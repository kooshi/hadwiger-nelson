import Proofs
-- FS131-ML1: count the declarations of `Plane/ValidMap/MergeMove` and the two restored theorems (`ArcMap.exists_merge_aux`, `Moves`;
-- `ArcMap.exists_merge`, `Contact`) as the vacuity scan counts them (not internal; `isRefutation` copied verbatim from
-- `scripts/Vacuity.lean`), to reconcile `declarations=` and `refutations-skipped=` against `main`'s run. Read with the scan's own logic.
open Lean Meta Elab Command

def isNegationConcl (concl : Expr) : Bool := concl.isAppOf ``Not || concl.isAppOf ``Ne

def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

#eval show CommandElabM Unit from liftTermElabM do
  let env ← getEnv
  let restored : List Name := [`HadwigerNelson.Plane.ArcMap.exists_merge_aux, `HadwigerNelson.Plane.ArcMap.exists_merge]
  let mut decls : Nat := 0
  let mut refs : Nat := 0
  for (n, ci) in env.constants.toList do
    if n.isInternal then continue
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    if !(m == `Proofs.HadwigerNelson.Plane.ValidMap.MergeMove || restored.contains n) then continue
    decls := decls + 1
    if ← (try isRefutation ci.type catch _ => pure false) then
      refs := refs + 1
      logInfo m!"REFUTATION {n}"
  logInfo m!"MERGE declarations={decls} refutations={refs}"
