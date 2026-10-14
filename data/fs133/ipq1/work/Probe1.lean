import Proofs.HadwigerNelson.Plane.OneClass.Pair
open MeasureTheory Filter Set
open HadwigerNelson.OneClass HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral
#check @exists_invariant_of_closed
#check @exists_field
#check @norm_kCoeff_mul
#check @Measure.QuasiMeasurePreserving.ae
#check @Measure.quasiMeasurePreserving_fst
#check @measurable_of_countable
#check @measurable_of_finite
#check @Measure.measure_ae_null_of_prod_null
#check @Measure.prod_apply_symm
#check @Measure.prod_swap
#check @IsAlgebraic.algebraMap
#check @isAlgebraic_algebraMap_iff
#check @Finset.rado_selection
#check @HadwigerNelson.exists_translate_mem
#check @HadwigerNelson.ae_hasDensityOneAt_fibre
#check @Besicovitch.ae_tendsto_measure_inter_div
#check @Measure.addHaar_closedBall
#check @exists_angle_of_norm_eq_one
#check @exists_interval_near
#check @norm_e_sub_e_le
#check @Filter.Eventually.exists
example : MeasurableSingletonClass (Fin 3 → Bool) := inferInstance
#check @ae_all_iff
#check @Set.Countable.to_subtype
#check @measure_preimage_add_right
#check @Measure.measure_prod_null
