#!/usr/bin/env python3
"""tick.py N "status text" [N "status" ...]: set the last cell of inventory item N."""
import sys, re
from pathlib import Path
p = Path('/home/kooshi/source/lean-dir/plans/FS85-close-inventory.md')
lines = p.read_text().split('\n')
args = sys.argv[1:]
for n, st in zip(args[::2], args[1::2]):
    hit = [i for i, l in enumerate(lines) if l.startswith(f'| {n} | ')]
    assert len(hit) == 1, (n, hit)
    l = lines[hit[0]]
    k = l.rstrip().rstrip('|').rstrip().rfind(' | ')
    lines[hit[0]] = l[:k] + ' | ' + st + ' |'
    print(n, '->', st[:60])
p.write_text('\n'.join(lines))
