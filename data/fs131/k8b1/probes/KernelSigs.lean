import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed
-- FS131-K8B1: the composition as the kernel stores it (LEAN.md: read a leaf as the kernel has it).
open HadwigerNelson.Rigidity
set_option pp.fullNames true
#check @zeroEntropyCarried_of_tateModel
#check @zeroEntropyCarried_of_numberField
#check @HadwigerNelson.Rigidity.zeroEntropyCarried
#print axioms zeroEntropyCarried_of_numberField
#check @TateModel.thinBox_heavy
#check @TateModel.exists_point_of_heavy
#check @TateModel.measure_compl_TA_eq_zero
#check @exists_one_lt_absAt
#check @TateModel.exists_orbit_box
