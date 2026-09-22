#!/usr/bin/env python3
"""arm 1e: WHERE is a depth-82 cube refuted?  If the refutation already happens inside the radius-2 or
radius-3 ball then it is a fact about the second shell -- the fourteen wheels were coloured independently and
a shell-2 vertex sees several of them -- and says nothing about the bulk of the graph.  The ladder's verdict
has to be typed before it is read.

Regenerates the SAME cubes as arm1c.py (same seed, same code path) and re-asks each on the radius-2, radius-3
and radius-4 formulas."""
import json, subprocess, sys, time
import numpy as np
sys.path.insert(0, 'tools')
import fs70_price_cubes as FP

OUT = 'build/fs70/1f'; PINS = [(0, 0), (25, 1), (27, 2)]
pts, ind, ptr, meta = FP.load_cache(OUT, fast=True)
n = meta['n']
cyc = FP.hexagons(ind, ptr)
per = [FP.hexagon_colourings(c, PINS, ind, ptr, n) for c in cyc]
rng = np.random.default_rng(20260922)          # the same draw order as arm1c.py
cubes = {}
for d in (40, 58, 82):
    need, use = d, []
    for free, outs in per:
        if need <= 0: break
        need -= len(free); use.append((free, outs))
    for rep in range(2):
        cubes[f'hex{d}-{rep}'] = tuple(x for (free, outs) in use for x in outs[rng.integers(len(outs))])

# the radius-r sub-balls, as index sets of the SAME vertex numbering
A = FP._void(pts); o = np.argsort(A, kind='stable'); sk = A[o]
G8 = pts[np.array(sorted(int(x) for x in ind[ptr[0]:ptr[1]]))]
lvl, cur, balls = {0}, np.array([0]), {}
for r in (1, 2, 3):
    cand = (pts[cur][:, None, :] + G8[None, :, :]).reshape(-1, 8)
    k = FP._void(cand); pos = np.clip(np.searchsorted(sk, k), 0, len(sk) - 1)
    cur = np.unique(o[pos[sk[pos] == k]])
    lvl |= set(int(x) for x in cur)
    balls[r] = sorted(lvl)
rows = []
for tag, cube in cubes.items():
    for r in (2, 3):
        V = balls[r]; pos = {v: i for i, v in enumerate(V)}
        E = sorted({(pos[a], pos[b]) for a in V for j in range(ptr[a], ptr[a + 1])
                    for b in [int(ind[j])] if b in pos and pos[a] < pos[b]})
        cl = []
        for i in range(len(V)):
            cl.append([FP.var(i, c) for c in range(4)])
            for c1 in range(4):
                for c2 in range(c1 + 1, 4):
                    cl.append([-FP.var(i, c1), -FP.var(i, c2)])
        for a, b in E:
            for c in range(4):
                cl.append([-FP.var(a, c), -FP.var(b, c)])
        for v, c in list(PINS) + [x for x in cube if x[0] in pos]:
            cl.append([FP.var(pos[v], c)])
        p = f'{OUT}/sub.cnf'
        open(p, 'w').write(f'p cnf {4*len(V)} {len(cl)}\n' +
                           ''.join(' '.join(map(str, c)) + ' 0\n' for c in cl))
        t = time.time()
        rc = subprocess.run(['kissat', '-q', '-n', '--time=300', p], capture_output=True).returncode
        v = {20: 'UNSAT', 10: 'SAT'}.get(rc, f'UNKNOWN({rc})')
        rows.append({'tag': tag, 'radius': r, 'vertices': len(V), 'edges': len(E),
                     'verdict': v, 'seconds': round(time.time() - t, 2)})
        print(f'  {tag} on the radius-{r} ball ({len(V):,} vertices): {v} in {time.time()-t:.2f}s', flush=True)
json.dump(rows, open(f'{OUT}/arm1e.json', 'w'), indent=1)
