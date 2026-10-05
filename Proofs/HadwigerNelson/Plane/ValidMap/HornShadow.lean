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
  `mem_shadow_hornSet_add_pi_N` (over `isPreconnected_hornSet_unit` and the far-side shadow `shadow_farSide_above`).
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

/-- **A horn with bounds in `[−1, 1]` is connected** (radius at most `1/2`): it is the sector between two germs of one direction
(`sectorBetween_eq_hornSet`, `BranchGerms.isPreconnected_sector`). -/
theorem isPreconnected_hornSet_unit {v : ℂ} {α κ₁ κ₂ r : ℝ} (h12 : κ₁ < κ₂) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hr : r ≤ 1 / 2) : IsPreconnected (hornSet v α κ₁ κ₂ r) := by
  have hπ := Real.pi_pos
  set G : BranchGerms 2 := ⟨![α, α], ![κ₁, κ₂]⟩ with hG
  have hb1 : |κ₁| ≤ 1 := abs_le.mpr ⟨h1, by linarith⟩
  have hb2 : |κ₂| ≤ 1 := abs_le.mpr ⟨by linarith, h2⟩
  have hsec : G.sector v r 0 = hornSet v α κ₁ κ₂ r := by
    have hb : G.nextβ 0 = α := by simp [BranchGerms.nextβ, hG]
    have hk : G.nextκ 0 = κ₂ := by simp [BranchGerms.nextκ, hG]
    show sectorBetween v (G.β 0) (G.κ 0) (G.nextβ 0) (G.nextκ 0) r = _
    rw [hb, hk]
    have h0 : G.β 0 = α := rfl
    have h1' : G.κ 0 = κ₁ := rfl
    rw [h0, h1']
    rcases le_or_gt r 0 with hr0 | hr0
    · ext z
      simp only [sectorBetween, hornSet, mem_setOf_eq]
      constructor
      · rintro ⟨s, ⟨hs0, hsr⟩, -⟩; linarith
      · rintro ⟨hz, -⟩; linarith [dist_nonneg (x := z) (y := v)]
    · exact sectorBetween_eq_hornSet v α κ₁ κ₂ r (by nlinarith [abs_nonneg κ₁]) (by nlinarith [abs_nonneg κ₂])
  rw [← hsec]
  refine G.isPreconnected_sector (r₀ := 1 / 2) (fun s hs i => ?_) hr 0
  have hs0 := hs.1
  have hs1 := hs.2
  have ha1 : κ₁ * s / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc (r := 1 / 2) (by nlinarith) hs0.le hs1.le
  have ha2 : κ₂ * s / 2 ∈ Icc (-1 : ℝ) 1 := half_curv_mem_Icc (r := 1 / 2) (by nlinarith) hs0.le hs1.le
  fin_cases i
  · show germDir (G.β 0) (G.κ 0) s < germDir (G.nextβ 0) (G.nextκ 0) s
    simp only [germDir, BranchGerms.nextβ, BranchGerms.nextκ, hG]
    norm_num
    exact Real.arcsin_lt_arcsin ha1.1 (by nlinarith) ha2.2
  · show germDir (G.β 1) (G.κ 1) s < germDir (G.nextβ 1) (G.nextκ 1) s
    simp only [germDir, BranchGerms.nextβ, BranchGerms.nextκ, hG]
    norm_num
    have := Real.arcsin_le_pi_div_two (κ₂ * s / 2)
    have := Real.neg_pi_div_two_le_arcsin (κ₁ * s / 2)
    linarith

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
  refine ⟨framePt v α Xw Y', ⟨?_, ?_, ?_, ?_⟩, ?_⟩
  · have h1 := sq_dist_frame v α (framePt v α Xw Y') v
    rw [frameX_self, frameY_self, frameX_framePt, frameY_framePt] at h1
    have hY'2 : Y' ^ 2 ≤ δ ^ 2 := by nlinarith
    have hXw2 : Xw ^ 2 < δ ^ 2 := by linarith [sq_nonneg Yw]
    have : dist (framePt v α Xw Y') v ^ 2 < r ^ 2 := by nlinarith
    exact (pow_lt_pow_iff_left₀ dist_nonneg hr.le two_ne_zero).mp this
  · rw [frameX_framePt]; exact hwX
  · show 0 < tanHeight _ _ _
    rw [frameX_framePt, frameY_framePt]; exact hT1
  · show tanHeight _ _ _ < 0
    rw [frameX_framePt, frameY_framePt]; exact hT2
  · have h1 := sq_dist_frame v α y (framePt v α Xw Y')
    rw [frameX_framePt, frameY_framePt, hXy, hYy] at h1
    have : dist y (framePt v α Xw Y') ^ 2 < 1 := by
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
  have hpre := isPreconnected_hornSet_unit (v := v) (α := α) (r := r) hνν' hν.le hν' hr2
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
  set y' := framePt v α (-frameX v α y) (frameY v α y) with hy'def
  have hfx : frameX v α y' = -frameX v α y := frameX_framePt _ _ _ _
  have hfy : frameY v α y' = frameY v α y := frameY_framePt _ _ _ _
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
  set w' := framePt v α (-frameX v α w) (frameY v α w) with hw'def
  have hgx : frameX v α w' = -frameX v α w := frameX_framePt _ _ _ _
  have hgy : frameY v α w' = frameY v α w := frameY_framePt _ _ _ _
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

/-! ## Spec examples -/

-- SH1's model (E5's `e5-sh` model line, side `−`): `ν = 1/3` gives `f(ν) = 1/4`.
example : curvDown (1 / 3) = 1 / 4 := by norm_num [curvDown]

-- the curvature maps' conjugacy at a value: `−f(−1/2) = f̃(1/2) = 1`.
example : -curvDown (-(1 / 2)) = curvUp (1 / 2) ∧ curvUp (1 / 2) = 1 := by
  constructor
  · exact neg_curvDown_neg _
  · norm_num [curvUp]

end HadwigerNelson.Plane
