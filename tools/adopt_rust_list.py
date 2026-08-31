#!/usr/bin/env python3
"""Adopt a Rust-engine class list as the campaign's list for an object's iteration.

The Python phases (`--hitting`, `export_sublist.py`, `--commit`) read `m50-S-{label}-it2v2.jsonl`
and require an `enumeration` row in `m50-batch.json` whose stage fingerprint matches the header.
This tool makes that adoption an act of RE-DERIVATION rather than trust:

  1. the header's `stage_fingerprint` must equal `obj.fingerprint(batch)` re-derived here from the
     object file and the header's own batch (the same derivation the Python enumerator uses);
  2. the batch must be `removed(live) ∪ F` with `F ⊆` the recorded census floor (a sub-batch);
  3. the engine's report must claim `exact` and print `=> classes.jsonl IS the class set`;
  4. EVERY line is re-validated in Python: width n, digits < k, proper on unit ∪ (cheats ∖ batch),
     and the forced pair separated — the campaign's own definition of a separating colouring.

Then the list is copied to the campaign name and the row recorded with its provenance.
"""
import argparse, hashlib, json, shutil, sys, time
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as BK  # noqa: E402
import twodist as T  # noqa: E402

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--object', required=True); ap.add_argument('--list', required=True)
    ap.add_argument('--report', required=True); ap.add_argument('--k', type=int, default=5)
    a = ap.parse_args()
    obj, removed = BK.load_object(a.object)
    src = Path(a.list); lines = src.read_text().splitlines()
    header = json.loads(lines[0]); assert header['kind'] == 'enumeration-header', header.get('kind')
    batch = [tuple(e) for e in header['batch']]
    # 1. the stage fingerprint, re-derived
    fp = obj.fingerprint(batch)
    assert fp == header['stage_fingerprint'], f'stage fingerprint {header["stage_fingerprint"]} != re-derived {fp}'
    # 2. a sub-batch of removed(live) ∪ census floor
    live = set(map(tuple, obj.cheats)); rem_live = {tuple(e) for e in removed if tuple(e) in live}
    rows = json.loads((BK.BUILD / 'm50-batch.json').read_text())['rows']
    rc = [r for r in rows if r['kind'] == 'recurse-census' and r['label'] == a.object][-1]
    floor = {tuple(e) for e in rc['essential_alone']}
    F = set(batch) - rem_live
    assert rem_live <= set(batch), 'batch misses a live removed cheat'
    assert F <= floor, f'batch spends edges outside the census floor: {F - floor}'
    # 3. the engine's own claim
    rep = Path(a.report).read_text()
    assert 'claim     exact' in rep and 'IS the class set of this stage' in rep, 'report does not claim exact+verified'
    # 4. re-validate every line
    edges = np.array(obj.unit_edges() + [e for e in obj.cheats if e not in set(batch)], dtype=np.int64)
    t0 = time.time(); n = 0
    for x in lines[1:]:
        col = json.loads(x); assert len(col) == obj.n, (n, len(col))
        c = np.frombuffer(col.encode(), dtype=np.uint8) - 48
        assert c.max() < a.k, (n, 'digit out of palette')
        assert np.all(c[edges[:, 0]] != c[edges[:, 1]]), (n, 'not proper')
        assert c[obj.A] != c[obj.B], (n, 'forced pair not separated')
        n += 1
    assert n == len(lines) - 1
    dst = BK.BUILD / f'm50-S-{a.object}-it2v2.jsonl'
    if dst.exists() and hashlib.sha256(dst.read_bytes()).hexdigest() != hashlib.sha256(src.read_bytes()).hexdigest():
        raise SystemExit(f'{dst} exists with different content — refusing to overwrite')
    shutil.copyfile(src, dst)
    row = {**header, 'kind': 'enumeration', 'count': n, 'status': 'exact', 'gate': 'proceed' if n <= 30_000 else 'blocked',
           'cubes': {'n': None, 'open': 0}, 'duplicate_class_lines_dropped': 0, 'seconds': None,
           'source': {'engine': 'descent enumerate (Rust)', 'list': str(src), 'list_sha256_16': hashlib.sha256(src.read_bytes()).hexdigest()[:16],
                      'report': str(a.report), 'sub_batch': {'floor_spent': len(F), 'floor_census': len(floor), 'removed_live': len(rem_live)}},
           'claim_scope': ('adopted from the Rust engine: exact (every leaf refuted) and V1/V2/V3-verified by the engine; '
                           'stage fingerprint re-derived from the object + header batch in Python; every line re-validated in '
                           f'Python (width, palette, proper on unit ∪ remaining cheats, forced pair separated) in {time.time()-t0:.0f} s; '
                           'a SUB-BATCH of the census floor when floor_spent < floor_census')}
    T.record(BK.BUILD / 'm50-batch.json', row)
    print(f'adopted {n} classes → {dst.name}; stage {fp}; batch {len(batch)} = {len(rem_live)} removed + {len(F)} floor '
          f'(census floor {len(floor)}); re-validated in {time.time()-t0:.0f} s; row recorded')

if __name__ == '__main__':
    main()
