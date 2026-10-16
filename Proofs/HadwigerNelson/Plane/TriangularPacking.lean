import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Proofs.HadwigerNelson.Plane.Slack

/-!
# The triangular packing of half-unit discs: `m₁(ℝ²) ≥ π/(8√3) > 1/5` (FS-131, job FS131-KFR1; module D4, skeleton)

**Read aloud.** The open discs of radius `1/2` centred at the triangular lattice of spacing `2`
(`triCentre m n = 2m + n(1 + i√3)`) hold no two points at distance one — two points of one disc are less than `1` apart, and
two of different discs more than `2 − 1 = 1` — and fill `π/(8√3) = 0.2267…` of the plane (one disc of area `π/4` per cell of
area `2√3`). So `m₁(ℝ²) ≥ π/(8√3) > 1/5`, which FS103-F-ROUND's "the density route never gives six" needs
(`1/m₁ < 4.42 < 5`). The kernel's earlier bounds, `1/7` (`OneClass.one_seventh_le_mOne`) and `2π/(21√3)`
(`Collapse.disc7_le_mOne`), are below `1/5`.

**Not claimed:** Croft's `0.22936` (`[Croft1967]`'s tortoises) or any value of `m₁`.

**Models.** `triPacking` itself is the object; `0 ∈ triPacking` (`zero_mem_triPacking`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric
open scoped ENNReal

noncomputable section

/-- The triangular lattice of spacing `2`: `2m + n(1 + i√3)`. -/
def triCentre (m n : ℤ) : ℂ := (((2 * m + n : ℤ) : ℝ) : ℂ) + (((n : ℝ) * Real.sqrt 3 : ℝ) : ℂ) * I

/-- **The packing**: the open discs of radius `1/2` about the lattice points. -/
def triPacking : Set ℂ := ⋃ (m : ℤ) (n : ℤ), ball (triCentre m n) (1 / 2)

example : triCentre 0 0 = 0 := by simp [triCentre]

theorem zero_mem_triPacking : (0 : ℂ) ∈ triPacking := by
  sorry

theorem measurableSet_triPacking : MeasurableSet triPacking := by
  sorry

/-- Distinct lattice points are at least `2` apart (`|2a + b(1 + i√3)|² = 4(a² + ab + b²) ≥ 4`). -/
theorem two_le_dist_triCentre {m n m' n' : ℤ} (h : (m, n) ≠ (m', n')) : 2 ≤ dist (triCentre m n) (triCentre m' n') := by
  sorry

/-- **No two points of the packing are at distance one.** -/
theorem isIndepSet_triPacking : (unitDistance ℂ).IsIndepSet triPacking := by
  sorry

/-- The packing is periodic under the lattice `ℤ·2 + ℤ·(1 + i√3)`. -/
theorem triPacking_periodic (x : ℂ) : (x + 2 ∈ triPacking ↔ x ∈ triPacking) ∧
    (x + (1 + ((Real.sqrt 3 : ℝ) : ℂ) * I) ∈ triPacking ↔ x ∈ triPacking) := by
  sorry

theorem linearIndependent_triLattice : LinearIndependent ℝ ![(2 : ℂ), 1 + ((Real.sqrt 3 : ℝ) : ℂ) * I] := by
  sorry

/-- **Its density is `π/(8√3)`** (`upperDensity_of_periodic`; the fundamental parallelogram holds one disc's area, `π/4`,
of its `2√3`). -/
theorem upperDensity_triPacking : upperDensity triPacking = ENNReal.ofReal (Real.pi / (8 * Real.sqrt 3)) := by
  sorry

/-- **`m₁(ℝ²) ≥ π/(8√3)`.** -/
theorem pi_div_le_mOne : ENNReal.ofReal (Real.pi / (8 * Real.sqrt 3)) ≤ mOne := by
  sorry

/-- **`1/5 < m₁(ℝ²)`** (`π/(8√3) > 0.2267`). -/
theorem fifth_lt_mOne : (5 : ℝ≥0∞)⁻¹ < mOne := by
  sorry

end

end HadwigerNelson.Plane
