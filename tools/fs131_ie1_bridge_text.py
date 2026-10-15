#!/usr/bin/env python3
"""FS131-IE1 — the four bridge lemmas in `Rigidity/Entropy` carry FS131-KN6's statements, as text: for each theorem of
`data/fs131/kn6/bridge-statements.lean`, its docstring and its head (from the docstring's opening to the top-level
`:= by`), whitespace-normalized, must occur in `Proofs/HadwigerNelson/Rigidity/Entropy.lean`.  The one difference of
context — the release's namespace, `open MeasureTheory OAI.PrimeDegreePackets` there, `open HadwigerNelson.Outside.OAI015`
in the module's `section Bridge` — is outside the heads and is printed, not compared.  (The kernel's side of the same
question is the statement dump: the four are the allow-list of `tools/fs131_ie1_statements.py`.)
Usage: fs131_ie1_bridge_text.py [--control]   (--control changes one character of one head; it must then mismatch)
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "data/fs131/kn6/bridge-statements.lean"
DST = ROOT / "Proofs/HadwigerNelson/Rigidity/Entropy.lean"


def heads(text):
    out = []
    for m in re.finditer(r"/--.*?-/\s*theorem\s+(\S+).*?:= by", text, flags=re.S):
        out.append((m.group(1), re.sub(r"\s+", " ", m.group(0))))
    return out


src, dst = heads(SRC.read_text()), re.sub(r"\s+", " ", DST.read_text())
if "--control" in sys.argv:
    name, h = src[2]
    src[2] = (name, h.replace("IsProbabilityMeasure", "IsFiniteMeasure", 1))
bad = [n for n, h in src if h not in dst]
for n, h in src:
    print(("MATCH   " if n not in bad else "MISMATCH"), n)
print(f"heads: {len(src)}  mismatched: {len(bad)}")
if not src:
    print("FAIL: no theorem read from the source — the check read nothing")
    sys.exit(2)
if "--control" in sys.argv:
    print("CONTROL " + ("FIRED" if len(bad) == 1 else "DID NOT FIRE"))
    sys.exit(0 if len(bad) == 1 else 1)
sys.exit(1 if bad else 0)
