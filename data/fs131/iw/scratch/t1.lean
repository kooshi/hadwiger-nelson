import Proofs.HadwigerNelson.Plane.Woodall.Basic
import Proofs.HadwigerNelson.Plane.SVMap
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

theorem e_mul_conj_e (θ : ℝ) : e θ * starRingEnd ℂ (e θ) = 1 := by
  rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e]; simp

/-- Polar form of `z` about `u`, measured from the direction `θ₀`. -/
theorem eq_add_norm_mul_e (u z : ℂ) (θ₀ : ℝ) :
    z = u + (‖z - u‖ : ℂ) * e (θ₀ + Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))) := by
  set w := (z - u) * starRingEnd ℂ (e θ₀) with hw
  have h1 : ‖w‖ = ‖z - u‖ := by
    rw [hw, norm_mul, Complex.norm_conj, norm_e, mul_one]
  have h2 : (‖w‖ : ℂ) * e (Complex.arg w) = w := by
    have := Complex.norm_mul_exp_arg_mul_I w
    rw [e]; exact this
  have h3 : z - u = w * e θ₀ := by
    rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e θ₀)), e_mul_conj_e, mul_one]
  have h4 : (‖w‖ : ℂ) * (e θ₀ * e (Complex.arg w)) = w * e θ₀ := by
    calc (‖w‖ : ℂ) * (e θ₀ * e (Complex.arg w)) = ((‖w‖ : ℂ) * e (Complex.arg w)) * e θ₀ := by ring
      _ = w * e θ₀ := by rw [h2]
  rw [e_add, ← h1, h4, ← h3]; ring

/-- Near `u + ρ₀ e θ₀` (`ρ₀ > 0`), the angle of `z` from `θ₀` is small. -/
theorem eventually_abs_arg_lt (u : ℂ) (θ₀ : ℝ) {ρ₀ δ : ℝ} (hρ : 0 < ρ₀) (hδ : 0 < δ) :
    ∀ᶠ z in 𝓝 (u + (ρ₀ : ℂ) * e θ₀), |Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))| < δ := by
  have hw : ((u + (ρ₀ : ℂ) * e θ₀) - u) * starRingEnd ℂ (e θ₀) = (ρ₀ : ℂ) := by
    rw [add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]
  have hcont : ContinuousAt (fun z : ℂ => Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))) (u + (ρ₀ : ℂ) * e θ₀) := by
    refine ContinuousAt.comp (g := Complex.arg) ?_ (by fun_prop)
    rw [hw]
    exact Complex.continuousAt_arg (Or.inl (by exact_mod_cast hρ))
  have h0 : Complex.arg ((((u + (ρ₀ : ℂ) * e θ₀)) - u) * starRingEnd ℂ (e θ₀)) = 0 := by
    rw [hw]; exact Complex.arg_ofReal_of_nonneg hρ.le
  have habs : ContinuousAt (fun z : ℂ => |Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))|) (u + (ρ₀ : ℂ) * e θ₀) :=
    continuous_abs.continuousAt.comp hcont
  have hlt : |Complex.arg ((((u + (ρ₀ : ℂ) * e θ₀)) - u) * starRingEnd ℂ (e θ₀))| < δ := by
    rw [h0]; simpa using hδ
  exact habs.eventually_lt continuousAt_const hlt

end HadwigerNelson.Plane
