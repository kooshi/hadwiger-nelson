import Proofs.HadwigerNelson.Arith.ThreeFourColours
import Proofs.HadwigerNelson.Instances.UpperHalfCorollaries

/-! FS131-KJ1 — the axioms of every theorem and definition of the line's modules, read from the COMPILED modules of this
worktree's library (private helpers included; names Lean generates inside a declaration skipped), one line each:

  AXIOMS <module> <public|private> <name> : [axioms, sorted]
  SORRY-FROM <name> : [the constants of the library, reachable from <name>, whose own type or value holds `sorryAx`]

and three planted records, declared here, that the reader must class as it classes them: `planted_sorry` (a `sorry`),
`planted_weil` (the declared outside theorem that is Weil's bound), `planted_clean`. The printer is FS131-IN1's
(`data/fs131/in1/lean/AxiomsCore.lean`) taken over a list of modules. -/
namespace FS131KJ1Axioms
open Lean Elab Command

theorem planted_sorry : (1 : Nat) = 1 := sorry
theorem planted_weil : True := by
  have _h := @HadwigerNelson.StandingFive.kloosterman_bound.{0}
  trivial
theorem planted_clean : (1 : Nat) = 1 := rfl

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

/-- Print the records for `names`, labelled `tag`. -/
def run (tag : String) (names : Array Name) : CommandElabM Unit := do
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
    let mut line := s!"AXIOMS {tag} {kind} {user} : {axs.toList}"
    if ax.contains ``sorryAx then
      let src := (sorrySources env n).map fun c => ((privateToUserName? c).getD c).toString
      line := line ++ s!"\nSORRY-FROM {user} : {src.toList}"
    rows := rows.push (user.toString, line)
  for (_, l) in rows.qsort (fun a b => a.1 < b.1) do
    IO.println l
  IO.println s!"AXIOMS-COUNT {tag} {rows.size}"

/-- Every constant the compiled module `m` stores. -/
def runModule (m : Name) : CommandElabM Unit := do
  let env ← getEnv
  let some i := env.header.moduleNames.findIdx? (· == m) | throwError "module {m} is not imported"
  run (m.components.getLast!.toString) (env.header.moduleData[i]!.constants.map (·.name))

end FS131KJ1Axioms

open FS131KJ1Axioms in
run_cmd do
  runModule `Proofs.HadwigerNelson.Arith.ThreeColourCharacter
  runModule `Proofs.HadwigerNelson.Arith.TorsionExtraction
  runModule `Proofs.HadwigerNelson.Arith.ThreeColourCriterion
  runModule `Proofs.HadwigerNelson.Arith.DyadicQuadratic
  runModule `Proofs.HadwigerNelson.Arith.UpperHalf
  runModule `Proofs.HadwigerNelson.Arith.QuadraticPrime
  runModule `Proofs.HadwigerNelson.Instances.UpperHalfValues
  runModule `Proofs.HadwigerNelson.Arith.ThreeFourColours
  runModule `Proofs.HadwigerNelson.Instances.UpperHalfCorollaries
  run "PLANTED" #[``planted_sorry, ``planted_weil, ``planted_clean]
