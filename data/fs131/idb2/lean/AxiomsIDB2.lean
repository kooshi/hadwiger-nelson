import Proofs.HadwigerNelson.Plane.DensityBound.Window
/-!
FS131-IDB2 — the axioms of every public declaration of this job's modules, from the built tree (read-only).

For each constant stored in the compiled data of the modules below that is not an internal name (private helpers are
read through the records that use them), prints `REC <module> <kind> <name> <axioms>` with the axioms as
`Lean.collectAxioms` computes them (transitively, through every constant the proof names). Two planted records follow,
`FS131IDB2Plant.withSorry` (a `sorry`) and `FS131IDB2Plant.withNative` (a `native_decide`), printed as `PLANT …`: the
reader `tools/fs131_idb2_axioms.py` must find `sorryAx` in the first and a native axiom in the second, or it fails.
Run: `lake env lean data/fs131/idb2/lean/AxiomsIDB1.lean > data/fs131/idb2/axioms.txt`.
-/
open Lean Elab Command

namespace FS131IDB2Plant
theorem withSorry : (1 : Nat) = 1 := by sorry
theorem withNative : (2 : Nat) + 2 = 4 := by native_decide
end FS131IDB2Plant

namespace FS131IDB2Axioms

def mods : List Name :=
  [`Proofs.HadwigerNelson.Plane.DensityBound.Autocorr, `Proofs.HadwigerNelson.Plane.DensityBound.Pattern,
   `Proofs.HadwigerNelson.Plane.DensityBound.Window, `Proofs.HadwigerNelson.Plane.OneAvoidingDensity]

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

elab "#idb2_axioms" : command => do
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
  for n in [``FS131IDB2Plant.withSorry, ``FS131IDB2Plant.withNative] do
    let axs ← liftCoreM <| Lean.collectAxioms n
    IO.println s!"PLANT {n} {axs.toList}"

#idb2_axioms

end FS131IDB2Axioms
