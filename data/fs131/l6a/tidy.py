#!/usr/bin/env python3
"""FS131-L6A: the ruled tidies of the brief's item 3, as exact text replacements.

Every edit is (file, old, new): `old` must occur exactly once in the file, or nothing is written and the script
exits 1 naming the edit. Run from the worktree root:

    python3 data/fs131/l6a/tidy.py --check     # every edit applies exactly once; nothing written
    python3 data/fs131/l6a/tidy.py             # write

(i)   `polarRegion_isOpen`, `polarRegion_isPreconnected` (FS131-I6E, `FanBridge`) deleted in favour of FS131-I6D's
      `isOpen_polarRegion`, `isPreconnected_polarRegion` (`FanBuild`); three uses repointed; their two audit records go.
(ii)  the audit records the reports leave for the join: FS131-I6C's six, FS131-I6E's fourteen; three block headings.
(iii) docstring sentences the join makes false; `ARCHITECTURE.md`'s rows that say "skeleton" or "leaves".
"""
import sys

D = "Proofs/HadwigerNelson/Plane/Saturated/"
P = "HadwigerNelson.Plane."

# the two duplicates: from the first one's docstring to the docstring of the declaration after the second
DUP_START = "/-- **A polar region between two continuous graphs is open.** -/\ntheorem polarRegion_isOpen "
DUP_END = "/-- A polar point a full turn on is the same point. -/\ntheorem polarPt_add_two_pi "

I6C_WIRED = ["HasTwoDiscsAt.one_le_norm_sub", "HasTwoDiscsAt.norm_sub_le", "HasTwoDiscsAt.normal_unique", "local_graph",
             "AeColouring.local_graph", "sq9_exists_isInterfaceChart"]
I6E_WIRED = ["exists_unitCurve_branch", "exists_twoColourNhd_branch", "dist_eq_one_of_common_contact", "contacts_of_no_common",
             "branch_outside_discs", "branch_contacts", "exists_contact_nextDir", "exists_contact_dir", "sector_constraints",
             "horn_false", "false_of_horn_next", "false_of_horn_dir", "sector_alone", "sector_unique"]

I6C_HEAD = ("/-! ## FS131-I6C — wave 6's bridge, line C: the leaves of `Plane/Saturated/Curve` (unit-speed curves with 1-Lipschitz "
            "tangent angle), then of `Plane/Saturated/LocalGraph`, with the implementer's children -/")
I6E_HEAD_OLD = ("; the records wired over `gamma`, `IsUnitCurve.exists_polarGraph` and `Pinch` are listed in "
                "`plans/FS131-I6E-implementation.md` and enter here at the join -/")
I6E_HEAD_NEW = ("; the fourteen records proved over `gamma`, `IsUnitCurve.exists_polarGraph` and `Pinch`'s leaves are the block's "
                "last section, entered at the join (FS131-L6A) -/")
I6D_HEAD_OLD = (" (until `fs131-w6c` joins, the records that read `Curve`'s or `LocalGraph`'s leaves print `sorryAx` on this "
                "branch) -/")
I6D_HEAD_NEW = (" (re-read at the join, FS131-L6A: nothing beneath them is open) -/")

EDITS = [
    # ---- (i) the three uses
    (D + "FanBridge.lean", "  polarRegion_isOpen z (F.cont i) (F.continuousOn_cyclicNext i)",
     "  isOpen_polarRegion z (F.cont i) (F.continuousOn_cyclicNext i)"),
    (D + "FanBridge.lean", "  polarRegion_isPreconnected z ((F.cont i).mono (Ioo_subset_Ioo_right hρ))",
     "  isPreconnected_polarRegion z ((F.cont i).mono (Ioo_subset_Ioo_right hρ))"),
    (D + "FanBridge.lean", "polarRegion_isOpen z hlo (F.continuousOn_cyclicNext i),",
     "isOpen_polarRegion z hlo (F.continuousOn_cyclicNext i),"),
    # ---- (i) their two records
    ("scripts/Axioms.lean", f"#print axioms {P}polarRegion_isOpen\n#print axioms {P}polarRegion_isPreconnected\n", ""),
    # ---- (ii) the block headings
    ("scripts/Axioms.lean", I6E_HEAD_OLD, I6E_HEAD_NEW),
    ("scripts/Axioms.lean", I6D_HEAD_OLD, I6D_HEAD_NEW),
    # ---- (iii) docstrings
    (D + "FanBridge.lean",
     "`plans/FS131-E8-derivation.md` §§ 3.2–3.7, each entry **[hand], one mind, kernel pending** until this module lands\n",
     "`plans/FS131-E8-derivation.md` §§ 3.2–3.7, each entry kernel-checked in this module (no `sorry`)\n"),
    (D + "FanBridge.lean",
     "locally finite near `z`, by FS131-E8-BRIDGE ([hand], one mind, until `fan_of_isolated` is proved). Inhabitant:",
     "locally finite near `z`, by FS131-E8-BRIDGE (kernel-checked: `fan_of_isolated`). Inhabitant:"),
    (D + "Fan.lean",
     "by FS131-E8-BRIDGE ([hand], one mind, until\n`Plane/Saturated/FanBridge` lands): `regJFan_of_saturated`.",
     "by FS131-E8-BRIDGE (kernel-checked in\n`Plane/Saturated/FanBridge`): `regJFan_of_saturated`."),
    (D + "LocalGraph.lean",
     "`plans/FS131-E8-derivation.md` §§ 3.1, 3.5 ([hand], one mind, until this module lands), at the class each argument",
     "`plans/FS131-E8-derivation.md` §§ 3.1, 3.5 (kernel-checked in this module), at the class each argument"),
    (D + "LocalGraph.lean",
     "no `sorry` in this module; `local_graph` rests on two leaves of `Plane/Saturated/Pinch`",
     "no `sorry` in this module; `local_graph` rests on two theorems of `Plane/Saturated/Pinch`"),
    (D + "Pinch.lean",
     "  preconnected unit-distance-free set. No sector and no colouring is read. **Proved.**\n\n**Inhabitants.**",
     "  preconnected unit-distance-free set. No sector and no colouring is read. **Proved.**\n\n"
     "**Every row above is proved; the module holds no `sorry`**: the rows marked so by the planner, and `pinch`,\n"
     "`pinch_not_in_in`, `c11_discs`, `c11_split`, `half_upperDensity`, `TwoColourOn.essBoundary_inter_eq`, `sq9_isTangentAt`\n"
     "by FS131-I6A (`plans/FS131-I6A-implementation.md`), with `pinch_interface` and `c11_discs_interface` over them.\n\n"
     "**Inhabitants.**"),
    (D + "MapEdge.lean",
     "(names of this module's own: a second line\nmay hold the same facts under other names until the wave's join).",
     "(names of this module's own: giving each\none home with the same facts of other modules is a tidy after wave 6's first landing)."),
    # ---- (iii) ARCHITECTURE.md
    ("ARCHITECTURE.md",
     "| `Plane/Saturated/Pinch` | **FS-131 wave 6, skeleton** (job FS131-K6). ",
     "| `Plane/Saturated/Pinch` | **FS-131 wave 6** (jobs FS131-K6, FS131-K6b; every leaf proved by FS131-I6A, "
     "`plans/FS131-I6A-implementation.md`; no `sorry`). "),
    ("ARCHITECTURE.md",
     "FS121-V2-EROSION-DIAM (`dist_le_one_of_mem_closure`, `erosion_diam`, `erosion_diam_cot`; proved). | `Plane/Saturated/Basic`",
     "FS121-V2-EROSION-DIAM (`dist_le_one_of_mem_closure`, `erosion_diam`, `erosion_diam_cot`; proved). FS131-I6A's children: the "
     "two cells of the pinch's table (`isSplitAt_of_in_out`, `hasTwoDiscsAt_of_out_out`), `IsSplitAt.hasTwoDiscsAt`, "
     "`essBoundary_inter_congr`, `volume_halfPlane_inter_closedBall_le`; six examples on `sq9` at `sqEdgePt`. | `Plane/Saturated/Basic`"),
    ("ARCHITECTURE.md",
     "| `Plane/Saturated/Curve` | **FS-131 wave 6, skeleton** (job FS131-K6b; ",
     "| `Plane/Saturated/Curve` | **FS-131 wave 6** (jobs FS131-K6b, FS131-I6C: every leaf proved, no `sorry`; "),
    ("ARCHITECTURE.md",
     "inhabitant `isUnitCurve_segment`; the leaves `IsUnitCurve.chord`,",
     "inhabitant `isUnitCurve_segment`; proved by FS131-I6C: `IsUnitCurve.chord`,"),
    ("ARCHITECTURE.md",
     "is 1-Lipschitz, by the parallelogram law). No measure, no colouring. | `Plane/Chord`",
     "is 1-Lipschitz, by the parallelogram law); `IsUnitCurve.sin_add_sin_le` (C1 and C2 as one inequality, at length `π`), "
     "`exists_lens_point`, `isUnitCurve_circle`. No measure, no colouring. | `Plane/Chord`"),
    ("ARCHITECTURE.md",
     "| `Plane/Saturated/LocalGraph` | **FS-131 wave 6, skeleton** (job FS131-K6b). ",
     "| `Plane/Saturated/LocalGraph` | **FS-131 wave 6** (jobs FS131-K6b, FS131-I6C: every leaf proved, no `sorry`; "
     "`local_graph` over `Pinch`'s `c11_discs` and `TwoColourOn.essBoundary_inter_eq`). "),
    ("ARCHITECTURE.md",
     "`AeColouring.local_graph` (FS121-V5-LOC (ii)). | `Plane/Saturated/Pinch`",
     "`AeColouring.local_graph` (FS121-V5-LOC (ii)). Children: `HasTwoDiscsAt.norm_sub_le`, `exists_arclength_inverse`, "
     "`exists_unit_curve_of_two_discs`, `isConnected_graph_side`; inhabitant `sq9_exists_isInterfaceChart`. | `Plane/Saturated/Pinch`"),
    ("ARCHITECTURE.md",
     "| `Plane/Saturated/FanBridge` | **FS-131 wave 6, skeleton** (job FS131-K6b). ",
     "| `Plane/Saturated/FanBridge` | **FS-131 wave 6** (jobs FS131-K6b, FS131-I6D, FS131-I6E: every leaf proved, no `sorry`). "),
    ("ARCHITECTURE.md",
     "FS121-V2-SECTOR (`Fan.sector_alone`) and FS121-DB1-L3 with FS111-W-NOREP (`Fan.sector_unique`, its case). | `Plane/Saturated/LocalGraph`",
     "FS121-V2-SECTOR (`Fan.sector_alone`) and FS121-DB1-L3 with FS111-W-NOREP (`Fan.sector_unique`, its case). The existence "
     "half (FS131-I6D) is proved through `Plane/Saturated/FanArcs` and `FanBuild`; model `sq9_regJFan`. The five `Fan` lemmas "
     "(FS131-I6E): `Fan.two_le_n`, `Fan.col_ne` with no saturation, over `volume_essBoundary` (the essential boundary of a "
     "measurable set is null) and the cells of a fan (`Fan.isPreconnected_cell`, `Fan.cell_subset_densitySet`, "
     "`Fan.exists_ray_subset_cell`; `image_polarPt_mem_nhds`, `fanAngle`); `Fan.branch_outside_discs` and `Fan.branch_contacts` "
     "over `Fan.exists_unitCurve_branch` (the branch as a unit-speed curve from `z`), `Fan.dist_eq_one_of_common_contact`, "
     "`Fan.contacts_of_no_common`; `Fan.sector_alone` over `in_in_or_out_out` (FS121-V2's Lemma H), `Fan.sector_side`, "
     "`horn_of_sin_constraints`, `Fan.horn_false`. Inhabitant: five examples on `sq9Fan`. | `Plane/Saturated/LocalGraph`"),
    ("ARCHITECTURE.md",
     "Rests on `Curve`'s and `LocalGraph`'s leaves. |",
     "Rests on `Curve`'s and `LocalGraph`'s theorems. |"),
]


def main(argv):
    check_only = "--check" in argv
    texts, bad = {}, 0

    def load(f):
        if f not in texts:
            texts[f] = open(f, encoding="utf-8").read()
        return texts[f]

    # (i) the deletion
    f = D + "FanBridge.lean"
    t = load(f)
    if t.count(DUP_START) != 1 or t.count(DUP_END) != 1 or t.index(DUP_START) > t.index(DUP_END):
        print(f"FAIL the duplicates' block: start {t.count(DUP_START)}, end {t.count(DUP_END)}")
        bad += 1
    else:
        a, b = t.index(DUP_START), t.index(DUP_END)
        gone = t[a:b]
        heads = [l.split()[1] for l in gone.split("\n") if l.startswith("theorem ")]
        if heads != ["polarRegion_isOpen", "polarRegion_isPreconnected"]:
            print(f"FAIL the duplicates' block holds {heads}")
            bad += 1
        else:
            texts[f] = t[:a] + t[b:]
            print(f"ok   {f}: deleted {heads} ({gone.count(chr(10))} lines)")
    for f, old, new in EDITS:
        t = load(f)
        n = t.count(old)
        if n != 1:
            print(f"FAIL {f}: {n} occurrence(s) of {old[:70]!r}")
            bad += 1
            continue
        texts[f] = t.replace(old, new, 1)
        print(f"ok   {f}: {old[:60]!r}")
    # (ii) the records, appended at the end of their blocks (before the blank line above the next block's heading)
    f = "scripts/Axioms.lean"
    t = load(f)
    for job, nxt, names, why in (
            ("FS131-I6C", "/-! ## FS131-I6E ", [P + n for n in I6C_WIRED],
             "-- entered at the join (FS131-L6A): proved over `Pinch`'s `c11_discs` and `TwoColourOn.essBoundary_inter_eq`"),
            ("FS131-I6E", "/-! ## FS131-I6D ", [P + "AeColouring.Fan." + n for n in I6E_WIRED],
             "-- entered at the join (FS131-L6A): proved over `gamma`, `IsUnitCurve.exists_polarGraph` and `Pinch`'s leaves")):
        if t.count(nxt) != 1 or t.count(f"/-! ## {job} ") != 1:
            print(f"FAIL {f}: block {job} or the heading after it is not unique")
            bad += 1
            continue
        dup = [n for n in names if f"#print axioms {n}\n" in t]
        if dup:
            print(f"FAIL {f}: already recorded: {dup}")
            bad += 1
            continue
        i = t.index(nxt)
        block = why + "\n" + "".join(f"#print axioms {n}\n" for n in names) + "\n"
        t = t[:i] + block + t[i:]
        print(f"ok   {f}: {len(names)} records appended to block {job}")
    texts[f] = t
    if bad:
        print(f"tidy: FAIL ({bad} edit(s) do not apply); nothing written")
        return 1
    if check_only:
        print("tidy --check: every edit applies exactly once; nothing written")
        return 0
    for f, t in texts.items():
        open(f, "w", encoding="utf-8").write(t)
    print(f"tidy: wrote {len(texts)} file(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
