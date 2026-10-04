import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.SVMap

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
  obtain ⟨σg, σh, hg1, hg2, hh1, hh2, hev⟩ := flank_shadows hF h5 hv hH h1 h2 hg hh hgc hhc
  -- not doubly shadowed: the `g`-shadow ends below the `h`-shadow
  have hle : σg ≤ σh := by
    by_contra hlt
    push Not at hlt
    refine hnot ⟨σh, σg, hh1, hlt, hg2, ?_⟩
    filter_upwards [hev] with r hr z hz
    have hz' := hornSet_mono hh1 hg2 hz
    exact ⟨(hr z hz').1.mpr hz.2.2.2, (hr z hz').2.mpr hz.2.2.1⟩
  refine ⟨c, g, h, α, κ₁, κ₂, σg, hH, hg, hh, hg1, hg2, ?_⟩
  filter_upwards [hev] with r hr z hz
  refine ⟨fun hA y hy hzy => ?_, fun hA y hy hzy => ?_⟩
  · -- above `σ_g`: outside the `g`-shadow
    have hB : TanBelow v α σg z := (hr z hz).1.mp ⟨y, hy, hzy⟩
    exact lt_asymm hA hB
  · -- not above `σ_g ≤ σ_h`: outside the `h`-shadow
    have hA' : TanAbove v α σh z := (hr z hz).2.mp ⟨y, hy, hzy⟩
    exact hA (lt_of_lt_of_le hA' (tanHeight_anti hle _ _))

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

/-- **The neighbour on the normal line is stuck, with a horn along the same axis** (FS110-N4-PROP's step, its second half): in a
terminal valid plane map with Condition 5 and at most three colours everywhere, if a colour `h` carried at `v` has at least two
sectors at `P = v + e(α + π/2)`, then `P` is stuck and `h` has a horn at `P` along `e α`. The axis: `v` is an `h`-contact of `P`,
and both directions of `h`'s horns at `P` lie in `D_h(P)`, so they are perpendicular to `v − P`. -/
theorem stuck_neighbour (hF : F.Valid) (h5 : F.Condition5) (hP : F.IsPlaneMap) (hT : F.Terminal)
    (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) {v : ℂ} {α : ℝ} {h : Fin k} (hhv : h ∈ F.coloursAt v)
    (hhN : h ∈ F.coloursAt (v + e (α + π / 2)))
    (hsec : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v + e (α + π / 2)) ρ h).encard) :
    F.IsStuck (v + e (α + π / 2)) ∧ ∃ m' : ℕ, ∃ κ κ' : ℝ, 2 ≤ m' ∧ F.HasSectors (v + e (α + π / 2)) h m' ∧
      F.IsHorn (v + e (α + π / 2)) α κ κ' h := by
  set P := v + e (α + π / 2) with hPdef
  have hPd : P ∈ F.dom := by rw [hP]; trivial
  obtain ⟨m', hm'⟩ := exists_hasSectors hPd h
  have h2 : 2 ≤ m' := by
    obtain ⟨ρ, h1, h2⟩ := (hsec.and hm').exists
    rw [h2] at h1
    exact_mod_cast h1
  have hstP : F.IsStuck P := by
    obtain ⟨t1, t2, t3⟩ := hT P (mem_univ _)
    exact ⟨t1, t2, t3, h, m', h2, hm'⟩
  obtain ⟨α₁, κ₁, κ₂, κ₃, κ₄, -, -, -, -, hH0, hH1, -⟩ :=
    stuck_structure hF h5 (covers_of_isPlaneMap hP P 2) (fun x _ => h3 x) hstP h2 hm'
  have hcov := covers_of_isPlaneMap hP P 1
  have hvP : v - P = -e (α + π / 2) := by rw [hPdef]; ring
  have hcont : F.IsContact P h v := by
    refine ⟨hhN, ?_, hhv⟩
    rw [dist_eq_norm, hvP, norm_neg, norm_e]
  have hd1 := coneAt_subset_allowedCone hF hcov hH0.mem_coneAt_region
  have hd2 := coneAt_subset_allowedCone hF hcov hH1.mem_coneAt_region
  rw [e_add_pi'] at hd2
  have hdot : dot (e α₁) (v - P) = 0 := by
    have hneg : dot (-e α₁) (v - P) = -dot (e α₁) (v - P) := dot_neg_left _ _
    rcases (contact_inType_or_outType hF hcov hcont).1 with hin | hout
    · have a1 := (hd1 v hcont).1 hin
      have a2 := (hd2 v hcont).1 hin
      rw [hneg] at a2
      linarith
    · have a1 := (hd1 v hcont).2 hout
      have a2 := (hd2 v hcont).2 hout
      rw [hneg] at a2
      linarith
  have hsin : Real.sin (α₁ - α) = 0 := by
    rw [hvP, dot_neg_right, dot_e_e, show α₁ - (α + π / 2) = (α₁ - α) - π / 2 by ring, Real.cos_sub_pi_div_two] at hdot
    linarith
  refine ⟨hstP, m', ?_⟩
  rcases e_eq_or_of_sin_sub_eq_zero hsin with he | he
  · exact ⟨κ₁, κ₂, h2, hm', hH0.congr he⟩
  · refine ⟨κ₃, κ₄, h2, hm', hH1.congr ?_⟩
    rw [e_add_pi', he, e_add_pi', neg_neg]

/-- **The stuck colour's other horn** (N4-STUCK (i)): at a stuck vertex of such a map, a horn along `e α` of a colour with at least
two sectors comes with a horn of that colour along `e(α + π)`. -/
theorem stuck_flip (hF : F.Valid) (h5 : F.Condition5) (hP : F.IsPlaneMap) (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) {w : ℂ}
    {α κ₁ κ₂ : ℝ} {c : Fin k} {m : ℕ} (hst : F.IsStuck w) (hm : 2 ≤ m) (hc : F.HasSectors w c m)
    (hH : F.IsHorn w α κ₁ κ₂ c) : ∃ κ κ' : ℝ, F.IsHorn w (α + π) κ κ' c := by
  obtain ⟨α₀, κ₁', κ₂', κ₃, κ₄, -, -, -, -, hH0, hH1, -, -, -, -, hc2, -⟩ :=
    stuck_structure hF h5 (covers_of_isPlaneMap hP w 2) (fun x _ => h3 x) hst hm hc
  rcases e_eq_or_of_two_horns hc2 hH0 hH1 hH with he | he
  · exact ⟨κ₃, κ₄, hH1.congr (by rw [e_add_pi', e_add_pi', he])⟩
  · exact ⟨κ₁', κ₂', hH0.congr (by rw [e_add_pi', he, e_add_pi', neg_neg])⟩

/-- **The step along the normal line** (FS110-N4-PROP's step `k → k + 1`): at a stuck vertex of a terminal valid plane map with
Condition 5 and at most three colours everywhere, a horn along `e α` of a colour with at least two sectors makes `w + e(α + π/2)`
stuck, with a horn along `e α` of a colour with at least two sectors there. -/
theorem stuck_step (hF : F.Valid) (h5 : F.Condition5) (hP : F.IsPlaneMap) (hT : F.Terminal)
    (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) {w : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin k} {m : ℕ} (hst : F.IsStuck w) (hm : 2 ≤ m)
    (hc : F.HasSectors w c m) (hH : F.IsHorn w α κ₁ κ₂ c) :
    F.IsStuck (w + e (α + π / 2)) ∧ ∃ h : Fin k, ∃ m' : ℕ, ∃ κ κ' : ℝ, 2 ≤ m' ∧ F.HasSectors (w + e (α + π / 2)) h m' ∧
      F.IsHorn (w + e (α + π / 2)) α κ κ' h := by
  obtain ⟨α₀, κ₁', κ₂', κ₃, κ₄, g, h, r, r', hH0, hH1, -, -, -, -, hc2, -, hcol, -, -, -, -, -, -, -, -, hcolN, -, hsecN,
    hcolS, -, hsecS⟩ := stuck_structure hF h5 (covers_of_isPlaneMap hP w 2) (fun x _ => h3 x) hst hm hc
  rcases e_eq_or_of_two_horns hc2 hH0 hH1 hH with he | he
  · have hn : e (α + π / 2) = e (α₀ + π / 2) := by rw [e_add, e_add, he]
    rw [← hn] at hcolN hsecN
    obtain ⟨hs, m', κ, κ', h2, hm', hH'⟩ := stuck_neighbour hF h5 hP hT h3 (h := h) (by rw [hcol]; simp)
      (by rw [hcolN]; simp) hsecN
    exact ⟨hs, h, m', κ, κ', h2, hm', hH'⟩
  · have hn : e (α + π / 2) = -e (α₀ + π / 2) := by
      rw [e_add, he, e_add_pi', e_add]; ring
    have hS : w - e (α₀ + π / 2) = w + e (α + π / 2) := by rw [hn]; ring
    rw [hS] at hcolS hsecS
    obtain ⟨hs, m', κ, κ', h2, hm', hH'⟩ := stuck_neighbour hF h5 hP hT h3 (h := g) (by rw [hcol]; simp)
      (by rw [hcolS]; simp) hsecS
    exact ⟨hs, g, m', κ, κ', h2, hm', hH'⟩

/-- **FS110-N4-STUCK**, N4-PROP: in a terminal valid map of the plane with Condition 5 and at most three colours at every point,
a stuck vertex whose stuck colour has a horn along `e α` forces stuck vertices at every point `v + jn`, `j ∈ ℤ`, of its normal
line. **No model of its hypotheses is expected** (FS131-QA2's QA2-5): it is a step inside FS110-N4-PROP's proof by contradiction — along the
chain the horns' bounding curvatures form a bi-infinite sequence `−1 < λ_j < υ_j < 1` with `λ_j ≤ f(λ_{j+1})`, `f̃(υ_{j−1}) ≤ υ_j`
(N4-SHADOW), which `n4_fin` (FS110-N4-FIN, `Plane/StuckChain`) refutes; so no terminal valid plane map with Condition 5 and at most three
colours everywhere has a stuck vertex. -/
theorem stuck_chain (hF : F.Valid) (h5 : F.Condition5) (hP : F.IsPlaneMap) (hT : F.Terminal)
    (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) {v : ℂ} (hst : F.IsStuck v) {α κ₁ κ₂ : ℝ} {c : Fin k} {m : ℕ} (hm : 2 ≤ m)
    (hc : F.HasSectors v c m) (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∀ j : ℤ, F.IsStuck (v + (j : ℂ) * e (α + π / 2)) := by
  -- the invariant carried along the normal line
  let Q : ℂ → Prop := fun w => F.IsStuck w ∧ ∃ c' : Fin k, ∃ m' : ℕ, ∃ κ κ' : ℝ, 2 ≤ m' ∧ F.HasSectors w c' m' ∧
    F.IsHorn w α κ κ' c'
  have hup : ∀ w, Q w → Q (w + e (α + π / 2)) := by
    rintro w ⟨hs, c', m', κ, κ', hm', hc', hH'⟩
    exact stuck_step hF h5 hP hT h3 hs hm' hc' hH'
  have hdown : ∀ w, Q w → Q (w - e (α + π / 2)) := by
    rintro w ⟨hs, c', m', κ, κ', hm', hc', hH'⟩
    obtain ⟨κa, κb, hHπ⟩ := stuck_flip hF h5 hP h3 hs hm' hc' hH'
    obtain ⟨hs2, c'', m'', κc, κd, hm'', hc'', hH''⟩ := stuck_step hF h5 hP hT h3 hs hm' hc' hHπ
    have hn : w + e (α + π + π / 2) = w - e (α + π / 2) := by
      rw [show α + π + π / 2 = (α + π / 2) + π by ring, e_add_pi']; ring
    rw [hn] at hs2 hc'' hH''
    obtain ⟨κe, κf, hH3⟩ := stuck_flip hF h5 hP h3 hs2 hm'' hc'' hH''
    refine ⟨hs2, c'', m'', κe, κf, hm'', hc'', hH3.congr ?_⟩
    rw [show α + π + π = α + 2 * π by ring, e_add_two_pi]
  have key : ∀ j : ℤ, Q (v + (j : ℂ) * e (α + π / 2)) := by
    intro j
    refine Int.induction_on j ?_ ?_ ?_
    · have h0 : v + ((0 : ℤ) : ℂ) * e (α + π / 2) = v := by simp
      rw [h0]; exact ⟨hst, c, m, κ₁, κ₂, hm, hc, hH⟩
    · intro i hi
      have := hup _ hi
      convert this using 1
      push_cast; ring
    · intro i hi
      have := hdown _ hi
      convert this using 1
      push_cast; ring
  exact fun j => (key j).1


end ArcMap

end HadwigerNelson.Plane
