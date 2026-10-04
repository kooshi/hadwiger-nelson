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
| `ArcMap.exists_three_le_sectors`, `ArcMap.aeMap6_normal`, `ArcMap.aeMap6_merged` (moved after `aeMap6_normal`, which it cites), `ArcMap.aeMap6`, `ArcMap.aeMap6_of_condition5`, `woodall_thm6` | compositions, § 9.3; `aeMap6_merged` as § 9.3's route (cyclic step by the orbit of `finRotate`, `step5_lt` at the horn, injectivity, `step5_lt` again for the angles) | proved from their citations; `sorryAx` through `exists_sectorsAt`, `ts_t`, `step6`, `step5_lt`, `exists_woodallMerged` (open or cited) |
| **FS131-IWb** — the connected piece: `ArcMap.exists_preconnected_of_mem_coneAt`, `collarAt_shadow_inner_of_mem_coneAt`, `collarAt_shadow_outer_of_mem_coneAt`, `SectorsAt.mem_coneAt_of_mem_Icc` | the brief's child ("a preconnected piece of a colour class approaching a point along a cone direction, for a horn and for any sector") | `sorryAx` through wave 3's `coneAt_region_eq_biUnion` (proved on `fs131-w3`, unlanded); `mem_coneAt_of_mem_Icc`: standard three |
| **FS131-IWb** — E1-RAY (inner, outer) and E1-BAD's interior case `SectorsAt.not_mem_coloursAt_of_mem_Ioo`, re-proved through the cone clause (items 154–155) | unchanged statements, § 8.5 | `sorryAx` through the connected piece (wave 3) and, for E1-BAD's case, E1-SEE's citation (`unitPairsNull_region`) |
| **FS131-IWb** — **`ArcMap.step5_lt`** (Woodall's step 5, strict), with `SectorsAt.collarAt_opposite`, `collarAt_closure_of_forall_shadow`, `exists_two_cover_of_three_le_card`, `Valid.region_dist_ne_one` | § 4.5's route: the inner arc `(β₂ − 3π/2, β₁ − π/2)` of length `π − φ > 2π/3`, inner collars for the three colours from the two edges as cone directions (horns included), two colours left, `woodall_step4` | `sorryAx` through cited statements only: `lemmaL` (via `woodall_step4`), `dense_interiorPts` (via `subset_closure_of_subset_shadow`), `coneAt_region_eq_biUnion`; `exists_two_cover_of_three_le_card`, `Valid.region_dist_ne_one`: standard three |
| **FS131-IWb** — **`ArcMap.step6`** (Woodall's step 6 by Townsend's lemma), with `false_of_cos_eq_zero_on_Icc`, `exists_eq_add_half_pi_of_cos_eq_zero`, `cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two`, `collarAt_setOf_forall_mem`, `CollarAt.of_abs_sub_lt` | § 4.5 / § 9.3's route: off the six edge normals one side works at first order (two sectors failing on opposite sides share an edge whose normal is the angle); the seed is an opposite arc of length `π − φ > π/3` when some angle is `< 2π/3`, else the certified normal of edge `d 0` (`exists_normal_collarAt`) extends one of length exactly `π/3`; `townsend_lemma` | `sorryAx` through cited statements only (`lemmaL` via `townsend_lemma`; `dense_interiorPts`; `coneAt_region_eq_biUnion`); the five real-variable children: standard three |

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
