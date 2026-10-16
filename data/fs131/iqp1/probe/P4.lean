import Proofs.HadwigerNelson.PadicPlane.Measure
open MeasureTheory HadwigerNelson
#check @hensels_lemma
#check @nonempty_inter_of_measure_lt_add
#check @measure_preimage_add
#check @sum_measure_preimage_singleton
#check @Measure.addHaarMeasure_self
#check @TopologicalSpace.PositiveCompacts.coe_top
#check @MeasurableSet.exists_isCompact_sdiff_lt
#check @MeasurableSet.exists_isOpen_sdiff_lt
#check @IsCompact.elim_nhds_subcover
#check @unitQuadrance.map
#check @PadicInt.norm_le_pow_iff_mem_span_pow
#check @PadicInt.ker_toZModPow
#check @PadicInt.cast_toZModPow
#check @measure_biUnion_finset
#check @measure_biUnion_finset_le
#check @ENNReal.le_of_forall_pos_le_add
#check @measure_inter_add_diff
#check @measure_iUnion_fintype_le
#check @measurable_generateFrom
#check @ENNReal.one_le_ofReal
example (p : ℕ) [Fact p.Prime] : MeasureTheory.Measure.IsAddHaarMeasure (PadicPlane.haar p) := by unfold PadicPlane.haar; infer_instance
example (p : ℕ) [Fact p.Prime] : BorelSpace (ℤ_[p] × ℤ_[p]) := by infer_instance
