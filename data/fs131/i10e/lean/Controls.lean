import Proofs.HadwigerNelson.Arith.Floor128

-- FS131-I10E, negative controls of the bridge (`lake env lean` on this file must FAIL at each `example`, and name it).
-- Each is a theorem of `Floor128` restated one unit sharper and given that theorem's own proof: if one of these ever
-- elaborated, the proof it copies would not be reading the certificate's bound.

namespace HadwigerNelson.Floor128

open Finset

-- CONTROL 1 (must fail at `exact h1`: 74 against 73): `class_le` at 73, by `class_le`'s proof.
example (r : ℕ) (hr : r < 127) : ∑ j ∈ range 129, step^[127 * j + r] 1 % 2 ≤ 73 := by
  have h := counts_ok
  rw [countsOk, Bool.and_eq_true, List.all_eq_true] at h
  have h1 := h.2 r (List.mem_range.mpr hr)
  rw [decide_eq_true_eq, Nat.shiftRight_eq_div_pow, show (255 : ℕ) = 2 ^ 8 - 1 from rfl,
    Nat.and_two_pow_sub_one_eq_mod, show (2 : ℕ) ^ 8 = 256 from rfl, counts] at h1
  rw [← pass_class 1 129 (by norm_num) r hr]
  exact h1

-- CONTROL 2 (must fail at `linarith`): the last step of `charSum_128_ge` at `−18`: from `c ≤ 74` the sum `129 − 2c` is
-- only known to be at least `−19`.
example (c : ℝ) (hc : c ≤ 74) : -(18 : ℝ) ≤ 129 - 2 * c := by
  linarith

-- CONTROL 3 (must fail): the register's period is not `5461 = 16383 / 3` — `order_checks` refuses it.
example : step^[5461] 1 = 1 := by
  have h := order_checks.1
  rw [pass_fst] at h
  exact h

-- PARTNER (must pass): the same three shapes at the true values.
example (r : ℕ) (hr : r < 127) : ∑ j ∈ range 129, step^[127 * j + r] 1 % 2 ≤ 74 := class_le r hr
example (c : ℝ) (hc : c ≤ 74) : -(19 : ℝ) ≤ 129 - 2 * c := by linarith
example : step^[5461] 1 ≠ 1 := by
  have h := order_checks.1
  rwa [pass_fst] at h

end HadwigerNelson.Floor128
