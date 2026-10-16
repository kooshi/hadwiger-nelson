import Proofs.HadwigerNelson.CayleyThree.Fibre
open HadwigerNelson
#check @WellQuasiOrderedLE.finite_of_isAntichain
#check @Pi.wellQuasiOrderedLE
#check @IsAntichain.finite
example {ι : Type} [Finite ι] : WellQuasiOrderedLE (ι → ℕ) := inferInstance
example {ι : Type} [Finite ι] : WellFoundedLT (ι → ℕ) := inferInstance
#check @WellFoundedLT.induction
#check @WellFounded.has_min
#check @List.perm_cons_erase
#check @List.length_erase_of_mem
#check @List.count_pos_iff
#check @Finset.univ_sum_single
#check @Int.induction_on
#check @Finset.sum_eq_zero_iff_of_nonneg
#check @AddSubgroup.finiteIndex_iInf
#check @AddSubgroup.finite_quotient_of_finiteIndex
#print HadwigerNelson.Forces
#check @HadwigerNelson.addCayleyTranslate
#check @Int.toNat_add
#check @AddSubgroup.mem_sup
#check @nsmulAddMonoidHom
#check @Int.csInf_mem
#check @csInf_le
#check @le_csInf
#check @Pi.single_add
