#!/usr/bin/env python3
"""FS131-E7 § 1.4: count how `nb4p`'s proof body uses `hnb`.  --plant rewrites the one use to take the whole hypothesis,
to show the count can come out otherwise."""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
src = (ROOT / "Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean").read_text().splitlines()
i0 = next(i for i, l in enumerate(src) if l.startswith("theorem nb4p "))
i1 = next(i for i in range(i0, len(src)) if src[i].rstrip().endswith("False := by"))
body = []
for l in src[i1 + 1:]:
    if l.startswith("end ") or l.startswith("theorem ") or l.startswith("/--"): break
    body.append(l)
text = "\n".join(body)
if "--plant" in sys.argv: text = text.replace("(hnb k hk).1", "(hnb k hk)")
uses = [m.end() for m in re.finditer(r"\bhnb\b", text)]
first = sum(1 for m in re.finditer(r"\(hnb [^()]*\)\.1", text))
print(f"uses of hnb in the proof body: {len(uses)}  through .1: {first}  through .2 or whole: {len(uses) - first}")
