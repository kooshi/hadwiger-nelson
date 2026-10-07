#!/usr/bin/env python3
"""FS124-P1 readback: every block quotation in the brief against its named source.
A quotation is a run of lines starting '> ' ended by a line '> — source: <path>[ § ...]'.
Match is exact-substring after stripping the leading '> ' (and a second '> ' for nested quotes);
whitespace is NOT normalised. Exit 1 on any miss."""
import sys, re, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root / "data/fs124/briefs/FS124-P1-question.md").read_text().splitlines()
quotes, cur = [], []
for i, line in enumerate(brief, 1):
    if line.startswith("> — source:"):
        src = line[len("> — source:"):].strip()
        path = src.split(" § ")[0].strip()
        quotes.append((cur, path, i)); cur = []
    elif line.startswith("> "):
        cur.append((i, line[2:]))
    else:
        cur = []
bad = 0
for lines, path, at in quotes:
    text = (root / path).read_text()
    for (i, q) in lines:
        cands = [q]
        if q.startswith("> "): cands.append(q[2:])
        hit = any(c in text for c in cands)
        n = max(text.count(c) for c in cands)
        print(f"{'ok  ' if hit else 'MISS'} brief:{i:3d} -> {path} (occurrences {n}): {q[:70]}")
        bad += (not hit)
print(f"quotations: {len(quotes)}  lines: {sum(len(l) for l,_,_ in quotes)}  misses: {bad}")
sys.exit(1 if bad else 0)
