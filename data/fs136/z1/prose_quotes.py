#!/usr/bin/env python3
"""FS136-Z1: every double-quoted phrase in the record job's own prose (a file's lines outside `derivation:`/`control:`
blocks and outside block quotes) must occur verbatim in a source.  A phrase is split at "…"; each fragment of twelve
characters or more must be a substring of the corpus (inner double quotes may appear as single quotes in the prose;
emphasis asterisks are ignored on both sides; double quotes pair in order).
  python3 data/fs136/z1/prose_quotes.py <file> [--fault]     exit 1 on any fragment not found
--fault alters one character of the first fragment (it must then be reported).
"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
CORPUS = ["plans/FS136-E1-derivation.md", "plans/FS136-E2-derivation.md", "data/fs136/claims.md", "plans/FS136-close-inventory.md",
          "plans/FS124-close-inventory.md", "plans/POROS-2026-10-07-fs136-round1.md", "plans/STUB-covering-pairs.md",
          "plans/FS136-the-point-across.md", "plans/FS124-derivation.md", "plans/FS124-E2-derivation.md", "data/fs136/reports/FS136-E1.md",
          "data/fs136/reports/FS136-E2.md", "data/fs136/reports/FS136-P1.md", "LEDGER.md", "CLAUDE.md", "plans/FS116-derivation.md",
          "plans/FRONTIER-STUBS.md", "data/fs136/briefs/FS136-Z1-record.md", ".claude/skills/grokkings/SKILL.md", "plans/SEARCH-QUEUE.md",
          "plans/GROKKING-INSTANCES.md", "plans/FS136-derivation.md", "plans/STUB-lateral-extent.md", "plans/STUB-seed-remainder.md", "plans/STUB-q-ring.md"]
corpus = "\n".join((ROOT / p).read_text() for p in CORPUS if (ROOT / p).exists())
corpus_flat = re.sub(r"\s+", " ", corpus).replace("*", "")          # emphasis marks are not part of a quotation
target = pathlib.Path(sys.argv[1])
own, inblock = [], False
for line in target.read_text().splitlines():
    if re.match(r"^(derivation|control|verification|invention): \S+", line): inblock = True; continue
    if inblock:
        if line.strip() == "": inblock = False
        continue
    if line.startswith(">"): continue
    own.append(line)
text = re.sub(r"\s+", " ", " ".join(own))
frags = []
pos = [m.start() for m in re.finditer('"', text)]
if len(pos) % 2: print("WARNING: odd number of double quotes in the prose")
for a, b in zip(pos[0::2], pos[1::2]):          # quotes pair in order: 1st with 2nd, 3rd with 4th, ...
    for f in text[a + 1:b].split("…"):
        f = f.strip(" ,;:.")
        if len(f) >= 12: frags.append(f)
bad = 0
for i, f in enumerate(frags):
    probe = f
    if "--fault" in sys.argv and i == 0: probe = f[:5] + "#" + f[6:]
    probe = probe.replace('*', '')
    ok = probe in corpus_flat or probe.replace("'", '"') in corpus_flat
    if not ok:
        bad += 1; print("NOT FOUND:", probe[:160])
print(f"{target.name}: quoted fragments={len(frags)} not-found={bad}")
sys.exit(1 if bad else 0)
