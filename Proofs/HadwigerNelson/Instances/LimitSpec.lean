import Proofs.HadwigerNelson.Limit
import Proofs.HadwigerNelson.Instances.Triangle

/-!
# Models of the limit lemma's hypotheses

`Limit.lean` states that a finite graph drawable in a fixed compact region with edge lengths
within `ε` of `1`, **for every `ε > 0`**, forces the space's chromatic number. That is a `∀ ε`
hypothesis, and a `∀` over an empty domain proves everything — so the statements are worth
nothing until someone exhibits a family satisfying them. This file is that exhibition, and it
follows the house pattern: the general reduction in `UnitDistance.lean` keeps its model in
`Instances/Triangle.lean` rather than importing geometry, and the limit lemma keeps its here.

Three models, each pinning a different way the statements could have been wrong:

* `three_le_chromaticNumber_complex_of_exact_triangle` — the degenerate case, one exact drawing
  reused at every tolerance. Confirms the hypotheses are inhabitable at all, and recovers
  `χ(ℂ) ≥ 3`, which `Instances/Triangle.lean` proves directly.
* `three_le_chromaticNumber_complex_of_shrinking_triangles` — the honest case: a **different**
  drawing at each tolerance, no member of the family exact. This is the one that would fail if
  the statement had accidentally demanded a single fixed drawing, and it is the template a real
  caller copies.
* `collapsed_drawing_satisfies_one_tolerance` — the **red**. At a *single* fixed tolerance the
  hypothesis is satisfied by putting every vertex in one place, for *any* graph whatsoever. So a
  version of the limit lemma quantified over one `ε` instead of all of them would prove
  `χ(ℝ²) ≥ k + 1` for every `k` — it is unsound, and the universal quantifier is what stops it.
  Stated and proven, so the red is a theorem rather than an absence of one.
-/

namespace HadwigerNelson

open SimpleGraph Filter Topology Metric

/-- Scaling the triangle about its own first vertex, which sits at the origin: the one geometric
fact both models need, stated once so neither re-derives it. -/
private theorem dist_smul_trianglePoints_zero (s : ℝ) (i : Fin 3) :
    dist (s • trianglePoints i) (0 : ℂ) = ‖s‖ * dist (trianglePoints i) (trianglePoints 0) := by
  rw [show (0 : ℂ) = s • trianglePoints 0 by simp [trianglePoints], dist_smul₀]

/-! ## Model 1 — one exact drawing, reused -/

/-- The unit triangle, offered at every tolerance with zero error. The hypotheses of
`add_one_le_chromaticNumber_unitDistance_of_approx` are therefore satisfiable, and the bound they
give is the one `Instances/Triangle.lean` obtains directly. -/
theorem three_le_chromaticNumber_complex_of_exact_triangle :
    ((2 + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  refine add_one_le_chromaticNumber_unitDistance_of_approx (G := ⊤) (K := closedBall (0 : ℂ) 2)
    (isCompact_closedBall 0 2) (fun ε hε => ⟨trianglePoints, fun i => ?_, fun i j hij => ?_⟩)
    not_colorable_two_top_fin_three
  · rcases eq_or_ne i 0 with rfl | hi
    · simp [trianglePoints]
    · have h : dist (trianglePoints i) (0 : ℂ) = 1 := by
        simpa [trianglePoints_dist hi] using dist_smul_trianglePoints_zero 1 i
      simp [mem_closedBall, h]
  · rw [trianglePoints_dist (by simpa using hij)]
    simpa using hε.le

/-! ## Model 2 — a different drawing at each tolerance, none of them exact -/

/-- The triangle scaled by `1 + min ε 1 / 2`: every edge has length strictly greater than `1`, so
**no member of this family is a unit-distance drawing**, yet the family satisfies the hypothesis
at every tolerance. The `min` keeps the whole family inside one fixed disc, which is what the
compactness hypothesis demands — a family allowed to grow without bound would not qualify, and
that is the hypothesis doing its job. -/
theorem three_le_chromaticNumber_complex_of_shrinking_triangles :
    ((2 + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  refine add_one_le_chromaticNumber_unitDistance_of_approx (G := ⊤) (K := closedBall (0 : ℂ) 2)
    (isCompact_closedBall 0 2) (fun ε hε => ⟨fun i => (1 + min ε 1 / 2) • trianglePoints i,
      fun i => ?_, fun i j hij => ?_⟩) not_colorable_two_top_fin_three
  · have hb : (0 : ℝ) ≤ min ε 1 := le_min hε.le zero_le_one
    have hm : min ε 1 ≤ 1 := min_le_right ε 1
    rcases eq_or_ne i 0 with rfl | hi
    · simp [trianglePoints]
    · simp only [mem_closedBall, dist_smul_trianglePoints_zero, trianglePoints_dist hi,
        Real.norm_eq_abs, abs_of_nonneg (by linarith : (0:ℝ) ≤ 1 + min ε 1 / 2), mul_one]
      linarith
  · have hb : (0 : ℝ) ≤ min ε 1 := le_min hε.le zero_le_one
    rw [dist_smul₀, trianglePoints_dist (by simpa using hij), Real.norm_eq_abs,
      abs_of_nonneg (by linarith : (0:ℝ) ≤ 1 + min ε 1 / 2), mul_one,
      show (1 : ℝ) + min ε 1 / 2 - 1 = min ε 1 / 2 by ring, abs_of_nonneg (by linarith)]
    linarith [min_le_left ε 1]

/-! ## Model 3 — the red: why the tolerance must be universally quantified -/

/-- **The red.** At one fixed tolerance the hypothesis is free: collapse every vertex onto a
single point and each edge reads `|0 - 1| = 1 ≤ 1`, whatever the graph. A limit lemma stated at a
single `ε` would therefore accept any non-`k`-colourable graph and conclude `χ(ℝ²) ≥ k + 1` for
every `k`, which is false. The `∀ ε > 0` is what rules this witness out — at any `ε < 1` it dies.

Stated for an arbitrary graph on an arbitrary vertex type — not even finiteness — because the point
is that the degenerate witness is *always* available. (The `[Fintype ι]` this once carried, to
parallel the real lemma's hypotheses, was unused; the linter caught it at M45 and dropping it makes
the red stronger, which is the direction a control should move.) -/
theorem collapsed_drawing_satisfies_one_tolerance {ι : Type*} (G : SimpleGraph ι) :
    ∃ z : ι → ℂ, (∀ i, z i ∈ closedBall (0 : ℂ) 1) ∧
      ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ 1 :=
  ⟨fun _ => 0, fun _ => by simp, fun _ _ _ => by simp⟩

/-- The same witness fails as soon as the tolerance drops below `1` — the quantifier is
load-bearing, not decoration. -/
theorem collapsed_drawing_fails_below_one {ε : ℝ} (hε : ε < 1) :
    ¬ |dist (0 : ℂ) 0 - 1| ≤ ε := by
  simpa using hε

end HadwigerNelson
