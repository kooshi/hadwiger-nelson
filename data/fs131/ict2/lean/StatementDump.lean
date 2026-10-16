import Proofs.HadwigerNelson.CayleyThree.Circular
import Proofs.HadwigerNelson.CayleyThree.Fibre
import Proofs.HadwigerNelson.CayleyThree.Density
/-!
FS131-ICT2 — every constant of the three `CayleyThree/` modules as the kernel holds it: read-only. FS131-ICO1's dumper
(`.claude/worktrees/kcl1/data/fs131/ico1/lean/StatementDump.lean`, itself FS131-IDG1's) with this job's module list. Format:
`## MODULE <m> constants=<n>`, then per constant `@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`,
`TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>` and, when its type is not a proposition, `DATA <hash> <raw>`
(the value with every proof subterm erased to `True.intro`).

Run from the worktree against its compiled library, before the first rebuild and after the last:
  lake env lean data/fs131/ict2/lean/StatementDump.lean > data/fs131/ict2/statements-<when>.txt (FS131-ICT1's dumper, unchanged but for its names)
-/
open Lean Elab Command Meta

namespace FS131ICT2Dump

/-- The three modules of the landing. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.CayleyThree.Circular, `Proofs.HadwigerNelson.CayleyThree.Fibre,
   `Proofs.HadwigerNelson.CayleyThree.Density]

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

end FS131ICT2Dump
