import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
-- FS131-KN3: the first layer read as the kernel has it (LEAN.md: "read a leaf as the kernel has it").
open HadwigerNelson HadwigerNelson.Rigidity
set_option pp.fullNames false
#check @positive_entropy_rigidity
#check @haar_or_zero_entropy
#check @MRPlus
#check @mrPlus_of_split_of_carried
#check @min_localBound_five_le_chromaticNumber_of_closed
#check @entropySplit
#check @zeroEntropyCarried
#check @noRamifiedStableDyadic_of_tca
#check @measurableSet_TA
#check @rot_preimage_TA
#print axioms positive_entropy_rigidity_model
#print axioms ZdAction.isVirtuallyCyclicMod_bot
#print axioms ksEntropy_zero_measure
#print axioms mrPlus_of_split_of_carried
#print axioms min_localBound_five_le_chromaticNumber_of_closed
#print axioms min_localBound_five_le_chromaticNumber_closed
