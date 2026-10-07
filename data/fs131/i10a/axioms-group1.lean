import Proofs.HadwigerNelson.Arith.SpectralInputs
-- FS131-I10A, group 1 (the factor trio). The last line is the control: a leaf still open must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.SpectralInputs.measurableSet_factorSigma_iff
#print axioms HadwigerNelson.SpectralInputs.contVec_eq_lpMeas
#print axioms HadwigerNelson.SpectralInputs.measurableSet_preimage_factorSigma
#print axioms HadwigerNelson.SpectralInputs.mem_factorSets_iff
#print axioms HadwigerNelson.SpectralInputs.isClosed_contVec
#print axioms HadwigerNelson.SpectralInputs.lipschitz_comp_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.setOf_lt_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.condExpL2_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.condExpL2_eq_self_iff
#print axioms HadwigerNelson.SpectralInputs.inner_sub_condExpL2_eq_zero
-- CONTROL (must show sorryAx):
#print axioms HadwigerNelson.SpectralInputs.sp_if
