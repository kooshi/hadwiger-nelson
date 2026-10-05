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

/-- **The tangent circle's quadratic**: for `R > 1/2`, `s² − 2(1 − R) s cos u − (2R − 1) = (s − tangRad R u)(s − t')` with the other root
`t' < 0` (`P` lies inside the circle). -/
theorem tangRad_quad {R : ℝ} (hR : 1 / 2 < R) (u : ℝ) :
    ∃ t' < 0, ∀ s : ℝ, s ^ 2 - 2 * (1 - R) * s * Real.cos u - (2 * R - 1) = (s - tangRad R u) * (s - t') := by
  have hD : 0 < (1 - R) ^ 2 * Real.cos u ^ 2 + 2 * R - 1 := by nlinarith [sq_nonneg ((1 - R) * Real.cos u)]
  have hq2 := Real.sq_sqrt hD.le
  have hq0 := Real.sqrt_nonneg ((1 - R) ^ 2 * Real.cos u ^ 2 + 2 * R - 1)
  have hlt : (1 - R) * Real.cos u < √((1 - R) ^ 2 * Real.cos u ^ 2 + 2 * R - 1) := by
    by_contra h
    push Not at h
    nlinarith [mul_nonneg hq0 (sub_nonneg.mpr h)]
  refine ⟨(1 - R) * Real.cos u - √((1 - R) ^ 2 * Real.cos u ^ 2 + 2 * R - 1), by linarith, fun s => ?_⟩
  rw [tangRad]
  linear_combination hq2

/-- The tangent circle meets every ray from `P` at a positive distance (`R > 1/2`). -/
theorem tangRad_pos {R : ℝ} (hR : 1 / 2 < R) (u : ℝ) : 0 < tangRad R u := by
  obtain ⟨t', ht', hq⟩ := tangRad_quad hR u
  have h0 := hq 0
  nlinarith

/-- For `s > 0`, `s ≤ tangRad R u` exactly when the quadratic is `≤ 0`. -/
theorem le_tangRad_iff {R : ℝ} (hR : 1 / 2 < R) (u : ℝ) {s : ℝ} (hs : 0 < s) :
    s ≤ tangRad R u ↔ s ^ 2 - 2 * (1 - R) * s * Real.cos u - (2 * R - 1) ≤ 0 := by
  obtain ⟨t', ht', hq⟩ := tangRad_quad hR u
  rw [hq s]
  constructor
  · intro h; exact mul_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith)
  · intro h; by_contra h'; push Not at h'; nlinarith [mul_pos (sub_pos.mpr h') (show 0 < s - t' by linarith)]

/-- For `s > 0`, `tangRad R u ≤ s` exactly when the quadratic is `≥ 0`. -/
theorem tangRad_le_iff {R : ℝ} (hR : 1 / 2 < R) (u : ℝ) {s : ℝ} (hs : 0 < s) :
    tangRad R u ≤ s ↔ 0 ≤ s ^ 2 - 2 * (1 - R) * s * Real.cos u - (2 * R - 1) := by
  obtain ⟨t', ht', hq⟩ := tangRad_quad hR u
  rw [hq s]
  constructor
  · intro h; exact mul_nonneg (by linarith) (by linarith)
  · intro h; by_contra h'; push Not at h'; nlinarith [mul_pos (sub_pos.mpr h') (show 0 < s - t' by linarith)]

/-- For `s > 0`, `s < tangRad R u` exactly when the quadratic is `< 0`. -/
theorem lt_tangRad_iff {R : ℝ} (hR : 1 / 2 < R) (u : ℝ) {s : ℝ} (hs : 0 < s) :
    s < tangRad R u ↔ s ^ 2 - 2 * (1 - R) * s * Real.cos u - (2 * R - 1) < 0 := by
  rw [← not_le, ← not_le, tangRad_le_iff hR u hs]

/-- `tangRad R u` is the quadratic's root. -/
theorem tangRad_root {R : ℝ} (hR : 1 / 2 < R) (u : ℝ) :
    tangRad R u ^ 2 - 2 * (1 - R) * tangRad R u * Real.cos u - (2 * R - 1) = 0 := by
  obtain ⟨t', -, hq⟩ := tangRad_quad hR u
  rw [hq]; ring

/-- `cos u < 1` off the point of tangency (`0 < |u| ≤ π`). -/
theorem cos_lt_one_of_abs {u : ℝ} (hu : 0 < |u|) (hu' : |u| ≤ π) : Real.cos u < 1 := by
  refine lt_of_le_of_ne (Real.cos_le_one u) fun h => ?_
  have hpi := Real.pi_pos
  have := (Real.cos_eq_one_iff_of_lt_of_lt (by linarith [neg_abs_le u]) (by linarith [le_abs_self u])).mp h
  rw [this, abs_zero] at hu
  exact lt_irrefl 0 hu

/-- The tangent circle's radial function is continuous in the angle. -/
theorem continuous_tangRad (R : ℝ) : Continuous (tangRad R) := by
  unfold tangRad; fun_prop

/-- **The depth identity**: `(1 − t)(t + 2R − 1) = 2(1 − R) t (1 − cos u)` at `t = tangRad R u`. -/
theorem tangRad_identity {R : ℝ} (hR : 1 / 2 < R) (u : ℝ) :
    (1 - tangRad R u) * (tangRad R u + 2 * R - 1) = 2 * (1 - R) * tangRad R u * (1 - Real.cos u) := by
  linear_combination (-1 : ℝ) * tangRad_root hR u

/-- **The radial graph is the circle**: `P + tangRad R u · e(θ + u)` lies on the circle of radius `R` about `P + (1 − R) e(θ)`; and a
point `P + t e(θ + u)`, `t > 0`, lies in its closed disc exactly when `t ≤ tangRad R u` (`R > 1/2`: `P` is inside the disc). -/
theorem tangRad_spec {R : ℝ} (hR : 1 / 2 < R) (P : ℂ) (θ u : ℝ) :
    P + (tangRad R u : ℂ) * e (θ + u) ∈ sphere (P + ((1 - R : ℝ) : ℂ) * e θ) R ∧
      ∀ t : ℝ, 0 < t → (P + (t : ℂ) * e (θ + u) ∈ closedBall (P + ((1 - R : ℝ) : ℂ) * e θ) R ↔ t ≤ tangRad R u) := by
  have hRpos : 0 < R := by linarith
  have hdist : ∀ s : ℝ, dist (P + (s : ℂ) * e (θ + u)) (P + ((1 - R : ℝ) : ℂ) * e θ) ^ 2 =
      R ^ 2 + (s ^ 2 - 2 * (1 - R) * s * Real.cos u - (2 * R - 1)) := by
    intro s; rw [dist_polar_polar_sq, add_sub_cancel_left]; ring
  refine ⟨?_, fun s hs => ?_⟩
  · rw [mem_sphere, ← pow_left_inj₀ dist_nonneg hRpos.le two_ne_zero, hdist, tangRad_root hR, add_zero]
  · rw [mem_closedBall, ← pow_le_pow_iff_left₀ dist_nonneg hRpos.le two_ne_zero, hdist, le_tangRad_iff hR u hs]
    constructor <;> intro h <;> linarith

/-- **The tangent circles against `ω(P)`**: inside it for `R < 1`, outside for `R > 1`, off the point of tangency (`0 < |u| ≤ π`); and
ordered in `R` (`R' < R` gives `tangRad R' u < tangRad R u` for `0 < |u| ≤ π`). -/
theorem tangRad_lt_one {R u : ℝ} (hR : 1 / 2 < R) (hR1 : R < 1) (hu : 0 < |u|) (hu' : |u| ≤ π) : tangRad R u < 1 := by
  have hc := cos_lt_one_of_abs hu hu'
  by_contra h
  push Not at h
  have := (le_tangRad_iff hR u one_pos).mp h
  nlinarith [mul_pos (sub_pos.mpr hR1) (sub_pos.mpr hc)]

/-- For `R > 1` the tangent circle lies outside `ω(P)` off the point of tangency. -/
theorem one_lt_tangRad {R u : ℝ} (hR : 1 < R) (hu : 0 < |u|) (hu' : |u| ≤ π) : 1 < tangRad R u := by
  have hc := cos_lt_one_of_abs hu hu'
  rw [lt_tangRad_iff (by linarith) u one_pos]
  nlinarith [mul_pos (sub_pos.mpr hR) (sub_pos.mpr hc)]

/-- The tangent circles are ordered by their radius off the point of tangency. -/
theorem tangRad_lt_tangRad {R R' u : ℝ} (hR' : 1 / 2 < R') (hRR : R' < R) (hu : 0 < |u|) (hu' : |u| ≤ π) :
    tangRad R' u < tangRad R u := by
  have hc := cos_lt_one_of_abs hu hu'
  set s := tangRad R' u with hs
  have hs0 : 0 < s := tangRad_pos hR' u
  have hroot := tangRad_root hR' u
  rw [← hs] at hroot
  -- the point of the smaller circle on this ray projects below `1`
  have hp : Real.cos u * s < 1 := by
    by_contra h
    push Not at h
    have hsp : Real.cos u * s < s := by nlinarith
    nlinarith [mul_pos (show 0 < s - Real.cos u * s by linarith) (show 0 < s + Real.cos u * s by linarith),
      mul_nonneg (show 0 ≤ Real.cos u * s - 1 by linarith) (show (0 : ℝ) ≤ R' by linarith)]
  rw [lt_tangRad_iff (by linarith) u hs0]
  nlinarith [mul_pos (sub_pos.mpr hRR) (sub_pos.mpr hp)]

/-- **The depth bound**: `1 − tangRad R u ≤ (1 − R)(1 − cos u)/R ≤ (1 − R) u²/(2R)` for `1/2 < R ≤ 1`. Route: from the quadratic,
`(1 − t)(t + 2R − 1) = 2(1 − R) t (1 − cos u)` with `t = tangRad R u ∈ [2R − 1, 1]`. -/
theorem one_sub_tangRad_le {R : ℝ} (hR : 1 / 2 < R) (hR1 : R ≤ 1) (u : ℝ) : 1 - tangRad R u ≤ (1 - R) * u ^ 2 / (2 * R) := by
  set t := tangRad R u with htdef
  have ht0 : 0 < t := tangRad_pos hR u
  have hid := tangRad_identity hR u
  rw [← htdef] at hid
  have hcos : 1 - Real.cos u ≤ u ^ 2 / 2 := by linarith [Real.one_sub_sq_div_two_le_cos (x := u)]
  have hc1 : 0 ≤ 1 - Real.cos u := by linarith [Real.cos_le_one u]
  have ht1 : t ≤ 1 := by
    by_contra h'; push Not at h'
    have := (lt_tangRad_iff hR u one_pos).mp h'
    nlinarith [mul_nonneg (sub_nonneg.mpr hR1) hc1]
  have hden : 0 < t + 2 * R - 1 := by linarith
  rw [le_div_iff₀ (by linarith)]
  refine le_of_mul_le_mul_right ?_ hden
  have h1 : (1 - t) * (2 * R) * (t + 2 * R - 1) = 2 * R * (2 * (1 - R) * t * (1 - Real.cos u)) := by rw [← hid]; ring
  rw [h1]
  have h2 : 2 * (1 - R) * t * (1 - Real.cos u) ≤ (1 - R) * t * u ^ 2 := by
    nlinarith [mul_nonneg (mul_nonneg (sub_nonneg.mpr hR1) ht0.le) (sub_nonneg.mpr hcos)]
  have h3 : 2 * R * t ≤ t + 2 * R - 1 := by nlinarith
  nlinarith [mul_nonneg (mul_nonneg (sub_nonneg.mpr hR1) (sq_nonneg u)) (sub_nonneg.mpr h3)]

/-- **The height bound** for `R ≥ 1`: `tangRad R u − 1 ≤ (R − 1) u²` (the same identity). -/
theorem tangRad_sub_one_le {R : ℝ} (hR : 1 ≤ R) (u : ℝ) : tangRad R u - 1 ≤ (R - 1) * u ^ 2 := by
  have hR2 : 1 / 2 < R := by linarith
  set t := tangRad R u with htdef
  have ht0 : 0 < t := tangRad_pos hR2 u
  have hid := tangRad_identity hR2 u
  rw [← htdef] at hid
  have hcos : 1 - Real.cos u ≤ u ^ 2 / 2 := by linarith [Real.one_sub_sq_div_two_le_cos (x := u)]
  have hc1 : 0 ≤ 1 - Real.cos u := by linarith [Real.cos_le_one u]
  have hden : 0 < t + 2 * R - 1 := by linarith
  refine le_of_mul_le_mul_right ?_ hden
  have h1 : (t - 1) * (t + 2 * R - 1) = 2 * (R - 1) * t * (1 - Real.cos u) := by linear_combination (-1 : ℝ) * hid
  rw [h1]
  have h2 : 2 * (R - 1) * t * (1 - Real.cos u) ≤ (R - 1) * t * u ^ 2 := by
    nlinarith [mul_nonneg (mul_nonneg (sub_nonneg.mpr hR) ht0.le) (sub_nonneg.mpr hcos)]
  nlinarith [mul_nonneg (mul_nonneg (sub_nonneg.mpr hR) (sq_nonneg u)) (show (0 : ℝ) ≤ 2 * R - 1 by linarith)]

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
  have hπ := Real.pi_pos
  have hd0 : 0 < |θ₂ - θ₁| := abs_pos.mpr (by linarith)
  have hd1 : |θ₂ - θ₁| ≤ π := by rw [abs_of_pos (by linarith)]; linarith
  have hcl : Continuous (clampAngle θ₁ θ₂) := continuous_const.max (continuous_id.min continuous_const)
  have hcont : ∀ R₀, Continuous (lensProf θ₁ θ₂ R₀) ∧ Continuous (outerProf θ₁ θ₂ R₀) := fun R₀ =>
    ⟨((continuous_tangRad R₀).comp (hcl.sub continuous_const)).max ((continuous_tangRad R₀).comp (continuous_const.sub hcl)),
      ((continuous_tangRad R₀).comp (hcl.sub continuous_const)).min ((continuous_tangRad R₀).comp (continuous_const.sub hcl))⟩
  have hR0 : (0 : ℝ) ≤ R' := by linarith
  -- off the open sector the clamped angle is an end
  have hend : ∀ θ ∉ Ioo θ₁ θ₂, clampAngle θ₁ θ₂ θ = θ₁ ∨ clampAngle θ₁ θ₂ θ = θ₂ := by
    intro θ hθ
    simp only [mem_Ioo, not_and_or, not_lt] at hθ
    unfold clampAngle
    rcases hθ with h | h
    · left; rw [min_eq_left (by linarith), max_eq_left h]
    · right; rw [min_eq_right h, max_eq_right (by linarith)]
  have hlens1 : ∀ R₀, 1 / 2 < R₀ → R₀ < 1 → ∀ θ ∉ Ioo θ₁ θ₂, lensProf θ₁ θ₂ R₀ θ = 1 := by
    intro R₀ h1 h2 θ hθ
    have hlt := tangRad_lt_one h1 h2 hd0 hd1
    unfold lensProf
    rcases hend θ hθ with h | h <;> rw [h]
    · rw [sub_self, tangRad_zero (by linarith), max_eq_left hlt.le]
    · rw [sub_self, tangRad_zero (by linarith), max_eq_right hlt.le]
  refine ⟨h12, hℓ, (hcont R').1, (hcont R).1, (hcont R'').2, fun θ hθ => ?_, fun θ hθ => ?_⟩
  · refine ⟨hlens1 R' hR' (by linarith) θ hθ, hlens1 R (by linarith) hR1 θ hθ, ?_⟩
    have hgt := one_lt_tangRad hR'' hd0 hd1
    unfold outerProf
    rcases hend θ hθ with h | h <;> rw [h]
    · rw [sub_self, tangRad_zero (by linarith), min_eq_left hgt.le]
    · rw [sub_self, tangRad_zero (by linarith), min_eq_right hgt.le]
  · have hc : clampAngle θ₁ θ₂ θ = θ := by
      unfold clampAngle; rw [min_eq_left hθ.2.le, max_eq_right hθ.1.le]
    have hu1 : 0 < |θ - θ₁| := abs_pos.mpr (by linarith [hθ.1])
    have hu1' : |θ - θ₁| ≤ π := by rw [abs_of_pos (by linarith [hθ.1])]; linarith [hθ.2]
    have hu2 : 0 < |θ₂ - θ| := abs_pos.mpr (by linarith [hθ.2])
    have hu2' : |θ₂ - θ| ≤ π := by rw [abs_of_pos (by linarith [hθ.2])]; linarith [hθ.1]
    unfold lensProf outerProf
    rw [hc]
    refine ⟨lt_max_of_lt_left (tangRad_pos hR' _), max_lt (lt_max_of_lt_left (tangRad_lt_tangRad hR' hR'R hu1 hu1'))
      (lt_max_of_lt_right (tangRad_lt_tangRad hR' hR'R hu2 hu2')), max_lt (tangRad_lt_one (by linarith) hR1 hu1 hu1')
      (tangRad_lt_one (by linarith) hR1 hu2 hu2'), lt_min (one_lt_tangRad hR'' hu1 hu1') (one_lt_tangRad hR'' hu2 hu2')⟩

/-- Spec: the collar's profiles at concrete radii (`R' = 3/4`, `R = 7/8`, `R'' = 5/4`, over `[0, π/6]`) are push profiles — the
hypotheses of `pushProfiles_collar` are met together. -/
example : PushProfiles 0 (π / 6) (lensProf 0 (π / 6) (3 / 4)) (lensProf 0 (π / 6) (7 / 8)) (outerProf 0 (π / 6) (5 / 4)) :=
  pushProfiles_collar (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by positivity) (by linarith [Real.pi_pos])

/-- **The lens lies under the toward profile**: `1 − lensProf θ₁ θ₂ R θ ≤ (1 − R)/R · min (θ − θ₁) (θ₂ − θ)` on `[θ₁, θ₂]` (an arc of at
most `60°`). Route: `1 − lensProf ≤ 1 − tangRad R (θ − θ₁)` and `≤ 1 − tangRad R (θ₂ − θ)`, each `≤ (1 − R) u²/(2R) ≤ (1 − R) u/R`
(`one_sub_tangRad_le`, `u ≤ π/3 < 2`). So `R` close to `1` puts the lens inside `bend_toward`'s profile `ψ · min (θ − θ₁) (θ₂ − θ)`. -/
theorem one_sub_lensProf_le {θ₁ θ₂ R θ : ℝ} (hR : 1 / 2 < R) (hR1 : R < 1) (hθ : θ ∈ Icc θ₁ θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    1 - lensProf θ₁ θ₂ R θ ≤ (1 - R) / R * min (θ - θ₁) (θ₂ - θ) := by
  have hπ : π < 4 := Real.pi_lt_four
  have hc : clampAngle θ₁ θ₂ θ = θ := by
    unfold clampAngle; rw [min_eq_left hθ.2, max_eq_right hθ.1]
  have hRpos : 0 < R := by linarith
  have hk : 0 ≤ (1 - R) / R := div_nonneg (by linarith) hRpos.le
  -- each side: `1 − tangRad R u ≤ (1 − R) u²/(2R) ≤ (1 − R) u / R` for `0 ≤ u ≤ π/3 < 2`
  have side : ∀ u, 0 ≤ u → u ≤ π / 3 → 1 - tangRad R u ≤ (1 - R) / R * u := by
    intro u hu0 hu1
    refine (one_sub_tangRad_le hR hR1.le u).trans ?_
    rw [div_le_iff₀ (by linarith)]
    have : (1 - R) / R * u * (2 * R) = (1 - R) * (2 * u) := by field_simp
    rw [this]
    exact mul_le_mul_of_nonneg_left (by nlinarith) (by linarith)
  unfold lensProf
  rw [hc, mul_min_of_nonneg _ _ hk]
  refine le_min ?_ ?_
  · exact (sub_le_sub_left (le_max_left _ _) 1).trans (side _ (by linarith [hθ.1]) (by linarith [hθ.2]))
  · exact (sub_le_sub_left (le_max_right _ _) 1).trans (side _ (by linarith [hθ.2]) (by linarith [hθ.1]))

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

/-! ### The lens boundary's arcs (FS131-CG1)

In the frame `w = (z − P) e(θ_E)‾` at an end `θ_E`, the tangent circle is the circle about `1 − R` of radius `R`, tangent to the unit
circle at `1`; the end's germ arc is `s ↦ 1 + s e(π/2 + arcsin(s/2R))` (chord parameter `s`, closed upper side), and the lens curve is
`u ↦ tangRad R u · e(u)`. Both are the points of that circle on the closed upper side within a chord `ρ` of `1`, which a point of the
circle there is determined by (`eq_of_tangentCircle`). At `A` the frame is `w`, at `B` its mirror `w‾`. -/

/-- The tangent circle's radial function decreases in `|u|` on `[0, π]` (`R ≤ 1`). -/
theorem tangRad_anti {R u u' : ℝ} (hR : 1 / 2 < R) (hR1 : R ≤ 1) (hu : 0 ≤ u) (huu : u ≤ u') (hu' : u' ≤ π) :
    tangRad R u' ≤ tangRad R u := by
  have hs := tangRad_pos hR u'
  rw [le_tangRad_iff hR u hs]
  have hroot := tangRad_root hR u'
  have hc : Real.cos u' ≤ Real.cos u := Real.cos_le_cos_of_nonneg_of_le_pi hu hu' huu
  nlinarith [mul_nonneg (mul_nonneg (sub_nonneg.mpr hR1) hs.le) (sub_nonneg.mpr hc)]

/-- **A point of the tangent circle is determined by its chord from `1`** on the closed upper side. -/
theorem eq_of_tangentCircle {R : ℝ} (hR : 0 < R) {W W' : ℂ} (hW : ‖W - ((1 - R : ℝ) : ℂ)‖ = R)
    (hW' : ‖W' - ((1 - R : ℝ) : ℂ)‖ = R) (him : 0 ≤ W.im) (him' : 0 ≤ W'.im) (hc : ‖W - 1‖ = ‖W' - 1‖) : W = W' := by
  have e1 := congrArg (· ^ 2) hW
  have e2 := congrArg (· ^ 2) hW'
  have e3 := congrArg (· ^ 2) hc
  simp only [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.one_re, Complex.one_im, sub_zero] at e1 e2 e3
  have hx : W.re = W'.re := by
    have h : R * (W.re - W'.re) = 0 := by linear_combination (-1 / 2 : ℝ) * e3 + (1 / 2 : ℝ) * e1 - (1 / 2 : ℝ) * e2
    have := (mul_eq_zero.mp h).resolve_left hR.ne'
    linarith
  have hy : W.im = W'.im := by
    have h : W.im ^ 2 = W'.im ^ 2 := by rw [hx] at e1; nlinarith
    exact (pow_left_inj₀ him him' two_ne_zero).mp h
  exact Complex.ext hx hy

/-- The germ arc at an end, in the end's frame: on the tangent circle, on the closed upper side, at chord `s` from `1` (`0 ≤ s ≤ 2R`). -/
theorem germ_tangentCircle {R s : ℝ} (hR : 0 < R) (hs : 0 ≤ s) (hs2 : s ≤ 2 * R) :
    ‖(1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) - ((1 - R : ℝ) : ℂ)‖ = R ∧
      0 ≤ (1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))).im ∧
      ‖(1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) - 1‖ = s := by
  set δ := Real.arcsin (s / (2 * R)) with hδ
  have hx1 : s / (2 * R) ≤ 1 := (div_le_one (by linarith)).mpr hs2
  have hx0 : -1 ≤ s / (2 * R) := by have : 0 ≤ s / (2 * R) := div_nonneg hs (by linarith); linarith
  have hsin : Real.sin δ = s / (2 * R) := Real.sin_arcsin hx0 hx1
  have hcos : 0 ≤ Real.cos δ := Real.cos_arcsin_nonneg _
  rw [show π / 2 + δ = δ + π / 2 by ring]
  refine ⟨?_, ?_, ?_⟩
  · have hsq : ‖(1 + (s : ℂ) * e (δ + π / 2)) - ((1 - R : ℝ) : ℂ)‖ ^ 2 = R ^ 2 := by
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im,
        Complex.re_ofReal_mul, Complex.im_ofReal_mul, re_e, im_e, Complex.ofReal_re, Complex.ofReal_im, Real.cos_add_pi_div_two,
        Real.sin_add_pi_div_two, hsin]
      have hc2 : Real.cos δ ^ 2 = 1 - (s / (2 * R)) ^ 2 := by rw [← hsin]; linarith [Real.sin_sq_add_cos_sq δ]
      have hRR : R * R⁻¹ = 1 := mul_inv_cancel₀ hR.ne'
      linear_combination s ^ 2 * hc2 - s ^ 2 * hRR
    exact (pow_left_inj₀ (norm_nonneg _) hR.le two_ne_zero).mp hsq
  · simp only [Complex.add_im, Complex.one_im, Complex.im_ofReal_mul, im_e, Real.sin_add_pi_div_two, zero_add]
    exact mul_nonneg hs hcos
  · rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hs]

/-- The lens curve at an end, in the end's frame: on the tangent circle (`tangRad_spec`), on the closed upper side for `u ∈ [0, π]`,
at squared chord `2R(1 − t cos u)` from `1`. -/
theorem polar_tangentCircle {R u : ℝ} (hR : 1 / 2 < R) (hu : 0 ≤ u) (hu' : u ≤ π) :
    ‖(tangRad R u : ℂ) * e u - ((1 - R : ℝ) : ℂ)‖ = R ∧ 0 ≤ ((tangRad R u : ℂ) * e u).im ∧
      ‖(tangRad R u : ℂ) * e u - 1‖ ^ 2 = 2 * R * (1 - tangRad R u * Real.cos u) := by
  have ht := tangRad_pos hR u
  refine ⟨?_, ?_, ?_⟩
  · have h := (tangRad_spec hR 0 0 u).1
    simp only [zero_add, e_zero, mul_one, mem_sphere, dist_eq_norm] at h
    exact h
  · rw [Complex.im_ofReal_mul, im_e]; exact mul_nonneg ht.le (Real.sin_nonneg_of_nonneg_of_le_pi hu hu')
  · have h := dist_polar_polar_sq 0 (tangRad R u) 1 u 0
    simp only [zero_add, e_zero, Complex.ofReal_one, mul_one, sub_zero, dist_eq_norm] at h
    rw [h]
    linear_combination tangRad_root hR u

/-- The lens curve's chord from the point of tangency is at most the circle's diameter. -/
theorem norm_tangRad_sub_one_le {R u : ℝ} (hR : 1 / 2 < R) (hu : 0 ≤ u) (hu' : u ≤ π) :
    ‖(tangRad R u : ℂ) * e u - 1‖ ≤ 2 * R := by
  have hRpos : 0 < R := by linarith
  obtain ⟨h1, -, -⟩ := polar_tangentCircle hR hu hu'
  calc ‖(tangRad R u : ℂ) * e u - 1‖ = ‖((tangRad R u : ℂ) * e u - ((1 - R : ℝ) : ℂ)) + (((1 - R : ℝ) : ℂ) - 1)‖ := by
        congr 1; ring
    _ ≤ ‖(tangRad R u : ℂ) * e u - ((1 - R : ℝ) : ℂ)‖ + ‖((1 - R : ℝ) : ℂ) - 1‖ := norm_add_le _ _
    _ = 2 * R := by
      rw [h1, show ((1 - R : ℝ) : ℂ) - 1 = ((-R : ℝ) : ℂ) by push_cast; ring, Complex.norm_real, Real.norm_eq_abs,
        abs_neg, abs_of_pos hRpos]; ring

/-- **The tangent circle's arc from its point of tangency, two ways** (normal position): the germ arc by chord, out to the chord `ρ` of
the lens curve's point at angle `uX ∈ [0, π/2]`, is the lens curve over `[0, uX]`. Route: both lie on the circle's closed upper side
(`germ_tangentCircle`, `polar_tangentCircle`), where a point is determined by its chord (`eq_of_tangentCircle`); the lens curve's chord
increases on `[0, π/2]` from `0` to `ρ` (so the intermediate value theorem matches every chord). -/
theorem tangentArc_image {R uX : ℝ} (hR : 1 / 2 < R) (hR1 : R ≤ 1) (hu0 : 0 ≤ uX) (hu1 : uX ≤ π / 2) :
    (fun s : ℝ => 1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) '' Icc 0 ‖(tangRad R uX : ℂ) * e uX - 1‖ =
      (fun u : ℝ => (tangRad R u : ℂ) * e u) '' Icc 0 uX := by
  have hRpos : 0 < R := by linarith
  have hπ := Real.pi_pos
  set f : ℝ → ℝ := fun u => ‖(tangRad R u : ℂ) * e u - 1‖ with hf
  have hfc : Continuous f :=
    continuous_norm.comp (((Complex.continuous_ofReal.comp (continuous_tangRad R)).mul continuous_e).sub continuous_const)
  have hf0 : f 0 = 0 := by simp [hf, tangRad_zero hRpos.le, e_zero]
  -- the chord is at most the diameter
  have hf2 : ∀ u, 0 ≤ u → u ≤ π → f u ≤ 2 * R := fun u hu hu' => norm_tangRad_sub_one_le hR hu hu'
  -- the chord increases on `[0, π/2]`
  have hmono : ∀ u u', 0 ≤ u → u ≤ u' → u' ≤ π / 2 → f u ≤ f u' := by
    intro u u' hu huu hu'
    obtain ⟨-, -, h⟩ := polar_tangentCircle hR hu (by linarith)
    obtain ⟨-, -, h'⟩ := polar_tangentCircle hR (hu.trans huu) (by linarith)
    have ht := tangRad_anti hR hR1 hu huu (by linarith)
    have hc := Real.cos_le_cos_of_nonneg_of_le_pi hu (by linarith) huu
    have hc0 : 0 ≤ Real.cos u' := Real.cos_nonneg_of_mem_Icc ⟨by linarith, hu'⟩
    have ht0 := (tangRad_pos hR u').le
    have hprod : tangRad R u' * Real.cos u' ≤ tangRad R u * Real.cos u := by
      nlinarith [mul_le_mul_of_nonneg_left hc ht0, mul_le_mul_of_nonneg_right ht (hc0.trans hc)]
    refine (pow_le_pow_iff_left₀ (norm_nonneg _) (norm_nonneg _) two_ne_zero).mp ?_
    show ‖(tangRad R u : ℂ) * e u - 1‖ ^ 2 ≤ ‖(tangRad R u' : ℂ) * e u' - 1‖ ^ 2
    rw [h, h']; nlinarith
  ext W
  constructor
  · rintro ⟨s, hs, rfl⟩
    obtain ⟨u, hu, hfu⟩ := intermediate_value_Icc hu0 hfc.continuousOn (by rw [hf0]; exact hs)
    have hs2 : s ≤ 2 * R := hs.2.trans (hf2 uX hu0 (by linarith))
    obtain ⟨g1, g2, g3⟩ := germ_tangentCircle hRpos hs.1 hs2
    obtain ⟨p1, p2, -⟩ := polar_tangentCircle hR hu.1 (by linarith [hu.2])
    exact ⟨u, hu, eq_of_tangentCircle hRpos p1 g1 p2 g2 (by rw [g3]; exact hfu)⟩
  · rintro ⟨u, hu, rfl⟩
    have hs := hmono u uX hu.1 hu.2 hu1
    have hs2 : f u ≤ 2 * R := hf2 u hu.1 (by linarith [hu.2])
    obtain ⟨g1, g2, g3⟩ := germ_tangentCircle hRpos (norm_nonneg _) hs2
    obtain ⟨p1, p2, -⟩ := polar_tangentCircle hR hu.1 (by linarith [hu.2])
    exact ⟨f u, ⟨norm_nonneg _, hs⟩, eq_of_tangentCircle hRpos g1 p1 g2 p2 (by rw [g3])⟩

/-- **The two arcs are the lens boundary.** Route: `germArc`'s carrier is the branch (`carrier_germArc`), the points
`A + 2R sin(s/2) e(θ₁ + π/2 + s/2)` of the circle about `P + (1 − R) e(θ₁)`; their polar angle about `P` runs from `θ₁` to the
bisector monotonically (`P` is inside the circle), and on that range `C_A` is the larger profile (`tangRad` even, increasing in
`cos u`); symmetrically for `C_B`. -/
theorem collarArcs_carrier {P : ℂ} {θ₁ θ₂ R : ℝ} (hR : 1 / 2 < R) (hR1 : R < 1) (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    (collarArcA P θ₁ θ₂ R).carrier ∪ (collarArcB P θ₁ θ₂ R).carrier = lensCurve P θ₁ θ₂ R := by
  have hπ := Real.pi_pos
  have hRpos : 0 < R := by linarith
  obtain ⟨uX, huX⟩ : ∃ uX : ℝ, uX = (θ₂ - θ₁) / 2 := ⟨_, rfl⟩
  have hu0 : 0 ≤ uX := by rw [huX]; linarith
  have hu1 : uX ≤ π / 2 := by rw [huX]; linarith
  have hmidA : (θ₁ + θ₂) / 2 = θ₁ + uX := by rw [huX]; ring
  have hmidB : (θ₁ + θ₂) / 2 = θ₂ - uX := by rw [huX]; ring
  set ρ := ‖(tangRad R uX : ℂ) * e uX - 1‖ with hρ
  have hρ0 : 0 ≤ ρ := norm_nonneg _
  have hρ2 : ρ ≤ 2 * R := norm_tangRad_sub_one_le hR hu0 (by linarith)
  have hκρ : (1 / R) * ρ ≤ 2 := by rw [div_mul_eq_mul_div, one_mul, div_le_iff₀ hRpos]; linarith
  -- the lens profile on each half
  have hL1 : ∀ θ ∈ Icc θ₁ (θ₁ + uX), lensProf θ₁ θ₂ R θ = tangRad R (θ - θ₁) := by
    intro θ hθ
    have hc : clampAngle θ₁ θ₂ θ = θ := by
      unfold clampAngle; rw [min_eq_left (by linarith [hθ.2]), max_eq_right hθ.1]
    unfold lensProf; rw [hc]
    exact max_eq_left (tangRad_anti hR hR1.le (by linarith [hθ.1]) (by linarith [hθ.2]) (by linarith [hθ.1]))
  have hL2 : ∀ θ ∈ Icc (θ₂ - uX) θ₂, lensProf θ₁ θ₂ R θ = tangRad R (θ₂ - θ) := by
    intro θ hθ
    have hc : clampAngle θ₁ θ₂ θ = θ := by
      unfold clampAngle; rw [min_eq_left hθ.2, max_eq_right (by linarith [hθ.1])]
    unfold lensProf; rw [hc]
    exact max_eq_right (tangRad_anti hR hR1.le (by linarith [hθ.2]) (by linarith [hθ.1]) (by linarith [hθ.2]))
  -- the crossing, and the two chords to it
  have hX : collarMid P θ₁ θ₂ R = P + (tangRad R uX : ℂ) * e (θ₁ + uX) := by
    rw [collarMid, hmidA, hL1 _ ⟨by linarith, le_rfl⟩, add_sub_cancel_left]
  have hρA : dist (ringPt P θ₁) (collarMid P θ₁ θ₂ R) = ρ := by
    rw [hX, dist_comm, dist_eq_norm, ringPt,
      show P + (tangRad R uX : ℂ) * e (θ₁ + uX) - (P + e θ₁) = ((tangRad R uX : ℂ) * e uX - 1) * e θ₁ by rw [e_add]; ring,
      norm_mul, norm_e, mul_one]
  have hρB : dist (ringPt P θ₂) (collarMid P θ₁ θ₂ R) = ρ := by
    rw [hX, show θ₁ + uX = θ₂ - uX by linarith, dist_comm, dist_eq_norm, ringPt,
      show P + (tangRad R uX : ℂ) * e (θ₂ - uX) - (P + e θ₂) = starRingEnd ℂ ((tangRad R uX : ℂ) * e uX - 1) * e θ₂ by
        rw [map_sub, map_one, map_mul, Complex.conj_ofReal, conj_e, sub_eq_add_neg θ₂ uX, e_add]; ring,
      norm_mul, norm_e, mul_one, RCLike.norm_conj]
  -- the germ arcs in their ends' frames
  have hbA : ∀ s : ℝ, branchPt (ringPt P θ₁) (θ₁ + π / 2) (1 / R) s =
      P + (1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) * e θ₁ := by
    intro s
    rw [branchPt, ringPt, show 1 / R * s / 2 = s / (2 * R) by ring,
      show θ₁ + π / 2 + Real.arcsin (s / (2 * R)) = θ₁ + (π / 2 + Real.arcsin (s / (2 * R))) by ring, e_add]
    ring
  have hbB : ∀ s : ℝ, branchPt (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) s =
      P + starRingEnd ℂ (1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) * e θ₂ := by
    intro s
    rw [branchPt, ringPt, show -(1 / R) * s / 2 = -(s / (2 * R)) by ring, Real.arcsin_neg, map_add, map_one, map_mul,
      Complex.conj_ofReal, conj_e,
      show θ₂ - π / 2 + -Real.arcsin (s / (2 * R)) = θ₂ + -(π / 2 + Real.arcsin (s / (2 * R))) by ring, e_add]
    ring
  have himg := tangentArc_image hR hR1.le hu0 hu1
  rw [← hρ] at himg
  have hcA : (collarArcA P θ₁ θ₂ R).carrier = (fun u : ℝ => P + ((tangRad R u : ℂ) * e u) * e θ₁) '' Icc 0 uX := by
    rw [collarArcA, hρA, carrier_germArc _ _ hρ0 (by rwa [abs_of_pos (one_div_pos.mpr hRpos)])]
    have h : branchPt (ringPt P θ₁) (θ₁ + π / 2) (1 / R) '' Icc 0 ρ = (fun w : ℂ => P + w * e θ₁) ''
        ((fun s : ℝ => 1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) '' Icc 0 ρ) := by
      rw [Set.image_image]; exact Set.image_congr fun s _ => hbA s
    rw [h, himg, Set.image_image]
  have hcB : (collarArcB P θ₁ θ₂ R).carrier =
      (fun u : ℝ => P + starRingEnd ℂ ((tangRad R u : ℂ) * e u) * e θ₂) '' Icc 0 uX := by
    rw [collarArcB, hρB, carrier_germArc _ _ hρ0 (by rwa [abs_neg, abs_of_pos (one_div_pos.mpr hRpos)])]
    have h : branchPt (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) '' Icc 0 ρ = (fun w : ℂ => P + starRingEnd ℂ w * e θ₂) ''
        ((fun s : ℝ => 1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) '' Icc 0 ρ) := by
      rw [Set.image_image]; exact Set.image_congr fun s _ => hbB s
    rw [h, himg, Set.image_image]
  rw [hcA, hcB]
  ext z
  constructor
  · rintro (⟨u, hu, rfl⟩ | ⟨u, hu, rfl⟩)
    · refine ⟨θ₁ + u, ⟨by linarith [hu.1], by linarith [hu.2]⟩, tangRad R u, ?_, ?_⟩
      · rw [mem_singleton_iff, hL1 _ ⟨by linarith [hu.1], by linarith [hu.2]⟩, add_sub_cancel_left]
      · rw [e_add]; ring
    · refine ⟨θ₂ - u, ⟨by linarith [hu.2], by linarith [hu.1]⟩, tangRad R u, ?_, ?_⟩
      · rw [mem_singleton_iff, hL2 _ ⟨by linarith [hu.2], by linarith [hu.1]⟩, sub_sub_cancel]
      · beta_reduce
        rw [map_mul, Complex.conj_ofReal, conj_e, sub_eq_add_neg θ₂ u, e_add]; ring
  · rintro ⟨θ, hθ, s, hs, rfl⟩
    rw [mem_singleton_iff] at hs
    subst hs
    rcases le_total θ (θ₁ + uX) with h | h
    · left
      refine ⟨θ - θ₁, ⟨by linarith [hθ.1], by linarith⟩, ?_⟩
      beta_reduce
      rw [hL1 _ ⟨hθ.1, h⟩, mul_assoc, ← e_add, sub_add_cancel]
    · right
      refine ⟨θ₂ - θ, ⟨by linarith [hθ.2], by linarith⟩, ?_⟩
      beta_reduce
      rw [hL2 _ ⟨by linarith, hθ.2⟩, map_mul, Complex.conj_ofReal, conj_e, mul_assoc, ← e_add,
        show -(θ₂ - θ) + θ₂ = θ by ring]

/-- **No unit pair in a thin sector of the closed unit disc**: two points `P + t e(θ)`, `t ∈ (0, 1]`, with angles in an interval of at
most `60°`, are less than `1` apart (`|z − z'|² < t² + t'² − tt' ≤ 1`; `toward_pairs`'s computation). -/
theorem dist_lt_one_of_mem_polarSet {P : ℂ} {θ₁ θ₂ : ℝ} (hℓ : θ₂ - θ₁ ≤ π / 3) {z z' : ℂ}
    (hz : z ∈ polarSet P (Ioo θ₁ θ₂) (fun _ => Ioc 0 1)) (hz' : z' ∈ polarSet P (Ioo θ₁ θ₂) (fun _ => Ioc 0 1)) :
    dist z z' < 1 := by
  obtain ⟨θ, hθ, t, ht, rfl⟩ := hz
  obtain ⟨θ', hθ', t', ht', rfl⟩ := hz'
  have hπ := Real.pi_pos
  have hcos : 1 / 2 < Real.cos (θ - θ') := by
    rw [← Real.cos_abs, ← Real.cos_pi_div_three]
    refine Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) ?_
    rw [abs_lt]; constructor <;> linarith [hθ.1, hθ.2, hθ'.1, hθ'.2]
  have h2 : dist (P + (t : ℂ) * e θ) (P + (t' : ℂ) * e θ') ^ 2 < 1 := by
    rw [dist_polar_polar_sq]
    have htt : 0 < t * t' := mul_pos ht.1 ht'.1
    nlinarith [mul_nonneg (sub_nonneg.mpr ht.2) ht'.1.le, mul_nonneg (sub_nonneg.mpr ht'.2) ht.1.le,
      mul_nonneg (sub_nonneg.mpr ht.2) (sub_nonneg.mpr ht'.2)]
  nlinarith [dist_nonneg (x := P + (t : ℂ) * e θ) (y := P + (t' : ℂ) * e θ')]

end HadwigerNelson.Plane
