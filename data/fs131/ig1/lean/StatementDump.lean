import Proofs.HadwigerNelson.Rigidity.DualGroup
import Proofs.HadwigerNelson.Rigidity.Annihilator
import Proofs.HadwigerNelson.Rigidity.SubgroupHaar
import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.DualConnected
import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
import Proofs.HadwigerNelson.Rigidity.Pieces
import Proofs.HadwigerNelson.Rigidity.EntropySplitMax
/-!
FS131-IG1 — every constant of `Rigidity/Pieces` (the module this job proves), of the seven modules whose docstrings this
job edits (`Rigidity/DualGroup`, `Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`, `UnitCircle`,
`ZeroEntropyNames`), and of `Rigidity/EntropySplitMax` (the one importer of `Pieces` but `Proofs`; not this job's,
dumped so that an import line added to `Pieces` is seen to move none of its stored terms), as the kernel holds it:
read-only.

For each constant stored in a module's compiled data (`env.header.moduleData`: what the module's own `.olean` holds,
whatever the file's text shows) it prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]
  TYPE <hash> <the stored type, raw: bound variables by index, every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  DATA <hash> <the stored value, every subterm that is a proof erased to `True.intro`>
                                                                         (definitions whose type is not a proposition)

(FS131-IDG1's dumper, `data/fs131/idg1/lean/StatementDump.lean`, aimed at these nine modules.) A module that is not
imported is an error, never an empty dump. Run from the worktree against its compiled library, before and after the
proofs:
  lake env lean data/fs131/ig1/lean/StatementDump.lean > data/fs131/ig1/statements-<when>.txt
The reader is `tools/fs131_ig1_statements.py`.
-/
open Lean Elab Command Meta

namespace FS131IG1Dump

/-- The nine modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.DualGroup,
   `Proofs.HadwigerNelson.Rigidity.Annihilator,
   `Proofs.HadwigerNelson.Rigidity.SubgroupHaar,
   `Proofs.HadwigerNelson.Rigidity.Duality,
   `Proofs.HadwigerNelson.Rigidity.DualConnected,
   `Proofs.HadwigerNelson.Rigidity.UnitCircle,
   `Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames,
   `Proofs.HadwigerNelson.Rigidity.Pieces,
   `Proofs.HadwigerNelson.Rigidity.EntropySplitMax]

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

end FS131IG1Dump
