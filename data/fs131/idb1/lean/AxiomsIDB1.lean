import Proofs.HadwigerNelson.Plane.DensityBound.Cells.Covering
/-!
FS131-IDB1 — the axioms of every public declaration of this job's modules, from the built tree (read-only).

For each constant stored in the compiled data of the modules below that is not an internal name (private helpers are
read through the records that use them), prints `REC <module> <kind> <name> <axioms>` with the axioms as
`Lean.collectAxioms` computes them (transitively, through every constant the proof names). Two planted records follow,
`FS131IDB1Plant.withSorry` (a `sorry`) and `FS131IDB1Plant.withNative` (a `native_decide`), printed as `PLANT …`: the
reader `tools/fs131_idb1_axioms.py` must find `sorryAx` in the first and a native axiom in the second, or it fails.
Run: `lake env lean data/fs131/idb1/lean/AxiomsIDB1.lean > data/fs131/idb1/axioms.txt`.
-/
open Lean Elab Command

namespace FS131IDB1Plant
theorem withSorry : (1 : Nat) = 1 := by sorry
theorem withNative : (2 : Nat) + 2 = 4 := by native_decide
end FS131IDB1Plant

namespace FS131IDB1Axioms

def mods : List Name :=
  [`Proofs.HadwigerNelson.Plane.DensityBound.Bessel, `Proofs.HadwigerNelson.Plane.DensityBound.BesselDefect,
   `Proofs.HadwigerNelson.Plane.DensityBound.BesselCheck, `Proofs.HadwigerNelson.Plane.DensityBound.BesselCert,
   `Proofs.HadwigerNelson.Plane.DensityBound.Cells.Data] ++
  ((List.range 46).map fun i =>
    (`Proofs.HadwigerNelson.Plane.DensityBound.Cells).str s!"Part{if i < 10 then "0" else ""}{i}") ++
  [`Proofs.HadwigerNelson.Plane.DensityBound.Cells.Covering]

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

elab "#idb1_axioms" : command => do
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
  for n in [``FS131IDB1Plant.withSorry, ``FS131IDB1Plant.withNative] do
    let axs ← liftCoreM <| Lean.collectAxioms n
    IO.println s!"PLANT {n} {axs.toList}"

#idb1_axioms

end FS131IDB1Axioms
