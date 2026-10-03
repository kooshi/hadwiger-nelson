#!/usr/bin/env python3
"""FS116-Z1: draft LEDGER.md § B lines from plans/FS116-derivation.md (the gate's own parser), one per entry, each theorem's line the entry's
statement truncated at a word boundary (verbatim, never paraphrased); copied from tools/fs121_z1_ledger_b.py and adapted. The grade cell is the
close's reconciliation (plans/FS116-Z1-close.md § 2.1). Usage: fs116_z1_ledger_b.py > data/fs116/fs116-z1/ledger-b-draft.md"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / ".claude/skills/ephodos/scripts"))
import derive_gate as G
HELD = {"FS116-O1-YESLIM", "FS116-O1-SATPIN", "FS116-RING-TWIST-C", "FS116-N1-TWIST-LIT", "FS116-RING-GERM", "FS116-N1-GERM-R", "FS116-N1-GERM-S",
        "FS116-N1-TOUCH", "FS116-N1-ECHO", "FS116-N1-AXIS", "FS116-S1-KAPPA", "FS116-S1-RUNG", "FS116-N3-SEMI", "FS116-N3-PAIR", "FS116-Y3-SIX",
        "FS116-Y3-TIPS", "FS116-Y3-TIGHTLENS", "FS116-Y3-STARFORCE"}
SPECIAL = {"FS116-N3-CROSS": "held on every clause but the last (one mind and a checking reading)",
           "FS116-S1-QF": "two derivations, the second told the verdict; a blind second mind owed",
           "FS116-Y3-NBTIP": "one mind and a checking reading",
           "FS116-Y4-EMPTY": "one mind; blind second mind running (FS116-V6)"}
VAC = {"FS116-V1-FRAME", "FS116-N2-HEX6", "FS116-N2-HEX3", "FS116-Y3-SIX", "FS116-Y3-TIPS", "FS116-Y3-HUBCOL", "FS116-Y3-TIGHT", "FS116-Y3-NOQ",
       "FS116-Y3-LENS", "FS116-Y3-TIGHTLENS", "FS116-Y3-NBTIP", "FS116-Y3-STARFORCE", "FS116-V5-LENS", "FS116-Y4-SYM", "FS116-Y4-SPOKE", "FS116-Y4-Q1"}
def row(n):
    if re.match(r"FS116-(O1|V1|N1-TWIST|RING-TWIST|RING-GERM|RING-Q$|RING-Q-PRIME$|N1-QDISK)", n): return "‹R116-a›"
    if re.match(r"FS116-(N1|RING-Q-PRIME-S|V3|SAT|S1|V4|Y1|Y-SAT)", n): return "‹R116-b›"
    if re.match(r"FS116-(N2|N3|RING-TRANSFER|SEMI|V5-(QCOL|U1|OUT2|DICHO|CROSS))", n): return "‹R116-c›"
    return "‹R116-d›"
path = ROOT / "plans/FS116-derivation.md"
lines, _ = G.strip_fences(G.read(str(path)))
for b in G.blocks(lines, str(path)):
    if b["kind"] != "derivation": continue
    f, n = b["fields"], b["name"]
    st = " ".join(f.get("statement", "").split())
    one = st if len(st) <= 150 else st[:150].rsplit(" ", 1)[0] + " …"
    v = f.get("verdict", "").strip()
    if v.lower() != "derived":
        grade, kern, one = "GAP; one mind", "stub (FS-123–FS-125)", one + " — GAP"
    else:
        g = f.get("grade", "").split(":")[0].strip().replace("derived from", "derived")
        if f.get("grade", "").startswith("computed over"): g = "tools, exact"
        m = SPECIAL.get(n) or ("held, two minds (the second blind)" if n in HELD else "one mind")
        grade = f"{g}; {m}" + ("; vacuous if FS116-Y4-EMPTY is held" if n in VAC else "")
        kern = "queued (FS-113)" if f.get("handoff", "").startswith("de Bruijn") else "none"
    print(f"| {n} | {row(n)} | {one.replace('|', '/')} | {grade} | `plans/FS116-derivation.md` {n} | {kern} |")
