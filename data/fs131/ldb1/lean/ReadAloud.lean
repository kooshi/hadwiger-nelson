import Proofs.HadwigerNelson.Plane.DensityBound.Theorem
import Proofs.HadwigerNelson.Plane.OneClass.Algebraic
/-! FS131-LDB1 — the headline as the kernel stores it, read aloud against `[AmbrusEtAl2023]` Theorem 1 (p. 4): its type,
the definition that type names with its stored value, the definitions the corollaries name, and the axioms. -/
set_option pp.funBinderTypes true
set_option pp.proofs true
#check @HadwigerNelson.Plane.oneAvoidingDensityBound
#print HadwigerNelson.Plane.OneAvoidingDensityBound
#print axioms HadwigerNelson.Plane.oneAvoidingDensityBound
#check @HadwigerNelson.DensityBound.DualCert.oneAvoidingDensityBound_of
#print HadwigerNelson.Plane.mOne
#check @HadwigerNelson.Plane.mOne_eq_iSup_bandFree
#print axioms HadwigerNelson.Plane.mOne_eq_iSup_bandFree
#check @HadwigerNelson.Plane.mOne_le_one
#check @HadwigerNelson.OneClass.one_seventh_le_mOne
#print HadwigerNelson.Plane.upperDensity
#print HadwigerNelson.Plane.BandFree
#check @HadwigerNelson.Plane.mOne_le_of_oneAvoidingDensityBound
#check @HadwigerNelson.Plane.mOne_lt_quarter
#check (HadwigerNelson.Plane.mOne_lt_quarter HadwigerNelson.Plane.oneAvoidingDensityBound)
#check @HadwigerNelson.Plane.upperDensity_le_of_oneAvoidingDensityBound
#print axioms HadwigerNelson.Plane.mOne_lt_quarter
#print axioms HadwigerNelson.DensityBound.DualCert.oneAvoidingDensityBound_of
