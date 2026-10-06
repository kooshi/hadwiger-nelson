import Proofs.HadwigerNelson.Plane.SixFragment
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods := env.header.moduleNames
  logInfo s!"SixFragment's environment imports Plane.Chord: {mods.contains `Proofs.HadwigerNelson.Plane.Chord}"
  let mut k := 0
  for (n, _) in env.constants.toList do
    if n.components.getLast? == some `conj_e then
      k := k + 1
      let m := (env.getModuleIdxFor? n).map (fun i => mods[i.toNat]!)
      logInfo s!"{n}  declared in module {m}"
  logInfo s!"constants named …conj_e: {k}"
#check @HadwigerNelson.Plane.conj_e
