#!/usr/bin/env python3
"""fs1014_importance -- reads an FS-66 certificate (read only) and reports, per block, the share of its R matrix's
trace, and per representative monomial phi_{-h} phi_h, the diagonal weight summed over blocks, grouped by the
norm class of 2h (the distance class of the pair). Untrusted reading; it decides only which variants to try."""
import json, sys
from fractions import Fraction
C = json.load(open(sys.argv[1]))
p = C['p']; n = p * p
def neg(x): a, b = divmod(x, p); return ((-a) % p) * p + ((-b) % p)
def nrm(x): a, b = divmod(x, p); return (a * a + b * b) % p
reps = [(0,)]; seen = set()
for h in range(n):
    if h in seen: continue
    mh = neg(h); seen.add(h); seen.add(mh); reps.append(tuple(sorted((mh, h))))
def dclass(r):
    if len(r) == 1: return 'phi_0'
    x, y = r
    if x == y: return 'phi_0^2'
    a1, b1 = divmod(x, p); a2, b2 = divmod(y, p)
    return 'N(2h)=%d' % (((a2 - a1) ** 2 + (b2 - b1) ** 2) % p)
tot_by = {}
print('blocks:', len(C['blocks']))
for bi, b in enumerate(C['blocks']):
    R = b['R']; d = len(R)
    tr = sum(R[i][i] for i in range(1, d)) if b['times'] == '1' else R[1][1]
    nz_off = sum(1 for i in range(1, d) for j in range(i + 1, d) if R[i][j]) if b['times'] == '1' else 0
    print(f"  block {bi:2d} times {b['times']} u={b.get('u')} size {d} trace(1..) {float(tr):.4e} R00 {float(R[0][0]):.3e} nonzero off-diag pairs {nz_off}")
    if b['times'] == '1':
        for i in range(1, d):
            c = dclass(reps[i - 1]); tot_by[c] = tot_by.get(c, 0) + R[i][i]
print('diagonal weight by distance class of the rep (summed over times-1 blocks):')
T = sum(tot_by.values())
for c, v in sorted(tot_by.items(), key=lambda kv: -kv[1]):
    print(f'  {c:10s} {float(v)/float(T):.4f}')
