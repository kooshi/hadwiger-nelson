import Proofs.HadwigerNelson.Plane.ValidMap.RadialPush

/-!
# The outward radial push and the outward lens (FS131-KA1's skeleton for the away collar bend)

Pure geometry, no arc map: the mirror of `Plane/ValidMap/RadialPush`'s second half for a lens **outside** `ω(P)`
(`plans/FS131-bendaway-kernel-plan.md` § 3, lane G).

* **The outward push** `pushOutHomeo P θ₁ θ₂ a l b`: on each ray `θ ∈ (θ₁, θ₂)` from `P` the push of `[a(θ), b(θ)]` sending `1` to
  `l(θ) > 1` (`PushOutProfiles`: `0 < a < 1 < l < b` inside). `RadialPush`'s `radialMap`, `push1` and `continuous_radialMap_push1` are
  reused as they stand; only `PushProfiles`' order `l < 1` is the toward bend's.
* **The outward lens**: profiles `lensProf θ₁ θ₂ R'` (inner, `R' < 1`), `outerProf θ₁ θ₂ R` (the lens curve, `R > 1`),
  `outerProf θ₁ θ₂ R''` (outer, `R'' > R`); the lens `lensOutSet`, its boundary `lensOutCurve` as two arcs `collarOutArcA`,
  `collarOutArcB` meeting at `collarOutMid`.
* **Three real lemmas the away bend's validity reads**: two points of thin outward lenses over one arc of at most `60°` are closer than
  `1` (`dist_lt_one_of_thin`); FS131-E5's Claim E (`claim_e`) and END-CAP (`end_cap`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The outward push -/

/-- **The profiles of an outward radial push** over the angles `(θ₁, θ₂)` (at most `60°`): continuous, equal to `1` off `(θ₁, θ₂)`, and
`0 < a < 1 < l < b` inside (`PushProfiles` with the middle profile above `1`). -/
structure PushOutProfiles (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) : Prop where
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
  /-- Inside, `0 < a < 1 < l < b`. -/
  inside : ∀ θ ∈ Ioo θ₁ θ₂, 0 < a θ ∧ a θ < 1 ∧ 1 < l θ ∧ l θ < b θ

/-- **The outward radial push**, a homeomorphism of the plane: `radialMap` of `push1 (a θ) 1 (l θ) (b θ)`, its inverse `radialMap` of
`push1 (a θ) (l θ) 1 (b θ)`. **Open — the four proof fields are `sorry`** (plan § 3, child G1). Route: the inverse laws by
`radialMap_radialMap` with `push1_push1`, `push1_zero`, `push1_pos` (as `pushInv_pushFun`); continuity by
`continuous_radialMap_push1` at the toward profiles `PushProfiles θ₁ θ₂ a ((a + 1) / 2) b` (a dummy middle profile: that lemma reads
`a < m < b` and `m = m' = 1` off the sector, never `l < 1`) with `(m, m') = (1, l)` and `(l, 1)`. -/
noncomputable def pushOutHomeo (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) (hp : PushOutProfiles θ₁ θ₂ a l b) : ℂ ≃ₜ ℂ where
  toFun := radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) 1 (l θ) (b θ) t)
  invFun := radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) (l θ) 1 (b θ) t)
  left_inv := by
    have := hp
    sorry
  right_inv := by
    have := hp
    sorry
  continuous_toFun := by
    have := hp
    sorry
  continuous_invFun := by
    have := hp
    sorry

section PushOut

variable {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ}

/-- The outward push on a ray of the sector (mirror of `pushHomeo_polar`). **Open — `sorry`** (child G1). -/
theorem pushOutHomeo_polar (hp : PushOutProfiles θ₁ θ₂ a l b) {θ t : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) (ht : 0 < t) :
    pushOutHomeo P θ₁ θ₂ a l b hp (P + (t : ℂ) * e θ) = P + (push1 (a θ) 1 (l θ) (b θ) t : ℝ) * e θ := by
  sorry

/-- The outward push's inverse on a ray of the sector (mirror of `pushHomeo_symm_polar`). **Open — `sorry`** (child G1). -/
theorem pushOutHomeo_symm_polar (hp : PushOutProfiles θ₁ θ₂ a l b) {θ t : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) (ht : 0 < t) :
    (pushOutHomeo P θ₁ θ₂ a l b hp).symm (P + (t : ℂ) * e θ) = P + (push1 (a θ) (l θ) 1 (b θ) t : ℝ) * e θ := by
  sorry

/-- The outward push is the identity off the open collar (mirror of `pushHomeo_eq_self`). **Open — `sorry`** (child G1). -/
theorem pushOutHomeo_eq_self (hp : PushOutProfiles θ₁ θ₂ a l b) {z : ℂ}
    (hz : z ∉ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (a θ) (b θ))) :
    pushOutHomeo P θ₁ θ₂ a l b hp z = z ∧ (pushOutHomeo P θ₁ θ₂ a l b hp).symm z = z := by
  sorry

end PushOut

/-- **The outward collar's profiles are push profiles** for `1/2 < R' < 1 < R < R''` and an arc of at most `60°` (mirror of
`pushProfiles_collar`; `tangRad_lt_one`, `one_lt_tangRad`, `tangRad_lt_tangRad`). **Open — `sorry`** (child G2). -/
theorem pushOutProfiles_collar {θ₁ θ₂ R' R R'' : ℝ} (hR' : 1 / 2 < R') (hR'1 : R' < 1) (hR : 1 < R) (hRR : R < R'')
    (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    PushOutProfiles θ₁ θ₂ (lensProf θ₁ θ₂ R') (outerProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') := by
  sorry

/-! ## The outward lens -/

/-- **The recoloured outward lens** with the open arc: `1 ≤ t < outerProf θ₁ θ₂ R θ`, `θ ∈ (θ₁, θ₂)`. -/
def lensOutSet (P : ℂ) (θ₁ θ₂ R : ℝ) : Set ℂ := polarSet P (Ioo θ₁ θ₂) (fun θ => Ico 1 (outerProf θ₁ θ₂ R θ))

/-- **The outward lens boundary**: `t = outerProf θ₁ θ₂ R θ` over the closed angles (its ends are the arc's ends). -/
def lensOutCurve (P : ℂ) (θ₁ θ₂ R : ℝ) : Set ℂ := polarSet P (Icc θ₁ θ₂) (fun θ => {outerProf θ₁ θ₂ R θ})

/-- The crossing of the two enclosing tangent circles, on the bisector. -/
noncomputable def collarOutMid (P : ℂ) (θ₁ θ₂ R : ℝ) : ℂ :=
  P + (outerProf θ₁ θ₂ R ((θ₁ + θ₂) / 2) : ℂ) * e ((θ₁ + θ₂) / 2)

/-- The outward lens boundary's arc from `ringPt P θ₁` to the crossing: the germ arc of curvature `1/R` along the arc's direction
(its circle's centre is `P + (1 − R) e(θ₁)`, as for `collarArcA`; `R > 1` puts it beyond `P`). -/
noncomputable def collarOutArcA (P : ℂ) (θ₁ θ₂ R : ℝ) : Arc :=
  germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) (dist (ringPt P θ₁) (collarOutMid P θ₁ θ₂ R))

/-- The outward lens boundary's arc from `ringPt P θ₂` to the crossing. -/
noncomputable def collarOutArcB (P : ℂ) (θ₁ θ₂ R : ℝ) : Arc :=
  germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) (dist (ringPt P θ₂) (collarOutMid P θ₁ θ₂ R))

/-- Spec: the lens holds the open arc's points and the lens curve the arc's ends (`outerProf = 1` at an end angle is
`pushOutProfiles_collar`'s `off`). -/
example (P : ℂ) {θ₁ θ₂ R θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) (h : 1 < outerProf θ₁ θ₂ R θ) :
    P + ((1 : ℝ) : ℂ) * e θ ∈ lensOutSet P θ₁ θ₂ R := ⟨θ, hθ, 1, ⟨le_rfl, h⟩, rfl⟩

/-- **The outward lens boundary is the two arcs** (mirror of `collarArcs_carrier` for `R > 1`: `tangRad R` now *increases* in `|u|`
on `[0, π]`, so the `min` of the two is the nearer end's circle). **Open — `sorry`** (child G3; the longest of lane G: the mirrors of
`tangRad_anti`, `tangentArc_image` for `R ≥ 1`, then `collarArcs_carrier`'s proof). -/
theorem collarOutArcs_carrier {P : ℂ} {θ₁ θ₂ R : ℝ} (hR : 1 < R) (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    (collarOutArcA P θ₁ θ₂ R).carrier ∪ (collarOutArcB P θ₁ θ₂ R).carrier = lensOutCurve P θ₁ θ₂ R := by
  sorry

/-! ## Three real lemmas for validity -/

/-- **Two points of thin outward lenses over one arc of at most `60°` are closer than `1`**: the first within `κ (φ₁ − α₁)²` above
`ω(P)`, the second within `κ (α₂ − φ₂)²`, `κ ≤ 1/8`. Route: `|z₁ − z₂| ≤ (t₁ − 1) + (t₂ − 1) + 2 sin ((φ₂ − φ₁)/2)`, and with
`u = φ₁ − α₁`, `v = α₂ − φ₂`: `2 sin ((φ₂ − φ₁)/2) ≤ 2 sin (π/6 − (u + v)/2) ≤ 1 − (√3/π)(u + v)` (`Real.mul_le_sin`), while
`κ (u² + v²) ≤ κ (π/3)(u + v)`. **Open — `sorry`** (child G4; the inside-the-disc reason of `dist_lt_one_of_mem_polarSet` does not
apply to an outward lens). -/
theorem dist_lt_one_of_thin {P : ℂ} {α₁ α₂ φ₁ φ₂ t₁ t₂ κ : ℝ} (hℓ : α₂ - α₁ ≤ π / 3) (h1 : α₁ < φ₁) (h12 : φ₁ ≤ φ₂)
    (h2 : φ₂ < α₂) (hκ0 : 0 ≤ κ) (hκ : κ ≤ 1 / 8) (ht₁ : 1 ≤ t₁) (ht₁' : t₁ ≤ 1 + κ * (φ₁ - α₁) ^ 2) (ht₂ : 1 ≤ t₂)
    (ht₂' : t₂ ≤ 1 + κ * (α₂ - φ₂) ^ 2) : dist (P + (t₁ : ℂ) * e φ₁) (P + (t₂ : ℂ) * e φ₂) < 1 := by
  sorry

/-- **FS131-E5's Claim E** (`e5-claim-e`), in the frame at an end `A = (1, 0)` of the arc with `P` the origin: a point `z` on `P`'s
side of the tangent line at `A`, on the arc's side of the line `PA` and not inside `ω(P)`, is farther from every point `p` beyond the
end (`p₁ > 0`, `p₂ ≤ 0`) than `A` is. No smallness. -/
theorem claim_e {z₁ z₂ p₁ p₂ : ℝ} (hz₁ : z₁ < 1) (hz₂ : 0 ≤ z₂) (hz : 1 ≤ z₁ ^ 2 + z₂ ^ 2) (hp₁ : 0 < p₁) (hp₂ : p₂ ≤ 0) :
    (p₁ - 1) ^ 2 + p₂ ^ 2 < (p₁ - z₁) ^ 2 + (p₂ - z₂) ^ 2 := by
  nlinarith [mul_pos hp₁ (sub_pos.mpr hz₁), mul_nonneg (neg_nonneg.mpr hp₂) hz₂]

/-- Spec: Claim E at E5's model point (`z = (1.002, 0.1)` is off the hypothesis `z₁ < 1`; a point that meets it: `z = (0.999, 0.1)`,
`p = (2, −0.01)`). -/
example : ((2 : ℝ) - 1) ^ 2 + (-1 / 100 : ℝ) ^ 2 < (2 - 999 / 1000) ^ 2 + (-1 / 100 - 1 / 10) ^ 2 :=
  claim_e (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by norm_num)

/-- **FS131-E5's END-CAP** (`e5-end-cap`), the triangle inequality about the common centre `O` of `Γ_Y` and `Σ_Y`: a point `z` inside
the lens circle (centre `C`, radius `R`, internally tangent to `Σ_Y = ∂B(O, ρ₀ − 1)`: `|C − O| = ρ₀ − 1 − R`) is farther than `1` from
every point `y` off `B(O, ρ₀)`. -/
theorem end_cap {y z O C : ℂ} {R ρ₀ : ℝ} (hCO : dist C O = ρ₀ - 1 - R) (hz : dist z C < R) (hy : ρ₀ ≤ dist y O) :
    1 < dist y z := by
  have h1 := dist_triangle z C O
  have h2 := dist_triangle y z O
  linarith

/-- Spec: END-CAP at `P = 0`, the end `A = 1`, `ρ₀ = 5/2` (`O = −1/2`), `R = 5/4` (`C = −1/4`): the lens point `z = 1` is not strictly
inside, `z = 9/10` is, and `y = 2` is on `∂B(O, ρ₀)`. -/
example : (1 : ℝ) < dist (2 : ℂ) (9 / 10) :=
  end_cap (O := -1 / 2) (C := -1 / 4) (R := 5 / 4) (ρ₀ := 5 / 2) (by rw [dist_eq_norm]; norm_num)
    (by rw [dist_eq_norm]; norm_num) (by rw [dist_eq_norm]; norm_num)

end HadwigerNelson.Plane
