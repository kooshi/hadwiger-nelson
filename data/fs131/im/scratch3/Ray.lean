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

/-- A non-negative number below `1` has square below `1`. -/
theorem sq_lt_one {d : ℝ} (h0 : 0 ≤ d) (h : d < 1) : d ^ 2 < 1 := by nlinarith

/-- A number above `1` has square above `1`. -/
theorem one_lt_sq {d : ℝ} (h : 1 < d) : 1 < d ^ 2 := by nlinarith

/-! ### The real inequalities of `ray_clear`, each with only its own hypotheses -/

/-- A positive coordinate of a point of `B(0, r)` is below `r`. -/
theorem lt_of_sq_add_sq_lt {x y r : ℝ} (hx : 0 < x) (hr : 0 < r) (h : x ^ 2 + y ^ 2 < r ^ 2) : x < r := by
  nlinarith [sq_nonneg y]

/-- A coordinate of a point of `B(0, r)`, `r < 1/4`, has square below `1/16`. -/
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

/-- `|y| ≤ x²` gives `y² ≤ x⁴`. -/
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

/-- The parabola of curvature `|μ| < 1` stays below height `x²/2`. -/
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

/-- Two germs of one direction (mod `2π`) have the same branch points. -/
theorem branchPt_congr_dir {v : ℂ} {β β' : ℝ} (h : e β = e β') (κ s : ℝ) : branchPt v β κ s = branchPt v β' κ s := by
  rw [branchPt, branchPt, e_add, e_add, h]

namespace RayGap

/-- **The frontier of a horn near its vertex**: a point of the closure of `hornSet v α a b r` inside the open ball and off the horn is
`v` or a point of one of the two bounding arcs (`|a|, |b| ≤ 1`, `r ≤ 1`). -/
theorem eq_of_mem_closure_hornSet {v z : ℂ} {α a b r : ℝ} (ha : |a| ≤ 1) (hb : |b| ≤ 1) (hr : r ≤ 1)
    (hz : z ∈ closure (hornSet v α a b r)) (hzr : dist z v < r) (hzn : z ∉ hornSet v α a b r) :
    z = v ∨ z = branchPt v α a ‖z - v‖ ∨ z = branchPt v α b ‖z - v‖ := by
  have hX : Continuous (frameX v α) := by unfold frameX; fun_prop
  have hY : Continuous (frameY v α) := by unfold frameY; fun_prop
  have hT : ∀ κ, Continuous fun z => tanHeight κ (frameX v α z) (frameY v α z) := fun κ => by
    unfold tanHeight; fun_prop
  have hcl : IsClosed {z : ℂ | 0 ≤ frameX v α z ∧ 0 ≤ tanHeight a (frameX v α z) (frameY v α z) ∧
      tanHeight b (frameX v α z) (frameY v α z) ≤ 0} :=
    (isClosed_le continuous_const hX).inter ((isClosed_le continuous_const (hT a)).inter (isClosed_le (hT b) continuous_const))
  have hsub : hornSet v α a b r ⊆ {z : ℂ | 0 ≤ frameX v α z ∧ 0 ≤ tanHeight a (frameX v α z) (frameY v α z) ∧
      tanHeight b (frameX v α z) (frameY v α z) ≤ 0} := fun z hz => ⟨hz.2.1.le, hz.2.2.1.le, hz.2.2.2.le⟩
  obtain ⟨hX0, hTa, hTb⟩ := closure_minimal hsub hcl hz
  have hd := sq_dist_frame v α z v
  rw [frameX_self, frameY_self, sub_zero, sub_zero] at hd
  have hzr' : ‖z - v‖ < r := by rw [← dist_eq_norm]; exact hzr
  rcases eq_or_lt_of_le hX0 with hX0' | hXpos
  · -- on the normal line through `v`: only `v` itself
    left
    have hY2 : frameY v α z ^ 2 < 1 := by
      have : dist z v ^ 2 < 1 := by nlinarith [dist_nonneg (x := z) (y := v)]
      rw [hd, ← hX0'] at this; nlinarith
    have hYa : |frameY v α z| < 1 := by rw [← abs_one]; exact sq_lt_sq.mp (by simpa using hY2)
    have h1 : 0 < 1 - a * frameY v α z / 2 := by
      have := abs_mul a (frameY v α z); have := abs_le.mp (show |a * frameY v α z| ≤ 1 by
        rw [abs_mul]; nlinarith [abs_nonneg a, abs_nonneg (frameY v α z)]); linarith
    have h2 : 0 < 1 - b * frameY v α z / 2 := by
      have := abs_le.mp (show |b * frameY v α z| ≤ 1 by
        rw [abs_mul]; nlinarith [abs_nonneg b, abs_nonneg (frameY v α z)]); linarith
    unfold tanHeight at hTa hTb
    rw [← hX0'] at hTa hTb
    have e1 : 0 ≤ frameY v α z * (1 - a * frameY v α z / 2) := by nlinarith
    have e2 : frameY v α z * (1 - b * frameY v α z / 2) ≤ 0 := by nlinarith
    have hY0 : frameY v α z = 0 := by
      rcases lt_trichotomy (frameY v α z) 0 with h | h | h
      · nlinarith [mul_neg_of_neg_of_pos h h1]
      · exact h
      · nlinarith [mul_pos h h2]
    have : dist z v ^ 2 = 0 := by rw [hd, ← hX0', hY0]; ring
    exact dist_eq_zero.mp (pow_eq_zero_iff two_ne_zero |>.mp this)
  · -- off the normal line: on one of the two arcs
    right
    have hnot : ¬ (0 < tanHeight a (frameX v α z) (frameY v α z) ∧ tanHeight b (frameX v α z) (frameY v α z) < 0) :=
      fun h => hzn ⟨hzr, hXpos, h.1, h.2⟩
    have hs : ∀ κ : ℝ, |κ| ≤ 1 → |κ| * ‖z - v‖ ≤ 2 := fun κ hκ => by
      nlinarith [abs_nonneg κ, norm_nonneg (z - v)]
    by_cases hA : tanHeight a (frameX v α z) (frameY v α z) = 0
    · exact Or.inl (eq_branchPt_of_tanHeight_eq_zero hXpos hA (hs a ha))
    · have hA' : 0 < tanHeight a (frameX v α z) (frameY v α z) := lt_of_le_of_ne hTa (Ne.symm hA)
      have hB : tanHeight b (frameX v α z) (frameY v α z) = 0 := by
        by_contra hB; exact hnot ⟨hA', lt_of_le_of_ne hTb hB⟩
      exact Or.inr (eq_branchPt_of_tanHeight_eq_zero hXpos hB (hs b hb))

/-- **A horn inside another bounds its curvatures**: `hornSet v α a₁ a₂ r ⊆ hornSet v α b₁ b₂ r` with `a₁ < a₂` gives `b₁ ≤ a₁` and
`a₂ ≤ b₂` (a branch point of an intermediate curvature tests each side). -/
theorem curv_le_of_hornSet_subset {v : ℂ} {α a₁ a₂ b₁ b₂ r : ℝ} (ha : a₁ < a₂) (hr : 0 < r)
    (hsub : hornSet v α a₁ a₂ r ⊆ hornSet v α b₁ b₂ r) : b₁ ≤ a₁ ∧ a₂ ≤ b₂ := by
  constructor
  · by_contra hlt
    push Not at hlt
    have hmin : a₁ < min b₁ a₂ := lt_min hlt ha
    have hm1 : a₁ < (a₁ + min b₁ a₂) / 2 := by linarith
    have hm2 : (a₁ + min b₁ a₂) / 2 < a₂ := by have := min_le_right b₁ a₂; linarith
    have hm3 : (a₁ + min b₁ a₂) / 2 ≤ b₁ := by have := min_le_left b₁ a₂; linarith
    obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s ((a₁ + min b₁ a₂) / 2) hr
    exact not_tanAbove_branchPt hsm.le hs0.le hm3 (hsub (branchPt_mem_hornSet v α hm1 hm2 hs0 hsr hsm)).2.2.1
  · by_contra hlt
    push Not at hlt
    have hmax : max a₁ b₂ < a₂ := max_lt ha hlt
    have hm1 : a₁ < (max a₁ b₂ + a₂) / 2 := by have := le_max_left a₁ b₂; linarith
    have hm2 : (max a₁ b₂ + a₂) / 2 < a₂ := by linarith
    have hm3 : b₂ ≤ (max a₁ b₂ + a₂) / 2 := by have := le_max_right a₁ b₂; linarith
    obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s ((max a₁ b₂ + a₂) / 2) hr
    exact not_tanBelow_branchPt hsm.le hs0.le hm3 (hsub (branchPt_mem_hornSet v α hm1 hm2 hs0 hsr hsm)).2.2.2

end RayGap

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ}

/-- **A chart sector meeting the gap between two germs of direction `α` lies in it**: the gap's frontier in the punctured ball is the two
germs' branches, which a sector (inside the interior points) never meets, and a sector is connected. -/
theorem sector_subset_hornSet_of_meets (X : F.Near v) {ρ : ℝ} (h : X.Small ρ) {α a b : ℝ} (ha : |a| ≤ 1) (hb : |b| ≤ 1)
    {ja jb : Fin X.n} (hja : e (X.G.β ja) = e α ∧ X.G.κ ja = a) (hjb : e (X.G.β jb) = e α ∧ X.G.κ jb = b)
    {r : ℝ} (hr : r ∈ Ioc 0 ρ) {j : Fin X.n} (hmeet : (X.G.sector v r j ∩ hornSet v α a b r).Nonempty) :
    X.G.sector v r j ⊆ hornSet v α a b r := by
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hr.2.trans h.lt_r₀.le⟩
  have hn : 0 < X.n := j.pos
  have hsecI := X.hC.sector_subset_interiorPts hn hr₀ j
  refine (X.hC.isPreconnected r hr₀ j).subset_left_of_subset_union (isOpen_hornSet v α a b r)
    isClosed_closure.isOpen_compl (disjoint_compl_right.mono_right (compl_subset_compl.mpr subset_closure)) ?_ hmeet
  intro z hz
  by_cases hzH : z ∈ hornSet v α a b r
  · exact Or.inl hzH
  right
  intro hzcl
  have hzr : dist z v < r := X.G.sector_subset_ball j hz
  have hzv : z ≠ v := fun h' => by
    obtain ⟨hs, -⟩ := X.G.mem_sector_iff.mp hz; rw [h', sub_self, norm_zero] at hs; exact lt_irrefl 0 hs.1
  have hzn : ‖z - v‖ ∈ Ioo 0 X.r₀ := ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv),
    by rw [← dist_eq_norm]; exact hzr.trans_le hr₀.2⟩
  rcases RayGap.eq_of_mem_closure_hornSet ha hb (hr.2.trans (by linarith [h.2.2.2])) hzcl hzr hzH with h1 | h1 | h1
  · exact hzv h1
  · rw [← hja.2, ← branchPt_congr_dir hja.1] at h1
    have hΓ := X.hC.branchPt_mem_Γ ja hzn
    rw [← h1] at hΓ
    exact (hsecI hz).2 hΓ.2
  · rw [← hjb.2, ← branchPt_congr_dir hjb.1] at h1
    have hΓ := X.hC.branchPt_mem_Γ jb hzn
    rw [← h1] at hΓ
    exact (hsecI hz).2 hΓ.2

/-- **A chart sector inside a horn of direction `α` is itself such a horn**: its two germs have direction `α` (mod `2π`), and it is
the horn of their curvatures at every chart radius. -/
theorem horn_of_sector_subset_hornSet (X : F.Near v) {r : ℝ} (hr : r ∈ Ioc 0 X.r₀) {α a b : ℝ} {j : Fin X.n}
    (hsub : X.G.sector v r j ⊆ hornSet v α a b r) :
    e (X.G.β j) = e α ∧ X.G.nextβ j = X.G.β j ∧ X.G.κ j < X.G.nextκ j ∧
      ∀ r' ∈ Ioc 0 X.r₀, X.G.sector v r' j = hornSet v α (X.G.κ j) (X.G.nextκ j) r' := by
  have hcone1 : ∀ β ∈ coneAt (X.G.sector v r j) v, e β = e α := fun β hβ =>
    e_eq_of_mem_coneAt_hornSet (coneAt_mono hsub v hβ)
  have hconei := X.hC.cone r hr j
  have hβi : e (X.G.β j) = e α :=
    hcone1 _ (by rw [hconei]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, X.hC.sorted.mono j⟩)
  rcases X.hC.sorted.2 j with hlt' | ⟨heq, hκ⟩
  · exfalso
    have hd : 0 < X.G.nextβ j - X.G.β j := sub_pos.mpr hlt'
    have hε0 : 0 < min (X.G.nextβ j - X.G.β j) π / 2 := by have := lt_min hd Real.pi_pos; positivity
    have hεπ : min (X.G.nextβ j - X.G.β j) π / 2 < π := by
      have := min_le_right (X.G.nextβ j - X.G.β j) π; linarith [Real.pi_pos]
    have hmem : X.G.β j + min (X.G.nextβ j - X.G.β j) π / 2 ∈ coneAt (X.G.sector v r j) v := by
      rw [hconei]
      refine Icc_subset_angleIcc _ _ ⟨by linarith, ?_⟩
      have := min_le_left (X.G.nextβ j - X.G.β j) π; linarith
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp ((hcone1 _ hmem).trans hβi.symm)
    have hm1 : (0 : ℝ) < m := by nlinarith [Real.pi_pos]
    have hm2 : (m : ℝ) < 1 := by nlinarith [Real.pi_pos]
    have : (0 : ℤ) < m := by exact_mod_cast hm1
    have : m < 1 := by exact_mod_cast hm2
    omega
  · refine ⟨hβi, heq.symm, hκ, fun r' hr' => ?_⟩
    have h1 : |X.G.κ j| * r' ≤ 2 := (mul_le_mul_of_nonneg_left hr'.2 (abs_nonneg _)).trans (X.hC.curv j).le
    have h2 : |X.G.nextκ j| * r' ≤ 2 := (mul_le_mul_of_nonneg_left hr'.2 (abs_nonneg _)).trans (X.hC.curv_next j).le
    show sectorBetween v (X.G.β j) (X.G.κ j) (X.G.nextβ j) (X.G.nextκ j) r' = _
    rw [← heq, sectorBetween_eq_hornSet v _ _ _ r' h1 h2, hornSet_congr hβi]

end Near

end ArcMap

namespace RayGap

/-- **A horn spanning two horns and the gap between them, cut by curvature**: a point of `hornSet v α κ₁ κ₄ r` lies in the lower horn,
on the arc of curvature `κ₂`, in the gap, on the arc of curvature `κ₃`, or in the upper horn. -/
theorem mem_hornSet_cases {v z : ℂ} {α κ₁ κ₂ κ₃ κ₄ r : ℝ} (hz : z ∈ hornSet v α κ₁ κ₄ r) (h2 : |κ₂| * ‖z - v‖ ≤ 2)
    (h3 : |κ₃| * ‖z - v‖ ≤ 2) :
    z ∈ hornSet v α κ₁ κ₂ r ∨ z = branchPt v α κ₂ ‖z - v‖ ∨ z ∈ hornSet v α κ₂ κ₃ r ∨ z = branchPt v α κ₃ ‖z - v‖ ∨
      z ∈ hornSet v α κ₃ κ₄ r := by
  obtain ⟨hd, hX, hA, hB⟩ := hz
  rcases lt_trichotomy (tanHeight κ₂ (frameX v α z) (frameY v α z)) 0 with h | h | h
  · exact Or.inl ⟨hd, hX, hA, h⟩
  · exact Or.inr (Or.inl (eq_branchPt_of_tanHeight_eq_zero hX h h2))
  rcases lt_trichotomy (tanHeight κ₃ (frameX v α z) (frameY v α z)) 0 with h' | h' | h'
  · exact Or.inr (Or.inr (Or.inl ⟨hd, hX, h, h'⟩))
  · exact Or.inr (Or.inr (Or.inr (Or.inl (eq_branchPt_of_tanHeight_eq_zero hX h' h3))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr ⟨hd, hX, h', hB⟩)))

end RayGap

namespace ArcMap

variable {k : ℕ}

/-- **The ray merge's colouring**: `c` on the horn `hornSet v α κ₁ κ₄ ρ` that spans the two horns and the gap between them, `F`'s
elsewhere. -/
noncomputable def rayCol (F : ArcMap k) (v : ℂ) (α κ₁ κ₄ ρ : ℝ) (c : Fin k) : ℂ → Fin k := fun z => by
  classical exact if z ∈ hornSet v α κ₁ κ₄ ρ then c else F.col z

variable {F : ArcMap k} {v : ℂ}

/-- The ray merge's colouring on its horn. -/
theorem rayCol_of_mem {α κ₁ κ₄ ρ : ℝ} {c : Fin k} {z : ℂ} (hz : z ∈ hornSet v α κ₁ κ₄ ρ) : F.rayCol v α κ₁ κ₄ ρ c z = c := by
  simp [rayCol, hz]

/-- The ray merge's colouring off its horn. -/
theorem rayCol_of_not_mem {α κ₁ κ₄ ρ : ℝ} {c : Fin k} {z : ℂ} (hz : z ∉ hornSet v α κ₁ κ₄ ρ) :
    F.rayCol v α κ₁ κ₄ ρ c z = F.col z := by
  simp [rayCol, hz]

/-- Spec: the ray merge's colouring is `c` at a branch point of curvature `1/2` in `hornSet 0 0 0 1 1` and `F`'s at the axis point
`1/2`, which is off the horn. -/
example (F : ArcMap 3) : F.rayCol 0 0 0 1 1 2 (branchPt 0 0 (1 / 2) (1 / 2)) = 2 ∧ F.rayCol 0 0 0 1 1 2 (1 / 2) = F.col (1 / 2) := by
  refine ⟨rayCol_of_mem (branchPt_mem_hornSet 0 0 (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by norm_num [abs_of_pos])), rayCol_of_not_mem fun h => ?_⟩
  have := h.2.2.1
  simp [TanAbove, tanHeight, frameX, frameY, e] at this

namespace Near

/-- The germs the ray merge keeps: every germ but those of direction `α` with curvature in `[κ₂, κ₃]`. -/
def rayKeep (X : F.Near v) (α κ₂ κ₃ : ℝ) : Set (Fin X.n) := {i | ¬ (e (X.G.β i) = e α ∧ κ₂ ≤ X.G.κ i ∧ X.G.κ i ≤ κ₃)}

/-- Spec: a germ of direction `α` with curvature in `[κ₂, κ₃]` is cut, any other kept. -/
example (X : F.Near v) (i : Fin X.n) (hβ : e (X.G.β i) = e 0) :
    (X.G.κ i = 0 → i ∉ X.rayKeep 0 0 1) ∧ (X.G.κ i = 2 → i ∈ X.rayKeep 0 0 1) := by
  refine ⟨fun h hk => hk ⟨hβ, by rw [h], by rw [h]; norm_num⟩, fun h hk => ?_⟩
  have := hk.2.2; rw [h] at this; norm_num at this

/-- **The configuration of a ray merge** at `v`, at radius `ρ`: the lower horn is the chart sector `i₀` (curvatures `κ₁ < κ₂`), the upper
horn the sector `i₁` (curvatures `κ₃ < κ₄`), the germ after `i₀` has curvature `κ₂` and the germ after `i₁` curvature `κ₄`, all of
direction `α`, with `−1 ≤ κ₁ < κ₂ < κ₃ < κ₄ ≤ 1`. -/
structure RayConfig (X : F.Near v) (ρ α κ₁ κ₂ κ₃ κ₄ : ℝ) (i₀ i₁ : Fin X.n) : Prop where
  /-- The radius is small for the moves. -/
  small : X.Small ρ
  /-- The lower horn is the chart sector `i₀`. -/
  sec₀ : ∀ r ∈ Ioc 0 X.r₀, X.G.sector v r i₀ = hornSet v α κ₁ κ₂ r
  /-- The upper horn is the chart sector `i₁`. -/
  sec₁ : ∀ r ∈ Ioc 0 X.r₀, X.G.sector v r i₁ = hornSet v α κ₃ κ₄ r
  /-- The lower horn's lower germ. -/
  germ₀ : e (X.G.β i₀) = e α ∧ X.G.κ i₀ = κ₁
  /-- The lower horn's upper germ. -/
  germ₂ : e (X.G.β (BranchGerms.next i₀)) = e α ∧ X.G.κ (BranchGerms.next i₀) = κ₂
  /-- The upper horn's lower germ. -/
  germ₃ : e (X.G.β i₁) = e α ∧ X.G.κ i₁ = κ₃
  /-- The upper horn's upper germ. -/
  germ₄ : e (X.G.β (BranchGerms.next i₁)) = e α ∧ X.G.κ (BranchGerms.next i₁) = κ₄
  /-- The lower curvature is at least `−1`. -/
  h1 : -1 ≤ κ₁
  /-- The lower horn is a horn. -/
  h12 : κ₁ < κ₂
  /-- The gap is a horn. -/
  h23 : κ₂ < κ₃
  /-- The upper horn is a horn. -/
  h34 : κ₃ < κ₄
  /-- The upper curvature is at most `1`. -/
  h4 : κ₄ ≤ 1

variable {X : F.Near v} {ρ α κ₁ κ₂ κ₃ κ₄ : ℝ} {i₀ i₁ : Fin X.n}

/-- The configuration's curvatures lie in `[−1, 1]`. -/
theorem RayConfig.abs_curv_le (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) :
    |κ₁| ≤ 1 ∧ |κ₂| ≤ 1 ∧ |κ₃| ≤ 1 ∧ |κ₄| ≤ 1 := by
  have := hR.h1; have := hR.h12; have := hR.h23; have := hR.h34; have := hR.h4
  exact ⟨abs_le.mpr ⟨by linarith, by linarith⟩, abs_le.mpr ⟨by linarith, by linarith⟩,
    abs_le.mpr ⟨by linarith, by linarith⟩, abs_le.mpr ⟨by linarith, by linarith⟩⟩

/-- A curvature in `[−1, 1]` is admissible at every distance below `ρ < 1/2`. -/
theorem RayConfig.curv_lt (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) {κ s : ℝ} (hκ : |κ| ≤ 1) (hs : s ≤ ρ) :
    |κ| * s < 2 := by
  have := hR.small.2.2.2; nlinarith [abs_nonneg κ]

/-- **A chart sector meeting the gap lies in it and is a horn there**: its germs have direction `α` and curvatures in `[κ₂, κ₃]`. -/
theorem RayConfig.gap_sector (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) {j : Fin X.n}
    (hmeet : (X.G.sector v ρ j ∩ hornSet v α κ₂ κ₃ ρ).Nonempty) :
    X.G.sector v ρ j ⊆ hornSet v α κ₂ κ₃ ρ ∧ e (X.G.β j) = e α ∧ κ₂ ≤ X.G.κ j ∧ X.G.κ j < X.G.nextκ j ∧
      X.G.nextκ j ≤ κ₃ := by
  obtain ⟨-, hκ2, hκ3, -⟩ := hR.abs_curv_le
  have hsub := X.sector_subset_hornSet_of_meets hR.small hκ2 hκ3 hR.germ₂ hR.germ₃ ⟨hR.small.1, le_rfl⟩ hmeet
  obtain ⟨hβ, -, hlt, hsec⟩ := X.horn_of_sector_subset_hornSet hR.small.mem_Ioc hsub
  rw [hsec ρ hR.small.mem_Ioc] at hsub
  obtain ⟨h1, h2⟩ := RayGap.curv_le_of_hornSet_subset hlt hR.small.1 hsub
  exact ⟨by rw [← hsec ρ hR.small.mem_Ioc] at hsub; exact hsub, hβ, h1, hlt, h2⟩

/-- **The kept germs' branches miss the merge's horn** `hornSet v α κ₁ κ₄ ρ`. -/
theorem RayConfig.branchPt_not_mem (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) {i : Fin X.n} (hi : i ∈ X.rayKeep α κ₂ κ₃)
    {s : ℝ} (hs : s ∈ Ioo 0 ρ) : branchPt v (X.G.β i) (X.G.κ i) s ∉ hornSet v α κ₁ κ₄ ρ := by
  intro hz
  have h := hR.small
  obtain ⟨-, hκ2, hκ3, -⟩ := hR.abs_curv_le
  have hn : 0 < X.n := i.pos
  have hns : ‖branchPt v (X.G.β i) (X.G.κ i) s - v‖ = s := norm_branchPt_sub v _ _ hs.1.le
  have hs₀ : s ∈ Ioo 0 X.s₀ := ⟨hs.1, hs.2.trans h.2.1⟩
  have hsr : s ∈ Ioo 0 X.r₀ := ⟨hs.1, hs.2.trans h.lt_r₀⟩
  have hΓ := X.hC.branchPt_mem_Γ i hsr
  have hI : ∀ j, branchPt v (X.G.β i) (X.G.κ i) s ∉ X.G.sector v ρ j := fun j hj =>
    (X.hC.sector_subset_interiorPts hn h.mem_Ioc j hj).2 hΓ.2
  rcases RayGap.mem_hornSet_cases hz (by rw [hns]; exact (hR.curv_lt hκ2 hs.2.le).le)
    (by rw [hns]; exact (hR.curv_lt hκ3 hs.2.le).le) with h1 | h1 | h1 | h1 | h1
  · exact hI i₀ (by rw [hR.sec₀ ρ h.mem_Ioc]; exact h1)
  · rw [hns, ← hR.germ₂.2, ← branchPt_congr_dir hR.germ₂.1] at h1
    have := eq_of_branchPt_eq X.hdisj hs₀ h1
    apply hi; rw [this]; exact ⟨hR.germ₂.1, le_of_eq hR.germ₂.2.symm, by rw [hR.germ₂.2]; exact hR.h23.le⟩
  · have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h.2.1.le i hs
    obtain ⟨w, hwH, hws⟩ := mem_closure_iff.mp hcl _ (isOpen_hornSet v α κ₂ κ₃ ρ) h1
    obtain ⟨-, hβ, hk2, hlt, hk3⟩ := hR.gap_sector ⟨w, hws, hwH⟩
    exact hi ⟨hβ, hk2, hlt.le.trans hk3⟩
  · rw [hns, ← hR.germ₃.2, ← branchPt_congr_dir hR.germ₃.1] at h1
    have := eq_of_branchPt_eq X.hdisj hs₀ h1
    apply hi; rw [this]; exact ⟨hR.germ₃.1, by rw [hR.germ₃.2]; exact hR.h23.le, le_of_eq hR.germ₃.2⟩
  · exact hI i₁ (by rw [hR.sec₁ ρ h.mem_Ioc]; exact h1)

/-- **The points off the kept branches** in the punctured ball are the merge's horn and `F`'s interior points. -/
theorem RayConfig.off_keep_iff (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) {z : ℂ} (hz : z ∈ ball v ρ) :
    (z ≠ v ∧ ∀ i ∈ X.rayKeep α κ₂ κ₃, z ≠ branchPt v (X.G.β i) (X.G.κ i) ‖z - v‖) ↔
      z ∈ hornSet v α κ₁ κ₄ ρ ∨ z ∈ F.interiorPts := by
  have h := hR.small
  have hn : 0 < X.n := i₀.pos
  obtain ⟨hκ1, hκ2, hκ3, hκ4⟩ := hR.abs_curv_le
  have hzρ : ‖z - v‖ < ρ := by rw [← dist_eq_norm]; exact hz
  constructor
  · rintro ⟨hzv, hK⟩
    by_cases hM : z ∈ hornSet v α κ₁ κ₄ ρ
    · exact Or.inl hM
    right
    refine (X.mem_interiorPts_iff h hz hzv).mpr fun i hzi => ?_
    by_cases hiK : i ∈ X.rayKeep α κ₂ κ₃
    · exact hK i hiK hzi
    · simp only [rayKeep, mem_setOf_eq, not_not] at hiK
      obtain ⟨hβ, hk2, hk3⟩ := hiK
      have hs0 : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
      have hκi : |X.G.κ i| ≤ 1 := abs_le.mpr ⟨by linarith [hR.h1, hR.h12], by linarith [hR.h34, hR.h4]⟩
      apply hM
      rw [hzi, branchPt_congr_dir hβ]
      exact branchPt_mem_hornSet v α (by linarith [hR.h12]) (by linarith [hR.h34]) hs0 hzρ
        (hR.curv_lt hκi hzρ.le)
  · rintro (hM | hI)
    · have hzv : z ≠ v := fun h' => by
        have := hM.2.1; rw [h', frameX_self] at this; exact lt_irrefl 0 this
      refine ⟨hzv, fun i hi hzi => ?_⟩
      have hs : ‖z - v‖ ∈ Ioo 0 ρ := ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), hzρ⟩
      exact hR.branchPt_not_mem hi hs (hzi ▸ hM)
    · have hzv : z ≠ v := fun h' => X.not_mem_interiorPts_self hn (h' ▸ hI)
      exact ⟨hzv, fun i _ => (X.mem_interiorPts_iff h hz hzv).mp hI i⟩


/-- The lower horn's germ is kept. -/
theorem RayConfig.mem_keep₀ (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) : i₀ ∈ X.rayKeep α κ₂ κ₃ := fun h' => by
  have := h'.2.1; rw [hR.germ₀.2] at this; linarith [hR.h12]

/-- The germ after the upper horn is kept. -/
theorem RayConfig.mem_keep₄ (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) : BranchGerms.next i₁ ∈ X.rayKeep α κ₂ κ₃ := fun h' => by
  have := h'.2.2; rw [hR.germ₄.2] at this; linarith [hR.h34]

/-- **A chart sector off the gap, other than the two horns, misses the merge's horn.** -/
theorem RayConfig.sector_disjoint (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) {j : Fin X.n} (hj0 : j ≠ i₀) (hj1 : j ≠ i₁)
    (hjG : ¬ X.G.sector v ρ j ⊆ hornSet v α κ₂ κ₃ ρ) : Disjoint (X.G.sector v ρ j) (hornSet v α κ₁ κ₄ ρ) := by
  rw [disjoint_left]
  intro z hzj hzM
  have h := hR.small
  have hn : 0 < X.n := j.pos
  obtain ⟨-, hκ2, hκ3, -⟩ := hR.abs_curv_le
  have hzI := X.hC.sector_subset_interiorPts hn h.mem_Ioc j hzj
  have hzρ : ‖z - v‖ < ρ := by rw [← dist_eq_norm]; exact X.G.sector_subset_ball j hzj
  have hz0 : 0 < ‖z - v‖ := (X.G.mem_sector_iff.mp hzj).1.1
  have hsr : ‖z - v‖ ∈ Ioo 0 X.r₀ := ⟨hz0, hzρ.trans h.lt_r₀⟩
  rcases RayGap.mem_hornSet_cases hzM (hR.curv_lt hκ2 hzρ.le).le (hR.curv_lt hκ3 hzρ.le).le with h1 | h1 | h1 | h1 | h1
  · rw [← hR.sec₀ ρ h.mem_Ioc] at h1
    exact disjoint_left.mp (X.hC.disjoint ρ h.mem_Ioc j i₀ hj0) hzj h1
  · rw [← hR.germ₂.2, ← branchPt_congr_dir hR.germ₂.1] at h1
    have hΓ := X.hC.branchPt_mem_Γ (BranchGerms.next i₀) hsr
    rw [← h1] at hΓ; exact hzI.2 hΓ.2
  · exact hjG (hR.gap_sector ⟨z, hzj, h1⟩).1
  · rw [← hR.germ₃.2, ← branchPt_congr_dir hR.germ₃.1] at h1
    have hΓ := X.hC.branchPt_mem_Γ i₁ hsr
    rw [← h1] at hΓ; exact hzI.2 hΓ.2
  · rw [← hR.sec₁ ρ h.mem_Ioc] at h1
    exact disjoint_left.mp (X.hC.disjoint ρ h.mem_Ioc j i₁ hj1) hzj h1

/-- The two horns are different chart sectors. -/
theorem RayConfig.ne (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) : i₀ ≠ i₁ := fun h' => by
  have e := (hR.sec₀ ρ hR.small.mem_Ioc).symm.trans (h' ▸ hR.sec₁ ρ hR.small.mem_Ioc)
  have := (hornSet_curv_eq hR.h12 hR.h34 hR.small.1 e).1
  linarith [hR.h12, hR.h23]

/-- **The ray merge's sector count**: a map whose interior points in `B(v, ρ)` are the merge's horn and `F`'s, coloured by `rayCol`,
has one `c`-sector fewer at `v`, when the gap holds no chart sector of colour `c`: the two horns, the gap's sectors and the two
branches between become one piece, the horn `hornSet v α κ₁ κ₄ r`. -/
theorem RayConfig.hasSectors (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) {F' : ArcMap k} {c : Fin k} (hci₀ : X.col i₀ = c)
    (hci₁ : X.col i₁ = c) (hfree : ∀ j, X.G.sector v ρ j ⊆ hornSet v α κ₂ κ₃ ρ → X.col j ≠ c)
    {m : ℕ} (hm : {i | X.col i = c}.encard = m + 1)
    (hint : ∀ z ∈ ball v ρ, z ∈ F'.interiorPts ↔ z ∈ hornSet v α κ₁ κ₄ ρ ∨ z ∈ F.interiorPts)
    (hcol' : ∀ z, F'.col z = F.rayCol v α κ₁ κ₄ ρ c z) : F'.HasSectors v c m := by
  have h := hR.small
  obtain ⟨hκ1, -, -, hκ4⟩ := hR.abs_curv_le
  have hn : 0 < X.n := i₀.pos
  have h14 : κ₁ < κ₄ := by linarith [hR.h12, hR.h23, hR.h34]
  filter_upwards [Ioc_mem_nhdsGT h.1] with r hr
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hr.2.trans h.lt_r₀.le⟩
  set T := {j : Fin X.n // j ≠ i₀ ∧ j ≠ i₁ ∧ ¬ X.G.sector v ρ j ⊆ hornSet v α κ₂ κ₃ ρ} with hT
  set A : Option T → Set ℂ := fun o => Option.elim o (hornSet v α κ₁ κ₄ r) (fun j => X.G.sector v r j.1) with hA
  set colA : Option T → Fin k := fun o => Option.elim o c (fun j => X.col j.1) with hcolA
  have hdisjρ : ∀ j : T, Disjoint (X.G.sector v ρ j.1) (hornSet v α κ₁ κ₄ ρ) := fun j =>
    hR.sector_disjoint j.2.1 j.2.2.1 j.2.2.2
  have hMr : hornSet v α κ₁ κ₄ r ⊆ hornSet v α κ₁ κ₄ ρ := hornSet_mono_radius hr.2
  have hsecI : ∀ i, X.G.sector v r i ⊆ F.interiorPts := X.hC.sector_subset_interiorPts hn hr₀
  have hU : F'.interiorPts ∩ ball v r = ⋃ o, A o := by
    ext z
    constructor
    · rintro ⟨hzI, hzr⟩
      by_cases hM : z ∈ hornSet v α κ₁ κ₄ ρ
      · exact mem_iUnion.mpr ⟨none, ⟨hzr, hM.2.1, hM.2.2.1, hM.2.2.2⟩⟩
      · have hF := ((hint z (ball_subset_ball hr.2 hzr)).mp hzI).resolve_left hM
        have : z ∈ ball v r ∩ F.interiorPts := ⟨hzr, hF⟩
        rw [X.hC.cover r hr₀ hn] at this
        obtain ⟨j, hj⟩ := mem_iUnion.mp this
        have hjρ := X.G.sector_mono hr.2 j hj
        have hj0 : j ≠ i₀ := fun h' => hM (by
          rw [h', hR.sec₀ ρ h.mem_Ioc] at hjρ
          exact hornSet_mono le_rfl (by linarith [hR.h23, hR.h34]) hjρ)
        have hj1 : j ≠ i₁ := fun h' => hM (by
          rw [h', hR.sec₁ ρ h.mem_Ioc] at hjρ
          exact hornSet_mono (by linarith [hR.h12, hR.h23]) le_rfl hjρ)
        have hjG : ¬ X.G.sector v ρ j ⊆ hornSet v α κ₂ κ₃ ρ := fun hG =>
          hM (hornSet_mono hR.h12.le hR.h34.le (hG hjρ))
        exact mem_iUnion.mpr ⟨some ⟨j, hj0, hj1, hjG⟩, hj⟩
    · intro hz
      obtain ⟨o, ho⟩ := mem_iUnion.mp hz
      match o, ho with
      | none, ho => exact ⟨(hint z (ball_subset_ball hr.2 ho.1)).mpr (Or.inl (hMr ho)), ho.1⟩
      | some j, ho =>
        exact ⟨(hint z (ball_subset_ball hr.2 (X.G.sector_subset_ball _ ho))).mpr (Or.inr (hsecI _ ho)),
          X.G.sector_subset_ball _ ho⟩
  refine (encard_sectorsOf_of_partition (F := F') (A := A) (colA := colA) hU ?_ ?_ ?_ ?_ ?_ c).trans ?_
  · intro o
    match o with
    | none => exact isOpen_hornSet v α κ₁ κ₄ r
    | some j => exact X.hC.isOpen r hr₀ _
  · intro o
    match o with
    | none => exact isPreconnected_hornSet v α h14 (hR.curv_lt hκ1 hr.2) (hR.curv_lt hκ4 hr.2)
    | some j => exact X.hC.isPreconnected r hr₀ _
  · intro o o' hoo'
    match o, o', hoo' with
    | none, none, h' => exact absurd rfl h'
    | some j, some j', h' => exact X.hC.disjoint r hr₀ _ _ fun e => h' (congrArg some (Subtype.ext e))
    | some j, none, _ => exact (hdisjρ j).mono (X.G.sector_mono hr.2 _) hMr
    | none, some j, _ => exact ((hdisjρ j).mono (X.G.sector_mono hr.2 _) hMr).symm
  · intro o _
    match o with
    | none => exact mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α h14 hr.1)
    | some j => exact X.hC.mem_closure_sector hr₀ _
  · intro o z hz
    show F'.col z = colA o
    match o, hz with
    | none, hz => exact (hcol' z).trans (rayCol_of_mem (hMr hz))
    | some j, hz =>
      rw [hcol', rayCol_of_not_mem fun hM => disjoint_left.mp (hdisjρ j) (X.G.sector_mono hr.2 _ hz) hM]
      have := (X.hcol j.1 r hr₀ hz).2
      simp only [mem_preimage, mem_singleton_iff] at this
      exact this
  · have hMne : (hornSet v α κ₁ κ₄ r).Nonempty := by
      obtain ⟨z, hz, -⟩ := mem_coneAt_hornSet v α h14 hr.1 1 one_pos
      exact ⟨z, hz⟩
    have hset : {o | (A o).Nonempty ∧ colA o = c} =
        insert none (some '' (Subtype.val ⁻¹' ({i | X.col i = c} \ {i₀, i₁}) : Set T)) := by
      ext o
      match o with
      | none =>
        simp only [mem_setOf_eq, mem_insert_iff, true_or, iff_true]
        exact ⟨hMne, rfl⟩
      | some j =>
        simp only [mem_setOf_eq, mem_insert_iff, reduceCtorEq, false_or, mem_image, Option.some.injEq,
          exists_eq_right, mem_preimage, Set.mem_sdiff, mem_insert_iff, mem_singleton_iff, not_or]
        exact ⟨fun h' => ⟨h'.2, j.2.1, j.2.2.1⟩, fun h' => ⟨X.hC.sector_nonempty hr₀ _, h'.1⟩⟩
    have hrange : {i | X.col i = c} \ {i₀, i₁} ⊆ range (Subtype.val : T → Fin X.n) := by
      rintro i ⟨hic, hi⟩
      simp only [mem_insert_iff, mem_singleton_iff, not_or] at hi
      exact ⟨⟨i, hi.1, hi.2, fun hG => hfree i hG hic⟩, rfl⟩
    rw [hset, encard_insert_of_notMem (by simp), (Option.some_injective T).encard_image,
      encard_preimage_of_injective_subset_range Subtype.val_injective hrange]
    have h2 := encard_sdiff_add_encard_of_subset (show ({i₀, i₁} : Set (Fin X.n)) ⊆ {i | X.col i = c} by
      rintro i (rfl | rfl)
      · exact hci₀
      · exact hci₁)
    rw [encard_pair hR.ne, hm] at h2
    have h3 : ({i | X.col i = c} \ {i₀, i₁}).encard + 1 + 1 = (m : ℕ∞) + 1 := by
      rw [add_assoc, one_add_one_eq_two]; exact h2
    exact ENat.add_left_injective_of_ne_top (by simp) h3

/-- **The ray merge's colouring is locally constant off the kept germs' arcs**: `c` on the open horn `hornSet v α κ₁ κ₄ ρ`; off it,
off its closure too (its frontier in the ball is two kept germs' branches), where the colouring is `F`'s. -/
theorem RayConfig.hlc (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) (c : Fin k) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ (X.rayKeep α κ₂ κ₃) ∅, a.carrier →
      ∀ᶠ y in 𝓝 x, F.rayCol v α κ₁ κ₄ ρ c y = F.rayCol v α κ₁ κ₄ ρ c x := by
  have h := hR.small
  obtain ⟨hκ1, -, -, hκ4⟩ := hR.abs_curv_le
  refine surgery_hlc_of X.hG h.1 (fun z hz => rayCol_of_not_mem fun hz' => hz (ball_subset_closedBall hz'.1))
    (sphere_subset_newArcs h) fun x hx hxA => ?_
  have hK : (X.rayKeep α κ₂ κ₃).Nonempty := ⟨i₀, hR.mem_keep₀⟩
  rw [mem_newArcs_iff h hK hx] at hxA
  push Not at hxA
  obtain ⟨hxv, hxb, -⟩ := hxA
  have hoff : x ≠ v ∧ ∀ i ∈ X.rayKeep α κ₂ κ₃, x ≠ branchPt v (X.G.β i) (X.G.κ i) ‖x - v‖ :=
    ⟨hxv, fun i hi => hxb hxv i hi⟩
  by_cases hxM : x ∈ hornSet v α κ₁ κ₄ ρ
  · filter_upwards [(isOpen_hornSet v α κ₁ κ₄ ρ).mem_nhds hxM] with y hy
    rw [rayCol_of_mem hy, rayCol_of_mem hxM]
  · have hxI : x ∈ F.interiorPts := ((hR.off_keep_iff hx).mp hoff).resolve_left hxM
    have hxcl : x ∉ closure (hornSet v α κ₁ κ₄ ρ) := by
      intro hcl
      rcases RayGap.eq_of_mem_closure_hornSet hκ1 hκ4 (by linarith [h.2.2.2]) hcl hx hxM with h1 | h1 | h1
      · exact hxv h1
      · apply hoff.2 i₀ hR.mem_keep₀
        rw [branchPt_congr_dir hR.germ₀.1, hR.germ₀.2]; exact h1
      · apply hoff.2 _ hR.mem_keep₄
        rw [branchPt_congr_dir hR.germ₄.1, hR.germ₄.2]; exact h1
    have hev : ∀ᶠ y in 𝓝 x, y ∉ hornSet v α κ₁ κ₄ ρ := by
      filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hxcl] with y hy hy' using hy (subset_closure hy')
    filter_upwards [F.locallyConstant x hxI.1 hxI.2, hev] with y hy hy'
    rw [rayCol_of_not_mem hy', rayCol_of_not_mem hxM, hy]


/-- **The ray merge** (N4-RAY's construction, with item 262 (a)'s correction): when the gap between the two horns holds no chart sector of
colour `c` and is clear for `c`, recolouring the horn `hornSet v α κ₁ κ₄ ρ` with `c` and cutting the germs of direction `α` with curvature
in `[κ₂, κ₃]` merges the two horns: a valid map agreeing with `F` off `B̄(v, ρ)`, creating no unit arc, keeping Condition 5, with one
`c`-sector fewer at `v`, no new colour at `v`, and at most three colours at each point of `∂B(v, ρ)`. -/
theorem RayConfig.exists_merge (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) (hF : F.Valid) {c : Fin k} (hci₀ : X.col i₀ = c)
    (hci₁ : X.col i₁ = c) (hfree : ∀ j, X.G.sector v ρ j ⊆ hornSet v α κ₂ κ₃ ρ → X.col j ≠ c)
    (hclear : ∀ z ∈ hornSet v α κ₂ κ₃ ρ, F.IsClear c z) {m : ℕ} (hm : {i | X.col i = c}.encard = m + 1) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧ (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c m ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  have h := hR.small
  have hn0 : 0 < X.n := i₀.pos
  obtain ⟨-, hκ2, hκ3, -⟩ := hR.abs_curv_le
  have hEnd : ∀ a ∈ (∅ : Set Arc), a.Nondegenerate := fun a ha => absurd ha (notMem_empty a)
  have hEin : ∀ a ∈ (∅ : Set Arc), a.carrier ⊆ closedBall v ρ := fun a ha => absurd ha (notMem_empty a)
  have hcol : ∀ z ∉ closedBall v ρ, F.rayCol v α κ₁ κ₄ ρ c z = F.col z := fun z hz =>
    rayCol_of_not_mem fun hz' => hz (ball_subset_closedBall hz'.1)
  have hK : (X.rayKeep α κ₂ κ₃).Nonempty := ⟨i₀, hR.mem_keep₀⟩
  set F' := X.move h (X.rayKeep α κ₂ κ₃) ∅ (F.rayCol v α κ₁ κ₄ ρ c) hEnd finite_empty (hR.hlc c) with hF'
  have hint : ∀ z ∈ ball v ρ, z ∈ F'.interiorPts ↔ z ∈ hornSet v α κ₁ κ₄ ρ ∨ z ∈ F.interiorPts := by
    intro z hz
    rw [mem_move_interiorPts_iff hz, mem_newArcs_iff h hK hz, ← hR.off_keep_iff hz]
    constructor
    · intro hn
      push Not at hn
      obtain ⟨hzv, hzb, -⟩ := hn
      exact ⟨hzv, fun i hi => hzb hzv i hi⟩
    · rintro ⟨hzv, hzb⟩ (h1 | ⟨-, i, hi, h2⟩ | h3)
      · exact hzv h1
      · exact hzb i hi h2
      · simp at h3
  have hcolc : ∀ {i : Fin X.n}, X.col i = c → ∀ z ∈ X.G.sector v ρ i, F.IsClear c z := fun {i} hic z hz => by
    have hI := X.hC.sector_subset_interiorPts hn0 h.mem_Ioc i hz
    have hzc : F.col z = c := by
      have := (X.hcol i ρ h.mem_Ioc hz).2
      simp only [mem_preimage, mem_singleton_iff] at this
      rw [this, hic]
    have := isClear_col hF hI
    rwa [hzc] at this
  refine ⟨F', ?_, move_agreesOff hEin hcol, move_ringArcsWithin (fun a ha => absurd ha (notMem_empty a)),
    move_condition5 (fun a ha => absurd ha (notMem_empty a)), hR.hasSectors hci₀ hci₁ hfree hm hint (fun z => rfl), ?_, ?_⟩
  · refine move_valid hF hEin hcol fun z hz hzI => ?_
    by_cases hM : z ∈ hornSet v α κ₁ κ₄ ρ
    · rw [rayCol_of_mem hM]
      have hzρ : ‖z - v‖ < ρ := by rw [← dist_eq_norm]; exact hz
      have hzv : z ≠ v := fun h' => by have := hM.2.1; rw [h', frameX_self] at this; exact lt_irrefl 0 this
      have hz0 : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
      rcases RayGap.mem_hornSet_cases hM (hR.curv_lt hκ2 hzρ.le).le (hR.curv_lt hκ3 hzρ.le).le with
        h1 | h1 | h1 | h1 | h1
      · exact hcolc hci₀ z (by rw [hR.sec₀ ρ h.mem_Ioc]; exact h1)
      · refine isClear_of_mem_closure hclear ?_
        rw [h1]; exact branchPt_mem_closure_hornSet_lower v α hR.h23 hz0 hzρ (hR.curv_lt hκ2 hzρ.le)
      · exact hclear z h1
      · refine isClear_of_mem_closure hclear ?_
        rw [h1]; exact branchPt_mem_closure_hornSet_upper v α hR.h23 hz0 hzρ (hR.curv_lt hκ3 hzρ.le)
      · exact hcolc hci₁ z (by rw [hR.sec₁ ρ h.mem_Ioc]; exact h1)
    · rw [rayCol_of_not_mem hM]
      exact isClear_col hF (((hint z hz).mp hzI).resolve_left hM)
  · refine move_coloursAt_self fun z hz hzI => ?_
    by_cases hM : z ∈ hornSet v α κ₁ κ₄ ρ
    · left
      rw [rayCol_of_mem hM]
      show v ∈ closure (F.region c)
      rw [← hci₀]
      exact closure_mono (X.hcol₀ i₀) (X.hC.mem_closure_sector X.hs₀ i₀)
    · right
      exact ⟨((hint z hz).mp hzI).resolve_left hM, rayCol_of_not_mem hM⟩
  · intro x hx
    have hsub := move_coloursAt_sphere (h := h) (hE := hEnd) (hEf := finite_empty) (hlc := hR.hlc c)
      hEin hcol (R := hornSet v α κ₁ κ₄ ρ) (C := {c})
      (fun z hz hzI hzR => ⟨((hint z hz).mp hzI).resolve_left hzR, rayCol_of_not_mem hzR⟩)
      (fun z hz _ => by rw [rayCol_of_mem hz.1]; rfl) x
    have hsub' : F'.coloursAt x ⊆ F.coloursAt x ∪ {c} := fun j hj => by
      rcases hsub hj with h1 | ⟨-, h2⟩
      · exact Or.inl h1
      · exact Or.inr h2
    have hxv : x ≠ v := fun h' => by rw [h', mem_sphere, dist_self] at hx; linarith [h.1]
    have hxs : x ∈ ball v X.s₀ := by rw [mem_ball]; rw [mem_sphere] at hx; rw [hx]; exact h.2.1
    calc (F'.coloursAt x).ncard ≤ (F.coloursAt x ∪ {c}).ncard := ncard_le_ncard hsub' (toFinite _)
      _ ≤ (F.coloursAt x).ncard + ({c} : Set (Fin k)).ncard := ncard_union_le _ _
      _ ≤ 2 + 1 := by
        rw [ncard_singleton]; gcongr; exact X.hC.ncard_coloursAt_le_two X.hs₀ X.hdisj hxv hxs
      _ = 3 := by norm_num


end Near

/-- **N4-RAY's merge, with the nearest `c`-horn** (item 262 (a)): of the `c`-horns along `α` above the lower horn — the upper horn and
every chart sector of colour `c` inside the gap — take the one of least lower curvature; if that curvature is the lower horn's upper
one, the two `c`-sectors are adjacent and the cut merges them, otherwise the gap between them holds no `c`-sector and the ray merge
(`RayConfig.exists_merge`) merges them. -/
theorem exists_rayMerge_of_clear (hF : F.Valid) (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₂ κ₃ r, F.IsClear c z) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨i₀, hβ₀, hnβ₀, hκ₀, hnκ₀, hci₀, hsec₀⟩ := X.horn_index hH
  obtain ⟨i₁, hβ₁, hnβ₁, hκ₁', hnκ₁, hci₁, hsec₁⟩ := X.horn_index hH'
  have hn0 : 0 < X.n := i₀.pos
  obtain ⟨ρ, hs, hcl⟩ := (X.eventually_small.and hclear).exists
  have hm := X.encard_col_eq hn0 hn
  have germ₂ : e (X.G.β (BranchGerms.next i₀)) = e α ∧ X.G.κ (BranchGerms.next i₀) = κ₂ :=
    ⟨by rw [← BranchGerms.e_nextβ, hnβ₀, hβ₀], by rw [← BranchGerms.nextκ_eq, hnκ₀]⟩
  set C : Set (Fin X.n) := {j | X.col j = c ∧ (j = i₁ ∨ X.G.sector v ρ j ⊆ hornSet v α κ₂ κ₃ ρ)} with hCdef
  have hC1 : i₁ ∈ C := ⟨hci₁, Or.inl rfl⟩
  obtain ⟨j, hjC, hjmin⟩ := (toFinite C).toFinset.exists_min_image (fun j => X.G.κ j)
    ⟨i₁, (Set.Finite.mem_toFinset _).mpr hC1⟩
  rw [Set.Finite.mem_toFinset] at hjC
  have hjfacts : e (X.G.β j) = e α ∧ X.G.nextβ j = X.G.β j ∧ X.G.κ j < X.G.nextκ j ∧
      (∀ r' ∈ Ioc 0 X.r₀, X.G.sector v r' j = hornSet v α (X.G.κ j) (X.G.nextκ j) r') ∧
      κ₂ ≤ X.G.κ j ∧ X.G.κ j ≤ κ₃ ∧ X.G.nextκ j ≤ κ₄ := by
    rcases hjC.2 with hj | hG
    · rw [hj, hκ₁', hnκ₁]
      exact ⟨hβ₁, hnβ₁, hH'.1, hsec₁, h23.le, le_rfl, le_rfl⟩
    · obtain ⟨hβ, hnβ, hlt, hsec⟩ := X.horn_of_sector_subset_hornSet hs.mem_Ioc hG
      have hG' := hG
      rw [hsec ρ hs.mem_Ioc] at hG'
      obtain ⟨h2', h3'⟩ := RayGap.curv_le_of_hornSet_subset hlt hs.1 hG'
      exact ⟨hβ, hnβ, hlt, hsec, h2', by linarith, by linarith [hH'.1]⟩
  obtain ⟨hβj, hnβj, hltj, hsecj, h2j, h3j, h4j⟩ := hjfacts
  rcases eq_or_lt_of_le h2j with heq | hlt
  · -- the sector just above the lower horn has colour `c`: the cut merges them
    have hj_eq : j = BranchGerms.next i₀ := by
      by_contra hne
      exact X.hC.sorted.κ_ne hne (hβj.trans germ₂.1.symm) (by rw [← heq, germ₂.2])
    have hcj : X.col (BranchGerms.next i₀) = c := hj_eq ▸ hjC.1
    obtain ⟨F', h1', h2', h3', h4', h5', h6', h7'⟩ :=
      X.exists_cut hF hs (BranchGerms.ne_next_of_nextβ_eq hnβ₀) hci₀ hcj hm
    exact ⟨ρ, hs.1, F', h1', h2', h3', h4', h5', h6', fun x hx => (h7' x hx).trans (by norm_num)⟩
  · -- the ray merge with the nearest `c`-horn above
    have hR : X.RayConfig ρ α κ₁ κ₂ (X.G.κ j) (X.G.nextκ j) i₀ j :=
      { small := hs, sec₀ := hsec₀, sec₁ := hsecj, germ₀ := ⟨hβ₀, hκ₀⟩, germ₂ := germ₂, germ₃ := ⟨hβj, rfl⟩,
        germ₄ := ⟨by rw [← BranchGerms.e_nextβ, hnβj, hβj], (BranchGerms.nextκ_eq j).symm⟩,
        h1 := h1, h12 := hH.1, h23 := hlt, h34 := hltj, h4 := h4j.trans h4 }
    have hfree : ∀ j', X.G.sector v ρ j' ⊆ hornSet v α κ₂ (X.G.κ j) ρ → X.col j' ≠ c := by
      intro j' hsub hc'
      have hsub' : X.G.sector v ρ j' ⊆ hornSet v α κ₂ κ₃ ρ := hsub.trans (hornSet_mono le_rfl h3j)
      have hmin := hjmin j' ((Set.Finite.mem_toFinset _).mpr ⟨hc', Or.inr hsub'⟩)
      obtain ⟨-, -, hlt', hsec'⟩ := X.horn_of_sector_subset_hornSet hs.mem_Ioc hsub
      rw [hsec' ρ hs.mem_Ioc] at hsub
      have := (RayGap.curv_le_of_hornSet_subset hlt' hs.1 hsub).2
      linarith
    have hclear' : ∀ z ∈ hornSet v α κ₂ (X.G.κ j) ρ, F.IsClear c z := fun z hz =>
      hcl z (hornSet_mono le_rfl h3j hz)
    obtain ⟨F', h1', h2', h3', h4', h5', h6', h7'⟩ := hR.exists_merge hF hci₀ hjC.1 hfree hclear' hm
    exact ⟨ρ, hs.1, F', h1', h2', h3', h4', h5', h6', h7'⟩

end ArcMap

end HadwigerNelson.Plane
