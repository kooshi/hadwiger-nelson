import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Mathlib
/-! FS131-KN7, stage 2, probe (expected to FAIL at the first example): with every field of `IsSolenoid X` made an
instance, the library and Mathlib's instances do not give metrizability (hence no `PolishSpace X`). The second example is the
partner that must pass: with second countability added, they do. -/
open HadwigerNelson.Rigidity
example {X : Type*} [AddCommGroup X] [TopologicalSpace X] (hX : IsSolenoid X) : TopologicalSpace.MetrizableSpace X := by
  haveI := hX.isTopologicalAddGroup; haveI := hX.t2Space; haveI := hX.compactSpace; haveI := hX.connectedSpace
  exact inferInstance
example {X : Type*} [AddCommGroup X] [TopologicalSpace X] (hX : IsSolenoid X) [SecondCountableTopology X] :
    TopologicalSpace.MetrizableSpace X := by
  haveI := hX.isTopologicalAddGroup; haveI := hX.t2Space; haveI := hX.compactSpace; haveI := hX.connectedSpace
  exact inferInstance
