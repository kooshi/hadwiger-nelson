import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.HaarMultiple
import Proofs.HadwigerNelson.Rigidity.SolenoidErgodic
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
/-!
FS131-IDG1 — every constant of the four modules whose module docstrings this job rewrote (prose only, from FS131-IN1L's
drafts): `Rigidity/ChainAtTA`, `HaarMultiple`, `SolenoidErgodic`, `ZeroEntropyNames`, as the kernel holds them; read-only.
`StatementDump.lean` with this module list; read by `tools/fs131_idg1_docdump_diff.py`, which requires every constant,
internal ones and proofs included, to be identical before and after the build that recompiles them. The rest of this
docstring is `StatementDump.lean`'s.

For each constant stored in the compiled data of `Rigidity/DualGroup`, `Annihilator`, `SubgroupHaar`, `Duality`,
`DualConnected`, `UnitCircle` (the six files this job proves) and `Rigidity/Pieces`, `Rigidity/EntropySplitMax` (their
only importers but `Proofs`; not this job's, dumped so that an import line added upstream is seen to move none of their
stored terms) — `env.header.moduleData`: what the module's own `.olean` holds, whatever the file's text shows — prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]
  TYPE <hash> <the stored type, raw: bound variables by index, every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  DATA <hash> <the stored value, every subterm that is a proof erased to `True.intro`>
                                                                         (definitions whose type is not a proposition)

`INTERNAL` marks a name Lean generates inside a declaration (`Name.isInternalDetail`); `PRIVATE` a `private`
declaration, printed with the name the file gives it; `PROPTYPE` a constant whose type is a proposition (an `instance`
of a `Prop`-valued class may be stored as a definition, and its value is a proof: the reader compares its type only).
`DATA` is the value with every subterm that is a proof (in its local context) replaced by `True.intro` (ill-typed,
printed only): a definition that holds a proof as a structure field (`AdmissiblePair.ofPow`'s `generates`,
`Duality.graphSubgroup`'s three closure fields)
moves its `VALUE` when the field is proved and keeps its `DATA` (`LEAN.md`, FS124-I3's line). A module that is not
imported is an error, never an empty dump.

FS131-IN1L's dumper (`data/fs131/in1l/lean/StatementDump.lean`) with the eight modules and the `PROPTYPE` flag. Run from
the worktree against its compiled library, before and after the proofs:
  lake env lean data/fs131/idg1/lean/StatementDump.lean > data/fs131/idg1/statements-<when>.txt
The reader is `tools/fs131_idg1_statements.py`.
-/
open Lean Elab Command Meta

namespace FS131IDG1DocDump

/-- The four modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.ChainAtTA, `Proofs.HadwigerNelson.Rigidity.HaarMultiple,
   `Proofs.HadwigerNelson.Rigidity.SolenoidErgodic, `Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames]

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

end FS131IDG1DocDump
