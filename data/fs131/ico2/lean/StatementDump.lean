import Proofs.HadwigerNelson.Arith.FloorPlanes
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Collapse.Thick
import Proofs.HadwigerNelson.Collapse.Colouring
import Proofs.HadwigerNelson.Collapse.Dichotomy
import Proofs.HadwigerNelson.Collapse.Slice
import Proofs.HadwigerNelson.Collapse.Mixing
import Proofs.HadwigerNelson.Collapse.Selection
import Proofs.HadwigerNelson.Collapse.Headline
/-!
FS131-ICO2 (a copy of FS131-ICO1's dumper, `data/fs131/ico1/lean/StatementDump.lean`, namespace renamed) — every constant of the seven `Collapse/` modules and of the two modules the approved edits D-E1, D-E2 touch
(`Arith/FloorPlanes`, `Rigidity/ClassRatio`), as the kernel holds it: read-only. FS131-IDG1's dumper
(`data/fs131/idg1/lean/StatementDump.lean`) with this job's module list; its format is that file's docstring.

Run from the worktree against its compiled library, before the first rebuild and after the last:
  lake env lean data/fs131/ico2/lean/StatementDump.lean > data/fs131/ico2/statements-<when>.txt
-/
open Lean Elab Command Meta

namespace FS131ICO2Dump

/-- The nine modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Arith.FloorPlanes, `Proofs.HadwigerNelson.Rigidity.ClassRatio,
   `Proofs.HadwigerNelson.Collapse.Thick, `Proofs.HadwigerNelson.Collapse.Colouring,
   `Proofs.HadwigerNelson.Collapse.Dichotomy, `Proofs.HadwigerNelson.Collapse.Slice,
   `Proofs.HadwigerNelson.Collapse.Mixing, `Proofs.HadwigerNelson.Collapse.Selection,
   `Proofs.HadwigerNelson.Collapse.Headline]

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

end FS131ICO2Dump
