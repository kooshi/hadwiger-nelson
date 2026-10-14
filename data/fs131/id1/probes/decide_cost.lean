import Proofs.HadwigerNelson.SpectralChain
import Mathlib.NumberTheory.Real.Irrational

set_option autoImplicit false

/-- probe: class A as a Bool over residues modulo 8 -/
def chkA : Bool :=
  [1, 5].all fun m => (List.range 8).all fun a => (List.range 8).all fun b => (List.range 8).all fun c =>
    (List.range 8).all fun d => (List.range 8).all fun n =>
      !((a * a + c * c + m * (b * b + d * d)) % 8 == (n * n) % 8 && (a * b + c * d) % 8 == 0 &&
          !(a % 2 == 0 && b % 2 == 0 && c % 2 == 0 && d % 2 == 0 && n % 2 == 0)) ||
        ((n % 2 == 1 && (a + b + c + d) % 2 == 1) ||
          (n % 4 == 2 && (a + b) % 2 == 0 && (c + d) % 2 == 0 && (a + 3 * b + c + 3 * d) % 4 == 2))

set_option trace.profiler true in
theorem chkA_true : chkA = true := by decide +kernel

/-- the same over `ZMod 8` -/
theorem zmodA : ∀ a b c d N : ZMod 8, a ^ 2 + c ^ 2 + 1 * (b ^ 2 + d ^ 2) = N ^ 2 → a * b + c * d = 0 →
    ¬ (a.val % 2 = 0 ∧ b.val % 2 = 0 ∧ c.val % 2 = 0 ∧ d.val % 2 = 0 ∧ N.val % 2 = 0) →
    (N.val % 2 = 1 ∧ (a.val + b.val + c.val + d.val) % 2 = 1) ∨
      (N.val % 4 = 2 ∧ (a.val + b.val) % 2 = 0 ∧ (c.val + d.val) % 2 = 0 ∧
        (a.val + 3 * b.val + c.val + 3 * d.val) % 4 = 2) := by
  decide +kernel
