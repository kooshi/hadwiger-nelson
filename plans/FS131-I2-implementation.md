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
`Plane/CoverExamples` 44 (R7 11: `measurable_r7Col`, `r7Col_mem_tile`, `r7UpCol_ne_r7DownCol`, `r7Up_unitPair`, `r7Up_sep`, `r7Down_dist_ne_one`,
`volume_iUnion_sphere_tri`, `r7_boundary_lattice`, `r7_boundary_offLattice`, `r7_phi_pos_up`, `r7_phi_pos_down`; DISC7 3; (G1) 4; HC/IRREG 23 children
and the three assemblies), `Arith/Dyadic` 12, `Plane/FalconerReduction` 9, `Plane/YesLimit` 4, `Plane/Cover` 2.
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

## Stage 10 — SAVED (FS131-I2g): readback; Dyadic's first nine children; the `ι ∉ F` ruling applied

**Readback.** Both brief quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754) and "Order by row
closure per child" (this record, Stage 9) — both exact. **May**: prove any child or leaf; add further children (stated as lemmas first, with their
`scripts/Axioms.lean` record); add imports; supporting definitions. **May not**: change any row statement, hypothesis or definition's meaning (except as
ruled below), any child statement fixed by K2c/K2d; no `axiom`, no `native_decide`. **Build as given** at `7c890ed9`: OK, all 1739 modules up to date,
6 modules with warnings (all `declaration uses 'sorry'`), `build/gate/build/20261004T115929Z-3328870.log`.

**Statement defect found and ruled (inventory item 134).** `Arith/Dyadic`'s `hi : ∃ ι : L, ι ^ 2 = -1` allowed `ι ∈ F`, so `L` was any quadratic extension;
`sqrt3_dyadic` was false at `F = ℚ(ζ₁₂)`, `L = F(√2)` (e(ℚ(ζ₂₄)/ℚ) = 4, e(ℚ(ζ₁₂)/ℚ) = 2: ramified), and `exists_root_quadratic` at `F = ℚ(i)`,
`s = 1, d = 2, δ = 2`. Ruled by Keryx: `hi` becomes `∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)` in exactly `exists_root_quadratic`,
`dyadicConclusion_of_coeffs`, `sqrt3_local_of_congr`, `sqrt3_local`, `sqrt3_dyadic`; applied, docstrings say so.

**Closed in `Arith/Dyadic`** (statements untouched but for the ruling): `x2x1_separable_irreducible_iff`, `card_quot_eq_two_pow`, `exists_span_four_eq`,
`exists_sq_sub_three_mem_pow` (completion density by `Valued.mem_nhds` on a ball about the root of radius `v(π^N)`, then `exists_valuation_sub_lt_of_integer`),
`exists_dyadic_coeffs` (one new child `ideal_le_of_mul_le`, cancellation of a nonzero ideal), `exists_root_quadratic`, `minpoly_eq_of_root`.
Left in Dyadic: `comap_conductor_sup_eq_top`, `dyadicConclusion_of_minpoly`, and the three assemblies.

## Stage 11 — SAVED (FS131-I2g): `Plane/Cover` and `Plane/FalconerReduction` sorry-free (compiled with `lake env lean`, build pending)

**Closed**: `Plane/Cover`'s two leaves — `essClosure_dist_ne_one_of_mem_densitySet` (from `twoBall_pairs_ge`: for `dist x y = 1`,
`densityRatio A x (r/4) ≤ 16π · densityRatio Aᶜ y (2r)`, then a squeeze) and `measurableSet_densitySet` (the density set read along rational radii,
`densitySet_iff_rat`; Tonelli for the centre-measurability) — and all nine of `Plane/FalconerReduction`: `upperHalfPlane_falconer_hyp`,
`densitySet_dist_ne_one`, `exists_mem_falconerE`, `two_classes_of_mem_falconerE`, `dist_circle_rotate`, `not_rotate_ae_eq_compl` (the ergodic rotation on
`AddCircle (2π)` through `AddCircle.ergodic_add_right`), `falconer_lemma4`, `fan_tip_ae_mem`, `falconer_reduction`. 16 children added, each stated before
use and recorded in `scripts/Axioms.lean` block "FS131-I2g". New imports in `Plane/Cover` (`Lebesgue.VolumeOfBalls`) and `Plane/FalconerReduction`
(`Dynamics.Ergodic.AddCircleAdd`, `Dynamics.Ergodic.Function`). Not yet built through `build.sh`: Cover's edit rebuilds every wave-2 dependent.

## Stage 12 — SAVED (FS131-I2g): `comap_conductor_sup_eq_top`, seven `Plane/Slack` leaves; handoff — 91 `sorry` left

**Closed since Stage 11** (statements untouched):
- `Arith/Dyadic`: `comap_conductor_sup_eq_top`, through two new children `exists_powerBasis_of_root` (a root of a quadratic outside `F` generates `L/F`:
  `Field.primitive_element_iff_minpoly_natDegree_eq`, `PowerBasis.ofAdjoinEqTop`) and `exists_coords_of_quadratic` (every integral `b ∈ L` has
  `(d² − 4δ) b = p + q g` with `p, q ∈ 𝓞 F`: write `b = u + v g`, read `Tr b` and `Tr (b g)` in `𝓞 F` (`Algebra.isIntegral_trace`,
  `IsIntegrallyClosed.isIntegral_iff`) and solve the 2×2 system, whose determinant is `d² − 4δ` — no `Algebra.discr`). The conductor then contains
  `d² s²` (`d² − 4δ = −d² s²`), a `P`-unit. Left in Dyadic: `dyadicConclusion_of_minpoly` (Kummer–Dedekind), and the assemblies
  `dyadicConclusion_of_coeffs`, `sqrt3_local_of_congr`, `sqrt3_local` (`sqrt3_dyadic` is proved from `sqrt3_local_of_congr`).
- `Plane/Slack` (46 → 39): `volume_prod_dist_eq_null`, `iccPairNull_of_forall_lt`, `muTile_le_mu`, `muPer_le_muTile`, `isGridUnion_periodize`,
  `bandFree_periodize` (two new children `shift_re`, `shift_im`), `keptAt_of_dist_le`. Moves: `volume_ball_ofReal` and `bandNull_of_bandFree` up
  in the file (no change).

**Still `sorry`** (lines that are exactly `sorry`; by file): `Plane/Slack` 39 (`unitPairsNull_iff_pairMass`, `continuous_pairMass`,
`ae_pairMass_eq_zero`, `pairMass_eq_zero_of_iccPairNull`, `iccPairNull_preimage_mul`, `AeColouring.exists_rescale`, `exists_pos_not_iccPairNull`,
`bandNull_unitPairsNull`, `mu_le_muZero`, `exists_squareWin_dense`, `ae_eventually_keptAt`, `upperDensity_of_periodic`, `upperDensity_periodize`,
`exists_tiled_kept`, `eventually_le_muPer`, the modification block (7), the compactness block (8), `exists_tight`, the three limits,
`chiM0_le_chiCP`, `chiM0_le_iff_muZero_eq_one`, `exists_bandNull_aeCover_of_mu_eq_one`, `tendsto_not_kept`, `exists_not_uniform_kept`),
`Plane/CoverExamples` 44 (unchanged), `Arith/Dyadic` 4, `Plane/YesLimit` 4 (its row waits on Slack's `chiM0_le_iff_muZero_eq_one`).
Sorry-free now: `Plane/Cover`, `Plane/FalconerReduction` (FS129-SA1-FALC-RED: the one declared import is `falconer_lemma2_nonempty`),
`Arith/PlaceHom`, `Arith/FalconerField`.

**Re-pricing.** This session's context: about 120k to read, plan and wait on builds; about 330k to prove. `Plane/Cover`'s two leaves (priced
30k + the Lemma 3 core) took about 22k and 18k; `FalconerReduction`'s nine (priced about 190k at the Sonnet rate) about 60k; `comap_conductor`
(priced 40k) about 20k. The Sonnet implementer's rate here was roughly a third of K2c's table; the cost was in finding the right Mathlib API
(`Valued.mem_nhds` with `restrict`, `AddCircle.ergodic_add_right`, `measurePreserving_add_right.quasiMeasurePreserving.ae` needing `(p := …)`
to elaborate within the heartbeat limit).

**For the next implementer.** (1) Order by row: `exists_squareWin_dense`, `ae_eventually_keptAt`, `exists_tiled_kept`, `upperDensity_of_periodic`,
`upperDensity_periodize` finish SUPK's lower bound (`eventually_le_muPer`); `continuous_pairMass`, `ae_pairMass_eq_zero` unlock
`pairMass_eq_zero_of_iccPairNull`, `bandNull_unitPairsNull`, `mu_le_muZero`. (2) `dyadicConclusion_of_minpoly` is the one hard Dyadic child;
the rest of Dyadic is plumbing from it. (3) `exists_not_uniform_kept`'s fringe-colouring open point (§ 17.1) was not reached.
(4) Iteration: `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false <file>` reads the worktree's built oleans directly (the build is
a few seconds for files whose upstream is built); a scratch file `import`ing the module being edited conflicts with its declared names, so give
test copies fresh names. Do not edit a module while `build.sh` has not yet passed it.

## Theorems this phase proved (FS131-I2g, additions)

Axioms are those of the gate-less `lake env lean` run of `scripts/Axioms.lean`'s block "FS131-I2g" (see Stage 12's build; `falconer_reduction`
and `le_chiM_of_falconerFan` carry `falconer_lemma2_nonempty`):
- `HadwigerNelson.Plane.falconer_reduction`, `le_chiM_of_falconerFan` — FS129-SA1-FALC-RED (the import `falconer_lemma2_nonempty` declared).
- Its children: `essClosure_dist_ne_one_of_mem_densitySet`, `measurableSet_densitySet`, `densitySet_dist_ne_one`, `exists_mem_falconerE`,
  `two_classes_of_mem_falconerE`, `dist_circle_rotate`, `not_rotate_ae_eq_compl`, `falconer_lemma4`, `fan_tip_ae_mem`, `upperHalfPlane_falconer_hyp`.
- `HadwigerNelson.Arith.comap_conductor_sup_eq_top`, `exists_dyadic_coeffs`, `exists_root_quadratic`, `minpoly_eq_of_root`, `exists_sq_sub_three_mem_pow`,
  `exists_span_four_eq`, `card_quot_eq_two_pow`, `x2x1_separable_irreducible_iff` — children of FS129-SA1-SQRT3-LOCAL (row not closed).
- `HadwigerNelson.Plane.keptAt_of_dist_le`, `isGridUnion_periodize`, `bandFree_periodize`, `muTile_le_mu`, `muPer_le_muTile`,
  `volume_prod_dist_eq_null`, `iccPairNull_of_forall_lt` — children of SUPK (row not closed).

## Drafts for the front page (FS131-I2g)

None: the gate was not run (91 `sorry` remain in wave 2's modules).

## Stage 13 — SAVED (FS131-I2h, Opus): readback; the branch builds as given

**Readback.** Both brief quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754, § Stage 13) and
"**Closed since Stage 11** (statements untouched):" (this record, Stage 12, line 388) — both exact. Counts at `59976a11` by script (lines that are exactly
`sorry`): `Plane/Slack` 39, `Plane/CoverExamples` 44, `Arith/Dyadic` 4, `Plane/YesLimit` 4 — 91, as the brief says.

**May**: prove any child or leaf; add further children (each stated as a lemma before use, with its `scripts/Axioms.lean` record); move declarations within
a module; add imports (with `ARCHITECTURE.md`'s Imports cell); add supporting definitions (the fringe colouring of `exists_not_uniform_kept`); register wave 2's
vacuity carriers under FS131-T1's procedure; move the four `falconer_lemma2_nonempty` records to the IMPORTED section; docstrings. **May not**: change any row
statement, hypothesis or definition's meaning (the rulings 48, 56, 57, 63, 72, 86, 100, 134 are the authorised changes; item 134's Dyadic repair is kept), nor
any child statement fixed by K2c or K2d; no new `axiom` (`falconer_lemma2_nonempty` is the one declared import), no `native_decide`. A leaf that cannot be
proved as written goes to Keryx.

**Build as given** at `59976a11`: OK — all 1739 modules up to date, 4 modules with warnings, 91 warnings, every one `declaration uses 'sorry'`
(`build/gate/build/20261004T142103Z-4106167.log`).

## Stage 14 — SAVED (FS131-I2h): `main` merged; Dyadic, YesLimit and DISC7 closed; eleven Slack leaves; 91 → 67

**`main` merged now, not at the landing** (`28f26bc1`): wave 3's `Plane/LocalMap` and `Plane/LocalStructure` already hold `ArcMap.isOpen_region`,
`Arc.isClosed_carrier` and `Arc.volume_carrier`, which YesLimit's children need; proving them again under new names would have been duplicate facts
(item 142). Conflicts: `Proofs.lean` (both sides' imports kept) and `scripts/Axioms.lean` (main's `libraryAxioms` line kept). **The two collisions**
renamed on wave 2's side: `Plane.dist_rot` (FalconerReduction) → `dist_add_e_mul`, `Plane.eq_norm_mul_e_arg` (Cover) → `self_eq_norm_mul_e_arg`,
every use and record renamed (wave 3's own records of its `dist_rot`, `eq_norm_mul_e_arg` untouched). **The IMPORTED move** (T3's procedure, step 2–3):
`#eval AxiomAudit.declareImport ``HadwigerNelson.Plane.falconer_lemma2_nonempty` added under the IMPORTED banner, and the four records
`falconer_reduction`, `le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem` moved below it; `ARCHITECTURE.md` § Trust already names
`Plane.falconer_lemma2_nonempty`. Not yet checked by `axioms.sh` (it fails on the remaining `sorry` by design). Build of the merge: OK, 446 of 446
batches, 25 modules rebuilt, every warning `declaration uses 'sorry'` (`build/gate/build/20261004T143159Z-4137400.log`).

**Closed** (statements untouched; children stated before use, recorded in `scripts/Axioms.lean` block "FS131-I2h"):
- `Arith/Dyadic` (4 → 0): `dyadicConclusion_of_minpoly` — Kummer–Dedekind through `normalizedFactors`: the reduced minimal polynomial is
  `X² + X + 1`, separable so squarefree, so `P𝓞_L`'s factors are distinct (`ramificationIdx = count = 1`); their number is the number of factors of
  `X² + X + 1` over `𝓞_F/P` (`Multiset.card_map`), at most `[L:F] = 2` (`Ideal.card_primesOverFinset_le_finrank`), one iff irreducible iff
  `¬ 3 ∣ 2^f − 1` iff `f` odd; the inertia degree `2` in the inert case from `Ideal.sum_ramification_inertia`. New child
  `three_dvd_two_pow_sub_one_iff`. Then `dyadicConclusion_of_coeffs`, `sqrt3_local_of_congr` (`d = 1`, `δ = 1 + t`, `4t = s² − 3`), `sqrt3_local`.
  **So FS129-SA1-SQRT3-LOCAL and TC1-SQRT3-DYADIC are sorry-free**, on item 134's hypotheses.
- `Plane/Slack` (39 → 26): `unitPairsNull_iff_pairMass`, `dist_gridPoint_lt`, `measurable_eval_gridPoint`, `CPColouring.law_ne_shift`,
  `CPColouring.exists_unif`, `bandNull_unitPairsNull`, `mu_le_muZero`, `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` (each a squeeze between
  `eventually_le_muPer` and `mu_le_muZero`, children still `sorry`), `chiM0_le_chiCP` (from the modification children, still `sorry`),
  `upperDensity_of_periodic` and `upperDensity_periodize` — both through one new squeeze, `upperDensity_of_tiling` (translates of a bounded window of
  positive area tiling the plane, the set invariant under them: the windows inside `B(0, R)` cover `B(0, R − δ)`), with the new children
  `measurableSet_squareWin`, `volume_squareWin`, `volume_ball_div_volume_ball`, `tendsto_sq_add_div`, `parallelogram_tiling` (coordinates in the
  basis `v₁, v₂`: measurable, positive area, diameter `≤ ‖v₁‖ + ‖v₂‖`, translates covering once), and two supporting definitions `parallelogram`,
  `latticePt` (spec example beside them).
- `Plane/YesLimit` (4 → 0): `ArcMap.measurableSet_region_inter` (wave 3's `isOpen_region`), `ArcMap.volume_ball_diff_region`
  (`measure_null_of_locally_null`, wave 3's `Arc.volume_carrier`), `ArcMap.bandFree_region`, `muZero_eq_one_of_fragments` (the window of side `ℓ`
  inscribed in `B(p, ℓ)`, periodized at `ℓ + 2`, density `ℓ²/(ℓ + 2)² → 1`). New import `Plane/LocalStructure` (ARCHITECTURE.md's Imports cell).
  FS116-O1-YESLIM now waits only on Slack's `chiM0_le_iff_muZero_eq_one`.
- `Plane/CoverExamples` (44 → 41): `disc7_periodic`, `disc7_linearIndependent` (moved above its first use), `volume_disc7_cell` (one disc per cell
  by the tiling and the colour-class discs' `√21/2` separation; the covolume `21√3/8` by `addHaar_image_linearMap`). **So FS111-M2-DISC7 is
  sorry-free** (`disc7_upperDensity` included).

**Iteration**: a private overlay of the worktree's oleans in the session scratch (`ol/`, Slack's olean compiled into it), `lean` with the overlay first on
`LEAN_PATH` — never evidence; the stage's build follows.

**Re-pricing** (the brief's ask, from the first two hard children): `dyadicConclusion_of_minpoly` about 25k tokens and `upperDensity_of_tiling` with
its two instances about 30k — K2c's table priced the Dyadic engine and the periodic density at about 40k each at the Sonnet rate. The easy Slack leaves
ran at 2–4k each. The rate holds near a third of the table, as I2f measured.

## Stage 15 — SAVED (FS131-I2h): exists_tight, R7's first three, four HC children, two more Slack leaves; the build is green; 53 `sorry` left — handoff

**Closed since Stage 14** (statements untouched):
- `Plane/Slack` (26 → 19): `pairMass_eq_zero_of_iccPairNull` (the closed zero set of a continuous function holds the open band less a null set,
  so all of it), `iccPairNull_preimage_mul` (`addHaar_preimage_smul` on `ℂ × ℂ`), `AeColouring.exists_rescale` (pair mass at radius `s` pulled
  back by `Prod.map (s • ·) id`, quasi-measure-preserving), `AeColouring.exists_tight` (FS111-V0-RESCALE: `a* = inf {a ≤ 1 : every class null on
  [a, 1]}`, positive by `exists_pos_not_iccPairNull`, attained by `iccPairNull_of_forall_lt`, pair mass zero at `a*`, rescale; slack `ε` would put
  `a*(1 − ε)` in the set), `exists_selection` (least colour of positive weight; its fibres are finite Boolean combinations of `{0 < F j}`),
  `ae_eventually_keptAt` (Besicovitch density at `ε/2` and `2ε`), `CPColouring.lintegral_ball_ne` (Tonelli on `law ⊗ volume`, the modification
  a.s. at `y` and at `0`).
- `Plane/CoverExamples` (41 → 34): `measurable_r7Col` (floors into a countable type, three measurable tests), `r7UpCol_ne_r7DownCol`,
  `volume_iUnion_sphere_tri`; HC's `dist_hcFrame`, `hcFrame_coords`, `essSupport_of_isOpen`, `subset_compl_unitShadow_closure` (a point of `U`
  at distance `1` from `closure U` is moved along the line to a point of `U` at distance exactly `1` from a nearby point of `U`).

**Build** at `a0865f7d`: `./scripts/build.sh` under the slot, OK — 446 of 446 batches, 2 modules rebuilt, 2 modules with warnings, every warning
`declaration uses 'sorry'` (`build/gate/build/20261004T151522Z-268577.log`); `Arith/Dyadic`, `Plane/YesLimit` build with no warning.
`tools/check_architecture.py`: PASS (Stage 14's YesLimit import). **Axioms**, printed from the built library with `lake env lean
data/fs131/i2/i2h-axioms.lean` (not `scripts/axioms.sh`, which fails on the remaining `sorry` by design): `data/fs131/i2/i2h-axioms.txt`. Negative
control: `continuous_pairMass`, still `sorry`, prints `sorryAx` — the check can fire. The gate (axioms.sh with the IMPORTED move, vacuity with wave 2's
carriers) was not run.

**Still `sorry`** (lines that are exactly `sorry`; 53):
- `Plane/Slack` 19: `continuous_pairMass`, `ae_pairMass_eq_zero`, `AeColouring.exists_pos_not_iccPairNull` (these three carry `exists_tight` and
  `bandNull_unitPairsNull` → `mu_le_muZero` → the three SUPK limits); `exists_squareWin_dense`, `exists_tiled_kept`, `eventually_le_muPer` (SUPK's lower
  bound: the window, the pixelation, the assembly); `CPColouring.exists_modification`, `CPColouring.ae_unitPairsNull_of_modification` (carry
  `chiM0_le_chiCP`), `CPColouring.tendsto_not_kept` (assembly: Markov on `lintegral_ball_ne`, now proved, with `exists_unif`); the compactness block
  `exists_weakStar_subseq`, `convForm_tendsto`, `exists_twoCircle_density`, `integral_circleAvg_sq`, `unitForm_tendsto`,
  `exists_translates_small_hole`, `ae_sum_eq_one_of_weakStar` and its two assemblies `chiM0_le_iff_muZero_eq_one` (the one leaf FS116-O1-YESLIM
  still waits on) and `exists_bandNull_aeCover_of_mu_eq_one`; `exists_not_uniform_kept` (§ 17.1's fringe formula not reached).
- `Plane/CoverExamples` 34: R7 8 (`r7Col_mem_tile`, `r7Up_unitPair`, `r7Up_sep`, `r7Down_dist_ne_one`, `r7_boundary_lattice`,
  `r7_boundary_offLattice`, `r7_phi_pos_up`, `r7_phi_pos_down`); (G1) 4 (`hcGap_eq_of_gap`, `differentiable_hcGap`, `hcGap_bounds`,
  `hcGap_lowerParabola` — the route: `g′ = uv(v − u)/2`, `|g″| ≤ 1/2` on a gap, `g′ = 0` on `Z` from `g ≤ dist²/4`, `g′` `1/2`-Lipschitz across
  gaps through a point of `Z` between, then Taylor); HC/IRREG 22 (`hcUpTri_frame` onward, § 17's list).

**Owed before the gate, not done this session**: docstrings for the wave-2 theorems that lack them (`tools/fs131_qa1_quality.py`; item 144 (d));
FALC-HOSTS (iv)'s docstring on `falconerFan_five_mem_P`; wave 2's vacuity carriers (`CPColouring`, `AeCover`, maximal covers, partial colourings)
registered under FS131-T1's procedure with a control each; the IMPORTED move is in place (Stage 14) but unverified until `axioms.sh` runs.

**For the next implementer.** (1) `main` is merged (Stage 14); the landing's merge will be small. (2) Cheapest next: `tendsto_not_kept` (Markov:
`¬ KeptAt` at `ρ ∈ {ε/2, 2ε}` puts `volume (ball 0 ρ ∩ {ct f · ≠ ct f 0}) ≥ η · volume (ball 0 ρ)`; `meas_ge_le_lintegral_div` with
`lintegral_ball_ne` and `exists_unif`), the four (G1) children (route above), `exists_near_hcFace` (floors in the face lattice), `pairMass`'s
continuity (`L¹` continuity of translation along the circle). (3) Iteration: a private overlay of the worktree's oleans (`cp -rs .lake/build/lib/lean/Proofs
<dir>/ol/`), the edited upstream module compiled into it with `lake env lean -o … -i …`, then `LEAN_PATH=<dir>/ol:$(lake env printenv LEAN_PATH) lean
-DautoImplicit=false …` — `lake env lean` resets `LEAN_PATH` and ignores the overlay. Testing a module's edits on a scratch copy of the file is safe
while `build.sh` runs; editing the module is not.

**Re-pricing, overall**: about 300k tokens of this session went to proofs, merging and builds for 38 lines and 12 new children; the easy leaves at
2–5k, the hard children (Kummer–Dedekind, the tiling squeeze, the disc-per-cell count) at 25–35k.

## Theorems this phase proved (FS131-I2h, additions)

Axioms read from `data/fs131/i2/i2h-axioms.txt` (printed from the built library at `a0865f7d`; the gate was not run). Each read against its docstring,
which carries the row.
- `HadwigerNelson.Arith.sqrt3_local` — `[propext, Classical.choice, Quot.sound]` — FS129-SA1-SQRT3-LOCAL (item 134's `hi`: `ι² = −1`, `ι ∉ F`);
  `sqrt3_dyadic` (TC1-SQRT3-DYADIC, merged), `sqrt3_local_of_congr`, `dyadicConclusion_of_coeffs`, `dyadicConclusion_of_minpoly`,
  `three_dvd_two_pow_sub_one_iff` — the standard three.
- `HadwigerNelson.Plane.disc7_upperDensity` (FS111-M2-DISC7, last clause), `volume_disc7_cell`, `disc7_periodic`, `disc7_linearIndependent` — the
  standard three. **FS111-M2-DISC7 is sorry-free.**
- `HadwigerNelson.Plane.muZero_eq_one_of_fragments` (FS116-O1-YESLIM's child), `ArcMap.measurableSet_region_inter`,
  `ArcMap.volume_ball_diff_region`, `ArcMap.bandFree_region` — the standard three. `chiM0_le_of_fragments` carries `sorryAx` through
  `chiM0_le_iff_muZero_eq_one`.
- `HadwigerNelson.Plane.upperDensity_of_periodic`, `upperDensity_periodize`, `upperDensity_of_tiling`, `parallelogram_tiling`,
  `measurableSet_squareWin`, `volume_squareWin`, `volume_ball_div_volume_ball`, `tendsto_sq_add_div` — the standard three.
- `HadwigerNelson.Plane.unitPairsNull_iff_pairMass`, `dist_gridPoint_lt`, `measurable_eval_gridPoint`, `CPColouring.law_ne_shift`,
  `CPColouring.exists_unif`, `CPColouring.lintegral_ball_ne`, `iccPairNull_preimage_mul`, `AeColouring.exists_rescale`, `exists_selection`,
  `ae_eventually_keptAt` — the standard three.
- Sorry-free in body, `sorryAx` through open children: `AeColouring.exists_tight` (FS111-V0-RESCALE) and `exists_tight_iff_chiM0_le`,
  `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` (FS129-SR2-SUPK), `chiM0_le_chiCP`, `mu_le_muZero`, `bandNull_unitPairsNull`,
  `pairMass_eq_zero_of_iccPairNull`.
- `HadwigerNelson.Plane.measurable_r7Col`, `volume_iUnion_sphere_tri` — the standard three; `r7UpCol_ne_r7DownCol` — `[propext, Quot.sound]`.
- `dist_hcFrame`, `hcFrame_coords`, `essSupport_of_isOpen`, `subset_compl_unitShadow_closure` — built at `a0865f7d`, not in the print file.
- Renamed, unchanged: `dist_add_e_mul` (was `dist_rot`), `self_eq_norm_mul_e_arg` (was `eq_norm_mul_e_arg`) — the standard three;
  `falconer_reduction` — the standard three and `HadwigerNelson.Plane.falconer_lemma2_nonempty`, the declared import.

## Drafts for the front page (FS131-I2h)

None: the gate was not run (53 `sorry` remain in wave 2's modules), so no count moves.

## Stage 16 — SAVED (FS131-I2i, Opus): readback; the branch builds as given

**Readback.** Both brief quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754, § Stage 13) and
"**Closed since Stage 14** (statements untouched):" (this record, Stage 15, line 498) — both exact. Counts at `e8237b4b` by script (lines that are exactly
`sorry`): `Plane/Slack` 19, `Plane/CoverExamples` 34 — 53, as the brief says; no other wave-2 module holds one.

**May**: prove any child or leaf; add further children (each stated as a lemma before use, with its `scripts/Axioms.lean` record); move declarations within
a module; add imports (with `ARCHITECTURE.md`'s Imports cell); add supporting definitions (the fringe colouring of `exists_not_uniform_kept`); register wave 2's
vacuity carriers under FS131-T1's procedure, each with a control; docstrings (item 144 (d), FALC-HOSTS (iv)'s on `falconerFan_five_mem_P`). **May not**: change
any row statement, hypothesis or definition's meaning (the rulings 48, 56, 57, 63, 72, 86, 100, 134 are the authorised changes; item 134's Dyadic repair is
kept), nor any child statement fixed by K2c or K2d; no new `axiom` (`falconer_lemma2_nonempty` is the one declared import), no `native_decide`. A leaf that
cannot be proved as written goes to Keryx at once, and the others continue.

**Build as given** at `e8237b4b`: OK — all 1750 modules up to date, nothing built, 2 modules with warnings, 53 warnings, every one `declaration uses 'sorry'`
(`build/gate/build/20261004T153021Z-369432.log`).

## Stage 17 — SAVED (FS131-I2i): the modification, REM's second and third clauses, `exists_tight`'s three children; Slack 19 → 12

(Stage 16 moved here from above I2h's theorem list, where it was first inserted, so the stages read in order.)

**Closed** (statements untouched; children stated before use, each with its `scripts/Axioms.lean` record in block "FS131-I2i"):
- `CPColouring.exists_modification` — scales `h_m` from `exists_unif` at `2^{−m}`, `ct f x` the eventual value of `f (gridPoint h_m x)` (else
  colour `0`; `k = 0` is vacuous), fibres measurable through `measurable_to_countable'`, the modification a.s. at each `x` by
  `ae_eventually_notMem` (Borel–Cantelli, `∑ 2^{−m} < ∞`).
- `CPColouring.ae_unitPairsNull_of_modification` — the set `{(f, x, θ) : ct f x = ct f (x + e θ)}` has `law ⊗ volume ⊗ arcLength`-measure `0`
  (each slice in `f` null by `c.proper` and the modification at `x` and `x + e θ`), so almost every slice in `(x, θ)` is null.
- `CPColouring.tendsto_not_kept` — new child `CPColouring.law_ge_ball_ne_le` (Markov at one radius on `lintegral_ball_ne`); not kept at
  `ρ ∈ {ε/2, 2ε}` puts the disagreement at `η` of the ball (`ofReal (1 − η) + ofReal η = 1`); at `η ≥ 1` every point is kept.
  **So `chiM0_le_chiCP` and FS106-REM's second clause are sorry-free.**
- `exists_not_uniform_kept` — **a route other than the plan's fringe colouring** (§ 17.1; "the implementer may take either"): the
  *stripe colouring* `stripeCol n` (new definitions `stripeIdx`, `stripeCol`, spec example beside them): squares of side `1/2` coloured
  `(⌊2 re⌋ mod 4, ⌊2 im⌋ mod 4)` — any refinement of it is proper at every unit pair (`stripeCol_ne_of_dist_eq_one`: one colour mod `4` in both
  coordinates and distance `≤ 1` force one square, diameter `√2/2`) — refined by stripes `⌊re · (⌊im⌋₊ + 1)⌋ mod (n + 1)`, finer as rows
  rise. With `n = ⌈4/(1 − η)⌉₊`, every point of the unit square at height `Y = ε/2 + 8/((1 − η)ε) + 1` is non-kept at radius `ε/2`: its colour
  class meets the ball in at most `2ρ(2ρ/N + 2/M) ≤ 2(1 − η)ρ² < (1 − η)πρ²` (children `volume_floor_emod_le`, `volume_floor_mul_emod_le`,
  `volume_box_stripe_le`, `measurable_stripeIdx`, `measurable_stripeCol`), so `m` is the unit square's area. The fringe-to-fringe pairs the
  plan left open do not arise: properness comes from the coarse squares alone. **So FS106-REM is sorry-free (all three clauses).**
- `continuous_pairMass` — new child `tendsto_measure_inter_of_symmDiff`; Mathlib's `tendsto_measure_symmDiff_preimage_nhds_zero` on the
  translations `x ↦ x + r e θ` (a continuous family in the compact-open topology, `ContinuousMap.curry`), applied to `A ∩ B(0, R + |r₀| + 1)`,
  then dominated convergence in `θ` (`tendsto_lintegral_filter_of_dominated_convergence`, bound `vol B(0, R)`). New Mathlib import
  `Mathlib.MeasureTheory.Measure.ContinuousPreimage` in `Plane/Slack`.
- `ae_pairMass_eq_zero` — new children `arcLength_eq_volume_Ioo` (the angle read on `(−π, π)` about the antipode, `e (θ + π) = −e θ`) and
  `lintegral_Ioo_angle_le` (polar coordinates about `x`, `Complex.lintegral_comp_polarCoord_symm`: `∫_{(a,b)} r · |{θ : x − r e θ ∈ A}| dr ≤
  |A ∩ annulus|`); then `∫_{(a,b)} r · pairMass(r) dr ≤ (vol ⊗ vol)(pairs at distance in [a, b]) = 0` by Tonelli
  (`lintegral_lintegral_swap`), and `r > a > 0`.
- `AeColouring.exists_pos_not_iccPairNull` — a class of positive measure, a density point `x` of it, `r < 1/2` with density `> 1/2` in
  `B̄(x, r)`; then `vol(A₁)² ≤ vol(A₁) · π(r/4)²` if the pairs at distance in `[r/4, 1]` were null, against `vol(A₁) > πr²/2`.
  **So `exists_tight` (FS111-V0-RESCALE) and `bandNull_unitPairsNull` are sorry-free in body and children.**

**Iteration**: `lake env lean -DautoImplicit=false` on scratch files importing the built `Plane/Slack`, then on `Plane/Slack.lean` in place
(about 15 s); never evidence — the stage's build follows.

**Re-pricing** (the brief's ask, from the first two hard children): the modification with its a.e. properness about 12k tokens, the polar
change of variables (`ae_pairMass_eq_zero` with two children) about 25k, the stripe colouring about 20k. Near a third of the plan's table
again (K2c priced the modification at 25k, the fringe colouring at 70k).

**Still `sorry`** (lines exactly `sorry`; 46 = Slack 12 + CoverExamples 34): Slack — `exists_squareWin_dense`, `exists_tiled_kept`,
`eventually_le_muPer` (SUPK's lower bound); the compactness block `exists_weakStar_subseq`, `convForm_tendsto`, `exists_twoCircle_density`,
`integral_circleAvg_sq`, `unitForm_tendsto`, `exists_translates_small_hole`, `ae_sum_eq_one_of_weakStar`, `chiM0_le_iff_muZero_eq_one`,
`exists_bandNull_aeCover_of_mu_eq_one`. CoverExamples — unchanged from Stage 15's list.

## Stage 18 — SAVED (FS131-I2i): the owed docstrings; builds green; handoff — 46 `sorry` left

**Builds** (`./scripts/build.sh` under the slot, `MEMMAX=40G BATCH=4`): at `50a034b9` OK, 446 of 446 batches, 4 modules rebuilt, 46 warnings, every
one `declaration uses 'sorry'` (`build/gate/build/20261004T155659Z-500816.log`); after the docstring pass at `91a0a02a` OK, 11 modules rebuilt, 46
warnings, all `sorry` (`build/gate/build/20261004T161336Z-632794.log`); at `aeab5813` (the last Lean commit) OK, 4 modules rebuilt, 46 warnings, all `sorry` (`build/gate/build/20261004T162337Z-697910.log`).

**Axioms**, printed from the built library at `50a034b9` with `lake env lean data/fs131/i2/i2i-axioms.lean` (not `scripts/axioms.sh`, which fails
on the remaining `sorry` by design): `data/fs131/i2/i2i-axioms.txt`, 26 records. Every declaration of this session and every row it closes reads
the standard three. Negative control in the same file: `eventually_le_muPer` and `tendsto_mu` (SUPK's lower bound still open) print `sorryAx` —
the check can fire.

**Owed items done** (inventory item 144 (d)):
- **Docstrings for the wave-2 theorems that lacked them**: 86 (QA1 counted 84 at its commit), listed by the new tool `tools/fs131_i2_docs.py`
  (wave 2's ten modules and three foundation modules, as this brief's `touches:` names them, parsed by `fs131_qa1_decls.parse`, unedited),
  inserted by `data/fs131/i2/i2i_add_docstrings.py` from `data/fs131/i2/i2i-docs-before.txt`, each read against its statement. **The tool
  fails before and passes after**: exit 1 with 86 listed at `50a034b9`, exit 0 with 0 listed at `91a0a02a`; its `--self-test` plants an
  undocumented theorem beside a documented one and passes only if exactly the first is listed. (`tools/fs131_qa1_quality.py` was run once
  for its counts; it rewrote `data/fs131/qa1/quality.json`, another job's file, which was restored with `git checkout` and not committed.)
- **FALC-HOSTS (iv)'s docstring** (`falconerFan_five_mem_P`, `Arith/FalconerField.lean`): now says the frame proves only that a fan's `t − a`
  is a non-zero forced difference of `R` (in the forced set, which is then not `{0}`, so `P` by `hR88`), the fields and `P = R ∩ 𝔓⁴` entering
  only on instantiation — checked against the proof (`hforced`, `hba`).
- `exists_not_uniform_kept`'s docstring names the witness proved (the stripe colouring) beside the row's zigzag colouring.

**Not done, owed before the gate**: wave 2's vacuity carriers. A recommendation for whoever runs the gate (decided by reading, not run): **IN**
`CPColouring` — a type whose emptiness is a theorem (`IsEmpty (CPColouring 0)`, `IsEmpty (CPColouring 1)` in `Plane/CPColouring`; inhabited at
`9` by `nonempty_cpColouring_nine`), exactly `AeColouring`'s shape; **OUT, by T1's set-variable rule** `IsPartialColouring`, `IsAdmissible`,
`IsAeCover`, `IsMaximalCover`, `IsTiled`, `IsPeriodic`, `IsMaxIn` — predicates of a family or set variable, `GENERIC` at every site, unless a
theorem of the `¬ P` shape at a concrete instance exists (then IN, as wave 3 did for `IsRingArc`). Each IN carrier needs its control in
`scripts/vacuity-controls.lean` and the counts reconciled by a run — none of that was done here.

**Still `sorry`** (46): `Plane/Slack` 12 — `exists_squareWin_dense`, `exists_tiled_kept`, `eventually_le_muPer` (SUPK's lower bound: the window
average, the pixelation, the assembly; the three limits `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` wait only on these); the compactness block
`exists_weakStar_subseq`, `convForm_tendsto`, `exists_twoCircle_density`, `integral_circleAvg_sq`, `unitForm_tendsto`,
`exists_translates_small_hole`, `ae_sum_eq_one_of_weakStar`, and its assemblies `chiM0_le_iff_muZero_eq_one` (FS116-O1-YESLIM's last wait),
`exists_bandNull_aeCover_of_mu_eq_one`. `Plane/CoverExamples` 34 — R7 8, (G1) 4, HC/IRREG 22, as Stage 15 lists them.

**For the next implementer.** (1) Cheapest next: the (G1) children (route in Stage 15; `g′ = uv(v − u)/2` on a gap, `|g″| ≤ 1/2`, `g′ = 0` on `Z`;
for the lower parabola use monotonicity of `h(s) = g(s) − g(σ) − g′(σ)(s − σ) + (s − σ)²/4` on `[σ, 1/2]` and `[−1/2, σ]` —
`monotoneOn_of_deriv_nonneg` — instead of an integral Taylor bound), `exists_near_hcFace`, then `exists_squareWin_dense` (average over the
`ℓ`-grid squares meeting `B(0, R)`; `volume_squareWin` and the tiling squeeze of Stage 14 are in place). (2) The compactness block is the hard
remainder: weak-* compactness of `[0, 1]`-valued families and the Rajchman step. (3) Iteration: `lake env lean -DautoImplicit=false` on a
scratch file importing the built `Plane/Slack` (seconds), then on the module in place (about 15 s).

**Re-pricing, overall**: about 180k tokens of this session went to proofs for 7 leaves and 12 children (Slack 19 → 12) — the modification and its
a.e. properness 12k, the Markov assembly 6k, the stripe colouring 20k, translation continuity 10k, the polar change of variables 25k, the
density-point leaf 6k — and about 40k to the docstring pass, the tool and the builds.

## Theorems this phase proved (FS131-I2i, additions)

Axioms read from `data/fs131/i2/i2i-axioms.txt` (printed from the built library at `50a034b9`; the gate was not run). Each read against its
docstring, which carries the row.
- `HadwigerNelson.Plane.exists_not_uniform_kept` — `[propext, Classical.choice, Quot.sound]` — FS106-REM, third clause (ruling item 63's `η < 1`):
  some measurable colouring proper at every unit pair has, at every scale, a unit square of non-kept points (here: all of it).
- `HadwigerNelson.Plane.CPColouring.tendsto_not_kept` — the standard three — FS106-REM, second clause. **FS106-REM is sorry-free.**
- `HadwigerNelson.Plane.chiM0_le_chiCP` — the standard three — FS106-EQ's easy direction (`χ_m⁰ ≤ χ_CP`), now through proved children.
- `HadwigerNelson.Plane.AeColouring.exists_tight`, `exists_tight_iff_chiM0_le` — the standard three — FS111-V0-RESCALE. **Sorry-free.**
- Children and leaves, each the standard three: `CPColouring.exists_modification`, `CPColouring.ae_unitPairsNull_of_modification`,
  `CPColouring.law_ge_ball_ne_le`, `continuous_pairMass`, `tendsto_measure_inter_of_symmDiff`, `ae_pairMass_eq_zero`, `arcLength_eq_volume_Ioo`,
  `lintegral_Ioo_angle_le`, `AeColouring.exists_pos_not_iccPairNull`, `volume_floor_emod_le`, `volume_floor_mul_emod_le`, `measurable_stripeIdx`,
  `volume_box_stripe_le`, `measurable_stripeCol`, `stripeCol_ne_of_dist_eq_one`; and through them `pairMass_eq_zero_of_iccPairNull`,
  `bandNull_unitPairsNull`, `mu_le_muZero`.

## Drafts for the front page (FS131-I2i)

None: the gate was not run (46 `sorry` remain in wave 2's modules), so no count in `CLAUDE.md` § The gate or § Trust ledger moves, and no
ledger row is regraded.

## Stage 19 — SAVED (FS131-I2j, Opus): readback; the branch builds as given

**Readback.** Both brief quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754, § Stage 13)
and the "**Builds** …" line (this record, Stage 18, line 637) — both exact. The brief's closing amendment (item 134, `hi` carrying `ι ∉ Set.range
(algebraMap F L)` in five Dyadic declarations) is already applied, by FS131-I2g (Stage 10): all five carry it and their docstrings name item 134; nothing
to do. Counts at `f5e83938` by script (lines that are exactly `sorry`): `Plane/Slack` 12, `Plane/CoverExamples` 34 — 46, as the brief says; no other
wave-2 module holds one.

**May**: prove any child or leaf; add further children (each stated as a lemma before use, with its `scripts/Axioms.lean` record); move declarations
within a module; add imports (with `ARCHITECTURE.md`'s Imports cell); add supporting definitions; register wave 2's vacuity carriers under FS131-T1's
procedure, each with a control; run the gate and land on `main` by fast-forward. **May not**: change any row statement, hypothesis or definition's
meaning, nor any child statement fixed by K2c or K2d (the rulings 48, 56, 57, 63, 72, 86, 100, 134 are the authorised changes and are kept); no new
`axiom` (`falconer_lemma2_nonempty` is the one declared import), no `native_decide`. A leaf that cannot be proved as written goes to Keryx at once, and
the others continue.

**Build as given** at `f5e83938`: OK — all 1750 modules up to date, nothing built, 2 modules with warnings, 46 warnings, every one `declaration uses
'sorry'` (`build/gate/build/20261004T163524Z-786167.log`).

## Stage 20 — SAVED (FS131-I2j): SUPK's lower bound and five of the compactness block; Slack 12 → 4; the build is green; 38 `sorry` left

**Closed** (statements untouched; children stated before use, each with its `scripts/Axioms.lean` record in block "FS131-I2j"):
- `exists_squareWin_dense` — by contradiction: if every `ℓ`-grid square held less than `dℓ²` of `S`, the squares inside `B(0, R + 2ℓ)` cover
  `S ∩ B(0, R)` and are disjoint, so `|S ∩ B(0, R)| ≤ d · |B(0, R + 2ℓ)|` and `d̄(S) ≤ d`. (Moved below `tendsto_sq_add_div`, which it uses.)
- `exists_tiled_kept` — `T j` the preimage under the cell index `x ↦ (⌊re/h⌋, ⌊im/h⌋)` of the cells in the window meeting the
  `η/2`-kept set of class `j` and of no smaller class (`Nat.find`); cells have diameter `≤ h√2`, so `keptAt_of_dist_le`.
- `eventually_le_muPer` — the assembly of the docstring with one simplification: `µ_k^per(ε)` grows as `ε` shrinks (band-freeness is
  monotone), so one scale `ε₀` suffices. A family with density above `b > a > d`, a window of side `ℓ` with `a(ℓ+2)² ≤ ((a+b)/2)ℓ²`,
  almost every point of `S` kept at every `ε < 1/(n+1)` for some `n` (continuity from below of the outer measure on the increasing
  sets `G n`, no measurability needed), `ε₀ = 1/(2(n+1))`, pixels `1/M`, `keptAt_band` at `η = 1/20`, `periodize` at `ℓ + 2`.
  `keptAt_band` was moved up beside its two cases. **So `tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` (FS129-SR2-SUPK) are
  sorry-free.**
- `exists_twoCircle_density` — the Radon–Nikodym derivative of the law of `e φ − e θ` (absolutely continuous by
  `twoCircle_preimage_null` after `θ ↦ θ + π`). New imports in `Plane/Slack`: `Plane/FalconerReduction` (ARCHITECTURE.md's Imports cell
  updated), Mathlib's `RadonNikodym`, `WeakDual`, `InnerProductSpace.Dual`, `L2Space`, `SeparableMeasure`.
- `exists_translates_small_hole` — new child `exists_ball_diff_le_avg` (Tonelli and the first moment method: some disc of radius `r` about
  a point of `B(0, R − r)` misses `S` in at most `|B_r| · |B_R ∖ S| / |B_{R−r}|`); at `r = m + 1` and hole fraction `η/(4πr²)` the hole in
  `B(0, m + 1)` is at most `1/(m + 1)`.
- `ae_sum_eq_one_of_weakStar` — no a priori bound on `F` is needed: on each piece `B(0, n) ∩ {|F j| ≤ M ∀ j} ∩ {±(∑F − 1) > 0}` the
  indicator is a test function, `∫_B ∑F = |B|` by disjointness and the vanishing holes, so the piece is null.
- `convForm_tendsto` — new child `conv_props` (the convolution is a.e.-strongly measurable, bounded by `‖κ‖₁`, and `∫ u(y) κ(y − x) dy`);
  pointwise convergence by weak-*, dominated convergence on the ball for the diagonal term, weak-* against `1_B (F ⋆ κ)` for the cross term.
- `exists_weakStar_subseq` — new child `exists_L2_weak_subseq` (any finite `μ`: sequential Banach–Alaoglu, `WeakDual.isSeqCompact_closedBall`,
  on `Fin k → L²(μ)`, separable by `Lp.SecondCountableTopology`, the functional `ψ ↦ ∑ ⟪u_m j, ψ j⟫`, and Riesz per coordinate); then
  `μ = (1 + ‖x‖)^{-3} · Leb` (finite, `integrable_one_add_norm`), `0 ≤ F ≤ 1` by testing on `{F < 0}` and `{F > 1}`, and a volume-integrable
  `φ` handled by truncations `1_{‖x‖<N, |φ|≤N} φ`, which divided by the weight are bounded, with an `ε/3` argument.

**Build** at `830d8ac5`: `./scripts/build.sh` under the slot, OK — 446 of 446 batches, 4 modules rebuilt, 38 warnings, every one
`declaration uses 'sorry'` (`build/gate/build/20261004T170059Z-890668.log`).

**Re-pricing** (from the first two hard children, as the brief asks): `exists_squareWin_dense` about 6k tokens, `eventually_le_muPer` about
12k — a fifth of the plan's table (40k each). The compactness children: `exists_L2_weak_subseq` and the weighted step together about 25k
against the table's 50k; `convForm_tendsto` 6k against 30k.

**Still `sorry`** (38): `Plane/Slack` 4 — `integral_circleAvg_sq`, `unitForm_tendsto` (the Rajchman step), and the two assemblies
`chiM0_le_iff_muZero_eq_one`, `exists_bandNull_aeCover_of_mu_eq_one` (every child of the latter is now proved); `Plane/CoverExamples` 34.

## Stage 21 — SAVED (FS131-I2j): the two compactness assemblies; Slack 4 → 2; the build is green; handoff — 36 `sorry` left

**Closed** (statements untouched):
- `exists_bandNull_aeCover_of_mu_eq_one` — translates with vanishing holes (`P` = band-null classes, `bandNull_preimage_add`), the weak-*
  limit, `∑F = 1`; the band form of each translate is zero (a.e. slice of the band pair set is null), so by `convForm_tendsto` with the
  annulus kernel the band form of each `F j` is zero, and being non-negative, `F j · (F j ⋆ κ) = 0` a.e.; selection `c`, classes `c⁻¹{j}`:
  for a.e. `x` of class `j`, `F j x > 0`, so `F j(x + w) = 0` for a.e. `w` in the annulus, and the band slice lies in two null sets.
  `hε` is idle (no sign of `ε` is read). **So FS106-COMP (`forall_mu_six_lt_one_iff`) is sorry-free.**
- `chiM0_le_iff_muZero_eq_one` — ⟹: `exists_tight_iff_chiM0_le` gives an `AeColouring k`, then `one_le_muZero`, `muZero_le_one`. ⟸: the same
  compactness argument with the unit form (`unitForm_tendsto`) in place of the band form; new child `ae_arcLength_null` (a null set meets
  almost every unit circle in an arc-null set — Fubini on `(x, θ) ↦ x + e θ`), used three times because a planar null set can hold a whole
  circle. The assembly is complete; it waits only on `unitForm_tendsto`, so `chiM0_le_iff_periodic`, `seven_le_chiM0_iff` and YESLIM's
  `chiM0_le_of_fragments` still print `sorryAx` through it.

**Build** at `dcd0668e`: `./scripts/build.sh` under the slot, OK — 446 of 446 batches, 4 modules rebuilt, 36 warnings, every one `declaration uses
'sorry'` (`build/gate/build/20261004T171540Z-968137.log`). `tools/check_architecture.py`: PASS (Slack's new import).

**Axioms**, printed from the built library with `lake env lean data/fs131/i2/i2j-axioms.lean` (not `scripts/axioms.sh`, which fails on the
remaining `sorry` by design): `data/fs131/i2/i2j-axioms.txt`, 20 records. Every declaration this session closed reads the standard three.
Negative control in the same file: `integral_circleAvg_sq`, `unitForm_tendsto` and `chiM0_le_iff_muZero_eq_one` print `sorryAx` — the
check can fire.

**Not done, owed before the gate**: wave 2's vacuity carriers (Stage 18's recommendation stands: `CPColouring` IN, the family and set predicates
OUT by T1's set-variable rule; a control per IN carrier, counts reconciled by a run).

**Still `sorry`** (36): `Plane/Slack` 2 — `integral_circleAvg_sq` and `unitForm_tendsto` (the Rajchman step); `Plane/CoverExamples` 34 — R7 8
(`r7Col_mem_tile`, `r7Up_unitPair`, `r7Up_sep`, `r7Down_dist_ne_one`, `r7_boundary_lattice`, `r7_boundary_offLattice`, `r7_phi_pos_up`,
`r7_phi_pos_down`), (G1) 4 (`hcGap_eq_of_gap`, `differentiable_hcGap`, `hcGap_bounds`, `hcGap_lowerParabola`), HC/IRREG 22 (`hcUpTri_frame`
onward, § 17's list).

**For the next implementer.** (1) `integral_circleAvg_sq`: `(∫_θ f)² = ∫∫ f(θ) f(φ)` on `arcLength ⊗ arcLength` (`integral_prod_mul`), swap with
`x` (the integrand is bounded by `4 · 1_{B(0, R+1)}(x)`), translate `y = x + e θ` so the inner integral is `G(e φ − e θ)` with
`G(w) = ∫ h(y) h(y + w) dy`, push `arcLength ⊗ arcLength` forward to `ρ · Leb` (equal on measurable sets by `hρN`; `Measure.ext`), then
`integral_withDensity_eq_integral_smul` and one more Fubini (`|h(y) h(y+w) ρ(w)| ≤ 4 · 1_{B_R}(y) ρ(w)`). (2) `unitForm_tendsto`: truncate
`g_m`, `F` to `B(0, R + 1)` (still weak-* convergent); `‖T(g_m − F)‖²_{L²} = ⟨h_m, h_m ⋆ ρ⟩` by `integral_circleAvg_sq`, which tends to `0` by
`convForm_tendsto` (diagonal term) and weak-* (the two cross terms, the second after `w ↦ −w`, `ρ` even); then
`|U(g_m) − U(F)| ≤ |∫_{B_R} g_m (T g_m − T F)| + |∫_{B_R} (g_m − F) T F|`, Cauchy–Schwarz on the first, weak-* on the second. (3) The cheapest
CoverExamples leaves remain Stage 18's: the (G1) children and `exists_near_hcFace`. (4) Iteration as before: a scratch file importing the built
module (`lake env lean -DautoImplicit=false`, seconds), the proof pasted in, then the module in place (about 17 s). Beware `∫ x, A - ∫ x, B`:
the first binder swallows the subtraction; write `(∫ x, A) - ∫ x, B`.

**Re-pricing, overall**: about 320k tokens this session (harness count from the launch figure), of which about 230k to proofs: 10 leaves and
5 new children (Slack 12 → 2) — SUPK's three about 25k, the compactness children about 120k with `exists_weakStar_subseq` the largest
(about 35k with its child), the two assemblies about 50k — and about 40k to readback, three builds, the axiom print and this record.

## Theorems this phase proved (FS131-I2j, additions)

Axioms read from `data/fs131/i2/i2j-axioms.txt` (printed from the built library at `dcd0668e`; the gate was not run). Each read against its
docstring, which carries the row.
- `HadwigerNelson.Plane.tendsto_mu`, `tendsto_muTile`, `tendsto_muPer` — `[propext, Classical.choice, Quot.sound]` — FS129-SR2-SUPK (carrying
  FS106-SUP's first clause): `µ_k(ε)`, `µ_k^tile(ε)`, `µ_k^per(ε)` tend to `µ_k⁰` as `ε → 0⁺`. **Sorry-free.** With them
  `muZero_eq_one_iff_tendsto` (FS106-EQ (c) ⟺ (d)).
- `HadwigerNelson.Plane.exists_bandNull_aeCover_of_mu_eq_one` — the standard three — FS106-SUP's attainment clause at `µ_k(ε) = 1`: some partial
  `k`-colouring with band-null classes covers almost every point; and through it `forall_mu_six_lt_one_iff` (FS106-COMP), the standard three.
- Leaves and children, each the standard three: `exists_squareWin_dense`, `exists_tiled_kept`, `eventually_le_muPer`, `exists_twoCircle_density`,
  `exists_ball_diff_le_avg` (new), `exists_translates_small_hole`, `ae_sum_eq_one_of_weakStar`, `conv_props` (new), `convForm_tendsto`,
  `exists_L2_weak_subseq` (new), `exists_weakStar_subseq`, `ae_arcLength_null` (new).
- `HadwigerNelson.Plane.chiM0_le_iff_muZero_eq_one` — proved from its children, but prints `sorryAx` through `unitForm_tendsto`; not counted.

## Drafts for the front page (FS131-I2j)

None: the gate was not run (36 `sorry` remain in wave 2's modules), so no count in `CLAUDE.md` § The gate or § Trust ledger moves, and no ledger
row is regraded.

## Stage 22 — SAVED (FS131-I2k, Opus): readback; the branch builds as given

**Readback.** The brief's three quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754,
§ Stage 13), "**Still `sorry`** (36): …" (this record, Stage 21, line 783) and "**For the next implementer.** (1) `integral_circleAvg_sq`: …" (this
record, Stage 21, line 788) — all three exact. Counts at `9e32ab1d` by script (lines that are exactly `sorry`): `Plane/Slack` 2, `Plane/CoverExamples`
34 — 36, as the brief says; no other module holds one.

**May**: prove any child or leaf; add further children (each stated as a lemma before use, with its `scripts/Axioms.lean` record); move declarations
within a module; add imports (with `ARCHITECTURE.md`'s Imports cell); add supporting definitions; register wave 2's vacuity carriers under FS131-T1's
procedure, each with a control, and reconcile the counts; run the full gate and land on `main` by fast-forward after merging `main`. **May not**: change
any row statement, hypothesis or definition's meaning, nor any child statement fixed by K2c or K2d (the rulings 48, 56, 57, 63, 72, 86, 100, 134 are the
authorised changes and are kept, with the IMPORTED move and the docstrings); no new `axiom` (`falconer_lemma2_nonempty` is the one declared import), no
`native_decide`; never force-push. A leaf that cannot be proved as written goes to Keryx at once, and the others continue. The untracked
`build-i2*.log` files stay uncommitted.

**Build as given** at `9e32ab1d`: OK — all 1750 modules up to date, nothing built, 2 modules with warnings, 36 warnings, every one `declaration uses
'sorry'` (`build/gate/build/20261004T173350Z-1106823.log`; counted with `grep -c`).

## Stage 23 — SAVED (FS131-I2k): `Plane/Slack` sorry-free; CoverExamples 34 → 23; the build is green; handoff — 23 `sorry` left

**Closed** (statements untouched; new children stated before use, each with a docstring and a `scripts/Axioms.lean` record in block "FS131-I2k"):
- `integral_circleAvg_sq` — I2j's route: `(∫_θ h)² = ∫ h(x + e p.1) h(x + e p.2) d(arcLength ⊗ arcLength)` (`integral_prod_mul`), Fubini
  twice (both integrands bounded by `4 · 1_{B̄(0, R+1)}` resp. `4 · 1_{B̄(0, R)}` of the plane coordinate), the translation `y = x + e p.1`, and the
  law of `e p.2 − e p.1` written as `volume.withDensity (ofReal ∘ ρ')` (`Measure.ext` on `hρN`), `ρ'` a measurable version of `ρ`. **The statement
  does not assume `ρ ≥ 0`**; the proof derives `ρ ≥ 0` a.e. from `hρN` itself (at `N = univ` and `N = {ρ' ≥ 0}`: `ofReal (∫ ρ') = (2π)² =
  ofReal (∫_{ρ' ≥ 0} ρ')`, so `∫_{ρ' < 0} ρ' = 0`).
- `unitForm_tendsto` (the Rajchman step) — `F` clamped to `G = max 0 (min F 1)` (a.e. equal; `T F = T G` a.e. by `ae_arcLength_null`, **moved up**
  from below `chiM0_le_chiCP`, a move), `h_m = 1_{B(0, R+1)}(g_m − G)`; `‖T h_m‖²_{L²} = ∫ h_m (h_m ⋆ ρ)` by `integral_circleAvg_sq` with
  `exists_twoCircle_density`'s `ρ`, which tends to `0` by dominated convergence on `B(0, R+1)` (`(h_m ⋆ ρ)(y) → 0` pointwise by weak-*, against
  `1_{B(0,R+1)} ρ(· − y)`; bound `‖ρ‖₁`) — no cross terms and no symmetry of `ρ` needed; then `∫_{B_R} |T h_m| → 0` by `|v| ≤ v²/(2δ) + δ/2` (no
  Cauchy–Schwarz), and the second term `∫_{B_R} (g_m − G) T G → 0` by weak-* against `1_{B_R} T G`. **So `Plane/Slack` is sorry-free**, and with
  it `chiM0_le_iff_muZero_eq_one` (FS106-EQ (a) ⟺ (c)), `chiM0_le_iff_periodic`, `seven_le_chiM0_iff` and YESLIM's `chiM0_le_of_fragments` read
  the standard three.
- **(G1)**: `hcGap_eq_of_gap` (`IsGreatest.csSup_eq`, `IsLeast.csInf_eq`; `hZc` idle, marked `have _ := hZc`), `differentiable_hcGap`,
  `hcGap_bounds`, `hcGap_lowerParabola`, with six new children: `hcGap_exists_gap` (every point of `[−1/2, 1/2] ∖ Z` lies in a gap: `IsClosed.csSup_mem`),
  `hasDerivAt_hcGap_of_gap` (`g′ = (s − a)(b − s)(a + b − 2s)/2`), `abs_hcGap_le_sq` (`|g(t)| ≤ (t − z)²/4` about `z ∈ Z`),
  `hasDerivAt_hcGap_of_mem` (`g′ = 0` on `Z`, through `isLittleO_pow_id`), `abs_deriv_hcGap_le` (`|g′(t)| ≤ |t − z|/2`), `abs_deriv_hcGap_sub_le`
  (`g′` is `1/2`-Lipschitz: across a point of `Z` the two bounds add; on one gap `g′(s) − g′(σ) = (s − σ) f / 2` with `−w²/2 ≤ f ≤ w²`, by
  `nlinarith`). The lower parabola is the monotonicity route of Stage 18 (`monotoneOn_of_deriv_nonneg`, `antitoneOn_of_deriv_nonpos`). **So
  `g1Bounds_hcGap` and HC's hypothesis model `hcZ0_spec` are sorry-free.**
- `exists_near_hcFace` — `tri_cover` at scale `L√3` and rotation `e(π/6)`.
- `hcUpTri_frame` — the frame map is affine (`haff`), so the frame conditions cut a convex set; the three vertices land on `e(π/3)/√3`,
  `e(π)/√3 = −1/√3`, `e(−π/3)/√3` in every one of the three frames (angles reduced by `e_add_two_pi`); `convexHull_min`.
- `frontier_essSupport_pos` (IRREG (3)) — almost every point of `A′ ∖ F` is a support point of `A′` in `K` off `F` (`volume_diff_essSupport`), and
  such a point is not interior to the support: an open neighbourhood off `F` inside the support lies in `K` (a ball off `K` meets `A′ ∖ F` in a null
  set), against `interior K = ∅`.
- `r7Col_mem_tile` — lattice coordinates `z = a + bω` (proved inline), cell `(⌊a⌋, ⌊b⌋)`, distances `√(triQ (u − p) (v − q))`; the first test puts `z`
  in `U(m, n)` (the other two vertices are always within `1` in the cell), the second in `U(m + 1, n)` (`triQ(u − 1, v − 1) = triQ(u − 2, v) − 1 + u − v`),
  the third in `U(m, n + 1)`, else `D(m, n)` with `u + v > 1` and `z = (1 − v)(λ + 1) + (1 − u)(λ + ω) + (u + v − 1)(λ + 1 + ω)` (`Convex.sum_mem`).
- **Assemblies** (bodies sorry-free; each still prints `sorryAx` through its children): `hc_band_components` (from `hcBand_component_iff`:
  `connectedComponentIn` equality ⟺ a preconnected subset holding both; `interior Z = ∅` by `Measure.interior_eq_empty_of_null`), `hc_isRegularMUA`
  (unit-avoidance gives null unit pairs; MUA by `isMUA_iff_ae_phi_pos` and `hc_ae_phi_pos`; support by `essSupport_of_isOpen`, `closure_interior_hcSet`;
  `|HC ∖ int HC| = |∂HC| = 0`; shadow identity by `subset_compl_unitShadow_closure` and `hc_exclusion`), `hc_irreg` (as `hc_isRegularMUA` for the first
  five clauses; `¬ IsMUA` from `hc_free_pos`; for a MUA completion `A′`: a.e. point of `A′` has `φ_A ≤ φ_{A′} = 0` (`ae_arcLength_null` on `A ∖ A′`,
  `unitPairsNull_iff_ae_phi_eq_zero`), so `A′ ∖ HC` lies a.e. in the free set, hence in `K`; it has positive measure, else `A′ =ᵐ A` and `A` would be
  MUA; then `frontier_essSupport_pos` with `F = HC`).

**Builds** (`./scripts/build.sh` under the slot, `MEMMAX=40G BATCH=4`): at `e74a5e98` OK, but **not evidence for any commit** — CoverExamples was
edited in the worktree while that build ran, so the final batch rebuilt it a second time (64 warning lines from two versions;
`build/gate/build/20261004T173908Z-1124421.log`); a slip of this session, recorded so nobody reads that log as a state. At `0ad70eba` OK, 2 modules
rebuilt, 48 warning lines, 24 distinct, every one `declaration uses 'sorry'` (each is printed twice: in its batch and replayed by the final `Proofs`
batch) (`build/gate/build/20261004T180054Z-1245235.log`). At `925a8bd5` (the last Lean commit) OK, 2 modules rebuilt,
46 warning lines, 23 distinct, every one `declaration uses 'sorry'` (`build/gate/build/20261004T181256Z-1328058.log`); counted with `grep`.

**Axioms**, printed from the built library at `925a8bd5` with `lake env lean data/fs131/i2/i2k-axioms.lean` (not `scripts/axioms.sh`, which fails on
the remaining `sorry` by design): `data/fs131/i2/i2k-axioms.txt`, 26 records, 22 reading the standard three. Negative controls in the same file:
`hc_isRegularMUA`, `hc_irreg`, `hc_band_components` and `r7_aeColouring` print `sorryAx` — the check can fire (`r7_aeColouring` still waits on three
R7 children).

**Iteration**: `lake env lean -DautoImplicit=false` on scratch files importing the built module, under `scripts/slot.py --mem 5 --cpus 2` (peak RSS
measured at 3.3 GB, mostly mapped `.olean`s), then the module in place (about 50 s); never evidence — the builds above are.

**Re-pricing** (from the first two hard children, as the brief asks): `integral_circleAvg_sq` about 12k tokens and `unitForm_tendsto` about 20k (I2j
had no price for either in the table; the compactness children ran at a half to a fifth of K2c's). CoverExamples against K2d's table: the (G1) block
about 25k (table 120k), `hcUpTri_frame` 10k (20k), `r7Col_mem_tile` 10k (35k), `frontier_essSupport_pos` 5k (30k), `exists_near_hcFace` 3k (25k),
the three assemblies 12k (75k) — a quarter of the table again.

**Not done, owed before the gate**: wave 2's vacuity carriers. A survey by reading (not run), for whoever runs the gate: **IN** `CPColouring`
(`IsEmpty (CPColouring 0)`, `IsEmpty (CPColouring 1)` in `Plane/CPColouring` — **as `instance`s, not theorems**: check that the scan's evidence
collector sees instances before relying on them, or add theorem forms; inhabited at `9` by `nonempty_cpColouring_nine`). **OUT** by T1's set-variable
rule (predicates of a family, set or function variable, `GENERIC` at every site, no `¬ P` theorem at a concrete instance found by grep):
`IsPartialColouring`, `IsAdmissible`, `IsAeCover`, `IsMaximalCover`, `IsTiled`, `IsPeriodic`, `IsMaxIn`, `IsSelection`, `AeLE`, `BandNull`, `BandFree`,
`IccPairNull`, `KeptAt`, `IsRegularMUA`, `Saturated`, `SaturatedPos`, `IsLowerGraphOf`, `CurvatureLeOne`, `SemiconcaveWith`, `G1Bounds`,
`WeakStarTendsto`, `CPColouring.RotationInvariant`, `AeColouring.HasSlack`/`Tight`; but **`Tight` and `SemiconcaveWith` have concrete-instance
facts** (`sq9_tight_saturated`, `exists_r7`'s `Tight` are positive; `not_semiconcaveWith_one_lowerArc` is a `¬ P` at a concrete instance) — the last
is a candidate IN under T1's refutation clause; decide it with the scan's output in hand. `Row130M1`, `Voronov11` are closed propositions (no binder),
outside the scan's per-binder question.

**Still `sorry`** (23, all in `Plane/CoverExamples`): R7 7 — `r7Up_unitPair`, `r7Up_sep`, `r7Down_dist_ne_one`, `r7_boundary_lattice`,
`r7_boundary_offLattice`, `r7_phi_pos_up`, `r7_phi_pos_down`; HC/IRREG 16 — `hcUp_slivers`, `hcBandTop_bounds`, `lt_hcBandTop_iff`,
`continuousOn_hcBandTop`, `isClosed_hcSet`, `closure_interior_hcSet`, `volume_frontier_hcSet`, `hc_band_dist_lt_one`, `hc_unitAvoiding`,
`hc_sausage_cover`, `hc_lemmaNL`, `hc_exclusion`, `hc_ae_phi_pos`, `hcBand_component_iff`, `hc_free_pos`, `hc_free_subset_nowhereDense`.

**For the next implementer.** (1) Nearest the root: the three R7 children `r7Up_unitPair`, `r7Up_sep`, `r7Down_dist_ne_one` close
`r7_aeColouring` (FS111-M-R7's a.e.-properness); `r7Col_mem_tile`'s `hD`/`hin`/`hout` pattern (distance to `tri (m + p) (n + q)` as
`√(triQ (u − p) (v − q))`, with `P = m + p` as an equation argument so the casts never need rewriting) is reusable there. (2) HC: `hcUpTri_frame`'s
`haff` (frame affine) and `hgood` (a vertex is in the frame set iff its angle's cosine and sine are bounded) carry over to `hcUp_slivers` and the
block table. (3) Traps met this session: the unused-variable linter fires on an unused theorem hypothesis (a warning the build counts) — use
`have _ := h -- idle: …`; `HasDerivAt.pow` here elaborates to the Pi-power form with mismatched module instances — build `(t − a)²(b − t)²` as a product
of `HasDerivAt.mul`s; `(z / ↑r).re = z.re / r` is `Complex.div_ofReal_re`; a set built inside `≤ᵐ[volume]` needs `( … : Set ℂ)`. (4) **Never splice
into a module while a build of the worktree runs** — the final batch rebuilds it and the log mixes two versions.

## Theorems this phase proved (FS131-I2k, additions)

Axioms read from `data/fs131/i2/i2k-axioms.txt` (printed from the built library at `925a8bd5`; the gate was not run). Each read against its docstring,
which carries the row.
- `HadwigerNelson.Plane.unitForm_tendsto` — `[propext, Classical.choice, Quot.sound]` — the Rajchman step (QB § 2.3): the unit form is weak-* continuous
  on `[0, 1]`-valued families. With it, each the standard three: `chiM0_le_iff_muZero_eq_one` (FS106-EQ (a) ⟺ (c): `χ_m⁰ ≤ k ⟺ µ_k⁰ = 1`),
  `chiM0_le_iff_periodic`, `seven_le_chiM0_iff` (`7 ≤ χ_m⁰ ⟺ sup_ε µ₆(ε) < 1`, row 131), and FS116-O1-YESLIM's `chiM0_le_of_fragments`.
- `HadwigerNelson.Plane.integral_circleAvg_sq` — the standard three — `T*T` has the integrable kernel `ρ` (Fubini).
- `HadwigerNelson.Plane.g1Bounds_hcGap` — the standard three — (G1) holds for § 1.6's gap function on every closed `Z ⊆ [−1/2, 1/2]` holding `±1/2`;
  and through it `hcZ0_spec` (the model of FS111-M3-HC's hypotheses). Leaves: `hcGap_eq_of_gap`, `differentiable_hcGap`, `hcGap_bounds`,
  `hcGap_lowerParabola`; children (new): `hcGap_exists_gap`, `hasDerivAt_hcGap_of_gap`, `abs_hcGap_le_sq`, `hasDerivAt_hcGap_of_mem`,
  `abs_deriv_hcGap_le`, `abs_deriv_hcGap_sub_le` — each the standard three.
- `HadwigerNelson.Plane.frontier_essSupport_pos` — the standard three — FS111-M3-IRREG (3) in general form.
- `HadwigerNelson.Plane.exists_near_hcFace`, `hcUpTri_frame` — the standard three — HC's covering radius and the up triangle in its edge frames.
- `HadwigerNelson.Plane.r7Col_mem_tile` — the standard three — every point lies in an R7 tile of its colour (a child of FS111-M-R7).
- `hc_isRegularMUA`, `hc_irreg`, `hc_band_components` — assembled; print `sorryAx` through their children; not counted.

## Drafts for the front page (FS131-I2k)

None: the gate was not run (23 `sorry` remain in `Plane/CoverExamples`), so no count in `CLAUDE.md` § The gate or § Trust ledger moves, and no ledger
row is regraded.

## Stage 24 — SAVED (FS131-I2l, Opus): readback; the branch builds as given

**Readback.** The brief's four quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754,
§ Stage 13), "**Still `sorry`** (23, all in `Plane/CoverExamples`): …" (this record, Stage 23, line 910), "**For the next implementer.** (1) Nearest
the root: …" (line 915) and "**Not done, owed before the gate**: wave 2's vacuity carriers. …" (line 899) — all four exact. Counts at `1cc25e27` by
script (lines that are exactly `sorry`): `Plane/CoverExamples` 23; no other module holds one.

**May**: prove any child or leaf; add further children (each stated as a lemma before use, with its `scripts/Axioms.lean` record); move declarations
within a module; add imports (with `ARCHITECTURE.md`'s Imports cell); add supporting definitions and lemmas (in the wave-2 modules, the wave's foundation
or the shared foundation under `Plane/`); register wave 2's vacuity carriers under FS131-T1's procedure, each with a control, and reconcile the counts;
run the full gate and land on `main` by fast-forward after merging `main` (with `tools/fs131_qa1_dupes.py`). **May not**: change any row statement,
hypothesis or definition's meaning, nor any child statement fixed by K2c or K2d (the authorised rulings, the IMPORTED move, the docstrings and the Dyadic
`hi` change are kept); no new `axiom`, no `native_decide`; never force-push; never edit a file while a build of it runs. A leaf that cannot be proved as
written goes to Keryx at once, and the others continue. The untracked `build-i2*.log` files stay uncommitted.

**Build as given** at `1cc25e27`: OK — all 1750 modules up to date, nothing built, 1 module with warnings, 23 warnings, every one `declaration uses
'sorry'`, 23 distinct (`build/gate/build/20261004T182453Z-1418891.log`; counted with `grep -c`).

## Stage 25 — SAVED (FS131-I2l): R7 closed — all seven R7 children proved; CoverExamples 23 → 16; handoff — 16 `sorry` left, all HC/IRREG

**Closed** (statements untouched; new children stated before use, each with a docstring and a `scripts/Axioms.lean` record in block "FS131-I2l";
two new definitions, `r7UpOpen` and `r7DownOpen`, each with a spec `example` that fails if it drifts):
- `r7Up_unitPair` — through a new general lemma, `reuleaux_unitPair`: if `x, y` are within `1` of the three vertices of a unit equilateral triangle
  and `|x − y| = 1`, then `x` is at distance `1` from a vertex. Proof: in the frame `w = conj(y − x)(· − x)` every vertex lies in the lens
  `|w| ≤ 1`, `|w − 1| ≤ 1`; if no vertex is on `|w| = 1`, two of the three lie on one closed side of the axis (pigeonhole on the signs of `Im w`)
  and are then less than `1` apart (`reuleaux_aux`, a two-case `nlinarith`) — against the side length `1`.
- `r7Up_sep` — offsets `2(P, Q)` with `triQ(P, Q) ≥ 3` are too far (`|λ' − λ| ≥ 2√3 > 3`, three unit steps); the six offsets of length `2` each give a
  vertex `W` of `U(m, n)` and a vertex `W''` of `U(m', n')` at distance exactly `3`, so `dist x W = 1` (`dist_eq_one_of_three`).
- `r7Down_dist_ne_one` — in lattice coordinates (`dist_eq_triQ`, `triCoord_mem_downTri`, `r7Down_coords`): the same tile (barycentric identity
  `2 − 2 triQ = 2Σαα′ + Σα(1 − α) + Σα′(1 − α′)` forces `x` to a vertex, which the tests exclude); the six offsets of length `√3` (the two tiles lie in
  opposite 60° cones at a shared lattice point `V₀`, one of the six bulge tests puts the far point outside the unit circle about `V₀`, and `triQ` is
  monotone on the cone, `triQ_le_add`); offsets with `triQ ≥ 5` too far (centroid bound `triQ(u − 2/3, v − 2/3) ≤ 1/3`, `sqrt_triQ_add_le`).
- `r7_boundary_offLattice` — `r7_local`: near a non-lattice point at most two colours occur (lattice-coordinate case analysis: the lines `a ∈ ℤ`,
  `b ∈ ℤ` carry one colour; in an open cell the three tests, with the circles' tangencies `triQ_tangent`), and when two do the point is on a unit
  circle about a lattice point that is a vertex of the up tile and a cusp of a down tile of the other colour; supports by
  `r7Up_vertex_mem_essSupport` (the open up triangle reaches its vertices) and `r7_down_mem_essSupport` (every down colour has a cusp at every
  lattice point; `mem_closure_r7DownOpen` reaches each cusp along its horn with explicit points `(1 − s, 2s)`, `(2s, 1 − s)`, `(1 − s, 1 − s)`).
- `r7_boundary_lattice` — the up colour of `λ₀ + 1 + ω` is absent from `B(λ₀, 7/10)` (`r7_far_vertex`: such a tile has a vertex at distance `≥ √3`),
  so it is not in the essential closure (`not_mem_essClosure_of_eventually`); every pair from the other six colours is carried by one of
  `λ₀ + 1`, `λ₀ + ω`, `λ₀ − 1 + ω`. (The planner's route through "cusps have density 0" is not needed: the down colours are in the support at
  every neighbour, so the six-colour pairs all close.)
- `r7_phi_pos_up`, `r7_phi_pos_down` — off the null union of unit circles about lattice points, a point `p` outside class `j` lies in a tile of its
  own colour (`r7Col_mem_tile`); from that tile a witness tile of colour `j` is named with one vertex/cusp strictly inside and one strictly outside the
  unit circle about `p` (twelve cases; "within 1" from the tile, "beyond 1" from an antipodal lattice point or a bulge test, equality excluded by the
  null set); the witness tile's open part is star-shaped about its centroid (`r7UpOpen_star`, `r7DownOpen_star` via `triQ_star`), so the
  intermediate value theorem puts a point of it on the unit circle (`phi_pos_of_star`) and an open arc follows (`phi_pos_of_mem_open`).
- **So R7 is sorry-free**: `r7_aeColouring`, `r7Cls_saturated`, `exists_r7` (FS111-M-R7's first three clauses) and `r7Cls_isMaximalCover`.

**Builds**: at `58c3cbc9` (the three tile lemmas) OK, 2 modules rebuilt, 40 warning lines = 20 distinct, every one `declaration uses 'sorry'`
(`build/gate/build/20261004T185334Z-1534006.log`). At `635088cf` (R7 closed) OK, 2 modules rebuilt, 32 warning lines = 16 distinct, every one `declaration uses 'sorry'`, no other warning (`build/gate/build/20261004T192247Z-1722400.log`; counted with `grep`). **Axioms**, printed from that built library with `lake env lean data/fs131/i2/i2l-axioms.lean` (not `scripts/axioms.sh`, which fails on the remaining `sorry` by design): `data/fs131/i2/i2l-axioms.txt`, 61 records — 58 read exactly the standard three (the 7 leaves, the 6 R7 declarations they close, 45 new children); the 3 negative controls `hc_isRegularMUA`, `hc_irreg`, `hc_band_components` print `sorryAx` (the check can fire).
Iteration: `lake env lean -DautoImplicit=false` on scratch files (not evidence), then the module in place.

**Re-pricing** (from the first two hard children, as the brief asks): `r7Up_unitPair` with `reuleaux_unitPair` about 12k tokens, `r7Up_sep` 5k,
`r7Down_dist_ne_one` 12k (K2d's table: 40k each); the four boundary/`φ` leaves together about 45k (table 160k) — a quarter of the table, as I2k found.

**Still `sorry`** (16, all in `Plane/CoverExamples`, HC/IRREG): `hcUp_slivers`, `hcBandTop_bounds`, `lt_hcBandTop_iff`, `continuousOn_hcBandTop`,
`isClosed_hcSet`, `closure_interior_hcSet`, `volume_frontier_hcSet`, `hc_band_dist_lt_one`, `hc_unitAvoiding`, `hc_sausage_cover`, `hc_lemmaNL`,
`hc_exclusion`, `hc_ae_phi_pos`, `hcBand_component_iff`, `hc_free_pos`, `hc_free_subset_nowhereDense`.

**For the next implementer.** (1) The lattice-coordinate kit now in the module is reusable for HC's face lattice: `dist_add_mul`, `dist_eq_triQ`,
`triCoord_combo`, `sqrt_triQ_add_le`, `triQ_le_add`; and the `φ` kit is general: `phi_pos_of_mem_open` (a point at distance `1` inside an open part),
`phi_pos_of_star` (a star-shaped open part with closure points inside and outside the unit circle), `not_mem_essClosure_of_eventually`,
`mem_essSupport_of_mem_closure` — `hc_ae_phi_pos`'s "`E°_B` ⟹ `T₁(z)` meets `int B`" is `phi_pos_of_star` with `O = int B` (blocks are convex or
star-shaped). (2) HC's derivation is `plans/FS111-M3-finiteness.md` §§ 1.6, 2.2–2.4 and 4.2 (read this session); K2d's table § 17 is the plan.
(3) Traps met: `isOpen_lt (by fun_prop) (by fun_prop)` on a set-builder `def` sticks on a metavariable type — give the continuous functions as
`have` terms first; `norm_num at h1 h2` after `interval_cases` errors "no goals" when the first hypothesis closes the goal — use
`(try norm_num at h1) <;> (try norm_num at h2)`; a tactic block inside parentheses must not break a `simp only [...]` list across lines followed
by `; omega` (parse error) — state the membership as a disjunction that `omega` proves.

## Theorems this phase proved (FS131-I2l, additions)

Axioms read from `data/fs131/i2/i2l-axioms.txt` (printed from the built library at `635088cf`; the gate was not run). Each read against its
docstring, which carries the row.
- `HadwigerNelson.Plane.r7_aeColouring` — `[propext, Classical.choice, Quot.sound]` — FS111-M-R7, a.e.-properness: R7 is a measurable
  seven-colouring with null monochromatic unit pairs. With it `HadwigerNelson.Plane.exists_r7` (FS111-M-R7's first three clauses: a.e.-proper,
  tight, saturated) and `HadwigerNelson.Plane.r7Cls_isMaximalCover` (FS111-VMW-R7-MAX's last clause: R7's classes are a maximal admissible cover),
  each the standard three; also `r7Cls_saturated`, `r7_boundary`, `r7_unitPair_mem_sphere`.
- The seven leaves, each the standard three: `r7Up_unitPair`, `r7Up_sep`, `r7Down_dist_ne_one`, `r7_boundary_lattice`, `r7_boundary_offLattice`,
  `r7_phi_pos_up`, `r7_phi_pos_down`.
- `HadwigerNelson.Plane.reuleaux_unitPair` — the standard three — Reuleaux's diameter in the form R7 reads it (two points within `1` of the three
  vertices of a unit equilateral triangle, `1` apart, put the first on a unit circle about a vertex).
- `HadwigerNelson.Plane.phi_pos_of_star`, `phi_pos_of_mem_open` — the standard three — `φ_A > 0` from a star-shaped open part of `A` reaching both
  sides of the unit circle about `p`.
- 41 further children (lattice coordinates, the open tiles and their closures, supports, the local analysis `r7_local`, the witnesses), each the
  standard three; listed in `scripts/Axioms.lean` block "FS131-I2l" and `data/fs131/i2/i2l-axioms.txt`.

## Drafts for the front page (FS131-I2l)

None: the gate was not run (16 `sorry` remain in `Plane/CoverExamples`, all HC/IRREG), so no count in `CLAUDE.md` § The gate or § Trust ledger
moves, and no ledger row is regraded.

## Stage 26 — SAVED (FS131-I2m, Opus): readback; the branch builds as given

**Readback.** The brief's four quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754,
§ Stage 13), "**Still `sorry`** (16, all in `Plane/CoverExamples`, HC/IRREG): …" (this record, Stage 25, line 1001), "**For the next
implementer.** (1) The lattice-coordinate kit now in the module is reusable for HC's face lattice: …" (line 1005) and "**Not done, owed before
the gate**: wave 2's vacuity carriers. …" (Stage 23, line 899) — all four exact. Count at `63ffebec` by script (lines that are exactly `sorry`):
`Plane/CoverExamples` 16; no other module holds one.

**May**: prove any child or leaf; add further children (each stated as a lemma before use, with its `scripts/Axioms.lean` record); move
declarations within a module; add imports (with `ARCHITECTURE.md`'s Imports cell); add supporting definitions and lemmas (in the wave-2 modules,
the wave's foundation or the shared foundation under `Plane/`); register wave 2's vacuity carriers under FS131-T1's procedure, each with a control,
and reconcile the counts; run the full gate and land on `main` by fast-forward after merging `main` (with `tools/fs131_qa1_dupes.py`). **May
not**: change any row statement, hypothesis or definition's meaning, nor any child statement fixed by K2c or K2d (the authorised rulings, the
IMPORTED move, the docstrings and the Dyadic `hi` change are kept); no new `axiom`, no `native_decide`; never force-push; never edit a file while
a build of it runs. A leaf that cannot be proved as written goes to Keryx at once, and the others continue. The untracked `build-i2*.log` files
stay uncommitted (this job writes its build stdout to its scratch directory, not the worktree root).

**Build as given** at `63ffebec`: OK — all 1750 modules up to date, nothing built, 1 module with warnings, 16 warning lines, 16 distinct, every one
`declaration uses 'sorry'` (`build/gate/build/20261004T194002Z-1862699.log`; counted with `grep -c`).

## Stage 27 — SAVED (FS131-I2m): eleven HC leaves closed; CoverExamples 16 → 5; handoff — 5 `sorry` left, the exclusion and IRREG

**Closed** (statements untouched; every new child stated before use with a docstring and a `scripts/Axioms.lean` record in block "FS131-I2m";
seven new definitions — `hcBlock`, `hcCA`, `hcCB`, `hcCentre`, `hcFlank`, `hcDn`, `hcUpO` — each with a spec `example` that fails if it drifts;
one new import, `Mathlib.Analysis.Convex.Measure`, for `Convex.addHaar_frontier`):
- **Frames in Cartesian form** (`hcFrame_explicit`: `t_j`, `s_j` as linear forms in `z − C`), the inverse `hcFrame_hcFrameST`, distance in a frame,
  `hcFrame_other` (two frames at one centroid differ by `±2π/3`), and **`mem_hcUpTri_iff`: the up triangle is `{∀ k, t_k ≥ 2}`** (barycentric
  weights `(2/√3)(t_k − 2)`).
- `hcUp_slivers` (G2) — in the other frame `t − 2 = (√3u − τ)/2` and `s = ε(α − 1/2)`, `α = u/2 + (√3/2)τ ≤ u`, so `g(s) ≤ α²/4 ≤ u/4 ≤ t − 2`.
- `hcBandTop_bounds`, `lt_hcBandTop_iff`, `continuousOn_hcBandTop` (G3) — `U` compact and nonempty, every point of `U` at `t ≥ 2 + g(s)` in every
  frame (`hcUp_frame`); `d_U` antitone and, by compactness, strictly decreasing below `t = 2`; `ℓ(s)` attained; continuity from the strict decrease
  and `d_U` 1-Lipschitz in `s`.
- `hc_band_dist_lt_one` (§ 2.3's `1 − σ + σ²`), `hc_lemmaNL` — **simpler than the derivation's**: the exterior disc is placed at the *vertical*
  foot `(s, 2 + g s)` (no nearest-point argument), `p = z + ν`; the lower-parabola bound gives `|w − c|² − R² ≥ (3/8)X² + Y² ≥ 0` for `w ∈ U`
  (any `R ≤ 2` works), and `|p − c|² = (R − 1)² − η/(2N) + η² < (R − 1)²` for `0 < η < 1/(2N)`; the boundary case `t = 2 + g s` by a limit.
- **The block kit**: `hcBlock` (six per cell), `hcSet_eq_iUnion`; centres `(L/2)·tri(A, B)` with integer `A`, `B` (`hcCentre_eq`); every block within
  `3/5` of its centre; `int_triQ_lt_three` + `hcC_near` (centres with `A² + AB + B² < 3` are one block or a flanking pair — 36 kind pairs by `omega`);
  `mem_hcDownTri_iff` (the down triangle is the point reflection of its cell's up triangle) and `hcFrame_dn` (`t = 2 − t′`, `s = −s′` across an
  edge), so the flanked down triangle lies in `t ≤ 0`; **`hcBlock_sep`: distinct blocks are `≥ 1` apart** (far centres: `√3 + 1/2 − 6/5 > 1`);
  **`hcBlock_dist_le_one`: every block has diameter `≤ 1`** (`convexHull_diam`); `hcBlock_locallyFinite`.
- `hc_unitAvoiding` — **without the interior characterization**: for `x ∈ int HC`, `y ∈ HC`, `|x − y| = 1`, the points `x ± εv` lie in `HC`;
  separation puts `x + εv`, `x`, `y`, `x − εv` in one block, whose diameter `1` is beaten by `|x − εv − y| = 1 + ε`.
- `isClosed_hcSet` (`LocallyFinite.isClosed_iUnion`), `closure_interior_hcSet` (the down triangle has the ball of radius `1/4` about its centroid;
  `U = cl U°` by shrinking toward the centroid, `|g′| ≤ 1/8`; bands open; discs), `volume_frontier_hcSet` (frontier of a locally finite union in
  the union of frontiers; convex blocks by `Convex.addHaar_frontier`; `U` and the bands through **`volume_graph_eq_zero`**: a graph `φ = f ∘ ψ`
  of a continuous `f`, with `φ` shifted by `c` and `ψ` fixed under translation by `c·v`, is null — its translates by `v/(k+1)` are disjoint and lie in one
  bounded set; no Fubini, no measure-preserving frame map).
- `hcBand_component_iff` — `(⟸)` the image of `[s₁, s₂] × (0, 1)` under `(s, μ) ↦ (s, 1 + μ(ℓ(s) − 1))`; `(⟹)` the line `s = c`, `c ∈ Z`, misses
  the band and separates.

**Builds** (`./scripts/build.sh` under the slot, `MEMMAX=40G BATCH=4`): at `6b581a65` (six leaves) OK, 2 modules rebuilt, 20 warning lines = 10
distinct, every one `declaration uses 'sorry'` (`build/gate/build/20261004T201140Z-2017320.log`). At `b968c1bb` (eleven leaves) OK, 2 modules rebuilt, 10 warning lines = 5 distinct, every one `declaration uses 'sorry'`, no other warning (`build/gate/build/20261004T203429Z-2166305.log`; counted with `grep`).
**Axioms**, printed from the built library at `b968c1bb` with `lake env lean data/fs131/i2/i2m-axioms.lean` (not `scripts/axioms.sh`, which fails on
the remaining `sorry` by design): `data/fs131/i2/i2m-axioms.txt`, 89 records — 82 read exactly the standard three (the 11 leaves, `hc_band_components` which they close, 70 new children); the 7 negative controls (the 5 open leaves, `hc_isRegularMUA`, `hc_irreg`) print `sorryAx` (the check can fire).
Iteration: `lake env lean -DautoImplicit=false` on scratch files importing the built module (each compile 3–10 s), then the module in place (about
100 s). The module was never edited while a build ran.

**Re-pricing** (from the first two hard children, as the brief asks): `hcUp_slivers` with the frame kit about 20k tokens, the (G3) trio about 15k
(K2d's table: 35k + 35k + 30k + 35k); the block kit with `hc_unitAvoiding` about 35k (table 80k), the three regularity leaves about 30k (table 95k) —
a quarter to a third of the table, as I2k and I2l found.

**Still `sorry`** (5, all in `Plane/CoverExamples`): `hc_sausage_cover` (B1), `hc_exclusion` (B2), `hc_ae_phi_pos`, `hc_free_pos` (IRREG (1)),
`hc_free_subset_nowhereDense` (IRREG (2)). The assemblies `hc_isRegularMUA` and `hc_irreg` wait on them; `hc_band_components` is now sorry-free.

**Not done, owed before the gate**: wave 2's vacuity carriers (Stage 23's survey stands; I2k's two points — the `IsEmpty (CPColouring 0/1)`
instances and `not_semiconcaveWith_one_lowerArc` — still open), the full gate, the landing.

**For the next implementer — the routes for the five, worked out but not written.**
1. **`hc_free_subset_nowhereDense` needs only `hc_exclusion` and `closure_interior_hcSet`** (no case analysis): take
   `K = {z | ∀ θ, z + e θ ∉ int HC} ∩ (int HC)ᶜ` — closed (`int HC` open), and `E ⊆ K` (an open 2π-periodic set of angles of arc length `0` is
   empty). If `B(z, δ) ⊆ K`: `z ∉ int HC`, so `hc_exclusion` gives `y ∈ HC` with `|z − y| = 1`; `HC = cl int HC` gives `y′ ∈ int HC` with
   `|y′ − y| < δ`; then `z′ = y′ − (y′ − z)/|y′ − z|` is in `B(z, δ)` and `z′ + (unit) = y′ ∈ int HC` — against `z′ ∈ K`.
2. **`hc_exclusion` and `hc_ae_phi_pos` through one strict-exclusion lemma** SE: `∀ z ∉ int HC, z ∈ N₀ ∨ z ∈ K_Z ∨ ∃ y ∈ int HC, dist z y = 1`,
   with `N₀` a countable union of null sets that does not depend on `|Z|` — spheres `|z − O| ∈ {1/2, 3/2}`; `{d_T = 1}` and `{D_T = 1}` for the
   triangles (frontiers of the convex sets `{d_T ≤ 1}` and `⋂ B̄(v, 1)`); the lines `t ∈ {0, 1, 2}` and `s = ±1/2` of every edge frame
   (`volume_hcFrame_graph`, `volume_hcFrame_line`); the circles `T₁(e±)`; `{d_σ = 1}`; the graphs of `ℓ`; `∂U` — and
   `K_Z = ⋃_e {z : ∃ c ∈ Z, |z − frame(c, 1)| = 1}`, which lies in `unitShadow HC` (`σ_e ⊆ HC`) and is null when `Z` is null. Then
   `hc_ae_phi_pos` is SE with `phi_pos_of_mem_open` off `N₀ ∪ K_Z`; and `hc_exclusion` follows on `HCᶜ ∖ N₀` (SE, or `K_Z ⊆` shadow), which is
   dense in `(int HC)ᶜ = cl HCᶜ` because `N₀` is null, and `unitShadow HC` is closed. SE's cases, through B1: (a) a face — `1/2 < |z − O| < 3/2`,
   the radial point; (b) a down triangle — `D_T > 1` gives IVT on `int T`; `D_T < 1` puts `z` across one incident side (the down triangle is
   `{∀ incident frame, t ≤ 0}` by `mem_hcDownTri_iff` + `hcFrame_dn`), at `0 < t < 1 − √3/2`, `|s| < 1/2`, off the closed vesica (`vesica_apex`),
   so case (d); (c) an up triangle — outside it, in the frame where `t < 2`: `|s| ≤ 1/2` gives `d_T = 2 − t` and, by `t` against `ℓ(s)`, the band
   (impossible), the graph of `ℓ` (`N₀`) or `d_U < 1` (`infDist_hcUp_strictAnti`); `|s| > 1/2` makes the end vertex the nearest point (`v ∈ U`); with
   a vertex beyond `1`, IVT on `U°` (needs `U°` preconnected: star-shaped about `C` by `hcFrame_shrink`); inside `T ∖ int HC`: the sliver at `t > 2`
   by `hc_lemmaNL`, `t = 2` a line, else `∂U`; `D_T < 1` is the flat bulge (case (d) mirrored); (d) a segment — `d_σ < 1 < D_σ` gives the secant
   point `(s′, 1)` (IVT on `σ`), `s′ ∈ Z` → `K_Z`, `|s′| = 1/2` → `T₁(e±)`, else the circle point `(s_z + σ√(1 − (1 + κ − t_z)²), 1 + κ)` lies in
   the band for small `κ > 0` (continuity of `ℓ` at `s′`); `D_σ < 1` (open vesica): `t < 1` the down triangle (strict (C0)), `t = 1` a line,
   `1 < t < ℓ` impossible, `t = ℓ` the graph, `t > ℓ` IVT on `U°` with the up apex beyond `1` (mirrored (C0)).
3. **`hc_sausage_cover`** is B1 as the derivation states it (fundamental triangle `O C M`, H3's quadrilateral `Q ⊆ B̄(v, 1) ∪ B̄(e, 1)`), carried
   around each face: `exists_near_hcFace`, then the sector of `arg(z − O)` within `30°` of `kπ/3`; the six triangles around `O` are
   `up(m, n)`, `down(m, n)`, … by the face-lattice relations (`hcFace_eq_tri`, `hcDownC_dn`).
4. **`hc_free_pos`** (the hardest): in the frame of edge `(0, 0, 0)`, `E ⊇ {(s, t) : 0 < t < t₀, s ± r(t) ∈ Z, |s − p| < h}`, `r(t) = √(2t − t²)`,
   `p` a Lebesgue density point of `Z` in `(−1/2, 1/2)` (Mathlib's density theorem); each such circle misses `int HC` — `T_down` (`D < 1`), `U`
   (top `1 + t < 2`), the band (the arc passes above it: `t·d/r > d²/4 ≥ g ≥ ℓ − 1`), and every other block, which needs the exact distances to the
   four adjacent bands and the two adjacent faces (the lattice table gives only `triQ ≥ 3` there, not enough: use the adjacent sides' frames);
   positivity by Fubini in frame coordinates (frame `(0, 0, 0)` is `(s, t) ↦ C + (c₀ − t) − i s`, measure-preserving through
   `Complex.volume_preserving_equiv_real_prod`) and `|(Z + r) ∩ (Z − r) ∩ I| ≥ |I| − 2|I′ ∖ Z| > 0` near the density point.
5. **Traps met this session**: a `set` variable hides its definition from `linarith` (use `obtain ⟨u, hu⟩ : ∃ u, u = …`); `(-(1/(k+1 : ℝ)) : ℂ)`
   elaborates with the coercion at the leaves — write `((c k : ℝ) : ℂ)`; `Convex.addHaar_frontier` needs `Mathlib.Analysis.Convex.Measure` (now
   imported) and takes `μ` implicitly; `rw` cannot see inside `z ∈ {z | …}` (use `show`); `Pairwise (Disjoint on H)` needs `open Function`
   (write `Function.onFun`); `Set.Finite.isCompact_convexHull` needs `(𝕜 := ℝ)`; after `fin_cases j` the coercion `↑↑⟨0, _⟩` no longer matches
   a lemma stated at `((0 : Fin 3) : ℕ)` — rewrite the edge direction to `![…] j` before `fin_cases`. The splice helper this session used (move proved
   chunks from a scratch file into the module by name, renaming primed copies) is `data/fs131/i2/i2m-splice.py`.

## Theorems this phase proved (FS131-I2m, additions)

Axioms read from `data/fs131/i2/i2m-axioms.txt` (printed from the built library at `b968c1bb`; the gate was not run). Each read against its
docstring, which carries the row.
- `HadwigerNelson.Plane.hcUp_slivers` — `[propext, Classical.choice, Quot.sound]` — FS111-M3-HC (G2): the graph `t = 2 + g(s)` of each side lies in `U`.
- `HadwigerNelson.Plane.hcBandTop_bounds`, `lt_hcBandTop_iff`, `continuousOn_hcBandTop` — the standard three — (G3): `1 ≤ ℓ ≤ 1 + g`, `ℓ = 1`
  exactly on `Z`; below `t = 2` the band is `{d_U > 1}`; `ℓ` continuous.
- `HadwigerNelson.Plane.hc_band_dist_lt_one` — the standard three — § 2.3: a band has diameter `< 1`.
- `HadwigerNelson.Plane.hc_lemmaNL` — the standard three — Lemma NL: a sliver point is at distance `1` from the closed band.
- `HadwigerNelson.Plane.hc_unitAvoiding` — the standard three — § 2.3: no two points of `int HC` are at distance `1`.
- `HadwigerNelson.Plane.isClosed_hcSet`, `closure_interior_hcSet`, `volume_frontier_hcSet` — the standard three — HC is closed, the closure of its
  interior, with null frontier.
- `HadwigerNelson.Plane.hcBand_component_iff` — the standard three — (G3): the band's components are its gaps; with it the assembly
  `hc_band_components` (FS111-M3-HC's second clause) is sorry-free and reads the standard three.
- `HadwigerNelson.Plane.hcBlock_sep`, `hcBlock_dist_le_one` — the standard three — distinct blocks of HC are `≥ 1` apart; each has diameter `≤ 1`.
- `HadwigerNelson.Plane.mem_hcUpTri_iff`, `mem_hcDownTri_iff`, `hcFrame_dn` — the standard three — the triangles as half-plane intersections and
  reflections.
- `HadwigerNelson.Plane.volume_graph_eq_zero` — the standard three — a graph `φ = f ∘ ψ` in translation-sheared coordinates is null.
- 60 further children (frames, `U`'s compactness and monotonicity, the lattice centres, local finiteness, the regularity pieces), each the standard
  three; listed in `scripts/Axioms.lean` block "FS131-I2m" and `data/fs131/i2/i2m-axioms.txt`.

## Drafts for the front page (FS131-I2m)

None: the gate was not run (5 `sorry` remain in `Plane/CoverExamples`), so no count in `CLAUDE.md` § The gate or § Trust ledger moves, and no ledger
row is regraded.

## Stage 28 — SAVED (FS131-I2n, Opus): readback; the branch builds as given

**Readback.** The brief's four quotations checked by `grep -F` against their sources: the "May" line (`plans/FS131-w2-kernel-plan.md` line 754,
§ Stage 13), "**Still `sorry`** (5, all in `Plane/CoverExamples`): …" (this record, Stage 27, line 1098), "**For the next implementer — the routes for
the five, worked out but not written.**" (line 1104) and "**Not done, owed before the gate**: wave 2's vacuity carriers. …" (Stage 23, line 899) — all
four exact. Count at `57c26bd0` by script (lines that are exactly `sorry`): `Plane/CoverExamples` 5; no other module holds one.

**May**: prove any child or leaf; add further children (each stated as a lemma before use, with its `scripts/Axioms.lean` record); move declarations
within a module; add imports (with `ARCHITECTURE.md`'s Imports cell); add supporting definitions and lemmas (in the wave-2 modules, the wave's foundation
or the shared foundation under `Plane/`); register wave 2's vacuity carriers under FS131-T1's procedure, each with a control, and reconcile the counts;
run the full gate and land on `main` by fast-forward after merging `main` (with `tools/fs131_qa1_dupes.py`). **May not**: change any row statement,
hypothesis or definition's meaning, nor any child statement fixed by K2c or K2d (the authorised rulings, the IMPORTED move, the docstrings and the Dyadic
`hi` change are kept); no new `axiom`, no `native_decide`; never force-push; never edit a file while a build of it runs. A leaf that cannot be proved as
written goes to Keryx at once, and the others continue. The untracked `build-i2*.log` files stay uncommitted (this job writes its build stdout to its
scratch directory).

**Build as given** at `57c26bd0`: OK — all 1750 modules up to date, nothing built, 1 module with warnings, 5 warning lines, 5 distinct, every one
`declaration uses 'sorry'` (`build/gate/build/20261004T204820Z-2280708.log`; counted with `grep -c`).

## Stage 29 — SAVED (FS131-I2n): the five HC/IRREG leaves closed; wave 2 is sorry-free

**Closed** (statements untouched — `hc_lemmaNL`'s statement too, only its proof was split; every new child stated before use
with a docstring and a `scripts/Axioms.lean` record in block "FS131-I2n"; four new definitions, `hcCorner`, `hcNframe`, `hcN0`,
`hcKZ`, each with a spec `example`):
- `hc_sausage_cover` (B1) — **not by rotations**: `exists_near_hcFace` gives a face `O` within `L`; `hc_face_cone` reads `z` in
  one of the six edge frames about `O` (`hcFrame_face`: the six frames `(m, n, 1)`, `(m − 1, n + 1, 0)`, `(m − 1, n + 1, 2)`,
  `(m − 1, n, 1)`, `(m − 1, n, 0)`, `(m, n, 2)` in Cartesian form about `O`; the cone `√3|t − 1| ≤ √3 + 1/2 − εs` by the signs
  of three linear forms); in the cone (`hc_cone_cover`), with `u = √3 + 1/2 − εs`, `v = t − 1`: `u² + v² ≤ 9/4` is the disc;
  otherwise `u > 3√3/4`, and `|v| ≤ 1` gives the slab `|s| ≤ 1/2` or a near corner `(ε/2, τ)` strictly within `1`
  (`(√3 − u)² < 3/16` plus `(t − τ)² ≤ 1/4`, split at `v = ±1/2` — simpler than H3's quadrilateral), `|v| > 1` puts `z` in the up
  or down triangle (`mem_hcUpTri_iff_frame`, `mem_hcDownTri_iff_frame`: each triangle in ONE frame, `t ≥ 2, √3|s| ≤ 2 + √3/2 − t`
  and `t ≤ 0, √3|s| ≤ √3/2 + t`; the bound `√3u + |v| ≤ 2L < 4 + √3` by Cauchy–Schwarz). The refined cover `hc_cover` records
  `εs > 1/2` at the corners, which makes the far corner of the same side `> 1` away for free.
- `hc_exclusion` (B2) and `hc_ae_phi_pos` — **I2m's route, one strict exclusion** `hc_strict_exclusion`: every `z ∉ int HC` lies in
  `N₀` (`hcN0`: face circles of radius `1/2`, `3/2`; per frame the lines `t ∈ {0, 1, 2}`, `s = ±1/2`, the graph of `ℓ`, the unit
  circles about eight frame corners, the frontiers of both triangles and of `U`), or in `K_Z` (`hcKZ`: unit circles about `Z × {1}`
  of every segment), or at distance `1` from a point of `int HC`. Cases from `hc_cover`: face (`hc_se_face`, the radial point),
  up triangle (`hc_se_up`: `∂U`, a side line, or a sliver — `hc_lemmaNL_lt`), down triangle (its frontier), slab (`hc_se_slab`:
  below `σ` the down triangle by the IVT on its interior or `σ` via (C0) `hc_c0_end`; above `σ` the band, the graph of `ℓ`, or `U°`
  by the IVT, or `σ` via (C0)'s mirror `hc_c0_end'`), corners (`hc_se_corner`); `σ` itself is `hc_seg_exclusion` (the crossing
  `s′` by the IVT along `σ`; `s′ ∈ Z` is `K_Z`; else the band holds a box over `s′` by continuity of `ℓ`, and the transversal crossing
  puts points of the box's closure strictly inside and outside the circle). The IVT tool is `exists_dist_eq_one_of_star` (the body of
  `phi_pos_of_star`, concluding the point); `U°` is star-shaped about `C` (`hcUpO_star`). `volume_hcN0` (independent of `|Z|`),
  `volume_hcKZ` (a smooth image of `{w : w.re ∈ Z}`, `addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero`),
  `hcKZ_subset` (`σ ⊆ cl Λ`: `hcFrame_mem_closure_band`), `isClosed_unitShadow` (`F + S¹`). Then `hc_exclusion`: points of
  `HCᶜ ∖ N₀` are in the closed shadow and are dense in `(int HC)ᶜ`; `hc_ae_phi_pos`: off `N₀ ∪ K_Z`, `phi_pos_of_mem_open`.
- `hc_free_subset_nowhereDense` (IRREG (2)) — I2m's route verbatim: `K = {z : ∀θ, z + e θ ∉ int HC} ∩ (int HC)ᶜ`, closed, and
  empty-interior by `hc_exclusion` + `closure_interior_hcSet`.
- `hc_free_pos` (IRREG (1)) — in the frame of edge `(0, 0, 0)` (`w₀ = 1`, so the frame is a reflection, a swap and a
  translation: `measurePreserving_hcFrame000`): `hc_free_near` (within `1` of `z = (s, t)`, `|s| < 1/2`, `0 < t < 1/20`, HC is only
  the down triangle `(1, −1)` and the closed band — far blocks by the centre lattice, `√3 + 1/2 − 0.61 − 3/5 > 1`; the triangle's
  other two bands by `hcFrame_dn000_others`, `t = −t₀/2 − √3/4 ± (√3/2)s₀ < 0` in their frames), the down triangle inside the
  unit circle (`hcDownTri_one_neg_one`: its vertices are `(0, −√3/2)`, `(∓1/2, 0)`), `hc_free_arc` (the arc above the band: the only
  closed-band points on the circle are `(s ± ρ, 1)`, by `t' − t ≥ 1 − tu/ρ` and `g ≤ (ρ − u)²/4`), so the circle meets `int HC`
  in a countable set of directions (`countable_setOf_add_e_eq`) and `φ = 0` (`hc_free_mem`); positivity: a density point `p` of
  `Z` in `(−1/2, 1/2)` (`exists_density_point`, Besicovitch's density theorem), each slice `{s : |s − p| < h, s ∓ ρ ∈ Z}` of
  measure `≥ h` (`hc_free_slice`), Fubini (`hc_free_param_pos`), and the frame's measure preservation.
- Five module docstrings that still said their children were `sorry`ed (`Arith/PlaceHom`, `Plane/Cover`, `Arith/Dyadic`,
  `Plane/FalconerReduction`, `Plane/Slack`) corrected to say they are proved — prose only.

**Builds** (`./scripts/build.sh` under the slot, `MEMMAX=40G BATCH=4`): at `f84dce14` (B1, IRREG (2)) OK, 2 modules rebuilt, 6
warning lines = 3 distinct, every one `declaration uses 'sorry'` (`build/gate/build/20261004T211414Z-2441453.log`); at `49e217da`
(B2, a.e.) OK, 2 modules rebuilt, 2 warning lines = 1 distinct, `declaration uses 'sorry'` (`build/gate/build/20261004T213918Z-2607493.log`);
counted with `grep`. At `d078808a` (the last leaf): pending at this save. The module was never edited while a build ran; scratch
files were compiled with `lake env lean -DautoImplicit=false` (never evidence), under `scripts/slot.py --mem 6`.

**Re-pricing** (from the first two hard children, as the brief asks): B1 with its cone machinery about 40k tokens (K2d's table
40k + 35k); the strict exclusion with both assemblies about 100k (table 40k + 3 × 25k + 40k + 2 × 25k = 205k); IRREG (1) about 70k
(table 70k); IRREG (2) about 5k (table 40k). About half the table overall, the hardest leaf at the table.

**Still `sorry`**: none — `grep` finds no `sorry` term in `Proofs/` (the word survives in prose only, "sorry-free").

## Stage 30 — SAVED (FS131-I2n): wave 2's vacuity carriers; the gate on `fs131-w2` before the merge

**The build of the last leaf** (`d078808a`): OK — 446 of 446 batches, 12 modules rebuilt (the five modules whose docstrings changed and their
dependents), **0 warnings** (`grep -c "warning:"` = 0) — `build/gate/build/20261004T215748Z-2725003.log`, copy `data/fs131/i2n/build-gate.log`. The
commits after it (`b0d18832`, `082f86c9`, `4679f115`) change `scripts/`, `tools/`, `data/`, `ARCHITECTURE.md` only, so that build is the Lean state
gated here. `grep -rnw sorry Proofs` finds the word in prose only.

**The carriers (FS131-T1's procedure, `scripts/Vacuity.lean`'s docstring, entry "Wave 2's carriers")**: **IN** `HadwigerNelson.Plane.CPColouring`
(a structure whose emptiness is a theorem — `IsEmpty (CPColouring 0)`, `IsEmpty (CPColouring 1)`, both `instance`s; the evidence collector reads
instances, as it reads `AeColouring`'s: `EVIDENCE EMPTY …instIsEmptyCPColouringOfNatNat(_1)` in the scan; inhabited at `9` by
`nonempty_cpColouring_nine`) and `HadwigerNelson.Plane.SemiconcaveWith` (refuted at a concrete instance by `not_semiconcaveWith_one_lowerArc`, read as
`EVIDENCE EMPTY`); **OUT** every other wave-2 predicate, each with its reason in the docstring (set/family/function/field variables, `GENERIC`
everywhere; `Tight`/`HasSlack` with positive facts only; number inequalities; `Row130M1` and `Voronov11`, closed propositions consumed as named
hypotheses, whose tracking would add undischargeable `UNKNOWN` sites). Controls 33–38 in `scripts/vacuity-controls.lean`, `expect` lines in
`scripts/vacuity.sh --self-test` (T1's step (3)).

**The gate** (every log read, not only its last line):
- **axioms** — "OK — 2450 clean, 11 axiom-free, 4 imported, 5 declared purchase(s)" over 2470 records; the four IMPORTED records
  (`falconer_reduction`, `le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem`) carry exactly `falconer_lemma2_nonempty`, the one
  declared import; library axioms other than native auxiliaries: 1, declared (`data/fs131/i2n/axioms-gate.log`; full
  `build/gate/axioms/20261004T221018Z-2806763.log`, copy `axioms-gate-full.log`). Every wave-2 row declaration reads the standard three but the two
  FALC-RED ones, which add the declared import (`tools/fs131_i2n_row_axioms.py`, 64 declarations, `data/fs131/i2n/row-axioms.txt`; its `--self-test`
  plants a `sorryAx` record and an unaudited name, both reported, and a faithful partner passes).
- **axioms self-test** — **red first**: 4 of 23 controls (`baseline`, `imported_declared`, `library_accounting`, `banner_dropped`), each traced to
  the library's state, not to the plants: `scripts/axioms-controls.txt` assumed a library with no declared import
  (`build/gate/axioms-self-test/20261004T221030Z-2808168.log`, copies `axioms-selftest.log`, `axioms-selftest-red-full.log`). Messaged; Keryx's
  ruling (inventory item 260): apply the four edits — the counts and the `old` digest texts set to the shipped state (4/1/1; 5/2/2 with the planted
  import), `library_accounting` drops the planted axiom's own `LIBRARY AXIOM` line, `banner_dropped` predicts the two consequences of a dropped
  IMPORTED banner on a non-empty section. **Green after**: "every planted fault fired, and every partner passed", 23 of 23
  (`build/gate/axioms-self-test/20261004T222158Z-2896287.log`, copies `axioms-selftest-green.log`, `axioms-selftest-green-full.log`).
- **vacuity self-test** — "every control fired, and the silent ones stayed silent", controls 1–38, the six new ones among them
  (`build/gate/vacuity-self-test/20261004T221942Z-2884278.log`, copy `vacuity-selftest.log`).
- **vacuity** — "vacuity: OK", `declarations=9261 refutations-skipped=64 sites=515`, `vacuous=0 stale=0 declared=3 witnessed=23 generic=487
  unknown=2` (the baseline's two), evidence 9 emptiness proofs and 48 witnesses (`data/fs131/i2n/vacuity-gate.log`; full
  `build/gate/vacuity/20261004T222352Z-2908756.log`, copy `vacuity-gate-full.log`). **Reconciled against this branch's recorded 8385 / 57 / 459 /
  21 / 433** (the counts recorded before wave 2's modules existed; `main`'s are reconciled at the landing): declarations +876 are wave 2's;
  refutations-skipped +7, wave 2's theorems concluding `False`; witnessed +2 — `sq9 :: AeColouring 9` and one more witnessed site of the backlog
  vocabulary; sites +56 = generic +54 + witnessed +2, the 19 `CPColouring k` sites (all `GENERIC`, `k` a variable) among them; `SemiconcaveWith`
  raises no site (it occurs only as a conclusion and in its refutation). vacuous, stale, declared, unknown unchanged.
- **architecture** — `tools/check_architecture.py` exit 0, "RESULT: PASS" (`data/fs131/i2n/arch.log`), after CoverExamples' row gained B1/B2's
  shape.
- **spec examples** — elaborated in the build: `hcCorner`'s, `hcN0`'s and `hcKZ`'s examples, and every earlier one.

**Negative controls, each watched red, each reverted** (`git diff -- Proofs ARCHITECTURE.md` empty of the plant after each):
- build — `theorem fs131_i2n_planted_build : (1 : ℕ) = 1 := by sorry` appended to `Plane/YesLimit` (imported by `Proofs` alone): "2 module(s)
  rebuilt, **1 module(s) with warnings**", naming `YesLimit.lean:220:8: declaration uses sorry`; `build.sh` exits 0 and prints "OK" — the gate's
  zero-warnings check is the count (`data/fs131/i2n/build-plant.log`). Reverted; the olean is restored by the post-merge build.
- architecture — `Plane/CoverExamples`' Imports cell without `Plane/Slack`: "FAIL imports of Plane/CoverExamples: stated-only [], real-only
  ['Plane/Slack']", exit 1 (`data/fs131/i2n/arch-plant.log`); reverted, exit 0.
- axioms — the self-test is the plant suite: its `sorry` control ("FAIL sorry CLEAN 't3c_sorry' carries sorryAx") and 22 others fired.
- vacuity — the self-test is the control suite; every control fired, the three new `VACUOUS` ones among them.

## Stage 31 — SAVED (FS131-I2n): `origin/main` merged; the gate re-run on the merge

**Correction to Stage 30's reconciliation**: the second new witnessed site is `finitePlane7QuotColoring :: (finitePlane 7).Coloring (Fin 4)`
(wave 2's `Instances/FalconerOrbit`), beside `sq9 :: AeColouring 9` — read by diffing the scan's `WITNESSED` rows.

**Merge.** `origin/main` (`7427f450`…: wave 3's `localSectors` (FS131-I3i) in `Plane/LocalStructure` and `Plane/RingGerm`, its 62 records, its
`Vacuity.lean` entry, the baseline header, briefs and plans) merged as `630beea1`. One conflict, in `scripts/Axioms.lean` (both sides appended a CLEAN
block above the PURCHASED banner): both kept, wave 2's first. `scripts/Vacuity.lean` merged by itself with both carrier entries. (A merge commit cannot
be a commit by path; it was committed whole after `git add` of the resolved file and the dupes log.) `tools/fs131_qa1_dupes.py` after the merge
(`data/fs131/i2n/dupes.log`): 6 names in two bodies' own files; the one involving wave 2 is `HadwigerNelson.Plane.framePt` (`Plane/Slack:2800`) against
wave 4's skeleton (`Plane/ValidMap/Basic:44`, bodies k4/w4) — not on `main`, so no collision at this landing; whichever of the two lands second renames.

**The gate on `630beea1`** (every log read):
- **build** — "OK — 446 of 446 batches, 6 module(s) rebuilt, 0 module(s) with warnings" (`grep -c warning:` = 0) — the merged wave-3 modules, their
  dependents, and `Plane/YesLimit` restored after the build control (`build/gate/build/20261004T223742Z-3020944.log`, copy `build-gate2.log`).
  No `sorry` term in `Proofs/`.
- **axioms** — "OK — 2512 clean, 11 axiom-free, 4 imported, 5 declared purchase(s)" over 2532 records; **reconciled**: 2450 + 62 = 2512 clean, the 62
  added rows being exactly I3i's records (the digest's `+` list); imported, purchases, axiom-free unchanged; the four IMPORTED records carry
  `falconer_lemma2_nonempty` only (`axioms-gate2.log`; full `build/gate/axioms/20261004T224728Z-3095228.log`, copy `axioms-gate2-full.log`).
  `tools/fs131_i2n_row_axioms.py` on it: 64 row declarations, identical to stage 30 (`row-axioms2.txt`).
- **axioms self-test** — 23 of 23, OK (`build/gate/axioms-self-test/20261004T224905Z-3098517.log`, `axioms-selftest2.log`).
- **vacuity** — "vacuity: OK", `declarations=9376 refutations-skipped=64 sites=516`, `vacuous=0 stale=0 declared=3 witnessed=23 generic=488
  unknown=2` (`vacuity-gate2.log`; full `build/gate/vacuity/20261004T224739Z-3095769.log`, copy `vacuity-gate2-full.log`). **Reconciled**: against
  stage 30's run, declarations +115 and sites/generic +1 (`ArcMap.Simple.coneAt_eq_angleIcc_sep :: F.Simple`) — exactly I3i's reconciliation; against
  `main`'s recorded 8500 / 57 / 460 / 21 / 434, declarations +876, refutations-skipped +7, witnessed +2 (`sq9`, `finitePlane7QuotColoring`),
  generic +54 (the 19 `CPColouring k` sites among them), sites +56 — wave 2's.
- **vacuity self-test** — 38 controls, OK (`build/gate/vacuity-self-test/20261004T225031Z-3104146.log`, `vacuity-selftest2.log`).
- **architecture** — exit 0, "RESULT: PASS" (`arch2.log`).

## Theorems this phase proved (FS131-I2n, additions)

Axioms read from `data/fs131/i2n/axioms-gate2-full.log` (`scripts/axioms.sh` on `630beea1`, the gate). Each read against its docstring, which carries
the row.
- `HadwigerNelson.Plane.hc_sausage_cover` — `[propext, Classical.choice, Quot.sound]` — FS111-M3 § 2.4's B1: every point is within `1` of a flat
  triangle or a segment, or within `3/2` of a face centre.
- `HadwigerNelson.Plane.hc_exclusion` — the standard three — B2: every point outside `int HC` is at distance `1` from HC.
- `HadwigerNelson.Plane.hc_ae_phi_pos` — the standard three — § 2.4: with `Z` null, almost every point off `int HC` has `φ > 0`.
- `HadwigerNelson.Plane.hc_free_pos` — the standard three — FS111-M3-IRREG (1): with `Z` of positive length, the free set has positive measure.
- `HadwigerNelson.Plane.hc_free_subset_nowhereDense` — the standard three — FS111-M3-IRREG (2): the free set lies in a closed nowhere dense set.
- With them, each the standard three and sorry-free for the first time: `hc_isRegularMUA` (FS111-M3-HC, first clause), `hc_irreg` (FS111-M3-IRREG),
  `not_forall_isRegularMUA` (MUA-REG-U false), `not_forall_fix_converse` (FS111-M3-FIXCONV).
- `HadwigerNelson.Plane.hc_strict_exclusion` — the standard three — the strict exclusion (every point off `int HC` in `N₀`, in `K_Z`, or at distance
  `1` from `int HC`); `hc_cover` (B1 refined), `hc_face_cone`, `hc_cone_cover`, `mem_hcUpTri_iff_frame`, `mem_hcDownTri_iff_frame`,
  `exists_dist_eq_one_of_star`, `hcUpO_star`, `volume_hcN0`, `volume_hcKZ`, `isClosed_unitShadow`, `hc_seg_exclusion`, `hc_lemmaNL_band`,
  `hc_lemmaNL_lt`, `hc_free_near`, `hc_free_arc`, `hc_free_mem`, `exists_density_point`, `measurePreserving_hcFrame000` — each the standard three;
  and 44 further children, each the standard three, listed in `scripts/Axioms.lean` block "FS131-I2n".

**Wave 2 in the kernel**: every one of its 28 rows' declarations (64, `data/fs131/i2n/row-axioms2.txt`) reads the standard three, but
`falconer_reduction` and `le_chiM_of_falconerFan` (FS129-SA1-FALC-RED), which rest also on `falconer_lemma2_nonempty`, `[Falconer1981]` Lemma 2 (i),
p. 185, the one declared import.

## Drafts for the front page (FS131-I2n)

From the gate on `630beea1` (if `main` moves with Lean before the landing, its records and declarations add to these numbers):
1. **`CLAUDE.md` § Trust ledger**, replacing "the current audit reads 1856 clean and 5 declared purchases, and 0 imported (and 11 axiom-free; 1,872
   records at the landing of `localSectors` (FS131-I3i), after wave 3's and FS131-T3's gate repair, 2026-10-04)" with "the current audit reads 2512
   clean and 5 declared purchases, and 4 imported (and 11 axiom-free; 2,532 records at wave 2's landing, FS131-I2n, 2026-10-04)". The imported count
   rises from 0: the four records resting on `falconer_lemma2_nonempty`.
2. **`CLAUDE.md` § The gate**, replacing "`declarations=8500 refutations-skipped=57 sites=460`, `vacuous=0 stale=0 declared=3 witnessed=21 generic=434
   unknown=2`" with "`declarations=9376 refutations-skipped=64 sites=516`, `vacuous=0 stale=0 declared=3 witnessed=23 generic=488 unknown=2`".
3. **`scripts/vacuity-baseline.txt`'s header**, replacing "#   declarations=8500  refutations-skipped=57  sites=460" and "#   vacuous=0 stale=0
   declared=3 witnessed=21 generic=434 unknown=2" with "#   declarations=9376  refutations-skipped=64  sites=516" and "#   vacuous=0 stale=0 declared=3
   witnessed=23 generic=488 unknown=2". The baseline's two entries are unchanged.
4. **`LEAN.md` § The gate**, replacing "`--self-test` plants twenty controls and watches each fire" with "`--self-test` plants thirty-eight controls and
   watches each fire" (32 before this job; `scripts/vacuity.sh`'s own banner still says "twenty planted defects").
5. **`CLAUDE.md` § Frontier, "What the kernel holds, beyond the interval"**, after "**FS-101's first slot** — `χ(ℚ(√47)²) ≤ 5`, and the main clause
   through five over named hypotheses (row 127);", insert: "**FS-131 wave 2, the measurable collapse's Lean side** — `χ(ℝ²) ≤ χ_m⁰(ℝ²)` with no MR
   (N-EASY, row 130), FS106-EQ's equivalences `χ_m⁰ ≤ k ⟺ µ_k⁰ = 1 ⟺` periodic slack near-colourings and `7 ≤ χ_m⁰ ⟺ sup_ε µ₆(ε) < 1`, with
   `χ_CP ≤ k` over FS-103's M1 named (row 131), fragments at every radius give `χ(ℝ²) ≤ k` (YESLIM, row 145), Falconer's reduction over one declared
   import (row 152), the maximal-cover toolkit — the fill, saturated maximal covers, Grundy's modification, the face lemma (rows 140, 143, 144) — and the
   example classes R7, SQ9, DISC7, the honeycomb class HC (a regular MUA set at every null `Z`, with one band component per gap) and the fat pinch
   whose every maximal completion is irregular (rows 140–141), with the place homomorphism, NOAFF-FIELDS and the dyadic `√3` (rows 151–152);".
6. **`LEDGER.md`** — no edit drafted here: rows are regraded at the milestone's filing (I3i's practice). The rows wave 2 now holds in the kernel, by
   their backlog tags (declarations in `data/fs131/i2n/row-axioms2.txt`): FS111-C-FILL, FS111-M-SATC, FS111-M2-COV, FS111-M2-FIX, FS111-M-COVER-SC
   (with the stated defect `not_forall_semiconcaveWith_one`), FS121-D3-GRUNDY, FS111-V0-RESCALE, FS129-SR2-SUPK, FS106-EQ (its (a) ⟺ (b) over the
   named hypothesis `Row130M1`, FS-103's M1), FS106-COMP (with `Voronov11`, `[Voronov2023]` Thm 1.1's form, as the equivalence's right side),
   FS106-REM, FS121-D4-FACE, FS121-V5-FACE-SHARP, FS129-OA1-NOPERLAW, FS129-SA1-FALC-RED (over `falconer_lemma2_nonempty`, `[Falconer1981]` Lemma 2 (i),
   the one import), FS116-O1-YESLIM, FS129-SA1-PLACE-HOM, FS129-SA1-NOAFF-FIELDS, FS129-SA1-FALC-RES, FS129-MA2-FALC-HOSTS (clauses (iii), (iv) over
   the named halves `hR78`, `hR88`, `hR88per` of rows 78 and 88), FS129-SA1-SQRT3-LOCAL, FS111-W-SQ9, FS111-M-R7, FS111-M2-DISC7, FS111-M3-BAND,
   FS111-M3-HC, FS111-M3-IRREG, FS111-M3-FIXCONV. All other axioms: the standard three.
7. **Proof Atlas** — grade changes for the rows above, [hand]/[tools]/[derived] → [kernel], at the filing.

## Stage 32 — SAVED (FS131-I2n): the landing

`origin/main` moved after stage 31 (`efe68c61`: FS131-QA3's stage 2, `plans/` only, no `Proofs/`, `scripts/`, `tools/` change); merged as `40f4b4ef`
(its merge message is git's default, without the attribution lines; not amended). The gate re-run there: build "OK — all 1750 modules already up to
date, nothing built, 0 module(s) with warnings" (`build/gate/build/20261004T225320Z-3120352.log`, `data/fs131/i2n/build-gate3.out`); axioms "OK —
2512 clean, 11 axiom-free, 4 imported, 5 declared purchase(s)" (`build/gate/axioms/20261004T225322Z-3123760.log`, `axioms-gate3.log`); vacuity "OK",
counts as stage 31 (`build/gate/vacuity/20261004T225327Z-3129569.log`, `vacuity-gate3.log`); `check_architecture` exit 0 (`arch3.log`). Stage 31's
drafts stand as written. Correction to stage 31's theorem list: "44 further children" is **39** — block "FS131-I2n" holds 58 records, 19 of them
named in the list.

Then `origin/main` fast-forwarded to this branch by `git push origin HEAD:main` (the commit carrying this stage and the report). The main tree's local
`main` was not touched. The untracked `build-i2*.log` files at the worktree's root stay uncommitted.

**Addendum at the push.** `origin/main` moved once more (`6b8fce2b`: inventory items 268–269 and two briefs, `plans/` and `data/fs131/briefs/` only);
merged as `54d408c6`, no file under `Proofs/`, `scripts/`, `tools/`, `ARCHITECTURE.md`, `Proofs.lean` or the toolchain changed (`git diff --stat`, 0 lines),
and the build reads "all 1750 modules already up to date, nothing built, 0 module(s) with warnings" (`build/gate/build/20261004T225532Z-3162433.log`,
`data/fs131/i2n/build-gate4.out`), so the axiom and vacuity receipts of `40f4b4ef` describe this commit's library and audit files unchanged.

