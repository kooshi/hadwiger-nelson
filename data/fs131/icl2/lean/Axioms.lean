import Proofs.HadwigerNelson.Rigidity.CountDescent
/-! FS131-ICL2 — the axioms of every theorem and definition of `Rigidity/FiniteZhang`, `CountTorus`, `CountResidue`,
`CountCompletion` and `CountDescent`, as their compiled `.olean`s store them (private helpers included; names Lean generates inside a
declaration skipped), one line each, sorted:

  AXIOMS <public|private> <name> : [axioms, sorted]
  SORRY-FROM <name> : [the constants of the library, reachable from <name>, whose own type or value holds `sorryAx`]

The reader and printer are FS131-IN1's (`data/fs131/in1/lean/AxiomsCore.lean`, copied under this job's namespace); the names
are every constant of the five modules' own compiled data. The reader of this output is `tools/fs131_icl2_axioms.py`. -/
namespace FS131ICL2Axioms
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
      -- `ConstantInfo.value?` is `none` for a theorem at the pin: read the stored proof by its constructor
      let val : Option Expr := match ci with
        | .thmInfo v => some v.value | .defnInfo v => some v.value | .opaqueInfo v => some v.value | _ => none
      let used := ci.type.getUsedConstants ++ (val.map (·.getUsedConstants)).getD #[]
      if used.contains ``sorryAx then out := out.push c
      for u in used do stack := stack.push u
  return out.qsort (fun a b => a.toString < b.toString)

/-- Print the records for `names`. -/
def run (names : Array Name) : CommandElabM Unit := do
  let env ← getEnv
  let mut rows : Array (String × String) := #[]
  for n in names do
    let some ci := env.find? n | continue
    let isDecl := match ci with | .thmInfo _ => true | .defnInfo _ => true | _ => false
    if !isDecl then continue
    let user := (privateToUserName? n).getD n
    if user.isInternalDetail then continue
    let ax ← liftCoreM <| collectAxioms n
    let axs := (ax.map toString).qsort (· < ·)
    let kind := if (privateToUserName? n).isSome then "private" else "public"
    let mut line := s!"AXIOMS {kind} {user} : {axs.toList}"
    if ax.contains ``sorryAx then
      let src := (sorrySources env n).map fun c => ((privateToUserName? c).getD c).toString
      line := line ++ s!"\nSORRY-FROM {user} : {src.toList}"
    rows := rows.push (user.toString, line)
  for (_, l) in rows.qsort (fun a b => a.1 < b.1) do
    IO.println l
  IO.println s!"AXIOMS-COUNT {rows.size}"

end FS131ICL2Axioms

open Lean Elab Command in
/-- Every constant stored in the five modules' compiled data. -/
def FS131ICL2Axioms.moduleNames : CommandElabM (Array Name) := do
  let env ← getEnv
  let mods : List Name := [`Proofs.HadwigerNelson.Rigidity.FiniteZhang, `Proofs.HadwigerNelson.Rigidity.CountTorus,
    `Proofs.HadwigerNelson.Rigidity.CountResidue, `Proofs.HadwigerNelson.Rigidity.CountCompletion,
    `Proofs.HadwigerNelson.Rigidity.CountDescent]
  let mut out : Array Name := #[]
  for m in mods do
    let some i := env.header.moduleNames.findIdx? (· == m) | throwError "module {m} is not imported"
    out := out ++ (env.header.moduleData[i]!.constants.map (·.name))
  return out

open Lean Elab Command in
#eval show CommandElabM Unit from do
  FS131ICL2Axioms.run (← FS131ICL2Axioms.moduleNames)
