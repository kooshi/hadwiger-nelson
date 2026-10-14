import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Plane.OneAvoidingDensity
import Proofs.HadwigerNelson.Plane.DensityPoints

open HadwigerNelson HadwigerNelson.Rigidity HadwigerNelson.SpectralChain MeasureTheory

set_option pp.proofs false
#print SpectralChain.Interface.Count
#print SpectralChain.Interface.R88TCA
#print SpectralChain.TCA
#print SpectralChain.IsTraceSpectral
#print SpectralChain.InvariantColouring

/-- The count, unfolded at the chain's interface: the kernel accepts the restatement by `Iff.rfl`. -/
example (F : Subfield ℝ) [NumberField F] : (chainInterface F).Count ↔
    (TCA F → ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ → σ (TA F)ᶜ ≠ 0) :=
  Iff.rfl

#check @tca_uniform
#check @Plane.mOne_lt_quarter
#check @Plane.dist_ne_one_of_mem_densitySet
#check @TA_subset_contChars
#check @isCountablyGenerated_nhds_tauPrime
#check @exists_mul_stableIntegers_le
#check @dense_mixedEmbedding_nsmul_unitRing
#check @noRamifiedStableDyadic_of_tca
#check @StablePrime.residue
#check @UpperHalf.residue_conj
#check @UpperHalf.mem_localRing_of_mul_conj_eq_one
-- Mathlib at the pin
#check @MeasureTheory.measure_limsup_atTop_eq_zero
#check @measurable_find
#check @MeasureTheory.Measure.addHaarMeasure
#check @MeasureTheory.tendsto_integral_filter_of_dominated_convergence
#check @IsDedekindDomain.exists_forall_sub_mem_ideal
#check @Ideal.finite_setOf_absNorm_le
#check @MeasurableSet.exists_isOpen_diff_lt
#check @MeasurableSet.exists_isCompact_diff_lt
#check @NumberField.mixedEmbedding.latticeBasis
#check @Complex.exp_log
#check @MeasureTheory.Measure.prod_apply
#check @MeasureTheory.lintegral_prod
#check @Nat.find
#check @Filter.HasBasis.tendsto_left_iff
#check @Real.arctan
