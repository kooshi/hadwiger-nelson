#!/usr/bin/env python3
"""FS-61, the owner's time-boxed look at the class theorem (plan E.5, route beta).  UNTRUSTED like everything in tools/.

Question: one integral lattice shape Lambda (a sublattice of Z^4 in the coordinates (a,b,c,e) of ((a+b sqrt d)/M, (c+e sqrt d)/M))
occurs over several fields.  W_d = the unit vectors of Q(sqrt d) in Lambda.  For d != d' the norm equation is linear in d, so W_d and
W_d' share only the RATIONAL unit vectors and no witness transfers verbatim.  But a linear T in GL(Lambda) with T(W_d) = W_d' would
make the two infinite unit-distance graphs isomorphic, and one refusing finite piece -- one LRAT -- would serve both fields: the
precondition for a parametric witness.  This searches for such a T exactly (Fractions), pruned level by level along a greedy basis.
Positive control: a field against itself must return its automorphisms (L3e1c94c6, 359 vs 359: 16).
Usage (from the repository root): python3 tools/fs61_owner_shape_iso.py SHAPE_ID d1 d2
"""
import sys, json, itertools
from fractions import Fraction as F
from math import isqrt
def load(d, sid):
    for l in open(f'data/fs61/fields/{d}/lattices.jsonl'):
        r = json.loads(l)
        if r['id'] == sid: return r
    raise SystemExit(f'{sid} not at d={d}')
def solve(basis, v):
    n = 4
    A = [[F(basis[j][i]) for j in range(n)] + [F(v[i])] for i in range(n)]
    for c in range(n):
        p = next((r for r in range(c, n) if A[r][c] != 0), None)
        if p is None: return None
        A[c], A[p] = A[p], A[c]
        A[c] = [x / A[c][c] for x in A[c]]
        for r in range(n):
            if r != c and A[r][c] != 0:
                A[r] = [x - A[r][c] * y for x, y in zip(A[r], A[c])]
    return [A[i][n] for i in range(n)]
def indep(vs):
    A = [[F(x) for x in r] for r in vs]; rk = 0
    for c in range(4):
        p = next((i for i in range(rk, len(A)) if A[i][c] != 0), None)
        if p is None: continue
        A[rk], A[p] = A[p], A[rk]
        for i in range(len(A)):
            if i != rk and A[i][c] != 0:
                f = A[i][c] / A[rk][c]; A[i] = [x - f * y for x, y in zip(A[i], A[rk])]
        rk += 1
    return rk == len(vs)
def in_lattice(hnf, v):
    co = solve(hnf, v)
    return co is not None and all(x.denominator == 1 for x in co)
def generators(d, M, hnf):
    W = []; B = isqrt(M * M // d)
    for b in range(-B, B + 1):
        for e in range(-B, B + 1):
            rest = M * M - d * (b * b + e * e)
            if rest < 0: continue
            for a in range(-isqrt(rest), isqrt(rest) + 1):
                c2 = rest - a * a; c = isqrt(c2)
                if c * c != c2: continue
                for cc in {c, -c}:
                    if a * b + cc * e == 0 and in_lattice(hnf, (a, b, cc, e)): W.append((a, b, cc, e))
    return sorted(set(W))

sid, d1, d2 = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
r1, r2 = load(d1, sid), load(d2, sid)
M, hnf = r1['M'], r1['hnf']
W1, W2 = generators(d1, M, hnf), generators(d2, M, hnf)
S2 = set(W2)
print(f'{sid}: |W_{d1}| = {len(W1)}, |W_{d2}| = {len(W2)}', flush=True)
def rel(W):
    S = set(W); return sum(1 for u in W for v in W if tuple(x + y for x, y in zip(u, v)) in S)
print('  additive relations u+v in W:', rel(W1), 'vs', rel(W2), flush=True)
# greedy basis: maximise how much of W1 lies in the span of the first k vectors
def span_count(bs):
    k = len(bs); cnt = 0
    for w in W1:
        # w in span(bs)? rank test via solving with padding
        rows = list(bs) + [w]
        # integer rank by fraction elimination
        A = [[F(x) for x in r] for r in rows]; rk = 0
        for c in range(4):
            p = next((i for i in range(rk, len(A)) if A[i][c] != 0), None)
            if p is None: continue
            A[rk], A[p] = A[p], A[rk]
            for i in range(len(A)):
                if i != rk and A[i][c] != 0:
                    f = A[i][c] / A[rk][c]; A[i] = [x - f * y for x, y in zip(A[i], A[rk])]
            rk += 1
        if rk == k: cnt += 1
    return cnt
basis = [W1[0]]
while len(basis) < 4:
    best = max((w for w in W1 if span_count(basis + [w]) and indep(basis + [w])), key=lambda w: span_count(basis + [w]))
    basis.append(best)
coords = {w: solve(basis, w) for w in W1}
level = {w: max(i for i in range(4) if coords[w][i] != 0) for w in W1}
bylev = [[w for w in W1 if level[w] == k] for k in range(4)]
print('  basis', basis, ' elements per level', [len(x) for x in bylev], flush=True)
found = []
def ok_level(k, img):
    for w in bylev[k]:
        c = coords[w]
        t = [sum(c[i] * img[i][j] for i in range(k + 1)) for j in range(4)]
        if any(x.denominator != 1 for x in t) or tuple(int(x) for x in t) not in S2: return False
    return True
def rec(k, img):
    if k == 4:
        found.append(tuple(img)); return
    for v in W2:
        if v in img: continue
        img.append(v)
        if ok_level(k, img): rec(k + 1, img)
        img.pop()
rec(0, [])
print(f'  linear isomorphisms T(W_{d1}) = W_{d2}: {len(found)}', flush=True)
if found: print('  first:', basis, '->', found[0])
