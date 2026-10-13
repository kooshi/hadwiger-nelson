import Proofs.HadwigerNelson.Plane.UnitPairs

/-!
# Measurable colourings proper at almost every unit pair, and `χ_m⁰(ℝ²)`

`χ_m⁰(ℝ²)` is "the fewest colours in a Lebesgue-measurable colouring whose unit pairs are bichromatic
almost everywhere" (`CLAUDE.md` § The aim, link 1). A colouring here is a total **Borel**-measurable function
`ℂ → Fin k` (`Measurable`: the σ-algebra of `ℂ` is the Borel one); a Lebesgue-measurable colouring proper at almost
every unit pair agrees with a Borel one off a null set, so the number is the same
(`Plane.exists_proper_of_nullMeasurable_weak`, `Plane.exists_aeColouring_of_nullMeasurable_proper`, in
`Plane/LebesgueNumber`). Its classes are the fibres, and "bichromatic almost everywhere" is `UnitPairsNull` of every
fibre (the monochromatic unit pairs are the union of the fibres' unit pairs). Partial colourings and
covers — the objects of the slack suprema `µ_k` and of maximal covers — are wave 2's vocabulary
(`plans/FS131-kernel-plan.md` § 7), stated over the same `UnitPairsNull`.

**Inhabitant.** A finite full colouring is a genuine theorem, never a triviality (`IsEmpty (AeColouring 1)`
below): the first one this library will hold is FS111-W-SQ9's nine-colouring by half-unit squares
(wave 2, `Plane/CoverExamples`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric

/-- A Borel-measurable `k`-colouring of the plane whose unit pairs are bichromatic almost everywhere. A
Lebesgue-measurable one agrees with a Borel one off a null set, and the number is the same
(`Plane.exists_proper_of_nullMeasurable_weak`, `Plane.exists_aeColouring_of_nullMeasurable_proper`). -/
structure AeColouring (k : ℕ) where
  /-- The colour of each point. -/
  col : ℂ → Fin k
  /-- The colouring is Borel measurable. -/
  measurable : Measurable col
  /-- Each colour class has null unit pairs. -/
  unitPairsNull : ∀ j, UnitPairsNull (col ⁻¹' {j})

/-- `χ_m⁰(ℝ²)`: the least `k` admitting an `AeColouring k` (`⊤` if none). An `AeColouring` is a Borel map; the least
`k` with a Lebesgue-measurable colouring proper at almost every unit pair is the same number (the two theorems named
at `AeColouring`), and it is the Lebesgue-measurable chromatic number `Plane.chiLebesgue`
(`Plane.chiM0_eq_chiLebesgue`). -/
noncomputable def chiM0 : ℕ∞ := ⨅ (k : ℕ) (_ : Nonempty (AeColouring k)), (k : ℕ∞)

/-- Any measurable colouring proper at almost every unit pair bounds `χ_m⁰(ℝ²)`. -/
theorem chiM0_le {k : ℕ} (c : AeColouring k) : chiM0 ≤ k := iInf₂_le k ⟨c⟩

/-- No colouring with no colours. -/
instance : IsEmpty (AeColouring 0) := ⟨fun c => (c.col 0).elim0⟩

/-- **Adversary**: one colour never suffices — its class is the plane, which holds a disc of radius `2`. -/
instance : IsEmpty (AeColouring 1) := ⟨fun c => by
  have h := c.unitPairsNull 0
  have huniv : c.col ⁻¹' {0} = univ := by ext x; simp [Fin.fin_one_eq_zero (c.col x)]
  rw [huniv] at h
  exact not_unitPairsNull_ball_two (h.mono (subset_univ _))⟩

/-- Spec example: `χ_m⁰(ℝ²) ≥ 2`, from the two emptiness facts alone. -/
example : 2 ≤ chiM0 := by
  refine le_iInf₂ fun k ⟨c⟩ => ?_
  match k, c with
  | 0, c => exact (IsEmpty.false c).elim
  | 1, c => exact (IsEmpty.false c).elim
  | k + 2, _ => exact_mod_cast Nat.le_add_left 2 k

end HadwigerNelson.Plane
