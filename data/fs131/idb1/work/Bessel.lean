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
  simp [J0, Real.circleAverage_def, circleMap]

theorem J1_eq_integral (x : ℝ) :
    J1 x = (2 * π)⁻¹ * ∫ θ in (0 : ℝ)..(2 * π), Real.sin θ * Real.sin (x * Real.sin θ) := by
  simp [J1, Real.circleAverage_def, circleMap]

theorem J0_zero : J0 0 = 1 := by
  simp [J0, Real.circleAverage_const]

theorem J1_zero : J1 0 = 0 := by
  simp [J1, Real.circleAverage_const]

theorem abs_J0_le_one (x : ℝ) : |J0 x| ≤ 1 := by
  have hc : Continuous fun z : ℂ => Real.cos (x * z.im) := by fun_prop
  have hint : CircleIntegrable (fun z : ℂ => Real.cos (x * z.im)) 0 1 :=
    (hc.continuousOn).circleIntegrable'
  calc |J0 x| ≤ Real.circleAverage (fun z : ℂ => |Real.cos (x * z.im)|) 0 1 :=
        Real.abs_circleAverage_le_circleAverage_abs
    _ ≤ Real.circleAverage (fun _ : ℂ => (1 : ℝ)) 0 1 := by
        apply Real.circleAverage_mono
        · exact (hc.abs.continuousOn).circleIntegrable'
        · exact (continuous_const.continuousOn).circleIntegrable'
        · intro z _; exact Real.abs_cos_le_one _
    _ = 1 := Real.circleAverage_const 1 0 1

theorem abs_J1_le_one (x : ℝ) : |J1 x| ≤ 1 := by
  have hc : Continuous fun z : ℂ => z.im * Real.sin (x * z.im) := by fun_prop
  calc |J1 x| ≤ Real.circleAverage (fun z : ℂ => |z.im * Real.sin (x * z.im)|) 0 1 :=
        Real.abs_circleAverage_le_circleAverage_abs
    _ ≤ Real.circleAverage (fun _ : ℂ => (1 : ℝ)) 0 1 := by
        apply Real.circleAverage_mono
        · exact (hc.abs.continuousOn).circleIntegrable'
        · exact (continuous_const.continuousOn).circleIntegrable'
        · intro z hz
          have hz1 : ‖z‖ = 1 := by simpa using hz
          have h1 : |z.im| ≤ 1 := hz1 ▸ Complex.abs_im_le_norm z
          rw [abs_mul]
          calc |z.im| * |Real.sin (x * z.im)| ≤ 1 * 1 :=
                mul_le_mul h1 (Real.abs_sin_le_one _) (abs_nonneg _) zero_le_one
            _ = 1 := one_mul 1
    _ = 1 := Real.circleAverage_const 1 0 1

/-- Differentiation under the integral over a period: `d/dx ∫ φ(θ) h(x sin θ) = ∫ φ(θ) sin θ h′(x sin θ)` for continuous
`φ` with `|φ| ≤ 1` and `h` with a continuous derivative bounded by `1`. -/
private theorem hasDerivAt_integral_sin {φ : ℝ → ℝ} (hφ : Continuous φ) (hφ1 : ∀ θ, |φ θ| ≤ 1)
    {h h' : ℝ → ℝ} (hh : ∀ y, HasDerivAt h (h' y) y) (hc' : Continuous h') (hb : ∀ y, |h' y| ≤ 1) (x : ℝ) :
    HasDerivAt (fun x => ∫ θ in (0 : ℝ)..(2 * π), φ θ * h (x * Real.sin θ))
      (∫ θ in (0 : ℝ)..(2 * π), φ θ * Real.sin θ * h' (x * Real.sin θ)) x := by
  have hc : Continuous h := continuous_iff_continuousAt.2 fun y => (hh y).continuousAt
  have hF : ∀ y : ℝ, Continuous fun θ => φ θ * h (y * Real.sin θ) := fun y =>
    hφ.mul (hc.comp (continuous_const.mul Real.continuous_sin))
  have hF' : ∀ y : ℝ, Continuous fun θ => φ θ * Real.sin θ * h' (y * Real.sin θ) := fun y =>
    (hφ.mul Real.continuous_sin).mul (hc'.comp (continuous_const.mul Real.continuous_sin))
  have key := intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le (μ := volume) (a := 0) (b := 2 * π)
    (F := fun y θ => φ θ * h (y * Real.sin θ)) (F' := fun y θ => φ θ * Real.sin θ * h' (y * Real.sin θ))
    (x₀ := x) (s := Set.univ) (bound := fun _ => 1) Filter.univ_mem
    (Filter.Eventually.of_forall fun y => (hF y).aestronglyMeasurable)
    ((hF x).intervalIntegrable _ _) (hF' x).aestronglyMeasurable
    (Filter.Eventually.of_forall fun θ _ y _ => by
      rw [Real.norm_eq_abs, abs_mul, abs_mul]
      calc |φ θ| * |Real.sin θ| * |h' (y * Real.sin θ)| ≤ 1 * 1 * 1 := by
            gcongr
            · exact hφ1 θ
            · exact Real.abs_sin_le_one θ
            · exact hb _
        _ = 1 := by norm_num)
    intervalIntegrable_const
    (Filter.Eventually.of_forall fun θ _ y _ => by
      have h1 : HasDerivAt (fun y => y * Real.sin θ) (Real.sin θ) y := by
        simpa using (hasDerivAt_id y).mul_const (Real.sin θ)
      exact (((hh (y * Real.sin θ)).comp y h1).const_mul (φ θ)).congr_deriv (by ring))
  exact key.2

/-- `J₀′ = −J₁` (differentiation under the integral sign). -/
theorem hasDerivAt_J0 (x : ℝ) : HasDerivAt J0 (-J1 x) x := by
  have h := (hasDerivAt_integral_sin (φ := fun _ => 1) continuous_const (by simp) (h := Real.cos)
    (h' := fun y => -Real.sin y) Real.hasDerivAt_cos Real.continuous_sin.neg (by simp [Real.abs_sin_le_one]) x).const_mul
    (2 * π)⁻¹
  have e1 : J0 = fun x => (2 * π)⁻¹ * ∫ θ in (0 : ℝ)..(2 * π), (fun _ => (1 : ℝ)) θ * Real.cos (x * Real.sin θ) := by
    funext y; rw [J0_eq_integral]; simp
  have e2 : -J1 x = (2 * π)⁻¹ * ∫ θ in (0 : ℝ)..(2 * π),
      (fun _ => (1 : ℝ)) θ * Real.sin θ * (fun y => -Real.sin y) (x * Real.sin θ) := by
    rw [J1_eq_integral, ← mul_neg, ← intervalIntegral.integral_neg]
    congr 1
    apply intervalIntegral.integral_congr
    intro θ _
    simp only [one_mul, mul_neg]
  rw [e1, e2]
  exact h

/-- `J₁′(x) = (2π)⁻¹ ∫ sin²θ cos(x sin θ)` at every `x` (differentiation under the integral sign). -/
private theorem hasDerivAt_J1_integral (x : ℝ) :
    HasDerivAt J1 ((2 * π)⁻¹ * ∫ θ in (0 : ℝ)..(2 * π), Real.sin θ * Real.sin θ * Real.cos (x * Real.sin θ)) x := by
  have h := (hasDerivAt_integral_sin (φ := Real.sin) Real.continuous_sin Real.abs_sin_le_one (h := Real.sin)
    (h' := Real.cos) Real.hasDerivAt_sin Real.continuous_cos Real.abs_cos_le_one x).const_mul (2 * π)⁻¹
  have e1 : J1 = fun x => (2 * π)⁻¹ * ∫ θ in (0 : ℝ)..(2 * π), Real.sin θ * Real.sin (x * Real.sin θ) := by
    funext y; rw [J1_eq_integral]
  rw [e1]
  exact h

/-- `J₁′ = J₀ − J₁/x` for `x ≠ 0` (differentiation under the integral sign, then one integration by parts:
`∫ cos²θ cos(x sin θ) = x⁻¹ ∫ sin θ sin(x sin θ)` over a period). -/
theorem hasDerivAt_J1 {x : ℝ} (hx : x ≠ 0) : HasDerivAt J1 (J0 x - J1 x / x) x := by
  convert hasDerivAt_J1_integral x using 1
  have hint : ∀ f : ℝ → ℝ, Continuous f → IntervalIntegrable f volume 0 (2 * π) := fun f hf => hf.intervalIntegrable _ _
  have hibp : ∫ θ in (0 : ℝ)..(2 * π), Real.cos θ * (Real.cos (x * Real.sin θ) * (x * Real.cos θ)) =
      ∫ θ in (0 : ℝ)..(2 * π), Real.sin θ * Real.sin (x * Real.sin θ) := by
    rw [intervalIntegral.integral_mul_deriv_eq_deriv_mul (u := Real.cos) (v := fun θ => Real.sin (x * Real.sin θ))
      (u' := fun θ => -Real.sin θ) (v' := fun θ => Real.cos (x * Real.sin θ) * (x * Real.cos θ))
      (fun θ _ => Real.hasDerivAt_cos θ)
      (fun θ _ => (Real.hasDerivAt_sin _).comp θ ((Real.hasDerivAt_sin θ).const_mul x))
      (hint _ Real.continuous_sin.neg)
      (hint _ ((Real.continuous_cos.comp (continuous_const.mul Real.continuous_sin)).mul
        (continuous_const.mul Real.continuous_cos)))]
    simp [intervalIntegral.integral_neg]
  have hA : ∫ θ in (0 : ℝ)..(2 * π), Real.cos θ * (Real.cos (x * Real.sin θ) * (x * Real.cos θ)) =
      x * ∫ θ in (0 : ℝ)..(2 * π), Real.cos θ * Real.cos θ * Real.cos (x * Real.sin θ) := by
    rw [← intervalIntegral.integral_const_mul]; congr 1; funext θ; ring
  have hC : ∫ θ in (0 : ℝ)..(2 * π), Real.sin θ * Real.sin θ * Real.cos (x * Real.sin θ) =
      (∫ θ in (0 : ℝ)..(2 * π), Real.cos (x * Real.sin θ)) -
        ∫ θ in (0 : ℝ)..(2 * π), Real.cos θ * Real.cos θ * Real.cos (x * Real.sin θ) := by
    rw [← intervalIntegral.integral_sub (hint (fun θ => Real.cos (x * Real.sin θ)) (by fun_prop))
      (hint (fun θ => Real.cos θ * Real.cos θ * Real.cos (x * Real.sin θ)) (by fun_prop))]
    congr 1; funext θ
    have := Real.sin_sq_add_cos_sq θ
    linear_combination Real.cos (x * Real.sin θ) * this
  rw [J0_eq_integral, J1_eq_integral, hC, ← hibp, hA]
  field_simp

theorem continuous_J0 : Continuous J0 := by
  exact continuous_iff_continuousAt.2 fun x => (hasDerivAt_J0 x).continuousAt

theorem continuous_J1 : Continuous J1 := by
  exact continuous_iff_continuousAt.2 fun x => (hasDerivAt_J1_integral x).continuousAt

/-- **The energy is antitone**: `‖J‖² = J₀² + J₁²` has derivative `−2J₁²/x ≤ 0` on `(0, ∞)` and `J` is continuous, so
`‖J‖` decreases on `[0, ∞)`. The tail of the covering reads `|J₀(t d)| ≤ ‖J(T d)‖` for `t ≥ T`. -/
theorem antitoneOn_norm_Jc : AntitoneOn (fun x => ‖Jc x‖) (Ici 0) := by
  have hd : ∀ x : ℝ, 0 < x → HasDerivAt (fun x => J0 x ^ 2 + J1 x ^ 2) (-(2 * J1 x ^ 2 / x)) x := by
    intro x hx
    refine (((hasDerivAt_J0 x).pow 2).add ((hasDerivAt_J1 hx.ne').pow 2)).congr_deriv ?_
    norm_num
    field_simp
    ring
  have hsq : AntitoneOn (fun x => J0 x ^ 2 + J1 x ^ 2) (Ici 0) := by
    apply antitoneOn_of_deriv_nonpos (convex_Ici 0)
    · exact ((continuous_J0.pow 2).add (continuous_J1.pow 2)).continuousOn
    · intro x hx
      rw [interior_Ici] at hx
      exact (hd x hx).differentiableAt.differentiableWithinAt
    · intro x hx
      rw [interior_Ici] at hx
      rw [(hd x hx).deriv]
      have : 0 ≤ 2 * J1 x ^ 2 / x := div_nonneg (by positivity) hx.le
      linarith
  have hn : ∀ z, ‖Jc z‖ ^ 2 = J0 z ^ 2 + J1 z ^ 2 := fun z => by
    rw [Complex.sq_norm, Jc, Complex.normSq_mk]; ring
  intro x hx y hy hxy
  have := hsq hx hy hxy
  simp only at this ⊢
  rw [← hn, ← hn] at this
  exact (pow_le_pow_iff_left₀ (norm_nonneg _) (norm_nonneg _) two_ne_zero).1 this

/-- `J₀` is `1`-Lipschitz (`|J₀′| = |J₁| ≤ 1`). -/
theorem abs_J0_sub_le (x y : ℝ) : |J0 x - J0 y| ≤ |x - y| := by
  have hL : LipschitzWith 1 J0 := by
    apply lipschitzWith_of_nnnorm_deriv_le (fun x => (hasDerivAt_J0 x).differentiableAt)
    intro x
    rw [(hasDerivAt_J0 x).deriv, ← NNReal.coe_le_coe, coe_nnnorm, norm_neg, Real.norm_eq_abs]
    simpa using abs_J1_le_one x
  have := hL.dist_le_mul x y
  simpa [Real.dist_eq] using this

/-- **The circle average**: `(2π)⁻¹ ∫₀^{2π} exp(i⟨ξ, r e^{iθ}⟩) dθ = J₀(r ‖ξ‖)` — a rotation of `θ` (periodicity) brings
`⟨ξ, r e^{iθ}⟩` to `r‖ξ‖ sin θ`, and the sine part integrates to `0`. -/
theorem circleAverage_exp_inner (ξ : ℂ) (r : ℝ) :
    Real.circleAverage (fun z : ℂ => Complex.exp (Complex.I * (inner ℝ ξ z : ℝ))) 0 r = (J0 (r * ‖ξ‖) : ℂ) := by
  set s := r * ‖ξ‖ with hs
  set β := Complex.arg ξ - π / 2 with hβ
  have hpt : ∀ θ : ℝ, inner ℝ ξ (circleMap 0 r θ) = s * Real.sin (θ - β) := by
    intro θ
    have h1 : inner ℝ ξ (circleMap 0 r θ) = r * Real.cos θ * ξ.re + r * Real.sin θ * ξ.im := by
      simp [Complex.inner, circleMap, Complex.mul_re, Complex.exp_ofReal_mul_I_re, Complex.exp_ofReal_mul_I_im]
    rw [h1, show θ - β = (θ - Complex.arg ξ) + π / 2 by rw [hβ]; ring, Real.sin_add_pi_div_two, Real.cos_sub,
      ← Complex.norm_mul_cos_arg ξ, ← Complex.norm_mul_sin_arg ξ, hs]
    ring
  have hcont : Continuous fun θ : ℝ => Complex.exp (Complex.I * ((s * Real.sin θ : ℝ) : ℂ)) := by fun_prop
  have hint : (∫ θ in (0 : ℝ)..(2 * π), Complex.exp (Complex.I * ((inner ℝ ξ (circleMap 0 r θ) : ℝ) : ℂ))) =
      ∫ θ in (0 : ℝ)..(2 * π), Complex.exp (Complex.I * ((s * Real.sin (θ - β) : ℝ) : ℂ)) := by
    congr 1; funext θ; rw [hpt]
  have hper : Function.Periodic (fun θ : ℝ => Complex.exp (Complex.I * ((s * Real.sin θ : ℝ) : ℂ))) (2 * π) := by
    intro θ; simp only [Real.sin_add_two_pi]
  have hshift : ∫ θ in (0 : ℝ)..(2 * π), Complex.exp (Complex.I * ((s * Real.sin (θ - β) : ℝ) : ℂ)) =
      ∫ θ in (0 : ℝ)..(2 * π), Complex.exp (Complex.I * ((s * Real.sin θ : ℝ) : ℂ)) := by
    rw [intervalIntegral.integral_comp_sub_right (fun θ => Complex.exp (Complex.I * ((s * Real.sin θ : ℝ) : ℂ)))]
    have := hper.intervalIntegral_add_eq (-β) 0
    rw [zero_add] at this
    rw [show (0 : ℝ) - β = -β by ring, show 2 * π - β = -β + 2 * π by ring, this]
  have hsplit : ∀ θ : ℝ, Complex.exp (Complex.I * ((s * Real.sin θ : ℝ) : ℂ)) =
      ((Real.cos (s * Real.sin θ) : ℝ) : ℂ) + ((Real.sin (s * Real.sin θ) : ℝ) : ℂ) * Complex.I := by
    intro θ
    rw [mul_comm, Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin]
  have hsin0 : ∫ θ in (0 : ℝ)..(2 * π), Real.sin (s * Real.sin θ) = 0 := by
    have h := intervalIntegral.integral_comp_sub_left (fun θ => Real.sin (s * Real.sin θ)) (a := 0) (b := 2 * π)
      (2 * π)
    have e : ∀ θ, Real.sin (s * Real.sin (2 * π - θ)) = -Real.sin (s * Real.sin θ) := by
      intro θ; rw [Real.sin_two_pi_sub, mul_neg, Real.sin_neg]
    simp only [e, intervalIntegral.integral_neg, sub_self, sub_zero] at h
    linarith
  rw [Real.circleAverage_def, hint, hshift]
  simp_rw [hsplit]
  rw [intervalIntegral.integral_add ((by fun_prop : Continuous fun θ : ℝ =>
      ((Real.cos (s * Real.sin θ) : ℝ) : ℂ)).intervalIntegrable _ _)
    ((by fun_prop : Continuous fun θ : ℝ => ((Real.sin (s * Real.sin θ) : ℝ) : ℂ) * Complex.I).intervalIntegrable _ _),
    intervalIntegral.integral_mul_const, intervalIntegral.integral_ofReal, intervalIntegral.integral_ofReal, hsin0,
    J0_eq_integral, Complex.real_smul]
  push_cast
  ring

/-- A model value: `J₀(0) = 1` and `J₁(0) = 0`, the chain's initial state. -/
example : J0 0 = 1 ∧ J1 0 = 0 := ⟨J0_zero, J1_zero⟩

end HadwigerNelson.DensityBound
