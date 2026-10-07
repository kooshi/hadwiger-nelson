import Proofs.HadwigerNelson.Plane.RadiusOutside
-- FS124-K1: the claims' statements as the environment stores them (LEAN.md § Searching: read a leaf by `#check`).
open HadwigerNelson HadwigerNelson.Plane
set_option pp.fullNames false
#check @IsWeakColouringOn
#check @AeProperOn
#check @radius_graph
#check @radius_countable
#check @radius_up
#check @radius_down
#check @radius_five
#check @AeProperOn.ae_rigidMotion
#check @AeProperOn.exists_rigidMotion
#check @colorable_plane_of_forall_aeProperOn_ball
#check @exists_radius_of_not_colorable
#check @colorable_iff_forall_ball
#check @seven_le_chromaticNumber_plane_iff_exists_ball
#check @exists_isWeakColouringOn_iff_subtype
#check @isWeakColouringOn_univ_iff_weakColoring
#print axioms radius_five
