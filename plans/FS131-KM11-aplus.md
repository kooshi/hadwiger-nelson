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
