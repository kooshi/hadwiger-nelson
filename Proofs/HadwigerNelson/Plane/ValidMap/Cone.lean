import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.SVMap

/-!
# The allowed cone (FS110-N3-CONF), the horn algebra and the horn charts, upstream of `Contact` and `Moves`

Moved verbatim from `Plane/ValidMap/Contact` in two moves, so that the moves (`Plane/ValidMap/Moves`) can read them.
The first (inventory items 253–254, FS131-IM1): `Contact`'s head — FS110-N3-CONF (`contact_inType_or_outType`,
`coneAt_subset_allowedCone`, `clear_of_subset_interior_allowedCone`, `lens_dist_lt_one_of_up`, `lune_dist_le_of_up`, with the
ray-point, shadow and dot helpers they use) and the branch-point and horn algebra (`hornSet_congr` … `mem_coneAt_hornSet`) —
and three single lemmas (`hornSet_mono_radius`, `not_mem_interiorPts_of_mem_closure_sector`, `IsSector.eq_of_mem`). The second
(item 263, FS131-IM2): the prefix of `Contact` that followed, from `e_eq_of_mem_coneAt_hornSet` through
`IsSectorChart.index_of_isSector_hornSet` — FS110-N3-DEG (`woodallCone`, `woodallCone_strict`), N4-FLANK's mechanism, and a horn's
chart sector and its flanks (`IsHorn.exists_chart_index`, `IsSectorChart.exists_col`, `IsSectorChart.exists_flank_after`/`_before`,
`IsHorn.exists_flankAbove`/`_Below`).
`tools/fs131_im_move_cone.py --check` holds the text byte-identical to its source lines in `Contact` at `d4f946ae`.

**The model of the contact lemmas** (those assuming only `F.Valid`, `F.Covers v 1`, a contact and its cone): `sevenBrickMap`
(`Plane/SVMap`) — valid (`sevenBrickMap_valid`), covering every disc (`covers_of_isPlaneMap` at `sevenBrickMap_isPlaneMap`); a
contact there, at [hand]: a corner and the corner at distance `1` from it (FS131-QA4 § 4.1; inventory ruling 427 (d), F2). The
lemmas about a cone with empty interior, a horn or a stuck vertex are not covered by this line: no Lean object satisfies their
hypotheses with `Covers` (FS131-QA4 § 3.5).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `frameX` is real-linear along a displacement. -/
theorem frameX_add_smul (v : ℂ) (α s : ℝ) (z u : ℂ) :
    frameX v α (z + (s : ℂ) * u) = frameX v α z + s * ((u * starRingEnd ℂ (e α)).re) := by
  unfold frameX
  have : (z + (s : ℂ) * u - v) * starRingEnd ℂ (e α) = (z - v) * starRingEnd ℂ (e α) + (s : ℂ) * (u * starRingEnd ℂ (e α)) := by ring
  rw [this, Complex.add_re, Complex.re_ofReal_mul]

/-- The ray point of `z` toward (`s = 1`) or away from (`s = −1`) `C`, at unit distance. -/
noncomputable def rayPt (C z : ℂ) (s : ℝ) : ℂ := z + ((s / ‖C - z‖ : ℝ) : ℂ) * (C - z)

/-- The ray point is continuous at `v` when `C ≠ v`. -/
theorem rayPt_continuousAt {C v : ℂ} (hne : C ≠ v) (s : ℝ) : ContinuousAt (fun z => rayPt C z s) v := by
  unfold rayPt
  have hn : ‖C - v‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr hne)
  fun_prop (disch := exact hn)

/-- The ray point is at distance `1` from `z`. -/
theorem dist_rayPt (C z : ℂ) (hz : z ≠ C) (s : ℝ) (hs : |s| = 1) : dist z (rayPt C z s) = 1 := by
  unfold rayPt
  have hr : 0 < ‖C - z‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hz.symm)
  rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_div, hs,
    abs_of_pos hr]
  field_simp

/-- The ray point is at distance `|s − ‖C − z‖|` from the centre. -/
theorem dist_rayPt_center (C z : ℂ) (hz : z ≠ C) (s : ℝ) :
    dist (rayPt C z s) C = |s - ‖C - z‖| := by
  unfold rayPt
  have hr : 0 < ‖C - z‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hz.symm)
  have : z + ((s / ‖C - z‖ : ℝ) : ℂ) * (C - z) - C = (((s / ‖C - z‖ - 1 : ℝ)) : ℂ) * (C - z) := by
    push_cast; ring
  rw [dist_eq_norm, this, norm_mul, Complex.norm_real, Real.norm_eq_abs]
  have : |s / ‖C - z‖ - 1| * ‖C - z‖ = |s - ‖C - z‖| := by
    rw [← abs_of_pos hr, ← abs_mul, abs_of_pos hr]
    congr 1; field_simp
  exact this

/-- The `x` coordinate of the ray point: `x_z + (s/r)(x_C − x_z)`. -/
theorem frameX_rayPt (v : ℂ) (α : ℝ) (C z : ℂ) (s : ℝ) :
    frameX v α (rayPt C z s) = frameX v α z + (s / ‖C - z‖) * (frameX v α C - frameX v α z) := by
  unfold rayPt
  rw [frameX_add_smul, frameX_sub]

/-- `‖C − z‖ = dist z C`. -/
theorem norm_C_sub_z (C z : ℂ) : ‖C - z‖ = dist z C := by rw [dist_comm, dist_eq_norm]

/-- **The shadow of a set inside a disc, from below** (`N4-SHADOW`'s engine, inside case): if `T` lies in `B(C, ρ)` near
`P = v + (C − v)/‖C − v‖`, with `‖C − v‖ = ρ + 1`, the points `z` near `v` (`x_z > 0`) in its shadow are exactly those in
`B(C, ρ + 1)`. -/
theorem shadow_inside {v C P : ℂ} {α ρ δ : ℝ} (hρ : 0 < ρ) (hC : ‖C - v‖ = ρ + 1) (hP : rayPt C v 1 = P)
    (hxP : ∀ y, frameX P α y = frameX v α y) (hxC : frameX v α C = 0) (hδ : 0 < δ) :
    ∃ ε > 0, ∀ z, dist z v < ε → 0 < frameX v α z →
      (z ∈ shadow {y | dist y P < δ ∧ 0 < frameX P α y ∧ dist y C < ρ} ↔ dist z C < ρ + 1) := by
  have hne : C ≠ v := fun h => by rw [h, sub_self, norm_zero] at hC; linarith
  obtain ⟨ε₁, hε₁, hcont⟩ := Metric.continuousAt_iff.mp (rayPt_continuousAt hne 1) δ hδ
  refine ⟨min ε₁ ρ, lt_min hε₁ hρ, fun z hz hx => ?_⟩
  have hz1 : dist z v < ε₁ := lt_of_lt_of_le hz (min_le_left _ _)
  have hz2 : dist z v < ρ := lt_of_lt_of_le hz (min_le_right _ _)
  constructor
  · rintro ⟨y, ⟨-, -, hyC⟩, hzy⟩
    calc dist z C ≤ dist z y + dist y C := dist_triangle _ _ _
      _ < 1 + ρ := by rw [hzy]; linarith
      _ = ρ + 1 := by ring
  · intro hzC
    have hr1 : 1 < ‖C - z‖ := by
      have : ‖C - v‖ - ‖z - v‖ ≤ ‖C - z‖ := by
        have := norm_sub_norm_le (C - v) (z - v)
        have e : C - v - (z - v) = C - z := by ring
        rw [e] at this
        linarith [norm_sub_norm_le (C - v) (z - v), norm_sub_rev (C - v) (z - v)]
      rw [dist_eq_norm] at hz2
      linarith
    have hzne : z ≠ C := fun h => by rw [h, sub_self, norm_zero] at hr1; linarith
    have hrpos : 0 < ‖C - z‖ := by linarith
    refine ⟨rayPt C z 1, ⟨?_, ?_, ?_⟩, dist_rayPt C z hzne 1 (by simp)⟩
    · have := hcont hz1
      rwa [hP] at this
    · rw [hxP, frameX_rayPt, hxC]
      have : 0 < (1 / ‖C - z‖) := by positivity
      have h1 : 1 / ‖C - z‖ < 1 := by rw [div_lt_one hrpos]; exact hr1
      nlinarith
    · rw [dist_rayPt_center C z hzne]
      rw [norm_C_sub_z] at hr1 ⊢
      rw [abs_of_nonpos (by linarith)]
      linarith

/-- **The shadow of a set outside a disc** (`N4-SHADOW`'s engine, outside case): if `T` lies outside `B̄(C, ρ)` near
`P = v − (C − v)/‖C − v‖`, with `‖C − v‖ = ρ − 1` and `ρ > 1`, the points `z` near `v` (`x_z > 0`) in its shadow are exactly
those outside `B̄(C, ρ − 1)`. -/
theorem shadow_outside {v C P : ℂ} {α ρ δ : ℝ} (hρ : 1 < ρ) (hC : ‖C - v‖ = ρ - 1) (hP : rayPt C v (-1) = P)
    (hxP : ∀ y, frameX P α y = frameX v α y) (hxC : frameX v α C = 0) (hδ : 0 < δ) :
    ∃ ε > 0, ∀ z, dist z v < ε → 0 < frameX v α z →
      (z ∈ shadow {y | dist y P < δ ∧ 0 < frameX P α y ∧ ρ < dist y C} ↔ ρ - 1 < dist z C) := by
  have hne : C ≠ v := fun h => by rw [h, sub_self, norm_zero] at hC; linarith
  obtain ⟨ε₁, hε₁, hcont⟩ := Metric.continuousAt_iff.mp (rayPt_continuousAt hne (-1)) δ hδ
  refine ⟨ε₁, hε₁, fun z hz hx => ?_⟩
  constructor
  · rintro ⟨y, ⟨-, -, hyC⟩, hzy⟩
    have : dist y C ≤ dist y z + dist z C := dist_triangle _ _ _
    rw [dist_comm y z, hzy] at this
    linarith
  · intro hzC
    have hrpos : 0 < ‖C - z‖ := by rw [norm_C_sub_z]; linarith
    have hzne : z ≠ C := fun h => by rw [h, sub_self, norm_zero] at hrpos; linarith
    refine ⟨rayPt C z (-1), ⟨?_, ?_, ?_⟩, dist_rayPt C z hzne (-1) (by simp)⟩
    · have := hcont hz
      rwa [hP] at this
    · rw [hxP, frameX_rayPt, hxC]
      have : 0 < (1 / ‖C - z‖) := by positivity
      have e : -1 / ‖C - z‖ * (0 - frameX v α z) = frameX v α z * (1 / ‖C - z‖) := by ring
      rw [e]
      nlinarith
    · rw [dist_rayPt_center C z hzne]
      rw [norm_C_sub_z] at hrpos ⊢
      rw [abs_of_nonpos (by linarith)]
      linarith

/-- The far side, near `N`, of an arc tangent to `e α` at `N` with upward curvature `μ`, on the `+a` side: the points of
`B(N, δ)` with positive `a`-coordinate above the arc. -/
def farSideAbove (N : ℂ) (α μ δ : ℝ) : Set ℂ := {z | dist z N < δ ∧ 0 < frameX N α z ∧ TanAbove N α μ z}

/-- The mirror: the points of `B(S, δ)` with positive `a`-coordinate below the arc of upward curvature `υ` tangent at `S`. -/
def farSideBelow (S : ℂ) (α υ δ : ℝ) : Set ℂ := {z | dist z S < δ ∧ 0 < frameX S α z ∧ TanBelow S α υ z}

/-- **FS110-N4-SHADOW**, going down: the far side of an arc of upward curvature `μ > −1` tangent to `a` at `N = v + n`
shadows a point `z` near `v` with `(z − v)·a > 0` exactly when `z` lies above the circle through `v` concentric with the arc,
of curvature `f(μ) = μ/(1 + μ)`. -/
theorem shadow_farSide_above (v : ℂ) (α : ℝ) {μ δ : ℝ} (hμ : -1 < μ) (hδ : 0 < δ) :
    ∃ ε > 0, ∀ z, dist z v < ε → 0 < frameX v α z →
      (z ∈ shadow (farSideAbove (v + e (α + π / 2)) α μ δ) ↔ TanAbove v α (curvDown μ) z) := by
  have h1 : 1 + μ ≠ 0 := by linarith
  rcases lt_trichotomy μ 0 with hneg | rfl | hpos
  · -- `μ < 0`: the far side lies outside the circle `Σ`; its shadow is the outside of the concentric circle
    have hf : curvDown μ < 0 := by unfold curvDown; exact div_neg_of_neg_of_pos hneg (by linarith)
    have hf' : 1 / curvDown μ = 1 + 1 / μ := inv_curvDown_eq hneg.ne h1
    have hμ1 : 1 / μ < -1 := by rw [div_lt_iff_of_neg hneg]; linarith
    set C : ℂ := v + ((1 / curvDown μ : ℝ) : ℂ) * e (α + π / 2) with hCdef
    have hCn : ‖C - v‖ = -(1 / μ) - 1 := by
      rw [hCdef, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, hf',
        abs_of_neg (by linarith)]
      ring
    have hP : rayPt C v (-1) = v + e (α + π / 2) := by
      have hCv : C - v = ((1 / curvDown μ : ℝ) : ℂ) * e (α + π / 2) := by rw [hCdef]; ring
      unfold rayPt
      rw [hCn, hCv]
      have : ((-1 / (-(1 / μ) - 1) : ℝ) : ℂ) * ((1 / curvDown μ : ℝ) : ℂ) = 1 := by
        rw [← Complex.ofReal_mul, hf']
        have : (-(1 / μ) - 1) ≠ 0 := by linarith
        have h2 : 1 + 1 / μ ≠ 0 := by linarith
        rw [Complex.ofReal_eq_one]; field_simp; ring
      calc v + ((-1 / (-(1 / μ) - 1) : ℝ) : ℂ) * (((1 / curvDown μ : ℝ) : ℂ) * e (α + π / 2))
          = v + (((-1 / (-(1 / μ) - 1) : ℝ) : ℂ) * ((1 / curvDown μ : ℝ) : ℂ)) * e (α + π / 2) := by ring
        _ = _ := by rw [this, one_mul]
    have hCeq : v + e (α + π / 2) + ((1 / μ : ℝ) : ℂ) * e (α + π / 2) = C := by
      rw [hCdef, hf']; push_cast; ring
    have hT : farSideAbove (v + e (α + π / 2)) α μ δ =
        {y | dist y (v + e (α + π / 2)) < δ ∧ 0 < frameX (v + e (α + π / 2)) α y ∧ -(1 / μ) < dist y C} := by
      ext y
      simp only [farSideAbove, mem_setOf_eq]
      rw [tanAbove_iff_of_neg (v + e (α + π / 2)) α hneg y, hCeq]
    obtain ⟨ε, hε, H⟩ := shadow_outside (v := v) (C := C) (P := v + e (α + π / 2)) (α := α) (ρ := -(1 / μ)) (δ := δ)
      (by linarith) hCn hP (frameX_base_N v α) (frameX_normalPt v α _) hδ
    refine ⟨ε, hε, fun z hz hx => ?_⟩
    rw [hT, H z hz hx, tanAbove_iff_of_neg v α hf z, ← hCdef, hf']
    have : -(1 + 1 / μ) = -(1 / μ) - 1 := by ring
    rw [this]
  · -- `μ = 0`: the far side is the half-plane above the line through `N`
    refine ⟨δ, hδ, fun z hz hx => ?_⟩
    have hf0 : curvDown 0 = 0 := by simp [curvDown]
    rw [hf0]
    have hTA : ∀ y, TanAbove (v + e (α + π / 2)) α 0 y ↔ 1 < frameY v α y := by
      intro y; unfold TanAbove tanHeight; rw [frameY_base_N]; constructor <;> intro h <;> nlinarith
    have hTA0 : TanAbove v α 0 z ↔ 0 < frameY v α z := by unfold TanAbove tanHeight; constructor <;> intro h <;> nlinarith
    rw [hTA0]
    constructor
    · rintro ⟨y, ⟨-, -, hy⟩, hzy⟩
      rw [hTA] at hy
      have hsq := sq_dist_frame v α z y
      rw [hzy] at hsq
      nlinarith [sq_nonneg (frameX v α z - frameX v α y), sq_nonneg (frameY v α z - frameY v α y + 1)]
    · intro hy
      refine ⟨z + ((1 : ℝ) : ℂ) * e (α + π / 2), ⟨?_, ?_, ?_⟩, ?_⟩
      · have : z + ((1 : ℝ) : ℂ) * e (α + π / 2) - (v + e (α + π / 2)) = z - v := by push_cast; ring
        rw [dist_eq_norm, this, ← dist_eq_norm]; exact hz
      · rw [frameX_base_N, frameX_add_normal]; exact hx
      · rw [hTA, frameY_add_normal]; linarith
      · rw [dist_eq_norm]; simp
  · -- `μ > 0`: the far side lies inside the circle `Σ`; its shadow is the inside of the concentric circle
    have hf : 0 < curvDown μ := by unfold curvDown; positivity
    have hf' : 1 / curvDown μ = 1 + 1 / μ := inv_curvDown_eq hpos.ne' h1
    have hμ : 0 < 1 / μ := by positivity
    set C : ℂ := v + ((1 / curvDown μ : ℝ) : ℂ) * e (α + π / 2) with hCdef
    have hCn : ‖C - v‖ = 1 / μ + 1 := by
      rw [hCdef, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, hf',
        abs_of_pos (by linarith)]
      ring
    have hP : rayPt C v 1 = v + e (α + π / 2) := by
      have hCv : C - v = ((1 / curvDown μ : ℝ) : ℂ) * e (α + π / 2) := by rw [hCdef]; ring
      unfold rayPt
      rw [hCn, hCv]
      have : ((1 / (1 / μ + 1) : ℝ) : ℂ) * ((1 / curvDown μ : ℝ) : ℂ) = 1 := by
        rw [← Complex.ofReal_mul, hf']
        have : (1 / μ + 1) ≠ 0 := by linarith
        rw [Complex.ofReal_eq_one]; field_simp; ring
      calc v + ((1 / (1 / μ + 1) : ℝ) : ℂ) * (((1 / curvDown μ : ℝ) : ℂ) * e (α + π / 2))
          = v + (((1 / (1 / μ + 1) : ℝ) : ℂ) * ((1 / curvDown μ : ℝ) : ℂ)) * e (α + π / 2) := by ring
        _ = _ := by rw [this, one_mul]
    have hCeq : v + e (α + π / 2) + ((1 / μ : ℝ) : ℂ) * e (α + π / 2) = C := by
      rw [hCdef, hf']; push_cast; ring
    have hT : farSideAbove (v + e (α + π / 2)) α μ δ =
        {y | dist y (v + e (α + π / 2)) < δ ∧ 0 < frameX (v + e (α + π / 2)) α y ∧ dist y C < 1 / μ} := by
      ext y
      simp only [farSideAbove, mem_setOf_eq]
      rw [tanAbove_iff_of_pos (v + e (α + π / 2)) α hpos y, hCeq]
    obtain ⟨ε, hε, H⟩ := shadow_inside (v := v) (C := C) (P := v + e (α + π / 2)) (α := α) (ρ := 1 / μ) (δ := δ)
      hμ hCn hP (frameX_base_N v α) (frameX_normalPt v α _) hδ
    refine ⟨ε, hε, fun z hz hx => ?_⟩
    rw [hT, H z hz hx, tanAbove_iff_of_pos v α hf z, ← hCdef, hf']
    have : 1 + 1 / μ = 1 / μ + 1 := by ring
    rw [this]

/-- **FS110-N4-SHADOW**, going up (the mirror at `S′ = v − n`): an arc of upward curvature `υ < 1` shadows, from below, exactly
the points below the concentric circle of curvature `f̃(υ) = υ/(1 − υ)`. -/
theorem shadow_farSide_below (v : ℂ) (α : ℝ) {υ δ : ℝ} (hυ : υ < 1) (hδ : 0 < δ) :
    ∃ ε > 0, ∀ z, dist z v < ε → 0 < frameX v α z →
      (z ∈ shadow (farSideBelow (v - e (α + π / 2)) α υ δ) ↔ TanBelow v α (curvUp υ) z) := by
  have h1 : 1 - υ ≠ 0 := by linarith
  rcases lt_trichotomy υ 0 with hneg | rfl | hpos
  · -- `υ < 0`: the far side lies inside a circle; its shadow is the inside of the concentric circle
    have hυ1 : 1 / υ < 0 := by rw [one_div]; exact inv_lt_zero.mpr hneg
    have hf' : 1 / curvUp υ = 1 / υ - 1 := inv_curvUp hneg.ne
    have hf : curvUp υ < 0 := by unfold curvUp; exact div_neg_of_neg_of_pos hneg (by linarith)
    set C : ℂ := v + ((1 / curvUp υ : ℝ) : ℂ) * e (α + π / 2) with hCdef
    have hCn : ‖C - v‖ = -(1 / υ) + 1 := by
      rw [hCdef, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, hf',
        abs_of_neg (by linarith)]
      ring
    have hP : rayPt C v 1 = v - e (α + π / 2) := by
      have hCv : C - v = ((1 / curvUp υ : ℝ) : ℂ) * e (α + π / 2) := by rw [hCdef]; ring
      unfold rayPt
      rw [hCn, hCv]
      have : ((1 / (-(1 / υ) + 1) : ℝ) : ℂ) * ((1 / curvUp υ : ℝ) : ℂ) = -1 := by
        rw [← Complex.ofReal_mul, hf']
        have : (-(1 / υ) + 1) ≠ 0 := by linarith
        rw [show (-1 : ℂ) = ((-1 : ℝ) : ℂ) by simp, Complex.ofReal_inj]; field_simp; ring
      calc v + ((1 / (-(1 / υ) + 1) : ℝ) : ℂ) * (((1 / curvUp υ : ℝ) : ℂ) * e (α + π / 2))
          = v + (((1 / (-(1 / υ) + 1) : ℝ) : ℂ) * ((1 / curvUp υ : ℝ) : ℂ)) * e (α + π / 2) := by ring
        _ = _ := by rw [this]; ring
    have hCeq : v - e (α + π / 2) + ((1 / υ : ℝ) : ℂ) * e (α + π / 2) = C := by
      rw [hCdef, hf']; push_cast; ring
    have hT : farSideBelow (v - e (α + π / 2)) α υ δ =
        {y | dist y (v - e (α + π / 2)) < δ ∧ 0 < frameX (v - e (α + π / 2)) α y ∧ dist y C < -(1 / υ)} := by
      ext y
      simp only [farSideBelow, mem_setOf_eq]
      rw [tanBelow_iff_of_neg (v - e (α + π / 2)) α hneg y, hCeq]
    obtain ⟨ε, hε, H⟩ := shadow_inside (v := v) (C := C) (P := v - e (α + π / 2)) (α := α) (ρ := -(1 / υ)) (δ := δ)
      (by linarith) hCn hP (frameX_base_S v α) (frameX_normalPt v α _) hδ
    refine ⟨ε, hε, fun z hz hx => ?_⟩
    rw [hT, H z hz hx, tanBelow_iff_of_neg v α hf z, ← hCdef, hf']
    have : -(1 / υ - 1) = -(1 / υ) + 1 := by ring
    rw [this]
  · -- `υ = 0`: the far side is the half-plane below the line through `S′`
    refine ⟨δ, hδ, fun z hz hx => ?_⟩
    have hf0 : curvUp 0 = 0 := by simp [curvUp]
    rw [hf0]
    have hTB : ∀ y, TanBelow (v - e (α + π / 2)) α 0 y ↔ frameY v α y < -1 := by
      intro y; unfold TanBelow tanHeight; rw [frameY_base_S]; constructor <;> intro h <;> nlinarith
    have hTB0 : TanBelow v α 0 z ↔ frameY v α z < 0 := by unfold TanBelow tanHeight; constructor <;> intro h <;> nlinarith
    rw [hTB0]
    constructor
    · rintro ⟨y, ⟨-, -, hy⟩, hzy⟩
      rw [hTB] at hy
      have hsq := sq_dist_frame v α z y
      rw [hzy] at hsq
      nlinarith [sq_nonneg (frameX v α z - frameX v α y), sq_nonneg (frameY v α z - frameY v α y - 1)]
    · intro hy
      refine ⟨z + ((-1 : ℝ) : ℂ) * e (α + π / 2), ⟨?_, ?_, ?_⟩, ?_⟩
      · have : z + ((-1 : ℝ) : ℂ) * e (α + π / 2) - (v - e (α + π / 2)) = z - v := by push_cast; ring
        rw [dist_eq_norm, this, ← dist_eq_norm]; exact hz
      · rw [frameX_base_S, frameX_add_normal]; exact hx
      · rw [hTB, frameY_add_normal]; linarith
      · rw [dist_eq_norm]; simp
  · -- `υ > 0`: the far side lies outside a circle; its shadow is the outside of the concentric circle
    have hυ : 1 < 1 / υ := by rw [lt_div_iff₀ hpos]; linarith
    have hf' : 1 / curvUp υ = 1 / υ - 1 := inv_curvUp hpos.ne'
    have hf : 0 < curvUp υ := by unfold curvUp; exact div_pos hpos (by linarith)
    set C : ℂ := v + ((1 / curvUp υ : ℝ) : ℂ) * e (α + π / 2) with hCdef
    have hCn : ‖C - v‖ = 1 / υ - 1 := by
      rw [hCdef, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, hf',
        abs_of_pos (by linarith)]
    have hP : rayPt C v (-1) = v - e (α + π / 2) := by
      have hCv : C - v = ((1 / curvUp υ : ℝ) : ℂ) * e (α + π / 2) := by rw [hCdef]; ring
      unfold rayPt
      rw [hCn, hCv]
      have : ((-1 / (1 / υ - 1) : ℝ) : ℂ) * ((1 / curvUp υ : ℝ) : ℂ) = -1 := by
        rw [← Complex.ofReal_mul, hf']
        have : (1 / υ - 1) ≠ 0 := by linarith
        rw [show (-1 : ℂ) = ((-1 : ℝ) : ℂ) by simp, Complex.ofReal_inj]; field_simp
      calc v + ((-1 / (1 / υ - 1) : ℝ) : ℂ) * (((1 / curvUp υ : ℝ) : ℂ) * e (α + π / 2))
          = v + (((-1 / (1 / υ - 1) : ℝ) : ℂ) * ((1 / curvUp υ : ℝ) : ℂ)) * e (α + π / 2) := by ring
        _ = _ := by rw [this]; ring
    have hCeq : v - e (α + π / 2) + ((1 / υ : ℝ) : ℂ) * e (α + π / 2) = C := by
      rw [hCdef, hf']; push_cast; ring
    have hT : farSideBelow (v - e (α + π / 2)) α υ δ =
        {y | dist y (v - e (α + π / 2)) < δ ∧ 0 < frameX (v - e (α + π / 2)) α y ∧ 1 / υ < dist y C} := by
      ext y
      simp only [farSideBelow, mem_setOf_eq]
      rw [tanBelow_iff_of_pos (v - e (α + π / 2)) α hpos y, hCeq]
    obtain ⟨ε, hε, H⟩ := shadow_outside (v := v) (C := C) (P := v - e (α + π / 2)) (α := α) (ρ := 1 / υ) (δ := δ)
      hυ hCn hP (frameX_base_S v α) (frameX_normalPt v α _) hδ
    refine ⟨ε, hε, fun z hz hx => ?_⟩
    rw [hT, H z hz hx, tanBelow_iff_of_pos v α hf z, ← hCdef, hf']

/-- `dot` is real-bilinear: scaling the first argument by a real number. -/
theorem dot_div_ofReal (a b : ℂ) (r : ℝ) : dot (a / (r : ℂ)) b = dot a b / r := by
  unfold dot
  rw [div_mul_eq_mul_div, Complex.div_ofReal_re]

/-- The law of cosines in dot form: `‖a − b‖² = ‖a‖² − 2 a·b + ‖b‖²`. -/
theorem norm_sub_sq_eq_dot (a b : ℂ) : ‖a - b‖ ^ 2 = ‖a‖ ^ 2 - 2 * dot a b + ‖b‖ ^ 2 := by
  rw [Complex.sq_norm, Complex.sq_norm, Complex.sq_norm, Complex.normSq_sub]
  unfold dot
  ring

/-- `|a·b| ≤ ‖a‖‖b‖`. -/
theorem abs_dot_le (a b : ℂ) : |dot a b| ≤ ‖a‖ * ‖b‖ := by
  unfold dot
  calc |(a * starRingEnd ℂ b).re| ≤ ‖a * starRingEnd ℂ b‖ := Complex.abs_re_le_norm _
    _ = ‖a‖ * ‖b‖ := by rw [norm_mul, RCLike.norm_conj]

/-- `dot` is additive in its first argument. -/
theorem dot_sub (a a' b : ℂ) : dot (a - a') b = dot a b - dot a' b := by
  unfold dot; rw [sub_mul, Complex.sub_re]

/-- A set approaching `v` along `β` and lying in `B̄(w, 1)` (`‖w − v‖ = 1`) approaches it within the half-plane `e β·(w − v) ≥ 0`. -/
theorem dot_nonneg_of_coneAt_subset {T : Set ℂ} {v w : ℂ} {β : ℝ} (hβ : β ∈ coneAt T v) (hw : dist w v = 1)
    (hT : ∀ t ∈ T, dist t w ≤ 1) : 0 ≤ dot (e β) (w - v) := by
  by_contra hneg
  rw [not_le] at hneg
  have hb : ‖w - v‖ = 1 := by rw [← dist_eq_norm]; exact hw
  obtain ⟨z, hzT, hzne, -, hdir⟩ := hβ (-dot (e β) (w - v) / 2) (by linarith)
  set a := z - v with ha
  have hr : 0 < ‖a‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzne)
  have hzw : ‖a - (w - v)‖ ^ 2 ≤ 1 := by
    have : a - (w - v) = z - w := by rw [ha]; ring
    rw [this, ← dist_eq_norm]
    nlinarith [hT z hzT, dist_nonneg (x := z) (y := w)]
  rw [norm_sub_sq_eq_dot, hb] at hzw
  have hdot : 0 < dot a (w - v) := by nlinarith [sq_nonneg ‖a‖]
  have hu : 0 < dot (a / (‖a‖ : ℂ)) (w - v) := by rw [dot_div_ofReal]; exact div_pos hdot hr
  have hdiff : |dot (a / (‖a‖ : ℂ) - e β) (w - v)| ≤ -dot (e β) (w - v) / 2 := by
    refine (abs_dot_le _ _).trans ?_
    rw [hb, mul_one]; exact hdir.le
  rw [dot_sub] at hdiff
  have := (abs_le.mp hdiff).2
  linarith

/-- The mirror: a set approaching `v` along `β` and lying outside `B(w, 1)` approaches it within `e β·(w − v) ≤ 0`. -/
theorem dot_nonpos_of_coneAt_subset {T : Set ℂ} {v w : ℂ} {β : ℝ} (hβ : β ∈ coneAt T v) (hw : dist w v = 1)
    (hT : ∀ t ∈ T, 1 ≤ dist t w) : dot (e β) (w - v) ≤ 0 := by
  by_contra hpos
  rw [not_le] at hpos
  have hb : ‖w - v‖ = 1 := by rw [← dist_eq_norm]; exact hw
  obtain ⟨z, hzT, hzne, hzd, hdir⟩ := hβ (dot (e β) (w - v) / 2) (by linarith)
  set a := z - v with ha
  have hr : 0 < ‖a‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzne)
  have hzw : 1 ≤ ‖a - (w - v)‖ ^ 2 := by
    have : a - (w - v) = z - w := by rw [ha]; ring
    rw [this, ← dist_eq_norm]
    nlinarith [hT z hzT]
  rw [norm_sub_sq_eq_dot, hb] at hzw
  have hdot : dot a (w - v) ≤ ‖a‖ ^ 2 / 2 := by nlinarith
  have hu : dot (a / (‖a‖ : ℂ)) (w - v) ≤ ‖a‖ / 2 := by
    rw [dot_div_ofReal, div_le_iff₀ hr]; nlinarith
  have hdiff : |dot (a / (‖a‖ : ℂ) - e β) (w - v)| ≤ dot (e β) (w - v) / 2 := by
    refine (abs_dot_le _ _).trans ?_
    rw [hb, mul_one]; exact hdir.le
  rw [dot_sub] at hdiff
  have := (abs_le.mp hdiff).1
  have hzd' : ‖a‖ < dot (e β) (w - v) / 2 := by rw [ha, ← dist_eq_norm]; exact hzd
  linarith

/-- `dot` is symmetric. -/
theorem dot_comm' (a b : ℂ) : dot a b = dot b a := by
  unfold dot
  rw [← Complex.conj_re (b * starRingEnd ℂ a), map_mul, Complex.conj_conj, mul_comm]

/-- `dot u u = ‖u‖²`. -/
theorem dot_self_eq (u : ℂ) : dot u u = ‖u‖ ^ 2 := by
  unfold dot; rw [Complex.mul_conj, Complex.normSq_eq_norm_sq]; norm_cast

/-- **The squared distance from `v + t d` to `y`** (`‖d‖ = 1`): `‖y − v‖² − 2t d·(y − v) + t²`. -/
theorem sq_norm_sub_add_smul (v y : ℂ) (β t : ℝ) :
    ‖y - (v + (t : ℂ) * e β)‖ ^ 2 = ‖y - v‖ ^ 2 - 2 * t * dot (e β) (y - v) + t ^ 2 := by
  have h := norm_sub_sq_eq_dot (y - v) ((t : ℂ) * e β)
  rw [show y - v - (t : ℂ) * e β = y - (v + (t : ℂ) * e β) by ring, norm_mul, Complex.norm_real, norm_e, mul_one,
    Real.norm_eq_abs, sq_abs, dot_comm' (y - v), dot_ofReal_mul] at h
  rw [h]; ring

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS110-N3-CONF -/

/-- **FS110-N3-CONF**, (i): every contact of a colour `c ∈ P_cl(v)` on `ω(v)` is in-type or out-type, and not both. -/
theorem contact_inType_or_outType (hF : F.Valid) {v w : ℂ} {c : Fin k} (hv : F.Covers v 1)
    (hw : F.IsContact v c w) : (F.InType v c w ∨ F.OutType v c w) ∧ ¬ (F.InType v c w ∧ F.OutType v c w) := by
  obtain ⟨hcv, hwv, hwcl⟩ := hw
  have hwdom : w ∈ F.dom := hv (by rw [mem_closedBall, hwv])
  have hvdom : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  -- every tile of colour `c` at `w` is inside `B(v,1)` or misses `B̄(v,1)` (N-E1 at `v`, then connectedness)
  have htype : ∀ T, F.TileOf c T → T ⊆ ball v 1 ∨ Disjoint T (closedBall v 1) := by
    intro T hT
    have hsph : ∀ t ∈ T, dist t v ≠ 1 := fun t ht => ne1_region hF hcv (hT.subset_region ht)
    have hcov : T ⊆ ball v 1 ∪ (closedBall v 1)ᶜ := by
      intro t ht
      rcases lt_or_gt_of_ne (hsph t ht) with h | h
      · exact Or.inl h
      · exact Or.inr (by simpa [mem_closedBall, not_le] using h)
    rcases hT.1.isPreconnected.subset_or_subset isOpen_ball isClosed_closedBall.isOpen_compl
        (by rw [disjoint_left]; intro x hx hx'; exact hx' (ball_subset_closedBall hx)) hcov with h | h
    · exact Or.inl h
    · exact Or.inr (disjoint_left.mpr fun x hx hx' => h hx hx')
  -- a tile at `w` exists
  obtain ⟨T₀, hT₀, hwT₀⟩ := (F.mem_coloursAt_iff_exists_tileOf hwdom).mp hwcl
  -- an in-type and an out-type tile cannot both touch `w`
  have hnot : ∀ T₁ T₂, F.TileOf c T₁ → F.TileOf c T₂ → w ∈ closure T₁ → w ∈ closure T₂ →
      T₁ ⊆ ball v 1 → Disjoint T₂ (closedBall v 1) → False := by
    intro T₁ T₂ hT₁ hT₂ hw₁ hw₂ hin hout
    obtain ⟨T₀, hT₀, hvT₀⟩ := (F.mem_coloursAt_iff_exists_tileOf hvdom).mp hcv
    obtain ⟨t₁, ht₁⟩ := hT₁.1.nonempty
    obtain ⟨t₂, ht₂⟩ := hT₂.1.nonempty
    have hnear : UnitNear T₀ T₁ :=
      unitNear_of_mem_closure hF hT₀ hT₁ hvT₀ (subset_closure ht₁) (by rw [dist_comm]; exact hin ht₁)
    have hfar : UnitFar T₀ T₂ := by
      refine unitFar_of_mem_closure hF hT₀ hT₂ hvT₀ (subset_closure ht₂) ?_
      have := disjoint_left.mp hout ht₂
      rw [mem_closedBall, not_le] at this
      rwa [dist_comm]
    -- `T₀ ⊆ B̄(w,1)` and `T₀ ∩ B(w,1) = ∅`, so `T₀ ⊆ ω(w)`
    have h1 : ∀ t ∈ T₀, dist t w ≤ 1 := by
      intro t ht
      have hsub : closure T₁ ⊆ closedBall t 1 := by
        refine closure_minimal (fun x hx => ?_) isClosed_closedBall
        rw [mem_closedBall, dist_comm]; exact (hnear t ht x hx).le
      have := mem_closedBall.mp (hsub hw₁)
      rwa [dist_comm] at this
    have h2 : ∀ t ∈ T₀, 1 ≤ dist t w := by
      intro t ht
      have hge : closure T₂ ⊆ {s | 1 ≤ dist t s} := by
        refine closure_minimal (fun x hx => ?_) (isClosed_le continuous_const (by fun_prop))
        exact (hfar t ht x hx).le
      have := hge hw₂
      simpa [dist_comm] using this
    have hsub : T₀ ⊆ sphere w 1 := fun t ht => le_antisymm (h1 t ht) (h2 t ht)
    have := hT₀.1.isOpen.subset_interior_iff.mpr hsub
    rw [interior_sphere w one_ne_zero] at this
    obtain ⟨t, ht⟩ := hT₀.1.nonempty
    exact this ht
  refine ⟨?_, fun ⟨hin, hout⟩ => ?_⟩
  · by_cases hex : ∃ T, F.TileOf c T ∧ w ∈ closure T ∧ T ⊆ ball v 1
    · obtain ⟨T₁, hT₁, hw₁, hin₁⟩ := hex
      left
      intro T hT hwT
      rcases htype T hT with h | h
      · exact h
      · exact (hnot T₁ T hT₁ hT hw₁ hwT hin₁ h).elim
    · right
      push Not at hex
      intro T hT hwT
      rcases htype T hT with h | h
      · exact (hex T hT hwT h).elim
      · exact h
  · obtain ⟨t, ht⟩ := hT₀.1.nonempty
    have := hin T₀ hT₀ hwT₀ ht
    have h' := disjoint_left.mp (hout T₀ hT₀ hwT₀) ht
    exact h' (ball_subset_closedBall this)

/-- **FS110-N3-CONF**, (ii): the directions along which `c`'s class approaches `v` (the union of its sectors' cones) lie in the
allowed cone `D_c(v)`. -/
theorem coneAt_subset_allowedCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) {β : ℝ}
    (hβ : β ∈ coneAt (F.region c) v) : e β ∈ F.allowedCone v c := by
  intro w hw
  obtain ⟨hcv, hwv, hwcl⟩ := hw
  have hwdom : w ∈ F.dom := hv (by rw [mem_closedBall, hwv])
  have hvdom : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  rw [F.coneAt_region_eq_biUnion hvdom c] at hβ
  obtain ⟨T, ⟨hT, hvT⟩, hβT⟩ := mem_iUnion₂.mp hβ
  obtain ⟨S, hS, hwS⟩ := (F.mem_coloursAt_iff_exists_tileOf hwdom).mp hwcl
  obtain ⟨s, hs⟩ := hS.1.nonempty
  constructor
  · intro hin
    have hS1 : S ⊆ ball v 1 := hin S hS hwS
    have hnear : UnitNear T S :=
      unitNear_of_mem_closure hF hT hS hvT (subset_closure hs) (by rw [dist_comm]; exact hS1 hs)
    refine dot_nonneg_of_coneAt_subset hβT hwv fun t ht => ?_
    have hsub : closure S ⊆ closedBall t 1 := by
      refine closure_minimal (fun x hx => ?_) isClosed_closedBall
      rw [mem_closedBall, dist_comm]; exact (hnear t ht x hx).le
    have := mem_closedBall.mp (hsub hwS)
    rwa [dist_comm] at this
  · intro hout
    have hS1 : Disjoint S (closedBall v 1) := hout S hS hwS
    have hfar : UnitFar T S := by
      refine unitFar_of_mem_closure hF hT hS hvT (subset_closure hs) ?_
      have := disjoint_left.mp hS1 hs
      rw [mem_closedBall, not_le] at this
      rwa [dist_comm]
    refine dot_nonpos_of_coneAt_subset hβT hwv fun t ht => ?_
    have hge : closure S ⊆ {x | 1 ≤ dist t x} := by
      refine closure_minimal (fun x hx => ?_) (isClosed_le continuous_const (by fun_prop))
      exact (hfar t ht x hx).le
    have := hge hwS
    simpa [dist_comm] using this

/-- **Near a point of the domain, every tile meeting a small ball has the point in its closure** (finitely many tiles near
it, `finite_tiles_near`). -/
theorem exists_ball_tiles_mem_closure {w : ℂ} (hw : w ∈ F.dom) :
    ∃ δ > 0, ∀ T, F.IsTile T → (T ∩ ball w δ).Nonempty → w ∈ closure T := by
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near hw
  set 𝒯 := {T | F.IsTile T ∧ (T ∩ ball w r).Nonempty} with h𝒯
  set B := ⋃ T ∈ {T | T ∈ 𝒯 ∧ w ∉ closure T}, closure T with hB
  have hBc : IsClosed B := (hfin.subset fun T hT => hT.1).isClosed_biUnion fun T _ => isClosed_closure
  have hwB : w ∉ B := by
    rw [hB, mem_iUnion₂]
    rintro ⟨T, ⟨_, hT⟩, hw⟩
    exact hT hw
  obtain ⟨δ₁, hδ₁, hδB⟩ := Metric.isOpen_iff.mp hBc.isOpen_compl w hwB
  refine ⟨min r δ₁, lt_min hr hδ₁, fun T hT hne => ?_⟩
  by_contra hwT
  obtain ⟨y, hyT, hyb⟩ := hne
  have hT𝒯 : T ∈ 𝒯 := ⟨hT, y, hyT, ball_subset_ball (min_le_left _ _) hyb⟩
  have hyB : y ∈ B := mem_biUnion (x := T) ⟨hT𝒯, hwT⟩ (subset_closure hyT)
  exact hδB (ball_subset_ball (min_le_right _ _) hyb) hyB

/-- The tile through a point of `c`'s class is a `c`-tile containing it. -/
theorem tileOf_component {c : Fin k} {y : ℂ} (hy : y ∈ F.region c) :
    F.TileOf c (connectedComponentIn F.interiorPts y) ∧ y ∈ connectedComponentIn F.interiorPts y := by
  have hyI : y ∈ F.interiorPts := hy.1
  have hT : F.IsTile (connectedComponentIn F.interiorPts y) := ⟨y, hyI, rfl⟩
  have hmem : y ∈ connectedComponentIn F.interiorPts y := mem_connectedComponentIn hyI
  have hcol : F.col y = c := hy.2
  exact ⟨hcol ▸ hT.tileOf hmem, hmem⟩

/-- **FS110-N3-CONF**, (iii) (N3-CLEAR): a compact set of directions inside the interior of `D_c(v)` is clear for `c` near `v`. -/
theorem clear_of_subset_interior_allowedCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    {Λ : Set ℝ} (hΛ : IsCompact Λ) (hΛD : e '' Λ ⊆ interior (F.allowedCone v c)) :
    ∃ ρ > 0, ∀ β ∈ Λ, ∀ t : ℝ, 0 < t → t < ρ → F.IsClear c (v + (t : ℂ) * e β) := by
  have hcont_e : Continuous e := Complex.continuous_exp.comp (Complex.continuous_ofReal.mul continuous_const)
  -- the margin `μ` of `Λ`'s directions inside `D_c(v)`
  obtain ⟨δ, hδ, hthick⟩ := (hΛ.image hcont_e).exists_thickening_subset_open isOpen_interior hΛD
  set μ := δ / 2 with hμ
  have hμ0 : 0 < μ := by positivity
  have hmargin : ∀ β ∈ Λ, ∀ w, F.IsContact v c w →
      (F.InType v c w → μ ≤ dot (e β) (w - v)) ∧ (F.OutType v c w → dot (e β) (w - v) ≤ -μ) := by
    intro β hβ w hw
    have hu : ‖w - v‖ = 1 := by rw [← dist_eq_norm]; exact hw.2.1
    have huu : dot (w - v) (w - v) = 1 := by rw [dot_self_eq, hu]; norm_num
    have hmem : ∀ σ : ℝ, |σ| = 1 → e β + ((σ * μ : ℝ) : ℂ) * (w - v) ∈ F.allowedCone v c := by
      intro σ hσ
      apply interior_subset
      apply hthick
      rw [Metric.mem_thickening_iff]
      refine ⟨e β, mem_image_of_mem e hβ, ?_⟩
      rw [dist_eq_norm, add_sub_cancel_left, norm_mul, hu, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_mul, hσ,
        one_mul, abs_of_pos hμ0]
      linarith
    constructor
    · intro hin
      have := (hmem (-1) (by norm_num) w hw).1 hin
      rw [dot_add_left, dot_ofReal_mul, huu] at this; linarith
    · intro hout
      have := (hmem 1 (by norm_num) w hw).2 hout
      rw [dot_add_left, dot_ofReal_mul, huu] at this; linarith
  -- the contacts, each with a ball met only by tiles holding it in their closure
  set W := closure (F.region c) ∩ sphere v 1 with hW
  have hloc : ∀ w ∈ W, ∃ δw > 0, δw ≤ μ / 2 ∧ ∀ T, F.IsTile T → (T ∩ ball w δw).Nonempty → w ∈ closure T := by
    intro w hw
    have hwdom : w ∈ F.dom := hv (sphere_subset_closedBall hw.2)
    obtain ⟨δ', hδ', h⟩ := exists_ball_tiles_mem_closure hwdom
    refine ⟨min δ' (μ / 2), lt_min hδ' (by positivity), min_le_right _ _, fun T hT hne => h T hT ?_⟩
    obtain ⟨y, hyT, hyb⟩ := hne
    exact ⟨y, hyT, ball_subset_ball (min_le_left _ _) hyb⟩
  choose! δw hδw0 hδwμ hδwT using hloc
  set U := ⋃ w ∈ W, ball w (δw w) with hU
  have hUo : IsOpen U := isOpen_biUnion fun w _ => isOpen_ball
  have hWU : W ⊆ U := fun w hw => mem_biUnion hw (mem_ball_self (hδw0 w hw))
  -- the annulus margin `t₀`
  set K := (closure (F.region c) ∩ {y | 1 / 2 ≤ dist y v ∧ dist y v ≤ 3 / 2}) \ U with hK
  have hKc : IsCompact K := by
    refine Metric.isCompact_of_isClosed_isBounded ?_ ?_
    · refine (isClosed_closure.inter ?_).sdiff hUo
      exact (isClosed_le continuous_const (continuous_id.dist continuous_const)).inter
        (isClosed_le (continuous_id.dist continuous_const) continuous_const)
    · refine (Metric.isBounded_closedBall (x := v) (r := 3 / 2)).subset fun y hy => ?_
      exact mem_closedBall.mpr hy.1.2.2
  obtain ⟨t₀, ht₀, ht₀h, ht₀K⟩ : ∃ t₀ > 0, t₀ ≤ 1 / 2 ∧ ∀ y ∈ K, t₀ ≤ |dist y v - 1| := by
    rcases K.eq_empty_or_nonempty with hKe | hKne
    · exact ⟨1 / 2, by norm_num, le_rfl, fun y hy => by rw [hKe] at hy; exact hy.elim⟩
    · obtain ⟨y₀, hy₀K, hmin⟩ := hKc.exists_isMinOn hKne
        ((continuous_id.dist continuous_const).sub continuous_const).abs.continuousOn
      have hpos : 0 < |dist y₀ v - 1| := by
        rw [abs_pos, sub_ne_zero]
        intro h1
        exact hy₀K.2 (hWU ⟨hy₀K.1.1, by rw [mem_sphere]; exact h1⟩)
      exact ⟨min (1 / 2) |dist y₀ v - 1|, lt_min (by norm_num) hpos, min_le_left _ _,
        fun y hy => (min_le_right _ _).trans (hmin hy)⟩
  refine ⟨min t₀ (μ / 2), lt_min ht₀ (by positivity), fun β hβ t ht0 htρ y hy hzy => ?_⟩
  have htt₀ : t < t₀ := lt_of_lt_of_le htρ (min_le_left _ _)
  have htμ : t < μ / 2 := lt_of_lt_of_le htρ (min_le_right _ _)
  set z := v + (t : ℂ) * e β with hz
  have hzv : dist z v = t := by
    rw [hz, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs,
      abs_of_pos ht0]
  -- `y` is within `t₀` of `ω(v)`
  have hnear : |dist y v - 1| < t₀ := by
    have h1 := dist_triangle y z v
    have h2 := dist_triangle y v z
    rw [dist_comm y z, hzy, hzv] at h1
    rw [dist_comm y z, hzy, dist_comm v z, hzv] at h2
    rw [abs_lt]; constructor <;> linarith
  have hyU : y ∈ U := by
    by_contra hyU
    have hyK : y ∈ K := by
      refine ⟨⟨subset_closure hy, ?_, ?_⟩, hyU⟩
      · have := (abs_lt.mp hnear).1; linarith
      · have := (abs_lt.mp hnear).2; linarith
    linarith [ht₀K y hyK]
  obtain ⟨w, hwW, hyw⟩ := mem_iUnion₂.mp hyU
  have hw : F.IsContact v c w := ⟨hc, hwW.2, hwW.1⟩
  obtain ⟨hTy, hyT⟩ := tileOf_component hy
  have hwT : w ∈ closure (connectedComponentIn F.interiorPts y) := hδwT w hwW _ hTy.1 ⟨y, hyT, hyw⟩
  have hywd : ‖y - w‖ < μ / 2 := by rw [← dist_eq_norm]; exact lt_of_lt_of_le hyw (hδwμ w hwW)
  have hdy : |dot (e β) (y - w)| < μ / 2 := by
    have := abs_dot_le (e β) (y - w); rw [norm_e, one_mul] at this; linarith
  have hsplit : dot (e β) (y - v) = dot (e β) (w - v) + dot (e β) (y - w) := by
    unfold dot; simp only [map_sub, mul_sub, Complex.sub_re]; ring
  have hsq : ‖y - z‖ ^ 2 = 1 := by rw [← dist_eq_norm, dist_comm, hzy]; norm_num
  rw [hz, sq_norm_sub_add_smul] at hsq
  rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
  · have hyv : ‖y - v‖ < 1 := by rw [← dist_eq_norm]; exact hin _ hTy hwT hyT
    have hm := (hmargin β hβ w hw).1 hin
    have hd : μ / 2 ≤ dot (e β) (y - v) := by rw [hsplit]; linarith [(abs_lt.mp hdy).1]
    have : ‖y - v‖ ^ 2 < 1 := by nlinarith [norm_nonneg (y - v)]
    nlinarith
  · have hyv : 1 < ‖y - v‖ := by
      have := disjoint_left.mp (hout _ hTy hwT) hyT
      rw [mem_closedBall, not_le, dist_eq_norm] at this; exact this
    have hm := (hmargin β hβ w hw).2 hout
    have hd : dot (e β) (y - v) ≤ -(μ / 2) := by rw [hsplit]; linarith [(abs_lt.mp hdy).2]
    have : 1 < ‖y - v‖ ^ 2 := by nlinarith
    nlinarith

end ArcMap

/-- **FS110-N3-CONF**, (iv) (N3-UP, the lens `|p|² ≤ 2p_y`, check C1): near `v`, moving a point in the `+n` direction keeps it
within distance `1` of every point of the lens `B(v, 1) ∩ B̄(N, 1)` it was within `1` of — so a point clear of an in-type tile at
`N` (all of whose distances are below `1`) stays clear. -/
theorem lens_dist_lt_one_of_up (v : ℂ) (α : ℝ) :
    ∃ r > 0, ∀ z, dist z v < r → ∀ t : ℝ, 0 ≤ t → dist (z + t * e (α + π / 2)) v < r →
      ∀ p ∈ ball v 1 ∩ closedBall (v + e (α + π / 2)) 1, dist z p < 1 → dist (z + t * e (α + π / 2)) p < 1 := by
  refine ⟨1 / 8, by norm_num, fun z hz t ht hz' p hp hd => ?_⟩
  obtain ⟨hpv, hpN⟩ := hp
  rw [mem_ball] at hpv
  rw [mem_closedBall] at hpN
  set z' := z + (t : ℂ) * e (α + π / 2) with hz'def
  have hx' : frameX v α z' = frameX v α z := frameX_add_normal v α t z
  have hy' : frameY v α z' = frameY v α z + t := frameY_add_normal v α t z
  have hdz : dist z' p ^ 2 = (frameX v α z - frameX v α p) ^ 2 + (frameY v α z + t - frameY v α p) ^ 2 := by
    rw [sq_dist_frame v α z' p, hx', hy']
  have hdz0 : dist z p ^ 2 = (frameX v α z - frameX v α p) ^ 2 + (frameY v α z - frameY v α p) ^ 2 :=
    sq_dist_frame v α z p
  have hpN2 : dist p (v + e (α + π / 2)) ^ 2 = frameX v α p ^ 2 + (frameY v α p - 1) ^ 2 := by
    rw [sq_dist_frame v α p, frameX_N, frameY_N]; ring
  have hpv2 : dist p v ^ 2 = frameX v α p ^ 2 + frameY v α p ^ 2 := by
    rw [sq_dist_frame v α p v, frameX_self, frameY_self]; ring
  have hz'v : frameX v α z' ^ 2 + frameY v α z' ^ 2 = dist z' v ^ 2 := by
    rw [sq_dist_frame v α z' v, frameX_self, frameY_self]; ring
  have hzv : frameX v α z ^ 2 + frameY v α z ^ 2 = dist z v ^ 2 := by
    rw [sq_dist_frame v α z v, frameX_self, frameY_self]; ring
  set a := frameX v α p
  set b := frameY v α p
  set x := frameX v α z
  set y := frameY v α z
  have hpN' : a ^ 2 + (b - 1) ^ 2 ≤ 1 := by
    have := pow_le_pow_left₀ dist_nonneg hpN 2
    rw [hpN2] at this; linarith
  have hzr : dist z v ^ 2 < 1 / 64 := by
    have := pow_lt_pow_left₀ hz dist_nonneg (two_ne_zero); nlinarith
  have hz'r : dist z' v ^ 2 < 1 / 64 := by
    have := pow_lt_pow_left₀ hz' dist_nonneg (two_ne_zero); nlinarith
  have hd2 : dist z p ^ 2 < 1 := by
    have := pow_lt_pow_left₀ hd dist_nonneg (two_ne_zero); simpa using this
  rw [← sq_lt_one_iff₀ dist_nonneg]
  by_cases hcase : 1 / 4 ≤ a ^ 2 + b ^ 2
  · -- the point `p` is ahead of both: moving up only approaches it
    have hpN'' : a ^ 2 + b ^ 2 ≤ 2 * b := by
      have : (b - 1) ^ 2 = b ^ 2 - 2 * b + 1 := by ring
      linarith
    have hb : 1 / 8 ≤ b := by linarith
    have hy2 : y + t < 1 / 8 := by
      have h1 : (y + t) ^ 2 < (1 / 8) ^ 2 := by
        rw [← hy']; nlinarith [sq_nonneg (frameX v α z')]
      exact (abs_lt.mp (abs_lt_of_sq_lt_sq h1 (by norm_num))).2
    have hy1 : y ≤ y + t := by linarith
    have hle : t * (y + (y + t) - 2 * b) ≤ 0 := mul_nonpos_of_nonneg_of_nonpos ht (by linarith)
    have : dist z' p ^ 2 ≤ dist z p ^ 2 := by rw [hdz, hdz0]; nlinarith [hle]
    linarith
  · -- the point `p` is within `1/2` of `v`
    push Not at hcase
    have hpv' : dist p v < 1 / 2 := by
      have h1 : dist p v ^ 2 < (1 / 2) ^ 2 := by nlinarith
      exact lt_of_pow_lt_pow_left₀ 2 (by norm_num) h1
    have hz'v' : dist z' v < 1 / 8 := hz'
    have : dist z' p < 1 := by
      calc dist z' p ≤ dist z' v + dist v p := dist_triangle _ _ _
        _ < 1 / 8 + 1 / 2 := by rw [dist_comm v p]; linarith
        _ < 1 := by norm_num
    exact pow_lt_one₀ dist_nonneg this two_ne_zero

/-- **FS110-N3-CONF**, (iv) (N3-UP, the lune `p_y ≤ −1/2`, check C2): moving a point near `v` in the `+n` direction moves it
away from every point of the lune `B̄(S′, 1) ∖ B(v, 1)` — so a point clear of an out-type tile at `S′` (all of whose distances
exceed `1`) stays clear. -/
theorem lune_dist_le_of_up (v : ℂ) (α : ℝ) {z : ℂ} (hz : dist z v < 1 / 2) {t : ℝ} (ht : 0 ≤ t)
    {p : ℂ} (hp : p ∈ closedBall (v - e (α + π / 2)) 1 \ ball v 1) : dist z p ≤ dist (z + t * e (α + π / 2)) p := by
  obtain ⟨hpS, hpv⟩ := hp
  rw [mem_closedBall] at hpS
  rw [mem_ball, not_lt] at hpv
  have hdz : dist (z + (t : ℂ) * e (α + π / 2)) p ^ 2 =
      (frameX v α z - frameX v α p) ^ 2 + (frameY v α z + t - frameY v α p) ^ 2 := by
    rw [sq_dist_frame v α _ p, frameX_add_normal, frameY_add_normal]
  have hdz0 : dist z p ^ 2 = (frameX v α z - frameX v α p) ^ 2 + (frameY v α z - frameY v α p) ^ 2 :=
    sq_dist_frame v α z p
  have hpS2 : dist p (v - e (α + π / 2)) ^ 2 = frameX v α p ^ 2 + (frameY v α p + 1) ^ 2 := by
    rw [sq_dist_frame v α p, frameX_S, frameY_S]; ring
  have hpv2 : dist p v ^ 2 = frameX v α p ^ 2 + frameY v α p ^ 2 := by
    rw [sq_dist_frame v α p v, frameX_self, frameY_self]; ring
  have hzv : frameX v α z ^ 2 + frameY v α z ^ 2 = dist z v ^ 2 := by
    rw [sq_dist_frame v α z v, frameX_self, frameY_self]; ring
  set a := frameX v α p
  set b := frameY v α p
  set y := frameY v α z
  have hpS' : a ^ 2 + (b + 1) ^ 2 ≤ 1 := by
    have := pow_le_pow_left₀ dist_nonneg hpS 2
    rw [hpS2] at this; linarith
  have hpv' : 1 ≤ a ^ 2 + b ^ 2 := by
    have := pow_le_pow_left₀ zero_le_one hpv 2
    rw [hpv2] at this; linarith
  have hb : b ≤ -1 / 2 := by
    have : (b + 1) ^ 2 = b ^ 2 + 2 * b + 1 := by ring
    linarith
  have hy : -(1 / 2) < y := by
    have h1 : y ^ 2 < (1 / 2) ^ 2 := by
      have := pow_lt_pow_left₀ hz dist_nonneg two_ne_zero
      nlinarith [sq_nonneg (frameX v α z)]
    exact (abs_lt.mp (abs_lt_of_sq_lt_sq h1 (by norm_num))).1
  have hle : 0 ≤ t * (2 * (y - b) + t) := mul_nonneg ht (by linarith)
  have : dist z p ^ 2 ≤ dist (z + (t : ℂ) * e (α + π / 2)) p ^ 2 := by rw [hdz, hdz0]; nlinarith [hle]
  exact (pow_le_pow_iff_left₀ dist_nonneg dist_nonneg two_ne_zero).mp this

/-- The horn depends on its direction only through `e β`. -/
theorem hornSet_congr {v : ℂ} {β β' : ℝ} (h : e β = e β') (κ₁ κ₂ r : ℝ) :
    hornSet v β κ₁ κ₂ r = hornSet v β' κ₁ κ₂ r := by
  simp only [hornSet, TanAbove, TanBelow, frameX, frameY, h]

/-- The height of the branch point of curvature `m` above the tangent circle of curvature `κ`: `s²(m − κ)/2`. -/
theorem tanHeight_branchPt (v : ℂ) (β m κ : ℝ) {s : ℝ} (hs : |m| * s ≤ 2) (hs0 : 0 ≤ s) :
    tanHeight κ (frameX v β (branchPt v β m s)) (frameY v β (branchPt v β m s)) = s ^ 2 * (m - κ) / 2 := by
  have ha := half_curv_mem_Icc hs hs0 le_rfl
  rw [branchPt, tanHeight_polar, add_sub_cancel_left, Real.sin_arcsin ha.1 ha.2]
  ring

/-- The branch point lies on the `+a` side of `v`. -/
theorem frameX_branchPt_pos (v : ℂ) (β m : ℝ) {s : ℝ} (hs : |m| * s < 2) (hs0 : 0 < s) :
    0 < frameX v β (branchPt v β m s) := by
  rw [branchPt, (frame_polar v β s _).1, add_sub_cancel_left, Real.cos_arcsin]
  refine mul_pos hs0 (Real.sqrt_pos.mpr ?_)
  have h : |m * s / 2| < 1 := by
    rw [abs_div, abs_mul, abs_of_pos hs0, abs_two]; rw [div_lt_one two_pos]; linarith
  have := abs_lt.mp h
  nlinarith

/-- **A branch point of intermediate curvature lies in the horn**: for `κ₁ < m < κ₂` and `0 < s < r` (with `|m| s < 2`),
`branchPt v β m s ∈ hornSet v β κ₁ κ₂ r`. -/
theorem branchPt_mem_hornSet (v : ℂ) (β : ℝ) {κ₁ κ₂ m r s : ℝ} (h1 : κ₁ < m) (h2 : m < κ₂) (hs0 : 0 < s) (hsr : s < r)
    (hs : |m| * s < 2) : branchPt v β m s ∈ hornSet v β κ₁ κ₂ r := by
  refine ⟨?_, frameX_branchPt_pos v β m hs hs0, ?_, ?_⟩
  · rw [dist_eq_norm, norm_branchPt_sub v β m hs0.le]; exact hsr
  · show 0 < tanHeight _ _ _
    rw [tanHeight_branchPt v β m κ₁ hs.le hs0.le]
    have : 0 < s ^ 2 := by positivity
    nlinarith
  · show tanHeight _ _ _ < 0
    rw [tanHeight_branchPt v β m κ₂ hs.le hs0.le]
    have : 0 < s ^ 2 := by positivity
    nlinarith

/-- A small admissible distance: `0 < s < r` with `|m| s < 2`. -/
theorem exists_small_s (m : ℝ) {r : ℝ} (hr : 0 < r) : ∃ s, 0 < s ∧ s < r ∧ |m| * s < 2 := by
  refine ⟨min (r / 2) (1 / (|m| + 1)), by positivity, lt_of_le_of_lt (min_le_left _ _) (by linarith), ?_⟩
  have h1 : |m| * min (r / 2) (1 / (|m| + 1)) ≤ |m| * (1 / (|m| + 1)) :=
    mul_le_mul_of_nonneg_left (min_le_right _ _) (abs_nonneg m)
  have h2 : |m| * (1 / (|m| + 1)) < 1 := by
    rw [mul_one_div, div_lt_one (by positivity)]; linarith
  linarith

/-- `sin x = 0` and `sin (x + δ) = 0` with `0 < δ < π` cannot both hold. -/
theorem sin_zero_of_two {x δ : ℝ} (hδ0 : 0 < δ) (hδπ : δ < π) (h1 : Real.sin x = 0) (h2 : Real.sin (x + δ) = 0) :
    False := by
  rw [Real.sin_add, h1, zero_mul, zero_add] at h2
  have hs : 0 < Real.sin δ := Real.sin_pos_of_pos_of_lt_pi hδ0 hδπ
  have hc : Real.cos x = 0 := by
    rcases mul_eq_zero.mp h2 with h | h
    · exact h
    · linarith
  have := Real.sin_sq_add_cos_sq x
  rw [h1, hc] at this; norm_num at this

/-- `sin (β − α) = 0` puts `e β` at `e α` or `e (α + π)`. -/
theorem e_eq_or_of_sin_sub_eq_zero {α β : ℝ} (h : Real.sin (β - α) = 0) : e β = e α ∨ e β = e (α + π) := by
  obtain ⟨m, hm⟩ := Real.sin_eq_zero_iff.mp h
  rcases Int.even_or_odd m with ⟨j, hj⟩ | ⟨j, hj⟩
  · left
    have : β = α + 2 * π * j := by rw [hj] at hm; push_cast at hm; linarith
    rw [this, e_add_int_mul]
  · right
    have : β = α + π + 2 * π * j := by rw [hj] at hm; push_cast at hm; linarith
    rw [this, e_add_int_mul]

/-- `dot` is odd in its second argument. -/
theorem dot_neg_right (d u : ℂ) : dot d (-u) = -dot d u := by
  unfold dot; rw [map_neg, mul_neg, Complex.neg_re]

/-- `e (x + π) = −e x`. -/
theorem e_add_pi' (x : ℝ) : e (x + π) = -e x := by
  rw [e_add, show e π = -1 by rw [e_eq]; simp, mul_neg_one]

/-- The dot product against `e α` is the frame's first coordinate at the origin. -/
theorem dot_e_eq_frameX (α : ℝ) (u : ℂ) : dot (e α) u = frameX 0 α u := by
  rw [dot_comm']; unfold dot frameX; rw [sub_zero]

/-- The dot product against `n = e (α + π/2)` is the frame's second coordinate at the origin. -/
theorem dot_e_add_pi_div_two_eq_frameY (α : ℝ) (u : ℂ) : dot (e (α + π / 2)) u = frameY 0 α u := by
  rw [dot_comm']; unfold dot frameY; rw [sub_zero, e_add_pi_div_two, map_mul, Complex.conj_I]
  have : u * (-I * starRingEnd ℂ (e α)) = -I * (u * starRingEnd ℂ (e α)) := by ring
  rw [this]; simp

/-- **A closed set of unit vectors on one side of `e α` that misses `s n` leaves `D` an interior** (the planar step of
FS110-N3-DEG): if every `u ∈ A` has `e α · u ≥ 0` and `s e (α + π/2) ∉ A` (`s = ±1`), the cone `{d : d · u ≥ 0 ∀ u ∈ A}` has
non-empty interior — it holds `e α − (s η/4) n` with a margin. -/
theorem interior_nonempty_of_not_mem {A : Set ℂ} (hA : IsClosed A) (hA1 : ∀ u ∈ A, ‖u‖ = 1) {α s : ℝ}
    (hs : s = 1 ∨ s = -1) (hα : ∀ u ∈ A, 0 ≤ dot (e α) u) (hn : (s : ℂ) * e (α + π / 2) ∉ A) :
    (interior {d : ℂ | ∀ u ∈ A, 0 ≤ dot d u}).Nonempty := by
  obtain ⟨η₀, hη₀, hball⟩ := Metric.isOpen_iff.mp hA.isOpen_compl _ hn
  set η := min η₀ 1 with hη
  have hη0 : 0 < η := lt_min hη₀ one_pos
  have hη1 : η ≤ 1 := min_le_right _ _
  set d : ℂ := e α - ((s * η / 4 : ℝ) : ℂ) * e (α + π / 2) with hd
  have hs2 : s ^ 2 = 1 := by rcases hs with rfl | rfl <;> norm_num
  have key : ∀ u ∈ A, η / 4 ≤ dot d u := by
    intro u hu
    have hu1 := hA1 u hu
    have hfar : η ≤ ‖u - (s : ℂ) * e (α + π / 2)‖ := by
      by_contra h
      push Not at h
      refine hball (show u ∈ ball _ η₀ from ?_) hu
      rw [mem_ball, dist_eq_norm]; exact lt_of_lt_of_le h (min_le_left _ _)
    have hpq : frameX 0 α u ^ 2 + frameY 0 α u ^ 2 = 1 := by
      have := frame_normSq 0 α u; rw [sub_zero, hu1] at this; linarith
    have hfar2 : η ^ 2 ≤ frameX 0 α u ^ 2 + (frameY 0 α u - s) ^ 2 := by
      have := sq_dist_normalPt 0 α s u
      rw [zero_add] at this
      rw [← this]; exact pow_le_pow_left₀ hη0.le hfar 2
    have hp : 0 ≤ frameX 0 α u := by have := hα u hu; rwa [dot_e_eq_frameX] at this
    have hdu : dot d u = frameX 0 α u - η / 4 * (s * frameY 0 α u) := by
      rw [hd, dot_sub, dot_ofReal_mul, dot_e_eq_frameX, dot_e_add_pi_div_two_eq_frameY]; ring
    rw [hdu]
    set p := frameX 0 α u
    set q := s * frameY 0 α u with hq
    have hq2 : q ^ 2 = frameY 0 α u ^ 2 := by rw [hq, mul_pow, hs2, one_mul]
    have hpq' : p ^ 2 + q ^ 2 = 1 := by rw [hq2]; exact hpq
    have hfar' : η ^ 2 ≤ 2 - 2 * q := by
      have : (frameY 0 α u - s) ^ 2 = frameY 0 α u ^ 2 - 2 * q + s ^ 2 := by rw [hq]; ring
      rw [this, hs2] at hfar2; linarith
    rcases le_or_gt q 0 with hq0 | hq0
    · have h1 : 1 ≤ p - q := by nlinarith
      nlinarith
    · have hq1 : q ≤ 1 := by nlinarith
      have hp2 : η ^ 2 / 2 ≤ p ^ 2 := by nlinarith
      have hpη : η / 2 ≤ p := by nlinarith
      nlinarith
  refine ⟨d, mem_interior.mpr ⟨ball d (η / 4), fun d' hd' u hu => ?_, isOpen_ball, mem_ball_self (by positivity)⟩⟩
  have h1 := key u hu
  have h2 : |dot (d' - d) u| ≤ ‖d' - d‖ * ‖u‖ := abs_dot_le _ _
  rw [hA1 u hu, mul_one] at h2
  have h3 : ‖d' - d‖ < η / 4 := by rw [← dist_eq_norm]; exact hd'
  have h4 : dot d' u = dot d u + dot (d' - d) u := by have := dot_sub d' d u; linarith
  rw [h4]
  linarith [(abs_le.mp h2).1]

/-- **A horn meeting no point of `B(N, 1)` has upper curvature at most `1`**. -/
theorem curv_le_one_of_avoid {v : ℂ} {β κ₁ κ₂ r : ℝ} (hr : 0 < r) (hlt : κ₁ < κ₂)
    (hN : ∀ x ∈ hornSet v β κ₁ κ₂ r, 1 ≤ dist x (v + e (β + π / 2))) : κ₂ ≤ 1 := by
  by_contra h
  push Not at h
  set m := (max κ₁ 1 + κ₂) / 2
  have hm1 : κ₁ < m := by have := le_max_left κ₁ 1; simp only [m]; linarith
  have hm2 : m < κ₂ := by have := max_lt hlt h; simp only [m]; linarith
  have hm3 : 1 < m := by have := le_max_right κ₁ 1; simp only [m]; linarith
  obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s m hr
  have hz := branchPt_mem_hornSet v β hm1 hm2 hs0 hsr hsm
  have hA : TanAbove v β 1 (branchPt v β m s) := by
    show 0 < tanHeight _ _ _
    rw [tanHeight_branchPt v β m 1 hsm.le hs0.le]
    have : 0 < s ^ 2 := by positivity
    nlinarith
  rw [tanAbove_one_iff] at hA
  linarith [hN _ hz]

/-- **A horn meeting no point of `B(S′, 1)` has lower curvature at least `−1`**. -/
theorem neg_one_le_curv_of_avoid {v : ℂ} {β κ₁ κ₂ r : ℝ} (hr : 0 < r) (hlt : κ₁ < κ₂)
    (hS : ∀ x ∈ hornSet v β κ₁ κ₂ r, 1 ≤ dist x (v - e (β + π / 2))) : -1 ≤ κ₁ := by
  by_contra h
  push Not at h
  set m := (κ₁ + min κ₂ (-1)) / 2
  have hm1 : κ₁ < m := by have := lt_min hlt h; simp only [m]; linarith
  have hm2 : m < κ₂ := by have := min_le_left κ₂ (-1); simp only [m]; linarith
  have hm3 : m < -1 := by have := min_le_right κ₂ (-1); simp only [m]; linarith
  obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s m hr
  have hz := branchPt_mem_hornSet v β hm1 hm2 hs0 hsr hsm
  have hB : TanBelow v β (-1) (branchPt v β m s) := by
    show tanHeight _ _ _ < 0
    rw [tanHeight_branchPt v β m (-1) hsm.le hs0.le]
    have : 0 < s ^ 2 := by positivity
    nlinarith
  rw [tanBelow_neg_one_iff] at hB
  linarith [hS _ hz]

/-- The branch point is continuous in its curvature. -/
theorem continuous_branchPt_curv (v : ℂ) (β s : ℝ) : Continuous fun m : ℝ => branchPt v β m s := by
  have h0 : Continuous fun m : ℝ => β + Real.arcsin (m * s / 2) :=
    continuous_const.add (Real.continuous_arcsin.comp (by fun_prop))
  have h1 : Continuous fun m : ℝ => e (β + Real.arcsin (m * s / 2)) :=
    Complex.continuous_exp.comp ((Complex.continuous_ofReal.comp h0).mul continuous_const)
  exact continuous_const.add (continuous_const.mul h1)

/-- **The upper bounding arc lies in the horn's closure**: `branchPt v β κ₂ s ∈ cl (hornSet v β κ₁ κ₂ r)` for `0 < s < r`,
`|κ₂| s < 2`. -/
theorem branchPt_mem_closure_hornSet_upper (v : ℂ) (β : ℝ) {κ₁ κ₂ r s : ℝ} (hlt : κ₁ < κ₂) (hs0 : 0 < s) (hsr : s < r)
    (hs : |κ₂| * s < 2) : branchPt v β κ₂ s ∈ closure (hornSet v β κ₁ κ₂ r) := by
  have ht : Filter.Tendsto (fun m : ℝ => branchPt v β m s) (𝓝[<] κ₂) (𝓝 (branchPt v β κ₂ s)) :=
    ((continuous_branchPt_curv v β s).tendsto κ₂).mono_left nhdsWithin_le_nhds
  refine mem_closure_of_tendsto ht ?_
  have hopen : {m : ℝ | |m| * s < 2} ∈ 𝓝 κ₂ :=
    (isOpen_lt (continuous_abs.mul continuous_const) continuous_const).mem_nhds hs
  filter_upwards [Ioo_mem_nhdsLT hlt, nhdsWithin_le_nhds hopen] with m hm hm2
  exact branchPt_mem_hornSet v β hm.1 hm.2 hs0 hsr hm2

/-- **The lower bounding arc lies in the horn's closure**. -/
theorem branchPt_mem_closure_hornSet_lower (v : ℂ) (β : ℝ) {κ₁ κ₂ r s : ℝ} (hlt : κ₁ < κ₂) (hs0 : 0 < s) (hsr : s < r)
    (hs : |κ₁| * s < 2) : branchPt v β κ₁ s ∈ closure (hornSet v β κ₁ κ₂ r) := by
  have ht : Filter.Tendsto (fun m : ℝ => branchPt v β m s) (𝓝[>] κ₁) (𝓝 (branchPt v β κ₁ s)) :=
    ((continuous_branchPt_curv v β s).tendsto κ₁).mono_left nhdsWithin_le_nhds
  refine mem_closure_of_tendsto ht ?_
  have hopen : {m : ℝ | |m| * s < 2} ∈ 𝓝 κ₁ :=
    (isOpen_lt (continuous_abs.mul continuous_const) continuous_const).mem_nhds hs
  filter_upwards [Ioo_mem_nhdsGT hlt, nhdsWithin_le_nhds hopen] with m hm hm2
  exact branchPt_mem_hornSet v β hm.1 hm.2 hs0 hsr hm2

/-- The branch of curvature `1` lies on `ω(N)`. -/
theorem dist_branchPt_one (v : ℂ) (β : ℝ) {s : ℝ} (hs0 : 0 ≤ s) (hs : s ≤ 2) :
    dist (branchPt v β 1 s) (v + e (β + π / 2)) = 1 := by
  have h := sq_dist_N v β (branchPt v β 1 s)
  have ht := tanHeight_branchPt v β 1 1 (s := s) (by rw [abs_one, one_mul]; exact hs) hs0
  unfold tanHeight at ht
  have h2 : dist (branchPt v β 1 s) (v + e (β + π / 2)) ^ 2 = 1 := by rw [h]; nlinarith
  have := dist_nonneg (x := branchPt v β 1 s) (y := v + e (β + π / 2))
  nlinarith

/-- The branch of curvature `−1` lies on `ω(S′)`. -/
theorem dist_branchPt_neg_one (v : ℂ) (β : ℝ) {s : ℝ} (hs0 : 0 ≤ s) (hs : s ≤ 2) :
    dist (branchPt v β (-1) s) (v - e (β + π / 2)) = 1 := by
  have h := sq_dist_S v β (branchPt v β (-1) s)
  have ht := tanHeight_branchPt v β (-1) (-1) (s := s) (by rw [abs_neg, abs_one, one_mul]; exact hs) hs0
  unfold tanHeight at ht
  have h2 : dist (branchPt v β (-1) s) (v - e (β + π / 2)) ^ 2 = 1 := by rw [h]; nlinarith
  have := dist_nonneg (x := branchPt v β (-1) s) (y := v - e (β + π / 2))
  nlinarith

/-- The height above a tangent circle falls as its curvature grows. -/
theorem tanHeight_anti {κ κ' : ℝ} (h : κ ≤ κ') (x y : ℝ) : tanHeight κ' x y ≤ tanHeight κ x y := by
  unfold tanHeight
  nlinarith [sq_nonneg x, sq_nonneg y]

/-- A horn between curvatures inside `[κ₁, κ₂]` lies in the horn between `κ₁` and `κ₂`. -/
theorem hornSet_mono {v : ℂ} {α κ₁ κ₂ s₁ s₂ r : ℝ} (h1 : κ₁ ≤ s₁) (h2 : s₂ ≤ κ₂) :
    hornSet v α s₁ s₂ r ⊆ hornSet v α κ₁ κ₂ r := fun _ ⟨hd, hx, hA, hB⟩ =>
  ⟨hd, hx, lt_of_lt_of_le hA (tanHeight_anti h1 _ _), lt_of_le_of_lt (tanHeight_anti h2 _ _) hB⟩

/-- **A horn approaches its base point along its axis**: `α ∈ coneAt (hornSet v α κ₁ κ₂ r) v`. -/
theorem mem_coneAt_hornSet (v : ℂ) (α : ℝ) {κ₁ κ₂ r : ℝ} (hlt : κ₁ < κ₂) (hr : 0 < r) :
    α ∈ coneAt (hornSet v α κ₁ κ₂ r) v := by
  intro ε hε
  set m := (κ₁ + κ₂) / 2 with hm
  have hm1 : κ₁ < m := by rw [hm]; linarith
  have hm2 : m < κ₂ := by rw [hm]; linarith
  have hcont : Continuous fun s : ℝ => ‖e (α + Real.arcsin (m * s / 2)) - e α‖ := by
    unfold e; fun_prop
  have h0 : ‖e (α + Real.arcsin (m * 0 / 2)) - e α‖ = 0 := by simp
  have hev1 : ∀ᶠ s in 𝓝[>] (0 : ℝ), ‖e (α + Real.arcsin (m * s / 2)) - e α‖ < ε := by
    have hlt : ‖e (α + Real.arcsin (m * 0 / 2)) - e α‖ < ε := by rw [h0]; exact hε
    exact nhdsWithin_le_nhds ((hcont.tendsto 0).eventually (gt_mem_nhds hlt))
  have hev2 : ∀ᶠ s in 𝓝[>] (0 : ℝ), s < min r ε ∧ |m| * s < 2 := by
    have h1 : ∀ᶠ s in 𝓝 (0 : ℝ), s < min r ε := gt_mem_nhds (lt_min hr hε)
    have h2 : ∀ᶠ s in 𝓝 (0 : ℝ), |m| * s < 2 := by
      have : Continuous fun s : ℝ => |m| * s := by fun_prop
      exact (this.tendsto 0).eventually (gt_mem_nhds (by simp))
    exact nhdsWithin_le_nhds (h1.and h2)
  obtain ⟨s, ⟨h1, h2, h3⟩, hs0⟩ := ((hev1.and hev2).and self_mem_nhdsWithin).exists
  have hs0 : (0 : ℝ) < s := hs0
  refine ⟨branchPt v α m s, branchPt_mem_hornSet v α hm1 hm2 hs0 (lt_of_lt_of_le h2 (min_le_left _ _)) h3, ?_, ?_, ?_⟩
  · intro h
    have := norm_branchPt_sub v α m hs0.le
    rw [h, sub_self, norm_zero] at this
    exact hs0.ne this
  · rw [dist_eq_norm, norm_branchPt_sub v α m hs0.le]; exact lt_of_lt_of_le h2 (min_le_right _ _)
  · rw [norm_branchPt_sub v α m hs0.le, branchPt, add_sub_cancel_left]
    have hs' : ((s : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hs0.ne'
    rw [mul_div_cancel_left₀ _ hs']
    exact h1

/-- A horn's points are at most its radius from its base point, and the horn grows with its radius. -/
theorem hornSet_mono_radius {v : ℂ} {α κ₁ κ₂ r r' : ℝ} (h : r ≤ r') : hornSet v α κ₁ κ₂ r ⊆ hornSet v α κ₁ κ₂ r' :=
  fun _ ⟨hd, hx, hA, hB⟩ => ⟨lt_of_lt_of_le hd h, hx, hA, hB⟩

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- A point of a sector's closure inside the ball, not in the sector, is no interior point (the sector is a component). -/
theorem not_mem_interiorPts_of_mem_closure_sector {v : ℂ} {r : ℝ} {S : Set ℂ} (hS : F.IsSector v r S) {p : ℂ}
    (hpr : p ∈ ball v r) (hpS : p ∈ closure S) (hpn : p ∉ S) : p ∉ F.interiorPts := by
  intro hpI
  obtain ⟨x₀, hx₀, rfl, -⟩ := hS
  set U := F.interiorPts ∩ ball v r
  have hU : IsOpen U := F.isOpen_interiorPts.inter isOpen_ball
  obtain ⟨δ, hδ, hδU⟩ := Metric.isOpen_iff.mp hU p ⟨hpI, hpr⟩
  obtain ⟨y, hyS, hyp⟩ := Metric.mem_closure_iff.mp hpS δ hδ
  have hyb : y ∈ ball p δ := by rw [mem_ball, dist_comm]; exact hyp
  have hcy : connectedComponentIn U y = connectedComponentIn U x₀ := (connectedComponentIn_eq hyS).symm
  have hsub : ball p δ ⊆ connectedComponentIn U y :=
    (convex_ball p δ).isPreconnected.subset_connectedComponentIn hyb hδU
  exact hpn (hcy ▸ hsub (mem_ball_self hδ))

/-- Two sectors sharing a point are equal. -/
theorem IsSector.eq_of_mem {v : ℂ} {r : ℝ} {S S' : Set ℂ} (hS : F.IsSector v r S) (hS' : F.IsSector v r S') {z : ℂ}
    (hz : z ∈ S) (hz' : z ∈ S') : S = S' := by
  obtain ⟨x, -, rfl, -⟩ := hS
  obtain ⟨x', -, rfl, -⟩ := hS'
  rw [connectedComponentIn_eq hz, connectedComponentIn_eq hz']

end ArcMap

/-- **A horn approaches its base point only along its axis**: every direction of `hornSet v α κ₁ κ₂ r` at `v` is `α` (mod `2π`). -/
theorem e_eq_of_mem_coneAt_hornSet {v : ℂ} {α κ₁ κ₂ r β : ℝ} (hβ : β ∈ coneAt (hornSet v α κ₁ κ₂ r) v) : e β = e α := by
  set K := |κ₁| + |κ₂| with hK
  have hK0 : 0 ≤ K := by positivity
  -- for every `ε`, the two dot products of `e β` with the frame are within `ε`-bounds
  have hbound : ∀ ε > 0, |dot (e (α + π / 2)) (e β)| ≤ (K / 2 + 1) * ε ∧ -ε ≤ dot (e α) (e β) := by
    intro ε hε
    obtain ⟨z, ⟨hzr, hzx, hzA, hzB⟩, hzne, hzd, hdir⟩ := hβ ε hε
    set a := z - v with ha
    have hr : 0 < ‖a‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzne)
    have hnorm := frame_normSq v α z
    rw [← ha] at hnorm
    have hA' : κ₁ * ‖a‖ ^ 2 / 2 < frameY v α z := by
      have := hzA; unfold TanAbove tanHeight at this; rw [hnorm] at this; linarith
    have hB' : frameY v α z < κ₂ * ‖a‖ ^ 2 / 2 := by
      have := hzB; unfold TanBelow tanHeight at this; rw [hnorm] at this; linarith
    have hy : |frameY v α z| ≤ K * ‖a‖ ^ 2 / 2 := by
      have hsq := sq_nonneg ‖a‖
      have h1 : 0 ≤ (κ₁ + |κ₁|) * ‖a‖ ^ 2 := mul_nonneg (by linarith [neg_abs_le κ₁]) hsq
      have h2 : 0 ≤ (|κ₂| - κ₂) * ‖a‖ ^ 2 := mul_nonneg (by linarith [le_abs_self κ₂]) hsq
      have h3 : 0 ≤ |κ₂| * ‖a‖ ^ 2 := mul_nonneg (abs_nonneg _) hsq
      have h4 : 0 ≤ |κ₁| * ‖a‖ ^ 2 := mul_nonneg (abs_nonneg _) hsq
      have hKe : K * ‖a‖ ^ 2 = |κ₁| * ‖a‖ ^ 2 + |κ₂| * ‖a‖ ^ 2 := by rw [hK]; ring
      rw [abs_le]; constructor <;> nlinarith
    have hfy : dot (e (α + π / 2)) (a / (‖a‖ : ℂ)) = frameY v α z / ‖a‖ := by
      rw [dot_comm', dot_div_ofReal, dot_comm', dot_e_add_pi_div_two_eq_frameY]
      simp [frameY, ha]
    have hfx : dot (e α) (a / (‖a‖ : ℂ)) = frameX v α z / ‖a‖ := by
      rw [dot_comm', dot_div_ofReal, dot_comm', dot_e_eq_frameX]
      simp [frameX, ha]
    have hdiff1 : |dot (e (α + π / 2)) (a / (‖a‖ : ℂ) - e β)| ≤ ε := by
      refine (abs_dot_le _ _).trans ?_
      rw [norm_e, one_mul]; exact hdir.le
    have hdiff2 : |dot (e α) (a / (‖a‖ : ℂ) - e β)| ≤ ε := by
      refine (abs_dot_le _ _).trans ?_
      rw [norm_e, one_mul]; exact hdir.le
    rw [dot_comm' (e (α + π / 2)), dot_sub, dot_comm' _ (e (α + π / 2)), dot_comm' (e β), hfy] at hdiff1
    rw [dot_comm' (e α), dot_sub, dot_comm' _ (e α), dot_comm' (e β), hfx] at hdiff2
    have hya : |frameY v α z / ‖a‖| ≤ K / 2 * ε := by
      rw [abs_div, abs_of_pos hr, div_le_iff₀ hr]
      have hae : ‖a‖ < ε := by rw [ha, ← dist_eq_norm]; exact hzd
      calc |frameY v α z| ≤ K * ‖a‖ ^ 2 / 2 := hy
        _ = K / 2 * ‖a‖ * ‖a‖ := by ring
        _ ≤ K / 2 * ε * ‖a‖ :=
          mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hae.le (by positivity)) hr.le
    have hxa : 0 < frameX v α z / ‖a‖ := div_pos hzx hr
    constructor
    · have h' := abs_sub_abs_le_abs_sub (dot (e (α + π / 2)) (e β)) (frameY v α z / ‖a‖)
      rw [abs_sub_comm] at h'
      have : (K / 2 + 1) * ε = K / 2 * ε + ε := by ring
      linarith
    · have := (abs_le.mp hdiff2).2
      linarith
  have hsin : Real.sin (β - α) = 0 := by
    have h : dot (e (α + π / 2)) (e β) = 0 := by
      by_contra hne
      have hpos : 0 < |dot (e (α + π / 2)) (e β)| := abs_pos.mpr hne
      have := (hbound (|dot (e (α + π / 2)) (e β)| / (2 * (K / 2 + 1))) (by positivity)).1
      have hK1 : 0 < K / 2 + 1 := by positivity
      have heq : (K / 2 + 1) * (|dot (e (α + π / 2)) (e β)| / (2 * (K / 2 + 1))) =
          |dot (e (α + π / 2)) (e β)| / 2 := by field_simp
      linarith
    rw [dot_e_e] at h
    rw [show α + π / 2 - β = π / 2 - (β - α) by ring, Real.cos_pi_div_two_sub] at h
    exact h
  have hcos : 0 ≤ dot (e α) (e β) := by
    by_contra hneg
    rw [not_le] at hneg
    have := (hbound (-dot (e α) (e β) / 2) (by linarith)).2
    linarith
  rcases e_eq_or_of_sin_sub_eq_zero hsin with h | h
  · exact h
  · exfalso
    rw [h, e_add_pi', dot_neg_right, dot_e_e, sub_self, Real.cos_zero] at hcos
    norm_num at hcos


/-- `dot` is negated with its first argument. -/
theorem dot_neg_left (d u : ℂ) : dot (-d) u = -dot d u := by
  rw [dot_comm', dot_neg_right, dot_comm']

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS110-N3-DEG -/

/-- An in-type contact is a closure point of `c`'s class inside `B(v, 1)`, and conversely. -/
theorem inType_iff (hF : F.Valid) {v w : ℂ} {c : Fin k} (hv : F.Covers v 1) (hw : F.IsContact v c w) :
    F.InType v c w ↔ w ∈ closure (F.region c ∩ ball v 1) := by
  have hwdom : w ∈ F.dom := hv (by rw [mem_closedBall, hw.2.1])
  constructor
  · intro hin
    obtain ⟨T, hT, hwT⟩ := (F.mem_coloursAt_iff_exists_tileOf hwdom).mp hw.2.2
    exact closure_mono (show T ⊆ F.region c ∩ ball v 1 from fun x hx => ⟨hT.subset_region hx, hin T hT hwT hx⟩) hwT
  · intro hcl
    rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
    · exact hin
    · exfalso
      obtain ⟨δ, hδ, hδT⟩ := exists_ball_tiles_mem_closure hwdom
      obtain ⟨y, ⟨hyc, hyv⟩, hyw⟩ := Metric.mem_closure_iff.mp hcl δ hδ
      obtain ⟨hTy, hyT⟩ := tileOf_component hyc
      have hwT := hδT _ hTy.1 ⟨y, hyT, by rw [mem_ball, dist_comm]; exact hyw⟩
      exact disjoint_left.mp (hout _ hTy hwT) hyT (ball_subset_closedBall hyv)

/-- An out-type contact is a closure point of `c`'s class outside `B̄(v, 1)`, and conversely. -/
theorem outType_iff (hF : F.Valid) {v w : ℂ} {c : Fin k} (hv : F.Covers v 1) (hw : F.IsContact v c w) :
    F.OutType v c w ↔ w ∈ closure (F.region c \ closedBall v 1) := by
  have hwdom : w ∈ F.dom := hv (by rw [mem_closedBall, hw.2.1])
  constructor
  · intro hout
    obtain ⟨T, hT, hwT⟩ := (F.mem_coloursAt_iff_exists_tileOf hwdom).mp hw.2.2
    exact closure_mono (show T ⊆ F.region c \ closedBall v 1 from fun x hx => ⟨hT.subset_region hx, disjoint_left.mp (hout T hT hwT) hx⟩) hwT
  · intro hcl
    rcases (contact_inType_or_outType hF hv hw).1 with hin | hout
    · exfalso
      obtain ⟨δ, hδ, hδT⟩ := exists_ball_tiles_mem_closure hwdom
      obtain ⟨y, ⟨hyc, hyv⟩, hyw⟩ := Metric.mem_closure_iff.mp hcl δ hδ
      obtain ⟨hTy, hyT⟩ := tileOf_component hyc
      have hwT := hδT _ hTy.1 ⟨y, hyT, by rw [mem_ball, dist_comm]; exact hyw⟩
      exact hyv (ball_subset_closedBall (hin _ hTy hwT hyT))
    · exact hout

/-- **No in-type contacts at both `N` and `S′`**: a `c`-tile at `v` would lie in `B̄(N, 1) ∩ B̄(S′, 1) = {v}` (N-E2). -/
theorem not_inType_both (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) {α : ℝ}
    (hN : F.IsContact v c (v + e (α + π / 2))) (hNi : F.InType v c (v + e (α + π / 2)))
    (hS : F.IsContact v c (v - e (α + π / 2))) (hSi : F.InType v c (v - e (α + π / 2))) : False := by
  have hvdom : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨X, hX, hvX⟩ := (F.mem_coloursAt_iff_exists_tileOf hvdom).mp hN.1
  have key : ∀ w, F.IsContact v c w → F.InType v c w → ∀ x ∈ X, dist x w ≤ 1 := by
    intro w hw hwi x hx
    have hwdom : w ∈ F.dom := hv (by rw [mem_closedBall, hw.2.1])
    obtain ⟨T, hT, hwT⟩ := (F.mem_coloursAt_iff_exists_tileOf hwdom).mp hw.2.2
    obtain ⟨t, ht⟩ := hT.1.nonempty
    have hvt : dist v t < 1 := by rw [dist_comm]; exact hwi T hT hwT ht
    exact UnitNear.dist_le_of_mem_closure (unitNear_of_mem_closure hF hX hT hvX (subset_closure ht) hvt) (subset_closure hx) hwT
  have hpt : ∀ x ∈ X, x = v := by
    intro x hx
    have h1 := key _ hN hNi x hx
    have h2 := key _ hS hSi x hx
    have e1 := sq_dist_N v α x
    have e2 := sq_dist_S v α x
    have e3 := frame_normSq v α x
    have h1' : dist x (v + e (α + π / 2)) ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := x) (y := v + e (α + π / 2))]
    have h2' : dist x (v - e (α + π / 2)) ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := x) (y := v - e (α + π / 2))]
    have : ‖x - v‖ ^ 2 ≤ 0 := by nlinarith
    have : ‖x - v‖ = 0 := by nlinarith [norm_nonneg (x - v)]
    exact sub_eq_zero.mp (norm_eq_zero.mp this)
  obtain ⟨x, hx⟩ := hX.1.nonempty
  obtain ⟨ε, hε, hεX⟩ := Metric.isOpen_iff.mp hX.1.isOpen x hx
  have hx' : x + ((ε / 2 : ℝ) : ℂ) ∈ X := hεX (by
    rw [mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
    linarith)
  have := (hpt _ hx').trans (hpt x hx).symm
  have h0 : ((ε / 2 : ℝ) : ℂ) = 0 := by linear_combination this
  have : ε / 2 = 0 := by exact_mod_cast h0
  linarith

/-- **FS110-N3-DEG's contacts**: if `int D_c(v) = ∅`, then for some axis `α` the colour `c` has out-type contacts at both
`N = v + n` and `S′ = v − n`. -/
theorem woodall_contacts (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) := by
  -- a direction of `c`'s class at `v`
  have hne : ∀ ε > 0, ∃ z ∈ F.region c, z ≠ v ∧ dist z v < ε := by
    intro ε hε
    by_cases hvr : v ∈ F.region c
    · obtain ⟨δ, hδ, hδs⟩ := Metric.isOpen_iff.mp (F.isOpen_region c) v hvr
      have hm : 0 < min ε δ / 2 := by positivity
      have hd : dist (v + ((min ε δ / 2 : ℝ) : ℂ)) v = min ε δ / 2 := by
        rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hm]
      refine ⟨v + ((min ε δ / 2 : ℝ) : ℂ), hδs ?_, ?_, ?_⟩
      · rw [mem_ball, hd]; linarith [min_le_right ε δ]
      · intro h
        have : dist (v + ((min ε δ / 2 : ℝ) : ℂ)) v = 0 := by rw [h, dist_self]
        linarith
      · rw [hd]; linarith [min_le_left ε δ]
    · obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hc ε hε
      exact ⟨z, hz, fun h => hvr (h ▸ hz), by rw [dist_comm]; exact hzd⟩
  obtain ⟨α, hα⟩ := coneAt_nonempty hne
  have hαD := coneAt_subset_allowedCone hF hv hα
  set Win := {w | F.IsContact v c w ∧ F.InType v c w} with hWin
  set Wout := {w | F.IsContact v c w ∧ F.OutType v c w} with hWout
  have hWin' : Win = closure (F.region c) ∩ sphere v 1 ∩ closure (F.region c ∩ ball v 1) := by
    ext w
    constructor
    · rintro ⟨hw, hin⟩; exact ⟨⟨hw.2.2, hw.2.1⟩, (inType_iff hF hv hw).mp hin⟩
    · rintro ⟨⟨h1, h2⟩, h3⟩
      have hw : F.IsContact v c w := ⟨hc, h2, h1⟩
      exact ⟨hw, (inType_iff hF hv hw).mpr h3⟩
  have hWout' : Wout = closure (F.region c) ∩ sphere v 1 ∩ closure (F.region c \ closedBall v 1) := by
    ext w
    constructor
    · rintro ⟨hw, hout⟩; exact ⟨⟨hw.2.2, hw.2.1⟩, (outType_iff hF hv hw).mp hout⟩
    · rintro ⟨⟨h1, h2⟩, h3⟩
      have hw : F.IsContact v c w := ⟨hc, h2, h1⟩
      exact ⟨hw, (outType_iff hF hv hw).mpr h3⟩
  have hcpt : ∀ X : Set ℂ, IsCompact (closure (F.region c) ∩ sphere v 1 ∩ closure X) := fun X =>
    (isCompact_sphere v 1).inter_left isClosed_closure |>.inter_right isClosed_closure
  set A := (fun w => w - v) '' Win ∪ (fun w => v - w) '' Wout with hA
  have hAc : IsCompact A := by
    refine IsCompact.union ?_ ?_
    · rw [hWin']; exact (hcpt _).image (continuous_id.sub continuous_const)
    · rw [hWout']; exact (hcpt _).image (continuous_const.sub continuous_id)
  have hA1 : ∀ u ∈ A, ‖u‖ = 1 := by
    rintro u (⟨w, hw, rfl⟩ | ⟨w, hw, rfl⟩)
    · rw [← dist_eq_norm]; exact hw.1.2.1
    · rw [← dist_eq_norm, dist_comm]; exact hw.1.2.1
  have hAα : ∀ u ∈ A, 0 ≤ dot (e α) u := by
    rintro u (⟨w, hw, rfl⟩ | ⟨w, hw, rfl⟩)
    · exact (hαD w hw.1).1 hw.2
    · have := (hαD w hw.1).2 hw.2
      have h' : dot (e α) (v - w) = -dot (e α) (w - v) := by
        rw [show v - w = -(w - v) by ring, dot_neg_right]
      rw [h']; linarith
  have hAD : {d : ℂ | ∀ u ∈ A, 0 ≤ dot d u} ⊆ F.allowedCone v c := by
    intro d hd w hw
    refine ⟨fun hin => hd _ (Or.inl ⟨w, ⟨hw, hin⟩, rfl⟩), fun hout => ?_⟩
    have := hd _ (Or.inr ⟨w, ⟨hw, hout⟩, rfl⟩)
    have h' : dot d (v - w) = -dot d (w - v) := by
      rw [show v - w = -(w - v) by ring, dot_neg_right]
    rw [h'] at this; linarith
  have hmem : ∀ s : ℝ, (s = 1 ∨ s = -1) → (s : ℂ) * e (α + π / 2) ∈ A := by
    intro s hs
    by_contra h
    obtain ⟨d, hd⟩ := interior_nonempty_of_not_mem hAc.isClosed hA1 hs hAα h
    have := interior_mono hAD hd
    rw [hD] at this
    exact this
  refine ⟨α, ?_⟩
  have h1 := hmem 1 (Or.inl rfl)
  have h2 := hmem (-1) (Or.inr rfl)
  simp only [Complex.ofReal_one, one_mul, Complex.ofReal_neg, neg_one_mul] at h1 h2
  rcases h1 with ⟨w, hw, hwv⟩ | ⟨w, hw, hwv⟩ <;> rcases h2 with ⟨w', hw', hwv'⟩ | ⟨w', hw', hwv'⟩
  · -- in at `N`, in at `S′`
    have e1 : w = v + e (α + π / 2) := by simp only at hwv; rw [← hwv]; ring
    have e2 : w' = v - e (α + π / 2) := by simp only at hwv'; linear_combination hwv'
    subst e1 e2
    exact (not_inType_both hF hv hw.1 hw.2 hw'.1 hw'.2).elim
  · -- in at `N`, out at `N`
    have e1 : w = v + e (α + π / 2) := by simp only at hwv; rw [← hwv]; ring
    have e2 : w' = v + e (α + π / 2) := by simp only at hwv'; linear_combination -hwv'
    subst e1 e2
    exact ((contact_inType_or_outType hF hv hw.1).2 ⟨hw.2, hw'.2⟩).elim
  · -- out at `S′`, in at `S′`
    have e1 : w = v - e (α + π / 2) := by simp only at hwv; linear_combination -hwv
    have e2 : w' = v - e (α + π / 2) := by simp only at hwv'; linear_combination hwv'
    subst e1 e2
    exact ((contact_inType_or_outType hF hv hw.1).2 ⟨hw'.2, hw.2⟩).elim
  · -- out at `S′`, out at `N`
    have e1 : w = v - e (α + π / 2) := by simp only at hwv; linear_combination -hwv
    have e2 : w' = v + e (α + π / 2) := by simp only at hwv'; linear_combination -hwv'
    subst e1 e2
    exact ⟨hw', hw⟩

/-- A sector at `v` lies in a tile of its colour whose closure holds `v`. -/
theorem sector_subset_tile {v : ℂ} {r : ℝ} {c : Fin k} {S : Set ℂ} (hS : S ∈ F.sectorsOf v r c) :
    ∃ X, F.TileOf c X ∧ S ⊆ X ∧ v ∈ closure X := by
  obtain ⟨⟨x, hx, rfl, hvS⟩, hcol⟩ := hS
  have hxI : x ∈ F.interiorPts := hx.1
  have hsub : connectedComponentIn (F.interiorPts ∩ ball v r) x ⊆ connectedComponentIn F.interiorPts x :=
    connectedComponentIn_mono x inter_subset_left
  refine ⟨connectedComponentIn F.interiorPts x, ?_, hsub, closure_mono hsub hvS⟩
  have hT : F.IsTile (connectedComponentIn F.interiorPts x) := ⟨x, hxI, rfl⟩
  have hc : F.col x = c := hcol (mem_connectedComponentIn hx)
  have := hT.tileOf (mem_connectedComponentIn hxI)
  rwa [hc] at this

/-- **A sector whose directions all lie on the line `±a` is a horn along it** (in a chart at `v`): it is
`hornSet v β κ₁ κ₂ r` with `κ₁ < κ₂` and `β` a direction of it. -/
theorem IsSectorChart.horn_of_cone_sin {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {r : ℝ} (hr : r ∈ Ioc 0 r₀) {S : Set ℂ} (hS : F.IsSector v r S) {α : ℝ}
    (hcone : ∀ β ∈ coneAt S v, Real.sin (β - α) = 0) :
    ∃ β κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v β κ₁ κ₂ r ∧ β ∈ coneAt S v := by
  have hπ := Real.pi_pos
  rcases Nat.eq_zero_or_pos n with hn | hn
  · exfalso
    rw [(hC.isSector_iff_of_zero hn hr).mp hS, coneAt_ball_self v hr.1] at hcone
    have := hcone (α + π / 2) (mem_univ _)
    rw [show α + π / 2 - α = π / 2 by ring, Real.sin_pi_div_two] at this
    norm_num at this
  · obtain ⟨i, rfl⟩ := (hC.isSector_iff hn hr).mp hS
    rw [hC.cone r hr i] at hcone ⊢
    rcases hC.sorted.2 i with hlt | ⟨heq, hκ⟩
    · exfalso
      set δ := min ((G.nextβ i - G.β i) / 2) (π / 2) with hδ
      have hδ0 : 0 < δ := lt_min (by linarith) (by linarith)
      have hδπ : δ < π := lt_of_le_of_lt (min_le_right _ _) (by linarith)
      have hδn : G.β i + δ ≤ G.nextβ i := by have := min_le_left ((G.nextβ i - G.β i) / 2) (π / 2); linarith
      have h1 := hcone (G.β i) (Icc_subset_angleIcc _ _ ⟨le_rfl, hlt.le⟩)
      have h2 := hcone (G.β i + δ) (Icc_subset_angleIcc _ _ ⟨by linarith, hδn⟩)
      rw [show G.β i + δ - α = (G.β i - α) + δ by ring] at h2
      exact sin_zero_of_two hδ0 hδπ h1 h2
    · refine ⟨G.β i, G.κ i, G.nextκ i, hκ, ?_, Icc_subset_angleIcc _ _ ⟨le_rfl, heq.le⟩⟩
      have h1 : |G.κ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv i).le
      have h2 : |G.nextκ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next i).le
      show sectorBetween v (G.β i) (G.κ i) (G.nextβ i) (G.nextκ i) r = _
      rw [← heq]
      exact sectorBetween_eq_hornSet v _ _ _ r h1 h2

/-- A `c`-tile at `v` keeps distance at least `1` from an out-type contact of `c` at `v` (N-E2: the tiles are far). -/
theorem one_le_dist_of_outType (hF : F.Valid) {v w : ℂ} {c : Fin k} (hv : F.Covers v 1) (hw : F.IsContact v c w)
    (hwo : F.OutType v c w) {X : Set ℂ} (hX : F.TileOf c X) (hvX : v ∈ closure X) {x : ℂ} (hx : x ∈ X) :
    1 ≤ dist x w := by
  have hwdom : w ∈ F.dom := hv (by rw [mem_closedBall, hw.2.1])
  obtain ⟨T, hT, hwT⟩ := (F.mem_coloursAt_iff_exists_tileOf hwdom).mp hw.2.2
  obtain ⟨t, ht⟩ := hT.1.nonempty
  have hvt : 1 < dist v t := by
    have := disjoint_left.mp (hwo T hT hwT) ht
    rw [mem_closedBall, not_le] at this
    rwa [dist_comm]
  exact UnitFar.one_le_dist_of_mem_closure (unitFar_of_mem_closure hF hX hT hvX (subset_closure ht) hvt)
    (subset_closure hx) hwT

/-- **A branch of `Γ` at `v` lying on a unit circle contradicts Condition 5**: if the points `branchPt v β κ s`, `0 < s < r`, are
off the interior points and on `ω(q)`, inside a ball about `v` met by finitely many arcs, Condition 5 fails. -/
theorem false_of_branch_on_sphere (h5 : F.Condition5) {v q : ℂ} {β κ r ε : ℝ} (hr : 0 < r) (hrε : r ≤ ε)
    (hεd : ball v ε ⊆ F.dom) (hfin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball v ε).Nonempty}.Finite)
    (hΓ : ∀ s ∈ Ioo 0 r, branchPt v β κ s ∉ F.interiorPts) (hsph : ∀ s ∈ Ioo 0 r, branchPt v β κ s ∈ sphere q 1) :
    False := by
  set P := (fun s => branchPt v β κ s) '' Ioo 0 r
  have hinj : InjOn (fun s => branchPt v β κ s) (Ioo 0 r) := by
    intro s hs s' hs' h
    have := congrArg (fun z => ‖z - v‖) h
    simp only at this
    rwa [norm_branchPt_sub v β κ hs.1.le, norm_branchPt_sub v β κ hs'.1.le] at this
  have hPinf : P.Infinite := (Set.Ioo_infinite hr).image hinj
  have hPsub : P ⊆ ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball v ε).Nonempty}, a.carrier ∩ F.dom ∩ sphere q 1 := by
    rintro _ ⟨s, hs, rfl⟩
    have hball : branchPt v β κ s ∈ ball v ε := by
      rw [mem_ball, dist_eq_norm, norm_branchPt_sub v β κ hs.1.le]; linarith [hs.2]
    have hdom : branchPt v β κ s ∈ F.dom := hεd hball
    have harc : branchPt v β κ s ∈ ⋃ a ∈ F.arcs, a.carrier := by
      by_contra h; exact hΓ s hs ⟨hdom, h⟩
    obtain ⟨a, ha, hpa⟩ := mem_iUnion₂.mp harc
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, _, hpa, hball⟩, ⟨hpa, hdom⟩, hsph s hs⟩
  exact hPinf ((hfin.biUnion fun a ha => h5 a ha.1 q).subset hPsub)

/-- **FS110-N3-DEG**, the cone with unit arcs allowed: if `int D_c(v)` is empty then for some axis `α` the colour `c` has
out-type contacts at both `v ± n`, and every `c`-sector at `v` is a cusp horn along `±a` with bounding curvatures in
`[−1, 1]`. -/
theorem woodallCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 ≤ κ₁ ∧ κ₁ < κ₂ ∧ κ₂ ≤ 1 ∧ S = hornSet v β κ₁ κ₂ r := by
  have hvdom : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨α, ⟨hNc, hNo⟩, ⟨hSc, hSo⟩⟩ := woodall_contacts hF hv hc hD
  refine ⟨α, ⟨hNc, hNo⟩, ⟨hSc, hSo⟩, ?_⟩
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hvdom
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
  intro S hS
  obtain ⟨X, hX, hSX, hvX⟩ := sector_subset_tile hS
  have hSN : ∀ x ∈ S, 1 ≤ dist x (v + e (α + π / 2)) := fun x hx =>
    one_le_dist_of_outType hF hv hNc hNo hX hvX (hSX hx)
  have hSS : ∀ x ∈ S, 1 ≤ dist x (v - e (α + π / 2)) := fun x hx =>
    one_le_dist_of_outType hF hv hSc hSo hX hvX (hSX hx)
  have hcone : ∀ β ∈ coneAt S v, Real.sin (β - α) = 0 := by
    intro β hβ
    have h1 := dot_nonpos_of_coneAt_subset hβ hNc.2.1 hSN
    have h2 := dot_nonpos_of_coneAt_subset hβ hSc.2.1 hSS
    rw [add_sub_cancel_left, dot_e_e] at h1
    rw [show v - e (α + π / 2) - v = -e (α + π / 2) by ring, dot_neg_right, dot_e_e] at h2
    have : Real.cos (β - (α + π / 2)) = Real.sin (β - α) := by
      rw [show β - (α + π / 2) = (β - α) - π / 2 by ring, Real.cos_sub_pi_div_two]
    linarith
  obtain ⟨β, κ₁, κ₂, hlt, hSeq, hβ⟩ := hC.horn_of_cone_sin hr hS.1 hcone
  have hr0 : 0 < r := hr.1
  rcases e_eq_or_of_sin_sub_eq_zero (hcone β hβ) with he | he
  · rw [hornSet_congr he] at hSeq
    subst hSeq
    exact ⟨α, Or.inl rfl, κ₁, κ₂, neg_one_le_curv_of_avoid hr0 hlt hSS, hlt, curv_le_one_of_avoid hr0 hlt hSN, rfl⟩
  · rw [hornSet_congr he] at hSeq
    subst hSeq
    have hn' : e (α + π + π / 2) = -e (α + π / 2) := by
      rw [show α + π + π / 2 = (α + π / 2) + π by ring, e_add_pi']
    refine ⟨α + π, Or.inr rfl, κ₁, κ₂, ?_, hlt, ?_, rfl⟩
    · refine neg_one_le_curv_of_avoid (v := v) (β := α + π) hr0 hlt fun x hx => ?_
      rw [hn', sub_neg_eq_add]; exact hSN x hx
    · refine curv_le_one_of_avoid (v := v) (β := α + π) hr0 hlt fun x hx => ?_
      rw [hn', ← sub_eq_add_neg]; exact hSS x hx

/-- **FS110-N3-DEG** as filed (Condition 5): the bounding curvatures of Woodall's cone lie in the open interval `(−1, 1)`. -/
theorem woodallCone_strict (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} {c : Fin k} (hv : F.Covers v 1)
    (hc : c ∈ F.coloursAt v) (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 < κ₁ ∧ κ₁ < κ₂ ∧ κ₂ < 1 ∧ S = hornSet v β κ₁ κ₂ r := by
  have hvdom : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  obtain ⟨α, hN, hS, hev⟩ := woodallCone hF hv hc hD
  refine ⟨α, hN, hS, ?_⟩
  obtain ⟨ε, hε, hεd, hfin⟩ := F.exists_ball_finite hvdom
  filter_upwards [hev, Ioc_mem_nhdsGT (lt_min hε one_pos)] with r hr hrε
  intro S hSmem
  obtain ⟨β, hβ, κ₁, κ₂, h1, hlt, h2, rfl⟩ := hr S hSmem
  have hr0 : 0 < r := hrε.1
  have hrε' : r ≤ ε := hrε.2.trans (min_le_left _ _)
  have hr1 : r ≤ 1 := hrε.2.trans (min_le_right _ _)
  have hsec := hSmem.1
  refine ⟨β, hβ, κ₁, κ₂, lt_of_le_of_ne h1 ?_, hlt, lt_of_le_of_ne h2 ?_, rfl⟩
  · -- `κ₁ = −1`: the lower arc lies on `ω(S′)` and in `Γ`
    intro heq
    subst heq
    refine false_of_branch_on_sphere h5 (κ := -1) (β := β) (q := v - e (β + π / 2)) hr0 hrε' hεd hfin
      (fun s hs => ?_) (fun s hs => ?_)
    · have hs2 : |(-1 : ℝ)| * s < 2 := by rw [abs_neg, abs_one, one_mul]; linarith [hs.2]
      refine not_mem_interiorPts_of_mem_closure_sector hsec ?_
        (branchPt_mem_closure_hornSet_lower v β hlt hs.1 hs.2 hs2) ?_
      · rw [mem_ball, dist_eq_norm, norm_branchPt_sub v β _ hs.1.le]; exact hs.2
      · rintro ⟨-, -, hA, -⟩
        have : tanHeight (-1) (frameX v β (branchPt v β (-1) s)) (frameY v β (branchPt v β (-1) s)) = 0 := by
          rw [tanHeight_branchPt v β (-1) (-1) hs2.le hs.1.le]; ring
        exact (ne_of_gt hA) this
    · rw [mem_sphere]; exact dist_branchPt_neg_one v β hs.1.le (by linarith [hs.2])
  · -- `κ₂ = 1`: the upper arc lies on `ω(N)` and in `Γ`
    intro heq
    subst heq
    refine false_of_branch_on_sphere h5 (κ := 1) (β := β) (q := v + e (β + π / 2)) hr0 hrε' hεd hfin
      (fun s hs => ?_) (fun s hs => ?_)
    · have hs2 : |(1 : ℝ)| * s < 2 := by rw [abs_one, one_mul]; linarith [hs.2]
      refine not_mem_interiorPts_of_mem_closure_sector hsec ?_
        (branchPt_mem_closure_hornSet_upper v β hlt hs.1 hs.2 hs2) ?_
      · rw [mem_ball, dist_eq_norm, norm_branchPt_sub v β _ hs.1.le]; exact hs.2
      · rintro ⟨-, -, -, hB⟩
        have : tanHeight 1 (frameX v β (branchPt v β 1 s)) (frameY v β (branchPt v β 1 s)) = 0 := by
          rw [tanHeight_branchPt v β 1 1 hs2.le hs.1.le]; ring
        exact (ne_of_lt hB) this
    · rw [mem_sphere]; exact dist_branchPt_one v β hs.1.le (by linarith [hs.2])

/-- A horn depends on its axis only through `e α`. -/
theorem IsHorn.congr {v : ℂ} {α α' κ₁ κ₂ : ℝ} {c : Fin k} (h : e α = e α') (hH : F.IsHorn v α κ₁ κ₂ c) :
    F.IsHorn v α' κ₁ κ₂ c := by
  obtain ⟨hlt, hev⟩ := hH
  refine ⟨hlt, ?_⟩
  filter_upwards [hev] with r hr
  rw [← hornSet_congr h κ₁ κ₂ r]
  exact hr

/-- A horn lies, near `v`, in the class of its colour. -/
theorem IsHorn.eventually_subset_region {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ κ₂ r ⊆ F.region c := by
  filter_upwards [hH.2] with r hr
  obtain ⟨⟨x, -, hS, -⟩, hcol⟩ := hr
  intro z hz
  refine ⟨?_, hcol hz⟩
  have : z ∈ connectedComponentIn (F.interiorPts ∩ ball v r) x := hS ▸ hz
  exact (connectedComponentIn_subset _ _ this).1

/-- **A horn's axis is a direction of its colour's class** at `v`. -/
theorem IsHorn.mem_coneAt_region {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) :
    α ∈ coneAt (F.region c) v := by
  obtain ⟨r, hr, hr0⟩ := (hH.eventually_subset_region.and self_mem_nhdsWithin).exists
  exact coneAt_mono hr v (mem_coneAt_hornSet v α hH.1 hr0)

/-- **Every colour has a number of sectors** at a point of the domain (constant for small radii, from the sector chart). -/
theorem exists_hasSectors {x : ℂ} (hx : x ∈ F.dom) (c : Fin k) : ∃ n : ℕ, F.HasSectors x c n := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hx
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  rcases Nat.eq_zero_or_pos n with hn | hn
  · -- the ball is the one sector, of the colour of `x`
    have hball : ball x r₀ ⊆ F.interiorPts := hC.empty hn
    have hcolb : ∀ r ∈ Ioc 0 r₀, ∀ z ∈ ball x r, F.col z = F.col x := fun r hr z hz =>
      (convex_ball x r₀).isPreconnected.constant (F.continuousOn_col.mono hball)
        (ball_subset_ball hr.2 hz) (mem_ball_self hC.pos)
    by_cases hcx : F.col x = c
    · refine ⟨1, ?_⟩
      filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
      have : F.sectorsOf x r c = {ball x r} := by
        ext S
        simp only [sectorsOf, mem_setOf_eq, mem_singleton_iff]
        rw [hC.isSector_iff_of_zero hn hr]
        refine ⟨fun h => h.1, ?_⟩
        rintro rfl
        exact ⟨rfl, fun z hz => (hcolb r hr z hz).trans hcx⟩
      rw [this, encard_singleton]; rfl
    · refine ⟨0, ?_⟩
      filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
      have : F.sectorsOf x r c = ∅ := by
        ext S
        simp only [sectorsOf, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
        intro hS hsub
        rw [hC.isSector_iff_of_zero hn hr] at hS
        subst hS
        exact hcx (hsub (mem_ball_self hr.1))
      rw [this, encard_empty]; rfl
  · choose p hp using fun i => hC.sector_nonempty hr₀ i
    have hmono : ∀ r ∈ Ioc 0 r₀, ∀ i, G.sector x r i ⊆ G.sector x r₀ i := by
      rintro r hr i z ⟨s, hs, φ, hφ, rfl⟩
      exact ⟨s, ⟨hs.1, hs.2.trans_le hr.2⟩, φ, hφ, rfl⟩
    have hcol : ∀ i, ∀ z ∈ G.sector x r₀ i, F.col z = F.col (p i) := fun i z hz =>
      (hC.isPreconnected r₀ hr₀ i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ i)) hz (hp i)
    refine ⟨(Finset.univ.filter fun i => F.col (p i) = c).card, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have hset : F.sectorsOf x r c = (fun i => G.sector x r i) '' ↑(Finset.univ.filter fun i => F.col (p i) = c) := by
      ext S
      simp only [sectorsOf, mem_setOf_eq, Finset.coe_filter, Finset.mem_univ, true_and, mem_image]
      rw [hC.isSector_iff hn hr]
      constructor
      · rintro ⟨⟨i, rfl⟩, hsub⟩
        obtain ⟨q, hq⟩ := hC.sector_nonempty hr i
        exact ⟨i, by rw [← hcol i q (hmono r hr i hq)]; exact hsub hq, rfl⟩
      · rintro ⟨i, hi, rfl⟩
        exact ⟨⟨i, rfl⟩, fun z hz => (hcol i z (hmono r hr i hz)).trans hi⟩
    rw [hset, (injective_of_disjoint (hC.disjoint r hr) (hC.sector_nonempty hr)).encard_image,
      Set.encard_coe_eq_coe_finsetCard]

/-- **The axis of a given horn of a two-horn colour** (the step under N4-STUCK (i)): if `c` has exactly two sectors at `v`, horns
along `α₀` and `α₀ + π`, every `c`-horn at `v` lies along one of them. -/
theorem e_eq_or_of_two_horns {v : ℂ} {c : Fin k} {α α₀ κ₁ κ₂ κ₁' κ₂' κ₃ κ₄ : ℝ} (hc2 : F.HasSectors v c 2)
    (hH0 : F.IsHorn v α₀ κ₁' κ₂' c) (hH1 : F.IsHorn v (α₀ + π) κ₃ κ₄ c) (hH : F.IsHorn v α κ₁ κ₂ c) :
    e α = e α₀ ∨ e α = e (α₀ + π) := by
  obtain ⟨r, ⟨⟨⟨⟨hs0, hc0⟩, ⟨hs1, hc1⟩⟩, ⟨hs, hcc⟩⟩, h2⟩, hr⟩ :=
    ((((hH0.2.and hH1.2).and hH.2).and hc2).and self_mem_nhdsWithin).exists
  have hr0 : (0 : ℝ) < r := hr
  have hA : hornSet v α₀ κ₁' κ₂' r ∈ F.sectorsOf v r c := ⟨hs0, hc0⟩
  have hB : hornSet v (α₀ + π) κ₃ κ₄ r ∈ F.sectorsOf v r c := ⟨hs1, hc1⟩
  have hC : hornSet v α κ₁ κ₂ r ∈ F.sectorsOf v r c := ⟨hs, hcc⟩
  have hAB : hornSet v α₀ κ₁' κ₂' r ≠ hornSet v (α₀ + π) κ₃ κ₄ r := by
    intro h
    have h1 := mem_coneAt_hornSet v α₀ hH0.1 hr0
    rw [h] at h1
    have h2 := e_eq_of_mem_coneAt_hornSet h1
    rw [e_add_pi'] at h2
    have : e α₀ = 0 := by linear_combination h2 / 2
    have hn := norm_e α₀
    rw [this, norm_zero] at hn
    exact zero_ne_one hn
  have h2' : (F.sectorsOf v r c).encard = 2 := by rw [h2]; rfl
  obtain ⟨x, y, -, hset⟩ := Set.encard_eq_two.mp h2'
  rw [hset] at hA hB hC
  simp only [mem_insert_iff, mem_singleton_iff] at hA hB hC
  have hCAB : hornSet v α κ₁ κ₂ r = hornSet v α₀ κ₁' κ₂' r ∨ hornSet v α κ₁ κ₂ r = hornSet v (α₀ + π) κ₃ κ₄ r := by
    rcases hA with hA | hA <;> rcases hB with hB | hB <;> rcases hC with hC | hC <;>
      first
        | exact Or.inl (hC.trans hA.symm)
        | exact Or.inr (hC.trans hB.symm)
        | exact absurd (hA.trans hB.symm) hAB
  have hα := mem_coneAt_hornSet v α hH.1 hr0
  rcases hCAB with h | h
  · rw [h] at hα; exact Or.inl (e_eq_of_mem_coneAt_hornSet hα)
  · rw [h] at hα; exact Or.inr (e_eq_of_mem_coneAt_hornSet hα)

/-- A plane map covers every disc. -/
theorem covers_of_isPlaneMap (hP : F.IsPlaneMap) (x : ℂ) (R : ℝ) : F.Covers x R := by
  intro z _; rw [hP]; trivial

/-- **Two `c`-horns on one ray sharing their bounding arc can be shaved** (SHAVE with upper flank `c`): if the `c`-horn between the
curvatures `κ₁ < κ₂` has the `c`-horn between `κ₂ < κ₃` directly above it and some lower flank `h`, SHAVE is available at `v`, at
`σ = κ₁` — the whole tip is the upper part, clear for `c` because it is `c`'s own class in a valid map. So a stuck vertex has no two
adjacent `c`-horns along one ray (the case `RayAvailable`, which needs a gap `κ₂ < κ₃`, does not cover). No model of all three hypotheses at once is held: it is a step inside N4-STUCK (i)'s proof by
contradiction (finding 1 of `plans/FS131-IC-implementation.md` Stage 5). -/
theorem shaveAvailable_of_adjacent_horns (hF : F.Valid) {v : ℂ} {α κ₁ κ₂ κ₃ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₂ κ₃ c) (hh : F.IsFlankBelow v α κ₁ h) : F.ShaveAvailable v := by
  refine ⟨c, c, h, α, κ₁, κ₂, κ₁, hH, ⟨κ₃, hH'.1, hH'.eventually_subset_region⟩, hh, le_rfl, hH.1.le, ?_⟩
  filter_upwards [hH.eventually_subset_region] with r hr z hz
  refine ⟨fun _ y hy hzy => ?_, fun hA => absurd hz.2.2.1 hA⟩
  have hzr := hr hz
  exact hF z hzr.1 y hy.1 hzy (hzr.2.trans hy.2.symm)

end ArcMap

/-! ## N4-FLANK's mechanism: where a horn's shadow comes from

Children of `flank_shadows` and of `stuck_structure` (FS131-IC3), each a step of N4-FLANK's proof (`plans/FS110-N-proof.md` § 2.2); the frame
lemmas are real arithmetic. No model of all of a step's hypotheses at once is held: the bowtie's flanks (`bowtie_flanks`, on `fs131-w4`) sit
at curvature `±1`, outside the strict range `(−1, 1)` the steps read, which is N4-FLANK's own setting. -/

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

/-! ## A horn's chart sector and its flanks (children of `stuck_structure` (i); FS131-IC2's findings 1–2) -/

/-- A branch point of curvature `m ≥ κ` is not below the arc of curvature `κ`. -/
theorem not_tanBelow_branchPt {v : ℂ} {β m κ s : ℝ} (hs : |m| * s ≤ 2) (hs0 : 0 ≤ s) (hm : κ ≤ m) :
    ¬ TanBelow v β κ (branchPt v β m s) := by
  unfold TanBelow
  rw [tanHeight_branchPt v β m κ hs hs0]
  have : 0 ≤ s ^ 2 * (m - κ) := mul_nonneg (sq_nonneg s) (by linarith)
  exact not_lt.mpr (by linarith)

/-- A branch point of curvature `m ≤ κ` is not above the arc of curvature `κ`. -/
theorem not_tanAbove_branchPt {v : ℂ} {β m κ s : ℝ} (hs : |m| * s ≤ 2) (hs0 : 0 ≤ s) (hm : m ≤ κ) :
    ¬ TanAbove v β κ (branchPt v β m s) := by
  unfold TanAbove
  rw [tanHeight_branchPt v β m κ hs hs0]
  have : s ^ 2 * (m - κ) ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (sq_nonneg s) (by linarith)
  exact not_lt.mpr (by linarith)

/-- **A horn determines its curvatures**: `hornSet v α κ₁ κ₂ r = hornSet v α κ₁' κ₂' r` with `κ₁ < κ₂`, `κ₁' < κ₂'` and `r > 0`
gives `κ₁ = κ₁'` and `κ₂ = κ₂'` (a branch point of an intermediate curvature separates two different horns). -/
theorem hornSet_curv_eq {v : ℂ} {α κ₁ κ₂ κ₁' κ₂' r : ℝ} (h : κ₁ < κ₂) (h' : κ₁' < κ₂') (hr : 0 < r)
    (heq : hornSet v α κ₁ κ₂ r = hornSet v α κ₁' κ₂' r) : κ₁ = κ₁' ∧ κ₂ = κ₂' := by
  have key : ∀ {a₁ a₂ b₁ b₂ : ℝ}, a₁ < a₂ → b₁ < b₂ → hornSet v α a₁ a₂ r = hornSet v α b₁ b₂ r →
      a₂ ≤ b₂ ∧ b₁ ≤ a₁ := by
    intro a₁ a₂ b₁ b₂ ha hb he
    constructor
    · by_contra hlt
      push Not at hlt
      have hmax : max a₁ b₂ < a₂ := max_lt ha hlt
      have hm1 : a₁ < (max a₁ b₂ + a₂) / 2 := by have := le_max_left a₁ b₂; linarith
      have hm2 : (max a₁ b₂ + a₂) / 2 < a₂ := by linarith
      have hm3 : b₂ ≤ (max a₁ b₂ + a₂) / 2 := by have := le_max_right a₁ b₂; linarith
      obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s ((max a₁ b₂ + a₂) / 2) hr
      have hp := branchPt_mem_hornSet v α hm1 hm2 hs0 hsr hsm
      rw [he] at hp
      exact not_tanBelow_branchPt hsm.le hs0.le hm3 hp.2.2.2
    · by_contra hlt
      push Not at hlt
      have hmin : a₁ < min b₁ a₂ := lt_min hlt ha
      have hm1 : a₁ < (a₁ + min b₁ a₂) / 2 := by linarith
      have hm2 : (a₁ + min b₁ a₂) / 2 < a₂ := by have := min_le_right b₁ a₂; linarith
      have hm3 : (a₁ + min b₁ a₂) / 2 ≤ b₁ := by have := min_le_left b₁ a₂; linarith
      obtain ⟨s, hs0, hsr, hsm⟩ := exists_small_s ((a₁ + min b₁ a₂) / 2) hr
      have hp := branchPt_mem_hornSet v α hm1 hm2 hs0 hsr hsm
      rw [he] at hp
      exact not_tanAbove_branchPt hsm.le hs0.le hm3 hp.2.2.1
  obtain ⟨h1, h2⟩ := key h h' heq
  obtain ⟨h3, h4⟩ := key h' h heq.symm
  exact ⟨le_antisymm h4 h2, le_antisymm h1 h3⟩

/-- `e (α + π) ≠ e α`. -/
theorem e_add_pi_ne (α : ℝ) : e (α + π) ≠ e α := by
  intro h
  rw [e_add_pi'] at h
  have h0 : e α = 0 := by linear_combination -h / 2
  have hn := norm_e α
  rw [h0, norm_zero] at hn
  exact zero_ne_one hn

/-- `arcsin` is small near `0`: for `d > 0` there is `η > 0` with `|arcsin x| < d` when `|x| < η`. -/
theorem exists_abs_arcsin_lt {d : ℝ} (hd : 0 < d) : ∃ η > 0, ∀ x : ℝ, |x| < η → |Real.arcsin x| < d := by
  obtain ⟨η, hη, hηa⟩ := Metric.continuousAt_iff.mp Real.continuous_arcsin.continuousAt d hd
  refine ⟨η, hη, fun x hx => ?_⟩
  have := @hηa x (by rw [Real.dist_eq, sub_zero]; exact hx)
  rwa [Real.dist_eq, Real.arcsin_zero, sub_zero] at this

/-- A curvature times a radius below `η/(|κ| + 1)` halves to below `η`. -/
theorem abs_half_lt {κ s η : ℝ} (hη : 0 < η) (hs0 : 0 < s) (hs : s < η / (|κ| + 1)) : |κ * s / 2| < η := by
  have h1 : 0 < |κ| + 1 := by positivity
  have h2 : s * (|κ| + 1) < η := (lt_div_iff₀ h1).mp hs
  rw [abs_div, abs_mul, abs_of_pos hs0, abs_two]
  nlinarith [abs_nonneg κ]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A horn's chart sector** (child of `stuck_structure` (i) and of `IsHorn.exists_flankAbove`): in a sector chart at `v`, a
horn along `e α` between `κ₁ < κ₂` is the sector after a germ `i` of direction `α` (mod `2π`) and curvature `κ₁`, whose next germ
has the same direction and curvature `κ₂`. -/
theorem IsHorn.exists_chart_index {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) {n : ℕ}
    {G : BranchGerms n} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) :
    ∃ i : Fin n, e (G.β i) = e α ∧ G.nextβ i = G.β i ∧ G.κ i = κ₁ ∧ G.nextκ i = κ₂ := by
  obtain ⟨r, ⟨hS, -⟩, hr⟩ := (hH.2.and (Ioc_mem_nhdsGT hC.pos)).exists
  have hr0 : 0 < r := hr.1
  have hcone1 : ∀ β ∈ coneAt (hornSet v α κ₁ κ₂ r) v, e β = e α := fun β hβ => e_eq_of_mem_coneAt_hornSet hβ
  rcases Nat.eq_zero_or_pos n with hn | hn
  · exfalso
    have hball := (hC.isSector_iff_of_zero hn hr).mp hS
    have hmem : α + π ∈ coneAt (hornSet v α κ₁ κ₂ r) v := by rw [hball, coneAt_ball_self v hr0]; trivial
    exact e_add_pi_ne α (hcone1 _ hmem)
  obtain ⟨i, hi⟩ := (hC.isSector_iff hn hr).mp hS
  have hconei := hC.cone r hr i
  rw [← hi] at hconei
  have hβi : e (G.β i) = e α :=
    hcone1 _ (by rw [hconei]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩)
  rcases hC.sorted.2 i with hlt | ⟨heq, hκ⟩
  · exfalso
    have hd : 0 < G.nextβ i - G.β i := sub_pos.mpr hlt
    have hε0 : 0 < min (G.nextβ i - G.β i) π / 2 := by have := lt_min hd Real.pi_pos; positivity
    have hεπ : min (G.nextβ i - G.β i) π / 2 < π := by
      have := min_le_right (G.nextβ i - G.β i) π; linarith [Real.pi_pos]
    have hmem : G.β i + min (G.nextβ i - G.β i) π / 2 ∈ coneAt (hornSet v α κ₁ κ₂ r) v := by
      rw [hconei]
      refine Icc_subset_angleIcc _ _ ⟨by linarith, ?_⟩
      have := min_le_left (G.nextβ i - G.β i) π; linarith
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp ((hcone1 _ hmem).trans hβi.symm)
    have hm1 : (0 : ℝ) < m := by nlinarith [Real.pi_pos]
    have hm2 : (m : ℝ) < 1 := by nlinarith [Real.pi_pos]
    have : (0 : ℤ) < m := by exact_mod_cast hm1
    have : m < 1 := by exact_mod_cast hm2
    omega
  · have h1 : |G.κ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv i).le
    have h2 : |G.nextκ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next i).le
    have hsec : G.sector v r i = hornSet v α (G.κ i) (G.nextκ i) r := by
      show sectorBetween v (G.β i) (G.κ i) (G.nextβ i) (G.nextκ i) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβi]
    rw [hsec] at hi
    obtain ⟨hk1, hk2⟩ := hornSet_curv_eq hH.1 hκ hr0 hi
    exact ⟨i, hβi, heq.symm, hk1.symm, hk2.symm⟩

/-- **A chart sector lies in one colour's class**, at every radius up to the chart's. -/
theorem IsSectorChart.exists_col {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (j : Fin n) : ∃ g, ∀ r ∈ Ioc 0 r₀, G.sector v r j ⊆ F.region g := by
  have hn : 0 < n := j.pos
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  obtain ⟨p, hp⟩ := hC.sector_nonempty hr₀ j
  refine ⟨F.col p, fun r hr z hz => ?_⟩
  have hmono : G.sector v r j ⊆ G.sector v r₀ j := by
    rintro w ⟨s, hs, φ, hφ, rfl⟩
    exact ⟨s, ⟨hs.1, hs.2.trans_le hr.2⟩, φ, hφ, rfl⟩
  refine ⟨hC.sector_subset_interiorPts hn hr j hz, ?_⟩
  show F.col z = F.col p
  exact (hC.isPreconnected r₀ hr₀ j).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ j))
    (hmono hz) hp

/-- **The flank after a germ** (child of `IsHorn.exists_flankAbove`): in a sector chart at `v`, above a germ of direction `α` (mod
`2π`) and curvature `κ` a thin horn `hornSet v α κ κ' r` lies, for all small `r`, in the class of the sector's colour. -/
theorem IsSectorChart.exists_flank_after {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {j : Fin n} {α κ : ℝ} (hβ : e (G.β j) = e α) (hκ : G.κ j = κ) :
    ∃ g κ', κ < κ' ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ κ' r ⊆ F.region g := by
  obtain ⟨g, hg⟩ := hC.exists_col j
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hβ
  have hcj : ∀ r ∈ Ioc 0 r₀, |κ| * r ≤ 2 := fun r hr => by
    rw [← hκ]; exact (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv j).le
  rcases hC.sorted.2 j with hlt | ⟨heq, hκ'⟩
  · -- a gap after the germ: a thin horn above it lies in sector `j`
    have hd : 0 < G.nextβ j - G.β j := sub_pos.mpr hlt
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hd)
    have hr₁ : 0 < min r₀ (min (1 / (|κ + 1| + 1)) (min (η / (|κ + 1| + 1)) (η / (|G.nextκ j| + 1)))) := by
      have := hC.pos; positivity
    refine ⟨g, κ + 1, by linarith, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hr₁] with r hr
    have hrr₀ : r ∈ Ioc 0 r₀ := ⟨hr.1, hr.2.le.trans (min_le_left _ _)⟩
    have hr2 : r < min (1 / (|κ + 1| + 1)) (min (η / (|κ + 1| + 1)) (η / (|G.nextκ j| + 1))) :=
      lt_of_lt_of_le hr.2 (min_le_right _ _)
    have h2 : |κ + 1| * r ≤ 2 := by
      have := abs_half_lt one_pos hr.1 (lt_of_lt_of_le hr2 (min_le_left _ _))
      rw [abs_div, abs_mul, abs_of_pos hr.1, abs_two] at this; linarith
    intro z hz
    apply hg r hrr₀
    rw [← sectorBetween_eq_hornSet v α κ (κ + 1) r (hcj r hrr₀) h2] at hz
    obtain ⟨s, hs, φ, hφ, rfl⟩ := hz
    have hsr : s < r := hs.2
    have ha1 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_left _ _)))))
    have ha2 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_right _ _)))))
    rw [abs_lt] at ha1 ha2
    refine ⟨s, hs, φ + 2 * π * m, ⟨?_, ?_⟩, ?_⟩
    · rw [hm, hκ]; linarith [hφ.1]
    · show φ + 2 * π * m < G.nextβ j + Real.arcsin (G.nextκ j * s / 2)
      linarith [hφ.2]
    · rw [e_add_int_mul]
  · -- the next germ has the same direction: sector `j` is the horn above the germ
    refine ⟨g, G.nextκ j, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have h2 : |G.nextκ j| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next j).le
    have h1 : |G.κ j| * r ≤ 2 := by rw [hκ]; exact hcj r hr
    have hsec : G.sector v r j = hornSet v α κ (G.nextκ j) r := by
      show sectorBetween v (G.β j) (G.κ j) (G.nextβ j) (G.nextκ j) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ, hκ]
    rw [← hsec]; exact hg r hr

/-- **The flank before a germ** (child of `IsHorn.exists_flankBelow`): in a sector chart at `v`, below the germ after sector `p`, of
direction `α` (mod `2π`) and curvature `κ`, a thin horn `hornSet v α κ' κ r` lies, for all small `r`, in sector `p`'s colour. -/
theorem IsSectorChart.exists_flank_before {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {p : Fin n} {α κ : ℝ} (hβ : e (G.nextβ p) = e α) (hκ : G.nextκ p = κ) :
    ∃ h κ', κ' < κ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ' κ r ⊆ F.region h := by
  obtain ⟨h, hh⟩ := hC.exists_col p
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp hβ
  have hcp : ∀ r ∈ Ioc 0 r₀, |κ| * r ≤ 2 := fun r hr => by
    rw [← hκ]; exact (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv_next p).le
  rcases hC.sorted.2 p with hlt | ⟨heq, hκ'⟩
  · have hd : 0 < G.nextβ p - G.β p := sub_pos.mpr hlt
    obtain ⟨η, hη, hηa⟩ := exists_abs_arcsin_lt (half_pos hd)
    have hr₁ : 0 < min r₀ (min (1 / (|κ - 1| + 1)) (min (η / (|κ - 1| + 1)) (η / (|G.κ p| + 1)))) := by
      have := hC.pos; positivity
    refine ⟨h, κ - 1, by linarith, ?_⟩
    filter_upwards [Ioo_mem_nhdsGT hr₁] with r hr
    have hrr₀ : r ∈ Ioc 0 r₀ := ⟨hr.1, hr.2.le.trans (min_le_left _ _)⟩
    have hr2 : r < min (1 / (|κ - 1| + 1)) (min (η / (|κ - 1| + 1)) (η / (|G.κ p| + 1))) :=
      lt_of_lt_of_le hr.2 (min_le_right _ _)
    have h1 : |κ - 1| * r ≤ 2 := by
      have := abs_half_lt one_pos hr.1 (lt_of_lt_of_le hr2 (min_le_left _ _))
      rw [abs_div, abs_mul, abs_of_pos hr.1, abs_two] at this; linarith
    intro z hz
    apply hh r hrr₀
    rw [← sectorBetween_eq_hornSet v α (κ - 1) κ r h1 (hcp r hrr₀)] at hz
    obtain ⟨s, hs, φ, hφ, rfl⟩ := hz
    have hsr : s < r := hs.2
    have ha1 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_left _ _)))))
    have ha2 := hηa _ (abs_half_lt hη hs.1 (lt_trans hsr (lt_of_lt_of_le hr2
      ((min_le_right _ _).trans (min_le_right _ _)))))
    rw [abs_lt] at ha1 ha2
    refine ⟨s, hs, φ + 2 * π * m, ⟨?_, ?_⟩, ?_⟩
    · show G.β p + Real.arcsin (G.κ p * s / 2) < φ + 2 * π * m
      linarith [hφ.1]
    · show φ + 2 * π * m < G.nextβ p + Real.arcsin (G.nextκ p * s / 2)
      rw [hm, hκ]; linarith [hφ.2]
    · rw [e_add_int_mul]
  · refine ⟨h, G.κ p, hκ ▸ hκ', ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have h1 : |G.κ p| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (hC.curv p).le
    have h2 : |G.nextκ p| * r ≤ 2 := by rw [hκ]; exact hcp r hr
    have hβ' : e (G.β p) = e α := by rw [heq]; exact hβ
    have hsec : G.sector v r p = hornSet v α (G.κ p) κ r := by
      show sectorBetween v (G.β p) (G.κ p) (G.nextβ p) (G.nextκ p) r = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r h1 h2, hornSet_congr hβ', hκ]
    rw [← hsec]; exact hh r hr

/-- **A horn has an upper flank** (FS131-IC2's finding 1): at a point of the domain, the colour of the sector after a horn's lies
directly above the horn's upper arc. -/
theorem IsHorn.exists_flankAbove {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hv : v ∈ F.dom) (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∃ g, F.IsFlankAbove v α κ₂ g := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  obtain ⟨i, hβi, hnext, -, hκ₂⟩ := hH.exists_chart_index hC
  have hn := i.pos
  obtain ⟨j, hβj, hκj⟩ : ∃ j : Fin n, e (G.β j) = e α ∧ G.κ j = κ₂ := by
    by_cases h : i.val + 1 < n
    · refine ⟨⟨i.val + 1, h⟩, ?_, ?_⟩
      · have : G.nextβ i = G.β ⟨i.val + 1, h⟩ := by unfold BranchGerms.nextβ; split_ifs; rfl
        rw [← this, hnext, hβi]
      · have : G.nextκ i = G.κ ⟨i.val + 1, h⟩ := by unfold BranchGerms.nextκ; split_ifs; rfl
        rw [← this, hκ₂]
    · refine ⟨⟨0, hn⟩, ?_, ?_⟩
      · have : G.nextβ i = G.β ⟨0, hn⟩ + 2 * π := by unfold BranchGerms.nextβ; split_ifs; rfl
        have h2 := e_add_int_mul (G.β ⟨0, hn⟩) 1
        rw [Int.cast_one, mul_one, ← this, hnext, hβi] at h2
        exact h2.symm
      · have : G.nextκ i = G.κ ⟨0, hn⟩ := by unfold BranchGerms.nextκ; split_ifs; rfl
        rw [← this, hκ₂]
  obtain ⟨g, κ', hκ', hev⟩ := hC.exists_flank_after hβj hκj
  exact ⟨g, κ', hκ', hev⟩

/-- **A horn has a lower flank** (the mirror of `IsHorn.exists_flankAbove`): the colour of the sector before a horn's lies directly
below the horn's lower arc. -/
theorem IsHorn.exists_flankBelow {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} (hv : v ∈ F.dom) (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∃ h, F.IsFlankBelow v α κ₁ h := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  obtain ⟨i, hβi, -, hκ₁, -⟩ := hH.exists_chart_index hC
  have hn := i.pos
  obtain ⟨p, hβp, hκp⟩ : ∃ p : Fin n, e (G.nextβ p) = e α ∧ G.nextκ p = κ₁ := by
    by_cases h0 : 0 < i.val
    · have hlt : i.val - 1 + 1 < n := by omega
      have hi : (⟨i.val - 1 + 1, hlt⟩ : Fin n) = i := Fin.ext (by simp only; omega)
      refine ⟨⟨i.val - 1, by omega⟩, ?_, ?_⟩
      · have : G.nextβ ⟨i.val - 1, by omega⟩ = G.β i := by
          unfold BranchGerms.nextβ; split_ifs with hh
          · exact congrArg G.β hi
          · exact absurd hlt hh
        rw [this, hβi]
      · have : G.nextκ ⟨i.val - 1, by omega⟩ = G.κ i := by
          unfold BranchGerms.nextκ; split_ifs with hh
          · exact congrArg G.κ hi
          · exact absurd hlt hh
        rw [this, hκ₁]
    · have hi0 : (⟨0, hn⟩ : Fin n) = i := Fin.ext (by simp only; omega)
      have hlt : ¬ (n - 1 + 1 < n) := by omega
      refine ⟨⟨n - 1, by omega⟩, ?_, ?_⟩
      · have : G.nextβ ⟨n - 1, by omega⟩ = G.β ⟨0, hn⟩ + 2 * π := by
          unfold BranchGerms.nextβ; split_ifs with hh
          · exact absurd hh hlt
          · rfl
        have h2 := e_add_int_mul (G.β ⟨0, hn⟩) 1
        rw [Int.cast_one, mul_one, ← this, hi0, hβi] at h2
        exact h2
      · have : G.nextκ ⟨n - 1, by omega⟩ = G.κ ⟨0, hn⟩ := by
          unfold BranchGerms.nextκ; split_ifs with hh
          · exact absurd hh hlt
          · rfl
        rw [this, hi0, hκ₁]
  obtain ⟨h, κ', hκ', hev⟩ := hC.exists_flank_before hβp hκp
  exact ⟨h, κ', hκ', hev⟩


/-- **A horn sector's chart index, at every radius** (child of `woodallCone_isHorn`): if the horn `hornSet v α κ₁ κ₂ r` is a sector
at one radius `r ≤ r₀`, it is the chart sector after a germ of direction `α` (mod `2π`) and curvature `κ₁` whose next germ has the same
direction and curvature `κ₂`, and that chart sector is the horn at every radius up to `r₀`. -/
theorem IsSectorChart.index_of_isSector_hornSet {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {α κ₁ κ₂ : ℝ} (hlt : κ₁ < κ₂)
    (hS : F.IsSector v r (hornSet v α κ₁ κ₂ r)) :
    ∃ i : Fin n, e (G.β i) = e α ∧ G.nextβ i = G.β i ∧ G.κ i = κ₁ ∧ G.nextκ i = κ₂ ∧
      ∀ r' ∈ Ioc 0 r₀, G.sector v r' i = hornSet v α κ₁ κ₂ r' := by
  have hr0 : 0 < r := hr.1
  have hcone1 : ∀ β ∈ coneAt (hornSet v α κ₁ κ₂ r) v, e β = e α := fun β hβ => e_eq_of_mem_coneAt_hornSet hβ
  rcases Nat.eq_zero_or_pos n with hn | hn
  · exfalso
    have hball := (hC.isSector_iff_of_zero hn hr).mp hS
    have hmem : α + π ∈ coneAt (hornSet v α κ₁ κ₂ r) v := by rw [hball, coneAt_ball_self v hr0]; trivial
    exact e_add_pi_ne α (hcone1 _ hmem)
  obtain ⟨i, hi⟩ := (hC.isSector_iff hn hr).mp hS
  have hconei := hC.cone r hr i
  rw [← hi] at hconei
  have hβi : e (G.β i) = e α :=
    hcone1 _ (by rw [hconei]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hC.sorted.mono i⟩)
  rcases hC.sorted.2 i with hlt' | ⟨heq, hκ⟩
  · exfalso
    have hd : 0 < G.nextβ i - G.β i := sub_pos.mpr hlt'
    have hε0 : 0 < min (G.nextβ i - G.β i) π / 2 := by have := lt_min hd Real.pi_pos; positivity
    have hεπ : min (G.nextβ i - G.β i) π / 2 < π := by
      have := min_le_right (G.nextβ i - G.β i) π; linarith [Real.pi_pos]
    have hmem : G.β i + min (G.nextβ i - G.β i) π / 2 ∈ coneAt (hornSet v α κ₁ κ₂ r) v := by
      rw [hconei]
      refine Icc_subset_angleIcc _ _ ⟨by linarith, ?_⟩
      have := min_le_left (G.nextβ i - G.β i) π; linarith
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp ((hcone1 _ hmem).trans hβi.symm)
    have hm1 : (0 : ℝ) < m := by nlinarith [Real.pi_pos]
    have hm2 : (m : ℝ) < 1 := by nlinarith [Real.pi_pos]
    have : (0 : ℤ) < m := by exact_mod_cast hm1
    have : m < 1 := by exact_mod_cast hm2
    omega
  · have hsec : ∀ r' ∈ Ioc 0 r₀, G.sector v r' i = hornSet v α (G.κ i) (G.nextκ i) r' := by
      intro r' hr'
      have h1 : |G.κ i| * r' ≤ 2 := (mul_le_mul_of_nonneg_left hr'.2 (abs_nonneg _)).trans (hC.curv i).le
      have h2 : |G.nextκ i| * r' ≤ 2 := (mul_le_mul_of_nonneg_left hr'.2 (abs_nonneg _)).trans (hC.curv_next i).le
      show sectorBetween v (G.β i) (G.κ i) (G.nextβ i) (G.nextκ i) r' = _
      rw [← heq, sectorBetween_eq_hornSet v _ _ _ r' h1 h2, hornSet_congr hβi]
    have hi' := hi
    rw [hsec r hr] at hi'
    obtain ⟨hk1, hk2⟩ := hornSet_curv_eq hlt hκ hr0 hi'
    refine ⟨i, hβi, heq.symm, hk1.symm, hk2.symm, fun r' hr' => ?_⟩
    rw [hsec r' hr', ← hk1, ← hk2]

end ArcMap

end HadwigerNelson.Plane
