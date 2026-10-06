#!/usr/bin/env python3
"""FS131-I6C stage 1: check every '>'-quotation of the brief against the file its '— source:' line names.

Exact substring match, the '> ' marker stripped. A source line is '<path>[ <words locating the passage>]': the path is
its first whitespace-delimited token; a relative path is read in the main tree (where the brief was written), an
absolute one as given. Prints one line per quotation and a count; exit 1 on a mismatch, and exit 2 if the brief holds
no quotation at all (a check that found nothing to check has not passed).

Usage: python3 tools/fs131_i6c_quotes.py [--plant]
  --plant alters the first quotation by one character: the check must then report one mismatch and exit 1."""
import sys, pathlib

MAIN = pathlib.Path("/home/kooshi/source/lean-dir")
BRIEF = MAIN / "data/fs131/briefs/FS131-I6C-wave6-bridge.md"

quotes, cur = [], []
for line in BRIEF.read_text().splitlines():
    if line.startswith("> — source:"):
        src = line.split("source:", 1)[1].strip().split()[0]
        quotes.append(("\n".join(cur), src))
        cur = []
    elif line.startswith("> "):
        cur.append(line[2:])
    elif line.startswith(">"):
        cur.append(line[1:])
    else:
        cur = []
if not quotes:
    print("NO QUOTATION FOUND in", BRIEF)
    sys.exit(2)
if "--plant" in sys.argv:
    q, s = quotes[0]
    quotes[0] = (q[:-1] + ("x" if q[-1] != "x" else "y"), s)
bad = 0
for q, s in quotes:
    p = pathlib.Path(s) if s.startswith("/") else MAIN / s
    ok = p.exists() and bool(q) and q in p.read_text()
    bad += not ok
    print(("exact   " if ok else "MISMATCH") + " | " + q[:78].replace("\n", " // ") + " | " + s)
print(f"quotations: {len(quotes)}  exact: {len(quotes) - bad}  mismatched: {bad}")
sys.exit(1 if bad else 0)
