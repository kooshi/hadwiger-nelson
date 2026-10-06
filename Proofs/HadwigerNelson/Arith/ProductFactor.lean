import Proofs.HadwigerNelson.Arith.SpectralInputs
import Mathlib.Probability.Independence.Basic
import Mathlib.MeasureTheory.Measure.MeasuredSets
import Mathlib.Probability.Independence.InfinitePi

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
* `contVec_prod_eq`: J45-SI-J.

**Proved (FS131-I10F), on events instead of vectors.** By `contVec_eq_lpMeas` both sides are `L²` of a σ-algebra, so the
statement is about events with `l`-continuous indicator (`factorSets`). `⊇`: the first coordinate's events are
eventually fixed, and the second system's factor pulls back (`comap_factorSigma_le`). `⊆`, in three steps:

1. **the noise lemma** (`exists_fst_preimage_ae_eq_of_mem_factorSets`, on `X × Ω₃` for any base system `X`): for an event
   `E` let `φ(E) = ∫ μ₃(E_w)(1 − μ₃(E_w)) dμ_X(w)`, the mean variance of its sections. `φ` is 1-Lipschitz for
   `μ(· ∆ ·)`; for a cylinder `E` on a finite coordinate set `A` and a shift `y` with `A + y` off `A`, the sections of
   `E` and of its shift are independent, so `φ(E) ≤ μ(shift⁻¹E ∆ E)`; cylinders are a ring of sets generating the
   σ-algebra (`hgen`), so Mathlib's approximation lemma and `hl` give `φ(A) ≤ 4δ` for every `δ`: the sections of `A`
   have measure 0 or 1, and `A` is a.e. a set of the base. This replaces the plan's children C1–C4 (the splitting by a
   conditional expectation, the density of cylinders in `L²₀`, the orthogonality, `‖V_y F′ − F′‖ = √2‖F′‖`): no
   conditional expectation and no `L²` density is used;
2. **the fibre lemma** (`fibre_mem_factorSets`, the plan's C5): over an atom `a` of the finite `Ω₁`, eventually
   `T₁ y = id`, so the fibre of a set of the first two coordinates has an `l`-continuous indicator in the second system;
3. **the assembly** (`exists_measurableSet_prodFactorSigma_ae_eq`, the plan's C6): the union over the atoms of
   `{ω₁ = a} ∩ {ω₂ ∈ fibre}` is an event of `σ(Φ) ∨ 𝒜_l(c₂)`, a.e. equal to `A`; then `Lp.induction_stronglyMeasurable`
   carries events to vectors.

**Inhabitants.** `prodMap₃` of three identity families is the identity family; with `l = ⊥` every hypothesis on `l` but
`hl` holds and `hl` fails (the empty filter is eventually everywhere), so the model the row names is the honest one:
`Φ` a uniform translate on a finite group, fair bits on `R → Bool` (`Measure.infinitePi`), `l` the cofinite filter on an
infinite `R`. **Built (FS131-I10F): `contVec_prod_eq_coin`** — every hypothesis of `contVec_prod_eq` at once, at `R = ℤ`,
coin tosses of any law indexed by `ℤ` under the shift (`measurePreserving_shift_infinitePi`,
`ProbabilityTheory.iIndepFun_infinitePi`), the cofinite filter, and one-point first and second systems. With a
non-degenerate coin it exercises `hgen`, `hind`, `hshift` and `hl` in earnest; `h₁` and `[Finite Ω₁]` are met by a point,
so the row's non-trivial finite translation system is not built.
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

/-- An event almost everywhere equal to one with `l`-continuous indicator has `l`-continuous indicator. -/
theorem mem_factorSets_of_ae_eq [IsFiniteMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (l : Filter R) {A B : Set Ω} (hA : A ∈ factorSets T hT l) (hB : MeasurableSet B) (hAB : A =ᵐ[μ] B) :
    B ∈ factorSets T hT l := by
  obtain ⟨-, h⟩ := (mem_factorSets_iff T hT l).mp hA
  refine (mem_factorSets_iff T hT l).mpr ⟨hB, ?_⟩
  have key : ∀ y, μ (symmDiff (T y ⁻¹' B) B) = μ (symmDiff (T y ⁻¹' A) A) := fun y =>
    measure_congr (((hT y).quasiMeasurePreserving.preimage_ae_eq hAB.symm).symmDiff hAB.symm)
  simpa only [key] using h

end FactorOfFactor

/-! ## The noise lemma: an event with `l`-continuous indicator over independent shifted coordinates is an event of the base

On `X × Ω₃`, with any measure-preserving family `S` on `X` and coordinates `ε x` on `Ω₃` that are independent, generate
the σ-algebra and are shifted by `T₃`: for an event `E` put `a_E(w) = μ₃(E_w)`, the measure of its section, and
`φ(E) = ∫ a_E (1 − a_E) dμ_X`. Then `φ` is 1-Lipschitz for `μ(· ∆ ·)` (`integral_section_var_le_add`); `φ(E) = 0` exactly
when `E` is a.e. a set of the first coordinate (`exists_fst_preimage_of_integral_section_var_eq_zero`); and for a cylinder
`E` on a finite coordinate set `A` and a shift `y` moving `A` off itself, `φ(E) ≤ μ((S y × T₃ y)⁻¹E ∆ E)`
(`integral_section_var_le_symmDiff_shift`: the two sections are independent, and `v(1 − v) ≤ u + v − 2uv`). Cylinders
are a ring of sets generating the product σ-algebra (`isSetRing_cylSets`, `generateFrom_cylSets`), so Mathlib's
approximation lemma gives `φ(A) ≤ 4δ` for every `δ` when `A` has an `l`-continuous indicator and `l` is not eventually
inside a finite set. -/

section Noise

open scoped symmDiff

variable {R X Ω₃ B : Type*} [MeasurableSpace X] [MeasurableSpace Ω₃] [MeasurableSpace B] {μX : Measure X}
  {μ₃ : Measure Ω₃}

/-- Fubini for a measurable set, in real form: `μ(E) = ∫ μ₃(E_w) dμ_X(w)`. -/
theorem measureReal_prod_eq_integral_section [IsFiniteMeasure μ₃] {E : Set (X × Ω₃)} (hE : MeasurableSet E) :
    (μX.prod μ₃).real E = ∫ w, μ₃.real (Prod.mk w ⁻¹' E) ∂μX := by
  rw [measureReal_def, Measure.prod_apply hE]
  exact (integral_toReal (measurable_measure_prodMk_left hE).aemeasurable
    (ae_of_all _ fun w => measure_lt_top _ _)).symm

theorem measurable_measureReal_section [IsFiniteMeasure μ₃] {E : Set (X × Ω₃)} (hE : MeasurableSet E) :
    Measurable fun w => μ₃.real (Prod.mk w ⁻¹' E) :=
  (measurable_measure_prodMk_left hE).ennreal_toReal

theorem integrable_measureReal_section [IsFiniteMeasure μX] [IsProbabilityMeasure μ₃] {E : Set (X × Ω₃)}
    (hE : MeasurableSet E) : Integrable (fun w => μ₃.real (Prod.mk w ⁻¹' E)) μX :=
  Integrable.of_bound (measurable_measureReal_section hE).aestronglyMeasurable 1 (ae_of_all _ fun w => by
    rw [Real.norm_eq_abs, abs_of_nonneg measureReal_nonneg]
    exact measureReal_le_one)

theorem integrable_section_var [IsFiniteMeasure μX] [IsProbabilityMeasure μ₃] {E : Set (X × Ω₃)}
    (hE : MeasurableSet E) :
    Integrable (fun w => μ₃.real (Prod.mk w ⁻¹' E) * (1 - μ₃.real (Prod.mk w ⁻¹' E))) μX :=
  Integrable.of_bound ((measurable_measureReal_section hE).mul
    (measurable_const.sub (measurable_measureReal_section hE))).aestronglyMeasurable 1 (ae_of_all _ fun w => by
    have h0 : 0 ≤ μ₃.real (Prod.mk w ⁻¹' E) := measureReal_nonneg
    have h1 : μ₃.real (Prod.mk w ⁻¹' E) ≤ 1 := measureReal_le_one
    rw [Real.norm_eq_abs, abs_le]
    constructor <;> nlinarith)

/-- For independent events `U`, `V` of a probability space: `P(V)(1 − P(V)) ≤ P(U ∆ V)`. -/
theorem measureReal_mul_one_sub_le_symmDiff [IsProbabilityMeasure μ₃] {U V : Set Ω₃} (hU : MeasurableSet U)
    (hV : MeasurableSet V) (hUV : μ₃ (U ∩ V) = μ₃ U * μ₃ V) :
    μ₃.real V * (1 - μ₃.real V) ≤ μ₃.real (U ∆ V) := by
  have h1 : μ₃.real (U ∩ V) = μ₃.real U * μ₃.real V := by
    rw [measureReal_def, hUV, ENNReal.toReal_mul]
    rfl
  have h2 : μ₃.real (U \ V) + μ₃.real (U ∩ V) = μ₃.real U := measureReal_sdiff_add_inter hV
  have h3 : μ₃.real (V \ U) + μ₃.real (V ∩ U) = μ₃.real V := measureReal_sdiff_add_inter hU
  rw [Set.inter_comm] at h3
  rw [measureReal_symmDiff_eq hU hV]
  have hu0 : 0 ≤ μ₃.real U := measureReal_nonneg
  have hu1 : μ₃.real U ≤ 1 := measureReal_le_one
  nlinarith [sq_nonneg (μ₃.real U - μ₃.real V), mul_nonneg hu0 (sub_nonneg.mpr hu1)]

/-- **The section variance is 1-Lipschitz**: `φ(E) ≤ φ(E') + μ(E ∆ E')`. -/
theorem integral_section_var_le_add [IsProbabilityMeasure μX] [IsProbabilityMeasure μ₃] {E E' : Set (X × Ω₃)}
    (hE : MeasurableSet E) (hE' : MeasurableSet E') :
    ∫ w, μ₃.real (Prod.mk w ⁻¹' E) * (1 - μ₃.real (Prod.mk w ⁻¹' E)) ∂μX ≤
      ∫ w, μ₃.real (Prod.mk w ⁻¹' E') * (1 - μ₃.real (Prod.mk w ⁻¹' E')) ∂μX + (μX.prod μ₃).real (E ∆ E') := by
  rw [measureReal_prod_eq_integral_section (hE.symmDiff hE'),
    ← integral_add (integrable_section_var hE') (integrable_measureReal_section (hE.symmDiff hE'))]
  refine integral_mono (integrable_section_var hE)
    ((integrable_section_var hE').add (integrable_measureReal_section (hE.symmDiff hE'))) fun w => ?_
  have ha0 : 0 ≤ μ₃.real (Prod.mk w ⁻¹' E) := measureReal_nonneg
  have ha1 : μ₃.real (Prod.mk w ⁻¹' E) ≤ 1 := measureReal_le_one
  have hb0 : 0 ≤ μ₃.real (Prod.mk w ⁻¹' E') := measureReal_nonneg
  have hb1 : μ₃.real (Prod.mk w ⁻¹' E') ≤ 1 := measureReal_le_one
  have hd : |μ₃.real (Prod.mk w ⁻¹' E) - μ₃.real (Prod.mk w ⁻¹' E')| ≤
      μ₃.real ((Prod.mk w ⁻¹' E) ∆ (Prod.mk w ⁻¹' E')) :=
    abs_measureReal_sub_le_measureReal_symmDiff (measurable_prodMk_left hE).nullMeasurableSet
      (measurable_prodMk_left hE').nullMeasurableSet
  have hd' := abs_le.mp hd
  show _ ≤ _ + μ₃.real ((Prod.mk w ⁻¹' E) ∆ (Prod.mk w ⁻¹' E'))
  rcases le_total (μ₃.real (Prod.mk w ⁻¹' E')) (μ₃.real (Prod.mk w ⁻¹' E)) with h | h <;> nlinarith

/-- **Zero section variance**: an event whose sections have measure 0 or 1 almost everywhere is almost everywhere a set
of the first coordinate. -/
theorem exists_fst_preimage_of_integral_section_var_eq_zero [IsProbabilityMeasure μX] [IsProbabilityMeasure μ₃]
    {E : Set (X × Ω₃)} (hE : MeasurableSet E)
    (h0 : ∫ w, μ₃.real (Prod.mk w ⁻¹' E) * (1 - μ₃.real (Prod.mk w ⁻¹' E)) ∂μX = 0) :
    ∃ C : Set X, MeasurableSet C ∧ E =ᵐ[μX.prod μ₃] Prod.fst ⁻¹' C := by
  have hnn : 0 ≤ fun w => μ₃.real (Prod.mk w ⁻¹' E) * (1 - μ₃.real (Prod.mk w ⁻¹' E)) := fun w =>
    mul_nonneg measureReal_nonneg (sub_nonneg.mpr measureReal_le_one)
  have hae := (integral_eq_zero_iff_of_nonneg hnn (integrable_section_var hE)).mp h0
  have hC : MeasurableSet {w | μ₃ (Prod.mk w ⁻¹' E) = 1} :=
    (measurable_measure_prodMk_left hE) (measurableSet_singleton 1)
  refine ⟨{w | μ₃ (Prod.mk w ⁻¹' E) = 1}, hC, measure_symmDiff_eq_zero_iff.mp ?_⟩
  rw [Measure.prod_apply (hE.symmDiff (measurable_fst hC))]
  have hz : ∀ᵐ w ∂μX, μ₃ (Prod.mk w ⁻¹' (E ∆ (Prod.fst ⁻¹' {w | μ₃ (Prod.mk w ⁻¹' E) = 1}))) = 0 := by
    filter_upwards [hae] with w hw
    have hw' : μ₃.real (Prod.mk w ⁻¹' E) * (1 - μ₃.real (Prod.mk w ⁻¹' E)) = 0 := hw
    by_cases hwC : μ₃ (Prod.mk w ⁻¹' E) = 1
    · have hs : Prod.mk w ⁻¹' (E ∆ (Prod.fst ⁻¹' {w | μ₃ (Prod.mk w ⁻¹' E) = 1})) = (Prod.mk w ⁻¹' E)ᶜ := by
        ext ω
        simp [Set.mem_symmDiff, hwC]
      rw [hs, prob_compl_eq_zero_iff (measurable_prodMk_left hE)]
      exact hwC
    · have hs : Prod.mk w ⁻¹' (E ∆ (Prod.fst ⁻¹' {w | μ₃ (Prod.mk w ⁻¹' E) = 1})) = Prod.mk w ⁻¹' E := by
        ext ω
        simp [Set.mem_symmDiff, hwC]
      rw [hs]
      rcases mul_eq_zero.mp hw' with h | h
      · exact (measureReal_eq_zero_iff (measure_ne_top _ _)).mp h
      · exfalso
        apply hwC
        have h1 : μ₃.real (Prod.mk w ⁻¹' E) = 1 := by linarith
        rw [measureReal_def] at h1
        exact (ENNReal.toReal_eq_one_iff _).mp h1
  rw [lintegral_congr_ae hz, lintegral_zero]

/-- The cylinder map on the coordinates in a finite set `A`: `(w, ω) ↦ (w, (ε x ω)_{x ∈ A})`. -/
def cylMap (ε : R → Ω₃ → B) (A : Finset R) (p : X × Ω₃) : X × (A → B) := (p.1, fun i => ε i p.2)

theorem measurable_cylMap {ε : R → Ω₃ → B} (hε : ∀ x, Measurable (ε x)) (A : Finset R) :
    Measurable (cylMap (X := X) ε A) :=
  measurable_fst.prodMk (measurable_pi_lambda _ fun i => (hε i).comp measurable_snd)

/-- **The cylinder events** of `X × Ω₃`: preimages under some `cylMap ε A`, `A` finite, of measurable sets. -/
def cylSets (ε : R → Ω₃ → B) : Set (Set (X × Ω₃)) :=
  {E | ∃ (A : Finset R) (E₀ : Set (X × (A → B))), MeasurableSet E₀ ∧ cylMap ε A ⁻¹' E₀ = E}

omit [MeasurableSpace Ω₃] in
/-- A cylinder on `A` is a cylinder on any larger finite set. -/
theorem exists_cyl_of_subset (ε : R → Ω₃ → B) {A A' : Finset R} (hsub : A ⊆ A') {E₀ : Set (X × (A → B))}
    (hE₀ : MeasurableSet E₀) :
    ∃ E₀' : Set (X × (A' → B)), MeasurableSet E₀' ∧ cylMap ε A' ⁻¹' E₀' = cylMap ε A ⁻¹' E₀ := by
  have hr : Measurable (Prod.map (id : X → X) fun (f : A' → B) (i : A) => f ⟨i, hsub i.2⟩) :=
    measurable_id.prodMap (measurable_pi_lambda _ fun i => measurable_pi_apply _)
  exact ⟨_, hr hE₀, rfl⟩

omit [MeasurableSpace Ω₃] in
theorem univ_mem_cylSets (ε : R → Ω₃ → B) : (Set.univ : Set (X × Ω₃)) ∈ cylSets ε :=
  ⟨∅, Set.univ, MeasurableSet.univ, rfl⟩

omit [MeasurableSpace Ω₃] in
/-- The cylinder events are a ring of sets. -/
theorem isSetRing_cylSets (ε : R → Ω₃ → B) : IsSetRing (cylSets (X := X) ε) := by
  classical
  refine ⟨⟨∅, ∅, MeasurableSet.empty, rfl⟩, ?_, ?_⟩
  · rintro _ _ ⟨A₁, E₁, hE₁, rfl⟩ ⟨A₂, E₂, hE₂, rfl⟩
    obtain ⟨F₁, hF₁, h1⟩ := exists_cyl_of_subset ε (Finset.subset_union_left (s₂ := A₂)) hE₁
    obtain ⟨F₂, hF₂, h2⟩ := exists_cyl_of_subset ε (Finset.subset_union_right (s₁ := A₁)) hE₂
    exact ⟨A₁ ∪ A₂, F₁ ∪ F₂, hF₁.union hF₂, by rw [Set.preimage_union, h1, h2]⟩
  · rintro _ _ ⟨A₁, E₁, hE₁, rfl⟩ ⟨A₂, E₂, hE₂, rfl⟩
    obtain ⟨F₁, hF₁, h1⟩ := exists_cyl_of_subset ε (Finset.subset_union_left (s₂ := A₂)) hE₁
    obtain ⟨F₂, hF₂, h2⟩ := exists_cyl_of_subset ε (Finset.subset_union_right (s₁ := A₁)) hE₂
    exact ⟨A₁ ∪ A₂, F₁ \ F₂, hF₁.diff hF₂, by rw [Set.preimage_sdiff, h1, h2]⟩

/-- The cylinder events generate the product σ-algebra when the coordinates generate the σ-algebra of `Ω₃`. -/
theorem generateFrom_cylSets {ε : R → Ω₃ → B} (hε : ∀ x, Measurable (ε x))
    (hgen : ‹MeasurableSpace Ω₃› = ⨆ x, MeasurableSpace.comap (ε x) inferInstance) :
    (inferInstance : MeasurableSpace (X × Ω₃)) = MeasurableSpace.generateFrom (cylSets (X := X) ε) := by
  apply le_antisymm
  · show MeasurableSpace.comap Prod.fst _ ⊔ MeasurableSpace.comap Prod.snd _ ≤ _
    refine sup_le ?_ ?_
    · rintro _ ⟨t, ht, rfl⟩
      exact MeasurableSpace.measurableSet_generateFrom ⟨∅, Prod.fst ⁻¹' t, measurable_fst ht, rfl⟩
    · have h := congrArg (MeasurableSpace.comap (Prod.snd : X × Ω₃ → Ω₃)) hgen
      rw [MeasurableSpace.comap_iSup] at h
      rw [h]
      refine iSup_le fun x => ?_
      rintro _ ⟨_, ⟨t, ht, rfl⟩, rfl⟩
      refine MeasurableSpace.measurableSet_generateFrom
        ⟨{x}, {q | q.2 ⟨x, Finset.mem_singleton_self x⟩ ∈ t}, ?_, rfl⟩
      exact ((measurable_pi_apply _).comp measurable_snd) ht
  · rintro E hE
    refine MeasurableSpace.generateFrom_le (fun F hF => ?_) E hE
    obtain ⟨A, E₀, hE₀, rfl⟩ := hF
    exact measurable_cylMap hε A hE₀

/-- **Independence of a cylinder from its own shift**: for a cylinder `E` on a finite coordinate set `A` and `y` with
`A + y` disjoint from `A`, the section variance of `E` is at most `μ((S y × T₃ y)⁻¹E ∆ E)`. -/
theorem integral_section_var_le_symmDiff_shift [AddCommGroup R] [IsProbabilityMeasure μX] [IsProbabilityMeasure μ₃]
    {S : R → X → X} {T₃ : R → Ω₃ → Ω₃} (hS : ∀ y, Measurable (S y)) (hT₃ : ∀ y, Measurable (T₃ y))
    {ε : R → Ω₃ → B} (hε : ∀ x, Measurable (ε x)) (hind : ProbabilityTheory.iIndepFun ε μ₃)
    (hshift : ∀ y x ω, ε x (T₃ y ω) = ε (x + y) ω) (A : Finset R) {E₀ : Set (X × (A → B))} (hE₀ : MeasurableSet E₀)
    {y : R} (hy : ∀ x ∈ A, x + y ∉ A) :
    ∫ w, μ₃.real (Prod.mk w ⁻¹' (cylMap ε A ⁻¹' E₀)) * (1 - μ₃.real (Prod.mk w ⁻¹' (cylMap ε A ⁻¹' E₀))) ∂μX ≤
      (μX.prod μ₃).real ((Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε A ⁻¹' E₀)) ∆ (cylMap ε A ⁻¹' E₀)) := by
  have hE : MeasurableSet (cylMap (X := X) ε A ⁻¹' E₀) := measurable_cylMap hε A hE₀
  have hQ : Measurable (Prod.map (S y) (T₃ y)) := (hS y).prodMap (hT₃ y)
  rw [measureReal_prod_eq_integral_section ((hQ hE).symmDiff hE)]
  refine integral_mono (integrable_section_var hE) (integrable_measureReal_section ((hQ hE).symmDiff hE)) fun w => ?_
  -- the coordinates in `A + y` are independent of those in `A`
  have hdisj : Disjoint (A.map (addRightEmbedding y)) A := by
    rw [Finset.disjoint_left]
    intro x hx hxA
    obtain ⟨x₀, hx₀, rfl⟩ := Finset.mem_map.mp hx
    exact hy x₀ hx₀ hxA
  have hI := hind.indepFun_finset (A.map (addRightEmbedding y)) A hdisj hε
  have hφ : Measurable fun (f : (A.map (addRightEmbedding y) : Finset R) → B) (i : A) =>
      f ⟨(i : R) + y, Finset.mem_map_of_mem (addRightEmbedding y) i.2⟩ :=
    measurable_pi_lambda _ fun i => measurable_pi_apply _
  have key := (hI.comp hφ measurable_id).measure_inter_preimage_eq_mul _ _
    (measurable_prodMk_left (x := S y w) hE₀) (measurable_prodMk_left (x := w) hE₀)
  have hU : Prod.mk w ⁻¹' (Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε A ⁻¹' E₀)) =
      ((fun (f : (A.map (addRightEmbedding y) : Finset R) → B) (i : A) =>
        f ⟨(i : R) + y, Finset.mem_map_of_mem (addRightEmbedding y) i.2⟩) ∘
          fun ω (j : (A.map (addRightEmbedding y) : Finset R)) => ε j ω) ⁻¹' (Prod.mk (S y w) ⁻¹' E₀) := by
    ext ω
    simp only [Set.mem_preimage, Prod.map_apply, cylMap, Function.comp_apply, hshift]
  have hmU : MeasurableSet (Prod.mk w ⁻¹' (Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε A ⁻¹' E₀))) :=
    measurable_prodMk_left (hQ hE)
  have hmV : MeasurableSet (Prod.mk w ⁻¹' (cylMap (X := X) ε A ⁻¹' E₀)) := measurable_prodMk_left hE
  have hUV : μ₃ (Prod.mk w ⁻¹' (Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε A ⁻¹' E₀)) ∩ Prod.mk w ⁻¹' (cylMap ε A ⁻¹' E₀)) =
      μ₃ (Prod.mk w ⁻¹' (Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε A ⁻¹' E₀))) * μ₃ (Prod.mk w ⁻¹' (cylMap ε A ⁻¹' E₀)) := by
    rw [hU]
    exact key
  exact measureReal_mul_one_sub_le_symmDiff hmU hmV hUV

/-- **The noise lemma.** On `X × Ω₃`, with `Ω₃` generated by independent coordinates that the maps shift: if `l` is not
eventually inside a finite set, an event with `l`-continuous indicator is almost everywhere a set of the first
coordinate. -/
theorem exists_fst_preimage_ae_eq_of_mem_factorSets [AddCommGroup R] [IsProbabilityMeasure μX]
    [IsProbabilityMeasure μ₃] {S : R → X → X} {T₃ : R → Ω₃ → Ω₃} (hS : ∀ y, MeasurePreserving (S y) μX μX)
    (hT₃ : ∀ y, MeasurePreserving (T₃ y) μ₃ μ₃) (l : Filter R) (ε : R → Ω₃ → B) (hε : ∀ x, Measurable (ε x))
    (hgen : ‹MeasurableSpace Ω₃› = ⨆ x, MeasurableSpace.comap (ε x) inferInstance)
    (hind : ProbabilityTheory.iIndepFun ε μ₃) (hshift : ∀ y x ω, ε x (T₃ y ω) = ε (x + y) ω)
    (hl : ∀ D : Set R, D.Finite → ∃ᶠ y in l, y ∉ D) {A : Set (X × Ω₃)}
    (hA : A ∈ factorSets (fun y => Prod.map (S y) (T₃ y)) (fun y => (hS y).prod (hT₃ y)) l) :
    ∃ C : Set X, MeasurableSet C ∧ A =ᵐ[μX.prod μ₃] Prod.fst ⁻¹' C := by
  obtain ⟨hAm, htend⟩ := (mem_factorSets_iff _ _ l).mp hA
  refine exists_fst_preimage_of_integral_section_var_eq_zero hAm (le_antisymm
    (le_of_forall_pos_le_add fun δ hδ => ?_)
    (integral_nonneg fun w => mul_nonneg measureReal_nonneg (sub_nonneg.mpr measureReal_le_one)))
  have hδ4 : (0 : ℝ) < δ / 4 := by positivity
  have hpos : (0 : ENNReal) < ENNReal.ofReal (δ / 4) := ENNReal.ofReal_pos.mpr hδ4
  obtain ⟨E, ⟨Ac, E₀, hE₀, rfl⟩, hEA⟩ := exists_measure_symmDiff_lt_of_generateFrom_isSetRing (μ := μX.prod μ₃)
    (isSetRing_cylSets ε) ⟨{Set.univ}, Set.countable_singleton _, by simpa using univ_mem_cylSets ε, by simp⟩
    (generateFrom_cylSets hε hgen) hAm hpos
  have hD : ((fun p : R × R => p.2 - p.1) '' ((Ac : Set R) ×ˢ (Ac : Set R))).Finite :=
    (Ac.finite_toSet.prod Ac.finite_toSet).image _
  obtain ⟨y, hyD, hyA⟩ := ((hl _ hD).and_eventually (htend.eventually_lt_const hpos)).exists
  have hy : ∀ x ∈ Ac, x + y ∉ Ac := fun x hx hxy => hyD ⟨(x, x + y), ⟨hx, hxy⟩, by simp⟩
  have hE : MeasurableSet (cylMap (X := X) ε Ac ⁻¹' E₀) := measurable_cylMap hε Ac hE₀
  have hQ : MeasurePreserving (Prod.map (S y) (T₃ y)) (μX.prod μ₃) (μX.prod μ₃) := (hS y).prod (hT₃ y)
  have h1 := integral_section_var_le_add (μX := μX) (μ₃ := μ₃) hAm hE
  have h2 := integral_section_var_le_symmDiff_shift (μX := μX) (fun y => (hS y).measurable)
    (fun y => (hT₃ y).measurable) hε hind hshift Ac hE₀ hy
  have h3 := measureReal_symmDiff_le (μ := μX.prod μ₃) (s := Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε Ac ⁻¹' E₀))
    (t := Prod.map (S y) (T₃ y) ⁻¹' A) (cylMap ε Ac ⁻¹' E₀)
  have h3' := measureReal_symmDiff_le (μ := μX.prod μ₃) (s := Prod.map (S y) (T₃ y) ⁻¹' A) (t := A)
    (cylMap ε Ac ⁻¹' E₀)
  have h4 : (μX.prod μ₃).real ((Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε Ac ⁻¹' E₀)) ∆ (Prod.map (S y) (T₃ y) ⁻¹' A)) =
      (μX.prod μ₃).real ((cylMap ε Ac ⁻¹' E₀) ∆ A) := by
    have e : (Prod.map (S y) (T₃ y) ⁻¹' (cylMap ε Ac ⁻¹' E₀)) ∆ (Prod.map (S y) (T₃ y) ⁻¹' A) =
        Prod.map (S y) (T₃ y) ⁻¹' ((cylMap ε Ac ⁻¹' E₀) ∆ A) := rfl
    rw [e, measureReal_def, hQ.measure_preimage (hE.symmDiff hAm).nullMeasurableSet, measureReal_def]
  have h5 : (μX.prod μ₃).real ((cylMap ε Ac ⁻¹' E₀) ∆ A) < δ / 4 := ENNReal.toReal_lt_of_lt_ofReal hEA
  have h6 : (μX.prod μ₃).real ((Prod.map (S y) (T₃ y) ⁻¹' A) ∆ A) < δ / 4 := ENNReal.toReal_lt_of_lt_ofReal hyA
  have h7 : (μX.prod μ₃).real (A ∆ (cylMap ε Ac ⁻¹' E₀)) = (μX.prod μ₃).real ((cylMap ε Ac ⁻¹' E₀) ∆ A) := by
    rw [symmDiff_comm]
  linarith

end Noise

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

/-- **The fibre lemma**: if the first system is eventually fixed along `l`, the fibre over an atom of `Ω₁` of a set of
the first two coordinates with `l`-continuous indicator has `l`-continuous indicator in the second system. -/
theorem fibre_mem_factorSets [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂]
    [IsProbabilityMeasure μ₃] {T₁ : R → Ω₁ → Ω₁} {T₂ : R → Ω₂ → Ω₂} {T₃ : R → Ω₃ → Ω₃}
    (hT₁ : ∀ y, MeasurePreserving (T₁ y) μ₁ μ₁) (hT₂ : ∀ y, MeasurePreserving (T₂ y) μ₂ μ₂)
    (hT₃ : ∀ y, MeasurePreserving (T₃ y) μ₃ μ₃) (l : Filter R) (h₁ : ∀ᶠ y in l, T₁ y = id) {C : Set (Ω₁ × Ω₂)}
    (hC : MeasurableSet C)
    (hB : {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C} ∈
      factorSets (prodMap₃ T₁ T₂ T₃) (measurePreserving_prodMap₃ hT₁ hT₂ hT₃) l) {a : Ω₁} (ha : μ₁ {a} ≠ 0) :
    Prod.mk a ⁻¹' C ∈ factorSets T₂ hT₂ l := by
  obtain ⟨-, h⟩ := (mem_factorSets_iff _ _ l).mp hB
  refine (mem_factorSets_iff T₂ hT₂ l).mpr ⟨measurable_prodMk_left hC, ?_⟩
  have hle : ∀ᶠ y in l, μ₂ (symmDiff (T₂ y ⁻¹' (Prod.mk a ⁻¹' C)) (Prod.mk a ⁻¹' C)) ≤
      (μ₁ {a})⁻¹ * (μ₁.prod (μ₂.prod μ₃)) (symmDiff
        (prodMap₃ T₁ T₂ T₃ y ⁻¹' {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C}) {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C}) := by
    filter_upwards [h₁] with y hy
    have hsub : ({a} : Set Ω₁) ×ˢ
        ((symmDiff (T₂ y ⁻¹' (Prod.mk a ⁻¹' C)) (Prod.mk a ⁻¹' C)) ×ˢ (Set.univ : Set Ω₃)) ⊆
        symmDiff (prodMap₃ T₁ T₂ T₃ y ⁻¹' {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C})
          {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C} := by
      rintro ⟨ω₁, ω₂, ω₃⟩ ⟨h1, h2, -⟩
      rw [Set.mem_singleton_iff] at h1
      subst h1
      simpa [prodMap₃, hy, Set.mem_symmDiff] using h2
    have hm := measure_mono (μ := μ₁.prod (μ₂.prod μ₃)) hsub
    rw [Measure.prod_prod, Measure.prod_prod, measure_univ, mul_one] at hm
    calc μ₂ (symmDiff (T₂ y ⁻¹' (Prod.mk a ⁻¹' C)) (Prod.mk a ⁻¹' C))
        = (μ₁ {a})⁻¹ * (μ₁ {a} * μ₂ (symmDiff (T₂ y ⁻¹' (Prod.mk a ⁻¹' C)) (Prod.mk a ⁻¹' C))) := by
          rw [← mul_assoc, ENNReal.inv_mul_cancel ha (measure_ne_top _ _), one_mul]
      _ ≤ _ := mul_le_mul_right hm _
  have h0 := ENNReal.Tendsto.const_mul (a := (μ₁ {a})⁻¹) h (Or.inr (ENNReal.inv_ne_top.mpr ha))
  rw [mul_zero] at h0
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds h0
    (Filter.Eventually.of_forall fun _ => zero_le) hle

/-- **Every event with `l`-continuous indicator in the product is almost everywhere an event of `σ(Φ) ∨ 𝒜_l(c₂)`**:
the noise lemma on `(Ω₁ × Ω₂) × Ω₃`, then the fibre lemma over the atoms of `Ω₁`. -/
theorem exists_measurableSet_prodFactorSigma_ae_eq [AddCommGroup R] [Finite Ω₁] [MeasurableSingletonClass Ω₁]
    [IsProbabilityMeasure μ₁] [IsProbabilityMeasure μ₂] [IsProbabilityMeasure μ₃] {T₁ : R → Ω₁ → Ω₁}
    {T₂ : R → Ω₂ → Ω₂} {T₃ : R → Ω₃ → Ω₃} (hT₁ : ∀ y, MeasurePreserving (T₁ y) μ₁ μ₁)
    (hT₂ : ∀ y, MeasurePreserving (T₂ y) μ₂ μ₂) (hT₃ : ∀ y, MeasurePreserving (T₃ y) μ₃ μ₃) (l : Filter R)
    (h₁ : ∀ᶠ y in l, T₁ y = id) {B : Type*} [MeasurableSpace B] (ε : R → Ω₃ → B) (hε : ∀ x, Measurable (ε x))
    (hgen : ‹MeasurableSpace Ω₃› = ⨆ x, MeasurableSpace.comap (ε x) inferInstance)
    (hind : ProbabilityTheory.iIndepFun ε μ₃) (hshift : ∀ y x ω, ε x (T₃ y ω) = ε (x + y) ω)
    (hl : ∀ D : Set R, D.Finite → ∃ᶠ y in l, y ∉ D) {A : Set (Ω₁ × Ω₂ × Ω₃)}
    (hA : A ∈ factorSets (prodMap₃ T₁ T₂ T₃) (measurePreserving_prodMap₃ hT₁ hT₂ hT₃) l) :
    ∃ B' : Set (Ω₁ × Ω₂ × Ω₃), MeasurableSet[prodFactorSigma (Ω₁ := Ω₁) (Ω₃ := Ω₃) T₂ hT₂ l] B' ∧
      A =ᵐ[μ₁.prod (μ₂.prod μ₃)] B' := by
  -- the noise lemma, on `(Ω₁ × Ω₂) × Ω₃`
  have he := measurePreserving_prodAssoc μ₁ μ₂ μ₃
  have hA' := preimage_mem_factorSets (fun y => Prod.map (Prod.map (T₁ y) (T₂ y)) (T₃ y))
    (fun y => ((hT₁ y).prod (hT₂ y)).prod (hT₃ y)) (prodMap₃ T₁ T₂ T₃) (measurePreserving_prodMap₃ hT₁ hT₂ hT₃) l he
    (fun y => rfl) hA
  obtain ⟨C, hC, hAC⟩ := exists_fst_preimage_ae_eq_of_mem_factorSets (fun y => (hT₁ y).prod (hT₂ y)) hT₃ l ε hε hgen
    hind hshift hl hA'
  -- back on `Ω₁ × Ω₂ × Ω₃`: `A` is a.e. the set `{(ω₁, ω₂) ∈ C}`
  have hBm : MeasurableSet {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C} :=
    (measurable_fst.prodMk (measurable_fst.comp measurable_snd)) hC
  have hAB : A =ᵐ[μ₁.prod (μ₂.prod μ₃)] {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C} := by
    have h := (MeasurePreserving.symm MeasurableEquiv.prodAssoc he).quasiMeasurePreserving.preimage_ae_eq hAC
    have h1 : (MeasurableEquiv.prodAssoc (α := Ω₁) (β := Ω₂) (γ := Ω₃)).symm ⁻¹'
        (MeasurableEquiv.prodAssoc ⁻¹' A) = A := by
      ext ω
      simp
    rw [h1] at h
    exact h
  have hB := mem_factorSets_of_ae_eq _ _ l hA hBm hAB
  have hfib : ∀ a : Ω₁, μ₁ {a} ≠ 0 → Prod.mk a ⁻¹' C ∈ factorSets T₂ hT₂ l := fun a ha =>
    fibre_mem_factorSets hT₁ hT₂ hT₃ l h₁ hC hB ha
  haveI : Countable Ω₁ := Finite.to_countable
  refine ⟨⋃ a : Ω₁, ⋃ (_ : μ₁ {a} ≠ 0),
    (Prod.fst ⁻¹' {a}) ∩ ((fun ω : Ω₁ × Ω₂ × Ω₃ => ω.2.1) ⁻¹' (Prod.mk a ⁻¹' C)), ?_, hAB.trans ?_⟩
  · refine MeasurableSet.iUnion fun a => MeasurableSet.iUnion fun ha => MeasurableSet.inter ?_ ?_
    · exact (le_sup_left : MeasurableSpace.comap (fun ω : Ω₁ × Ω₂ × Ω₃ => ω.1) inferInstance ≤ _) _
        ⟨{a}, measurableSet_singleton a, rfl⟩
    · exact (le_sup_right : MeasurableSpace.comap (fun ω : Ω₁ × Ω₂ × Ω₃ => ω.2.1) (factorSigma T₂ hT₂ l) ≤
        prodFactorSigma (Ω₁ := Ω₁) (Ω₃ := Ω₃) T₂ hT₂ l) _
        ⟨Prod.mk a ⁻¹' C, (measurableSet_factorSigma_iff T₂ hT₂ l).mpr (hfib a ha), rfl⟩
  · refine ae_eq_set.mpr ⟨measure_mono_null (t := ⋃ a : Ω₁, ⋃ (_ : μ₁ {a} = 0), Prod.fst ⁻¹' {a}) ?_ ?_, ?_⟩
    · rintro ω ⟨hω, hω'⟩
      simp only [Set.mem_iUnion, Set.mem_inter_iff, Set.mem_preimage, Set.mem_singleton_iff, exists_prop,
        not_exists, not_and] at hω' ⊢
      refine ⟨ω.1, ?_, rfl⟩
      by_contra hne
      exact hω' ω.1 hne rfl hω
    · refine measure_iUnion_null fun a => measure_iUnion_null fun ha => ?_
      rw [(measurePreserving_fst (μ := μ₁) (ν := μ₂.prod μ₃)).measure_preimage
        (measurableSet_singleton a).nullMeasurableSet]
      exact ha
    · have hsub : (⋃ a : Ω₁, ⋃ (_ : μ₁ {a} ≠ 0),
          (Prod.fst ⁻¹' {a}) ∩ ((fun ω : Ω₁ × Ω₂ × Ω₃ => ω.2.1) ⁻¹' (Prod.mk a ⁻¹' C))) \
          {ω : Ω₁ × Ω₂ × Ω₃ | (ω.1, ω.2.1) ∈ C} = ∅ := by
        ext ω
        simp only [Set.mem_sdiff, Set.mem_iUnion, Set.mem_inter_iff, Set.mem_preimage, Set.mem_singleton_iff,
          exists_prop, Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false, not_and, not_not]
        rintro ⟨a, -, rfl, h⟩
        exact h
      rw [hsub, measure_empty]

/-- **J45-SI-J, at the class its argument reads**: "the `E_S`-factor of an independent product of a finite translation
system, a Bernoulli process and `c₂` is `σ(Φ) ∨ 𝒜_S(c₂)`". For a finite discrete system `Ω₁` whose maps are eventually the
identity along `l`, any system `Ω₂`, and a system `Ω₃` whose σ-algebra is generated by independent coordinates `ε x`
(`x ∈ R`) that the maps shift (`ε x ∘ T₃ y = ε (x + y)`): if `l` is not eventually inside a finite set, the `l`-continuous
vectors of the product system are exactly the vectors of `L²` measurable for `σ(Φ) ∨ 𝒜_l(c₂)`. With
`SpectralInputs.contVec_eq_lpMeas` this says the two σ-algebras agree up to null sets. Identical distribution of the
coordinates is not read. MODEL: `Ω₁` a finite group with its uniform measure and translations through a homomorphism
`R → Ω₁` with kernel in `l`; `Ω₃ = R → Bool` under `Measure.infinitePi` of fair coins with the shift; `l` the
neighbourhoods of `0` for a T₁ group topology that is not discrete. INHABITANT: `contVec_prod_eq_coin` (every hypothesis
at once, with a one-point first system). -/
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
  have hle0 : prodFactorSigma (Ω₁ := Ω₁) (Ω₃ := Ω₃) T₂ hT₂ l ≤ (inferInstance : MeasurableSpace (Ω₁ × Ω₂ × Ω₃)) :=
    sup_le measurable_fst.comap_le ((MeasurableSpace.comap_mono (factorSigma_le T₂ hT₂ l)).trans
      (measurable_fst.comp measurable_snd).comap_le)
  -- `⊇`: `σ(Φ) ∨ 𝒜_l(c₂)` lies in the factor of the product
  have hle1 : prodFactorSigma (Ω₁ := Ω₁) (Ω₃ := Ω₃) T₂ hT₂ l ≤
      factorSigma (prodMap₃ T₁ T₂ T₃) (measurePreserving_prodMap₃ hT₁ hT₂ hT₃) l := by
    refine sup_le ?_ ?_
    · rintro _ ⟨s, hs, rfl⟩
      rw [measurableSet_factorSigma_iff]
      refine (mem_factorSets_iff _ _ l).mpr ⟨measurable_fst hs, ?_⟩
      refine tendsto_const_nhds.congr' ?_
      filter_upwards [h₁] with y hy
      have hpre : prodMap₃ T₁ T₂ T₃ y ⁻¹' ((fun ω : Ω₁ × Ω₂ × Ω₃ => ω.1) ⁻¹' s) =
          (fun ω : Ω₁ × Ω₂ × Ω₃ => ω.1) ⁻¹' s := by
        ext ω
        simp [prodMap₃, hy]
      rw [hpre, symmDiff_self, Set.bot_eq_empty, measure_empty]
    · exact comap_factorSigma_le (prodMap₃ T₁ T₂ T₃) (measurePreserving_prodMap₃ hT₁ hT₂ hT₃) T₂ hT₂ l
        (π := Prod.fst ∘ Prod.snd) (measurePreserving_fst.comp measurePreserving_snd) (fun y => rfl)
  rw [contVec_eq_lpMeas]
  ext f
  simp only [SetLike.mem_coe, mem_lpMeas_iff_aestronglyMeasurable]
  refine ⟨fun hf => ?_, fun hf => hf.mono hle1⟩
  -- `⊆`: indicators first (every event of the factor is a.e. an event of `σ(Φ) ∨ 𝒜_l(c₂)`), then closure
  refine Lp.induction_stronglyMeasurable (factorSigma_le _ (measurePreserving_prodMap₃ hT₁ hT₂ hT₃) l) (by simp)
    (fun g => AEStronglyMeasurable[prodFactorSigma (Ω₁ := Ω₁) (Ω₃ := Ω₃) T₂ hT₂ l] g (μ₁.prod (μ₂.prod μ₃)))
    ?_ ?_ ?_ f hf
  · intro c s hs hμs
    rw [Lp.simpleFunc.coe_indicatorConst]
    obtain ⟨B', hB', hsB'⟩ := exists_measurableSet_prodFactorSigma_ae_eq hT₁ hT₂ hT₃ l h₁ ε hε hgen hind hshift hl
      ((measurableSet_factorSigma_iff _ _ l).mp hs)
    exact ⟨B'.indicator fun _ => c, stronglyMeasurable_const.indicator hB',
      indicatorConstLp_coeFn.trans (indicator_ae_eq_of_ae_eq_set hsB')⟩
  · intro f g hf hg _ _ _ hPf hPg
    exact (hPf.add hPg).congr (Lp.coeFn_add _ _).symm
  · exact (isClosed_aestronglyMeasurable hle0).preimage continuous_subtype_val

end Product

/-! ## A model of every hypothesis of `contVec_prod_eq` at once -/

/-- The shift of an i.i.d. process indexed by an additive group preserves its law. -/
theorem measurePreserving_shift_infinitePi {R B : Type*} [AddCommGroup R] [MeasurableSpace B] (ρ : Measure B)
    [IsProbabilityMeasure ρ] (y : R) :
    MeasurePreserving (fun (ω : R → B) (x : R) => ω (x + y)) (Measure.infinitePi fun _ : R => ρ)
      (Measure.infinitePi fun _ : R => ρ) := by
  refine ⟨measurable_pi_lambda _ fun x => measurable_pi_apply _, ?_⟩
  have h : (fun (ω : R → B) (x : R) => ω (x + y)) =
      ⇑(MeasurableEquiv.piCongrLeft (fun _ : R => B) (Equiv.subRight y)) := by
    funext ω x
    have h1 := Equiv.piCongrLeft_apply_apply (P := fun _ : R => B) (Equiv.subRight y) ω (x + y)
    have h2 : (Equiv.subRight y) (x + y) = x := by simp
    rw [h2] at h1
    exact h1.symm
  rw [h]
  exact Measure.infinitePi_map_piCongrLeft (μ := fun _ : R => ρ) (Equiv.subRight y)

/-- **A model of every hypothesis of `contVec_prod_eq` at once**: one-point first and second systems, coin tosses of
any law `ρ` indexed by `ℤ` under the shift, and the cofinite filter. For a non-degenerate `ρ` the coordinates are
independent in earnest; the conclusion then says the shift of an i.i.d. process has no vector continuous along the
cofinite filter beyond the constants. -/
theorem contVec_prod_eq_coin (ρ : Measure Bool) [IsProbabilityMeasure ρ] :
    contVec (prodMap₃ (fun _ : ℤ => (id : Unit → Unit)) (fun _ : ℤ => (id : Unit → Unit))
        (fun (y : ℤ) (ω : ℤ → Bool) (x : ℤ) => ω (x + y)))
      (measurePreserving_prodMap₃ (μ₁ := Measure.dirac ()) (μ₂ := Measure.dirac ())
        (fun _ => MeasurePreserving.id _) (fun _ => MeasurePreserving.id _) (measurePreserving_shift_infinitePi ρ))
      Filter.cofinite =
      (lpMeas ℝ ℝ (prodFactorSigma (Ω₁ := Unit) (Ω₃ := ℤ → Bool) (fun _ : ℤ => (id : Unit → Unit))
          (fun _ => MeasurePreserving.id (Measure.dirac ())) Filter.cofinite) 2
        ((Measure.dirac ()).prod ((Measure.dirac ()).prod (Measure.infinitePi fun _ : ℤ => ρ))) :
        Set (Lp ℝ 2 ((Measure.dirac ()).prod ((Measure.dirac ()).prod (Measure.infinitePi fun _ : ℤ => ρ))))) :=
  contVec_prod_eq (fun _ => MeasurePreserving.id _) (fun _ => MeasurePreserving.id _)
    (measurePreserving_shift_infinitePi ρ) Filter.cofinite (Filter.Eventually.of_forall fun _ => rfl)
    (fun (x : ℤ) (ω : ℤ → Bool) => ω x) (fun x => measurable_pi_apply x) rfl
    (ProbabilityTheory.iIndepFun_infinitePi (P := fun _ : ℤ => ρ) (X := fun _ => id) fun _ => measurable_id)
    (fun _ _ _ => rfl)
    (fun D hD => (Filter.eventually_cofinite.mpr (by simpa using hD)).frequently)

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

-- `cylMap` keeps the base point and reads the coordinates in `A`.
example (ε : ℤ → (ℤ → Bool) → Bool) (A : Finset ℤ) (w : ℕ) (ω : ℤ → Bool) :
    cylMap ε A (w, ω) = (w, fun i : A => ε i ω) := rfl

-- the event "coordinate `0` is `true`" is a cylinder event (on `A = {0}`); so is the whole space (on `A = ∅`).
example : {p : ℕ × (ℤ → Bool) | p.2 0 = true} ∈ cylSets (X := ℕ) (fun x (ω : ℤ → Bool) => ω x) := by
  refine ⟨{0}, {q | q.2 ⟨0, Finset.mem_singleton_self 0⟩ = true}, ?_, rfl⟩
  have hm : Measurable fun q : ℕ × ((({0} : Finset ℤ) : Type) → Bool) => q.2 ⟨0, Finset.mem_singleton_self 0⟩ :=
    (measurable_pi_apply _).comp measurable_snd
  exact hm (measurableSet_singleton true)

example (ε : ℤ → (ℤ → Bool) → Bool) : (Set.univ : Set (ℕ × (ℤ → Bool))) ∈ cylSets ε := univ_mem_cylSets ε

-- the noise lemma's inequality at the two extremes: an event independent of itself has probability 0 or 1.
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] {V : Set Ω} (hV : MeasurableSet V)
    (h : μ (V ∩ V) = μ V * μ V) : μ.real V * (1 - μ.real V) ≤ 0 := by
  simpa using measureReal_mul_one_sub_le_symmDiff hV hV h

end HadwigerNelson.SpectralInputs
