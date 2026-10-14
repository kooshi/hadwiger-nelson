import Proofs.HadwigerNelson.Plane.DensityBound.Bessel
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
import Mathlib.MeasureTheory.Integral.PeakFunction
import Mathlib.MeasureTheory.Measure.ContinuousPreimage
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex
import Mathlib.Analysis.Fourier.Inversion
open MeasureTheory Real Complex
open scoped FourierTransform RealInnerProductSpace
#check @Real.tendsto_integral_gaussian_smul'
#check @VectorFourier.integral_fourierIntegral_smul_eq_flip
#check @fourier_gaussian_innerProductSpace'
#check @Real.fourierIntegral
#check @Real.fourier_eq
#check @Real.fourierIntegral_eq
#check @FourierTransform.fourier
#check @Real.fourierChar_apply
#check @MeasureTheory.integral_indicator_one
#check @MeasureTheory.intervalIntegral_integral_swap
#check @MeasureTheory.integral_integral_swap
#check @tendsto_measure_symmDiff_preimage_nhds_zero
#check @Real.continuous_fourierIntegral
#check @VectorFourier.fourierIntegral_continuous
#check @MeasureTheory.Integrable.prod_mul
#check @integral_complex_ofReal
#check @intervalIntegral.tendsto_integral_filter_of_dominated_convergence
#check @MeasureTheory.measure_preimage_add_right
#check @MeasureTheory.Integrable.integrable_prod_iff
#check @Real.circleAverage_eq_intervalAverage
#check @Real.fourier_real_eq
example : FiniteDimensional ℝ ℂ := inferInstance
#synth FiniteDimensional ℝ ℂ
