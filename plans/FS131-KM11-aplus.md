# FS131-KM11 — the five-colour chain: M11 (A⁺ at the empty set), typed to its leaves and priced

*de Bruijn, the planner (the twelfth on this chain). Brief: `data/fs131/briefs/FS131-KM11-aplus.md` (on `main`). Branch
`fs131-wm11`, cut from the chain's line at `1e438c171`, in the tree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/km11/`. Report: `data/fs131/reports/FS131-KM11.md`.*

## Theorems this phase proved

A planning job; filled at the last stage.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_km11_readback.py` (KR1's tool, copied with the brief's path changed; KR1's own is not edited) reads every block
quotation of the brief and requires it, character for character, as one whole line of its source on `main`'s working tree.
Output `data/fs131/km11/readback.out`: **6 quotations, 6 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), NF2-NC and the
two dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823 and 863 (`plans/FS131-close-inventory.md`).
Control (`--plant`, `data/fs131/km11/readback-plant.out`): one character changed in each quotation in memory, **6 of 6
reported**, exit 0 as the control requires. The brief's two in-line quotations of the map planner's record — "(d) … **the step
no record states as a lemma**" and "1,500–2,500 lines" — read against `plans/FS131-KR1-chain-map.md` § 2.4 on this branch:
present as quoted.

### 1.2 The branch and the build

`git checkout -b fs131-wm11 1e438c171` in `fs132-wi1` (the tree was on `fs131-f4`, clean). First build:
`slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` → **`build: OK — 256 of 256 batches, 74 module(s)
rebuilt, 18 module(s) with warnings, 11m7s`** (`build/gate/build/20261014T151321Z-3570208.log`; my copy
`data/fs131/km11/build1.log`).

### 1.3 The hypothesis, from the kernel

`data/fs131/km11/probes/Print.lean` → `Print.out`, from the compiled library:

```
def HadwigerNelson.SpectralChain.Interface.APlusOfR88 : {F : Subfield ℝ} → Interface F → Prop := fun {F} I => I.R88TCA → I.APlus0
def …APlus0 := fun {F} I => ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ →
      ∫ (χ : Dual F) in I.TAᶜ, (↑(χ 1)).re ∂σ < 0
def …R88TCA := fun {F} I => ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ I.TAᶜ ≠ 0
def HadwigerNelson.Rigidity.chainInterface : (F : Subfield ℝ) → [NumberField ↥F] → Interface F :=
  fun F [NumberField ↥F] => { E := TA F, TA := TA F, …, h := fun τ u => ksEntropy τ (rot u) }
```

and the kernel accepts, by `Iff.rfl`, the restatement

```lean
(chainInterface F).APlusOfR88 ↔
  ((∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ (TA F)ᶜ ≠ 0) →
    ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0)
```

**Restated.** For a real number field `F`: *if* no translation- and rotation-invariant random proper four-colouring of
`Cay(ℤ[U_F], U_F)` has a trace spectral measure null off `T + A`, *then* every such colouring's every trace spectral measure
has a strictly negative mean of `Re χ(1)` over the characters off `T + A`. `χ 1` is the character at the ring's `1`, which is
the unit vector `1`. M11 proves it with no hypothesis beyond `[NumberField F]`.

The read statements, as the kernel stores them (`Print.out`): `contChars_tauPrime : contChars (tauPrime F) = TA F` and
`bochnerHerglotz_of_countable`, `measure_eq_of_fourier` on the standard three; **`bochnerOn_tauPrime : BochnerOn (tauPrime
F)` on `sorryAx`** (M2b, being proved); `isTopologicalAddGroup_tauPrime`, `isCountablyGenerated_nhds_tauPrime`,
`measurableSet_TA`, `rot_preimage_TA`, `spectral_carried_iff`, `si4`, `si4_equivariant`, `si4_equivariant_factorSigma`,
`comap_factorSigma_eq_of_action`, `rotInv_of_isTraceSpectral`, `contVec_eq_lpMeas`, `inner_sub_condExpL2_eq_zero`.

### 1.4 The map planner's steps (a)–(g), restated: what each reads, what it produces, what the kernel already holds

Notation: `Ω = (unitRing F → Fin 4)` with the law `μ.μ`; `V_y f = f ∘ shift_y` the Koopman operators; `𝒜 = factorSigma` of
the shifts along `𝓝_{τ′} 0`; `Π = condExpL2` for `𝒜`.

| step | reads | produces | held by the kernel now |
|---|---|---|---|
| (a) `σ = ⅓Σ_k σ_{g_k}` | Herglotz–Bochner (existence of each `σ_{g_k}`), Fourier uniqueness, the tetrahedral Gram identity | the trace measure as a sum of three spectral measures | `bochnerHerglotz_of_countable`, `measure_eq_of_fourier`, `tetra_eq`; **not**: a spectral measure of a vector of `L²(μ)` exists (`posDef` of `y ↦ ⟨f, V_y f⟩`) |
| (b) `σ_g = σ_h + σ_r` | `h ∈ contVec`, `r ⊥ contVec`, `contVec` shift-invariant, `V_y` unitary | the split of each `σ_{g_k}` | `condExpL2_mem_contVec`, `inner_sub_condExpL2_eq_zero`; **not**: the cross-term vanishing, `contVec` invariance |
| (c) `σ_h(TAᶜ) = 0` | N2's `⟸`: `spectral_carried_iff` with `BochnerOn (tauPrime F)` and `contChars_tauPrime` | `σ_h` on `T + A` | `spectral_carried_iff`, `contChars_tauPrime`, `isTopologicalAddGroup_tauPrime`, `isCountablyGenerated_nhds_tauPrime`; `bochnerOn_tauPrime` typed (M2b) |
| (d) `σ_r(TA) = 0` | the cyclic subspace of `r`, density of trigonometric polynomials in `L²(σ_r)`, N2's `⟹` (dominated convergence), `r ⊥ contVec` | `σ_r` off `T + A` | nothing: **the step no record states as a lemma** |
| (e) SI-3 | (a)–(d), properness (`μ (X4 F)ᶜ = 0`), conditional expectation commuting with shifts | `∫_{TAᶜ} Re χ(u) dσ = −(4/3)Σ_j E[p_j(0)p_j(u)] ≤ 0` | `condExp_comp_measurePreserving`, `comap_factorSigma_eq_of_action`, `condLaw_nonneg` |
| (f) remark (ii) | `σ` rotation-invariant (`rotInv_of_isTraceSpectral` over `bochnerHerglotz_of_countable`), `rot_preimage_TA` | the integral is the same at every `u ∈ U` | both read statements are theorems; the transfer is not |
| (g) SI-4 and R88-TCA | equality at every `u` ⟹ SI-4's selection `c′`; its law an `InvariantColouring` (shift and **rotation** equivariance, carried by `X₄`); its trace measure carried by `T + A` (N2's `⟸` again); `R88TCA` | the contradiction | `si4`, `si4_equivariant`, `si4_equivariant_factorSigma`; **not**: `𝒜` rotation-invariant (needs multiplication by `u` continuous for `τ′`), the law's four fields, its trace measure on `T + A` |

**Two findings already at the readback** (to the coordinator at once, below):

1. **A shorter route for (a) and (e): colour indicators in place of tetrahedral coordinates.** With `e_j = 1{c(0) = j}` and
   `tetra i j = (4/3)[i = j] − 1/3`, the correlation is `corr(y) = (4/3)Σ_j ⟨e_j, V_y e_j⟩ − 1/3` (because `Σ_j e_j = 1`), so
   by Fourier uniqueness **`3σ + δ₁ = 4Σ_j σ_{e_j}`**, a sum of positive measures with natural-number coefficients. Then
   SI-3 is immediate: `⟨e_j, V_u e_j⟩ = μ(c(0) = j = c(u)) = 0` for `u ∈ U`, and `Πe_j = p_j(0)`, the very `condLaw` that
   `SpectralInputs.si4`'s hypothesis is written in. The tetrahedral coordinates and their Gram algebra leave the path; the
   identity `⟨Σp_ie_i, Σq_je_j⟩ = (4/3)Σp_jq_j − 1/3` of SI-3's proof becomes the definition of `tetra`. The same identity
   serves the factor colouring in (g), with `e″_j = 1{c′(0) = j}`, which is `𝒜`-measurable — so (g)'s "its trace measure is
   carried by `T + A`" is the same lemma applied once more.
2. **Step (d) needs no Bochner theorem, and holds at the class its argument reads.** For any action of a countable abelian
   group by measure-preserving maps, any countably generated filter `l` on the group, any measurable set `A` of characters
   each tending to `1` along `l`, and any `f ⊥ contVec(l)` with spectral measure `σ`: `σ(A) = 0`. The cyclic-subspace
   construction is a limit of real Koopman sums `Σ_y Re(a_y) V_y f`, Cauchy because
   `‖Σ Re(a_y)V_y f‖² + ‖Σ Im(a_y)V_y f‖² = ∫ |Σ a_y χ(y)|² dσ` (σ's coefficients are real), so no symmetry of `σ` under
   `χ ↦ χ̄` is needed; density of trigonometric polynomials in `L²(σ)` is Stone–Weierstrass on the compact dual
   (`ContinuousMap.starSubalgebra_topologicalClosure_eq_top_of_separatesPoints`) with `ContinuousMap.toLp_denseRange`, both
   at the pin (`data/fs131/km11/probes/Names.out`), in place of the record's "Fourier uniqueness applied to the positive and
   negative parts of a complex measure".

## Stage 2 — SAVED: the statements typed

### 2.1 How M11 is cut

Three modules, sharing no file, each importing the one before it:

| module | id | what it holds | reads |
|---|---|---|---|
| `Rigidity/SpectralSubspace` | M11a | spectral measures of Koopman vectors for **any** action of a countable abelian group on a measure space; **step (d), the cyclic-subspace step** (`spectral_null_of_orthogonal`); N2's last clause in spectral form (`isSpectralMeasureOf_condExpL2`) | M2a, M4, `SpectralInputs` |
| `Rigidity/TraceSplit` | M11b | the shift action on colourings, `𝒜 = colourFactor μ`, the trace measure in colour indicators (`trace_decomp`), **SI-3** (`setIntegral_compl_TA_re`) and **remark (ii)** (`setIntegral_compl_TA_rot`) | M11a, M10, M2b, `Arith/FactorAction` |
| `Rigidity/APlus` | M11c | rotations, `𝒜` rotation-invariant, **SI-4's** factor colouring and its law, **the composition `aPlusOfR88`**, the models | M11b, `ChainAtTA`, M3 (models only), `Instances/UpperHalfValues` (models only) |

### 2.2 The statements, read aloud against their entries (J45, `plans/FS84-SI-D-derivation.md`)

*M11a.* `posDef_koopman`: `y ↦ ⟨f, V_y f⟩` is positive definite — N2's "`σ̂_f` is positive definite" (l. 129).
`exists_isSpectralMeasureOf`, `IsSpectralMeasureOf.unique`: every `f` has one spectral measure — J45 §1.2's `σ_f`, which
the derivation takes as given. `IsSpectralMeasureOf.add_of_orthogonal`: SI-1's "the cross terms vanish" (l. 146), with
`comp_mem_contVec` ("`H_S` is … translation-invariant", l. 131) and `inner_comp_eq_inner_comp_neg`.
**`spectral_null_of_orthogonal`**: for `l` countably generated, a measurable `A` of characters each tending to `1` along `l`,
and `f ⊥ contVec(l)`, `σ_f(A) = 0` — FS131-KR1 § 2.4's step (d) ("`σ_{r_k}(TA) = 0`"), at the class its argument reads; its
children `exists_spectral_vector` (the vector `1_A(V) f`), `exists_trigPoly_tendsto` ("trigonometric polynomials are dense
in `L²(σ_r)`"), `gram_sum_eq` and `norm_sq_koopmanSum_re_add_im` (the isometry), `inner_koopmanSum_re`, `comp_koopmanSum`.
`spectral_contChars_null_of_orthogonal`: the same at `A = contChars t` (proved in the skeleton from the above).
`isSpectralMeasureOf_condExpL2`: "the spectral projection `Π(E_S)` is `E[· | 𝒜_S]`" (N2, l. 127), as the two restrictions
of `σ_f` to `contChars t` and its complement.

*M11b.* `trace_decomp`: `3σ + δ₁ = 4 Σ_j σ_{e_j}` — J45 §1.2's trace measure written in colour indicators (§ 1.4 finding 1;
it replaces SI-1's "`C(u) = Σ_k ⟨V_u g_k, g_k⟩`"), children `three_mul_tetra_add_one`, `integral_colourInd_mul_comp`.
`condLaw_comp_colourShift`: SI's "`p_j(x) := p_j(0) ∘ T_x` (a version …, `𝒜_S` being invariant)" (l. 142).
`inner_colourInd_comp_unit`: "`C(u) = −1/3` because `c` is proper surely" (l. 148), in indicator form.
`colourCond_ae_eq_condLaw`, `integral_colourCond_mul_comp`: "By N2, `Πg_k = h_k(0)` and `V_u h_k(0) = h_k(u)`" (l. 147).
**`setIntegral_compl_TA_re`**: SI-3's identity verbatim at `S = ∅`, `∫_{R̂∖(T+A)} Re χ(u) dσ_μ = −(4/3) Σ_j E[p_j(0)p_j(u)]`
(l. 154); `setIntegral_compl_TA_re_nonpos` its "hence it is `≤ 0`" (proved in the skeleton). **`setIntegral_compl_TA_rot`**:
remark (ii), "`u ↦ ∫_{R̂∖E_S} χ(u) dσ_μ` is constant on `U`" (l. 249).

*M11c.* `tendsto_mul_nhds_tauPrime`, `comap_colourRot_colourFactor`: remark (ii)'s "`E_S` [is] `U`-invariant" at the level
of the factor — the derivation needs it only of the set; the factor colouring's rotation-equivariance needs it of `𝒜`, a
step the derivation does not write (multiplication by `u` is a `τ′_∅`-homeomorphism: SI-5 (a) says so, l. 180).
`factorColouring` and its four lemmas: SI-4's "`c′ = f ∘ M` is a.s. a proper four-colouring, `𝒜_S`-measurable,
translation-equivariant" (l. 160), with **rotation-equivariance added** (A⁺'s remark (ii) case, `R ⋊ U`).
`EqualAtUnits`, `integral_condLaw_mul_eq_zero_of_adj`: SI-3's "stationarity carries this to every `x`" (l. 157).
`factorLaw`: A⁺'s "its law `μ′` … is a translation-invariant Borel probability on `X₄(F)`" (l. 244), rotation-invariant too.
`factorLaw_trace_null`: "the coordinates of `e_{c′(0)}` lie in `L²(𝒜_S)`, so their spectral measures … are carried by `E_S`
(N2)" (l. 245). `equalAtUnits_of_not_neg` + `aPlusOfR88`: A⁺ with remark (ii), "strict at every `u`, in particular at `u = 1`".

**The composition** (`aPlusOfR88`, proved in the skeleton over the leaves):

```lean
theorem aPlusOfR88 (F : Subfield ℝ) [NumberField F] : (chainInterface F).APlusOfR88 := by
  intro hR μ σ hσ
  show ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0
  by_contra hneg
  have hEq := equalAtUnits_of_not_neg μ hσ hneg
  …
  obtain ⟨σ', hfin, hσ', -⟩ := bochnerHerglotz_of_countable (unitRing F) _ (posDef_corr (factorLaw μ hEq))
  exact hR (factorLaw μ hEq) σ' ⟨hfin, hσ'⟩ (factorLaw_trace_null μ ⟨hfin, hσ'⟩)
```

### 2.3 The modeling passes (each a fresh Skill invocation; each committed before the next)

**Domain pass** (`debruijn-domain-modeling`, commit `FS131-KM11: the three skeleton modules, with the domain pass`):
(1) the probability instance on `μ.μ` is the structure's own field made a **scoped** instance
(`attribute [scoped instance] InvariantColouring.isProb`), not a second declaration — no sibling module (M12's lanes read
`InvariantColouring` too) can then hold a duplicate; (2) `colourInd` takes the random colour at `0`, `κ₀ : Ω → Fin 4`, not
the whole colouring with a measurability proof per coordinate — it reads one coordinate, so it indexes one; (3) `Πe_j` is
named (`colourCond`), which halved two statements. Kept: `trigPoly` and `koopmanSum` as `Finsupp.linearCombination`
(linearity free; the group algebra `R →₀ ℂ` is the problem's own coefficient space); `colourFactor` as an `abbrev` of
`factorSigma`, so every `SpectralInputs` lemma applies by unification; `factorLaw` a `def` whose proof fields are named
theorems (its stored value does not move when they are proved, `LEAN.md` § Searching).

**Obligation pass** (`debruijn-obligation-modeling`, commit `FS131-KM11: the obligation pass`): (1) `gram_sum_eq`, a
finite-sum identity in any real inner product space, made the shared child of `posDef_koopman` and the isometry; (2)
`exists_spectral_vector` made the child that carries step (d)'s construction, reading no orthogonality and no filter, so
`spectral_null_of_orthogonal` is it plus dominated convergence; (3) `trace_decomp`'s two children typed; (4)
**`factorLaw_trace_null` lost the hypothesis `EqualAtUnits μ`**, which its proof never reads: it is stated for the law of
`c′` whatever `μ`. Mutation reading: drop `hAl` from `spectral_null_of_orthogonal` and `A = univ` makes it false; drop
`hequiv` from `trace_decomp` and it is false; drop `[l.IsCountablyGenerated]` and the dominated-convergence step has no
Mathlib form (kept as the hypothesis the proof reads; at `τ′_∅` it holds, `isCountablyGenerated_nhds_tauPrime`).

### 2.4 The build, the stored types, the models

`./scripts/build.sh` → **`build: OK — 256 of 256 batches, 3 module(s) rebuilt, 7m1s`**
(`build/gate/build/20261014T154305Z-3697722.log`; `data/fs131/km11/build3.log`; the second build's failure — dot notation
on a lemma declared in the wrong namespace and one coercion — is `build2.log`). The three modules carry **33 declarations
with `sorry`** and no other warning. **Proved in the skeleton**, composed over the leaves: `aPlusOfR88`,
`exists_isSpectralMeasureOf`, `IsSpectralMeasureOf.unique` (standard three), `spectral_contChars_null_of_orthogonal`,
`setIntegral_compl_TA_re_nonpos`, `integral_condLaw_mul_nonneg`, `three_mul_tetra_add_one` (standard three), `minSel_mem`,
`measurable_factorColouring(_apply)`, `factorLaw_isProb`, `nonempty_invariantColouring_bot`, `aplus_model`. Axioms
(`data/fs131/km11/probes/Sigs.out`): `aPlusOfR88` on `[propext, sorryAx, Classical.choice, Quot.sound]` — `sorryAx` from
the leaves and from M2b, M3 through the models — and nothing else.

**Stored types, read for class binders** (item 847's defect): every constant of the three modules dumped from the compiled
library (`probes/Sigs.lean` → `Sigs.out`, tabulated in `probes/binders.txt`). Every instance binder is one its statement
reads: `[NumberField ↥F]` exactly on what names `tauPrime` (through `colourFactor`) or `TA`; `[Countable R]` exactly on
what uses Fourier uniqueness or the compact dual; none on `colourShift`, `colourRot`, `minSel`, `gram_sum_eq`,
`spectral_null_model`; `trigPoly` carries `[AddCommGroup R]` and not `[MeasurableSpace Ω]`. One generated theorem,
`colourFactor.congr_simp`, sits in the module that defines `colourFactor` (a `GENERATED` row for the landing's
`dupnames.sh` to read; it cannot double, its definition being in the same module).

**Models.** `spectral_null_model` (typed, a leaf): a non-degenerate instance of every hypothesis of the cyclic-subspace
step at once. `aplus_model` (proved over M3 and `numberField_bot`): over `ℚ` an invariant colouring and a trace spectral
measure exist, so the binders of SI-3, remark (ii), `factorLaw_trace_null` and `APlus0` are inhabited at a number field.
`EqualAtUnits` is a step inside a proof by contradiction; its docstring names the model over `ℚ` (the residue colouring at
the ramified prime above 2 with a fair bit) as described, not a declaration. `IsSpectralMeasureOf` hypotheses are inhabited
by `exists_isSpectralMeasureOf` for every vector.

## Stage 3 — SAVED: the plan per leaf

Mathlib names `#check`ed at the pin in `data/fs131/km11/probes/Names.out`, or used in the scratch proofs (elaborated).
Prices are lines of Lean including docstrings; "scratch" means a proof exists in `data/fs131/km11/scratch/` and elaborated.

### 3.1 M11a — `Rigidity/SpectralSubspace` (lane S)

| leaf | route | names | hard part | price |
|---|---|---|---|---|
| `gram_sum_eq` | `Complex.ext`; real part: `‖Σ c_x v_x‖² = ΣΣ c_x c_y ⟨v_y, v_x⟩` (`real_inner_self_eq_norm_sq`, `sum_inner`, `inner_sum`); imaginary part cancels by `Finset.sum_comm` and `real_inner_comm` | — | none | **scratch, proved**: 35 (`Gram.lean`) |
| `posDef_koopman` | `⟨f, V_{x−y} f⟩ = ⟨V_y f, V_x f⟩` (`compMeasurePreserving_add`, isometry preserves `inner`: `Lp.isometry_compMeasurePreserving`, polarization or `LinearIsometry.inner_map_map` on `Lp.compMeasurePreservingₗᵢ`), `integral_mul_comp_eq_inner`, then `gram_sum_eq` | `integral_mul_comp_eq_inner` | the inner-product transport | 40–60 |
| `comp_mem_contVec` | `‖V_z V_y h − V_y h‖ = ‖V_y (V_z h − h)‖ = ‖V_z h − h‖` (commuting from `hadd` and `add_comm`; `Lp.norm_compMeasurePreserving`) | `compMeasurePreserving_add` | none | 20–30 |
| `inner_comp_eq_inner_comp_neg` | apply `V_{−y}` (an isometry) to both arguments; `V_{−y} V_y = V_0 = id` (`compMeasurePreserving_zero`) | as above | none | 20–30 |
| `IsSpectralMeasureOf.add_of_orthogonal` | expand `⟨h + r, V_y(h + r)⟩`; `⟨r, V_y h⟩ = 0` by `comp_mem_contVec`, `⟨h, V_y r⟩ = ⟨V_{−y} h, r⟩ = 0`; `integral_add_measure` | `integral_add_measure` | none | 40–60 |
| `exists_trigPoly_tendsto` | the evaluations span a star subalgebra of `C(R̂, ℂ)` separating points; Stone–Weierstrass; `ContinuousMap.toLp_denseRange` (weak regularity by `Measure.WeaklyRegular.of_pseudoMetrizableSpace_of_isFiniteMeasure`); `‖F‖² = ∫‖F‖²` | `ContinuousMap.starSubalgebra_topologicalClosure_eq_top_of_separatesPoints`, `ContinuousMap.toLp_denseRange`, `ContinuousMap.coeFn_toLp`, `indicatorConstLp_coeFn` | **API: the hard leaf of step (d)** — resolved | **scratch, proved**: 145 with its helpers (`Density.lean`; standard three) |
| `norm_sq_koopmanSum_re_add_im` | `koopmanSum` of `Finsupp` coefficients as a `Finset` sum over `a.support`; `∫ |Σ a_y χ(y)|² dσ = ΣΣ a_x ā_y σ̂(x − y)` (expand `normSq`, `integral_finsetSum`, `coe_char_sub`); `σ̂(x − y) = ⟨V_y f, V_x f⟩` (as in `posDef_koopman`); `gram_sum_eq` | `SpectralInputs.coe_char_sub`, `integral_finsetSum` | the Finsupp/Finset bookkeeping | 60–100 |
| `inner_koopmanSum_re` | `⟨Σ b_y V_y f, f⟩ = Σ b_y ⟨V_y f, f⟩`, `⟨V_y f, f⟩ = σ̂(y)` real; `Re ∫ P_a dσ = Σ Re(a_y) σ̂(y)` | `integral_finsetSum`, `real_inner_comm` | none | 25–40 |
| `comp_koopmanSum` | linearity of `V_z`, `compMeasurePreserving_add`, `Finsupp.linearCombination_mapDomain` | as named | none | 20–30 |
| `exists_spectral_vector` | Cauchy sequence of `Σ Re(a_n,y) V_y f`, `cauchySeq_tendsto_of_complete`; the pairing through `∫‖P_n − 1_A‖ → 0` (`‖g‖ ≤ δ + ‖g‖²/δ`); the bound by `‖(c − 1)P‖² ≤ 2‖(c − 1)1_A‖² + 8‖P − 1_A‖²` and `le_of_tendsto_of_tendsto'` | `Finsupp.mapDomain_mapRange`, `Finsupp.linearCombination_mapDomain`, `integral_indicator`, `Lp.isometry_compMeasurePreserving` | **the assembly of step (d)** — resolved | **scratch, elaborated over the four leaves above**: 156 + 85 of helpers (`SpectralVector.lean`) |
| `spectral_null_of_orthogonal` | `exists_spectral_vector`; `w ∈ contVec l`: `‖V_z w − w‖ ≤ (2∫_A|χ z − 1|²)^{1/2} → 0` by `tendsto_integral_filter_of_dominated_convergence` (bound `4`, each `χ ∈ A` tends to `1` by `hAl`); then `horth w` gives `σ.real A = 0` | `tendsto_integral_filter_of_dominated_convergence` | none | 40–60 |
| `isSpectralMeasureOf_condExpL2` | `σ_h`, `σ_r` exist; `σ = σ_h + σ_r` (`add_of_orthogonal` with `condExpL2_mem_contVec`, `inner_sub_condExpL2_eq_zero`, uniqueness; `f = h + (f − h)`); `σ_h((contChars t)ᶜ) = 0` (`spectral_carried_iff`, ⟸); `σ_r(contChars t) = 0` (`spectral_contChars_null_of_orthogonal`); restrict | `Measure.restrict_add`, `Measure.restrict_eq_self_of_ae_mem` | none | 50–80 |
| `spectral_null_model` | `T n x = x + (n : Fin 2)` on `Fin 2` with `Measure.count`; `f = 1_{0} − ½`; `σ = ½ δ_{χ₋}`, `χ₋ n = (−1)ⁿ` (an `AddChar ℤ Circle` from `zmultiplesHom` or `AddChar.ofInt`); `contVec ⊤` are the invariant vectors, here the constants | `Measure.count`, `AddChar` on `ℤ` | building `χ₋` and computing in `Lp` of a two-point space | 80–140 |

**M11a: about 900–1,100 lines, of which about 420 are written and elaborate.**

### 3.2 M11b — `Rigidity/TraceSplit` (lane T)

| leaf | route | names | hard part | price |
|---|---|---|---|---|
| `integral_colourInd_mul_comp` | `Lp.coeFn_compMeasurePreserving`, `indicatorConstLp_coeFn`; product of indicators is the indicator of the intersection; `hequiv` moves `κ (T y ω) 0` to `κ ω y` | `integral_indicator_one`-type, `Measure.real` | ae bookkeeping | 30–50 |
| `three_mul_tetra_add_one` | **proved** in the skeleton (`split_ifs; norm_num`) | — | — | 4 |
| `trace_decomp` | coefficient at `y`: `3 corr(y) + 1 = 4 μ(κ0 = κy) = 4 Σ_j μ(κ0 = j, κy = j)` (`three_mul_tetra_add_one`, `integral_map`, a sum over `Fin 4` of indicators); then `measure_eq_of_fourier` | `integral_map`, `Measure.integral_smul_nat`-type, `integral_finset_sum_measure` (`integral_finsetSum_measure` at the pin) | the `ℕ`-smul of measures against integrals | 60–100 |
| `condLaw_comp_colourShift` | `condExp_comp_measurePreserving` with `comap_factorSigma_eq_of_action` (`colourShift_add`, `colourShift_zero`); the indicator of `{c (x) = j}` composed with `shift_y` is that of `{c (x + y) = j}` | as named | none | 20–30 |
| `inner_colourInd_comp_unit` | `integral_colourInd_mul_comp` at `κ = id`; `{c 0 = j ∧ c u = j} ⊆ (X₄)ᶜ`, `μ.carried` | `measure_mono_null` | none | 20–30 |
| `colourCond_ae_eq_condLaw` | `MemLp.condExpL2_ae_eq_condExp` on the indicator | as named | the `indicatorConstLp` / `MemLp.toLp` match (`indicatorConstLp_coeFn`, `Lp.ext`) | 15–30 |
| `integral_colourCond_mul_comp` | `colourCond_ae_eq_condLaw`, `Lp.coeFn_compMeasurePreserving`, `condLaw_comp_colourShift` at `x = 0` | as named | none | 25–40 |
| `setIntegral_compl_TA_re` | `σ_j` (`exists_isSpectralMeasureOf`); `trace_decomp` at `κ = id`; `isSpectralMeasureOf_condExpL2` at `tauPrime F` (with `contChars_tauPrime`, `isTopologicalAddGroup_tauPrime`, `isCountablyGenerated_nhds_tauPrime`, `bochnerOn_tauPrime`, `measurableSet_TA`); restrict `3σ + δ₁ = 4Σσ_j` to `(TA F)ᶜ` (`δ₁((TA F)ᶜ) = 0`, `one_mem_TA`); `∫ χ(u) dσ_{r_j} = ⟨e_j, V_u e_j⟩ − ⟨Πe_j, V_u Πe_j⟩` from the two restrictions' coefficients; `inner_colourInd_comp_unit`, `integral_colourCond_mul_comp`; take real parts | `setIntegral_eq_integral_of_forall_compl_eq_zero`-type, `integral_re` | the composition's length | 100–160 |
| `setIntegral_compl_TA_rot` | `rotInv_of_isTraceSpectral (bochnerHerglotz_of_countable _)`; `setIntegral_map` with `rot_preimage_TA` (complement) and `rot_apply`; `uvRing u * 1 = uvRing u` | `setIntegral_map`, `Measure.restrict_map` | none | 30–50 |

**M11b: about 350–500 lines.**

### 3.3 M11c — `Rigidity/APlus` (lane A)

| leaf | route | names | hard part | price |
|---|---|---|---|---|
| `tendsto_mul_nhds_tauPrime` | `tauPrime = profTop ⊓ archTop`: `nhds_inf`; on `profTop`, `nhds_iInf` and `nhds_induced`, `r · (N+1)R ⊆ (N+1)R`; on `archTop`, `archHom (r y) = mixedEmbedding r * archHom y` (`map_mul`) and `continuous_mul_left` on the mixed space. M10's helpers `mem_nhds_profTop`, `eventually_archTop`, `archHom` are **private** there: reprove here (about 40 lines), or `open private … from Proofs.HadwigerNelson.Rigidity.ContinuityGroup` (Batteries; `LEAN.md` § Searching) | `nhds_inf`, `nhds_iInf`, `nhds_induced`, `map_mul` | the private helpers | 60–110 |
| `comap_colourRot_colourFactor` | `measurableSet_factorSigma_iff`, `mem_factorSets_iff` (`μ(T_y⁻¹ A ∆ A) → 0`); `colourShift y ∘ colourRot u = colourRot u ∘ colourShift (u y)`; `measure_preimage` of `colourRot u`; `tendsto_mul_nhds_tauPrime` composed; both inclusions, the second through `ū` (`rot_conj_rot`'s computation, private in `ChainAtTA`: restate) | as named | none | 50–80 |
| `factorColouring_shift_ae` | `si4_equivariant_factorSigma` with `hcomm` from `colourShift_add`, `hinv : colourShift (−y) ∘ colourShift y = id`, `π v = v + y`; `funext` under the `ae` | as named | none | 20–30 |
| `factorColouring_rot_ae` | `si4_equivariant` with `comap_colourRot_colourFactor`, `μ.measurePreserving_rot`, `π v = uvRing u * v` | as named | none | 20–30 |
| `integral_condLaw_mul_eq_zero_of_adj` | `⟨y − x, hxy⟩ : unitVectors F`, `uvRing` of it `= y − x`; `condLaw_comp_colourShift` twice; `integral_map` of the measure-preserving shift | as named | none | 30–50 |
| `factorColouring_mem_X4` | `si4` with `adj x y := (y : ℂ) − x ∈ unitVectors F`, `hdisj` from the leaf above, `f = minSel`, `hf = minSel_mem` | `si4` | none | 15–25 |
| `factorLaw_carried` | `Measure.map_apply` with `measurableSet_X4` (countability), `measure_eq_zero_iff_ae_notMem` | as named | none | 10–20 |
| `factorLaw_shift_inv`, `factorLaw_rot_inv` | `Measure.map_map`, `Measure.map_congr` with the two `_ae` lemmas, then `μ.shift_inv`, `μ.rot_inv` | as named | none | 20–30 each |
| `factorLaw_trace_null` | `trace_decomp` at `κ = factorColouring μ` (`hequiv` from `factorColouring_shift_ae` at `0`, `zero_add`); each `e″_j` is `𝒜`-measurable (`measurable_factorColouring_apply`), so in `lpMeas` (`mem_lpMeas_indicatorConstLp`), so in `contVec` (`contVec_eq_lpMeas`), so `σ″_j((TA F)ᶜ) = 0` (`spectral_carried_iff` ⟸, `contChars_tauPrime`); evaluate `3σ′ + δ₁ = 4Σσ″_j` at `(TA F)ᶜ` | `mem_lpMeas_indicatorConstLp` | none | 50–80 |
| `equalAtUnits_of_not_neg` | `setIntegral_compl_TA_re_nonpos` at `1` gives `= 0`; `setIntegral_compl_TA_rot` gives `= 0` at every `u`; `setIntegral_compl_TA_re` and `integral_condLaw_mul_nonneg`: a sum of nonnegatives that is `0` (`Finset.sum_eq_zero_iff_of_nonneg`) | as named | `uvRing ⟨1, _⟩ = 1` | 30–50 |
| `numberField_bot` | `⊥ = (algebraMap ℚ ℝ).fieldRange` (`Subfield.bot_eq_of_charZero`-type, or `mem_bot`); `Module.Finite ℚ ⊥` from a surjection `ℚ → ⊥` (`Module.Finite.of_surjective`) | `Module.Finite.of_surjective` | finding the `⊥` characterization | 15–30 |
| `aPlusOfR88`, `nonempty_invariantColouring_bot`, `aplus_model`, `minSel_mem`, `factorLaw_isProb`, `measurable_factorColouring(_apply)` | **proved in the skeleton** (compositions) | — | — | — |

**M11c: about 350–550 lines.**

### 3.4 Classical inputs, each searched for by name at the pin; formalize or declare

| input | where | status |
|---|---|---|
| Stone–Weierstrass, complex star subalgebras | `ContinuousMap.starSubalgebra_topologicalClosure_eq_top_of_separatesPoints` | Mathlib; used in the scratch proof |
| density of continuous functions in `Lᵖ` of a weakly regular finite measure | `ContinuousMap.toLp_denseRange` | Mathlib; used |
| weak regularity of finite measures on pseudometrizable spaces | `Measure.WeaklyRegular.of_pseudoMetrizableSpace_of_isFiniteMeasure` (a theorem, `haveI`) | Mathlib; used |
| completeness of `L²`; dominated convergence along a countably generated filter | instances; `tendsto_integral_filter_of_dominated_convergence` | Mathlib |
| `E[· | 𝒜]` in `L²` is the conditional expectation | `MemLp.condExpL2_ae_eq_condExp` | Mathlib |
| Herglotz–Bochner on a countable group; Fourier uniqueness | `bochnerHerglotz_of_countable` (M2a), `measure_eq_of_fourier` (M4) | this library, standard three |
| Bochner for `τ′_∅` | `bochnerOn_tauPrime` (M2b) | this library, typed, being proved |

**No axiom is declared, and none is needed.** `[Rudin1962]` 1.4.3 is not read by any M11 proof (M2b's route avoids it).
