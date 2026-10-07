import Proofs.HadwigerNelson.Plane.OnePiece
/-!
FS124-I2 — every constant of this job's two modules, as the kernel holds it: read-only.

For each constant stored in the compiled data of `Plane/CircleCrossing` and `Plane/OnePiece` (`env.header.moduleData`: what the
module's own `.olean` holds, whatever the file's text shows), prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw: bound variables by index, every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)

`INTERNAL` marks a name Lean generates inside a declaration (`Name.isInternalDetail`: `_proof_n`, `match_n`, …): those
move with a proof and are not statements. A module that is not imported is an error, never an empty dump.

Run from the worktree against its built library, before and after the proofs:
  lake env lean data/fs124/i2/lean/StatementDump.lean > data/fs124/i2/statements-<when>.txt
The reader is `data/fs124/i2/statement_diff.py`.
-/
open Lean Elab Command

namespace FS124I2Dump

/-- The two modules of this job. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Plane.CircleCrossing, `Proofs.HadwigerNelson.Plane.OnePiece]

/-- The kind of a constant, as the kernel classes it. -/
def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

/-- Print the stored constants of the two modules. Reads the environment; writes nothing to it. -/
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

end FS124I2Dump
