import Proofs.HadwigerNelson.Arith.StandingFive
import Mathlib.RingTheory.RootsOfUnity.Complex

namespace HadwigerNelson.StandingFive

open Finset

/-- Cyclic convolution on `ℤ[C₂₉]`, as vectors of length 29. -/
def cconv (v w : Fin 29 → ℤ) : Fin 29 → ℤ := fun m => ∑ j : Fin 29, v j * w (m - j)

/-- Evaluation of a vector of `ℤ[C₂₉]` at a character. -/
noncomputable def cev (χ : Fin 29 → ℂ) (v : Fin 29 → ℤ) : ℂ := ∑ k : Fin 29, (v k : ℂ) * χ k

theorem cev_cconv (χ : Fin 29 → ℂ) (hχ : ∀ j k, χ (j + k) = χ j * χ k) (v w : Fin 29 → ℤ) :
    cev χ (cconv v w) = cev χ v * cev χ w := by
  unfold cev cconv
  calc ∑ m, ((∑ j, v j * w (m - j) : ℤ) : ℂ) * χ m
      = ∑ m, ∑ j, (v j : ℂ) * χ j * ((w (m - j) : ℂ) * χ (m - j)) := by
        refine Finset.sum_congr rfl fun m _ => ?_
        rw [Int.cast_sum, Finset.sum_mul]
        refine Finset.sum_congr rfl fun j _ => ?_
        have hm : χ m = χ j * χ (m - j) := by rw [← hχ, add_sub_cancel]
        rw [hm]; push_cast; ring
    _ = ∑ j, ∑ m, (v j : ℂ) * χ j * ((w (m - j) : ℂ) * χ (m - j)) := Finset.sum_comm
    _ = ∑ j, (v j : ℂ) * χ j * ∑ k, (w k : ℂ) * χ k := by
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [Finset.mul_sum]
        exact Fintype.sum_equiv (Equiv.subRight j) _ _ fun m => rfl
    _ = _ := by rw [Finset.sum_mul]

theorem cev_add (χ : Fin 29 → ℂ) (v w : Fin 29 → ℤ) : cev χ (v + w) = cev χ v + cev χ w := by
  simp [cev, add_mul, Finset.sum_add_distrib]

def cdelta (n : ℤ) : Fin 29 → ℤ := fun k => if k = 0 then n else 0

theorem cev_cdelta (χ : Fin 29 → ℂ) (h0 : χ 0 = 1) (n : ℤ) : cev χ (cdelta n) = n := by
  simp [cev, cdelta, h0]

def hvec : Fin 29 → ℤ := ![0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
def tvec1 : Fin 29 → ℤ := ![1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
def tvec2 : Fin 29 → ℤ := ![-8, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 2, 1, 2, 0, 0, 2, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1]
def tvec3 : Fin 29 → ℤ := ![-3, -3, 1, 1, 3, 1, 3, 1, 0, 0, 3, 2, -3, 2, 3, 3, 2, -3, 2, 3, 0, 0, 1, 3, 1, 3, 1, 1, -3]
def tvec4 : Fin 29 → ℤ := ![16, 2, 4, 7, 4, 4, 7, 7, 4, 4, 4, 0, 2, 0, 7, 7, 0, 2, 0, 4, 4, 4, 7, 7, 4, 4, 7, 4, 2]
def tvec5 : Fin 29 → ℤ := ![22, 20, 20, 19, 15, 20, 18, 19, 19, 19, 15, 15, 20, 15, 18, 18, 15, 20, 15, 15, 19, 19, 19, 18, 20, 15, 19, 20, 20]
def tvec6 : Fin 29 → ℤ := ![71, 72, 72, 72, 73, 72, 72, 72, 72, 72, 73, 73, 72, 73, 72, 72, 73, 72, 73, 73, 72, 72, 72, 72, 72, 73, 72, 72, 72]

set_option maxRecDepth 100000 in
theorem horner1 : hvec + cdelta 1 = tvec1 := by decide +kernel
set_option maxRecDepth 100000 in
theorem horner2 : cconv tvec1 hvec + cdelta (-12) = tvec2 := by decide +kernel
set_option maxRecDepth 100000 in
theorem horner3 : cconv tvec2 hvec + cdelta (-7) = tvec3 := by decide +kernel
set_option maxRecDepth 100000 in
theorem horner4 : cconv tvec3 hvec + cdelta 28 = tvec4 := by decide +kernel
set_option maxRecDepth 100000 in
theorem horner5 : cconv tvec4 hvec + cdelta 14 = tvec5 := by decide +kernel
set_option maxRecDepth 100000 in
theorem horner6 : cconv tvec5 hvec + cdelta (-9) = tvec6 := by decide +kernel
set_option maxRecDepth 100000 in
theorem horner7 : cconv tvec6 hvec + cdelta 1 = fun _ => 289 := by decide +kernel


/-- The character `k ↦ ζ^k`, `ζ = e^{2πi/29}`. -/
noncomputable def chi29 (k : Fin 29) : ℂ := Complex.exp (2 * Real.pi * Complex.I / (29 : ℕ)) ^ (k : ℕ)

theorem chi29_add (j k : Fin 29) : chi29 (j + k) = chi29 j * chi29 k := by
  have h1 : Complex.exp (2 * Real.pi * Complex.I / (29 : ℕ)) ^ 29 = 1 :=
    (Complex.isPrimitiveRoot_exp 29 (by norm_num)).pow_eq_one
  rw [chi29, chi29, chi29, ← pow_add, Fin.val_add, ← pow_eq_pow_mod _ h1]

theorem chi29_zero : chi29 0 = 1 := by simp [chi29]

theorem sum_chi29 : ∑ k : Fin 29, chi29 k = 0 := by
  have h := (Complex.isPrimitiveRoot_exp 29 (by norm_num)).geom_sum_eq_zero (by norm_num)
  rw [← Fin.sum_univ_eq_sum_range] at h
  exact h

theorem chi29_eq (k : Fin 29) : chi29 k =
    (Real.cos (2 * Real.pi * (k : ℕ) / 29) : ℂ) + (Real.sin (2 * Real.pi * (k : ℕ) / 29) : ℂ) * Complex.I := by
  rw [chi29, ← Complex.exp_nat_mul, Complex.ofReal_cos, Complex.ofReal_sin, ← Complex.exp_mul_I]
  congr 1
  push_cast
  ring

theorem cev_hvec : cev chi29 hvec = (eta : ℂ) := by
  have h : cev chi29 hvec = chi29 1 + chi29 12 + chi29 17 + chi29 28 := by
    simp [cev, hvec, Fin.sum_univ_succ]
    ring
  rw [h, chi29_eq, chi29_eq, chi29_eq, chi29_eq, eta]
  have c28 : Real.cos (2 * Real.pi * 28 / 29) = Real.cos (2 * Real.pi / 29) := by
    rw [← Real.cos_two_pi_sub]; congr 1; ring
  have s28 : Real.sin (2 * Real.pi * 28 / 29) = -Real.sin (2 * Real.pi / 29) := by
    rw [← Real.sin_two_pi_sub]; congr 1; ring
  have c17 : Real.cos (2 * Real.pi * 17 / 29) = Real.cos (24 * Real.pi / 29) := by
    rw [← Real.cos_two_pi_sub]; congr 1; ring
  have s17 : Real.sin (2 * Real.pi * 17 / 29) = -Real.sin (24 * Real.pi / 29) := by
    rw [← Real.sin_two_pi_sub]; congr 1; ring
  have c12 : (2 * Real.pi * 12 / 29) = (24 * Real.pi / 29) := by ring
  have c1 : (2 * Real.pi * 1 / 29) = (2 * Real.pi / 29) := by ring
  have v12 : ((12 : Fin 29) : ℕ) = 12 := rfl
  have v17 : ((17 : Fin 29) : ℕ) = 17 := rfl
  have v28 : ((28 : Fin 29) : ℕ) = 28 := rfl
  simp only [Fin.val_one, Nat.cast_one, v12, v17, v28, Nat.cast_ofNat]
  rw [c28, s28, c17, s17, c12, c1]
  push_cast
  ring

/-- **`g(η) = 0`**: the period polynomial vanishes at the Gaussian period. -/
theorem g_eta : eta ^ 7 + eta ^ 6 - 12 * eta ^ 5 - 7 * eta ^ 4 + 28 * eta ^ 3 + 14 * eta ^ 2 - 9 * eta + 1 = 0 := by
  have hc := cev_cconv chi29 chi29_add
  have hd := cev_cdelta chi29 chi29_zero
  have e1 : cev chi29 tvec1 = eta + 1 := by rw [← horner1, cev_add, hd, cev_hvec]; norm_num
  have e2 : cev chi29 tvec2 = (eta + 1) * eta - 12 := by rw [← horner2, cev_add, hd, hc, e1, cev_hvec]; push_cast; ring
  have e3 : cev chi29 tvec3 = ((eta + 1) * eta - 12) * eta - 7 := by rw [← horner3, cev_add, hd, hc, e2, cev_hvec]; push_cast; ring
  have e4 : cev chi29 tvec4 = (((eta + 1) * eta - 12) * eta - 7) * eta + 28 := by
    rw [← horner4, cev_add, hd, hc, e3, cev_hvec]; push_cast; ring
  have e5 : cev chi29 tvec5 = ((((eta + 1) * eta - 12) * eta - 7) * eta + 28) * eta + 14 := by
    rw [← horner5, cev_add, hd, hc, e4, cev_hvec]; push_cast; ring
  have e6 : cev chi29 tvec6 = (((((eta + 1) * eta - 12) * eta - 7) * eta + 28) * eta + 14) * eta - 9 := by
    rw [← horner6, cev_add, hd, hc, e5, cev_hvec]; push_cast; ring
  have e7 : cev chi29 (fun _ => 289) = ((((((eta + 1) * eta - 12) * eta - 7) * eta + 28) * eta + 14) * eta - 9) * eta + 1 := by
    rw [← horner7, cev_add, hd, hc, e6, cev_hvec]; push_cast; ring
  have e0 : cev chi29 (fun _ => 289) = 0 := by
    simp only [cev]
    rw [← Finset.mul_sum, sum_chi29, mul_zero]
  have : ((eta ^ 7 + eta ^ 6 - 12 * eta ^ 5 - 7 * eta ^ 4 + 28 * eta ^ 3 + 14 * eta ^ 2 - 9 * eta + 1 : ℝ) : ℂ) = 0 := by
    push_cast
    rw [← e0, e7]; ring
  exact_mod_cast this

end HadwigerNelson.StandingFive
