import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.MeasureTheory.Measure.Portmanteau

open MeasureTheory HadwigerNelson SpectralChain

variable (F : Subfield ℝ) [Countable (unitRing F)]

#synth BorelSpace (unitRing F → Fin 4)
#synth HasOuterApproxClosed (unitRing F → Fin 4)
#synth CompactSpace (unitRing F → Fin 4)
#synth T2Space (unitRing F → Fin 4)
#synth CompactSpace (ProbabilityMeasure (unitRing F → Fin 4))
#check @ProbabilityMeasure.limsup_measure_closed_le_of_tendsto
#check @ProbabilityMeasure.tendsto_iff_forall_integral_tendsto
#check @ext_of_forall_integral_eq_of_IsFiniteMeasure
#check @integral_finsetSum_measure
#check @Measure.coe_finsetSum
#check @prob_compl_eq_zero_iff
#check @isClosed_iff_forall_filter
#check @IsCompact.inter_iInter_nonempty
#check @isCompact_univ.ultrafilter_le_nhds
#check @Finset.sum_range_sub
#check @tendsto_one_div_add_atTop_nhds_zero_nat
