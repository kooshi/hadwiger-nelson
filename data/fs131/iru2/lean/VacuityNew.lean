import Proofs
/-! FS131-IRU2 (a copy of FS131-IRU1's, its run line changed; on the merged build) — the vacuity scan's two counts read for the five modules of the ring of unit vectors and `Rigidity/AdmissiblePrime` (FS131-ICO2's
`data/fs131/ico2/lean/VacuityNew.lean`, its module list written here), with the scan's own predicates
copied from `scripts/Vacuity.lean` (`Name.isInternal`; `isNegationConcl`, `isRefutation`): every constant the scan counts in
`declarations=` and every one it counts in `refutations-skipped`. Run from the worktree's root, under a slot:
  lake env lean data/fs131/iru2/lean/VacuityNew.lean > data/fs131/iru2/vacuity-new.txt -/
open Lean Meta Elab Command

namespace FS131IRU2VacuityNew

def isNegationConcl (concl : Expr) : Bool :=
  concl.isAppOf ``Not || concl.isAppOf ``Ne

def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.AdmissiblePrime, `Proofs.HadwigerNelson.Rigidity.NormOneGen,
   `Proofs.HadwigerNelson.Rigidity.UnitRingEq, `Proofs.HadwigerNelson.Rigidity.UsablePrime,
   `Proofs.HadwigerNelson.Rigidity.PlaneComponents, `Proofs.HadwigerNelson.Instances.UnitRingModels]

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

end FS131IRU2VacuityNew
