import Proofs.HadwigerNelson.Plane.DensityBound.Pattern
import Proofs.HadwigerNelson.Plane.OneAvoidingDensity
open MeasureTheory Real Complex Set Filter
#check @Complex.volume_ball
#check @Complex.orthonormalBasisOneI
#check @LinearIsometryEquiv.measurePreserving
#check @NullMeasurableSet.exists_measurable_subset_ae_eq
#check @List.sum_ofFn
#check @Fin.sum_univ_get
#check @Fin.sum_univ_getElem
#check @List.sum_map_ofFn
#check @Filter.limsup_le_limsup
#check @Filter.Tendsto.limsup_eq
#check @ENNReal.tendsto_ofReal
#check @Fintype.sum_option
#check @MeasurePreserving.measure_preimage_emb
#check @LinearIsometryEquiv.preimage_ball
#check @ae_eq_set_inter
#check @measure_congr
#check @ENNReal.ofReal_div_of_pos
#check @Filter.limsup_le_of_le
#check @EuclideanSpace.volume_ball
example : FiniteDimensional ℝ ℂ := inferInstance
#synth FiniteDimensional ℝ ℂ
