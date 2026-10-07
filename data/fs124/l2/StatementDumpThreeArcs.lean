import Proofs.HadwigerNelson.Plane.ThreeArcs
/-!
FS124-L2 — every constant of the landing's modules as the kernel holds it, for "no statement changed": read-only
(after `data/fs124/i4/lean/StatementDump.lean`, FS124-I4's, whose line format is kept so that its saved dumps can be
read beside this one's).  For each constant stored in a module's own compiled data (`env.header.moduleData`):

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw>
  VALUE <hash> <the stored value, raw>                 (definitions only)
  DATA <hashes> <the three data fields, raw>           (a `ThreePiece` given by its sixteen arguments only)

A module that is not imported is an error, never an empty dump.  The reader is `tools/fs124_l2_statements.py`.
-/
open Lean Elab Command

namespace FS124L2Dump

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
      | .defnInfo v =>
        IO.println s!"VALUE {v.value.hash} {v.value}"
        if v.value.getAppFn.isConstOf `HadwigerNelson.Plane.ThreePiece.mk && v.value.getAppNumArgs == 16 then
          let args := v.value.getAppArgs
          IO.println s!"DATA {args[4]!.hash} {args[5]!.hash} {args[6]!.hash} {args[4]!} ;; {args[5]!} ;; {args[6]!}"
      | _ => pure ()

end FS124L2Dump

#eval FS124L2Dump.run [`Proofs.HadwigerNelson.Plane.ThreeArcs]
