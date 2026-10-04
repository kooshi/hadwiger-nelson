import Proofs.HadwigerNelson.Plane.Basic

/-!
# Chords of unit circles, two unit circles, and the corner of two lines (FS-131 wave 1)

Rows: **FS116-V4-CHORD**, **FS129-SR1-TWOCIRC**, **FS121-D1-XCORNER**. Plan: `plans/FS131-kernel-plan.md` § 6.
Pure plane trigonometry: no colouring, no map. The angle convention is `Plane/Basic`'s (`e θ = exp(θ i)`,
counter-clockwise).
-/

namespace HadwigerNelson.Plane

open Complex Real Set

/-- The chord of a unit circle as a vector: `r(β) − r(α) = 2 sin((β − α)/2) · e((α + β)/2 + π/2)`. -/
theorem ringPt_sub_ringPt (p : ℂ) (α β : ℝ) :
    ringPt p β - ringPt p α = ((2 * Real.sin ((β - α) / 2) : ℝ) : ℂ) * e ((α + β) / 2 + π / 2) := by
  sorry

/-- **FS116-V4-CHORD**, distance: two points of a unit circle at angular separation `δ = |α − β| ∈ [0, π]` are at
distance `2 sin(δ/2)`. -/
theorem dist_ringPt_ringPt (p : ℂ) {α β : ℝ} (hδ : |α - β| ≤ π) :
    dist (ringPt p α) (ringPt p β) = 2 * Real.sin (|α - β| / 2) := by
  sorry

/-- **FS116-V4-CHORD**, the three regimes: at separation `δ ∈ [0, π]` the distance is `1` exactly at `δ = π/3`, below
`1` for `δ < π/3`, above `1` for `π/3 < δ`. -/
theorem dist_ringPt_ringPt_cmp_one (p : ℂ) {α β : ℝ} (hδ : |α - β| ≤ π) :
    (dist (ringPt p α) (ringPt p β) = 1 ↔ |α - β| = π / 3) ∧
    (dist (ringPt p α) (ringPt p β) < 1 ↔ |α - β| < π / 3) ∧
    (1 < dist (ringPt p α) (ringPt p β) ↔ π / 3 < |α - β|) := by
  sorry

/-- **FS129-SR1-TWOCIRC**: let `|y₀ − y₁| = 1` and let `p = y₀ + (y₁ − y₀) e(σπ/3)` (`σ = ±1`: `p` is the third vertex
of a unit equilateral triangle on `y₀y₁`, and `σ` is the turning sense "toward `p`"); put
`a(s) = y₀ + (y₁ − y₀) e(σ s)` (from `y₁`, turning `s` about `y₀` toward `p`) and `b(t) = y₁ + (y₀ − y₁) e(−σ t)`
(from `y₀`, turning `t` about `y₁` toward `p`). Then
`|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) = 2(1 − cos s)(1 − cos t) − 2 sin s sin t`. -/
theorem twoCirc_identity {y₀ y₁ : ℂ} (h01 : dist y₀ y₁ = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (s t : ℝ) :
    ‖(y₀ + (y₁ - y₀) * e (σ * s)) - (y₁ + (y₀ - y₁) * e (-(σ * t)))‖ ^ 2 - 1 =
      -8 * Real.sin (s / 2) * Real.sin (t / 2) * Real.cos ((s + t) / 2) ∧
    ‖(y₀ + (y₁ - y₀) * e (σ * s)) - (y₁ + (y₀ - y₁) * e (-(σ * t)))‖ ^ 2 - 1 =
      2 * (1 - Real.cos s) * (1 - Real.cos t) - 2 * Real.sin s * Real.sin t := by
  sorry

/-- **FS129-SR1-TWOCIRC**, the regimes: for `0 < s, t < π`, `|a(s) − b(t)|` is below `1` when `s + t < π`, equal to `1`
when `s + t = π`, above `1` when `s + t > π`. -/
theorem twoCirc_cmp_one {y₀ y₁ : ℂ} (h01 : dist y₀ y₁ = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {s t : ℝ}
    (hs : 0 < s) (hs' : s < π) (ht : 0 < t) (ht' : t < π) :
    (s + t < π → dist (y₀ + (y₁ - y₀) * e (σ * s)) (y₁ + (y₀ - y₁) * e (-(σ * t))) < 1) ∧
    (s + t = π → dist (y₀ + (y₁ - y₀) * e (σ * s)) (y₁ + (y₀ - y₁) * e (-(σ * t))) = 1) ∧
    (π < s + t → 1 < dist (y₀ + (y₁ - y₀) * e (σ * s)) (y₁ + (y₀ - y₁) * e (-(σ * t)))) := by
  sorry

/-- The row's hypothesis read back: every `p` with `|p − y₀| = |p − y₁| = 1 = |y₀ − y₁|` is `y₀ + (y₁ − y₀) e(σπ/3)`
for one of `σ = ±1`, so `twoCirc_identity` covers every configuration the row names. -/
theorem exists_sign_of_equilateral {y₀ y₁ p : ℂ} (h01 : dist y₀ y₁ = 1) (hp0 : dist p y₀ = 1)
    (hp1 : dist p y₁ = 1) : ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ p = y₀ + (y₁ - y₀) * e (σ * (π / 3)) := by
  sorry

/-- **FS121-D1-XCORNER**: at a convex corner `z` of angle `θ ∈ (0, π)` with straight edges along `e(φ)` and
`e(φ + θ)`, the inner unit parallels of the two edges (`z + s e(φ) + e(φ + π/2)` and `z + t e(φ + θ) + e(φ + θ − π/2)`)
meet exactly when `s = t = cot(θ/2)`, at the point at distance `1/sin(θ/2)` from `z` on the bisector. -/
theorem xcorner {θ : ℝ} (hθ : 0 < θ) (hθ' : θ < π) (z : ℂ) (φ : ℝ) (s t : ℝ) :
    (z + s * e φ + e (φ + π / 2) = z + t * e (φ + θ) + e (φ + θ - π / 2) ↔
      s = Real.cot (θ / 2) ∧ t = Real.cot (θ / 2)) ∧
    z + (Real.cot (θ / 2) : ℂ) * e φ + e (φ + π / 2) = z + ((1 / Real.sin (θ / 2) : ℝ) : ℂ) * e (φ + θ / 2) := by
  sorry

end HadwigerNelson.Plane
