import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

/-!
# The radial push and the collar's geometry (FS131-KP2's skeleton for `bend_toward_collar`)

Pure geometry, no arc map: the homeomorphism of the plane that the collar bend transports the map by, and the shapes it is built
from (`plans/FS131-collar-kernel-plan.md` §§ 2–3; the design is KB2's D1, `plans/FS131-I5-implementation.md` § 44.3).

* **Polar sets** about a point `P`: `polarSet P I S = {P + t e(θ) : θ ∈ I, t ∈ S θ}`.
* **The one-dimensional push** `push1 a m m' b`: the piecewise-linear homeomorphism of `ℝ` fixing `(−∞, a] ∪ [b, ∞)` and sending
  `m` to `m'` (`a < m, m' < b`); its inverse is `push1 a m' m b` (`push1_push1`).
* **The radial push** `pushHomeo P θ₁ θ₂ a l b`: on each ray `θ ∈ (θ₁, θ₂)` from `P`, the push of `[a(θ), b(θ)]` sending `1` to `l(θ)`;
  the identity elsewhere. Its hypotheses are the structure `PushProfiles` (continuous profiles, equal to `1` off `(θ₁, θ₂)`, with
  `0 < a < l < 1 < b` inside).
* **The collar's profiles** (D1): `tangRad R u`, the distance from `P` along the ray at angle `u` from `ringPt P θ` to the circle of
  radius `R` tangent to `ω(P)` there (centre `P + (1 − R) e(θ)`); the lens profile `lensProf θ₁ θ₂ R` (the larger of the two tangent
  circles at the ends, `R < 1`), the outer profile `outerProf θ₁ θ₂ R''` (the smaller, `R'' > 1`); the lens boundary as two arcs
  `collarArcA`, `collarArcB` (germ arcs from the ends to the crossing `collarMid` on the bisector).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Polar sets about a point -/

/-- The points `P + t e(θ)` with `θ ∈ I` and `t ∈ S θ`. -/
def polarSet (P : ℂ) (I : Set ℝ) (S : ℝ → Set ℝ) : Set ℂ := {z | ∃ θ ∈ I, ∃ t ∈ S θ, z = P + (t : ℂ) * e θ}

/-- Spec: `polarSet` holds its points. -/
example (P : ℂ) (θ t : ℝ) : P + (t : ℂ) * e θ ∈ polarSet P {θ} (fun _ => {t}) := ⟨θ, rfl, t, rfl, rfl⟩

/-! ## The one-dimensional push -/

/-- The tent on `[a, b]` with peak `1` at `m`: `0` off `(a, b)`, linear on `[a, m]` and on `[m, b]`. -/
noncomputable def tent (a m b t : ℝ) : ℝ := max 0 (min ((t - a) / (m - a)) ((b - t) / (b - m)))

/-- **The one-dimensional push**: `t − (m − m') · tent a m b t` — fixes `t` off `(a, b)`, sends `m` to `m'`, linear between. -/
noncomputable def push1 (a m m' b t : ℝ) : ℝ := t - (m - m') * tent a m b t

/-- Spec: the tent peaks at `1`. -/
example : tent 0 1 2 1 = 1 := by norm_num [tent]

/-- The push sends the peak `m` to `m'`. -/
theorem push1_mid {a m m' b : ℝ} (ha : a < m) (hb : m < b) : push1 a m m' b m = m' := by
  have h1 : (m - a) / (m - a) = 1 := div_self (by linarith)
  have h2 : (b - m) / (b - m) = 1 := div_self (by linarith)
  simp only [push1, tent, h1, h2, min_self, max_eq_right zero_le_one]
  ring

/-- Off `(a, b)` the push is the identity. -/
theorem push1_of_not_mem {a m m' b t : ℝ} (ha : a < m) (hb : m < b) (ht : t ∉ Ioo a b) : push1 a m m' b t = t := by
  have h0 : tent a m b t = 0 := by
    simp only [mem_Ioo, not_and_or, not_lt] at ht
    unfold tent
    refine max_eq_left (min_le_iff.mpr ?_)
    rcases ht with h | h
    · exact Or.inl (div_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith))
    · exact Or.inr (div_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith))
  simp [push1, h0]

/-- The tent is nonnegative. -/
theorem tent_nonneg (a m b t : ℝ) : 0 ≤ tent a m b t := le_max_left _ _

/-- The tent vanishes at and below its foot `a` (for `a ≤ m`). -/
theorem tent_of_le_left {a m b t : ℝ} (ham : a ≤ m) (ht : t ≤ a) : tent a m b t = 0 :=
  max_eq_left (min_le_iff.mpr (Or.inl (div_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith))))

/-- The tent is at most `1` (for `a ≤ m ≤ b`; a degenerate side reads `0` by `x / 0 = 0`). -/
theorem tent_le_one {a m b t : ℝ} (ham : a ≤ m) (hmb : m ≤ b) : tent a m b t ≤ 1 := by
  unfold tent
  refine max_le zero_le_one ?_
  rcases eq_or_lt_of_le ham with h | h
  · subst h; simp
  rcases le_total t m with htm | htm
  · exact (min_le_left _ _).trans ((div_le_one (by linarith)).mpr (by linarith))
  · rcases eq_or_lt_of_le hmb with h' | h'
    · subst h'; simp
    · exact (min_le_right _ _).trans ((div_le_one (by linarith)).mpr (by linarith))

/-- On the rising side the tent is `(t − a)/(m − a)`. -/
theorem tent_of_le_mid {a m b t : ℝ} (ham : a < m) (hmb : m < b) (h1 : a ≤ t) (h2 : t ≤ m) :
    tent a m b t = (t - a) / (m - a) := by
  unfold tent
  have hx : (t - a) / (m - a) ≤ 1 := (div_le_one (by linarith)).mpr (by linarith)
  have hy : 1 ≤ (b - t) / (b - m) := (one_le_div (by linarith)).mpr (by linarith)
  rw [min_eq_left (hx.trans hy), max_eq_right (div_nonneg (by linarith) (by linarith))]

/-- On the falling side the tent is `(b − t)/(b − m)`. -/
theorem tent_of_mid_le {a m b t : ℝ} (ham : a < m) (hmb : m < b) (h1 : m ≤ t) (h2 : t ≤ b) :
    tent a m b t = (b - t) / (b - m) := by
  unfold tent
  have hx : 1 ≤ (t - a) / (m - a) := (one_le_div (by linarith)).mpr (by linarith)
  have hy : (b - t) / (b - m) ≤ 1 := (div_le_one (by linarith)).mpr (by linarith)
  rw [min_eq_right (hy.trans hx), max_eq_right (div_nonneg (by linarith) (by linarith))]

/-- The push on `[a, m]`: the affine map onto `[a, m']`. -/
theorem push1_of_le_mid {a m m' b t : ℝ} (ham : a < m) (hmb : m < b) (h1 : a ≤ t) (h2 : t ≤ m) :
    push1 a m m' b t = a + (t - a) * (m' - a) / (m - a) := by
  have : m - a ≠ 0 := by linarith
  rw [push1, tent_of_le_mid ham hmb h1 h2]; field_simp; ring

/-- The push on `[m, b]`: the affine map onto `[m', b]`. -/
theorem push1_of_mid_le {a m m' b t : ℝ} (ham : a < m) (hmb : m < b) (h1 : m ≤ t) (h2 : t ≤ b) :
    push1 a m m' b t = b - (b - t) * (b - m') / (b - m) := by
  have : b - m ≠ 0 := by linarith
  rw [push1, tent_of_mid_le ham hmb h1 h2]; field_simp; ring

/-- A push that moves nothing is the identity. -/
theorem push1_self (a m b t : ℝ) : push1 a m m b t = t := by simp [push1]

/-- The push maps `[a, m)` into `[a, m')`. -/
theorem push1_mem_Ico {a m m' b t : ℝ} (ha : a < m) (hb : m < b) (ha' : a < m') (ht : t ∈ Ico a m) :
    push1 a m m' b t ∈ Ico a m' := by
  rw [push1_of_le_mid ha hb ht.1 ht.2.le]
  have h0 : 0 ≤ (t - a) * (m' - a) / (m - a) := div_nonneg (mul_nonneg (by linarith [ht.1]) (by linarith)) (by linarith)
  have h1 : (t - a) * (m' - a) / (m - a) < m' - a := by
    rw [div_lt_iff₀ (by linarith)]; nlinarith [ht.2]
  exact ⟨by linarith, by linarith⟩

/-- The push maps `(m, b]` into `(m', b]`. -/
theorem push1_mem_Ioc {a m m' b t : ℝ} (ha : a < m) (hb : m < b) (hb' : m' < b) (ht : t ∈ Ioc m b) :
    push1 a m m' b t ∈ Ioc m' b := by
  rw [push1_of_mid_le ha hb ht.1.le ht.2]
  have h0 : 0 ≤ (b - t) * (b - m') / (b - m) := div_nonneg (mul_nonneg (by linarith [ht.2]) (by linarith)) (by linarith)
  have h1 : (b - t) * (b - m') / (b - m) < b - m' := by
    rw [div_lt_iff₀ (by linarith)]; nlinarith [ht.1]
  exact ⟨by linarith, by linarith⟩

/-- **The push's inverse is the push back**: `push1 a m' m b ∘ push1 a m m' b = id` for `a < m, m' < b` (piecewise-linear algebra on
`[a, m]`, `[m, b]` and their images `[a, m']`, `[m', b]`). -/
theorem push1_push1 {a m m' b : ℝ} (ha : a < m) (hb : m < b) (ha' : a < m') (hb' : m' < b) (t : ℝ) :
    push1 a m' m b (push1 a m m' b t) = t := by
  rcases lt_or_ge t a with h | h
  · rw [push1_of_not_mem ha hb (fun h' => by linarith [h'.1]), push1_of_not_mem ha' hb' (fun h' => by linarith [h'.1])]
  rcases lt_or_ge b t with h' | h'
  · rw [push1_of_not_mem ha hb (fun h'' => by linarith [h''.2]), push1_of_not_mem ha' hb' (fun h'' => by linarith [h''.2])]
  rcases le_total t m with hm | hm
  · have hs := push1_of_le_mid (m' := m') ha hb h hm
    have h0 : 0 ≤ (t - a) * (m' - a) / (m - a) := div_nonneg (mul_nonneg (by linarith) (by linarith)) (by linarith)
    have h1 : (t - a) * (m' - a) / (m - a) ≤ m' - a := by
      rw [div_le_iff₀ (by linarith)]; nlinarith
    rw [hs, push1_of_le_mid ha' hb' (by linarith) (by linarith)]
    have : m - a ≠ 0 := by linarith
    have : m' - a ≠ 0 := by linarith
    field_simp; ring
  · have hs := push1_of_mid_le (m' := m') ha hb hm h'
    have h0 : 0 ≤ (b - t) * (b - m') / (b - m) := div_nonneg (mul_nonneg (by linarith) (by linarith)) (by linarith)
    have h1 : (b - t) * (b - m') / (b - m) ≤ b - m' := by
      rw [div_le_iff₀ (by linarith)]; nlinarith
    rw [hs, push1_of_mid_le ha' hb' (by linarith) (by linarith)]
    have : b - m ≠ 0 := by linarith
    have : b - m' ≠ 0 := by linarith
    field_simp; ring

/-- The push maps `[a, m)` onto `[a, m')` (it is increasing and fixes `a`). -/
theorem push1_image_Ico {a m m' b : ℝ} (ha : a < m) (hb : m < b) (ha' : a < m') (hb' : m' < b) :
    push1 a m m' b '' Ico a m = Ico a m' := by
  ext s
  constructor
  · rintro ⟨t, ht, rfl⟩; exact push1_mem_Ico ha hb ha' ht
  · intro hs; exact ⟨push1 a m' m b s, push1_mem_Ico ha' hb' ha hs, push1_push1 ha' hb' ha hb s⟩

/-- The push maps `(m, b]` onto `(m', b]`. -/
theorem push1_image_Ioc {a m m' b : ℝ} (ha : a < m) (hb : m < b) (ha' : a < m') (hb' : m' < b) :
    push1 a m m' b '' Ioc m b = Ioc m' b := by
  ext s
  constructor
  · rintro ⟨t, ht, rfl⟩; exact push1_mem_Ioc ha hb hb' ht
  · intro hs; exact ⟨push1 a m' m b s, push1_mem_Ioc ha' hb' hb hs, push1_push1 ha' hb' ha hb s⟩

/-! ## The radial push -/

/-- **The profiles of a radial push** over the angles `(θ₁, θ₂)` (at most `60°`): continuous, equal to `1` off `(θ₁, θ₂)` (so the push
is the identity off the sector and continuous across its edges), and `0 < a < l < 1 < b` inside. -/
structure PushProfiles (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) : Prop where
  /-- The angles are ordered. -/
  lt : θ₁ < θ₂
  /-- The sector is at most `60°`. -/
  short : θ₂ - θ₁ ≤ π / 3
  /-- The inner profile is continuous. -/
  cont_a : Continuous a
  /-- The middle profile is continuous. -/
  cont_l : Continuous l
  /-- The outer profile is continuous. -/
  cont_b : Continuous b
  /-- Off the open sector every profile is `1`. -/
  off : ∀ θ ∉ Ioo θ₁ θ₂, a θ = 1 ∧ l θ = 1 ∧ b θ = 1
  /-- Inside, `0 < a < l < 1 < b`. -/
  inside : ∀ θ ∈ Ioo θ₁ θ₂, 0 < a θ ∧ a θ < l θ ∧ l θ < 1 ∧ 1 < b θ

/-- The angle of `z` about `P`, read in the window `(φ − π, φ + π]`. -/
noncomputable def polarAngle (P : ℂ) (φ : ℝ) (z : ℂ) : ℝ := φ + arg ((z - P) * starRingEnd ℂ (e φ))

/-- The radial push, as a function: on the ray at angle `θ` (read about the bisector), the push of `[a θ, b θ]` sending `1` to `l θ`. -/
noncomputable def pushFun (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) (z : ℂ) : ℂ :=
  P + (push1 (a (polarAngle P ((θ₁ + θ₂) / 2) z)) 1 (l (polarAngle P ((θ₁ + θ₂) / 2) z))
    (b (polarAngle P ((θ₁ + θ₂) / 2) z)) ‖z - P‖ : ℝ) * e (polarAngle P ((θ₁ + θ₂) / 2) z)

/-- The radial push back: on each ray, the push sending `l θ` back to `1`. -/
noncomputable def pushInv (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) (z : ℂ) : ℂ :=
  P + (push1 (a (polarAngle P ((θ₁ + θ₂) / 2) z)) (l (polarAngle P ((θ₁ + θ₂) / 2) z)) 1
    (b (polarAngle P ((θ₁ + θ₂) / 2) z)) ‖z - P‖ : ℝ) * e (polarAngle P ((θ₁ + θ₂) / 2) z)

/-! ### The radial push's supporting lemmas (FS131-CG1)

At each angle the profiles are either inside (`0 < a < l < 1 < b`) or all `1`; the push is a *radial map* (`radialMap`): each ray from `P`
to itself with the radius moved by a one-dimensional push, read in the angular window `(φ − π, φ + π]` about the bisector. -/

/-- At each angle the profiles are inside or all `1`. -/
theorem PushProfiles.cases {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (θ : ℝ) :
    (θ ∈ Ioo θ₁ θ₂ ∧ 0 < a θ ∧ a θ < l θ ∧ l θ < 1 ∧ 1 < b θ) ∨ (θ ∉ Ioo θ₁ θ₂ ∧ a θ = 1 ∧ l θ = 1 ∧ b θ = 1) := by
  by_cases h : θ ∈ Ioo θ₁ θ₂
  · exact Or.inl ⟨h, hp.inside θ h⟩
  · exact Or.inr ⟨h, hp.off θ h⟩

/-- The inner profile is positive. -/
theorem PushProfiles.a_pos {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (θ : ℝ) : 0 < a θ := by
  rcases hp.cases θ with ⟨-, h, -⟩ | ⟨-, h, -⟩
  · exact h
  · rw [h]; exact one_pos

/-- The inner profile is bounded below by a positive constant (it is `1` off the compact `[θ₁, θ₂]`). -/
theorem PushProfiles.exists_a_ge {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) : ∃ a₀ > 0, ∀ θ, a₀ ≤ a θ := by
  obtain ⟨x, -, hmin⟩ := isCompact_Icc.exists_isMinOn (nonempty_Icc.mpr hp.lt.le) hp.cont_a.continuousOn
  refine ⟨min (a x) 1, lt_min (hp.a_pos x) one_pos, fun θ => ?_⟩
  by_cases h : θ ∈ Ioo θ₁ θ₂
  · exact (min_le_left _ _).trans (hmin (Ioo_subset_Icc_self h))
  · rw [(hp.off θ h).1]; exact min_le_right _ _

/-- The angle about `P` lies in its window `(φ − π, φ + π]`. -/
theorem polarAngle_mem (P : ℂ) (φ : ℝ) (z : ℂ) : polarAngle P φ z ∈ Ioc (φ - π) (φ + π) := by
  have h := Complex.arg_mem_Ioc ((z - P) * starRingEnd ℂ (e φ))
  exact ⟨by unfold polarAngle; linarith [h.1], by unfold polarAngle; linarith [h.2]⟩

/-- Every point is `P + |z − P| e(polarAngle z)`. -/
theorem eq_polar_polarAngle (P : ℂ) (φ : ℝ) (z : ℂ) : z = P + (‖z - P‖ : ℂ) * e (polarAngle P φ z) := by
  have h := eq_polar_frameDir P z φ
  rwa [dist_eq_norm] at h

/-- **The angle of a polar point**: `polarAngle P φ (P + t e θ) = θ` for `t > 0` and `θ` in the window `(φ − π, φ + π]`. -/
theorem polarAngle_polar {P : ℂ} {φ θ t : ℝ} (hθ : θ ∈ Ioc (φ - π) (φ + π)) (ht : 0 < t) :
    polarAngle P φ (P + (t : ℂ) * e θ) = θ := by
  unfold polarAngle
  have h1 : (P + (t : ℂ) * e θ - P) * starRingEnd ℂ (e φ) = (t : ℂ) * e (θ - φ) := by
    rw [e_sub_eq]; ring
  have h2 : arg (e (θ - φ)) = θ - φ := by
    rw [e_eq, Complex.ofReal_cos, Complex.ofReal_sin]
    exact Complex.arg_cos_add_sin_mul_I ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  rw [h1, Complex.arg_real_mul _ ht, h2]; ring

/-- The angles of the sector lie within `π/6` of the bisector, so in its window. -/
theorem abs_sub_bisector_le {θ₁ θ₂ θ : ℝ} (hℓ : θ₂ - θ₁ ≤ π / 3) (hθ : θ ∈ Icc θ₁ θ₂) : |θ - (θ₁ + θ₂) / 2| ≤ π / 6 :=
  abs_le.mpr ⟨by linarith [hθ.1, hθ.2], by linarith [hθ.1, hθ.2]⟩

/-- The sector lies in the bisector's window. -/
theorem mem_window_of_mem_Icc {θ₁ θ₂ θ : ℝ} (hℓ : θ₂ - θ₁ ≤ π / 3) (hθ : θ ∈ Icc θ₁ θ₂) :
    θ ∈ Ioc ((θ₁ + θ₂) / 2 - π) ((θ₁ + θ₂) / 2 + π) := by
  have h := abs_le.mp (abs_sub_bisector_le hℓ hθ)
  exact ⟨by linarith [h.1, Real.pi_pos], by linarith [h.2, Real.pi_pos]⟩

/-- A **radial map** about `P` (angles read about `φ`): the ray at angle `θ` to itself, the radius `t` moved to `f θ t`. `pushFun` and
`pushInv` are radial maps (`pushFun_eq_radialMap`, `pushInv_eq_radialMap`). -/
noncomputable def radialMap (P : ℂ) (φ : ℝ) (f : ℝ → ℝ → ℝ) (z : ℂ) : ℂ :=
  P + (f (polarAngle P φ z) ‖z - P‖ : ℂ) * e (polarAngle P φ z)

/-- Spec: the radial map moving no radius is the identity. -/
theorem radialMap_id (P : ℂ) (φ : ℝ) (z : ℂ) : radialMap P φ (fun _ t => t) z = z := (eq_polar_polarAngle P φ z).symm

/-- The push is a radial map. -/
theorem pushFun_eq_radialMap (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) :
    pushFun P θ₁ θ₂ a l b = radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) 1 (l θ) (b θ) t) := rfl

/-- The push back is a radial map. -/
theorem pushInv_eq_radialMap (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) :
    pushInv P θ₁ θ₂ a l b = radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) (l θ) 1 (b θ) t) := rfl

/-- A radial map fixing the radius `0` fixes the centre. -/
theorem radialMap_center {P : ℂ} {φ : ℝ} {f : ℝ → ℝ → ℝ} (hf0 : ∀ θ, f θ 0 = 0) : radialMap P φ f P = P := by
  simp [radialMap, hf0]

/-- A radial map on a polar point (angle in the window, radius positive). -/
theorem radialMap_polar {P : ℂ} {φ θ t : ℝ} {f : ℝ → ℝ → ℝ} (hθ : θ ∈ Ioc (φ - π) (φ + π)) (ht : 0 < t) :
    radialMap P φ f (P + (t : ℂ) * e θ) = P + (f θ t : ℂ) * e θ := by
  have hn : ‖P + (t : ℂ) * e θ - P‖ = t := by
    rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.le]
  rw [radialMap, polarAngle_polar hθ ht, hn]

/-- A radial map fixes a point whose radius it fixes. -/
theorem radialMap_eq_self {P : ℂ} {φ : ℝ} {f : ℝ → ℝ → ℝ} {z : ℂ} (h : f (polarAngle P φ z) ‖z - P‖ = ‖z - P‖) :
    radialMap P φ f z = z := by
  rw [radialMap, h]; exact (eq_polar_polarAngle P φ z).symm

/-- **Radial maps compose ray by ray**: if `f θ` keeps `0` and positive radii positive and `g θ` undoes it on positive radii, the radial
map of `g` undoes that of `f`. -/
theorem radialMap_radialMap {P : ℂ} {φ : ℝ} {f g : ℝ → ℝ → ℝ} (hf0 : ∀ θ, f θ 0 = 0) (hg0 : ∀ θ, g θ 0 = 0)
    (hpos : ∀ θ t, 0 < t → 0 < f θ t) (hgf : ∀ θ t, 0 < t → g θ (f θ t) = t) (z : ℂ) :
    radialMap P φ g (radialMap P φ f z) = z := by
  rcases eq_or_lt_of_le (norm_nonneg (z - P)) with h0 | hr
  · have hz : z = P := sub_eq_zero.mp (norm_eq_zero.mp h0.symm)
    rw [hz, radialMap_center hf0, radialMap_center hg0]
  · have hw : radialMap P φ f z = P + (f (polarAngle P φ z) ‖z - P‖ : ℂ) * e (polarAngle P φ z) := rfl
    rw [hw, radialMap_polar (polarAngle_mem P φ z) (hpos _ _ hr), hgf _ _ hr]
    exact (eq_polar_polarAngle P φ z).symm

/-- The push fixes `0` when `0 ≤ a`. -/
theorem push1_zero {a m m' b : ℝ} (h0 : 0 ≤ a) (ha : a < m) (hb : m < b) : push1 a m m' b 0 = 0 :=
  push1_of_not_mem ha hb (fun h => by linarith [h.1])

/-- The push keeps positive radii positive when `0 < a`. -/
theorem push1_pos {a m m' b t : ℝ} (h0 : 0 < a) (ha : a < m) (hb : m < b) (ha' : a < m') (hb' : m' < b) (ht : 0 < t) :
    0 < push1 a m m' b t := by
  rcases lt_or_ge t a with h | h
  · rw [push1_of_not_mem ha hb (fun h' => by linarith [h'.1])]; exact ht
  rcases lt_trichotomy t m with h' | rfl | h'
  · exact lt_of_lt_of_le h0 (push1_mem_Ico ha hb ha' ⟨h, h'⟩).1
  · rw [push1_mid ha hb]; linarith
  · rcases le_or_gt t b with h'' | h''
    · exact lt_trans (by linarith) (push1_mem_Ioc ha hb hb' ⟨h', h''⟩).1
    · rw [push1_of_not_mem ha hb (fun h3 => by linarith [h3.2])]; exact ht

/-- At each angle both pushes fix `0`. -/
theorem PushProfiles.push1_zero {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (θ : ℝ) :
    push1 (a θ) 1 (l θ) (b θ) 0 = 0 ∧ push1 (a θ) (l θ) 1 (b θ) 0 = 0 := by
  rcases hp.cases θ with ⟨-, h0, hal, hl1, hb⟩ | ⟨-, ha, hl, hb⟩
  · exact ⟨_root_.HadwigerNelson.Plane.push1_zero h0.le (by linarith) hb,
      _root_.HadwigerNelson.Plane.push1_zero h0.le hal (by linarith)⟩
  · rw [ha, hl, hb]; exact ⟨push1_self _ _ _ _, push1_self _ _ _ _⟩

/-- At each angle both pushes keep positive radii positive. -/
theorem PushProfiles.push1_pos {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (θ : ℝ) {t : ℝ} (ht : 0 < t) :
    0 < push1 (a θ) 1 (l θ) (b θ) t ∧ 0 < push1 (a θ) (l θ) 1 (b θ) t := by
  rcases hp.cases θ with ⟨-, h0, hal, hl1, hb⟩ | ⟨-, ha, hl, hb⟩
  · exact ⟨_root_.HadwigerNelson.Plane.push1_pos h0 (by linarith) hb hal (by linarith) ht,
      _root_.HadwigerNelson.Plane.push1_pos h0 hal (by linarith) (by linarith) hb ht⟩
  · rw [ha, hl, hb, push1_self]; exact ⟨ht, ht⟩

/-- At each angle the two pushes are inverse. -/
theorem PushProfiles.push1_push1 {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (θ t : ℝ) :
    push1 (a θ) (l θ) 1 (b θ) (push1 (a θ) 1 (l θ) (b θ) t) = t ∧
      push1 (a θ) 1 (l θ) (b θ) (push1 (a θ) (l θ) 1 (b θ) t) = t := by
  rcases hp.cases θ with ⟨-, h0, hal, hl1, hb⟩ | ⟨-, ha, hl, hb⟩
  · exact ⟨_root_.HadwigerNelson.Plane.push1_push1 (by linarith) hb hal (by linarith) t,
      _root_.HadwigerNelson.Plane.push1_push1 hal (by linarith) (by linarith) hb t⟩
  · rw [ha, hl, hb, push1_self, push1_self]; exact ⟨rfl, rfl⟩

/-- The displacement form of a radial push: `z − (m − m')(θ) · tent(a θ, m θ, b θ, |z − P|) · e θ`, `θ = polarAngle z`. -/
theorem radialMap_push1_eq (P : ℂ) (φ : ℝ) (a m m' b : ℝ → ℝ) (z : ℂ) :
    radialMap P φ (fun θ t => push1 (a θ) (m θ) (m' θ) (b θ) t) z =
      z - (((m (polarAngle P φ z) - m' (polarAngle P φ z)) *
        tent (a (polarAngle P φ z)) (m (polarAngle P φ z)) (b (polarAngle P φ z)) ‖z - P‖ : ℝ) : ℂ) * e (polarAngle P φ z) := by
  have h := eq_polar_polarAngle P φ z
  simp only [radialMap, push1]
  push_cast
  linear_combination (-1 : ℂ) * h

/-- **A radial push is continuous** when its profiles are: `a`, `m`, `m'`, `b` continuous, `a < m < b` inside the sector, `m = m' = 1`
(with `a = b = 1`) off it. The displacement is `0` near the window's slit (whose angles are far from the sector) and near `P` (inside the
inner profile's positive minimum); elsewhere the angle is continuous, and where `m = m'` the displacement is at most `|m − m'| → 0`. -/
theorem continuous_radialMap_push1 {P : ℂ} {θ₁ θ₂ : ℝ} {a l b m m' : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b)
    (hm : Continuous m) (hm' : Continuous m') (hin : ∀ θ ∈ Ioo θ₁ θ₂, a θ < m θ ∧ m θ < b θ)
    (hoff : ∀ θ ∉ Ioo θ₁ θ₂, m θ = 1 ∧ m' θ = 1) :
    Continuous (radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) (m θ) (m' θ) (b θ) t)) := by
  set φ := (θ₁ + θ₂) / 2 with hφ
  set A : ℂ → ℝ := polarAngle P φ with hA
  set D : ℂ → ℂ := fun z => (((m (A z) - m' (A z)) * tent (a (A z)) (m (A z)) (b (A z)) ‖z - P‖ : ℝ) : ℂ) * e (A z) with hD
  have hform : radialMap P φ (fun θ t => push1 (a θ) (m θ) (m' θ) (b θ) t) = fun z => z - D z :=
    funext (radialMap_push1_eq P φ a m m' b)
  rw [hform]
  refine continuous_id.sub (continuous_iff_continuousAt.2 fun z => ?_)
  have hamb : ∀ θ, a θ ≤ m θ ∧ m θ ≤ b θ := by
    intro θ
    by_cases h : θ ∈ Ioo θ₁ θ₂
    · exact ⟨(hin θ h).1.le, (hin θ h).2.le⟩
    · rw [(hp.off θ h).1, (hp.off θ h).2.2, (hoff θ h).1]; exact ⟨le_rfl, le_rfl⟩
  have hD0 : ∀ w, A w ∉ Ioo θ₁ θ₂ → D w = 0 := by
    intro w hw; simp [hD, (hoff _ hw).1, (hoff _ hw).2]
  have hDb : ∀ w, ‖D w‖ ≤ |m (A w) - m' (A w)| := by
    intro w
    simp only [hD, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
    refine mul_le_of_le_one_right (abs_nonneg _) ?_
    rw [abs_of_nonneg (tent_nonneg _ _ _ _)]
    exact tent_le_one (hamb _).1 (hamb _).2
  have hq : Continuous fun w : ℂ => (w - P) * starRingEnd ℂ (e φ) := (continuous_id.sub continuous_const).mul continuous_const
  by_cases hU : ((z - P) * starRingEnd ℂ (e φ)).re < 0
  · -- near the slit: the angle is far from the sector
    have hopen : IsOpen {w : ℂ | ((w - P) * starRingEnd ℂ (e φ)).re < 0} :=
      isOpen_lt (Complex.continuous_re.comp hq) continuous_const
    refine Filter.EventuallyEq.continuousAt (y := 0) ?_
    filter_upwards [hopen.mem_nhds hU] with w hw
    refine hD0 w fun hmem => ?_
    have harg : π / 2 < |arg ((w - P) * starRingEnd ℂ (e φ))| := by
      by_contra h
      exact absurd (Complex.abs_arg_le_pi_div_two_iff.mp (not_lt.mp h)) (not_le.mpr hw)
    have hAw : A w - φ = arg ((w - P) * starRingEnd ℂ (e φ)) := by simp only [hA, polarAngle]; ring
    have hb := abs_sub_bisector_le hp.short (Ioo_subset_Icc_self hmem)
    rw [← hφ, hAw] at hb
    linarith [Real.pi_pos]
  by_cases hP : z = P
  · -- near the centre: inside the inner profile
    obtain ⟨a₀, ha₀, hge⟩ := hp.exists_a_ge
    refine Filter.EventuallyEq.continuousAt (y := 0) ?_
    filter_upwards [Metric.ball_mem_nhds z ha₀] with w hw
    rw [hP, Metric.mem_ball, dist_eq_norm] at hw
    simp only [hD, tent_of_le_left (hamb _).1 (hw.le.trans (hge _)), mul_zero, Complex.ofReal_zero, zero_mul]
  · -- elsewhere the angle is continuous
    have hslit : (z - P) * starRingEnd ℂ (e φ) ∈ slitPlane := by
      rw [mem_slitPlane_iff]
      rcases (not_lt.mp hU).lt_or_eq with h | h
      · exact Or.inl h
      · refine Or.inr fun him => hP ?_
        have h0 : (z - P) * starRingEnd ℂ (e φ) = 0 := Complex.ext h.symm him
        have hc : starRingEnd ℂ (e φ) ≠ 0 := by
          rw [map_ne_zero]; exact e_ne_zero φ
        exact sub_eq_zero.mp ((mul_eq_zero.mp h0).resolve_right hc)
    have hqz : ContinuousAt (fun w : ℂ => (w - P) * starRingEnd ℂ (e φ)) z := hq.continuousAt
    have harg : ContinuousAt (fun w => arg ((w - P) * starRingEnd ℂ (e φ))) z :=
      ContinuousAt.comp (g := arg) (continuousAt_arg hslit) hqz
    have hAc : ContinuousAt A z := continuousAt_const.add harg
    have hmA : ContinuousAt (fun w => m (A w)) z := hm.continuousAt.comp hAc
    have hm'A : ContinuousAt (fun w => m' (A w)) z := hm'.continuousAt.comp hAc
    by_cases hin' : A z ∈ Ioo θ₁ θ₂
    · obtain ⟨h1, h2⟩ := hin _ hin'
      have hr : ContinuousAt (fun w => ‖w - P‖) z := (continuous_norm.comp (continuous_id.sub continuous_const)).continuousAt
      have haA : ContinuousAt (fun w => a (A w)) z := hp.cont_a.continuousAt.comp hAc
      have hbA : ContinuousAt (fun w => b (A w)) z := hp.cont_b.continuousAt.comp hAc
      have hx : ContinuousAt (fun w => (‖w - P‖ - a (A w)) / (m (A w) - a (A w))) z :=
        (hr.sub haA).div (hmA.sub haA) (sub_pos.mpr h1).ne'
      have hy : ContinuousAt (fun w => (b (A w) - ‖w - P‖) / (b (A w) - m (A w))) z :=
        (hbA.sub hr).div (hbA.sub hmA) (sub_pos.mpr h2).ne'
      have hmin : ContinuousAt (fun w => min ((‖w - P‖ - a (A w)) / (m (A w) - a (A w)))
          ((b (A w) - ‖w - P‖) / (b (A w) - m (A w)))) z :=
        continuous_min.continuousAt.comp (hx.prodMk hy)
      have ht : ContinuousAt (fun w => tent (a (A w)) (m (A w)) (b (A w)) ‖w - P‖) z :=
        continuous_max.continuousAt.comp (continuousAt_const.prodMk hmin)
      exact (Complex.continuous_ofReal.continuousAt.comp ((hmA.sub hm'A).mul ht)).mul (continuous_e.continuousAt.comp hAc)
    · have hDz : D z = 0 := hD0 z hin'
      have hlim : Tendsto (fun w => |m (A w) - m' (A w)|) (𝓝 z) (𝓝 0) := by
        have h := (hmA.sub hm'A).abs
        rw [ContinuousAt] at h
        simpa [(hoff _ hin').1, (hoff _ hin').2] using h
      rw [ContinuousAt, hDz]
      exact squeeze_zero_norm hDb hlim

/-- **The push back undoes the push.** Route: `z = P + ‖z − P‖ e(polarAngle z)` (`eq_polar_frameDir`); the push keeps the angle
(`polarAngle (P + t e θ) = θ` for `t > 0`, `θ` in the window) and moves the radius by `push1`, which `push1_push1` inverts; at `z = P`
both fix `P` (`0 < a`). -/
theorem pushInv_pushFun {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (z : ℂ) :
    pushInv P θ₁ θ₂ a l b (pushFun P θ₁ θ₂ a l b z) = z := by
  rw [pushFun_eq_radialMap, pushInv_eq_radialMap]
  exact radialMap_radialMap (fun θ => (hp.push1_zero θ).1) (fun θ => (hp.push1_zero θ).2)
    (fun θ _ ht => (hp.push1_pos θ ht).1) (fun θ t _ => (hp.push1_push1 θ t).1) z

/-- **The push undoes the push back** (the same route). -/
theorem pushFun_pushInv {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (z : ℂ) :
    pushFun P θ₁ θ₂ a l b (pushInv P θ₁ θ₂ a l b z) = z := by
  rw [pushFun_eq_radialMap, pushInv_eq_radialMap]
  exact radialMap_radialMap (fun θ => (hp.push1_zero θ).2) (fun θ => (hp.push1_zero θ).1)
    (fun θ _ ht => (hp.push1_pos θ ht).2) (fun θ t _ => (hp.push1_push1 θ t).2) z

/-- **The push is continuous.** Route: write `pushFun z = z − (1 − l θ) · tent (a θ) 1 (b θ) ‖z − P‖ · e θ`, `θ = polarAngle z`. Off a
compact subset of the open sector it is the identity (near `P`: `‖z − P‖ < a`; near the window's slit: the profiles are `1`); inside,
the angle is continuous (`Complex.continuousAt_arg`); where `l θ = 1` the displacement is `(1 − l θ) ·` a factor in `[0, 1]`, so it
tends to `0` — continuity at the sector's edges with no case on the tent's knots. -/
theorem continuous_pushFun {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) :
    Continuous (pushFun P θ₁ θ₂ a l b) := by
  rw [pushFun_eq_radialMap]
  exact continuous_radialMap_push1 (m := fun _ => 1) hp continuous_const hp.cont_l
    (fun θ h => ⟨by linarith [hp.inside θ h], by linarith [hp.inside θ h]⟩) (fun θ h => ⟨rfl, (hp.off θ h).2.1⟩)

/-- **The push back is continuous** (the same route, the tent's peak at `l θ`). -/
theorem continuous_pushInv {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) :
    Continuous (pushInv P θ₁ θ₂ a l b) := by
  rw [pushInv_eq_radialMap]
  exact continuous_radialMap_push1 (m' := fun _ => 1) hp hp.cont_l continuous_const
    (fun θ h => ⟨(hp.inside θ h).2.1, by linarith [hp.inside θ h]⟩) (fun θ h => ⟨(hp.off θ h).2.1, rfl⟩)

/-- **The radial push**, a homeomorphism of the plane. -/
noncomputable def pushHomeo (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) (hp : PushProfiles θ₁ θ₂ a l b) : ℂ ≃ₜ ℂ where
  toFun := pushFun P θ₁ θ₂ a l b
  invFun := pushInv P θ₁ θ₂ a l b
  left_inv := pushInv_pushFun hp
  right_inv := pushFun_pushInv hp
  continuous_toFun := continuous_pushFun hp
  continuous_invFun := continuous_pushInv hp

/-- **The push on a ray**: `P + t e(θ) ↦ P + push1 (a θ) 1 (l θ) (b θ) t · e(θ)` for `θ ∈ (θ₁, θ₂)`, `t > 0`. Route: `polarAngle` of
`P + t e(θ)` is `θ` (`|θ − φ| < π`), `‖P + t e θ − P‖ = t`. -/
theorem pushHomeo_polar {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) {θ t : ℝ}
    (hθ : θ ∈ Ioo θ₁ θ₂) (ht : 0 < t) :
    pushHomeo P θ₁ θ₂ a l b hp (P + (t : ℂ) * e θ) = P + (push1 (a θ) 1 (l θ) (b θ) t : ℝ) * e θ := by
  show pushFun P θ₁ θ₂ a l b (P + (t : ℂ) * e θ) = _
  rw [pushFun_eq_radialMap, radialMap_polar (mem_window_of_mem_Icc hp.short (Ioo_subset_Icc_self hθ)) ht]

/-- **The push is the identity off the open collar** `{P + t e(θ) : θ ∈ (θ₁, θ₂), a θ < t < b θ}`, and so is the push back. -/
theorem pushHomeo_eq_self {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) {z : ℂ}
    (hz : z ∉ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (a θ) (b θ))) :
    pushHomeo P θ₁ θ₂ a l b hp z = z ∧ (pushHomeo P θ₁ θ₂ a l b hp).symm z = z := by
  have key : ∀ {m m' : ℝ → ℝ}, (∀ θ ∈ Ioo θ₁ θ₂, a θ < m θ ∧ m θ < b θ) → (∀ θ ∉ Ioo θ₁ θ₂, m θ = m' θ) →
      radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) (m θ) (m' θ) (b θ) t) z = z := by
    intro m m' hin hoff
    apply radialMap_eq_self
    by_cases hθ : polarAngle P ((θ₁ + θ₂) / 2) z ∈ Ioo θ₁ θ₂
    · refine push1_of_not_mem (hin _ hθ).1 (hin _ hθ).2 fun hr => ?_
      rcases eq_or_lt_of_le (norm_nonneg (z - P)) with h0 | -
      · rw [← h0] at hr; linarith [hr.1, hp.a_pos (polarAngle P ((θ₁ + θ₂) / 2) z)]
      · exact hz ⟨_, hθ, ‖z - P‖, hr, eq_polar_polarAngle P _ z⟩
    · rw [hoff _ hθ, push1_self]
  refine ⟨?_, ?_⟩
  · show pushFun P θ₁ θ₂ a l b z = z
    rw [pushFun_eq_radialMap]
    exact key (m := fun _ => 1) (fun θ h => ⟨by linarith [hp.inside θ h], by linarith [hp.inside θ h]⟩)
      (fun θ h => (hp.off θ h).2.1.symm)
  · show pushInv P θ₁ θ₂ a l b z = z
    rw [pushInv_eq_radialMap]
    exact key (m' := fun _ => 1) (fun θ h => ⟨(hp.inside θ h).2.1, by linarith [hp.inside θ h]⟩)
      (fun θ h => (hp.off θ h).2.1)

/-- **The push carries polar sets ray by ray**: over angles inside `(θ₁, θ₂)` and positive radii, the image is the polar set of the
images under `push1` (from `pushHomeo_polar`). -/
theorem pushHomeo_image_polarSet {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) {I : Set ℝ}
    (hI : I ⊆ Ioo θ₁ θ₂) {S : ℝ → Set ℝ} (hS : ∀ θ, S θ ⊆ Ioi 0) :
    pushHomeo P θ₁ θ₂ a l b hp '' polarSet P I S = polarSet P I (fun θ => push1 (a θ) 1 (l θ) (b θ) '' S θ) := by
  ext w
  constructor
  · rintro ⟨z, ⟨θ, hθ, t, ht, rfl⟩, rfl⟩
    exact ⟨θ, hθ, push1 (a θ) 1 (l θ) (b θ) t, ⟨t, ht, rfl⟩, pushHomeo_polar hp (hI hθ) (hS θ ht)⟩
  · rintro ⟨θ, hθ, s, ⟨t, ht, rfl⟩, rfl⟩
    exact ⟨P + (t : ℂ) * e θ, ⟨θ, hθ, t, ht, rfl⟩, pushHomeo_polar hp (hI hθ) (hS θ ht)⟩

/-! ## The collar's profiles (D1): circles tangent to `ω(P)` at the arc's ends -/

/-- The distance from `P`, along the ray at angle `u` from `ringPt P θ`, to the circle of radius `R` tangent to `ω(P)` at `ringPt P θ`
(centre `P + (1 − R) e(θ)`; the positive root of `t² − 2(1 − R) t cos u + 1 − 2R = 0`, the only one for `R > 1/2`). -/
noncomputable def tangRad (R u : ℝ) : ℝ := (1 - R) * Real.cos u + √((1 - R) ^ 2 * Real.cos u ^ 2 + 2 * R - 1)

/-- At the point of tangency the circle is at distance `1`. -/
theorem tangRad_zero {R : ℝ} (hR : 0 ≤ R) : tangRad R 0 = 1 := by
  have : (1 - R) ^ 2 * Real.cos 0 ^ 2 + 2 * R - 1 = R ^ 2 := by rw [Real.cos_zero]; ring
  rw [tangRad, this, Real.sqrt_sq hR, Real.cos_zero]; ring

/-- **The radial graph is the circle**: `P + tangRad R u · e(θ + u)` lies on the circle of radius `R` about `P + (1 − R) e(θ)`; and a
point `P + t e(θ + u)`, `t > 0`, lies in its closed disc exactly when `t ≤ tangRad R u` (`R > 1/2`: `P` is inside the disc). -/
theorem tangRad_spec {R : ℝ} (hR : 1 / 2 < R) (P : ℂ) (θ u : ℝ) :
    P + (tangRad R u : ℂ) * e (θ + u) ∈ sphere (P + ((1 - R : ℝ) : ℂ) * e θ) R ∧
      ∀ t : ℝ, 0 < t → (P + (t : ℂ) * e (θ + u) ∈ closedBall (P + ((1 - R : ℝ) : ℂ) * e θ) R ↔ t ≤ tangRad R u) := by
  sorry

/-- **The tangent circles against `ω(P)`**: inside it for `R < 1`, outside for `R > 1`, off the point of tangency (`0 < |u| ≤ π`); and
ordered in `R` (`R' < R` gives `tangRad R' u < tangRad R u` for `0 < |u| ≤ π`). -/
theorem tangRad_lt_one {R u : ℝ} (hR : 1 / 2 < R) (hR1 : R < 1) (hu : 0 < |u|) (hu' : |u| ≤ π) : tangRad R u < 1 := by
  sorry

/-- For `R > 1` the tangent circle lies outside `ω(P)` off the point of tangency. -/
theorem one_lt_tangRad {R u : ℝ} (hR : 1 < R) (hu : 0 < |u|) (hu' : |u| ≤ π) : 1 < tangRad R u := by
  sorry

/-- The tangent circles are ordered by their radius off the point of tangency. -/
theorem tangRad_lt_tangRad {R R' u : ℝ} (hR' : 1 / 2 < R') (hRR : R' < R) (hu : 0 < |u|) (hu' : |u| ≤ π) :
    tangRad R' u < tangRad R u := by
  sorry

/-- **The depth bound**: `1 − tangRad R u ≤ (1 − R)(1 − cos u)/R ≤ (1 − R) u²/(2R)` for `1/2 < R ≤ 1`. Route: from the quadratic,
`(1 − t)(t + 2R − 1) = 2(1 − R) t (1 − cos u)` with `t = tangRad R u ∈ [2R − 1, 1]`. -/
theorem one_sub_tangRad_le {R : ℝ} (hR : 1 / 2 < R) (hR1 : R ≤ 1) (u : ℝ) : 1 - tangRad R u ≤ (1 - R) * u ^ 2 / (2 * R) := by
  sorry

/-- **The height bound** for `R ≥ 1`: `tangRad R u − 1 ≤ (R − 1) u²` (the same identity). -/
theorem tangRad_sub_one_le {R : ℝ} (hR : 1 ≤ R) (u : ℝ) : tangRad R u - 1 ≤ (R - 1) * u ^ 2 := by
  sorry

/-- An angle clamped into `[θ₁, θ₂]`. -/
noncomputable def clampAngle (θ₁ θ₂ θ : ℝ) : ℝ := max θ₁ (min θ θ₂)

/-- **The lens profile** (`R < 1`): the larger of the two tangent circles at the ends `ringPt P θ₁`, `ringPt P θ₂` — `C_A` on `[θ₁, φ]`,
`C_B` on `[φ, θ₂]` — over the clamped angle, so `1` off `(θ₁, θ₂)`. With `R'` in place of `R` it is the collar's inner profile. -/
noncomputable def lensProf (θ₁ θ₂ R θ : ℝ) : ℝ :=
  max (tangRad R (clampAngle θ₁ θ₂ θ - θ₁)) (tangRad R (θ₂ - clampAngle θ₁ θ₂ θ))

/-- **The outer profile** (`R'' > 1`): the smaller of the two enclosing tangent circles at the ends, over the clamped angle. -/
noncomputable def outerProf (θ₁ θ₂ R θ : ℝ) : ℝ :=
  min (tangRad R (clampAngle θ₁ θ₂ θ - θ₁)) (tangRad R (θ₂ - clampAngle θ₁ θ₂ θ))

/-- **The D1 profiles are push profiles** for `1/2 < R' < R < 1 < R''` and an arc of at most `60°`. Route: continuity by composition;
off `(θ₁, θ₂)` the clamped angle is an end, where one term is `tangRad _ 0 = 1` and the other is `< 1` (`max`) or `> 1` (`min`);
inside, `tangRad_lt_one`, `one_lt_tangRad`, `tangRad_lt_tangRad`, and `0 < tangRad R' u` (`R' > 1/2`). -/
theorem pushProfiles_collar {θ₁ θ₂ R' R R'' : ℝ} (hR' : 1 / 2 < R') (hR'R : R' < R) (hR1 : R < 1) (hR'' : 1 < R'')
    (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    PushProfiles θ₁ θ₂ (lensProf θ₁ θ₂ R') (lensProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') := by
  sorry

/-- **The lens lies under the toward profile**: `1 − lensProf θ₁ θ₂ R θ ≤ (1 − R)/R · min (θ − θ₁) (θ₂ − θ)` on `[θ₁, θ₂]` (an arc of at
most `60°`). Route: `1 − lensProf ≤ 1 − tangRad R (θ − θ₁)` and `≤ 1 − tangRad R (θ₂ − θ)`, each `≤ (1 − R) u²/(2R) ≤ (1 − R) u/R`
(`one_sub_tangRad_le`, `u ≤ π/3 < 2`). So `R` close to `1` puts the lens inside `bend_toward`'s profile `ψ · min (θ − θ₁) (θ₂ − θ)`. -/
theorem one_sub_lensProf_le {θ₁ θ₂ R θ : ℝ} (hR : 1 / 2 < R) (hR1 : R < 1) (hθ : θ ∈ Icc θ₁ θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    1 - lensProf θ₁ θ₂ R θ ≤ (1 - R) / R * min (θ - θ₁) (θ₂ - θ) := by
  sorry

/-! ## The collar's sets and the lens boundary as arcs -/

/-- **The collar** `K`: between the inner profile (radius `R'`) and the outer (radius `R''`), over the closed angles. -/
def collarK (P : ℂ) (θ₁ θ₂ R' R'' : ℝ) : Set ℂ :=
  polarSet P (Icc θ₁ θ₂) (fun θ => Icc (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ))

/-- **The recoloured lens** with the open arc: `lensProf θ₁ θ₂ R θ < t ≤ 1`, `θ ∈ (θ₁, θ₂)`. -/
def lensSet (P : ℂ) (θ₁ θ₂ R : ℝ) : Set ℂ := polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc (lensProf θ₁ θ₂ R θ) 1)

/-- **The lens boundary** `β`: `t = lensProf θ₁ θ₂ R θ` over the closed angles (its ends are the arc's ends). -/
def lensCurve (P : ℂ) (θ₁ θ₂ R : ℝ) : Set ℂ := polarSet P (Icc θ₁ θ₂) (fun θ => {lensProf θ₁ θ₂ R θ})

/-- The crossing `X` of the two tangent circles, on the bisector. -/
noncomputable def collarMid (P : ℂ) (θ₁ θ₂ R : ℝ) : ℂ :=
  P + (lensProf θ₁ θ₂ R ((θ₁ + θ₂) / 2) : ℂ) * e ((θ₁ + θ₂) / 2)

/-- The lens boundary's arc from `A = ringPt P θ₁` to `X`: the germ arc of curvature `1/R` leaving `A` along `α`'s direction. -/
noncomputable def collarArcA (P : ℂ) (θ₁ θ₂ R : ℝ) : Arc :=
  germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) (dist (ringPt P θ₁) (collarMid P θ₁ θ₂ R))

/-- The lens boundary's arc from `B = ringPt P θ₂` to `X`: the germ arc of curvature `−1/R` leaving `B` along `α` backwards. -/
noncomputable def collarArcB (P : ℂ) (θ₁ θ₂ R : ℝ) : Arc :=
  germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) (dist (ringPt P θ₂) (collarMid P θ₁ θ₂ R))

/-- **The two arcs are the lens boundary.** Route: `germArc`'s carrier is the branch (`carrier_germArc`), the points
`A + 2R sin(s/2) e(θ₁ + π/2 + s/2)` of the circle about `P + (1 − R) e(θ₁)`; their polar angle about `P` runs from `θ₁` to the
bisector monotonically (`P` is inside the circle), and on that range `C_A` is the larger profile (`tangRad` even, increasing in
`cos u`); symmetrically for `C_B`. -/
theorem collarArcs_carrier {P : ℂ} {θ₁ θ₂ R : ℝ} (hR : 1 / 2 < R) (hR1 : R < 1) (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    (collarArcA P θ₁ θ₂ R).carrier ∪ (collarArcB P θ₁ θ₂ R).carrier = lensCurve P θ₁ θ₂ R := by
  sorry

/-- **No unit pair in a thin sector of the closed unit disc**: two points `P + t e(θ)`, `t ∈ (0, 1]`, with angles in an interval of at
most `60°`, are less than `1` apart (`|z − z'|² < t² + t'² − tt' ≤ 1`; `toward_pairs`'s computation). -/
theorem dist_lt_one_of_mem_polarSet {P : ℂ} {θ₁ θ₂ : ℝ} (hℓ : θ₂ - θ₁ ≤ π / 3) {z z' : ℂ}
    (hz : z ∈ polarSet P (Ioo θ₁ θ₂) (fun _ => Ioc 0 1)) (hz' : z' ∈ polarSet P (Ioo θ₁ θ₂) (fun _ => Ioc 0 1)) :
    dist z z' < 1 := by
  sorry

end HadwigerNelson.Plane
