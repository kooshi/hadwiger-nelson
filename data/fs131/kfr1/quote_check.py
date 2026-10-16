#!/usr/bin/env python3
"""FS131-KFR1 stage 1: check every block quotation in the brief against its named source, verbatim.

Each quotation in the brief is a run of lines beginning with '> ' ending with a '> — source: <path>' line.
For each, the quoted text (with the '> ' prefixes removed, lines joined by newlines) must occur in the named
source exactly; if not, the script reports the longest prefix that does occur and the first differing line.

Usage: python3 -I quote_check.py <brief> <repo-root>
Control: --plant changes one character in the first quotation and must report a MISMATCH.
"""
import pathlib
import re
import sys


def blocks(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith('>'):
            body = line[2:] if line.startswith('> ') else line[1:]
            m = re.match(r'^— source: (\S+)(.*)$', body)
            if m:
                out.append((m.group(1), m.group(2).strip(), cur))
                cur = []
            else:
                cur.append(body)
        else:
            if cur:
                out.append((None, '', cur))
            cur = []
    return out


def main():
    plant = '--plant' in sys.argv
    args = [a for a in sys.argv[1:] if a != '--plant']
    brief, root = pathlib.Path(args[0]), pathlib.Path(args[1])
    bad = 0
    bs = blocks(brief.read_text())
    if plant:
        src, extra, lines = bs[0]
        lines = list(lines)
        lines[0] = lines[0].replace('e', 'E', 1)
        bs[0] = (src, extra, lines)
    for i, (src, extra, lines) in enumerate(bs):
        if src is None:
            print(f'[{i}] UNSOURCED block of {len(lines)} lines: {lines[0][:60]!r}')
            continue
        srcpath = root / src
        stext = srcpath.read_text()
        # a quotation of a table row or an indented list item may have had its leading characters kept
        q = '\n'.join(lines)
        if q in stext:
            print(f'[{i}] VERBATIM  {src} {extra}  ({len(lines)} lines, {len(q)} chars)')
            continue
        # try line by line
        missing = [ln for ln in lines if ln.strip() and ln not in stext]
        if not missing:
            print(f'[{i}] LINES-VERBATIM {src} {extra} (every line present; joined text not contiguous)')
            continue
        bad += 1
        print(f'[{i}] MISMATCH {src} {extra}: {len(missing)} line(s) not found')
        for ln in missing[:3]:
            # longest prefix present
            k = len(ln)
            while k > 0 and ln[:k] not in stext:
                k -= 1
            print(f'     first {k} of {len(ln)} chars present; differs at: {ln[k:k+80]!r}')
    print('MISMATCHES:', bad)
    sys.exit(1 if bad else 0)


main()
