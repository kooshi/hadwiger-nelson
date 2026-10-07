import Proofs.HadwigerNelson.Arith.StationaryRatio
import Proofs.HadwigerNelson.Arith.StandingFive
-- FS131-I10B, every record of this job's block of `scripts/Axioms.lean` (the three leaves first). The last line is the
-- control: a leaf still open on this branch (`StandingFive.usable_card_ge`, another implementer's) must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_mul
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels
#print axioms HadwigerNelson.StationaryRatio.ae_neg_iff
#print axioms HadwigerNelson.StationaryRatio.ratio_le_one
#print axioms HadwigerNelson.StationaryRatio.ratio_mul_le
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_add_apply
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_zero_apply
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_neg_T
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_T_neg
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_T_apply
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_T_comp
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_T_left
#print axioms HadwigerNelson.StationaryRatio.StationarySet.ae_T_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.notMem_nb_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.nb_mono
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurableSet_nb
#print axioms HadwigerNelson.StationaryRatio.StationarySet.ae_nb_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prod_null_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prod_apply_corr
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_corr
#print axioms HadwigerNelson.StationaryRatio.StationarySet.aeIndependent_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_mul_of_symm
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_max_ratio
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_of_symm
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurableSet_majority
#print axioms HadwigerNelson.StationaryRatio.StationarySet.ae_majority
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measure_le_majority_add
#print axioms HadwigerNelson.StationaryRatio.cosetAverage_apply
#print axioms HadwigerNelson.StationaryRatio.cosetAverage.instIsProbabilityMeasure
#print axioms HadwigerNelson.StationaryRatio.cosetAverage_compl
#print axioms HadwigerNelson.StationaryRatio.ae_mem_cosetAverage
#print axioms HadwigerNelson.StationaryRatio.cosetAverage_preimage_add
#print axioms HadwigerNelson.StationaryRatio.lintegral_prod_conv_cosetAverage
#print axioms HadwigerNelson.StationaryRatio.tendsto_measure_symmDiff_shift
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_level_add
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels_of_shrink
#print axioms HadwigerNelson.StationaryRatio.ratio_dirac_le
#print axioms HadwigerNelson.StationaryRatio.StationarySet.parity_prob
#print axioms HadwigerNelson.StationaryRatio.StationarySet.parity_aeIndependent
#print axioms HadwigerNelson.StationaryRatio.map_neg_dirac_one
#print axioms HadwigerNelson.StationaryRatio.ratio_dirac_one_zmod_two
#print axioms HadwigerNelson.StationaryRatio.mem_cantorLevel
#print axioms HadwigerNelson.StationaryRatio.cantorLevel_antitone
#print axioms HadwigerNelson.StationaryRatio.exists_cantorLevel_subset
#print axioms HadwigerNelson.StationaryRatio.StationarySet.nb
#print axioms HadwigerNelson.StationaryRatio.StationarySet.pull
#print axioms HadwigerNelson.StationaryRatio.StationarySet.couple
#print axioms HadwigerNelson.StationaryRatio.StationarySet.majority
#print axioms HadwigerNelson.StationaryRatio.StationarySet.parity
#print axioms HadwigerNelson.StationaryRatio.cantorLevel
-- CONTROL (must show sorryAx):
#print axioms HadwigerNelson.StandingFive.usable_card_ge
