# FS131-IM11 — the five-colour chain: M11 (A⁺ at the empty set), proved

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IM11-aplus.md` (on `main`). Branch `fs131-wm12`, cut from
`fs131-wm11` at `3d7ed3d82`, in the tree `.claude/worktrees/fs132-wi1`. Working files: `data/fs131/im11/`. Report:
`data/fs131/reports/FS131-IM11.md`. The planner's record: `plans/FS131-KM11-aplus.md` (this branch).*

## Theorems this phase proved

*(filled at the last stage)*

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_im11_readback.py` (FS131-KM11's `tools/fs131_km11_readback.py`, copied with the brief's path changed; that
one is not edited) reads every block quotation of the brief and requires it, character for character, as one whole line of
its source on `main`'s working tree. Output `data/fs131/im11/readback.out`: **6 quotations, 6 IDENTICAL** — W2
(`data/fs131/REQUEST-2026-10-13.md`), the three dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 873
and 863 (`plans/FS131-close-inventory.md`). Control (`--plant`, `data/fs131/im11/readback-plant.out`): one character
changed in each quotation in memory, **6 of 6 reported**, exit 0 as the control requires.

### 1.2 The branch and the build

`git checkout -b fs131-wm12` at `3d7ed3d82` (the tree was on `fs131-wm11`, clean). Build under the slot
(`slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`): **`build: OK — all 1932 modules already up to
date, nothing built, 21 module(s) with warnings, 4s`** (`data/fs131/im11/build0.log`;
`build/gate/build/20261014T155840Z-3751940.log`). The tree's compiled library is current for the branch.

### 1.3 The stored statements, before any edit

`data/fs131/im11/lean/StatementDump.lean` (FS131-IJ1's dumper aimed at ten modules: the four I write —
`Rigidity/SpectralSubspace`, `TraceSplit`, `APlus`, `ContinuityGroup` — and the six downstream of `ContinuityGroup`:
`BochnerTau`, `CountTorus`, `CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`), run through `lake env lean`
under the slot against the compiled library as given: `data/fs131/im11/statements-before.txt`, 267 constants (20, 31, 30,
49, 4, 13, 70, 33, 6, 11 by module). The reader comparing it with the dump after the last build is
`tools/fs131_im11_statements.py` (stage 5).

### 1.4 The leaves, each restated in one line beside its plan (planner's record § 3)

Notation: `V_y f = f ∘ T y` (Koopman), `σ̂_f(y) = ⟨f, V_y f⟩`, `P_a(χ) = Σ_y a_y χ(y)`, `e_j = 1{κ₀ = j}`, `Π = E[· | 𝒜]`.

**M11-S (`Rigidity/SpectralSubspace`), 13 `sorry`:**

| # | leaf | restated | plan (§ 3.1) |
|---|---|---|---|
| S1 | `gram_sum_eq` | `Σ_{x,y∈s} z_x z̄_y ⟨v_y, v_x⟩ = ‖Σ Re z_x v_x‖² + ‖Σ Im z_x v_x‖²` in a real inner product space | scratch `Gram.lean` |
| S2 | `posDef_koopman` | `y ↦ ⟨f, V_y f⟩` is positive definite | `⟨f, V_{x−y} f⟩ = ⟨V_y f, V_x f⟩`, then S1 |
| S3 | `comp_mem_contVec` | `V_y` maps `l`-continuous vectors to `l`-continuous vectors | `‖V_z V_y h − V_y h‖ = ‖V_z h − h‖` |
| S4 | `inner_comp_eq_inner_comp_neg` | `⟨g, V_y f⟩ = ⟨V_{−y} g, f⟩` | apply the isometry `V_{−y}` to both |
| S5 | `IsSpectralMeasureOf.add_of_orthogonal` | `σ_{h+r} = σ_h + σ_r` for `h` continuous, `r ⊥` continuous vectors | the cross terms vanish by S3, S4 |
| S6 | `exists_trigPoly_tendsto` | some `P_{a_n} → 1_A` in `L²(σ)`, `σ` finite on the dual of a countable group | scratch `Density.lean` |
| S7 | `norm_sq_koopmanSum_re_add_im` | `‖Σ Re a_y V_y f‖² + ‖Σ Im a_y V_y f‖² = ∫ ‖P_a‖² dσ_f` | expand `‖P_a‖²`, coefficients, S1 |
| S8 | `inner_koopmanSum_re` | `⟨Σ Re a_y V_y f, f⟩ = Re ∫ P_a dσ_f` | linearity, `σ̂_f` real |
| S9 | `comp_koopmanSum` | `V_z (Σ b_y V_y f) = Σ b_y V_{y+z} f` | linearity, `compMeasurePreserving_add`, `linearCombination_mapDomain` |
| S10 | `exists_spectral_vector` | some `w` with `⟨w, f⟩ = σ_f(A)` and `‖V_z w − w‖² ≤ 2∫_A ‖χ z − 1‖² dσ_f` for all `z` | scratch `SpectralVector.lean` |
| S11 | `spectral_null_of_orthogonal` | `f ⊥ contVec l`, `A` measurable of characters tending to `1` along countably generated `l` ⟹ `σ_f(A) = 0` | S10, dominated convergence |
| S12 | `isSpectralMeasureOf_condExpL2` | `σ_{Πf} = σ_f|_{contChars t}` and `σ_{f−Πf} = σ_f|_{(contChars t)ᶜ}` | S5, uniqueness, `spectral_carried_iff`, S11 at `contChars` |
| S13 | `spectral_null_model` | `ℤ` flipping `Fin 2` (counting measure), `f = 1_{0} − ½`, `σ = ½δ_{χ₋}` meets every hypothesis of S11 with `σ ≠ 0` | explicit |

**M11-T (`Rigidity/TraceSplit`), 8 `sorry`:**

| # | leaf | restated | plan (§ 3.2) |
|---|---|---|---|
| T1 | `integral_colourInd_mul_comp` | `⟨e_j, V_y e_j⟩ = μ(κ0 = j ∧ κy = j)` for `κ` moved equivariantly at `0` | indicators, `hequiv` |
| T2 | `trace_decomp` | `3σ + δ₁ = 4 Σ_j σ_{e_j}` | coefficients by T1 and `3 tetra + 1 = 4[=]`; Fourier uniqueness |
| T3 | `condLaw_comp_colourShift` | `p_j(x) ∘ shift_y = p_j(x + y)` a.e. | `condExp_comp_measurePreserving`, `comap_factorSigma_eq_of_action` |
| T4 | `inner_colourInd_comp_unit` | `⟨e_j, V_u e_j⟩ = 0` for a unit vector `u` | T1 at `κ = id`; `μ` carried by `X₄` |
| T5 | `colourCond_ae_eq_condLaw` | `Πe_j = p_j(0)` a.e. | `MemLp.condExpL2_ae_eq_condExp` |
| T6 | `integral_colourCond_mul_comp` | `⟨Πe_j, V_y Πe_j⟩ = E[p_j(0) p_j(y)]` | T5, T3 at `x = 0` |
| T7 | `setIntegral_compl_TA_re` | SI-3: `∫_{(T+A)ᶜ} Re χ(u) dσ = −(4/3) Σ_j E[p_j(0) p_j(u)]` | T2, S12 at `tauPrime F`, T4, T6 |
| T8 | `setIntegral_compl_TA_rot` | remark (ii): `∫_{(T+A)ᶜ} Re χ(u) dσ = ∫_{(T+A)ᶜ} Re χ(1) dσ` | `rotInv_of_isTraceSpectral`, `rot_preimage_TA` |

**M11-A (`Rigidity/APlus`), 12 `sorry`:**

| # | leaf | restated | plan (§ 3.3) |
|---|---|---|---|
| A1 | `tendsto_mul_nhds_tauPrime` | `y ↦ r y` is continuous at `0` for `τ′_∅` | `nhds_inf`; `(N+1)R` stable; `archHom` multiplicative on the mixed space |
| A2 | `comap_colourRot_colourFactor` | `rot_u⁻¹ 𝒜 = 𝒜` | `mem_factorSets_iff`, `shift_y ∘ rot_u = rot_u ∘ shift_{uy}`, A1 |
| A3 | `factorColouring_shift_ae` | `c′(shift_y c) = shift_y (c′ c)` a.s. | `si4_equivariant_factorSigma` |
| A4 | `factorColouring_rot_ae` | `c′(rot_u c) = rot_u (c′ c)` a.s. | `si4_equivariant` with A2 |
| A5 | `integral_condLaw_mul_eq_zero_of_adj` | `EqualAtUnits μ`, `y − x` a unit vector ⟹ `E[p_j(x) p_j(y)] = 0` | T3 twice, shift invariance |
| A6 | `factorColouring_mem_X4` | `EqualAtUnits μ` ⟹ `c′ ∈ X₄` a.s. | `si4` with A5 |
| A7 | `factorLaw_carried` | `EqualAtUnits μ` ⟹ the law of `c′` gives `X₄ᶜ` measure `0` | A6, `Measure.map_apply` |
| A8 | `factorLaw_shift_inv` | the law of `c′` is shift-invariant | A3, `μ.shift_inv` |
| A9 | `factorLaw_rot_inv` | the law of `c′` is rotation-invariant | A4, `μ.rot_inv` |
| A10 | `factorLaw_trace_null` | every trace spectral measure of the law of `c′` is null off `T + A` | T2 at `κ = c′`, each `e″_j` `𝒜`-measurable, `spectral_carried_iff` |
| A11 | `equalAtUnits_of_not_neg` | `¬ (∫_{(T+A)ᶜ} Re χ(1) dσ < 0)` ⟹ `EqualAtUnits μ` | T7, T8, nonnegative summands |
| A12 | `numberField_bot` | `⊥ : Subfield ℝ` is a number field | `Module.Finite` from `ℚ` onto `⊥` |

## Stage 2 — SAVED: M11-S (`Rigidity/SpectralSubspace`) proved, 13 of 13 leaves

All thirteen leaves are proved in the module (`lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false
-Dlinter.missingDocs=true`: exit 0, no message; `data/fs131/im11/logs/S-final.log`). The build and the axiom print come at
the gate stage, once for the three modules.

**Routes as planned**, with the planner's three scratch proofs folded in: `gram_sum_eq` (`Gram.lean`, verbatim);
`exists_trigPoly_tendsto` (`Density.lean`: its helpers `evC`, `evC_add`, `evC_zero`, `star_evC`, `trigAlg`,
`trigAlg_separatesPoints`, `trigC`, `trigC_apply`, `exists_trigC_near`, `integral_norm_sq_eq` made `private`);
`exists_spectral_vector` (`SpectralVector.lean`: the primed helpers made `private` under their unprimed names —
`trigPoly_sub`, `trigPoly_eq_sum`, `measurable_trigPoly`, `norm_trigPoly_le`, `integrable_err`,
`tendsto_integral_norm_of_sq`, `trigPoly_mapDomain_add`). New private helpers: `inner_comp_comp_same` (each `V_y` preserves
`⟨·,·⟩`, from `Lp.compMeasurePreservingₗᵢ`), `inner_comp_comp` (`⟨V_y f, V_x f⟩ = ⟨f, V_{x−y} f⟩`), `koopmanSum_mapRange`
(a Koopman sum of mapped coefficients as a sum over `a.support`).

**One route changed (mine to decide, said here):** `spectral_null_model` takes its `σ` from
`exists_isSpectralMeasureOf` (Herglotz–Bochner on `ℤ`, M2a, standard three) instead of writing `½ δ_{χ₋}`, and shows
`σ ≠ 0` from `∫ χ(0) dσ = ‖f‖² ≠ 0`. The statement is an existential and is unchanged; by uniqueness the `σ` it takes is
`½ δ_{χ₋}`, so the docstring's description stays true. The action is written `T y i = i + y • 1` on `Fin 2` (`Fin 2` has
no global `IntCast` at the pin; the docstring's `(· + n)` is this map).

**Re-priced from the first two leaves** (brief, § Your lanes): `gram_sum_eq` 35 lines (the scratch proof), `posDef_koopman`
13 lines plus 22 of two helpers, against the plan's 35 and 40–60 — at plan. **The lane:** 609 lines added (`git diff
--stat`), against the plan's "500–700 lines left"; about 13 minutes from the first edit to the last leaf.

## Stage 3 — SAVED: M11-T (`Rigidity/TraceSplit`) proved, 8 of 8 leaves

All eight leaves are proved (`lake env lean` with the lakefile's options as `-D` flags: exit 0, no message;
`data/fs131/im11/logs/T-final.log`), elaborated against the compiled `SpectralSubspace` of the base commit (its statements
are unchanged, so the leaves of M11-S are read as stated).

**Routes as planned.** `trace_decomp`'s coefficient identity `3 corr(y) + 1 = 4 Σ_j μ(κ0 = j ∧ κy = j)` is computed in
`ℝ` and cast; the measure identity is Fourier uniqueness (`measure_eq_of_fourier`). `setIntegral_compl_TA_re` reads only
the first half of `isSpectralMeasureOf_condExpL2` (the continuous part's measure is `σ_j` on `T + A`) with
`integral_add_compl`: `∫_{(T+A)ᶜ} χ(u) dσ_j = ⟨e_j, V_u e_j⟩ − ⟨Πe_j, V_u Πe_j⟩ = 0 − E[p_j(0) p_j(u)]`; then `3σ = 4Σσ_j`
off `T + A` (`1 ∈ T + A`), integrated, and the real part taken. `setIntegral_compl_TA_rot` is `setIntegral_map` along
`rot u` with `rot_preimage_TA`. New private helpers: `three_mul_tetra_add_one_eq_sum` (pointwise, `fin_cases`),
`isFiniteMeasure_nsmul`, `integral_nsmul_measure`.

**Re-priced from the first two leaves:** `integral_colourInd_mul_comp` 18 lines, `trace_decomp` 54 lines with its two
helpers' 14, against the plan's 30–50 and 60–100 — under plan. **The lane:** 175 lines added, against the plan's 350–500;
about 9 minutes.

## Stage 4 — SAVED: M11-A (`Rigidity/APlus`) proved, 12 of 12 leaves; two helpers of `ContinuityGroup` made public

**`ContinuityGroup`:** `private` removed from `archHom` and `mem_nhds_profTop` and nothing else (item 873 ruling 1).
**`eventually_archTop` is left private**, a choice I report for the coordinator: the route I took for
`tendsto_mul_nhds_tauPrime` does not read it, and it carries no docstring, so made public it would warn under the
lakefile's `linter.missingDocs` — and the brief allows me no other line of that file. The build with the two made public
and lanes S and T proved: **`build: OK — 256 of 256 batches, 11 module(s) rebuilt, 19 module(s) with warnings, 7m14s`**
(`data/fs131/im11/build1.log`; `build/gate/build/20261014T162219Z-3807280.log`): `ContinuityGroup`, `SpectralSubspace`,
`TraceSplit` rebuilt with no warning; `APlus` (still the skeleton then), `BochnerTau` and the five `Count*` modules
rebuilt with their own `sorry` warnings only. Lane A's proofs were written meanwhile in a copy
(`data/fs131/im11/work/APlus.lean`) and put over the module after the build.

**All twelve leaves are proved** (`lake env lean` with the lakefile's options: exit 0, no message;
`data/fs131/im11/logs/A-final.log`).

**One route changed (mine to decide, said here): `tendsto_mul_nhds_tauPrime`.** The profinite half is the plan's
(`mem_nhds_profTop`, `r · (N + 1)R ⊆ (N + 1)R`), through `nhds_iInf`, `nhds_induced` and `tendsto_pure`. The archimedean
half uses no norm: `archTop` is induced by `archHom` (`rfl`), `archHom (r y) = archHom r · archHom y` (`map_mul` of the
mixed embedding), so the map is `(archHom r · ·) ∘ archHom` and continuity of multiplication on the mixed space
(`continuous_const_mul`) with `tendsto_comap` finishes — `eventually_archTop` and its classical norm are not read.
`numberField_bot` is `UpperHalf.numberField_bot` (`Instances/UpperHalfValues`, already imported).

New private helpers: `conjUV` (the conjugate of a unit vector, `ChainAtTA`'s private `conj_mem_unitVectors` restated as
a value), `uvRing_mul_conjUV` (`u (ū y) = y`), `colourRot_preimage_mem` (the rotated preimage of an event of `𝒜` is in
`𝒜`: `shift_y⁻¹ rot_u⁻¹ A = rot_u⁻¹ shift_{ūy}⁻¹ A`, then `tendsto_mul_nhds_tauPrime` at `ū`), from which
`comap_colourRot_colourFactor` is the two inclusions.

**Re-priced from the first two leaves:** `tendsto_mul_nhds_tauPrime` 41 lines, `comap_colourRot_colourFactor` 16 lines
plus 44 of three helpers, against the plan's 60–110 and 50–80 — at or under plan. **The lane:** 203 lines added, against
the plan's 350–550; about 10 minutes of writing during the build and 2 minutes after it.

**M11 as a whole:** 33 of 33 leaves proved, 987 lines added to the three modules (609 + 175 + 203) against the plan's
1,170–1,720 still to write (§ 4.2 of the planner's record, its ~430 written lines subtracted) — about 0.6–0.85 of plan.
