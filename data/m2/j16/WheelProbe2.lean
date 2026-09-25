import Mathlib.Data.Fin.Basic

set_option autoImplicit false

theorem s2f_prop : ∀ a r0 r1 r2 r3 r4 r5 : Fin 4,
    a ≠ r0 → a ≠ r1 → a ≠ r2 → a ≠ r3 → a ≠ r4 → a ≠ r5 →
    r0 ≠ r1 → r1 ≠ r2 → r2 ≠ r3 → r3 ≠ r4 → r4 ≠ r5 → r5 ≠ r0 →
    ¬ (r0 = r2 ∧ r2 = r4) → ¬ (r1 = r3 ∧ r3 = r5) → r2 = r4 → r0 = r3 ∧ r1 = r5 := by
  decide +kernel
