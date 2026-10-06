import Proofs.HadwigerNelson.Arith.Floor128
-- FS131-I10E, the closed-term hazard, variant (b): the CLOSED term (length 16383, seed 1), rewritten with core's
-- `Nat.zero_add`, whose `0 + _` is stated at the goal's own instances.
-- Registered before the run: elaborates, probability 0.8 (if the hazard is the instance path, as read).
namespace HadwigerNelson.Floor128
open Finset
example : counts.2 = ∑ m ∈ range 16383, step^[m] 1 % 2 * 2 ^ (8 * ((0 + m) % 127)) := by
  rw [counts, pass_snd _ _ _ _ (by norm_num), Nat.zero_add]
end HadwigerNelson.Floor128
