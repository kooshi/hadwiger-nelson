import Proofs.HadwigerNelson.Plane.OneAvoidingDensity
import Proofs.HadwigerNelson.Plane.DensityPoints
import Proofs.HadwigerNelson.Plane.UnitAvoiding
import Proofs.HadwigerNelson.Plane.Slack

/-!
# `m₁` in a window, and the neighbourhood ratio of the unit-distance graph (FS-131, job FS131-K12A; module M12, block P; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C4, "Lemma X′" and C14.1-e; `plans/FS86-R88-D-derivation.md`). The count
reads the plane's measurable independence ratio `m₁ = Plane.mOne` in two finite forms, both about one square window
`squareWin a s = [a.re, a.re + s) × [a.im, a.im + s)` and both for sets whose unit pairs are null (`UnitPairsNull`: the essential,
measure-zero form of "1-avoiding"):

* `volume_inter_sq_le` — **`m₁` in a window**: `|A ∩ squareWin a s| ≤ m₁ · (s + 2)²`. Route, every step in the kernel: the
  density points of `A` form a measurable 1-avoiding set equal to `A` almost everywhere (`Plane.measurableSet_densitySet`,
  `Plane.dist_ne_one_of_mem_densitySet`); its trace on the window, periodised at `s + 2` (`Plane.periodize`,
  `Plane.bandFree_periodize`, `Plane.measurableSet_periodize` of `Plane/Slack`), is 1-avoiding with upper density
  `|trace| / (s + 2)²` (`Plane.upperDensity_periodize`), which `m₁` bounds by its definition.
* `exists_periodic_near_mOne` — **a periodic 1-avoiding set of density near `m₁`**: the supremum defining `m₁`, a dense
  window (`Plane.exists_squareWin_dense`), periodised.
* `exists_nrWindow` — **the neighbourhood ratio** (C14.1-e), with one scale for every set (`NRWindow ε s₀`):
  `|Z ∩ squareWin a s| ≤ m₁ |N_e[Z] ∩ squareWin a s| + ε s²` for `s ≥ s₀`, where `N_e[Z] = Z ∪ {x : the unit circle about x meets Z in
  positive length}` (`essNbhd`). Route: for a near-optimal periodic `J` and `t` in its cell, `((J + t) \ N_e[Z]) ∪ Z` has
  null unit pairs (`unitPairsNull_diff_essNbhd_union`), so the window bound applies to it; averaging over `t` gives
  `|Z ∩ Q| + δ_J |Q \ N_e[Z]| ≤ m₁ (s + 2)²`.

Nothing here reads the outside theorem `[AmbrusEtAl2023]`: `m₁` is the library's supremum, and the count applies
`Plane.mOne_lt_quarter` to it. All three are the derivation's window lemmas restated for one plane — the count's
archimedean factor is one copy of `UD(ℝ²)` at every number field (module `Rigidity/CountTorus`, the slice `Δ = ℚ(i) ⊗ ℝ`).

**Models.** The empty set and the open disc of radius `1/3` have null unit pairs (`Plane.unitPairsNull_of_dist_lt_one`);
`essNbhd ∅ = ∅`.
-/

namespace HadwigerNelson.Plane

open MeasureTheory Filter Metric Set Complex

noncomputable section

/-- **The essential closed neighbourhood** `N_e[Z]`: `Z` together with the points whose unit circle meets `Z` in positive
length (`Plane.phi Z x ≠ 0`). -/
def essNbhd (Z : Set ℂ) : Set ℂ := Z ∪ {x | phi Z x ≠ 0}

theorem measurableSet_essNbhd {Z : Set ℂ} (hZ : MeasurableSet Z) : MeasurableSet (essNbhd Z) :=
  hZ.union ((measurable_phi hZ) (measurableSet_singleton 0)).compl

/-- **Regularisation**: the density points of a measurable set with null unit pairs form a 1-avoiding set equal to it almost
everywhere. -/
theorem densitySet_bandFree {A : Set ℂ} (hA : MeasurableSet A) (h : UnitPairsNull A) :
    BandFree (densitySet A) 0 ∧ densitySet A =ᵐ[volume] A := by
  sorry

/-- **`m₁` in a window.** -/
theorem volume_inter_sq_le {A : Set ℂ} (hA : MeasurableSet A) (h : UnitPairsNull A) (a : ℂ) {s : ℝ} (hs : 0 < s) :
    volume (A ∩ squareWin a s) ≤ mOne * ENNReal.ofReal ((s + 2) ^ 2) := by
  sorry

/-- **A periodic 1-avoiding set of density within `ε` of `m₁`**, its period at least `L₀`. -/
theorem exists_periodic_near_mOne {ε : ℝ} (hε : 0 < ε) :
    ∃ L : ℝ, 0 < L ∧ ∃ J : Set ℂ, MeasurableSet J ∧ BandFree J 0 ∧ IsPeriodicSet L J ∧
      mOne.toReal - ε ≤ volume.real (J ∩ squareWin 0 L) / L ^ 2 := by
  sorry

/-- **C14.1-e's union**: a 1-avoiding set with the essential neighbourhood of a set with null unit pairs removed, together
with that set, has null unit pairs. -/
theorem unitPairsNull_diff_essNbhd_union {J Z : Set ℂ} (hJ : MeasurableSet J) (hJ1 : BandFree J 0)
    (hZ : MeasurableSet Z) (hZ1 : UnitPairsNull Z) : UnitPairsNull ((J \ essNbhd Z) ∪ Z) := by
  sorry

/-- **The neighbourhood ratio of the unit-distance graph, in a window, at scale `s₀` and slack `ε`** (C14.1-e) — uniform
in the set, as the count reads it (one `s₀` for the lonely sets of every row at every level). -/
def NRWindow (ε s₀ : ℝ) : Prop :=
  ∀ Z : Set ℂ, MeasurableSet Z → UnitPairsNull Z → ∀ (a : ℂ) (s : ℝ), s₀ ≤ s →
    volume.real (Z ∩ squareWin a s) ≤ mOne.toReal * volume.real (essNbhd Z ∩ squareWin a s) + ε * s ^ 2

/-- **The neighbourhood ratio holds at every slack, from some scale on.** Route: a near-optimal periodic `J`
(`exists_periodic_near_mOne`); for `t` in its cell, `((J + t) \ N_e[Z]) ∪ Z` has null unit pairs
(`unitPairsNull_diff_essNbhd_union`), so `volume_inter_sq_le` bounds it; average over `t`. -/
theorem exists_nrWindow {ε : ℝ} (hε : 0 < ε) : ∃ s₀ : ℝ, 0 < s₀ ∧ NRWindow ε s₀ := by
  sorry

theorem mOne_le_one : mOne ≤ 1 :=
  iSup₂_le fun A _ => upperDensity_le_one A

/-! ## Spec examples -/

/-- The essential neighbourhood of the empty set is empty. -/
example : essNbhd ∅ = ∅ := by
  sorry

end

end HadwigerNelson.Plane
