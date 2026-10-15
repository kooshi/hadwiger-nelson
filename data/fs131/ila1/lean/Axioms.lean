import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Proofs.HadwigerNelson.Rigidity.EntropySplitMax
/-! FS131-ILA1 — the axioms of every theorem and definition stored in the compiled modules this job writes
(`Rigidity/AdmissiblePrime`, new; `Rigidity/UnitCircle`, the proof of `exists_admissiblePair`; private helpers included;
names Lean generates inside a declaration skipped), one line each, sorted by name:

  AXIOMS <module> <public|private> <name> : [axioms, sorted]
  SORRY-FROM <name> : [the constants of the library, reachable from <name>, whose own type or value holds `sorryAx`]

then one planted record, a leaf of `Rigidity/EntropySplitMax` that rests on `sorry` in this tree (`rotInv_sub_maxMultiple`),
under the module name `PLANT` (the reader, `tools/fs131_ila1_axioms.py`, must report it).
Run from the worktree against its compiled library:
  lake env lean data/fs131/ila1/lean/Axioms.lean > data/fs131/ila1/axioms-<when>.txt
(FS131-IM11's printer, `data/fs131/im11/lean/Axioms.lean`, aimed at these modules; that one is not edited.) -/
namespace FS131ILA1Axioms
open Lean Elab Command

/-- The modules read. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.AdmissiblePrime, `Proofs.HadwigerNelson.Rigidity.UnitCircle]

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
    let src := (sorrySources env n).map fun c => ((privateToUserName? c).getD c).toString
    line := line ++ s!"\nSORRY-FROM {user} : {src.toList}"
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
  match ← record env "PLANT" `HadwigerNelson.Rigidity.rotInv_sub_maxMultiple with
  | some l => IO.println l
  | none => throwError "the planted record is missing"
  IO.println s!"AXIOMS-COUNT {count}"

#eval run

end FS131ILA1Axioms
