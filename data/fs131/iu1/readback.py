#!/usr/bin/env python3
"""FS131-IU1 stage 1: the brief's quotations against their sources.

A quotation in the brief is a `> ` line followed by a `> — source: path` line. Three kinds:
`> ID: text` with ID = NF1-...  -> compared character for character with the line `ID: text` of the claim list;
`> W2: text`                    -> searched verbatim (whitespace runs collapsed) in the request file;
`> - <date> — text`             -> a dated line: compared character for character with a line of the claim list.
The sources are read from the main checkout (the brief and the claim list's dated lines live there, not on this branch).
`--control` plants a one-word change in every quotation and must report DIFFERS for each; exit 0 only when the verdicts
are the expected ones.
"""
import re, sys, pathlib
MAIN = pathlib.Path("/home/kooshi/source/lean-dir")
BRIEF = MAIN / "data/fs131/briefs/FS131-IU1-leaves.md"
CLAIMS = MAIN / "data/fs131/claims-NF1.md"
REQ = MAIN / "data/fs131/REQUEST-2026-10-13.md"
control = "--control" in sys.argv
brief = BRIEF.read_text()
claim_lines = CLAIMS.read_text().splitlines()
req = REQ.read_text()
norm = lambda s: re.sub(r"\s+", " ", s)
n = bad = 0
for m in re.finditer(r"^> (.*)\n> — source: (\S+)", brief, re.M):
    line, src = m.group(1), m.group(2)
    n += 1
    tag = line[:28].replace("\n", " ")
    if control:
        line = line.replace(" the ", " a ", 1) if " the " in line else line + " x"
    if line.startswith("W2: "):
        ok = norm(line[4:]) in norm(req)
    else:
        ok = line in claim_lines
    print(f"[{tag}…]: {'IDENTICAL' if ok else 'DIFFERS'} ({len(line)} characters; source {src})")
    bad += (not ok)
print(f"compared={n} differing={bad} mode={'control' if control else 'real'}")
sys.exit(0 if (n > 0 and (bad == n if control else bad == 0)) else 1)
