import Proofs.HadwigerNelson.CayleyThree.Fibre
open HadwigerNelson
#check @Convex.sum_mem
#check @Finset.sum_lt_sum
#check @AddSubgroup.coe_neg
#check @NegMemClass.coe_neg
#check @Finset.sum_ite_eq
#check @Finset.sum_ite_eq'
#check @Pi.single_smul
#check @AddSubgroup.zsmul_mem
#check @AddSubgroup.sum_mem
#check @Int.toNat_of_nonneg
#check @Finset.single_le_sum
example (t : ℤ) (h : t < 0) : ((t.natAbs : ℤ)) = -t := by omega
