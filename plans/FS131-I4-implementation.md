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

## Stage 6 — SAVED (FS131-I4c): `main` merged, Lebesgue discharged, FS106-L and TS-T's first clause proved; 51 `sorry` left

**The merge** (`52fe62fd`): `origin/main` (waves 1 and 3 landed, FS131-LEB) into `fs131-w4`. Conflicts at the append points only — `ARCHITECTURE.md` (`main`'s
landed wave-3 rows and LEB's two rows, then wave 4's) and `scripts/Axioms.lean` (both blocks; no duplicate record). `tools/fs131_qa1_dupes.py`
(`data/fs131/i4/dupes-i4c.log`): no collision with `main`; `abs_dot_le` collides with `fs131-ww` only. This stage adds two more names that `fs131-ww`'s
`Plane/Woodall/Collar` also declares with the same statement, `isOpen_shadow` and `dot_add_left` (`HadwigerNelson.Plane`): under item 142 the branch landing
later deletes its identical copy. Build of the merge: "build: OK — 443 of 443 batches, 19 module(s) rebuilt, 4 module(s) with warnings", exit 0
(`build/gate/build/20261004T151814Z-292722.log`; driver log `data/fs131/i4/build-i4c-merge.log`) — the four are wave 4's `sorry` modules; wave 3 is sorry-free.

**Proved this stage (3 leaves; 54 → 51):**
- `lebesgue_covering_square` — one line, `LebesgueCovering.lebesgue_covering_square c hs F hF hcov hLR hBT` (inventory item 151); `Plane/SVMap` imports
  `Topology/LebesgueCovering`; docstring cites `[HurewiczWallman1948]` Thm IV 2, p. 42, and the "disposition owed" sentence is gone (module docstring and
  `ARCHITECTURE.md` row likewise).
- `AeProperRegions.exists_three_le_multicolour` (FS106-TS-T, SB's form) — I4b's route, written: regions as pairs `(j, C)` (`IsRegion`; two classes may share a
  component as a set), the regions meeting a finite open cover `U` of the square of side `1 + ε` about `z` (compactness and `locallyFinite`), the chain classes
  (`Relation.EqvGen` of "same colour, closures meet") on that finite set, `Fc a` the union of a class's closures (closed, finite union), every point of the
  square in some `Fc a` (density plus local finiteness at the point), diameter `≤ 1` per class (wave 1's `chain_step` passed along the `EqvGen` induction,
  with `unitPairsNull_cls`), the distinct class sets enumerated by `Finite.exists_equiv_fin`, Lebesgue at side `1 + ε > 1`, and three classes at the point
  with three colours (two of one colour whose closures meet are one class). Children: `unitPairsNull_cls`, `IsRegion`, `IsRegion.subset`,
  `IsRegion.isPreconnected`, `IsRegion.chain_step`, `IsRegion.dist_lt_one`. Import added: `Plane/Diameter`.
- `lemmaL` (FS106-L) — **plan gap closed (item 143)**. The sweep route needs no two-dimensional covering argument, only one explicit point. For `q ∈ ω(b) ∩ W`:
  `V_A = Sh(A) ∩ B(q, δ)` is open and misses `A`, so `V_A ⊆ cl(V_A ∩ B)` (it lies in `W ⊆ cl(A ∪ B)`), likewise `V_B ⊆ cl(V_B ∩ A)`; `Sh(V_A ∩ B)` is open, misses
  `B` and is dense in `Sh(V_A)` (`shadow_subset_closure_shadow`), likewise `Sh(V_B ∩ A)`; so a point `w ∈ B(b, η) ⊆ W` lying in `Sh(V_A) ∩ Sh(V_B)` gives a
  non-empty open subset of `W` missing `A ∪ B` — contradiction. The point (`exists_double_unit_circle`): `a ∈ A`, `a' ∈ B` within `ε` of `b`, `w = a + t·i(q − b)`
  with `t = sin δ'/2`, and on each of `ω(a)`, `ω(a')` a point within `δ` of `q` at unit distance from `w`, by the intermediate value theorem on
  `θ ↦ (w − p)·e(θ) − |w − p|²/2` over `[θ₀ − δ', θ₀ + δ']` (`exists_dist_add_e_eq_one`), `θ₀ = arg(q − b)`. Children: `dot_e_e`, `dot_ofReal_mul`,
  `dot_add_left`, `abs_dot_e_le`, `dist_add_e_sq`, `exists_dist_add_e_eq_one`, `exists_double_unit_circle`, `isOpen_shadow`, `disjoint_shadow`,
  `shadow_subset_closure_shadow`. `b ∈ W` is used exactly where the adversary `not_lemmaL_of_not_mem` says it must be (`w ∈ B(b, η) ⊆ W`).

**No statement changed, no new axiom, no `native_decide`.** The 15 new theorems' records are in `scripts/Axioms.lean` (section "FS-131 wave 4 (job FS131-I4c)");
`tools/fs131_k4_decls.py --check`: 150 names, 0 missing; `tools/check_architecture.py`: PASS (the `Plane/SVMap` row's Imports cell gains
`Topology/LebesgueCovering`, `Plane/Diameter`). Build of this stage: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 4 module(s) with warnings", exit 0
(`build/gate/build/20261004T152838Z-359462.log`; driver log `data/fs131/i4/build-i4c-stage6.log`). Axioms printed against that build's oleans
(`data/fs131/i4/axioms-i4c-stage6.txt`).

**Re-pricing** (from these leaves): `exists_three_le_multicolour` (planned M) ≈ 230 lines and `lemmaL` with its geometric step ≈ 200 lines; each elaborated on
the second try. On Opus a planned-M leaf with a fixed route costs about 15–25k tokens; the cost sits in reading the plan and the derivation.

**What is left (51), and what the next session does first:**
- **Merge `main` again** (`localSectors` landed at `0131aa59`, the coordinator's message; inventory item 171 lists its exports), then the bridge (item 136):
  for `v ∈ dom` and `r ≤ r₀`, every `IsSector v r S` is one of the chart's sectors (`n > 0`: they are open, preconnected, disjoint and cover
  `ball v r ∩ interiorPts`, so each non-empty one is a component; `n = 0`: the ball), `HasDegree v (max n 1)`, and a one-direction cone's sector equals a
  `hornSet`. First consumer: `exists_hasDegree_of_mem_dom` (each colour at `v` is a sector's colour, sectors are monochromatic, so `ncard (coloursAt v) ≤`
  the degree) — it closes `ts_t_trichromatic`, `ts_t_degree_three` and `Plane/SVMap`.
- **The coordinator's four QA2 items** (FS131-QA2, item 172; before the gate, no statement changes): (1) an inhabitant of `IsCubicTrichromatic` and a
  non-degenerate one of `MIn` — `sevenBrickMap` at a brick corner (T-junction, angles `π/2, π/2, π`, three colours; `tools/fs131_qa2_brick.py`,
  `plans/FS131-QA2-audit.md` § 2.2); (2) an `IsHorn` model — the `bowtie_*` leaves early, or a two-colour cusp fragment; (3) `halfDisc.Simple`; (4)
  `stuck_chain`'s docstring declares that no model is expected (`n4_fin` refutes the configuration), naming the refuting theorem.
- **`lock` clause 1** (item 143's second gap): not worked out this stage.
- **Before the gate**: `AeProperRegions` as a vacuity carrier (empty at `k ≤ 1`, item 144); TS-T's Condition-5 clause kept in its carried form (item 142).
- The other leaves as Stage 4 lists them: Contact 10, UnitArc 20, BaseSteps 20.

## Stage 7 — SAVED (FS131-I4d): readback, the as-given build

*FS131-I4d (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4d-wave4.md` on `main`) continues this record from `2e42278a`.*

**The brief's three quotations against their sources** (standing rule 3): (1) "**It may**: add children anywhere in the wave's modules — the seven engines and
every child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2 (line 887 of the file): **matches as a truncation**
(the source continues "… foundation `Plane/ValidMap/Basic` where § 13.1 puts them, …"). (2) "**The merge** (`52fe62fd`): `origin/main` (waves 1 and 3 landed,
FS131-LEB) into `fs131-w4`. Conflicts at the append points only — `ARCHITECTURE.md` (`main`'s" — this record, Stage 6's first paragraph: **matches as a
truncation**. (3) "171. **FS131-I3i done; `localSectors` LANDED on `main`** (report `data/fs131/reports/FS131-I3i.md`; record on `fs131-w3b`; `origin/main`
fast-forwarded to `0131aa59`, whose Lean" — `plans/FS131-close-inventory.md` on `main`, item 171: **matches as a truncation**. The items the brief cites
(136, 142, 143, 144, 172) read on `main` as the brief summarizes them.

**What I may change** (§ 14.2, unchanged from Stages 1 and 5): add children anywhere in the wave's modules (the seven engines in `Basic`, sorry-free, with
spec examples; every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`,
wave 1's `Plane/Chord`, `Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`,
then `tools/fs131_k4_decls.py --check`); a new wave-4 module for the bridge to `localSectors` (item 136); wave 4's vacuity carriers at the gate,
`AeProperRegions` among them (item 144); `stuck_chain`'s docstring (QA2-5's declaration, item 172). **What I may not change**: any statement of §§ 3.2, 7.2,
8.2, 12.2; any definition of `Plane/ValidMap/Basic`; the fragments' definitions (`bowtie*`, `l60*`, `isoY`, `isoFrag`, `sevenBrick*`) but for a coordinate slip
found against the source tool (a finding); the read-backs' conventions; TS-T's Condition-5 clause stays in its carried form (item 142); no new `axiom`, no
`native_decide`. A leaf that cannot be proved as written goes to Keryx at once with the declaration, the reason and the counterexample or missing hypothesis.

**The worktree as given** (`2e42278a`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1743 modules already up to date, nothing built, 4 module(s) with warnings", exit 0 (`build/gate/build/20261004T154037Z-407415.log`; driver log
`data/fs131/i4/build-i4d-readback.log`). The four are wave 4's `sorry` modules. 51 `sorry` declarations: Contact 10, UnitArc 20, BaseSteps 20, SVMap 1.

## Stage 8 — SAVED (FS131-I4d): `main` merged, the bridge to `localSectors`, `exists_hasDegree_of_mem_dom`, QA2's items 2–5, `lock` ruled; 50 `sorry` left

**The merge** (`05968b36`): `origin/main` at `cff2c33e` (`localSectors` landed, item 171) into `fs131-w4`. One conflict, at the append point of
`scripts/Axioms.lean` (main's I3i block kept first, wave 4's after; no record duplicated). `tools/fs131_qa1_dupes.py` (`data/fs131/i4/dupes-i4d.log`):
no collision with `main`; the three known collisions with `fs131-ww` (`abs_dot_le`, `dot_add_left`, `isOpen_shadow`, plus `dot_e_e`, all identical
statements) stand for whichever branch lands second (item 142). Build of the merge: "build: OK — 444 of 444 batches, 11 module(s) rebuilt, 4 module(s)
with warnings", exit 0 (`build/gate/build/20261004T154138Z-409752.log`; driver log `data/fs131/i4/build-i4d-merge.log`).

**The bridge (inventory item 136)**, a new wave-4 module `Plane/ValidMap/Sectors` (imports `Plane/ValidMap/Basic`; `Plane/SVMap` now imports it):
- `isSector_iff_of_partition`, `encard_sectors_of_partition` — if the interior points of `B(v, r)` are a union of open, preconnected, pairwise
  disjoint, non-empty sets with `v` in each closure, the sectors at radius `r` are exactly those sets (and there are as many as pieces). The general
  form, used both for charts and for concrete maps.
- `IsSectorChart.isSector_iff` (`n > 0`: the chart's sectors), `…_of_zero` (`n = 0`: the ball), `encard_sectors`, `hasDegree` (`v` has degree `max n 1`,
  constant for `r ≤ r₀` — item 136's "the number of sectors is constant"), `ncard_coloursAt_le` (every colour at `v` is a sector's colour),
  `exists_hasDegree_of_chart`.
- `sectorBetween_eq_hornSet` — the sector between two germs of one direction `β` is `hornSet v β κ₁ κ₂ r` exactly (`|κᵢ| r ≤ 2`); with it item 136's
  dichotomy `IsSectorChart.isSector_cone_or_horn`: every sector at `r ≤ r₀` has a cone with non-empty interior or is a horn `hornSet v β κ₁ κ₂ r`, `κ₁ < κ₂`.
  (Children: `connectedComponentIn_eq_of_iUnion`, `frame_polar`, `tanHeight_polar`, `half_curv_mem_Icc`, `coneAt_ball_self`, `IsSectorChart.curv_next`,
  `mem_closure_sector`, `injective_of_disjoint`.)
- **Leaf proved**: `exists_hasDegree_of_mem_dom` (SVMap) `:= exists_hasDegree_of_chart hx`. So `ts_t_trichromatic`, `ts_t_degree_three` are sorry-free and
  **`Plane/SVMap` has no `sorry`** (50 left: Contact 10, UnitArc 20, BaseSteps 20).

**QA2's items (item 172), no statement changed:**
- **QA2-2** — `sevenBrick_corner_isCubicTrichromatic : sevenBrickMap.IsCubicTrichromatic 0` (SVMap): at `0 = brickCorner 0 0` the interior points of
  `B(0, ρ)`, `ρ ≤ 1/5`, are the three cells (`sevenBrick_corner_interior`: the edges there are the line `im = 0` and the half-line `re = 0, im ≥ 0`), so
  degree `3` (`sevenBrick_corner_hasDegree`, through `encard_sectors_of_partition`), and `P_cl(0) = {0, 6, 4}` (`sevenBrick_corner_coloursAt`; colours
  `(column + 3·row) mod 7` of cells `(0,0)`, `(−1,0)`, `(0,−1)`). And `sevenBrick_corner_mIn` (BaseSteps, which now imports SVMap): `x = 4/5 + 3/5 i`
  is at distance exactly `1` and M-in at `0` (colour `0`). Together they exercise `pair_i`, `pair_ii`, `pair_P'`, `fail_*`, `anti`'s hypotheses on a valid
  plane map at `k = 7` (each docstring names them). Children: `not_mem_sevenBrickArcs`, `mem_sevenBrickArcs_of_bottom`, `…_of_left`,
  `abs_re_im_lt_of_mem_ball`, `mem_brickCornerSector_iUnion`, `brickCornerSector_subset_ball`, `brickCornerPt_mem`, `sevenBrick_color_eq`,
  `sevenBrick_corner_col`. Agrees with `tools/fs131_qa2_brick.py`'s checks 1–3 (same cells, colours, distance).
- **QA2-3** — `halfDisc_simple : halfDisc.Simple` with `halfDisc_two_tiles` (two distinct tiles, so the second clause is exercised): the tiles are the
  open half-discs (`halfDisc_isTile`), each a Jordan domain by `isJordanDomain_of_convex` (an open bounded convex non-empty set; Mathlib's
  `exists_homeomorph_image_interior_closure_frontier_eq_unitBall`), and the closures meet in a convex set.
- **QA2-4** — `cuspFrag_isHorn : cuspFrag.IsHorn 0 0 (-1) 1 1`, the library's first proved horn: `cuspFrag : ArcMap 2` on `B(0, 1/2)`, arcs the unit circles
  about `±i`, colour `1` outside both unit discs; `cuspFrag_valid`; for `r ≤ 1/2` the interior points of `B(0, r)` are the two horns and the two discs'
  parts (`cuspFrag_partition`), and the horn along `e 0` is a sector of colour `1` (`isSector_iff_of_partition`; its preconnectedness from wave 3's
  `isPreconnected_sector` and `sectorBetween_eq_hornSet`). The bowtie's own horn leaves stay open.
- **QA2-5** — `stuck_chain`'s docstring now says no model of its hypotheses is expected and names `n4_fin` as the refutation (a step inside N4-PROP's
  proof by contradiction), in `LEAN.md` § The gate's form ("Where none is expected … the docstring says so with the theorem that refutes the
  configuration") — not `VACUITY DECLARED:`, since the emptiness is not proved in Lean.

**`lock` (item 143's second gap) — sent to Keryx by message at this stage.** Clause 1 needs no N-E2: `IsRingArc`'s constant-sides clause holds **at
`w` itself** (`θ ∈ Ioo θ₁ θ₂`), so `outerColours P w = {c'}` and near `w` outside `B̄(P, 1)` every interior point is `c'`. For `y ∈ cl(region c')` with
`|y − w| = 1` and `y ≠ P`, `ω(y)` has points strictly outside `B̄(P, 1)` arbitrarily near `w` (`u = w − P`, `d = w − y`: `y ≠ P` iff `d ≠ u`, and then
`u·e(ψ) > u·d` for `ψ` near `arg d`); a `z'' ∈ region c'` near `y` that is not the centre of one of the finitely many unit arcs near `w` has on `ω(z'')` an
interior point there (wave 3's `Arc.finite_inter_sphere_or_eq_circ`), of colour `c'`, at distance `1` — against `Valid`. Clause 2 the same on the inner side
(`y ∉ {P, P + 2e(θ)}` is transversality). **Clause 3 looks false as a global statement** for a short arc: `P = 0`, arc `r([−0.01, 0.01])`, inner tile
`{0.9 < |z| < 1, |arg z| < 0.01}` (colour `c`), `T = B(m, 1/2) ∖ ⋃_{|φ| ≤ 0.01} B̄(e(φ), 1)` with `m = (2 + 1.95 e(0.3))/2` (colour `c`, connected, diameter
`< 1`, `2 ∈ cl T`, `1.95 e(0.3) ∈ T ∩ B(0, 2)`), cross distances to the inner tile `> 1` (float sample minimum 1.0024 — a sanity check, not exact). The
local form (near `P + 2e(θ)`) holds. **Ruled** (item 177, the brief's amendment): clauses 1–2 by this route; clause 3 **restated locally**, as the row reads
("from outside `B(P, 2)`"): `∀ T, F.TileOf c T → P + 2 * e θ ∈ closure T → ∃ δ > 0, Disjoint (T ∩ ball (P + 2 * e θ) δ) (ball P 2)` — the one statement
change of this stage, made on the ruling, docstring citing item 177; `lock` has no consumer in the library. **`lock` is left `sorry`**, its route written for
the successor: one engine serves all three clauses — *if `z ∈ region d`, `O` is an open subset of `dom` on which every interior point has colour `d`, and
`ω(z)` meets `O` at a point near which no arc of `F` lies on `ω(z)`, then `F` is not valid* (an arc of `ω(z)` in `O` has only finitely many points on `Γ`, by
`locallyFinite` and `Arc.finite_inter_sphere_or_eq_circ`; any other point is an interior `d`-point at distance `1` from `z`). Clause 1: `O = ball w ε \ B̄(P, 1)`
with `ε` from `outerColours P w = {c'}`, `z ∈ region c'` near `y` off the finitely many unit-arc centres near `w`, the meeting point from `u·e(ψ) > u·d`.
Clause 2: `O = ball w ε ∩ B(P, 1)` from `innerColours P w = {c}`, the meeting point from transversality (`y ∉ {P, P + 2e(θ)}`). Clause 3: for `t ∈ T`
with `|t − y| < δ` and `|t − P| < 2`, the point `t + (P − t)/|P − t|` of `ω(t)` lies in `B(P, 1)` within `(2 − |t − P|) + |e(arg(t − P)) − e(θ)|` of `w`, so in
clause 2's `O`; perturb `t` inside the open set `T ∩ ball y δ ∩ ball P 2` off the unit-arc centres.

**Tools.** `tools/fs131_i4_addrecords.py` now reads `Plane/ValidMap/Sectors` too and has `--check` (planted: `--plant --check` exit 1; clean exit 0);
`data/fs131/i4/errs.sh` (compact error digest over `iter.sh`, iteration only). Records: 245 names, 0 missing; `tools/fs131_k4_decls.py --check` 164 names,
0 missing; `tools/check_architecture.py` PASS (new row `Plane/ValidMap/Sectors`; SVMap's Imports cell `Plane/ValidMap/Sectors, …`; BaseSteps' gains
`Plane/SVMap`). **No statement changed but `lock`'s clause 3 (ruled, item 177); no new axiom, no `native_decide`.** Build of this stage: "build: OK — 444 of 444
batches, 6 module(s) rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T160421Z-559067.log`; driver log
`data/fs131/i4/build-i4d-stage8.log`): 50 `declaration uses sorry` warnings, and three linter warnings in `UnitArc` older than this stage (l. 236 unused
`hF`, ll. 666, 706 `push_cast` does nothing) that the gate's zero-warning count will need cleared. `Sectors`, `SVMap` build with no warning. Axioms printed
against that build's oleans (`data/fs131/i4/axioms-i4d.txt`): every new theorem the standard three.

**What is left (50) and the order I would take it.** Contact 10: `clear_of_subset_interior_allowedCone`, `woodallCone`, `woodallCone_strict` (now has
`isSector_cone_or_horn` — every `c`-sector with empty-interior allowed cone is a horn), `flank_shadows`, `shaveAvailable_of_not_doublyShadowed`, `exists_shave`,
`exists_rayMerge`, `exists_merge`, `stuck_structure`, `stuck_chain`. UnitArc 20: `lock` (route above), `l60_le`, `noBoth`, `u1_shadow`, `l60_eq_inner`,
`l60_eq_outer`, `l60_eq_corners`, `l60Col_locallyConstant`, `l60_real`, `n2_env_toward`, `n2_env_away`, `n2_env_near`, `n2_env_near_away`, `bend_toward`,
`bend_away`, `bend_away_whole`, `flankQ_upper`, `flankQ_lower`, `a4six`, `nb4p`. BaseSteps 20: `pair_i`, `pair_ii`, `pair_P'`, `fail_leavingCentre`,
`fail_colours`, `anti`, `n3_end`, `bowtieCol_locallyConstant`, `bowtie_valid`, `bowtie_mem_dom`, `bowtie_coloursAt_zero`, `bowtie_isHorn`, `bowtie_flanks`,
`bowtie_doublyShadowed`, `bowtie_inType`, `bowtie_neighbours`, `bowtie_isStuck`, `bowtie_terminalOn`, `bowtie_unitArcEnds`, `flank_incomplete_bowtie`.
Next: `lock` (one engine, three clauses); then the bowtie near `E = 0`, which is `cuspFrag`'s partition again — near `0` the bowtie's tiles are
`G ∩ ball`, `H ∩ ball` and the horns, its arcs there only the two unit arcs (every one of its 28 segments has both ends with `|re| ≥ 1/13` or
`|im| ≥ 1/13` on one side), so `bowtie_isHorn`, `bowtie_flanks` and `bowtie_coloursAt_zero` follow the pattern of `cuspFrag_isHorn`; `bowtie_mem_dom` needs
`B(x, ρ) ⊆ closure bowtieTiles` at `0`, `±i` (a ball minus finitely many lines and circles lies in the tiles, and that complement is dense).

## Stage 9 — SAVED (FS131-I4e): readback, the as-given build

*FS131-I4e (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4e-wave4.md` on `main`) continues this record from `c1255fc5`.*

**The brief's three quotations against their sources** (standing rule 3): (1) "**It may**: add children anywhere in the wave's modules — the seven engines and
every child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2 (line 887): **matches as a truncation**. (2) "**The
merge** (`05968b36`): `origin/main` at `cff2c33e` (`localSectors` landed, item 171) into `fs131-w4`. One conflict, at the append point of" — this record, Stage 8's
first paragraph: **matches as a truncation**. (3) "177. **FS131-I4d mid-job, on `ArcMap.lock`** (FS112-LOCK; `fs131-w4`, `Plane/ValidMap/UnitArc.lean`): (1)
**clause 1 closes with no N-E2** — `IsRingArc`'s" — `plans/FS131-close-inventory.md` on `main`, item 177 (line 1229): **matches as a truncation**; the item's
ruling (clause 3 local, `∃ δ > 0, Disjoint (T ∩ ball (P + 2e(θ)) δ) (ball P 2)`) reads as the brief summarizes it. One small mismatch in the brief's prose (not a
quotation): the older linter warnings sit at `UnitArc` lines 236 (unused `hF`), 666 and 706 (`push_cast` does nothing), not "near 234 and 236; 664 and 666".

**What I may change** (§ 14.2, unchanged from Stages 1, 5, 7): add children anywhere in the wave's modules (the seven engines in `Basic`, sorry-free, with spec
examples; every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's
`Plane/Chord`, `Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`, then
`tools/fs131_k4_decls.py --check`); `Plane/ValidMap/Sectors` (the bridge module, mine to extend); wave 4's vacuity carriers at the gate, `AeProperRegions` among
them (item 144); the four older linter warnings cleared. **What I may not change**: any statement of §§ 3.2, 7.2, 8.2, 12.2 (`lock`'s clause 3 is already in
its ruled local form, item 177); any definition of `Plane/ValidMap/Basic`; the fragments' definitions (`bowtie*`, `l60*`, `isoY`, `isoFrag`, `sevenBrick*`) but
for a coordinate slip found against the source tool (a finding); the read-backs' conventions; TS-T's Condition-5 clause stays in its carried form (item 142);
no new `axiom`, no `native_decide`. A leaf that cannot be proved as written goes to Keryx at once with the declaration, the reason and the counterexample or
the missing hypothesis; if one of `lock`'s consumers (the three bends) needs more than the local clause 3, that is a message too.

**The worktree as given** (`c1255fc5`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T161716Z-654577.log`; driver log
`data/fs131/i4/build-i4e-readback.log`). 50 `declaration uses sorry` warnings — Contact 10, UnitArc 20, BaseSteps 20 — and the three older linter warnings above.

## Stage 10 — SAVED (FS131-I4e): `lock` (three clauses, one engine), the bowtie at `E` (three leaves), `UnitArc`'s linter warnings cleared; 46 `sorry` left

**`lock` (FS112-LOCK) proved** (`UnitArc`), statement as ruled (item 177), no consumer needed more than the local clause 3 (it has none in the library). The
engine is one child, `Valid.dist_ne_one_of_isOpen_subset_closure`: *a point `a` of the closure of the class of `d` is never at distance `1` from a point `q`
of an open set `O ⊆ closure (region d)* — a short radial segment through `q` toward and away from `a`, inside `O`, crosses `ω(a)`, and wave 3's crossing engine
`Valid.false_of_crossing` refutes it. No finite-arc or centre-avoiding argument is needed (I4d's route perturbed `z` off unit-arc centres; the crossing engine
makes that unnecessary). The open sets are wave 3's `side_ball_subset_closure` patches at `w = r(θ)`: `ball w ε \ B̄(P, 1) ⊆ cl(region c')` (from
`outerColours P w = {c'}`) and `ball w ε ∩ B(P, 1) ⊆ cl(region c)` (from `innerColours P w = {c}`). The point `q`: for `y ∈ ω(w)`, `q = w + (w − y)(e s − 1)` is on
`ω(y)`, `|q − w| = |e s − 1|`, `|q − P| = |1 + ζ(e s − 1)|` with `ζ = conj(w − P)(w − y)` (`unit_circle_turn`), and
`|1 + ζ(e s − 1)|² = 1 + 2(1 − cos s)(1 − Re ζ) − 2 Im ζ sin s` (`sq_norm_one_add_mul_e_sub_one`). Clause 1 (`y ≠ P` ⟺ `ζ ≠ 1`, so `Re ζ < 1`): the sign of `s`
against `Im ζ` makes the square `> 1` (`exists_e_outside`). Clause 2 (`y ∉ {P, P + 2e(θ)}` ⟺ `ζ ≠ ±1` ⟺ `Im ζ ≠ 0`, transversality): `s = ±min(ε/2, 1, |Im ζ|/4)`
makes it `< 1` (`exists_e_inside`; `1 − cos s ≤ s²/2`, Jordan's `sin s ≥ 2s/π`). Clause 3: for `t ∈ T` within `δ = min(ε/4, 1)` of `P + 2e(θ)` and inside
`B(P, 2)`, the point `q = t + (P − t)/|P − t|` of `ω(t)` has `|q − P| = |t − P| − 1 < 1` and `|q − w| ≤ 3|t − (P + 2e(θ))| < ε`, so it lies in the inner patch,
against the engine with `a = t`. Children: `sq_norm_one_add_mul_e_sub_one`, `re_lt_one_of_norm_eq_one`, `norm_e_sub_one_le`, `exists_e_outside`,
`exists_e_inside` (top level), `Valid.dist_ne_one_of_isOpen_subset_closure`, `unit_circle_turn` (`ArcMap`). Elaborated on the third pass (two linear-combination
coefficient slips, one `abs_le` for `abs_lt`).

**The bowtie at `E = 0`** (`BaseSteps`): `bowtie_isHorn`, `bowtie_flanks`, `bowtie_coloursAt_zero` proved by the cusp pattern, as I4d planned. Within `1/13`
of `0` the bowtie's interior points are `cuspFrag`'s: `mem_bowtieArcs_iff_of_norm_lt` (a point of `B(0, 1/13)` is on a boundary piece iff it is on `ω(i)` or
`ω(−i)`: each of the 28 segments lies in a half-plane `re ≥ 1/13`, `re ≤ −1/13`, `im ≥ 1/13` or `im ≤ −1/13` — `norm_ge_of_mem_segment_far`, each case closed
by `norm_num [pt]` — and a point of `ω(±i)` there lies on the unit arc at angle `3π/2 + arcsin(re z)`, resp. `π/2 − arcsin(re z)`: `mem_bowtieArc_N`,
`mem_bowtieArc_S`), and `B(0, 1/13) ⊆ bowtie.dom` (`ball_subset_bowtie_dom`: the two unit circles are closed with empty interior, so their complement is dense,
and off them the ball lies in `G ∪ H ∪ C` — `cuspPiece_subset_bowtie`). So `bowtie_partition`: for `r ≤ 1/13`, `bowtie.interiorPts ∩ B(0, r)` is the four
`cuspPiece r i`; colours `1, 1, 0, 2` on them (`bowtieCol_of_mem_C/G/H`, `bowtieCol_cuspPiece`); each piece a sector (`bowtie_isSector_cuspPiece`); the horn along
`e π` is the left piece (`hornSet_cusp_pi_eq`, with `e_pi_add_pi_div_two`); the flanks' horn sets lie in the disc parts (`cuspPiece_subset_bowtie_region`).
`HasSectors 0 1 2`: the colour-`1` sectors are exactly the two horns (`Set.encard_pair`). In `Plane/ValidMap/Sectors`, `cuspFrag_isHorn`'s partition data is
now the lemma `cuspPiece_data` (open, preconnected, disjoint, non-empty, `0` in each closure), and `cuspFrag_isHorn` reads it (statement unchanged).

**Linter warnings.** `UnitArc`'s three older warnings are cleared: two `push_cast` that did nothing removed; `l60_eq_third`'s unused validity hypothesis is now the
binder `_hF` (its type, so the statement, is unchanged; it records that the proof does not read validity) — say if a binder rename counts as a statement edit
and I will restore `hF` with a different fix.

**Axioms** (`#print axioms` against this stage's build's oleans, `data/fs131/i4/axioms-i4e.txt`, not a gate log): `lock` and its seven children, `cuspPiece_data`,
`cuspFrag_isHorn`, `l60_eq_third` — the standard three. The bowtie's theorems read `sorryAx`, only because the structure `bowtie` carries
`bowtieCol_locallyConstant` (still `sorry`) in its `locallyConstant` field; every bowtie theorem will read clean once that leaf lands.

**Records**: `tools/fs131_i4_addrecords.py` — 268 names, 0 missing; `tools/fs131_k4_decls.py --check` — 186 names, 0 missing. No import changed. **No statement changed,
no new axiom, no `native_decide`.** Build of this stage: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s) with warnings", exit 0
(`build/gate/build/20261004T163756Z-794707.log`; driver log `data/fs131/i4/build-i4e-stage10.log`): 46 distinct `declaration uses sorry` (Contact 10,
UnitArc 19, BaseSteps 17), no other warning. (An earlier build of this stage, `build-i4e-lock.log`, failed because I edited `BaseSteps` while it ran and it
compiled a half-edited file; no edit was made during the stage's build.)

**Re-pricing.** `lock` (planned M) took about 25k tokens: one engine child and one unit-circle computation, three passes. The bowtie's three leaves at `E` (planned
M each) took about 35k together, most of it the twelve children that every later bowtie leaf at `E` reuses. The rest of the bowtie is heavier: `bowtie_mem_dom` at
`±i` and `bowtie_unitArcEnds` at `(±5/13, ±1/13)` need the same density argument with four lines (resp. a circle and lines) through each point;
`bowtieCol_locallyConstant` needs, for each of the 11 tiles, its colour under the if-chain (disjointness from earlier tiles) and `frontier T ⊆ ⋃ arcs` — then
a domain point off the arcs lies in the closure of one tile, hence in that tile; `bowtie_valid` needs the 21 same-colour tile pairs (G's diameter by the sector's
angle `2 arcsin(5/13) < 60°`; C–CN by `(z − i)·(a, b) < 0` for `z` below and `(a, b)` in the upward cone; the rest by coordinates).

## Stage 11 — SAVED (FS131-I4e): `bowtie_mem_dom`; 45 `sorry` left, and the handoff

**`bowtie_mem_dom` proved** (`BaseSteps`): `0` by `ball_subset_bowtie_dom` (stage 10); `±i` by the same density argument with the four tile-edge lines through
each point. Children: `interior_line_eq_empty` (a line `a·re + b·im = c`, `(a, b) ≠ 0`, has empty interior — moving along `(a, b)` changes the left side),
`isClosed_line`, `dense_compl_four_lines` (four such lines have a dense complement), `subset_bowtieTiles` (each tile in the union),
`ball_I_subset_closure_bowtieTiles` (off the lines `±12x + 5y = 5`, `x − y = −1`, `x + y = 1`, the ball `B(i, 1/10)` lies in `G ∪ CN ∪ XR ∪ XL`: case on
`12|x| < 5(1 − y)` (G), `|x| < y − 1` (CN), then the sign of `x`; `x = 0` forces `z = i`, which is on every line), `ball_negI_subset_closure_bowtieTiles` (the
mirror at `−i` with `H`, `CS`, `YR`, `YL`). Axioms (`data/fs131/i4/axioms-i4e.txt`): the children the standard three; `bowtie_mem_dom` reads `sorryAx` only
through the structure `bowtie` (stage 10's note).

**Records**: 274 names, 0 missing (`tools/fs131_i4_addrecords.py --check`); `tools/fs131_k4_decls.py --check` 192 names, 0 missing. **No statement changed, no new
axiom, no `native_decide`.** Build: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s) with warnings", exit 0
(`build/gate/build/20261004T165111Z-843230.log`; driver log `data/fs131/i4/build-i4e-stage11.log`): 45 distinct `declaration uses sorry`, no other warning.

**What is left (45), in the order I would take it.**
- *The bowtie* (BaseSteps, 9): `bowtieCol_locallyConstant` first — every bowtie theorem reads `sorryAx` through it. Route: for each of the 11 tiles, its colour
  under `bowtieCol`'s if-chain (each tile disjoint from the tiles tested before it; stage 10 did `G`, `C`, `H`) and `frontier T ⊆ ⋃ bowtieArcs` (closure by the
  non-strict inequalities, then which equality holds puts the point on a listed piece; `Z`'s left edge `x = 9/26` lies inside the excluded closed region, whose
  slanted edges are sub-segments of `G`'s and `H`'s edges through `(9/26, ±11/65)`); then a domain point off the arcs lies in the closure of one tile (finite union),
  hence in it, and the colour is constant on that open tile. Then `bowtie_valid` (YB3's pairs: one per colour class of tiles; `G`, `H` by the sector angle
  `2 arcsin(5/13) < 60°` — for `u, v` in the cone `12|x| < −5y`, `|u − v|² ≤ |u|² + |v|² − (238/169)|u||v| < 1`; `C`–`CN` because `(z − i)·(a, b) < 0` for `z`
  below and `(a, b)` in the upward cone, so `|z − w| > |z − i| > 1`; `ZR`–`ZL` all `< 1`, `XR`–`YR` all `> 1`; the rest by vertex distances of convex pieces).
  `bowtie_unitArcEnds` by the stage-11 density argument at `(±5/13, ±1/13)` (the circle and the lines `x = ±5/13`, `12|x| = 5(1 ∓ y)` through each end; around
  `(5/13, 1/13)` the tiles are `G`, `C`, `Z` — `C` lies below `G`'s edge line there, so `C ∩ Z = ∅`). `bowtie_neighbours`, `bowtie_inType`, `bowtie_isStuck`,
  `bowtie_doublyShadowed`, `bowtie_terminalOn`, `flank_incomplete_bowtie` need the partition at `±i` (four sectors `G`, `CN`, `XR`, `XL` at `i`) in stage 10's
  pattern, and the moves' unavailability.
- *UnitArc* (19): `u1_shadow` (plan § 13.5's route; `lock`'s engine and `side_ball_subset_closure` give the outer patch at `w`), the four `n2_env_*`
  (one identity each), engine 6 and L60's five, `noBoth`, `flankQ_upper/lower` (engine 5 over `isSector_cone_or_horn`), the bends (engines 1–3), `a4six` (engine 7),
  `nb4p`.
- *Contact* (10) and the base's steps (BaseSteps' seven) as Stage 8 lists them.

## Stage 12 — SAVED (FS131-I4f): readback, the as-given build

*FS131-I4f (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4f-wave4.md` on `main`) continues this record from `9a8de899`.*

**The brief's quotations against their sources** (standing rule 3). The brief says "four quotations"; it carries five, all checked: (1) "**It may**: add
children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md`
§ 14.2 (line 887): **matches as a truncation**. (2) "**What is left (45), in the order I would take it.**" — this record, Stage 11 (line 422): **matches**. (3) "- *The
bowtie* (BaseSteps, 9): `bowtieCol_locallyConstant` first — every bowtie theorem reads `sorryAx` through it. Route: for each of the 11 tiles, its colour" — Stage 11
(line 423): **matches as a truncation**. (4) item 177, "177. **FS131-I4d mid-job, on `ArcMap.lock`** … `IsRingArc`'s" — `plans/FS131-close-inventory.md` on `main`
(line 1229): **matches as a truncation**. (5) item 185, "185. **Ruling: `l60_eq_third`'s binder `hF` → `_hF` accepted** … silence the linter" — same file (line 1300):
**matches as a truncation**. The only mismatch is the count ("four" for five), a finding about the brief's prose, not about any quotation.

**What I may change** (§ 14.2, unchanged from Stages 1, 5, 7, 9): add children anywhere in the wave's modules (the seven engines in `Basic`, sorry-free, with spec
examples; every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's
`Plane/Chord`, `Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`, then
`tools/fs131_k4_decls.py --check`); `Plane/ValidMap/Sectors` (the bridge module); wave 4's vacuity carriers at the gate (`AeProperRegions` registered, item 144).
**What I may not change**: any statement of §§ 3.2, 7.2, 8.2, 12.2 (`lock`'s clause 3 stays in its ruled local form, item 177; `l60_eq_third`'s binder `_hF` is
accepted, item 185); any definition of `Plane/ValidMap/Basic`; the fragments' definitions (`bowtie*`, `l60*`, `isoY`, `isoFrag`, `sevenBrick*`) but for a coordinate
slip found against the source tool (a finding); the read-backs' conventions; TS-T's Condition-5 clause stays in its carried form (item 142); no new `axiom`, no
`native_decide`. A leaf that cannot be proved as written goes to Keryx at once with the declaration, the reason and the counterexample or the missing hypothesis.
No edit while a build of the edited file runs. A merge commit is the one commit made without paths.

**The worktree as given** (`9a8de899`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`), queued about 10 minutes
for the slot: "build: OK — all 1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T170918Z-955682.log`;
driver log `data/fs131/i4/build-i4f-readback.log`). 45 `declaration uses sorry` warnings — BaseSteps 16, Contact 10, UnitArc 19 — and no other warning.

## Stage 13 — SAVED (FS131-I4f): `bowtieCol_locallyConstant`, `bowtie_valid`, `bowtie_doublyShadowed`, `bowtie_inType`; 41 `sorry` left

**`bowtieCol_locallyConstant` proved** (`BaseSteps`), with no disjointness of tiles and no work on `Z±`: `bowtieCol` reads only membership in the nine open
tiles `G`, `C`, `CN`, `CS`, `H`, `X±`, `Y±` (`bowtieCol_eq_of_iff`), and membership in an open set `U` is eventually constant near a point off a set `A`
whenever `closure U ⊆ U ∪ A` (`eventually_mem_iff_of_closure_subset`). So the leaf is nine closure lemmas, `closure T ⊆ T ∪ ⋃ bowtieArcs` — each by
`closure_minimal` onto the non-strict inequalities, then the equality case put on a listed piece: a segment by explicit coordinates
(`mem_bowtieArcs_seg`, over `mem_segment_of_coords`), an arc of `ω(±i)` by `mem_bowtieArcN_of`/`mem_bowtieArcS_of` (I4e's `mem_bowtieArc_N/S` with the
hypothesis `‖z‖ < 1/13` weakened to `|re z| ≤ 5/13` and the side of the centre). `C`'s case `re z = 0` is the point `0`, on the arc of `ω(i)`; `X σ`, `Y σ` go
through `bowtieX_closure_cases`/`bowtieY_closure_cases` in the coordinate `u = σ re`. The route I4e planned (each tile's colour under the if-chain, then a domain
point in one tile) was not needed. Re-pricing: about 25k tokens, two passes (one `classical` missing for `ite`'s instance under `simp`, one `IsOpen` stated through
`unfold … ; refine … <;> fun_prop`).

**`bowtie_valid` proved** (YB3's pairs, by colour class): an interior point lies in one of the nine tiles or in `closure Z±` (`bowtie_interiorPts_cases`, from
the nine closure lemmas), and each colour comes from fixed tiles (`bowtieCol_cases`, by `split_ifs`). Colour `0`: two points of `G` are less than `1` apart
(`dist_lt_one_of_mem_bowtieG`: with `p = 1 − im`, `|re| < 5p/12` gives `|a₁b₁| ≤ (25/144)pq`; for `ra ≤ rb`, `pq ≥ (144/169)ra`, so the squared distance is at most
`rb − (69/169)ra < 1`). Colour `2`: `H` is `G`'s mirror under conjugation. Colour `1`: `C–C`, `CN–CN`, `CS–CS` by boxes; `C–CN` more than `1` apart (`CN` in the
upward cone at `i`, `C` below `i` outside `ω(i)`: `(z − i)·(w − i) < 0`), `C–CS` by conjugation; `CN–CS` by height. Colours `3`, `4`: `X σ`, `Y σ` boxes, `X–Y` by
height (`82/65 > 1`). Colour `5`: both points in the box `|re| ≤ 113/260`, `|im| ≤ 11/65` of `closure Z±`, squared distance at most `14705/16900 < 1`.

**`bowtie_inType` proved**: the contacts at `N = i` (colour `0`) and `S′ = −i` (colour `2`) — `i ∈ closure(region 0)` by the points `(1 − t) i` of `G`, which lie
on no boundary piece (`not_mem_bowtieArcs_near_I`: within `1/10` of `i` only `G`'s and `CN`'s edges through `i` are near, and a point strictly inside `G`'s cone
is on neither; all 30 pieces checked, each segment by `coords_of_mem_segment` and `linarith`); in-type because every tile of colour `0` lies in `G ⊆ B(0, 1)`
(`bowtieG_subset_ball`), of colour `2` in `H ⊆ B(0, 1)`. **`bowtie_doublyShadowed` proved** with the whole horn (`s₁ = −1`, `s₂ = 1`): for `‖z‖ < 1/20` outside
`ω(i)`, the point `y = z + (i − z)/‖z − i‖` is at distance exactly `1` from `z`, in `G` within `1/20` of `i`, so in the class `0`
(`mem_shadow_bowtie_region_zero`); the mirror at `−i` for the class `2`.

**Axioms** (`#print axioms` against this stage's build's oleans, `data/fs131/i4/axioms-i4f.txt`, not a gate log): the four leaves and their children the standard
three — and with `bowtieCol_locallyConstant` proved, the structure `bowtie` is sorry-free, so I4e's `bowtie_isHorn`, `bowtie_flanks`, `bowtie_coloursAt_zero`,
`bowtie_mem_dom` now read `[propext, Classical.choice, Quot.sound]` too.

**Records**: `tools/fs131_i4_addrecords.py` — 323 names, 49 added, 0 missing (negative control: `bowtie_valid`'s line deleted, `--check` exit 1 naming it;
restored, exit 0); `tools/fs131_k4_decls.py --check` 241 names, 0 missing. **No statement changed, no new axiom, no `native_decide`.** Build: "build: OK — 444 of
444 batches, 2 module(s) rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T172502Z-1035280.log`; driver log
`data/fs131/i4/build-i4f-stage13.log`): 41 distinct `declaration uses sorry` (BaseSteps 12, Contact 10, UnitArc 19), no other warning. (A first launch of this
build was stopped by its PID while it still waited for the slot, before it read any file, so that the edits could be finished first; nothing was built by it.)

## Stage 14 — SAVED (FS131-I4f): `bowtie_unitArcEnds`, `bowtie_neighbours`; 39 `sorry` left, and the handoff

**`bowtie_unitArcEnds` proved**: the two unit arcs' ends are `(±5/13, ±1/13)` (`bowtie_arc_ends`, from `sin(arcsin 5/13) = 5/13`, `cos = 12/13`), and each is in the
domain by I4e's density pattern with a circle and two lines (`interior_sphere_union_lines`, `subset_closure_of_diff_subset`): off `ω(i)`, `x = 5/13` and
`12x + 5y = 5`, the ball of radius `1/100` about `(5/13, 1/13)` lies in `G ∪ C ∪ ZR` (`bowtie_dom_end_pp`; `ZR` there is `x > 5/13` or `12x + 5y > 5`; outside
`ω(i)` with `x < 5/13` the point has `y < 1/13`, so it is in `C`); the three mirrors `_np`, `_pn`, `_nn` likewise. Every other boundary piece is a segment, so
the hypothesis `a = .circ p 1 θ₀ θ₁` is refuted by `simp`.

**`bowtie_neighbours` proved**, through one general lemma, `coloursAt_hasSectors_of_tiles` (any `ArcMap`): if near `v` the interior points are cut by `n` disjoint
convex open sets, each holding `v` in its closure and of one colour `c i`, `c` injective, then `P_cl(v) = range c` and each colour has exactly one sector (over
`isSector_iff_of_partition`); `coloursAt_hasSectors_of_four_tiles` is its four-named-tiles form. At `i` the four tiles are `G`, `CN`, `XR`, `XL`
(`bowtie_partition_I`, for `r ≤ 1/10`: an interior point there is in one of them by `bowtie_interiorPts_cases` and the heights of the others; conversely each
is in the domain and off every piece, by `mem_bowtieArcs_near_I` — within `1/10` of `i` a point of a piece is on one of the four edges through `i`), with colours
`0, 1, 3, 4` (`bowtieCol_of_mem_CN_CS`, `bowtieCol_of_mem_XY`), convex (`convex_bowtie_tiles`, each tile a disc and half-planes, `convex_halfPlane`), and `i`
in each closure along a ray (`mem_closure_of_ray`: `−i`, `i`, `1`, `−1`). At `−i` the mirror: `H`, `CS`, `YR`, `YL`, colours `2, 1, 3, 4`.

**Axioms** (`data/fs131/i4/axioms-i4f.txt`, against this stage's build's oleans, not a gate log): `bowtie_unitArcEnds`, `bowtie_neighbours` and their children the
standard three; no line of the file reads `sorryAx`. **Records**: `tools/fs131_i4_addrecords.py` — 341 names, 18 added, 0 missing; `tools/fs131_k4_decls.py
--check` 259 names, 0 missing. **No statement changed, no new axiom, no `native_decide`.** Build: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s)
with warnings", exit 0 (`build/gate/build/20261004T174227Z-1140038.log`; driver log `data/fs131/i4/build-i4f-stage14.log`): 39 distinct `declaration uses sorry`
(BaseSteps 10, Contact 10, UnitArc 19), no other warning.

**Re-pricing** (from the six bowtie leaves): each concrete-geometry leaf cost 10–25k tokens once its engine existed; the engines that the rest reuse are
`coords_of_mem_segment` (a point of a segment by its parameter — every "not on a boundary piece" check becomes 30 cases closed by `linarith`), the near-point
cases lemmas at `i`, `−i`, the closure lemmas of the nine tiles, and `coloursAt_hasSectors_of_tiles`.

**What is left (39), in the order I would take it.**
- *The bowtie's moves* (BaseSteps, 3): `bowtie_isStuck`, `bowtie_terminalOn`, `flank_incomplete_bowtie`. The easy halves: `¬ IsStuck (±i)` and `¬ MergeAvailable (±i)`
  — by `bowtie_neighbours` every colour has one sector there, and a colour not carried has none (a sector's closure holds the vertex, so its colour is carried);
  `¬ RayAvailable (±i)` — two disjoint horns of one colour would be two sectors of it. `flank_incomplete_bowtie`'s first clause: the contacts of `0` at `i` and
  `2` at `−i` are in-type (`bowtie_inType`) through a tile meeting `G` near `i` (the segment `(1 − t) i` is connected and in the interior points), so not out-type;
  `0` is no contact at `−i` (`region 0 ⊆ G ⊆ {im > 0}`), `2` none at `i`. The hard half, one engine for all three: **a horn at `E = 0` is one of the two cusp horns,
  and its flanks are `G` and `H`** — a horn set is a sector, so for small `r` it is one of `cuspPiece r i` (`bowtie_partition`, `isSector_iff_of_partition`); it is not
  a disc part (`cuspPiece r 2` contains points at angle `45°` at every radius, which a horn set between two tangent circles does not for small `r`); a flank band is
  open, non-empty, disjoint from the horn and on the horn's side of `0`, so it lies in a disc part, colour `0` or `2`. Then `¬ ShaveAvailable 0`: every horn point is
  in `shadow(region 0) ∩ shadow(region 2)` (`mem_shadow_bowtie_region_zero/two`), so neither flank colour is clear there. `¬ RayAvailable 0`: two disjoint colour-`1`
  horns along one `α` are the two cusp horns, one holding `t > 0` and one `−t`, both in `{frameX 0 α > 0}` — `t cos α > 0` and `−t cos α > 0`. `¬ MergeAvailable 0`:
  only colour `1` has two sectors; its contacts on `ω(0)` include `±i` (`CN`, `CS` near `±i`, from the partitions), both out-type (a tile of colour `1` is preconnected
  inside the separated open sets `C`, `CN`, `CS`, so inside one; holding `i` in its closure it is in `CN`, outside `B̄(0, 1)`), so the allowed cone is in `{im d = 0}`,
  with empty interior. At `±i`, `¬ ShaveAvailable` needs that no horn set is one of the four angular tiles (same 45°-type argument).
- *UnitArc* (19), *Contact* (10) and the base's steps (BaseSteps' seven: `pair_i`, `pair_ii`, `pair_P'`, `fail_leavingCentre`, `fail_colours`, `anti`, `n3_end`)
  as Stage 11 and Stage 8 list them. `n2_env_near` is not "one identity": it needs every point of the lens `B̄(A, 1) ∩ B̄(B, 1)` within `< 1` of a toward lens point
  near the arc, with the profile `s ≤ ψ·Δ(φ)` doing the work near the ends — a real estimate.

## Stage 15 — SAVED (FS131-I4g): readback, the as-given build

*FS131-I4g (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4g-wave4.md` on `main`) continues this record from `8a184ec1`.
Inventory ruling 194: this job takes `BaseSteps` and `UnitArc` only (29 leaves); `Contact` (10) is a parallel implementer's, and `Contact.lean` is not edited here.*

**The brief's six quotations against their sources** (standing rule 3): (1) "**It may**: add children anywhere in the wave's modules — the seven engines and every
child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2 (line 887): **matches as a truncation**. (2) "**What is left
(39), in the order I would take it.**" — this record, Stage 14 (line 527): **matches**. (3) "- *The bowtie's moves* (BaseSteps, 3): `bowtie_isStuck`,
`bowtie_terminalOn`, `flank_incomplete_bowtie`. The easy halves: `¬ IsStuck (±i)` and `¬ MergeAvailable (±i)`" — Stage 14 (line 528): **matches as a truncation**.
(4) item 194, "194. **Ruling: wave 4 splits by file** … Choice: the next wave-4 implementer" — `plans/FS131-close-inventory.md` on `main` (line 1358): **matches as a
truncation**. (5) item 177, "177. **FS131-I4d mid-job, on `ArcMap.lock`** … `IsRingArc`'s" — same file (line 1229): **matches as a truncation**. (6) item 185,
"185. **Ruling: `l60_eq_third`'s binder `hF` → `_hF` accepted** … silence the linter" — same file (line 1300): **matches as a truncation**. The source heading
the brief gives for (2)–(3) ("## Stage 14 — SAVED (FS131-I4f): `bowtie_unitArcEnds`, `bowtie_neighbours`; 39 `sorry` left, and the handoff") is this record's
line 501, verbatim. No mismatch.

**What I may change** (§ 14.2, unchanged from Stages 1, 5, 7, 9, 12): add children anywhere in the wave's modules (engines in `Basic`, sorry-free, with spec
examples; every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's
`Plane/Chord`, `Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`, then
`tools/fs131_k4_decls.py --check`); `Plane/ValidMap/Sectors`; wave 4's vacuity carriers at the gate (`AeProperRegions` registered, item 144). **What I may not
change**: any statement of §§ 3.2, 7.2, 8.2, 12.2 (`lock`'s clause 3 in its ruled local form, item 177; `l60_eq_third`'s binder `_hF`, item 185); any definition
of `Plane/ValidMap/Basic`; the fragments' definitions but for a coordinate slip found against the source tool (a finding); the read-backs' conventions; TS-T's
Condition-5 clause in its carried form (item 142); no new `axiom`, no `native_decide`; `Contact.lean` (ruling 194) except by merging the parallel branch. A leaf
that cannot be proved as written goes to Keryx at once. No edit while a build of the edited file runs. A merge commit is the one commit made without paths.

**The worktree as given** (`8a184ec1`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T175529Z-1222267.log`; driver log
`data/fs131/i4/build-i4g-readback.log`). 39 `declaration uses sorry` warnings — BaseSteps 10, Contact 10, UnitArc 19 — and no other warning.

## Stage 16 — SAVED (FS131-I4g): the bowtie's moves (`bowtie_isStuck`, `bowtie_terminalOn`, `flank_incomplete_bowtie`) and `u1_shadow`; 25 `sorry` left in `BaseSteps` and `UnitArc`

**The bowtie's moves, through one engine: a horn is tangent to its axis.** `eventually_ray_not_mem_hornSet` — a ray `v + t d` with `d` off `±e α` leaves
every horn set at `v` along `e α` for small `t` (in the frame, `κ₁ t N/2 < Im(d ē(α)) < κ₂ t N/2`); so two non-parallel rays are never both in a horn set
(`eventually_not_two_rays_hornSet`), and a horn set holding a whole unit ray points along it (`eq_e_of_ray_subset_hornSet`). A sector absorbs every preconnected
set of interior points it meets (`IsSector.subset_of_isPreconnected`), so a horn set that is a sector misses every convex set holding two non-parallel rays
(`IsSector.disjoint_of_rays`). **At `±i`**: the four tiles there (`G`, `CN`, `X±` at `i`; `H`, `CS`, `Y±` at `−i`) each hold two such rays, so **no horn at `±i`**
(`bowtie_not_isHorn_I/negI`) — no MERGE-RAY, no SHAVE — and every colour has at most one sector (`bowtie_hasSectors_le_one`, from `bowtie_neighbours` and
`HasSectors.eq_zero_of_not_mem`), so no MERGE and not stuck. **At `E = 0`**: the disc parts hold two rays each, so a horn set meets only the cusp horns, holds the
right one with `e α = 1` or the left with `e α = −1`, and lies outside `ω(±i)` (`bowtie_hornSet_zero`). No MERGE: only colour `1` has two sectors
(`bowtie_hasSectors_zero_two`), its tiles lie in `C`, `CN` or `CS` (`bowtie_tileOf_one`), so its contacts `±i` are out-type (`bowtie_outType_one`) and its allowed
cone lies in the line `im d = 0`. No MERGE-RAY: two disjoint horn sets along one axis would hold the same cusp horn. No SHAVE: a flank point is on the horn's side
(`frameX > 0`) and off the horn, so in a disc part (`bowtie_flank_colour`): `g, h ∈ {0, 2}`, and every horn point is in both shadows (I4f's
`mem_shadow_bowtie_region_zero/two`). `flank_incomplete_bowtie`'s first clause: at `i` (colour `0`) and `−i` (colour `2`) the in-type contact's tile is not
out-type; `0` is not carried at `−i`, `2` not at `i` (`bowtie_neighbours`). `BaseSteps` now imports `Plane/ValidMap/UnitArc` (for `exists_mem_hornSet_aboveBelow`,
the flank point; `n3_end` will need UnitArc's FLANK and `noBoth` too); `ARCHITECTURE.md`'s Imports cell updated, `tools/check_architecture.py` PASS.

**`u1_shadow` proved** (no validity read): pick `θ ∈ (θ₁, θ₂)` within `90°` of `β` (the midpoint of `(max θ₁ (β − 90°), min θ₂ (β + 90°))`), `w = r(θ)`; the outer patch
`ball w δ₁ \ B̄(P, 1) ⊆ cl(region c')` (wave 3's `side_ball_subset_closure`), a ball about `w` in the domain, and the finitely many arcs near `w`. A centre
`P + t e(β)` lies on the ray at one parameter (`rayParam`, with `rayParam_circ` and a spec example), so for small `t > 0` no arc near `w` is a unit arc about
`z = P + t e(β)`; the point `z + e θ = w + t e(β)` is outside `B̄(P, 1)` (`|t e(β) + e θ|² = 1 + t² + 2t cos(β − θ)`), an injective arc of `ω(z)` about it lies in
the patch, it meets the nearby arcs in finitely many points (`Arc.finite_inter_sphere_or_eq_circ`), and any other of its points is an interior point of colour `c'`
(`col_eq_of_mem_closure_region`) within `ε` of the arc, at distance `1` from `z`.

**Axioms** (`#print axioms` against this stage's build's oleans, `data/fs131/i4/axioms-i4g.lean` → `axioms-i4g.txt`, not a gate log): the four leaves and their 28
children, `[propext, Classical.choice, Quot.sound]`. **Records**: `tools/fs131_i4_addrecords.py` — 369 names, 28 added, 0 missing; `tools/fs131_k4_decls.py --check`
286 names, 0 missing. **No statement changed, no new axiom, no `native_decide`.** Build: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with
warnings", exit 0 (`build/gate/build/20261004T181925Z-1381684.log`; driver log `data/fs131/i4/build-i4g-stage16.log`): 35 distinct `declaration uses sorry`
(BaseSteps 7, Contact 10, UnitArc 18), no other warning. (`u1_shadow` was inserted into `UnitArc` while the build waited for the slot, before it read any file; no
edit was made during the build.)

**Re-pricing.** The three bowtie moves cost about 70k tokens with their engine (most of it the ray engine and the tile rays, each elaborated on the first or second
pass); `u1_shadow` (planned M) about 25k, two passes. The ray engine is general (any `ArcMap`, any horn) and serves `n3_end` and wave 5.

## Stage 17 — SAVED (FS131-I4g): `l60Col_locallyConstant` (so `l60Frag` is sorry-free); 24 `sorry` left in `BaseSteps` and `UnitArc`, and the handoff

**`l60Col_locallyConstant` proved.** The colouring reads three tests (in the lens `L`, `‖z‖ < 1`, `dist z 1 < 1/4`), so off the arcs each is locally constant: a
point of `L` off the arcs has `‖x − 1‖ < 1` and `‖x − e 60°‖ < 1` (a point of `ω(1)` in `B̄(e 60°, 1)` is on the side `1 + e([60°, 180°])`, `mem_l60_arc1`; of
`ω(e 60°)` in `B̄(1, 1)` on `e 60° + e([240°, 360°])`, `mem_l60_arc2`) and `‖x‖ ≠ 1` (`ω(0) ∩ L` is the arc `r([0, 60°])`, `mem_l60_arc0`); off `L`, `L` is closed
and `dist x 1 ≠ 1/4` (`mem_carrier_circ_full`). Each arc lemma is `arg` with a whole-turn shift (`mem_carrier_circ_of_arg`) and one cosine bound
(`cos_arg_sub`; `cos x ≥ 1/2` on `[−π, π]` gives `|x| ≤ π/3`, `abs_le_pi_div_three_of_cos`; `cos x ≤ −1/2` gives `|x| ≥ 2π/3`, `two_pi_div_three_le_abs_of_cos`).
The domain hypothesis is not read. With it the structure `l60Frag` is sorry-free (its `locallyConstant` field).

**Axioms** (`data/fs131/i4/axioms-i4g-17.lean` → `axioms-i4g-17.txt`, against this stage's build's oleans, not a gate log): the leaf and its ten children, the
standard three. **Records**: `tools/fs131_i4_addrecords.py` — 379 names, 10 added, 0 missing. **No statement changed** (against `8a184ec1` the only lines removed
from `UnitArc` and `BaseSteps` are five `sorry`s), no new axiom, no `native_decide`. Build: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s)
with warnings", exit 0 (`build/gate/build/20261004T182956Z-1435730.log`; driver log `data/fs131/i4/build-i4g-stage17.log`): 34 distinct `declaration uses sorry`
(BaseSteps 7, Contact 10, UnitArc 17), no other warning.

**What is left (24 in this job's files; `Contact`'s 10 are the parallel implementer's), in the order I would take it.**
- `l60_real` (UnitArc): `l60Frag` is now a sorry-free `ArcMap`; left are validity by the four classes (`Reul(0, A, B)` and the cap: constant width `1`, so interior
  pairs are `< 1` apart; the two discs of diameter `1/2`; cross-class pairs need nothing), `IsRingArc 0 0 (π/3) 0 1` (sides near an open-arc point: inside
  `B(0, 1)` the lens's colour `0`, outside colour `1`; the arc lies in `Γ` and the domain), and the thickening (`IsCompact.exists_thickening_subset_open` on the
  closed arc inside the open domain). Check the classes against `tools/fs114_l60_check.py` first. This stage's arc lemmas (`mem_l60_arc0/1/2`) serve the `Γ` side.
- `noBoth`: `c ≠ c′` is forced (`ringArc_cone_inner/outer` put the cones of `c` and `c′` at `P` in disjoint angle intervals, and a carried colour has a non-empty
  cone, `coneAt_nonempty`); `ringArc_sideCone_other` gives `d, d′ ∉ {c, c′}` in the two open side cones; `d ≠ d′` gives four colours. The work is `d = d′`: two
  sectors of `d` at `P`, separated by the `c`- and `c′`-directions — through the sector chart (`localSectors`, `IsSectorChart`; a sector's cone is the interval
  between consecutive germs or a horn), not a one-line step.
- The rest as Stage 11 lists them: the four `n2_env_*` (`n2_env_near` needs the lens estimate, Stage 14), engine 6 and `l60_le`, `l60_eq_inner/outer/corners`,
  `flankQ_upper/lower` (engine 5), engine 7 and `a4six`, engine 3 and the three bends, `nb4p` (re-read FS110-NB-4 first); `BaseSteps`' `pair_i`, `pair_ii`,
  `pair_P'`, `fail_leavingCentre`, `fail_colours`, `anti` (N3's proofs; read the derivation per leaf) and `n3_end` last — it needs `Contact`'s `woodallCone` and
  `exists_merge`, so `BaseSteps` must import `Plane/ValidMap/Contact` after the parallel branch merges.
- The ray engine of Stage 16 (`eventually_ray_not_mem_hornSet`, `eventually_not_two_rays_hornSet`, `eq_e_of_ray_subset_hornSet`, `IsSector.disjoint_of_rays`) is
  general and lives in `BaseSteps`; if `UnitArc` or `Contact` needs it (`flankQ_*`, engine 5, `woodallCone`), move it to `Plane/ValidMap/Basic` — a move, no
  statement change.

## Stage 18 — SAVED (FS131-I4h): readback, the as-given build

*FS131-I4h (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4h-wave4.md` on `main`) continues this record from `68f34f18`.
Inventory ruling 194: this job takes `BaseSteps` and `UnitArc` only (24 leaves); `Contact` (10) is a parallel implementer's, and `Contact.lean` is not edited here.*

**The brief's six quotations against their sources** (standing rule 3): (1) "**It may**: add children anywhere in the wave's modules — the seven engines and every
child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2 (line 887): **matches as a truncation**. (2) "**What is left
(24 in this job's files; `Contact`'s 10 are the parallel implementer's), in the order I would take it.**" — this record, Stage 17 (line 622): **matches**. (3) "- `l60_real`
(UnitArc): `l60Frag` is now a sorry-free `ArcMap`; left are validity by the four classes (`Reul(0, A, B)` and the cap: constant width `1`, so interior" — Stage 17
(line 623): **matches as a truncation**. (4) item 194, "194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two
sessions, 39 left). Choice: the next wave-4 implementer" — `plans/FS131-close-inventory.md` on `main` (line 1358): **matches as a truncation**. (5) item 177, "177.
**FS131-I4d mid-job, on `ArcMap.lock`** (FS112-LOCK; `fs131-w4`, `Plane/ValidMap/UnitArc.lean`): (1) **clause 1 closes with no N-E2** — `IsRingArc`'s" — same file
(line 1229): **matches as a truncation**. (6) item 185, "185. **Ruling: `l60_eq_third`'s binder `hF` → `_hF` accepted** (I4e's held question). Choice: accept.
Alternative weighed: restore `hF` and silence the linter" — same file (line 1300): **matches as a truncation**. The source heading the brief gives for (2)–(3) is
this record's line 607, verbatim. No mismatch.

**What I may change** (§ 14.2, unchanged from Stages 1, 5, 7, 9, 12, 15): add children anywhere in the wave's modules (engines in `Basic`, sorry-free, with spec
examples; every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's
`Plane/Chord`, `Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`, then
`tools/fs131_k4_decls.py --check`); `Plane/ValidMap/Sectors`; wave 4's vacuity carriers at the gate (`AeProperRegions` registered, item 144). **What I may not
change**: any statement of §§ 3.2, 7.2, 8.2, 12.2 (`lock`'s clause 3 in its ruled local form, item 177; `l60_eq_third`'s binder `_hF`, item 185); any definition
of `Plane/ValidMap/Basic`; the fragments' definitions but for a coordinate slip found against the source tool (a finding); the read-backs' conventions; TS-T's
Condition-5 clause in its carried form (item 142); no new `axiom`, no `native_decide`; `Contact.lean` (ruling 194) except by merging the parallel branch. A leaf
that cannot be proved as written goes to Keryx at once. No edit while a build of the edited file runs. A merge commit is the one commit made without paths.

**The worktree as given** (`68f34f18`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T184245Z-1494706.log`; driver log
`data/fs131/i4/build-i4h-readback.log`). 34 `declaration uses sorry` warnings — BaseSteps 7, Contact 10, UnitArc 17 — and no other warning.

## Stage 19 — SAVED (FS131-I4h): `l60_real`; 23 `sorry` left in `BaseSteps` and `UnitArc`

**`l60_real` proved**, by its three clauses. *Validity* by the four classes (`l60_interior_cases`): an interior point of colour `0` lies in the open Reuleaux
triangle on `0`, `1`, `e 60°`; of colour `1` in the open one on `1`, `e 60°`, `C = 1 + e 60°` (the cap `L ∖ B̄(0, 1)` lies in `B(C, 1)`, `l60_cap_mem_ball`, one
`nlinarith` certificate over the products of the three constraints); of colour `2` in `B(1, 1/4)`, of `3` in `B(e 60°, 1/4)`. **A Reuleaux triangle has diameter
`1`** (`dist_le_one_of_mem_reul`, general `X`, `Y`, `Z` pairwise `1` apart): for `d = p − q` some vertex `V` has `±d` in the cone spanned by the other two from `V`
(six cases on the signs of `d`'s Cramer coordinates in the basis `Y − X`, `Z − X`, `eq_cramer`), and then `|d| ≤ 1` by the vertex bound
(`norm_sub_le_one_of_cone`, through `reul_bound_real`: `|q − W|² ≤ 1 = |W − V|²` gives `2(q − V)·(W − V) ≥ |q − V|²`, so `d·(q − V) ≥ 0` and
`|d|² ≤ d·(p − V) ≤ |d|`); strictly inside, `< 1` (`dist_lt_one_of_mem_reul`, by pushing `p` outward along `p − q`). *The ring arc* (`l60Frag_isRingArc`): the
closed arc lies in the domain (`ringArc_l60_subset_dom`: its interior points in the open lens, its ends in the small open discs, by
`dist_ringPt_ringPt_cmp_one`), on the arc `.circ 0 1 0 (π/3)`; at an interior point the open lens `O` is a neighbourhood on which the colour is `0` inside
`B(0, 1)` and `1` outside `B̄(0, 1)`, so the sides are `{0}` and `{1}` (one inclusion by `mem_closure_iff` against `O`, the other by
`l60_closure_subset_region`: an open part of the domain of one colour is, up to closure, in that colour's class, by `dense_interiorPts` and
`IsOpen.inter_closure`). *The thickening*: `IsCompact.exists_thickening_subset_open`. Checked against `tools/fs114_l60_check.py` FRAG: not re-run — the proof is the
check (every pair class is proved, not probed).

**Axioms** (`data/fs131/i4/axioms-i4h-19.lean` → `axioms-i4h-19.txt`, against this stage's build's oleans, not a gate log): the leaf and its 15 children, the standard
three. **Records**: `tools/fs131_i4_addrecords.py` — 394 names, 15 added, 0 missing. **No statement changed** (the only line removed from `UnitArc` is one `sorry`),
no new axiom, no `native_decide`. Build: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings", exit 0
(`build/gate/build/20261004T190217Z-1602361.log`; driver log `data/fs131/i4/build-i4h-stage19.log`): 33 distinct `declaration uses sorry` (BaseSteps 7, Contact 10,
UnitArc 16), no other warning. The iteration scripts `data/fs131/i4/iter.sh`, `chk.sh` now take the scratch mirror from `S` (default unchanged), so two implementers
do not share one mirror; this job's is `/home/kooshi/scratch-w4h`.

**Re-pricing**: `l60_real` (planned M–H) cost about 45k tokens, five passes, most of them on `nlinarith` heartbeats — a real-coordinate core lemma per inequality
is the cure that worked.

## Stage 20 — SAVED (FS131-I4h): N2-ENV's `n2_env_near`, `n2_env_near_away`, `n2_env_toward`; 20 `sorry` left in `BaseSteps` and `UnitArc`

**The near clauses — one lens estimate, not one identity** (I4f's Stage-14 note confirmed). For `q = p − P` in the lens `B̄(e θ₁, 1) ∩ B̄(e θ₂, 1)`:
`|q|² ≤ 2 q·e θᵢ` at each end, and `sin(θ₂ − φ) e θ₁ + sin(φ − θ₁) e θ₂ = sin ℓ · e φ` (`sin_mul_e_add_sin_mul_e`), so
`sin ℓ · (q·e φ) ≥ (sin a + sin b)|q|²/2` (`lens_dot_ge`; `a = φ − θ₁`, `b = θ₂ − φ`). The sine gap `sin a + sin b − sin ℓ = sin a (1 − cos b) + sin b (1 − cos a)
≥ (2/π) min(a, b) (1 − cos(ℓ/2))` (`sin_add_sin_sub_sin_ge`, Jordan's `Real.mul_le_sin`) makes the profile linear in `Δ = min(a, b)`: **toward near**, with
`ψ = (1 − cos(ℓ/2))/π`, `(1 − s)(sin a + sin b) ≥ sin ℓ`, so `|q − (1 − s)e φ|² ≤ (1 − s)² < 1` (`n2_env_near_core`); **away near** off `B(P, r)`, with
`ψ = min(1, c r²)/3`, `c = (1 − cos(ℓ/2))/π`: `|q − (1 + s)e φ|² ≤ (1 + s)² − (2cΔ + s) r² < 1` (`n2_env_near_away_core`). Shared: `n2_env_data`,
`sq_norm_sub_ofReal_mul_e`.

**`n2_env_toward`**, with `ψ = min(1, r/9)`, in the frame of `φ` (`x = frameX P φ p`, `y = frameY P φ p`; `frame_polar_add` puts `P + ρ e(φ + t)` at
`(ρ cos t, ρ sin t)`), on the symmetric sub-arc `[φ − Δ, φ + Δ]`: a point in the arc's directions (`|y| cos Δ ≤ x sin Δ`) is covered by the ring point in its own
direction (`exists_dir_of_within`, through `arctan(y/x)`) since `0 < |p − P| ≤ 2 − s`; off them, on the side `y ≥ 0` (the other by `y ↦ −y`, `t = −Δ`), the end
condition at `φ + Δ` and the disc give `x² + y² ≤ 72ψ² < r²` (`n2_env_toward_core`): behind (`x ≤ 0`) `|x| ≤ s`, `y sin Δ ≤ 2s`; beside (`x > 0`,
`n2_env_toward_beside`) the direction is at least `45°` off `φ` (`toward_dir45`: `(ρ² − 2(1 − s)x)ρ² − (4U² − 4(1 − s)Ux) = (ρ² − 2U)(ρ² + 2U − 2(1 − s)x) ≥ 0`
with `U = x cos Δ + y sin Δ ≥ x`, so `2Ux ≤ ρ²`, `x ≤ y`), and then `y (sin Δ − (1 − cos Δ)) ≤ U − x ≤ s`, `sin Δ − (1 − cos Δ) ≥ Δ/6`.

**Axioms** (`data/fs131/i4/axioms-i4h-20.lean` → `axioms-i4h-20.txt`, against this stage's build's oleans, not a gate log): the three leaves and their 12 children, the
standard three. **Records**: `tools/fs131_i4_addrecords.py` — 406 names, 12 added, 0 missing. **No statement changed** (the only lines removed from `UnitArc` are
three `sorry`s; `n2_env_toward`'s unused binder `h12` is referenced by `have _ := h12`, the file's existing pattern, not renamed). No new axiom, no `native_decide`.
Build: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T191331Z-1651956.log`; driver log
`data/fs131/i4/build-i4h-stage20.log`): 30 distinct `declaration uses sorry` (BaseSteps 7, Contact 10, UnitArc 13), no other warning.

**Re-pricing**: the three leaves (planned M–H each) cost about 60k tokens together. Every failure was `nlinarith` heartbeats in a large context, cured by a
real-variable core lemma per inequality and explicit `mul_le_mul` steps.

## Stage 21 — SAVED (FS131-I4h): `n2_env_away` (so N2-ENV is sorry-free); 19 `sorry` left in `BaseSteps` and `UnitArc`, and the handoff

**`n2_env_away` proved**, with `ψ = min(1/2, r/4)`, on the whole arc (not a symmetric sub-arc: an away point beyond `φ + Δ` but inside the arc's directions is
covered only near `R₂`, so the reduction the toward bend uses loses there). In the frame of `φ`, the disc and the condition at `θ = φ` give `x ≥ 1 + s/2`, so
`|p − P|² ≥ 2 + s`; `p = P + ρ e(φ + t)` with `|t| < 90°` (`eq_polar_of_frameX_pos`, through `arctan(y/x)`). **In the arc's directions** (`−a ≤ t ≤ b`) the
condition at `φ + t` gives `ρ ≥ 2`, so `p` is within `ρ − 2 ≤ s < r` of `P + 2e(φ + t) ∈ R₂(ᾱ)`. **Beyond `θ₂`** (`t > b`), in the end's frame: `Y sin b ≤ s`
(`n2_env_away_height`), so `Y ≤ 2ψ`, `X ≥ 1`, and the end condition `(X − 1)² + Y² ≥ 1` gives `X ≥ 2 − Y²`, so `p` is within `√12 ψ < r` of `P + 2e θ₂`
(`n2_env_away_core`, `n2_env_away_end`). Beyond `θ₁`, the mirror (`Y ↦ −Y`).

**Axioms** (`data/fs131/i4/axioms-i4h-21.lean` → `axioms-i4h-21.txt`, against this stage's build's oleans, not a gate log): the leaf and its four children, the standard
three. **Records**: `tools/fs131_i4_addrecords.py` — 410 names, 4 added, 0 missing. **No statement changed** (one `sorry` removed; `h12` referenced by
`have _ := h12`). Build: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T193948Z-1860590.log`;
driver log `data/fs131/i4/build-i4h-stage21.log`): 29 distinct `declaration uses sorry` (BaseSteps 7, Contact 10, UnitArc 12), no other warning.

**What is left (19 in this job's files; `Contact`'s are the parallel implementer's, FS131-IC1/IC2 on `fs131-w4c`), in the order I would take it.**
- *Engine 2*, `ringArcsWithin_of_Γ_subset`, **in `Plane/ValidMap/Basic` under exactly that name** (inventory item 218 (g), the coordinator's note to this job): the
  bends and `Contact`'s three moves both need it; whichever implementer reaches it first writes it, and `tools/fs131_qa1_dupes.py` deletes an identical copy at the
  merge. This job did not reach it.
- *Engine 6* (`IsRingArc.side_dist_le_one`) and `l60_le`, `l60_eq_inner`, `l60_eq_outer`, `l60_eq_corners`. This stage's Reuleaux lemmas are general
  (`dist_le_one_of_mem_reul`, `dist_lt_one_of_mem_reul`, the vertex bound `norm_sub_le_one_of_cone`) and the lens estimate `lens_dot_ge` (`B̄(A, 1) ∩ B̄(B, 1)` against
  directions between the ends) is the trigonometric half of L60-EQ's `L ∩ ω(P) = ᾱ` child.
- *The bends* (`bend_toward`, `bend_away`, `bend_away_whole` over it): N2-ENV is now sorry-free (all four, with explicit profiles: toward `ψ = min(1, r/9)`,
  away `ψ = min(1/2, r/4)`, near `(1 − cos(ℓ/2))/π`, near-away `min(1, c r²)/3`); left are engines 1–3 and the clearness.
- `noBoth` (the sector chart: two sectors of `d` at `P` separated by the `c`- and `c′`-directions); `flankQ_upper`/`flankQ_lower` (engine 5; Contact's
  `woodallCone` is now proved on `fs131-w4c`); engine 7 and `a4six`; `nb4p` (re-read FS110-NB-4 first).
- `BaseSteps`' `pair_i`, `pair_ii`, `pair_P'`, `fail_leavingCentre`, `fail_colours`, `anti` (N3's proofs; read the derivation per leaf), and `n3_end` last, after
  `fs131-w4c` merges (it needs `woodallCone` and `exists_merge`).
- **Technique**, measured on all five leaves of this job: `nlinarith` in a declaration with a large context runs out of heartbeats even when the certificate is
  small, and a whole declaration has one heartbeat budget. State each inequality as a real-variable lemma with only its hypotheses (here `reul_bound_real`,
  `n2_env_near_core`, `toward_dir45`, `n2_env_away_core`), and use `mul_le_mul…` and `pow_le_pow_iff_left₀` for the steps `nlinarith` would search for.

## Stage 22 — SAVED (FS131-I4i): readback, the as-given build

*FS131-I4i (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4i-wave4.md` on `main`) continues this record from `22820927`.
Inventory ruling 194: this job takes `BaseSteps` and `UnitArc` only (19 leaves); `Contact` (10 `sorry` lines here, 6 left on `fs131-w4c`) is FS131-IC2's,
and `Contact.lean` is not edited here except by merging that branch.*

**The brief's six quotations against their sources** (standing rule 3): (1) "**It may**: add children anywhere in the wave's modules — the seven engines and every
child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2 (line 887): **matches as a truncation**. (2) "**What is left
(19 in this job's files; `Contact`'s are the parallel implementer's, FS131-IC1/IC2 on `fs131-w4c`), in the order I would take it.**" — this record, Stage 21
(line 734): **matches**. (3) "- *Engine 2*, `ringArcsWithin_of_Γ_subset`, **in `Plane/ValidMap/Basic` under exactly that name** (inventory item 218 (g), the
coordinator's note to this job): the" — Stage 21 (line 735): **matches as a truncation**. (4) item 194, "194. **Ruling: wave 4 splits by file** (item 191's condition
met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4 implementer" — `plans/FS131-close-inventory.md` on `main` (line 1358):
**matches as a truncation**. (5) item 177 — same file (line 1229): **matches as a truncation**. (6) item 185 — same file (line 1300): **matches as a truncation**.
The source heading the brief gives for (2)–(3) is this record's line 720, verbatim. No mismatch.

**What I may change** (§ 14.2, unchanged from Stages 1, 5, 7, 9, 12, 15, 18): add children anywhere in the wave's modules (engines in `Basic`, sorry-free, with spec
examples; every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's
`Plane/Chord`, `Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`, then
`tools/fs131_k4_decls.py --check`); `Plane/ValidMap/Sectors`; wave 4's vacuity carriers at the gate (`AeProperRegions` registered, item 144). **What I may not
change**: any statement of §§ 3.2, 7.2, 8.2, 12.2 (`lock`'s clause 3 in its ruled local form, item 177; `l60_eq_third`'s binder `_hF`, item 185); any definition
of `Plane/ValidMap/Basic`; the fragments' definitions but for a coordinate slip found against the source tool (a finding); the read-backs' conventions; TS-T's
Condition-5 clause in its carried form (item 142); no new `axiom`, no `native_decide`; `Contact.lean` (ruling 194) except by merging the parallel branch. Engine 2
goes in `Plane/ValidMap/Basic` under exactly the name `ringArcsWithin_of_Γ_subset` (item 218 (g)). A leaf that cannot be proved as written goes to Keryx at once.
No edit while a build of the edited file runs. A merge commit is the one commit made without paths.

**The worktree as given** (`22820927`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T195230Z-1910844.log`; driver log
`data/fs131/i4/build-i4i-readback.log`). 29 `declaration uses sorry` warnings — BaseSteps 7, Contact 10, UnitArc 12 — and no other warning. This job's scratch
mirror for `iter.sh`/`chk.sh` is `S=/home/kooshi/scratch-w4i`.

## Stage 23 — SAVED (FS131-I4i): engine 2 (`ringArcsWithin_of_Γ_subset`, in `Plane/ValidMap/Basic`); 19 `sorry` left in `BaseSteps` and `UnitArc`

**Engine 2 written, under exactly the name item 218 (g) fixes**, in `Plane/ValidMap/Basic` § Engines 1–2:
`ringArcsWithin_of_Γ_subset (hdom : F'.dom = F.dom) {A' : Set Arc} (hnd : ∀ a ∈ A', a.Nondegenerate) (hlf : ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x,
{a | a ∈ A' ∧ (a.carrier ∩ t).Nonempty}.Finite) (hunit : ∀ a ∈ A', ¬ a.IsUnitArc) (hΓ : F'.Γ ⊆ F.Γ ∪ ⋃ a ∈ A', a.carrier) :
F'.RingArcsWithin F` — the plan's § 13.1 form, with `A'`'s non-degeneracy and local finiteness (on `F.dom`) as explicit hypotheses. Proof: a
sub-arc of `ω(p)` in `F'.Γ` is compact, so meets finitely many `A'`-arcs, each (non-degenerate, not a unit arc) in finitely many points of
`ω(p)` (`Arc.finite_inter_sphere_or_eq_circ`); off that finite set it lies in `F.Γ`; children `mem_closure_ringArc_diff_finite` (a point of a
positive-length sub-arc is a limit of its points off a finite set) and `ringArc_subset_Γ_of_finite` (`Γ` is closed in the domain). Spec
example: `segPlane` (one segment) creates no unit arc over the arc-free plane, through the engine; `unitArcPlane` is the existing adversary.
Iteration-checked with `data/fs131/i4/errs.sh` (`S=/home/kooshi/scratch-w4i`), then the build: "build: OK — 444 of 444 batches, 8 module(s)
rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T195613Z-1925227.log`; driver log `data/fs131/i4/build-i4i-engine2.log`):
29 distinct `declaration uses sorry` (BaseSteps 7, Contact 10, UnitArc 12), no other warning. **For the merge with `fs131-w4c`**: if FS131-IC2
writes its own copy, `tools/fs131_qa1_dupes.py` decides; this one's hypotheses are the plan's.

## Stage 24 — SAVED (FS131-I4i): `l60_le`, `noBoth`, `l60_eq_inner`, `l60_eq_outer`, `l60_eq_corners` — engine 6 not needed; 14 `sorry` left in `BaseSteps` and `UnitArc`

**L60 needs no chain (engine 6 is not written).** The crossing engine `Valid.dist_lt_or_gt_of_isPreconnected` on the open arc, which lies in the
closure of each side colour's class, does all of L60-LE and L60-EQ: a point of a side colour's class within `1` of one interior point of the arc is
within `1` of every interior point (and, by continuity, `≤ 1` of the ends). Route notes against the plan (§ 13.1 engine 6, § 13.5): its H
child is replaced by these short arguments, so the plan's critical path through engine 6 is gone.
- **`l60_le`**: if `ℓ > 60°`, two interior points of the arc `t ∈ (60°, min(ℓ, 180°))` apart are more than `1` apart (`dist_ringPt_ringPt_cmp_one`); an
  outer-class point near the first is within `1` of the second — contradiction.
- **`l60_eq_inner` / `l60_eq_outer`**: a side tile touching the open arc lies in `B(touch point, 1)` (`IsTile.subset_ball`), so within `1` of the closed
  arc (`dist_le_one_of_touch`); the lens of the ends meets `ω(P)` only in the arc (`mem_ringArc_of_lens`, rotating `mem_l60_arc0` by `norm_rot_sub`), which
  lies in `Γ`, so the tile misses `ω(P)` and, being connected, stays on its side (`IsPreconnected.subset_left_of_subset_union`); outside, the closed cap
  `B̄(A,1) ∩ B̄(B,1) ∖ B̄(P,1) ⊆ B̄(C,1)` (`l60_cap_mem_closedBall`, the closed form of I4h's `l60_cap_mem_ball`, rotated by `l60_cap_general`).
- **`l60_eq_corners`**: over the two containments, `cos_nonneg_of_mem_coneAt` (wave 3) and its new mirror `cos_nonpos_of_mem_coneAt` at the centre and the
  other end, and `mem_angleIcc_of_two_cos` (two closed half-turns `0 < a₂ − a₁ < π` meet in `[a₂ − 90°, a₁ + 90°]`, by
  `sin(a₂ − a₁) cos(β − θ) = sin(a₂ − θ) cos(β − a₁) + sin(θ − a₁) cos(β − a₂)` into `mem_angleIcc_of_cos_nonneg`). The outer cone at each end reads `B̄(P, 1)`'s
  complement and the other end's disc; `C` is not needed for the cones.
- **`noBoth`**: § 4.19's route in the sector chart. The side colours differ (`disj_lifts`), the side cones hold colours `d₁`, `d₂ ∉ {c, c'}`
  (`ringArc_sideCone_other`); at most three colours forces `d₁ = d₂ = d`; in the chart (`localSectors`, a germ since two colours) each of the two side
  directions lies in the cone of a `d`-sector (`IsSectorChart.exists_sector_of_mem_coneAt_region`, new in `Sectors`); one sector holding both would hold a
  half-turn in its open interval (`angleIcc_half_turn`), hence the inner or the outer colour's direction (`coneAt_region_nonempty`, new in `Sectors`),
  against `BranchGerms.Mono.disjoint`; so `d` has two sectors at every radius `≤ r₀` — a repeated colour.

**Moves and imports.** `l60_eq_inner`, `l60_eq_outer`, `l60_eq_corners` (statements and docstrings verbatim, checked by script against `3f7ea033`) now sit
after the `l60Frag` helpers they read (`mem_l60_arc0`), under a new heading "L60-EQ: the containments and the corner cones"; `l60_eq_third` is unmoved.
`UnitArc` now imports `Plane/ValidMap/Sectors` (no cycle; `ARCHITECTURE.md`'s Imports cell updated, `tools/check_architecture.py` PASS).

**Axioms** (`data/fs131/i4/axioms-i4i-24.lean` → `axioms-i4i-24.txt`, against this stage's build's oleans, not a gate log): the five leaves, engine 2 and its
two children, `l60_eq_third` (no longer over `sorry`: wave 3's statements it reads are proved since `main`'s merge), and 13 further children — 22 records, all
`[propext, Classical.choice, Quot.sound]`, no `sorryAx`. **Records**: `tools/fs131_i4_addrecords.py` — 426 names, 16 added, 0 missing;
`tools/fs131_k4_decls.py --check` exit 0. **No statement changed**, no new axiom, no `native_decide`. Build: "build: OK — 444 of 444 batches, 5 module(s)
rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T201515Z-2044743.log`; driver log `data/fs131/i4/build-i4i-stage24.log`): 24 distinct
`declaration uses sorry` (BaseSteps 7, Contact 10, UnitArc 7), no other warning.

**Re-pricing**: engine 2 (planned M) and the five leaves (planned M, M, M over an H engine, M, M) cost about 90k tokens together, two iteration passes each;
reading for the structure the crossing engine already gives was the saving.

**What is left (14 in this job's files), in the order I would take it.**
- `pair_P'` (BaseSteps) is the nearest: at `dist u u' = 1`, every interior point near `u` has a colour of `c(u) = c(u')`, so by N-E1 (`ne1_region`) `ω(u')`
  near `u` lies in `Γ`; the work is a sub-arc of `ω(u')` from `u` with constant sides (a chart branch at `u` equal to `ω(u')`, by
  `Arc.finite_inter_sphere_or_eq_circ`, and its two adjacent sectors), then `noBoth` at `u'` against degree 3 with three colours.
- `a4six` over engine 7 (`exists_coveringPoint_of_window`) and `exists_shift_avoiding`; then `flankQ_upper`/`flankQ_lower` over engine 5.
- The bends (engines 1–3 and the clearness; N2-ENV is sorry-free); `nb4p` (re-read FS110-NB-4 first).
- `BaseSteps`' `pair_i`, `pair_ii`, `fail_leavingCentre`, `fail_colours`, `anti` read S–V's votes at a cubic trichromatic vertex: each needs the three
  germs at `u` from its chart (degree 3) and the second-order vote of a branch against `ω(q)`; a shared child "the germs of a cubic trichromatic
  vertex and their votes" is the first thing to state. `n3_end` last, after `fs131-w4c` merges (`woodallCone`, `exists_merge`).

## Stage 25 — SAVED (FS131-I4j): readback, the as-given build

*FS131-I4j (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4j-wave4.md` on `main`) continues this record from `e16f5b2c`.
Inventory ruling 194: this job takes `BaseSteps` and `UnitArc` only (14 leaves); `Contact` (10 `sorry` lines here) is FS131-IC3's on `fs131-w4c`, and
`Contact.lean` is not edited here except by merging that branch.*

**The brief's six quotations against their sources** (standing rule 3): (1) "**It may**: add children anywhere in the wave's modules — the seven engines and every
child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2 (line 887): **matches as a truncation**. (2) "**What is left
(14 in this job's files), in the order I would take it.**" — this record, Stage 24 (line 832): **matches**. (3) "- `pair_P'` (BaseSteps) is the nearest: at
`dist u u' = 1`, every interior point near `u` has a colour of `c(u) = c(u')`, so by N-E1 (`ne1_region`) `ω(u')`" — Stage 24 (line 833): **matches as a truncation**.
(4) item 194 — `plans/FS131-close-inventory.md` on `main` (line 1358): **matches as a truncation**. (5) item 177 — same file (line 1229): **matches as a truncation**.
(6) item 185 — same file (line 1300): **matches as a truncation**. The source heading the brief gives for (2)–(3) is this record's Stage 24 heading, verbatim.
No mismatch.

**What I may change** (§ 14.2, unchanged since Stage 1): add children anywhere in the wave's modules (engines in `Basic`, sorry-free, with spec examples; every
child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`, wave 1's `Plane/Chord`,
`Diameter`, `Basic`), statements unchanged; imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`, then
`tools/fs131_k4_decls.py --check`); `Plane/ValidMap/Sectors`; wave 4's vacuity carriers at the gate (`AeProperRegions` registered, item 144). **What I may not
change**: any statement of §§ 3.2, 7.2, 8.2, 12.2 (`lock`'s clause 3 in its ruled local form, item 177; `l60_eq_third`'s binder `_hF`, item 185); any definition
of `Plane/ValidMap/Basic`; the fragments' definitions but for a coordinate slip found against the source tool (a finding); the read-backs' conventions; TS-T's
Condition-5 clause in its carried form (item 142); no new `axiom`, no `native_decide`; `Contact.lean` (ruling 194) except by merging the parallel branch. A leaf
that cannot be proved as written goes to Keryx at once. No edit while a build of the edited file runs. A merge commit is the one commit made without paths.

**The worktree as given** (`e16f5b2c`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T202813Z-2139606.log`; driver log
`data/fs131/i4/build-i4j-readback.log`). 24 `declaration uses sorry` warnings — BaseSteps 7, Contact 10, UnitArc 7 — and no other warning. This job's scratch
mirror for `iter.sh`/`chk.sh`/`errs.sh` is `S=/home/kooshi/scratch-w4j`.

## Stage 26 — SAVED (FS131-I4j): the ring-arc engine and `pair_P'`; 13 `sorry` left in `BaseSteps` and `UnitArc`

**A ring arc inside every arc of `Γ` on a ring** (new children in `UnitArc`, section "Ring arcs from clean arcs of `Γ`", right after `noBoth`): every leaf
that must produce an `IsRingArc` (`pair_P'`, `pair_ii`, `fail_leavingCentre`, `flankQ_*`, `n3_end`) needs the side colours of an arc of `Γ` on `ω(p)`
to be constant, and nothing in waves 1–3 gave them. Two statements carry it:
- `isRingArc_of_clean` (**engine A**): a closed sub-arc of positive length of `ω(p)` in `Γ`, each of whose interior points has a ball in the domain in which
  every point of an arc lies on `ω(p)`, is an `IsRingArc`. Near `x = r(θ)` the inner side `B(x, δ) ∩ B(p, 1)` is convex; the outer side
  `B(x, δ) ∖ B̄(p, 1)` is joined to `p + (1 + δ/2) e(θ)` by a segment that stays outside (`outside_segment`, over the real inequality
  `outside_segment_real`, `δ ≤ 1/2`); both are interior points, so one colour each; the colour is locally constant in `θ`, so constant on `(θ₁, θ₂)`
  (`IsPreconnected.constant` with the discrete topology on `Fin k`).
- `exists_clean_subArc` (**engine B**): inside any sub-arc of positive length there is a clean one (finitely many arcs near one point; those not on `ω(p)`
  meet it finitely, `Arc.finite_inter_sphere_or_eq_circ`; a point off them, `mem_closure_ringArc_diff_finite`, and a ball missing their carriers).
  Combined: `exists_isRingArc_of_subset_Γ` — a closed sub-arc of `ω(p)` in `Γ` contains a sub-arc with constant sides.
Engine A takes local cleanliness as a hypothesis so that the consumers needing an arc **ending at a vertex** (`fail_leavingCentre`, engine 5) can supply it
from the vertex's sector chart (distinct branches never meet in the punctured ball) instead of from engine B.

**`pair_P'` (FS112-N3-PAIRS, N3-P′) proved.** Children in `BaseSteps` (new section before N3-PAIRS): `exists_ball_col_mem_coloursAt` (from `localSectors`: near a
point of the domain every interior point carries a colour of the point) and `IsCubicTrichromatic.not_hasRepeatedColour` (three sectors, three colours, so
the sector-to-colour map is injective, `Finset.card_image_iff`). The proof is the row's: at `dist u u' = 1`, `ω(u')` near `u` lies in `Γ` (an interior point
there would carry a colour of `c(u) = c(u')` at distance `1` from `u'`, N-E1); the engine gives a sub-arc with constant sides, both side colours colours
of `u`, hence of `u'`: both-kind at `u'`, so `noBoth` gives four colours (against `ncard = 3`) or a repeated colour (against the child).
**Binder rename, held for the coordinator**: the hypothesis that `u` is cubic trichromatic is not used (the proof reads only `u'`'s three colours and
three sectors, and `c(u) = c(u')`), so the binder `h` is now `_h` — the same rename as ruling 185's for `l60_eq_third`; the statement's type is unchanged
(diff against `e16f5b2c`: the one `-`/`+` pair is the binder).

**Records**: `tools/fs131_i4_addrecords.py` — 439 names, 13 added; `tools/fs131_k4_decls.py --check` exit 0. **Axioms** (`data/fs131/i4/axioms-i4j-26.lean` →
`axioms-i4j-26.txt`, against this stage's build's oleans, not a gate log): 14 records (the 13 children and `pair_P'`), all `[propext, Classical.choice,
Quot.sound]`. **No statement changed** (but the binder above), no new axiom, no `native_decide`, no new import. Build: "build: OK — 444 of 444 batches, 3
module(s) rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T204412Z-2240985.log`; driver log `data/fs131/i4/build-i4j-stage26.log`):
23 distinct `declaration uses sorry` (BaseSteps 6, Contact 10, UnitArc 7), no other warning.

**Re-pricing** (from this first leaf): the engine (planned nowhere; the plan's engine 5 assumed the ring arc would come from the horn's sectors) and
`pair_P'` cost about 60k tokens with one iteration pass each; the engine is the reusable part.

## Stage 27 — SAVED (FS131-I4j): `a4six` (engine 7 and the shift); 12 `sorry` left in `BaseSteps` and `UnitArc`

**`a4six` (FS112-A4SIX) proved**, on the plan's route (§ 13.5) with four new children in `UnitArc` just before it:
- `exists_shift_avoiding`: a measurable set of angles whose part in `[0, 2π)` has measure below `π/3` misses all six points `x + j·60°` of some `x`
  (else `[0, π/3)` is covered by six translates of its pieces in the six windows: `measure_biUnion_finset_le`, `measure_preimage_add_right`,
  `measure_biUnion_finset` on the disjoint windows).
- `isClosed_Γ_inter_sphere` (finitely many compact arcs meet a covered ring), so the angles of `Γ` on `ω(v)` are a closed, hence measurable, set;
  `countable_ringPt_preimage` (`e_eq_e_iff`), so the angles of the finitely many points of `Γ ∩ ω(v)` on no arc of `Γ` (wave 3's
  `finite_ringΓ_off_ringArc`) are null, and `arcLength {θ | OnRingArc}` below `π/3` bounds them all.
- `exists_coveringPoint_of_window` (**engine 7**): on a window whose interior points carry only `a`, `b`, with ends of colours `a`, `b` and no positive-length
  arc of `Γ` strictly inside, some point carries both — every window point is a limit of interior window points (an open sub-interval not in `Γ`), so the
  window is the union of the closed sets "carries `a`" and "carries `b`", and `isPreconnected_closed_iff` on `Icc`. The plan's sorted-list induction is not needed.
Then: the six window ends are interior points (one turn on is `x` again), of colours in the two absent at `v` (N-E1), consecutive ends `60°` apart are a unit pair
so of different colours; a window with no arc of `Γ` gives a point carrying both absent colours, a covering pair with `v`, against `hno`. `hab` is not read.
(`open MeasureTheory in` precedes the three declarations that use `volume`; no statement changed — checked by script against `e16f5b2c`, 102 statements.)

**Records**: 4 added (443 names); `tools/fs131_k4_decls.py --check` exit 0. **Axioms** (`data/fs131/i4/axioms-i4j-27.txt`, against this stage's oleans): the four
children and `a4six`, all `[propext, Classical.choice, Quot.sound]`. Build: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings",
exit 0 (`build/gate/build/20261004T205905Z-2360618.log`; driver log `data/fs131/i4/build-i4j-stage27.log`): 22 distinct `declaration uses sorry` (BaseSteps 6,
Contact 10, UnitArc 6), no other warning. Cost: about 25k tokens, one iteration pass.

## Stage 28 — SAVED (FS131-I4j): `bend_away_whole` over `bend_away`; 11 `sorry` left in `BaseSteps` and `UnitArc`, and the handoff

**`bend_away_whole` reduced to `bend_away`** (plan § 13.5: "E over `bend_away` (`r2Contacts` empty)"): an interval `[a, b] ⊆ C₂(ᾱ)` would put
`P + 2e(a) ∈ R₂(ᾱ)` in the closure of the inner class, against `hR2`. Its axioms read `sorryAx` through `bend_away` (`data/fs131/i4/axioms-i4j-28.txt`);
the leaf's own `sorry` is gone. Build: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings", exit 0
(`build/gate/build/20261004T210939Z-2417914.log`; driver log `data/fs131/i4/build-i4j-stage28.log`): 21 distinct `declaration uses sorry` (BaseSteps 6,
Contact 10, UnitArc 5), no other warning. `tools/fs131_k4_decls.py --check` exit 0 (no new declaration).

**What is left (11 in this job's files: UnitArc `bend_toward`, `bend_away`, `flankQ_upper`, `flankQ_lower`, `nb4p`; BaseSteps `pair_i`, `pair_ii`,
`fail_leavingCentre`, `fail_colours`, `anti`, `n3_end`), in the order I would take it.** Routes below are worked out on paper, not written in Lean.
- **`fail_leavingCentre`** (S–V Prop. 10's place, by votes). (a) A new `localSectors_disj` in `Plane/LocalStructure`: `localSectors`' proof already establishes
  that distinct germs never meet at one distance (its last bullet, `hr₃`) and hands it to `isSectorChart_of`; return it as a second conjunct and make
  `localSectors` its corollary (statement unchanged) — `IsSectorChart` does not carry it, and the cleanliness in (e) needs it. Editing `LocalStructure`
  rebuilds every plane module (price one long build). (b) The vote, a child: for an interior point `z` and a sector `i` of the chart at `u` bounded by a germ
  whose branch point `b` (at radius `δ`) has `|z − u| < 1 < |z − b|` (or `>`/`<` mirrored), the sector — preconnected, `u` and `b` in its closure (`b` because
  the sector's angular slice at radius `δ` opens just above the germ's direction, `dir_lt_nextDir`) — holds a point at distance exactly `1` from `z`, so
  `col z` is not the sector's colour. (c) At a cubic trichromatic `u` there are three germs and three sectors of the three colours (as in
  `IsCubicTrichromatic.not_hasRepeatedColour`); two distinct germs bound all three sectors, so two germs voting the same way give `StripHolds` on that side.
  Hence `¬ StripHolds u q` forces, for every `δ ∈ (0, r₀)`, a germ point `bp_k(δ) ∈ ω(q)`. (d) Four values of `δ`, three germs: one germ `k` has two zeros
  `s₁ ≠ s₂` of `cos(A + arcsin(κs/2)) + s/2` (`A = β_k − arg(u − q)`); squaring, `cos²A = s²(κ² − 2κ sin A + 1)/4 = s²((κ − sin A)² + cos²A)/4` at two values of
  `s`, so `cos A = 0`, `κ = sin A = ±1`, and then the whole branch is on `ω(q)`: `bp_k(s) = ringPt q (ψ ± 2 arcsin(s/2))`, `ψ = arg(u − q)` (two circles through `u`
  meeting twice more are one). (e) `isRingArc_of_clean` (Stage 26) on `ringArc q ψ (ψ + τ)` or `ringArc q (ψ − τ) ψ`, `τ < 2 arcsin(r₀/2)`, cleanliness from (a)
  (a branch point at radius `s` is at positive distance from every other branch: a compact middle range of radii, and the radius gap outside it); `u ∈ Γ` by the
  chart's `mem_Γ`.
- **`fail_colours`** over the same votes, plus which sector beside the `ω(q)`-branch lies inside `B(q, 1)` (the other two germs vote one in and one out at a
  generic `δ`; the third colour is excluded on both sides). Then **`pair_i`, `pair_ii`** (N3-I, N3-II over the votes and `noBoth`, as `pair_P'` did) and
  **`anti`** (N3-ANTI: each germ casts an in-vote at `u + e` or `u − e`, against a budget of one per M-in point).
- **`flankQ_upper` / `flankQ_lower`.** Engine 5 through `isRingArc_of_clean`: near an arc point `x = N + e(α − π/2 + t)`, `t` small, the open set
  `O = {dist(·, v) < r, frameX > 0, TanAbove κ₁, TanBelow κ′}` holds `x` (frame coordinates `(sin t, 1 − cos t)`, `tanHeight κ = (1 − κ)(1 − cos t)`); `O ∩ B(N, 1)`
  lies in the flank (`g`) and `O ∖ B̄(N, 1)` in the horn (`c`), so an arc point of `F` in `O` is on `ω(N)`; arc points (and `v`) are not interior (a child: an
  interior point of `B(v, r)` in the closure of a sector and off it would join the sector's component). (Q) branch: the `g`-tile at `N`
  (`mem_coloursAt_iff_exists_tileOf`) is near the flank tile (`unitNear_or_unitFar`; a flank point is within `1` of `N`), so inside `B̄(v, 1)`, and `ne1_region`
  at `v` makes it `B(v, 1)`. (R2) branch: `S′ = N + 2e(α − π/2) ∈ R₂`; out-type by the far branch of `unitNear_or_unitFar` (flank points are farther than `1`
  from `S′`) and `ne1_region` at `v`. **The shadow clause is the one place the formal (R2) is weaker than the derivation's reading**: `IsR2Arc` gives only
  `R₂ ⊆ cl(region g)`, while N4-SHADOW reads a `g`-tile filling the far side below `R₂`. My reading (one mind, not formalized): it still follows — (i) `g` avoids
  the thin cusp just inside `B(N, 2)` above `R₂` near `S′` (a `g`-point there has its unit partner, on the segment toward `N`, inside the flank: a `g`–`g` unit
  pair), so the points of `R₂` near `S′` are not interior, hence on `Γ`; (ii) by the chart at `S′` and the two-zeros algebra of (d) (curvature `1/2`), `R₂` near
  `S′` is a germ `(α, 1/2)` of that chart; (iii) the sector clockwise next to it (outside `B̄(N, 2)`) is `g` (the `R₂` points are in the closure of `g`'s class,
  the other adjacent sector lies in the forbidden cusp); (iv) for a horn point `z` near `v`, `ω(z)` crosses `R₂` transversally at an angle inside the open arc
  (offset `≈ √ε` from `arg(z − N)`, `ε = dist(z, N) − 1 < (1 − κ₁)x²/2`; the upper crossing always qualifies) and just before that crossing runs through the
  `g`-sector: a `g`-point at distance `1`. If (iii) fails (a cusp sector of another colour below `R₂`), the clause needs a hypothesis — that is where to look.
- The bends and `nb4p` as Stage 24 left them; `n3_end` after `fs131-w4c` merges (`woodallCone`, `exists_merge`).

**Re-pricing** (three leaves and a reduction this session, about 120k tokens of work): the leaves with a ready engine cost 25–60k each; the ring-arc engine
was the reusable cost. The base's five (`pair_i`, `pair_ii`, `fail_*`, `anti`) share (a)–(d) above, priced at one session for (a)–(e) plus
`fail_leavingCentre`, then about one leaf per 40k.

## Stage 29 — SAVED (FS131-I4k): readback, the as-given build

*FS131-I4k (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4k-wave4.md` on `main`) continues this record from `cd0fe492`.
Inventory ruling 194: this job takes `BaseSteps` and `UnitArc` only (11 leaves); `Contact` (10 `sorry` lines) is FS131-IC4's on `fs131-w4c`, and
`Contact.lean` is not edited here except by merging that branch.*

**The brief's quotations against their sources** (standing rule 3). The brief says "six"; it carries seven quotation blocks: (1) "**It may**: add children
anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" — `plans/FS131-w4-kernel-plan.md`
§ 14.2 (line 887): **matches as a truncation**. (2) "**What is left (11 in this job's files: UnitArc `bend_toward`, `bend_away`, `flankQ_upper`, `flankQ_lower`,
`nb4p`; BaseSteps `pair_i`, `pair_ii`," — this record, Stage 28 (line 933): **matches as a truncation**. (3) "- **`fail_leavingCentre`** (S–V Prop. 10's place,
by votes). (a) A new `localSectors_disj` in `Plane/LocalStructure`: `localSectors`' proof already establishes" — Stage 28 (line 935): **matches as a truncation**.
(4) item 194 — `plans/FS131-close-inventory.md` on `main` (line 1358): **matches as a truncation**. (5) item 244 — same file (line 1751): **matches as a
truncation**; its continuation (ruling (b), `localSectors_disj` in `Plane/LocalStructure` with `localSectors` re-derived, statement unchanged; (c) run Stage 28's
step (iii) and report at once if it fails) is as the brief summarizes it. (6) item 177 — same file (line 1229): **matches as a truncation**. (7) item 185 —
same file (line 1300): **matches as a truncation**. The source headings the brief gives for (2)–(3) are this record's Stage 28 heading, verbatim. No
mismatch but the count (seven blocks, not six).

**What I may change** (§ 14.2, unchanged since Stage 1, with ruling 244 (b)): add children anywhere in the wave's modules (engines in `Basic`, sorry-free, with
spec examples; every child § 13 names); supporting lemmas in the foundation modules (wave 4's `Basic`, wave 3's `Plane/LocalMap`, `LocalStructure`, `Tiles`,
wave 1's `Plane/Chord`, `Diameter`, `Basic`), statements unchanged; in `Plane/LocalStructure`, the new `localSectors_disj` with `localSectors` re-derived from it
(statement unchanged); imports (with `ARCHITECTURE.md`'s Imports cell, each new record in `scripts/Axioms.lean`, then `tools/fs131_k4_decls.py --check`);
wave 4's vacuity carriers at the gate (`AeProperRegions` registered, item 144). **What I may not change**: any statement of §§ 3.2, 7.2, 8.2, 12.2 (`lock`'s
clause 3 in its ruled local form, item 177; `l60_eq_third`'s binder `_hF`, item 185; `pair_P'`'s `_h`, item 244 (a)); any definition of `Plane/ValidMap/Basic`;
the fragments' definitions but for a coordinate slip found against the source tool (a finding); the read-backs' conventions; TS-T's Condition-5 clause in its
carried form (item 142); no new `axiom`, no `native_decide`; `Contact.lean` (ruling 194) except by merging the parallel branch. A leaf that cannot be proved
as written goes to Keryx at once. No edit while a build of the edited file runs. A merge commit is the one commit made without paths.

**The worktree as given** (`cd0fe492`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK — all
1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T212339Z-2513792.log`; driver log
`data/fs131/i4/build-i4k-readback.log`). 21 `declaration uses sorry` warnings — BaseSteps 6, Contact 10, UnitArc 5 — and no other warning. This job's scratch
mirror for `iter.sh`/`chk.sh`/`errs.sh` is `S=/home/kooshi/scratch-w4k`.

## Stage 30 — SAVED (FS131-I4k): `localSectors_disj` and `fail_leavingCentre`; 10 `sorry` left in `BaseSteps` and `UnitArc`

**`localSectors_disj`** (`Plane/LocalStructure`, ruling 244 (b)): `localSectors`' proof already built the disjointness (`hr₃`) and handed it to
`isSectorChart_of`; it is now a named `have` returned as a second conjunct, and `localSectors` is its corollary — statement unchanged (the `theorem` line
is identical, checked by `git diff`; the docstring moved to the new theorem). Cost of the rebuild: LocalStructure 34 s, the whole build 11 min.

**`fail_leavingCentre` (FS112-N3-FAIL, the place) proved**, on Stage 28's route (a)–(e), with children in a new `BaseSteps` section "The germs of a cubic
trichromatic vertex and their votes" (before N3-FAIL):
- `IsCubicTrichromatic.chart`: three germs (degree 3 forces `n = 3`), the disjointness, three sectors of three distinct colours that are all of `c(u)`.
- `BranchGerms.mem_closure_sector_of_lt`: a germ's branch point lies in the closure of the sectors on both sides of it (`image_closure_subset_closure_image`).
- `BranchGerms.fin3_adj` (`decide`): two distinct germs of three bound every sector.
- `exists_branch_on_circle_of_not_stripHolds` (**the vote**): where the strip fails, at every radius some germ's branch point is on `ω(q)` — two germs
  strictly outside bar every colour of `u` from the inner side (the crossing engine on the closed sector, which reaches from `u`, inside `ω(z)`, to the
  branch point, outside), two inside bar the outer side.
- `germ_eq_of_two_on_circle` (**the two-zeros algebra**) over `sq_dist_branchPt` and the real lemma `germ_circle_real`: with `y = (u − q) conj e(β) = p + ir`,
  `|b(s) − q| = 1` reads `4p² = s²(p²κ² + (1 + rκ)²)`, so two radii give `p = 0`, `rκ = −1`: `κ = ±1` and `e β = iκ(u − q)`.
- `branchPt_two_sin`: such a germ's branch point at distance `2 sin(t/2)` is `q + (u − q) e(κt)` — the branch is `ω(q)`.
- `IsSectorChart.exists_ball_branch` (over `localSectors_disj`): a small ball about a branch point meets the arcs only on its own branch — the cleanliness
  `isRingArc_of_clean` (Stage 26's engine A) asks for.
Then four radii and three germs give one germ on `ω(q)` at two radii (pigeonhole), the arc of `ω(q)` from `u` along it lies in `Γ` and is clean, and engine A
makes it a ring arc ending at `u`. Hypotheses read: `hF` (the crossing), `hu`, `hc` (only `u ∈ dom`), `hq`, `hs`. Read against § 8.2 and the row: same
statement (where the strip fails at `q ∈ ω(u)`, `q` is the centre of an arc of `Γ` on `ω(q)` with constant sides ending at `u`).

**Records**: `tools/fs131_i4_addrecords.py` — 452 names, 9 added; `localSectors_disj` added by hand beside `localSectors` in wave 3's block;
`tools/fs131_k4_decls.py --check` exit 0. **Axioms** (`data/fs131/i4/axioms-i4k-30.lean` → `axioms-i4k-30.txt`, against this stage's build's oleans, not a gate
log): all twelve `[propext, Classical.choice, Quot.sound]`, `fin3_adj` none. **No statement changed**, no new axiom, no `native_decide`, no new import. Build:
"build: OK — 444 of 444 batches, 12 module(s) rebuilt, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T213942Z-2609986.log`; driver log
`data/fs131/i4/build-i4k-stage30.log`): 20 distinct `declaration uses sorry` (BaseSteps 5, Contact 10, UnitArc 5), no other warning.

**Re-pricing** (first hard leaf): about 70k tokens including the readback; three iteration passes on a scratch file importing `BaseSteps` (compiling only
`LocalStructure` into the scratch mirror: a purely additive change leaves its dependents' oleans loadable, iteration only).

## Stage 31 — SAVED (FS131-I4k): `fail_colours`, `anti`, `pair_ii`; `pair_i` held (a GAP, ruled); 7 `sorry` left in `BaseSteps` and `UnitArc`

**The vote, refactored** (children in the same section, now moved before N3-PAIRS so that `pair_ii` can read them): `stripHolds_of_two_branches` (two germs
with branch points strictly on one side of `ω(q)` at one radius make the strip hold) with `exists_branch_on_circle_of_not_stripHolds` over it;
`IsSectorChart.exists_isRingArc_of_along` (the arc of `Γ` along a germ tangent to `ω(q)`, ending at `u`, its interior points that germ's branch points —
`fail_leavingCentre`'s tail, now shared); `exists_along_of_side` (if both bounding germs of a sector stay weakly on one side of `ω(q)`, one lies along it:
off that each meets `ω(q)` at one radius at most, so at some radius both are strictly on one side); `closure_sector_subset_of_side` (**the crossing at a
vertex**: a colour of `u` approaching `x` from inside `ω(u)` confines its sector's closure to `B̄(x, 1)`, from outside to `{1 ≤ dist · x}`);
`exists_colour_near` (finitely many colours: a colour of `u` occurring near `q` on one side for every `ε` approaches `q` on that side).

**`fail_colours` (FS112-N3-FAIL, the colours) proved.** (1), (3) from `¬ StripHolds` by `exists_colour_near`. (2): a colour `f i` of `u` inside at `q` confines
sector `i` to `B̄(q, 1)`, hence (open) to `B(q, 1)`; of its two bounding germs one lies along `ω(q)` (`exists_along_of_side`, the outer strip would hold
otherwise); the arc along it has a branch point of that germ, in the closure of sector `i`, as an interior point, so `f i` is its inner colour. (4) mirrors it.
Read against § 8.2 and the row: same statement (the row's "exactly" read as the proof's "only", as the docstring says).

**`anti` (FS112-N3-ANTI) proved**, with no second-order formula: `u` is the midpoint of the antipodes, so `|b − x|² + |b − y|² = 2|b − u|² + 2` puts every
branch point at a positive radius beyond `ω(x)` or beyond `ω(y)`; two of the three germs are beyond the same one, they bound all three sectors, and the sector
of the M-in colour there is confined to its closed disc (`closure_sector_subset_of_side`). The strip is not read. Same statement.

**`pair_ii` (FS112-N3-PAIRS (ii)) proved**, with neither the strip nor N3-FAIL: `exists_side_germs_of_transversal` (with `ζ = (x − u₁) conj(x − y) = P + iQ`,
`|ringPt y (φ₀ + t) − u₁|² = 1 + 2(1 − P)(1 − cos t) + 2Q sin t`, and `htr` is `Q ≠ 0`) gives a half of `ω(y)` strictly inside `ω(u₁)` and one strictly outside;
`half_colour_or_bothKind` on each: an interior point of the half has a colour outside `{a, b}` (N-E1 at `y`), else the half is in `Γ` and a constant-sides
sub-arc has side colours in `{a, b}` (both-kind at `y`, the second disjunct) or one outside. So `x` carries a colour `d₁` of `u₁` from inside and `d₂` from
outside, distinct (one sector would lie on `ω(x)`, `interior_sphere`), and `{a, b, d₁, d₂}` are four colours at `x`. **Binders renamed**: `h₂`, `hc₂`, `hy`
are unread, now `_h₂`, `_hc₂`, `_hy` (accepted by the coordinator mid-job, ruling 185's reason). Read against § 8.2: same statement.

**`pair_i` held — a GAP in N3-I, sent to the coordinator and ruled.** The derivation's step "a failure at `(x, y)` would recur at nearby unit pairs" fails
when `(x, y)` is an isolated unit pair of `ω(u₁) × ω(u₂)`: `|u₁ − u₂| = 3`, `u₁, x, y, u₂` collinear at spacing `1` (then `ω(y)` is tangent to `ω(u₁)` at
`x` from outside, and CB's strip argument reaches only an outer strip). A local picture (`u₁ = 0, x = 1, y = 2, u₂ = 3`, both strips holding on the inner
side, colour `a` inside each) shows no contradiction; no full counterexample was built. **Ruling (inventory item 258)**: `pair_i` gains `(h3 : dist u₁ u₂ < 3)`.

**Records**: `tools/fs131_i4_addrecords.py` — 459 names, 7 added; `tools/fs131_k4_decls.py --check` exit 0. **Statements**: new `tools/fs131_i4_stmts.py`
(every theorem's text up to `:=` against a revision): against `cd0fe492`, 141 old, 157 new, 16 added, 0 removed, 1 changed — `pair_ii`'s binders,
allowed; its plant (`fail_leavingCentre`'s hypothesis `¬ StripHolds` edited to `StripHolds`) fired `CHANGED fail_leavingCentre`, exit 1, and the restored file
reads exit 0. **Axioms** (`data/fs131/i4/axioms-i4k-31.txt`, this stage's oleans, not a gate log): the three leaves, `fail_leavingCentre` and the eight new
children, all `[propext, Classical.choice, Quot.sound]`. Build: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s) with warnings", exit 0
(`build/gate/build/20261004T215858Z-2731754.log`; driver log `data/fs131/i4/build-i4k-stage31.log`): 17 distinct `declaration uses sorry` (BaseSteps 2,
Contact 10, UnitArc 5), no other warning. Cost: about 60k tokens for the three leaves and the refactor, two iteration passes.

## Stage 32 — SAVED (FS131-I4k): `pair_i` gains `h3 : dist u₁ u₂ < 3` (ruling 258); 7 `sorry` left in `BaseSteps` and `UnitArc`, and the handoff

**The statement change, as ruled** (inventory item 258; the brief's amendment of 2026-10-04): `pair_i` takes `(h3 : dist u₁ u₂ < 3)` after `hc₂`, and its
docstring names it in place of "no transversality hypothesis". `tools/fs131_i4_stmts.py ff32b839 … --allow pair_i`: 157 statements, 1 changed (`pair_i`,
allowed), exit 0. The axioms record is by name and unchanged. Build: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s) with warnings", exit 0
(`build/gate/build/20261004T221211Z-2818124.log`; driver log `data/fs131/i4/build-i4k-stage32.log`): 17 distinct `declaration uses sorry` (BaseSteps 2,
Contact 10, UnitArc 5), no other warning.

**The coordinator's inference (item 258), checked on paper (one mind, not formalized)**: the critical points of `|x′ − y′|` on `ω(u₁) × ω(u₂)` are the four
configurations with `x′`, `y′` on the line through `u₁`, `u₂`, of values `d − 2, d, d, d + 2` (`d = |u₁ − u₂|`, `d > 0`; for `d = 0` the level set `|x′ − y′| = 1`
is a smooth curve). The value `1` is critical only at `d = 3` (the minimum: an isolated pair, the GAP) and at `d = 1` (two saddles: the level set is two crossing
curves, still not isolated). So for `d < 3` every unit pair has unit pairs `(x′, y′) → (x, y)`, `(x′, y′) ≠ (x, y)`. Tangency at `x′` (`|y′ − u₁| = 2`) needs
`y′ ∈ ω(u₂) ∩ sphere(u₁, 2)`, at most two points; the strip fails at no more than three points of `ω(u₁)` (each fail point `q` has a germ of `u₁` with `e β = iκ(u₁ − q)`,
`exists_branch_on_circle_of_not_stripHolds` and `germ_eq_of_two_on_circle`, so `q` is fixed by the germ). Confirmed: the perturbation covers tangent pairs.

**What is left (7 in this job's files: UnitArc `bend_toward`, `bend_away`, `flankQ_upper`, `flankQ_lower`, `nb4p`; BaseSteps `pair_i`, `n3_end`).**
- **`pair_i`** (with `h3`), the route: (1) `y ≠ u₁` (`a ∈ c(y)`, `a ∉ c(u₁)`) and `x ≠ u₂`. (2) **The strip case**: if `StripHolds u₁ x` on a side `σ` that `ω(y)`
  enters near `x` (transversal: `exists_side_germs_of_transversal` gives both sides; tangent from outside: only `σ` = outside), every interior point there has
  colour `a` (the strip, `exists_ball_col_mem_coloursAt`, `c′(x) = {a}`), so a ball `O` about a point `m` of `ω(y)` on side `σ` lies in `closure (region a)` (interior
  points are dense: grep wave 3 for its density lemma), and `Valid.dist_ne_one_of_isOpen_subset_closure` with `y ∈ closure (region a)`, `dist y m = 1` is the
  contradiction. (3) **Otherwise perturb**: `c′ ≡ {a}` on `ω(u₁)` near `x` (`coloursAt x′ ⊆ coloursAt x` near `x`, from `exists_ball_col_mem_coloursAt`;
  `c′(x′) ≠ ∅` by `noBoth` as in `pair_P'`) and on `ω(u₂)` near `y`; choose a unit pair `(x′, y′)` near `(x, y)` (the paragraph above; the intermediate value
  theorem along `ω(u₂)` against `ω(x′)`, using `exists_side_germs_of_transversal` at `y` when `|x − u₂| ≠ 2`, or along `ω(u₁)` against `ω(y′)` otherwise) with `x′`
  not a fail point and `|y′ − u₁| ≠ 2`, then (2). Price: about one session.
- **`n3_end`** after `fs131-w4c` merges (`woodallCone`, `exists_merge`), as I4g and Stage 28 said.
- **`flankQ_*`, the bends, `nb4p`**: as Stage 28 left them. `flankQ_*` can now use `IsSectorChart.exists_isRingArc_of_along`'s pattern (an arc of `Γ` along a
  chart germ tangent to a unit circle) at `v` with `q = N` or `S′`, if the horn's bounding arc is a germ of `v`'s chart; the (R2) shadow reading (ruling 244 (c))
  is not yet run — run Stage 28's step (iii) first and message the coordinator at once if it fails.

**Re-pricing** (this session, about 130k tokens of work after the readback): four leaves and a statement repair; the shared vertex children (the chart, the vote,
the arc along a germ, the crossing at a vertex) made `fail_colours`, `anti` and `pair_ii` cost about 20k each once `fail_leavingCentre` had paid for them.

## Stage 33 — SAVED (FS131-I4l): readback, the as-given build

*FS131-I4l (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4l-wave4.md` on `main`) continues this record from `d391f480`. Its
first job is inventory item 267's merge of `fs131-w4c` (at `f975677b`) into this branch; then `n3_end`, `UnitArc`'s five and `pair_i`. `Contact.lean` is
not edited here except by that merge.*

**The brief's quotations against their sources** (standing rule 3). Five blocks: (1) "**What is left (7 in this job's files: UnitArc `bend_toward`,
`bend_away`, `flankQ_upper`, `flankQ_lower`, `nb4p`; BaseSteps `pair_i`, `n3_end`).**" — this record, Stage 32 (its heading as the brief gives it, verbatim):
**matches exactly**. (2) "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the
engines in the" — `plans/FS131-w4-kernel-plan.md` § 14.2 (line 887): **matches as a truncation**. (3) item 267 — `plans/FS131-close-inventory.md` on `main`
(line 1940): **matches as a truncation**. (4) item 258 — same file (line 1845): **matches as a truncation**. (5) item 266 — same file (line 1927): **matches as a
truncation**. Items 257 and 264 read in full; 264's critical-point argument is the one Stage 32 records. No mismatch.

**The merge's scope, checked before merging** (`git diff --name-only 68f34f18` on each side; `68f34f18` is the merge base): the two sides share exactly
`ARCHITECTURE.md` and `scripts/Axioms.lean`, as item 267 says; `fs131-w4c` adds `Contact.lean`, its record `plans/FS131-IC-implementation.md`, its reports,
`tools/fs131_ic*_addrecords.py` and `data/fs131/ic/`.

**The worktree as given** (`d391f480`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`), admitted after
one wait: "build: OK — all 1744 modules already up to date, nothing built, 3 module(s) with warnings", exit 0 (`build/gate/build/20261004T223506Z-2998291.log`;
driver log `data/fs131/i4/build-i4l-readback.log`). 17 `declaration uses sorry` warnings — Contact 10, UnitArc 5, BaseSteps 2 — and no other warning.

## Stage 34 — SAVED (FS131-I4l): `fs131-w4c` merged (inventory item 267); 10 `sorry` left on the branch (Contact 3, UnitArc 5, BaseSteps 2)

**The merge** (`d33d0b33`, `git merge fs131-w4c` at `f975677b`; the one commit of this job made without paths, as its message says). Conflicts:
`ARCHITECTURE.md` only — the `Contact` row taken from `fs131-w4c` (IC1's children, Imports `Plane/ValidMap/Basic`, `Plane/Tiles`, `Plane/SVMap`), the `UnitArc`
row from `fs131-w4` (Imports with `Plane/ValidMap/Sectors`); every other row was already common. `scripts/Axioms.lean` merged without conflict, and every line
of both sides is kept: base 3,050 lines, `fs131-w4` 3,131, `fs131-w4c` 3,215, merged 3,296 = 3,050 + 81 + 165, each line's multiplicity checked against
base + (ours − base) + (theirs − base), 0 mismatches. No other file changed on both sides. `Contact.lean` is `fs131-w4c`'s byte for byte.

**Checks.**
- **Statements** (`tools/fs131_i4_stmts.py`, every wave-4 and supporting module): against `d391f480`, `Contact` 30 old / 180 new, 1 changed — `stuck_structure`,
  ruling 252's sides clause (IC5's), allowed: exit 0 with `--allow stuck_structure`; `UnitArc`, `BaseSteps`, `Basic`, `Sectors`, `LocalStructure`,
  `StuckChain`, `SVMap` 0 changed. Against `f975677b`, `BaseSteps` 3 changed — `pair_i` (ruling 258), `pair_ii` and `pair_P'` (binder renames, rulings 258 and
  244 (a)), allowed: exit 0 with `--allow`; every other module 0 changed. So the merge changed no statement: each module equals one parent's.
- **Duplicate names.** `tools/fs131_qa1_dupes.py` (`data/fs131/i4/dupes-i4l.log`, run on the merge commit): the same six names as I4d's
  `dupes-i4d.log` (`abs_dot_le`, `dot_add_left`, `dot_e_e`, `isOpen_shadow` against `fs131-ww`; `framePt` against `fs131-w2`; `conj_e`, wave 1's) — nothing new.
  QA1's tool compares bodies and skips a name repeated inside one body, which after a merge is exactly the case to check, so a new tool,
  `tools/fs131_i4_treedupes.py`, scans every qualified name in the tree (QA1's `qualified_decls`, imported): merged tree 7,529 declarations, the merge base
  `68f34f18` 7,296, `d391f480` 7,378, `f975677b` 7,447 — 7,378 + 7,447 − 7,296 = 7,529, nothing lost or doubled — and the same 3 repeats in all four
  (`conj_e` in `Chord`/`SixFragment`, and `bindings`, `with`: prose read as declarations), none new. Planted control: a synthetic file redeclaring
  `ArcMap.pair_i` fires `REPEAT HadwigerNelson.Plane.ArcMap.pair_i`, exit 1 (`data/fs131/i4/treedupes-i4l-merge.log` holds all five runs).
- **Records.** `tools/check_architecture.py`: PASS, exit 0. `tools/fs131_k4_decls.py --check`: exit 1, 522 names, 2 "missing" —
  `…ArcMap._root_.HadwigerNelson.Plane.BranchGerms.frameY_lt_of_mem` and `…lt_frameY_of_mem`: K4's tool does not resolve `_root_.` (a **tool defect**, not
  mine to edit); both records are present under their resolved names (`scripts/Axioms.lean` lines 3230, 3239), and with `._root_.` resolved all 522 names
  are recorded (0 missing). The Contact lane's own `tools/fs131_ic*_addrecords.py` reads `_root_.` names as written.

**Build** of the merge: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s) with warnings, 8m48s", exit 0
(`build/gate/build/20261004T223841Z-3027842.log`; driver log `data/fs131/i4/build-i4l-merge.log`): 10 distinct `declaration uses sorry` — `Contact` 3
(l. 4064, 4078, 4094: `exists_shave`, `exists_rayMerge`, `exists_merge`), `UnitArc` 5, `BaseSteps` 2 — and no other warning, as the brief expected.

## Stage 35 — SAVED (FS131-I4l): `pair_i` (FS112-N3-PAIRS (i), with ruling 258's `h3`) proved; 9 `sorry` left on the branch (Contact 3, UnitArc 5, BaseSteps 1)

**`pair_i` proved** on Stage 32's route, with one simplification found on the way: the perturbed partner needs no pseudo-colour of its own, because
**every point of `ω(u)` near a point whose pseudo-colour is `{a}` lies in the closure of `a`'s class** (`mem_closure_region_of_pseudo`). Children, in a new
`BaseSteps` section "Moving a unit pair along two unit circles", before N3-PAIRS:
- `eq_midpoint_of_dist` (Apollonius: `|x − u| = |x − y| = 1`, `|y − u| = 2` ⟹ `x = (u + y)/2`), `finite_sphere_inter_sphere_half` (a unit circle meets a
  circle of radius `1/2` finitely: wave 3's `Arc.finite_inter_sphere_or_eq_circ` on `circ m (1/2) (−π) π`), `exists_mem_Ioo_ringPt_not_mem` (an open
  interval of angles has one whose ring point avoids a countable set: `countable_ringPt_preimage` and Lebesgue measure).
- `mem_closure_region_of_pseudo`: an interior point of `ω(u)` near `y` has a colour of `y` that `u` does not carry (N-E1 at `u`), so `a`; a sub-arc of
  `ω(u)` in `Γ` holds a ring arc with constant sides whose two side colours are colours of `y`, both carried at `u` only if both-kind — NOBOTH, against
  `u` cubic trichromatic — so one is `a`; such points are dense on `ω(u)` near `y`, and `closure (region a)` is closed.
- `finite_not_stripHolds`: the strip fails at three points of `ω(u)` at most — each is `u + I κ e(β)` for a germ of the chart with `κ = ±1` (four radii,
  `exists_branch_on_circle_of_not_stripHolds`, `germ_eq_of_two_on_circle`, as in `fail_leavingCentre`).
- `pair_i_of_transversal` (the case `|x − u₂| ≠ 2`): `ω(x)` crosses `ω(u₂)` transversally at `y` (`exists_side_germs_of_transversal`); pick `x′ ∈ ω(u₁)`
  within `η` of `x` off the finitely many fail points and off `ω(u₁) ∩ sphere((u₁ + u₂)/2, 1/2)` (the `x′` whose partner could be tangent:
  `|y′ − u₁| = 2` forces `x′ = (u₁ + y′)/2`); the intermediate value theorem along `ω(u₂)` near `y` gives `y′` with `|x′ − y′| = 1`, `y′ ≠ u₁`,
  `|y′ − u₁| ≠ 2`, `y′ ∈ closure (region a)`. The strip holds at `x′` on a side `O` (open); every interior point of `O` near `x` has colour `a`, so
  `O ⊆ closure (region a)` (`dense_interiorPts`, `IsOpen.inter_closure`); `ω(y′)` crosses `ω(u₁)` transversally at `x′` and enters `O` at a point at
  distance `1` from `y′`, against `Valid.dist_ne_one_of_isOpen_subset_closure`.
- `pair_i` itself: if `|x − u₂| = 2`, then `|y − u₁| ≠ 2` (both would make `u₁, x, y, u₂` collinear at spacing `1`, `|u₁ − u₂| = 3`, against `h3` —
  exactly ruling 258's case), and `pair_i_of_transversal` applies with the roles of `(u₁, x)` and `(u₂, y)` exchanged. **`h3` is read exactly there.**
Read against § 8.2 and the row as amended by ruling 258: same statement.

**Tools.** `tools/fs131_i4_addrecords.py` now resolves `theorem _root_.X` to `X` (it read `fs131_k4_decls.py`'s unresolved names and would have
written two bogus records after the merge); `--check` before the fix listed the two `_root_` names and the six new ones, after it the six only; `--plant`
fires (615 of 615 missing); after adding, `--check` exit 0 (615 names, 0 missing). Statements: `tools/fs131_i4_stmts.py 54852de9 …BaseSteps.lean`
157 old, 163 new, 6 added, 0 changed, exit 0. **Axioms** (`data/fs131/i4/axioms-i4l-35.txt`, against this stage's build's oleans, not a gate log):
`pair_i` and the six children, all `[propext, Classical.choice, Quot.sound]`. No new import, no `native_decide`, no axiom.

**Build**: "build: OK — 444 of 444 batches, 2 module(s) rebuilt, 3 module(s) with warnings, 9m20s", exit 0
(`build/gate/build/20261004T225128Z-3105601.log`; driver log `data/fs131/i4/build-i4l-stage35.log`): 9 distinct `declaration uses sorry` — Contact 3,
UnitArc 5, BaseSteps 1 (`n3_end`) — and no other warning.

**For `n3_end`, the coordinator's amendment (inventory items 268–269, by message mid-job)**: `exists_merge`'s clause
`∀ x ∉ sphere v ρ, F'.coloursAt x ⊆ F.coloursAt x` is unsatisfiable and becomes `F'.coloursAt v ⊆ F.coloursAt v` on `fs131-w4m`; a proof of `n3_end`
reads only that vertex instance.

## Stage 36 — SAVED (FS131-I4l): engine 5 (upper), and `flankQ_upper` proved over one named child, its (R2) shadow clause; 9 `sorry` left on the branch (Contact 3, UnitArc 5, BaseSteps 1)

**Engine 5, the upper bound** (`ArcMap.IsHorn.isRingArc_upper`, plan § 13.1 item 5, in `UnitArc` before FLANK-Q; consumers `flankQ_upper`, `n3_end`,
wave 5's C-DOUBLE): a horn `IsHorn v α κ₁ 1 c` with an upper flank `g` is bounded by an arc of `Γ` on `ω(N)` from `v` with constant sides `g` inside,
`c` outside. Route as Stage 28 gave it: on `O = {dist(·, v) < r, frameX > 0, TanAbove κ₁, TanBelow κ′}` the horn and the flank fill everything off
`ω(N)`; the arc's points (`ringPt N (α − π/2 + t) = framePt v α (sin t) (1 − cos t)`, child `normalPt_add_eq_framePt`, the radial points
`N + ρ e(α − π/2 + t)` at frame `(ρ sin t, 1 − ρ cos t)`) lie in `O` for `0 < t ≤ min (r/2) 1`; such a point, or `v`, if interior, would have a ball of
interior points meeting the horn, hence inside the horn's component (the `IsSector` equality), yet holding points inside `ω(N)`; so the closed arc is in
`Γ`, clean (arcs near it lie on `ω(N)`), and `isRingArc_of_clean` applies; its side colours are read at the arc's middle from the radial points
`N + (1 ∓ s) e(m)`. No validity read.

**`flankQ_upper`** now reads: engine 5 for the arc; the side colours of an arc with constant sides are unique (read at its middle), so `hQR`'s (Q) or
(R2) arc is the flank's. (Q): `g ∈ P_cl(N)`, its tile `T` at `N` (`mem_coloursAt_iff_exists_tileOf`) is unit-near every flank tile (unit-far is refuted at
`N`, a flank point being inside `B(N, 1)`), so every point of `T` is within `1` of every flank point, hence `T ⊆ B̄(v, 1)`, and `T` is open: `T ⊆ B(v, 1)`.
(R2): `S′ = N + 2e(α − π/2)` is `R₂`'s point at `v`, so in `closure (region g)`; a `g`-tile at `S′` is unit-far from every flank tile (flank points have
`frameY > 0`, so are farther than `1` from `S′`), so its points are at least `1` from `v`, and being open it misses `B̄(v, 1)`: out-type. The shadow clause
is the one child left, **`flankQ_upper_shadow`** (`sorry`): `F.Valid`, `F.Covers v 1`, the upper flank, `α − π/2 < θ₂` and
`radiusTwoArc N (α − π/2) θ₂ ⊆ closure (region g)` ⟹ `∀ᶠ r in 𝓝[>] 0, hornSet v α κ₁ 1 r ⊆ shadow (region g)` — the horn read only as a set.
`hcN` is unread (as § 13.3 (e) foresaw for the (R2) branch's `c`-contact; FLANK-Q's statement keeps it).

**Ruling 244 (c): Stage 28's step (iii) run — it holds (one mind, on paper, not formalized), by a route that needs no chart at `S′`.** Write
`p_s = N + 2e(α − π/2 + s)`.
1. *The cusp* (Stage 28 (i)): for small `s > 0` some ball about `p_s` holds no point of `region g` inside `B(N, 2)`. For `q` there,
   `q′ = N + (|q − N| − 1)(q − N)/|q − N|` is at distance exactly `1` from `q`; `q ↦ q′` is continuous and `q′(p_s)` is the arc point `a(s)`, inside the open
   set `{dist(·, v) < r_f, frameX > 0, TanBelow κ′}` (`r_f` a flank radius); with `|q′ − N| = |q − N| − 1 < 1`, `q′` is a flank point: a `g`–`g` unit pair.
2. Hence the points of `R₂` near `S′` (`s > 0`) are in `Γ`: an interior one would be `g` (it lies in `closure (region g)`), with `g`-points just inside radius 2.
3. *Generic points*: finitely many arcs meet a neighbourhood of `S′`; each lies on `sphere N 2` or meets it in finitely many points (wave 3's
   `Arc.finite_inter_sphere_or_eq_circ` after the homothety `z ↦ (z + N)/2`, which takes `sphere N 2` to `ω(N)` and arcs to arcs). So some `s_min > 0`
   has, for `0 < s < s_min`, a ball about `p_s` in which every arc point lies on `sphere N 2`.
4. *The outer side is `g`*: a polar rectangle `{N + ρ e(φ) : 2 < ρ < 2 + η, |φ − φ_s| < η′}` in that ball is preconnected and free of arcs, so of one
   colour; the `g`-points near `p_s` lie in it (by 1–2; angles by continuity of `arg` near the positive reals), so it is `g`'s.
5. *The crossing*: for `z` in the horn, `w = z − N = |w| e(α − π/2 + s_w)` with `|w| > 1` (`TanBelow 1`) and `s_w > 0` small (`frameX > 0`);
   `s_c = s_w + arccos((3 + |w|²)/(4|w|))` puts `p_{s_c}` on `ω(z)` (`|2e − w|² = 4 + |w|² − 4|w| cos = 1`), and `s_c → 0` as `z → v`; for `r` small
   every horn point has `s_c ∈ (0, min(s_min, θ₂ − (α − π/2)))`. The crossing is transversal (`sin(s_c − s_w) ≠ 0`), so `ω(z)` enters the rectangle at
   `p_{s_c}`: a point of `region g` at distance exactly `1` from `z`.
So Stage 28's worry — "a cusp sector of another colour below `R₂`" — does not block: below `R₂` near `S′` there is no `g` at all (1), and above it, at the
generic points the horn's circles reach, one colour carries `R₂` in its closure. Special points of `R₂` are avoided by taking `r` small (5). The mirror
(`flankQ_lower_shadow`) is the same with `N ↔ S′`. Price: about 300–400 lines (the homothety of arcs, the clean ball, the cusp, the rectangle, the
crossing) — a session.

**Records**: `tools/fs131_i4_addrecords.py` — 618 names, 3 added (`normalPt_add_eq_framePt`, `IsHorn.isRingArc_upper`, `flankQ_upper_shadow`); `--check`
exit 0. **Statements**: `tools/fs131_i4_stmts.py 111830c8 …UnitArc.lean` 120 old, 123 new, 3 added, 0 changed, exit 0.
**Axioms** (`data/fs131/i4/axioms-i4l-36.txt`, this stage's oleans, not a gate log): `normalPt_add_eq_framePt`, `IsHorn.isRingArc_upper` the standard
three; `flankQ_upper` reads `sorryAx` through `flankQ_upper_shadow` only. **Build**: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s)
with warnings, 9m57s", exit 0 (`build/gate/build/20261004T230630Z-3278350.log`; driver log `data/fs131/i4/build-i4l-stage36.log`): 9 distinct
`declaration uses sorry` — Contact 3, UnitArc 5 (`bend_toward`, `bend_away`, `flankQ_upper_shadow`, `flankQ_lower`, `nb4p`), BaseSteps 1 — and no other
warning.

## Stage 37 — SAVED (FS131-I4l): engine 5 (lower), and `flankQ_lower` proved over its (R2) shadow child; 9 `sorry` left on the branch (Contact 3, UnitArc 5, BaseSteps 1), and the handoff

**The mirror, proved directly** (plan § 13.3 (c)): `normalPt_sub_add_eq_framePt` (`S′ + ρ e(α + π/2 − t)` at frame `(ρ sin t, −(1 − ρ cos t))`),
`ArcMap.IsHorn.isRingArc_lower` (a horn `IsHorn v α (−1) κ₂ c` with a lower flank `h` is bounded by an arc of `Γ` on `ω(S′)` ending at `v`, inner `h`,
outer `c` — the bound `n3_end`'s horn has), and `flankQ_lower` over the child **`flankQ_lower_shadow`** (`sorry`; the hypotheses of
`flankQ_upper_shadow` with `N ↔ S′`: `radiusTwoArc S′ θ₁ (α + π/2) ⊆ closure (region h)` ⟹ `h` shadows the horn near `v`). (Q): the `h`-tile at `S′`
is Siamese with the flank (flank points inside `B(S′, 1)`), so in `B(v, 1)`. (R2): `N = S′ + 2e(α + π/2)` is `R₂`'s point at `v`; flank points have
`frameY < 0`, so are farther than `1` from `N`, and an `h`-tile at `N` is unit-far from them: out-type. `hcS` unread, as `hcN` above.

**What is left (6 in this job's files): UnitArc `bend_toward`, `bend_away`, `flankQ_upper_shadow`, `flankQ_lower_shadow`, `nb4p`; BaseSteps `n3_end`.**
`pair_i` is proved; `flankQ_upper`, `flankQ_lower` are proved over their shadow children.
- **`flankQ_upper_shadow`, `flankQ_lower_shadow`**: Stage 36's five steps (the cusp, `R₂` in `Γ`, generic points by the homothety `z ↦ (z + N)/2` and
  `Arc.finite_inter_sphere_or_eq_circ`, the polar rectangle, the crossing). Write the homothety of arcs and the clean-ball lemma once, generically in the
  centre, and both mirrors use them; the cusp and the crossing are per side. Price: a session for both.
- **`n3_end`**: unblocked by the merge (`woodallCone`, `exists_merge`, and now `IsHorn.isRingArc_lower` for its horn's lower arc on `ω(v − n)`); reads
  `exists_merge`'s vertex clause `F'.coloursAt v ⊆ F.coloursAt v` only (inventory items 268–269). NB3-END's items 1–5 (`plans/FS112-NB3-verification.md`
  l. 221–243) are its route; `n3_end` carries no `hQR`, so FLANK-Q's conclusions are not available to it as stated — read item 1 against that first.
- **The bends, `nb4p`**: as Stage 24 left them.

**Records**: `tools/fs131_i4_addrecords.py` — 621 names, 3 added; `--check` exit 0. **Statements**: `tools/fs131_i4_stmts.py c8b8b382 …UnitArc.lean`
123 old, 126 new, 3 added, 0 changed, exit 0; against `d391f480` (the job's start): `UnitArc` 6 added, 0 changed; `BaseSteps` 6 added, 0 changed;
`Contact` 150 added, 1 changed (`stuck_structure`, IC5's, ruling 252), allowed. **Duplicates**: `tools/fs131_i4_treedupes.py` — 7,541 declarations
(7,529 + the 12 added), the same 3 pre-existing repeats. **Axioms** (`data/fs131/i4/axioms-i4l-37.txt`, this stage's oleans, not a gate log):
`normalPt_sub_add_eq_framePt`, `IsHorn.isRingArc_lower` the standard three; `flankQ_lower` reads `sorryAx` through `flankQ_lower_shadow` only. No
`native_decide`, no axiom, no import changed in this job. **Build**: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings,
9m52s", exit 0 (`build/gate/build/20261004T232508Z-3414461.log`; driver log `data/fs131/i4/build-i4l-stage37.log`): 9 distinct `declaration uses sorry` —
Contact 3 (the moves), UnitArc 5 (`bend_toward`, `bend_away`, `flankQ_upper_shadow`, `flankQ_lower_shadow`, `nb4p`), BaseSteps 1 (`n3_end`) — and no
other warning.

**Re-pricing** (this job, about 250k tokens of work after the readback): the merge and its checks about 40k; `pair_i` about 60k (one pass of children,
one of the core, both nearly first-time clean); engine 5 and the two FLANK-Q assemblies about 70k, the mirror a third of the first side.

## Stage 38 — SAVED (FS131-I4m): readback, the as-given build, and `n3_end`'s `hQR` question

*FS131-I4m (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4m-wave4.md` on `main`) continues this record from `68ca5f0f`. Its
leaves: `UnitArc`'s `bend_toward`, `bend_away`, `flankQ_upper_shadow`, `flankQ_lower_shadow`, `nb4p`, and `BaseSteps`' `n3_end`. `Contact.lean` is not
edited here.*

**The brief's quotations against their sources** (standing rule 3). Four blocks: (1) item 280 — `plans/FS131-close-inventory.md` on `main` (line 2071):
**matches as a truncation**. (2) item 281 — same file (line 2089): **matches as a truncation**. (3) "**What is left (6 in this job's files): UnitArc
`bend_toward`, `bend_away`, `flankQ_upper_shadow`, `flankQ_lower_shadow`, `nb4p`; BaseSteps `n3_end`.**" — this record, Stage 37: **matches exactly**.
(4) "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" —
`plans/FS131-w4-kernel-plan.md` § 14.2 (line 887): **matches as a truncation**. Items 268–269 read in full (on this branch `exists_merge` still carries the
off-rim clause; the ruled vertex clause is `fs131-w4m`'s). No mismatch.

**The worktree as given** (`68ca5f0f`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK —
all 1744 modules already up to date, nothing built, 3 module(s) with warnings, 2s", exit 0 (`build/gate/build/20261004T234345Z-3556418.log`; driver log
`data/fs131/i4/build-i4m-readback.log`): 9 `declaration uses sorry` — Contact 3 (l. 4064, 4078, 4094), UnitArc 5 (l. 2645, 2658, 3427, 3736, 4182),
BaseSteps 1 (l. 1648) — and no other warning.

**`n3_end`'s question (brief, Done means 2): does its proof need FLANK-Q's (Q)/(R2) dichotomy? — No, on my reading (one mind).** NB3-END item 1
(`plans/FS112-NB3-verification.md` l. 230–231) splits on "an upper bound of `H_±` is `+1`" against "both upper bounds are `< 1`", and concludes in the first
case only that the chain is `{P_0}` — the clause `n3_end` does not state (finding N-END-CHAIN, plan § 8.2). The Lean statement splits differently: its second
disjunct is "the flank colour `g` is a contact at `N`, in-type, `κ₂ = 1`, and every `c`-horn along `α + π` has `κ₃ = −1`". So item 1 serves only as a case
split, and the split the proof needs is on `g` at `N`:
- **`g ∈ P_cl(N)`**: the contact is in-type or out-type (`contact_inType_or_outType`). Out-type forces `κ₂ < 1`: at `κ₂ = 1` the flank lies inside `B(N, 1)`,
  so a `g`-tile at `N` is unit-near the flank tile (N-E2) and lies in `B̄(v, 1)` — FLANK-Q's (Q)-branch argument, which reads `g ∈ P_cl(N)` and never (Q).
  In-type forces `κ₂ = 1` (`κ₂ ≤ 1` by `woodallCone`, since `HasSectors v c 2` and no MERGE give `int D_c(v) = ∅`; `κ₂ ≥ 1` by N-E2 of the in-type tile against
  the flank) and `κ₃ = −1` (`flankQ_both`, which carries no `hQR`, or N-E2 against the `−a` horn's `+n` flank directly). The second disjunct.
- **no in-type `g`-tile at `N`** — which includes `κ₂ = 1` with `g ∉ P_cl(N)`, i.e. FLANK-Q's (R2) branch or the out-contact arc `hQR` would exclude: the first
  disjunct, by items 2–5. Item 2 reads "upper bound `< 1`" only to exclude an in-type `g`-tile at `N` ("the flank is not in `B̄(N, 1)`"); with no `g`-tile at
  `N` at all its conclusion (`g`-tiles at `S′` tangent to `±a`, out-type) follows the same way, and items 3–5 never read the upper bound. **This extends NB3's
  text** (which leaves the case `κ₂ = 1`, `g ∉ P_cl(N)` to item 1, whose conclusion is not the statement's) — a reading, one mind, not a statement defect.
So no hypothesis is missing for `hQR`'s sake, and I send no message. **What the leaf does need**: NB3 items 2–5 for a horn whose lower arc is a unit arc
(`κ₁ = −1`) with no Condition 5. Contact's shadow machinery — `flank_shadow_g`/`_h`, `flank_shadows`, `shaveAvailable_of_not_doublyShadowed`,
`stuck_structure` — assumes Condition 5 and curvatures in `(−1, 1)`, so none applies; the SHAVE analysis, the `g`-sectors at `S′`, N3-DEG at `S′` (the
non-strict `woodallCone`, no Condition 5, does apply), the colours `y ≠ z` and the in-type `y`-tile at `P_{−2}` are new work: a `stuck_structure`-sized leaf.

**Order of this job**: the two shadow leaves first (one route, both mirrors), then the others as the budget allows.

## Stage 39 — SAVED (FS131-I4m): `flankQ_upper_shadow`, `flankQ_lower_shadow` — FLANK-Q is sorry-free; 7 `sorry` left on the branch (Contact 3, UnitArc 3, BaseSteps 1)

**The shadow clause proved, both mirrors, on a shorter route than Stage 36's.** Stage 36's step 1 (the cusp: no `g` inside `B(N, 2)` near `R₂`, by
validity against the flank) is not needed, and with it neither validity nor the flank is read: at a point `p` of `R₂` where the arcs nearby lie on
the circle of radius `2` about `N`, the two sides of that circle near `p` are each one colour, and `p ∈ cl(region g)` makes one of them `g`; `ω(z)`
crosses the circle at `p` transversally, so it enters **both** sides, and the intermediate value theorem in the `g` side gives a `g`-point at distance
exactly `1` from `z`. Children, in `UnitArc` (the first five before `namespace ArcMap` ahead of FLANK-Q, the rest just before `flankQ_upper_shadow`):
- `r2Cross` (def: `arg u + arccos((3 + ‖u‖²)/(4‖u‖))`, with a spec example at `u = 2`), `sq_norm_two_e_sub` (`‖2e(t) − u‖² = 4 + ‖u‖² − 4‖u‖cos(t − arg u)`),
  `r2Cross_spec` (for `1 < ‖u‖ < 3`, `Im u > 0`: `0 < arg u < r2Cross u < arg u + π/2`, inside `ω(u)` between `arg u` and the crossing, outside from it
  to `arg u + π`), `continuousAt_r2Cross_one`, `r2Cross_one` — the crossing angle and its limit `0` at `u = 1`.
- `Arc.finite_inter_sphere_two_or_subset` (the homothety `z ↦ (z + C)/2` carried through wave 3's `Arc.finite_inter_sphere_or_eq_circ`: a
  nondegenerate arc meets `sphere C 2` finitely or lies on it); `ArcMap.eventually_arcs_on_sphere_two` (at `C + 2e(θ₀)` in the domain, for every
  `θ ≠ θ₀` near `θ₀` the point `C + 2e(θ)` is in the domain and some ball about it meets the arcs only on the circle).
- `ArcMap.exists_polarBox_subset_region` (at such a point in `cl(region g)`, the polar box just outside or just inside the circle lies in `region g`;
  the boxes are images of products of intervals, so preconnected; a `g`-point near `p` is put in polar form with `arg` continuous at `2`);
  `ArcMap.mem_shadow_of_crossing` (with points of the circle at angles arbitrarily near `p`'s both inside and outside `ω(z)`, `z ∈ shadow (region g)`).
- `flankQ_upper_shadow`: `u = (z − N)/e(α − π/2)` is `(1 − frameY) + i·frameX`, so `Im u > 0` on the horn and `‖u‖ = dist z N > 1`; `u → 1` at `v`,
  so the crossing angle tends to `0` uniformly on small horns; the crossing point `N + 2e(α − π/2 + r2Cross u)` lies in `R₂` and off the finitely many
  special points. `flankQ_lower_shadow`: the same at `S′` with `conj u` and the angle `α + π/2 − r2Cross (conj u)`.
`hF` and `hg` are unread in both (bound by `have _ :=`, as FLANK-Q's `hcN`); `hv` is read once, for `S′` (resp. `N`) in the domain.
Read against § 12.2 and Stage 36's statement: same statements (`tools/fs131_i4_stmts.py 70075915 …UnitArc.lean`: 126 old, 134 new, 8 added, 0 changed,
exit 0). With them **`flankQ_upper`, `flankQ_lower` read the standard three**.

**Records**: `tools/fs131_i4_addrecords.py` — 629 names, 8 added; `--check` exit 0. **Duplicates**: `tools/fs131_i4_treedupes.py` — 7,550 declarations
(7,541 + the 9 added: 8 theorems and `r2Cross`), the same 3 pre-existing repeats. **Axioms** (`data/fs131/i4/axioms-i4m-39.txt`, this stage's
oleans, not a gate log): the eight children, `flankQ_upper_shadow`, `flankQ_lower_shadow`, `flankQ_upper`, `flankQ_lower` — all
`[propext, Classical.choice, Quot.sound]`. No `native_decide`, no axiom, no import changed. **Build**: "build: OK — 444 of 444 batches, 3 module(s)
rebuilt, 3 module(s) with warnings, 10m0s", exit 0 (`build/gate/build/20261005T000153Z-3696869.log`; driver log `data/fs131/i4/build-i4m-stage39.log`):
7 distinct `declaration uses sorry` — Contact 3 (the moves), UnitArc 3 (`bend_toward`, `bend_away`, `nb4p`), BaseSteps 1 (`n3_end`) — and no other
warning.

**Re-pricing**: Stage 36 priced the pair at "a session, 300–400 lines"; it took about 490 lines and about 40k tokens, nearly first-time clean, because
the cusp step dropped out.

## Stage 40 — SAVED (FS131-I4m): `nb4p` (FS112-NB4P); 6 `sorry` left on the branch (Contact 3, UnitArc 2, BaseSteps 1), and the handoff

**`nb4p` proved**, on NB-4's own route (`plans/FS110-NB-verification.md` § 2.3) with W1 (ii)'s corrections (`plans/FS112-N-proof.md` § 2.1), read in full
before planning, as § 13.5 asked. The half-plane step is wave 3's GERM-R lemmas (`Valid.cone_re_nonpos_of_germ` / `_nonneg_of_germ`) applied at `v`
itself, so no tile is needed except in (3). Children, in `UnitArc`:
- `sq_norm_e_add_e`, `e_add_third_add_e_sub_third` (`e(a + 60°) + e(a − 60°) = e(a)`, so `y_k` is the point of `ω(y_{k+1})` at angle `θ − 60°`);
  `cos_int_mul_third_pos`, `cos_int_mul_third_neg` (the sign of `cos(m·60°)` by `m mod 6`); `exists_opposite_cos_third` (NB-4's closing count as a sign
  table: for orbit indices `j ≠ l` and a parity `p`, some `k ∈ {p, p + 2, p + 4}` has `cos((j − k)·60°)`, `cos((l − k)·60°)` of opposite strict signs —
  `interval_cases` and `decide` over the 60 cases).
- `ArcMap.germ_rotate_third` (the ring rotates its colours: a germ of `ω(v)` in class `c`, and `r(θ + 60°)` on no arc of `Γ` on `ω(v)` ⟹ the same-side germ
  there lies in a class `d ≠ c` absent at `v`; `germ_dichotomy`, N-E1, validity at distance `1`).
- `ArcMap.straddlers_third` (W1 (ii)'s (1) and (3) with NB-4's half-planes: the germ of `ω(y_{k+1})` at `y_k` inside `B(v, 1)` lies in one colour `i`, the
  outer germ in `o ≠ i`; both colours of `v`, carried at `y_k`, not at `y_{k+1}`; `v`'s class of `i` approaches `v` only facing `y_k`, that of `o` only
  facing away. `i ≠ o` by N-E2: the inner germ's tile is unit-near `v`'s `i`-tile, the outer germ's unit-far, so that tile lies on `ω(y_k)` — empty
  interior, `interior_sphere`).
- `nb4p`: (1) `germS_absent` gives the two absent colours `X`, `X'`; the ring alternates `X | X'` / `X' | X` at `y_0, …, y_5` (induction, `hring`), so
  every `y_j`, `j ≤ 6`, carries both; (2) `straddlers_third` at each `k < 6` (`hnb`'s first half); (3) the pairs `Q_k = {i_k, o_k}` alternate:
  `Q_{k+1} ⊆ P_cl(v) ∖ Q_k`, both of size two, so `Q_{k+1} = P_cl(v) ∖ Q_k` and `Q_{k+2} = Q_k` — every colour of `v` is a straddler at the three orbit
  points of one parity; (4) by the sign table each colour's cone at `v` holds at most one of the six orbit directions; (5) every direction is in some
  colour's cone (`exists_mem_coneAt_region`), so six directions inject into four colours.
**Generalization**: `hnb`'s second half (no arc of `ω(y_{j−1})` through `y_j`) is never read — W1 (ii)'s equality `Q⁻_{k+1} = Q⁺_{k+1}` is not needed,
since the alternation of the `+` pairs alone gives the parity classes. Read against § 12.2 and the row: same statement.

**Records**: `tools/fs131_i4_addrecords.py` — 636 names, 7 added; `--check` exit 0. **Statements**: `tools/fs131_i4_stmts.py e1c75f21 …UnitArc.lean` 134
old, 141 new, 7 added, 0 changed, exit 0; planted control (nb4p's `hv` changed to `Covers v 2` in the working file): "1 changed, CHANGED nb4p", exit 1;
file restored byte for byte, re-run exit 0. **Duplicates**: `tools/fs131_i4_treedupes.py` — 7,557 declarations (7,550 + 7), the same 3 repeats.
**Axioms** (`data/fs131/i4/axioms-i4m-40.txt`, this stage's oleans, not a gate log): the seven children and `nb4p`, all `[propext, Classical.choice,
Quot.sound]`. No `native_decide`, no axiom, no import changed. **Build**: "build: OK — 444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with
warnings, 10m11s", exit 0 (`build/gate/build/20261005T001554Z-3797153.log`; driver log `data/fs131/i4/build-i4m-stage40.log`): 6 distinct `declaration
uses sorry` — Contact 3 (the moves), UnitArc 2 (`bend_toward`, `bend_away`), BaseSteps 1 (`n3_end`) — and no other warning.

**What is left (3 in this job's files): UnitArc `bend_toward`, `bend_away`; BaseSteps `n3_end`.** Contact's three moves are IM3's.
- **The bends** (plan § 13.5, Stage 24): engine 3 (the cut, `exists_cut_ringArc`, not yet stated) removes the open arc from every arc of `ω(P)`; the new
  map adds the bent arc and recolours the lens; engines 1–2 give validity from the clearness and `RingArcsWithin`; the clearness is N2-ENV (proved) with
  N2-SIGN; the cap at the ends is N2-TOWARD's corner/tangent start; for `bend_away` the tangent bend at isolated R2 contacts (N2-TAN, `TAN` exact in
  `tools/fs112_n2_checks.py`). Each is a construction, not a reduction: price a session each, the cut first.
- **`n3_end`**: Stage 38's reading — no `hQR` needed; split on "an in-type `g`-tile at `N`" (second disjunct: `κ₂ = 1` by `woodallCone` and N-E2,
  `κ₃ = −1` by `flankQ_both`) against its absence (first disjunct by NB3 items 2–5). The obstacle is infrastructure: every shadow and SHAVE lemma in
  `Contact` (`flank_shadow_g`/`_h`, `flank_shadows`, `shaveAvailable_of_not_doublyShadowed`, `stuck_structure`) assumes Condition 5 and curvatures in
  `(−1, 1)`, and `n3_end`'s horn has `κ₁ = −1` with no Condition 5. What applies as is: `woodallCone` (non-strict), `contact_inType_or_outType`,
  `outType_N_of_flankAbove`/`outType_S_of_flankBelow`, `IsHorn.exists_flankAbove`/`_flankBelow`, `flankQ_both`, `flank_siamese_of_inType`,
  `inType_shadows_horn`, `noBoth`, and the two shadow lemmas of Stage 39 (`mem_shadow_of_crossing` is the general "a circle crossing a class's closure
  where the arcs are on a circle" engine). The new work is item 2 at a unit-arc bound (which `g`-contacts can shadow the horn near `v`: only `g`-tiles at
  `S′` tangent to `±a`, out-type), item 3 (`woodallCone` at `S′` for `g`, `Terminal` there), item 4 (the colours `y ≠ z` beside `g`'s `+a` horn at `S′`, the
  SHAVE contradiction for `z = y`) and item 5 (the in-type `y`-tile at `P_{−2}`, Siamese to the lower flank, putting the horn's lower arc on `ω(P_{−2})`;
  `noBoth`). Price: a `stuck_structure`-sized leaf, two sessions.

**Re-pricing**: `nb4p` (§ 13.5's H, "the one leaf whose derivation must be re-read in full") took about 360 lines and about 60k tokens, first build clean
after six scratch iterations; wave 3's GERM-R lemmas did the geometric half.

## Stage 41 — SAVED (FS131-I4n): readback, the as-given build, and `bend_away`'s statement defect (sent to Keryx)

*FS131-I4n (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-I4n-wave4.md` on `main`) continues this record from `a0c29483`.
Its job: merge `fs131-w4m` (at `67256973`), make `Contact` cite SHAVE and RAY, move `n3_end` to wave 5 (item 289 (b)), prove `bend_toward` and
`bend_away`.*

**The brief's quotations against their sources** (standing rule 3). Five blocks: (1) "**What is left (3 in this job's files): UnitArc `bend_toward`,
`bend_away`; BaseSteps `n3_end`.** Contact's three moves are IM3's." — this record, Stage 40: **matches exactly**. (2) item 288 — `plans/FS131-close-inventory.md`
on `main` (l. 2171): **matches as a truncation**. (3) item 289 (l. 2187): **matches as a truncation**. (4) item 286 (l. 2148): **matches as a truncation**.
(5) "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" —
`plans/FS131-w4-kernel-plan.md` § 14.2 (l. 887): **matches as a truncation**. `origin/fs131-w4m` is at `67256973` as the brief says. Items 288–289 read in
full; I4m's Stages 38–40 and IM's record §§ 3, 6–10 (on `fs131-w4m`) read. No mismatch.

**The worktree as given** (`a0c29483`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK —
all 1744 modules already up to date, nothing built, 3 module(s) with warnings, 2s", exit 0 (`build/gate/build/20261005T003233Z-3932168.log`; driver log
`data/fs131/i4/build-i4n-readback.log`): 6 `declaration uses sorry` — Contact 3 (l. 4064, 4078, 4094), UnitArc 2 (l. 2645, 2658), BaseSteps 1 (l. 1648) —
and no other warning.

**`bend_away` is false as written — a statement defect, sent to Keryx at this stage (message to "main").** Nothing in the statement puts the radius-2 arc
`R₂(ᾱ)` in `F.dom`, and off the domain `closure (F.region c)` may meet `R₂(ᾱ)` in an infinite nowhere-dense set of angles; then `C₂` holds no non-degenerate
interval and the conclusion demands the whole open arc be bent away, which no `F'` can do. **Counterexample** (`k = 2`, `c ≠ c'`, `P = 0`, `θ₁ = 0`,
`θ₂ = ℓ = 0.1`, `η`, `δ` small): `K = {0.05} ∪ {0.05 + 0.001/n : n ≥ 1}`, `f = infDist · K`; `N = {ρe(φ) : 1 − η < ρ < 1 + η, −η < φ < ℓ + η}`,
`Y = {ρe(φ) : 0 < φ < ℓ, 2 + f(φ) < ρ < 2 + f(φ) + δ}`, `dom = N ∪ Y`; one arc `circ 0 1 (−η) (ℓ + η)`; colour `c` on `N`'s inside and on `Y`, `c'` on
`N`'s outside. Valid (inner pairs `< 1`: angular gap `< π/3`, radii `< 1`; inner–`Y` `> 1`; `Y` and `N`'s outside of diameter `< 1`); `IsRingArc 0 0 ℓ c c'`;
`c ∉ coloursAt 0`; `C₂ = K` (the closure of `Y` meets the radius-2 circle where `f = 0`, points not in `dom`). For any `F'` with `AgreesOff F
(thickening ε ᾱ)` (`ε < η/2`) and `F'.region j ⊆ F.region j` for `j ≠ c`: (1) if `r(φ)`, `φ ∈ K`, is `F'`-interior its colour is `c` (it lies on `F.Γ`),
so by local constancy `z = (1 + s)e(φ)` is `F'`-interior of colour `c` for small `s > 0`, while `w = (2 + s)e(φ) ∈ Y` is untouched, of colour `c`, at
distance `1`: `F'` invalid; (2) otherwise `r(K) ⊆ F'.Γ`; near `r(0.05)` finitely many `F'`-arcs, so one holds infinitely many points of `r(K)`, hence is
`circ 0 1 θa θb` (`Arc.finite_inter_sphere_or_eq_circ`), and a point of `K` with parameter inside `(θa, θb)` is `F'.OnRingArc`, needing a non-degenerate
interval inside `K`. **Likely repair** (Keryx's and the planner's call): `(hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom)` — the derivation's "`C₂` is a finite union
of points and closed arcs" (FS112-N-proof N2-TAN) reads local finiteness there. **`bend_away_whole` is true as stated** with no domain hypothesis (`R₂`
compact and disjoint from the closed class: positive distance; N2-ENV-away clears the lens), but today it is proved *through* `bend_away`; I proposed to
prove it directly, statement unchanged, on the mirrored lens of `bend_toward`. No other Lean consumer of `bend_away` (grep on `fs131-w4`, `-w5`, `-w5p`,
`-w4mm`). **`bend_toward` is true as stated, on my reading**: the lens's far colour `c'` is kept off by `c' ∉ coloursAt P` (a positive distance from `P`,
for N2-ENV toward) and by N2-SIGN with N2-ENV's near clause; nothing reads the domain beyond a thickening of `ᾱ`.

**The plan for `bend_toward`** (the construction, fixed before writing): the new boundary is one circular arc through `A`, `B` of radius `R > 1`, centre
`C = P − d e(φ_m)` (`φ_m` the arc's middle angle, `h = ℓ/2`, `R² = 1 + 2d cos h + d²`, `d` small); the lens is `L = {z : |z − P| ≤ 1, R < |z − C|}`, which
holds the open arc `O` and lies in the circular segment beyond the chord; in polar form `z = P + (1 − s)e(φ)`, `|φ − φ_m| < h` and `s < 2d·Δ(φ)`, so N2-ENV's
profile is met by `2d ≤ ψ`. The arcs of `F'`: every arc of `F` not of the form `circ P 1 _ _` kept; each `circ P 1 θa θb` replaced by its sub-arcs over
`[θa, θb] ∩ [θ₂ + 2πm, θ₁ + 2π(m + 1)]` for `m = ⌊(θa − θ₂)/2π⌋` and `m + 1` (non-degenerate ones; a dropped single point is `A` or `B`, on the new arc);
the new arc `circ C R (φ_m − γ) (φ_m + γ)`, `γ = arccos((d² + R² − 1)/(2dR))`, whose carrier is exactly `sphere C R ∩ closedBall P 1`. Colour `c'` on `L`,
`F`'s elsewhere. Validity by engine 1 (lens points clear: N2-ENV toward and near, N2-SIGN; points of `O` by `ne1_region`; two lens points are never at
distance `1`, `|φ − φ'| < π/3`); no unit arc by engine 2. `Surgery`'s `Near.exists_cut` and `ArcMap.surgery` are ball-centred (they trim `B(v, ρ)` and add
`∂B(v, ρ)`) and do not serve a cut along `ω(P)`; its `Arc.sub`, `Arc.nondegenerate_sub`, `Arc.carrier_sub` do, and are reused.

## Stage 42 — SAVED (FS131-I4n): `fs131-w4m` merged; `Contact` cites SHAVE and RAY; `n3_end` moved to wave 5; the ruling on `bend_away`

**Keryx's ruling on `bend_away` (inventory items 290–291, message of this stage)**: the repair is adopted — `bend_away` gains the hypothesis that the
radius-2 arc `radiusTwoArc P θ₁ θ₂` lies in `F.dom`, with its docstring rewritten; `bend_away_whole` is proved directly on `bend_toward`'s lens mirrored,
statement unchanged; order: `bend_toward`, `bend_away_whole`, the repaired `bend_away`; if the repaired leaf is not done when MERGE lands it moves out
of wave 4. The statement change is made in the commit that proves `bend_away_whole` directly (so no proved leaf regresses to `sorry` meanwhile).
**On the smallest hypothesis** (Keryx asked): the arc in the domain is a neighbourhood of it for free (the arc is compact, the domain open), so
nothing more is needed for `C₂` to be locally a finite union of points and closed intervals.

**The merge** (`8c50673c`, made without paths): `git merge origin/fs131-w4m` at `67256973`. `Contact` merged cleanly. Conflicts only in
`ARCHITECTURE.md` (both sides kept: `fs131-w4m`'s `Contact`, `Cone`, `Surgery`, `Moves` rows — the two `Contact` descriptions were identical, `w4m`'s
Imports cell adds `Cone` — and `fs131-w4`'s `UnitArc` row with its `Sectors` import) and `scripts/Axioms.lean` (both audit blocks, IC5's then IM's,
above the `=== PURCHASED ===` banner; records 2509 + 2539 − 2368 at the base = 2680, no record twice). Item 244's `localSectors_disj` is kept
(`LocalStructure` l. 4608). **Checks**: `tools/fs131_i4_treedupes.py` — 7,749 declarations, the same 3 pre-existing repeats as both parents
(`data/fs131/i4/treedupes-i4n-merge.log`); `tools/fs131_qa1_dupes.py` — the same 6 cross-body names as at I4l's merge (it reads branch refs, not the
working tree; `data/fs131/i4/qa1dupes-i4n-merge.log`); **the statement comparison against both parents** — a new tool,
`tools/fs131_i4_mergestmts.py` (every theorem statement of `Proofs/`, keyed by name so files may move, checked three-way: a side that changed a
name's statements from the merge base wins, both changing it is a conflict, and the merged tree must hold exactly the result): 5,416 names, 0
mismatches, PASS (`data/fs131/i4/mergestmts-i4n.log`); **planted control** (`--plant`: one statement `fs131-w4m` added, altered in the merged view):
"MISMATCH Arc.finite_inter_sphere_of_not_isUnitArc", FAIL, exit 1 (`data/fs131/i4/mergestmts-i4n-plant.log`), beside the faithful run's PASS;
`tools/fs131_im_statements.py --check` and `tools/fs131_im_split.py --check` PASS; `tools/check_architecture.py` PASS
(`data/fs131/i4/check-architecture-i4n-merge.txt`). **Build**: "build: OK — 446 of 446 batches, 5 module(s) rebuilt, 4 module(s) with warnings,
9m35s", exit 0 (`build/gate/build/20261005T004304Z-4022253.log`; driver log `data/fs131/i4/build-i4n-merge.log`): `sorry` only — UnitArc 2, Contact 3,
BaseSteps 1, Moves 1 (`exists_merge_aux`).

**The citations** (`7011ce9e`): `Contact` imports `Plane/ValidMap/Moves` (no cycle: `Moves` → `Surgery` → `Cone`), and `exists_shave`, `exists_rayMerge`
are `exact exists_shave_aux …`, `exact exists_rayMerge_aux …` (statements identical, `tools/fs131_im_statements.py --check` PASS); `exists_merge` stays
`sorry`. `ARCHITECTURE.md`'s `Contact` Imports cell gains `Moves`; `check_architecture` PASS.

**`n3_end` moved out** (`addf6e8e`, item 289 (b)): its section header, docstring and declaration deleted from `BaseSteps` and its record from
`scripts/Axioms.lean` — the resulting `BaseSteps.lean` is **byte-identical** to FS131-I5d's on `fs131-w5` (`4a126455`, `diff` empty), so the later merge is
clean. (I5d left `BaseSteps`' module docstring, l. 20, and `ARCHITECTURE.md`'s `BaseSteps` row still naming `n3_end`; I left them identical for the
same reason — a stale mention for whoever merges the waves.)

**Build of both** (one run): "build: OK — 446 of 446 batches, 3 module(s) rebuilt, 3 module(s) with warnings, 10m0s", exit 0
(`build/gate/build/20261005T010142Z-4169366.log`; driver log `data/fs131/i4/build-i4n-cite.log`): `sorry` only — UnitArc 2 (`bend_toward`, `bend_away`),
Contact 1 (`exists_merge`), Moves 1 (`exists_merge_aux`); none in `BaseSteps`.

**The bends in scratch** (`data/fs131/i4/scratch-i4n/Cut.lean`, against the real oleans, iteration only): engine 3 (`cutArcs` and its lemmas), the
generic bend (`bendMap` and its five transfer lemmas), the lens geometry, and `bend_toward'`, `bend_away_whole'` elaborate sorry-free, both printing
`[propext, Classical.choice, Quot.sound]`; 17 s, 3.4 GB. They go into `UnitArc` next.

## Stage 43 — SAVED (FS131-I4n): `bend_toward` and `bend_away_whole` proved (engine 3, the generic bend, the lens geometry); `bend_away` repaired and left `sorry` — it leaves wave 4 (items 291 (d), 295 (b))

**The amendment of 2026-10-05** (inventory items 294–295), read back: its quotation of item 295's first line, and the 2026-10-04 amendment's of item 291's,
match `plans/FS131-close-inventory.md` on `main` (l. 2274, 2210) as truncations. For this job: `bend_away`'s trigger is my hand-back; `exists_merge` and
`exists_merge_aux` stay `sorry` (the merge-and-gate job deletes them).

**Engine 3 and the bend** (in `UnitArc`, a block before `r2Contacts`; the namespace `ArcMap` is closed for the geometry and reopened):
- *The cut* — `cutArcs F P θ₁ θ₂` (defs `cutLo`, `cutHi`): every arc of `F` that is not an arc `circ P 1 θa θb` of `ω(P)` kept; each arc of `ω(P)` replaced by
  its non-degenerate pieces over `[θa, θb] ∩ [θ₂ + 2πm, θ₁ + 2π(m + 1)]`, `m ∈ ℤ`. Lemmas: `cutArcs_nondegenerate`, `cutArcs_subset`, `finite_cut_pieces`,
  `cutArcs_locallyFinite`, `ringPt_mem_openArc_iff`, `disjoint_piece_openArc` (pieces miss `r((θ₁, θ₂))`), `mem_cut_of_mem_circ` (off the open arc and its
  two ends, a point of an arc of `ω(P)` is on a piece — a dropped single-point piece is an end), `mem_cutArcs_iff`, `exists_kept_of_mem_openArc`.
- *The generic bend* — `bendMap F P θ₁ θ₂ a L j` (the cut, one new arc `a`, colour `j` on the lens `L`: `bendCol`) and its transfer lemmas, each over named
  hypotheses on `L` and `a` only: `bend_hlc` (local constancy — inside the lens off `ω(P)` by openness; at the open arc, the lens on one side and `F`'s class
  of `j` on the other, `hside`, `hcol`; off the lens `F`'s, `closure L ⊆ L ∪ a.carrier`), `bendMap_interiorPts`, `bendMap_agreesOff`,
  `bendMap_ringArcsWithin` (engine 2), `bendMap_valid` (engine 1: the lens clear for `j`, no unit pair in it), `bendMap_region`, `bendMap_not_onRingArc`
  (near a point of the open arc only kept arcs of `F` meet `ω(P)`, finitely often, `Arc.finite_inter_sphere_or_eq_circ`; the domain read only at the open
  arc). `Surgery`'s `ArcMap.surgery` and `Near.exists_cut` are ball-centred (they trim `B(v, ρ)` and add `∂B(v, ρ)`), so they do not serve a cut along
  `ω(P)`; none of `Surgery` is imported.
- *The lens geometry* (outside `ArcMap`): `cos_sub_cos_le_sub`, `abs_le_of_cos_le`, `abs_lt_of_cos_lt`; the profiles `polar_toward(_strict)`,
  `polar_away(_strict)` (from `1 − ‖w‖² ≤ 2d(Re w − cos h)`, resp. `‖w‖² − 1 ≤ …`, `d ≤ 1/2`: `|arg w| ≤ h` and depth `≤ 2d(h − |arg w|)`); the frame along
  `e φ` (`norm_frameDir`, `eq_polar_frameDir`, `dist_sq_sub_dir`, `dist_sq_add_dir`, `re_frameDir_ringPt`, `re_frameDir_sub_dir`, `re_frameDir_add_dir`);
  **`carrier_circ_arccos`** (the arc `circ C R (φ ∓ arccos(τ/R))` is the circle's part with component `≥ τ` along `e φ`), whence `toward_carrier` (the
  circle about `P − d e(φ_m)` of squared radius `1 + 2d cos h + d²` inside `B̄(P, 1)`) and `away_carrier` (about `P + d e(φ_m)`, `1 − 2d cos h + d²`, outside
  `B(P, 1)`); `toward_polar(_strict)`, `away_polar(_strict)`, `toward_pairs` (two toward lens points: `|z − z'|² < ρ² + ρ'² − ρρ' ≤ 1`),
  `dist_polar_polar_sq`, `dist_polar_ringPt`, `min_add_sub_eq`, `le_on_Icc_of_Ioo`, `ge_on_Icc_of_Ioo`, `one_add_le_two_cos`, `away_mem_lens` (an away lens
  point lies in `B̄(A, 1) ∩ B̄(B, 1)`), and in `ArcMap` `mem_thickening_ringArc_of_polar`, `away_circle_facts`, `away_pairs`.
- *Clearness* (N2-TOWARD's, N2-AWAY's): `toward_clear` (a near point of the outer class lies in `B̄(A, 1) ∩ B̄(B, 1)` by N2-SIGN and `le/ge_on_Icc_of_Ioo`,
  within `< 1` of the lens point by `n2_env_near`; a far one in `B(P, r)` by `n2_env_toward`, which the class misses since `c' ∉ coloursAt P`); `away_clear`
  (the same with `n2_env_near_away` off `B(P, r)` and `n2_env_away`'s `r`-neighbourhood of `R₂(ᾱ)`, which the class misses by `hR2`); `away_lens_clear`
  (points of `ω(P)` in the lens by `ne1_region`).

**`bend_toward`** (FS112-N2-BENDS, N2-TOWARD), statement unchanged: `ℓ ≤ 60°` by `l60_le`; `r` the distance of the outer class from `P`; `ψ₁`, `ψ₂` from
`n2_env_toward`, `n2_env_near`; `d = min(ψ₁, ψ₂, ε)/4`; the lens `L = {|z − P| ≤ 1, 1 + 2d cos h + d² < |z − (P − d e(φ_m))|²}` (in polar form inside the
angle with depth `< 2dΔ`), the new arc `toward_carrier`'s; `bendMap` with `j = c'`, `S = (B̄(P, 1))ᶜ`. **`bend_away_whole`** (N2-AWAY), statement
unchanged, now proved directly (it no longer cites `bend_away`): the mirror, `r` below the class's distances from `P` and from the compact `R₂(ᾱ)` and `≤ 1/2`,
`d = min(ψ₁, ψ₂, ε, 1/2)/5 ≤ 1/10`, `L = {1 ≤ |z − P|, |z − (P + d e(φ_m))|² < 1 − 2d cos h + d²}`, `j = c`, `S = B(P, 1)`; the pairs by `away_pairs`. The
declaration's single heartbeat budget forced the clearness and the pairs into children (`away_lens_clear`, `away_pairs`, `away_circle_facts`), per LEAN.md.

**`bend_away`**: the ruled repair applied (items 290–291 (a)) — `(hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom)` after `hin`, docstring rewritten (the repair, its
reason, the Stage-41 counterexample's address); otherwise unchanged (`tools/fs131_i4_stmts.py a0c29483…`: 1 changed, `ALLOWED bend_away`). **Not proved; it
leaves wave 4 at this hand-back** (items 291 (d), 295 (b)). What its proof needs, for its job (my reading, one mind, not a derivation): (1) `C₂(ᾱ)` is a finite
union of points and closed intervals — local finiteness at the compact `R₂(ᾱ) ⊆ dom` with I4m's `Arc.finite_inter_sphere_two_or_subset`; (2) the set to clear
is `(θ₁, θ₂)` minus the non-degenerate components of `C₂`, a finite union of open intervals; (3) the lens over each is `B̄`-intersection of finitely many
discs (corner circles at free ends as here; at each isolated contact `w₀` and at each component end, a disc of radius `1/κ > 1` containing `B(P, 1)` and
tangent at `r(w₀)`) minus `B(P, 1)`, its boundary arcs cut by half-planes (`carrier_circ_arccos`), `bendMap` unchanged; (4) clearness at an isolated contact
`q₀ = P + 2e(w₀)`: the inner class near `q₀` is far (N2-SIGN), so outside `⋃_{w ∈ int α} B(r(w), 1)`, and its sectors at `q₀` (wave 3's chart at `q₀`) rise
linearly or with a tangent germ of curvature `< 1/2` (curvature `1/2` on a side is an interval of `C₂` there); with `1 − κ` small against that rise the cap
of `ω(z)` beyond radius 2 misses them — an inf-convolution inequality `ε₀x² − c(y − x)² < Gy²`; (5) **at an end of the arc** the uncovered region near
`q_A` is bounded by `ω(A)` (curvature `1`, tangent to the radius-2 circle at `q_A`) on the far side, so a class hugging `ω(A)` from outside is not covered by
(4)'s curvature `< 1/2` analysis; N2-AWAY says "the end vertex's own blocker is exactly R2 at the end" [hand, one mind] — this step should be re-derived
before the kernel work starts. Price: two to three sessions, (4) and (5) the risk.

**Records**: `tools/fs131_i4_addrecords.py` — 582 names, 56 added (the new theorems), `--check` 0 missing. **Spec examples** for the five new definitions:
`cutLo`/`cutHi` values, the cut of `unitArcPlane`'s arc `r([0, π])` at `(π/3, 2π/3)` (the piece `r([2π/3, π])` present, the whole arc absent), `bendCol` on the
one-colour plane, `bendMap`'s fields. **Statements**: `tools/fs131_i4_stmts.py 89af8b63 …UnitArc.lean --allow bend_away` — 141 old, 197 new, 56 added,
0 removed, 1 changed (`ALLOWED bend_away`), exit 0. **Duplicates**: `tools/fs131_i4_treedupes.py` — 7,809 declarations (7,749 − `n3_end` + 56 theorems + 5
definitions), the same 3 pre-existing repeats (a docstring line beginning `class` read as a declaration by the textual scanner was reworded). No import
changed; `check_architecture` PASS. No `axiom`, no `native_decide`.

**Build**: "build: OK — 446 of 446 batches, 3 module(s) rebuilt, 3 module(s) with warnings, 10m3s", exit 0 (`build/gate/build/20261005T012209Z-120054.log`;
driver log `data/fs131/i4/build-i4n-bends.log`): `sorry` only — UnitArc 1 (`bend_away`, l. 3973), Contact 1 (`exists_merge`), Moves 1 (`exists_merge_aux`).
**Axioms** (`data/fs131/i4/axioms-i4n-43.txt`, from `data/fs131/i4/axioms-i4n-43.lean` against this build's oleans, not a gate log): 62 records —
`bend_toward`, `bend_away_whole`, `exists_shave`, `exists_rayMerge` and the 56 children exactly `[propext, Classical.choice, Quot.sound]`; `bend_away` and
`exists_merge` `sorryAx` besides.

**What is left on `fs131-w4` (3 `sorry`)**: `bend_away` (leaves wave 4 at this hand-back, items 291 (d), 295 (b)); `exists_merge`, `exists_merge_aux` (the
merge-and-gate job deletes them, item 295 (a)).

## Stage 44 — SAVED (FS131-G4): readback, the as-given build, and what this job may change

*FS131-G4 (de Bruijn, the implementer, on Opus 5.5; brief `data/fs131/briefs/FS131-G4-land.md` on `main`) continues this record from `71cca146`.
Its job: wave 4's landing — delete the three declarations that left the wave, rename `framePt`, teach `tools/fs131_k4_decls.py` `_root_.` names, register
wave 4's vacuity carriers beside wave 2's and settle the vacuity notes, the full gate on one commit, merge `main`, the gate again, and fast-forward `main`.*

**The brief's quotations against their sources** (standing rule 3), each read in `plans/FS131-close-inventory.md` at `main` (`6403c145`) unless named:
item 297 (l. 2307), item 296 (l. 2285), item 295 (l. 2274), item 291 (l. 2210), item 281 (l. 2089), item 271 (l. 1980), item 260 (l. 1863), item 252
(l. 1807), item 266 (l. 1927), item 144 (l. 892), item 270 (l. 1966): each **matches as a truncation** (the brief quotes each item's first line). The
brief's parenthetical summaries read against the items in full: item 297's tasks (three deletions with their records, the `_root_.` tool fix, the
`framePt` rename, the carriers, the vacuity notes, the gate with both self-tests, the merge with `fs131_qa1_dupes.py`, the fast-forward) — as item 297
says; item 281 (b), item 271's `framePt` clause (`Plane/Slack` l. 2800 against `Plane/ValidMap/Basic` l. 44) and its carrier clause, item 260's
re-run clause, items 252 and 266's vacuity notes, item 144 (b)'s carriers — each as the item says. The plan's two quotations
(`plans/FS131-w4-kernel-plan.md` § 14.4 items 1 and 3, l. 919, l. 925 on this branch): **match exactly** (item 1 as a truncation). No mismatch.
I read the record's Stages 41–43 and the plan's § 14 in full.

**The worktree as given** (`71cca146`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK —
all 1747 modules already up to date, nothing built, 3 module(s) with warnings, 2s", exit 0 (`build/gate/build/20261005T013928Z-247025.log`; driver log
`data/fs131/g4/build-g4-readback.log`): 3 warnings, all `declaration uses sorry` — UnitArc l. 3973 (`bend_away`), Moves l. 1667 (`exists_merge_aux`),
Contact l. 1525 (`exists_merge`). `grep -cP '^\s*sorry\s*$|:= sorry|by sorry'` over `Proofs/`: those three lines (UnitArc 3980, Moves 1673, Contact
1531). `lebesgue_covering_square` is no longer `sorry` (FS131-LEB landed; `SVMap` l. 468 cites `LebesgueCovering.lebesgue_covering_square`).
`python3 tools/fs131_k4_decls.py --check`: "495 names, 2 missing", exit 1 — the two `_root_.` theorems of `Contact` (l. 368, l. 975), read as
`HadwigerNelson.Plane.ArcMap._root_.HadwigerNelson.Plane.BranchGerms.frameY_lt_of_mem` and `…lt_frameY_of_mem` (item 281 (b)'s defect, reproduced).

**What this job may change** (the brief's touches and § 14.2): the three deletions — `ArcMap.bend_away` (`UnitArc`), `ArcMap.exists_merge` (`Contact`),
`ArcMap.exists_merge_aux` (`Moves`) — each with its docstring and its `#print axioms` record, and the header lines that name them (`Contact`'s
"* **FS110-W-MERGE**: `exists_merge`."; `UnitArc`'s bends line; `Moves`' module docstring), nothing else of their modules; the `framePt` rename with
every use; inhabitants and docstring lines the vacuity step needs, in wave 4's modules; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`,
`scripts/Vacuity.lean`, `scripts/vacuity.sh`, `scripts/vacuity-baseline.txt`, `scripts/axioms-controls.txt`, `tools/fs131_k4_decls.py`, `tools/fs131_g4_*.py`,
`data/fs131/g4/`, this record, the report; `main` by fast-forward only. **What it may not**: any statement (no hypothesis, conclusion or definition the
statements use changes; `framePt`'s rename changes a name, not a definition), any `axiom`, `CLAUDE.md`, `LEAN.md`, `tools/claude_md_fact_audit.py`, another
job's tools. `Near.RayConfig.exists_merge` (`Moves` l. 1481, proved, read by `exists_rayMerge_of_clear`) is a different declaration and stays.

## Stage 45 — SAVED (FS131-G4): the three declarations deleted, `framePt` renamed `fromFrame`, `tools/fs131_k4_decls.py` taught `_root_.` names; 0 `sorry`

**The deletions** (items 291 (d), 295 (a), 297): `ArcMap.bend_away` (`UnitArc`), `ArcMap.exists_merge` (`Contact`), `ArcMap.exists_merge_aux` (`Moves`), each with
its docstring, and their three `#print axioms` records in `scripts/Axioms.lean` (exact-line matches; `Near.RayConfig.exists_merge` and `bend_away_whole` kept).
Header lines: `Contact`'s "* **FS110-W-MERGE**: `exists_merge`." and its now-empty section header `/-! ## FS110-W-MERGE -/` (I4n's precedent for `n3_end`'s);
`UnitArc`'s bends line now names `bend_toward`, `bend_away_whole`; `Moves`' module docstring (title "SHAVE and MERGE-RAY (FS110-N4-SHAVE, N4-RAY)", and the
list of `_aux` statements without `exists_merge_aux`). `ARCHITECTURE.md`: `Contact`'s row drops "FS110-W-MERGE (`exists_merge`)"; `Moves`' row names the two
moves and says W-MERGE left wave 4 (item 295 (a)). Nothing else in the three modules changed (`git diff`: 51 lines deleted, 4 rewritten). The deleted text is
on `71cca146` and on `fs131-w4mm` / `fs131-w4ba` for the later landings. **Consequence for another job's tool** (not edited, not a gate check of this
brief): `tools/fs131_im_statements.py --check` now fails on `exists_merge` ("statement missing (Moves)") by design of item 295 (a); IMM2's landing restores
both statements and its check.

**The rename** (item 271): wave 4's `HadwigerNelson.Plane.framePt` (`Plane/ValidMap/Basic` l. 44, colliding with wave 2's `Plane/Slack` l. 2800, a different
definition) is now **`fromFrame`** — "the point from frame coordinates", the inverse of `frameX`, `frameY` (`frameX v α (fromFrame v α x y) = x`). Every
identifier containing `framePt` in wave 4's three files was renamed by one substitution `framePt → fromFrame` (102 occurrences in `Basic`, `UnitArc`, `Moves`,
`scripts/Axioms.lean`, `ARCHITECTURE.md`; 102 after): the definition, `frameX_fromFrame`, `frameY_fromFrame` (root and `RayGap` copies), `sq_dist_fromFrame`,
`normalPt_add_eq_fromFrame`, `normalPt_sub_add_eq_fromFrame`, `tanHeight_one_fromFrame`, and their seven records. The definition's body is unchanged.
`fromFrame` occurs nowhere on `main`, `fs131-w5`, `-w5p`, `-w5x`, `-w4mm`, `-w4ba`, `-ww` (`git grep`, 0 each). **For wave 5's merges**: `fs131-w5`'s
`ValidMap/FlankUA` (and the copies of `Basic`/`UnitArc`/`Moves` on `-w5p`, `-w5x`, `-w4mm`, `-ww`) use `framePt` and its lemma names; after this landing they
take the same substitution in their own files. Where such a file imports `Plane/Slack` (wave 2's `framePt (x : ℂ) (θ s t : ℝ)`, same arity), a missed
`framePt` would elaborate against the other definition — a merge check should grep `framePt` in wave 4 and 5's files and find none.

**The tool** (item 281 (b)): `tools/fs131_k4_decls.py` resolves a theorem written `_root_.X` to `X` (`qualify`). Before: "495 names, 2 missing" (the two
`_root_.` theorems of `Contact`, Stage 44). Controls: `--plant-root` (the resolution off) "FIRED (2 missing, 2 _root_ names)", exit 0 — two-sided: it must
miss exactly the `_root_.` names and no other (`data/fs131/g4/k4decls-plant-root.log`); a planted dropped record (`BranchGerms.frameY_lt_of_mem`'s line removed
from a copy-restored `scripts/Axioms.lean`) — `--check` "493 names, 1 missing", exit 1 (`data/fs131/g4/k4decls-plant-drop.log`; the file restored, `cmp`
identical); the faithful `--check` "493 names, 0 missing", exit 0 (`data/fs131/g4/k4decls-check.log`) — 493 = 495 − `bend_away` − `exists_merge`
(`exists_merge_aux` is in `Moves`, outside K4's five modules). The old `--plant` (namespaces dropped) still fires (491 missing).

**Build**: "build: OK — 446 of 446 batches, 11 module(s) rebuilt, 0 module(s) with warnings, 11m7s", exit 0 (`build/gate/build/20261005T014409Z-283282.log`;
driver log `data/fs131/g4/build-g4-deletions.log`): 0 warnings (`grep -c warning` on the full log: 0). `grep -cP '^\s*sorry\s*$|:= sorry|by sorry'` over
`Proofs/`: 0. `tools/check_architecture.py`: PASS (`data/fs131/g4/check-architecture-g4-45.txt`). `tools/fs131_i4_treedupes.py`: 7,806 declarations (7,809 − 3),
the same 3 pre-existing repeats (`data/fs131/g4/treedupes-g4-45.log`).

**The ruling of this stage** (inventory item 304, brief amendment of 2026-10-05; its first line matches `plans/FS131-close-inventory.md` on `main` l. 2404 as a
truncation): my message to Keryx — the vacuity note on `stuck_structure`, `stuck_structure_flanks`, `stuck_pole_N` can be settled neither way here
(`VACUITY DECLARED:` reads STALE on any site whose carrier is not proved empty, and these sites are GENERIC; no theorem empties the local class; a model is a
bowtie-sized construction, sketched in the message) — is ruled: docstring notes naming `stuck_chain` (FS110-N4-FIN) as the refutation on a whole terminal
plane map, no marker, no model; the sketch goes to the inventory as a stub to write. Item 144 (b): `AeProperRegions` is this job's (item 153 moved the vacuity
half to each wave's landing; the brief's "done by FS131-T3" is the coordinator's slip, acknowledged); `CPColouring` lives only on `main` (wave 2), so its
entry is merged at the merge.

## Stage 46 — SAVED (FS131-G4): wave 4's carriers registered, the stuck notes settled as ruled, and the full gate green on the pre-merge tree

**The vacuity notes** (items 252, 266; ruling 304): no marker, no model. The three docstrings now say no model is held, none is expected, and name the
refutation on a whole terminal plane map — `stuck_structure`: "... and none is expected: it is a step inside FS110-N4-PROP's proof by contradiction — on a
whole terminal plane map the configuration is refuted along the normal line (`stuck_chain`, whose chain `n4_fin`, FS110-N4-FIN, refutes)"; `stuck_pole_N` and
`stuck_structure_flanks` the same sentence (the latter's old "(`stuck_chain`, FS110-N4-FIN)" made exact: `stuck_chain` is N4-PROP, `n4_fin` is N4-FIN). No
consumer reads any of the three outside a refutation: in wave 4 only `stuck_structure` → `stuck_structure_flanks` → `stuck_pole_N` and `stuck_chain`'s chain;
on `fs131-w5`, `-w5p`, `-w5x`, `-ww`, `-w4mm` they appear in docstrings only (`git grep`, Stage 45's message).

**The carriers** (`scripts/Vacuity.lean`, the procedure "How a later wave registers its carriers"; my decisions, recorded in the file as "Wave 4's carriers
(FS131-G4 …)"). **IN** — each with a closed piece of evidence in the library and three controls:
- `ArcMap.IsHorn`: refuted by `ArcMap.bowtie_not_isHorn_I_axis : ¬ bowtie.IsHorn I 0 (-1) 1 1` (new, `BaseSteps`, a closed instance of
  `bowtie_not_isHorn_I`, whose variable angles make it no evidence); inhabited by `cuspFrag_isHorn`. Controls 39–41.
- `ArcMap.IsStuck`: refuted by `ArcMap.bowtie_not_isStuck_I : ¬ bowtie.IsStuck I` (new, `BaseSteps`, `bowtie_isStuck`'s second clause; the conjunction is no
  evidence). Controls 42–44.
- `ArcMap.Condition5`: refuted by `ArcMap.unitArcPlane_not_condition5 : ¬ unitArcPlane.Condition5` (new, `Basic`: the arc `r([0, π])` meets `ω(0)` in the
  infinite set `spherePt 0 1 '' (0, π)`, `injOn_spherePt`). Controls 45–47.
- `Plane.AeProperRegions` (items 144 (b), 153): `instIsEmptyAeProperRegionsZero : IsEmpty (AeProperRegions 0)` (the empty union is not dense) and
  `instIsEmptyAeProperRegionsOne : IsEmpty (AeProperRegions 1)` (new, `SVMap`: the class is open and dense, so some `z` near `x + 1` has `z − 1` in a ball about
  `x` inside the class, two points of one class at distance `1`); inhabited at `7` by `sevenBrickRegions`. Controls 48–50.
**OUT** (reasons in the file): `Terminal`, `TerminalOn` (the plan recommended IN; refuting either at a concrete map needs a map with an available move, which
no theorem exhibits, and every site is at a variable map — register when `¬ X.Terminal` is a theorem); the three move preconditions; the sector, flank,
contact and clearness predicates; the four unit-arc contact kinds and `IsR2Arc` (built on the tracked `IsRingArc`); `Condition6`, `InMK`; `AgreesOff`,
`RingArcsWithin`; `IsCoveringPair`; `ArcMap.Near`, `Near.Small`, `Near.RayConfig`; `IsLeavingCentre`, `StripHolds`, `MIn`, `AeProperRegions.IsRegion`. Records for
the five new declarations added to `scripts/Axioms.lean`; `tools/fs131_k4_decls.py --check` "495 names, 0 missing" (493 + the two `BaseSteps` theorems).
Controls numbered 39–50 to follow wave 2's 33–38 on `main` (the pre-merge tree lacks those; the merge joins them).

**Controls watched**: the self-test's 12 new lines all `ok` (each `VACUOUS` from its refutation, each `GENERIC` at a variable instance, each `UNKNOWN` at an
instance no closed theorem decides). **Negative control**: the four names misspelt in `trackedProps` (`IsHornX`, …) in the real file, the self-test re-run:
exit 1, exactly the 12 new controls FAIL ("expected … and it is absent"), none of the others (`data/fs131/g4/vacuity-selftest-plant-misspelt.log`; full output
`build/gate/vacuity-self-test/20261005T023001Z-589589.log`); the file restored from a copy, `cmp` identical.

**The full gate on the pre-merge tree** (the tree of this stage's commit; `Proofs/`, `scripts/`, `tools/` unchanged after the runs):
- **Build**: "build: OK — 446 of 446 batches, 11 module(s) rebuilt, 0 module(s) with warnings, 11m18s", exit 0 (`build/gate/build/20261005T021339Z-489606.log`;
  driver `data/fs131/g4/build-g4-carriers.log`); `grep -c warning` on the full log: 0 (its one "error" line is the up-to-date probe's `--no-build` refusal,
  which starts the walk).
- **Sorry**: `grep -cP '^\s*sorry\s*$|:= sorry|by sorry'` over `Proofs/`: 0.
- **Axioms**: "axioms: OK — 2720 clean, 12 axiom-free, 0 imported, 5 declared purchase(s)", exit 0; 2,737 records, every one clean or a declared purchase;
  purchases the same five (rung A's spindle, no wave-4 record); no `native_decide` (`build/gate/axioms/20261005T022537Z-572085.log`; driver
  `data/fs131/g4/axioms-pre.log`). `--self-test`: "every planted fault fired, and every partner passed", 23 controls, exit 0 (the branch's own
  `axioms-controls.txt`, T3's, counts 0/0/0 — this tree has no import; `build/gate/axioms-self-test/20261005T022541Z-572334.log`; driver
  `data/fs131/g4/axioms-selftest-pre.log`).
- **Vacuity**: "vacuity: OK", exit 0: `declarations=9649 refutations-skipped=85 sites=649`, `vacuous=0 stale=0 declared=3 witnessed=25 generic=619 unknown=2`
  (`build/gate/vacuity/20261005T022706Z-578881.log`; driver `data/fs131/g4/vacuity-pre.log`). Of the 649 sites, 84 are the four new carriers' — `IsHorn` 41
  GENERIC + 1 WITNESSED (`cuspFrag_isHorn`), `Condition5` 25 GENERIC, `IsStuck` 7 GENERIC, `AeProperRegions` 9 GENERIC + 1 WITNESSED (`sevenBrickRegions`);
  `stuck_structure`, `stuck_structure_flanks`, `stuck_pole_N` read GENERIC on `Valid`, `Condition5`, `IsStuck`, `IsHorn`. The reconciliation against `main`'s
  recorded counts is made on the merged run (Stage 47). `--self-test`: OK, 44 `ok` lines (the branch's 32 controls and `silent` lines, and the 12 new), exit 0
  (`build/gate/vacuity-self-test/20261005T022806Z-580417.log`; driver `data/fs131/g4/vacuity-selftest-pre.log`).
- `tools/check_architecture.py`: PASS (`data/fs131/g4/check-architecture-pre.txt`); `python3 tools/fs131_k4_decls.py --check`: exit 0
  (`data/fs131/g4/k4decls-check-pre.log`).

## Stage 47 — SAVED (FS131-G4): `main` merged (`42ca1740`), and the full gate green on the merged commit, every count reconciled

**Before the merge**: `tools/fs131_qa1_dupes.py` (branch refs, `fs131-w4` at `e13835e2`): 17 names in two bodies' own files, none a collision this merge
meets — 11 are `k4`/`w4` pairs (the skeleton `f620977c`, an ancestor of `fs131-w4`, against the block moved from `Contact` to `Cone`, item 254: one declaration);
4 are `w4`/`ww` (`abs_dot_le`, `dot_add_left`, `dot_e_e`, `isOpen_shadow`: Woodall's branch is not on `main`; its later landing deletes its copies, item 142);
`conj_e` is the pre-existing `Chord`/`SixFragment` repeat already on `main`; `framePt` is `w2:Plane/Slack` against `k4:Plane/ValidMap/Basic`, the skeleton's
name, which `fs131-w4` no longer declares (Stage 45; `grep framePt Proofs/` on the merged tree: `Plane/Slack.lean` only)
(`data/fs131/g4/qa1dupes-premerge.log`).

**The merge** (`42ca1740`, `git merge --no-ff origin/main` at `b100fc6b`; a merge commit cannot take paths, so it was made after explicit `git add`s of the
resolved files). Files both sides changed since `cff2c33e`: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` (auto-merged: both sides' additions;
records 2,737 + 2,532 − 1,872 at the base = 3,397, no record twice; 199 imports, none twice), and `scripts/Vacuity.lean`, `scripts/vacuity-controls.lean`,
`scripts/vacuity.sh` (conflicts, all three resolved by keeping both sides — wave 2's carrier entry, `trackedProps` line, controls 33–38 and `expect` lines first,
then wave 4's; wave 2's closing `]` became `,`). In the same commit, item 271's owed tool defect: `scripts/vacuity.sh`'s banner said "twenty planted
defects" for 38 controls; it now states no count and the self-test counts what it runs ("OK — all 50 controls behaved …"; the failing path "FAIL — n of m
control(s)"). **Checks**: `tools/fs131_i4_mergestmts.py HEAD origin/main` (I4n's three-way statement check, used, not edited): 6,098 names, 0 mismatches, PASS;
its `--plant`: "MISMATCH AeColouring.exists_fill", FAIL, exit 1 (`data/fs131/g4/mergestmts-g4.log`, `…-plant.log`); `tools/fs131_i4_treedupes.py`: 8,575
declarations, the same 3 pre-existing repeats (`data/fs131/g4/treedupes-g4-merge.log`).

**The full gate on the merged commit `42ca1740`** (the baseline header written after it, Stage 47's commit; `Proofs/` unchanged):
- **Build**: "build: OK — 449 of 449 batches, 14 module(s) rebuilt, 0 module(s) with warnings, 10m45s", exit 0 (`build/gate/build/20261005T023736Z-648846.log`;
  driver `data/fs131/g4/build-g4-merged.log`); `grep -c warning` on the full log: 0. **Sorry**: 0.
- **Axioms**: "axioms: OK — 3376 clean, 12 axiom-free, 4 imported, 5 declared purchase(s)", exit 0; 3,397 records (`build/gate/axioms/20261005T025216Z-771937.log`;
  driver `data/fs131/g4/axioms-merged.log`). Reconciled: clean 2,512 (`main`) + 2,720 (branch) − 1,856 (base) = 3,376; axiom-free 11 + 12 − 11 = 12 (wave 4's
  `BranchGerms.fin3_adj`); imported 4 (wave 2's, unchanged: wave 4 declares no import); purchases 5 (unchanged). Wave 4's 865 records: 864 on the standard three
  or fewer, 1 axiom-free; no `native_decide`, no `axiom`. **`--self-test`** (item 260): "23 controls … OK — every planted fault fired, and every partner passed",
  exit 0, with `main`'s `scripts/axioms-controls.txt` unchanged — the counts its controls read (imported 4, declared 1, library 1; `banner_dropped`'s two
  consequences) are wave 2's import, which wave 4 does not move, so no expected count needed fixing (`build/gate/axioms-self-test/20261005T025220Z-772373.log`;
  driver `data/fs131/g4/axioms-selftest-merged.log`).
- **Vacuity**: "vacuity: OK", exit 0: `declarations=10525 refutations-skipped=92 sites=705`, `vacuous=0 stale=0 declared=3 witnessed=27 generic=673 unknown=2`
  (`build/gate/vacuity/20261005T025356Z-783452.log`; re-run after the baseline header, `build/gate/vacuity/20261005T025904Z-812893.log`, "recorded counts in
  scripts/vacuity-baseline.txt's header: match (9 of 9 compared)"; drivers `data/fs131/g4/vacuity-merged.log`, `vacuity-final.log`). **Reconciled row for
  row** by a new tool, `tools/fs131_g4_vacdiff.py` (`main`'s run `fs131-w2/build/gate/vacuity/20261004T225327Z-3129569.log`, the branch's Stage-46 run, the
  merged run; base counts from the branch's `CLAUDE.md` at `cff2c33e`: 8500, 57, 460, 0, 0, 3, 21, 434, 2): SITE rows — `main` 516, branch 649, union 705,
  merged 705, none outside the union and none missing; EVIDENCE rows — 57, 60, union 66, merged 66; every count = `main` + branch − base (PASS,
  `data/fs131/g4/vacdiff-merged.log`). Its plant (one merged SITE row dropped): "1 of a parent missing", FAIL, exit 1 (`data/fs131/g4/vacdiff-merged-plant.log`).
  **What changed against `main`'s recorded counts, explained**: declarations +1,149 (wave 4's declarations, the three deletions net, generated API included);
  refutations-skipped +28 (wave 4's theorems concluding `False`, `nb4p` among them); sites +189, all wave 4's rows — 84 on the four new carriers (`IsHorn` 41
  GENERIC + 1 WITNESSED, `Condition5` 25, `IsStuck` 7, `AeProperRegions` 9 GENERIC + 1 WITNESSED) and 105 on carriers already tracked (`Valid` 91 GENERIC,
  `IsRingArc` 12 GENERIC + 1 WITNESSED, `Simple` 1 WITNESSED); witnessed +4 (`cuspFrag_isHorn`, `sevenBrickRegions`, `l60Frag_isRingArc`, `halfDisc_simple`);
  generic +185; vacuous, stale, declared, unknown unchanged (0, 0, 3, 2: the baseline's two `hexShell` entries). Evidence +9: five emptiness proofs (this job's
  `bowtie_not_isHorn_I_axis`, `bowtie_not_isStuck_I`, `unitArcPlane_not_condition5`, the two `AeProperRegions` instances) and four witnesses (the four above).
  **`--self-test`**: "OK — all 50 controls behaved", exit 0 (`build/gate/vacuity-self-test/20261005T025507Z-789080.log`, and after the plant below
  `…/20261005T030014Z-818800.log`; drivers `data/fs131/g4/vacuity-selftest-merged.log`, `vacuity-selftest-final.log`). **Negative control on the merged tree**:
  `IsStuck` misspelt in `trackedProps`: "FAIL — 3 of 50 control(s) did not behave as designed", exactly controls 42–44, exit 1
  (`data/fs131/g4/vacuity-selftest-merged-plant.log`), the file restored from a copy (`cmp` identical) before the final green run.
- `tools/check_architecture.py`: PASS (`data/fs131/g4/check-architecture-merged.txt`); `python3 tools/fs131_k4_decls.py --check`: "495 names, 0 missing", exit 0
  (`data/fs131/g4/k4decls-check-merged.log`).
- **`scripts/vacuity-baseline.txt`'s header** written: `declarations=10525  refutations-skipped=92  sites=705`, `vacuous=0 stale=0 declared=3 witnessed=27
  generic=673 unknown=2` (`scripts/gate_report.py header` on the merged run).

`main` moved to `7d8c5af7` meanwhile (two commits, `plans/` and `data/` only); merged again in the next stage, the gate re-run there.

## Stage 48 — SAVED (FS131-G4): `main` merged again (`5816a11a`), the full gate re-run there, green; the landing

**The second merge** (`5816a11a`, `origin/main` at `7d8c5af7`: two commits, `data/fs131/briefs/FS131-IP4-planar.md`, `plans/FS131-close-inventory.md`,
`plans/SESSION-HANDOFF-2026-10-04.md`; no conflict). `git diff --stat 6193582a 5816a11a -- Proofs Proofs.lean scripts tools lakefile.toml lean-toolchain
lake-manifest.json ARCHITECTURE.md`: empty — the gate's inputs are those of Stage 47's commit. **The full gate re-run on `5816a11a`**, all exit 0:
- build: "build: OK — all 1760 modules already up to date, nothing built, 0 module(s) with warnings, 2s" (`build/gate/build/20261005T030527Z-856313.log`;
  driver `data/fs131/g4/build-g4-final.log`) — the up-to-date probe's exit 0 against the oleans Stage 47's 10m45s build wrote; 0 warnings there and here;
- `grep -cP '^\s*sorry\s*$|:= sorry|by sorry'` over `Proofs/`: 0;
- axioms: "axioms: OK — 3376 clean, 12 axiom-free, 4 imported, 5 declared purchase(s)" (`build/gate/axioms/20261005T030529Z-856603.log`; driver
  `data/fs131/g4/axioms-final2.log`); `--self-test`: "OK — every planted fault fired, and every partner passed", 23 controls
  (`build/gate/axioms-self-test/20261005T030533Z-857141.log`; driver `data/fs131/g4/axioms-selftest-final2.log`);
- vacuity: "vacuity: OK", `declarations=10525 refutations-skipped=92 sites=705`, `vacuous=0 stale=0 declared=3 witnessed=27 generic=673 unknown=2`, baseline
  header "match (9 of 9 compared)" (`build/gate/vacuity/20261005T030707Z-867776.log`; driver `data/fs131/g4/vacuity-final2.log`); `--self-test`: "OK — all 50
  controls behaved" (`build/gate/vacuity-self-test/20261005T030818Z-873736.log`; driver `data/fs131/g4/vacuity-selftest-final2.log`);
- `tools/check_architecture.py`: PASS (`data/fs131/g4/check-architecture-final.txt`); `python3 tools/fs131_k4_decls.py --check`: "495 names, 0 missing"
  (`data/fs131/g4/k4decls-check-final.log`).
**`main` moved twice more while this ran, `plans/` and `data/` only each time** (`ba3019d5`: items 314–315; `aa628f8e`: items 316–317). Merged at `4fa41167`
(`ba3019d5`), and the full gate re-run there, all exit 0: build "all 1760 modules already up to date, nothing built, 0 module(s) with warnings"
(`build/gate/build/20261005T031207Z-890606.log`); 0 `sorry`; axioms "OK — 3376 clean, 12 axiom-free, 4 imported, 5 declared purchase(s)"
(`build/gate/axioms/20261005T031209Z-891011.log`), `--self-test` OK, 23 controls (`build/gate/axioms-self-test/20261005T031213Z-891584.log`); vacuity "OK", the
same nine counts, header "match (9 of 9 compared)" (`build/gate/vacuity/20261005T031346Z-903019.log`), `--self-test` "all 50 controls behaved"
(`build/gate/vacuity-self-test/20261005T031456Z-909085.log`); `check_architecture` PASS, `fs131_k4_decls.py --check` 0 missing (drivers
`data/fs131/g4/*-final3.*`). **The gated commit is `4fa41167`.** Each re-run takes about seven minutes and `main` has moved during each, always in `plans/` and
`data/`; so the last merge (`aa628f8e`, and any later one before the push) is made and pushed at once, on the check that it changes no gate input
(`git diff --name-only 4fa41167 HEAD -- . ':!plans' ':!data'` empty) — the precedent of wave 2's plans-only merge `54d408c6` after its gated `40f4b4ef`
(item 270). **The landing**: `git push origin HEAD:main` from the worktree, a fast-forward (checked first: `origin/main` an ancestor of `HEAD`); the hand-back
gives the hash.

## Theorems this phase proved (Stage 4's additions; `#print axioms` prints against the real build's oleans, not a gate log)

- FS112-ISO: `HadwigerNelson.Plane.ArcMap.iso` (+ `isoCol_locallyConstant`) — read against the row: same statement (`isoFrag` valid; the arc `r([−1/8, 1/8])` has constant sides `0` inside, `1` outside;
  `0 ∉ P_cl(0)`; `isoY` a tile of colour `0` outside `B̄(0,2)` with corner `2`; `C₂ = {0}`; the radial points `1 + s` at distance exactly `1` from the class). Inhabits the bends' centre conditions.
- FS114-L60-LE, L60-EQ's third tile: `ArcMap.l60_eq_third` — same statement; axioms `[propext, sorryAx, Classical.choice, Quot.sound]` **(over sorry)**: wave 3's `exists_mem_coneAt_region`, `coneAt_region_eq_biUnion` are `sorry` on this branch's skeleton.
- FS106-L's adversary: `not_lemmaL_of_not_mem` — same statement.
- FS112-BOWTIE's fragment data: `bowtieArcs_nondegenerate`, `bowtieArcs_locallyFinite` — same statements.

## Drafts for the front page

None yet: the milestone is not Closed (60 leaves remain, 59 without `lebesgue_covering_square`).

## Theorems this phase proved (FS131-I4c's; axioms from `#print axioms` against the stage-6 build's oleans, `data/fs131/i4/axioms-i4c-stage6.txt`, not a gate log)

- FS106-L: `HadwigerNelson.Plane.lemmaL` — `[propext, Classical.choice, Quot.sound]`. Read against the row and § 7.2's read-back: same statement (change point
  `b ∈ W`; `A`, `B` open, no unit pair in either, `W ⊆ cl(A ∪ B)` ⟹ `ω(b) ∩ W = ∅`; disjointness of `A`, `B` not read). Its geometric step
  `exists_double_unit_circle` — the standard three.
- FS106-TS-T, clause (i): `HadwigerNelson.Plane.AeProperRegions.exists_three_le_multicolour` — `[propext, Classical.choice, Quot.sound]`; with it
  `exists_three_le_multicolour_lt_one` and `ArcMap.ts_t` are sorry-free (the standard three). Same statement (a point of chromaticity `≥ 3` within `1/√2 + ε` of
  every point of an almost-everywhere-proper map's regions). `ts_t_trichromatic`, `ts_t_degree_three` still read `sorryAx`, through `exists_hasDegree_of_mem_dom`.
- Lebesgue's covering theorem for the square: `HadwigerNelson.Plane.lebesgue_covering_square` — `[propext, Classical.choice, Quot.sound]`, by FS131-LEB's theorem.

## Theorems this phase proved (FS131-I4d's; axioms from `#print axioms` against the stage-8 build's oleans, not a gate log)

- FS106-TS-T's vertex step: `HadwigerNelson.Plane.ArcMap.exists_hasDegree_of_mem_dom` — read against § 7.2: same statement (a point of the domain has a
  finite degree at least its number of colours). With it `ts_t_trichromatic`, `ts_t_degree_three` (TS-T's Condition-5/6 clauses in their carried form,
  item 142) are sorry-free.
- The bridge (item 136): `ArcMap.IsSectorChart.isSector_iff`, `…_of_zero`, `…hasDegree`, `…ncard_coloursAt_le`, `…isSector_cone_or_horn`,
  `sectorBetween_eq_hornSet`, `ArcMap.isSector_iff_of_partition`, `ArcMap.encard_sectors_of_partition` — children, no row.
- Inhabitants (QA2): `sevenBrick_corner_isCubicTrichromatic`, `sevenBrick_corner_mIn`, `ArcMap.halfDisc_simple`, `ArcMap.halfDisc_two_tiles`,
  `ArcMap.cuspFrag_isHorn`, `ArcMap.cuspFrag_valid`, `ArcMap.isJordanDomain_of_convex`.

## Theorems this phase proved (FS131-I4e's; axioms from `#print axioms` against the stage-10 build's oleans, `data/fs131/i4/axioms-i4e.txt`, not a gate log)

- FS112-LOCK: `HadwigerNelson.Plane.ArcMap.lock` — `[propext, Classical.choice, Quot.sound]`. Read against the row (`plans/FS112-derivation.md` l. 72) and item
  177's ruling: same statement (clauses 1–2 as the row; clause 3 in the ruled local form). Its engine `ArcMap.Valid.dist_ne_one_of_isOpen_subset_closure` and
  `ArcMap.unit_circle_turn`, `exists_e_outside`, `exists_e_inside`, `sq_norm_one_add_mul_e_sub_one`, `re_lt_one_of_norm_eq_one`, `norm_e_sub_one_le` — children, the standard three.
- FS112-BOWTIE at `E`: `ArcMap.bowtie_isHorn`, `ArcMap.bowtie_flanks`, `ArcMap.bowtie_coloursAt_zero` — `[propext, sorryAx, Classical.choice, Quot.sound]`
  **(over sorry: the structure `bowtie`'s `locallyConstant` field is `bowtieCol_locallyConstant`, still `sorry`)**. Read against § 8.2: same statements (two horns
  of colour `1` along `±1` between `ω(−i)` and `ω(i)`; flanks `0` above, `2` below; `P_cl(E) = {0, 1, 2}`, two colour-`1` sectors). Children: `ArcMap.bowtie_partition`,
  `ArcMap.ball_subset_bowtie_dom`, `ArcMap.mem_bowtieArcs_iff_of_norm_lt`, `ArcMap.mem_bowtieArc_N`, `ArcMap.mem_bowtieArc_S`, `ArcMap.norm_ge_of_mem_segment_far`,
  `ArcMap.cuspPiece_subset_bowtie`, `ArcMap.bowtieCol_of_mem_G/C/H`, `ArcMap.bowtieCol_cuspPiece`, `ArcMap.hornSet_cusp_pi_eq`, `ArcMap.bowtie_isSector_cuspPiece`,
  `ArcMap.cuspPiece_subset_bowtie_region`, `ArcMap.e_pi_add_pi_div_two`; in `Sectors`, `ArcMap.cuspPiece_data` (the standard three).
- FS112-BOWTIE: `ArcMap.bowtie_mem_dom` — `[propext, sorryAx, Classical.choice, Quot.sound]` **(over sorry: the structure `bowtie`, as above)**. Read against
  § 8.2: same statement (`E`, `N`, `S′` in the fragment's domain). Children `ArcMap.interior_line_eq_empty`, `ArcMap.isClosed_line`, `ArcMap.dense_compl_four_lines`,
  `ArcMap.subset_bowtieTiles`, `ArcMap.ball_I_subset_closure_bowtieTiles`, `ArcMap.ball_negI_subset_closure_bowtieTiles` — the standard three.

## Theorems this phase proved (FS131-I4f's; axioms from `#print axioms` against the stage-13 and stage-14 builds' oleans, `data/fs131/i4/axioms-i4f.txt`, not a gate log)

- FS112-BOWTIE's fragment: `HadwigerNelson.Plane.bowtieCol_locallyConstant` — `[propext, Classical.choice, Quot.sound]`. Read against § 8.2: same statement (the
  bowtie's colour locally constant off its boundary pieces, in its domain). With it the structure `bowtie` is sorry-free, so `ArcMap.bowtie_isHorn`,
  `ArcMap.bowtie_flanks`, `ArcMap.bowtie_coloursAt_zero`, `ArcMap.bowtie_mem_dom` (I4e's) read the standard three.
- FS112-BOWTIE: `ArcMap.bowtie_valid` — the standard three. Same statement (no two interior points of one colour at distance exactly `1`; YB3's pairs).
- FS112-BOWTIE: `ArcMap.bowtie_doublyShadowed` — the standard three. Same statement (both horns, near `E`, in the shadows of both flank colours; the band is the
  whole horn, `s₁ = −1`, `s₂ = 1`).
- FS112-BOWTIE: `ArcMap.bowtie_inType` — the standard three. Same statement (contacts of `0` at `i` and `2` at `−i`, in-type).
- FS112-BOWTIE: `ArcMap.bowtie_unitArcEnds` — the standard three. Same statement (both ends of both unit arcs in the domain).
- FS112-BOWTIE: `ArcMap.bowtie_neighbours` — the standard three. Same statement (`P_cl(i) = {0, 1, 3, 4}`, `P_cl(−i) = {2, 1, 3, 4}`, one sector per colour).
- Children (no row), the standard three: `ArcMap.coloursAt_hasSectors_of_tiles` (general: colours and single sectors from a convex tile partition),
  `ArcMap.coloursAt_hasSectors_of_four_tiles`, `ArcMap.coords_of_mem_segment`, `mem_segment_of_coords`, `ArcMap.mem_closure_of_ray`, `ArcMap.convex_halfPlane`,
  `eventually_mem_iff_of_closure_subset`, `ArcMap.subset_closure_of_diff_subset`, and the bowtie's: the nine `closure_bowtie*_subset`, `bowtieCol_eq_of_iff`,
  `bowtieCol_cases`, `bowtie_interiorPts_cases`, `dist_lt_one_of_mem_bowtieG/H`, `sq_ne_one_of_bowtie_one/XY`, `not_mem_bowtieArcs_near_I/negI`,
  `mem_bowtieArcs_near_I/negI`, `bowtie_partition_I/negI`, `convex_bowtie_tiles`, `bowtie_arc_ends`, `bowtie_dom_end_pp/np/pn/nn`,
  `mem_shadow_bowtie_region_zero/two`, `I_mem_closure_bowtie_region` (records in `scripts/Axioms.lean`, FS131-I4 block).

## Theorems this phase proved (FS131-I4g's; axioms from `#print axioms` against the stage builds' oleans, `data/fs131/i4/axioms-i4g.txt`, not a gate log)

- FS112-BOWTIE: `HadwigerNelson.Plane.ArcMap.bowtie_isStuck` — `[propext, Classical.choice, Quot.sound]`. Read against § 8.2: same statement (`E` stuck; `±i` not).
- FS112-BOWTIE: `ArcMap.bowtie_terminalOn` — the standard three. Same statement (no MERGE, MERGE-RAY or SHAVE at `0`, `i`, `−i`).
- FS112-FLANK, its last clause: `ArcMap.flank_incomplete_bowtie` — the standard three. Same statement (no out-type contact of `0` or `2` at `±i`; no SHAVE at `E`).
- FS112-U1, the shadow clause: `ArcMap.u1_shadow` — the standard three. Read against § 12.2: same statement (for `β` in the open facing cone and `ε > 0`, the points
  `P + t e(β)`, small `t > 0`, are at distance `1` from the outer colour's class outside `B̄(P, 1)` within `ε` of the arc; no validity read).
- Children (no row), the standard three: the ray engine `ArcMap.eventually_ray_not_mem_hornSet`, `ArcMap.eventually_not_two_rays_hornSet`,
  `ArcMap.eq_e_of_ray_subset_hornSet`, `ArcMap.frame_ray`, `ArcMap.tanBelow_tanAbove_false`; sectors `ArcMap.IsSector.subset`, `.nonempty`,
  `.subset_of_isPreconnected`, `.disjoint_of_rays`, `ArcMap.HasSectors.eq`, `.eq_zero_of_not_mem`; `ArcMap.ray_mem_ball`, `ray_coords`, `im_pt_mul_conj_pt`,
  `norm_ray_sub_lt_one`; the bowtie's `bowtie_not_isHorn_I/negI`, `bowtie_hornSet_zero`, `bowtie_hasSectors_zero_two`, `bowtie_tileOf_one`, `bowtie_outType_one`,
  `bowtie_not_merge_zero`, `bowtie_not_ray_zero`, `bowtie_flank_colour`, `bowtie_not_shave_zero`, `bowtie_hasSectors_le_one`, `bowtie_terminal_pm_I`; and
  `ArcMap.rayParam_circ` (UnitArc).
- FS114-L60-LE, L60-REAL's fragment: `ArcMap.l60Col_locallyConstant` — the standard three. Read against § 12.2: same statement (the colouring locally constant off
  the five arcs, in the domain); with it the structure `l60Frag` is sorry-free. Children, the standard three: `ArcMap.mem_carrier_circ_of_arg`,
  `ArcMap.mem_carrier_circ_full`, `ArcMap.mem_l60_arc0/1/2`, `ArcMap.cos_arg_sub`, `ArcMap.abs_le_pi_div_three_of_cos`, `ArcMap.two_pi_div_three_le_abs_of_cos`,
  `ArcMap.sq_norm_sub_eq`, `ArcMap.e_pi_div_three_re_im`.

## Theorems this phase proved (FS131-I4h's; axioms from `#print axioms` against the stage builds' oleans, `data/fs131/i4/axioms-i4h-19/20/21.txt`, not a gate log)

- FS114-L60-LE, L60-REAL: `HadwigerNelson.Plane.ArcMap.l60_real` — `[propext, Classical.choice, Quot.sound]`. Read against § 12.2: same statement (`l60Frag` valid;
  `r([0, 60°])` of `ω(0)` an arc of `Γ` with constant sides, inner `0`, outer `1`; a thickening of the closed arc in the domain). Inhabits `IsRingArc` at `ℓ = 60°`.
- FS112-N2-BENDS, N2-ENV toward: `ArcMap.n2_env_toward` — the standard three. Same statement (for `0 < ℓ ≤ 60°`, `r > 0`, some profile `ψ > 0` with the uncovered
  part of `B̄(P + (1 − s)e φ, 1)` inside `B(P, r)` for `0 < s ≤ ψ Δ(φ)`).
- FS112-N2-BENDS, N2-ENV away: `ArcMap.n2_env_away` — the standard three. Same statement (the uncovered part of `B̄(P + (1 + s)e φ, 1)` within `r` of `R₂(ᾱ)`).
- FS112-N2-BENDS, N2-ENV near (toward): `ArcMap.n2_env_near` — the standard three. Same statement (the lens of the ends within `< 1` of every toward lens point).
- FS112-N2-BENDS, N2-ENV near (away): `ArcMap.n2_env_near_away` — the standard three. Same statement (the lens off `B(P, r)` within `< 1` of every away lens point).
- Children (no row), the standard three: the Reuleaux triangle `ArcMap.dist_le_one_of_mem_reul`, `ArcMap.dist_lt_one_of_mem_reul`, `ArcMap.norm_sub_le_one_of_cone`,
  `ArcMap.reul_bound_real`, `ArcMap.eq_cramer`, `ArcMap.sq_norm_eq_re_im`; L60-REAL's `ArcMap.l60Frag_valid`, `ArcMap.l60Frag_isRingArc`,
  `ArcMap.norm_e_pi_div_three_sub_one`, `ArcMap.l60_interior_lens`, `ArcMap.l60_cap_mem_ball`, `ArcMap.l60_interior_cases`, `ArcMap.l60_openLens_subset_dom`,
  `ArcMap.l60_closure_subset_region`, `ArcMap.ringArc_l60_subset_dom`; N2-ENV's `ArcMap.sin_add_sin_sub_sin_ge`, `ArcMap.sin_mul_e_add_sin_mul_e`, `ArcMap.lens_dot_ge`,
  `ArcMap.sq_norm_sub_ofReal_mul_e`, `ArcMap.n2_env_near_core`, `ArcMap.n2_env_near_away_core`, `ArcMap.n2_env_data`, `ArcMap.toward_dir45`,
  `ArcMap.n2_env_toward_beside`, `ArcMap.n2_env_toward_core`, `ArcMap.frame_polar_add`, `ArcMap.exists_dir_of_within`, `ArcMap.n2_env_away_height`,
  `ArcMap.n2_env_away_core`, `ArcMap.n2_env_away_end`, `ArcMap.eq_polar_of_frameX_pos`.

## Theorems this phase proved (FS131-I4i's; axioms from `#print axioms` against the stage-24 build's oleans, `data/fs131/i4/axioms-i4i-24.txt`, not a gate log)

- FS114-L60-LE, its first clause: `HadwigerNelson.Plane.ArcMap.l60_le` — `[propext, Classical.choice, Quot.sound]`. Read against § 3.2: same statement (a unit arc
  with constant sides has `θ₂ − θ₁ ≤ π/3`).
- FS112-N3-NOBOTH: `ArcMap.noBoth` — the standard three. Read against § 3.2: same statement, with the domain hypothesis (the centre of a both-kind unit arc, in the
  domain, carries at least four colours or a repeated colour).
- FS114-L60-LE, L60-EQ: `ArcMap.l60_eq_inner`, `ArcMap.l60_eq_outer`, `ArcMap.l60_eq_corners` — the standard three each. Read against § 12.2: same statements
  (inner tiles in `Reul(P, A, B)`; outer tiles in `Reul(A, B, C) ∖ B̄(P, 1)`; the four corner cones). `ArcMap.l60_eq_third` (I4e's) now reads the standard three.
- Engine 2: `ArcMap.ringArcsWithin_of_Γ_subset` — the standard three (no row; the moves' "no unit arc created" clause).
- Children (no row), the standard three: `ArcMap.mem_closure_ringArc_diff_finite`, `ArcMap.ringArc_subset_Γ_of_finite` (Basic);
  `ArcMap.IsSectorChart.exists_sector_of_mem_coneAt_region`, `ArcMap.coneAt_region_nonempty` (Sectors); `ArcMap.angleIcc_half_turn`, `ArcMap.norm_rot_sub`,
  `ArcMap.ringPt_eq_rot`, `ArcMap.mem_ringArc_of_lens`, `ArcMap.l60_cap_mem_closedBall`, `ArcMap.l60_cap_general`, `ArcMap.dist_le_one_of_touch`,
  `ArcMap.l60_tile_dist_ne_one`, `ArcMap.l60_side_tile`, `ArcMap.cos_nonpos_of_mem_coneAt`, `ArcMap.mem_angleIcc_of_two_cos` (UnitArc).

## Theorems this phase proved (FS131-I4j's; axioms from `#print axioms` against the stage builds' oleans, `data/fs131/i4/axioms-i4j-*.txt`, not a gate log)

- FS112-N3-PAIRS, N3-P′: `HadwigerNelson.Plane.ArcMap.pair_P'` — `[propext, Classical.choice, Quot.sound]`. Read against § 8.2 and the row: same statement (two
  cubic trichromatic vertices of the domain with one multicolour are never at distance `1`); the binder of the unused hypothesis at `u` renamed `_h`.
- Children (no row), the standard three: the ring-arc engine `ArcMap.isRingArc_of_clean`, `ArcMap.exists_clean_subArc`, `ArcMap.exists_isRingArc_of_subset_Γ`,
  `ArcMap.outside_segment`, `ArcMap.outside_segment_real`, `ArcMap.dist_ringPt_radial`, `ArcMap.dist_radial_centre`, `ArcMap.carrier_circ_subset_sphere`,
  `ArcMap.ringArc_subset_ringArc`, `ArcMap.dist_ringPt_ringPt_le`, `ArcMap.ringPt_arg_sub` (UnitArc); `ArcMap.exists_ball_col_mem_coloursAt`,
  `ArcMap.IsCubicTrichromatic.not_hasRepeatedColour` (BaseSteps).
- FS112-A4SIX: `ArcMap.a4six` — the standard three. Read against § 12.2: same statement (exactly two colours absent at `v`, no covering pair on `ω(v)` ⟹ arcs of `Γ`
  on `ω(v)` of total length `≥ 60°`, or one strictly inside each of six consecutive open `60°` windows).
- Children (no row), the standard three: engine 7 `ArcMap.exists_coveringPoint_of_window`, `ArcMap.exists_shift_avoiding`, `ArcMap.isClosed_Γ_inter_sphere`,
  `ArcMap.countable_ringPt_preimage` (UnitArc).
- FS112-N2-BENDS, the away bend as the row states it: `ArcMap.bend_away_whole` — `[propext, sorryAx, Classical.choice, Quot.sound]` **(over sorry:
  `bend_away`)**. Same statement; the proof is the reduction to `bend_away`.

## Theorems this phase proved (FS131-I4k's; axioms from `#print axioms` against the stage builds' oleans, `data/fs131/i4/axioms-i4k-*.txt`, not a gate log)

- FS112-N3-FAIL, the place: `HadwigerNelson.Plane.ArcMap.fail_leavingCentre` — `[propext, Classical.choice, Quot.sound]`. Read against § 8.2 and the row: same
  statement (at a cubic trichromatic `u` covering `B̄(u, 1)`, the strip fails at `q ∈ ω(u)` only when `q` is a leaving centre of `u`).
- `HadwigerNelson.Plane.localSectors_disj` (wave 3's module; ruling 244 (b)) — the standard three; `localSectors` re-derived from it, statement unchanged.
- Children (no row), the standard three: `BranchGerms.mem_closure_sector_of_lt`, `sq_dist_branchPt`, `germ_circle_real`, `germ_eq_of_two_on_circle`,
  `branchPt_two_sin`, `ArcMap.IsCubicTrichromatic.chart`, `ArcMap.IsSectorChart.exists_ball_branch`, `ArcMap.exists_branch_on_circle_of_not_stripHolds`;
  `BranchGerms.fin3_adj` (no axioms, `decide`).
- FS112-N3-FAIL, the colours: `ArcMap.fail_colours` — the standard three. Read against § 8.2: same statement.
- FS112-N3-ANTI: `ArcMap.anti` — the standard three. Read against § 8.2 and the row: same statement (at a cubic trichromatic `u`, no two points of `ω(u)` at
  distance `2` are both M-in).
- FS112-N3-PAIRS (ii): `ArcMap.pair_ii` — the standard three. Read against § 8.2: same statement; binders `h₂`, `hc₂`, `hy` renamed `_h₂`, `_hc₂`, `_hy` (accepted).
- Children (no row), the standard three: `ArcMap.stripHolds_of_two_branches`, `ArcMap.IsSectorChart.exists_isRingArc_of_along`, `ArcMap.exists_along_of_side`,
  `ArcMap.exists_colour_near`, `ArcMap.closure_sector_subset_of_side`, `ArcMap.exists_side_germs_of_transversal`, `ArcMap.half_colour_or_bothKind`.

## Theorems this phase proved (FS131-I4l's; axioms from `#print axioms` against the stage builds' oleans, `data/fs131/i4/axioms-i4l-*.txt`, not a gate log)

- FS112-N3-PAIRS (i): `HadwigerNelson.Plane.ArcMap.pair_i` — `[propext, Classical.choice, Quot.sound]`. Read against § 8.2 and the row as amended by
  ruling 258: same statement (cubic trichromatic `u₁`, `u₂` covering their unit discs, `|u₁ − u₂| < 3`, a unit pair `x ∈ ω(u₁)`, `y ∈ ω(u₂)` with
  `c′(x) = c′(y) = {a}`: impossible); `h3` is read exactly at the collinear configuration.
- Children (no row), the standard three: `HadwigerNelson.Plane.eq_midpoint_of_dist`, `finite_sphere_inter_sphere_half`, `exists_mem_Ioo_ringPt_not_mem`;
  `ArcMap.mem_closure_region_of_pseudo`, `ArcMap.finite_not_stripHolds`, `ArcMap.pair_i_of_transversal` (BaseSteps).
- Engine 5: `HadwigerNelson.Plane.ArcMap.IsHorn.isRingArc_upper`, `ArcMap.IsHorn.isRingArc_lower` — the standard three each (no row; plan § 13.1 item 5).
  Children: `normalPt_add_eq_framePt`, `normalPt_sub_add_eq_framePt` — the standard three (UnitArc).
- FS112-N2-FLANK-Q, the upper and lower bounds: `ArcMap.flankQ_upper`, `ArcMap.flankQ_lower` — `[propext, sorryAx, Classical.choice, Quot.sound]`
  **(over sorry: `flankQ_upper_shadow`, `flankQ_lower_shadow`, their (R2) shadow clauses)**. Read against § 12.2: same statements.

## Theorems this phase proved (FS131-I4m's; axioms from `#print axioms` against the stage builds' oleans, `data/fs131/i4/axioms-i4m-*.txt`, not a gate log)

- FS112-N2-FLANK-Q, the (R2) shadow clause: `HadwigerNelson.Plane.ArcMap.flankQ_upper_shadow`, `ArcMap.flankQ_lower_shadow` — `[propext, Classical.choice,
  Quot.sound]` each. Read against § 12.2 and Stage 36's statements: same statements (`R₂` in the closure of the flank colour's class ⟹ that class shadows the
  horn near `v`); validity and the flank hypothesis are not read. With them **`ArcMap.flankQ_upper`, `ArcMap.flankQ_lower` read the standard three**.
- Children (no row), the standard three: `r2Cross` (def), `sq_norm_two_e_sub`, `r2Cross_spec`, `continuousAt_r2Cross_one`, `r2Cross_one`,
  `Arc.finite_inter_sphere_two_or_subset`, `ArcMap.eventually_arcs_on_sphere_two`, `ArcMap.exists_polarBox_subset_region`, `ArcMap.mem_shadow_of_crossing` (UnitArc).
- FS112-NB4P: `HadwigerNelson.Plane.ArcMap.nb4p` — `[propext, Classical.choice, Quot.sound]`. Read against § 12.2 and the row: same statement (a valid
  six-coloured map, a point `v` of exactly four colours covering `B̄(v, 1)`, a change point `y₀` of its ring, no orbit point on an arc of `Γ` on `ω(v)` or on
  an arc of `ω(y_{j±1})`: contradiction); the `ω(y_{j−1})` half of `hnb` is not read.
- Children (no row), the standard three: `sq_norm_e_add_e`, `e_add_third_add_e_sub_third`, `cos_int_mul_third_pos`, `cos_int_mul_third_neg`,
  `exists_opposite_cos_third`, `ArcMap.germ_rotate_third`, `ArcMap.straddlers_third` (UnitArc).

## Theorems this phase proved (FS131-I4n's; axioms from `#print axioms` against the stage-43 build's oleans, `data/fs131/i4/axioms-i4n-43.txt`, not a gate log)

- FS112-N2-BENDS, N2-TOWARD: `HadwigerNelson.Plane.ArcMap.bend_toward` — `[propext, Classical.choice, Quot.sound]`. Read against § 12.2 and the row: same statement (for every
  `ε > 0` a valid map agreeing with `F` off the `ε`-neighbourhood of the closed arc, no unit arc created, no interior point of the arc on an arc of `Γ` on
  `ω(P)`, only the outer colour gains points and only inside `B̄(P, 1)` near the arc).
- FS112-N2-BENDS, N2-AWAY as the row states it: `ArcMap.bend_away_whole` — `[propext, Classical.choice, Quot.sound]`. Same statement; now proved directly (no longer over `bend_away`).
- FS110-N4-SHAVE and N4-RAY at `Contact`'s statements: `ArcMap.exists_shave`, `ArcMap.exists_rayMerge` — `[propext, Classical.choice, Quot.sound]` each (by `exists_shave_aux`,
  `exists_rayMerge_aux`, FS131-IM3's, after the merge).
- Engine 3 and the bend (no row), the lens geometry, the clearness children — 56 theorems listed in Stage 43 and in `scripts/Axioms.lean`'s FS131-I4 block —
  `[propext, Classical.choice, Quot.sound]` each.

## Theorems this phase proved (FS131-G4's; axioms from the gate's own receipt, `build/gate/axioms/20261005T030529Z-856603.log`)

No row theorem: wave 4's statements are as I4n left them, less the three that left the wave. The vacuity step's evidence, each [kernel]:
- `HadwigerNelson.Plane.ArcMap.unitArcPlane_not_condition5` — `¬ unitArcPlane.Condition5` (`Plane/ValidMap/Basic`) — `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.Plane.ArcMap.bowtie_not_isStuck_I` — `¬ bowtie.IsStuck I` (`Plane/ValidMap/BaseSteps`) — `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.Plane.ArcMap.bowtie_not_isHorn_I_axis` — `¬ bowtie.IsHorn I 0 (-1) 1 1` (`Plane/ValidMap/BaseSteps`) — `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.Plane.instIsEmptyAeProperRegionsZero` — `IsEmpty (AeProperRegions 0)` (`Plane/SVMap`) — `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.Plane.instIsEmptyAeProperRegionsOne` — `IsEmpty (AeProperRegions 1)`: one open dense class always holds two points at distance `1`
  (`Plane/SVMap`) — `[propext, Classical.choice, Quot.sound]`.

## Drafts for the front page (FS131-G4)

*For Keryx to file; each names its slot and the log line it comes from. The Frontier clause, the `LEDGER.md` rows to regrade and the Proof Atlas grades for
wave 4 are held for the milestone's filing, as wave 2's were (inventory item 271).*

1. **`CLAUDE.md` § Trust ledger**, the sentence "the current audit reads 2512 clean and 5 declared purchases, and 4 imported (and 11 axiom-free; 2,532 records at
   wave 2's landing, FS131-I2n, 2026-10-04)" becomes: "the current audit reads 3376 clean and 5 declared purchases, and 4 imported (and 12 axiom-free; 3,397
   records at wave 4's landing, FS131-G4, 2026-10-05)". From `build/gate/axioms/20261005T030529Z-856603.log`'s digest (`data/fs131/g4/axioms-final2.log`):
   "audited: 3397 records — 3376 clean on the standard axioms, 12 axiom-free, 4 imported (resting on a declared outside theorem), 5 declared purchase(s)".
2. **`CLAUDE.md` § The gate**, the two count lines "`declarations=9376 refutations-skipped=64 sites=516`, `vacuous=0 stale=0 declared=3 witnessed=23 generic=488
   unknown=2`." become "`declarations=10525 refutations-skipped=92 sites=705`, `vacuous=0 stale=0 declared=3 witnessed=27 generic=673 unknown=2`." From
   `build/gate/vacuity/20261005T030707Z-867776.log`: "=== SCANNED === declarations=10525 refutations-skipped=92" and "=== TOTALS === sites=705 vacuous=0 stale=0
   declared=3 witnessed=27 generic=673 unknown=2 untelescoped=0"; reconciled row for row against `main`'s run in Stage 47.
3. **`scripts/vacuity-baseline.txt`'s header** — written by this job (Stage 47's commit): "#   declarations=10525  refutations-skipped=92  sites=705" and
   "#   vacuous=0 stale=0 declared=3 witnessed=27 generic=673 unknown=2"; the gate's digest reads it as "match (9 of 9 compared)".
4. **`tools/claude_md_fact_audit.py` `GATE_CHANGES`**, after the `(("1856", "5"), ("2512", "5"))` entry:
   `(("2512", "5"), ("3376", "5")): "FS-131 wave 4's landing (FS131-G4; .claude/worktrees/fs131-w4/build/gate/axioms/20261005T030529Z-856603.log, gated commit 5816a11a): 3,397 records, 3,376 clean, 12 axiom-free, 4 imported, 5 purchases",`
   (the same log line as draft 1).
5. **`LEAN.md` § The gate**, "`--self-test` plants thirty-eight controls and watches each fire" becomes "`--self-test` plants fifty controls and watches each
   fire". From `build/gate/vacuity-self-test/20261005T030818Z-873736.log`'s driver (`data/fs131/g4/vacuity-selftest-final2.log`): "==> vacuity self-test: OK —
   all 50 controls behaved: every one fired, and the silent ones stayed silent." (38 on `main`; 12 added, controls 39–50.) The axiom self-test's count, 23, is
   unchanged.
