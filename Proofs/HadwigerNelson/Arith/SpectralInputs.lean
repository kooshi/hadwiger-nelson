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
  are a proper measurable subgroup separating the points of a torsion-free `R`.
* **J45-SI-4** (`si4`): if the conditional supports of a random colouring given a sub-σ-algebra `𝒜` are disjoint across every
  edge, any selection from the supports is an `𝒜`-measurable proper colouring — for any countable graph and any `𝒜`.

**Not stated in this pass** (their foundation is listed in `plans/FS131-w10-kernel-plan.md` § 3): J45-N1 (a)–(b) (the topology
`τ′_S` and its three summands), J45-SI-5, J45-SI-J, J45-SI-C.

**Inhabitants.** `IsHaarFourier` is satisfiable given Herglotz–Bochner (`exists_isHaarFourier`). `contVec`, `factorSets` and
`factorSigma` take plain data; the identity family `T y = id` is a model (`contVec_id`). `sp_if`'s hypothesis — a non-Haar finite
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

/-- **J45-N2 (i)**: the events with `l`-continuous indicators are a σ-algebra. -/
theorem measurableSet_factorSigma_iff [IsProbabilityMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (l : Filter R) {A : Set Ω} : MeasurableSet[factorSigma T hT l] A ↔ A ∈ factorSets T hT l := by
  sorry

/-- **J45-N2 (ii)**: "these `f` form `L²(𝒜)`" — the `l`-continuous vectors are exactly the `𝒜_l`-measurable ones; so the
orthogonal projection onto them is `E[· | 𝒜_l]` (Mathlib's `condExpL2` is the projection onto `lpMeas`). -/
theorem contVec_eq_lpMeas [IsProbabilityMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (l : Filter R) :
    contVec T hT l = (lpMeas ℝ ℝ (factorSigma T hT l) 2 μ : Set (Lp ℝ 2 μ)) := by
  sorry

/-- **J45-N2 (iii)**: "for a translation-invariant σ-algebra" — when the maps commute, `𝒜_l` is invariant under each. -/
theorem measurableSet_preimage_factorSigma [IsProbabilityMeasure μ] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (hcomm : ∀ x y, T x ∘ T y = T y ∘ T x) (l : Filter R) (x : R) {A : Set Ω}
    (hA : MeasurableSet[factorSigma T hT l] A) : MeasurableSet[factorSigma T hT l] (T x ⁻¹' A) := by
  sorry

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

/-- **J45-N1 (c), the clause the chain consumes**: "`E_S` is a proper dense … subgroup, Haar-null" — the `t`-continuous
characters of a countable torsion-free `R` are Haar-null when they are measurable, separate the points of `R` (dense) and are
not all characters (proper). Steinhaus–Weil in the compact connected dual. -/
theorem contChars_haar_null [Countable R] (htf : ∀ (n : ℕ) (x : R), n ≠ 0 → n • x = 0 → x = 0) (t : TopologicalSpace R)
    (ht : @IsTopologicalAddGroup R t _) (hmeas : MeasurableSet (contChars t))
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

end HadwigerNelson.SpectralInputs
