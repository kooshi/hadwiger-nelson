#!/usr/bin/env python3
"""pool_field_census — which square roots can ONE iteration reach? (RISKS.md R1's question, Kooshi
2026-09-03: "is it even possible for the field to generate √5 or √7 material in a single iteration?")

    python3 tools/pool_field_census.py --object <label> [--dps 50]

A glue point of two points at squared distance d² adjoins √(4/d² − 1). Over K = ℚ(√3, √11) (every
point of the object is in K — T14, exact coordinates in data/m52/exact-<label>.json) the depth-1
lattice's field is K adjoined the roots of the distinct radicands r = 4/d² − 1 over all pairs at
distance < 2. Two radicands give the same extension iff their ratio is a square in K; 3 and 11 are
squares in K, so the RATIONAL square classes are m ∈ {1, 2, 5, 7, 10, 14, 35, 70} (m = 1 means the
root is already in K — an in-field glue point). This census: every pair at distance < 2 among the
live points (float screen, then EXACT d² in K by Fraction arithmetic), the distinct radicands, each
classified into a rational class (√(r/m) ∈ K, found by PSLQ at `dps` digits and VERIFIED exactly by
squaring in K) or left as a non-rational class; per class the number of radicands, pairs, and pool
points (two glue points per pair). Writes data/m52/poolfield-<label>.json. UNTRUSTED like all of
tools/; the classification of a radicand as in-class is exact (a verified square), a radicand left
unclassified is 'no rational class found', not 'irrational class proved'."""
from __future__ import annotations
import argparse, collections, json, sys, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from scipy.spatial import cKDTree
import mpmath as mp
import batchkill as B
from copy_exact_field import K

OUT = Path(__file__).resolve().parent.parent / "data" / "m52"
CLASSES = [1, 2, 5, 7, 10, 14, 35, 70]


def k_inv(a: K) -> K:
    """The inverse in K by solving the 4×4 multiplication system over ℚ."""
    basis = [K(1), K(0, 1), K(0, 0, 1), K(0, 0, 0, 1)]
    cols = [(a * b).c for b in basis]                      # column j = a * e_j
    M = [[Fr(cols[j][i]) for j in range(4)] for i in range(4)]
    rhs = [Fr(1), Fr(0), Fr(0), Fr(0)]
    # Gaussian elimination
    n = 4
    A = [row[:] + [rhs[i]] for i, row in enumerate(M)]
    for c in range(n):
        piv = next(r for r in range(c, n) if A[r][c] != 0)
        A[c], A[piv] = A[piv], A[c]
        pv = A[c][c]; A[c] = [x / pv for x in A[c]]
        for r in range(n):
            if r != c and A[r][c] != 0:
                f = A[r][c]; A[r] = [x - f * y for x, y in zip(A[r], A[c])]
    return K(*(A[i][4] for i in range(4)))


def sqrt_in_K(x: K, dps: int):
    """s ∈ K with s² = x, or None. Numeric discovery by PSLQ, exact verification by squaring."""
    xm = x.mp()
    if xm < 0:
        return None
    s = mp.sqrt(xm)
    if abs(s) < mp.mpf(10) ** (-(dps - 10)):
        return K()
    rel = mp.pslq([s, 1, mp.sqrt(3), mp.sqrt(11), mp.sqrt(33)], maxcoeff=10 ** 9, maxsteps=10 ** 5)
    if not rel or rel[0] == 0:
        return None
    cand = K(*(Fr(-r, rel[0]) for r in rel[1:]))
    return cand if (cand * cand) == x else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--dps", type=int, default=50)
    a = ap.parse_args()
    t0 = time.time(); mp.mp.dps = a.dps
    obj, removed = B.load_object(a.object)
    ex = json.loads((OUT / f"exact-{a.object}.json").read_text())["points"]
    def kx(i):
        A_, B_ = ex[str(i)]["x"]; assert all(n == 0 for n, d in B_), "a copy point (K(√5)) — this census is for K-point objects"
        return K(*(Fr(n, d) for n, d in A_))
    def ky(i):
        A_, B_ = ex[str(i)]["y"]; return K(*(Fr(n, d) for n, d in A_))
    live = [i for i in range(obj.n) if i not in obj.deleted and str(i) in ex]
    X = {i: kx(i) for i in live}; Y = {i: ky(i) for i in live}
    P = np.array([obj.pts[i] for i in live]); tree = cKDTree(P); lv = np.array(live)
    pairs = tree.query_pairs(2.0 - 1e-9)
    print(f"[poolfield] {a.object}: {len(live)} live K-points, {len(pairs)} pairs at distance < 2 (float screen) [{time.time()-t0:.0f}s]", flush=True)
    four = K(4); one = K(1)
    rad_of_pair = {}; radicands = {}
    for i, j in pairs:
        u, v = int(lv[i]), int(lv[j])
        dx, dy = X[u] - X[v], Y[u] - Y[v]
        d2 = dx * dx + dy * dy
        if d2.is_zero(): continue
        r = four * k_inv(d2) - one                              # 4/d² − 1, exact in K
        key = r.c
        radicands.setdefault(key, r); rad_of_pair[(u, v)] = key
    print(f"[poolfield] distinct radicands (exact): {len(radicands)} [{time.time()-t0:.0f}s]", flush=True)
    cls = {}
    for key, r in radicands.items():
        found = None
        for m in CLASSES:
            s = sqrt_in_K(r * K(Fr(1, m)), a.dps)                # √(r/m) ∈ K ⟺ r ∈ m·K²
            if s is not None:
                found = m; break
        cls[key] = found
    per_class_rad = collections.Counter(cls.values())
    per_class_pairs = collections.Counter(cls[k] for k in rad_of_pair.values())
    pos = sum(1 for k, r in radicands.items() if r.mp() > 0)
    print(f"[poolfield] radicands by rational class (m: radicands / pairs / pool points = 2·pairs):", flush=True)
    for m in CLASSES + [None]:
        if per_class_rad.get(m, 0):
            print(f"[poolfield]   m = {m if m else 'non-rational class'}: {per_class_rad[m]} radicands, {per_class_pairs[m]} pairs, {2*per_class_pairs[m]} pool points"
                  + ("  (in K: √r ∈ K — an in-field glue point)" if m == 1 else "") + ("  ← √5" if m == 5 else "") + ("  ← √7" if m == 7 else "") + ("  ← √35" if m == 35 else ""), flush=True)
    out = dict(kind="pool-field-census", label=a.object, live=len(live), pairs=len(pairs), radicands=len(radicands), radicands_positive=pos,
               classes={str(m): dict(radicands=per_class_rad.get(m, 0), pairs=per_class_pairs.get(m, 0)) for m in CLASSES + [None]},
               dps=a.dps, seconds=round(time.time() - t0, 1),
               claim_scope="exact d² and radicands in K; class membership = an exact square in K found by PSLQ; 'non-rational class' = no m in {1,2,5,7,10,14,35,70} found, not a proof of irrationality of the class")
    (OUT / f"poolfield-{a.object}.json").write_text(json.dumps(out, indent=1))
    print(f"[poolfield] wrote {OUT / ('poolfield-' + a.object + '.json')} [{time.time()-t0:.0f}s]")


if __name__ == "__main__":
    main()
