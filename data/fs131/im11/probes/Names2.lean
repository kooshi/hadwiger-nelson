import Proofs.HadwigerNelson.Rigidity.SpectralSubspace
open MeasureTheory
#check @HadwigerNelson.SpectralInputs.coe_char_sub
#check @measureReal_eq_zero_iff
#check @Real.le_sqrt
#check @add_sub_cancel
#check @Finsupp.apply_linearCombination
#check @Complex.mul_conj
#check @Complex.normSq_eq_norm_sq
#check @integral_complex_ofReal
#check @integral_ofReal
#check @Finsupp.mem_supported
#check @Finsupp.support_mapRange
#check @Measure.restrict_eq_zero
#check @ae_iff
#check @Lp.compMeasurePreservingₗ_apply
#check @integral_add_measure
#check @inner_add_right
#check @map_finsuppSum
#check @Complex.ofReal_injective
#check @integral_const_mul
#check @Complex.re_ofReal_mul
#check @HadwigerNelson.SpectralInputs.compMeasurePreserving_add
#check @HadwigerNelson.SpectralInputs.integral_mul_comp_eq_inner
#check @HadwigerNelson.SpectralInputs.measurable_evalChar
#check @MeasureTheory.ae_restrict_iff'
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} (f : Ω → Ω) (hf : MeasurePreserving f μ μ) (g : Lp ℝ 2 μ) :
    Lp.compMeasurePreservingₗᵢ ℝ f hf g = Lp.compMeasurePreserving f hf g := rfl
