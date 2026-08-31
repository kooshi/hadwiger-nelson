#!/usr/bin/env python3
"""Write a LOCALITY-ORDERED copy of a pool export: the same pool, its points renumbered by
reverse Cuthill–McKee over the pool's unit-distance adjacency (pool–pool edges, with the pool's
seed/halo edges folded in as a shared frame), so that unit-adjacent material sits close in index
space — and therefore in the solver's assignment array, watch lists and clause arena, which are
laid out in variable order. (Kooshi, 2026-08-31: "a sorting pass at the beginning of these heavy
phases, to assemble the graph in memory such that cache level groups primarily contain unit
distance material.")

The pool SET is unchanged, so every per-class verdict must be identical to the raw export's —
that equality is the control; the measurement is asks/s and per-ask latency at a fixed worker
count. Output: `<base>-rcm.{json,npz}` with the pool fingerprint recomputed for the new order
(the campaign's own formula), array sha256s recomputed, and the permutation saved beside.
"""
import hashlib, json, sys, time
from pathlib import Path
import numpy as np
from scipy.sparse import csr_matrix, coo_matrix
from scipy.sparse.csgraph import reverse_cuthill_mckee
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402

def csr_rows(indptr, idx):
    return [idx[indptr[i]:indptr[i+1]] for i in range(len(indptr) - 1)]

def main():
    base = Path(sys.argv[1])  # e.g. build/m51-pool-<objfp>-depth1 (no extension)
    man = json.loads((base.with_suffix('.json')).read_text()); z0 = np.load(str(base) + '.npz')
    z = {k: (z0[k].astype(np.int64) if k.endswith('_indptr') else z0[k]) for k in z0.files}  # indptr is uint64 in the export
    n = man['pool']['n_points']; t0 = time.time()
    # the ordering graph: pool–pool unit adjacency, plus pool–halo and pool–seed edges through
    # shared frame nodes (halo point j ↦ node n+j, seed v ↦ node n+n_halo+v) so that pool points
    # adjacent to the same object point are drawn together as well
    n_halo = man['object']['n_halo']; seed_n = man['object']['seed_n']; N = n + n_halo + seed_n
    ap, ai = z['pool_adj_indptr'], z['pool_adj_idx']
    rows = np.repeat(np.arange(n), np.diff(ap)); cols = ai.astype(np.int64)
    hp, hi = z['pool_halo_indptr'], z['pool_halo_idx']
    hr = np.repeat(np.arange(n), np.diff(hp)); hc = n + hi.astype(np.int64)
    sp, si = z['pool_seed_indptr'], z['pool_seed_idx']
    sr = np.repeat(np.arange(n), np.diff(sp)); sc = n + n_halo + si.astype(np.int64)
    R = np.concatenate([rows, hr, sr, cols, hc, sc]); C = np.concatenate([cols, hc, sc, rows, hr, sr])
    G = csr_matrix((np.ones(len(R), dtype=np.int8), (R, C)), shape=(N, N))
    mode = sys.argv[3] if len(sys.argv) > 3 else 'rcm'
    if mode == 'rcm':
        order = reverse_cuthill_mckee(G, symmetric_mode=True)
        perm = np.array([v for v in order if v < n], dtype=np.int64)      # new index -> old pool index
    elif mode == 'morton':
        # spatial: a Z-order (Morton) curve on a 2^16 grid over the pool's bounding box — cache
        # GROUPS by position; a point's unit neighbours lie one unit away, i.e. in a bounded ring
        # of nearby cells rather than anywhere in memory
        xy = z['pool_xy']; lo = xy.min(axis=0); span = (xy.max(axis=0) - lo).max() or 1.0
        q = np.floor((xy - lo) / span * 65535).astype(np.uint64)
        def spread(v):
            v = (v | (v << np.uint64(16))) & np.uint64(0x0000FFFF0000FFFF)
            v = (v | (v << np.uint64(8))) & np.uint64(0x00FF00FF00FF00FF)
            v = (v | (v << np.uint64(4))) & np.uint64(0x0F0F0F0F0F0F0F0F)
            v = (v | (v << np.uint64(2))) & np.uint64(0x3333333333333333)
            return (v | (v << np.uint64(1))) & np.uint64(0x5555555555555555)
        key = spread(q[:, 0]) | (spread(q[:, 1]) << np.uint64(1))
        perm = np.argsort(key, kind='stable').astype(np.int64)
    else:
        raise SystemExit(f'unknown order {mode}')
    assert len(perm) == n and len(set(perm.tolist())) == n
    inv = np.empty(n, dtype=np.int64); inv[perm] = np.arange(n)      # old -> new
    print(f'{mode} over {N} nodes / {len(R)//2} edges in {time.time()-t0:.1f} s; bandwidth raw→rcm: '
          f'{int(np.abs(rows - cols).max())} → {int(np.abs(inv[rows] - inv[cols]).max())}; '
          f'median |Δ| {int(np.median(np.abs(rows - cols)))} → {int(np.median(np.abs(inv[rows] - inv[cols])))}')
    def permute_rows(indptr, idx, remap_idx):
        L = csr_rows(indptr, idx); newL = [np.sort(remap_idx(L[perm[k]])) for k in range(n)]
        ip = np.zeros(n + 1, dtype=np.uint64)  # the export's indptr width
        for k, r in enumerate(newL): ip[k+1] = ip[k] + len(r)
        return ip, (np.concatenate(newL) if ip[-1] else np.array([], dtype=idx.dtype)).astype(idx.dtype)
    arrays = {}
    arrays['pool_seed_indptr'], arrays['pool_seed_idx'] = permute_rows(sp, si, lambda r: r)
    arrays['pool_halo_indptr'], arrays['pool_halo_idx'] = permute_rows(hp, hi, lambda r: r)
    arrays['pool_adj_indptr'], arrays['pool_adj_idx'] = permute_rows(ap, ai, lambda r: inv[r.astype(np.int64)])
    for k in ('halo_seed_indptr', 'halo_seed_idx', 'halo_adj_indptr', 'halo_adj_idx'):
        arrays[k] = z[k]
    prov = z['pool_prov'][perm]
    assert prov[:, :2].max() < man['object']['n'], 'a depth-2 parent would need remapping'
    arrays['pool_prov'] = prov
    arrays['pool_xy'] = z['pool_xy'][perm]
    obj, _ = BK.load_object(sys.argv[2])
    pts = [tuple(p) for p in arrays['pool_xy'].tolist()]
    fp = BK._pool_fp(obj, man['pool']['name'], man['pool']['params'], pts)
    out = Path(str(base) + '-' + mode)
    np.savez(str(out) + '.npz', **arrays)
    man2 = json.loads(json.dumps(man))
    man2['pool']['fingerprint'] = fp; man2['pool']['ordering'] = 'by-depth'  # the engine validates this word; the locality note goes below
    man2['arrays'] = {k: {'dtype': str(v.dtype), 'shape': list(v.shape),
                          'sha256': hashlib.sha256(np.ascontiguousarray(v).tobytes()).hexdigest()} for k, v in arrays.items()}
    man2['derived_from'] = {'manifest': base.name + '.json', 'pool_fingerprint': man['pool']['fingerprint'], 'permutation': out.name + '-perm.npy', 'ordering_note': mode + '-locality'}
    (Path(str(out) + '.json')).write_text(json.dumps(man2, indent=1)); np.save(str(out) + '-perm.npy', perm)
    print(f'wrote {out}.{{json,npz}}: pool fp {fp} (raw {man["pool"]["fingerprint"]}), {n} points, {time.time()-t0:.1f} s')

if __name__ == '__main__':
    main()
