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

omit [MeasurableSpace Ω] in
/-- Drift check: the section of the whole space has density `1` along any windows of finite positive measure. -/
theorem sectionDensity_univ (lam : Measure X) {Xn : ℕ → Set X} (hpos : ∀ n, lam (Xn n) ≠ 0)
    (hfin : ∀ n, lam (Xn n) ≠ ⊤) (ω : Ω) : sectionDensity lam Xn (univ : Set (X × Ω)) ω = 1 := by
  have h : (fun n => lam (Xn n ∩ {x | (x, ω) ∈ (univ : Set (X × Ω))}) / lam (Xn n)) = fun _ => 1 := by
    funext n
    simp only [mem_univ, setOf_true, inter_univ]
    exact ENNReal.div_self (hpos n) (hfin n)
  unfold sectionDensity
  rw [h]
  exact limsup_const 1

omit [MeasurableSpace Ω] in
/-- Drift check: the empty set has density `0`. -/
theorem sectionDensity_empty (lam : Measure X) (Xn : ℕ → Set X) (ω : Ω) :
    sectionDensity lam Xn (∅ : Set (X × Ω)) ω = 0 := by
  have h : (fun n => lam (Xn n ∩ {x | (x, ω) ∈ (∅ : Set (X × Ω))}) / lam (Xn n)) = fun _ => 0 := by
    funext n
    simp only [mem_empty_iff_false, setOf_false, inter_empty, measure_empty, ENNReal.zero_div]
  unfold sectionDensity
  rw [h]
  exact limsup_const 0

omit [MeasurableSpace Ω] in
/-- The part of a window in the section at `ω`, as the restricted measure of the section. -/
private theorem measure_inter_section (lam : Measure X) {Xn : ℕ → Set X} (hXm : ∀ n, MeasurableSet (Xn n)) (n : ℕ)
    (W : Set (X × Ω)) (ω : Ω) :
    lam (Xn n ∩ {x | (x, ω) ∈ W}) = (lam.restrict (Xn n)) ((fun x => (x, ω)) ⁻¹' W) := by
  rw [Measure.restrict_apply' (hXm n), inter_comm]
  rfl

/-- Each window average is a measurable function of `ω`. -/
private theorem measurable_windowRatio (lam : Measure X) {Xn : ℕ → Set X} {W : Set (X × Ω)} (hW : MeasurableSet W)
    (hXm : ∀ n, MeasurableSet (Xn n)) (hfin : ∀ n, lam (Xn n) ≠ ⊤) (n : ℕ) :
    Measurable fun ω => lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n) := by
  haveI : IsFiniteMeasure (lam.restrict (Xn n)) :=
    ⟨by rw [Measure.restrict_apply_univ]; exact (hfin n).lt_top⟩
  have h := (measurable_measure_prodMk_right (μ := lam.restrict (Xn n)) hW).div_const (lam (Xn n))
  have he : (fun ω => lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n)) =
      fun ω => (lam.restrict (Xn n)) ((fun x => (x, ω)) ⁻¹' W) / lam (Xn n) := by
    funext ω
    rw [measure_inter_section lam hXm]
  rw [he]
  exact h

omit [MeasurableSpace Ω] in
/-- A window average is at most `1`. -/
private theorem windowRatio_le_one (lam : Measure X) (Xn : ℕ → Set X) (W : Set (X × Ω)) (n : ℕ) (ω : Ω) :
    lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n) ≤ 1 :=
  ENNReal.div_le_of_le_mul (by rw [one_mul]; exact measure_mono inter_subset_left)

/-- The density of the section is a measurable function of `ω` (Tonelli on each window, which has finite measure). -/
theorem measurable_sectionDensity (lam : Measure X) {Xn : ℕ → Set X} {W : Set (X × Ω)} (hW : MeasurableSet W)
    (hXm : ∀ n, MeasurableSet (Xn n)) (hfin : ∀ n, lam (Xn n) ≠ ⊤) : Measurable (sectionDensity lam Xn W) :=
  show Measurable fun ω => limsup (fun n => lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n)) atTop from
    Measurable.limsup fun n => measurable_windowRatio lam hW hXm hfin n

/-- **The reverse Fatou step.** If, in each window, almost every point is covered by the random set with probability
at least `α`, the mean upper density of the random set is at least `α`. -/
theorem le_lintegral_sectionDensity (lam : Measure X) (μ : Measure Ω) [IsProbabilityMeasure μ] {Xn : ℕ → Set X}
    {W : Set (X × Ω)} (hW : MeasurableSet W) (hXm : ∀ n, MeasurableSet (Xn n)) (hpos : ∀ n, lam (Xn n) ≠ 0)
    (hfin : ∀ n, lam (Xn n) ≠ ⊤) {α : ℝ≥0∞} (hcov : ∀ n, ∀ᵐ x ∂lam.restrict (Xn n), α ≤ μ {ω | (x, ω) ∈ W}) :
    α ≤ ∫⁻ ω, sectionDensity lam Xn W ω ∂μ := by
  -- every window average has mean at least `α` (Tonelli on the window)
  have hA : ∀ n, α ≤ ∫⁻ ω, lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n) ∂μ := by
    intro n
    haveI : IsFiniteMeasure (lam.restrict (Xn n)) :=
      ⟨by rw [Measure.restrict_apply_univ]; exact (hfin n).lt_top⟩
    have h1 : ∫⁻ ω, lam (Xn n ∩ {x | (x, ω) ∈ W}) ∂μ = ∫⁻ x, μ {ω | (x, ω) ∈ W} ∂lam.restrict (Xn n) :=
      (lintegral_congr fun ω => measure_inter_section lam hXm n W ω).trans
        ((Measure.prod_apply_symm (μ := lam.restrict (Xn n)) (ν := μ) hW).symm.trans (Measure.prod_apply hW))
    have h2 : α * lam (Xn n) ≤ ∫⁻ x, μ {ω | (x, ω) ∈ W} ∂lam.restrict (Xn n) :=
      calc α * lam (Xn n) = ∫⁻ _, α ∂lam.restrict (Xn n) := by
            rw [lintegral_const, Measure.restrict_apply_univ]
        _ ≤ ∫⁻ x, μ {ω | (x, ω) ∈ W} ∂lam.restrict (Xn n) := lintegral_mono_ae (hcov n)
    calc α = α * lam (Xn n) / lam (Xn n) := (ENNReal.mul_div_cancel_right (hpos n) (hfin n)).symm
      _ ≤ (∫⁻ ω, lam (Xn n ∩ {x | (x, ω) ∈ W}) ∂μ) / lam (Xn n) :=
          ENNReal.div_le_div_right (h2.trans_eq h1.symm) _
      _ = ∫⁻ ω, lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n) ∂μ := by
          simp only [div_eq_mul_inv]
          rw [lintegral_mul_const' _ _ (ENNReal.inv_ne_top.2 (hpos n))]
  -- the reverse Fatou lemma, the averages being at most `1`
  calc α = limsup (fun _ : ℕ => α) atTop := (limsup_const α).symm
    _ ≤ limsup (fun n => ∫⁻ ω, lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n) ∂μ) atTop :=
        limsup_le_limsup (Eventually.of_forall hA)
    _ ≤ ∫⁻ ω, limsup (fun n => lam (Xn n ∩ {x | (x, ω) ∈ W}) / lam (Xn n)) atTop ∂μ :=
        limsup_lintegral_le 1 (fun n => measurable_windowRatio lam hW hXm hfin n)
          (fun n => Eventually.of_forall fun ω => windowRatio_le_one lam Xn W n ω) (by simp)

/-- With positive probability the random set has upper density at least `α` along the windows. -/
theorem measure_le_sectionDensity_pos (lam : Measure X) (μ : Measure Ω) [IsProbabilityMeasure μ] {Xn : ℕ → Set X}
    {W : Set (X × Ω)} (hW : MeasurableSet W) (hXm : ∀ n, MeasurableSet (Xn n)) (hpos : ∀ n, lam (Xn n) ≠ 0)
    (hfin : ∀ n, lam (Xn n) ≠ ⊤) {α : ℝ≥0∞} (hcov : ∀ n, ∀ᵐ x ∂lam.restrict (Xn n), α ≤ μ {ω | (x, ω) ∈ W}) :
    0 < μ {ω | α ≤ sectionDensity lam Xn W ω} := by
  by_contra h0
  have hnull : μ {ω | α ≤ sectionDensity lam Xn W ω} = 0 := nonpos_iff_eq_zero.1 (not_lt.1 h0)
  have hlt : ∀ᵐ ω ∂μ, sectionDensity lam Xn W ω < α := by
    filter_upwards [measure_eq_zero_iff_ae_notMem.1 hnull] with ω hω
    exact not_le.1 hω
  have hD1 : ∀ ω, sectionDensity lam Xn W ω ≤ 1 := fun ω =>
    limsup_le_of_le (h := Eventually.of_forall fun n => windowRatio_le_one lam Xn W n ω)
  have hfin' : ∫⁻ ω, sectionDensity lam Xn W ω ∂μ ≠ ⊤ :=
    ((lintegral_mono hD1).trans_lt (by simp)).ne
  have hstrict := lintegral_strict_mono (IsProbabilityMeasure.ne_zero μ) aemeasurable_const hfin' hlt
  rw [lintegral_const, measure_univ, mul_one] at hstrict
  exact absurd (le_lintegral_sectionDensity lam μ hW hXm hpos hfin hcov) (not_le.2 hstrict)

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
  by_cases hi : Integrable h μ
  · have hS : MeasurableSet {ω | 0 < h ω} := measurableSet_lt measurable_const hm
    have h2 : ∫ ω, h ω ∂μ ≤ (∫⁻ ω, ENNReal.ofReal (h ω) ∂μ).toReal := by
      rw [integral_eq_lintegral_pos_part_sub_lintegral_neg_part hi]
      exact sub_le_self _ ENNReal.toReal_nonneg
    have h3 : ∫⁻ ω, ENNReal.ofReal (h ω) ∂μ ≤ μ {ω | 0 < h ω} := by
      rw [← lintegral_indicator_one hS]
      refine lintegral_mono fun ω => ?_
      by_cases hω : 0 < h ω
      · rw [indicator_of_mem (show ω ∈ {ω | 0 < h ω} from hω)]
        exact ENNReal.ofReal_le_one.2 (h1 ω)
      · rw [indicator_of_notMem (show ω ∉ {ω | 0 < h ω} from hω), ENNReal.ofReal_of_nonpos (not_lt.1 hω)]
    calc ENNReal.ofReal (∫ ω, h ω ∂μ) ≤ ENNReal.ofReal ((∫⁻ ω, ENNReal.ofReal (h ω) ∂μ).toReal) :=
          ENNReal.ofReal_le_ofReal h2
      _ ≤ ∫⁻ ω, ENNReal.ofReal (h ω) ∂μ := ENNReal.ofReal_toReal_le
      _ ≤ μ {ω | 0 < h ω} := h3
  · rw [integral_undef hi, ENNReal.ofReal_zero]
    exact zero_le

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
