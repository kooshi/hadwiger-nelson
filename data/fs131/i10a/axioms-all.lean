import Proofs.HadwigerNelson.Arith.SpectralInputs
import Proofs.HadwigerNelson.Arith.CharacterColouring
import Proofs.HadwigerNelson.Arith.StandingFive
-- FS131-I10A, the whole job: every record of the "FS131-I10A" block of `scripts/Axioms.lean`.
-- The last line is the control: a leaf of another file of the wave, still open, must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.SpectralInputs.mem_factorSets_iff
#print axioms HadwigerNelson.SpectralInputs.isClosed_contVec
#print axioms HadwigerNelson.SpectralInputs.lipschitz_comp_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.iUnion_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.measurableSet_factorSigma_iff
#print axioms HadwigerNelson.SpectralInputs.setOf_lt_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.contVec_eq_lpMeas
#print axioms HadwigerNelson.SpectralInputs.measurableSet_preimage_factorSigma
#print axioms HadwigerNelson.SpectralInputs.condExpL2_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.condExpL2_eq_self_iff
#print axioms HadwigerNelson.SpectralInputs.inner_sub_condExpL2_eq_zero
#print axioms HadwigerNelson.SpectralInputs.measurable_selection
#print axioms HadwigerNelson.SpectralInputs.ae_mem_condSupport
#print axioms HadwigerNelson.SpectralInputs.ae_condLaw_mul_eq_zero
#print axioms HadwigerNelson.SpectralInputs.si4
#print axioms HadwigerNelson.SpectralInputs.condExp_comp_measurePreserving
#print axioms HadwigerNelson.SpectralInputs.si4_equivariant
#print axioms HadwigerNelson.SpectralInputs.posDef_fourier
#print axioms HadwigerNelson.SpectralInputs.ext_of_fourier
#print axioms HadwigerNelson.SpectralInputs.posDef_delta
#print axioms HadwigerNelson.SpectralInputs.exists_isHaarFourier
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.integral_eq
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.map_mulRight
#print axioms HadwigerNelson.SpectralInputs.mul_mem_contChars_iff
#print axioms HadwigerNelson.SpectralInputs.contChars_haar_null
#print axioms HadwigerNelson.SpectralInputs.rot_negOne_apply
#print axioms HadwigerNelson.SpectralInputs.sp_if
#print axioms HadwigerNelson.SpectralInputs.compMeasurePreserving_add
#print axioms HadwigerNelson.SpectralInputs.compMeasurePreserving_zero
#print axioms HadwigerNelson.SpectralInputs.norm_comp_sub_sq
#print axioms HadwigerNelson.SpectralInputs.spectral_carried_iff
#print axioms HadwigerNelson.CharacterColouring.exists_ratLinear_extension
#print axioms HadwigerNelson.CharacterColouring.mem_archimedean_unitRing_iff
-- CONTROL (must show sorryAx):
#print axioms HadwigerNelson.StandingFive.usable_card_ge
