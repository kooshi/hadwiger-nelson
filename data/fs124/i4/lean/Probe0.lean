import Proofs.HadwigerNelson.Plane.ClosePair
open Complex Set MeasureTheory Metric Topology
#check @Homeomorph.isOpen_image
#check @IsPreconnected.image
#check @Homeomorph.image_closure
#check @IsOpenMap.image_mem_nhds
#check @Homeomorph.mulLeft₀
#check @Homeomorph.addLeft
#check @MeasureTheory.Measure.QuasiMeasurePreserving.ae
#check @MeasureTheory.Measure.QuasiMeasurePreserving.preimage_null
#check @measurePreserving_add_left
#check @MeasurePreserving.comp
#check @MeasurePreserving.id
#check @IsPreconnected.subset_connectedComponentIn
#check @IsPreconnected.subset_left_of_subset_union
#check @isPreconnected_connectedComponentIn
#check @isPreconnected_of_forall
#check @IsPreconnected.union
#check @Measure.addHaar_sphere
#check @Measurable.ite
#check @connectedComponentIn_subset
#check @mem_connectedComponentIn
#check @Homeomorph.image_connectedComponentIn
#check @Equiv.image_eq_preimage_symm
#check @Homeomorph.image_eq_preimage_symm
#check @LinearIsometryEquiv.measurePreserving
#check @Complex.abs_re_le_norm
#check @Complex.sq_norm
#check @Complex.normSq_apply
#check @sq_norm_eq
#check @convex_segment
#check @Complex.continuous_ofReal
#check @Real.continuous_sqrt
#check @Real.sq_sqrt
#check @Real.sqrt_nonneg
example : (Homeomorph.refl ℂ : ℂ → ℂ) = id := rfl
example (a u : ℂ) (hu : u ≠ 0) (z : ℂ) : ((Homeomorph.mulLeft₀ u hu).trans (Homeomorph.addLeft a)) z = a + u * z := rfl
example (a u : ℂ) (hu : u ≠ 0) (z : ℂ) : ((Homeomorph.mulLeft₀ u hu).trans (Homeomorph.addLeft a)).symm z = u⁻¹ * (-a + z) := rfl
