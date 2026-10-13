import Mathlib.MeasureTheory.Measure.Prod
import Mathlib.MeasureTheory.Integral.Lebesgue.DominatedConvergence
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability

/-!
# A random set that covers each point with probability `α` has upper density `α` with positive probability (FS-133)

The derivation's entry C133-DENS-CLASS (`plans/FS133-E1-derivation.md`, stage 3): the reverse Fatou lemma applied to
the window averages of a random set. No plane, no group and no topology: a measurable `W ⊆ X × Ω`, a probability `μ`
on `Ω`, windows `Xn n ⊆ X` of finite positive measure.

* `sectionDensity lam Xn W ω` is `limsup_n lam (Xn n ∩ W_ω) / lam (Xn n)`, the upper density along the windows of the
  section `W_ω = {x | (x, ω) ∈ W}`.
* The set form (`measurable_sectionDensity`, `le_lintegral_sectionDensity`, `measure_le_sectionDensity_pos`,
  `exists_mem_le_sectionDensity`): if almost every point of every window is covered with probability at least `α`,
  then `∫ D dμ ≥ α`, the event `{D ≥ α}` has positive probability, and every event of full measure meets it.
* `sectionDensity_setOf_pos` (the entry as written): for a measurable `H ≤ 1` with mean at least `α` at almost every
  point, the same for `W = {H > 0}`.

Wider than the entry in three ways, each because the proof never reads the hypothesis: the measure on `X` need not be
σ-finite (each window has finite measure, and nothing outside the windows is read); `H` need not be nonnegative
(`H ≤ 1` alone gives `H ≤ 1_{H > 0}`); and the conclusion is about any measurable random set, of which `{H > 0}` is
one. Not claimed (the entry's line): that almost every `ω` has `D ω ≥ α`; the same with `liminf`; convergence of the
window averages.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.Plane

variable {X Ω : Type*} [MeasurableSpace X] [MeasurableSpace Ω]

/-- The upper density, along the windows `Xn`, of the section at `ω` of a set `W ⊆ X × Ω`:
`limsup_n lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n)`. -/
noncomputable def sectionDensity (lam : Measure X) (Xn : ℕ → Set X) (W : Set (X × Ω)) (ω : Ω) : ℝ≥0∞ :=
  limsup (fun n => lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n)) atTop

/-- Drift check: the section of the whole space has density `1` along any windows of finite positive measure. -/
theorem sectionDensity_univ (lam : Measure X) {Xn : ℕ → Set X} (hpos : ∀ n, lam (Xn n) ≠ 0)
    (hfin : ∀ n, lam (Xn n) ≠ ⊤) (ω : Ω) : sectionDensity lam Xn (univ : Set (X × Ω)) ω = 1 := by
  sorry

/-- Drift check: the empty set has density `0`. -/
theorem sectionDensity_empty (lam : Measure X) (Xn : ℕ → Set X) (ω : Ω) :
    sectionDensity lam Xn (∅ : Set (X × Ω)) ω = 0 := by
  sorry

/-- The density of the section is a measurable function of `ω` (Tonelli on each window, which has finite measure). -/
theorem measurable_sectionDensity (lam : Measure X) {Xn : ℕ → Set X} {W : Set (X × Ω)} (hW : MeasurableSet W)
    (hXm : ∀ n, MeasurableSet (Xn n)) (hfin : ∀ n, lam (Xn n) ≠ ⊤) : Measurable (sectionDensity lam Xn W) := by
  sorry

/-- **The reverse Fatou step.** If, in each window, almost every point is covered by the random set with probability
at least `α`, the mean upper density of the random set is at least `α`. -/
theorem le_lintegral_sectionDensity (lam : Measure X) (μ : Measure Ω) [IsProbabilityMeasure μ] {Xn : ℕ → Set X}
    {W : Set (X × Ω)} (hW : MeasurableSet W) (hXm : ∀ n, MeasurableSet (Xn n)) (hpos : ∀ n, lam (Xn n) ≠ 0)
    (hfin : ∀ n, lam (Xn n) ≠ ⊤) {α : ℝ≥0∞} (hcov : ∀ n, ∀ᵐ x ∂lam.restrict (Xn n), α ≤ μ {ω | (x, ω) ∈ W}) :
    α ≤ ∫⁻ ω, sectionDensity lam Xn W ω ∂μ := by
  sorry

/-- With positive probability the random set has upper density at least `α` along the windows. -/
theorem measure_le_sectionDensity_pos (lam : Measure X) (μ : Measure Ω) [IsProbabilityMeasure μ] {Xn : ℕ → Set X}
    {W : Set (X × Ω)} (hW : MeasurableSet W) (hXm : ∀ n, MeasurableSet (Xn n)) (hpos : ∀ n, lam (Xn n) ≠ 0)
    (hfin : ∀ n, lam (Xn n) ≠ ⊤) {α : ℝ≥0∞} (hcov : ∀ n, ∀ᵐ x ∂lam.restrict (Xn n), α ≤ μ {ω | (x, ω) ∈ W}) :
    0 < μ {ω | α ≤ sectionDensity lam Xn W ω} := by
  sorry

/-- Every event of full probability holds an `ω` at which the random set has upper density at least `α`. -/
theorem exists_mem_le_sectionDensity (lam : Measure X) (μ : Measure Ω) [IsProbabilityMeasure μ] {Xn : ℕ → Set X}
    {W : Set (X × Ω)} (hW : MeasurableSet W) (hXm : ∀ n, MeasurableSet (Xn n)) (hpos : ∀ n, lam (Xn n) ≠ 0)
    (hfin : ∀ n, lam (Xn n) ≠ ⊤) {α : ℝ≥0∞} (hcov : ∀ n, ∀ᵐ x ∂lam.restrict (Xn n), α ≤ μ {ω | (x, ω) ∈ W})
    {S : Set Ω} (hS : μ Sᶜ = 0) : ∃ ω ∈ S, α ≤ sectionDensity lam Xn W ω := by
  by_contra h
  have hsub : {ω | α ≤ sectionDensity lam Xn W ω} ⊆ Sᶜ := fun ω hω hωS => h ⟨ω, hωS, hω⟩
  exact (measure_le_sectionDensity_pos lam μ hW hXm hpos hfin hcov).ne' (measure_mono_null hsub hS)

/-- A function at most `1` is positive with probability at least its mean (the entry's "`1_{H > 0} ≥ H`"). -/
theorem ofReal_integral_le_measure_pos (μ : Measure Ω) [IsProbabilityMeasure μ] {h : Ω → ℝ} (hm : Measurable h)
    (h1 : ∀ ω, h ω ≤ 1) : ENNReal.ofReal (∫ ω, h ω ∂μ) ≤ μ {ω | 0 < h ω} := by
  sorry

/-- **C133-DENS-CLASS, as its entry states it** (no σ-finiteness and no lower bound on `H` are needed): for a
jointly measurable `H ≤ 1` whose mean is at least `α` at almost every point, and windows of finite positive measure,
the upper density `D` of the support `{H > 0}` is measurable, `∫ D dμ ≥ α`, `μ {D ≥ α} > 0`, and every event of full
measure holds an `ω` with `D ω ≥ α`. -/
theorem sectionDensity_setOf_pos (lam : Measure X) (μ : Measure Ω) [IsProbabilityMeasure μ] {H : X × Ω → ℝ}
    (hH : Measurable H) (h1 : ∀ p, H p ≤ 1) {α : ℝ} (hmean : ∀ᵐ x ∂lam, α ≤ ∫ ω, H (x, ω) ∂μ) {Xn : ℕ → Set X}
    (hXm : ∀ n, MeasurableSet (Xn n)) (hpos : ∀ n, lam (Xn n) ≠ 0) (hfin : ∀ n, lam (Xn n) ≠ ⊤) :
    Measurable (sectionDensity lam Xn {p | 0 < H p}) ∧
      ENNReal.ofReal α ≤ ∫⁻ ω, sectionDensity lam Xn {p | 0 < H p} ω ∂μ ∧
      0 < μ {ω | ENNReal.ofReal α ≤ sectionDensity lam Xn {p | 0 < H p} ω} ∧
      ∀ S : Set Ω, μ Sᶜ = 0 → ∃ ω ∈ S, ENNReal.ofReal α ≤ sectionDensity lam Xn {p | 0 < H p} ω := by
  have hW : MeasurableSet {p : X × Ω | 0 < H p} := measurableSet_lt measurable_const hH
  have hcov : ∀ n, ∀ᵐ x ∂lam.restrict (Xn n), ENNReal.ofReal α ≤ μ {ω | (x, ω) ∈ {p : X × Ω | 0 < H p}} := by
    intro n
    filter_upwards [ae_restrict_of_ae hmean] with x hx
    exact (ENNReal.ofReal_le_ofReal hx).trans
      (ofReal_integral_le_measure_pos μ (hH.comp measurable_prodMk_left) fun ω => h1 (x, ω))
  exact ⟨measurable_sectionDensity lam hW hXm hfin, le_lintegral_sectionDensity lam μ hW hXm hpos hfin hcov,
    measure_le_sectionDensity_pos lam μ hW hXm hpos hfin hcov,
    fun _ hS => exists_mem_le_sectionDensity lam μ hW hXm hpos hfin hcov hS⟩

end HadwigerNelson.Plane
