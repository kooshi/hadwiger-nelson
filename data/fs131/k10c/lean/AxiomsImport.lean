import Proofs.HadwigerNelson.Arith.WeilKloosterman
set_option pp.fullNames true
open HadwigerNelson.StandingFive
-- resting on the import: each must print the standard three and `HadwigerNelson.StandingFive.kloosterman_bound`, nothing else
#print axioms kloostermanBound_of_ringChar_ne_two
#print axioms targetFloor_seven_weil
#print axioms targetFloor_six_weil
#print axioms circle_sum_le_weil
#print axioms standingFloor_seven_weil
#print axioms standingFloor_five_weil
#print axioms seven_le_localBound_weil
#print axioms five_le_chromaticNumber_weil
-- no axiom beyond the standard three: the controls (the model's conclusion does not use the import)
#print axioms sum_units_eq_sum_ne_zero
#print axioms four_mul_mul_ne_zero_iff
#print axioms kloosterman_page_of_kloostermanBound
#print axioms kloosterman_bound_model
#print axioms ringChar_ne_two_of_card_mod_four
#print axioms targetFloor_six_of_kloosterman
-- the hypothesis forms the import discharges: standard three only
#print axioms standingFloor_seven
#print axioms seven_le_localBound_of_kloosterman
#print axioms HadwigerNelson.Floor128.targetFloor_eight_128
