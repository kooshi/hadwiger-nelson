import Proofs.HadwigerNelson.Rigidity.APlus
import Proofs.HadwigerNelson.Rigidity.AdmissiblePrime
import Proofs.HadwigerNelson.Rigidity.Annihilator
import Proofs.HadwigerNelson.Rigidity.BochnerTau
import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.CountCompletion
import Proofs.HadwigerNelson.Rigidity.CountDescent
import Proofs.HadwigerNelson.Rigidity.CountExtension
import Proofs.HadwigerNelson.Rigidity.CountModels
import Proofs.HadwigerNelson.Rigidity.CountResidue
import Proofs.HadwigerNelson.Rigidity.CountTorus
import Proofs.HadwigerNelson.Rigidity.DualConnected
import Proofs.HadwigerNelson.Rigidity.DualGroup
import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.Entropy
import Proofs.HadwigerNelson.Rigidity.EntropyFibres
import Proofs.HadwigerNelson.Rigidity.EntropySplitMax
import Proofs.HadwigerNelson.Rigidity.FiniteZhang
import Proofs.HadwigerNelson.Rigidity.GlobalPoint
import Proofs.HadwigerNelson.Rigidity.HaarMultiple
import Proofs.HadwigerNelson.Rigidity.Herglotz
import Proofs.HadwigerNelson.Rigidity.InvariantMeasure
import Proofs.HadwigerNelson.Rigidity.Multipliers
import Proofs.HadwigerNelson.Rigidity.Pieces
import Proofs.HadwigerNelson.Rigidity.PlaceSizes
import Proofs.HadwigerNelson.Rigidity.PlaneZhang
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Proofs.HadwigerNelson.Rigidity.RingScope
import Proofs.HadwigerNelson.Rigidity.Solenoid
import Proofs.HadwigerNelson.Rigidity.SolenoidErgodic
import Proofs.HadwigerNelson.Rigidity.SpectralSubspace
import Proofs.HadwigerNelson.Rigidity.SubgroupHaar
import Proofs.HadwigerNelson.Rigidity.TateArch
import Proofs.HadwigerNelson.Rigidity.TateCharacter
import Proofs.HadwigerNelson.Rigidity.TateExists
import Proofs.HadwigerNelson.Rigidity.TateKernel
import Proofs.HadwigerNelson.Rigidity.TateLocal
import Proofs.HadwigerNelson.Rigidity.TateModel
import Proofs.HadwigerNelson.Rigidity.ThinBoxes
import Proofs.HadwigerNelson.Rigidity.TraceSplit
import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Proofs.HadwigerNelson.Rigidity.WanderingShells
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
/-!
FS131-IJN1 — every constant of every module of `Proofs/HadwigerNelson/Rigidity/` as the kernel holds it: read-only.
FS131-IJ3's dumper (`data/fs131/ij3/lean/StatementDump.lean`), its module list replaced by every imported module under
`Proofs.HadwigerNelson.Rigidity` (no module outside `Rigidity/` imports one; `Proofs.lean` aside). Output format as there:

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]
  TYPE <hash> <the stored type, raw>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  DATA <hash> <the stored value, every proof subterm erased to `True.intro`>  (definitions of a non-proposition)

Run from the worktree against its compiled library, after the merges' build and after the last build:
  lake env lean data/fs131/ijn1/lean/StatementDump.lean > data/fs131/ijn1/statements-<when>.txt
The reader is `tools/fs131_ijn1_statements.py`.
-/
open Lean Elab Command Meta

namespace FS131IJN1Dump

/-- The modules: every imported module of `Proofs/HadwigerNelson/Rigidity/` (the import list above names each). -/
def modulesOf (env : Environment) : List Name :=
  env.header.moduleNames.toList.filter fun m => (`Proofs.HadwigerNelson.Rigidity).isPrefixOf m

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
  let modules := modulesOf env
  IO.println s!"## MODULES {modules.length}"
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

end FS131IJN1Dump
