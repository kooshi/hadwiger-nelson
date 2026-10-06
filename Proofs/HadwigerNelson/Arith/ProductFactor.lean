import Proofs.HadwigerNelson.Arith.SpectralInputs
import Mathlib.Probability.Independence.Basic

/-!
# The factor of an independent product (J45-SI-J), at the class its argument reads (FS-131 wave 10, second planning pass)

**Read aloud, against the informal claim.** J45-SI-J: "the `E_S`-factor of an independent product of a finite translation
system, a Bernoulli process and `c₂` is `σ(Φ) ∨ 𝒜_S(c₂)`". The `E_S`-factor is the factor of a filter
(`SpectralInputs.factorSigma`, at `l = 𝓝 0` for `τ′_S`), and **the argument reads no spectral measure**: for *any* filter
`l` on the index group that is not eventually inside a finite set,

* a finite system whose maps are eventually the identity along `l` is fixed along `l`;
* a process with independent coordinates indexed by `R` and shifted by the maps has no `l`-continuous vector beyond the
  constants, even in a product: a cylinder `F′ ∈ L²(·) ⊗ L²₀(noise)` on a finite set `A` of coordinates has
  `⟨V_y F′, F′⟩ = 0` once `A + y` misses `A`, so `‖V_y F′ − F′‖² = 2‖F′‖²` frequently along `l`.

So the `l`-continuous vectors of the product are `L²` of `σ(first coordinate) ∨ 𝒜_l(second system)`
(`contVec_prod_eq`). The row's route — Bernoulli shifts have Lebesgue spectrum, spectral measures of independent tensors
convolve, `Haar(E_S) = 0` — is not used; J45-N1 (c) is no longer an input of SI-J. At `E_S` the hypothesis on `l` is
"`τ′_S` is T₁ and not discrete" (J45-N1 (b)'s content), and "eventually the identity" is "the finite quotient's kernel is
`τ′_S`-open" (true by the definition of `τ′_S`, whose profinite component makes every subgroup of finite index open).

* `preimage_mem_factorSets`, `comap_factorSigma_le` (proved): the factor of a factor system pulls back into the factor of
  the extension — SI-J's last sentence, "a spectral measure does not depend on the ambient system", with no spectral
  measure.
* `contVec_prod_eq` (the leaf): J45-SI-J.

**Inhabitants.** `prodMap₃` of three identity families is the identity family; with `l = ⊥` every hypothesis on `l` but
`hl` holds and `hl` fails (the empty filter is eventually everywhere), so the model the row names is the honest one:
`Φ` a uniform translate on a finite group, fair bits on `R → Bool` (`Measure.infinitePi`), `l` the cofinite filter on an
infinite `R` — not built here; the docstring of `contVec_prod_eq` says what it must satisfy.
-/

namespace HadwigerNelson.SpectralInputs

open MeasureTheory

section FactorOfFactor

variable {R Ω Ω' : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω'] {μ : Measure Ω} {μ' : Measure Ω'}

/-- **The factor of a factor system pulls back into the factor of the extension**: for a measure-preserving `π` that
intertwines the two families, the preimage of an event with `l`-continuous indicator has `l`-continuous indicator. -/
theorem preimage_mem_factorSets [IsFiniteMeasure μ] [IsFiniteMeasure μ'] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (T' : R → Ω' → Ω') (hT' : ∀ y, MeasurePreserving (T' y) μ' μ')
    (l : Filter R) {π : Ω → Ω'} (hπ : MeasurePreserving π μ μ') (hequiv : ∀ y, π ∘ T y = T' y ∘ π) {A : Set Ω'}
    (hA : A ∈ factorSets T' hT' l) : π ⁻¹' A ∈ factorSets T hT l := by
  obtain ⟨hAm, h⟩ := (mem_factorSets_iff T' hT' l).mp hA
  refine (mem_factorSets_iff T hT l).mpr ⟨hAm.preimage hπ.measurable, ?_⟩
  have key : ∀ y, μ (symmDiff (T y ⁻¹' (π ⁻¹' A)) (π ⁻¹' A)) = μ' (symmDiff (T' y ⁻¹' A) A) := by
    intro y
    have e1 : T y ⁻¹' (π ⁻¹' A) = π ⁻¹' (T' y ⁻¹' A) := by
      rw [← Set.preimage_comp, ← Set.preimage_comp, hequiv y]
    have e : symmDiff (T y ⁻¹' (π ⁻¹' A)) (π ⁻¹' A) = π ⁻¹' (symmDiff (T' y ⁻¹' A) A) := by
      rw [e1]
      rfl
    rw [e, hπ.measure_preimage ((hAm.preimage (hT' y).measurable).symmDiff hAm).nullMeasurableSet]
  simpa only [key] using h

/-- The same on the σ-algebras: `π⁻¹(𝒜_l') ≤ 𝒜_l`. -/
theorem comap_factorSigma_le [IsProbabilityMeasure μ] [IsProbabilityMeasure μ'] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (T' : R → Ω' → Ω') (hT' : ∀ y, MeasurePreserving (T' y) μ' μ')
    (l : Filter R) {π : Ω → Ω'} (hπ : MeasurePreserving π μ μ') (hequiv : ∀ y, π ∘ T y = T' y ∘ π) :
    (factorSigma T' hT' l).comap π ≤ factorSigma T hT l := by
  intro B hB
  obtain ⟨A, hA, rfl⟩ := MeasurableSpace.measurableSet_comap.mp hB
  rw [measurableSet_factorSigma_iff] at hA ⊢
  exact preimage_mem_factorSets T hT T' hT' l hπ hequiv hA

end FactorOfFactor

section Product

variable {R : Type*} {Ω₁ Ω₂ Ω₃ : Type*} [MeasurableSpace Ω₁] [MeasurableSpace Ω₂] [MeasurableSpace Ω₃]
  {μ₁ : Measure Ω₁} {μ₂ : Measure Ω₂} {μ₃ : Measure Ω₃}

/-- The product of three families of maps, acting diagonally on `Ω₁ × Ω₂ × Ω₃`. -/
def prodMap₃ (T₁ : R → Ω₁ → Ω₁) (T₂ : R → Ω₂ → Ω₂) (T₃ : R → Ω₃ → Ω₃) (y : R) :
    Ω₁ × Ω₂ × Ω₃ → Ω₁ × Ω₂ × Ω₃ :=
  Prod.map (T₁ y) (Prod.map (T₂ y) (T₃ y))

/-- The diagonal family preserves the product measure. -/
theorem measurePreserving_prodMap₃ [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂] [IsProbabilityMeasure μ₃]
    {T₁ : R → Ω₁ → Ω₁} {T₂ : R → Ω₂ → Ω₂} {T₃ : R → Ω₃ → Ω₃} (hT₁ : ∀ y, MeasurePreserving (T₁ y) μ₁ μ₁)
    (hT₂ : ∀ y, MeasurePreserving (T₂ y) μ₂ μ₂) (hT₃ : ∀ y, MeasurePreserving (T₃ y) μ₃ μ₃) (y : R) :
    MeasurePreserving (prodMap₃ T₁ T₂ T₃ y) (μ₁.prod (μ₂.prod μ₃)) (μ₁.prod (μ₂.prod μ₃)) :=
  (hT₁ y).prod ((hT₂ y).prod (hT₃ y))

/-- **`σ(Φ) ∨ 𝒜_l(c₂)`** on the product: the first coordinate's σ-algebra joined with the pull-back of the second
system's `l`-factor. -/
@[reducible] def prodFactorSigma [IsProbabilityMeasure μ₂] (T₂ : R → Ω₂ → Ω₂) (hT₂ : ∀ y, MeasurePreserving (T₂ y) μ₂ μ₂)
    (l : Filter R) : MeasurableSpace (Ω₁ × Ω₂ × Ω₃) :=
  MeasurableSpace.comap (fun ω : Ω₁ × Ω₂ × Ω₃ => ω.1) inferInstance ⊔
    MeasurableSpace.comap (fun ω : Ω₁ × Ω₂ × Ω₃ => ω.2.1) (factorSigma T₂ hT₂ l)

/-- **J45-SI-J, at the class its argument reads**: "the `E_S`-factor of an independent product of a finite translation
system, a Bernoulli process and `c₂` is `σ(Φ) ∨ 𝒜_S(c₂)`". For a finite discrete system `Ω₁` whose maps are eventually the
identity along `l`, any system `Ω₂`, and a system `Ω₃` whose σ-algebra is generated by independent coordinates `ε x`
(`x ∈ R`) that the maps shift (`ε x ∘ T₃ y = ε (x + y)`): if `l` is not eventually inside a finite set, the `l`-continuous
vectors of the product system are exactly the vectors of `L²` measurable for `σ(Φ) ∨ 𝒜_l(c₂)`. With
`SpectralInputs.contVec_eq_lpMeas` this says the two σ-algebras agree up to null sets. Identical distribution of the
coordinates is not read. MODEL: `Ω₁` a finite group with its uniform measure and translations through a homomorphism
`R → Ω₁` with kernel in `l`; `Ω₃ = R → Bool` under `Measure.infinitePi` of fair coins with the shift; `l` the
neighbourhoods of `0` for a T₁ group topology that is not discrete. -/
theorem contVec_prod_eq [AddCommGroup R] [Finite Ω₁] [MeasurableSingletonClass Ω₁] [IsProbabilityMeasure μ₁]
    [IsProbabilityMeasure μ₂] [IsProbabilityMeasure μ₃] {T₁ : R → Ω₁ → Ω₁} {T₂ : R → Ω₂ → Ω₂} {T₃ : R → Ω₃ → Ω₃}
    (hT₁ : ∀ y, MeasurePreserving (T₁ y) μ₁ μ₁) (hT₂ : ∀ y, MeasurePreserving (T₂ y) μ₂ μ₂)
    (hT₃ : ∀ y, MeasurePreserving (T₃ y) μ₃ μ₃) (l : Filter R) (h₁ : ∀ᶠ y in l, T₁ y = id)
    {B : Type*} [MeasurableSpace B] (ε : R → Ω₃ → B) (hε : ∀ x, Measurable (ε x))
    (hgen : ‹MeasurableSpace Ω₃› = ⨆ x, MeasurableSpace.comap (ε x) inferInstance)
    (hind : ProbabilityTheory.iIndepFun ε μ₃) (hshift : ∀ y x ω, ε x (T₃ y ω) = ε (x + y) ω)
    (hl : ∀ D : Set R, D.Finite → ∃ᶠ y in l, y ∉ D) :
    contVec (prodMap₃ T₁ T₂ T₃) (measurePreserving_prodMap₃ hT₁ hT₂ hT₃) l =
      (lpMeas ℝ ℝ (prodFactorSigma (Ω₁ := Ω₁) (Ω₃ := Ω₃) T₂ hT₂ l) 2 (μ₁.prod (μ₂.prod μ₃)) :
        Set (Lp ℝ 2 (μ₁.prod (μ₂.prod μ₃)))) := by
  sorry

end Product

/-! ## Spec -/

-- `prodMap₃` acts coordinatewise.
example (T₁ : ℤ → Bool → Bool) (T₂ : ℤ → ℕ → ℕ) (T₃ : ℤ → Unit → Unit) (y : ℤ) (a : Bool) (b : ℕ) :
    prodMap₃ T₁ T₂ T₃ y (a, b, ()) = (T₁ y a, T₂ y b, T₃ y ()) := rfl

-- `comap_factorSigma_le` along the identity factor map is `le_refl`.
example {R Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) :
    (factorSigma T hT l).comap id ≤ factorSigma T hT l :=
  comap_factorSigma_le T hT T hT l (MeasurePreserving.id μ) fun _ => rfl

-- `prodFactorSigma` contains the first coordinate's events.
example {R Ω₁ Ω₂ Ω₃ : Type*} [MeasurableSpace Ω₁] [MeasurableSpace Ω₂] [MeasurableSpace Ω₃] {μ₂ : Measure Ω₂}
    [IsProbabilityMeasure μ₂] (T₂ : R → Ω₂ → Ω₂) (hT₂ : ∀ y, MeasurePreserving (T₂ y) μ₂ μ₂) (l : Filter R) (s : Set Ω₁)
    (hs : MeasurableSet s) :
    MeasurableSet[prodFactorSigma (Ω₁ := Ω₁) (Ω₃ := Ω₃) T₂ hT₂ l] ((fun ω : Ω₁ × Ω₂ × Ω₃ => ω.1) ⁻¹' s) :=
  (le_sup_left : MeasurableSpace.comap (fun ω : Ω₁ × Ω₂ × Ω₃ => ω.1) inferInstance ≤ _) _ ⟨s, hs, rfl⟩

end HadwigerNelson.SpectralInputs
