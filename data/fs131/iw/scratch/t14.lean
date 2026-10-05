import Mathlib
open Fin.NatCast in
example (m : ℕ) (i i₀ : Fin (m + 1)) : i₀ + (((i - i₀).val : ℕ) : Fin (m + 1)) = i := by
  rw [Fin.cast_val_eq_self]; abel
open Fin.NatCast in
example (m q : ℕ) (i₀ : Fin (m + 1)) : i₀ + ((q + 1 : ℕ) : Fin (m + 1)) = (i₀ + (q : Fin (m + 1))) + 1 := by
  rw [Nat.cast_succ, add_assoc]
