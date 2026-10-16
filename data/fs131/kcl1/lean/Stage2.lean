import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed

/-!
FS131-KCL1, stage 2 (scratch; iteration only, never evidence that a module is green).

Row 128's derivation uses MR(F) at exactly one step (V1 § Stage 2a, Theorem V1-LB's last sentence; V2 § Stage 2b,
C-635-F1): an SP witness (D-SP) is excluded. Here: `MRPlus F` excludes every SP witness at every `E ⊇ T + A`, and it
implies row 120's literal form (a multiple of Haar measure) at every such `E`.
-/

namespace HadwigerNelson.Rigidity.KCL1Scratch

open MeasureTheory SpectralChain SpectralInputs

variable (F : Subfield ℝ)

/-- D-SP (`plans/FS100-BC-verification.md` § 1.2, as `data/fs103/claims.md` § 0 quotes it): "a finite positive
`U`-invariant Borel measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0`" — at a set `E` of characters. -/
def IsSPWitness (E : Set (Dual F)) (τ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure τ ∧ RotInv F τ ∧ τ E = 0 ∧ ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ < 0

/-- D-MR (`LEDGER.md` row 120), its literal form: every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is
a multiple of Haar measure. -/
def MRLiteral [Countable (unitRing F)] (E : Set (Dual F)) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ E = 0 → τ = τ Set.univ • dualHaar (unitRing F)

variable {F}

/-- **MR⁺ excludes every SP witness at every `E ⊇ T + A`** — the one use of MR in row 128's derivation. -/
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

/-- **MR⁺ gives row 120's literal MR(F) at every `E ⊇ T + A`**: such a `τ` is its mass times Haar measure (Fourier
uniqueness, `measure_eq_of_fourier`). -/
theorem mrLiteral_of_mrPlus [Countable (unitRing F)] (h : MRPlus F) {E : Set (Dual F)} (hE : TA F ⊆ E) :
    MRLiteral F E := by
  intro τ hfin hrot hτE
  haveI := hfin
  haveI : IsFiniteMeasure (τ Set.univ • dualHaar (unitRing F)) :=
    ⟨by rw [Measure.smul_apply, smul_eq_mul]; exact ENNReal.mul_lt_top (measure_lt_top τ _) (measure_lt_top _ _)⟩
  refine measure_eq_of_fourier fun r => ?_
  by_cases hr : r = 0
  · subst hr
    simp [AddChar.map_zero_eq_one, Measure.real]
  · rw [h τ hfin hrot (measure_mono_null hE hτE) r hr, integral_smul_measure,
      (isHaarFourier_dualHaar (unitRing F)).2 r hr, smul_zero]

/-- **The answer at every real number field**: no SP witness exists at any `E ⊇ T + A`, on the library's `mrPlus`. -/
theorem not_isSPWitness [NumberField F] {E : Set (Dual F)} (hE : TA F ⊆ E) (τ : Measure (Dual F)) :
    ¬ IsSPWitness F E τ :=
  not_isSPWitness_of_mrPlus (mrPlus F) hE τ

/-- **Row 120's literal MR at every real number field**, at every `E ⊇ T + A`. -/
theorem mrLiteral [NumberField F] {E : Set (Dual F)} (hE : TA F ⊆ E) :
    haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
    haveI : Countable (unitRing F) := countable_unitRing
    MRLiteral F E :=
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  mrLiteral_of_mrPlus (mrPlus F) hE

/-- Spec: at `E = T + A` itself. -/
example [NumberField F] (τ : Measure (Dual F)) : ¬ IsSPWitness F (TA F) τ := not_isSPWitness subset_rfl τ

end HadwigerNelson.Rigidity.KCL1Scratch

#print axioms HadwigerNelson.Rigidity.KCL1Scratch.not_isSPWitness
#print axioms HadwigerNelson.Rigidity.KCL1Scratch.mrLiteral_of_mrPlus
#print axioms HadwigerNelson.Rigidity.KCL1Scratch.mrLiteral
