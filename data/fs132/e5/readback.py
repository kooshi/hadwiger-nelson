#!/usr/bin/env python3
"""FS132-E5 readback: every quotation in the brief checked against its source (exact substring).
With --fault the first quotation has one character changed; the count of mismatches must then be 1."""
import sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root/'data/fs132/briefs/FS132-E5-witness-card.md').read_text()
lines = brief.split('\n')
quotes = []
i = 0
while i < len(lines):
    if lines[i].startswith('> ') and not lines[i].startswith('> — source:'):
        q = []
        while i < len(lines) and lines[i].startswith('>') and not lines[i].startswith('> — source:'):
            q.append(lines[i][2:] if lines[i].startswith('> ') else lines[i][1:])
            i += 1
        src = lines[i][len('> — source: '):] if i < len(lines) and lines[i].startswith('> — source:') else None
        quotes.append(('\n'.join(q), src))
    i += 1
if '--fault' in sys.argv and quotes:
    q0, s0 = quotes[0]
    quotes[0] = (q0[:-1] + ('#' if q0[-1] != '#' else '!'), s0)
ok = bad = 0
for q, src in quotes:
    path = src.split(' ')[0] if src else None
    text = (root/path).read_text() if path and (root/path).exists() else ''
    qq = q[2:] if q.startswith('> ') else q   # Kooshi's words are doubly quoted
    hit = qq in text
    if '-v' in sys.argv:
        print(('OK  ' if hit else 'MISS'), '|', (src or 'NO SOURCE'), '|', qq[:70].replace('\n', ' '))
    ok += hit; bad += (not hit)
print(f'quotations={ok+bad} matched={ok} mismatched={bad}')
