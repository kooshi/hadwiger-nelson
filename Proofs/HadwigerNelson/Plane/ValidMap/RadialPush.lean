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

/-- **The push's inverse is the push back**: `push1 a m' m b ∘ push1 a m m' b = id` for `a < m, m' < b` (piecewise-linear algebra on
`[a, m]`, `[m, b]` and their images `[a, m']`, `[m', b]`). -/
theorem push1_push1 {a m m' b : ℝ} (ha : a < m) (hb : m < b) (ha' : a < m') (hb' : m' < b) (t : ℝ) :
    push1 a m' m b (push1 a m m' b t) = t := by
  sorry

/-- The push maps `[a, m)` onto `[a, m')` (it is increasing and fixes `a`). -/
theorem push1_image_Ico {a m m' b : ℝ} (ha : a < m) (hb : m < b) (ha' : a < m') (hb' : m' < b) :
    push1 a m m' b '' Ico a m = Ico a m' := by
  sorry

/-- The push maps `(m, b]` onto `(m', b]`. -/
theorem push1_image_Ioc {a m m' b : ℝ} (ha : a < m) (hb : m < b) (ha' : a < m') (hb' : m' < b) :
    push1 a m m' b '' Ioc m b = Ioc m' b := by
  sorry

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

/-- **The push back undoes the push.** Route: `z = P + ‖z − P‖ e(polarAngle z)` (`eq_polar_frameDir`); the push keeps the angle
(`polarAngle (P + t e θ) = θ` for `t > 0`, `θ` in the window) and moves the radius by `push1`, which `push1_push1` inverts; at `z = P`
both fix `P` (`0 < a`). -/
theorem pushInv_pushFun {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (z : ℂ) :
    pushInv P θ₁ θ₂ a l b (pushFun P θ₁ θ₂ a l b z) = z := by
  sorry

/-- **The push undoes the push back** (the same route). -/
theorem pushFun_pushInv {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) (z : ℂ) :
    pushFun P θ₁ θ₂ a l b (pushInv P θ₁ θ₂ a l b z) = z := by
  sorry

/-- **The push is continuous.** Route: write `pushFun z = z − (1 − l θ) · tent (a θ) 1 (b θ) ‖z − P‖ · e θ`, `θ = polarAngle z`. Off a
compact subset of the open sector it is the identity (near `P`: `‖z − P‖ < a`; near the window's slit: the profiles are `1`); inside,
the angle is continuous (`Complex.continuousAt_arg`); where `l θ = 1` the displacement is `(1 − l θ) ·` a factor in `[0, 1]`, so it
tends to `0` — continuity at the sector's edges with no case on the tent's knots. -/
theorem continuous_pushFun {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) :
    Continuous (pushFun P θ₁ θ₂ a l b) := by
  sorry

/-- **The push back is continuous** (the same route, the tent's peak at `l θ`). -/
theorem continuous_pushInv {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) :
    Continuous (pushInv P θ₁ θ₂ a l b) := by
  sorry

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
  sorry

/-- **The push is the identity off the open collar** `{P + t e(θ) : θ ∈ (θ₁, θ₂), a θ < t < b θ}`, and so is the push back. -/
theorem pushHomeo_eq_self {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) {z : ℂ}
    (hz : z ∉ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (a θ) (b θ))) :
    pushHomeo P θ₁ θ₂ a l b hp z = z ∧ (pushHomeo P θ₁ θ₂ a l b hp).symm z = z := by
  sorry

/-- **The push carries polar sets ray by ray**: over angles inside `(θ₁, θ₂)` and positive radii, the image is the polar set of the
images under `push1` (from `pushHomeo_polar`). -/
theorem pushHomeo_image_polarSet {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushProfiles θ₁ θ₂ a l b) {I : Set ℝ}
    (hI : I ⊆ Ioo θ₁ θ₂) {S : ℝ → Set ℝ} (hS : ∀ θ, S θ ⊆ Ioi 0) :
    pushHomeo P θ₁ θ₂ a l b hp '' polarSet P I S = polarSet P I (fun θ => push1 (a θ) 1 (l θ) (b θ) '' S θ) := by
  sorry

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
