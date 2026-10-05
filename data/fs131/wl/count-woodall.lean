import Proofs
-- FS131-WL1: count the declarations of the five Woodall modules the vacuity scan counts (`isOurs`, not internal), and those it
-- skips as refutations (its `isRefutation`, copied verbatim from `scripts/Vacuity.lean`), to reconcile the scan's
-- `declarations=` and `refutations-skipped=` against `main`'s run. Iteration aid, read with the scan's own logic.
open Lean Meta Elab Command

def isNegationConcl (concl : Expr) : Bool := concl.isAppOf ``Not || concl.isAppOf ``Ne

def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

#eval show CommandElabM Unit from liftTermElabM do
  let env ← getEnv
  let mut decls : Nat := 0
  let mut refs : Nat := 0
  for (n, _ci) in env.constants.toList do
    if n.isInternal then continue
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    if !(`Proofs.HadwigerNelson.Plane.Woodall).isPrefixOf m then continue
    decls := decls + 1
    if ← (try isRefutation _ci.type catch _ => pure false) then
      refs := refs + 1
      logInfo m!"REFUTATION {n}"
  logInfo m!"WOODALL declarations={decls} refutations={refs}"
