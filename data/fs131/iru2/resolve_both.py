#!/usr/bin/env python3
"""FS131-IRU2: resolve each conflict hunk of a file by keeping both sides, main's side ("theirs") first, then the
branch's ("ours"), with one blank line between when neither side ends in one. Refuses a file with nested or unbalanced
markers. Usage: python3 -I resolve_both.py <file> [--vacuity]  (--vacuity: for the baseline's count line, write
nothing and print both sides, the line is set by hand from the expected join)"""
import sys, pathlib
p = pathlib.Path(sys.argv[1]); lines = p.read_text().split('\n')
out, i, hunks = [], 0, 0
while i < len(lines):
    ln = lines[i]
    if ln.startswith('<<<<<<< '):
        j = i + 1; ours = []
        while not lines[j].startswith('======='):
            assert not lines[j].startswith('<<<<<<<'), 'nested'; ours.append(lines[j]); j += 1
        k = j + 1; theirs = []
        while not lines[k].startswith('>>>>>>> '):
            assert not lines[k].startswith(('<<<<<<<', '=======')), 'unbalanced'; theirs.append(lines[k]); k += 1
        merged = theirs + ([''] if theirs and theirs[-1].strip() and ours and ours[0].strip() else []) + ours
        out += merged; i = k + 1; hunks += 1
        print(f'hunk {hunks}: theirs {len(theirs)} lines, ours {len(ours)} lines -> {len(merged)}')
    else:
        out.append(ln); i += 1
assert not any(l.startswith(('<<<<<<< ', '>>>>>>> ')) or l == '=======' for l in out), 'markers left'
p.write_text('\n'.join(out)); print('hunks resolved:', hunks)
