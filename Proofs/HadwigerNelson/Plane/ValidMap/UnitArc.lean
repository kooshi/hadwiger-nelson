import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Mathlib.Analysis.Real.Pi.Bounds
import Proofs.HadwigerNelson.Plane.RingGerm

/-!
# The unit-arc calculus (FS-112), first rows

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` §§ 3, 12). A unit arc `α ⊂ ω(P)` with constant sides is wave 3's
`F.IsRingArc P θ₁ θ₂ c c'` (inner colour `c`, outer `c'`, `θ₁ < θ₂`); "valid map" is `F.Valid` for any `F : ArcMap k` (only FS112-NB4P
reads six colours). The frame at a horn's vertex `v` is the foundation's: `a = e α`, `n = e (α + π/2)`, `N = v + n`, `S′ = v − n`.

* **FS112-LOCK** (`lock`); **FS112-N3-NOBOTH** (`noBoth`); **FS112-U1**, its shadow clause (`u1_shadow`; the first three clauses are
  wave 3's FS116-V5-U1).
* **FS114-L60-LE**: L60-LE (`l60_le`), L60-EQ (`l60_eq_inner`, `l60_eq_outer`, `l60_eq_corners`, `l60_eq_third`), L60-REAL (`l60Frag`,
  `l60_real`).
* **FS112-N2-BENDS** with FS112-BEND merged: N2-SIGN (`n2_sign`), N2-ENV (`n2_env_toward`, `n2_env_away`, `n2_env_near`,
  `n2_env_near_away`), the bends (`bend_toward`, `bend_away`, `bend_away_whole`).
* **FS112-ISO** (`isoFrag`, `iso`); **FS112-FLANK** (`inType_shadows_horn`, `flank_siamese_of_inType`; its third clause, the bowtie's
  witness, is `flank_incomplete_bowtie` in `Plane/ValidMap/BaseSteps`); **FS112-N2-FLANK-Q** (`flankQ_upper`, `flankQ_lower`,
  `flankQ_both`).
* **FS112-A4SIX** (`a4six`); **FS112-NB4P** (`nb4p`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `framePt` has the `x` coordinate it is built from. -/
theorem frameX_framePt (v : ℂ) (α x y : ℝ) : frameX v α (framePt v α x y) = x := by
  have hce := conj_e_mul_e α
  unfold frameX framePt
  have : (v + ((x : ℂ) + (y : ℂ) * I) * e α - v) * starRingEnd ℂ (e α) = (x : ℂ) + (y : ℂ) * I := by
    calc _ = ((x : ℂ) + (y : ℂ) * I) * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [hce, mul_one]
  rw [this]; simp

/-- `framePt` has the `y` coordinate it is built from. -/
theorem frameY_framePt (v : ℂ) (α x y : ℝ) : frameY v α (framePt v α x y) = y := by
  have hce := conj_e_mul_e α
  unfold frameY framePt
  have : (v + ((x : ℂ) + (y : ℂ) * I) * e α - v) * starRingEnd ℂ (e α) = (x : ℂ) + (y : ℂ) * I := by
    calc _ = ((x : ℂ) + (y : ℂ) * I) * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [hce, mul_one]
  rw [this]; simp

/-- The height of the parabola point `(t, s t²/2)` above the arc of curvature `κ`. -/
theorem tanHeight_hornPt (κ s t : ℝ) : tanHeight κ t (s * t ^ 2 / 2) = (t ^ 2 / 2) * (s - κ - κ * s ^ 2 * t ^ 2 / 4) := by
  unfold tanHeight; ring

/-- Above a lower curvature `κ < s`, for small `t`: the sign of `tanHeight_hornPt`. -/
theorem eventually_hornPt_pos {κ s : ℝ} (h : κ < s) : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < s - κ - κ * s ^ 2 * t ^ 2 / 4 := by
  have hc : Continuous fun t : ℝ => s - κ - κ * s ^ 2 * t ^ 2 / 4 := by fun_prop
  have := hc.tendsto 0
  simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero, zero_div, sub_zero] at this
  exact nhdsWithin_le_nhds (this.eventually (lt_mem_nhds (by linarith)))

/-- Below a higher curvature `s < κ`, for small `t`. -/
theorem eventually_hornPt_neg {κ s : ℝ} (h : s < κ) : ∀ᶠ t in 𝓝[>] (0 : ℝ), s - κ - κ * s ^ 2 * t ^ 2 / 4 < 0 := by
  have hc : Continuous fun t : ℝ => s - κ - κ * s ^ 2 * t ^ 2 / 4 := by fun_prop
  have := hc.tendsto 0
  simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero, zero_div, sub_zero] at this
  exact nhdsWithin_le_nhds (this.eventually (gt_mem_nhds (by linarith)))

/-- **A point of a horn at a prescribed height**: for `κ₁ < s < κ₂` there are horn points arbitrarily near the vertex on the
parabola `y = s x²/2`, which lie above every arc of curvature `m < s` and below every arc of curvature `m > s`. -/
theorem exists_mem_hornSet_aboveBelow (v : ℂ) (α : ℝ) {κ₁ κ₂ s m r : ℝ} (hr : 0 < r) (h1 : κ₁ < s) (h2 : s < κ₂)
    (hm : m ≠ s) :
    ∃ z ∈ hornSet v α κ₁ κ₂ r, (m < s → TanAbove v α m z) ∧ (s < m → TanBelow v α m z) := by
  have hc : Continuous fun t : ℝ => framePt v α t (s * t ^ 2 / 2) := by unfold framePt; fun_prop
  have hdist : ∀ᶠ t in 𝓝 (0 : ℝ), dist (framePt v α t (s * t ^ 2 / 2)) v < r := by
    have := hc.tendsto 0
    have h0 : framePt v α 0 (s * 0 ^ 2 / 2) = v := by simp [framePt]
    rw [h0] at this
    exact (Metric.tendsto_nhds.mp this) r hr
  have e1 := eventually_hornPt_pos h1
  have e2 := eventually_hornPt_neg h2
  have e3 : ∀ᶠ t in 𝓝[>] (0 : ℝ), (m < s → 0 < s - m - m * s ^ 2 * t ^ 2 / 4) ∧ (s < m → s - m - m * s ^ 2 * t ^ 2 / 4 < 0) := by
    rcases lt_or_gt_of_ne hm with hlt | hgt
    · filter_upwards [eventually_hornPt_pos hlt] with t ht
      exact ⟨fun _ => ht, fun h => absurd h (not_lt.mpr hlt.le)⟩
    · filter_upwards [eventually_hornPt_neg hgt] with t ht
      exact ⟨fun h => absurd h (not_lt.mpr hgt.le), fun _ => ht⟩
  have hall : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < s - κ₁ - κ₁ * s ^ 2 * t ^ 2 / 4 ∧ s - κ₂ - κ₂ * s ^ 2 * t ^ 2 / 4 < 0 ∧
      ((m < s → 0 < s - m - m * s ^ 2 * t ^ 2 / 4) ∧ (s < m → s - m - m * s ^ 2 * t ^ 2 / 4 < 0)) ∧ t ∈ Ioi (0 : ℝ) ∧
      dist (framePt v α t (s * t ^ 2 / 2)) v < r := by
    filter_upwards [e1, e2, e3, eventually_mem_nhdsWithin, hdist.filter_mono nhdsWithin_le_nhds] with t a b c d e
    exact ⟨a, b, c, d, e⟩
  obtain ⟨t, ht1, ht2, ht3, ht0, hd⟩ := hall.exists
  have ht0' : 0 < t := ht0
  have hX : frameX v α (framePt v α t (s * t ^ 2 / 2)) = t := frameX_framePt v α _ _
  have hY : frameY v α (framePt v α t (s * t ^ 2 / 2)) = s * t ^ 2 / 2 := frameY_framePt v α _ _
  have hpos : 0 < t ^ 2 / 2 := by positivity
  refine ⟨framePt v α t (s * t ^ 2 / 2), ⟨hd, by rw [hX]; exact ht0', ?_, ?_⟩, ?_, ?_⟩
  · unfold TanAbove; rw [hX, hY, tanHeight_hornPt]; exact mul_pos hpos ht1
  · unfold TanBelow; rw [hX, hY, tanHeight_hornPt]; exact mul_neg_of_pos_of_neg hpos ht2
  · intro h; unfold TanAbove; rw [hX, hY, tanHeight_hornPt]; exact mul_pos hpos (ht3.1 h)
  · intro h; unfold TanBelow; rw [hX, hY, tanHeight_hornPt]; exact mul_neg_of_pos_of_neg hpos (ht3.2 h)

/-- A direction `β` with `e β · u < 0` exists for every `u ≠ 0` (the direction of `−u`). -/
theorem exists_dir_dot_neg {u : ℂ} (hu : u ≠ 0) : ∃ β : ℝ, dot (e β) u < 0 := by
  refine ⟨Complex.arg (-u), ?_⟩
  have hn : (‖-u‖ : ℂ) * e (Complex.arg (-u)) = -u := by
    simpa [e] using Complex.norm_mul_exp_arg_mul_I (-u)
  have hpos : 0 < ‖u‖ := norm_pos_iff.2 hu
  have he : e (Complex.arg (-u)) = (-u) / (‖u‖ : ℂ) := by
    rw [norm_neg] at hn
    have : (‖u‖ : ℂ) ≠ 0 := by exact_mod_cast hpos.ne'
    field_simp
    rw [mul_comm]; exact hn
  unfold dot
  rw [he, div_mul_eq_mul_div, neg_mul, Complex.mul_conj, Complex.normSq_eq_norm_sq]
  have : ((-(((‖u‖ ^ 2 : ℝ) : ℂ)) / (‖u‖ : ℂ))).re = -‖u‖ := by
    rw [← Complex.ofReal_neg, ← Complex.ofReal_div, Complex.ofReal_re]
    field_simp
  rw [this]; linarith

/-- Turning a unit vector by `e s`: for `‖ζ‖ = 1`, `‖1 + ζ (e s − 1)‖² = 1 + 2 (1 − cos s)(1 − Re ζ) − 2 Im ζ sin s`. -/
theorem sq_norm_one_add_mul_e_sub_one {ζ : ℂ} (hζ : ‖ζ‖ = 1) (s : ℝ) :
    ‖1 + ζ * (e s - 1)‖ ^ 2 = 1 + 2 * (1 - Real.cos s) * (1 - ζ.re) - 2 * ζ.im * Real.sin s := by
  have h1 : ζ.re * ζ.re + ζ.im * ζ.im = 1 := by
    have := congrArg (· ^ 2) hζ
    simpa only [Complex.sq_norm, Complex.normSq_apply, one_pow] using this
  have h2 := Real.cos_sq_add_sin_sq s
  rw [Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.sub_re, Complex.sub_im,
    Complex.one_re, Complex.one_im, re_e, im_e]
  linear_combination (Real.cos s ^ 2 + Real.sin s ^ 2 - 2 * Real.cos s + 1) * h1 + h2

/-- A unit `ζ ≠ 1` has real part below `1`. -/
theorem re_lt_one_of_norm_eq_one {ζ : ℂ} (hζ : ‖ζ‖ = 1) (h1 : ζ ≠ 1) : ζ.re < 1 := by
  have hn : ζ.re * ζ.re + ζ.im * ζ.im = 1 := by
    have := congrArg (· ^ 2) hζ
    simpa only [Complex.sq_norm, Complex.normSq_apply, one_pow] using this
  by_contra h
  push Not at h
  have him : ζ.im = 0 := by nlinarith [mul_self_nonneg ζ.im]
  have hre : ζ.re = 1 := by nlinarith [mul_self_nonneg ζ.im]
  exact h1 (Complex.ext (by simp [hre]) (by simp [him]))

/-- `‖e s − 1‖ ≤ |s|`. -/
theorem norm_e_sub_one_le (s : ℝ) : ‖e s - 1‖ ≤ |s| := by
  simpa [show e 0 = 1 by simp [e]] using norm_e_sub_e_le s 0

/-- **Off the centre, a unit circle through `w` leaves the closed disc of `ω(P)`**: for `‖ζ‖ = 1`, `ζ ≠ 1`, some turn `e s`
within `ε` of `1` puts `1 + ζ (e s − 1)` strictly outside the unit circle. -/
theorem exists_e_outside {ζ : ℂ} (hζ : ‖ζ‖ = 1) (h1 : ζ ≠ 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ s, ‖e s - 1‖ < ε ∧ 1 < ‖1 + ζ * (e s - 1)‖ := by
  have hπ := Real.pi_gt_three
  set s₀ := min (ε / 2) 1 with hs₀
  have hs0 : 0 < s₀ := lt_min (half_pos hε) one_pos
  have hs1 : s₀ ≤ 1 := min_le_right _ _
  have hs2 : s₀ < ε := lt_of_le_of_lt (min_le_left _ _) (half_lt_self hε)
  have hsin : 0 < Real.sin s₀ := Real.sin_pos_of_pos_of_lt_pi hs0 (by linarith)
  have hcos : Real.cos s₀ < 1 := by
    have := Real.cos_sq_add_sin_sq s₀
    have hc1 := Real.cos_le_one s₀
    by_contra h
    push Not at h
    nlinarith [mul_pos hsin hsin]
  have hre := re_lt_one_of_norm_eq_one hζ h1
  set s : ℝ := if 0 < ζ.im then -s₀ else s₀ with hsdef
  have habs : |s| = s₀ := by
    rw [hsdef]; split_ifs <;> simp [abs_of_pos hs0]
  have hcs : Real.cos s = Real.cos s₀ := by rw [hsdef]; split_ifs <;> simp [Real.cos_neg]
  have hterm : 0 ≤ -(ζ.im * Real.sin s) := by
    rw [hsdef]; split_ifs with h
    · rw [Real.sin_neg]; nlinarith
    · push Not at h; nlinarith
  refine ⟨s, lt_of_le_of_lt (norm_e_sub_one_le s) (by rw [habs]; exact hs2), ?_⟩
  have hsq := sq_norm_one_add_mul_e_sub_one hζ s
  rw [hcs] at hsq
  have : 1 < ‖1 + ζ * (e s - 1)‖ ^ 2 := by
    rw [hsq]; nlinarith [mul_pos (sub_pos.mpr hcos) (sub_pos.mpr hre)]
  nlinarith [norm_nonneg (1 + ζ * (e s - 1))]

/-- **Off both centres, a unit circle through `w` enters the open disc of `ω(P)`**: for `‖ζ‖ = 1`, `ζ ≠ ±1` (transversality),
some turn `e s` within `ε` of `1` puts `1 + ζ (e s − 1)` strictly inside the unit circle. -/
theorem exists_e_inside {ζ : ℂ} (hζ : ‖ζ‖ = 1) (h1 : ζ ≠ 1) (h2 : ζ ≠ -1) {ε : ℝ} (hε : 0 < ε) :
    ∃ s, ‖e s - 1‖ < ε ∧ ‖1 + ζ * (e s - 1)‖ < 1 := by
  have hπ := Real.pi_gt_three
  have hπ4 := Real.pi_lt_four
  have hn : ζ.re * ζ.re + ζ.im * ζ.im = 1 := by
    have := congrArg (· ^ 2) hζ
    simpa only [Complex.sq_norm, Complex.normSq_apply, one_pow] using this
  have hb : ζ.im ≠ 0 := by
    intro hb
    have : ζ.re = 1 ∨ ζ.re = -1 := by
      have : (ζ.re - 1) * (ζ.re + 1) = 0 := by rw [hb] at hn; nlinarith
      rcases mul_eq_zero.mp this with h | h
      · left; linarith
      · right; linarith
    rcases this with h | h
    · exact h1 (Complex.ext (by simp [h]) (by simp [hb]))
    · exact h2 (Complex.ext (by simp [h]) (by simp [hb]))
  have hbpos : 0 < |ζ.im| := abs_pos.mpr hb
  have hb1 : |ζ.im| ≤ 1 := by
    rw [abs_le]; constructor <;> nlinarith [mul_self_nonneg ζ.re, mul_self_nonneg (ζ.im + 1), mul_self_nonneg (ζ.im - 1)]
  have hre1 : -1 ≤ ζ.re := by nlinarith [mul_self_nonneg ζ.im, mul_self_nonneg (ζ.re + 1)]
  set s₀ := min (min (ε / 2) 1) (|ζ.im| / 4) with hs₀
  have hs0 : 0 < s₀ := lt_min (lt_min (half_pos hε) one_pos) (by positivity)
  have hs1 : s₀ ≤ 1 := (min_le_left _ _).trans (min_le_right _ _)
  have hs2 : s₀ < ε := lt_of_le_of_lt ((min_le_left _ _).trans (min_le_left _ _)) (half_lt_self hε)
  have hs3 : s₀ ≤ |ζ.im| / 4 := min_le_right _ _
  have hsin : 2 / π * s₀ ≤ Real.sin s₀ := Real.mul_le_sin hs0.le (by linarith)
  have hsin' : s₀ / 2 ≤ Real.sin s₀ := by
    have : s₀ / 2 ≤ 2 / π * s₀ := by
      rw [div_mul_eq_mul_div, le_div_iff₀ (by linarith)]; nlinarith
    linarith
  have hcos : 1 - s₀ ^ 2 / 2 ≤ Real.cos s₀ := Real.one_sub_sq_div_two_le_cos
  set s : ℝ := if 0 < ζ.im then s₀ else -s₀ with hsdef
  have habs : |s| = s₀ := by
    rw [hsdef]; split_ifs <;> simp [abs_of_pos hs0]
  have hcs : Real.cos s = Real.cos s₀ := by rw [hsdef]; split_ifs <;> simp [Real.cos_neg]
  have hterm : ζ.im * Real.sin s = |ζ.im| * Real.sin s₀ := by
    rw [hsdef]; split_ifs with h
    · rw [abs_of_pos h]
    · push Not at h
      rw [abs_of_neg (lt_of_le_of_ne h hb), Real.sin_neg]; ring
  refine ⟨s, lt_of_le_of_lt (norm_e_sub_one_le s) (by rw [habs]; exact hs2), ?_⟩
  have hsq := sq_norm_one_add_mul_e_sub_one hζ s
  rw [hcs, mul_assoc 2 ζ.im, hterm] at hsq
  have : ‖1 + ζ * (e s - 1)‖ ^ 2 < 1 := by
    rw [hsq]
    have h1c : 1 - Real.cos s₀ ≤ s₀ ^ 2 / 2 := by linarith
    have h1c' : 0 ≤ 1 - Real.cos s₀ := by linarith [Real.cos_le_one s₀]
    have hre2 : 1 - ζ.re ≤ 2 := by linarith
    have : 2 * (1 - Real.cos s₀) * (1 - ζ.re) ≤ 2 * s₀ ^ 2 := by nlinarith
    nlinarith [mul_le_mul_of_nonneg_left hsin' hbpos.le]
  nlinarith [norm_nonneg (1 + ζ * (e s - 1))]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- At a point of the domain, some tile approaches in a direction `β` with `e β · u < 0`, for any `u ≠ 0`. -/
theorem exists_tile_cone_dot_neg {A u : ℂ} (hA : A ∈ F.dom) (hu : u ≠ 0) :
    ∃ T, F.IsTile T ∧ ∃ β ∈ coneAt T A, dot (e β) u < 0 := by
  obtain ⟨β, hβ⟩ := exists_dir_dot_neg hu
  obtain ⟨c, hc⟩ := F.exists_mem_coneAt_region hA β
  rw [F.coneAt_region_eq_biUnion hA c] at hc
  simp only [mem_iUnion, mem_setOf_eq] at hc
  obtain ⟨T, ⟨hT, -⟩, hβT⟩ := hc
  exact ⟨T, hT.1, β, hβT, hβ⟩

end ArcMap

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **No class point at unit distance from an open patch of its own closure** (the engine of FS112-LOCK): a point of the
closure of the class of `d` is at distance `≠ 1` from every point of an open set lying in that closure — otherwise a short
radial segment through the point, inside the open set, crosses the unit circle about it (wave 3's crossing engine). -/
theorem Valid.dist_ne_one_of_isOpen_subset_closure (hF : F.Valid) {d : Fin k} {a q : ℂ} {O : Set ℂ}
    (ha : a ∈ closure (F.region d)) (hO : IsOpen O) (hOd : O ⊆ closure (F.region d)) (hq : q ∈ O) :
    dist a q ≠ 1 := by
  intro h1
  obtain ⟨η, hη, hball⟩ := Metric.isOpen_iff.mp hO q hq
  set τ : ℝ := min (η / 2) (1 / 2) with hτ
  have hτ0 : 0 < τ := lt_min (half_pos hη) (by norm_num)
  have hτη : τ < η := lt_of_le_of_lt (min_le_left _ _) (half_lt_self hη)
  have hτ1 : τ < 1 := lt_of_le_of_lt (min_le_right _ _) (by norm_num)
  have haq : ‖a - q‖ = 1 := by rw [← dist_eq_norm]; exact h1
  set u := q + (τ : ℂ) * (a - q) with hu
  set v := q - (τ : ℂ) * (a - q) with hv
  have hub : u ∈ ball q η := by
    rw [mem_ball, dist_eq_norm, show u - q = (τ : ℂ) * (a - q) by rw [hu]; ring, norm_mul, haq, Complex.norm_real,
      Real.norm_eq_abs, abs_of_pos hτ0, mul_one]
    exact hτη
  have hvb : v ∈ ball q η := by
    rw [mem_ball, dist_eq_norm, show v - q = -((τ : ℂ) * (a - q)) by rw [hv]; ring, norm_neg, norm_mul, haq,
      Complex.norm_real, Real.norm_eq_abs, abs_of_pos hτ0, mul_one]
    exact hτη
  have hS : segment ℝ u v ⊆ closure (F.region d) :=
    ((convex_ball q η).segment_subset hub hvb).trans (hball.trans hOd)
  refine hF.false_of_crossing ha (convex_segment u v).isPreconnected hS (left_mem_segment ℝ u v)
    (right_mem_segment ℝ u v) ?_ ?_
  · rw [dist_eq_norm, show a - u = ((1 - τ : ℝ) : ℂ) * (a - q) by rw [hu]; push_cast; ring, norm_mul, haq,
      Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith), mul_one]
    linarith
  · rw [dist_eq_norm, show a - v = ((1 + τ : ℝ) : ℂ) * (a - q) by rw [hv]; push_cast; ring, norm_mul, haq,
      Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith), mul_one]
    linarith

/-- The unit circle about `y ∈ ω(w)`, turned at `w` by `e s`: the point `q = w + (w − y)(e s − 1)` lies on `ω(y)`, at distance
`‖e s − 1‖` from `w`, and at distance `‖1 + ζ (e s − 1)‖` from `P` when `‖w − P‖ = 1`, `ζ = conj(w − P)(w − y)`. -/
theorem unit_circle_turn {P w y : ℂ} (hwP : ‖w - P‖ = 1) (hy : ‖w - y‖ = 1) (s : ℝ) :
    dist y (w + (w - y) * (e s - 1)) = 1 ∧ ‖w + (w - y) * (e s - 1) - w‖ = ‖e s - 1‖ ∧
      ‖w + (w - y) * (e s - 1) - P‖ = ‖1 + (starRingEnd ℂ (w - P) * (w - y)) * (e s - 1)‖ := by
  have hu : (w - P) * starRingEnd ℂ (w - P) = 1 := by
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hwP]; norm_num
  refine ⟨?_, ?_, ?_⟩
  · rw [dist_eq_norm, show y - (w + (w - y) * (e s - 1)) = -((w - y) * e s) by ring, norm_neg, norm_mul, hy, norm_e,
      one_mul]
  · rw [add_sub_cancel_left, norm_mul, hy, one_mul]
  · have : w + (w - y) * (e s - 1) - P = (w - P) * (1 + (starRingEnd ℂ (w - P) * (w - y)) * (e s - 1)) := by
      linear_combination (-(w - y) * (e s - 1)) * hu
    rw [this, norm_mul, hwP, one_mul]

/-- **FS112-LOCK**: for `w = r(θ)` interior to a unit arc of `ω(P)`, a tile of the outer colour touches `ω(w)` only at `P`; a
tile of the inner colour only at `P` or at `P + 2e(θ)`, and a tile of the inner colour touching at `P + 2e(θ)` approaches it from outside
`B(P, 2)`: near `P + 2e(θ)` it misses `B(P, 2)` (the row's "from outside `B(P, 2)`", `plans/FS112-derivation.md` l. 72; the whole-tile form
`Disjoint T (ball P 2)` first stated here was stronger than the row and fails for short arcs — inventory item 177, FS131-I4d's
counter-configuration). (Class form for the touching sets: no point of either class's closure on `ω(w)` elsewhere.) -/
theorem lock (hF : F.Valid) {P : ℂ} {θ₁ θ₂ θ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') (hθ : θ ∈ Ioo θ₁ θ₂) :
    closure (F.region c') ∩ sphere (ringPt P θ) 1 ⊆ {P} ∧
      closure (F.region c) ∩ sphere (ringPt P θ) 1 ⊆ {P, P + 2 * e θ} ∧
      ∀ T, F.TileOf c T → P + 2 * e θ ∈ closure T → ∃ δ > 0, Disjoint (T ∩ ball (P + 2 * e θ) δ) (ball P 2) := by
  set w := ringPt P θ with hw
  have hwd : w ∈ F.dom := (hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩).1
  obtain ⟨hin, hout⟩ := hA.2.2 θ hθ
  obtain ⟨εi, hεi, hballi⟩ := F.side_ball_subset_closure (O := ball P 1) isOpen_ball hwd (c := c) fun d hd => by
    have : d ∈ F.innerColours P w := hd
    rw [hin] at this; exact this
  obtain ⟨εo, hεo, hballo⟩ := F.side_ball_subset_closure (O := (closedBall P 1)ᶜ) isClosed_closedBall.isOpen_compl hwd
    (c := c') fun d hd => by
    have : d ∈ F.outerColours P w := by
      show w ∈ closure (F.region d \ closedBall P 1)
      rwa [Set.sdiff_eq]
    rw [hout] at this; exact this
  have hwP : ‖w - P‖ = 1 := by rw [hw, ringPt, add_sub_cancel_left, norm_e]
  have hwe : w - P = e θ := by rw [hw, ringPt, add_sub_cancel_left]
  -- `ζ` for a point `y ∈ ω(w)`
  have hζn : ∀ y, ‖w - y‖ = 1 → ‖starRingEnd ℂ (w - P) * (w - y)‖ = 1 := fun y hy => by
    rw [norm_mul, Complex.norm_conj, hwP, hy, one_mul]
  have hζ1 : ∀ y, y ≠ P → starRingEnd ℂ (w - P) * (w - y) ≠ 1 := by
    intro y hyP h
    apply hyP
    have hu : (w - P) * starRingEnd ℂ (w - P) = 1 := by
      rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hwP]; norm_num
    have : w - y = w - P := by linear_combination -(w - y) * hu + (w - P) * h
    linear_combination -this
  have hζ2 : ∀ y, y ≠ P + 2 * e θ → starRingEnd ℂ (w - P) * (w - y) ≠ -1 := by
    intro y hyP h
    apply hyP
    have hu : (w - P) * starRingEnd ℂ (w - P) = 1 := by
      rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hwP]; norm_num
    have : w - y = -(w - P) := by linear_combination -(w - y) * hu + (w - P) * h
    rw [← hwe]; linear_combination -this
  refine ⟨?_, ?_, ?_⟩
  · -- clause 1: the outer colour
    rintro y ⟨hy, hyw⟩
    rw [mem_sphere, dist_comm, dist_eq_norm] at hyw
    rw [mem_singleton_iff]
    by_contra hyP
    obtain ⟨s, hs, hout'⟩ := exists_e_outside (hζn y hyw) (hζ1 y hyP) hεo
    obtain ⟨hq1, hqw, hqP⟩ := unit_circle_turn hwP hyw s
    refine hF.dist_ne_one_of_isOpen_subset_closure hy (isOpen_ball.inter isClosed_closedBall.isOpen_compl) hballo ⟨?_, ?_⟩ hq1
    · rw [mem_ball, dist_eq_norm, hqw]; exact hs
    · rw [mem_compl_iff, mem_closedBall, dist_eq_norm, hqP, not_le]; exact hout'
  · -- clause 2: the inner colour
    rintro y ⟨hy, hyw⟩
    rw [mem_sphere, dist_comm, dist_eq_norm] at hyw
    by_contra hyP
    simp only [mem_insert_iff, mem_singleton_iff, not_or] at hyP
    obtain ⟨s, hs, hin'⟩ := exists_e_inside (hζn y hyw) (hζ1 y hyP.1) (hζ2 y hyP.2) hεi
    obtain ⟨hq1, hqw, hqP⟩ := unit_circle_turn hwP hyw s
    refine hF.dist_ne_one_of_isOpen_subset_closure hy (isOpen_ball.inter isOpen_ball) hballi ⟨?_, ?_⟩ hq1
    · rw [mem_ball, dist_eq_norm, hqw]; exact hs
    · rw [mem_ball, dist_eq_norm, hqP]; exact hin'
  · -- clause 3: an inner tile near `P + 2e(θ)` stays outside `B(P, 2)`
    intro T hT _
    set y := P + 2 * e θ with hy
    refine ⟨min (εi / 4) 1, lt_min (by linarith) one_pos, ?_⟩
    rw [Set.disjoint_left]
    rintro t ⟨htT, htδ⟩ htP
    rw [mem_ball, dist_eq_norm] at htδ htP
    have htδ1 : ‖t - y‖ < εi / 4 := lt_of_lt_of_le htδ (min_le_left _ _)
    have htδ2 : ‖t - y‖ < 1 := lt_of_lt_of_le htδ (min_le_right _ _)
    have hyP : ‖y - P‖ = 2 := by rw [hy, add_sub_cancel_left, norm_mul, norm_e]; norm_num
    set r := ‖t - P‖ with hr
    have hrd : |2 - r| ≤ ‖t - y‖ := by
      rw [← hyP, norm_sub_rev t y]
      calc |‖y - P‖ - ‖t - P‖| ≤ ‖(y - P) - (t - P)‖ := abs_norm_sub_norm_le _ _
        _ = ‖y - t‖ := by congr 1; ring
    have hr1 : 1 < r := by have := (abs_lt.mp (lt_of_le_of_lt hrd htδ2)).2; linarith
    have hr0 : (r : ℂ) ≠ 0 := by exact_mod_cast (by linarith : r ≠ 0)
    set q := t + (P - t) / (r : ℂ) with hq
    have hq1 : dist t q = 1 := by
      rw [dist_eq_norm, hq, show t - (t + (P - t) / (r : ℂ)) = (t - P) / (r : ℂ) by ring, norm_div, Complex.norm_real,
        Real.norm_eq_abs, abs_of_pos (by linarith), ← hr, div_self (by linarith)]
    have hqP : ‖q - P‖ = r - 1 := by
      rw [hq, show t + (P - t) / (r : ℂ) - P = (t - P) * (((r - 1) / r : ℝ) : ℂ) by push_cast; field_simp; ring,
        norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by apply div_pos <;> linarith), ← hr]
      field_simp
    have hv : ‖t - P - (r : ℂ) * e θ‖ ≤ 2 * ‖t - y‖ := by
      calc ‖t - P - (r : ℂ) * e θ‖ = ‖(t - y) + ((2 - r : ℝ) : ℂ) * e θ‖ := by
              congr 1; rw [hy]; push_cast; ring
        _ ≤ ‖t - y‖ + |2 - r| := by
              refine (norm_add_le _ _).trans ?_
              rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
        _ ≤ 2 * ‖t - y‖ := by linarith
    have hqw : ‖q - w‖ < εi := by
      have heq : q - w = (((r - 1) / r : ℝ) : ℂ) * (t - P - (r : ℂ) * e θ) + ((r - 2 : ℝ) : ℂ) * e θ := by
        rw [hq, hw, ringPt]; push_cast; field_simp; ring
      rw [heq]
      have hc : (r - 1) / r < 1 := by rw [div_lt_one (by linarith)]; linarith
      have hc0 : 0 < (r - 1) / r := div_pos (by linarith) (by linarith)
      calc ‖(((r - 1) / r : ℝ) : ℂ) * (t - P - (r : ℂ) * e θ) + ((r - 2 : ℝ) : ℂ) * e θ‖
          ≤ (r - 1) / r * ‖t - P - (r : ℂ) * e θ‖ + |r - 2| := by
            refine (norm_add_le _ _).trans ?_
            rw [norm_mul, norm_mul, norm_e, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
              Real.norm_eq_abs, abs_of_pos hc0]
        _ ≤ 1 * (2 * ‖t - y‖) + ‖t - y‖ := by
            have := mul_le_mul hc.le hv (norm_nonneg _) zero_le_one
            rw [abs_sub_comm]; linarith
        _ < εi := by linarith
    refine hF.dist_ne_one_of_isOpen_subset_closure (subset_closure (hT.subset_region htT)) (isOpen_ball.inter isOpen_ball) hballi
      ⟨?_, ?_⟩ hq1
    · rw [mem_ball, dist_eq_norm]; exact hqw
    · rw [mem_ball, dist_eq_norm, hqP]; linarith

/-- **FS112-N2-BENDS**, its lemma N2-SIGN: every interior point of a side colour's class is within `< 1` of every interior
point of the arc, or farther than `1` from every one. -/
theorem n2_sign (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' d : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') (hd : d = c ∨ d = c')
    {z : ℂ} (hz : z ∈ F.region d) :
    (∀ θ ∈ Ioo θ₁ θ₂, dist z (ringPt P θ) < 1) ∨ ∀ θ ∈ Ioo θ₁ θ₂, 1 < dist z (ringPt P θ) := by
  have hmem : ∀ θ ∈ Ioo θ₁ θ₂, ringPt P θ ∈ closure (F.region d) := by
    intro θ hθ
    obtain ⟨hin, hout⟩ := hA.2.2 θ hθ
    rcases hd with rfl | rfl
    · have : d ∈ F.innerColours P (ringPt P θ) := by rw [hin]; rfl
      exact closure_mono inter_subset_left this
    · have : d ∈ F.outerColours P (ringPt P θ) := by rw [hout]; rfl
      exact closure_mono sdiff_subset this
  have hne : ∀ θ ∈ Ioo θ₁ θ₂, dist z (ringPt P θ) ≠ 1 := fun θ hθ => ne1_region hF (hmem θ hθ) hz
  have hcont : Continuous fun θ : ℝ => dist z (ringPt P θ) := by
    unfold ringPt e; fun_prop
  by_cases h : ∀ θ ∈ Ioo θ₁ θ₂, dist z (ringPt P θ) < 1
  · exact Or.inl h
  · right
    push Not at h
    obtain ⟨a, ha, ha1⟩ := h
    have ha' : 1 < dist z (ringPt P a) := lt_of_le_of_ne ha1 (Ne.symm (hne a ha))
    intro b hb
    by_contra hb1
    rw [not_lt] at hb1
    have hb' : dist z (ringPt P b) < 1 := lt_of_le_of_ne hb1 (hne b hb)
    obtain ⟨c, hc, hc1⟩ := (isPreconnected_Ioo (a := θ₁) (b := θ₂)).intermediate_value hb ha hcont.continuousOn
      ⟨hb'.le, ha'.le⟩
    exact hne c hc hc1

/-- **FS114-L60-LE**, its first clause: a unit arc with constant sides has angular length at most `60°` (its ends lie in the
closure of the outer colour's tiles along it, a chain of diameter at most `1`). -/
theorem l60_le (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') : θ₂ - θ₁ ≤ π / 3 := by
  sorry

/-- **FS112-N3-NOBOTH**: the centre of a both-kind unit arc, a point of the domain, carries at least four colours or a repeated
colour. (`P ∈ F.dom` is the hypothesis FS116-V5-U1's last clauses need, wave 3's finding.) -/
theorem noBoth (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} (hP : P ∈ F.dom) (hA : F.BothKind P θ₁ θ₂) :
    4 ≤ (F.coloursAt P).ncard ∨ F.HasRepeatedColour P := by
  sorry

/-! ## FS112-U1, its shadow clause -/

/-- The parameter of a centre on the ray from `P` along `e β`: `t` for `P + t e β`. -/
noncomputable def rayParam (P : ℂ) (β : ℝ) : Arc → ℝ
  | .seg _ _ => 0
  | .circ c _ _ _ => ((c - P) * starRingEnd ℂ (e β)).re

theorem rayParam_circ (P : ℂ) (β t ρ θa θb : ℝ) : rayParam P β (.circ (P + (t : ℂ) * e β) ρ θa θb) = t := by
  simp only [rayParam, add_sub_cancel_left, mul_assoc, conj_e_mul_e, mul_one, Complex.ofReal_re]

/-- A segment carries no centre: its parameter is `0`. -/
example : rayParam 0 0 (.seg 0 1) = 0 := rfl

/-- **FS112-U1**, the shadow clause (its first three clauses are wave 3's `ringArc_cone_inner`, `ringArc_cone_outer`,
`ringArc_sideCone_inner`, `ringArc_sideCone_outer` — FS116-V5-U1's, by SR1-6.2 item 4): the outer side's first-order shadow near
`P` contains the open facing cone `(θ₁ − 90°, θ₂ + 90°)` of width `π + ℓ`. For every direction `β` of it and every `ε > 0`, the points
`P + t e(β)`, `t > 0` small, are at distance exactly `1` from a point of the outer colour's class outside `B̄(P, 1)` within `ε` of the arc
(so from the outer tile beside the arc, for `ε` small). No validity is read. -/
theorem u1_shadow {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {β : ℝ}
    (hβ : β ∈ Ioo (θ₁ - π / 2) (θ₂ + π / 2)) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ t : ℝ in 𝓝[>] 0,
      P + (t : ℂ) * e β ∈ shadow ((F.region c' ∩ thickening ε (ringArc P θ₁ θ₂)) \ closedBall P 1) := by
  obtain ⟨h12, hΓ, hside⟩ := hA
  have hπ := Real.pi_pos
  -- the arc point `w = r(θ)` facing `e β`
  set θ := (max θ₁ (β - π / 2) + min θ₂ (β + π / 2)) / 2 with hθdef
  have hlo : max θ₁ (β - π / 2) < min θ₂ (β + π / 2) :=
    max_lt (lt_min h12 (by linarith [hβ.1])) (lt_min (by linarith [hβ.2]) (by linarith))
  have hθ : θ ∈ Ioo θ₁ θ₂ :=
    ⟨by linarith [le_max_left θ₁ (β - π / 2)], by linarith [min_le_left θ₂ (β + π / 2)]⟩
  have hcos : 0 < Real.cos (β - θ) := Real.cos_pos_of_mem_Ioo
    ⟨by linarith [min_le_right θ₂ (β + π / 2)], by linarith [le_max_right θ₁ (β - π / 2)]⟩
  set w := ringPt P θ with hw
  have hwarc : w ∈ ringArc P θ₁ θ₂ := ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  have hwd : w ∈ F.dom := (hΓ hwarc).1
  -- the outer patch, the domain, the finitely many arcs near `w`
  obtain ⟨δ₁, hδ₁, hpatch⟩ := F.side_ball_subset_closure (isOpen_compl_iff.mpr isClosed_closedBall) hwd (c := c')
    (fun d hd => by
      have : d ∈ F.outerColours P w := by rw [outerColours, mem_setOf_eq, sdiff_eq]; exact hd
      rw [(hside θ hθ).2] at this; exact this)
  obtain ⟨δ₂, hδ₂, hdom⟩ := Metric.isOpen_iff.mp F.isOpen_dom w hwd
  obtain ⟨tw, htw, hfin⟩ := F.locallyFinite w hwd
  obtain ⟨δ₃, hδ₃, htwb⟩ := Metric.mem_nhds_iff.mp htw
  set A := {a | a ∈ F.arcs ∧ (a.carrier ∩ tw).Nonempty}
  set δ := min (min δ₁ δ₂) (min δ₃ ε) with hδdef
  have hδ : 0 < δ := lt_min (lt_min hδ₁ hδ₂) (lt_min hδ₃ hε)
  have hbad : ((rayParam P β '' A) \ {0}).Finite := (hfin.image _).subset sdiff_subset
  have hev : ∀ᶠ t : ℝ in 𝓝[>] 0, t ∈ Ioo 0 (δ / 2) ∧ t ∉ (rayParam P β '' A) \ {0} :=
    Filter.Eventually.and (Ioo_mem_nhdsGT (by linarith))
      (nhdsWithin_le_nhds (hbad.isClosed.isOpen_compl.mem_nhds (by simp)))
  filter_upwards [hev] with t ⟨⟨ht0, htδ⟩, htbad⟩
  set z := P + (t : ℂ) * e β with hz
  -- the point `q₀ = z + e θ = w + t e β` of `ω(z)`, outside `B̄(P, 1)` and within `t` of `w`
  set U := ball w δ ∩ (closedBall P 1)ᶜ with hU
  have hUo : IsOpen U := isOpen_ball.inter (isOpen_compl_iff.mpr isClosed_closedBall)
  have hq₀ : z + e θ ∈ U := by
    refine ⟨?_, ?_⟩
    · rw [mem_ball, dist_eq_norm, hw, ringPt, hz,
        show P + (t : ℂ) * e β + e θ - (P + e θ) = (t : ℂ) * e β by ring, norm_mul, norm_e, mul_one,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
      linarith
    · rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le, hz, show P + (t : ℂ) * e β + e θ - P = (t : ℂ) * e β + e θ by ring]
      have hsq : ‖(t : ℂ) * e β + e θ‖ ^ 2 = 1 + t ^ 2 + 2 * t * Real.cos (β - θ) := by
        rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
        simp only [Complex.add_re, Complex.add_im, Complex.re_ofReal_mul, Complex.im_ofReal_mul, re_e, im_e, Real.cos_sub]
        nlinarith [Real.cos_sq_add_sin_sq β, Real.cos_sq_add_sin_sq θ]
      have : 1 < ‖(t : ℂ) * e β + e θ‖ ^ 2 := by rw [hsq]; nlinarith
      exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
  obtain ⟨s₀, hs₀, hs₀U⟩ := Metric.isOpen_iff.mp hUo _ hq₀
  -- an injective arc of `ω(z)` inside `U`
  set q : ℝ → ℂ := fun s => z + e (θ + s) with hq
  have hqU : ∀ s ∈ Ioo 0 (min s₀ 1), q s ∈ U := by
    intro s hs
    apply hs₀U
    rw [mem_ball, dist_eq_norm, hq, show z + e (θ + s) - (z + e θ) = e (θ + s) - e θ by ring]
    calc ‖e (θ + s) - e θ‖ ≤ |θ + s - θ| := norm_e_sub_e_le _ _
      _ = s := by rw [add_sub_cancel_left, abs_of_pos hs.1]
      _ < s₀ := hs.2.trans_le (min_le_left _ _)
  have hqinj : InjOn q (Ioo 0 (min s₀ 1)) := by
    intro s hs s' hs' hss
    have h' : e (θ + s) = e (θ + s') := add_left_cancel hss
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp h'
    have hs1 := hs.2.trans_le (min_le_right _ _)
    have hs1' := hs'.2.trans_le (min_le_right _ _)
    have hn0 : n = 0 := by
      have hlt : |(n : ℝ) * (2 * π)| < 2 * π := by
        rw [show (n : ℝ) * (2 * π) = s - s' by linarith, abs_lt]; constructor <;> linarith [hs.1, hs'.1, Real.pi_gt_three]
      rw [abs_mul, abs_of_pos (by positivity : (0:ℝ) < 2 * π)] at hlt
      have : |(n : ℝ)| < 1 := by nlinarith
      have h1 : (-1 : ℝ) < n := (abs_lt.mp this).1
      have h2 : (n : ℝ) < 1 := (abs_lt.mp this).2
      have h1' : -1 < n := by exact_mod_cast h1
      have h2' : n < 1 := by exact_mod_cast h2
      omega
    rw [hn0] at hn; simp at hn; linarith
  have hQinf : (q '' Ioo 0 (min s₀ 1)).Infinite := (Ioo_infinite (lt_min hs₀ one_pos)).image hqinj
  -- finitely many points of `ω(z)` lie on arcs near `w`
  have hfin2 : (⋃ a ∈ A, a.carrier ∩ sphere z 1).Finite := by
    refine hfin.biUnion fun a ha => ?_
    rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha.1) z with h | ⟨θa, θb, rfl⟩
    · exact h
    · exfalso
      refine htbad ⟨⟨_, ha, rayParam_circ P β t 1 θa θb⟩, ?_⟩
      simp only [mem_singleton_iff]; exact ht0.ne'
  obtain ⟨_, ⟨s, hs, rfl⟩, hsn⟩ := (hQinf.sdiff hfin2).nonempty
  have hqs := hqU s hs
  have hqsph : q s ∈ sphere z 1 := by simp [hq]
  have hqb : dist (q s) w < δ := hqs.1
  have hqint : q s ∈ F.interiorPts := by
    refine ⟨hdom (lt_of_lt_of_le hqb ((min_le_left _ _).trans (min_le_right _ _))), fun hmem => hsn ?_⟩
    obtain ⟨a, ha, hqa⟩ := mem_iUnion₂.mp hmem
    have hqtw : q s ∈ tw := htwb (lt_of_lt_of_le hqb ((min_le_right _ _).trans (min_le_left _ _)))
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, q s, hqa, hqtw⟩, hqa, hqsph⟩
  have hqcl : q s ∈ closure (F.region c') :=
    hpatch ⟨lt_of_lt_of_le hqb ((min_le_left _ _).trans (min_le_left _ _)), hqs.2⟩
  refine ⟨q s, ⟨⟨⟨hqint, col_eq_of_mem_closure_region hqint hqcl⟩, ?_⟩, hqs.2⟩, ?_⟩
  · exact Metric.mem_thickening_iff.mpr ⟨w, hwarc, lt_of_lt_of_le hqb ((min_le_right _ _).trans (min_le_right _ _))⟩
  · rw [dist_comm]; exact hqsph

/-! ## FS114-L60-LE: the equality case and its fragment -/

/-- `Reul(X, Y, Z)`: the intersection of the closed unit discs about `X`, `Y`, `Z` (a Reuleaux triangle of width `1` when the three
points are pairwise `1` apart). -/
def reul (X Y Z : ℂ) : Set ℂ := closedBall X 1 ∩ closedBall Y 1 ∩ closedBall Z 1

/-- **FS114-L60-LE**, L60-EQ, the inner side: at `ℓ = 60°` every tile of the inner colour touching the open arc from inside lies in
`Reul(P, A, B)` (`A`, `B` the arc's ends). -/
theorem l60_eq_inner (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c')
    {T : Set ℂ} (hT : F.TileOf c T) (htouch : ∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T ∩ ball P 1)) :
    T ⊆ reul P (ringPt P θ₁) (ringPt P (θ₁ + π / 3)) := by
  sorry

/-- **FS114-L60-LE**, L60-EQ, the outer side: at `ℓ = 60°` every tile of the outer colour touching the open arc from outside lies in
the Reuleaux cap `Reul(A, B, C) ∖ B̄(P, 1)`, `C = A + B − P`. -/
theorem l60_eq_outer (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c')
    {T : Set ℂ} (hT : F.TileOf c' T) (htouch : ∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T \ closedBall P 1)) :
    T ⊆ reul (ringPt P θ₁) (ringPt P (θ₁ + π / 3)) (ringPt P θ₁ + ringPt P (θ₁ + π / 3) - P) \ closedBall P 1 := by
  sorry

/-- **FS114-L60-LE**, L60-EQ at the ends: such inner tiles approach the end `A = r(θ₁)` only within the corner cone
`[θ₁ + 90°, θ₁ + 210°]` (120°) and outer ones within `[θ₁ + 30°, θ₁ + 90°]` (60°) — together the closed half-plane facing the other end;
at `B = r(θ₁ + 60°)` the mirror cones `[θ₁ + 210°, θ₁ + 330°]` and `[θ₁ − 30°, θ₁ + 30°]`. -/
theorem l60_eq_corners (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c') :
    (∀ T, F.TileOf c T → (∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T ∩ ball P 1)) →
      coneAt T (ringPt P θ₁) ⊆ angleIcc (θ₁ + π / 2) (θ₁ + 7 * π / 6) ∧
        coneAt T (ringPt P (θ₁ + π / 3)) ⊆ angleIcc (θ₁ + 7 * π / 6) (θ₁ + 11 * π / 6)) ∧
    ∀ T, F.TileOf c' T → (∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T \ closedBall P 1)) →
      coneAt T (ringPt P θ₁) ⊆ angleIcc (θ₁ + π / 6) (θ₁ + π / 2) ∧
        coneAt T (ringPt P (θ₁ + π / 3)) ⊆ angleIcc (θ₁ - π / 6) (θ₁ + π / 6) := by
  sorry

/-- **FS114-L60-LE**, L60-EQ, "each end is a vertex carrying a third tile": at each end some tile approaches from the open half-plane
facing away from the other end (so it is neither an inner nor an outer tile of the arc, by `l60_eq_corners`). -/
theorem l60_eq_third (_hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c') :
    (∃ T, F.IsTile T ∧ ∃ β ∈ coneAt T (ringPt P θ₁), dot (e β) (ringPt P (θ₁ + π / 3) - ringPt P θ₁) < 0) ∧
      ∃ T, F.IsTile T ∧ ∃ β ∈ coneAt T (ringPt P (θ₁ + π / 3)), dot (e β) (ringPt P θ₁ - ringPt P (θ₁ + π / 3)) < 0 := by
  -- validity is not read (the binder `_hF`): the third tile comes from the domain alone
  have hπ := Real.pi_gt_three
  have hd1 : dist (ringPt P θ₁) (ringPt P (θ₁ + π / 3)) = 1 :=
    ((dist_ringPt_ringPt_cmp_one P (α := θ₁) (β := θ₁ + π / 3) (by
      rw [show θ₁ - (θ₁ + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]; linarith)).1).2
      (by rw [show θ₁ - (θ₁ + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)])
  have hne : ringPt P θ₁ ≠ ringPt P (θ₁ + π / 3) := fun h => by rw [h, dist_self] at hd1; norm_num at hd1
  have hAdom : ringPt P θ₁ ∈ F.dom := (hA.2.1 ⟨θ₁, ⟨le_refl _, by linarith⟩, rfl⟩).1
  have hBdom : ringPt P (θ₁ + π / 3) ∈ F.dom := (hA.2.1 ⟨θ₁ + π / 3, ⟨by linarith, le_refl _⟩, rfl⟩).1
  exact ⟨exists_tile_cone_dot_neg hAdom (sub_ne_zero.2 hne.symm), exists_tile_cone_dot_neg hBdom (sub_ne_zero.2 hne)⟩

/-- The lens of the 60° arc `r([0, 60°])` of `ω(0)`: `L = B̄(1, 1) ∩ B̄(e 60°, 1)` (`plans/FS114-L60-audit.md` § 1.3). -/
noncomputable def l60Lens : Set ℂ := closedBall 1 1 ∩ closedBall (e (π / 3)) 1

/-- L60-REAL's domain: the interior of the lens together with the closed discs of radius `1/4` about the ends. -/
noncomputable def l60Dom : Set ℂ := interior (l60Lens ∪ closedBall 1 (1 / 4) ∪ closedBall (e (π / 3)) (1 / 4))

/-- L60-REAL's arcs: the arc itself, the lens's two sides (arcs of `ω(1)` and `ω(e 60°)` from `0` through the other end to
`C = 1 + e 60°`), and the two circles of radius `1/4` about the ends. -/
noncomputable def l60Arcs : Set Arc :=
  {.circ 0 1 0 (π / 3), .circ 1 1 (π / 3) π, .circ (e (π / 3)) 1 (4 * π / 3) (2 * π), .circ 1 (1 / 4) 0 (2 * π),
    .circ (e (π / 3)) (1 / 4) 0 (2 * π)}

/-- L60-REAL's colours (`plans/FS114-L60-audit.md` § 1.3 (iii), colours less one, renumbered): `0` on the lens inside `ω(0)`
(`Reul(0, A, B)`), `1` on the lens outside (the Reuleaux cap), `2` on the disc about `A = 1` off the lens, `3` on the disc about
`B = e 60°` off the lens. -/
noncomputable def l60Col (z : ℂ) : Fin 4 := by
  classical
  exact if z ∈ l60Lens then (if ‖z‖ < 1 then 0 else 1) else if dist z 1 < 1 / 4 then 2 else 3

/-- L60-REAL's domain is open. -/
theorem isOpen_l60Dom : IsOpen l60Dom := isOpen_interior

/-- L60-REAL's arcs are non-degenerate. -/
theorem l60Arcs_nondegenerate : ∀ a ∈ l60Arcs, a.Nondegenerate := by
  intro a ha
  simp only [l60Arcs, mem_insert_iff, mem_singleton_iff] at ha
  have hπ := pi_pos
  rcases ha with rfl | rfl | rfl | rfl | rfl <;> refine ⟨by norm_num, by linarith, by linarith⟩

/-- A point at distance `ρ > 0` from `c` whose argument (shifted by a whole turn) lies in `[θ₀, θ₁]` is on the arc. -/
theorem mem_carrier_circ_of_arg {c w : ℂ} {ρ θ₀ θ₁ : ℝ} (hw : ‖w - c‖ = ρ) (k : ℤ)
    (h : Complex.arg (w - c) + k * (2 * π) ∈ Icc θ₀ θ₁) : w ∈ (Arc.circ c ρ θ₀ θ₁).carrier := by
  refine ⟨_, h, ?_⟩
  have he : e (Complex.arg (w - c) + k * (2 * π)) = e (Complex.arg (w - c)) := e_eq_e_iff.mpr ⟨k, rfl⟩
  show c + (ρ : ℂ) * e _ = w
  rw [he, ← hw]
  have : (‖w - c‖ : ℂ) * e (Complex.arg (w - c)) = w - c := by
    simp [e]
  rw [this]; ring

/-- On `[−π, π]`, `cos x ≥ 1/2` exactly within `π/3` of `0`. -/
theorem abs_le_pi_div_three_of_cos {x : ℝ} (h1 : -π ≤ x) (h2 : x ≤ π) (hc : 1 / 2 ≤ Real.cos x) : |x| ≤ π / 3 := by
  have hπ := Real.pi_pos
  by_contra hlt
  rw [not_le] at hlt
  have hax : |x| ≤ π := abs_le.mpr ⟨h1, h2⟩
  have : Real.cos |x| < Real.cos (π / 3) :=
    Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith) hax hlt
  rw [Real.cos_abs, Real.cos_pi_div_three] at this
  linarith

/-- `cos x ≤ −1/2` only at least `2π/3` from `0`. -/
theorem two_pi_div_three_le_abs_of_cos {x : ℝ} (hc : Real.cos x ≤ -1 / 2) :
    2 * π / 3 ≤ |x| := by
  have hπ := Real.pi_pos
  by_contra hlt
  rw [not_le] at hlt
  have : Real.cos (2 * π / 3) < Real.cos |x| :=
    Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg x) (by linarith) hlt
  rw [Real.cos_abs, show 2 * π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three] at this
  linarith

/-- `cos (arg w − a)` for a unit `w`: `Re (w · conj (e a))`. -/
theorem cos_arg_sub {w : ℂ} (hw : ‖w‖ = 1) (a : ℝ) :
    Real.cos (Complex.arg w - a) = w.re * Real.cos a + w.im * Real.sin a := by
  have hw0 : w ≠ 0 := by intro h; rw [h, norm_zero] at hw; norm_num at hw
  rw [Real.cos_sub, Complex.cos_arg hw0, Complex.sin_arg, hw, div_one, div_one]

/-- `‖x − a‖²` in coordinates. -/
theorem sq_norm_sub_eq (x a : ℂ) : ‖x - a‖ ^ 2 = (x.re - a.re) ^ 2 + (x.im - a.im) ^ 2 := by
  rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring

/-- `e (π/3) = 1/2 + (√3/2) i`. -/
theorem e_pi_div_three_re_im : (e (π / 3)).re = 1 / 2 ∧ (e (π / 3)).im = √3 / 2 := by
  simp [e_eq, Real.cos_pi_div_three, Real.sin_pi_div_three]

/-- A point at distance `ρ > 0` from `c` lies on the whole circle `.circ c ρ 0 (2π)`. -/
theorem mem_carrier_circ_full {c w : ℂ} {ρ : ℝ} (hw : ‖w - c‖ = ρ) : w ∈ (Arc.circ c ρ 0 (2 * π)).carrier := by
  have h1 := Complex.neg_pi_lt_arg (w - c)
  have h2 := Complex.arg_le_pi (w - c)
  by_cases h0 : 0 ≤ Complex.arg (w - c)
  · exact mem_carrier_circ_of_arg hw 0 ⟨by simpa using h0, by simp; linarith [Real.pi_pos]⟩
  · exact mem_carrier_circ_of_arg hw 1 ⟨by simp; linarith, by simp; linarith⟩

/-- A point of `ω(0)` in the lens `B̄(1, 1) ∩ B̄(e 60°, 1)` lies on the arc `r([0, 60°])`. -/
theorem mem_l60_arc0 {x : ℂ} (h0 : ‖x‖ = 1) (h1 : ‖x - 1‖ ≤ 1) (h2 : ‖x - e (π / 3)‖ ≤ 1) :
    x ∈ (Arc.circ 0 1 0 (π / 3)).carrier := by
  have hπ := Real.pi_pos
  obtain ⟨er, ei⟩ := e_pi_div_three_re_im
  have hs3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hsq0 : x.re ^ 2 + x.im ^ 2 = 1 := by
    have := sq_norm_sub_eq x 0; rw [sub_zero, h0] at this; simp at this; linarith
  have hsq1 := sq_norm_sub_eq x 1
  have hsq2 := sq_norm_sub_eq x (e (π / 3))
  rw [er, ei] at hsq2
  simp only [Complex.one_re, Complex.one_im] at hsq1
  have hb1 : ‖x - 1‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (x - 1)]
  have hb2 : ‖x - e (π / 3)‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (x - e (π / 3))]
  have hx1 := Complex.neg_pi_lt_arg x
  have hx2 := Complex.arg_le_pi x
  have hc0 : 1 / 2 ≤ Real.cos (Complex.arg x - 0) := by rw [cos_arg_sub h0, Real.cos_zero, Real.sin_zero]; nlinarith
  rw [sub_zero] at hc0
  have ha := abs_le.mp (abs_le_pi_div_three_of_cos hx1.le hx2 hc0)
  have hc1 : 1 / 2 ≤ Real.cos (Complex.arg x - π / 3) := by
    rw [cos_arg_sub h0, Real.cos_pi_div_three, Real.sin_pi_div_three]; nlinarith
  have hb := abs_le.mp (abs_le_pi_div_three_of_cos (by linarith) (by linarith) hc1)
  refine mem_carrier_circ_of_arg (by rw [sub_zero, h0]) 0 ⟨?_, ?_⟩ <;> simp only [sub_zero, Int.cast_zero, zero_mul, add_zero] <;> linarith

/-- A point of `ω(1)` in `B̄(e 60°, 1)` lies on the lens's side `1 + e([60°, 180°])`. -/
theorem mem_l60_arc1 {x : ℂ} (h0 : ‖x - 1‖ = 1) (h2 : ‖x - e (π / 3)‖ ≤ 1) :
    x ∈ (Arc.circ 1 1 (π / 3) π).carrier := by
  have hπ := Real.pi_pos
  obtain ⟨er, ei⟩ := e_pi_div_three_re_im
  have hs3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hsq0 := sq_norm_sub_eq x 1
  rw [h0] at hsq0; simp only [Complex.one_re, Complex.one_im] at hsq0
  have hsq2 := sq_norm_sub_eq x (e (π / 3))
  rw [er, ei] at hsq2
  have hb2 : ‖x - e (π / 3)‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (x - e (π / 3))]
  have hw1 := Complex.neg_pi_lt_arg (x - 1)
  have hw2 := Complex.arg_le_pi (x - 1)
  have hc : Real.cos (Complex.arg (x - 1) - (-(π / 3))) ≤ -1 / 2 := by
    rw [cos_arg_sub h0, Real.cos_neg, Real.sin_neg, Real.cos_pi_div_three, Real.sin_pi_div_three]
    simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, sub_zero]; nlinarith
  have := two_pi_div_three_le_abs_of_cos hc
  rw [sub_neg_eq_add] at this
  rcases le_abs'.mp this with h | h
  · linarith
  · exact mem_carrier_circ_of_arg h0 0 ⟨by simp; linarith, by simp; linarith⟩

/-- A point of `ω(e 60°)` in `B̄(1, 1)` lies on the lens's side `e 60° + e([240°, 360°])`. -/
theorem mem_l60_arc2 {x : ℂ} (h0 : ‖x - e (π / 3)‖ = 1) (h1 : ‖x - 1‖ ≤ 1) :
    x ∈ (Arc.circ (e (π / 3)) 1 (4 * π / 3) (2 * π)).carrier := by
  have hπ := Real.pi_pos
  obtain ⟨er, ei⟩ := e_pi_div_three_re_im
  have hs3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hsq0 := sq_norm_sub_eq x (e (π / 3))
  rw [h0, er, ei] at hsq0
  have hsq1 := sq_norm_sub_eq x 1
  simp only [Complex.one_re, Complex.one_im] at hsq1
  have hb1 : ‖x - 1‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (x - 1)]
  have hw1 := Complex.neg_pi_lt_arg (x - e (π / 3))
  have hw2 := Complex.arg_le_pi (x - e (π / 3))
  have hcs : Real.cos (2 * π / 3) = -1 / 2 ∧ Real.sin (2 * π / 3) = √3 / 2 := by
    rw [show 2 * π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.sin_pi_sub, Real.cos_pi_div_three, Real.sin_pi_div_three]
    norm_num
  have hc : Real.cos (Complex.arg (x - e (π / 3)) - 2 * π / 3) ≤ -1 / 2 := by
    rw [cos_arg_sub h0, hcs.1, hcs.2]
    simp only [Complex.sub_re, Complex.sub_im, er, ei]; nlinarith
  have hA := two_pi_div_three_le_abs_of_cos hc
  have hc' : Real.cos (Complex.arg (x - e (π / 3)) + 4 * π / 3) ≤ -1 / 2 := by
    rw [show Complex.arg (x - e (π / 3)) + 4 * π / 3 = (Complex.arg (x - e (π / 3)) - 2 * π / 3) + 2 * π by ring,
      Real.cos_add_two_pi]; exact hc
  have hB := two_pi_div_three_le_abs_of_cos hc'
  rcases le_abs'.mp hA with h | h
  · rcases le_abs'.mp hB with h' | h'
    · linarith
    · exact mem_carrier_circ_of_arg h0 1 ⟨by simp; linarith, by simp; linarith⟩
  · linarith

/-- L60-REAL's colouring is locally constant off its arcs. -/
theorem l60Col_locallyConstant : ∀ x ∈ l60Dom, x ∉ ⋃ a ∈ l60Arcs, a.carrier → ∀ᶠ y in 𝓝 x, l60Col y = l60Col x := by
  intro x _ hx
  have hmem : ∀ a ∈ l60Arcs, x ∉ a.carrier := fun a ha h => hx (mem_iUnion₂.mpr ⟨a, ha, h⟩)
  by_cases hL : x ∈ l60Lens
  · obtain ⟨hL1, hL2⟩ := hL
    rw [mem_closedBall, dist_eq_norm] at hL1 hL2
    have h1 : ‖x - 1‖ < 1 := lt_of_le_of_ne hL1 fun h => hmem _ (by simp [l60Arcs]) (mem_l60_arc1 h hL2)
    have h2 : ‖x - e (π / 3)‖ < 1 := lt_of_le_of_ne hL2 fun h => hmem _ (by simp [l60Arcs]) (mem_l60_arc2 h hL1)
    have h0 : ‖x‖ ≠ 1 := fun h => hmem _ (by simp [l60Arcs]) (mem_l60_arc0 h hL1 hL2)
    have hxL : x ∈ l60Lens := ⟨by rw [mem_closedBall, dist_eq_norm]; exact hL1, by rw [mem_closedBall, dist_eq_norm]; exact hL2⟩
    have hU : ∀ᶠ y in 𝓝 x, y ∈ l60Lens := by
      filter_upwards [isOpen_ball.mem_nhds (show x ∈ ball 1 1 by rw [mem_ball, dist_eq_norm]; exact h1),
        isOpen_ball.mem_nhds (show x ∈ ball (e (π / 3)) 1 by rw [mem_ball, dist_eq_norm]; exact h2)] with y hy1 hy2
      exact ⟨ball_subset_closedBall hy1, ball_subset_closedBall hy2⟩
    have hN : ∀ᶠ y in 𝓝 x, (‖y‖ < 1 ↔ ‖x‖ < 1) := by
      rcases lt_or_gt_of_ne h0 with h | h
      · filter_upwards [(isOpen_lt continuous_norm continuous_const).mem_nhds h] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
      · filter_upwards [(isOpen_lt continuous_const continuous_norm).mem_nhds h] with y hy
        exact ⟨fun h' => absurd h' (not_lt.mpr hy.le), fun h' => absurd h' (not_lt.mpr h.le)⟩
    filter_upwards [hU, hN] with y hy hyN
    by_cases hx1 : ‖x‖ < 1
    · simp only [l60Col, hy, hxL, hx1, hyN.mpr hx1, if_true]
    · simp only [l60Col, hy, hxL, hx1, mt hyN.mp hx1, if_true, if_false]
  · have hd1 : dist x 1 ≠ 1 / 4 := fun h => hmem (.circ 1 (1 / 4) 0 (2 * π)) (by simp [l60Arcs]) (mem_carrier_circ_full (c := 1) (ρ := 1 / 4) (show ‖x - 1‖ = 1 / 4 by rw [← dist_eq_norm]; exact h))
    have hU : ∀ᶠ y in 𝓝 x, y ∉ l60Lens :=
      (isClosed_closedBall.inter isClosed_closedBall).isOpen_compl.mem_nhds hL
    have hD : ∀ᶠ y in 𝓝 x, (dist y 1 < 1 / 4 ↔ dist x 1 < 1 / 4) := by
      rcases lt_or_gt_of_ne hd1 with h | h
      · filter_upwards [isOpen_ball.mem_nhds (show x ∈ ball 1 (1 / 4) from h)] with y hy
        exact ⟨fun _ => h, fun _ => hy⟩
      · filter_upwards [(isOpen_lt continuous_const (continuous_id.dist continuous_const)).mem_nhds h] with y hy
        exact ⟨fun h' => absurd h' (not_lt.mpr hy.le), fun h' => absurd h' (not_lt.mpr h.le)⟩
    filter_upwards [hU, hD] with y hy hyD
    by_cases hx1 : dist x 1 < 1 / 4
    · simp only [l60Col, hy, hL, hx1, hyD.mpr hx1, if_true, if_false]
    · simp only [l60Col, hy, hL, hx1, mt hyD.mp hx1, if_false]

/-- **The fragment of L60-REAL**, by formula: four colours on a neighbourhood of the closed 60° arc `r([0, 60°])` of `ω(0)`. -/
noncomputable def l60Frag : ArcMap 4 where
  dom := l60Dom
  isOpen_dom := isOpen_l60Dom
  arcs := l60Arcs
  nondegenerate := l60Arcs_nondegenerate
  locallyFinite := fun _ _ => ⟨univ, univ_mem, (((((finite_singleton _).insert _).insert _).insert _).insert _).subset fun _ ha => ha.1⟩
  col := l60Col
  locallyConstant := l60Col_locallyConstant

/-- **FS114-L60-LE**, L60-REAL: equality is realised by a valid fragment by formula on a neighbourhood of the closed arc — the arc
`r([0, 60°])` of `ω(0)` is an arc of `Γ` with constant sides (inner colour `0`, outer `1`) of `l60Frag`, which is valid and whose
domain holds a neighbourhood of the closed arc. -/
theorem l60_real : l60Frag.Valid ∧ l60Frag.IsRingArc 0 0 (π / 3) 0 1 ∧
    ∃ δ > 0, thickening δ (ringArc 0 0 (π / 3)) ⊆ l60Frag.dom := by
  sorry

/-! ## FS112-N2-BENDS: N2-ENV and the whole-arc bends (FS112-BEND merged) -/

/-- **FS112-N2-BENDS**, N2-ENV toward: for a closed arc `ᾱ = r([θ₁, θ₂])` of `ω(P)` with `0 < ℓ ≤ 60°` and every `r > 0` there is a
lens profile `ψ > 0` such that, for every toward lens point `z = P + (1 − s) e(φ)` with `φ` interior and `0 < s ≤ ψ·Δ(φ)` (`Δ` the angular
distance to the nearer end), the part of `B̄(z, 1)` not within `< 1` of some point of `ᾱ` lies in `B(P, r)`. -/
theorem n2_env_toward (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 - s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ ball P r := by
  sorry

/-- **FS112-N2-BENDS**, N2-ENV away: the same for an away lens point `z = P + (1 + s) e(φ)`, the uncovered part lying within `r` of
the radius-2 arc `R₂(ᾱ)`. -/
theorem n2_env_away (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 + s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ thickening r (radiusTwoArc P θ₁ θ₂) := by
  sorry

/-- **FS112-N2-BENDS**, N2-ENV's near clause, toward: for a small enough profile, every point of the lens `B̄(A, 1) ∩ B̄(B, 1)` of the
arc's ends is within `< 1` of every toward lens point. -/
theorem n2_env_near (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1, dist p (P + (1 - s) * e φ) < 1 := by
  sorry

/-- **FS112-N2-BENDS**, N2-ENV's near clause, away: the same for the away lens off `B(P, r)`. -/
theorem n2_env_near_away (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1 := by
  sorry

/-- `C₂(ᾱ)` (FS112-N2-TAN): the angles of the closed arc whose radius-2 point lies in the closure of the colour `c`'s class. -/
def r2Contacts (P : ℂ) (θ₁ θ₂ : ℝ) (c : Fin k) : Set ℝ := {θ ∈ Icc θ₁ θ₂ | P + 2 * e θ ∈ closure (F.region c)}

/-- **FS112-N2-BENDS**, the toward bend (N2-TOWARD; FS112-BEND's toward case, off the end vertices, is its special case): if the outer
colour is not carried at the centre, the whole arc, end vertices included, bends toward `P` — for every `ε > 0` there is a valid map
agreeing with `F` off the `ε`-neighbourhood of the closed arc and creating no unit arc, in which no interior point of the arc lies on an
arc of `Γ` on `ω(P)`, no colour but the outer one gains points, and the outer one only inside `B̄(P, 1)` near the arc. -/
theorem bend_toward (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hout : c' ∉ F.coloursAt P) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ F'.OnRingArc P (ringPt P θ)) ∧ (∀ j, j ≠ c' → F'.region j ⊆ F.region j) ∧
      F'.region c' ⊆ F.region c' ∪ (thickening ε (ringArc P θ₁ θ₂) ∩ closedBall P 1) := by
  sorry

/-- **FS112-N2-BENDS**, the away bend with the tangent bend (N2-AWAY and N2-TAN; FS112-BEND's away case is its special case): if the
inner colour is not carried at the centre, the arc bends away from `P` everywhere but along the arcs of R2 contact — for every
`ε > 0` there is a valid map agreeing with `F` off the `ε`-neighbourhood of the closed arc and creating no unit arc, in which an
interior point of the arc still on an arc of `Γ` on `ω(P)` lies in a non-degenerate interval of `C₂(ᾱ)` ("isolated R2 contacts are cleared
by a tangent bend, and only R2 along an arc blocks"), no colour but the inner one gains points, and the inner one only outside
`B(P, 1)` near the arc. -/
theorem bend_away (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hin : c ∉ F.coloursAt P) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, F'.OnRingArc P (ringPt P θ) →
        ∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c) ∧
      (∀ j, j ≠ c → F'.region j ⊆ F.region j) ∧
      F'.region c ⊆ F.region c ∪ (thickening ε (ringArc P θ₁ θ₂) \ ball P 1) := by
  sorry

/-- **FS112-N2-BENDS**, the away bend as the row states it (N2-AWAY): if the inner colour is not carried at the centre and no point of
the radius-2 arc `R₂(ᾱ)` lies in the closure of its class, the whole arc bends away — no interior point of it is left on an arc of
`Γ` on `ω(P)`. -/
theorem bend_away_whole (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hin : c ∉ F.coloursAt P) (hR2 : Disjoint (radiusTwoArc P θ₁ θ₂) (closure (F.region c))) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ F'.OnRingArc P (ringPt P θ)) ∧ (∀ j, j ≠ c → F'.region j ⊆ F.region j) ∧
      F'.region c ⊆ F.region c ∪ (thickening ε (ringArc P θ₁ θ₂) \ ball P 1) := by
  sorry

/-! ## FS112-ISO: an isolated R2 contact, and what it blocks -/

/-- FS112-ISO's inner-colour tile: the open sector at `q₀ = 2` (`= P + 2e(0)` for `P = 0`) of half-angle `60°` about the direction
`e(0)`, within `1/4` of `q₀` — outside `B̄(0, 2)`, with `q₀` its corner. -/
noncomputable def isoY : Set ℂ := {z | ‖z - 2‖ < 1 / 4 ∧ |(z - 2).im| < √3 * (z - 2).re}

/-- FS112-ISO's domain: a disc about the arc's middle point `1` and the sector `isoY`. -/
theorem isOpen_isoDom : IsOpen (ball (1 : ℂ) (1 / 4) ∪ isoY) := by
  refine isOpen_ball.union ?_
  have h1 : IsOpen {z : ℂ | ‖z - 2‖ < 1 / 4} := isOpen_lt (by fun_prop) continuous_const
  have h2 : IsOpen {z : ℂ | |(z - 2).im| < √3 * (z - 2).re} := isOpen_lt (by fun_prop) (by fun_prop)
  exact h1.inter h2

/-- A point of `B(1, 1/4)` on the unit circle lies on `FS112-ISO`'s arc `r([−π/6, π/6])`. -/
theorem mem_isoArc_of_norm_one {x : ℂ} (hball : x ∈ ball (1 : ℂ) (1 / 4)) (h1' : ‖x‖ = 1) :
    x ∈ ⋃ a ∈ ({Arc.circ 0 1 (-(π / 6)) (π / 6)} : Set Arc), a.carrier := by
  rw [mem_ball, dist_eq_norm] at hball
  have hre : 31 / 32 < x.re := by
    have hsq : ‖x - 1‖ ^ 2 < (1 / 4) ^ 2 := by
      have := norm_nonneg (x - 1)
      nlinarith
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at hsq
    simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im] at hsq
    have hn : ‖x‖ ^ 2 = x.re ^ 2 + x.im ^ 2 := by
      rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; ring
    nlinarith [sq_nonneg x.im, norm_nonneg x]
  simp only [mem_iUnion, mem_singleton_iff]
  refine ⟨_, rfl, ?_⟩
  have hx0 : x ≠ 0 := by rintro rfl; simp at h1'
  have hcos : Real.cos (Complex.arg x) = x.re := by
    rw [Complex.cos_arg hx0, h1', div_one]
  have habs : |Complex.arg x| ≤ π / 6 := by
    by_contra hlt
    rw [not_le] at hlt
    have hc : Real.cos (Complex.arg x) = Real.cos |Complex.arg x| := (Real.cos_abs _).symm
    have : Real.cos |Complex.arg x| < Real.cos (π / 6) :=
      Real.cos_lt_cos_of_nonneg_of_le_pi (by positivity) (by linarith [Complex.abs_arg_le_pi x]) hlt
    rw [Real.cos_pi_div_six] at this
    have h3 : √3 < 2 * (31 / 32) := by
      rw [Real.sqrt_lt' (by norm_num)]; norm_num
    linarith
  refine ⟨Complex.arg x, ?_, ?_⟩
  · exact ⟨by linarith [(abs_le.mp habs).1], by linarith [(abs_le.mp habs).2]⟩
  · have := Complex.norm_mul_exp_arg_mul_I x
    simp only [h1', ofReal_one, one_mul] at this
    simp only [e]
    simpa using this

/-- FS112-ISO's colouring is locally constant off its arc. -/
theorem isoCol_locallyConstant : ∀ x ∈ ball (1 : ℂ) (1 / 4) ∪ isoY, x ∉ ⋃ a ∈ ({Arc.circ 0 1 (-(π / 6)) (π / 6)} : Set Arc),
    a.carrier → ∀ᶠ y in 𝓝 x, (by classical exact if ‖y‖ < 1 ∨ y ∈ isoY then (0 : Fin 2) else 1) =
      (by classical exact if ‖x‖ < 1 ∨ x ∈ isoY then (0 : Fin 2) else 1) := by
  intro x hx hxa
  classical
  have hopenY : IsOpen isoY := by
    have h1 : IsOpen {z : ℂ | ‖z - 2‖ < 1 / 4} := isOpen_lt (by fun_prop) continuous_const
    have h2 : IsOpen {z : ℂ | |(z - 2).im| < √3 * (z - 2).re} := isOpen_lt (by fun_prop) (by fun_prop)
    exact h1.inter h2
  have hopenC : IsOpen {y : ℂ | ‖y‖ < 1 ∨ y ∈ isoY} :=
    (isOpen_lt continuous_norm continuous_const).union hopenY
  by_cases h : ‖x‖ < 1 ∨ x ∈ isoY
  · filter_upwards [hopenC.mem_nhds h] with y hy
    rw [if_pos hy, if_pos h]
  · have hball : x ∈ ball (1 : ℂ) (1 / 4) := by
      rcases hx with hx | hx
      · exact hx
      · exact absurd (Or.inr hx) h
    push Not at h
    obtain ⟨h1, hY⟩ := h
    rw [mem_ball, dist_eq_norm] at hball
    have hre : 31 / 32 < x.re := by
      have hsq : ‖x - 1‖ ^ 2 < (1 / 4) ^ 2 := by
        have := norm_nonneg (x - 1)
        nlinarith
      rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at hsq
      simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im] at hsq
      have hn : ‖x‖ ^ 2 = x.re ^ 2 + x.im ^ 2 := by
        rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; ring
      nlinarith [sq_nonneg x.im, norm_nonneg x]
    have hne : ‖x‖ ≠ 1 := fun h1' => hxa (mem_isoArc_of_norm_one (by rw [mem_ball, dist_eq_norm]; exact hball) h1')
    have hgt : 1 < ‖x‖ := lt_of_le_of_ne h1 (Ne.symm hne)
    have h2 : 3 / 4 < ‖x - 2‖ := by
      have : ‖(1 : ℂ) - 2‖ ≤ ‖x - 1‖ + ‖x - 2‖ := by
        calc ‖(1 : ℂ) - 2‖ = ‖(x - 2) - (x - 1)‖ := by congr 1; ring
          _ ≤ ‖x - 2‖ + ‖x - 1‖ := norm_sub_le _ _
          _ = _ := add_comm _ _
      have h12 : ‖(1 : ℂ) - 2‖ = 1 := by norm_num
      linarith
    have hopen2 : IsOpen {y : ℂ | 1 < ‖y‖ ∧ 1 / 4 < ‖y - 2‖} :=
      (isOpen_lt (f := fun _ : ℂ => (1 : ℝ)) (g := fun y : ℂ => ‖y‖) continuous_const continuous_norm).inter
        (isOpen_lt (f := fun _ : ℂ => (1 / 4 : ℝ)) (g := fun y : ℂ => ‖y - 2‖) continuous_const (by fun_prop))
    filter_upwards [hopen2.mem_nhds ⟨hgt, by linarith⟩] with y hy
    have hn : ¬ (‖y‖ < 1 ∨ y ∈ isoY) := by
      rintro (h | h)
      · linarith [hy.1]
      · linarith [hy.2, h.1]
    rw [if_neg hn, if_neg (by rintro (h | h) <;> [linarith; exact hY h])]

/-- **The fragment of FS112-ISO**, by formula (`plans/FS112-NB-verification.md` § 2.3 #4): about the arc of `ω(0)` near `1`, colour `0`
inside and `1` outside; and the sector `isoY` at `q₀ = 2`, colour `0` (the inner colour). -/
noncomputable def isoFrag : ArcMap 2 where
  dom := ball 1 (1 / 4) ∪ isoY
  isOpen_dom := isOpen_isoDom
  arcs := {Arc.circ 0 1 (-(π / 6)) (π / 6)}
  nondegenerate := by
    intro a ha
    rw [mem_singleton_iff] at ha
    subst ha
    exact ⟨one_pos, by linarith [pi_pos], by linarith [pi_pos]⟩
  locallyFinite := fun _ _ => ⟨univ, univ_mem, (finite_singleton _).subset fun a ha => ha.1⟩
  col := fun y => by classical exact if ‖y‖ < 1 ∨ y ∈ isoY then 0 else 1
  locallyConstant := isoCol_locallyConstant

/-! ### `iso`'s facts -/

/-- A point of `isoY` is farther than `2` from `0` (its corner `2` is the only point of `closedBall 0 2` the sector approaches). -/
theorem two_lt_norm_of_mem_isoY {z : ℂ} (hz : z ∈ isoY) : 2 < ‖z‖ := by
  obtain ⟨h1, h2⟩ := hz
  have hre : 0 < (z - 2).re := by
    have := abs_nonneg (z - 2).im
    have h3 : 0 < √3 := Real.sqrt_pos.2 (by norm_num)
    by_contra hle
    push Not at hle
    nlinarith [mul_nonpos_of_nonneg_of_nonpos h3.le hle]
  have hre2 : 2 < z.re := by simpa using hre
  have : z.re ≤ ‖z‖ := (Complex.re_le_norm z)
  linarith

/-- The points of the disc `B(1, 1/4)` have norm between `3/4` and `5/4`. -/
theorem norm_bounds_of_mem_ball_one {z : ℂ} (hz : z ∈ ball (1 : ℂ) (1 / 4)) : 3 / 4 < ‖z‖ ∧ ‖z‖ < 5 / 4 := by
  rw [mem_ball, dist_eq_norm] at hz
  have h1 : ‖(1 : ℂ)‖ - ‖z - 1‖ ≤ ‖z‖ := by
    have := norm_sub_norm_le (1 : ℂ) (1 - z)
    rw [norm_sub_rev] at this
    have h2 : (1 : ℂ) - (1 - z) = z := by ring
    rw [h2] at this
    simpa [norm_sub_rev] using this
  have h2 : ‖z‖ ≤ ‖z - 1‖ + ‖(1 : ℂ)‖ := by
    have := norm_le_norm_add_norm_sub' z 1
    simp only [norm_one] at this ⊢
    linarith
  simp only [norm_one] at h1 h2
  constructor <;> linarith

/-- The colour of `isoFrag`: `0` exactly on the open unit disc and `isoY`. -/
theorem isoFrag_col_eq_zero_iff (z : ℂ) : isoFrag.col z = 0 ↔ (‖z‖ < 1 ∨ z ∈ isoY) := by
  classical
  show (if ‖z‖ < 1 ∨ z ∈ isoY then (0 : Fin 2) else 1) = 0 ↔ _
  split_ifs with h
  · simp [h]
  · simp only [h, iff_false]; decide

/-- The arc of `isoFrag` lies on the unit circle. -/
theorem norm_eq_one_of_mem_isoFrag_arcs {z : ℂ} (hz : z ∈ ⋃ a ∈ isoFrag.arcs, a.carrier) : ‖z‖ = 1 := by
  simp only [isoFrag, mem_iUnion, mem_singleton_iff] at hz
  obtain ⟨a, rfl, θ, -, rfl⟩ := hz
  simp [e]

/-- Every point of `isoFrag`'s domain is near `1` or in `isoY`. -/
theorem mem_isoFrag_dom {z : ℂ} : z ∈ isoFrag.dom ↔ z ∈ ball (1 : ℂ) (1 / 4) ∨ z ∈ isoY := Iff.rfl

/-- Colour-`1` points of `isoFrag` lie in the disc about `1`, outside the open unit disc. -/
theorem isoFrag_region_one {z : ℂ} (hz : z ∈ isoFrag.region 1) : z ∈ ball (1 : ℂ) (1 / 4) ∧ 1 < ‖z‖ := by
  obtain ⟨⟨hd, hna⟩, hc⟩ := hz
  have hc' : isoFrag.col z = 1 := hc
  have h0 : ¬ (‖z‖ < 1 ∨ z ∈ isoY) := fun h => by
    have := (isoFrag_col_eq_zero_iff z).2 h
    rw [hc'] at this; exact absurd this (by decide)
  push Not at h0
  have hball : z ∈ ball (1 : ℂ) (1 / 4) := hd.resolve_right h0.2
  refine ⟨hball, lt_of_le_of_ne h0.1 fun h => hna ?_⟩
  exact mem_isoArc_of_norm_one hball h.symm

/-- **FS112-ISO**: isolated inner-colour contacts at `P + 2e(θ₀)` exist locally, and block a first-order away-bend. In `isoFrag`
(valid), the arc `r([−1/8, 1/8])` of `ω(0)` has constant sides (inner `0`, outer `1`) and its inner colour is not carried at the
centre (the away bend's precondition); the inner colour's tile `isoY` lies outside `B̄(0, 2)` but for its corner `2 = 0 + 2e(0)`,
which is the only radius-2 contact (`C₂ = {0}`); and every radial point `1 + s` beyond the arc's middle, `s > 0` small, is at distance
exactly `1` from the inner colour's class — so no lens of the away bend containing those points can take the inner colour. -/
theorem iso : isoFrag.Valid ∧ isoFrag.IsRingArc 0 (-(1 / 8)) (1 / 8) 0 1 ∧ (0 : Fin 2) ∉ isoFrag.coloursAt 0 ∧
    isoFrag.TileOf 0 isoY ∧ Disjoint isoY (closedBall 0 2) ∧ (2 : ℂ) ∈ closure isoY ∧
    isoFrag.r2Contacts 0 (-(1 / 8)) (1 / 8) 0 = {0} ∧
    ∀ᶠ s : ℝ in 𝓝[>] 0, ¬ isoFrag.IsClear 0 (0 + (1 + (s : ℂ)) * e 0) := by
  have hopenY : IsOpen isoY := by
    have h1 : IsOpen {z : ℂ | ‖z - 2‖ < 1 / 4} := isOpen_lt (by fun_prop) continuous_const
    have h2 : IsOpen {z : ℂ | |(z - 2).im| < √3 * (z - 2).re} := isOpen_lt (by fun_prop) (by fun_prop)
    exact h1.inter h2
  have hY0 : ∀ z ∈ isoY, isoFrag.col z = 0 := fun z hz => (isoFrag_col_eq_zero_iff z).2 (Or.inr hz)
  have hYint : ∀ z ∈ isoY, z ∈ isoFrag.interiorPts := fun z hz =>
    ⟨Or.inr hz, fun h => by
      have := norm_eq_one_of_mem_isoFrag_arcs h
      linarith [two_lt_norm_of_mem_isoY hz]⟩
  have hYreg : ∀ z ∈ isoY, z ∈ isoFrag.region 0 := fun z hz => ⟨hYint z hz, hY0 z hz⟩
  have hnotY : ∀ z ∈ ball (1 : ℂ) (1 / 4), z ∉ isoY := fun z hz hzY => by
    linarith [(norm_bounds_of_mem_ball_one hz).2, two_lt_norm_of_mem_isoY hzY]
  have hhalf : ∀ {x y c : ℂ}, x ∈ ball c (1 / 4) → y ∈ ball c (1 / 4) → dist x y < 1 / 2 := by
    intro x y c hx hy
    rw [mem_ball] at hx hy
    linarith [dist_triangle_right x y c]
  have hregfar : ∀ c, ∀ z ∈ isoFrag.region c, 3 / 4 < ‖z‖ := by
    intro c z hz
    rcases hz.1.1 with h | h
    · exact (norm_bounds_of_mem_ball_one h).1
    · linarith [two_lt_norm_of_mem_isoY h]
  have hclosfar : ∀ c, ∀ z ∈ closure (isoFrag.region c), 3 / 4 ≤ ‖z‖ := fun c z hz =>
    closure_minimal (fun w hw => (hregfar c w hw).le)
      (isClosed_le continuous_const continuous_norm : IsClosed {z : ℂ | (3 / 4 : ℝ) ≤ ‖z‖}) hz
  have hclY : ∀ z ∈ closure isoY, 2 ≤ ‖z‖ := fun z hz =>
    closure_minimal (fun w hw => (two_lt_norm_of_mem_isoY hw).le)
      (isClosed_le continuous_const continuous_norm : IsClosed {z : ℂ | (2 : ℝ) ≤ ‖z‖}) hz
  -- validity
  have hvalid : isoFrag.Valid := by
    intro x hx y hy hxy hcol
    by_cases hx0 : isoFrag.col x = 0
    · have hy0 : isoFrag.col y = 0 := hcol ▸ hx0
      rw [isoFrag_col_eq_zero_iff] at hx0 hy0
      rcases hx.1 with hxb | hxY <;> rcases hy.1 with hyb | hyY
      · linarith [hhalf hxb hyb]
      · have hxn : ‖x‖ < 1 := hx0.resolve_right (hnotY x hxb)
        have h2 := two_lt_norm_of_mem_isoY hyY
        have := norm_sub_norm_le y x
        rw [← dist_eq_norm, dist_comm] at this
        linarith
      · have hyn : ‖y‖ < 1 := hy0.resolve_right (hnotY y hyb)
        have h2 := two_lt_norm_of_mem_isoY hxY
        have := norm_sub_norm_le x y
        rw [← dist_eq_norm] at this
        linarith
      · have h1 : x ∈ ball (2 : ℂ) (1 / 4) := by rw [mem_ball, dist_eq_norm]; exact hxY.1
        have h2 : y ∈ ball (2 : ℂ) (1 / 4) := by rw [mem_ball, dist_eq_norm]; exact hyY.1
        linarith [hhalf h1 h2]
    · have hy1 : ¬ isoFrag.col y = 0 := hcol ▸ hx0
      rw [isoFrag_col_eq_zero_iff] at hx0 hy1
      have hxb : x ∈ ball (1 : ℂ) (1 / 4) := hx.1.resolve_right fun h => hx0 (Or.inr h)
      have hyb : y ∈ ball (1 : ℂ) (1 / 4) := hy.1.resolve_right fun h => hy1 (Or.inr h)
      linarith [hhalf hxb hyb]
  -- points near the arc
  have hnear : ∀ θ : ℝ, |θ| ≤ 1 / 8 → ∀ t : ℝ, |t| ≤ 1 / 16 → (((1 + t : ℝ) : ℂ) * e θ) ∈ ball (1 : ℂ) (1 / 4) := by
    intro θ hθ t ht
    rw [mem_ball, dist_eq_norm]
    have h1 : ‖e θ - 1‖ ≤ |θ| := by
      have := Real.norm_exp_I_mul_ofReal_sub_one_le (x := θ)
      rw [Real.norm_eq_abs] at this
      simpa [e, mul_comm] using this
    have h2 : ‖((1 + t : ℝ) : ℂ) * e θ - 1‖ ≤ ‖((1 + t : ℝ) : ℂ) * e θ - e θ‖ + ‖e θ - 1‖ := by
      calc _ = ‖(((1 + t : ℝ) : ℂ) * e θ - e θ) + (e θ - 1)‖ := by congr 1; ring
        _ ≤ _ := norm_add_le _ _
    have h3 : ‖((1 + t : ℝ) : ℂ) * e θ - e θ‖ = |t| := by
      have : ((1 + t : ℝ) : ℂ) * e θ - e θ = (t : ℂ) * e θ := by push_cast; ring
      rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs]; simp [e]
    linarith
  have hne1 : ∀ θ : ℝ, ∀ t : ℝ, ‖((1 + t : ℝ) : ℂ) * e θ‖ = |1 + t| := by
    intro θ t; rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]; simp [e]
  -- the ring arc
  have harc : isoFrag.IsRingArc 0 (-(1 / 8)) (1 / 8) 0 1 := by
    refine ⟨by norm_num, ?_, ?_⟩
    · rintro _ ⟨θ, hθ, rfl⟩
      have hθ' : |θ| ≤ 1 / 8 := abs_le.2 ⟨hθ.1, hθ.2⟩
      refine ⟨Or.inl ?_, ?_⟩
      · have := hnear θ hθ' 0 (by norm_num)
        simpa [ringPt] using this
      · simp only [isoFrag, mem_iUnion, mem_singleton_iff]
        refine ⟨_, rfl, θ, ⟨by linarith [hθ.1, Real.pi_gt_three], by linarith [hθ.2, Real.pi_gt_three]⟩, ?_⟩
        simp [ringPt]
    · intro θ hθ
      have hθ' : |θ| ≤ 1 / 8 := abs_le.2 ⟨hθ.1.le, hθ.2.le⟩
      have hn1 : ‖ringPt 0 θ‖ = 1 := by simp [ringPt, e]
      constructor
      · ext c
        simp only [mem_singleton_iff, innerColours, mem_setOf_eq]
        constructor
        · intro h
          by_contra hc
          have hc1 : c = 1 := by fin_cases c <;> simp_all
          subst hc1
          have hsub : isoFrag.region 1 ∩ ball 0 1 ⊆ (∅ : Set ℂ) := by
            intro z hz
            have := (isoFrag_region_one hz.1).2
            have h2 := hz.2
            rw [mem_ball, dist_zero_right] at h2
            linarith
          rw [subset_empty_iff.1 hsub, closure_empty] at h
          exact h
        · rintro rfl
          refine Metric.mem_closure_iff.2 fun δ hδ => ?_
          set t : ℝ := min (δ / 2) (1 / 16) with ht
          have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
          have htδ : t < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
          have ht16 : t ≤ 1 / 16 := min_le_right _ _
          refine ⟨((1 + -t : ℝ) : ℂ) * e θ, ⟨⟨⟨Or.inl (hnear θ hθ' (-t) (by rw [abs_neg, abs_of_pos ht0]; exact ht16)), ?_⟩, ?_⟩, ?_⟩, ?_⟩
          · intro h
            have := norm_eq_one_of_mem_isoFrag_arcs h
            rw [hne1, abs_of_pos (by linarith)] at this
            linarith
          · show isoFrag.col _ = 0
            rw [isoFrag_col_eq_zero_iff]
            left; rw [hne1, abs_of_pos (by linarith)]; linarith
          · rw [mem_ball, dist_zero_right, hne1, abs_of_pos (by linarith)]; linarith
          · rw [dist_eq_norm]
            have : ringPt 0 θ - ((1 + -t : ℝ) : ℂ) * e θ = (t : ℂ) * e θ := by simp [ringPt]; ring
            rw [this, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; simp [e]; exact htδ
      · ext c
        simp only [mem_singleton_iff, outerColours, mem_setOf_eq]
        constructor
        · intro h
          by_contra hc
          have hc0 : c = 0 := by fin_cases c <;> simp_all
          subst hc0
          have := hclY _ (closure_mono (fun z hz => by
            have hz0 : isoFrag.col z = 0 := hz.1.2
            rw [isoFrag_col_eq_zero_iff] at hz0
            rcases hz0 with h0 | h0
            · exfalso; exact hz.2 (by rw [mem_closedBall, dist_zero_right]; exact h0.le)
            · exact h0) h)
          rw [hn1] at this
          linarith
        · rintro rfl
          refine Metric.mem_closure_iff.2 fun δ hδ => ?_
          set t : ℝ := min (δ / 2) (1 / 16) with ht
          have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
          have htδ : t < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
          have ht16 : t ≤ 1 / 16 := min_le_right _ _
          have hb : ((1 + t : ℝ) : ℂ) * e θ ∈ ball (1 : ℂ) (1 / 4) := hnear θ hθ' t (by rw [abs_of_pos ht0]; exact ht16)
          have hnb : ‖((1 + t : ℝ) : ℂ) * e θ‖ = 1 + t := by rw [hne1, abs_of_pos (by linarith)]
          refine ⟨((1 + t : ℝ) : ℂ) * e θ, ⟨⟨⟨Or.inl hb, ?_⟩, ?_⟩, ?_⟩, ?_⟩
          · intro h
            have := norm_eq_one_of_mem_isoFrag_arcs h
            linarith
          · show isoFrag.col _ = 1
            have : ¬ isoFrag.col (((1 + t : ℝ) : ℂ) * e θ) = 0 := by
              rw [isoFrag_col_eq_zero_iff]
              rintro (h | h)
              · linarith
              · exact hnotY _ hb h
            revert this
            generalize isoFrag.col (((1 + t : ℝ) : ℂ) * e θ) = c
            fin_cases c <;> simp
          · rw [mem_closedBall, dist_zero_right, hnb]; intro h; linarith
          · rw [dist_eq_norm]
            have : ringPt 0 θ - ((1 + t : ℝ) : ℂ) * e θ = -((t : ℂ) * e θ) := by simp [ringPt]; ring
            rw [this, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; simp [e]; exact htδ
  have h0 : (0 : Fin 2) ∉ isoFrag.coloursAt 0 := fun h => by
    have := hclosfar 0 0 h
    norm_num at this
  -- the sector tile
  have hYconv : Convex ℝ isoY := by
    have e1 : isoY = ball (2 : ℂ) (1 / 4) ∩ {z : ℂ | |(z - 2).im| < √3 * (z - 2).re} := by
      ext z; simp [isoY, mem_ball, dist_eq_norm]
    rw [e1]
    refine (convex_ball _ _).inter ?_
    intro a ha b hb s t hs ht hst
    simp only [mem_setOf_eq] at ha hb ⊢
    have hre : (s • a + t • b - 2).re = s * (a - 2).re + t * (b - 2).re := by
      have : (s • a + t • b - 2) = (s : ℂ) * (a - 2) + (t : ℂ) * (b - 2) := by
        have : (2 : ℂ) = ((s + t : ℝ) : ℂ) * 2 := by rw [hst]; simp
        rw [Complex.real_smul, Complex.real_smul]
        calc (s : ℂ) * a + t * b - 2 = s * a + t * b - ((s + t : ℝ) : ℂ) * 2 := by rw [← this]
          _ = _ := by push_cast; ring
      rw [this]; simp
    have him : (s • a + t • b - 2).im = s * (a - 2).im + t * (b - 2).im := by
      have : (s • a + t • b - 2) = (s : ℂ) * (a - 2) + (t : ℂ) * (b - 2) := by
        have : (2 : ℂ) = ((s + t : ℝ) : ℂ) * 2 := by rw [hst]; simp
        rw [Complex.real_smul, Complex.real_smul]
        calc (s : ℂ) * a + t * b - 2 = s * a + t * b - ((s + t : ℝ) : ℂ) * 2 := by rw [← this]
          _ = _ := by push_cast; ring
      rw [this]; simp
    rw [hre, him]
    calc |s * (a - 2).im + t * (b - 2).im| ≤ |s * (a - 2).im| + |t * (b - 2).im| := abs_add_le _ _
      _ = s * |(a - 2).im| + t * |(b - 2).im| := by rw [abs_mul, abs_mul, abs_of_nonneg hs, abs_of_nonneg ht]
      _ < √3 * (s * (a - 2).re + t * (b - 2).re) := by
        set A := √3 * (a - 2).re - |(a - 2).im| with hAdef
        set B := √3 * (b - 2).re - |(b - 2).im| with hBdef
        have hA : 0 < A := by rw [hAdef]; linarith
        have hB : 0 < B := by rw [hBdef]; linarith
        have h1 := mul_le_mul_of_nonneg_left (min_le_left A B) hs
        have h2 := mul_le_mul_of_nonneg_left (min_le_right A B) ht
        have h3 : s * min A B + t * min A B = min A B := by rw [← add_mul, hst, one_mul]
        have h4 : 0 < min A B := lt_min hA hB
        have : s * |(a - 2).im| + t * |(b - 2).im| = √3 * (s * (a - 2).re + t * (b - 2).re) - (s * A + t * B) := by
          rw [hAdef, hBdef]; ring
        linarith
  have hx0 : ((21 / 10 : ℝ) : ℂ) ∈ isoY := by
    refine ⟨?_, ?_⟩
    · rw [show ((21 / 10 : ℝ) : ℂ) - 2 = ((1 / 10 : ℝ) : ℂ) by push_cast; ring, Complex.norm_real]; norm_num
    · rw [show ((21 / 10 : ℝ) : ℂ) - 2 = ((1 / 10 : ℝ) : ℂ) by push_cast; ring]
      simp only [Complex.ofReal_im, Complex.ofReal_re, abs_zero]
      positivity
  have htile : isoFrag.TileOf 0 isoY := by
    refine ⟨⟨_, hYint _ hx0, ?_⟩, fun z hz => hY0 z hz⟩
    apply subset_antisymm
    · exact hYconv.isPreconnected.subset_connectedComponentIn hx0 (fun z hz => hYint z hz)
    · refine IsPreconnected.subset_left_of_subset_union (v := (closure isoY)ᶜ) hopenY isClosed_closure.isOpen_compl
        (disjoint_compl_right.mono_left subset_closure) ?_ ⟨_, mem_connectedComponentIn (hYint _ hx0), hx0⟩
        isPreconnected_connectedComponentIn
      intro p hp
      have hpi := connectedComponentIn_subset _ _ hp
      rcases hpi.1 with hb | hY
      · right; intro hcl
        have := hclY p hcl
        linarith [(norm_bounds_of_mem_ball_one hb).2]
      · left; exact hY
  have hdisj : Disjoint isoY (closedBall 0 2) := disjoint_left.2 fun z hz hb => by
    have := two_lt_norm_of_mem_isoY hz
    rw [mem_closedBall, dist_zero_right] at hb
    linarith
  have hcl2 : (2 : ℂ) ∈ closure isoY := by
    refine Metric.mem_closure_iff.2 fun δ hδ => ?_
    set t : ℝ := min (δ / 2) (1 / 8) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have htδ : t < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have ht8 : t ≤ 1 / 8 := min_le_right _ _
    refine ⟨2 + (t : ℂ), ⟨?_, ?_⟩, ?_⟩
    · rw [add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; linarith
    · rw [add_sub_cancel_left]
      simp only [Complex.ofReal_im, Complex.ofReal_re, abs_zero]
      exact mul_pos (Real.sqrt_pos.2 (by norm_num)) ht0
    · rw [dist_eq_norm, show (2 : ℂ) - (2 + (t : ℂ)) = -(t : ℂ) by ring, norm_neg, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos ht0]
      exact htδ
  have hr2 : isoFrag.r2Contacts 0 (-(1 / 8)) (1 / 8) 0 = {0} := by
    ext θ
    simp only [ArcMap.r2Contacts, mem_setOf_eq, mem_singleton_iff]
    constructor
    · rintro ⟨hθ, hcl⟩
      have hK : ∀ z ∈ closure (isoFrag.region 0), ‖z‖ ≤ 5 / 4 ∨ (‖z - 2‖ ≤ 1 / 4 ∧ |(z - 2).im| ≤ √3 * (z - 2).re) := by
        intro z hz
        have hKc : IsClosed {z : ℂ | ‖z‖ ≤ 5 / 4 ∨ (‖z - 2‖ ≤ 1 / 4 ∧ |(z - 2).im| ≤ √3 * (z - 2).re)} :=
          (isClosed_le continuous_norm continuous_const).union
            ((isClosed_le (f := fun z : ℂ => ‖z - 2‖) (g := fun _ => (1 / 4 : ℝ)) (by fun_prop) continuous_const).inter
              (isClosed_le (f := fun z : ℂ => |(z - 2).im|) (g := fun z : ℂ => √3 * (z - 2).re) (by fun_prop) (by fun_prop)))
        refine closure_minimal (fun w hw => ?_) hKc hz
        rcases hw.1.1 with hb | hY
        · exact Or.inl (norm_bounds_of_mem_ball_one hb).2.le
        · exact Or.inr ⟨hY.1.le, hY.2.le⟩
      have h2 := hK _ hcl
      have hn2 : ‖(0 : ℂ) + 2 * e θ‖ = 2 := by simp [e]
      rcases h2 with h | ⟨-, h⟩
      · rw [hn2] at h; linarith
      · have hre : ((0 : ℂ) + 2 * e θ - 2).re = 2 * (Real.cos θ - 1) := by simp [e, Complex.exp_ofReal_mul_I_re]; ring
        have him : ((0 : ℂ) + 2 * e θ - 2).im = 2 * Real.sin θ := by simp [e, Complex.exp_ofReal_mul_I_im]
        rw [hre, him] at h
        have h3 : 0 < √3 := Real.sqrt_pos.2 (by norm_num)
        have hc1 : Real.cos θ ≤ 1 := Real.cos_le_one θ
        have hcc : Real.cos θ = 1 := by
          have := abs_nonneg (2 * Real.sin θ)
          nlinarith [mul_nonneg h3.le (sub_nonneg.2 hc1)]
        have hs0 : Real.sin θ = 0 := by
          have hsq := Real.sin_sq_add_cos_sq θ
          rw [hcc] at hsq
          nlinarith
        exact (Real.sin_eq_zero_iff_of_lt_of_lt (by linarith [hθ.1, Real.pi_gt_three]) (by linarith [hθ.2, Real.pi_gt_three])).1 hs0
    · rintro rfl
      exact ⟨⟨by norm_num, by norm_num⟩, closure_mono (fun z hz => hYreg z hz) (by simpa [e] using hcl2)⟩
  have hev : ∀ᶠ s : ℝ in 𝓝[>] 0, ¬ isoFrag.IsClear 0 (0 + (1 + (s : ℂ)) * e 0) := by
    filter_upwards [Ioo_mem_nhdsGT (by norm_num : (0 : ℝ) < 1 / 4)] with s hs hclear
    have hmem : (2 + (s : ℂ)) ∈ isoY := by
      refine ⟨?_, ?_⟩
      · rw [add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hs.1]; exact hs.2
      · rw [add_sub_cancel_left]
        simp only [Complex.ofReal_im, Complex.ofReal_re, abs_zero]
        exact mul_pos (Real.sqrt_pos.2 (by norm_num)) hs.1
    refine hclear _ (hYreg _ hmem) ?_
    rw [dist_eq_norm]
    simp [e]
    ring_nf
    simp
  exact ⟨hvalid, harc, h0, htile, hdisj, hcl2, hr2, hev⟩

/-! ## FS112-FLANK: N4-FLANK at a horn bound `±1` -/

/-- **FS112-FLANK**, the band: a connected set inside `B(v, 1)` with `N` in its closure (an in-type tile at `N`) shadows every point of
a horn at `v` whose upper bound has curvature at most `1`, near `v` — at `κ₂ = 1` this is the band of the horn N4-FLANK's list of
shadows omits. No map is read. -/
theorem inType_shadows_horn (v : ℂ) {α κ₁ κ₂ : ℝ} (hκ₂ : κ₂ ≤ 1) {X : Set ℂ} (hX : IsPreconnected X)
    (hXv : X ⊆ ball v 1) (hN : v + e (α + π / 2) ∈ closure X) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ κ₂ r ⊆ shadow X := by
  obtain ⟨p₀, hp₀⟩ := closure_nonempty_iff.mp ⟨_, hN⟩
  have hp₀v : dist p₀ v < 1 := hXv hp₀
  filter_upwards [Ioo_mem_nhdsGT (show 0 < 1 - dist p₀ v by linarith)] with r hr z hz
  obtain ⟨hzd, -, -, hzB⟩ := hz
  -- below `ω(N)`'s arc: farther than `1` from `N`
  have hzN : 1 < dist z (v + e (α + π / 2)) := by
    refine (tanBelow_one_iff v α z).mp ?_
    unfold TanBelow at hzB ⊢
    unfold tanHeight at hzB ⊢
    nlinarith [sq_nonneg (frameX v α z), sq_nonneg (frameY v α z)]
  have hzp₀ : dist z p₀ < 1 := by
    calc dist z p₀ ≤ dist z v + dist v p₀ := dist_triangle _ _ _
      _ < r + dist p₀ v := by rw [dist_comm v p₀]; linarith
      _ < 1 := by linarith [hr.2]
  obtain ⟨y₁, hy₁, hy₁d⟩ := Metric.mem_closure_iff.mp hN (dist z (v + e (α + π / 2)) - 1) (by linarith)
  have hzy₁ : 1 < dist z y₁ := by
    have := dist_triangle z y₁ (v + e (α + π / 2))
    rw [dist_comm y₁ _] at this
    linarith [hy₁d, dist_comm (v + e (α + π / 2)) y₁]
  have hcont : ContinuousOn (fun y => dist z y) X := by fun_prop
  obtain ⟨y, hy, hyd⟩ := hX.intermediate_value hp₀ hy₁ hcont (show (1 : ℝ) ∈ Icc (dist z p₀) (dist z y₁) from ⟨hzp₀.le, hzy₁.le⟩)
  exact ⟨y, hy, hyd⟩

/-- **FS112-FLANK**, Siamese: when a horn's upper arc lies on `ω(N)` (`κ₂ = 1`) its upper flank lies inside `B(N, 1)`, so a tile of the
flank colour inside `B(v, 1)` with `N` in its closure (in-type at `N`) is Siamese with the flank — within `< 1` of every flank point
near `v`. -/
theorem flank_siamese_of_inType (hF : F.Valid) {v : ℂ} {α κ' : ℝ} (hκ' : 1 < κ') {g : Fin k}
    (hfl : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α 1 κ' r ⊆ F.region g) {X : Set ℂ} (hX : F.TileOf g X)
    (hXv : X ⊆ ball v 1) (hN : v + e (α + π / 2) ∈ closure X) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α 1 κ' r, ∀ x ∈ X, dist x z < 1 := by
  have _ := hκ'
  have _ := hXv
  filter_upwards [hfl] with r hr z hz x hx
  have hzg : z ∈ F.region g := hr hz
  have hzN : dist z (v + e (α + π / 2)) < 1 := (tanAbove_one_iff v α z).mp hz.2.2.1
  have hT : F.IsTile (connectedComponentIn F.interiorPts z) := ⟨z, hzg.1, rfl⟩
  have hzT : z ∈ connectedComponentIn F.interiorPts z := mem_connectedComponentIn hzg.1
  have hTg : F.TileOf g (connectedComponentIn F.interiorPts z) := by
    have := hT.tileOf hzT
    rwa [show F.col z = g from hzg.2] at this
  rcases unitNear_or_unitFar hF hTg hX with hnear | hfar
  · rw [dist_comm]; exact hnear z hzT x hx
  · exfalso
    obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hN (1 - dist z (v + e (α + π / 2))) (by linarith)
    have h1 := hfar z hzT y hy
    have := dist_triangle z (v + e (α + π / 2)) y
    linarith

/-! ## FS112-N2-FLANK-Q: horn bounds `±1` sit on (Q) or (R2) arcs -/

/-- **FS112-N2-FLANK-Q**, the upper bound `κ₂ = 1`. Let `c` have a horn at `v` along `e α` whose upper arc lies on `ω(N)`, with flank
colour `g` above it and an out-type `c`-contact at `N` (N3-DEG's, where `int D_c(v) = ∅`), and suppose every arc of `Γ` on `ω(N)` with
constant sides is (Q) or (R2) — **N2-RED's conclusion at `N` (FS112-N2-TERM's clause 1, a wave-5 row), a named hypothesis**. Then the
horn's upper arc is an arc of `Γ` on `ω(N)` from `v` (inner colour `g`, outer `c`), and either it is (Q) and a `g`-tile inside `B(v, 1)`
has `N` in its closure (FLANK's in-type exception), or it is (R2): `g` is not carried at `N`, the radius-2 point `S′` lies in the closure
of `g`'s class, every `g`-tile at `S′` is out-type, and `g`'s class shadows the whole horn near `v` (`σ_g = κ₂`, by `f̃(1/2) = 1`). -/
theorem flankQ_upper (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hg : F.IsFlankAbove v α 1 g)
    (hcN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2)))
    (hQR : ∀ θ₁ θ₂ d d', F.IsRingArc (v + e (α + π / 2)) θ₁ θ₂ d d' →
      F.IsQArc (v + e (α + π / 2)) θ₁ θ₂ ∨ F.IsR2Arc (v + e (α + π / 2)) θ₁ θ₂) :
    ∃ θ₂, α - π / 2 < θ₂ ∧ F.IsRingArc (v + e (α + π / 2)) (α - π / 2) θ₂ g c ∧
      ((F.IsQArc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧
          ∃ T, F.TileOf g T ∧ T ⊆ ball v 1 ∧ v + e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧ g ∉ F.coloursAt (v + e (α + π / 2)) ∧
          v - e (α + π / 2) ∈ closure (F.region g) ∧ F.OutType v g (v - e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ 1 r ⊆ shadow (F.region g))) := by
  sorry

/-- **FS112-N2-FLANK-Q**, the lower bound `κ₁ = −1`, the mirror: the horn's lower arc on `ω(S′)` with flank colour `h` below, an out-type
`c`-contact at `S′`, and every arc of `Γ` on `ω(S′)` with constant sides (Q) or (R2) (the same named hypothesis at `S′`): the lower arc is
an arc of `Γ` on `ω(S′)` ending at `v` (inner colour `h`, outer `c`), and either it is (Q) with an `h`-tile inside `B(v, 1)` touching
`S′`, or it is (R2) with `N` in the closure of `h`'s class, every `h`-tile at `N` out-type, and `h` shadowing the whole horn near `v`
(`f(−1/2) = −1`). -/
theorem flankQ_lower (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α (-1) κ₂ c) (hh : F.IsFlankBelow v α (-1) h)
    (hcS : F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2)))
    (hQR : ∀ θ₁ θ₂ d d', F.IsRingArc (v - e (α + π / 2)) θ₁ θ₂ d d' →
      F.IsQArc (v - e (α + π / 2)) θ₁ θ₂ ∨ F.IsR2Arc (v - e (α + π / 2)) θ₁ θ₂) :
    ∃ θ₁, θ₁ < α + π / 2 ∧ F.IsRingArc (v - e (α + π / 2)) θ₁ (α + π / 2) h c ∧
      ((F.IsQArc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧
          ∃ T, F.TileOf h T ∧ T ⊆ ball v 1 ∧ v - e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧ h ∉ F.coloursAt (v - e (α + π / 2)) ∧
          v + e (α + π / 2) ∈ closure (F.region h) ∧ F.OutType v h (v + e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α (-1) κ₂ r ⊆ shadow (F.region h))) := by
  sorry

/-- **FS112-N2-FLANK-Q**, "then both horns' upper arcs form one arc of `ω(N)` through `v`": if `c` has horns along `±a` at `v`, the one
along `+a` bounded above by `ω(N)`, one tile `T_g` of a colour `g` lies directly on the `+n` side of both horns, a `g`-tile inside
`B(v, 1)` has `N` in its closure (FLANK's exception) and a `c`-tile at `N` is out-type, then the `−a` horn's arc on the `+n` side lies on
`ω(N)` too: its bound there is `−1` in its own frame (where `n` is reversed). -/
theorem flankQ_both (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₃ κ₄ κ' κ'' : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hH' : F.IsHorn v (α + π) κ₃ κ₄ c)
    (hcN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2)))
    {Tg : Set ℂ} (hTg : F.TileOf g Tg) (hκ' : 1 < κ') (hκ'' : κ'' < κ₃)
    (hab : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α 1 κ' r ⊆ Tg)
    (hbe : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v (α + π) κ'' κ₃ r ⊆ Tg)
    {X : Set ℂ} (hX : F.TileOf g X) (hXv : X ⊆ ball v 1) (hXN : v + e (α + π / 2) ∈ closure X) :
    κ₃ = -1 := by
  have _ := hH
  have _ := hXv
  have hvdom : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  have hNdom : v + e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, dist_eq_norm]; simp)
  have hepi : e (α + π + π / 2) = -e (α + π / 2) := by
    rw [show α + π + π / 2 = (α + π / 2) + π by ring, e_add_pi]
  have hconvA : ∀ z, TanAbove v (α + π) (-1) z ↔ 1 < dist z (v + e (α + π / 2)) := by
    intro z; rw [tanAbove_neg_one_iff, hepi, sub_neg_eq_add]
  have hconvB : ∀ z, TanBelow v (α + π) (-1) z ↔ dist z (v + e (α + π / 2)) < 1 := by
    intro z; rw [tanBelow_neg_one_iff, hepi, sub_neg_eq_add]
  -- Step 1: the tile `T_g` lies in `B̄(N, 1)` (Siamese with `X`)
  obtain ⟨r₀, hr₀sub, hr₀pos⟩ := (hab.and eventually_mem_nhdsWithin).exists
  have hr₀ : 0 < r₀ := hr₀pos
  obtain ⟨z₀, hz₀, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := 1) (κ₂ := κ') (s := (1 + κ') / 2) (m := 1) hr₀
    (by linarith) (by linarith) (by intro h; linarith)
  have hz₀T : z₀ ∈ Tg := hr₀sub hz₀
  have hz₀N : dist z₀ (v + e (α + π / 2)) < 1 := (tanAbove_one_iff v α z₀).mp hz₀.2.2.1
  have hnear : UnitNear Tg X := by
    rcases unitNear_or_unitFar hF hTg hX with h | h
    · exact h
    · exfalso
      obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hXN (1 - dist z₀ (v + e (α + π / 2))) (by linarith)
      have h1 := h z₀ hz₀T y hy
      have := dist_triangle z₀ (v + e (α + π / 2)) y
      linarith
  have hTgN : ∀ t ∈ Tg, dist t (v + e (α + π / 2)) ≤ 1 := by
    intro t ht
    have hsub : closure X ⊆ closedBall t 1 := by
      refine closure_minimal (fun x hx => ?_) isClosed_closedBall
      rw [mem_closedBall, dist_comm]; exact (hnear t ht x hx).le
    have := mem_closedBall.mp (hsub hXN)
    rwa [dist_comm] at this
  apply le_antisymm
  · -- κ₃ ≤ -1: the flank horn lies in `T_g ⊆ B̄(N, 1)`
    by_contra hlt
    rw [not_le] at hlt
    obtain ⟨r, hrsub, hrpos⟩ := (hbe.and eventually_mem_nhdsWithin).exists
    obtain ⟨z, hz, hzA, -⟩ := exists_mem_hornSet_aboveBelow v (α + π) (κ₁ := κ'') (κ₂ := κ₃)
      (s := (max κ'' (-1) + κ₃) / 2) (m := -1) hrpos
      (by have := le_max_left κ'' (-1); linarith [max_lt hκ'' hlt]) (by linarith [max_lt hκ'' hlt])
      (by intro h; linarith [le_max_right κ'' (-1), max_lt hκ'' hlt])
    have hzA' := hzA (by linarith [le_max_right κ'' (-1), max_lt hκ'' hlt])
    have := hTgN z (hrsub hz)
    have h2 := (hconvA z).mp hzA'
    linarith
  · -- κ₃ ≥ -1: the `c`-horn lies outside `B(N, 1)` (N-E2 against the out-type `c`-tile at `N`)
    by_contra hlt
    rw [not_le] at hlt
    obtain ⟨r, ⟨hsec, hcol⟩, hrpos⟩ := (hH'.2.and eventually_mem_nhdsWithin).exists
    obtain ⟨z, hz, -, hzB⟩ := exists_mem_hornSet_aboveBelow v (α + π) (κ₁ := κ₃) (κ₂ := κ₄)
      (s := (κ₃ + min κ₄ (-1)) / 2) (m := -1) hrpos
      (by linarith [lt_min hH'.1 hlt]) (by linarith [min_le_left κ₄ (-1), lt_min hH'.1 hlt])
      (by intro h; linarith [min_le_right κ₄ (-1), lt_min hH'.1 hlt])
    have hzB' := hzB (by linarith [min_le_right κ₄ (-1), lt_min hH'.1 hlt])
    have hzN : dist z (v + e (α + π / 2)) < 1 := (hconvB z).mp hzB'
    obtain ⟨x, hx, hSeq, hvcl⟩ := hsec
    have hSpre : IsPreconnected (hornSet v (α + π) κ₃ κ₄ r) := by
      rw [hSeq]; exact isPreconnected_connectedComponentIn
    have hSsub : hornSet v (α + π) κ₃ κ₄ r ⊆ F.interiorPts := by
      rw [hSeq]; exact (connectedComponentIn_subset _ _).trans inter_subset_left
    have hTz : F.IsTile (connectedComponentIn F.interiorPts z) := ⟨z, hSsub hz, rfl⟩
    have hzT : z ∈ connectedComponentIn F.interiorPts z := mem_connectedComponentIn (hSsub hz)
    have hTzc : F.TileOf c (connectedComponentIn F.interiorPts z) := by
      have := hTz.tileOf hzT
      rwa [show F.col z = c from hcol hz] at this
    have hST : hornSet v (α + π) κ₃ κ₄ r ⊆ connectedComponentIn F.interiorPts z :=
      hSpre.subset_connectedComponentIn hz hSsub
    have hvT : v ∈ closure (connectedComponentIn F.interiorPts z) := closure_mono hST hvcl
    obtain ⟨TN, hTN, hNT⟩ := (F.mem_coloursAt_iff_exists_tileOf hNdom).mp hcN.1.2.2
    have hout := hcN.2 TN hTN hNT
    have hnear' : UnitNear (connectedComponentIn F.interiorPts z) TN :=
      unitNear_of_mem_closure hF hTzc hTN (subset_closure hzT) hNT hzN
    obtain ⟨b, hb⟩ := hTN.1.nonempty
    have hsub : closure (connectedComponentIn F.interiorPts z) ⊆ closedBall b 1 := by
      refine closure_minimal (fun a ha => ?_) isClosed_closedBall
      rw [mem_closedBall]; exact (hnear' a ha b hb).le
    have hvb : b ∈ closedBall v 1 := by
      have := mem_closedBall.mp (hsub hvT)
      rw [mem_closedBall, dist_comm]; exact this
    exact disjoint_left.mp hout hb hvb

/-! ## FS112-A4SIX and FS112-NB4P: four-colour vertices and their rings -/

/-- **FS112-A4SIX** (C-UA-BUDGET, branch 1), at the class its argument reads: a point `v` of a valid map at which exactly two colours
are absent (a four-colour vertex, at six colours), with no covering pair `(v, y)` on its unit circle, has on that circle arcs of `Γ`
of total length at least `60°`, or at least six, one inside each of six consecutive open `60°` windows. -/
theorem a4six (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {a b : Fin k} (hab : a ≠ b)
    (habs : (F.coloursAt v)ᶜ = {a, b}) (hno : ∀ y ∈ sphere v 1, ¬ F.IsCoveringPair v y) :
    ENNReal.ofReal (π / 3) ≤ arcLength {θ | F.OnRingArc v (ringPt v θ)} ∨
      ∃ x : ℝ, ∀ j : Fin 6, ∃ θ₁ θ₂, x + (j : ℕ) * (π / 3) < θ₁ ∧ θ₁ < θ₂ ∧ θ₂ < x + ((j : ℕ) + 1) * (π / 3) ∧
        ringArc v θ₁ θ₂ ⊆ F.Γ := by
  sorry

/-- **FS112-NB4P** (NB-4 corrected): at a point `v` of exactly four colours of a valid six-coloured map, let `y₀ = r(ψ)` be a change
point of its ring (a covering pair with `v`, automatically) and `y_j = r(ψ + j·60°)` its `σ_v`-orbit. If no orbit point lies on an arc
of `Γ` on `ω(v)` (closed arcs, so ends included), and no arc of `Γ` on `ω(y_{j±1})` has `y_j` on it, contradiction. The bound on the
colours at `y_j` is not needed (not a hypothesis). -/
theorem nb4p {G : ArcMap 6} (hF : G.Valid) {v : ℂ} (hv : G.Covers v 1) (h4 : (G.coloursAt v).ncard = 4) {ψ : ℝ}
    {X X' : Fin 6} (hy : G.IsChangePoint v ψ X X')
    (hring : ∀ j : ℕ, j < 6 → ¬ G.OnRingArc v (ringPt v (ψ + j * (π / 3))))
    (hnb : ∀ j : ℕ, j < 6 →
      ¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) + 1) * (π / 3))) (ringPt v (ψ + j * (π / 3))) ∧
        ¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) - 1) * (π / 3))) (ringPt v (ψ + j * (π / 3)))) :
    False := by
  sorry

end ArcMap

end HadwigerNelson.Plane
