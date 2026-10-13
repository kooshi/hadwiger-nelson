#!/usr/bin/env python3
"""FS131-EN1 stage 1: every block quotation in the brief against the file its source line names.

A quotation is a line of the brief starting with "> " whose next line is "> — source: <path> ...".
Prints the number of quotations that are NOT a verbatim line of their source (expect 0), then the number checked.
--plant: change one character of each quotation before comparing (every one must then miss)."""
import sys, re, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root / "data/fs131/briefs/FS131-EN1-shorter-route.md").read_text().splitlines()
plant = "--plant" in sys.argv
miss = n = 0
for i, line in enumerate(brief[:-1]):
    m = re.match(r"> — source: (\S+)", brief[i + 1])
    if not (line.startswith("> ") and m):
        continue
    q = line[2:]
    if plant:
        q = q[:10] + ("x" if q[10] != "x" else "y") + q[11:]
    src = (root / m.group(1)).read_text().splitlines()
    n += 1
    if q not in src:
        miss += 1
print(miss, n)
