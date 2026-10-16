import Proofs.HadwigerNelson.Rigidity.AdmissiblePrime
import Proofs.HadwigerNelson.Rigidity.NormOneGen
import Proofs.HadwigerNelson.Rigidity.UnitRingEq
import Proofs.HadwigerNelson.Rigidity.UsablePrime
import Proofs.HadwigerNelson.Rigidity.PlaneComponents
import Proofs.HadwigerNelson.Instances.UnitRingModels
/-!
FS131-IRU1 (a copy of FS131-ICO2's dumper, `data/fs131/ico2/lean/StatementDump.lean`, module list and namespace changed) —
every constant of the five skeleton modules of FS131-KRU1 and of `Rigidity/AdmissiblePrime` (the one ruled edit: three
private lemmas made public), as the kernel holds it: read-only. Format: `## MODULE <m> constants=<n>`, then per constant
`@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>`
and, when its type is not a proposition, `DATA <hash> <raw>` — the value with every proof subterm erased.

Run from the worktree against its compiled library, before the first rebuild and after the last:
  lake env lean data/fs131/iru1/lean/StatementDump.lean > data/fs131/iru1/statements-<when>.txt
-/
open Lean Elab Command Meta

namespace FS131IRU1Dump

/-- The six modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.AdmissiblePrime, `Proofs.HadwigerNelson.Rigidity.NormOneGen,
   `Proofs.HadwigerNelson.Rigidity.UnitRingEq, `Proofs.HadwigerNelson.Rigidity.UsablePrime,
   `Proofs.HadwigerNelson.Rigidity.PlaneComponents, `Proofs.HadwigerNelson.Instances.UnitRingModels]

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

end FS131IRU1Dump
