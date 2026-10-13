import Proofs.HadwigerNelson.Instances.UpperHalfValues
/-!
FS131-IV1 — every constant of the module's three files (`Arith/UpperHalf`, `Arith/QuadraticPrime`,
`Instances/UpperHalfValues`), as the kernel holds it: read-only. (Pattern: `data/fs131/iu1/lean/StatementDump.lean`, whose
print format this keeps line for line, so a dump of one module made by either is read by either job's reader.)

For each constant stored in the compiled data of a module (`env.header.moduleData`: what the module's own `.olean` holds,
whatever the file's text shows), prints

  ## MODULE <module> constants=<n>
  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw: bound variables by index, every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)

`INTERNAL` marks a name Lean generates inside a declaration (`Name.isInternalDetail`: `_proof_n`, `match_n`, …) — and a
private declaration's stored name: those move with a proof and are not statements. A module that is not imported is an
error, never an empty dump.

Run from the worktree against its built library, before the first rebuild and after the last:
  data/fs131/iv1/lean1.sh data/fs131/iv1/lean/StatementDump.lean      (the print is logs/StatementDump.out)
The reader is `data/fs131/iv1/statement_diff.py`, after `data/fs131/iv1/compact_dump.py`.
-/
open Lean Elab Command

namespace FS131IV1Dump

/-- The three modules of NF1-MODULE. -/
def modules : List Name := [`Proofs.HadwigerNelson.Arith.UpperHalf, `Proofs.HadwigerNelson.Arith.QuadraticPrime,
  `Proofs.HadwigerNelson.Instances.UpperHalfValues]

/-- The kind of a constant, as the kernel classes it. -/
def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

/-- Print the stored constants of the modules. Reads the environment; writes nothing to it. -/
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

end FS131IV1Dump
