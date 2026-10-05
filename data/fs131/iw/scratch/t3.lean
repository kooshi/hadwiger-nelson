import Proofs.HadwigerNelson.Plane.Woodall.Basic
import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.Chord
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

theorem dot_eq (a b : ℂ) : dot a b = a.re * b.re + a.im * b.im := by
  simp [dot, Complex.mul_re]

theorem abs_dot_le (a b : ℂ) : |dot a b| ≤ ‖a‖ * ‖b‖ := by
  have : dot a b = (a * starRingEnd ℂ b).re := rfl
  rw [this, ← norm_conj b, ← norm_mul]
  exact Complex.abs_re_le_norm _

theorem dot_add_left (a b c : ℂ) : dot (a + b) c = dot a c + dot b c := by
  simp [dot_eq]; ring

theorem dot_sub_left (a b c : ℂ) : dot (a - b) c = dot a c - dot b c := by
  simp [dot_eq]; ring

theorem dot_sub_right (a b c : ℂ) : dot a (b - c) = dot a b - dot a c := by
  simp [dot_eq]; ring

theorem dot_real_mul_left (r : ℝ) (a b : ℂ) : dot ((r : ℂ) * a) b = r * dot a b := by
  simp [dot_eq]; ring

theorem dot_e_e (a b : ℝ) : dot (e a) (e b) = Real.cos (a - b) := by
  rw [dot_eq, e_eq, e_eq, Real.cos_sub]; simp [-Complex.ofReal_cos, -Complex.ofReal_sin]

theorem norm_sub_real_mul_e_sq (q : ℂ) (ρ ψ : ℝ) : ‖q - (ρ : ℂ) * e ψ‖ ^ 2 = ‖q‖ ^ 2 + ρ ^ 2 - 2 * ρ * dot q (e ψ) := by
  rw [dot_eq, e_eq]
  simp only [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im,
    Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
  simp
  nlinarith [Real.sin_sq_add_cos_sq ψ]

/-- A preconnected set with a point inside and a point outside the unit circle about `z` meets it. -/
theorem mem_shadow_of_preconnected {R : Set ℂ} (hR : IsPreconnected R) {z a b : ℂ} (ha : a ∈ R) (hb : b ∈ R)
    (hza : dist z a < 1) (hzb : 1 < dist z b) : z ∈ shadow R := by
  have himg : IsPreconnected ((fun y => dist z y) '' R) := hR.image _ (continuous_const.dist continuous_id).continuousOn
  obtain ⟨y, hy, hy1⟩ := himg.Icc_subset ⟨a, ha, rfl⟩ ⟨b, hb, rfl⟩ ⟨hza.le, hzb.le⟩
  exact ⟨y, hy, hy1⟩

end HadwigerNelson.Plane
