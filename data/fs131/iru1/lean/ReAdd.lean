import Proofs.HadwigerNelson.Rigidity.UnitRingEq
/-!
FS131-IRU1 — the one ruled binder drop of this landing (inventory item 1049), undone by term surgery on the stored type of
the build being gated, so that it can be compared by hash (`Expr.hash`, which reads no binder name and no binder kind) with
the type the skeleton's print holds (`data/fs131/iru1/statements-before.txt.gz`). After FS131-ICT2's
`data/fs131/ict2/lean/ReAdd.lean` (its `insertInstAfter`).

* **DROPPED**: the instance binder `[NumberField ↥F]` of `Rigidity.not_isRamified_of_odd_mem`, put back after its one
  leading binder `{F : Subfield ℝ}`; its domain elaborated from the skeleton's own text at that bound variable, in this
  module's import closure.

Prints `AFTER <name> <hash>`, `READD <name> <hash>` (the surgery) and two controls that must differ from the skeleton's hash:
`CONTROL-TRUE` (the domain `True` in place of the binder's) and `CONTROL-POS` (the right domain one binder later).
Run from the worktree's root: `lake env lean data/fs131/iru1/lean/ReAdd.lean > data/fs131/iru1/readd.txt`.
-/
open Lean Meta Elab Term Command

namespace FS131IRU1ReAdd

/-- Insert one instance-implicit binder, its domain built from the leading binders, after the first `k` binders of `t`. -/
def insertInstAfter (t : Expr) (k : Nat) (dom : Array Expr → TermElabM Expr) : TermElabM Expr :=
  forallBoundedTelescope t k fun xs body => do
    let d ← dom xs
    withLocalDecl `inst .instImplicit d fun y => do mkForallFVars (xs.push y) body

/-- Elaborate `stx` at the bound variables in scope, with no expected type, and instantiate its metavariables. -/
def elabClosed (stx : Syntax) : TermElabM Expr := do
  let e ← Term.elabTerm stx none
  Term.synthesizeSyntheticMVarsNoPostponing
  let e ← instantiateMVars e
  if e.hasMVar then throwError "unassigned metavariables in {e}"
  pure e

def typeOf (n : Name) : TermElabM Expr := do
  let some ci := (← getEnv).find? n | throwError "unknown {n}"
  pure ci.type

def run : TermElabM Unit := do
  let n := ``HadwigerNelson.Rigidity.not_isRamified_of_odd_mem
  let t ← typeOf n
  let nf : Array Expr → TermElabM Expr := fun _ => do elabClosed (← `(NumberField ↥$(mkIdent `F)))
  IO.println s!"AFTER {n} {t.hash}"
  IO.println s!"READD {n} {(← insertInstAfter t 1 nf).hash}"
  IO.println s!"CONTROL-TRUE {n} {(← insertInstAfter t 1 fun _ => pure (mkConst ``True)).hash}"
  IO.println s!"CONTROL-POS {n} {(← insertInstAfter t 2 nf).hash}"

#eval run

end FS131IRU1ReAdd
