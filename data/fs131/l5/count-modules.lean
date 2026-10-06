import Proofs
/-!
FS131-L5 — the declarations of every module of the package as the vacuity scan counts them, module by module, so that the scan's
`declarations=` and `refutations-skipped=` can be reconciled between `main`'s gated run and the landing's (after FS131-OL1's
`data/fs131/ol/count-open.lean`, which counted one module). `isOurs`, `isNegationConcl` and `isRefutation` are copied verbatim from
`scripts/Vacuity.lean` (the scan cannot be imported: it runs its audit when elaborated). Read-only.

One `MODULE <name> declarations=<n> refutations=<r> theorems=<t>` line per module with at least one counted declaration, one
`THM <module> <name>` line per theorem that is not machine-written API, and a `TOTAL` line whose two counts must equal the scan's.
Run from a worktree with a built library:  lake env lean data/fs131/l5/count-modules.lean
-/
open Lean Meta Elab Command

namespace L5Count

def isOurs (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | some idx =>
    match env.header.moduleNames[idx.toNat]? with
    | some m => (`Proofs.HadwigerNelson).isPrefixOf m || m == `Proofs
    | none => false
  | none => false

def isNegationConcl (concl : Expr) : Bool :=
  concl.isAppOf ``Not || concl.isAppOf ``Ne

def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

def isGeneratedDecl (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  (match ci with | .ctorInfo _ | .recInfo _ => true | _ => false) ||
  isAuxRecursor env n || isNoConfusion env n || (env.getProjectionFnInfo? n).isSome ||
  (match n with | .str _ s => s == "ctorIdx" || s == "noConfusionType" | _ => false)

def run : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let mut decls : Std.HashMap Name Nat := {}
  let mut refs : Std.HashMap Name Nat := {}
  let mut thms : Std.HashMap Name Nat := {}
  let mut total : Nat := 0
  let mut totalRefs : Nat := 0
  let mut thmLines : Array (Name × Name) := #[]
  for (n, ci) in env.constants.toList do
    if n.isInternal || !isOurs env n then continue
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    total := total + 1
    decls := decls.insert m (decls.getD m 0 + 1)
    if ← (try isRefutation ci.type catch _ => pure false) then
      totalRefs := totalRefs + 1
      refs := refs.insert m (refs.getD m 0 + 1)
    if !isGeneratedDecl env n ci then
      if let .thmInfo _ := ci then
        thms := thms.insert m (thms.getD m 0 + 1)
        thmLines := thmLines.push (m, n)
  logInfo m!"=== L5 COUNT ==="
  for (m, d) in decls.toArray.qsort (fun a b => a.1.toString < b.1.toString) do
    logInfo m!"MODULE {m} declarations={d} refutations={refs.getD m 0} theorems={thms.getD m 0}"
  for (m, n) in thmLines.qsort (fun a b => a.1.toString < b.1.toString || (a.1 == b.1 && a.2.toString < b.2.toString)) do
    logInfo m!"THM {m} {n}"
  logInfo m!"TOTAL declarations={total} refutations={totalRefs} modules={decls.size} theorems={thmLines.size}"
  logInfo m!"=== END ==="

end L5Count

#eval L5Count.run
