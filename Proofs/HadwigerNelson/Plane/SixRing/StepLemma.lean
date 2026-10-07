import Proofs.HadwigerNelson.Plane.SixRing.Basic
import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# The step lemma (FS-132, C132-M-ORBIT step M8, Lemma S) and two facts about change points

Real analysis on the line: no colouring, no chart, no palette. A measurable set `S ⊆ ℝ` (the angles whose palette
holds one of the two outside labels) and a shift `ε` with `ShiftBounds ε κ`.

* `step_lemma` — the derivation's **Lemma S**: if for almost every `(α, d, d')` the pairs `(α − d, α)` and
  `(α + ε, α + ε + d')` are not both split by `S` (`NoDoubleChange`), then on the interval of radius `κ/4` the set
  `S` is, up to a null set, a half-line: "a function with at most one jump".
* its five children, in the order of the proof — `exists_step_or_density_triple`, `exists_window`,
  `exists_shiftMap`, `exists_density_pair`, `volume_pattern_pos`. **The children are the planner's decomposition;
  `step_lemma`'s statement is the interface.** An implementer who needs a child in another form restates the child
  and says so in its report; `step_lemma` itself is not restated without the planner.
* `step_at_of_change` — the jump is at a point every neighbourhood of which meets both `S` and its complement in
  positive measure; `volume_change_pairs_pos` — at such a point the pairs split by `S` have positive measure at
  every scale (the derivation's step M3, first sentence).

**Route note.** The derivation proves Lemma S by fixing the outer pair `(u, w)` in a neighbourhood and integrating
(Fubini over `(u, w)`). Here the outer pair is fixed at two density points *exactly*, a middle point `v₀` is chosen
with `v₀` and `g(v₀)` both density points (`exists_density_pair`), and positivity of the forbidden pattern near
that base point is a translation-and-Lipschitz estimate (`volume_pattern_pos`): no change of variables in three
dimensions, and the implicit map `g` is needed at one pair only. The window is found on a dyadic scale
(`exists_window`), which needs no continuity of the proportion in the radius. `plans/FS132-kernel-plan.md` stage 5.

**What is used of the shift.** `ShiftBounds ε κ` only: positivity, the two bounds by a sixteenth, and the two
Lipschitz bounds. No measurability of `ε` is assumed or used: the set of `volume_pattern_pos` need not be
measurable, and its positive (outer) measure is read off sections at fixed `(d, d')`, each of which is a measurable
set of angles. The density theorem is Mathlib's (`Besicovitch.ae_tendsto_measure_inter_div_of_measurableSet`); the
measure of an image under an expanding map is the one-dimensional Hausdorff measure's
(`AntilipschitzWith.le_hausdorffMeasure_image`). Every leaf is proved (`plans/FS132-I3-implementation.md`).
-/

open MeasureTheory Filter Topology Set

namespace HadwigerNelson.SixRing

/-- A (two-sided, Lebesgue) density point of a set `E ⊆ ℝ`: the proportion of `E` in `[x − r, x + r]` tends to `1`
as `r → 0⁺`. The form of `Besicovitch.ae_tendsto_measure_inter_div_of_measurableSet`. -/
def IsDensityPt (E : Set ℝ) (x : ℝ) : Prop :=
  Tendsto (fun r => volume (E ∩ Metric.closedBall x r) / volume (Metric.closedBall x r)) (𝓝[>] 0) (𝓝 1)

/-- Every point is a density point of the whole line (drift check and model of `IsDensityPt`). -/
example (x : ℝ) : IsDensityPt Set.univ x := by
  refine tendsto_const_nhds.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr
  rw [Set.univ_inter, ENNReal.div_self]
  · rw [Real.volume_closedBall]; simpa using hr
  · rw [Real.volume_closedBall]; exact ENNReal.ofReal_ne_top

/-! ## Density points: the tools -/

/-- Lebesgue's density theorem in Besicovitch's form: almost every point of a measurable set is a density point of
it. -/
theorem ae_mem_imp_isDensityPt {E : Set ℝ} (hE : MeasurableSet E) : ∀ᵐ x : ℝ, x ∈ E → IsDensityPt E x := by
  filter_upwards [Besicovitch.ae_tendsto_measure_inter_div_of_measurableSet volume hE] with x hx hxE
  simpa [IsDensityPt, Set.indicator_of_mem hxE] using hx

/-- A density point of a set is a density point of every larger set. -/
theorem IsDensityPt.mono {E E' : Set ℝ} {x : ℝ} (h : IsDensityPt E x) (hEE' : E ⊆ E') : IsDensityPt E' x := by
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' h tendsto_const_nhds ?_ ?_
  · exact Eventually.of_forall fun r =>
      ENNReal.div_le_div_right (measure_mono (inter_subset_inter_left _ hEE')) _
  · exact Eventually.of_forall fun r =>
      ENNReal.div_le_of_le_mul (by rw [one_mul]; exact measure_mono inter_subset_right)

/-- A point in the interior of a set is a density point of it (the models of this file's hypotheses use it). -/
theorem isDensityPt_of_mem_nhds {E : Set ℝ} {x : ℝ} (h : E ∈ 𝓝 x) : IsDensityPt E x := by
  obtain ⟨δ, hδ, hsub⟩ := Metric.mem_nhds_iff.mp h
  refine tendsto_const_nhds.congr' ?_
  filter_upwards [Ioo_mem_nhdsGT hδ] with r hr
  have hE : E ∩ Metric.closedBall x r = Metric.closedBall x r :=
    inter_eq_right.mpr ((Metric.closedBall_subset_ball hr.2).trans hsub)
  rw [hE, ENNReal.div_self]
  · rw [Real.volume_closedBall]
    simpa using hr.1
  · rw [Real.volume_closedBall]
    exact ENNReal.ofReal_ne_top

/-- At a density point the set fills more than any proportion `c < 1` of every small closed ball, in real numbers. -/
theorem IsDensityPt.eventually_lt {E : Set ℝ} {x : ℝ} (h : IsDensityPt E x) {c : ℝ} (hc : c < 1) :
    ∀ᶠ r in 𝓝[>] 0, c * (2 * r) < volume.real (E ∩ Metric.closedBall x r) := by
  have h1 : ENNReal.ofReal (max c 0) < 1 := by
    rw [← ENNReal.ofReal_one]
    exact (ENNReal.ofReal_lt_ofReal_iff one_pos).mpr (max_lt hc one_pos)
  filter_upwards [h.eventually (lt_mem_nhds h1), self_mem_nhdsWithin] with r hr hr0
  have hr0' : (0 : ℝ) < r := hr0
  have hfin : volume (E ∩ Metric.closedBall x r) ≠ ⊤ :=
    ((measure_mono inter_subset_right).trans_lt (by rw [Real.volume_closedBall]; exact ENNReal.ofReal_lt_top)).ne
  rw [Real.volume_closedBall, ENNReal.lt_div_iff_mul_lt (Or.inl (by simpa using hr0')) (Or.inl ENNReal.ofReal_ne_top),
    ← ENNReal.ofReal_mul (le_max_right _ _)] at hr
  have h2 := (ENNReal.ofReal_lt_iff_lt_toReal (by positivity) hfin).mp hr
  calc c * (2 * r) ≤ max c 0 * (2 * r) := by gcongr; exact le_max_left _ _
    _ < _ := h2

/-- At a density point of a measurable set the complement fills at most any proportion `δ > 0` of every small
closed ball. -/
theorem IsDensityPt.eventually_compl_le {E : Set ℝ} (hE : MeasurableSet E) {x : ℝ} (h : IsDensityPt E x) {δ : ℝ}
    (hδ : 0 < δ) : ∀ᶠ r in 𝓝[>] 0, volume (Metric.closedBall x r \ E) ≤ ENNReal.ofReal (δ * r) := by
  filter_upwards [h.eventually_lt (show 1 - δ / 2 < 1 by linarith), self_mem_nhdsWithin] with r hr hr0
  have hr0' : (0 : ℝ) < r := hr0
  have hB : volume (Metric.closedBall x r) ≠ ⊤ := by rw [Real.volume_closedBall]; exact ENNReal.ofReal_ne_top
  have hsum := measureReal_inter_add_sdiff (μ := volume) (s := Metric.closedBall x r) hE hB
  rw [Real.volume_real_closedBall hr0'.le, inter_comm] at hsum
  have hfin : volume (Metric.closedBall x r \ E) ≠ ⊤ := ((measure_mono sdiff_subset).trans_lt hB.lt_top).ne
  rw [← ENNReal.ofReal_toReal hfin]
  refine ENNReal.ofReal_le_ofReal ?_
  have : (1 - δ / 2) * (2 * r) = 2 * r - δ * r := by ring
  have h3 : (volume (Metric.closedBall x r \ E)).toReal = volume.real (Metric.closedBall x r \ E) := rfl
  linarith

/-- The same on open intervals: at a density point the set fills more than any proportion `c < 1` of every small
open interval about the point. -/
theorem IsDensityPt.eventually_lt_Ioo {E : Set ℝ} {x : ℝ} (h : IsDensityPt E x) {c : ℝ} (hc : c < 1) :
    ∀ᶠ r in 𝓝[>] 0, c * (2 * r) < volume.real (E ∩ Ioo (x - r) (x + r)) := by
  filter_upwards [h.eventually_lt hc] with r hr
  rwa [Real.closedBall_eq_Icc, measureReal_congr (ae_eq_set_inter (ae_eq_refl E) Ioo_ae_eq_Icc.symm)] at hr

/-- A point is not a density point of a measurable set and of its complement. -/
theorem IsDensityPt.not_compl {S : Set ℝ} (hS : MeasurableSet S) {x : ℝ} (h : IsDensityPt S x) :
    ¬ IsDensityPt Sᶜ x := by
  intro h'
  obtain ⟨r, hr1, hr2, hr0⟩ := ((h.eventually_lt (c := 1 / 2) (by norm_num)).and
    ((h'.eventually_lt (c := 1 / 2) (by norm_num)).and self_mem_nhdsWithin)).exists
  have hr0' : (0 : ℝ) < r := hr0
  have hB : volume (Metric.closedBall x r) ≠ ⊤ := by rw [Real.volume_closedBall]; exact ENNReal.ofReal_ne_top
  have hsum := measureReal_inter_add_sdiff (μ := volume) (s := Metric.closedBall x r) hS hB
  rw [Real.volume_real_closedBall hr0'.le] at hsum
  rw [inter_comm] at hr1
  rw [inter_comm, ← sdiff_eq] at hr2
  linarith

/-- **Lemma S, first step** ("Suppose the conclusion fails. Then there are Lebesgue density points `a_* < b < c_*` …
of the level sets of `s` with `s(a_*) = s(c_*) ≠ s(b)`"): on an open interval a measurable set is, up to a null
set, an initial or a final segment, or there are three density points in the interval, the outer two of one of `S`,
`Sᶜ` and the middle one of the other. -/
theorem exists_step_or_density_triple {S : Set ℝ} (hS : MeasurableSet S) (l r : ℝ) :
    (∃ t' : ℝ, (∀ᵐ θ : ℝ, θ ∈ Ioo l r → (θ ∈ S ↔ θ < t')) ∨ (∀ᵐ θ : ℝ, θ ∈ Ioo l r → (θ ∈ S ↔ t' < θ))) ∨
    ∃ a b c : ℝ, l < a ∧ a < b ∧ b < c ∧ c < r ∧
      ((IsDensityPt S a ∧ IsDensityPt Sᶜ b ∧ IsDensityPt S c) ∨
        (IsDensityPt Sᶜ a ∧ IsDensityPt S b ∧ IsDensityPt Sᶜ c)) := by
  by_cases hT : ∃ a b c : ℝ, l < a ∧ a < b ∧ b < c ∧ c < r ∧
      ((IsDensityPt S a ∧ IsDensityPt Sᶜ b ∧ IsDensityPt S c) ∨
        (IsDensityPt Sᶜ a ∧ IsDensityPt S b ∧ IsDensityPt Sᶜ c))
  · exact Or.inr hT
  left
  -- the density points of `S` and of `Sᶜ` in the interval
  set A : Set ℝ := {x | x ∈ Ioo l r ∧ IsDensityPt S x} with hA
  set B : Set ℝ := {x | x ∈ Ioo l r ∧ IsDensityPt Sᶜ x} with hB
  have hae : ∀ᵐ θ : ℝ, θ ∈ Ioo l r → ((θ ∈ S → θ ∈ A) ∧ (θ ∉ S → θ ∈ B)) := by
    filter_upwards [ae_mem_imp_isDensityPt hS, ae_mem_imp_isDensityPt hS.compl] with θ h1 h2 hθ
    exact ⟨fun h => ⟨hθ, h1 h⟩, fun h => ⟨hθ, h2 h⟩⟩
  -- two sets of the interval, one wholly before the other, are separated by a point
  have key : ∀ A B : Set ℝ, A ⊆ Ioo l r → B ⊆ Ioo l r → (∀ a ∈ A, ∀ b ∈ B, a ≤ b) →
      ∃ t' : ℝ, (∀ a ∈ A, a ≤ t') ∧ ∀ b ∈ B, t' ≤ b := by
    intro A B hAI hBI hAB
    have hbdd : BddAbove (insert l A) := bddAbove_insert.mpr ⟨r, fun a ha => (hAI ha).2.le⟩
    refine ⟨sSup (insert l A), fun a ha => le_csSup hbdd (mem_insert_of_mem _ ha), fun b hb => ?_⟩
    refine csSup_le (insert_nonempty _ _) ?_
    rintro x (rfl | hx)
    · exact (hBI hb).1.le
    · exact hAB x hx b hb
  have hne : ∀ t' : ℝ, ∀ᵐ θ : ℝ, θ ≠ t' := fun t' => by
    simpa using (Set.countable_singleton t').ae_notMem (volume : Measure ℝ)
  by_cases h1 : ∀ a ∈ A, ∀ b ∈ B, a ≤ b
  · obtain ⟨t', hAt, hBt⟩ := key A B (fun x hx => hx.1) (fun x hx => hx.1) h1
    refine ⟨t', Or.inl ?_⟩
    filter_upwards [hae, hne t'] with θ hθ hθne hI
    refine ⟨fun hθS => lt_of_le_of_ne (hAt _ ((hθ hI).1 hθS)) hθne, fun hlt => ?_⟩
    by_contra hθS
    exact absurd (hBt _ ((hθ hI).2 hθS)) (not_le.mpr hlt)
  · by_cases h2 : ∀ a ∈ A, ∀ b ∈ B, b ≤ a
    · obtain ⟨t', hBt, hAt⟩ := key B A (fun x hx => hx.1) (fun x hx => hx.1) fun b hb a ha => h2 a ha b hb
      refine ⟨t', Or.inr ?_⟩
      filter_upwards [hae, hne t'] with θ hθ hθne hI
      refine ⟨fun hθS => lt_of_le_of_ne (hAt _ ((hθ hI).1 hθS)) (Ne.symm hθne), fun hlt => ?_⟩
      by_contra hθS
      exact absurd (hBt _ ((hθ hI).2 hθS)) (not_le.mpr hlt)
    · exfalso
      push Not at h1 h2
      obtain ⟨a₁, ha₁, b₁, hb₁, h1⟩ := h1
      obtain ⟨a₂, ha₂, b₂, hb₂, h2⟩ := h2
      rcases lt_trichotomy a₁ b₂ with h | h | h
      · exact hT ⟨b₁, a₁, b₂, hb₁.1.1, h1, h, hb₂.1.2, Or.inr ⟨hb₁.2, ha₁.2, hb₂.2⟩⟩
      · exact (ha₁.2.not_compl hS) (h ▸ hb₂.2)
      · exact hT ⟨a₂, b₂, a₁, ha₂.1.1, h2, h, ha₁.1.2, Or.inl ⟨ha₂.2, hb₂.2, ha₁.2⟩⟩

/-- **Lemma S, the window** ("In every case `u_0 < w_0` are density points of `{s = X}`, `I = (b − ρ, b + ρ) ⊂
(u_0, w_0)`, `{s = Y}` fills at least `3/4` of `I`, and one of `u_0`, `w_0` is within `3ρ` of every point of `I`"),
with `E` the middle value's set and `7/8` in place of `3/4`: between density points `a < c` of `Eᶜ` and about a
density point `b` of `E` there are a radius `ρ`, and density points `u ≤ b − ρ` and `b + ρ ≤ w` of `Eᶜ`, one of
them within `2ρ` of `b`, with `E` filling at least `7/8` of `(b − ρ, b + ρ)`. -/
theorem exists_window {E : Set ℝ} (hE : MeasurableSet E) {a b c : ℝ} (hab : a < b) (hbc : b < c)
    (ha : IsDensityPt Eᶜ a) (hb : IsDensityPt E b) (hc : IsDensityPt Eᶜ c) :
    ∃ u w ρ : ℝ, 0 < ρ ∧ a ≤ u ∧ u ≤ b - ρ ∧ b + ρ ≤ w ∧ w ≤ c ∧ IsDensityPt Eᶜ u ∧ IsDensityPt Eᶜ w ∧
      (b - u ≤ 2 * ρ ∨ w - b ≤ 2 * ρ) ∧ ENNReal.ofReal (7 / 4 * ρ) ≤ volume (E ∩ Ioo (b - ρ) (b + ρ)) := by
  have hR0 : 0 < min (b - a) (c - b) := lt_min (by linarith) (by linarith)
  set R : ℝ := min (b - a) (c - b) with hR
  have hRa : R ≤ b - a := min_le_left _ _
  have hRc : R ≤ c - b := min_le_right _ _
  have hfin : ∀ x y : ℝ, volume (Ioo x y) ≠ ⊤ := fun x y => by rw [Real.volume_Ioo]; exact ENNReal.ofReal_ne_top
  -- at some dyadic radius `R / 2 ^ (n + 1)` the set `E` fills `7/8` of the interval about `b`
  have hex : ∃ n : ℕ, 7 / 4 * (R / 2 ^ (n + 1)) ≤
      volume.real (E ∩ Ioo (b - R / 2 ^ (n + 1)) (b + R / 2 ^ (n + 1))) := by
    obtain ⟨R₀, hR₀, hsub⟩ :=
      mem_nhdsGT_iff_exists_Ioo_subset.mp (hb.eventually_lt_Ioo (c := 7 / 8) (by norm_num))
    have hR₀' : (0 : ℝ) < R₀ := hR₀
    obtain ⟨n, hn⟩ := exists_pow_lt_of_lt_one (div_pos hR₀' hR0) (by norm_num : (1 / 2 : ℝ) < 1)
    refine ⟨n, ?_⟩
    have hpos : 0 < R / 2 ^ (n + 1) := by positivity
    have hlt : R / 2 ^ (n + 1) < R₀ := by
      have h1 : R / 2 ^ (n + 1) = R * (1 / 2) ^ n / 2 := by
        rw [pow_succ, one_div_pow]
        field_simp
      have h2 : R * (1 / 2) ^ n < R * (R₀ / R) := mul_lt_mul_of_pos_left hn hR0
      have h3 : R * (R₀ / R) = R₀ := by field_simp
      have h4 : (0 : ℝ) < R * (1 / 2) ^ n := by positivity
      linarith
    have := hsub ⟨hpos, hlt⟩
    simp only [mem_setOf_eq] at this
    linarith
  classical
  obtain ⟨n, hn, hmin⟩ : ∃ n : ℕ, 7 / 4 * (R / 2 ^ (n + 1)) ≤
      volume.real (E ∩ Ioo (b - R / 2 ^ (n + 1)) (b + R / 2 ^ (n + 1))) ∧
      ∀ m < n, ¬ 7 / 4 * (R / 2 ^ (m + 1)) ≤
        volume.real (E ∩ Ioo (b - R / 2 ^ (m + 1)) (b + R / 2 ^ (m + 1))) :=
    ⟨Nat.find hex, Nat.find_spec hex, fun m hm => Nat.find_min hex hm⟩
  have hρ0 : 0 < R / 2 ^ (n + 1) := by positivity
  have hρR : 2 * (R / 2 ^ (n + 1)) ≤ R := by
    have h1 : 2 * (R / 2 ^ (n + 1)) = R / 2 ^ n := by
      rw [pow_succ]
      field_simp
    rw [h1]
    exact div_le_self hR0.le (one_le_pow₀ (by norm_num))
  have hfill : ENNReal.ofReal (7 / 4 * (R / 2 ^ (n + 1))) ≤
      volume (E ∩ Ioo (b - R / 2 ^ (n + 1)) (b + R / 2 ^ (n + 1))) := ENNReal.ofReal_le_of_le_toReal hn
  rcases n with _ | k
  · -- the first radius, `R / 2`: the outer pair is `(a, c)`
    refine ⟨a, c, R / 2 ^ (0 + 1), hρ0, le_rfl, by linarith, by linarith, le_rfl, ha, hc, ?_, hfill⟩
    have h1 : 2 * (R / 2 ^ (0 + 1)) = R := by norm_num; ring
    rw [h1]
    rcases min_choice (b - a) (c - b) with h | h
    · exact Or.inl (by rw [hR, h])
    · exact Or.inr (by rw [hR, h])
  · -- a later radius `ρ`: at radius `2ρ` the set `E` fills less than `7/8`, so `Eᶜ` has a density point with
    -- `ρ ≤ |x − b| < 2ρ`
    have hk := hmin k (Nat.lt_succ_self k)
    set ρ : ℝ := R / 2 ^ (k + 1 + 1) with hρ
    have h2ρ : R / 2 ^ (k + 1) = 2 * ρ := by
      rw [hρ, pow_succ 2 (k + 1)]
      field_simp
    rw [h2ρ] at hk
    have s2 := measureReal_inter_add_sdiff (μ := volume) (s := Ioo (b - 2 * ρ) (b + 2 * ρ)) hE (hfin _ _)
    have s1 := measureReal_inter_add_sdiff (μ := volume) (s := Ioo (b - ρ) (b + ρ)) hE (hfin _ _)
    rw [Real.volume_real_Ioo_of_le (by linarith), inter_comm] at s1 s2
    have hcover : Ioo (b - 2 * ρ) (b + 2 * ρ) \ E ⊆
        (Ioo (b - ρ) (b + ρ) \ E) ∪ (Eᶜ ∩ (Ioo (b - 2 * ρ) (b + 2 * ρ) \ Ioo (b - ρ) (b + ρ))) := by
      rintro x ⟨hx2, hxE⟩
      by_cases hx1 : x ∈ Ioo (b - ρ) (b + ρ)
      · exact Or.inl ⟨hx1, hxE⟩
      · exact Or.inr ⟨hxE, hx2, hx1⟩
    have hAfin : volume (Eᶜ ∩ (Ioo (b - 2 * ρ) (b + 2 * ρ) \ Ioo (b - ρ) (b + ρ))) ≠ ⊤ :=
      ((measure_mono (inter_subset_right.trans sdiff_subset)).trans_lt (hfin _ _).lt_top).ne
    have hle := (measureReal_mono hcover (by
      exact ((measure_union_le _ _).trans_lt (ENNReal.add_lt_top.mpr
        ⟨(measure_mono sdiff_subset).trans_lt (hfin _ _).lt_top, hAfin.lt_top⟩)).ne)).trans
      (measureReal_union_le _ _)
    have hpos : 0 < volume.real (Eᶜ ∩ (Ioo (b - 2 * ρ) (b + 2 * ρ) \ Ioo (b - ρ) (b + ρ))) := by linarith
    have hne : volume (Eᶜ ∩ (Ioo (b - 2 * ρ) (b + 2 * ρ) \ Ioo (b - ρ) (b + ρ))) ≠ 0 := fun h0 => by
      rw [Measure.real, h0] at hpos
      simp at hpos
    obtain ⟨x, hx, hdx⟩ := Measure.exists_mem_of_measure_ne_zero_of_ae hne
      (ae_restrict_of_ae (ae_mem_imp_isDensityPt hE.compl))
    have hxd : IsDensityPt Eᶜ x := hdx hx.1
    obtain ⟨-, hx2, hx1⟩ := hx
    by_cases hxl : x ≤ b - ρ
    · exact ⟨x, c, ρ, hρ0, by linarith [hx2.1], hxl, by linarith, le_rfl, hxd, hc,
        Or.inl (by linarith [hx2.1]), hfill⟩
    · have hxr : b + ρ ≤ x := by
        by_contra hlt
        exact hx1 ⟨not_le.mp hxl, not_le.mp hlt⟩
      exact ⟨a, x, ρ, hρ0, le_rfl, by linarith, hxr, by linarith [hx2.2], ha, hxd,
        Or.inr (by linarith [hx2.2]), hfill⟩

/-- **Model of the hypotheses of `exists_window`**: `E = (−1, 1)` between `a = −2` and `c = 2`, about `b = 0`. -/
example := exists_window (E := Ioo (-1 : ℝ) 1) (a := -2) (b := 0) (c := 2) measurableSet_Ioo (by norm_num)
  (by norm_num)
  (isDensityPt_of_mem_nhds (mem_of_superset (Iio_mem_nhds (by norm_num : (-2 : ℝ) < -1))
    fun x hx h => by linarith [show x < -1 from hx, h.1]))
  (isDensityPt_of_mem_nhds (Ioo_mem_nhds (by norm_num) (by norm_num)))
  (isDensityPt_of_mem_nhds (mem_of_superset (Ioi_mem_nhds (by norm_num : (1 : ℝ) < 2))
    fun x hx h => by linarith [show 1 < x from hx, h.2]))

/-- **Lemma S, the map `g_{u,w}`** ("`g_{u,w}(v) = v + ε`, an increasing … map with `g′ ≥ 7/8` … and
`0 < g(v) − v ≤ min(v − u, w − v)/16`"), at one pair `u`, `w` with `w − u < κ` (nothing is said when `w ≤ u`: the
interval is then empty): there is `g` on `(u, w)` with
`v < g v < w` and `g v = v + ε (v − u) (w − g v)` — so that `(u, v, g v, w)` are the four angles of a unit pair with
`d = v − u` and `d' = w − g v` — and with slopes between `7/8` and `9/8`. (The bounds `g v − v ≤ (v − u)/16` and
`g v − v ≤ (w − g v)/16` are then `ShiftBounds.le_left`, `.le_right`.) -/
theorem exists_shiftMap {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hε : ShiftBounds ε κ) {u w : ℝ} (hκ : w - u < κ) :
    ∃ g : ℝ → ℝ, (∀ v ∈ Ioo u w, v < g v ∧ g v < w ∧ g v = v + ε (v - u) (w - g v)) ∧
      ∀ v₁ ∈ Ioo u w, ∀ v₂ ∈ Ioo u w, v₁ ≤ v₂ →
        7 / 8 * (v₂ - v₁) ≤ g v₂ - g v₁ ∧ g v₂ - g v₁ ≤ 9 / 8 * (v₂ - v₁) := by
  have hex : ∀ v ∈ Ioo u w, ∃ y : ℝ, v < y ∧ y < w ∧ y = v + ε (v - u) (w - y) := by
    rintro v ⟨hv1, hv2⟩
    have hd0 : 0 < v - u := by linarith
    have hdκ : v - u < κ := by linarith
    have hL0 : 0 < w - v := by linarith
    have hLκ : w - v < κ := by linarith
    -- `D ↦ D + ε (v − u) D` is continuous on `[(w − v)/2, w − v]`, at most `w − v` at the left end and above it
    -- at the right end
    have hcont : ContinuousOn (fun D : ℝ => D + ε (v - u) D) (Icc ((w - v) / 2) (w - v)) := by
      refine continuousOn_id.add ?_
      have hL : LipschitzOnWith (1 / 32 : NNReal) (fun D : ℝ => ε (v - u) D) (Icc ((w - v) / 2) (w - v)) := by
        refine LipschitzOnWith.of_dist_le_mul fun D₁ h₁ D₂ h₂ => ?_
        rw [Real.dist_eq, Real.dist_eq]
        have := hε.lip_right (v - u) D₁ D₂ hd0 hdκ (by linarith [h₁.1]) (by linarith [h₁.2])
          (by linarith [h₂.1]) (by linarith [h₂.2])
        have h32 : (((1 / 32 : NNReal) : ℝ)) = 1 / 32 := by norm_num
        rw [h32]
        linarith
      exact hL.continuousOn
    have hlo : (w - v) / 2 + ε (v - u) ((w - v) / 2) ≤ w - v := by
      have := hε.le_right (v - u) ((w - v) / 2) hd0 hdκ (by linarith) (by linarith)
      linarith
    have hhi : w - v ≤ w - v + ε (v - u) (w - v) := by
      have := hε.pos (v - u) (w - v) hd0 hdκ hL0 hLκ
      linarith
    obtain ⟨D, hD, hDeq⟩ := intermediate_value_Icc (by linarith : (w - v) / 2 ≤ w - v) hcont ⟨hlo, hhi⟩
    have hDeq' : D + ε (v - u) D = w - v := hDeq
    have hDpos : 0 < ε (v - u) D := hε.pos (v - u) D hd0 hdκ (by linarith [hD.1]) (by linarith [hD.2])
    refine ⟨w - D, by linarith, by linarith [hD.1], ?_⟩
    rw [sub_sub_cancel]
    linarith
  choose! g hg using hex
  refine ⟨g, hg, fun v₁ h₁ v₂ h₂ h12 => ?_⟩
  obtain ⟨a1, b1, c1⟩ := hg v₁ h₁
  obtain ⟨a2, b2, c2⟩ := hg v₂ h₂
  have e1 := hε.lip_left (v₁ - u) (v₂ - u) (w - g v₁) (by linarith [h₁.1]) (by linarith [h₁.2])
    (by linarith [h₂.1]) (by linarith [h₂.2]) (by linarith) (by linarith [h₁.1])
  have e2 := hε.lip_right (v₂ - u) (w - g v₁) (w - g v₂) (by linarith [h₂.1]) (by linarith [h₂.2])
    (by linarith) (by linarith [h₁.1]) (by linarith) (by linarith [h₂.1])
  have hδ : |v₁ - u - (v₂ - u)| = v₂ - v₁ := by
    rw [show v₁ - u - (v₂ - u) = -(v₂ - v₁) by ring, abs_neg, abs_of_nonneg (by linarith)]
  have hx : w - g v₁ - (w - g v₂) = g v₂ - g v₁ := by ring
  rw [hδ] at e1
  rw [hx] at e2
  rw [abs_le] at e1
  rcases le_total 0 (g v₂ - g v₁) with hpos | hneg
  · rw [abs_of_nonneg hpos, abs_le] at e2
    constructor <;> linarith [e1.1, e1.2, e2.1, e2.2]
  · rw [abs_of_nonpos hneg, abs_le] at e2
    constructor <;> linarith [e1.1, e1.2, e2.1, e2.2]

/-- **Model of the hypotheses of `exists_shiftMap`**: the product shift `d d' / 16` (`shiftBounds_model`) on the
pair `(0, 1/4)`. -/
example := exists_shiftMap shiftBounds_model (u := 0) (w := 1 / 4) (by norm_num)

/-- **A map that shrinks no distance on a set by more than a factor `K` shrinks its outer measure by at most `K`**:
if `dist x y ≤ K · dist (g x) (g y)` on `F` then `vol F ≤ K · vol (g '' F)`. No measurability of `F`, of `g` or of
the image. (Lebesgue measure on the line is one-dimensional Hausdorff measure, which an antilipschitz map
shrinks by at most its constant.) -/
theorem volume_le_mul_volume_image {F : Set ℝ} {g : ℝ → ℝ} {K : NNReal}
    (h : ∀ x ∈ F, ∀ y ∈ F, dist x y ≤ K * dist (g x) (g y)) : volume F ≤ K * volume (g '' F) := by
  have hanti : AntilipschitzWith K (F.restrict g) := AntilipschitzWith.of_le_mul_dist fun x y => h x x.2 y y.2
  have h1 := hanti.le_hausdorffMeasure_image (d := 1) zero_le_one univ
  have h2 : μH[1] (univ : Set F) = μH[1] F := by
    rw [← (isometry_subtype_coe (s := F)).hausdorffMeasure_image (Or.inl zero_le_one) univ, image_univ,
      Subtype.range_coe]
  rw [image_univ, range_restrict, h2, ENNReal.rpow_one] at h1
  rwa [hausdorffMeasure_real] at h1

/-- **Lemma S, the overlap** ("`{s = Y} ∩ I` has measure at least `(3/2)ρ`, its image under `g` at least
`(21/16)ρ`, and both lie in an interval of length `(9/4)ρ`; so they overlap"), with the constants of `exists_window`
(`7/4`, `49/32`, `35/16`), and the base point it yields: a set `F` filling `7/8` of an interval of radius `ρ`, moved
by a map `g` with slopes in `[7/8, 9/8]` and `0 < g − id ≤ 3ρ/16`, contains a point `v` with `g v ∈ F` such that
`v` and `g v` are both density points of `F`. -/
theorem exists_density_pair {F : Set ℝ} (hF : MeasurableSet F) {b ρ : ℝ} (hρ : 0 < ρ)
    (hFI : F ⊆ Ioo (b - ρ) (b + ρ)) (hFm : ENNReal.ofReal (7 / 4 * ρ) ≤ volume F) {g : ℝ → ℝ}
    (hg : ∀ v ∈ F, v < g v ∧ g v ≤ v + 3 / 16 * ρ)
    (hlip : ∀ v₁ ∈ F, ∀ v₂ ∈ F, v₁ ≤ v₂ →
      7 / 8 * (v₂ - v₁) ≤ g v₂ - g v₁ ∧ g v₂ - g v₁ ≤ 9 / 8 * (v₂ - v₁)) :
    ∃ v ∈ F, g v ∈ F ∧ IsDensityPt F v ∧ IsDensityPt F (g v) := by
  -- a measurable null set `N` off which every point of `F` is a density point of `F`
  have hN0 : volume (toMeasurable volume {x : ℝ | ¬ (x ∈ F → IsDensityPt F x)}) = 0 := by
    rw [measure_toMeasurable]
    exact ae_iff.mp (ae_mem_imp_isDensityPt hF)
  set N : Set ℝ := toMeasurable volume {x : ℝ | ¬ (x ∈ F → IsDensityPt F x)} with hN
  have hF'm : MeasurableSet (F \ N) := hF.diff (measurableSet_toMeasurable _ _)
  have hF'd : ∀ x ∈ F \ N, IsDensityPt F x := fun x hx => by
    by_contra hc
    exact hx.2 (subset_toMeasurable _ _ fun himp => hc (himp hx.1))
  have hF'vol : ENNReal.ofReal (7 / 4 * ρ) ≤ volume (F \ N) := by rwa [measure_sdiff_null hN0]
  by_contra hcon
  push Not at hcon
  -- so the image of `F \ N` under `g` misses `F \ N`
  have hdisj : Disjoint (g '' (F \ N)) (F \ N) := by
    rw [Set.disjoint_left]
    rintro _ ⟨v, hv, rfl⟩ hgv
    exact hcon v hv.1 hgv.1 (hF'd v hv) (hF'd _ hgv)
  -- the image has at least `7/8` of the measure
  have himg : volume (F \ N) ≤ ((8 / 7 : NNReal) : ENNReal) * volume (g '' (F \ N)) := by
    refine volume_le_mul_volume_image fun x hx y hy => ?_
    have h87 : (((8 / 7 : NNReal) : ℝ)) = 8 / 7 := by norm_num
    rw [h87, Real.dist_eq, Real.dist_eq]
    rcases le_total x y with hxy | hxy
    · have := (hlip x hx.1 y hy.1 hxy).1
      rw [abs_sub_comm x y, abs_sub_comm (g x) (g y), abs_of_nonneg (by linarith),
        abs_of_nonneg (by linarith)]
      linarith
    · have := (hlip y hy.1 x hx.1 hxy).1
      rw [abs_of_nonneg (by linarith), abs_of_nonneg (by linarith)]
      linarith
  -- both lie in an interval of length `35/16 · ρ`
  have hsub : g '' (F \ N) ∪ (F \ N) ⊆ Ioo (b - ρ) (b + 19 / 16 * ρ) := by
    rintro x (⟨v, hv, rfl⟩ | hx)
    · have h1 := hg v hv.1
      have h2 := hFI hv.1
      exact ⟨by linarith [h2.1], by linarith [h2.2]⟩
    · have h2 := hFI hx.1
      exact ⟨h2.1, by linarith [h2.2]⟩
  have hle : volume (g '' (F \ N)) + volume (F \ N) ≤ ENNReal.ofReal (35 / 16 * ρ) := by
    rw [← measure_union hdisj hF'm]
    refine (measure_mono hsub).trans ?_
    rw [Real.volume_Ioo]
    exact ENNReal.ofReal_le_ofReal (by linarith)
  -- the count, in real numbers
  have hA : volume (g '' (F \ N)) ≠ ⊤ := ((le_self_add.trans hle).trans_lt ENNReal.ofReal_lt_top).ne
  have hB : volume (F \ N) ≠ ⊤ := ((le_add_self.trans hle).trans_lt ENNReal.ofReal_lt_top).ne
  have r1 : (volume (F \ N)).toReal ≤ 8 / 7 * (volume (g '' (F \ N))).toReal := by
    have := ENNReal.toReal_mono (ENNReal.mul_ne_top ENNReal.coe_ne_top hA) himg
    rw [ENNReal.toReal_mul] at this
    have h87 : ((((8 / 7 : NNReal) : ENNReal)).toReal) = 8 / 7 := by norm_num
    rwa [h87] at this
  have r2 : (volume (g '' (F \ N))).toReal + (volume (F \ N)).toReal ≤ 35 / 16 * ρ := by
    have := ENNReal.toReal_mono ENNReal.ofReal_ne_top hle
    rwa [ENNReal.toReal_add hA hB, ENNReal.toReal_ofReal (by positivity)] at this
  have r3 : 7 / 4 * ρ ≤ (volume (F \ N)).toReal := (ENNReal.ofReal_le_iff_le_toReal hB).mp hF'vol
  linarith

/-- **Model of the hypotheses of `exists_density_pair`**: the whole interval `F = (−1, 1)` (`b = 0`, `ρ = 1`) moved by
the translation `g v = v + 1/16`. -/
example := exists_density_pair (F := Ioo ((0 : ℝ) - 1) (0 + 1)) (b := 0) (ρ := 1) (g := fun v => v + 1 / 16)
  measurableSet_Ioo one_pos subset_rfl
  (by rw [Real.volume_Ioo]; exact ENNReal.ofReal_le_ofReal (by norm_num))
  (fun v _ => ⟨by linarith, by linarith⟩) (fun v₁ _ v₂ _ h => ⟨by linarith, by linarith⟩)

/-- **Lemma S, positivity** (in place of "The pairs `(u, w) ∈ 𝒩` with `s(u) = s(w) = X` have positive measure …
On the resulting set of triples, of positive measure"): if at `(α, d, d')` the four angles `α − d`, `α`, `α + ε`,
`α + ε + d'` (`ε = ε d d'`) are density points of `E₁`, `E₂`, `E₂`, `E₁`, then in every cube about `(α, d, d')` the
triples whose four angles lie in `E₁`, `E₂`, `E₂`, `E₁` have positive measure. -/
theorem volume_pattern_pos {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hε : ShiftBounds ε κ) {E₁ E₂ : Set ℝ}
    (h₁ : MeasurableSet E₁) (h₂ : MeasurableSet E₂) {α d d' : ℝ} (hd : 0 < d) (hdκ : d < κ) (hd' : 0 < d')
    (hd'κ : d' < κ) (hp₁ : IsDensityPt E₁ (α - d)) (hp₂ : IsDensityPt E₂ α)
    (hp₃ : IsDensityPt E₂ (α + ε d d')) (hp₄ : IsDensityPt E₁ (α + ε d d' + d')) {η : ℝ} (hη : 0 < η) :
    0 < volume {y : ℝ × ℝ × ℝ | |y.1 - α| < η ∧ |y.2.1 - d| < η ∧ |y.2.2 - d'| < η ∧
      y.1 - y.2.1 ∈ E₁ ∧ y.1 ∈ E₂ ∧ y.1 + ε y.2.1 y.2.2 ∈ E₂ ∧ y.1 + ε y.2.1 y.2.2 + y.2.2 ∈ E₁} := by
  -- a radius `r` at which each of the four sets fills all but `1/24` of the ball of radius `3r` about its point
  have h3 : Tendsto (fun r : ℝ => 3 * r) (𝓝[>] 0) (𝓝[>] 0) := by
    refine tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _ ?_ ?_
    · exact ((continuous_const.mul continuous_id).tendsto' (0 : ℝ) 0 (by simp)).mono_left nhdsWithin_le_nhds
    · filter_upwards [self_mem_nhdsWithin] with r hr
      exact mul_pos three_pos (show (0 : ℝ) < r from hr)
  have hI : ∀ {c : ℝ}, 0 < c → ∀ᶠ r in 𝓝[>] (0 : ℝ), r < c := fun hc =>
    Filter.eventually_of_mem (Ioo_mem_nhdsGT hc) fun r hr => hr.2
  have hrad : ∀ᶠ r in 𝓝[>] (0 : ℝ), 0 < r ∧ r < η ∧ r < d ∧ d + r < κ ∧ r < d' ∧ d' + r < κ ∧
      volume (Metric.closedBall (α - d) (3 * r) \ E₁) ≤ ENNReal.ofReal (r / 8) ∧
      volume (Metric.closedBall α (3 * r) \ E₂) ≤ ENNReal.ofReal (r / 8) ∧
      volume (Metric.closedBall (α + ε d d') (3 * r) \ E₂) ≤ ENNReal.ofReal (r / 8) ∧
      volume (Metric.closedBall (α + ε d d' + d') (3 * r) \ E₁) ≤ ENNReal.ofReal (r / 8) := by
    filter_upwards [self_mem_nhdsWithin, hI hη, hI hd, hI (sub_pos.mpr hdκ), hI hd', hI (sub_pos.mpr hd'κ),
      h3.eventually (hp₁.eventually_compl_le h₁ (δ := 1 / 24) (by norm_num)),
      h3.eventually (hp₂.eventually_compl_le h₂ (δ := 1 / 24) (by norm_num)),
      h3.eventually (hp₃.eventually_compl_le h₂ (δ := 1 / 24) (by norm_num)),
      h3.eventually (hp₄.eventually_compl_le h₁ (δ := 1 / 24) (by norm_num))] with r a0 a1 a2 a3 a4 a5 b1 b2 b3 b4
    have h24 : 1 / 24 * (3 * r) = r / 8 := by ring
    rw [h24] at b1 b2 b3 b4
    exact ⟨a0, a1, a2, by linarith, a4, by linarith, b1, b2, b3, b4⟩
  obtain ⟨r, hr0, hrη, hrd, hrdκ, hrd', hrd'κ, hb1, hb2, hb3, hb4⟩ := hrad.exists
  -- for every `(d₁, d₂)` within `r` of `(d, d')` the section in the first variable has positive measure
  have hsec : ∀ d₁ d₂ : ℝ, |d₁ - d| < r → |d₂ - d'| < r →
      0 < volume {a : ℝ | |a - α| < η ∧ a - d₁ ∈ E₁ ∧ a ∈ E₂ ∧ a + ε d₁ d₂ ∈ E₂ ∧ a + ε d₁ d₂ + d₂ ∈ E₁} := by
    intro d₁ d₂ hd₁ hd₂
    have hee : |ε d₁ d₂ - ε d d'| ≤ r / 16 := by
      rw [abs_lt] at hd₁ hd₂
      have e1 := hε.lip_left d₁ d d₂ (by linarith [hd₁.1]) (by linarith [hd₁.2]) hd hdκ (by linarith [hd₂.1])
        (by linarith [hd₂.2])
      have e2 := hε.lip_right d d₂ d' hd hdκ (by linarith [hd₂.1]) (by linarith [hd₂.2]) hd' hd'κ
      have e3 : |ε d₁ d₂ - ε d d'| ≤ |ε d₁ d₂ - ε d d₂| + |ε d d₂ - ε d d'| := abs_sub_le _ _ _
      have e4 := abs_lt.mpr hd₁
      have e5 := abs_lt.mpr hd₂
      linarith
    rw [abs_le] at hee
    rw [abs_lt] at hd₁ hd₂
    by_contra hzero
    have hT0 : volume {a : ℝ | |a - α| < η ∧ a - d₁ ∈ E₁ ∧ a ∈ E₂ ∧ a + ε d₁ d₂ ∈ E₂ ∧
        a + ε d₁ d₂ + d₂ ∈ E₁} = 0 := nonpos_iff_eq_zero.mp (not_lt.mp hzero)
    -- the window `[α − r, α + r]` is covered by the section and four translates of the bad sets
    have hW : Metric.closedBall α r ⊆
        {a : ℝ | |a - α| < η ∧ a - d₁ ∈ E₁ ∧ a ∈ E₂ ∧ a + ε d₁ d₂ ∈ E₂ ∧ a + ε d₁ d₂ + d₂ ∈ E₁} ∪
        ((fun a : ℝ => a + -d₁) ⁻¹' (Metric.closedBall (α - d) (3 * r) \ E₁) ∪
        ((Metric.closedBall α (3 * r) \ E₂) ∪
        ((fun a : ℝ => a + ε d₁ d₂) ⁻¹' (Metric.closedBall (α + ε d d') (3 * r) \ E₂) ∪
        (fun a : ℝ => a + (ε d₁ d₂ + d₂)) ⁻¹' (Metric.closedBall (α + ε d d' + d') (3 * r) \ E₁)))) := by
      intro a ha
      rw [Metric.mem_closedBall, Real.dist_eq, abs_le] at ha
      by_cases c1 : a - d₁ ∈ E₁
      · by_cases c2 : a ∈ E₂
        · by_cases c3 : a + ε d₁ d₂ ∈ E₂
          · by_cases c4 : a + ε d₁ d₂ + d₂ ∈ E₁
            · exact Or.inl ⟨abs_lt.mpr ⟨by linarith [ha.1], by linarith [ha.2]⟩, c1, c2, c3, c4⟩
            · refine Or.inr (Or.inr (Or.inr (Or.inr ?_)))
              show a + (ε d₁ d₂ + d₂) ∈ Metric.closedBall (α + ε d d' + d') (3 * r) ∧ a + (ε d₁ d₂ + d₂) ∉ E₁
              refine ⟨?_, by rwa [← add_assoc]⟩
              rw [Metric.mem_closedBall, Real.dist_eq, abs_le]
              constructor <;> linarith [ha.1, ha.2, hee.1, hee.2]
          · refine Or.inr (Or.inr (Or.inr (Or.inl ?_)))
            show a + ε d₁ d₂ ∈ Metric.closedBall (α + ε d d') (3 * r) ∧ a + ε d₁ d₂ ∉ E₂
            refine ⟨?_, c3⟩
            rw [Metric.mem_closedBall, Real.dist_eq, abs_le]
            constructor <;> linarith [ha.1, ha.2, hee.1, hee.2]
        · refine Or.inr (Or.inr (Or.inl ⟨?_, c2⟩))
          rw [Metric.mem_closedBall, Real.dist_eq, abs_le]
          constructor <;> linarith [ha.1, ha.2]
      · refine Or.inr (Or.inl ?_)
        show a + -d₁ ∈ Metric.closedBall (α - d) (3 * r) ∧ a + -d₁ ∉ E₁
        refine ⟨?_, by rwa [← sub_eq_add_neg]⟩
        rw [Metric.mem_closedBall, Real.dist_eq, abs_le]
        constructor <;> linarith [ha.1, ha.2]
    have hmeas := (measure_mono (μ := (volume : Measure ℝ)) hW).trans ((measure_union_le _ _).trans
      (add_le_add le_rfl ((measure_union_le _ _).trans (add_le_add le_rfl ((measure_union_le _ _).trans
        (add_le_add le_rfl (measure_union_le _ _)))))))
    rw [hT0, zero_add, measure_preimage_add_right, measure_preimage_add_right, measure_preimage_add_right,
      Real.volume_closedBall] at hmeas
    have hsum := hmeas.trans (add_le_add hb1 (add_le_add hb2 (add_le_add hb3 hb4)))
    rw [← ENNReal.ofReal_add (by positivity) (by positivity), ← ENNReal.ofReal_add (by positivity) (by positivity),
      ← ENNReal.ofReal_add (by positivity) (by positivity), ENNReal.ofReal_le_ofReal_iff (by positivity)] at hsum
    linarith
  -- if the set of triples were null, almost every such section would be null
  by_contra hzero
  have hA0 := nonpos_iff_eq_zero.mp (not_lt.mp hzero)
  have hswap := (Measure.measurePreserving_swap (μ := (volume : Measure (ℝ × ℝ)))
    (ν := (volume : Measure ℝ))).quasiMeasurePreserving.preimage_null hA0
  have hnull := Measure.measure_ae_null_of_prod_null hswap
  have hball : volume (Metric.ball ((d, d') : ℝ × ℝ) r) = 0 := by
    refine measure_mono_null (fun x hx => ?_) (ae_iff.mp hnull)
    rw [Metric.mem_ball, Prod.dist_eq, max_lt_iff, Real.dist_eq, Real.dist_eq] at hx
    refine fun h0 => (hsec x.1 x.2 hx.1 hx.2).ne' (measure_mono_null ?_ h0)
    rintro a ⟨h1, h2, h3, h4, h5⟩
    exact ⟨h1, hx.1.trans hrη, hx.2.trans hrη, h2, h3, h4, h5⟩
  exact (Metric.measure_ball_pos volume _ hr0).ne' hball

/-- **Model of the hypotheses of `volume_pattern_pos`**: the product shift (`shiftBounds_model`), both sets the whole
line, at `(α, d, d') = (0, 1/4, 1/4)`. -/
example := volume_pattern_pos shiftBounds_model (E₁ := univ) (E₂ := univ) MeasurableSet.univ MeasurableSet.univ
  (α := 0) (d := 1 / 4) (d' := 1 / 4) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
  (isDensityPt_of_mem_nhds univ_mem) (isDensityPt_of_mem_nhds univ_mem) (isDensityPt_of_mem_nhds univ_mem)
  (isDensityPt_of_mem_nhds univ_mem) one_pos

/-- (†) reads the same for a set and for its complement: a pair is split by `S` exactly when it is split by `Sᶜ`. -/
theorem noDoubleChange_compl {ε : ℝ → ℝ → ℝ} {S : Set ℝ} {t κ : ℝ} (h : NoDoubleChange ε S t κ) :
    NoDoubleChange ε Sᶜ t κ := by
  filter_upwards [h] with y hy h1 h2 h3 h4 h5 hc
  refine hy h1 h2 h3 h4 h5 ⟨?_, ?_⟩
  · have := hc.1
    simp only [mem_compl_iff, not_not] at this
    tauto
  · have := hc.2
    simp only [mem_compl_iff, not_not] at this
    tauto

/-- **Lemma S, the contradiction** ("On the resulting set of triples, of positive measure, `s(u) ≠ s(v)` and
`s(g(v)) ≠ s(w)`: against (†)"): under (†) for a measurable set `E` there are no three density points `a < b < c`
within `κ/4` of `t`, the outer two of `Eᶜ` and the middle one of `E`. The children in the order of the proof: the
window, the map `g` at its outer pair, the base point `v` with `v` and `g v` density points of `E` in the window, and
the positivity of the forbidden pattern near `(v, v − u, w − g v)`.

A refutation: its hypotheses have no model, and this is the theorem that says so. Each is satisfiable without the
others — `ShiftBounds` by `shiftBounds_model`, (†) by a half-line (the `example` under `step_lemma`), the three
density points by `E = (−1, 1)` (the `example` under `exists_window`). -/
theorem density_triple_false {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hκ : 0 < κ) (hε : ShiftBounds ε κ) {E : Set ℝ}
    (hE : MeasurableSet E) {t : ℝ} (h : NoDoubleChange ε E t κ) {a b c : ℝ} (hla : t - κ / 4 < a) (hab : a < b)
    (hbc : b < c) (hcr : c < t + κ / 4) (ha : IsDensityPt Eᶜ a) (hb : IsDensityPt E b) (hc : IsDensityPt Eᶜ c) :
    False := by
  obtain ⟨u, w, ρ, hρ, hau, hub, hbw, hwc, hdu, hdw, hnear, hfill⟩ := exists_window hE hab hbc ha hb hc
  obtain ⟨g, hg, hslope⟩ := exists_shiftMap hε (show w - u < κ by linarith)
  have hIuw : Ioo (b - ρ) (b + ρ) ⊆ Ioo u w := fun x hx => ⟨by linarith [hx.1], by linarith [hx.2]⟩
  have hFm : MeasurableSet (E ∩ Ioo (b - ρ) (b + ρ)) := hE.inter measurableSet_Ioo
  -- the shift on the window is at most `3ρ/16`: one end of `(u, w)` is within `3ρ` of every point of the window
  have hgF : ∀ v ∈ E ∩ Ioo (b - ρ) (b + ρ), v < g v ∧ g v ≤ v + 3 / 16 * ρ := by
    intro v hv
    have hvI : v ∈ Ioo u w := hIuw hv.2
    obtain ⟨hg1, hg2, hg3⟩ := hg v hvI
    have h1 := hε.le_left (v - u) (w - g v) (by linarith [hvI.1]) (by linarith [hvI.2]) (by linarith)
      (by linarith [hvI.1])
    have h2 := hε.le_right (v - u) (w - g v) (by linarith [hvI.1]) (by linarith [hvI.2]) (by linarith)
      (by linarith [hvI.1])
    refine ⟨hg1, ?_⟩
    rcases hnear with hn | hn
    · linarith [hv.2.2]
    · linarith [hv.2.1]
  obtain ⟨v, hvF, -, hdv, hdgv⟩ := exists_density_pair hFm hρ inter_subset_right hfill hgF
    fun v₁ h₁ v₂ h₂ h12 => hslope v₁ (hIuw h₁.2) v₂ (hIuw h₂.2) h12
  have hvI : v ∈ Ioo u w := hIuw hvF.2
  obtain ⟨hg1, hg2, hg3⟩ := hg v hvI
  have hd0 : 0 < v - u := by linarith [hvI.1]
  have hd'0 : 0 < w - g v := by linarith
  have hη : 0 < min (min (v - u) (w - g v)) (κ / 2) := lt_min (lt_min hd0 hd'0) (by linarith)
  have hpat := volume_pattern_pos hε hE.compl hE (α := v) hd0 (by linarith [hvI.2]) hd'0 (by linarith [hvI.1])
    (by rw [sub_sub_cancel]; exact hdu) (hdv.mono inter_subset_left)
    (by rw [← hg3]; exact hdgv.mono inter_subset_left) (by rw [← hg3, add_sub_cancel]; exact hdw) hη
  refine hpat.ne' (measure_mono_null ?_ (ae_iff.mp h))
  rintro y ⟨h1, h2, h3, h4, h5, h6, h7⟩
  rw [abs_lt] at h1 h2 h3
  have hη1 := (min_le_left _ (κ / 2)).trans (min_le_left (v - u) (w - g v))
  have hη2 := (min_le_left _ (κ / 2)).trans (min_le_right (v - u) (w - g v))
  have hη3 := min_le_right (min (v - u) (w - g v)) (κ / 2)
  intro hP
  refine hP ?_ (by linarith) (by linarith [hvI.2]) (by linarith) (by linarith [hvI.1]) ⟨?_, ?_⟩
  · rw [abs_lt]
    constructor <;> linarith [hvI.1, hvI.2]
  · exact ⟨fun hmem => absurd hmem h4, fun hnot => absurd h5 hnot⟩
  · exact ⟨fun _ => h7, fun _ => h6⟩

/-- **Lemma S** (`plans/FS132-E3-derivation.md`, Stage 3, step M8): "*If (†) holds almost everywhere, `s` is almost
everywhere equal, on `J = (ψ_1 − κ_1/4, ψ_1 + κ_1/4)`, to a function with at most one jump.*" Here `S` is one level
set of `s`, (†) is `NoDoubleChange ε S t κ`, and "at most one jump" is: for some `t'`, almost every `θ` within `κ/4`
of `t` lies in `S` exactly when `θ < t'`, or exactly when `t' < θ` (`t'` outside the interval gives the two constant
cases). No colouring; any shift with `ShiftBounds ε κ` (a model: `shiftBounds_model`); a set satisfying the
hypothesis: a half-line (the `example` below). -/
theorem step_lemma {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hκ : 0 < κ) (hε : ShiftBounds ε κ) {S : Set ℝ} (hS : MeasurableSet S)
    {t : ℝ} (h : NoDoubleChange ε S t κ) :
    ∃ t' : ℝ, (∀ᵐ θ : ℝ, |θ - t| < κ / 4 → (θ ∈ S ↔ θ < t')) ∨
      (∀ᵐ θ : ℝ, |θ - t| < κ / 4 → (θ ∈ S ↔ t' < θ)) := by
  have hIoo : ∀ θ : ℝ, |θ - t| < κ / 4 → θ ∈ Ioo (t - κ / 4) (t + κ / 4) := fun θ hθ => by
    rw [abs_lt] at hθ
    exact ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  rcases exists_step_or_density_triple hS (t - κ / 4) (t + κ / 4) with
    ⟨t', ht'⟩ | ⟨a, b, c, hla, hab, hbc, hcr, ⟨ha, hb, hc⟩ | ⟨ha, hb, hc⟩⟩
  · exact ⟨t', ht'.imp (fun h => h.mono fun θ hθ h1 => hθ (hIoo θ h1))
      fun h => h.mono fun θ hθ h1 => hθ (hIoo θ h1)⟩
  · exact (density_triple_false hκ hε hS.compl (noDoubleChange_compl h) hla hab hbc hcr (by rwa [compl_compl]) hb
      (by rwa [compl_compl])).elim
  · exact (density_triple_false hκ hε hS h hla hab hbc hcr ha hb hc).elim

/-- **Model of the hypothesis of `step_lemma`**: a half-line is split by no two such pairs — a split pair
`(α − d, α)` has `α` at or past the end, and then `α + ε` and `α + ε + d'` are both past it. -/
example {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hε : ShiftBounds ε κ) (t t' : ℝ) : NoDoubleChange ε (Set.Iio t') t κ :=
  Eventually.of_forall fun y _ h1 h2 h3 h4 ⟨ha, hb⟩ => by
    have hpos := hε.pos y.2.1 y.2.2 h1 h2 h3 h4
    simp only [Set.mem_Iio, not_lt] at ha hb
    by_cases h : y.1 - y.2.1 < t'
    · have h5 := ha.mp h
      have h7 := hb.mpr (by linarith)
      linarith
    · exact h (ha.mpr (by linarith [not_lt.mp h]))

/-- A half-line changes at its end: every neighbourhood of `t` meets `Iio t` and its complement in positive measure
(the model of the hypothesis `hchange` of `step_at_of_change` and of `volume_change_pairs_pos`). -/
theorem change_Iio (t : ℝ) : ∀ η : ℝ, 0 < η →
    0 < volume (Iio t ∩ Ioo (t - η) (t + η)) ∧ 0 < volume ((Iio t)ᶜ ∩ Ioo (t - η) (t + η)) := by
  intro η hη
  constructor
  · refine lt_of_lt_of_le ?_ (measure_mono (show Ioo (t - η) t ⊆ _ from
      fun x hx => ⟨hx.2, hx.1, by linarith [hx.2]⟩))
    rw [Real.volume_Ioo]
    simpa using hη
  · refine lt_of_lt_of_le ?_ (measure_mono (show Ioo t (t + η) ⊆ _ from
      fun x hx => ⟨not_lt.mpr hx.1.le, by linarith [hx.1], hx.2⟩))
    rw [Real.volume_Ioo]
    simpa using hη

/-- **M8, last line** ("By M1, `s` is not almost everywhere constant near `ψ_1`, so `s` is a step at `ψ_1`"): if
every neighbourhood of `t` meets `S` and `Sᶜ` in positive measure and `S` is a half-line with end `t'` near `t`,
up to a null set, then `t' = t`. -/
theorem step_at_of_change {S : Set ℝ} {t r : ℝ} (hr : 0 < r)
    (hchange : ∀ η : ℝ, 0 < η → 0 < volume (S ∩ Ioo (t - η) (t + η)) ∧ 0 < volume (Sᶜ ∩ Ioo (t - η) (t + η)))
    {t' : ℝ} (h : (∀ᵐ θ : ℝ, |θ - t| < r → (θ ∈ S ↔ θ < t')) ∨ (∀ᵐ θ : ℝ, |θ - t| < r → (θ ∈ S ↔ t' < θ))) :
    t' = t := by
  -- on an interval about `t` on one side of `t'`, `S` or its complement would be null
  have key : ∀ η : ℝ, 0 < η → η ≤ r → (∀ θ ∈ Ioo (t - η) (t + η), t' < θ) ∨ (∀ θ ∈ Ioo (t - η) (t + η), θ < t') →
      False := by
    intro η hη hηr hside
    obtain ⟨hS, hSc⟩ := hchange η hη
    have hr' : ∀ θ ∈ Ioo (t - η) (t + η), |θ - t| < r := fun θ hθ => by
      rw [abs_lt]; constructor <;> linarith [hθ.1, hθ.2]
    rcases h with h | h <;> rcases hside with hs | hs
    · refine hS.ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
      filter_upwards [h] with θ hθ hmem
      exact lt_asymm (hs θ hmem.2) ((hθ (hr' θ hmem.2)).mp hmem.1)
    · refine hSc.ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
      filter_upwards [h] with θ hθ hmem
      exact hmem.1 ((hθ (hr' θ hmem.2)).mpr (hs θ hmem.2))
    · refine hSc.ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
      filter_upwards [h] with θ hθ hmem
      exact hmem.1 ((hθ (hr' θ hmem.2)).mpr (hs θ hmem.2))
    · refine hS.ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
      filter_upwards [h] with θ hθ hmem
      exact lt_asymm (hs θ hmem.2) ((hθ (hr' θ hmem.2)).mp hmem.1)
  by_contra hne
  rcases lt_or_gt_of_ne hne with hlt | hgt
  · exact key (min r (t - t')) (lt_min hr (by linarith)) (min_le_left _ _)
      (Or.inl fun θ hθ => by linarith [hθ.1, min_le_right r (t - t')])
  · exact key (min r (t' - t)) (lt_min hr (by linarith)) (min_le_left _ _)
      (Or.inr fun θ hθ => by linarith [hθ.2, min_le_right r (t' - t)])

/-- **Model of the hypotheses of `step_at_of_change`**: the half-line `Iio t`, a step at `t`. -/
example (t : ℝ) : t = t :=
  step_at_of_change (S := Iio t) one_pos (change_Iio t) (Or.inl (Eventually.of_forall fun _ _ => Iff.rfl))

/-- **M3, first sentence** ("`W_k(κ)` has positive measure for every `κ > 0`: otherwise `s(α) = s(α − d)` for almost
every `α` within `κ` of `ψ_{k+1}` and `0 < d < κ`, so … `s` is almost everywhere constant there"): at a point `t`
every neighbourhood of which meets `S` and `Sᶜ` in positive measure, the pairs `(α, d)` with `|α − t| < κ`,
`0 < d < κ` and exactly one of `α`, `α − d` in `S` have positive measure, for every `κ > 0`. No measurability of
`S` is used (the measure is outer measure where the set is not measurable). A model of the hypothesis: `S = Iio t`. -/
theorem volume_change_pairs_pos {S : Set ℝ} {t : ℝ}
    (hchange : ∀ η : ℝ, 0 < η → 0 < volume (S ∩ Ioo (t - η) (t + η)) ∧ 0 < volume (Sᶜ ∩ Ioo (t - η) (t + η)))
    {κ : ℝ} (hκ : 0 < κ) :
    0 < volume {x : ℝ × ℝ | |x.1 - t| < κ ∧ 0 < x.2 ∧ x.2 < κ ∧ (x.1 ∈ S ↔ x.1 - x.2 ∉ S)} := by
  obtain ⟨hS1, hS2⟩ := hchange (κ / 2) (by linarith)
  -- the shear `(x, y) ↦ (x, x − y)` preserves the measure of the plane
  have hφ : MeasurePreserving (fun z : ℝ × ℝ => (z.1, z.1 - z.2)) (volume : Measure (ℝ × ℝ)) volume := by
    have h1 : MeasurePreserving (Prod.map (id : ℝ → ℝ) (Neg.neg : ℝ → ℝ)) (volume : Measure (ℝ × ℝ)) volume :=
      (MeasurePreserving.id (volume : Measure ℝ)).prod (Measure.measurePreserving_neg (volume : Measure ℝ))
    have h2 := (measurePreserving_prod_add (volume : Measure ℝ) (volume : Measure ℝ)).comp h1
    have h3 : ((fun z : ℝ × ℝ => (z.1, z.1 + z.2)) ∘ Prod.map (id : ℝ → ℝ) (Neg.neg : ℝ → ℝ)) =
        fun z : ℝ × ℝ => (z.1, z.1 - z.2) := by
      funext z
      simp [sub_eq_add_neg]
    rwa [h3] at h2
  by_contra hzero
  have hT0 := nonpos_iff_eq_zero.mp (not_lt.mp hzero)
  have hP1 := hφ.quasiMeasurePreserving.preimage_null hT0
  have hP2 := (hφ.comp (Measure.measurePreserving_swap (μ := (volume : Measure ℝ))
    (ν := (volume : Measure ℝ)))).quasiMeasurePreserving.preimage_null hT0
  -- a pair with `x ∈ S`, `y ∉ S`, both within `κ/2` of `t`, is carried into the set by one of the two shears
  have hsub : (S ∩ Ioo (t - κ / 2) (t + κ / 2)) ×ˢ (Sᶜ ∩ Ioo (t - κ / 2) (t + κ / 2)) ⊆
      (fun z : ℝ × ℝ => (z.1, z.1 - z.2)) ⁻¹'
        {x : ℝ × ℝ | |x.1 - t| < κ ∧ 0 < x.2 ∧ x.2 < κ ∧ (x.1 ∈ S ↔ x.1 - x.2 ∉ S)} ∪
      ((fun z : ℝ × ℝ => (z.1, z.1 - z.2)) ∘ Prod.swap) ⁻¹'
        {x : ℝ × ℝ | |x.1 - t| < κ ∧ 0 < x.2 ∧ x.2 < κ ∧ (x.1 ∈ S ↔ x.1 - x.2 ∉ S)} := by
    rintro ⟨x, y⟩ ⟨⟨hxS, hxI⟩, ⟨hyS, hyI⟩⟩
    have hxI' : t - κ / 2 < x ∧ x < t + κ / 2 := hxI
    have hyI' : t - κ / 2 < y ∧ y < t + κ / 2 := hyI
    have hyS' : y ∉ S := hyS
    rcases lt_trichotomy y x with hlt | heq | hgt
    · left
      show |x - t| < κ ∧ 0 < x - y ∧ x - y < κ ∧ (x ∈ S ↔ x - (x - y) ∉ S)
      refine ⟨abs_lt.mpr ⟨by linarith, by linarith⟩, by linarith, by linarith, ?_⟩
      rw [sub_sub_cancel]
      exact ⟨fun _ => hyS', fun _ => hxS⟩
    · exact absurd (heq ▸ hxS) hyS'
    · right
      show |y - t| < κ ∧ 0 < y - x ∧ y - x < κ ∧ (y ∈ S ↔ y - (y - x) ∉ S)
      refine ⟨abs_lt.mpr ⟨by linarith, by linarith⟩, by linarith, by linarith, ?_⟩
      rw [sub_sub_cancel]
      exact ⟨fun h => absurd h hyS', fun h => absurd hxS h⟩
  have hprod := measure_mono_null hsub (measure_union_null hP1 hP2)
  rw [Measure.volume_eq_prod, Measure.prod_prod, mul_eq_zero] at hprod
  rcases hprod with h | h
  · exact hS1.ne' h
  · exact hS2.ne' h

/-- **Model of the hypothesis of `volume_change_pairs_pos`**: the half-line `Iio t`. -/
example (t : ℝ) := volume_change_pairs_pos (change_Iio t) one_pos

end HadwigerNelson.SixRing
