#!/usr/bin/env python3
"""FS-73 V2 (independent verifier): decide Θ for a lattice graph by branch and bound on RELATIONS, with an exact certificate.

The reformulation (derivation in data/fs73/records/verify-P3b-q167.md §2).  Let U⁺ = {u₁, …, u_N} be one unit vector from each
± pair.  If θ ∈ Θ, then x_u := θ(u) − ⌊θ(u)⌋ lies in [1/3, 2/3] for every u, and for every integer relation r (Σ r_u u = 0 in
ℤ⁴) the number r·x = θ(Σ r_u u) − r·⌊θ(U)⌋ is an INTEGER.  So

    Θ ≠ ∅  ⟹  some x ∈ B := [1/3, 2/3]^N has r·x ∈ ℤ for every relation r,

and conversely (R = the full relation lattice is a direct summand of ℤ^N, so integrality on a basis of R lets x be shifted by an
integer vector into the span of the θ-images).  No fundamental domain, no frame: the box B is the root.

Tree.  A branch on a relation r with range lo..hi has children, in order,
    low:   r·x ≤ lo − 1,      k:  r·x = k  (k = lo..hi),      high:  r·x ≥ hi + 1,
which cover every x with r·x ∈ ℤ.  A leaf carries multipliers λ on its path's constraints (λ ≥ 0 on inequalities, any sign on
equalities) whose combination w·x ⋈ ρ is violated everywhere on B:  min_{x∈B} w·x = Σ_u min(w_u/3, 2w_u/3) > ρ.

Floats (scipy's HiGHS) only PROPOSE; every multiplier written has been checked exactly by the same criterion the standalone
checker `fs73v2_check.py` applies.  A node whose LP point is integral on a basis of the relation lattice is a candidate point of
Θ; it is rationalised, checked exactly, and turned into θ.

Usage:  fs73v2_xbb.py d key out.json [--maxlen L] [--pool basis|short]
"""
from __future__ import annotations

import argparse
import copy
import itertools
import json
import math
import os
import subprocess
import sys
import time
from collections import defaultdict
from fractions import Fraction

import numpy as np
from scipy.optimize import linprog

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs73v2_units import analyse, solve  # noqa: E402

THIRD, TWOTHIRD = Fraction(1, 3), Fraction(2, 3)


# ---------------------------------------------------------------- relations

def kernel_basis(pos: list[tuple[int, ...]]) -> list[list[int]]:
    """LLL-reduced basis of the integer relation lattice {r : Σ r_u u = 0}, proposed by PARI and verified here."""
    N = len(pos)
    M = "[" + ";".join(",".join(str(pos[j][i]) for j in range(N)) for i in range(4)) + "]"
    gp = f"K = matkerint({M}); print(#K); for(j=1,#K, print(Vec(K[,j])))\n"
    out = subprocess.run(["gp", "-q", "-f"], input=gp, capture_output=True, text=True, check=True).stdout.split("\n")
    rels = [json.loads(l.replace(" ", "")) for l in out[1:] if l.strip()]
    assert len(rels) == int(out[0]) == N - 4, (len(rels), out[0])
    for r in rels:
        assert all(sum(r[j] * pos[j][i] for j in range(N)) == 0 for i in range(4))
    return rels


def short_relations(pos: list[tuple[int, ...]], maxlen: int) -> list[list[int]]:
    """Every relation that is a closed walk of length ≤ maxlen ≤ 6 (sum of ≤ maxlen signed unit vectors = 0), folded
    onto U⁺: meet in the middle over multisets of ≤ 3 signed unit vectors."""
    assert maxlen <= 6
    N = len(pos)
    signed = [(j, s) for j in range(N) for s in (1, -1)]
    sums = {}
    for t in range(1, (maxlen + 1) // 2 + 1):
        d = defaultdict(list)
        for ms in itertools.combinations_with_replacement(range(2 * N), t):
            v = [0, 0, 0, 0]
            c = [0] * N
            for k in ms:
                j, sg = signed[k]
                c[j] += sg
                for i in range(4):
                    v[i] += sg * pos[j][i]
            d[tuple(v)].append(tuple(c))
        sums[t] = d
    rels = set()
    for t1 in sums:
        for t2 in sums:
            if t1 > t2 or t1 + t2 > maxlen:
                continue
            for s, cs in sums[t1].items():
                neg = tuple(-x for x in s)
                for c1 in cs:
                    for c2 in sums[t2].get(neg, ()):
                        r = tuple(a + b for a, b in zip(c1, c2))
                        if any(r):
                            first = next(x for x in r if x)
                            if first < 0:
                                r = tuple(-x for x in r)
                            rels.add(r)
    out = sorted(rels, key=lambda r: (sum(map(abs, r)), r))
    for r in out:
        assert all(sum(r[j] * pos[j][i] for j in range(N)) == 0 for i in range(4))
    return [list(r) for r in out]


# ---------------------------------------------------------------- exact leaf test (same criterion as the checker)

def boxmin(w: list[Fraction]) -> Fraction:
    return sum((wu * THIRD if wu > 0 else wu * TWOTHIRD) for wu in w)


def leaf_ok(cons, lam: dict[int, Fraction], N: int) -> bool:
    w = [Fraction(0)] * N
    rho = Fraction(0)
    for i, l in lam.items():
        a, b, kind = cons[i]
        if kind == "le" and l < 0:
            return False
        for u, c in a:
            w[u] += l * c
        rho += l * b
    return boxmin(w) > rho


# ---------------------------------------------------------------- search

class Found(Exception):
    def __init__(self, x):
        super().__init__("point")
        self.x = x


class Search:
    def __init__(self, pos, basis, pool, log_every=500, cover_through_points=False):
        self.cover_through_points = cover_through_points
        self.points = []
        self.last_leaf = None
        self.pos, self.N = pos, len(pos)
        self.basis = basis
        self.pool = pool                      # list of relations (lists); basis relations are in it
        self.poolf = np.array(pool, float)
        self.basisf = np.array(basis, float)
        self.n_nodes = self.n_leaves = self.n_lp = self.n_bad_farkas = 0
        self.t0 = time.time()
        self.log_every = log_every

    def _mats(self, cons):
        Aeq, beq, Aub, bub = [], [], [], []
        for a, b, kind in cons:
            row = np.zeros(self.N)
            for u, c in a:
                row[u] = float(c)
            if kind == "eq":
                Aeq.append(row)
                beq.append(float(b))
            else:
                Aub.append(row)
                bub.append(float(b))
        return Aeq, beq, Aub, bub

    def lp(self, cons, obj):
        Aeq, beq, Aub, bub = self._mats(cons)
        self.n_lp += 1
        return linprog(obj, A_ub=np.array(Aub) if Aub else None, b_ub=np.array(bub) if bub else None,
                       A_eq=np.array(Aeq) if Aeq else None, b_eq=np.array(beq) if beq else None,
                       bounds=[(1 / 3, 2 / 3)] * self.N, method="highs")

    def elastic(self, cons):
        """min total violation; returns (value, x, multipliers-per-constraint as floats)."""
        N, m = self.N, len(cons)
        # variables: x (N), then per constraint: eq -> s+, s- ; le -> s
        cols = N
        slack_idx = []
        for _, _, kind in cons:
            if kind == "eq":
                slack_idx.append((cols, cols + 1))
                cols += 2
            else:
                slack_idx.append((cols,))
                cols += 1
        c = np.zeros(cols)
        c[N:] = 1.0
        Aeq, beq, Aub, bub, order = [], [], [], [], []
        for i, (a, b, kind) in enumerate(cons):
            row = np.zeros(cols)
            for u, co in a:
                row[u] = float(co)
            if kind == "eq":
                row[slack_idx[i][0]] = -1.0
                row[slack_idx[i][1]] = 1.0
                Aeq.append(row)
                beq.append(float(b))
                order.append(("eq", len(Aeq) - 1))
            else:
                row[slack_idx[i][0]] = -1.0
                Aub.append(row)
                bub.append(float(b))
                order.append(("le", len(Aub) - 1))
        bounds = [(1 / 3, 2 / 3)] * N + [(0, None)] * (cols - N)
        self.n_lp += 1
        res = linprog(c, A_ub=np.array(Aub) if Aub else None, b_ub=np.array(bub) if bub else None,
                      A_eq=np.array(Aeq) if Aeq else None, b_eq=np.array(beq) if beq else None,
                      bounds=bounds, method="highs")
        assert res.status == 0, res.message
        mult = []
        for kind, k in order:
            mult.append(res.eqlin.marginals[k] if kind == "eq" else res.ineqlin.marginals[k])
        return res.fun, res.x[:N], mult

    def farkas(self, cons, mult):
        for sign in (-1.0, 1.0):
            for den in (10 ** 3, 10 ** 6, 10 ** 9, 10 ** 12):
                lam = {}
                for i, v in enumerate(mult):
                    v = sign * v
                    if abs(v) < 1e-10:
                        continue
                    f = Fraction(v).limit_denominator(den)
                    if cons[i][2] == "le" and f < 0:
                        f = Fraction(0)
                    if f != 0:
                        lam[i] = f
                if lam and leaf_ok(cons, lam, self.N):
                    return lam
        return None

    def _is_point(self, xr):
        return all(THIRD <= v <= TWOTHIRD for v in xr) and \
            all(sum(Fraction(c) * v for c, v in zip(r, xr) if c).denominator == 1 for r in self.basis)

    def candidate_point(self, x, cons=()):
        for den in (6, 12, 60, 10 ** 3, 10 ** 6, 10 ** 9):
            xr = [Fraction(float(v)).limit_denominator(den) for v in x]
            if self._is_point(xr):
                return xr
        # exact repair: tight box coordinates pinned, the path's equalities solved exactly for pivot coordinates, the
        # rest rounded from the float point
        N = self.N
        rows = []
        for u in range(N):
            if abs(x[u] - 1 / 3) < 1e-9:
                rows.append(({u: Fraction(1)}, THIRD))
            elif abs(x[u] - 2 / 3) < 1e-9:
                rows.append(({u: Fraction(1)}, TWOTHIRD))
        for r in self.basis:
            val = round(float(np.dot(r, x)))
            rows.append(({u: Fraction(c) for u, c in enumerate(r) if c}, Fraction(val)))
        M = [[row.get(u, Fraction(0)) for u in range(N)] + [b] for row, b in rows]
        piv = []
        rk = 0
        for col in range(N):
            p = next((i for i in range(rk, len(M)) if M[i][col] != 0), None)
            if p is None:
                continue
            M[rk], M[p] = M[p], M[rk]
            pv = M[rk][col]
            M[rk] = [v / pv for v in M[rk]]
            for i in range(len(M)):
                if i != rk and M[i][col] != 0:
                    f = M[i][col]
                    M[i] = [a - f * b for a, b in zip(M[i], M[rk])]
            piv.append(col)
            rk += 1
        if any(M[i][N] != 0 for i in range(rk, len(M))):
            return None
        for den in (10 ** 3, 10 ** 6, 10 ** 9):
            xr = [Fraction(float(v)).limit_denominator(den) for v in x]
            for i, col in enumerate(piv):
                xr[col] = M[i][N] - sum(M[i][j] * xr[j] for j in range(N) if j not in piv and M[i][j] != 0)
            if self._is_point(xr):
                return xr
        return None

    def node(self, cons, fixed: set, depth: int):
        self.n_nodes += 1
        if self.n_nodes % self.log_every == 0:
            print(f"  nodes {self.n_nodes} leaves {self.n_leaves} lp {self.n_lp} depth {depth} "
                  f"{time.time() - self.t0:.0f}s", flush=True)
        viol, x, mult = self.elastic(cons)
        if viol > 1e-9:
            lam = self.farkas(cons, mult)
            if lam is not None:
                self.n_leaves += 1
                self.last_leaf = [[i, l.numerator, l.denominator] for i, l in sorted(lam.items())]
                return ["F", self.last_leaf]
            self.n_bad_farkas += 1
            raise RuntimeError(f"infeasible node (violation {viol}) without an exact Farkas certificate")
        vals = self.poolf @ x
        frac = np.abs(vals - np.round(vals))
        bvals = self.basisf @ x
        if viol <= 1e-9 and np.all(np.abs(bvals - np.round(bvals)) < 1e-7):
            xr = self.candidate_point(x)
            if xr is not None:
                if not self.cover_through_points:
                    raise Found(xr)
                # PLANT MODE: a genuine point lies in this region; write a bogus leaf (the previous valid leaf's
                # multipliers) so that the standalone checker's rejection of it can be observed
                self.points.append(xr)
                return ["F", copy.deepcopy(self.last_leaf) if self.last_leaf else []]
        # branch: the shortest pool relation, not yet branched on this path, whose LP value is fractional
        best = None
        for idx in range(len(self.pool)):
            if idx in fixed:
                continue
            if frac[idx] > 1e-7:
                best = idx
                break
        if best is None:
            best = next((idx for idx in range(len(self.pool)) if idx not in fixed), None)
        if best is None:
            if self.cover_through_points:
                self.points.append(None)
                return ["F", copy.deepcopy(self.last_leaf) if self.last_leaf else []]
            raise RuntimeError("every relation fixed, LP feasible, and no exact point: investigate")
        r = self.pool[best]
        rf = self.poolf[best]
        r1 = self.lp(cons, rf)
        r2 = self.lp(cons, -rf)
        if r1.status != 0 or r2.status != 0:
            lo = math.ceil(vals[best] - 1e-9)
            hi = lo - 1
        else:
            lo = math.ceil(r1.fun - 1e-7)
            hi = math.floor(-r2.fun + 1e-7)
        a = [(u, c) for u, c in enumerate(r) if c]
        neg = [(u, -c) for u, c in a]
        kids = [self.node(cons + [(a, Fraction(lo - 1), "le")], fixed | {best}, depth + 1)]
        for k in range(lo, hi + 1):
            kids.append(self.node(cons + [(a, Fraction(k), "eq")], fixed | {best}, depth + 1))
        kids.append(self.node(cons + [(neg, Fraction(-(hi + 1)), "le")], fixed | {best}, depth + 1))
        return ["B", best, lo, hi, kids]


def theta_from_x(pos, basis, xr):
    """Integer n with r·n = −r·x for every basis relation, then θ with θ(u) = x_u + n_u (checked for every u)."""
    N = len(pos)
    K = "[" + ";".join(",".join(str(basis[k][j]) for j in range(N)) for k in range(len(basis))) + "]"  # rows = relations
    rhs = "[" + ",".join(str(-sum(Fraction(c) * v for c, v in zip(r, xr))) for r in basis) + "]~"
    gp = f"n = matsolvemod({K}, 0, {rhs}); print(n)\n"
    out = subprocess.run(["gp", "-q", "-f"], input=gp, capture_output=True, text=True, check=True).stdout.strip()
    n = [int(v) for v in out.strip("[]~ ").replace(" ", "").split(",")]
    target = [xr[j] + n[j] for j in range(N)]
    # θ as a vector in (a, b, c, e)-dual coordinates: solve on four independent columns, then check all
    for quad in itertools.combinations(range(N), 4):
        A = [list(pos[i]) for i in quad]
        try:
            # θ·u_i = target_i for i in quad:  A θ = t  →  θ = solve(Aᵀ-rows...)
            th = solve([[A[i][k] for i in range(4)] for k in range(4)], [target[i] for i in quad])
        except StopIteration:
            continue
        if all(sum(th[k] * pos[j][k] for k in range(4)) == target[j] for j in range(N)):
            return th, n
    raise RuntimeError("no consistent θ")


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("d", type=int)
    ap.add_argument("key")
    ap.add_argument("out")
    ap.add_argument("--maxlen", type=int, default=6)
    ap.add_argument("--log-every", type=int, default=500)
    ap.add_argument("--cover-through-points", action="store_true",
                    help="PLANT MODE: keep covering past points of Θ, writing a bogus leaf at each (the checker must FAIL)")
    a = ap.parse_args()
    t0 = time.time()
    info = analyse(a.d, a.key, want_unit_basis=False)
    pos = [tuple(u) for u in info["pos"]]
    basis = kernel_basis(pos)
    short = short_relations(pos, a.maxlen) if a.maxlen > 0 else []
    pool = []
    seen = set()
    for r in short + sorted(basis, key=lambda r: sum(map(abs, r))):
        t = tuple(r)
        if t not in seen and tuple(-x for x in r) not in seen:
            seen.add(t)
            pool.append(list(r))
    pool.sort(key=lambda r: sum(map(abs, r)))
    print(f"N = {len(pos)} pairs; basis {len(basis)}; short relations (len ≤ {a.maxlen}) {len(short)}; pool {len(pool)}; "
          f"{time.time() - t0:.1f}s", flush=True)
    S = Search(pos, basis, pool, a.log_every, a.cover_through_points)
    sys.setrecursionlimit(10000)
    try:
        tree = S.node([], frozenset(), 0)
    except Found as f:
        xr = f.x
        th, n = theta_from_x(pos, basis, xr)
        vals = [sum(th[k] * u[k] for k in range(4)) for u in pos]
        ok = all(THIRD <= v - math.floor(v) <= TWOTHIRD for v in vals)
        res = {"verdict": "NONEMPTY", "d": a.d, "key": a.key, "units": [list(u) for u in pos],
               "x": [[v.numerator, v.denominator] for v in xr],
               "theta_abce_dual": [[v.numerator, v.denominator] for v in th], "exact_check": ok,
               "stats": {"nodes": S.n_nodes, "lp": S.n_lp, "wall_s": round(time.time() - t0, 1)}}
        with open(a.out, "w") as fh:
            json.dump(res, fh)
        print(f"NONEMPTY: θ = {[str(v) for v in th]}; exact check {ok}; nodes {S.n_nodes}", flush=True)
        return
    if S.points:
        print(f"PLANT MODE: {len(S.points)} genuine points of Θ covered by bogus leaves; first x = "
              f"{[str(v) for v in S.points[0]]}", flush=True)
    res = {"verdict": "EMPTY", "d": a.d, "key": a.key, "units": [list(u) for u in pos], "relations": pool, "tree": tree,
           "stats": {"nodes": S.n_nodes, "leaves": S.n_leaves, "lp": S.n_lp, "bad_farkas": S.n_bad_farkas,
                     "wall_s": round(time.time() - t0, 1)}}
    with open(a.out, "w") as fh:
        json.dump(res, fh, separators=(",", ":"))
    print("EMPTY; stats", res["stats"], flush=True)


if __name__ == "__main__":
    main()
