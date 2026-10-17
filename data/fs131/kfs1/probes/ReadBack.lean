import Proofs.HadwigerNelson.RationalFour.Forbid
import Proofs.HadwigerNelson.Instances.SeamFractional
set_option pp.coercions.types true
open HadwigerNelson
#check @RationalFour.zero_le_val_iff
#check @RationalFour.one_le_val_div_odd
#check @RationalFour.inv_prime_mem_comp
#check @RationalFour.forall_coloring_eq_iff
#check @RationalFour.forall_coloring_ne_iff
#check @RationalFour.exists_coloring_eq_and_ne_iff
#check @RationalFour.exists_coloring_forbidding_iff
#check @RationalFour.exists_coloring_forbidding_iff_padicValRat
#check @RationalFour.coloring_forbids_of_odd
#check @RationalFour.nonempty_iso_unitDistance
#check @Instances.SeamFractional.fractionalChromaticNumber_seamPlane
#check @Instances.SeamFractional.IndepLaw.density_le_quarter_seamField
#print axioms Instances.SeamFractional.fractionalChromaticNumber_seamPlane
