import Proofs.HadwigerNelson.Plane.WeakColouringOn
-- FS124-K1 probe (iteration only): the periodicity leaf and the openness leaf.
namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Metric Filter Topology

theorem probe_prod_arcLength_eq_restrict :
    (volume : Measure ℂ).prod arcLength = (volume : Measure (ℂ × ℝ)).restrict (univ ×ˢ Ico 0 (2 * Real.pi)) := by
  rw [arcLength, Measure.volume_eq_prod, ← Measure.prod_restrict, Measure.restrict_univ]

theorem probe_prod_arcLength_eq_zero_iff_volume {S : Set (ℂ × ℝ)}
    (hS : ∀ (x : ℂ) (θ θ' : ℝ), e θ = e θ' → (x, θ) ∈ S → (x, θ') ∈ S) :
    ((volume : Measure ℂ).prod arcLength) S = 0 ↔ (volume : Measure (ℂ × ℝ)) S = 0 := by
  have hI : MeasurableSet ((univ : Set ℂ) ×ˢ Ico (0 : ℝ) (2 * Real.pi)) := MeasurableSet.univ.prod measurableSet_Ico
  rw [probe_prod_arcLength_eq_restrict, Measure.restrict_apply' hI]
  refine ⟨fun h0 => ?_, fun h0 => measure_mono_null inter_subset_left h0⟩
  have hp : (0 : ℝ) < 2 * Real.pi := by positivity
  -- `S` is covered by the integer translates, in the angle, of its part over `[0, 2π)`
  have hcov : S ⊆ ⋃ n : ℤ, (fun q : ℂ × ℝ => (q.1, q.2 + (-(n * (2 * Real.pi))))) ⁻¹'
      (S ∩ (univ : Set ℂ) ×ˢ Ico (0 : ℝ) (2 * Real.pi)) := by
    rintro ⟨x, θ⟩ hq
    refine mem_iUnion.2 ⟨⌊θ / (2 * Real.pi)⌋, ?_, mem_univ _, ?_, ?_⟩
    · refine hS x θ _ ?_ hq
      have h := (Function.Periodic.int_mul (fun θ : ℝ => e_add_two_pi θ) (-⌊θ / (2 * Real.pi)⌋)) θ
      simpa [mul_comm] using h.symm
    · have := Int.floor_le (θ / (2 * Real.pi))
      rw [le_div_iff₀ hp] at this
      show 0 ≤ θ + -(↑⌊θ / (2 * Real.pi)⌋ * (2 * Real.pi)); linarith
    · have := Int.lt_floor_add_one (θ / (2 * Real.pi))
      rw [div_lt_iff₀ hp] at this
      show θ + -(↑⌊θ / (2 * Real.pi)⌋ * (2 * Real.pi)) < 2 * Real.pi; linarith
  refine measure_mono_null hcov (measure_iUnion_null fun n => ?_)
  have hmp : MeasurePreserving (fun q : ℂ × ℝ => (q.1, q.2 + (-(n * (2 * Real.pi)))))
      (volume : Measure (ℂ × ℝ)) volume := by
    rw [Measure.volume_eq_prod]
    exact (MeasurePreserving.id volume).prod (measurePreserving_add_right volume _)
  exact hmp.quasiMeasurePreserving.preimage_null h0

theorem probe_continuous_rigidMotion : Continuous fun p : (ℂ × ℝ) × ℂ => rigidMotion p.1 p.2 := by
  unfold rigidMotion
  exact (continuous_fst.comp continuous_fst).add
    ((continuous_e.comp (continuous_snd.comp continuous_fst)).mul continuous_snd)

theorem probe_isOpen_setOf_mapsTo_rigidMotion {K U : Set ℂ} (hK : IsCompact K) (hU : IsOpen U) :
    IsOpen {q : ℂ × ℝ | MapsTo (rigidMotion q) K U} := by
  rw [isOpen_iff_eventually]
  intro q₀ hq₀
  refine hK.eventually_forall_of_forall_eventually fun y hy => ?_
  exact probe_continuous_rigidMotion.continuousAt.eventually (hU.mem_nhds (hq₀ hy))

end HadwigerNelson.Plane
