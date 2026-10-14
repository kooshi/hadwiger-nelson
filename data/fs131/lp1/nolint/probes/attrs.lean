import Mathlib.Tactic.Linter.Style
/-! FS131-LP1 probe: may a declaration carry two attribute blocks, and does `@[nolint]` attach to an anonymous
instance (and to an `instance` that already has attributes)? -/
structure ZzT where
  x : Nat
/-- an anonymous instance with nolint -/
@[nolint defsWithUnderscore]
instance : Inhabited ZzT := ⟨⟨0⟩⟩
/-- merged -/
@[nolint unusedArguments, simp] theorem zz_merged (n : Nat) : (fun _ : Nat => 0) n = 0 := rfl
#eval show Lean.MetaM Unit from do
  let env ← Lean.getEnv
  for n in [``instInhabitedZzT, ``zz_merged] do
    IO.println s!"{n}: nolint {Batteries.Tactic.Lint.nolintAttr.getParam? env n} simp {(← Lean.Meta.getSimpTheorems).isLemma (.decl n)}"
