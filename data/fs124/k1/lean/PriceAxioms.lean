import Proofs.HadwigerNelson.Plane.RadiusOutside
-- FS124-K1 stage 5: the axioms of the eight leaves proved by the planner, read from the real build.
open HadwigerNelson HadwigerNelson.Plane
#print axioms continuous_rigidMotion
#print axioms rigidMotion_motionMul
#print axioms measurePreserving_motionMul_right
#print axioms prod_arcLength_eq_restrict
#print axioms prod_arcLength_eq_zero_iff_volume
#print axioms mem_monoPairSet_iff_rigidMotion
#print axioms isOpen_setOf_mapsTo_rigidMotion
#print axioms AeProperOn.ae_rigidMotion_edge

-- Deferred, not in the library: C124-EVERY-DIRECTION in this module's vocabulary (statement only; it elaborates).
theorem deferred_every_direction {k : ℕ} {U : Set ℂ} {c : ℂ → Fin k} (hU : MeasurableSet U)
    (hc : IsWeakColouringOn U c) (θ : ℝ) :
    ∀ᵐ z : ℂ, z ∈ U → z + e θ ∈ U → c z ≠ c (z + e θ) := by
  sorry
