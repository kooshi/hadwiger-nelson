#!/usr/bin/env python3
"""FS131-IM3: split the moves' machinery out of Plane/ValidMap/Moves, verbatim, into a new module Plane/ValidMap/Surgery upstream of
Moves (inventory item 279).

    python3 tools/fs131_im_split.py --write        # generate Surgery.lean and the trimmed Moves.lean from Moves at 9ffc2aba
    python3 tools/fs131_im_split.py --check        # Surgery.lean equals the regenerated text byte for byte (the moved block is
                                                   # Moves' source lines, verbatim); Moves imports Surgery and declares none of
                                                   # the moved names again
    python3 tools/fs131_im_split.py --check-split  # --check, and Moves.lean is exactly the source minus the block plus its new
                                                   # header (true at the split commit only: the moves are proved in Moves later)

The block is every declaration of Moves at 9ffc2aba before the three `…_aux` statements: from `/-! ## The arc of a branch germ`
(l. 25) through the `end ArcMap` after `Near.exists_cut` (l. 2087). The ruling names "from `/-! ## The chart near its point`
(l. 246) through `Near.exists_cut`"; the block starts 221 lines earlier because the machinery reads IM1's l. 25–244 (`germArc`, its
carrier and non-degeneracy in `Near.germ`, `Near.newArcs_*`; `isClear_of_mem_closure` in `Near.exists_cut`), which could not stay
in Moves once Moves imports Surgery.

The source is `git show 9ffc2aba:<Moves>`, never the working copy, so a re-run cannot drift. Exit 0 only when every check passes;
every failure prints its culprit and exits 1.
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC_REV = "9ffc2aba"
MOVES = "Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean"
SURGERY = "Proofs/HadwigerNelson/Plane/ValidMap/Surgery.lean"
IMPORT_OLD = "import Proofs.HadwigerNelson.Plane.ValidMap.Cone"
IMPORT_NEW = "import Proofs.HadwigerNelson.Plane.ValidMap.Surgery"

BLOCK = (25, 2087)   # 1-based, inclusive
HEAD_END = 24        # Moves' l. 1-24: import, module doc, namespace, open, blank
EXPECT = {
    1: IMPORT_OLD,
    3: "/-!",
    19: "-/",
    21: "namespace HadwigerNelson.Plane",
    23: "open Complex Real Set Filter Topology Metric",
    24: "",
    25: "/-! ## The arc of a branch germ (the surgery's new and re-added arcs) -/",
    246: "/-! ## The chart near its point: germs apart, the closure of a sector, two colours at a point -/",
    2021: "theorem exists_cut (hF : F.Valid)",
    2085: "end Near",
    2087: "end ArcMap",
    2088: "",
    2089: "namespace ArcMap",
    2096: "theorem exists_shave_aux",
}

SURGERY_HEADER = """import Proofs.HadwigerNelson.Plane.ValidMap.Cone

/-!
# The surgery at a point: the machinery of the local moves (FS131-IM1, FS131-IM2)

The construction the three simplifying moves of `Plane/ValidMap/Moves` (SHAVE, MERGE-RAY, MERGE) share, moved verbatim from `Moves`
(inventory item 279, FS131-IM3), in order: the arc of a branch germ (`germArc`, IM1) and clearness at limits
(`ArcMap.isClear_of_mem_closure`, IM1); the chart near its point — germs apart and ordered below a radius
(`IsSectorChart.eventually_ord`), the closure of a sector, at most two colours at a point of the punctured ball
(`IsSectorChart.ncard_coloursAt_le_two`), the flank colours of the sectors beside a germ, the neighbourhood of a branch point; an arc's
pieces outside a ball (`Arc.outer`, `Arc.outer_spec`); the surgery (`ArcMap.surgery`: `F`'s arcs with `B(v, ρ)` cut out, new arcs
inside, a new colouring) with its transfer lemmas (agreement, no unit arc created, Condition 5); horns as sets (open, connected); the
counting of sectors from a partition; the near data (`ArcMap.Near`) and the generic move (`Near.move`: the kept germs' arcs, extra
arcs and the circle `∂B(v, ρ)`), with validity and the colours at `v` and on the circle; and **the cut** (`Near.exists_cut`): two
sectors of one colour beside a germ merge across it (IM2).
`tools/fs131_im_split.py --check` holds the text byte-identical to its source lines in `Moves` at `9ffc2aba`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

"""
SURGERY_FOOTER = "\nend HadwigerNelson.Plane\n"

MOVES_DOC = """/-!
# The local moves at a point: SHAVE, MERGE-RAY and MERGE (FS110-N4-SHAVE, N4-RAY, W-MERGE)

Wave 4's three simplifying moves (`plans/FS131-w4-kernel-plan.md` §§ 3.2, 13; inventory item 236), proved under `Contact`'s exact
statements as `exists_shave_aux`, `exists_rayMerge_aux`, `exists_merge_aux`, which `Contact`'s leaves cite. Each move is a local
surgery at `v`: the same domain, the arcs cut inside a small disc about `v` and new arcs added there, the colouring changed only on the
recoloured region; validity is engine 1 (`Valid.of_agreesOff`) over the move's clearness, "no unit arc created" is engine 2
(`ringArcsWithin_of_Γ_subset`), and the sector count at `v` is a partition of the new map's interior points near `v`.

The machinery — the chart near its point, an arc's pieces outside a ball, the surgery and the generic move `Near.move`, and the cut
`Near.exists_cut` — is `Plane/ValidMap/Surgery` (inventory item 279).
-/"""


def source_lines():
    out = subprocess.run(["git", "show", f"{SRC_REV}:{MOVES}"], cwd=ROOT, check=True, capture_output=True, text=True).stdout
    return out.split("\n")


def seg(lines, a, b):
    return lines[a - 1:b]


def check_source(lines):
    bad = 0
    for n, pre in EXPECT.items():
        if not lines[n - 1].startswith(pre) or (pre == "" and lines[n - 1] != ""):
            print(f"FAIL: source line {n} does not start with {pre!r}: {lines[n - 1][:80]!r}")
            bad += 1
    return bad


DECL = re.compile(r"^(?:noncomputable |protected |private )*(?:theorem|lemma|def|structure|abbrev|instance|class|inductive)\s+(\S+)")


def decl_names(lines):
    return [m.group(1) for l in lines if (m := DECL.match(l))]


def build(lines):
    block = seg(lines, *BLOCK)
    surgery = SURGERY_HEADER + "\n".join(block) + "\n" + SURGERY_FOOTER
    head = seg(lines, 1, HEAD_END)
    assert head[0] == IMPORT_OLD
    doc_start = head.index("/-!")
    doc_end = head.index("-/")
    new_head = [IMPORT_NEW] + head[1:doc_start] + MOVES_DOC.split("\n") + head[doc_end + 1:]
    rest = lines[BLOCK[1] + 1:]  # drop the block and its trailing blank line (l. 2088)
    moves = "\n".join(new_head + rest)
    return block, surgery, moves


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in ("--write", "--check", "--check-split"):
        print(__doc__)
        return 2
    lines = source_lines()
    bad = check_source(lines)
    block, surgery, moves = build(lines)
    if sys.argv[1] == "--write":
        if bad:
            print(f"FAIL: {bad} source check(s) failed; nothing written")
            return 1
        (ROOT / SURGERY).write_text(surgery)
        (ROOT / MOVES).write_text(moves)
        print(f"wrote {SURGERY} ({surgery.count(chr(10))} lines) and {MOVES} ({moves.count(chr(10))} lines)")
        return 0
    disk_surgery = (ROOT / SURGERY).read_text()
    disk_moves = (ROOT / MOVES).read_text()
    s_lines = disk_surgery.split("\n")
    found = any(s_lines[i:i + len(block)] == block for i in range(len(s_lines) - len(block) + 1))
    if found:
        print(f"ok: source lines {BLOCK[0]}-{BLOCK[1]} ({len(block)} lines) verbatim in {SURGERY}")
    else:
        print(f"FAIL: source lines {BLOCK[0]}-{BLOCK[1]} are not found verbatim in {SURGERY}")
        bad += 1
    if disk_surgery != surgery:
        print(f"FAIL: {SURGERY} differs from the text regenerated from {SRC_REV}")
        bad += 1
    else:
        print(f"ok: {SURGERY} is the fixed header, the block, and the fixed footer, byte for byte")
    m_lines = disk_moves.split("\n")
    if IMPORT_NEW not in m_lines:
        print(f"FAIL: {MOVES} does not import Surgery")
        bad += 1
    moved = set(decl_names(block))
    again = sorted(moved & set(decl_names(m_lines)))
    if again:
        print(f"FAIL: {MOVES} declares {len(again)} moved name(s) again: {again[:5]}")
        bad += 1
    else:
        print(f"ok: {MOVES} declares none of the {len(moved)} moved names")
    if sys.argv[1] == "--check-split":
        if disk_moves != moves:
            print(f"FAIL: {MOVES} differs from {SRC_REV}'s minus the block plus the new header")
            bad += 1
        else:
            print(f"ok: {MOVES} is {SRC_REV}'s minus exactly l. {BLOCK[0]}-{BLOCK[1] + 1}, with `{IMPORT_NEW}` and the new module doc")
    if bad:
        print(f"FAIL: {bad} check(s) failed")
        return 1
    print("PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
