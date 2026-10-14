import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.Complex.Basic

/-! FS131-KM11 first leaf, priced in scratch: `gram_sum_eq`, stated exactly as in `Rigidity/SpectralSubspace`. -/

namespace HadwigerNelson.Rigidity.KM11Scratch

theorem gram_sum_eq {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] {ι : Type*} (v : ι → E) (s : Finset ι)
    (z : ι → ℂ) :
    ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * ((inner ℝ (v y) (v x) : ℝ) : ℂ) =
      ((‖∑ x ∈ s, (z x).re • v x‖ ^ 2 + ‖∑ x ∈ s, (z x).im • v x‖ ^ 2 : ℝ) : ℂ) := by
  have hsq : ∀ c : ι → ℝ, ‖∑ x ∈ s, c x • v x‖ ^ 2 = ∑ x ∈ s, ∑ y ∈ s, c x * c y * inner ℝ (v y) (v x) := by
    intro c
    rw [← real_inner_self_eq_norm_sq, sum_inner]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [inner_sum]
    refine Finset.sum_congr rfl fun y _ => ?_
    rw [real_inner_smul_left, real_inner_smul_right, real_inner_comm (v y)]
    ring
  apply Complex.ext
  · rw [Complex.ofReal_re, hsq, hsq, ← Finset.sum_add_distrib, Complex.re_sum]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [Complex.re_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun y _ => ?_
    simp only [Complex.mul_re, Complex.star_def, Complex.conj_re, Complex.conj_im, Complex.ofReal_re,
      Complex.ofReal_im, Complex.mul_im]
    ring
  · rw [Complex.ofReal_im, Complex.im_sum]
    have h : ∀ x y, (z x * star (z y) * ((inner ℝ (v y) (v x) : ℝ) : ℂ)).im =
        ((z x).im * (z y).re - (z x).re * (z y).im) * inner ℝ (v y) (v x) := by
      intro x y
      simp only [Complex.mul_re, Complex.star_def, Complex.conj_re, Complex.conj_im, Complex.ofReal_re,
        Complex.ofReal_im, Complex.mul_im]
      ring
    simp only [Complex.im_sum, h, sub_mul, Finset.sum_sub_distrib]
    rw [sub_eq_zero, Finset.sum_comm]
    refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
    rw [real_inner_comm]
    ring

end HadwigerNelson.Rigidity.KM11Scratch
