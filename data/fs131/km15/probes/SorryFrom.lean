import Proofs.HadwigerNelson.Instances.SqrtFortySevenFive
import Proofs.HadwigerNelson.Instances.SqrtClassValues
/-! FS131-KM15 — the leaves each `sorryAx` comes from, for the value and its neighbours: the constants of the library,
reachable from a declaration, whose own type or value holds `sorryAx` (the reachability of FS131-IN1's
`data/fs131/in1/lean/AxiomsCore.lean`, copied). Controls: a sorry-free theorem must print `[]`, and
`five_le_localBound_sqrt47` must print the link and nothing else. -/
open Lean Elab Command

def km15SorrySources (env : Environment) (n : Name) : Array Name := Id.run do
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

elab "#km15_sorry_from " id:ident : command => do
  let env ← getEnv
  let n := id.getId
  let src := (km15SorrySources env n).map fun c => ((privateToUserName? c).getD c).toString
  logInfo m!"SORRY-FROM {n} : {src.toList}"

#km15_sorry_from HadwigerNelson.SqrtFortySeven.stablePrime_card_sqrt47
#km15_sorry_from HadwigerNelson.SqrtFortySeven.five_le_localBound_sqrt47
#km15_sorry_from HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
#km15_sorry_from HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber
