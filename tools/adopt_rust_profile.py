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
    ap.add_argument('--merge-tail', action='append', default=[], help='replay --out dir(s) on a RESTRICTED pool covering classes the main run left unanswered (an acknowledged pool choice: kills transfer by monotonicity; survives/unknown there say nothing about the named pool and count as unknown)')
    ap.add_argument('--merge-full', action='append', default=[], help='replay --out dir(s) on the NAMED pool re-asking classes (their verdicts are adopted as-is and OVERRIDE a restricted-pool unknown; a wall unknown stays unknown)')
    ap.add_argument('--unanswered-as-unknown', action='store_true', help='acknowledge that classes no checkpoint answers are adopted as unknown (never folded); without this flag a missing row is refused')
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
    tail_note = []
    for td in a.merge_tail:
        tf = Path(td) / 'verdicts.jsonl'; tl = tf.read_text().splitlines()
        th = tl[0].split(); tail_conflicts = next((x.split('=')[1] for x in th[3:] if x.startswith('conflicts=')), None)
        n_kill = n_other = 0
        for l in tl[1:]:
            if not l.strip(): continue
            i, v = l.split(); i = int(i)
            assert i not in verdict or verdict[i] == 'unknown', f'class {i} already decided by an earlier checkpoint'
            if v == 'killed':
                verdict[i] = 'killed'; n_kill += 1        # a kill on a sub-pool is a kill on the pool
            elif i not in verdict:
                verdict[i] = 'unknown'; n_other += 1      # a sub-pool survive/unknown says nothing about the pool
        tail_note.append({'out': str(td), 'pool_fingerprint': th[2], 'conflicts_budget': tail_conflicts,
                          'kills_adopted': n_kill, 'demoted_to_unknown': n_other,
                          'verdicts_sha256_16': hashlib.sha256(tf.read_bytes()).hexdigest()[:16]})
        print(f'merged restricted-pool tail {td}: {n_kill} kills adopted (monotone), {n_other} demoted to unknown')
    full_note = []
    for fd in a.merge_full:
        ff = Path(fd) / 'verdicts.jsonl'; fl = ff.read_text().splitlines(); fh = fl[0].split()
        assert fh[2] == pool.fp, f'full re-ask {fd} is on pool {fh[2]}, not the named pool {pool.fp}'
        n_over = n_new = 0
        for l in fl[1:]:
            if not l.strip(): continue
            i, v = l.split(); i = int(i)
            assert v in ('killed', 'survives', 'unknown'), (i, v)
            prev = verdict.get(i)
            assert prev in (None, 'unknown'), f'class {i} was {prev} on the named pool already; a re-ask must not disagree'
            if v != 'unknown' or prev is None:
                verdict[i] = v; n_over += (prev is not None); n_new += (prev is None)
        full_note.append({'out': str(fd), 'pool_fingerprint': fh[2], 'overrides': n_over, 'new': n_new,
                          'verdicts_sha256_16': hashlib.sha256(ff.read_bytes()).hexdigest()[:16]})
        print(f'merged full-pool re-ask {fd}: {n_over} unknowns resolved/re-asked, {n_new} new rows')
    missing = [i for i in range(N) if i not in verdict]
    if missing and a.unanswered_as_unknown:
        for i in missing: verdict[i] = 'unknown'
        print(f'{len(missing)} classes answered by no checkpoint adopted as UNKNOWN (acknowledged; never folded)')
        missing = []
    assert not missing, f'{len(missing)} classes have no verdict (first: {missing[:5]}) — the checkpoint is not complete; re-run the replay (it resumes) or pass --unanswered-as-unknown'
    outs = [verdict[i] for i in range(N)]
    label = f'{a.object}-it2v2-{pool.name}'
    (BK.BUILD / f'm50-survivors-{label}.json').write_text(json.dumps([i for i, k in enumerate(outs) if k != 'killed']))
    (BK.BUILD / f'm50-unknown-{label}.json').write_text(json.dumps([i for i, k in enumerate(outs) if k == 'unknown']))
    nk, ns, nu = (sum(1 for o in outs if o == v) for v in ('killed', 'survives', 'unknown'))
    budget = next((x.split('=')[1] for x in h[3:] if x.startswith('conflicts=')), None)
    row = {'kind': 'profile', 'label': label, **pool.cite(), 'n_colourings': N,
           'survivor_file': f'm50-survivors-{label}.json', 'killed': nk, 'survive': ns, 'unknown': nu, 'seconds': None,
           'source': {'engine': 'descent replay (Rust)', 'out': str(a.out), 'conflicts_budget': budget, 'tails': tail_note, 'full_reasks': full_note, 'unanswered_as_unknown': a.unanswered_as_unknown,
                      'verdicts_sha256_16': hashlib.sha256(vf.read_bytes()).hexdigest()[:16], 'stage_fingerprint': header['stage_fingerprint']},
           'claim_scope': ('per-colouring whole-set verdict on the named pool, from the Rust engine: killed = no extension of the '
                           'colouring to the whole pool exists (so none to any subset — monotonicity), survives = the whole pool '
                           'is list-colourable under it, unknown = the conflict budget fired and is NEVER folded; adopted after the '
                           'checkpoint header (count, pool fingerprint) was re-derived against the campaign list and the cached '
                           'export, and every class index found exactly once; a merged tail checkpoint on a restricted pool contributes KILLS only (monotonicity) with everything else demoted to unknown')}
    T.record(BK.BUILD / 'm50-batch.json', row)
    print(f'adopted profile {label}: {N} classes — killed {nk}, survive {ns}, unknown {nu}; pool {pool.fp} ({len(pool.pts)} pts); row recorded')

if __name__ == '__main__':
    main()
