import Proofs.HadwigerNelson.Arith.StationaryRatio
-- FS131-I10B, group 1 (X25B-P and X25B-PZ, with the toolkit). The last line is the control: a leaf still open
-- (X25B-L1 at this stage) must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_mul
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_max_ratio
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le
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
#print axioms HadwigerNelson.StationaryRatio.StationarySet.nb
#print axioms HadwigerNelson.StationaryRatio.StationarySet.notMem_nb_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.nb_mono
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurableSet_nb
#print axioms HadwigerNelson.StationaryRatio.StationarySet.ae_nb_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prod_null_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prod_apply_corr
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_corr
#print axioms HadwigerNelson.StationaryRatio.StationarySet.aeIndependent_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.pull
#print axioms HadwigerNelson.StationaryRatio.StationarySet.couple
-- CONTROL (must show sorryAx):
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels
