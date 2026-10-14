import Mathlib.Topology.Algebra.Group.Quotient
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.MeasureTheory.Measure.Count
import Mathlib.Logic.Equiv.Fin.Basic
open MeasureTheory
example : TopologicalSpace (Fin 4) := inferInstance
example : DiscreteTopology (Fin 4) := inferInstance
example : IsTopologicalAddGroup (Fin 4) := inferInstance
example : CompactSpace (Fin 4) := inferInstance
example : T2Space (Fin 4) := inferInstance
example : BorelSpace (Fin 4) := inferInstance
example : MeasurableSingletonClass (Fin 4) := inferInstance
example : ((AddSubgroup.zmultiples (2 : Fin 4) : Set (Fin 4))).Finite := Set.toFinite _
example : AddSubgroup.zmultiples (2 : Fin 4) ≠ ⊥ := by
  intro h
  have : (2 : Fin 4) ∈ AddSubgroup.zmultiples (2 : Fin 4) := AddSubgroup.mem_zmultiples 2
  rw [h, AddSubgroup.mem_bot] at this
  exact absurd this (by decide)
example : finFunctionFinEquiv (![0, 1] : Fin 2 → Fin 2) = 2 := by decide
