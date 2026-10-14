import Proofs.HadwigerNelson.Plane.OneAvoidingDensity
import Proofs.HadwigerNelson.Plane.DensityPoints
import Proofs.HadwigerNelson.Plane.UnitAvoiding

/-!
# `m₁` in a window, and the neighbourhood ratio of the unit-distance graph (FS-131, job FS131-K12A; module M12, block P; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C4, "Lemma X′" and C14.1-e; `plans/FS86-R88-D-derivation.md`). The count
reads the plane's measurable independence ratio `m₁ = Plane.mOne` in two finite forms, both about one square window
`sq a s = [a.re, a.re + s) × [a.im, a.im + s)` and both for sets whose unit pairs are null (`UnitPairsNull`: the essential,
measure-zero form of "1-avoiding"):

* `volume_inter_sq_le` — **`m₁` in a window**: `|A ∩ sq a s| ≤ m₁ · (s + 2)²`. Route: the density points of `A` form a
  1-avoiding set equal to `A` almost everywhere (`Plane.dist_ne_one_of_mem_densitySet`); copies of its trace on the square
  placed at the points of the lattice `(s + 2)·ℤ[i]` are at least `2` apart, so their union is a periodic measurable
  1-avoiding set; a periodic set's upper density is at least its density in one cell (`le_upperDensity_of_periodic`), and
  every such upper density is at most `m₁` (the definition).
* `exists_periodic_near_mOne` — **a periodic 1-avoiding set of density near `m₁`**, from the supremum defining `m₁`.
* `volume_inter_sq_le_essNbhd` — **the neighbourhood ratio** (C14.1-e): `|Z ∩ sq a s| ≤ m₁ |N_e[Z] ∩ sq a s| + O(s) + ε s²`,
  where `N_e[Z] = Z ∪ {x : the unit circle about x meets Z in positive length}` (`essNbhd`). Route: for a near-optimal
  periodic `J` and `t` in its cell, `((J + t) \ N_e[Z]) ∪ Z` has null unit pairs, so the window bound applies to it;
  averaging over `t` gives `|Z ∩ Q| + δ_J |Q \ N_e[Z]| ≤ m₁ (s + 2)²`.

Nothing here reads the outside theorem `[AmbrusEtAl2023]`: `m₁` is the library's supremum, and the count applies
`Plane.mOne_lt_quarter` to it. All three are the derivation's window lemmas restated for one plane — the count's
archimedean factor is one copy of `UD(ℝ²)` at every number field (module `Rigidity/CountTorus`, the slice `Δ = ℚ(i) ⊗ ℝ`).

**Models.** The empty set and the open disc of radius `1/3` have null unit pairs (`Plane.unitPairsNull_of_dist_lt_one`);
`essNbhd ∅ = ∅`.
-/

namespace HadwigerNelson.Plane

open MeasureTheory Filter Metric Set Complex

noncomputable section

/-- **The half-open square** `[a.re, a.re + s) × [a.im, a.im + s)`, read through `ℂ ≃ ℝ × ℝ` so that its measure is
Mathlib's (`Complex.volume_preserving_equiv_real_prod`, `Real.volume_Ico`). -/
def sq (a : ℂ) (s : ℝ) : Set ℂ := Complex.equivRealProd ⁻¹' (Set.Ico a.re (a.re + s) ×ˢ Set.Ico a.im (a.im + s))

/-- **The essential closed neighbourhood** `N_e[Z]`: `Z` together with the points whose unit circle meets `Z` in positive
length (`Plane.phi Z x ≠ 0`). -/
def essNbhd (Z : Set ℂ) : Set ℂ := Z ∪ {x | phi Z x ≠ 0}

theorem measurableSet_sq (a : ℂ) (s : ℝ) : MeasurableSet (sq a s) := by
  sorry

theorem volume_sq (a : ℂ) {s : ℝ} (hs : 0 ≤ s) : volume (sq a s) = ENNReal.ofReal (s ^ 2) := by
  sorry

theorem measurableSet_essNbhd {Z : Set ℂ} (hZ : MeasurableSet Z) : MeasurableSet (essNbhd Z) :=
  hZ.union ((measurable_phi hZ) (measurableSet_singleton 0)).compl

/-- **Regularisation**: the density points of a measurable set with null unit pairs form a 1-avoiding set equal to it almost
everywhere. -/
theorem densitySet_bandFree {A : Set ℂ} (hA : MeasurableSet A) (h : UnitPairsNull A) :
    BandFree (densitySet A) 0 ∧ densitySet A =ᵐ[volume] A := by
  sorry

/-- **A periodic set's upper density is at least its density in one cell.** -/
theorem le_upperDensity_of_periodic {P : Set ℂ} {L : ℝ} (hL : 0 < L) (hP : MeasurableSet P) (hper : IsPeriodicSet L P) :
    volume (P ∩ sq 0 L) / ENNReal.ofReal (L ^ 2) ≤ upperDensity P := by
  sorry

/-- **The periodisation of a 1-avoiding set's trace on a square**, at spacing `s + 2`, is 1-avoiding. -/
theorem bandFree_periodize {A : Set ℂ} (hA : BandFree A 0) (a : ℂ) {s : ℝ} (hs : 0 < s) :
    BandFree {z | ∃ m n : ℤ, z - ((s + 2) * m + (s + 2) * n * I) ∈ A ∩ sq a s} 0 := by
  sorry

/-- **`m₁` in a window.** -/
theorem volume_inter_sq_le {A : Set ℂ} (hA : MeasurableSet A) (h : UnitPairsNull A) (a : ℂ) {s : ℝ} (hs : 0 < s) :
    volume (A ∩ sq a s) ≤ mOne * ENNReal.ofReal ((s + 2) ^ 2) := by
  sorry

/-- **A periodic 1-avoiding set of density within `ε` of `m₁`**, its period at least `L₀`. -/
theorem exists_periodic_near_mOne {ε : ℝ} (hε : 0 < ε) :
    ∃ L : ℝ, 0 < L ∧ ∃ J : Set ℂ, MeasurableSet J ∧ BandFree J 0 ∧ IsPeriodicSet L J ∧
      mOne.toReal - ε ≤ volume.real (J ∩ sq 0 L) / L ^ 2 := by
  sorry

/-- **The neighbourhood ratio of the unit-distance graph, in a window** (C14.1-e). -/
theorem volume_inter_sq_le_essNbhd {Z : Set ℂ} (hZ : MeasurableSet Z) (h : UnitPairsNull Z) {ε : ℝ} (hε : 0 < ε) :
    ∃ s₀ : ℝ, 0 < s₀ ∧ ∀ (a : ℂ) (s : ℝ), s₀ ≤ s →
      volume.real (Z ∩ sq a s) ≤ mOne.toReal * volume.real (essNbhd Z ∩ sq a s) + ε * s ^ 2 := by
  sorry

theorem mOne_le_one : mOne ≤ 1 :=
  iSup₂_le fun A _ => upperDensity_le_one A

/-! ## Spec examples -/

/-- The origin lies in its own unit square. -/
example : (0 : ℂ) ∈ sq 0 1 := by
  simp [sq, Complex.equivRealProd]

/-- The essential neighbourhood of the empty set is empty. -/
example : essNbhd ∅ = ∅ := by
  sorry

end

end HadwigerNelson.Plane
