#!/usr/bin/env python3
"""FS131-ISF1 stage 1: check every block quotation of the brief against its named source, in each of the given trees.

A quote is a run of '>' lines ending in '> — source: <path>'. Its text, with every leading run of '>' prefixes removed and
whitespace collapsed, must occur in the source, normalized the same way. Each quote is looked up in every tree given
(the brief names files of `main` and of this branch); FOUND in a tree prints the tree, MISSING in all prints the longest
prefix found. After FS131-KFS1's `quote_check.py` (its nested-prefix fix kept).
Usage: fs131_isf1_quotes.py BRIEF TREE [TREE ...] [--plant]
  --plant changes one character of the third quote ('fractionalChromaticNumber' -> 'fractionalchromaticNumber'):
  it must read MISSING and the exit must be 1.
Exit 0 iff every quote is FOUND in at least one tree.
"""
import pathlib
import re
import sys


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
    args = [a for a in sys.argv[1:] if a != '--plant']
    brief, trees = pathlib.Path(args[0]).read_text(), [pathlib.Path(t) for t in args[1:]]
    qs = quotes(brief)
    if '--plant' in sys.argv:
        src, q = qs[2]
        assert 'fractionalChromaticNumber' in q
        qs[2] = (src, q.replace('fractionalChromaticNumber', 'fractionalchromaticNumber', 1))
    bad = 0
    for k, (src, q) in enumerate(qs):
        nq = norm(q)
        found = []
        for t in trees:
            p = t / src
            if p.exists() and nq in norm(p.read_text()):
                found.append(str(t))
        if found:
            print(f'FOUND   #{k} {src} ({len(nq)} chars) in: {", ".join(found)}')
            continue
        bad += 1
        best = 0
        for t in trees:
            p = t / src
            if not p.exists():
                continue
            text = norm(p.read_text())
            lo, hi = 0, len(nq)
            while lo < hi:
                mid = (lo + hi + 1) // 2
                if nq[:mid] in text:
                    lo = mid
                else:
                    hi = mid - 1
            best = max(best, lo)
        print(f'MISSING #{k} {src} ({len(nq)} chars); longest found prefix {best}: next {nq[best:best+80]!r}')
    print(f'{len(qs)} quotes, {bad} missing')
    sys.exit(1 if bad else 0)


main()
