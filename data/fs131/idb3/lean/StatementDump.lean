import Proofs.HadwigerNelson.Plane.DensityBound.Window
import Proofs.HadwigerNelson.Plane.DensityBound.Cells.Covering
/-!
FS131-IDB3 — every constant of every existing module of the density bound (`Plane/DensityBound/*`, `Cells/*`,
`Plane/OneAvoidingDensity`) as the kernel holds it, read from the modules' own compiled data (after FS131-IDB2's dump; the
value is printed by hash only, the cell literals being megabytes):

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type>
  VALUE <hash>                         (definitions only)

Every module under `Proofs.HadwigerNelson.Plane.DensityBound` that the environment holds is dumped, with
`Plane.OneAvoidingDensity`; fewer than 56 such modules (4 Bessel modules, `Cells/Data`, 46 parts, `Cells/Covering`, `Autocorr`, `Pattern`, `Window`, `Plane/OneAvoidingDensity`) is an error, never a short dump. Reader:
`tools/fs131_idb3_statement_diff.py`.
-/
open Lean Elab Command

namespace FS131IDB3Dump

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def wanted (m : Name) : Bool :=
  (`Proofs.HadwigerNelson.Plane.DensityBound).isPrefixOf m || m == `Proofs.HadwigerNelson.Plane.OneAvoidingDensity

def run : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut count : Nat := 0
  for i in [0:mods.size] do
    let m := mods[i]!
    unless wanted m do continue
    count := count + 1
    let d := data[i]!
    IO.println s!"## MODULE {m} constants={d.constants.size}"
    for ci in d.constants do
      let n := ci.name
      let flag := if n.isInternalDetail then " INTERNAL" else ""
      IO.println s!"@@ {kindOf ci} {n}{flag}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v => IO.println s!"VALUE {v.value.hash}"
      | _ => pure ()
  IO.println s!"## MODULES {count}"
  if count < 56 then throwError "only {count} modules of the density bound are imported"

#eval run

end FS131IDB3Dump
