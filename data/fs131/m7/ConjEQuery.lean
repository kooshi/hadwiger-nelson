import Proofs.HadwigerNelson.Plane.Chord
import Proofs.HadwigerNelson.Plane.SixFragment
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mut hits : Array String := #[]
  for (n, _) in env.constants.toList do
    if n.components.getLast? == some `conj_e then
      let m := (env.getModuleIdxFor? n).map (fun i => env.header.moduleNames[i.toNat]!)
      hits := hits.push s!"{n}  declared in module {m}"
  for h in hits.qsort (· < ·) do
    logInfo h
  logInfo s!"constants named …conj_e: {hits.size}"
