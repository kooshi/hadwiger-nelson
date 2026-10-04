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

## Drafts for the front page

None yet: the milestone is not Closed (60 leaves remain, 59 without `lebesgue_covering_square`).
