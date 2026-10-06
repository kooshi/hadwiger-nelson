import Proofs.HadwigerNelson.SpectralChain
import Mathlib.MeasureTheory.Function.ConditionalExpectation.CondexpL2
import Mathlib.MeasureTheory.Function.ConditionalExpectation.Basic
import Mathlib.MeasureTheory.Function.LpSpace.Indicator
import Mathlib.Dynamics.Ergodic.MeasurePreserving

/-!
# The spectral inputs of row 123's chain (FS-131 wave 10; J45's lemmas, `plans/FS84-SI-D-derivation.md`)

**Read aloud, against the informal claim.** `SpectralChain` proves SP-Cor over an interface: a set `E` of characters of
`R = ℤ[U]` and named `Prop`s about it. This module states the lemmas of J45 that those `Prop`s rest on, each **at the class its
argument reads**, which is in every case wider than the arithmetic setting it was derived in:

* **Haar in Fourier form** (`IsHaarFourier`): a probability measure on the characters of a group whose Fourier coefficients
  vanish off `0`. No topology on the dual is needed to say it; Herglotz–Bochner (`SpectralChain.BochnerHerglotz`, a named
  classical hypothesis) gives existence and uniqueness.
* **J45-SP-oi** (`sp_only_if`, proved): a finite measure with `∫ Re χ(r) dτ < 0` at some `r ≠ 0` is not a multiple of Haar. The
  row's other hypotheses (`U`-invariant, `E`-null) are not read by the argument; `sp_only_if_interface` restates the row's words.
* **J45-SP-if** (`sp_if`): over an interface whose `E` is stable under the duals of multiplications (`Interface.MulStable`:
  `m⁻¹(E) ⊆ E`, J45 §4.2 step 2) and carries a rotation-invariant probability with negative mean at `1`
  (`Interface.NegCircle`: the archimedean circle of radius `j₁,₁/2π`, step 3).
* **J45-N2** in two halves. The measure-theoretic half needs no spectral theory and no group: for *any* family of
  measure-preserving maps `T y` and *any* filter `l` on the index set, the `l`-continuous vectors of `L²(μ)` (`contVec`) are
  `L²` of a σ-algebra (`factorSigma`), `measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`. The spectral half
  (`spectral_carried_iff`) reads a topology `t` on `R` for which Bochner's theorem holds (`BochnerOn t`, a named classical
  hypothesis: true for the topology induced by a dense homomorphism into a locally compact abelian group).
* **J45-N1**, the part the chain consumes (`contChars_haar_null`): the characters continuous for `t` are Haar-null when they
  are a proper measurable subgroup separating the points of `R` (given Herglotz–Bochner; no topology on the dual).
* **J45-SI-4** (`si4`): if the conditional supports of a random colouring given a sub-σ-algebra `𝒜` are disjoint across every
  edge, any selection from the supports is an `𝒜`-measurable proper colouring — for any countable graph and any `𝒜`.

**Not stated in this pass** (their foundation is listed in `plans/FS131-w10-kernel-plan.md` § 3): J45-N1 (a)–(b) (the topology
`τ′_S` and its three summands), J45-SI-5, J45-SI-J, J45-SI-C.

**Inhabitants.** `IsHaarFourier` is satisfiable given Herglotz–Bochner (`exists_isHaarFourier`). `contVec`, `factorSets` and
`factorSigma` take plain data; the identity family `T y = id` is a model (`contVec_id`). `BochnerOn` holds at the discrete
topology (`bochnerOn_bot`). `sp_if`'s hypothesis — a non-Haar finite
rotation-invariant `E`-null measure — is the open zero-entropy question over the arithmetic `E` (J45 §4.2, "Not claimed"); at
`Interface.trivial` (`E = ∅`) it is met by the point mass at the trivial character.
-/

namespace HadwigerNelson.SpectralInputs

open MeasureTheory SpectralChain

/-! ## Haar in Fourier form, and SP -/

noncomputable section Haar

variable {G : Type*} [AddCommGroup G]

/-- **Haar probability on the characters of `G`, in Fourier form**: its Fourier coefficients vanish off `0`. -/
def IsHaarFourier (m : Measure (AddChar G Circle)) : Prop :=
  IsProbabilityMeasure m ∧ ∀ r : G, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂m = 0

/-- Evaluation at `y` is measurable on the characters of any group (the cylinder σ-algebra). -/
theorem measurable_evalChar (y : G) : Measurable (fun χ : AddChar G Circle => (χ y : ℂ)) :=
  (measurable_pi_apply y).comp (comap_measurable (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)))

/-- Haar measure exists in Fourier form, given Herglotz–Bochner: `δ₀` is positive definite. -/
theorem exists_isHaarFourier (hBH : BochnerHerglotz G) : ∃ m : Measure (AddChar G Circle), IsHaarFourier m := by
  sorry

/-- **J45-SP-oi, at the class its argument reads**: a measure with `∫ Re χ(r) dτ < 0` at some `r ≠ 0` is not a multiple of
Haar measure — "`∫ χ(1) dHaar = 0` because `1 ≠ 0` in `R`". -/
theorem sp_only_if {τ m : Measure (AddChar G Circle)} (hm : IsHaarFourier m) {r : G} (hr : r ≠ 0)
    (hneg : ∫ χ, (χ r : ℂ).re ∂τ < 0) (a : ENNReal) : τ ≠ a • m := by
  rintro rfl
  haveI := hm.1
  have hint : Integrable (fun χ : AddChar G Circle => (χ r : ℂ)) m :=
    Integrable.of_bound (measurable_evalChar r).aestronglyMeasurable 1 (Filter.Eventually.of_forall fun χ => by simp)
  have h0 : ∫ χ, (χ r : ℂ).re ∂m = 0 := by
    have h := integral_re (𝕜 := ℂ) hint
    simp only [RCLike.re_to_complex] at h
    rw [h, hm.2 r hr, Complex.zero_re]
  rw [integral_smul_measure, h0, smul_zero] at hneg
  exact lt_irrefl 0 hneg

end Haar

noncomputable section SP

variable {F : Subfield ℝ}

/-- **J45-SP-oi, in the row's words** (Lemma SP-only-if, §4.2): "If a finite positive `U`-invariant `τ` has `τ(E) = 0` and
`∫ Re χ(1) dτ < 0`, then `τ` itself is a `U`-invariant finite measure with `τ(E) = 0` that is not a multiple of Haar".
INHABITANT: none known — such a `τ` is the open sign problem (the Poros record's F5); the argument reads only the last
hypothesis, and `sp_only_if` is satisfiable (any point mass at a character with `Re χ(r) < 0`). -/
theorem sp_only_if_interface (I : Interface F) {τ : Measure (Dual F)} (hfin : IsFiniteMeasure τ) (hrot : RotInv F τ)
    (hE : τ I.E = 0) (hneg : ∫ χ, (χ 1 : ℂ).re ∂τ < 0) :
    IsFiniteMeasure τ ∧ RotInv F τ ∧ τ I.E = 0 ∧
      ∀ m : Measure (Dual F), IsHaarFourier m → ∀ a : ENNReal, τ ≠ a • m :=
  ⟨hfin, hrot, hE, fun _ hm a => sp_only_if hm one_ne_zero hneg a⟩

/-- **`m⁻¹(E) ⊆ E`** (J45 §4.2, SP-if step 2): if `χ(r₀ ·) ∈ E` then `χ ∈ E`, for every `r₀ ≠ 0`. For the arithmetic `E` it
rests on J28V-7 (`MR ⊆ r₀R` for a non-zero integer `M`; `[LevitzMott1972]`). -/
def _root_.HadwigerNelson.SpectralChain.Interface.MulStable (I : Interface F) : Prop :=
  ∀ r₀ : unitRing F, r₀ ≠ 0 → ∀ χ : Dual F, χ.compAddMonoidHom (AddMonoidHom.mulLeft r₀) ∈ I.E → χ ∈ I.E

/-- **The negative circle** (J45 §4.2, SP-if step 3): a rotation-invariant probability `λ` with `∫ Re χ(1) dλ < 0`, carried by a
set `S` of characters translation by which does not leave `E`ᶜ (for the arithmetic `E`: `S ⊆ A ⊆ E`, a subgroup; `λ` uniform on
the archimedean characters `x ↦ exp(2πi Re(ξ x))`, `|ξ| = j₁,₁/2π`, where `∫ = J₀(j₁,₁) ≈ −0.4028`). -/
def _root_.HadwigerNelson.SpectralChain.Interface.NegCircle (I : Interface F) : Prop :=
  ∃ lam : Measure (Dual F), IsProbabilityMeasure lam ∧ RotInv F lam ∧
    (∃ S : Set (Dual F), MeasurableSet S ∧ lam Sᶜ = 0 ∧ ∀ a ∈ S, ∀ χ : Dual F, χ * a ∈ I.E → χ ∈ I.E) ∧
    ∫ χ, (χ 1 : ℂ).re ∂lam < 0

/-- **J45-SP-if** (Lemma SP-if, §4.2): "If some finite positive `U`-invariant `ν` with `ν(E) = 0` is not a multiple of Haar,
then some finite positive `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`." Over an interface with `MulStable` and
`NegCircle`; Fourier uniqueness is Herglotz–Bochner's uniqueness clause. INHABITANT: over the arithmetic `E` the hypothesis is
the open zero-entropy question; at `Interface.trivial` it is met by the point mass at the trivial character. -/
theorem sp_if (I : Interface F) [Countable (unitRing F)] (hBH : BochnerHerglotz (unitRing F)) (hmul : I.MulStable)
    (hcirc : I.NegCircle) {ν m : Measure (Dual F)} (hfin : IsFiniteMeasure ν) (hrot : RotInv F ν) (hE : ν I.E = 0)
    (hm : IsHaarFourier m) (hnh : ∀ a : ENNReal, ν ≠ a • m) :
    ∃ τ : Measure (Dual F), IsFiniteMeasure τ ∧ RotInv F τ ∧ τ I.E = 0 ∧ ∫ χ, (χ 1 : ℂ).re ∂τ < 0 := by
  sorry

end SP

/-! ## The continuity factor (J45-N2), at the class its argument reads -/

noncomputable section Factor

variable {R Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- **The `l`-continuous vectors**: `f ∈ L²(μ)` with `‖f ∘ T y − f‖ → 0` along the filter `l`. -/
def contVec (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) : Set (Lp ℝ 2 μ) :=
  {f | Filter.Tendsto (fun y => ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖) l (nhds 0)}

/-- The events whose indicator is `l`-continuous. -/
def factorSets [IsFiniteMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) : Set (Set Ω) :=
  {A | ∃ hA : MeasurableSet A, indicatorConstLp 2 hA (measure_ne_top μ A) (1 : ℝ) ∈ contVec T hT l}

/-- **The factor σ-algebra `𝒜_l`**, generated by the events with `l`-continuous indicators (which already form a σ-algebra:
`measurableSet_factorSigma_iff`). -/
@[reducible] def factorSigma [IsFiniteMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) :
    MeasurableSpace Ω :=
  MeasurableSpace.generateFrom (factorSets T hT l)

theorem factorSigma_le [IsFiniteMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) :
    factorSigma T hT l ≤ ‹MeasurableSpace Ω› :=
  MeasurableSpace.generateFrom_le fun _ hA => hA.1

/-! ### The proof of N2 (i)–(iii): the `l`-continuous vectors are a closed sublattice containing the constants

The statement the three leaves derive from: `contVec` is a closed subspace of `L²(μ)`, stable under `f ↦ φ ∘ f` for `φ`
Lipschitz with `φ 0 = 0`, and an indicator `1_A` lies in it iff `μ (T y ⁻¹' A ∆ A) → 0` along `l`. -/

section FactorProofs

open scoped symmDiff

/-- `‖1_A‖₂ = √μ(A)`, with a constant. -/
theorem norm_indicatorConstLp_two {A : Set Ω} (hA : MeasurableSet A) (hμA : μ A ≠ ⊤) (c : ℝ) :
    ‖indicatorConstLp 2 hA hμA c‖ = ‖c‖ * Real.sqrt (μ.real A) := by
  rw [norm_indicatorConstLp (by norm_num) (by simp), Real.sqrt_eq_rpow]
  simp

theorem tendsto_sqrt_toReal_iff {ι : Type*} {l : Filter ι} {a : ι → ENNReal} (ha : ∀ y, a y ≠ ⊤) :
    Filter.Tendsto (fun y => Real.sqrt (a y).toReal) l (nhds 0) ↔ Filter.Tendsto a l (nhds 0) := by
  rw [← ENNReal.tendsto_toReal_zero_iff ha]
  constructor
  · intro h
    have := h.pow 2
    simpa [Real.sq_sqrt ENNReal.toReal_nonneg] using this
  · intro h
    have := (Real.continuous_sqrt.tendsto 0).comp h
    simpa [Function.comp_def] using this

section
variable {T : R → Ω → Ω} {hT : ∀ y, MeasurePreserving (T y) μ μ} {l : Filter R}

theorem add_mem_contVec {f g : Lp ℝ 2 μ} (hf : f ∈ contVec T hT l) (hg : g ∈ contVec T hT l) :
    f + g ∈ contVec T hT l := by
  refine squeeze_zero (fun y => norm_nonneg _) (fun y => ?_) (by simpa using Filter.Tendsto.add hf hg)
  rw [map_add, add_sub_add_comm]
  exact norm_add_le _ _

theorem neg_mem_contVec {f : Lp ℝ 2 μ} (hf : f ∈ contVec T hT l) : -f ∈ contVec T hT l := by
  refine squeeze_zero (fun y => norm_nonneg _) (fun y => ?_) hf
  rw [map_neg, ← neg_sub', norm_neg]

theorem sub_mem_contVec {f g : Lp ℝ 2 μ} (hf : f ∈ contVec T hT l) (hg : g ∈ contVec T hT l) :
    f - g ∈ contVec T hT l := by
  rw [sub_eq_add_neg]
  exact add_mem_contVec hf (neg_mem_contVec hg)

variable (T hT l) in
theorem isClosed_contVec : IsClosed (contVec T hT l) := by
  refine isClosed_of_closure_subset fun f hf => ?_
  show Filter.Tendsto (fun y => ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖) l (nhds 0)
  rw [Metric.tendsto_nhds]
  intro ε hε
  obtain ⟨g, hg, hfg⟩ := Metric.mem_closure_iff.mp hf (ε / 3) (by positivity)
  have hg' : ∀ᶠ y in l, ‖Lp.compMeasurePreserving (T y) (hT y) g - g‖ < ε / 3 := by
    have := (Metric.tendsto_nhds.mp hg) (ε / 3) (by positivity)
    simpa using this
  filter_upwards [hg'] with y hy
  rw [Real.dist_eq, sub_zero, abs_norm]
  have h1 : Lp.compMeasurePreserving (T y) (hT y) f - f =
      Lp.compMeasurePreserving (T y) (hT y) (f - g) + (Lp.compMeasurePreserving (T y) (hT y) g - g) - (f - g) := by
    rw [map_sub]
    abel
  have h2 : ‖Lp.compMeasurePreserving (T y) (hT y) (f - g)‖ = ‖f - g‖ := Lp.norm_compMeasurePreserving _ _
  rw [dist_eq_norm] at hfg
  calc ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖
      ≤ ‖Lp.compMeasurePreserving (T y) (hT y) (f - g)‖ + ‖Lp.compMeasurePreserving (T y) (hT y) g - g‖ + ‖f - g‖ := by
        rw [h1]
        exact (norm_sub_le _ _).trans (add_le_add_left (norm_add_le _ _) _)
    _ < ε := by rw [h2]; linarith

theorem compMeasurePreserving_compLp {c : NNReal} {φ : ℝ → ℝ} (hφ : LipschitzWith c φ) (h0 : φ 0 = 0) {S : Ω → Ω}
    (hS : MeasurePreserving S μ μ) (f : Lp ℝ 2 μ) :
    Lp.compMeasurePreserving S hS (hφ.compLp h0 f) = hφ.compLp h0 (Lp.compMeasurePreserving S hS f) := by
  apply Lp.ext
  have h1 := Lp.coeFn_compMeasurePreserving (hφ.compLp h0 f) hS
  have h2 := (hφ.coeFn_compLp h0 f).comp_tendsto hS.quasiMeasurePreserving.tendsto_ae
  have h3 := hφ.coeFn_compLp h0 (Lp.compMeasurePreserving S hS f)
  have h4 := Lp.coeFn_compMeasurePreserving f hS
  filter_upwards [h1, h2, h3, h4] with ω e1 e2 e3 e4
  rw [e1, e3]
  simp only [Function.comp_apply] at e2 e4 ⊢
  rw [e2, e4]

theorem lipschitz_comp_mem_contVec {c : NNReal} {φ : ℝ → ℝ} (hφ : LipschitzWith c φ) (h0 : φ 0 = 0) {f : Lp ℝ 2 μ}
    (hf : f ∈ contVec T hT l) : hφ.compLp h0 f ∈ contVec T hT l := by
  have hbound : ∀ y, ‖Lp.compMeasurePreserving (T y) (hT y) (hφ.compLp h0 f) - hφ.compLp h0 f‖ ≤
      c * ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖ := fun y => by
    rw [compMeasurePreserving_compLp]
    exact hφ.norm_compLp_sub_le h0 _ _
  refine squeeze_zero (fun y => norm_nonneg _) hbound ?_
  simpa using Filter.Tendsto.const_mul (c : ℝ) hf

end

/-- `‖V 1_A − 1_A‖₂ = √μ(T⁻¹A ∆ A)`, with a constant. -/
theorem norm_comp_indicator_sub [IsFiniteMeasure μ] {S : Ω → Ω} (hS : MeasurePreserving S μ μ) {A : Set Ω}
    (hA : MeasurableSet A) (c : ℝ) :
    ‖Lp.compMeasurePreserving S hS (indicatorConstLp 2 hA (measure_ne_top μ A) c) -
        indicatorConstLp 2 hA (measure_ne_top μ A) c‖ = ‖c‖ * Real.sqrt (μ.real ((S ⁻¹' A) ∆ A)) := by
  rw [Lp.indicatorConstLp_compMeasurePreserving hA (measure_ne_top μ A) c hS, ← dist_eq_norm,
    dist_indicatorConstLp_eq_norm, norm_indicatorConstLp_two]

section
variable [IsFiniteMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R)

theorem indicatorConstLp_mem_contVec_iff {A : Set Ω} (hA : MeasurableSet A) {c : ℝ} (hc : c ≠ 0) :
    indicatorConstLp 2 hA (measure_ne_top μ A) c ∈ contVec T hT l ↔
      Filter.Tendsto (fun y => μ ((T y ⁻¹' A) ∆ A)) l (nhds 0) := by
  rw [← tendsto_sqrt_toReal_iff (fun y => measure_ne_top μ _)]
  show Filter.Tendsto (fun y => ‖Lp.compMeasurePreserving (T y) (hT y) _ - _‖) l (nhds 0) ↔ _
  simp only [norm_comp_indicator_sub (hT _) hA]
  have hc' : ‖c‖ ≠ 0 := norm_ne_zero_iff.mpr hc
  constructor
  · intro h
    have := h.const_mul ‖c‖⁻¹
    simpa only [inv_mul_cancel_left₀ hc', mul_zero, measureReal_def] using this
  · intro h
    have := h.const_mul ‖c‖
    simpa only [mul_zero, measureReal_def] using this

theorem mem_factorSets_iff {A : Set Ω} :
    A ∈ factorSets T hT l ↔ MeasurableSet A ∧ Filter.Tendsto (fun y => μ ((T y ⁻¹' A) ∆ A)) l (nhds 0) :=
  ⟨fun ⟨hA, h⟩ => ⟨hA, (indicatorConstLp_mem_contVec_iff T hT l hA one_ne_zero).mp h⟩,
    fun ⟨hA, h⟩ => ⟨hA, (indicatorConstLp_mem_contVec_iff T hT l hA one_ne_zero).mpr h⟩⟩

variable {T hT l}

theorem indicatorConstLp_mem_contVec {A : Set Ω} (hA : MeasurableSet A)
    (h : Filter.Tendsto (fun y => μ ((T y ⁻¹' A) ∆ A)) l (nhds 0)) (c : ℝ) :
    indicatorConstLp 2 hA (measure_ne_top μ A) c ∈ contVec T hT l := by
  by_cases hc : c = 0
  · subst hc
    show Filter.Tendsto (fun y => ‖Lp.compMeasurePreserving (T y) (hT y) _ - _‖) l (nhds 0)
    simp only [norm_comp_indicator_sub (hT _) hA, norm_zero, zero_mul]
    exact tendsto_const_nhds
  · exact (indicatorConstLp_mem_contVec_iff T hT l hA hc).mpr h

theorem const_mem_contVec (c : ℝ) :
    indicatorConstLp 2 MeasurableSet.univ (measure_ne_top μ Set.univ) c ∈ contVec T hT l :=
  indicatorConstLp_mem_contVec MeasurableSet.univ (by simpa using tendsto_const_nhds) c

theorem empty_mem_factorSets : ∅ ∈ factorSets T hT l :=
  (mem_factorSets_iff T hT l).mpr ⟨MeasurableSet.empty, by simpa using tendsto_const_nhds⟩

theorem compl_mem_factorSets {A : Set Ω} (hA : A ∈ factorSets T hT l) : Aᶜ ∈ factorSets T hT l := by
  obtain ⟨hAm, h⟩ := (mem_factorSets_iff T hT l).mp hA
  refine (mem_factorSets_iff T hT l).mpr ⟨hAm.compl, ?_⟩
  simpa only [Set.preimage_compl, compl_symmDiff_compl] using h

theorem union_mem_factorSets {A B : Set Ω} (hA : A ∈ factorSets T hT l) (hB : B ∈ factorSets T hT l) :
    A ∪ B ∈ factorSets T hT l := by
  obtain ⟨hAm, hA'⟩ := (mem_factorSets_iff T hT l).mp hA
  obtain ⟨hBm, hB'⟩ := (mem_factorSets_iff T hT l).mp hB
  refine (mem_factorSets_iff T hT l).mpr ⟨hAm.union hBm, ?_⟩
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le (h := fun y => μ ((T y ⁻¹' A) ∆ A) + μ ((T y ⁻¹' B) ∆ B))
    tendsto_const_nhds (by simpa using hA'.add hB') (fun y => zero_le) fun y => ?_
  refine (measure_mono ?_).trans (measure_union_le _ _)
  intro ω hω
  simp only [Set.mem_symmDiff, Set.mem_preimage, Set.mem_union] at hω ⊢
  tauto

theorem iUnion_mem_factorSets {f : ℕ → Set Ω} (hf : ∀ i, f i ∈ factorSets T hT l) :
    (⋃ i, f i) ∈ factorSets T hT l := by
  have hfm : ∀ i, MeasurableSet (f i) := fun i => ((mem_factorSets_iff T hT l).mp (hf i)).1
  have hacc : ∀ n, Set.accumulate f n ∈ factorSets T hT l := by
    intro n
    induction n with
    | zero => simpa [Set.accumulate] using hf 0
    | succ n ih =>
      rw [Set.accumulate_succ]
      exact union_mem_factorSets ih (hf (n + 1))
  have hU : MeasurableSet (⋃ i, f i) := MeasurableSet.iUnion hfm
  have haccm : ∀ n, MeasurableSet (Set.accumulate f n) := fun n => ((mem_factorSets_iff T hT l).mp (hacc n)).1
  refine ⟨hU, ?_⟩
  have hlim : Filter.Tendsto (fun n => indicatorConstLp 2 (haccm n) (measure_ne_top μ _) (1 : ℝ)) Filter.atTop
      (nhds (indicatorConstLp 2 hU (measure_ne_top μ _) (1 : ℝ))) := by
    refine tendsto_indicatorConstLp_set (by simp) ?_
    have hsub : ∀ n, Set.accumulate f n ⊆ ⋃ i, f i := fun n => Set.accumulate_subset_iUnion n
    have h1 : ∀ n, μ (Set.accumulate f n ∆ ⋃ i, f i) = μ (⋃ i, f i) - μ (Set.accumulate f n) := by
      intro n
      rw [Set.symmDiff_def, Set.sdiff_eq_empty.mpr (hsub n), Set.empty_union,
        measure_sdiff (hsub n) (haccm n).nullMeasurableSet (measure_ne_top μ _)]
    simp only [h1]
    have h2 := tendsto_measure_iUnion_accumulate (μ := μ) (f := f)
    have := ENNReal.Tendsto.sub (tendsto_const_nhds (x := μ (⋃ i, f i))) h2 (Or.inl (measure_ne_top μ _))
    simpa using this
  refine (isClosed_contVec T hT l).mem_of_tendsto hlim (Filter.Eventually.of_forall fun n => ?_)
  obtain ⟨_, h⟩ := hacc n
  exact h

variable (T hT l) in
/-- The events with `l`-continuous indicators, as a σ-algebra. -/
@[reducible] def factorSetsSpace : MeasurableSpace Ω where
  MeasurableSet' A := A ∈ factorSets T hT l
  measurableSet_empty := empty_mem_factorSets
  measurableSet_compl _ h := compl_mem_factorSets h
  measurableSet_iUnion _ h := iUnion_mem_factorSets h

end

end FactorProofs

/-- **J45-N2 (i)**: the events with `l`-continuous indicators are a σ-algebra. -/
theorem measurableSet_factorSigma_iff [IsProbabilityMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (l : Filter R) {A : Set Ω} : MeasurableSet[factorSigma T hT l] A ↔ A ∈ factorSets T hT l := by
  refine ⟨fun h => ?_, fun h => MeasurableSpace.measurableSet_generateFrom h⟩
  exact MeasurableSpace.generateFrom_le (m := factorSetsSpace T hT l) (fun _ h => h) A h

section FactorProofs

/-- The clamp `ψ_n(x) = max 0 (min 1 ((n + 1) x))`: `(n + 1)`-Lipschitz, `0` at `0`, and within `1_{0 < x < 1/(n+1)}` of the
indicator of `(0, ∞)`. -/
def clamp (n : ℕ) (x : ℝ) : ℝ := max 0 (min 1 ((n + 1 : ℝ) * x))

theorem clamp_zero (n : ℕ) : clamp n 0 = 0 := by simp [clamp]

theorem lipschitzWith_clamp (n : ℕ) : LipschitzWith (n + 1 : NNReal) (clamp n) := by
  have h1 : LipschitzWith (n + 1 : NNReal) (fun x : ℝ => (n + 1 : ℝ) * x) :=
    LipschitzWith.of_dist_le_mul fun x y => by
      rw [Real.dist_eq, Real.dist_eq, ← mul_sub, abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ n + 1)]
      push_cast
      exact le_rfl
  exact (h1.const_min 1).const_max 0

theorem abs_clamp_sub_le (n : ℕ) (t a : ℝ) :
    |clamp n (a - t) - (if t < a then 1 else 0)| ≤ |if t < a ∧ (n + 1 : ℝ) * (a - t) < 1 then (1 : ℝ) else 0| := by
  unfold clamp
  have hn : (0 : ℝ) < n + 1 := by positivity
  by_cases hx : t < a
  · have hpos : 0 < a - t := sub_pos.mpr hx
    by_cases hx1 : (n + 1 : ℝ) * (a - t) < 1
    · rw [if_pos hx, if_pos ⟨hx, hx1⟩, min_eq_right hx1.le, max_eq_right (mul_pos hn hpos).le, abs_one, abs_le]
      constructor <;> nlinarith [mul_pos hn hpos]
    · rw [if_pos hx, if_neg (fun h => hx1 h.2), min_eq_left (not_lt.mp hx1), max_eq_right zero_le_one]
      simp
  · rw [if_neg hx, if_neg (fun h => hx h.1)]
    have h0 : (n + 1 : ℝ) * (a - t) ≤ 0 := mul_nonpos_of_nonneg_of_nonpos hn.le (sub_nonpos.mpr (not_lt.mp hx))
    rw [min_eq_right (h0.trans zero_le_one), max_eq_left h0]
    simp

section
variable [IsProbabilityMeasure μ] {T : R → Ω → Ω} {hT : ∀ y, MeasurePreserving (T y) μ μ} {l : Filter R}

/-- A superlevel set of an `l`-continuous vector has an `l`-continuous indicator: `1_{f > t}` is the `L²`-limit of the clamps
of `f − t`. -/
theorem setOf_lt_mem_factorSets {f : Lp ℝ 2 μ} (hf : f ∈ contVec T hT l) (t : ℝ) :
    {ω | t < f ω} ∈ factorSets T hT l := by
  have hfm : Measurable (f : Ω → ℝ) := (Lp.stronglyMeasurable f).measurable
  have hm : MeasurableSet {ω | t < f ω} := measurableSet_lt measurable_const hfm
  refine ⟨hm, ?_⟩
  have hh : f - indicatorConstLp 2 MeasurableSet.univ (measure_ne_top μ Set.univ) t ∈ contVec T hT l :=
    sub_mem_contVec hf (const_mem_contVec t)
  set h : Lp ℝ 2 μ := f - indicatorConstLp 2 MeasurableSet.univ (measure_ne_top μ Set.univ) t with hdef
  have hh_ae : ∀ᵐ ω ∂μ, h ω = f ω - t := by
    filter_upwards [Lp.coeFn_sub f (indicatorConstLp 2 MeasurableSet.univ (measure_ne_top μ Set.univ) t),
      indicatorConstLp_coeFn (p := 2) (hs := MeasurableSet.univ) (hμs := measure_ne_top μ Set.univ) (c := t)]
      with ω h1 h2
    rw [hdef, h1, Pi.sub_apply, h2]
    simp
  let D : ℕ → Set Ω := fun n => {ω | t < f ω ∧ (n + 1 : ℝ) * (f ω - t) < 1}
  have hDm : ∀ n, MeasurableSet (D n) := fun n =>
    hm.inter (measurableSet_lt (measurable_const.mul (hfm.sub measurable_const)) measurable_const)
  have hbound : ∀ n, ‖(lipschitzWith_clamp n).compLp (clamp_zero n) h - indicatorConstLp 2 hm (measure_ne_top μ _) (1 : ℝ)‖ ≤
      ‖indicatorConstLp 2 (hDm n) (measure_ne_top μ _) (1 : ℝ)‖ := by
    intro n
    refine Lp.norm_le_norm_of_ae_le ?_
    filter_upwards [Lp.coeFn_sub ((lipschitzWith_clamp n).compLp (clamp_zero n) h)
        (indicatorConstLp 2 hm (measure_ne_top μ _) (1 : ℝ)),
      (lipschitzWith_clamp n).coeFn_compLp (clamp_zero n) h, hh_ae,
      indicatorConstLp_coeFn (p := 2) (hs := hm) (hμs := measure_ne_top μ _) (c := (1 : ℝ)),
      indicatorConstLp_coeFn (p := 2) (hs := hDm n) (hμs := measure_ne_top μ _) (c := (1 : ℝ))] with ω e1 e2 e3 e4 e5
    rw [e1, Pi.sub_apply, e2, Function.comp_apply, e3, e4, e5, Real.norm_eq_abs, Real.norm_eq_abs]
    simp only [Set.indicator_apply, Set.mem_setOf_eq, D]
    exact abs_clamp_sub_le n t (f ω)
  have hD0 : Filter.Tendsto (fun n => ‖indicatorConstLp 2 (hDm n) (measure_ne_top μ _) (1 : ℝ)‖) Filter.atTop (nhds 0) := by
    have hanti : Antitone D := by
      intro n k hnk ω hω
      refine ⟨hω.1, lt_of_le_of_lt ?_ hω.2⟩
      have h1 : (n : ℝ) ≤ k := Nat.cast_le.mpr hnk
      have h2 : 0 < f ω - t := sub_pos.mpr hω.1
      nlinarith
    have hInter : ⋂ n, D n = ∅ := by
      ext ω
      simp only [Set.mem_iInter, Set.mem_empty_iff_false, iff_false, not_forall]
      by_cases h1 : t < f ω
      · obtain ⟨n, hn⟩ := exists_nat_gt (1 / (f ω - t))
        refine ⟨n, fun h2 => ?_⟩
        have hpos : 0 < f ω - t := sub_pos.mpr h1
        rw [div_lt_iff₀ hpos] at hn
        have := h2.2
        nlinarith
      · exact ⟨0, fun h => h1 h.1⟩
    have h := tendsto_measure_iInter_atTop (μ := μ) (fun n => (hDm n).nullMeasurableSet) hanti ⟨0, measure_ne_top μ _⟩
    rw [hInter, measure_empty] at h
    have h' := (tendsto_sqrt_toReal_iff (fun n => measure_ne_top μ (D n))).mpr h
    simpa [norm_indicatorConstLp_two, measureReal_def] using h'
  have hlim : Filter.Tendsto (fun n => (lipschitzWith_clamp n).compLp (clamp_zero n) h) Filter.atTop
      (nhds (indicatorConstLp 2 hm (measure_ne_top μ _) (1 : ℝ))) := by
    rw [tendsto_iff_norm_sub_tendsto_zero]
    exact squeeze_zero (fun n => norm_nonneg _) hbound hD0
  exact (isClosed_contVec T hT l).mem_of_tendsto hlim
    (Filter.Eventually.of_forall fun n => lipschitz_comp_mem_contVec _ _ hh)

theorem aestronglyMeasurable_of_mem_contVec {f : Lp ℝ 2 μ} (hf : f ∈ contVec T hT l) :
    AEStronglyMeasurable[factorSigma T hT l] f μ := by
  have hmeas : Measurable[factorSigma T hT l] (f : Ω → ℝ) :=
    measurable_of_Ioi fun t => (measurableSet_factorSigma_iff T hT l).mpr (setOf_lt_mem_factorSets hf t)
  exact hmeas.stronglyMeasurable.aestronglyMeasurable

theorem mem_contVec_of_aestronglyMeasurable {f : Lp ℝ 2 μ} (hf : AEStronglyMeasurable[factorSigma T hT l] f μ) :
    f ∈ contVec T hT l := by
  refine Lp.induction_stronglyMeasurable (factorSigma_le T hT l) (by simp) (fun g => g ∈ contVec T hT l) ?_ ?_ ?_ f hf
  · intro c s hs hμs
    rw [Lp.simpleFunc.coe_indicatorConst]
    obtain ⟨hsm, h⟩ := (mem_factorSets_iff T hT l).mp ((measurableSet_factorSigma_iff T hT l).mp hs)
    exact indicatorConstLp_mem_contVec hsm h c
  · intro f g hf hg _ _ _ hPf hPg
    exact add_mem_contVec hPf hPg
  · exact (isClosed_contVec T hT l).preimage continuous_subtype_val

end

end FactorProofs

/-- **J45-N2 (ii)**: "these `f` form `L²(𝒜)`" — the `l`-continuous vectors are exactly the `𝒜_l`-measurable ones; so the
orthogonal projection onto them is `E[· | 𝒜_l]` (Mathlib's `condExpL2` is the projection onto `lpMeas`). -/
theorem contVec_eq_lpMeas [IsProbabilityMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) :
    contVec T hT l = (lpMeas ℝ ℝ (factorSigma T hT l) 2 μ : Set (Lp ℝ 2 μ)) := by
  ext f
  rw [SetLike.mem_coe, mem_lpMeas_iff_aestronglyMeasurable]
  exact ⟨aestronglyMeasurable_of_mem_contVec, mem_contVec_of_aestronglyMeasurable⟩

/-- **J45-N2 (iii)**: "for a translation-invariant σ-algebra" — when the maps commute, `𝒜_l` is invariant under each. -/
theorem measurableSet_preimage_factorSigma [IsProbabilityMeasure μ] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (hcomm : ∀ x y, T x ∘ T y = T y ∘ T x) (l : Filter R) (x : R) {A : Set Ω}
    (hA : MeasurableSet[factorSigma T hT l] A) : MeasurableSet[factorSigma T hT l] (T x ⁻¹' A) := by
  rw [measurableSet_factorSigma_iff] at hA ⊢
  obtain ⟨hAm, h⟩ := (mem_factorSets_iff T hT l).mp hA
  refine (mem_factorSets_iff T hT l).mpr ⟨hAm.preimage (hT x).measurable, ?_⟩
  have key : ∀ y, μ (symmDiff (T y ⁻¹' (T x ⁻¹' A)) (T x ⁻¹' A)) = μ (symmDiff (T y ⁻¹' A) A) := by
    intro y
    have e1 : T y ⁻¹' (T x ⁻¹' A) = T x ⁻¹' (T y ⁻¹' A) := by
      rw [← Set.preimage_comp, ← Set.preimage_comp, hcomm x y]
    have e : symmDiff (T y ⁻¹' (T x ⁻¹' A)) (T x ⁻¹' A) = T x ⁻¹' (symmDiff (T y ⁻¹' A) A) := by
      rw [e1]
      rfl
    rw [e, (hT x).measure_preimage ((hAm.preimage (hT y).measurable).symmDiff hAm).nullMeasurableSet]
  simpa only [key] using h

/-! ### "`Π(E_S) = E[· | 𝒜_S]`": Mathlib's `condExpL2` is the orthogonal projection onto the continuous vectors -/

section
variable [IsProbabilityMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R)

/-- **J45-N2, last clause — "`Π(E_S) = E[· | 𝒜_S]`"**, first of three: Mathlib's `condExpL2` for the factor σ-algebra `𝒜_l`
takes its values among the `l`-continuous vectors. -/
theorem condExpL2_mem_contVec (f : Lp ℝ 2 μ) :
    (condExpL2 ℝ ℝ (factorSigma_le T hT l) f : Lp ℝ 2 μ) ∈ contVec T hT l := by
  rw [contVec_eq_lpMeas T hT l]
  exact (condExpL2 ℝ ℝ (factorSigma_le T hT l) f).2

/-- Second: `E[· | 𝒜_l]` fixes exactly the `l`-continuous vectors. -/
theorem condExpL2_eq_self_iff (f : Lp ℝ 2 μ) :
    (condExpL2 ℝ ℝ (factorSigma_le T hT l) f : Lp ℝ 2 μ) = f ↔ f ∈ contVec T hT l := by
  haveI : Fact (factorSigma T hT l ≤ ‹MeasurableSpace Ω›) := ⟨factorSigma_le T hT l⟩
  have h := Submodule.starProjection_eq_self_iff (K := lpMeas ℝ ℝ (factorSigma T hT l) 2 μ) (v := f)
  rw [contVec_eq_lpMeas T hT l]
  exact h

/-- Third: the residual `f − E[f | 𝒜_l]` is orthogonal to every `l`-continuous vector. So `E[· | 𝒜_l]` is the orthogonal
projection of `L²(μ)` onto the `l`-continuous vectors. -/
theorem inner_sub_condExpL2_eq_zero (f : Lp ℝ 2 μ) {g : Lp ℝ 2 μ} (hg : g ∈ contVec T hT l) :
    inner ℝ (f - (condExpL2 ℝ ℝ (factorSigma_le T hT l) f : Lp ℝ 2 μ)) g = 0 := by
  haveI : Fact (factorSigma T hT l ≤ ‹MeasurableSpace Ω›) := ⟨factorSigma_le T hT l⟩
  rw [contVec_eq_lpMeas T hT l] at hg
  exact Submodule.starProjection_inner_eq_zero (K := lpMeas ℝ ℝ (factorSigma T hT l) 2 μ) f g hg

end

/-- The model: under the identity family every vector is continuous along every filter. -/
theorem contVec_id (l : Filter R) :
    contVec (μ := μ) (fun _ : R => id) (fun _ => MeasurePreserving.id μ) l = Set.univ := by
  refine Set.eq_univ_of_forall fun f => ?_
  have h : Lp.compMeasurePreserving (id : Ω → Ω) (MeasurePreserving.id μ) f = f := by
    apply Lp.ext
    filter_upwards [Lp.coeFn_compMeasurePreserving f (MeasurePreserving.id μ)] with ω hω
    rw [hω]
    rfl
  show Filter.Tendsto (fun y : R => ‖Lp.compMeasurePreserving (id : Ω → Ω) (MeasurePreserving.id μ) f - f‖) l (nhds 0)
  simp only [h, sub_self, norm_zero]
  exact tendsto_const_nhds

end Factor

/-! ## The spectral half of N2 and the Haar-null clause of N1 -/

noncomputable section Spectral

variable {R : Type*} [AddCommGroup R] {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- The characters of `R` continuous for a topology `t` on `R` — J45's `E_S` when `t = τ′_S`. -/
def contChars (t : TopologicalSpace R) : Set (AddChar R Circle) := {χ | @Continuous R Circle t _ fun y : R => χ y}

/-- **Bochner's theorem for the topology `t`, a named classical hypothesis**: a finite measure on the characters of `R` whose
Fourier transform is `t`-continuous is carried by the `t`-continuous characters. True when `t` is induced by a homomorphism with
dense range into a locally compact abelian group `G′` (Bochner on `G′`, Rudin, *Fourier Analysis on Groups* 1.4.3, with the
uniqueness of Fourier–Stieltjes coefficients on the compact dual of `R`): J45 Lemma N2's `⟸`. False for some group topologies
that are not locally compact, which is why it is a hypothesis on `t`. -/
def BochnerOn (t : TopologicalSpace R) : Prop :=
  ∀ σ : Measure (AddChar R Circle), IsFiniteMeasure σ →
    @Continuous R ℂ t _ (fun y : R => ∫ χ, (χ y : ℂ) ∂σ) → σ (contChars t)ᶜ = 0

/-- **A spectral measure of `f ∈ L²(μ)`** under the maps `T y`: `∫ χ(y) dσ = ⟨f, f ∘ T y⟩` for every `y`. -/
def IsSpectralMeasureOf (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (f : Lp ℝ 2 μ)
    (σ : Measure (AddChar R Circle)) : Prop :=
  IsFiniteMeasure σ ∧ ∀ y : R, ∫ χ, (χ y : ℂ) ∂σ = ((∫ ω, f ω * Lp.compMeasurePreserving (T y) (hT y) f ω ∂μ : ℝ) : ℂ)

/-- **J45-N2, first sentence**: "`σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous" — for a first-countable group topology
`t` on `R` satisfying Bochner's theorem and an action by measure-preserving maps. -/
theorem spectral_carried_iff [IsProbabilityMeasure μ] (t : TopologicalSpace R)
    (ht : @IsTopologicalAddGroup R t _) (hcount : (@nhds R t 0).IsCountablyGenerated) (hB : BochnerOn t)
    (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (hadd : ∀ x y, T (x + y) = T x ∘ T y)
    {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)} (hσ : IsSpectralMeasureOf T hT f σ) :
    σ (contChars t)ᶜ = 0 ↔ f ∈ contVec T hT (@nhds R t 0) := by
  sorry

/-- Bochner's theorem holds for the discrete topology: every character is continuous. The hypothesis' model. -/
theorem bochnerOn_bot : BochnerOn (⊥ : TopologicalSpace R) := fun σ _ _ => by
  have h : contChars (⊥ : TopologicalSpace R) = Set.univ :=
    Set.eq_univ_of_forall fun χ => (continuous_bot : @Continuous R Circle ⊥ _ fun y => χ y)
  rw [h, Set.compl_univ, measure_empty]

/-- **J45-N1 (c), the clause the chain consumes**: "`E_S` is a proper dense … subgroup, Haar-null" — the `t`-continuous
characters are Haar-null when they are measurable, separate the points of `R` (dense) and are not all characters (proper).
Route on the Fourier side, with no topology on the dual and no Steinhaus–Weil: for `H = contChars t` with `m(H) > 0`, the
Fourier coefficients of `1_H·m` vanish off `0` (translation by `h ∈ H` multiplies the `r`-th one by `h(r)`, and `H` separates
points), so `1_H·m = m(H)·m` by Herglotz–Bochner's uniqueness, `m(H) = 1`, and a second coset would have measure `1` too. -/
theorem contChars_haar_null (hBH : BochnerHerglotz R) (t : TopologicalSpace R) (hmeas : MeasurableSet (contChars t))
    (hsep : ∀ r : R, r ≠ 0 → ∃ χ ∈ contChars t, χ r ≠ 1) (hproper : contChars t ≠ Set.univ)
    {m : Measure (AddChar R Circle)} (hm : IsHaarFourier m) : m (contChars t) = 0 := by
  sorry

end Spectral

/-! ## SI-4: a selection from disjoint conditional supports -/

noncomputable section Selection

variable {Ω : Type*} {V : Type*}

/-- The conditional support `M(x) = {j : P(c(x) = j | 𝒜) > 0}`, for Mathlib's version of the conditional expectation. -/
def condSupport (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin 4) (ω : Ω) (x : V) :
    Finset (Fin 4) :=
  Finset.univ.filter fun j => 0 < (μ[(Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) | 𝒜]) ω

/-- **J45-SI-4, at the class its argument reads**: "equality at every `u` ⟹ every selection from the supports is an
`𝒜_S`-measurable … proper four-colouring". For any countable graph `adj` on `V`, any sub-σ-algebra `𝒜` and any random
colouring `c` (properness of `c` is not read): if the conditional laws at adjacent vertices are orthogonal
(`Σ_j E[p_j(x) p_j(y)] = 0`, SI-3's form of equality), then for every choice function `f` the colouring `f ∘ M` is
`𝒜`-measurable, almost surely proper, and `c(x) ∈ M(x)` almost surely (SI-2). The equivariance clause is
`plans/FS131-w10-kernel-plan.md` § 3's child `si4_equivariant`. -/
theorem si4 [Countable V] (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (h𝒜 : 𝒜 ≤ m0)
    (c : Ω → V → Fin 4) (hc : ∀ x, Measurable fun ω => c ω x) (adj : V → V → Prop)
    (hdisj : ∀ x y, adj x y → ∀ j : Fin 4,
      ∫ ω, (μ[(Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) | 𝒜]) ω *
        (μ[(Set.indicator {ω' | c ω' y = j} fun _ => (1 : ℝ)) | 𝒜]) ω ∂μ = 0)
    (f : Finset (Fin 4) → Fin 4) (hf : ∀ s : Finset (Fin 4), s.Nonempty → f s ∈ s) :
    (∀ x, Measurable[𝒜] fun ω => f (condSupport 𝒜 μ c ω x)) ∧
      (∀ᵐ ω ∂μ, ∀ x y, adj x y → f (condSupport 𝒜 μ c ω x) ≠ f (condSupport 𝒜 μ c ω y)) ∧
      ∀ᵐ ω ∂μ, ∀ x, c ω x ∈ condSupport 𝒜 μ c ω x := by
  sorry

end Selection

/-! ## Spec -/

-- `contChars` at the discrete topology is every character; at the indiscrete one only the constant ones are continuous.
example : contChars (⊥ : TopologicalSpace ℤ) = Set.univ :=
  Set.eq_univ_of_forall fun χ => (continuous_bot : @Continuous ℤ Circle ⊥ _ fun y => χ y)

-- `IsHaarFourier` would drift if the `r ≠ 0` guard were dropped: at `r = 0` the coefficient of a probability measure is `1`.
example (m : Measure (AddChar ℤ Circle)) (hm : IsHaarFourier m) : ∫ χ, (χ 0 : ℂ) ∂m = 1 := by
  haveI := hm.1
  simp

-- `clamp` would drift if its slope or its two cut-offs moved.
example : clamp 0 (1 / 2) = 1 / 2 := by norm_num [clamp]
example : clamp 3 1 = 1 := by norm_num [clamp]
example : clamp 3 (-1) = 0 := by norm_num [clamp]

-- `factorSetsSpace` is the σ-algebra whose measurable sets are exactly `factorSets`.
example {R Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsFiniteMeasure μ] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) (A : Set Ω) :
    MeasurableSet[factorSetsSpace T hT l] A ↔ A ∈ factorSets T hT l := Iff.rfl

end HadwigerNelson.SpectralInputs
