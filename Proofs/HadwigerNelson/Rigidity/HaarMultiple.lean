import Mathlib.MeasureTheory.Measure.Sub
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import Mathlib.MeasureTheory.MeasurableSpace.Embedding

/-!
# The largest multiple of one measure below another (FS-131, job FS131-KN7; skeleton)

**Read aloud, against the derivation** (`plans/FS131-EN2-derivation.md` § 5.2, EN2-PE2-MAX step 1; module M7 of the chain,
`data/fs131/kn3/claims-M7-entropy-split.md`): "For a finite measure `τ`, the set `{c ≥ 0 : c·m ≤ τ}` (setwise inequality on
Borel sets) contains `0`, is bounded by `τ(X)` and is closed; let `a` be its maximum. `τ′ := τ − a·m` is a finite positive
measure, `U`-invariant because `τ` and `m` are, and no `c > 0` has `c·m ≤ τ′`."

Here, for measures `τ` and `m` on any measurable space: `maxMultiple τ m := sSup {c | c • m ≤ τ}` (in `ℝ≥0∞`; Mathlib's `≤`
on measures is the setwise inequality on measurable sets, `Measure.le_iff`) — the upper adjoint of `c ↦ c • m`
(`smul_le_iff_le_maxMultiple`) — which is attained (`maxMultiple_smul_le`),
at most `τ(univ)` when `m` is a probability (`maxMultiple_le_measure_univ`), leaves a remainder `τ − a • m` with
`τ − a • m + a • m = τ` (`sub_maxMultiple_add`) under which no positive multiple of `m` fits
(`not_smul_le_sub_maxMultiple`), and is carried along by every measurable equivalence preserving both measures
(`map_sub_maxMultiple`). Nothing here is about characters, rotations or entropy: the chain's module for PE-2 reads it at
`τ` a rotation-invariant measure on `Dual F` and `m` its Haar measure.

**Inhabitants.** `maxMultiple_self`: a probability measure is its own largest multiple, with remainder `0` — every clause
exercised at `τ = m` (`c • m ≤ m` forces `c ≤ 1`). The entry's model `τ = m + λ_ρ` (`a = 1`) needs a measure singular to
Haar, not in the library.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory

open scoped ENNReal

variable {Y : Type*} [MeasurableSpace Y]

/-- **The largest multiple of `m` below `τ`**: `sup {c | c • m ≤ τ}` (EN2-PE2-MAX step 1). -/
noncomputable def maxMultiple (τ m : Measure Y) : ℝ≥0∞ :=
  sSup {c : ℝ≥0∞ | c • m ≤ τ}

/-- Every multiple below `τ` is at most the largest. -/
theorem le_maxMultiple {τ m : Measure Y} {c : ℝ≥0∞} (h : c • m ≤ τ) : c ≤ maxMultiple τ m :=
  le_sSup h

/-- **The supremum is attained**: `maxMultiple τ m • m ≤ τ` (on each measurable set, `(sup c) · m(s) = sup (c · m(s))`). -/
theorem maxMultiple_smul_le (τ m : Measure Y) : maxMultiple τ m • m ≤ τ := by
  sorry

/-- **The Galois connection**: `c • m ≤ τ` exactly when `c ≤ maxMultiple τ m` — `c ↦ c • m` has `maxMultiple · m` as its
upper adjoint. The other statements of this module are read off it. (`→`: `le_maxMultiple`; `←`: `maxMultiple_smul_le`
and `smul_le_smul_right`-shape monotonicity of `c ↦ c • m`.) -/
theorem smul_le_iff_le_maxMultiple {τ m : Measure Y} {c : ℝ≥0∞} : c • m ≤ τ ↔ c ≤ maxMultiple τ m := by
  sorry

/-- **Bounded by the total mass** when `m` is a probability: `a = a · m(univ) ≤ τ(univ)`. -/
theorem maxMultiple_le_measure_univ (τ m : Measure Y) [IsProbabilityMeasure m] : maxMultiple τ m ≤ τ Set.univ := by
  sorry

/-- The remainder and the largest multiple add back to `τ` (`Measure.sub_add_cancel_of_le`). -/
theorem sub_maxMultiple_add (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] :
    τ - maxMultiple τ m • m + maxMultiple τ m • m = τ := by
  sorry

/-- **No positive multiple of `m` fits under the remainder** — else `(a + c) • m ≤ τ` with `a` finite. -/
theorem not_smul_le_sub_maxMultiple (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] {c : ℝ≥0∞}
    (hc : c ≠ 0) : ¬ c • m ≤ τ - maxMultiple τ m • m := by
  sorry

/-- **The remainder is invariant** under every measurable equivalence that preserves `τ` and `m` (the largest multiple of
the pushed pair is the same number). -/
theorem map_sub_maxMultiple (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] (e : Y ≃ᵐ Y)
    (hτ : τ.map e = τ) (hm : m.map e = m) :
    (τ - maxMultiple τ m • m).map e = τ - maxMultiple τ m • m := by
  sorry

/-- **A model**: a probability measure is its own largest multiple. Every clause above is exercised at `τ = m`. -/
theorem maxMultiple_self (m : Measure Y) [IsProbabilityMeasure m] : maxMultiple m m = 1 := by
  sorry

end HadwigerNelson.Rigidity
