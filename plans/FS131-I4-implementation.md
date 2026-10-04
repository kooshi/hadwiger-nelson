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

