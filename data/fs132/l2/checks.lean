import Proofs
/-!
FS132-L2 — the four theorems the landing is for, as the kernel holds them, with their axioms, for the reading aloud;
and the definitions their statements name.  Iteration file, run by the gate's runner after the build
(`lake env lean data/fs132/l2/checks.lean`); never a library module.
-/
open HadwigerNelson HadwigerNelson.SixRing HadwigerNelson.Outside.OAI158

#check @no_outside_orbit_points
#check @no_outside_orbit
#check @not_ae_outside
#check @not_ae_outside_points
#check @no_alternating_pairs
#check @no_alternating_groups
#check @adjacent_tip_false
#check @chart_step_false
#print axioms no_outside_orbit_points
#print axioms no_outside_orbit
#print axioms not_ae_outside
#print axioms not_ae_outside_points
#print axioms no_alternating_pairs
-- the definitions the statements name
#print FourCycleStraddle
#print OutsideOrbit
#print WeakColoring
#print Straddle
#print spatialSupport
#print IsTip
#print hub
#print sixty
#check @palette
#check @angularMeasure
-- the models the docstrings name, as the kernel holds them
#check @proper_to_borel_weak_model
#check @shiftBounds_model
#check @exists_shiftBounds
#check @exists_weakColoring_iff_nonempty_aeColouring
-- controls: a theorem on each declared outside theorem prints it (the print sees an import when one is there)
#print axioms not_colorable_five
#print axioms chromaticNumber_plane_eq_chiM0
