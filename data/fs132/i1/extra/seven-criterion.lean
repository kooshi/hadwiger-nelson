import Proofs.HadwigerNelson.Outside.OAI158
open HadwigerNelson HadwigerNelson.Outside.OAI158
#check @Plane.seven_le_chiM0_iff
/-- not added to the library: row 131's criterion read for χ(ℝ²) itself -/
theorem seven_le_chromaticNumber_plane_iff :
    7 ≤ (unitDistance ℂ).chromaticNumber ↔ (⨆ ε > (0 : ℝ), Plane.mu 6 ε) < 1 := by
  rw [chromaticNumber_plane_eq_chiM0]; exact Plane.seven_le_chiM0_iff
#print axioms seven_le_chromaticNumber_plane_iff
