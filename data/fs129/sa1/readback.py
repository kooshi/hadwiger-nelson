#!/usr/bin/env python3
"""FS129-SA1 stage 1: check every blockquoted quotation in the brief against its named source.
Exact substring first, then whitespace-normalised. --fault appends a word to each quotation (every check must then miss)."""
import re, sys
brief = open('data/fs129/briefs/FS129-SA1-pass3.md').read()
fault = '--fault' in sys.argv
lines = brief.splitlines()
pairs = []
for i, l in enumerate(lines):
    if l.startswith('> ') and not l.startswith('> — source'):
        src = lines[i + 1] if i + 1 < len(lines) else ''
        m = re.search(r'source: (\S+)', src)
        pairs.append((l[2:], m.group(1) if m else None))
miss = 0
for q, s in pairs:
    if fault:
        q = q + ' zzfault'
    text = open(s).read()
    if q in text:
        how = 'verbatim'
    elif ' '.join(q.split()) in ' '.join(text.split()):
        how = 'verbatim (whitespace normalised: the source wraps the line)'
    else:
        how = 'MISSING'; miss += 1
    print(f'{s}: {how}: {q[:70]!r}')
print(f'quotations {len(pairs)} missing {miss}')
