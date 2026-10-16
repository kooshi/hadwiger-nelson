import Mathlib.Algebra.Ring.Subring.Basic
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Algebra.GroupWithZero.Units.Fintype
import Mathlib.FieldTheory.Finite.GaloisField
#check @GaloisField.card
#check @FiniteField.pow_card
#check @Polynomial.card_le_degree_of_subset_roots
#check @pow_orderOf_eq_one
#check @orderOf_pos
#check @inv_eq_of_mul_eq_one_right
#check @frobenius_def
#synth Fact (Nat.Prime 3)
#synth Finite (ℤˣ)
#check @Units.val_pow_eq_pow_val
#check @IsUnit.map
#check @Polynomial.natDegree_X_pow_sub_X
#check @FiniteField.X_pow_card_sub_X_natDegree_eq
#synth Fintype (GaloisField 3 2)
#synth CharP (GaloisField 3 2) 3
example : ∃ θ : GaloisField 3 2, θ ^ 3 ≠ θ := by
  by_contra h
  push Not at h
  sorry
