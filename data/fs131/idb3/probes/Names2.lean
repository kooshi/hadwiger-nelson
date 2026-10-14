import Proofs.HadwigerNelson.Plane.DensityBound.Pattern
#check @Nat.testBit_or
#check @Nat.testBit_and
#check @Nat.testBit_xor
#check @Nat.testBit_one_succ
#check @Nat.testBit_succ
#check @Nat.one_testBit_succ
example (k : ℕ) : Nat.testBit 1 (k + 1) = false := by simp
#check @List.getD_map
#check @List.getD_eq_getElem
#check @List.sum_map_neg
#check @Complex.conj_ofNat
#check @Complex.norm_natCast
#check @abs_le_of_sq_le_sq'
