import Proofs.HadwigerNelson.Rigidity.APlus
import Proofs.HadwigerNelson.Rigidity.AdmissiblePrime
import Proofs.HadwigerNelson.Rigidity.Annihilator
import Proofs.HadwigerNelson.Rigidity.BochnerTau
import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.ChainHeadline
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
import Proofs.HadwigerNelson.Outside.OAI015ErgodicDecomposition
import Proofs.HadwigerNelson.Outside.OAI015Generating
import Proofs.HadwigerNelson.Outside.OAI015Maximal
import Proofs.HadwigerNelson.Outside.OAI015Mixtures
import Proofs.HadwigerNelson.Outside.OAI015Shannon
import Proofs.HadwigerNelson.Plane.OneAvoidingDensity
import Proofs.HadwigerNelson.Plane.WindowDensity
/-! FS131-IJN1 — the axioms of every theorem and definition stored in the joined chain's 54 compiled modules (every
module of `Proofs/HadwigerNelson/Rigidity/`, the five ported `Outside/OAI015*` modules, `Plane/OneAvoidingDensity` and
`Plane/WindowDensity`: the modules of this branch that `main` does not hold), in the format of
`data/fs131/ijn1/lean/Axioms.lean` (this job's nine modules' printer, which it extends). The draft of the audit's block for
the landing is generated from it (`tools/fs131_ijn1_audit_block.py`). Run from the worktree against its compiled library:
  lake env lean data/fs131/ijn1/lean/AxiomsAll.lean > data/fs131/ijn1/axioms-all.txt -/
namespace FS131IJN1AxiomsAll
open Lean Elab Command

/-- The modules read: the joined chain's. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.APlus,
   `Proofs.HadwigerNelson.Rigidity.AdmissiblePrime,
   `Proofs.HadwigerNelson.Rigidity.Annihilator,
   `Proofs.HadwigerNelson.Rigidity.BochnerTau,
   `Proofs.HadwigerNelson.Rigidity.ChainAtTA,
   `Proofs.HadwigerNelson.Rigidity.ChainHeadline,
   `Proofs.HadwigerNelson.Rigidity.ClassRatio,
   `Proofs.HadwigerNelson.Rigidity.ContinuityGroup,
   `Proofs.HadwigerNelson.Rigidity.CountCompletion,
   `Proofs.HadwigerNelson.Rigidity.CountDescent,
   `Proofs.HadwigerNelson.Rigidity.CountExtension,
   `Proofs.HadwigerNelson.Rigidity.CountModels,
   `Proofs.HadwigerNelson.Rigidity.CountResidue,
   `Proofs.HadwigerNelson.Rigidity.CountTorus,
   `Proofs.HadwigerNelson.Rigidity.DualConnected,
   `Proofs.HadwigerNelson.Rigidity.DualGroup,
   `Proofs.HadwigerNelson.Rigidity.Duality,
   `Proofs.HadwigerNelson.Rigidity.Entropy,
   `Proofs.HadwigerNelson.Rigidity.EntropyFibres,
   `Proofs.HadwigerNelson.Rigidity.EntropySplitMax,
   `Proofs.HadwigerNelson.Rigidity.FiniteZhang,
   `Proofs.HadwigerNelson.Rigidity.GlobalPoint,
   `Proofs.HadwigerNelson.Rigidity.HaarMultiple,
   `Proofs.HadwigerNelson.Rigidity.Herglotz,
   `Proofs.HadwigerNelson.Rigidity.InvariantMeasure,
   `Proofs.HadwigerNelson.Rigidity.Multipliers,
   `Proofs.HadwigerNelson.Rigidity.Pieces,
   `Proofs.HadwigerNelson.Rigidity.PlaceSizes,
   `Proofs.HadwigerNelson.Rigidity.PlaneZhang,
   `Proofs.HadwigerNelson.Rigidity.PositiveEntropy,
   `Proofs.HadwigerNelson.Rigidity.RingScope,
   `Proofs.HadwigerNelson.Rigidity.Solenoid,
   `Proofs.HadwigerNelson.Rigidity.SolenoidErgodic,
   `Proofs.HadwigerNelson.Rigidity.SpectralSubspace,
   `Proofs.HadwigerNelson.Rigidity.SubgroupHaar,
   `Proofs.HadwigerNelson.Rigidity.TateArch,
   `Proofs.HadwigerNelson.Rigidity.TateCharacter,
   `Proofs.HadwigerNelson.Rigidity.TateExists,
   `Proofs.HadwigerNelson.Rigidity.TateKernel,
   `Proofs.HadwigerNelson.Rigidity.TateLocal,
   `Proofs.HadwigerNelson.Rigidity.TateModel,
   `Proofs.HadwigerNelson.Rigidity.ThinBoxes,
   `Proofs.HadwigerNelson.Rigidity.TraceSplit,
   `Proofs.HadwigerNelson.Rigidity.UnitCircle,
   `Proofs.HadwigerNelson.Rigidity.WanderingShells,
   `Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed,
   `Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames,
   `Proofs.HadwigerNelson.Outside.OAI015ErgodicDecomposition,
   `Proofs.HadwigerNelson.Outside.OAI015Generating,
   `Proofs.HadwigerNelson.Outside.OAI015Maximal,
   `Proofs.HadwigerNelson.Outside.OAI015Mixtures,
   `Proofs.HadwigerNelson.Outside.OAI015Shannon,
   `Proofs.HadwigerNelson.Plane.OneAvoidingDensity,
   `Proofs.HadwigerNelson.Plane.WindowDensity]

/-- The constants of the library, reachable from `n`, that mention `sorryAx` directly. -/
def sorrySources (env : Environment) (n : Name) : Array Name := Id.run do
  let isOurs (c : Name) : Bool := match env.getModuleIdxFor? c with
    | none => true
    | some i => (env.header.moduleNames[i.toNat]!).getRoot == `Proofs
  let mut seen : NameSet := {}
  let mut stack : Array Name := #[n]
  let mut out : Array Name := #[]
  while !stack.isEmpty do
    let c := stack.back!
    stack := stack.pop
    if seen.contains c then continue
    seen := seen.insert c
    if !isOurs c then continue
    match env.find? c with
    | none => pure ()
    | some ci =>
      let val : Option Expr := match ci with
        | .thmInfo v => some v.value | .defnInfo v => some v.value | .opaqueInfo v => some v.value | _ => none
      let used := ci.type.getUsedConstants ++ (val.map (·.getUsedConstants)).getD #[]
      if used.contains ``sorryAx then out := out.push c
      for u in used do stack := stack.push u
  return out.qsort (fun a b => a.toString < b.toString)

/-- One record. -/
def record (env : Environment) (modLabel : String) (n : Name) : CommandElabM (Option String) := do
  let some ci := env.find? n | return none
  let isDecl := match ci with | .thmInfo _ => true | .defnInfo _ => true | _ => false
  if !isDecl then return none
  let user := (privateToUserName? n).getD n
  if user.isInternalDetail then return none
  let ax ← liftCoreM <| collectAxioms n
  let axs := (ax.map toString).qsort (· < ·)
  let kind := if (privateToUserName? n).isSome then "private" else "public"
  let mut line := s!"AXIOMS {modLabel} {kind} {user} : {axs.toList}"
  if ax.contains ``sorryAx then
    let srcs := sorrySources env n
    let src := srcs.map fun c => ((privateToUserName? c).getD c).toString
    line := line ++ s!"\nSORRY-FROM {user} : {src.toList}"
    for c in srcs do
      let modName := match env.getModuleIdxFor? c with
        | some i => (env.header.moduleNames[i.toNat]!).toString
        | none => "this-file"
      let ln ← match ← liftCoreM (findDeclarationRanges? c) with
        | some r => pure (toString r.selectionRange.pos.line)
        | none => pure "?"
      line := line ++ s!"\nSORRY-LEAF {user} {((privateToUserName? c).getD c)} {modName} l.{ln}"
  return some line

/-- Print the records. -/
def run : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut count := 0
  for m in modules do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to read"
    let mut rows : Array (String × String) := #[]
    for ci in data[i]!.constants do
      if let some l ← record env m.toString ci.name then
        rows := rows.push (((privateToUserName? ci.name).getD ci.name).toString, l)
    for (_, l) in rows.qsort (fun a b => a.1 < b.1) do
      IO.println l
    count := count + rows.size
  match ← record env "PLANT" `HadwigerNelson.Rigidity.positive_entropy_rigidity_of_polishSpace with
  | some l => IO.println l
  | none => throwError "the planted record is missing"
  IO.println s!"AXIOMS-COUNT {count}"

#eval run

end FS131IJN1AxiomsAll
