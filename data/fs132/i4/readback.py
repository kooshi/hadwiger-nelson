#!/usr/bin/env python3
"""FS132-I4 stage 1: every quotation of the brief against its source.

A quotation is a run of lines starting '> ' ended by a line '> — source: <path> [rest]'.
The check: the quoted text (whitespace-normalized) occurs in the source file
(whitespace-normalized). Exit 1 on any mismatch, and when no quotation was found.

--fault: alter one character of the first quotation; the run must then exit 1.
"""
import re, sys, pathlib

MAIN = pathlib.Path('/home/kooshi/source/lean-dir')
BRIEF = MAIN / 'data/fs132/briefs/FS132-I4-join.md'

def norm(s):
    return re.sub(r'\s+', ' ', s).strip()

def quotations(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith('> — source:'):
            src = line[len('> — source:'):].strip()
            out.append((' '.join(cur), src))
            cur = []
        elif line.startswith('>'):
            body = line[1:].strip()
            # the brief nests one level for Kooshi's word ('> > ...')
            if body.startswith('>'):
                body = body[1:].strip()
            cur.append(body)
        else:
            cur = []
    return out

def source_path(src):
    first = src.split()[0]
    p = pathlib.Path(first)
    if not p.is_absolute():
        p = MAIN / first
    return p

def main():
    fault = '--fault' in sys.argv
    qs = quotations(BRIEF.read_text())
    if not qs:
        print('NO QUOTATION FOUND'); return 1
    bad = 0
    for n, (q, src) in enumerate(qs, 1):
        if fault and n == 1:
            q = q.replace('lean backlog', 'lean backlag')
        p = source_path(src)
        if not p.exists():
            print(f'{n:2d} MISSING SOURCE {p}'); bad += 1; continue
        ok = norm(q) in norm(p.read_text())
        print(f'{n:2d} {"MATCH   " if ok else "MISMATCH"} {p.relative_to(MAIN) if str(p).startswith(str(MAIN)) else p} :: {norm(q)[:70]}')
        bad += (not ok)
    print(f'quotations={len(qs)} matched={len(qs)-bad} mismatched={bad}')
    return 1 if bad else 0

sys.exit(main())
