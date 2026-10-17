import Proofs
/-! FS131-ISF2 (FS131-ISF1's copy of FS131-LGT1's printer, its module list file moved to this job's copy) — the axioms of every theorem and definition
stored in the modules this job adds or changes (`data/fs131/isf2/modules.txt`), with the leaves each `sorryAx` comes from.
Run from the worktree's root: lake env lean data/fs131/isf2/lean/AxiomsAll.lean > data/fs131/isf2/axioms-all.txt -/
namespace FS131ISF2AxiomsAll
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
  let text ← IO.FS.readFile "data/fs131/isf2/modules.txt"
  let modules : List Name := (text.splitOn "\n").filterMap fun s =>
    let t := s.trimAscii.toString
    if t.isEmpty then none else some t.toName
  if modules.length == 0 then throwError "no modules read"
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

end FS131ISF2AxiomsAll
