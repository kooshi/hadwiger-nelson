#!/usr/bin/env python3
"""fs58_mkpool -- write a pool JSON (D, N, LLL basis, W0) for a union of classes, e.g. 'W140*' or 'axis+qi5+W40*'. Usage: D M SPEC OUT.
"""
import sys, json, itertools
sys.path.insert(0, str(__import__('pathlib').Path(__file__).resolve().parent))
from fs58_chain import hnf_basis, lll
from fs58_local import units_d
d = int(sys.argv[1]); M = int(sys.argv[2]); spec = sys.argv[3]; out = sys.argv[4]
W = set()
for part in spec.split('+'):
    if part == 'axis': W |= {(M,0,0,0),(-M,0,0,0),(0,0,M,0),(0,0,-M,0)}
    elif part == 'qi5': W |= {tuple(x * (M // 5) for x in w) for w in units_d(5, d) if w[1] == 0 and w[3] == 0 and 0 not in (w[0], w[2])}
    elif part.startswith('W') and part.endswith('*'):
        N = int(part[1:-1]); W |= {tuple(x * (M // N) for x in w) for w in units_d(N, d) if w[1] or w[3]}
W = sorted(W)
B = lll(hnf_basis(W), (1, d, 1, d))
json.dump({'D': d, 'N': M, 'basis': B, 'W0': [list(w) for w in W]}, open(out, 'w'))
print(out, len(W), 'vectors')
