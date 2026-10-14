import Proofs
/-!
FS131-LP1: the refutations the vacuity scan skips, by name, in the port's modules (the scan counts them,
`refutations-skipped`, and does not list them). `isNegationConcl` and `isRefutation` are copied from
`scripts/Vacuity.lean` (lines 779–797, unchanged); the filter is the scan's (`n.isInternal` skipped), over the
constants of the 31 generated modules and `Outside/OAI158Collapse` — the modules this port adds.
-/
open Lean Lean.Meta Lean.Elab Lean.Elab.Command
namespace FS131LP1Refut
def isNegationConcl (concl : Expr) : Bool :=
  concl.isAppOf ``Not || concl.isAppOf ``Ne
def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated
end FS131LP1Refut
open FS131LP1Refut in
elab "lp1_refutations" : command => liftTermElabM do
  let env ← getEnv
  let mods := env.header.moduleNames
  let mut total := 0
  let mut found := 0
  for i in [0:mods.size] do
    let m := mods[i]!
    let s := m.toString
    unless s.startsWith "Proofs.HadwigerNelson.Outside.OAI158" do continue
    let d := env.header.moduleData[i]!
    for ci in d.constants do
      let n := ci.name
      if n.isInternal then continue
      total := total + 1
      if ← (try isRefutation ci.type catch _ => pure false) then
        found := found + 1
        IO.println s!"REFUTATION {n} @ {m}"
  IO.println s!"DONE constants={total} refutations={found} (modules Proofs.HadwigerNelson.Outside.OAI158*)"
lp1_refutations
