import Proofs.HadwigerNelson.Plane.DensityBound.Autocorr

/-! FS131-KDB1 first leaves, written for pricing (scratch; the module's leaves stay `sorry`). -/

namespace HadwigerNelson.DensityBound
open Real MeasureTheory Set Metric

/-- KMOR Lemma 3.2 (1), finite-window form. -/
theorem autocorr_eq_zero_of_norm_eq_one' {E : Set ℂ} (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) {z : ℂ}
    (hz : ‖z‖ = 1) : autocorr E z = 0 := by
  have hempty : E ∩ (fun y => y + z) ⁻¹' E = ∅ := by
    ext y
    simp only [mem_inter_iff, mem_preimage, mem_empty_iff_false, iff_false, not_and]
    intro hy hyz
    exact h1 _ hyz _ hy (by rw [dist_eq_norm, add_sub_cancel_left, hz])
  simp [autocorr, hempty]

/-- `|J₀| ≤ 1`, through Mathlib's circle-average API. -/
theorem abs_J0_le_one' (x : ℝ) : |J0 x| ≤ 1 := by
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

/-- `J₀(0) = 1`. -/
theorem J0_zero' : J0 0 = 1 := by
  simp [J0, Real.circleAverage_const]

end HadwigerNelson.DensityBound

#print axioms HadwigerNelson.DensityBound.autocorr_eq_zero_of_norm_eq_one'
#print axioms HadwigerNelson.DensityBound.abs_J0_le_one'
#print axioms HadwigerNelson.DensityBound.J0_zero'
