import Proofs.HadwigerNelson.Arith.FloorPlanes
-- FS131-I10D, group 1 (P1 `involution_eq_pow`, P2 `card_normOne`, and `targetFloor_of_charSum`, proved over the two).
-- The last line is the control: a leaf still open must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.StandingFive.involution_eq_pow
#print axioms HadwigerNelson.StandingFive.card_filter_pow_eq_one
#print axioms HadwigerNelson.StandingFive.card_normOne
#print axioms HadwigerNelson.StandingFive.targetFloor_of_charSum
-- CONTROL (must show sorryAx):
#print axioms HadwigerNelson.StandingFive.sum_quadratic_eq
