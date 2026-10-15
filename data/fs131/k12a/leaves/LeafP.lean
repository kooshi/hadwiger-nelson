import Proofs.HadwigerNelson.Plane.WindowDensity
/-! First leaf of block P (scratch; FS131-K12A): C14.1-e's union has null unit pairs. -/
namespace HadwigerNelson.Plane
open MeasureTheory Set Complex

theorem leafP {J Z : Set ℂ} (hJ : MeasurableSet J) (hJ1 : BandFree J 0)
    (hZ : MeasurableSet Z) (hZ1 : UnitPairsNull Z) : UnitPairsNull ((J \ essNbhd Z) ∪ Z) := by
  set D := J \ essNbhd Z with hD
  have hDm : MeasurableSet D := hJ.diff (measurableSet_essNbhd hZ)
  -- pairs inside `J`: none
  have hJJ : pairSet D D = ∅ := by
    ext q
    simp only [pairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro h1 h2
    have hd : dist q.1 (q.1 + e q.2) = 1 := by
      rw [dist_comm, dist_eq_norm, add_sub_cancel_left]
      simp [e, Complex.norm_exp_ofReal_mul_I]
    rcases hJ1 _ h1.1 _ h2.1 with h | h <;> linarith
  -- from `D` into `Z`: the slices are null off the essential neighbourhood
  have hDZ : (volume.prod arcLength) (pairSet D Z) = 0 := by
    rw [pairSet_measure_eq_lintegral hDm hZ]
    refine (setLIntegral_congr_fun hDm (fun p hp => ?_)).trans (lintegral_zero)
    have : p ∉ essNbhd Z := hp.2
    simp only [essNbhd, mem_union, mem_setOf_eq, not_or, not_not] at this
    exact this.2
  -- from `Z` into `D`: the swap
  have hZD : (volume.prod arcLength) (pairSet Z D) = 0 := by
    rw [pairSet_null_iff_ae_slice hZ hDm]
    have h1 := (pairSet_null_iff_ae_slice hDm hZ).mp hDZ
    have h2 := ae_arcLength_shift_pi (fun θ => volume {x : ℂ | x ∈ D ∧ x + e θ ∈ Z})
      (fun θ => by simp [e_add_two_pi]) h1
    filter_upwards [h2] with θ hθ
    rw [volume_slice_swap]
    exact hθ
  -- assemble
  have hsub : unitPairSet (D ∪ Z) ⊆ pairSet D D ∪ pairSet Z Z ∪ pairSet D Z ∪ pairSet Z D := by
    intro q hq
    simp only [unitPairSet, pairSet, mem_setOf_eq, mem_union] at hq ⊢
    tauto
  refine measure_mono_null hsub ?_
  rw [hJJ, empty_union]
  exact measure_union_null (measure_union_null hZ1 hDZ) hZD

end HadwigerNelson.Plane
