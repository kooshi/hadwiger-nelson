import Proofs.HadwigerNelson.Plane.DensityBound.BesselDefect
open Real
set_option pp.all true in
#check fun a b : ℤ => (a + b * a, a / b, decide (a ≤ b), (2:ℤ) ^ 3)
#check @Int.ediv_mul_le
#check @Complex.norm_le_abs_re_add_abs_im
#check @Complex.abs_re_le_norm
#check @HasDerivAt.ofReal_comp
#check @Complex.mk_eq_add_mul_I
#check @Nat.cast_natAbs
#check @Int.cast_natAbs
#check @Int.natCast_natAbs
#check @List.forall₂_cons
#check @List.Forall₂
#check @HasDerivAt.const_add
#check @HasDerivAt.mul
#check @hasDerivAt_id
#check @List.getD
#check @Int.lt_ediv_add_one_mul_self
#check @abs_sub_abs_le_abs_sub
#check @norm_sub_le
#check @norm_sub_norm_le
#check @Complex.ext_iff
#check @HasDerivAt.comp_sub_const
