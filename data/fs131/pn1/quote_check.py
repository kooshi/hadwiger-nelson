#!/usr/bin/env python3
"""FS131-PN1 readback: every quotation in the brief against its source, character for character
(whitespace runs collapsed, the blockquote markers stripped). Exit 0 iff all match.
Usage: quote_check.py [--fault]   (--fault alters one character of the first quotation; must exit 1)."""
import re, sys
BRIEF = 'data/fs131/briefs/FS131-PN1-number-field-ranking.md'
SRC = 'data/fs131/REQUEST-2026-10-13.md'
b = open(BRIEF, encoding='utf-8').read()
s = open(SRC, encoding='utf-8').read()
mism = 0
n = 0
for i, tag in enumerate(('W1', 'H1')):
    m = re.search(r'> ' + tag + r': (.*?)\n> — source: (\S+)', b, re.S)
    assert m, tag
    assert m.group(2) == SRC, m.group(2)
    q = re.sub(r'\s+', ' ', ' '.join(l.lstrip('> ').strip() for l in m.group(1).split('\n'))).strip()
    if '--fault' in sys.argv and i == 0:
        q = q[:40] + ('X' if q[40] != 'X' else 'Y') + q[41:]
    src = [l for l in s.split('\n') if l.startswith(tag + ': ')]
    assert len(src) == 1, tag
    src = re.sub(r'\s+', ' ', src[0][len(tag) + 2:]).strip()
    n += 1
    ok = q == src
    mism += (not ok)
    print(f'{tag}: {"MATCH" if ok else "MISMATCH"} ({len(q)} chars against {len(src)})')
print(f'quotations={n} mismatches={mism}')
sys.exit(1 if mism else 0)
