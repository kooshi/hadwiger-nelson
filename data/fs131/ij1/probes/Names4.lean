import Proofs.HadwigerNelson.SpectralChain
import Mathlib.MeasureTheory.Measure.Prokhorov
open MeasureTheory HadwigerNelson SpectralChain
variable (F : Subfield ℝ) [Countable (unitRing F)]
example : BorelSpace (unitRing F → Fin 4) := inferInstance
example : CompactSpace (unitRing F → Fin 4) := inferInstance
example : TopologicalSpace.PseudoMetrizableSpace (unitRing F → Fin 4) := inferInstance
example (K : Set (unitRing F → Fin 4)) : BorelSpace K := inferInstance
example (K : Set (unitRing F → Fin 4)) : HasOuterApproxClosed K := inferInstance
#check @FiniteMeasure.ext_of_forall_integral_eq
#check @MeasureTheory.ext_of_forall_integral_eq_of_IsFiniteMeasure
#check @FiniteMeasure.continuous_map
#check @Measure.map_dirac
#check @MeasureTheory.integral_dirac
#check @MeasureTheory.integral_finset_sum_measure
#check @MeasureTheory.integral_smul_measure
#check @Measure.map_map
