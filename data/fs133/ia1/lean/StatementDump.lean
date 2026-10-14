import Proofs.HadwigerNelson.Plane.OneClass.Field
/-!
FS133-IA1 — every constant of this job's two hand-written modules, as the kernel holds it: read-only.

For each constant stored in the compiled data of `Outside/OAI158Rigidity` and `Plane/OneClass/Field`
(`env.header.moduleData`: what the module's own `.olean` holds, whatever the file's text shows), prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw: bound variables by index, every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)

`INTERNAL` marks a name Lean generates inside a declaration (`Name.isInternalDetail`: `_proof_n`, `match_n`, …): those
move with a proof and are not statements. A module that is not imported is an error, never an empty dump.

Run from the worktree against its built library, before and after the proofs (FS124-I3's dumper, for this job's
modules):
  lake env lean data/fs133/ia1/lean/StatementDump.lean > data/fs133/ia1/statements-<when>.txt
The reader is `tools/fs133_ia1_statements.py`.
-/
open Lean Elab Command

namespace FS133IA1Dump

/-- The two hand-written modules of this job (the third, `Outside/OAI158Transfer`, is generated and new). -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Outside.OAI158Rigidity, `Proofs.HadwigerNelson.Plane.OneClass.Field]

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

end FS133IA1Dump
