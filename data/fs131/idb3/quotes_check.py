"""FS131-IDB3 stage 1: every '> ' quotation of the brief, searched verbatim in the source its '— source:' line names (on main)."""
import sys, re
from pathlib import Path
MAIN = Path('/home/kooshi/source/lean-dir')
brief = (MAIN / 'data/fs131/briefs/FS131-IDB3-x23-theorem.md').read_text().splitlines()
blocks, cur = [], []
for ln in brief:
    if ln.startswith('> — source:'):
        blocks.append((cur, ln[len('> — source:'):].strip())); cur = []
    elif ln.startswith('> '):
        cur.append(ln[2:])
bad = 0
for lines, src in blocks:
    path = src.split(" § ")[0].strip()
    text = (MAIN / path).read_text()
    for q in lines:
        ok = q in text
        bad += not ok
        print(("VERBATIM " if ok else "MISMATCH ") + src + ' :: ' + q[:90])
inline = 'Yes, prove the density bound.'
n = (MAIN / 'data/fs131/REQUEST-2026-10-13.md').read_text().count(inline)
print('inline W6 occurrences:', n); bad += (n == 0)
# control: a quotation with one character changed must be reported
ctl = blocks[0][0][0].replace('formalized', 'formalised')
print('control (one letter changed) found verbatim:', ctl in (MAIN / blocks[0][1].split(' § ')[0]).read_text())
print('blocks', len(blocks), 'mismatches', bad)
sys.exit(1 if bad else 0)
