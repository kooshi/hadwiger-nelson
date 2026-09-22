#!/usr/bin/env python3
"""arm 1f: what fraction of first-shell colourings survive the radius-3 ball?

arm 1e showed a depth-82 cube is refuted on the 95,389-vertex radius-3 ball, not by the bulk.  So a cube pass
at depth 82 is really two stages: a cheap local test on the radius-3 ball, then the full ball for whatever
survives.  This measures the survival rate, which is the multiplier in that cost model -- and is itself a
measurement of how strongly the first shell is constrained at radius 3."""
import json, multiprocessing as mp, os, subprocess, sys, time
import numpy as np
sys.path.insert(0, 'tools')
import fs70_price_cubes as FP

OUT = 'build/fs70/1f'; PINS = [(0, 0), (25, 1), (27, 2)]
N, BUD, JOBS = int(sys.argv[1]) if len(sys.argv) > 1 else 120, 300, 6
pts, ind, ptr, meta = FP.load_cache(OUT, fast=True)
n = meta['n']
per = [FP.hexagon_colourings(c, PINS, ind, ptr, n) for c in FP.hexagons(ind, ptr)]
A = FP._void(pts); o = np.argsort(A, kind='stable'); sk = A[o]
G8 = pts[np.array(sorted(int(x) for x in ind[ptr[0]:ptr[1]]))]
lvl, cur = {0}, np.array([0])
for r in (1, 2, 3):
    cand = (pts[cur][:, None, :] + G8[None, :, :]).reshape(-1, 8)
    k = FP._void(cand); pos = np.clip(np.searchsorted(sk, k), 0, len(sk) - 1)
    cur = np.unique(o[pos[sk[pos] == k]]); lvl |= set(int(x) for x in cur)
V = sorted(lvl); pos = {v: i for i, v in enumerate(V)}
E = sorted({(pos[a], pos[b]) for a in V for j in range(ptr[a], ptr[a + 1])
            for b in [int(ind[j])] if b in pos and pos[a] < pos[b]})
body = []
for i in range(len(V)):
    body.append([FP.var(i, c) for c in range(4)])
    for c1 in range(4):
        for c2 in range(c1 + 1, 4):
            body.append([-FP.var(i, c1), -FP.var(i, c2)])
for a, b in E:
    for c in range(4):
        body.append([-FP.var(a, c), -FP.var(b, c)])
for v, c in PINS:
    body.append([FP.var(pos[v], c)])
BODY = ''.join(' '.join(map(str, c)) + ' 0\n' for c in body)
print(f'the radius-3 ball: {len(V):,} vertices, {len(E):,} edges, {len(body):,} clauses', flush=True)
rng = np.random.default_rng(777)

def one(j):
    cube, tag = j
    p = f'{OUT}/s3-{tag}.cnf'
    ex = [x for x in cube if x[0] in pos]
    open(p, 'w').write(f'p cnf {4*len(V)} {len(body)+len(ex)}\n' + BODY +
                       ''.join(f'{FP.var(pos[v], c)} 0\n' for v, c in ex))
    t = time.time()
    rc = subprocess.run(['kissat', '-q', '-n', f'--time={BUD}', p], capture_output=True).returncode
    os.remove(p)
    return {'tag': tag, 'verdict': {20: 'UNSAT', 10: 'SAT'}.get(rc, f'UNKNOWN({rc})'),
            'seconds': round(time.time() - t, 2)}

jobs = []
for i in range(N):
    cube = tuple(x for (free, outs) in per for x in outs[rng.integers(len(outs))])
    jobs.append((cube, f'{i:03d}'))
t0 = time.time(); rows = []
with mp.get_context('fork').Pool(JOBS) as pool:
    for r in pool.imap_unordered(one, jobs, chunksize=1):
        rows.append(r)
        if len(rows) % 20 == 0:
            c = {v: sum(1 for x in rows if x['verdict'] == v) for v in ('SAT', 'UNSAT')}
            print(f'  {len(rows)}/{N}: {c} [{time.time()-t0:.0f}s]', flush=True)
c = {}
for r in rows:
    c[r['verdict']] = c.get(r['verdict'], 0) + 1
sat = c.get('SAT', 0)
res = {'sampled': len(rows), 'counts': c, 'survival_rate': round(sat / len(rows), 4),
       'mean_seconds': round(sum(r['seconds'] for r in rows) / len(rows), 2),
       'mean_seconds_unsat': round(sum(r['seconds'] for r in rows if r['verdict'] == 'UNSAT') /
                                   max(1, c.get('UNSAT', 0)), 2),
       'mean_seconds_sat': round(sum(r['seconds'] for r in rows if r['verdict'] == 'SAT') / max(1, sat), 2),
       'radius3_vertices': len(V), 'radius3_edges': len(E), 'budget': BUD, 'rows': rows}
print(json.dumps({k: v for k, v in res.items() if k != 'rows'}, indent=1))
json.dump(res, open(f'{OUT}/arm1f.json', 'w'), indent=1)
