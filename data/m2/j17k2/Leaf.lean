import Mathlib.NumberTheory.FLT.Polynomial
import Mathlib.RingTheory.Polynomial.RationalRoot
open Polynomial
variable {k : Type*} [Field k]

theorem exists_eq_C_mul_sq_of_mul_eq_sq {x y g : k[X]} (hxy : IsCoprime x y) (h : x * y = g ^ 2) :
    ∃ (r : k) (α : k[X]), r ≠ 0 ∧ α ^ 2 * C r = x := by
  obtain ⟨α, u, hu⟩ := exists_associated_pow_of_mul_eq_pow' hxy h
  obtain ⟨r, hr, hC⟩ := Polynomial.isUnit_iff.mp u.isUnit
  exact ⟨r, α, hr.ne_zero, by rw [hC]; exact hu⟩

theorem natDegree_eq_zero_of_mul_mul_sub_eq_sq (h2 : (2 : k) ≠ 0) {p q g : k[X]} (hpq : IsCoprime p q)
    (hg : p * q * (p ^ 2 - q ^ 2) = g ^ 2) : p.natDegree = 0 ∧ q.natDegree = 0 := by
  -- the degenerate cases: one of `p`, `q`, `p² − q²` is zero
  have hunit : ∀ {x : k[X]}, IsUnit x → x.natDegree = 0 := fun hx => natDegree_eq_zero_of_isUnit hx
  by_cases hp0 : p = 0
  · subst hp0
    exact ⟨natDegree_zero, hunit (isCoprime_zero_left.mp hpq)⟩
  by_cases hq0 : q = 0
  · subst hq0
    exact ⟨hunit (isCoprime_zero_right.mp hpq), natDegree_zero⟩
  -- the three factors are pairwise coprime
  have hp_s : IsCoprime p (p ^ 2 - q ^ 2) := by
    have := (hpq.pow_right (n := 2)).neg_right.add_mul_left_right p
    rwa [show -q ^ 2 + p * p = p ^ 2 - q ^ 2 by ring] at this
  have hq_s : IsCoprime q (p ^ 2 - q ^ 2) := by
    have := (hpq.symm.pow_right (n := 2)).add_mul_left_right (-q)
    rwa [show p ^ 2 + q * -q = p ^ 2 - q ^ 2 by ring] at this
  by_cases hs0 : p ^ 2 - q ^ 2 = 0
  · have hpq2 : p ^ 2 = q ^ 2 := sub_eq_zero.mp hs0
    refine ⟨hunit ((hpq.pow_right (n := 2)).isUnit_of_dvd' dvd_rfl ⟨p, by rw [← hpq2]; ring⟩),
      hunit ((hpq.symm.pow_right (n := 2)).isUnit_of_dvd' dvd_rfl ⟨q, by rw [hpq2]; ring⟩)⟩
  -- each factor is a unit times a square
  obtain ⟨r₁, α, hr₁, hα⟩ := exists_eq_C_mul_sq_of_mul_eq_sq (hpq.mul_right hp_s)
    (show p * (q * (p ^ 2 - q ^ 2)) = g ^ 2 by rw [← hg]; ring)
  obtain ⟨r₂, β, hr₂, hβ⟩ := exists_eq_C_mul_sq_of_mul_eq_sq (hpq.symm.mul_right hq_s)
    (show q * (p * (p ^ 2 - q ^ 2)) = g ^ 2 by rw [← hg]; ring)
  obtain ⟨r₃, γ, hr₃, hγ⟩ := exists_eq_C_mul_sq_of_mul_eq_sq (hp_s.symm.mul_right hq_s.symm)
    (show (p ^ 2 - q ^ 2) * (p * q) = g ^ 2 by rw [← hg]; ring)
  have hα0 : α ≠ 0 := by rintro rfl; apply hp0; rw [← hα]; ring
  have hβ0 : β ≠ 0 := by rintro rfl; apply hq0; rw [← hβ]; ring
  have hγ0 : γ ≠ 0 := by rintro rfl; apply hs0; rw [← hγ]; ring
  have hαβ : IsCoprime α β := by
    rw [← hα, ← hβ] at hpq
    exact (IsCoprime.pow_iff two_pos two_pos).mp hpq.of_mul_left_left.of_mul_right_left
  -- the Fermat–Catalan equation of signature (4, 4, 2)
  have heq : C (r₁ ^ 2) * α ^ 4 + C (-r₂ ^ 2) * β ^ 4 + C (-r₃) * γ ^ 2 = 0 := by
    simp only [map_pow, map_neg]
    linear_combination (α ^ 2 * C r₁ + p) * hα - (β ^ 2 * C r₂ + q) * hβ - hγ
  have h4 : ((4 : ℕ) : k) ≠ 0 := by
    rw [show ((4 : ℕ) : k) = 2 * 2 by norm_num]; exact mul_ne_zero h2 h2
  obtain ⟨hαd, hβd, -⟩ := Polynomial.flt_catalan (p := 4) (q := 4) (r := 2) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) h4 h4 (by exact_mod_cast h2) hα0 hβ0 hγ0 hαβ (pow_ne_zero 2 hr₁)
    (neg_ne_zero.mpr (pow_ne_zero 2 hr₂)) (neg_ne_zero.mpr hr₃) heq
  refine ⟨?_, ?_⟩
  · rw [← hα, natDegree_mul_C hr₁, natDegree_pow, hαd, mul_zero]
  · rw [← hβ, natDegree_mul_C hr₂, natDegree_pow, hβd, mul_zero]
