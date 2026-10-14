import Proofs.HadwigerNelson.Plane.OneClass.Pair
open MeasureTheory Filter Set
open HadwigerNelson.OneClass HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral
example (x y : E) : ((x + y : E) : ℂ) = (x : ℂ) + y := by push_cast; rfl
example (x y : E) : ((x * y : E) : ℂ) = (x : ℂ) * y := by push_cast; rfl
example (x y : E) : ((x - y : E) : ℂ) = (x : ℂ) - y := by push_cast; rfl
example (r : ℝ) : algebraMap ℝ ℂ r = (r : ℂ) := rfl
#check @measurable_to_bool
#check @measurableSet_eq_fun
#check @Prod.discreteTopology
example (Λ : Type) [TopologicalSpace Λ] [DiscreteTopology Λ] : DiscreteTopology (Λ × Λ) := inferInstance
#check @MeasurableSpace.measurableSet_top
#check @mem_algebraicClosure_iff
#check @measure_eq_zero_iff_ae_notMem
