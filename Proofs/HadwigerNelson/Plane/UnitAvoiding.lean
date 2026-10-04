import Proofs.HadwigerNelson.Plane.UnitPairs

/-!
# Maximal unit-avoiding sets and the circle measure `φ_A` (FS-131 wave 1)

Row: **FS111-M2-ZERO**. Plan: `plans/FS131-kernel-plan.md` § 6.

`φ_A(p) = σ{w ∈ S¹ : p + w ∈ A}` is `phi A p`, read through the angle parametrization of `σ`. A **MUA set** (maximal
unit-avoiding) is a measurable set with null unit pairs, maximal under inclusion up to null sets among such sets — "a
measurable independent dominating set of the unit-distance graph". By Tonelli, null unit pairs is `φ_A = 0` almost
everywhere on `A`, and maximality is `φ_A > 0` almost everywhere off `A`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-- `φ_A(p)`: the arc-length of the directions from `p` that land in `A` at distance `1`. -/
noncomputable def phi (A : Set ℂ) (p : ℂ) : ENNReal := arcLength {θ | p + e θ ∈ A}

/-- A **MUA set**: measurable, null unit pairs, and maximal up to null sets among measurable sets with null unit
pairs. -/
def IsMUA (A : Set ℂ) : Prop :=
  MeasurableSet A ∧ UnitPairsNull A ∧
    ∀ B : Set ℂ, MeasurableSet B → UnitPairsNull B → A ≤ᵐ[volume] B → B ≤ᵐ[volume] A

/-- Spec: `φ` of the plane is the whole circle. -/
theorem phi_univ (p : ℂ) : phi univ p = ENNReal.ofReal (2 * Real.pi) := by
  sorry

/-- **FS111-M2-ZERO**, unit-avoiding half: a measurable `A` has null unit pairs iff `φ_A = 0` almost everywhere on `A`. -/
theorem unitPairsNull_iff_ae_phi_eq_zero {A : Set ℂ} (hA : MeasurableSet A) :
    UnitPairsNull A ↔ ∀ᵐ p ∂(volume.restrict A), phi A p = 0 := by
  sorry

/-- **FS111-M2-ZERO**, maximal half: a measurable `A` with null unit pairs is a MUA set iff `φ_A > 0` almost
everywhere off `A`. -/
theorem isMUA_iff_ae_phi_pos {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) :
    IsMUA A ↔ ∀ᵐ p ∂(volume.restrict Aᶜ), 0 < phi A p := by
  sorry

/-- **FS111-M2-ZERO**: a measurable `A` is a MUA set iff `A = {φ_A = 0}` almost everywhere. -/
theorem isMUA_iff_ae_eq {A : Set ℂ} (hA : MeasurableSet A) :
    IsMUA A ↔ A =ᵐ[volume] {p | phi A p = 0} := by
  sorry

end HadwigerNelson.Plane
