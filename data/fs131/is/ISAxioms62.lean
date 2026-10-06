import Proofs
set_option pp.fullNames true
-- the theorem and its child (the brief's item 3)
#print axioms HadwigerNelson.Plane.ArcMap.stuckRun_ne_univ
#print axioms HadwigerNelson.Plane.ArcMap.shadow_recursion
-- the other children (Stage 61)
#print axioms HadwigerNelson.Plane.ArcMap.le_curvDown_of_flankBelow_of_horn
#print axioms HadwigerNelson.Plane.ArcMap.curvUp_le_of_horn_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.horn_colour_eq_of_isChainVertex
#print axioms HadwigerNelson.Plane.ArcMap.eq_horn_colour_of_two_sectors
#print axioms HadwigerNelson.Plane.ArcMap.horn_upper_ne_one
#print axioms HadwigerNelson.Plane.ArcMap.horn_lower_ne_neg_one
-- what the theorem rests on in other modules, and its siblings in `Terminal`
#print axioms HadwigerNelson.Plane.n4_fin
#print axioms HadwigerNelson.Plane.ArcMap.cv_class
#print axioms HadwigerNelson.Plane.ArcMap.run_hornBoundsQR
#print axioms HadwigerNelson.Plane.ArcMap.run_ends
-- controls: open leaves elsewhere (must print sorryAx): `exists_terminal` and `exists_red` rest on `Procedure`'s two steps
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminal
#print axioms HadwigerNelson.Plane.ArcMap.exists_red
#print axioms HadwigerNelson.Plane.ArcMap.exists_vertexStep
