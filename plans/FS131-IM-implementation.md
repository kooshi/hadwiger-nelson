# FS131-IM — wave 4's three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) in `Plane/ValidMap/Moves`

*The record of FS131-IM1 (de Bruijn, the implementer, on Opus), branch `fs131-w4m` from `fs131-w4c` at `d4f946ae`, in the worktree
`.claude/worktrees/fs131-w4m`. Brief: `data/fs131/briefs/FS131-IM1-moves.md` (on `main`). Report: `data/fs131/reports/FS131-IM1.md`.*

## Theorems this phase proved

Kernel-checked in this job's build (`build/gate/build/20261004T220917Z-2800792.log`), axioms printed against that build's oleans
(`data/fs131/im/axioms-stage3.txt`), all in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`:

- `HadwigerNelson.Plane.e_sub_e_two_mul` — [kernel], `[propext, Classical.choice, Quot.sound]`
- `HadwigerNelson.Plane.branchPt_eq_circle` — [kernel], the standard three
- `HadwigerNelson.Plane.abs_half_le_one` — [kernel], the standard three
- `HadwigerNelson.Plane.carrier_germArc` — [kernel], the standard three
- `HadwigerNelson.Plane.germArc_nondegenerate` — [kernel], the standard three
- `HadwigerNelson.Plane.germArc_isUnitArc_iff` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.isClear_of_mem_closure` — [kernel], the standard three

FS131-IM2's, kernel-checked in its stage-6 build (`build/gate/build/20261004T231602Z-3342967.log`), axioms printed against that build's oleans
(`data/fs131/im/axioms-stage6.txt`), all in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` — the moves' machinery and the cut (§ 6.2), each
reading `[propext, Classical.choice, Quot.sound]` (`HadwigerNelson.Plane.BranchGerms.next_injective`: `[propext, Quot.sound]`):

- `HadwigerNelson.Plane.BranchGerms.Sorted.κ_ne` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.exists_germDir_ne_of_ne` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.eventually_ord` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.BranchGerms.mem_closure_sector` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.BranchGerms.next_injective` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.coloursAt_subset_of_mem_interiorPts` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_mem_Γ` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_branchPt_eq` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.eq_of_branchPt_eq` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.BranchGerms.closure_sector_cases` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.eq_or_next_eq_of_mem_closure` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.eq_of_mem_closure_of_mem` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.coloursAt_subset_image` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.ncard_coloursAt_le_two` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.Arc.continuous_pt` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.Arc.carrier_eq_image` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.Arc.carrier_sub` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.Arc.nondegenerate_sub` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.Arc.param_spec` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.Arc.finite_outer` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.norm_e_sub_e_eq` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.le_abs_sin_iff` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.abs_sin_le_of` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.Arc.outer_spec` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.finite_arcs_through` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.trimArcs_spec` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.trimArcs_disjoint_ball` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.surgery_mem_arcs_iff_of_not_mem` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.surgery_mem_arcs_iff_of_mem` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.surgery_agreesOff` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.surgery_ringArcsWithin` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.surgery_condition5` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.surgery_hlc_of` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.isOpen_hornSet` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.isPreconnected_hornSet` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.hornSet_eq_empty` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.eq_branchPt_of_tanHeight_eq_zero` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.isClear_col` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.encard_sectorsOf_of_partition` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.encard_sectorsOf` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.finite_inter_sphere_of_subset_Γ` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.carrier_circ_full'` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.BranchGerms.e_nextβ` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_branchPt_mem_sector_after` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_branchPt_mem_sector_before` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.col_eq_of_flankAbove` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.col_eq_of_flankBelow` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_mem_closure_sector_after` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_mem_closure_sector_before` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_ball_subset_of_branchPt` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.exists_near` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.eventually_small` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_dom` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.Small.lt_r₀` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.Small.mem_Ioc` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.Small.curv` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.hcol₀` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.carrier_germ` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_carrier_germ_iff` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_interiorPts_iff` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_Γ` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.circ_nondegenerate` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.newArcs_nondegenerate` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.newArcs_finite` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.newArcs_subset_closedBall` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.sphere_subset_newArcs` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.germ_subset_Γ` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.newArcs_unit` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.newArcs_condition5` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_newArcs_iff` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_dom` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_col` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_move_interiorPts_iff` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_move_interiorPts_iff_of_not_mem` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.not_mem_move_interiorPts_of_sphere` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_agreesOff` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_ringArcsWithin` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_condition5` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_valid` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_coloursAt_self` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.move_coloursAt_sphere` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.cutCol_of_mem` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.cutCol_of_not_mem` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.norm_of_mem_cutSet` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.cutSet_subset_ball` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.ne_of_mem_cutSet` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.not_mem_interiorPts_of_mem_cutSet` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.cutSet_subset_closure` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.closure_cutSet_subset` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.mem_interiorPts_or_cutSet` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.cut_hlc` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.cut_hasSectors` — [kernel], the standard three or fewer
- `HadwigerNelson.Plane.ArcMap.Near.exists_cut` — [kernel], the standard three or fewer

FS131-IM3's, kernel-checked in its stage-9 build (`build/gate/build/20261004T235251Z-3627279.log`), axioms printed against that build's oleans
(`data/fs131/im/axioms-stage9.txt`), all in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`, each reading exactly `[propext, Classical.choice, Quot.sound]`:

- `HadwigerNelson.Plane.ArcMap.exists_shave_aux` — [kernel], the standard three — **FS110-N4-SHAVE, the move, under `Contact`'s statement**
- `HadwigerNelson.Plane.BranchGerms.ne_next_of_nextβ_eq` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.horn_index` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.encard_col_eq` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.exists_shave_of_flankAbove` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.exists_shave_of_flankBelow` — [kernel], the standard three
- `HadwigerNelson.Plane.Arc.finite_inter_sphere_of_not_isUnitArc` — [kernel], the standard three
- `HadwigerNelson.Plane.mem_germArc_iff_of_mem_hornSet` — [kernel], the standard three
- `HadwigerNelson.Plane.mem_shaveArcs_carrier` — [kernel], the standard three
- `HadwigerNelson.Plane.shaveArcs_finite` — [kernel], the standard three
- `HadwigerNelson.Plane.shaveArcs_nondegenerate` — [kernel], the standard three
- `HadwigerNelson.Plane.shaveArcs_not_isUnitArc` — [kernel], the standard three
- `HadwigerNelson.Plane.shaveArcs_subset_closedBall` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.shaveCol_of_not_mem` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.shaveCol_of_above` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.shaveCol_of_not_above` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.shaveCol_mem` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.not_mem_interiorPts_self` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.shave_mem_interiorPts_iff` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.coloursAt_subset_of_mem_closure_sector` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.shave_hasSectors` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.shave_hlc` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.exists_shave_recolour` — [kernel], the standard three

FS131-IM3's, kernel-checked in its stage-10 build (`build/gate/build/20261005T001350Z-3780541.log`), axioms printed against that build's oleans
(`data/fs131/im/axioms-stage10.txt`), all in `Moves`, each reading exactly `[propext, Classical.choice, Quot.sound]`:

- `HadwigerNelson.Plane.ArcMap.exists_rayMerge_aux` — [kernel], the standard three — **N4-RAY, the clearness and the merge, under `Contact`'s statement**
- `HadwigerNelson.Plane.RayGap.frameX_framePt` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.frameY_framePt` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.sq_dist_framePt` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.tanHeight_parab` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.exists_parab_mem_hornSet` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.exists_same_side` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.sq_lt_one` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.one_lt_sq` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.lt_of_sq_add_sq_lt` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.sq_lt_of_sq_add_sq_lt` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.abs_le_sq_of_gap` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.sq_le_pow_four_of_abs_le` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.parab_below` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.parab_above` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.vertical_identity` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.not_both_inside` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.trapped_of_both_outside` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.abs_half_mul_sq_le` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.abeam_inside` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.abs_abeam_height` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.abeam_identity` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.abeam_contra` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.side_of_preconnected` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.hornSet_subset_region` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.ray_clear` — [kernel], the standard three
- `HadwigerNelson.Plane.branchPt_congr_dir` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.eq_of_mem_closure_hornSet` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.curv_le_of_hornSet_subset` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.sector_subset_hornSet_of_meets` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.horn_of_sector_subset_hornSet` — [kernel], the standard three
- `HadwigerNelson.Plane.RayGap.mem_hornSet_cases` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.rayCol_of_mem` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.rayCol_of_not_mem` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.abs_curv_le` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.curv_lt` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.gap_sector` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.branchPt_not_mem` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.off_keep_iff` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.mem_keep₀` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.mem_keep₄` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.sector_disjoint` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.ne` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.hasSectors` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.hlc` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.Near.RayConfig.exists_merge` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.exists_rayMerge_of_clear` — [kernel], the standard three

Still open: `exists_merge_aux` (reads `sorryAx` besides the standard three), now FS131-IMM1's (item 285).

## Stage 1 — SAVED: the readback, the as-given build, what I may and may not change

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation checked against its source by reading the source at the address given (the quotations are prefixes of the source text, cut
with `…`):

| quotation | source | result |
|---|---|---|
| "236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (…) to a parallel implementer in a" | `plans/FS131-close-inventory.md` l. 1692 (on `main`) | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | **verbatim** |
| "3. **`exists_shave`** (H, about a session). `F′ = F` plus two arcs — the branch of curvature `σ` from `v` to radius `ρ` (`Arc.circ` with explicit" | `.claude/worktrees/fs131-w4c/plans/FS131-IC-implementation.md` § Stage 2, item 3 | **verbatim** |
| "4. **`exists_rayMerge`, `exists_merge`** (H each, a session each). **The plan's claim (§ 13.1 engine 3: "the moves of Contact add arcs and recolour; they" | the same, item 4 | **verbatim** |
| "- **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc" | `fs131-w4`'s kernel plan § 14.5 | **verbatim** |
| "223. **Engine 2 written once** (item 218 (g)): FS131-I4i wrote `ringArcsWithin_of_Γ_subset` in `Plane/ValidMap/Basic` on `fs131-w4` (`3f7ea033`, Basic.lean only," | `plans/FS131-close-inventory.md` l. 1596 | **verbatim** |

The paraphrase after the IC quotations ("SHAVE adds two arcs from `v`; the merges each need **a cut at `v`** …; `exists_shave` keeps its statement though it
does not assume `g ≠ c` or `h ≠ c`, so the case `g = c`, `σ < κ₂` needs the same cut") matches IC's items 3–4 in substance.

**One small difference, not a defect:** ruling 236 says `Moves` imports "`Basic`, `Sectors`, `SVMap`"; the brief says "what `Contact` imports — `Plane/ValidMap/Basic`,
`Plane/Tiles`, `Plane/SVMap`". `SVMap` imports `Sectors`, so importing `Contact`'s three satisfies both; I follow the brief.

The three statements are at `Contact.lean` l. 4019 (`exists_shave`), 4033 (`exists_rayMerge`), 4049 (`exists_merge`) at `d4f946ae` — checked.

### 1.2 What I may and may not change

**May** (brief § What is yours to decide; kernel plan § 14.2): add children in the new module `Plane/ValidMap/Moves` or, statements unchanged, in
`Plane/ValidMap/Basic`; bring engine 2's exact hunk (`3f7ea033`) into `Basic`; edit `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (my own block,
headed "FS131-IM1"), this record, `tools/fs131_im_*.py`, `data/fs131/im/`, `data/fs131/reports/FS131-IM1.md`.

**May not**: change any statement of the three moves (they are copied by script, hypotheses, binders and conclusion verbatim, as `…_aux`); change any
definition of `Plane/ValidMap/Basic`; edit `Contact.lean` (FS131-IC4's) or wave 4's other modules (`BaseSteps`, `UnitArc`, `Sectors`, `SVMap`, `StuckChain`);
add an `axiom` or use `native_decide`; merge into `fs131-w4c` or `fs131-w4`; run wave 4's gate; push to `main`; start agents. A move that cannot be proved as
written is a message to Keryx with the declaration, the reason and the smallest counterexample or missing hypothesis; a `Contact` lemma a move needs is a
message too (that lemma then moves to `Moves`, by Keryx), never a copy.

### 1.3 The branch builds as given

`d4f946ae`, built under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 444 of 444 batches, 4 modules
rebuilt (the worktree's `.lake/build` is a copy from `fs131-w5b`), warnings only `declaration uses 'sorry'`, in `BaseSteps`, `UnitArc` and `Contact` (its four
leaves: the three moves and `stuck_structure`). Log `build/gate/build/20261004T214859Z-2681059.log`; the run's terminal output `data/fs131/im/build-asgiven.log`.

## Stage 2 — SAVED: engine 2, the block moved to `Cone`, `Moves` created with the three statements

### 2.1 Engine 2

`git diff 3f7ea033~1 3f7ea033 -- Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean | git apply` applied cleanly (112 lines: `mem_closure_ringArc_diff_finite`,
`ringArc_subset_Γ_of_finite`, `ringArcsWithin_of_Γ_subset`, `segPlane` and its spec example). Checked: `git diff 3f7ea033 -- Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean`
is empty, so `Basic` on this branch is byte-identical to `Basic` at `3f7ea033` and the copies meet without conflict at the merge. (The hunk has no
`condition5_of_ringArcsWithin`; the moves' Condition-5 clause will be proved per move, from the cut arcs lying in old carriers and the new arcs not being unit
arcs, `Arc.finite_inter_sphere_or_eq_circ`.)

### 2.2 The block moved to `Plane/ValidMap/Cone` (inventory items 253–254, the amendment of the brief)

`tools/fs131_im_move_cone.py --write` generated `Cone.lean` and the trimmed `Contact.lean` from `git show d4f946ae:…/Contact.lean`; `--check` passes:

- the head block, ruled as "l. 27–1030", is **l. 26–1056** at `d4f946ae`: l. 27 is `frameX_add_smul`'s first line and its docstring is l. 26; l. 1030 falls
  inside `mem_coneAt_hornSet` (l. 1026–1056), so the range is rounded out to whole declarations — 1031 lines, from `frameX_add_smul` to `mem_coneAt_hornSet`,
  including the N3-CONF section's `namespace ArcMap … end ArcMap` (l. 425–680);
- `hornSet_mono_radius` (l. 1716–1718, top level), `not_mem_interiorPts_of_mem_closure_sector` (l. 1373–1386) and `IsSector.eq_of_mem` (l. 2627–2632), the
  latter two placed in `namespace ArcMap` with `Contact`'s `variable {k : ℕ} {F : ArcMap k}`;
- each range found verbatim, in order, in `Cone.lean`; `Contact.lean` equals `d4f946ae`'s minus exactly those ranges (each with its trailing blank line)
  plus the one line `import Proofs.HadwigerNelson.Plane.ValidMap.Cone`.

**Negative control, watched**: changing `(h : κ ≤ κ')` to `(h : κ < κ')` in `Cone.lean`'s `tanHeight_anti` made `--check` exit 1 naming the head block and
the regenerated text (`data/fs131/im/move-control.txt`); `--write` restored it and `--check` passed again.

`Cone` imports `Contact`'s three (`Plane/ValidMap/Basic`, `Plane/Tiles`, `Plane/SVMap`); `Contact` and `Moves` import `Cone`. `Proofs.lean` gains `Cone` and
`Moves`; `ARCHITECTURE.md` gains their rows and `Cone` in `Contact`'s Imports cell; `tools/check_architecture.py`: PASS (209 rows, 0 import mismatches).
`tools/fs131_k4_decls.py --check`: exit 0 (its two "missing" names are the `_root_`-prefixed `BranchGerms.frameY_lt_of_mem`/`lt_frameY_of_mem` of `Contact`,
a parse of the tool's that predates this job, not a moved declaration).

### 2.3 `Moves` and the three statements

`tools/fs131_im_statements.py --print` extracted each statement from `Contact` at `d4f946ae` (from `theorem <name>` to the `:= by` ending its last line) and
renamed it `…_aux`; `Moves.lean` holds the three with `sorry`. `--check` compares each `…_aux` statement with `Contact`'s, after the name: **the diff is
empty for all three** (8, 7 and 6 lines). **Negative control, watched**: planting `(h2 : κ₂ < 1)` for `(h2 : κ₂ ≤ 1)` in `exists_shave_aux` made `--check`
exit 1 with the one-line diff (`data/fs131/im/statements-control.txt`); restored, it passes. `scripts/Axioms.lean` gains the block "FS-131 wave 4, `Moves`
(job FS131-IM1)" with the three `…_aux` records.

### 2.4 The build of stages 2–3

Under the slot, as in § 1.3: **OK**, 445 of 445 batches, 10 modules rebuilt (`Basic`, `StuckChain`, `Sectors`, `SVMap`, `Cone`, `Moves`, `UnitArc`, `Contact`,
`BaseSteps`, `Proofs`); `Cone` with no warning; `Moves` with exactly three, `declaration uses 'sorry'` at the three `…_aux`; `Contact` with its same four
leaves (`exists_shave`, `exists_rayMerge`, `exists_merge`, `stuck_structure`); no other warning. Log `build/gate/build/20261004T220917Z-2800792.log`; terminal
output `data/fs131/im/build-stage2.log`.

## Stage 3 — SAVED: the germ arc and clearness at limits proved; the plan for the three moves (my reading, for whoever proves them; no statement changes)

**Proved here** (in `Moves`, sorry-free, the standard three axioms): `germArc v β κ ρ`, the arc whose carrier is the branch `branchPt v β κ '' [0, ρ]`
(`carrier_germArc`; via `branchPt_eq_circle`, a branch point as a point of its circle, and `e_sub_e_two_mul`), non-degenerate for `ρ > 0`
(`germArc_nondegenerate`), a unit arc iff `|κ| = 1` (`germArc_isUnitArc_iff`), with a spec example (the curvature-`1` germ is a unit arc and holds its branch
point, the straight one is not); and `isClear_of_mem_closure` (a limit of points clear for `c` is clear for `c`). Both are children every move needs: the
σ-arc and the cut's re-added branches are germ arcs, and a cut branch is clear because the recoloured region beside it is. **Re-pricing from them**: the germ
arc took about 15k tokens of work (one elaboration round of fixes); the surgery as a whole is larger than IC1's "about a session each" — see § 3.5.

### 3.1 One surgery, three instances

Every move builds `F'` with `F'.dom = F.dom`, `F'.col = F.col` off the recoloured region `R ⊆ B(v, ρ)`, and
`F'.arcs = {a ∈ F.arcs | a.carrier ∩ B̄(v, ρ) = ∅} ∪ ⋃_{a meets B̄(v,ρ)} outer(a) ∪ {germArc v (β i) (κ i) ρ | i kept} ∪ A_new`:

- **`germArc v β κ ρ`** (proved in `Moves` at this stage) is the arc whose
  carrier is exactly the branch `branchPt v β κ '' [0, ρ]` (`carrier_germArc`, `|κ| ρ ≤ 2`): a segment for `κ = 0`, an arc of the circle of radius `1/|κ|`
  about `v + n/κ` otherwise; non-degenerate for `ρ > 0`; a unit arc iff `|κ| = 1` (`germArc_isUnitArc_iff`). It serves twice: the new σ-arc of SHAVE is
  `germArc v α σ ρ`, and **the cut re-adds the kept chart branches as germ arcs** instead of matching each old arc to the germs it carries (an old arc may carry
  zero, one or two branches at `v`, and several arcs may carry one branch; the chart's `branches` field, `(F.Γ ∩ B(v, r₀)) ∖ {v} = ⋃ᵢ branchᵢ`, describes the
  union, which is all the sector count reads).
- **`outer(a)`**, for an old arc through `v` (all arcs meeting `B̄(v, ρ)` pass through `v` below a `GoodAt` radius), is `a.carrier ∖ B(v, ρ)` as at most four
  arcs: split `a` at `v`'s parameter into its two sides; on a side `[θ_v, θ₁]` of a circle of radius `R > ρ/2` the outer part is `[θ_v + δ, min(θ₁, θ_v + 2π − δ)]`,
  `δ = 2 arcsin(ρ/2R)` (because `‖e θ − e θ_v‖ = 2 sin((θ − θ_v)/2)` on `[0, 2π]`), and the mirror on `[θ₀, θ_v]`; on a segment side `[v, w]`, `[v + ρ(w − v)/|w − v|, w]`.
  No far-end or full-circle case analysis is needed for the carrier identity; non-degeneracy needs only that no end of a nearby arc lies on `∂B(v, ρ)` —
  finitely many ends, so true for all but finitely many `ρ` (choose `ρ` by `Filter.Eventually`).
- **Engines**: validity by engine 1 (`Valid.of_agreesOff`) — `R`'s clearness, plus "no unit pair of one colour inside `R`" (`R ⊆ B(v, ρ)`, `ρ < 1/2`);
  `RingArcsWithin` by engine 2 with `A' = A_new` (the cut arcs' carriers lie in old carriers, so in `F.Γ`); Condition 5 per arc (cut arcs: subsets of old
  carriers; new arcs: radius `ρ < 1` or `1/|σ|` with `|σ| < 1`, so `Arc.finite_inter_sphere_or_eq_circ`).
- **The sector count** by `isSector_iff_of_partition` (`Sectors`) at every `r < ρ`, `r ≤ r₀`: `F'.interiorPts ∩ B(v, r)` is the untouched chart sectors plus the
  new pieces; count the `c`-coloured ones (each chart sector has one colour, `IsSectorChart.exists_col`).
- **Rim colours** (`∀ x ∈ ∂B(v, ρ), (F'.coloursAt x).ncard ≤ 3`): put the whole circle `circ v ρ 0 2π` in `A_new` for SHAVE and RAY (not a unit arc; it
  changes no sector at radius `r < ρ`); then `F'.coloursAt x ⊆ F.coloursAt x ∪ {colours of R near x}`, and a point of the punctured chart ball carries at most
  two colours of `F` (a child to prove from the chart's polar description: near a point at distance `ρ` and direction `dirᵢ(ρ)` only sectors `i − 1` and `i`
  meet, the germ directions at distance `ρ` being strictly increasing). For MERGE the full circle is **wrong** — a rim point with one colour on both sides
  would carry a repeated colour, against its `¬ HasRepeatedColour` clause — so MERGE's rim arcs lie exactly where the colour changes.

### 3.2 SHAVE (`exists_shave_aux`): the cases the statement leaves open

The statement assumes neither `g ≠ c` nor `h ≠ c` (IC1's finding). Recolour the tip `H_ρ = hornSet v α κ₁ κ₂ ρ` by `col'(z) = g` above `σ`, `h` otherwise,
in every case; then:

| case | new arcs | cut | the new pieces at radius `r` | `c`-count |
|---|---|---|---|---|
| `g ≠ c`, `h ≠ c` | σ-arc iff `κ₁ < σ < κ₂` and `g ≠ h`; rim circle | none | `U_r` (colour `g`), `L_r` (colour `h`), the empty one dropped; one piece `H_r` if `g = h` | `n + 1 − 1` |
| `g = c` (any `h`) | σ-arc iff `κ₁ < σ < κ₂` and `h ≠ c`; rim circle | the `κ₂`-branch | `S_g ∪ branch ∪ U_r` (colour `c`), `L_r` (colour `h`) — or `S_g ∪ branch ∪ H_r` when `h = c` or `σ = κ₁` | `n + 1 − 2 + 1` |
| `g ≠ c`, `h = c` | σ-arc iff `κ₁ < σ < κ₂`; rim circle | the `κ₁`-branch | `U_r` (colour `g`), `L_r ∪ branch ∪ S_h` (colour `c`) | `n + 1 − 2 + 1` |

(`S_g`, `S_h`: the chart sectors holding the flank bands `hornSet v α κ₂ κ' r ⊆ F.region g`, `hornSet v α κ'' κ₁ r ⊆ F.region h`; `S_g ≠ H` since the band lies
above `κ₂`.) With `g = h = c` the σ-arc must **not** be added (it would leave `L_r` a separate `c`-sector). Openness of the merged piece at the cut branch is
explicit, without the chart: near a point of the `κ₂`-branch every point lies in `H`, on the `κ₂`-circle, or in the flank band. Clearness of the cut branch's
points for `c` follows from `R`'s clearness by openness of `F.region c` (a unit circle through a branch point meets a ball in `F.region c`; nearby horn points
then see it too). The chart facts SHAVE reads — the horn's chart index with both germs (`IsHorn.exists_chart_index`, `IsSectorChart.index_of_isSector_hornSet`),
a sector's single colour (`IsSectorChart.exists_col`), a flank's chart sector (`IsSectorChart.exists_flank_after`/`_before`) — are in `Contact` (l. 2252–2633 at
`d4f946ae`), **not** in the moved block: a second, smaller move upstream is needed before SHAVE's sector count can cite them (their Contact-local dependencies
should be computed by a parse of the proofs, not of the docstrings; my token scan over-approximated through docstring mentions).

### 3.3 RAY (`exists_rayMerge_aux`)

**Clearness** (the first conjunct), by an exact argument that replaces N4-RAY's "follow the circle until it exits": for `t` between the horns and `y ∈ F.region c`
with `dist t y = 1`, each horn, being a preconnected subset of `F.region c` in a valid map, lies wholly inside `B(y, 1)` or wholly outside `B̄(y, 1)`.
*Both inside*: on the vertical line through `t` (frame `x = x_t`) `u ↦ |z(u) − y|² − 1` is a convex quadratic, negative at points of both horns below and above
`t`, so negative at `t`: contradiction. *One inside, one outside*: `v` is in both closures, so `|v − y| = 1`; for horn points `|z − y|² − 1 = −2x·y_x + O(x²)`,
so `y_x = 0`, `y ∈ {N, S′}`, and both horns lie outside `B(N, 1)` (curvatures `≤ 1`) and outside `B(S′, 1)` (curvatures `≥ −1`): contradiction. *Both outside*:
the disc `B̄(y, 1) ∋ t` contains the lens `{t + w : |w|² ≤ 2 w·u}`, `u = y − t`; if `|u_y| ≥ 1/2` it holds a vertical segment of length `≥ 1` from `t`, reaching the
horn above or below; if `|u_x| ≥ √3/2` it holds vertical segments of half-length `≍ s` at `x = x_t ± s`, wider than the stack (`≍ x²`) once `x_t` is small:
contradiction. All three are exact frame algebra (`tanHeight`, `sq_dist_frame`).
**The merge**: recolouring the whole gap merges `H₁`, `H₂` *and every `c`-sector between them*, so the count is `n − m` with `m` such sectors; the right
construction merges `H₁` with the **nearest** `c`-horn above it (between `κ₂` and `κ₃`, or `H₂`), cutting every chart branch of direction `α` with curvature
in `[κ₂, κ_a]` and recolouring `hornSet v α κ₂ κ_a ρ` with `c` (clear by the first conjunct, a subset).

### 3.4 MERGE (`exists_merge_aux`)

Choose two `c`-sectors consecutive along `D_c(v)`'s arc of directions with the gap between them inside `D_c(v)` (the `c`-sectors' cones lie in `D_c(v)`,
`coneAt_subset_allowedCone`); cut every chart branch strictly inside the gap and the two bounding branches; recolour the gap's sectors in `B(v, ρ)` with `c`;
rim arcs only across the recoloured sectors. Clearness: N3-CLEAR (`clear_of_subset_interior_allowedCone`) at the gap's directions interior to `D_c(v)`, N3-UP
(`lens_dist_lt_one_of_up`, `lune_dist_le_of_up`) at a cusp end on `∂D_c(v)` — all now in `Cone`. The clauses MERGE adds over SHAVE (no point off the rim gains a
colour; the rim's new points carry at most three colours and none repeated; `D_c(v′)` unchanged off `B̄(v, ρ)`) each need their own child; the last is FS110's
"`cl R ∩ ω(v′) ⊆ {v}`" argument.

### 3.5 The handover: what is proved, what is left, the price

**Proved**: the seven children listed under "Theorems this phase proved"; engine 2 brought over byte-identical; the `Cone` block moved and checked; the three
statements in `Moves`, checked identical to `Contact`'s. **Left**: all three moves — `exists_shave_aux`, `exists_rayMerge_aux`, `exists_merge_aux` each still
`sorry`; nothing in `Contact` changed beyond the ruled deletion and the import line.

**What SHAVE needs next, in order** (each a stated child; § 3.1–3.2 give the routes): (1) `outer(a)` — an old arc through `v` minus the open ball, as at most
four non-degenerate arcs in its carrier; (2) the surgery map and its `AgreesOff`, local finiteness and local constancy, over a `GoodAt` radius with no arc end
on the rim; (3) "a point of the punctured chart ball carries at most two colours"; (4) the second move upstream of `Contact`'s chart lemmas (§ 3.2's list), or
their re-derivation in `Moves` if Keryx so rules; (5) SHAVE's three cases over (1)–(4). RAY adds its clearness (§ 3.3, exact frame algebra, three cases) and
the multi-branch cut; MERGE adds the gap's choice and the rim and `D_c(v′)` clauses.

**Re-pricing** (standing order, from the first leaves): the germ arc, one of about a dozen children of comparable size SHAVE needs, took about 15k tokens of
work; with (1)–(5) SHAVE is about three of my sessions, RAY two more over SHAVE's machinery, MERGE two to three — against IC1's "about a session each". The
surgery engine ((1), (2), the counting partition) is shared and is most of SHAVE's cost; RAY and MERGE are cheaper once it stands.

## Stage 4 — SAVED: FS131-IM2's readback, the as-given build

*FS131-IM2 (de Bruijn, the implementer, on Opus) resumes this record at Stage 4 (standing rule 2): the last SAVED stage is 3, committed in
`8d075e9c` and reported in `dbedaf97` (`git log -- plans/FS131-IM-implementation.md`). Brief: `data/fs131/briefs/FS131-IM2-moves.md` (on `main`).
Report: `data/fs131/reports/FS131-IM2.md`.*

### 4.1 The brief's quotations against their sources (standing rule 3)

| quotation (a prefix, cut with `…`) | source | result |
|---|---|---|
| "236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (…) to a parallel implementer in a" | `plans/FS131-close-inventory.md` l. 1692 (on `main`) | **verbatim** |
| "262. **Corrections, slips and a tool defect from IM1's report.** (a) **Correction owed — N4-RAY's route**: recolouring the whole gap merges every `c`-sector" | the same, l. 1884 | **verbatim** |
| "263. **Ruling: the second move is a prefix move, into `Cone`, by IM1's successor on `fs131-w4m`.** Choice: FS131-IM2 moves **every declaration of `Contact` from" | the same, l. 1893 | **verbatim** |
| "Every move builds `F'` with `F'.dom = F.dom`, `F'.col = F.col` off the recoloured region `R ⊆ B(v, ρ)`, and" | this record § 3.1 | **verbatim** |
| "**Proved**: the seven children listed under "Theorems this phase proved"; engine 2 brought over byte-identical; the `Cone` block moved and checked; the three" | this record § 3.5 | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | **verbatim** |
| "- **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc" | the same, § 14.5 | **verbatim** |

**One wording difference, not a defect**: ruling 263 says "the single lemma already moved stays moved"; **two** of IM1's three single lemmas lie inside
d4f946ae's l. 1057–2593 — `not_mem_interiorPts_of_mem_closure_sector` (l. 1373–1386) and `hornSet_mono_radius` (l. 1716–1718); the third,
`IsSector.eq_of_mem` (l. 2627–2632), lies below the range. Both stay where IM1 put them in `Cone`; the second move is the range minus those two holes.

The brief's state is as stated: branch head `dbedaf97`, tree clean, Lean sources at `8d075e9c`'s state.

### 4.2 The branch builds as given

`dbedaf97`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, all 1746 modules already up to date,
nothing built; warnings only `declaration uses 'sorry'` — `BaseSteps` 7, `UnitArc` 17, `Contact` 4 (the three moves and `stuck_structure`), `Moves` 3 (the three
`…_aux`). Log `build/gate/build/20261004T222624Z-2921733.log`; terminal output `data/fs131/im/build-im2-asgiven.log`.

## Stage 5 — SAVED: the second move (item 263), into `Cone`

**The range, by declarations** (inventory item 262 (c)'s lesson): from `e_eq_of_mem_coneAt_hornSet` (its docstring, d4f946ae's l. 1058) through
`IsSectorChart.index_of_isSector_hornSet` (its last line, l. 2592) — the ruling's "l. 1057–2593" with the blank line on each side. It holds the
module-doc headings and the `namespace ArcMap`/`variable` lines between (N3-DEG l. 1139–1635, N4-FLANK's mechanism l. 1637–2247, a horn's chart sector
and its flanks from l. 2249), minus the two single lemmas of the first move that lie inside it (`not_mem_interiorPts_of_mem_closure_sector`, l. 1373–1386;
`hornSet_mono_radius`, l. 1716–1718; each with its trailing blank line), which stay where IM1 put them. The range ends inside the `namespace ArcMap`
opened at l. 2322, so `Cone` closes it after the range, and `Contact` reopens `namespace ArcMap` and `variable {k : ℕ} {F : ArcMap k}` before
`woodallCone_isHorn`'s docstring (l. 2594).

**The tool**: `tools/fs131_im_move_cone.py` extended (`RANGE2`, `HOLES`, `REOPEN`); `--write` generated `Cone.lean` (2607 lines; its module doc now
names both moves) and the trimmed `Contact.lean` (1644 lines) from `git show d4f946ae:…/Contact.lean`; `--check` passes: every first-move range and the
second move's three pieces (l. 1058–1372, 1388–1715, 1720–2592) found verbatim, in order, in `Cone`; `Cone` equal to the regenerated text; `Contact` equal
to d4f946ae's minus exactly the moved ranges (with their trailing blank lines), plus the import line and the reopening. The tool also checks that each
hole is a first-move range inside the second move's range and that the reopening point is the line after the range's trailing blank line.

**Negative controls, watched** (`data/fs131/im/move-control-im2.txt`): (1) renaming `woodallCone_strict` in `Cone` (inside the second move) made
`--check` exit 1 naming source l. 1388–1715 and the regenerated text; (2) deleting the reopened `namespace ArcMap` from `Contact` made it exit 1 naming
`Contact`; (3) a copy of the tool with a hole off its first-move range (`(1716, 1717)`) exits 1 naming the hole. Each restored by `--write`, `--check`
passing again.

**Other checks**: `tools/fs131_im_statements.py --check` PASS (the three `…_aux` statements equal `Contact`'s, diffs empty); `tools/fs131_k4_decls.py --check`
exit 0 with its two pre-existing `_root_` parse misses (item 262 (d)); `tools/check_architecture.py`: 209 rows, 0 import mismatches; it exits 1 on
"purchase ledgers disagree" (its check [5]), which it does identically on the tree before this stage (checked by stashing the stage's edits) — not this
job's. `ARCHITECTURE.md`'s `Cone` row names the second move. No `private` declaration in the range (item 263); the `scripts/Axioms.lean` records are by
name and unchanged.

**The build** (under the slot, as in § 4.2): **OK**, 445 of 445 batches, 4 modules rebuilt (`Cone` 22 s, `Moves`, `Contact`, `Proofs`); warnings only
`declaration uses 'sorry'` — `Contact` 4 (the three moves and `stuck_structure`), `Moves` 3, `BaseSteps` 7, `UnitArc` 17 (unchanged); none in `Cone`.
Log `build/gate/build/20261004T222948Z-2949144.log`; terminal output `data/fs131/im/build-stage5.log`.

## Stage 6 — SAVED: item 269 applied; SHAVE's machinery and the cut proved; the three moves still open

### 6.1 Item 269 (`exists_merge`'s colour clause), applied before MERGE

Both copies — `Contact`'s `exists_merge` and `Moves`' `exists_merge_aux` — now carry `F'.coloursAt v ⊆ F.coloursAt v` in place of
`(∀ x ∉ sphere v ρ, F'.coloursAt x ⊆ F.coloursAt x)`, and `exists_merge`'s docstring says "`v` gains no colour" (commit `de8842c6`). The change
is a ruled amendment table, `tools/fs131_im_amend.py` (each old text must occur exactly once), applied by both IM tools on top of d4f946ae:
`tools/fs131_im_move_cone.py --check` holds `Contact` to d4f946ae minus the moved ranges plus the import, the reopening and the amendments;
`tools/fs131_im_statements.py --check` holds both `Moves`' `…_aux` and the working `Contact`'s three statements to d4f946ae's plus the amendments
(PASS, diffs empty). **Controls watched** (`data/fs131/im/amend-control.txt`): `Contact`'s new clause changed to `⊂` made both tools exit 1
naming `exists_merge`/`Contact`; an amendment whose old text is absent raises. Build of that commit: **OK**, 3 modules rebuilt (`Moves`,
`Contact`, `Proofs`), warnings only `sorry` (log `build/gate/build/20261004T225708Z-3205523.log`, terminal `data/fs131/im/build-item269.log`).
I agree with item 268's finding: inside the recoloured gap points change colour by design.

### 6.2 What is proved (all in `Moves`, before the three `…_aux`; 93 theorems, listed under "Theorems this phase proved")

One surgery serves the three moves, and the cut is its first instance:

- **The chart near its point.** `BranchGerms.Sorted.κ_ne` (distinct indices of a sorted chart are distinct germs), `exists_germDir_ne_of_ne`
  (different germs never meet at one small distance; LocalStructure's `exists_germDir_ne` without normalisation),
  `IsSectorChart.eventually_ord` (**below some `s₀ ≤ r₀` the germs are apart and ordered** — the chart structure records neither);
  `BranchGerms.mem_closure_sector` (a sector's closure in polar form, by compactness) and `closure_sector_cases`;
  `IsSectorChart.ncard_coloursAt_le_two` (**at most two colours at a point of the punctured ball** below `s₀`; IM1's child (3)), with
  `coloursAt_subset_image`, `eq_or_next_eq_of_mem_closure`, `eq_of_mem_closure_of_mem`, `exists_branchPt_eq`, `branchPt_mem_Γ`,
  `coloursAt_subset_of_mem_interiorPts`; `col_eq_of_flankAbove`/`_flankBelow` (**the flank colour is the adjacent sector's colour**) via
  `exists_branchPt_mem_sector_after`/`_before`; `branchPt_mem_closure_sector_after`/`_before`; `exists_ball_subset_of_branchPt` (**near a
  branch point only the two sectors beside its germ and the branch itself**).
- **The outer pieces** (IM1's child (1)): `Arc.pt`, `Arc.params`, `Arc.sub`, `Arc.param`, `Arc.outerIv`, `Arc.outer`, and `Arc.outer_spec`: for an
  arc through `v`, at most two non-degenerate sub-arcs outside `B(v, ρ)` covering the arc off `B̄(v, ρ)` (segments by the affine parameter;
  circles by the chord `‖e θ − e θ'‖ = 2|sin((θ − θ')/2)|`, `norm_e_sub_e_eq`, and `δ = 2 arcsin(ρ/2R)`, which clamps at `π` so no case on
  `ρ` against `2R` is needed).
- **The surgery** (IM1's child (2)): `ArcMap.trimArcs`, `trimArcs_spec`, `trimArcs_disjoint_ball` (in a good ball), `ArcMap.surgery` (the map,
  local constancy as a hypothesis), and its transfer lemmas `surgery_agreesOff`, `surgery_ringArcsWithin` (engine 2 with the non-unit new arcs),
  `surgery_condition5`, `surgery_hlc_of` (local constancy off the closed ball is `F`'s), `surgery_mem_arcs_iff_of_mem/_of_not_mem`.
- **Horns as sets and counting**: `isOpen_hornSet`, `isPreconnected_hornSet` (a two-germ chart's sector), `hornSet_eq_empty`,
  `eq_branchPt_of_tanHeight_eq_zero` (a point on the tangent arc of curvature `σ` is a branch point), `isClear_col`,
  `encard_sectorsOf_of_partition` (sectors of colour `c` from a partition with possibly empty pieces), `IsSectorChart.encard_sectorsOf`,
  `finite_inter_sphere_of_subset_Γ`, `carrier_circ_full'`.
- **The near data and the generic move**: `ArcMap.Near` (chart, ordered radius `s₀`, good radius `ρ₀`, sector colours; `exists_near`), `Near.Small`,
  `Near.newArcs` (kept germs' arcs, extra arcs, the circle `∂B(v, ρ)`), `Near.move`, and `move_valid`, `move_agreesOff`, `move_ringArcsWithin`,
  `move_condition5`, `move_coloursAt_self` (`v` gains no colour), `move_coloursAt_sphere` (colours on the circle), `mem_move_interiorPts_iff`.
- **The cut** — `Near.exists_cut`: if the sectors `p` and `j = next p` beside germ `j` both have colour `c`, cutting `j`'s branch inside
  `B(v, ρ)` gives a valid map agreeing with `F` off `B̄(v, ρ)`, creating no unit arc, keeping Condition 5, with one `c`-sector fewer at `v`, no
  new colour at `v`, and **at most two** colours at each point of `∂B(v, ρ)`; with `cut_hlc` (local constancy) and `cut_hasSectors` (the
  count, the merged piece open by `exists_ball_subset_of_branchPt` and connected through the branch).

### 6.3 What is left, in order, and the price

**SHAVE (`exists_shave_aux`)**, three cases on the flank colours (one fewer than § 3.2's table: when `g = c` or `h = c` no recolouring is
needed at all, so `hclear` is not read there):
1. `g = c`: `exists_cut` at `p = i₀` (the horn's chart index, `IsSectorChart.index_of_isSector_hornSet`), `j = next i₀`; `col i₀ = c` from the
   horn, `col (next i₀) = g` by `col_eq_of_flankAbove` (`e (β (next i₀)) = e α` by `BranchGerms.e_nextβ`, `κ (next i₀) = κ₂` by `nextκ_eq`);
   `p ≠ next p` since `nextβ i₀ = β i₀` (a one-germ chart has `nextβ = β + 2π`); `{i | col i = c}.encard = n + 1` from `hn` by
   `IsSectorChart.encard_sectorsOf`; `ρ` from `Near.eventually_small`. About 60 lines of glue.
2. `h = c` (and `g ≠ c`): `exists_cut` at `p` with `next p = i₀`, `col p = h` by `col_eq_of_flankBelow`. Same glue.
3. `g ≠ c`, `h ≠ c`: `Near.move` with all germs kept, `E = {germArc v α σ ρ | κ₁ < σ < κ₂}`, the tip `hornSet v α κ₁ κ₂ ρ` recoloured `g` above
   `σ` and `h` below; pieces at radius `r`: the chart sectors `≠ i₀` and `hornSet v α σ κ₂ r`, `hornSet v α κ₁ σ r` (open, connected,
   possibly empty — the partition lemma allows it); clearness from `hclear` at `ρ`; local constancy in the tip by `eq_branchPt_of_tanHeight_eq_zero`
   and off it by `not_mem_interiorPts_of_mem_closure_sector`; colours at `v`: `g`, `h` are `F`'s there (the flank bands); on the circle,
   `move_coloursAt_sphere` with `R` the tip, `C = {g, h}`, and `closure_sector_cases` at the horn's sector (`F`'s colours there `⊆ {c, g, h}`).
   About half a session.

**RAY (`exists_rayMerge_aux`)**: its first conjunct (clearness of the gap) is IM1's § 3.3 frame algebra, untouched; the merge is `exists_cut`
generalised from one germ to a run `next p, …, nextᵗ p` with the run's inner sectors recoloured `c` (merging `H₁` with the nearest `c`-horn
above it, item 262 (a)). About 1.5 sessions. **MERGE (`exists_merge_aux`)**: the run cut again, in a gap of `D_c(v)`, but **without** the full
circle (a rim point with one colour on both sides would be a repeated colour), so its rim arcs and the local constancy on the circle need their
own children, and the `D_c(v′)` clause FS110's argument. About two sessions. **Re-priced** from this stage: the machinery (93 theorems) took
one session; IM1's "three sessions for SHAVE" was high, since the cut cases need no recolouring.

**The shared machinery settles into a module of its own**: everything from `/-! ## The chart near its point` through `Near.exists_cut` reads
only `Cone` and wave 3, and could become `Plane/ValidMap/Surgery`, upstream of `Moves`; RAY and MERGE could then run in parallel downstream of it
(brief § What is yours to decide).

### 6.4 The build and the axioms of this stage

Under the slot, as in § 4.2: **OK**, 445 of 445 batches, 2 modules rebuilt (`Moves` 8.4 s, `Proofs`); warnings only `declaration uses 'sorry'` —
`Moves` exactly 3 (the three `…_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17 (unchanged). Log `build/gate/build/20261004T231602Z-3342967.log`;
terminal output `data/fs131/im/build-stage6.log`. **Axioms**, printed against that build's oleans (`lake env lean data/fs131/im/AxiomsIM2.lean`,
`data/fs131/im/axioms-stage6.txt`, 96 records): the 93 new theorems read `[propext, Classical.choice, Quot.sound]` or fewer
(`BranchGerms.next_injective`: `[propext, Quot.sound]`); the three `…_aux` read `sorryAx` besides. No `axiom`, no `native_decide`. The 93
records are added to `scripts/Axioms.lean`'s FS131-IM1 block (names in `data/fs131/im/im2-names.txt`). The working file
`data/fs131/im/scratch2/S1.lean`, now in `Moves`, is removed.

## Stage 7 — SAVED: FS131-IM3's readback, the as-given build

*FS131-IM3 (de Bruijn, the implementer, on Opus) resumes this record at Stage 7 (standing rule 2): the last SAVED stage is 6, committed in
`6c7573dd` and reported in `9ffc2aba` (`git log -- plans/FS131-IM-implementation.md`). Brief: `data/fs131/briefs/FS131-IM3-moves.md` (on `main`).
Report: `data/fs131/reports/FS131-IM3.md`.*

### 7.1 The brief's quotations against their sources (standing rule 3)

| quotation (a prefix, cut with `…`) | source | result |
|---|---|---|
| "**SHAVE (`exists_shave_aux`)**, three cases on the flank colours (one fewer than § 3.2's table: when `g = c` or `h = c` no recolouring is" | this record § 6.3 | **verbatim** |
| "278. **FS131-IM2 handed back** (Stage 6 SAVED, harness ≈ 505k; report `fs131-w4m`'s `data/fs131/reports/FS131-IM2.md`; commits `aee53d57`, `fe10562b`," | `plans/FS131-close-inventory.md` l. 2049 (on `main`) | **verbatim** |
| "279. **Ruling: the moves' machinery becomes `Plane/ValidMap/Surgery`, and FS131-IM3 continues on `fs131-w4m`.** Choice: IM3 first moves IM2's machinery (`Moves`" | the same, l. 2064 | **verbatim** |
| "262. **Corrections, slips and a tool defect from IM1's report.** (a) **Correction owed — N4-RAY's route**: recolouring the whole gap merges every `c`-sector" | the same, l. 1884 | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 (l. 887) | **verbatim** |
| "- **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc" | the same, § 14.5 (l. 934) | **verbatim** |

The brief's state is as stated: branch head `9ffc2aba`, tree clean. IM1's § 3 and IM2's Stages 5–6 (§ 6.3 above all) read.

**One finding about the ruled range (item 279), not a defect of substance**: the ruling moves "from `/-! ## The chart near its point` through
`Near.exists_cut`" (`Moves` l. 246–2087 at `9ffc2aba`), but that machinery reads IM1's children above it — `germArc`, `carrier_germArc`,
`germArc_nondegenerate`, `germArc_isUnitArc_iff` (in `Near.germ`, `Near.newArcs_*`) and `ArcMap.isClear_of_mem_closure` (in `Near.exists_cut`),
l. 25–244. Once `Moves` imports `Surgery`, those cannot stay in `Moves`; the split therefore moves l. 25–2087, every declaration before the
three `…_aux` statements, so `Moves` keeps only the moves.

### 7.2 The branch builds as given

`9ffc2aba`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, admitted after about ten
minutes' wait behind two other slots): **OK**, all 1746 modules already up to date, nothing built; warnings only `declaration uses 'sorry'` —
`Moves` 3 (the three `…_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17. Log `build/gate/build/20261004T233507Z-3491303.log`; terminal output
`data/fs131/im/build-im3-asgiven.log`. An olean mirror for iteration (`build/im3-mirror`, `data/fs131/im/iter3.sh`) taken from this build.

**Early probe** (scratch, against the mirror, never evidence): SHAVE's two cut cases (`g = c`, `h = c`) elaborate over `Near.exists_cut` with
three small children (`BranchGerms.ne_next_of_nextβ_eq`, `Near.horn_index`, `Near.encard_col_eq`); `data/fs131/im/scratch3/Cut.lean`.

## Stage 8 — SAVED: the split (item 279) — the machinery into `Plane/ValidMap/Surgery`; the audit block moved out of PURCHASED

### 8.1 The split

`tools/fs131_im_split.py --write` generated `Proofs/HadwigerNelson/Plane/ValidMap/Surgery.lean` (2087 lines: a module doc, `namespace` and `open`,
then `Moves`' l. 25–2087 at `9ffc2aba` verbatim, then `end HadwigerNelson.Plane`) and the trimmed `Moves.lean` (60 lines: `9ffc2aba`'s minus l. 25–2088,
its import now `Plane/ValidMap/Surgery`, its module doc pointing at `Surgery`), both from `git show 9ffc2aba:…/Moves.lean`. The range is § 7.1's:
from `/-! ## The arc of a branch germ` through the `end ArcMap` after `Near.exists_cut` — the ruling's l. 246–2087 plus IM1's l. 25–244, which the
machinery reads. `Surgery` imports `Plane/ValidMap/Cone` (what `Moves` imported); `Moves` imports `Surgery`.

**The check** — `--check`: the block found verbatim in `Surgery`; `Surgery` equal to header + block + footer, byte for byte; `Moves` imports
`Surgery` and declares none of the 116 moved names (100 theorems, 16 definitions). `--check-split` adds: `Moves` equal to the source minus the
block plus the new header (true at this commit only; later stages prove the moves in `Moves`). **PASS.** **Negative controls, watched**
(`data/fs131/im/split-control.txt`): (1) `Near.Small`'s `ρ < 1 / 2` changed to `ρ < 1 / 3` in `Surgery` — exit 1, naming the block and the
regenerated text; (2) `isClear_col` copied back into `Moves` — exit 1, naming the name; (3) `Moves`' import changed back to `Cone` — exit 1,
naming the import; each restored by `--write`, `--check-split` passing again.

Other checks: `tools/fs131_im_statements.py --check` PASS (the three `…_aux` statements, diffs empty); `tools/fs131_im_move_cone.py --check` PASS.
`Proofs.lean` gains `Surgery` before `Moves`; `ARCHITECTURE.md` gains `Surgery`'s row, and `Moves`' Imports cell reads `Plane/ValidMap/Surgery`.
The `scripts/Axioms.lean` records are by name and unchanged in content.

### 8.2 A finding: the FS131-IM1 audit block sat under the PURCHASED banner (IM1's slip; IM2's "tool defect" was this)

`tools/check_architecture.py` failed on this branch with "purchase ledgers disagree" (IM2 reported it as a tool defect, item 278). The cause is
not the tool: IM1 inserted its block ("FS-131 wave 4, `Moves` (job FS131-IM1)", 3 + 7 records, later IM2's 93) **directly after**
`#eval IO.println "=== PURCHASED ==="` (l. 3165 at `d4f946ae`), so the tool read the 103 moves records as purchases, and `scripts/axioms.sh` would
fail every one of them at wave 4's gate (a PURCHASED record must carry a native axiom; these carry the standard three or `sorryAx`). The waves
append CLEAN records just above the PURCHASED banner (the file's own note, l. 170–173); I moved the block, unchanged, to there (the file's lines
as a multiset are identical before and after). **Watched**: before the move `check_architecture.py` exits 1, "FAIL purchase ledgers disagree"
(`data/fs131/im/check-architecture-before-axioms-move.txt`); after, exit 0, "RESULT: PASS" (`data/fs131/im/check-architecture-after-axioms-move.txt`).

### 8.3 The build

Under the slot, as in § 7.2: **OK**, 446 of 446 batches, 3 modules rebuilt (`Surgery` 8.4 s, `Moves` 1.4 s, `Proofs`); warnings only
`declaration uses 'sorry'` — `Moves` exactly 3 (l. 27, 39, 50: the three `…_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17 (unchanged); none in
`Surgery`. Log `build/gate/build/20261004T233700Z-3503469.log`; terminal output `data/fs131/im/build-im3-split.log`.

## Stage 9 — SAVED: SHAVE proved (`exists_shave_aux`), its three cases

**Proved** (in `Moves`, before the three statements, under the heading "SHAVE (`exists_shave_aux`): two cuts and one recolouring"; 23 theorems,
listed under "Theorems this phase proved"), in § 6.3's order:

1. **`g = c`** — `exists_shave_of_flankAbove`: `Near.exists_cut` at `p = i₀` (the horn's chart index), `j = next i₀`. Children:
   `Near.horn_index` (a `c`-horn is a chart sector `i₀` of colour `c`, its germs of direction `α` with curvatures `κ₁`, `κ₂`, and the sector
   is the horn at every chart radius — from `IsSectorChart.index_of_isSector_hornSet`), `Near.encard_col_eq` (`s_c(v) = m` counts the chart
   sectors of colour `c`), `BranchGerms.ne_next_of_nextβ_eq` (a germ whose next germ has its direction is not its own next: a one-germ chart's
   next direction is a turn on). The rim bound comes out as `≤ 2`.
2. **`h = c`** — `exists_shave_of_flankBelow`: the cut at `p` with `next p = i₀` (`next` is a bijection of `Fin n`).
3. **`g ≠ c`, `h ≠ c`** — `exists_shave_recolour`: `Near.move` with every germ kept, the extra arcs `shaveArcs` (the `σ`-arc `germArc v α σ ρ`
   when `κ₁ < σ < κ₂`, none otherwise) and the colouring `shaveCol` (`g` above the `σ`-arc in the tip `hornSet v α κ₁ κ₂ ρ`, `h` on or below
   it, `F`'s elsewhere). Children: `mem_germArc_iff_of_mem_hornSet` (inside a horn the `σ`-arc is the tangent circle `tanHeight σ = 0`),
   `shave_mem_interiorPts_iff` (the move's interior points in the ball are `F`'s off the `σ`-circle in the tip), `shave_hasSectors` (the
   horn's sector replaced by its two pieces `hornSet v α σ κ₂ r`, `hornSet v α κ₁ σ r`, possibly empty, coloured `g`, `h`; the partition
   lemma over `{i // i ≠ i₀} ⊕ Bool`), `shave_hlc` (local constancy: the side of the `σ`-circle in the tip, `F`'s off the tip's closure by
   `not_mem_interiorPts_of_mem_closure_sector`), `coloursAt_subset_of_mem_closure_sector` (a point of a chart sector's closure carries at
   most the colours of that sector and its two neighbours, so a rim point carries at most `{h, c, g}`), `Arc.finite_inter_sphere_of_not_isUnitArc`
   (Condition 5 for the new arc), with `shaveArcs_*`, `shaveCol_*` and spec examples for both definitions. `hclear` is read at the chosen `ρ`.

`exists_shave_aux` splits on `g = c`, then `h = c`, and cites the three. **No statement changed** (`tools/fs131_im_statements.py --check` PASS);
`tools/fs131_im_split.py --check` PASS. The 22 children are recorded in `scripts/Axioms.lean`'s IM block (headed "FS131-IM3: SHAVE's children").

**Re-priced from SHAVE**: the two cut cases took a few minutes of glue each over `exists_cut`, as § 6.3 said; the recolouring case about 500
lines, one session-fraction; nothing needed a dispatch.

**The build** (under the slot, as in § 7.2): **OK**, 446 of 446 batches, 2 modules rebuilt (`Moves` 2.7 s, `Proofs`); warnings only
`declaration uses 'sorry'` — `Moves` exactly 2 (`exists_rayMerge_aux`, `exists_merge_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17. Log
`build/gate/build/20261004T235251Z-3627279.log`; terminal output `data/fs131/im/build-im3-shave.log`. **Axioms** against that build's oleans
(`lake env lean data/fs131/im/AxiomsIM3.lean`, `data/fs131/im/axioms-stage9.txt`, 25 records): `exists_shave_aux` and the 22 children read exactly
`[propext, Classical.choice, Quot.sound]`; `exists_rayMerge_aux`, `exists_merge_aux` read `sorryAx` besides. No `axiom`, no `native_decide`.

**RAY's clearness** (the first conjunct of `exists_rayMerge_aux`) elaborates in scratch (`data/fs131/im/scratch3/RayClear.lean`, against the mirror):
`ArcMap.ray_clear`, by record § 3.3's three cases over parabola points `framePt v α X (μ X²/2)` of each horn, every real inequality a small lemma
(`RayGap.*`, LEAN.md's `nlinarith` rule). It goes into `Moves` with the merge.

## Stage 10 — SAVED: MERGE-RAY proved (`exists_rayMerge_aux`); MERGE moved to FS131-IMM1 (item 285), with what I found about it

**Proved** (in `Moves`, between SHAVE's section and the three statements, under the heading "MERGE-RAY (`exists_rayMerge_aux`): the gap's
clearness and the merge with the nearest `c`-horn"; 46 theorems, `data/fs131/im/im3-ray-names.txt`):

1. **The first conjunct** — `ArcMap.ray_clear`: near `v` the gap `hornSet v α κ₂ κ₃ r` between the two `c`-horns is clear for `c`. Record
   § 3.3's argument, made exact over **parabola points** `framePt v α X (μ X²/2)` (`RayGap.exists_parab_mem_hornSet`: for `κ₁ < μ < κ₂` they lie
   in the horn at every small abscissa). A unit circle about `y ∈ c` through a gap point `t` has each horn (a preconnected piece of `c`'s class,
   `side_of_preconnected`) inside it or outside it. *Both inside*: the parabola points of the two horns on the vertical through `t`, one below
   (`RayGap.parab_below`) and one above (`parab_above`), give `b < u₁/2 < 0 < u₂/2 < b` for the normal component `b` of `y − t`
   (`not_both_inside`). *Both outside*: `2b` is trapped between `u₁` and `u₂`, so `|b| ≤ 3x²/4`, the centre is abeam of `t`, and the lower horn's
   parabola point at abscissa `x + a x/2` lies inside (`abeam_contra`, `abeam_inside`). *Mixed*: `v` is in both closures, so `|v − y| = 1`, and at
   a small abscissa both horns' parabola points fall on one side (`exists_same_side`: inside when `y` is ahead of `v` along `α`, outside
   otherwise). Every real inequality is a small lemma carrying only its own hypotheses (LEAN.md's `nlinarith` rule: one 300-line declaration
   timed out until split).
2. **The merge** — `exists_rayMerge_of_clear`, with item 262 (a)'s correction: of the `c`-horns along `α` above the lower horn (the upper horn
   and every chart sector of colour `c` inside the gap) take the one of least lower curvature `κ*` (`Finset.exists_min_image`). If `κ* = κ₂`
   it is the sector just above the lower horn (`Sorted.κ_ne`) and `Near.exists_cut` merges them. Otherwise the gap `hornSet v α κ₂ κ*` holds
   no `c`-sector and `Near.RayConfig.exists_merge` recolours the horn `hornSet v α κ₁ κ₄' ρ` that spans both horns and the gap, cutting every
   germ of direction `α` with curvature in `[κ₂, κ*]` (`rayKeep`, `rayCol`). Children: `RayGap.eq_of_mem_closure_hornSet` (a horn's frontier
   in the open ball is `v` and its two bounding arcs), `Near.sector_subset_hornSet_of_meets` (a chart sector meeting the gap lies in it —
   preconnectedness against that frontier, whose arcs are chart branches), `Near.horn_of_sector_subset_hornSet` (and is a horn there, from its
   cone), `RayGap.curv_le_of_hornSet_subset`, `RayGap.mem_hornSet_cases` (the spanning horn = lower horn ∪ κ₂-arc ∪ gap ∪ κ₃-arc ∪ upper horn),
   `RayConfig.branchPt_not_mem` (kept branches miss the spanning horn), `RayConfig.off_keep_iff` (off the kept branches the punctured ball is the
   spanning horn and `F`'s interior points), `RayConfig.sector_disjoint`, `RayConfig.hasSectors` (partition over `Option T`, `T` the chart
   sectors off the gap and the two horns; count `(n + 1) − 2 + 1`), `RayConfig.hlc`, with spec examples for `rayCol` and `rayKeep`. The rim
   bound is `F`'s two colours plus `c`.

`exists_rayMerge_aux` is `⟨ray_clear …, exists_rayMerge_of_clear … (ray_clear …)⟩`. **No statement changed** (`tools/fs131_im_statements.py --check`
PASS; `tools/fs131_im_split.py --check` PASS). New records in `scripts/Axioms.lean`'s IM block ("FS131-IM3: MERGE-RAY's children"). Names
checked against `fs131-w4`, `fs131-w5`, `fs131-w5p`: no clash (the frame helpers are in a namespace `RayGap` because `UnitArc` has its own
`frameX_framePt`).

### 10.1 MERGE (`exists_merge_aux`) — FS131-IMM1's now; what I found about it, for IMM1

**The brief's amendment** (2026-10-04, inventory item 285), read back: its quotation "285. **Ruling: I5c's slot → the parallel MERGE implementer
FS131-IMM1 on a new branch `fs131-w4mm`; wave 5's next implementer takes the next slot.** Choice: as" is **verbatim** against
`plans/FS131-close-inventory.md` l. 2141 (on `main`). I did not edit `exists_merge_aux` and added no MERGE child; `Surgery` is unchanged since
the split (`tools/fs131_im_split.py --check` PASS), so `fs131-w4mm` (cut from `73d31ad6`) merges with this branch's `Surgery` cleanly. The likely
textual conflicts at the merge are trivial: `scripts/Axioms.lean`, where both branches append records just above the PURCHASED banner, and
`Moves`' statement block if IMM1 rewrites `exists_merge_aux` there.

Not started in Lean. What I worked out:

- **The gap's choice.** The directions of `D_c(v)` form an arc `A` (a convex cone with non-empty interior); every `c`-sector's cone lies in
  `A` (`coneAt_subset_allowedCone`). With `n + 1 ≥ 2` `c`-sectors, at most one of the `n + 1` cyclic gaps between consecutive `c`-sectors meets
  the complement of `A`; take another. Its end directions are interior to `A` unless the adjacent `c`-sector is a cusp at `∂A` (N3-UP's case).
- **`Near.move` and `Near.exists_cut` cannot be used as they are**: both add the whole circle `∂B(v, ρ)` as an arc (`Near.newArcs`), and a rim
  point with one colour on both sides of it carries a repeated colour, against MERGE's rim clause (IM1's § 3.1 note). MERGE needs a surgery
  whose rim arcs lie only where the colour changes, and its own local-constancy proof on the rest of the circle (`surgery_hlc_of` assumes the
  whole circle is on the new arcs).
- **A finding about the rim clause** `∀ x ∈ sphere v ρ, ¬ F'.HasRepeatedColour x`: a valid `ArcMap` may carry a germ at `v` with the **same
  colour on both sides** (nothing in `Valid`, `Condition5` or the statement forbids it). Where such a germ crosses `∂B(v, ρ)`, `F'` agrees with
  `F` outside the closed ball, so the outer piece is still an arc with one colour on both sides; if the germ also continues inside (or the rim
  is an arc there) that point has two sectors of one colour. So the construction must, for every such germ, **cut it in a thin annulus just
  inside `ρ`** (its inner part, which the sector count at `v` may need, stays; the outer piece then ends at the rim with no arc inside, one
  sector). Inside the chosen gap, a same-coloured pair of gap sectors across a gap germ forces the recoloured region's boundary to run inside
  the ball (radius `ρ' < ρ`) rather than along the rim. Example that rules out the naive construction: three `c`-sectors at `v` separated by
  three radial segments with `c` on both sides (`n + 1 = 3`): cutting one segment gives `n = 2`, and the other two must be cut near the rim
  or their rim points carry `c` twice. I believe the statement is **true** (the annulus cuts repair it), but MERGE's price is above § 6.3's
  "about two sessions": the surgery needs variable rim arcs, annulus cuts, and FS110's `cl R ∩ ω(v′) ⊆ {v}` for the `D_c(v′)` clause (contact
  types do not change: when `c ∈ coloursAt v′`, every `c`-tile of `F'` avoids `ω(v′)` by validity, so a merged tile lies on one side).
- Reusable as they stand: `Near.horn_index`, `Near.encard_col_eq`, `ne_next_of_nextβ_eq`, `coloursAt_subset_of_mem_closure_sector`,
  `encard_sectorsOf_of_partition`, `Arc.outer`/`trimArcs`/`ArcMap.surgery` and its transfer lemmas (`surgery_agreesOff`, `surgery_ringArcsWithin`,
  `surgery_condition5`), N3-CLEAR (`clear_of_subset_interior_allowedCone`) and N3-UP (`lens_dist_lt_one_of_up`, `lune_dist_le_of_up`) in `Cone`.

### 10.2 The build and the axioms

Under the slot, as in § 7.2: **OK**, 446 of 446 batches, 2 modules rebuilt (`Moves` 13 s, `Proofs`); warnings only `declaration uses 'sorry'` —
`Moves` exactly 1 (l. 1667, `exists_merge_aux`), `Contact` 4, `BaseSteps` 7, `UnitArc` 17; no other warning (a deprecation warning,
`Set.encard_diff_add_encard_of_subset`, seen in iteration, was fixed to `Set.encard_sdiff_add_encard_of_subset` before the build). Log
`build/gate/build/20261005T001350Z-3780541.log`; terminal output `data/fs131/im/build-im3-ray.log`. **Axioms** against that build's oleans
(`lake env lean data/fs131/im/AxiomsIM3.lean`, `data/fs131/im/axioms-stage10.txt`, 71 records): `exists_shave_aux`, `exists_rayMerge_aux` and
their 68 children read exactly `[propext, Classical.choice, Quot.sound]`; `exists_merge_aux` reads `sorryAx` besides. No `axiom`, no `native_decide`.

**Re-priced**: RAY took about one session-fraction more than SHAVE (the clearness algebra ~350 lines, the merge ~500), against § 6.3's
"about 1.5 sessions".
