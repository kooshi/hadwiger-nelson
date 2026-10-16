import Proofs.HadwigerNelson.Rigidity.UnitRingEq
import Batteries.Tactic.Lint
open Lean Meta Elab Command Batteries.Tactic.Lint
-- every public constant of the two modules, through the environment linters `lake lint` runs
#eval show CommandElabM Unit from do
  let env ← getEnv
  for m in [`Proofs.HadwigerNelson.Rigidity.NormOneGen, `Proofs.HadwigerNelson.Rigidity.UnitRingEq] do
    let some i := env.header.moduleNames.findIdx? (· == m) | throwError "no {m}"
    for ci in env.header.moduleData[i]!.constants do
      let n := ci.name
      if n.isInternalDetail then continue
      let r ← liftTermElabM <| unusedArguments.test n
      match r with
      | some msg => logInfo m!"UNUSED {n}: {msg}"
      | none => logInfo m!"ok {n}"
