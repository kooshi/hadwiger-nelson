#!/usr/bin/env python3
"""Build a core-and-spindle unit-distance graph and a certified fractional lower bound.

**Untrusted generator.** Lean re-derives every claim: the geometry by kernel reduction of
`UDCert.Valid`, and the weight bound by kernel reduction of `noHeavy`. A bug in this file can only
produce data Lean refuses to certify.

## The construction, which is the point

Fisher and Ullman's, as Cranston and Rabern describe it (arXiv:1501.01647 §2), rebuilt from the
description rather than from anyone's coordinates:

1. **Core** — a trapezoidal patch of the unit triangular lattice, rows given by `--rows`.
2. A **diamond** is two core points at distance √3 together with their two common neighbours.
3. To each diamond, attach a **Moser spindle**: rotate the diamond about its lower point by the
   angle with `cos θ = 5/6`, `sin θ = √11/6` — exactly the angle carrying the two far tips to
   distance 1 — and keep the three new points.
4. Join **every** pair at distance exactly 1.

All arithmetic is exact in ℚ(√3, √11), a subfield of the `ℚ(√3,√5,√7,√11)` tower the project
already carries, so "distance = 1" is an integer identity and never a float comparison.

## The bound

`χ_f(G) ≥ (Σ w) / D` whenever no independent set of `G` weighs more than `D`. The weights come
from the dual linear program, solved by constraint generation with an **exact** separation oracle:
at each round `cadical` is asked whether any independent set exceeds the current bound, through a
weighted sequential counter. The answer is then re-checked here by an independent branch-and-bound
before anything is written.

Usage:
    python3 tools/corespindle.py --rows 6 5 4 --out tools/corespindle63.json \\
        --lean Proofs/HadwigerNelson/Instances/CoreSpindle/Weights.lean
"""

import argparse
import json
import random
import subprocess
import sys
from fractions import Fraction as F
from math import gcd, lcm
from pathlib import Path

PRIMES = [3, 5, 7, 11]                 # bit k of a coefficient index ↔ √PRIMES[k]
NSLOT = 1 << len(PRIMES)
# ℚ(√3,√11) as 4-tuples over the basis (1, √3, √11, √33); the tower slots they occupy.
SLOT = [0, 1, 8, 9]


# ---------------------------------------------------------------- exact ℚ(√3,√11)

def add(u, v): return tuple(x + y for x, y in zip(u, v))
def sub(u, v): return tuple(x - y for x, y in zip(u, v))
def smul(s, u): return tuple(s * x for x in u)


def mul(u, v):
    a, b, c, d = u
    e, f, g, h = v
    return (a * e + 3 * b * f + 11 * c * g + 33 * d * h,
            a * f + b * e + 11 * (c * h + d * g),
            a * g + c * e + 3 * (b * h + d * f),
            a * h + d * e + b * g + c * f)


def q(x): return (F(x), F(0), F(0), F(0))


R3 = (F(0), F(1), F(0), F(0))
ONE = q(1)
THREE = q(3)


def distSq(p, r):
    dx, dy = sub(p[0], r[0]), sub(p[1], r[1])
    return add(mul(dx, dx), mul(dy, dy))


# ---------------------------------------------------------------- the construction

def trapezoid(rows):
    """Row `j` has `rows[j]` lattice points, offset by `j/2` as the triangular lattice requires."""
    pts = []
    for j, cnt in enumerate(rows):
        for i in range(cnt):
            pts.append((add(q(i), smul(F(1, 2), q(j))), smul(F(j, 2), R3)))
    return pts


def spin(p, centre):
    """Rotate `p` about `centre` by the angle with cos = 5/6, sin = √11/6."""
    vx, vy = sub(p[0], centre[0]), sub(p[1], centre[1])
    s = (F(0), F(0), F(1, 6), F(0))                       # √11/6
    c = q(F(5, 6))
    return (add(sub(mul(c, vx), mul(s, vy)), centre[0]),
            add(add(mul(s, vx), mul(c, vy)), centre[1]))


def build(rows):
    core = trapezoid(rows)
    seen = {p: i for i, p in enumerate(core)}
    pts = list(core)
    diamonds = 0
    for i in range(len(core)):
        for j in range(i + 1, len(core)):
            if distSq(core[i], core[j]) != THREE:
                continue
            flank = [k for k in range(len(core))
                     if distSq(core[k], core[i]) == ONE and distSq(core[k], core[j]) == ONE]
            if len(flank) != 2:
                continue                                   # a boundary pair, not a full diamond
            diamonds += 1
            for p in [core[j]] + [core[k] for k in flank]:
                r = spin(p, core[i])
                if r not in seen:
                    seen[r] = len(pts)
                    pts.append(r)
    n = len(pts)
    edges = [(i, j) for i in range(n) for j in range(i + 1, n) if distSq(pts[i], pts[j]) == ONE]
    return pts, len(core), diamonds, edges


# ---------------------------------------------------------------- the dual, and its oracle

def cadical():
    prefix = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True,
                            cwd=Path(__file__).resolve().parent.parent).stdout.strip()
    return str(Path(prefix) / "bin" / "cadical")


def heavier_than(n, edges, w, D, tmp):
    """Ask cadical for an independent set of weight ≥ D+1. Returns the set, or None."""
    T = D + 1
    cls = [[-(a + 1), -(b + 1)] for a, b in edges]
    S, nv = {}, n
    for i in range(1, n + 1):
        for j in range(1, T + 1):
            nv += 1
            S[(i, j)] = nv
    for i in range(1, n + 1):
        for j in range(1, T + 1):
            base, p = [-S[(i, j)]], S.get((i - 1, j))
            cls.append(base + ([p] if p else []) + [i])
            k = j - w[i - 1]
            if k >= 1:
                qq = S.get((i - 1, k))
                cls.append(base + ([p] if p else []) + ([qq] if qq else []))
    cls.append([S[(n, T)]])
    tmp.write_text(f"p cnf {nv} {len(cls)}\n" + "".join(" ".join(map(str, c)) + " 0\n" for c in cls))
    r = subprocess.run([cadical(), "-q", str(tmp)], capture_output=True, text=True)
    if "s UNSATISFIABLE" in r.stdout:
        return None
    if "s SATISFIABLE" not in r.stdout:
        raise RuntimeError(r.stdout[:400] + r.stderr[:400])
    lits = [int(x) for line in r.stdout.splitlines() if line.startswith("v ")
            for x in line[2:].split()]
    return {l - 1 for l in lits if 0 < l <= n}


def max_weight(n, edges, w):
    """Exact maximum weight of an independent set, by branch and bound. Independent of cadical,
    and the check that decides whether anything is written."""
    nbr = [0] * n
    for a, b in edges:
        nbr[a] |= 1 << b
        nbr[b] |= 1 << a
    order = sorted(range(n), key=lambda v: (-w[v], v))
    pos = {v: i for i, v in enumerate(order)}
    ww = [w[v] for v in order]
    nb = [0] * n
    for a, b in edges:
        nb[pos[a]] |= 1 << pos[b]
        nb[pos[b]] |= 1 << pos[a]
    suf = [0] * (n + 1)
    for i in range(n - 1, -1, -1):
        suf[i] = suf[i + 1] + ww[i]
    best = [0]
    nodes = [0]
    sys.setrecursionlimit(100000)

    def rec(i, chosen, wt):
        nodes[0] += 1
        if wt > best[0]:
            best[0] = wt
        for u in range(i, n):
            if wt + suf[u] <= best[0]:
                break
            if nb[u] & chosen:
                continue
            rec(u + 1, chosen | (1 << u), wt + ww[u])
    rec(0, 0, 0)
    return best[0], nodes[0], order


def dual(n, edges, seed=11, rounds=200, pool_size=8000, fine=5040):
    import numpy as np
    from scipy.optimize import linprog
    adj = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    rng = random.Random(seed)
    tmp = Path(__file__).resolve().parent / ".corespindle.cnf"

    def pool(y, k):
        out = []
        for _ in range(k):
            order = sorted(range(n), key=lambda v: -(y[v] + rng.random() * 0.35))
            S, blocked = set(), set()
            for v in order:
                if v in blocked:
                    continue
                S.add(v)
                blocked.add(v)
                blocked |= adj[v]
            out.append(frozenset(S))
        return out

    sets = set(pool([1.0] * n, pool_size))
    y = None
    for _ in range(rounds):
        L = list(sets)
        A = np.zeros((len(L), n))
        for i, S in enumerate(L):
            for v in S:
                A[i, v] = 1.0
        res = linprog(c=-np.ones(n), A_ub=A, b_ub=np.ones(len(L)), bounds=[(0, None)] * n,
                      method="highs")
        if not res.success:
            raise RuntimeError("LP: " + res.message)
        y = res.x
        sets |= set(pool(y, 800))
        wit = heavier_than(n, edges, [int(v * fine) for v in y], fine, tmp)
        if wit is None:
            break
        S, blocked = set(wit), set(wit)
        for v in wit:
            blocked |= adj[v]
        for v in sorted(range(n), key=lambda v: -y[v]):
            if v not in blocked:
                S.add(v)
                blocked.add(v)
                blocked |= adj[v]
        sets.add(frozenset(S))
    tmp.unlink(missing_ok=True)

    best = None
    for k in [8, 12, 16, 18, 19, 20, 24, 28, 32, 40, 48, 64, 96]:
        fr = [F(v).limit_denominator(k) for v in y]
        L = 1
        for f in fr:
            L = lcm(L, f.denominator)
        if L > 6000:
            continue
        w = [int(f * L) for f in fr]
        if any(x < 0 for x in w):
            continue
        mx, _, _ = max_weight(n, edges, w)
        if mx <= L and (best is None or sum(w) * best[1] > best[0] * L):
            best = (sum(w), L, w)
    return best


# ---------------------------------------------------------------- emission

def to_tower(u):
    """A ℚ(√3,√11) coefficient 4-tuple, placed in the 16 slots of the ℚ(√3,√5,√7,√11) tower."""
    out = [F(0)] * NSLOT
    for k, s in enumerate(SLOT):
        out[s] = u[k]
    return out


def lean_weights(name, n, w, D, order, out: Path):
    ws = ", ".join(str(x) for x in w)
    od = ", ".join(str(v) for v, _ in order)
    slots = ", ".join(f"({1 << v}, {mask}, {w[v]})" for v, mask in order)
    out.write_text(f"""import Proofs.HadwigerNelson.IndepSearch

/-!
# `{name}` — the weights, and the search plan that certifies them

Emitted by `tools/corespindle.py`, which is **not trusted**: `{name}_noHeavy` is decided by kernel
reduction, so wrong weights or a wrong plan cannot pass. When it fails, `{name}_findHeavy` in
`Instances/CoreSpindle/Diagnose.lean` names an independent set that beat the bound.
-/

namespace HadwigerNelson

/-- The {n} vertex weights, summing to {sum(w)}. -/
def {name}WeightList : List ℕ := [{ws}]

/-- The weight of a vertex; `0` outside the table, which no consumer reaches. -/
def {name}Weights (v : Fin {n}) : ℕ := {name}WeightList.getD v.val 0

/-- The order the search visits vertices in — heaviest first, which is worth a measured 27×.
The bound these weights certify is {D}: no independent set weighs more. -/
def {name}Order : List (Fin {n}) := [{od}]

/-- The search plan: one triple per visit, `(this vertex's bit, its neighbour mask, its weight)`.
A literal, so the kernel reads it rather than rebuilding it 390,625 times; `{name}_slots` ties it
to the graph. -/
def {name}Slots : List (ℕ × ℕ × ℕ) := [{slots}]

end HadwigerNelson
""")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--rows", nargs="+", type=int, required=True)
    ap.add_argument("--out", help="certificate JSON for tools/emit_cert.py")
    ap.add_argument("--lean", help="Lean module for the weights and the search plan")
    ap.add_argument("--name", default="coreSpindle")
    args = ap.parse_args()

    pts, ncore, diamonds, edges = build(args.rows)
    n = len(pts)
    print(f"core            {ncore} points, rows {args.rows}", file=sys.stderr)
    print(f"diamonds        {diamonds}", file=sys.stderr)
    print(f"points          {n}  ({len(set(pts))} distinct)", file=sys.stderr)
    print(f"unit-distance   {len(edges)} pairs", file=sys.stderr)
    if len(set(pts)) != n:
        sys.exit("repeated point")

    tot, D, w = dual(n, edges)
    mx, nodes, order = max_weight(n, edges, w)
    print(f"weights         sum {tot}, bound {D}  ->  chi_f >= {tot}/{D} = {tot / D:.6f}",
          file=sys.stderr)
    print(f"re-checked      heaviest independent set weighs {mx} "
          f"({'tight' if mx == D else 'SLACK'}), {nodes} search nodes", file=sys.stderr)
    g = gcd(tot, D)
    print(f"reduced         {tot // g}/{D // g}", file=sys.stderr)
    if mx > D:
        sys.exit("the weights are not feasible; nothing written")

    if args.out:
        L = 1
        for p in pts:
            for comp in p:
                for f in comp:
                    L = lcm(L, f.denominator)
        coords = [[[int(f * L) for f in to_tower(comp)] for comp in p] for p in pts]
        json.dump({"names": [str(i) for i in range(n)], "denom": L, "coords": coords,
                   "edges": [list(e) for e in edges], "primes": PRIMES}, open(args.out, "w"))
        print(f"denominator     {L}", file=sys.stderr)
        print(f"wrote           {args.out}", file=sys.stderr)

    if args.lean:
        nbr = [0] * n
        for a, b in edges:
            nbr[a] |= 1 << b
            nbr[b] |= 1 << a
        lean_weights(args.name, n, w, D, [(v, nbr[v]) for v in order], Path(args.lean))
        print(f"wrote           {args.lean}", file=sys.stderr)


if __name__ == "__main__":
    main()
