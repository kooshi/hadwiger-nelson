import Proofs.HadwigerNelson.Arith.Floor128
-- FS131-I10E, the closed-term hazard, variant (c): the CLOSED term (length 16383, seed 1), rewritten with Mathlib's
-- `zero_add`. Measured on the working file before `pass_snd` was in the module: "(kernel) deterministic timeout"
-- after about 173 s. Expected here: the same.
namespace HadwigerNelson.Floor128
open Finset
example : counts.2 = ∑ m ∈ range 16383, step^[m] 1 % 2 * 2 ^ (8 * ((0 + m) % 127)) := by
  rw [counts, pass_snd _ _ _ _ (by norm_num), zero_add]
end HadwigerNelson.Floor128
