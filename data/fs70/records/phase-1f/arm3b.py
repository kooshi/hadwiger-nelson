#!/usr/bin/env python3
"""arm 3b: the k = 5 ball's degree distribution, measured on a sample of its points over ALL 132 unit vectors
of the lattice that fit inside it -- not just the 84 generators.

The generator-edge count in arm3.json is exact but it is a LOWER bound on the edge count: in the k = 4 ball
1.97 % of the edges come from unit vectors that are not generators, and at k = 5 forty-eight more of the
lattice's 324 unit vectors become expressible, so that share must rise.  This measures it.

Still a lower bound, by the same argument one level up: a unit vector of word-length >= 6 can join two points
of the k = 5 ball without itself lying in it.  In the k = 4 ball that residue was 1.97 % of the edges.
"""
import json, sys, time
import numpy as np
sys.path.insert(0, 'tools')
from fs70_price_cubes import load_cache, _void

OUT = 'build/fs70/1f'
t0 = time.time()
pts, ind, ptr, meta = load_cache(OUT, fast=False)
n, M = meta['n'], meta['meta']['M']
S5 = np.load(f'{OUT}/shell5.npy').astype(np.int64)
G = pts[np.sort(ind[ptr[0]:ptr[1]])]
B = np.array([1.0, np.sqrt(3.0), np.sqrt(5.0), np.sqrt(15.0)])
def norm2(Q):
    x = Q[:, :4] @ B; y = Q[:, 4:] @ B
    return (x * x + y * y) / (M * M)
U5 = S5[np.abs(norm2(S5) - 1) < 1e-9]
U = np.concatenate([G, U5])
assert len(U) == 132, len(U)
assert np.abs(norm2(U) - 1).max() < 1e-9
# the unit-vector set must be symmetric, or the degree count double-counts wrongly
Uk = set(_void(U).tolist()); negk = set(_void(-U).tolist())
print(f'{len(U)} unit vectors inside the k=5 ball; symmetric (-U = U): {Uk == negk}')

K5 = np.concatenate([pts, S5])
keys = _void(K5); skeys = np.sort(keys)
nk5 = len(K5)
print(f'k=5 ball: {nk5:,} points ({time.time()-t0:.0f}s)', flush=True)

def inball(Q):
    k = _void(Q); pos = np.clip(np.searchsorted(skeys, k), 0, len(skeys) - 1)
    return skeys[pos] == k

rng = np.random.default_rng(20260922)
res = {}
for name, pool, frac in (('shell<=4 (the old k=4 ball)', np.arange(n), 0.02),
                         ('shell 5', np.arange(n, nk5), 0.01)):
    sel = rng.choice(len(pool), size=int(frac * len(pool)), replace=False)
    degs = []
    for s in range(0, len(sel), 4000):
        blk = K5[pool[sel[s:s + 4000]]]
        cand = (blk[:, None, :] + U[None, :, :]).reshape(-1, 8)
        hit = inball(cand).reshape(len(blk), len(U))
        degs.append(hit.sum(axis=1))
    d = np.concatenate(degs)
    res[name] = {'sampled': int(len(d)), 'fraction': frac, 'mean_degree': round(float(d.mean()), 3),
                 'min': int(d.min()), 'max': int(d.max()),
                 'ge13': round(float((d >= 13).mean()), 4), 'ge14': round(float((d >= 14).mean()), 4),
                 'ge16': round(float((d >= 16).mean()), 4), 'ge18': round(float((d >= 18).mean()), 4)}
    print(f'  {name}: mean {d.mean():.3f}, min {d.min()}, max {d.max()}, '
          f'P(deg>=14) = {(d>=14).mean():.4f} ({time.time()-t0:.0f}s)', flush=True)

a = res['shell<=4 (the old k=4 ball)']['mean_degree'] * n
b = res['shell 5']['mean_degree'] * (nk5 - n)
res['k5_mean_degree'] = round((a + b) / nk5, 3)
res['k5_edges_lower_bound'] = int(round((a + b) / 2))
res['k5_points'] = int(nk5)
res['unit_vectors_inside_k5'] = int(len(U))
res['note'] = ('a lower bound: unit vectors of word-length >= 6 can still join two k=5 points; in the k=4 '
               'ball that residue was 1.97 % of the edges')
print(json.dumps(res, indent=1))
json.dump(res, open(f'{OUT}/arm3b.json', 'w'), indent=1)
print(f'done in {time.time()-t0:.0f}s')
