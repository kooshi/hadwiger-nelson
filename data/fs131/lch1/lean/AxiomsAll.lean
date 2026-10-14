import Proofs
/-! FS131-LCH1 — the axioms of every theorem and definition stored in the chain's compiled modules on the joined tree
(every module of `Proofs/HadwigerNelson/Rigidity/`, the five ported `Outside/OAI015*` modules, `Plane/WindowDensity`,
M13's `Arith/CircleCos`, M15's two `Instances` modules and this job's `Plane/MOneBound`: the modules the joined tree holds
that `main` does not), and of `main`'s two modules whose records this job changed (`Plane/OneClass/InvariantLaw`,
`Arith/UpperHalf`), with the leaves each `sorryAx` comes from. FS131-IJN1's printer (`data/fs131/ijn1/lean/AxiomsAll.lean`),
its module list replaced. Run from the worktree against its compiled library:
  lake env lean data/fs131/lch1/lean/AxiomsAll.lean > data/fs131/lch1/axioms-all.txt -/
namespace FS131LCH1AxiomsAll
open Lean Elab Command

/-- The modules read: the chain's on the joined tree, and main's two this job changed. -/
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
   `Proofs.HadwigerNelson.Plane.WindowDensity,
   `Proofs.HadwigerNelson.Rigidity.SqrtClassFive,
   `Proofs.HadwigerNelson.Instances.SqrtFortySevenFive,
   `Proofs.HadwigerNelson.Instances.SqrtClassValues,
   `Proofs.HadwigerNelson.Arith.CircleCos,
   `Proofs.HadwigerNelson.Plane.MOneBound,
   `Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw,
   `Proofs.HadwigerNelson.Arith.UpperHalf]

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

end FS131LCH1AxiomsAll
