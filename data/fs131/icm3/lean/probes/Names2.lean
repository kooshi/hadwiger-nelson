import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Data.ZMod.Basic
#check @List.sum_toFinset
#check @Complex.div_natCast_re
#check @Complex.re_sum
#check @Complex.abs_re_le_norm
#check @Complex.norm_real
#check @Complex.norm_I
#check @ZMod.val_injective
#check @ZMod.val_lt
#check @ZMod.natCast_zmod_val
#check @ZMod.val_cast_of_lt
#check @Finset.sum_image
#check @Finset.sum_product
#check @Complex.I_pow_four
#check @Rat.cast_abs
#check @Int.cast_sum
example : (Nat.cast : ℕ → ℚ) 5 = 5 := rfl
#print Rat.instNatCast
#synth Pow ℚ ℕ
