import Proofs.HadwigerNelson.SpectralChain
import Mathlib.NumberTheory.Real.Irrational
/-! FS131-ID1 — the negative control of the exhaustion behind the three shape lemmas (`shapeCheck`, copied from
`Arith/DyadicQuadratic.lean` word for word but for `private`).  Three true checks (the module's) must pass; four planted
ones must each fail with `decide`'s "proposition is false":
  A' — class A's conclusion at `m ≡ 3 (mod 4)` (the planner's plant A: `-(1 + i√3)/2`);
  B' — class B's conclusion at `m ≡ 0 (mod 4)`;
  C' — class C's conclusion at `m ≡ 7 (mod 8)` (`(3 + i√7)/4`);
  C'' — class C's conclusion at `m ≡ 3 (mod 8)` with the all-odd alternative left out (residues modulo 4 cannot
        exclude it: this is why `not_odd_of_three_mod_eight` is a separate lemma).
Expected: exactly four `error` lines, at the four planted theorems. -/
set_option autoImplicit false

def shapeCheck (ms : List ℕ) (P : ℕ → ℕ → ℕ → ℕ → ℕ → Prop) [∀ a b c d n, Decidable (P a b c d n)] : Bool :=
  ms.all fun m => (List.range 4).all fun a => (List.range 4).all fun b => (List.range 4).all fun c =>
    (List.range 4).all fun d => (List.range 4).all fun n =>
      decide ((a * a + c * c + m * (b * b + d * d)) % 8 = (n * n) % 8 → (a * b + c * d) % 4 = 0 →
        ¬ (a % 2 = 0 ∧ b % 2 = 0 ∧ c % 2 = 0 ∧ d % 2 = 0 ∧ n % 2 = 0) → P a b c d n)

abbrev PA : ℕ → ℕ → ℕ → ℕ → ℕ → Prop := fun a b c d n => (n % 2 = 1 ∧ (a + b + c + d) % 2 = 1) ∨
      (n % 4 = 2 ∧ (a + b) % 2 = 0 ∧ (c + d) % 2 = 0 ∧ (a + 3 * b + c + 3 * d) % 4 = 2)
abbrev PB : ℕ → ℕ → ℕ → ℕ → ℕ → Prop := fun a b c d n => (n % 2 = 1 ∧ (a + c) % 2 = 1) ∨
      (n % 4 = 2 ∧ a % 2 = 0 ∧ c % 2 = 0 ∧ b % 2 = 1 ∧ d % 2 = 1 ∧ (a / 2 + c / 2 + d) % 2 = 1)
abbrev PC : ℕ → ℕ → ℕ → ℕ → ℕ → Prop := fun a b c d n =>
    (b % 2 = 1 ∧ c % 2 = 1 ∧ d % 2 = 1) ∨ (n % 2 = 1 ∧ (a + b + c + d) % 2 = 1) ∨
      (n % 4 = 2 ∧ (a + d) % 2 = 0 ∧ (b + c) % 2 = 0 ∧ (b + d) % 2 = 1)
abbrev PC'' : ℕ → ℕ → ℕ → ℕ → ℕ → Prop := fun a b c d n => (n % 2 = 1 ∧ (a + b + c + d) % 2 = 1) ∨
      (n % 4 = 2 ∧ (a + d) % 2 = 0 ∧ (b + c) % 2 = 0 ∧ (b + d) % 2 = 1)

theorem trueA : shapeCheck [1, 5] PA = true := by decide +kernel
theorem trueB : shapeCheck [2, 6] PB = true := by decide +kernel
theorem trueC : shapeCheck [3] PC = true := by decide +kernel
theorem plantA : shapeCheck [3, 7] PA = true := by decide +kernel
theorem plantB : shapeCheck [0, 4] PB = true := by decide +kernel
theorem plantC : shapeCheck [7] PC = true := by decide +kernel
theorem plantC'' : shapeCheck [3] PC'' = true := by decide +kernel
