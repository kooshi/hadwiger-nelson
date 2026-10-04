# FS131-I2 — wave 2 implementation record

*Implementer: de Bruijn (Sonnet 5.5). Branch `fs131-w2`, worktree `.claude/worktrees/fs131-w2`. Brief: `data/fs131/briefs/FS131-I2-wave2.md`.*

## Theorems this phase proved

**None yet at the gate**: the gate has not been run (43 of 71 leaves remain), so no axiom line is read from a saved audit log. Closed leaves, 28 of 71
(each builds in `build/gate/build/20261004T074250Z-1995015.log`, axioms not yet audited): see Stages 1–4.

## Stage 1 — SAVED: `main` merged; 13 leaves closed (Arith, MaximalCover, one shared exhaustion)

**Merge.** `main` merged into `fs131-w2` (`0b97dd89`), no conflicts. Baseline build green with only `declaration uses sorry`
(`build/gate/build/20261004T064408Z-1712030.log`).

**Leaves closed** (statements untouched; one leaf moved, `exists_isMUA_ae_le`, from `Plane/CoverExamples` to `Plane/Cover` as the plan allows):
- `Arith/FalconerField`: `falconerFan_five_mem_eight`, `not_falconerFan_five_of_fanGap`, `falconerFan_five_mem_P`.
- `Arith/Dyadic`: `sqrt3_dyadic`.
- `Plane/MaximalCover`: `AeColouring.exists_fill`, `exists_isMaximalCover`, `IsMaximalCover.interior_union_unitShadow`,
  `IsAdmissible.exists_aeColouring`, `isMaximalCover_iff`, `IsRegularMUA.interior_eq_compl_unitShadow`, `IsRegularMUA.component_side`.
- `Plane/Cover` (moved leaf): `exists_isMUA_ae_le`.

**Shared children stated** (all in `Plane/Cover`, sorry-free): `UnitPairsNull.congr_ae`, `volume_prod_shift_null`, `exists_ae_maximal`
(the measure-maximizing exhaustion: a predicate closed under a.e. equality of measurable sets and increasing unions has an
a.e.-maximal element above any member), `essSupport_eq_support`, `isClosed_essSupport`, `volume_diff_essSupport`,
`essSupport_mono_ae`, `exists_annulus_subset_compl`, `ae_restrict_mem_densitySet` (Besicovitch), `volume_diff_densitySet`,
`upperDensityAt_eq_zero_of_null`, `essSupport_eq_closure_densitySet`, `subset_densitySet_of_isOpen_ae_subset`;
in `Plane/MaximalCover`: `IsMUA.interior_union_unitShadow`.

**Tooling.** `tools/fs131_i2_fill.py` replaces a named leaf's `sorry` by a body from a file (refuses if the next `sorry` is not that
theorem's). Iteration uses a scratch olean farm (never evidence).

## Stage 2 — SAVED: BAND, `not_semiconcaveWith_one_lowerArc`, `fatZ_spec`; one ruling

**Ruling** (Keryx, `plans/FS131-close-inventory.md` item 48; the only statement change of this job): `vesica_apex_exact` is false for `h ≤ -2`
(apex `2i`: `dist z (2i) ≥ 2 − z.im > 1` for every `z.im < 1`); the hypothesis `(h0 : 0 ≤ h)` is added, the row's "depth". Proved in that form.
The wider `-2 < h` is not stated.

**Leaves closed** (cumulative 18 of 71): `not_semiconcaveWith_one_lowerArc` (explicit triple `s = 3/20`, `h = 1/25`, rational sqrt bounds),
`band_excludes_horn`, `le_one_of_band_unitFree`, `vesica_apex`, `vesica_apex_exact`, `fatZ_spec`.

## Stage 3 — SAVED: derived closures, FalconerReduction/Stationary leaves; the build is green; stop with 48 leaves left

**Leaves closed** (cumulative 23 of 71): `muZero_eq_one_iff_tendsto`, `seven_le_chiM0_iff` (children `antitone_mu`, `mu_le_one`, `muZero_le_one`,
`upperDensity_le_one` in `Plane/Suprema`), `exists_tight_iff_chiM0_le` (padding by `Fin.castLE`), `le_chiM_of_falconerFan`,
`CPColouring.forcedSet_eq_zero` (rotation invariance, discreteness, `exp (θ i) = 1`).

**Build**: `./scripts/build.sh` under the slot, OK, 443 of 443, 123 `declaration uses sorry` warnings and no other
(`build/gate/build/20261004T070546Z-1830028.log`). `tools/check_architecture.py` PASS (`Plane/MaximalCover` imports `Plane/DensityPoints`).
`scripts/Axioms.lean`: 18 records added for the children, before the `=== PURCHASED ===` marker.

**Re-pricing** (from the first leaves): the measure-theoretic exhaustion (`exists_ae_maximal`) took one session-hour; BAND, DISC7-free examples and the
derived closures were E, as planned; `forcedSet_eq_zero` was cheaper than M. The 13 H leaves are untouched and remain multi-hour each.

**Left (48)**: `Plane/MaximalCover` 4 (`enclosing_or_exterior`, `curvatureLeOne`, `semiconcaveWith`, `exists_grundy`); `Plane/Slack` 15
(`exists_tight`, `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer`, `chiM0_le_chiCP`, `chiM0_le_iff_muZero_eq_one`, `chiM0_le_iff_periodic`,
`exists_bandNull_aeCover_of_mu_eq_one`, `forall_mu_six_lt_one_iff`, `keptAt_band`, `CPColouring.tendsto_not_kept`, `exists_not_uniform_kept`, `face`,
`face_densitySet`, `exists_face_fails`); `Plane/Stationary` 2 (`nonempty_cpColouring_nine`, `exists_discrete_forcedSet`); `Plane/FalconerReduction` 3
(`twoCircle_preimage_null`, `falconer_lemma1`, `falconer_reduction`); `Plane/YesLimit` 2; `Plane/CoverExamples` 16; `Arith/PlaceHom` 2;
`Arith/FalconerField` 2 (`falconerFan_five_field`, `falconerFan_five_placeHom`); `Arith/Dyadic` 2 (`sqrt3_local_of_congr`, `sqrt3_local`).
Ready next, by the obligation graph: `exists_grundy` (use `exists_ae_maximal` per colour), `enclosing_or_exterior` (via `essSupport_eq_closure_densitySet`,
`hullset`), `disc7_*` (periodic density child `upperDensity_of_periodic` still to state), `face`.

## Stage 4 — SAVED (FS131-I2b): five leaves, two rulings applied; the build is green; 43 leaves left

**Readback.** Brief's quotations checked against `plans/FS131-w2-kernel-plan.md` Stage 10 and this record's Stage 3: they match. May not: change any statement,
hypothesis or definition's meaning (rulings 56 and 57 below are the only authorised changes); no new `axiom`, no `native_decide`. `main` has moved since `0b97dd89`
(not merged this session; merge at the landing).

**Leaves closed** (cumulative 28 of 71): `twoCircle_preimage_null` (local inverses of a `C¹` map on the open set `sin(φ−s) ≠ 0`, countable cover, the lines null;
children `preimage_inter_null_of_invertible_deriv`, `twoCircleMap`, `twoCircleDeriv_injective`, `volume_sinZero_null`), `falconer_lemma1` (by contradiction: a
positive-arc point of `E` on a circle about every `p ∈ E`, then `slice_slice_null` through the two-circle lemma kills the countable union),
`CPColouring.exists_discrete_forcedSet` (children: stationarity of the pair law, `forcedSubgroup`, closedness by continuity in probability,
`exists_pos_forall_norm_lt_eq_zero`: a closed subgroup of `ℂ` missing the unit circle is discrete, by multiples and compactness),
`chromaticNumber_plane_le_chiM0` (N-EASY: `AeColouring.exists_motion` picks `θ` off finitely many null angle sets and then `v` off finitely many null translates;
Mathlib's `nonempty_hom_of_forall_finite_subgraph_hom` finishes), `IsMaximalCover.enclosing_or_exterior` (through `…_contact`, with `y ∈ essSupport`;
`x ∈ closure P` is idle). `eq_norm_mul_e_arg` lives in `Plane/Cover`. Iteration used a symlink overlay farm (`scratchpad/ol`, never evidence).

**Rulings applied** (Keryx, 2026-10-04):
- **Item 56**: `IsLowerGraphOf`'s first clause reads the region below the graph in `densitySet A` (was `essSupport A`). The derivation applies the dichotomy
  to pieces of `F̃_a`. `r7_lowerGraph` (still `sorry`) must now show the region below R7's arc lies in the class's density set; message Keryx if it does not hold.
- **Item 57**: `CurvatureLeOne`'s test functions touch `u` from below (`φ s ≤ u s`); from above, `φ = u + N (s − s₀)²` refutes the bound (false on R7's
  lower arc, where `u'' = (1+u'²)^{3/2}`). `curvatureLeOne` and `semiconcaveWith` stay `sorry`; `semiconcaveWith` is to be re-derived from the corrected form.

**Notes for the successor on `curvatureLeOne`** (not proved): with the corrected direction, the enclosing case gives `u ≤ ψ` (the disc's upper arc,
`ψ'' < 0`) and the exterior case `u ≤ ψ_low` (`ψ_low'' = (1+ψ_low'²)^{3/2}`), so `φ ≤ u ≤ ψ` touching at `s₀` gives `φ'' ≤ ψ''`. The point
needing care: the **equator** configuration (`u s₀ = τ`, `|s₀ − σ| = 1`, vertical tangent) in the exterior case, where the disc gives no arc; a proof must
exclude it or show it harmless (e.g. by choosing another contact). `P` is the image of `I × [0,1)` under `(s, λ) ↦ frame(s, u s − δλ)`, preconnected,
in `Ã` by item 56.

**Not done, with the plan** (beside the leaf list below): `face` (the argument: a key lemma "open `B` with `|B∖A| = 0`, `y ∈ supp A`, and every unit circle
about `y'` near `y` meets `B` gives `¬ UnitPairsNull A`" by `pairSet_null_iff_ae_slice` and `pairSet_measure_eq_lintegral`; then the geometry: for `y ≠ x+e` the
half-box is met by every nearby circle, at `y = x+e` the far box is met for `c' ≥ 1` and the half-box for `c' < 1`, by the intermediate value theorem on a
convex box), `exists_tight` (dilate by `1/(1+ε*)` or `1/(1−ε*)` according to which side carries the non-null band; needs continuity in `r` of the unit-pair
mass at radius `r` to pass from `BandNull` to `UnitPairsNull`).

**Left (43)**: `Plane/MaximalCover` 3 (`curvatureLeOne`, `semiconcaveWith`, `exists_grundy`); `Plane/Slack` 15 (as Stage 3); `Plane/Stationary` 1
(`nonempty_cpColouring_nine`: route by `AddCircle × AddCircle` Haar or by `IsAddFundamentalDomain`; measurability of the descended colouring is the plumbing);
`Plane/FalconerReduction` 1 (`falconer_reduction`); `Plane/YesLimit` 1 (`chiM0_le_of_fragments`); `Plane/CoverExamples` 16; `Arith/PlaceHom` 2;
`Arith/FalconerField` 2; `Arith/Dyadic` 2.

**Build**: `./scripts/build.sh` under the slot, OK, 443 of 443, 9 modules rebuilt, 112 `declaration uses sorry` warnings and no other
(`build/gate/build/20261004T074250Z-1995015.log`); `tools/check_architecture.py` PASS. `scripts/Axioms.lean`: 19 records added for the children.

**Re-pricing**: the five leaves cost 40k tokens each on average (`twoCircle_preimage_null` and `falconer_lemma1` were M, not H); the Mathlib local-inverse API
(`ContDiffAt.toOpenPartialHomeomorph`, `addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero`) carried the hard part.

## Stage 5 — SAVED (FS131-I2c): five leaves, one ruling applied, `main` merged; 38 leaves left

**Readback.** Brief's quotations match Stage 10 of `plans/FS131-w2-kernel-plan.md` and Stage 4 above. May not: change any statement, hypothesis or
definition's meaning (except the rulings: 56, 57, and 63 below), no `axiom`, no `native_decide`. `main` merged (`211b4c7e`), no conflicts.

**Ruling applied** (Keryx, `plans/FS131-close-inventory.md` item 63): `exists_not_uniform_kept` gains `(hη : η < 1)`; at `η ≥ 1` `KeptAt` is vacuous
(`ofReal (1 − η) = 0`), no point is non-kept, and `m ≤ volume ∅` is false. Still `sorry`. **Item 64** (route note, no statement change): `sqrt3_local`
cannot go through `sqrt3_local_of_congr`, whose congruence `s² − 3 ∈ (4)·P` is global (all primes over `2`); a local square gives it at `P` only. Build a
P-local Kummer–Dedekind child (`s² − 3 ∈ P^(2e+1)`) and derive both.

**Leaves closed** (cumulative 33 of 71): `disc7_lens` (children `disc7_nbr`, `lens_pos`, `norm_tri_sub`), `nonempty_cpColouring_nine` (the torus
`(ℝ/(3/2)ℤ)²` with Haar measure, `sq9` read through `equivIoc`; children `torCol`, `torField`, `cpLaw`, `cpLaw_map_shift`, `cpLaw_proper`,
`cpLaw_tendsto` by dominated convergence off the null half-integer grid), `chiM0_le_iff_periodic` (⟸ needs no `tendsto_muPer`; ⟹ uses
`tendsto_muPer` and `chiM0_le_iff_muZero_eq_one`, both still `sorry`), `face_densitySet` (from `face`, still `sorry`; child `upperDensityAt_pos_of_halfBox`),
`forall_mu_six_lt_one_iff` (⟹ unconditional through closures of the classes; ⟸ through `exists_bandNull_aeCover_of_mu_eq_one`, still `sorry`;
children `voronov11_of_forall_mu_lt`, `mu_lt_of_voronov11`, `bandNull_of_bandFree`). Four of the five depend on other open leaves (derived closures).

**Build**: `./scripts/build.sh` under the slot, OK, 443 of 443, only `declaration uses sorry` (38 warnings), `build/gate/build/20261004T081144Z-2067541.log`.
`scripts/Axioms.lean`: 35 records added for the children. Gate not run (38 leaves left).

**Assessment of the rest** (for a fourth implementer): `exists_tight` and `exists_bandNull…` need continuity in `r` of the unit-pair mass (a convolution
`1_A ⋆ 1_{−A}` argument) — the endpoint of the slack range is a 3-dimensional null statement the 4-dimensional `BandNull` does not give; `curvatureLeOne`:
the equator configuration is excluded in both cases (a lower-graph piece `P` has points on both sides of `s₀`, and a vertical-tangent disc admits only one
side; in the exterior case the slice `(u−δ, u]` has fixed length while the forbidden strip has half-width `~√(2|s−s₀|)`), the remaining work is the
second-derivative comparison of a touching `C²` pair and the arc formulas; `keptAt_band` needs a lower bound on the arc of `S(u,1)` in `B(y,2ε)` and the
exchange identity `∫ arc{θ : u+eθ ∈ N} du = 2π|N|`. `sq9_tight_saturated`: tightness is an explicit rectangle product near the corner `(1/2, 3/2)`; saturation is a density computation on a union of squares.

**Re-pricing**: the five closed leaves cost 40–60k tokens each; the derived closures were cheap (about 20k each), the CP inhabitant the dearest (about 90k).

## Theorems this phase proved (FS131-I2c, additions)

Axioms not yet read from a saved audit log (gate not run); `scripts/Axioms.lean` has the records. Declarations: `disc7_lens` (FS111-M2-DISC7),
`nonempty_cpColouring_nine` (FS129-OA1-NOPERLAW's inhabitant), `chiM0_le_iff_periodic` (FS106-EQ (a)⟺(e), conditional on two open leaves),
`face_densitySet` (FS121-D4-FACE last clause, conditional on `face`), `forall_mu_six_lt_one_iff` (FS106-COMP second clause, ⟸ conditional on the attainment lemma).

## Stage 6 — SAVED (FS131-I2d): four leaves, one ruling applied; the build is green; 34 `sorry` left

**Readback.** Brief's two quotations match `plans/FS131-w2-kernel-plan.md` Stage 10 and Stage 5 above. May not: change any statement, hypothesis or definition's
meaning (rulings 56, 57, 63, and 72 below are the only authorised changes), no `axiom`, no `native_decide`. `main` has moved (`f3dae3d0`); not merged this
session (merge at the landing).

**Ruling applied** (Keryx, `plans/FS131-close-inventory.md` item 72, on this job's message): `IsLowerGraphOf`'s first clause is strict, `t < u s` — a point on a
smooth arc has density `1/2`, so `r7_lowerGraph` was false at `t = u s` (`s = 3/20`, `z₀ = e(π/6)`, `θ = 2π/3`). The docstring carries the item.

**Leaves closed** (cumulative 37 of 71 counting wave-2's earlier 33; 38 → 34 left): `r7_not_bandNull` (open set of band pairs in `U(0,0)`, vertex-to-arc
direction `e(π/6)`; child `r7ColTri_zero`), `r7_lowerGraph` (δ = 1/20; children `triCoord_frame`, `r7ColTri_four`, `triQ_far_gt`, `triQ_frame`: the frame's lattice
coordinates are `((1−t)/√3 ∓ s)`, `triQ = (1−t)² + s²`), `IsMaximalCover.curvatureLeOne` (the graph point is a frontier point; `enclosing_or_exterior_contact` on the
preconnected piece `P`; the touching curve `φ` gives `g(s) = |frame(s, φ s) − y|² − 1 ≤ 0` (or `≥ 0`) with `g(s₀) = 0`; second-derivative test through
`second_order_of_local_max`, via a `−(c/4)(s−s₀)²` perturbation and Mathlib's `isLocalMin_of_deriv_deriv_pos`; the vertical segment below the graph point fixes
the sign of `w = u s₀ − τ` in both cases; **the equator configuration is excluded by the first-order condition** `w = 0 ⇒ s₀ = σ ⇒ 0 = 1`; the exterior case ends at
`√X · (−w) = 1`), `IsMaximalCover.semiconcaveWith` (`semiconcave_pos`: a chord violation of `v = u − K x²/2` is touched from below by the convex parabola
`ℓ − ε(x−a)(b−x) + const`, min of `g_ε` on `[a,b]`; `abs_deriv_le_of_touch_below` gives `|φ'| ≤ L` from the Lipschitz bound by one-sided slopes).
**`sq9_tight_saturated`** is split: `sq9_tight` (with `sq9_not_bandNull`, `sq9Col_of_floor`) is proved; the saturation clauses are the one remaining `sorry`
`sq9_saturated_both` (plan: `essClosure (cls j)` lies in the closed squares of the class by floors; a boundary point off every open square lies on an edge;
the facing same-class edge is `x ± (1,0)` or `x ± (0,1)`, in `closure (densitySet)` as the closure of an open square; `essSupport ⊆ essClosure` here needs a
`1/16` ball-in-box density bound, as in `upperDensityAt_pos_of_halfBox`).

**Build**: `./scripts/build.sh` under the slot, OK, 443 of 443, 34 `declaration uses sorry` warnings and no other (`build/gate/build/20261004T085910Z-2325827.log`);
`tools/check_architecture.py` run. `scripts/Axioms.lean`: 17 records added for the children (the `sq9_saturated_both` child is not recorded: it is `sorry`).
Gate not run (34 leaves left).

**Findings for the successor.**
- `IsMUA.add_normal_mem_essSupport` (BAND (1)): route found and costed, not proved. Shadow gives `y_τ ∈ supp A` at distance `1` from `m + τ e` for every
  `τ ∈ (0, δ)`; the open half-box lies in `Ã` (open, a.e. inside `A`), so `dist_ne_one_of_mem_interior_densitySet` keeps `y_τ` at distance `≠ 1` from every
  half-box point; a limit `y*` of `y_τ` (compactness, `S` closed) has `|y* − m| = 1`, and the unit circle about `y* = m + e(σ + ρ i)` meets the open half-box
  (`g(s,t) = s² + t² + 2sσ − 2tρ = 0` on `0 < s < ε`, `|t| < ε`, by the intermediate value theorem on a convex box) unless `(σ,ρ) = (1,0)`. The cases `ρ ≠ 0`,
  `ρ = 0, σ = −1` need separate witnesses (`ρ = 0`, `σ = −1`: `t = ε/2` and `s` small). About 150 lines.
- `chiM0_le_chiCP` needs a jointly measurable modification of a process continuous in probability (dyadic approximation); `face` and `keptAt_band` are
  circle-meets-open-set arguments of the same kind; `sqrt3_local_of_congr`, `falconerFan_five_*`, `exists_placeHom` need Kummer–Dedekind and `decide +kernel`
  orbit tables (not started).
- Iteration: `lake env lean -DautoImplicit=false <file>` against the worktree's own oleans works from a scratch file importing the module (9 s for `CoverExamples`);
  after a statement change in `MaximalCover`, one real build is needed first.

**Re-pricing.** `r7_not_bandNull` 15k tokens, `r7_lowerGraph` 40k (the rebuild after the ruling included), `curvatureLeOne` 70k, `semiconcaveWith` 40k, `sq9_tight` 20k:
the M leaves ran at 40–70k, as the earlier stages found.

## Theorems this phase proved (FS131-I2d, additions)

Axioms not yet read from a saved audit log (gate not run); `scripts/Axioms.lean` has the records. Declarations: `r7_not_bandNull` (FS111-M-R7 tightness),
`r7_lowerGraph` (FS111-M-COVER-SC defect witness, with item 72), `IsMaximalCover.curvatureLeOne` (FS111-M-COVER-SC second clause, corrected),
`IsMaximalCover.semiconcaveWith` (its named corollary), `sq9_tight` (FS111-W-SQ9 tightness; the saturation half open).

## Stage 7 — SAVED (FS131-I2e): four of the sixteen re-planned leaves, 35 sorries fewer; the build is green; 90 `sorry` left

**Readback.** Both brief quotations match `plans/FS131-w2-kernel-plan.md` Stage 10 (the "May not" sentence) and Stage 13 (the "May" line); the branch built
as K2c left it (`bdba8ff5`, 1738 modules up to date). May not: change any statement, hypothesis or definition's meaning (rulings 56, 57, 63, 72, 86 and item 100
below are the only authorised changes), no `axiom`, no `native_decide`. `main` not merged (the landing's job). `Plane/CoverExamples`, `Arith/PlaceHom`,
`Arith/FalconerField` are FS131-K2d's and were not touched.

**Ruling applied** (Keryx, `plans/FS131-close-inventory.md` item 100, on this job's message): `arcLength_bigBall_ge` takes `(hR : 1 < R)`. At `R = 1`, `u = z`
the circle about `u` lies on the sphere and misses the open ball, so the arc is `0 < 2π/3`. Its one consumer (`not_keptAt_of_half_lt`, `R = 2ε > 1`) needs the strict form.

**Leaves closed** (of the sixteen): `keptAt_band` (children `keptAt_band_le_half`, `not_keptAt_of_half_lt`; shared Cover children `arcLength_ball_ge`,
`arcLength_sub_ball_le`, `arcLength_bigBall_ge`, `pairs_le_of_arc`, `twoBall_pairs_ge`, helpers `arcLength_eq_window`, `arcLength_ge_of_Ioo`,
`arcLength_le_of_subset_Ioo`, `norm_sq_e_sub`, `pairs_eq_lintegral`), `AeColouring.exists_grundy` (children `exists_isMaxIn`, `grundyTaken_eq`,
`grundyCls_isMaxIn`, `essSupport_subset_unitShadow_of_isMaxIn`, helpers `measurableSet_grundyTaken`, `unitPairsNull_iUnion_of_monotone`), `face`
(children `not_unitPairsNull_of_circles_meet`, `isOpen_halfBox`, `isOpen_farBox`, `circles_meet_halfBox`, `circles_meet_boxes_at_normal`; the geometry through
`framePt`, the intermediate value theorem on the half-box, and `exists_far_point`, the explicit far-box point `g + δ` with `δ` chosen from `u` and `ρ|v|/(1 − g)`),
`exists_face_fails` (children `exists_faceFailClass_noUnitPairs` by a six-way real lemma `real_no_unit`, `exists_aeColouring_of_noUnitPairs`,
`measurableSet_faceFailClass`, `add_e_mem_essSupport_faceFailClass`). Also closed, children of open leaves: `essClosure_subset_essSupport`, `volume_densitySet_diff`,
`exists_ne_mem_essClosure`, `IccPairNull.mono`, `IccPairNull.union`, `isPeriodicSet_periodize`, `measurableSet_periodize`, `iUnion_periodize`, `disjoint_periodize`,
`unitPairsNull_preimage_add`, `bandNull_preimage_add`. `face_densitySet` was already proved from `face`, so it is now unconditional.

**Build**: `./scripts/build.sh` under the slot, OK, 443 of 443, 8 modules with warnings, every warning `declaration uses sorry` (90 declarations),
`build/gate/build/20261004T105629Z-2873941.log`; `tools/check_architecture.py` PASS. `scripts/Axioms.lean`: 33 records added (block "FS131-I2e"). The 33 were
printed from the built library: all on `[propext, Classical.choice, Quot.sound]`, no `sorryAx` (`data/fs131/i2/i2e-axioms.txt`). The gate (`axioms.sh`, vacuity)
was not run: it fails on the 90 remaining `sorry` by design.

**Still `sorry`** (counts of lines that are exactly `sorry`): `Plane/Cover` 2 (`essClosure_dist_ne_one_of_mem_densitySet`, `measurableSet_densitySet`),
`Plane/Slack` 46, `Plane/FalconerReduction` 9, `Plane/YesLimit` 4, `Plane/CoverExamples` 13, `Arith/PlaceHom` 2, `Arith/FalconerField` 2, `Arith/Dyadic` 12;
`Plane/MaximalCover` and `Plane/Stationary` none. Of the sixteen, twelve remain: `exists_tight`, the three limits, `chiM0_le_chiCP`, `chiM0_le_iff_muZero_eq_one`,
`exists_bandNull_aeCover_of_mu_eq_one`, `CPColouring.tendsto_not_kept`, `falconer_reduction`, `chiM0_le_of_fragments` (its child `muZero_eq_one_of_fragments` and
`chiM0_le_iff_muZero_eq_one` still open), and both Dyadic leaves.

**Re-pricing** (from this session's rates): Cover arcs 45k in all (five lemmas and helpers), `keptAt_band` 25k, `exists_grundy` 60k (the shadow clause 15k, the
assembly 15k), `face` 85k (the key lemma 20k, the two geometry children 35k and 30k), `exists_face_fails` 45k. The planner's prices held within a factor of two;
nothing was cheaper than priced. Hand-checked pitfalls for the next implementer: `f =ᵐ[μ] g` on sets parses `∪` into its right side (name the set first);
`simp` on an `ofReal`/`NNReal.pi` area needs `← NNReal.coe_real_pi, ENNReal.ofReal_coe_nnreal`, never `simp [NNReal.pi]`.

## Theorems this phase proved (FS131-I2e, additions)

Axioms read from `data/fs131/i2/i2e-axioms.txt` (printed from the built library, not from the gate's saved log; the gate was not run): every line below is
`[propext, Classical.choice, Quot.sound]`. `keptAt_band` (FS106-REM first clause, one class), `AeColouring.exists_grundy` (FS121-D3-GRUNDY), `face`
(FS121-D4-FACE, with FACE-SHARP's hypothesis), `exists_face_fails` (FS121-V5-FACE-SHARP's failure half, with item 86), `arcLength_bigBall_ge` (item 100's strict
form), `twoBall_pairs_ge`, `pairs_le_of_arc`, `exists_ne_mem_essClosure`, `not_unitPairsNull_of_circles_meet`. Each read against its docstring, which carries the row.

## Drafts for the front page

None: the gate was not run (90 `sorry` remain in the wave-2 modules). Vacuity carriers for wave 2 are not yet registered.

## Stage 8 — SAVED (FS131-I2f, Opus implementer trial): readback; lane A closed (19 children); SQ9 closed (5 children)

**Readback.** Both brief quotations checked by `grep -F` against `plans/FS131-w2-kernel-plan.md`: the "May" line of § 13 (line beginning
"- **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);")
and the "What is left" line of § 18 (line 1070) — both exact. Counts at `ddc5b5c8` by script (lines that are exactly `sorry`): `Plane/Slack` 46,
`Plane/CoverExamples` 62, `Arith/PlaceHom` 14, `Arith/Dyadic` 12, `Plane/FalconerReduction` 9, `Arith/FalconerField` 5, `Plane/YesLimit` 4,
`Plane/Cover` 2 — 154, as the brief says. **May**: prove any child or leaf; add further children (each stated as a lemma first, with its
`scripts/Axioms.lean` record); move declarations within a module; add imports (with `ARCHITECTURE.md`'s Imports cell); supporting definitions.
**May not**: change any row statement, hypothesis, or definition's meaning (rulings 48, 56, 57, 63, 72, 86, 100 are the authorised changes so far),
nor any child statement fixed by K2c or K2d; no `axiom` (`falconer_lemma2_nonempty` is the one declared import), no `native_decide`.

**Build as given**: launched at `ddc5b5c8` under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`); it waited about 20 minutes for admission
and, by the time it reached `Arith/PlaceHom` and `Arith/FalconerField`, read this session's first edits to those two files (the build reads files
as it reaches them). **OK** — 443 of 443 batches, 5 modules rebuilt (`Instances/FalconerOrbit`, `Arith/PlaceHom`, `Arith/FalconerField`,
`Plane/CoverExamples` and one dependent), every warning `declaration uses 'sorry'`, 8 m 35 s (`build/gate/build/20261004T112218Z-3062460.log`).
So K2d's modules rebuild; the evidence for the proofs below is the gate's build, not this one.

**Iteration**: a private symlink overlay of the worktree's oleans (scratch `i2f/ol`, never evidence), `lean -DautoImplicit=false
-DrelaxedAutoImplicit=false` with the overlay first on `LEAN_PATH`; `Instances/FalconerOrbit` compiled into it under a 6 GiB slot (4 s).

**Closed** (statements untouched):
- `Arith/FalconerField` (all 5): `not_falconerFan_of_colorable`, `sub_mem_of_connected`, `exists_hom_apex`, `tip_eq_zero_of_tipFree`,
  `not_falconerFan_five_of_hom_slack`.
- `Arith/PlaceHom` (all 14): `pureTranscendental_zero`, `pureTranscendental_succ`, `algebraicIndependent_init_and_transcendental_last`,
  `exists_valuationSubring_localization` (Mathlib's `Localization.subalgebra.ofField` — its carrier is exactly `{a s⁻¹ : s ∈ 𝔭ᶜ}` — a DVR by
  `isDiscreteValuationRing_of_dedekind_domain`, then `ValuationSubring.ofSubring`), `exists_residue_localization` (`IsLocalization.lift` of the
  quotient map; the non-unit clause through `B.valuation`), `placeHom_base` (`Subring.equivMapOfInjective` into `ℝ`; `−1` not a square by
  `FiniteField.isSquare_neg_one_iff`), `placeHom_step` (`V₁ = (W.comap L).map ι`, `W = (V₀.comap g).map ι`, `φ₁` through two
  `equivMapOfInjective`s and two `RingHom.restrict`s; constants by `AlgEquiv.commutes`), `exists_hom_of_isPlaceHom` (the coset construction on
  `{z : z.re, z.im ∈ V}` directly in `ℂ`), `chromaticNumber_planeOver_pureTranscendental_eq`, `nonempty_ringEquiv_zmod_of_card`,
  `exists_hom_finitePlane_of_card`, `slack_complete`, `exists_hom_slack`, `forall_const_of_hom_slack`.
  **So lane A's four leaves are sorry-free**: `exists_placeHom` (FS129-SA1-PLACE-HOM), `noAffine_fields` (FS129-SA1-NOAFF-FIELDS),
  `falconerFan_five_field` and `falconerFan_five_placeHom` (FS129-SA1-FALC-RES (i), (ii)); `Arith/PlaceHom` and `Arith/FalconerField` elaborate
  with no warning.
- `Plane/CoverExamples`, SQ9 (all 5): `SaturatedPos.saturated`, `sq9_essClosure_subset` (the colour's closed squares as a `LocallyFinite`
  family), `sq9Sq_subset_essClosure`, `sq9_mem_edge_of_not_mem_densitySet`, `sq9_partner`. Two new children, stated before use and recorded in
  `scripts/Axioms.lean` (block "FS131-I2f"): `upperDensityAt_pos_of_balls` (a quarter-radius ball a.e. inside `A` at every small radius gives
  density ratio `≥ 1/16`), `sq9_openSq_subset`. **So `sq9_saturated_both`, and with it `sq9_tight_saturated` (FS111-W-SQ9), is sorry-free.**

**Count for the trial** (inventory item 103): 24 `sorry`ed children closed (lane A 19, SQ9 5) and 2 children added and proved; 4 + 1 leaves now
sorry-free from them. 130 lines that are exactly `sorry` remain (`Plane/CoverExamples` 57, `Plane/Slack` 46, `Arith/Dyadic` 12,
`Plane/FalconerReduction` 9, `Plane/YesLimit` 4, `Plane/Cover` 2).

**Re-pricing** (the first two hard children, as the brief asks): `exists_valuationSubring_localization` and `exists_residue_localization`, priced
35k and 30k at the Sonnet rate, took about 6k and 9k tokens of this session's context each, one compile-fix round each; `placeHom_step`
(priced 40k) about 12k with two rounds. Lane A's 19 children took about 55k in all against K2d's 445k Sonnet-rate table; SQ9's five about 20k
against 85k. On this evidence the Opus rate is roughly a quarter to a sixth of the Sonnet table, the gain largest on plumbing whose Mathlib API
exists (`Localization.subalgebra.ofField` replaced K2d's planned hand-built residue map).

## Stage 9 — SAVED (FS131-I2f): BAND (1) closed; DISC7's first two clauses closed; the build is green; 117 `sorry` left — handoff

**Closed since Stage 8** (statements untouched):
- BAND (1), `Plane/CoverExamples` (all 3): `IsMUA.exists_shadow_point`, `circle_meets_halfBox_of_ne` (the circle about `y = m + e θ · w` is
  parametrized rationally, `q(k) = 2k(σk + ρ, ρk − σ)/(1 + k²)`, `|q − w| = 1`, with `k` chosen by the sign of `ρ = w.im`; `ρ = 0` forces
  `w = −1` by `y ≠ m + e θ`), and the assembly of `IsMUA.add_normal_mem_essSupport` (shadow points at `τ_k = δ/(k + 2)`, a convergent
  subsequence in `closedBall m (δ + 1)`, the limit at distance `1` from `m`, then `dist_ne_one_of_mem_interior_densitySet` against the
  half-box). **So FS111-M3-BAND is sorry-free** (its other clauses were closed in Stage 2).
- DISC7, `Plane/CoverExamples` (9 of 12): `measurableSet_disc7`, `disc7Col_eq_dist_ge` (`a ≡ −3b (mod 7)` makes `a² + ab + b² = 7(7t² − 5tb + b²)`,
  positive, so `≥ 7`), `disc7_unitPair_mem_sphere`, `disc7_cover`, `disc7_colour_near` (the colour lattice is `μ·Λ`, `μ = 1 + 2ω`, `|μ|² = 7`;
  the centre `(a + p − 2q, 2p + 3q)` through `ω² = ω − 1`), `phi_closedBall_pos` (an open window of angles about `arg (c − p)`,
  `arcLength_ge_of_Ioo`), `disc7_isMUA`, `essSupport_disc7`, `volume_frontier_disc7`; and R7's child `unitPairsNull_of_unitPair_mem`
  (`unitPairSet A ⊆ N ×ˢ univ`, `Measure.prod_prod`). **So `disc7_isMaximalCover` and `disc7_isRegularMUA` (FS111-M2-DISC7's first two
  clauses) are sorry-free**; `disc7_lens` was already; `disc7_upperDensity` still needs `disc7_periodic`, `volume_disc7_cell`,
  `disc7_linearIndependent` and `Plane/Slack`'s `upperDensity_of_periodic`.
- New children, stated before use, recorded in `scripts/Axioms.lean` block "FS131-I2f": `triQ_cover_tri` (the Voronoi split of the lower
  triangle; certificates `1/3 − Q = (a + b)/6 + (au + bv)/2` and its two images), `tri_cover` (the unit triangular lattice's covering radius
  `1/√3`), `isClosed_disc7` (the discs as a `LocallyFinite` family over `ℤ × ℤ`).

**Build**: `./scripts/build.sh` under the slot at `aed439ba`: **OK** — 443 of 443 batches, 2 modules rebuilt (`Plane/CoverExamples`, `Proofs`),
6 modules with warnings, every warning `declaration uses 'sorry'` (359 lines, 0 others), 8 m 35 s (`build/gate/build/20261004T114615Z-3230511.log`).
`Arith/PlaceHom` and `Arith/FalconerField` built with no warning in the Stage 8 build (`✔` in `build/gate/build/20261004T112218Z-3062460.log`)
and are unchanged since. **Axioms**, printed from the built library with `lake env lean data/fs131/i2/i2f-axioms.lean` (not the gate's
`scripts/axioms.sh`, which fails on the remaining `sorry` by design): every line `[propext, Classical.choice, Quot.sound]`, no `sorryAx`
(`data/fs131/i2/i2f-axioms.txt`). Negative control: the same print of `disc7_upperDensity`, still `sorry`, reads
`[propext, sorryAx, Classical.choice, Quot.sound]` — the check can fire. The gate (axioms.sh, vacuity with wave 2's carriers) was not run.

**Count for the trial** (inventory item 103), this session: **37 lines that are exactly `sorry` closed** (lane A 19, SQ9 5, BAND (1) 3,
DISC7 9, R7's `unitPairsNull_of_unitPair_mem` 1) and **5 children added and proved**; **5 rows made sorry-free** (FS129-SA1-PLACE-HOM,
FS129-SA1-NOAFF-FIELDS, FS129-SA1-FALC-RES, FS111-W-SQ9, FS111-M3-BAND) and two of FS111-M2-DISC7's clauses. 154 → 117.

**Re-pricing, overall.** About 120k tokens of this session's context went to proofs (the rest to reading the briefs, plans and the build
waits): lane A 55k, SQ9 20k, BAND (1) 15k, DISC7 30k. K2c/K2d's Sonnet-rate prices for the same items total about 780k. The ratio held at
roughly one sixth across plumbing (lane A), measure-theoretic assembly (BAND) and explicit geometry (DISC7); no child was dearer than priced.
Most children compiled on the first or second try; the errors were tactic-level (a `rw` order, a `linarith` with an underdetermined `show`),
never a missing lemma.

**Still `sorry`** (lines that are exactly `sorry`): `Plane/Slack` 46 (unchanged: `exists_tight` and its children, the three limits and SUPK's
children, the modification and `chiM0_le_chiCP`, `tendsto_not_kept`, the compactness children and the attainment lemma, `exists_not_uniform_kept`),
`Plane/CoverExamples` 44 (R7 10: `measurable_r7Col`, `r7Col_mem_tile`, `r7UpCol_ne_r7DownCol`, `r7Up_unitPair`, `r7Up_sep`, `r7Down_dist_ne_one`,
`volume_iUnion_sphere_tri`, `r7_boundary_lattice`, `r7_boundary_offLattice`, `r7_phi_pos_up`/`_down` (11 with both); DISC7 3; (G1) 4; HC/IRREG 26
plus the three assemblies), `Arith/Dyadic` 12, `Plane/FalconerReduction` 9, `Plane/YesLimit` 4, `Plane/Cover` 2.
**Not touched**: `exists_not_uniform_kept`'s fringe formula (§ 17.1's open point) — no message to Keryx was needed, since I did not reach it.

**For the next implementer.**
- Order by row closure per child: DISC7's last three plus `upperDensity_of_periodic` close FS111-M2-DISC7; (G1)'s four close `g1Bounds_hcGap`;
  `Plane/Cover`'s two plus `FalconerReduction`'s nine close FALC-RED. `volume_iUnion_sphere_tri` is a two-line copy of `disc7_isMUA`'s `hN`.
- Iteration: a private symlink overlay of the worktree's oleans (`cp -rs .lake/build/lib/lean/Proofs <dir>/ol/`), `LEAN_PATH=<dir>/ol:$(lake env
  printenv LEAN_PATH)`, `lean -DautoImplicit=false -DrelaxedAutoImplicit=false`; compile a changed upstream module into the overlay with `-o`/`-i`.
  **Do not reuse the parent session's shared `scratchpad/ol`**: it already holds real (non-symlink) oleans from earlier wave-2 sessions
  (`Plane/Cover.olean` among them), stale against the branch.
- The Mathlib pin deprecates `push_neg` (use `push Not at h`, or `simp only [not_or, not_exists, not_and]`) and `mul_le_mul_left'` (here `gcongr`);
  both are warnings and the landing's build must have none.

## Theorems this phase proved (FS131-I2f, additions)

Axioms read from `data/fs131/i2/i2f-axioms.txt` (printed from the built library at `aed439ba`, not from the gate's saved log; the gate was not run):
- `HadwigerNelson.Arith.exists_placeHom` — `[propext, Classical.choice, Quot.sound]` — FS129-SA1-PLACE-HOM (§ 4.1's read-back: reduction mod `𝔭`
  on `𝒪_{F,𝔭}` as every `a/s ∈ V` with `φ(a/s)·s̄ = ā`; the coset formula as `h x − h y = (φ Δre, φ Δim)`).
- `HadwigerNelson.Arith.noAffine_fields` — the standard three — FS129-SA1-NOAFF-FIELDS.
- `HadwigerNelson.Arith.falconerFan_five_field` — the standard three — FS129-SA1-FALC-RES (i).
- `HadwigerNelson.Arith.falconerFan_five_placeHom` — the standard three — FS129-SA1-FALC-RES (ii), for every `(V, φ)` with PLACE-HOM's properties.
- `HadwigerNelson.Plane.sq9_tight_saturated` — the standard three — FS111-W-SQ9 (half-open squares for the row's closed ones).
- `HadwigerNelson.Plane.IsMUA.add_normal_mem_essSupport` — the standard three — FS111-M3-BAND (1), § 7.3's wider form.
- `HadwigerNelson.Plane.disc7_isMaximalCover`, `HadwigerNelson.Plane.disc7_isRegularMUA` — the standard three — FS111-M2-DISC7, first two clauses.
- Children: `upperDensityAt_pos_of_balls`, `sq9_openSq_subset`, `triQ_cover_tri`, `tri_cover`, `isClosed_disc7`, `unitPairsNull_of_unitPair_mem`,
  `phi_closedBall_pos` — the standard three.

## Drafts for the front page (FS131-I2f)

None: the gate was not run (117 `sorry` remain in wave 2's modules), and wave 2's vacuity carriers are not yet registered.
