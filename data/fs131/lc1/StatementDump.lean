import Proofs
/-!
FS131-LC1 — every constant of the three modules this landing edits (docstrings only) as the kernel holds it, for "no
statement changed": read-only (after `data/fs124/l2/StatementDump.lean`, FS124-L2's, whose line format is kept so that
`tools/fs124_l2_statements.py` reads it).  For each constant stored in a module's own compiled data
(`env.header.moduleData`):

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw>
  VALUE <hash> <the stored value, raw>                 (definitions only)

A module that is not imported is an error, never an empty dump.
-/
open Lean Elab Command

namespace FS131LC1Dump

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def run (modules : List Name) : CommandElabM Unit := do
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

end FS131LC1Dump

#eval FS131LC1Dump.run [`Proofs.HadwigerNelson.Plane.AeColouring, `Proofs.HadwigerNelson.Plane.FalconerReduction, `Proofs.HadwigerNelson.Plane.LebesgueNumber]
