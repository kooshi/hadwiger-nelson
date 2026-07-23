import Mathlib.Tactic

/-!
# Basic — sanity module

Confirms the pinned toolchain elaborates and Mathlib is wired in through the cache.
The first real declaration; replace with milestone content as it lands (`WORKFLOW.md`).
-/

namespace Proofs

/-- Sanity theorem exercising Mathlib (`ℝ` and `norm_num`) and the kernel. -/
theorem two_add_two : (2 : ℝ) + 2 = 4 := by norm_num

/-- Spec example: would fail to elaborate if `two_add_two` drifted from its statement. -/
example : (2 : ℝ) + 2 = 4 := two_add_two

end Proofs
