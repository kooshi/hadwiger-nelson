"""(1) every split presentation in the sample has S = +-{a}, +-{a,2a} or +-{a,b,a+b};  (2) every rank-1 triple {p,q,p+q} has a
Theta_4 point t = j/N (lonely-runner, three speeds, checked exactly for p < q <= 40)."""
import itertools, collections, math
from fractions import Fraction as Fr
from heights_edge import sym, neg, add
from split_types import comps, cases
bad = 0; kinds = collections.Counter()
for G in cases:
    S = sym(G); cs = comps(S)
    if len(cs) == 1: continue
    A = set(); used = set()
    for K in cs:
        if id(K) in used: continue
        nk = {neg(s) for s in K}
        A |= K
        used.add(id(K)); used |= {id(L) for L in cs if L == nk}
    A = sorted(A)
    if len(A) == 1: kinds['{a}'] += 1; continue
    if len(A) == 2:
        a, b = A
        if add(add(a, a), b) == tuple(0 for _ in a) or add(add(b, b), a) == tuple(0 for _ in a): kinds['{a,-2a}'] += 1
        else: bad += 1
        continue
    if len(A) == 3 and add(add(A[0], A[1]), A[2]) == tuple(0 for _ in A[0]): kinds['{a,b,-a-b}'] += 1; continue
    bad += 1; print('BAD', A)
print('split structure:', dict(kinds), 'violations', bad)
def dist(x): x = x % 1; return min(x, 1 - x)
fail = 0
for p in range(1, 41):
    for q in range(p + 1, 41):
        speeds = (p, q, p + q)
        ok = any(all(dist(Fr(j, N) * v) >= Fr(1, 4) for v in speeds) for N in range(2, 4 * (p + q) + 1) for j in range(1, N))
        if not ok: fail += 1; print('no Theta4 point for', speeds)
print('rank-1 triples {p,q,p+q}, p<q<=40: failures', fail)
