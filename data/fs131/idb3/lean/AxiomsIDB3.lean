import Proofs.HadwigerNelson.Plane.DensityBound.Theorem
/-!
FS131-IDB3 — the axioms of every public declaration of this job's modules, from the built tree (read-only).

For each constant stored in the compiled data of the modules below that is not an internal name (private helpers are
read through the records that use them), prints `REC <module> <kind> <name> <axioms>` with the axioms as
`Lean.collectAxioms` computes them (transitively, through every constant the proof names). Two planted records follow,
`FS131IDB3Plant.withSorry` (a `sorry`) and `FS131IDB3Plant.withNative` (a `native_decide`), printed as `PLANT …`: the
reader `tools/fs131_idb3_axioms.py` must find `sorryAx` in the first and a native axiom in the second, or it fails.
Run: `lake env lean data/fs131/idb3/lean/AxiomsIDB3.lean > data/fs131/idb3/axioms.txt`.
-/
open Lean Elab Command

namespace FS131IDB3Plant
theorem withSorry : (1 : Nat) = 1 := by sorry
theorem withNative : (2 : Nat) + 2 = 4 := by native_decide
end FS131IDB3Plant

namespace FS131IDB3Axioms

def mods : List Name :=
  [`Proofs.HadwigerNelson.Plane.DensityBound.X23Check,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Data,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong00,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong01,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong02,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong03,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong04,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong05,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong06,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Cong07,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms00,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms01,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms02,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms03,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms04,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms05,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms06,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms07,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms08,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms09,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms10,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms11,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Atoms12,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23All,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23,
   `Proofs.HadwigerNelson.Plane.DensityBound.X23Dist,
   `Proofs.HadwigerNelson.Plane.DensityBound.Theorem]

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

elab "#idb3_axioms" : command => do
  let env ← getEnv
  for m in mods do
    let some i := env.header.moduleNames.findIdx? (· == m)
      | throwError "module {m} is not imported"
    let d := env.header.moduleData[i]!
    IO.println s!"MODULE {m} {d.constants.size}"
    for ci in d.constants do
      if ci.name.isInternalDetail then continue
      let axs ← liftCoreM <| Lean.collectAxioms ci.name
      IO.println s!"REC {m} {kindOf ci} {ci.name} {axs.toList}"
  let axs ← liftCoreM <| Lean.collectAxioms ``HadwigerNelson.Plane.oneAvoidingDensityBound
  IO.println s!"THEOREM HadwigerNelson.Plane.oneAvoidingDensityBound {axs.toList}"
  for n in [``FS131IDB3Plant.withSorry, ``FS131IDB3Plant.withNative] do
    let axs ← liftCoreM <| Lean.collectAxioms n
    IO.println s!"PLANT {n} {axs.toList}"

#idb3_axioms

end FS131IDB3Axioms
