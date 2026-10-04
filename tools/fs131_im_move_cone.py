#!/usr/bin/env python3
"""FS131-IM1, FS131-IM2: move Contact's head block, three single lemmas and the prefix that follows the head, verbatim, into
Plane/ValidMap/Cone (inventory items 253-254, the first move; item 263, the second).

    python3 tools/fs131_im_move_cone.py --write   # generate Cone.lean and the trimmed Contact.lean from Contact at d4f946ae
    python3 tools/fs131_im_move_cone.py --check   # check, byte for byte, that the moved text equals its source lines and that
                                                  # the trimmed Contact is the source minus exactly those lines plus one import

The source is `git show d4f946ae:<Contact>`, never the working copy, so a re-run cannot drift. Exit 0 only when every check passes;
every failure prints its culprit and exits 1.
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC_REV = "d4f946ae"
CONTACT = "Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean"
CONE = "Proofs/HadwigerNelson/Plane/ValidMap/Cone.lean"
IMPORT_LINE = "import Proofs.HadwigerNelson.Plane.ValidMap.Cone"

# 1-based inclusive line ranges of whole declarations (docstring through last proof line) in Contact at d4f946ae.
# The head block: l. 27-1030 of the ruling, rounded out to whole declarations (l. 26 is the docstring of `frameX_add_smul`;
# `mem_coneAt_hornSet`, begun at l. 1027, ends at l. 1056).
HEAD = (26, 1056)
TOP_LEVEL = [(1716, 1718)]              # hornSet_mono_radius (namespace HadwigerNelson.Plane)
IN_ARCMAP = [(1373, 1386), (2627, 2632)]  # not_mem_interiorPts_of_mem_closure_sector, IsSector.eq_of_mem (namespace ArcMap)
# The second move (item 263, FS131-IM2): every declaration from `e_eq_of_mem_coneAt_hornSet` (its docstring, l. 1058) through
# `IsSectorChart.index_of_isSector_hornSet` (its last line, l. 2592), with the module-doc headings and the `namespace`/`variable`
# lines between, minus the two single lemmas of the first move that lie inside it (HOLES, each with its trailing blank line,
# already in Cone). The range ends inside the `namespace ArcMap` opened at l. 2322, so Cone closes it after the range and Contact
# reopens it (REOPEN) before `woodallCone_isHorn`'s docstring, l. 2594.
RANGE2 = (1058, 2592)
HOLES = [(1373, 1386), (1716, 1718)]
REOPEN_AT = 2594
REOPEN = ["namespace ArcMap", "", "variable {k : ℕ} {F : ArcMap k}", ""]
EXPECT_FIRST = {
    26: "/-- `frameX` is real-linear along a displacement. -/",
    1716: "/-- A horn's points are at most its radius from its base point",
    1373: "/-- A point of a sector's closure inside the ball, not in the sector, is no interior point",
    2627: "/-- Two sectors sharing a point are equal. -/",
    1058: "/-- **A horn approaches its base point only along its axis**",
    2594: "/-- **Woodall's cone with fixed horns**",
    2322: "namespace ArcMap",
    2324: "variable {k : ℕ} {F : ArcMap k}",
}
EXPECT_NAMES = {
    1056: None,
    1717: "theorem hornSet_mono_radius",
    1374: "theorem not_mem_interiorPts_of_mem_closure_sector",
    2628: "theorem IsSector.eq_of_mem",
    1059: "theorem e_eq_of_mem_coneAt_hornSet",
    2549: "theorem IsSectorChart.index_of_isSector_hornSet",
    2597: "theorem woodallCone_isHorn",
}

HEADER = """import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.SVMap

/-!
# The allowed cone (FS110-N3-CONF), the horn algebra and the horn charts, upstream of `Contact` and `Moves`

Moved verbatim from `Plane/ValidMap/Contact` in two moves, so that the moves (`Plane/ValidMap/Moves`) can read them.
The first (inventory items 253–254, FS131-IM1): `Contact`'s head — FS110-N3-CONF (`contact_inType_or_outType`,
`coneAt_subset_allowedCone`, `clear_of_subset_interior_allowedCone`, `lens_dist_lt_one_of_up`, `lune_dist_le_of_up`, with the
ray-point, shadow and dot helpers they use) and the branch-point and horn algebra (`hornSet_congr` … `mem_coneAt_hornSet`) —
and three single lemmas (`hornSet_mono_radius`, `not_mem_interiorPts_of_mem_closure_sector`, `IsSector.eq_of_mem`). The second
(item 263, FS131-IM2): the prefix of `Contact` that followed, from `e_eq_of_mem_coneAt_hornSet` through
`IsSectorChart.index_of_isSector_hornSet` — FS110-N3-DEG (`woodallCone`, `woodallCone_strict`), N4-FLANK's mechanism, and a horn's
chart sector and its flanks (`IsHorn.exists_chart_index`, `IsSectorChart.exists_col`, `IsSectorChart.exists_flank_after`/`_before`,
`IsHorn.exists_flankAbove`/`_Below`).
`tools/fs131_im_move_cone.py --check` holds the text byte-identical to its source lines in `Contact` at `d4f946ae`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

"""


def source_lines():
    out = subprocess.run(["git", "show", f"{SRC_REV}:{CONTACT}"], cwd=ROOT, check=True, capture_output=True, text=True).stdout
    return out.split("\n")


def seg(lines, a, b):
    return lines[a - 1:b]


def range2_pieces(lines):
    """The second move's text as consecutive pieces of source lines, cut at the holes (each hole with its trailing blank line)."""
    pieces, a = [], RANGE2[0]
    for h0, h1 in HOLES:
        pieces.append((a, h0 - 1))
        a = h1 + 2
    pieces.append((a, RANGE2[1]))
    return pieces


def build(lines):
    head = seg(lines, *HEAD)
    top = [l for r in TOP_LEVEL for l in [""] + seg(lines, *r)]
    arc = []
    for i, r in enumerate(IN_ARCMAP):
        if i:
            arc.append("")
        arc += seg(lines, *r)
    r2 = [l for a, b in range2_pieces(lines) for l in seg(lines, a, b)]
    cone = HEADER + "\n".join(head + top + ["", "namespace ArcMap", "", "variable {k : ℕ} {F : ArcMap k}", ""] + arc +
                              ["", "end ArcMap", ""] + r2 + ["", "end ArcMap", "", "end HadwigerNelson.Plane", ""])
    # the trimmed Contact: drop each range and the blank line after it; add the import after the last import line
    drop = set()
    for a, b in [HEAD] + TOP_LEVEL + IN_ARCMAP + [RANGE2]:
        drop.update(range(a, b + 2))  # the range and its trailing blank line
    kept = []
    for i, l in enumerate(lines, start=1):
        if i == REOPEN_AT:
            kept += REOPEN
        if i not in drop:
            kept.append(l)
    last_import = max(i for i, l in enumerate(kept) if l.startswith("import "))
    kept.insert(last_import + 1, IMPORT_LINE)
    return cone, "\n".join(kept)


def check_source(lines):
    bad = 0
    for n, pre in EXPECT_FIRST.items():
        if not lines[n - 1].startswith(pre):
            print(f"FAIL: source line {n} does not start with {pre!r}: {lines[n - 1][:80]!r}")
            bad += 1
    for n, pre in EXPECT_NAMES.items():
        if pre is not None and not lines[n - 1].startswith(pre):
            print(f"FAIL: source line {n} does not start with {pre!r}")
            bad += 1
    for h0, h1 in HOLES:
        if not (RANGE2[0] <= h0 and h1 < RANGE2[1]) or (h0, h1) not in TOP_LEVEL + IN_ARCMAP:
            print(f"FAIL: hole {h0}-{h1} is not a first-move range inside the second move's range")
            bad += 1
    if REOPEN_AT != RANGE2[1] + 2:
        print(f"FAIL: the reopening point {REOPEN_AT} is not the line after the second move's trailing blank line")
        bad += 1
    for a, b in [HEAD] + TOP_LEVEL + IN_ARCMAP + [RANGE2]:
        if lines[b] != "":
            print(f"FAIL: the line after range {a}-{b} is not blank: {lines[b][:80]!r}")
            bad += 1
        if lines[b + 1].startswith(" "):
            print(f"FAIL: range {a}-{b} does not end a declaration (next non-blank line is indented)")
            bad += 1
    return bad


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in ("--write", "--check"):
        print(__doc__)
        return 2
    lines = source_lines()
    bad = check_source(lines)
    cone, contact = build(lines)
    if sys.argv[1] == "--write":
        if bad:
            print(f"FAIL: {bad} source check(s) failed; nothing written")
            return 1
        (ROOT / CONE).write_text(cone)
        (ROOT / CONTACT).write_text(contact)
        print(f"wrote {CONE} ({cone.count(chr(10))} lines) and {CONTACT}")
        return 0
    # --check: the files on disk against the regenerated text, and every moved range found verbatim, in order, in Cone
    disk_cone = (ROOT / CONE).read_text()
    disk_contact = (ROOT / CONTACT).read_text()
    cone_lines = disk_cone.split("\n")
    for a, b in [HEAD] + TOP_LEVEL + IN_ARCMAP + range2_pieces(lines):
        block = seg(lines, a, b)
        found = any(cone_lines[i:i + len(block)] == block for i in range(len(cone_lines) - len(block) + 1))
        if not found:
            print(f"FAIL: source lines {a}-{b} are not found verbatim in {CONE}")
            bad += 1
        else:
            print(f"ok: source lines {a}-{b} ({len(block)} lines) verbatim in {CONE}")
    if disk_cone != cone:
        print(f"FAIL: {CONE} differs from the text regenerated from {SRC_REV}")
        bad += 1
    if disk_contact != contact:
        print(f"FAIL: {CONTACT} differs from {SRC_REV}'s minus the moved ranges plus the import")
        bad += 1
    else:
        print(f"ok: {CONTACT} is {SRC_REV}'s minus exactly the moved ranges (and their trailing blank lines) plus `{IMPORT_LINE}`"
              f" and the reopening of `namespace ArcMap` before source line {REOPEN_AT}")
    if bad:
        print(f"FAIL: {bad} check(s) failed")
        return 1
    print("PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
