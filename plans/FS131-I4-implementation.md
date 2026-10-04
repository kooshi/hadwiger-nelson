# FS131-I4 — wave 4's implementation record (branch `fs131-w4`)

Implementer: de Bruijn on Sonnet 5.5. Brief `data/fs131/briefs/FS131-I4-wave4.md`; plan `plans/FS131-w4-kernel-plan.md` (§ 13 the plan per leaf,
§ 14 the handoff). Iteration tools: `data/fs131/i4/iter.sh <module…>` (compile oleans into a scratch mirror, never evidence) and
`data/fs131/i4/chk.sh <module or abs path>`.

## Theorems this phase proved

(Axioms from `#print axioms` prints only until the gate runs; the gate's saved log supersedes.)

Axioms below are from `#print axioms` prints against scratch oleans (`data/fs131/i4/iter.sh`, then a print file), **not from a gate log**: the gate
has not run (60 of 86 leaves remain). Every line reads `[propext, Classical.choice, Quot.sound]` unless marked "(over sorry)".

- FS110-N4-FIN: `HadwigerNelson.Plane.n4_fin` (+ `curvUp_curvDown`) — standard three. Read against the row: no bi-infinite chain `−1<λ_k<υ_k<1`, `λ_k ≤ f(λ_{k+1})`, `f̃(υ_{k−1}) ≤ υ_k` (same statement).
- FS112-N2-RAY: `ray_chain`, `exists_oneSided_chain`, `rayLower_pencil` — standard three.
- FS110-N3-CONF: `ArcMap.contact_inType_or_outType`, `ArcMap.coneAt_subset_allowedCone`, `lens_dist_lt_one_of_up`, `lune_dist_le_of_up` — standard three
  (the first two over wave 3's `ne1_region`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`, `unitNear/unitFar_of_mem_closure`, which are
  `sorry` on `main`'s wave-3 skeleton and proved on `fs131-w3`: the scratch prints used wave 3's proved versions).
- FS110-N4-SHADOW: `shadow_farSide_above`, `shadow_farSide_below` — standard three.
- FS110-N3-DEG's neighbour, FS112-N2-BENDS' N2-SIGN: `ArcMap.n2_sign` — standard three (over `ne1_region`).
- FS112-FLANK: `ArcMap.inType_shadows_horn`, `ArcMap.flank_siamese_of_inType` — standard three. FS112-N2-FLANK-Q: `ArcMap.flankQ_both` — standard three.
- FS106-TS-T (arc maps): `ArcMap.ts_t`, `ts_t_trichromatic`, `ts_t_degree_three`, `AeProperRegions.exists_three_le_multicolour_lt_one` — proved *from*
  `exists_three_le_multicolour` (still `sorry`, over `lebesgue_covering_square`) and `exists_hasDegree_of_mem_dom` (still `sorry`): axioms read `sorryAx` (over sorry).
- Foundation/inhabitants: `ArcMap.Valid.of_agreesOff` (engine 1), `ArcMap.region_locallyFinite`, `ArcMap.dense_iUnion_region`, `sevenBrickArcs_nondegenerate`,
  `sevenBrickArcs_locallyFinite`, `sevenBrick_color_locallyConstant` (so `sevenBrickMap` is a sorry-free arc map once `sevenBrickMap_valid`'s imports are) — standard three.
- `l60Arcs_nondegenerate`, `isOpen_isoDom` (fragment plumbing) — proved (print not taken: they live in `ArcMap`; the gate's records will name them).

## Stage 1 — SAVED: the readback

**Quotations checked against `plans/FS131-w4-kernel-plan.md` § 14.2 and `plans/FS131-close-inventory.md` line 650**: all three match their sources
verbatim (the "It may" and "It may not" sentences, the "Wave 4 note" on `noBoth`'s cusp case).

**What I may change**: add children anywhere in the wave's modules (the seven engines and every child § 13 names; engines in the foundation
`Plane/ValidMap/Basic`, sorry-free, each with a spec example); add supporting lemmas to the foundation modules (wave 4's `Basic`, wave 3's
`Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's `Plane/Chord`, `Diameter`, `Basic`), statements unchanged; change imports (updating
`ARCHITECTURE.md`'s Imports cell, adding each new record to `scripts/Axioms.lean`, then `tools/fs131_k4_decls.py --check`).
**What I may not change**: any statement of §§ 3.2, 7.2, 8.2, 12.2; any definition of `Plane/ValidMap/Basic`; the fragments' definitions
(`bowtie*`, `l60*`, `isoY`, `isoFrag`, `sevenBrick*`) except a coordinate slip found against the source tool (a finding, with the tool's output);
the read-backs' conventions; no new `axiom`, no `native_decide`. A statement that cannot be proved as written goes to Keryx with the stuck goal.
`lebesgue_covering_square` is FS131-LEB's. `noBoth`: if its proof reaches the cusp case (item 112), stop that leaf and message Keryx.

**The worktree build as given** (`f620977c`): started under the slot (log `data/fs131/i4/build-stage1.log`); edits to `Basic`, `StuckChain`,
`Contact` were made while it ran, so it is not a clean "as given" build. Wave 3's modules are still `sorry`-bearing here (`LocalStructure` 12,
`Tiles` 20, `RingGerm` 36, `RingBand` 15, `Lens` 2, `SixFragment` 12), so wave 4's leaves that read them are proved over their statements.

## Stage 2 — SAVED: engine 4 (frame algebra), engine 1, and `StuckChain` (5/5)

First two hard-ish leaves re-price: `n4_fin` (graded M) took one pass (two inductions via `inv_curvUp`, `inv_curvDown`); `rayLower_pencil`
(M) one pass over engine 4. These E/M leaves cost minutes, not the planner's table.

Added to `Basic` (sorry-free): `e_add_pi_div_two`, `frame_normSq`, `sq_dist_normalPt`, `sq_dist_N`, `sq_dist_S`, `tanAbove_one_iff`,
`tanBelow_one_iff`, `tanAbove_neg_one_iff`, `tanBelow_neg_one_iff`, `tanHeight_eq_of_ne_zero`, `tanAbove_iff_of_pos`, `tanBelow_iff_of_pos`,
`sq_dist_frame` (the frame is an isometry), `frameX/Y_add_normal`, `frameX/Y_{self,N,S}`; engine 1 `ArcMap.Valid.of_agreesOff`.
`StuckChain`: `curvUp_curvDown`, `n4_fin` (children `inv_curvUp`, `inv_curvDown`, `n4_fin_u_nonpos`), `ray_chain`, `exists_oneSided_chain`,
`rayLower_pencil` (children `rayLower_neg`, `rayLower_eq_curvDown`). `Contact`: `lens_dist_lt_one_of_up`, `lune_dist_le_of_up`.

## Stage 3 — SAVED: 26 of 86 leaves, and the wave-3 snapshot for iteration

**Where it stands.** Proved (sorry-free): StuckChain 5/5; Contact 6 (`contact_inType_or_outType`, `coneAt_subset_allowedCone`, `lens_dist_lt_one_of_up`,
`lune_dist_le_of_up`, `shadow_farSide_above`, `shadow_farSide_below`); UnitArc 6 (`n2_sign`, `l60Arcs_nondegenerate`, `isOpen_isoDom`, `inType_shadows_horn`,
`flank_siamese_of_inType`, `flankQ_both`); SVMap 9 (`region_locallyFinite`, `dense_iUnion_region`, `exists_three_le_multicolour_lt_one`, `ts_t`,
`ts_t_trichromatic`, `ts_t_degree_three`, `sevenBrickArcs_nondegenerate`, `sevenBrickArcs_locallyFinite`, `sevenBrick_color_locallyConstant`, the last two proved
in this stage's last commits); BaseSteps 0. **Remaining 60 `sorry`** (Contact 10, UnitArc 23, SVMap 5 including `lebesgue_covering_square`, BaseSteps 22;
count with `grep -c "^  sorry" <module>`): see "What is left" below.

**Statement changes: none.** No new axiom, no `native_decide`. Imports changed (statements unchanged): `Contact` now imports `Plane/Tiles`, `UnitArc` imports
`Plane/RingGerm` (ARCHITECTURE.md's Imports cells updated, `tools/check_architecture.py` PASS). `inv_curvUp`, `inv_curvDown` moved from `StuckChain` to `Basic`
(children; `Contact` needs them).

**Iteration against wave 3's proved engines.** The wave-4 skeleton sits on wave 3's skeleton (`05cb0a3e`), where `Valid.dist_lt_or_gt_of_isPreconnected`,
`ne1_region`'s proof, `finite_tiles_near`'s proof etc. are not all present. Per the brief I did not merge `fs131-w3`; instead `data/fs131/i4/w3snap.sh`
extracts the seven wave-3 modules as they stand on `fs131-w3` and compiles them into the scratch olean mirror, so wave-4 files iterate against wave 3's
proved lemmas (statements as on `05cb0a3e`; only *proofs* and children differ). My proofs use only statements present at `05cb0a3e`
(`ne1_region`, `unitNear_or_unitFar`, `unitNear/unitFar_of_mem_closure`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`, `finite_tiles_near`,
`dense_interiorPts`), so the real build (`build-stage3.log`) compiles them over the skeleton.

**New children (all with docstrings; `tools/fs131_i4_addrecords.py` added their `#print axioms` records to `scripts/Axioms.lean`)**:
Basic: `e_add_pi_div_two`, `frame_normSq`, `sq_dist_normalPt`, `sq_dist_N`, `sq_dist_S`, `tan{Above,Below}_{one,neg_one}_iff`, `tanHeight_eq_of_ne_zero`,
`tan{Above,Below}_iff_of_{pos,neg}`, `conj_e_mul_e`, `frame{X,Y}_sub`, `sq_dist_frame` (the frame is an isometry), `frame{X,Y}_add_normal`,
`frame{X,Y}_{self,N,S}`, `frame{X,Y}_base_{N,S}`, `frameX_normalPt`, `inv_curvUp`, `inv_curvDown`, `inv_curvDown_eq`, `ArcMap.Valid.of_agreesOff` (engine 1).
StuckChain: `n4_fin_u_nonpos`, `rayLower_neg`, `rayLower_eq_curvDown`. Contact: `dot_div_ofReal`, `norm_sub_sq_eq_dot`, `abs_dot_le`, `dot_sub`,
`dot_nonneg_of_coneAt_subset`, `dot_nonpos_of_coneAt_subset`, `frameX_add_smul`, `rayPt` (+ `rayPt_continuousAt`, `dist_rayPt`, `dist_rayPt_center`,
`frameX_rayPt`, `norm_C_sub_z`), `shadow_inside`, `shadow_outside` (the engine of N4-SHADOW: the shadow of a set inside / outside a disc, both from the
ray point `z ± (C − z)/‖C − z‖`). UnitArc: `frame{X,Y}_framePt`, `tanHeight_hornPt`, `eventually_hornPt_{pos,neg}`, `exists_mem_hornSet_aboveBelow`
(horn points on a parabola at a prescribed height). SVMap: `brickCorner_re/im`, `eventually_floor_eq`, `sevenBrick_{h,w,s}`.

**Re-pricing (from the first two hard leaves, as the standing rule asks).** The plan's M/M–H grades were high: `n4_fin` and `rayLower_pencil` (M) took one
pass each; `shadow_farSide_above/below` (M–H, 6 sub-cases each) became two generic lemmas (`shadow_inside`, `shadow_outside`) plus a short case split, because the
shadow of a disc-bounded set is computed from one explicit point (the ray point), never from connectedness — the plan's "connectedness of the polar region"
step is unnecessary. `flankQ_both` (M) needed one new child (`exists_mem_hornSet_aboveBelow`). Cost per proved leaf in this session: about 8–12k tokens for
E/M leaves; the engine children are where the shared work is.

**What is left, and where I stopped** (the order a successor should take; the plan's § 14.1 order otherwise holds):
- **Wave-3-engine gaps found.** The plan (§ 13.1) cites `localSectors` (wave 3's sector engine) as gating `woodallCone`, `exists_hasDegree_of_mem_dom`, engine 5, and
  `noBoth`'s `HasRepeatedColour` clause; **it does not exist on `fs131-w3`** (`git grep localSectors fs131-w3` is empty). Those leaves — `woodallCone`,
  `woodallCone_strict`, `exists_hasDegree_of_mem_dom`, `noBoth`, `flankQ_upper/lower` (engine 5), `stuck_structure`, `exists_hasDegree…` consumers — need that child
  first (a statement about the components of `interiorPts ∩ ball v r`: at a point of `dom`, finitely many sectors and each is a horn/cusp or a region
  with a positive-angle cone). I did not state it; it is wave 3's per § 13.1, and its absence is a finding for the coordinator.
- **Not attempted (hard, and what each needs):** `lock` (the exact R2OUT/R2IN geometry against both side tiles; needs the N-E2 two-sidedness at `w` and
  `tools/fs112_n2_checks.py`'s cases); `l60_*` (engine 6, the side chain, `IsPreconnected.induction₂`); `u1_shadow`; the N2-ENV family and the bends (engines
  1–3, with engine 2 `ringArcsWithin_of_Γ_subset` stated in `data/fs131/i4/` notes only: `F'.dom = F.dom`, `F'.Γ ⊆ F.Γ ∪ ⋃ A'`, `A'` finite and no unit arc ⟹ `F'.RingArcsWithin F`;
  route: `Γ = dom ∩ (interiorPts)ᶜ` is closed in `dom`, the sub-arc minus a finite set lies in `F.Γ`, hence all of it); the three Contact moves; `stuck_*`; `a4six`,
  `nb4p`; `lemmaL`, `not_lemmaL_of_not_mem`, `exists_three_le_multicolour` (over `lebesgue_covering_square`); BaseSteps (all 22: the bowtie is per-fragment exact
  arithmetic — `bowtie_mem_dom` is *not* E, it needs `0 ∈ interior (closure bowtieTiles)`, i.e. a covering of a neighbourhood of `0` by the tiles' closures).
- **The gate has not run**: it needs every `sorry` gone except `lebesgue_covering_square`. The real build of this stage: `data/fs131/i4/build-stage3.log`.

## Stage 4 — SAVED (FS131-I4b): readback, six leaves, 54 `sorry` left

**Readback (brief FS131-I4b).** The four quotations (§ 14.2 "It may", ruling 126, the Wave 4 note, the Stage 3 "Where it stands") match their sources;
ruling 126 has since been replaced by item 132 (coordinator's message): `localSectors` is **not** mine to state; wave 3's FS131-I3g states it in
`Plane/LocalStructure`, and I iterate against it with `data/fs131/i4/w3snap.sh` once told. What I may change: unchanged from Stage 1. The worktree at `d011c17d` built
as given: "all 1741 modules already up to date" (`data/fs131/i4/build-i4b-readback.log`), nothing edited before it.

**Proved this stage (6 leaves; 60 → 54 `sorry`; `lebesgue_covering_square` still among them, FS131-LEB's):**
`bowtieArcs_nondegenerate`, `bowtieArcs_locallyFinite` (BaseSteps); `isoCol_locallyConstant`, `iso` (all eight clauses), `l60_eq_third` (UnitArc);
`not_lemmaL_of_not_mem` (SVMap; the counterexample is the planner's § 7.3 with straight cones and radius `1/10`, `1/4`). Children added (UnitArc): `exists_dir_dot_neg`,
`ArcMap.exists_tile_cone_dot_neg` (a tile with a direction `β`, `e β · u < 0`, at any point of the domain, over wave 3's `exists_mem_coneAt_region` and
`coneAt_region_eq_biUnion`), `mem_isoArc_of_norm_one`, `two_lt_norm_of_mem_isoY`, `norm_bounds_of_mem_ball_one`, `isoFrag_col_eq_zero_iff`,
`norm_eq_one_of_mem_isoFrag_arcs`, `mem_isoFrag_dom`, `isoFrag_region_one`. Import added to `UnitArc`: `Mathlib.Analysis.Real.Pi.Bounds` (for `Real.pi_gt_three`).
**No statement changed, no new axiom, no `native_decide`.**

**A tool caveat found.** `data/fs131/i4/chk.sh` resolves imports through the scratch mirror, whose `RingGerm` is wave 3's snapshot: it imports Mathlib modules that
the skeleton's `RingGerm` does not, so a name can elaborate under `chk.sh` and be unknown in the real build (`Real.pi_gt_three`, found by the real build, not by `chk.sh`).
Every stage therefore ends with a real `./scripts/build.sh`.

**What is left, and what I judged (so a successor does not redo it):**
- *Needs `localSectors` (item 132)*: `woodallCone`, `woodallCone_strict`, `exists_hasDegree_of_mem_dom`, `noBoth`'s repeated-colour clause, engine 5
  (`flankQ_upper`, `flankQ_lower`), `stuck_structure`, `stuck_chain`, `pair_*`, `fail_*`, `anti` (the cubic-vertex statements), the three Contact moves.
  Told the coordinator what form I need (message "Answer on sector structure": the branch-germ form with horn identification, not only my `IsSector`).
- *`lemmaL` (FS106-L)*: the sweep argument alone does not close it. With `S_A = ⋃_{a ∈ A∩B(b,η)} ω(a)` (open, disjoint from `A`) and `S_B` likewise, `S_A ⊆ cl B` and `S_B ⊆ cl A`
  near `y ∈ ω(b)∩W`, and the contradiction needs `S_A ∩ S_B ≠ ∅`, i.e. a pair `a ∈ A`, `a' ∈ B` near `b` with `a' − a` within `r` of the direction perpendicular to `y − b`
  (two unit circles then meet near `y`). That pair exists by a two-dimensional covering argument (all lines of that direction near `b` cannot be split between `A` and `B`
  while both accumulate at `b` and `B(b,η) ⊆ cl(A∪B)`) that the plan's "sweep" note does not state. Not attempted past this analysis.
- *`lock`*: clauses 1 and 2 follow from `n2_sign` by transversality of `ω(z)` to `ω(P)` at `w` (`z ∉ {P, P + 2e θ}`); clause 1's exclusion of `P + 2e θ` for the *outer*
  colour is not a consequence of validity at `w` alone (a second tile of colour `c'` far away may touch there); it needs N-E2 between the outer tile at `w` and that tile.
- *`l60_real`, `l60Col_locallyConstant`*: validity needs the Reuleaux-triangle width lemma (interior points of `B(0,1)∩B(A,1)∩B(B,1)` are `< 1` apart) and three trig facts
  (`lens ∩ ω(0)`, `∩ ω(1)`, `∩ ω(e 60°)` lie on the listed arcs); not started.
- *`n2_env_*`*: the identity route needs `∀ p ∈` lens a bound uniform in `p`; the chord-convexity shortcut (`w` in the chord triangle) fails because lens points can be farther than `1` from `P`.
  Not started.
- *Bowtie* (11 leaves): `bowtieCol_locallyConstant` needs the 11 tiles pairwise disjoint (55 pairs) and "domain minus arcs ⊆ tiles", the heaviest finite computation of the
  wave; every other bowtie leaf reads it or `bowtie_mem_dom`. Not started.
- *`exists_three_le_multicolour`* (over `lebesgue_covering_square`): route worked out, not written: components as pairs `(j, C)`, the relation "same colour, closures meet",
  `ReflTransGen` classes of diameter `< 1` by `chain_step` induction, class closures locally finite hence closed (`LocallyFinite.isClosed_iUnion`), finitely many classes meet
  the square (compactness), side `1 + ε` against `1/√2 + ε`, three classes at the Lebesgue point have three distinct colours (two classes of one colour with closures meeting would coincide).

## Stage 5 — SAVED (FS131-I4c): readback, the as-given build

*FS131-I4c (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4c-wave4.md`) continues this record from `f1f26a8a`.*

**The brief's three quotations against their sources** (standing rule 3): (1) "**It may**: add children anywhere in the wave's modules — the seven
engines and every child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2, line 887: **matches as a
truncation** (the source continues "… foundation `Plane/ValidMap/Basic` where § 13.1 puts them, …"). (2) "**Readback (brief FS131-I4b).** The four quotations
(§ 14.2 "It may", ruling 126, the Wave 4 note, the Stage 3 "Where it stands") match their sources;" — this record, Stage 4's first sentence: **matches as a
truncation**. (3) "163. **FS131-I3i mid-job: `localSectors` proved** (message 2026-10-04; `fs131-w3b` at `d8a3177f`, pushed), in I3h's drafted shape
unchanged — `HadwigerNelson.Plane.localSectors" — `plans/FS131-close-inventory.md` on `main`, item 163: **matches as a truncation** (the source continues
with the signature `(F) {v} (hv : v ∈ F.dom) : ∃ r₀ n G, F.IsSectorChart G v r₀` and the exports). The inventory items the brief cites (136, 142, 143, 144,
151) read on `main` as the brief summarizes them.

**What I may change** (§ 14.2, unchanged from Stage 1): add children anywhere in the wave's modules (the seven engines, sorry-free, in `Basic` with spec
examples, and every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`,
wave 1's `Plane/Chord`, `Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`,
then `tools/fs131_k4_decls.py --check`); and, from this brief: discharge `lebesgue_covering_square` from `main` (inventory item 151); the bridge from
`localSectors`' `IsSectorChart` to wave 4's `IsSector`/`hornSet` (item 136) as a wave-4 child; a new wave-4 module for it if needed; the vacuity carriers at the
gate (wave 4's only), `AeProperRegions` among them (item 144). **What I may not change**: any statement of §§ 3.2, 7.2, 8.2, 12.2; any definition of
`Plane/ValidMap/Basic`; the fragments' definitions (`bowtie*`, `l60*`, `isoY`, `isoFrag`, `sevenBrick*`) but for a coordinate slip found against the source
tool (a finding); the read-backs' conventions; TS-T's Condition-5 clause stays in its carried form (item 142); no new `axiom`, no `native_decide`. A leaf
that cannot be proved as written goes to Keryx at once with the declaration, the reason and the counterexample or missing hypothesis.

**The worktree as given** (`f1f26a8a`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1741 modules already up to date, nothing built, 10 module(s) with warnings", exit 0 (`build/gate/build/20261004T151446Z-265642.log`; driver log
`data/fs131/i4/build-i4c-readback.log`). The ten are the `sorry`-bearing modules: wave 3's six skeletons as of `05cb0a3e` and wave 4's four (`StuckChain` is
sorry-free). 54 `sorry` declarations: Contact 10, UnitArc 20, BaseSteps 20, SVMap 4.

## Theorems this phase proved (Stage 4's additions; `#print axioms` prints against the real build's oleans, not a gate log)

- FS112-ISO: `HadwigerNelson.Plane.ArcMap.iso` (+ `isoCol_locallyConstant`) — read against the row: same statement (`isoFrag` valid; the arc `r([−1/8, 1/8])` has constant sides `0` inside, `1` outside;
  `0 ∉ P_cl(0)`; `isoY` a tile of colour `0` outside `B̄(0,2)` with corner `2`; `C₂ = {0}`; the radial points `1 + s` at distance exactly `1` from the class). Inhabits the bends' centre conditions.
- FS114-L60-LE, L60-EQ's third tile: `ArcMap.l60_eq_third` — same statement; axioms `[propext, sorryAx, Classical.choice, Quot.sound]` **(over sorry)**: wave 3's `exists_mem_coneAt_region`, `coneAt_region_eq_biUnion` are `sorry` on this branch's skeleton.
- FS106-L's adversary: `not_lemmaL_of_not_mem` — same statement.
- FS112-BOWTIE's fragment data: `bowtieArcs_nondegenerate`, `bowtieArcs_locallyFinite` — same statements.

## Drafts for the front page

None yet: the milestone is not Closed (60 leaves remain, 59 without `lebesgue_covering_square`).
