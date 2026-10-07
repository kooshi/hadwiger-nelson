import Proofs.HadwigerNelson.Plane.Radius
import Mathlib.Geometry.Euclidean.Basic

namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Metric

variable {α : Type*}

theorem probe_abs_inner_lt_one {u v : ℂ} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (h₁ : u ≠ v) (h₂ : u ≠ -v) :
    |inner ℝ u v| < 1 := by
  have hle : |inner ℝ u v| ≤ 1 := by
    have := abs_real_inner_le_norm u v
    rwa [hu, hv, one_mul] at this
  rcases hle.lt_or_eq with h | h
  · exact h
  · exfalso
    rcases abs_eq (zero_le_one' ℝ) |>.mp h with h | h
    · exact h₁ ((inner_eq_one_iff_of_norm_eq_one hu hv).mp h)
    · exact h₂ ((inner_eq_neg_one_iff_of_norm_eq_one hu hv).mp h)

theorem probe_quadrant {u v : ℂ} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) {s t : ℝ} (hs : s = 1 ∨ s = -1)
    (ht : t = 1 ∨ t = -1) (ε : ℝ) :
    ‖u + ε • (s • u + t • v)‖ ^ 2 - 1 = 2 * ε * (1 + s * t * inner ℝ u v) * (s + ε) := by
  have hs2 : s ^ 2 = 1 := by rcases hs with rfl | rfl <;> norm_num
  have ht2 : t ^ 2 = 1 := by rcases ht with rfl | rfl <;> norm_num
  have hd : ‖s • u + t • v‖ ^ 2 = 2 + 2 * s * t * inner ℝ u v := by
    rw [norm_add_sq_real, norm_smul, norm_smul, hu, hv, inner_smul_left, inner_smul_right]
    simp only [Real.norm_eq_abs, mul_one, sq_abs, RCLike.conj_to_real]
    linear_combination hs2 + ht2
  have hi : inner ℝ u (ε • (s • u + t • v)) = ε * (s + t * inner ℝ u v) := by
    rw [inner_smul_right, inner_add_right, inner_smul_right, inner_smul_right, real_inner_self_eq_norm_sq, hu]
    ring
  rw [norm_add_sq_real, norm_smul, mul_pow, hd, hi, hu, Real.norm_eq_abs, sq_abs]
  linear_combination (-(2 * ε * t * inner ℝ u v)) * hs2

/-- The shadow core, with no measurability. -/
theorem probe_shadow {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) {W : Set ℂ} (hW : IsOpen W) (hWU : W ⊆ U)
    {i : α} (hi : ∀ᵐ z, z ∈ W → c z = i) : ∀ᵐ z, z ∈ U ∩ unitShadow W → c z ≠ i := by
  -- the pairs from a point of `U` of label `i` into `W` are null: monochromatic, or the far end is off its label
  have hN : (volume : Measure ℂ) {z | ¬ (z ∈ W → c z = i)} = 0 := ae_iff.mp hi
  have hM := (measurePreserving_motionMul_right (1, 0)).quasiMeasurePreserving.preimage_null
    (show (volume : Measure (ℂ × ℝ)) ({z | ¬ (z ∈ W → c z = i)} ×ˢ (univ : Set ℝ)) = 0 by
      rw [Measure.volume_eq_prod, Measure.prod_prod, hN, zero_mul])
  have hT : (volume : Measure (ℂ × ℝ)) {q | q.1 ∈ U ∧ c q.1 = i ∧ q.1 + e q.2 ∈ W} = 0 := by
    refine measure_mono_null (fun q hq => ?_) (measure_union_null (aeProperOn_iff_volume.mp hc) hM)
    obtain ⟨h1, h2, h3⟩ := hq
    by_cases h4 : c (q.1 + e q.2) = i
    · exact Or.inl ⟨h1, hWU h3, h2.trans h4.symm⟩
    · refine Or.inr ?_
      show motionMul q (1, 0) ∈ {z | ¬ (z ∈ W → c z = i)} ×ˢ (univ : Set ℝ)
      refine ⟨?_, mem_univ _⟩
      simp only [motionMul, rigidMotion, mul_one, mem_setOf_eq, Classical.not_imp]
      exact ⟨h3, h4⟩
  rw [Measure.volume_eq_prod] at hT
  have hsl := Measure.measure_ae_null_of_prod_null hT
  filter_upwards [hsl] with z hz hzU hzi
  obtain ⟨hzU, y, hyW, hzy⟩ := hzU
  -- the directions from `z` into `W` are a non-empty open set of angles
  have hopen : IsOpen {θ : ℝ | z + e θ ∈ W} := hW.preimage (continuous_const.add continuous_e)
  obtain ⟨θ₀, -, hθ₀⟩ := exists_angle_of_norm_eq_one (z := y - z)
    (by rw [← dist_eq_norm, dist_comm]; exact hzy)
  have hne : {θ : ℝ | z + e θ ∈ W}.Nonempty := ⟨θ₀, by
    show z + e θ₀ ∈ W
    rw [← hθ₀]; simpa using hyW⟩
  have hpos := hopen.measure_pos volume hne
  have hsub : {θ : ℝ | z + e θ ∈ W} ⊆ Prod.mk z ⁻¹' {q : ℂ × ℝ | q.1 ∈ U ∧ c q.1 = i ∧ q.1 + e q.2 ∈ W} :=
    fun θ hθ => ⟨hzU, hzi, hθ⟩
  exact hpos.ne' (measure_mono_null hsub hz)

end HadwigerNelson.Plane
