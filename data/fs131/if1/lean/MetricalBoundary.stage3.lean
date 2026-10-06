import Mathlib.MeasureTheory.Covering.BesicovitchVectorSpace
import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar
import Mathlib.Analysis.Normed.Module.Convex
import Mathlib.Topology.Order.IntermediateValue

/-!
# A set that is neither null nor conull has a nonempty metrical boundary (FS131-IF1)

`[Falconer1981]` Lemma 2 (i), p. 185: *"Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ∖S) > 0 then (i) ∂S is
non-empty"*, where `∂S`, the metrical boundary, is the set of points at which the Lebesgue density of `S` fails to exist or
exists with a value other than `0` or `1`. The paper defers the proof to Croft's Lemma 4, which this project does not hold;
the argument here is its own (nested balls of ratio one half), and is not claimed to be Croft's.

Setting: a finite-dimensional real normed space `E` with an additive Haar measure `μ`, and a `μ`-null-measurable `S` — for
Lebesgue measure on `ℝⁿ`, a Lebesgue measurable set, which is the paper's hypothesis. Write
`φ_S(c, r) = μ (S ∩ B̄(c, r)) / μ (B̄(c, r))`.

1. `c ↦ μ (S ∩ B̄(c, r))` is continuous (`continuous_measure_inter_closedBall`): two balls of one radius differ by at most an
   annulus, whose measure tends to `0` with the distance of the centres.
2. Inside a closed ball whose interior holds a density point of `S` and one of `Sᶜ` there is, at every small radius, a closed
   ball with `φ_S = 1/2` (`exists_closedBall_ratio_eq_half`): at a small radius `φ_S` is above `1/2` at the first point and
   below it at the second, the centres allowed form a convex set, and the intermediate value theorem applies.
3. A ball with `φ_S = 1/2` holds a density point of each in its interior (Lebesgue's density theorem in Besicovitch's form;
   a sphere is null), so step 2 repeats: nested closed balls with `φ_S = 1/2` and radii halving
   (`exists_nested_closedBalls_ratio_eq_half`).
4. At a common point `x` of the balls, `B̄(cₙ, rₙ) ⊆ B̄(x, 2 rₙ)` and the larger ball has `2 ^ dim E` times the measure, so
   both `φ_S(x, 2 rₙ)` and `φ_{Sᶜ}(x, 2 rₙ)` are at least `1 / (2 · 2 ^ dim E)` (`exists_ratio_ge_and_compl_ge`). Neither
   ratio tends to `1` (`exists_not_tendsto_ratio_and_compl`), which is the paper's statement; the quantitative form says
   more — both `S` and `Sᶜ` have positive upper density at `x`, with an explicit bound.

`Plane/FalconerReduction` reads the last theorem at `E = ℂ`, `μ = volume` (`falconer_lemma2_nonempty`).
-/

namespace HadwigerNelson.Plane

open Set MeasureTheory Filter Topology Metric

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] (μ : Measure E) [μ.IsAddHaarMeasure]

/-- Two closed balls of one radius: the part of `S` in the second is the part in the first up to an annulus about the
first, whose measure depends only on the radius and the distance of the centres. -/
theorem measure_inter_closedBall_le_add (S : Set E) (c c' : E) (ρ : ℝ) :
    μ (S ∩ closedBall c' ρ) ≤
      μ (S ∩ closedBall c ρ) + (μ (closedBall (0 : E) (ρ + dist c' c)) - μ (closedBall (0 : E) ρ)) := by
  have hsub : S ∩ closedBall c' ρ ⊆ (S ∩ closedBall c ρ) ∪ (closedBall c (ρ + dist c' c) \ closedBall c ρ) := by
    intro y hy
    by_cases h : y ∈ closedBall c ρ
    · exact Or.inl ⟨hy.1, h⟩
    · exact Or.inr ⟨closedBall_subset_closedBall' le_rfl hy.2, h⟩
  have hann : μ (closedBall c (ρ + dist c' c) \ closedBall c ρ) =
      μ (closedBall (0 : E) (ρ + dist c' c)) - μ (closedBall (0 : E) ρ) := by
    rw [measure_sdiff (closedBall_subset_closedBall (by linarith [dist_nonneg (x := c') (y := c)]))
      measurableSet_closedBall.nullMeasurableSet measure_closedBall_lt_top.ne,
      Measure.addHaar_closedBall_center μ c, Measure.addHaar_closedBall_center μ c ρ]
  calc μ (S ∩ closedBall c' ρ)
      ≤ μ ((S ∩ closedBall c ρ) ∪ (closedBall c (ρ + dist c' c) \ closedBall c ρ)) := measure_mono hsub
    _ ≤ μ (S ∩ closedBall c ρ) + μ (closedBall c (ρ + dist c' c) \ closedBall c ρ) := measure_union_le _ _
    _ = _ := by rw [hann]

/-- The measure of the annulus between the radii `ρ` and `ρ + d` tends to `0` with `d`. -/
theorem tendsto_measure_closedBall_sub {ρ : ℝ} (hρ : 0 < ρ) :
    Tendsto (fun d : ℝ => μ (closedBall (0 : E) (ρ + d)) - μ (closedBall (0 : E) ρ)) (𝓝 0) (𝓝 0) := by
  have hK : μ (closedBall (0 : E) 1) ≠ ⊤ := measure_closedBall_lt_top.ne
  have h1 : Tendsto (fun d : ℝ => ENNReal.ofReal ((ρ + d) ^ Module.finrank ℝ E) * μ (closedBall (0 : E) 1)) (𝓝 0)
      (𝓝 (ENNReal.ofReal (ρ ^ Module.finrank ℝ E) * μ (closedBall (0 : E) 1))) := by
    refine ENNReal.Tendsto.mul_const (ENNReal.tendsto_ofReal ?_) (Or.inr hK)
    have : Continuous fun d : ℝ => (ρ + d) ^ Module.finrank ℝ E := by fun_prop
    simpa using this.tendsto 0
  have h2 : Tendsto (fun d : ℝ => μ (closedBall (0 : E) (ρ + d))) (𝓝 0) (𝓝 (μ (closedBall (0 : E) ρ))) := by
    rw [Measure.addHaar_closedBall' μ 0 hρ.le]
    refine h1.congr' ?_
    filter_upwards [Ioo_mem_nhds (neg_lt_zero.2 hρ) hρ] with d hd
    exact (Measure.addHaar_closedBall' μ 0 (by linarith [hd.1])).symm
  have := ENNReal.Tendsto.sub h2 (tendsto_const_nhds (x := μ (closedBall (0 : E) ρ)))
    (Or.inl measure_closedBall_lt_top.ne)
  rwa [tsub_self] at this

/-- The measure of the part of any set in a closed ball of fixed positive radius is continuous in the centre. -/
theorem continuous_measure_inter_closedBall (S : Set E) {ρ : ℝ} (hρ : 0 < ρ) :
    Continuous fun c : E => μ (S ∩ closedBall c ρ) := by
  rw [continuous_iff_continuousAt]
  intro c
  have hfin : μ (S ∩ closedBall c ρ) ≠ ⊤ :=
    ((measure_mono inter_subset_right).trans_lt measure_closedBall_lt_top).ne
  rw [ContinuousAt, ENNReal.tendsto_nhds hfin]
  intro ε hε
  have hd : Tendsto (fun c' : E => dist c' c) (𝓝 c) (𝓝 0) := by
    have := (continuous_id.dist continuous_const : Continuous fun c' : E => dist c' c).tendsto c
    simpa using this
  have hη := (tendsto_measure_closedBall_sub μ hρ).comp hd
  filter_upwards [ENNReal.tendsto_nhds_zero.1 hη ε hε] with c' hc'
  simp only [Function.comp_apply] at hc'
  constructor
  · rw [tsub_le_iff_right]
    have := measure_inter_closedBall_le_add μ S c' c ρ
    rw [dist_comm] at this
    exact this.trans (by gcongr)
  · exact (measure_inter_closedBall_le_add μ S c c' ρ).trans (by gcongr)

omit [BorelSpace E] in
/-- On a closed ball of positive radius the ratios of a null-measurable set and of its complement sum to `1`. -/
theorem measure_inter_closedBall_div_add_compl {S : Set E} (hS : NullMeasurableSet S μ) (x : E) {r : ℝ} (hr : 0 < r) :
    μ (S ∩ closedBall x r) / μ (closedBall x r) + μ (Sᶜ ∩ closedBall x r) / μ (closedBall x r) = 1 := by
  have hB : μ (closedBall x r) ≠ 0 := (measure_closedBall_pos μ x hr).ne'
  have hB' : μ (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
  rw [← ENNReal.add_div, inter_comm S, inter_comm Sᶜ, ← sdiff_eq, measure_inter_add_sdiff₀ _ hS,
    ENNReal.div_self hB hB']

omit [BorelSpace E] in
/-- In a closed ball of positive radius where a null-measurable set has ratio one half, so has its complement. -/
theorem measure_compl_inter_closedBall_div_eq_half {S : Set E} (hS : NullMeasurableSet S μ) {c : E} {r : ℝ}
    (hr : 0 < r) (h : μ (S ∩ closedBall c r) / μ (closedBall c r) = 1 / 2) :
    μ (Sᶜ ∩ closedBall c r) / μ (closedBall c r) = 1 / 2 := by
  have hsum := measure_inter_closedBall_div_add_compl μ hS c hr
  rw [h] at hsum
  exact (ENNReal.add_right_inj (by simp)).1 (hsum.trans (ENNReal.add_halves 1).symm)

/-- A set with positive measure in an open ball has a density point in it (Lebesgue's density theorem, in Besicovitch's
form, for an arbitrary set). -/
theorem exists_mem_ball_tendsto_ratio (A : Set E) {c : E} {ρ : ℝ} (h : μ (A ∩ ball c ρ) ≠ 0) :
    ∃ a ∈ ball c ρ, Tendsto (fun r => μ (A ∩ closedBall a r) / μ (closedBall a r)) (𝓝[>] 0) (𝓝 1) := by
  have hae := ae_restrict_of_ae_restrict_of_subset (inter_subset_left (t := ball c ρ))
    (Besicovitch.ae_tendsto_measure_inter_div μ A)
  obtain ⟨a, ha, hlim⟩ := Measure.exists_mem_of_measure_ne_zero_of_ae h hae
  exact ⟨a, ha.2, hlim⟩

/-- A set of ratio one half in a closed ball of positive radius has positive measure in the open ball: a sphere is null. -/
theorem measure_inter_ball_ne_zero_of_ratio_eq_half {A : Set E} {c : E} {ρ : ℝ} (hρ : 0 < ρ)
    (h : μ (A ∩ closedBall c ρ) / μ (closedBall c ρ) = 1 / 2) : μ (A ∩ ball c ρ) ≠ 0 := by
  intro h0
  have hle : μ (A ∩ closedBall c ρ) ≤ μ (A ∩ ball c ρ) + μ (sphere c ρ) := by
    refine (measure_mono ?_).trans (measure_union_le _ _)
    rw [← ball_union_sphere]
    rintro y ⟨hyA, hy | hy⟩
    · exact Or.inl ⟨hyA, hy⟩
    · exact Or.inr hy
  rw [h0, Measure.addHaar_sphere_of_ne_zero μ c hρ.ne', add_zero, nonpos_iff_eq_zero] at hle
  rw [hle, ENNReal.zero_div] at h
  exact (ENNReal.half_pos one_ne_zero).ne h

/-- **The step.** Inside a closed ball whose interior holds a density point `a` of `S` and a density point `b` of `Sᶜ`
there is, below any bound `δ`, a closed ball in which `S` has ratio exactly one half. -/
theorem exists_closedBall_ratio_eq_half {S : Set E} (hS : NullMeasurableSet S μ) {c₀ a b : E} {R δ : ℝ}
    (ha : a ∈ ball c₀ R) (hb : b ∈ ball c₀ R) (hδ : 0 < δ)
    (hSa : Tendsto (fun r => μ (S ∩ closedBall a r) / μ (closedBall a r)) (𝓝[>] 0) (𝓝 1))
    (hSb : Tendsto (fun r => μ (Sᶜ ∩ closedBall b r) / μ (closedBall b r)) (𝓝[>] 0) (𝓝 1)) :
    ∃ c ρ, 0 < ρ ∧ ρ ≤ δ ∧ closedBall c ρ ⊆ closedBall c₀ R ∧
      μ (S ∩ closedBall c ρ) / μ (closedBall c ρ) = 1 / 2 := by
  have hRa : 0 < R - dist a c₀ := sub_pos.2 (mem_ball.1 ha)
  have hRb : 0 < R - dist b c₀ := sub_pos.2 (mem_ball.1 hb)
  have hhalf : (1 / 2 : ENNReal) < 1 := ENNReal.half_lt_self one_ne_zero ENNReal.one_ne_top
  -- a radius below every bound at which `S` has ratio above one half at `a` and `Sᶜ` at `b`
  have hev : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), ρ ∈ Ioo 0 (min δ (min (R - dist a c₀) (R - dist b c₀))) ∧
      1 / 2 < μ (S ∩ closedBall a ρ) / μ (closedBall a ρ) ∧
      1 / 2 < μ (Sᶜ ∩ closedBall b ρ) / μ (closedBall b ρ) :=
    Filter.Eventually.and (Ioo_mem_nhdsGT (lt_min hδ (lt_min hRa hRb)))
      ((hSa.eventually (lt_mem_nhds hhalf)).and (hSb.eventually (lt_mem_nhds hhalf)))
  obtain ⟨ρ, ⟨hρ0, hρlt⟩, haρ, hbρ⟩ := hev.exists
  have hρδ : ρ ≤ δ := hρlt.le.trans (min_le_left _ _)
  have hρa : dist a c₀ ≤ R - ρ := by
    have := hρlt.trans_le ((min_le_right _ _).trans (min_le_left _ _)); linarith
  have hρb : dist b c₀ ≤ R - ρ := by
    have := hρlt.trans_le ((min_le_right _ _).trans (min_le_right _ _)); linarith
  -- at `b` the ratio of `S` is below one half
  have hbS : μ (S ∩ closedBall b ρ) / μ (closedBall b ρ) < 1 / 2 := by
    by_contra hge
    rw [not_lt] at hge
    have hlt : (1 : ENNReal) <
        μ (S ∩ closedBall b ρ) / μ (closedBall b ρ) + μ (Sᶜ ∩ closedBall b ρ) / μ (closedBall b ρ) := by
      calc (1 : ENNReal) = 1 / 2 + 1 / 2 := (ENNReal.add_halves 1).symm
        _ < _ := ENNReal.add_lt_add_of_le_of_lt (by simp) hge hbρ
    exact hlt.ne' (measure_inter_closedBall_div_add_compl μ hS b hρ0)
  -- the ratio is continuous in the centre, and the centres allowed form a convex set
  have hfc : Continuous fun c : E => μ (S ∩ closedBall c ρ) / μ (closedBall c ρ) := by
    simp only [Measure.addHaar_closedBall_center μ _ ρ]
    exact (ENNReal.continuous_div_const _ (measure_closedBall_pos μ 0 hρ0).ne').comp
      (continuous_measure_inter_closedBall μ S hρ0)
  have hconn : IsPreconnected (closedBall c₀ (R - ρ)) := (convex_closedBall c₀ (R - ρ)).isPreconnected
  obtain ⟨c, hc, hc'⟩ := hconn.intermediate_value (mem_closedBall.2 hρb) (mem_closedBall.2 hρa)
    hfc.continuousOn ⟨hbS.le, haρ.le⟩
  refine ⟨c, ρ, hρ0, hρδ, closedBall_subset_closedBall' ?_, hc'⟩
  have := mem_closedBall.1 hc
  linarith

/-- A closed ball of ratio one half holds another of at most half its radius. -/
theorem exists_closedBall_subset_ratio_eq_half {S : Set E} (hS : NullMeasurableSet S μ) {c : E} {r : ℝ} (hr : 0 < r)
    (h : μ (S ∩ closedBall c r) / μ (closedBall c r) = 1 / 2) :
    ∃ c' r', 0 < r' ∧ r' ≤ r / 2 ∧ closedBall c' r' ⊆ closedBall c r ∧
      μ (S ∩ closedBall c' r') / μ (closedBall c' r') = 1 / 2 := by
  obtain ⟨a, ha, hSa⟩ := exists_mem_ball_tendsto_ratio μ S (measure_inter_ball_ne_zero_of_ratio_eq_half μ hr h)
  obtain ⟨b, hb, hSb⟩ := exists_mem_ball_tendsto_ratio μ Sᶜ
    (measure_inter_ball_ne_zero_of_ratio_eq_half μ hr (measure_compl_inter_closedBall_div_eq_half μ hS hr h))
  exact exists_closedBall_ratio_eq_half μ hS ha hb (half_pos hr) hSa hSb

/-- A null-measurable set that is neither null nor conull has ratio exactly one half in some closed ball. -/
theorem exists_closedBall_ratio_eq_half_of_measure_ne_zero {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0)
    (h2 : μ Sᶜ ≠ 0) : ∃ c r, 0 < r ∧ μ (S ∩ closedBall c r) / μ (closedBall c r) = 1 / 2 := by
  obtain ⟨a, -, hSa⟩ := Measure.exists_mem_of_measure_ne_zero_of_ae h1 (Besicovitch.ae_tendsto_measure_inter_div μ S)
  obtain ⟨b, -, hSb⟩ := Measure.exists_mem_of_measure_ne_zero_of_ae h2 (Besicovitch.ae_tendsto_measure_inter_div μ Sᶜ)
  obtain ⟨c, r, h0, -, -, hhalf⟩ := exists_closedBall_ratio_eq_half μ hS (c₀ := a) (R := dist b a + 1)
    (mem_ball_self (by positivity)) (mem_ball.2 (lt_add_one _)) one_pos hSa hSb
  exact ⟨c, r, h0, hhalf⟩

/-- Nested closed balls, radii at least halving, in each of which `S` has ratio exactly one half. -/
theorem exists_nested_closedBalls_ratio_eq_half {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0)
    (h2 : μ Sᶜ ≠ 0) :
    ∃ (c : ℕ → E) (r : ℕ → ℝ), (∀ n, 0 < r n) ∧ (∀ n, r (n + 1) ≤ r n / 2) ∧
      (∀ n, closedBall (c (n + 1)) (r (n + 1)) ⊆ closedBall (c n) (r n)) ∧
      ∀ n, μ (S ∩ closedBall (c n) (r n)) / μ (closedBall (c n) (r n)) = 1 / 2 := by
  let P : E × ℝ → Prop := fun p => 0 < p.2 ∧ μ (S ∩ closedBall p.1 p.2) / μ (closedBall p.1 p.2) = 1 / 2
  have step : ∀ p : {p : E × ℝ // P p}, ∃ q : {p : E × ℝ // P p},
      q.1.2 ≤ p.1.2 / 2 ∧ closedBall q.1.1 q.1.2 ⊆ closedBall p.1.1 p.1.2 := by
    rintro ⟨⟨c, r⟩, hr, h⟩
    obtain ⟨c', r', h0, hle, hsub, hhalf⟩ := exists_closedBall_subset_ratio_eq_half μ hS hr h
    exact ⟨⟨(c', r'), h0, hhalf⟩, hle, hsub⟩
  choose f hf using step
  obtain ⟨c₀, r₀, hr₀, h₀⟩ := exists_closedBall_ratio_eq_half_of_measure_ne_zero μ hS h1 h2
  let p₀ : {p : E × ℝ // P p} := ⟨(c₀, r₀), hr₀, h₀⟩
  refine ⟨fun n => (f^[n] p₀).1.1, fun n => (f^[n] p₀).1.2, fun n => (f^[n] p₀).2.1, fun n => ?_, fun n => ?_,
    fun n => (f^[n] p₀).2.2⟩
  · simp only [Function.iterate_succ_apply']
    exact (hf _).1
  · simp only [Function.iterate_succ_apply']
    exact (hf _).2

/-- At a point of a closed ball of ratio one half, the ball of twice the radius has ratio at least
`1 / (2 · 2 ^ dim E)`: it contains the first and has `2 ^ dim E` times its measure. -/
theorem ratio_two_mul_ge {A : Set E} {x c : E} {r : ℝ} (hr : 0 < r) (hx : x ∈ closedBall c r)
    (h : μ (A ∩ closedBall c r) / μ (closedBall c r) = 1 / 2) :
    (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≤ μ (A ∩ closedBall x (2 * r)) / μ (closedBall x (2 * r)) := by
  have hV0 : μ (closedBall (0 : E) r) ≠ 0 := (measure_closedBall_pos μ 0 hr).ne'
  have hVt : μ (closedBall (0 : E) r) ≠ ⊤ := measure_closedBall_lt_top.ne
  have hT0 : (2 ^ Module.finrank ℝ E : ENNReal) ≠ 0 := pow_ne_zero _ two_ne_zero
  have hTt : (2 ^ Module.finrank ℝ E : ENNReal) ≠ ⊤ := ENNReal.pow_ne_top ENNReal.ofNat_ne_top
  have hbig : μ (closedBall x (2 * r)) = 2 ^ Module.finrank ℝ E * μ (closedBall (0 : E) r) := by
    rw [Measure.addHaar_closedBall_mul μ x zero_le_two hr.le, ENNReal.ofReal_pow zero_le_two, ENNReal.ofReal_ofNat]
  have hsmall : μ (A ∩ closedBall c r) = 2⁻¹ * μ (closedBall (0 : E) r) := by
    rw [Measure.addHaar_closedBall_center μ c r] at h
    rw [← (ENNReal.eq_div_iff hV0 hVt).1 h.symm, one_div, mul_comm]
  have hmono : μ (A ∩ closedBall c r) ≤ μ (A ∩ closedBall x (2 * r)) :=
    measure_mono (inter_subset_inter_right _ (closedBall_subset_closedBall' (by
      have := mem_closedBall.1 hx
      rw [dist_comm]; linarith)))
  rw [hbig, ENNReal.le_div_iff_mul_le (Or.inl (mul_ne_zero hT0 hV0)) (Or.inl (ENNReal.mul_ne_top hTt hVt))]
  calc (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ * (2 ^ Module.finrank ℝ E * μ (closedBall (0 : E) r))
      = 2⁻¹ * μ (closedBall (0 : E) r) := by
        rw [ENNReal.mul_inv (Or.inl two_ne_zero) (Or.inl ENNReal.ofNat_ne_top), mul_assoc, ← mul_assoc _ _ (μ _),
          ENNReal.inv_mul_cancel hT0 hTt, one_mul]
    _ = μ (A ∩ closedBall c r) := hsmall.symm
    _ ≤ _ := hmono

/-- **The quantitative form.** A null-measurable set that is neither null nor conull has a point at which, along radii
tending to `0`, both it and its complement have ratio at least `1 / (2 · 2 ^ dim E)`. -/
theorem exists_ratio_ge_and_compl_ge {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0) (h2 : μ Sᶜ ≠ 0) :
    ∃ (x : E) (s : ℕ → ℝ), (∀ n, 0 < s n) ∧ Tendsto s atTop (𝓝 0) ∧
      ∀ n, (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≤ μ (S ∩ closedBall x (s n)) / μ (closedBall x (s n)) ∧
        (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≤ μ (Sᶜ ∩ closedBall x (s n)) / μ (closedBall x (s n)) := by
  obtain ⟨c, r, hr, hhalve, hnest, hhalf⟩ := exists_nested_closedBalls_ratio_eq_half μ hS h1 h2
  have hrn : ∀ n, r n ≤ r 0 * (1 / 2) ^ n := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
      calc r (n + 1) ≤ r n / 2 := hhalve n
        _ ≤ r 0 * (1 / 2) ^ n / 2 := by gcongr
        _ = r 0 * (1 / 2) ^ (n + 1) := by ring
  have hr0 : Tendsto r atTop (𝓝 0) := by
    refine squeeze_zero (fun n => (hr n).le) hrn ?_
    have := (tendsto_pow_atTop_nhds_zero_of_lt_one (by norm_num : (0 : ℝ) ≤ 1 / 2)
      (by norm_num : (1 / 2 : ℝ) < 1)).const_mul (r 0)
    simpa using this
  obtain ⟨x, hx⟩ := IsCompact.nonempty_iInter_of_sequence_nonempty_isCompact_isClosed
    (fun n => closedBall (c n) (r n)) hnest (fun n => nonempty_closedBall.2 (hr n).le)
    (isCompact_closedBall _ _) (fun n => isClosed_closedBall)
  rw [mem_iInter] at hx
  refine ⟨x, fun n => 2 * r n, fun n => mul_pos two_pos (hr n), ?_, fun n => ⟨?_, ?_⟩⟩
  · simpa using hr0.const_mul 2
  · exact ratio_two_mul_ge μ (hr n) (hx n) (hhalf n)
  · exact ratio_two_mul_ge μ (hr n) (hx n) (measure_compl_inter_closedBall_div_eq_half μ hS (hr n) (hhalf n))

omit [BorelSpace E] in
/-- A point at which a null-measurable set keeps ratio at least `κ > 0` along radii tending to `0` is no density point of
its complement. -/
theorem not_tendsto_ratio_compl_of_ratio_ge {A : Set E} (hA : NullMeasurableSet A μ) {x : E} {s : ℕ → ℝ} {κ : ENNReal}
    (hκ : κ ≠ 0) (hs : ∀ n, 0 < s n) (hs0 : Tendsto s atTop (𝓝 0))
    (h : ∀ n, κ ≤ μ (A ∩ closedBall x (s n)) / μ (closedBall x (s n))) :
    ¬ Tendsto (fun r => μ (Aᶜ ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 1) := by
  intro hlim
  have hs' : Tendsto s atTop (𝓝[>] 0) := tendsto_nhdsWithin_iff.2 ⟨hs0, Eventually.of_forall hs⟩
  have hsum : Tendsto (fun n => κ + μ (Aᶜ ∩ closedBall x (s n)) / μ (closedBall x (s n))) atTop (𝓝 (κ + 1)) :=
    (hlim.comp hs').const_add κ
  have hle : κ + 1 ≤ 0 + 1 := by
    rw [zero_add]
    refine le_of_tendsto' hsum fun n => ?_
    calc κ + μ (Aᶜ ∩ closedBall x (s n)) / μ (closedBall x (s n))
        ≤ μ (A ∩ closedBall x (s n)) / μ (closedBall x (s n)) +
          μ (Aᶜ ∩ closedBall x (s n)) / μ (closedBall x (s n)) := by gcongr; exact h n
      _ = 1 := measure_inter_closedBall_div_add_compl μ hA x (hs n)
  exact hκ (nonpos_iff_eq_zero.1 ((ENNReal.add_le_add_iff_right ENNReal.one_ne_top).1 hle))

/-- **`[Falconer1981]` Lemma 2 (i), in any finite dimension.** A null-measurable set that is neither null nor conull for an
additive Haar measure on a finite-dimensional real normed space has a point that is a density point neither of it nor of
its complement: its metrical boundary is nonempty. -/
theorem exists_not_tendsto_ratio_and_compl {S : Set E} (hS : NullMeasurableSet S μ) (h1 : μ S ≠ 0) (h2 : μ Sᶜ ≠ 0) :
    ∃ x : E, ¬ Tendsto (fun r => μ (S ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 1) ∧
      ¬ Tendsto (fun r => μ (Sᶜ ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 1) := by
  obtain ⟨x, s, hs, hs0, h⟩ := exists_ratio_ge_and_compl_ge μ hS h1 h2
  have hκ : (2 * 2 ^ Module.finrank ℝ E : ENNReal)⁻¹ ≠ 0 :=
    ENNReal.inv_ne_zero.2 (ENNReal.mul_ne_top ENNReal.ofNat_ne_top (ENNReal.pow_ne_top ENNReal.ofNat_ne_top))
  refine ⟨x, ?_, not_tendsto_ratio_compl_of_ratio_ge μ hS hκ hs hs0 fun n => (h n).1⟩
  have := not_tendsto_ratio_compl_of_ratio_ge μ hS.compl hκ hs hs0 fun n => (h n).2
  rwa [compl_compl] at this

/-! ## Spec examples -/

/-- **A model of the hypotheses**, in dimension one: the half-line `(0, ∞)` and its complement both have positive measure,
so the theorem gives it a point of its metrical boundary. -/
example : ∃ x : ℝ,
    ¬ Tendsto (fun r => volume (Ioi (0 : ℝ) ∩ closedBall x r) / volume (closedBall x r)) (𝓝[>] 0) (𝓝 1) ∧
      ¬ Tendsto (fun r => volume ((Ioi (0 : ℝ))ᶜ ∩ closedBall x r) / volume (closedBall x r)) (𝓝[>] 0) (𝓝 1) :=
  exists_not_tendsto_ratio_and_compl volume measurableSet_Ioi.nullMeasurableSet (by simp) (by simp)

/-- **Adversary**: the hypothesis `μ Sᶜ ≠ 0` cannot be dropped — every point is a density point of the whole space, so the
conclusion fails for `S = univ`. -/
example : ¬ ∃ x : ℝ,
    ¬ Tendsto (fun r => volume ((univ : Set ℝ) ∩ closedBall x r) / volume (closedBall x r)) (𝓝[>] 0) (𝓝 1) ∧
      ¬ Tendsto (fun r => volume ((univ : Set ℝ)ᶜ ∩ closedBall x r) / volume (closedBall x r)) (𝓝[>] 0) (𝓝 1) := by
  rintro ⟨x, h, -⟩
  refine h (tendsto_const_nhds.congr' ?_)
  filter_upwards [self_mem_nhdsWithin] with r hr
  rw [univ_inter, ENNReal.div_self (measure_closedBall_pos volume x hr).ne' measure_closedBall_lt_top.ne]

/-- The constant of the quantitative form in dimension one is `1/4`. -/
example : (2 * 2 ^ Module.finrank ℝ ℝ : ENNReal)⁻¹ = 4⁻¹ := by
  rw [Module.finrank_self, pow_one]; norm_num

end HadwigerNelson.Plane
