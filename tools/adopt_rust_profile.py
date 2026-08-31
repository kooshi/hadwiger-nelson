#!/usr/bin/env python3
"""Adopt a Rust-engine profile (`descent replay`) as the campaign's profile for an object's iteration.

The Python phases after the profile (`--hitting`, then `export_sublist.py`) read
`m50-survivors-{label}.json` / `m50-unknown-{label}.json` and a `profile` row in `m50-batch.json`.
This tool makes the adoption a re-derivation rather than trust:

  1. the checkpoint header's class count must equal the campaign's list length, and its pool
     fingerprint must equal the cached pool export's (`load_pool` re-verifies every array's sha256
     and the object fingerprint on the way);
  2. every class index 0..N-1 must appear exactly once with a verdict in {killed, survives, unknown}
     — a missing row is refused (an unfinished checkpoint is not a profile);
  3. `unknown` is never folded: survivors = every index whose verdict is not `killed`.

Then the two index files are written and the row recorded with provenance.
"""
import argparse, hashlib, json, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402
import twodist as T  # noqa: E402

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--object', required=True); ap.add_argument('--out', required=True, help='the replay --out directory')
    ap.add_argument('--pool', default='depth1')
    a = ap.parse_args()
    obj, removed = BK.load_object(a.object)
    seps = BK.BUILD / f'm50-S-{a.object}-it2v2.jsonl'
    header, cols = BK.load_seps(seps); N = len(cols)
    pool = BK.load_pool(obj, a.pool)
    assert pool is not None, 'no cached pool export for this object'
    vf = Path(a.out) / 'verdicts.jsonl'; lines = vf.read_text().splitlines()
    h = lines[0].split(); assert h[0] == '#', lines[0]
    n_hdr, pool_fp = int(h[1]), h[2]
    assert n_hdr == N, f'checkpoint header count {n_hdr} != list length {N}'
    assert pool_fp == pool.fp, f'checkpoint pool fp {pool_fp} != export pool fp {pool.fp}'
    verdict = {}
    for l in lines[1:]:
        if not l.strip(): continue
        i, v = l.split(); i = int(i)
        assert v in ('killed', 'survives', 'unknown'), (i, v)
        assert i not in verdict, f'class {i} answered twice'
        verdict[i] = v
    missing = [i for i in range(N) if i not in verdict]
    assert not missing, f'{len(missing)} classes have no verdict (first: {missing[:5]}) — the checkpoint is not complete; re-run the replay (it resumes)'
    outs = [verdict[i] for i in range(N)]
    label = f'{a.object}-it2v2-{pool.name}'
    (BK.BUILD / f'm50-survivors-{label}.json').write_text(json.dumps([i for i, k in enumerate(outs) if k != 'killed']))
    (BK.BUILD / f'm50-unknown-{label}.json').write_text(json.dumps([i for i, k in enumerate(outs) if k == 'unknown']))
    nk, ns, nu = (sum(1 for o in outs if o == v) for v in ('killed', 'survives', 'unknown'))
    budget = next((x.split('=')[1] for x in h[3:] if x.startswith('conflicts=')), None)
    row = {'kind': 'profile', 'label': label, **pool.cite(), 'n_colourings': N,
           'survivor_file': f'm50-survivors-{label}.json', 'killed': nk, 'survive': ns, 'unknown': nu, 'seconds': None,
           'source': {'engine': 'descent replay (Rust)', 'out': str(a.out), 'conflicts_budget': budget,
                      'verdicts_sha256_16': hashlib.sha256(vf.read_bytes()).hexdigest()[:16], 'stage_fingerprint': header['stage_fingerprint']},
           'claim_scope': ('per-colouring whole-set verdict on the named pool, from the Rust engine: killed = no extension of the '
                           'colouring to the whole pool exists (so none to any subset — monotonicity), survives = the whole pool '
                           'is list-colourable under it, unknown = the conflict budget fired and is NEVER folded; adopted after the '
                           'checkpoint header (count, pool fingerprint) was re-derived against the campaign list and the cached '
                           'export, and every class index found exactly once')}
    T.record(BK.BUILD / 'm50-batch.json', row)
    print(f'adopted profile {label}: {N} classes — killed {nk}, survive {ns}, unknown {nu}; pool {pool.fp} ({len(pool.pts)} pts); row recorded')

if __name__ == '__main__':
    main()
