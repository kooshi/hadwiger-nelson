import Proofs.HadwigerNelson.UnitDistance
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# The unit equilateral triangle — M01's model of its own hypotheses

`Proofs.HadwigerNelson.add_one_le_chromaticNumber_unitDistance` quantifies over a graph, a vertex
map, an edge hypothesis and a non-colourability fact. A `∀` over an empty domain proves everything
and means nothing, so before anything downstream leans on that theorem, this file exhibits one
concrete instance of all four and reads off the resulting bound.

The instance is the smallest possible: three points of `ℂ` pairwise at distance `1`, carrying
`K₃`, which needs three colours. The conclusion — that the plane needs at least three colours — is
independently known, which is precisely what makes it a test of the reduction rather than a
consequence of it.
-/

namespace Proofs.HadwigerNelson

open SimpleGraph Complex

/-- Three points of `ℂ` pairwise at distance `1`: the unit equilateral triangle. -/
noncomputable def trianglePoints : Fin 3 → ℂ
  | 0 => 0
  | 1 => 1
  | 2 => ⟨1 / 2, Real.sqrt 3 / 2⟩

/-- Every pair of distinct triangle vertices is a unit-distance pair. -/
theorem trianglePoints_dist {i j : Fin 3} (h : i ≠ j) :
    dist (trianglePoints i) (trianglePoints j) = 1 := by
  sorry

/-- `K₃` is not 2-colourable — the combinatorial half of the witness. -/
theorem not_colorable_two_top_fin_three : ¬ (⊤ : SimpleGraph (Fin 3)).Colorable 2 := by
  sorry

/-- **χ(ℂ) ≥ 3**, via the general reduction applied to the triangle. -/
theorem three_le_chromaticNumber_unitDistance_complex :
    3 ≤ (unitDistance ℂ).chromaticNumber := by
  sorry

/-- **χ(ℝ²) ≥ 3.** The same bound in the model a reader expects, transported along the isometry
`ℂ ≃ᵢ EuclideanSpace ℝ (Fin 2)`. M05 will state its headline in exactly this shape. -/
theorem three_le_chromaticNumber_plane :
    3 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  sorry

end Proofs.HadwigerNelson
