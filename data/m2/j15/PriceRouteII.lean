import Mathlib.FieldTheory.RatFunc.AsPolynomial

/-!
# J15 stage 1, route (ii): the residue hom at `t = 0` through polynomials (`denom`, `RatFunc.eval`)

Sub-leaf 1: the `t`-integral subring `{f | denom f (0) ≠ 0}`. Sub-leaf 2: evaluation at `0` as a ring hom on it.
-/

set_option autoImplicit false

namespace J15Price

open Polynomial

variable (F : Type*) [Field F]

/-- A divisor of a polynomial that does not vanish at `0` does not vanish at `0`. -/
theorem eval_zero_ne_zero_of_dvd {p q : F[X]} (h : p ∣ q) (hq : q.eval 0 ≠ 0) : p.eval 0 ≠ 0 :=
  fun hp => hq (Polynomial.eval₂_eq_zero_of_dvd_of_eval₂_eq_zero _ _ h hp)

/-- **Sub-leaf 1.** The rational functions with no pole at `0`. -/
noncomputable def zeroIntegral : Subring (RatFunc F) where
  carrier := {f | (RatFunc.denom f).eval 0 ≠ 0}
  zero_mem' := by simp [RatFunc.denom_zero]
  one_mem' := by simp [RatFunc.denom_one]
  add_mem' {x y} hx hy := eval_zero_ne_zero_of_dvd F (RatFunc.denom_add_dvd x y)
    (by rw [Polynomial.eval_mul]; exact mul_ne_zero hx hy)
  mul_mem' {x y} hx hy := eval_zero_ne_zero_of_dvd F (RatFunc.denom_mul_dvd x y)
    (by rw [Polynomial.eval_mul]; exact mul_ne_zero hx hy)
  neg_mem' {x} hx := by
    have h1 : (RatFunc.denom (-1 : RatFunc F)).eval 0 ≠ 0 := by
      rw [show (-1 : RatFunc F) = algebraMap F[X] _ (-1) by simp, RatFunc.denom_algebraMap]; simp
    have := eval_zero_ne_zero_of_dvd F (RatFunc.denom_mul_dvd (-1) x)
      (by rw [Polynomial.eval_mul]; exact mul_ne_zero h1 hx)
    simpa using this

/-- **Sub-leaf 2.** Evaluation at `t = 0`, a ring hom on the `t`-integral subring. -/
noncomputable def evalZero : zeroIntegral F →+* F where
  toFun f := RatFunc.eval (RingHom.id F) 0 f
  map_one' := by simp
  map_zero' := by simp
  map_add' x y := by
    simp only [Subring.coe_add]
    exact RatFunc.eval_add _ _ x.2 y.2
  map_mul' x y := by
    simp only [Subring.coe_mul]
    exact RatFunc.eval_mul _ _ x.2 y.2

example : (evalZero ℚ ⟨RatFunc.C 3, by simp [zeroIntegral]⟩) = 3 := by
  show RatFunc.eval (RingHom.id ℚ) 0 (RatFunc.C 3) = 3
  rw [RatFunc.eval_C]; rfl

end J15Price
