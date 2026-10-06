import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Mathlib.Analysis.Real.Pi.Bounds
import Proofs.HadwigerNelson.Plane.RingGerm
import Proofs.HadwigerNelson.Plane.ValidMap.Sectors

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
  `n2_env_near_away`), the bends (`bend_toward`, `bend_away_whole`).
* **FS112-ISO** (`isoFrag`, `iso`); **FS112-FLANK** (`inType_shadows_horn`, `flank_siamese_of_inType`; its third clause, the bowtie's
  witness, is `flank_incomplete_bowtie` in `Plane/ValidMap/BaseSteps`); **FS112-N2-FLANK-Q** (`flankQ_upper`, `flankQ_lower`,
  `flankQ_both`).
* **FS112-A4SIX** (`a4six`); **FS112-NB4P** (`nb4p`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `fromFrame` has the `x` coordinate it is built from. -/
theorem frameX_fromFrame (v : ℂ) (α x y : ℝ) : frameX v α (fromFrame v α x y) = x := by
  have hce := conj_e_mul_e α
  unfold frameX fromFrame
  have : (v + ((x : ℂ) + (y : ℂ) * I) * e α - v) * starRingEnd ℂ (e α) = (x : ℂ) + (y : ℂ) * I := by
    calc _ = ((x : ℂ) + (y : ℂ) * I) * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [hce, mul_one]
  rw [this]; simp

/-- `fromFrame` has the `y` coordinate it is built from. -/
theorem frameY_fromFrame (v : ℂ) (α x y : ℝ) : frameY v α (fromFrame v α x y) = y := by
  have hce := conj_e_mul_e α
  unfold frameY fromFrame
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
  have hc : Continuous fun t : ℝ => fromFrame v α t (s * t ^ 2 / 2) := by unfold fromFrame; fun_prop
  have hdist : ∀ᶠ t in 𝓝 (0 : ℝ), dist (fromFrame v α t (s * t ^ 2 / 2)) v < r := by
    have := hc.tendsto 0
    have h0 : fromFrame v α 0 (s * 0 ^ 2 / 2) = v := by simp [fromFrame]
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
      dist (fromFrame v α t (s * t ^ 2 / 2)) v < r := by
    filter_upwards [e1, e2, e3, eventually_mem_nhdsWithin, hdist.filter_mono nhdsWithin_le_nhds] with t a b c d e
    exact ⟨a, b, c, d, e⟩
  obtain ⟨t, ht1, ht2, ht3, ht0, hd⟩ := hall.exists
  have ht0' : 0 < t := ht0
  have hX : frameX v α (fromFrame v α t (s * t ^ 2 / 2)) = t := frameX_fromFrame v α _ _
  have hY : frameY v α (fromFrame v α t (s * t ^ 2 / 2)) = s * t ^ 2 / 2 := frameY_fromFrame v α _ _
  have hpos : 0 < t ^ 2 / 2 := by positivity
  refine ⟨fromFrame v α t (s * t ^ 2 / 2), ⟨hd, by rw [hX]; exact ht0', ?_, ?_⟩, ?_, ?_⟩
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
  -- the open arc lies in the closure of the outer class; an outer point near one interior point of the arc is within `1` of
  -- every interior point (the crossing engine), and two interior points more than `60°` apart are more than `1` apart
  by_contra hlt
  push Not at hlt
  have hπ := Real.pi_pos
  have hmin : π / 3 < min (θ₂ - θ₁) π := lt_min hlt (by linarith)
  set t := (π / 3 + min (θ₂ - θ₁) π) / 2 with ht
  have ht1 : π / 3 < t := by linarith
  have htℓ : t < θ₂ - θ₁ := by linarith [min_le_left (θ₂ - θ₁) π]
  have htπ : t ≤ π := by linarith [min_le_right (θ₂ - θ₁) π]
  set θ := θ₁ + (θ₂ - θ₁ - t) / 2 with hθ
  have hθm : θ ∈ Ioo θ₁ θ₂ := ⟨by linarith, by linarith⟩
  have hφm : θ + t ∈ Ioo θ₁ θ₂ := ⟨by linarith, by linarith⟩
  have habs : |θ - (θ + t)| = t := by rw [show θ - (θ + t) = -t by ring, abs_neg, abs_of_pos (by linarith)]
  have hfar : 1 < dist (ringPt P θ) (ringPt P (θ + t)) :=
    ((dist_ringPt_ringPt_cmp_one P (by rw [habs]; exact htπ)).2.2).mpr (by rw [habs]; exact ht1)
  have hcl : ∀ φ ∈ Ioo θ₁ θ₂, ringPt P φ ∈ closure (F.region c') := by
    intro φ hφ
    have : c' ∈ F.outerColours P (ringPt P φ) := by rw [(hA.2.2 φ hφ).2]; rfl
    exact closure_mono sdiff_subset this
  obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp (hcl θ hθm)
    (min (dist (ringPt P θ) (ringPt P (θ + t)) - 1) 1) (lt_min (by linarith) one_pos)
  have hcont : Continuous fun φ : ℝ => ringPt P φ := by unfold ringPt e; fun_prop
  have hS : IsPreconnected ((fun φ : ℝ => ringPt P φ) '' Ioo θ₁ θ₂) := isPreconnected_Ioo.image _ hcont.continuousOn
  rcases hF.dist_lt_or_gt_of_isPreconnected hz hS (by rintro _ ⟨φ, hφ, rfl⟩; exact hcl φ hφ) with h | h
  · have h1 := h _ ⟨θ + t, hφm, rfl⟩
    have := dist_triangle (ringPt P θ) z (ringPt P (θ + t))
    linarith [min_le_left (dist (ringPt P θ) (ringPt P (θ + t)) - 1) 1]
  · have h1 := h _ ⟨θ, hθm, rfl⟩
    rw [dist_comm] at h1
    linarith [min_le_right (dist (ringPt P θ) (ringPt P (θ + t)) - 1) 1]

/-- Two points `x`, `x + π` of an angular interval of length at most one turn: one of the two open half-turns between them lies in its
open interior. -/
theorem angleIcc_half_turn {a b x : ℝ} (hb : b ≤ a + 2 * π) (h1 : x ∈ angleIcc a b) (h2 : x + π ∈ angleIcc a b) :
    (∀ y, x < y → y < x + π → y ∈ angleIoo a b) ∨ ∀ y, x + π < y → y < x + 2 * π → y ∈ angleIoo a b := by
  have hπ := Real.pi_pos
  obtain ⟨m₁, h11, h12⟩ := mem_iUnion.mp h1
  obtain ⟨m₂, h21, h22⟩ := mem_iUnion.mp h2
  have hk1 : (m₁ : ℝ) < m₂ + 1 := by
    by_contra hc; push Not at hc
    nlinarith [mul_le_mul_of_nonneg_left hc (by positivity : (0 : ℝ) ≤ 2 * π)]
  have hk2 : (m₂ : ℝ) < m₁ + 2 := by
    by_contra hc; push Not at hc
    nlinarith [mul_le_mul_of_nonneg_left hc (by positivity : (0 : ℝ) ≤ 2 * π)]
  have hk1' : m₁ < m₂ + 1 := by exact_mod_cast hk1
  have hk2' : m₂ < m₁ + 2 := by exact_mod_cast hk2
  rcases (show m₂ = m₁ ∨ m₂ = m₁ + 1 by omega) with h | h
  · left
    subst h
    intro y hy1 hy2
    exact mem_iUnion.mpr ⟨m₂, by linarith, by linarith⟩
  · right
    subst h
    intro y hy1 hy2
    push_cast at h21 h22
    exact mem_iUnion.mpr ⟨m₁ + 1, by push_cast; linarith, by push_cast; linarith⟩

/-- **FS112-N3-NOBOTH**: the centre of a both-kind unit arc, a point of the domain, carries at least four colours or a repeated
colour. (`P ∈ F.dom` is the hypothesis FS116-V5-U1's last clauses need, wave 3's finding.) -/
theorem noBoth (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} (hP : P ∈ F.dom) (hA : F.BothKind P θ₁ θ₂) :
    4 ≤ (F.coloursAt P).ncard ∨ F.HasRepeatedColour P := by
  obtain ⟨c, c', hR, hc, hc'⟩ := hA
  have hπ := Real.pi_pos
  have h12 : θ₁ < θ₂ := hR.1
  have hfac := ringArc_cone_inner hF hR
  have haway := ringArc_cone_outer hF hR
  obtain ⟨γ, hγ⟩ := coneAt_region_nonempty hc
  obtain ⟨γ', hγ'⟩ := coneAt_region_nonempty hc'
  -- the two side colours differ: their cones face the arc and face away
  have hcc' : c ≠ c' := by
    rintro rfl
    obtain ⟨i, hi1, hi2⟩ := mem_iUnion.mp (hfac hγ)
    obtain ⟨j, hj1, hj2⟩ := mem_iUnion.mp (haway hγ)
    exact disj_lifts h12 i j ⟨hi1, hi2⟩ ⟨hj1, hj2⟩
  -- the two side cones hold colours other than `c`, `c'`
  obtain ⟨d₁, hd₁c, hd₁c', hd₁⟩ := F.ringArc_sideCone_other hF hP hR (β := (θ₁ + θ₂) / 2 - π / 2)
    (Or.inl (Ioo_subset_angleIoo _ _ ⟨by linarith, by linarith⟩))
  obtain ⟨d₂, hd₂c, hd₂c', hd₂⟩ := F.ringArc_sideCone_other hF hP hR (β := (θ₁ + θ₂) / 2 + π / 2)
    (Or.inr (Ioo_subset_angleIoo _ _ ⟨by linarith, by linarith⟩))
  by_cases h4 : 4 ≤ (F.coloursAt P).ncard
  · exact Or.inl h4
  right
  -- at most three colours: the two side cones carry one colour `d`
  have hd : d₁ = d₂ := by
    by_contra hne
    apply h4
    have hd₁z : d₁ ∈ F.coloursAt P := mem_closure_of_mem_coneAt hd₁
    have hd₂z : d₂ ∈ F.coloursAt P := mem_closure_of_mem_coneAt hd₂
    classical
    have hcard : ({c, c', d₁, d₂} : Finset (Fin k)).card = 4 := by
      rw [Finset.card_insert_of_notMem, Finset.card_insert_of_notMem, Finset.card_pair hne]
      · simp [Ne.symm hd₁c', Ne.symm hd₂c']
      · simp [hcc', Ne.symm hd₁c, Ne.symm hd₂c]
    have hsub : (↑({c, c', d₁, d₂} : Finset (Fin k)) : Set (Fin k)) ⊆ F.coloursAt P := by
      intro x hx
      simp only [Finset.coe_insert, Finset.coe_singleton, mem_insert_iff, mem_singleton_iff] at hx
      rcases hx with rfl | rfl | rfl | rfl <;> assumption
    have := Set.ncard_le_ncard hsub (Set.toFinite _)
    rwa [Set.ncard_coe_finset, hcard] at this
  subst hd
  -- the sector chart at `P`; it has a germ, since `P` carries two colours
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hP
  have hn : 0 < n := by
    by_contra h0
    have hn0 : n = 0 := by omega
    have hle := hC.ncard_coloursAt_le
    rw [hn0] at hle
    have h2 : 2 ≤ (F.coloursAt P).ncard := by
      have hs : ({c, c'} : Set (Fin k)) ⊆ F.coloursAt P := by
        intro x hx
        rcases hx with rfl | rfl
        · exact hc
        · exact hc'
      have := Set.ncard_le_ncard hs (Set.toFinite _)
      rwa [Set.ncard_pair hcc'] at this
    have h1 : max 0 1 = 1 := rfl
    rw [h1] at hle
    omega
  refine ⟨d₁, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
  have hM := hC.sorted.mono
  obtain ⟨i₁, hi₁, hs₁⟩ := hC.exists_sector_of_mem_coneAt_region hn hr hd₁
  obtain ⟨i₂, hi₂, hs₂⟩ := hC.exists_sector_of_mem_coneAt_region hn hr hd₂
  have hsec : ∀ i, G.sector P r i ⊆ F.region d₁ → G.sector P r i ∈ F.sectorsOf P r d₁ := fun i hi =>
    ⟨(hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, fun z hz => (hi hz).2⟩
  -- a sector of another colour `e` at a direction `δ` strictly inside sector `i₁`'s interval is impossible
  have hno : ∀ {e : Fin k} {δ : ℝ}, e ≠ d₁ → δ ∈ coneAt (F.region e) P →
      δ ∉ angleIoo (G.β i₁) (G.nextβ i₁) := by
    intro e δ hne hδ hδo
    obtain ⟨j, hδj, hsj⟩ := hC.exists_sector_of_mem_coneAt_region hn hr hδ
    have hji : i₁ ≠ j := by
      rintro rfl
      obtain ⟨z, hz⟩ := hC.sector_nonempty hr i₁
      exact hne ((hsj hz).2.symm.trans (hs₁ hz).2)
    rw [hC.cone r hr j] at hδj
    exact disjoint_left.mp (hM.disjoint hji) hδj hδo
  by_cases hii : i₁ = i₂
  · exfalso
    subst hii
    rw [hC.cone r hr i₁] at hi₁ hi₂
    rcases angleIcc_half_turn (hM.nextβ_le_add i₁) hi₁
        (by rwa [show (θ₁ + θ₂) / 2 - π / 2 + π = (θ₁ + θ₂) / 2 + π / 2 by ring]) with hcase | hcase
    · -- the facing half-turn: the inner colour's direction
      obtain ⟨l, hl1, hl2⟩ := mem_iUnion.mp (hfac hγ)
      refine hno (Ne.symm hd₁c) hγ ?_
      obtain ⟨q, hq1, hq2⟩ := mem_iUnion.mp (hcase (γ - 2 * π * l) (by linarith) (by linarith))
      exact mem_iUnion.mpr ⟨q + l, by push_cast; linarith, by push_cast; linarith⟩
    · -- the away half-turn: the outer colour's direction
      obtain ⟨l, hl1, hl2⟩ := mem_iUnion.mp (haway hγ')
      refine hno (Ne.symm hd₁c') hγ' ?_
      obtain ⟨q, hq1, hq2⟩ := mem_iUnion.mp (hcase (γ' - 2 * π * l) (by linarith) (by linarith))
      exact mem_iUnion.mpr ⟨q + l, by push_cast; linarith, by push_cast; linarith⟩
  · -- two distinct sectors of the colour `d`
    have hne : G.sector P r i₁ ≠ G.sector P r i₂ := by
      intro h
      obtain ⟨z, hz⟩ := hC.sector_nonempty hr i₁
      exact disjoint_left.mp (hC.disjoint r hr i₁ i₂ hii) hz (h ▸ hz)
    calc (2 : ℕ∞) = ({G.sector P r i₁, G.sector P r i₂} : Set (Set ℂ)).encard := (encard_pair hne).symm
      _ ≤ _ := encard_le_encard (by
          rintro S (rfl | rfl)
          · exact hsec i₁ hs₁
          · exact hsec i₂ hs₂)

/-! ## Ring arcs from clean arcs of `Γ` (the side colours of an arc of `Γ` on a ring) -/

/-- The real inequality behind `outside_segment`: from a point `w` outside the unit disc within `δ ≤ 1/2` of the unit vector `u`, the
segment to `(1 + δ/2) u` stays outside (`N = ‖w‖²`, `R = w·u`, `D = ‖w − u‖²`). -/
theorem outside_segment_real {a b δ N R D : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1) (hδ0 : 0 < δ) (hδ : δ ≤ 1 / 2)
    (hN : 1 < N) (hD : D < δ ^ 2) (hR : 2 * R = N + 1 - D) :
    1 < a ^ 2 * (1 + δ / 2) ^ 2 + 2 * a * b * (1 + δ / 2) * R + b ^ 2 * N := by
  have hkey : 0 ≤ (1 + δ / 2) * (1 - δ ^ 2 / 2) - 1 := by nlinarith
  have hR' : 1 - δ ^ 2 / 2 < R := by linarith
  have hab0 : 0 ≤ a * b := mul_nonneg ha hb
  rcases eq_or_lt_of_le hb with hb0 | hb0
  · subst hb0
    have : a = 1 := by linarith
    subst this; nlinarith
  · have h1 : a ^ 2 * (1 + δ / 2) ^ 2 ≥ a ^ 2 := by nlinarith [sq_nonneg a]
    have h2 : 2 * a * b * (1 + δ / 2) * R ≥ 2 * a * b := by
      have : (1 + δ / 2) * R ≥ 1 := by nlinarith
      nlinarith
    have h3 : b ^ 2 * N > b ^ 2 := by nlinarith [sq_pos_of_pos hb0]
    have : (a + b) ^ 2 = 1 := by rw [hab]; norm_num
    nlinarith

/-- **The segment from an outside point near `ω(p)`**: for `x = p + e θ`, `δ ≤ 1/2` and `z` outside `B̄(p, 1)` within `δ` of `x`, the
segment from `z` to `p + (1 + δ/2) e θ` lies outside `B̄(p, 1)`. -/
theorem outside_segment {p z : ℂ} {θ δ : ℝ} (hδ0 : 0 < δ) (hδ : δ ≤ 1 / 2) (hz : z ∉ closedBall p 1)
    (hzx : dist z (ringPt p θ) < δ) : segment ℝ z (p + ((1 + δ / 2 : ℝ) : ℂ) * e θ) ⊆ (closedBall p 1)ᶜ := by
  rintro y ⟨a, b, ha, hb, hab, rfl⟩
  rw [mem_compl_iff, mem_closedBall, not_le, dist_eq_norm]
  set w := z - p with hw
  set u := e θ with hu
  have hu1 : u.re ^ 2 + u.im ^ 2 = 1 := by
    have := norm_e θ
    rw [← hu, ← Real.sqrt_sq (norm_nonneg u), ← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at this
    rw [Real.sqrt_eq_one] at this; nlinarith
  have hN : 1 < w.re ^ 2 + w.im ^ 2 := by
    rw [mem_closedBall, not_le, dist_eq_norm, ← hw] at hz
    have h2 : 1 < ‖w‖ ^ 2 := by nlinarith
    rwa [← Complex.normSq_eq_norm_sq, Complex.normSq_apply, ← sq, ← sq] at h2
  have hD : (w.re - u.re) ^ 2 + (w.im - u.im) ^ 2 < δ ^ 2 := by
    rw [dist_eq_norm, ringPt, show z - (p + e θ) = w - u by rw [hw, hu]; ring] at hzx
    have h2 : ‖w - u‖ ^ 2 < δ ^ 2 := by nlinarith [norm_nonneg (w - u)]
    rwa [← Complex.normSq_eq_norm_sq, Complex.normSq_apply, ← sq, ← sq, Complex.sub_re, Complex.sub_im] at h2
  have hR : 2 * (w.re * u.re + w.im * u.im) =
      (w.re ^ 2 + w.im ^ 2) + 1 - ((w.re - u.re) ^ 2 + (w.im - u.im) ^ 2) := by nlinarith
  have hineq := outside_segment_real hb ha (by linarith) hδ0 hδ hN hD hR
  have heq : a • z + b • (p + ((1 + δ / 2 : ℝ) : ℂ) * e θ) - p =
      ((b * (1 + δ / 2) : ℝ) : ℂ) * u + (a : ℂ) * w := by
    rw [Complex.real_smul, Complex.real_smul, hw, hu]
    have : (a : ℂ) + b = 1 := by exact_mod_cast hab
    push_cast
    linear_combination p * this
  rw [heq]
  set A : ℝ := b * (1 + δ / 2) with hA
  have hexp : Complex.normSq ((A : ℂ) * u + (a : ℂ) * w) =
      A ^ 2 * (u.re ^ 2 + u.im ^ 2) + 2 * A * a * (w.re * u.re + w.im * u.im) + a ^ 2 * (w.re ^ 2 + w.im ^ 2) := by
    rw [Complex.normSq_apply]
    simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
      zero_mul, sub_zero, add_zero]
    ring
  have hsq : 1 < ‖(A : ℂ) * u + (a : ℂ) * w‖ ^ 2 := by
    rw [← Complex.normSq_eq_norm_sq, hexp, hu1, hA]
    nlinarith [hineq]
  nlinarith [norm_nonneg ((A : ℂ) * u + (a : ℂ) * w)]

/-- The radial point `p + (1 + t) e θ` is `|t|` from the ring point `r(θ)`. -/
theorem dist_ringPt_radial (p : ℂ) (θ t : ℝ) : dist (p + ((1 + t : ℝ) : ℂ) * e θ) (ringPt p θ) = |t| := by
  rw [dist_eq_norm, ringPt, show p + ((1 + t : ℝ) : ℂ) * e θ - (p + e θ) = (t : ℂ) * e θ by push_cast; ring, norm_mul, norm_e,
    mul_one, Complex.norm_real, Real.norm_eq_abs]

/-- The point `p + ρ e θ`, `ρ ≥ 0`, is `ρ` from `p`. -/
theorem dist_radial_centre (p : ℂ) (θ ρ : ℝ) (hρ : 0 ≤ ρ) : dist (p + (ρ : ℂ) * e θ) p = ρ := by
  rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hρ]

/-- **A ring arc from a clean arc of `Γ`** (child; the base's and the flank rows' "an arc of `Γ` on `ω(p)` has constant sides"): a closed
sub-arc of positive length of `ω(p)` in `Γ`, each of whose interior points has a ball in the domain in which every point of an arc lies on
`ω(p)`, has constant sides — each side of the open arc is one preconnected set of interior points near each point, and the side colour is
locally constant along the arc. -/
theorem isRingArc_of_clean {p : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hΓ : ringArc p θ₁ θ₂ ⊆ F.Γ)
    (hclean : ∀ θ ∈ Ioo θ₁ θ₂, ∃ δ > 0, ball (ringPt p θ) δ ⊆ F.dom ∧
      ∀ z ∈ ball (ringPt p θ) δ, z ∈ ⋃ a ∈ F.arcs, a.carrier → dist z p = 1) :
    ∃ c c', F.IsRingArc p θ₁ θ₂ c c' := by
  choose! δ hδ hdom hcl using hclean
  set d : ℝ → ℝ := fun θ => min (δ θ) (1 / 2) with hd
  have hd0 : ∀ θ ∈ Ioo θ₁ θ₂, 0 < d θ := fun θ hθ => lt_min (hδ θ hθ) (by norm_num)
  have hdδ : ∀ θ, d θ ≤ δ θ := fun θ => min_le_left _ _
  have hd2 : ∀ θ, d θ ≤ 1 / 2 := fun θ => min_le_right _ _
  have hint : ∀ θ ∈ Ioo θ₁ θ₂, ∀ z ∈ ball (ringPt p θ) (d θ), dist z p ≠ 1 → z ∈ F.interiorPts := by
    intro θ hθ z hz hzp
    have hz' : z ∈ ball (ringPt p θ) (δ θ) := ball_subset_ball (hdδ θ) hz
    exact ⟨hdom θ hθ hz', fun h => hzp (hcl θ hθ z hz' h)⟩
  -- the radial points `p + (1 ± t) e θ`
  have hin_mem : ∀ θ ∈ Ioo θ₁ θ₂, ∀ t, 0 < t → t < d θ →
      p + ((1 + -t : ℝ) : ℂ) * e θ ∈ ball (ringPt p θ) (d θ) ∩ ball p 1 := by
    intro θ hθ t ht htd
    refine ⟨?_, ?_⟩
    · rw [mem_ball, dist_ringPt_radial, abs_neg, abs_of_pos ht]; exact htd
    · rw [mem_ball, dist_radial_centre p θ _ (by linarith [hd2 θ])]; linarith
  have hout_mem : ∀ θ ∈ Ioo θ₁ θ₂, ∀ t, 0 < t → t < d θ →
      p + ((1 + t : ℝ) : ℂ) * e θ ∈ ball (ringPt p θ) (d θ) \ closedBall p 1 := by
    intro θ hθ t ht htd
    refine ⟨?_, ?_⟩
    · rw [mem_ball, dist_ringPt_radial, abs_of_pos ht]; exact htd
    · rw [mem_closedBall, dist_radial_centre p θ _ (by linarith), not_le]; linarith
  set cin : ℝ → Fin k := fun θ => F.col (p + ((1 + -(d θ / 2) : ℝ) : ℂ) * e θ) with hcin
  set cout : ℝ → Fin k := fun θ => F.col (p + ((1 + d θ / 2 : ℝ) : ℂ) * e θ) with hcout
  have hFin : ∀ θ ∈ Ioo θ₁ θ₂, ∀ z ∈ ball (ringPt p θ) (d θ) ∩ ball p 1, F.col z = cin θ := by
    intro θ hθ z hz
    have hsub : ball (ringPt p θ) (d θ) ∩ ball p 1 ⊆ F.interiorPts := fun y hy =>
      hint θ hθ y hy.1 (ne_of_lt (mem_ball.mp hy.2))
    exact ((convex_ball _ _).inter (convex_ball _ _)).isPreconnected.constant (F.continuousOn_col.mono hsub) hz
      (hin_mem θ hθ _ (by linarith [hd0 θ hθ]) (by linarith [hd0 θ hθ]))
  have hFout : ∀ θ ∈ Ioo θ₁ θ₂, ∀ z ∈ ball (ringPt p θ) (d θ) \ closedBall p 1, F.col z = cout θ := by
    intro θ hθ z hz
    have hq := hout_mem θ hθ (d θ / 2) (by linarith [hd0 θ hθ]) (by linarith [hd0 θ hθ])
    have hseg := outside_segment (hd0 θ hθ) (hd2 θ) hz.2 (mem_ball.mp hz.1)
    have hsub : segment ℝ z (p + ((1 + d θ / 2 : ℝ) : ℂ) * e θ) ⊆ F.interiorPts := by
      intro y hy
      have hy1 : y ∈ ball (ringPt p θ) (d θ) := (convex_ball _ _).segment_subset hz.1 hq.1 hy
      have hy2 := hseg hy
      rw [mem_compl_iff, mem_closedBall, not_le] at hy2
      exact hint θ hθ y hy1 (ne_of_gt hy2)
    exact (convex_segment _ _).isPreconnected.constant (F.continuousOn_col.mono hsub) (left_mem_segment _ _ _)
      (right_mem_segment _ _ _)
  -- the side colours are locally constant along the open arc
  have hnear : ∀ θ ∈ Ioo θ₁ θ₂, ∀ θ' ∈ Ioo θ₁ θ₂, |θ' - θ| < d θ / 2 → cin θ' = cin θ ∧ cout θ' = cout θ := by
    intro θ hθ θ' hθ' hθθ
    have h0 := hd0 θ hθ
    have h0' := hd0 θ' hθ'
    set t := min (d θ') (d θ / 2) / 2 with ht
    have ht0 : 0 < t := by positivity
    have ht1 : t < d θ' := by linarith [min_le_left (d θ') (d θ / 2)]
    have ht2 : t ≤ d θ / 4 := by linarith [min_le_right (d θ') (d θ / 2)]
    have hpts : dist (ringPt p θ') (ringPt p θ) ≤ |θ' - θ| := by
      rw [dist_eq_norm, ringPt, ringPt, show p + e θ' - (p + e θ) = e θ' - e θ by ring]
      exact norm_e_sub_e_le θ' θ
    constructor
    · have hy := hin_mem θ' hθ' t ht0 ht1
      have hy' : p + ((1 + -t : ℝ) : ℂ) * e θ' ∈ ball (ringPt p θ) (d θ) ∩ ball p 1 := by
        refine ⟨?_, hy.2⟩
        rw [mem_ball]
        have := dist_triangle (p + ((1 + -t : ℝ) : ℂ) * e θ') (ringPt p θ') (ringPt p θ)
        rw [dist_ringPt_radial, abs_neg, abs_of_pos ht0] at this
        linarith
      exact (hFin θ' hθ' _ hy).symm.trans (hFin θ hθ _ hy')
    · have hy := hout_mem θ' hθ' t ht0 ht1
      have hy' : p + ((1 + t : ℝ) : ℂ) * e θ' ∈ ball (ringPt p θ) (d θ) \ closedBall p 1 := by
        refine ⟨?_, hy.2⟩
        rw [mem_ball]
        have := dist_triangle (p + ((1 + t : ℝ) : ℂ) * e θ') (ringPt p θ') (ringPt p θ)
        rw [dist_ringPt_radial, abs_of_pos ht0] at this
        linarith
      exact (hFout θ' hθ' _ hy).symm.trans (hFout θ hθ _ hy')
  have hev : ∀ θ ∈ Ioo θ₁ θ₂, ∀ᶠ θ' in 𝓝[Ioo θ₁ θ₂] θ, cin θ' = cin θ ∧ cout θ' = cout θ := by
    intro θ hθ
    have hb : ball θ (d θ / 2) ∈ 𝓝 θ := ball_mem_nhds θ (by linarith [hd0 θ hθ])
    filter_upwards [nhdsWithin_le_nhds (inter_mem hb (Ioo_mem_nhds hθ.1 hθ.2))] with θ' hθ'
    exact hnear θ hθ θ' hθ'.2 (by rw [← Real.dist_eq]; exact mem_ball.mp hθ'.1)
  have hcont_in : ContinuousOn cin (Ioo θ₁ θ₂) := by
    intro θ hθ
    rw [ContinuousWithinAt, nhds_discrete, tendsto_pure]
    filter_upwards [hev θ hθ] with θ' h using h.1
  have hcont_out : ContinuousOn cout (Ioo θ₁ θ₂) := by
    intro θ hθ
    rw [ContinuousWithinAt, nhds_discrete, tendsto_pure]
    filter_upwards [hev θ hθ] with θ' h using h.2
  set m := (θ₁ + θ₂) / 2 with hm
  have hmI : m ∈ Ioo θ₁ θ₂ := ⟨by linarith, by linarith⟩
  refine ⟨cin m, cout m, h12, hΓ, fun θ hθ => ⟨?_, ?_⟩⟩
  · have hc : cin θ = cin m := isPreconnected_Ioo.constant hcont_in hθ hmI
    ext j
    simp only [innerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro hj
      obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hj (d θ) (hd0 θ hθ)
      have := hFin θ hθ z ⟨by rw [mem_ball, dist_comm]; exact hzd, hz.2⟩
      rw [← hc, ← this]; exact hz.1.2.symm
    · rintro rfl
      rw [Metric.mem_closure_iff]
      intro ε hε
      set t := min ε (d θ) / 2 with ht
      have ht0 : 0 < t := by have := hd0 θ hθ; positivity
      have htd : t < d θ := by linarith [min_le_right ε (d θ), hd0 θ hθ]
      have hy := hin_mem θ hθ t ht0 htd
      refine ⟨_, ⟨⟨hint θ hθ _ hy.1 (ne_of_lt (mem_ball.mp hy.2)), ?_⟩, hy.2⟩, ?_⟩
      · show F.col _ = cin m
        rw [hFin θ hθ _ hy, hc]
      · rw [dist_comm, dist_ringPt_radial, abs_neg, abs_of_pos ht0]
        linarith [min_le_left ε (d θ)]
  · have hc : cout θ = cout m := isPreconnected_Ioo.constant hcont_out hθ hmI
    ext j
    simp only [outerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro hj
      obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hj (d θ) (hd0 θ hθ)
      have := hFout θ hθ z ⟨by rw [mem_ball, dist_comm]; exact hzd, hz.2⟩
      rw [← hc, ← this]; exact hz.1.2.symm
    · rintro rfl
      rw [Metric.mem_closure_iff]
      intro ε hε
      set t := min ε (d θ) / 2 with ht
      have ht0 : 0 < t := by have := hd0 θ hθ; positivity
      have htd : t < d θ := by linarith [min_le_right ε (d θ), hd0 θ hθ]
      have hy := hout_mem θ hθ t ht0 htd
      have hyp : dist (p + ((1 + t : ℝ) : ℂ) * e θ) p ≠ 1 := by
        rw [dist_radial_centre p θ _ (by linarith)]; linarith
      refine ⟨_, ⟨⟨hint θ hθ _ hy.1 hyp, ?_⟩, hy.2⟩, ?_⟩
      · show F.col _ = cout m
        rw [hFout θ hθ _ hy, hc]
      · rw [dist_comm, dist_ringPt_radial, abs_of_pos ht0]
        linarith [min_le_left ε (d θ)]

/-- An arc of `ω(p)` lies on `ω(p)`. -/
theorem carrier_circ_subset_sphere (p : ℂ) (θa θb : ℝ) : (Arc.circ p 1 θa θb).carrier ⊆ sphere p 1 := by
  rintro _ ⟨θ, -, rfl⟩
  rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, Complex.ofReal_one, one_mul, norm_e]

/-- A sub-arc of a ring arc lies in it. -/
theorem ringArc_subset_ringArc {p : ℂ} {θ₁ θ₂ a b : ℝ} (ha : θ₁ ≤ a) (hb : b ≤ θ₂) : ringArc p a b ⊆ ringArc p θ₁ θ₂ :=
  image_mono (Icc_subset_Icc ha hb)

/-- **A clean sub-arc** (child): inside any closed sub-arc of positive length of `ω(p)` whose interior points lie in the domain, there is
a sub-arc of positive length each of whose interior points has a ball in the domain in which every point of an arc lies on `ω(p)` (near
one point finitely many arcs; those not on `ω(p)` meet it finitely, `Arc.finite_inter_sphere_or_eq_circ`). -/
theorem exists_clean_subArc {p : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hdom : ringPt p ((θ₁ + θ₂) / 2) ∈ F.dom) :
    ∃ a b, θ₁ ≤ a ∧ a < b ∧ b ≤ θ₂ ∧ ∀ θ ∈ Ioo a b, ∃ δ > 0, ball (ringPt p θ) δ ⊆ F.dom ∧
      ∀ z ∈ ball (ringPt p θ) δ, z ∈ ⋃ a ∈ F.arcs, a.carrier → dist z p = 1 := by
  set m₀ := (θ₁ + θ₂) / 2 with hm₀
  set z₀ := ringPt p m₀ with hz₀
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite z₀ hdom
  obtain ⟨r, hr, hrt⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hdom))
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty} with h𝒜
  set 𝒜f := {a | a ∈ 𝒜 ∧ (a.carrier ∩ sphere p 1).Finite} with h𝒜f
  set C := ⋃ a ∈ 𝒜f, a.carrier ∩ sphere p 1 with hC
  have hCfin : C.Finite := (hfin.subset fun a ha => ha.1).biUnion fun a ha => ha.2
  set D := ⋃ a ∈ 𝒜f, a.carrier with hD
  have hDc : IsClosed D := (hfin.subset fun a ha => ha.1).isClosed_biUnion fun a _ => a.isClosed_carrier
  -- a short sub-arc about `m₀` inside `B(z₀, r)`
  set η := min (r / 2) ((θ₂ - θ₁) / 4) with hη
  have hη0 : 0 < η := lt_min (by linarith) (by linarith)
  have hηr : η ≤ r / 2 := min_le_left _ _
  have hηθ : η ≤ (θ₂ - θ₁) / 4 := min_le_right _ _
  have hz₀mem : z₀ ∈ ringArc p (m₀ - η) (m₀ + η) := ⟨m₀, ⟨by linarith, by linarith⟩, rfl⟩
  obtain ⟨z, ⟨⟨φ, hφ, rfl⟩, hzC⟩, hzd⟩ :=
    Metric.mem_closure_iff.mp (mem_closure_ringArc_diff_finite (by linarith) hCfin hz₀mem) (r / 2) (by linarith)
  have hzr : dist (ringPt p φ) z₀ < r := by
    have : dist (ringPt p φ) z₀ ≤ |φ - m₀| := by
      rw [dist_eq_norm, ringPt, hz₀, ringPt, show p + e φ - (p + e m₀) = e φ - e m₀ by ring]
      exact norm_e_sub_e_le φ m₀
    have h2 : |φ - m₀| ≤ η := abs_le.mpr ⟨by linarith [hφ.1], by linarith [hφ.2]⟩
    linarith
  -- a ball about `r(φ)` inside `B(z₀, r)` missing the carriers of the arcs meeting `ω(p)` finitely
  have hzD : ringPt p φ ∉ D := by
    intro h
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
    exact hzC (mem_iUnion₂.mpr ⟨a, ha, hza, ringPt_mem_sphere p φ⟩)
  obtain ⟨δ₁, hδ₁, hδ₁D⟩ := Metric.isOpen_iff.mp hDc.isOpen_compl _ hzD
  set δ := min δ₁ (r - dist (ringPt p φ) z₀) with hδ
  have hδ0 : 0 < δ := lt_min hδ₁ (by linarith)
  refine ⟨φ, min θ₂ (φ + δ / 2), by linarith [hφ.1], lt_min (by linarith [hφ.2]) (by linarith), min_le_left _ _, ?_⟩
  intro θ hθ
  have hθφ : dist (ringPt p θ) (ringPt p φ) < δ / 2 := by
    have : dist (ringPt p θ) (ringPt p φ) ≤ |θ - φ| := by
      rw [dist_eq_norm, ringPt, ringPt, show p + e θ - (p + e φ) = e θ - e φ by ring]
      exact norm_e_sub_e_le θ φ
    have h2 : |θ - φ| < δ / 2 := abs_lt.mpr ⟨by linarith [hθ.1], by linarith [hθ.2, min_le_right θ₂ (φ + δ / 2)]⟩
    linarith
  have hball : ball (ringPt p θ) (δ / 2) ⊆ ball (ringPt p φ) δ := by
    intro w hw
    rw [mem_ball] at hw ⊢
    linarith [dist_triangle w (ringPt p θ) (ringPt p φ)]
  have hball2 : ball (ringPt p φ) δ ⊆ ball z₀ r := by
    intro w hw
    rw [mem_ball] at hw ⊢
    linarith [dist_triangle w (ringPt p φ) z₀, min_le_right δ₁ (r - dist (ringPt p φ) z₀)]
  refine ⟨δ / 2, by linarith, fun w hw => (hrt (hball2 (hball hw))).2, fun w hw hwa => ?_⟩
  obtain ⟨a, ha, hwa⟩ := mem_iUnion₂.mp hwa
  have hwt : w ∈ t := (hrt (hball2 (hball hw))).1
  have ha𝒜 : a ∈ 𝒜 := ⟨ha, w, hwa, hwt⟩
  rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha) p with hf | ⟨θa, θb, rfl⟩
  · exfalso
    refine hδ₁D ?_ (mem_iUnion₂.mpr ⟨a, ⟨ha𝒜, hf⟩, hwa⟩)
    have := hball hw
    rw [mem_ball] at this ⊢
    linarith [min_le_left δ₁ (r - dist (ringPt p φ) z₀)]
  · exact carrier_circ_subset_sphere p θa θb hwa

/-- **A ring arc inside every arc of `Γ` on a ring** (engines A and B): a closed sub-arc of positive length of `ω(p)` in `Γ` contains a
sub-arc of positive length with constant sides. -/
theorem exists_isRingArc_of_subset_Γ {p : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hΓ : ringArc p θ₁ θ₂ ⊆ F.Γ) :
    ∃ a b c c', θ₁ ≤ a ∧ a < b ∧ b ≤ θ₂ ∧ F.IsRingArc p a b c c' := by
  obtain ⟨a, b, ha, hab, hb, hcl⟩ := exists_clean_subArc (F := F) h12
    (hΓ ⟨(θ₁ + θ₂) / 2, ⟨by linarith, by linarith⟩, rfl⟩).1
  obtain ⟨c, c', hR⟩ := isRingArc_of_clean hab ((ringArc_subset_ringArc ha hb).trans hΓ) hcl
  exact ⟨a, b, c, c', ha, hab, hb, hR⟩

/-- Two ring points are at most their angle apart. -/
theorem dist_ringPt_ringPt_le (p : ℂ) (θ φ : ℝ) : dist (ringPt p θ) (ringPt p φ) ≤ |θ - φ| := by
  rw [dist_eq_norm, ringPt, ringPt, show p + e θ - (p + e φ) = e θ - e φ by ring]
  exact norm_e_sub_e_le θ φ

/-- A point at distance `1` from `u'` is the ring point of `ω(u')` at its argument. -/
theorem ringPt_arg_sub {u u' : ℂ} (hd : dist u u' = 1) : ringPt u' (arg (u - u')) = u := by
  have h := eq_polar_arg (u - u')
  rw [← dist_eq_norm, hd, Complex.ofReal_one, one_mul] at h
  rw [ringPt, ← h]; ring

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

/-- The Reuleaux bound in coordinates: `D = a u + b w` (`a, b ≥ 0`), `Q` with `|Q|² ≤ 2 Q·u` and `|Q|² ≤ 2 Q·w`, and `|D + Q| ≤ 1` give
`|D| ≤ 1` (`|D|² = D·(D + Q) − D·Q ≤ D·(D + Q) ≤ |D|`). -/
theorem reul_bound_real {D1 D2 Q1 Q2 u1 u2 w1 w2 a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) (hre : D1 = a * u1 + b * w1)
    (him : D2 = a * u2 + b * w2) (hQu : Q1 ^ 2 + Q2 ^ 2 ≤ 2 * (Q1 * u1 + Q2 * u2))
    (hQw : Q1 ^ 2 + Q2 ^ 2 ≤ 2 * (Q1 * w1 + Q2 * w2)) (hP : (D1 + Q1) ^ 2 + (D2 + Q2) ^ 2 ≤ 1) : D1 ^ 2 + D2 ^ 2 ≤ 1 := by
  have hDQ : 0 ≤ D1 * Q1 + D2 * Q2 := by
    have hsplit : D1 * Q1 + D2 * Q2 = a * (Q1 * u1 + Q2 * u2) + b * (Q1 * w1 + Q2 * w2) := by rw [hre, him]; ring
    rw [hsplit]
    have h1 : 0 ≤ Q1 * u1 + Q2 * u2 := by nlinarith [sq_nonneg Q1, sq_nonneg Q2]
    have h2 : 0 ≤ Q1 * w1 + Q2 * w2 := by nlinarith [sq_nonneg Q1, sq_nonneg Q2]
    exact add_nonneg (mul_nonneg ha h1) (mul_nonneg hb h2)
  clear hre him hQu hQw
  have hDD : D1 ^ 2 + D2 ^ 2 ≤ D1 * (D1 + Q1) + D2 * (D2 + Q2) := by linarith
  have hCS : (D1 * (D1 + Q1) + D2 * (D2 + Q2)) ^ 2 ≤ (D1 ^ 2 + D2 ^ 2) * ((D1 + Q1) ^ 2 + (D2 + Q2) ^ 2) := by
    nlinarith [sq_nonneg (D1 * (D2 + Q2) - D2 * (D1 + Q1))]
  by_contra hlt
  push Not at hlt
  have h0 : 0 ≤ D1 ^ 2 + D2 ^ 2 := by positivity
  have h3 : (D1 ^ 2 + D2 ^ 2) ^ 2 ≤ (D1 ^ 2 + D2 ^ 2) * 1 := by
    calc (D1 ^ 2 + D2 ^ 2) ^ 2 ≤ (D1 * (D1 + Q1) + D2 * (D2 + Q2)) ^ 2 := pow_le_pow_left₀ h0 hDD 2
      _ ≤ _ := hCS
      _ ≤ _ := mul_le_mul_of_nonneg_left hP h0
  nlinarith

/-- The Reuleaux bound at a vertex `V`: if `q ∈ B̄(W₁, 1) ∩ B̄(W₂, 1)` with `|W₁ − V| = |W₂ − V| = 1`, `p ∈ B̄(V, 1)`, and `p − q` is a
nonnegative combination of `W₁ − V` and `W₂ − V`, then `|p − q| ≤ 1`. -/
theorem norm_sub_le_one_of_cone {V W₁ W₂ p q : ℂ} (h₁ : ‖W₁ - V‖ = 1) (h₂ : ‖W₂ - V‖ = 1) (hp : ‖p - V‖ ≤ 1)
    (hq₁ : ‖q - W₁‖ ≤ 1) (hq₂ : ‖q - W₂‖ ≤ 1) {a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hd : p - q = (a : ℂ) * (W₁ - V) + (b : ℂ) * (W₂ - V)) : ‖p - q‖ ≤ 1 := by
  have e1 := sq_norm_eq (W₁ - V); rw [h₁] at e1
  have e2 := sq_norm_eq (W₂ - V); rw [h₂] at e2
  have ep : ‖p - V‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (p - V)]
  have eq1 : ‖q - W₁‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (q - W₁)]
  have eq2 : ‖q - W₂‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (q - W₂)]
  rw [sq_norm_eq] at ep eq1 eq2
  have hre : p.re - q.re = a * (W₁.re - V.re) + b * (W₂.re - V.re) := by
    have := congrArg Complex.re hd; simpa using this
  have him : p.im - q.im = a * (W₁.im - V.im) + b * (W₂.im - V.im) := by
    have := congrArg Complex.im hd; simpa using this
  simp only [Complex.sub_re, Complex.sub_im] at e1 e2 ep eq1 eq2
  have hQu : (q.re - V.re) ^ 2 + (q.im - V.im) ^ 2 ≤
      2 * ((q.re - V.re) * (W₁.re - V.re) + (q.im - V.im) * (W₁.im - V.im)) := by nlinarith
  have hQw : (q.re - V.re) ^ 2 + (q.im - V.im) ^ 2 ≤
      2 * ((q.re - V.re) * (W₂.re - V.re) + (q.im - V.im) * (W₂.im - V.im)) := by nlinarith
  have hP : ((p.re - q.re) + (q.re - V.re)) ^ 2 + ((p.im - q.im) + (q.im - V.im)) ^ 2 ≤ 1 := by
    simp only [sub_add_sub_cancel]; exact ep
  have := reul_bound_real ha hb hre him hQu hQw hP
  have h2 : ‖p - q‖ ^ 2 ≤ 1 := by rw [sq_norm_eq]; simpa using this
  nlinarith [norm_nonneg (p - q)]

/-- `d = a u + b w` by Cramer's rule, for `u`, `w` not parallel. -/
theorem eq_cramer (d u w : ℂ) (hc : u.re * w.im - u.im * w.re ≠ 0) :
    d = (((d.re * w.im - d.im * w.re) / (u.re * w.im - u.im * w.re) : ℝ) : ℂ) * u +
      (((u.re * d.im - u.im * d.re) / (u.re * w.im - u.im * w.re) : ℝ) : ℂ) * w := by
  have hc' : w.im * u.re - w.re * u.im ≠ 0 := by rwa [show w.im * u.re - w.re * u.im = u.re * w.im - u.im * w.re by ring]
  apply Complex.ext <;>
    simp only [Complex.add_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, Complex.add_im, Complex.mul_im, zero_mul,
      sub_zero, add_zero] <;> field_simp <;> ring

/-- **A Reuleaux triangle has diameter `1`**: for `X`, `Y`, `Z` pairwise `1` apart, any two points of `Reul(X, Y, Z)` are at most `1`
apart. -/
theorem dist_le_one_of_mem_reul {X Y Z p q : ℂ} (hXY : ‖Y - X‖ = 1) (hXZ : ‖Z - X‖ = 1) (hYZ : ‖Z - Y‖ = 1)
    (hp : p ∈ reul X Y Z) (hq : q ∈ reul X Y Z) : dist p q ≤ 1 := by
  obtain ⟨⟨hpX, hpY⟩, hpZ⟩ := hp
  obtain ⟨⟨hqX, hqY⟩, hqZ⟩ := hq
  simp only [mem_closedBall, dist_eq_norm] at hpX hpY hpZ hqX hqY hqZ
  have hYX : ‖X - Y‖ = 1 := by rw [norm_sub_rev]; exact hXY
  have hZX : ‖X - Z‖ = 1 := by rw [norm_sub_rev]; exact hXZ
  have hZY : ‖Y - Z‖ = 1 := by rw [norm_sub_rev]; exact hYZ
  set u := Y - X with hu
  set w := Z - X with hw
  have sq := sq_norm_eq
  have hc : u.re * w.im - u.im * w.re ≠ 0 := by
    have e1 := sq u; rw [hXY] at e1
    have e2 := sq w; rw [hXZ] at e2
    have hwu : ‖w - u‖ = 1 := by rw [show w - u = Z - Y by simp [hu, hw]]; exact hYZ
    have e3 := sq (w - u); rw [hwu] at e3
    simp only [Complex.sub_re, Complex.sub_im] at e3
    have hdot : u.re * w.re + u.im * w.im = 1 / 2 := by nlinarith
    have hlag : (u.re * w.re + u.im * w.im) ^ 2 + (u.re * w.im - u.im * w.re) ^ 2 =
        (u.re ^ 2 + u.im ^ 2) * (w.re ^ 2 + w.im ^ 2) := by ring
    intro h0
    rw [hdot, h0, ← e1, ← e2] at hlag
    norm_num at hlag
  set c := u.re * w.im - u.im * w.re
  set a := ((p - q).re * w.im - (p - q).im * w.re) / c
  set b := (u.re * (p - q).im - u.im * (p - q).re) / c
  have hd : p - q = (a : ℂ) * u + (b : ℂ) * w := eq_cramer (p - q) u w hc
  rw [dist_eq_norm]
  rcases le_total 0 a with ha | ha <;> rcases le_total 0 b with hb | hb
  · exact norm_sub_le_one_of_cone hXY hXZ hpX hqY hqZ ha hb hd
  · rcases le_total 0 (a + b) with hab | hab
    · -- `q − p = (a + b)(X − Y) + (−b)(Z − Y)`, at `Y`
      rw [norm_sub_rev]
      refine norm_sub_le_one_of_cone (V := Y) (W₁ := X) (W₂ := Z) hYX hYZ hqY hpX hpZ hab (neg_nonneg.2 hb) ?_
      rw [show q - p = -(p - q) by ring, hd]; push_cast; simp only [hu, hw]; ring
    · -- `p − q = −(a + b)(X − Z) + a (Y − Z)`, at `Z`
      refine norm_sub_le_one_of_cone (V := Z) (W₁ := X) (W₂ := Y) hZX hZY hpZ hqX hqY (neg_nonneg.2 hab) ha ?_
      rw [hd]; push_cast; simp only [hu, hw]; ring
  · rcases le_total 0 (a + b) with hab | hab
    · -- `q − p = (a + b)(X − Z) + (−a)(Y − Z)`, at `Z`
      rw [norm_sub_rev]
      refine norm_sub_le_one_of_cone (V := Z) (W₁ := X) (W₂ := Y) hZX hZY hqZ hpX hpY hab (neg_nonneg.2 ha) ?_
      rw [show q - p = -(p - q) by ring, hd]; push_cast; simp only [hu, hw]; ring
    · -- `p − q = −(a + b)(X − Y) + b (Z − Y)`, at `Y`
      refine norm_sub_le_one_of_cone (V := Y) (W₁ := X) (W₂ := Z) hYX hYZ hpY hqX hqZ (neg_nonneg.2 hab) hb ?_
      rw [hd]; push_cast; simp only [hu, hw]; ring
  · rw [norm_sub_rev]
    refine norm_sub_le_one_of_cone hXY hXZ hqX hpY hpZ (neg_nonneg.2 ha) (neg_nonneg.2 hb) ?_
    rw [show q - p = -(p - q) by ring, hd]; push_cast; ring

/-- **The open Reuleaux triangle**: a point of `B(X, 1) ∩ B(Y, 1) ∩ B(Z, 1)` is less than `1` from every point of `Reul(X, Y, Z)`. -/
theorem dist_lt_one_of_mem_reul {X Y Z p q : ℂ} (hXY : ‖Y - X‖ = 1) (hXZ : ‖Z - X‖ = 1) (hYZ : ‖Z - Y‖ = 1)
    (hp : p ∈ ball X 1 ∩ ball Y 1 ∩ ball Z 1) (hq : q ∈ reul X Y Z) : dist p q < 1 := by
  have hO : IsOpen (ball X 1 ∩ ball Y 1 ∩ ball Z 1) := (isOpen_ball.inter isOpen_ball).inter isOpen_ball
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hO p hp
  by_cases hpq : p = q
  · rw [hpq, dist_self]; norm_num
  have hn : 0 < ‖p - q‖ := norm_pos_iff.2 (sub_ne_zero.2 hpq)
  set s := ε / 2 / ‖p - q‖ with hs
  have hs0 : 0 < s := by positivity
  set p' := p + (s : ℂ) * (p - q) with hp'
  have hp'b : p' ∈ ball X 1 ∩ ball Y 1 ∩ ball Z 1 := by
    apply hball
    rw [mem_ball, dist_eq_norm, hp', add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hs0, hs,
      div_mul_cancel₀ _ hn.ne']
    linarith
  have hreul : p' ∈ reul X Y Z := by
    obtain ⟨⟨h1, h2⟩, h3⟩ := hp'b
    exact ⟨⟨ball_subset_closedBall h1, ball_subset_closedBall h2⟩, ball_subset_closedBall h3⟩
  have hle := dist_le_one_of_mem_reul hXY hXZ hYZ hreul hq
  rw [dist_eq_norm, hp', show p + (s : ℂ) * (p - q) - q = ((1 + s : ℝ) : ℂ) * (p - q) by push_cast; ring, norm_mul,
    Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)] at hle
  rw [dist_eq_norm]
  nlinarith

/-- The three points `0`, `1`, `e 60°` are pairwise `1` apart. -/
theorem norm_e_pi_div_three_sub_one : ‖e (π / 3) - 1‖ = 1 := by
  obtain ⟨er, ei⟩ := e_pi_div_three_re_im
  have hs3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h := sq_norm_eq (e (π / 3) - 1)
  simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, er, ei] at h
  have h2 : ‖e (π / 3) - 1‖ ^ 2 = 1 := by rw [h]; nlinarith
  nlinarith [norm_nonneg (e (π / 3) - 1)]

/-- An interior point of `l60Frag` in the lens is strictly inside both of its discs and off `ω(0)`. -/
theorem l60_interior_lens {x : ℂ} (hx : x ∈ l60Frag.interiorPts) (hL : x ∈ l60Lens) :
    ‖x - 1‖ < 1 ∧ ‖x - e (π / 3)‖ < 1 ∧ ‖x‖ ≠ 1 := by
  have hmem : ∀ a ∈ l60Arcs, x ∉ a.carrier := fun a ha h => hx.2 (mem_iUnion₂.mpr ⟨a, ha, h⟩)
  obtain ⟨hL1, hL2⟩ := hL
  rw [mem_closedBall, dist_eq_norm] at hL1 hL2
  exact ⟨lt_of_le_of_ne hL1 fun h => hmem _ (by simp [l60Arcs]) (mem_l60_arc1 h hL2),
    lt_of_le_of_ne hL2 fun h => hmem _ (by simp [l60Arcs]) (mem_l60_arc2 h hL1),
    fun h => hmem _ (by simp [l60Arcs]) (mem_l60_arc0 h hL1 hL2)⟩

/-- The cap of the lens outside `ω(0)` lies in `B(C, 1)`, `C = 1 + e 60°`. -/
theorem l60_cap_mem_ball {x : ℂ} (h1 : ‖x - 1‖ < 1) (h2 : ‖x - e (π / 3)‖ < 1) (h0 : 1 < ‖x‖) :
    ‖x - (1 + e (π / 3))‖ < 1 := by
  obtain ⟨er, ei⟩ := e_pi_div_three_re_im
  have hs3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs3p : 0 < √3 := by positivity
  have q1 : ‖x - 1‖ ^ 2 < 1 := by nlinarith [norm_nonneg (x - 1)]
  have q2 : ‖x - e (π / 3)‖ ^ 2 < 1 := by nlinarith [norm_nonneg (x - e (π / 3))]
  have q0 : 1 < ‖x‖ ^ 2 := by nlinarith
  rw [sq_norm_eq] at q1 q2 q0
  simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, er, ei] at q1 q2
  have g1 : 0 < 2 * x.re - (x.re ^ 2 + x.im ^ 2) := by nlinarith
  have g2 : 0 < x.re + √3 * x.im - (x.re ^ 2 + x.im ^ 2) := by nlinarith
  have g3 : 0 < x.re ^ 2 + x.im ^ 2 - 1 := by linarith
  have hT : 0 < 3 * x.re + √3 * x.im - (x.re ^ 2 + x.im ^ 2) - 2 := by
    nlinarith [mul_pos g1 g2, mul_pos g1 g3, mul_pos g2 g3, sq_nonneg (x.re - 3 / 2), sq_nonneg (x.im - √3 / 2),
      sq_nonneg (√3 * x.re - x.im)]
  have : ‖x - (1 + e (π / 3))‖ ^ 2 < 1 := by
    rw [sq_norm_eq]
    simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im, er, ei]
    nlinarith
  nlinarith [norm_nonneg (x - (1 + e (π / 3)))]

/-! ### L60-EQ: the containments and the corner cones, over the crossing engine (no chain needed) -/

/-- Rotating about `P` by `−θ` is an isometry: `‖(z − P) ē(θ) − w‖ = ‖z − (P + w e(θ))‖`. -/
theorem norm_rot_sub (P z w : ℂ) (θ : ℝ) : ‖(z - P) * starRingEnd ℂ (e θ) - w‖ = ‖z - (P + w * e θ)‖ := by
  have hce := conj_e_mul_e θ
  have : z - (P + w * e θ) = ((z - P) * starRingEnd ℂ (e θ) - w) * e θ := by
    calc z - (P + w * e θ) = (z - P) * (e θ * starRingEnd ℂ (e θ)) - w * e θ := by rw [hce]; ring
      _ = _ := by ring
  rw [this, norm_mul, norm_e, mul_one]

/-- `ringPt P θ = P + 1 · e θ` and `ringPt P (θ + π/3) = P + e(π/3) e θ`, the two ends in the rotated frame. -/
theorem ringPt_eq_rot (P : ℂ) (θ : ℝ) : ringPt P θ = P + 1 * e θ ∧ ringPt P (θ + π / 3) = P + e (π / 3) * e θ := by
  refine ⟨by rw [ringPt, one_mul], ?_⟩
  rw [ringPt, show θ + π / 3 = π / 3 + θ by ring, e_add]

/-- **The lens of a `60°` arc's ends meets `ω(P)` in the arc**: a point of `ω(P)` within `1` of both ends lies on `r([θ₁, θ₁ + 60°])`. -/
theorem mem_ringArc_of_lens {P z : ℂ} {θ₁ : ℝ} (h0 : dist z P = 1) (h1 : dist z (ringPt P θ₁) ≤ 1)
    (h2 : dist z (ringPt P (θ₁ + π / 3)) ≤ 1) : z ∈ ringArc P θ₁ (θ₁ + π / 3) := by
  set x := (z - P) * starRingEnd ℂ (e θ₁) with hx
  obtain ⟨hA, hB⟩ := ringPt_eq_rot P θ₁
  have hx0 : ‖x‖ = 1 := by
    have := norm_rot_sub P z 0 θ₁
    rw [sub_zero, zero_mul, add_zero, ← dist_eq_norm, h0] at this; exact this
  have hx1 : ‖x - 1‖ ≤ 1 := by rw [norm_rot_sub, ← hA, ← dist_eq_norm]; exact h1
  have hx2 : ‖x - e (π / 3)‖ ≤ 1 := by rw [norm_rot_sub, ← hB, ← dist_eq_norm]; exact h2
  obtain ⟨φ, hφ, hφx⟩ := mem_l60_arc0 hx0 hx1 hx2
  have hce := conj_e_mul_e θ₁
  refine ⟨θ₁ + φ, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, ?_⟩
  have hφx' : e φ = x := by simpa using hφx
  rw [ringPt, e_add, mul_comm (e θ₁), hφx', hx]
  calc P + (z - P) * starRingEnd ℂ (e θ₁) * e θ₁ = P + (z - P) * (e θ₁ * starRingEnd ℂ (e θ₁)) := by ring
    _ = z := by rw [hce]; ring

/-- The cap of the closed lens outside `B̄(0, 1)` lies in `B̄(C, 1)`, `C = 1 + e 60°` (the closed form of `l60_cap_mem_ball`). -/
theorem l60_cap_mem_closedBall {x : ℂ} (h1 : ‖x - 1‖ ≤ 1) (h2 : ‖x - e (π / 3)‖ ≤ 1) (h0 : 1 < ‖x‖) :
    ‖x - (1 + e (π / 3))‖ ≤ 1 := by
  obtain ⟨er, ei⟩ := e_pi_div_three_re_im
  have hs3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs3p : 0 < √3 := by positivity
  have q1 : ‖x - 1‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (x - 1)]
  have q2 : ‖x - e (π / 3)‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (x - e (π / 3))]
  have q0 : 1 < ‖x‖ ^ 2 := by nlinarith
  rw [sq_norm_eq] at q1 q2 q0
  simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, er, ei] at q1 q2
  have g1 : 0 ≤ 2 * x.re - (x.re ^ 2 + x.im ^ 2) := by nlinarith
  have g2 : 0 ≤ x.re + √3 * x.im - (x.re ^ 2 + x.im ^ 2) := by nlinarith
  have g3 : 0 < x.re ^ 2 + x.im ^ 2 - 1 := by linarith
  have hT : 0 ≤ 3 * x.re + √3 * x.im - (x.re ^ 2 + x.im ^ 2) - 2 := by
    nlinarith [mul_nonneg g1 g2, mul_nonneg g1 g3.le, mul_nonneg g2 g3.le, sq_nonneg (x.re - 3 / 2), sq_nonneg (x.im - √3 / 2),
      sq_nonneg (√3 * x.re - x.im)]
  have : ‖x - (1 + e (π / 3))‖ ^ 2 ≤ 1 := by
    rw [sq_norm_eq]
    simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im, er, ei]
    nlinarith
  nlinarith [norm_nonneg (x - (1 + e (π / 3)))]

/-- The cap at a general `60°` arc: a point within `1` of both ends and outside `B̄(P, 1)` is within `1` of `C = A + B − P`. -/
theorem l60_cap_general {P z : ℂ} {θ₁ : ℝ} (h1 : dist z (ringPt P θ₁) ≤ 1) (h2 : dist z (ringPt P (θ₁ + π / 3)) ≤ 1)
    (h0 : 1 < dist z P) : dist z (ringPt P θ₁ + ringPt P (θ₁ + π / 3) - P) ≤ 1 := by
  obtain ⟨hA, hB⟩ := ringPt_eq_rot P θ₁
  have hx0 : 1 < ‖(z - P) * starRingEnd ℂ (e θ₁)‖ := by
    have := norm_rot_sub P z 0 θ₁
    rw [sub_zero, zero_mul, add_zero, ← dist_eq_norm] at this; rw [this]; exact h0
  have hx1 : ‖(z - P) * starRingEnd ℂ (e θ₁) - 1‖ ≤ 1 := by rw [norm_rot_sub, ← hA, ← dist_eq_norm]; exact h1
  have hx2 : ‖(z - P) * starRingEnd ℂ (e θ₁) - e (π / 3)‖ ≤ 1 := by rw [norm_rot_sub, ← hB, ← dist_eq_norm]; exact h2
  have h := l60_cap_mem_closedBall hx1 hx2 hx0
  rw [norm_rot_sub] at h
  have heq : ringPt P θ₁ + ringPt P (θ₁ + π / 3) - P = P + (1 + e (π / 3)) * e θ₁ := by rw [hA, hB]; ring
  rw [dist_eq_norm, heq]; exact h

/-- **A tile touching an arc of `Γ` on `ω(P)` from a side whose colour has the open arc in its closure lies within `1` of the whole closed
arc**: it lies in the open unit disc about the touching point, so (the crossing engine along the open arc) within `1` of every interior
point of the arc, and by continuity within `1` of the ends. -/
theorem dist_le_one_of_touch (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) {d : Fin k}
    (hd : ∀ φ ∈ Ioo θ₁ θ₂, ringPt P φ ∈ closure (F.region d)) {T : Set ℂ} (hT : F.TileOf d T) {θ : ℝ}
    (hθ : θ ∈ Ioo θ₁ θ₂) (hθT : ringPt P θ ∈ closure T) : ∀ z ∈ T, ∀ φ ∈ Icc θ₁ θ₂, dist z (ringPt P φ) ≤ 1 := by
  intro z hz φ hφ
  have hzθ : dist z (ringPt P θ) < 1 := hT.1.subset_ball hF hθT hz
  have hcont : Continuous fun φ : ℝ => ringPt P φ := by unfold ringPt e; fun_prop
  have hS : IsPreconnected ((fun φ : ℝ => ringPt P φ) '' Ioo θ₁ θ₂) := isPreconnected_Ioo.image _ hcont.continuousOn
  have hopen : ∀ φ ∈ Ioo θ₁ θ₂, dist z (ringPt P φ) < 1 := by
    rcases hF.dist_lt_or_gt_of_isPreconnected (hT.subset_region hz) hS
        (by rintro _ ⟨φ, hφ, rfl⟩; exact hd φ hφ) with h | h
    · exact fun φ hφ => h _ ⟨φ, hφ, rfl⟩
    · exact absurd (h _ ⟨θ, hθ, rfl⟩) (not_lt.mpr hzθ.le)
  have hcl : IsClosed {φ : ℝ | dist z (ringPt P φ) ≤ 1} := isClosed_le (continuous_const.dist hcont) continuous_const
  have hsub : Icc θ₁ θ₂ ⊆ {φ : ℝ | dist z (ringPt P φ) ≤ 1} := by
    rw [← closure_Ioo h12.ne]
    exact closure_minimal (fun φ hφ => (hopen φ hφ).le) hcl
  exact hsub hφ

/-- A tile within `1` of both ends of a `60°` arc of `Γ` on `ω(P)` misses `ω(P)` (the arc is the lens's trace on `ω(P)` and lies in
`Γ`). -/
theorem l60_tile_dist_ne_one {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c') {T : Set ℂ}
    (hT : F.IsTile T) (hlens : ∀ z ∈ T, dist z (ringPt P θ₁) ≤ 1 ∧ dist z (ringPt P (θ₁ + π / 3)) ≤ 1) :
    ∀ z ∈ T, dist z P ≠ 1 := by
  intro z hz h
  have hΓ := hA.2.1 (mem_ringArc_of_lens h (hlens z hz).1 (hlens z hz).2)
  exact (hT.subset_interiorPts hz).2 hΓ.2

/-- The ends' lens for a side tile of a `60°` arc: the side colour has the open arc in its closure, the tile touches it, so the tile lies
within `1` of both ends and misses `ω(P)`. -/
theorem l60_side_tile {P : ℂ} {θ₁ : ℝ} {c c' d : Fin k} (hF : F.Valid) (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c')
    (hd : ∀ φ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P φ ∈ closure (F.region d)) {T : Set ℂ} (hT : F.TileOf d T) {θ : ℝ}
    (hθ : θ ∈ Ioo θ₁ (θ₁ + π / 3)) (hθT : ringPt P θ ∈ closure T) :
    (∀ z ∈ T, dist z (ringPt P θ₁) ≤ 1 ∧ dist z (ringPt P (θ₁ + π / 3)) ≤ 1) ∧ ∀ z ∈ T, dist z P ≠ 1 := by
  have h12 : θ₁ < θ₁ + π / 3 := by linarith [Real.pi_pos]
  have hle := dist_le_one_of_touch hF h12 hd hT hθ hθT
  have hends : ∀ z ∈ T, dist z (ringPt P θ₁) ≤ 1 ∧ dist z (ringPt P (θ₁ + π / 3)) ≤ 1 := fun z hz =>
    ⟨hle z hz θ₁ ⟨le_rfl, h12.le⟩, hle z hz _ ⟨h12.le, le_rfl⟩⟩
  exact ⟨hends, l60_tile_dist_ne_one hA hT.1 hends⟩

/-- **FS114-L60-LE**, L60-EQ, the inner side: at `ℓ = 60°` every tile of the inner colour touching the open arc from inside lies in
`Reul(P, A, B)` (`A`, `B` the arc's ends). -/
theorem l60_eq_inner (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c')
    {T : Set ℂ} (hT : F.TileOf c T) (htouch : ∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T ∩ ball P 1)) :
    T ⊆ reul P (ringPt P θ₁) (ringPt P (θ₁ + π / 3)) := by
  obtain ⟨θ, hθ, hθT⟩ := htouch
  have hd : ∀ φ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P φ ∈ closure (F.region c) := by
    intro φ hφ
    have : c ∈ F.innerColours P (ringPt P φ) := by rw [(hA.2.2 φ hφ).1]; rfl
    exact closure_mono inter_subset_left this
  obtain ⟨hends, hsph⟩ := l60_side_tile hF hA hd hT hθ (closure_mono inter_subset_left hθT)
  -- `T` is connected, misses `ω(P)`, and meets `B(P, 1)`
  have hne : (T ∩ ball P 1).Nonempty := by
    obtain ⟨w, hw, -⟩ := Metric.mem_closure_iff.mp hθT 1 one_pos
    exact ⟨w, hw⟩
  have hTin : T ⊆ ball P 1 := by
    refine hT.1.isPreconnected.subset_left_of_subset_union isOpen_ball (isOpen_compl_iff.mpr isClosed_closedBall)
      (Set.disjoint_left.mpr fun w hw hw' => hw' (ball_subset_closedBall hw)) (fun w hw => ?_) hne
    rcases lt_trichotomy (dist w P) 1 with h | h | h
    · exact Or.inl h
    · exact absurd h (hsph w hw)
    · exact Or.inr (by rw [mem_compl_iff, mem_closedBall, not_le]; exact h)
  intro z hz
  exact ⟨⟨ball_subset_closedBall (hTin hz), (hends z hz).1⟩, (hends z hz).2⟩

/-- **FS114-L60-LE**, L60-EQ, the outer side: at `ℓ = 60°` every tile of the outer colour touching the open arc from outside lies in
the Reuleaux cap `Reul(A, B, C) ∖ B̄(P, 1)`, `C = A + B − P`. -/
theorem l60_eq_outer (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c')
    {T : Set ℂ} (hT : F.TileOf c' T) (htouch : ∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T \ closedBall P 1)) :
    T ⊆ reul (ringPt P θ₁) (ringPt P (θ₁ + π / 3)) (ringPt P θ₁ + ringPt P (θ₁ + π / 3) - P) \ closedBall P 1 := by
  obtain ⟨θ, hθ, hθT⟩ := htouch
  have hd : ∀ φ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P φ ∈ closure (F.region c') := by
    intro φ hφ
    have : c' ∈ F.outerColours P (ringPt P φ) := by rw [(hA.2.2 φ hφ).2]; rfl
    exact closure_mono sdiff_subset this
  obtain ⟨hends, hsph⟩ := l60_side_tile hF hA hd hT hθ (closure_mono sdiff_subset hθT)
  have hne : (T ∩ (closedBall P 1)ᶜ).Nonempty := by
    obtain ⟨w, hw, -⟩ := Metric.mem_closure_iff.mp hθT 1 one_pos
    exact ⟨w, hw.1, hw.2⟩
  have hTout : T ⊆ (closedBall P 1)ᶜ := by
    refine hT.1.isPreconnected.subset_left_of_subset_union (isOpen_compl_iff.mpr isClosed_closedBall) isOpen_ball
      (Set.disjoint_left.mpr fun w hw hw' => hw (ball_subset_closedBall hw')) (fun w hw => ?_) hne
    rcases lt_trichotomy (dist w P) 1 with h | h | h
    · exact Or.inr h
    · exact absurd h (hsph w hw)
    · exact Or.inl (by rw [mem_compl_iff, mem_closedBall, not_le]; exact h)
  intro z hz
  have hzP : 1 < dist z P := by have := hTout hz; rwa [mem_compl_iff, mem_closedBall, not_le] at this
  exact ⟨⟨⟨(hends z hz).1, (hends z hz).2⟩, l60_cap_general (hends z hz).1 (hends z hz).2 hzP⟩, hTout hz⟩

/-- The mirror of `cos_nonneg_of_mem_coneAt`: a set outside `B(y + e γ, 1)` approaches `y` only along directions with `cos(β − γ) ≤ 0`. -/
theorem cos_nonpos_of_mem_coneAt {S : Set ℂ} {y : ℂ} {γ : ℝ} (hS : ∀ z ∈ S, 1 ≤ dist z (y + e γ)) {β : ℝ}
    (hβ : β ∈ coneAt S y) : Real.cos (β - γ) ≤ 0 := by
  by_contra hpos
  push Not at hpos
  obtain ⟨z, hzS, hzy, hzd, hdir⟩ := hβ (Real.cos (β - γ) / 2) (by linarith)
  have hw0 : z - y ≠ 0 := sub_ne_zero.mpr hzy
  have hn0 : 0 < ‖z - y‖ := norm_pos_iff.mpr hw0
  have hz1 : 1 ≤ ‖(z - y) - e γ‖ := by
    have := hS z hzS
    rwa [dist_eq_norm, show z - (y + e γ) = (z - y) - e γ by ring] at this
  have hsq : 2 * ((z - y) * (starRingEnd ℂ) (e γ)).re ≤ ‖z - y‖ ^ 2 := by
    have h1 : 1 ≤ ‖(z - y) - e γ‖ ^ 2 := by nlinarith
    rw [Complex.sq_norm, Complex.normSq_apply] at h1
    have h2 : ‖z - y‖ ^ 2 = (z - y).re ^ 2 + (z - y).im ^ 2 := by rw [Complex.sq_norm, Complex.normSq_apply]; ring
    have h4 : (e γ).re ^ 2 + (e γ).im ^ 2 = 1 := by rw [re_e, im_e]; exact Real.cos_sq_add_sin_sq γ
    simp only [Complex.sub_re, Complex.sub_im] at h1
    simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im, Complex.sub_re, Complex.sub_im]
    simp only [Complex.sub_re, Complex.sub_im] at h2
    nlinarith [h1, h2, h4]
  have hdre : ((z - y) / (‖z - y‖ : ℂ) * (starRingEnd ℂ) (e γ)).re ≤ ‖z - y‖ / 2 := by
    rw [div_mul_eq_mul_div, Complex.div_ofReal_re, div_le_iff₀ hn0]; nlinarith
  have hre : (e β * (starRingEnd ℂ) (e γ)).re = Real.cos (β - γ) := re_e_mul_conj_e β γ
  have hdiff : (e β * (starRingEnd ℂ) (e γ)).re - ((z - y) / (‖z - y‖ : ℂ) * (starRingEnd ℂ) (e γ)).re
      ≤ ‖(z - y) / (‖z - y‖ : ℂ) - e β‖ := by
    rw [← Complex.sub_re, ← sub_mul]
    calc _ ≤ ‖(e β - (z - y) / (‖z - y‖ : ℂ)) * (starRingEnd ℂ) (e γ)‖ := Complex.re_le_norm _
      _ = ‖(z - y) / (‖z - y‖ : ℂ) - e β‖ := by rw [norm_mul, Complex.norm_conj, norm_e, mul_one, norm_sub_rev]
  rw [hre] at hdiff
  have hnd : ‖z - y‖ < Real.cos (β - γ) / 2 := by rw [← dist_eq_norm]; exact hzd
  linarith

/-- Two closed half-turns `cos(β − a₁) ≥ 0`, `cos(β − a₂) ≥ 0` with `0 < a₂ − a₁ < π` meet in `[a₂ − 90°, a₁ + 90°]` (every direction
between `a₁` and `a₂` is then within `90°` of `β`: `sin(a₂ − a₁) cos(β − θ) = sin(a₂ − θ) cos(β − a₁) + sin(θ − a₁) cos(β − a₂)`). -/
theorem mem_angleIcc_of_two_cos {a₁ a₂ β : ℝ} (h12 : a₁ < a₂) (h2 : a₂ - a₁ < π) (c1 : 0 ≤ Real.cos (β - a₁))
    (c2 : 0 ≤ Real.cos (β - a₂)) : β ∈ angleIcc (a₂ - π / 2) (a₁ + π / 2) := by
  refine mem_angleIcc_of_cos_nonneg h12 fun θ hθ => ?_
  have hid : Real.sin (a₂ - a₁) * Real.cos (β - θ) =
      Real.sin (a₂ - θ) * Real.cos (β - a₁) + Real.sin (θ - a₁) * Real.cos (β - a₂) := by
    simp only [Real.sin_sub, Real.cos_sub]; ring
  have hs : 0 < Real.sin (a₂ - a₁) := Real.sin_pos_of_pos_of_lt_pi (by linarith) h2
  have hs1 : 0 ≤ Real.sin (a₂ - θ) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith [hθ.2]) (by linarith [hθ.1])
  have hs2 : 0 ≤ Real.sin (θ - a₁) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith [hθ.1]) (by linarith [hθ.2])
  have : 0 ≤ Real.sin (a₂ - a₁) * Real.cos (β - θ) := by rw [hid]; positivity
  by_contra hneg
  push Not at hneg
  nlinarith [mul_neg_of_pos_of_neg hs hneg]

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
  have hπ := Real.pi_pos
  -- the centre and the other end, seen from each end
  have hAP : ringPt P θ₁ + e (θ₁ + π) = P := by rw [ringPt, e_add_pi]; ring
  have hBP : ringPt P (θ₁ + π / 3) + e (θ₁ + 4 * π / 3) = P := by
    rw [ringPt, show θ₁ + 4 * π / 3 = (θ₁ + π / 3) + π by ring, e_add_pi]; ring
  have hBA : ringPt P (θ₁ + π / 3) + e (θ₁ - π / 3) = ringPt P θ₁ := by
    rw [← ringPt_sub_ringPt_plus_third P θ₁]; ring
  have hAB : ringPt P θ₁ + e (θ₁ + 2 * π / 3) = ringPt P (θ₁ + π / 3) := by
    have h := ringPt_sub_ringPt_plus_third P θ₁
    rw [show θ₁ + 2 * π / 3 = (θ₁ - π / 3) + π by ring, e_add_pi, ← h]; ring
  refine ⟨fun T hT htouch => ?_, fun T hT htouch => ?_⟩
  · have hsub := l60_eq_inner hF hA hT htouch
    have hTP : T ⊆ closedBall (ringPt P θ₁ + e (θ₁ + π)) 1 := by rw [hAP]; exact fun z hz => (hsub hz).1.1
    have hTB : T ⊆ closedBall (ringPt P θ₁ + e (θ₁ + 2 * π / 3)) 1 := by rw [hAB]; exact fun z hz => (hsub hz).2
    have hTP' : T ⊆ closedBall (ringPt P (θ₁ + π / 3) + e (θ₁ + 4 * π / 3)) 1 := by
      rw [hBP]; exact fun z hz => (hsub hz).1.1
    have hTA' : T ⊆ closedBall (ringPt P (θ₁ + π / 3) + e (θ₁ - π / 3)) 1 := by
      rw [hBA]; exact fun z hz => (hsub hz).1.2
    refine ⟨fun β hβ => ?_, fun β hβ => ?_⟩
    · have h := mem_angleIcc_of_two_cos (a₁ := θ₁ + 2 * π / 3) (a₂ := θ₁ + π) (by linarith) (by linarith)
        (cos_nonneg_of_mem_coneAt hTB hβ) (cos_nonneg_of_mem_coneAt hTP hβ)
      convert h using 2
      all_goals ring
    · have c1 := cos_nonneg_of_mem_coneAt hTA' hβ
      have c1' : 0 ≤ Real.cos (β - (θ₁ + 5 * π / 3)) := by
        rw [show β - (θ₁ + 5 * π / 3) = β - (θ₁ - π / 3) - 2 * π by ring, Real.cos_sub_two_pi]; exact c1
      have h := mem_angleIcc_of_two_cos (a₁ := θ₁ + 4 * π / 3) (a₂ := θ₁ + 5 * π / 3) (by linarith) (by linarith)
        (cos_nonneg_of_mem_coneAt hTP' hβ) c1'
      convert h using 2
      all_goals ring
  · have hsub := l60_eq_outer hF hA hT htouch
    have hfar : ∀ z ∈ T, 1 < dist z P := fun z hz => by
      have := (hsub hz).2; rwa [mem_closedBall, not_le] at this
    have hTP : ∀ z ∈ T, 1 ≤ dist z (ringPt P θ₁ + e (θ₁ + π)) := fun z hz => by rw [hAP]; exact (hfar z hz).le
    have hTP' : ∀ z ∈ T, 1 ≤ dist z (ringPt P (θ₁ + π / 3) + e (θ₁ + 4 * π / 3)) := fun z hz => by
      rw [hBP]; exact (hfar z hz).le
    have hTB : T ⊆ closedBall (ringPt P θ₁ + e (θ₁ + 2 * π / 3)) 1 := by rw [hAB]; exact fun z hz => (hsub hz).1.1.2
    have hTA' : T ⊆ closedBall (ringPt P (θ₁ + π / 3) + e (θ₁ - π / 3)) 1 := by
      rw [hBA]; exact fun z hz => (hsub hz).1.1.1
    refine ⟨fun β hβ => ?_, fun β hβ => ?_⟩
    · have c0 := cos_nonpos_of_mem_coneAt hTP hβ
      have c0' : 0 ≤ Real.cos (β - θ₁) := by
        rw [show β - (θ₁ + π) = (β - θ₁) - π by ring, Real.cos_sub_pi] at c0; linarith
      have h := mem_angleIcc_of_two_cos (a₁ := θ₁) (a₂ := θ₁ + 2 * π / 3) (by linarith) (by linarith) c0'
        (cos_nonneg_of_mem_coneAt hTB hβ)
      convert h using 2
      all_goals ring
    · have c0 := cos_nonpos_of_mem_coneAt hTP' hβ
      have c0' : 0 ≤ Real.cos (β - (θ₁ + π / 3)) := by
        rw [show β - (θ₁ + 4 * π / 3) = (β - (θ₁ + π / 3)) - π by ring, Real.cos_sub_pi] at c0; linarith
      have h := mem_angleIcc_of_two_cos (a₁ := θ₁ - π / 3) (a₂ := θ₁ + π / 3) (by linarith) (by linarith)
        (cos_nonneg_of_mem_coneAt hTA' hβ) c0'
      convert h using 2
      all_goals ring

/-- The interior points of `l60Frag` by colour: `0` in the open Reuleaux triangle on `0`, `1`, `e 60°`; `1` in the open one on `1`,
`e 60°`, `C`; `2` in `B(1, 1/4)`; `3` in `B(e 60°, 1/4)`. -/
theorem l60_interior_cases {x : ℂ} (hx : x ∈ l60Frag.interiorPts) :
    (l60Frag.col x = 0 ∧ x ∈ ball 0 1 ∩ ball 1 1 ∩ ball (e (π / 3)) 1) ∨
      (l60Frag.col x = 1 ∧ x ∈ ball 1 1 ∩ ball (e (π / 3)) 1 ∩ ball (1 + e (π / 3)) 1) ∨
      (l60Frag.col x = 2 ∧ x ∈ ball 1 (1 / 4)) ∨ (l60Frag.col x = 3 ∧ x ∈ ball (e (π / 3)) (1 / 4)) := by
  classical
  have hcol : l60Frag.col x = l60Col x := rfl
  have hmem : ∀ a ∈ l60Arcs, x ∉ a.carrier := fun a ha h => hx.2 (mem_iUnion₂.mpr ⟨a, ha, h⟩)
  by_cases hL : x ∈ l60Lens
  · obtain ⟨h1, h2, h0⟩ := l60_interior_lens hx hL
    by_cases hn : ‖x‖ < 1
    · left
      refine ⟨by rw [hcol]; simp [l60Col, hL, hn], ⟨⟨?_, ?_⟩, ?_⟩⟩ <;> rw [mem_ball, dist_eq_norm] <;> simpa
    · right; left
      have hn' : 1 < ‖x‖ := lt_of_le_of_ne (not_lt.mp hn) (Ne.symm h0)
      refine ⟨by rw [hcol]; simp [l60Col, hL, hn], ⟨⟨?_, ?_⟩, ?_⟩⟩ <;> rw [mem_ball, dist_eq_norm]
      · exact h1
      · exact h2
      · exact l60_cap_mem_ball h1 h2 hn'
  · right; right
    have hdom : x ∈ l60Lens ∪ closedBall 1 (1 / 4) ∪ closedBall (e (π / 3)) (1 / 4) := interior_subset hx.1
    by_cases hd : dist x 1 < 1 / 4
    · left
      exact ⟨by rw [hcol]; simp only [l60Col, hL, hd, if_false, if_true], hd⟩
    · right
      refine ⟨by rw [hcol]; simp only [l60Col, hL, hd, if_false], ?_⟩
      rcases hdom with (h | h) | h
      · exact absurd h hL
      · exact absurd (lt_of_le_of_ne (mem_closedBall.mp h) fun h' => hmem (.circ 1 (1 / 4) 0 (2 * π)) (by simp [l60Arcs])
          (mem_carrier_circ_full (c := 1) (ρ := 1 / 4) (by rw [← dist_eq_norm]; exact h'))) hd
      · exact lt_of_le_of_ne (mem_closedBall.mp h) fun h' => hmem (.circ (e (π / 3)) (1 / 4) 0 (2 * π)) (by simp [l60Arcs])
          (mem_carrier_circ_full (by rw [← dist_eq_norm]; exact h'))

/-- `l60Frag` is valid. -/
theorem l60Frag_valid : l60Frag.Valid := by
  have h01 : ‖(1 : ℂ) - 0‖ = 1 := by simp
  have h0B : ‖e (π / 3) - 0‖ = 1 := by simp
  have h1B : ‖e (π / 3) - 1‖ = 1 := norm_e_pi_div_three_sub_one
  have h1C : ‖1 + e (π / 3) - 1‖ = 1 := by simp
  have hBC : ‖1 + e (π / 3) - e (π / 3)‖ = 1 := by simp
  have hreul : ∀ {X Y Z p : ℂ}, p ∈ ball X 1 ∩ ball Y 1 ∩ ball Z 1 → p ∈ reul X Y Z := fun ⟨⟨h1, h2⟩, h3⟩ =>
    ⟨⟨ball_subset_closedBall h1, ball_subset_closedBall h2⟩, ball_subset_closedBall h3⟩
  have hhalf : ∀ {x y c : ℂ}, x ∈ ball c (1 / 4) → y ∈ ball c (1 / 4) → dist x y < 1 / 2 := by
    intro x y c hx hy
    rw [mem_ball] at hx hy
    linarith [dist_triangle_right x y c]
  intro x hx y hy hxy hcol
  rcases l60_interior_cases hx with ⟨cx, bx⟩ | ⟨cx, bx⟩ | ⟨cx, bx⟩ | ⟨cx, bx⟩ <;>
    rcases l60_interior_cases hy with ⟨cy, by'⟩ | ⟨cy, by'⟩ | ⟨cy, by'⟩ | ⟨cy, by'⟩ <;>
    rw [cx, cy] at hcol <;> try exact absurd hcol (by decide)
  · linarith [dist_lt_one_of_mem_reul h01 h0B h1B bx (hreul by')]
  · linarith [dist_lt_one_of_mem_reul h1B h1C hBC bx (hreul by')]
  · linarith [hhalf bx by']
  · linarith [hhalf bx by']

/-- The open lens `B(1, 1) ∩ B(e 60°, 1)` lies in `l60Dom`. -/
theorem l60_openLens_subset_dom : ball 1 1 ∩ ball (e (π / 3)) 1 ⊆ l60Dom :=
  interior_maximal (fun _ ⟨h1, h2⟩ => Or.inl (Or.inl ⟨ball_subset_closedBall h1, ball_subset_closedBall h2⟩))
    (isOpen_ball.inter isOpen_ball)

/-- An open part of `l60Dom` of one colour is, up to closure, inside that colour's class. -/
theorem l60_closure_subset_region {U : Set ℂ} (hU : IsOpen U) (hUd : U ⊆ l60Dom) {c : Fin 4} (hc : ∀ w ∈ U, l60Col w = c) :
    closure U ⊆ closure (l60Frag.region c ∩ U) := by
  refine closure_minimal (fun u hu => ?_) isClosed_closure
  have h1 : u ∈ U ∩ closure l60Frag.interiorPts := ⟨hu, l60Frag.dense_interiorPts (hUd hu)⟩
  exact closure_mono (fun w (hw : w ∈ U ∩ l60Frag.interiorPts) => (⟨⟨hw.2, hc w hw.1⟩, hw.1⟩ : w ∈ l60Frag.region c ∩ U))
    (hU.inter_closure h1)

/-- The arc `r([0, 60°])` of `ω(0)` lies in `l60Dom`. -/
theorem ringArc_l60_subset_dom : ringArc 0 0 (π / 3) ⊆ l60Dom := by
  rintro _ ⟨θ, hθ, rfl⟩
  have hπ := Real.pi_pos
  have hO : IsOpen (ball 1 (1 / 4) ∪ ball (e (π / 3)) (1 / 4) ∪ (ball 1 1 ∩ ball (e (π / 3)) 1)) :=
    (isOpen_ball.union isOpen_ball).union (isOpen_ball.inter isOpen_ball)
  have hsub : ball 1 (1 / 4) ∪ ball (e (π / 3)) (1 / 4) ∪ (ball 1 1 ∩ ball (e (π / 3)) 1) ⊆ l60Dom := by
    refine interior_maximal ?_ hO
    rintro z ((h | h) | ⟨h1, h2⟩)
    · exact Or.inl (Or.inr (ball_subset_closedBall h))
    · exact Or.inr (ball_subset_closedBall h)
    · exact Or.inl (Or.inl ⟨ball_subset_closedBall h1, ball_subset_closedBall h2⟩)
  apply hsub
  have hr0 : ringPt 0 0 = 1 := by simp [ringPt, e]
  have hr60 : ringPt 0 (π / 3) = e (π / 3) := by simp [ringPt]
  rcases eq_or_lt_of_le hθ.1 with h0 | h0
  · subst h0; left; left; rw [hr0]; exact mem_ball_self (by norm_num)
  rcases eq_or_lt_of_le hθ.2 with h1 | h1
  · subst h1; left; right; rw [hr60]; exact mem_ball_self (by norm_num)
  right
  constructor
  · rw [mem_ball, ← hr0]
    refine ((dist_ringPt_ringPt_cmp_one 0 (α := θ) (β := 0) (by rw [sub_zero, abs_of_pos h0]; linarith)).2.1).2 ?_
    rw [sub_zero, abs_of_pos h0]; exact h1
  · rw [mem_ball, ← hr60]
    refine ((dist_ringPt_ringPt_cmp_one 0 (α := θ) (β := π / 3) (by rw [abs_of_neg (by linarith)]; linarith)).2.1).2 ?_
    rw [abs_of_neg (by linarith)]; linarith

/-- **`r([0, 60°])` is an arc of `Γ` of `l60Frag` with constant sides**, inner colour `0`, outer `1`. -/
theorem l60Frag_isRingArc : l60Frag.IsRingArc 0 0 (π / 3) 0 1 := by
  classical
  have hπ := Real.pi_pos
  set O := ball (1 : ℂ) 1 ∩ ball (e (π / 3)) 1 with hOdef
  have hO : IsOpen O := isOpen_ball.inter isOpen_ball
  have hOL : ∀ w ∈ O, w ∈ l60Lens := fun w ⟨h1, h2⟩ => ⟨ball_subset_closedBall h1, ball_subset_closedBall h2⟩
  refine ⟨by positivity, fun z hz => ⟨ringArc_l60_subset_dom hz, ?_⟩, fun θ hθ => ?_⟩
  · obtain ⟨θ, hθ, rfl⟩ := hz
    exact mem_iUnion₂.mpr ⟨.circ 0 1 0 (π / 3), (show _ ∈ l60Arcs by simp [l60Arcs]), θ, hθ, by simp [ringPt]⟩
  set z := ringPt 0 θ with hz
  have hzO : z ∈ O := by
    have hr0 : ringPt 0 0 = 1 := by simp [ringPt, e]
    have hr60 : ringPt 0 (π / 3) = e (π / 3) := by simp [ringPt]
    constructor
    · rw [mem_ball, ← hr0]
      refine ((dist_ringPt_ringPt_cmp_one 0 (α := θ) (β := 0) (by rw [sub_zero, abs_of_pos hθ.1]; linarith [hθ.2])).2.1).2 ?_
      rw [sub_zero, abs_of_pos hθ.1]; exact hθ.2
    · rw [mem_ball, ← hr60]
      refine ((dist_ringPt_ringPt_cmp_one 0 (α := θ) (β := π / 3)
        (by rw [abs_of_neg (by linarith [hθ.2])]; linarith [hθ.1])).2.1).2 ?_
      rw [abs_of_neg (by linarith [hθ.2])]; linarith [hθ.1]
  have hzn : ‖z‖ = 1 := by simp [hz, ringPt]
  have hOd : O ⊆ l60Dom := l60_openLens_subset_dom
  constructor
  · ext c
    simp only [innerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro h
      obtain ⟨w, hwO, hw, hwb⟩ := mem_closure_iff.mp h O hO hzO
      have : l60Frag.col w = 0 := by
        show l60Col w = 0
        rw [mem_ball, dist_zero_right] at hwb
        simp only [l60Col, hOL w hwO, hwb, if_true]
      rw [← hw.2, this]
    · rintro rfl
      have hU : IsOpen (O ∩ ball 0 1) := hO.inter isOpen_ball
      have hzU : z ∈ closure (O ∩ ball 0 1) :=
        hO.inter_closure ⟨hzO, by rw [closure_ball 0 one_ne_zero, mem_closedBall, dist_zero_right, hzn]⟩
      refine closure_mono (fun w (hw : w ∈ l60Frag.region 0 ∩ (O ∩ ball 0 1)) =>
        (⟨hw.1, hw.2.2⟩ : w ∈ l60Frag.region 0 ∩ ball 0 1))
        (l60_closure_subset_region hU (inter_subset_left.trans hOd) (fun w hw => ?_) hzU)
      have hwb := hw.2
      rw [mem_ball, dist_zero_right] at hwb
      simp only [l60Col, hOL w hw.1, hwb, if_true]
  · ext c
    simp only [outerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro h
      obtain ⟨w, hwO, hw, hwb⟩ := mem_closure_iff.mp h O hO hzO
      have : l60Frag.col w = 1 := by
        show l60Col w = 1
        rw [mem_closedBall, dist_zero_right, not_le] at hwb
        simp only [l60Col, hOL w hwO, not_lt.mpr hwb.le, if_true, if_false]
      rw [← hw.2, this]
    · rintro rfl
      have hU : IsOpen (O ∩ (closedBall 0 1)ᶜ) := hO.inter isClosed_closedBall.isOpen_compl
      have hzU : z ∈ closure (O ∩ (closedBall 0 1)ᶜ) :=
        hO.inter_closure ⟨hzO, by
          rw [closure_compl, interior_closedBall 0 one_ne_zero, mem_compl_iff, mem_ball, dist_zero_right, hzn]; exact lt_irrefl 1⟩
      refine closure_mono (fun w (hw : w ∈ l60Frag.region 1 ∩ (O ∩ (closedBall 0 1)ᶜ)) =>
        (⟨hw.1, hw.2.2⟩ : w ∈ l60Frag.region 1 \ closedBall 0 1))
        (l60_closure_subset_region hU (inter_subset_left.trans hOd) (fun w hw => ?_) hzU)
      have hwb := hw.2
      rw [mem_compl_iff, mem_closedBall, dist_zero_right, not_le] at hwb
      simp only [l60Col, hOL w hw.1, not_lt.mpr hwb.le, if_true, if_false]

/-- **FS114-L60-LE**, L60-REAL: equality is realised by a valid fragment by formula on a neighbourhood of the closed arc — the arc
`r([0, 60°])` of `ω(0)` is an arc of `Γ` with constant sides (inner colour `0`, outer `1`) of `l60Frag`, which is valid and whose
domain holds a neighbourhood of the closed arc. -/
theorem l60_real : l60Frag.Valid ∧ l60Frag.IsRingArc 0 0 (π / 3) 0 1 ∧
    ∃ δ > 0, thickening δ (ringArc 0 0 (π / 3)) ⊆ l60Frag.dom := by
  refine ⟨l60Frag_valid, l60Frag_isRingArc, ?_⟩
  have hc : IsCompact (ringArc 0 0 (π / 3)) := isCompact_Icc.image (by unfold ringPt e; fun_prop)
  obtain ⟨δ, hδ, h⟩ := hc.exists_thickening_subset_open isOpen_l60Dom ringArc_l60_subset_dom
  exact ⟨δ, hδ, h⟩

/-! ## FS112-N2-BENDS: N2-ENV and the whole-arc bends (FS112-BEND merged) -/

/-- N2-ENV's sine gap: for `a, b > 0` with `a + b = ℓ ≤ 60°`, `sin a + sin b − sin ℓ ≥ (2/π) min(a, b) (1 − cos(ℓ/2))`. -/
theorem sin_add_sin_sub_sin_ge {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (hℓ : a + b ≤ π / 3) :
    2 / π * min a b * (1 - Real.cos ((a + b) / 2)) ≤ Real.sin a + Real.sin b - Real.sin (a + b) := by
  have hπ := Real.pi_pos
  have hid : Real.sin a + Real.sin b - Real.sin (a + b) =
      Real.sin a * (1 - Real.cos b) + Real.sin b * (1 - Real.cos a) := by rw [Real.sin_add]; ring
  rw [hid]
  have hsa : 0 ≤ Real.sin a := Real.sin_nonneg_of_nonneg_of_le_pi ha.le (by linarith)
  have hsb : 0 ≤ Real.sin b := Real.sin_nonneg_of_nonneg_of_le_pi hb.le (by linarith)
  have hca : 0 ≤ 1 - Real.cos a := by linarith [Real.cos_le_one a]
  have hcb : 0 ≤ 1 - Real.cos b := by linarith [Real.cos_le_one b]
  have hc0 : 0 ≤ 1 - Real.cos ((a + b) / 2) := by linarith [Real.cos_le_one ((a + b) / 2)]
  have hmin : 0 ≤ min a b := le_min ha.le hb.le
  -- `sin x ≥ (2/π) x` on `[0, π/2]`, and `cos` decreases on `[0, π]`
  have hJ : ∀ x, 0 ≤ x → x ≤ π / 2 → 2 / π * x ≤ Real.sin x := fun x h0 h1 => Real.mul_le_sin h0 h1
  rcases le_total a b with hle | hle
  · rw [min_eq_left hle]
    have hcos : Real.cos b ≤ Real.cos ((a + b) / 2) :=
      Real.cos_le_cos_of_nonneg_of_le_pi (by linarith) (by linarith) (by linarith)
    have h1 : 2 / π * a * (1 - Real.cos ((a + b) / 2)) ≤ Real.sin a * (1 - Real.cos b) :=
      mul_le_mul (hJ a ha.le (by linarith)) (by linarith) hc0 hsa
    nlinarith [mul_nonneg hsb hca]
  · rw [min_eq_right hle]
    have hcos : Real.cos a ≤ Real.cos ((a + b) / 2) :=
      Real.cos_le_cos_of_nonneg_of_le_pi (by linarith) (by linarith) (by linarith)
    have h1 : 2 / π * b * (1 - Real.cos ((a + b) / 2)) ≤ Real.sin b * (1 - Real.cos a) :=
      mul_le_mul (hJ b hb.le (by linarith)) (by linarith) hc0 hsb
    nlinarith [mul_nonneg hsa hcb]

/-- `e φ` as a combination of the ends: `sin(θ₂ − φ) e θ₁ + sin(φ − θ₁) e θ₂ = sin(θ₂ − θ₁) e φ`. -/
theorem sin_mul_e_add_sin_mul_e (θ₁ θ₂ φ : ℝ) :
    (Real.sin (θ₂ - φ) : ℂ) * e θ₁ + (Real.sin (φ - θ₁) : ℂ) * e θ₂ = (Real.sin (θ₂ - θ₁) : ℂ) * e φ := by
  apply Complex.ext <;>
    simp only [Complex.add_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, Complex.add_im,
      Complex.mul_im, zero_mul, sub_zero, add_zero, Real.sin_sub] <;> ring

/-- **N2-ENV's lens estimate**: for `q` in the lens `B̄(e θ₁, 1) ∩ B̄(e θ₂, 1)` and `φ` between the ends,
`sin(θ₂ − θ₁) · (q · e φ) ≥ (sin(φ − θ₁) + sin(θ₂ − φ)) |q|² / 2`. -/
theorem lens_dot_ge {θ₁ θ₂ φ : ℝ} (h1 : θ₁ ≤ φ) (h2 : φ ≤ θ₂) (hℓ : θ₂ - θ₁ ≤ π) {q : ℂ} (hq1 : ‖q - e θ₁‖ ≤ 1)
    (hq2 : ‖q - e θ₂‖ ≤ 1) :
    (Real.sin (φ - θ₁) + Real.sin (θ₂ - φ)) * ‖q‖ ^ 2 / 2 ≤
      Real.sin (θ₂ - θ₁) * (q.re * Real.cos φ + q.im * Real.sin φ) := by
  have sq : ∀ z : ℂ, ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := fun z => by
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; ring
  have hd : ∀ θ, ‖q - e θ‖ ≤ 1 → ‖q‖ ^ 2 ≤ 2 * (q.re * Real.cos θ + q.im * Real.sin θ) := by
    intro θ h
    have h' : ‖q - e θ‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg (q - e θ)]
    rw [sq, Complex.sub_re, Complex.sub_im, re_e, im_e] at h'
    rw [sq]
    nlinarith [Real.cos_sq_add_sin_sq θ]
  have hs1 : 0 ≤ Real.sin (θ₂ - φ) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith)
  have hs2 : 0 ≤ Real.sin (φ - θ₁) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith)
  have hcomb := sin_mul_e_add_sin_mul_e θ₁ θ₂ φ
  have hre := congrArg Complex.re hcomb
  have him := congrArg Complex.im hcomb
  simp only [Complex.add_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, Complex.add_im,
    Complex.mul_im, zero_mul, sub_zero, add_zero] at hre him
  have e1 := hd θ₁ hq1
  have e2 := hd θ₂ hq2
  have : Real.sin (θ₂ - θ₁) * (q.re * Real.cos φ + q.im * Real.sin φ) =
      Real.sin (θ₂ - φ) * (q.re * Real.cos θ₁ + q.im * Real.sin θ₁) +
        Real.sin (φ - θ₁) * (q.re * Real.cos θ₂ + q.im * Real.sin θ₂) := by
    rw [mul_add, ← mul_assoc, ← mul_assoc, mul_comm (Real.sin (θ₂ - θ₁)) q.re, mul_comm (Real.sin (θ₂ - θ₁)) q.im,
      mul_assoc, mul_assoc, ← hre, ← him]; ring
  rw [this]
  nlinarith [mul_le_mul_of_nonneg_left e1 hs1, mul_le_mul_of_nonneg_left e2 hs2]

/-- `|q − t e φ|² = |q|² − 2t (q · e φ) + t²`. -/
theorem sq_norm_sub_ofReal_mul_e (q : ℂ) (t φ : ℝ) :
    ‖q - (t : ℂ) * e φ‖ ^ 2 = ‖q‖ ^ 2 - 2 * t * (q.re * Real.cos φ + q.im * Real.sin φ) + t ^ 2 := by
  rw [← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im, Complex.re_ofReal_mul, Complex.im_ofReal_mul, re_e, im_e]
  linear_combination t ^ 2 * Real.cos_sq_add_sin_sq φ

/-- N2-ENV near, the real core: `S Q ≤ 2 L D`, `L ≤ (1 − s) S`, `0 < s < 1` give `Q − 2(1 − s) D + (1 − s)² < 1`. -/
theorem n2_env_near_core {Q D S L s : ℝ} (hL : 0 < L) (hQ0 : 0 ≤ Q) (hSD : S * Q ≤ 2 * (L * D))
    (hK : L ≤ (1 - s) * S) (hs : 0 < s) (hs1 : s < 1) : Q - 2 * (1 - s) * D + (1 - s) ^ 2 < 1 := by
  have h1 : L * Q ≤ (1 - s) * S * Q := mul_le_mul_of_nonneg_right hK hQ0
  have h2 : (1 - s) * S * Q ≤ (1 - s) * (2 * (L * D)) := by
    rw [mul_assoc]; exact mul_le_mul_of_nonneg_left hSD (by linarith)
  have h3 : L * Q ≤ L * (2 * (1 - s) * D) := by linarith
  have h4 : Q ≤ 2 * (1 - s) * D := le_of_mul_le_mul_left h3 hL
  nlinarith

/-- N2-ENV near-away, the real core. -/
theorem n2_env_near_away_core {Q D S L s c Δ r : ℝ} (hL : 0 < L) (hL1 : L ≤ 1) (hSD : S * Q ≤ 2 * (L * D))
    (hgap : 2 * c * Δ ≤ S - L) (hs : 0 < s) (h3s : 3 * s ≤ c * r ^ 2 * Δ) (hs1 : s ≤ 1) (hc : 0 < c) (hΔ : 0 < Δ)
    (hr : 0 < r) (hrQ : r ^ 2 ≤ Q) : Q - 2 * (1 + s) * D + (1 + s) ^ 2 < 1 := by
  have hQ0 : 0 ≤ Q := le_trans (sq_nonneg r) hrQ
  have h0 : 0 ≤ 2 * c * Δ := by positivity
  have hK : (1 + 2 * c * Δ + s) * L ≤ (1 + s) * S := by
    have h1 : 2 * c * Δ * L ≤ 2 * c * Δ := by nlinarith
    have hSl : 0 ≤ S - L := by linarith
    have hp := mul_nonneg hs.le hSl
    nlinarith
  have h1 : (1 + 2 * c * Δ + s) * L * Q ≤ (1 + s) * S * Q := mul_le_mul_of_nonneg_right hK hQ0
  have h2 : (1 + s) * S * Q ≤ (1 + s) * (2 * (L * D)) := by
    rw [mul_assoc]; exact mul_le_mul_of_nonneg_left hSD (by linarith)
  have h3 : L * ((1 + 2 * c * Δ + s) * Q) ≤ L * (2 * (1 + s) * D) := by linarith
  have hQ : (1 + 2 * c * Δ + s) * Q ≤ 2 * (1 + s) * D := le_of_mul_le_mul_left h3 hL
  have hcoef : 0 ≤ 2 * c * Δ + s := by positivity
  have h4 : (2 * c * Δ + s) * r ^ 2 ≤ (2 * c * Δ + s) * Q := mul_le_mul_of_nonneg_left hrQ hcoef
  have hmain : 2 * s + s ^ 2 < (2 * c * Δ + s) * r ^ 2 := by
    have : 0 < c * r ^ 2 * Δ := by positivity
    nlinarith
  calc Q - 2 * (1 + s) * D + (1 + s) ^ 2 ≤ Q - (1 + 2 * c * Δ + s) * Q + (1 + s) ^ 2 := by linarith
    _ = (1 + s) ^ 2 - (2 * c * Δ + s) * Q := by ring
    _ ≤ (1 + s) ^ 2 - (2 * c * Δ + s) * r ^ 2 := by linarith
    _ < 1 := by linarith

/-- The arc data of N2-ENV: for `φ` strictly inside `(θ₁, θ₂)` with `ℓ = θ₂ − θ₁ ≤ 60°`, the sine gap and the lens estimate of a point
of the lens of the ends about `P`. -/
theorem n2_env_data (P : ℂ) {θ₁ θ₂ φ : ℝ} (hℓ : θ₂ - θ₁ ≤ π / 3) (hφ : φ ∈ Ioo θ₁ θ₂) {p : ℂ}
    (hp : p ∈ closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) :
    2 / π * min (φ - θ₁) (θ₂ - φ) * (1 - Real.cos ((θ₂ - θ₁) / 2)) ≤
        Real.sin (φ - θ₁) + Real.sin (θ₂ - φ) - Real.sin (θ₂ - θ₁) ∧
      (Real.sin (φ - θ₁) + Real.sin (θ₂ - φ)) * ‖p - P‖ ^ 2 ≤
        2 * (Real.sin (θ₂ - θ₁) * ((p - P).re * Real.cos φ + (p - P).im * Real.sin φ)) := by
  have hπ := Real.pi_pos
  obtain ⟨hp1, hp2⟩ := hp
  have ha0 : 0 < φ - θ₁ := by linarith [hφ.1]
  have hb0 : 0 < θ₂ - φ := by linarith [hφ.2]
  have hgap := sin_add_sin_sub_sin_ge ha0 hb0 (by linarith)
  rw [show φ - θ₁ + (θ₂ - φ) = θ₂ - θ₁ by ring] at hgap
  refine ⟨hgap, ?_⟩
  have hq1 : ‖(p - P) - e θ₁‖ ≤ 1 := by
    rw [mem_closedBall, dist_eq_norm, ringPt, show p - (P + e θ₁) = (p - P) - e θ₁ by ring] at hp1; exact hp1
  have hq2 : ‖(p - P) - e θ₂‖ ≤ 1 := by
    rw [mem_closedBall, dist_eq_norm, ringPt, show p - (P + e θ₂) = (p - P) - e θ₂ by ring] at hp2; exact hp2
  have hL := lens_dot_ge hφ.1.le hφ.2.le (by linarith) hq1 hq2
  linarith

/-- N2-ENV toward's angle step: with `U ≥ x > 0` (`U = x cos Δ + y sin Δ`), `x² + y² ≥ 2U` and the disc `x² + y² ≤ 2(1 − s)x + 2s − s²`,
the direction is at least `45°` off the centre: `x ≤ y`. -/
theorem toward_dir45 {x y U s : ℝ} (hx : 0 < x) (hy : 0 ≤ y) (hUx : x ≤ U) (hs : 0 < s)
    (hunc : 2 * U ≤ x ^ 2 + y ^ 2) (hdisc : x ^ 2 + y ^ 2 ≤ 2 * (1 - s) * x + 2 * s - s ^ 2) : x ≤ y := by
  have hU0 : 0 ≤ U := by linarith
  have hρ0 : 0 ≤ x ^ 2 + y ^ 2 := by positivity
  have hdiff : ((x ^ 2 + y ^ 2) - 2 * (1 - s) * x) * (x ^ 2 + y ^ 2) - (4 * U ^ 2 - 4 * (1 - s) * U * x) =
      ((x ^ 2 + y ^ 2) - 2 * U) * ((x ^ 2 + y ^ 2) + 2 * U - 2 * (1 - s) * x) := by ring
  have hA : 0 ≤ (x ^ 2 + y ^ 2) - 2 * U := by linarith
  have hsx : (1 - s) * x ≤ x := by nlinarith
  have hB : 0 ≤ (x ^ 2 + y ^ 2) + 2 * U - 2 * (1 - s) * x := by linarith
  have h1 := mul_nonneg hA hB
  have h2 : ((x ^ 2 + y ^ 2) - 2 * (1 - s) * x) * (x ^ 2 + y ^ 2) ≤ (2 * s) * (x ^ 2 + y ^ 2) :=
    mul_le_mul_of_nonneg_right (by nlinarith) hρ0
  have hkey : 4 * U ^ 2 - 4 * (1 - s) * U * x ≤ 2 * s * (x ^ 2 + y ^ 2) := by linarith
  have hUU : U * x ≤ U * U := mul_le_mul_of_nonneg_left hUx hU0
  have h3 : s * (2 * (U * x)) ≤ s * (x ^ 2 + y ^ 2) := by nlinarith
  have h4 : 2 * (U * x) ≤ x ^ 2 + y ^ 2 := le_of_mul_le_mul_left h3 hs
  have hxx : x * x ≤ U * x := mul_le_mul_of_nonneg_right hUx hx.le
  have h5 : x ^ 2 ≤ y ^ 2 := by nlinarith
  by_contra h
  push Not at h
  have := mul_lt_mul'' h h hy hy
  nlinarith

/-- N2-ENV toward, the real core beside the arc (`x > 0`, `y ≥ 0`, direction beyond `Δ`). -/
theorem n2_env_toward_beside {x y s Δ ψ : ℝ} (hΔ : 0 < Δ) (hΔ6 : Δ ≤ π / 6) (hs : 0 < s) (hsψ : s ≤ ψ * Δ)
    (hy : 0 ≤ y) (hdisc : x ^ 2 + y ^ 2 ≤ 2 * (1 - s) * x + 2 * s - s ^ 2)
    (hunc : 2 * (x * Real.cos Δ + y * Real.sin Δ) ≤ x ^ 2 + y ^ 2) (hdir : x * Real.sin Δ < y * Real.cos Δ) (hx : 0 < x) :
    x ^ 2 + y ^ 2 ≤ 72 * ψ ^ 2 := by
  have hπ := Real.pi_pos
  have hπ4 := Real.pi_le_four
  have hcos : 0 < Real.cos Δ := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  have hcos1' : Real.cos Δ ≤ 1 := Real.cos_le_one Δ
  have hsin0 : 0 < Real.sin Δ := Real.sin_pos_of_pos_of_lt_pi hΔ (by linarith)
  have hsin : 2 / π * Δ ≤ Real.sin Δ := Real.mul_le_sin hΔ.le (by linarith)
  have hcos1 : 1 - Δ ^ 2 / 2 ≤ Real.cos Δ := Real.one_sub_sq_div_two_le_cos
  have hcs := Real.cos_sq_add_sin_sq Δ
  have hψ : 0 ≤ ψ := by
    by_contra h; push Not at h
    have : ψ * Δ < 0 := mul_neg_of_neg_of_pos h hΔ
    linarith
  have hUx : x ≤ x * Real.cos Δ + y * Real.sin Δ := by
    have h1 : x * Real.sin Δ ^ 2 ≤ y * Real.sin Δ * Real.cos Δ := by
      have := mul_le_mul_of_nonneg_left hdir.le hsin0.le
      linarith [this]
    have e2 : x * Real.cos Δ ^ 2 + x * Real.sin Δ ^ 2 = x := by rw [← mul_add, hcs, mul_one]
    have h3 : 0 ≤ x * (1 - Real.cos Δ) := mul_nonneg hx.le (by linarith)
    have : 0 ≤ (x * Real.cos Δ + y * Real.sin Δ - x) * Real.cos Δ := by
      have e : (x * Real.cos Δ + y * Real.sin Δ - x) * Real.cos Δ =
          x * Real.cos Δ ^ 2 + y * Real.sin Δ * Real.cos Δ - x * Real.cos Δ := by ring
      rw [e]; linarith
    exact sub_nonneg.mp (nonneg_of_mul_nonneg_left this hcos)
  have hxy : x ≤ y := toward_dir45 hx hy hUx hs hunc hdisc
  have hUle : x * Real.cos Δ + y * Real.sin Δ - x ≤ s := by
    have hsx : 0 ≤ s * x := mul_nonneg hs.le hx.le
    have : s ^ 2 ≥ 0 := sq_nonneg s
    linarith
  have hgap : Δ / 6 ≤ Real.sin Δ - (1 - Real.cos Δ) := by
    have h1 : Δ ^ 2 / 2 ≤ Δ * (1 / 3) := by
      have : Δ ≤ 2 / 3 := by linarith
      have := mul_le_mul_of_nonneg_left this hΔ.le
      linarith
    have h2 : Δ * (1 / 2) ≤ 2 / π * Δ := by
      rw [show 2 / π * Δ = Δ * (2 / π) by ring]
      exact mul_le_mul_of_nonneg_left (by rw [le_div_iff₀ hπ]; linarith) hΔ.le
    linarith
  have hyb : y * (Δ / 6) ≤ s := by
    have h1 : y * (Real.sin Δ - (1 - Real.cos Δ)) ≤ x * Real.cos Δ + y * Real.sin Δ - x := by
      have : y * (Real.cos Δ - 1) ≤ x * (Real.cos Δ - 1) := mul_le_mul_of_nonpos_right hxy (by linarith)
      linarith
    have := mul_le_mul_of_nonneg_left hgap hy
    linarith
  have hy6 : y ≤ 6 * ψ := by
    have : y * (Δ / 6) ≤ (6 * ψ) * (Δ / 6) := by
      have : (6 * ψ) * (Δ / 6) = ψ * Δ := by ring
      linarith
    exact le_of_mul_le_mul_right this (by positivity)
  have hyy : y * y ≤ (6 * ψ) * (6 * ψ) := mul_le_mul hy6 hy6 hy (by positivity)
  have hxx : x * x ≤ y * y := mul_le_mul hxy hxy hx.le hy
  nlinarith

/-- N2-ENV toward, the real core on one side (`y ≥ 0`), off the arc's directions: a point of `B̄(1 − s, 1)` (in the frame of `φ`)
farther than `1` from `e Δ` lies within `√72 ψ` of `0` when `s ≤ ψ Δ`. -/
theorem n2_env_toward_core {x y s Δ ψ : ℝ} (hΔ : 0 < Δ) (hΔ6 : Δ ≤ π / 6) (hs : 0 < s) (hsψ : s ≤ ψ * Δ) (hs1 : s < 1) (hy : 0 ≤ y)
    (hdisc : x ^ 2 + y ^ 2 ≤ 2 * (1 - s) * x + 2 * s - s ^ 2)
    (hunc : 2 * (x * Real.cos Δ + y * Real.sin Δ) ≤ x ^ 2 + y ^ 2) (hdir : x * Real.sin Δ < y * Real.cos Δ) :
    x ^ 2 + y ^ 2 ≤ 72 * ψ ^ 2 := by
  have hπ := Real.pi_pos
  have hπ4 := Real.pi_le_four
  have hcos : 0 < Real.cos Δ := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  have hsin : 2 / π * Δ ≤ Real.sin Δ := Real.mul_le_sin hΔ.le (by linarith)
  have hcos1 : 1 - Δ ^ 2 / 2 ≤ Real.cos Δ := Real.one_sub_sq_div_two_le_cos
  have hcs := Real.cos_sq_add_sin_sq Δ
  have hψ : 0 ≤ ψ := by
    by_contra h; push Not at h; nlinarith
  -- `x ≥ −s` from the disc
  have hxs : -s ≤ x := by nlinarith [sq_nonneg y, sq_nonneg (x - (1 - s) + 1)]
  rcases le_or_gt x 0 with hx | hx
  · -- behind: `y sin Δ ≤ 2s`
    have h1 : y * Real.sin Δ ≤ 2 * s := by
      have : x * (1 - s - Real.cos Δ) ≤ s := by
        have ha : |1 - s - Real.cos Δ| ≤ 1 := by
          rw [abs_le]; constructor <;> nlinarith [Real.cos_le_one Δ]
        have hb : |x| ≤ s := by rw [abs_le]; constructor <;> linarith
        calc x * (1 - s - Real.cos Δ) ≤ |x * (1 - s - Real.cos Δ)| := le_abs_self _
          _ = |x| * |1 - s - Real.cos Δ| := abs_mul _ _
          _ ≤ s * 1 := mul_le_mul hb ha (abs_nonneg _) hs.le
          _ = s := mul_one s
      nlinarith
    have hy' : y ≤ π * ψ := by
      have h2 : y * (2 / π * Δ) ≤ 2 * (ψ * Δ) := by nlinarith [mul_le_mul_of_nonneg_left hsin hy]
      have h3 : y * (2 / π * Δ) = (2 * Δ / π) * y := by ring
      have h4 : 2 * (ψ * Δ) = (2 * Δ / π) * (π * ψ) := by field_simp
      rw [h3, h4] at h2
      exact le_of_mul_le_mul_left h2 (by positivity)
    have hx' : x ^ 2 ≤ ψ ^ 2 := by
      have : s ≤ ψ := by nlinarith
      nlinarith
    have hπ2 : π ^ 2 ≤ 16 := by nlinarith
    nlinarith [mul_le_mul hy' hy' hy (by positivity : 0 ≤ π * ψ)]
  · exact n2_env_toward_beside hΔ hΔ6 hs hsψ hy hdisc hunc hdir hx

/-- Frame coordinates of a point given in polar form about the frame's origin: `v + ρ e(α + t)` is at `(ρ cos t, ρ sin t)`. -/
theorem frame_polar_add (v : ℂ) (α ρ t : ℝ) :
    frameX v α (v + (ρ : ℂ) * e (α + t)) = ρ * Real.cos t ∧ frameY v α (v + (ρ : ℂ) * e (α + t)) = ρ * Real.sin t := by
  have h : (v + (ρ : ℂ) * e (α + t) - v) * starRingEnd ℂ (e α) = (ρ : ℂ) * e t := by
    rw [e_add]
    calc _ = (ρ : ℂ) * e t * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [conj_e_mul_e, mul_one]
  unfold frameX frameY
  rw [h]
  simp [re_e, im_e]

/-- A point at angle `|t| ≤ Δ` off `φ` and distance in `(0, 2)` from the centre is within `< 1` of the ring point in its direction:
in frame coordinates, for `x sin Δ ≥ |y| cos Δ`, `0 < x² + y²`, some `|t| ≤ Δ` has `x cos t + y sin t = √(x² + y²)`. -/
theorem exists_dir_of_within {x y Δ : ℝ} (hΔ : 0 < Δ) (hΔ2 : Δ < π / 2) (h : |y| * Real.cos Δ ≤ x * Real.sin Δ)
    (h0 : 0 < x ^ 2 + y ^ 2) : ∃ t, |t| ≤ Δ ∧ x * Real.cos t + y * Real.sin t = √(x ^ 2 + y ^ 2) := by
  have hcos : 0 < Real.cos Δ := Real.cos_pos_of_mem_Ioo ⟨by linarith, hΔ2⟩
  have hsin : 0 < Real.sin Δ := Real.sin_pos_of_pos_of_lt_pi hΔ (by linarith)
  have hx : 0 < x := by
    rcases lt_trichotomy x 0 with hx | hx | hx
    · nlinarith [abs_nonneg y, mul_nonneg (abs_nonneg y) hcos.le]
    · rw [hx, zero_mul] at h
      have hy : |y| = 0 := le_antisymm (by nlinarith [abs_nonneg y]) (abs_nonneg y)
      rw [abs_eq_zero] at hy; rw [hx, hy] at h0; norm_num at h0
    · exact hx
  refine ⟨Real.arctan (y / x), ?_, ?_⟩
  · have htan : |y / x| ≤ Real.tan Δ := by
      rw [Real.tan_eq_sin_div_cos, abs_div, abs_of_pos hx, div_le_div_iff₀ hx hcos]; linarith
    rw [abs_le] at htan ⊢
    have hmono := Real.arctan_strictMono.monotone
    have h1 := hmono htan.2
    have h2 := hmono htan.1
    rw [Real.arctan_tan (by linarith) hΔ2] at h1
    rw [Real.arctan_neg, Real.arctan_tan (by linarith) hΔ2] at h2
    exact ⟨h2, h1⟩
  · rw [Real.cos_arctan, Real.sin_arctan]
    have hs : 0 < √(1 + (y / x) ^ 2) := Real.sqrt_pos.2 (by positivity)
    have hq : √(x ^ 2 + y ^ 2) = x * √(1 + (y / x) ^ 2) := by
      rw [show x ^ 2 + y ^ 2 = x ^ 2 * (1 + (y / x) ^ 2) by field_simp, Real.sqrt_mul (sq_nonneg x),
        Real.sqrt_sq hx.le]
    rw [hq]
    field_simp
    ring_nf
    rw [Real.sq_sqrt (by positivity)]
    field_simp

/-- **FS112-N2-BENDS**, N2-ENV toward: for a closed arc `ᾱ = r([θ₁, θ₂])` of `ω(P)` with `0 < ℓ ≤ 60°` and every `r > 0` there is a
lens profile `ψ > 0` such that, for every toward lens point `z = P + (1 − s) e(φ)` with `φ` interior and `0 < s ≤ ψ·Δ(φ)` (`Δ` the angular
distance to the nearer end), the part of `B̄(z, 1)` not within `< 1` of some point of `ᾱ` lies in `B(P, r)`. -/
theorem n2_env_toward (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 - s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ ball P r := by
  have _ := h12
  have hπ := Real.pi_pos
  refine ⟨min 1 (r / 9), by positivity, fun φ hφ s hs hsψ p hp => ?_⟩
  obtain ⟨hp1, hp2⟩ := hp
  simp only [mem_iUnion, not_exists] at hp2
  set Δ := min (φ - θ₁) (θ₂ - φ) with hΔdef
  have hΔ0 : 0 < Δ := lt_min (by linarith [hφ.1]) (by linarith [hφ.2])
  have hΔ6 : Δ ≤ π / 6 := by
    rcases le_total (φ - θ₁) (θ₂ - φ) with h | h <;> simp only [hΔdef, h, min_eq_left, min_eq_right] <;> linarith
  have hψ1 : min 1 (r / 9) ≤ 1 := min_le_left _ _
  have hs1 : s < 1 := by
    have : min 1 (r / 9) * Δ ≤ 1 * (π / 6) := mul_le_mul hψ1 hΔ6 hΔ0.le zero_le_one
    linarith [Real.pi_le_four]
  set x := frameX P φ p with hx
  set y := frameY P φ p with hy
  have hdist : ∀ ρ t : ℝ, dist p (P + (ρ : ℂ) * e (φ + t)) ^ 2 = (x - ρ * Real.cos t) ^ 2 + (y - ρ * Real.sin t) ^ 2 := by
    intro ρ t
    rw [sq_dist_frame P φ, (frame_polar_add P φ ρ t).1, (frame_polar_add P φ ρ t).2]
  have hdisc : x ^ 2 + y ^ 2 ≤ 2 * (1 - s) * x + 2 * s - s ^ 2 := by
    have h1 := hdist (1 - s) 0
    rw [add_zero, Real.cos_zero, Real.sin_zero] at h1
    push_cast at h1
    have h2 : dist p (P + (1 - (s : ℂ)) * e φ) ^ 2 ≤ 1 := by
      have := mem_closedBall.mp hp1
      nlinarith [dist_nonneg (x := p) (y := P + (1 - (s : ℂ)) * e φ)]
    nlinarith
  have hunc : ∀ t, |t| ≤ Δ → 2 * (x * Real.cos t + y * Real.sin t) ≤ x ^ 2 + y ^ 2 := by
    intro t ht
    rw [abs_le] at ht
    have hmem : φ + t ∈ Icc θ₁ θ₂ := ⟨by linarith [min_le_left (φ - θ₁) (θ₂ - φ)], by
      linarith [min_le_right (φ - θ₁) (θ₂ - φ)]⟩
    have h1 := hp2 (φ + t) hmem
    rw [mem_ball, not_lt] at h1
    have h2 := hdist 1 t
    rw [Complex.ofReal_one, one_mul] at h2
    have h3 : 1 ≤ dist p (ringPt P (φ + t)) ^ 2 := by nlinarith
    rw [ringPt] at h3
    rw [h2] at h3
    nlinarith [Real.cos_sq_add_sin_sq t]
  have hnorm : dist p P ^ 2 = x ^ 2 + y ^ 2 := by rw [dist_eq_norm, ← frame_normSq P φ p]
  rw [mem_ball]
  have hψ : min 1 (r / 9) ≤ r / 9 := min_le_right _ _
  have hψ0 : 0 < min 1 (r / 9) := by positivity
  have hbound : x ^ 2 + y ^ 2 < r ^ 2 := by
    by_cases hw : |y| * Real.cos Δ ≤ x * Real.sin Δ
    · -- within the arc's directions: covered unless `p = P`
      by_cases h0 : x ^ 2 + y ^ 2 = 0
      · rw [h0]; positivity
      have h0' : 0 < x ^ 2 + y ^ 2 := lt_of_le_of_ne (by positivity) (Ne.symm h0)
      obtain ⟨t, ht, hxt⟩ := exists_dir_of_within hΔ0 (by linarith) hw h0'
      have h1 := hunc t ht
      rw [hxt] at h1
      set ρ := √(x ^ 2 + y ^ 2) with hρ
      have hρ0 : 0 < ρ := Real.sqrt_pos.2 h0'
      have hρ2 : ρ ^ 2 = x ^ 2 + y ^ 2 := Real.sq_sqrt h0'.le
      have hxρ : x ≤ ρ := by
        have := Real.sqrt_le_sqrt (show x ^ 2 ≤ x ^ 2 + y ^ 2 by nlinarith)
        rw [Real.sqrt_sq_eq_abs] at this
        exact (le_abs_self x).trans this
      exfalso
      have hge : 2 ≤ ρ := by nlinarith
      have : ρ ^ 2 ≤ 2 * (1 - s) * ρ + 2 * s - s ^ 2 := by nlinarith
      nlinarith
    · push Not at hw
      have hb : x ^ 2 + y ^ 2 ≤ 72 * min 1 (r / 9) ^ 2 := by
        rcases le_total 0 y with hy0 | hy0
        · rw [abs_of_nonneg hy0] at hw
          exact n2_env_toward_core hΔ0 hΔ6 hs hsψ hs1 hy0 hdisc (hunc Δ (by rw [abs_of_pos hΔ0])) hw
        · rw [abs_of_nonpos hy0] at hw
          have h1 := hunc (-Δ) (by rw [abs_neg, abs_of_pos hΔ0])
          rw [Real.cos_neg, Real.sin_neg] at h1
          have := n2_env_toward_core (y := -y) hΔ0 hΔ6 hs hsψ hs1 (by linarith) (by nlinarith) (by nlinarith) hw
          nlinarith
      have : 72 * min 1 (r / 9) ^ 2 < r ^ 2 := by
        have h1 : min 1 (r / 9) ^ 2 ≤ (r / 9) ^ 2 := pow_le_pow_left₀ hψ0.le hψ 2
        nlinarith
      linarith
  rw [← hnorm] at hbound
  exact lt_of_pow_lt_pow_left₀ 2 hr.le hbound

/-- N2-ENV away beyond an end, the height bound: in the end's frame, a point of the disc about `(1 + s)e(−b)` outside `B(1, 1)` with
`0 < X ≤ 2 + s` has `Y sin b ≤ s`. -/
theorem n2_env_away_height {X Y s b : ℝ} (hs : 0 < s) (hX : 0 < X) (hX2 : X ≤ 2 + s)
    (hdisc : (X - (1 + s) * Real.cos b) ^ 2 + (Y + (1 + s) * Real.sin b) ^ 2 ≤ 1) (hunc : 2 * X ≤ X ^ 2 + Y ^ 2) :
    Y * Real.sin b ≤ s := by
  have hcos1 : Real.cos b ≤ 1 := Real.cos_le_one b
  have hcs := Real.cos_sq_add_sin_sq b
  have e : (X - (1 + s) * Real.cos b) ^ 2 + (Y + (1 + s) * Real.sin b) ^ 2 =
      X ^ 2 + Y ^ 2 - 2 * (1 + s) * (X * Real.cos b - Y * Real.sin b) + (1 + s) ^ 2 := by
    linear_combination (1 + s) ^ 2 * hcs
  rw [e] at hdisc
  have h1 : (1 + s) * (Y * Real.sin b) ≤ X * ((1 + s) * Real.cos b - 1) - s - s ^ 2 / 2 := by
    have : 2 * X - 2 * (1 + s) * (X * Real.cos b - Y * Real.sin b) + (1 + s) ^ 2 ≤ 1 := by linarith
    linarith
  have h2 : X * ((1 + s) * Real.cos b - 1) ≤ X * s := by
    apply mul_le_mul_of_nonneg_left _ hX.le
    have : s * Real.cos b ≤ s := by nlinarith
    linarith
  have h3 : X * s ≤ (2 + s) * s := mul_le_mul_of_nonneg_right hX2 hs.le
  have h4 : (1 + s) * (Y * Real.sin b) ≤ (1 + s) * s := by nlinarith
  exact le_of_mul_le_mul_left h4 (by linarith)

/-- N2-ENV away, the real core beyond an end (in the end's frame, `Y > 0`): a point of the disc about `(1 + s)e(−b)` outside
`B(1, 1)`, with `X² + Y² ≥ 2 + s`, lies within `√12 ψ` of the radius-2 end `(2, 0)` when `s ≤ ψ b`, `ψ ≤ 1/2`. -/
theorem n2_env_away_core {X Y s b ψ : ℝ} (hb : 0 < b) (hb3 : b ≤ π / 3) (hs : 0 < s) (hsψ : s ≤ ψ * b) (hψ2 : ψ ≤ 1 / 2)
    (hX : 0 < X) (hY : 0 < Y)
    (hdisc : (X - (1 + s) * Real.cos b) ^ 2 + (Y + (1 + s) * Real.sin b) ^ 2 ≤ 1)
    (hunc : 2 * X ≤ X ^ 2 + Y ^ 2) (hfar : 2 + s ≤ X ^ 2 + Y ^ 2) (hnear : X ^ 2 + Y ^ 2 ≤ (2 + s) ^ 2) :
    (X - 2) ^ 2 + Y ^ 2 ≤ 12 * ψ ^ 2 := by
  have hπ := Real.pi_pos
  have hπ4 := Real.pi_le_four
  have hsin : 2 / π * b ≤ Real.sin b := Real.mul_le_sin hb.le (by linarith)
  have hψ0 : 0 ≤ ψ := by
    by_contra h; push Not at h
    have : ψ * b < 0 := mul_neg_of_neg_of_pos h hb
    linarith
  have hb1 : b ≤ 2 := by linarith
  have hs2 : s ≤ 2 * ψ := by
    have := mul_le_mul_of_nonneg_left hb1 hψ0
    linarith
  have hs1 : s ≤ 1 := by linarith
  have hX2 : X ≤ 2 + s := by
    have : X ^ 2 ≤ (2 + s) ^ 2 := by linarith [sq_nonneg Y]
    exact (pow_le_pow_iff_left₀ hX.le (by linarith) two_ne_zero).mp this
  have hYs := n2_env_away_height hs hX hX2 hdisc hunc
  have hY2 : Y ≤ 2 * ψ := by
    have h1 : Y * (2 / π * b) ≤ s := le_trans (mul_le_mul_of_nonneg_left hsin hY.le) hYs
    have h2 : Y * (b / 2) ≤ Y * (2 / π * b) := by
      apply mul_le_mul_of_nonneg_left _ hY.le
      have : (1 : ℝ) / 2 ≤ 2 / π := by rw [le_div_iff₀ hπ]; linarith
      have := mul_le_mul_of_nonneg_left this hb.le
      linarith
    have h3 : Y * (b / 2) ≤ (2 * ψ) * (b / 2) := by
      have : (2 * ψ) * (b / 2) = ψ * b := by ring
      linarith
    exact le_of_mul_le_mul_right h3 (by positivity)
  have hY1 : Y ≤ 1 := by linarith
  have hYY : Y ^ 2 ≤ Y := by
    have := mul_le_mul_of_nonneg_left hY1 hY.le
    nlinarith
  have hX1 : 1 ≤ X := by
    have h1 : Y ^ 2 ≤ 1 := by linarith
    have : (1 : ℝ) ^ 2 ≤ X ^ 2 := by linarith
    exact (pow_le_pow_iff_left₀ zero_le_one hX.le two_ne_zero).mp this
  have hXlo : 2 - Y ^ 2 ≤ X := by
    have h1 : 1 - Y ^ 2 ≤ (X - 1) ^ 2 := by linarith
    have h2 : 0 ≤ 1 - Y ^ 2 := by linarith
    have h3 : (1 - Y ^ 2) ^ 2 ≤ 1 - Y ^ 2 := by
      have : 1 - Y ^ 2 ≤ 1 := by linarith [sq_nonneg Y]
      have := mul_le_mul_of_nonneg_left this h2
      linarith
    have h4 : (1 - Y ^ 2) ^ 2 ≤ (X - 1) ^ 2 := le_trans h3 h1
    have := (pow_le_pow_iff_left₀ h2 (by linarith) two_ne_zero).mp h4
    linarith
  have hd : (X - 2) ^ 2 ≤ Y ^ 2 + s ^ 2 := by
    rcases le_total X 2 with h | h
    · have h5 : (2 - X) ^ 2 ≤ (Y ^ 2) ^ 2 := pow_le_pow_left₀ (by linarith) (by linarith) 2
      have h6 : (Y ^ 2) ^ 2 ≤ Y ^ 2 := by
        have h7 : Y ^ 2 ≤ 1 := by linarith
        have := mul_le_mul_of_nonneg_left h7 (sq_nonneg Y)
        linarith
      have : (X - 2) ^ 2 = (2 - X) ^ 2 := by ring
      linarith [sq_nonneg s]
    · have : (X - 2) ^ 2 ≤ s ^ 2 := pow_le_pow_left₀ (by linarith) (by linarith) 2
      linarith [sq_nonneg Y]
  have hYψ : Y ^ 2 ≤ (2 * ψ) ^ 2 := pow_le_pow_left₀ hY.le hY2 2
  have hsψ' : s ^ 2 ≤ (2 * ψ) ^ 2 := pow_le_pow_left₀ hs.le hs2 2
  have : (2 * ψ) ^ 2 = 4 * ψ ^ 2 := by ring
  linarith

/-- A point with positive frame abscissa is in polar form about the frame's origin at an angle within `90°` of the frame's axis. -/
theorem eq_polar_of_frameX_pos (P p : ℂ) (φ : ℝ) (hx : 0 < frameX P φ p) :
    ∃ t ∈ Ioo (-(π / 2)) (π / 2), p = P + (‖p - P‖ : ℂ) * e (φ + t) := by
  set x := frameX P φ p with hxd
  set y := frameY P φ p with hyd
  have hw : (p - P) * starRingEnd ℂ (e φ) = (x : ℂ) + (y : ℂ) * I := by
    apply Complex.ext <;> simp [hxd, hyd, frameX, frameY]
  have hpP : p - P = ((x : ℂ) + (y : ℂ) * I) * e φ := by
    rw [← hw, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), conj_e_mul_e, mul_one]
  have hn : ‖p - P‖ = √(x ^ 2 + y ^ 2) := by
    rw [hxd, hyd, frame_normSq P φ p, Real.sqrt_sq (norm_nonneg _)]
  refine ⟨Real.arctan (y / x), ⟨Real.neg_pi_div_two_lt_arctan _, Real.arctan_lt_pi_div_two _⟩, ?_⟩
  have hs : 0 < √(1 + (y / x) ^ 2) := Real.sqrt_pos.2 (by positivity)
  have hq : √(x ^ 2 + y ^ 2) = x * √(1 + (y / x) ^ 2) := by
    rw [show x ^ 2 + y ^ 2 = x ^ 2 * (1 + (y / x) ^ 2) by field_simp, Real.sqrt_mul (sq_nonneg x), Real.sqrt_sq hx.le]
  have hc : √(x ^ 2 + y ^ 2) * Real.cos (Real.arctan (y / x)) = x := by
    rw [Real.cos_arctan, hq]; field_simp
  have hsn : √(x ^ 2 + y ^ 2) * Real.sin (Real.arctan (y / x)) = y := by
    rw [Real.sin_arctan, hq]; field_simp
  rw [hn, e_add]
  have : (x : ℂ) + (y : ℂ) * I = (√(x ^ 2 + y ^ 2) : ℂ) * e (Real.arctan (y / x)) := by
    apply Complex.ext <;> simp only [Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_re,
      Complex.mul_im, Complex.I_re, Complex.I_im, re_e, im_e] <;> linarith
  calc p = P + (p - P) := by ring
    _ = _ := by rw [hpP, this]; ring

/-- N2-ENV away beyond an end, as a distance: the core's frame coordinates `(X, Y)` of `p` at the end put `p` within `r` of the
radius-2 end `q` when `ψ ≤ r/4`. -/
theorem n2_env_away_end {p q : ℂ} {X Y s b ψ r : ℝ} (hb : 0 < b) (hb3 : b ≤ π / 3) (hs : 0 < s) (hsψ : s ≤ ψ * b)
    (hψ2 : ψ ≤ 1 / 2) (hψ0 : 0 < ψ) (hψr : ψ ≤ r / 4) (hr : 0 < r) (hX : 0 < X) (hY : 0 < Y)
    (hdisc : (X - (1 + s) * Real.cos b) ^ 2 + (Y + (1 + s) * Real.sin b) ^ 2 ≤ 1)
    (hunc : 2 * X ≤ X ^ 2 + Y ^ 2) (hfar : 2 + s ≤ X ^ 2 + Y ^ 2) (hnear : X ^ 2 + Y ^ 2 ≤ (2 + s) ^ 2)
    (hdd : dist p q ^ 2 = (X - 2) ^ 2 + Y ^ 2) : dist p q < r := by
  have hcore := n2_env_away_core hb hb3 hs hsψ hψ2 hX hY hdisc hunc hfar hnear
  have h1 : ψ ^ 2 ≤ (r / 4) ^ 2 := pow_le_pow_left₀ hψ0.le hψr 2
  have : dist p q ^ 2 < r ^ 2 := by
    rw [hdd]
    have : (r / 4) ^ 2 = r ^ 2 / 16 := by ring
    have h2 : 0 < r ^ 2 := by positivity
    linarith
  exact lt_of_pow_lt_pow_left₀ 2 hr.le this

/-- **FS112-N2-BENDS**, N2-ENV away: the same for an away lens point `z = P + (1 + s) e(φ)`, the uncovered part lying within `r` of
the radius-2 arc `R₂(ᾱ)`. -/
theorem n2_env_away (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 + s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ thickening r (radiusTwoArc P θ₁ θ₂) := by
  have _ := h12
  have hπ := Real.pi_pos
  have hπ4 := Real.pi_le_four
  refine ⟨min (1 / 2) (r / 4), by positivity, fun φ hφ s hs hsψ p hp => ?_⟩
  obtain ⟨hp1, hp2⟩ := hp
  simp only [mem_iUnion, not_exists] at hp2
  have ha0 : 0 < φ - θ₁ := by linarith [hφ.1]
  have hb0 : 0 < θ₂ - φ := by linarith [hφ.2]
  set ψ := min (1 / 2) (r / 4) with hψd
  have hψ0 : 0 < ψ := by positivity
  have hψ2 : ψ ≤ 1 / 2 := min_le_left _ _
  have hψr : ψ ≤ r / 4 := min_le_right _ _
  have hsa : s ≤ ψ * (φ - θ₁) := hsψ.trans (mul_le_mul_of_nonneg_left (min_le_left _ _) hψ0.le)
  have hsb : s ≤ ψ * (θ₂ - φ) := hsψ.trans (mul_le_mul_of_nonneg_left (min_le_right _ _) hψ0.le)
  have hsr : s < r := by
    have h1 : ψ * (φ - θ₁) ≤ r / 4 * (π / 3) := mul_le_mul hψr (by linarith) ha0.le (by positivity)
    have h2 := mul_le_mul_of_nonneg_left hπ4 hr.le
    linarith
  -- the point's distance from the centre: `2 + s ≤ |p − P|² ≤ (2 + s)²`
  have hz : dist p (P + (1 + s) * e φ) ≤ 1 := mem_closedBall.mp hp1
  have hnear : ‖p - P‖ ≤ 2 + s := by
    have h1 : ‖(P + (1 + s) * e φ) - P‖ = 1 + s := by
      rw [add_sub_cancel_left, norm_mul, norm_e, mul_one]
      rw [show (1 : ℂ) + s = ((1 + s : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
    have := dist_triangle p (P + (1 + s) * e φ) P
    rw [dist_eq_norm p P, dist_eq_norm (P + (1 + s) * e φ) P] at this
    linarith
  have hdisc0 : ∀ α t : ℝ, φ = α + t →
      (frameX P α p - (1 + s) * Real.cos t) ^ 2 + (frameY P α p - (1 + s) * Real.sin t) ^ 2 ≤ 1 := by
    intro α t hα
    have h := sq_dist_frame P α p (P + ((1 + s : ℝ) : ℂ) * e (α + t))
    rw [(frame_polar_add P α (1 + s) t).1, (frame_polar_add P α (1 + s) t).2, ← hα] at h
    push_cast at h
    rw [← h]; nlinarith [dist_nonneg (x := p) (y := P + (1 + s) * e φ)]
  have hunc0 : ∀ α t : ℝ, α + t ∈ Icc θ₁ θ₂ → 2 * (frameX P α p * Real.cos t + frameY P α p * Real.sin t) ≤
      frameX P α p ^ 2 + frameY P α p ^ 2 := by
    intro α t hmem
    have h1 := hp2 (α + t) hmem
    rw [mem_ball, not_lt] at h1
    have h := sq_dist_frame P α p (P + ((1 : ℝ) : ℂ) * e (α + t))
    rw [(frame_polar_add P α 1 t).1, (frame_polar_add P α 1 t).2, Complex.ofReal_one, one_mul] at h
    have h3 : 1 ≤ dist p (ringPt P (α + t)) ^ 2 := by nlinarith
    rw [ringPt, h] at h3
    nlinarith [Real.cos_sq_add_sin_sq t]
  have hnorm : ∀ α, frameX P α p ^ 2 + frameY P α p ^ 2 = ‖p - P‖ ^ 2 := fun α => frame_normSq P α p
  -- in the frame of `φ`: `x ≥ 1 + s/2`, so `|p − P|² ≥ 2 + s`
  have hx : 1 + s / 2 ≤ frameX P φ p := by
    have h1 := hdisc0 φ 0 (by ring)
    have h2 := hunc0 φ 0 (by rw [add_zero]; exact ⟨hφ.1.le, hφ.2.le⟩)
    rw [Real.cos_zero, Real.sin_zero] at h1 h2
    have h1' : frameX P φ p ^ 2 + frameY P φ p ^ 2 ≤ 2 * (1 + s) * frameX P φ p - 2 * s - s ^ 2 := by
      have e : (frameX P φ p - (1 + s) * 1) ^ 2 + (frameY P φ p - (1 + s) * 0) ^ 2 =
          frameX P φ p ^ 2 + frameY P φ p ^ 2 - 2 * (1 + s) * frameX P φ p + (1 + s) ^ 2 := by ring
      rw [e] at h1; linarith
    have h4 : 0 ≤ s * (2 * frameX P φ p - 2 - s) := by linarith
    have := (mul_nonneg_iff_of_pos_left hs).mp h4
    linarith
  have hfar : 2 + s ≤ ‖p - P‖ ^ 2 := by
    have h2 := hunc0 φ 0 (by rw [add_zero]; exact ⟨hφ.1.le, hφ.2.le⟩)
    rw [Real.cos_zero, Real.sin_zero, hnorm] at h2
    linarith
  have hnear2 : ‖p - P‖ ^ 2 ≤ (2 + s) ^ 2 := pow_le_pow_left₀ (norm_nonneg _) hnear 2
  -- the frames at the ends against the frame at `φ`
  obtain ⟨t, ht, hpt⟩ := eq_polar_of_frameX_pos P p φ (by linarith)
  set ρ := ‖p - P‖ with hρ
  have hρnn : 0 ≤ ρ := norm_nonneg _
  have hρ0 : 0 < ρ := by
    rcases eq_or_lt_of_le hρnn with h | h
    · rw [← h] at hfar; nlinarith
    · exact h
  have hY2 : frameY P θ₂ p = ρ * Real.sin (t - (θ₂ - φ)) := by
    have := (frame_polar_add P θ₂ ρ (t - (θ₂ - φ))).2
    rwa [show θ₂ + (t - (θ₂ - φ)) = φ + t by ring, ← hpt] at this
  have hX2 : frameX P θ₂ p = ρ * Real.cos (t - (θ₂ - φ)) := by
    have := (frame_polar_add P θ₂ ρ (t - (θ₂ - φ))).1
    rwa [show θ₂ + (t - (θ₂ - φ)) = φ + t by ring, ← hpt] at this
  have hY1 : frameY P θ₁ p = ρ * Real.sin (t + (φ - θ₁)) := by
    have := (frame_polar_add P θ₁ ρ (t + (φ - θ₁))).2
    rwa [show θ₁ + (t + (φ - θ₁)) = φ + t by ring, ← hpt] at this
  have hX1 : frameX P θ₁ p = ρ * Real.cos (t + (φ - θ₁)) := by
    have := (frame_polar_add P θ₁ ρ (t + (φ - θ₁))).1
    rwa [show θ₁ + (t + (φ - θ₁)) = φ + t by ring, ← hpt] at this
  rw [Metric.mem_thickening_iff]
  by_cases hb : θ₂ - φ < t
  · -- beyond `θ₂`: within `√12 ψ` of `P + 2 e θ₂`
    refine ⟨P + 2 * e θ₂, ⟨θ₂, ⟨h12.le, le_refl _⟩, rfl⟩, ?_⟩
    have hYp : 0 < frameY P θ₂ p := by
      rw [hY2]; exact mul_pos hρ0 (Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [ht.2]))
    have hXp : 0 < frameX P θ₂ p := by
      rw [hX2]; exact mul_pos hρ0 (Real.cos_pos_of_mem_Ioo ⟨by linarith [ht.1], by linarith [ht.2]⟩)
    have hd := hdisc0 θ₂ (-(θ₂ - φ)) (by ring)
    rw [Real.cos_neg, Real.sin_neg, show frameY P θ₂ p - (1 + s) * -Real.sin (θ₂ - φ) =
      frameY P θ₂ p + (1 + s) * Real.sin (θ₂ - φ) by ring] at hd
    have hu := hunc0 θ₂ 0 (by rw [add_zero]; exact ⟨h12.le, le_refl _⟩)
    rw [Real.cos_zero, Real.sin_zero, mul_one, mul_zero, add_zero] at hu
    have hdd := sq_dist_frame P θ₂ p (P + ((2 : ℝ) : ℂ) * e (θ₂ + 0))
    rw [(frame_polar_add P θ₂ 2 0).1, (frame_polar_add P θ₂ 2 0).2, Real.cos_zero, Real.sin_zero, add_zero, mul_one,
      mul_zero, sub_zero] at hdd
    push_cast at hdd
    exact n2_env_away_end hb0 (by linarith) hs hsb hψ2 hψ0 hψr hr hXp hYp hd hu (by rw [hnorm]; exact hfar)
      (by rw [hnorm]; exact hnear2) hdd
  by_cases ha : t < -(φ - θ₁)
  · -- beyond `θ₁`: within `√12 ψ` of `P + 2 e θ₁`
    refine ⟨P + 2 * e θ₁, ⟨θ₁, ⟨le_refl _, h12.le⟩, rfl⟩, ?_⟩
    have hYp : 0 < -frameY P θ₁ p := by
      rw [hY1, ← mul_neg, ← Real.sin_neg]
      exact mul_pos hρ0 (Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [ht.1]))
    have hXp : 0 < frameX P θ₁ p := by
      rw [hX1]; exact mul_pos hρ0 (Real.cos_pos_of_mem_Ioo ⟨by linarith [ht.1], by linarith [ht.2]⟩)
    have hd := hdisc0 θ₁ (φ - θ₁) (by ring)
    rw [show (frameY P θ₁ p - (1 + s) * Real.sin (φ - θ₁)) ^ 2 = (-frameY P θ₁ p + (1 + s) * Real.sin (φ - θ₁)) ^ 2 by
      ring] at hd
    have hu := hunc0 θ₁ 0 (by rw [add_zero]; exact ⟨le_refl _, h12.le⟩)
    rw [Real.cos_zero, Real.sin_zero, mul_one, mul_zero, add_zero, ← neg_sq (frameY P θ₁ p)] at hu
    have hdd := sq_dist_frame P θ₁ p (P + ((2 : ℝ) : ℂ) * e (θ₁ + 0))
    rw [(frame_polar_add P θ₁ 2 0).1, (frame_polar_add P θ₁ 2 0).2, Real.cos_zero, Real.sin_zero, add_zero, mul_one,
      mul_zero, sub_zero, ← neg_sq (frameY P θ₁ p)] at hdd
    push_cast at hdd
    exact n2_env_away_end ha0 (by linarith) hs hsa hψ2 hψ0 hψr hr hXp hYp hd hu (by rw [neg_sq, hnorm]; exact hfar)
      (by rw [neg_sq, hnorm]; exact hnear2) hdd
  · -- within the arc's directions: `2 ≤ ρ ≤ 2 + s`, within `s` of `P + 2 e(φ + t)`
    push Not at hb ha
    have hmem : φ + t ∈ Icc θ₁ θ₂ := ⟨by linarith, by linarith⟩
    refine ⟨P + 2 * e (φ + t), ⟨φ + t, hmem, rfl⟩, ?_⟩
    have hu := hp2 (φ + t) hmem
    rw [mem_ball, not_lt, ringPt, hpt, dist_eq_norm, show P + (ρ : ℂ) * e (φ + t) - (P + e (φ + t)) =
      ((ρ - 1 : ℝ) : ℂ) * e (φ + t) by push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs] at hu
    have hρ2 : 2 ≤ ρ := by
      rcases le_total 0 (ρ - 1) with h | h
      · rw [abs_of_nonneg h] at hu; linarith
      · rw [abs_of_nonpos h] at hu; linarith
    rw [hpt, dist_eq_norm, show P + (ρ : ℂ) * e (φ + t) - (P + 2 * e (φ + t)) = ((ρ - 2 : ℝ) : ℂ) * e (φ + t) by
      push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by linarith)]
    linarith

/-- **FS112-N2-BENDS**, N2-ENV's near clause, toward: for a small enough profile, every point of the lens `B̄(A, 1) ∩ B̄(B, 1)` of the
arc's ends is within `< 1` of every toward lens point. -/
theorem n2_env_near (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1, dist p (P + (1 - s) * e φ) < 1 := by
  have hπ := Real.pi_pos
  have hℓ0 : 0 < θ₂ - θ₁ := by linarith
  have hcos0 : 0 ≤ Real.cos ((θ₂ - θ₁) / 2) := Real.cos_nonneg_of_mem_Icc ⟨by linarith, by linarith⟩
  have hc : 0 < 1 - Real.cos ((θ₂ - θ₁) / 2) := by
    have : Real.cos ((θ₂ - θ₁) / 2) < Real.cos 0 :=
      Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) (by linarith) (by linarith)
    rw [Real.cos_zero] at this; linarith
  refine ⟨(1 - Real.cos ((θ₂ - θ₁) / 2)) / π, div_pos hc hπ, fun φ hφ s hs hsψ p hp => ?_⟩
  obtain ⟨hgap, hSD⟩ := n2_env_data P hℓ hφ hp
  have ha0 : 0 < φ - θ₁ := by linarith [hφ.1]
  have hb0 : 0 < θ₂ - φ := by linarith [hφ.2]
  have hmin0 : 0 < min (φ - θ₁) (θ₂ - φ) := lt_min ha0 hb0
  have hmin_le : min (φ - θ₁) (θ₂ - φ) ≤ π / 6 := by
    rcases le_total (φ - θ₁) (θ₂ - φ) with h | h <;> simp [h] <;> linarith
  have hs1 : s < 1 := by
    have h1 : (1 - Real.cos ((θ₂ - θ₁) / 2)) / π ≤ 1 / π := div_le_div_of_nonneg_right (by linarith) hπ.le
    have h2 : (1 - Real.cos ((θ₂ - θ₁) / 2)) / π * min (φ - θ₁) (θ₂ - φ) ≤ 1 / π * (π / 6) :=
      mul_le_mul h1 hmin_le hmin0.le (by positivity)
    have h3 : 1 / π * (π / 6) = 1 / 6 := by field_simp
    linarith
  have hsa := Real.sin_le_one (φ - θ₁)
  have hsb := Real.sin_le_one (θ₂ - φ)
  have hsℓ : 0 < Real.sin (θ₂ - θ₁) := Real.sin_pos_of_pos_of_lt_pi hℓ0 (by linarith)
  have hK : Real.sin (θ₂ - θ₁) ≤ (1 - s) * (Real.sin (φ - θ₁) + Real.sin (θ₂ - φ)) := by
    have h2 : 2 * s ≤ 2 / π * min (φ - θ₁) (θ₂ - φ) * (1 - Real.cos ((θ₂ - θ₁) / 2)) := by
      have : 2 / π * min (φ - θ₁) (θ₂ - φ) * (1 - Real.cos ((θ₂ - θ₁) / 2)) =
          2 * ((1 - Real.cos ((θ₂ - θ₁) / 2)) / π * min (φ - θ₁) (θ₂ - φ)) := by ring
      linarith
    nlinarith
  have hcore := n2_env_near_core hsℓ (sq_nonneg _) hSD hK hs hs1
  rw [← sq_norm_sub_ofReal_mul_e] at hcore
  have heq : p - (P + (1 - s) * e φ) = (p - P) - ((1 - s : ℝ) : ℂ) * e φ := by push_cast; ring
  rw [dist_eq_norm, heq]
  nlinarith [norm_nonneg ((p - P) - ((1 - s : ℝ) : ℂ) * e φ)]

/-- **FS112-N2-BENDS**, N2-ENV's near clause, away: the same for the away lens off `B(P, r)`. -/
theorem n2_env_near_away (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1 := by
  have hπ := Real.pi_pos
  have hℓ0 : 0 < θ₂ - θ₁ := by linarith
  set c := (1 - Real.cos ((θ₂ - θ₁) / 2)) / π with hcdef
  have hc : 0 < c := by
    have : Real.cos ((θ₂ - θ₁) / 2) < Real.cos 0 :=
      Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) (by linarith) (by linarith)
    rw [Real.cos_zero] at this; exact div_pos (by linarith) hπ
  refine ⟨min 1 (c * r ^ 2) / 3, by positivity, fun φ hφ s hs hsψ p hp => ?_⟩
  obtain ⟨hpL, hpr⟩ := hp
  obtain ⟨hgap, hSD⟩ := n2_env_data P hℓ hφ hpL
  have ha0 : 0 < φ - θ₁ := by linarith [hφ.1]
  have hb0 : 0 < θ₂ - φ := by linarith [hφ.2]
  have hmin0 : 0 < min (φ - θ₁) (θ₂ - φ) := lt_min ha0 hb0
  have hmin_le : min (φ - θ₁) (θ₂ - φ) ≤ π / 6 := by
    rcases le_total (φ - θ₁) (θ₂ - φ) with h | h <;> simp [h] <;> linarith
  have hs1 : s ≤ 1 := by
    have h1 : min 1 (c * r ^ 2) / 3 * min (φ - θ₁) (θ₂ - φ) ≤ 1 / 3 * (π / 6) :=
      mul_le_mul (by linarith [min_le_left 1 (c * r ^ 2)]) hmin_le hmin0.le (by norm_num)
    linarith [Real.pi_le_four]
  have h3s : 3 * s ≤ c * r ^ 2 * min (φ - θ₁) (θ₂ - φ) := by
    have := mul_le_mul_of_nonneg_right (min_le_right 1 (c * r ^ 2)) hmin0.le
    linarith
  have hgap' : 2 * c * min (φ - θ₁) (θ₂ - φ) ≤
      Real.sin (φ - θ₁) + Real.sin (θ₂ - φ) - Real.sin (θ₂ - θ₁) := by
    have : 2 / π * min (φ - θ₁) (θ₂ - φ) * (1 - Real.cos ((θ₂ - θ₁) / 2)) = 2 * c * min (φ - θ₁) (θ₂ - φ) := by
      rw [hcdef]; field_simp
    linarith
  have hsℓ : 0 < Real.sin (θ₂ - θ₁) := Real.sin_pos_of_pos_of_lt_pi hℓ0 (by linarith)
  have hqr : r ^ 2 ≤ ‖p - P‖ ^ 2 := by
    rw [mem_ball, not_lt, dist_eq_norm] at hpr; exact pow_le_pow_left₀ hr.le hpr 2
  have hcore := n2_env_near_away_core hsℓ (Real.sin_le_one _) hSD hgap' hs h3s hs1 hc hmin0 hr hqr
  rw [← sq_norm_sub_ofReal_mul_e] at hcore
  have heq : p - (P + (1 + s) * e φ) = (p - P) - ((1 + s : ℝ) : ℂ) * e φ := by push_cast; ring
  rw [dist_eq_norm, heq]
  nlinarith [norm_nonneg ((p - P) - ((1 + s : ℝ) : ℂ) * e φ)]

end ArcMap

/-! ## The bends' geometry: polar form about a direction, the lens profile, arcs cut by a half-plane -/

/-- `cos a − cos h ≤ h − a` for `0 ≤ a ≤ h ≤ π`. -/
theorem cos_sub_cos_le_sub {a h : ℝ} (ha : 0 ≤ a) (hah : a ≤ h) (hh : h ≤ π) : Real.cos a - Real.cos h ≤ h - a := by
  rw [Real.cos_sub_cos]
  have h1 : Real.sin ((a - h) / 2) = - Real.sin ((h - a) / 2) := by rw [← Real.sin_neg]; ring_nf
  rw [h1]
  have h2 : Real.sin ((h - a) / 2) ≤ (h - a) / 2 := Real.sin_le (by linarith)
  have h3 : 0 ≤ Real.sin ((h - a) / 2) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith)
  have h4 : Real.sin ((a + h) / 2) ≤ 1 := Real.sin_le_one _
  nlinarith

/-- A cosine at least `cos h`, `0 ≤ h ≤ π`, puts an angle of `(−π, π]` within `h` of `0`. -/
theorem abs_le_of_cos_le {a h : ℝ} (ha : |a| ≤ π) (hh : 0 ≤ h) (hc : Real.cos h ≤ Real.cos a) : |a| ≤ h := by
  by_contra hlt
  push Not at hlt
  have := Real.cos_lt_cos_of_nonneg_of_le_pi hh ha hlt
  rw [Real.cos_abs] at this
  linarith

/-- The strict form. -/
theorem abs_lt_of_cos_lt {a h : ℝ} (ha : |a| ≤ π) (hh : 0 ≤ h) (hc : Real.cos h < Real.cos a) : |a| < h := by
  by_contra hle
  push Not at hle
  have := Real.cos_le_cos_of_nonneg_of_le_pi hh ha hle
  rw [Real.cos_abs] at this
  linarith

/-- **The toward lens profile in polar form**: a point `w`, `‖w‖ ≤ 1`, with `1 − ‖w‖² ≤ 2d(Re w − cos h)` has `|arg w| ≤ h` and radial
depth `1 − ‖w‖ ≤ 2d(h − |arg w|)`. -/
theorem polar_toward {d h : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ} (hw1 : ‖w‖ ≤ 1)
    (hK : 1 - ‖w‖ ^ 2 ≤ 2 * d * (w.re - Real.cos h)) :
    0 < w.re ∧ |arg w| ≤ h ∧ 1 - ‖w‖ ≤ 2 * d * (h - |arg w|) := by
  have hcos : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hn0 := norm_nonneg w
  have hre : Real.cos h ≤ w.re := by
    by_contra hlt; push Not at hlt; nlinarith
  have hre0 : 0 < w.re := hcos.trans_le hre
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : w.re ≤ Real.cos (arg w) := by rw [hca, le_div_iff₀ hnpos]; nlinarith
  have habs := abs_le_of_cos_le (Complex.abs_arg_le_pi w) hh.le (hre.trans hge)
  refine ⟨hre0, habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  have hre' : w.re = ‖w‖ * Real.cos (arg w) := by rw [hca]; field_simp
  have : w.re ≤ Real.cos (arg w) := hge
  nlinarith

/-- The strict form: strictly inside the angle, strictly thinner than the profile. -/
theorem polar_toward_strict {d h : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ} (hw1 : ‖w‖ ≤ 1)
    (hK : 1 - ‖w‖ ^ 2 < 2 * d * (w.re - Real.cos h)) : |arg w| < h ∧ 1 - ‖w‖ < 2 * d * (h - |arg w|) := by
  obtain ⟨hre0, -, -⟩ := polar_toward hd hh hh2 hw1 hK.le
  have hn0 := norm_nonneg w
  have hre : Real.cos h < w.re := by
    by_contra hle; push Not at hle; nlinarith
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : w.re ≤ Real.cos (arg w) := by rw [hca, le_div_iff₀ hnpos]; nlinarith
  have habs := abs_lt_of_cos_lt (Complex.abs_arg_le_pi w) hh.le (hre.trans_le hge)
  refine ⟨habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs.le (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  nlinarith

/-- **The away lens profile in polar form**: a point `w`, `‖w‖ ≥ 1`, with `‖w‖² − 1 ≤ 2d(Re w − cos h)`, `d ≤ 1/2`, has
`|arg w| ≤ h` and radial height `‖w‖ − 1 ≤ 2d(h − |arg w|)`. -/
theorem polar_away {d h : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ} (hw1 : 1 ≤ ‖w‖)
    (hK : ‖w‖ ^ 2 - 1 ≤ 2 * d * (w.re - Real.cos h)) :
    0 < w.re ∧ |arg w| ≤ h ∧ ‖w‖ - 1 ≤ 2 * d * (h - |arg w|) := by
  have hcos : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hcos1 : Real.cos h ≤ 1 := Real.cos_le_one h
  have hre : ‖w‖ * Real.cos h ≤ w.re := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hw1) (show 0 ≤ ‖w‖ + 1 - 2 * d * Real.cos h by nlinarith)]
  have hre0 : 0 < w.re := lt_of_lt_of_le (by positivity) hre
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : Real.cos h ≤ Real.cos (arg w) := by rw [hca, le_div_iff₀ hnpos]; linarith
  have habs := abs_le_of_cos_le (Complex.abs_arg_le_pi w) hh.le hge
  refine ⟨hre0, habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  have hre' : w.re = ‖w‖ * Real.cos (arg w) := by rw [hca]; field_simp
  have hc1 : Real.cos (arg w) ≤ 1 := Real.cos_le_one _
  have hm1 : d * (Real.cos (arg w) - Real.cos h) ≤ d * (h - |arg w|) := mul_le_mul_of_nonneg_left hsub hd.le
  have hm2 : d * (‖w‖ - 1) * Real.cos (arg w) ≤ d * (‖w‖ - 1) :=
    mul_le_of_le_one_right (mul_nonneg hd.le (by linarith)) hc1
  have hstep : (‖w‖ - 1) * (2 - 2 * d) ≤ 2 * d * (h - |arg w|) := by nlinarith
  have hΔ : 0 ≤ h - |arg w| := by linarith
  nlinarith

/-- The strict form of `polar_away`. -/
theorem polar_away_strict {d h : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2) {w : ℂ}
    (hw1 : 1 ≤ ‖w‖) (hK : ‖w‖ ^ 2 - 1 < 2 * d * (w.re - Real.cos h)) :
    |arg w| < h ∧ ‖w‖ - 1 < 2 * d * (h - |arg w|) := by
  obtain ⟨hre0, -, -⟩ := polar_away hd hd2 hh hh2 hw1 hK.le
  have hcos : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hre : ‖w‖ * Real.cos h < w.re := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hw1) (show 0 ≤ ‖w‖ + 1 - 2 * d * Real.cos h by nlinarith [Real.cos_le_one h])]
  have hw0 : w ≠ 0 := fun h0 => by rw [h0, Complex.zero_re] at hre0; exact lt_irrefl _ hre0
  have hnpos : 0 < ‖w‖ := norm_pos_iff.mpr hw0
  have hca : Real.cos (arg w) = w.re / ‖w‖ := Complex.cos_arg hw0
  have hge : Real.cos h < Real.cos (arg w) := by rw [hca, lt_div_iff₀ hnpos]; linarith
  have habs := abs_lt_of_cos_lt (Complex.abs_arg_le_pi w) hh.le hge
  refine ⟨habs, ?_⟩
  have hsub := cos_sub_cos_le_sub (abs_nonneg (arg w)) habs.le (by linarith [Real.pi_pos])
  rw [Real.cos_abs] at hsub
  have hre' : w.re = ‖w‖ * Real.cos (arg w) := by rw [hca]; field_simp
  have hc1 : Real.cos (arg w) ≤ 1 := Real.cos_le_one _
  have hm1 : d * (Real.cos (arg w) - Real.cos h) ≤ d * (h - |arg w|) := mul_le_mul_of_nonneg_left hsub hd.le
  have hm2 : d * (‖w‖ - 1) * Real.cos (arg w) ≤ d * (‖w‖ - 1) :=
    mul_le_of_le_one_right (mul_nonneg hd.le (by linarith)) hc1
  have hstep : (‖w‖ - 1) * (2 - 2 * d) < 2 * d * (h - |arg w|) := by nlinarith
  nlinarith

/-- **An arc cut from a circle by a half-plane**: for `|τ| ≤ R`, the arc `circ C R (φ − arccos(τ/R)) (φ + arccos(τ/R))` is the set of
points of the circle whose component along `e φ` from the centre is at least `τ`. -/
theorem carrier_circ_arccos {C : ℂ} {R φ τ : ℝ} (hR : 0 < R) (hτ : |τ| ≤ R) :
    (Arc.circ C R (φ - Real.arccos (τ / R)) (φ + Real.arccos (τ / R))).carrier =
      {z | dist z C = R ∧ τ ≤ ((z - C) * starRingEnd ℂ (e φ)).re} := by
  have hτR : -1 ≤ τ / R ∧ τ / R ≤ 1 := by
    rw [abs_le] at hτ
    exact ⟨by rw [le_div_iff₀ hR]; linarith, by rw [div_le_one hR]; linarith⟩
  have hcosγ : Real.cos (Real.arccos (τ / R)) = τ / R := Real.cos_arccos hτR.1 hτR.2
  have hγ0 := Real.arccos_nonneg (τ / R)
  have hγπ := Real.arccos_le_pi (τ / R)
  ext z
  simp only [Arc.carrier, mem_image, mem_setOf_eq]
  constructor
  · rintro ⟨θ, hθ, rfl⟩
    refine ⟨by rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos hR], ?_⟩
    rw [add_sub_cancel_left, mul_assoc, Complex.re_ofReal_mul, ArcMap.re_e_mul_conj_e]
    have habs : |θ - φ| ≤ Real.arccos (τ / R) := abs_le.mpr ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    have hc : Real.cos (Real.arccos (τ / R)) ≤ Real.cos |θ - φ| :=
      Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) hγπ habs
    rw [Real.cos_abs, hcosγ] at hc
    rw [div_le_iff₀ hR] at hc
    linarith
  · rintro ⟨hd, hτq⟩
    set q := (z - C) * starRingEnd ℂ (e φ) with hq
    have hqn : ‖q‖ = R := by rw [hq, norm_mul, RCLike.norm_conj, norm_e, mul_one, ← dist_eq_norm, hd]
    have hq0 : q ≠ 0 := fun h0 => by rw [h0, norm_zero] at hqn; linarith
    have hzq : z = C + q * e φ := by
      rw [hq, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), e_mul_conj_e, mul_one]; ring
    have hca : Real.cos (arg q) = q.re / R := by rw [Complex.cos_arg hq0, hqn]
    have hc : Real.cos (Real.arccos (τ / R)) ≤ Real.cos (arg q) := by
      rw [hcosγ, hca]; exact div_le_div_of_nonneg_right hτq hR.le
    have habs := abs_le_of_cos_le (Complex.abs_arg_le_pi q) hγ0 hc
    refine ⟨φ + arg q, ⟨by linarith [(abs_le.mp habs).1], by linarith [(abs_le.mp habs).2]⟩, ?_⟩
    have hqe : q = (R : ℂ) * e (arg q) := by rw [← hqn]; exact eq_norm_mul_e_arg
    symm
    calc z = C + q * e φ := hzq
      _ = C + (R : ℂ) * e (arg q) * e φ := by rw [← hqe]
      _ = C + R * e (φ + arg q) := by rw [e_add]; ring

/-- The frame along `e φ` at `P`: `w = (z − P) e(φ)‾` has `‖w‖ = |z − P|`. -/
theorem norm_frameDir (P z : ℂ) (φ : ℝ) : ‖(z - P) * starRingEnd ℂ (e φ)‖ = dist z P := by
  rw [norm_mul, RCLike.norm_conj, norm_e, mul_one, dist_eq_norm]

/-- `z = P + |z − P| e(φ + arg w)`, `w = (z − P) e(φ)‾`. -/
theorem eq_polar_frameDir (P z : ℂ) (φ : ℝ) :
    z = P + (dist z P : ℂ) * e (φ + arg ((z - P) * starRingEnd ℂ (e φ))) := by
  set w := (z - P) * starRingEnd ℂ (e φ) with hw
  have hzw : z - P = w * e φ := by rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), e_mul_conj_e, mul_one]
  have h1 : w = (‖w‖ : ℂ) * e (arg w) := eq_norm_mul_e_arg
  rw [← norm_frameDir P z φ, ← hw, e_add]
  calc z = P + w * e φ := by rw [← hzw]; ring
    _ = P + (‖w‖ : ℂ) * e (arg w) * e φ := by rw [← h1]
    _ = _ := by ring

/-- The squared distance to `P − d e(φ)`: `|z − P|² + 2d Re w + d²`. -/
theorem dist_sq_sub_dir (P z : ℂ) (φ d : ℝ) :
    dist z (P - d * e φ) ^ 2 = dist z P ^ 2 + 2 * d * ((z - P) * starRingEnd ℂ (e φ)).re + d ^ 2 := by
  set w := (z - P) * starRingEnd ℂ (e φ) with hw
  have hzw : z - P = w * e φ := by rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), e_mul_conj_e, mul_one]
  have h1 : z - (P - d * e φ) = (w + d) * e φ := by rw [add_mul, ← hzw]; ring
  rw [dist_eq_norm, h1, norm_mul, norm_e, mul_one, ← norm_frameDir P z φ, ← hw, Complex.sq_norm, Complex.sq_norm,
    Complex.normSq_apply, Complex.normSq_apply]
  simp only [Complex.add_re, Complex.ofReal_re, Complex.add_im, Complex.ofReal_im, add_zero]
  ring

/-- The squared distance to `P + d e(φ)`: `|z − P|² − 2d Re w + d²`. -/
theorem dist_sq_add_dir (P z : ℂ) (φ d : ℝ) :
    dist z (P + d * e φ) ^ 2 = dist z P ^ 2 - 2 * d * ((z - P) * starRingEnd ℂ (e φ)).re + d ^ 2 := by
  have := dist_sq_sub_dir P z φ (-d)
  rw [show P - ((-d : ℝ) : ℂ) * e φ = P + d * e φ by push_cast; ring] at this
  rw [this]; ring

/-- For a point `r(θ)` of `ω(P)`, `Re w = cos(θ − φ)`. -/
theorem re_frameDir_ringPt (P : ℂ) (θ φ : ℝ) : ((ringPt P θ - P) * starRingEnd ℂ (e φ)).re = Real.cos (θ - φ) := by
  rw [ringPt, add_sub_cancel_left, ArcMap.re_e_mul_conj_e]

/-- `min (h + a) (h − a) = h − |a|`. -/
theorem min_add_sub_eq (h a : ℝ) : min (h + a) (h - a) = h - |a| := by
  rcases le_total 0 a with ha | ha
  · rw [abs_of_nonneg ha, min_eq_right (by linarith)]
  · rw [abs_of_nonpos ha, min_eq_left (by linarith)]; ring

/-- The distance from `P + ρ e(φ)` to `r(φ)` is `|1 − ρ|`. -/
theorem dist_polar_ringPt (P : ℂ) (ρ φ : ℝ) : dist (P + (ρ : ℂ) * e φ) (ringPt P φ) = |1 - ρ| := by
  rw [dist_eq_norm, ringPt, show P + (ρ : ℂ) * e φ - (P + e φ) = ((ρ - 1 : ℝ) : ℂ) * e φ by push_cast; ring, norm_mul, norm_e,
    mul_one, Complex.norm_real, Real.norm_eq_abs, abs_sub_comm]

/-- An inequality on the open interval passes to the closed one (by continuity). -/
theorem le_on_Icc_of_Ioo {f : ℝ → ℝ} (hf : Continuous f) {a b c : ℝ} (hab : a < b) (h : ∀ θ ∈ Ioo a b, f θ ≤ c) :
    ∀ θ ∈ Icc a b, f θ ≤ c := by
  have : Icc a b ⊆ {θ | f θ ≤ c} := by
    rw [← closure_Ioo hab.ne]; exact closure_minimal h (isClosed_le hf continuous_const)
  exact fun θ hθ => this hθ

/-- The same, from below. -/
theorem ge_on_Icc_of_Ioo {f : ℝ → ℝ} (hf : Continuous f) {a b c : ℝ} (hab : a < b) (h : ∀ θ ∈ Ioo a b, c ≤ f θ) :
    ∀ θ ∈ Icc a b, c ≤ f θ := by
  have : Icc a b ⊆ {θ | c ≤ f θ} := by
    rw [← closure_Ioo hab.ne]; exact closure_minimal h (isClosed_le continuous_const hf)
  exact fun θ hθ => this hθ

/-- **The toward lens in polar form**: a point of `B̄(P, 1)` outside or on the circle about `P − d e(φ)` of squared radius
`1 + 2d cos h + d²` is `P + |z − P| e(φ + a)`, `a = arg w`, with `|a| ≤ h` and depth `1 − |z − P| ≤ 2d(h − |a|)`. -/
theorem toward_polar {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) (hz1 : dist z P ≤ 1)
    (hzC : 1 + 2 * d * Real.cos h + d ^ 2 ≤ dist z (P - d * e φ) ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h ∧
      1 - dist z P ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : 1 - ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 ≤ 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_sub_dir] at hzC; linarith
  obtain ⟨-, h1, h2⟩ := polar_toward hd hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h2
  exact ⟨h1, h2⟩

/-- The strict form: strictly outside the circle, strictly inside the angle and the profile. -/
theorem toward_polar_strict {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hh : 0 < h) (hh2 : h < π / 2) (hz1 : dist z P ≤ 1)
    (hzC : 1 + 2 * d * Real.cos h + d ^ 2 < dist z (P - d * e φ) ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| < h ∧
      1 - dist z P < 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : 1 - ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 < 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_sub_dir] at hzC; linarith
  have h := polar_toward_strict hd hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h
  exact h

/-- The squared distance between two points in polar form about `P`. -/
theorem dist_polar_polar_sq (P : ℂ) (ρ ρ' b b' : ℝ) :
    dist (P + (ρ : ℂ) * e b) (P + (ρ' : ℂ) * e b') ^ 2 = ρ ^ 2 + ρ' ^ 2 - 2 * ρ * ρ' * Real.cos (b - b') := by
  rw [dist_eq_norm, add_sub_add_left_eq_sub, Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im, Complex.re_ofReal_mul, Complex.im_ofReal_mul, re_e, im_e]
  rw [Real.cos_sub]
  nlinarith [Real.cos_sq_add_sin_sq b, Real.cos_sq_add_sin_sq b']

/-- **Two points of the toward lens are never at distance `1`** (half-length `h ≤ 30°`): in polar form both lie within `h` of the
middle direction and within the unit disc, so `|z − z'|² < ρ² + ρ'² − ρρ' ≤ 1`. -/
theorem toward_pairs {P z z' : ℂ} {φ h d : ℝ} (hd : 0 < d) (hh : 0 < h) (hh6 : h ≤ π / 6)
    (hz1 : dist z P ≤ 1) (hzC : 1 + 2 * d * Real.cos h + d ^ 2 < dist z (P - d * e φ) ^ 2)
    (hz1' : dist z' P ≤ 1) (hzC' : 1 + 2 * d * Real.cos h + d ^ 2 < dist z' (P - d * e φ) ^ 2) : dist z z' ≠ 1 := by
  have hπ := Real.pi_pos
  have hh2 : h < π / 2 := by linarith
  set a := arg ((z - P) * starRingEnd ℂ (e φ))
  set a' := arg ((z' - P) * starRingEnd ℂ (e φ))
  obtain ⟨ha, -⟩ := toward_polar_strict hd hh hh2 hz1 hzC
  obtain ⟨ha', -⟩ := toward_polar_strict hd hh hh2 hz1' hzC'
  -- the radii are positive: the lens misses `P`
  have hcosh : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  have hoff : ∀ x : ℂ, 1 + 2 * d * Real.cos h + d ^ 2 < dist x (P - d * e φ) ^ 2 → 0 < dist x P := by
    intro x hx
    by_contra h0; push Not at h0
    have hxP : x = P := dist_le_zero.mp h0
    rw [hxP, dist_eq_norm, show P - (P - (d : ℂ) * e φ) = (d : ℂ) * e φ by ring, norm_mul, norm_e, mul_one,
      Complex.norm_real, Real.norm_eq_abs, sq_abs] at hx
    nlinarith
  have hρ := hoff z hzC
  have hρ' := hoff z' hzC'
  have hcos : 1 / 2 < Real.cos (a - a') := by
    have h1 : |a - a'| < π / 3 := by
      have := abs_sub (a) (a'); linarith [abs_sub_le_iff.mp (le_refl |a - a'|)]
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg (a - a')) (by linarith) h1
    rw [Real.cos_abs, Real.cos_pi_div_three] at this
    exact this
  have hsq : dist z z' ^ 2 = dist z P ^ 2 + dist z' P ^ 2 - 2 * dist z P * dist z' P * Real.cos (a - a') := by
    have hz := eq_polar_frameDir P z φ
    have hz' := eq_polar_frameDir P z' φ
    have : dist z z' = dist (P + (dist z P : ℂ) * e (φ + a)) (P + (dist z' P : ℂ) * e (φ + a')) := by
      rw [← hz, ← hz']
    rw [this, dist_polar_polar_sq, show φ + a - (φ + a') = a - a' by ring]
  intro h1
  have : dist z P ^ 2 + dist z' P ^ 2 - 2 * dist z P * dist z' P * Real.cos (a - a') < 1 := by
    nlinarith [mul_pos hρ hρ', mul_nonneg (sub_nonneg.mpr hz1) (show 0 ≤ dist z P + 1 - dist z' P by linarith),
      mul_nonneg hρ'.le (sub_nonneg.mpr hz1')]
  rw [← hsq, h1] at this
  norm_num at this

/-- The component of `z − (P − d e(φ))` along `e φ` is `Re w + d`. -/
theorem re_frameDir_sub_dir (P z : ℂ) (φ d : ℝ) :
    ((z - (P - d * e φ)) * starRingEnd ℂ (e φ)).re = ((z - P) * starRingEnd ℂ (e φ)).re + d := by
  rw [show z - (P - d * e φ) = (z - P) + d * e φ by ring, add_mul, mul_assoc, e_mul_conj_e, mul_one, Complex.add_re,
    Complex.ofReal_re]

/-- **The toward bend's new arc**: the arc of the circle about `P − d e(φ)` of squared radius `1 + 2d cos h + d²` cut by the
half-plane `Re((z − C) e(φ)‾) ≥ d + cos h` is exactly that circle's part in `B̄(P, 1)`. -/
theorem toward_carrier (P : ℂ) {φ h d : ℝ} (hd : 0 < d) (hcos : 0 < Real.cos h) :
    (Arc.circ (P - d * e φ) √(1 + 2 * d * Real.cos h + d ^ 2)
      (φ - Real.arccos ((d + Real.cos h) / √(1 + 2 * d * Real.cos h + d ^ 2)))
      (φ + Real.arccos ((d + Real.cos h) / √(1 + 2 * d * Real.cos h + d ^ 2)))).carrier =
      {z | dist z (P - d * e φ) = √(1 + 2 * d * Real.cos h + d ^ 2) ∧ dist z P ≤ 1} := by
  have hpos : 0 < 1 + 2 * d * Real.cos h + d ^ 2 := by positivity
  set R := √(1 + 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 + 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt hpos.le
  have hR : 0 < R := Real.sqrt_pos.2 hpos
  have hτ : |d + Real.cos h| ≤ R := by
    rw [abs_of_pos (by positivity)]
    refine Real.le_sqrt_of_sq_le ?_
    nlinarith [Real.cos_sq_le_one h]
  rw [carrier_circ_arccos hR hτ]
  ext z
  simp only [mem_setOf_eq, re_frameDir_sub_dir]
  have hd2 := dist_sq_sub_dir P z φ d
  constructor <;> rintro ⟨hzc, h2⟩ <;> refine ⟨hzc, ?_⟩
  · rw [hzc, hRsq] at hd2
    have : dist z P ^ 2 ≤ 1 := by nlinarith
    nlinarith [dist_nonneg (x := z) (y := P)]
  · rw [hzc, hRsq] at hd2
    have : dist z P ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := z) (y := P)]
    nlinarith

/-- The component of `z − (P + d e(φ))` along `e φ` is `Re w − d`. -/
theorem re_frameDir_add_dir (P z : ℂ) (φ d : ℝ) :
    ((z - (P + d * e φ)) * starRingEnd ℂ (e φ)).re = ((z - P) * starRingEnd ℂ (e φ)).re - d := by
  have := re_frameDir_sub_dir P z φ (-d)
  rw [show P - ((-d : ℝ) : ℂ) * e φ = P + d * e φ by push_cast; ring] at this
  rw [this]; ring

/-- **The away lens in polar form**: a point outside `B(P, 1)` inside or on the circle about `P + d e(φ)` of squared radius
`1 − 2d cos h + d²` (`d ≤ 1/2`) is `P + |z − P| e(φ + a)` with `|a| ≤ h` and height `|z − P| − 1 ≤ 2d(h − |a|)`. -/
theorem away_polar {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2)
    (hz1 : 1 ≤ dist z P) (hzC : dist z (P + d * e φ) ^ 2 ≤ 1 - 2 * d * Real.cos h + d ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h ∧
      dist z P - 1 ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 - 1 ≤ 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_add_dir] at hzC; linarith
  obtain ⟨-, h1, h2⟩ := polar_away hd hd2 hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h2
  exact ⟨h1, h2⟩

/-- The strict form of `away_polar`. -/
theorem away_polar_strict {P z : ℂ} {φ h d : ℝ} (hd : 0 < d) (hd2 : d ≤ 1 / 2) (hh : 0 < h) (hh2 : h < π / 2)
    (hz1 : 1 ≤ dist z P) (hzC : dist z (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2) :
    |arg ((z - P) * starRingEnd ℂ (e φ))| < h ∧
      dist z P - 1 < 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) := by
  have hK : ‖(z - P) * starRingEnd ℂ (e φ)‖ ^ 2 - 1 < 2 * d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by
    rw [norm_frameDir]; rw [dist_sq_add_dir] at hzC; linarith
  have h := polar_away_strict hd hd2 hh hh2 (by rw [norm_frameDir]; exact hz1) hK
  rw [norm_frameDir] at h
  exact h

/-- **The away bend's new arc**: the arc of the circle about `P + d e(φ)` of squared radius `1 − 2d cos h + d²` cut by the
half-plane `Re((z − C) e(φ)‾) ≥ cos h − d` is exactly that circle's part outside `B(P, 1)`. -/
theorem away_carrier (P : ℂ) {φ h d : ℝ} (hd : 0 < d) (hpos : 0 < 1 - 2 * d * Real.cos h + d ^ 2) :
    (Arc.circ (P + d * e φ) √(1 - 2 * d * Real.cos h + d ^ 2)
      (φ - Real.arccos ((Real.cos h - d) / √(1 - 2 * d * Real.cos h + d ^ 2)))
      (φ + Real.arccos ((Real.cos h - d) / √(1 - 2 * d * Real.cos h + d ^ 2)))).carrier =
      {z | dist z (P + d * e φ) = √(1 - 2 * d * Real.cos h + d ^ 2) ∧ 1 ≤ dist z P} := by
  set R := √(1 - 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 - 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt hpos.le
  have hR : 0 < R := Real.sqrt_pos.2 hpos
  have hτ : |Real.cos h - d| ≤ R := by
    refine Real.abs_le_sqrt ?_
    nlinarith [Real.cos_sq_le_one h]
  rw [carrier_circ_arccos hR hτ]
  ext z
  simp only [mem_setOf_eq, re_frameDir_add_dir]
  have hd2 := dist_sq_add_dir P z φ d
  constructor <;> rintro ⟨hzc, h2⟩ <;> refine ⟨hzc, ?_⟩
  · rw [hzc, hRsq] at hd2
    have h3 : 0 ≤ d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := mul_nonneg hd.le (by linarith)
    have : 1 ≤ dist z P ^ 2 := by nlinarith
    nlinarith [dist_nonneg (x := z) (y := P)]
  · rw [hzc, hRsq] at hd2
    have : 1 ≤ dist z P ^ 2 := by nlinarith [dist_nonneg (x := z) (y := P)]
    have h3 : 0 ≤ d * (((z - P) * starRingEnd ℂ (e φ)).re - Real.cos h) := by nlinarith
    have h4 := (mul_nonneg_iff_of_pos_left hd).mp h3
    linarith

/-- `1 + 2dy ≤ 2 cos(π/3 − y)` for `0 ≤ y ≤ π/3`, `d ≤ 1/10`. -/
theorem one_add_le_two_cos {d y : ℝ} (hd1 : d ≤ 1 / 10) (hy : 0 ≤ y) (hy3 : y ≤ π / 3) :
    1 + 2 * d * y ≤ 2 * Real.cos (π / 3 - y) := by
  have hπ := Real.pi_pos
  have hπ4 := Real.pi_lt_d2
  rw [Real.cos_sub, Real.cos_pi_div_three, Real.sin_pi_div_three]
  have hc : 1 - y ^ 2 / 2 ≤ Real.cos y := Real.one_sub_sq_div_two_le_cos
  have hs : 2 / π * y ≤ Real.sin y := Real.mul_le_sin hy (by linarith)
  have hs' : y / 2 ≤ Real.sin y := by
    refine le_trans ?_ hs
    rw [div_mul_eq_mul_div, le_div_iff₀ hπ]; nlinarith
  have h3 : (17 / 10 : ℝ) ≤ √3 := Real.le_sqrt_of_sq_le (by norm_num)
  have hsy : 0 ≤ Real.sin y := le_trans (by linarith) hs'
  nlinarith [mul_le_mul_of_nonneg_right h3 hsy]

/-- **A point of the away lens lies in `B̄(A, 1) ∩ B̄(B, 1)`**: at `P + ρ e(φ + b)`, `|b| < h ≤ 30°`, with height
`ρ − 1 ≤ 2d(h − |b|)`, `d ≤ 1/10`, both ends are within `1`. -/
theorem away_mem_lens {P : ℂ} {φ h d ρ b : ℝ} (hd : 0 ≤ d) (hd1 : d ≤ 1 / 10) (hh6 : h ≤ π / 6) (hb : |b| ≤ h)
    (hρ1 : 1 ≤ ρ) (hρ : ρ - 1 ≤ 2 * d * (h - |b|)) :
    dist (P + (ρ : ℂ) * e (φ + b)) (ringPt P (φ - h)) ≤ 1 ∧ dist (P + (ρ : ℂ) * e (φ + b)) (ringPt P (φ + h)) ≤ 1 := by
  have hπ := Real.pi_pos
  have key : ∀ β' y : ℝ, 0 ≤ y → |φ + b - β'| + y ≤ π / 3 → ρ ≤ 1 + 2 * d * y →
      dist (P + (ρ : ℂ) * e (φ + b)) (ringPt P β') ≤ 1 := by
    intro β' y hy hxy hρy
    have hcx : Real.cos (π / 3 - y) ≤ Real.cos |φ + b - β'| :=
      Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) (by linarith)
    rw [Real.cos_abs] at hcx
    have h2 := one_add_le_two_cos hd1 hy (by linarith [abs_nonneg (φ + b - β')])
    have hr : ringPt P β' = P + ((1 : ℝ) : ℂ) * e β' := by rw [ringPt, Complex.ofReal_one, one_mul]
    rw [hr, ← sq_le_one_iff₀ dist_nonneg, dist_polar_polar_sq]
    nlinarith
  have hab := abs_le.mp hb
  refine ⟨key _ (h - b) (by linarith) ?_ (by nlinarith [le_abs_self b]), key _ (h + b) (by linarith) ?_
    (by nlinarith [neg_abs_le b])⟩
  · rw [show φ + b - (φ - h) = h + b by ring, abs_of_nonneg (by linarith)]; linarith
  · rw [show φ + b - (φ + h) = -(h - b) by ring, abs_neg, abs_of_nonneg (by linarith)]; linarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## Engine 3: the cut of an open sub-arc of a unit circle out of a map's arcs, and the bend -/

section Bend

variable (F)

/-- The lower end of the `m`-th piece of the arc `circ P 1 θa θb` off the open sub-arc `r((θ₁, θ₂))`. -/
noncomputable def cutLo (θ₂ θa : ℝ) (m : ℤ) : ℝ := max θa (θ₂ + m * (2 * π))

/-- The upper end of the `m`-th piece. -/
noncomputable def cutHi (θ₁ θb : ℝ) (m : ℤ) : ℝ := min θb (θ₁ + (m + 1) * (2 * π))

/-- **Engine 3, the cut** (`plans/FS131-w4-kernel-plan.md` § 13.1): the arcs of `F` with the open sub-arc `r((θ₁, θ₂))` of `ω(P)`
removed — every arc that is not an arc `circ P 1 θa θb` of `ω(P)` kept whole, each arc of `ω(P)` replaced by its non-degenerate
pieces over the parameter intervals `[θ₂ + 2πm, θ₁ + 2π(m + 1)]` that miss the sub-arc. -/
def cutArcs (P : ℂ) (θ₁ θ₂ : ℝ) : Set Arc :=
  {a | a ∈ F.arcs ∧ ∀ θa θb, a ≠ .circ P 1 θa θb} ∪
    {b | ∃ θa θb, Arc.circ P 1 θa θb ∈ F.arcs ∧ ∃ m : ℤ, cutLo θ₂ θa m < cutHi θ₁ θb m ∧
      b = .circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)}

/-- The carrier of an arc of `ω(P)`: its points are `r(t)`. -/
theorem carrier_circ_one (P : ℂ) (θa θb : ℝ) : (Arc.circ P 1 θa θb).carrier = ringPt P '' Icc θa θb := by
  ext z
  simp only [Arc.carrier, mem_image, ringPt, Complex.ofReal_one, one_mul]

/-- The pieces of the cut are non-degenerate arcs. -/
theorem cutArcs_nondegenerate {P : ℂ} {θ₁ θ₂ : ℝ} : ∀ b ∈ F.cutArcs P θ₁ θ₂, b.Nondegenerate := by
  rintro b (⟨hb, -⟩ | ⟨θa, θb, ha, m, hlt, rfl⟩)
  · exact F.nondegenerate b hb
  · obtain ⟨-, h1, h2⟩ := F.nondegenerate _ ha
    refine ⟨one_pos, hlt, ?_⟩
    have := le_max_left θa (θ₂ + m * (2 * π))
    have := min_le_left θb (θ₁ + (m + 1) * (2 * π))
    simp only [cutLo, cutHi] at *
    linarith

/-- Each arc of the cut lies in an arc of `F`. -/
theorem cutArcs_subset {P : ℂ} {θ₁ θ₂ : ℝ} :
    ∀ b ∈ F.cutArcs P θ₁ θ₂, ∃ a ∈ F.arcs, b.carrier ⊆ a.carrier := by
  rintro b (⟨hb, -⟩ | ⟨θa, θb, ha, m, hlt, rfl⟩)
  · exact ⟨b, hb, subset_rfl⟩
  · refine ⟨_, ha, ?_⟩
    rw [carrier_circ_one, carrier_circ_one]
    exact image_mono (Icc_subset_Icc (le_max_left _ _) (min_le_left _ _))

/-- An arc of `ω(P)` has finitely many pieces. -/
theorem finite_cut_pieces (θ₁ θ₂ θa θb : ℝ) :
    {m : ℤ | cutLo θ₂ θa m < cutHi θ₁ θb m}.Finite := by
  have hπ := Real.pi_pos
  refine (Set.finite_Icc (⌊(θa - θ₁) / (2 * π)⌋ - 1) ⌈(θb - θ₂) / (2 * π)⌉).subset ?_
  intro m hm
  simp only [mem_setOf_eq, cutLo, cutHi, lt_min_iff, max_lt_iff] at hm
  obtain ⟨⟨-, h1⟩, h2, -⟩ := hm
  constructor
  · have : (θa - θ₁) / (2 * π) < (m : ℝ) + 1 := by
      rw [div_lt_iff₀ (by positivity)]; linarith
    have h3 : ⌊(θa - θ₁) / (2 * π)⌋ < m + 1 := by
      rw [Int.floor_lt]; push_cast; exact this
    omega
  · have : (m : ℝ) < (θb - θ₂) / (2 * π) := by
      rw [lt_div_iff₀ (by positivity)]; linarith
    exact_mod_cast this.le.trans (Int.le_ceil _)

/-- The cut's arcs are locally finite on the domain. -/
theorem cutArcs_locallyFinite {P : ℂ} {θ₁ θ₂ : ℝ} :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {b | b ∈ F.cutArcs P θ₁ θ₂ ∧ (b.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  refine ⟨t, ht, ?_⟩
  set S := {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}
  have hpieces : ∀ θa θb : ℝ, {b | ∃ m : ℤ, cutLo θ₂ θa m < cutHi θ₁ θb m ∧
      b = Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)}.Finite := fun θa θb =>
    ((finite_cut_pieces θ₁ θ₂ θa θb).image fun m => Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)).subset
      fun b ⟨m, hm, hb⟩ => ⟨m, hm, hb.symm⟩
  set pieces : Arc → Set Arc := fun a => {b | ∃ θa θb, a = Arc.circ P 1 θa θb ∧ ∃ m : ℤ, cutLo θ₂ θa m < cutHi θ₁ θb m ∧
      b = Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)} with hpdef
  have hS : (S ∩ {a | ∃ θa θb, a = Arc.circ P 1 θa θb}).Finite := hfin.subset inter_subset_left
  have hfp : ∀ a ∈ S ∩ {a | ∃ θa θb, a = Arc.circ P 1 θa θb}, (pieces a).Finite := by
    rintro a ⟨-, θa, θb, rfl⟩
    refine (hpieces θa θb).subset ?_
    rintro b ⟨θa', θb', heq, m, hm, rfl⟩
    simp only [Arc.circ.injEq, true_and] at heq
    obtain ⟨rfl, rfl⟩ := heq
    exact ⟨m, hm, rfl⟩
  refine (hfin.union (hS.biUnion hfp)).subset ?_
  rintro b ⟨⟨hb, -⟩ | ⟨θa, θb, ha, m, hm, rfl⟩, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · refine Or.inr (mem_iUnion₂.mpr ⟨Arc.circ P 1 θa θb, ⟨⟨ha, ?_⟩, θa, θb, rfl⟩, θa, θb, rfl, m, hm, rfl⟩)
    obtain ⟨z, hz, hzt⟩ := hbt
    refine ⟨z, ?_, hzt⟩
    rw [carrier_circ_one] at hz ⊢
    exact image_mono (Icc_subset_Icc (le_max_left _ _) (min_le_left _ _)) hz

/-- A point `r(t)` lies on the open sub-arc `r((θ₁, θ₂))` exactly when some `t − 2πn` lies in `(θ₁, θ₂)`. -/
theorem ringPt_mem_openArc_iff (P : ℂ) {θ₁ θ₂ t : ℝ} :
    ringPt P t ∈ ringPt P '' Ioo θ₁ θ₂ ↔ ∃ n : ℤ, t - n * (2 * π) ∈ Ioo θ₁ θ₂ := by
  constructor
  · rintro ⟨u, hu, heq⟩
    have he : e u = e t := by simpa [ringPt] using heq
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he.symm
    exact ⟨n, by rw [hn]; simpa using hu⟩
  · rintro ⟨n, hn⟩
    refine ⟨t - n * (2 * π), hn, ?_⟩
    have := e_eq_e_iff.mpr ⟨n, (sub_add_cancel t _).symm⟩
    simp only [ringPt, this]

/-- The cut's pieces miss the open sub-arc. -/
theorem disjoint_piece_openArc {P : ℂ} {θ₁ θ₂ θa θb : ℝ} (m : ℤ) :
    Disjoint (Arc.circ P 1 (cutLo θ₂ θa m) (cutHi θ₁ θb m)).carrier (ringPt P '' Ioo θ₁ θ₂) := by
  rw [carrier_circ_one, Set.disjoint_left]
  rintro _ ⟨t, ht, rfl⟩ hmem
  obtain ⟨n, hn1, hn2⟩ := (ringPt_mem_openArc_iff P).mp hmem
  have hlo : θ₂ + m * (2 * π) ≤ t := (le_max_right _ _).trans ht.1
  have hhi : t ≤ θ₁ + (m + 1) * (2 * π) := ht.2.trans (min_le_right _ _)
  have hπ := Real.pi_pos
  rcases le_or_gt n m with h | h
  · have : (n : ℝ) ≤ m := by exact_mod_cast h
    nlinarith
  · have : (m : ℝ) + 1 ≤ n := by exact_mod_cast h
    nlinarith

/-- **The cut covers what it should**: a point of an arc `circ P 1 θa θb` of `F` off the open sub-arc and off its two ends lies on a
piece. -/
theorem mem_cut_of_mem_circ {P : ℂ} {θ₁ θ₂ θa θb : ℝ} (ha : Arc.circ P 1 θa θb ∈ F.arcs) {x : ℂ}
    (hx : x ∈ (Arc.circ P 1 θa θb).carrier) (hO : x ∉ ringPt P '' Ioo θ₁ θ₂) (hA : x ≠ ringPt P θ₁)
    (hB : x ≠ ringPt P θ₂) : x ∈ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier := by
  rw [carrier_circ_one] at hx
  obtain ⟨t, ht, rfl⟩ := hx
  have hπ := Real.pi_pos
  set m := ⌊(t - θ₂) / (2 * π)⌋ with hm
  have h1 : (m : ℝ) ≤ (t - θ₂) / (2 * π) := Int.floor_le _
  have h2 : (t - θ₂) / (2 * π) < m + 1 := Int.lt_floor_add_one _
  have h1' : θ₂ + m * (2 * π) ≤ t := by rw [le_div_iff₀ (by positivity)] at h1; linarith
  have h2' : t < θ₂ + (m + 1) * (2 * π) := by rw [div_lt_iff₀ (by positivity)] at h2; linarith
  have h3 : t ≤ θ₁ + (m + 1) * (2 * π) := by
    by_contra h
    push Not at h
    refine hO ((ringPt_mem_openArc_iff P).mpr ⟨m + 1, ?_, ?_⟩) <;> push_cast <;> linarith
  have hlo : cutLo θ₂ θa m ≤ t := max_le ht.1 h1'
  have hhi : t ≤ cutHi θ₁ θb m := le_min ht.2 h3
  rcases lt_or_eq_of_le (hlo.trans hhi) with hlt | heq
  · exact mem_iUnion₂.mpr ⟨_, Or.inr ⟨θa, θb, ha, m, hlt, rfl⟩, by
      rw [carrier_circ_one]; exact ⟨t, ⟨hlo, hhi⟩, rfl⟩⟩
  · exfalso
    have hlo' : cutLo θ₂ θa m = t := le_antisymm hlo (heq ▸ hhi)
    have hhi' : cutHi θ₁ θb m = t := le_antisymm (heq ▸ hlo) hhi
    obtain ⟨-, hab, -⟩ := F.nondegenerate _ ha
    rcases max_choice θa (θ₂ + m * (2 * π)) with h | h <;> rw [cutLo, h] at hlo' <;>
      rcases min_choice θb (θ₁ + (m + 1) * (2 * π)) with h' | h' <;> rw [cutHi, h'] at hhi'
    · linarith
    · exact hA (by rw [← hhi']; simpa [ringPt] using (e_add_int_mul_two_pi θ₁ (m + 1)))
    · exact hB (by rw [← hlo']; simpa [ringPt] using (e_add_int_mul_two_pi θ₂ m))
    · exact hB (by rw [← hlo']; simpa [ringPt] using (e_add_int_mul_two_pi θ₂ m))

/-- Off the open sub-arc and its two ends, the cut's arcs and `F`'s cover the same points. -/
theorem mem_cutArcs_iff {P : ℂ} {θ₁ θ₂ : ℝ} {x : ℂ} (hO : x ∉ ringPt P '' Ioo θ₁ θ₂) (hA : x ≠ ringPt P θ₁)
    (hB : x ≠ ringPt P θ₂) : x ∈ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier ↔ x ∈ ⋃ a ∈ F.arcs, a.carrier := by
  constructor
  · intro h
    obtain ⟨b, hb, hxb⟩ := mem_iUnion₂.mp h
    obtain ⟨a, ha, hsub⟩ := F.cutArcs_subset b hb
    exact mem_iUnion₂.mpr ⟨a, ha, hsub hxb⟩
  · intro h
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
    by_cases hc : ∃ θa θb, a = Arc.circ P 1 θa θb
    · obtain ⟨θa, θb, rfl⟩ := hc
      exact F.mem_cut_of_mem_circ ha hxa hO hA hB
    · push Not at hc
      exact mem_iUnion₂.mpr ⟨a, Or.inl ⟨ha, hc⟩, hxa⟩

/-- On the open sub-arc, a point of the cut's arcs lies on an arc of `F` that is not an arc of `ω(P)`. -/
theorem exists_kept_of_mem_openArc {P : ℂ} {θ₁ θ₂ : ℝ} {x : ℂ} (hO : x ∈ ringPt P '' Ioo θ₁ θ₂)
    (hx : x ∈ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier) : ∃ a ∈ F.arcs, (∀ θa θb, a ≠ .circ P 1 θa θb) ∧ x ∈ a.carrier := by
  obtain ⟨b, hb, hxb⟩ := mem_iUnion₂.mp hx
  rcases hb with ⟨hb, hnot⟩ | ⟨θa, θb, -, m, -, rfl⟩
  · exact ⟨b, hb, hnot, hxb⟩
  · exact absurd hO (Set.disjoint_left.mp (disjoint_piece_openArc m) hxb)

/-! ## The bend: the cut, one new arc, and a lens recoloured -/

/-- Off a locally finite family of arcs, a point has a neighbourhood off the family. -/
theorem eventually_not_mem_arcs {A : Set Arc} {x : ℂ} (hlf : ∃ t ∈ 𝓝 x, {a | a ∈ A ∧ (a.carrier ∩ t).Nonempty}.Finite)
    (hx : x ∉ ⋃ a ∈ A, a.carrier) : ∀ᶠ y in 𝓝 x, y ∉ ⋃ a ∈ A, a.carrier := by
  obtain ⟨t, ht, hfin⟩ := hlf
  have hcl : IsClosed (⋃ a ∈ {a | a ∈ A ∧ (a.carrier ∩ t).Nonempty}, a.carrier) :=
    hfin.isClosed_biUnion fun a _ => a.isClosed_carrier
  have hxn : x ∉ ⋃ a ∈ {a | a ∈ A ∧ (a.carrier ∩ t).Nonempty}, a.carrier := fun h => by
    obtain ⟨a, ⟨ha, -⟩, hxa⟩ := mem_iUnion₂.mp h
    exact hx (mem_iUnion₂.mpr ⟨a, ha, hxa⟩)
  filter_upwards [ht, hcl.isOpen_compl.mem_nhds hxn] with y hyt hyc hy
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hy
  exact hyc (mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, hyt⟩, hya⟩)

/-- The bend's arcs (the cut and one new arc) are locally finite on the domain. -/
theorem bendArcs_locallyFinite {P : ℂ} {θ₁ θ₂ : ℝ} (a : Arc) :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {b | b ∈ F.cutArcs P θ₁ θ₂ ∪ {a} ∧ (b.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.cutArcs_locallyFinite (P := P) (θ₁ := θ₁) (θ₂ := θ₂) x hx
  refine ⟨t, ht, (hfin.union (finite_singleton a)).subset ?_⟩
  rintro b ⟨hb | hb, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · exact Or.inr hb

/-- The bend's colouring: `j` on the lens `L`, `F`'s elsewhere. -/
noncomputable def bendCol (L : Set ℂ) (j : Fin k) : ℂ → Fin k := by
  classical
  exact fun y => if y ∈ L then j else F.col y

/-- On the lens the bend's colour is `j`. -/
theorem bendCol_of_mem {L : Set ℂ} {j : Fin k} {y : ℂ} (hy : y ∈ L) : F.bendCol L j y = j := by
  simp [bendCol, hy]

/-- Off the lens the bend's colour is `F`'s. -/
theorem bendCol_of_not_mem {L : Set ℂ} {j : Fin k} {y : ℂ} (hy : y ∉ L) : F.bendCol L j y = F.col y := by
  simp [bendCol, hy]

/-- **The bend's colouring is locally constant off its arcs**: inside the lens off `ω(P)` by openness; at a point of the open
sub-arc, the lens on one side and `F`'s class of `j` on the other (`hside`, `hcol`); off the lens, `F`'s. -/
theorem bend_hlc {P : ℂ} {θ₁ θ₂ : ℝ} {a : Arc} {L S : Set ℂ} {j : Fin k} (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L)
    (hAa : ringPt P θ₁ ∈ a.carrier) (hBa : ringPt P θ₂ ∈ a.carrier) (hcl : closure L ⊆ L ∪ a.carrier)
    (hLsph : ∀ x ∈ L, x ∈ sphere P 1 → x ∈ ringPt P '' Ioo θ₁ θ₂) (hLopen : ∀ x ∈ L, x ∉ sphere P 1 → L ∈ 𝓝 x)
    (hS : Disjoint S (sphere P 1)) (hside : ∀ x ∈ ringPt P '' Ioo θ₁ θ₂, ∀ᶠ y in 𝓝 x, y ∈ L ∨ y ∈ S)
    (hcol : ∀ x ∈ ringPt P '' Ioo θ₁ θ₂, ∀ i, i ≠ j → x ∉ closure (F.region i ∩ S)) :
    ∀ x ∈ F.dom, x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂ ∪ {a}, b.carrier → ∀ᶠ y in 𝓝 x, F.bendCol L j y = F.bendCol L j x := by
  intro x hx hxA
  have hev := eventually_not_mem_arcs (F.bendArcs_locallyFinite a x hx) hxA
  have hxa : x ∉ a.carrier := fun h => hxA (mem_iUnion₂.mpr ⟨a, Or.inr rfl, h⟩)
  have hxcut : x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier := fun h => by
    obtain ⟨b, hb, hxb⟩ := mem_iUnion₂.mp h
    exact hxA (mem_iUnion₂.mpr ⟨b, Or.inl hb, hxb⟩)
  by_cases hxL : x ∈ L
  · rw [F.bendCol_of_mem hxL]
    by_cases hsph : x ∈ sphere P 1
    · have hxO := hLsph x hxL hsph
      have hfin : ∀ᶠ y in 𝓝 x, ∀ i, i ≠ j → y ∉ F.region i ∩ S := by
        rw [eventually_all]
        intro i
        by_cases hij : i = j
        · exact Filter.Eventually.of_forall fun _ h => absurd hij h
        · filter_upwards [isClosed_closure.isOpen_compl.mem_nhds (hcol x hxO i hij)] with y hy _ hyR
          exact hy (subset_closure hyR)
      filter_upwards [hev, hside x hxO, hfin, F.isOpen_dom.mem_nhds hx] with y hyA hyLS hyR hyd
      by_cases hyL : y ∈ L
      · exact F.bendCol_of_mem hyL
      · have hyS : y ∈ S := hyLS.resolve_left hyL
        rw [F.bendCol_of_not_mem hyL]
        have hyF : y ∉ ⋃ b ∈ F.arcs, b.carrier := by
          intro h
          obtain ⟨b, hb, hyb⟩ := mem_iUnion₂.mp h
          by_cases hc : ∃ θa θb, b = Arc.circ P 1 θa θb
          · obtain ⟨θa, θb, rfl⟩ := hc
            rw [carrier_circ_one] at hyb
            obtain ⟨t, -, rfl⟩ := hyb
            exact Set.disjoint_left.mp hS hyS (ringPt_mem_sphere P t)
          · push Not at hc
            exact hyA (mem_iUnion₂.mpr ⟨b, Or.inl (Or.inl ⟨hb, hc⟩), hyb⟩)
        by_contra hne
        exact hyR (F.col y) hne ⟨⟨⟨hyd, hyF⟩, rfl⟩, hyS⟩
    · filter_upwards [hLopen x hxL hsph] with y hy
      exact F.bendCol_of_mem hy
  · have hxcl : x ∉ closure L := fun h => (hcl h).elim hxL hxa
    have hxF : x ∉ ⋃ b ∈ F.arcs, b.carrier := by
      intro h
      refine hxcut ((F.mem_cutArcs_iff (fun h' => hxL (hOL h')) (fun h' => hxa (h' ▸ hAa))
        (fun h' => hxa (h' ▸ hBa))).mpr h)
    filter_upwards [F.locallyConstant x hx hxF, isClosed_closure.isOpen_compl.mem_nhds hxcl] with y hy hyL
    have hyL' : y ∉ L := fun h => hyL (subset_closure h)
    rw [F.bendCol_of_not_mem hyL', F.bendCol_of_not_mem hxL, hy]

/-- **The bent map**: `F`'s domain, the cut of the open sub-arc `r((θ₁, θ₂))` of `ω(P)` together with one new arc `a`, and the
colour `j` on the lens `L`. -/
noncomputable def bendMap (P : ℂ) (θ₁ θ₂ : ℝ) (a : Arc) (L : Set ℂ) (j : Fin k) (ha : a.Nondegenerate)
    (hlc : ∀ x ∈ F.dom, x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂ ∪ {a}, b.carrier → ∀ᶠ y in 𝓝 x, F.bendCol L j y = F.bendCol L j x) :
    ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.cutArcs P θ₁ θ₂ ∪ {a}
  nondegenerate := by
    rintro b (hb | hb)
    · exact F.cutArcs_nondegenerate b hb
    · rw [mem_singleton_iff.mp hb]; exact ha
  locallyFinite := F.bendArcs_locallyFinite a
  col := F.bendCol L j
  locallyConstant := hlc

section BendMap

variable {F} {P : ℂ} {θ₁ θ₂ : ℝ} {a : Arc} {L : Set ℂ} {j : Fin k} {ha : a.Nondegenerate}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂ ∪ {a}, b.carrier → ∀ᶠ y in 𝓝 x, F.bendCol L j y = F.bendCol L j x}

/-- The bent map's interior points off the lens are `F`'s, with `F`'s colours. -/
theorem bendMap_interiorPts (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L) (hAa : ringPt P θ₁ ∈ a.carrier)
    (hBa : ringPt P θ₂ ∈ a.carrier) {z : ℂ} (hz : z ∈ (F.bendMap P θ₁ θ₂ a L j ha hlc).interiorPts) (hzL : z ∉ L) :
    z ∈ F.interiorPts ∧ (F.bendMap P θ₁ θ₂ a L j ha hlc).col z = F.col z := by
  obtain ⟨hzd, hzA⟩ := hz
  have hza : z ∉ a.carrier := fun h => hzA (mem_iUnion₂.mpr ⟨a, Or.inr rfl, h⟩)
  have hzcut : z ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂, b.carrier := fun h => by
    obtain ⟨b, hb, hzb⟩ := mem_iUnion₂.mp h
    exact hzA (mem_iUnion₂.mpr ⟨b, Or.inl hb, hzb⟩)
  refine ⟨⟨hzd, fun h => hzcut ((F.mem_cutArcs_iff (fun h' => hzL (hOL h')) (fun h' => hza (h' ▸ hAa))
    (fun h' => hza (h' ▸ hBa))).mpr h)⟩, F.bendCol_of_not_mem hzL⟩

/-- **The bent map agrees with `F` off `U`** when the lens, the new arc and the closed arc lie in `U`. -/
theorem bendMap_agreesOff (h12 : θ₁ < θ₂) {U : Set ℂ} (hLU : L ⊆ U) (haU : a.carrier ⊆ U) (hαU : ringArc P θ₁ θ₂ ⊆ U) :
    (F.bendMap P θ₁ θ₂ a L j ha hlc).AgreesOff F U := by
  refine ⟨rfl, fun z hz => ⟨?_, (F.bendCol_of_not_mem fun h => hz (hLU h)).symm⟩⟩
  have hzO : z ∉ ringPt P '' Ioo θ₁ θ₂ := fun h => hz (hαU (image_mono Ioo_subset_Icc_self h))
  have hzA : z ≠ ringPt P θ₁ := by rintro rfl; exact hz (hαU ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩)
  have hzB : z ≠ ringPt P θ₂ := by rintro rfl; exact hz (hαU ⟨θ₂, ⟨h12.le, le_rfl⟩, rfl⟩)
  have hza : z ∉ a.carrier := fun h => hz (haU h)
  have key := F.mem_cutArcs_iff hzO hzA hzB
  show z ∈ F.dom \ _ ↔ z ∈ F.dom \ _
  refine ⟨fun ⟨hd, hn⟩ => ⟨hd, fun h => ?_⟩, fun ⟨hd, hn⟩ => ⟨hd, fun h => hn ?_⟩⟩
  · obtain ⟨b, hb | hb, hzb⟩ := mem_iUnion₂.mp h
    · exact hn (key.mp (mem_iUnion₂.mpr ⟨b, hb, hzb⟩))
    · exact hza (mem_singleton_iff.mp hb ▸ hzb)
  · obtain ⟨b, hb, hzb⟩ := mem_iUnion₂.mp (key.mpr h)
    exact mem_iUnion₂.mpr ⟨b, Or.inl hb, hzb⟩

/-- **The bent map creates no unit arc** (engine 2): its `Γ` lies in `F`'s and the new arc, which is not a unit arc. -/
theorem bendMap_ringArcsWithin (hau : ¬ a.IsUnitArc) : (F.bendMap P θ₁ θ₂ a L j ha hlc).RingArcsWithin F := by
  refine ringArcsWithin_of_Γ_subset rfl (A' := {a}) (fun b hb => mem_singleton_iff.mp hb ▸ ha)
    (fun x _ => ⟨univ, univ_mem, (finite_singleton a).subset fun b hb => hb.1⟩)
    (fun b hb => mem_singleton_iff.mp hb ▸ hau) ?_
  rintro z ⟨hzd, hz⟩
  obtain ⟨b, hb | hb, hzb⟩ := mem_iUnion₂.mp hz
  · obtain ⟨a', ha', hsub⟩ := F.cutArcs_subset b hb
    exact Or.inl ⟨hzd, mem_iUnion₂.mpr ⟨a', ha', hsub hzb⟩⟩
  · exact Or.inr (mem_iUnion₂.mpr ⟨a, rfl, mem_singleton_iff.mp hb ▸ hzb⟩)

/-- **The bent map is valid** (engine 1) when the lens is clear for `j` in `F` and holds no unit pair. -/
theorem bendMap_valid (hF : F.Valid) (h12 : θ₁ < θ₂) {U : Set ℂ} (hLU : L ⊆ U) (haU : a.carrier ⊆ U)
    (hαU : ringArc P θ₁ θ₂ ⊆ U) (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L) (hAa : ringPt P θ₁ ∈ a.carrier)
    (hBa : ringPt P θ₂ ∈ a.carrier) (hclear : ∀ z ∈ L, F.IsClear j z) (hLL : ∀ z ∈ L, ∀ z' ∈ L, dist z z' ≠ 1) :
    (F.bendMap P θ₁ θ₂ a L j ha hlc).Valid := by
  set F' := F.bendMap P θ₁ θ₂ a L j ha hlc
  have hjL : ∀ z ∈ L, F'.col z = j := fun z hz => F.bendCol_of_mem hz
  have hoff : ∀ {z}, z ∈ (F.bendMap P θ₁ θ₂ a L j ha hlc).interiorPts → z ∉ L →
      z ∈ F.interiorPts ∧ (F.bendMap P θ₁ θ₂ a L j ha hlc).col z = F.col z :=
    fun hz hzL => bendMap_interiorPts hOL hAa hBa hz hzL
  refine Valid.of_agreesOff hF (bendMap_agreesOff h12 hLU haU hαU) (fun z ⟨_, hz⟩ => ?_) ?_
  · by_cases hzL : z ∈ L
    · rw [hjL z hzL]; exact hclear z hzL
    · obtain ⟨hzi, hzc⟩ := hoff hz hzL
      rw [hzc]
      intro y hy hzy
      exact hF z hzi y hy.1 hzy hy.2.symm
  · rintro z ⟨_, hz⟩ y ⟨_, hy⟩ hzy hcol
    by_cases hzL : z ∈ L <;> by_cases hyL : y ∈ L
    · exact hLL z hzL y hyL hzy
    · obtain ⟨hyi, hyc⟩ := hoff hy hyL
      refine hclear z hzL y ⟨hyi, ?_⟩ hzy
      show F.col y = j
      rw [← hyc, ← hcol, hjL z hzL]
    · obtain ⟨hzi, hzc⟩ := hoff hz hzL
      refine hclear y hyL z ⟨hzi, ?_⟩ (by rw [dist_comm]; exact hzy)
      show F.col z = j
      rw [← hzc, hcol, hjL y hyL]
    · obtain ⟨hzi, hzc⟩ := hoff hz hzL
      obtain ⟨hyi, hyc⟩ := hoff hy hyL
      exact hF z hzi y hyi hzy (by rw [← hzc, ← hyc]; exact hcol)

/-- The bent map's classes: no colour but `j` gains points, and `j` only on the lens. -/
theorem bendMap_region (hOL : ringPt P '' Ioo θ₁ θ₂ ⊆ L) (hAa : ringPt P θ₁ ∈ a.carrier)
    (hBa : ringPt P θ₂ ∈ a.carrier) :
    (∀ i, i ≠ j → (F.bendMap P θ₁ θ₂ a L j ha hlc).region i ⊆ F.region i) ∧
      (F.bendMap P θ₁ θ₂ a L j ha hlc).region j ⊆ F.region j ∪ L := by
  have hoff : ∀ {z}, z ∈ (F.bendMap P θ₁ θ₂ a L j ha hlc).interiorPts → z ∉ L →
      z ∈ F.interiorPts ∧ (F.bendMap P θ₁ θ₂ a L j ha hlc).col z = F.col z :=
    fun hz hzL => bendMap_interiorPts hOL hAa hBa hz hzL
  refine ⟨fun i hij z ⟨hz, hzc⟩ => ?_, fun z ⟨hz, hzc⟩ => ?_⟩
  · have hzL : z ∉ L := fun h => hij (by rw [← (show _ = i from hzc)]; exact F.bendCol_of_mem h)
    obtain ⟨hzi, hcz⟩ := hoff hz hzL
    exact ⟨hzi, by show F.col z = i; rw [← hcz]; exact hzc⟩
  · by_cases hzL : z ∈ L
    · exact Or.inr hzL
    · obtain ⟨hzi, hcz⟩ := hoff hz hzL
      exact Or.inl ⟨hzi, by show F.col z = j; rw [← hcz]; exact hzc⟩

/-- **The open sub-arc leaves `ω(P)`'s arcs**: in the bent map no point of `r((θ₁, θ₂))` lies on an arc of `Γ` on `ω(P)` — near it
the cut leaves only arcs of `F` that are not arcs of `ω(P)`, finitely many, each meeting `ω(P)` finitely often. -/
theorem bendMap_not_onRingArc (hdom : ringPt P '' Ioo θ₁ θ₂ ⊆ F.dom)
    (haO : Disjoint a.carrier (ringPt P '' Ioo θ₁ θ₂)) :
    ∀ θ ∈ Ioo θ₁ θ₂, ¬ (F.bendMap P θ₁ θ₂ a L j ha hlc).OnRingArc P (ringPt P θ) := by
  rintro θ hθ ⟨a', b', hab, ⟨t₀, ht₀, heq⟩, hsub⟩
  have hπ := Real.pi_pos
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite _ (hdom ⟨θ, hθ, rfl⟩)
  obtain ⟨r, hr, hrt⟩ := Metric.mem_nhds_iff.mp ht
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp (show e t₀ = e θ by simpa [ringPt] using heq)
  set η := min r (min (θ₂ - θ) (θ - θ₁)) with hη
  have hη0 : 0 < η := lt_min hr (lt_min (by linarith [hθ.2]) (by linarith [hθ.1]))
  -- a sub-interval of `[a', b']` within `η` of `t₀`
  obtain ⟨lo, hi, hlh, hJ⟩ : ∃ lo hi, lo < hi ∧ Icc lo hi ⊆ Icc a' b' ∩ Ioo (t₀ - η) (t₀ + η) := by
    rcases lt_or_eq_of_le ht₀.2 with h | h
    · refine ⟨t₀, min b' (t₀ + η / 2), lt_min h (by linarith), fun u hu => ⟨⟨by linarith [ht₀.1, hu.1], ?_⟩, by linarith [hu.1], ?_⟩⟩
      · linarith [hu.2, min_le_left b' (t₀ + η / 2)]
      · linarith [hu.2, min_le_right b' (t₀ + η / 2)]
    · refine ⟨max a' (t₀ - η / 2), t₀, max_lt (by linarith) (by linarith), fun u hu => ⟨⟨?_, by linarith [hu.2]⟩, ?_, by linarith [hu.2]⟩⟩
      · linarith [hu.1, le_max_left a' (t₀ - η / 2)]
      · linarith [hu.1, le_max_right a' (t₀ - η / 2)]
  -- the finitely many points of `ω(P)` on the arcs of `F` near `r(θ)` that are not arcs of `ω(P)`
  set Cf := ⋃ b ∈ {b | b ∈ F.arcs ∧ (b.carrier ∩ t).Nonempty ∧ ∀ θa θb, b ≠ Arc.circ P 1 θa θb}, b.carrier ∩ sphere P 1
  have hCf : Cf.Finite := by
    refine (hfin.subset fun b hb => ⟨hb.1, hb.2.1⟩).biUnion fun b hb => ?_
    rcases Arc.finite_inter_sphere_or_eq_circ b (F.nondegenerate b hb.1) P with h | ⟨θa, θb, h⟩
    · exact h
    · exact absurd h (hb.2.2 θa θb)
  have hy0 : ringPt P lo ∈ ringArc P lo hi := ⟨lo, ⟨le_rfl, hlh.le⟩, rfl⟩
  have hne : (ringArc P lo hi \ Cf).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty] at h
    have := mem_closure_ringArc_diff_finite hlh hCf hy0
    rw [h, closure_empty] at this
    exact this
  obtain ⟨_, ⟨u, hu, rfl⟩, huC⟩ := hne
  have huJ := hJ hu
  have huO : ringPt P u ∈ ringPt P '' Ioo θ₁ θ₂ := by
    refine (ringPt_mem_openArc_iff P).mpr ⟨n, ?_, ?_⟩
    · have := huJ.2.1; have := min_le_right r (min (θ₂ - θ) (θ - θ₁)); have := min_le_right (θ₂ - θ) (θ - θ₁); linarith
    · have := huJ.2.2; have := min_le_right r (min (θ₂ - θ) (θ - θ₁)); have := min_le_left (θ₂ - θ) (θ - θ₁); linarith
  have huΓ := hsub ⟨u, huJ.1, rfl⟩
  obtain ⟨b, hb | hb, hub⟩ := mem_iUnion₂.mp huΓ.2
  · obtain ⟨a₁, ha₁, hnot, hua₁⟩ := F.exists_kept_of_mem_openArc huO (mem_iUnion₂.mpr ⟨b, hb, hub⟩)
    have hut : ringPt P u ∈ t := by
      refine hrt ?_
      rw [mem_ball, dist_eq_norm, ringPt, ringPt, show P + e u - (P + e θ) = e u - e θ by ring]
      have h1 : e θ = e t₀ := by simpa [ringPt] using heq.symm
      rw [h1]
      calc ‖e u - e t₀‖ ≤ |u - t₀| := norm_e_sub_e_le u t₀
        _ < η := by rw [abs_lt]; constructor <;> linarith [huJ.2.1, huJ.2.2]
        _ ≤ r := min_le_left _ _
    exact huC (mem_iUnion₂.mpr ⟨a₁, ⟨ha₁, ⟨_, hua₁, hut⟩, hnot⟩, hua₁, ringPt_mem_sphere P u⟩)
  · exact Set.disjoint_left.mp haO (mem_singleton_iff.mp hb ▸ hub) huO

end BendMap

/-- A point `P + ρ e(β)` with `β ∈ [θ₁, θ₂]` and `|1 − ρ| < ε` lies within `ε` of the closed arc. -/
theorem mem_thickening_ringArc_of_polar {P z : ℂ} {θ₁ θ₂ β ρ ε : ℝ} (hβ : β ∈ Icc θ₁ θ₂) (hz : z = P + (ρ : ℂ) * e β)
    (hρ : |1 - ρ| < ε) : z ∈ thickening ε (ringArc P θ₁ θ₂) := by
  rw [Metric.mem_thickening_iff]
  exact ⟨ringPt P β, ⟨β, hβ, rfl⟩, by rw [hz, dist_polar_ringPt]; exact hρ⟩

/-- **The toward lens point is clear for the outer colour** (N2-TOWARD's clearness): a point `P + (1 − s) e(φ)` of the lens profile
`0 < s ≤ ψ Δ(φ)` is at distance `≠ 1` from the outer class — a near point of the class (inside a unit disc about the arc) lies in
`B̄(A, 1) ∩ B̄(B, 1)` (N2-SIGN), within `< 1` of the lens point (N2-ENV near); a far one lies, by N2-ENV toward, in `B(P, r)`, which
the class misses. -/
theorem toward_clear (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {r ψ₁ ψ₂ : ℝ}
    (hr : ∀ y ∈ F.region c', r ≤ dist y P)
    (henv : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 - s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ ball P r)
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1, dist p (P + (1 - s) * e φ) < 1)
    {φ s : ℝ} (hφ : φ ∈ Ioo θ₁ θ₂) (hs : 0 < s) (hsψ₁ : s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ))
    (hsψ₂ : s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ)) :
    F.IsClear c' (P + (1 - s) * e φ) := by
  intro y hy hzy
  have h12 : θ₁ < θ₂ := hA.1
  have hcont : Continuous fun θ : ℝ => dist y (ringPt P θ) := by unfold ringPt e; fun_prop
  by_cases hU : y ∈ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1
  · obtain ⟨θ₀, hθ₀, hy0⟩ := mem_iUnion₂.mp hU
    rw [mem_ball] at hy0
    rcases n2_sign hF hA (Or.inr rfl) hy with hlt | hgt
    · have hle := le_on_Icc_of_Ioo hcont h12 fun θ hθ => (hlt θ hθ).le
      have := hnear φ hφ s hs hsψ₂ y ⟨mem_closedBall.mpr (hle θ₁ ⟨le_rfl, h12.le⟩),
        mem_closedBall.mpr (hle θ₂ ⟨h12.le, le_rfl⟩)⟩
      rw [dist_comm] at this; linarith
    · have hge := ge_on_Icc_of_Ioo hcont h12 fun θ hθ => (hgt θ hθ).le
      linarith [hge θ₀ hθ₀]
  · have hyb : y ∈ closedBall (P + (1 - s) * e φ) 1 := by rw [mem_closedBall, dist_comm]; exact hzy.le
    have := henv φ hφ s hs hsψ₁ ⟨hyb, hU⟩
    rw [mem_ball] at this
    linarith [hr y hy]

/-- **The away lens point is clear for the inner colour** (N2-AWAY's clearness): a point `P + (1 + s) e(φ)` of the lens profile is
at distance `≠ 1` from the inner class — a near point of the class lies in `B̄(A, 1) ∩ B̄(B, 1)` (N2-SIGN), off `B(P, r)` (which
the class misses) within `< 1` of the lens point (N2-ENV near, away); a far one lies, by N2-ENV away, within `r` of `R₂(ᾱ)`, which
the class misses. -/
theorem away_clear (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {r ψ₁ ψ₂ : ℝ}
    (hr : ∀ y ∈ F.region c, r ≤ dist y P) (hr2 : ∀ y ∈ F.region c, y ∉ thickening r (radiusTwoArc P θ₁ θ₂))
    (henv : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 + s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ thickening r (radiusTwoArc P θ₁ θ₂))
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1)
    {φ s : ℝ} (hφ : φ ∈ Ioo θ₁ θ₂) (hs : 0 < s) (hsψ₁ : s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ))
    (hsψ₂ : s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ)) :
    F.IsClear c (P + (1 + s) * e φ) := by
  intro y hy hzy
  have h12 : θ₁ < θ₂ := hA.1
  have hcont : Continuous fun θ : ℝ => dist y (ringPt P θ) := by unfold ringPt e; fun_prop
  by_cases hU : y ∈ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1
  · obtain ⟨θ₀, hθ₀, hy0⟩ := mem_iUnion₂.mp hU
    rw [mem_ball] at hy0
    rcases n2_sign hF hA (Or.inl rfl) hy with hlt | hgt
    · have hle := le_on_Icc_of_Ioo hcont h12 fun θ hθ => (hlt θ hθ).le
      have hyP : y ∉ ball P r := fun h' => by rw [mem_ball] at h'; linarith [hr y hy]
      have := hnear φ hφ s hs hsψ₂ y ⟨⟨mem_closedBall.mpr (hle θ₁ ⟨le_rfl, h12.le⟩),
        mem_closedBall.mpr (hle θ₂ ⟨h12.le, le_rfl⟩)⟩, hyP⟩
      rw [dist_comm] at this; linarith
    · have hge := ge_on_Icc_of_Ioo hcont h12 fun θ hθ => (hgt θ hθ).le
      linarith [hge θ₀ hθ₀]
  · have hyb : y ∈ closedBall (P + (1 + s) * e φ) 1 := by rw [mem_closedBall, dist_comm]; exact hzy.le
    exact hr2 y hy (henv φ hφ s hs hsψ₁ ⟨hyb, hU⟩)

/-- **The away lens is clear for the inner colour**: on `ω(P)` by `ne1_region`, off it by `away_clear` at the lens profile. -/
theorem away_lens_clear (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {r ψ₁ ψ₂ d : ℝ}
    (hd : 0 < d) (hd10 : d ≤ 1 / 10)
    (hr : ∀ y ∈ F.region c, r ≤ dist y P) (hr2 : ∀ y ∈ F.region c, y ∉ thickening r (radiusTwoArc P θ₁ θ₂))
    (henv : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₁ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 + s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ thickening r (radiusTwoArc P θ₁ θ₂))
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ₂ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1)
    (hd1 : 2 * d ≤ ψ₁) (hd2 : 2 * d ≤ ψ₂) {z : ℂ} (hz1 : 1 ≤ dist z P)
    (hzC : dist z (P + d * e ((θ₁ + θ₂) / 2)) ^ 2 < 1 - 2 * d * Real.cos ((θ₂ - θ₁) / 2) + d ^ 2) :
    F.IsClear c z := by
  have h12 : θ₁ < θ₂ := hA.1
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by rw [hhdef]; linarith
  obtain ⟨hb, hs⟩ := away_polar_strict hd (by linarith) hh hh2 hz1 hzC
  set b := arg ((z - P) * starRingEnd ℂ (e φ)) with hbdef
  have hpolO : φ + b ∈ Ioo θ₁ θ₂ :=
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).2]⟩
  by_cases hsph : dist z P = 1
  · have hz := eq_polar_frameDir P z φ
    rw [← hbdef, hsph, Complex.ofReal_one, one_mul] at hz
    have hcl' : z ∈ closure (F.region c) := by
      have : c ∈ F.innerColours P (ringPt P (φ + b)) := by rw [(hA.2.2 _ hpolO).1]; rfl
      rw [hz]; exact closure_mono inter_subset_left this
    intro y hy hzy
    exact ne1_region hF hcl' hy (by rw [dist_comm]; exact hzy)
  · have hs0 : 0 < dist z P - 1 := by have := lt_of_le_of_ne hz1 (Ne.symm hsph); linarith
    have hmin : min (φ + b - θ₁) (θ₂ - (φ + b)) = h - |b| := by
      rw [show φ + b - θ₁ = h + b by rw [hφdef, hhdef]; ring, show θ₂ - (φ + b) = h - b by rw [hφdef, hhdef]; ring]
      exact min_add_sub_eq h b
    have hzeq : z = P + (1 + ((dist z P - 1 : ℝ) : ℂ)) * e (φ + b) := by
      have := eq_polar_frameDir P z φ
      rw [← hbdef] at this
      calc z = P + (dist z P : ℂ) * e (φ + b) := this
        _ = _ := by push_cast; ring
    have hΔ : 0 ≤ h - |b| := by linarith
    rw [hzeq]
    refine F.away_clear hF hA hr hr2 henv hnear hpolO hs0 ?_ ?_ <;> rw [hmin]
    · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd1 hΔ)).le
    · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd2 hΔ)).le

/-- **Two points of the away lens are never at distance `1`**: if one is off `ω(P)` it is a lens point of the profile and the other
lies in `B̄(A, 1) ∩ B̄(B, 1)` off `B(P, r)` (`away_mem_lens`), so N2-ENV's near clause puts them within `< 1`; two points of `ω(P)`
within `2h ≤ 60°` of each other are within `< 1`. -/
theorem away_pairs {P : ℂ} {θ₁ θ₂ d r ψ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) (hd : 0 < d) (hd10 : d ≤ 1 / 10)
    (hr : r ≤ 1 / 2) (hdψ : 2 * d ≤ ψ)
    (hnear : ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1)
    {z z' : ℂ} (hz1 : 1 ≤ dist z P)
    (hzC : dist z (P + d * e ((θ₁ + θ₂) / 2)) ^ 2 < 1 - 2 * d * Real.cos ((θ₂ - θ₁) / 2) + d ^ 2)
    (hz1' : 1 ≤ dist z' P)
    (hzC' : dist z' (P + d * e ((θ₁ + θ₂) / 2)) ^ 2 < 1 - 2 * d * Real.cos ((θ₂ - θ₁) / 2) + d ^ 2) :
    dist z z' ≠ 1 := by
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh6 : h ≤ π / 6 := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by linarith
  have hdh : d ≤ 1 / 2 := by linarith
  have hθ₁ : φ - h = θ₁ := by rw [hφdef, hhdef]; ring
  have hθ₂ : φ + h = θ₂ := by rw [hφdef, hhdef]; ring
  have hinI : ∀ x : ℂ, 1 ≤ dist x P → dist x (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2 →
      x ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r := by
    intro x hx1 hxC
    obtain ⟨hb, hs⟩ := away_polar_strict hd hdh hh hh2 hx1 hxC
    have hx' := eq_polar_frameDir P x φ
    have := away_mem_lens (P := P) (φ := φ) hd.le hd10 hh6 hb.le hx1 hs.le
    rw [← hx', hθ₁, hθ₂] at this
    refine ⟨⟨mem_closedBall.mpr this.1, mem_closedBall.mpr this.2⟩, fun h' => ?_⟩
    rw [mem_ball] at h'
    linarith
  have hoff1 : ∀ x x' : ℂ, 1 ≤ dist x P → dist x (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2 →
      1 ≤ dist x' P → dist x' (P + d * e φ) ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2 → dist x P ≠ 1 → dist x x' ≠ 1 := by
    intro x x' hx1 hxC hx1' hxC' hsph
    obtain ⟨hb, hs⟩ := away_polar_strict hd hdh hh hh2 hx1 hxC
    set b := arg ((x - P) * starRingEnd ℂ (e φ)) with hbdef
    have hpolO : φ + b ∈ Ioo θ₁ θ₂ :=
      ⟨by rw [← hθ₁]; linarith [(abs_lt.mp hb).1], by rw [← hθ₂]; linarith [(abs_lt.mp hb).2]⟩
    have hs0 : 0 < dist x P - 1 := by have := lt_of_le_of_ne hx1 (Ne.symm hsph); linarith
    have hmin : min (φ + b - θ₁) (θ₂ - (φ + b)) = h - |b| := by
      rw [← hθ₁, ← hθ₂, show φ + b - (φ - h) = h + b by ring, show φ + h - (φ + b) = h - b by ring]
      exact min_add_sub_eq h b
    have hxeq : x = P + (1 + ((dist x P - 1 : ℝ) : ℂ)) * e (φ + b) := by
      have := eq_polar_frameDir P x φ
      rw [← hbdef] at this
      calc x = P + (dist x P : ℂ) * e (φ + b) := this
        _ = _ := by push_cast; ring
    have hΔ : 0 ≤ h - |b| := by linarith
    have := hnear (φ + b) hpolO (dist x P - 1) hs0
      (by rw [hmin]; exact (hs.trans_le (mul_le_mul_of_nonneg_right hdψ hΔ)).le) x' (hinI x' hx1' hxC')
    rw [← hxeq, dist_comm] at this
    exact ne_of_lt this
  by_cases h1 : dist z P = 1
  · by_cases h1' : dist z' P = 1
    · obtain ⟨hb, -⟩ := away_polar_strict hd hdh hh hh2 hz1 hzC
      obtain ⟨hb', -⟩ := away_polar_strict hd hdh hh hh2 hz1' hzC'
      set b := arg ((z - P) * starRingEnd ℂ (e φ))
      set b' := arg ((z' - P) * starRingEnd ℂ (e φ))
      have hcos : 1 / 2 < Real.cos (b - b') := by
        have h3 : |b - b'| < π / 3 := by have := abs_sub b b'; linarith
        have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) h3
        rw [Real.cos_abs, Real.cos_pi_div_three] at this
        exact this
      have hz₀ := eq_polar_frameDir P z φ
      have hz₀' := eq_polar_frameDir P z' φ
      have hd' : dist z z' = dist (P + (dist z P : ℂ) * e (φ + b)) (P + (dist z' P : ℂ) * e (φ + b')) := by
        rw [← hz₀, ← hz₀']
      intro h2
      have := dist_polar_polar_sq P (dist z P) (dist z' P) (φ + b) (φ + b')
      rw [← hd', h2, h1, h1', show φ + b - (φ + b') = b - b' by ring] at this
      nlinarith
    · rw [dist_comm]; exact hoff1 z' z hz1' hzC' hz1 hzC h1'
  · exact hoff1 z z' hz1 hzC hz1' hzC' h1

/-- The away bend's circle: positive squared radius `1 − 2d cos h + d²`, its half-plane threshold below the radius (so the arc is
non-degenerate), and radius `≠ 1` (so it is not a unit arc), for `0 < d ≤ 1/10`, `0 < h ≤ 30°`. -/
theorem away_circle_facts {d h : ℝ} (hd : 0 < d) (hd10 : d ≤ 1 / 10) (hh : 0 < h) (hh6 : h ≤ π / 6) :
    0 < 1 - 2 * d * Real.cos h + d ^ 2 ∧ (Real.cos h - d) / √(1 - 2 * d * Real.cos h + d ^ 2) < 1 ∧
      √(1 - 2 * d * Real.cos h + d ^ 2) ≠ 1 := by
  have hπ := Real.pi_pos
  have hc1 := Real.cos_le_one h
  have hcosh2 : 1 / 2 < Real.cos h := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi hh.le (by linarith) (show h < π / 3 by linarith)
    rwa [Real.cos_pi_div_three] at this
  have hpos : 0 < 1 - 2 * d * Real.cos h + d ^ 2 := by nlinarith
  refine ⟨hpos, ?_, ?_⟩
  · rw [div_lt_one (Real.sqrt_pos.2 hpos)]
    refine Real.lt_sqrt_of_sq_lt ?_
    have : Real.cos h ^ 2 < 1 := by
      have hsin : 0 < Real.sin h := Real.sin_pos_of_pos_of_lt_pi hh (by linarith)
      nlinarith [Real.sin_sq_add_cos_sq h]
    nlinarith
  · intro h1
    have : (√(1 - 2 * d * Real.cos h + d ^ 2)) ^ 2 = 1 := by rw [h1]; norm_num
    rw [Real.sq_sqrt hpos.le] at this
    nlinarith

/-! ### Spec examples for the cut and the bend -/

/-- The cut's piece ends: `max θa (θ₂ + 2πm)` and `min θb (θ₁ + 2π(m + 1))`. -/
example : cutLo 1 0 0 = 1 ∧ cutHi 0 1 0 = 1 := by
  have hπ := Real.pi_gt_three
  refine ⟨by norm_num [cutLo], ?_⟩
  simp only [cutHi, Int.cast_zero, zero_add, one_mul]
  exact min_eq_left (by linarith)

/-- Cutting `r((π/3, 2π/3))` out of `unitArcPlane`'s arc `r([0, π])` leaves the piece `r([2π/3, π])` (`m = 0`) and removes the
whole arc. -/
example : Arc.circ 0 1 (2 * π / 3) π ∈ unitArcPlane.cutArcs 0 (π / 3) (2 * π / 3) ∧
    Arc.circ 0 1 0 π ∉ unitArcPlane.cutArcs 0 (π / 3) (2 * π / 3) := by
  have hπ := Real.pi_pos
  refine ⟨Or.inr ⟨0, π, rfl, 0, ?_, ?_⟩, ?_⟩
  · simp only [cutLo, cutHi, Int.cast_zero, zero_mul, add_zero, zero_add, one_mul]
    rw [max_eq_right (by positivity), min_eq_left (by linarith)]
    linarith
  · simp only [cutLo, cutHi, Int.cast_zero, zero_mul, add_zero, zero_add, one_mul]
    rw [max_eq_right (by positivity), min_eq_left (by linarith)]
  · rintro (⟨-, hne⟩ | ⟨θa, θb, ha, m, -, heq⟩)
    · exact hne 0 π rfl
    · have ha' : Arc.circ 0 1 θa θb = Arc.circ 0 1 0 π := ha
      simp only [Arc.circ.injEq, true_and] at ha'
      obtain ⟨rfl, rfl⟩ := ha'
      simp only [Arc.circ.injEq, true_and, cutLo, cutHi] at heq
      obtain ⟨h1, h2⟩ := heq
      have h1' : 2 * π / 3 + m * (2 * π) ≤ 0 := by
        have := le_max_right (0 : ℝ) (2 * π / 3 + m * (2 * π)); linarith
      have h2' : π ≤ π / 3 + (m + 1) * (2 * π) := by
        have := min_le_right π (π / 3 + (m + 1) * (2 * π)); linarith
      have hm1 : (m : ℝ) < 0 := by
        by_contra h0; push Not at h0
        have := mul_nonneg h0 (by positivity : (0 : ℝ) ≤ 2 * π); linarith
      have hm2 : m ≤ -1 := by
        have : m < 0 := by exact_mod_cast hm1
        omega
      have hm3 : (m : ℝ) + 1 ≤ 0 := by
        have : (m : ℝ) ≤ -1 := by exact_mod_cast hm2
        linarith
      have := mul_nonpos_of_nonpos_of_nonneg hm3 (by positivity : (0 : ℝ) ≤ 2 * π)
      linarith

/-- The bend's colouring is `j` on the lens and `F`'s colour off it. -/
example : (ArcMap.const univ isOpen_univ (0 : Fin 2)).bendCol {0} 1 0 = 1 ∧
    (ArcMap.const univ isOpen_univ (0 : Fin 2)).bendCol {0} 1 1 = 0 := by
  refine ⟨bendCol_of_mem _ rfl, ?_⟩
  rw [bendCol_of_not_mem _ (by simp)]
  rfl

/-- The bent map's arcs are the cut and the new arc, its colouring the bend's. -/
example {k : ℕ} (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (a : Arc) (L : Set ℂ) (j : Fin k) (ha : a.Nondegenerate)
    (hlc : ∀ x ∈ F.dom, x ∉ ⋃ b ∈ F.cutArcs P θ₁ θ₂ ∪ {a}, b.carrier → ∀ᶠ y in 𝓝 x, F.bendCol L j y = F.bendCol L j x) :
    (F.bendMap P θ₁ θ₂ a L j ha hlc).arcs = F.cutArcs P θ₁ θ₂ ∪ {a} ∧ (F.bendMap P θ₁ θ₂ a L j ha hlc).col = F.bendCol L j ∧
      (F.bendMap P θ₁ θ₂ a L j ha hlc).dom = F.dom :=
  ⟨rfl, rfl, rfl⟩

end Bend

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
  have h12 : θ₁ < θ₂ := hA.1
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh6 : h ≤ π / 6 := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by linarith
  have hcosh : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  -- the outer class keeps a positive distance from `P`
  obtain ⟨r, hr, hrc⟩ : ∃ r > 0, ∀ y ∈ F.region c', r ≤ dist y P := by
    have : P ∉ closure (F.region c') := hout
    rw [Metric.mem_closure_iff] at this
    push Not at this
    obtain ⟨r, hr, hr'⟩ := this
    exact ⟨r, hr, fun y hy => by rw [dist_comm]; exact hr' y hy⟩
  obtain ⟨ψ₁, hψ₁, henv⟩ := n2_env_toward P h12 hℓ hr
  obtain ⟨ψ₂, hψ₂, hnear⟩ := n2_env_near P h12 hℓ
  set d := min (min ψ₁ ψ₂) ε / 4 with hddef
  have hd : 0 < d := by positivity
  have hd1 : 2 * d ≤ ψ₁ := by have := min_le_left (min ψ₁ ψ₂) ε; have := min_le_left ψ₁ ψ₂; rw [hddef]; linarith
  have hd2 : 2 * d ≤ ψ₂ := by have := min_le_left (min ψ₁ ψ₂) ε; have := min_le_right ψ₁ ψ₂; rw [hddef]; linarith
  have hdε : 2 * d * h < ε := by
    have := min_le_right (min ψ₁ ψ₂) ε
    have h1 : 2 * d ≤ ε / 2 := by rw [hddef]; linarith
    have h2 : h < 1 := by linarith [Real.pi_lt_four]
    nlinarith
  set C := P - (d : ℂ) * e φ with hCdef
  set L : Set ℂ := {z | dist z P ≤ 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 < dist z C ^ 2} with hLdef
  set R := √(1 + 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 + 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt (by positivity)
  set a := Arc.circ C R (φ - Real.arccos ((d + Real.cos h) / R)) (φ + Real.arccos ((d + Real.cos h) / R)) with hadef
  have hcar : a.carrier = {z | dist z C = R ∧ dist z P ≤ 1} := toward_carrier P hd hcosh
  set O := ringPt P '' Ioo θ₁ θ₂ with hOdef
  set U := thickening ε (ringArc P θ₁ θ₂) with hUdef
  -- the arc's points against the bending circle
  have hring : ∀ θ, dist (ringPt P θ) C ^ 2 = 1 + 2 * d * Real.cos (θ - φ) + d ^ 2 := by
    intro θ; rw [hCdef, dist_sq_sub_dir, re_frameDir_ringPt, dist_ringPt]; ring
  have hOL : O ⊆ L := by
    rintro _ ⟨θ, hθ, rfl⟩
    refine ⟨(dist_ringPt P θ).le, ?_⟩
    rw [hring]
    have habs : |θ - φ| < h := abs_lt.mpr ⟨by rw [hφdef, hhdef]; linarith [hθ.1], by rw [hφdef, hhdef]; linarith [hθ.2]⟩
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) habs
    rw [Real.cos_abs] at this
    nlinarith
  have hend : ∀ θ, (θ = θ₁ ∨ θ = θ₂) → ringPt P θ ∈ a.carrier := by
    intro θ hθ
    rw [hcar]
    refine ⟨?_, (dist_ringPt P θ).le⟩
    have hc : Real.cos (θ - φ) = Real.cos h := by
      rcases hθ with h1 | h1 <;> rw [h1]
      · rw [show θ₁ - φ = -h by rw [hφdef, hhdef]; ring, Real.cos_neg]
      · rw [show θ₂ - φ = h by rw [hφdef, hhdef]; ring]
    have := hring θ
    rw [hc, ← hRsq] at this
    exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp this
  -- polar forms
  have hpolI : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Icc θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).2]⟩
  have hpolO : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| < h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Ioo θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).2]⟩
  have hU1 : ∀ z, dist z P ≤ 1 → |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      1 - dist z P ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) → z ∈ U := by
    intro z hz1 hb hs
    refine mem_thickening_ringArc_of_polar (hpolI z hb) (eq_polar_frameDir P z φ) ?_
    rw [abs_of_nonneg (by linarith)]
    have : 0 ≤ |arg ((z - P) * starRingEnd ℂ (e φ))| := abs_nonneg _
    nlinarith
  have hLU : L ⊆ U := fun z hz => by
    obtain ⟨hb, hs⟩ := toward_polar_strict hd hh hh2 hz.1 hz.2
    exact hU1 z hz.1 hb.le hs.le
  have haU : a.carrier ⊆ U := fun z hz => by
    rw [hcar] at hz
    obtain ⟨hb, hs⟩ := toward_polar hd hh hh2 hz.2 (by rw [hz.1, hRsq])
    exact hU1 z hz.2 hb hs
  have hαU : ringArc P θ₁ θ₂ ⊆ U := self_subset_thickening hε _
  have haO : Disjoint a.carrier O := by
    rw [Set.disjoint_left]
    intro z hz hzO
    rw [hcar] at hz
    have := (hOL hzO).2
    rw [hz.1, hRsq] at this
    exact lt_irrefl _ this
  have hcl : closure L ⊆ L ∪ a.carrier := by
    have hK : IsClosed {z : ℂ | dist z P ≤ 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 ≤ dist z C ^ 2} :=
      (isClosed_le (continuous_id.dist continuous_const) continuous_const).inter
        (isClosed_le continuous_const ((continuous_id.dist continuous_const).pow 2))
    intro z hz
    obtain ⟨hz1, hz2⟩ := closure_minimal (show L ⊆ {z : ℂ | dist z P ≤ 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 ≤ dist z C ^ 2}
      from fun y hy => ⟨hy.1, hy.2.le⟩) hK hz
    rcases lt_or_eq_of_le hz2 with hlt | heq
    · exact Or.inl ⟨hz1, hlt⟩
    · refine Or.inr ?_
      rw [hcar]
      refine ⟨?_, hz1⟩
      rw [← hRsq] at heq
      exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp heq.symm
  have hLsph : ∀ x ∈ L, x ∈ sphere P 1 → x ∈ O := by
    intro x hx hsph
    rw [mem_sphere] at hsph
    obtain ⟨hb, -⟩ := toward_polar_strict hd hh hh2 hx.1 hx.2
    refine ⟨_, hpolO x hb, ?_⟩
    have := eq_polar_frameDir P x φ
    rw [hsph, Complex.ofReal_one, one_mul] at this
    rw [ringPt, ← this]
  have hLopen : ∀ x ∈ L, x ∉ sphere P 1 → L ∈ 𝓝 x := by
    intro x hx hsph
    have hlt : dist x P < 1 := lt_of_le_of_ne hx.1 hsph
    have hopen : IsOpen {z : ℂ | dist z P < 1 ∧ 1 + 2 * d * Real.cos h + d ^ 2 < dist z C ^ 2} :=
      (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
        (isOpen_lt continuous_const ((continuous_id.dist continuous_const).pow 2))
    exact Filter.mem_of_superset (hopen.mem_nhds ⟨hlt, hx.2⟩) fun z hz => ⟨hz.1.le, hz.2⟩
  have hS : Disjoint (closedBall P 1)ᶜ (sphere P 1) :=
    Set.disjoint_left.mpr fun z hz hs => hz (sphere_subset_closedBall hs)
  have hside : ∀ x ∈ O, ∀ᶠ y in 𝓝 x, y ∈ L ∨ y ∈ (closedBall P 1)ᶜ := by
    intro x hx
    have hopen : IsOpen {z : ℂ | 1 + 2 * d * Real.cos h + d ^ 2 < dist z C ^ 2} :=
      isOpen_lt continuous_const ((continuous_id.dist continuous_const).pow 2)
    filter_upwards [hopen.mem_nhds (hOL hx).2] with y hy
    by_cases hy1 : dist y P ≤ 1
    · exact Or.inl ⟨hy1, hy⟩
    · exact Or.inr fun h' => hy1 (mem_closedBall.mp h')
  have hcol : ∀ x ∈ O, ∀ i, i ≠ c' → x ∉ closure (F.region i ∩ (closedBall P 1)ᶜ) := by
    rintro _ ⟨θ, hθ, rfl⟩ i hi hcl'
    have hout' := (hA.2.2 θ hθ).2
    have : i ∈ F.outerColours P (ringPt P θ) := by rw [outerColours, mem_setOf_eq, Set.sdiff_eq]; exact hcl'
    rw [hout'] at this
    exact hi this
  have hclear : ∀ z ∈ L, F.IsClear c' z := by
    intro z hz
    by_cases hsph : dist z P = 1
    · obtain ⟨θ, hθ, rfl⟩ := hLsph z hz (mem_sphere.mpr hsph)
      have hcl' : ringPt P θ ∈ closure (F.region c') := by
        have : c' ∈ F.outerColours P (ringPt P θ) := by rw [(hA.2.2 θ hθ).2]; rfl
        exact closure_mono sdiff_subset this
      intro y hy hzy
      exact ne1_region hF hcl' hy (by rw [dist_comm]; exact hzy)
    · obtain ⟨hb, hs⟩ := toward_polar_strict hd hh hh2 hz.1 hz.2
      set b := arg ((z - P) * starRingEnd ℂ (e φ)) with hbdef
      have hs0 : 0 < 1 - dist z P := by have := lt_of_le_of_ne hz.1 hsph; linarith
      have hmin : min (φ + b - θ₁) (θ₂ - (φ + b)) = h - |b| := by
        rw [show φ + b - θ₁ = h + b by rw [hφdef, hhdef]; ring, show θ₂ - (φ + b) = h - b by rw [hφdef, hhdef]; ring]
        exact min_add_sub_eq h b
      have hzeq : z = P + (1 - ((1 - dist z P : ℝ) : ℂ)) * e (φ + b) := by
        have := eq_polar_frameDir P z φ
        rw [← hbdef] at this
        calc z = P + (dist z P : ℂ) * e (φ + b) := this
          _ = _ := by push_cast; ring
      have hΔ : 0 ≤ h - |b| := by linarith
      rw [hzeq]
      refine F.toward_clear hF hA hrc henv hnear (hpolO z hb) hs0 ?_ ?_ <;> rw [hmin]
      · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd1 hΔ)).le
      · exact (hs.trans_le (mul_le_mul_of_nonneg_right hd2 hΔ)).le
  have hLL : ∀ z ∈ L, ∀ z' ∈ L, dist z z' ≠ 1 := fun z hz z' hz' => toward_pairs hd hh hh6 hz.1 hz.2 hz'.1 hz'.2
  have hdom : O ⊆ F.dom := fun x hx => (hA.2.1 (image_mono Ioo_subset_Icc_self hx)).1
  have hRpos : 0 < R := Real.sqrt_pos.2 (by positivity)
  have hκ : (d + Real.cos h) / R < 1 := by
    rw [div_lt_one hRpos]
    refine Real.lt_sqrt_of_sq_lt ?_
    have : Real.cos h ^ 2 < 1 := by
      have hsin : 0 < Real.sin h := Real.sin_pos_of_pos_of_lt_pi hh (by linarith)
      nlinarith [Real.sin_sq_add_cos_sq h]
    nlinarith
  have ha : a.Nondegenerate := ⟨hRpos, by have := Real.arccos_pos.mpr hκ; linarith,
    by have := Real.arccos_le_pi ((d + Real.cos h) / R); linarith⟩
  have hau : ¬ a.IsUnitArc := by
    intro h1
    change R = 1 at h1
    have : R ^ 2 = 1 := by rw [h1]; norm_num
    rw [hRsq] at this
    nlinarith
  have hlc := F.bend_hlc (a := a) (L := L) (S := (closedBall P 1)ᶜ) (j := c') hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hcl hLsph hLopen hS hside hcol
  refine ⟨F.bendMap P θ₁ θ₂ a L c' ha hlc, bendMap_valid hF h12 hLU haU hαU hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hclear hLL, bendMap_agreesOff h12 hLU haU hαU, bendMap_ringArcsWithin hau,
    bendMap_not_onRingArc hdom haO, (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).1, fun z hz => ?_⟩
  rcases (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).2 hz with h1 | h1
  · exact Or.inl h1
  · exact Or.inr ⟨hLU h1, mem_closedBall.mpr h1.1⟩

/-- **FS112-N2-BENDS**, the away bend as the row states it (N2-AWAY): if the inner colour is not carried at the centre and no point of
the radius-2 arc `R₂(ᾱ)` lies in the closure of its class, the whole arc bends away — no interior point of it is left on an arc of
`Γ` on `ω(P)`. Proved directly on the away lens (`bendMap` with the circle about `P + d e(φ_m)` through the arc's ends), with no domain
hypothesis: the inner class keeps a positive distance from `P` and from the compact `R₂(ᾱ)`. -/
theorem bend_away_whole (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hin : c ∉ F.coloursAt P) (hR2 : Disjoint (radiusTwoArc P θ₁ θ₂) (closure (F.region c))) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ F'.OnRingArc P (ringPt P θ)) ∧ (∀ j, j ≠ c → F'.region j ⊆ F.region j) ∧
      F'.region c ⊆ F.region c ∪ (thickening ε (ringArc P θ₁ θ₂) \ ball P 1) := by
  have h12 : θ₁ < θ₂ := hA.1
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  set φ := (θ₁ + θ₂) / 2 with hφdef
  set h := (θ₂ - θ₁) / 2 with hhdef
  have hh : 0 < h := by rw [hhdef]; linarith
  have hh6 : h ≤ π / 6 := by rw [hhdef]; linarith
  have hh2 : h < π / 2 := by linarith
  have hcosh : 0 < Real.cos h := Real.cos_pos_of_mem_Ioo ⟨by linarith, hh2⟩
  -- the inner class keeps a positive distance from `P` and from `R₂(ᾱ)`
  obtain ⟨r₁, hr₁, hr₁c⟩ : ∃ r > 0, ∀ y ∈ F.region c, r ≤ dist y P := by
    have : P ∉ closure (F.region c) := hin
    rw [Metric.mem_closure_iff] at this
    push Not at this
    obtain ⟨r, hr, hr'⟩ := this
    exact ⟨r, hr, fun y hy => by rw [dist_comm]; exact hr' y hy⟩
  have hK : IsCompact (radiusTwoArc P θ₁ θ₂) := isCompact_Icc.image (by unfold e; fun_prop)
  obtain ⟨r₂, hr₂, hr₂c⟩ := hK.exists_thickening_subset_open isClosed_closure.isOpen_compl
    (fun x hx hcl => Set.disjoint_left.mp hR2 hx hcl)
  set r := min (min r₁ r₂) (1 / 2) with hrdef
  have hr : 0 < r := by positivity
  have hrc : ∀ y ∈ F.region c, r ≤ dist y P := fun y hy =>
    le_trans (le_trans (min_le_left _ _) (min_le_left _ _)) (hr₁c y hy)
  have hr2c : ∀ y ∈ F.region c, y ∉ thickening r (radiusTwoArc P θ₁ θ₂) := fun y hy hyt =>
    hr₂c (thickening_mono (le_trans (min_le_left _ _) (min_le_right _ _)) _ hyt) (subset_closure hy)
  obtain ⟨ψ₁, hψ₁, henv⟩ := n2_env_away P h12 hℓ hr
  obtain ⟨ψ₂, hψ₂, hnear⟩ := n2_env_near_away P h12 hℓ hr
  set d := min (min (min ψ₁ ψ₂) ε) (1 / 2) / 5 with hddef
  have hd : 0 < d := by positivity
  have hm1 := min_le_left (min (min ψ₁ ψ₂) ε) (1 / 2)
  have hm2 := min_le_right (min (min ψ₁ ψ₂) ε) (1 / 2)
  have hm3 := min_le_left (min ψ₁ ψ₂) ε
  have hm4 := min_le_right (min ψ₁ ψ₂) ε
  have hd1 : 2 * d ≤ ψ₁ := by have := min_le_left ψ₁ ψ₂; rw [hddef]; linarith
  have hd2 : 2 * d ≤ ψ₂ := by have := min_le_right ψ₁ ψ₂; rw [hddef]; linarith
  have hd10 : d ≤ 1 / 10 := by rw [hddef]; linarith
  have hdh : d ≤ 1 / 2 := by linarith
  have hdε : 2 * d * h < ε := by
    have h1 : 2 * d ≤ ε / 2 := by rw [hddef]; linarith
    have h2 : h < 1 := by linarith [Real.pi_lt_four]
    nlinarith
  obtain ⟨hpos, hκ, hR1⟩ := away_circle_facts hd hd10 hh hh6
  set C := P + (d : ℂ) * e φ with hCdef
  set L : Set ℂ := {z | 1 ≤ dist z P ∧ dist z C ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2} with hLdef
  set R := √(1 - 2 * d * Real.cos h + d ^ 2) with hRdef
  have hRsq : R ^ 2 = 1 - 2 * d * Real.cos h + d ^ 2 := Real.sq_sqrt hpos.le
  set a := Arc.circ C R (φ - Real.arccos ((Real.cos h - d) / R)) (φ + Real.arccos ((Real.cos h - d) / R)) with hadef
  have hcar : a.carrier = {z | dist z C = R ∧ 1 ≤ dist z P} := away_carrier P hd hpos
  set O := ringPt P '' Ioo θ₁ θ₂ with hOdef
  set U := thickening ε (ringArc P θ₁ θ₂) with hUdef
  have hring : ∀ θ, dist (ringPt P θ) C ^ 2 = 1 - 2 * d * Real.cos (θ - φ) + d ^ 2 := by
    intro θ; rw [hCdef, dist_sq_add_dir, re_frameDir_ringPt, dist_ringPt]; ring
  have hOL : O ⊆ L := by
    rintro _ ⟨θ, hθ, rfl⟩
    refine ⟨(dist_ringPt P θ).ge, ?_⟩
    rw [hring]
    have habs : |θ - φ| < h := abs_lt.mpr ⟨by rw [hφdef, hhdef]; linarith [hθ.1], by rw [hφdef, hhdef]; linarith [hθ.2]⟩
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) habs
    rw [Real.cos_abs] at this
    nlinarith
  have hend : ∀ θ, (θ = θ₁ ∨ θ = θ₂) → ringPt P θ ∈ a.carrier := by
    intro θ hθ
    rw [hcar]
    refine ⟨?_, (dist_ringPt P θ).ge⟩
    have hc : Real.cos (θ - φ) = Real.cos h := by
      rcases hθ with h1 | h1 <;> rw [h1]
      · rw [show θ₁ - φ = -h by rw [hφdef, hhdef]; ring, Real.cos_neg]
      · rw [show θ₂ - φ = h by rw [hφdef, hhdef]; ring]
    have := hring θ
    rw [hc, ← hRsq] at this
    exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp this
  have hpolI : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Icc θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_le.mp hb).2]⟩
  have hpolO : ∀ z, |arg ((z - P) * starRingEnd ℂ (e φ))| < h →
      φ + arg ((z - P) * starRingEnd ℂ (e φ)) ∈ Ioo θ₁ θ₂ := fun z hb =>
    ⟨by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).1], by rw [hφdef]; rw [hhdef] at hb; linarith [(abs_lt.mp hb).2]⟩
  have hU1 : ∀ z, 1 ≤ dist z P → |arg ((z - P) * starRingEnd ℂ (e φ))| ≤ h →
      dist z P - 1 ≤ 2 * d * (h - |arg ((z - P) * starRingEnd ℂ (e φ))|) → z ∈ U := by
    intro z hz1 hb hs
    refine mem_thickening_ringArc_of_polar (hpolI z hb) (eq_polar_frameDir P z φ) ?_
    rw [abs_sub_comm, abs_of_nonneg (by linarith)]
    have : 0 ≤ |arg ((z - P) * starRingEnd ℂ (e φ))| := abs_nonneg _
    nlinarith
  have hLU : L ⊆ U := fun z hz => by
    obtain ⟨hb, hs⟩ := away_polar_strict hd hdh hh hh2 hz.1 hz.2
    exact hU1 z hz.1 hb.le hs.le
  have haU : a.carrier ⊆ U := fun z hz => by
    rw [hcar] at hz
    obtain ⟨hb, hs⟩ := away_polar hd hdh hh hh2 hz.2 (by rw [hz.1, hRsq])
    exact hU1 z hz.2 hb hs
  have hαU : ringArc P θ₁ θ₂ ⊆ U := self_subset_thickening hε _
  have haO : Disjoint a.carrier O := by
    rw [Set.disjoint_left]
    intro z hz hzO
    rw [hcar] at hz
    have := (hOL hzO).2
    rw [hz.1, hRsq] at this
    exact lt_irrefl _ this
  have hcl : closure L ⊆ L ∪ a.carrier := by
    have hK' : IsClosed {z : ℂ | 1 ≤ dist z P ∧ dist z C ^ 2 ≤ 1 - 2 * d * Real.cos h + d ^ 2} :=
      (isClosed_le continuous_const (continuous_id.dist continuous_const)).inter
        (isClosed_le ((continuous_id.dist continuous_const).pow 2) continuous_const)
    intro z hz
    obtain ⟨hz1, hz2⟩ := closure_minimal (show L ⊆ {z : ℂ | 1 ≤ dist z P ∧ dist z C ^ 2 ≤ 1 - 2 * d * Real.cos h + d ^ 2}
      from fun y hy => ⟨hy.1, hy.2.le⟩) hK' hz
    rcases lt_or_eq_of_le hz2 with hlt | heq
    · exact Or.inl ⟨hz1, hlt⟩
    · refine Or.inr ?_
      rw [hcar]
      refine ⟨?_, hz1⟩
      rw [← hRsq] at heq
      exact (pow_left_inj₀ dist_nonneg (Real.sqrt_nonneg _) two_ne_zero).mp heq
  have hLsph : ∀ x ∈ L, x ∈ sphere P 1 → x ∈ O := by
    intro x hx hsph
    rw [mem_sphere] at hsph
    obtain ⟨hb, -⟩ := away_polar_strict hd hdh hh hh2 hx.1 hx.2
    refine ⟨_, hpolO x hb, ?_⟩
    have := eq_polar_frameDir P x φ
    rw [hsph, Complex.ofReal_one, one_mul] at this
    rw [ringPt, ← this]
  have hLopen : ∀ x ∈ L, x ∉ sphere P 1 → L ∈ 𝓝 x := by
    intro x hx hsph
    have hlt : 1 < dist x P := lt_of_le_of_ne hx.1 (Ne.symm hsph)
    have hopen : IsOpen {z : ℂ | 1 < dist z P ∧ dist z C ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2} :=
      (isOpen_lt continuous_const (continuous_id.dist continuous_const)).inter
        (isOpen_lt ((continuous_id.dist continuous_const).pow 2) continuous_const)
    exact Filter.mem_of_superset (hopen.mem_nhds ⟨hlt, hx.2⟩) fun z hz => ⟨hz.1.le, hz.2⟩
  have hS : Disjoint (ball P 1) (sphere P 1) :=
    Set.disjoint_left.mpr fun z hz hs => by rw [mem_ball] at hz; rw [mem_sphere] at hs; linarith
  have hside : ∀ x ∈ O, ∀ᶠ y in 𝓝 x, y ∈ L ∨ y ∈ ball P 1 := by
    intro x hx
    have hopen : IsOpen {z : ℂ | dist z C ^ 2 < 1 - 2 * d * Real.cos h + d ^ 2} :=
      isOpen_lt ((continuous_id.dist continuous_const).pow 2) continuous_const
    filter_upwards [hopen.mem_nhds (hOL hx).2] with y hy
    by_cases hy1 : 1 ≤ dist y P
    · exact Or.inl ⟨hy1, hy⟩
    · exact Or.inr (mem_ball.mpr (not_le.mp hy1))
  have hcol : ∀ x ∈ O, ∀ i, i ≠ c → x ∉ closure (F.region i ∩ ball P 1) := by
    rintro _ ⟨θ, hθ, rfl⟩ i hi hcl'
    have hin' := (hA.2.2 θ hθ).1
    have : i ∈ F.innerColours P (ringPt P θ) := hcl'
    rw [hin'] at this
    exact hi this
  have hclear : ∀ z ∈ L, F.IsClear c z := fun z hz =>
    F.away_lens_clear hF hA hd hd10 hrc hr2c henv hnear hd1 hd2 hz.1 hz.2
  have hLL : ∀ z ∈ L, ∀ z' ∈ L, dist z z' ≠ 1 := fun z hz z' hz' =>
    away_pairs h12 hℓ hd hd10 (min_le_right _ _) hd2 hnear hz.1 hz.2 hz'.1 hz'.2
  have hdom : O ⊆ F.dom := fun x hx => (hA.2.1 (image_mono Ioo_subset_Icc_self hx)).1
  have hRpos : 0 < R := Real.sqrt_pos.2 hpos
  have ha : a.Nondegenerate := ⟨hRpos, by have := Real.arccos_pos.mpr hκ; linarith,
    by have := Real.arccos_le_pi ((Real.cos h - d) / R); linarith⟩
  have hau : ¬ a.IsUnitArc := fun h1 => hR1 h1
  have hlc := F.bend_hlc (a := a) (L := L) (S := ball P 1) (j := c) hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hcl hLsph hLopen hS hside hcol
  refine ⟨F.bendMap P θ₁ θ₂ a L c ha hlc, bendMap_valid hF h12 hLU haU hαU hOL (hend θ₁ (Or.inl rfl))
    (hend θ₂ (Or.inr rfl)) hclear hLL, bendMap_agreesOff h12 hLU haU hαU, bendMap_ringArcsWithin hau,
    bendMap_not_onRingArc hdom haO, (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).1, fun z hz => ?_⟩
  rcases (bendMap_region hOL (hend θ₁ (Or.inl rfl)) (hend θ₂ (Or.inr rfl))).2 hz with h1 | h1
  · exact Or.inl h1
  · exact Or.inr ⟨hLU h1, fun h' => by rw [mem_ball] at h'; linarith [h1.1]⟩

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

end ArcMap

/-- **The radial points of `ω(N)` from `v`, in the frame at `v`** (child of engine 5): `N + ρ e(α − π/2 + t)` has frame coordinates
`(ρ sin t, 1 − ρ cos t)`, `N = v + e(α + π/2)`; at `ρ = 1` the arc of `ω(N)` leaving `v` along `e α`. -/
theorem normalPt_add_eq_fromFrame (v : ℂ) (α ρ t : ℝ) :
    v + e (α + π / 2) + (ρ : ℂ) * e (α - π / 2 + t) = fromFrame v α (ρ * Real.sin t) (1 - ρ * Real.cos t) := by
  have h1 : e (α + π / 2) = I * e α := e_add_pi_div_two α
  have h2 : e (α - π / 2 + t) = -(I * e α * e t) := by
    have := e_add_pi (α - π / 2 + t)
    rw [show α - π / 2 + t + π = (α + π / 2) + t by ring, e_add, h1] at this
    linear_combination this
  rw [h2, h1, e_eq t]
  unfold fromFrame
  simp only [Complex.ofReal_mul, Complex.ofReal_sub, Complex.ofReal_one]
  linear_combination (-((ρ : ℂ) * (Real.sin t : ℂ) * e α)) * Complex.I_sq

/-- **The radial points of `ω(S′)` from `v`, in the frame at `v`** (child of engine 5, the lower bound): `S′ + ρ e(α + π/2 − t)` has
frame coordinates `(ρ sin t, −(1 − ρ cos t))`, `S′ = v − e(α + π/2)`; at `ρ = 1` the arc of `ω(S′)` leaving `v` along `e α`. -/
theorem normalPt_sub_add_eq_fromFrame (v : ℂ) (α ρ t : ℝ) :
    v - e (α + π / 2) + (ρ : ℂ) * e (α + π / 2 - t) = fromFrame v α (ρ * Real.sin t) (-(1 - ρ * Real.cos t)) := by
  have h1 : e (α + π / 2) = I * e α := e_add_pi_div_two α
  have h2 : e (α + π / 2 - t) = I * e α * e (-t) := by
    rw [show α + π / 2 - t = (α + π / 2) + -t by ring, e_add, h1]
  rw [h2, h1, e_eq (-t), Real.cos_neg, Real.sin_neg]
  unfold fromFrame
  simp only [Complex.ofReal_mul, Complex.ofReal_sub, Complex.ofReal_one, Complex.ofReal_neg]
  linear_combination (-((ρ : ℂ) * (Real.sin t : ℂ) * e α)) * Complex.I_sq

/-- The angle, measured from `arg u`, at which the circle of radius `2` about `0` meets `ω(u)` going counter-clockwise. -/
noncomputable def r2Cross (u : ℂ) : ℝ := Complex.arg u + Real.arccos ((3 + ‖u‖ ^ 2) / (4 * ‖u‖))

/-- The squared distance from `2 e(t)` to `u`, by the angle from `arg u`. -/
theorem sq_norm_two_e_sub (u : ℂ) (t : ℝ) :
    ‖2 * e t - u‖ ^ 2 = 4 + ‖u‖ ^ 2 - 4 * ‖u‖ * Real.cos (t - Complex.arg u) := by
  have hu : u = (‖u‖ : ℂ) * e (Complex.arg u) := by
    rw [e]; exact (Complex.norm_mul_exp_arg_mul_I u).symm
  conv_lhs => rw [hu]
  rw [Complex.sq_norm, Complex.normSq_apply, e_eq, e_eq]
  simp only [Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.add_re, Complex.add_im, Complex.I_re, Complex.I_im, Complex.re_ofNat, Complex.im_ofNat]
  rw [Real.cos_sub]
  have h1 := Real.cos_sq_add_sin_sq t
  have h2 := Real.cos_sq_add_sin_sq (Complex.arg u)
  nlinarith [h1, h2]

/-- **The crossing of `ω(u)` with the circle of radius `2`** (child of FLANK-Q's shadow clause): for `1 < ‖u‖ < 3` above the real
axis, the angle `r2Cross u` lies in `(0, arg u + π/2)`, the point `2 e(t)` is inside `ω(u)` for `t` between `arg u` and it, and outside
for `t` between it and `arg u + π`. -/
theorem r2Cross_spec {u : ℂ} (h1 : 1 < ‖u‖) (h3 : ‖u‖ < 3) (him : 0 < u.im) :
    0 < Complex.arg u ∧ Complex.arg u < r2Cross u ∧ r2Cross u < Complex.arg u + π / 2 ∧
      (∀ t, Complex.arg u < t → t < r2Cross u → ‖2 * e t - u‖ < 1) ∧
      (∀ t, r2Cross u < t → t < Complex.arg u + π → 1 < ‖2 * e t - u‖) := by
  have hπ := Real.pi_pos
  set ρ := ‖u‖ with hρ
  set x := (3 + ρ ^ 2) / (4 * ρ) with hx
  have hρ0 : 0 < ρ := by linarith
  have hx0 : 0 < x := by positivity
  have hx1 : x < 1 := by
    rw [hx, div_lt_one (by positivity)]; nlinarith
  have harg0 : 0 < Complex.arg u := by
    rcases (Complex.arg_nonneg_iff.mpr him.le).lt_or_eq with h | h
    · exact h
    · exfalso
      have := (Complex.arg_eq_zero_iff.mp h.symm).2
      linarith
  have hargπ : Complex.arg u < π := by
    rcases (Complex.arg_le_pi u).lt_or_eq with h | h
    · exact h
    · exfalso
      have := (Complex.arg_eq_pi_iff.mp h).2
      linarith
  set Δ := Real.arccos x with hΔ
  have hΔ0 : 0 < Δ := Real.arccos_pos.mpr hx1
  have hΔ1 : Δ < π / 2 := Real.arccos_lt_pi_div_two.mpr hx0
  have hcosΔ : Real.cos Δ = x := Real.cos_arccos (by linarith) hx1.le
  have hsc : r2Cross u = Complex.arg u + Δ := rfl
  refine ⟨harg0, by rw [hsc]; linarith, by rw [hsc]; linarith, ?_, ?_⟩
  · intro t ht1 ht2
    rw [hsc] at ht2
    have hlt : x < Real.cos (t - Complex.arg u) := by
      rw [← hcosΔ]
      exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith) (by linarith) (by linarith)
    have hsq := sq_norm_two_e_sub u t
    have hxρ : 4 * ρ * x = 3 + ρ ^ 2 := by rw [hx]; field_simp
    have : ‖2 * e t - u‖ ^ 2 < 1 := by rw [hsq]; nlinarith
    nlinarith [norm_nonneg (2 * e t - u)]
  · intro t ht1 ht2
    rw [hsc] at ht1
    have hlt : Real.cos (t - Complex.arg u) < x := by
      rw [← hcosΔ]
      exact Real.cos_lt_cos_of_nonneg_of_le_pi hΔ0.le (by linarith) (by linarith)
    have hsq := sq_norm_two_e_sub u t
    have hxρ : 4 * ρ * x = 3 + ρ ^ 2 := by rw [hx]; field_simp
    have : 1 < ‖2 * e t - u‖ ^ 2 := by rw [hsq]; nlinarith
    nlinarith [norm_nonneg (2 * e t - u)]

/-- `r2Cross` is continuous at `u = 1` (so it tends to `r2Cross 1 = 0` there). -/
theorem continuousAt_r2Cross_one : ContinuousAt r2Cross 1 := by
  unfold r2Cross
  refine (Complex.continuousAt_arg (by simp [Complex.mem_slitPlane_iff])).add ?_
  refine Real.continuous_arccos.continuousAt.comp ?_
  refine ContinuousAt.div (by fun_prop) (by fun_prop) (by simp)

/-- At `u = 1` the crossing angle is `0`. -/
theorem r2Cross_one : r2Cross 1 = 0 := by
  simp only [r2Cross, Complex.arg_one, norm_one]
  norm_num



/-- **A nondegenerate arc meets the circle of radius `2` about `C` finitely, or lies on it** (the homothety `z ↦ (z + C)/2`, which takes
that circle to `ω(C)` and arcs to arcs, carried through `Arc.finite_inter_sphere_or_eq_circ`). -/
theorem Arc.finite_inter_sphere_two_or_subset (a : Arc) (ha : a.Nondegenerate) (C : ℂ) :
    (a.carrier ∩ sphere C 2).Finite ∨ a.carrier ⊆ sphere C 2 := by
  have hinj : Function.Injective (fun z : ℂ => (z + C) / 2) := by
    intro z w h; simp only at h; linear_combination 2 * h
  have hsph : ∀ z, z ∈ sphere C 2 ↔ (z + C) / 2 ∈ sphere C 1 := by
    intro z
    rw [mem_sphere, mem_sphere, dist_eq_norm, dist_eq_norm,
      show (z + C) / 2 - C = (z - C) / 2 by ring, norm_div]
    simp only [Complex.norm_ofNat]
    constructor <;> intro h <;> linarith
  cases a with
  | seg p q =>
    left
    have hnd : (Arc.seg ((p + C) / 2) ((q + C) / 2)).Nondegenerate := by
      intro h; exact ha (hinj h)
    rcases Arc.finite_inter_sphere_or_eq_circ _ hnd C with h | ⟨θ₀, θ₁, h⟩
    · refine (h.preimage hinj.injOn).subset ?_
      rintro z ⟨hz, hzs⟩
      refine ⟨?_, (hsph z).mp hzs⟩
      obtain ⟨s, t, hs, ht, hst, rfl⟩ := hz
      refine ⟨s, t, hs, ht, hst, ?_⟩
      simp only [Complex.real_smul]
      linear_combination (C / 2) * (by exact_mod_cast hst : ((s : ℂ) + t) = 1)
    · cases h
  | circ c ρ θ₀ θ₁ =>
    obtain ⟨hρ, h01, h01'⟩ := ha
    have hnd : (Arc.circ ((c + C) / 2) (ρ / 2) θ₀ θ₁).Nondegenerate := ⟨by linarith, h01, h01'⟩
    rcases Arc.finite_inter_sphere_or_eq_circ _ hnd C with h | ⟨θa, θb, h⟩
    · left
      refine (h.preimage hinj.injOn).subset ?_
      rintro z ⟨hz, hzs⟩
      refine ⟨?_, (hsph z).mp hzs⟩
      obtain ⟨θ, hθ, rfl⟩ := hz
      refine ⟨θ, hθ, ?_⟩
      simp only; push_cast; ring
    · right
      simp only [Arc.circ.injEq] at h
      obtain ⟨hc, hρ2, -, -⟩ := h
      have hcC : c = C := by linear_combination 2 * hc
      have hρ' : ρ = 2 := by linarith
      rintro z ⟨θ, -, rfl⟩
      rw [mem_sphere, dist_eq_norm, hcC, hρ', add_sub_cancel_left, norm_mul, norm_e]
      simp

/-- Spec: at `u = 2` (norm `2`, argument `0`) the crossing angle is `arccos (7/8)`. -/
example : r2Cross 2 = Real.arccos (7 / 8) := by
  simp only [r2Cross, Complex.norm_ofNat]
  norm_num

/-- `cos(m·60°)` is positive when `m ≡ 0, ±1 (mod 6)`. -/
theorem cos_int_mul_third_pos {m : ℤ} (h : m % 6 = 0 ∨ m % 6 = 1 ∨ m % 6 = 5) : 0 < Real.cos (m * (π / 3)) := by
  have hm : (m : ℝ) * (π / 3) = ((m % 6 : ℤ) : ℝ) * (π / 3) + ((m / 6 : ℤ) : ℝ) * (2 * π) := by
    have := Int.emod_add_mul_ediv m 6
    have h' : ((m % 6 : ℤ) : ℝ) + 6 * ((m / 6 : ℤ) : ℝ) = m := by exact_mod_cast this
    rw [← h']; ring
  rw [hm, Real.cos_add_int_mul_two_pi]
  rcases h with h | h | h <;> rw [h] <;> push_cast
  · simp
  · rw [one_mul, Real.cos_pi_div_three]; norm_num
  · rw [show (5 : ℝ) * (π / 3) = -(π / 3) + (1 : ℤ) * (2 * π) by push_cast; ring, Real.cos_add_int_mul_two_pi,
      Real.cos_neg, Real.cos_pi_div_three]; norm_num

/-- `cos(m·60°)` is negative when `m ≡ 2, 3, 4 (mod 6)`. -/
theorem cos_int_mul_third_neg {m : ℤ} (h : m % 6 = 2 ∨ m % 6 = 3 ∨ m % 6 = 4) : Real.cos (m * (π / 3)) < 0 := by
  have hm : (m : ℝ) * (π / 3) = ((m % 6 : ℤ) : ℝ) * (π / 3) + ((m / 6 : ℤ) : ℝ) * (2 * π) := by
    have := Int.emod_add_mul_ediv m 6
    have h' : ((m % 6 : ℤ) : ℝ) + 6 * ((m / 6 : ℤ) : ℝ) = m := by exact_mod_cast this
    rw [← h']; ring
  rw [hm, Real.cos_add_int_mul_two_pi]
  rcases h with h | h | h <;> rw [h] <;> push_cast
  · rw [show (2 : ℝ) * (π / 3) = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]; norm_num
  · rw [show (3 : ℝ) * (π / 3) = π by ring, Real.cos_pi]; norm_num
  · rw [show (4 : ℝ) * (π / 3) = π / 3 + π by ring, Real.cos_add_pi, Real.cos_pi_div_three]; norm_num

/-- **The sign table of NB-4's last step**: for distinct orbit indices `j ≠ l` and a parity `p`, some `k ∈ {p, p + 2, p + 4}` sees
`r(ψ + j·60°)` and `r(ψ + l·60°)` on opposite sides — `cos((j − k)·60°)` and `cos((l − k)·60°)` have opposite strict signs. -/
theorem exists_opposite_cos_third {j l p : ℕ} (hj : j < 6) (hl : l < 6) (hp : p < 2) (hjl : j ≠ l) :
    ∃ i < 3, Real.cos (((j : ℤ) - (p + 2 * i : ℕ)) * (π / 3)) * Real.cos (((l : ℤ) - (p + 2 * i : ℕ)) * (π / 3)) < 0 := by
  have key : ∃ i < 3, (((j : ℤ) - (p + 2 * i : ℕ)) % 6 ∈ ({0, 1, 5} : Finset ℤ) ∧ ((l : ℤ) - (p + 2 * i : ℕ)) % 6 ∈ ({2, 3, 4} : Finset ℤ)) ∨
      (((j : ℤ) - (p + 2 * i : ℕ)) % 6 ∈ ({2, 3, 4} : Finset ℤ) ∧ ((l : ℤ) - (p + 2 * i : ℕ)) % 6 ∈ ({0, 1, 5} : Finset ℤ)) := by
    interval_cases j <;> interval_cases l <;> interval_cases p <;> simp at hjl <;> decide
  obtain ⟨i, hi, h⟩ := key
  refine ⟨i, hi, ?_⟩
  simp only [Finset.mem_insert, Finset.mem_singleton] at h
  push_cast at h ⊢
  rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact mul_neg_of_pos_of_neg (by exact_mod_cast cos_int_mul_third_pos (m := (j : ℤ) - (p + 2 * i)) (by exact_mod_cast h1))
      (by exact_mod_cast cos_int_mul_third_neg (m := (l : ℤ) - (p + 2 * i)) (by exact_mod_cast h2))
  · exact mul_neg_of_neg_of_pos (by exact_mod_cast cos_int_mul_third_neg (m := (j : ℤ) - (p + 2 * i)) (by exact_mod_cast h1))
      (by exact_mod_cast cos_int_mul_third_pos (m := (l : ℤ) - (p + 2 * i)) (by exact_mod_cast h2))


/-- The squared norm of a sum of two unit vectors: `‖e a + e b‖² = 2 + 2 cos(a − b)`. -/
theorem sq_norm_e_add_e (a b : ℝ) : ‖e a + e b‖ ^ 2 = 2 + 2 * Real.cos (a - b) := by
  rw [Complex.sq_norm, Complex.normSq_apply, e_eq, e_eq, Real.cos_sub]
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.I_re, Complex.I_im]
  nlinarith [Real.cos_sq_add_sin_sq a, Real.cos_sq_add_sin_sq b]

/-- The two unit vectors `60°` on either side of `e a` add up to `e a`. -/
theorem e_add_third_add_e_sub_third (a : ℝ) : e (a + π / 3) + e (a - π / 3) = e a := by
  rw [e_eq, e_eq, e_eq, Real.cos_add, Real.cos_sub, Real.sin_add, Real.sin_sub, Real.cos_pi_div_three]
  push_cast; ring

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS112-N2-FLANK-Q: horn bounds `±1` sit on (Q) or (R2) arcs -/

/-- **Engine 5, the upper bound** (`plans/FS131-w4-kernel-plan.md` § 13.1 item 5): a horn at `v` along `e α` whose upper arc has
curvature `1`, with a flank colour `g` above it, is bounded by an arc of `Γ` on `ω(N)` leaving `v`, with constant sides — inner colour
`g`, outer colour the horn's. The points of that arc near `v` are limits of both the horn and the flank and are not interior points
(an interior one would join the horn's component, which holds no point inside `ω(N)`); near each of them the horn and the flank fill
everything off `ω(N)`, so the arcs there lie on `ω(N)` (`isRingArc_of_clean`). -/
theorem IsHorn.isRingArc_upper {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hg : F.IsFlankAbove v α 1 g) :
    ∃ θ₂, α - π / 2 < θ₂ ∧ F.IsRingArc (v + e (α + π / 2)) (α - π / 2) θ₂ g c := by
  have hπ := Real.pi_pos
  have hπ3 := Real.pi_gt_three
  obtain ⟨hκ₁, hHev⟩ := hH
  obtain ⟨κ', hκ', hgev⟩ := hg
  obtain ⟨r, ⟨⟨hsec, hcol⟩, hfl⟩, hr0⟩ :=
    ((hHev.and hgev).and (Ioo_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num))).exists
  set N := v + e (α + π / 2) with hN
  obtain ⟨x₀, -, hHeq, hvH⟩ := hsec
  have hHI : hornSet v α κ₁ 1 r ⊆ F.interiorPts := by
    rw [hHeq]; exact (connectedComponentIn_subset _ _).trans inter_subset_left
  have hFlI : hornSet v α 1 κ' r ⊆ F.interiorPts := fun z hz => (hfl hz).1
  -- a preconnected set of interior points in `B(v, r)` meeting the horn lies in it
  have hjoin : ∀ B : Set ℂ, IsPreconnected B → B ⊆ F.interiorPts ∩ ball v r → ∀ p ∈ B, p ∈ hornSet v α κ₁ 1 r →
      B ⊆ hornSet v α κ₁ 1 r := by
    intro B hB hBsub p hpB hpH
    rw [hHeq] at hpH ⊢
    rw [connectedComponentIn_eq hpH]
    exact hB.subset_connectedComponentIn hpB hBsub
  set O : Set ℂ := {z | dist z v < r ∧ 0 < frameX v α z ∧ TanAbove v α κ₁ z ∧ TanBelow v α κ' z} with hOdef
  have hOopen : IsOpen O := by
    have hfx : Continuous (frameX v α) := by unfold frameX; fun_prop
    have hfy : Continuous (frameY v α) := by unfold frameY; fun_prop
    have ht : ∀ κ : ℝ, Continuous fun z => tanHeight κ (frameX v α z) (frameY v α z) := fun κ => by
      unfold tanHeight; fun_prop
    exact (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
      ((isOpen_lt continuous_const hfx).inter ((isOpen_lt continuous_const (ht κ₁)).inter (isOpen_lt (ht κ') continuous_const)))
  have hOball : O ⊆ ball v r := fun z hz => hz.1
  have hOH : ∀ z ∈ O, 1 < dist z N → z ∈ hornSet v α κ₁ 1 r := fun z hz h =>
    ⟨hz.1, hz.2.1, hz.2.2.1, (tanBelow_one_iff v α z).mpr h⟩
  have hOF : ∀ z ∈ O, dist z N < 1 → z ∈ hornSet v α 1 κ' r := fun z hz h =>
    ⟨hz.1, hz.2.1, (tanAbove_one_iff v α z).mpr h, hz.2.2.2⟩
  have hHN : ∀ z ∈ hornSet v α κ₁ 1 r, 1 < dist z N := fun z hz => (tanBelow_one_iff v α z).mp hz.2.2.2
  -- the radial points
  have hdN : ∀ ρ θ : ℝ, 0 ≤ ρ → dist (N + (ρ : ℂ) * e θ) N = ρ := fun ρ θ hρ => by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hρ]
  have hdd : ∀ ρ θ : ℝ, dist (N + (ρ : ℂ) * e θ) (N + e θ) = |ρ - 1| := fun ρ θ => by
    rw [dist_eq_norm, show N + (ρ : ℂ) * e θ - (N + e θ) = ((ρ - 1 : ℝ) : ℂ) * e θ by push_cast; ring, norm_mul, norm_e, mul_one,
      Complex.norm_real, Real.norm_eq_abs]
  -- the arc points `a(t) = N + e(α − π/2 + t)`, `0 < t ≤ τ`, lie in `O`
  set τ := min (r / 2) 1 with hτ
  have hτ0 : 0 < τ := lt_min (by linarith [hr0.1]) one_pos
  have hτr : τ ≤ r / 2 := min_le_left _ _
  have hτ1 : τ ≤ 1 := min_le_right _ _
  have hapt : ∀ t, ringPt N (α - π / 2 + t) = fromFrame v α (Real.sin t) (1 - Real.cos t) := fun t => by
    have := normalPt_add_eq_fromFrame v α 1 t
    rw [ofReal_one, one_mul, one_mul, one_mul] at this
    rw [ringPt, ← this]
  have hadist : ∀ t, 0 ≤ t → dist (ringPt N (α - π / 2 + t)) v ≤ t := by
    intro t ht
    have h := frame_normSq v α (ringPt N (α - π / 2 + t))
    rw [hapt, frameX_fromFrame, frameY_fromFrame, ← hapt, ← dist_eq_norm] at h
    have hc := Real.one_sub_sq_div_two_le_cos (x := t)
    have hsc := Real.sin_sq_add_cos_sq t
    have h2 : dist (ringPt N (α - π / 2 + t)) v ^ 2 ≤ t ^ 2 := by nlinarith
    nlinarith [dist_nonneg (x := ringPt N (α - π / 2 + t)) (y := v)]
  have hainO : ∀ t ∈ Ioc 0 τ, ringPt N (α - π / 2 + t) ∈ O := by
    intro t ht
    have hcos : Real.cos t < 1 := by
      have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) (by linarith [ht.2, hτ1]) ht.1
      rwa [Real.cos_zero] at this
    have hsin : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht.1 (by linarith [ht.2, hτ1])
    have hsc := Real.sin_sq_add_cos_sq t
    refine ⟨by linarith [hadist t ht.1.le, hr0.1, ht.2, hτr], ?_, ?_, ?_⟩
    · rw [hapt, frameX_fromFrame]; exact hsin
    · unfold TanAbove; rw [hapt, frameX_fromFrame, frameY_fromFrame]; unfold tanHeight
      nlinarith
    · unfold TanBelow; rw [hapt, frameX_fromFrame, frameY_fromFrame]; unfold tanHeight
      nlinarith
  -- the arc points are not interior points
  have hnotI : ∀ t ∈ Ioc 0 τ, ringPt N (α - π / 2 + t) ∉ F.interiorPts := by
    intro t ht hI
    set a := ringPt N (α - π / 2 + t) with ha
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp (F.isOpen_interiorPts.inter hOopen) a ⟨hI, hainO t ht⟩
    have hae : a = N + e (α - π / 2 + t) := rfl
    set s := min (δ / 2) (1 / 2) with hs
    have hs0 : 0 < s := lt_min (by linarith) (by norm_num)
    have hsδ : s < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hs1 : s ≤ 1 / 2 := min_le_right _ _
    have hout : N + ((1 + s : ℝ) : ℂ) * e (α - π / 2 + t) ∈ ball a δ := by
      rw [mem_ball, hae, hdd, abs_of_pos (by linarith)]; linarith
    have hin : N + ((1 - s : ℝ) : ℂ) * e (α - π / 2 + t) ∈ ball a δ := by
      rw [mem_ball, hae, hdd, abs_of_neg (by linarith)]; linarith
    have hBsub : ball a δ ⊆ F.interiorPts ∩ ball v r := fun z hz => ⟨(hball hz).1, hOball (hball hz).2⟩
    have houtH := hOH _ (hball hout).2 (by rw [hdN _ _ (by linarith)]; linarith)
    have hsub := hjoin (ball a δ) (convex_ball a δ).isPreconnected hBsub _ hout houtH
    have := hHN _ (hsub hin)
    rw [hdN _ _ (by linarith)] at this
    linarith
  have hvnotI : v ∉ F.interiorPts := by
    intro hI
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts v hI
    set δ' := min δ r with hδ'
    have hδ'0 : 0 < δ' := lt_min hδ hr0.1
    have hBsub : ball v δ' ⊆ F.interiorPts ∩ ball v r := fun z hz =>
      ⟨hball (ball_subset_ball (min_le_left _ _) hz), ball_subset_ball (min_le_right _ _) hz⟩
    obtain ⟨p, hpB, hpH⟩ := mem_closure_iff.mp hvH (ball v δ') isOpen_ball (mem_ball_self hδ'0)
    have hsub := hjoin (ball v δ') (convex_ball v δ').isPreconnected hBsub p hpB hpH
    have hq : fromFrame v α (-(δ' / 2)) 0 ∈ ball v δ' := by
      rw [mem_ball, dist_eq_norm]
      unfold fromFrame
      rw [show v + ((((-(δ' / 2) : ℝ) : ℂ) + ((0 : ℝ) : ℂ) * I)) * e α - v = ((-(δ' / 2) : ℝ) : ℂ) * e α by push_cast; ring,
        norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos (by linarith)]
      linarith
    have := (hsub hq).2.1
    rw [frameX_fromFrame] at this
    linarith
  have hdomv : ∀ z, dist z v < r → z ∈ F.dom := fun z hz => hv (by rw [mem_closedBall]; linarith [hr0.2])
  have hΓ : ringArc N (α - π / 2) (α - π / 2 + τ) ⊆ F.Γ := by
    rintro _ ⟨θ, hθ, rfl⟩
    have hθe : θ = α - π / 2 + (θ - (α - π / 2)) := by ring
    rcases (show 0 ≤ θ - (α - π / 2) by linarith [hθ.1]).eq_or_lt with h0 | hpos
    · have hθ0 : θ = α - π / 2 := by linarith
      have hv' : ringPt N θ = v := by
        rw [hθ0, show α - π / 2 = α - π / 2 + 0 by ring, hapt]; simp [fromFrame]
      rw [hv']
      exact ⟨hdomv v (by rw [dist_self]; exact hr0.1), not_not.mp fun h => hvnotI ⟨hdomv v (by rw [dist_self]; exact hr0.1), h⟩⟩
    · have ht : θ - (α - π / 2) ∈ Ioc 0 τ := ⟨hpos, by linarith [hθ.2]⟩
      rw [hθe]
      have hd := hdomv _ (hainO _ ht).1
      exact ⟨hd, not_not.mp fun h => hnotI _ ht ⟨hd, h⟩⟩
  have hclean : ∀ θ ∈ Ioo (α - π / 2) (α - π / 2 + τ), ∃ δ > 0, ball (ringPt N θ) δ ⊆ F.dom ∧
      ∀ z ∈ ball (ringPt N θ) δ, z ∈ ⋃ a ∈ F.arcs, a.carrier → dist z N = 1 := by
    intro θ hθ
    have ht : θ - (α - π / 2) ∈ Ioc 0 τ := ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    have hmem := hainO _ ht
    rw [show α - π / 2 + (θ - (α - π / 2)) = θ by ring] at hmem
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hOopen _ hmem
    refine ⟨δ, hδ, fun z hz => hdomv z (hball hz).1, fun z hz hza => ?_⟩
    have hzO := hball hz
    by_contra hne
    rcases lt_or_gt_of_ne hne with h | h
    · exact (hFlI (hOF z hzO h)).2 hza
    · exact (hHI (hOH z hzO h)).2 hza
  obtain ⟨c₀, c₀', hR⟩ := isRingArc_of_clean (by linarith) hΓ hclean
  -- the side colours: the flank inside, the horn outside
  set m := α - π / 2 + τ / 2 with hm
  have hmI : m ∈ Ioo (α - π / 2) (α - π / 2 + τ) := ⟨by linarith, by linarith⟩
  have hmO : ringPt N m ∈ O := hainO (τ / 2) ⟨by linarith, by linarith⟩
  obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hOopen _ hmO
  have hme : ringPt N m = N + e m := rfl
  have hgin : g ∈ F.innerColours N (ringPt N m) := by
    show ringPt N m ∈ closure (F.region g ∩ ball N 1)
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min (min (ε / 2) (δ / 2)) (1 / 2) with hs
    have hs0 : 0 < s := lt_min (lt_min (by linarith) (by linarith)) (by norm_num)
    have hs1 := min_le_left (min (ε / 2) (δ / 2)) (1 / 2)
    have hs2 := min_le_right (min (ε / 2) (δ / 2)) (1 / 2)
    have hs3 := min_le_left (ε / 2) (δ / 2)
    have hs4 := min_le_right (ε / 2) (δ / 2)
    have hd1 : dist (N + ((1 - s : ℝ) : ℂ) * e m) (ringPt N m) = s := by
      rw [hme, hdd, abs_of_neg (by linarith)]; ring
    have hbO : N + ((1 - s : ℝ) : ℂ) * e m ∈ O := hball (by rw [mem_ball, hd1]; linarith)
    have hbN : dist (N + ((1 - s : ℝ) : ℂ) * e m) N < 1 := by rw [hdN _ _ (by linarith)]; linarith
    refine ⟨_, ⟨hfl (hOF _ hbO hbN), hbN⟩, ?_⟩
    rw [dist_comm, hd1]; linarith
  have hcout : c ∈ F.outerColours N (ringPt N m) := by
    show ringPt N m ∈ closure (F.region c \ closedBall N 1)
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min (ε / 2) (δ / 2) with hs
    have hs0 : 0 < s := lt_min (by linarith) (by linarith)
    have hs3 := min_le_left (ε / 2) (δ / 2)
    have hs4 := min_le_right (ε / 2) (δ / 2)
    have hd1 : dist (N + ((1 + s : ℝ) : ℂ) * e m) (ringPt N m) = s := by
      rw [hme, hdd, abs_of_pos (by linarith)]; ring
    have hbO : N + ((1 + s : ℝ) : ℂ) * e m ∈ O := hball (by rw [mem_ball, hd1]; linarith)
    have hbN : 1 < dist (N + ((1 + s : ℝ) : ℂ) * e m) N := by rw [hdN _ _ (by linarith)]; linarith
    have hbH := hOH _ hbO hbN
    refine ⟨_, ⟨⟨hHI hbH, hcol hbH⟩, by rw [mem_closedBall, not_le]; exact hbN⟩, ?_⟩
    rw [dist_comm, hd1]; linarith
  have hgc : g = c₀ := by
    have := (hR.2.2 m hmI).1 ▸ hgin; exact this
  have hcc : c = c₀' := by
    have := (hR.2.2 m hmI).2 ▸ hcout; exact this
  subst hgc hcc
  exact ⟨α - π / 2 + τ, by linarith, hR⟩

/-- **Near a point of the circle of radius `2` about `C`, all but finitely many nearby points of that circle see only arcs lying on
the circle** (child of FLANK-Q's shadow clause): at `S₀ = C + 2 e(θ₀)` in the domain, for every angle `θ ≠ θ₀` near `θ₀` the point
`C + 2 e(θ)` is in the domain and some ball about it meets the arcs only on the circle. -/
theorem eventually_arcs_on_sphere_two {C : ℂ} {θ₀ : ℝ} (hd : C + 2 * e θ₀ ∈ F.dom) :
    ∀ᶠ θ in 𝓝[≠] θ₀, C + 2 * e θ ∈ F.dom ∧
      ∃ η > 0, ∀ w ∈ ball (C + 2 * e θ) η, w ∈ ⋃ a ∈ F.arcs, a.carrier → dist w C = 2 := by
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite _ hd
  set A := {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty} with hA
  set Afin := {a | a ∈ A ∧ (a.carrier ∩ sphere C 2).Finite} with hAfin
  have hAfinF : Afin.Finite := hfin.subset fun a ha => ha.1
  set D := ⋃ a ∈ Afin, a.carrier with hD
  have hDc : IsClosed D := hAfinF.isClosed_biUnion fun a _ => a.isClosed_carrier
  have hE : (D ∩ sphere C 2).Finite := by
    rw [hD, iUnion₂_inter]
    exact hAfinF.biUnion fun a ha => ha.2
  have hcont : Continuous (fun θ : ℝ => C + 2 * e θ) := by unfold e; fun_prop
  -- the points of the circle near `S₀` lie in the interior of `t` and in the domain
  have h1 : ∀ᶠ θ in 𝓝 θ₀, C + 2 * e θ ∈ interior t ∩ F.dom :=
    hcont.continuousAt.preimage_mem_nhds (inter_mem (interior_mem_nhds.mpr ht) (F.isOpen_dom.mem_nhds hd))
  -- and, `θ ≠ θ₀` near `θ₀`, off the finite set `D ∩ sphere C 2`
  have hinj : InjOn (fun θ : ℝ => C + 2 * e θ) (Ioo (θ₀ - π) (θ₀ - π + 2 * π)) := by
    have := injOn_spherePt C (show (0 : ℝ) < 2 by norm_num) (θ₀ - π)
    intro x hx y hy hxy
    exact this hx hy (by simpa [spherePt] using hxy)
  set Θ := (fun θ : ℝ => C + 2 * e θ) ⁻¹' (D ∩ sphere C 2) ∩ Ioo (θ₀ - π) (θ₀ - π + 2 * π) with hΘ
  have hΘfin : Θ.Finite :=
    Set.Finite.of_finite_image (hE.subset (image_subset_iff.mpr fun θ (hθ : θ ∈ Θ) => hθ.1))
      (hinj.mono fun θ (hθ : θ ∈ Θ) => hθ.2)
  have h2 : ∀ᶠ θ in 𝓝[≠] θ₀, θ ∉ Θ := by
    have hcl : IsClosed (Θ \ {θ₀}) := (hΘfin.subset sdiff_subset).isClosed
    have hmem : (Θ \ {θ₀})ᶜ ∈ 𝓝 θ₀ := hcl.isOpen_compl.mem_nhds (fun h => h.2 rfl)
    filter_upwards [nhdsWithin_le_nhds hmem, self_mem_nhdsWithin] with θ h hne h'
    exact h ⟨h', hne⟩
  have h3 : ∀ᶠ θ in 𝓝 θ₀, θ ∈ Ioo (θ₀ - π) (θ₀ - π + 2 * π) :=
    Ioo_mem_nhds (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos])
  filter_upwards [nhdsWithin_le_nhds h1, h2, nhdsWithin_le_nhds h3] with θ hθ hθΘ hθI
  refine ⟨hθ.2, ?_⟩
  have hpD : C + 2 * e θ ∉ D := by
    intro h
    refine hθΘ ⟨⟨h, ?_⟩, hθI⟩
    rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e]; simp
  obtain ⟨η₁, hη₁, hb1⟩ := Metric.isOpen_iff.mp hDc.isOpen_compl _ hpD
  obtain ⟨η₂, hη₂, hb2⟩ := Metric.isOpen_iff.mp isOpen_interior _ hθ.1
  refine ⟨min η₁ η₂, lt_min hη₁ hη₂, fun w hw hwa => ?_⟩
  have hw1 : w ∈ ball (C + 2 * e θ) η₁ := ball_subset_ball (min_le_left _ _) hw
  have hw2 : w ∈ interior t := hb2 (ball_subset_ball (min_le_right _ _) hw)
  obtain ⟨a, ha, hwa'⟩ := mem_iUnion₂.mp hwa
  have haA : a ∈ A := ⟨ha, w, hwa', interior_subset hw2⟩
  rcases Arc.finite_inter_sphere_two_or_subset a (F.nondegenerate a ha) C with hf | hs
  · exact absurd (mem_iUnion₂.mpr ⟨a, ⟨haA, hf⟩, hwa'⟩) (hb1 hw1)
  · exact hs hwa'

/-- **One side of the circle of radius `2`, near a point of it in a class's closure, is that class** (child of FLANK-Q's shadow
clause): at `p = C + 2 e(φ)` in the domain and in the closure of `g`'s class, with the arcs near `p` lying on the circle, some polar
box just outside the circle, or just inside it, about `p` lies in `g`'s class. -/
theorem exists_polarBox_subset_region {C : ℂ} {φ : ℝ} {g : Fin k} (hd : C + 2 * e φ ∈ F.dom)
    (hcl : C + 2 * e φ ∈ closure (F.region g)) {η₀ : ℝ} (hη₀ : 0 < η₀)
    (harc : ∀ w ∈ ball (C + 2 * e φ) η₀, w ∈ ⋃ a ∈ F.arcs, a.carrier → dist w C = 2) :
    ∃ η > 0, η < 1 ∧
      ((fun q : ℝ × ℝ => C + (q.1 : ℂ) * e q.2) '' (Ioo 2 (2 + η) ×ˢ Ioo (φ - η) (φ + η)) ⊆ F.region g ∨
        (fun q : ℝ × ℝ => C + (q.1 : ℂ) * e q.2) '' (Ioo (2 - η) 2 ×ˢ Ioo (φ - η) (φ + η)) ⊆ F.region g) := by
  set p := C + 2 * e φ with hp
  obtain ⟨η₁, hη₁, hball⟩ := Metric.isOpen_iff.mp F.isOpen_dom p hd
  set η := min (min η₁ η₀ / 3) (1 / 2) with hη
  have hη0 : 0 < η := lt_min (by positivity) (by norm_num)
  have hη1 : η ≤ min η₁ η₀ / 3 := min_le_left _ _
  have hηh : η ≤ 1 / 2 := min_le_right _ _
  set Φ := fun q : ℝ × ℝ => C + (q.1 : ℂ) * e q.2 with hΦ
  have hΦc : Continuous Φ := by rw [hΦ]; unfold e; fun_prop
  -- a box point is within `3η` of `p`, so in the domain and in the ball where the arcs lie on the circle
  have hnear : ∀ ρ t, |ρ - 2| < η → |t - φ| < η → dist (Φ (ρ, t)) p < min η₁ η₀ := by
    intro ρ t hρ ht
    have : dist (Φ (ρ, t)) p ≤ |ρ - 2| + 2 * |t - φ| := by
      rw [hΦ, hp, dist_eq_norm]
      simp only
      have h1 : C + (ρ : ℂ) * e t - (C + 2 * e φ) = ((ρ - 2 : ℝ) : ℂ) * e t + 2 * (e t - e φ) := by push_cast; ring
      rw [h1]
      calc ‖((ρ - 2 : ℝ) : ℂ) * e t + 2 * (e t - e φ)‖ ≤ ‖((ρ - 2 : ℝ) : ℂ) * e t‖ + ‖2 * (e t - e φ)‖ := norm_add_le _ _
        _ = |ρ - 2| + 2 * ‖e t - e φ‖ := by
          rw [norm_mul, norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs]; simp
        _ ≤ |ρ - 2| + 2 * |t - φ| := by linarith [norm_e_sub_e_le t φ]
    linarith
  have hdistC : ∀ ρ t, 0 ≤ ρ → dist (Φ (ρ, t)) C = ρ := by
    intro ρ t hρ
    rw [hΦ, dist_eq_norm]; simp only
    rw [add_sub_cancel_left, norm_mul, norm_e, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hρ, mul_one]
  -- each half box is a preconnected set of interior points
  have hhalf : ∀ a b : ℝ, 2 - η ≤ a → b ≤ 2 + η → (2 ∉ Ioo a b) →
      IsPreconnected (Φ '' (Ioo a b ×ˢ Ioo (φ - η) (φ + η))) ∧
        Φ '' (Ioo a b ×ˢ Ioo (φ - η) (φ + η)) ⊆ F.interiorPts := by
    intro a b ha hb h2
    refine ⟨(isPreconnected_Ioo.prod isPreconnected_Ioo).image _ hΦc.continuousOn, ?_⟩
    rintro _ ⟨⟨ρ, t⟩, ⟨hρ, ht⟩, rfl⟩
    have hρ2 : |ρ - 2| < η := by rw [abs_lt]; constructor <;> linarith [hρ.1, hρ.2]
    have ht2 : |t - φ| < η := by rw [abs_lt]; constructor <;> linarith [ht.1, ht.2]
    have hn := hnear ρ t hρ2 ht2
    refine ⟨hball (lt_of_lt_of_le hn (min_le_left _ _)), fun hmem => ?_⟩
    have := harc _ (lt_of_lt_of_le hn (min_le_right _ _)) hmem
    rw [hdistC ρ t (by linarith [hρ.1])] at this
    exact h2 (this ▸ hρ)
  obtain ⟨hpo, hpo'⟩ := hhalf 2 (2 + η) (by linarith) le_rfl (fun h => lt_irrefl _ h.1)
  obtain ⟨hpi, hpi'⟩ := hhalf (2 - η) 2 le_rfl (by linarith) (fun h => lt_irrefl _ h.2)
  -- a half box with one point of colour `g` lies in `g`'s class
  have hfill : ∀ H : Set ℂ, IsPreconnected H → H ⊆ F.interiorPts → (H ∩ F.region g).Nonempty → H ⊆ F.region g := by
    intro H hH hHi ⟨y, hyH, hyg⟩ w hw
    refine ⟨hHi hw, ?_⟩
    have := hH.constant (F.continuousOn_col.mono hHi) hw hyH
    show F.col w = g
    rw [this]; exact hyg.2
  -- a point of `g`'s class near `p`, in polar form about `C`
  have harg : ∀ᶠ ζ in 𝓝 (2 : ℂ), |Complex.arg ζ| < η := by
    have hc : ContinuousAt Complex.arg 2 := Complex.continuousAt_arg (by simp)
    have : Complex.arg 2 = 0 := by simp
    have h := hc.eventually (Metric.ball_mem_nhds (Complex.arg 2) hη0)
    filter_upwards [h] with ζ hζ
    have hζ' : dist (Complex.arg ζ) (Complex.arg 2) < η := hζ
    rw [Real.dist_eq, this, sub_zero] at hζ'; exact hζ'
  obtain ⟨ε, hε, hεarg⟩ := Metric.eventually_nhds_iff.mp harg
  obtain ⟨y, hyg, hyd⟩ := Metric.mem_closure_iff.mp hcl (min ε η) (lt_min hε hη0)
  set ζ := (y - C) / e φ with hζ
  have he0 : e φ ≠ 0 := by intro h; simpa [h] using norm_e φ
  have hζ2 : dist ζ 2 < min ε η := by
    rw [hζ, dist_eq_norm, show (y - C) / e φ - 2 = (y - (C + 2 * e φ)) / e φ by field_simp; ring, norm_div, norm_e,
      div_one, ← dist_eq_norm, dist_comm]; exact hyd
  have hζarg : |Complex.arg ζ| < η := hεarg (lt_of_lt_of_le hζ2 (min_le_left _ _))
  have hζn : |‖ζ‖ - 2| < η := by
    have := abs_norm_sub_norm_le ζ 2
    rw [show ‖(2 : ℂ)‖ = 2 by simp] at this
    rw [dist_eq_norm] at hζ2
    linarith [min_le_right ε η]
  have hy : y = Φ (‖ζ‖, φ + Complex.arg ζ) := by
    rw [hΦ]; simp only
    have hpol : (‖ζ‖ : ℂ) * e (Complex.arg ζ) = ζ := Complex.norm_mul_exp_arg_mul_I ζ
    rw [e_add, show (‖ζ‖ : ℂ) * (e φ * e (Complex.arg ζ)) = e φ * ((‖ζ‖ : ℂ) * e (Complex.arg ζ)) by ring, hpol, hζ]
    field_simp; ring
  have htI : φ + Complex.arg ζ ∈ Ioo (φ - η) (φ + η) := by
    rw [abs_lt] at hζarg; constructor <;> linarith [hζarg.1, hζarg.2]
  rw [abs_lt] at hζn
  refine ⟨η, hη0, by linarith, ?_⟩
  rcases lt_trichotomy ‖ζ‖ 2 with h | h | h
  · right
    exact hfill _ hpi hpi' ⟨y, hy ▸ mem_image_of_mem _ ⟨⟨by linarith [hζn.1], h⟩, htI⟩, hyg⟩
  · -- `y` on the circle: its class contains a small ball, which reaches outside
    left
    obtain ⟨ε', hε', hb'⟩ := Metric.isOpen_iff.mp (F.isOpen_region g) y hyg
    set δ := min (ε' / 2) (η / 2) with hδ
    have hδ0 : 0 < δ := lt_min (by linarith) (by linarith)
    refine hfill _ hpo hpo' ⟨Φ (2 + δ, φ + Complex.arg ζ), mem_image_of_mem _ ⟨⟨by linarith, by linarith [min_le_right (ε' / 2) (η / 2)]⟩, htI⟩, hb' ?_⟩
    rw [mem_ball, hy, h, hΦ, dist_eq_norm]; simp only
    rw [show C + ((2 + δ : ℝ) : ℂ) * e (φ + Complex.arg ζ) - (C + ((2 : ℝ) : ℂ) * e (φ + Complex.arg ζ)) =
      (δ : ℂ) * e (φ + Complex.arg ζ) by push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos hδ0]
    linarith [min_le_left (ε' / 2) (η / 2)]
  · left
    exact hfill _ hpo hpo' ⟨y, hy ▸ mem_image_of_mem _ ⟨⟨h, by linarith [hζn.2]⟩, htI⟩, hyg⟩

/-- **A circle crossing the circle of radius `2` into a class's side lies in the class's shadow** (child of FLANK-Q's shadow clause):
if `p = C + 2 e(φ)` is as in `exists_polarBox_subset_region` and `z` has points of that circle at angles arbitrarily near `φ` both
inside and outside `ω(z)`, then `z` is in the shadow of `g`'s class. -/
theorem mem_shadow_of_crossing {C z : ℂ} {φ : ℝ} {g : Fin k} (hd : C + 2 * e φ ∈ F.dom)
    (hcl : C + 2 * e φ ∈ closure (F.region g)) {η₀ : ℝ} (hη₀ : 0 < η₀)
    (harc : ∀ w ∈ ball (C + 2 * e φ) η₀, w ∈ ⋃ a ∈ F.arcs, a.carrier → dist w C = 2)
    (hcross : ∀ δ > 0, ∃ φ₁ φ₂, |φ₁ - φ| < δ ∧ |φ₂ - φ| < δ ∧ dist z (C + 2 * e φ₁) < 1 ∧ 1 < dist z (C + 2 * e φ₂)) :
    z ∈ shadow (F.region g) := by
  obtain ⟨η, hη, hη1, hbox⟩ := exists_polarBox_subset_region hd hcl hη₀ harc
  obtain ⟨φ₁, φ₂, h1, h2, hd1, hd2⟩ := hcross η hη
  set Φ := fun q : ℝ × ℝ => C + (q.1 : ℂ) * e q.2 with hΦ
  have hΦc : Continuous Φ := by rw [hΦ]; unfold e; fun_prop
  have hc1 : Continuous fun ρ : ℝ => dist z (Φ (ρ, φ₁)) := by fun_prop
  have hc2 : Continuous fun ρ : ℝ => dist z (Φ (ρ, φ₂)) := by fun_prop
  have hev : ∀ᶠ ρ in 𝓝 (2 : ℝ), dist z (Φ (ρ, φ₁)) < 1 ∧ 1 < dist z (Φ (ρ, φ₂)) := by
    have e1 : dist z (Φ (2, φ₁)) < 1 := by simpa [hΦ] using hd1
    have e2 : 1 < dist z (Φ (2, φ₂)) := by simpa [hΦ] using hd2
    exact (hc1.continuousAt.eventually (gt_mem_nhds e1)).and (hc2.continuousAt.eventually (lt_mem_nhds e2))
  have hφ1 : φ₁ ∈ Ioo (φ - η) (φ + η) := by rw [abs_lt] at h1; constructor <;> linarith [h1.1, h1.2]
  have hφ2 : φ₂ ∈ Ioo (φ - η) (φ + η) := by rw [abs_lt] at h2; constructor <;> linarith [h2.1, h2.2]
  have hivt : ∀ a b : ℝ, (Φ '' (Ioo a b ×ˢ Ioo (φ - η) (φ + η)) ⊆ F.region g) →
      (∃ ρ ∈ Ioo a b, dist z (Φ (ρ, φ₁)) < 1 ∧ 1 < dist z (Φ (ρ, φ₂))) → z ∈ shadow (F.region g) := by
    intro a b hsub ⟨ρ, hρ, hρ1, hρ2⟩
    have hpc : IsPreconnected (Φ '' (Ioo a b ×ˢ Ioo (φ - η) (φ + η))) :=
      (isPreconnected_Ioo.prod isPreconnected_Ioo).image _ hΦc.continuousOn
    have hm1 : Φ (ρ, φ₁) ∈ Φ '' (Ioo a b ×ˢ Ioo (φ - η) (φ + η)) := mem_image_of_mem _ ⟨hρ, hφ1⟩
    have hm2 : Φ (ρ, φ₂) ∈ Φ '' (Ioo a b ×ˢ Ioo (φ - η) (φ + η)) := mem_image_of_mem _ ⟨hρ, hφ2⟩
    obtain ⟨y, hy, hyd⟩ := hpc.intermediate_value hm1 hm2 (continuous_const.dist continuous_id).continuousOn
      (show (1 : ℝ) ∈ Icc (dist z (Φ (ρ, φ₁))) (dist z (Φ (ρ, φ₂))) from ⟨hρ1.le, hρ2.le⟩)
    exact ⟨y, hsub hy, hyd⟩
  rcases hbox with hb | hb
  · refine hivt 2 (2 + η) hb ?_
    obtain ⟨ρ, hρ, hρI⟩ := ((hev.filter_mono nhdsWithin_le_nhds).and (Ioo_mem_nhdsGT (show (2 : ℝ) < 2 + η by linarith))).exists
    exact ⟨ρ, hρI, hρ⟩
  · refine hivt (2 - η) 2 hb ?_
    obtain ⟨ρ, hρ, hρI⟩ := ((hev.filter_mono nhdsWithin_le_nhds).and (Ioo_mem_nhdsLT (show (2 - η : ℝ) < 2 by linarith))).exists
    exact ⟨ρ, hρI, hρ⟩

/-- **FS112-N2-FLANK-Q's (R2) shadow, upper** (child of `flankQ_upper`): if the radius-2 arc `R₂` over `[α − π/2, θ₂]` about `N` lies in
the closure of the flank colour `g`'s class, `g`'s class shadows every horn point near `v` below `ω(N)`. -/
theorem flankQ_upper_shadow (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {g : Fin k}
    (hg : F.IsFlankAbove v α 1 g) {θ₂ : ℝ} (hθ₂ : α - π / 2 < θ₂)
    (hR2 : radiusTwoArc (v + e (α + π / 2)) (α - π / 2) θ₂ ⊆ closure (F.region g)) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ 1 r ⊆ shadow (F.region g) := by
  have _ := hF
  have _ := hg
  set N := v + e (α + π / 2) with hN
  set θ₀ := α - π / 2 with hθ₀
  have heb : e (α + π / 2) = -e θ₀ := by
    rw [show α + π / 2 = θ₀ + π by rw [hθ₀]; ring, e_add_pi]
  have hb0 : e θ₀ ≠ 0 := by intro h; simpa [h] using norm_e θ₀
  -- `S′ = N + 2 e(θ₀)` is in the domain
  have hS : N + 2 * e θ₀ ∈ F.dom := by
    refine hv ?_
    rw [mem_closedBall, hN, heb, dist_eq_norm, show v + -e θ₀ + 2 * e θ₀ - v = e θ₀ by ring, norm_e]
  obtain ⟨ε₁, hε₁, hgood⟩ := Metric.eventually_nhds_iff.mp (eventually_nhdsWithin_iff.mp (eventually_arcs_on_sphere_two hS))
  set ε := min ε₁ (θ₂ - θ₀) with hε
  have hε0 : 0 < ε := lt_min hε₁ (by linarith)
  -- the frame coordinate `u = (z − N)/e(θ₀)`, equal to `1` at `v`
  set u : ℂ → ℂ := fun z => (z - N) / e θ₀ with hu
  have huc : Continuous u := by rw [hu]; fun_prop (disch := exact hb0)
  have huv : u v = 1 := by
    rw [hu]; simp only; rw [hN, heb, show v - (v + -e θ₀) = e θ₀ by ring, div_self hb0]
  have hev : ∀ᶠ z in 𝓝 v, r2Cross (u z) < ε ∧ ‖u z‖ < 3 := by
    have h1 : ∀ᶠ z in 𝓝 v, r2Cross (u z) < ε := by
      have hc : ContinuousAt (r2Cross ∘ u) v :=
        ContinuousAt.comp (by rw [huv]; exact continuousAt_r2Cross_one) huc.continuousAt
      have : (r2Cross ∘ u) v = 0 := by simp only [Function.comp, huv, r2Cross_one]
      exact hc.eventually (gt_mem_nhds (show (r2Cross ∘ u) v < ε by rw [this]; exact hε0))
    have h2 : ∀ᶠ z in 𝓝 v, ‖u z‖ < 3 := by
      have hc : ContinuousAt (fun z => ‖u z‖) v := (continuous_norm.comp huc).continuousAt
      exact hc.eventually (gt_mem_nhds (show ‖u v‖ < 3 by rw [huv]; norm_num))
    exact h1.and h2
  obtain ⟨δ, hδ, hδev⟩ := Metric.eventually_nhds_iff.mp hev
  filter_upwards [Ioo_mem_nhdsGT hδ] with r hr z hz
  obtain ⟨hzr, hzx, -, hzB⟩ := hz
  obtain ⟨hsc, hu3⟩ := hδev (lt_trans hzr hr.2)
  have hzN : z - N = e θ₀ * u z := by rw [hu]; simp only; field_simp
  -- `u z` is above the real axis, of norm `> 1`
  have hun : ‖u z‖ = dist z N := by
    rw [hu]; simp only; rw [norm_div, norm_e, div_one, dist_eq_norm]
  have hu1 : 1 < ‖u z‖ := by rw [hun]; exact (tanBelow_one_iff v α z).mp hzB
  have huim : 0 < (u z).im := by
    have : (u z).im = frameX v α z := by
      rw [hu]; simp only
      rw [hN, heb, show z - (v + -e θ₀) = (z - v) + e θ₀ by ring, add_div, div_self hb0]
      unfold frameX
      have hinv : (e θ₀)⁻¹ = starRingEnd ℂ (e θ₀) := by
        rw [Complex.inv_def, Complex.normSq_eq_norm_sq, norm_e]; simp
      have hI : e (π / 2) = I := by rw [e_eq]; simp
      rw [show α = θ₀ + π / 2 by rw [hθ₀]; ring, e_add, div_eq_mul_inv, hinv, hI, map_mul, Complex.conj_I]
      simp only [Complex.add_im, Complex.one_im, add_zero, Complex.mul_re, Complex.mul_im, Complex.neg_re, Complex.neg_im,
        Complex.I_re, Complex.I_im]
      ring
    rw [this]; exact hzx
  obtain ⟨hw0, hwc, hcw, hin, hout⟩ := r2Cross_spec hu1 hu3 huim
  set sc := r2Cross (u z) with hscdef
  have hsc0 : 0 < sc := by linarith
  -- the crossing point `p = N + 2 e(θ₀ + sc)`
  obtain ⟨hpd, η₀, hη₀, harc⟩ := hgood (by
    rw [Real.dist_eq, show θ₀ + sc - θ₀ = sc by ring, abs_of_pos hsc0]; exact lt_of_lt_of_le hsc (min_le_left _ _))
    (by intro h; simp only [mem_singleton_iff] at h; linarith)
  have hpcl : N + 2 * e (θ₀ + sc) ∈ closure (F.region g) := by
    refine hR2 ⟨θ₀ + sc, ⟨by linarith, ?_⟩, rfl⟩
    have := lt_of_lt_of_le hsc (min_le_right ε₁ (θ₂ - θ₀)); linarith
  have hdist : ∀ t, dist z (N + 2 * e (θ₀ + t)) = ‖2 * e t - u z‖ := by
    intro t
    calc dist z (N + 2 * e (θ₀ + t)) = ‖(z - N) - 2 * (e θ₀ * e t)‖ := by
          rw [dist_eq_norm, e_add]; congr 1; ring
      _ = ‖e θ₀ * (u z - 2 * e t)‖ := by rw [hzN]; congr 1; ring
      _ = ‖2 * e t - u z‖ := by rw [norm_mul, norm_e, one_mul, norm_sub_rev]
  refine mem_shadow_of_crossing hpd hpcl hη₀ harc fun d hd => ?_
  set d' := min d (sc - Complex.arg (u z)) / 2 with hd'
  have hd'0 : 0 < d' := by
    have : 0 < min d (sc - Complex.arg (u z)) := lt_min hd (by linarith)
    linarith
  have hd'1 : d' < d := by
    have := min_le_left d (sc - Complex.arg (u z)); linarith
  have hd'2 : d' < sc - Complex.arg (u z) := by
    have := min_le_right d (sc - Complex.arg (u z)); linarith
  refine ⟨θ₀ + (sc - d'), θ₀ + (sc + d'), ?_, ?_, ?_, ?_⟩
  · rw [show θ₀ + (sc - d') - (θ₀ + sc) = -d' by ring, abs_neg, abs_of_pos hd'0]; exact hd'1
  · rw [show θ₀ + (sc + d') - (θ₀ + sc) = d' by ring, abs_of_pos hd'0]; exact hd'1
  · rw [hdist]; exact hin _ (by linarith) (by linarith)
  · rw [hdist]; exact hout _ (by linarith) (by linarith [Real.pi_pos])


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
  have _ := hcN
  have hπ := Real.pi_pos
  set N := v + e (α + π / 2) with hN
  have hNdom : N ∈ F.dom := hv (by rw [mem_closedBall, hN, dist_eq_norm]; simp)
  obtain ⟨θ₂, hθ₂, hR⟩ := hH.isRingArc_upper hv hg
  -- the side colours of an arc of `Γ` with constant sides are unique
  set m := ((α - π / 2) + θ₂) / 2 with hm
  have hmI : m ∈ Ioo (α - π / 2) θ₂ := ⟨by linarith, by linarith⟩
  have huniq : ∀ d d', F.IsRingArc N (α - π / 2) θ₂ d d' → d = g ∧ d' = c := by
    intro d d' hR'
    have h2 := (hR.2.2 m hmI).1
    have h4 := (hR.2.2 m hmI).2
    rw [(hR'.2.2 m hmI).1] at h2
    rw [(hR'.2.2 m hmI).2] at h4
    exact ⟨Set.singleton_eq_singleton_iff.mp h2, Set.singleton_eq_singleton_iff.mp h4⟩
  -- flank points: inside `ω(N)`, on the `+n` side, arbitrarily near `v`
  obtain ⟨κ', hκ', hgev⟩ := hg
  have hflank : ∀ ε > 0, ∃ f ∈ F.region g, dist f v < ε ∧ dist f N < 1 ∧ 0 < frameY v α f := by
    intro ε hε
    obtain ⟨r, hr, hrpos⟩ := (hgev.and (Ioo_mem_nhdsGT hε)).exists
    obtain ⟨z, hz, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := 1) (κ₂ := κ') (s := (1 + κ') / 2) (m := 1)
      hrpos.1 (by linarith) (by linarith) (by intro h; linarith)
    refine ⟨z, hr hz, by linarith [hz.1, hrpos.2], (tanAbove_one_iff v α z).mp hz.2.2.1, ?_⟩
    have := hz.2.2.1
    unfold TanAbove tanHeight at this
    nlinarith [sq_nonneg (frameX v α z), sq_nonneg (frameY v α z)]
  have htile : ∀ f ∈ F.region g, F.TileOf g (connectedComponentIn F.interiorPts f) ∧
      f ∈ connectedComponentIn F.interiorPts f := by
    intro f hf
    have hT : F.IsTile (connectedComponentIn F.interiorPts f) := ⟨f, hf.1, rfl⟩
    have hfT : f ∈ connectedComponentIn F.interiorPts f := mem_connectedComponentIn hf.1
    refine ⟨?_, hfT⟩
    have := hT.tileOf hfT
    rwa [show F.col f = g from hf.2] at this
  rcases hQR _ _ _ _ hR with hQ | hR2
  · -- (Q): `g` is carried at `N`, and its tile there is Siamese with the flank, so inside `B(v, 1)`
    obtain ⟨d, d', hR', hd, -, -⟩ := id hQ
    rw [(huniq d d' hR').1] at hd
    obtain ⟨T, hT, hNT⟩ := (F.mem_coloursAt_iff_exists_tileOf hNdom).mp hd
    refine ⟨θ₂, hθ₂, hR, Or.inl ⟨hQ, T, hT, ?_, hNT⟩⟩
    have hnear : ∀ t ∈ T, ∀ f ∈ F.region g, dist f N < 1 → dist t f < 1 := by
      intro t ht f hf hfN
      obtain ⟨hTf, hfT⟩ := htile f hf
      rcases unitNear_or_unitFar hF hT hTf with h | h
      · exact h t ht f hfT
      · exfalso
        obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hNT (1 - dist f N) (by linarith)
        have h1 := h y hy f hfT
        have := dist_triangle y N f
        rw [dist_comm N f] at this
        rw [dist_comm] at hyd
        linarith
    have hTv : T ⊆ closedBall v 1 := by
      intro t ht
      rw [mem_closedBall]
      by_contra hlt
      push Not at hlt
      obtain ⟨f, hf, hfv, hfN, -⟩ := hflank (dist t v - 1) (by linarith)
      have h1 := hnear t ht f hf hfN
      have := dist_triangle t f v
      linarith
    have := hT.1.isOpen.subset_interior_iff.mpr hTv
    rwa [interior_closedBall v one_ne_zero] at this
  · -- (R2): `S′ = N + 2e(α − π/2)` is the arc's radius-2 point at its end `v`; `g`'s tiles there are far from the flank
    obtain ⟨d, d', hR', -, hd, hsub⟩ := id hR2
    rw [(huniq d d' hR').1] at hd hsub
    have hS : v - e (α + π / 2) = N + 2 * e (α - π / 2) := by
      have := e_add_pi (α - π / 2)
      rw [show α - π / 2 + π = α + π / 2 by ring] at this
      rw [hN, this]; ring
    have hSg : v - e (α + π / 2) ∈ closure (F.region g) := by
      rw [hS]; exact hsub ⟨α - π / 2, ⟨le_rfl, hθ₂.le⟩, rfl⟩
    refine ⟨θ₂, hθ₂, hR, Or.inr ⟨hR2, hd, hSg, ?_, flankQ_upper_shadow hF hv ⟨κ', hκ', hgev⟩ hθ₂ hsub⟩⟩
    intro T hT hST
    have hfar : ∀ t ∈ T, ∀ f ∈ F.region g, 0 < frameY v α f → 1 < dist t f := by
      intro t ht f hf hfy
      have hfS : 1 < dist f (v - e (α + π / 2)) := by
        have h := sq_dist_S v α f
        nlinarith [sq_nonneg (frameX v α f), dist_nonneg (x := f) (y := v - e (α + π / 2))]
      obtain ⟨hTf, hfT⟩ := htile f hf
      rcases unitNear_or_unitFar hF hT hTf with h | h
      · exfalso
        obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hST (dist f (v - e (α + π / 2)) - 1) (by linarith)
        have h1 := h y hy f hfT
        have := dist_triangle f y (v - e (α + π / 2))
        rw [dist_comm f y] at this
        rw [dist_comm] at hyd
        linarith
      · exact h t ht f hfT
    have hTv : T ⊆ {w | 1 ≤ dist w v} := by
      intro t ht
      show 1 ≤ dist t v
      by_contra hlt
      push Not at hlt
      obtain ⟨f, hf, hfv, -, hfy⟩ := hflank (1 - dist t v) (by linarith)
      have h1 := hfar t ht f hf hfy
      have := dist_triangle t v f
      rw [dist_comm v f] at this
      linarith
    have hint := hT.1.isOpen.subset_interior_iff.mpr hTv
    have hcompl : {w : ℂ | 1 ≤ dist w v} = (ball v 1)ᶜ := by ext w; simp [mem_ball, not_lt]
    rw [hcompl, interior_compl, closure_ball v one_ne_zero] at hint
    exact Set.disjoint_left.mpr fun t ht htB => hint ht htB

/-- **Engine 5, the lower bound** (the mirror of `IsHorn.isRingArc_upper`): a horn at `v` along `e α` whose lower arc has curvature
`−1`, with a flank colour `h` below it, is bounded by an arc of `Γ` on `ω(S′)` ending at `v`, with constant sides — inner colour `h`,
outer colour the horn's. -/
theorem IsHorn.isRingArc_lower {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α (-1) κ₂ c) (hh : F.IsFlankBelow v α (-1) h) :
    ∃ θ₁, θ₁ < α + π / 2 ∧ F.IsRingArc (v - e (α + π / 2)) θ₁ (α + π / 2) h c := by
  have hπ := Real.pi_pos
  have hπ3 := Real.pi_gt_three
  obtain ⟨hκ₂, hHev⟩ := hH
  obtain ⟨κ', hκ', hhev⟩ := hh
  obtain ⟨r, ⟨⟨hsec, hcol⟩, hfl⟩, hr0⟩ :=
    ((hHev.and hhev).and (Ioo_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num))).exists
  set S := v - e (α + π / 2) with hS
  obtain ⟨x₀, -, hHeq, hvH⟩ := hsec
  have hHI : hornSet v α (-1) κ₂ r ⊆ F.interiorPts := by
    rw [hHeq]; exact (connectedComponentIn_subset _ _).trans inter_subset_left
  have hFlI : hornSet v α κ' (-1) r ⊆ F.interiorPts := fun z hz => (hfl hz).1
  have hjoin : ∀ B : Set ℂ, IsPreconnected B → B ⊆ F.interiorPts ∩ ball v r → ∀ p ∈ B, p ∈ hornSet v α (-1) κ₂ r →
      B ⊆ hornSet v α (-1) κ₂ r := by
    intro B hB hBsub p hpB hpH
    rw [hHeq] at hpH ⊢
    rw [connectedComponentIn_eq hpH]
    exact hB.subset_connectedComponentIn hpB hBsub
  set O : Set ℂ := {z | dist z v < r ∧ 0 < frameX v α z ∧ TanAbove v α κ' z ∧ TanBelow v α κ₂ z} with hOdef
  have hOopen : IsOpen O := by
    have hfx : Continuous (frameX v α) := by unfold frameX; fun_prop
    have ht : ∀ κ : ℝ, Continuous fun z => tanHeight κ (frameX v α z) (frameY v α z) := fun κ => by
      unfold tanHeight frameX frameY; fun_prop
    exact (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
      ((isOpen_lt continuous_const hfx).inter ((isOpen_lt continuous_const (ht κ')).inter (isOpen_lt (ht κ₂) continuous_const)))
  have hOball : O ⊆ ball v r := fun z hz => hz.1
  have hOH : ∀ z ∈ O, 1 < dist z S → z ∈ hornSet v α (-1) κ₂ r := fun z hz hz' =>
    ⟨hz.1, hz.2.1, (tanAbove_neg_one_iff v α z).mpr hz', hz.2.2.2⟩
  have hOF : ∀ z ∈ O, dist z S < 1 → z ∈ hornSet v α κ' (-1) r := fun z hz hz' =>
    ⟨hz.1, hz.2.1, hz.2.2.1, (tanBelow_neg_one_iff v α z).mpr hz'⟩
  have hHS : ∀ z ∈ hornSet v α (-1) κ₂ r, 1 < dist z S := fun z hz => (tanAbove_neg_one_iff v α z).mp hz.2.2.1
  have hdS : ∀ ρ θ : ℝ, 0 ≤ ρ → dist (S + (ρ : ℂ) * e θ) S = ρ := fun ρ θ hρ => by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hρ]
  have hdd : ∀ ρ θ : ℝ, dist (S + (ρ : ℂ) * e θ) (S + e θ) = |ρ - 1| := fun ρ θ => by
    rw [dist_eq_norm, show S + (ρ : ℂ) * e θ - (S + e θ) = ((ρ - 1 : ℝ) : ℂ) * e θ by push_cast; ring, norm_mul, norm_e, mul_one,
      Complex.norm_real, Real.norm_eq_abs]
  set τ := min (r / 2) 1 with hτ
  have hτ0 : 0 < τ := lt_min (by linarith [hr0.1]) one_pos
  have hτr : τ ≤ r / 2 := min_le_left _ _
  have hτ1 : τ ≤ 1 := min_le_right _ _
  have hapt : ∀ t, ringPt S (α + π / 2 - t) = fromFrame v α (Real.sin t) (-(1 - Real.cos t)) := fun t => by
    have := normalPt_sub_add_eq_fromFrame v α 1 t
    rw [ofReal_one, one_mul, one_mul, one_mul] at this
    rw [ringPt, ← this]
  have hadist : ∀ t, 0 ≤ t → dist (ringPt S (α + π / 2 - t)) v ≤ t := by
    intro t ht
    have h := frame_normSq v α (ringPt S (α + π / 2 - t))
    rw [hapt, frameX_fromFrame, frameY_fromFrame, ← hapt, ← dist_eq_norm] at h
    have hc := Real.one_sub_sq_div_two_le_cos (x := t)
    have hsc := Real.sin_sq_add_cos_sq t
    have h2 : dist (ringPt S (α + π / 2 - t)) v ^ 2 ≤ t ^ 2 := by nlinarith
    nlinarith [dist_nonneg (x := ringPt S (α + π / 2 - t)) (y := v)]
  have hainO : ∀ t ∈ Ioc 0 τ, ringPt S (α + π / 2 - t) ∈ O := by
    intro t ht
    have hcos : Real.cos t < 1 := by
      have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) (by linarith [ht.2, hτ1]) ht.1
      rwa [Real.cos_zero] at this
    have hsin : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht.1 (by linarith [ht.2, hτ1])
    have hsc := Real.sin_sq_add_cos_sq t
    refine ⟨by linarith [hadist t ht.1.le, hr0.1, ht.2, hτr], ?_, ?_, ?_⟩
    · rw [hapt, frameX_fromFrame]; exact hsin
    · unfold TanAbove; rw [hapt, frameX_fromFrame, frameY_fromFrame]; unfold tanHeight
      nlinarith
    · unfold TanBelow; rw [hapt, frameX_fromFrame, frameY_fromFrame]; unfold tanHeight
      nlinarith
  have hnotI : ∀ t ∈ Ioc 0 τ, ringPt S (α + π / 2 - t) ∉ F.interiorPts := by
    intro t ht hI
    set a := ringPt S (α + π / 2 - t) with ha
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp (F.isOpen_interiorPts.inter hOopen) a ⟨hI, hainO t ht⟩
    have hae : a = S + e (α + π / 2 - t) := rfl
    set s := min (δ / 2) (1 / 2) with hs
    have hs0 : 0 < s := lt_min (by linarith) (by norm_num)
    have hsδ : s < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hs1 : s ≤ 1 / 2 := min_le_right _ _
    have hout : S + ((1 + s : ℝ) : ℂ) * e (α + π / 2 - t) ∈ ball a δ := by
      rw [mem_ball, hae, hdd, abs_of_pos (by linarith)]; linarith
    have hin : S + ((1 - s : ℝ) : ℂ) * e (α + π / 2 - t) ∈ ball a δ := by
      rw [mem_ball, hae, hdd, abs_of_neg (by linarith)]; linarith
    have hBsub : ball a δ ⊆ F.interiorPts ∩ ball v r := fun z hz => ⟨(hball hz).1, hOball (hball hz).2⟩
    have houtH := hOH _ (hball hout).2 (by rw [hdS _ _ (by linarith)]; linarith)
    have hsub := hjoin (ball a δ) (convex_ball a δ).isPreconnected hBsub _ hout houtH
    have := hHS _ (hsub hin)
    rw [hdS _ _ (by linarith)] at this
    linarith
  have hvnotI : v ∉ F.interiorPts := by
    intro hI
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts v hI
    set δ' := min δ r with hδ'
    have hδ'0 : 0 < δ' := lt_min hδ hr0.1
    have hBsub : ball v δ' ⊆ F.interiorPts ∩ ball v r := fun z hz =>
      ⟨hball (ball_subset_ball (min_le_left _ _) hz), ball_subset_ball (min_le_right _ _) hz⟩
    obtain ⟨p, hpB, hpH⟩ := mem_closure_iff.mp hvH (ball v δ') isOpen_ball (mem_ball_self hδ'0)
    have hsub := hjoin (ball v δ') (convex_ball v δ').isPreconnected hBsub p hpB hpH
    have hq : fromFrame v α (-(δ' / 2)) 0 ∈ ball v δ' := by
      rw [mem_ball, dist_eq_norm]
      unfold fromFrame
      rw [show v + ((((-(δ' / 2) : ℝ) : ℂ) + ((0 : ℝ) : ℂ) * I)) * e α - v = ((-(δ' / 2) : ℝ) : ℂ) * e α by push_cast; ring,
        norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos (by linarith)]
      linarith
    have := (hsub hq).2.1
    rw [frameX_fromFrame] at this
    linarith
  have hdomv : ∀ z, dist z v < r → z ∈ F.dom := fun z hz => hv (by rw [mem_closedBall]; linarith [hr0.2])
  have hΓ : ringArc S (α + π / 2 - τ) (α + π / 2) ⊆ F.Γ := by
    rintro _ ⟨θ, hθ, rfl⟩
    have hθe : θ = α + π / 2 - (α + π / 2 - θ) := by ring
    rcases (show 0 ≤ α + π / 2 - θ by linarith [hθ.2]).eq_or_lt with h0 | hpos
    · have hθ0 : θ = α + π / 2 := by linarith
      have hv' : ringPt S θ = v := by
        rw [hθ0, show α + π / 2 = α + π / 2 - 0 by ring, hapt]; simp [fromFrame]
      rw [hv']
      exact ⟨hdomv v (by rw [dist_self]; exact hr0.1), not_not.mp fun h => hvnotI ⟨hdomv v (by rw [dist_self]; exact hr0.1), h⟩⟩
    · have ht : α + π / 2 - θ ∈ Ioc 0 τ := ⟨hpos, by linarith [hθ.1]⟩
      rw [hθe]
      have hd := hdomv _ (hainO _ ht).1
      exact ⟨hd, not_not.mp fun h => hnotI _ ht ⟨hd, h⟩⟩
  have hclean : ∀ θ ∈ Ioo (α + π / 2 - τ) (α + π / 2), ∃ δ > 0, ball (ringPt S θ) δ ⊆ F.dom ∧
      ∀ z ∈ ball (ringPt S θ) δ, z ∈ ⋃ a ∈ F.arcs, a.carrier → dist z S = 1 := by
    intro θ hθ
    have ht : α + π / 2 - θ ∈ Ioc 0 τ := ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
    have hmem := hainO _ ht
    rw [show α + π / 2 - (α + π / 2 - θ) = θ by ring] at hmem
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hOopen _ hmem
    refine ⟨δ, hδ, fun z hz => hdomv z (hball hz).1, fun z hz hza => ?_⟩
    have hzO := hball hz
    by_contra hne
    rcases lt_or_gt_of_ne hne with h' | h'
    · exact (hFlI (hOF z hzO h')).2 hza
    · exact (hHI (hOH z hzO h')).2 hza
  obtain ⟨c₀, c₀', hR⟩ := isRingArc_of_clean (by linarith) hΓ hclean
  set m := α + π / 2 - τ / 2 with hm
  have hmI : m ∈ Ioo (α + π / 2 - τ) (α + π / 2) := ⟨by linarith, by linarith⟩
  have hmO : ringPt S m ∈ O := hainO (τ / 2) ⟨by linarith, by linarith⟩
  obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hOopen _ hmO
  have hme : ringPt S m = S + e m := rfl
  have hhin : h ∈ F.innerColours S (ringPt S m) := by
    show ringPt S m ∈ closure (F.region h ∩ ball S 1)
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min (min (ε / 2) (δ / 2)) (1 / 2) with hs
    have hs0 : 0 < s := lt_min (lt_min (by linarith) (by linarith)) (by norm_num)
    have hs1 := min_le_left (min (ε / 2) (δ / 2)) (1 / 2)
    have hs2 := min_le_right (min (ε / 2) (δ / 2)) (1 / 2)
    have hs3 := min_le_left (ε / 2) (δ / 2)
    have hs4 := min_le_right (ε / 2) (δ / 2)
    have hd1 : dist (S + ((1 - s : ℝ) : ℂ) * e m) (ringPt S m) = s := by
      rw [hme, hdd, abs_of_neg (by linarith)]; ring
    have hbO : S + ((1 - s : ℝ) : ℂ) * e m ∈ O := hball (by rw [mem_ball, hd1]; linarith)
    have hbS : dist (S + ((1 - s : ℝ) : ℂ) * e m) S < 1 := by rw [hdS _ _ (by linarith)]; linarith
    refine ⟨_, ⟨hfl (hOF _ hbO hbS), hbS⟩, ?_⟩
    rw [dist_comm, hd1]; linarith
  have hcout : c ∈ F.outerColours S (ringPt S m) := by
    show ringPt S m ∈ closure (F.region c \ closedBall S 1)
    rw [Metric.mem_closure_iff]
    intro ε hε
    set s := min (ε / 2) (δ / 2) with hs
    have hs0 : 0 < s := lt_min (by linarith) (by linarith)
    have hs3 := min_le_left (ε / 2) (δ / 2)
    have hs4 := min_le_right (ε / 2) (δ / 2)
    have hd1 : dist (S + ((1 + s : ℝ) : ℂ) * e m) (ringPt S m) = s := by
      rw [hme, hdd, abs_of_pos (by linarith)]; ring
    have hbO : S + ((1 + s : ℝ) : ℂ) * e m ∈ O := hball (by rw [mem_ball, hd1]; linarith)
    have hbS : 1 < dist (S + ((1 + s : ℝ) : ℂ) * e m) S := by rw [hdS _ _ (by linarith)]; linarith
    have hbH := hOH _ hbO hbS
    refine ⟨_, ⟨⟨hHI hbH, hcol hbH⟩, by rw [mem_closedBall, not_le]; exact hbS⟩, ?_⟩
    rw [dist_comm, hd1]; linarith
  have hhc : h = c₀ := by
    have := (hR.2.2 m hmI).1 ▸ hhin; exact this
  have hcc : c = c₀' := by
    have := (hR.2.2 m hmI).2 ▸ hcout; exact this
  subst hhc hcc
  exact ⟨α + π / 2 - τ, by linarith, hR⟩

/-- **FS112-N2-FLANK-Q's (R2) shadow, lower** (child of `flankQ_lower`, the mirror of `flankQ_upper_shadow`): if the radius-2 arc over
`[θ₁, α + π/2]` about `S′` lies in the closure of the flank colour `h`'s class, `h`'s class shadows every horn point near `v` above
`ω(S′)`. -/
theorem flankQ_lower_shadow (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {h : Fin k}
    (hh : F.IsFlankBelow v α (-1) h) {θ₁ : ℝ} (hθ₁ : θ₁ < α + π / 2)
    (hR2 : radiusTwoArc (v - e (α + π / 2)) θ₁ (α + π / 2) ⊆ closure (F.region h)) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α (-1) κ₂ r ⊆ shadow (F.region h) := by
  have _ := hF
  have _ := hh
  set θ₀ := α + π / 2 with hθ₀
  set S := v - e θ₀ with hS
  have hb0 : e θ₀ ≠ 0 := by intro h; simpa [h] using norm_e θ₀
  -- `N = S + 2 e(θ₀)` is in the domain
  have hN : S + 2 * e θ₀ ∈ F.dom := by
    refine hv ?_
    rw [mem_closedBall, hS, dist_eq_norm, show v - e θ₀ + 2 * e θ₀ - v = e θ₀ by ring, norm_e]
  obtain ⟨ε₁, hε₁, hgood⟩ := Metric.eventually_nhds_iff.mp (eventually_nhdsWithin_iff.mp (eventually_arcs_on_sphere_two hN))
  set ε := min ε₁ (θ₀ - θ₁) with hε
  have hε0 : 0 < ε := lt_min hε₁ (by linarith)
  -- the frame coordinate `u = (z − S′)/e(θ₀)`, equal to `1` at `v`; its conjugate is above the real axis on the horn
  set u : ℂ → ℂ := fun z => starRingEnd ℂ ((z - S) / e θ₀) with hu
  have huc : Continuous u := by rw [hu]; fun_prop (disch := exact hb0)
  have huv : u v = 1 := by
    rw [hu]; simp only; rw [hS, show v - (v - e θ₀) = e θ₀ by ring, div_self hb0, map_one]
  have hev : ∀ᶠ z in 𝓝 v, r2Cross (u z) < ε ∧ ‖u z‖ < 3 := by
    have h1 : ∀ᶠ z in 𝓝 v, r2Cross (u z) < ε := by
      have hc : ContinuousAt (r2Cross ∘ u) v :=
        ContinuousAt.comp (by rw [huv]; exact continuousAt_r2Cross_one) huc.continuousAt
      have : (r2Cross ∘ u) v = 0 := by simp only [Function.comp, huv, r2Cross_one]
      exact hc.eventually (gt_mem_nhds (show (r2Cross ∘ u) v < ε by rw [this]; exact hε0))
    have h2 : ∀ᶠ z in 𝓝 v, ‖u z‖ < 3 := by
      have hc : ContinuousAt (fun z => ‖u z‖) v := (continuous_norm.comp huc).continuousAt
      exact hc.eventually (gt_mem_nhds (show ‖u v‖ < 3 by rw [huv]; norm_num))
    exact h1.and h2
  obtain ⟨δ, hδ, hδev⟩ := Metric.eventually_nhds_iff.mp hev
  filter_upwards [Ioo_mem_nhdsGT hδ] with r hr z hz
  obtain ⟨hzr, hzx, hzA, -⟩ := hz
  obtain ⟨hsc, hu3⟩ := hδev (lt_trans hzr hr.2)
  have hzS : z - S = e θ₀ * starRingEnd ℂ (u z) := by
    rw [hu]; simp only; rw [Complex.conj_conj]; field_simp
  have hun : ‖u z‖ = dist z S := by
    rw [hu]; simp only; rw [Complex.norm_conj, norm_div, norm_e, div_one, dist_eq_norm]
  have hu1 : 1 < ‖u z‖ := by rw [hun]; exact (tanAbove_neg_one_iff v α z).mp hzA
  have huim : 0 < (u z).im := by
    have : (u z).im = frameX v α z := by
      rw [hu]; simp only
      rw [Complex.conj_im, hS, show z - (v - e θ₀) = (z - v) + e θ₀ by ring, add_div, div_self hb0]
      unfold frameX
      have hinv : (e θ₀)⁻¹ = starRingEnd ℂ (e θ₀) := by
        rw [Complex.inv_def, Complex.normSq_eq_norm_sq, norm_e]; simp
      have hI : e (π / 2) = I := by rw [e_eq]; simp
      rw [div_eq_mul_inv, hinv, hθ₀, e_add, hI, map_mul, Complex.conj_I]
      simp only [Complex.add_im, Complex.one_im, add_zero, Complex.mul_re, Complex.mul_im, Complex.neg_re, Complex.neg_im,
        Complex.I_re, Complex.I_im]
      ring
    rw [this]; exact hzx
  obtain ⟨hw0, hwc, hcw, hin, hout⟩ := r2Cross_spec hu1 hu3 huim
  set sc := r2Cross (u z) with hscdef
  have hsc0 : 0 < sc := by linarith
  -- the crossing point `p = S′ + 2 e(θ₀ − sc)`
  obtain ⟨hpd, η₀, hη₀, harc⟩ := hgood (by
    rw [Real.dist_eq, show θ₀ - sc - θ₀ = -sc by ring, abs_neg, abs_of_pos hsc0]; exact lt_of_lt_of_le hsc (min_le_left _ _))
    (by intro h; simp only [mem_singleton_iff] at h; linarith)
  have hpcl : S + 2 * e (θ₀ - sc) ∈ closure (F.region h) := by
    refine hR2 ⟨θ₀ - sc, ⟨?_, by linarith⟩, rfl⟩
    have := lt_of_lt_of_le hsc (min_le_right ε₁ (θ₀ - θ₁)); linarith
  have hdist : ∀ t, dist z (S + 2 * e (θ₀ - t)) = ‖2 * e t - u z‖ := by
    intro t
    calc dist z (S + 2 * e (θ₀ - t)) = ‖(z - S) - 2 * (e θ₀ * e (-t))‖ := by
          rw [dist_eq_norm, sub_eq_add_neg θ₀ t, e_add]; congr 1; ring
      _ = ‖e θ₀ * starRingEnd ℂ (u z - 2 * e t)‖ := by
          rw [hzS, map_sub, map_mul, conj_e, show (starRingEnd ℂ) (2 : ℂ) = 2 from map_ofNat _ 2]; congr 1; ring
      _ = ‖2 * e t - u z‖ := by rw [norm_mul, norm_e, one_mul, Complex.norm_conj, norm_sub_rev]
  refine mem_shadow_of_crossing hpd hpcl hη₀ harc fun d hd => ?_
  set d' := min d (sc - Complex.arg (u z)) / 2 with hd'
  have hd'0 : 0 < d' := by
    have : 0 < min d (sc - Complex.arg (u z)) := lt_min hd (by linarith)
    linarith
  have hd'1 : d' < d := by
    have := min_le_left d (sc - Complex.arg (u z)); linarith
  have hd'2 : d' < sc - Complex.arg (u z) := by
    have := min_le_right d (sc - Complex.arg (u z)); linarith
  refine ⟨θ₀ - (sc - d'), θ₀ - (sc + d'), ?_, ?_, ?_, ?_⟩
  · rw [show θ₀ - (sc - d') - (θ₀ - sc) = d' by ring, abs_of_pos hd'0]; exact hd'1
  · rw [show θ₀ - (sc + d') - (θ₀ - sc) = -d' by ring, abs_neg, abs_of_pos hd'0]; exact hd'1
  · rw [hdist]; exact hin _ (by linarith) (by linarith)
  · rw [hdist]; exact hout _ (by linarith) (by linarith [Real.pi_pos])

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
  have _ := hcS
  have hπ := Real.pi_pos
  set S := v - e (α + π / 2) with hS
  have hSdom : S ∈ F.dom := hv (by rw [mem_closedBall, hS, dist_eq_norm]; simp)
  obtain ⟨θ₁, hθ₁, hR⟩ := hH.isRingArc_lower hv hh
  set m := (θ₁ + (α + π / 2)) / 2 with hm
  have hmI : m ∈ Ioo θ₁ (α + π / 2) := ⟨by linarith, by linarith⟩
  have huniq : ∀ d d', F.IsRingArc S θ₁ (α + π / 2) d d' → d = h ∧ d' = c := by
    intro d d' hR'
    have h2 := (hR.2.2 m hmI).1
    have h4 := (hR.2.2 m hmI).2
    rw [(hR'.2.2 m hmI).1] at h2
    rw [(hR'.2.2 m hmI).2] at h4
    exact ⟨Set.singleton_eq_singleton_iff.mp h2, Set.singleton_eq_singleton_iff.mp h4⟩
  obtain ⟨κ', hκ', hhev⟩ := hh
  have hflank : ∀ ε > 0, ∃ f ∈ F.region h, dist f v < ε ∧ dist f S < 1 ∧ frameY v α f < 0 := by
    intro ε hε
    obtain ⟨r, hr, hrpos⟩ := (hhev.and (Ioo_mem_nhdsGT hε)).exists
    obtain ⟨z, hz, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := κ') (κ₂ := -1) (s := (κ' - 1) / 2) (m := -1)
      hrpos.1 (by linarith) (by linarith) (by intro h'; linarith)
    refine ⟨z, hr hz, by linarith [hz.1, hrpos.2], (tanBelow_neg_one_iff v α z).mp hz.2.2.2, ?_⟩
    have := hz.2.2.2
    unfold TanBelow tanHeight at this
    nlinarith [sq_nonneg (frameX v α z), sq_nonneg (frameY v α z)]
  have htile : ∀ f ∈ F.region h, F.TileOf h (connectedComponentIn F.interiorPts f) ∧
      f ∈ connectedComponentIn F.interiorPts f := by
    intro f hf
    have hT : F.IsTile (connectedComponentIn F.interiorPts f) := ⟨f, hf.1, rfl⟩
    have hfT : f ∈ connectedComponentIn F.interiorPts f := mem_connectedComponentIn hf.1
    refine ⟨?_, hfT⟩
    have := hT.tileOf hfT
    rwa [show F.col f = h from hf.2] at this
  rcases hQR _ _ _ _ hR with hQ | hR2
  · obtain ⟨d, d', hR', hd, -, -⟩ := id hQ
    rw [(huniq d d' hR').1] at hd
    obtain ⟨T, hT, hST⟩ := (F.mem_coloursAt_iff_exists_tileOf hSdom).mp hd
    refine ⟨θ₁, hθ₁, hR, Or.inl ⟨hQ, T, hT, ?_, hST⟩⟩
    have hnear : ∀ t ∈ T, ∀ f ∈ F.region h, dist f S < 1 → dist t f < 1 := by
      intro t ht f hf hfS
      obtain ⟨hTf, hfT⟩ := htile f hf
      rcases unitNear_or_unitFar hF hT hTf with h' | h'
      · exact h' t ht f hfT
      · exfalso
        obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hST (1 - dist f S) (by linarith)
        have h1 := h' y hy f hfT
        have := dist_triangle y S f
        rw [dist_comm S f] at this
        rw [dist_comm] at hyd
        linarith
    have hTv : T ⊆ closedBall v 1 := by
      intro t ht
      rw [mem_closedBall]
      by_contra hlt
      push Not at hlt
      obtain ⟨f, hf, hfv, hfS, -⟩ := hflank (dist t v - 1) (by linarith)
      have h1 := hnear t ht f hf hfS
      have := dist_triangle t f v
      linarith
    have := hT.1.isOpen.subset_interior_iff.mpr hTv
    rwa [interior_closedBall v one_ne_zero] at this
  · obtain ⟨d, d', hR', -, hd, hsub⟩ := id hR2
    rw [(huniq d d' hR').1] at hd hsub
    have hN : v + e (α + π / 2) = S + 2 * e (α + π / 2) := by rw [hS]; ring
    have hNh : v + e (α + π / 2) ∈ closure (F.region h) := by
      rw [hN]; exact hsub ⟨α + π / 2, ⟨hθ₁.le, le_rfl⟩, rfl⟩
    refine ⟨θ₁, hθ₁, hR, Or.inr ⟨hR2, hd, hNh, ?_, flankQ_lower_shadow hF hv ⟨κ', hκ', hhev⟩ hθ₁ hsub⟩⟩
    intro T hT hNT
    have hfar : ∀ t ∈ T, ∀ f ∈ F.region h, frameY v α f < 0 → 1 < dist t f := by
      intro t ht f hf hfy
      have hfN : 1 < dist f (v + e (α + π / 2)) := by
        have h' := sq_dist_N v α f
        nlinarith [sq_nonneg (frameX v α f), dist_nonneg (x := f) (y := v + e (α + π / 2))]
      obtain ⟨hTf, hfT⟩ := htile f hf
      rcases unitNear_or_unitFar hF hT hTf with h' | h'
      · exfalso
        obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hNT (dist f (v + e (α + π / 2)) - 1) (by linarith)
        have h1 := h' y hy f hfT
        have := dist_triangle f y (v + e (α + π / 2))
        rw [dist_comm f y] at this
        rw [dist_comm] at hyd
        linarith
      · exact h' t ht f hfT
    have hTv : T ⊆ {w | 1 ≤ dist w v} := by
      intro t ht
      show 1 ≤ dist t v
      by_contra hlt
      push Not at hlt
      obtain ⟨f, hf, hfv, -, hfy⟩ := hflank (1 - dist t v) (by linarith)
      have h1 := hfar t ht f hf hfy
      have := dist_triangle t v f
      rw [dist_comm v f] at this
      linarith
    have hint := hT.1.isOpen.subset_interior_iff.mpr hTv
    have hcompl : {w : ℂ | 1 ≤ dist w v} = (ball v 1)ᶜ := by ext w; simp [mem_ball, not_lt]
    rw [hcompl, interior_compl, closure_ball v one_ne_zero] at hint
    exact Set.disjoint_left.mpr fun t ht htB => hint ht htB

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

open MeasureTheory in
/-- **Six translates of a thin periodic set** (child of FS112-A4SIX): a measurable set of angles whose part in `[0, 2π)` has measure
below `π/3` misses all six points `x + j·60°` of some shift `x`. -/
theorem exists_shift_avoiding {S : Set ℝ} (hS : MeasurableSet S) (h : volume (S ∩ Ico 0 (2 * π)) < ENNReal.ofReal (π / 3)) :
    ∃ x : ℝ, ∀ j : ℕ, j < 6 → x + j * (π / 3) ∉ S := by
  have hπ := Real.pi_pos
  by_contra hno
  push Not at hno
  set I : ℕ → Set ℝ := fun j => Ico (j * (π / 3)) (j * (π / 3) + π / 3) with hI
  set T : ℕ → Set ℝ := fun j => (fun x => x + j * (π / 3)) ⁻¹' (S ∩ I j) with hT
  have hcov : Ico 0 (π / 3) ⊆ ⋃ j ∈ Finset.range 6, T j := by
    intro x hx
    obtain ⟨j, hj, hjS⟩ := hno x
    refine mem_iUnion₂.mpr ⟨j, Finset.mem_range.mpr hj, hjS, ?_, ?_⟩
    · show (j : ℝ) * (π / 3) ≤ x + j * (π / 3); linarith [hx.1]
    · show x + j * (π / 3) < j * (π / 3) + π / 3; linarith [hx.2]
  have hdisj : PairwiseDisjoint (↑(Finset.range 6)) fun j => S ∩ I j := by
    intro i _ j _ hij
    refine Set.disjoint_left.mpr fun x hxi hxj => hij ?_
    have h1 := hxi.2; have h2 := hxj.2
    simp only [hI, mem_Ico] at h1 h2
    have hij1 : (i : ℝ) < j + 1 := by
      by_contra hc; push Not at hc
      nlinarith [mul_le_mul_of_nonneg_right hc (by positivity : (0 : ℝ) ≤ π / 3)]
    have hji1 : (j : ℝ) < i + 1 := by
      by_contra hc; push Not at hc
      nlinarith [mul_le_mul_of_nonneg_right hc (by positivity : (0 : ℝ) ≤ π / 3)]
    have a1 : i < j + 1 := by exact_mod_cast hij1
    have a2 : j < i + 1 := by exact_mod_cast hji1
    omega
  have hsub : (⋃ j ∈ Finset.range 6, S ∩ I j) ⊆ S ∩ Ico 0 (2 * π) := by
    intro x hx
    obtain ⟨j, hj, hxS, hx1, hx2⟩ := mem_iUnion₂.mp hx
    have hj6 : (j : ℝ) + 1 ≤ 6 := by
      have := Finset.mem_range.mp hj; exact_mod_cast this
    refine ⟨hxS, ?_, ?_⟩
    · have : (0 : ℝ) ≤ j * (π / 3) := by positivity
      linarith
    · nlinarith
  have hvol : volume (Ico (0 : ℝ) (π / 3)) = ENNReal.ofReal (π / 3) := by
    rw [Real.volume_Ico, sub_zero]
  have : ENNReal.ofReal (π / 3) ≤ volume (S ∩ Ico 0 (2 * π)) :=
    calc ENNReal.ofReal (π / 3) = volume (Ico (0 : ℝ) (π / 3)) := hvol.symm
      _ ≤ volume (⋃ j ∈ Finset.range 6, T j) := measure_mono hcov
      _ ≤ ∑ j ∈ Finset.range 6, volume (T j) := measure_biUnion_finset_le _ _
      _ = ∑ j ∈ Finset.range 6, volume (S ∩ I j) := by
          refine Finset.sum_congr rfl fun j _ => ?_
          exact measure_preimage_add_right volume (j * (π / 3)) (S ∩ I j)
      _ = volume (⋃ j ∈ Finset.range 6, S ∩ I j) :=
          (measure_biUnion_finset hdisj fun j _ => hS.inter measurableSet_Ico).symm
      _ ≤ volume (S ∩ Ico 0 (2 * π)) := measure_mono hsub
  exact absurd h (not_lt.mpr this)

/-- On a covered ring, the points of `Γ` form a closed set (finitely many compact arcs meet the ring). -/
theorem isClosed_Γ_inter_sphere {p : ℂ} (hp : F.Covers p 1) : IsClosed (F.Γ ∩ sphere p 1) := by
  have hK : sphere p 1 ⊆ F.dom := sphere_subset_closedBall.trans hp
  choose! t ht hfin using F.locallyFinite
  obtain ⟨S, hSK, hcov⟩ := (isCompact_sphere p 1).elim_nhds_subcover t fun x hx => ht x (hK hx)
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ sphere p 1).Nonempty} with h𝒜def
  have h𝒜 : 𝒜.Finite := by
    refine (S.finite_toSet.biUnion fun x hx => hfin x (hK (hSK x hx))).subset ?_
    rintro a ⟨ha, y, hya, hyK⟩
    obtain ⟨x, hxS, hyx⟩ := mem_iUnion₂.mp (hcov hyK)
    exact mem_iUnion₂.mpr ⟨x, hxS, ha, y, hya, hyx⟩
  have heq : F.Γ ∩ sphere p 1 = (⋃ a ∈ 𝒜, a.carrier) ∩ sphere p 1 := by
    ext y
    constructor
    · rintro ⟨⟨-, hy⟩, hys⟩
      obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hy
      exact ⟨mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, hys⟩, hya⟩, hys⟩
    · rintro ⟨hy, hys⟩
      obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hy
      exact ⟨⟨hK hys, mem_iUnion₂.mpr ⟨a, ha.1, hya⟩⟩, hys⟩
  rw [heq]
  exact (h𝒜.isClosed_biUnion fun a _ => a.isClosed_carrier).inter isClosed_sphere

open MeasureTheory in
/-- The angles of a point of the plane on a ring are countably many (`e` has period `2π`). -/
theorem countable_ringPt_preimage (p c : ℂ) : (ringPt p ⁻¹' {c}).Countable := by
  rcases (ringPt p ⁻¹' {c}).eq_empty_or_nonempty with h | ⟨θ₀, hθ₀⟩
  · rw [h]; exact countable_empty
  · refine (countable_range fun n : ℤ => θ₀ + n * (2 * π)).mono fun θ hθ => ?_
    have h1 : e θ = e θ₀ := by
      have := hθ.trans hθ₀.symm
      simpa [ringPt] using this
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp h1
    exact ⟨n, hn.symm⟩

/-- **The covering change point** (wave 4's engine 7): on a window `[s, s + w]` of `ω(v)` whose interior points carry only the colours
`a`, `b`, whose ends are interior points of colours `a` and `b`, and which holds no positive-length arc of `Γ` strictly inside, some point
carries both `a` and `b` (the window is the union of the two closed sets of points carrying `a` and carrying `b`). -/
theorem exists_coveringPoint_of_window {v : ℂ} (hv : F.Covers v 1) {s w : ℝ} (hw : 0 < w) {a b : Fin k}
    (hsa : ringPt v s ∈ F.region a) (hsb : ringPt v (s + w) ∈ F.region b)
    (hcol : ∀ θ ∈ Icc s (s + w), ringPt v θ ∈ F.interiorPts → F.col (ringPt v θ) = a ∨ F.col (ringPt v θ) = b)
    (hno : ¬ ∃ θ₁ θ₂, s < θ₁ ∧ θ₁ < θ₂ ∧ θ₂ < s + w ∧ ringArc v θ₁ θ₂ ⊆ F.Γ) :
    ∃ θ ∈ Icc s (s + w), a ∈ F.coloursAt (ringPt v θ) ∧ b ∈ F.coloursAt (ringPt v θ) := by
  have hcont : Continuous (ringPt v) := by unfold ringPt e; fun_prop
  have hdom : ∀ θ, ringPt v θ ∈ F.dom := fun θ => hv (sphere_subset_closedBall (ringPt_mem_sphere v θ))
  have hca : IsClosed {θ | ringPt v θ ∈ closure (F.region a)} := isClosed_closure.preimage hcont
  have hcb : IsClosed {θ | ringPt v θ ∈ closure (F.region b)} := isClosed_closure.preimage hcont
  have hcover : Icc s (s + w) ⊆ {θ | ringPt v θ ∈ closure (F.region a)} ∪ {θ | ringPt v θ ∈ closure (F.region b)} := by
    intro θ hθ
    show ringPt v θ ∈ closure (F.region a) ∨ ringPt v θ ∈ closure (F.region b)
    rw [← mem_union, ← closure_union, Metric.mem_closure_iff]
    intro ε hε
    set lo := max s (θ - ε / 2) with hlo
    set hi := min (s + w) (θ + ε / 2) with hhi
    have hlh : lo < hi := by
      rcases lt_or_eq_of_le hθ.1 with h1 | h1
      · exact max_lt (lt_min (by linarith) (by linarith [hθ.1])) (lt_min (by linarith [hθ.2]) (by linarith))
      · rw [hlo, hhi, ← h1]
        exact max_lt (lt_min (by linarith) (by linarith)) (lt_min (by linarith) (by linarith))
    have hθ₁ : s < (2 * lo + hi) / 3 := by linarith [le_max_left s (θ - ε / 2)]
    have hθ₂ : (lo + 2 * hi) / 3 < s + w := by linarith [min_le_left (s + w) (θ + ε / 2)]
    have hnot : ¬ ringArc v ((2 * lo + hi) / 3) ((lo + 2 * hi) / 3) ⊆ F.Γ := fun h =>
      hno ⟨_, _, hθ₁, by linarith, hθ₂, h⟩
    obtain ⟨_, ⟨φ, hφ, rfl⟩, hφΓ⟩ := Set.not_subset.mp hnot
    have hφI : ringPt v φ ∈ F.interiorPts := ⟨hdom φ, fun h => hφΓ ⟨hdom φ, h⟩⟩
    have hφw : φ ∈ Icc s (s + w) := ⟨by linarith [hφ.1], by linarith [hφ.2]⟩
    refine ⟨ringPt v φ, ?_, ?_⟩
    · rcases hcol φ hφw hφI with h | h
      · exact Or.inl ⟨hφI, h⟩
      · exact Or.inr ⟨hφI, h⟩
    · have h1 := dist_ringPt_ringPt_le v θ φ
      have h2 : |θ - φ| < ε := by
        rw [abs_lt]; constructor
        · linarith [hφ.2, min_le_right (s + w) (θ + ε / 2)]
        · linarith [hφ.1, le_max_right s (θ - ε / 2)]
      linarith
  obtain ⟨θ, hθ, hθa, hθb⟩ := isPreconnected_closed_iff.mp isPreconnected_Icc _ _ hca hcb hcover
    ⟨s, ⟨le_rfl, by linarith⟩, subset_closure hsa⟩ ⟨s + w, ⟨by linarith, le_rfl⟩, subset_closure hsb⟩
  exact ⟨θ, hθ, hθa, hθb⟩

open MeasureTheory in
/-- **FS112-A4SIX** (C-UA-BUDGET, branch 1), at the class its argument reads: a point `v` of a valid map at which exactly two colours
are absent (a four-colour vertex, at six colours), with no covering pair `(v, y)` on its unit circle, has on that circle arcs of `Γ`
of total length at least `60°`, or at least six, one inside each of six consecutive open `60°` windows. -/
theorem a4six (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {a b : Fin k} (hab : a ≠ b)
    (habs : (F.coloursAt v)ᶜ = {a, b}) (hno : ∀ y ∈ sphere v 1, ¬ F.IsCoveringPair v y) :
    ENNReal.ofReal (π / 3) ≤ arcLength {θ | F.OnRingArc v (ringPt v θ)} ∨
      ∃ x : ℝ, ∀ j : Fin 6, ∃ θ₁ θ₂, x + (j : ℕ) * (π / 3) < θ₁ ∧ θ₁ < θ₂ ∧ θ₂ < x + ((j : ℕ) + 1) * (π / 3) ∧
        ringArc v θ₁ θ₂ ⊆ F.Γ := by
  have hπ := Real.pi_pos
  by_cases hm : ENNReal.ofReal (π / 3) ≤ arcLength {θ | F.OnRingArc v (ringPt v θ)}
  · exact Or.inl hm
  right
  push Not at hm
  have hcont : Continuous (ringPt v) := by unfold ringPt e; fun_prop
  -- the angles of `Γ` on the ring: closed, and of measure below `π/3` in one turn
  set Sg : Set ℝ := ringPt v ⁻¹' (F.Γ ∩ sphere v 1) with hSg
  have hSm : MeasurableSet Sg := ((isClosed_Γ_inter_sphere hv).preimage hcont).measurableSet
  have hA : arcLength {θ | F.OnRingArc v (ringPt v θ)} = volume ({θ | F.OnRingArc v (ringPt v θ)} ∩ Ico 0 (2 * π)) :=
    Measure.restrict_apply' measurableSet_Ico
  set E := (F.Γ ∩ sphere v 1) \ {x | F.OnRingArc v x} with hEdef
  have hE : volume (ringPt v ⁻¹' E) = 0 := by
    refine Set.Countable.measure_zero ?_ volume
    exact ((F.finite_ringΓ_off_ringArc hv).countable.biUnion fun c _ => countable_ringPt_preimage v c).mono
      fun θ hθ => mem_iUnion₂.mpr ⟨ringPt v θ, hθ, rfl⟩
  have hSv : volume (Sg ∩ Ico 0 (2 * π)) < ENNReal.ofReal (π / 3) := by
    have hsub : Sg ∩ Ico 0 (2 * π) ⊆ ({θ | F.OnRingArc v (ringPt v θ)} ∩ Ico 0 (2 * π)) ∪ ringPt v ⁻¹' E := by
      rintro θ ⟨hθ, hθI⟩
      by_cases hon : F.OnRingArc v (ringPt v θ)
      · exact Or.inl ⟨hon, hθI⟩
      · exact Or.inr ⟨hθ, hon⟩
    calc volume (Sg ∩ Ico 0 (2 * π)) ≤ volume (({θ | F.OnRingArc v (ringPt v θ)} ∩ Ico 0 (2 * π)) ∪ ringPt v ⁻¹' E) :=
          measure_mono hsub
      _ ≤ volume ({θ | F.OnRingArc v (ringPt v θ)} ∩ Ico 0 (2 * π)) + volume (ringPt v ⁻¹' E) := measure_union_le _ _
      _ < ENNReal.ofReal (π / 3) := by rw [hE, add_zero, ← hA]; exact hm
  obtain ⟨x, hx⟩ := exists_shift_avoiding hSm hSv
  have hdom : ∀ θ, ringPt v θ ∈ F.dom := fun θ => hv (sphere_subset_closedBall (ringPt_mem_sphere v θ))
  -- the six points `x + i·60°` (and the seventh, one turn on) are interior points
  have hend : ∀ i : ℕ, i ≤ 6 → ringPt v (x + i * (π / 3)) ∈ F.interiorPts := by
    intro i hi
    have key : ∀ i' : ℕ, i' < 6 → ringPt v (x + i' * (π / 3)) ∈ F.interiorPts := fun i' hi' =>
      ⟨hdom _, fun h => hx i' hi' ⟨⟨hdom _, h⟩, ringPt_mem_sphere v _⟩⟩
    rcases lt_or_eq_of_le hi with h | rfl
    · exact key i h
    · have := key 0 (by norm_num)
      rw [show x + ((6 : ℕ) : ℝ) * (π / 3) = x + 2 * π by push_cast; ring, ringPt, e_add_two_pi]
      simpa [ringPt] using this
  -- the colours on the ring are the two absent at `v`
  have hcolS : ∀ θ, ringPt v θ ∈ F.interiorPts → F.col (ringPt v θ) = a ∨ F.col (ringPt v θ) = b := by
    intro θ hθ
    have hnot : F.col (ringPt v θ) ∉ F.coloursAt v := fun hc => ne1_region hF hc ⟨hθ, rfl⟩ (dist_ringPt v θ)
    have : F.col (ringPt v θ) ∈ (F.coloursAt v)ᶜ := hnot
    rw [habs] at this
    rcases this with h | h
    · exact Or.inl h
    · exact Or.inr h
  refine ⟨x, fun j => ?_⟩
  by_contra hnoarc
  set s := x + ((j : ℕ) : ℝ) * (π / 3) with hs
  have hs1 : x + (((j : ℕ) : ℝ) + 1) * (π / 3) = s + π / 3 := by rw [hs]; ring
  have hj6 : (j : ℕ) + 1 ≤ 6 := j.isLt
  have hy₀ : ringPt v s ∈ F.interiorPts := hend j (by omega)
  have hy₁ : ringPt v (s + π / 3) ∈ F.interiorPts := by
    have := hend ((j : ℕ) + 1) hj6
    rwa [show x + (((j : ℕ) + 1 : ℕ) : ℝ) * (π / 3) = s + π / 3 by rw [hs]; push_cast; ring] at this
  have hd : dist (ringPt v s) (ringPt v (s + π / 3)) = 1 := by
    have habs3 : |s - (s + π / 3)| = π / 3 := by
      rw [show s - (s + π / 3) = -(π / 3) by ring, abs_neg, abs_of_pos (by positivity)]
    exact ((dist_ringPt_ringPt_cmp_one v (by rw [habs3]; linarith)).1).mpr habs3
  have hne : F.col (ringPt v s) ≠ F.col (ringPt v (s + π / 3)) := hF _ hy₀ _ hy₁ hd
  have hno' : ¬ ∃ θ₁ θ₂, s < θ₁ ∧ θ₁ < θ₂ ∧ θ₂ < s + π / 3 ∧ ringArc v θ₁ θ₂ ⊆ F.Γ := by
    rintro ⟨θ₁, θ₂, h1, h2, h3, h4⟩
    exact hnoarc ⟨θ₁, θ₂, h1, h2, by rw [hs1]; exact h3, h4⟩
  have hcolW : ∀ θ ∈ Icc s (s + π / 3), ringPt v θ ∈ F.interiorPts →
      F.col (ringPt v θ) = a ∨ F.col (ringPt v θ) = b := fun θ _ hθ => hcolS θ hθ
  obtain ⟨θ, -, hθ1, hθ2⟩ : ∃ θ ∈ Icc s (s + π / 3), a ∈ F.coloursAt (ringPt v θ) ∧ b ∈ F.coloursAt (ringPt v θ) := by
    rcases hcolS s hy₀ with h0 | h0 <;> rcases hcolS (s + π / 3) hy₁ with h1 | h1
    · exact absurd (h0.trans h1.symm) hne
    · exact exists_coveringPoint_of_window hv (by positivity) ⟨hy₀, h0⟩ ⟨hy₁, h1⟩ hcolW hno'
    · obtain ⟨θ, hθ, hb, ha⟩ := exists_coveringPoint_of_window hv (by positivity) ⟨hy₀, h0⟩ ⟨hy₁, h1⟩
        (fun θ hθ hI => (hcolW θ hθ hI).symm) hno'
      exact ⟨θ, hθ, ha, hb⟩
    · exact absurd (h0.trans h1.symm) hne
  refine hno (ringPt v θ) (ringPt_mem_sphere v θ) ?_
  ext c
  simp only [mem_union, mem_univ, iff_true]
  by_cases hc : c ∈ F.coloursAt v
  · exact Or.inl hc
  · right
    have : c ∈ (F.coloursAt v)ᶜ := hc
    rw [habs] at this
    rcases this with rfl | rfl
    · exact hθ1
    · exact hθ2

/-- **The ring rotates its colours** (child of NB4P): if the germ of `ω(v)` on side `s` of `r(θ)` lies in the class of `c`, and
`r(θ + 60°)` is on no arc of `Γ` on `ω(v)`, the germ on side `s` of `r(θ + 60°)` lies in the class of a colour `d ≠ c` absent at
`v`. -/
theorem germ_rotate_third (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {θ : ℝ} {s : Side} {c : Fin k}
    (hg : GermIn v θ s (F.region c)) (hna : ¬ F.OnRingArc v (ringPt v (θ + π / 3))) :
    ∃ d, d ≠ c ∧ d ∉ F.coloursAt v ∧ GermIn v (θ + π / 3) s (F.region d) := by
  have hdom : ringPt v (θ + π / 3) ∈ F.dom := hv (sphere_subset_closedBall (ringPt_mem_sphere v _))
  rcases F.germ_dichotomy hdom s with ⟨d, hd⟩ | ⟨θ₁, θ₂, c₁, c₂, hA, hgA⟩
  · refine ⟨d, ?_, ?_, hd⟩
    · rintro rfl
      obtain ⟨δ, hδ, h1⟩ := hg
      obtain ⟨δ', hδ', h2⟩ := hd
      set t := min δ δ' / 2 with ht
      have ht0 : 0 < t := by positivity
      have htδ : t < δ := by have := min_le_left δ δ'; linarith
      have htδ' : t < δ' := by have := min_le_right δ δ'; linarith
      have hz1 : ringPt v (θ + s.sign * t) ∈ F.region d := h1 ⟨t, ⟨ht0, htδ⟩, rfl⟩
      have hz2 : ringPt v (θ + π / 3 + s.sign * t) ∈ F.region d := h2 ⟨t, ⟨ht0, htδ'⟩, rfl⟩
      have hd1 : dist (ringPt v (θ + s.sign * t)) (ringPt v (θ + π / 3 + s.sign * t)) = 1 := by
        rw [show θ + π / 3 + s.sign * t = (θ + s.sign * t) + 1 * (π / 3) by ring]
        exact dist_ringPt_third v _ 1 (Or.inl rfl)
      exact hF _ hz1.1 _ hz2.1 hd1 (hz1.2.trans hz2.2.symm)
    · obtain ⟨z, hz, hzs⟩ := GermIn.exists_mem_sphere hd
      exact not_mem_coloursAt_of_mem_sphere hF hzs hz
  · exact absurd ⟨θ₁, θ₂, hA.1, mem_ringArc_of_germIn hgA, hA.2.1⟩ hna

/-- **The straddlers of `ω(y_{k+1})` at `y_k`** (child of NB4P; `plans/FS112-N-proof.md` § 2.1 W1 (ii), (1) and (3), with NB-4's half-plane
step): let `y_k = r(θ)` and `y_{k+1} = r(θ + 60°)` on `ω(v)`, both absent colours `X`, `X'` carried at `y_{k+1}`, and `y_k` on no arc of `Γ`
on `ω(y_{k+1})`. Then the germ of `ω(y_{k+1})` at `y_k` inside `B(v, 1)` lies in one colour `i`, the one outside `B̄(v, 1)` in one colour
`o ≠ i`; both are colours of `v` carried at `y_k` and not at `y_{k+1}`; and `v`'s class of `i` approaches `v` only along directions facing
`y_k`, that of `o` only along directions facing away. -/
theorem straddlers_third (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {θ : ℝ} {X X' : Fin k}
    (hcompl : (F.coloursAt v)ᶜ = {X, X'})
    (hX : X ∈ F.coloursAt (ringPt v (θ + π / 3))) (hX' : X' ∈ F.coloursAt (ringPt v (θ + π / 3)))
    (hna : ¬ F.OnRingArc (ringPt v (θ + π / 3)) (ringPt v θ)) :
    ∃ i o, i ≠ o ∧ i ∈ F.coloursAt v ∧ o ∈ F.coloursAt v ∧
      i ∉ F.coloursAt (ringPt v (θ + π / 3)) ∧ o ∉ F.coloursAt (ringPt v (θ + π / 3)) ∧
      i ∈ F.coloursAt (ringPt v θ) ∧ o ∈ F.coloursAt (ringPt v θ) ∧
      (∀ β ∈ coneAt (F.region i) v, 0 ≤ Real.cos (β - θ)) ∧ (∀ β ∈ coneAt (F.region o) v, Real.cos (β - θ) ≤ 0) := by
  have hπ := Real.pi_pos
  set p := ringPt v (θ + π / 3) with hp
  set φ₀ := θ - π / 3 with hφ₀
  have hpt : ringPt p φ₀ = ringPt v θ := by
    rw [hp, hφ₀]; unfold ringPt; rw [add_assoc, e_add_third_add_e_sub_third]
  have hvd : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  have hdom : ringPt p φ₀ ∈ F.dom := by rw [hpt]; exact hv (sphere_subset_closedBall (ringPt_mem_sphere v _))
  have hgerm : ∀ s, ∃ c, GermIn p φ₀ s (F.region c) := by
    intro s
    rcases F.germ_dichotomy hdom s with h | ⟨θ₁, θ₂, c₁, c₂, hA, hgA⟩
    · exact h
    · exact absurd ⟨θ₁, θ₂, hA.1, hpt ▸ mem_ringArc_of_germIn hgA, hA.2.1⟩ hna
  obtain ⟨i, hi⟩ := hgerm .cw
  obtain ⟨o, ho⟩ := hgerm .ccw
  have hnotp : ∀ s c, GermIn p φ₀ s (F.region c) → c ∉ F.coloursAt p := by
    intro s c hg
    obtain ⟨z, hz, hzs⟩ := GermIn.exists_mem_sphere hg
    exact not_mem_coloursAt_of_mem_sphere hF hzs hz
  have hinv : ∀ c, c ∉ F.coloursAt p → c ∈ F.coloursAt v := by
    intro c hc
    by_contra h
    have : c ∈ (F.coloursAt v)ᶜ := h
    rw [hcompl] at this
    rcases this with rfl | rfl
    · exact hc hX
    · exact hc hX'
  have haty : ∀ s c, GermIn p φ₀ s (F.region c) → c ∈ F.coloursAt (ringPt v θ) := by
    intro s c ⟨δ, hδ, hsub⟩
    rw [← hpt]; exact closure_mono hsub (ringPt_mem_closure_germ p φ₀ s hδ)
  -- distances from `v` to the two germs
  have hdv : ∀ φ, dist v (ringPt p φ) ^ 2 = 2 + 2 * Real.cos (θ + π / 3 - φ) := by
    intro φ
    rw [hp, dist_eq_norm, show v - ringPt (ringPt v (θ + π / 3)) φ = -(e (θ + π / 3) + e φ) by unfold ringPt; ring, norm_neg,
      sq_norm_e_add_e]
  have hc23 : Real.cos (2 * π / 3) = -(1 / 2) := by
    rw [show 2 * π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have hin_d : ∀ t ∈ Ioo 0 (π / 3), dist v (ringPt p (φ₀ + Side.cw.sign * t)) < 1 := by
    intro t ht
    have hcos : Real.cos (2 * π / 3 + t) < -(1 / 2) := by
      rw [← hc23]; exact Real.cos_lt_cos_of_nonneg_of_le_pi (by positivity) (by linarith [ht.2]) (by linarith [ht.1])
    have h := hdv (φ₀ + Side.cw.sign * t)
    rw [show θ + π / 3 - (φ₀ + Side.cw.sign * t) = 2 * π / 3 + t by rw [hφ₀]; simp [Side.sign]; ring] at h
    nlinarith [dist_nonneg (x := v) (y := ringPt p (φ₀ + Side.cw.sign * t))]
  have hout_d : ∀ t ∈ Ioo 0 (π / 3), 1 < dist v (ringPt p (φ₀ + Side.ccw.sign * t)) := by
    intro t ht
    have hcos : -(1 / 2) < Real.cos (2 * π / 3 - t) := by
      rw [← hc23]; exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith [ht.2]) (by linarith) (by linarith [ht.1])
    have h := hdv (φ₀ + Side.ccw.sign * t)
    rw [show θ + π / 3 - (φ₀ + Side.ccw.sign * t) = 2 * π / 3 - t by rw [hφ₀]; simp [Side.sign]; ring] at h
    nlinarith [dist_nonneg (x := v) (y := ringPt p (φ₀ + Side.ccw.sign * t))]
  have hy1 : ‖v - ringPt p φ₀‖ = 1 := by
    rw [hpt, ← dist_eq_norm, dist_comm]; exact dist_ringPt v θ
  have hre : ∀ β, ((v - ringPt p φ₀) * starRingEnd ℂ (e β)).re = -Real.cos (β - θ) := by
    intro β
    rw [hpt, show v - ringPt v θ = -e θ by unfold ringPt; ring, neg_mul, Complex.neg_re, re_e_mul_conj_e,
      ← Real.cos_neg, neg_sub]
  have hconeI : ∀ β ∈ coneAt (F.region i) v, 0 ≤ Real.cos (β - θ) := by
    intro β hβ
    have := Valid.cone_re_nonpos_of_germ hF (hi.mono subset_closure) hy1 ⟨π / 3, by positivity, hin_d⟩ β hβ
    rw [hre] at this; linarith
  have hconeO : ∀ β ∈ coneAt (F.region o) v, Real.cos (β - θ) ≤ 0 := by
    intro β hβ
    have := Valid.cone_re_nonneg_of_germ hF (ho.mono subset_closure) hy1 ⟨π / 3, by positivity, hout_d⟩ β hβ
    rw [hre] at this; linarith
  refine ⟨i, o, ?_, hinv i (hnotp _ _ hi), hinv o (hnotp _ _ ho), hnotp _ _ hi, hnotp _ _ ho, haty _ _ hi, haty _ _ ho,
    hconeI, hconeO⟩
  -- an inner and an outer straddler at one point never share a colour (N-E2 against `v`'s tile of that colour)
  rintro rfl
  obtain ⟨Tv, hTv, hvTv⟩ := (F.mem_coloursAt_iff_exists_tileOf hvd).mp (hinv i (hnotp _ _ hi))
  -- the tile of a germ: it holds the germ, so has `y_k` in its closure
  have htile : ∀ s, GermIn p φ₀ s (F.region i) → ∃ t ∈ Ioo 0 (π / 3), ∃ T, F.TileOf i T ∧
      ringPt p (φ₀ + s.sign * t) ∈ T ∧ ringPt v θ ∈ closure T := by
    intro s ⟨δ, hδ, hsub⟩
    set t := min δ (π / 3) / 2 with ht
    have ht0 : 0 < t := by positivity
    have htδ : t < δ := by have := min_le_left δ (π / 3); linarith
    have htπ : t < π / 3 := by have := min_le_right δ (π / 3); linarith
    have hzg : ringPt p (φ₀ + s.sign * t) ∈ germ p φ₀ s δ := ⟨t, ⟨ht0, htδ⟩, rfl⟩
    have hz := hsub hzg
    have hgT : germ p φ₀ s δ ⊆ connectedComponentIn F.interiorPts (ringPt p (φ₀ + s.sign * t)) :=
      (isPreconnected_germ p φ₀ s δ).subset_connectedComponentIn hzg (hsub.trans (F.region_subset_interiorPts i))
    have hT : F.IsTile (connectedComponentIn F.interiorPts (ringPt p (φ₀ + s.sign * t))) := ⟨_, hz.1, rfl⟩
    have hTi := hT.tileOf (mem_connectedComponentIn hz.1)
    rw [show F.col (ringPt p (φ₀ + s.sign * t)) = i from hz.2] at hTi
    exact ⟨t, ⟨ht0, htπ⟩, _, hTi, mem_connectedComponentIn hz.1,
      hpt ▸ closure_mono hgT (ringPt_mem_closure_germ p φ₀ s hδ)⟩
  obtain ⟨t₁, ht₁, Tin, hTin, hz₁, hyin⟩ := htile .cw hi
  obtain ⟨t₂, ht₂, Tout, hTout, hz₂, hyout⟩ := htile .ccw ho
  have hnear := unitNear_of_mem_closure hF hTin hTv (subset_closure hz₁) hvTv (by rw [dist_comm]; exact hin_d t₁ ht₁)
  have hfar := unitFar_of_mem_closure hF hTout hTv (subset_closure hz₂) hvTv (by rw [dist_comm]; exact hout_d t₂ ht₂)
  have hsph : Tv ⊆ sphere (ringPt v θ) 1 := by
    intro b hb
    have h1 : dist (ringPt v θ) b ≤ 1 :=
      closure_minimal (fun a ha => (hnear a ha b hb).le) (isClosed_le (continuous_id.dist continuous_const) continuous_const) hyin
    have h2 : 1 ≤ dist (ringPt v θ) b :=
      closure_minimal (fun a ha => (hfar a ha b hb).le) (isClosed_le continuous_const (continuous_id.dist continuous_const)) hyout
    rw [mem_sphere, dist_comm]; linarith
  have hint := interior_maximal hsph hTv.1.isOpen
  rw [interior_sphere _ one_ne_zero] at hint
  obtain ⟨b, hb⟩ := hTv.1.nonempty
  exact hint hb

/-- **FS112-NB4P** (NB-4 corrected): at a point `v` of exactly four colours of a valid six-coloured map, let `y₀ = r(ψ)` be a change
point of its ring (a covering pair with `v`, automatically) and `y_j = r(ψ + j·60°)` its `σ_v`-orbit. If no orbit point lies on an arc
of `Γ` on `ω(v)` (closed arcs, so ends included), and no arc of `Γ` on `ω(y_{j+1})` has `y_j` on it, contradiction. The bound on the
colours at `y_j` is not needed (not a hypothesis). `hnb` is one rotational sense only: the proof never read the clause about
`ω(y_{j−1})`, which FS131-RP1 removed (inventory ruling 441 (a)); that clause alone suffices too, by the mirror
`z ↦ v + conj (z − v)`, at [hand] and not in Lean (`plans/FS131-E7-derivation.md` § 5.4).
Inhabitant, at [hand], no Lean object yet (an open gate item): on FS131-E7's `F₁` — the four-petal flower with one cell recoloured,
§ 4.1 — at `v = 0`, `ψ = 0`, `X = 4`, `X' = 5`, the hypotheses `hF`, `hv`, `h4`, `hy`, `hnb` hold at once (§ 5.1; `hnb` holds because
no circle `ω(y_{j+1})` carries an arc of `Γ` there) and `hring` fails at `j = 1, 2, 4, 5`: so `hring` is not idle. Whether `hF`,
`hv`, `h4`, `hy`, `hring` hold at once on some map is open (§ 5.3). -/
theorem nb4p {G : ArcMap 6} (hF : G.Valid) {v : ℂ} (hv : G.Covers v 1) (h4 : (G.coloursAt v).ncard = 4) {ψ : ℝ}
    {X X' : Fin 6} (hy : G.IsChangePoint v ψ X X')
    (hring : ∀ j : ℕ, j < 6 → ¬ G.OnRingArc v (ringPt v (ψ + j * (π / 3))))
    (hnb : ∀ j : ℕ, j < 6 →
      ¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) + 1) * (π / 3))) (ringPt v (ψ + j * (π / 3)))) :
    False := by
  classical
  have hπ := Real.pi_pos
  obtain ⟨-, hcompl⟩ := germS_absent hF hv (by omega) (by omega) hy
  have hXX' : X ≠ X' := hy.2.1
  have hvd : v ∈ G.dom := hv (mem_closedBall_self zero_le_one)
  set P := G.coloursAt v with hP
  have hangle : ∀ j : ℕ, ψ + ((j + 1 : ℕ) : ℝ) * (π / 3) = ψ + j * (π / 3) + π / 3 := by intro j; push_cast; ring
  -- Step 1: the ring's colours alternate between the two absent colours at every orbit point
  have hrot : ∀ θ s (c c' : Fin 6), ({c, c'} : Set (Fin 6)) = {X, X'} → c ≠ c' → GermIn v θ s (G.region c) →
      ¬ G.OnRingArc v (ringPt v (θ + π / 3)) → GermIn v (θ + π / 3) s (G.region c') := by
    intro θ s c c' hcc hne hg hna
    obtain ⟨d, hdc, hdv, hd⟩ := germ_rotate_third hF hv hg hna
    have : d ∈ ({c, c'} : Set (Fin 6)) := by rw [hcc, ← hcompl]; exact hdv
    rcases this with rfl | rfl
    · exact absurd rfl hdc
    · exact hd
  have halt : ∀ j : ℕ, j ≤ 5 → ∃ c c', ({c, c'} : Set (Fin 6)) = {X, X'} ∧ c ≠ c' ∧
      GermIn v (ψ + j * (π / 3)) .ccw (G.region c) ∧ GermIn v (ψ + j * (π / 3)) .cw (G.region c') := by
    intro j hj
    induction j with
    | zero => exact ⟨X, X', rfl, hXX', by simpa using hy.2.2.1, by simpa using hy.2.2.2⟩
    | succ j ih =>
      obtain ⟨c, c', hcc, hne, hg1, hg2⟩ := ih (by omega)
      have hna : ¬ G.OnRingArc v (ringPt v (ψ + j * (π / 3) + π / 3)) := by
        have := hring (j + 1) (by omega); rwa [hangle] at this
      rw [hangle]
      refine ⟨c', c, by rw [Set.pair_comm]; exact hcc, hne.symm, hrot _ _ c c' hcc hne hg1 hna, ?_⟩
      exact hrot _ _ c' c (by rw [Set.pair_comm]; exact hcc) hne.symm hg2 hna
  have hcl : ∀ θ s c, GermIn v θ s (G.region c) → c ∈ G.coloursAt (ringPt v θ) := by
    intro θ s c ⟨δ, hδ, hsub⟩
    exact closure_mono hsub (ringPt_mem_closure_germ v θ s hδ)
  have hXy : ∀ j : ℕ, j ≤ 6 → X ∈ G.coloursAt (ringPt v (ψ + j * (π / 3))) ∧ X' ∈ G.coloursAt (ringPt v (ψ + j * (π / 3))) := by
    intro j hj
    have h05 : ∀ j : ℕ, j ≤ 5 → X ∈ G.coloursAt (ringPt v (ψ + j * (π / 3))) ∧ X' ∈ G.coloursAt (ringPt v (ψ + j * (π / 3))) := by
      intro j hj
      obtain ⟨c, c', hcc, -, hg1, hg2⟩ := halt j hj
      have h1 := hcl _ _ _ hg1
      have h2 := hcl _ _ _ hg2
      have hX : X ∈ ({c, c'} : Set (Fin 6)) := by rw [hcc]; exact Or.inl rfl
      have hX' : X' ∈ ({c, c'} : Set (Fin 6)) := by rw [hcc]; exact Or.inr rfl
      constructor
      · rcases hX with rfl | rfl <;> assumption
      · rcases hX' with rfl | rfl <;> assumption
    rcases Nat.lt_or_ge j 6 with h | h
    · exact h05 j (by omega)
    · have hj6 : j = 6 := by omega
      subst hj6
      have : ringPt v (ψ + ((6 : ℕ) : ℝ) * (π / 3)) = ringPt v (ψ + ((0 : ℕ) : ℝ) * (π / 3)) := by
        unfold ringPt; push_cast; rw [show ψ + 6 * (π / 3) = ψ + 0 * (π / 3) + 2 * π by ring, e_add_two_pi]
      rw [this]; exact h05 0 (by omega)
  -- Step 2: the straddlers of `ω(y_{k+1})` at `y_k`
  have hS : ∀ k : ℕ, ∃ i o : Fin 6, k < 6 → (i ≠ o ∧ i ∈ P ∧ o ∈ P ∧
      i ∉ G.coloursAt (ringPt v (ψ + ((k + 1 : ℕ) : ℝ) * (π / 3))) ∧ o ∉ G.coloursAt (ringPt v (ψ + ((k + 1 : ℕ) : ℝ) * (π / 3))) ∧
      i ∈ G.coloursAt (ringPt v (ψ + k * (π / 3))) ∧ o ∈ G.coloursAt (ringPt v (ψ + k * (π / 3))) ∧
      (∀ β ∈ coneAt (G.region i) v, 0 ≤ Real.cos (β - (ψ + k * (π / 3)))) ∧
      (∀ β ∈ coneAt (G.region o) v, Real.cos (β - (ψ + k * (π / 3))) ≤ 0)) := by
    intro k
    rcases Nat.lt_or_ge k 6 with hk | hk
    · have hX2 := hXy (k + 1) (by omega)
      rw [hangle] at hX2 ⊢
      have hna := hnb k hk
      rw [show ψ + ((k : ℝ) + 1) * (π / 3) = ψ + k * (π / 3) + π / 3 by ring] at hna
      obtain ⟨i, o, h⟩ := straddlers_third hF hv hcompl hX2.1 hX2.2 hna
      exact ⟨i, o, fun _ => h⟩
    · exact ⟨X, X, fun h => absurd h (by omega)⟩
  choose I O hIO using hS
  -- Step 3: the straddler pairs alternate between two complementary halves of `P`
  set Q : ℕ → Set (Fin 6) := fun k => {I k, O k} with hQ
  have hQP : ∀ k, k < 6 → Q k ⊆ P := by
    intro k hk; rintro _ (rfl | rfl)
    · exact (hIO k hk).2.1
    · exact (hIO k hk).2.2.1
  have hQ2 : ∀ k, k < 6 → (Q k).ncard = 2 := fun k hk => Set.ncard_pair (hIO k hk).1
  have hPfin : P.Finite := Set.toFinite _
  have hstep : ∀ k, k < 5 → Q (k + 1) = P \ Q k := by
    intro k hk
    have hsub : Q (k + 1) ⊆ P \ Q k := by
      intro x hx
      refine ⟨hQP (k + 1) (by omega) hx, ?_⟩
      have hxy : x ∈ G.coloursAt (ringPt v (ψ + ((k + 1 : ℕ) : ℝ) * (π / 3))) := by
        rcases hx with rfl | rfl
        · exact (hIO (k + 1) (by omega)).2.2.2.2.2.1
        · exact (hIO (k + 1) (by omega)).2.2.2.2.2.2.1
      rintro (rfl | rfl)
      · exact (hIO k (by omega)).2.2.2.1 hxy
      · exact (hIO k (by omega)).2.2.2.2.1 hxy
    refine Set.eq_of_subset_of_ncard_le hsub ?_ hPfin.sdiff
    rw [Set.ncard_sdiff (hQP k (by omega)), h4, hQ2 k (by omega), hQ2 (k + 1) (by omega)]
  have hback : ∀ k, k < 4 → Q (k + 2) = Q k := by
    intro k hk
    have h1 : Q (k + 2) = P \ Q (k + 1) := hstep (k + 1) (by omega)
    rw [h1, hstep k (by omega), Set.sdiff_sdiff_cancel_left (hQP k (by omega))]
  have e1 : Q 1 = P \ Q 0 := hstep 0 (by omega)
  have e2 : Q 2 = Q 0 := hback 0 (by omega)
  have e4 : Q 4 = Q 0 := (hback 2 (by omega)).trans e2
  have e3 : Q 3 = Q 1 := hback 1 (by omega)
  have e5 : Q 5 = Q 1 := (hback 3 (by omega)).trans e3
  -- each colour of `v` is a straddler at three orbit points of one parity
  set Str : ℕ → Fin 6 → Prop := fun k A => (∀ β ∈ coneAt (G.region A) v, 0 ≤ Real.cos (β - (ψ + k * (π / 3)))) ∨
    (∀ β ∈ coneAt (G.region A) v, Real.cos (β - (ψ + k * (π / 3))) ≤ 0) with hStr
  have hStrQ : ∀ k, k < 6 → ∀ A ∈ Q k, Str k A := by
    intro k hk A hA
    rcases hA with rfl | rfl
    · exact Or.inl (hIO k hk).2.2.2.2.2.2.2.1
    · exact Or.inr (hIO k hk).2.2.2.2.2.2.2.2
  have hpar : ∀ A ∈ P, ∃ p < 2, ∀ i < 3, Str (p + 2 * i) A := by
    intro A hA
    by_cases h0 : A ∈ Q 0
    · refine ⟨0, by omega, fun i hi => ?_⟩
      interval_cases i
      · exact hStrQ 0 (by omega) A h0
      · exact hStrQ 2 (by omega) A (by rw [e2]; exact h0)
      · exact hStrQ 4 (by omega) A (by rw [e4]; exact h0)
    · have h1 : A ∈ Q 1 := by rw [e1]; exact ⟨hA, h0⟩
      refine ⟨1, by omega, fun i hi => ?_⟩
      interval_cases i
      · exact hStrQ 1 (by omega) A h1
      · exact hStrQ 3 (by omega) A (by rw [e3]; exact h1)
      · exact hStrQ 5 (by omega) A (by rw [e5]; exact h1)
  -- Step 4: each colour of `v` approaches `v` along at most one of the six orbit directions
  have hone : ∀ A ∈ P, ∀ j l : ℕ, j < 6 → l < 6 → ψ + j * (π / 3) ∈ coneAt (G.region A) v →
      ψ + l * (π / 3) ∈ coneAt (G.region A) v → j = l := by
    intro A hA j l hj hl hjc hlc
    by_contra hjl
    obtain ⟨p, hp, hS3⟩ := hpar A hA
    obtain ⟨i, hi, hneg⟩ := exists_opposite_cos_third hj hl hp hjl
    have hcj : Real.cos (ψ + j * (π / 3) - (ψ + ((p + 2 * i : ℕ) : ℝ) * (π / 3))) =
        Real.cos (((j : ℤ) - (p + 2 * i : ℕ)) * (π / 3)) := by congr 1; push_cast; ring
    have hcl' : Real.cos (ψ + l * (π / 3) - (ψ + ((p + 2 * i : ℕ) : ℝ) * (π / 3))) =
        Real.cos (((l : ℤ) - (p + 2 * i : ℕ)) * (π / 3)) := by congr 1; push_cast; ring
    rcases hS3 i hi with h | h
    · have a1 := h _ hjc; have a2 := h _ hlc
      rw [hcj] at a1; rw [hcl'] at a2
      nlinarith [mul_nonneg a1 a2]
    · have a1 := h _ hjc; have a2 := h _ hlc
      rw [hcj] at a1; rw [hcl'] at a2
      nlinarith [mul_nonneg_of_nonpos_of_nonpos a1 a2]
  -- Step 5: six directions, four colours
  have hC : ∀ j : ℕ, ∃ c, ψ + j * (π / 3) ∈ coneAt (G.region c) v := fun j => G.exists_mem_coneAt_region hvd _
  choose C hCc using hC
  have hCP : ∀ j, C j ∈ P := fun j => mem_closure_of_mem_coneAt (hCc j)
  have hinj : Set.InjOn C (Finset.range 6 : Set ℕ) := by
    intro j hj l hl hjl
    simp only [Finset.coe_range, mem_Iio] at hj hl
    exact hone (C j) (hCP j) j l hj hl (hCc j) (hjl ▸ hCc l)
  have hcard : (Finset.range 6).card ≤ P.toFinset.card := by
    rw [← Finset.card_image_of_injOn hinj]
    refine Finset.card_le_card fun c hc => ?_
    obtain ⟨j, -, rfl⟩ := Finset.mem_image.mp hc
    exact Set.mem_toFinset.mpr (hCP j)
  rw [Finset.card_range, ← Set.ncard_eq_toFinset_card', h4] at hcard
  omega

end ArcMap

end HadwigerNelson.Plane
