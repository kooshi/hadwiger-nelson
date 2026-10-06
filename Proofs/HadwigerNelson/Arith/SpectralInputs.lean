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

**Added with the proofs (FS131-I10A).** N2's last clause, "`Π(E_S) = E[· | 𝒜_S]`", as three statements about Mathlib's
`condExpL2` for `factorSigma` (`condExpL2_mem_contVec`, `condExpL2_eq_self_iff`, `inner_sub_condExpL2_eq_zero`); SI-4's
equivariance clause (`si4_equivariant`, over `condExp_comp_measurePreserving`); Fourier uniqueness on the characters from
Herglotz–Bochner's uniqueness clause (`ext_of_fourier`, over `posDef_fourier`), and the translation invariance of Haar measure
(`IsHaarFourier.map_mulRight`).

**Inhabitants.** `IsHaarFourier` is satisfiable given Herglotz–Bochner (`exists_isHaarFourier`). `contVec`, `factorSets` and
`factorSigma` take plain data; the identity family `T y = id` is a model (`contVec_id`). `BochnerOn` holds at the discrete
topology (`bochnerOn_bot`). `sp_if`'s hypothesis — a non-Haar finite
rotation-invariant `E`-null measure — is the open zero-entropy question over the arithmetic `E` (J45 §4.2, "Not claimed"); at
`Interface.trivial` (`E = ∅`) it is met by the point mass at the trivial character. **`Interface.NegCircle` has no Lean model on
file** (one is planned at `F = ℚ`, `Arith/NegCircleModel` on the wave's second pass): `sp_if` is an open gate item until it lands.
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

/-! ### Fourier uniqueness, from Herglotz–Bochner's uniqueness clause -/

/-- A map into the characters is measurable (for the cylinder σ-algebra) as soon as each evaluation is. -/
theorem measurable_of_evalChar {X : Type*} [MeasurableSpace X] {g : X → AddChar G Circle}
    (h : ∀ y, Measurable fun x => ((g x) y : ℂ)) : Measurable g :=
  measurable_comap_iff.mpr (measurable_pi_iff.mpr h)

theorem integrable_evalChar (σ : Measure (AddChar G Circle)) [IsFiniteMeasure σ] (y : G) :
    Integrable (fun χ : AddChar G Circle => (χ y : ℂ)) σ :=
  Integrable.of_bound (measurable_evalChar y).aestronglyMeasurable 1 (Filter.Eventually.of_forall fun χ => by simp)

theorem coe_char_sub (χ : AddChar G Circle) (x y : G) :
    (χ (x - y) : ℂ) = (χ x : ℂ) * (starRingEnd ℂ) (χ y : ℂ) := by
  rw [AddChar.map_sub_eq_div, div_eq_mul_inv, Circle.coe_mul, Circle.coe_inv_eq_conj]

/-- The Fourier–Stieltjes transform of a finite measure on the characters is positive definite:
`Σ z_x z̄_y σ̂(x − y) = ∫ |Σ z_x χ(x)|² dσ`. -/
theorem posDef_fourier (σ : Measure (AddChar G Circle)) [IsFiniteMeasure σ] :
    PosDef (fun y => ∫ χ, (χ y : ℂ) ∂σ) := by
  intro s z
  have hint : ∀ x y : G, Integrable (fun χ : AddChar G Circle => z x * star (z y) * (χ (x - y) : ℂ)) σ :=
    fun x y => (integrable_evalChar σ (x - y)).const_mul _
  have hpt : ∀ χ : AddChar G Circle, ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * (χ (x - y) : ℂ) =
      ((Complex.normSq (∑ x ∈ s, z x * (χ x : ℂ)) : ℝ) : ℂ) := by
    intro χ
    rw [← Complex.mul_conj, map_sum, Finset.sum_mul_sum]
    refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
    rw [coe_char_sub, map_mul, Complex.star_def]
    ring
  have key : ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * ∫ χ, (χ (x - y) : ℂ) ∂σ =
      ((∫ χ, Complex.normSq (∑ x ∈ s, z x * (χ x : ℂ)) ∂σ : ℝ) : ℂ) := by
    have h1 : ∀ x y, z x * star (z y) * ∫ χ, (χ (x - y) : ℂ) ∂σ =
        ∫ χ, z x * star (z y) * (χ (x - y) : ℂ) ∂σ := fun x y => (integral_const_mul _ _).symm
    have h2 : ∀ x, ∑ y ∈ s, ∫ χ, z x * star (z y) * (χ (x - y) : ℂ) ∂σ =
        ∫ χ, ∑ y ∈ s, z x * star (z y) * (χ (x - y) : ℂ) ∂σ :=
      fun x => (integral_finsetSum s fun y _ => hint x y).symm
    simp only [h1, h2]
    rw [← integral_finsetSum s fun x _ => integrable_finsetSum s fun y _ => hint x y, ← integral_complex_ofReal]
    exact integral_congr_ae (ae_of_all _ hpt)
  rw [key]
  exact ⟨Complex.ofReal_im _, by
    rw [Complex.ofReal_re]; exact integral_nonneg fun χ => Complex.normSq_nonneg _⟩

/-- **Fourier uniqueness on the characters**, from Herglotz–Bochner's uniqueness clause: two finite measures with the same
Fourier coefficients are equal. -/
theorem ext_of_fourier (hBH : BochnerHerglotz G) {σ σ' : Measure (AddChar G Circle)} [IsFiniteMeasure σ]
    [IsFiniteMeasure σ'] (h : ∀ y, ∫ χ, (χ y : ℂ) ∂σ = ∫ χ, (χ y : ℂ) ∂σ') : σ = σ' := by
  obtain ⟨σ₀, -, -, huniq⟩ := hBH _ (posDef_fourier σ')
  rw [huniq σ inferInstance h, huniq σ' inferInstance fun _ => rfl]

/-- `a·δ₀` is positive definite for `a ≥ 0`: the double sum is `a Σ |z_x|²`. -/
theorem posDef_delta [DecidableEq G] {a : ℝ} (ha : 0 ≤ a) : PosDef (fun y : G => if y = 0 then (a : ℂ) else 0) := by
  intro s z
  have key : ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * (if x - y = 0 then (a : ℂ) else 0) =
      ((∑ x ∈ s, Complex.normSq (z x) * a : ℝ) : ℂ) := by
    push_cast
    refine Finset.sum_congr rfl fun x hx => ?_
    have h : ∀ y, z x * star (z y) * (if x - y = 0 then (a : ℂ) else 0) = if x = y then z x * star (z y) * a else 0 := by
      intro y
      simp only [sub_eq_zero, mul_ite, mul_zero]
    simp only [h, Finset.sum_ite_eq, hx, if_true]
    rw [← Complex.mul_conj, Complex.star_def]
  rw [key]
  exact ⟨Complex.ofReal_im _, by
    rw [Complex.ofReal_re]; exact Finset.sum_nonneg fun x _ => mul_nonneg (Complex.normSq_nonneg _) ha⟩

theorem integral_evalChar_zero (σ : Measure (AddChar G Circle)) : ∫ χ, (χ 0 : ℂ) ∂σ = (σ.real Set.univ : ℂ) := by
  simp

/-- Haar measure exists in Fourier form, given Herglotz–Bochner: `δ₀` is positive definite. -/
theorem exists_isHaarFourier (hBH : BochnerHerglotz G) : ∃ m : Measure (AddChar G Circle), IsHaarFourier m := by
  classical
  obtain ⟨σ, hfin, hσ, -⟩ := hBH _ (posDef_delta (G := G) zero_le_one)
  refine ⟨σ, ⟨?_⟩, fun r hr => by rw [hσ r, if_neg hr]⟩
  have h0 := hσ 0
  rw [integral_evalChar_zero, if_pos rfl, Complex.ofReal_one, Complex.ofReal_eq_one, measureReal_def,
    ENNReal.toReal_eq_one_iff] at h0
  exact h0

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

/-! ### Haar measure is translation-invariant -/

/-- The Fourier coefficients of Haar measure: `δ₀`. -/
theorem IsHaarFourier.integral_eq [DecidableEq G] {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m) (y : G) :
    ∫ χ, (χ y : ℂ) ∂m = if y = 0 then 1 else 0 := by
  haveI := hm.1
  by_cases hy : y = 0
  · subst hy
    rw [if_pos rfl, integral_evalChar_zero]
    simp
  · rw [if_neg hy, hm.2 y hy]

theorem measurable_mulRight (a : AddChar G Circle) : Measurable fun χ : AddChar G Circle => χ * a :=
  measurable_of_evalChar fun y => by
    simp only [AddChar.mul_apply, Circle.coe_mul]
    exact (measurable_evalChar y).mul_const _

theorem integral_evalChar_map_mulRight (σ : Measure (AddChar G Circle)) (a : AddChar G Circle) (y : G) :
    ∫ χ, (χ y : ℂ) ∂(σ.map fun χ => χ * a) = (∫ χ, (χ y : ℂ) ∂σ) * (a y : ℂ) := by
  rw [integral_map (measurable_mulRight a).aemeasurable (measurable_evalChar y).aestronglyMeasurable,
    ← integral_mul_const]
  simp only [AddChar.mul_apply, Circle.coe_mul]

/-- Haar measure is invariant under every translation of the characters (by uniqueness). -/
theorem IsHaarFourier.map_mulRight (hBH : BochnerHerglotz G) {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m)
    (a : AddChar G Circle) : (m.map fun χ => χ * a) = m := by
  classical
  haveI := hm.1
  refine ext_of_fourier hBH fun y => ?_
  rw [integral_evalChar_map_mulRight, hm.integral_eq]
  by_cases hy : y = 0
  · subst hy
    simp
  · rw [if_neg hy, zero_mul]

theorem measurable_mul_char : Measurable fun p : AddChar G Circle × AddChar G Circle => p.1 * p.2 :=
  measurable_of_evalChar fun y => by
    simp only [AddChar.mul_apply, Circle.coe_mul]
    exact ((measurable_evalChar y).comp measurable_fst).mul ((measurable_evalChar y).comp measurable_snd)

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

/-! ### The proof of SP-if: the dual of a multiplication, rotation by `−1` -/

/-- The dual of multiplication by `r₀` on the ring `R`: `χ ↦ χ(r₀ ·)` (J45 §4.2, SP-if step 2's `m`). -/
def mulDual (r₀ : unitRing F) (χ : Dual F) : Dual F := χ.compAddMonoidHom (AddMonoidHom.mulLeft r₀)

theorem mulDual_apply (r₀ : unitRing F) (χ : Dual F) (y : unitRing F) : mulDual r₀ χ y = χ (r₀ * y) := rfl

theorem measurable_mulDual (r₀ : unitRing F) : Measurable (mulDual r₀) :=
  measurable_of_evalChar fun y => measurable_evalChar (r₀ * y)

theorem rot_apply (u : unitVectors F) (χ : Dual F) (y : unitRing F) : rot u χ y = χ (uvRing u * y) := rfl

theorem rot_comp_mulDual (u : unitVectors F) (r₀ : unitRing F) : rot u ∘ mulDual r₀ = mulDual r₀ ∘ rot u := by
  funext χ
  refine DFunLike.ext _ _ fun y => ?_
  show χ (r₀ * (uvRing u * y)) = χ (uvRing u * (r₀ * y))
  rw [mul_left_comm]

theorem rot_mul (u : unitVectors F) (χ a : Dual F) : rot u (χ * a) = rot u χ * rot u a :=
  DFunLike.ext _ _ fun _ => rfl

/-- `−1 ∈ U`. -/
def negOne (F : Subfield ℝ) : unitVectors F :=
  ⟨-1, ⟨by simp, by simp⟩, by simp⟩

/-- Rotation by `−1` is conjugation of the values: `χ(−y) = conj χ(y)`. -/
theorem rot_negOne_apply (χ : Dual F) (y : unitRing F) :
    ((rot (negOne F) χ) y : ℂ) = (starRingEnd ℂ) (χ y : ℂ) := by
  have h : uvRing (negOne F) * y = -y := by
    apply Subtype.ext
    simp [uvRing, negOne]
  rw [rot_apply, h, AddChar.map_neg_eq_inv, Circle.coe_inv_eq_conj]

/-- **J45-SP-if** (Lemma SP-if, §4.2): "If some finite positive `U`-invariant `ν` with `ν(E) = 0` is not a multiple of Haar,
then some finite positive `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`." Over an interface with `MulStable` and
`NegCircle`; Fourier uniqueness is Herglotz–Bochner's uniqueness clause. INHABITANT: over the arithmetic `E` the hypothesis is
the open zero-entropy question; at `Interface.trivial` it is met by the point mass at the trivial character. MODEL: given
`hBH`, every other hypothesis holds at once at `F = ℚ` with `Interface.trivial` (`sp_if_hypotheses_trivial_bot`,
`Arith/NegCircleModel`, whose spec example applies this theorem to it; its `hcirc` is `negCircle_trivial_bot`, the point mass
at the parity character). **One named classical hypothesis is still assumed**: `hBH` is the Herglotz–Bochner theorem for
the countable discrete group `unitRing ⊥` — a classical theorem named as a hypothesis from outside the backlog
(`plans/FS131-kernel-plan.md` § 7.4), true, not in the kernel; it is a statement to prove, not a structure to inhabit, and
no smaller group serves (`unitRing ⊥ ⊇ ℤ`). Until it is proved this theorem stays an open gate item under the inhabitant
rule (`LEAN.md` § The gate): open by one classical theorem. -/
theorem sp_if (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hmul : I.MulStable)
    (hcirc : I.NegCircle) {ν m : Measure (Dual F)} (hfin : IsFiniteMeasure ν) (hrot : RotInv F ν) (hE : ν I.E = 0)
    (hm : IsHaarFourier m) (hnh : ∀ a : ENNReal, ν ≠ a • m) :
    ∃ τ : Measure (Dual F), IsFiniteMeasure τ ∧ RotInv F τ ∧ τ I.E = 0 ∧ ∫ χ, (χ 1 : ℂ).re ∂τ < 0 := by
  classical
  haveI := hm.1
  -- (1) a non-zero frequency with a non-zero coefficient: Fourier uniqueness
  obtain ⟨r₀, hr₀, hne⟩ : ∃ r₀ : unitRing F, r₀ ≠ 0 ∧ ∫ χ, (χ r₀ : ℂ) ∂ν ≠ 0 := by
    by_contra hall
    have hall' : ∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂ν = 0 := fun r hr => by
      by_contra h
      exact hall ⟨r, hr, h⟩
    haveI : IsFiniteMeasure (ν Set.univ • m) := Measure.smul_finite m (measure_ne_top ν Set.univ)
    refine hnh (ν Set.univ) (ext_of_fourier hBH fun y => ?_)
    rw [integral_smul_measure, hm.integral_eq]
    by_cases hy : y = 0
    · subst hy
      rw [integral_evalChar_zero, if_pos rfl, measureReal_def]
      simp
    · rw [hall' y hy, if_neg hy, smul_zero]
  -- the coefficient is real: rotation by `−1`
  have hreal : (∫ χ, (χ r₀ : ℂ) ∂ν).im = 0 := by
    have h1 : ∫ χ, (χ r₀ : ℂ) ∂ν = (starRingEnd ℂ) (∫ χ, (χ r₀ : ℂ) ∂ν) :=
      calc ∫ χ, (χ r₀ : ℂ) ∂ν = ∫ χ, (χ r₀ : ℂ) ∂(ν.map (rot (negOne F))) := by rw [hrot (negOne F)]
        _ = ∫ χ, ((rot (negOne F) χ) r₀ : ℂ) ∂ν :=
          integral_map (measurable_rot _).aemeasurable (measurable_evalChar r₀).aestronglyMeasurable
        _ = ∫ χ, (starRingEnd ℂ) (χ r₀ : ℂ) ∂ν := integral_congr_ae (ae_of_all _ fun χ => rot_negOne_apply χ r₀)
        _ = (starRingEnd ℂ) (∫ χ, (χ r₀ : ℂ) ∂ν) := integral_conj
    exact Complex.conj_eq_iff_im.mp h1.symm
  -- (2) `τ′ = m_* ν`
  have hτ'rot : RotInv F (ν.map (mulDual r₀)) := by
    intro u
    rw [Measure.map_map (measurable_rot u) (measurable_mulDual r₀), rot_comp_mulDual,
      ← Measure.map_map (measurable_mulDual r₀) (measurable_rot u), hrot u]
  have hτ'E : ν.map (mulDual r₀) I.E = 0 := by
    rw [Measure.map_apply (measurable_mulDual r₀) I.measurableSet_E]
    exact measure_mono_null (fun χ hχ => hmul r₀ hr₀ χ hχ) hE
  have hτ'1 : ∫ χ, (χ 1 : ℂ) ∂(ν.map (mulDual r₀)) = ∫ χ, (χ r₀ : ℂ) ∂ν := by
    rw [integral_map (measurable_mulDual r₀).aemeasurable (measurable_evalChar 1).aestronglyMeasurable]
    simp only [mulDual_apply, mul_one]
  have hre : ∀ τ : Measure (Dual F), IsFiniteMeasure τ → ∫ χ, (χ 1 : ℂ).re ∂τ = (∫ χ, (χ 1 : ℂ) ∂τ).re := by
    intro τ _
    have h := integral_re (𝕜 := ℂ) (integrable_evalChar τ 1)
    simpa only [RCLike.re_to_complex] using h
  set a : ℝ := (∫ χ, (χ r₀ : ℂ) ∂ν).re with ha
  have haz : ∫ χ, (χ r₀ : ℂ) ∂ν = (a : ℂ) := Complex.ext (by simp [ha]) (by simp [hreal])
  have ha0 : a ≠ 0 := fun h => hne (by rw [haz, h, Complex.ofReal_zero])
  rcases lt_or_gt_of_ne ha0 with hneg | hpos
  · refine ⟨ν.map (mulDual r₀), inferInstance, hτ'rot, hτ'E, ?_⟩
    rw [hre _ inferInstance, hτ'1, haz, Complex.ofReal_re]
    exact hneg
  -- (3) the positive case: convolve with the negative circle
  obtain ⟨lam, hlprob, hlrot, ⟨S, -, hS0, hS⟩, hlneg⟩ := hcirc
  haveI := hlprob
  refine ⟨((ν.map (mulDual r₀)).prod lam).map (fun p => p.1 * p.2), inferInstance, ?_, ?_, ?_⟩
  · intro u
    have hcomm : rot u ∘ (fun p : Dual F × Dual F => p.1 * p.2) =
        (fun p : Dual F × Dual F => p.1 * p.2) ∘ Prod.map (rot u) (rot u) := by
      funext p
      exact rot_mul u p.1 p.2
    rw [Measure.map_map (measurable_rot u) measurable_mul_char, hcomm,
      ← Measure.map_map measurable_mul_char ((measurable_rot u).prodMap (measurable_rot u)),
      ← Measure.map_prod_map _ _ (measurable_rot u) (measurable_rot u), hτ'rot u, hlrot u]
  · rw [Measure.map_apply measurable_mul_char I.measurableSet_E,
      Measure.prod_apply_symm (measurable_mul_char I.measurableSet_E)]
    have h0 : ∀ᵐ b ∂lam, ν.map (mulDual r₀)
        ((fun χ => (χ, b)) ⁻¹' ((fun p : Dual F × Dual F => p.1 * p.2) ⁻¹' I.E)) = 0 := by
      filter_upwards [measure_eq_zero_iff_ae_notMem.mp hS0] with b hb
      exact measure_mono_null (fun χ hχ => hS b (not_not.mp hb) χ hχ) hτ'E
    rw [lintegral_congr_ae h0, lintegral_zero]
  · rw [hre _ inferInstance,
      integral_map measurable_mul_char.aemeasurable (measurable_evalChar 1).aestronglyMeasurable]
    have h1 : ∫ p : Dual F × Dual F, (((p.1 * p.2) 1 : Circle) : ℂ) ∂((ν.map (mulDual r₀)).prod lam) =
        (∫ χ, (χ 1 : ℂ) ∂(ν.map (mulDual r₀))) * ∫ χ, (χ 1 : ℂ) ∂lam := by
      rw [← integral_prod_mul]
      simp only [AddChar.mul_apply, Circle.coe_mul]
    rw [h1, hτ'1, haz, Complex.re_ofReal_mul, ← hre lam inferInstance]
    exact mul_neg_of_pos_of_neg hpos hlneg

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

/-! ### The proof of N2's first sentence: `‖V_y f − f‖² = 2 ∫ (1 − Re χ(y)) dσ_f` -/

theorem compMeasurePreserving_congr {g g' : Ω → Ω} (h : g = g') (hg : MeasurePreserving g μ μ)
    (hg' : MeasurePreserving g' μ μ) (f : Lp ℝ 2 μ) :
    Lp.compMeasurePreserving g hg f = Lp.compMeasurePreserving g' hg' f := by
  subst h
  rfl

/-- `V_g (V_h f) = V_{h ∘ g} f`. -/
theorem compMeasurePreserving_comp_apply {g h : Ω → Ω} (hg : MeasurePreserving g μ μ) (hh : MeasurePreserving h μ μ)
    (f : Lp ℝ 2 μ) :
    Lp.compMeasurePreserving g hg (Lp.compMeasurePreserving h hh f) =
      Lp.compMeasurePreserving (h ∘ g) (hh.comp hg) f := by
  apply Lp.ext
  have h1 := Lp.coeFn_compMeasurePreserving (Lp.compMeasurePreserving h hh f) hg
  have h2 := (Lp.coeFn_compMeasurePreserving f hh).comp_tendsto hg.quasiMeasurePreserving.tendsto_ae
  have h3 := Lp.coeFn_compMeasurePreserving f (hh.comp hg)
  filter_upwards [h1, h2, h3] with ω e1 e2 e3
  rw [e1, e3]
  exact e2

section
variable {T : R → Ω → Ω} {hT : ∀ y, MeasurePreserving (T y) μ μ}

/-- For an action, `V_{x+y} = V_y ∘ V_x`. -/
theorem compMeasurePreserving_add (hadd : ∀ x y, T (x + y) = T x ∘ T y) (x y : R) (f : Lp ℝ 2 μ) :
    Lp.compMeasurePreserving (T (x + y)) (hT (x + y)) f =
      Lp.compMeasurePreserving (T y) (hT y) (Lp.compMeasurePreserving (T x) (hT x) f) := by
  rw [compMeasurePreserving_comp_apply]
  exact compMeasurePreserving_congr (hadd x y) _ _ f

/-- For an action, `V_0 = id`: it is an idempotent isometry. -/
theorem compMeasurePreserving_zero (hadd : ∀ x y, T (x + y) = T x ∘ T y) (f : Lp ℝ 2 μ) :
    Lp.compMeasurePreserving (T 0) (hT 0) f = f := by
  have h : Lp.compMeasurePreserving (T 0) (hT 0) (Lp.compMeasurePreserving (T 0) (hT 0) f) =
      Lp.compMeasurePreserving (T 0) (hT 0) f := by
    rw [← compMeasurePreserving_add hadd 0 0 f]
    exact compMeasurePreserving_congr (congrArg T (add_zero 0)) _ _ f
  exact (Lp.isometry_compMeasurePreserving (hT 0)).injective h

omit [AddCommGroup R] in
/-- The correlation `∫ f · (f ∘ T_y)` is the inner product `⟨f, V_y f⟩`. -/
theorem integral_mul_comp_eq_inner (y : R) (f : Lp ℝ 2 μ) :
    ∫ ω, f ω * Lp.compMeasurePreserving (T y) (hT y) f ω ∂μ =
      inner ℝ f (Lp.compMeasurePreserving (T y) (hT y) f) := by
  rw [L2.inner_def]
  refine integral_congr_ae (ae_of_all _ fun ω => ?_)
  simp [mul_comm]

omit [AddCommGroup R] in
/-- `‖V_y f − f‖² = 2(⟨f, f⟩ − ⟨f, V_y f⟩)`. -/
theorem norm_comp_sub_sq (y : R) (f : Lp ℝ 2 μ) :
    ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖ ^ 2 =
      2 * (inner ℝ f f - inner ℝ f (Lp.compMeasurePreserving (T y) (hT y) f)) := by
  rw [norm_sub_sq_real, Lp.norm_compMeasurePreserving, real_inner_self_eq_norm_sq, real_inner_comm f]
  ring

end

/-- **J45-N2, first sentence**: "`σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous" — for a first-countable group topology
`t` on `R` satisfying Bochner's theorem and an action by measure-preserving maps of any measure space (`σ` carries `‖f‖²`: that
`μ` is a probability measure is not read). MODEL (the planner's note, `plans/FS131-w10-kernel-plan.md` § 16.2; described,
**not a Lean declaration**): the discrete topology (`bochnerOn_bot`), the trivial action `T y = id`, and `σ = ‖f‖² • δ₁`, the
point mass at the trivial character — then both sides hold. At `τ′_S` the hypothesis `BochnerOn` is Bochner's theorem on
`G′_S` with J45-N1 (b), not in the kernel. Until the model is a declaration this theorem is an open gate item under the
inhabitant rule (`LEAN.md` § The gate). -/
theorem spectral_carried_iff (t : TopologicalSpace R)
    (ht : @IsTopologicalAddGroup R t _) (hcount : (@nhds R t 0).IsCountablyGenerated) (hB : BochnerOn t)
    (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (hadd : ∀ x y, T (x + y) = T x ∘ T y)
    {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)} (hσ : IsSpectralMeasureOf T hT f σ) :
    σ (contChars t)ᶜ = 0 ↔ f ∈ contVec T hT (@nhds R t 0) := by
  letI := t
  haveI := ht
  haveI := hcount
  haveI := hσ.1
  have hc : ∀ y, ∫ χ, (χ y : ℂ) ∂σ = ((inner ℝ f (Lp.compMeasurePreserving (T y) (hT y) f) : ℝ) : ℂ) := fun y => by
    rw [hσ.2 y, integral_mul_comp_eq_inner]
  have hre : ∀ y, ∫ χ, (χ y : ℂ).re ∂σ = inner ℝ f (Lp.compMeasurePreserving (T y) (hT y) f) := fun y => by
    have h := integral_re (𝕜 := ℂ) (integrable_evalChar σ y)
    simp only [RCLike.re_to_complex] at h
    rw [h, hc y, Complex.ofReal_re]
  have hmass : σ.real Set.univ = inner ℝ f f := by
    have h := hre 0
    rw [compMeasurePreserving_zero hadd f] at h
    rw [← h]
    simp
  have hD : ∀ y, ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖ ^ 2 = 2 * ∫ χ, (1 - (χ y : ℂ).re) ∂σ := fun y => by
    have hint : Integrable (fun χ : AddChar R Circle => (χ y : ℂ).re) σ := (integrable_evalChar σ y).re
    rw [norm_comp_sub_sq, integral_sub (integrable_const 1) hint, hre y, ← hmass]
    simp
  constructor
  · intro h0
    have hae : ∀ᵐ χ ∂σ, χ ∈ contChars t := by
      filter_upwards [measure_eq_zero_iff_ae_notMem.mp h0] with χ hχ using not_not.mp hχ
    have hsq : Filter.Tendsto (fun y => ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖ ^ 2) (nhds 0) (nhds 0) := by
      simp only [hD]
      rw [Filter.tendsto_iff_seq_tendsto]
      intro u hu
      have hlim : Filter.Tendsto (fun n => ∫ χ, (1 - (χ (u n) : ℂ).re) ∂σ) Filter.atTop
          (nhds (∫ _χ : AddChar R Circle, (0 : ℝ) ∂σ)) := by
        refine tendsto_integral_of_dominated_convergence (fun _ => (2 : ℝ)) (fun n => ?_) (integrable_const 2)
          (fun n => ?_) ?_
        · exact (measurable_const.sub (Complex.measurable_re.comp (measurable_evalChar (u n)))).aestronglyMeasurable
        · refine Filter.Eventually.of_forall fun χ => ?_
          have h1 : |(χ (u n) : ℂ).re| ≤ 1 := (Complex.abs_re_le_norm _).trans (by simp)
          rw [abs_le] at h1
          rw [Real.norm_eq_abs, abs_le]
          constructor <;> linarith [h1.1, h1.2]
        · filter_upwards [hae] with χ hχ
          have hχc : Continuous fun y => χ y := hχ
          have h1 : Filter.Tendsto (fun n => χ (u n)) Filter.atTop (nhds (χ 0)) := (hχc.tendsto 0).comp hu
          have h2 : Filter.Tendsto (fun n => ((χ (u n) : Circle) : ℂ).re) Filter.atTop (nhds ((χ 0 : Circle) : ℂ).re) :=
            ((Complex.continuous_re.comp continuous_subtype_val).tendsto _).comp h1
          have h3 := (tendsto_const_nhds (x := (1 : ℝ))).sub h2
          simpa using h3
      simpa [Function.comp_def] using hlim.const_mul 2
    have h := (Real.continuous_sqrt.tendsto 0).comp hsq
    show Filter.Tendsto (fun y => ‖Lp.compMeasurePreserving (T y) (hT y) f - f‖) (nhds 0) (nhds 0)
    simpa [Function.comp_def, Real.sqrt_sq (norm_nonneg _)] using h
  · intro hf
    refine hB σ hσ.1 ?_
    have hfun : (fun y : R => ∫ χ, (χ y : ℂ) ∂σ) =
        fun y => ((inner ℝ f (Lp.compMeasurePreserving (T y) (hT y) f) : ℝ) : ℂ) := funext hc
    rw [hfun]
    refine Complex.continuous_ofReal.comp (continuous_iff_continuousAt.mpr fun x => ?_)
    show Filter.Tendsto (fun y => inner ℝ f (Lp.compMeasurePreserving (T y) (hT y) f)) (nhds x)
      (nhds (inner ℝ f (Lp.compMeasurePreserving (T x) (hT x) f)))
    rw [tendsto_iff_dist_tendsto_zero]
    have hbound : ∀ y, dist (inner ℝ f (Lp.compMeasurePreserving (T y) (hT y) f))
        (inner ℝ f (Lp.compMeasurePreserving (T x) (hT x) f)) ≤
        ‖f‖ * ‖Lp.compMeasurePreserving (T (y - x)) (hT (y - x)) f - f‖ := by
      intro y
      have e : Lp.compMeasurePreserving (T y) (hT y) f =
          Lp.compMeasurePreserving (T x) (hT x) (Lp.compMeasurePreserving (T (y - x)) (hT (y - x)) f) := by
        rw [← compMeasurePreserving_add hadd (y - x) x f]
        exact compMeasurePreserving_congr (congrArg T (sub_add_cancel y x).symm) _ _ f
      rw [Real.dist_eq, ← inner_sub_right, e, ← map_sub]
      refine (abs_real_inner_le_norm _ _).trans ?_
      rw [Lp.norm_compMeasurePreserving]
    have htend : Filter.Tendsto (fun y : R => y - x) (nhds x) (nhds 0) := by
      have h := (continuous_sub_right x).tendsto x
      rwa [sub_self] at h
    have h := (Filter.Tendsto.comp hf htend).const_mul ‖f‖
    exact squeeze_zero (fun y => dist_nonneg) hbound (by simpa [Function.comp_def] using h)

/-- Bochner's theorem holds for the discrete topology: every character is continuous. The hypothesis' model. -/
theorem bochnerOn_bot : BochnerOn (⊥ : TopologicalSpace R) := fun σ _ _ => by
  have h : contChars (⊥ : TopologicalSpace R) = Set.univ :=
    Set.eq_univ_of_forall fun χ => (continuous_bot : @Continuous R Circle ⊥ _ fun y => χ y)
  rw [h, Set.compl_univ, measure_empty]

/-- The `t`-continuous characters are stable under multiplication by one of them, both ways: they are a subgroup, whatever
the topology `t`. -/
theorem mul_mem_contChars_iff (t : TopologicalSpace R) {a : AddChar R Circle} (ha : a ∈ contChars t)
    (χ : AddChar R Circle) : χ * a ∈ contChars t ↔ χ ∈ contChars t := by
  letI := t
  have ha' : Continuous fun y => a y := ha
  constructor
  · intro h
    have h' : Continuous fun y => (χ * a) y := h
    have e : (fun y => χ y) = fun y => (χ * a) y * (a y)⁻¹ := by
      funext y
      rw [AddChar.mul_apply, mul_inv_cancel_right]
    show Continuous fun y => χ y
    rw [e]
    exact h'.mul ha'.inv
  · intro h
    have h' : Continuous fun y => χ y := h
    show Continuous fun y => (χ * a) y
    simp only [AddChar.mul_apply]
    exact h'.mul ha'

/-- **J45-N1 (c), the clause the chain consumes**: "`E_S` is a proper dense … subgroup, Haar-null" — the `t`-continuous
characters are Haar-null when they are measurable, separate the points of `R` (dense) and are not all characters (proper).
Route on the Fourier side, with no topology on the dual and no Steinhaus–Weil: for `H = contChars t` with `m(H) > 0`, the
Fourier coefficients of `1_H·m` vanish off `0` (translation by `h ∈ H` multiplies the `r`-th one by `h(r)`, and `H` separates
points), so `1_H·m = m(H)·m` by Herglotz–Bochner's uniqueness, `m(H) = 1`, and a second coset would have measure `1` too.
MODEL (the planner's note, `plans/FS131-w10-kernel-plan.md` § 16.2; described, **not a Lean declaration**): given `hBH`,
`R = ℤ` with the profinite topology — the continuous characters are those of finite order, a countable (so measurable) proper
subgroup separating the points of `ℤ`; `m` from `exists_isHaarFourier`. `hBH` is Herglotz's theorem, classical and not in the
kernel: as for `sp_if`, a statement to prove and not a structure to inhabit. No finite `R` is a model (a separating group of
characters of a finite group is the whole dual, against `hproper`). Until the model is a declaration this theorem is an open
gate item under the inhabitant rule (`LEAN.md` § The gate). -/
theorem contChars_haar_null (hBH : BochnerHerglotz R) (t : TopologicalSpace R) (hmeas : MeasurableSet (contChars t))
    (hsep : ∀ r : R, r ≠ 0 → ∃ χ ∈ contChars t, χ r ≠ 1) (hproper : contChars t ≠ Set.univ)
    {m : Measure (AddChar R Circle)} (hm : IsHaarFourier m) : m (contChars t) = 0 := by
  classical
  haveI := hm.1
  by_contra h0
  set H := contChars t with hH
  -- `ν = m|_H` is invariant under translation by `H`
  have hinv : ∀ a ∈ H, ((m.restrict H).map fun χ => χ * a) = m.restrict H := by
    intro a ha
    have hpre : (fun χ : AddChar R Circle => χ * a) ⁻¹' H = H := by
      ext χ
      exact mul_mem_contChars_iff t ha χ
    have h1 := Measure.restrict_map (μ := m) (measurable_mulRight a) hmeas
    rw [hpre, hm.map_mulRight hBH a] at h1
    exact h1.symm
  -- so its Fourier coefficients vanish off `0`
  have hcoef : ∀ r : R, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂(m.restrict H) = 0 := by
    intro r hr
    obtain ⟨a, ha, har⟩ := hsep r hr
    have h1 := integral_evalChar_map_mulRight (m.restrict H) a r
    rw [hinv a ha] at h1
    have har' : (a r : ℂ) ≠ 1 := fun h => har (Circle.coe_eq_one.mp h)
    have h2 : (∫ χ, (χ r : ℂ) ∂(m.restrict H)) * (1 - (a r : ℂ)) = 0 := by
      rw [mul_sub, mul_one, ← h1, sub_self]
    exact (mul_eq_zero.mp h2).resolve_right (sub_ne_zero.mpr (Ne.symm har'))
  -- hence `m|_H = m(H)·m`
  haveI : IsFiniteMeasure (m H • m) := Measure.smul_finite m (measure_ne_top m H)
  have heq : m.restrict H = m H • m := by
    refine ext_of_fourier hBH fun y => ?_
    rw [integral_smul_measure, hm.integral_eq]
    by_cases hy : y = 0
    · subst hy
      rw [integral_evalChar_zero, if_pos rfl, measureReal_def, Measure.restrict_apply MeasurableSet.univ,
        Set.univ_inter]
      simp
    · rw [hcoef y hy, if_neg hy, smul_zero]
  -- so `m(Hᶜ) = 0`
  have hcompl : m Hᶜ = 0 := by
    have h1 := congrArg (fun μ' : Measure (AddChar R Circle) => μ' Hᶜ) heq
    simp only [Measure.restrict_apply hmeas.compl, Set.compl_inter_self, measure_empty, Measure.smul_apply,
      smul_eq_mul] at h1
    exact (mul_eq_zero.mp h1.symm).resolve_left h0
  -- but a second coset has the measure of `H`
  obtain ⟨χ₀, hχ₀⟩ := (Set.ne_univ_iff_exists_notMem H).mp hproper
  have hsub : (fun χ : AddChar R Circle => χ * χ₀) ⁻¹' H ⊆ Hᶜ := by
    intro χ hχ hχH
    have h1 : χ * χ₀ ∈ H := hχ
    rw [mul_comm] at h1
    exact hχ₀ ((mul_mem_contChars_iff t hχH χ₀).mp h1)
  have h2 : m ((fun χ : AddChar R Circle => χ * χ₀) ⁻¹' H) = m H := by
    rw [← Measure.map_apply (measurable_mulRight χ₀) hmeas, hm.map_mulRight hBH χ₀]
  exact h0 (h2 ▸ measure_mono_null hsub hcompl)

end Spectral

/-! ## SI-4: a selection from disjoint conditional supports -/

noncomputable section Selection

variable {Ω : Type*} {V : Type*}

/-- The conditional support `M(x) = {j : P(c(x) = j | 𝒜) > 0}`, for Mathlib's version of the conditional expectation. -/
def condSupport (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin 4) (ω : Ω) (x : V) :
    Finset (Fin 4) :=
  Finset.univ.filter fun j => 0 < (μ[(Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) | 𝒜]) ω

/-! ### The proof of SI-4: SI-2 (`c(x) ∈ M(x)` a.s.), and orthogonal conditional laws have disjoint supports -/

section
variable (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin 4)

/-- The conditional law of the colour at `x`: `p_j(x) = P(c(x) = j | 𝒜)`, Mathlib's version. -/
def condLaw (x : V) (j : Fin 4) : Ω → ℝ := μ[(Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) | 𝒜]

theorem mem_condSupport {ω : Ω} {x : V} {j : Fin 4} : j ∈ condSupport 𝒜 μ c ω x ↔ 0 < condLaw 𝒜 μ c x j ω := by
  simp [condSupport, condLaw]

theorem measurable_condLaw (x : V) (j : Fin 4) : Measurable[𝒜] (condLaw 𝒜 μ c x j) :=
  (stronglyMeasurable_condExp (m := 𝒜) (μ := μ) (f := Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ))).measurable

theorem measurableSet_condLaw_pos (x : V) (j : Fin 4) : MeasurableSet[𝒜] {ω | 0 < condLaw 𝒜 μ c x j ω} :=
  measurable_condLaw 𝒜 μ c x j measurableSet_Ioi

theorem measurableSet_condSupport_eq (x : V) (s : Finset (Fin 4)) :
    MeasurableSet[𝒜] {ω | condSupport 𝒜 μ c ω x = s} := by
  have h : {ω | condSupport 𝒜 μ c ω x = s} = ⋂ j : Fin 4, {ω | 0 < condLaw 𝒜 μ c x j ω ↔ j ∈ s} := by
    ext ω
    simp only [Set.mem_setOf_eq, Set.mem_iInter, Finset.ext_iff, mem_condSupport]
  rw [h]
  refine MeasurableSet.iInter fun j => ?_
  by_cases hj : j ∈ s
  · simpa only [hj, iff_true] using measurableSet_condLaw_pos 𝒜 μ c x j
  · simp only [hj, iff_false]
    exact (measurableSet_condLaw_pos 𝒜 μ c x j).compl

theorem measurable_selection (f : Finset (Fin 4) → Fin 4) (x : V) :
    Measurable[𝒜] fun ω => f (condSupport 𝒜 μ c ω x) := by
  refine @measurable_to_countable' (Fin 4) Ω _ _ 𝒜 _ fun k => ?_
  have h : (fun ω => f (condSupport 𝒜 μ c ω x)) ⁻¹' {k} =
      ⋃ s : Finset (Fin 4), ⋃ (_ : f s = k), {ω | condSupport 𝒜 μ c ω x = s} := by
    ext ω
    simp
  rw [h]
  exact MeasurableSet.iUnion fun s => MeasurableSet.iUnion fun _ => measurableSet_condSupport_eq 𝒜 μ c x s

theorem condLaw_nonneg (x : V) (j : Fin 4) : 0 ≤ᵐ[μ] condLaw 𝒜 μ c x j :=
  condExp_nonneg (Filter.Eventually.of_forall fun ω => Set.indicator_nonneg (fun _ _ => zero_le_one) ω)

variable [IsProbabilityMeasure μ] (h𝒜 : 𝒜 ≤ m0) (hc : ∀ x, Measurable fun ω => c ω x)
include h𝒜 hc

omit h𝒜 in
theorem integrable_colourIndicator (x : V) (j : Fin 4) :
    Integrable (Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) μ :=
  (integrable_const (1 : ℝ)).indicator (hc x (measurableSet_singleton j))

/-- **SI-2**, for one vertex and one colour: `P(c(x) = j, p_j(x) ≤ 0) = 0`. -/
theorem measure_condLaw_nonpos_inter (x : V) (j : Fin 4) :
    μ ({ω | condLaw 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j}) = 0 := by
  have hA : MeasurableSet {ω | c ω x = j} := hc x (measurableSet_singleton j)
  have hs : MeasurableSet[𝒜] {ω | condLaw 𝒜 μ c x j ω ≤ 0} := measurable_condLaw 𝒜 μ c x j measurableSet_Iic
  have h1 : ∫ ω in {ω | condLaw 𝒜 μ c x j ω ≤ 0}, (Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) ω ∂μ =
      μ.real ({ω | condLaw 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j}) := by
    rw [setIntegral_indicator hA, setIntegral_const, smul_eq_mul, mul_one]
  have h2 : μ.real ({ω | condLaw 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j}) ≤ 0 := by
    rw [← h1, ← setIntegral_condExp h𝒜 (integrable_colourIndicator μ c hc x j) hs]
    exact setIntegral_nonpos (h𝒜 _ hs) fun ω hω => hω
  have h3 := le_antisymm h2 measureReal_nonneg
  rwa [measureReal_def, ENNReal.toReal_eq_zero_iff, or_iff_left (measure_ne_top μ _)] at h3

/-- **SI-2**: almost surely, the colour at every vertex is in its conditional support. -/
theorem ae_mem_condSupport [Countable V] : ∀ᵐ ω ∂μ, ∀ x, c ω x ∈ condSupport 𝒜 μ c ω x := by
  have h : ∀ᵐ ω ∂μ, ∀ x, ∀ j, ω ∉ {ω | condLaw 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j} :=
    ae_all_iff.mpr fun x => ae_all_iff.mpr fun j =>
      measure_eq_zero_iff_ae_notMem.mp (measure_condLaw_nonpos_inter 𝒜 μ c h𝒜 hc x j)
  filter_upwards [h] with ω hω x
  rw [mem_condSupport]
  by_contra hneg
  exact hω x (c ω x) ⟨not_lt.mp hneg, rfl⟩

theorem condLaw_le_one (x : V) (j : Fin 4) : ∀ᵐ ω ∂μ, condLaw 𝒜 μ c x j ω ≤ 1 := by
  have h := condExp_mono (m := 𝒜) (integrable_colourIndicator μ c hc x j) (integrable_const (1 : ℝ))
    (Filter.Eventually.of_forall fun ω => Set.indicator_le_self' (fun _ _ => zero_le_one) ω)
  rw [condExp_const h𝒜] at h
  exact h

/-- Orthogonal conditional laws: `E[p_j(x) p_j(y)] = 0` makes `p_j(x) p_j(y) = 0` almost surely. -/
theorem ae_condLaw_mul_eq_zero {x y : V} {j : Fin 4}
    (h : ∫ ω, condLaw 𝒜 μ c x j ω * condLaw 𝒜 μ c y j ω ∂μ = 0) :
    ∀ᵐ ω ∂μ, condLaw 𝒜 μ c x j ω * condLaw 𝒜 μ c y j ω = 0 := by
  have hnn : 0 ≤ᵐ[μ] fun ω => condLaw 𝒜 μ c x j ω * condLaw 𝒜 μ c y j ω := by
    filter_upwards [condLaw_nonneg 𝒜 μ c x j, condLaw_nonneg 𝒜 μ c y j] with ω h1 h2
    exact mul_nonneg h1 h2
  have hint : Integrable (fun ω => condLaw 𝒜 μ c x j ω * condLaw 𝒜 μ c y j ω) μ := by
    refine Integrable.mono' (integrable_condExp (m := 𝒜) (μ := μ)
      (f := Set.indicator {ω' | c ω' y = j} fun _ => (1 : ℝ))).norm
      ((integrable_condExp (m := 𝒜)).aestronglyMeasurable.mul (integrable_condExp (m := 𝒜)).aestronglyMeasurable) ?_
    filter_upwards [condLaw_nonneg 𝒜 μ c x j, condLaw_le_one 𝒜 μ c h𝒜 hc x j] with ω h1 h2
    rw [norm_mul]
    refine mul_le_of_le_one_left (norm_nonneg _) ?_
    rw [Real.norm_eq_abs, abs_le]
    exact ⟨by have : (0 : ℝ) ≤ condLaw 𝒜 μ c x j ω := h1; linarith, h2⟩
  exact (integral_eq_zero_iff_of_nonneg_ae hnn hint).mp h

end

/-- **J45-SI-4, at the class its argument reads**: "equality at every `u` ⟹ every selection from the supports is an
`𝒜_S`-measurable … proper four-colouring". For any countable graph `adj` on `V`, any sub-σ-algebra `𝒜` and any random
colouring `c` (properness of `c` is not read): if the conditional laws at adjacent vertices are orthogonal
(`Σ_j E[p_j(x) p_j(y)] = 0`, SI-3's form of equality), then for every choice function `f` the colouring `f ∘ M` is
`𝒜`-measurable, almost surely proper, and `c(x) ∈ M(x)` almost surely (SI-2). The equivariance clause is
`plans/FS131-w10-kernel-plan.md` § 3's child `si4_equivariant`. MODEL (the planner's note, `plans/FS131-w10-kernel-plan.md`
§ 16.2; described, **not a Lean declaration**): a deterministic proper colouring — `μ` a point mass, `c ω = c₀` with
`c₀ x ≠ c₀ y` across `adj`: each conditional law is a point mass and `hdisj` holds for every `𝒜`. A model with a non-trivial
`𝒜` is J45-SI-C's noisy colouring with `𝒜 = σ(Φ)` (`GapSeven.supp_disjoint` is its `hdisj` on the finite plane), not built.
Until one is a declaration this theorem is an open gate item under the inhabitant rule (`LEAN.md` § The gate). -/
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
  have hmem := ae_mem_condSupport 𝒜 μ c h𝒜 hc
  refine ⟨measurable_selection 𝒜 μ c f, ?_, hmem⟩
  have hprod : ∀ᵐ ω ∂μ, ∀ x y, adj x y → ∀ j, condLaw 𝒜 μ c x j ω * condLaw 𝒜 μ c y j ω = 0 := by
    refine ae_all_iff.mpr fun x => ae_all_iff.mpr fun y => ?_
    by_cases hxy : adj x y
    · have h : ∀ᵐ ω ∂μ, ∀ j, condLaw 𝒜 μ c x j ω * condLaw 𝒜 μ c y j ω = 0 :=
        ae_all_iff.mpr fun j => ae_condLaw_mul_eq_zero 𝒜 μ c h𝒜 hc (hdisj x y hxy j)
      filter_upwards [h] with ω hω _ using hω
    · exact Filter.Eventually.of_forall fun ω h => absurd h hxy
  filter_upwards [hprod, hmem] with ω h1 h2 x y hxy heq
  have hx := (mem_condSupport 𝒜 μ c).mp (hf _ ⟨c ω x, h2 x⟩)
  have hy := (mem_condSupport 𝒜 μ c).mp (hf _ ⟨c ω y, h2 y⟩)
  rw [← heq] at hy
  exact (mul_pos hx hy).ne' (h1 x y hxy _)

/-! ### SI-4's equivariance clause -/

/-- Conditional expectation commutes with a measure-preserving map that leaves the σ-algebra invariant:
`E[g | 𝒜] ∘ S = E[g ∘ S | 𝒜]` almost surely, when `S⁻¹𝒜 = 𝒜`. -/
theorem condExp_comp_measurePreserving (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] (h𝒜 : 𝒜 ≤ m0) {S : Ω → Ω} (hS : MeasurePreserving S μ μ) (hS𝒜 : 𝒜.comap S = 𝒜)
    {g : Ω → ℝ} (hg : Integrable g μ) : (μ[g | 𝒜]) ∘ S =ᵐ[μ] μ[g ∘ S | 𝒜] := by
  have hSm : Measurable[𝒜, 𝒜] S := measurable_iff_comap_le.mpr hS𝒜.le
  have hmap : ∀ {h : Ω → ℝ}, AEStronglyMeasurable h μ → ∀ {s' : Set Ω}, MeasurableSet s' →
      ∫ ω in S ⁻¹' s', h (S ω) ∂μ = ∫ ω in s', h ω ∂μ := by
    intro h hh s' hs'
    have h1 := setIntegral_map (μ := μ) (g := S) (f := h) hs' (by rwa [hS.map_eq]) hS.measurable.aemeasurable
    rw [hS.map_eq] at h1
    exact h1.symm
  have hint : Integrable ((μ[g | 𝒜]) ∘ S) μ :=
    (hS.integrable_comp integrable_condExp.aestronglyMeasurable).mpr integrable_condExp
  refine ae_eq_condExp_of_forall_setIntegral_eq h𝒜 ((hS.integrable_comp hg.aestronglyMeasurable).mpr hg)
    (fun s _ _ => hint.integrableOn) (fun s hs _ => ?_)
    ((stronglyMeasurable_condExp (m := 𝒜)).comp_measurable hSm).aestronglyMeasurable
  rw [← hS𝒜] at hs
  obtain ⟨s', hs', rfl⟩ := MeasurableSpace.measurableSet_comap.mp hs
  show ∫ ω in S ⁻¹' s', (μ[g | 𝒜]) (S ω) ∂μ = ∫ ω in S ⁻¹' s', g (S ω) ∂μ
  rw [hmap integrable_condExp.aestronglyMeasurable (h𝒜 _ hs'), hmap hg.aestronglyMeasurable (h𝒜 _ hs'),
    setIntegral_condExp h𝒜 hg hs']

/-- **J45-SI-4, the equivariance clause** ("`M(x + y) = M(x) ∘ T_y`"): if a measure-preserving map `S` of `Ω` leaves `𝒜`
invariant (`S⁻¹𝒜 = 𝒜`) and moves the colouring by a map `π` of the vertices (`c (S ω) x = c ω (π x)`; for the shift by `y`,
`π x = x + y`), then almost surely the conditional supports move the same way, `M(S ω)(x) = M(ω)(π x)` for every `x` — so every
selection `f ∘ M` is equivariant. With Mathlib's fixed version of the conditional expectation the identity is almost sure;
the derivation chooses versions that make it sure. MODEL: any additive action with `T 0 = id`, `𝒜` its factor σ-algebra —
`comap_factorSigma_eq_of_action` supplies `hS𝒜`, and `si4_equivariant_factorSigma` is this theorem there
(`Arith/FactorAction`). -/
theorem si4_equivariant [Countable V] (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] (h𝒜 : 𝒜 ≤ m0) (c : Ω → V → Fin 4) (hc : ∀ x, Measurable fun ω => c ω x)
    {S : Ω → Ω} (hS : MeasurePreserving S μ μ) (hS𝒜 : 𝒜.comap S = 𝒜) (π : V → V)
    (hπ : ∀ ω x, c (S ω) x = c ω (π x)) :
    ∀ᵐ ω ∂μ, ∀ x, condSupport 𝒜 μ c (S ω) x = condSupport 𝒜 μ c ω (π x) := by
  have h : ∀ᵐ ω ∂μ, ∀ x, ∀ j, condLaw 𝒜 μ c x j (S ω) = condLaw 𝒜 μ c (π x) j ω := by
    refine ae_all_iff.mpr fun x => ae_all_iff.mpr fun j => ?_
    have h1 := condExp_comp_measurePreserving 𝒜 μ h𝒜 hS hS𝒜 (integrable_colourIndicator μ c hc x j)
    have h2 : (Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) ∘ S =
        Set.indicator {ω' | c ω' (π x) = j} fun _ => (1 : ℝ) := by
      funext ω
      simp only [Function.comp_apply, Set.indicator_apply, Set.mem_setOf_eq, hπ]
    rw [h2] at h1
    exact h1
  filter_upwards [h] with ω hω x
  ext j
  rw [mem_condSupport, mem_condSupport, hω x j]

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

-- `condLaw` is the function `condSupport` thresholds: `j ∈ M(x) ↔ 0 < p_j(x)`.
example {Ω V : Type*} (𝒜 : MeasurableSpace Ω) [MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin 4) (ω : Ω) (x : V)
    (j : Fin 4) : j ∈ condSupport 𝒜 μ c ω x ↔ 0 < condLaw 𝒜 μ c x j ω := mem_condSupport 𝒜 μ c

-- `mulDual r₀` is `χ ↦ χ(r₀ ·)`, and `negOne` is the unit vector `−1`.
example {F : Subfield ℝ} (r₀ : unitRing F) (χ : Dual F) (y : unitRing F) : mulDual r₀ χ y = χ (r₀ * y) := rfl
example (F : Subfield ℝ) : ((negOne F : unitVectors F) : ℂ) = -1 := rfl

-- `si4_equivariant`'s hypotheses have a model: the identity map, with the identity on the vertices.
example {Ω V : Type*} [Countable V] (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω)
    [IsProbabilityMeasure μ] (h𝒜 : 𝒜 ≤ m0) (c : Ω → V → Fin 4) (hc : ∀ x, Measurable fun ω => c ω x) :
    ∀ᵐ ω ∂μ, ∀ x, condSupport 𝒜 μ c (id ω) x = condSupport 𝒜 μ c ω (id x) :=
  si4_equivariant 𝒜 μ h𝒜 c hc (MeasurePreserving.id μ) MeasurableSpace.comap_id id fun _ _ => rfl

end HadwigerNelson.SpectralInputs
