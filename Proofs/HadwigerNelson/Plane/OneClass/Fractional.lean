import Proofs.HadwigerNelson.Plane.OneClass.Algebraic

/-!
# The fractional chromatic number of the plane is `1 / m₁(ℝ²)` (FS-133)

The derivation's entries C133-CHIF and C133-ONE, second line (`plans/FS133-E1-derivation.md`, stage 5):
`χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1 / m₁(ℝ²)`. `SimpleGraph.fractionalChromaticNumber` (`Fractional.lean`) is the
infimum of `n / b` over the `b`-fold colourings with `n` colours — `[Johnson1996fcn]`'s form; `[MatolcsiEtAl2025]`
p. 4's (finitely many independent sets with real weights) is the same number, by rounding the weights up to
rationals, and that is not proved here. `χ_f,0` is the supremum over the finite point sets.

* `exists_periodic_indep` — periodisation (the first half of C133-PER);
* `exists_fold_cover` — the regularisation, the grid squares and the count;
* `fractionalChromaticNumber_plane_le` — **C133-CHIF**: `χ_f(ℝ²) ≤ 1 / m₁(ℝ²)`;
* the three equalities.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral SimpleGraph

/-- **Periodisation** (C133-PER, first half): below `m₁(ℝ²)` there is a Borel set with no two points at distance
one that is periodic under `L ℤ²` for an integer `L ≥ 1`, of density more than `c` — its part in one period square
has measure more than `c L²`. -/
theorem exists_periodic_indep {c : ℝ≥0∞} (hc : c < mOne) :
    ∃ (A : Set ℂ) (L : ℕ), 0 < L ∧ MeasurableSet A ∧ (unitDistance ℂ).IsIndepSet A ∧
      IsPeriodicSet (L : ℝ) A ∧
      c * ENNReal.ofReal ((L : ℝ) ^ 2) < volume (A ∩ {z : ℂ | z.re ∈ Ico 0 (L : ℝ) ∧ z.im ∈ Ico 0 (L : ℝ)}) := by
  sorry

/-- **Finitely many translates covering every point equally often** (C133-CHIF's open regularisation, grid squares
and count): below `m₁(ℝ²)` there are `N` sets with no two points at distance one such that every point of the plane
lies in at least `b` of them, with `b ≥ c N` and `b > 0`. -/
theorem exists_fold_cover {c : ℝ≥0∞} (hc : c < mOne) :
    ∃ (N b : ℕ) (U : Fin N → Set ℂ), 0 < b ∧ c * N ≤ b ∧ (∀ j, (unitDistance ℂ).IsIndepSet (U j)) ∧
      ∀ x : ℂ, b ≤ {j | x ∈ U j}.ncard := by
  sorry

/-- **C133-CHIF**: `χ_f(ℝ²) ≤ 1 / m₁(ℝ²)`. Needs no outside theorem. -/
theorem fractionalChromaticNumber_plane_le : (unitDistance ℂ).fractionalChromaticNumber ≤ mOne⁻¹ := by
  sorry

/-- The fractional chromatic number of an induced subgraph is at most the graph's. -/
theorem fractionalChromaticNumber_induce_le {V : Type*} (G : SimpleGraph V) (S : Set V) :
    (G.induce S).fractionalChromaticNumber ≤ G.fractionalChromaticNumber :=
  fractionalChromaticNumber_mono_of_hom (Embedding.induce S).toHom

/-- **C133-ONE, second line, the plane**: `χ_f(ℝ²) = 1 / m₁(ℝ²)`. Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem fractionalChromaticNumber_plane : (unitDistance ℂ).fractionalChromaticNumber = mOne⁻¹ := by
  refine le_antisymm fractionalChromaticNumber_plane_le ?_
  rw [← finIndepRatio_plane_eq_mOne]
  exact (inv_finIndepRatio_le_iSup_fractionalChromaticNumber _).trans
    (iSup_le fun S => fractionalChromaticNumber_induce_le _ _)

/-- **C133-ONE, second line, finite point sets**: `χ_f,0(ℝ²) = 1 / m₁(ℝ²)` — the supremum of the fractional
chromatic numbers of the finite unit-distance graphs of the plane. Rests on `Spectral.residual_fourier`. -/
theorem iSup_fractionalChromaticNumber_plane :
    (⨆ S : Finset ℂ, ((unitDistance ℂ).induce (S : Set ℂ)).fractionalChromaticNumber) = mOne⁻¹ := by
  refine le_antisymm ?_ ?_
  · exact (iSup_le fun S => fractionalChromaticNumber_induce_le _ _).trans fractionalChromaticNumber_plane_le
  · rw [← finIndepRatio_plane_eq_mOne]
    exact inv_finIndepRatio_le_iSup_fractionalChromaticNumber _

/-- **C133-ONE, second line, the algebraic plane**: `χ_f(𝒜²) = 1 / m₁(ℝ²)`. Rests on
`Spectral.residual_fourier`. -/
theorem fractionalChromaticNumber_algPlane : (unitDistance E).fractionalChromaticNumber = mOne⁻¹ := by
  refine le_antisymm ?_ ?_
  · exact (fractionalChromaticNumber_mono_of_hom algPlaneEmbedding.toHom).trans fractionalChromaticNumber_plane_le
  · rw [← finIndepRatio_algPlane_eq_mOne]
    exact (inv_finIndepRatio_le_iSup_fractionalChromaticNumber _).trans
      (iSup_le fun S => fractionalChromaticNumber_induce_le _ _)

end HadwigerNelson.OneClass
