import Proofs.HadwigerNelson.Arith.TargetFloors
-- FS131-I10E: this job's block of `scripts/Axioms.lean`, then the planner's compositions of `TargetFloors` that rested on
-- the two floors, then the controls: leaves still open on this branch (other files') must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.Floor128.ev_zero
#print axioms HadwigerNelson.Floor128.ev_eq
#print axioms HadwigerNelson.Floor128.ev_one
#print axioms HadwigerNelson.Floor128.ev_two_mul
#print axioms HadwigerNelson.Floor128.ev_shiftLeft_one
#print axioms HadwigerNelson.Floor128.ev_two_pow
#print axioms HadwigerNelson.Floor128.ev_two
#print axioms HadwigerNelson.Floor128.map_ev
#print axioms HadwigerNelson.Floor128.coeff_ev_X
#print axioms HadwigerNelson.Floor128.ev_xor
#print axioms HadwigerNelson.Floor128.ev_clmul
#print axioms HadwigerNelson.Floor128.ev_step
#print axioms HadwigerNelson.Floor128.ev_iterate_step
#print axioms HadwigerNelson.Floor128.qBig_lt
#print axioms HadwigerNelson.Floor128.qBig_testBit_one
#print axioms HadwigerNelson.Floor128.charP_two
#print axioms HadwigerNelson.Floor128.exists_root
#print axioms HadwigerNelson.Floor128.step_lt
#print axioms HadwigerNelson.Floor128.step_ne_zero
#print axioms HadwigerNelson.Floor128.pass_fst
#print axioms HadwigerNelson.Floor128.pass_snd
#print axioms HadwigerNelson.Floor128.iterate_step_lt
#print axioms HadwigerNelson.Floor128.iterate_step_ne_zero
#print axioms HadwigerNelson.Floor128.iterate_step_period
#print axioms HadwigerNelson.Floor128.eq_of_dvd_of_not_dvd
#print axioms HadwigerNelson.Floor128.minimalPeriod_step
#print axioms HadwigerNelson.Floor128.iterate_step_injOn
#print axioms HadwigerNelson.Floor128.exists_iterate_step_eq
#print axioms HadwigerNelson.Floor128.digit_sum
#print axioms HadwigerNelson.Floor128.sum_range_mul_eq
#print axioms HadwigerNelson.Floor128.pass_class
#print axioms HadwigerNelson.Floor128.class_le
#print axioms HadwigerNelson.Floor128.root_pow_eq_one
#print axioms HadwigerNelson.Floor128.ev_ne_zero
#print axioms HadwigerNelson.Floor128.ev_inj
#print axioms HadwigerNelson.Floor128.root_pow_inj
#print axioms HadwigerNelson.Floor128.exists_code
#print axioms HadwigerNelson.Floor128.exists_root_pow_eq
#print axioms HadwigerNelson.Floor128.normOne_eq_image
#print axioms HadwigerNelson.Floor128.exists_addChar
#print axioms HadwigerNelson.Floor128.charSum_128_ge
#print axioms HadwigerNelson.Floor128.targetFloor_eight_128
#print axioms HadwigerNelson.Floor128.targetFloor_seven_128
-- the planner's compositions over the two floor modules (`TargetFloors`, not this job's file): both floors are proved on
-- this branch, so these two must print the standard three
#print axioms HadwigerNelson.StandingFive.standingFloor_seven
#print axioms HadwigerNelson.StandingFive.standingFloor_five
-- CONTROL (must show sorryAx): `StandingFive.usable_card_ge`, open on this branch (another file's leaf)
#print axioms HadwigerNelson.StandingFive.usable_card_ge
-- CONTROL (must show sorryAx): the wave's composition still rests on `StandingFive.le_localBound`, open on this branch
#print axioms HadwigerNelson.StandingFive.seven_le_localBound_of_kloosterman
