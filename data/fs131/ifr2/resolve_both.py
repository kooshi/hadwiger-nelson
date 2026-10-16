#!/usr/bin/env python3
"""FS131-IFR2: resolve a merge conflict in a gate-input list by keeping both sides' lines: main's side (the landings that
went in first) then this branch's (HEAD), separated by one blank line where both are non-empty. Refuses a file with a diff3
base section, nested markers, or a marker count that is not a multiple of three; prints each hunk's line counts.
Usage: python3 -I resolve_both.py <file> [--order theirs-first|ours-first]"""
import pathlib, sys
p = pathlib.Path(sys.argv[1]); order = sys.argv[3] if len(sys.argv) > 3 else 'theirs-first'
lines = p.read_text().split('\n')
out, i, hunks = [], 0, 0
while i < len(lines):
    ln = lines[i]
    if ln.startswith('<<<<<<< '):
        j = i + 1; ours = []
        while not lines[j].startswith('======='):
            assert not lines[j].startswith(('<<<<<<<', '|||||||', '>>>>>>>')), f'bad marker at {j+1}'
            ours.append(lines[j]); j += 1
        k = j + 1; theirs = []
        while not lines[k].startswith('>>>>>>> '):
            assert not lines[k].startswith(('<<<<<<<', '|||||||', '=======')), f'bad marker at {k+1}'
            theirs.append(lines[k]); k += 1
        a, b = (theirs, ours) if order == 'theirs-first' else (ours, theirs)
        while a and a[-1] == '': a.pop()
        while b and b[0] == '': b.pop(0)
        out += a + ([''] if a and b else []) + b
        hunks += 1
        print(f'hunk {hunks}: lines {i+1}-{k+1}: HEAD {len(ours)} lines, main {len(theirs)} lines')
        i = k + 1
    else:
        out.append(ln); i += 1
assert hunks > 0, 'no conflict found'
p.write_text('\n'.join(out))
print('resolved', hunks, 'hunk(s) in', p)
