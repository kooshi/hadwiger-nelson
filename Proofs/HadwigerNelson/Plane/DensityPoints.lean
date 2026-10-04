import Proofs.HadwigerNelson.Plane.AeColouring

/-!
# Density points of a set with null unit pairs (FS-131 wave 1)

Rows: **FS111-V0-ID1** (I-D1), **FS129-SR2-HULLSET** (carrying FS111-C-HULL), **FS111-M-HULL2**, **FS111-M2-INT**.
Plan: `plans/FS131-kernel-plan.md` § 6. Every statement here is about one measurable set `A` with null unit pairs,
as FS-129's audit restated them (HULLSET's `uses only:` — "reads only that A's own unit pairs are null").

The engine is I-D1: a point of density `1` and a point of positive upper density are never exactly `1` apart.
Everything else is I-D1 plus the continuity of `dist x ·` on a connected set.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-- **I-D1, set form** (FS111-V0-ID1's argument; G92's widened form): for a measurable `A` with null unit pairs, a
density point `y` of `A` and a point `x` of positive upper density are not at distance `1`. -/
theorem dist_ne_one_of_mem_densitySet {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A)
    {x y : ℂ} (hy : y ∈ densitySet A) (hx : 0 < upperDensityAt A x) : dist x y ≠ 1 := by
  sorry

/-- **FS111-V0-ID1** (I-D1): in every measurable colouring proper at almost every unit pair, if `y ∈ S̃_j` and
`d̄_j(x) > 0` then `|x − y| ≠ 1`. -/
theorem AeColouring.dist_ne_one {k : ℕ} (c : AeColouring k) (j : Fin k) {x y : ℂ}
    (hy : y ∈ densitySet (c.col ⁻¹' {j})) (hx : 0 < upperDensityAt (c.col ⁻¹' {j}) x) : dist x y ≠ 1 := by
  sorry

/-- A density point has positive upper density (it has upper density `1`). -/
theorem upperDensityAt_pos_of_mem_densitySet {A : Set ℂ} {x : ℂ} (hx : x ∈ densitySet A) :
    0 < upperDensityAt A x := by
  sorry

/-- **FS129-SR2-HULLSET**, first clause (with FS111-C-HULL merged into it): for a measurable `A` with null unit pairs,
every preconnected `C ⊆ Ã` and every `x` with `d̄_A(x) > 0`, either every point of `C` is within distance below `1`
of `x` or every point of `C` is farther than `1`. (The row says path-connected; the argument reads only
preconnectedness — a generalization, reported.) -/
theorem hullset {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {C : Set ℂ}
    (hC : IsPreconnected C) (hCA : C ⊆ densitySet A) {x : ℂ} (hx : 0 < upperDensityAt A x) :
    (∀ c ∈ C, dist x c < 1) ∨ (∀ c ∈ C, 1 < dist x c) := by
  sorry

/-- **FS129-SR2-HULLSET**, second clause: when `C` is moreover compact, the bound is uniform — `sup_{c ∈ C} |x − c| < 1`
or `dist(x, C) > 1`, written with explicit bounds so that an empty `C` reads no junk value. -/
theorem hullset_of_isCompact {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {C : Set ℂ}
    (hC : IsPreconnected C) (hCc : IsCompact C) (hCA : C ⊆ densitySet A) {x : ℂ}
    (hx : 0 < upperDensityAt A x) :
    (∃ r < 1, ∀ c ∈ C, dist x c ≤ r) ∨ (∃ r > 1, ∀ c ∈ C, r ≤ dist x c) := by
  sorry

/-- **FS111-M-HULL2**: two preconnected pieces of one class — `P` of points of positive upper density, `Q` of density
points — have all cross distances below `1` or all above `1`. (The row says "path-connected pieces of one class"; its
`uses only:` reads C-HULL at each point of one piece and path-connectedness of the other.) -/
theorem hull2 {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {P Q : Set ℂ}
    (hP : IsPreconnected P) (hQ : IsPreconnected Q) (hPA : P ⊆ {x | 0 < upperDensityAt A x})
    (hQA : Q ⊆ densitySet A) :
    (∀ p ∈ P, ∀ q ∈ Q, dist p q < 1) ∨ (∀ p ∈ P, ∀ q ∈ Q, 1 < dist p q) := by
  sorry

/-- **FS111-M2-INT**: for a measurable `A` with null unit pairs, no point of the interior of its density set is at
distance exactly `1` from a point of the closure of its density set. -/
theorem dist_ne_one_of_mem_interior_densitySet {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A)
    {x y : ℂ} (hx : x ∈ interior (densitySet A)) (hy : y ∈ closure (densitySet A)) : dist x y ≠ 1 := by
  sorry

end HadwigerNelson.Plane
