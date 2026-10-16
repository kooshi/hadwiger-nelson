import Proofs
/-! FS131-IFR2 (a copy of FS131-IFR1's printer, itself FS131-ICO2's: namespace renamed, module list replaced) — the axioms of
every theorem and definition stored in the ten modules the two landings this merge joins bring or change: FS131-IFR1's six
(`Rigidity/ClassRatio`, `Collapse/Headline`, `Collapse/Density/Defs`, `Upper`, `Headline`, `Plane/TriangularPacking`) and
FS131-ICS1's five (`Rigidity/ClassRatio`, `FourColourPlaces`, `Arith/StableAboveUsable`, `Instances/SqrtFiveClass`,
`Instances/SqrtTwentyThreeCbrtTwo`), with the leaves each `sorryAx` comes from. Run from the worktree's root, under a slot:
  lake env lean data/fs131/ifr2/lean/AxiomsAll.lean > data/fs131/ifr2/axioms-all.txt -/
namespace FS131IFR2AxiomsAll
open Lean Elab Command

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
  let modules : List Name :=
    [`Proofs.HadwigerNelson.Rigidity.ClassRatio, `Proofs.HadwigerNelson.Collapse.Headline,
     `Proofs.HadwigerNelson.Collapse.Density.Defs, `Proofs.HadwigerNelson.Collapse.Density.Upper,
     `Proofs.HadwigerNelson.Collapse.Density.Headline, `Proofs.HadwigerNelson.Plane.TriangularPacking,
     `Proofs.HadwigerNelson.Rigidity.FourColourPlaces, `Proofs.HadwigerNelson.Arith.StableAboveUsable,
     `Proofs.HadwigerNelson.Instances.SqrtFiveClass, `Proofs.HadwigerNelson.Instances.SqrtTwentyThreeCbrtTwo]
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

end FS131IFR2AxiomsAll
