#!/usr/bin/env python3
"""FS131-ISF2: resolve git conflict blocks by keeping both sides (ours, then theirs). Refuses a diff3 base section
('|||||||') and a malformed block; prints each block's line counts. Usage: union_conflicts.py FILE..."""
import sys

for path in sys.argv[1:]:
    lines = open(path, encoding='utf-8').read().split('\n')
    out, i, blocks = [], 0, 0
    while i < len(lines):
        ln = lines[i]
        if ln.startswith('<<<<<<< '):
            j = i + 1; ours = []
            while not lines[j].startswith('======='):
                assert not lines[j].startswith(('|||||||', '<<<<<<< ', '>>>>>>> ')), (path, j)
                ours.append(lines[j]); j += 1
            k = j + 1; theirs = []
            while not lines[k].startswith('>>>>>>> '):
                assert not lines[k].startswith(('|||||||', '<<<<<<< ', '=======')), (path, k)
                theirs.append(lines[k]); k += 1
            out += ours + theirs; blocks += 1
            print(f'{path}: block {blocks} at line {i+1}: ours {len(ours)} lines, theirs {len(theirs)} lines')
            i = k + 1
        else:
            out.append(ln); i += 1
    assert blocks > 0, path
    open(path, 'w', encoding='utf-8').write('\n'.join(out))
