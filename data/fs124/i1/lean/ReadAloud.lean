import Proofs.HadwigerNelson.Plane.RadiusOutside
-- FS124-I1: the four statements read aloud in the record, as stored, with every binder's type shown
-- (the default print writes `∃ c, …` and hides that `c : ℂ → Fin 6` in the last one).
open HadwigerNelson HadwigerNelson.Plane
set_option pp.funBinderTypes true
set_option pp.numericTypes true
#check @radius_up
#check @radius_down
#check @colorable_iff_forall_ball
#check @seven_le_chromaticNumber_plane_iff_exists_ball
