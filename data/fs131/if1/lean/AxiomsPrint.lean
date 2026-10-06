import Proofs.HadwigerNelson.Plane.MetricalBoundary

/-! FS131-IF1: the axioms of the new module's theorems, with a planted control. Read by `tools/fs131_if1_axioms_check.py`,
which requires every record above the control banner to be a subset of the standard three and the control to print
`sorryAx` — the same predicate, seen to fire. Iteration evidence only; the gate's receipt is `scripts/axioms.sh`. -/

set_option pp.fullNames true

#eval IO.println "=== IF1 RECORDS ==="
#print axioms HadwigerNelson.Plane.measure_inter_closedBall_le_add
#print axioms HadwigerNelson.Plane.tendsto_measure_closedBall_sub
#print axioms HadwigerNelson.Plane.continuous_measure_inter_closedBall
#print axioms HadwigerNelson.Plane.measure_inter_closedBall_div_add_compl
#print axioms HadwigerNelson.Plane.measure_compl_inter_closedBall_div_eq_half
#print axioms HadwigerNelson.Plane.exists_mem_ball_tendsto_ratio
#print axioms HadwigerNelson.Plane.measure_inter_ball_ne_zero_of_ratio_eq_half
#print axioms HadwigerNelson.Plane.exists_closedBall_ratio_eq_half
#print axioms HadwigerNelson.Plane.exists_closedBall_subset_ratio_eq_half
#print axioms HadwigerNelson.Plane.exists_closedBall_ratio_eq_half_of_measure_ne_zero
#print axioms HadwigerNelson.Plane.exists_nested_closedBalls_ratio_eq_half
#print axioms HadwigerNelson.Plane.ratio_two_mul_ge
#print axioms HadwigerNelson.Plane.exists_ratio_ge_and_compl_ge
#print axioms HadwigerNelson.Plane.not_tendsto_ratio_compl_of_ratio_ge
#print axioms HadwigerNelson.Plane.exists_not_tendsto_ratio_and_compl

#eval IO.println "=== IF1 CONTROL ==="
/-- Planted: rests on `sorry`, so its record must print `sorryAx`. -/
theorem if1_control_sorry : (1 : ℕ) = 1 := sorry
#print axioms if1_control_sorry
