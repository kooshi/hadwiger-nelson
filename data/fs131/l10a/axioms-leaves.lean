import Proofs.HadwigerNelson.Arith.CharacterColouring
import Proofs.HadwigerNelson.Arith.SpectralInputs
import Proofs.HadwigerNelson.Arith.StationaryRatio
import Proofs.HadwigerNelson.Arith.StandingFive

set_option pp.fullNames true

#print axioms HadwigerNelson.CharacterColouring.mem_archimedean_unitRing_iff
#print axioms HadwigerNelson.SpectralInputs.exists_isHaarFourier
#print axioms HadwigerNelson.SpectralInputs.sp_if
#print axioms HadwigerNelson.SpectralInputs.measurableSet_factorSigma_iff
#print axioms HadwigerNelson.SpectralInputs.contVec_eq_lpMeas
#print axioms HadwigerNelson.SpectralInputs.measurableSet_preimage_factorSigma
#print axioms HadwigerNelson.SpectralInputs.spectral_carried_iff
#print axioms HadwigerNelson.SpectralInputs.contChars_haar_null
#print axioms HadwigerNelson.SpectralInputs.si4
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_mul
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels
#print axioms HadwigerNelson.StandingFive.numberField_standingField
#print axioms HadwigerNelson.StandingFive.finrank_standingField
#print axioms HadwigerNelson.StandingFive.isTotallyReal_standingField
#print axioms HadwigerNelson.StandingFive.ncard_primes_above_two
#print axioms HadwigerNelson.StandingFive.comap_conj_of_two_mem
#print axioms HadwigerNelson.StandingFive.card_quotient_of_two_mem
#print axioms HadwigerNelson.StandingFive.usable_card_ge
#print axioms HadwigerNelson.StandingFive.stablePrime_card
#print axioms HadwigerNelson.StandingFive.le_localBound
#print axioms HadwigerNelson.StandingFive.no_small_usable
#print axioms HadwigerNelson.StandingFive.seven_le_localBound
#print axioms HadwigerNelson.StandingFive.five_le_chromaticNumber

-- the control: a `sorry` this print must show
theorem HadwigerNelson.fs131_l10a_control : (1 : Nat) = 1 := by sorry
#print axioms HadwigerNelson.fs131_l10a_control
