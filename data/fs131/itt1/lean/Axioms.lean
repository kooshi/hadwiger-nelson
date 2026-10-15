import Proofs.HadwigerNelson.Rigidity.TateExists
import Proofs.HadwigerNelson.Rigidity.ThinBoxes
import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
/-! FS131-ITT1 — the axioms of every theorem and definition stored in the compiled modules this job writes
(`Rigidity/RingScope`, `TateModel`, `TateLocal`, `TateArch`, `TateCharacter`, and `ThinBoxes`, which the move edits; private
helpers included; names Lean generates inside a declaration skipped), one line each, sorted by name:

  AXIOMS <module> <public|private> <name> : [axioms, sorted]
  SORRY-FROM <name> : [the constants of the library, reachable from <name>, whose own type or value holds `sorryAx`]

then, for information, the same for `Rigidity/TateKernel` and `Rigidity/TateExists` (`DOWNSTREAM-…`), and one planted
record, a declaration of `Rigidity/PositiveEntropy` that rests on the chain's declared printed theorem
(`positive_entropy_rigidity_of_polishSpace`), under the module name `PLANT`: the reader (`tools/fs131_itt1_axioms.py`) must
report it. Run from the worktree against its compiled library:
  lake env lean data/fs131/itt1/lean/Axioms.lean > data/fs131/itt1/axioms-<when>.txt
(FS131-IP23's printer, `data/fs131/ip23/lean/Axioms.lean`, aimed at these modules.) -/
namespace FS131ITT1Axioms
open Lean Elab Command

/-- The modules read. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.RingScope, `Proofs.HadwigerNelson.Rigidity.TateModel,
   `Proofs.HadwigerNelson.Rigidity.TateLocal, `Proofs.HadwigerNelson.Rigidity.TateArch,
   `Proofs.HadwigerNelson.Rigidity.TateCharacter, `Proofs.HadwigerNelson.Rigidity.ThinBoxes]

/-- The downstream modules, printed for information. -/
def downstream : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.TateKernel, `Proofs.HadwigerNelson.Rigidity.TateExists]

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
  match ← record env "PLANT" `HadwigerNelson.Rigidity.positive_entropy_rigidity_of_polishSpace with
  | some l => IO.println l
  | none => throwError "the planted record is missing"
  IO.println s!"AXIOMS-COUNT {count}"
  for m in downstream do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to read"
    let mut rows : Array (String × String) := #[]
    for ci in data[i]!.constants do
      if let some l ← record env s!"DOWNSTREAM-{m}" ci.name then
        rows := rows.push (((privateToUserName? ci.name).getD ci.name).toString, l)
    for (_, l) in rows.qsort (fun a b => a.1 < b.1) do
      IO.println l

#eval run

end FS131ITT1Axioms
