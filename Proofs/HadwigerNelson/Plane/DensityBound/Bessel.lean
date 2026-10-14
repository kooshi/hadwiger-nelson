import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.Calculus.ParametricIntervalIntegral
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Periodic
import Mathlib.MeasureTheory.Integral.CircleAverage

/-!
# `J₀` and `J₁` from their integrals; the Bessel system, its energy, the circle average (FS-131, FS131-KDB1; skeleton)

Mathlib at the pin has no Bessel function. This module defines the two this proof needs by their integrals over a full
period,

`J₀(x) = (2π)⁻¹ ∫₀^{2π} cos(x sin θ) dθ`, `J₁(x) = (2π)⁻¹ ∫₀^{2π} sin θ · sin(x sin θ) dθ`,

and proves exactly what the density bound reads: `J(0) = (1, 0)`; `|J₀|, |J₁| ≤ 1`; the Bessel system `J₀′ = −J₁`,
`J₁′ = J₀ − J₁/x` (`x ≠ 0`); the norm of `J = J₀ + iJ₁` antitone on `[0, ∞)` (`‖J‖²` has derivative `−2J₁²/x`); `J₀` is
`1`-Lipschitz; and the circle average `(2π)⁻¹∫₀^{2π} exp(i⟨ξ, r e^{iθ}⟩) dθ = J₀(r‖ξ‖)`, the only place the Fourier side meets
`J₀`. The full period makes every integration by parts boundary-free (periodicity), and it is the period of the circle
average. Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real MeasureTheory intervalIntegral Set

/-- **`J₀`**, the Bessel function of the first kind of order `0`, as a circle average over the unit circle:
`(2π)⁻¹ ∫₀^{2π} cos(x sin θ) dθ` (`J0_eq_integral`). Defined through Mathlib's `Real.circleAverage` so that its API
(constants, monotonicity, `|·|`, sums, rotations) applies. -/
noncomputable def J0 (x : ℝ) : ℝ := Real.circleAverage (fun z : ℂ => Real.cos (x * z.im)) 0 1

/-- **`J₁`**: `(2π)⁻¹ ∫₀^{2π} sin θ · sin(x sin θ) dθ` (`J1_eq_integral`; `cos θ · cos(x sin θ)` integrates to `0` over a
period, so this is the classical `(2π)⁻¹ ∫ cos(θ − x sin θ)`). -/
noncomputable def J1 (x : ℝ) : ℝ := Real.circleAverage (fun z : ℂ => z.im * Real.sin (x * z.im)) 0 1

/-- **The pair** `J = J₀ + i J₁`, the state of the Bessel system `J′ = iJ − i J₁/x`. -/
noncomputable def Jc (x : ℝ) : ℂ := ⟨J0 x, J1 x⟩

theorem J0_eq_integral (x : ℝ) : J0 x = (2 * π)⁻¹ * ∫ θ in (0 : ℝ)..(2 * π), Real.cos (x * Real.sin θ) := by
  sorry

theorem J1_eq_integral (x : ℝ) :
    J1 x = (2 * π)⁻¹ * ∫ θ in (0 : ℝ)..(2 * π), Real.sin θ * Real.sin (x * Real.sin θ) := by
  sorry

theorem J0_zero : J0 0 = 1 := by
  sorry

theorem J1_zero : J1 0 = 0 := by
  sorry

theorem abs_J0_le_one (x : ℝ) : |J0 x| ≤ 1 := by
  sorry

theorem abs_J1_le_one (x : ℝ) : |J1 x| ≤ 1 := by
  sorry

/-- `J₀′ = −J₁` (differentiation under the integral sign). -/
theorem hasDerivAt_J0 (x : ℝ) : HasDerivAt J0 (-J1 x) x := by
  sorry

/-- `J₁′ = J₀ − J₁/x` for `x ≠ 0` (differentiation under the integral sign, then one integration by parts:
`∫ cos²θ cos(x sin θ) = x⁻¹ ∫ sin θ sin(x sin θ)` over a period). -/
theorem hasDerivAt_J1 {x : ℝ} (hx : x ≠ 0) : HasDerivAt J1 (J0 x - J1 x / x) x := by
  sorry

theorem continuous_J0 : Continuous J0 := by
  sorry

theorem continuous_J1 : Continuous J1 := by
  sorry

/-- **The energy is antitone**: `‖J‖² = J₀² + J₁²` has derivative `−2J₁²/x ≤ 0` on `(0, ∞)` and `J` is continuous, so
`‖J‖` decreases on `[0, ∞)`. The tail of the covering reads `|J₀(t d)| ≤ ‖J(T d)‖` for `t ≥ T`. -/
theorem antitoneOn_norm_Jc : AntitoneOn (fun x => ‖Jc x‖) (Ici 0) := by
  sorry

/-- `J₀` is `1`-Lipschitz (`|J₀′| = |J₁| ≤ 1`). -/
theorem abs_J0_sub_le (x y : ℝ) : |J0 x - J0 y| ≤ |x - y| := by
  sorry

/-- **The circle average**: `(2π)⁻¹ ∫₀^{2π} exp(i⟨ξ, r e^{iθ}⟩) dθ = J₀(r ‖ξ‖)` — a rotation of `θ` (periodicity) brings
`⟨ξ, r e^{iθ}⟩` to `r‖ξ‖ sin θ`, and the sine part integrates to `0`. -/
theorem circleAverage_exp_inner (ξ : ℂ) (r : ℝ) :
    Real.circleAverage (fun z : ℂ => Complex.exp (Complex.I * (inner ℝ ξ z : ℝ))) 0 r = (J0 (r * ‖ξ‖) : ℂ) := by
  sorry

/-- A model value: `J₀(0) = 1` and `J₁(0) = 0`, the chain's initial state. -/
example : J0 0 = 1 ∧ J1 0 = 0 := ⟨J0_zero, J1_zero⟩

end HadwigerNelson.DensityBound
