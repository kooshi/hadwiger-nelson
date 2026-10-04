import Proofs.HadwigerNelson.Plane.DensityPoints

/-!
# An open set with null unit pairs avoids distance `1` to its closure (FS-131 wave 1)

Row: **FS129-SR2-CLOSURE** (carrying FS111-V0-CLOSE, FS106-DIAM (iii) and FS116-V5-NE1's first clause, SR2 item 9).
Plan: `plans/FS131-kernel-plan.md` § 6. Route: FS111-M2-INT with `A = U` — every point of an open set is a density
point of it (`subset_densitySet_of_isOpen`), so `U ⊆ int Ũ` and `cl U ⊆ cl Ũ`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-- Every point of an open set is a density point of it. -/
theorem subset_densitySet_of_isOpen {U : Set ℂ} (hU : IsOpen U) : U ⊆ densitySet U := by
  sorry

/-- **FS129-SR2-CLOSURE**: if `U ⊆ ℝ²` is open with `(Leb ⊗ σ){(x, w) ∈ U × S¹ : x + w ∈ U} = 0`, no point of `U` is at
distance exactly `1` from a point of `cl U`. -/
theorem dist_ne_one_of_mem_of_mem_closure {U : Set ℂ} (hU : IsOpen U) (hnull : UnitPairsNull U)
    {x y : ℂ} (hx : x ∈ U) (hy : y ∈ closure U) : dist x y ≠ 1 := by
  sorry

end HadwigerNelson.Plane
