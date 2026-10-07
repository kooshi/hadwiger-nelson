#!/usr/bin/env python3
"""FS131-L8A stage 4: the docstring corrections, as exact replacements — each old text must stand exactly `n` times, or
nothing is written. Run once from the worktree root; a second run fails on the first edit (its old text is gone), which
is the check that it ran. `--list` prints every edit with its before and after and writes nothing.

LISTED: the brief's step 4. BEYOND: sentences the join itself made false or stale, which no branch could see; ruled by
the coordinator mid-job (message of 2026-10-06: "make (a), (b), (c), the `ARCHITECTURE.md` rows and the
`scripts/Axioms.lean` block comment true of the joined state — doc comments and registry prose only").
"""
import sys

D = "Proofs/HadwigerNelson/Plane/RingCalculus/"
EDITS = [
    # (file, class, what, n, old, new)
    (D + "SemiHub.lean", "LISTED 1", "fullSemiHub_star_crossed's docstring: four colours do not follow from germS_absent", 1,
     "The row's \"full semi-hub of kind O with (Q) arcs `A`, `B`\" gives these hypotheses: the arcs by\n"
     "`GermOnQWith.exists_isRingArc_ccw`, `…_cw`, four colours by `germS_absent`. Model: the strip's `P₀` (`ℓ = m = 15.52°`, edges\n"
     "at `0°, 90°, 180°, 270°`); no Lean term. -/",
     "The row's \"full semi-hub of kind O with (Q) arcs `A`, `B`\" gives the two arcs, by `GermOnQWith.exists_isRingArc_ccw`,\n"
     "`…_cw`. It does not give `h4`: at a change point `germS_absent` makes two colours absent at `p` (`ncard + 2 = k`), which is\n"
     "four colours only at `k = 6`; exactly four colours is a hypothesis of its own (inventory item 592). Model: the strip's `P₀`\n"
     "(`ℓ = m = 15.52°`, edges at `0°, 90°, 180°, 270°`); no Lean term. -/"),
    (D + "SemiHub.lean", "LISTED 3", "qcol_inner_tile's docstring: the line of prose holding the word `sorry`", 1,
     "stated there with `sorry` on a branch this one does not hold: one declaration at the join.) -/",
     "stated there as an open leaf on a branch this one does not hold: one declaration at the join.) -/"),
    (D + "SemiHub.lean", "BEYOND (a)", "module doc, the row of FS116-N3-SEMI: proved, not stated", 1,
     "| FS116-N3-SEMI | `semiHub_places` (`…/SemiHubPlaces`) | stated |",
     "| FS116-N3-SEMI | `semiHub_places` (`…/SemiHubPlaces`) | proved there (job FS131-I8D) |"),
    (D + "SemiHub.lean", "BEYOND (a)", "module doc, the row of FS116-N3-CROSS: proved, not stated", 1,
     "`crossed_semiHub` (`…/SemiHubPlaces`) | `crossed_tip_zeroAngle` proved from `crossed_no_tip`; the rest stated |",
     "`crossed_semiHub` (`…/SemiHubPlaces`) | proved there (job FS131-I8D) |"),
    (D + "SemiHubPlaces.lean", "LISTED 2", "the five ruled statements cite the ruling by its inventory number", 5,
     "**The class** (`h4`; ruled on FS131-I8D's finding): `p` carries *exactly* four colours.",
     "**The class** (`h4`; inventory item 592): `p` carries *exactly* four colours."),
    (D + "SemiHubPlaces.lean", "BEYOND (c)", "module doc: the same phrase a sixth time", 1,
     "**The class** (ruled on job FS131-I8D's finding): `semiHub_places`,",
     "**The class** (inventory item 592, on job FS131-I8D's finding): `semiHub_places`,"),
    (D + "SemiHubPlaces.lean", "BEYOND (b)", "module doc: stale since the join, and a line of prose holding the word `sorry`", 1,
     "**Proved over the statements of `Plane/RingCalculus/SemiHub`** (job FS131-I8C's leaves, in a tree of its own until the wave's\n"
     "join): no declaration of this module holds a `sorry`, and each rests on that module's leaves it cites.",
     "**Proved over the statements of `Plane/RingCalculus/SemiHub`** (job FS131-I8C's leaves, proved in a tree of its own; the two\n"
     "were joined by job FS131-L8A): every declaration of this module is a kernel theorem with no open leaf beneath it."),
    ("ARCHITECTURE.md", "LISTED 4", "the row of StarChart: two modules import it", 1,
     "Imported by no module yet: `SemiHub` and `SemiHubPlaces` take it at their implementers' first stage. No `sorry`, no axiom, no `native_decide`.",
     "Imported by `SemiHub` and `SemiHubPlaces`. No `sorry`, no axiom, no `native_decide`."),
    ("ARCHITECTURE.md", "BEYOND", "the row of SemiHubPlaces: the ruling by its inventory number", 1,
     "(`(F.coloursAt p).ncard = 4`, ruled on FS131-I8D's finding: `germS_absent` gives four colours only at `k = 6`)",
     "(`(F.coloursAt p).ncard = 4`, inventory item 592: `germS_absent` gives four colours only at `k = 6`)"),
    ("ARCHITECTURE.md", "BEYOND", "the row of SemiHubPlaces: its records rest on nothing since the join", 1,
     "No `sorry` in the module; until the wave's join its records rest on `…/SemiHub`'s open leaves. No axiom, no `native_decide`.",
     "No `sorry` in the module, and since the wave's join (job FS131-L8A) none beneath it: every record is on the standard three. No axiom, no `native_decide`."),
    ("ARCHITECTURE.md", "BEYOND", "the row of Star: no skeleton — every leaf is proved", 1,
     "| `Plane/RingCalculus/Star` | **FS-131 wave 8, skeleton** (job FS131-K8; plan Stages 2–4).",
     "| `Plane/RingCalculus/Star` | **FS-131 wave 8** (stated by job FS131-K8, plan Stages 2–4; its two leaves proved by jobs FS131-I8A and FS131-I8B)."),
    ("ARCHITECTURE.md", "BEYOND", "the row of Empty: no skeleton — every leaf is proved", 1,
     "| `Plane/RingCalculus/Empty` | **FS-131 wave 8, skeleton** (job FS131-K8; plan Stages 2 and 4).",
     "| `Plane/RingCalculus/Empty` | **FS-131 wave 8** (stated by job FS131-K8, plan Stages 2 and 4; its leaves proved by jobs FS131-I8A and FS131-I8D)."),
    ("ARCHITECTURE.md", "BEYOND", "the row of SemiHub: no skeleton", 1,
     "| `Plane/RingCalculus/SemiHub` | **FS-131 wave 8, skeleton: the semi-hub rows** (job FS131-K8b; `plans/FS131-w8-kernel-plan.md` Stages 6–10).",
     "| `Plane/RingCalculus/SemiHub` | **FS-131 wave 8: the semi-hub rows** (stated by job FS131-K8b, `plans/FS131-w8-kernel-plan.md` Stages 6–10; its seventeen leaves proved by job FS131-I8C, `plans/FS131-I8C-implementation.md`)."),
    ("ARCHITECTURE.md", "BEYOND", "the row of SemiHub: the skeleton's word '(stated)', five times", 1,
     "`qcol_inner_tile`, `qcol_not_one_arc`, `GermOnQWith.exists_isRingArc_ccw`, `…_cw` (stated). FS116-N3-PAIR: `germPair_inner_ne` (stated), `germPair_swap`; FS116-V5-DICHO: `germPair_dicho` (stated). FS116-N3-CONE: `ringTile_uMinus`, `…_vMinus`, `…_vPlus`, `…_uPlus` (stated),",
     "`qcol_inner_tile`, `qcol_not_one_arc`, `GermOnQWith.exists_isRingArc_ccw`, `…_cw`. FS116-N3-PAIR: `germPair_inner_ne`, `germPair_swap`; FS116-V5-DICHO: `germPair_dicho`. FS116-N3-CONE: `ringTile_uMinus`, `…_vMinus`, `…_vPlus`, `…_uPlus`,"),
    ("ARCHITECTURE.md", "BEYOND", "the row of SemiHub: '(stated)', continued", 1,
     "`closure_inter_subset_sphere` (proved), `isRingArc_of_edge`, `four_le_of_bothKind` (stated).",
     "`closure_inter_subset_sphere`, `isRingArc_of_edge`, `four_le_of_bothKind`."),
    ("ARCHITECTURE.md", "BEYOND", "the row of SemiHub: '(stated)' and the sentence that apologized for it", 1,
     "`fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`, `fullSemiHub_star_parallel_T` (stated). **Job FS131-I8C** (`plans/FS131-I8C-implementation.md`) proved the seventeen leaves; the words \"(stated)\" above are the skeleton's and no longer describe the module. Its helpers:",
     "`fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`, `fullSemiHub_star_parallel_T`. Job FS131-I8C's helpers:"),
    ("scripts/Axioms.lean", "BEYOND", "the block comment of FS131-I8D: no record rests on an open leaf since the join", 1,
     "Until the wave's join each record here that cites a statement of\n"
     "`Plane/RingCalculus/SemiHub` rests on that module's open leaves (`tools/fs131_i8d_axioms.py` names them per record). -/",
     "Until the wave's join each record here that cites a statement of\n"
     "`Plane/RingCalculus/SemiHub` rested on that module's open leaves; since the join (job FS131-L8A) none does\n"
     "(`tools/fs131_i8d_axioms.py`: 29 on the standard three, none resting). -/"),
]


def main():
    listing = "--list" in sys.argv[1:]
    texts = {}
    for path, cls, what, n, old, new in EDITS:
        s = texts.setdefault(path, open(path, encoding="utf-8").read())
        c = s.count(old)
        if listing:
            print(f"## [{cls}] {path} — {what} (×{n})\n--- before\n{old}\n+++ after\n{new}\n")
            continue
        if c != n:
            sys.stderr.write(f"REFUSED: [{cls}] {path}: the old text stands {c} time(s), expected {n} — nothing written\n{old}\n")
            return 1
        texts[path] = s.replace(old, new)
    if listing:
        print(f"{len(EDITS)} edits in {len(texts)} files")
        return 0
    for path, s in texts.items():
        open(path, "w", encoding="utf-8").write(s)
    print(f"applied {len(EDITS)} edits ({sum(e[3] for e in EDITS)} replacements) in {len(texts)} files: " + ", ".join(sorted(texts)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
