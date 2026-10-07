#!/usr/bin/env python3
"""EXT-OAI1 stage 1: check every quotation in the brief against its source.

A quotation is a run of lines beginning '> ' closed by a line '> — source: <path>'.
The check: the quotation's text, whitespace-normalized, occurs in the source file,
whitespace-normalized.  Relative sources resolve against the repository root.
Exit 0 iff every quotation is found; --control plants a one-character change in
the third quotation (the catalogue's claim) and must then exit 1.
"""
import re, sys, pathlib
ROOT = pathlib.Path('/home/kooshi/source/lean-dir')
BRIEF = ROOT / 'data/external/briefs/EXT-OAI1-outside-five-colour-lean.md'
def norm(s): return re.sub(r'\s+', ' ', s).strip()
def quotes(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith('> — source:'):
            src = line.split('source:', 1)[1].strip()
            out.append(('\n'.join(cur), src)); cur = []
        elif line.startswith('>'):
            body = line[1:]
            if body.startswith(' '): body = body[1:]
            # a nested quote marker ("> > words") is the request file's own '>'
            cur.append(body)
        elif line.strip() == '':
            if cur and not cur[-1].strip(): pass
            cur.append('') if cur else None
        else:
            cur = []
    return out
def main():
    control = '--control' in sys.argv
    qs = quotes(BRIEF.read_text())
    bad = 0
    for i, (q, src) in enumerate(qs):
        p = pathlib.Path(src)
        if not p.is_absolute(): p = ROOT / p
        text = norm(p.read_text())
        nq = norm(q)
        if control and i == 2: assert 'five' in nq; nq = nq.replace('five', 'fivc', 1)
        ok = nq in text
        if not ok and nq.startswith('> '):       # the request file quotes Kooshi with its own '>'
            ok = norm(nq[2:]) in text.replace('> ', '')
        print(f"{'OK  ' if ok else 'MISS'} [{i+1}] {src}: {nq[:90]!r}")
        bad += (not ok)
    print(f"quotations={len(qs)} missing={bad}")
    sys.exit(1 if bad else 0)
main()
