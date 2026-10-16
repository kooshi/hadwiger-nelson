import Proofs.HadwigerNelson.CayleyThree.Density
/-!
FS131-ICT2 — the three ruled statement changes of the three-colour landing, undone by term surgery on the stored types of
the build being gated, so that each can be compared by hash (`Expr.hash`, which reads no binder name) with the type the
skeleton's print holds (`data/fs131/ict1/statements-before.txt.gz`). After FS131-LCH1's `data/fs131/lch1/lean/ReAdd.lean`.

* **DROPPED** (inventory item 1012): the explicit binder `(hc : ProperAlong s c)` of `CayleyThree.even_pmHeight_sub_sum`,
  put back after its five leading binders `{A} [AddCommGroup A] {m} {s} {c}`; the explicit binder
  `(hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M)` of `CayleyThree.exists_le_mul_of_imp_eq_zero`, put back after `{ι} [Finite ι] (M)`.
  Each domain is elaborated from the skeleton's own text, at the bound variables, in this module's import closure (the
  closure the statement was elaborated in: `Density` imports `Fibre`).
* **CORRECTED** (inventory item 1003): the right side of `CayleyThree.mcshane_model`, `l1 x`, replaced by the skeleton's
  `∑ j, x j`; the line `RHS-IS-L1` says whether the stored right side is exactly the elaborated `l1 x`.

Prints, per ruled constant, `AFTER <name> <hash of the stored type>`, `READD <name> <hash>` (the surgery) and two controls
that must differ from the skeleton's hash: `CONTROL-TRUE` (the domain `True` in place of the binder's, or `0` in place of
the right side) and, for each dropped binder, `CONTROL-POS` (the right domain at the wrong position: one binder later).
Run from the worktree's root: `lake env lean data/fs131/ict2/lean/ReAdd.lean > data/fs131/ict2/readd.txt`.
-/
open Lean Meta Elab Term Command

namespace FS131ICT2ReAdd

/-- Insert one non-dependent binder, its domain built from the leading binders, after the first `k` binders of `t`. -/
def insertAfter (t : Expr) (k : Nat) (dom : Array Expr → TermElabM Expr) : TermElabM Expr :=
  forallBoundedTelescope t k fun xs body => do
    let d ← dom xs
    mkForallFVars xs (← mkArrow d body)

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
  -- `even_pmHeight_sub_sum`: `(hc : ProperAlong s c)` after `{A} [AddCommGroup A] {m} {s} {c}`
  let n₁ := ``HadwigerNelson.CayleyThree.even_pmHeight_sub_sum
  let t₁ ← typeOf n₁
  let pa : Array Expr → TermElabM Expr := fun _ => do elabClosed (← `(HadwigerNelson.ThreeColour.ProperAlong s c))
  IO.println s!"AFTER {n₁} {t₁.hash}"
  IO.println s!"READD {n₁} {(← insertAfter t₁ 5 pa).hash}"
  IO.println s!"CONTROL-TRUE {n₁} {(← insertAfter t₁ 5 fun _ => pure (mkConst ``True)).hash}"
  IO.println s!"CONTROL-POS {n₁} {(← insertAfter t₁ 6 pa).hash}"
  -- `exists_le_mul_of_imp_eq_zero`: `(hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M)` after `{ι} [Finite ι] (M)`
  let n₂ := ``HadwigerNelson.CayleyThree.exists_le_mul_of_imp_eq_zero
  let t₂ ← typeOf n₂
  let ha : Array Expr → TermElabM Expr := fun _ => do elabClosed (← `(∀ x ∈ M, ∀ y ∈ M, x + y ∈ M))
  IO.println s!"AFTER {n₂} {t₂.hash}"
  IO.println s!"READD {n₂} {(← insertAfter t₂ 3 ha).hash}"
  IO.println s!"CONTROL-TRUE {n₂} {(← insertAfter t₂ 3 fun _ => pure (mkConst ``True)).hash}"
  IO.println s!"CONTROL-POS {n₂} {(← insertAfter t₂ 4 ha).hash}"
  -- `mcshane_model`: the right side `l1 x` replaced by `∑ j, x j`
  let n₃ := ``HadwigerNelson.CayleyThree.mcshane_model
  let t₃ ← typeOf n₃
  IO.println s!"AFTER {n₃} {t₃.hash}"
  let (re, rhsIsL1, ctrl) ← forallTelescope t₃ fun xs body => do
    let some (ty, lhs, rhs) := body.eq? | throwError "{n₃}: the body is not an equation"
    let l1x ← elabClosed (← `(HadwigerNelson.CayleyThree.l1 x))
    let sumx ← elabClosed (← `(∑ j, x j))
    let zero ← elabClosed (← `((0 : ℤ)))
    let re ← mkForallFVars xs (mkApp3 (mkConst ``Eq [levelOne]) ty lhs sumx)
    let ctrl ← mkForallFVars xs (mkApp3 (mkConst ``Eq [levelOne]) ty lhs zero)
    pure (re, rhs == l1x, ctrl)
  IO.println s!"RHS-IS-L1 {n₃} {rhsIsL1}"
  IO.println s!"READD {n₃} {re.hash}"
  IO.println s!"CONTROL-TRUE {n₃} {ctrl.hash}"

#eval run

end FS131ICT2ReAdd
