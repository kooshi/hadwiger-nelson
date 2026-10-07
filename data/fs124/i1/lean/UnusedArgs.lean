import Batteries.Tactic.Lint
import Proofs.HadwigerNelson.Plane.RadiusOutside
/-!
FS124-I1 — "no binder of the 57 statements is unread by its proof", asked of Batteries' `unusedArguments` linter
(the one `lake lint` runs) declaration by declaration, with a positive line per declaration visited — the lint's
own trace says only `Passed!` — and a control: one theorem declared here with a hypothesis its proof does not
read must be reported, and its partner, which reads it, must not.
-/
open Lean Elab Command Meta

namespace FS124I1Control
/-- Planted: `hU` is not read. -/
theorem unused_hyp {U : Set ℂ} (hU : IsOpen U) (x : ℂ) : x = x := rfl
/-- Partner: `hU` is read. -/
theorem used_hyp {U : Set ℂ} (hU : IsOpen U) : IsOpen U := hU
end FS124I1Control

def fs124Modules : List Name :=
  [`Proofs.HadwigerNelson.Plane.WeakColouringOn, `Proofs.HadwigerNelson.Plane.Radius,
   `Proofs.HadwigerNelson.Plane.RadiusOutside]

run_cmd do
  let env ← getEnv
  let mut names : Array Name := #[]
  for (n, ci) in env.constants.toList do
    if n.isInternal then continue
    let some idx := env.getModuleIdxFor? n | continue
    unless fs124Modules.contains env.header.moduleNames[idx.toNat]! do continue
    if ci matches .thmInfo _ then names := names.push n
  names := names.qsort (fun a b => a.toString < b.toString)
  let mut bad := 0
  for n in names ++ #[`FS124I1Control.unused_hyp, `FS124I1Control.used_hyp] do
    let r ← liftTermElabM <| Batteries.Tactic.Lint.unusedArguments.test n
    match r with
    | some msg =>
      bad := bad + 1
      IO.println s!"UNUSED {n}: {← msg.toString}"
    | none => IO.println s!"ok {n}"
  IO.println s!"VISITED {names.size} theorems of the three modules and 2 controls; reported {bad}"
