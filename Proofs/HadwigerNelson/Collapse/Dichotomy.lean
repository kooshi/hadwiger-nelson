import Proofs.HadwigerNelson.Collapse.Colouring
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed

/-!
# The dichotomy at `T + A`, closed by MR⁺: an invariant `k`-colouring with its spectrum on `T + A` (FS-131, job FS131-KCL1; module C3)

**Read aloud, against the informal claim** (V1-L1–L3, `plans/FS103-V1-verification.md` ll. 101–124; V2 Step 2, ll. 116–122; the
one use of MR in `LEDGER.md` row 128's derivation, `plans/FS131-KCL1-collapse-plan.md` § 2.1). For an invariant random proper
`k`-colouring `μ` of `Cay(R, U)`:

* **the colour spectral measure** `σ` (`IsColourSpectral`): `∫ χ(y) dσ = P(c(0) = c(y))` — the sum over the colours `j` of
  the spectral measures of the indicators `1{c(0) = j}`. It is finite, of mass `1`, rotation-invariant
  (`IsColourSpectral.rotInv`), and `∫ χ(u) dσ = 0` at every unit vector (`IsColourSpectral.integral_unit`: the colouring is
  proper). It replaces the derivation's simplex measure; the constants `k/(k − 1)` never appear.
* **SI-3 at `T + A`** (`setIntegral_compl_TA_re_k`): `∫_{R̂∖(T+A)} Re χ(u) dσ = −Σ_j E[p_j(0) p_j(u)]` with
  `p_j(x) = P(c(x) = j | 𝒜)` and `𝒜` the factor of the `τ′_∅`-continuous vectors; each term is `≥ 0`, and the left side does
  not depend on `u` (`setIntegral_compl_TA_rot_k`).
* **the SP witness** (`IsSPWitness`, D-SP at a set `E`) and **its exclusion by MR⁺** (`not_isSPWitness_of_mrPlus`, proved:
  stage 2 of the record), at every real number field (`not_isSPWitness`, on `Rigidity.mrPlus`).
* **the factor colouring** (`exists_factorLawK`, SI-4 with `APlus`'s factor): if `Σ_j E[p_j(0) p_j(u)] = 0` at every `u`, the
  least colour of the conditional support is an invariant proper `k`-colouring whose colour spectral measures are carried by
  `T + A`.
* **`exists_invColouring_TA`**: so every invariant `k`-colouring has a sibling with its spectrum on `T + A` — case (B) of the
  load-bearing step is empty.

**Route** (record § 3.1, L1–L3). The four-colour proofs (`Rigidity/TraceSplit`, `Rigidity/APlus`, SI-4 in
`Arith/SpectralInputs`) at `Fin k`, on the colour spectral measure; `Rigidity.isSpectralMeasureOf_condExpL2` at `tauPrime F`,
`contChars_tauPrime`, `bochnerOn_tauPrime` are read as they are.

**Models.** `InvColouring ⊥ 2` is inhabited (`Collapse.nonempty_invColouring_bot`), and every `InvColouring` has a colour
spectral measure (`exists_isColourSpectral`). `IsSPWitness F E τ` is empty at every `E ⊇ T + A` over a number field: that is
the theorem (`not_isSPWitness`); `not_isSPWitness_of_mrPlus` reads `MRPlus F`, whose models are `Rigidity/ChainAtTA`'s.
`EqualAtUnitsK` holds at the model over `ℚ` with its residue two-colouring, whose spectrum is torsion, so in `T + A`.
-/

namespace HadwigerNelson.Collapse

open SpectralChain SpectralInputs MeasureTheory NumberField Rigidity Filter Topology

noncomputable section

/-! ## The SP witness and MR⁺ (stage 2) -/

section Witness

variable (F : Subfield ℝ)

/-- **D-SP** (`plans/FS100-BC-verification.md` § 1.2, as `data/fs103/claims.md` § 0 quotes it): "a finite positive
`U`-invariant Borel measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0`" — at a set `E` of characters. -/
def IsSPWitness (E : Set (Dual F)) (τ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure τ ∧ RotInv F τ ∧ τ E = 0 ∧ ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ < 0

variable {F}

/-- **MR⁺ excludes every SP witness at every `E ⊇ T + A`** — the one use of MR in row 128's derivation (V1 l. 176). -/
theorem not_isSPWitness_of_mrPlus (h : MRPlus F) {E : Set (Dual F)} (hE : TA F ⊆ E) (τ : Measure (Dual F)) :
    ¬ IsSPWitness F E τ := by
  rintro ⟨hfin, hrot, hτE, hneg⟩
  have hTA : τ (TA F) = 0 := measure_mono_null hE hτE
  have h1 : ∫ χ, ((χ 1 : Circle) : ℂ) ∂τ = 0 := h τ hfin hrot hTA 1 one_ne_zero
  have hint : Integrable (fun χ : Dual F => ((χ 1 : Circle) : ℂ)) τ :=
    Integrable.of_bound (measurable_evalChar (1 : unitRing F)).aestronglyMeasurable 1
      (Filter.Eventually.of_forall fun χ => by rw [Circle.norm_coe])
  have hre : ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ = 0 := by
    have h2 := integral_re (𝕜 := ℂ) hint
    simp only [RCLike.re_to_complex] at h2
    rw [h2, h1, Complex.zero_re]
  rw [hre] at hneg
  exact lt_irrefl 0 hneg

/-- **No SP witness at any `E ⊇ T + A`, over every real number field** — on `Rigidity.mrPlus`, so on
`[EinsiedlerLindenstrauss2022]` Thm 1.3 (`Rigidity.positive_entropy_rigidity`). -/
theorem not_isSPWitness [NumberField F] {E : Set (Dual F)} (hE : TA F ⊆ E) (τ : Measure (Dual F)) :
    ¬ IsSPWitness F E τ :=
  not_isSPWitness_of_mrPlus (mrPlus F) hE τ

end Witness

/-! ## The colour spectral measure -/

variable {F : Subfield ℝ} {k : ℕ}

/-- **The shift of a `k`-colouring** by `y ∈ R`: `c ↦ c(· + y)`. -/
def colourShiftK (y : unitRing F) (c : unitRing F → Fin k) : unitRing F → Fin k := fun x => c (x + y)

theorem measurable_colourShiftK (y : unitRing F) : Measurable (colourShiftK (k := k) y) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

/-- The shifts are an action of `R`. -/
theorem colourShiftK_add (x y : unitRing F) :
    colourShiftK (k := k) (x + y) = colourShiftK x ∘ colourShiftK y := by
  funext c z
  simp only [colourShiftK, Function.comp_apply, add_assoc]

/-- Each shift preserves the law of an invariant colouring. -/
theorem InvColouring.measurePreserving_shift (μ : InvColouring F k) (y : unitRing F) :
    MeasurePreserving (colourShiftK y) μ.μ μ.μ :=
  ⟨measurable_colourShiftK y, μ.shift_inv y⟩

/-- **`𝒜`, the factor of the `τ′_∅`-continuous vectors** of an invariant `k`-colouring (the four-colour
`Rigidity.colourFactor` at `Fin k`). -/
abbrev factorK [NumberField F] (μ : InvColouring F k) : MeasurableSpace (unitRing F → Fin k) :=
  haveI := μ.isProb
  factorSigma (colourShiftK (F := F) (k := k)) μ.measurePreserving_shift (@nhds _ (tauPrime F) 0)

/-- **The conditional law of the colour at `x`**: `p_j(x) = P(c(x) = j | 𝒜)` (SpectralInputs' `condLaw` at `Fin k`). -/
def condLawK {Ω V : Type*} (𝒜 : MeasurableSpace Ω) [MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin k) (x : V)
    (j : Fin k) : Ω → ℝ :=
  μ[(Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) | 𝒜]

/-- **The colour spectral measure** of a random colouring: `∫ χ(y) dσ = P(c(0) = c(y))` for every `y ∈ R` — the sum over the
colours of the spectral measures of the indicators `1{c(0) = j}`. -/
def IsColourSpectral (μ : Measure (unitRing F → Fin k)) (σ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure σ ∧ ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂σ = ((μ.real {c | c 0 = c y} : ℝ) : ℂ)

/-- **Every invariant colouring has a colour spectral measure** (Herglotz–Bochner on the countable `R`, per colour:
`Rigidity.exists_isSpectralMeasureOf` for each indicator, summed). -/
theorem exists_isColourSpectral [NumberField F] (μ : InvColouring F k) : ∃ σ : Measure (Dual F), IsColourSpectral μ.μ σ := by
  sorry

/-- **It is rotation-invariant** (node L3 at `k` colours): the law is, so `P(c(0) = c(uy)) = P(c(0) = c(y))`, and Fourier
uniqueness (`Rigidity.measure_eq_of_fourier`). -/
theorem IsColourSpectral.rotInv [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) : RotInv F σ := by
  sorry

/-- **At a unit vector its coefficient is `0`**: the colouring is proper, `P(c(0) = c(u)) = 0`. -/
theorem IsColourSpectral.integral_unit (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (u : unitVectors F) : ∫ χ, (χ (uvRing u) : ℂ) ∂σ = 0 := by
  sorry

/-- The restriction of a rotation-invariant measure to the complement of `T + A` is rotation-invariant (`T + A` is). -/
theorem rotInv_restrict_compl_TA [NumberField F] {σ : Measure (Dual F)} (hσ : RotInv F σ) :
    RotInv F (σ.restrict (TA F)ᶜ) := by
  intro u
  have hpre : rot u ⁻¹' (TA F)ᶜ = (TA F)ᶜ := by rw [Set.preimage_compl, rot_preimage_TA F u]
  conv_lhs => rw [← hpre]
  rw [← Measure.restrict_map (measurable_rot u) (measurableSet_TA F).compl, hσ u]

/-! ## SI-3 at `T + A`, and the factor colouring -/

/-- **SI-3 at `T + A`, at `k` colours** (the four-colour `Rigidity.setIntegral_compl_TA_re` on the colour spectral measure):
`∫_{R̂∖(T+A)} Re χ(u) dσ = −Σ_j E[p_j(0) p_j(u)]`. Route: `σ = Σ_j σ_{e_j}`, and off `T + A` each `σ_{e_j}` is the spectral
measure of `e_j − E[e_j | 𝒜]` (`Rigidity.isSpectralMeasureOf_condExpL2` at `tauPrime F`, whose continuous characters are
`T + A`); its coefficient at `u` is `⟨e_j, V_u e_j⟩ − ⟨Πe_j, V_u Πe_j⟩ = 0 − E[p_j(0) p_j(u)]`. -/
theorem setIntegral_compl_TA_re_k [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ =
      -∑ j : Fin k, ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
        condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ := by
  sorry

/-- Each term of SI-3 is non-negative (`E[p_j(0) p_j(y)] ≥ 0`: the conditional laws are). -/
theorem integral_condLawK_mul_nonneg [NumberField F] (μ : InvColouring F k) (x y : unitRing F) (j : Fin k) :
    0 ≤ ∫ c, condLawK (factorK μ) μ.μ (fun c => c) x j c * condLawK (factorK μ) μ.μ (fun c => c) y j c ∂μ.μ := by
  sorry

/-- **Remark (ii)**: the integral off `T + A` is the same at every unit vector (`σ` and `T + A` are rotation-invariant). -/
theorem setIntegral_compl_TA_rot_k [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ := by
  sorry

/-- **The conditional laws are orthogonal across every unit vector** — the hypothesis of the factor colouring. -/
def EqualAtUnitsK [NumberField F] (μ : InvColouring F k) : Prop :=
  ∀ (u : unitVectors F) (j : Fin k), ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
    condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ = 0

/-- **If the integral off `T + A` is not negative, the conditional laws are orthogonal across every edge** (SI-3, remark (ii)
and the non-negative terms; the four-colour `Rigidity.equalAtUnits_of_not_neg`). -/
theorem equalAtUnitsK_of_not_neg [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) (h : ¬ ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0) : EqualAtUnitsK μ := by
  sorry

/-- **The factor colouring** (SI-4 and `APlus`'s factor at `Fin k`): when the conditional laws are orthogonal across every
edge, the least colour of the conditional support, `c′ = min ∘ M`, is `𝒜`-measurable, almost surely proper and equivariant;
its law is an invariant colouring, and its colour spectral measures are carried by `T + A` (each `1{c′(0) = j}` is
`𝒜`-measurable, so its spectral measure is, `Rigidity.spectral_carried_iff`). -/
theorem exists_factorLawK [NumberField F] (μ : InvColouring F k) (h : EqualAtUnitsK μ) :
    ∃ μ' : InvColouring F k, ∀ σ' : Measure (Dual F), IsColourSpectral μ'.μ σ' → σ' (TA F)ᶜ = 0 := by
  sorry

/-- **Case (B) is empty: an invariant `k`-colouring has a sibling with its spectrum on `T + A`** — over every real number
field. If `∫_{R̂∖(T+A)} Re χ(1) dσ < 0`, then `σ|_{R̂∖(T+A)}` is an SP witness at `E = T + A` (finite, rotation-invariant,
`(T + A)`-null by construction — no R-U), which MR⁺ excludes; otherwise the factor colouring. -/
theorem exists_invColouring_TA [NumberField F] (μ : InvColouring F k) :
    ∃ μ' : InvColouring F k, ∀ σ' : Measure (Dual F), IsColourSpectral μ'.μ σ' → σ' (TA F)ᶜ = 0 := by
  obtain ⟨σ, hσ⟩ := exists_isColourSpectral μ
  haveI := hσ.1
  by_cases hneg : ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0
  · exfalso
    refine not_isSPWitness (F := F) subset_rfl (σ.restrict (TA F)ᶜ) ⟨inferInstance, rotInv_restrict_compl_TA
      (hσ.rotInv μ), ?_, hneg⟩
    rw [Measure.restrict_apply (measurableSet_TA F), Set.inter_compl_self, measure_empty]
  · exact exists_factorLawK μ (equalAtUnitsK_of_not_neg μ hσ hneg)

/-! ## Spec -/

-- the shift moves the colouring by `+ y` at every point.
example (y x : unitRing F) (c : unitRing F → Fin k) : colourShiftK y c x = c (x + y) := rfl

-- the witness's four clauses, in D-SP's order.
example (E : Set (Dual F)) (τ : MeasureTheory.Measure (Dual F)) :
    IsSPWitness F E τ ↔ IsFiniteMeasure τ ∧ RotInv F τ ∧ τ E = 0 ∧ ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ < 0 := Iff.rfl

end

end HadwigerNelson.Collapse
