import Proofs.HadwigerNelson.Plane.DensityBound.Bessel
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
import Mathlib.MeasureTheory.Integral.PeakFunction
import Mathlib.MeasureTheory.Measure.ContinuousPreimage
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex

/-!
# The autocorrelation of a bounded planar set is positive definite against `J₀` (FS-131, FS131-KDB1; skeleton)

`autocorr E z = vol(E ∩ (E − z))`. For a bounded measurable `E ⊆ ℂ`, radii `r_k` and reals `c_k`,

  if `Σ c_k J₀(t r_k) ≥ 0` for every `t ≥ 0`, then `Σ c_k F̊(r_k) ≥ 0`,

where `F̊` is the circle average of `F = autocorr E`. This is the Fourier side of `[AmbrusEtAl2023]` Proposition 1 (pp. 13–14)
without the paper's periodic reduction and torus (§§ 2, 5): the Gaussian `Γ_ε` regularizes, its Fourier integral
(`GaussianFourier.integral_cexp_neg_mul_sq_norm_add`) and Fubini turn the regularized sum into
`(4π²)⁻¹ ∫ e^{−ε|ξ|²/4} |1̂_E(ξ)|² Σ c_k J₀(r_k|ξ|) dξ ≥ 0`, and `ε → 0` is a peak-function limit at points where `F` is
continuous — everywhere (`continuous_autocorr`). KMOR's Lemma 3.2 (1) is `autocorr_eq_zero_of_norm_eq_one` here.
Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real MeasureTheory Set Metric
open scoped ENNReal

/-- **The autocorrelation** `F(z) = vol(E ∩ (E − z))`, as a real number (finite for the bounded sets it is used on). -/
noncomputable def autocorr (E : Set ℂ) (z : ℂ) : ℝ := (volume (E ∩ (fun y => y + z) ⁻¹' E)).toReal

/-- **`[KMOR2016]` Lemma 3.2 (1), finite-window form**: a 1-avoiding set meets no translate of itself by a unit vector. -/
theorem autocorr_eq_zero_of_norm_eq_one {E : Set ℂ} (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) {z : ℂ}
    (hz : ‖z‖ = 1) : autocorr E z = 0 := by
  sorry

/-- The circle average of the autocorrelation at radius `1` vanishes. -/
theorem circleAvg_autocorr_one {E : Set ℂ} (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) :
    Real.circleAverage (autocorr E) 0 1 = 0 := by
  sorry

/-- At radius `0`: `F̊(0) = F(0) = vol E`. -/
theorem circleAvg_autocorr_zero (E : Set ℂ) : Real.circleAverage (autocorr E) 0 0 = (volume E).toReal := by
  sorry

/-- `F` is continuous for a measurable set of finite measure (translation is continuous in measure:
`tendsto_measure_symmDiff_preimage_nhds_zero`). -/
theorem continuous_autocorr {E : Set ℂ} (hE : MeasurableSet E) (hfin : volume E ≠ ∞) :
    Continuous (autocorr E) := by
  sorry

/-- **Positive definiteness against `J₀`** (the Fourier side, Gaussian-regularized). -/
theorem sum_circleAvg_autocorr_nonneg {E : Set ℂ} (hE : MeasurableSet E) (hb : Bornology.IsBounded E)
    {ι : Type*} (s : Finset ι) (c r : ι → ℝ) (hW : ∀ t : ℝ, 0 ≤ t → 0 ≤ ∑ k ∈ s, c k * J0 (t * r k)) :
    0 ≤ ∑ k ∈ s, c k * Real.circleAverage (autocorr E) 0 (r k) := by
  sorry

/-- **A model** of `sum_circleAvg_autocorr_nonneg`'s hypotheses with every clause exercised: `E` the open disc of radius
`1/2` (measurable, bounded, nonempty), and the single term `c = 1` at `r = 0`, where `Σ c J₀(t·0) = J₀ 0 = 1 ≥ 0`. -/
example : MeasurableSet (ball (0 : ℂ) (1 / 2)) ∧ Bornology.IsBounded (ball (0 : ℂ) (1 / 2)) ∧
    ∀ t : ℝ, 0 ≤ t → 0 ≤ ∑ k ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) k * J0 (t * (fun _ => (0 : ℝ)) k) := by
  refine ⟨measurableSet_ball, isBounded_ball, fun t _ => ?_⟩
  simp [J0_zero]

end HadwigerNelson.DensityBound
