import Proofs.HadwigerNelson.Plane.CPColouring
import Proofs.HadwigerNelson.Plane.Cover

/-!
# Forced translations of a CP colouring (FS-131 wave 2)

Row: **FS129-OA1-NOPERLAW**. Plan: `plans/FS131-w2-kernel-plan.md` § 4. The object is the foundation's `CPColouring`
(a stationary random colouring, continuous in probability, proper almost surely on every unit pair, as its law). The
inhabitant `sq9CP` is the CP colouring every theorem here is witnessed by.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology

variable {k : ℕ}

/-- **Inhabitant**: `sq9` under a uniformly random translation of its period torus `(3/2)ℤ²` — the law of
`y ↦ sq9.col (y + z)`, `z` uniform on `[0, 3/2)²`. -/
theorem nonempty_cpColouring_nine : Nonempty (CPColouring 9) := by
  sorry

/-- `Z`: the vectors `x` with `c(0) = c(x)` almost surely. -/
def CPColouring.forcedSet (c : CPColouring k) : Set ℂ := {x | c.law {f | f 0 = f x} = 1}

/-- **FS129-OA1-NOPERLAW**, first clause: `Z` is a discrete subgroup of `ℝ²`. -/
theorem CPColouring.exists_discrete_forcedSet (c : CPColouring k) :
    ∃ G : AddSubgroup ℂ, (G : Set ℂ) = c.forcedSet ∧ DiscreteTopology G := by
  sorry

/-- **FS129-OA1-NOPERLAW**, second clause: if the law is rotation-invariant, `Z = {0}`. -/
theorem CPColouring.forcedSet_eq_zero (c : CPColouring k) (h : c.RotationInvariant) : c.forcedSet = {0} := by
  sorry

end HadwigerNelson.Plane
