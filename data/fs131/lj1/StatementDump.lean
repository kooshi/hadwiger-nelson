import Proofs
/-!
FS131-LJ1 — every constant of the six modules this landing brings (and edits, docstrings only) as the kernel holds
it, for "no statement changed": read-only (FS131-LU1's `data/fs131/lu1/StatementDump.lean` with the module list
changed; its line format is FS124-L2's, so that `tools/fs124_l2_statements.py` reads it).  For each constant stored in
a module's own compiled data (`env.header.moduleData`):

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw>
  VALUE <hash> <the stored value, raw>                 (definitions only)

A module that is not imported is an error, never an empty dump.
-/
open Lean Elab Command

namespace FS131LJ1Dump

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

end FS131LJ1Dump

#eval FS131LJ1Dump.run [`Proofs.HadwigerNelson.Arith.ThreeColourCharacter, `Proofs.HadwigerNelson.Arith.TorsionExtraction, `Proofs.HadwigerNelson.Arith.ThreeColourCriterion, `Proofs.HadwigerNelson.Arith.DyadicQuadratic, `Proofs.HadwigerNelson.Arith.ThreeFourColours, `Proofs.HadwigerNelson.Instances.UpperHalfCorollaries]
