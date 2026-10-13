import Proofs.HadwigerNelson.SquareClass
import Mathlib.NumberTheory.Padics.Hensel
import Mathlib.NumberTheory.Padics.RingHoms
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.FieldTheory.Extension
import Mathlib.RingTheory.Valuation.LocalSubring

open HadwigerNelson NumberField
#check @IntermediateField.nonempty_algHom_adjoin_of_splits
#check @PadicInt.norm_lt_one_iff_dvd
#check @PadicInt.norm_int_lt_one_iff_dvd
#check @PadicInt.ker_toZMod
#check @PadicInt.isUnit_iff
#check @PadicInt.toZMod_spec
#check @PadicInt.mem_subring_iff
#check @PadicInt.norm_le_one
#check @Padic.norm_le_one_iff_val_nonneg
#check @PadicInt.coe_toZMod
#check @PadicInt.toZMod_natCast
#check @IsIntegral.map
#check @IsIntegral.tower_top
#check @Polynomial.Splits.of_dvd
#check @Polynomial.splits_of_splits_of_dvd
#check @minpoly.dvd
#check @IntermediateField.finiteDimensional_adjoin
#check @IntermediateField.adjoin.finiteDimensional
#check @Subfield.closure_mono
#check @RingOfIntegers.mapRingHom
#check @ZMod.natCast_self_eq_zero
#check @Nat.card_congr
#check @Nat.card_zmod
#check @isIntegral_algebraMap_iff
#check @Polynomial.X_sub_C_mul_X_sub_C
#check @Polynomial.Splits.mul
#check @Polynomial.Splits.X_sub_C
#check @Polynomial.splits_X_sub_C
#check @IsIntegral.of_pow
#check @Real.sq_sqrt
#check @IsIntegral.sqrt
example (K : Type*) [Field K] (V : ValuationSubring K) : IsIntegrallyClosed V := inferInstance
example (p : ℕ) [Fact p.Prime] : IsIntegrallyClosed ℤ_[p] := inferInstance
example (p : ℕ) [Fact p.Prime] : IsFractionRing ℤ_[p] ℚ_[p] := inferInstance
example (p : ℕ) [Fact p.Prime] : Algebra ℤ_[p] ℚ_[p] := inferInstance
example : Finite ({11} : Set ℕ) := inferInstance
example : Finite ({3, 11, 5} : Set ℕ) := inferInstance
example (K : Type*) [Field K] : Algebra ℤ K := inferInstance
