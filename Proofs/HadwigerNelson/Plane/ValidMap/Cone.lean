import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.SVMap

/-!
# The allowed cone (FS110-N3-CONF) and the horn algebra, upstream of `Contact` and `Moves`

Moved verbatim from `Plane/ValidMap/Contact` (inventory items 253–254, FS131-IM1): `Contact`'s head — FS110-N3-CONF
(`contact_inType_or_outType`, `coneAt_subset_allowedCone`, `clear_of_subset_interior_allowedCone`, `lens_dist_lt_one_of_up`,
`lune_dist_le_of_up`, with the ray-point, shadow and dot helpers they use) and the branch-point and horn algebra
(`hornSet_congr` … `mem_coneAt_hornSet`) — and three single lemmas (`hornSet_mono_radius`,
`not_mem_interiorPts_of_mem_closure_sector`, `IsSector.eq_of_mem`), so that the moves (`Plane/ValidMap/Moves`) can read them.
`tools/fs131_im_move_cone.py --check` holds the text byte-identical to its source lines in `Contact` at `d4f946ae`.
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

end HadwigerNelson.Plane
