import Mathlib.MeasureTheory.Covering.BesicovitchVectorSpace
import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex
import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace
import Mathlib.LinearAlgebra.Complex.FiniteDimensional
import Mathlib.Analysis.Normed.Module.Convex
import Mathlib.Topology.Order.IntermediateValue

open MeasureTheory Metric Set Filter Topology

#check @Besicovitch.ae_tendsto_measure_inter_div
#check @MeasureTheory.Measure.addHaar_closedBall
#check @MeasureTheory.Measure.addHaar_closedBall'
#check @MeasureTheory.Measure.addHaar_closedBall_center
#check @MeasureTheory.Measure.addHaar_sphere
#check @MeasureTheory.Measure.addHaar_closedBall_mul
#check @MeasureTheory.measure_inter_add_diff₀
#check @IsPreconnected.intermediate_value
#check @convex_closedBall
#check @Convex.isPreconnected
#check @ENNReal.tendsto_nhds
#check @IsCompact.nonempty_iInter_of_sequence_nonempty_isCompact_isClosed
#check @MeasureTheory.exists_mem_of_measure_ne_zero_of_ae
#check @Metric.closedBall_subset_closedBall'
#check @MeasureTheory.ae_restrict_of_ae_restrict_of_subset
#check @MeasureTheory.measure_diff
#check @ENNReal.Tendsto.sub
#check @Metric.ball_union_sphere
#check @MeasureTheory.Measure.restrict_apply

example : (volume : Measure ℂ).IsAddHaarMeasure := inferInstance
example : FiniteDimensional ℝ ℂ := inferInstance
example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E] : HasBesicovitchCovering E := inferInstance
example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E] : ProperSpace E := inferInstance
example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E] : SecondCountableTopology E := inferInstance
