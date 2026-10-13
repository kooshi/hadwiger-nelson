import Proofs.HadwigerNelson.SpectralChain
import Mathlib.NumberTheory.Real.Irrational
#check @Odd.of_dvd_nat
#check @Rat.den_dvd
#check @Rat.den_intCast
#check @Rat.cast_intCast
#check @ZMod.natCast_eq_zero_iff_even
#check @ZMod.intCast_zmod_eq_zero_iff_dvd
#check @ZMod.intCast_eq_intCast_iff_dvd_sub
#check @AddMonoidHom.addSubgroupComap
#check @AddSubgroup.coe_zsmul
#check @AddSubgroup.inclusion
#check @Nat.card_zmod
#check @SimpleGraph.Embedding.toHom
#check @Nat.not_even_iff_odd
#check @Int.not_even_iff_odd
#check @AddEquiv.symm_apply_eq
#check @AddSubgroup.coe_equivMapOfInjective_apply
#check @injective_iff_map_eq_zero
#check @Rat.neg_den
#check @Rat.den_zero
#check @AddMonoidHom.mk'_apply
#check @Squarefree
#check @ZMod.intCast_cast
#check @Int.odd_iff
example : (1 : ZMod 2) ≠ 0 := by decide
#synth Field (ZMod 2)
