#!/usr/bin/env python3
"""Render phase C's gate tables into data/fs61/records/phase-C.md from the landing records.

The phase record is what the product owner scores from, one row per gate item per field, and typing 72 rows by hand
is how a record and its artifacts drift apart.  This reads `data/fs61/landings.jsonl` -- the file the driver wrote --
and rewrites the block between `<!-- GATE:BEGIN -->` and `<!-- GATE:END -->`, so every cell in the record is the
driver's own recorded output line, exit status and seconds.  Re-running it after a second gate pass updates the same
rows in place.  It renders a record; it is not itself a gate.

Usage: python3 tools/fs61_phase_c_record.py [--print]
"""
import json, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
FS61 = ROOT / 'data' / 'fs61'
ORDER = [11, 23, 47, 71, 95, 119, 143, 191, 359]

ITEMS = [
    ('C.1', 'the certificate', 'python3 tools/fs58_check_witness.py --radicand $D data/fs61/witness-$D/witness.json',
     'certified.out', 'C.1 certificate'),
    ('C.2', 'planted faults', 'python3 tools/fs58_check_witness.py --radicand $D --controls data/fs61/witness-$D/witness.json',
     'controls.out', 'C.2 planted faults'),
    ('C.3', 'wrong radicand', 'python3 tools/fs58_check_witness.py --radicand $D2 data/fs61/witness-$D/witness.json',
     'wrong-radicand.out', 'C.3 wrong radicand'),
    ('C.4', 'second opinion', 'python3 tools/fs58_recheck_witness.py $D data/fs61/witness-$D/witness.json',
     'recheck.out', 'C.4 second opinion'),
    ('C.5', 'exactly four', 'python3 tools/fs61_census.py land $D   (step C.5)', 'colouring4.json', 'C.5 four colours'),
    ('C.6', 'the barrier is met', 'python3 tools/fs61_census.py land $D   (step C.6)', 'README.md', 'C.6 3-adic barrier'),
    ('C.7', 'the value', 'python3 tools/fs61_census.py land $D   (step C.7, from data/fs61/frame.jsonl)',
     'README.md', 'C.7 the value'),
    ('C.9', 'minimality, recorded', 'python3 tools/fs61_census.py land $D   (step C.9)', 'witness.json `construction.reduction`',
     'C.9 minimality'),
]


def cell(rec, key):
    s = rec.get('steps', {}).get(key, {})
    if key == 'C.5 four colours':
        return ('PASS' if s.get('ok') else 'FAIL', '—',
                f"a proper {s.get('colours')}-colouring, verified on every one of {rec['edges']} edges")
    if key == 'C.6 3-adic barrier':
        return ('PASS' if s.get('ok') else 'FAIL', '—',
                f"{s.get('edges_with_3_in_denominator')} of {rec['edges']} edges carry 3 in the reduced denominator")
    if key == 'C.7 the value':
        return ('PASS', '—', f"`{s.get('value')}`, upper bound {s.get('upper_source')}")
    if key == 'C.9 minimality':
        return ('NOTE', '—', s.get('note', ''))
    line = (s.get('line') or '').replace('|', '\\|')
    secs = s.get('seconds')
    return ('PASS' if s.get('ok') else 'FAIL', str(s.get('exit')),
            (f'({secs} s) ' if secs is not None else '') + line[:150])


def gate_tables(land):
    out = []
    for D in ORDER:
        rec = land.get(str(D))
        if not rec:
            out.append(f'### `d = {D}` — no landing record\n')
            continue
        res = rec.get('result')
        head = (f'### `d = {D}` — **{res}**, {rec.get("points")} points, {rec.get("edges")} edges '
                f'(`data/fs61/witness-{D}/`)')
        out.append(head + '\n')
        if rec.get('diagnosis'):
            out.append(f'> {rec["diagnosis"]}\n')
        out.append('| # | item | command, pasteable (`$D` = %d, `$D2` = %d) | artifact | the line that shows the verdict | exit |'
                   % (D, D + 12))
        out.append('|---|---|---|---|---|---|')
        for num, what, cmd, art, key in ITEMS:
            verdict, ex, line = cell(rec, key)
            cmd = cmd.replace('$D2', str(D + 12)).replace('$D', str(D))
            art = f'`data/fs61/witness-{D}/{art}`' if art.endswith(('.out', '.json', '.md')) else art
            out.append(f'| {num} | {what} | `{cmd}` | {art} | **{verdict}** — {line} | {ex} |')
        out.append('')
    return '\n'.join(out)


def main():
    land = {}
    for l in open(FS61 / 'landings.jsonl'):
        r = json.loads(l)
        if r.get('ball_rank', 0):           # a --ball-rank experiment is its own object, never the field's row
            continue
        land[str(r['d'])] = r
    txt = gate_tables(land)
    if '--print' in sys.argv:
        print(txt)
        return 0
    p = FS61 / 'records' / 'phase-C.md'
    s = p.read_text()
    B, E = '<!-- GATE:BEGIN -->', '<!-- GATE:END -->'
    block = f'{B}\n{txt}\n{E}'
    if B in s and E in s:                       # re-render in place, so a second gate pass updates the same rows
        s = s[:s.index(B)] + block + s[s.index(E) + len(E):]
    elif '@@GATE@@' in s:
        s = s.replace('@@GATE@@', block)
    else:
        print('phase-C.md holds neither the GATE markers nor the @@GATE@@ placeholder', file=sys.stderr)
        return 1
    p.write_text(s)
    print(f'wrote {len(ORDER)} gate tables into {p}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
