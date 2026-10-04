# FS131-IW — Woodall's chain in the kernel: the implementer's record

*Brief `data/fs131/briefs/FS131-IW-woodall.md`; branch `fs131-ww` (worktree `.claude/worktrees/fs131-ww`), on `058c65f8`. Implementer: de Bruijn on Sonnet 5.5.*

## Theorems this phase proved

Axioms below are from `#print axioms` on **iteration oleans** (`data/fs131/iw/iter.sh`, `lake env lean` with the lakefile's options against scratch
oleans), the whole print in `data/fs131/iw/axioms-iteration.txt` and its split in `data/fs131/iw/axioms-iteration-summary.txt`. The gate has not run
(waves 3–4 and FS131-LEB have not landed): this is **not gate evidence**. A `sorryAx` below is never this job's: it comes through a cited, unlanded
statement (`lemmaL`; `ArcMap.dense_interiorPts`; `ArcMap.Valid.unitPairsNull_region`) or through one of the five leaves left (stage 2).

| declaration | read against | axioms |
|---|---|---|
| `Collar`'s foundation: `isOpen_annSector`, `isPreconnected_annSector`, `isOpen_collar`, `collar_subset_collar`, `exists_collar_of_collarAt`, `exists_unit_pair_collar`, `exists_changePt`, `sphere_meets_of_collarAt` | the skeleton's docstrings (`[Woodall1973]` p. 198, "unit arc of positive thickness") | standard three (the landing and the change point need none of the cited statements) |
| `collarAt_shadow_outer`, `collarAt_shadow_inner`, `ArcMap.col_not_mem_of_mem_shadow` | "the cone of a connected piece decides on which side of `ω(u)` the unit circles meet it" | standard three |
| `ArcMap.subset_closure_of_subset_shadow` | FS106-WO's excluded set | `sorryAx` through `ArcMap.dense_interiorPts` (wave 3) |
| `not_woodall_step4_two_thirds` | FS106-WO clause 2 (the adversary: Townsend's counterexample at `2π/3`) | standard three |
| `woodall_step4` (FS106-WO, clause 2), `townsend_lemma` (FS106-TW) | `[Woodall1973]` p. 198 as repaired; `[Townsend1979ms]` Thm 1 | `sorryAx` through `lemmaL` (wave 3/4, FS106-L) only; engines A–D proved: `false_of_changePt_landing`, `exists_changePt_band`, `false_of_collars_closed`, `finite_bad_radii` |
| E1-SEE `not_mem_coloursAt_of_dist_eq_one`; robust `not_mem_coloursAt_of_collarAt`; E1-RAY `SectorsAt.collarAt_shadow_inner_of_mem`, `_outer_of_mem`; E1-CROSS `SectorsAt.not_mem_range_of_crossesAt` | `plans/FS131-W-kernel-plan.md` § 8.5 rows | `not_mem_coloursAt_of_collarAt`, E1-RAY, E1-CROSS: standard three; E1-SEE: `sorryAx` through `ArcMap.Valid.unitPairsNull_region` (wave 3) |
| `exists_side_colours_of_not_crossesAt`, `exists_closure_colour_of_arc`, E1-COVER `SectorsAt.false_of_ncard_le_two_on_arc` | § 8.5 (E1-COVER; E1-GEN6's form) | `sorryAx` through `ArcMap.dense_interiorPts` and `unitPairsNull_region` (cited) |
| `dist_le_one_of_subset_closure`, `exists_mem_collar_of_dist_lt`, `exists_Ioo_avoiding`, `mem_coneAt_annSector`, `collarAt_shadow_of_parabola` | § 9.3 region-only tools | standard three |
| E1-BAD `SectorsAt.exists_two_absent` (with `exists_mem_Ico`, `not_mem_coloursAt_of_mem_Ioo`, `exists_parabola_region`, `exists_normal_collarAt`, `absent_at_normal`, `eq_of_edge_mem_angleIcc`, `Arc.finite_inter_parabola`, `width_eq_pi_unique`) | § 8.5 (corrected count, robust form) | `exists_two_absent` and `not_mem_coloursAt_of_mem_Ioo`: `sorryAx` through E1-SEE, i.e. `ArcMap.Valid.unitPairsNull_region` (cited); `exists_mem_Ico`, `exists_parabola_region`, `exists_normal_collarAt`, `absent_at_normal`, `eq_of_edge_mem_angleIcc`, `Arc.finite_inter_parabola`, `width_eq_pi_unique`: standard three |
| `SectorsAt.coloursAt_eq` | § 4.5 (`j ∈ coloursAt v ⟺ j ∈ range c`) | standard three |
| **E1-NO45** `ArcMap.false_of_four_le_sectors` | `plans/FS131-E1-derivation.md` § 3.6 ("no point lies on the boundary of exactly four or exactly five sectors"), read as `4 ≤ n`, `k ≤ 5`, `WoodallNormal` | `sorryAx` through its citations: `exists_sectorsAt`, `step6` (open leaves) and the cited statements; the argument itself is proved: the angle bound `≤ π`, `habs`, the avoiding arc, the three-colour point, its picture |
| `ArcMap.exists_three_le_sectors`, `ArcMap.aeMap6_normal`, `ArcMap.aeMap6`, `ArcMap.aeMap6_of_condition5`, `woodall_thm6` | compositions, § 9.3 | proved from their citations; `sorryAx` through `exists_sectorsAt`, `ts_t`, `step6`, `step5_lt`, `exists_woodallMerged` (open or cited) |

**E1-NO45 holds in the kernel as a proof from its citations**: the proof of `false_of_four_le_sectors` is complete, and the check on E1's argument it was
asked to be (inventory item 111) found no gap: E1-BAD's count (`K.card ≤ n`), E1-COVER's colour-class form and the refined second-order lemma all closed
as § 8–9 stated them, with no statement changed. What it still cites: `step6` (leaf), `exists_sectorsAt` (leaf).

## Stage 1 — SAVED: the readback

**The brief's two quotations** (`.../FS131-W-kernel-plan.md` § 9.5) match their source verbatim, both paragraphs read whole. **What I may change**: children
anywhere; supporting lemmas in the foundation modules; imports (with `ARCHITECTURE.md`, `scripts/Axioms.lean`, `tools/fs131_w2_decls.py --check`); the
private "merged ⇒ normal" with `VACUITY DECLARED`. **What I may not**: any statement of § 3.1's table kept by § 8.4, any statement of §§ 8.4–8.5, any
definition of `Plane/Woodall/Basic` or `Plane/Woodall/NoFourFive`, any new `axiom`, any `native_decide`.

**Slip, logged**: the brief asks for the build "once, exactly as given, before editing anything". I started it and edited `Collar.lean` before it reached that
module, so the first build (`data/fs131/iw-build0.log`, OK, 444 of 444, 5 modules rebuilt) is of the tree with my first Collar leaves, not of `058c65f8`. The
skeleton had been built green at `058c65f8` by FS131-W2 (`plans/FS131-W-kernel-plan.md` § 8.6) with the same worktree; I had no failure to attribute.

## Stage 2 — SAVED: the leaves, in § 9.5's order

**Proved (modules sorry-free): `Plane/Woodall/Collar` (0 `sorry`), `Plane/Woodall/NoFourFive` (0 `sorry`).** `Plane/Woodall/Steps` has **5** left, each
named: `exists_sectorsAt` (H), `exists_woodallMerged` (H+), `step5_lt` (M), `aeMap6_merged` (M), `step6` (H−). `lebesgue_covering_square` is FS131-LEB's.

**Re-pricing (from the first two hard leaves).** The plan's table priced `Collar`'s foundation at M/E and the module at about two implementer sessions; the
first two leaves (`isOpen_annSector`, `isPreconnected_annSector`) closed in one pass each, on one polar-coordinate lemma (`eq_add_norm_mul_e`, `eventually_abs_arg_lt`)
that every later leaf reused. All of `Collar` and `NoFourFive` (about 55 declarations, 1,300 lines) took about 380k tokens. Open leaves, by what each needs:
* `step5_lt` (M): `woodall_step4` on the inner arc opposite the narrow sector, `collarAt_shadow_inner` for the three colours' tiles, `neighbour_dirs` through the
  `Fin` wrap (`prev_succ`, `d_prev_succ`, `exists_prev_dir` are in `NoFourFive` and serve it). Not started.
* `aeMap6_merged` (M): the cyclic step "a zero-width sector whose next has positive width exists if any zero-width sector exists" is the one new piece
  (orbit of `finRotate` is the whole circle, or an extremal choice on `d`); then `step5_lt` and `aeMap6_normal` (proved) finish. Not started.
* `step6` (H−): `townsend_lemma` with `K` the at most three uncertified normals (`exists_normal_collarAt`, in place), seeds from `collarAt_shadow_inner`/`outer_of_mem`
  and `exists_cur_dir`/`exists_prev_dir`. Not started.
* `exists_sectorsAt` (H) and `exists_woodallMerged` (H+): not started; the second is a separate job at this rate.

**Findings.** No statement defect: no leaf proved so far disagreed with its statement. E1-NO45's chain is formalizable as written (see above). Two
notes for the planner: (i) `exists_parabola_region` and `absent_at_normal` carry `hn : 2 ≤ n` unused (it follows from the others); kept, discharged by `have _ := hn`.
(ii) every theorem here that cites `lemmaL`, `dense_interiorPts` or `Valid.unitPairsNull_region` shows `sorryAx` until waves 3–4 land; the parabola lemmas, `exists_normal_collarAt`, `absent_at_normal` and `exists_mem_Ico` are free of it (`exists_two_absent` is not: it cites E1-SEE).

## Drafts for the front page

Not drafted: the gate has not run, no milestone state moved. Slot, when the gate runs: `CLAUDE.md` § The gate gets the counts; the ledger rows FS106-WO,
FS106-TW, FS106-AE-MAP6 and the E1-NO45 row stay [hand] until `Steps` is sorry-free and waves 3–4 and FS131-LEB land.

## Tools and working files

`data/fs131/iw/iter.sh` (iteration elaboration, never evidence), `data/fs131/iw/scratch/run.sh` and the scratch files `t*.lean` (the leaves as first developed),
`data/fs131/iw/axioms-iteration*.txt`. `tools/fs131_w2_decls.py --check`: 114 theorems, 114 records, 0 missing, 0 stale; `--plant` fires both ways.
`tools/check_architecture.py`: PASS (the `Plane/Chord` import of `Collar` added to its row).
