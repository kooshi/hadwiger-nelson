import Proofs.HadwigerNelson.Plane.SixRing.Basic

/-!
# The chart about the ring and the hubs: plane geometry (FS-132, C132-M-ORBIT steps M2, M5, M6)

No colouring and no measure. Every statement is an identity or an inequality of plane trigonometry about
`chart p α d = p + e(α) + e(α − 2π/3 − d)` and `hub p ψ n = p + e(ψ + nπ/3)`; each is a leaf of a few lines.
`plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.

Every leaf is proved (job FS132-I4, under Amendment 2 of its brief); no `sorry`. `chart_eq_polar` states what
`chart_eq_polar_shift` of `Plane/SixRing/Shift` states (FS132-I3 proved that one where it was needed: the shift's
module does not import this one, nor this one that); the proof here is the same sum-to-product.
-/

open scoped RealInnerProductSpace

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

/-- **M2, the chart in polar form** (the derivation's "`|Z| = 2 cos(π/3 + d/2)` and `arg Z = α − π/3 − d/2`", as one
identity valid for all real `α`, `d`): `Z(α, d) = p + r(d) e(α − π/3 − d/2)`. Sum-to-product. -/
theorem chart_eq_polar (p : ℂ) (α d : ℝ) :
    chart p α d = p + ((ringRadius d : ℝ) : ℂ) * Plane.e (α - π / 3 - d / 2) := by
  have hsum : Plane.e α + Plane.e (α - 2 * π / 3 - d) =
      Plane.e ((α - π / 3 - d / 2) + (π / 3 + d / 2)) + Plane.e ((α - π / 3 - d / 2) + -(π / 3 + d / 2)) := by
    congr 2 <;> ring
  have hpair : Plane.e (π / 3 + d / 2) + Plane.e (-(π / 3 + d / 2)) = ((ringRadius d : ℝ) : ℂ) := by
    rw [Plane.e_eq, Plane.e_eq, cos_neg, sin_neg, ringRadius]
    push_cast
    ring
  rw [chart, add_assoc, hsum, Plane.e_add (α - π / 3 - d / 2) (π / 3 + d / 2),
    Plane.e_add (α - π / 3 - d / 2) (-(π / 3 + d / 2)), ← mul_add, hpair, mul_comm]

/-- At `d = 0` the chart is on the ring: `Z(α, 0) = p + e(α − π/3)`. -/
theorem chart_zero (p : ℂ) (α : ℝ) : chart p α 0 = p + Plane.e (α - π / 3) := by
  have h : ringRadius 0 = 1 := by
    rw [ringRadius, zero_div, add_zero, cos_pi_div_three]
    norm_num
  rw [chart_eq_polar, h, Complex.ofReal_one, one_mul, zero_div, sub_zero]

/-- **M2, "the points `Z(α, d)` with `α` near `ψ_{n+1}` and `d` near `0` are the points near `y_n`"**, at the centre
of the box: `Z(ψ_{n+1}, 0) = y_n`. -/
theorem chart_hub (p : ℂ) (ψ : ℝ) (n : ℤ) : chart p (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) 0 = hub p ψ n := by
  rw [chart_zero, hub]
  congr 2
  push_cast
  ring

/-- The distance of a chart point from the centre is `|r(d)|`. -/
theorem dist_chart_centre (p : ℂ) (α d : ℝ) : dist (chart p α d) p = |ringRadius d| := by
  rw [chart_eq_polar, dist_eq_norm, add_sub_cancel_left, norm_mul, Plane.norm_e, mul_one, Complex.norm_real,
    Real.norm_eq_abs]

/-- **M2, "below 1 exactly when `d > 0`"**, the direction used: for `0 < d ≤ π/3` the chart point is in the open
unit disc about `p`. -/
theorem dist_chart_lt_one {d : ℝ} (hd : 0 < d) (hd' : d ≤ π / 3) (p : ℂ) (α : ℝ) : dist (chart p α d) p < 1 := by
  have hpi := Real.pi_pos
  have h1 : cos (π / 3 + d / 2) < 1 / 2 := by
    rw [← cos_pi_div_three]
    exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith) (by linarith) (by linarith)
  have h2 : 0 ≤ cos (π / 3 + d / 2) := Real.cos_nonneg_of_mem_Icc ⟨by linarith, by linarith⟩
  rw [dist_chart_centre, ringRadius, abs_lt]
  constructor <;> linarith

/-- The chart is continuous in `(α, d)`. -/
theorem continuous_chart (p : ℂ) : Continuous fun x : ℝ × ℝ => chart p x.1 x.2 := by
  unfold chart
  exact (continuous_const.add (Plane.continuous_e.comp continuous_fst)).add
    (Plane.continuous_e.comp ((continuous_fst.sub continuous_const).sub continuous_snd))

/-- **M2, "a non-parallel pair, on which the sum map is this chart"**: the chart is the release's `angularSum` at the
pair of directions `(α, α − 2π/3 − d)`. -/
theorem chart_eq_angularSum (p : ℂ) (α d : ℝ) :
    chart p α d = angularSum p 1 ((α : Angles), ((α - 2 * π / 3 - d : ℝ) : Angles)) := by
  simp only [chart, angularSum, direction_coe, Complex.ofReal_one, one_mul]

/-- Hubs are on the unit circle about `p`. -/
theorem dist_hub (p : ℂ) (ψ : ℝ) (n : ℤ) : dist (hub p ψ n) p = 1 := by
  rw [hub, dist_eq_norm, add_sub_cancel_left, Plane.norm_e]

/-- **M5, "`y_{k+3} = −y_k`"**: hubs three apart are antipodal on the ring. -/
theorem hub_add_three (p : ℂ) (ψ : ℝ) (n : ℤ) : hub p ψ (n + 3) - p = -(hub p ψ n - p) := by
  simp only [hub, add_sub_cancel_left]
  rw [← Plane.e_add_pi]
  congr 1
  push_cast
  ring

/-- **M6, "`e(ψ_1) = e(ψ_0) + e(ψ_2)`"**, at every index: the three axes. -/
theorem hub_axes (p : ℂ) (ψ : ℝ) (n : ℤ) : hub p ψ (n + 1) - p = (hub p ψ n - p) + (hub p ψ (n + 2) - p) := by
  simp only [hub, add_sub_cancel_left]
  have hpair : Plane.e (π / 3) + Plane.e (-(π / 3)) = 1 := by
    rw [Plane.e_eq, Plane.e_eq, cos_neg, sin_neg, cos_pi_div_three]
    push_cast
    ring
  have e0 : ψ + (n : ℝ) * (π / 3) = (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) + -(π / 3) := by
    push_cast
    ring
  have e2 : ψ + ((n + 2 : ℤ) : ℝ) * (π / 3) = (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) + π / 3 := by
    push_cast
    ring
  rw [e0, e2, Plane.e_add (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) (-(π / 3)),
    Plane.e_add (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) (π / 3), ← mul_add, add_comm (Plane.e (-(π / 3))), hpair, mul_one]

/-- Moving the base angle by `mπ/3` moves the index by `m`. -/
theorem hub_shift (p : ℂ) (ψ : ℝ) (m n : ℤ) : hub p (ψ + m * (π / 3)) n = hub p ψ (m + n) := by
  simp only [hub]
  congr 2
  push_cast
  ring

end HadwigerNelson.SixRing
