import Proofs.HadwigerNelson.Plane.Woodall.Collar
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

/-- `e` has period `2π m` for every integer `m`. -/
theorem e_add_int_mul_two_pi (θ : ℝ) (m : ℤ) : e (θ + 2 * π * m) = e θ := by
  have h : e (2 * π * m) = 1 := by
    rw [e, show ((2 * π * m : ℝ) : ℂ) * I = (m : ℂ) * (2 * π * I) by push_cast; ring]
    exact Complex.exp_int_mul_two_pi_mul_I m
  rw [e_add, h, mul_one]

/-- `1 − e(2φ) = 2 sin φ · e(φ − π/2)`. -/
theorem one_sub_e_two_mul (φ : ℝ) : 1 - e (2 * φ) = ((2 * Real.sin φ : ℝ) : ℂ) * e (φ - π / 2) := by
  have hsc : Complex.sin (φ : ℂ) ^ 2 + Complex.cos (φ : ℂ) ^ 2 = 1 := Complex.sin_sq_add_cos_sq _
  rw [e_eq, e_eq, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, Real.cos_two_mul, Real.sin_two_mul]
  push_cast
  linear_combination (-2 : ℂ) * hsc

/-- `1 − e(−2φ) = 2 sin φ · e(π/2 − φ)`. -/
theorem one_sub_e_neg_two_mul (φ : ℝ) : 1 - e (-(2 * φ)) = ((2 * Real.sin φ : ℝ) : ℂ) * e (π / 2 - φ) := by
  have hsc : Complex.sin (φ : ℂ) ^ 2 + Complex.cos (φ : ℂ) ^ 2 = 1 := Complex.sin_sq_add_cos_sq _
  rw [e_eq, e_eq, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, Real.cos_neg, Real.sin_neg, Real.cos_two_mul, Real.sin_two_mul]
  push_cast
  linear_combination (-2 : ℂ) * hsc

end HadwigerNelson.Plane
