import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Proofs.HadwigerNelson.Rigidity.Pieces
import Proofs.HadwigerNelson.Rigidity.EntropySplitMax
/-!
FS131-ILA1 — every constant of the three modules this job's edit can reach, as the kernel holds it: read-only.
The one this job writes (`Rigidity/UnitCircle`: the proof of `exists_admissiblePair`, private helpers, import lines) and
the two downstream of it (`Rigidity/Pieces`, `Rigidity/EntropySplitMax`: they recompile when `UnitCircle` does). The first
dump was taken with these three; the module list gained the new `Rigidity/AdmissiblePrime` after it (the dump before
the edit cannot import a module that did not exist), and nothing else of this file changed.

For each constant stored in a module's compiled data (`env.header.moduleData`) it prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]
  TYPE <hash> <the stored type, raw>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  DATA <hash> <the stored value, every proof subterm erased to `True.intro`>  (definitions of a non-proposition)

under a line `## MODULE <name> constants=<n>` per module. (FS131-IM11's dumper, `data/fs131/im11/lean/StatementDump.lean`,
aimed at these three modules; that one is not edited.) Run from the worktree against its compiled library, before the
first edit and after the last:
  lake env lean data/fs131/ila1/lean/StatementDump.lean > data/fs131/ila1/statements-<when>.txt
The reader is `tools/fs131_ila1_statements.py`.
-/
open Lean Elab Command Meta

namespace FS131ILA1Dump

/-- The three modules, and (in the dump after the edit only) the new `Rigidity/AdmissiblePrime`. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.UnitCircle,
   `Proofs.HadwigerNelson.Rigidity.Pieces,
   `Proofs.HadwigerNelson.Rigidity.EntropySplitMax,
   `Proofs.HadwigerNelson.Rigidity.AdmissiblePrime]

/-- The kind of a constant, as the kernel classes it. -/
def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

/-- A definition's value with every subterm that is a proof erased to `True.intro` (see the module docstring). -/
def eraseProofArgs (v : Expr) : MetaM Expr :=
  Meta.transform v (pre := fun e => do
    if e.isSort || e.isConst then return .continue
    if ← (try isProof e catch _ => pure false) then return .done (mkConst ``True.intro) else return .continue)

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
      let isP ← liftTermElabM <| isProp ci.type
      let pflag := if isP then " PROPTYPE" else ""
      IO.println s!"@@ {kindOf ci} {n}{flag}{pflag}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v =>
        IO.println s!"VALUE {v.value.hash} {v.value}"
        unless isP do
          let e ← liftTermElabM <| eraseProofArgs v.value
          IO.println s!"DATA {e.hash} {e}"
      | _ => pure ()

#eval run

end FS131ILA1Dump
