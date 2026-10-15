import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Mathlib.MeasureTheory.Constructions.Polish.Basic

/-! FS131-KN7, stage 2: the declared statement `positive_entropy_rigidity` read from the kernel's side, and the three facts
the finding on its σ-algebra rests on. Elaborated against the built tree; nothing here is a module of the library. -/

open HadwigerNelson HadwigerNelson.Rigidity

-- (A0) The stored type, as the last planner printed it (default options), for the comparison with its print.
#check @positive_entropy_rigidity
#check @haar_or_zero_entropy

open MeasureTheory

-- (A) The stored type, every implicit and instance argument shown.
set_option pp.explicit true in
#check @positive_entropy_rigidity

-- (B) Every constant the stored type mentions, and the measurable-space instances on a quotient among them.
open Lean Elab Command in
run_cmd do
  let some ci := (← getEnv).find? ``HadwigerNelson.Rigidity.positive_entropy_rigidity | throwError "absent"
  let cs := ci.type.getUsedConstants.toList.map toString |>.toArray.qsort (· < ·)
  logInfo m!"constants={cs.size}"
  for c in cs do logInfo m!"CONST {c}"

-- (C1) The σ-algebra the statement puts on `X ⧸ G` is the quotient σ-algebra: the sets whose preimage is measurable.
example {X : Type*} [AddCommGroup X] [MeasurableSpace X] (G : AddSubgroup X) :
    (inferInstance : MeasurableSpace (X ⧸ G)) = MeasurableSpace.map (QuotientAddGroup.mk' G) ‹MeasurableSpace X› :=
  rfl

-- (C2) It contains the Borel σ-algebra of the quotient group, for every topological group with Borel sets.
theorem kn7_borel_le_quotient {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    (G : AddSubgroup X) : borel (X ⧸ G) ≤ QuotientAddGroup.measurableSpace G := by
  have h : @Measurable X (X ⧸ G) _ (borel (X ⧸ G)) (QuotientAddGroup.mk' G) :=
    (QuotientAddGroup.continuous_mk (N := G)).borel_measurable.mono OpensMeasurableSpace.borel_le le_rfl
  exact MeasurableSpace.comap_le_iff_le_map.mp h.comap_le

-- (C3) And it is the Borel σ-algebra when `X` is Polish and `G` closed (Mathlib's `QuotientAddGroup.borelSpace`).
example {X : Type*} [AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X] [PolishSpace X] [MeasurableSpace X]
    [BorelSpace X] (G : AddSubgroup X) [IsClosed (G : Set X)] :
    QuotientAddGroup.measurableSpace G = borel (X ⧸ G) :=
  BorelSpace.measurable_eq

-- (D) Nothing in the library gives `PolishSpace X` from `IsSolenoid X`: this must fail to synthesize.
-- example {X : Type*} [AddCommGroup X] [TopologicalSpace X] (hX : IsSolenoid X) : PolishSpace X := inferInstance

#print axioms kn7_borel_le_quotient
