import Proofs.HadwigerNelson.Plane.SixRing.Placeholders
import Proofs.HadwigerNelson.Outside.OAI158PaletteDensity
import Proofs.HadwigerNelson.Outside.OAI158PaletteTransport
import Proofs.HadwigerNelson.Outside.OAI158States
import Proofs.HadwigerNelson.Outside.OAI158AngularBoundary

/-!
FS132-I4, the join: the planner's four placeholders against the ported theorems, **as the kernel stores them** —
run on the merged tree while both still exist (commit `466d0fa1d`), before the placeholders' file is deleted.

For each short name: the stored type of `HadwigerNelson.SixRing.<name>` and of
`HadwigerNelson.Outside.OAI158.<name>`, compared by `Expr.equal` (structural, binder names and binder annotations
included) and by `==` (structural up to bound-variable names). The two controls at the end must read DIFFERENT:
a statement against another statement, and a statement against itself with one binder made implicit.
-/

open Lean Elab Command Meta

def cmpStored (tag : String) (a b : Expr) : CommandElabM Unit :=
  logInfo m!"{tag}: Expr.equal={a.equal b} beq={a == b}  => {if a.equal b then "IDENTICAL" else "DIFFERENT"}"

run_cmd do
  let env ← getEnv
  for n in [`palette_transfer_pair, `palette_sixty_disjoint, `two_state_impossible, `mem_spatialSupport_ae] do
    let some a := env.find? (`HadwigerNelson.SixRing ++ n) | throwError "missing placeholder {n}"
    let some b := env.find? (`HadwigerNelson.Outside.OAI158 ++ n) | throwError "missing ported {n}"
    cmpStored s!"{n}" a.type b.type
  -- controls
  let some a := env.find? `HadwigerNelson.SixRing.palette_transfer_pair | throwError "missing"
  let some b := env.find? `HadwigerNelson.Outside.OAI158.palette_sixty_disjoint | throwError "missing"
  cmpStored "CONTROL-1 (two different statements; must be DIFFERENT)" a.type b.type
  match a.type with
  | .forallE nm ty body bi =>
      let flipped := Expr.forallE nm ty body (if bi == .implicit then .default else .implicit)
      cmpStored "CONTROL-2 (one binder annotation flipped; must be DIFFERENT)" a.type flipped
  | _ => throwError "unexpected shape"

set_option pp.fullNames true in
#check @HadwigerNelson.SixRing.palette_transfer_pair
set_option pp.fullNames true in
#check @HadwigerNelson.Outside.OAI158.palette_transfer_pair
set_option pp.fullNames true in
#check @HadwigerNelson.SixRing.palette_sixty_disjoint
set_option pp.fullNames true in
#check @HadwigerNelson.Outside.OAI158.palette_sixty_disjoint
set_option pp.fullNames true in
#check @HadwigerNelson.SixRing.two_state_impossible
set_option pp.fullNames true in
#check @HadwigerNelson.Outside.OAI158.two_state_impossible
set_option pp.fullNames true in
#check @HadwigerNelson.SixRing.mem_spatialSupport_ae
set_option pp.fullNames true in
#check @HadwigerNelson.Outside.OAI158.mem_spatialSupport_ae
