#!/usr/bin/env python3
"""arm 1c: the hardness ladder -- how deep must a cube be before the residual instance decides?

The sample (arm 1b) prices three branching depths that a real cube pass could afford.  This asks the other
question: is there ANY depth at which a cube decides?  The probes here are NOT passes -- their cube counts are
astronomical -- and they are one-sided: a SAT verdict decides the whole instance (the fabric four-colours),
while UNSAT or UNKNOWN says only that this one cube was refuted or was still hard.

  depth 40, 58, 82   whole hexagonal wheels about the origin; depth 82 fixes the origin's ENTIRE neighbourhood
  depth 3526         the whole word-distance-<= 2 ball (3,529 vertices, 3 of them already pinned), coloured by
                     kissat on the induced subgraph -- a cube that fixes a radius-2 neighbourhood
"""
import json, os, subprocess, sys, time
import numpy as np
sys.path.insert(0, 'tools')
import fs70_price_cubes as FP

OUT = 'build/fs70/1f'
PINS = [(0, 0), (25, 1), (27, 2)]
BUDGET = 600
t0 = time.time()
pts, ind, ptr, meta = FP.load_cache(OUT, fast=True)
n = meta['n']
bmeta = json.load(open(f'{OUT}/base-meta.json'))
assert bmeta['reproduces_prior_attempts_cnf']
base, nv, ncl = bmeta['body_path'], bmeta['variables'], bmeta['body_clauses']
cyc = FP.hexagons(ind, ptr)
pinned = {v for v, _ in PINS}

# ---- the hexagon cubes at depths 40, 58, 82
per = []
for c in cyc:
    per.append(FP.hexagon_colourings(c, PINS, ind, ptr, n))
rng = np.random.default_rng(20260922)
jobs = []
for d in (40, 58, 82):
    need, use = d, []
    for free, outs in per:
        if need <= 0:
            break
        need -= len(free)
        use.append((free, outs))
    assert need == 0, d
    for rep in range(2):
        cube = tuple(x for (free, outs) in use for x in outs[rng.integers(len(outs))])
        assert len(cube) == d
        jobs.append((cube, f'hex{d}-{rep}', f'{d} of the origin\'s 84 neighbours (hexagonal wheels)',
                     11 * 66 ** ((d - 4) // 6)))

# ---- the word-distance-<=2 cube: a proper colouring of the induced subgraph on the k=2 ball
dist2 = set([0])
for v in sorted(int(x) for x in ind[ptr[0]:ptr[1]]):
    dist2.add(v)
for v in list(dist2):
    for j in range(ptr[v], ptr[v + 1]):
        pass
# shells from the saved word-distance run: rebuild by two generator steps
G8 = pts[np.array(sorted(int(x) for x in ind[ptr[0]:ptr[1]]))]
A = FP._void(pts); ordr = np.argsort(A, kind='stable'); sk = A[ordr]
def idx_of(Q):
    k = FP._void(Q); pos = np.clip(np.searchsorted(sk, k), 0, len(sk) - 1)
    hit = sk[pos] == k
    return ordr[pos[hit]]
lvl = {0}
cur = np.array([0])
for _ in range(2):
    cand = (pts[cur][:, None, :] + G8[None, :, :]).reshape(-1, 8)
    cur = np.unique(idx_of(cand))
    lvl |= set(int(x) for x in cur)
ball2 = sorted(lvl)
print(f'the word-distance <= 2 ball: {len(ball2)} vertices ({time.time()-t0:.0f}s)', flush=True)
pos = {v: i for i, v in enumerate(ball2)}
E2 = sorted({(pos[a], pos[b]) for a in ball2 for j in range(ptr[a], ptr[a + 1])
             for b in [int(ind[j])] if b in pos and pos[a] < pos[b]})
cl = []
m = len(ball2)
for i in range(m):
    cl.append([FP.var(i, c) for c in range(4)])
    for c1 in range(4):
        for c2 in range(c1 + 1, 4):
            cl.append([-FP.var(i, c1), -FP.var(i, c2)])
for a, b in E2:
    for c in range(4):
        cl.append([-FP.var(a, c), -FP.var(b, c)])
for v, c in PINS:
    cl.append([FP.var(pos[v], c)])
p2 = f'{OUT}/ball2.cnf'
with open(p2, 'w') as fh:
    fh.write(f'p cnf {4*m} {len(cl)}\n')
    fh.write(''.join(' '.join(map(str, c)) + ' 0\n' for c in cl))
print(f'  induced subgraph: {m} vertices, {len(E2)} edges, {len(cl)} clauses', flush=True)
for rep in range(3):
    r = subprocess.run(['kissat', '-q', f'--seed={1000+rep}', '--time=120', p2],
                       capture_output=True, text=True)
    assert r.returncode == 10, f'the k=2 ball is not 4-colourable?! rc={r.returncode}'
    lits = [int(x) for line in r.stdout.splitlines() if line.startswith('v ') for x in line[2:].split()]
    val = {abs(x): x > 0 for x in lits if x}
    C = [next(c for c in range(4) if val.get(FP.var(i, c), False)) for i in range(m)]
    assert all(C[a] != C[b] for a, b in E2), 'the k=2 colouring is not proper'
    assert all(C[pos[v]] == c for v, c in PINS), 'the k=2 colouring breaks the pin'
    cube = tuple((v, C[pos[v]]) for v in ball2 if v not in pinned)
    jobs.append((cube, f'ball2-{rep}', 'the whole word-distance <= 2 ball', None))
print(f'{len(jobs)} probes ({time.time()-t0:.0f}s)', flush=True)

ledger = f'{OUT}/ladder.jsonl'
done = set()
if os.path.exists(ledger):
    done = {json.loads(l)['tag'] for l in open(ledger)}
todo = [(c, base, nv, ncl, BUDGET, tag, OUT) for c, tag, _, _ in jobs if tag not in done]
meta_by_tag = {tag: (what, cnt, len(c)) for c, tag, what, cnt in jobs}
import multiprocessing as mp
with mp.get_context('fork').Pool(processes=min(4, max(1, len(todo)))) as pool, open(ledger, 'a') as fh:
    for r in pool.imap_unordered(FP.solve_cube, todo, chunksize=1):
        what, cnt, dep = meta_by_tag[r['tag']]
        r.update({'what': what, 'full_pass_cubes': cnt, 'depth': dep, 'cube': None})
        fh.write(json.dumps(r) + '\n'); fh.flush()
        print(f'  {r["tag"]} (depth {dep}, {what}): {r["verdict"]} in {r["wall_seconds"]}s, '
              f'{r["max_rss_kb"]/1048576:.2f} GB  [{time.time()-t0:.0f}s]', flush=True)
print(f'done in {time.time()-t0:.0f}s')
