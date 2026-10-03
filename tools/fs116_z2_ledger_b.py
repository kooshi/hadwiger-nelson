#!/usr/bin/env python3
"""FS116-Z2: draft LEDGER.md § B lines from plans/FS116-derivation.md (the gate's own parser), one per entry, each line the entry's statement
truncated at a word boundary (verbatim, never paraphrased). Copied from tools/fs116_z1_ledger_b.py (part 1's) and adapted for FS116-V6's verdict:
FS116-Y4-EMPTY held (inventory item 139), the vacuity cells definite, FS116-V6's five lemmas added; and one line for FS-114's new entry FS114-N7-HUB
(FS116-Z2's erratum), with a replacement for FS114-N7-3T's existing line.

Usage: fs116_z2_ledger_b.py > data/fs116/fs116-z2/ledger-b-draft.md         (the FS-116 lines)
       fs116_z2_ledger_b.py --fs114 > data/fs116/fs116-z2/ledger-b-fs114.md (FS114-N7-HUB's new line; FS114-N7-3T's replacement line)
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / ".claude/skills/ephodos/scripts"))
import derive_gate as G  # noqa: E402

HELD = {"FS116-O1-YESLIM", "FS116-O1-SATPIN", "FS116-RING-TWIST-C", "FS116-N1-TWIST-LIT", "FS116-RING-GERM", "FS116-N1-GERM-R", "FS116-N1-GERM-S",
        "FS116-N1-TOUCH", "FS116-N1-ECHO", "FS116-N1-AXIS", "FS116-S1-KAPPA", "FS116-S1-RUNG", "FS116-N3-SEMI", "FS116-N3-PAIR", "FS116-Y3-SIX",
        "FS116-Y3-TIPS", "FS116-Y3-TIGHTLENS", "FS116-Y3-STARFORCE", "FS116-Y4-EMPTY"}
SPECIAL = {"FS116-N3-CROSS": "held on every clause but the last (one mind and a checking reading)",
           "FS116-S1-QF": "two derivations, the second told the verdict; a blind second mind owed",
           "FS116-Y3-NBTIP": "one mind and a checking reading"}
VAC = {"FS116-V1-FRAME", "FS116-N2-HEX6", "FS116-N2-HEX3", "FS116-Y3-SIX", "FS116-Y3-TIPS", "FS116-Y3-HUBCOL", "FS116-Y3-TIGHT", "FS116-Y3-NOQ",
       "FS116-Y3-LENS", "FS116-Y3-TIGHTLENS", "FS116-Y3-NBTIP", "FS116-Y3-STARFORCE", "FS116-V5-LENS", "FS116-Y4-SYM", "FS116-Y4-SPOKE", "FS116-Y4-Q1",
       "FS116-V6-HUBS", "FS116-V6-HUG", "FS116-V6-COUNT", "FS116-V6-ANTI", "FS116-V6-ADJ"}
VAC_CELL = "true vacuously (FS116-Y4-EMPTY, held)"


def row(n: str) -> str:
    if re.match(r"FS116-(O1|V1|N1-TWIST|RING-TWIST|RING-GERM|RING-Q$|RING-Q-PRIME$|N1-QDISK)", n):
        return "‹R116-a›"
    if re.match(r"FS116-(N1|RING-Q-PRIME-S|V3|SAT|S1|V4|Y1|Y-SAT)", n):
        return "‹R116-b›"
    if re.match(r"FS116-(N2|N3|RING-TRANSFER|SEMI|V5-(QCOL|U1|OUT2|DICHO|CROSS))", n):
        return "‹R116-c›"
    return "‹R116-d›"


def one_line(st: str) -> str:
    st = " ".join(st.split())
    return st if len(st) <= 150 else st[:150].rsplit(" ", 1)[0] + " …"


def fs116() -> None:
    path = ROOT / "plans/FS116-derivation.md"
    lines, _ = G.strip_fences(G.read(str(path)))
    for b in G.blocks(lines, str(path)):
        if b["kind"] != "derivation":
            continue
        f, n = b["fields"], b["name"]
        one = one_line(f.get("statement", ""))
        v = f.get("verdict", "").strip()
        if v.lower() != "derived":
            grade, kern, one = "GAP; one mind", "stub (FS-123–FS-125)", one + " — GAP"
            if n == "FS116-C114-LOCAL-F":
                grade = "GAP; the Γ-free case held excluded (FS116-Y4-EMPTY)"
        else:
            g = f.get("grade", "").split(":")[0].strip().replace("derived from", "derived")
            if f.get("grade", "").startswith("computed over"):
                g = "tools, exact"
            m = SPECIAL.get(n) or ("held, two minds (the second blind)" if n in HELD else "one mind")
            grade = f"{g}; {m}" + (f"; {VAC_CELL}" if n in VAC else "")
            kern = "queued (FS-113)" if f.get("handoff", "").startswith("de Bruijn") else "none"
        print(f"| {n} | {row(n)} | {one.replace('|', '/')} | {grade} | `plans/FS116-derivation.md` {n} | {kern} |")


def fs114() -> None:
    path = ROOT / "plans/FS114-derivation.md"
    lines, _ = G.strip_fences(G.read(str(path)))
    blocks = {b["name"]: b for b in G.blocks(lines, str(path)) if b["kind"] == "derivation"}
    hub = blocks["FS114-N7-HUB"]["fields"]
    print("New line (after FS114-N7-QOPP's):")
    print(f"| FS114-N7-HUB | row 138 | {one_line(hub['statement']).replace('|', '/')} | hand; two minds (the second blind, FS116-V1, on rings "
          f"carrying no arc of Γ), one mind on rings with (R2) arcs; {VAC_CELL} where the ring carries no arc of Γ | `plans/FS114-derivation.md` "
          f"FS114-N7-HUB | none |")
    print("Replacement for FS114-N7-3T's line (its statement read in the record's setting, FS116-Z2's erratum):")
    # verbatim pieces of the record's own statement (plans/FS114-N7-proof.md § 2.2), elided at "…"
    print("| FS114-N7-3T | row 138 | At a degree-4 four-colour vertex of a non-Siamese valid map in the simple class whose ring is (Q)-free after the "
          "bends, three tactic edges occur only in … the **open-cap family OC**. Every other configuration "
          "with three or four tactic edges is excluded at radius `1 + ε`. | hand; one mind: N7 (the pattern kills; FS116-V1's blind check stalled at "
          "them) | `plans/FS114-derivation.md` FS114-N7-3T | declined |")


if __name__ == "__main__":
    fs114() if "--fs114" in sys.argv else fs116()
