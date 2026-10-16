import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Collapse.Headline
import Proofs.HadwigerNelson.Collapse.Density.Defs
import Proofs.HadwigerNelson.Collapse.Density.Upper
import Proofs.HadwigerNelson.Collapse.Density.Headline
import Proofs.HadwigerNelson.Plane.TriangularPacking
/-!
FS131-IFR1 (a copy of FS131-ICO2's dumper, `data/fs131/ico2/lean/StatementDump.lean`, namespace and module list changed) —
every constant of the four new modules and of the two landed modules the rulings touch (`Rigidity/ClassRatio`: the
word `private` before `ratioAtMost_of_charBound`; `Collapse/Headline`: the splits and the model at `k = 7`), as the kernel
holds it: read-only. Format: FS131-IDG1's dumper's docstring.

Run from the worktree against its compiled library, before the first rebuild and after the last:
  lake env lean data/fs131/ifr1/lean/StatementDump.lean > data/fs131/ifr1/statements-<when>.txt
-/
open Lean Elab Command Meta

namespace FS131IFR1Dump

/-- The six modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.ClassRatio, `Proofs.HadwigerNelson.Collapse.Headline,
   `Proofs.HadwigerNelson.Collapse.Density.Defs, `Proofs.HadwigerNelson.Collapse.Density.Upper,
   `Proofs.HadwigerNelson.Collapse.Density.Headline, `Proofs.HadwigerNelson.Plane.TriangularPacking]

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

end FS131IFR1Dump
