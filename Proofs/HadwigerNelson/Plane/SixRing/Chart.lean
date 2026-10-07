import Proofs.HadwigerNelson.Plane.SixRing.Basic

/-!
# The chart about the ring and the hubs: plane geometry (FS-132, C132-M-ORBIT steps M2, M5, M6) — SKELETON

No colouring and no measure. Every statement is an identity or an inequality of plane trigonometry about
`chart p α d = p + e(α) + e(α − 2π/3 − d)` and `hub p ψ n = p + e(ψ + nπ/3)`; each is a leaf of a few lines.
`plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.
-/

open scoped RealInnerProductSpace

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

/-- **M2, the chart in polar form** (the derivation's "`|Z| = 2 cos(π/3 + d/2)` and `arg Z = α − π/3 − d/2`", as one
identity valid for all real `α`, `d`): `Z(α, d) = p + r(d) e(α − π/3 − d/2)`. Sum-to-product. -/
theorem chart_eq_polar (p : ℂ) (α d : ℝ) :
    chart p α d = p + ((ringRadius d : ℝ) : ℂ) * Plane.e (α - π / 3 - d / 2) := by
  sorry

/-- At `d = 0` the chart is on the ring: `Z(α, 0) = p + e(α − π/3)`. -/
theorem chart_zero (p : ℂ) (α : ℝ) : chart p α 0 = p + Plane.e (α - π / 3) := by
  sorry

/-- **M2, "the points `Z(α, d)` with `α` near `ψ_{n+1}` and `d` near `0` are the points near `y_n`"**, at the centre
of the box: `Z(ψ_{n+1}, 0) = y_n`. -/
theorem chart_hub (p : ℂ) (ψ : ℝ) (n : ℤ) : chart p (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) 0 = hub p ψ n := by
  sorry

/-- The distance of a chart point from the centre is `|r(d)|`. -/
theorem dist_chart_centre (p : ℂ) (α d : ℝ) : dist (chart p α d) p = |ringRadius d| := by
  sorry

/-- **M2, "below 1 exactly when `d > 0`"**, the direction used: for `0 < d ≤ π/3` the chart point is in the open
unit disc about `p`. -/
theorem dist_chart_lt_one {d : ℝ} (hd : 0 < d) (hd' : d ≤ π / 3) (p : ℂ) (α : ℝ) : dist (chart p α d) p < 1 := by
  sorry

/-- The chart is continuous in `(α, d)`. -/
theorem continuous_chart (p : ℂ) : Continuous fun x : ℝ × ℝ => chart p x.1 x.2 := by
  sorry

/-- **M2, "a non-parallel pair, on which the sum map is this chart"**: the chart is the release's `angularSum` at the
pair of directions `(α, α − 2π/3 − d)`. -/
theorem chart_eq_angularSum (p : ℂ) (α d : ℝ) :
    chart p α d = angularSum p 1 ((α : Angles), ((α - 2 * π / 3 - d : ℝ) : Angles)) := by
  sorry

/-- Hubs are on the unit circle about `p`. -/
theorem dist_hub (p : ℂ) (ψ : ℝ) (n : ℤ) : dist (hub p ψ n) p = 1 := by
  sorry

/-- **M5, "`y_{k+3} = −y_k`"**: hubs three apart are antipodal on the ring. -/
theorem hub_add_three (p : ℂ) (ψ : ℝ) (n : ℤ) : hub p ψ (n + 3) - p = -(hub p ψ n - p) := by
  sorry

/-- **M6, "`e(ψ_1) = e(ψ_0) + e(ψ_2)`"**, at every index: the three axes. -/
theorem hub_axes (p : ℂ) (ψ : ℝ) (n : ℤ) : hub p ψ (n + 1) - p = (hub p ψ n - p) + (hub p ψ (n + 2) - p) := by
  sorry

/-- Moving the base angle by `mπ/3` moves the index by `m`. -/
theorem hub_shift (p : ℂ) (ψ : ℝ) (m n : ℤ) : hub p (ψ + m * (π / 3)) n = hub p ψ (m + n) := by
  sorry

end HadwigerNelson.SixRing
