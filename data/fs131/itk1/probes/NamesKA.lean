import Proofs.HadwigerNelson.Rigidity.PlaceSizes
open NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum
#check @mixedEmbedding.normAtPlace_apply
#check @mixedEmbedding.normAtPlace_add_le
#check @mixedEmbedding.normAtPlace_neg
#check @mixedEmbedding.normAtPlace_nonneg
#check @mixedEmbedding.continuous_normAtPlace
#check @FinitePlace.norm_def
#check @FinitePlace.norm_embedding
#check @WithZeroMulInt.toNNReal_le_one_iff
#check @WithZeroMulInt.toNNReal_strictMono
#check @RestrictedProduct.continuous_eval
#check @HeightOneSpectrum.Support.finite
#check @finprod_eq_prod_of_mulSupport_subset
#check @Finset.one_le_prod'
#check @Finset.prod_le_prod_of_subset_of_one_le'
#check @FinitePlace.prod_eq_inv_abs_norm
#check @InfinitePlace.prod_eq_abs_norm
#check @NumberField.prod_abs_eq_one
#check @FinitePlace.equivHeightOneSpectrum_symm_apply
#check @FinitePlace.hasFiniteMulSupport
#check @NumberField.InfinitePlace.sum_mult_eq
#check @NumberField.Embeddings.pow_eq_one_of_norm_eq_one
#check @NumberField.InfinitePlace.comap_apply
#check @NumberField.mem_integers_of_valuation_le_one
#check @Ideal.finite_setOf_absNorm_eq
#check @FinitePlace.norm_lt_one_iff_mem
#check @FinitePlace.norm_eq_one_iff_notMem
#check @FinitePlace.norm_le_one
#check @adicAbv_natCast_le_one
#check @HeightOneSpectrum.adicAbv_def
#check @InfinitePlace.one_le_mult
example (F : Subfield ℝ) [NumberField F] (w : HadwigerNelson.Rigidity.SplitPlace F) :
    IsUltrametricDist (w.1.adicCompletion (HadwigerNelson.SpectralChain.fieldI F)) := inferInstance
example (F : Subfield ℝ) [NumberField F] (w : HadwigerNelson.Rigidity.SplitPlace F) (a b : (w.1.adicCompletion (HadwigerNelson.SpectralChain.fieldI F))) :
    ‖a + b‖ ≤ max ‖a‖ ‖b‖ := IsUltrametricDist.norm_add_le_max a b
