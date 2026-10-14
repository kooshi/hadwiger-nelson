import Proofs.HadwigerNelson.Plane.DensityBound.Autocorr
open MeasureTheory Real Complex Set
#check @Function.Periodic.lift
#check @Function.Periodic.lift_coe
#check @lintegral_add_left_eq_self
#check @Complex.norm_mul_exp_arg_mul_I
#check @Complex.exp_two_pi_mul_I
#check @measure_biUnion_finset
#check @lintegral_finset_sum
#check @lintegral_finsetSum
#check @ofReal_integral_eq_lintegral_ofReal
#check @Real.circleAverage_eq_integral_add
#check @setLIntegral_const
#check @ENNReal.toReal_sum
#check @Finset.sum_boole_mul
#check @Complex.norm_conj
#check @Fintype.sum_bool
example : (volume : Measure (AddCircle (2 * π))).IsAddLeftInvariant := by
  haveI : Fact (0 < 2 * π) := ⟨by positivity⟩; infer_instance
