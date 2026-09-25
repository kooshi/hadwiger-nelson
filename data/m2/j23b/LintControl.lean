-- J23b stage-0 negative control for `lake lint` (not part of the library; run with `lake env lean`).
-- (1) Coverage: how many declarations does runLinter's selector hand the linters for package `Proofs`?
-- (2) Firing: a planted def with an unused argument and no docstring must be reported by `#lint`.
import Proofs
import Batteries.Tactic.Lint
open Lean Meta Batteries.Tactic.Lint

#eval show CoreM Unit from do
  let decls ← getDeclsInPackage `Proofs
  IO.println s!"COVERAGE: getDeclsInPackage `Proofs returns {decls.size} declarations"

def j23bPlantedUnusedArg (n : Nat) (_m : Nat) (k : Nat) : Nat := n

#lint only unusedArguments docBlame in j23bPlantedUnusedArg
