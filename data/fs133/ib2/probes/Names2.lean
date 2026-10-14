import Proofs.HadwigerNelson.Plane.OneClass.Defs
open MeasureTheory Filter Set
open scoped ENNReal Topology
open HadwigerNelson.Outside.OAI158.Spectral
#synth Countable (List ℚ)
#synth Countable (ℕ →₀ ℚ)
#synth Encodable ℚ
#check @Polynomial.toFinsupp_injective
#check @minpoly.aeval
#check @Polynomial.mem_rootSet
#check @IsAlgebraic
#check @mem_algebraicClosure_iff
#check @Set.Countable.biUnion
#check @Set.countable_iUnion
#check @Pi.instMeasurableSingletonClass
#check @MeasurableSet.iUnion
#check @Polynomial.coeffList
#check @Polynomial.card_support_le_one_iff_monomial
#print kCoeff
#print K
#check @Finset.exists_max_image
#check @SimpleGraph.Colorable
#print SimpleGraph.Colorable
#check @ENNReal.mul_le_of_le_div
#check @ENNReal.inv_mul_le_iff
#check @ENNReal.le_div_iff_mul_le
#check @ENNReal.div_le_div_right
#check @ENNReal.div_le_div_left
#check @Finset.sum_lt_sum_of_nonempty
#check @isProbabilityMeasure_dirac
example : IsProbabilityMeasure (Measure.dirac (fun _ : E => false)) := inferInstance
