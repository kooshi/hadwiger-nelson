#!/usr/bin/env python3
"""FS124-P2 readback: every block quotation of the brief against its source.

A quotation is a line beginning "> " followed by a line "> — source: <path>[ § ...]".
A quoted line that is itself quoted in its source (begins "> ") is matched without the mark.
Each quoted line must occur verbatim in the source file (as one line's prefix or substring).
Exit 0 if all match, 1 otherwise.  --fault changes one character of the first quotation.
"""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root / "data/fs124/briefs/FS124-P2-round-one.md").read_text().splitlines()
fault = "--fault" in sys.argv
quotes = []
i = 0
while i < len(brief):
    if brief[i].startswith("> ") and not brief[i].startswith("> — source:"):
        block = []
        while i < len(brief) and brief[i].startswith("> ") and not brief[i].startswith("> — source:"):
            block.append(brief[i][2:])
            i += 1
        src = None
        if i < len(brief) and brief[i].startswith("> — source:"):
            src = brief[i][len("> — source:"):].strip()
            i += 1
        quotes.append((block, src))
    else:
        i += 1
miss = 0
n = 0
for block, src in quotes:
    path = re.split(r"\s+§", src)[0].strip() if src else None
    text = (root / path).read_text() if path and (root / path).exists() else None
    for line in block:
        n += 1
        q = line[2:] if line.startswith("> ") else line
        if fault and n == 1:
            q = q[:10] + ("X" if q[10] != "X" else "Y") + q[11:]
        ok = text is not None and q in text
        if not ok:
            miss += 1
        print(("ok   " if ok else "MISS ") + f"[{path}] {q[:90]}")
print(f"quotations={len(quotes)} lines={n} misses={miss}")
sys.exit(1 if miss else 0)
