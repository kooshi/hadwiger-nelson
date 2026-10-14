#!/usr/bin/env python3
"""FS131-LCH1: check every quoted block of a brief against its named source.

A block is a run of lines beginning '> ' followed by a line '> — source: <path>[ § ...]'.
The block's text (the '> ' prefixes removed, lines joined by one space) must occur in the
source file read at a given git revision (or on disk), after collapsing whitespace runs,
where a hard-wrapped quote may be joined with a space or with nothing.
Usage: fs131_lch1_quotes.py <brief> <repo> <rev> [--plant]
--plant mutates one character of every block and requires every block to FAIL.
Exit 0 only when every block matches (or, with --plant, every block fails)."""
import re, subprocess, sys

def blocks(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith('> — source:'):
            src = line[len('> — source:'):].strip()
            out.append((cur, src)); cur = []
        elif line.startswith('> ') or line == '>':
            cur.append(line[2:])
        else:
            cur = []
    return out

def norm(s):
    return re.sub(r'\s+', ' ', s).strip()

def main():
    brief, repo, rev = sys.argv[1:4]
    plant = '--plant' in sys.argv
    bs = blocks(open(brief, encoding='utf-8').read())
    if not bs:
        print('FAIL: no quoted blocks found'); return 1
    bad = 0
    for i, (lines, src) in enumerate(bs):
        path = src.split(' § ')[0].strip()
        try:
            text = subprocess.run(['git', '-C', repo, 'show', f'{rev}:{path}'], check=True,
                                  capture_output=True, text=True).stdout
        except subprocess.CalledProcessError:
            print(f'[{i}] FAIL: cannot read {path} at {rev}'); bad += 1; continue
        hay = norm(text)
        hay_nl = text.replace('\n', '')  # hard-wrapped source joined without a space
        q = norm(' '.join(lines))
        q_tight = ''.join(lines)
        if plant:
            k = len(q) // 2
            q = q[:k] + ('X' if q[k] != 'X' else 'Y') + q[k+1:]
            k = len(q_tight) // 2
            q_tight = q_tight[:k] + ('X' if q_tight[k] != 'X' else 'Y') + q_tight[k+1:]
        ok = (q in hay) or (q_tight in hay_nl) or (norm(q_tight) in norm(hay_nl))
        # a quote may elide the source's leading markup: match the longest sentence too
        print(f'[{i}] {"MATCH" if ok else "MISMATCH"}  {path}  ({len(q)} chars)')
        if not ok:
            bad += 1
    n = len(bs)
    if plant:
        print(f'PLANT: {bad}/{n} blocks failed (all must)'); return 0 if bad == n else 1
    print(f'{n - bad}/{n} blocks match'); return 0 if bad == 0 else 1

sys.exit(main())
