import Proofs.HadwigerNelson.Plane.OneClass.Defs
open MeasureTheory Filter Set
open scoped ENNReal Topology
open HadwigerNelson.Outside.OAI158
#check @Algebraic.countable
#check (inferInstance : Countable (Polynomial ℚ))
#check @Polynomial.rootSet_finite
#check @NullMeasurableSet.exists_measurable_subset_ae_eq
#check @ENNReal.inv_iInf
#check @ENNReal.inv_div
#check @Finset.exists_le_card_fiber_of_nsmul_le_card_of_maps_to
#check @Finset.exists_lt_card_fiber_of_mul_lt_card_of_maps_to
#check @Finset.card_eq_sum_card_fiberwise
#check @ae_dirac_iff
#check @Measure.ae_dirac_iff
#check @ae_dirac_eq
#check @kCoeff
#print kCoeff
#print K
#check @SimpleGraph.exists_isNIndepSet_indepNum
#check @measure_congr
#check @MeasureTheory.measure_congr
#check @Fintype.card_coe
#check @SimpleGraph.Embedding.map_adj_iff
#check @Subtype.dist_eq
#check @Circle.coe_mul
#check @Measure.map_dirac
#check @Measure.map_dirac'
#check @MeasurePreserving.mk
#check @IsProbabilityMeasure
#check @measurable_pi_lambda
example : MeasurableSpace (E → Bool) := inferInstance
#check @MeasurableSingletonClass
#synth Countable E
