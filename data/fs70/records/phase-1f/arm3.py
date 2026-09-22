#!/usr/bin/env python3
"""arm 3, completed: the k=4 ball's degree and core profile by word-distance shell, and the k=5 ball's edge
count.  Scratch script (build/ is regenerable); its numbers go into data/fs70/records/phase-1f.md."""
import json, sys, time
import numpy as np
sys.path.insert(0, 'tools')
from fs70_price_cubes import load_cache, _void

OUT = 'build/fs70/1f'
t0 = time.time()
pts, ind, ptr, meta = load_cache(OUT, fast=False)
n, M = meta['n'], meta['meta']['M']
P = pts
G = P[np.sort(ind[ptr[0]:ptr[1]])]
keys = _void(P); order = np.argsort(keys, kind='stable'); skeys = keys[order]

def inball(Q):
    k = _void(Q); pos = np.clip(np.searchsorted(skeys, k), 0, len(skeys) - 1)
    return skeys[pos] == k

# ---- word-distance shells (recomputed; 7 s)
dist = np.full(n, -1, dtype=np.int8); dist[0] = 0
frontier = np.array([0], dtype=np.int64)
for d in range(1, 5):
    found = []
    for s in range(0, len(frontier), 40000):
        blk = P[frontier[s:s + 40000]]
        cand = (blk[:, None, :] + G[None, :, :]).reshape(-1, 8)
        k = _void(cand); pos = np.clip(np.searchsorted(skeys, k), 0, len(skeys) - 1)
        hit = skeys[pos] == k
        found.append(np.unique(order[pos[hit]]))
    nf = np.unique(np.concatenate(found)); nf = nf[dist[nf] < 0]
    dist[nf] = d; frontier = nf
deg = np.diff(ptr)
print(f'shells recomputed in {time.time()-t0:.0f}s')

res = {'k4_degree_by_shell': {}, 'k4_core_profile': {}, 'k5': {}}
for s in range(5):
    m = dist == s
    res['k4_degree_by_shell'][s] = {'points': int(m.sum()), 'mean_degree': round(float(deg[m].mean()), 3),
                                    'min': int(deg[m].min()), 'max': int(deg[m].max())}
print('k=4 degree by shell:', json.dumps(res['k4_degree_by_shell']))

# ---- the k=4 ball's core profile (the control: phase 1e records max core number 12)
def core_numbers(nn, indices, indptr):
    """every vertex's core number in ONE pass (peel the smallest degree first, bucket queue), so every k-core
    follows by a threshold instead of one peel per k."""
    import array
    I = array.array('i', np.ascontiguousarray(indices, dtype=np.int32).tobytes())
    Pp = array.array('q', np.ascontiguousarray(indptr, dtype=np.int64).tobytes())
    d = array.array('i', np.diff(indptr).astype(np.int32).tobytes())
    mx = max(d)
    bins = [[] for _ in range(mx + 1)]
    for v in range(nn):
        bins[d[v]].append(v)
    core = array.array('i', bytes(4 * nn))
    removed = bytearray(nn)
    cur = 0
    done = 0
    while done < nn:
        while cur <= mx and not bins[cur]:
            cur += 1
        v = bins[cur].pop()
        if removed[v] or d[v] != cur:
            continue
        removed[v] = 1
        core[v] = cur
        done += 1
        for j in range(Pp[v], Pp[v + 1]):
            w = I[j]
            if not removed[w] and d[w] > cur:
                d[w] -= 1
                bins[d[w]].append(w)
        if cur > 0:
            cur -= 1
    return np.frombuffer(core, dtype=np.int32)

cn = core_numbers(n, ind, ptr)
np.save(f'{OUT}/corenum.npy', cn)
print(f'core numbers in {time.time()-t0:.0f}s; max core number = {int(cn.max())}')
for k in (6, 10, 12, 13, 14, 16):
    live = int((cn >= k).sum())
    res['k4_core_profile'][k] = {'points': live}
    print(f'  {k}-core: {live:,} points')
res['k4_max_core_number'] = int(cn.max())
res['k4_core_number_by_shell'] = {s: {'mean': round(float(cn[dist == s].mean()), 3),
                                      'max': int(cn[dist == s].max())} for s in range(5)}

# ---- the k=5 ball: shell 5, then its edge count
acc = []
sh4 = np.nonzero(dist == 4)[0]
leaving = 0
for s in range(0, len(sh4), 40000):
    blk = P[sh4[s:s + 40000]]
    cand = (blk[:, None, :] + G[None, :, :]).reshape(-1, 8)
    outr = cand[~inball(cand)]
    leaving += len(outr)
    acc.append(np.unique(_void(outr)))
    if len(acc) >= 24:
        acc = [np.unique(np.concatenate(acc))]
sh5keys = np.unique(np.concatenate(acc))
S5 = np.frombuffer(sh5keys.tobytes(), dtype=np.int16).reshape(-1, 8).astype(np.int64)
np.save(f'{OUT}/shell5.npy', S5.astype(np.int16))
print(f'shell 5: {len(S5):,} points, {leaving:,} incidences from shell 4 ({time.time()-t0:.0f}s)', flush=True)

# X = # (p, g) with p and p+g both in shell 5, estimated from a 5% sample of shell 5.
# UNBIASED, unlike the distinct-point estimator: it is a sum over parents, not a count of distinct children.
s5sorted = np.sort(sh5keys)
rng = np.random.default_rng(20260922)
frac = 0.05
sel = rng.choice(len(S5), size=int(frac * len(S5)), replace=False)
hits = 0
for s in range(0, len(sel), 40000):
    blk = S5[sel[s:s + 40000]]
    cand = (blk[:, None, :] + G[None, :, :]).reshape(-1, 8)
    k = _void(cand); pos = np.clip(np.searchsorted(s5sorted, k), 0, len(s5sorted) - 1)
    hits += int((s5sorted[pos] == k).sum())
X = hits / frac
twoE = 84 * n + leaving + X                       # 2 * (generator edges of the k=5 ball)
nk5 = n + len(S5)
res['k5'] = {'points': int(nk5), 'shell5': int(len(S5)),
             'shell4_incidences_into_shell5': int(leaving),
             'shell5_internal_incidences_sampled_at': frac, 'shell5_internal_incidences': int(round(X)),
             'generator_edges': int(round(twoE / 2)),
             'mean_generator_degree': round(twoE / nk5, 3),
             'k4_generator_edges': int((84 * n - leaving) // 2),
             'k4_mean_generator_degree': round((84 * n - leaving) / n, 3),
             'k4_mean_degree_all_edges': round(2 * meta['m'] / n, 3),
             'non_generator_edge_share_k4': round(1 - (84 * n - leaving) / 2 / meta['m'], 5)}
print(json.dumps(res['k5'], indent=1))
json.dump(res, open(f'{OUT}/arm3.json', 'w'), indent=1)
print(f'done in {time.time()-t0:.0f}s')
