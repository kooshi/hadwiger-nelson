#!/usr/bin/env python3
"""FS121-DB1 readback: quotation checks (standing rule 3).

(1) Every statement the brief quotes (its '> ' blocks) must occur verbatim, whitespace aside, in the frozen claim list.
(2) Every double-quoted string in the frozen list's sections 0 and 1 must occur verbatim, whitespace aside, in one of its
    open source files (the one source that is fenced for this job, FS-116's opening, is reported as NOT CHECKED).

Usage:  python3 tools/fs121_db1_quotes.py            # the check; exit 0 iff every checkable quotation is found
        python3 tools/fs121_db1_quotes.py --plant    # the same with one character of one quotation changed in each part;
                                                      # it must report the two planted quotations missing and exit 1
        --summary (with or without --plant) prints only the final 'failures: N' line and exits 0 (the record's control)
"""
import re
import sys

ROOT = '/home/kooshi/source/lean-dir/'
BRIEF = ROOT + 'data/fs121/briefs/FS121-DB1-verify.md'
CLAIMS = ROOT + 'data/fs121/claims.md'
SOURCES = [
    'data/fs106/claims.md', 'data/fs111/claims.md', 'data/fs114/claims.md',
    'plans/FS111-M-regularity.md', 'plans/FS111-M2-regularity.md', 'plans/FS111-derivation.md',
    'plans/FS112-derivation.md',
]
FENCED_MARK = "FS-116's opening"


def norm(s):
    return re.sub(r'\s+', ' ', s).strip()


def brief_blocks(text):
    blocks, cur = [], []
    for line in text.splitlines():
        if line.startswith('> '):
            cur.append(line[2:])
        elif cur:
            blocks.append(cur)
            cur = []
    if cur:
        blocks.append(cur)
    out = []
    for b in blocks:
        body = norm(' '.join(l for l in b if not l.startswith('— source')))
        out.append(re.sub(r'^- ', '', body))
    return out


def list_quotes(text):
    """Double-quoted strings in sections 0 and 1, each with the paragraph it came from."""
    sec = text.split('## 0. Definitions', 1)[1].split('## 2.', 1)[0]
    items = re.split(r'\n- ', sec)
    out = []
    for it in items:
        flat = norm(it)
        for q in re.findall(r'"([^"]+)"', flat):
            out.append((q, flat[:80]))
    return out


def main(plant):
    claims = open(CLAIMS).read()
    cn = norm(claims)
    fails = 0
    print('(1) the brief\'s quotations against the frozen list')
    bb = brief_blocks(open(BRIEF).read())
    if plant:
        bb[0] = bb[0].replace('ends, off a null set', 'ends, off a nul set', 1)
    for b in bb:
        name = re.search(r'\*\*(C121-[A-Z0-9-]+)\*\*', b).group(1)
        ok = b in cn
        fails += not ok
        print(f'  {"FOUND  " if ok else "MISSING"} {name} ({len(b)} chars)')
    print('(2) the frozen list\'s sections 0-1 quotations against their open sources')
    srcs = {p: norm(open(ROOT + p).read()) for p in SOURCES}
    qs = list_quotes(claims)
    if plant:
        qs[0] = (qs[0][0].replace('density 1', 'density one', 1), qs[0][1])
    for q, ctx in qs:
        hits = [p for p, t in srcs.items() if norm(q) in t]
        if hits:
            print(f'  FOUND   {q[:70]!r} in {hits[0]}')
        elif FENCED_MARK in ctx:
            print(f'  NOT CHECKED (source fenced) {q[:70]!r}')
        else:
            fails += 1
            print(f'  MISSING {q[:70]!r}  [{ctx}]')
    print(f'failures: {fails}')
    return 1 if fails else 0


if __name__ == '__main__':
    if '--summary' in sys.argv:  # for the record's control: print only the failure count, exit 0
        import io, contextlib
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            main('--plant' in sys.argv)
        print(buf.getvalue().strip().splitlines()[-1])
        sys.exit(0)
    sys.exit(main('--plant' in sys.argv))
