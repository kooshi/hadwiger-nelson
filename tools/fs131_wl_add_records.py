#!/usr/bin/env python3
"""FS131-WL1: append a `#print axioms` record to scripts/Axioms.lean for every theorem of Woodall's chain that has none.

Not a check (the check is tools/fs131_w3_decls.py --check, run after this; FS131-W3's, read-only here): it reads that tool's names() and
records() and inserts each missing name, in module order, at the end of the section "FS-131 Woodall's chain (job FS131-WL1)", which it
creates after the last Woodall section if absent (its heading starts "FS-131 Woodall's chain", so the check reads it). Prints what it added;
changes nothing when nothing is missing.
"""
import pathlib, sys
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import fs131_w3_decls as W

ROOT = pathlib.Path(__file__).resolve().parents[1]
AX = ROOT / "scripts" / "Axioms.lean"
HDR = ("/-! ## FS-131 Woodall's chain (job FS131-WL1) — the plane-map model (QA2-1): the brick map's T-junctions, its pictures, Woodall's "
       "normal form on the plane, Condition 5; the adversaries off the domain -/")

miss, _ = W.compare(W.names(), W.records())
if not miss:
    print("nothing missing"); sys.exit(0)
lines = AX.read_text().split("\n")
if HDR not in lines:
    last = max(n for n, l in enumerate(lines) if W.SECTION.match(l))
    j = last + 1
    while j < len(lines) and not lines[j].startswith("/-! ## "):
        j += 1
    while lines[j - 1] == "":
        j -= 1
    lines[j:j] = ["", HDR, ""]
i = lines.index(HDR)
j = i + 1
while j < len(lines) and not lines[j].startswith("/-! ## ") and not lines[j].startswith("#eval"):
    j += 1
while lines[j - 1] == "" and j - 1 > i + 1:
    j -= 1
lines[j:j] = [f"#print axioms {n}" for n in miss]
AX.write_text("\n".join(lines))
for n in miss:
    print("ADDED", n)
