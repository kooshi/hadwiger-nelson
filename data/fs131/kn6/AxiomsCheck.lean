import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
-- FS131-KN6: the axiom lists of what this job proved, from the built tree (build 2).
open HadwigerNelson HadwigerNelson.Rigidity
#print axioms colorable_two_levelTarget_one_of_isRamified
#print axioms noRamifiedStableDyadic_of_three_le_localBound
#print axioms IsRamified.isDyadic
#print axioms noRamifiedStableDyadic_iff
#print axioms partitionEntropy_le_liminf
#print axioms mem_nameCell_self
#print axioms partitionEntropy_le
#print axioms partitionEntropy_le_ksEntropyOn
#print axioms partitionEntropy_le_ksEntropy
#print axioms ksEntropy_eq_zero_iff
#print axioms ksEntropyOn_le_ksEntropy
#print axioms blockEntropy_nonneg
#check @noRamifiedStableDyadic_of_three_le_localBound
#check @colorable_two_levelTarget_one_of_isRamified
#check @tendsto_blockEntropy_div
#check @ksEntropyOn_le_ksEntropy
