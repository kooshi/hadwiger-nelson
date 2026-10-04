# FS131-QA2 — impossible assumptions: every hypothesis the backlog's Lean takes, checked for a real instance (de Bruijn, Opus)

*Brief: `data/fs131/briefs/FS131-QA2-impossible-assumptions.md`. Read-only toward every `Proofs/` file, worktree and branch; every finding is
a recommendation routed through Keryx. Code read with `git show <ref>:<path>` at the refs in § 1.2.*

## Theorems this phase proved

None in the library. An audit proves nothing there; its exact checks and scratch `example`s are evidence for verdicts, listed where used.

## Stage 1 — SAVED

### 1.1 The brief's quotations (standing rule 3)

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "158. **Statement defect — definitions: `WoodallMerged` and `WoodallNormal` are unsatisfiable on every valid plane map; `exists_woodallMerged` is false at" | `plans/FS131-close-inventory.md` | **matches**, line 1045, verbatim (the item's first line; the brief says "the item continues there") |
| 2 | "inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a" | `LEAN.md` § The gate | **matches**, verbatim (a mid-sentence excerpt of the inhabitant rule) |
| 3 | "165. **Kooshi, 2026-10-04 (verbatim)**: *"Ok, I'm caught up. Yes, run the impossible assumption audit. And thank you and all the agents for your excellent work." | `plans/FS131-close-inventory.md` | **matches**, line 1134, verbatim (the item's first line) |

No slip.

### 1.2 The bodies, as read (2026-10-04)

| body | ref (tip) | its own files |
|---|---|---|
| main | `main` `8b30e6e1` | waves 1 and 3, LEB: 22 files (`Arith/{FalconerFan,NoAffine}`, `Plane/{AeColouring,ArcMap,Basic,Chord,CircleColouring,Closure,DensityPoints,Diameter,Lens,LocalMap,LocalMapExamples,LocalStructure,RingBand,RingGerm,SixFragment,Tiles,UnitAvoiding,UnitPairs}`, `Topology/{LebesgueCovering,SpernerGrid}`) |
| w2 | `origin/fs131-w2` `9f54be3d` | 13 files (`Arith/{Dyadic,FalconerField,PlaceHom}`, `Instances/FalconerOrbit`, `Plane/{CPColouring,Cover,CoverExamples,FalconerReduction,MaximalCover,Slack,Stationary,Suprema,YesLimit}`) |
| w4 | `origin/fs131-w4` `f1f26a8a` | the K4 skeleton and its fill: `Plane/{SVMap,StuckChain}`, `Plane/ValidMap/{Basic,BaseSteps,Contact,UnitArc}` |
| ww | `origin/fs131-ww` `89a4aad0` (E3's NiceAt repair) | `Plane/Woodall/{Basic,Collar,Merge,NoFourFive,Steps}`, over the K4 skeleton at fork time |
| w3b | `fs131-w3b` `167a2a74` (local tip; `d8a3177f` on `origin` plus a merge of `main`) | `Plane/LocalStructure` (+1,396: `localSectors`, `BranchGerms`, `IsSectorChart`), `Plane/RingGerm` (+131) |

**Duplicates resolved.** The K4 files on `fs131-ww` differ from `fs131-w4`'s only by w4's later *additions* (294 and 352 lines deleted,
none added, in `ValidMap/Basic` and `SVMap`): every K4 definition Woodall reads is w4's, unchanged. The w3b diff against `main` adds
definitions and changes none. So one predicate is counted once, at its defining body.

### 1.3 The instrument

`tools/fs131_qa2_census.py` — imports QA1's parser (`tools/fs131_qa1_decls.py`, unedited) and, over the five bodies' own files, lists
every **predicate** (a `def`/`abbrev` whose type ends in `Prop`, by binders, arrows or pattern matching; every `structure`, `class`,
`inductive`), and for each the declarations that take it as a hypothesis — in any binder, or as an antecedent of the conclusion's arrow
chain — flagging **refutation-shaped** ones (final target `False`), and the declarations that conclude it (candidate inhabitants) or its
negation (adversaries). `--self-test` plants fifteen controls (a pattern-matching `Prop` def, which the first run missed — `Arc.Nondegenerate`,
`Arc.IsUnitArc`, `Arc.InitialPiece` — and a longer name that must not match among them). **Negative controls watched**: with the arrow
chain's antecedents dropped in a copy, the self-test fails naming "arrow-antecedent refutation missed"; with implicit binders excluded,
it fails naming "implicit binder missed"; restored, it passes. Outputs: `data/fs131/qa2/{preds.tsv,uses.tsv,predsigs.jsonl}`.

**Its limits, stated**: textual (no elaboration); a predicate is matched by its last name component, so a short common name can
over-match (never under-match inside a body's own files); Prop-valued hypotheses that are *not* named definitions (inline `dist x y = 1`,
angle bounds) are outside a definition census, and are read by hand in the refutations of Stage 2.

### 1.4 The census, in numbers

2,291 declarations parsed; **140 predicates** (173 before the 31 duplicate K4 copies on `fs131-ww` and 4 on w3b are merged: 136 distinct);
**about 105 of them are taken as a hypothesis** by at least one declaration (1,114 hypothesis uses); **20 appear in a refutation-shaped
declaration**, across **24 distinct refutation-shaped theorems** (the w3b copies of five main theorems counted once):

| body | refutation-shaped theorems (the census's) |
|---|---|
| main (and w3b's copies) | `GoodAt.not_tile_subset_ball`, `coneAt_interiors_disjoint`, `circ_gap_false` (LocalStructure); `overlap_false`, `Valid.false_of_crossing` (RingGerm) |
| w2 | `not_falconerFan_five_of_hom_slack` (FalconerField) |
| w4 | `pair_i`, `anti` (BaseSteps, `sorry`); `nb4p` (UnitArc, `sorry`) |
| ww | `false_of_changePt_landing`, `false_of_collars_closed`, `woodall_step4`, `not_woodall_step4_two_thirds`, `townsend_lemma` (Collar); `SectorsAt.false_of_ncard_le_two_on_arc` (NoFourFive); `step5_lt`, `step6`, `false_of_four_le_sectors`, `aeMap6_normal`, `aeMap6_merged`, `aeMap6`, `aeMap6_of_condition5`, `woodall_thm6` (Steps) |

**Order of work (my choice, brief § What is yours to decide)**: Stage 2 the refutation-shaped theorems and every predicate they assume
(the scan skips them, so nothing else guards them); Stage 3 the carriers and predicates of the non-refutation theorems, by number of
hypothesis uses (a predicate assumed by many theorems first), the rest sampled with the rule stated there; Stage 4 wave 4's skeleton
statements against their rows; Stage 5 the verdict.

## Stage 2 — SAVED

### 2.1 The test, made precise

A refutation-shaped theorem's hypotheses are jointly unsatisfiable *by design*: that is what it proves. So "has a real instance" cannot
mean "all hypotheses hold at once". The defect of inventory item 158 was of a different kind: a **definition** that fails on every
real object for a reason unrelated to the mathematics being refuted (`WoodallMerged` failed at every point of two colours of every
map, because `SectorsAt` admits phantom horns). The test applied here, for every predicate a refutation assumes:

1. **Per predicate, on a real object, at the kind of point the theorem talks about** (points of two or more colours, horns, vertices of
   three colours, a picture with more than one presentation): is there an instance where every clause is non-vacuous?
2. **Per refutation, its background at a parameter the refutation does not kill**: drop what is refuted (`k ≤ 5`, the forbidden
   relation) and ask whether the rest has a model — for the five-colour refutations, at `k = 7` on a plane map.
3. **Per supply theorem** (an `exists_…` or a `…_of_…` that concludes a predicate a chain consumes): its conclusion must be satisfiable,
   and not contradicted by the model of 2.

### 2.2 The model used throughout: `sevenBrickMap` at a corner

`sevenBrickMap : ArcMap 7` (`Plane/SVMap`, on `fs131-w4` with its three fields proved; `sorry` on `fs131-ww`'s older copy) is a valid
map of the plane (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`). `tools/fs131_qa2_brick.py` checks exactly, over a 13 × 13 window
of cells: every vertex of its edge graph is a **T-junction** (three cells, angles `π/2, π/2, π`, all `≥ π/3`); the three cells at
every vertex carry **three distinct colours** (`(c − 1 + 3r, c + 3r, c + 3r − 3) mod 7`, pairwise differences 1, 2, 3); at a corner
`u`, the far corner of each upper cell is at distance **exactly 1** (the 3–4–5 diagonal), the two such points are `8/5` apart (not
antipodal), and the lower cell's far corners are at distance `√13/5 < 1`. **Controls watched**: shear `0` (vertical edges aligned)
fails check 1 with "4 cells meet" (507 failures); colour `(c + r) mod 7` fails check 2 with "colours not distinct" (338 failures).

So, at every brick corner `u`, mathematically: `HasDegree u 3`, `ncard (coloursAt u) = 3` (**`IsCubicTrichromatic u`**), a picture
with three positive-angle sectors of distinct colours (**`NiceAt u`**, and the **`WoodallNormal`** clause), `Covers u R` for every `R`,
and **`MIn u x`** at the far corner `x` of an upper cell (`x ∈ closure (region c ∩ ball u 1)`, `c` that cell's colour). Every point
of three colours is a corner, so `sevenBrickMap.WoodallNormal univ` and `sevenBrickMap.WoodallMerged univ` hold. Grade: [hand] over
the exact check; not in Lean.

### 2.3 The refutation-shaped theorems (the census's 24)

| theorem (body, file:line) | predicates it assumes | real instance of each, exercising every clause | background model (2.1 item 2) | verdict |
|---|---|---|---|---|
| `aeMap6_normal` (ww Steps:537) | `Valid`, `IsPlaneMap`, `WoodallNormal (closedBall 0 3)` | `threeSectorDisc_woodallNormal` (a point of three colours — but `dom = ball 0 (1/3)`, **not a plane map**); `sevenBrickMap` at `k = 7`, §2.2 | `sevenBrickMap`, `k = 7` — **not in the library** | sound definitions; **inhabitant owed on a plane map** (finding QA2-1) |
| `aeMap6_merged` (ww Steps:558) | `Valid`, `IsPlaneMap`, `WoodallMerged (closedBall 0 3)` | as above (`threeSectorDisc_woodallMerged`, not plane) | same | same (QA2-1) |
| `false_of_four_le_sectors` (ww Steps:471) | `Valid`, `IsPlaneMap`, `SectorsAt` (`n ≥ 4`, injective, angles `≥ π/3`), `WoodallNormal (sphere v 1)` | `SectorsAt` at four sectors: a point where four tiles of four colours meet at right angles (an X-crossing of two segments, colours `A, B, C, D`) | at `k = 7`: a valid plane map with a four-colour X vertex (the brick map has none; one is built by subdividing a brick by a short vertical segment — not in the library) | sound; refuted content is "four or five sectors" at `k ≤ 5`; inhabitant of the four-sector picture owed only as a spec example (low) |
| `aeMap6`, `aeMap6_of_condition5`, `woodall_thm6` (ww Steps:566–582) | `ArcMap`, `Valid`, `IsPlaneMap`, `Condition5`; `woodall_thm6` a full proper `col` agreeing with `F.col` on interior points | `sevenBrickMap` (`k = 7`): `Condition5` holds (segments meet a unit circle in at most two points); `col := sevenBrick.color` is proper on all of `ℂ` (`Brick.avoids`) | `sevenBrickMap`, `k = 7` — named (`sevenBrickMap_valid`) for `aeMap6`; the `woodall_thm6` and `Condition5` models not named | sound; the final theorems rest on `exists_woodallMerged` (`sorry`, E3-BALL [derived]) — its conclusion is satisfiable (§2.2: the brick map is already merged); a citation, not a defect |
| `step5_lt`, `step6` (ww Steps:252, 277) | `Valid`, `IsPlaneMap`, `SectorsAt` (`n ≥ 3`) | brick corner: three sectors, angles `π/2, π/2, π`; distinct colours | brick corner at `k = 7` (step 6's three sectors `≥ π/3` hold there; step 5's sub-`π/3` angle does not — the refuted clause) | sound |
| `SectorsAt.false_of_ncard_le_two_on_arc` (ww NoFourFive:1042) | `Valid`, `IsPlaneMap`, `SectorsAt` with positive angles, at most one colour absent | positive-angle picture: brick corner; "at most one absent" needs a point of `k − 1` colours | none at `k = 7` in the library (the brick map has three colours per point); the clause is the chain's own situation (`k ≤ 5`, four or five sectors) | sound; a step of E1-NO45's contradiction — its background is the refuted world, which is expected; no definition defect |
| `woodall_step4`, `false_of_collars_closed`, `false_of_changePt_landing`, `townsend_lemma` (ww Collar:468–764) | `Rim`, `CollarAt`, open sets with no unit pair | `CollarAt` holds of any open set containing an annular sector (`collarAt_shadow_*`, proved) | `not_woodall_step4_two_thirds` (proved) exhibits A, B, collars over an arc of length exactly `2π/3` — the background at the boundary | sound; best evidence in the library (QA1 row 20) |
| `GoodAt.not_tile_subset_ball`, `coneAt_interiors_disjoint`, `circ_gap_false` (main LocalStructure; and w3b's copies) | `GoodAt`, `IsTile`, `Arc` | `exists_goodAt` (proved): **every point of every map's domain has a good radius** — a universal existence theorem; `IsTile` at `halfDisc`'s two tiles | any map, any point | sound |
| `overlap_false`, `Valid.false_of_crossing` (main RingGerm:2280, 49) | `TileOf`, `Valid` | `IsTile.tileOf` (proved, every tile is a `TileOf` its colour); `Valid`: `sixFrag_valid`, `sevenBrickMap_valid` | `sixFrag` | sound |
| `not_falconerFan_five_of_hom_slack` (w2 FalconerField:146) | `FalconerFan H 5 a t`, a homomorphism to a graph slack at four | `rhombus_falconerFan` (proved; colourings exist, so the ∀-over-colourings clause is not vacuous) | the hypothesis `Slack T 4` makes `H` 4-colourable, so `H − a` has 5-colourings and the fan clause bites | sound |
| `pair_i`, `anti` (w4 BaseSteps:130, 170; `sorry`) | `Valid`, `Covers u 1`, **`IsCubicTrichromatic`** (both); `MIn` (`anti`) | `IsCubicTrichromatic`: **no inhabitant in the library**; brick corner (§2.2). `MIn`: only the one-colour plane (degenerate: its `u` is not cubic trichromatic); brick corner's far corner (§2.2) | brick corner `u`, one M-in point `x`; `anti`'s second, antipodal M-in point is the refuted clause (the brick's two M-in points are `8/5` apart) | sound; **inhabitant owed** (QA2-2) |
| `nb4p` (w4 UnitArc:1037; `sorry`) | `ArcMap 6`, `Valid`, `Covers v 1`, `IsChangePoint`, `OnRingArc` | `IsChangePoint`: `halfPlane2_isChangePoint` (proved, on a two-colour map that is not valid); on a valid map any circle crossing a brick edge between two colours | a valid six-colour fragment with a four-colour point covering `B̄(v, 1)`: `sixFrag` (FS-116's) is the candidate | sound |

**No refutation-shaped theorem rests on a definition unsatisfiable on real objects.** Two inhabitants are owed (QA2-1, QA2-2), both
for exactly the reason item 158 slipped through: the hypothesis's only inhabitants live on maps where the theorem's other hypotheses
fail (a disc of radius `1/3` for a chain that assumes a plane map; the one-colour plane for a lemma about cubic trichromatic points).

### 2.4 Supply theorems still `sorry` that a chain consumes (2.1 item 3)

| supply theorem (body) | what it supplies | its conclusion satisfiable? |
|---|---|---|
| `exists_woodallMerged` (ww) | E3-BALL: a valid plane arc map merged on `closedBall 0 R` | yes — the brick map is its own witness at `k = 7` (§2.2); at `k ≤ 5` it is the chain's premise, [derived] by E3 |
| `exists_merge_at`, `exists_dirColourAt`, `niceAt_of_dirColourAt`, `wedgeMerge_niceAt`, `niceAt_congr` (ww Merge, W3's skeleton) | E3-BALL's children | yes, each at a brick corner or `threeSectorDisc`'s centre; `DirColourAt`'s clause ("a wedge of one colour about every direction off a finite set") holds at every point of every arc map (wave 3's `GoodAt.exists_wedge`) |
| `exists_merge`, `exists_rayMerge`, `exists_shave` (w4 Contact) | FS110-W-MERGE, N4-RAY, N4-SHAVE: a modified map | yes in form (the identity modification satisfies every clause but the sector count); the counts are the mathematics |
| `bowtie_*` (w4 BaseSteps: valid, coloursAt, isHorn, flanks, neighbours, inType, doublyShadowed) | the only model of `IsHorn`, `IsFlankAbove/Below`, `InType`, `HasSectors … 2`, `HasRepeatedColour`, `DoublyShadowed`, and the stuck configuration | yes on paper (YB3's exact check, 21 of 21 tile pairs); until they are proved, those predicates have **no proved** non-degenerate inhabitant (QA2-4) |
| `exists_tiled_kept`, `exists_bandNull_aeCover_of_mu_eq_one`, `exists_weakStar_subseq`, `hc_isRegularMUA` (w2) | wave 2's slack and cover chain | yes: their predicates have proved inhabitants elsewhere (`BandNull` via `bandNull_of_bandFree`, `IsRegularMUA` via `disc7_isRegularMUA`, `KeptAt` via `ae_eventually_keptAt`) |

## Stage 3 — SAVED

### 3.1 Every predicate taken as a hypothesis, with its instance

Classes of evidence: **U** — a proved theorem gives an instance at every point/object of its kind (strongest); **N** — a proved, named,
non-degenerate inhabitant (every clause bites); **D** — the only named inhabitant is degenerate (some clause vacuous on it); **S** — the
inhabitant exists but its proof is `sorry`; **H** — none in the library: a hand instance stated here, grade [hand]. The theorems that
assume each predicate are in `data/fs131/qa2/uses.tsv` (role `REFUT` first, then `hyp`). Counts are hypothesis uses. All 105 are read;
none is skipped.

**main — wave 1 (`Plane/ArcMap`, `UnitPairs`, `AeColouring`, `UnitAvoiding`, `Arith/FalconerFan`)**

| predicate | uses | class | instance | note |
|---|---|---|---|---|
| `ArcMap` (structure) | 37 | N | `halfDisc`, `sixFrag`, `sevenBrickMap` | |
| `Arc`, `Arc.Nondegenerate` | 55, 13 | N | `sixArcs_nondegenerate`, `sevenBrickArcs_nondegenerate` (w4) | QA1's D1 (docstring) stands |
| `IsTile` | 36 | U | every component of the interior points; `finite_tiles_near` | |
| `Valid` | 190 | N | `sixFrag_valid`, `sevenBrickMap_valid`, `iso`, `threeSectorDisc_valid` | |
| `Covers` | 78 | N | `sixFrag_covers`, `sixQ_inhabited` | |
| `IsPlaneMap` | 37 | N | `sevenBrickMap_isPlaneMap` (w4/ww only — **no plane map on `main`**) | wave 3's theorems on `main` that assume `IsPlaneMap` have their inhabitant only after wave 4 lands |
| `NonSiamese` | 4 | N | `sixFrag_nonSiamese`; adversary `halfDiscMono` | |
| `Simple`, `IsJordanDomain` | 6, 5 | **D** | the one-tile disc (`ArcMap.lean:367`): `Simple`'s second clause ("distinct tiles' closures meet in a preconnected set") is vacuous on it | **QA2-3**: `halfDisc` is a two-tile simple map (two Jordan half-discs whose closures meet in a diameter) |
| `AeColouring` | 29 | N | `sq9 : AeColouring 9`, `r7_aeColouring`; `IsEmpty (AeColouring 1)` | |
| `UnitPairsNull` | 27 | N | `unitPairsNull_of_no_unit_pair`, `unitPairsNull_grundyS` | |
| `IsMUA` | 5 | N | `disc7_isMUA` | |
| `FalconerFan` | 11 | N | `rhombus_falconerFan` (its ∀-over-colourings clause bites: colourings exist) | a fan at `k` is vacuous on a graph with no `k`-colouring of `H − a`; every use pairs it with a hypothesis that supplies colourings (§2.3) |

**main — wave 3 (`LocalMap`, `LocalStructure`, `CircleColouring`, `RingBand`, `RingGerm`, `SixFragment`, `Tiles`) and LEB**

| predicate | uses | class | instance | note |
|---|---|---|---|---|
| `TileOf` | 30 | U | `IsTile.tileOf` | |
| `GoodAt` | 12 | U | `exists_goodAt` (every point of every domain) | |
| `Arc.InitialPiece` | 8 | U | `Arc.exists_initialPiece_of_approach`, `exists_initialPiece_of_cone` | |
| `Arc.Tang` | 2 | N | `GoodAt.exists_wedge`, `countable_tang_dirs` | |
| `Arc.OnRing` | 6 | H | the arc `.circ p 1 0 1` | trivially satisfiable (an equation of constructors) |
| `UnitNear`, `UnitFar` | 2, 1 | N | `IsTile.unitNear_self`, `unitNear_or_unitFar` | |
| `Side` (inductive) | 45 | U | `.cw`, `.ccw` | |
| `GermIn` | 30 | N | `changePoint_germs`, `touchW` | |
| `OnRingArc`, `IsRingArc` | 6, 42 | N | `quadRing_isRingArc`; on a valid map `sixQ_inhabited`, `sixFrag_isRingArc` | |
| `IsQArc`, `GermOnQ`, `OnQArc` | 4, 12, 6 | N | `sixQ_isQArc`, `sixFrag_isQArc` (valid maps, a point of four colours); `onQArc_of_germOnQ` | |
| `IsChangePoint` | 21 | N | `halfPlane2_isChangePoint` (a two-colour map, not valid); on a valid map: any ring crossing a brick edge between two colours | adequate: the clause is local to the ring |
| `IsEssBoundary`, `SaturatedAt` | 2, 2 | N | spec examples in `LocalMap` | |
| `RegularAt` | 4 | U | `exists_regular_germ`, `isOpen_regularAt` | |
| `Sides` | 13 | U | `exists_sides` | |
| `PairPos` | 4 | H | `hexColouring` at `θ = 0` if its change set holds `0` and `π/3` (two change points `60°` apart); not checked in Lean | low |
| `CircleColouring`, `Lift`, `Good`, `LeftVal`, `RightVal`, `IsSwap` | 11, 2, 17, 3, 3, 2 | N/U | `hexColouring`, `nineColouring`, `arcsColouring`; `exists_lift`; `exists_good_near`; `Sides.vals`; `exists_swap_of_ring` | |
| `InSixLens`, `sixPieceS/Q/G` | 3, 5–7 | N | spec examples, `sixCol_zero_cases` | |
| `Rainbow`, `RainbowCell` | 2, 2 | U | `exists_rainbowCell` (Sperner) | |

**w3b (`localSectors`)**: `BranchGerms` (6), `Sorted` (3), `Mono` (10), `IsSectorChart` (3) — **U**: `localSectors` proves a sector chart
at every point of every domain; `halfDisc_sectorChart` names one at a point of two colours.

**w2 (wave 2)**

| predicate | uses | class | instance | note |
|---|---|---|---|---|
| `CPColouring` | 18 | N | `nonempty_cpColouring_nine`; `IsEmpty (CPColouring 1)` | |
| `CPColouring.RotationInvariant` | 1 | H | `sq9CP` averaged over the rotation group (rotations preserve unit distance, conjugate translations, keep continuity in probability) | low; no named inhabitant |
| `IsUsablePrime`, `IsPlaceHom` | 5, 5 | N | `falconerFan_five_field`, `exists_isPlaceHom` | |
| `NoAffFieldHyp` | 2 | H | `NoAffFieldHyp ℚ 4` with `𝔭 = (7)`: residue field `𝔽₇`, `7 ≡ 3 (mod 4)` | low; no named inhabitant |
| `IsAdmissible` | 2 | **D** (implicit) | satisfied by the empty classes; the real instance is `sq9`'s classes | low |
| `IsMaximalCover`, `IsSelection`, `IsRegularMUA` | 6, 1, 2 | N | `disc7_isMaximalCover`, `r7Cls_isMaximalCover`; `disc7_isRegularMUA` | |
| `Saturated`, `SaturatedPos` | 1, 1 | N | `sq9_saturated_both`, `r7Cls_saturated` | |
| `G1Bounds` | 18 | N | `g1Bounds_hcGap` (every closed `Z ⊆ [−1/2, 1/2]` holding both ends) | |
| `IsLowerGraphOf`, `CurvatureLeOne`, `IsMaxIn` | 3, 1, 1 | N | `r7_lowerGraph`, `IsMaximalCover.curvatureLeOne`, `isMaxIn_maxIn` | |
| `KeptAt`, `IccPairNull`, `BandNull`, `BandFree`, `IsGridUnion`, `IsPartialColouring` | 3, 5, 2, 3, 1, 2 | N | `ae_eventually_keptAt`; `bandNull_iff_iccPairNull`; `bandNull_of_bandFree`; `ArcMap.bandFree_region`; `AeColouring.isPartialColouring` | `IsGridUnion` named only in `exists_tiled_kept` (S); a grid square is one |
| `WeakStarTendsto` | 3 | S/H | `exists_weakStar_subseq` (`sorry`); a constant sequence is a trivial instance | low |
| `Row130M1`, `Voronov11` | 1, 1 | — | carried hypotheses (rulings 22, 53): **propositions, not predicates** — true or false, never "inhabited"; `Row130M1` is [hand] given MR, `Voronov11` is `[Voronov2023]`'s | the right check is their read-back (QA1 rows 6–7), done |

**w4 (wave 4's K4 skeleton)**

| predicate | uses | class | instance | note |
|---|---|---|---|---|
| `IsCubicTrichromatic` | 6 (2 refutations) | **H — none in the library** | a brick corner of `sevenBrickMap` (§2.2) | **QA2-2** |
| `MIn`, `StripHolds`, `IsLeavingCentre` | 1, 2, 0 | **D**, N, N | `MIn`: only the one-colour plane; brick far corner (§2.2). `StripHolds`: adversary on the one-colour plane; `quadRing.IsLeavingCentre 1 0` | `MIn` joins QA2-2 |
| `HasSectors`, `HasDegree`, `HasRepeatedColour` | 6, 0, 1 | S | `bowtie_coloursAt_zero` (`sorry`); brick corner (1 sector each, degree 3); an X-crossing (`A, B, A, B`: `A` repeated) | QA2-4 |
| `IsHorn`, `IsFlankAbove`, `IsFlankBelow`, `InType`, `DoublyShadowed` | 9, 5, 4, 1, 1 | S | `bowtie_isHorn`, `bowtie_flanks`, `bowtie_inType`, `bowtie_doublyShadowed` — all `sorry` | **QA2-4**: no proved horn anywhere; the definitions read right (`hornSet` is exactly a component for small `r`: at `frameX = 0` no point but `v` lies between two tangent arcs) |
| `IsContact`, `OutType` | 5, 3 | N | spec example; `contact_inType_or_outType` | |
| `IsStuck`, `Terminal` | 3, 2 | none / **D** | `Terminal`: `sevenBrickMap` is terminal (no colour has two sectors, no horn), but there `IsStuck` fails everywhere; `IsStuck`: the bowtie's centre (`sorry`) — and the bowtie **fails `Condition5`** by design (its horns are bounded by unit arcs) | **QA2-5**: `stuck_structure` and `stuck_chain` assume `IsStuck ∧ Condition5`; no model is exhibited or known; `n3_end` assumes `Terminal ∧ IsStuck ∧ IsPlaneMap`, and the bowtie is a fragment |
| `BothKind` | 2 | N | a (Q) arc is both-kind: `sixQ_isQArc` | |
| `IsR2Arc` | 2 | H | thin bands of colour `c` at radii `(1 − h, 1)` and `(2, 2 + h)` about `p` over an arc shorter than `29°` (cross distances `> 1`, each band of diameter `< 1`), `c′` between them and at `p` on the side facing away from the arc | low; for FLANK-Q (both `sorry`) |
| `Condition5`, `Condition6`, `InMK` | 5, 1, 0 | N | spec examples; `sevenBrickMap` (segments only; three colours per vertex, degree 3) | QA1's D5 (presentation-dependence) stands |
| `AgreesOff`, `RingArcsWithin`, `IsClear`, `IsCoveringPair`, `TanAbove` | 1, 0, 2, 1, 1 | N | spec examples (`F.AgreesOff F`), `tanAbove_one_iff` | |
| `AeProperRegions` (SVMap) | 0 | N | `sevenBrickRegions` | |

**ww (Woodall's chain at `89a4aad0`)**

| predicate | uses | class | instance | note |
|---|---|---|---|---|
| `Rim`, `CollarAt` | 26, 15 | N | constructors; `collarAt_shadow_inner/outer` | |
| `SectorsAt` | 25 | N/S | `const_sectorsAt` (one sector, degenerate for adjacency); `threeSectorDisc_sectorsAt` (`sorry`), `halfDisc_sectorsAt` (`sorry`) | the non-degenerate pictures are `sorry`; `threeSectorDisc_phantom` (also `sorry`) is the adversary that kills the ∀-forms |
| `NiceAt` | 1 | N (over S) | `threeSectorDisc_niceAt`, `halfDisc_niceAt` (proved, over the `sorry` pictures) | |
| `WoodallMerged`, `WoodallNormal` | 1, 2 | N (over S), **not on a plane map** | `threeSectorDisc_woodallMerged/Normal` | **QA2-1** |
| `OffDirs`, `DirColourAt`, `CrossesAt` | 1, 2, 4 | H/S/N | `OffDirs ∅ φ` trivially; `exists_dirColourAt` (`sorry`; wave 3's wedge lemma gives it); `CrossesAt` spec examples | |

### 3.2 Tally

**105 predicates taken as a hypothesis, all read. 0 unsatisfiable on real objects. 0 whose definition fails at the kind of point its
theorems quantify over** (the item-158 class: a ∀ over presentations, or a clause that real maps break). By evidence: U 14, N 63, S 11,
H 8, D 5 (counting each row's predicates; the two carried propositions apart). The findings are all of one kind — **a hypothesis whose
only exhibited model lives where the theorem's other hypotheses fail** — QA2-1 to QA2-5, ranked in Stage 5.
