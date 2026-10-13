import Proofs.HadwigerNelson.Plane.OneClass.SectionDensity
import Proofs.HadwigerNelson.Plane.OneClass.Field
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
import Proofs.HadwigerNelson.Plane.DensityPoints
import Proofs.HadwigerNelson.Plane.Slack

/-!
# The finitary independence ratio of the plane is its measurable density (FS-133)

The derivation's entries C133-ALG, C133-EASY, C133-ONE (first line) and C133-FN (`plans/FS133-E1-derivation.md`,
stage 5):

* `exists_measurable_indep_of_field` — from a field to a set (the density step and the density points): a jointly
  measurable `[0, 1]`-valued field over the plane with mean at least `δ` at every point, whose values at two points
  one unit apart have almost surely zero product, has a sample whose density points are a Borel set with no two
  points at distance one and upper density at least `δ`;
* `IsInvariantLaw.measure_origin_le_mOne` — **C133-ALG**: an invariant random independent set of the unit-distance
  graph of the algebraic plane has density at most `m₁(ℝ²)`;
* `mOne_le_finIndepRatio` — C133-EASY, the averaging bound;
* `finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne` — **C133-ONE, first line**:
  `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`;
* `tendsto_minIndepNum_div` — **C133-FN**: `f(n) / n → m₁(ℝ²)`.

The two headlines and C133-ALG rest on the declared outside theorem `Outside.OAI158.Spectral.residual_fourier`
(through `exists_field`). Not claimed: any value of `m₁(ℝ²)`; anything at a number field's plane; that the release
states any of this (its manuscript does not); that the result is new (`[Davies2026]` proves the same sentence in
dimension four and up).
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral SimpleGraph

/-- **From a field to a set** (the derivation's C133-DENS as posed, with the density points of C133-DP). On any
probability space: a jointly measurable `H : ℂ × Ω → [0, 1]` with `∫ H (x, ·) ≥ δ` at every `x` and
`H (x, ·) H (x + w, ·) = 0` almost surely at every `x` and unit `w` gives a Borel set of the plane with no two
points at distance one and upper density at least `δ`. No outside theorem. The hypotheses hold trivially for
`H = 0`, `δ ≤ 0`; with `δ > 0` they hold for the field `exists_field` gives at an invariant random independent set
of positive density (the consumer, `IsInvariantLaw.measure_origin_le_mOne`). -/
theorem exists_measurable_indep_of_field {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω) [IsProbabilityMeasure P]
    {H : ℂ × Ω → ℝ} (hH : Measurable H) (h01 : ∀ p, 0 ≤ H p ∧ H p ≤ 1) {δ : ℝ}
    (hmean : ∀ x, δ ≤ ∫ ω, H (x, ω) ∂P)
    (hunit : ∀ x w : ℂ, ‖w‖ = 1 → ∀ᵐ ω ∂P, H (x, ω) * H (x + w, ω) = 0) :
    ∃ A : Set ℂ, MeasurableSet A ∧ (unitDistance ℂ).IsIndepSet A ∧ ENNReal.ofReal δ ≤ upperDensity A := by
  sorry

/-- **C133-ALG.** Every invariant random independent set of the unit-distance graph of the algebraic plane has
density at most `m₁(ℝ²)`. Rests on the declared outside theorem `Spectral.residual_fourier`. Its hypothesis is
inhabited with positive density: `exists_isInvariantLaw_unitDistance`. -/
theorem IsInvariantLaw.measure_origin_le_mOne {P : Measure (E → Bool)} (h : IsInvariantLaw (unitDistance E) P) :
    P {I | I 0 = true} ≤ mOne := by
  sorry

/-- **C133-EASY**: `m₁(ℝ²) ≤ α(G) / |G|` for every finite point set `G` of the plane — a measurable set with no two
points at distance one, translated at random, meets `G` in an independent set. -/
theorem mOne_le_finIndepRatio : mOne ≤ (unitDistance ℂ).finIndepRatio := by
  sorry

/-- `α₁(𝒜²) ≤ m₁(ℝ²)`: the law of best density, bounded by C133-ALG. -/
theorem finIndepRatio_algPlane_le_mOne : (unitDistance E).finIndepRatio ≤ mOne := by
  obtain ⟨P, hP, hval⟩ := exists_isInvariantLaw_unitDistance
  rw [← hval]
  exact hP.measure_origin_le_mOne

/-- **C133-ONE, first line, the plane**: `α₁(ℝ²) = m₁(ℝ²)` — the infimum of `α(G) / |G|` over the finite point
sets of the plane is the supremum of the upper densities of its measurable sets with no two points at distance
one. Rests on the declared outside theorem `Spectral.residual_fourier`. -/
theorem finIndepRatio_plane_eq_mOne : (unitDistance ℂ).finIndepRatio = mOne :=
  le_antisymm ((finIndepRatio_le_of_embedding algPlaneEmbedding).trans finIndepRatio_algPlane_le_mOne)
    mOne_le_finIndepRatio

/-- **C133-ONE, first line, the algebraic plane**: `α₁(𝒜²) = m₁(ℝ²)`. Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem finIndepRatio_algPlane_eq_mOne : (unitDistance E).finIndepRatio = mOne :=
  le_antisymm finIndepRatio_algPlane_le_mOne
    (mOne_le_finIndepRatio.trans (finIndepRatio_le_of_embedding algPlaneEmbedding))

/-- Neither side is trivial: `1 / 7 ≤ m₁(ℝ²)`, from the seven-colouring of the plane and the equality. -/
theorem one_seventh_le_mOne : (7 : ℝ≥0∞)⁻¹ ≤ mOne := by
  sorry

/-- `f(n) / n → α₁(ℝ²)`: Fekete's lemma for the subadditive `f`, whose ratios have infimum the finitary
independence ratio. No outside theorem. -/
theorem tendsto_minIndepNum_div_finIndepRatio :
    Tendsto (fun n : ℕ => (minIndepNum n : ℝ≥0∞) / n) atTop (𝓝 (unitDistance ℂ).finIndepRatio) := by
  sorry

/-- **C133-FN**: `f(n) / n → m₁(ℝ²)`, where `f(n)` is the least independence number of the unit-distance graph on
`n` points of the plane (`[DuczVarga2026]` Conjecture 1, first clause). Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem tendsto_minIndepNum_div : Tendsto (fun n : ℕ => (minIndepNum n : ℝ≥0∞) / n) atTop (𝓝 mOne) :=
  finIndepRatio_plane_eq_mOne ▸ tendsto_minIndepNum_div_finIndepRatio

end HadwigerNelson.OneClass
