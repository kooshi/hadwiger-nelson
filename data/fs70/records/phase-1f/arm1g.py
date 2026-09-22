#!/usr/bin/env python3
"""arm 1g: how BIG is the surviving set?

arm 1f measured that the radius-3 ball refutes 120 of 120 random first-shell colourings.  That bounds the
survival RATE from above (< 2.5 % at 95 % confidence) but says nothing useful about the survivor COUNT, which
is what a two-stage pass would actually pay for.  Enumerate them directly instead: solve the radius-3 ball,
project the model onto the 84 first-shell vertices, block that projection, repeat.

ONE-SIDED, and the informative direction is 'many'.  If survivors pour out, the surviving set is large and the
route is dead.  If the enumeration stalls, that measures the solver as much as the set (G21) and settles
nothing.
"""
import json, sys, time
import numpy as np
sys.path.insert(0, 'tools')
import fs70_price_cubes as FP
from pysat.solvers import Solver

OUT = 'build/fs70/1f'; PINS = [(0, 0), (25, 1), (27, 2)]
BUDGET = int(sys.argv[1]) if len(sys.argv) > 1 else 600
pts, ind, ptr, meta = FP.load_cache(OUT, fast=True)
n = meta['n']
A = FP._void(pts); o = np.argsort(A, kind='stable'); sk = A[o]
G8 = pts[np.array(sorted(int(x) for x in ind[ptr[0]:ptr[1]]))]
lvl, cur = {0}, np.array([0])
for r in (1, 2, 3):
    cand = (pts[cur][:, None, :] + G8[None, :, :]).reshape(-1, 8)
    k = FP._void(cand); p = np.clip(np.searchsorted(sk, k), 0, len(sk) - 1)
    cur = np.unique(o[p[sk[p] == k]]); lvl |= set(int(x) for x in cur)
V = sorted(lvl); pos = {v: i for i, v in enumerate(V)}
E = sorted({(pos[a], pos[b]) for a in V for j in range(ptr[a], ptr[a + 1])
            for b in [int(ind[j])] if b in pos and pos[a] < pos[b]})
shell1 = [v for v in sorted(int(x) for x in ind[ptr[0]:ptr[1]]) if v not in {x for x, _ in PINS}]
print(f'radius-3 ball: {len(V):,} vertices, {len(E):,} edges; projecting onto {len(shell1)} shell vertices',
      flush=True)
s = Solver(name='cadical195')
for i in range(len(V)):
    s.add_clause([FP.var(i, c) for c in range(4)])
    for c1 in range(4):
        for c2 in range(c1 + 1, 4):
            s.add_clause([-FP.var(i, c1), -FP.var(i, c2)])
for a, b in E:
    for c in range(4):
        s.add_clause([-FP.var(a, c), -FP.var(b, c)])
for v, c in PINS:
    s.add_clause([FP.var(pos[v], c)])
t0 = time.time(); seen = set(); marks = []
while time.time() - t0 < BUDGET:
    if not s.solve():
        print('  the radius-3 ball is exhausted: every first-shell colouring has been enumerated')
        break
    m = {abs(x): x > 0 for x in s.get_model() if x}
    proj = tuple(next(c for c in range(4) if m.get(FP.var(pos[v], c), False)) for v in shell1)
    seen.add(proj)
    s.add_clause([-FP.var(pos[v], c) for v, c in zip(shell1, proj)])
    if len(seen) % 200 == 0:
        marks.append((len(seen), round(time.time() - t0, 1)))
        print(f'  {len(seen)} survivors in {time.time()-t0:.0f}s', flush=True)
el = time.time() - t0
res = {'survivors_found': len(seen), 'seconds': round(el, 1),
       'rate_per_second': round(len(seen) / el, 2), 'marks': marks,
       'radius3_vertices': len(V), 'shell_vertices': len(shell1),
       'note': 'one-sided: many survivors kills the two-stage route; few measures the solver as much as the set'}
print(json.dumps({k: v for k, v in res.items() if k != 'marks'}, indent=1))
json.dump(res, open(f'{OUT}/arm1g.json', 'w'), indent=1)
