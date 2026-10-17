import Proofs.HadwigerNelson.Instances.SeamFractional
import Proofs.HadwigerNelson.Plane.G27.Bound

/-!
FS131-ISF1 (a copy of FS131-IRU2's dumper, itself FS131-ICO2's: namespace renamed, module list replaced) — every constant of
the modules this job builds, as the kernel holds it: read-only. The list grows with the modules (each added here when it is
first built); the skeleton's one module is `Instances/SeamFractional`; the after-dump adds the hand-written `Plane/G27` modules (the
generated ones hold certificate data, whose values would print hundreds of MB). Run from the worktree's root, under a slot:
  lake env lean data/fs131/isf1/lean/StatementDump.lean > data/fs131/isf1/statements-<when>.txt
-/
open Lean Elab Command Meta

namespace FS131ISF1Dump

/-- The modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Instances.SeamFractional, `Proofs.HadwigerNelson.Plane.G27.Check,
   `Proofs.HadwigerNelson.Plane.G27.Sound, `Proofs.HadwigerNelson.Plane.G27.Law, `Proofs.HadwigerNelson.Plane.G27.Bound]

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

/-- A definition's value with every subterm that is a proof erased to `True.intro`. -/
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
