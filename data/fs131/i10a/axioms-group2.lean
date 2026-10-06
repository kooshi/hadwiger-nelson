import Proofs.HadwigerNelson.Arith.SpectralInputs
-- FS131-I10A, groups 2 and 3 (SI-4; the Fourier group). The last line is the control: a leaf still open must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.SpectralInputs.si4
#print axioms HadwigerNelson.SpectralInputs.ae_mem_condSupport
#print axioms HadwigerNelson.SpectralInputs.ae_condLaw_mul_eq_zero
#print axioms HadwigerNelson.SpectralInputs.measurable_selection
#print axioms HadwigerNelson.SpectralInputs.posDef_fourier
#print axioms HadwigerNelson.SpectralInputs.posDef_delta
#print axioms HadwigerNelson.SpectralInputs.ext_of_fourier
#print axioms HadwigerNelson.SpectralInputs.exists_isHaarFourier
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.map_mulRight
#print axioms HadwigerNelson.SpectralInputs.mul_mem_contChars_iff
#print axioms HadwigerNelson.SpectralInputs.contChars_haar_null
#print axioms HadwigerNelson.SpectralInputs.sp_if
-- CONTROL (must show sorryAx):
#print axioms HadwigerNelson.SpectralInputs.spectral_carried_iff
