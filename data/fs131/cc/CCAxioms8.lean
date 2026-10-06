import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
set_option pp.fullNames true
/-- A planted control: its record must hold `sorryAx`. -/
theorem ccControlPlanted : (1 : ℕ) = 2 := sorry
-- EXPECT STANDARD — the collar bend, the collar's existence, and the model (B0)
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
#print axioms HadwigerNelson.Plane.ArcMap.exists_collarFit
#print axioms HadwigerNelson.Plane.ArcMap.collarModel
#print axioms HadwigerNelson.Plane.ArcMap.quarter_lt_chord
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_homeo
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_lensCurve
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_end
-- EXPECT SORRY — the planted control
#print axioms ccControlPlanted
