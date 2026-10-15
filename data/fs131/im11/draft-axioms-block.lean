-- FS131-IM11 (draft for the landing; CLEAN section of scripts/Axioms.lean): every public declaration of
-- Rigidity/SpectralSubspace, Rigidity/TraceSplit and Rigidity/APlus whose axioms are a subset of the standard three at
-- build 3 of fs131-wm12, and the lemma of Rigidity/ContinuityGroup made public (generated from data/fs131/im11/axioms-after.txt).
-- (generated `congr_simp` theorems left out: `koopmanSum`, `Lp.compMeasurePreservingₗ`, `colourFactor`, `factorColouring`.)
-- Rigidity/SpectralSubspace
#print axioms HadwigerNelson.Rigidity.IsSpectralMeasureOf.add_of_orthogonal
#print axioms HadwigerNelson.Rigidity.IsSpectralMeasureOf.unique
#print axioms HadwigerNelson.Rigidity.comp_koopmanSum
#print axioms HadwigerNelson.Rigidity.comp_mem_contVec
#print axioms HadwigerNelson.Rigidity.exists_isSpectralMeasureOf
#print axioms HadwigerNelson.Rigidity.exists_spectral_vector
#print axioms HadwigerNelson.Rigidity.exists_trigPoly_tendsto
#print axioms HadwigerNelson.Rigidity.gram_sum_eq
#print axioms HadwigerNelson.Rigidity.inner_comp_eq_inner_comp_neg
#print axioms HadwigerNelson.Rigidity.inner_koopmanSum_re
#print axioms HadwigerNelson.Rigidity.isSpectralMeasureOf_condExpL2
#print axioms HadwigerNelson.Rigidity.koopmanSum
#print axioms HadwigerNelson.Rigidity.norm_sq_koopmanSum_re_add_im
#print axioms HadwigerNelson.Rigidity.posDef_koopman
#print axioms HadwigerNelson.Rigidity.spectral_contChars_null_of_orthogonal
#print axioms HadwigerNelson.Rigidity.spectral_null_model
#print axioms HadwigerNelson.Rigidity.spectral_null_of_orthogonal
#print axioms HadwigerNelson.Rigidity.trigPoly
-- Rigidity/TraceSplit
#print axioms HadwigerNelson.Rigidity.colourCond
#print axioms HadwigerNelson.Rigidity.colourCond_ae_eq_condLaw
#print axioms HadwigerNelson.Rigidity.colourFactor
#print axioms HadwigerNelson.Rigidity.colourInd
#print axioms HadwigerNelson.Rigidity.colourShift
#print axioms HadwigerNelson.Rigidity.colourShift_add
#print axioms HadwigerNelson.Rigidity.colourShift_zero
#print axioms HadwigerNelson.Rigidity.condLaw_comp_colourShift
#print axioms HadwigerNelson.Rigidity.inner_colourInd_comp_unit
#print axioms HadwigerNelson.Rigidity.integral_colourCond_mul_comp
#print axioms HadwigerNelson.Rigidity.integral_colourInd_mul_comp
#print axioms HadwigerNelson.Rigidity.integral_condLaw_mul_nonneg
#print axioms HadwigerNelson.Rigidity.measurable_colourShift
#print axioms HadwigerNelson.Rigidity.setIntegral_compl_TA_rot
#print axioms HadwigerNelson.Rigidity.three_mul_tetra_add_one
#print axioms HadwigerNelson.Rigidity.trace_decomp
#print axioms HadwigerNelson.SpectralChain.InvariantColouring.measurePreserving_shift
-- Rigidity/APlus
#print axioms HadwigerNelson.Rigidity.EqualAtUnits
#print axioms HadwigerNelson.Rigidity.colourRot
#print axioms HadwigerNelson.Rigidity.comap_colourRot_colourFactor
#print axioms HadwigerNelson.Rigidity.factorColouring
#print axioms HadwigerNelson.Rigidity.factorColouring_mem_X4
#print axioms HadwigerNelson.Rigidity.factorColouring_rot_ae
#print axioms HadwigerNelson.Rigidity.factorColouring_shift_ae
#print axioms HadwigerNelson.Rigidity.factorLaw
#print axioms HadwigerNelson.Rigidity.factorLaw_carried
#print axioms HadwigerNelson.Rigidity.factorLaw_isProb
#print axioms HadwigerNelson.Rigidity.factorLaw_rot_inv
#print axioms HadwigerNelson.Rigidity.factorLaw_shift_inv
#print axioms HadwigerNelson.Rigidity.integral_condLaw_mul_eq_zero_of_adj
#print axioms HadwigerNelson.Rigidity.measurable_colourRot
#print axioms HadwigerNelson.Rigidity.measurable_factorColouring
#print axioms HadwigerNelson.Rigidity.measurable_factorColouring_apply
#print axioms HadwigerNelson.Rigidity.minSel
#print axioms HadwigerNelson.Rigidity.minSel_mem
#print axioms HadwigerNelson.Rigidity.numberField_bot
#print axioms HadwigerNelson.Rigidity.tendsto_mul_nhds_tauPrime
#print axioms HadwigerNelson.SpectralChain.InvariantColouring.measurePreserving_rot
-- Rigidity/ContinuityGroup
#print axioms HadwigerNelson.Rigidity.mem_nhds_profTop
-- NOT YET CLEAN (sorryAx only through M2b's bochnerOn_tauPrime, or M3's two leaves for the models): to the CLEAN
-- section when those modules land; until then they are not audit records
-- Rigidity/TraceSplit
-- #print axioms HadwigerNelson.Rigidity.setIntegral_compl_TA_re
-- #print axioms HadwigerNelson.Rigidity.setIntegral_compl_TA_re_nonpos
-- Rigidity/APlus
-- #print axioms HadwigerNelson.Rigidity.aPlusOfR88
-- #print axioms HadwigerNelson.Rigidity.aplus_model
-- #print axioms HadwigerNelson.Rigidity.equalAtUnits_of_not_neg
-- #print axioms HadwigerNelson.Rigidity.factorLaw_trace_null
-- #print axioms HadwigerNelson.Rigidity.nonempty_invariantColouring_bot
