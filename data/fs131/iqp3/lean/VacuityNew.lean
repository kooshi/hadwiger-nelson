import Proofs
/-! FS131-IQP3 — the vacuity scan's two counts read for the eight modules of this landing, with the scan's own predicates
copied from `scripts/Vacuity.lean` (`Name.isInternal`; `isNegationConcl`, `isRefutation`): every constant the scan counts in
`declarations=` and every one it counts in `refutations-skipped`. FS131-ICO2's reader, its module list written here. Run from
the worktree's root, under a slot:
  lake env lean data/fs131/iqp3/lean/VacuityNew.lean > data/fs131/iqp3/vacuity-new.txt -/
open Lean Meta Elab Command

namespace FS131IQP3VacuityNew

def isNegationConcl (concl : Expr) : Bool :=
  concl.isAppOf ``Not || concl.isAppOf ``Ne

def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

def modules : List Name :=
  [`Proofs.HadwigerNelson.PadicPlane.Basic, `Proofs.HadwigerNelson.PadicPlane.Measure,
   `Proofs.HadwigerNelson.PadicPlane.Upper, `Proofs.HadwigerNelson.PadicPlane.Tower,
   `Proofs.HadwigerNelson.PadicPlane.Values, `Proofs.HadwigerNelson.Arith.FibreCert7,
   `Proofs.HadwigerNelson.Arith.FibreCert7Check, `Proofs.HadwigerNelson.Arith.FibreCert7Bound]

def run : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let mods := env.header.moduleNames
  for m in modules do
    let some i := mods.findIdx? (· == m) | throwError "module {m} is not imported"
    let mut n0 := 0
    for ci in env.header.moduleData[i]!.constants do
      let n := ci.name
      if n.isInternal then continue
      n0 := n0 + 1
      IO.println s!"DECL {m} {n}"
      if ← (try isRefutation ci.type catch _ => pure false) then IO.println s!"REFUTATION {m} {n}"
    IO.println s!"COUNT {m} {n0}"

#eval run

end FS131IQP3VacuityNew
