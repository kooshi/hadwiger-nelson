import Proofs.HadwigerNelson.Arith.StationaryRatio
import Proofs.HadwigerNelson.Arith.StandingFive
-- FS131-I10B, group 2 (X25B-L1, with the majority event and the level average). The last line is the control: a leaf
-- still open on this branch (`StandingFive.usable_card_ge`, another implementer's file) must print `sorryAx`.
set_option pp.fullNames true
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_level_add
#print axioms HadwigerNelson.StationaryRatio.StationarySet.majority
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
-- the leaves of group 1 again (the file was rebuilt)
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_mul
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le
-- CONTROL (must show sorryAx):
#print axioms HadwigerNelson.StandingFive.usable_card_ge
