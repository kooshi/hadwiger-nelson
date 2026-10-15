import Proofs.HadwigerNelson.Rigidity.DualGroup
import Proofs.HadwigerNelson.Rigidity.Annihilator
import Proofs.HadwigerNelson.Rigidity.SubgroupHaar
import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.DualConnected
import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
/-!
FS131-IG1 — every constant of the seven modules whose docstrings this job rewrote (prose only, from FS131-IDG1's drafts):
`Rigidity/DualGroup`, `Annihilator`, `SubgroupHaar`, `Duality`, `DualConnected`, `UnitCircle`, `ZeroEntropyNames`, as the
kernel holds them; read-only. FS131-IDG1's `DocDump.lean` with this module list and one line more per theorem,
`PROOF <hash>` (the hash of the stored proof term), so that the comparison covers proofs too. For each constant of a
module's compiled data it prints `@@ <kind> <name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <type>`,
for a definition `VALUE <hash> <value>` and, for a definition of a non-proposition, `DATA <hash> <value with proofs
erased>`, and for a theorem `PROOF <hash>`. Read by `tools/fs131_ig1_docdump_diff.py`, which requires every line to be
identical before and after the build that recompiles the seven modules. Run from the worktree against its compiled
library:
  lake env lean data/fs131/ig1/lean/DocDump.lean > data/fs131/ig1/docdump-<when>.txt
-/
open Lean Elab Command Meta

namespace FS131IG1DocDump

/-- The seven modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.DualGroup,
   `Proofs.HadwigerNelson.Rigidity.Annihilator,
   `Proofs.HadwigerNelson.Rigidity.SubgroupHaar,
   `Proofs.HadwigerNelson.Rigidity.Duality,
   `Proofs.HadwigerNelson.Rigidity.DualConnected,
   `Proofs.HadwigerNelson.Rigidity.UnitCircle,
   `Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames]

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
      | .thmInfo v => IO.println s!"PROOF {v.value.hash}"
      | _ => pure ()

#eval run

end FS131IG1DocDump
