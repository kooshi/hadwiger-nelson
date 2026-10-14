import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Mathlib.Analysis.SpecialFunctions.Complex.Log

/-!
# The count's archimedean factor: one plane, at every number field (FS-131, job FS131-K12A; module M12, block A)

**Read aloud, against the derivation** (J28D § 3.2 C3: "`T_S := ∏_v T(F_v)` … is the closure of `U` in `G_S` (weak
approximation, CLG-c (W))"; FS100-TCA's "C14.3's induction" at `n` real places; FS100-CX at a complex place). The count
needs of the archimedean places only this: **inside `L ⊗ ℝ` (Mathlib's mixed space of `L = F(i)`) sits the plane
`Δ = ℚ(i) ⊗ ℝ`**, the real span of the images of `1` and `i` (`Delta F`, an `ℝ`-linear map from `ℂ`), and its unit circle
is approximated by the unit vectors of `F²` — even by their `h`-th powers:

* `Delta_ratCast` — on `ℚ(i)` the plane is the canonical embedding: `Δ(q₁ + q₂ i) = e(q₁ + q₂ i)`.
* `Delta_circle_mem_closure` — every point `Δ(e^{iθ})` of the unit circle of `Δ` is a limit of images of unit vectors: the
  rational points of the circle, `(1 − t² + 2ti)/(1 + t²)` with `t ∈ ℚ`, are dense in it.
* `mem_closure_pow` — **the weak approximation the count reads**: for every unit vector `u` of `F²` and every `h ≥ 1`,
  `e(u)` is a limit of `e(w)^h` with `w` a unit vector. Route: `u = φ(t₀) = (1 + it₀)/(1 − it₀)` with `t₀ ∈ F`
  (`u ≠ −1`; `−1 = i²`); `φ(t)^h = φ(R_h(t))` for the rational function `R_h = Im (1 + it)^h / Re (1 + it)^h`; at every
  place `v` of `F` (Mathlib's mixed space of `F`) pick `y_v` with `R_h(y_v) = σ_v(t₀)` — `y_v = (ξ − 1)/(i(ξ + 1))` for the
  principal `h`-th root `ξ = exp(log φ(σ_v t₀) / h) ≠ −1`, real at a real place — then `t ∈ F` close to `(y_v)`
  (`F` is dense in its mixed space: a full lattice and its rational multiples).

With these the slices `Δ × K` of the completion carry `UD(ℝ²) ⊗ Cay(K, U)` (module `Rigidity/CountCompletion`,
`mem_closure_ιG`): one plane for every number field, totally real or not; C14.3's induction over the real places and
FS100-CX's restriction at the complex places are not on this route (both are the case `Δ` of dropping edges, which is the
safe direction for a ratio).

**Models.** `F = ℚ` (`⊥`): `L = ℚ(i)`, `Δ` is the whole mixed space's real form; `u = (3 + 4i)/5`.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField Filter Topology

noncomputable section

variable (F : Subfield ℝ)

/-- `i`, as an element of `L = F(i)`. -/
def iL : fieldI F := ⟨Complex.I, by simp⟩

/-- **The norm-one elements of `L`**: `x · x̄ = 1` — the unit vectors of `F²`, read in `L`. -/
def normOneL : Set (fieldI F) := {x | x * conjOn (fieldI_conj F) x = 1}

theorem mem_normOneL_iff {x : fieldI F} : x ∈ normOneL F ↔ (x : ℂ) ∈ unitVectors F :=
  ⟨fun h => ⟨x.2, (UnitRing.mem_normOne_conjOn_iff x).1 (mem_normOne.2 h)⟩,
    fun h => mem_normOne.1 ((UnitRing.mem_normOne_conjOn_iff x).2 h.2)⟩

variable [NumberField F]

/-- **The plane `Δ = ℚ(i) ⊗ ℝ` inside `L ⊗ ℝ`**: `z ↦ Re z · e(1) + Im z · e(i)`. -/
def Delta : ℂ →ₗ[ℝ] NumberField.mixedEmbedding.mixedSpace (fieldI F) :=
  Complex.reLm.smulRight (NumberField.mixedEmbedding (fieldI F) 1) +
    Complex.imLm.smulRight (NumberField.mixedEmbedding (fieldI F) (iL F))

omit [NumberField F] in
/-- On `ℚ(i)`, `Δ` is the canonical embedding. -/
theorem Delta_ratCast (q₁ q₂ : ℚ) :
    Delta F ((q₁ : ℂ) + (q₂ : ℂ) * Complex.I) =
      NumberField.mixedEmbedding (fieldI F) ((q₁ : fieldI F) + (q₂ : fieldI F) * iL F) := by
  have hre : ((q₁ : ℂ) + (q₂ : ℂ) * Complex.I).re = q₁ := by simp
  have him : ((q₁ : ℂ) + (q₂ : ℂ) * Complex.I).im = q₂ := by simp
  have hq : ∀ q : ℚ, NumberField.mixedEmbedding (fieldI F) (q : fieldI F) =
      (q : ℝ) • NumberField.mixedEmbedding (fieldI F) 1 := fun q => by
    rw [← Rat.smul_one_eq_cast (fieldI F) q, map_rat_smul, Rat.cast_smul_eq_qsmul]
  show (Complex.reLm.smulRight (NumberField.mixedEmbedding (fieldI F) 1) +
      Complex.imLm.smulRight (NumberField.mixedEmbedding (fieldI F) (iL F))) _ = _
  rw [LinearMap.add_apply, LinearMap.smulRight_apply, LinearMap.smulRight_apply, Complex.reLm_coe, Complex.imLm_coe,
    hre, him, map_add, map_mul, hq, hq, smul_mul_assoc, map_one, one_mul]

-- FS131-ICL2: the Cayley parametrisation `t ↦ (1 + it)/(1 − it)` of the circle, and the closure of the unit vectors'
-- `h`-th powers as a submonoid.

omit [NumberField F] in
private theorem iL_mul_iL : iL F * iL F = -1 := Subtype.ext (by simp [iL])

omit [NumberField F] in
private theorem iL_mem_normOneL : iL F ∈ normOneL F := by
  show iL F * conjOn (fieldI_conj F) (iL F) = 1
  exact Subtype.ext (by simp [iL])

omit [NumberField F] in
private theorem neg_one_mem_normOneL : (-1 : fieldI F) ∈ normOneL F := by
  show (-1 : fieldI F) * conjOn (fieldI_conj F) (-1) = 1
  rw [map_neg, map_one, neg_mul_neg, mul_one]

/-- The images of the `h`-th powers of the unit vectors, as a submonoid of the mixed space. -/
private def powSubmonoid (h : ℕ) : Submonoid (NumberField.mixedEmbedding.mixedSpace (fieldI F)) where
  carrier := NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)
  mul_mem' := by
    rintro _ _ ⟨_, ⟨a, ha, rfl⟩, rfl⟩ ⟨_, ⟨b, hb, rfl⟩, rfl⟩
    refine ⟨(a * b) ^ h, ⟨a * b, ?_, rfl⟩, by rw [mul_pow, map_mul]⟩
    show a * b * conjOn (fieldI_conj F) (a * b) = 1
    rw [map_mul, mul_mul_mul_comm]
    rw [show a * conjOn (fieldI_conj F) a = 1 from ha, show b * conjOn (fieldI_conj F) b = 1 from hb, one_mul]
  one_mem' := ⟨1, ⟨1, by show (1 : fieldI F) * conjOn (fieldI_conj F) 1 = 1; rw [map_one, one_mul], one_pow h⟩, map_one _⟩

omit [NumberField F] in
private theorem closure_powSubmonoid (h : ℕ) :
    ((powSubmonoid F h).topologicalClosure : Set (NumberField.mixedEmbedding.mixedSpace (fieldI F))) =
      closure (NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)) :=
  Submonoid.coe_topologicalClosure _

omit [NumberField F] in
private theorem norm_cay (t : ℝ) : ‖((1 : ℂ) + t * Complex.I) / (1 - t * Complex.I)‖ = 1 := by
  have h1 : ‖(1 : ℂ) + t * Complex.I‖ = √(1 ^ 2 + t ^ 2) := by
    simpa using Complex.norm_add_mul_I 1 t
  have h2 : ‖(1 : ℂ) - t * Complex.I‖ = √(1 ^ 2 + t ^ 2) := by
    have := Complex.norm_add_mul_I 1 (-t)
    rw [show ((1 : ℝ) : ℂ) + ((-t : ℝ) : ℂ) * Complex.I = 1 - t * Complex.I by push_cast; ring] at this
    rw [this, neg_sq]
  have hpos : 0 < √(1 ^ 2 + t ^ 2) := Real.sqrt_pos.2 (by positivity)
  rw [norm_div, h1, h2, div_self hpos.ne']

omit [NumberField F] in
/-- **The unit circle of `Δ` lies in the closure of the unit vectors.** -/
theorem Delta_circle_mem_closure (θ : ℝ) :
    Delta F (Complex.exp (θ * Complex.I)) ∈ closure (NumberField.mixedEmbedding (fieldI F) '' normOneL F) := by
  -- Route: `e^{iθ} = (1 + it)/(1 − it)` at `t = tan (θ/2)` (or `e^{iθ} = −1`); the rational `t` give unit vectors with
  -- rational coordinates, where `Δ` is the canonical embedding (`Delta_ratCast`); `ℚ` is dense in `ℝ`.
  set X := closure (NumberField.mixedEmbedding (fieldI F) '' normOneL F) with hX
  have hΔc : Continuous (Delta F) := (Delta F).continuous_of_finiteDimensional
  set cay : ℝ → ℂ := fun t => (1 + t * Complex.I) / (1 - t * Complex.I) with hcay
  have hden : ∀ t : ℝ, (1 : ℂ) - t * Complex.I ≠ 0 := fun t h => by
    have := congrArg Complex.re h
    simp at this
  have hcayc : Continuous cay :=
    (continuous_const.add (Complex.continuous_ofReal.mul continuous_const)).div
      (continuous_const.sub (Complex.continuous_ofReal.mul continuous_const)) hden
  have hrat : ∀ q : ℚ, Delta F (cay q) ∈ X := by
    intro q
    apply subset_closure
    have hq : (1 : ℚ) + q ^ 2 ≠ 0 := by positivity
    have hqC : (1 : ℂ) + (q : ℂ) ^ 2 ≠ 0 := by exact_mod_cast hq
    have hc : cay q = (((1 - q ^ 2) / (1 + q ^ 2) : ℚ) : ℂ) + ((2 * q / (1 + q ^ 2) : ℚ) : ℂ) * Complex.I := by
      simp only [hcay]
      rw [div_eq_iff (hden q)]
      push_cast
      field_simp
      linear_combination (2 * (q : ℂ) ^ 2) * Complex.I_sq
    set x : fieldI F := (((1 - q ^ 2) / (1 + q ^ 2) : ℚ) : fieldI F) + ((2 * q / (1 + q ^ 2) : ℚ) : fieldI F) * iL F
      with hxdef
    have hq' : ∀ r : ℚ, ((r : fieldI F) : ℂ) = (r : ℂ) := fun r => map_ratCast (fieldI F).subtype r
    have hcoe : (x : ℂ) = cay q := by
      rw [hc, hxdef, Subfield.coe_add, Subfield.coe_mul, hq', hq']
      rfl
    refine ⟨x, (mem_normOneL_iff F).2 ⟨x.2, ?_⟩, ?_⟩
    · rw [hcoe]
      exact norm_cay q
    · rw [hc, Delta_ratCast]
  have hreal : ∀ t : ℝ, Delta F (cay t) ∈ X := by
    intro t
    have h1 : Delta F (cay t) ∈ closure ((fun t => Delta F (cay t)) '' Set.range ((↑) : ℚ → ℝ)) :=
      mem_closure_image (hΔc.comp hcayc).continuousAt (Rat.denseRange_cast t)
    refine closure_minimal ?_ isClosed_closure h1
    rintro _ ⟨_, ⟨q, rfl⟩, rfl⟩
    exact hrat q
  have hexp : Complex.exp (θ * Complex.I) =
      ((Real.cos (θ / 2) : ℂ) + (Real.sin (θ / 2) : ℂ) * Complex.I) ^ 2 := by
    rw [Complex.ofReal_cos, Complex.ofReal_sin, ← Complex.exp_mul_I, ← Complex.exp_nat_mul]
    congr 1
    push_cast
    ring
  rcases eq_or_ne (Real.cos (θ / 2)) 0 with hc0 | hc0
  · have hs : Real.sin (θ / 2) ^ 2 = 1 := by nlinarith [Real.sin_sq_add_cos_sq (θ / 2)]
    have hm1 : Complex.exp (θ * Complex.I) = -1 := by
      rw [hexp, hc0, Complex.ofReal_zero, zero_add]
      have hs' : (Real.sin (θ / 2) : ℂ) ^ 2 = 1 := by exact_mod_cast hs
      linear_combination Complex.I ^ 2 * hs' + Complex.I_sq
    have hΔ : Delta F (-1) = NumberField.mixedEmbedding (fieldI F) (-1) := by
      simp [Delta]
    rw [hm1, hΔ]
    exact subset_closure ⟨-1, neg_one_mem_normOneL F, rfl⟩
  · set c := Real.cos (θ / 2) with hcdef
    set sn := Real.sin (θ / 2) with hsdef
    have hcs : (c : ℂ) ^ 2 + (sn : ℂ) ^ 2 = 1 := by exact_mod_cast Real.cos_sq_add_sin_sq (θ / 2)
    have hcC : (c : ℂ) ≠ 0 := by exact_mod_cast hc0
    have hden' : (c : ℂ) - sn * Complex.I ≠ 0 := by
      intro h0
      have := congrArg Complex.re h0
      simp at this
      exact hc0 this
    have hcay' : cay (sn / c) = ((c : ℂ) + sn * Complex.I) / ((c : ℂ) - sn * Complex.I) := by
      simp only [hcay]
      push_cast
      rw [← mul_div_mul_left _ _ hcC]
      congr 1 <;> field_simp
    have htan : Complex.exp (θ * Complex.I) = cay (sn / c) := by
      rw [hexp, hcay', eq_div_iff hden']
      linear_combination ((c : ℂ) + sn * Complex.I) * hcs - ((c : ℂ) + sn * Complex.I) * sn ^ 2 * Complex.I_sq
    rw [htan]
    exact hreal _

-- FS131-ICL2: weak approximation by `h`-th powers. A unit vector `x ≠ −1` is `(1 + i t₀)/(1 − i t₀)` with `t₀ ∈ F`; at each
-- place `w` of `L` (all complex, as `i ∈ L`) the target is `cayI (w i) (w t₀)`, and a principal `h`-th Cayley root of it is
-- read off one point `y` of `F`'s mixed space, where the continuous map `Ψ` (the Cayley map at each place of `L`, then the
-- `h`-th power) takes the value `e x`; `F` is dense in its mixed space and `Ψ` sends it into the `h`-th powers.

omit [NumberField F] in
/-- `F → L = F(i)`. -/
private def ιF : F →+* fieldI F :=
  RingHom.codRestrict (Complex.ofRealHom.comp F.subtype) (fieldI F) fun a => by
    rw [mem_fieldI]
    simp

/-- The Cayley map with the sign `I`. -/
private def cayI (I z : ℂ) : ℂ := (1 + I * z) / (1 - I * z)

/-- The principal `h`-th Cayley root of `z`. -/
private def cayRoot (h : ℕ) (z : ℂ) : ℂ :=
  (Complex.exp (Complex.log (cayI Complex.I z) / h) - 1) /
    (Complex.I * (Complex.exp (Complex.log (cayI Complex.I z) / h) + 1))

private theorem exp_div_ne_neg_one {h : ℕ} (hh : 2 ≤ h) (c : ℂ) : Complex.exp (Complex.log c / h) ≠ -1 := by
  intro he
  have hre := congrArg Complex.re he
  rw [Complex.exp_re, Complex.div_natCast_re, Complex.div_natCast_im] at hre
  have hh' : (2 : ℝ) ≤ h := by exact_mod_cast hh
  have hpos : (0 : ℝ) < h := by linarith
  have h1 := Complex.neg_pi_lt_log_im c
  have h2 := Complex.log_im_le_pi c
  have hlo : -(Real.pi / 2) ≤ (Complex.log c).im / h := by
    rw [le_div_iff₀ hpos]
    nlinarith [Real.pi_pos]
  have hhi : (Complex.log c).im / h ≤ Real.pi / 2 := by
    rw [div_le_iff₀ hpos]
    nlinarith [Real.pi_pos]
  have hcos := Real.cos_nonneg_of_mem_Icc ⟨hlo, hhi⟩
  have hexp := Real.exp_pos ((Complex.log c).re / h)
  simp only [Complex.neg_re, Complex.one_re] at hre
  nlinarith

private theorem cayRoot_spec {h : ℕ} (hh : 2 ≤ h) {z : ℂ} (h1 : 1 + Complex.I * z ≠ 0) (h2 : 1 - Complex.I * z ≠ 0) :
    1 - Complex.I * cayRoot h z ≠ 0 ∧ 1 + Complex.I * cayRoot h z ≠ 0 ∧
      cayI Complex.I (cayRoot h z) ^ h = cayI Complex.I z ∧
        cayI (-Complex.I) (cayRoot h z) ^ h = cayI (-Complex.I) z := by
  set c := cayI Complex.I z with hcdef
  have hc0 : c ≠ 0 := div_ne_zero h1 h2
  set ξ := Complex.exp (Complex.log c / h) with hξdef
  have hξ1 : ξ + 1 ≠ 0 := fun h0 => exp_div_ne_neg_one hh c (eq_neg_of_add_eq_zero_left h0)
  have hξ0 : ξ ≠ 0 := Complex.exp_ne_zero _
  have hh0 : (h : ℂ) ≠ 0 := by exact_mod_cast (show h ≠ 0 by omega)
  have hξh : ξ ^ h = c := by
    rw [hξdef, ← Complex.exp_nat_mul, mul_div_cancel₀ _ hh0, Complex.exp_log hc0]
  have hI : Complex.I * cayRoot h z = (ξ - 1) / (ξ + 1) := by
    show Complex.I * ((ξ - 1) / (Complex.I * (ξ + 1))) = _
    field_simp
  have hA : 1 - Complex.I * cayRoot h z = 2 / (ξ + 1) := by
    rw [hI]
    field_simp
    ring
  have hB : 1 + Complex.I * cayRoot h z = 2 * ξ / (ξ + 1) := by
    rw [hI]
    field_simp
    ring
  have hA0 : 1 - Complex.I * cayRoot h z ≠ 0 := by rw [hA]; exact div_ne_zero two_ne_zero hξ1
  have hB0 : 1 + Complex.I * cayRoot h z ≠ 0 := by
    rw [hB]; exact div_ne_zero (mul_ne_zero two_ne_zero hξ0) hξ1
  have hcay : cayI Complex.I (cayRoot h z) = ξ := by
    rw [cayI, hA, hB]
    field_simp
  have hcay' : cayI (-Complex.I) (cayRoot h z) = ξ⁻¹ := by
    rw [cayI, neg_mul, sub_neg_eq_add, ← sub_eq_add_neg, hA, hB]
    field_simp
  have hcz : cayI (-Complex.I) z = c⁻¹ := by
    rw [hcdef, cayI, cayI, neg_mul, sub_neg_eq_add, ← sub_eq_add_neg, inv_div]
  refine ⟨hA0, hB0, by rw [hcay, hξh], by rw [hcay', inv_pow, hξh, hcz]⟩

omit [NumberField F] in
private theorem conj_cayI (I z : ℂ) : starRingEnd ℂ (cayI I z) = cayI (starRingEnd ℂ I) (starRingEnd ℂ z) := by
  simp [cayI, map_div₀]

/-- The four cases: the sign `I = ±i`, and the root or the conjugate of the root at `z̄`. -/
private theorem cay_pow_eq {h : ℕ} (hh : 2 ≤ h) {z I Λ : ℂ} (h1 : 1 + Complex.I * z ≠ 0)
    (h2 : 1 - Complex.I * z ≠ 0) (hI : I = Complex.I ∨ I = -Complex.I)
    (hΛ : Λ = cayRoot h z ∨ Λ = starRingEnd ℂ (cayRoot h (starRingEnd ℂ z))) :
    1 - I * Λ ≠ 0 ∧ cayI I Λ ^ h = cayI I z := by
  have h1' : 1 + Complex.I * starRingEnd ℂ z ≠ 0 := by
    intro h0
    apply h2
    have := congrArg (starRingEnd ℂ) h0
    simpa [map_add, map_mul, sub_eq_add_neg] using this
  have h2' : 1 - Complex.I * starRingEnd ℂ z ≠ 0 := by
    intro h0
    apply h1
    have := congrArg (starRingEnd ℂ) h0
    simpa [map_sub, map_mul, sub_eq_add_neg] using this
  obtain ⟨hA, hB, hp, hm⟩ := cayRoot_spec hh h1 h2
  obtain ⟨hA', hB', hp', hm'⟩ := cayRoot_spec hh h1' h2'
  rcases hI with rfl | rfl <;> rcases hΛ with rfl | rfl
  · exact ⟨hA, hp⟩
  · refine ⟨?_, ?_⟩
    · intro h0
      apply hB'
      have := congrArg (starRingEnd ℂ) h0
      simpa [map_sub, map_mul, sub_eq_add_neg] using this
    · have e : cayI Complex.I (starRingEnd ℂ (cayRoot h (starRingEnd ℂ z))) =
          starRingEnd ℂ (cayI (-Complex.I) (cayRoot h (starRingEnd ℂ z))) := by
        rw [conj_cayI, map_neg, Complex.conj_I, neg_neg]
      rw [e, ← map_pow, hm', conj_cayI, map_neg, Complex.conj_I, neg_neg, Complex.conj_conj]
  · refine ⟨?_, hm⟩
    rw [neg_mul, sub_neg_eq_add]
    exact hB
  · refine ⟨?_, ?_⟩
    · intro h0
      apply hA'
      have := congrArg (starRingEnd ℂ) h0
      simpa [map_sub, map_mul, sub_eq_add_neg] using this
    · have e : cayI (-Complex.I) (starRingEnd ℂ (cayRoot h (starRingEnd ℂ z))) =
          starRingEnd ℂ (cayI Complex.I (cayRoot h (starRingEnd ℂ z))) := by
        rw [conj_cayI, Complex.conj_I]
      rw [e, ← map_pow, hp', conj_cayI, Complex.conj_I, Complex.conj_conj]

/-- At a real point the root is real. -/
private theorem cayRoot_im {h : ℕ} (hh : 2 ≤ h) (r : ℝ) : (cayRoot h r).im = 0 := by
  set c := cayI Complex.I r with hcdef
  have hnorm : ‖c‖ = 1 := by
    rw [hcdef, cayI, mul_comm Complex.I]
    exact norm_cay r
  set ξ := Complex.exp (Complex.log c / h) with hξdef
  have hξn : ‖ξ‖ = 1 := by
    rw [hξdef, Complex.norm_exp, Complex.div_natCast_re, Complex.log_re, hnorm, Real.log_one, zero_div,
      Real.exp_zero]
  have hξ0 : ξ ≠ 0 := Complex.exp_ne_zero _
  have hξ1 : ξ + 1 ≠ 0 := fun h0 => exp_div_ne_neg_one hh c (eq_neg_of_add_eq_zero_left h0)
  have hconj : starRingEnd ℂ ξ = ξ⁻¹ := by
    rw [Complex.inv_def, Complex.normSq_eq_norm_sq, hξn, one_pow, inv_one, Complex.ofReal_one, mul_one]
  have hξ1' : ξ⁻¹ + 1 ≠ 0 := by
    intro h0
    apply hξ1
    have : ξ * (ξ⁻¹ + 1) = 0 := by rw [h0, mul_zero]
    rw [mul_add, mul_inv_cancel₀ hξ0, mul_one] at this
    linear_combination this
  rw [← Complex.conj_eq_iff_im]
  show starRingEnd ℂ ((ξ - 1) / (Complex.I * (ξ + 1))) = (ξ - 1) / (Complex.I * (ξ + 1))
  have hξ1'' : 1 + ξ ≠ 0 := by rwa [add_comm]
  rw [map_div₀, map_sub, map_mul, map_add, map_one, hconj, Complex.conj_I]
  field_simp
  ring

omit [NumberField F] in
/-- Every infinite place of `L = F(i)` is complex: `i` has no real image. -/
private theorem isComplex_place (w : NumberField.InfinitePlace (fieldI F)) : w.IsComplex := by
  rw [NumberField.InfinitePlace.isComplex_iff]
  intro hw
  have hc := NumberField.ComplexEmbedding.isReal_iff.1 hw
  have hi : w.embedding (iL F) ^ 2 = -1 := by rw [← map_pow, sq, iL_mul_iL, map_neg, map_one]
  have hre : starRingEnd ℂ (w.embedding (iL F)) = w.embedding (iL F) := by
    rw [← NumberField.ComplexEmbedding.conjugate_coe_eq, hc]
  have him := Complex.conj_eq_iff_im.1 hre
  have := congrArg Complex.re hi
  rw [sq, Complex.mul_re, him, mul_zero, sub_zero] at this
  simp at this
  nlinarith [sq_nonneg (w.embedding (iL F)).re]

omit [NumberField F] in
private theorem embedding_iL (w : NumberField.InfinitePlace (fieldI F)) :
    w.embedding (iL F) = Complex.I ∨ w.embedding (iL F) = -Complex.I := by
  have hi : w.embedding (iL F) ^ 2 = -1 := by rw [← map_pow, sq, iL_mul_iL, map_neg, map_one]
  have h : (w.embedding (iL F) - Complex.I) * (w.embedding (iL F) + Complex.I) = 0 := by
    linear_combination hi - Complex.I_sq
  rcases mul_eq_zero.1 h with h | h
  · exact Or.inl (sub_eq_zero.1 h)
  · exact Or.inr (eq_neg_of_add_eq_zero_left h)

/-- `F` is dense in its mixed space: the rational multiples of a lattice basis. -/
private theorem dense_range_mixedEmbedding :
    Dense (Set.range (NumberField.mixedEmbedding F)) := by
  let H : AddSubgroup (NumberField.mixedEmbedding.mixedSpace F) := (NumberField.mixedEmbedding F).range.toAddSubgroup
  change Dense (SetLike.coe H)
  let lB := NumberField.mixedEmbedding.latticeBasis F
  rw [dense_iff_closure_eq, ← AddSubgroup.topologicalClosure_coe]
  refine Set.eq_univ_of_forall fun x => ?_
  rw [SetLike.mem_coe, ← lB.sum_repr x]
  refine AddSubgroup.sum_mem _ fun i _ => ?_
  have hmem : ∀ q : ℚ, (q : ℝ) • lB i ∈ (H : Set _) := fun q => by
    refine ⟨q • NumberField.integralBasis F i, ?_⟩
    rw [map_rat_smul, NumberField.mixedEmbedding.latticeBasis_apply, Rat.cast_smul_eq_qsmul]
  have hc : Continuous fun t : ℝ => t • lB i := continuous_id.smul continuous_const
  have h1 := mem_closure_image hc.continuousAt (Rat.denseRange_cast (lB.repr x i))
  rw [← SetLike.mem_coe, AddSubgroup.topologicalClosure_coe]
  refine closure_minimal ?_ isClosed_closure h1
  rintro _ ⟨_, ⟨q, rfl⟩, rfl⟩
  exact subset_closure (hmem q)

/-- The point of `F`'s mixed space read off a function of the embeddings of `t₀`. -/
private def Ypt (t₀ : F) (g : ℂ → ℂ) : NumberField.mixedEmbedding.mixedSpace F :=
  (fun v => (g (v.1.embedding t₀)).re, fun v => g (v.1.embedding t₀))

omit [NumberField F] in
/-- **One place of `L` read on `F`'s mixed space**: a continuous `λ` through which every `w(t)`, `t ∈ F`, factors, and whose
value at `Ypt t₀ g` is `g (w t₀)` or the conjugate of `g` at `w t₀`'s conjugate. -/
private theorem exists_coord (w : NumberField.InfinitePlace (fieldI F)) (t₀ : F) (g : ℂ → ℂ)
    (hg : ∀ r : ℝ, (g r).im = 0) :
    ∃ lam : NumberField.mixedEmbedding.mixedSpace F → ℂ, Continuous lam ∧
      (∀ t : F, lam (NumberField.mixedEmbedding F t) = w.embedding (ιF F t)) ∧
      (lam (Ypt F t₀ g) = g (w.embedding (ιF F t₀)) ∨
        lam (Ypt F t₀ g) = starRingEnd ℂ (g (starRingEnd ℂ (w.embedding (ιF F t₀))))) := by
  set φ : F →+* ℂ := w.embedding.comp (ιF F) with hφ
  have he := NumberField.InfinitePlace.embedding_mk_eq φ
  set v := NumberField.InfinitePlace.mk φ with hv
  by_cases hvr : v.IsReal
  · have hφr : NumberField.ComplexEmbedding.IsReal φ := by
      have hr := NumberField.InfinitePlace.isReal_iff.1 hvr
      rcases he with e | e
      · rwa [e] at hr
      · rw [e] at hr
        rw [NumberField.ComplexEmbedding.isReal_iff] at hr ⊢
        have h2 : NumberField.ComplexEmbedding.conjugate (NumberField.ComplexEmbedding.conjugate φ) = φ := star_star φ
        rw [h2] at hr
        exact hr.symm
    have hvφ : v.embedding = φ := NumberField.InfinitePlace.embedding_mk_eq_of_isReal hφr
    refine ⟨fun a => ((a.1 ⟨v, hvr⟩ : ℝ) : ℂ), Complex.continuous_ofReal.comp ((continuous_apply _).comp continuous_fst),
      fun t => ?_, Or.inl ?_⟩
    · dsimp only
      rw [NumberField.mixedEmbedding.mixedEmbedding_apply_isReal, NumberField.InfinitePlace.embedding_of_isReal_apply,
        hvφ]
      rfl
    · show (((g (v.embedding t₀)).re : ℝ) : ℂ) = _
      have hr : v.embedding t₀ = ((NumberField.InfinitePlace.embedding_of_isReal hvr t₀ : ℝ) : ℂ) :=
        (NumberField.InfinitePlace.embedding_of_isReal_apply hvr t₀).symm
      have hφt : v.embedding t₀ = w.embedding (ιF F t₀) := by rw [hvφ]; rfl
      rw [← hφt]
      apply Complex.ext
      · simp
      · rw [Complex.ofReal_im, hr, hg]
  · have hvc : v.IsComplex := NumberField.InfinitePlace.not_isReal_iff_isComplex.1 hvr
    rcases he with e | e
    · refine ⟨fun a => a.2 ⟨v, hvc⟩, (continuous_apply _).comp continuous_snd, fun t => ?_, Or.inl ?_⟩
      · dsimp only
        rw [NumberField.mixedEmbedding.mixedEmbedding_apply_isComplex, e]
        rfl
      · show g (v.embedding t₀) = _
        rw [e]
        rfl
    · refine ⟨fun a => starRingEnd ℂ (a.2 ⟨v, hvc⟩), Complex.continuous_conj.comp ((continuous_apply _).comp continuous_snd),
        fun t => ?_, Or.inr ?_⟩
      · dsimp only
        rw [NumberField.mixedEmbedding.mixedEmbedding_apply_isComplex, e, NumberField.ComplexEmbedding.conjugate_coe_eq,
          Complex.conj_conj]
        rfl
      · show starRingEnd ℂ (g (v.embedding t₀)) = _
        rw [e, NumberField.ComplexEmbedding.conjugate_coe_eq]
        rfl

omit [NumberField F] in
private theorem coe_ιF (t : F) : ((ιF F t : fieldI F) : ℂ) = ((t : ℝ) : ℂ) := rfl

omit [NumberField F] in
private theorem one_sub_iL_ne_zero (t : F) : 1 - iL F * ιF F t ≠ 0 := fun h0 => by
  have := congrArg (fun z : fieldI F => (z : ℂ).re) h0
  simp [iL, coe_ιF] at this

omit [NumberField F] in
private theorem one_add_iL_ne_zero (t : F) : 1 + iL F * ιF F t ≠ 0 := fun h0 => by
  have := congrArg (fun z : fieldI F => (z : ℂ).re) h0
  simp [iL, coe_ιF] at this

omit [NumberField F] in
private theorem cay_mem_normOneL (t : F) : (1 + iL F * ιF F t) / (1 - iL F * ιF F t) ∈ normOneL F := by
  refine (mem_normOneL_iff F).2 ⟨Subtype.coe_prop _, ?_⟩
  have e : (((1 + iL F * ιF F t) / (1 - iL F * ιF F t) : fieldI F) : ℂ) =
      (1 + ((t : ℝ) : ℂ) * Complex.I) / (1 - ((t : ℝ) : ℂ) * Complex.I) := by
    rw [Subfield.coe_div, Subfield.coe_add, Subfield.coe_sub, Subfield.coe_mul, Subfield.coe_one, coe_ιF]
    show (1 + Complex.I * _) / (1 - Complex.I * _) = _
    rw [mul_comm Complex.I]
  rw [e]
  exact norm_cay (t : ℝ)

/-- **Weak approximation by `h`-th powers, away from `−1`, at `h ≥ 2`.** -/
private theorem mem_closure_pow_of_ne {x : fieldI F} (hx : x ∈ normOneL F) (hx1 : x ≠ -1) {h : ℕ} (hh : 2 ≤ h) :
    NumberField.mixedEmbedding (fieldI F) x ∈
      closure (NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)) := by
  -- `x = (1 + i t₀)/(1 − i t₀)` with `t₀ = Im x / (1 + Re x) ∈ F`
  have hxU := (mem_normOneL_iff F).1 hx
  obtain ⟨hre, him⟩ := (mem_fieldI F).1 x.2
  set a := (x : ℂ).re with ha
  set b := (x : ℂ).im with hb
  have hn : a ^ 2 + b ^ 2 = 1 := by
    have h1 := hxU.2
    rw [Complex.norm_def, Real.sqrt_eq_one, Complex.normSq_apply] at h1
    nlinarith
  have hxab : (x : ℂ) = a + b * Complex.I := (Complex.re_add_im _).symm
  have ha1 : 1 + a ≠ 0 := by
    intro h0
    have hb0 : b = 0 := by nlinarith
    apply hx1
    apply Subtype.ext
    rw [hxab, hb0, show a = -1 by linarith]
    simp
  set t₀ : F := ⟨b / (1 + a), F.div_mem him (F.add_mem F.one_mem hre)⟩ with ht₀
  have hxt : x = (1 + iL F * ιF F t₀) / (1 - iL F * ιF F t₀) := by
    rw [eq_div_iff (one_sub_iL_ne_zero F t₀)]
    apply Subtype.ext
    rw [Subfield.coe_mul, Subfield.coe_add, Subfield.coe_sub, Subfield.coe_mul, Subfield.coe_one, coe_ιF, hxab]
    show ((a : ℂ) + b * Complex.I) * (1 - Complex.I * ((b / (1 + a) : ℝ) : ℂ)) = 1 + Complex.I * ((b / (1 + a) : ℝ) : ℂ)
    have ha1' : (1 : ℂ) + a ≠ 0 := by exact_mod_cast ha1
    have hn' : (a : ℂ) ^ 2 + (b : ℂ) ^ 2 = 1 := by exact_mod_cast hn
    push_cast
    field_simp
    linear_combination hn' - (b : ℂ) ^ 2 * Complex.I_sq
  -- the places of `L`, all complex
  have hnotreal : ∀ w : {w : NumberField.InfinitePlace (fieldI F) // w.IsReal}, False := fun w =>
    NumberField.InfinitePlace.not_isReal_iff_isComplex.2 (isComplex_place F w.1) w.2
  set z : NumberField.InfinitePlace (fieldI F) → ℂ := fun w => w.embedding (ιF F t₀) with hz
  have hw1 : ∀ w, 1 + Complex.I * z w ≠ 0 ∧ 1 - Complex.I * z w ≠ 0 := by
    intro w
    have hp : w.embedding (1 + iL F * ιF F t₀) ≠ 0 := (map_ne_zero _).2 (one_add_iL_ne_zero F t₀)
    have hm : w.embedding (1 - iL F * ιF F t₀) ≠ 0 := (map_ne_zero _).2 (one_sub_iL_ne_zero F t₀)
    rw [map_add, map_one, map_mul] at hp
    rw [map_sub, map_one, map_mul] at hm
    rcases embedding_iL F w with hI | hI <;> rw [hI] at hp hm
    · exact ⟨hp, hm⟩
    · refine ⟨?_, ?_⟩
      · simpa [neg_mul, sub_eq_add_neg] using hm
      · simpa [neg_mul, sub_eq_add_neg] using hp
  choose lam hlamc hlame hlamy using fun w : NumberField.InfinitePlace (fieldI F) =>
    exists_coord F w t₀ (cayRoot h) (cayRoot_im hh)
  have hpow : ∀ w, 1 - w.embedding (iL F) * lam w (Ypt F t₀ (cayRoot h)) ≠ 0 ∧
      cayI (w.embedding (iL F)) (lam w (Ypt F t₀ (cayRoot h))) ^ h = cayI (w.embedding (iL F)) (z w) :=
    fun w => cay_pow_eq hh (hw1 w).1 (hw1 w).2 (embedding_iL F w) (hlamy w)
  -- the map `Ψ`
  set Ψ : NumberField.mixedEmbedding.mixedSpace F → NumberField.mixedEmbedding.mixedSpace (fieldI F) := fun c =>
    ((NumberField.mixedEmbedding (fieldI F) x).1, fun w => cayI (w.1.embedding (iL F)) (lam w.1 c) ^ h) with hΨ
  have hΨy : Ψ (Ypt F t₀ (cayRoot h)) = NumberField.mixedEmbedding (fieldI F) x := by
    refine Prod.ext rfl (funext fun w => ?_)
    show cayI _ (lam w.1 _) ^ h = (NumberField.mixedEmbedding (fieldI F) x).2 w
    rw [(hpow w.1).2, NumberField.mixedEmbedding.mixedEmbedding_apply_isComplex]
    conv_rhs => rw [hxt]
    rw [map_div₀, map_add, map_sub, map_one, map_mul]
    rfl
  have hΨe : ∀ t : F, Ψ (NumberField.mixedEmbedding F t) ∈
      NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F) := by
    intro t
    refine ⟨((1 + iL F * ιF F t) / (1 - iL F * ιF F t)) ^ h, ⟨_, cay_mem_normOneL F t, rfl⟩, ?_⟩
    refine Prod.ext (funext fun w => (hnotreal w).elim) (funext fun w => ?_)
    rw [NumberField.mixedEmbedding.mixedEmbedding_apply_isComplex]
    show w.1.embedding _ = cayI _ (lam w.1 (NumberField.mixedEmbedding F t)) ^ h
    rw [hlame, map_pow, map_div₀, map_add, map_sub, map_one, map_mul]
    rfl
  have hΨc : ContinuousAt Ψ (Ypt F t₀ (cayRoot h)) := by
    refine continuousAt_const.prodMk (continuousAt_pi.2 fun w => ?_)
    have hd := (hpow w.1).1
    exact ((continuousAt_const.add (continuousAt_const.mul (hlamc w.1).continuousAt)).div
      (continuousAt_const.sub (continuousAt_const.mul (hlamc w.1).continuousAt)) hd).pow h
  have h1 := mem_closure_image hΨc (dense_range_mixedEmbedding F (Ypt F t₀ (cayRoot h)))
  rw [hΨy] at h1
  refine closure_mono ?_ h1
  rintro _ ⟨_, ⟨t, rfl⟩, rfl⟩
  exact hΨe t

/-- **Weak approximation by `h`-th powers** — what the count reads of the archimedean torus. -/
theorem mem_closure_pow {x : fieldI F} (hx : x ∈ normOneL F) {h : ℕ} (hh : 1 ≤ h) :
    NumberField.mixedEmbedding (fieldI F) x ∈
      closure (NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)) := by
  rcases Nat.lt_or_ge h 2 with hh2 | hh2
  · obtain rfl : h = 1 := by omega
    exact subset_closure ⟨x, ⟨x, hx, pow_one x⟩, rfl⟩
  by_cases hx1 : x = -1
  · subst hx1
    have hiL : iL F ≠ -1 := fun h0 => by
      have := congrArg (fun z : fieldI F => (z : ℂ).re) h0
      simp [iL] at this
    have hi := mem_closure_pow_of_ne F (iL_mem_normOneL F) hiL hh2
    rw [← closure_powSubmonoid] at hi ⊢
    have := (powSubmonoid F h).topologicalClosure.mul_mem hi hi
    rwa [← map_mul, iL_mul_iL] at this
  · exact mem_closure_pow_of_ne F hx hx1 hh2

/-- **What the completion reads**: `Δ(e^{iθ}) · e(x)` is a limit of images of `h`-th powers of unit vectors — the closure
of a multiplicatively closed set is multiplicatively closed (`Submonoid.topologicalClosure`), and it holds `Δ(S¹)` and
`e(U)` (the two theorems above). -/
theorem Delta_circle_mul_mem_closure_pow (θ : ℝ) {x : fieldI F} (hx : x ∈ normOneL F) {h : ℕ} (hh : 1 ≤ h) :
    Delta F (Complex.exp (θ * Complex.I)) * NumberField.mixedEmbedding (fieldI F) x ∈
      closure (NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)) := by
  have h1 : Delta F (Complex.exp (θ * Complex.I)) ∈
      closure (NumberField.mixedEmbedding (fieldI F) '' ((· ^ h) '' normOneL F)) := by
    refine closure_minimal ?_ isClosed_closure (Delta_circle_mem_closure F θ)
    rintro _ ⟨y, hy, rfl⟩
    exact mem_closure_pow F hy hh
  have h2 := mem_closure_pow F hx hh
  rw [← closure_powSubmonoid] at h1 h2 ⊢
  exact (powSubmonoid F h).topologicalClosure.mul_mem h1 h2

omit [NumberField F] in
theorem pow_mem_normOneL {x : fieldI F} (hx : x ∈ normOneL F) (h : ℕ) : x ^ h ∈ normOneL F := by
  show x ^ h * conjOn (fieldI_conj F) (x ^ h) = 1
  rw [map_pow, ← mul_pow, show x * conjOn (fieldI_conj F) x = 1 from hx, one_pow]

omit [NumberField F] in
theorem mul_mem_normOneL {x y : fieldI F} (hx : x ∈ normOneL F) (hy : y ∈ normOneL F) : x * y ∈ normOneL F := by
  show x * y * conjOn (fieldI_conj F) (x * y) = 1
  rw [map_mul, mul_mul_mul_comm, show x * conjOn (fieldI_conj F) x = 1 from hx,
    show y * conjOn (fieldI_conj F) y = 1 from hy, one_mul]

/-! ## Spec examples -/

example : ((iL F : fieldI F) : ℂ) = Complex.I := rfl

end

end HadwigerNelson.Rigidity.Counting
