#!/usr/bin/env python3
"""FS131-PN1 readback of Amendment 1: its three quoted receipt lines against their source file.
Exit 0 iff each quoted line occurs verbatim as a whole line. --fault alters one character of the first."""
import re, sys
BRIEF = 'data/fs131/briefs/FS131-PN1-number-field-ranking.md'
b = open(BRIEF, encoding='utf-8').read()
a = b[b.index('## Amendment 1'):]
qs = re.findall(r'> (ASSUMPTION .*?)\n> — source: (\S+)', a)
assert len(qs) == 3, len(qs)
mism = 0
for i, (q, src) in enumerate(qs):
    if '--fault' in sys.argv and i == 0:
        q = q.replace('kind=ours', 'kind=outside', 1)
    lines = [l.strip() for l in open(src, encoding='utf-8').read().split('\n')]
    ok = q.strip() in lines
    mism += (not ok)
    print(('MATCH   ' if ok else 'MISMATCH') + ' ' + q[:70] + ' …')
print(f'quotations={len(qs)} mismatches={mism}')
sys.exit(1 if mism else 0)
