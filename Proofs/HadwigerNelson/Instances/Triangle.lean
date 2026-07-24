import Proofs.HadwigerNelson.EdgeList
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# The unit equilateral triangle — M01's model of its own hypotheses

`lt_chromaticNumber_unitDistance` quantifies over a graph, a vertex map, an edge hypothesis and a
non-colourability fact. A `∀` over an empty domain proves everything and means nothing, so before
anything downstream leans on that theorem, this file exhibits one concrete instance of all four and
reads off the resulting bound.

The instance is the smallest possible: three points of `ℂ` pairwise at distance `1`, carrying `K₃`,
which needs three colours. The conclusion — that the plane needs at least three colours — is
independently known, which is precisely what makes it a test of the reduction rather than a
consequence of it.

The triangle is built **twice**: once as `⊤ : SimpleGraph (Fin 3)` through the general reduction,
once as an explicit edge list through the `edgeGraph` specialization. The two routes cross-check
each other at a scale where both are obviously right, which is the same discipline M03 applies to
the CNF encoder and the Moser spindle.
-/

namespace Proofs.HadwigerNelson

open SimpleGraph Complex

/-! ## The points -/

/-- Three points of `ℂ` pairwise at distance `1`: the unit equilateral triangle.

A vector literal rather than a `match` on `Fin 3` literals, deliberately: `fin_cases i <;> simp`
is reliable against `Matrix.cons_val_*` and is not against a bare `match`, and the difference is a
proof that transcribes versus a proof that fights. -/
noncomputable def trianglePoints : Fin 3 → ℂ :=
  ![0, 1, ⟨1 / 2, Real.sqrt 3 / 2⟩]

/-! The three real-number facts underneath the 9-case bash. Stated separately so the case analysis
cites them rather than re-deriving `√3² = 3` six times. -/

private theorem dist_01 : dist (trianglePoints 0) (trianglePoints 1) = 1 := by sorry

private theorem dist_02 : dist (trianglePoints 0) (trianglePoints 2) = 1 := by sorry

private theorem dist_12 : dist (trianglePoints 1) (trianglePoints 2) = 1 := by sorry

/-- Every pair of distinct triangle vertices is a unit-distance pair. -/
theorem trianglePoints_dist {i j : Fin 3} (h : i ≠ j) :
    dist (trianglePoints i) (trianglePoints j) = 1 := by
  sorry

/-! ## Route 1 — through the general reduction, with `⊤` -/

/-- `K₃` is not 2-colourable — the combinatorial half of the witness. -/
theorem not_colorable_two_top_fin_three : ¬ (⊤ : SimpleGraph (Fin 3)).Colorable 2 := by
  sorry

/-- **χ(ℂ) ≥ 3**, via the general reduction applied to the triangle. -/
theorem three_le_chromaticNumber_unitDistance_complex :
    3 ≤ (unitDistance ℂ).chromaticNumber := by
  sorry

/-! ## Route 2 — through the edge-list specialization

The same triangle presented the way every certificate will be, so that `edgeGraph` and the
specialized reduction are exercised before M04 depends on them at 1581 vertices. -/

/-- The triangle's three edges, as a certificate would list them. -/
def triangleEdges : List (Fin 3 × Fin 3) := [(0, 1), (1, 2), (0, 2)]

/-- The edge-list presentation agrees with `⊤` — a cross-check of `edgeGraph` against Mathlib's
complete graph, at a size where both are transparently correct. -/
theorem edgeGraph_triangleEdges_eq_top : edgeGraph 3 triangleEdges = ⊤ := by
  sorry

/-- **χ(ℂ) ≥ 3** again, this time through the certificate-shaped route. -/
theorem three_le_chromaticNumber_unitDistance_complex' :
    3 ≤ (unitDistance ℂ).chromaticNumber := by
  sorry

/-! ## The headline -/

/-- **χ(ℝ²) ≥ 3.** The same bound in the model a reader expects, transported along the isometry
`ℂ ≃ᵢ EuclideanSpace ℝ (Fin 2)`. M05 will state its headline in exactly this shape. -/
theorem three_le_chromaticNumber_plane :
    3 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  sorry

/-! ## Non-vacuity of the adjacency itself

Guards against the failure where `unitDistance` has an empty `Adj` and every theorem above is
true for the wrong reason. -/

example : (unitDistance ℂ).Adj 0 1 := by sorry

example : ¬ (unitDistance ℂ).Adj 0 2 := by sorry

end Proofs.HadwigerNelson
