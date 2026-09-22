#!/usr/bin/env python3
"""Fill the record's remaining placeholders from the sample ledger and the ranked draft."""
import json, sys
from collections import Counter

REC = 'data/fs70/records/phase-1f.md'
RANKED = ('/tmp/claude-1000/-home-kooshi-source-lean-dir/'
          '229be71b-1af0-4601-bef0-f695943ce757/scratchpad/ranked.md')
rows = [json.loads(l) for l in open('build/fs70/1f/sample.jsonl')]
by = {}
for r in rows:
    by.setdefault(int(r['tag'].split('-')[0][1:]), []).append(r)
CUBES = {10: '726', 16: '47,916', 22: '3,162,456'}
NB = {10: 'the pinned wheel + 1 whole wheel', 16: '+ 2 whole wheels', 22: '+ 3 whole wheels'}

tab = ['| depth | branching set | cubes in a full pass | sampled | decided | at the wall | '
       'mean kissat s | max kissat s | RSS range |', '|---|---|---|---|---|---|---|---|---|']
tot_dec = 0
for d in (10, 16, 22):
    rs = by.get(d, [])
    c = Counter(r['verdict'] for r in rs)
    dec = c.get('SAT', 0) + c.get('UNSAT', 0)
    tot_dec += dec
    ks = [r['kissat_seconds'] for r in rs if r['kissat_seconds'] is not None]
    rss = [r['max_rss_kb'] / 1048576 for r in rs]
    verd = ', '.join(f'{v}: {n}' for v, n in sorted(c.items()))
    tab.append(f'| {d} | {NB[d]} | {CUBES[d]} | {len(rs)} | **{dec}** ({verd}) | '
               f'{c.get("UNKNOWN", 0)}/{len(rs)} | {sum(ks)/len(ks):.1f} | {max(ks):.1f} | '
               f'{min(rss):.2f}–{max(rss):.2f} GB |')
table = '\n'.join(tab)
n = len(rows)
if tot_dec == 0:
    table += (f'\n\n**{n} of {n} cubes are UNKNOWN at 600 s — the decided fraction is 0 at every depth, so the '
              f'sample yields no mean time of decided cubes and no finite extrapolation.** Deeper branching '
              f'inside the range the brief named buys nothing: 16 cubes with 22 vertices fixed behave exactly '
              f'like 16 cubes with 10 fixed. The fraction at the wall is 1.00, 1.00, 1.00.')
    short = f'all {n} UNKNOWN'
else:
    short = f'{tot_dec} of {n} decided'

s = open(REC).read()
s = s.replace('PLACEHOLDER-1B-TABLE', table)
s = s.replace('PLACEHOLDER-1B-SHORT', short)
for d in (10, 16, 22):
    rs = by.get(d, [])
    c = Counter(r['verdict'] for r in rs)
    s = s.replace(f'PLACEHOLDER-D{d}', str(c.get('SAT', 0) + c.get('UNSAT', 0)))
s = s.replace('PLACEHOLDER-RANKED', open(RANKED).read().rstrip())
open(REC, 'w').write(s)
left = [l for l in s.splitlines() if 'PLACEHOLDER' in l]
print(f'{n} sample rows, {tot_dec} decided; placeholders left: {len(left)}')
for l in left:
    print('  !!', l[:90])
