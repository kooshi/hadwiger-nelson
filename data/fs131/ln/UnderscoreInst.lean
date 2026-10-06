import Mathlib.NumberTheory.NumberField.Basic
import Batteries.Tactic.Lint

/-! FS131-LN1 scratch, not in the library: which forms of an unused instance argument `unusedArguments` reports.
Run by `lake env lean data/fs131/ln/UnderscoreInst.lean`; `#lint` fails the file when it reports anything. -/

/-- The control: an unused anonymous instance argument. The linter must report it. -/
theorem fs131LnAnon (F : Type) [Field F] [NumberField F] : (1 : F) = 1 := rfl

/-- The binder named by an underscore: read from the linter's source as exempt. -/
theorem fs131LnUnderscore (F : Type) [Field F] [_hF : NumberField F] : (1 : F) = 1 := rfl

/-- The hypothesis referenced by `have _ :=`: read as used. -/
theorem fs131LnHave (F : Type) [Field F] [hF : NumberField F] : (1 : F) = 1 := by
  have _ := hF
  rfl

#lint only unusedArguments
