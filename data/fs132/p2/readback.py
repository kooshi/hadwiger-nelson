#!/usr/bin/env python3
"""FS132-P2 readback: every quotation in the brief checked against its source (exact substring)."""
import re, sys, pathlib
root = pathlib.Path('/home/kooshi/source/lean-dir')
brief = (root/'data/fs132/briefs/FS132-P2-night-rerank.md').read_text()
lines = brief.split('\n')
ok = bad = 0
i = 0
quotes = []
while i < len(lines):
    if lines[i].startswith('> ') and not lines[i].startswith('> — source:'):
        q = []
        while i < len(lines) and lines[i].startswith('>') and not lines[i].startswith('> — source:'):
            q.append(lines[i][2:] if lines[i].startswith('> ') else lines[i][1:])
            i += 1
        src = lines[i][len('> — source: '):] if i < len(lines) and lines[i].startswith('> — source:') else None
        quotes.append(('\n'.join(q), src))
    i += 1
for q, src in quotes:
    path = src.split(' ')[0] if src else None
    text = (root/path).read_text() if path and (root/path).exists() else ''
    qq = q[2:] if q.startswith('> ') else q   # Kooshi's words are doubly quoted
    hit = qq in text
    print(('OK  ' if hit else 'MISS'), '|', (src or 'NO SOURCE'), '|', qq[:70].replace('\n', ' '))
    ok += hit; bad += (not hit)
print(f'quotations: {ok+bad}  matched: {ok}  mismatched: {bad}')
sys.exit(1 if bad else 0)
