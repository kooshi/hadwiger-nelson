import Proofs.HadwigerNelson.Rigidity.TateKernel
open NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum
#check @Circle.exp_eq_one
#check @NumberField.mixedEmbedding_injective
#check @HeightOneSpectrum.valuation_of_algebraMap
#check @HeightOneSpectrum.intValuation_le_one
#check @RestrictedProduct.ext
#check @ZSpan.fract_mem_fundamentalDomain
#check @ZSpan.fundamentalDomain_isBounded
#check @ZSpan.floor
#check @ZSpan.fract_apply
#check @NumberField.mixedEmbedding.latticeBasis_apply
#check @Metric.isCompact_of_isClosed_isBounded
#check @Bornology.IsBounded.isCompact_closure
#check @IsCompact.prod
#check @RestrictedProduct.exists_structureMap_eq_of_forall
#check @RestrictedProduct.isEmbedding_structureMap
#check @AddChar.map_sub_eq_div
#check @Subring.natCast_mem
#check @Algebra.trace_algebraMap
#check @Module.finrank_pos
#check @mem_adicCompletionIntegers
#check @valuedAdicCompletion_eq_valuation'
#check @adicCompletion.coe_mul
#check @Real.pi_ne_zero
example (F : Subfield ℝ) [NumberField F] : T2Space (SpectralChain.Dual F) := by
  open HadwigerNelson.Rigidity in infer_instance
example (F : Subfield ℝ) [NumberField F] : Countable (SpectralChain.unitRing F) := inferInstance
example (F : Subfield ℝ) [NumberField F] : ProperSpace (mixedEmbedding.mixedSpace (SpectralChain.fieldI F)) := inferInstance
