import Proofs.HadwigerNelson.Plane.ValidMap.Contact

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## N4-FLANK's mechanism: where a horn's shadow comes from -/

/-- The frame's first coordinate moves by at most the distance moved. -/
theorem abs_frameX_sub_le (v : ℂ) (α : ℝ) (y y₀ : ℂ) : |frameX v α y - frameX v α y₀| ≤ dist y y₀ := by
  rw [frameX_sub, dist_eq_norm]
  refine (Complex.abs_re_le_norm _).trans ?_
  rw [norm_mul, RCLike.norm_conj, norm_e, mul_one]

/-- The frame's second coordinate is at most the distance from the frame's origin. -/
theorem abs_frameY_le_norm (v : ℂ) (α : ℝ) (z : ℂ) : |frameY v α z| ≤ ‖z - v‖ := by
  have h := frame_normSq v α z
  have h0 := sq_abs (frameY v α z)
  nlinarith [abs_nonneg (frameY v α z), norm_nonneg (z - v), sq_nonneg (frameX v α z)]

/-- **A horn point lies near its axis**: for curvatures in `[−1, 1]`, `|y| ≤ ‖z − v‖²/2` in the frame at `v`. -/
theorem abs_frameY_le_of_mem_hornSet {v z : ℂ} {α κ₁ κ₂ r : ℝ} (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hz : z ∈ hornSet v α κ₁ κ₂ r) : |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2 := by
  obtain ⟨-, -, hA, hB⟩ := hz
  have hq := frame_normSq v α z
  unfold TanAbove tanHeight at hA
  unfold TanBelow tanHeight at hB
  have hq0 : 0 ≤ frameX v α z ^ 2 + frameY v α z ^ 2 := by positivity
  have e1 : 0 ≤ (κ₁ + 1) * (frameX v α z ^ 2 + frameY v α z ^ 2) := mul_nonneg (by linarith) hq0
  have e2 : 0 ≤ (1 - κ₂) * (frameX v α z ^ 2 + frameY v α z ^ 2) := mul_nonneg (by linarith) hq0
  rw [abs_le]
  constructor <;> nlinarith

/-- **A point near the axis is ahead along it**: `x ≥ ‖z − v‖/2` when `x > 0`, `|y| ≤ ‖z − v‖²/2` and `‖z − v‖ ≤ 1`. -/
theorem half_norm_le_frameX {v z : ℂ} {α : ℝ} (hz1 : ‖z - v‖ ≤ 1) (hX : 0 < frameX v α z)
    (hY : |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2) : ‖z - v‖ / 2 ≤ frameX v α z := by
  have h := frame_normSq v α z
  have hs0 := norm_nonneg (z - v)
  have hY2 : frameY v α z ^ 2 ≤ (‖z - v‖ ^ 2 / 2) ^ 2 := by
    rw [← sq_abs]; exact pow_le_pow_left₀ (abs_nonneg _) hY 2
  have hs4 : ‖z - v‖ ^ 4 ≤ ‖z - v‖ ^ 2 := by
    have : ‖z - v‖ ^ 2 ≤ 1 := by nlinarith
    nlinarith
  by_contra hlt
  push Not at hlt
  nlinarith

/-- **The push toward `N`**: if `z` near `v` is at unit distance from `y` near `N = v + n`, every `z + t n` with `0 < t < 1` is
nearer than `1` to `y`. -/
theorem dist_push_up_lt_one {v z y : ℂ} {α t : ℝ} (hz : dist z v < 1 / 4) (hy : dist y (v + e (α + π / 2)) < 1 / 4)
    (hzy : dist z y = 1) (ht0 : 0 < t) (ht1 : t < 1) : dist (z + (t : ℂ) * e (α + π / 2)) y < 1 := by
  have hd := sq_dist_frame v α (z + (t : ℂ) * e (α + π / 2)) y
  have hd0 := sq_dist_frame v α z y
  rw [frameX_add_normal, frameY_add_normal] at hd
  have hYz : |frameY v α z| < 1 / 4 := lt_of_le_of_lt (abs_frameY_le_norm v α z) (by rw [← dist_eq_norm]; exact hz)
  have hYy : |frameY v α y - 1| < 1 / 4 := by
    have h := sq_dist_N v α y
    have h0 := sq_abs (frameY v α y - 1)
    have : dist y (v + e (α + π / 2)) ^ 2 < (1 / 4) ^ 2 := pow_lt_pow_left₀ hy dist_nonneg (by norm_num)
    nlinarith [abs_nonneg (frameY v α y - 1), sq_nonneg (frameX v α y)]
  rw [abs_lt] at hYz hYy
  have h2 : dist (z + (t : ℂ) * e (α + π / 2)) y ^ 2 < 1 := by rw [hd]; nlinarith
  nlinarith [dist_nonneg (x := z + (t : ℂ) * e (α + π / 2)) (y := y)]

/-- **The push toward `S′`**: if `z` near `v` is at unit distance from `y` near `S′ = v − n`, every `z − t n` with `0 < t < 1` is
nearer than `1` to `y`. -/
theorem dist_push_down_lt_one {v z y : ℂ} {α t : ℝ} (hz : dist z v < 1 / 4) (hy : dist y (v - e (α + π / 2)) < 1 / 4)
    (hzy : dist z y = 1) (ht0 : 0 < t) (ht1 : t < 1) : dist (z + ((-t : ℝ) : ℂ) * e (α + π / 2)) y < 1 := by
  have hd := sq_dist_frame v α (z + ((-t : ℝ) : ℂ) * e (α + π / 2)) y
  have hd0 := sq_dist_frame v α z y
  rw [frameX_add_normal, frameY_add_normal] at hd
  have hYz : |frameY v α z| < 1 / 4 := lt_of_le_of_lt (abs_frameY_le_norm v α z) (by rw [← dist_eq_norm]; exact hz)
  have hYy : |frameY v α y + 1| < 1 / 4 := by
    have h := sq_dist_S v α y
    have h0 := sq_abs (frameY v α y + 1)
    have : dist y (v - e (α + π / 2)) ^ 2 < (1 / 4) ^ 2 := pow_lt_pow_left₀ hy dist_nonneg (by norm_num)
    nlinarith [abs_nonneg (frameY v α y + 1), sq_nonneg (frameX v α y)]
  rw [abs_lt] at hYz hYy
  have h2 : dist (z + ((-t : ℝ) : ℂ) * e (α + π / 2)) y ^ 2 < 1 := by rw [hd]; nlinarith
  nlinarith [dist_nonneg (x := z + ((-t : ℝ) : ℂ) * e (α + π / 2)) (y := y)]

/-- A horn's points are at most its radius from its base point, and the horn grows with its radius. -/
theorem hornSet_mono_radius {v : ℂ} {α κ₁ κ₂ r r' : ℝ} (h : r ≤ r') : hornSet v α κ₁ κ₂ r ⊆ hornSet v α κ₁ κ₂ r' :=
  fun _ ⟨hd, hx, hA, hB⟩ => ⟨lt_of_lt_of_le hd h, hx, hA, hB⟩

/-- The small root of a horn point's height: for `x ∈ (0, 1/4)` and `|y| ≤ (x² + y²)/2`, `|y| ≤ x²`. -/
theorem abs_le_sq_of_near_axis {x y : ℝ} (hx : 0 < x) (hq : x ^ 2 + y ^ 2 < 1 / 16) (hy : |y| ≤ (x ^ 2 + y ^ 2) / 2) :
    |y| ≤ x ^ 2 := by
  have h0 := sq_abs y
  have hy4 : |y| < 1 / 4 := by nlinarith [abs_nonneg y]
  nlinarith [abs_nonneg y]

/-- **A horn point pushed up meets the band above it** (child of N4-FLANK): for `z` in the horn between `κ₁ ≥ −1` and `κ₂`, of
radius `r ≤ 1/4`, and `κ₂ < κ' ≤ 1`, some `z + t n` with `0 < t < 1` lies in the horn between `κ₂` and `κ'` of radius `2r`. -/
theorem exists_push_up {v z : ℂ} {α κ₁ κ₂ κ' r : ℝ} (h1 : -1 ≤ κ₁) (h2 : κ₂ < κ') (h' : κ' ≤ 1) (hr : r ≤ 1 / 4)
    (hz : z ∈ hornSet v α κ₁ κ₂ r) :
    ∃ t : ℝ, 0 < t ∧ t < 1 ∧ z + (t : ℂ) * e (α + π / 2) ∈ hornSet v α κ₂ κ' (2 * r) := by
  have hY := abs_frameY_le_of_mem_hornSet h1 (h2.le.trans h') hz
  obtain ⟨hzr, hx, hA, hB⟩ := hz
  set x := frameX v α z with hxdef
  set y := frameY v α z with hydef
  have hq := frame_normSq v α z
  rw [← hxdef, ← hydef] at hq
  have hzr' : ‖z - v‖ < r := by rw [← dist_eq_norm]; exact hzr
  have hq16 : x ^ 2 + y ^ 2 < 1 / 16 := by rw [hq]; nlinarith [norm_nonneg (z - v)]
  have hy2 : |y| ≤ x ^ 2 := abs_le_sq_of_near_axis hx hq16 (by rw [hq]; exact hY)
  have hxr : x < r := by nlinarith [norm_nonneg (z - v)]
  have hx4 : x < 1 / 4 := by linarith
  unfold TanAbove tanHeight at hA
  unfold TanBelow tanHeight at hB
  rw [← hxdef, ← hydef] at hA hB
  have hk12 : κ₁ < κ₂ := by
    by_contra hle; push Not at hle
    have : κ₂ * (x ^ 2 + y ^ 2) ≤ κ₁ * (x ^ 2 + y ^ 2) := mul_le_mul_of_nonneg_right hle (by positivity)
    linarith
  set m := (κ₂ + κ') / 2 with hm
  set f : ℝ → ℝ := fun t => tanHeight m x (y + t) with hf
  have hfc : ContinuousOn f (Icc 0 x) := by
    apply Continuous.continuousOn; simp only [hf, tanHeight]; fun_prop
  have hf0 : f 0 < 0 := by
    simp only [hf, tanHeight, add_zero]
    have : κ₂ * (x ^ 2 + y ^ 2) ≤ m * (x ^ 2 + y ^ 2) := mul_le_mul_of_nonneg_right (by linarith) (by positivity)
    linarith
  have hfx : 0 < f x := by
    simp only [hf, tanHeight]
    have hm1 : |m| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
    have hyx : |y + x| ≤ 2 * x := by
      rw [abs_le] at hy2 ⊢; constructor <;> nlinarith
    have hsq : (y + x) ^ 2 ≤ 4 * x ^ 2 := by
      have := sq_abs (y + x); nlinarith [abs_nonneg (y + x)]
    have hmq : m * (x ^ 2 + (y + x) ^ 2) ≤ x ^ 2 + (y + x) ^ 2 := by
      have h0 : 0 ≤ x ^ 2 + (y + x) ^ 2 := by positivity
      nlinarith [abs_le.mp hm1]
    rw [abs_le] at hy2
    nlinarith
  obtain ⟨t, ht, hft⟩ := intermediate_value_Icc hx.le hfc ⟨hf0.le, hfx.le⟩
  have ht0 : t ≠ 0 := by rintro rfl; exact absurd hft hf0.ne
  have htx : t ≠ x := by rintro rfl; exact absurd hft hfx.ne'
  have ht0' : 0 < t := lt_of_le_of_ne ht.1 (Ne.symm ht0)
  have htx' : t < x := lt_of_le_of_ne ht.2 htx
  refine ⟨t, ht0', by linarith, ?_, ?_, ?_, ?_⟩
  · calc dist (z + (t : ℂ) * e (α + π / 2)) v ≤ dist z v + ‖(t : ℂ) * e (α + π / 2)‖ := by
          rw [dist_eq_norm, dist_eq_norm, show z + (t : ℂ) * e (α + π / 2) - v = (z - v) + (t : ℂ) * e (α + π / 2) by ring]
          exact norm_add_le _ _
      _ < r + r := by
          rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0']
          linarith
      _ = 2 * r := by ring
  · rw [frameX_add_normal]; exact hx
  · show 0 < tanHeight κ₂ (frameX v α _) (frameY v α _)
    rw [frameX_add_normal, frameY_add_normal, ← hxdef, ← hydef]
    have hft' : tanHeight m x (y + t) = 0 := hft
    unfold tanHeight at hft' ⊢
    have : 0 < x ^ 2 + (y + t) ^ 2 := by positivity
    nlinarith
  · show tanHeight κ' (frameX v α _) (frameY v α _) < 0
    rw [frameX_add_normal, frameY_add_normal, ← hxdef, ← hydef]
    have hft' : tanHeight m x (y + t) = 0 := hft
    unfold tanHeight at hft' ⊢
    have : 0 < x ^ 2 + (y + t) ^ 2 := by positivity
    nlinarith

/-- **A horn point pushed down meets the band below it** (the mirror of `exists_push_up`): for `z` in the horn between `κ₁`
and `κ₂ ≤ 1`, of radius `r ≤ 1/4`, and `−1 ≤ κ' < κ₁`, some `z − t n` with `0 < t < 1` lies in the horn between `κ'` and `κ₁` of
radius `2r`. -/
theorem exists_push_down {v z : ℂ} {α κ₁ κ₂ κ' r : ℝ} (h2 : κ₂ ≤ 1) (h1 : κ' < κ₁) (h' : -1 ≤ κ') (hr : r ≤ 1 / 4)
    (hz : z ∈ hornSet v α κ₁ κ₂ r) :
    ∃ t : ℝ, 0 < t ∧ t < 1 ∧ z + ((-t : ℝ) : ℂ) * e (α + π / 2) ∈ hornSet v α κ' κ₁ (2 * r) := by
  have hY := abs_frameY_le_of_mem_hornSet (h'.trans h1.le) h2 hz
  obtain ⟨hzr, hx, hA, hB⟩ := hz
  set x := frameX v α z with hxdef
  set y := frameY v α z with hydef
  have hq := frame_normSq v α z
  rw [← hxdef, ← hydef] at hq
  have hzr' : ‖z - v‖ < r := by rw [← dist_eq_norm]; exact hzr
  have hq16 : x ^ 2 + y ^ 2 < 1 / 16 := by rw [hq]; nlinarith [norm_nonneg (z - v)]
  have hy2 : |y| ≤ x ^ 2 := abs_le_sq_of_near_axis hx hq16 (by rw [hq]; exact hY)
  have hxr : x < r := by nlinarith [norm_nonneg (z - v)]
  unfold TanAbove tanHeight at hA
  unfold TanBelow tanHeight at hB
  rw [← hxdef, ← hydef] at hA hB
  have hk12 : κ₁ < κ₂ := by
    by_contra hle; push Not at hle
    have : κ₂ * (x ^ 2 + y ^ 2) ≤ κ₁ * (x ^ 2 + y ^ 2) := mul_le_mul_of_nonneg_right hle (by positivity)
    linarith
  set m := (κ' + κ₁) / 2 with hm
  set f : ℝ → ℝ := fun t => tanHeight m x (y - t) with hf
  have hfc : ContinuousOn f (Icc 0 x) := by
    apply Continuous.continuousOn; simp only [hf, tanHeight]; fun_prop
  have hf0 : 0 < f 0 := by
    simp only [hf, tanHeight, sub_zero]
    have : m * (x ^ 2 + y ^ 2) ≤ κ₁ * (x ^ 2 + y ^ 2) := mul_le_mul_of_nonneg_right (by linarith) (by positivity)
    linarith
  have hfx : f x < 0 := by
    simp only [hf, tanHeight]
    have hm1 : |m| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
    have hyx : |y - x| ≤ 2 * x := by
      rw [abs_le] at hy2 ⊢; constructor <;> nlinarith
    have hsq : (y - x) ^ 2 ≤ 4 * x ^ 2 := by
      have := sq_abs (y - x); nlinarith [abs_nonneg (y - x)]
    have hmq : -(x ^ 2 + (y - x) ^ 2) ≤ m * (x ^ 2 + (y - x) ^ 2) := by
      have h0 : 0 ≤ x ^ 2 + (y - x) ^ 2 := by positivity
      nlinarith [abs_le.mp hm1]
    rw [abs_le] at hy2
    nlinarith
  obtain ⟨t, ht, hft⟩ := intermediate_value_Icc' hx.le hfc ⟨hfx.le, hf0.le⟩
  have ht0 : t ≠ 0 := by rintro rfl; exact absurd hft hf0.ne'
  have htx : t ≠ x := by rintro rfl; exact absurd hft hfx.ne
  have ht0' : 0 < t := lt_of_le_of_ne ht.1 (Ne.symm ht0)
  have htx' : t < x := lt_of_le_of_ne ht.2 htx
  refine ⟨t, ht0', by linarith, ?_, ?_, ?_, ?_⟩
  · calc dist (z + ((-t : ℝ) : ℂ) * e (α + π / 2)) v ≤ dist z v + ‖((-t : ℝ) : ℂ) * e (α + π / 2)‖ := by
          rw [dist_eq_norm, dist_eq_norm,
            show z + ((-t : ℝ) : ℂ) * e (α + π / 2) - v = (z - v) + ((-t : ℝ) : ℂ) * e (α + π / 2) by ring]
          exact norm_add_le _ _
      _ < r + r := by
          rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos ht0']
          linarith
      _ = 2 * r := by ring
  · rw [frameX_add_normal]; exact hx
  · show 0 < tanHeight κ' (frameX v α _) (frameY v α _)
    rw [frameX_add_normal, frameY_add_normal, ← hxdef, ← hydef]
    have hft' : tanHeight m x (y - t) = 0 := hft
    unfold tanHeight at hft' ⊢
    have : 0 < x ^ 2 + (y + -t) ^ 2 := by positivity
    nlinarith
  · show tanHeight κ₁ (frameX v α _) (frameY v α _) < 0
    rw [frameX_add_normal, frameY_add_normal, ← hxdef, ← hydef]
    have hft' : tanHeight m x (y - t) = 0 := hft
    unfold tanHeight at hft' ⊢
    have : 0 < x ^ 2 + (y + -t) ^ 2 := by positivity
    nlinarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The pole contradiction** (N-E2 at a pole): a point `p` of a `g`-tile `A` farther than `1` from a closure point `P` of a
`g`-tile `T` cannot be nearer than `1` to a point of `T` (the tiles are near or far). -/
theorem false_of_pole (hF : F.Valid) {g : Fin k} {T A : Set ℂ} (hT : F.TileOf g T) (hA : F.TileOf g A)
    {y p P : ℂ} (hPT : P ∈ closure T) (hy : y ∈ T) (hp : p ∈ A) (hpP : 1 < dist p P) (hpy : dist p y < 1) : False := by
  rcases unitNear_or_unitFar hF hA hT with hn | hf
  · exact absurd (UnitNear.dist_le_of_mem_closure hn (subset_closure hp) hPT) (not_le.mpr hpP)
  · exact absurd (hf p hp y hy) (not_lt.mpr hpy.le)

/-- An upper flank's axis is a direction of its colour's class at `v`. -/
theorem IsFlankAbove.mem_coneAt {v : ℂ} {α κ₂ : ℝ} {g : Fin k} (hg : F.IsFlankAbove v α κ₂ g) :
    α ∈ coneAt (F.region g) v := by
  obtain ⟨κ', hκ', hev⟩ := hg
  obtain ⟨r, hr, hr0⟩ := (hev.and self_mem_nhdsWithin).exists
  exact coneAt_mono hr v (mem_coneAt_hornSet v α hκ' hr0)

/-- A lower flank's axis is a direction of its colour's class at `v`. -/
theorem IsFlankBelow.mem_coneAt {v : ℂ} {α κ₁ : ℝ} {h : Fin k} (hh : F.IsFlankBelow v α κ₁ h) :
    α ∈ coneAt (F.region h) v := by
  obtain ⟨κ', hκ', hev⟩ := hh
  obtain ⟨r, hr, hr0⟩ := (hev.and self_mem_nhdsWithin).exists
  exact coneAt_mono hr v (mem_coneAt_hornSet v α hκ' hr0)

/-- **An upper flank keeps the horn out of the shadow of its colour near `N`** (N4-FLANK, "out-type `g` at `N` shadows an
upward-closed set that must miss the flank sector, hence misses `H`"): pushing a horn point up into the flank brings it nearer
than `1` to any `g`-point near `N` it was at unit distance from, while the flank point, outside `B̄(N, 1)`, is far from every
`g`-tile at `N` (N-E2). -/
theorem horn_not_shadowed_near_N (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {g : Fin k}
    (h1 : -1 ≤ κ₁) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g) :
    ∃ δ > 0, ∃ ρ > 0, ∀ z ∈ hornSet v α κ₁ κ₂ ρ, ∀ y ∈ F.region g,
      dist y (v + e (α + π / 2)) < δ → dist z y ≠ 1 := by
  have hNdom : v + e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_e])
  obtain ⟨δt, hδt, hδT⟩ := exists_ball_tiles_mem_closure hNdom
  obtain ⟨κ', hκ', hev⟩ := hg
  obtain ⟨r₀, hr₀sub, hr₀⟩ := (hev.and self_mem_nhdsWithin).exists
  have hr₀' : (0 : ℝ) < r₀ := hr₀
  refine ⟨min δt (1 / 4), by positivity, min (r₀ / 2) (1 / 8), by positivity, ?_⟩
  intro z hz y hy hyN hzy
  obtain ⟨t, ht0, ht1, hp⟩ := exists_push_up h1 (lt_min hκ' h2) (min_le_right _ _)
    (le_trans (min_le_right _ _) (by norm_num)) hz
  have hpg : z + (t : ℂ) * e (α + π / 2) ∈ F.region g :=
    hr₀sub (hornSet_mono le_rfl (min_le_left _ _) (hornSet_mono_radius (by linarith [min_le_left (r₀ / 2) (1 / 8)]) hp))
  have hpN : 1 < dist (z + (t : ℂ) * e (α + π / 2)) (v + e (α + π / 2)) := by
    rw [← tanBelow_one_iff]
    exact lt_of_le_of_lt (tanHeight_anti (min_le_right κ' 1) _ _) hp.2.2.2
  have hzv : dist z v < 1 / 4 := lt_of_lt_of_le hz.1 (le_trans (min_le_right _ _) (by norm_num))
  have hpy := dist_push_up_lt_one hzv (lt_of_lt_of_le hyN (min_le_right _ _)) hzy ht0 ht1
  obtain ⟨hTy, hyT⟩ := tileOf_component hy
  obtain ⟨hAp, hpA⟩ := tileOf_component hpg
  have hNT := hδT _ hTy.1 ⟨y, hyT, lt_of_lt_of_le hyN (min_le_left _ _)⟩
  exact false_of_pole hF hTy hAp hNT hyT hpA hpN hpy

/-- **A lower flank keeps the horn out of the shadow of its colour near `S′`** (the mirror of `horn_not_shadowed_near_N`). -/
theorem horn_not_shadowed_near_S (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {h : Fin k}
    (h2 : κ₂ ≤ 1) (h1 : -1 < κ₁) (hh : F.IsFlankBelow v α κ₁ h) :
    ∃ δ > 0, ∃ ρ > 0, ∀ z ∈ hornSet v α κ₁ κ₂ ρ, ∀ y ∈ F.region h,
      dist y (v - e (α + π / 2)) < δ → dist z y ≠ 1 := by
  have hSdom : v - e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e])
  obtain ⟨δt, hδt, hδT⟩ := exists_ball_tiles_mem_closure hSdom
  obtain ⟨κ', hκ', hev⟩ := hh
  obtain ⟨r₀, hr₀sub, hr₀⟩ := (hev.and self_mem_nhdsWithin).exists
  have hr₀' : (0 : ℝ) < r₀ := hr₀
  refine ⟨min δt (1 / 4), by positivity, min (r₀ / 2) (1 / 8), by positivity, ?_⟩
  intro z hz y hy hyS hzy
  obtain ⟨t, ht0, ht1, hp⟩ := exists_push_down h2 (max_lt hκ' h1) (le_max_right _ _)
    (le_trans (min_le_right _ _) (by norm_num)) hz
  have hph : z + ((-t : ℝ) : ℂ) * e (α + π / 2) ∈ F.region h :=
    hr₀sub (hornSet_mono (le_max_left _ _) le_rfl (hornSet_mono_radius (by linarith [min_le_left (r₀ / 2) (1 / 8)]) hp))
  have hpS : 1 < dist (z + ((-t : ℝ) : ℂ) * e (α + π / 2)) (v - e (α + π / 2)) := by
    rw [← tanAbove_neg_one_iff]
    exact lt_of_lt_of_le hp.2.2.1 (tanHeight_anti (le_max_right κ' (-1)) _ _)
  have hzv : dist z v < 1 / 4 := lt_of_lt_of_le hz.1 (le_trans (min_le_right _ _) (by norm_num))
  have hpy := dist_push_down_lt_one hzv (lt_of_lt_of_le hyS (min_le_right _ _)) hzy ht0 ht1
  obtain ⟨hTy, hyT⟩ := tileOf_component hy
  obtain ⟨hAp, hpA⟩ := tileOf_component hph
  have hST := hδT _ hTy.1 ⟨y, hyT, lt_of_lt_of_le hyS (min_le_left _ _)⟩
  exact false_of_pole hF hTy hAp hST hyT hpA hpS hpy

/-- `frameX v α y` is the dot product of `e α` with `y − v`. -/
theorem dot_e_sub_eq_frameX (v : ℂ) (α : ℝ) (y : ℂ) : dot (e α) (y - v) = frameX v α y := by
  rw [dot_e_eq_frameX]; unfold frameX; rw [sub_zero]

/-- The in-type estimate (real arithmetic): `‖z − y‖² < 1` for `z` near the axis within `m/4` of `v` and `y` inside `B(v, 1)`
ahead by `m/2`. -/
theorem shadow_ineq_in {Xz Yz Xy Yy s m : ℝ} (hqz : Xz ^ 2 + Yz ^ 2 = s ^ 2) (hqy : Xy ^ 2 + Yy ^ 2 < 1)
    (hXz : s / 2 ≤ Xz) (hp : -(s ^ 2 / 2) ≤ Yz * Yy) (hXX : Xz * (m / 2) ≤ Xz * Xy) (hm : 0 < m) (hs0 : 0 < s)
    (hsm : s < m / 4) : (Xz - Xy) ^ 2 + (Yz - Yy) ^ 2 < 1 := by
  have h1 : s / 2 * m ≤ Xz * m := mul_le_mul_of_nonneg_right hXz hm.le
  have h2 : s * s < s * (m / 4) := mul_lt_mul_of_pos_left hsm hs0
  nlinarith

/-- The out-type estimate (real arithmetic): `‖z − y‖² > 1` for `z` near the axis within `|m|/2` of `v` and `y` outside
`B̄(v, 1)` behind by `|m|/2`. -/
theorem shadow_ineq_out {Xz Yz Xy Yy s m : ℝ} (hqz : Xz ^ 2 + Yz ^ 2 = s ^ 2) (hqy : 1 < Xy ^ 2 + Yy ^ 2)
    (hXz : s / 2 ≤ Xz) (hp : Yz * Yy ≤ s ^ 2) (hXX : Xz * Xy ≤ Xz * (m / 2)) (hm : m < 0) (hs0 : 0 < s)
    (hsm : s < -m / 2) : 1 < (Xz - Xy) ^ 2 + (Yz - Yy) ^ 2 := by
  have h1 : Xz * m ≤ s / 2 * m := mul_le_mul_of_nonpos_right hXz hm.le
  have h2 : s * s < s * (-m / 2) := mul_lt_mul_of_pos_left hsm hs0
  nlinarith

/-- A point with `x > 0` is not the frame's origin. -/
theorem norm_pos_of_frameX_pos {v z : ℂ} {α : ℝ} (hX : 0 < frameX v α z) : 0 < ‖z - v‖ := by
  rcases (norm_nonneg (z - v)).lt_or_eq with h | h
  · exact h
  · exfalso
    have hq := frame_normSq v α z
    rw [← h] at hq
    linarith [pow_pos hX 2, sq_nonneg (frameY v α z)]

/-- A unit-circle point with `x = 0` in the frame at `v` is `N` or `S′`. -/
theorem eq_N_or_S_of_frameX_eq_zero {v y : ℂ} {α : ℝ} (hy : dist y v = 1) (hm : frameX v α y = 0) :
    dist y (v + e (α + π / 2)) = 0 ∨ dist y (v - e (α + π / 2)) = 0 := by
  have hq := frame_normSq v α y
  rw [← dist_eq_norm, hy, hm] at hq
  have : (frameY v α y - 1) * (frameY v α y + 1) = 0 := by linear_combination hq
  rcases mul_eq_zero.mp this with h | h
  · left
    have h2 := sq_dist_N v α y
    rw [hm, show frameY v α y - 1 = 0 from h] at h2
    exact pow_eq_zero_iff two_ne_zero |>.mp (by rw [h2]; ring)
  · right
    have h2 := sq_dist_S v α y
    rw [hm, show frameY v α y + 1 = 0 from h] at h2
    exact pow_eq_zero_iff two_ne_zero |>.mp (by rw [h2]; ring)

/-- **The local step at a contact off the poles** (child of `shadow_source_near_poles`): near a contact `y₀` of `c` with
`e α·(y₀ − v) ≠ 0` and `e α ∈ D_c(v)`, no point of `c`'s class is at unit distance from a point near `v` close to the axis. -/
theorem shadow_local_contact (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α : ℝ} {c : Fin k}
    (hcα : e α ∈ F.allowedCone v c) {y₀ : ℂ} (hcont : F.IsContact v c y₀) (hm0 : frameX v α y₀ ≠ 0) :
    ∃ ε₁ > 0, ∃ ε₂ > 0, ∀ z y, dist z v < ε₁ → dist y y₀ < ε₂ → 0 < frameX v α z →
      |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2 → y ∈ F.region c → dist z y ≠ 1 := by
  have hy1 : dist y₀ v = 1 := hcont.2.1
  have hy₀dom : y₀ ∈ F.dom := hv (by rw [mem_closedBall, hy1])
  obtain ⟨δt, hδt, hδT⟩ := exists_ball_tiles_mem_closure hy₀dom
  set m := frameX v α y₀ with hmdef
  have hcone := hcα y₀ hcont
  rw [dot_e_sub_eq_frameX, ← hmdef] at hcone
  rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
  · -- in-type: `m > 0`, the tiles at `y₀` inside `B(v, 1)`
    have hm : 0 < m := lt_of_le_of_ne (hcone.1 hin) (Ne.symm hm0)
    refine ⟨min (m / 4) 1, by positivity, min δt (m / 2), by positivity, ?_⟩
    intro z y hz hy hX hY hyc hzy
    obtain ⟨hTy, hyT⟩ := tileOf_component hyc
    have hwT := hδT _ hTy.1 ⟨y, hyT, lt_of_lt_of_le hy (min_le_left _ _)⟩
    have hyv : dist y v < 1 := hin _ hTy hwT hyT
    have hXy : m / 2 < frameX v α y := by
      have h1 := abs_frameX_sub_le v α y y₀
      rw [← hmdef] at h1
      have h2 := lt_of_le_of_lt h1 (lt_of_lt_of_le hy (min_le_right _ _))
      rw [abs_lt] at h2; linarith
    have hqy := frame_normSq v α y
    have hyv' : ‖y - v‖ ^ 2 < 1 := by
      have := pow_lt_pow_left₀ hyv dist_nonneg two_ne_zero
      rw [dist_eq_norm, one_pow] at this; exact this
    have hYy : |frameY v α y| ≤ 1 := (abs_frameY_le_norm v α y).trans (by rw [← dist_eq_norm]; exact hyv.le)
    have hs1 : ‖z - v‖ < 1 := by rw [← dist_eq_norm]; exact lt_of_lt_of_le hz (min_le_right _ _)
    have hsm : ‖z - v‖ < m / 4 := by rw [← dist_eq_norm]; exact lt_of_lt_of_le hz (min_le_left _ _)
    have hprod : |frameY v α z * frameY v α y| ≤ ‖z - v‖ ^ 2 / 2 := by
      rw [abs_mul]
      calc |frameY v α z| * |frameY v α y| ≤ (‖z - v‖ ^ 2 / 2) * 1 :=
            mul_le_mul hY hYy (abs_nonneg _) (by positivity)
        _ = ‖z - v‖ ^ 2 / 2 := by ring
    have h := shadow_ineq_in (frame_normSq v α z) (by rw [hqy]; exact hyv') (half_norm_le_frameX hs1.le hX hY)
      (abs_le.mp hprod).1 (mul_le_mul_of_nonneg_left hXy.le hX.le) hm (norm_pos_of_frameX_pos hX) hsm
    rw [← sq_dist_frame, hzy] at h; norm_num at h
  · -- out-type: `m < 0`, the tiles at `y₀` outside `B̄(v, 1)`
    have hm : m < 0 := lt_of_le_of_ne (hcone.2 hout) hm0
    have hm2 : 0 < -m / 2 := by linarith
    refine ⟨min (-m / 2) 1, lt_min hm2 one_pos, min δt (min (-m / 2) 1), lt_min hδt (lt_min hm2 one_pos), ?_⟩
    intro z y hz hy hX hY hyc hzy
    obtain ⟨hTy, hyT⟩ := tileOf_component hyc
    have hwT := hδT _ hTy.1 ⟨y, hyT, lt_of_lt_of_le hy (min_le_left _ _)⟩
    have hyv : 1 < dist y v := by
      have := disjoint_left.mp (hout _ hTy hwT) hyT
      rw [mem_closedBall, not_le] at this; exact this
    have hyy₀ : dist y y₀ < min (-m / 2) 1 := lt_of_lt_of_le hy (min_le_right _ _)
    have hXy : frameX v α y < m / 2 := by
      have h1 := abs_frameX_sub_le v α y y₀
      rw [← hmdef] at h1
      have h2 := lt_of_le_of_lt h1 (lt_of_lt_of_le hyy₀ (min_le_left _ _))
      rw [abs_lt] at h2; linarith
    have hqy := frame_normSq v α y
    have hyv' : 1 < ‖y - v‖ ^ 2 := by
      have := one_lt_pow₀ hyv two_ne_zero
      rw [dist_eq_norm] at this; exact this
    have hYy : |frameY v α y| ≤ 2 := by
      refine (abs_frameY_le_norm v α y).trans ?_
      rw [← dist_eq_norm]
      have := dist_triangle y y₀ v
      rw [hy1] at this
      linarith [lt_of_lt_of_le hyy₀ (min_le_right _ _)]
    have hs1 : ‖z - v‖ < 1 := by rw [← dist_eq_norm]; exact lt_of_lt_of_le hz (min_le_right _ _)
    have hsm : ‖z - v‖ < -m / 2 := by rw [← dist_eq_norm]; exact lt_of_lt_of_le hz (min_le_left _ _)
    have hprod : |frameY v α z * frameY v α y| ≤ ‖z - v‖ ^ 2 := by
      rw [abs_mul]
      calc |frameY v α z| * |frameY v α y| ≤ (‖z - v‖ ^ 2 / 2) * 2 :=
            mul_le_mul hY hYy (abs_nonneg _) (by positivity)
        _ = ‖z - v‖ ^ 2 := by ring
    have h := shadow_ineq_out (frame_normSq v α z) (by rw [hqy]; exact hyv') (half_norm_le_frameX hs1.le hX hY)
      (abs_le.mp hprod).2 (mul_le_mul_of_nonneg_left hXy.le hX.le) hm (norm_pos_of_frameX_pos hX) hsm
    rw [← sq_dist_frame, hzy] at h; norm_num at h

/-- **Where a shadow near `v` along `e α` comes from** (child of N4-FLANK): for a colour `c` carried at `v` with `e α` in its
allowed cone, a point `z` near `v` close to the axis (`x > 0`, `|y| ≤ ‖z − v‖²/2`) at unit distance from a point of `c`'s class
sees it within `δ` of `N` or of `S′`. Every other contact `w` has `e α` strictly inside its half-plane (`e α·(w − v) ≠ 0` off
`±n`), so its tiles are uniformly nearer (in-type) or farther (out-type) than `1` from such `z` (`shadow_local_contact`); away
from `ω(v)` the triangle inequality; compactness of the class's closure in `B̄(v, 2)` off the two poles' balls does the rest. -/
theorem shadow_source_near_poles (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α : ℝ} {c : Fin k}
    (hc : c ∈ F.coloursAt v) (hcα : e α ∈ F.allowedCone v c) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ > 0, ∀ z, dist z v < ρ → 0 < frameX v α z → |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2 →
      ∀ y ∈ F.region c, dist z y = 1 → dist y (v + e (α + π / 2)) < δ ∨ dist y (v - e (α + π / 2)) < δ := by
  set K := Set.diff (closure (F.region c) ∩ closedBall v 2) (ball (v + e (α + π / 2)) δ ∪ ball (v - e (α + π / 2)) δ)
    with hK
  have hKc : IsCompact K :=
    ((isCompact_closedBall v 2).inter_left isClosed_closure).diff (isOpen_ball.union isOpen_ball)
  have hloc : ∀ y₀ ∈ K, ∀ᶠ q : ℂ × ℂ in 𝓝 (v, y₀), (0 < frameX v α q.1 → |frameY v α q.1| ≤ ‖q.1 - v‖ ^ 2 / 2 →
      q.2 ∈ F.region c → dist q.1 q.2 ≠ 1) := by
    intro y₀ hy₀
    suffices hsuff : ∃ ε₁ > 0, ∃ ε₂ > 0, ∀ z y, dist z v < ε₁ → dist y y₀ < ε₂ → 0 < frameX v α z →
        |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2 → y ∈ F.region c → dist z y ≠ 1 by
      obtain ⟨ε₁, hε₁, ε₂, hε₂, hP⟩ := hsuff
      have hmem : ball v ε₁ ×ˢ ball y₀ ε₂ ∈ 𝓝 (v, y₀) := prod_mem_nhds (ball_mem_nhds _ hε₁) (ball_mem_nhds _ hε₂)
      filter_upwards [hmem] with q hq
      exact hP q.1 q.2 hq.1 hq.2
    by_cases hy1 : dist y₀ v = 1
    · refine shadow_local_contact hF hv hcα ⟨hc, hy1, hy₀.1.1⟩ fun hm => hy₀.2 ?_
      rcases eq_N_or_S_of_frameX_eq_zero hy1 hm with h | h
      · left; rw [mem_ball, h]; exact hδ
      · right; rw [mem_ball, h]; exact hδ
    · -- off the unit circle: the triangle inequality
      have hd : 0 < |dist y₀ v - 1| := abs_pos.mpr (sub_ne_zero.mpr hy1)
      refine ⟨|dist y₀ v - 1| / 2, by positivity, |dist y₀ v - 1| / 2, by positivity, ?_⟩
      intro z y hz hy _ _ _ hzy
      have t1 := dist_triangle z v y
      have t2 := dist_triangle v y₀ y
      have t3 := dist_triangle y₀ y v
      have t4 := dist_triangle y z v
      rw [dist_comm v y₀] at t2
      rw [dist_comm y₀ y] at t2 t3
      rw [dist_comm y z] at t4
      rcases le_or_gt (dist y₀ v) 1 with hle | hgt
      · rw [abs_of_nonpos (by linarith)] at hz hy; linarith
      · rw [abs_of_pos (by linarith)] at hz hy; linarith
  have hev := hKc.eventually_forall_of_forall_eventually (P := fun z y => 0 < frameX v α z →
    |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2 → y ∈ F.region c → dist z y ≠ 1) hloc
  obtain ⟨ρ, hρ, hρP⟩ := Metric.eventually_nhds_iff.mp hev
  refine ⟨min ρ (1 / 2), by positivity, fun z hz hX hY y hy hzy => ?_⟩
  by_contra hcon
  push Not at hcon
  have hyv : dist y v ≤ 2 := by
    have := dist_triangle y z v
    rw [dist_comm y z, hzy] at this
    linarith [lt_of_lt_of_le hz (min_le_right ρ (1 / 2))]
  have hyK : y ∈ K := by
    refine ⟨⟨subset_closure hy, hyv⟩, ?_⟩
    rintro (h | h)
    · exact absurd (mem_ball.mp h) (not_lt.mpr hcon.1)
    · exact absurd (mem_ball.mp h) (not_lt.mpr hcon.2)
  exact hρP (lt_of_lt_of_le hz (min_le_left _ _)) y hyK hX hY hy hzy

/-- **The `g`-shadow of a horn comes from near `S′`** (N4-FLANK's localization, upper flank): with an upper flank `g` and
curvatures in `[−1, 1)`, a point of the horn near `v` at unit distance from a point of `g`'s class sees it within `δ` of `S′`. -/
theorem horn_shadow_near_S (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {g : Fin k}
    (h1 : -1 ≤ κ₁) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ > 0, ∀ z ∈ hornSet v α κ₁ κ₂ ρ, ∀ y ∈ F.region g, dist z y = 1 → dist y (v - e (α + π / 2)) < δ := by
  have hcone := hg.mem_coneAt
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hcone
  have hgα := coneAt_subset_allowedCone hF hv hcone
  obtain ⟨δN, hδN, ρN, hρN, hN⟩ := horn_not_shadowed_near_N hF hv h1 h2 hg
  obtain ⟨ρ₁, hρ₁, hloc⟩ := shadow_source_near_poles hF hv hgv hgα (lt_min hδ hδN)
  refine ⟨min ρ₁ ρN, lt_min hρ₁ hρN, fun z hz y hy hzy => ?_⟩
  rcases hloc z (lt_of_lt_of_le hz.1 (min_le_left _ _)) hz.2.1 (abs_frameY_le_of_mem_hornSet h1 h2.le hz) y hy hzy
    with h | h
  · exact absurd hzy (hN z (hornSet_mono_radius (min_le_right _ _) hz) y hy (lt_of_lt_of_le h (min_le_right _ _)))
  · exact lt_of_lt_of_le h (min_le_left _ _)

/-- **The `h`-shadow of a horn comes from near `N`** (the mirror of `horn_shadow_near_S`, lower flank). -/
theorem horn_shadow_near_N (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {h : Fin k}
    (h1 : -1 < κ₁) (h2 : κ₂ ≤ 1) (hh : F.IsFlankBelow v α κ₁ h) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ > 0, ∀ z ∈ hornSet v α κ₁ κ₂ ρ, ∀ y ∈ F.region h, dist z y = 1 → dist y (v + e (α + π / 2)) < δ := by
  have hcone := hh.mem_coneAt
  have hhv : h ∈ F.coloursAt v := mem_closure_of_mem_coneAt hcone
  have hhα := coneAt_subset_allowedCone hF hv hcone
  obtain ⟨δS, hδS, ρS, hρS, hS⟩ := horn_not_shadowed_near_S hF hv h2 h1 hh
  obtain ⟨ρ₁, hρ₁, hloc⟩ := shadow_source_near_poles hF hv hhv hhα (lt_min hδ hδS)
  refine ⟨min ρ₁ ρS, lt_min hρ₁ hρS, fun z hz y hy hzy => ?_⟩
  rcases hloc z (lt_of_lt_of_le hz.1 (min_le_left _ _)) hz.2.1 (abs_frameY_le_of_mem_hornSet h1.le h2 hz) y hy hzy
    with hy' | hy'
  · exact lt_of_lt_of_le hy' (min_le_left _ _)
  · exact absurd hzy (hS z (hornSet_mono_radius (min_le_right _ _) hz) y hy (lt_of_lt_of_le hy' (min_le_right _ _)))

/-- Flank points arbitrarily near `v`: for `κ < κ'` with the horn between them inside `T` near `v`, there are points of
`hornSet v α κ κ' r` (so of `T`) within any `d > 0` of `v`. -/
theorem exists_mem_hornSet_near {v : ℂ} {α κ κ' : ℝ} (hlt : κ < κ') {T : Set ℂ}
    (hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ κ' r ⊆ T) {d : ℝ} (hd : 0 < d) :
    ∃ p ∈ T, p ∈ hornSet v α κ κ' d := by
  obtain ⟨r₀, hr₀sub, hr₀⟩ := (hev.and self_mem_nhdsWithin).exists
  have hr₀' : (0 : ℝ) < r₀ := hr₀
  obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s ((κ + κ') / 2) (lt_min hr₀' hd)
  have hp := branchPt_mem_hornSet v α (κ₁ := κ) (κ₂ := κ') (by linarith) (by linarith) hs0 hsr hsm
  exact ⟨_, hr₀sub (hornSet_mono_radius (min_le_left _ _) hp), hornSet_mono_radius (min_le_right _ _) hp⟩

/-- **An upper flank's colour shadowing the horn arbitrarily near `v` has an out-type contact at `S′`** (N4-FLANK's
mechanism; the clause N4-STUCK (ii) reads: "doubly shadowed gives … an out-type `g`-tile at `S′`"). The contact is
`horn_shadow_near_S`; in-type is excluded because a `g`-tile at `S′` inside `B(v, 1)` would be near every flank tile, while
flank points lie outside `B̄(S′, 1)` (N-E2). -/
theorem outType_S_of_shadow (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {g : Fin k}
    (h1 : -1 < κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g)
    (hsh : ∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region g)) :
    F.IsContact v g (v - e (α + π / 2)) ∧ F.OutType v g (v - e (α + π / 2)) := by
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hg.mem_coneAt
  have hSv : dist (v - e (α + π / 2)) v = 1 := by rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_e]
  have hSdom : v - e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, hSv])
  have hScl : v - e (α + π / 2) ∈ closure (F.region g) := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨ρ, hρ, hloc⟩ := horn_shadow_near_S hF hv h1.le h2 hg hε
    obtain ⟨z, hz, y, hy, hzy⟩ := hsh ρ hρ
    exact ⟨y, hy, by rw [dist_comm]; exact hloc z hz y hy hzy⟩
  have hcont : F.IsContact v g (v - e (α + π / 2)) := ⟨hgv, hSv, hScl⟩
  refine ⟨hcont, ?_⟩
  rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
  · exfalso
    obtain ⟨T, hT, hST⟩ := (F.mem_coloursAt_iff_exists_tileOf hSdom).mp hScl
    obtain ⟨t, ht⟩ := hT.1.nonempty
    have htv : dist t v < 1 := hin T hT hST ht
    obtain ⟨κ', hκ', hev⟩ := hg
    obtain ⟨p, hpg, hp⟩ := exists_mem_hornSet_near hκ' hev (show 0 < 1 - dist t v by linarith)
    have hpS : 1 < dist p (v - e (α + π / 2)) := by
      rw [← tanAbove_neg_one_iff]
      exact lt_of_lt_of_le hp.2.2.1 (tanHeight_anti (by linarith) _ _)
    have hpt : dist p t < 1 := by
      have := dist_triangle p v t
      rw [dist_comm v t] at this
      linarith [hp.1]
    obtain ⟨hAp, hpA⟩ := tileOf_component hpg
    exact false_of_pole hF hT hAp hST ht hpA hpS hpt
  · exact hout

/-- **A lower flank's colour shadowing the horn arbitrarily near `v` has an out-type contact at `N`** (the mirror of
`outType_S_of_shadow`; N4-STUCK (ii): "doubly shadowed gives an out-type `h`-tile at `N`"). -/
theorem outType_N_of_shadow (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {h : Fin k}
    (h1 : -1 < κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ < 1) (hh : F.IsFlankBelow v α κ₁ h)
    (hsh : ∀ ρ > 0, ∃ z ∈ hornSet v α κ₁ κ₂ ρ, z ∈ shadow (F.region h)) :
    F.IsContact v h (v + e (α + π / 2)) ∧ F.OutType v h (v + e (α + π / 2)) := by
  have hhv : h ∈ F.coloursAt v := mem_closure_of_mem_coneAt hh.mem_coneAt
  have hNv : dist (v + e (α + π / 2)) v = 1 := by rw [dist_eq_norm, add_sub_cancel_left, norm_e]
  have hNdom : v + e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, hNv])
  have hNcl : v + e (α + π / 2) ∈ closure (F.region h) := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨ρ, hρ, hloc⟩ := horn_shadow_near_N hF hv h1 h2.le hh hε
    obtain ⟨z, hz, y, hy, hzy⟩ := hsh ρ hρ
    exact ⟨y, hy, by rw [dist_comm]; exact hloc z hz y hy hzy⟩
  have hcont : F.IsContact v h (v + e (α + π / 2)) := ⟨hhv, hNv, hNcl⟩
  refine ⟨hcont, ?_⟩
  rcases (contact_inType_or_outType hF hv hcont).1 with hin | hout
  · exfalso
    obtain ⟨T, hT, hNT⟩ := (F.mem_coloursAt_iff_exists_tileOf hNdom).mp hNcl
    obtain ⟨t, ht⟩ := hT.1.nonempty
    have htv : dist t v < 1 := hin T hT hNT ht
    obtain ⟨κ', hκ', hev⟩ := hh
    obtain ⟨p, hph, hp⟩ := exists_mem_hornSet_near hκ' hev (show 0 < 1 - dist t v by linarith)
    have hpN : 1 < dist p (v + e (α + π / 2)) := by
      rw [← tanBelow_one_iff]
      have hk1 : κ₁ ≤ 1 := by linarith
      exact lt_of_le_of_lt (tanHeight_anti hk1 _ _) hp.2.2.2
    have hpt : dist p t < 1 := by
      have := dist_triangle p v t
      rw [dist_comm v t] at this
      linarith [hp.1]
    obtain ⟨hAp, hpA⟩ := tileOf_component hph
    exact false_of_pole hF hT hAp hNT ht hpA hpN hpt
  · exact hout

end ArcMap

end HadwigerNelson.Plane
