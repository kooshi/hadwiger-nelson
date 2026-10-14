# FS131-IM11 — the five-colour chain: M11 (A⁺ at the empty set), proved

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IM11-aplus.md` (on `main`). Branch `fs131-wm12`, cut from
`fs131-wm11` at `3d7ed3d82`, in the tree `.claude/worktrees/fs132-wi1`. Working files: `data/fs131/im11/`. Report:
`data/fs131/reports/FS131-IM11.md`. The planner's record: `plans/FS131-KM11-aplus.md` (this branch).*

## Theorems this phase proved

All 33 leaves of M11 are proved; axioms as `data/fs131/im11/lean/Axioms.lean` prints them from the compiled library of
build 3 (`data/fs131/im11/axioms-after.txt`). "Standard three" = `[propext, Classical.choice, Quot.sound]`; "M2b" =
`[propext, sorryAx, Classical.choice, Quot.sound]` with `sorryAx` only through `Rigidity.bochnerOn_tauPrime` (module
`Rigidity/BochnerTau`, being proved on another line); "M3" = the same with `sorryAx` only through
`exists_shiftInvariant_on` and `exists_rotInvariant_of_shiftInvariant` (module `Rigidity/InvariantMeasure`).

*`Rigidity/SpectralSubspace` (M11-S), every one [kernel], standard three:*
- `Rigidity.gram_sum_eq` — the complex Gram identity in a real inner product space.
- `Rigidity.posDef_koopman` — `y ↦ ⟨f, V_y f⟩` is positive definite.
- `Rigidity.comp_mem_contVec` — `V_y` maps `l`-continuous vectors to `l`-continuous vectors.
- `Rigidity.inner_comp_eq_inner_comp_neg` — `⟨g, V_y f⟩ = ⟨V_{−y} g, f⟩`.
- `Rigidity.IsSpectralMeasureOf.add_of_orthogonal` — `σ_{h+r} = σ_h + σ_r` (SI-1's cross terms vanish).
- `Rigidity.exists_trigPoly_tendsto` — trigonometric polynomials are dense in `L²(σ)` on the dual of a countable group.
- `Rigidity.norm_sq_koopmanSum_re_add_im`, `Rigidity.inner_koopmanSum_re`, `Rigidity.comp_koopmanSum` — the Koopman isometry,
  pairing and shift.
- `Rigidity.exists_spectral_vector` — the spectral vector `1_A(V) f` of a measurable set of characters.
- **`Rigidity.spectral_null_of_orthogonal`** — the cyclic-subspace step (FS131-KR1's step (d)), no Bochner theorem read.
- **`Rigidity.isSpectralMeasureOf_condExpL2`** — J45 N2's last clause in spectral form.
- `Rigidity.spectral_null_model` — a non-degenerate model of the cyclic-subspace step's hypotheses (`ℤ` on `Fin 2`, `σ ≠ 0`).
- Composed by the planner, now with no `sorry` under them: `Rigidity.exists_isSpectralMeasureOf`,
  `Rigidity.spectral_contChars_null_of_orthogonal`.

*`Rigidity/TraceSplit` (M11-T), [kernel]:*
- `Rigidity.integral_colourInd_mul_comp`, `Rigidity.trace_decomp` (`3σ + δ₁ = 4Σ_j σ_{e_j}`), `Rigidity.condLaw_comp_colourShift`,
  `Rigidity.inner_colourInd_comp_unit` (its unread `[NumberField ↥F]` dropped, item 726), `Rigidity.colourCond_ae_eq_condLaw`,
  `Rigidity.integral_colourCond_mul_comp`, **`Rigidity.setIntegral_compl_TA_rot`** (remark (ii)) — standard three.
- **`Rigidity.setIntegral_compl_TA_re`** (SI-3 at `S = ∅`) and `Rigidity.setIntegral_compl_TA_re_nonpos` — M2b.

*`Rigidity/APlus` (M11-A), [kernel]:*
- `Rigidity.tendsto_mul_nhds_tauPrime`, `Rigidity.comap_colourRot_colourFactor` (`𝒜` rotation-invariant),
  `Rigidity.factorColouring_shift_ae`, `Rigidity.factorColouring_rot_ae`, `Rigidity.integral_condLaw_mul_eq_zero_of_adj`,
  `Rigidity.factorColouring_mem_X4`, `Rigidity.factorLaw_carried`, `Rigidity.factorLaw_shift_inv`, `Rigidity.factorLaw_rot_inv`,
  `Rigidity.numberField_bot` — standard three.
- `Rigidity.factorLaw_trace_null`, `Rigidity.equalAtUnits_of_not_neg` and the composition **`Rigidity.aPlusOfR88 (F)
  [NumberField F] : (chainInterface F).APlusOfR88`** — M2b.
- The models `Rigidity.nonempty_invariantColouring_bot`, `Rigidity.aplus_model` — M3.

So **`aPlusOfR88` rests on exactly one open leaf, `bochnerOn_tauPrime` (M2b)**: it prints the standard three the day M2b
lands, with no further change here.

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

## Stage 5 — SAVED: the gate items, and two lint findings repaired

**The lint, first run** (`lake lint --no-build -- --no-build --trace`, on build 2): exit 1, three `unusedArguments`
findings — `archTop`'s `[NumberField ↥F]` (known: item 863 ruling 1, owed on another branch), **`archHom`'s
`[NumberField ↥F]`** (made public at stage 4, so newly linted: the map does not read the binder, exactly as `archTop`), and
**`inner_colourInd_comp_unit`'s `[NumberField ↥F]`** (its statement reads no number field). **Repairs, both mine to decide
and said here:** (1) `archHom` is **private again** — `tendsto_mul_nhds_tauPrime`'s archimedean half now reads the map
`archTop` is defined with (it is `@[reducible]`, `archTop F = induced f inferInstance` by `rfl`), multiplicative by `map_mul`
of the mixed embedding, so no helper of `ContinuityGroup` but `mem_nhds_profTop` is read and no fact is proved twice;
making it public would need `@[nolint unusedArguments]` there, a line the brief does not give me. (2) The unread binder of
`inner_colourInd_comp_unit` is **dropped** (item 726's word, in the brief): stored type before `∀ {F} [inst : NumberField
↥F] (μ …) (u …) (j …), …`, after `∀ {F} (μ …) (u …) (j …), …` (`statements-before.txt`, `statements-after.txt`). So of item 873
ruling 1's three helpers **one is public** (`mem_nhds_profTop`, the one my route reads); `archHom` and `eventually_archTop`
stay private.

**Build 3** (the last): **`build: OK — 256 of 256 batches, 10 module(s) rebuilt, 18 module(s) with warnings, 8m14s`**
(`data/fs131/im11/build3.log`; `build/gate/build/20261014T164056Z-3864357.log`) — **no warning from any of my four files**
(`grep` of the log for them: 0 lines); the 18 modules with warnings are other modules' `sorry`.

**No statement and no definition changed** but the ruled ones, from the kernel's side: `tools/fs131_im11_statements.py`
(FS131-IJ1's reader aimed at the ten modules, the publicization and the dropped binder made checkable) on
`statements-before.txt` (stage 1) and `statements-after.txt` (build 3): **PASS** — 172 named constants compared (kinds,
stored types, modules), 41 data definitions' values, 6 example heads; `RULED PUBLIC mem_nhds_profTop` (kind, module, stored
type identical once the private name is substituted), `RULED DROP inner_colourInd_comp_unit`; the six downstream modules'
stored terms unmoved; three new public constants, each a generated `congr_simp` theorem (`koopmanSum`,
`Lp.compMeasurePreservingₗ`, `factorColouring`; `data/fs131/im11/allow-new.txt`); 26 new private helpers
(`statements-verdict.out`). **Control** (`--control`): ten faults planted in memory — a leaf's stored type, a definition's
value, a leaf gone, a downstream statement, a move, an unlisted public constant, an axiom, a theorem become a definition, the
publicized helper's type, a private constant's type — **10 of 10 reported** (`statements-control.out`).

**Axioms**, every declaration of the four modules (`data/fs131/im11/lean/Axioms.lean` → `axioms-after.txt`, read by
`tools/fs131_im11_axioms.py`): **PASS** — 121 records, 114 CLEAN, 7 OPEN-LEAF: `SpectralSubspace` 40 of 40 clean,
`ContinuityGroup` 28 of 28, `TraceSplit` 21 of 23 (`setIntegral_compl_TA_re`, `_nonpos` through `bochnerOn_tauPrime`), `APlus`
25 of 30 (`aPlusOfR88`, `equalAtUnits_of_not_neg`, `factorLaw_trace_null` through `bochnerOn_tauPrime`;
`nonempty_invariantColouring_bot`, `aplus_model` through M3's two leaves); no `sorry` sourced in my four modules; **the planted
record** (`positive_entropy_rigidity_of_polishSpace`) **reported** resting on the declared printed theorem. **Control**: four
faults planted (a `sorry` sourced in `SpectralSubspace`, an unknown axiom, the declared theorem, a `sorry` in a must-clean
leaf) — **4 of 4 reported** (`axioms-control.out`).

**The guarded lint on build 3** (`data/fs131/im11/lint.out`): exit 1 on **one** finding, `archTop`'s
`[NumberField ↥F]` (`ContinuityGroup` l. 42) — the pre-existing one, item 863 ruling 1, owed by another job on another
branch; **no finding in `SpectralSubspace`, `TraceSplit` or `APlus`, and none new in `ContinuityGroup`**. 13 of 14 linters
`(2/2) Passed!`.

`tools/check_architecture.py`: **PASS** (`data/fs131/im11/arch.out`), with the four rows updated (three modules proved; the
`ContinuityGroup` row names `mem_nhds_profTop` public).

## Drafts for the landing

**The audit's block** (`scripts/Axioms.lean`, CLEAN section): `data/fs131/im11/draft-axioms-block.lean` — 57 records CLEAN
at build 3 (every public declaration of the three modules whose axioms are the standard three, generated `congr_simp`
theorems left out, and `mem_nhds_profTop`), and 7 commented as not yet clean, to move up when M2b and M3 land.

**The models** (`LEAN.md` § The gate, the inhabitant rule):
- `spectral_null_model` — now a **kernel theorem** (standard three): `ℤ` acting on `Fin 2` by flips (`T y i = i + y • 1`,
  the counting measure), `f = 1_{0} − ½`, `σ` from Herglotz–Bochner with `σ ≠ 0`, `l = ⊤`, `A = {1}`: every hypothesis of
  `spectral_null_of_orthogonal` at once, non-degenerately.
- `IsSpectralMeasureOf` hypotheses (`add_of_orthogonal`, `exists_spectral_vector`, `isSpectralMeasureOf_condExpL2`, …):
  inhabited for every vector by `exists_isSpectralMeasureOf` (standard three).
- `trace_decomp`'s hypotheses: inhabited at `κ = id` on the colourings with the shift action, inside
  `setIntegral_compl_TA_re`, and at `κ = c′` inside `factorLaw_trace_null`; an invariant colouring and a trace measure exist
  over `ℚ` (`aplus_model`, M3).
- `isSpectralMeasureOf_condExpL2` at the topology the chain reads (`tauPrime F`): its use in `setIntegral_compl_TA_re`.
- `EqualAtUnits`: a step inside a proof by contradiction; its docstring names the model over `ℚ` (described, not a
  declaration), unchanged.

**`LEAN.md` § Searching — Lean, lines (each to follow the last):**
- At the pin `Fin n` has no global `IntCast` (its ring structure is not an instance): a `ℤ`-action on `Fin 2` is
  `i + y • 1` (`zsmul`), `abel` closes its action law (FS131-IM11, `spectral_null_model`).
- `rw [Measure.map_map hg hf]` does not find `map (fun c x => c (x + y)) (map f μ)` when `hg` is stated for a named
  definition with that body (`measurable_colourShift y`): `rw` does not unfold it; pass `(g := fun c x => c (x + y))`
  (FS131-IM11).
- Making a private declaration public exposes it to `lake lint`'s `unusedArguments`, which never reads private ones:
  `ContinuityGroup.archHom`'s `[NumberField ↥F]` is unread as `archTop`'s is. Lint before publicizing; a reducible
  definition's body can be read instead (`archTop F = induced f inferInstance := rfl`) (FS131-IM11).
- Dot notation on a hypothesis whose type is a definition unfolding to `∧` (`hσ : IsSpectralMeasureOf …`) looks in
  `And`: `hσ.unique` is "Invalid field"; write `IsSpectralMeasureOf.unique hσ h` (FS131-IM11).
- `IsFiniteMeasure (n • ν)` for `n : ℕ`, and of a `Finset` sum of measures, are not instances at the pin:
  `Measure.smul_apply`, `nsmul_eq_mul`, `ENNReal.mul_lt_top`; `Measure.finsetSum_apply`, `ENNReal.sum_lt_top`. A finite sum
  of measures restricts by `Measure.restrictₗ` and `map_sum` (FS131-IM11, `TraceSplit`).
- A module's compiled data holds the `congr_simp` theorems its proofs asked for, of its own definitions and of Mathlib's
  (`MeasureTheory.Lp.compMeasurePreservingₗ.congr_simp` in `Rigidity/SpectralSubspace`): a statement check lists them as
  generated, never as new statements (FS131-IM11).
