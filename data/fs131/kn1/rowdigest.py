#!/usr/bin/env python3
"""FS131-KN1 working tool: print a ledger row's head and tail (LEDGER.md § A), or the whole row.
usage: rowdigest.py <first> <last> [head_chars] [tail_chars]   (head_chars = 0 prints the whole row)"""
import re, sys
rows = {}
for i, l in enumerate(open('LEDGER.md').read().splitlines(), 1):
    m = re.match(r'\| (\d+) \| ', l)
    if m and 43 <= i <= 213:
        rows[int(m.group(1))] = l
a, b = int(sys.argv[1]), int(sys.argv[2])
h = int(sys.argv[3]) if len(sys.argv) > 3 else 600
t = int(sys.argv[4]) if len(sys.argv) > 4 else 220
for n in range(a, b + 1):
    if n not in rows:
        print(f'[{n}] ABSENT'); continue
    body = rows[n][len(f'| {n} | '):]
    if h == 0 or len(body) <= h + t:
        print(f'[{n}] {body}\n')
    else:
        print(f'[{n}] {body[:h]} …… {body[-t:]}\n')
