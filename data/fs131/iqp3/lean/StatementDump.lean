import Proofs.HadwigerNelson.PadicPlane.Basic
import Proofs.HadwigerNelson.PadicPlane.Measure
import Proofs.HadwigerNelson.PadicPlane.Upper
import Proofs.HadwigerNelson.PadicPlane.Tower
import Proofs.HadwigerNelson.PadicPlane.Values
import Proofs.HadwigerNelson.Arith.FibreCert7
import Proofs.HadwigerNelson.Arith.FibreCert7Check
import Proofs.HadwigerNelson.Arith.FibreCert7Bound
/-!
FS131-IQP3 — every constant of the eight landing modules as the kernel holds it: read-only. FS131-IQP1's dumper
(`data/fs131/iqp1/lean/StatementDump.lean`, itself FS131-ICO1's and FS131-IDG1's) with the three `Arith/FibreCert7*`
modules added to its list, the format unchanged: `## MODULE`, `@@ KIND name [INTERNAL | PRIVATE user] [PROPTYPE]`,
`TYPE hash raw`, and for a definition `VALUE hash raw` and, unless its type is a proposition, `DATA hash raw` (the value,
proofs erased).

Run from the worktree against the build being gated, under a slot:
  lake env lean data/fs131/iqp3/lean/StatementDump.lean > data/fs131/iqp3/statements-after.txt
-/
open Lean Elab Command Meta

namespace FS131IQP3Dump

/-- The eight modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.PadicPlane.Basic, `Proofs.HadwigerNelson.PadicPlane.Measure,
   `Proofs.HadwigerNelson.PadicPlane.Upper, `Proofs.HadwigerNelson.PadicPlane.Tower,
   `Proofs.HadwigerNelson.PadicPlane.Values, `Proofs.HadwigerNelson.Arith.FibreCert7,
   `Proofs.HadwigerNelson.Arith.FibreCert7Check, `Proofs.HadwigerNelson.Arith.FibreCert7Bound]

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

end FS131IQP3Dump
