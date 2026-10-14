import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz
import Proofs.HadwigerNelson.Rigidity.InvariantMeasure
import Proofs.HadwigerNelson.Rigidity.BochnerTau
import Proofs.HadwigerNelson.Rigidity.CountTorus
import Proofs.HadwigerNelson.Rigidity.CountResidue
import Proofs.HadwigerNelson.Rigidity.CountCompletion
import Proofs.HadwigerNelson.Rigidity.CountExtension
import Proofs.HadwigerNelson.Rigidity.CountDescent
/-!
FS131-IJ1 — every constant of the ten modules this job's edits can reach, as the kernel holds it: read-only.
The seven this job writes (`Rigidity/ChainAtTA` — two lemmas made public; `CountResidue`, `CountCompletion` — the ring map
`Counting.toL` replaced by `ofUnitRing`; `ContinuityGroup`, `Herglotz`, `InvariantMeasure`, `BochnerTau` — proofs) and the
three downstream of them that it does not (`CountTorus`, `CountExtension`, `CountDescent`: an import line added upstream
could move an instance their stored terms name).

For each constant stored in a module's compiled data (`env.header.moduleData`) it prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]
  TYPE <hash> <the stored type, raw>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  DATA <hash> <the stored value, every proof subterm erased to `True.intro`>  (definitions of a non-proposition)

under a line `## MODULE <name> constants=<n>` per module. (FS131-ITK1's dumper, `data/fs131/itk1/lean/StatementDump.lean`,
aimed at these ten modules.) Run from the worktree against its compiled library, before the first edit and after the last:
  lake env lean data/fs131/ij1/lean/StatementDump.lean > data/fs131/ij1/statements-<when>.txt
The reader is `tools/fs131_ij1_statements.py`.
-/
open Lean Elab Command Meta

namespace FS131IJ1Dump

/-- The ten modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.ChainAtTA,
   `Proofs.HadwigerNelson.Rigidity.ContinuityGroup,
   `Proofs.HadwigerNelson.Rigidity.Herglotz,
   `Proofs.HadwigerNelson.Rigidity.InvariantMeasure,
   `Proofs.HadwigerNelson.Rigidity.BochnerTau,
   `Proofs.HadwigerNelson.Rigidity.CountTorus,
   `Proofs.HadwigerNelson.Rigidity.CountResidue,
   `Proofs.HadwigerNelson.Rigidity.CountCompletion,
   `Proofs.HadwigerNelson.Rigidity.CountExtension,
   `Proofs.HadwigerNelson.Rigidity.CountDescent]

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

end FS131IJ1Dump
