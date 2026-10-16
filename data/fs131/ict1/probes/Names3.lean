import Proofs.HadwigerNelson.CayleyThree.Circular
open HadwigerNelson
#check @continuous_finsetSum
example (t : Fin 3 → ℝ) : Continuous (fun u : Fin 3 → ℝ => ∑ l, t l * u l) := by fun_prop
#check @Filter.Tendsto.div
#check @ContinuousAt.tendsto
#check @Finset.sum_div
#check @mul_div_cancel_right₀
