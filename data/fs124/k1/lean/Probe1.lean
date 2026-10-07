import Proofs.HadwigerNelson.Plane.WeakColouringOn
-- FS124-K1 probe (iteration only): the right-translation leaf and the edge lemma, to validate the model.
namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Metric

theorem probe_rigidMotion_motionMul (q h : ℂ × ℝ) (z : ℂ) :
    rigidMotion (motionMul q h) z = rigidMotion q (rigidMotion h z) := by
  simp only [rigidMotion, motionMul, e_add]; ring

theorem probe_measurePreserving_motionMul_right (h : ℂ × ℝ) :
    MeasurePreserving (fun q : ℂ × ℝ => motionMul q h) volume volume := by
  -- skew product over the angle, conjugated by the swap
  have hsk : MeasurePreserving (fun p : ℝ × ℂ => (p.1 + h.2, p.2 + e p.1 * h.1))
      ((volume : Measure ℝ).prod (volume : Measure ℂ)) ((volume : Measure ℝ).prod (volume : Measure ℂ)) := by
    refine MeasurePreserving.skew_product (g := fun (θ : ℝ) (x : ℂ) => x + e θ * h.1)
      (measurePreserving_add_right volume h.2) ?_ (Filter.Eventually.of_forall fun θ => ?_)
    · exact (measurable_snd.add ((continuous_e.measurable.comp measurable_fst).mul measurable_const))
    · exact (measurePreserving_add_right volume (e θ * h.1)).map_eq
  have h1 := (Measure.measurePreserving_swap (μ := (volume : Measure ℝ)) (ν := (volume : Measure ℂ))).comp
    (hsk.comp (Measure.measurePreserving_swap (μ := (volume : Measure ℂ)) (ν := (volume : Measure ℝ))))
  have hfun : (fun q : ℂ × ℝ => motionMul q h) =
      Prod.swap ∘ (fun p : ℝ × ℂ => (p.1 + h.2, p.2 + e p.1 * h.1)) ∘ Prod.swap := by
    funext q; simp [motionMul, rigidMotion]
  rw [hfun]
  exact h1

theorem probe_mem_monoPairSet_iff {α : Type*} {U : Set ℂ} {c : ℂ → α} {q : ℂ × ℝ} :
    q ∈ monoPairSet U c ↔
      rigidMotion q 0 ∈ U ∧ rigidMotion q 1 ∈ U ∧ c (rigidMotion q 0) = c (rigidMotion q 1) := by
  simp [monoPairSet, rigidMotion]

theorem probe_ae_rigidMotion_edge {α : Type*} {U : Set ℂ} {c : ℂ → α}
    (hc : (volume : Measure (ℂ × ℝ)) (monoPairSet U c) = 0) (h : ℂ × ℝ) :
    ∀ᵐ q : ℂ × ℝ, rigidMotion q (rigidMotion h 0) ∈ U → rigidMotion q (rigidMotion h 1) ∈ U →
      c (rigidMotion q (rigidMotion h 0)) ≠ c (rigidMotion q (rigidMotion h 1)) := by
  have hnull := (probe_measurePreserving_motionMul_right h).quasiMeasurePreserving.preimage_null hc
  rw [ae_iff]
  refine measure_mono_null (fun q hq => ?_) hnull
  simp only [mem_setOf_eq, Classical.not_imp, not_not] at hq
  show motionMul q h ∈ monoPairSet U c
  rw [probe_mem_monoPairSet_iff, probe_rigidMotion_motionMul, probe_rigidMotion_motionMul]
  exact hq

end HadwigerNelson.Plane
