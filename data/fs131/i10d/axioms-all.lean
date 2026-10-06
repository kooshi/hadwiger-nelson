import Proofs.HadwigerNelson.Arith.TargetFloors
-- FS131-I10D, all leaves: this job's block of `scripts/Axioms.lean`, and the planner's compositions that rested on these
-- leaves. The last line is the control: a leaf still open on this branch (another file's) must print `sorryAx`.
set_option pp.fullNames true
-- `NormOneTarget`
#print axioms HadwigerNelson.StandingFive.involution_eq_pow
#print axioms HadwigerNelson.StandingFive.card_filter_pow_eq_one
#print axioms HadwigerNelson.StandingFive.card_normOne
#print axioms HadwigerNelson.StandingFive.targetFloor_of_charSum
-- `FloorPlanes`
#print axioms HadwigerNelson.StandingFive.sum_addChar_mul_left
#print axioms HadwigerNelson.StandingFive.sum_eq_zero_add_sum_units
#print axioms HadwigerNelson.StandingFive.sum_units_addChar_mul
#print axioms HadwigerNelson.StandingFive.sum_addChar_mul_sq
#print axioms HadwigerNelson.StandingFive.sum_quadratic_eq
#print axioms HadwigerNelson.StandingFive.sum_plane_quadratic
#print axioms HadwigerNelson.StandingFive.circle_sum_eq_kloosterman
#print axioms HadwigerNelson.StandingFive.circle_sum_le_of_ne
#print axioms HadwigerNelson.StandingFive.circle_sum_le
#print axioms HadwigerNelson.StandingFive.circle_sum_zero_of_isotropic
#print axioms HadwigerNelson.StandingFive.two_sqrt_lt_circle_sum_zero
#print axioms HadwigerNelson.StandingFive.exists_ringHom_pow
#print axioms HadwigerNelson.StandingFive.card_filter_pow_eq_self
#print axioms HadwigerNelson.StandingFive.exists_mulShift_eq
#print axioms HadwigerNelson.StandingFive.normOne_charSum_ge
#print axioms HadwigerNelson.StandingFive.targetFloor_seven_of_kloosterman
-- CONTROL (must show sorryAx): `StandingFive.usable_card_ge`, open on this branch
#print axioms HadwigerNelson.StandingFive.usable_card_ge
-- For the join (not a record of this block): the wave's composition still rests on `Floor128`'s leaf, another
-- implementer's, so it must show `sorryAx` on this branch.
#print axioms HadwigerNelson.StandingFive.standingFloor_seven
