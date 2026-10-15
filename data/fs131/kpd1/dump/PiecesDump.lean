import Proofs.HadwigerNelson.Rigidity.Pieces
/-!
FS131-KPD1 — every constant stored in `Rigidity/Pieces`'s compiled data (after FS124-L2's `StatementDump.lean`, its line
format), to show that adding the duality modules to its imports changes no stored type or value. Read-only. A module that is
not imported is an error, never an empty dump. Compared by `tools/fs131_kpd1_dumpdiff.py`.
-/
open Lean Elab Command

def kpd1KindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def kpd1Run (modules : List Name) : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  for m in modules do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to dump"
    let d := data[i]!
    IO.println s!"## MODULE {m} constants={d.constants.size}"
    for ci in d.constants do
      IO.println s!"@@ {kpd1KindOf ci} {ci.name}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v => IO.println s!"VALUE {v.value.hash} {v.value}"
      | _ => pure ()

#eval kpd1Run [`Proofs.HadwigerNelson.Rigidity.Pieces]
