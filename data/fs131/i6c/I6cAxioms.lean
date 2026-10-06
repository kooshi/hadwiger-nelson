import Proofs.HadwigerNelson.Plane.Saturated.LocalGraph
/-! FS131-I6C: the axioms of each declaration this job proved, read from the build's oleans
(`lake env lean data/fs131/i6c/I6cAxioms.lean`). The first print is the **control**: a declaration that still rests on
`sorry` on this branch must show `sorryAx`, so the reader is seen to report the failure it guards against. -/
open HadwigerNelson.Plane
set_option pp.fullNames true
#eval IO.println "=== CONTROL (must show sorryAx) ==="
#print axioms HadwigerNelson.Plane.c11_discs
#eval IO.println "=== Curve ==="
#print axioms HadwigerNelson.Plane.IsUnitCurve.hasDerivWithinAt_re_mul
#print axioms HadwigerNelson.Plane.IsUnitCurve.hasDerivWithinAt_norm_sq
#print axioms HadwigerNelson.Plane.IsUnitCurve.abs_sub_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_add_sin_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.chord
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_le_inner
#print axioms HadwigerNelson.Plane.IsUnitCurve.strictMonoOn_dist
#print axioms HadwigerNelson.Plane.IsUnitCurve.norm_sub_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.one_le_dist_of_sign
#print axioms HadwigerNelson.Plane.IsUnitCurve.one_le_dist
#print axioms HadwigerNelson.Plane.isUnitCurve_circle
#print axioms HadwigerNelson.Plane.two_sin_le_norm_e_sub_e
#print axioms HadwigerNelson.Plane.lt_mul_of_two_sin_le
#print axioms HadwigerNelson.Plane.le_add_of_chord
#print axioms HadwigerNelson.Plane.lipschitzOnWith_of_chord
