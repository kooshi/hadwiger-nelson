import Proofs
-- FS131-OL1: count the declarations of `Plane/ValidMap/OpenMove` as the vacuity scan counts them (not internal; `isRefutation`,
-- `isNegationConcl` and `isGeneratedDecl` copied verbatim from `scripts/Vacuity.lean`), to reconcile `declarations=` and
-- `refutations-skipped=` against `main`'s gated run. Read with the scan's own logic, restricted to one module; it prints every
-- refutation by name, and how many declarations are generated API (counted in `declarations=`, never a site) or written by hand.
-- `--plant` is a second file, `count-open-plant.lean`: the same count over a module that does not exist, which must print 0.
open Lean Meta Elab Command

def isNegationConcl (concl : Expr) : Bool := concl.isAppOf ``Not || concl.isAppOf ``Ne

def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

def isGeneratedDecl (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  (match ci with | .ctorInfo _ | .recInfo _ => true | _ => false) ||
  isAuxRecursor env n || isNoConfusion env n || (env.getProjectionFnInfo? n).isSome ||
  (match n with | .str _ s => s == "ctorIdx" || s == "noConfusionType" | _ => false)

def countModule (module : Name) : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let mut decls : Nat := 0
  let mut refs : Nat := 0
  let mut gen : Nat := 0
  let mut thms : Nat := 0
  let mut defs : Nat := 0
  let mut other : Array Name := #[]
  for (n, ci) in env.constants.toList do
    if n.isInternal then continue
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    if m != module then continue
    decls := decls + 1
    if isGeneratedDecl env n ci then
      gen := gen + 1
      logInfo m!"GENERATED {n}"
    else match ci with
      | .thmInfo _ => thms := thms + 1; logInfo m!"THM {n}"
      | .defnInfo _ => defs := defs + 1; logInfo m!"DEF {n}"
      | _ => other := other.push n; logInfo m!"OTHER {n}"
    if ← (try isRefutation ci.type catch _ => pure false) then
      refs := refs + 1
      logInfo m!"REFUTATION {n}"
  logInfo m!"MODULE {module} declarations={decls} refutations={refs} generated={gen} theorems={thms} definitions={defs} other={other.size}"

#eval countModule `Proofs.HadwigerNelson.Plane.ValidMap.OpenMoveX
