#!/usr/bin/env python3
"""FS129-SR2, item 63: the GAP lines of data/fs129/index/open-steps.md § 3 that fall inside a Lean-order entry of lane R beyond FS-110.

A line plans/<file>:<n> is assigned to the entry open-steps.md names ("after entry X"), else to the entry of that file whose recorded start line\n(theorems.jsonl `line`) is the greatest at or below n.
Kept when the file is FS-111's, FS-112's, FS-114's, FS-116's or FS-121's derivation file and the entry is a row of data/fs129/index/lean-order.md.
Writes data/fs129/sr2/item63-gap-lines.md. Fault: --fault ignores the named entry and assigns each line to the next entry by line number (the count changes).
"""
import json, re, sys, bisect
from collections import defaultdict

FILES = {f'plans/FS{m}-derivation.md' for m in ('111', '112', '114', '116', '121')}

def main():
    fault = '--fault' in sys.argv
    order = {}
    for l in open('data/fs129/index/lean-order.md'):
        m = re.match(r'\| (\d+) \| (\S+) \|', l)
        if m: order[m.group(2)] = int(m.group(1))
    starts = defaultdict(list)
    with open('data/fs129/index/theorems.jsonl') as f:
        f.readline()
        for l in f:
            d = json.loads(l)
            if d['file'] in FILES: starts[d['file']].append((int(d['line']), d['id']))
    for k in starts: starts[k].sort()
    txt = open('data/fs129/index/open-steps.md').read()
    sec = re.split(r'(?m)^## 4\. ', re.split(r'(?m)^## 3\. ', txt)[1])[0]
    kept = []
    for m in re.finditer(r'^- (plans/[^:\s]+):(\d+)(?: \(after entry (\S+)\))?: (.*)$', sec, re.M):
        fn, n, named, body = m.group(1), int(m.group(2)), m.group(3), m.group(4)
        if fn not in FILES: continue
        lines = [s for s, _ in starts[fn]]
        i = bisect.bisect_right(lines, n) - 1 + (1 if fault else 0)
        if i < 0 or i >= len(lines): continue
        eid = named if (named and not fault) else starts[fn][i][1]
        if eid in order: kept.append((order[eid], eid, fn, n, body))
    kept.sort()
    with open('data/fs129/sr2/item63-gap-lines.md', 'w') as out:
        out.write('# Item 63 — GAP lines inside Lean-order entries, lane R beyond FS-110 (tools/fs129_sr2_gaps.py)\n\n')
        out.write('| row | id | address | line (cut at 260) |\n|---|---|---|---|\n')
        for r, eid, fn, n, body in kept:
            out.write(f"| {r} | {eid} | {fn}:{n} | {body[:260].replace('|', '/')} |\n")
    print(f"GAP lines in Lean-order lane-R entries: {len(kept)} in {len({k[1] for k in kept})} entries")

main()
