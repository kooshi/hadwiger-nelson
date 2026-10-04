#!/usr/bin/env python3
"""Print index records by id: statement, uses, not claimed, grade, minds, verdict, model, handoff, address. Usage: show.py ID [ID ...] [--short]"""
import json, sys
recs = {}
for line in open('/home/kooshi/source/lean-dir/data/fs129/index/theorems.jsonl'):
    r = json.loads(line)
    if 'id' in r:
        recs[r['id']] = r
short = '--short' in sys.argv
for i in [a for a in sys.argv[1:] if not a.startswith('--')]:
    r = recs.get(i)
    if r is None:
        print(f'## {i}: NOT IN INDEX'); continue
    print(f"## {i} — {r['file']}:{r['line']} — {r.get('grade','')} — minds {r.get('minds','')} — verdict {r.get('verdict','')}")
    print('S:', r.get('statement', ''))
    if not short:
        print('U:', r.get('uses_raw', ''))
        print('N:', r.get('not_claimed', ''))
        print('M:', r.get('model', ''))
        print('R:', r.get('rests_text', '')[:400], '| ids', r.get('rests_ids'))
        print('H:', (r.get('handoff') or r.get('kernel') or '')[:300])
    print()
