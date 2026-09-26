#!/usr/bin/env python3
"""fs84_s1_band_candidates -- FS-84 S1c: complete exact enumeration of two DERIVED finite candidate sets of rational band characters
on the ten minimal survivors Lambda_M of Q(sqrt47) (data/fs81/phaseD/d47/survivors.md), each hit re-checked in Fractions.

A band character is theta in Hom(Lambda_M, Q/Z) with theta(u) mod 1 in [1/4, 3/4] for every u in U_M; it four-colours
Cay(Lambda_M, U_M) periodically by x -> floor(4 theta(x)).  Deciding whether ANY theta exists is the Theta_4 question (a finder;
out under the ban).  This tool enumerates only the finite sets fixed in plans/FS84-S1-derivation.md Stage 3 BEFORE any run:

  family A (the T_168 family): every theta of order dividing 168 = lcm(2,3,4,7,8) -- a superset of every theta whose restriction to
      every rotation layer b U_Q is one of row 95's 29 torsion types with zero archimedean part (Lambda_M is spanned by its layers);
  family B (the local family): every theta of order q for q in {11, 19, 23, 31, 43, 47}, the stable places below 50 -- a superset of
      the level-one characters at one stable place (CLG's local form), and of their sums over the two places above q.

POINTS.  (a, b, c, e) over M is ((a + b sqrt47)/M, (c + e sqrt47)/M); U_M by FS-58's frozen enumerator (read-only import).  Lambda_M's
Z-basis is the Hermite normal form of the numerator vectors; every u gets integer coordinates in it (asserted).

CONTROLS.  (pos) the rank-2 lattice of U_5 (the 12 rational unit vectors over 5): family A must contain the six type representatives
of row 95 (FS89-S1V-5), transported to (1/5)Z[i]; (neg) theta = 0 and a planted off-band theta must be REFUSED by the Fractions
checker; (FS-81) at M = 240 no hit may have order dividing 7 or 14 (FS-81's quotient screen is UNSAT there).
--plant band: the checker's band is narrowed to [1/4 + 1/168, 3/4]: the Fractions checker must then refuse the order-4 point
(x+y)/4, whose values sit on 1/4 and 3/4 (it fires); parity (values 1/2) must survive it.
Exit 0 all checks hold, 1 a check failed, 4 a plant did not fire.  Output: data/fs84/s1/band_candidates.{out,json}.
"""
import json
import os
import sys
from fractions import Fraction as Fr

import numpy as np

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
from fs58_local import units_d  # noqa: E402  (frozen; read-only use)

D = 47
MINIMAL = [240, 360, 408, 840, 1272, 1464, 2136, 2184, 2328, 2424]
STABLE_Q = [11, 19, 23, 31, 43, 47]
PLANT = sys.argv[sys.argv.index('--plant') + 1] if '--plant' in sys.argv else None
LO = Fr(1, 4) + (Fr(1, 168) if PLANT == 'band' else 0)
HI = Fr(3, 4)


def hnf_basis(vectors):
    """row-style integer echelon basis of the Z-span of the given integer vectors (exact, by gcd elimination)"""
    rows = [list(v) for v in vectors if any(v)]
    n = len(rows[0])
    basis = []
    col = 0
    while rows and col < n:
        rows = [r for r in rows if any(r)]
        piv = [r for r in rows if r[col] != 0]
        if not piv:
            col += 1
            continue
        while len([r for r in rows if r[col] != 0]) > 1:
            nz = sorted([r for r in rows if r[col] != 0], key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(n):
                    r[j] -= q * p[j]
            rows = [r for r in rows if any(r)]
        p = [r for r in rows if r[col] != 0][0]
        if p[col] < 0:
            p = [-x for x in p]
        basis.append(p)
        rows = [r for r in rows if r[col] == 0]
        col += 1
    return basis


def coords(basis, v):
    """integer coordinates of v in the echelon basis (asserted exact)"""
    v = list(v)
    out = []
    for b in basis:
        c = next(j for j in range(len(b)) if b[j] != 0)
        assert v[c] % b[c] == 0, 'not in the lattice'
        k = v[c] // b[c]
        out.append(k)
        v = [v[j] - k * b[j] for j in range(len(v))]
    assert not any(v), 'residual'
    return out


def band_ok(theta_vals):
    return all(LO <= (t % 1) <= HI for t in theta_vals)


def fractions_check(C, t, N):
    """theta = t/N on the basis; every u (coordinates C row) in the band, exactly"""
    return band_ok([Fr(sum(ti * ci for ti, ci in zip(t, row)), N) for row in C])


def enum_order(C, N, lo=None, hi=None):
    """every t in (Z/N)^r with lo <= <t, c(u)> mod N <= hi for all rows; returns the list of hits (as tuples)"""
    lo = -(-N // 4) if lo is None else lo   # ceil(N/4)
    hi = (3 * N) // 4 if hi is None else hi
    C = np.array([[x % N for x in row] for row in C], dtype=np.int64)
    r = C.shape[1]
    hits = []
    rest = r - 1
    grid = np.stack(np.meshgrid(*[np.arange(N)] * rest, indexing='ij'), -1).reshape(-1, rest) if rest else np.zeros((1, 0), np.int64)
    for t0 in range(N):
        T = grid
        keep = np.ones(len(T), bool)
        idx = np.arange(len(T))
        for row in C:
            v = (t0 * row[0] + T[idx] @ row[1:]) % N
            ok = (v >= lo) & (v <= hi)
            idx = idx[ok]
            if not len(idx):
                break
        for i in idx:
            hits.append((t0,) + tuple(int(x) for x in T[i]))
    return hits


def lattice(M):
    U = sorted(set(map(tuple, units_d(M, D))))
    B = hnf_basis(U)
    half = []
    seen = set()
    for u in U:
        if tuple(-x for x in u) in seen:
            continue
        seen.add(u)
        half.append(u)
    C = [coords(B, u) for u in half]
    return U, B, C


def order_of(t, N):
    from math import gcd
    g = N
    for x in t:
        g = gcd(g, x)
    return N // g


def main():
    fails = []
    res = {'band': [str(LO), str(HI)], 'plant': PLANT, 'lattices': {}}
    # positive control: rank 2, the rational pattern over 5
    U5, B5, C5 = lattice(5)
    assert len(U5) == 12 and len(B5) == 2, (len(U5), len(B5))
    hits5 = enum_order(C5, 168)
    # row 95's six type representatives, as characters of Z[i] ((x + y)/2 etc.), transported to (1/5)Z[i]:
    # theta(z) for z in (1/5)Z[i] is 5^{-1} (mod the order) times theta(5 z).  Evaluate on each basis vector of B5.
    def rep(alpha, beta, n):
        inv5 = pow(5, -1, n)
        vals = []
        for b in B5:            # b = (a, 0, c, 0) over 5: z = (a + c i)/5, 5z = a + c i
            a, c = b[0], b[2]
            vals.append(((alpha * a + beta * c) * inv5 % n) * (168 // n) % 168)
        return tuple(vals)
    reps = {'(x+y)/2': rep(1, 1, 2), '(x+y)/3': rep(1, 1, 3), '(x+y)/4': rep(1, 1, 4), '(x+2y)/4': rep(1, 2, 4),
            '(2x+3y)/7': rep(2, 3, 7), '(3x+2y)/8': rep(3, 2, 8)}
    hs5 = set(hits5)
    present = {k: (v in hs5) for k, v in reps.items()}
    print(f'(pos) rank-2 rational pattern over 5: {len(hits5)} characters of order | 168 in the band; row 95 types present: {present}')
    res['positive_control'] = dict(n_hits=len(hits5), types_present=present)
    if not all(present.values()):
        fails.append('positive control: a row-95 type is missing')
    # negative controls on the checker
    if fractions_check(C5, (0, 0), 168):
        fails.append('neg: theta = 0 accepted')
    if not fractions_check(C5, reps['(x+y)/2'], 168):
        fails.append('neg: parity refused by the Fractions checker')
    if not fractions_check(C5, reps['(x+y)/4'], 168):   # margin 0: values sit on 1/4 and 3/4, so a narrowed band refuses it
        fails.append('neg: the order-4 point (x+y)/4 refused by the Fractions checker')
    for M in ([] if PLANT else MINIMAL):   # a plant tests the checker and the control only
        U, B, C = lattice(M)
        rec = dict(units=len(U), rank=len(B), basis=B)
        hA = enum_order(C, 168)
        hB = {}
        for q in STABLE_Q:
            hB[q] = enum_order(C, q)
        exact = [t for t in hA if fractions_check(C, t, 168)]
        exactB = {q: [t for t in h if fractions_check(C, t, q)] for q, h in hB.items()}
        ords = sorted({order_of(t, 168) for t in hA})
        rec.update(familyA_hits=len(hA), familyA_exact=len(exact), familyA_orders=ords,
                   familyB_hits={q: len(h) for q, h in hB.items()},
                   familyB_exact={q: len(h) for q, h in exactB.items()},
                   examples=dict(A=[list(t) for t in exact[:3]], B={q: [list(t) for t in h[:2]] for q, h in exactB.items() if h}))
        if len(exact) != len(hA) or any(len(exactB[q]) != len(hB[q]) for q in hB):
            fails.append(f'M={M}: numpy and Fractions disagree')
        if M == 240 and any(order_of(t, 168) in (1, 2, 7, 14) for t in hA):
            fails.append('M=240: a hit of order dividing 14 contradicts FS-81 (N = 7, 14 UNSAT)')
        print(f'M={M:5d}: |U_M| = {len(U)}, rank {len(B)}; family A (order | 168): {len(hA)} band characters '
              f'(orders {ords}); family B (order q stable): {rec["familyB_hits"]}')
        res['lattices'][M] = rec
    res['fails'] = fails
    if PLANT:
        if fails:
            print(f'PLANT {PLANT} FIRED: {fails}')
            return 0
        print(f'PLANT {PLANT} DID NOT FIRE')
        return 4
    with open(os.path.join(ROOT, 'data/fs84/s1/band_candidates.json'), 'w') as f:
        json.dump(res, f, indent=1, default=str)
    if fails:
        print('FAIL:', fails)
        return 1
    print('DONE: every hit re-checked exactly; controls pass.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
