#!/usr/bin/env python3
"""FS131-IO2: classify a `#print axioms` output (pp.fullNames) record by record, rejoining wrapped lines.
Prints one line per record and a summary; exits 1 if any record rests on an axiom outside the standard three other than `sorryAx`, or if the
number of records differs from `--expect N`; exits 2 if no record is found. Usage: fs131_io_axioms.py <print.txt> [--expect N]
[--sorry name,name,...] (the records allowed to carry `sorryAx`; any other `sorryAx` record fails)."""
import re, sys

STD = {'propext', 'Classical.choice', 'Quot.sound'}
args = sys.argv[1:]
path = args[0]
expect = int(args[args.index('--expect') + 1]) if '--expect' in args else None
allowed_sorry = set(args[args.index('--sorry') + 1].split(',')) if '--sorry' in args else set()
text = open(path).read()
text = re.sub(r'\n\s+', ' ', text)  # rejoin wrapped continuation lines
recs = []
for m in re.finditer(r"'(\S+)' depends on axioms: \[([^\]]*)\]", text):
    recs.append((m.group(1), [a.strip() for a in m.group(2).split(',') if a.strip()]))
for m in re.finditer(r"'(\S+)' does not depend on any axioms", text):
    recs.append((m.group(1), []))
if not recs:
    print('no records found'); sys.exit(2)
bad = 0; counts = {'std': 0, 'sorry': 0, 'foreign': 0}
for name, ax in recs:
    s = set(ax)
    if s <= STD:
        counts['std'] += 1; kind = 'STD'
    elif s - STD == {'sorryAx'}:
        counts['sorry'] += 1; kind = 'SORRY'
        if name not in allowed_sorry:
            bad += 1; kind = 'SORRY-UNEXPECTED'
    else:
        counts['foreign'] += 1; kind = 'FOREIGN'; bad += 1
    print(f'{kind:17} {name} {sorted(ax)}')
print(f"records={len(recs)} std={counts['std']} sorry={counts['sorry']} foreign={counts['foreign']}")
if expect is not None and len(recs) != expect:
    print(f'COUNT MISMATCH: expected {expect}'); bad += 1
sys.exit(1 if bad else 0)
