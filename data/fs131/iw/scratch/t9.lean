import Proofs.HadwigerNelson.Plane.Woodall.Collar
import Proofs.HadwigerNelson.Plane.LocalStructure
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric Polynomial

/-- The zeros of a real quartic with a nonzero coefficient of positive degree are finitely many. -/
theorem finite_roots_quartic (a0 a1 a2 a3 a4 : ℝ) (h : a1 ≠ 0 ∨ a2 ≠ 0 ∨ a3 ≠ 0 ∨ a4 ≠ 0) :
    {x : ℝ | a0 + a1 * x + a2 * x ^ 2 + a3 * x ^ 3 + a4 * x ^ 4 = 0}.Finite := by
  set P : ℝ[X] := C a0 + C a1 * X + C a2 * X ^ 2 + C a3 * X ^ 3 + C a4 * X ^ 4 with hP
  have hP0 : P ≠ 0 := by
    intro hz
    have h1 : P.coeff 1 = a1 := by simp [hP]
    have h2 : P.coeff 2 = a2 := by simp [hP]
    have h3 : P.coeff 3 = a3 := by simp [hP]
    have h4 : P.coeff 4 = a4 := by simp [hP]
    rw [hz] at h1 h2 h3 h4
    simp only [coeff_zero] at h1 h2 h3 h4
    rcases h with h | h | h | h
    · exact h h1.symm
    · exact h h2.symm
    · exact h h3.symm
    · exact h h4.symm
  refine (Polynomial.finite_setOf_isRoot hP0).subset fun x hx => ?_
  simp only [mem_setOf_eq] at hx ⊢
  simp [hP, IsRoot, eval_add, eval_mul, eval_pow, eval_C, eval_X]
  linarith


theorem framePt_re (v : ℂ) (β x y : ℝ) : (framePt v β x y).re = v.re + x * Real.cos β - y * Real.sin β := by
  simp [framePt, e_eq, Complex.mul_re, Complex.mul_im, -Complex.ofReal_cos, -Complex.ofReal_sin]
  ring

theorem framePt_im (v : ℂ) (β x y : ℝ) : (framePt v β x y).im = v.im + x * Real.sin β + y * Real.cos β := by
  simp [framePt, e_eq, Complex.mul_re, Complex.mul_im, -Complex.ofReal_cos, -Complex.ofReal_sin]
  ring

/-- **A nondegenerate arc meets the parabola of curvature `1/2` tangent to `e β` at `v` in finitely many points**: the parabola lies on no
circle and no line. -/
theorem Arc.finite_inter_parabola (a : Arc) (ha : a.Nondegenerate) (v : ℂ) (β : ℝ) :
    {x : ℝ | framePt v β x ((1 / 2 : ℝ) * x ^ 2 / 2) ∈ a.carrier}.Finite := by
  have hg : Real.cos β ^ 2 + Real.sin β ^ 2 = 1 := by rw [add_comm]; exact Real.sin_sq_add_cos_sq β
  cases a with
  | seg p q =>
    -- on the line through `p` and `q`
    have hpq : p ≠ q := ha
    obtain ⟨w1, hw1⟩ : ∃ w1, w1 = (q - p).re := ⟨_, rfl⟩
    obtain ⟨w2, hw2⟩ : ∃ w2, w2 = (q - p).im := ⟨_, rfl⟩
    have hw : w1 ≠ 0 ∨ w2 ≠ 0 := by
      by_contra hcon; push Not at hcon
      exact hpq (sub_eq_zero.mp (Complex.ext (by rw [← hw1]; simp [hcon.1]) (by rw [← hw2]; simp [hcon.2]))).symm
    refine (finite_roots_quartic ((v - p).im * w1 - (v - p).re * w2)
      (Real.sin β * w1 - Real.cos β * w2) ((Real.cos β * w1 + Real.sin β * w2) / 4) 0 0 ?_).subset ?_
    · by_contra hcon
      push Not at hcon
      obtain ⟨h1, h2, -, -⟩ := hcon
      have e1 : Real.cos β * w1 + Real.sin β * w2 = 0 := by linarith
      have hw1' : w1 = 0 := by
        have : w1 * (Real.cos β ^ 2 + Real.sin β ^ 2) = Real.cos β * (Real.cos β * w1 + Real.sin β * w2) + Real.sin β * (Real.sin β * w1 - Real.cos β * w2) := by ring
        rw [hg, e1, h1] at this; linarith
      have hw2' : w2 = 0 := by
        have : w2 * (Real.cos β ^ 2 + Real.sin β ^ 2) = Real.sin β * (Real.cos β * w1 + Real.sin β * w2) - Real.cos β * (Real.sin β * w1 - Real.cos β * w2) := by ring
        rw [hg, e1, h1] at this; linarith
      rcases hw with h | h <;> contradiction
    · intro x hx
      simp only [Arc.carrier, mem_setOf_eq] at hx ⊢
      obtain ⟨s, t, hs, ht, hst, hz⟩ := hx
      have hre := congrArg Complex.re hz
      have him := congrArg Complex.im hz
      rw [framePt_re] at hre
      rw [framePt_im] at him
      simp [Complex.add_re, Complex.add_im] at hre him
      have hw1' : w1 = q.re - p.re := by rw [hw1]; simp
      have hw2' : w2 = q.im - p.im := by rw [hw2]; simp
      have hs' : s = 1 - t := by linarith
      subst hs'
      have hvp1 : (v - p).re = v.re - p.re := Complex.sub_re v p
      have hvp2 : (v - p).im = v.im - p.im := Complex.sub_im v p
      rw [hvp1, hvp2, hw1', hw2']
      linear_combination (q.re - p.re) * (-1 : ℝ) * him + (q.im - p.im) * hre
  | circ c ρ θ₀ θ₁ =>
    have hρ : 0 < ρ := ha.1
    refine (finite_roots_quartic ((v.re - c.re) ^ 2 + (v.im - c.im) ^ 2 - ρ ^ 2)
      (2 * ((v.re - c.re) * Real.cos β + (v.im - c.im) * Real.sin β))
      (((v.im - c.im) * Real.cos β - (v.re - c.re) * Real.sin β) / 2 + 1) 0 (1 / 16) (Or.inr (Or.inr (Or.inr (by norm_num))))).subset ?_
    intro x hx
    simp only [Arc.carrier, mem_setOf_eq] at hx ⊢
    obtain ⟨θ, -, hz⟩ := hx
    have hn : ‖framePt v β x ((1 / 2 : ℝ) * x ^ 2 / 2) - c‖ ^ 2 = ρ ^ 2 := by
      rw [← hz, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hρ]
    rw [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, framePt_re, framePt_im] at hn
    linear_combination hn - (x ^ 2 + x ^ 4 / 16) * hg

end HadwigerNelson.Plane
