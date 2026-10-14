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
  rw [Measure.le_iff]
  intro s hs
  rw [Measure.smul_apply, smul_eq_mul, maxMultiple, ENNReal.sSup_mul]
  refine iSup₂_le fun c hc => ?_
  have h := Measure.le_iff.mp (show c • m ≤ τ from hc) s hs
  rwa [Measure.smul_apply, smul_eq_mul] at h

/-- **The Galois connection**: `c • m ≤ τ` exactly when `c ≤ maxMultiple τ m` — `c ↦ c • m` has `maxMultiple · m` as its
upper adjoint. The other statements of this module are read off it. (`→`: `le_maxMultiple`; `←`: `maxMultiple_smul_le`
and `smul_le_smul_right`-shape monotonicity of `c ↦ c • m`.) -/
theorem smul_le_iff_le_maxMultiple {τ m : Measure Y} {c : ℝ≥0∞} : c • m ≤ τ ↔ c ≤ maxMultiple τ m := by
  refine ⟨le_maxMultiple, fun h => le_trans ?_ (maxMultiple_smul_le τ m)⟩
  rw [Measure.le_iff]
  intro s _
  simp only [Measure.smul_apply, smul_eq_mul]
  gcongr

/-- **Bounded by the total mass** when `m` is a probability: `a = a · m(univ) ≤ τ(univ)`. -/
theorem maxMultiple_le_measure_univ (τ m : Measure Y) [IsProbabilityMeasure m] : maxMultiple τ m ≤ τ Set.univ := by
  have h := Measure.le_iff.mp (maxMultiple_smul_le τ m) Set.univ MeasurableSet.univ
  rwa [Measure.smul_apply, smul_eq_mul, measure_univ, mul_one] at h

/-- The largest multiple of a probability measure below a finite measure is finite. -/
private theorem maxMultiple_ne_top (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] :
    maxMultiple τ m ≠ ⊤ :=
  ((maxMultiple_le_measure_univ τ m).trans_lt (measure_lt_top τ _)).ne

/-- The largest multiple of a probability measure below a finite measure is a finite measure. -/
private theorem isFiniteMeasure_maxMultiple_smul (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] :
    IsFiniteMeasure (maxMultiple τ m • m) :=
  ⟨by
    rw [Measure.smul_apply, smul_eq_mul, measure_univ, mul_one]
    exact (maxMultiple_le_measure_univ τ m).trans_lt (measure_lt_top τ _)⟩

/-- The remainder and the largest multiple add back to `τ` (`Measure.sub_add_cancel_of_le`). -/
theorem sub_maxMultiple_add (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] :
    τ - maxMultiple τ m • m + maxMultiple τ m • m = τ := by
  haveI := isFiniteMeasure_maxMultiple_smul τ m
  exact Measure.sub_add_cancel_of_le (maxMultiple_smul_le τ m)

/-- **No positive multiple of `m` fits under the remainder** — else `(a + c) • m ≤ τ` with `a` finite. -/
theorem not_smul_le_sub_maxMultiple (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] {c : ℝ≥0∞}
    (hc : c ≠ 0) : ¬ c • m ≤ τ - maxMultiple τ m • m := by
  intro h
  have h2 : (maxMultiple τ m + c) • m ≤ τ := by
    rw [Measure.le_iff]
    intro s hs
    have h1 := Measure.le_iff.mp h s hs
    calc ((maxMultiple τ m + c) • m) s = (c • m) s + (maxMultiple τ m • m) s := by
          simp only [Measure.smul_apply, smul_eq_mul]
          ring
      _ ≤ (τ - maxMultiple τ m • m) s + (maxMultiple τ m • m) s := by gcongr
      _ = τ s := by rw [← Measure.add_apply, sub_maxMultiple_add]
  have h3 : maxMultiple τ m + c ≤ maxMultiple τ m + 0 := by
    rw [add_zero]
    exact le_maxMultiple h2
  exact hc (nonpos_iff_eq_zero.mp ((ENNReal.add_le_add_iff_left (maxMultiple_ne_top τ m)).mp h3))

/-- **The remainder is invariant** under every measurable equivalence that preserves `τ` and `m` (the largest multiple of
the pushed pair is the same number). -/
theorem map_sub_maxMultiple (τ m : Measure Y) [IsFiniteMeasure τ] [IsProbabilityMeasure m] (e : Y ≃ᵐ Y)
    (hτ : τ.map e = τ) (hm : m.map e = m) :
    (τ - maxMultiple τ m • m).map e = τ - maxMultiple τ m • m := by
  haveI := isFiniteMeasure_maxMultiple_smul τ m
  ext s hs
  have hes : MeasurableSet (e ⁻¹' s) := e.measurable hs
  have h1 : τ (e ⁻¹' s) = τ s := by rw [← e.map_apply, hτ]
  have h2 : m (e ⁻¹' s) = m s := by rw [← e.map_apply, hm]
  rw [e.map_apply, Measure.sub_apply hes (maxMultiple_smul_le τ m),
    Measure.sub_apply hs (maxMultiple_smul_le τ m)]
  simp only [Measure.smul_apply, smul_eq_mul, h1, h2]

/-- **A model**: a probability measure is its own largest multiple. Every clause above is exercised at `τ = m`. -/
theorem maxMultiple_self (m : Measure Y) [IsProbabilityMeasure m] : maxMultiple m m = 1 :=
  le_antisymm ((maxMultiple_le_measure_univ m m).trans_eq measure_univ) (le_maxMultiple (by rw [one_smul]))

end HadwigerNelson.Rigidity

open HadwigerNelson.Rigidity in
#print axioms maxMultiple_smul_le
open HadwigerNelson.Rigidity in
#print axioms map_sub_maxMultiple
open HadwigerNelson.Rigidity in
#print axioms not_smul_le_sub_maxMultiple
open HadwigerNelson.Rigidity in
#print axioms maxMultiple_self
example : (1 : ℕ) = 2 := rfl
