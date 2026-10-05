# FS131-IW — Woodall's chain in the kernel: the implementer's record

*Brief `data/fs131/briefs/FS131-IW-woodall.md`; branch `fs131-ww` (worktree `.claude/worktrees/fs131-ww`), on `058c65f8`. Implementer: de Bruijn on Sonnet 5.5.*

## Theorems this phase proved

Axioms below are from `#print axioms` on **iteration oleans** (`data/fs131/iw/iter.sh`, `lake env lean` with the lakefile's options against scratch
oleans), the whole print in `data/fs131/iw/axioms-iteration.txt` and its split in `data/fs131/iw/axioms-iteration-summary.txt`. The gate has not run
(waves 3–4 and FS131-LEB have not landed): this is **not gate evidence**. A `sorryAx` below is never this job's: it comes through a cited, unlanded
statement (`lemmaL`; `ArcMap.dense_interiorPts`; `ArcMap.Valid.unitPairsNull_region`) or through one of the five leaves left (stage 2).
The FS131-IWd rows (stages 14–16) are from `data/fs131/iwd/axioms-iteration.txt` (`lake env lean` on `data/fs131/iwd/scratch/ax.lean`, importing the built
`Woodall/Steps`; never evidence): the three leaves and E3-BALL print the standard three; the chain theorems of `Steps` still print `sorryAx`, through wave 4's
skeleton alone (`lemmaL`, `ts_t`, … in `Plane/SVMap`, a `sorry` statement on this branch until wave 4 lands). The FS131-IWc rows (stages 7–11) are from `data/fs131/iwc/axioms-iteration.txt` (`lake env lean` on a copy of `Merge` with the prints appended,
`data/fs131/iwc/scratch/ax.lean`; never evidence); since FS131-W3's merge of `main` (wave 3 landed; kernel plan § 12) every IWc theorem but `exists_woodallMerged`
prints the standard three alone.

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
| `ArcMap.exists_three_le_sectors`, `ArcMap.aeMap6_normal`, `ArcMap.aeMap6_merged` (moved after `aeMap6_normal`, which it cites), `ArcMap.aeMap6`, `ArcMap.aeMap6_of_condition5`, `woodall_thm6` | compositions, § 9.3; `aeMap6_merged` as § 9.3's route (cyclic step by the orbit of `finRotate`, `step5_lt` at the horn, injectivity, `step5_lt` again for the angles) | proved from their citations; `sorryAx` through `exists_sectorsAt`, `ts_t`, `step6`, `step5_lt`, `exists_woodallMerged` (open or cited) |
| **FS131-IWb** — the connected piece: `ArcMap.exists_preconnected_of_mem_coneAt`, `collarAt_shadow_inner_of_mem_coneAt`, `collarAt_shadow_outer_of_mem_coneAt`, `SectorsAt.mem_coneAt_of_mem_Icc` | the brief's child ("a preconnected piece of a colour class approaching a point along a cone direction, for a horn and for any sector") | `sorryAx` through wave 3's `coneAt_region_eq_biUnion` (proved on `fs131-w3`, unlanded); `mem_coneAt_of_mem_Icc`: standard three |
| **FS131-IWb** — E1-RAY (inner, outer) and E1-BAD's interior case `SectorsAt.not_mem_coloursAt_of_mem_Ioo`, re-proved through the cone clause (items 154–155) | unchanged statements, § 8.5 | `sorryAx` through the connected piece (wave 3) and, for E1-BAD's case, E1-SEE's citation (`unitPairsNull_region`) |
| **FS131-IWb** — **`ArcMap.step5_lt`** (Woodall's step 5, strict), with `SectorsAt.collarAt_opposite`, `collarAt_closure_of_forall_shadow`, `exists_two_cover_of_three_le_card`, `Valid.region_dist_ne_one` | § 4.5's route: the inner arc `(β₂ − 3π/2, β₁ − π/2)` of length `π − φ > 2π/3`, inner collars for the three colours from the two edges as cone directions (horns included), two colours left, `woodall_step4` | `sorryAx` through cited statements only: `lemmaL` (via `woodall_step4`), `dense_interiorPts` (via `subset_closure_of_subset_shadow`), `coneAt_region_eq_biUnion`; `exists_two_cover_of_three_le_card`, `Valid.region_dist_ne_one`: standard three |
| **FS131-IWb** — **`ArcMap.step6`** (Woodall's step 6 by Townsend's lemma), with `false_of_cos_eq_zero_on_Icc`, `exists_eq_add_half_pi_of_cos_eq_zero`, `cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two`, `collarAt_setOf_forall_mem`, `CollarAt.of_abs_sub_lt` | § 4.5 / § 9.3's route: off the six edge normals one side works at first order (two sectors failing on opposite sides share an edge whose normal is the angle); the seed is an opposite arc of length `π − φ > π/3` when some angle is `< 2π/3`, else the certified normal of edge `d 0` (`exists_normal_collarAt`) extends one of length exactly `π/3`; `townsend_lemma` | `sorryAx` through cited statements only (`lemmaL` via `townsend_lemma`; `dense_interiorPts`; `coneAt_region_eq_biUnion`); the five real-variable children: standard three |
| **FS131-IWc** — **`clear_wedge` (E3-W)**, with `mem_annSector_union_of_ne`, `disjoint_annSector_wedges`, `annSector_subset_ball`, `annSector_mono_r₂`, `mem_segment_ray` | `plans/FS131-E3-derivation.md` § 3.2 (E3-W; the plan's read-back: hypotheses weaker, same radius and conclusion) | standard three |
| **FS131-IWc** — the recolouring and the merge at a wedge: `recolour_valid`, `recolour_region_diff`, `wedgeArcs_nondegenerate`, `frontier_annSector_subset`, `wedgeMerge_valid`, `wedgeMerge_condition5`, `wedgeMerge_region_diff`, with `wedgeArcs_subset_polar`, `polar_notMem`, `annSector_notMem_wedgeArcs` | `plans/FS131-W-kernel-plan.md` § 14.2–14.3 rows | standard three |
| **FS131-IWc** — locality and local data: `coloursAt_congr`, `niceAt_congr`, `exists_dirColourAt`, `GoodAt.ncard_coloursAt_le_two` (with `ncard_coloursAt_le_two_of_sides`, `mem_curveAt_one_iff`), `finite_three_le_coloursAt`, `dirColourAt_wedgeMerge`; cones after a merge `coneAt_wedgeMerge_of_notMem`, `eq_of_mem_coneAt_wedgeMerge`, `eq_of_mem_coneAt_wedgeMerge_of_subset` (with `mem_coneAt_inter_annSector`, `mem_angleIcc_iff_e`, `isClosed_angleIcc`) | § 14.2–14.3 rows; § 14.4 / stage 11 (the measure's cone facts) | standard three |
| **FS131-IWc** — **`exists_woodallMerged` (E3-BALL)** as a composition | E3-BALL, `plans/FS131-E3-derivation.md` § 3.4 (verbatim E3's draft) | `sorryAx` through `exists_merge_at` (open leaf) only |
| **FS131-IWc** — `Basic`'s inhabitant leaves T1–T5 (`threeCol_locallyConstant`, `threeSectorDisc_sectorsAt`, `threeSectorDisc_phantom`, `threeSectorDisc_ncard_coloursAt_le_two`, `halfDisc_sectorsAt`), so `threeSectorDisc_niceAt`, `_woodallMerged`, `_woodallNormal`, both phantom adversaries and `halfDisc_niceAt`; children `coneAt_annSector_eq`, `mem_annSector_zero_iff`, `threeSectorDisc_region`, … | § 13.2's table (every clause of the ∃-forms exercised on a valid map; item 158's defect a test) | standard three |
| **FS131-IWd** — **`niceAt_of_dirColourAt`** (the `NiceAt` picture from the local data), with `DirColourAt.const_of_noChange`, `rightCol`/`leftCol` lemmas, `exists_offDirs_punctured`, `finRotate_val`, … (stage 14) | E3-NICE's last paragraph; plan § 14.3 row; stage 11's truth reading | standard three |
| **FS131-IWd** — **`wedgeMerge_niceAt`** (the crossings a merge creates), with `niceAt_of_crossing`, `GoodAt.exists_sides`, `wedgeMerge_crossing`, `cos_pos_arc`, `exists_sign_near`, `coneAt_subset_halfPlane` (stage 15) | E3-NICE's crossings; plan § 14.3 row (no transversality needed) | standard three |
| **FS131-IWd** — **`exists_merge_at` (E3-NICE)**, with `DirColourAt.exists_merge_dirs`; so **`exists_woodallMerged` (E3-BALL)** on its proved children (stage 16) | `plans/FS131-E3-derivation.md` § 3.3, as read back in plan § 14.2; stage 11's measure | standard three (both) |

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

**Proved (modules sorry-free): `Plane/Woodall/Collar` (0 `sorry`), `Plane/Woodall/NoFourFive` (0 `sorry`).** `Plane/Woodall/Steps` has **4** left, each
named: `exists_sectorsAt` (H), `exists_woodallMerged` (H+), `step5_lt` (M, with the horn child below), `step6` (H−). `lebesgue_covering_square` is FS131-LEB's.

**Re-pricing (from the first two hard leaves).** The plan's table priced `Collar`'s foundation at M/E and the module at about two implementer sessions; the
first two leaves (`isOpen_annSector`, `isPreconnected_annSector`) closed in one pass each, on one polar-coordinate lemma (`eq_add_norm_mul_e`, `eventually_abs_arg_lt`)
that every later leaf reused. All of `Collar` and `NoFourFive` (about 55 declarations, 1,300 lines) took about 380k tokens. Open leaves, by what each needs:
* `step5_lt` (M): `woodall_step4` on the inner arc opposite the narrow sector, `collarAt_shadow_inner` for the three colours' tiles, `neighbour_dirs` through the
  `Fin` wrap (`prev_succ`, `d_prev_succ`, `exists_prev_dir` are in `NoFourFive` and serve it). Not started.
* `aeMap6_merged` (M): **proved** (stage 3), over `step5_lt`; the order of declarations in `Steps` changed (it now follows `aeMap6_normal`: the skeleton
  put it before the theorem it cites, which cannot elaborate). No statement changed.
* `step6` (H−): `townsend_lemma` with `K` the at most three uncertified normals (`exists_normal_collarAt`, in place), seeds from `collarAt_shadow_inner`/`outer_of_mem`
  and `exists_cur_dir`/`exists_prev_dir`. Not started.
* `exists_sectorsAt` (H) and `exists_woodallMerged` (H+): not started; the second is a separate job at this rate.

**Plan gap found at `step5_lt` (read while pricing it; not yet a statement defect).** § 4.5's route puts an inner collar about each `ψ` of the arc
`I = (β₂ − 3π/2, β₁ − π/2)` in the shadow of each of the three colours `A, B, C`, by `collarAt_shadow_inner` on a **preconnected piece** of the colour's
class approaching `v` along a direction `γ ∈ (ψ + π/2, ψ + 3π/2)`. For the middle sector and for a neighbour of positive width that piece is a truncated
sector (`SectorsAt.collarAt_shadow_inner_of_mem`, E1-RAY, with `γ = β₁ − δ` resp. `β₂ + δ`; strict inequalities make `δ` available). For a **horn**
(sector `i` itself, or a neighbour, of width `0`; `SectorsAt` allows them) the plan says "a horn's own direction", but `SectorsAt` supplies the horn's
direction only as a point of `coneAt (region c) v` (the cone equation), with no preconnected set of the class approaching along it (the class is a union
of tiles, not connected), and `collarAt_shadow_inner` needs one. The fix is local structure (wave 3's tiles and `exists_mem_coneAt_region`, or the
finitely many arcs near `v`), not a change of statement; the planner should price `step5_lt` with that child (a **connected piece of a colour class
approaching `v` along any cone direction**, for an arc map of the plane), and likewise `step6` (its first-order presence sets read cone directions of
sectors of any width). `aeMap6_merged` uses `step5_lt` precisely at a horn (the sector `i` itself has width `0`), so the horn case is the one it needs, not an exotic one.

**Findings.** No statement defect: no leaf proved so far disagreed with its statement. E1-NO45's chain is formalizable as written (see above). Two
notes for the planner: (i) `exists_parabola_region` and `absent_at_normal` carry `hn : 2 ≤ n` unused (it follows from the others); kept, discharged by `have _ := hn`.
(ii) every theorem here that cites `lemmaL`, `dense_interiorPts` or `Valid.unitPairsNull_region` shows `sorryAx` until waves 3–4 land; the parabola lemmas, `exists_normal_collarAt`, `absent_at_normal` and `exists_mem_Ico` are free of it (`exists_two_absent` is not: it cites E1-SEE).

## Stage 3 — SAVED: `aeMap6_merged`; the final build

`aeMap6_merged` proved and moved after `aeMap6_normal`; `finRotate_ne_symm` added (`n ≥ 3`: the rotation has no 2-cycle). `tools/fs131_w2_decls.py --check`: 115
theorems, 115 records. The build of stage 2's tree: OK, 444 of 444, 8 m 47 s, `build/gate/build/20261004T123605Z-3530781.log` (`data/fs131/iw-build1.log`;
`Collar` and `NoFourFive` built with no warning; every warning of `Steps` is `declaration uses 'sorry'`). The build of stage 3's tree: **OK — 444 of 444, 2 modules rebuilt, 12 with warnings, 8 m 8 s, exit 0** (`build/gate/build/20261004T125346Z-3674506.log`, `data/fs131/iw-build2.log`); the only warnings in the four Woodall modules are `declaration uses 'sorry'` in `Steps` (four leaves).

## Drafts for the front page

Not drafted: the gate has not run, no milestone state moved. Slot, when the gate runs: `CLAUDE.md` § The gate gets the counts; the ledger rows FS106-WO,
FS106-TW, FS106-AE-MAP6 and the E1-NO45 row stay [hand] until `Steps` is sorry-free and waves 3–4 and FS131-LEB land.

## Tools and working files

`data/fs131/iw/iter.sh` (iteration elaboration, never evidence), `data/fs131/iw/scratch/run.sh` and the scratch files `t*.lean` (the leaves as first developed),
`data/fs131/iw/axioms-iteration*.txt`. `tools/fs131_w2_decls.py --check`: 114 theorems, 114 records, 0 missing, 0 stale; `--plant` fires both ways.
`tools/check_architecture.py`: PASS (the `Plane/Chord` import of `Collar` added to its row).

## Stage 4 — SAVED (FS131-IWb): the readback

*Brief `data/fs131/briefs/FS131-IWb-woodall.md` (on `main`); the second implementer on this chain, de Bruijn on Opus 5.5; branch `fs131-ww` at `a731f352`.*

**The brief's three quotations** match their sources verbatim: the § 9.5 line "waves unchanged), and imports (updating `ARCHITECTURE.md`, `scripts/Axioms.lean`,
then `tools/fs131_w2_decls.py --check`). It may not change any" (`plans/FS131-W-kernel-plan.md` line 827, inside § 9.5, read whole); Stage 3's opening line (this
record, line 75); Stage 2's "Plan gap found at `step5_lt`" paragraph (this record, line 58). **The build as given** (`a731f352`, before any edit): OK, all 1745
modules already up to date (IW's final build was of this tree; `a731f352` added scratch files only), 12 modules with warnings, the four `sorry` warnings in
`Steps` at lines 55, 138, 147, 160 (`exists_sectorsAt`, `exists_woodallMerged`, `step5_lt`, `step6`); `build/gate/build/20261004T131326Z-3756794.log`, driver log
`data/fs131/iwb/build0.log`.

**What I may change**: children anywhere in the four Woodall modules (in `Basic` and `NoFourFive` children only); supporting lemmas in the foundation modules
(statements of other waves unchanged); imports (with `ARCHITECTURE.md`, `scripts/Axioms.lean`, `tools/fs131_w2_decls.py --check`); `Proofs.lean`. **What I may
not**: any statement of § 3.1's table kept by § 8.4, any statement of §§ 8.4–8.5, any definition of `Plane/Woodall/Basic` or `Plane/Woodall/NoFourFive`, any new
`axiom`, any `native_decide`; nothing with a `sorry` reaches `main`.

**Statement defect found at once, messaged to the coordinator (2026-10-04)**: `ArcMap.exists_sectorsAt` is false as stated. `SectorsAt`'s fifth clause
(`annSector v 0 r (d i.castSucc + δ) (d i.succ − δ) ⊆ F.region (c i)` for every `δ > 0`) cannot hold for a sector merged across an arc between two same-coloured
sides, and clause 4 forces the merge. Smallest counterexample: `k = 1`, `F = {dom := univ, arcs := {Arc.seg (−1) 1}, col := fun _ => 0}`, `v = 0`. Here `n ≥ 2`
violates clause 4 in `Fin 1`; at `n = 1`, clause 5 at `δ = π/4` needs an open angle range of length `3π/2`, which holds a multiple of `π`, so the annular sector
holds a point of the segment, which is not an interior point. The same happens at points of three or more colours where a class is split by an arc (a hexagonal
7-colouring with one slit is a valid plane map with no picture at the slit's midpoint). Proposed fix, the planner's call: drop clause 5 or weaken it to `⊆ closure
(F.region (c i))`. Its only readers, E1-RAY (inner, outer) and E1-BAD's interior case, re-prove from the cone equation through the connected-piece child below.
`exists_sectorsAt` is held until the ruling.

## Stage 5 — SAVED (FS131-IWb): `SectorsAt`'s fifth clause replaced by `v ∈ F.dom` (inventory items 154, 155); the three readers re-routed; the connected piece

**The rulings.** Item 154 (Keryx, 2026-10-04): drop clause 5. **A second finding, messaged before the change**: dropping it outright makes E1-RAY false
off the domain. Counterexample: `v = 0 ∉ dom`; colour 0 on `A = ⋃ₘ annSector 0 2^(−2m−1) 2^(−2m) a b` (radial pieces with gaps accumulating at `0`), colour 1 on
the open sector `(b, a + 2π)`, `dom = A ∪ B`, no arcs. The picture `n = 2`, `d = (a, b, a + 2π)`, `c = (0, 1)` satisfies every other clause. Unit circles about
points just inside `ω(0)` cross the narrow `A`-directions near `0` in a band of distance ratio below 2, which falls in a radial gap infinitely often, so no inner
collar lies in `shadow A`. Item 155 (Keryx): **replace clause 5 by `v ∈ F.dom`, at the same position** (no projection moves; the cone clause stays
`h.2.2.2.2.2`).

**Changes (no statement of §§ 3.1, 8.4–8.5 changed; the one definition the amendment licenses).**
* `Plane/Woodall/Basic`: `SectorsAt`'s fifth clause is now `v ∈ F.dom`, and its docstring and the module docstring say so with the item number;
  `const_sectorsAt`'s fifth component is `mem_univ v`.
* `Plane/Woodall/NoFourFive`, new children before E1-RAY: **`exists_preconnected_of_mem_coneAt`** (the connected piece your brief asked for: at a
  point of the domain, a direction of the cone of `j`'s class is a direction of the cone of one of its tiles, a preconnected subset of the class — wave 3's
  `coneAt_region_eq_biUnion`; a horn's direction included); **`collarAt_shadow_inner_of_mem_coneAt`**, **`collarAt_shadow_outer_of_mem_coneAt`** (W's
  `collarAt_shadow_inner/_outer` on that piece); **`SectorsAt.mem_coneAt_of_mem_Icc`** (a direction of a closed sector is in its colour's cone).
* Re-routed, statements unchanged: **E1-RAY** inner and outer (`SectorsAt.collarAt_shadow_inner_of_mem`, `_outer_of_mem`) — the cone clause, the
  connected piece, `hv := h.2.2.2.2.1`; **E1-BAD's interior case** (`SectorsAt.not_mem_coloursAt_of_mem_Ioo`) — directions of sector `i` at `D₂ ± η` give an
  inner and an outer collar about `ψ` (E1-RAY), and the robust kill `not_mem_coloursAt_of_collarAt` finishes; no exact point is read.
* `scripts/Axioms.lean`: a section "FS-131 Woodall's chain (job FS131-IWb)" with the four records; `tools/fs131_w2_decls.py --check`: 119 theorems,
  119 records, 0 missing, 0 stale.

**Axioms**: the four children, E1-RAY and E1-BAD's interior case now cite `coneAt_region_eq_biUnion` (wave 3, proved on `fs131-w3`, a `sorry` statement
here until wave 3 lands), so they show `sorryAx` until then. Before this stage E1-RAY was on the standard three axioms.

**Build of this stage**: OK — 444 of 444 batches, 5 modules rebuilt, 12 with warnings, 8 m 46 s, exit 0 (`build/gate/build/20261004T132056Z-3782220.log`,
driver log `data/fs131/iwb/build1.log`); `Woodall/Basic`, `Collar` and `NoFourFive` built with no warning, and the only warnings in `Steps` are the four
`declaration uses 'sorry'`. Iteration tools: `data/fs131/iwb/run.sh` and `olean.sh` (a private `cp -rs` olean mirror under `build/iwb-olean`; the symlink is
removed before an olean is written, so nothing writes through into `.lake/build`). Never evidence.

## Stage 6 — SAVED (FS131-IWb): `step5_lt` and `step6` proved; the route for `exists_sectorsAt`; `exists_woodallMerged` re-priced

**`step5_lt` proved** (statement unchanged). The connected piece closes the plan gap IW found: both edges `β₁ = d i.castSucc`, `β₂ = d i.succ` of sector `i` are
cone directions of `c i`, and, mod `2π` (`d_prev_succ`), of the previous and the next colour. For `ψ` in the inner arc `(β₂ − 3π/2, β₁ − π/2)` both edges lie in
the far half `(ψ + π/2, ψ + 3π/2)`, so the three colours carry inner collars about `ψ` (`SectorsAt.collarAt_opposite`, which reads only cone directions, so a horn
sector or horn neighbour needs no case). `collarAt_closure_of_forall_shadow` (W's `subset_closure_of_subset_shadow` on the intersected collar) leaves the two
other colours (`exists_two_cover_of_three_le_card`, `k ≤ 5`), and `woodall_step4` on the arc of length `π − φ > 2π/3` gives `False`. No δ, no truncated sector.

**`step6` proved** (statement unchanged). Cut angles `K` are the six edge normals `d j ± π/2` (`j = 0, 1, 2`). Off `K`, inner or outer first order holds at `θ`.
If not, some sector has `cos (γ − θ) ≥ 0` throughout and some sector has `≤ 0` throughout. One sector can't do both (`false_of_cos_eq_zero_on_Icc`: zeros of
`cos` are `π` apart). So they are two sectors, which with three sectors are adjacent: their common edge `e` has `cos (e − θ) = 0`, and `θ` is a normal of `e`
(`exists_eq_add_half_pi_of_cos_eq_zero`), in `K`. The seed: if some angle is `< 2π/3`, the arc opposite it has length `π − φ > π/3` and is inner at first order
(each sector holds an edge in the far half). If all three are `2π/3`, the refined second-order lemma (`exists_normal_collarAt`) certifies a normal
`d 0 + σπ/2` of edge `d 0` for both of its colours; the third colour's cone holds `d 2` (σ = 1) or `d 1` (σ = −1) in the far half; the collar there extends
the opposite arc of length exactly `π/3` (of sector 2, resp. 0) by a margin (`CollarAt.of_abs_sub_lt`). `townsend_lemma` finishes. W's count of "at most three
cut angles" is not needed: `townsend_lemma` takes any finite `K`.

**Build of this stage**: OK — 444 of 444 batches, 2 modules rebuilt, 12 with warnings, 8 m 26 s, exit 0 (`build/gate/build/20261004T133104Z-3845273.log`,
driver log `data/fs131/iwb/build2.log`). The only warnings in the Woodall modules are the two `declaration uses 'sorry'` in `Steps`: line 106
(`exists_sectorsAt`) and line 189 (`exists_woodallMerged`). Records: 9 more in the FS131-IWb section of `scripts/Axioms.lean`; `tools/fs131_w2_decls.py --check`: 128 theorems, 128 records, 0 missing, 0 stale;
`--plant` FIRED both ways. Name collisions: none of the 13 new theorem names is declared on `main`, `fs131-w2`, `fs131-w3`, `fs131-w4` or `fs131-leb` (`git grep`;
the QA1 tool runs at the gate). Axioms (iteration print, `data/fs131/iwb/scratch/ax.lean`, never evidence): `step5_lt` and `step6` show `sorryAx` only through
cited unlanded statements (`lemmaL`, `dense_interiorPts`, `coneAt_region_eq_biUnion`, `Valid.unitPairsNull_region`); the five real-variable children,
`exists_two_cover_of_three_le_card`, `Valid.region_dist_ne_one`, `SectorsAt.mem_coneAt_of_mem_Icc` and `const_sectorsAt` are on the standard three.

**The route for `exists_sectorsAt`** (the clause-5 replacement makes it a statement about cones only; no `localSectors` needed; every named lemma is
wave 3's, proved on `fs131-w3`, public at the end of `Plane/LocalStructure`):
1. *Bad directions.* `GoodAt v ρ₀` (`exists_goodAt`); `𝒜` the finitely many arcs meeting `ball v ρ₀`, all through `v`. For an arc with `b = (a.curveData v).2 ≠ 0`,
   `Arc.Tang v (e β) a` is `(b * conj (e β)).re = 0`, i.e. `|b| cos (arg b − β) = 0`, i.e. `β ∈ arg b + π/2 + πℤ`. Let `T` be the finset `{arg b_a + π/2}` and
   `Bad β := ∃ t ∈ T, ∃ m : ℤ, β = t + π m`. Then `¬ Bad β` means no arc of `𝒜` is tangent to `e β`, and `Bad` meets any bounded window in a finite set.
2. *A good direction has one colour, locally.* For `¬ Bad β`: `GoodAt.exists_wedge` (with `u = e β`) gives `m`, `N₀`; with `N = max N₀ 1` the wedge
   `W = Rgn v (e β) N m` lies in the interior points (every arc meeting it is tangent to `e β`, and none is). `W` is preconnected (`isPreconnected_Rgn_lev`, `I = univ`),
   so it lies in one class, of colour `a β`. (U) every colour whose cone holds `β` is `a β`: by `exists_mem_Rgn_of_mem_coneAt`, its class meets `W`.
   (N) there is `ε > 0` with `Ioo (β − ε) (β + ε) ⊆ coneAt (region (a β)) v`: `ray_mem_Rgn` (with `u₀ < min (m/4) (1/2)`) puts the rays at `β ± u₀`, and the ray at
   `β` itself, into `W` for small radius, and a ray inside a set approaches along its own direction (a three-line child). Define `a β` as `Classical.choose
   (exists_mem_coneAt_region hv β)`; by (U) it is the wedge's colour.
3. *Constant between bad directions.* (N) at `β` with (U) at `β'` gives `a β' = a β` for nearby good `β'`; on an open interval with no bad direction, `a` is
   locally constant, hence constant (`isPreconnected_Ioo.constant`, continuity from local constancy as in `continuousOn_col`).
4. *A pre-picture with uniform slots.* Choose a good `θ₀` (the bad directions in `[0, 1]` are finite). Let `p : Fin r → ℝ` be the sorted bad directions in
   `(θ₀, θ₀ + 2π)` (`Finset.orderEmbOfFin`). If `r = 0`: `n = 1`, `d = (θ₀, θ₀ + 2π)`, `c = a θ₀`. If `r ≥ 1`, give each breakpoint `k + 1` slots:
   `n = r (k + 1)`; slot `(l, s)` (index `l (k + 1) + s`) starts at `d = p l`; for `s < k` it is a horn of colour `if s ∈ H l then s else a_l`, where
   `H l = {j | p l ∈ coneAt (region j) v}`; for `s = k` it is the interval `[p l, p (l + 1)]` (`p r := p 0 + 2π`) of colour `a_l = a ((p l + p (l + 1))/2)`;
   `d n = p 0 + 2π`. A horn coloured `a_l` is harmless: `p l` lies in the closed interval of that colour. The cone clause: `⊆` from (U) off `Bad`, and from
   `H l` at a breakpoint (shifted into the window by periodicity, `mem_coneAt_add_two_pi`); `⊇` from (N) on each open interval, closedness of the cone
   (`isClosed_coneAt`) at its ends and at the interior points that are not true breakpoints, and the definition of `H l` for the horns.
5. *Merge.* `PreSectorsAt` := `SectorsAt` without clause 4. Strong induction on `n`: if `n = 1` or every adjacent pair differs, done. Else merge a pair
   `(i, i + 1)` of one colour with `i + 1 < n` by `Fin.removeNth (i + 1)` on `d` and `c` (cone clause: `angleIcc a b ∪ angleIcc b c' = angleIcc a c'` for
   `a ≤ b ≤ c'`). A wrap pair `(n − 1, 0)` is first rotated (`d' k = d (k + 1)` for `k < n`, `d' n = d 1 + 2π`, `c' = c ∘ finRotate n`; the cone clause
   holds by `2π`-periodicity of `angleIcc`), which makes it the pair `(n − 2, n − 1)`.
Price: H, about 600–800 lines (step 4's index arithmetic and step 5's `Fin.removeNth` are most of it). Its axioms will be wave 3's.

**`exists_woodallMerged`, re-priced: H+, a job of its own, and first a derivation.** What it needs, none of it held:
(i) Woodall's clearness lemma in this project's terms (region-only: a run of sectors of total angle `< π` between two sectors of colour `c` at `P` has,
near `P`, no point at distance exactly `1` from a point of colour `c`). W's § 4.5 has it in one paragraph, and no derivation in `plans/` re-derives
step 3 the way E1 re-derived steps 5–8.
(ii) The modification as an `ArcMap`: arcs of `F` outside small discs, a circle of radius `ε(P) < 1` about each vertex with a repeated colour, radii small
enough for disjointness and local finiteness, colours changed on the runs. Plus validity across discs and against far points, the plane, and
Condition 5 kept.
(iii) `WoodallMerged` for the new map at every point. That reads its pictures (old vertices after recolouring, and the new vertices where the small circles
cross old arcs), so it needs `exists_sectorsAt`'s analysis applied to the modified map.
Rough size: 1500–3000 lines. Recommended: a derivation of step 3 as a modification lemma with every clause, then a planner's skeleton, then an
implementer. A derivation might also find a statement that avoids the modification: E1-style handling of repeated colours at a point directly in the
contradiction chain. That is the deriver's question, not mine.

**Where I stop.** At about 430k by the harness's count, under the brief's line of about 500k. `exists_sectorsAt` (H, 600–800 lines) would not fit, so
it is left with the route above. The gate and the landing still wait for waves 3–4 and FS131-LEB.

## Stage 7 — SAVED (FS131-IWc): the readback; `NiceAt.normal` private

*Brief `data/fs131/briefs/FS131-IWc-woodall-merge.md` (on `main`, with Keryx's amendment of 2026-10-04: a plane-map model of the normal forms once wave 4's
`sevenBrickMap` is merged); the third implementer on this chain, de Bruijn on Opus 5.5; branch `fs131-ww` at `8488ad82`.*

**The brief's two quotations** match their sources verbatim: "167. **FS131-W3 done, harness ≈ 442k** (report on its branch; `fs131-ww` at `8488ad82`,
checked): E3's drafts in the chain, statements verbatim, each elaborating on the" is `plans/FS131-close-inventory.md` (main) line 1141 (`grep -nF`, one hit;
the item read whole, with its rulings (a)–(d)); "- `Woodall/Merge`: new; 18 `sorry` leaves; `recolour` and four small lemmas proved;" is
`plans/FS131-W-kernel-plan.md` § 15.3 (this branch, `grep -cF` → 1; § 15.3 read whole, and §§ 11–16). No mismatch.

**The build as given** (`8488ad82`, before any edit): OK — all 1748 modules already up to date, nothing built, 7 modules with warnings (wave 4's five
skeleton modules, `Woodall/Basic`, `Woodall/Merge`, each Woodall warning `declaration uses 'sorry'`), 2 s, exit 0 (`build/gate/build/20261004T152755Z-356556.log`;
driver log `data/fs131/iwc/build0.log`). Sorry leaves: `Merge` 18, `Basic` 5 (T1–T5), `Steps`, `Collar`, `NoFourFive` 0.

**What I may change**: children anywhere (in `Basic`, `Merge` and `Steps` children only), supporting lemmas in the foundation modules (statements of other
waves unchanged), imports, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `tools/fs131_iw_*.py`, `data/fs131/iw/`, `data/fs131/iwc/`, this record,
my report; and, by ruling 167 (b), `NiceAt.normal`'s visibility. **What I may not**: any statement or definition of `Woodall/Basic` or `Woodall/Merge`, any
chain theorem of `Woodall/Steps`, any new `axiom`, any `native_decide`; nothing with a `sorry` reaches `main`; the gate and the landing wait for wave 4.

**Ruling 167 (b) applied**: `NiceAt.normal` is now `private theorem`, its docstring saying why (a public statement over valid five-coloured plane maps must
conclude `False`; the vacuity scan does not track `ArcMap` binders, so a `VACUITY DECLARED` marker there would go unchecked). Its record is removed from
`scripts/Axioms.lean` (a private name cannot be printed from another module; `aeMap6_merged`, its one reader, keeps its record) and its `ARCHITECTURE.md`
mention re-worded. `tools/fs131_w3_decls.py --check`: 154 theorems, 154 records, 0 missing, 0 stale (its pattern reads `theorem` at line start, so a private
theorem is not a theorem it counts). `Steps` elaborates (iteration, `data/fs131/iwc/run.sh`, never evidence).

## Stage 8 — SAVED (FS131-IWc): `Merge`'s easy leaves and the composition `exists_woodallMerged`

**Proved (statements unchanged)**, in § 15.3's order: `wedgeArcs_nondegenerate`, `recolour_valid`, `recolour_region_diff`, `coloursAt_congr`, `niceAt_congr`,
`wedgeMerge_condition5`, `wedgeMerge_region_diff`, `frontier_annSector_subset`, `wedgeMerge_valid` (over `clear_wedge`, still a leaf), and
**`exists_woodallMerged`** (E3-BALL) over its stated children — the first composition check passed: the children fit as § 15.1 says (strong induction on the
size of a finite set holding the bad points, generalized over the map; `exists_merge_at` at one bad point with `ε = 1`; off the merged ball the regions
agree on the open complement, so `coloursAt_congr` and `niceAt_congr` make a bad point of the new map a bad point of the old one, other than the merged
point; the start from `finite_three_le_coloursAt` on `closedBall 0 R`).

**Children added** (`Merge`, before `wedgeArcs`): `norm_real_mul_e`, `annSector_subset_ball`, `annSector_mono_r₂`, `mem_segment_ray`,
`closure_annSector_subset`; records in `scripts/Axioms.lean`'s merge section; `tools/fs131_w3_decls.py --check`: 159 theorems, 159 records, 0 missing,
0 stale. No name among them is declared in any other worktree's `Proofs/` or on `main` (`rg`).

**Re-pricing from the first two leaves.** The plan priced the easy leaves E and the module at 1,100–1,800 lines for an Opus implementer; the nine easy
leaves and the composition took about 230 lines and one elaboration round each (every one closed on its first or second try), so the easy band is priced
right. The hard band is priced from its own first leaves below.

**Left in `Merge` (8)**: `clear_wedge`, `exists_dirColourAt`, `GoodAt.ncard_coloursAt_le_two`, `finite_three_le_coloursAt`, `niceAt_of_dirColourAt`,
`dirColourAt_wedgeMerge`, `wedgeMerge_niceAt`, `exists_merge_at`; in `Basic` T1–T5.

## Stage 9 — SAVED (FS131-IWc): E3-W (`clear_wedge`), three-colour points finite, the local data

**Build of stage 8's tree**: OK — 445 of 445 batches, 3 modules rebuilt, 7 with warnings, 8 m 39 s, exit 0 (`build/gate/build/20261004T154158Z-412013.log`;
driver log `data/fs131/iwc/build1.log`); the Woodall warnings are all `declaration uses 'sorry'` (59 lines across the build's replays).

**Proved (statements unchanged)**:
* **`GoodAt.ncard_coloursAt_le_two`** — off the arcs one colour; on an arc, `GoodAt.exists_local_curve` puts every arc point near `z` on one full curve
  `curveAt x κ b`, and two preconnected sides of it near `z` carry at most one colour each: for a line, two open half-discs (convex); for a circle about
  `c = x + b`, two thin annular sectors about `c` (`isPreconnected_annSector`), inside and outside the circle, inside a ball where the curve is the only
  arc locus. An open set always has a point off the curve (wave 3's `exists_notMem_curveAt`), which carries the colour of one side.
* **`finite_three_le_coloursAt`** — a finite subcover of good balls (`IsCompact.elim_nhds_subcover`); a point of three colours in a good ball is its centre.
* **`exists_dirColourAt`** — `D` = the arguments of the finitely many unit vectors tangent at `v` to an arc of a good ball (`finite_perp_circle`); off
  `D` no such arc is tangent to `e φ`, so wave 3's wedge `Rgn v (e φ) N m` lies in the interior points, is preconnected, so in one tile; a truncated
  cone `annSector v 0 r (φ − r) (φ + r)`, `r = min (1/2) (1/(2N)) (m/2)`, lies in the wedge; `σ` by `choose!`.
* **`clear_wedge` (E3-W)**, by E3's sagitta argument made exact: if `dist z y = 1` with `y ∈ S`, the unit circle `p t = y + e t` through `z` leaves the
  disc `B(v, r₁)` first at `b = inf {t ≥ t_z | ‖p t − v‖ ≥ r₁}` and last at `a = sup {t ≤ t_z | …}`; on `(a, b)` it avoids `v` and the two edges (all in
  `closure S`, `dist_ne_one_of_mem_of_mem_closure`), so by preconnectedness it stays in the open wedge (`mem_annSector_union_of_ne`,
  `disjoint_annSector_wedges`), and its ends lie on `‖· − v‖ = r₁` in the closed wedge; `b − a ≤ π` (else two antipodal points in a disc of diameter `< 1`);
  the chord gives `sin h ≤ r₁` (`h = (b − a)/2`, through `one_sub_e_two_mul`); projecting on the bisector `e((d₁+d₂)/2)`, the sinusoid
  `K + cos(t − β)` lies above the convex combination of its end values (each `≥ r₁ cos(α/2)`) up to `1 − cos h ≤ sin² h ≤ r₁²`, so
  `‖z − v‖ ≥ r₁ cos(α/2) − r₁² > r₁ cos(α/2)/2`, against `z` in the small wedge. No sagitta constant is approximated; E3's float control
  (`tools/fs131_e3_sagitta.py`) is now superseded by the kernel proof of the same bound.

**Children added**: `ArcMap.ncard_coloursAt_le_two_of_sides` (two preconnected sides bound the colours at a point by two), `ArcMap.mem_curveAt_one_iff`,
`mem_annSector_union_of_ne`, `disjoint_annSector_wedges` (the wedge helpers moved with the stage-8 block before `clear_wedge`, which now cites them; no
statement moved past a reader). Records added; `tools/fs131_w3_decls.py --check`: 163 theorems, 163 records, 0 missing, 0 stale.

**Re-pricing from the first two hard leaves** (`GoodAt.ncard_coloursAt_le_two`, `clear_wedge`): about 120 and 210 lines, two and five elaboration
rounds; the plan's M and M+ (150–250) hold. At this rate the four leaves left in `Merge` (`niceAt_of_dirColourAt` H−, `dirColourAt_wedgeMerge` M−,
`wedgeMerge_niceAt` H−, `exists_merge_at` H) are 900–1,300 lines, more than this job's remaining budget; T1–T5 about 300.

**Left in `Merge` (4)**: `niceAt_of_dirColourAt`, `dirColourAt_wedgeMerge`, `wedgeMerge_niceAt`, `exists_merge_at`; in `Basic` T1–T5.

## Stage 10 — SAVED (FS131-IWc): the local data after a merge; `Basic`'s five inhabitant leaves (T1–T5)

**Build of stage 9's tree**: OK — 445 of 445 batches, 3 modules rebuilt, 7 with warnings, 8 m 47 s, exit 0 (`build/gate/build/20261004T155530Z-491688.log`;
driver log `data/fs131/iwc/build2.log`).

**Proved (statements unchanged)**:
* **`dirColourAt_wedgeMerge`** — off `D` and the two edge directions, a direction inside the wedge (mod `2π`) has a thin cone inside the open wedge and
  inside `F`'s thin cone, so of interior points of the merged map (the wedge meets none of its own arcs, `annSector_notMem_wedgeArcs`) coloured `c`; a
  direction outside the closed wedge has a thin cone off the polar image of `[0, ρ] × [d₁, d₂]` (`polar_notMem`), which holds the wedge's closure and
  arcs (`closure_annSector_subset`, `wedgeArcs_subset_polar`), so the regions there are `F`'s (`recolour_region_diff`).
* **T1 `threeCol_locallyConstant`** — off the cuts in the disc, `x ≠ 0` and its angle `π + arg(−x) ∈ (0, 2π]` avoids `2π/3`, `4π/3`, `2π`
  (`mem_threeCuts_iff`); so `−x` is in the slit plane and the angle is continuous at `x`; the strict inequality that fixes `threeCol x` holds nearby.
* **T2 `threeSectorDisc_sectorsAt`**, **T3 `threeSectorDisc_phantom`** — the region of colour `j` is the open sector `(2πj/3, 2π(j+1)/3)` of radius `1/3`
  (`threeSectorDisc_region`), and the cone of an open sector at its apex is its closed angular interval (`coneAt_annSector_eq`, the plan's reusable
  child); the phantom's horns at `2π/3` sit inside both neighbours' intervals (`angleIcc_subset_angleIcc`).
* **T4 `threeSectorDisc_ncard_coloursAt_le_two`** — a point `w ≠ 0` in the closures of all three sectors would have one direction in `[0, 2π/3]`,
  `[2π/3, 4π/3]` and `[4π/3, 2π]` at once (`closure_annSector_subset`, `polar_inj`, `e_ne_e_of_lt`).
* **T5 `halfDisc_sectorsAt`** — the regions of `halfDisc` are the open sectors `(0, π)` and `(π, 2π)` (`Complex.arg_neg_iff`, `arg_nonneg_iff`,
  `arg_lt_pi_iff`, `arg_eq_zero_iff`, `arg_eq_pi_iff`), then `coneAt_annSector_eq`.

So `threeSectorDisc_niceAt`, `_woodallMerged`, `_woodallNormal`, the two phantom adversaries and `halfDisc_niceAt` are now on their proved leaves:
**`Plane/Woodall/Basic` is `sorry`-free.**

**Children added.** In `Basic` (new section "Polar coordinates, and the cone of an open sector at its apex"): `eq_of_e_eq_of_mem_Ioc`,
`coneAt_annSector_eq`, `eq_norm_mul_e_pi_add_arg`, `pi_add_arg_neg_mem`, `pi_add_arg_neg_eq`, `mem_annSector_zero_iff`, `mem_segment_half_iff`,
`ArcMap.mem_threeCuts_iff`, `ArcMap.threeCol_eq_iff`, `ArcMap.threeSectorDisc_region` (with `_zero`, `_one`, `_two`), `ArcMap.angleIcc_subset_angleIcc`.
**Moved upstream into `Basic`, unchanged** (the inhabitants need them, and `Basic` is upstream of both): `norm_real_mul_e`, `closure_annSector_subset`,
`polar_inj`, `e_ne_e_of_lt` (from `Merge`) and `mem_coneAt_annSector` (from `NoFourFive`, a `--` line left at its old place). In `Merge`:
`polar_inj` and `e_ne_e_of_lt` (then moved), `wedgeArcs_subset_polar`, `polar_notMem`, `annSector_notMem_wedgeArcs`. Records: a new section "FS-131
Woodall's chain (job FS131-IWc)" for `Basic`'s children, three lines in the merge section; `tools/fs131_w3_decls.py --check`: 182 theorems, 182 records,
0 missing, 0 stale. No new name is declared in any other worktree's `Proofs/` or on `main` (`rg`, 20 names).

**Left in `Merge` (3)**: `niceAt_of_dirColourAt`, `wedgeMerge_niceAt`, `exists_merge_at`.

**Build of this stage**: OK — 445 of 445 batches, 6 modules rebuilt, 6 with warnings (wave 4's five skeleton modules and `Woodall/Merge`), 9 m 8 s,
exit 0 (`build/gate/build/20261004T160612Z-574527.log`; driver log `data/fs131/iwc/build3.log`); the only Woodall warnings are `Merge`'s three
`declaration uses 'sorry'` (each printed three times by the replays); `Basic` builds with no warning.

## Stage 11 — SAVED (FS131-IWc): cones after a merge (`exists_merge_at`'s measure, proved children); the three leaves left, with routes

**Proved (children of `exists_merge_at`, in `Merge` after `dirColourAt_wedgeMerge`)**: `mem_coneAt_inter_annSector` (cones are local in direction:
a set approaching `v` along `δ` does so inside every thin truncated cone about `δ`, by continuity of `arg` at `1`), `mem_angleIcc_iff_e`,
`isClosed_angleIcc`, and the three cone facts after a merge: **`coneAt_wedgeMerge_of_notMem`** (off the closed wedge the cones at `v` are `F`'s),
**`eq_of_mem_coneAt_wedgeMerge`** (inside the open wedge only `c` approaches `v`), **`eq_of_mem_coneAt_wedgeMerge_of_subset`** (along a direction
whose thin cone lies in `F`'s class of `c`, only `c` does). All on the standard three axioms (iteration print). Records added;
`tools/fs131_w3_decls.py --check`: 188 theorems, 188 records, 0 missing, 0 stale; `--plant`: FIRED both ways, exit 0. `tools/check_architecture.py`:
PASS (`Basic` and `Merge` rows rewritten).

### The three leaves left, each read against its statement (no statement defect found), with a route

**`exists_merge_at` — a simpler measure than § 14.4's "runs plus pokes".** § 14.4's measure needs the colour word of `(D, σ)` sorted into runs, the
same machinery as `niceAt_of_dirColourAt`. This one needs none: for local data `(D, σ)` of `F` at `v`,
`μ(F, D) = ∑ δ ∈ D, ((Finset.univ.filter fun j => δ ∈ coneAt (F.region j) v).card − 1)`
(duplicates in `D` mod `2π` are harmless). One step, of either of § 14.4's two kinds:
* *the step's parameters* (a lemma to state and prove): if `hrun ∧ hpoke` fails for `(D, σ)`, there are `d₁ < d₂ < d₁ + π`, both `OffDirs D`,
  `σ d₁ = σ d₂ = c`, and some `δ ∈ D` with `δ ∈ angleIoo d₁ d₂` whose cone-colour set has two members. From `¬ hrun` (`φ₁ < φ₂ < φ₁ + 2π`, one
  colour `c`, a direction `ψ ≠ c` on each side): one of `(φ₁, φ₂)`, `(φ₂, φ₁ + 2π)` has length `≤ π`; shrink its right end by a little inside
  `c`'s thin cone (and off `D`) to make it `< π` with `ψ` still inside; take `d₁, d₂` its ends. From `¬ hpoke` at `δ`: `d₁, d₂ = δ ∓ t` off `D`.
  The two-colour `δ`: the closed sets `C_c = coneAt (F.region c) v ∩ [d₁, ψ]` and `⋃_{j ≠ c} coneAt (F.region j) v ∩ [d₁, ψ]` cover `[d₁, ψ]`
  (`exists_mem_coneAt_region`); `[d₁, ψ]` is preconnected, `d₁` is in the first only and `ψ` in the second, so they meet at some `δ'`; off `D`
  a direction is in one cone only (the thin cone and disjoint regions), so `δ' ≡ δ ∈ D`, and `δ' ≠ d₁`, `δ' ≤ ψ < d₂`. For `¬ hpoke` the
  two colours are `j` and `c` (closedness of `c`'s cone).
* *the decrease*: with `F' = F.wedgeMerge v hρ hd hd2 c` and `D' = insert d₁ (insert d₂ D)`, every `δ ∈ D` is `≢ d₁, d₂`; if
  `δ ∈ angleIoo d₁ d₂` its count is now `0` (**`eq_of_mem_coneAt_wedgeMerge`**, proved), otherwise unchanged
  (**`coneAt_wedgeMerge_of_notMem`**, proved); `d₁` and `d₂` count `0` (**`eq_of_mem_coneAt_wedgeMerge_of_subset`**, proved, from `F`'s thin
  cones there); `Finset.sum_lt_sum` at the two-colour `δ`.
* *the state* of the strong induction on `μ`, generalized over the map: `G` valid, plane, `F.Condition5 → G.Condition5`, regions equal to `F`'s off
  `closedBall v ρ₁`, every `w ∈ closedBall v ρ₁ \ {v}` of three or more colours `NiceAt` in `G`, and local data `(D, σ)` of `G` at `v`. No
  decreasing radii are needed in the state (§ 14.4 carries them): each merge takes `ρ' < min (good radius of G at v) ρ₁`, below E3-W's bound
  `r₁ cos(α/2)/2` and below `r₁`, with `r₁ < cos(α/2)/2` under both thin-cone radii at `d₁, d₂`; `wedgeMerge_valid`, `wedgeMerge_condition5`,
  `wedgeMerge_region_diff`, `wedgeMerge_niceAt` (`hc` from the thin cones), `coloursAt_congr`/`niceAt_congr` off `closedBall v ρ'`, and
  `dirColourAt_wedgeMerge` keep it. *Start*: `ρ₁ < min ε (good radius of F)`, the ring clause by `GoodAt.ncard_coloursAt_le_two`, data by
  `exists_dirColourAt`. *End* (`hrun ∧ hpoke`): `niceAt_of_dirColourAt` at `v`.
  Price: M+ (150–250 lines) on top of its three proved cone children and `niceAt_of_dirColourAt`.

**`niceAt_of_dirColourAt` (H−).** True as stated (checked: with `h3`, a colour at `v` has a nonempty cone; off `D` it is a run colour, on `D` it is
a run colour or, by `hpoke`, a horn at a change point; runs have distinct colours by `hrun`; `σ` is `2π`-periodic off `D` because the thin cones of
`φ` and `φ + 2π` are one set). The work is the picture's indexing: sort the change points `q₀ < … < q_{m−1}` in a window `[θ₀, θ₀ + 2π)` with `θ₀`
off `D` (`m ≥ 2` by `h3` and `hpoke`); the arc `(q_l, q_{l+1})` has colour `a_l` (constant: `σ` is locally constant off `D`, and equal across a
non-change point); horns at `q_l`: the colours `j ∉ {a_{l−1}, a_l}` with `q_l ∈ coneAt (F.region j) v`. Suggested representation: a
`List (ℝ × Fin k)` of (start angle, colour), `[(q_l, h) for h in H_l] ++ [(q_l, a_l)]` concatenated over `l`, then `n = length`, `d i = start`,
`d n = q₀ + 2π`, `c i = colour`, with one generic lemma "a sorted list with cyclically distinct neighbours and the cone clause in list form gives
`SectorsAt`". The cone clause: `⊇` from `hD` on open arcs and `isClosed_coneAt`; `⊆` off `D` by disjointness of regions near a thin cone, on `D`
by `hpoke` and the horn lists. `coneAt_annSector_eq` (proved, `Basic`) is not needed here; `isClosed_angleIcc` and `mem_angleIcc_iff_e` (proved)
are.

**`wedgeMerge_niceAt` (H−).** True as stated (checked case by case): inside the open wedge one colour; on an edge or at an edge's outer end, `F`'s
colour there is `c` (`hc`, `ρ < r₁`), so one colour; off the closed wedge and its arcs `F` is unchanged near `w` and `GoodAt.ncard_coloursAt_le_two`
gives at most two; on the outer arc at a direction strictly inside, either `w` is off `F`'s arcs (two colours) or on exactly one full curve
`C` through `v` (`GoodAt.exists_local_curve`), which crosses the circle `‖· − v‖ = ρ` transversally (a segment through `v` is radial; a circle
through `v` of radius `R` has `2R > ρ₀ > ρ` by `GoodAt.big`, and it is tangent to the circle of radius `ρ` about `v` only if `ρ = 2R`). Then the colours
are `c` on the inner side and `F`'s two side colours `g, g′` outside, and at three colours the picture has three sectors (`c` on the inner half,
angle `π`; `g`, `g′` between the tangent of `C` and the circle's tangents), no horn. The work is the three cone identities at `w` for curvilinear
sectors (bounded by a circle and a line or circle crossing transversally): each cone is the closed interval between the two tangent directions.
`ArcMap.ncard_coloursAt_le_two_of_sides` (proved) is the counting half; the cones need a curvilinear analogue of `coneAt_annSector_eq`.

**Build of stage 11's tree**: OK — 445 of 445 batches, 3 modules rebuilt, 6 with warnings (wave 4's five skeleton modules and `Woodall/Merge`), 8 m 37 s,
exit 0 (`build/gate/build/20261004T161928Z-665717.log`; driver log `data/fs131/iwc/build4.log`); the only Woodall warnings are `Merge`'s three
`declaration uses 'sorry'`. Two records (`norm_real_mul_e`, `closure_annSector_subset`) moved to the IWc chain section with their declarations, so the
frozen `tools/fs131_w2_decls.py --check` (four modules) passes too: 151 theorems, 151 records; `tools/fs131_w3_decls.py --check`: 188, 188, 0, 0.

## Stage 12 — SAVED (FS131-IWc): where I stop

`sorry` leaves by module: `Basic` 0, `Collar` 0, `NoFourFive` 0, `Steps` 0, **`Merge` 3** — `niceAt_of_dirColourAt`, `wedgeMerge_niceAt`,
`exists_merge_at` (routes in stage 11). Of the brief's 23 leaves, 20 are proved (15 of `Merge`'s 18, all five of `Basic`'s), each on the standard three
axioms by the iteration print; `exists_woodallMerged` cites `exists_merge_at` and so carries `sorryAx` until it lands. Not done, and why: the three
leaves are H−, H−, H (900–1,300 lines with their children at this job's rate), past this job's budget; Keryx's amendment (a plane-map model of the
normal forms, `sevenBrickMap.WoodallNormal univ` or an `ArcMap 7` in normal form on `closedBall 0 3`) waits for wave 4's `sevenBrickMap` on this
branch; the gate and the landing wait for wave 4.

## Drafts for the front page

None: no milestone state moved (the gate has not run; `Merge` keeps three `sorry` leaves). Slot, when the chain's gate runs: `CLAUDE.md` § The gate
and § Trust ledger get the counts, and the FS106-WO, FS106-TW, FS106-AE-MAP6 and E1-NO45 ledger rows are regraded then.

## Stage 13 — SAVED (FS131-IWd): the readback

*Brief `data/fs131/briefs/FS131-IWd-woodall-merge.md` (on `main`); the fourth implementer on this chain, de Bruijn on Opus 5.5; branch `fs131-ww` at
`ca6ec757`.*

**The brief's two quotations** match their sources verbatim: "180. **FS131-IWc handed back at stage 12, harness ≈ 494k** (report on its branch; `fs131-ww`
at `ca6ec757`, checked): **20 of its 23 leaves proved**, statements unchanged," is `plans/FS131-close-inventory.md` (main) line 1257 (`grep -nF`, one hit; the
item read whole, and item 181); "**Proved (children of `exists_merge_at`, in `Merge` after `dirColourAt_wedgeMerge`)**: `mem_coneAt_inter_annSector` (cones
are local in direction:" is this record's Stage 11 opening (`grep -cF` → 1; the stage read whole, with plan §§ 14–15). No mismatch.

**The build as given** (`ca6ec757`, before any edit): OK — all 1748 modules already up to date, nothing built, 6 modules with warnings (wave 4's five
skeleton modules and `Woodall/Merge`), 2 s, exit 0 (`build/gate/build/20261004T163241Z-772535.log`; driver log `data/fs131/iwd/build0.log`). The `Merge`
warnings are its three `declaration uses 'sorry'` at lines 873, 1074, 1089 (`niceAt_of_dirColourAt`, `wedgeMerge_niceAt`, `exists_merge_at`).

**What I may change**: children anywhere in the five Woodall modules (in `Basic` and `Merge` children only, no definition or statement), supporting lemmas
in the foundation modules (statements of other waves unchanged), imports, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `tools/fs131_iw_*.py`,
`data/fs131/iw/`, `data/fs131/iwd/`, this record, my report. After wave 4 lands: the merge of `main`, deleting this branch's identical copies of
`abs_dot_le`, `dot_add_left`, `dot_e_e`, `isOpen_shadow` for wave 4's; QA2-1's plane-map model. **What I may not**: any statement or definition of
`Woodall/Basic` or `Woodall/Merge`, any chain theorem of `Woodall/Steps`, any new `axiom`, any `native_decide`; nothing with a `sorry` reaches `main`; no
landing before wave 4 is on `main` (at this stage it is not: `origin/main` at `b8b478a6`, `fs131-w4` at `89ab1ab7`).

Iteration script: `data/fs131/iwd/run.sh` (`lake env lean` with the lakefile's options against the built oleans, read only; never evidence).

## Stage 14 — SAVED (FS131-IWd): `niceAt_of_dirColourAt` proved

**Proved (statement unchanged)**: `niceAt_of_dirColourAt`, by stage 11's route made concrete. The picture's sectors are the elements of a finite
set of pairs (direction, rank) sorted lexicographically (`Finset.orderEmbOfFin` on `Lex (ℝ × ℕ)`): for each change point `q` of the colour in a window
`[θ₀, θ₀ + 2π)` starting off `D`, one pair `(q, j)` per horn colour `j` (rank `j < k`: a colour whose cone holds `q`, other than the colours just
before and just after `q`) and one pair `(q, k)` for the run starting at `q`. Adjacent sectors differ, two runs never share a colour (`hrun`, through
the change point inside each of the two arcs between them), a horn sits between distinct colours, and the cone clause holds (a direction lies in a
run, half-open on the right; at a non-change direction only the run's colour approaches, by `hpoke`). With no change point the picture is one
sector. `h3` is not used (the statement carries it; the constant case is a one-sector picture).

**Children added** (`Merge`; the side colours are read off `σ`, no `localSectors`): at the top, after `OffDirs` — `offDirs_add_int`,
`exists_offDirs_punctured` (the directions of `D` are isolated mod `2π`), `exists_offDirs_Ioo`, `mem_closure_offDirs_Ioo`, `finRotate_val`, the
definitions `isoRad`, `rightCol`, `leftCol` (the colours just counter-clockwise and just clockwise of a direction) with `isoRad_pos`,
`offDirs_of_isoRad`; before the leaf, in a section `DirColour` — `DirColourAt.mem_coneAt`, `eq_of_mem_coneAt`, `eq_of_near`, `eq_add_int`,
`eq_of_Ioo`, `eq_rightCol`, `eq_leftCol`, `rightCol_eq_of`, `leftCol_eq_of`, `rightCol_of_offDirs`, `rightCol_add_int`, `leftCol_add_int`,
`rightCol_mem_coneAt`, `leftCol_mem_coneAt`, `not_offDirs_of_ne`, `const_of_noChange` (between two directions with no change of colour strictly
between, the colour is constant), `noChange_of_const`. **Moved, unchanged**: `mem_coneAt_inter_annSector` (from IWc's "Cones after a merge" block to
just before these, which read it). Records: a section "FS-131 Woodall's merge (job FS131-IWd)" in `scripts/Axioms.lean`, written by
`tools/fs131_iw_add_records.py` (not a check: it appends what `tools/fs131_w3_decls.py` reports missing); `tools/fs131_w3_decls.py --check`: 212
theorems, 212 records, 0 missing, 0 stale; `--plant`: FIRED both ways, exit 0. No new name is declared on `origin/main`, `fs131-w2`, `fs131-w4` or
`fs131-w3b` (`git grep`).

**Build of this stage**: OK — 445 of 445 batches, 3 modules rebuilt, 6 with warnings (wave 4's five skeleton modules and `Woodall/Merge`), 8 m 46 s,
exit 0 (`build/gate/build/20261004T170025Z-886887.log`; driver log `data/fs131/iwd/build1.log`); the only Woodall warnings are `Merge`'s two
`declaration uses 'sorry'` (`wedgeMerge_niceAt`, `exists_merge_at`). Scratch: `data/fs131/iwd/scratch/A.lean` (the leaf as developed, iteration only).

## Stage 15 — SAVED (FS131-IWd): `wedgeMerge_niceAt` proved

**Proved (statement unchanged)**: `wedgeMerge_niceAt`. With `w = v + s e θ`, `θ ∈ [d₁, d₁ + 2π)`: on an edge (`θ = d₁` or `d₂`; `s ≤ ρ < r₁`)
`w` is in `F`'s class of `c` (`hc`), an open set on which the merged map has the one colour `c`; strictly inside the open wedge one colour; off the
closed wedge (`θ ∈ (d₂, d₁ + 2π)`) the merged map is `F` near `w` (off the compact polar image of `[0, ρ] × [d₁, d₂]`) and `F` has at most two
colours there (`GoodAt.ncard_coloursAt_le_two`); on the outer arc at a point off `F`'s arcs, `c` and `F`'s colour at `w`. Each of these has at most
two colours, against `h3`. What is left is the crossing: `w = v + ρ e θ`, `θ ∈ (d₁, d₂)`, on an arc of `F` (`wedgeMerge_crossing`).

**The crossing, region-only (`niceAt_of_crossing`)**: near `w`, the open inner side of the circle `‖z − v‖ = ρ`, written at `w` as
`2 dot (z − w) (ρ e θ) + ‖z − w‖² < 0`, carries `c`; the outer side is split by the one curve of `F` through `w` (`κ ‖z − v‖² − 2 dot (z − v) b`,
written at `w` as `2 dot (z − w) n_C + κ ‖z − w‖²` with `n_C = κ (w − v) − b`) into `x` and `y`, the colours of its two sides
(`GoodAt.exists_sides`, IWc's construction in `GoodAt.ncard_coloursAt_le_two` kept as a lemma). The colours at `w` are among `c, x, y` (any open
set near `w` has a point off both curves, `exists_notMem_curveAt`), so with three colours they are distinct. The local data: `D` the four tangent
directions `θ ± π/2`, `arg n_C ± π/2`; `σ` = `c` where `cos (φ − θ) < 0`, else `x` or `y` by the sign of `cos (φ − arg n_C)`; a thin cone keeps
the signs of both first-order terms (`exists_sign_near`). The run condition: each colour class is an open half-circle or the intersection of two,
and of two directions in an open half-circle the shorter arc between them lies in it (`cos_pos_arc`), the same arc for both half-circles. The poke
condition: at a tangent direction outside the circle or on it, the colours just before and just after differ (so the hypothesis is never met);
inside, only `c` approaches (`coneAt_subset_halfPlane`: a set kept off the open side of a circle approaches only from the closed other side).
`niceAt_of_dirColourAt` finishes. **No transversality hypothesis is needed** (the plan expected one): if the curve were tangent to the circle, a
third colour would only be a horn; the stage-11 note that `GoodAt.big` makes the crossing transversal is true but unused.

**Children added** (`Merge`): Plane-level, after `leftCol` — `dot_real_mul_right`, `eq_of_cos_sub_eq_zero`, `exists_mem_Ioo_of_cos_pos`,
`cos_pos_arc`, `exists_sign_near`, `coneAt_subset_halfPlane`, `norm_add_sq_dot`; in a section "The crossings a merge creates" before the leaf —
`niceAt_of_crossing`, `GoodAt.exists_sides`, `wedgeMerge_crossing`. Records added (`tools/fs131_iw_add_records.py`);
`tools/fs131_w3_decls.py --check`: 222 theorems, 222 records, 0 missing, 0 stale. `exists_sides` is also a name on `main` (`Plane/RingBand`, a
different namespace); the full names differ.

**Build of this stage**: OK — 445 of 445 batches, 3 modules rebuilt, 6 with warnings (wave 4's five skeleton modules and `Woodall/Merge`), 8 m 45 s,
exit 0 (`build/gate/build/20261004T171824Z-982130.log`; driver log `data/fs131/iwd/build2.log`); the only Woodall warning is `Merge`'s one
`declaration uses 'sorry'` (`exists_merge_at`). Scratch: `data/fs131/iwd/scratch/B2.lean` (iteration only).

## Stage 16 — SAVED (FS131-IWd): `exists_merge_at` proved; `Plane/Woodall/Merge` sorry-free

**Proved (statement unchanged)**: `exists_merge_at` (E3-NICE), by stage 11's simpler measure `μ(G, D) = ∑_{δ ∈ D} (#{j | δ ∈ coneAt (G.region j) v} − 1)`.
Strong induction on `μ`, generalized over the map: `G` valid, plane, Condition 5 kept, regions equal to `F`'s off `closedBall v ρ₁`, every point of
`closedBall v ρ₁ \ {v}` of three or more colours `NiceAt` in `G`, local data `(D, σ)` of `G` at `v`; `ρ₁ = min (ε/2) (ρ₀/2)` with `ρ₀` a good radius
of `F` at `v`, so the start is vacuous (`GoodAt.ncard_coloursAt_le_two`). If the run and poke conditions hold, `niceAt_of_dirColourAt` at `v` ends it.
Else **`DirColourAt.exists_merge_dirs`** gives `d₁ < d₂ < d₁ + π` off `D` of one colour `c` with a direction `δ₀ ∈ D` strictly between at which a second
colour approaches (from a failed run: the shorter of the two arcs, an endpoint pulled inside `c`'s thin cone; the two closed sets "cone of `c`" and
"cones of the others" cover `[d₁, ψ₀]`, so meet, at a direction of `D`; from a failed poke: `δ ∓ t`). One merge `G.wedgeMerge v ρ' d₁ d₂ c` with
`ρ' ≤ r₁ cos(α/2)/2`, `ρ' < ` a good radius of `G` at `v`, `ρ' < ρ₁/2`, `r₁` under both thin cones and `cos(α/2)/4`: valid (`wedgeMerge_valid`),
Condition 5 (`ρ' < 1`), regions unchanged off `closedBall v ρ'`, the new points of three colours `NiceAt` (`wedgeMerge_niceAt`; outside
`closedBall v ρ'` by `coloursAt_congr`/`niceAt_congr`), local data `(insert d₁ (insert d₂ D), σ')` (`dirColourAt_wedgeMerge`). The measure drops:
`d₁`, `d₂` count `0` (`eq_of_mem_coneAt_wedgeMerge_of_subset`), every `δ ∈ D` inside the wedge counts `0` (`eq_of_mem_coneAt_wedgeMerge`), every
other keeps its count (`coneAt_wedgeMerge_of_notMem`; a direction of `D` is never `d₁` or `d₂` mod `2π`), and `δ₀` drops from at least `1`.

So **`exists_woodallMerged` (E3-BALL) rests on proved children only**, and **every Woodall module (`Basic`, `Collar`, `NoFourFive`, `Merge`,
`Steps`) is `sorry`-free**; the chain's remaining `sorryAx` is wave 4's skeleton (`Plane/SVMap`), until wave 4 lands.

**Children added**: `DirColourAt.exists_merge_dirs` (before `exists_merge_at`); its record. `tools/fs131_w3_decls.py --check`: 223 theorems, 223 records,
0 missing, 0 stale; `--plant` FIRED both ways; the frozen `tools/fs131_w2_decls.py --check`: 151, 151, 0, 0. `ARCHITECTURE.md`: the `Merge` row
rewritten (proved, sorry-free; the IWd children named); `tools/check_architecture.py`: PASS.

**Build of this stage**: OK — 445 of 445 batches, 3 modules rebuilt, **5 with warnings** (wave 4's five skeleton modules; **no Woodall module warns**),
8 m 45 s, exit 0 (`build/gate/build/20261004T172813Z-1058816.log`; driver log `data/fs131/iwd/build3.log`; `grep Woodall … | grep -ic warning` → 0).
Axioms: `data/fs131/iwd/axioms-iteration.txt` (iteration, never evidence; see the table above). Scratch: `data/fs131/iwd/scratch/C.lean`.

**Re-pricing, for the record.** IWc priced the three leaves at 900–1,300 lines with children; `Merge` grew by 1,576 lines (1,139 → 2,715,
docstrings included), each leaf elaborating after two to six rounds: the price held, a little high on the leaves and low on their children.

## Stage 17 — SAVED (FS131-IWd): where I stop

Item 2 of the brief is done. Item 3 waits: **wave 4 has not landed on `main`** (`origin/main` at `b3c6f5db`; `Plane/SVMap` there has no `sevenBrickMap`;
FS131-I4f is running). So, per the brief, I stop after item 2: no merge of `main`, no `tools/fs131_qa1_dupes.py` run, no QA2-1 plane-map model, no gate,
no landing. What the next job on this branch does once wave 4 lands: merge `main` (delete this branch's identical copies of `abs_dot_le`, `dot_add_left`,
`dot_e_e`, `isOpen_shadow` for wave 4's; run `tools/fs131_qa1_dupes.py`), then QA2-1 (`sevenBrickMap.WoodallNormal univ` / `WoodallMerged univ`, or an
`ArcMap 7` in normal form on `closedBall 0 3` with a three-colour point — the brick corner, `sevenBrick_corner_isCubicTrichromatic`), then the gate and the
landing. Note for QA2-1: `exists_woodallMerged` is now proved for any number of colours, so `sevenBrickMap`'s merged map exists by theorem; the model the
amendment asks for is still an explicit inhabitant with every clause exercised.

## Drafts for the front page

None: no milestone state moved (the gate has not run; wave 4's skeleton still carries `sorry` on this branch). Slot, when the chain's gate runs:
`CLAUDE.md` § The gate and § Trust ledger get the counts, and the FS106-WO, FS106-TW, FS106-AE-MAP6 and E1-NO45 ledger rows are regraded then.

## Stage 18 — SAVED (FS131-WL1): the readback; the build as given

*Brief `data/fs131/briefs/FS131-WL1-woodall-land.md` (on `main`); the landing implementer, de Bruijn on Opus 5.5; branch `fs131-ww` at `792434f0`;
`origin/main` at `a573a140` (wave 4 landed at `60ff1843`; since then `563e8e98`, `03c4d0b7`, `a573a140`: the filing, this brief, a handoff).*

**The brief's quotations** (standing rule 3), each checked with `grep -cF` (one hit each) and its item read whole:
- items 190, 172, 318, 319, 270, 271 of `plans/FS131-close-inventory.md` (main): opening lines verbatim (lines 1324, 1194, 2570, 2594 read whole);
- the QA2-1 paragraph of `data/fs131/briefs/FS131-IWd-woodall-merge.md` (line 62, read through line 65): verbatim;
- the three chain theorems and their docstrings in `Proofs/HadwigerNelson/Plane/Woodall/Steps.lean`: every quoted line is a whole line of the file
  (`grep -cxF`, 15 lines, one hit each). **No mismatch.**

Read: this record's stages 12–17, `plans/FS131-W-kernel-plan.md` § 14 (14.1–14.4), item 318's corrections owed (the first, `framePt → fromFrame` on every
unmerged branch's side, is this job's).

**The build as given** (`792434f0`, before any edit): OK — all 1748 modules up to date, nothing built, 5 modules with warnings, 2 s, exit 0
(`build/gate/build/20261005T032321Z-944708.log`; driver log `data/fs131/wl/build0.log`). The 86 warnings are all `declaration uses 'sorry'`, all in wave
4's five skeleton modules on this branch (`SVMap` 14, `StuckChain` 5, `ValidMap/BaseSteps` 22, `ValidMap/Contact` 16, `ValidMap/UnitArc` 29); none in
`Plane/Woodall/`.

**What I may change**: the merge's files (conflicts resolved both sides kept unless they collide); in the five Woodall modules, the rename
`framePt → fromFrame`, the deletion of identical copies (and renames on this side of any that collide and differ), children and the QA2-1 model (no
definition or statement changes); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`,
`scripts/vacuity-baseline.txt`, this record, `tools/fs131_wl_*.py`, `data/fs131/wl/`, my report; `main` by fast-forward only. **What I may not**: any
statement or definition of the Woodall modules or of wave 4, any new `axiom`, any `native_decide`; `CLAUDE.md`, `LEAN.md`, `tools/claude_md_fact_audit.py`
(drafts only); nothing with a `sorry` reaches `main`; no force-push.

## Stage 19 — SAVED (FS131-WL1): `main` merged (wave 4 landed); `framePt → fromFrame`; the identical copies deleted

**The merge**: `origin/main` at `a573a140` into `fs131-ww` at `22eaa004`. A criss-cross merge: two merge bases, `f01c964d` (main, before
the skeleton) and `f620977c` (FS131-K4c's report, the wave-4 skeleton both sides carry); none of this branch's own commits touches a wave-4
file, so every wave-4 module took `main`'s proved text cleanly. **Two conflicts, both resolved both-sides-kept**: `ARCHITECTURE.md` (the
`Plane/LocalStructure` row: `main`'s, a superset; the wave-4 rows: `main`'s, then this branch's five `Plane/Woodall/` rows) and
`scripts/Axioms.lean` (this branch's wave-4 skeleton sections dropped — `main` holds wave 4's records in its own sections, with G4's
deletions — and this branch's eight Woodall sections kept in place; `main`'s wave-2 and wave-4 sections kept).

**The rename** (item 318's correction (1)): `framePt` occurs in one Woodall file, `Woodall/NoFourFive` (23 lines), renamed to `fromFrame`
with the three names built on it — `norm_sq_framePt_sub → norm_sq_fromFrame_sub`, `framePt_re → fromFrame_re`, `framePt_im → fromFrame_im`
(as wave 4 renamed `frameX_framePt → frameX_fromFrame`), and their three records. No `framePt` is left in `Plane/Woodall/` or in a Woodall
record (`grep`: 0); `Plane/Slack`, the only other `framePt`, is not in `Woodall/Steps`' import closure (25 modules, computed from the
`import` lines), so no Woodall name could have resolved to it.

**The identical copies** (`tools/fs131_qa1_dupes.py`, `data/fs131/wl/qa1-dupes.txt`: four names declared both in `ww`'s and in `w4`'s own
files, as items 181 and 190 listed; `tools/fs131_i4_treedupes.py` on the merged tree: those four plus `main`'s three standing textual repeats,
`conj_e`, `bindings`, `with`, which `--rev origin/main` also reports). Each `ww` copy is the same statement up to binder names:
`abs_dot_le` (verbatim) and `dot_add_left`, `dot_e_e`, `isOpen_shadow` (binders renamed: `(a b c)`/`(d d' u)`, `(a b)`/`(α β)`, `{U}`/`{O}`;
no Woodall caller passes a named argument). **Deleted** from `Woodall/Collar`, with their four records; `Woodall/Collar` now imports
`Plane/ValidMap/Cone` (for `abs_dot_le`; the other three come through `Plane/SVMap`, which it already imported). After the deletions
`fs131_i4_treedupes.py` reports exactly `main`'s three. No copy collided and differed.

**Statements, three-way** (`tools/fs131_i4_mergestmts.py HEAD origin/main`, `data/fs131/wl/mergestmts.txt`): FAIL, 21 — but it takes one
merge base (`f01c964d`) of two, so every wave-4 statement the skeleton changed and wave 4 changed again reads CONFLICT and every skeleton
declaration G4 deleted (`bend_away`, `exists_merge`, `n3_end`'s skeleton form, …) reads MISMATCH. **New tool `tools/fs131_wl_mergestmts.py`**
(imports FS131-I4n's check, never copies it): the virtual base `merge3(05cb0a3e, f01c964d, f620977c)` per name, as git's own merge does,
and `--rename framePt=fromFrame` applied to `ours`. Result (`data/fs131/wl/mergestmts-virtual-renamed.txt`): **6,319 names, 0 base
conflicts, 3 conflicts — `dot_add_left`, `dot_e_e`, `isOpen_shadow`, the three alpha-equivalent copies above** (each side added the name
with its own binder names; the merged tree holds `main`'s). Without the rename (`mergestmts-virtual.txt`): 12, the 9 more being exactly the
rename's six statements and three names. **Control**: `--plant` alters one merged statement `main` changed (`AeColouring.exists_fill`) and
the tool reports it, exit 1 (`data/fs131/wl/mergestmts-plant.txt`). So no statement changed in the merge beyond the rename and the three
binder renamings.

**Records**: `tools/fs131_w3_decls.py --check` 219 theorems, 219 records, 0 missing, 0 stale (223 − the 4 deleted); the frozen
`fs131_w2_decls.py --check` 147/147, `fs131_w_decls.py --check` 96, 0 missing; `fs131_k4_decls.py --check` 495 names, 0 missing.
`ARCHITECTURE.md`: `Woodall/Collar`'s imports cell gains `Plane/ValidMap/Cone`; `tools/check_architecture.py` PASS (`data/fs131/wl/arch.txt`).

**The build of the merged tree**: OK — 451 of 451 batches, 33 modules rebuilt (wave 2's and wave 4's modules from `main` and the five Woodall
modules), **0 modules with warnings**, 13 m 56 s, exit 0 (`build/gate/build/20261005T032705Z-967400.log`, 0 `warning:` lines; driver log
`data/fs131/wl/build1.log`).

**The model, drafted** (stage 20 places it): `data/fs131/wl/scratch/Model.lean` elaborates against the merged oleans, `sevenBrickMap_woodallModel`
on the standard three by the iteration print (`data/fs131/wl/run.sh`; a planted `1 = 2` is reported, so the runner reports errors).

## Stage 20 — SAVED (FS131-WL1): the plane-map model (QA2-1), proved; the adversaries; Woodall's carriers registered

**The model, in `Plane/Woodall/Steps`** (a section after `woodall_thm6`, so in the file of the theorems it models; the module docstring names
it). `sevenBrickMap_woodallModel : sevenBrickMap.Valid ∧ sevenBrickMap.IsPlaneMap ∧ sevenBrickMap.Condition5 ∧ sevenBrickMap.WoodallNormal univ
∧ sevenBrickMap.WoodallMerged univ ∧ (sevenBrickMap.coloursAt 0).ncard = 3` — every hypothesis of `aeMap6`, `aeMap6_of_condition5`,
`aeMap6_normal` and `aeMap6_merged` but `k ≤ 5`, at once, at `k = 7` on a map of the plane (`LEAN.md` § The gate's inhabitant rule), with the
normal form exercised (a point of three colours). `sevenBrickMap_thm6Model`: `woodall_thm6`'s colouring at `k = 7` (the brick colouring itself,
proper at every unit pair by `Brick.avoids`). The route, as the brief's amendment named it, on the whole plane rather than `closedBall 0 3`:
- **The points of three colours are the T-junctions** (`sevenBrickMap_tJunction`). `sevenBrickMap_mem_coloursAt`: a colour at `z` is the colour
  of a closed brick cell through `z` (near `z` the class lies in the closed cells of a finite 3 × 3 block of indices; `Set.Finite.closure_biUnion`).
  `tJunction_of_three`: three distinct closed cells through `z` force two in one row (rows through a point lie within one of each other) and
  the third in another, so `z` is `brickCorner c r` (upward T: cells `(c, r)`, `(c − 1, r)`, `(c, r − 1)`) or `brickCorner c r − 2/5`
  (downward T: `(c − 1, r)`, `(c − 1, r − 1)`, `(c, r − 1)`).
- **The pictures** (`sevenBrickMap_sectorsAt_tUp`, `_tDown`): directions `0, π/2, π, 2π` and `0, π, 3π/2, 2π`, colours `brickCellCol` of the
  three cells (`table i j = i + 3j mod 7`: the three are `x, x − 1, x − 3` and `x − 1, x − 4, x − 3` mod 7, distinct, `tUpCols_injective`,
  `tDownCols_injective` by `omega`). The cone clause comes from a new region-only lemma, `ArcMap.coneAt_region_of_sectors`: if each open sector
  of radius `ρ` lies in its colour's class and every interior point of `B(v, ρ)` lies in a sector, the cones are the closed angular intervals.
  Each sector of radius `1/5` lies inside one open cell (`tUp_sub`, `tDown_sub`, through `sevenBrickMap_mem_region_of_cell`), and an interior
  point near the junction lies in a sector because the three remaining directions are cell edges (`tUp_cov`, `tDown_cov`).
- **Condition 5** (`sevenBrickMap_condition5`): the arcs are segments (`Arc.finite_inter_sphere_or_eq_circ`).
- **Spec examples** (each fails if its definition drifts): `tUpCols 0 0 = ![0, 6, 4]` and `tDownCols 0 0 = ![6, 3, 4]` by `decide`; the
  picture's colours at `0` equal wave 4's independent `sevenBrick_corner_coloursAt` (`{0, 6, 4}`); the corner `0` in the closed cells
  `(0, 0)`, `(−1, 0)`, `(0, −1)` and not in `(1, 0)`; the directions; the centre off the punctured disc's domain.

**The adversaries** (the vacuity scan's evidence, and the lesson QA2 drew — a picture reads the domain): `threeSectorDisc_not_sectorsAt_one`,
`threeSectorDisc_not_niceAt_one` (no picture at `1`, off the disc), and `puncturedThreeSectorDisc` (`threeSectorDisc` with its centre removed
from the domain: the classes are unchanged, the centre still carries three colours, `puncturedThreeSectorDisc_coloursAt_zero`, and no picture
exists there), so `puncturedThreeSectorDisc_not_woodallMerged` and `_not_woodallNormal` on `univ`.

**Woodall's carriers, registered** (`scripts/Vacuity.lean`'s procedure): **IN** `ArcMap.SectorsAt`, `ArcMap.NiceAt`, `ArcMap.WoodallMerged`,
`ArcMap.WoodallNormal`, each refuted at a concrete instance by the adversaries above and inhabited (on the plane, for the normal forms, by
the model); controls 51–62 in `scripts/vacuity-controls.lean`, three each (VACUOUS at the refuted instance, GENERIC at a variable map, UNKNOWN
at a `halfDisc` instance nothing decides), with their `expect` lines in `scripts/vacuity.sh`. **OUT**, with reasons in the docstring: the data
(`annSector`, `collar`, `Rim`, the merge's constructions, the inhabitants, the model's tables) and `CollarAt`, `CrossesAt`, `DirColourAt`,
`OffDirs` (predicates of variables, `GENERIC` at every site, no `¬ P` at a concrete instance).

**Records**: 38 new theorems, each recorded by `tools/fs131_wl_add_records.py` in a section "FS-131 Woodall's chain (job FS131-WL1)";
`tools/fs131_w3_decls.py --check` 257 theorems, 257 records, 0 missing, 0 stale; `--plant` FIRED. `ARCHITECTURE.md`'s `Woodall/Steps` row names
the model; `tools/check_architecture.py` PASS. No new name is declared on `fs131-w5` or `fs131-w5p` (`git grep`); `tools/fs131_i4_treedupes.py`
on the tree: `main`'s three textual repeats only.

**Build of this stage**: OK — 451 of 451 batches, 2 modules rebuilt (`Woodall/Steps`, `Proofs`), **0 modules with warnings** (0 `warning:` lines),
8 m 41 s, exit 0 (`build/gate/build/20261005T035201Z-1162343.log`; driver log `data/fs131/wl/build2.log`).
