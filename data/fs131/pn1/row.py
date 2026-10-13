#!/usr/bin/env python3
"""Print LEDGER.md rows by number (the table of section A). Usage: row.py N [N ...] [--head K]"""
import re, sys
L = open('LEDGER.md', encoding='utf-8').read().split('\n')
head = None
args = sys.argv[1:]
if '--head' in args:
    i = args.index('--head'); head = int(args[i + 1]); args = args[:i] + args[i + 2:]
want = set(int(a) for a in args)
for i, l in enumerate(L[36:214], start=37):
    m = re.match(r'\|\s*\**(\d+)\**\s*\|', l)
    if m and int(m.group(1)) in want:
        print(f'[LEDGER.md l.{i}] ' + (l if head is None else l[:head] + (' …' if len(l) > head else '')))
        print()
