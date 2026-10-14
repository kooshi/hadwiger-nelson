import Proofs.HadwigerNelson.Plane.DensityBound.Window
/-!
FS131-IDB2 — every constant of `Plane/DensityBound/Autocorr`, `Pattern`, `Window` and `Plane/OneAvoidingDensity` as the kernel holds it
(read-only; after FS124-I3's dump). For each constant in the module's own compiled data:

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type>
  VALUE <hash> <the stored value>        (definitions only)

A module that is not imported is an error, never an empty dump. Run from the worktree against its built library:
  lake env lean data/fs131/idb2/lean/StatementDump.lean > data/fs131/idb2/statements-<when>.txt
The reader is `tools/fs131_idb2_statement_diff.py`.
-/
open Lean Elab Command

namespace FS131IDB2Dump

def modules : List Name :=
  [`Proofs.HadwigerNelson.Plane.DensityBound.Autocorr, `Proofs.HadwigerNelson.Plane.DensityBound.Pattern,
   `Proofs.HadwigerNelson.Plane.DensityBound.Window, `Proofs.HadwigerNelson.Plane.OneAvoidingDensity]

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def run : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  for m in modules do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to dump"
    let d := data[i]!
    IO.println s!"## MODULE {m} constants={d.constants.size}"
    for ci in d.constants do
      let n := ci.name
      let flag := if n.isInternalDetail then " INTERNAL" else ""
      IO.println s!"@@ {kindOf ci} {n}{flag}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v => IO.println s!"VALUE {v.value.hash} {v.value}"
      | _ => pure ()

#eval run

end FS131IDB2Dump
