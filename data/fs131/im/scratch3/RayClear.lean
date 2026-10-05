import Proofs.HadwigerNelson.Plane.ValidMap.Moves

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace RayGap

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

/-- The squared distance from a frame point to `y`, in the frame. -/
theorem sq_dist_framePt (v : ℂ) (α x yy : ℝ) (y : ℂ) :
    dist (framePt v α x yy) y ^ 2 = (x - frameX v α y) ^ 2 + (yy - frameY v α y) ^ 2 := by
  rw [sq_dist_frame v α, frameX_framePt, frameY_framePt]

/-- The height of the parabola point `(t, μ t²/2)` above the arc of curvature `κ`. -/
theorem tanHeight_parab (κ μ t : ℝ) : tanHeight κ t (μ * t ^ 2 / 2) = (t ^ 2 / 2) * (μ - κ - κ * μ ^ 2 * t ^ 2 / 4) := by
  unfold tanHeight; ring

/-- **The parabola of curvature `μ` runs inside the horn** `hornSet v α κ₁ κ₂ R` near `v`, for `κ₁ < μ < κ₂`. -/
theorem exists_parab_mem_hornSet (v : ℂ) (α : ℝ) {κ₁ κ₂ μ R : ℝ} (hR : 0 < R) (h1 : κ₁ < μ) (h2 : μ < κ₂) :
    ∃ δ > 0, ∀ X ∈ Ioo 0 δ, framePt v α X (μ * X ^ 2 / 2) ∈ hornSet v α κ₁ κ₂ R := by
  have hc1 : Continuous fun t : ℝ => μ - κ₁ - κ₁ * μ ^ 2 * t ^ 2 / 4 := by fun_prop
  have hc2 : Continuous fun t : ℝ => μ - κ₂ - κ₂ * μ ^ 2 * t ^ 2 / 4 := by fun_prop
  have hcP : Continuous fun t : ℝ => framePt v α t (μ * t ^ 2 / 2) := by unfold framePt; fun_prop
  have e1 : ∀ᶠ t in 𝓝 (0 : ℝ), 0 < μ - κ₁ - κ₁ * μ ^ 2 * t ^ 2 / 4 :=
    (hc1.tendsto 0).eventually (lt_mem_nhds (by simp; linarith))
  have e2 : ∀ᶠ t in 𝓝 (0 : ℝ), μ - κ₂ - κ₂ * μ ^ 2 * t ^ 2 / 4 < 0 :=
    (hc2.tendsto 0).eventually (gt_mem_nhds (by simp; linarith))
  have e3 : ∀ᶠ t in 𝓝 (0 : ℝ), dist (framePt v α t (μ * t ^ 2 / 2)) v < R := by
    have h0 : framePt v α 0 (μ * 0 ^ 2 / 2) = v := by simp [framePt]
    have := hcP.tendsto 0
    rw [h0] at this
    exact (Metric.tendsto_nhds.mp this) R hR
  have hall : ∀ᶠ t in 𝓝[>] (0 : ℝ), framePt v α t (μ * t ^ 2 / 2) ∈ hornSet v α κ₁ κ₂ R := by
    filter_upwards [(e1.and (e2.and e3)).filter_mono nhdsWithin_le_nhds, self_mem_nhdsWithin] with t ht ht0
    obtain ⟨a, b, d⟩ := ht
    have ht0' : (0 : ℝ) < t := ht0
    have hpos : 0 < t ^ 2 / 2 := by positivity
    refine ⟨d, by rw [frameX_framePt]; exact ht0', ?_, ?_⟩
    · unfold TanAbove; rw [frameX_framePt, frameY_framePt, tanHeight_parab]; exact mul_pos hpos a
    · unfold TanBelow; rw [frameX_framePt, frameY_framePt, tanHeight_parab]; exact mul_neg_of_pos_of_neg hpos b
  obtain ⟨δ, hδ, hsub⟩ := (mem_nhdsGT_iff_exists_Ioo_subset.mp hall)
  exact ⟨δ, hδ, fun X hX => hsub hX⟩

/-- **Two parabolas on one side**: if `y` is at distance `1` from `v`, then at some abscissa in `(0, δ)` the points of the parabolas of
curvatures `μ, μ' ∈ (−1, 1)` are both inside `B(y, 1)` or both outside `B̄(y, 1)` (inside when `y` lies ahead of `v` along the axis,
outside otherwise). -/
theorem exists_same_side {v y : ℂ} {α μ μ' : ℝ} (hyv : dist y v = 1) (hμ : |μ| < 1) (hμ' : |μ'| < 1) {δ : ℝ}
    (hδ : 0 < δ) :
    ∃ X ∈ Ioo 0 δ, (dist (framePt v α X (μ * X ^ 2 / 2)) y < 1 ∧ dist (framePt v α X (μ' * X ^ 2 / 2)) y < 1) ∨
      (1 < dist (framePt v α X (μ * X ^ 2 / 2)) y ∧ 1 < dist (framePt v α X (μ' * X ^ 2 / 2)) y) := by
  set a := frameX v α y
  set b := frameY v α y
  have hab : a ^ 2 + b ^ 2 = 1 := by
    have := sq_dist_frame v α y v
    rw [hyv, frameX_self, frameY_self] at this; simp only [sub_zero] at this; linarith
  have hb : |b| ≤ 1 := by rw [abs_le]; constructor <;> nlinarith [sq_nonneg a]
  have hd : ∀ (m X : ℝ), dist (framePt v α X (m * X ^ 2 / 2)) y ^ 2 =
      1 + X ^ 2 - 2 * a * X + m ^ 2 * X ^ 4 / 4 - b * m * X ^ 2 := fun m X => by
    rw [sq_dist_framePt]; nlinarith [hab]
  have hbm : ∀ m : ℝ, |m| < 1 → b * m < 1 := fun m hm => by
    have := abs_mul b m
    have h' : |b * m| < 1 := by rw [abs_mul]; nlinarith [abs_nonneg b, abs_nonneg m]
    exact (abs_lt.mp h').2
  have hbm' : ∀ m : ℝ, |m| < 1 → -1 < b * m := fun m hm => by
    have h' : |b * m| < 1 := by rw [abs_mul]; nlinarith [abs_nonneg b, abs_nonneg m]
    exact (abs_lt.mp h').1
  have hm2 : ∀ m : ℝ, |m| < 1 → m ^ 2 ≤ 1 := fun m hm => by
    have := sq_abs m; nlinarith [abs_nonneg m]
  rcases lt_or_ge 0 a with ha | ha
  · -- ahead: both inside
    set X := min (δ / 2) (a / 4) with hX
    have hX0 : 0 < X := lt_min (by linarith) (by linarith)
    have hXa : X ≤ a / 4 := min_le_right _ _
    have hX1 : X ≤ 1 / 4 := by nlinarith [hab, sq_nonneg b]
    have key : ∀ m : ℝ, |m| < 1 → dist (framePt v α X (m * X ^ 2 / 2)) y < 1 := fun m hm => by
      have h1 := hd m X
      have h2 := hm2 m hm
      have h3 := hbm' m hm
      have h4 : m ^ 2 * X ^ 4 / 4 ≤ X ^ 2 / 4 := by
        have hX2 : X ^ 2 ≤ 1 := by nlinarith
        have : X ^ 4 ≤ X ^ 2 := by
          have := mul_le_mul_of_nonneg_left hX2 (sq_nonneg X); nlinarith
        nlinarith [sq_nonneg m, sq_nonneg X]
      have h5 : 0 < 2 * a * X - (X ^ 2 + m ^ 2 * X ^ 4 / 4 - b * m * X ^ 2) := by nlinarith
      nlinarith [dist_nonneg (x := framePt v α X (m * X ^ 2 / 2)) (y := y)]
    exact ⟨X, ⟨hX0, lt_of_le_of_lt (min_le_left _ _) (by linarith)⟩, Or.inl ⟨key μ hμ, key μ' hμ'⟩⟩
  · -- behind or abeam: both outside
    set X := δ / 2 with hX
    have hX0 : 0 < X := by linarith
    have key : ∀ m : ℝ, |m| < 1 → 1 < dist (framePt v α X (m * X ^ 2 / 2)) y := fun m hm => by
      have h1 := hd m X
      have h3 := hbm m hm
      have h4 : 0 ≤ m ^ 2 * X ^ 4 / 4 := by positivity
      have h5 : 0 < X ^ 2 * (1 - b * m) := mul_pos (by positivity) (by linarith)
      have h6 : 1 < dist (framePt v α X (m * X ^ 2 / 2)) y ^ 2 := by nlinarith
      nlinarith [dist_nonneg (x := framePt v α X (m * X ^ 2 / 2)) (y := y)]
    exact ⟨X, ⟨hX0, by linarith⟩, Or.inr ⟨key μ hμ, key μ' hμ'⟩⟩

theorem sq_lt_one {d : ℝ} (h0 : 0 ≤ d) (h : d < 1) : d ^ 2 < 1 := by nlinarith

theorem one_lt_sq {d : ℝ} (h : 1 < d) : 1 < d ^ 2 := by nlinarith

/-! ### The real inequalities of `ray_clear`, each with only its own hypotheses -/

theorem lt_of_sq_add_sq_lt {x y r : ℝ} (hx : 0 < x) (hr : 0 < r) (h : x ^ 2 + y ^ 2 < r ^ 2) : x < r := by
  nlinarith [sq_nonneg y]

theorem sq_lt_of_sq_add_sq_lt {x y r : ℝ} (hr : r < 1 / 4) (hr0 : 0 < r) (h : x ^ 2 + y ^ 2 < r ^ 2) : y ^ 2 < 1 / 16 := by
  nlinarith [sq_nonneg x]

/-- A point of the gap between the arcs of curvatures `κ₂ < κ₃` (`|κᵢ| ≤ 1`) near the vertex has height at most `x²`. -/
theorem abs_le_sq_of_gap {x y κ₂ κ₃ : ℝ} (hκ2 : |κ₂| ≤ 1) (hκ3 : |κ₃| ≤ 1) (hA : 0 < y - κ₂ * (x ^ 2 + y ^ 2) / 2)
    (hB : y - κ₃ * (x ^ 2 + y ^ 2) / 2 < 0) (hy2 : y ^ 2 < 1 / 16) : |y| ≤ x ^ 2 := by
  have q0 : 0 ≤ x ^ 2 + y ^ 2 := by positivity
  have e2 : -(x ^ 2 + y ^ 2) ≤ κ₂ * (x ^ 2 + y ^ 2) := by
    have := neg_abs_le κ₂; nlinarith
  have e3 : κ₃ * (x ^ 2 + y ^ 2) ≤ x ^ 2 + y ^ 2 := by
    have := le_abs_self κ₃; nlinarith
  have hy : |y| < 1 / 4 := by
    rw [← abs_of_pos (show (0:ℝ) < 1 / 4 by norm_num)]; exact sq_lt_sq.mp (by norm_num; linarith)
  rw [abs_le]; constructor
  · have := neg_abs_le y; have : y ^ 2 ≤ |y| / 4 := by have := sq_abs y; nlinarith [abs_nonneg y]
    nlinarith
  · have := le_abs_self y; have : y ^ 2 ≤ |y| / 4 := by have := sq_abs y; nlinarith [abs_nonneg y]
    nlinarith

theorem sq_le_pow_four_of_abs_le {x y : ℝ} (h : |y| ≤ x ^ 2) : y ^ 2 ≤ x ^ 4 := by
  have := sq_abs y
  have h0 := abs_nonneg y
  nlinarith

/-- The lower horn's parabola point on the vertical through a gap point lies below it. -/
theorem parab_below {x y κ₂ μ : ℝ} (hκ2 : |κ₂| ≤ 1) (hA : 0 < y - κ₂ * (x ^ 2 + y ^ 2) / 2) (hyx : |y| ≤ x ^ 2)
    (hx : 0 < x) (hx1 : x < 1) (hsmall : x < κ₂ - μ) : μ * x ^ 2 / 2 - y < 0 := by
  by_contra h; push Not at h
  have h4 := sq_le_pow_four_of_abs_le hyx
  have hk := neg_abs_le κ₂
  have e : (κ₂ - μ) * x ^ 2 ≤ y ^ 2 := by nlinarith [sq_nonneg y]
  have hx2 : x ^ 2 < x := by nlinarith
  have hx2' : 0 < x ^ 2 := by positivity
  have : κ₂ - μ ≤ x ^ 2 := by
    by_contra h'; push Not at h'
    have : x ^ 2 * x ^ 2 < (κ₂ - μ) * x ^ 2 := mul_lt_mul_of_pos_right h' hx2'
    nlinarith
  linarith

/-- The upper horn's parabola point on the vertical through a gap point lies above it. -/
theorem parab_above {x y κ₃ μ' : ℝ} (hκ3 : |κ₃| ≤ 1) (hB : y - κ₃ * (x ^ 2 + y ^ 2) / 2 < 0) (hyx : |y| ≤ x ^ 2)
    (hx : 0 < x) (hx1 : x < 1) (hsmall : x < μ' - κ₃) : 0 < μ' * x ^ 2 / 2 - y := by
  by_contra h; push Not at h
  have h4 := sq_le_pow_four_of_abs_le hyx
  have hk := le_abs_self κ₃
  have e : (μ' - κ₃) * x ^ 2 ≤ y ^ 2 := by nlinarith [sq_nonneg y]
  have hx2 : x ^ 2 < x := by nlinarith
  have hx2' : 0 < x ^ 2 := by positivity
  have : μ' - κ₃ ≤ x ^ 2 := by
    by_contra h'; push Not at h'
    have : x ^ 2 * x ^ 2 < (μ' - κ₃) * x ^ 2 := mul_lt_mul_of_pos_right h' hx2'
    nlinarith
  linarith

/-- The distance identity on a vertical: `(x − X)² + (m − Y)² = 1 + u² − 2ub` when `(X − x, Y − y)` is a unit vector `(a, b)` and
`u = m − y`. -/
theorem vertical_identity {x y X Y m : ℝ} (hab : (X - x) ^ 2 + (Y - y) ^ 2 = 1) :
    (x - X) ^ 2 + (m - Y) ^ 2 = 1 + (m - y) ^ 2 - 2 * (m - y) * (Y - y) := by
  linear_combination hab

/-- Both inside is impossible on a vertical with points below (`u₁ < 0`) and above (`u₂ > 0`). -/
theorem not_both_inside {u₁ u₂ b : ℝ} (hu₁ : u₁ < 0) (hu₂ : 0 < u₂) (i1 : 1 + u₁ ^ 2 - 2 * u₁ * b < 1)
    (i2 : 1 + u₂ ^ 2 - 2 * u₂ * b < 1) : False := by
  have j1 : 0 < u₁ - 2 * b := by
    by_contra h; push Not at h; nlinarith [mul_nonneg_of_nonpos_of_nonpos hu₁.le h]
  have j2 : u₂ - 2 * b < 0 := by
    by_contra h; push Not at h; nlinarith [mul_nonneg hu₂.le h]
  linarith

/-- Both outside on such a vertical traps `2b` between `u₁` and `u₂`. -/
theorem trapped_of_both_outside {u₁ u₂ b : ℝ} (hu₁ : u₁ < 0) (hu₂ : 0 < u₂) (o1 : 1 < 1 + u₁ ^ 2 - 2 * u₁ * b)
    (o2 : 1 < 1 + u₂ ^ 2 - 2 * u₂ * b) : u₁ < 2 * b ∧ 2 * b < u₂ := by
  constructor
  · by_contra h; push Not at h; nlinarith [mul_nonpos_of_nonpos_of_nonneg hu₁.le (sub_nonneg.mpr h)]
  · by_contra h; push Not at h; nlinarith [mul_nonpos_of_nonneg_of_nonpos hu₂.le (sub_nonpos.mpr h)]

theorem abs_half_mul_sq_le {μ x : ℝ} (hμ : |μ| < 1) : |μ * x ^ 2 / 2| ≤ x ^ 2 / 2 := by
  rw [abs_div, abs_mul, abs_of_nonneg (sq_nonneg x), abs_two]
  have := abs_nonneg μ
  have := sq_nonneg x
  nlinarith

/-- The abeam case's final inequality: moving by `a x / 2` along the axis towards the centre, at height `d`, strictly enters the
unit disc. -/
theorem abeam_inside {x a b d : ℝ} (hab : a ^ 2 + b ^ 2 = 1) (hx : 0 < x) (hx4 : x < 1 / 4) (hbx : |b| ≤ 3 * x ^ 2 / 4)
    (hdx : |d| ≤ 3 * x ^ 2) : 1 - a ^ 2 * x + a ^ 2 * x ^ 2 / 4 + (d ^ 2 - 2 * d * b) < 1 := by
  have hxx : x ^ 2 ≤ 1 / 16 := by nlinarith
  have hx4' : x ^ 4 ≤ x ^ 2 / 16 := by
    have := mul_le_mul_of_nonneg_left hxx (sq_nonneg x); nlinarith
  have hb2 : b ^ 2 ≤ 9 * x ^ 4 / 16 := by have := sq_abs b; nlinarith [abs_nonneg b]
  have ha2 : 1 / 2 ≤ a ^ 2 := by nlinarith
  have e1 : d ^ 2 ≤ 9 * x ^ 4 := by have := sq_abs d; nlinarith [abs_nonneg d]
  have e2 : -(2 * d * b) ≤ 2 * (|d| * |b|) := by
    have := neg_abs_le (d * b); rw [abs_mul] at this; linarith
  have e3 : |d| * |b| ≤ 3 * x ^ 2 * (3 * x ^ 2 / 4) := mul_le_mul hdx hbx (abs_nonneg _) (by positivity)
  have hdb : d ^ 2 - 2 * d * b ≤ 14 * x ^ 4 := by nlinarith
  have hx3 : x ^ 3 < 1 / 64 := by nlinarith [sq_nonneg x]
  have hkey : 14 * x ^ 4 < a ^ 2 * x * (1 - x / 4) := by
    have : 14 * x ^ 4 = 14 * x ^ 3 * x := by ring
    nlinarith
  nlinarith

/-- The abeam point's height bound: `|μ x'²/2 − y| ≤ 3x²` for `x' ≤ 3x/2`, `|μ| < 1`, `|y| ≤ x²`. -/
theorem abs_abeam_height {μ x x' y : ℝ} (hμ : |μ| < 1) (hx' : 0 ≤ x') (hx'1 : x' ≤ 3 * x / 2) (hyx : |y| ≤ x ^ 2) :
    |μ * x' ^ 2 / 2 - y| ≤ 3 * x ^ 2 := by
  have h1 := abs_half_mul_sq_le (x := x') hμ
  have h2 : x' ^ 2 ≤ 9 * x ^ 2 / 4 := by nlinarith
  calc |μ * x' ^ 2 / 2 - y| ≤ |μ * x' ^ 2 / 2| + |y| := abs_sub _ _
    _ ≤ 3 * x ^ 2 := by linarith [sq_nonneg x]

/-- The abeam identity: `(x' − X)² + (μx'²/2 − Y)² = 1 − a²x + a²x²/4 + (d² − 2db)` for `x' = x + ax/2`, `a = X − x`, `b = Y − y`,
`a² + b² = 1`, `d = μx'²/2 − y`. -/
theorem abeam_identity {x y X Y μ : ℝ} (hab : (X - x) ^ 2 + (Y - y) ^ 2 = 1) :
    (x + (X - x) * x / 2 - X) ^ 2 + (μ * (x + (X - x) * x / 2) ^ 2 / 2 - Y) ^ 2 =
      1 - (X - x) ^ 2 * x + (X - x) ^ 2 * x ^ 2 / 4 +
        ((μ * (x + (X - x) * x / 2) ^ 2 / 2 - y) ^ 2 - 2 * (μ * (x + (X - x) * x / 2) ^ 2 / 2 - y) * (Y - y)) := by
  linear_combination hab

/-- **The abeam case**: if `y`'s offset `(a, b)` from `t = (x, yt)` is a unit vector with `|b| ≤ 3x²/4`, the parabola point of curvature
`μ` at abscissa `x + a x / 2` lies inside `B(y, 1)`; so a set holding those parabola points cannot lie outside `B̄(y, 1)`. -/
theorem abeam_contra {v y : ℂ} {α μ x yt δ : ℝ} {S : Set ℂ} (hP : ∀ X ∈ Ioo 0 δ, framePt v α X (μ * X ^ 2 / 2) ∈ S)
    (hout : S ⊆ {z | 1 < dist z y}) (hμ : |μ| < 1) (hx : 0 < x) (hx4 : x < 1 / 4) (hxδ : 3 * x / 2 < δ)
    (hytx : |yt| ≤ x ^ 2) (hab : (frameX v α y - x) ^ 2 + (frameY v α y - yt) ^ 2 = 1)
    (hbx : |frameY v α y - yt| ≤ 3 * x ^ 2 / 4) : False := by
  have ha1 : |frameX v α y - x| ≤ 1 := by
    rw [abs_le]; constructor <;> nlinarith [sq_nonneg (frameY v α y - yt)]
  have hx'0 : x / 2 ≤ x + (frameX v α y - x) * x / 2 := by have := abs_le.mp ha1; nlinarith
  have hx'1 : x + (frameX v α y - x) * x / 2 ≤ 3 * x / 2 := by have := abs_le.mp ha1; nlinarith
  have hQm := hP (x + (frameX v α y - x) * x / 2) ⟨by linarith, by linarith⟩
  have o3 : 1 < dist (framePt v α (x + (frameX v α y - x) * x / 2)
      (μ * (x + (frameX v α y - x) * x / 2) ^ 2 / 2)) y := hout hQm
  have o3' : 1 < dist (framePt v α (x + (frameX v α y - x) * x / 2)
      (μ * (x + (frameX v α y - x) * x / 2) ^ 2 / 2)) y ^ 2 := one_lt_sq o3
  rw [sq_dist_framePt, abeam_identity hab] at o3'
  have hdx := abs_abeam_height hμ (by linarith) hx'1 hytx
  have := abeam_inside (a := frameX v α y - x) (b := frameY v α y - yt) hab hx hx4 hbx hdx
  linarith

end RayGap

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A connected piece of a colour class lies on one side of each unit circle about the class**: inside `B(y, 1)` or outside
`B̄(y, 1)`, for `y` of the same colour in a valid map. -/
theorem side_of_preconnected (hF : F.Valid) {c : Fin k} {S : Set ℂ} (hS : IsPreconnected S) (hSc : S ⊆ F.region c)
    {y : ℂ} (hy : y ∈ F.region c) : S ⊆ ball y 1 ∨ S ⊆ {z | 1 < dist z y} := by
  refine hS.subset_or_subset isOpen_ball (isOpen_lt continuous_const (continuous_id.dist continuous_const)) ?_ ?_
  · exact disjoint_left.mpr fun z h1 h2 => by rw [mem_ball] at h1; simp only [mem_setOf_eq] at h2; linarith
  · intro z hz
    have hzc := hSc hz
    have hne : dist z y ≠ 1 := fun h => hF z hzc.1 y hy.1 h (by
      have h1 := hzc.2; have h2 := hy.2; simp only [mem_preimage, mem_singleton_iff] at h1 h2; rw [h1, h2])
    rcases lt_or_gt_of_ne hne with h | h
    · exact Or.inl (mem_ball.mpr h)
    · exact Or.inr h

/-- A horn that is a sector of one colour lies in that colour's class. -/
theorem hornSet_subset_region {v : ℂ} {α a b r : ℝ} {c : Fin k} (hS : F.IsSector v r (hornSet v α a b r))
    (hc : hornSet v α a b r ⊆ F.col ⁻¹' {c}) : hornSet v α a b r ⊆ F.region c := by
  intro z hz
  obtain ⟨x, -, heq, -⟩ := hS
  have : z ∈ connectedComponentIn (F.interiorPts ∩ ball v r) x := heq ▸ hz
  exact ⟨(connectedComponentIn_subset _ _ this).1, hc hz⟩

/-- **N4-RAY's clearness** (the first conjunct of `exists_rayMerge`; record § 3.3's exact argument): near `v` the gap between two
`c`-horns along one ray is clear for `c`. A unit circle about a point `y` of `c` through a point `t` of the gap has each horn inside it
or outside it; on the vertical through `t` (a parabola point of each horn below and above `t`) both inside is impossible, both
outside forces the circle's centre abeam of `t` and then a parabola point of the lower horn nearer the centre lies inside, and one
inside, one outside puts `y` on `ω(v)`, where the two horns fall on one side. -/
theorem ray_clear (hF : F.Valid) {v : ℂ} {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k} (h23 : κ₂ < κ₃)
    (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₃ κ₄ c) (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₂ κ₃ r, F.IsClear c z := by
  have h12 := hH.1
  have h34 := hH'.1
  obtain ⟨R, ⟨⟨hS, hc⟩, hS', hc'⟩, hR⟩ :=
    ((hH.2.and hH'.2).and (Ioo_mem_nhdsGT (show (0 : ℝ) < 1 / 4 by norm_num))).exists
  have hH1 := hornSet_subset_region hS hc
  have hH2 := hornSet_subset_region hS' hc'
  have hκ : ∀ κ : ℝ, -1 ≤ κ → κ ≤ 1 → |κ| * R < 2 := fun κ ha hb => by
    have : |κ| ≤ 1 := abs_le.mpr ⟨ha, hb⟩; nlinarith [abs_nonneg κ, hR.1, hR.2]
  have hpre1 := isPreconnected_hornSet v α h12 (hκ κ₁ h1 (by linarith)) (hκ κ₂ (by linarith) (by linarith))
  have hpre2 := isPreconnected_hornSet v α h34 (hκ κ₃ (by linarith) (by linarith)) (hκ κ₄ (by linarith) h4)
  set μ := (κ₁ + κ₂) / 2 with hμ
  set μ' := (κ₃ + κ₄) / 2 with hμ'
  obtain ⟨δ₁, hδ₁, hP₁⟩ := RayGap.exists_parab_mem_hornSet v α hR.1 (show κ₁ < μ by linarith) (show μ < κ₂ by linarith)
  obtain ⟨δ₂, hδ₂, hP₂⟩ := RayGap.exists_parab_mem_hornSet v α hR.1 (show κ₃ < μ' by linarith) (show μ' < κ₄ by linarith)
  have hμ1 : |μ| < 1 := abs_lt.mpr ⟨by linarith, by linarith⟩
  have hμ'1 : |μ'| < 1 := abs_lt.mpr ⟨by linarith, by linarith⟩
  have hvcl1 : v ∈ closure (hornSet v α κ₁ κ₂ R) := mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α h12 hR.1)
  have hvcl2 : v ∈ closure (hornSet v α κ₃ κ₄ R) := mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α h34 hR.1)
  set r₀ := min (min δ₁ δ₂ / 2) (min (1 / 4) (min ((κ₂ - κ₁) / 2) ((κ₄ - κ₃) / 2))) with hr₀
  have hr₀0 : 0 < r₀ := lt_min (by positivity) (lt_min (by norm_num) (lt_min (by linarith) (by linarith)))
  have hr₀δ₁ : r₀ ≤ δ₁ / 2 := (min_le_left _ _).trans (by have := min_le_left δ₁ δ₂; linarith)
  have hr₀δ₂ : r₀ ≤ δ₂ / 2 := (min_le_left _ _).trans (by have := min_le_right δ₁ δ₂; linarith)
  have hr₀4 : r₀ ≤ 1 / 4 := (min_le_right _ _).trans (min_le_left _ _)
  have hr₀12 : r₀ ≤ (κ₂ - κ₁) / 2 := (min_le_right _ _).trans ((min_le_right _ _).trans (min_le_left _ _))
  have hr₀34 : r₀ ≤ (κ₄ - κ₃) / 2 := (min_le_right _ _).trans ((min_le_right _ _).trans (min_le_right _ _))
  filter_upwards [Ioo_mem_nhdsGT hr₀0] with r hr
  intro t ht y hy hty
  -- the frame data of `t`
  set x := frameX v α t with hxdef
  set yt := frameY v α t with hytdef
  have hx : 0 < x := ht.2.1
  have htv : x ^ 2 + yt ^ 2 < r ^ 2 := by
    have h := sq_dist_frame v α t v
    rw [frameX_self, frameY_self, sub_zero, sub_zero] at h
    rw [← h]; exact pow_lt_pow_left₀ ht.1 dist_nonneg two_ne_zero
  have hA : 0 < yt - κ₂ * (x ^ 2 + yt ^ 2) / 2 := ht.2.2.1
  have hB : yt - κ₃ * (x ^ 2 + yt ^ 2) / 2 < 0 := ht.2.2.2
  have hr4 : r < 1 / 4 := lt_of_lt_of_le hr.2 hr₀4
  have hrr : r < r₀ := hr.2
  have hxr : x < r := RayGap.lt_of_sq_add_sq_lt hx hr.1 htv
  have hyt2 : yt ^ 2 < 1 / 16 := RayGap.sq_lt_of_sq_add_sq_lt hr4 hr.1 htv
  have hκ2 : |κ₂| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
  have hκ3 : |κ₃| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
  have hytx : |yt| ≤ x ^ 2 := RayGap.abs_le_sq_of_gap hκ2 hκ3 hA hB hyt2
  -- the frame data of `y`
  have hab : (frameX v α y - x) ^ 2 + (frameY v α y - yt) ^ 2 = 1 := by
    have h := sq_dist_frame v α t y
    rw [hty, one_pow] at h; linear_combination -h
  -- the parabola points on the vertical through `t`
  have hxδ₁ : x < δ₁ := by linarith
  have hxδ₂ : x < δ₂ := by linarith
  have hP₁m := hP₁ x ⟨hx, hxδ₁⟩
  have hP₂m := hP₂ x ⟨hx, hxδ₂⟩
  have hx1 : x < 1 := by linarith
  have hu₁n : μ * x ^ 2 / 2 - yt < 0 := RayGap.parab_below hκ2 hA hytx hx hx1 (by linarith)
  have hu₂p : 0 < μ' * x ^ 2 / 2 - yt := RayGap.parab_above hκ3 hB hytx hx hx1 (by linarith)
  have hd₁ := RayGap.vertical_identity (m := μ * x ^ 2 / 2) hab
  have hd₂ := RayGap.vertical_identity (m := μ' * x ^ 2 / 2) hab
  rw [← RayGap.sq_dist_framePt] at hd₁ hd₂
  have hdn : ∀ p : ℂ, dist p y < 1 → dist p y ^ 2 < 1 := fun p h => RayGap.sq_lt_one dist_nonneg h
  have hdp : ∀ p : ℂ, 1 < dist p y → 1 < dist p y ^ 2 := fun p h => RayGap.one_lt_sq h
  -- the mixed case puts `y` on `ω(v)`, where both horns fall on one side
  have hmixed : ∀ (S S' : Set ℂ), (S = hornSet v α κ₁ κ₂ R ∧ S' = hornSet v α κ₃ κ₄ R) ∨
      (S = hornSet v α κ₃ κ₄ R ∧ S' = hornSet v α κ₁ κ₂ R) → S ⊆ ball y 1 → S' ⊆ {z | 1 < dist z y} → False := by
    intro S S' hSS hin hout
    have hvS : v ∈ closure S := by rcases hSS with ⟨rfl, -⟩ | ⟨rfl, -⟩ <;> assumption
    have hvS' : v ∈ closure S' := by rcases hSS with ⟨-, rfl⟩ | ⟨-, rfl⟩ <;> assumption
    have h1' : dist v y ≤ 1 := by
      have := closure_mono hin hvS; rw [closure_ball y one_ne_zero] at this; exact this
    have h2' : 1 ≤ dist v y := by
      have hcl : IsClosed {z : ℂ | 1 ≤ dist z y} := isClosed_le continuous_const (continuous_id.dist continuous_const)
      have hsub : S' ⊆ {z : ℂ | 1 ≤ dist z y} := fun z hz => by
        have := hout hz; simp only [mem_setOf_eq] at this ⊢; exact this.le
      exact closure_minimal hsub hcl hvS'
    have hyv : dist y v = 1 := by rw [dist_comm]; linarith
    obtain ⟨X, hX, hside⟩ := RayGap.exists_same_side (α := α) hyv hμ1 hμ'1 (lt_min hδ₁ hδ₂)
    have hX1 := hP₁ X ⟨hX.1, lt_of_lt_of_le hX.2 (min_le_left _ _)⟩
    have hX2 := hP₂ X ⟨hX.1, lt_of_lt_of_le hX.2 (min_le_right _ _)⟩
    rcases hSS with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · rcases hside with ⟨-, h⟩ | ⟨h, -⟩
      · have := hout hX2; simp only [mem_setOf_eq] at this; linarith
      · have := hin hX1; rw [mem_ball] at this; linarith
    · rcases hside with ⟨h, -⟩ | ⟨-, h⟩
      · have := hout hX1; simp only [mem_setOf_eq] at this; linarith
      · have := hin hX2; rw [mem_ball] at this; linarith
  rcases side_of_preconnected hF hpre1 hH1 hy with hin1 | hout1 <;>
    rcases side_of_preconnected hF hpre2 hH2 hy with hin2 | hout2
  · -- both inside: impossible on the vertical through `t`
    have i1 := hdn _ (mem_ball.mp (hin1 hP₁m))
    have i2 := hdn _ (mem_ball.mp (hin2 hP₂m))
    rw [hd₁] at i1; rw [hd₂] at i2
    exact RayGap.not_both_inside hu₁n hu₂p i1 i2
  · exact hmixed _ _ (Or.inl ⟨rfl, rfl⟩) hin1 hout2
  · exact hmixed _ _ (Or.inr ⟨rfl, rfl⟩) hin2 hout1
  · -- both outside: the centre is abeam of `t`, and a parabola point of the lower horn nearer it lies inside
    have o1 := hdp _ (hout1 hP₁m)
    have o2 := hdp _ (hout2 hP₂m)
    rw [hd₁] at o1; rw [hd₂] at o2
    obtain ⟨j1, j2⟩ := RayGap.trapped_of_both_outside hu₁n hu₂p o1 o2
    have hbx : |frameY v α y - yt| ≤ 3 * x ^ 2 / 4 := by
      have e1 := abs_le.mp (RayGap.abs_half_mul_sq_le (x := x) hμ1)
      have e2 := abs_le.mp (RayGap.abs_half_mul_sq_le (x := x) hμ'1)
      have e3 := abs_le.mp hytx
      rw [abs_le]; constructor <;> linarith
    exact RayGap.abeam_contra hP₁ hout1 hμ1 hx (by linarith) (by linarith) hytx hab hbx

end ArcMap

end HadwigerNelson.Plane
