import Proofs.HadwigerNelson.Rigidity.Entropy
import Proofs.HadwigerNelson.Rigidity.Solenoid
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Proofs.HadwigerNelson.Rigidity.ChainAtTA
/-!
FS131-IE1 — every constant of the chain's first layer, as the kernel holds it: read-only.

For each constant stored in the compiled data of `Rigidity/Entropy` (this job's file), and of `Rigidity/Solenoid`,
`Rigidity/PositiveEntropy` (which holds the declared printed theorem) and `Rigidity/ChainAtTA` (the two modules that
import `Rigidity/Entropy`, and their sibling) — `env.header.moduleData`: what the module's own `.olean` holds, whatever
the file's text shows — prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL|PRIVATE <user name>]
  TYPE <hash> <the stored type, raw: bound variables by index, every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)

`INTERNAL` marks a name Lean generates inside a declaration (`Name.isInternalDetail`: `_proof_n`, `match_n`, …): those
move with a proof and are not statements.  `PRIVATE` marks a `private` declaration (its stored name is
`_private.<module>.0.<name>`, which `isInternalDetail` also holds: `LEAN.md`, FS131-IU1), printed with the name the
file gives it.  A module that is not imported is an error, never an empty dump.

Run from the worktree against its compiled library, before and after the proofs (FS124-I3's dumper, through
FS133-IA1's, for this job's modules):
  lake env lean data/fs131/ie1/lean/StatementDump.lean > data/fs131/ie1/statements-<when>.txt
The reader is `tools/fs131_ie1_statements.py`.
-/
open Lean Elab Command

namespace FS131IE1Dump

/-- This job's file, and the three other modules of the chain's first layer. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.Entropy, `Proofs.HadwigerNelson.Rigidity.Solenoid,
   `Proofs.HadwigerNelson.Rigidity.PositiveEntropy, `Proofs.HadwigerNelson.Rigidity.ChainAtTA]

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
      let flag := match privateToUserName? n with
        | some u => if u.isInternalDetail then " INTERNAL" else s!" PRIVATE {u}"
        | none => if n.isInternalDetail then " INTERNAL" else ""
      IO.println s!"@@ {kindOf ci} {n}{flag}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v => IO.println s!"VALUE {v.value.hash} {v.value}"
      | _ => pure ()

#eval run

end FS131IE1Dump
