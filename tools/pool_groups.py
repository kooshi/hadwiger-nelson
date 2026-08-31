#!/usr/bin/env python3
"""Fast cache-group ordering of a pool export, driven by the unit-distance graph, sized from the
machine's cache topology — approximate, non-deterministic across machines, seconds not hours.

(Kooshi, 2026-08-31: "groups don't need to be perfect, or even deterministic, just sized to
cache/page levels — ideally dynamic by environment, as the server's cache will be a different
topology and size.")

Two levels of multi-source BFS Voronoi cells on the unit graph (pool–pool + pool–halo edges):
  L3 cells: K3 = ceil(N / n3) seeds, n3 = L3 bytes ÷ bytes-per-point;
  L2 cells inside each L3 cell: n2 = L2 bytes ÷ bytes-per-point.
Seeds are the highest-degree points spread by a greedy "not within h hops of an existing seed"
rule (a BFS from all chosen seeds at once); every node joins the nearest seed by hops, ties by
seed order. Cells are then ordered L3-major, L2-minor, BFS-order within — so consecutive indices
share a cell at both levels. Sizes are read from sysfs (`/sys/devices/system/cpu/cpu0/cache`)
unless given; bytes-per-point defaults to 1024 (k = 5 colour variables plus watches; measure to
refine). Scored by the internal-edge fraction at the L2 and L3 block sizes.

  python3 tools/pool_groups.py <base> <object-label> [--bytes-per-point 1024] [--l2 BYTES --l3 BYTES]
"""
import argparse, hashlib, json, sys, time
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402

def sysfs_cache():
    out = {}
    root = Path('/sys/devices/system/cpu/cpu0/cache')
    for d in sorted(root.glob('index*')) if root.exists() else []:
        lvl = int((d / 'level').read_text()); typ = (d / 'type').read_text().strip(); sz = (d / 'size').read_text().strip()
        b = int(sz[:-1]) * (1024 if sz.endswith('K') else 1024 ** 2 if sz.endswith('M') else 1)
        if typ in ('Unified', 'Data'): out[lvl] = b
    return out

def csr(N, U, V):
    deg = np.bincount(np.concatenate([U, V]), minlength=N)
    ptr = np.zeros(N + 1, dtype=np.int64); np.cumsum(deg, out=ptr[1:])
    order = np.argsort(np.concatenate([U, V]), kind='stable')
    return ptr, np.concatenate([V, U])[order], deg

def voronoi(N, ptr, nbr, seeds, mask=None, cap=None):
    """Multi-source BFS: label[v] = index of the nearest seed (hops; ties by seed order), order[v] =
    BFS discovery rank. Restricted to nodes where mask is True (others stay unlabeled). With `cap`,
    a cell stops absorbing at `cap` nodes (size-bounded cells: a node whose nearest seeds are all
    full waits for a later frontier from an unfilled cell, or ends unlabeled)."""
    label = -np.ones(N, dtype=np.int64); rank = np.zeros(N, dtype=np.int64)
    label[seeds] = np.arange(len(seeds)); frontier = np.array(seeds, dtype=np.int64); r = 0
    size = np.ones(len(seeds), dtype=np.int64)
    while len(frontier):
        rank[frontier] = np.arange(r, r + len(frontier)); r += len(frontier)
        cnt = ptr[frontier + 1] - ptr[frontier]
        src = np.repeat(frontier, cnt)
        idx = np.concatenate([np.arange(ptr[f], ptr[f + 1]) for f in frontier]) if len(frontier) < 50000 else \
              (np.repeat(ptr[frontier] - np.cumsum(cnt) + cnt, cnt) + np.arange(int(cnt.sum())))
        dst = nbr[idx]
        ok = label[dst] < 0
        if mask is not None: ok &= mask[dst]
        dst, src = dst[ok], src[ok]
        # first arrival wins, ties by the lower seed index: sort by (dst, label[src]) and keep the first
        if len(dst) == 0: break
        o = np.lexsort((label[src], dst)); dst, src = dst[o], src[o]
        if cap is not None:                                          # drop arrivals at full cells
            ok2 = size[label[src]] < cap; dst, src = dst[ok2], src[ok2]
            if len(dst) == 0: break
        first = np.ones(len(dst), dtype=bool); first[1:] = dst[1:] != dst[:-1]
        dst, src = dst[first], src[first]
        if cap is not None:                                          # admit per cell up to the cap, in order
            lab = label[src]; o2 = np.argsort(lab, kind='stable'); dst, src, lab = dst[o2], src[o2], lab[o2]
            start = np.searchsorted(lab, np.arange(len(seeds))); cnt = np.bincount(lab, minlength=len(seeds))
            room = np.maximum(cap - size, 0); take = np.minimum(cnt, room)
            keep = np.zeros(len(dst), dtype=bool)
            for g in np.flatnonzero(take): keep[start[g]:start[g] + take[g]] = True
            dst, src = dst[keep], src[keep]; size += np.bincount(label[src], minlength=len(seeds))
        label[dst] = label[src]; frontier = dst
    return label, rank

def spread_seeds(N, ptr, nbr, deg, K, mask=None):
    """K seeds: highest degree first, each at least `h` hops from the chosen ones, h from the target
    cell radius (BFS balls); falls back to degree order when spacing runs out."""
    cand = np.argsort(-deg, kind='stable')
    if mask is not None: cand = cand[mask[cand]]
    target = (mask.sum() if mask is not None else N) / max(K, 1)
    h = max(1, int(np.log(max(target, 2)) / np.log(6)))   # ~degree-7 growth: a ball of radius h holds ~7^h
    seeds = []; blocked = np.zeros(N, dtype=bool)
    for v in cand:
        if len(seeds) >= K: break
        if blocked[v]: continue
        seeds.append(int(v))
        fr = np.array([v]); blocked[v] = True
        for _ in range(h):
            cnt = ptr[fr + 1] - ptr[fr]
            if cnt.sum() == 0: break
            idx = np.concatenate([np.arange(ptr[f], ptr[f + 1]) for f in fr])
            nx = np.unique(nbr[idx]); nx = nx[~blocked[nx]]
            if mask is not None: nx = nx[mask[nx]]
            blocked[nx] = True; fr = nx
    if len(seeds) < K:
        rest = cand[~np.isin(cand, seeds)][:K - len(seeds)]; seeds.extend(int(v) for v in rest)
    return np.array(seeds, dtype=np.int64)

def main():
    ap = argparse.ArgumentParser(); ap.add_argument('base'); ap.add_argument('label')
    ap.add_argument('--bytes-per-point', type=int, default=1024); ap.add_argument('--l2', type=int); ap.add_argument('--l3', type=int)
    a = ap.parse_args(); base = Path(a.base)
    cache = sysfs_cache(); l2 = a.l2 or cache.get(2, 512 * 1024); l3 = a.l3 or cache.get(3, 32 * 1024 ** 2)
    man = json.loads(Path(str(base) + '.json').read_text()); z0 = np.load(str(base) + '.npz')
    z = {k: (z0[k].astype(np.int64) if k.endswith('_indptr') else z0[k]) for k in z0.files}
    n = man['pool']['n_points']; n_halo = man['object']['n_halo']; N = n + n_halo
    ap_, ai = z['pool_adj_indptr'], z['pool_adj_idx']; r = np.repeat(np.arange(n), np.diff(ap_)); c = ai.astype(np.int64); m = r < c
    hp, hi = z['pool_halo_indptr'], z['pool_halo_idx']; hr = np.repeat(np.arange(n), np.diff(hp)); hc = n + hi.astype(np.int64)
    U = np.concatenate([r[m], hr]); V = np.concatenate([c[m], hc])
    ptr, nbr, deg = csr(N, U, V)
    n3 = max(1000, l3 // a.bytes_per_point); n2 = max(64, l2 // a.bytes_per_point)
    K3 = int(np.ceil(1.5 * N / n3)); t0 = time.time()
    print(f'cache: L2 {l2//1024} KB, L3 {l3//1024**2} MB at {a.bytes_per_point} B/point → L3 cells of ~{n3} points ({K3} seeds), L2 cells of ~{n2}')
    s3 = spread_seeds(N, ptr, nbr, deg, K3); lab3, rank3 = voronoi(N, ptr, nbr, s3, cap=int(1.25 * n3))
    un = np.flatnonzero(lab3 < 0)
    if len(un):                                                   # isolated / unreached nodes: their own trailing cell
        lab3[un] = K3; print(f'  {len(un)} nodes unreached by any seed → trailing cell')
    sizes = np.bincount(lab3); print(f'  L3 cells: {len(sizes)}, sizes median {int(np.median(sizes))}, max {sizes.max()}, {time.time()-t0:.1f} s')
    lab2 = np.zeros(N, dtype=np.int64); rank2 = np.zeros(N, dtype=np.int64); off = 0
    for g in range(lab3.max() + 1):
        mask = lab3 == g; cnt = int(mask.sum()); K2 = max(1, int(np.ceil(1.5 * cnt / n2)))
        s2 = spread_seeds(N, ptr, nbr, deg, K2, mask=mask); l, rk = voronoi(N, ptr, nbr, s2, mask=mask, cap=int(1.25 * n2))
        l[(l < 0) & mask] = K2
        lab2[mask] = off + l[mask]; rank2[mask] = rk[mask]; off += K2 + 1
    print(f'  L2 cells: {off}, {time.time()-t0:.1f} s')
    order = np.lexsort((rank2, lab2, lab3)); pos = np.empty(N, dtype=np.int64); pos[order] = np.arange(N)
    def internal(p, B): return float(np.mean((p[U] // B) == (p[V] // B)))
    raw = np.arange(N)
    print('internal-edge fraction (block = cache level in points):')
    for nm, p in (('raw', raw), ('groups', pos)):
        print(f'  {nm:7s} L2 block {n2:>6}: {internal(p, n2):.3f}   L3 block {n3:>7}: {internal(p, n3):.3f}   4096: {internal(p, 4096):.3f}   32768: {internal(p, 32768):.3f}')
    # write the export (pool points only, in group order; halo order is fixed by the object)
    pool_perm = order[order < n]; inv = np.empty(n, dtype=np.int64); inv[pool_perm] = np.arange(n)
    def permute_rows(indptr, idx, remap):
        rows = [idx[indptr[i]:indptr[i+1]] for i in range(n)]
        newL = [np.sort(remap(rows[pool_perm[k]])) for k in range(n)]
        ip = np.zeros(n + 1, dtype=np.uint64)
        for k, rr in enumerate(newL): ip[k+1] = ip[k] + len(rr)
        return ip, (np.concatenate(newL) if ip[-1] else np.array([], dtype=idx.dtype)).astype(idx.dtype)
    A = {}
    A['pool_seed_indptr'], A['pool_seed_idx'] = permute_rows(z['pool_seed_indptr'], z['pool_seed_idx'], lambda x: x)
    A['pool_halo_indptr'], A['pool_halo_idx'] = permute_rows(z['pool_halo_indptr'], z['pool_halo_idx'], lambda x: x)
    A['pool_adj_indptr'], A['pool_adj_idx'] = permute_rows(z['pool_adj_indptr'], z['pool_adj_idx'], lambda x: inv[x.astype(np.int64)])
    for k in ('halo_seed_indptr', 'halo_seed_idx', 'halo_adj_indptr', 'halo_adj_idx'): A[k] = z0[k]
    A['pool_prov'] = z['pool_prov'][pool_perm]; A['pool_xy'] = z['pool_xy'][pool_perm]
    obj, _ = BK.load_object(a.label)
    fp = BK._pool_fp(obj, man['pool']['name'], man['pool']['params'], [tuple(p) for p in A['pool_xy'].tolist()])
    out = Path(str(base) + '-groups'); np.savez(str(out) + '.npz', **A)
    m2 = json.loads(json.dumps(man)); m2['pool']['fingerprint'] = fp; m2['pool']['ordering'] = 'by-depth'
    m2['arrays'] = {k: {'dtype': str(v.dtype), 'shape': list(v.shape), 'sha256': hashlib.sha256(np.ascontiguousarray(v).tobytes()).hexdigest()} for k, v in A.items()}
    m2['derived_from'] = {'manifest': base.name + '.json', 'pool_fingerprint': man['pool']['fingerprint'], 'permutation': out.name + '-perm.npy',
                          'ordering_note': f'cache-groups L3~{n3}/L2~{n2} points at {a.bytes_per_point} B/point (L2 {l2}, L3 {l3} bytes)'}
    Path(str(out) + '.json').write_text(json.dumps(m2, indent=1)); np.save(str(out) + '-perm.npy', pool_perm)
    print(f'wrote {out}.{{json,npz}}: pool fp {fp}; total {time.time()-t0:.1f} s')

if __name__ == '__main__':
    main()
