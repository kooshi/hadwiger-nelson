import Proofs.HadwigerNelson.Arith.Floor128
-- FS131-I10E, the closed-term hazard, variant (a): the length and the seed are VARIABLES; the rewrite is Mathlib's
-- `zero_add` (stated at `AddZeroClass`, so its `0 + _` reaches `Nat.add` by another instance path than the goal's).
-- Expected: elaborates.
namespace HadwigerNelson.Floor128
open Finset
example (n x : ℕ) : (pass n x 0 0).2 = ∑ m ∈ range n, step^[m] x % 2 * 2 ^ (8 * ((0 + m) % 127)) := by
  rw [pass_snd _ _ _ _ (by norm_num), zero_add]
end HadwigerNelson.Floor128
