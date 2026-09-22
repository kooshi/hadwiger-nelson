#!/usr/bin/env python3
"""arm 3c: is there a SMALLER shape at the k = 5 ball's degree?

The k = 5 ball reaches mean degree 19.2 but costs 29 M points.  Its degree rose because 48 more of the
lattice's 324 unit vectors became expressible.  So take those 132 unit vectors as the GENERATOR SET and build
a word ball in that metric instead: the same lattice, the same unit-distance graph, a different shape.  A
radius-r ball there is contained in the old radius-5r ball, but it is built to hold unit vectors rather than
volume, so it should reach the same degree at a fraction of the size.

No solver.  Sizes and degrees only; the point is to price a shape, not to ask it.
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
G84 = pts[np.sort(ind[ptr[0]:ptr[1]])]
B = np.array([1.0, np.sqrt(3.0), np.sqrt(5.0), np.sqrt(15.0)])
def norm2(Q):
    x = Q[:, :4] @ B; y = Q[:, 4:] @ B
    return (x * x + y * y) / (M * M)
U = np.concatenate([G84, S5[np.abs(norm2(S5) - 1) < 1e-9]])
assert len(U) == 132 and set(_void(U).tolist()) == set(_void(-U).tolist())
print(f'generator set: {len(U)} unit vectors (the 84 of word-length 1 plus the 48 of word-length 5)')

rows = []
cur = np.zeros((1, 8), dtype=np.int64)
ball = cur.copy()
bkeys = np.sort(_void(ball))
for r in range(1, 5):
    acc = []
    for s in range(0, len(cur), 20000):
        blk = cur[s:s + 20000]
        cand = (blk[:, None, :] + U[None, :, :]).reshape(-1, 8)
        k = _void(cand)
        pos = np.clip(np.searchsorted(bkeys, k), 0, len(bkeys) - 1)
        acc.append(np.unique(k[bkeys[pos] != k]))
        if len(acc) >= 16:
            acc = [np.unique(np.concatenate(acc))]
    newk = np.unique(np.concatenate(acc))
    new = np.frombuffer(newk.tobytes(), dtype=np.int16).reshape(-1, 8).astype(np.int64)
    ball = np.concatenate([ball, new])
    bkeys = np.sort(_void(ball))
    cur = new
    # degree over the 132 unit vectors, on a sample (exact for small balls)
    frac = 1.0 if len(ball) <= 300000 else 0.01
    rng = np.random.default_rng(20260922)
    sel = np.arange(len(ball)) if frac == 1.0 else rng.choice(len(ball), size=int(frac * len(ball)),
                                                              replace=False)
    degs = []
    for s in range(0, len(sel), 4000):
        blk = ball[sel[s:s + 4000]]
        cand = (blk[:, None, :] + U[None, :, :]).reshape(-1, 8)
        k = _void(cand)
        pos = np.clip(np.searchsorted(bkeys, k), 0, len(bkeys) - 1)
        degs.append((bkeys[pos] == k).reshape(len(blk), len(U)).sum(axis=1))
    d = np.concatenate(degs)
    row = {'radius': r, 'points': int(len(ball)), 'shell': int(len(new)),
           'boundary_share': round(len(new) / len(ball), 4),
           'degree_sampled_fraction': frac, 'mean_degree': round(float(d.mean()), 3),
           'min': int(d.min()), 'max': int(d.max()),
           'edges_lower_bound': int(round(float(d.mean()) * len(ball) / 2)),
           'seconds': round(time.time() - t0, 1)}
    rows.append(row)
    print(f'  radius {r}: {len(ball):,} points, mean degree {d.mean():.3f} '
          f'(min {d.min()}, max {d.max()}), boundary {100*len(new)/len(ball):.1f} % '
          f'[{time.time()-t0:.0f}s]', flush=True)
    if len(ball) > 12_000_000:
        print('  stopping: past the size that could be an affordable ask')
        break
json.dump({'generators': int(len(U)), 'rows': rows}, open(f'{OUT}/arm3c.json', 'w'), indent=1)
print(f'done in {time.time()-t0:.0f}s')
