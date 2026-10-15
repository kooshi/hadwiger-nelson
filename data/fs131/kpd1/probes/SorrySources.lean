import Proofs.HadwigerNelson.Rigidity.Duality
import Proofs.HadwigerNelson.Rigidity.DualConnected
/-!
FS131-KPD1 — for each headline of the duality modules (as compiled from `data/fs131/kpd1/route/`, the measured first leaves),
the declarations of this library whose own proof or value holds `sorryAx` and that the headline reaches: what the route still
waits on. Read-only. A headline that reaches no `sorryAx` prints `NONE`; a name that is not in the environment is an error.
-/
open Lean Elab Command

partial def kpd1Sources (env : Environment) (root : Name) : Array Name := Id.run do
  let mut seen : NameSet := {}
  let mut stack := #[root]
  let mut out := #[]
  while h : stack.size > 0 do
    let n := stack.back
    stack := stack.pop
    if seen.contains n then continue
    seen := seen.insert n
    let some ci := env.find? n | continue
    let used := match ci with
      | .thmInfo v => v.value.getUsedConstants ++ v.type.getUsedConstants
      | .defnInfo v => v.value.getUsedConstants ++ v.type.getUsedConstants
      | _ => ci.type.getUsedConstants
    if used.contains ``sorryAx then out := out.push n
    for m in used do
      if (`HadwigerNelson).isPrefixOf m then stack := stack.push m
  return out

elab "#kpd1_sources " ids:ident* : command => do
  let env ← getEnv
  for id in ids do
    let n := id.getId
    unless env.contains n do throwError "unknown constant {n}"
    let s := kpd1Sources env n
    logInfo m!"{n}: {if s.isEmpty then "NONE" else toString (s.toList)}"

#kpd1_sources HadwigerNelson.Rigidity.dualAnnihilator_dualCoannihilator_of_isClosed
  HadwigerNelson.Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot'
  HadwigerNelson.Rigidity.evalDualHom_surjective HadwigerNelson.Rigidity.additiveDualDualEquiv
  HadwigerNelson.Rigidity.finite_dualAnnihilator HadwigerNelson.Rigidity.connectedSpace_dual
  HadwigerNelson.Rigidity.subgroupHaar_bot HadwigerNelson.Rigidity.not_connectedSpace_dual_zmod_two
