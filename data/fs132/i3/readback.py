#!/usr/bin/env python3
"""FS132-I3 stage 1: check every quotation of the brief against its source, as a literal substring.
Usage: readback.py [--fault]   (--fault alters one quotation by one character and must report a mismatch)"""
import re, sys, pathlib
ROOT = pathlib.Path('/home/kooshi/source/lean-dir')
brief = (ROOT / 'data/fs132/briefs/FS132-I3-step-lemma.md').read_text()
lines = brief.split('\n')
quotes = []
i = 0
while i < len(lines):
    if lines[i].startswith('> ') and not lines[i].startswith('> — source:'):
        q = []
        while i < len(lines) and lines[i].startswith('> ') and not lines[i].startswith('> — source:'):
            q.append(lines[i][2:]); i += 1
        src = None
        if i < len(lines) and lines[i].startswith('> — source:'):
            src = lines[i][len('> — source:'):].strip(); i += 1
        quotes.append((' '.join(q), src))
    else:
        i += 1
fault = '--fault' in sys.argv
bad = 0
def norm(s): return re.sub(r'\s+', ' ', s).strip()
for n, (q, src) in enumerate(quotes, 1):
    if q.startswith('> '): q = q[2:]            # a quotation of a quotation
    if fault and n == 3: q = q.replace('MeasurableSet S', 'MeasurableSet T')
    path = src.split(' ')[0]
    p = pathlib.Path(path) if path.startswith('/') else ROOT / path
    text = norm(p.read_text())
    ok = norm(q) in text
    bad += (not ok)
    print(f"{n:2d} {'MATCH   ' if ok else 'MISMATCH'} {src}\n      {q[:100]}")
print(f"quotations={len(quotes)} matched={len(quotes)-bad} mismatched={bad}")
sys.exit(1 if bad else 0)
