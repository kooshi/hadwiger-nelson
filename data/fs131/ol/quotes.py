#!/usr/bin/env python3
"""FS131-OL1: check every quotation of the brief against its source (standing rule 3).
Every `> ` line of the brief followed by a `> — source: <path>` line is searched as an exact substring of the source file.
Usage: quotes.py <brief> --root <tree> [--plant]   (a relative source path is read under <tree>, the tree the brief was written in;
--plant alters the first quotation by a character and must report exactly one MISMATCH)
Exit 0 iff every quotation is found; 1 on a mismatch or a missing source; 2 if the brief holds no quotation."""
import os, re, sys
brief = sys.argv[1]; plant = '--plant' in sys.argv; root = sys.argv[sys.argv.index('--root') + 1]
b = open(brief).read().split('\n'); i = 0; n = 0; bad = 0
while i < len(b) - 1:
    if b[i].startswith('> ') and b[i + 1].startswith('> — source: '):
        q = b[i][2:]; path = re.match(r'> — source: (\S+)', b[i + 1]).group(1); n += 1
        if plant and n == 1:
            q = q[:10] + 'X' + q[11:]
        if not os.path.isabs(path):
            path = os.path.join(root, path)
        try:
            t = open(path).read().split('\n')
        except OSError as e:
            print(f'MISSING   {path}: {e}'); bad += 1; i += 2; continue
        hits = [k + 1 for k, line in enumerate(t) if q in line]
        if hits:
            print(f'verbatim  l. {hits[0]:5}  {path}  |  {q[:80]}')
        else:
            print(f'MISMATCH             {path}  |  {q[:80]}'); bad += 1
        i += 2
    else:
        i += 1
print(f'quotations={n} mismatches={bad}')
sys.exit(2 if n == 0 else (1 if bad else 0))
