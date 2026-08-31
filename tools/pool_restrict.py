#!/usr/bin/env python3
"""Write a RESTRICTED copy of a pool export — a subset of its points, with every array filtered
consistently — as a named POOL CHOICE for the profile (a smaller pool can only make `survives`
more likely, so its verdicts are conservative for the hitting set; kills found in it are kills in
the full pool by monotonicity). Criteria: `nobj>=K` (object-neighbour count), `pdeg>=D`
(pool–pool unit degree), joined by `|`.

  python3 tools/pool_restrict.py <base> <object-label> <name> 'nobj>=3|pdeg>=16'
"""
import hashlib, json, sys
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402

base, label, name, crit = Path(sys.argv[1]), sys.argv[2], sys.argv[3], sys.argv[4]
man = json.loads(Path(str(base) + '.json').read_text()); z0 = np.load(str(base) + '.npz')
z = {k: (z0[k].astype(np.int64) if k.endswith('_indptr') else z0[k]) for k in z0.files}
n = man['pool']['n_points']
nobj = np.diff(z['pool_seed_indptr']) + np.diff(z['pool_halo_indptr']); pdeg = np.diff(z['pool_adj_indptr'])
keep = np.zeros(n, dtype=bool)
for term in crit.split('|'):
    var, k = term.split('>='); arr = {'nobj': nobj, 'pdeg': pdeg}[var]; keep |= arr >= int(k)
old_idx = np.flatnonzero(keep); new_of = -np.ones(n, dtype=np.int64); new_of[old_idx] = np.arange(len(old_idx))
def rows(ip, ix): return [ix[ip[i]:ip[i+1]] for i in range(n)]
def refilter(ip, ix, remap):
    R = rows(ip, ix); out = []
    for o in old_idx:
        r = remap(R[o]); out.append(np.sort(r))
    nip = np.zeros(len(old_idx) + 1, dtype=np.uint64)
    for k, r in enumerate(out): nip[k+1] = nip[k] + len(r)
    return nip, (np.concatenate(out) if nip[-1] else np.array([], dtype=ix.dtype)).astype(ix.dtype)
A = {}
A['pool_seed_indptr'], A['pool_seed_idx'] = refilter(z['pool_seed_indptr'], z['pool_seed_idx'], lambda r: r)
A['pool_halo_indptr'], A['pool_halo_idx'] = refilter(z['pool_halo_indptr'], z['pool_halo_idx'], lambda r: r)
def adj_remap(r):
    m = new_of[r.astype(np.int64)]; return m[m >= 0]
A['pool_adj_indptr'], A['pool_adj_idx'] = refilter(z['pool_adj_indptr'], z['pool_adj_idx'], adj_remap)
for k in ('halo_seed_indptr', 'halo_seed_idx', 'halo_adj_indptr', 'halo_adj_idx'): A[k] = z0[k]
A['pool_prov'] = z['pool_prov'][old_idx]; A['pool_xy'] = z['pool_xy'][old_idx]
obj, _ = BK.load_object(label)
params = {'restrict': crit}
fp = BK._pool_fp(obj, name, params, [tuple(p) for p in A['pool_xy'].tolist()])
out = Path(str(base) + '-' + name); np.savez(str(out) + '.npz', **A)
m2 = json.loads(json.dumps(man)); m2['pool'].update({'fingerprint': fp, 'name': name, 'params': params, 'n_points': int(len(old_idx)), 'ordering': 'by-depth (restricted)'})
m2['arrays'] = {k: {'dtype': str(v.dtype), 'shape': list(v.shape), 'sha256': hashlib.sha256(np.ascontiguousarray(v).tobytes()).hexdigest()} for k, v in A.items()}
m2['derived_from'] = {'manifest': base.name + '.json', 'pool_fingerprint': man['pool']['fingerprint'], 'criterion': crit}
Path(str(out) + '.json').write_text(json.dumps(m2, indent=1))
print(f'{name}: {len(old_idx)} of {n} points ({crit}); pool–pool edges {int(A["pool_adj_indptr"][-1])//2}; fp {fp} → {out}.{{json,npz}}')
