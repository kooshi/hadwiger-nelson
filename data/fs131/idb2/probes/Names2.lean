import Proofs.HadwigerNelson.Plane.DensityBound.Bessel
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
import Mathlib.MeasureTheory.Integral.PeakFunction
import Mathlib.MeasureTheory.Measure.ContinuousPreimage
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex
import Mathlib.Analysis.Fourier.Inversion
open MeasureTheory Real Complex
open scoped FourierTransform RealInnerProductSpace
#check @GaussianFourier.integrable_rexp_neg_mul_sq_norm
#check @integrable_rexp_neg_mul_sq_norm
#check @Bornology.IsBounded.measure_lt_top
#check @Bornology.IsBounded.subset_closedBall
#check @ContinuousLinearMap.circleAverage_comp_comm
#check @Metric.sphere_zero
#check @integral_indicator_const
#check @integral_add_left_eq_self
#check @integral_conj
#check @Complex.conj_mul'
#check @Complex.norm_exp_ofReal_mul_I
#check @integrable_prod_iff
#check @MeasureTheory.AEStronglyMeasurable.snd
#check @continuous_of_dominated
#check @ContinuousMap.curry
#check @measurePreserving_add_right
#check @HasCompactSupport.intro
#check @Continuous.integrable_of_hasCompactSupport
#check @Integrable.ofReal
#check @integrable_indicator_iff
#check @Complex.exp_conj
#check @integral_finset_sum
#check @measureReal_union_le
#check @measureReal_mono
#check @innerₗ
example (E : Set ℂ) (hE : MeasurableSet E) : (MeasureTheory.volume : Measure ℂ).InnerRegularCompactLTTop := inferInstance
