import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Collapse.Headline
import Proofs.HadwigerNelson.Collapse.Density.Defs
import Proofs.HadwigerNelson.Collapse.Density.Upper
import Proofs.HadwigerNelson.Collapse.Density.Headline
import Proofs.HadwigerNelson.Plane.TriangularPacking
import Proofs.HadwigerNelson.Arith.StableAboveUsable
import Proofs.HadwigerNelson.Rigidity.FourColourPlaces
import Proofs.HadwigerNelson.Instances.SqrtFiveClass
import Proofs.HadwigerNelson.Instances.SqrtTwentyThreeCbrtTwo
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
import Proofs.HadwigerNelson.PadicPlane.Tower
import Proofs.HadwigerNelson.PadicPlane.Values
/-!
FS131-IFR2 (a copy of FS131-IFR1's dumper, itself FS131-ICO2's: namespace renamed, module list replaced) — every constant of
the 27 modules the merge of `main` into `fs131-kfr1` recompiles and that a gated dump can be compared with: FS131-IFR1's six
(`data/fs131/ifr1/statements-after.txt.gz`), FS131-ICS1's twenty-one (`data/fs131/ics1/statements-after.txt.gz` on `main`),
two in both, and the p-adic plane's two (`PadicPlane/Tower`, `Values`: downstream of `Rigidity/ClassRatio`, in neither dump),
as the kernel holds it: read-only. Run from the worktree's root against the merged build, under a slot:
  lake env lean data/fs131/ifr2/lean/StatementDump.lean > data/fs131/ifr2/statements-merged.txt
-/
open Lean Elab Command Meta

namespace FS131IFR2Dump

/-- The twenty-seven modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.ClassRatio,
   `Proofs.HadwigerNelson.Collapse.Headline,
   `Proofs.HadwigerNelson.Collapse.Density.Defs,
   `Proofs.HadwigerNelson.Collapse.Density.Upper,
   `Proofs.HadwigerNelson.Collapse.Density.Headline,
   `Proofs.HadwigerNelson.Plane.TriangularPacking,
   `Proofs.HadwigerNelson.Arith.StableAboveUsable,
   `Proofs.HadwigerNelson.Rigidity.FourColourPlaces,
   `Proofs.HadwigerNelson.Instances.SqrtFiveClass,
   `Proofs.HadwigerNelson.Instances.SqrtTwentyThreeCbrtTwo,
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
   `Proofs.HadwigerNelson.Rigidity.SqrtClassFive,
   `Proofs.HadwigerNelson.PadicPlane.Tower,
   `Proofs.HadwigerNelson.PadicPlane.Values]

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

end FS131IFR2Dump
