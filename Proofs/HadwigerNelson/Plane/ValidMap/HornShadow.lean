import Proofs.HadwigerNelson.Plane.ValidMap.FlankUA

/-!
# The shadow of a horn at its antipode (FS131-E5's lemmas SH and SEP)

FS131-E5's two lemmas (`plans/FS131-E5-derivation.md` §§ 3.1, 3.3; entries `e5-sh`, `e5-sep`), the route E5 derived for
`n3_end_of_not_inType` (NB3-END item 2, at `S′`) and for `cv_class`'s "None" case (FS114-CVB § 1.4 item 5, at `N`, mirrored). Frame at
`v`: `a = e α`, `n = e (α + π/2)`, `N = v + n`, `S′ = v − n`. A horn on side `+` is `hornSet v α ν ν' r`; on side `−` it is
`hornSet v (α + π) κ₃ κ₄ r`, whose `S′`-side bound is `−κ₄` and whose `N`-side bound is `−κ₃`.

* **SH1**, in a global form stronger than E5's (no localization at `S′`, any point above the bounding circle, distance at most `1`):
  `tanAbove_S_of_dist_le_one`, its mirror `tanBelow_N_of_dist_le_one`; the horn forms `shadow_hornSet_subset_S`,
  `shadow_hornSet_add_pi_subset_S`, `shadow_hornSet_subset_N`, `shadow_hornSet_add_pi_subset_N`.
* **SH2**, E5's form, on each side at each pole: `mem_shadow_hornSet_S`, `mem_shadow_hornSet_add_pi_S`, `mem_shadow_hornSet_N`,
  `mem_shadow_hornSet_add_pi_N` (over `Surgery`'s `isPreconnected_hornSet` and the far-side shadow `shadow_farSide_above`).
* **SEP**, as the unit pair it produces: `sep_S`, `sep_add_pi_S`, `sep_N`, `sep_add_pi_N`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The frame turned by `π` -/

/-- Turning the frame by `π` negates the second coordinate. -/
theorem frameY_add_pi (v : ℂ) (α : ℝ) (z : ℂ) : frameY v (α + π) z = -frameY v α z := by
  unfold frameY; rw [e_add_pi', map_neg, mul_neg, neg_im]

/-- Above an arc, in the frame turned by `π`, is below the arc of opposite upward curvature. -/
theorem tanAbove_add_pi_iff (v : ℂ) (α κ : ℝ) (z : ℂ) : TanAbove v (α + π) κ z ↔ TanBelow v α (-κ) z := by
  unfold TanAbove TanBelow tanHeight
  rw [frameX_add_pi, frameY_add_pi, neg_sq, neg_sq]
  constructor <;> intro h <;> linarith

/-- Below an arc, in the frame turned by `π`, is above the arc of opposite upward curvature. -/
theorem tanBelow_add_pi_iff (v : ℂ) (α κ : ℝ) (z : ℂ) : TanBelow v (α + π) κ z ↔ TanAbove v α (-κ) z := by
  unfold TanAbove TanBelow tanHeight
  rw [frameX_add_pi, frameY_add_pi, neg_sq, neg_sq]
  constructor <;> intro h <;> linarith

/-- The two curvature maps are conjugate by `υ ↦ −υ`: `−f(−υ) = f̃(υ)`. -/
theorem neg_curvDown_neg (u : ℝ) : -curvDown (-u) = curvUp u := by
  unfold curvDown curvUp; ring

/-- The frame turned twice by `π` is the frame. -/
theorem e_add_pi_add_pi (α : ℝ) : e (α + π + π) = e α := by
  rw [e_add_pi', e_add_pi', neg_neg]

/-- Distance in frame coordinates: two pairs of points with equal squared coordinate differences are equally far apart. -/
theorem dist_eq_dist_of_frame {v : ℂ} {α : ℝ} {a b c d : ℂ}
    (h : (frameX v α a - frameX v α b) ^ 2 + (frameY v α a - frameY v α b) ^ 2 =
      (frameX v α c - frameX v α d) ^ 2 + (frameY v α c - frameY v α d) ^ 2) : dist a b = dist c d := by
  have h1 := sq_dist_frame v α a b
  have h2 := sq_dist_frame v α c d
  exact (pow_left_inj₀ dist_nonneg dist_nonneg two_ne_zero).mp (by rw [h1, h2, h])

/-! ## SH1 — the shadow lies above the concentric circle -/

/-- **FS131-E5's Lemma SH, first half (`e5-sh`, (SH1)), in a global form** (`plans/FS131-E5-derivation.md` § 3.1): a point within
distance `1` of a point above the circle through `v` tangent to `e α` with upward curvature `ν > −1` lies above the concentric circle
through `S′ = v − n`, of curvature `f(ν) = ν/(1 + ν)` (`curvDown`). **Stronger than E5's (SH1)**, which asks `|y − S′| < 1/2` and a
unit partner in a horn: the circle of curvature `ν` (centre `v + n/ν`, radius `1/|ν|`; the line when `ν = 0`) and the triangle
inequality give it with no localization. -/
theorem tanAbove_S_of_dist_le_one {v : ℂ} {α ν : ℝ} (hν : -1 < ν) {z y : ℂ} (hz : TanAbove v α ν z)
    (hzy : dist y z ≤ 1) : TanAbove (v - e (α + π / 2)) α (curvDown ν) y := by
  unfold TanAbove at hz ⊢
  rw [frameX_base_S, frameY_base_S]
  unfold tanHeight at hz ⊢
  have hd : (frameX v α y - frameX v α z) ^ 2 + (frameY v α y - frameY v α z) ^ 2 ≤ 1 := by
    have h := sq_dist_frame v α y z
    have h1 : dist y z ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := y) (y := z)]
    linarith
  have hyO : ∀ R : ℝ, dist y (v + (R : ℂ) * e (α + π / 2)) ^ 2 = frameX v α y ^ 2 + (frameY v α y - R) ^ 2 := by
    intro R; rw [dist_eq_norm]; exact sq_dist_normalPt v α R y
  have hzO : ∀ R : ℝ, dist z (v + (R : ℂ) * e (α + π / 2)) ^ 2 = frameX v α z ^ 2 + (frameY v α z - R) ^ 2 := by
    intro R; rw [dist_eq_norm]; exact sq_dist_normalPt v α R z
  set p := frameX v α z
  set q := frameY v α z
  set X := frameX v α y
  set Y := frameY v α y
  have h1ν : 0 < 1 + ν := by linarith
  -- the key inequality `ν (X² + Y²)/2 < Y + 1 + ν/2`
  have key : ν * (X ^ 2 + Y ^ 2) / 2 < Y + 1 + ν / 2 := by
    rcases lt_trichotomy ν 0 with hneg | h0 | hpos
    · -- `ν < 0`: `z` lies outside the circle of radius `−1/ν` about `O = v + n/ν`, and `y` within `1` of `z`
      obtain ⟨R, hR⟩ : ∃ R : ℝ, R = 1 / ν := ⟨_, rfl⟩
      have hRν : R * ν = 1 := by rw [hR, one_div, inv_mul_cancel₀ hneg.ne]
      have hR1 : R < -1 := by
        rw [hR, div_lt_iff_of_neg hneg]; linarith
      set O := v + (R : ℂ) * e (α + π / 2)
      have hzO2 : R ^ 2 < dist z O ^ 2 := by
        rw [hzO R]
        have hA : 0 < -(2 * R) * (q - ν * (p ^ 2 + q ^ 2) / 2) := mul_pos (by linarith) hz
        have e1 : p ^ 2 + (q - R) ^ 2 = R ^ 2 - 2 * R * (q - ν * (p ^ 2 + q ^ 2) / 2) := by
          have : R * ν * (p ^ 2 + q ^ 2) = p ^ 2 + q ^ 2 := by rw [hRν, one_mul]
          linear_combination (-1 : ℝ) * this
        rw [e1]; linarith
      have hzO1 : -R < dist z O := by
        by_contra hle; push Not at hle
        have := pow_le_pow_left₀ dist_nonneg hle 2
        nlinarith
      have hyO1 : -R - 1 < dist y O := by
        have := dist_triangle z y O
        rw [dist_comm z y] at this
        linarith
      have hyO2 : (-R - 1) ^ 2 < dist y O ^ 2 := pow_lt_pow_left₀ hyO1 (by linarith) two_ne_zero
      rw [hyO R] at hyO2
      have hYR : Y * R * ν = Y := by rw [mul_assoc, hRν, mul_one]
      nlinarith [hYR, hRν]
    · subst h0
      have hq : 0 < q := by linarith
      nlinarith [sq_nonneg (X - p)]
    · -- `ν > 0`: `z` lies inside the circle of radius `1/ν` about `O = v + n/ν`, and `y` within `1` of `z`
      obtain ⟨R, hR⟩ : ∃ R : ℝ, R = 1 / ν := ⟨_, rfl⟩
      have hRν : R * ν = 1 := by rw [hR, one_div, inv_mul_cancel₀ hpos.ne']
      have hR0 : 0 < R := by rw [hR]; positivity
      set O := v + (R : ℂ) * e (α + π / 2)
      have hzO2 : dist z O ^ 2 < R ^ 2 := by
        rw [hzO R]
        have hA : 0 < 2 * R * (q - ν * (p ^ 2 + q ^ 2) / 2) := mul_pos (by linarith) hz
        have e1 : p ^ 2 + (q - R) ^ 2 = R ^ 2 - 2 * R * (q - ν * (p ^ 2 + q ^ 2) / 2) := by
          have : R * ν * (p ^ 2 + q ^ 2) = p ^ 2 + q ^ 2 := by rw [hRν, one_mul]
          linear_combination (-1 : ℝ) * this
        rw [e1]; linarith
      have hzO1 : dist z O < R := by
        by_contra hle; push Not at hle
        have := pow_le_pow_left₀ hR0.le hle 2
        linarith
      have hyO1 : dist y O < 1 + R := by
        have := dist_triangle y z O
        linarith
      have hyO2 : dist y O ^ 2 < (1 + R) ^ 2 := pow_lt_pow_left₀ hyO1 dist_nonneg two_ne_zero
      rw [hyO R] at hyO2
      have hYR : Y * R * ν = Y := by rw [mul_assoc, hRν, mul_one]
      nlinarith [hYR, hRν]
  unfold curvDown
  have e2 : Y + 1 - ν / (1 + ν) * (X ^ 2 + (Y + 1) ^ 2) / 2 = (Y + 1 + ν / 2 - ν * (X ^ 2 + Y ^ 2) / 2) / (1 + ν) := by
    field_simp; ring
  rw [e2]
  exact div_pos (by linarith) h1ν

/-- **SH1 mirrored at `N`** (E5 § 3.5): a point within distance `1` of a point below the circle through `v` tangent to `e α` with upward
curvature `υ < 1` lies below the concentric circle through `N = v + n`, of curvature `f̃(υ) = υ/(1 − υ)` (`curvUp`). -/
theorem tanBelow_N_of_dist_le_one {v : ℂ} {α υ : ℝ} (hυ : υ < 1) {z y : ℂ} (hz : TanBelow v α υ z)
    (hzy : dist y z ≤ 1) : TanBelow (v + e (α + π / 2)) α (curvUp υ) y := by
  have h := tanAbove_S_of_dist_le_one (α := α + π) (ν := -υ) (by linarith)
    ((tanAbove_add_pi_iff v α (-υ) z).mpr (by rwa [neg_neg])) hzy
  rw [sub_e_add_pi_add, tanAbove_add_pi_iff, neg_curvDown_neg] at h
  exact h

/-- **E5's (SH1)** for a horn on side `+` at `S′`: its shadow lies above the circle of curvature `f(ν)` through `S′` (`ν` its `S′`-side
bound). No other hypothesis: see `tanAbove_S_of_dist_le_one`. -/
theorem shadow_hornSet_subset_S {v : ℂ} {α ν ν' r : ℝ} (hν : -1 < ν) :
    shadow (hornSet v α ν ν' r) ⊆ {y | TanAbove (v - e (α + π / 2)) α (curvDown ν) y} :=
  fun _ ⟨_, hz, hyz⟩ => tanAbove_S_of_dist_le_one hν hz.2.2.1 hyz.le

/-- **E5's (SH1)** for a horn on side `−` at `S′` (its `S′`-side bound is `−κ₄`). -/
theorem shadow_hornSet_add_pi_subset_S {v : ℂ} {α κ₃ κ₄ r : ℝ} (hκ₄ : κ₄ < 1) :
    shadow (hornSet v (α + π) κ₃ κ₄ r) ⊆ {y | TanAbove (v - e (α + π / 2)) α (curvDown (-κ₄)) y} :=
  fun _ ⟨z, hz, hyz⟩ =>
    tanAbove_S_of_dist_le_one (by linarith) ((tanBelow_add_pi_iff v α κ₄ z).mp hz.2.2.2) hyz.le

/-- **E5's (SH1) mirrored** for a horn on side `+` at `N` (its `N`-side bound is `υ`): the shadow lies below the circle of curvature
`f̃(υ)` through `N`. -/
theorem shadow_hornSet_subset_N {v : ℂ} {α υ' υ r : ℝ} (hυ : υ < 1) :
    shadow (hornSet v α υ' υ r) ⊆ {y | TanBelow (v + e (α + π / 2)) α (curvUp υ) y} :=
  fun _ ⟨_, hz, hyz⟩ => tanBelow_N_of_dist_le_one hυ hz.2.2.2 hyz.le

/-- **E5's (SH1) mirrored** for a horn on side `−` at `N` (its `N`-side bound is `−κ₃`). -/
theorem shadow_hornSet_add_pi_subset_N {v : ℂ} {α κ₃ κ₄ r : ℝ} (hκ₃ : -1 < κ₃) :
    shadow (hornSet v (α + π) κ₃ κ₄ r) ⊆ {y | TanBelow (v + e (α + π / 2)) α (curvUp (-κ₃)) y} :=
  fun _ ⟨z, hz, hyz⟩ =>
    tanBelow_N_of_dist_le_one (by linarith) ((tanAbove_add_pi_iff v α κ₃ z).mp hz.2.2.1) hyz.le

/-! ## SH2 — near the pole, the region above the concentric circle is in the shadow -/

/-- **The vertical drop** (E5's (D), in heights): from a point `(X, Y)` above the `ν`-circle near the origin (`X > 0`, `X² + Y² < δ²`,
`0 < δ ≤ 1/4`, `|ν| ≤ 1`) a lower height `Y' ∈ [−δ, Y)` lies strictly between the `ν`-circle and the `ν'`-circle (`ν < ν'`): an
intermediate value of `t ↦ tanHeight ν X (Y − t)`, below `(ν' − ν) X²/2`. -/
theorem exists_drop_height {ν ν' X Y δ : ℝ} (hνabs : |ν| ≤ 1) (hνν' : ν < ν') (hX : 0 < X)
    (hXY : X ^ 2 + Y ^ 2 < δ ^ 2) (hδ : 0 < δ) (hδq : δ ≤ 1 / 4) (hT : 0 < tanHeight ν X Y) :
    ∃ Y', -δ ≤ Y' ∧ Y' < Y ∧ 0 < tanHeight ν X Y' ∧ tanHeight ν' X Y' < 0 := by
  have hY2 : Y ^ 2 < δ ^ 2 := by nlinarith [sq_nonneg X]
  have hX2 : X ^ 2 < δ ^ 2 := by nlinarith [sq_nonneg Y]
  have hYa := abs_lt.mp (abs_lt_of_sq_lt_sq hY2 hδ.le)
  have hν1 := abs_le.mp hνabs
  set f : ℝ → ℝ := fun t => tanHeight ν X (Y - t) with hf
  have hT0 : 0 ≤ Y + δ := by linarith
  have hf0 : f 0 = tanHeight ν X Y := by simp only [hf, sub_zero]
  have hfT : f (Y + δ) < 0 := by
    have e1 : f (Y + δ) = -δ - ν * (X ^ 2 + δ ^ 2) / 2 := by
      simp only [hf, tanHeight]; ring
    rw [e1]
    have h0 : 0 ≤ X ^ 2 + δ ^ 2 := by positivity
    have : -1 * (X ^ 2 + δ ^ 2) ≤ ν * (X ^ 2 + δ ^ 2) := mul_le_mul_of_nonneg_right hν1.1 h0
    nlinarith
  have hdel : 0 < (ν' - ν) * X ^ 2 / 2 := by
    have : 0 < X ^ 2 := by positivity
    have : 0 < (ν' - ν) * X ^ 2 := mul_pos (by linarith) this
    linarith
  set c₁ := min (tanHeight ν X Y) ((ν' - ν) * X ^ 2 / 2) / 2 with hc₁
  have hc₁0 : 0 < c₁ := half_pos (lt_min hT hdel)
  have hc₁f : c₁ < tanHeight ν X Y := by
    have := min_le_left (tanHeight ν X Y) ((ν' - ν) * X ^ 2 / 2); linarith
  have hc₁d : c₁ < (ν' - ν) * X ^ 2 / 2 := by
    have := min_le_right (tanHeight ν X Y) ((ν' - ν) * X ^ 2 / 2); linarith
  have hfc : ContinuousOn f (Icc 0 (Y + δ)) := by
    apply Continuous.continuousOn
    simp only [hf, tanHeight]
    fun_prop
  obtain ⟨t₁, ⟨ht₁0, ht₁T⟩, hft₁⟩ := intermediate_value_Icc' hT0 hfc
    (show c₁ ∈ Icc (f (Y + δ)) (f 0) from ⟨by linarith, by rw [hf0]; exact hc₁f.le⟩)
  have hft : tanHeight ν X (Y - t₁) = c₁ := hft₁
  have ht₁pos : 0 < t₁ := by
    rcases ht₁0.lt_or_eq with h | h
    · exact h
    · rw [← h, sub_zero] at hft; linarith
  refine ⟨Y - t₁, by linarith, by linarith, by rw [hft]; exact hc₁0, ?_⟩
  have e1 : tanHeight ν' X (Y - t₁) = tanHeight ν X (Y - t₁) - (ν' - ν) * (X ^ 2 + (Y - t₁) ^ 2) / 2 := by
    unfold tanHeight; ring
  rw [e1, hft]
  have : 0 ≤ (ν' - ν) * (Y - t₁) ^ 2 := mul_nonneg (by linarith) (sq_nonneg _)
  nlinarith

/-- **The near point of SH2**: a unit partner `w` of `y` (with `|y − S′| < 1/4`) above the `ν`-circle, near `v` on the `+a` side, drops
vertically to a point of the horn `hornSet v α ν ν' r` within distance `1` of `y` (E5's (D), with `exists_drop_height`). -/
theorem exists_near_hornSet_of_partner {v : ℂ} {α ν ν' r δ : ℝ} (hνabs : |ν| ≤ 1) (hνν' : ν < ν') (hr : 0 < r)
    (hδ : 0 < δ) (hδr : δ ≤ r / 2) (hδq : δ ≤ 1 / 4) {w y : ℂ} (hwv : dist w v < δ) (hwX : 0 < frameX v α w)
    (hwT : TanAbove v α ν w) (hyw : dist y w = 1) (hyS : dist y (v - e (α + π / 2)) < 1 / 4) :
    ∃ w' ∈ hornSet v α ν ν' r, dist y w' < 1 := by
  have hw2' := sq_dist_frame v α w v
  have hy2' := sq_dist_S v α y
  have hyw2' := sq_dist_frame v α y w
  rw [frameX_self, frameY_self] at hw2'
  have hwv2 := pow_lt_pow_left₀ hwv dist_nonneg two_ne_zero
  have hyS2 := pow_lt_pow_left₀ hyS dist_nonneg two_ne_zero
  unfold TanAbove at hwT
  obtain ⟨Xw, hXw⟩ : ∃ a, frameX v α w = a := ⟨_, rfl⟩
  obtain ⟨Yw, hYw⟩ : ∃ a, frameY v α w = a := ⟨_, rfl⟩
  obtain ⟨Xy, hXy⟩ : ∃ a, frameX v α y = a := ⟨_, rfl⟩
  obtain ⟨Yy, hYy⟩ : ∃ a, frameY v α y = a := ⟨_, rfl⟩
  rw [hXw, hYw] at hw2' hwT
  rw [hXw] at hwX
  rw [hXy, hYy] at hy2'
  rw [hXw, hYw, hXy, hYy, hyw] at hyw2'
  have hw2 : Xw ^ 2 + Yw ^ 2 < δ ^ 2 := by linarith
  have hYw2 : Yw ^ 2 < δ ^ 2 := by linarith [sq_nonneg Xw]
  have hYwa := abs_lt.mp (abs_lt_of_sq_lt_sq hYw2 hδ.le)
  have hYy' : Yy < -3 / 4 := by
    have h : (Yy + 1) ^ 2 < (1 / 4) ^ 2 := by linarith [sq_nonneg Xy]
    have := abs_lt.mp (abs_lt_of_sq_lt_sq h (by norm_num)); linarith
  obtain ⟨Y', hY'lo, hY'hi, hT1, hT2⟩ := exists_drop_height hνabs hνν' hwX hw2 hδ hδq hwT
  refine ⟨fromFrame v α Xw Y', ⟨?_, ?_, ?_, ?_⟩, ?_⟩
  · have h1 := sq_dist_frame v α (fromFrame v α Xw Y') v
    rw [frameX_self, frameY_self, frameX_fromFrame, frameY_fromFrame] at h1
    have hY'2 : Y' ^ 2 ≤ δ ^ 2 := by nlinarith
    have hXw2 : Xw ^ 2 < δ ^ 2 := by linarith [sq_nonneg Yw]
    have : dist (fromFrame v α Xw Y') v ^ 2 < r ^ 2 := by nlinarith
    exact (pow_lt_pow_iff_left₀ dist_nonneg hr.le two_ne_zero).mp this
  · rw [frameX_fromFrame]; exact hwX
  · show 0 < tanHeight _ _ _
    rw [frameX_fromFrame, frameY_fromFrame]; exact hT1
  · show tanHeight _ _ _ < 0
    rw [frameX_fromFrame, frameY_fromFrame]; exact hT2
  · have h1 := sq_dist_frame v α y (fromFrame v α Xw Y')
    rw [frameX_fromFrame, frameY_fromFrame, hXy, hYy] at h1
    have : dist y (fromFrame v α Xw Y') ^ 2 < 1 := by
      rw [h1]
      have hlo : Yy < Y' := by linarith
      have hp : 0 < (Yw - Y') * (Yw + Y' - 2 * Yy) := mul_pos (by linarith) (by linarith)
      rw [one_pow] at hyw2'
      have e : (Xy - Xw) ^ 2 + (Yy - Y') ^ 2 =
          ((Xy - Xw) ^ 2 + (Yy - Yw) ^ 2) - (Yw - Y') * (Yw + Y' - 2 * Yy) := by ring
      rw [e, ← hyw2']
      linarith
    exact (pow_lt_one_iff_of_nonneg dist_nonneg two_ne_zero).mp this

/-- **FS131-E5's Lemma SH, second half (`e5-sh`, (SH2))**, side `+`, at `S′` (`plans/FS131-E5-derivation.md` § 3.1): for the horn
`H = hornSet v α ν ν' r` with `−1 < ν < ν' ≤ 1`, `0 < r ≤ 1/2`, every point near `S′` on the `+a` side above the circle of curvature
`f(ν)` through `S′` has a unit partner in `H`. Proof: the far-side shadow (`shadow_farSide_above`, wave 4) gives a unit partner above
the `ν`-circle near `v`; the vertical drop to just above that circle (an intermediate value of the height) puts a point of `H` within
`1`; a point of `H` along the middle germ lies beyond `1`; `H` is connected. -/
theorem mem_shadow_hornSet_S {v : ℂ} {α ν ν' r : ℝ} (hν : -1 < ν) (hνν' : ν < ν') (hν' : ν' ≤ 1) (hr : 0 < r)
    (hr2 : r ≤ 1 / 2) :
    ∃ ρ > 0, ∀ y, dist y (v - e (α + π / 2)) < ρ → 0 < frameX v α y →
      TanAbove (v - e (α + π / 2)) α (curvDown ν) y → y ∈ shadow (hornSet v α ν ν' r) := by
  set S := v - e (α + π / 2) with hSdef
  have hSN : S + e (α + π / 2) = v := by rw [hSdef]; ring
  set δ₀ := min (r / 2) (1 / 4) with hδ₀
  have hδ₀pos : 0 < δ₀ := lt_min (by linarith) (by norm_num)
  have hδ₀r : δ₀ ≤ r / 2 := min_le_left _ _
  have hδ₀q : δ₀ ≤ 1 / 4 := min_le_right _ _
  obtain ⟨ε, hε, hfs⟩ := shadow_farSide_above S α hν hδ₀pos
  rw [hSN] at hfs
  -- the far point, on the middle germ
  set m₀ := (ν + ν') / 2 with hm₀def
  set s₀ := r / 2 with hs₀def
  have hs₀ : 0 < s₀ := by positivity
  have hm₀ : |m₀| * s₀ < 2 := by
    have : |m₀| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
    nlinarith [abs_nonneg m₀]
  set z₀ := branchPt v α m₀ s₀ with hz₀def
  have hz₀H : z₀ ∈ hornSet v α ν ν' r :=
    branchPt_mem_hornSet v α (by linarith) (by linarith) hs₀ (by linarith) hm₀
  have hz₀Y : frameY v α z₀ = s₀ ^ 2 * m₀ / 2 := by
    have := tanHeight_branchPt v α m₀ 0 hm₀.le hs₀.le
    unfold tanHeight at this
    linarith
  have hz₀n : frameX v α z₀ ^ 2 + frameY v α z₀ ^ 2 = s₀ ^ 2 := by
    have h1 := sq_dist_frame v α z₀ v
    rw [frameX_self, frameY_self, dist_eq_norm, norm_branchPt_sub v α m₀ hs₀.le] at h1
    linarith
  set D := s₀ ^ 2 * (1 + m₀) with hD
  have hD0 : 0 < D := by rw [hD]; have : 0 < 1 + m₀ := by linarith
                         positivity
  have hD1 : D < 1 := by
    rw [hD]; have : s₀ ^ 2 ≤ 1 / 16 := by nlinarith
    nlinarith
  have hz₀S2 : dist z₀ S ^ 2 = 1 + D := by
    rw [sq_dist_frame v α z₀ S, hSdef, frameX_S, frameY_S]
    nlinarith [hz₀Y, hz₀n]
  have hz₀S : 1 + D / 3 < dist z₀ S := by
    by_contra hle; push Not at hle
    have := pow_le_pow_left₀ dist_nonneg hle 2
    nlinarith
  refine ⟨min (min ε (D / 3)) (1 / 4), lt_min (lt_min hε (by linarith)) (by norm_num), fun y hyS hyX hyT => ?_⟩
  have hyε : dist y S < ε := lt_of_lt_of_le hyS ((min_le_left _ _).trans (min_le_left _ _))
  have hyD : dist y S < D / 3 := lt_of_lt_of_le hyS ((min_le_left _ _).trans (min_le_right _ _))
  have hyq : dist y S < 1 / 4 := lt_of_lt_of_le hyS (min_le_right _ _)
  -- a unit partner above the `ν`-circle near `v`, dropped into the horn
  have hyX' : 0 < frameX S α y := by rw [hSdef, frameX_base_S]; exact hyX
  obtain ⟨w, ⟨hwv, hwX, hwT⟩, hyw⟩ := (hfs y hyε hyX').mpr hyT
  have hνabs : |ν| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
  obtain ⟨w', hw'H, hyw'⟩ := exists_near_hornSet_of_partner (ν' := ν') hνabs hνν' hr hδ₀pos hδ₀r hδ₀q hwv hwX hwT hyw hyq
  have hyz₀ : 1 < dist y z₀ := by
    have := dist_triangle z₀ y S
    rw [dist_comm z₀ y] at this
    linarith
  -- the intermediate value on the connected horn
  have hpre := isPreconnected_hornSet v α (r := r) hνν'
    ((mul_le_of_le_one_left hr.le hνabs).trans_lt (by linarith))
    ((mul_le_of_le_one_left hr.le (abs_le.mpr ⟨by linarith, hν'⟩)).trans_lt (by linarith))
  have hcont : ContinuousOn (fun z => dist y z) (hornSet v α ν ν' r) :=
    (continuous_const.dist continuous_id).continuousOn
  obtain ⟨z, hz, hyz⟩ := hpre.intermediate_value hw'H hz₀H hcont ⟨hyw'.le, hyz₀.le⟩
  exact ⟨z, hz, hyz⟩

/-- **E5's (SH2)**, side `−`, at `S′`: for `H₋ = hornSet v (α + π) κ₃ κ₄ r` with `−1 ≤ κ₃ < κ₄ < 1` (its `S′`-side bound `−κ₄ > −1`),
every point near `S′` on the `−a` side above the circle of curvature `f(−κ₄)` through `S′` has a unit partner in `H₋` (the side-`+`
lemma, read through the reflection in the normal line through `v`). -/
theorem mem_shadow_hornSet_add_pi_S {v : ℂ} {α κ₃ κ₄ r : ℝ} (h3 : -1 ≤ κ₃) (h34 : κ₃ < κ₄) (h4 : κ₄ < 1) (hr : 0 < r)
    (hr2 : r ≤ 1 / 2) :
    ∃ ρ > 0, ∀ y, dist y (v - e (α + π / 2)) < ρ → frameX v α y < 0 →
      TanAbove (v - e (α + π / 2)) α (curvDown (-κ₄)) y → y ∈ shadow (hornSet v (α + π) κ₃ κ₄ r) := by
  obtain ⟨ρ, hρ, H⟩ := mem_shadow_hornSet_S (v := v) (α := α) (ν := -κ₄) (ν' := -κ₃) (by linarith) (by linarith)
    (by linarith) hr hr2
  refine ⟨ρ, hρ, fun y hyS hyX hyT => ?_⟩
  set y' := fromFrame v α (-frameX v α y) (frameY v α y) with hy'def
  have hfx : frameX v α y' = -frameX v α y := frameX_fromFrame _ _ _ _
  have hfy : frameY v α y' = frameY v α y := frameY_fromFrame _ _ _ _
  have hy'S : dist y' (v - e (α + π / 2)) < ρ := by
    have : dist y' (v - e (α + π / 2)) = dist y (v - e (α + π / 2)) := by
      apply dist_eq_dist_of_frame (v := v) (α := α)
      rw [hfx, hfy, frameX_S, frameY_S]; ring
    rw [this]; exact hyS
  have hy'T : TanAbove (v - e (α + π / 2)) α (curvDown (-κ₄)) y' := by
    unfold TanAbove at hyT ⊢
    rw [frameX_base_S, frameY_base_S, hfx, hfy]
    rw [frameX_base_S, frameY_base_S] at hyT
    unfold tanHeight at hyT ⊢
    rw [neg_sq]; exact hyT
  obtain ⟨w, hw, hyw⟩ := H y' hy'S (by rw [hfx]; linarith) hy'T
  set w' := fromFrame v α (-frameX v α w) (frameY v α w) with hw'def
  have hgx : frameX v α w' = -frameX v α w := frameX_fromFrame _ _ _ _
  have hgy : frameY v α w' = frameY v α w := frameY_fromFrame _ _ _ _
  refine ⟨w', ⟨?_, ?_, ?_, ?_⟩, ?_⟩
  · have : dist w' v = dist w v := by
      apply dist_eq_dist_of_frame (v := v) (α := α)
      rw [hgx, hgy, frameX_self, frameY_self]; ring
    rw [this]; exact hw.1
  · rw [frameX_add_pi, hgx, neg_neg]; exact hw.2.1
  · rw [tanAbove_add_pi_iff]
    have h := hw.2.2.2
    unfold TanBelow tanHeight at h ⊢
    rw [hgx, hgy, neg_sq]; exact h
  · rw [tanBelow_add_pi_iff]
    have h := hw.2.2.1
    unfold TanAbove tanHeight at h ⊢
    rw [hgx, hgy, neg_sq]; exact h
  · rw [← hyw]
    apply dist_eq_dist_of_frame (v := v) (α := α)
    rw [hfx, hfy, hgx, hgy]; ring

/-- **E5's (SH2) mirrored**, side `+`, at `N` (E5 § 3.5): for `H = hornSet v α υ' υ r` with `−1 ≤ υ' < υ < 1` (its `N`-side bound `υ`),
every point near `N` on the `+a` side below the circle of curvature `f̃(υ)` through `N` has a unit partner in `H` (side `−` at `S′` in
the frame turned by `π`). -/
theorem mem_shadow_hornSet_N {v : ℂ} {α υ' υ r : ℝ} (h1 : -1 ≤ υ') (h12 : υ' < υ) (h2 : υ < 1) (hr : 0 < r)
    (hr2 : r ≤ 1 / 2) :
    ∃ ρ > 0, ∀ y, dist y (v + e (α + π / 2)) < ρ → 0 < frameX v α y →
      TanBelow (v + e (α + π / 2)) α (curvUp υ) y → y ∈ shadow (hornSet v α υ' υ r) := by
  obtain ⟨ρ, hρ, H⟩ := mem_shadow_hornSet_add_pi_S (v := v) (α := α + π) h1 h12 h2 hr hr2
  rw [sub_e_add_pi_add, hornSet_congr (e_add_pi_add_pi α)] at H
  refine ⟨ρ, hρ, fun y hyS hyX hyT => H y hyS (by rw [frameX_add_pi]; linarith) ?_⟩
  rw [tanAbove_add_pi_iff, neg_curvDown_neg]; exact hyT

/-- **E5's (SH2) mirrored**, side `−`, at `N`: for `H₋ = hornSet v (α + π) κ₃ κ₄ r` with `−1 < κ₃ < κ₄ ≤ 1` (its `N`-side bound `−κ₃`),
every point near `N` on the `−a` side below the circle of curvature `f̃(−κ₃)` through `N` has a unit partner in `H₋` (side `+` at `S′` in
the frame turned by `π`). -/
theorem mem_shadow_hornSet_add_pi_N {v : ℂ} {α κ₃ κ₄ r : ℝ} (h3 : -1 < κ₃) (h34 : κ₃ < κ₄) (h4 : κ₄ ≤ 1) (hr : 0 < r)
    (hr2 : r ≤ 1 / 2) :
    ∃ ρ > 0, ∀ y, dist y (v + e (α + π / 2)) < ρ → frameX v α y < 0 →
      TanBelow (v + e (α + π / 2)) α (curvUp (-κ₃)) y → y ∈ shadow (hornSet v (α + π) κ₃ κ₄ r) := by
  obtain ⟨ρ, hρ, H⟩ := mem_shadow_hornSet_S (v := v) (α := α + π) h3 h34 h4 hr hr2
  rw [sub_e_add_pi_add] at H
  refine ⟨ρ, hρ, fun y hyS hyX hyT => H y hyS (by rw [frameX_add_pi]; linarith) ?_⟩
  rw [tanAbove_add_pi_iff]
  have : -curvDown κ₃ = curvUp (-κ₃) := by rw [← neg_curvDown_neg, neg_neg]
  rw [this]; exact hyT

/-! ## SEP — a sector meeting the shadow pushes every horn of its colour above it into the shadow -/

/-- The order of circles tangent at one point: above the arc of curvature `μ₁` and below that of `μ₂`, off the base point, forces
`μ₁ < μ₂` (E5's SEP-ORDER identity `tanHeight μ₁ − tanHeight μ₂ = (μ₂ − μ₁) ρ²/2`). -/
theorem lt_of_tanAbove_tanBelow {w : ℂ} {α μ₁ μ₂ : ℝ} {y : ℂ} (h1 : TanAbove w α μ₁ y) (h2 : TanBelow w α μ₂ y) :
    μ₁ < μ₂ := by
  unfold TanAbove TanBelow tanHeight at *
  by_contra hle; push Not at hle
  have : 0 ≤ (μ₁ - μ₂) * (frameX w α y ^ 2 + frameY w α y ^ 2) := mul_nonneg (by linarith) (by positivity)
  nlinarith

/-- Above an arc of curvature `μ` is above every arc of curvature at most `μ`. -/
theorem TanAbove.mono {w : ℂ} {α μ μ' : ℝ} {y : ℂ} (h : TanAbove w α μ y) (hμ : μ' ≤ μ) : TanAbove w α μ' y := by
  unfold TanAbove tanHeight at *
  have : 0 ≤ (μ - μ') * (frameX w α y ^ 2 + frameY w α y ^ 2) := mul_nonneg (by linarith) (by positivity)
  nlinarith

/-- Below an arc of curvature `μ` is below every arc of curvature at least `μ`. -/
theorem TanBelow.mono {w : ℂ} {α μ μ' : ℝ} {y : ℂ} (h : TanBelow w α μ y) (hμ : μ ≤ μ') : TanBelow w α μ' y := by
  unfold TanBelow tanHeight at *
  have : 0 ≤ (μ' - μ) * (frameX w α y ^ 2 + frameY w α y ^ 2) := mul_nonneg (by linarith) (by positivity)
  nlinarith

/-- **FS131-E5's Lemma SEP (`e5-sep`)**, side `+`, at `S′` (`plans/FS131-E5-derivation.md` § 3.3), as the unit pair it produces: if a
point of the shadow of the horn `H = hornSet v α ν ν' r` lies below the arc through `S′` tangent to `e α` of upward curvature `μ` (a point
of a sector `G` on the `−n` side of its half-arc `γ` of curvature `μ`), then every set `K` reaching `S′` on the `+a` side above that arc
holds a point at distance `1` from a point of `H`. With `H` and `K` of one colour in a valid map this is SEP's contradiction (E5: "no
`c`-sector at `S′` with cone `{α}` lies on `γ`'s `+n` side"). -/
theorem sep_S {v : ℂ} {α ν ν' r μ : ℝ} (hν : -1 < ν) (hνν' : ν < ν') (hν' : ν' ≤ 1) (hr : 0 < r) (hr2 : r ≤ 1 / 2)
    {y₀ : ℂ} (hy₀ : y₀ ∈ shadow (hornSet v α ν ν' r)) (hy₀μ : TanBelow (v - e (α + π / 2)) α μ y₀) {K : Set ℂ}
    (hK : ∀ ρ > 0, ∃ y ∈ K, dist y (v - e (α + π / 2)) < ρ ∧ 0 < frameX v α y ∧ TanAbove (v - e (α + π / 2)) α μ y) :
    ∃ y ∈ K, ∃ z ∈ hornSet v α ν ν' r, dist y z = 1 := by
  have hμ := lt_of_tanAbove_tanBelow (shadow_hornSet_subset_S hν hy₀) hy₀μ
  obtain ⟨ρ, hρ, H⟩ := mem_shadow_hornSet_S (α := α) (v := v) hν hνν' hν' hr hr2
  obtain ⟨y, hyK, hyS, hyX, hyT⟩ := hK ρ hρ
  obtain ⟨z, hz, hyz⟩ := H y hyS hyX (hyT.mono hμ.le)
  exact ⟨y, hyK, z, hz, hyz⟩

/-- **E5's SEP**, side `−`, at `S′` (the form `n3_end_of_not_inType` reads, E5 § 3.4: `H = H₋`, `ν = −κ₄`, `γ = γ₋`): a shadow point of
`H₋ = hornSet v (α + π) κ₃ κ₄ r` below the arc of curvature `μ` through `S′`, and a set `K` reaching `S′` on the `−a` side above that arc,
give a unit pair between `K` and `H₋`. -/
theorem sep_add_pi_S {v : ℂ} {α κ₃ κ₄ r μ : ℝ} (h3 : -1 ≤ κ₃) (h34 : κ₃ < κ₄) (h4 : κ₄ < 1) (hr : 0 < r) (hr2 : r ≤ 1 / 2)
    {y₀ : ℂ} (hy₀ : y₀ ∈ shadow (hornSet v (α + π) κ₃ κ₄ r)) (hy₀μ : TanBelow (v - e (α + π / 2)) α μ y₀) {K : Set ℂ}
    (hK : ∀ ρ > 0, ∃ y ∈ K, dist y (v - e (α + π / 2)) < ρ ∧ frameX v α y < 0 ∧ TanAbove (v - e (α + π / 2)) α μ y) :
    ∃ y ∈ K, ∃ z ∈ hornSet v (α + π) κ₃ κ₄ r, dist y z = 1 := by
  have hμ := lt_of_tanAbove_tanBelow (shadow_hornSet_add_pi_subset_S h4 hy₀) hy₀μ
  obtain ⟨ρ, hρ, H⟩ := mem_shadow_hornSet_add_pi_S (α := α) (v := v) h3 h34 h4 hr hr2
  obtain ⟨y, hyK, hyS, hyX, hyT⟩ := hK ρ hρ
  obtain ⟨z, hz, hyz⟩ := H y hyS hyX (hyT.mono hμ.le)
  exact ⟨y, hyK, z, hz, hyz⟩

/-- **E5's SEP mirrored**, side `+`, at `N` (E5 § 3.5, CVB § 1.4 item 5 with `Q₊`, `H₊`): a shadow point of `H = hornSet v α υ' υ r`
above the arc of curvature `μ` through `N` (a point of a sector on the `+n` side of its half-arc), and a set `K` reaching `N` on the `+a`
side below that arc, give a unit pair between `K` and `H`. -/
theorem sep_N {v : ℂ} {α υ' υ r μ : ℝ} (h1 : -1 ≤ υ') (h12 : υ' < υ) (h2 : υ < 1) (hr : 0 < r) (hr2 : r ≤ 1 / 2)
    {y₀ : ℂ} (hy₀ : y₀ ∈ shadow (hornSet v α υ' υ r)) (hy₀μ : TanAbove (v + e (α + π / 2)) α μ y₀) {K : Set ℂ}
    (hK : ∀ ρ > 0, ∃ y ∈ K, dist y (v + e (α + π / 2)) < ρ ∧ 0 < frameX v α y ∧ TanBelow (v + e (α + π / 2)) α μ y) :
    ∃ y ∈ K, ∃ z ∈ hornSet v α υ' υ r, dist y z = 1 := by
  have hμ := lt_of_tanAbove_tanBelow hy₀μ (shadow_hornSet_subset_N h2 hy₀)
  obtain ⟨ρ, hρ, H⟩ := mem_shadow_hornSet_N (α := α) (v := v) h1 h12 h2 hr hr2
  obtain ⟨y, hyK, hyS, hyX, hyT⟩ := hK ρ hρ
  obtain ⟨z, hz, hyz⟩ := H y hyS hyX (hyT.mono hμ.le)
  exact ⟨y, hyK, z, hz, hyz⟩

/-- **E5's SEP mirrored**, side `−`, at `N` (CVB § 1.4 item 5 with `Q₋`, `H₋`, `N`-side bound `−κ₃`). -/
theorem sep_add_pi_N {v : ℂ} {α κ₃ κ₄ r μ : ℝ} (h3 : -1 < κ₃) (h34 : κ₃ < κ₄) (h4 : κ₄ ≤ 1) (hr : 0 < r) (hr2 : r ≤ 1 / 2)
    {y₀ : ℂ} (hy₀ : y₀ ∈ shadow (hornSet v (α + π) κ₃ κ₄ r)) (hy₀μ : TanAbove (v + e (α + π / 2)) α μ y₀) {K : Set ℂ}
    (hK : ∀ ρ > 0, ∃ y ∈ K, dist y (v + e (α + π / 2)) < ρ ∧ frameX v α y < 0 ∧ TanBelow (v + e (α + π / 2)) α μ y) :
    ∃ y ∈ K, ∃ z ∈ hornSet v (α + π) κ₃ κ₄ r, dist y z = 1 := by
  have hμ := lt_of_tanAbove_tanBelow hy₀μ (shadow_hornSet_add_pi_subset_N h3 hy₀)
  obtain ⟨ρ, hρ, H⟩ := mem_shadow_hornSet_add_pi_N (α := α) (v := v) h3 h34 h4 hr hr2
  obtain ⟨y, hyK, hyS, hyX, hyT⟩ := hK ρ hρ
  obtain ⟨z, hz, hyz⟩ := H y hyS hyX (hyT.mono hμ.le)
  exact ⟨y, hyK, z, hz, hyz⟩

/-! ## The shadow witnesses at the antipode and the cones there (FS131-I5i, for `n3_end_of_not_inType`, E5 § 3.2) -/

/-- `witness_dir_real`'s first step: the horn point's normal coordinate is small, `|Y| ≤ x²`, and `x < ρ`. -/
theorem witness_dir_aux1 {a Y ρ : ℝ} (ha : 0 < a) (hY : |Y| ≤ (a ^ 2 + Y ^ 2) / 2) (hρ : a ^ 2 + Y ^ 2 < ρ ^ 2)
    (hρ0 : 0 < ρ) (hρ8 : ρ ≤ 1 / 8) : |Y| < 1 / 2 ∧ |Y| ≤ a ^ 2 ∧ a < ρ := by
  have hρ2 : ρ ^ 2 ≤ 1 / 64 := by nlinarith
  have hY0 := abs_nonneg Y
  have hYa : |Y| < 1 / 2 := by nlinarith
  have hY2 : Y ^ 2 = |Y| ^ 2 := (sq_abs Y).symm
  have hYY : |Y| ^ 2 ≤ |Y| / 2 := by nlinarith
  refine ⟨hYa, by nlinarith, ?_⟩
  have : a ^ 2 < ρ ^ 2 := by nlinarith
  nlinarith

/-- `witness_dir_real`'s second step: the identities (E1), (E2) give `σp > −x s²/2`, `q > −2 x s`, `2q < s²`. -/
theorem witness_dir_aux2 {a Y P q s : ℝ} (ha : 0 < a) (hYa : |Y| < 1 / 2) (hYx : |Y| ≤ a ^ 2)
    (hzS : 1 < a ^ 2 + (1 + Y) ^ 2) (hzy : (a - P) ^ 2 + (1 + Y - q) ^ 2 = 1) (hyv : 0 < P ^ 2 + q ^ 2 - 2 * q)
    (hs : s ^ 2 = P ^ 2 + q ^ 2) (hs0 : 0 < s) :
    -(a * s ^ 2) < 2 * P ∧ -(2 * a * s) < q ∧ 2 * q < s ^ 2 := by
  have hY1 : -|Y| ≤ Y := neg_abs_le Y
  have h1Y : 0 < 1 + Y := by linarith
  have hE1 : 2 * (a * P) + 2 * (1 + Y) * q = a ^ 2 + (1 + Y) ^ 2 - 1 + s ^ 2 := by nlinarith
  have hE2 : 2 * q < s ^ 2 := by nlinarith
  have hE3 : (1 + Y) * (2 * q) < (1 + Y) * s ^ 2 := mul_lt_mul_of_pos_left hE2 h1Y
  have hYs : Y * s ^ 2 ≤ a ^ 2 * s ^ 2 := mul_le_mul_of_nonneg_right (le_trans (le_abs_self Y) hYx) (sq_nonneg s)
  have h6 : -(a ^ 2 * s ^ 2) < 2 * (a * P) := by nlinarith
  have hP1 : -(a * s ^ 2) < 2 * P := by
    have : a * (-(a * s ^ 2)) < a * (2 * P) := by nlinarith
    exact lt_of_mul_lt_mul_left this ha.le
  have hPs : P ≤ s := by nlinarith
  have haS : a * P ≤ a * s := mul_le_mul_of_nonneg_left hPs ha.le
  have h7 : -(a * s) < (1 + Y) * q := by nlinarith
  refine ⟨hP1, ?_, hE2⟩
  have has0 : 0 < a * s := mul_pos ha hs0
  rcases le_or_gt 0 q with hq | hq
  · linarith
  · have h12 : (1 : ℝ) / 2 ≤ 1 + Y := by linarith
    have : (1 + Y) * q ≤ (1 / 2) * q := mul_le_mul_of_nonpos_right h12 hq.le
    linarith

/-- `witness_dir_real`'s last step: the sign of `σp`, and the direction's distance from `σ e α`. -/
theorem witness_dir_aux3 {a P q s ρ δ : ℝ} (hs0 : 0 < s) (hs : s ^ 2 = P ^ 2 + q ^ 2) (haρ : a < ρ) (ha : 0 < a)
    (hδ : s < δ) (hρ8 : ρ ≤ 1 / 8) (hδ8 : δ ≤ 1 / 8)
    (hP1 : -(a * s ^ 2) < 2 * P) (hq1 : -(2 * a * s) < q) (hE2 : 2 * q < s ^ 2) :
    0 < P ∧ (P - s) ^ 2 + q ^ 2 < 8 * (ρ + δ) ^ 2 * s ^ 2 := by
  obtain ⟨M, hM⟩ : ∃ M, M = 2 * (ρ + δ) := ⟨_, rfl⟩
  have hM2 : M ≤ 1 / 2 := by rw [hM]; linarith
  have hss : s * s < δ * s := mul_lt_mul_of_pos_right hδ hs0
  have has : a * s < ρ * s := mul_lt_mul_of_pos_right haρ hs0
  have hqu : q < M * s := by nlinarith
  have hql : -(M * s) < q := by nlinarith
  have hq2 : q ^ 2 < M ^ 2 * s ^ 2 := by nlinarith
  have hM0 : 0 ≤ M := by rw [hM]; linarith
  have hM4 : M ^ 2 ≤ 1 / 4 := by nlinarith
  have hMs : M ^ 2 * s ^ 2 ≤ s ^ 2 / 4 := by nlinarith [sq_nonneg s]
  have hPpos : 0 < P := by
    by_contra hle
    push Not at hle
    have has : a * s < 1 / 64 := by nlinarith
    have hnP : -P < a * s ^ 2 / 2 := by linarith
    have hnP0 : 0 ≤ -P := by linarith
    have h8 : P ^ 2 < (a * s ^ 2 / 2) ^ 2 := by nlinarith
    have h8' : (a * s ^ 2 / 2) ^ 2 = (a * s) ^ 2 * s ^ 2 / 4 := by ring
    have h8'' : (a * s) ^ 2 * s ^ 2 / 4 ≤ s ^ 2 / 4 := by
      have : (a * s) ^ 2 ≤ 1 := by nlinarith
      nlinarith [sq_nonneg s]
    nlinarith
  refine ⟨hPpos, ?_⟩
  have h9 : (s - P) * (s + P) = q ^ 2 := by rw [show (s - P) * (s + P) = s ^ 2 - P ^ 2 by ring, hs]; ring
  have h11 : 0 ≤ s - P := (mul_nonneg_iff_of_pos_right (by linarith : 0 < s + P)).mp (h9 ▸ sq_nonneg q)
  have h10 : (s - P) * s ≤ q ^ 2 := h9 ▸ mul_le_mul_of_nonneg_left (by linarith) h11
  have h14 : ((s - P) * s) ^ 2 ≤ (q ^ 2) ^ 2 := pow_le_pow_left₀ (mul_nonneg h11 hs0.le) h10 2
  have h15 : q ^ 2 * q ^ 2 ≤ q ^ 2 * (M ^ 2 * s ^ 2) := mul_le_mul_of_nonneg_left hq2.le (sq_nonneg q)
  have h12 : (s - P) ^ 2 * s ^ 2 ≤ (M ^ 2 * q ^ 2) * s ^ 2 := by
    calc (s - P) ^ 2 * s ^ 2 = ((s - P) * s) ^ 2 := by ring
      _ ≤ (q ^ 2) ^ 2 := h14
      _ = q ^ 2 * q ^ 2 := by ring
      _ ≤ q ^ 2 * (M ^ 2 * s ^ 2) := h15
      _ = (M ^ 2 * q ^ 2) * s ^ 2 := by ring
  have h13 : (s - P) ^ 2 ≤ M ^ 2 * q ^ 2 := le_of_mul_le_mul_right h12 (by positivity)
  have h16 : M ^ 2 * q ^ 2 ≤ q ^ 2 / 4 := by nlinarith [sq_nonneg q]
  have hM8 : 2 * M ^ 2 = 8 * (ρ + δ) ^ 2 := by rw [hM]; ring
  have h17 : (P - s) ^ 2 = (s - P) ^ 2 := by ring
  rw [h17, ← hM8]
  have h18 : 0 ≤ M ^ 2 * s ^ 2 := by positivity
  linarith

/-- **The direction of a shadow witness** (E5 § 3.2 (F4), I5e § 20.2, exact): in the frame at `S′` along `e α`, let `z − v = (x, Y)`
with `σx > 0`, `|Y| ≤ (x² + Y²)/2` (a horn with bounds in `[−1, 1]`), `z` outside `B̄(S′, 1)`, and `y − S′ = (p, q)` at distance `s`
from `S′`, outside `B̄(v, 1)`, with `|z − y| = 1`. Then `σp > 0` and `(σp − s)² + q² < 8 (ρ + δ)² s²` when `x² + Y² < ρ²`,
`s < δ`, `0 < ρ ≤ 1/8`, `δ ≤ 1/8`. -/
theorem witness_dir_real {σ x Y p q s ρ δ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hx : 0 < σ * x)
    (hY : |Y| ≤ (x ^ 2 + Y ^ 2) / 2) (hzS : 1 < x ^ 2 + (1 + Y) ^ 2) (hzy : (x - p) ^ 2 + (1 + Y - q) ^ 2 = 1)
    (hyv : 0 < p ^ 2 + q ^ 2 - 2 * q) (hs : s ^ 2 = p ^ 2 + q ^ 2) (hs0 : 0 < s) (hρ : x ^ 2 + Y ^ 2 < ρ ^ 2)
    (hρ0 : 0 < ρ) (hδ : s < δ) (hρ8 : ρ ≤ 1 / 8) (hδ8 : δ ≤ 1 / 8) :
    0 < σ * p ∧ (σ * p - s) ^ 2 + q ^ 2 < 8 * (ρ + δ) ^ 2 * s ^ 2 := by
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hax : (σ * x) ^ 2 = x ^ 2 := by rw [mul_pow, hσ2, one_mul]
  have hPp : (σ * p) ^ 2 = p ^ 2 := by rw [mul_pow, hσ2, one_mul]
  have hxp : (σ * x - σ * p) ^ 2 = (x - p) ^ 2 := by rw [← mul_sub, mul_pow, hσ2, one_mul]
  rw [← hax] at hY hzS hρ
  rw [← hxp] at hzy
  rw [← hPp] at hyv hs
  obtain ⟨hYa, hYx, haρ⟩ := witness_dir_aux1 hx hY hρ hρ0 hρ8
  obtain ⟨hP1, hq1, hE2⟩ := witness_dir_aux2 hx hYa hYx hzS hzy hyv hs hs0
  exact witness_dir_aux3 hs0 hs haρ hx hδ hρ8 hδ8 hP1 hq1 hE2

/-- The unit direction of `y` from `w`, read in the frame at `w` along `e α`: `‖(y − w)/|y − w| − σ e α‖² · |y − w|² =
(σ X − |y − w|)² + Y²` for `σ = ±1`, `(X, Y)` the frame coordinates of `y`. -/
theorem dirDist_sq_frame {w y : ℂ} {α σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hy : y ≠ w) :
    ‖(y - w) / (‖y - w‖ : ℂ) - (σ : ℂ) * e α‖ ^ 2 * ‖y - w‖ ^ 2 =
      (σ * frameX w α y - ‖y - w‖) ^ 2 + frameY w α y ^ 2 := by
  have hs : 0 < ‖y - w‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hy)
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  set s := ‖y - w‖ with hsdef
  have hsC : (s : ℂ) ≠ 0 := by exact_mod_cast hs.ne'
  have h1 : ‖(y - w) / (s : ℂ) - (σ : ℂ) * e α‖ * s = ‖(y - w) * starRingEnd ℂ (e α) - (σ * s : ℝ)‖ := by
    have : ((y - w) / (s : ℂ) - (σ : ℂ) * e α) * (s : ℂ) * starRingEnd ℂ (e α) =
        (y - w) * starRingEnd ℂ (e α) - ((σ * s : ℝ) : ℂ) := by
      rw [sub_mul, sub_mul, div_mul_cancel₀ _ hsC, mul_assoc, mul_assoc, mul_comm (s : ℂ), ← mul_assoc (e α),
        conj_e_mul_e]
      push_cast; ring
    rw [← this, norm_mul, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hs,
      show ‖starRingEnd ℂ (e α)‖ = 1 by rw [Complex.norm_conj, norm_e], mul_one]
  rw [show ‖(y - w) / (s : ℂ) - (σ : ℂ) * e α‖ ^ 2 * s ^ 2 = (‖(y - w) / (s : ℂ) - (σ : ℂ) * e α‖ * s) ^ 2 by ring, h1,
    Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im, Complex.ofReal_re, Complex.ofReal_im, sub_zero]
  unfold frameX frameY
  have : (σ * ((y - w) * starRingEnd ℂ (e α)).re - s) ^ 2 = (((y - w) * starRingEnd ℂ (e α)).re - σ * s) ^ 2 := by
    linear_combination (((y - w) * starRingEnd ℂ (e α)).re ^ 2 - s ^ 2) * hσ2
  nlinarith [this]

/-- **A shadow witness of a horn points along its axis from the antipode** (E5 § 3.2 (F4), a point form of `witness_dir_real`): `z`
near `v` on the `σ` side of the normal line, within the parabola `|Y| ≤ |z − v|²/2` (a horn with bounds in `[−1, 1]`) and outside
`B̄(S′, 1)`; `y` near `S′`, outside `B̄(v, 1)`, at distance `1` from `z`. Then `y` lies on the `σ` side and its direction from `S′`
is within `3(ρ + δ)` of `σ e α`. -/
theorem witness_dir_pt {v z y : ℂ} {α σ ρ δ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hzx : 0 < σ * frameX v α z)
    (hzY : |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2) (hzS : 1 < dist z (v - e (α + π / 2))) (hzy : dist z y = 1)
    (hyv : 1 < dist y v) (hzv : dist z v < ρ) (hyS : dist y (v - e (α + π / 2)) < δ) (hy0 : y ≠ v - e (α + π / 2))
    (hρ0 : 0 < ρ) (hρ8 : ρ ≤ 1 / 8) (hδ8 : δ ≤ 1 / 8) :
    0 < σ * frameX v α y ∧
      ‖(y - (v - e (α + π / 2))) / (‖y - (v - e (α + π / 2))‖ : ℂ) - (σ : ℂ) * e α‖ < 3 * (ρ + δ) := by
  set S := v - e (α + π / 2) with hSdef
  have hfx : ∀ u, frameX S α u = frameX v α u := frameX_base_S v α
  have hfy : ∀ u, frameY S α u = frameY v α u + 1 := frameY_base_S v α
  have hnz := frame_normSq v α z
  have hzS2 := frame_normSq S α z
  have hyS2 := frame_normSq S α y
  have hzy2 := sq_dist_frame v α z y
  have hyv2 := sq_dist_frame v α y v
  rw [hfx, hfy] at hzS2 hyS2
  rw [frameX_self, frameY_self, sub_zero, sub_zero] at hyv2
  set s := ‖y - S‖ with hsdef
  have hs0 : 0 < s := norm_pos_iff.mpr (sub_ne_zero.mpr hy0)
  have hsδ : s < δ := by rw [hsdef, ← dist_eq_norm]; exact hyS
  have hzS' : 1 < ‖z - S‖ ^ 2 := by rw [← dist_eq_norm]; nlinarith [dist_nonneg (x := z) (y := S)]
  have hyv' : 1 < dist y v ^ 2 := by nlinarith
  have hzv' : ‖z - v‖ ^ 2 < ρ ^ 2 := by
    rw [← dist_eq_norm]; exact pow_lt_pow_left₀ hzv dist_nonneg two_ne_zero
  obtain ⟨h1, h2⟩ := witness_dir_real (σ := σ) (x := frameX v α z) (Y := frameY v α z) (p := frameX v α y)
    (q := frameY v α y + 1) (s := s) (ρ := ρ) (δ := δ) hσ hzx (by rw [hnz]; exact hzY) (by nlinarith [hzS2, hzS'])
    (by have := hzy2; rw [hzy] at this; nlinarith [this]) (by nlinarith) (by rw [hsdef, ← hyS2]) hs0 (by rw [hnz]; exact hzv') hρ0 hsδ hρ8 hδ8
  refine ⟨h1, ?_⟩
  have hd := dirDist_sq_frame (w := S) (y := y) (α := α) hσ hy0
  rw [hfx, hfy] at hd
  have hlt : ‖(y - S) / (s : ℂ) - (σ : ℂ) * e α‖ ^ 2 * s ^ 2 < (3 * (ρ + δ)) ^ 2 * s ^ 2 := by
    have h9 : 0 ≤ (ρ + δ) ^ 2 * s ^ 2 := by positivity
    have h10 : (3 * (ρ + δ)) ^ 2 * s ^ 2 = 9 * ((ρ + δ) ^ 2 * s ^ 2) := by ring
    have h11 : 8 * (ρ + δ) ^ 2 * s ^ 2 = 8 * ((ρ + δ) ^ 2 * s ^ 2) := by ring
    linarith
  have hlt' : ‖(y - S) / (s : ℂ) - (σ : ℂ) * e α‖ ^ 2 < (3 * (ρ + δ)) ^ 2 :=
    lt_of_mul_lt_mul_right hlt (sq_nonneg s)
  have h3 : 0 ≤ 3 * (ρ + δ) := by linarith
  exact (pow_lt_pow_iff_left₀ (norm_nonneg _) h3 two_ne_zero).mp hlt'

/-- The direction `α + π` lies outside `[α + π + φ, α + 2π]` for `0 < φ < π` (U1 on the `−a` horn's arc of `ω(S′)` removes it). -/
theorem angle_pinch_false {α φ b : ℝ} (hφ : 0 < φ) (hφπ : φ < π) (hm : ∃ m : ℤ, b = α + π + 2 * π * m)
    (hb : b ∈ angleIcc (α + π + φ) (α + 2 * π)) : False := by
  obtain ⟨m, rfl⟩ := hm
  obtain ⟨k, hk1, hk2⟩ := mem_iUnion.mp hb
  have h1 : (0 : ℝ) < ((m - k : ℤ) : ℝ) := by
    push_cast
    have : 0 < 2 * π * ((m : ℝ) - k) := by nlinarith
    by_contra h; push Not at h; nlinarith
  have h2 : ((m - k : ℤ) : ℝ) < 1 := by
    push_cast
    by_contra h; push Not at h; nlinarith
  have h1' : 0 < m - k := by exact_mod_cast h1
  have h2' : m - k < 1 := by exact_mod_cast h2
  omega

/-- The cone at `S′` of a set lying, near `S′`, outside `B(v, 1)` is in the lower closed half-turn. -/
theorem coneAt_subset_of_far {v : ℂ} {α : ℝ} {A : Set ℂ}
    (h : ∃ r > 0, ∀ y ∈ A, dist y (v - e (α + π / 2)) < r → 1 ≤ dist y v) :
    coneAt A (v - e (α + π / 2)) ⊆ angleIcc (α + π) (α + 2 * π) := by
  intro β hβ
  obtain ⟨r, hr, hfar⟩ := h
  have hπ := Real.pi_pos
  set S := v - e (α + π / 2) with hSdef
  have hsin : Real.sin (β - α) ≤ 0 := by
    by_contra hpos
    push Not at hpos
    set t := Real.sin (β - α) with ht
    obtain ⟨y, hy, hyS, hyd, hdir⟩ := hβ (min (t / 4) (min r 1)) (lt_min (by linarith) (lt_min hr one_pos))
    have hyd' : dist y S < r := lt_of_lt_of_le hyd ((min_le_right _ _).trans (min_le_left _ _))
    have hyv := hfar y hy hyd'
    have hb := ArcMap.re_mul_conj_e_bound (sub_ne_zero.mpr hyS) (θ := α + π / 2) hdir
    have hre : ((y - S) * starRingEnd ℂ (e (α + π / 2))).re = frameY S α y := by
      unfold frameY
      rw [e_add, show e (π / 2) = I by simp [e, Complex.exp_mul_I]]
      simp [Complex.mul_re, Complex.mul_im]; ring
    rw [hre, show β - (α + π / 2) = (β - α) - π / 2 by ring, Real.cos_sub_pi_div_two] at hb
    set s := ‖y - S‖ with hs
    have hs0 : 0 < s := norm_pos_iff.mpr (sub_ne_zero.mpr hyS)
    have hsd : s < t / 4 := by
      have : dist y S = s := by rw [hs, dist_eq_norm]
      rw [← this]; exact lt_of_lt_of_le hyd (min_le_left _ _)
    -- far from `v`: `frameY S α y ≤ s² / 2`
    have hN := sq_dist_N S α y
    rw [hSdef, sub_add_cancel] at hN
    have hns := frame_normSq S α y
    rw [← hs] at hns
    have hY : frameY S α y ≤ s ^ 2 / 2 := by nlinarith [hyv]
    have hε : min (t / 4) (min r 1) ≤ t / 4 := min_le_left _ _
    have h1 : s * t - s * (t / 4) ≤ frameY S α y := by
      have := (abs_le.mp hb).1
      nlinarith [mul_le_mul_of_nonneg_left hε hs0.le]
    nlinarith
  have hc : 0 ≤ Real.cos (β - (α + 3 * π / 2)) := by
    rw [show β - (α + 3 * π / 2) = (β - α) - π - π / 2 by ring, Real.cos_sub_pi_div_two, Real.sin_sub_pi]
    linarith
  have := ArcMap.mem_angleIcc_of_cos_nonneg_single hc
  rwa [show α + 3 * π / 2 - π / 2 = α + π by ring, show α + 3 * π / 2 + π / 2 = α + 2 * π by ring] at this

/-- **Shadow witnesses of a horn at the antipode, with their direction** (E5 § 3.2 (F3)–(F4)). -/
theorem exists_witness_dir {v : ℂ} {α σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {H : ℝ → Set ℂ} {W : Set ℂ}
    (hH : ∀ ρ, ∀ z ∈ H ρ, dist z v < ρ ∧ 0 < σ * frameX v α z ∧ |frameY v α z| ≤ ‖z - v‖ ^ 2 / 2 ∧
      1 < dist z (v - e (α + π / 2)))
    (hmono : ∀ ρ ρ', ρ ≤ ρ' → H ρ ⊆ H ρ') (hsh : ∀ ρ > 0, ∃ z ∈ H ρ, z ∈ shadow W)
    (hloc : ∀ δ > 0, ∃ ρ > 0, ∀ z ∈ H ρ, ∀ y ∈ W, dist z y = 1 → dist y (v - e (α + π / 2)) < δ)
    (hfar : ∃ r > 0, ∀ y ∈ W, dist y (v - e (α + π / 2)) < r → 1 < dist y v) :
    ∀ ε > 0, ∀ ρ₀ > 0, ∃ y ∈ W, ∃ z ∈ H ρ₀, dist z y = 1 ∧ y ≠ v - e (α + π / 2) ∧
      dist y (v - e (α + π / 2)) < ε ∧ 0 < σ * frameX v α y ∧
      ‖(y - (v - e (α + π / 2))) / (‖y - (v - e (α + π / 2))‖ : ℂ) - (σ : ℂ) * e α‖ < ε := by
  intro ε hε ρ₀ hρ₀
  obtain ⟨r, hr, hfr⟩ := hfar
  set δ := min (min (ε / 6) (1 / 8)) r with hδ
  have hδ0 : 0 < δ := lt_min (lt_min (by linarith) (by norm_num)) hr
  obtain ⟨ρ₁, hρ₁, hl⟩ := hloc δ hδ0
  set ρ := min (min ρ₀ ρ₁) (min (ε / 6) (1 / 8)) with hρ
  have hρ0 : 0 < ρ := lt_min (lt_min hρ₀ hρ₁) (lt_min (by linarith) (by norm_num))
  obtain ⟨z, hz, y, hy, hzy⟩ := hsh ρ hρ0
  obtain ⟨hzv, hzx, hzY, hzS⟩ := hH ρ z hz
  have hyS : dist y (v - e (α + π / 2)) < δ := hl z (hmono ρ ρ₁ ((min_le_left _ _).trans (min_le_right _ _)) hz) y hy hzy
  have hy0 : y ≠ v - e (α + π / 2) := by
    rintro rfl; rw [hzy] at hzS; exact lt_irrefl _ hzS
  have hyv : 1 < dist y v := hfr y hy (lt_of_lt_of_le hyS (min_le_right _ _))
  obtain ⟨h1, h2⟩ := witness_dir_pt hσ hzx hzY hzS hzy hyv hzv hyS hy0 hρ0
    ((min_le_right _ _).trans (min_le_right _ _)) ((min_le_left _ _).trans (min_le_right _ _))
  have hρε : ρ ≤ ε / 6 := (min_le_right _ _).trans (min_le_left _ _)
  have hδε : δ ≤ ε / 6 := (min_le_left _ _).trans (min_le_left _ _)
  refine ⟨y, hy, z, hmono ρ ρ₀ ((min_le_left _ _).trans (min_le_left _ _)) hz, hzy, hy0, by linarith, h1, by linarith⟩

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The upper flank's shadow witnesses on the `+a` horn localize at `S′`** (E5 § 3.2 (F3); I5e § 20.2): at `κ₂ < 1` by
`horn_shadow_near_S`; at `κ₂ = 1` by `shadow_source_near_poles`, given that `N` is not in the flank colour's closure. -/
theorem witness_near_S_upper (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {g : Fin k} (h2 : κ₂ ≤ 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hN : κ₂ = 1 → v + e (α + π / 2) ∉ closure (F.region g)) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ > 0, ∀ z ∈ hornSet v α (-1) κ₂ ρ, ∀ y ∈ F.region g, dist z y = 1 → dist y (v - e (α + π / 2)) < δ := by
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hg.mem_coneAt
  rcases lt_or_eq_of_le h2 with h2' | rfl
  · exact horn_shadow_near_S hF hv le_rfl h2' hg hδ
  · have hNcl := hN rfl
    rw [Metric.mem_closure_iff] at hNcl
    push Not at hNcl
    obtain ⟨δN, hδN, hfN⟩ := hNcl
    obtain ⟨ρ, hρ, hloc⟩ := shadow_source_near_poles hF hv hgv (coneAt_subset_allowedCone hF hv hg.mem_coneAt)
      (lt_min hδ hδN)
    refine ⟨ρ, hρ, fun z hz y hy hzy => ?_⟩
    rcases hloc z hz.1 hz.2.1 (abs_frameY_le_of_mem_hornSet le_rfl le_rfl hz) y hy hzy with hyN | hyS
    · have := hfN y hy
      rw [dist_comm] at this
      linarith [min_le_right δ δN]
    · exact lt_of_lt_of_le hyS (min_le_left _ _)

/-- **The lower flank's shadow witnesses on the `−a` horn localize at `S′`** (its own `N`; E5 § 3.2 (F3)): at `κ₃ > −1` by
`horn_shadow_near_N` turned; at `κ₃ = −1` by `shadow_source_near_poles`, given that `N` is not in the colour's closure. -/
theorem witness_near_S_lower (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₃ κ₄ : ℝ} {g : Fin k} (h3 : -1 ≤ κ₃)
    (h4 : κ₄ ≤ 1) (hg : F.IsFlankBelow v (α + π) κ₃ g) (hN : κ₃ = -1 → v + e (α + π / 2) ∉ closure (F.region g))
    {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ > 0, ∀ z ∈ hornSet v (α + π) κ₃ κ₄ ρ, ∀ y ∈ F.region g, dist z y = 1 → dist y (v - e (α + π / 2)) < δ := by
  have hgv : g ∈ F.coloursAt v := mem_closure_of_mem_coneAt hg.mem_coneAt
  rcases lt_or_eq_of_le h3 with h3' | rfl
  · obtain ⟨ρ, hρ, H⟩ := horn_shadow_near_N hF hv h3' h4 hg hδ
    rw [add_e_add_pi_add] at H
    exact ⟨ρ, hρ, H⟩
  · have hNcl := hN rfl
    rw [Metric.mem_closure_iff] at hNcl
    push Not at hNcl
    obtain ⟨δN, hδN, hfN⟩ := hNcl
    obtain ⟨ρ, hρ, hloc⟩ := shadow_source_near_poles hF hv hgv (coneAt_subset_allowedCone hF hv hg.mem_coneAt)
      (lt_min hδ hδN)
    refine ⟨ρ, hρ, fun z hz y hy hzy => ?_⟩
    rcases hloc z hz.1 hz.2.1 (abs_frameY_le_of_mem_hornSet le_rfl h4 hz) y hy hzy with hyS | hyN
    · rw [add_e_add_pi_add] at hyS
      exact lt_of_lt_of_le hyS (min_le_left _ _)
    · rw [sub_e_add_pi_add] at hyN
      have := hfN y hy
      rw [dist_comm] at this
      linarith [min_le_right δ δN]

/-- **An out-type contact at `P` keeps every point of its colour near `P` outside `B̄(w, 1)`** (E5 § 3.2 (F2), pointwise): near `P` each
such point lies in a sector of the chart at `P`, hence in a tile of that colour whose closure holds `P`. -/
theorem far_of_outType_chart {P w : ℂ} {g : Fin k} (hout : F.OutType w g P) {n : ℕ} {G : BranchGerms n} {r₀ : ℝ}
    (hC : F.IsSectorChart G P r₀) (hn : 0 < n) :
    ∀ y ∈ F.region g, dist y P < r₀ → 1 < dist y w := by
  intro y hy hyP
  have hyc : y ∈ ball P r₀ ∩ F.interiorPts := ⟨hyP, hy.1⟩
  rw [hC.cover r₀ ⟨hC.pos, le_rfl⟩ hn] at hyc
  obtain ⟨i, hi⟩ := mem_iUnion.mp hyc
  obtain ⟨hT, hyT⟩ := tileOf_component hy
  have hsub : G.sector P r₀ i ⊆ connectedComponentIn F.interiorPts y :=
    (hC.isPreconnected r₀ ⟨hC.pos, le_rfl⟩ i).subset_connectedComponentIn hi
      (hC.sector_subset_interiorPts hn ⟨hC.pos, le_rfl⟩ i)
  have hPcl : P ∈ closure (G.sector P r₀ i) := by
    apply mem_closure_of_mem_coneAt (β := G.β i)
    rw [hC.cone r₀ ⟨hC.pos, le_rfl⟩ i]
    exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩
  have hdisj := hout _ hT (closure_mono hsub hPcl)
  have : y ∉ closedBall w 1 := Set.disjoint_left.mp hdisj hyT
  rw [mem_closedBall, not_le] at this
  exact this

/-- **U1 at `S′`, the cone form** (the bound inside `not_antipodal_coneAt_S_of_horn`): a `c`-horn on `ω(S′)` puts `c`'s cone at `S′`
in `[α + π, α + 2π − φ]` for some `φ ∈ (0, π)`. -/
theorem coneAt_S_subset_of_horn (hF : F.Valid) {v : ℂ} {α κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α (-1) κ₂ c)
    (h2 : κ₂ ≤ 1) : ∃ φ, 0 < φ ∧ φ < π ∧ coneAt (F.region c) (v - e (α + π / 2)) ⊆ angleIcc (α + π) (α + 2 * π - φ) := by
  have hπ := Real.pi_pos
  obtain ⟨φ₀, hφ₀, hrad⟩ := horn_radial_S hH h2
  set φ := min φ₀ 1 with hφ
  have hφ0 : 0 < φ := lt_min hφ₀ one_pos
  have hφπ : φ < π := lt_of_le_of_lt (min_le_right _ _) (by linarith [Real.pi_gt_three])
  refine ⟨φ, hφ0, hφπ, fun γ hγ => ?_⟩
  have hI : γ - π ∈ angleIcc (α + π / 2 - π / 2) (α + π / 2 - φ + π / 2) := by
    refine mem_angleIcc_of_cos_nonneg (by linarith) fun θ hθ => ?_
    obtain ⟨η₀, hη₀, hseg⟩ := hrad (α + π / 2 - θ) ⟨by linarith [hθ.2], by linarith [hθ.1, min_le_left φ₀ 1]⟩
    have hseg' : ∀ t ∈ Ioo 1 (1 + η₀), v - e (α + π / 2) + (t : ℂ) * e θ ∈ closure (F.region c) := fun t ht => by
      have := hseg t ht
      rw [show α + π / 2 - (α + π / 2 - θ) = θ by ring] at this
      exact subset_closure this
    have := hF.cos_nonpos_of_radial_outer hη₀ hseg' γ hγ
    rw [show γ - π - θ = (γ - θ) - π by ring, Real.cos_sub_pi]
    linarith
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hI
  exact mem_iUnion.mpr ⟨m, by constructor <;> linarith⟩

/-- **U1 at `N`, the cone form** (the bound inside `not_antipodal_coneAt_N_of_horn`): a `c`-horn on `ω(N)` puts `c`'s cone at `N` in
`[α + φ, α + π]` for some `φ ∈ (0, π)`. -/
theorem coneAt_N_subset_of_horn (hF : F.Valid) {v : ℂ} {α κ₁ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ 1 c)
    (h1 : -1 ≤ κ₁) : ∃ φ, 0 < φ ∧ φ < π ∧ coneAt (F.region c) (v + e (α + π / 2)) ⊆ angleIcc (α + φ) (α + π) := by
  have hπ := Real.pi_pos
  obtain ⟨φ₀, hφ₀, hrad⟩ := horn_radial_N hH h1
  set φ := min φ₀ 1 with hφ
  have hφ0 : 0 < φ := lt_min hφ₀ one_pos
  have hφπ : φ < π := lt_of_le_of_lt (min_le_right _ _) (by linarith [Real.pi_gt_three])
  refine ⟨φ, hφ0, hφπ, fun γ hγ => ?_⟩
  have hI : γ - π ∈ angleIcc (α - π / 2 + φ - π / 2) (α - π / 2 + π / 2) := by
    refine mem_angleIcc_of_cos_nonneg (by linarith) fun θ hθ => ?_
    obtain ⟨η₀, hη₀, hseg⟩ := hrad (θ - (α - π / 2)) ⟨by linarith [hθ.1], by linarith [hθ.2, min_le_left φ₀ 1]⟩
    have hseg' : ∀ t ∈ Ioo 1 (1 + η₀), v + e (α + π / 2) + (t : ℂ) * e θ ∈ closure (F.region c) := fun t ht => by
      have := hseg t ht
      rw [show α - π / 2 + (θ - (α - π / 2)) = θ by ring] at this
      exact subset_closure this
    have := hF.cos_nonpos_of_radial_outer hη₀ hseg' γ hγ
    rw [show γ - π - θ = (γ - θ) - π by ring, Real.cos_sub_pi]
    linarith
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hI
  exact mem_iUnion.mpr ⟨m, by constructor <;> linarith⟩

/-- **An upper flank above `ω(N)` holds radial segments just inside `ω(N)`**: if `g` flanks a horn at `v` whose upper arc is on `ω(N)`,
then for every direction from `N` within a small angle past `α − π/2`, the points of that ray at distance slightly less than `1` from `N`
lie in `g`'s class (the mirror of `horn_radial_N` on the inner side). Model of the hypothesis: `bowtie` at `0`, `α = 0`, upper flank `0`
(`bowtie_flanks`). -/
theorem flank_radial_N {v : ℂ} {α : ℝ} {g : Fin k} (hg : F.IsFlankAbove v α 1 g) :
    ∃ φ₀ > (0 : ℝ), ∀ x ∈ Ioo 0 φ₀, ∃ η₀ > (0 : ℝ), ∀ t ∈ Ioo (1 - η₀) 1,
      v + e (α + π / 2) + (t : ℂ) * e (α - π / 2 + x) ∈ F.region g := by
  have hπ := Real.pi_pos
  obtain ⟨κ', hκ', hev⟩ := hg
  obtain ⟨r₀, hr₀sub, hr₀⟩ := (hev.and self_mem_nhdsWithin).exists
  have hr₀' : (0 : ℝ) < r₀ := hr₀
  set r := min r₀ 1 with hr
  have hr0 : 0 < r := lt_min hr₀' one_pos
  have hr1 : r ≤ 1 := min_le_right _ _
  have hrr : r ≤ r₀ := min_le_left _ _
  refine ⟨r / 2, by positivity, fun x hx => ?_⟩
  have hxpi : x < π := by linarith [hx.2, Real.pi_gt_three]
  have hcos1 : Real.cos x < 1 := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) hxpi.le hx.1
    rwa [Real.cos_zero] at this
  set A := 1 - Real.cos x with hA
  have hA0 : 0 < A := by rw [hA]; linarith
  have hAx : A ≤ x ^ 2 / 2 := by rw [hA]; linarith [Real.one_sub_sq_div_two_le_cos (x := x)]
  have hA2 : A ≤ 2 := by rw [hA]; linarith [Real.neg_one_le_cos x]
  have hsin : 0 < Real.sin x := Real.sin_pos_of_pos_of_lt_pi hx.1 hxpi
  set δ := κ' - 1 with hδ
  have hδ0 : 0 < δ := by rw [hδ]; linarith
  refine ⟨min (r / 2) (min (1 / 2) (δ * A / 4)), lt_min (by positivity) (lt_min (by norm_num) (by positivity)),
    fun t ht => ?_⟩
  set u := 1 - t with hu
  have hu0 : 0 < u := by rw [hu]; linarith [ht.2]
  have hu1 : u < r / 2 := by rw [hu]; linarith [ht.1, min_le_left (r / 2) (min (1 / 2) (δ * A / 4))]
  have hu2 : u < 1 / 2 := by
    rw [hu]; linarith [ht.1, min_le_right (r / 2) (min (1 / 2) (δ * A / 4)), min_le_left (1 / 2 : ℝ) (δ * A / 4)]
  have hu3 : u < δ * A / 4 := by
    rw [hu]; linarith [ht.1, min_le_right (r / 2) (min (1 / 2) (δ * A / 4)), min_le_right (1 / 2 : ℝ) (δ * A / 4)]
  have ht' : t = 1 - u := by rw [hu]; ring
  apply hr₀sub
  rw [normalPt_add_eq_fromFrame]
  have hq : (t * Real.sin x) ^ 2 + (1 - t * Real.cos x) ^ 2 = u ^ 2 + 2 * (1 - u) * A := by
    rw [fromFrame_normSq_aux, ht', hA]; ring
  have hY : 1 - t * Real.cos x = u + A - u * A := by rw [ht', hA]; ring
  refine ⟨?_, ?_, ?_, ?_⟩
  · -- the distance from `v`
    have hn := frame_normSq v α (fromFrame v α (t * Real.sin x) (1 - t * Real.cos x))
    rw [frameX_fromFrame, frameY_fromFrame, hq, ← dist_eq_norm] at hn
    have hlt : u ^ 2 + 2 * (1 - u) * A < r₀ ^ 2 := by
      have hx2 : x < r / 2 := hx.2
      have : x ^ 2 < r ^ 2 / 4 := by nlinarith [mul_lt_mul'' hx2 hx2 hx.1.le hx.1.le]
      have : u ^ 2 < r ^ 2 / 4 := by nlinarith
      have : r ^ 2 ≤ r₀ ^ 2 := by nlinarith
      nlinarith
    nlinarith [dist_nonneg (x := fromFrame v α (t * Real.sin x) (1 - t * Real.cos x)) (y := v)]
  · show 0 < frameX v α _
    rw [frameX_fromFrame]
    have : 0 < t := by rw [ht']; linarith
    positivity
  · show 0 < tanHeight 1 (frameX v α _) (frameY v α _)
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq, hY]
    nlinarith
  · show tanHeight κ' (frameX v α _) (frameY v α _) < 0
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq, hY]
    have hκ'e : κ' = 1 + δ := by rw [hδ]; ring
    rw [hκ'e]
    nlinarith [mul_pos hδ0 hA0, sq_nonneg u, mul_pos hu0 hδ0]


/-- **A lower flank below `ω(S′)` holds radial segments just inside `ω(S′)`** (the mirror of `flank_radial_N`): if `h` flanks a horn at `v`
whose lower arc is on `ω(S′)`, then for every direction from `S′` within a small angle before `α + π/2`, the points of that ray at distance
slightly less than `1` from `S′` lie in `h`'s class. Model of the hypothesis: `bowtie` at `0`, `α = 0`, lower flank `2`
(`bowtie_flanks`). -/
theorem flank_radial_S {v : ℂ} {α : ℝ} {h : Fin k} (hh : F.IsFlankBelow v α (-1) h) :
    ∃ φ₀ > (0 : ℝ), ∀ x ∈ Ioo 0 φ₀, ∃ η₀ > (0 : ℝ), ∀ t ∈ Ioo (1 - η₀) 1,
      v - e (α + π / 2) + (t : ℂ) * e (α + π / 2 - x) ∈ F.region h := by
  have hπ := Real.pi_pos
  obtain ⟨κ', hκ', hev⟩ := hh
  obtain ⟨r₀, hr₀sub, hr₀⟩ := (hev.and self_mem_nhdsWithin).exists
  have hr₀' : (0 : ℝ) < r₀ := hr₀
  set r := min r₀ 1 with hr
  have hr0 : 0 < r := lt_min hr₀' one_pos
  have hr1 : r ≤ 1 := min_le_right _ _
  have hrr : r ≤ r₀ := min_le_left _ _
  refine ⟨r / 2, by positivity, fun x hx => ?_⟩
  have hxpi : x < π := by linarith [hx.2, Real.pi_gt_three]
  have hcos1 : Real.cos x < 1 := by
    have := Real.cos_lt_cos_of_nonneg_of_le_pi (le_refl 0) hxpi.le hx.1
    rwa [Real.cos_zero] at this
  set A := 1 - Real.cos x with hA
  have hA0 : 0 < A := by rw [hA]; linarith
  have hAx : A ≤ x ^ 2 / 2 := by rw [hA]; linarith [Real.one_sub_sq_div_two_le_cos (x := x)]
  have hA2 : A ≤ 2 := by rw [hA]; linarith [Real.neg_one_le_cos x]
  have hsin : 0 < Real.sin x := Real.sin_pos_of_pos_of_lt_pi hx.1 hxpi
  set δ := -1 - κ' with hδ
  have hδ0 : 0 < δ := by rw [hδ]; linarith
  refine ⟨min (r / 2) (min (1 / 2) (δ * A / 4)), lt_min (by positivity) (lt_min (by norm_num) (by positivity)),
    fun t ht => ?_⟩
  set u := 1 - t with hu
  have hu0 : 0 < u := by rw [hu]; linarith [ht.2]
  have hu1 : u < r / 2 := by rw [hu]; linarith [ht.1, min_le_left (r / 2) (min (1 / 2) (δ * A / 4))]
  have hu2 : u < 1 / 2 := by
    rw [hu]; linarith [ht.1, min_le_right (r / 2) (min (1 / 2) (δ * A / 4)), min_le_left (1 / 2 : ℝ) (δ * A / 4)]
  have hu3 : u < δ * A / 4 := by
    rw [hu]; linarith [ht.1, min_le_right (r / 2) (min (1 / 2) (δ * A / 4)), min_le_right (1 / 2 : ℝ) (δ * A / 4)]
  have ht' : t = 1 - u := by rw [hu]; ring
  apply hr₀sub
  rw [S_add_eq_fromFrame]
  have hq : (t * Real.sin x) ^ 2 + (t * Real.cos x - 1) ^ 2 = u ^ 2 + 2 * (1 - u) * A := by
    have := fromFrame_normSq_aux (t := t) (x := x)
    rw [show (t * Real.cos x - 1) ^ 2 = (1 - t * Real.cos x) ^ 2 by ring, this, ht', hA]; ring
  have hY : t * Real.cos x - 1 = -(u + A - u * A) := by rw [ht', hA]; ring
  refine ⟨?_, ?_, ?_, ?_⟩
  · have hn := frame_normSq v α (fromFrame v α (t * Real.sin x) (t * Real.cos x - 1))
    rw [frameX_fromFrame, frameY_fromFrame, hq, ← dist_eq_norm] at hn
    have hlt : u ^ 2 + 2 * (1 - u) * A < r₀ ^ 2 := by
      have hx2 : x < r / 2 := hx.2
      have : x ^ 2 < r ^ 2 / 4 := by nlinarith [mul_lt_mul'' hx2 hx2 hx.1.le hx.1.le]
      have : u ^ 2 < r ^ 2 / 4 := by nlinarith
      have : r ^ 2 ≤ r₀ ^ 2 := by nlinarith
      nlinarith
    nlinarith [dist_nonneg (x := fromFrame v α (t * Real.sin x) (t * Real.cos x - 1)) (y := v)]
  · show 0 < frameX v α _
    rw [frameX_fromFrame]
    have : 0 < t := by rw [ht']; linarith
    positivity
  · show 0 < tanHeight κ' (frameX v α _) (frameY v α _)
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq, hY]
    have hκ'e : κ' = -1 - δ := by rw [hδ]; ring
    rw [hκ'e]
    nlinarith [mul_pos hδ0 hA0, sq_nonneg u, mul_pos hu0 hδ0]
  · show tanHeight (-1) (frameX v α _) (frameY v α _) < 0
    rw [frameX_fromFrame, frameY_fromFrame]
    unfold tanHeight
    rw [hq, hY]
    nlinarith

/-- **U1 for an upper flank at `N`, the cone form** (the inner colour of a unit arc of `ω(N)` faces it): a flank above a horn whose upper
arc is on `ω(N)` puts its colour's cone at `N` in `[α + π + φ, α + 2π]` for some `φ ∈ (0, π)` (`flank_radial_N` with
`Valid.cos_nonneg_of_radial_inner`; FS131-I5n, for CVB § 1.6's branch `G_N`). Model of the hypotheses: `bowtie` at `0` (`bowtie_valid`,
`bowtie_flanks`). -/
theorem coneAt_N_subset_of_flankAbove (hF : F.Valid) {v : ℂ} {α : ℝ} {g : Fin k} (hg : F.IsFlankAbove v α 1 g) :
    ∃ φ, 0 < φ ∧ φ < π ∧ coneAt (F.region g) (v + e (α + π / 2)) ⊆ angleIcc (α + π + φ) (α + 2 * π) := by
  have hπ := Real.pi_pos
  obtain ⟨φ₀, hφ₀, hrad⟩ := flank_radial_N hg
  set φ := min φ₀ 1 with hφ
  have hφ0 : 0 < φ := lt_min hφ₀ one_pos
  have hφπ : φ < π := lt_of_le_of_lt (min_le_right _ _) (by linarith [Real.pi_gt_three])
  refine ⟨φ, hφ0, hφπ, fun γ hγ => ?_⟩
  have hI : γ ∈ angleIcc (α - π / 2 + φ - π / 2) (α - π / 2 + π / 2) := by
    refine mem_angleIcc_of_cos_nonneg (by linarith) fun θ hθ => ?_
    obtain ⟨η₀, hη₀, hseg⟩ := hrad (θ - (α - π / 2)) ⟨by linarith [hθ.1], by linarith [hθ.2, min_le_left φ₀ 1]⟩
    have hseg' : ∀ t ∈ Ioo (1 - η₀) 1, v + e (α + π / 2) + (t : ℂ) * e θ ∈ closure (F.region g) := fun t ht => by
      have := hseg t ht
      rw [show α - π / 2 + (θ - (α - π / 2)) = θ by ring] at this
      exact subset_closure this
    exact hF.cos_nonneg_of_radial_inner hη₀ hseg' γ hγ
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hI
  exact mem_iUnion.mpr ⟨m - 1, by push_cast; constructor <;> linarith⟩

/-- **U1 for a lower flank at `S′`, the cone form** (the mirror of `coneAt_N_subset_of_flankAbove`): a flank below a horn whose lower arc
is on `ω(S′)` puts its colour's cone at `S′` in `[α, α + π − φ]` for some `φ ∈ (0, π)`. Model of the hypotheses: `bowtie` at `0`
(`bowtie_valid`, `bowtie_flanks`). -/
theorem coneAt_S_subset_of_flankBelow (hF : F.Valid) {v : ℂ} {α : ℝ} {h : Fin k} (hh : F.IsFlankBelow v α (-1) h) :
    ∃ φ, 0 < φ ∧ φ < π ∧ coneAt (F.region h) (v - e (α + π / 2)) ⊆ angleIcc α (α + π - φ) := by
  have hπ := Real.pi_pos
  obtain ⟨φ₀, hφ₀, hrad⟩ := flank_radial_S hh
  set φ := min φ₀ 1 with hφ
  have hφ0 : 0 < φ := lt_min hφ₀ one_pos
  have hφπ : φ < π := lt_of_le_of_lt (min_le_right _ _) (by linarith [Real.pi_gt_three])
  refine ⟨φ, hφ0, hφπ, fun γ hγ => ?_⟩
  have hI : γ ∈ angleIcc (α + π / 2 - π / 2) (α + π / 2 - φ + π / 2) := by
    refine mem_angleIcc_of_cos_nonneg (by linarith) fun θ hθ => ?_
    obtain ⟨η₀, hη₀, hseg⟩ := hrad (α + π / 2 - θ) ⟨by linarith [hθ.2], by linarith [hθ.1, min_le_left φ₀ 1]⟩
    have hseg' : ∀ t ∈ Ioo (1 - η₀) 1, v - e (α + π / 2) + (t : ℂ) * e θ ∈ closure (F.region h) := fun t ht => by
      have := hseg t ht
      rw [show α + π / 2 - (α + π / 2 - θ) = θ by ring] at this
      exact subset_closure this
    exact hF.cos_nonneg_of_radial_inner hη₀ hseg' γ hγ
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hI
  exact mem_iUnion.mpr ⟨m, by constructor <;> linarith⟩

end ArcMap

/-! ## Spec examples -/

-- SH1's model (E5's `e5-sh` model line, side `−`): `ν = 1/3` gives `f(ν) = 1/4`.
example : curvDown (1 / 3) = 1 / 4 := by norm_num [curvDown]

-- the curvature maps' conjugacy at a value: `−f(−1/2) = f̃(1/2) = 1`.
example : -curvDown (-(1 / 2)) = curvUp (1 / 2) ∧ curvUp (1 / 2) = 1 := by
  constructor
  · exact neg_curvDown_neg _
  · norm_num [curvUp]

/-! ## N4-SHADOW's two inequalities between stacked vertices (FS131-IS1, for `stuckRun_ne_univ`)

`plans/FS110-N-proof.md` § Continuation — FS110-N4, § 2.6: `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`, each "from validity of the flanks
alone" (`plans/FS110-derivation.md`, FS110-N4-FIN's verdict line) once the colours are placed: SH2 at the pole and `Valid`. -/

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **FS110-N4-SHADOW's inequality going down** (N4 § 2.6, `λ_k ≤ f(λ_{k+1})`, with `w = P_k`, `N = w + n = P_{k+1}`): in a valid map, if
the colour `h` lies directly below the arc of upward curvature `a` at `w` along `e α` (a lower flank) and has a horn along `e α` at `N`
between the curvatures `−1 < a' < b' ≤ 1`, then `a ≤ f(a') = a'/(1 + a')` (`curvDown`). The horn shadows, near `w` on the `+e α` side,
everything above the concentric circle of curvature `f(a')` through `w` (SH2, `mem_shadow_hornSet_S`); a band of the flank above that
circle would hold a point at distance `1` from a point of the horn, both of colour `h`. Stated at any number of colours and with no
terminality: validity alone. No model of the two hypotheses on one valid map is known in Lean (`GENERIC`: a horn stacked over a flank of its
colour is a two-vertex stuck chain, FS-115); the one-sided chain `λ_k = −1/(k + 1)` meets the inequality with equality
(`rayLower_eq_curvDown`, `Plane/StuckChain`). -/
theorem le_curvDown_of_flankBelow_of_horn (hF : F.Valid) {w : ℂ} {α a a' b' : ℝ} {h : Fin k}
    (hh : F.IsFlankBelow w α a h) (H' : F.IsHorn (w + e (α + π / 2)) α a' b' h) (ha' : -1 < a') (hb' : b' ≤ 1) :
    a ≤ curvDown a' := by
  by_contra hlt
  rw [not_le] at hlt
  obtain ⟨κ', hκ', hev⟩ := hh
  -- a radius at which the horn at `N` lies in its colour's class
  obtain ⟨r₁, hr₁, hr₁0, hr₁2⟩ : ∃ r₁, hornSet (w + e (α + π / 2)) α a' b' r₁ ⊆ F.region h ∧ 0 < r₁ ∧ r₁ ≤ 1 / 2 := by
    obtain ⟨r, hr, hr0⟩ :=
      (H'.eventually_subset_region.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num))).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  obtain ⟨ρ, hρ, Hsh⟩ := mem_shadow_hornSet_S (v := w + e (α + π / 2)) (α := α) ha' H'.1 hb' hr₁0 hr₁2
  rw [add_sub_cancel_right] at Hsh
  -- a radius below `ρ` at which the flank's band lies in its colour's class
  obtain ⟨r₂, hr₂, hr₂0, hr₂ρ⟩ : ∃ r₂, hornSet w α κ' a r₂ ⊆ F.region h ∧ 0 < r₂ ∧ r₂ ≤ ρ := by
    obtain ⟨r, hr, hr0⟩ := (hev.and (Ioc_mem_nhdsGT hρ)).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  have hs1 : κ' ≤ max κ' (curvDown a') := le_max_left _ _
  have hs2 : curvDown a' ≤ max κ' (curvDown a') := le_max_right _ _
  have hsa : max κ' (curvDown a') < a := max_lt hκ' hlt
  -- a point of the band between the `f(a')`-circle and the flank's arc
  obtain ⟨y, hy, hyA, -⟩ := exists_mem_hornSet_aboveBelow w α (κ₁ := max κ' (curvDown a')) (κ₂ := a)
    (s := (max κ' (curvDown a') + a) / 2) (m := curvDown a') hr₂0 (by linarith) (by linarith) (by intro h0; linarith)
  have hyT : TanAbove w α (curvDown a') y := hyA (by linarith)
  have hyR : y ∈ F.region h := hr₂ (hornSet_mono hs1 le_rfl hy)
  obtain ⟨z, hz, hyz⟩ := Hsh y (lt_of_lt_of_le hy.1 hr₂ρ) (by rw [frameX_base_N]; exact hy.2.1) hyT
  have hzR : z ∈ F.region h := hr₁ hz
  have hcy : F.col y = h := hyR.2
  have hcz : F.col z = h := hzR.2
  exact hF y hyR.1 z hzR.1 hyz (hcy.trans hcz.symm)

/-- **FS110-N4-SHADOW's inequality going up** (N4 § 2.6, `f̃(υ_{k−1}) ≤ υ_k`, with `w = P_{k−1}`, `N = w + n = P_k`; the mirror of
`le_curvDown_of_flankBelow_of_horn`): in a valid map, if the colour `g` has a horn along `e α` at `w` between the curvatures
`−1 ≤ a < b < 1` and lies directly above the arc of upward curvature `b'` at `N` along `e α` (an upper flank), then
`f̃(b) = b/(1 − b) ≤ b'` (`curvUp`). The horn shadows, near `N` on the `+e α` side, everything below the concentric circle of curvature
`f̃(b)` through `N` (SH2 mirrored, `mem_shadow_hornSet_N`). No model in Lean (`GENERIC`, FS-115), as for the downward form; the one-sided
chain's `υ_k = 0` meets it with equality (`ray_chain`). -/
theorem curvUp_le_of_horn_of_flankAbove (hF : F.Valid) {w : ℂ} {α a b b' : ℝ} {g : Fin k}
    (H : F.IsHorn w α a b g) (hg : F.IsFlankAbove (w + e (α + π / 2)) α b' g) (ha : -1 ≤ a) (hb : b < 1) :
    curvUp b ≤ b' := by
  by_contra hlt
  rw [not_le] at hlt
  obtain ⟨κ', hκ', hev⟩ := hg
  -- a radius at which the horn at `w` lies in its colour's class
  obtain ⟨r₁, hr₁, hr₁0, hr₁2⟩ : ∃ r₁, hornSet w α a b r₁ ⊆ F.region g ∧ 0 < r₁ ∧ r₁ ≤ 1 / 2 := by
    obtain ⟨r, hr, hr0⟩ :=
      (H.eventually_subset_region.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 2 by norm_num))).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  obtain ⟨ρ, hρ, Hsh⟩ := mem_shadow_hornSet_N (v := w) (α := α) ha H.1 hb hr₁0 hr₁2
  -- a radius below `ρ` at which the flank's band lies in its colour's class
  obtain ⟨r₂, hr₂, hr₂0, hr₂ρ⟩ :
      ∃ r₂, hornSet (w + e (α + π / 2)) α b' κ' r₂ ⊆ F.region g ∧ 0 < r₂ ∧ r₂ ≤ ρ := by
    obtain ⟨r, hr, hr0⟩ := (hev.and (Ioc_mem_nhdsGT hρ)).exists
    exact ⟨r, hr, hr0.1, hr0.2⟩
  have hs1 : min κ' (curvUp b) ≤ κ' := min_le_left _ _
  have hs2 : min κ' (curvUp b) ≤ curvUp b := min_le_right _ _
  have hsb : b' < min κ' (curvUp b) := lt_min hκ' hlt
  -- a point of the band between the flank's arc and the `f̃(b)`-circle
  obtain ⟨y, hy, -, hyB⟩ := exists_mem_hornSet_aboveBelow (w + e (α + π / 2)) α (κ₁ := b') (κ₂ := min κ' (curvUp b))
    (s := (b' + min κ' (curvUp b)) / 2) (m := curvUp b) hr₂0 (by linarith) (by linarith) (by intro h0; linarith)
  have hyT : TanBelow (w + e (α + π / 2)) α (curvUp b) y := hyB (by linarith)
  have hyR : y ∈ F.region g := hr₂ (hornSet_mono le_rfl hs1 hy)
  obtain ⟨z, hz, hyz⟩ := Hsh y (lt_of_lt_of_le hy.1 hr₂ρ) (by rw [← frameX_base_N]; exact hy.2.1) hyT
  have hzR : z ∈ F.region g := hr₁ hz
  have hcy : F.col y = g := hyR.2
  have hcz : F.col z = g := hzR.2
  exact hF y hyR.1 z hzR.1 hyz (hcy.trans hcz.symm)

end ArcMap

end HadwigerNelson.Plane
