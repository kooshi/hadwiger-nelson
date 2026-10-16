import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Arith.StableAboveUsable
import Proofs.HadwigerNelson.Rigidity.FourColourPlaces
import Proofs.HadwigerNelson.Instances.SqrtFiveClass
import Proofs.HadwigerNelson.Instances.SqrtTwentyThreeCbrtTwo
import Proofs.HadwigerNelson.Collapse.Headline
import Proofs.HadwigerNelson.Collapse.Mixing
import Proofs.HadwigerNelson.Collapse.Selection
import Proofs.HadwigerNelson.Collapse.Slice
import Proofs.HadwigerNelson.Collapse.Thick
import Proofs.HadwigerNelson.Instances.SqrtClassValues
import Proofs.HadwigerNelson.Instances.SqrtFortySevenFive
import Proofs.HadwigerNelson.Rigidity.CertLinkModels
import Proofs.HadwigerNelson.Rigidity.ChainHeadline
import Proofs.HadwigerNelson.Rigidity.CountCompletion
import Proofs.HadwigerNelson.Rigidity.CountDescent
import Proofs.HadwigerNelson.Rigidity.CountExtension
import Proofs.HadwigerNelson.Rigidity.CountModels
import Proofs.HadwigerNelson.Rigidity.CountResidue
import Proofs.HadwigerNelson.Rigidity.MainClauseFive
import Proofs.HadwigerNelson.Rigidity.SqrtClassFive
/-!
FS131-ICS1 (a copy of FS131-ICO2's dumper, `data/fs131/ico2/lean/StatementDump.lean`, namespace renamed, module list
replaced) — every constant of the four skeleton modules of FS131-KCS1, of `Rigidity/ClassRatio` (the ruled edit, inventory
item 1027 (1)) and of the 16 other modules downstream of `ClassRatio` (which the edit recompiles), as the kernel holds it:
read-only. Format: FS131-IDG1's dumper's docstring.

Run from the worktree against its compiled library, before the first proof edit and after the last build:
  lake env lean data/fs131/ics1/lean/StatementDump.lean > data/fs131/ics1/statements-<when>.txt
-/
open Lean Elab Command Meta

namespace FS131ICS1Dump

/-- The twenty-one modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.ClassRatio,
   `Proofs.HadwigerNelson.Arith.StableAboveUsable,
   `Proofs.HadwigerNelson.Rigidity.FourColourPlaces,
   `Proofs.HadwigerNelson.Instances.SqrtFiveClass,
   `Proofs.HadwigerNelson.Instances.SqrtTwentyThreeCbrtTwo,
   `Proofs.HadwigerNelson.Collapse.Headline,
   `Proofs.HadwigerNelson.Collapse.Mixing,
   `Proofs.HadwigerNelson.Collapse.Selection,
   `Proofs.HadwigerNelson.Collapse.Slice,
   `Proofs.HadwigerNelson.Collapse.Thick,
   `Proofs.HadwigerNelson.Instances.SqrtClassValues,
   `Proofs.HadwigerNelson.Instances.SqrtFortySevenFive,
   `Proofs.HadwigerNelson.Rigidity.CertLinkModels,
   `Proofs.HadwigerNelson.Rigidity.ChainHeadline,
   `Proofs.HadwigerNelson.Rigidity.CountCompletion,
   `Proofs.HadwigerNelson.Rigidity.CountDescent,
   `Proofs.HadwigerNelson.Rigidity.CountExtension,
   `Proofs.HadwigerNelson.Rigidity.CountModels,
   `Proofs.HadwigerNelson.Rigidity.CountResidue,
   `Proofs.HadwigerNelson.Rigidity.MainClauseFive,
   `Proofs.HadwigerNelson.Rigidity.SqrtClassFive]

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

end FS131ICS1Dump
