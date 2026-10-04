import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.Tiles

/-!
# Contacts, the allowed cone, shadows and the local moves (FS-110's N3–N4 rounds)

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 3). Conventions, read once: `F : ArcMap k` with `F.Valid` (no two interior
points of one colour at distance exactly 1); "near `v`" reads the map on a neighbourhood of `B̄(v, 1)`, stated `F.Covers v 1`
(`covers_one_iff`); the frame at `v` is `a = e α`, `n = e (α + π/2)`, `N = v + n`, `S′ = v − n`. Condition 5 is a hypothesis
exactly where a row's argument reads it; FS112-WALK's finding that N3-CONF and W-MERGE hold with unit arcs is followed.

* **FS110-N3-CONF**: `contact_inType_or_outType`, `coneAt_subset_allowedCone`, `clear_of_subset_interior_allowedCone`,
  `lens_dist_lt_one_of_up`, `lune_dist_le_of_up`.
* **FS110-N3-DEG**: `woodallCone`, `woodallCone_strict`.
* **FS110-N4-SHADOW**: `shadow_farSide_above`, `shadow_farSide_below`, `flank_shadows`.
* **FS110-N4-SHAVE**: `shaveAvailable_of_not_doublyShadowed`, `exists_shave`, `exists_rayMerge`.
* **FS110-N4-STUCK**: `stuck_structure`, `stuck_chain`.
* **FS110-W-MERGE**: `exists_merge`.
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

/-- **FS110-N3-CONF**, (iii) (N3-CLEAR): a compact set of directions inside the interior of `D_c(v)` is clear for `c` near `v`. -/
theorem clear_of_subset_interior_allowedCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    {Λ : Set ℝ} (hΛ : IsCompact Λ) (hΛD : e '' Λ ⊆ interior (F.allowedCone v c)) :
    ∃ ρ > 0, ∀ β ∈ Λ, ∀ t : ℝ, 0 < t → t < ρ → F.IsClear c (v + (t : ℂ) * e β) := by
  sorry

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

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS110-N3-DEG -/

/-- **FS110-N3-DEG**, the cone with unit arcs allowed: if `int D_c(v)` is empty then for some axis `α` the colour `c` has
out-type contacts at both `v ± n`, and every `c`-sector at `v` is a cusp horn along `±a` with bounding curvatures in
`[−1, 1]`. -/
theorem woodallCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 ≤ κ₁ ∧ κ₁ < κ₂ ∧ κ₂ ≤ 1 ∧ S = hornSet v β κ₁ κ₂ r := by
  sorry

/-- **FS110-N3-DEG** as filed (Condition 5): the bounding curvatures of Woodall's cone lie in the open interval `(−1, 1)`. -/
theorem woodallCone_strict (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} {c : Fin k} (hv : F.Covers v 1)
    (hc : c ∈ F.coloursAt v) (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 < κ₁ ∧ κ₁ < κ₂ ∧ κ₂ < 1 ∧ S = hornSet v β κ₁ κ₂ r := by
  sorry

/-! ## FS110-N4-SHADOW: N4-FLANK -/

/-- **FS110-N4-SHADOW**, N4-FLANK: for a `c`-horn along `a` with curvatures in `(−1, 1)`, upper flank `g` and lower flank `h`
(both `≠ c`), the points of the horn near `v` in the shadow of `g`'s class are exactly those below a tangent circle of some
curvature `σ_g ≤ κ₂`, and those in the shadow of `h`'s class exactly those above one of curvature `σ_h ≥ κ₁` (an absent shadow
is `σ_g = κ₁`, `σ_h = κ₂`). -/
theorem flank_shadows (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c g h : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 < κ₁) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g)
    (hh : F.IsFlankBelow v α κ₁ h) (hgc : g ≠ c) (hhc : h ≠ c) :
    ∃ σg σh, κ₁ ≤ σg ∧ σg ≤ κ₂ ∧ κ₁ ≤ σh ∧ σh ≤ κ₂ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (z ∈ shadow (F.region g) ↔ TanBelow v α σg z) ∧ (z ∈ shadow (F.region h) ↔ TanAbove v α σh z) := by
  sorry

/-! ## FS110-N4-SHAVE -/

/-- **FS110-N4-SHAVE**, the criterion: a horn with curvatures in `(−1, 1)` that is not doubly shadowed by its flanks can be
shaved (SHAVE is available at `v`). -/
theorem shaveAvailable_of_not_doublyShadowed (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1)
    {α κ₁ κ₂ : ℝ} {c g h : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 < κ₁) (h2 : κ₂ < 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hgc : g ≠ c) (hhc : h ≠ c)
    (hnot : ¬ F.DoublyShadowed v α κ₁ κ₂ g h) : F.ShaveAvailable v := by
  sorry

/-- **FS110-N4-SHAVE**, the move: where SHAVE is available at `v` for a colour `c` with `n ≥ 1` sectors, recolouring the horn's
tip gives a valid map, agreeing with `F` off a small disc about `v` and creating no unit arc (Condition 5 kept when `F` has it),
in which `c` has `n − 1` sectors at `v`, no colour is added at `v`, and the new points on the disc's rim carry at most three
colours. Unit arcs are allowed (FS112-WALK, row 7: the split circle has curvature `σ ∈ [κ₁, κ₂] ⊆ [−1, 1]`, and `σ = ±1` puts it on
the horn's own bounding arc); the curvature bounds are what keeps the move from creating a unit arc. -/
theorem exists_shave (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  sorry

/-- **FS110-N4-SHAVE**, N4-RAY: two `c`-horns along one ray merge — the region between them is `c`-clear near `v`, and
recolouring it gives a valid map, agreeing with `F` off a small disc about `v` and creating no unit arc, in which `c` has one
sector fewer at `v`. Unit arcs are allowed and the outer bounds may be `±1` (FS112-WALK W3: the region between the horns is bounded
by their inner arcs, of curvatures strictly inside `(−1, 1)`). -/
theorem exists_rayMerge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) :
    (∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₂ κ₃ r, F.IsClear c z) ∧
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  sorry

/-! ## FS110-W-MERGE -/

/-- **FS110-W-MERGE**, Woodall's step 3 almost everywhere for curved arcs: if `int D_c(v)` is non-empty and `c` has `n + 1 ≥ 2`
sectors at `v`, recolouring a gap inside `D_c(v)` near `v` gives a valid map, equal to `F` off a small disc about `v`, in which
`c` has `n` sectors at `v`, no point off the disc's rim gains a colour, the new points on the rim carry at most three colours
with none repeated, no other point's allowed cone for `c` changes, and no unit arc is created (so Condition 5 is kept). Condition 5 is not assumed
(FS112-WALK). -/
theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
    (hn : F.HasSectors v c (n + 1)) (hD : (interior (F.allowedCone v c)).Nonempty) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧ F'.HasSectors v c n ∧ (∀ x ∉ sphere v ρ, F'.coloursAt x ⊆ F.coloursAt x) ∧
      (∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x) ∧
      ∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c := by
  sorry

/-! ## FS110-N4-STUCK -/

/-- **FS110-N4-STUCK**, the structure (N4-STUCK (i)–(iv)), stated over "at most three colours at every point of `B̄(v, 1)`"
(the class its argument reads; FS110-NB-4 supplies it under Condition 5): at a stuck vertex the colour `c` with two or more
sectors has exactly two, cusp horns along `±a` with curvatures in `(−1, 1)`; `P_cl(v) = {c, g, h}` and `v` has degree `4`, the
interior points near `v` above the axis of colour `g` or `c` and below it of colour `h` or `c`; `g`'s contacts on `ω(v)` are
out-type at `S′` only, `h`'s out-type at `N` only, `c`'s out-type at both; `P_cl(N) = {c, h, r}` with `r ∉ P_cl(v)` and `h`
with at least two sectors at `N`, and `P_cl(S′) = {c, g, r′}` with `r′ ∉ P_cl(v)` and `g` with at least two sectors at `S′`. -/
theorem stuck_structure (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 2)
    (h3 : ∀ x ∈ closedBall v 1, (F.coloursAt x).ncard ≤ 3) (hst : F.IsStuck v) {c : Fin k} {m : ℕ} (hm : 2 ≤ m)
    (hc : F.HasSectors v c m) :
    ∃ α κ₁ κ₂ κ₃ κ₄ : ℝ, ∃ g h r r' : Fin k,
      F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 < κ₁ ∧ κ₂ < 1 ∧ -1 < κ₃ ∧ κ₄ < 1 ∧
      F.HasSectors v c 2 ∧ F.HasDegree v 4 ∧ F.coloursAt v = {c, g, h} ∧ g ≠ h ∧ g ≠ c ∧ h ≠ c ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
        (0 < frameY v α z → F.col z = g ∨ F.col z = c) ∧ (frameY v α z < 0 → F.col z = h ∨ F.col z = c)) ∧
      (∀ w, F.IsContact v g w → w = v - e (α + π / 2) ∧ F.OutType v g w) ∧
      (∀ w, F.IsContact v h w → w = v + e (α + π / 2) ∧ F.OutType v h w) ∧
      F.OutType v c (v + e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2)) ∧
      F.coloursAt (v + e (α + π / 2)) = {c, h, r} ∧ r ∉ F.coloursAt v ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v + e (α + π / 2)) ρ h).encard) ∧
      F.coloursAt (v - e (α + π / 2)) = {c, g, r'} ∧ r' ∉ F.coloursAt v ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v - e (α + π / 2)) ρ g).encard) := by
  sorry

/-- **FS110-N4-STUCK**, N4-PROP: in a terminal valid map of the plane with Condition 5 and at most three colours at every point,
a stuck vertex whose stuck colour has a horn along `e α` forces stuck vertices at every point `v + jn`, `j ∈ ℤ`, of its normal
line. -/
theorem stuck_chain (hF : F.Valid) (h5 : F.Condition5) (hP : F.IsPlaneMap) (hT : F.Terminal)
    (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) {v : ℂ} (hst : F.IsStuck v) {α κ₁ κ₂ : ℝ} {c : Fin k} {m : ℕ} (hm : 2 ≤ m)
    (hc : F.HasSectors v c m) (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∀ j : ℤ, F.IsStuck (v + (j : ℂ) * e (α + π / 2)) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
