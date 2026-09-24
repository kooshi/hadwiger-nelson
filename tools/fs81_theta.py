#!/usr/bin/env python3
"""FS-81 phase 0: exact three-colour (Θ₃) trees on EXPLICITLY LISTED unit vectors of ℚ(√d)², checkpointed and resumable.

Untrusted, like everything in `tools/`: every verdict it writes is re-checked by a frozen checker (`tools/fs73v2_check.py`) or by
`tools/fs81_theta_check.py`, which import nothing from here.

The decision procedure is V2's relation tree (`tools/fs73v2_xbb.py`, derivation in `data/fs73/records/verify-P3b-q167.md` §2):
Θ ≠ ∅ iff some x ∈ [1/3, 2/3]^N has r·x ∈ ℤ for every integer relation r of the listed vectors.  What is new here:

  * the unit vectors are LISTED (a configuration such as {1, v, v̄}·U^(5)), never enumerated from a key, so a key denominator of
    10⁶ costs nothing; the key written into the certificate is the Hermite basis of the listed vectors' span;
  * the depth-first search is ITERATIVE, and its whole state (the stack of branch nodes under construction, with every finished
    child) is saved atomically every `--ckpt-s` seconds; a relaunch of the same command resumes from it and redoes at most the
    nodes since the last save;
  * a cumulative wall cap (`--cap-s`) turns a tree that does not finish into an UNDECIDED record with its node count.

Configurations: an element of ℚ(√d)(i) is (a, b, c, e) with Fractions, meaning (a + b√d) + i(c + e√d).  U^(5^K) is the set of
rational unit vectors (p + iq)/5^K, p² + q² = 25^K.  A configuration {b₁, …, b_m}·U^(5^K) is the set of products, one per ± pair.

Usage:
  fs81_theta.py tree  D UNITS.json OUT.json [--ckpt STATE.json] [--cap-s 1800] [--ckpt-s 60]
  fs81_theta.py show-config d NAME [K]         (print the configuration's units and key)
"""
from __future__ import annotations

import argparse
import json
import math
import os
import sys
import time
from fractions import Fraction as F

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs73v2_xbb as X                                        # noqa: E402  (relations, LPs, Farkas rounding, θ recovery)
from fs73v2_units import hnf                                  # noqa: E402

THIRD, TWOTHIRD = F(1, 3), F(2, 3)


# ================================================================ ℚ(√d)(i) arithmetic

def mul(d, x, y):
    a, b, c, e = x
    a2, b2, c2, e2 = y
    re = (a * a2 + d * b * b2 - c * c2 - d * e * e2, a * b2 + b * a2 - c * e2 - e * c2)
    im = (a * c2 + d * b * e2 + c * a2 + d * e * b2, a * e2 + b * c2 + c * b2 + e * a2)
    return (re[0], re[1], im[0], im[1])


def conj(x):
    """complex conjugation"""
    a, b, c, e = x
    return (a, b, -c, -e)


def norm2(d, x):
    """|x|² as (rational part, √d part)"""
    a, b, c, e = x
    return (a * a + d * b * b + c * c + d * e * e, 2 * (a * b + c * e))


def is_unit_elt(d, x):
    return norm2(d, x) == (1, 0)


def power(d, x, k):
    r = (F(1), F(0), F(0), F(0))
    base = x if k >= 0 else conj(x)
    for _ in range(abs(k)):
        r = mul(d, r, base)
    return r


def rational_units(K):
    """U^(5^K): (p + iq)/5^K with p² + q² = 25^K."""
    m = 5 ** K
    out = []
    for p in range(-m, m + 1):
        q2 = m * m - p * p
        q = math.isqrt(q2)
        if q * q == q2:
            for qq in {q, -q}:
                out.append((F(p, m), F(0), F(qq, m), F(0)))
    return sorted(set(out))


def v_rot(d):
    """G7's type-M rotation v = ((2n−1) + i√d)/(2n), n = (d+1)/4."""
    assert d % 4 == 3
    n = (d + 1) // 4
    return (F(2 * n - 1, 2 * n), F(0), F(0), F(1, 2 * n))


def gauss_layers(d, p, count=3, cmax=10 ** 6):
    """The `count` smallest-c solutions (a, c), a > 0, of a² + d = p c² (p = 2 or 5 here)."""
    out = []
    for c in range(1, cmax):
        a2 = p * c * c - d
        if a2 <= 0:
            continue
        a = math.isqrt(a2)
        if a * a == a2:
            out.append((a, c))
            if len(out) == count:
                break
    return out


def z_layer(d, p, a, c, sign):
    """z = π(a − i·sign·√d)/(p c), π = 1+i (p = 2) or 2+i (p = 5), with a² + d = p c²; |z| = 1.
    T40–T41's z over ℚ(√167) is p = 2, (a, c) = (15, 14), sign = +1: (1+i)(15 − i√167)/28."""
    assert a * a + d == p * c * c
    pi = {2: (F(1), F(0), F(1), F(0)), 5: (F(2), F(0), F(1), F(0))}[p]
    w = (F(a, p * c), F(0), F(0), F(-sign, p * c))      # (a − i·sign·√d)/(p c)
    z = mul(d, pi, w)
    assert is_unit_elt(d, z), (d, p, z)
    return z


def config_names(d, count=2):
    """Every configuration of P0.2 that exists at d: A, B, then C and D at the `count` smallest (a, c), both signs."""
    names = ["A", "B"]
    for p, tag in ((2, "C"), (5, "D")):
        for a, c in gauss_layers(d, p, count):
            names += [f"{tag}:{a}:{c}:+", f"{tag}:{a}:{c}:-"]
    return names


def configuration(d, name, K=1):
    """The layer set of a named configuration; its units are layers·U^(5^K).
    A = {1, v, v̄};  B = {v^k : |k| ≤ 2};  C:a:c:s = {1, v, z} with z at p = 2 (T41's shape);  D:a:c:s = {1, v, z₅} (p = 5);
    E:a:c = {1, v, v̄, z, z̄} at p = 2 (L21cc6506's five layers)."""
    if name.startswith("conj|"):                       # complex conjugation of every layer (an isometry: Θ equivariant)
        return [conj(b) for b in configuration(d, name[5:], K)]
    if name.startswith("gal|"):                        # √d ↦ −√d on every layer (additive, preserves the unit set)
        return [(a, -b, c, -e) for a, b, c, e in configuration(d, name[4:], K)]
    v = v_rot(d)
    one = (F(1), F(0), F(0), F(0))
    if name == "A":
        return [one, v, conj(v)]
    if name == "B":
        return [power(d, v, k) for k in range(-2, 3)]
    tag, *rest = name.split(":")
    if tag in ("C", "D"):
        a, c, s = int(rest[0]), int(rest[1]), rest[2]
        return [one, v, z_layer(d, 2 if tag == "C" else 5, a, c, +1 if s == "+" else -1)]
    if tag == "E":
        a, c = int(rest[0]), int(rest[1])
        z = z_layer(d, 2, a, c, +1)
        return [one, v, conj(v), z, conj(z)]
    raise ValueError(name)


def units_of(d, layers, K=1):
    """One representative (a, b, c, e) ∈ ℤ⁴ per ± pair of B·U^(5^K), at the least common denominator D."""
    U = rational_units(K)
    elts = set()
    for b in layers:
        for r in U:
            x = mul(d, b, r)
            assert is_unit_elt(d, x)
            elts.add(x)
    D = 1
    for x in elts:
        for t in x:
            D = D * t.denominator // math.gcd(D, t.denominator)
    vecs = set()
    for x in elts:
        u = tuple(int(t * D) for t in x)
        neg = tuple(-t for t in u)
        vecs.add(max(u, neg))
    return D, sorted(vecs)


def key_of(units, D):
    rows = hnf([list(u) for u in units])
    assert len(rows) == 4, f"the listed units span rank {len(rows)}, not 4"
    return f"{D}|" + ";".join(",".join(str(x) for x in r) for r in rows)


def check_units(d, D, units):
    for a, b, c, e in units:
        assert (a, b, c, e) != (0, 0, 0, 0) and a * a + d * b * b + c * c + d * e * e == D * D and a * b + c * e == 0, \
            f"{(a, b, c, e)} is not a unit vector of Q(sqrt {d})^2 at denominator {D}"


# ================================================================ the checkpointed iterative tree

def child_constraint(r, lo, hi, j):
    a = [(u, c) for u, c in enumerate(r) if c]
    if j == 0:
        return (a, F(lo - 1), "le")
    if j == hi - lo + 2:
        return ([(u, -c) for u, c in a], F(-(hi + 1)), "le")
    return (a, F(lo + j - 1), "eq")


class Capped(Exception):
    pass


class IterSearch(X.Search):
    """V2's Search, driven iteratively with a saved stack.  eval_node returns a leaf, or a branch decision (best, lo, hi)."""

    def eval_node(self, cons, fixed, depth):
        self.n_nodes += 1
        viol, x, mult = self.elastic(cons)
        if viol > 1e-9:
            lam = self.farkas(cons, mult)
            if lam is None:
                self.n_bad_farkas += 1
                raise RuntimeError(f"infeasible node (violation {viol}) without an exact Farkas certificate")
            self.n_leaves += 1
            return ("leaf", ["F", [[i, l.numerator, l.denominator] for i, l in sorted(lam.items())]])
        vals = self.poolf @ x
        frac = abs(vals - vals.round())
        bvals = self.basisf @ x
        if (abs(bvals - bvals.round()) < 1e-7).all():
            xr = self.candidate_point(x)
            if xr is not None:
                raise X.Found(xr)
        best = next((i for i in range(len(self.pool)) if i not in fixed and frac[i] > 1e-7), None)
        if best is None:
            best = next((i for i in range(len(self.pool)) if i not in fixed), None)
        if best is None:
            raise RuntimeError("every relation fixed, LP feasible, and no exact point: investigate")
        rf = self.poolf[best]
        r1 = self.lp(cons, rf)
        r2 = self.lp(cons, -rf)
        if r1.status != 0 or r2.status != 0:
            lo = math.ceil(vals[best] - 1e-9)
            hi = lo - 1
        else:
            lo = math.ceil(r1.fun - 1e-7)
            hi = math.floor(-r2.fun + 1e-7)
        return ("branch", (best, lo, hi))

    def run(self, stack, tree, ckpt_path, ckpt_s, cap_s, elapsed0):
        """stack: [[best, lo, hi, kids]] root first.  Returns the finished tree; raises Capped."""
        t_start = time.time()
        last = t_start

        def path_cons():
            cons, fixed = [], frozenset()
            for best, lo, hi, kids in stack:
                cons = cons + [child_constraint(self.pool[best], lo, hi, len(kids))]
                fixed = fixed | {best}
            return cons, fixed

        def save():
            if ckpt_path:
                state = {"stack": stack, "stats": self.stats(), "elapsed": elapsed0 + time.time() - t_start}
                tmp = ckpt_path + ".tmp"
                with open(tmp, "w") as fh:
                    json.dump(state, fh, separators=(",", ":"))
                    fh.flush()
                    os.fsync(fh.fileno())
                os.replace(tmp, ckpt_path)

        if tree is None and not stack:
            kind, val = self.eval_node([], frozenset(), 0)
            if kind == "leaf":
                return val
            stack.append([val[0], val[1], val[2], []])
        while stack:
            now = time.time()
            if now - last >= ckpt_s:
                save()
                last = now
            if elapsed0 + now - t_start > cap_s:
                save()
                raise Capped()
            best, lo, hi, kids = stack[-1]
            if len(kids) == hi - lo + 3:
                stack.pop()
                node = ["B", best, lo, hi, kids]
                if stack:
                    stack[-1][3].append(node)
                    continue
                return node
            cons, fixed = path_cons()
            kind, val = self.eval_node(cons, fixed, len(stack))
            if kind == "leaf":
                kids.append(val)
            else:
                stack.append([val[0], val[1], val[2], []])
        raise AssertionError("unreachable")

    def stats(self):
        return {"nodes": self.n_nodes, "leaves": self.n_leaves, "lp": self.n_lp, "bad_farkas": self.n_bad_farkas}


def kernel_basis(pos):
    """V2's relation basis (`fs73v2_xbb.kernel_basis`: PARI's matkerint, verified here), with a 2 GB PARI stack: the default
    8 MB overflows at about 160 pairs (the saturation of B over ℚ(√59) stopped P0.2's group 5)."""
    import subprocess
    N = len(pos)
    M = "[" + ";".join(",".join(str(pos[j][i]) for j in range(N)) for i in range(4)) + "]"
    gp = f"K = matkerint({M}); print(#K); for(j=1,#K, print(Vec(K[,j])))\n"
    r = subprocess.run(["gp", "-q", "-f", "-s", "2G"], input=gp, capture_output=True, text=True, check=True)
    if r.stderr.strip():
        raise RuntimeError(f"gp: {r.stderr.strip()[:300]}")
    out = r.stdout.split("\n")
    rels = [json.loads(l.replace(" ", "")) for l in out[1:] if l.strip()]
    assert len(rels) == int(out[0]) == N - 4, (len(rels), out[0])
    for rr in rels:
        assert all(sum(rr[j] * pos[j][i] for j in range(N)) == 0 for i in range(4))
    return rels


def small_order_point(units, screen=(3, 6, 9, 12), chunk=200000):
    """A point θ of Θ of order dividing m, for m in `screen`: θ(b_j) = t_j/m on the Hermite basis b of span U, t ∈ (ℤ/m)⁴,
    tested on every listed unit at once (numpy, exact integers).  Returns (m, θ in (a,b,c,e)-dual coordinates) or None.
    A finder only: its θ is re-checked exactly here and by the checkers."""
    import itertools
    import numpy as np
    from fs73v2_units import solve
    B = hnf([list(u) for u in units])
    L = math.lcm(*screen)
    # integer coordinates in the Hermite basis, reduced mod lcm(screen) (only their residues matter; unreduced they can
    # exceed int64 — the defect that stopped P0.2's first launch at d = 83)
    C = np.array([[int(t) % L for t in solve(B, list(u))] for u in units], dtype=np.int64)
    for m in screen:
        grid = np.array(list(itertools.product(range(m), repeat=4)), dtype=np.int64)
        for k in range(0, len(grid), chunk):
            T = grid[k:k + chunk]
            V = (C @ T.T) % m                                                          # N × chunk
            ok = ((3 * V >= m) & (3 * V <= 2 * m)).all(axis=0)
            hit = np.nonzero(ok)[0]
            if len(hit):
                t = [F(int(x), m) for x in T[hit[0]]]
                # θ on ℚ⁴ with θ(b_j) = t_j: solve Bᵀ-system  Σ_k θ_k B[j][k] = t_j
                th = solve([[B[j][k] for j in range(4)] for k in range(4)], t)
                vals = [sum(th[k] * u[k] for k in range(4)) for u in units]
                assert all(THIRD <= v - math.floor(v) <= TWOTHIRD for v in vals)
                return m, th
    return None


def decide(d, D, units, out_path, ckpt_path=None, cap_s=1800.0, ckpt_s=60.0, maxlen=6, log=print, screen=()):
    """Decide Θ for Cay(span U, ±U).  Returns a result dict (also written to out_path unless UNDECIDED)."""
    t0 = time.time()
    units = [tuple(u) for u in units]
    check_units(d, D, units)
    key = key_of(units, D)
    if screen:
        hit = small_order_point(units, screen)
        if hit is not None:
            m, th = hit
            res = {"d": d, "key": key, "units": [list(u) for u in units], "N": len(units), "verdict": "NONEMPTY",
                   "finder": f"small-order screen, order {m}", "theta_abce_dual": [[v.numerator, v.denominator] for v in th],
                   "exact_check": True, "stats": {"nodes": 0, "wall_s": round(time.time() - t0, 1)}}
            with open(out_path, "w") as fh:
                json.dump(res, fh)
            return res
    state = None
    if ckpt_path and os.path.exists(ckpt_path):
        state = json.load(open(ckpt_path))
        if state.get("d") != d or state.get("units") != [list(u) for u in units]:
            raise SystemExit(f"checkpoint {ckpt_path} is for another problem; refusing to resume")
    if state and "pool" in state:
        basis, pool = state["basis"], state["pool"]
    else:
        basis = kernel_basis(units)
        # short relations cost (2N)^3/6 multisets, each carrying an N-vector: cap the length as N grows (the pool is only
        # a branching order; the relation basis alone keeps the tree complete)
        maxlen = maxlen if len(units) <= 60 else (4 if len(units) <= 120 else 0)
        short = X.short_relations(units, maxlen) if maxlen > 0 else []
        pool, seen = [], set()
        for r in short + sorted(basis, key=lambda r: sum(map(abs, r))):
            t = tuple(r)
            if t not in seen and tuple(-x for x in r) not in seen:
                seen.add(t)
                pool.append(list(r))
        pool.sort(key=lambda r: sum(map(abs, r)))
        if ckpt_path:
            state = {"d": d, "D": D, "units": [list(u) for u in units], "basis": basis, "pool": pool,
                     "stack": [], "stats": {}, "elapsed": 0.0}
            with open(ckpt_path + ".tmp", "w") as fh:
                json.dump(state, fh, separators=(",", ":"))
                fh.flush()
                os.fsync(fh.fileno())
            os.replace(ckpt_path + ".tmp", ckpt_path)
    S = IterSearch(units, basis, pool, log_every=10 ** 9)
    stack, elapsed0 = [], 0.0
    dyn = (ckpt_path + ".stack") if ckpt_path else None
    if dyn and os.path.exists(dyn):                  # the dynamic part: the stack of branch nodes under construction
        st = json.load(open(dyn))
        stack, elapsed0 = st["stack"], st["elapsed"]
        S.n_nodes, S.n_leaves, S.n_lp, S.n_bad_farkas = (st["stats"][k] for k in ("nodes", "leaves", "lp", "bad_farkas"))
        log(f"resumed: {S.n_nodes} nodes, {elapsed0:.0f} s, stack depth {len(stack)}")

    def run():
        return S.run(stack, None, ckpt_path + ".stack" if ckpt_path else None, ckpt_s, cap_s, elapsed0)

    base = {"d": d, "key": key, "units": [list(u) for u in units], "N": len(units), "pool": len(pool)}
    try:
        tree = run()
    except X.Found as f:
        th, n = X.theta_from_x(units, basis, f.x)
        vals = [sum(th[k] * u[k] for k in range(4)) for u in units]
        ok = all(THIRD <= v - math.floor(v) <= TWOTHIRD for v in vals)
        res = dict(base, verdict="NONEMPTY", finder="relation tree", x=[[v.numerator, v.denominator] for v in f.x],
                   theta_abce_dual=[[v.numerator, v.denominator] for v in th], exact_check=ok,
                   stats=dict(S.stats(), wall_s=round(elapsed0 + time.time() - t0, 1)))
        with open(out_path, "w") as fh:
            json.dump(res, fh)
        _cleanup(ckpt_path)
        return res
    except Capped:
        return dict(base, verdict="UNDECIDED", stats=dict(S.stats(), wall_s=round(elapsed0 + time.time() - t0, 1)),
                    cap_s=cap_s)
    res = dict(base, verdict="EMPTY", finder="relation tree", relations=pool, tree=tree,
               stats=dict(S.stats(), wall_s=round(elapsed0 + time.time() - t0, 1)))
    with open(out_path, "w") as fh:
        json.dump(res, fh, separators=(",", ":"))
    _cleanup(ckpt_path)
    return res


def _cleanup(ckpt_path):
    for p in (ckpt_path, (ckpt_path or "") + ".stack"):
        if p and os.path.exists(p):
            os.remove(p)


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    t = sub.add_parser("tree")
    t.add_argument("d", type=int)
    t.add_argument("units")
    t.add_argument("out")
    t.add_argument("--D", type=int, required=True)
    t.add_argument("--ckpt", default=None)
    t.add_argument("--cap-s", type=float, default=1800.0)
    t.add_argument("--ckpt-s", type=float, default=60.0)
    s = sub.add_parser("show-config")
    s.add_argument("d", type=int)
    s.add_argument("name")
    s.add_argument("K", type=int, nargs="?", default=1)
    a = ap.parse_args()
    if a.cmd == "tree":
        units = json.load(open(a.units))
        r = decide(a.d, a.D, units, a.out, a.ckpt, a.cap_s, a.ckpt_s)
        print(r["verdict"], r["stats"])
    else:
        layers = configuration(a.d, a.name, a.K)
        D, units = units_of(a.d, layers, a.K)
        print(json.dumps({"d": a.d, "config": a.name, "K": a.K, "D": D, "N": len(units), "key": key_of(units, D),
                          "units": units}))


if __name__ == "__main__":
    main()
