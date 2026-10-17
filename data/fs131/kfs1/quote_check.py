#!/usr/bin/env python3
"""FS131-KFS1 stage 1: check every block quotation of the brief against its named source.

Each quote is a run of '> ' lines ending in '> — source: <path>[ § …]'. The quote's text, with the '> ' prefixes
removed and every run of whitespace collapsed, must occur in the source with its own line prefixes ('> ') removed and
whitespace collapsed. Prints FOUND / MISSING per quote and, for a miss, the longest prefix that is found.
Usage: quote_check.py BRIEF ROOT [--plant]   (--plant alters one character of the first quote: it must read MISSING)
"""
import re, sys, pathlib

def norm(s):
    s = re.sub(r'(?m)^\s*(?:>\s?)+', '', s)
    return re.sub(r'\s+', ' ', s).strip()

def quotes(brief):
    out, cur = [], []
    for line in brief.splitlines():
        if line.startswith('>'):
            cur.append(line)
            m = re.match(r'>\s*— source:\s*(\S+)', line)
            if m:
                out.append((m.group(1).rstrip(','), '\n'.join(cur[:-1])))
                cur = []
        else:
            cur = []
    return out

def main():
    brief, root = pathlib.Path(sys.argv[1]).read_text(), pathlib.Path(sys.argv[2])
    qs = quotes(brief)
    if '--plant' in sys.argv:
        src, q = qs[0]
        qs[0] = (src, q.replace('formalize', 'formalise', 1))
    bad = 0
    for src, q in qs:
        text = norm((root / src).read_text())
        nq = norm(q)
        if nq in text:
            print(f'FOUND   {src}  ({len(nq)} chars)')
            continue
        bad += 1
        lo, hi = 0, len(nq)
        while lo < hi:
            mid = (lo + hi + 1) // 2
            if nq[:mid] in text: lo = mid
            else: hi = mid - 1
        print(f'MISSING {src}  ({len(nq)} chars); longest found prefix {lo}: ...{nq[max(0,lo-60):lo]!r} | next {nq[lo:lo+80]!r}')
    print(f'{len(qs)} quotes, {bad} missing')
    sys.exit(1 if bad else 0)

main()
