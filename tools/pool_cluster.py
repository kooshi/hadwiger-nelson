#!/usr/bin/env python3
"""Cache-group ordering of a pool export, driven by the UNIT-DISTANCE GRAPH alone.

(Kooshi, 2026-08-31: "the vast majority of points near a point are not at all useful to it …
the algo really needs to prioritize the unit distance edges, maybe greedily seeding groups with
points with high connectivity.")  A point's cache neighbours should be its unit neighbours, not
its spatial ones: groups of B consecutive indices are grown greedily — seed = the highest-degree
unassigned point; repeatedly add the unassigned point with the most unit edges INTO the group
(ties by degree) until the group holds B points; then the next seed. Edges are pool–pool plus
pool–halo (halo points are solver variables too); seed vertices are pinned per ask and ignored.

The currency is `internal(B)` = the fraction of unit edges whose endpoints lie in the same
B-block of the ordering — what a cache level of B points' state actually holds — reported for
every ordering the campaign has (raw, rcm, morton, greedy) at several B, and the greedy export
is written as `<base>-greedy.{json,npz}` with fingerprints recomputed. Same point set ⇒ every
per-class verdict must equal the raw export's (the control).
"""
import hashlib, heapq, json, sys, time
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402

def load(base):
    man = json.loads(Path(str(base) + '.json').read_text()); z0 = np.load(str(base) + '.npz')
    z = {k: (z0[k].astype(np.int64) if k.endswith('_indptr') else z0[k]) for k in z0.files}
    return man, z

def edges_of(man, z):
    n = man['pool']['n_points']; n_halo = man['object']['n_halo']
    ap, ai = z['pool_adj_indptr'], z['pool_adj_idx']
    r = np.repeat(np.arange(n), np.diff(ap)); c = ai.astype(np.int64)
    m = r < c                                                   # each pool–pool edge once
    hp, hi = z['pool_halo_indptr'], z['pool_halo_idx']
    hr = np.repeat(np.arange(n), np.diff(hp)); hc = n + hi.astype(np.int64)
    return n, n_halo, np.concatenate([r[m], hr]), np.concatenate([c[m], hc])

def internal_fraction(pos, U, V, B):
    """pos: node -> position in the ordering (pool and halo nodes); B: block size in nodes."""
    return float(np.mean((pos[U] // B) == (pos[V] // B)))

def greedy_groups(N, U, V, B):
    """Greedy cache groups over N nodes with undirected edges (U,V)."""
    deg = np.bincount(np.concatenate([U, V]), minlength=N)
    order_idx = np.argsort(np.concatenate([U, V]), kind='stable')
    nbr_ptr = np.zeros(N + 1, dtype=np.int64); np.cumsum(deg, out=nbr_ptr[1:])
    nbr = np.concatenate([V, U])[order_idx]
    # pure-Python inner loop on Python ints (numpy scalars cost ~10x per op here)
    nbr_l = nbr.tolist(); ptr_l = nbr_ptr.tolist(); deg_l = deg.tolist()
    assigned = bytearray(N); gain = [0] * N
    perm = [0] * N; k = 0
    seeds = np.argsort(-deg, kind='stable').tolist(); si = 0
    heap = []; push = heapq.heappush; pop = heapq.heappop
    while k < N:
        while si < N and assigned[seeds[si]]: si += 1
        s = seeds[si]; size = 0
        heap = [(0, -deg_l[s], s)]
        while size < B and heap:
            g, _, v = pop(heap)
            if assigned[v] or -g != gain[v]:
                continue                                      # stale entry
            assigned[v] = 1; perm[k] = v; k += 1; size += 1
            for w in nbr_l[ptr_l[v]:ptr_l[v + 1]]:
                if not assigned[w]:
                    gain[w] += 1
                    push(heap, (-gain[w], -deg_l[w], w))
    return np.array(perm, dtype=np.int64)

def main():
    base = Path(sys.argv[1]); obj_label = sys.argv[2]; B = int(sys.argv[3]) if len(sys.argv) > 3 else 4096
    man, z = load(base); n, n_halo, U, V = edges_of(man, z); N = n + n_halo
    print(f'{n} pool + {n_halo} halo nodes, {len(U)} unit edges (pool–pool + pool–halo)')
    # score the existing orderings: raw, and any sibling exports (rcm, morton)
    cands = {'raw': np.arange(N)}
    for nm in ('rcm', 'morton'):
        pp = Path(str(base) + f'-{nm}-perm.npy')
        if pp.exists():
            perm = np.load(pp); pos = np.empty(N, dtype=np.int64); pos[perm] = np.arange(n); pos[n:] = np.arange(n, N)
            cands[nm] = pos
    t0 = time.time(); perm = greedy_groups(N, U, V, B); print(f'greedy groups of {B}: {time.time()-t0:.0f} s')
    pos = np.empty(N, dtype=np.int64); pos[perm] = np.arange(N); cands['greedy'] = pos
    print('internal-edge fraction by block size (higher = more unit material per cache group):')
    print('  ordering ' + ' '.join(f'{b:>8}' for b in (512, 2048, 8192, 32768, 131072)))
    for nm, p in cands.items():
        print(f'  {nm:<8} ' + ' '.join(f'{internal_fraction(p, U, V, b):8.3f}' for b in (512, 2048, 8192, 32768, 131072)))
    # write the greedy export: pool points in greedy order (halo positions are fixed by the object)
    pool_perm = perm[perm < n]                                   # new pool index -> old
    inv = np.empty(n, dtype=np.int64); inv[pool_perm] = np.arange(n)
    def permute_rows(indptr, idx, remap):
        rows = [idx[indptr[i]:indptr[i+1]] for i in range(n)]
        newL = [np.sort(remap(rows[pool_perm[k]])) for k in range(n)]
        ip = np.zeros(n + 1, dtype=np.uint64)
        for k, r in enumerate(newL): ip[k+1] = ip[k] + len(r)
        return ip, (np.concatenate(newL) if ip[-1] else np.array([], dtype=idx.dtype)).astype(idx.dtype)
    arrays = {}
    arrays['pool_seed_indptr'], arrays['pool_seed_idx'] = permute_rows(z['pool_seed_indptr'], z['pool_seed_idx'], lambda r: r)
    arrays['pool_halo_indptr'], arrays['pool_halo_idx'] = permute_rows(z['pool_halo_indptr'], z['pool_halo_idx'], lambda r: r)
    arrays['pool_adj_indptr'], arrays['pool_adj_idx'] = permute_rows(z['pool_adj_indptr'], z['pool_adj_idx'], lambda r: inv[r.astype(np.int64)])
    for k in ('halo_seed_indptr', 'halo_seed_idx', 'halo_adj_indptr', 'halo_adj_idx'):
        arrays[k] = np.load(str(base) + '.npz')[k]
    arrays['pool_prov'] = z['pool_prov'][pool_perm]; arrays['pool_xy'] = z['pool_xy'][pool_perm]
    obj, _ = BK.load_object(obj_label)
    fp = BK._pool_fp(obj, man['pool']['name'], man['pool']['params'], [tuple(p) for p in arrays['pool_xy'].tolist()])
    out = Path(str(base) + '-greedy'); np.savez(str(out) + '.npz', **arrays)
    man2 = json.loads(json.dumps(man)); man2['pool']['fingerprint'] = fp; man2['pool']['ordering'] = 'by-depth'  # the engine validates this word; the locality note goes below
    man2['arrays'] = {k: {'dtype': str(v.dtype), 'shape': list(v.shape), 'sha256': hashlib.sha256(np.ascontiguousarray(v).tobytes()).hexdigest()} for k, v in arrays.items()}
    man2['derived_from'] = {'manifest': base.name + '.json', 'pool_fingerprint': man['pool']['fingerprint'], 'permutation': out.name + '-perm.npy', 'ordering_note': f'greedy-groups-{B}'}
    Path(str(out) + '.json').write_text(json.dumps(man2, indent=1)); np.save(str(out) + '-perm.npy', pool_perm)
    print(f'wrote {out}.{{json,npz}}: pool fp {fp}')

if __name__ == '__main__':
    main()
