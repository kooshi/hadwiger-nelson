import Proofs.HadwigerNelson.Rigidity.HaarMultiple
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
open MeasureTheory
-- `map_sub_maxMultiple`'s hypotheses, at the identity:
example : (Measure.dirac () : Measure Unit).map (MeasurableEquiv.refl Unit) = Measure.dirac () := Measure.map_id
-- `rpow_mul_exp_le_exp`'s hypotheses, non-degenerate:
example : (1 : ℝ) ≤ 2 ∧ (0 : ℝ) ≤ 1 / 8 ∧ 1 / 8 * Real.log (2 * 2) ≤ Real.log 4 / 8 ∧ (0 : ℝ) ≤ 16 ∧
    (2 : ℝ) ≤ 1 / 8 * 16 := by
  refine ⟨by norm_num, by norm_num, ?_, by norm_num, by norm_num⟩
  norm_num
  linarith
