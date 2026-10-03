#!/usr/bin/env python3
"""FS121-Z1: draft LEDGER.md § B lines from plans/FS121-derivation.md (the gate's own parser), one per entry, each theorem's line the
entry's statement truncated at a word boundary (verbatim, never paraphrased). Usage: fs121_z1_ledger_b.py > data/fs121/fs121-z1/ledger-b-draft.md"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / ".claude/skills/ephodos/scripts"))
import derive_gate as G
HELD = {"FS121-O1-ENDS", "FS121-O1-OUT", "FS121-O1-PER", "FS121-O1-LRA-LINE", "FS121-DB1-L3", "FS121-D1-VT", "FS121-D1-EROSION",
        "FS121-V2-SECTOR", "FS121-D3-GRUNDY", "FS121-D3-FALLSAT", "FS121-D2-SYM", "FS121-C1-BOUND", "FS121-C1-GMAP", "FS121-C1-SAT",
        "FS121-C1-COVMAP", "FS121-C1-FLAT", "FS121-D4-FACE", "FS121-D4-GRID"}
def row(name):
    if re.match(r"FS121-(O1|DB1|D1|V2-VT|V2-EROSION|R2-FOUR|CURVED|V2-SECTOR|V3)", name): return "‹R121-a›"
    if re.match(r"FS121-(D3|SAT6|C1|NOPAR|V4)", name): return "‹R121-b›"
    return "‹R121-c›"
STUB = {"FS121-R2-FOUR": "FS-126", "FS121-CURVED": "FS-126", "FS121-NOLRA": "FS-126", "FS121-O1-CARD": "FS-126", "FS121-REGJ": "FS-127",
        "FS121-SAT6": "FS-128", "FS121-NOPAR": "FS-128", "FS121-NOPAR-C5": "FS-128"}
path = ROOT / "plans/FS121-derivation.md"
lines, _ = G.strip_fences(G.read(str(path)))
for b in G.blocks(lines, str(path)):
    if b["kind"] != "derivation": continue
    f, n = b["fields"], b["name"]
    st = " ".join(f.get("statement", "").split())
    one = st if len(st) <= 150 else st[:150].rsplit(" ", 1)[0] + " …"
    v = f.get("verdict", "").strip()
    if v.lower() != "derived":
        grade, kern = "GAP; one mind", f"stub ({STUB.get(n, 'FS-126')})"
        one = one + " — GAP"
    else:
        g = f.get("grade", "").split(":")[0].strip()
        m = f.get("minds", "").split()[0]
        grade = f"{g}; " + ("held, two minds (the second blind)" if n in HELD else ("two minds, not frozen" if m == "2" else "one mind"))
        kern = "queued (FS-113)" if f.get("handoff", "").startswith("de Bruijn") else "none"
    print(f"| {n} | {row(n)} | {one.replace('|', '/')} | {grade} | `plans/FS121-derivation.md` {n} | {kern} |")
