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

## Drafts for the front page

None: the gate was not run (43 leaves remain). Vacuity carriers for wave 2 are not yet registered.
