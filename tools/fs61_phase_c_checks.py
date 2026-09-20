#!/usr/bin/env python3
"""Phase C's two remaining gate items, both of which need a solver and neither of which belongs in `land`.

  C.8  reproducibility -- re-run the generation line of a committed `run-all.sh` into a scratch directory and
       compare `witness.json` BYTE FOR BYTE with the committed one.  Two populations, because they answer
       different questions:
         * a 1-minimal witness, from a TRULY EMPTY directory -- the strong form, nothing carried over;
         * a stopped-deletion witness, from a directory seeded with its own `steps.jsonl` -- the honest form, and
           exactly what its `run-all.sh` header says (the checkpoint is gitignored provenance, and without it a
           `--stop-deletion` rerun stops at position 0 and yields the larger core-round witness instead).
  PLANT the direct-witness wall and its fallback.  `run_generation` is given a wall small enough that
       `direct-witness` cannot finish; it must be stopped by pid and `extract` must take over the same ball and
       produce a witness.  Both outcomes are shown reachable: the same ball with a generous wall finishes in
       `direct-witness` and the fallback never fires.

Usage: python3 tools/fs61_phase_c_checks.py [--only c8|plant]
"""
import json, sys, shutil, time, hashlib, tempfile, pathlib

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import fs61_census as C

FS61 = C.FS61
# (d, why this field is in the population)
CLEAN = [(47, 'direct-witness, 1-minimal, the smallest witness here'),
         (71, 'extract, 1-minimal -- the core rounds and the whole deletion rerun from nothing')]
SEEDED = [(143, 'extract with the deletion stopped at 1,056 of 1,769; seeded with its own steps.jsonl')]


def sha(p):
    return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()


def gen_line(D):
    """The generation line of the committed run-all.sh, read from the file rather than rebuilt, so this tests the
    script a reviewer would actually run."""
    for ln in (FS61 / f'witness-{D}' / 'run-all.sh').read_text().splitlines():
        if 'fs58_search.py' in ln:
            return ln.split()
    raise SystemExit(f'd={D}: run-all.sh has no fs58_search.py line')


def c8():
    rows, bad = [], []
    for D, why, seed in [(d, w, False) for d, w in CLEAN] + [(d, w, True) for d, w in SEEDED]:
        toks = gen_line(D)
        with tempfile.TemporaryDirectory(prefix=f'fs61-c8-{D}-') as td:
            if seed:
                shutil.copy(FS61 / f'witness-{D}' / 'steps.jsonl', pathlib.Path(td) / 'steps.jsonl')
            cmd = [sys.executable if t == 'python3' else t for t in toks]
            cmd = [str(td) if t == '$D' else t for t in cmd]
            cmd = [t for t in cmd if not t.startswith('>')]
            t0 = time.time()
            import subprocess
            p = subprocess.run(cmd, capture_output=True, text=True, cwd=str(C.ROOT))
            dt = time.time() - t0
            new = pathlib.Path(td) / 'witness.json'
            ok = p.returncode == 0 and new.exists() and sha(new) == sha(FS61 / f'witness-{D}' / 'witness.json')
            rows.append((D, why, 'seeded with steps.jsonl' if seed else 'EMPTY directory', round(dt, 1),
                         'byte-identical' if ok else f'DIFFERS (exit {p.returncode})'))
            if not ok:
                bad.append(D)
                print((p.stdout + p.stderr)[-600:])
    print('\nC.8 -- `run-all.sh`\'s generation line, re-run into a scratch directory:')
    print('| d | why this field | started from | seconds | witness.json |')
    print('|---|---|---|---|---|')
    for D, why, st, dt, v in rows:
        print(f'| {D} | {why} | {st} | {dt} | **{v}** |')
    return bad


def plant():
    """The wall and the fallback, on d = 119's ball -- the one direct-witness field that takes long enough (51 s)
    for a small wall to be meaningful and short enough for the generous arm to finish."""
    D, spec, R = 119, 'q1+12+60.1', 1.5
    out = []
    for wall, expect in ((5.0, 'the wall fires and extract takes over'), (600.0, 'direct-witness finishes')):
        with tempfile.TemporaryDirectory(prefix=f'fs61-plant-{D}-') as td:
            t0 = time.time()
            info = C.run_generation(D, spec, R, pathlib.Path(td), big=False, deletion_budget=600.0,
                                    gen_cap=5400.0, direct_wall=wall)
            ok = info['ok'] and (pathlib.Path(td) / 'witness.json').exists()
            n = len(json.loads((pathlib.Path(td) / 'witness.json').read_text())['points']) if ok else None
            out.append((wall, expect, info.get('generator'), info.get('stopped'), n, round(time.time() - t0, 1)))
    print('\nPLANT -- the direct-witness wall and its fallback (d = 119, ball 13,605 points):')
    print('| wall | what should happen | generator that finished | what was stopped | witness points | seconds |')
    print('|---|---|---|---|---|---|')
    for wall, expect, gen, stop, n, dt in out:
        print(f'| {wall:.0f} s | {expect} | **{gen}** | {stop or "nothing"} | {n} | {dt} |')
    fired = bool(out[0][2] == 'extract' and out[0][3] and out[0][4])
    clean = bool(out[1][2] == 'direct-witness' and out[1][3] is None and out[1][4])
    print(f'\nplant fired: {fired};  the generous arm is clean: {clean}  '
          f'(both outcomes reachable, which is what makes the plant evidence)')
    return [] if (fired and clean) else [D]


if __name__ == '__main__':
    only = sys.argv[sys.argv.index('--only') + 1] if '--only' in sys.argv else None
    bad = []
    if only in (None, 'c8'):
        bad += c8()
    if only in (None, 'plant'):
        bad += plant()
    print(f'\nDONE fs61_phase_c_checks: {len(bad)} failures')
    sys.exit(1 if bad else 0)
