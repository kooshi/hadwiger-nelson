#!/usr/bin/env python3
"""FS131-E8 stage 1: check every '>'-quotation of the brief against the file its '— source:' line names.
Exact substring match, the '> ' marker stripped. Prints one line per quotation and a count; exit 1 on a mismatch.
Usage: python3 quotes.py [--plant]   (--plant alters the first quotation by one character: the check must then fail)"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
brief = (ROOT / "data/fs131/briefs/FS131-E8-regj-bridge.md").read_text().splitlines()
quotes, cur = [], []
for line in brief:
    if line.startswith("> — source:"):
        src = line.split("source:", 1)[1].strip()
        quotes.append(("\n".join(cur), src)); cur = []
    elif line.startswith("> "):
        cur.append(line[2:])
    else:
        cur = []
if "--plant" in sys.argv and quotes:
    q, s = quotes[0]; quotes[0] = (q[:-1] + ("x" if q[-1] != "x" else "y"), s)
bad = 0
for q, s in quotes:
    p = pathlib.Path(s) if s.startswith("/") else ROOT / s
    ok = p.exists() and q in p.read_text()
    bad += not ok
    print(("exact   " if ok else "MISMATCH") + " | " + q[:70].replace("\n", " ⏎ ") + " | " + str(p.relative_to(ROOT)))
print(f"quotations: {len(quotes)}  exact: {len(quotes) - bad}  mismatched: {bad}")
sys.exit(1 if bad else 0)
