#!/usr/bin/env python3
"""FS131-IWd: append a `#print axioms` record to scripts/Axioms.lean for every theorem of Woodall's chain that has none.

Not a check (the check is tools/fs131_w3_decls.py --check, run after this): it reads that tool's names() and records(), and inserts each
missing name, in module order, at the end of the section "FS-131 Woodall's merge (job FS131-IWd)", which it creates after the FS131-W3 merge
section if absent. Prints what it added; changes nothing when nothing is missing.
"""
import pathlib, sys
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import fs131_w3_decls as W

ROOT = pathlib.Path(__file__).resolve().parents[1]
AX = ROOT / "scripts" / "Axioms.lean"
HDR = ("/-! ## FS-131 Woodall's merge (job FS131-IWd) — the picture from the local data (side colours, runs, horns), the crossings a merge "
       "creates, E3-NICE's measure -/")
W3 = "/-! ## FS-131 Woodall's merge (job FS131-W3)"

miss, _ = W.compare(W.names(), W.records())
if not miss:
    print("nothing missing"); sys.exit(0)
lines = AX.read_text().split("\n")
if HDR not in lines:
    i = next(n for n, l in enumerate(lines) if l.startswith(W3))
    j = i + 1
    while j < len(lines) and not lines[j].startswith("/-! ## "):
        j += 1
    lines[j:j] = [HDR, "", ""]
i = lines.index(HDR)
j = i + 1
while j < len(lines) and not lines[j].startswith("/-! ## "):
    j += 1
while lines[j - 1] == "" and j - 1 > i + 1:
    j -= 1
lines[j:j] = [f"#print axioms {n}" for n in miss]
AX.write_text("\n".join(lines))
for n in miss:
    print("ADDED", n)
