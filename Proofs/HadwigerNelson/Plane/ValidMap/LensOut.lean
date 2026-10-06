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

/-- At each angle the outward profiles are inside (`0 < a < 1 < l < b`) or all `1`. -/
theorem PushOutProfiles.cases {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushOutProfiles θ₁ θ₂ a l b) (θ : ℝ) :
    (θ ∈ Ioo θ₁ θ₂ ∧ 0 < a θ ∧ a θ < 1 ∧ 1 < l θ ∧ l θ < b θ) ∨ (θ ∉ Ioo θ₁ θ₂ ∧ a θ = 1 ∧ l θ = 1 ∧ b θ = 1) := by
  by_cases h : θ ∈ Ioo θ₁ θ₂
  · exact Or.inl ⟨h, hp.inside θ h⟩
  · exact Or.inr ⟨h, hp.off θ h⟩

/-- **The toward profiles under an outward push**: the same inner and outer profiles with the dummy middle profile `(a + 1)/2`, which
is below `1` — what `continuous_radialMap_push1` and `PushProfiles.a_pos` read of a push's profiles (`a`, `b`, the sector), never the
middle one. -/
theorem PushOutProfiles.toward {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushOutProfiles θ₁ θ₂ a l b) :
    PushProfiles θ₁ θ₂ a (fun θ => (a θ + 1) / 2) b where
  lt := hp.lt
  short := hp.short
  cont_a := hp.cont_a
  cont_l := (hp.cont_a.add continuous_const).div_const 2
  cont_b := hp.cont_b
  off := fun θ hθ => ⟨(hp.off θ hθ).1, by rw [(hp.off θ hθ).1]; norm_num, (hp.off θ hθ).2.2⟩
  inside := fun θ hθ => by
    obtain ⟨h0, h1, h2, h3⟩ := hp.inside θ hθ
    exact ⟨h0, by linarith, by linarith, by linarith⟩

/-- The inner profile of an outward push is positive. -/
theorem PushOutProfiles.a_pos {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushOutProfiles θ₁ θ₂ a l b) (θ : ℝ) : 0 < a θ :=
  hp.toward.a_pos θ

/-- At each angle both outward pushes fix `0`. -/
theorem PushOutProfiles.push1_zero {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushOutProfiles θ₁ θ₂ a l b) (θ : ℝ) :
    push1 (a θ) 1 (l θ) (b θ) 0 = 0 ∧ push1 (a θ) (l θ) 1 (b θ) 0 = 0 := by
  rcases hp.cases θ with ⟨-, h0, ha1, h1l, hlb⟩ | ⟨-, ha, hl, hb⟩
  · exact ⟨_root_.HadwigerNelson.Plane.push1_zero h0.le ha1 (by linarith),
      _root_.HadwigerNelson.Plane.push1_zero h0.le (by linarith) hlb⟩
  · rw [ha, hl, hb]; exact ⟨push1_self _ _ _ _, push1_self _ _ _ _⟩

/-- At each angle both outward pushes keep positive radii positive. -/
theorem PushOutProfiles.push1_pos {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushOutProfiles θ₁ θ₂ a l b) (θ : ℝ) {t : ℝ}
    (ht : 0 < t) : 0 < push1 (a θ) 1 (l θ) (b θ) t ∧ 0 < push1 (a θ) (l θ) 1 (b θ) t := by
  rcases hp.cases θ with ⟨-, h0, ha1, h1l, hlb⟩ | ⟨-, ha, hl, hb⟩
  · exact ⟨_root_.HadwigerNelson.Plane.push1_pos h0 ha1 (by linarith) (by linarith) hlb ht,
      _root_.HadwigerNelson.Plane.push1_pos h0 (by linarith) hlb ha1 (by linarith) ht⟩
  · rw [ha, hl, hb, push1_self]; exact ⟨ht, ht⟩

/-- At each angle the two outward pushes are inverse. -/
theorem PushOutProfiles.push1_push1 {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ} (hp : PushOutProfiles θ₁ θ₂ a l b) (θ t : ℝ) :
    push1 (a θ) (l θ) 1 (b θ) (push1 (a θ) 1 (l θ) (b θ) t) = t ∧
      push1 (a θ) 1 (l θ) (b θ) (push1 (a θ) (l θ) 1 (b θ) t) = t := by
  rcases hp.cases θ with ⟨-, h0, ha1, h1l, hlb⟩ | ⟨-, ha, hl, hb⟩
  · exact ⟨_root_.HadwigerNelson.Plane.push1_push1 ha1 (by linarith) (by linarith) hlb t,
      _root_.HadwigerNelson.Plane.push1_push1 (by linarith) hlb ha1 (by linarith) t⟩
  · rw [ha, hl, hb, push1_self, push1_self]; exact ⟨rfl, rfl⟩

/-- **The outward radial push**, a homeomorphism of the plane: `radialMap` of `push1 (a θ) 1 (l θ) (b θ)`, its inverse `radialMap` of
`push1 (a θ) (l θ) 1 (b θ)` (plan § 3, child G1). The inverse laws are `radialMap_radialMap` with `push1_push1`, `push1_zero`,
`push1_pos` (as `pushInv_pushFun`); continuity is `continuous_radialMap_push1` at the toward profiles
`PushProfiles θ₁ θ₂ a ((a + 1) / 2) b` (`PushOutProfiles.toward`, a dummy middle profile: that lemma reads `a < m < b` and
`m = m' = 1` off the sector, never `l < 1`) with `(m, m') = (1, l)` and `(l, 1)`. -/
noncomputable def pushOutHomeo (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) (hp : PushOutProfiles θ₁ θ₂ a l b) : ℂ ≃ₜ ℂ where
  toFun := radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) 1 (l θ) (b θ) t)
  invFun := radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) (l θ) 1 (b θ) t)
  left_inv := radialMap_radialMap (fun θ => (hp.push1_zero θ).1) (fun θ => (hp.push1_zero θ).2)
    (fun θ _ ht => (hp.push1_pos θ ht).1) (fun θ t _ => (hp.push1_push1 θ t).1)
  right_inv := radialMap_radialMap (fun θ => (hp.push1_zero θ).2) (fun θ => (hp.push1_zero θ).1)
    (fun θ _ ht => (hp.push1_pos θ ht).2) (fun θ t _ => (hp.push1_push1 θ t).2)
  continuous_toFun := continuous_radialMap_push1 (m := fun _ => 1) hp.toward continuous_const hp.cont_l
    (fun θ h => ⟨(hp.inside θ h).2.1, by linarith [hp.inside θ h]⟩) (fun θ h => ⟨rfl, (hp.off θ h).2.1⟩)
  continuous_invFun := continuous_radialMap_push1 (m' := fun _ => 1) hp.toward hp.cont_l continuous_const
    (fun θ h => ⟨by linarith [hp.inside θ h], (hp.inside θ h).2.2.2⟩) (fun θ h => ⟨(hp.off θ h).2.1, rfl⟩)

section PushOut

variable {P : ℂ} {θ₁ θ₂ : ℝ} {a l b : ℝ → ℝ}

/-- The outward push on a ray of the sector (mirror of `pushHomeo_polar`; child G1). -/
theorem pushOutHomeo_polar (hp : PushOutProfiles θ₁ θ₂ a l b) {θ t : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) (ht : 0 < t) :
    pushOutHomeo P θ₁ θ₂ a l b hp (P + (t : ℂ) * e θ) = P + (push1 (a θ) 1 (l θ) (b θ) t : ℝ) * e θ := by
  show radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) 1 (l θ) (b θ) t) (P + (t : ℂ) * e θ) = _
  rw [radialMap_polar (mem_window_of_mem_Icc hp.short (Ioo_subset_Icc_self hθ)) ht]

/-- The outward push's inverse on a ray of the sector (mirror of `pushHomeo_symm_polar`; child G1). -/
theorem pushOutHomeo_symm_polar (hp : PushOutProfiles θ₁ θ₂ a l b) {θ t : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) (ht : 0 < t) :
    (pushOutHomeo P θ₁ θ₂ a l b hp).symm (P + (t : ℂ) * e θ) = P + (push1 (a θ) (l θ) 1 (b θ) t : ℝ) * e θ := by
  show radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) (l θ) 1 (b θ) t) (P + (t : ℂ) * e θ) = _
  rw [radialMap_polar (mem_window_of_mem_Icc hp.short (Ioo_subset_Icc_self hθ)) ht]

/-- The outward push is the identity off the open collar (mirror of `pushHomeo_eq_self`; child G1). -/
theorem pushOutHomeo_eq_self (hp : PushOutProfiles θ₁ θ₂ a l b) {z : ℂ}
    (hz : z ∉ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (a θ) (b θ))) :
    pushOutHomeo P θ₁ θ₂ a l b hp z = z ∧ (pushOutHomeo P θ₁ θ₂ a l b hp).symm z = z := by
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
  · show radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) 1 (l θ) (b θ) t) z = z
    exact key (m := fun _ => 1) (fun θ h => ⟨(hp.inside θ h).2.1, by linarith [hp.inside θ h]⟩)
      (fun θ h => (hp.off θ h).2.1.symm)
  · show radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) (l θ) 1 (b θ) t) z = z
    exact key (m' := fun _ => 1) (fun θ h => ⟨by linarith [hp.inside θ h], (hp.inside θ h).2.2.2⟩)
      (fun θ h => (hp.off θ h).2.1)

/-- Spec for `pushOutHomeo`: on each ray of the sector the push sends the point of `ω(P)` to the middle profile's point (`push1_mid`),
and its inverse brings that point back — so the arc goes onto the lens curve and nothing else does. -/
example (hp : PushOutProfiles θ₁ θ₂ a l b) {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    pushOutHomeo P θ₁ θ₂ a l b hp (P + ((1 : ℝ) : ℂ) * e θ) = P + (l θ : ℂ) * e θ ∧
      (pushOutHomeo P θ₁ θ₂ a l b hp).symm (P + (l θ : ℂ) * e θ) = P + ((1 : ℝ) : ℂ) * e θ := by
  obtain ⟨h0, ha1, h1l, hlb⟩ := hp.inside θ hθ
  rw [pushOutHomeo_polar hp hθ one_pos, pushOutHomeo_symm_polar hp hθ (one_pos.trans h1l), push1_mid ha1 (h1l.trans hlb),
    push1_mid (ha1.trans h1l) hlb]
  exact ⟨rfl, rfl⟩

end PushOut

/-- **The outward collar's profiles are push profiles** for `1/2 < R' < 1 < R < R''` and an arc of at most `60°` (mirror of
`pushProfiles_collar`; `tangRad_lt_one`, `one_lt_tangRad`, `tangRad_lt_tangRad`; child G2). -/
theorem pushOutProfiles_collar {θ₁ θ₂ R' R R'' : ℝ} (hR' : 1 / 2 < R') (hR'1 : R' < 1) (hR : 1 < R) (hRR : R < R'')
    (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    PushOutProfiles θ₁ θ₂ (lensProf θ₁ θ₂ R') (outerProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') := by
  have hπ := Real.pi_pos
  have hd0 : 0 < |θ₂ - θ₁| := abs_pos.mpr (by linarith)
  have hd1 : |θ₂ - θ₁| ≤ π := by rw [abs_of_pos (by linarith)]; linarith
  have hcl : Continuous (clampAngle θ₁ θ₂) := continuous_const.max (continuous_id.min continuous_const)
  have hcont : ∀ R₀, Continuous (lensProf θ₁ θ₂ R₀) ∧ Continuous (outerProf θ₁ θ₂ R₀) := fun R₀ =>
    ⟨((continuous_tangRad R₀).comp (hcl.sub continuous_const)).max ((continuous_tangRad R₀).comp (continuous_const.sub hcl)),
      ((continuous_tangRad R₀).comp (hcl.sub continuous_const)).min ((continuous_tangRad R₀).comp (continuous_const.sub hcl))⟩
  -- off the open sector the clamped angle is an end
  have hend : ∀ θ ∉ Ioo θ₁ θ₂, clampAngle θ₁ θ₂ θ = θ₁ ∨ clampAngle θ₁ θ₂ θ = θ₂ := by
    intro θ hθ
    simp only [mem_Ioo, not_and_or, not_lt] at hθ
    unfold clampAngle
    rcases hθ with h | h
    · left; rw [min_eq_left (by linarith), max_eq_left h]
    · right; rw [min_eq_right h, max_eq_right (by linarith)]
  have houter1 : ∀ R₀, 1 < R₀ → ∀ θ ∉ Ioo θ₁ θ₂, outerProf θ₁ θ₂ R₀ θ = 1 := by
    intro R₀ h1 θ hθ
    have hgt := one_lt_tangRad h1 hd0 hd1
    unfold outerProf
    rcases hend θ hθ with h | h <;> rw [h]
    · rw [sub_self, tangRad_zero (by linarith), min_eq_left hgt.le]
    · rw [sub_self, tangRad_zero (by linarith), min_eq_right hgt.le]
  refine ⟨h12, hℓ, (hcont R').1, (hcont R).2, (hcont R'').2, fun θ hθ => ?_, fun θ hθ => ?_⟩
  · refine ⟨?_, houter1 R hR θ hθ, houter1 R'' (hR.trans hRR) θ hθ⟩
    have hlt := tangRad_lt_one hR' hR'1 hd0 hd1
    unfold lensProf
    rcases hend θ hθ with h | h <;> rw [h]
    · rw [sub_self, tangRad_zero (by linarith), max_eq_left hlt.le]
    · rw [sub_self, tangRad_zero (by linarith), max_eq_right hlt.le]
  · have hc : clampAngle θ₁ θ₂ θ = θ := by
      unfold clampAngle; rw [min_eq_left hθ.2.le, max_eq_right hθ.1.le]
    have hu1 : 0 < |θ - θ₁| := abs_pos.mpr (by linarith [hθ.1])
    have hu1' : |θ - θ₁| ≤ π := by rw [abs_of_pos (by linarith [hθ.1])]; linarith [hθ.2]
    have hu2 : 0 < |θ₂ - θ| := abs_pos.mpr (by linarith [hθ.2])
    have hu2' : |θ₂ - θ| ≤ π := by rw [abs_of_pos (by linarith [hθ.2])]; linarith [hθ.1]
    have hR2 : 1 / 2 < R := by linarith
    unfold lensProf outerProf
    rw [hc]
    exact ⟨lt_max_of_lt_left (tangRad_pos hR' _), max_lt (tangRad_lt_one hR' hR'1 hu1 hu1') (tangRad_lt_one hR' hR'1 hu2 hu2'),
      lt_min (one_lt_tangRad hR hu1 hu1') (one_lt_tangRad hR hu2 hu2'),
      lt_min (min_lt_of_left_lt (tangRad_lt_tangRad hR2 hRR hu1 hu1')) (min_lt_of_right_lt (tangRad_lt_tangRad hR2 hRR hu2 hu2'))⟩

/-- Spec: the outward collar's profiles at concrete radii (`R' = 3/4`, `R = 9/8`, `R'' = 5/4`, over `[0, π/6]`) are outward push
profiles — the hypotheses of `pushOutProfiles_collar` are met together. -/
example : PushOutProfiles 0 (π / 6) (lensProf 0 (π / 6) (3 / 4)) (outerProf 0 (π / 6) (9 / 8)) (outerProf 0 (π / 6) (5 / 4)) :=
  pushOutProfiles_collar (by norm_num) (by norm_num) (by norm_num) (by norm_num) (by positivity) (by linarith [Real.pi_pos])

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

/-! ### The outward lens boundary's arcs (mirror of `RadialPush`'s section for `R > 1`)

The frame lemmas of `RadialPush` (`germ_tangentCircle`, `polar_tangentCircle`, `eq_of_tangentCircle`, `norm_tangRad_sub_one_le`) hold
for every `R > 1/2`; what is the toward bend's alone is the direction of two monotonicities. For `R ≥ 1` the tangent circle encloses
`ω(P)`: `tangRad R` *increases* in `|u|` on `[0, π]` (`tangRad_mono`), and the chord from the point of tangency still increases — not
because both factors of `tangRad R u · cos u` decrease, but by the circle's quadratic (`tangRad_mul_cos_anti`). -/

/-- The enclosing tangent circle's radial function increases in `|u|` on `[0, π]` (`R ≥ 1`; mirror of `tangRad_anti`). -/
theorem tangRad_mono {R u u' : ℝ} (hR : 1 ≤ R) (hu : 0 ≤ u) (huu : u ≤ u') (hu' : u' ≤ π) :
    tangRad R u ≤ tangRad R u' := by
  have hR2 : 1 / 2 < R := by linarith
  have hs := tangRad_pos hR2 u
  rw [le_tangRad_iff hR2 u' hs]
  have hroot := tangRad_root hR2 u
  have hc : Real.cos u' ≤ Real.cos u := Real.cos_le_cos_of_nonneg_of_le_pi hu hu' huu
  nlinarith [mul_nonneg (mul_nonneg (sub_nonneg.mpr hR) hs.le) (sub_nonneg.mpr hc)]

/-- **The enclosing tangent circle's point moves back along the axis as its ray turns** (`R > 1`): `tangRad R u · cos u` decreases on
`[0, π]`. From the quadratic, `t² + 2(R − 1) t cos u = 2R − 1` at `t = tangRad R u`, and `t` increases (`tangRad_mono`). -/
theorem tangRad_mul_cos_anti {R u u' : ℝ} (hR : 1 < R) (hu : 0 ≤ u) (huu : u ≤ u') (hu' : u' ≤ π) :
    tangRad R u' * Real.cos u' ≤ tangRad R u * Real.cos u := by
  have hR2 : 1 / 2 < R := by linarith
  have ht := tangRad_pos hR2 u
  have ht' := tangRad_pos hR2 u'
  have htt := tangRad_mono hR.le hu huu hu'
  have hroot := tangRad_root hR2 u
  have hroot' := tangRad_root hR2 u'
  by_contra h
  push Not at h
  nlinarith [mul_pos (sub_pos.mpr hR) (sub_pos.mpr h), mul_nonneg (sub_nonneg.mpr htt) (add_pos ht ht').le]

/-- **The enclosing tangent circle's arc from its point of tangency, two ways** (mirror of `tangentArc_image` for `R > 1`): the germ arc
by chord, out to the chord of the lens curve's point at angle `uX ∈ [0, π/2]`, is the lens curve over `[0, uX]`. Both lie on the
circle's closed upper side, where a point is determined by its chord (`eq_of_tangentCircle`); the chord increases on `[0, π/2]`
(`tangRad_mul_cos_anti`). -/
theorem tangentArc_image_out {R uX : ℝ} (hR : 1 < R) (hu0 : 0 ≤ uX) (hu1 : uX ≤ π / 2) :
    (fun s : ℝ => 1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) '' Icc 0 ‖(tangRad R uX : ℂ) * e uX - 1‖ =
      (fun u : ℝ => (tangRad R u : ℂ) * e u) '' Icc 0 uX := by
  have hR2 : 1 / 2 < R := by linarith
  have hRpos : 0 < R := by linarith
  have hπ := Real.pi_pos
  set f : ℝ → ℝ := fun u => ‖(tangRad R u : ℂ) * e u - 1‖ with hf
  have hfc : Continuous f :=
    continuous_norm.comp (((Complex.continuous_ofReal.comp (continuous_tangRad R)).mul continuous_e).sub continuous_const)
  have hf0 : f 0 = 0 := by simp [hf, tangRad_zero hRpos.le, e_zero]
  -- the chord is at most the diameter
  have hf2 : ∀ u, 0 ≤ u → u ≤ π → f u ≤ 2 * R := fun u hu hu' => norm_tangRad_sub_one_le hR2 hu hu'
  -- the chord increases on `[0, π/2]`
  have hmono : ∀ u u', 0 ≤ u → u ≤ u' → u' ≤ π / 2 → f u ≤ f u' := by
    intro u u' hu huu hu'
    obtain ⟨-, -, h⟩ := polar_tangentCircle hR2 hu (by linarith)
    obtain ⟨-, -, h'⟩ := polar_tangentCircle hR2 (hu.trans huu) (by linarith)
    have hprod := tangRad_mul_cos_anti hR hu huu (by linarith)
    refine (pow_le_pow_iff_left₀ (norm_nonneg _) (norm_nonneg _) two_ne_zero).mp ?_
    show ‖(tangRad R u : ℂ) * e u - 1‖ ^ 2 ≤ ‖(tangRad R u' : ℂ) * e u' - 1‖ ^ 2
    rw [h, h']; nlinarith
  ext W
  constructor
  · rintro ⟨s, hs, rfl⟩
    obtain ⟨u, hu, hfu⟩ := intermediate_value_Icc hu0 hfc.continuousOn (by rw [hf0]; exact hs)
    have hs2 : s ≤ 2 * R := hs.2.trans (hf2 uX hu0 (by linarith))
    obtain ⟨g1, g2, g3⟩ := germ_tangentCircle hRpos hs.1 hs2
    obtain ⟨p1, p2, -⟩ := polar_tangentCircle hR2 hu.1 (by linarith [hu.2])
    exact ⟨u, hu, eq_of_tangentCircle hRpos p1 g1 p2 g2 (by rw [g3]; exact hfu)⟩
  · rintro ⟨u, hu, rfl⟩
    have hs := hmono u uX hu.1 hu.2 hu1
    have hs2 : f u ≤ 2 * R := hf2 u hu.1 (by linarith [hu.2])
    obtain ⟨g1, g2, g3⟩ := germ_tangentCircle hRpos (norm_nonneg _) hs2
    obtain ⟨p1, p2, -⟩ := polar_tangentCircle hR2 hu.1 (by linarith [hu.2])
    exact ⟨f u, ⟨norm_nonneg _, hs⟩, eq_of_tangentCircle hRpos g1 p1 g2 p2 (by rw [g3])⟩

/-- The outward crossing on the bisector: `P + tangRad R ((θ₂ − θ₁)/2) · e(θ₁ + (θ₂ − θ₁)/2)` (mirror of `collarMid_eq`; the two
enclosing circles' terms agree there). -/
theorem collarOutMid_eq {P : ℂ} {θ₁ θ₂ R : ℝ} (h12 : θ₁ ≤ θ₂) :
    collarOutMid P θ₁ θ₂ R = P + (tangRad R ((θ₂ - θ₁) / 2) : ℂ) * e (θ₁ + (θ₂ - θ₁) / 2) := by
  have hc : clampAngle θ₁ θ₂ ((θ₁ + θ₂) / 2) = (θ₁ + θ₂) / 2 := by
    unfold clampAngle; rw [min_eq_left (by linarith), max_eq_right (by linarith)]
  rw [collarOutMid, outerProf, hc, show (θ₁ + θ₂) / 2 - θ₁ = (θ₂ - θ₁) / 2 by ring,
    show θ₂ - (θ₁ + θ₂) / 2 = (θ₂ - θ₁) / 2 by ring, min_self, show (θ₁ + θ₂) / 2 = θ₁ + (θ₂ - θ₁) / 2 by ring]

/-- The chord from `ringPt P θ₁` to the outward crossing, in the end's frame (it is `collarMid`'s formula: `dist_collarMid_left`). -/
theorem dist_collarOutMid_left {P : ℂ} {θ₁ θ₂ R : ℝ} (h12 : θ₁ ≤ θ₂) :
    dist (ringPt P θ₁) (collarOutMid P θ₁ θ₂ R) = ‖(tangRad R ((θ₂ - θ₁) / 2) : ℂ) * e ((θ₂ - θ₁) / 2) - 1‖ := by
  rw [collarOutMid_eq h12, ← collarMid_eq h12]; exact dist_collarMid_left h12

/-- The chord from `ringPt P θ₂` to the outward crossing (the same length). -/
theorem dist_collarOutMid_right {P : ℂ} {θ₁ θ₂ R : ℝ} (h12 : θ₁ ≤ θ₂) :
    dist (ringPt P θ₂) (collarOutMid P θ₁ θ₂ R) = ‖(tangRad R ((θ₂ - θ₁) / 2) : ℂ) * e ((θ₂ - θ₁) / 2) - 1‖ := by
  rw [collarOutMid_eq h12, ← collarMid_eq h12]; exact dist_collarMid_right h12

/-- **The outward lens boundary is the two arcs** (mirror of `collarArcs_carrier` for `R > 1`; child G3): `tangRad R` now *increases*
in `|u|` on `[0, π]` (`tangRad_mono`), so the `min` of the two is the nearer end's circle; each germ arc is that circle's part from its
end to the crossing (`tangentArc_image_out`). -/
theorem collarOutArcs_carrier {P : ℂ} {θ₁ θ₂ R : ℝ} (hR : 1 < R) (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    (collarOutArcA P θ₁ θ₂ R).carrier ∪ (collarOutArcB P θ₁ θ₂ R).carrier = lensOutCurve P θ₁ θ₂ R := by
  have hπ := Real.pi_pos
  have hR2 : 1 / 2 < R := by linarith
  have hRpos : 0 < R := by linarith
  obtain ⟨uX, huX⟩ : ∃ uX : ℝ, uX = (θ₂ - θ₁) / 2 := ⟨_, rfl⟩
  have hu0 : 0 ≤ uX := by rw [huX]; linarith
  have hu1 : uX ≤ π / 2 := by rw [huX]; linarith
  set ρ := ‖(tangRad R uX : ℂ) * e uX - 1‖ with hρ
  have hρ0 : 0 ≤ ρ := norm_nonneg _
  have hρ2 : ρ ≤ 2 * R := norm_tangRad_sub_one_le hR2 hu0 (by linarith)
  have hκρ : (1 / R) * ρ ≤ 2 := by rw [div_mul_eq_mul_div, one_mul, div_le_iff₀ hRpos]; linarith
  -- the lens profile on each half: the nearer end's circle
  have hL1 : ∀ θ ∈ Icc θ₁ (θ₁ + uX), outerProf θ₁ θ₂ R θ = tangRad R (θ - θ₁) := by
    intro θ hθ
    have hc : clampAngle θ₁ θ₂ θ = θ := by
      unfold clampAngle; rw [min_eq_left (by linarith [hθ.2]), max_eq_right hθ.1]
    unfold outerProf; rw [hc]
    exact min_eq_left (tangRad_mono hR.le (by linarith [hθ.1]) (by linarith [hθ.2]) (by linarith [hθ.1]))
  have hL2 : ∀ θ ∈ Icc (θ₂ - uX) θ₂, outerProf θ₁ θ₂ R θ = tangRad R (θ₂ - θ) := by
    intro θ hθ
    have hc : clampAngle θ₁ θ₂ θ = θ := by
      unfold clampAngle; rw [min_eq_left hθ.2, max_eq_right (by linarith [hθ.1])]
    unfold outerProf; rw [hc]
    exact min_eq_right (tangRad_mono hR.le (by linarith [hθ.2]) (by linarith [hθ.1]) (by linarith [hθ.2]))
  -- the crossing, and the two chords to it
  have hρA : dist (ringPt P θ₁) (collarOutMid P θ₁ θ₂ R) = ρ := by rw [dist_collarOutMid_left h12.le, ← huX]
  have hρB : dist (ringPt P θ₂) (collarOutMid P θ₁ θ₂ R) = ρ := by rw [dist_collarOutMid_right h12.le, ← huX]
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
  have himg := tangentArc_image_out hR hu0 hu1
  rw [← hρ] at himg
  have hcA : (collarOutArcA P θ₁ θ₂ R).carrier = (fun u : ℝ => P + ((tangRad R u : ℂ) * e u) * e θ₁) '' Icc 0 uX := by
    rw [collarOutArcA, hρA, carrier_germArc _ _ hρ0 (by rwa [abs_of_pos (one_div_pos.mpr hRpos)])]
    have h : branchPt (ringPt P θ₁) (θ₁ + π / 2) (1 / R) '' Icc 0 ρ = (fun w : ℂ => P + w * e θ₁) ''
        ((fun s : ℝ => 1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * R)))) '' Icc 0 ρ) := by
      rw [Set.image_image]; exact Set.image_congr fun s _ => hbA s
    rw [h, himg, Set.image_image]
  have hcB : (collarOutArcB P θ₁ θ₂ R).carrier =
      (fun u : ℝ => P + starRingEnd ℂ ((tangRad R u : ℂ) * e u) * e θ₂) '' Icc 0 uX := by
    rw [collarOutArcB, hρB, carrier_germArc _ _ hρ0 (by rwa [abs_neg, abs_of_pos (one_div_pos.mpr hRpos)])]
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

/-! ## Three real lemmas for validity -/

/-- The chord of a gap against the angle left over: `2 sin (Δ/2) ≤ 1 − sin w` when `0 ≤ Δ/2 ≤ π/6 − w` and `0 ≤ w`
(`2 sin (π/6 − w) = cos w − √3 sin w`, `cos w ≤ 1`, `√3 ≥ 1`). -/
theorem two_sin_half_le_of_gap {Δ w : ℝ} (hΔ : 0 ≤ Δ) (hw0 : 0 ≤ w) (h : Δ / 2 ≤ π / 6 - w) :
    2 * Real.sin (Δ / 2) ≤ 1 - Real.sin w := by
  have hπ := Real.pi_pos
  have h1 : Real.sin (Δ / 2) ≤ Real.sin (π / 6 - w) :=
    Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) (by linarith) h
  have h2 : Real.sin (π / 6 - w) = 1 / 2 * Real.cos w - √3 / 2 * Real.sin w := by
    rw [Real.sin_sub, Real.sin_pi_div_six, Real.cos_pi_div_six]
  have hs : 0 ≤ Real.sin w := Real.sin_nonneg_of_nonneg_of_le_pi hw0 (by linarith)
  have hc : Real.cos w ≤ 1 := Real.cos_le_one w
  have h3 : (1 : ℝ) ≤ √3 := Real.one_le_sqrt.mpr (by norm_num)
  nlinarith [mul_nonneg (sub_nonneg.mpr h3) hs]

/-- `w²/2 < sin w` on `(0, π/6]` (`sin w ≥ (2/π) w > w/2 > w²/2`). -/
theorem sq_div_two_lt_sin {w : ℝ} (hw0 : 0 < w) (hw : w ≤ π / 6) : w ^ 2 / 2 < Real.sin w := by
  have hπ4 : π < 4 := Real.pi_lt_four
  have h1 : 2 / π * w ≤ Real.sin w := Real.mul_le_sin hw0.le (by linarith [Real.pi_pos])
  have h2 : (1 : ℝ) / 2 < 2 / π := by rw [lt_div_iff₀ Real.pi_pos]; linarith
  have h3 : w < 1 := by linarith
  nlinarith [mul_pos hw0 (sub_pos.mpr h2), mul_pos hw0 (sub_pos.mpr h3)]

/-- **Two points of thin outward lenses over one arc of at most `60°` are closer than `1`**: the first within `κ (φ₁ − α₁)²` above
`ω(P)`, the second within `κ (α₂ − φ₂)²`, `κ ≤ 1/8` (child G4; the inside-the-disc reason of `dist_lt_one_of_mem_polarSet` does not
apply to an outward lens). `|z₁ − z₂| ≤ (t₁ − 1) + (t₂ − 1) + 2 sin ((φ₂ − φ₁)/2)`, and with `u = φ₁ − α₁`, `v = α₂ − φ₂`,
`w = (u + v)/2 ∈ (0, π/6]`: `2 sin ((φ₂ − φ₁)/2) ≤ 2 sin (π/6 − w) ≤ 1 − sin w` (`two_sin_half_le_of_gap`), while
`κ (u² + v²) ≤ (u + v)²/8 = w²/2 < sin w` (`sq_div_two_lt_sin`). The route differs from the plan's in its constants only (`√3 ≥ 1`
in place of `√3/π`): the inequality is the same. No `0 ≤ κ` is asked: it follows from `1 ≤ t₁ ≤ 1 + κ (φ₁ − α₁)²` and
`α₁ < φ₁`, and the proof does not read it (the skeleton's `hκ0`, removed under inventory ruling 452 (a)). -/
theorem dist_lt_one_of_thin {P : ℂ} {α₁ α₂ φ₁ φ₂ t₁ t₂ κ : ℝ} (hℓ : α₂ - α₁ ≤ π / 3) (h1 : α₁ < φ₁) (h12 : φ₁ ≤ φ₂)
    (h2 : φ₂ < α₂) (hκ : κ ≤ 1 / 8) (ht₁ : 1 ≤ t₁) (ht₁' : t₁ ≤ 1 + κ * (φ₁ - α₁) ^ 2) (ht₂ : 1 ≤ t₂)
    (ht₂' : t₂ ≤ 1 + κ * (α₂ - φ₂) ^ 2) : dist (P + (t₁ : ℂ) * e φ₁) (P + (t₂ : ℂ) * e φ₂) < 1 := by
  have hπ := Real.pi_pos
  have hu0 : 0 < φ₁ - α₁ := sub_pos.mpr h1
  have hv0 : 0 < α₂ - φ₂ := sub_pos.mpr h2
  -- the triangle inequality through the two points of `ω(P)` under the lens points
  have hd1 : dist (P + (t₁ : ℂ) * e φ₁) (P + e φ₁) = t₁ - 1 := by
    rw [dist_eq_norm, show P + (t₁ : ℂ) * e φ₁ - (P + e φ₁) = ((t₁ - 1 : ℝ) : ℂ) * e φ₁ by push_cast; ring, norm_mul, norm_e,
      mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  have hd2 : dist (P + e φ₂) (P + (t₂ : ℂ) * e φ₂) = t₂ - 1 := by
    rw [dist_comm, dist_eq_norm, show P + (t₂ : ℂ) * e φ₂ - (P + e φ₂) = ((t₂ - 1 : ℝ) : ℂ) * e φ₂ by push_cast; ring, norm_mul,
      norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  have hd3 : dist (P + e φ₁) (P + e φ₂) = 2 * Real.sin ((φ₂ - φ₁) / 2) := by
    rw [dist_eq_norm, add_sub_add_left_eq_sub, norm_sub_rev, norm_e_sub_e_eq, abs_of_nonneg]
    exact Real.sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith)
  have htri := dist_triangle4 (P + (t₁ : ℂ) * e φ₁) (P + e φ₁) (P + e φ₂) (P + (t₂ : ℂ) * e φ₂)
  rw [hd1, hd2, hd3] at htri
  have hsin := two_sin_half_le_of_gap (Δ := φ₂ - φ₁) (w := ((φ₁ - α₁) + (α₂ - φ₂)) / 2) (by linarith) (by linarith) (by linarith)
  have hsq := sq_div_two_lt_sin (w := ((φ₁ - α₁) + (α₂ - φ₂)) / 2) (by linarith) (by linarith)
  have hκ' : κ * (φ₁ - α₁) ^ 2 + κ * (α₂ - φ₂) ^ 2 ≤ (((φ₁ - α₁) + (α₂ - φ₂)) / 2) ^ 2 / 2 := by
    nlinarith [mul_pos hu0 hv0, mul_nonneg (sub_nonneg.mpr hκ) (add_nonneg (sq_nonneg (φ₁ - α₁)) (sq_nonneg (α₂ - φ₂)))]
  linarith

/-- Spec: `dist_lt_one_of_thin` at numbers — the lens points over the ends' neighbours of a `60°` arc (`φ₁ = 1/100`,
`φ₂ = π/3 − 1/100`, heights at the bound with `κ = 1/8`) are closer than `1`, though their angles are almost `60°` apart. -/
example : dist ((0 : ℂ) + ((1 + 1 / 8 * (1 / 100 - 0) ^ 2 : ℝ) : ℂ) * e (1 / 100))
    (0 + ((1 + 1 / 8 * (π / 3 - (π / 3 - 1 / 100)) ^ 2 : ℝ) : ℂ) * e (π / 3 - 1 / 100)) < 1 :=
  dist_lt_one_of_thin (α₁ := 0) (α₂ := π / 3) (κ := 1 / 8) (by linarith) (by norm_num) (by linarith [Real.pi_gt_three])
    (by linarith) le_rfl (by norm_num) le_rfl (by nlinarith [Real.pi_pos]) le_rfl

/-- The outward profile lies under the first end's enclosing circle. -/
theorem outerProf_le_left {θ₁ θ₂ R θ : ℝ} (hθ : θ ∈ Icc θ₁ θ₂) : outerProf θ₁ θ₂ R θ ≤ tangRad R (θ - θ₁) := by
  have hc : clampAngle θ₁ θ₂ θ = θ := by unfold clampAngle; rw [min_eq_left hθ.2, max_eq_right hθ.1]
  unfold outerProf; rw [hc]; exact min_le_left _ _

/-- The outward profile lies under the second end's enclosing circle. -/
theorem outerProf_le_right {θ₁ θ₂ R θ : ℝ} (hθ : θ ∈ Icc θ₁ θ₂) : outerProf θ₁ θ₂ R θ ≤ tangRad R (θ₂ - θ) := by
  have hc : clampAngle θ₁ θ₂ θ = θ := by unfold clampAngle; rw [min_eq_left hθ.2, max_eq_right hθ.1]
  unfold outerProf; rw [hc]; exact min_le_right _ _

/-- **No unit pair in a thin outward lens**: two points of the outward lens (with the open arc) of radius `R ∈ [1, 9/8]` over an arc
of at most `60°` are less than `1` apart (`dist_lt_one_of_thin` with `κ = R − 1`: the lens lies under each end's enclosing circle,
`tangRad_sub_one_le`). The outward counterpart of `dist_lt_one_of_mem_polarSet`. -/
theorem dist_lt_one_of_mem_lensOutSet {P : ℂ} {θ₁ θ₂ R : ℝ} (hR : 1 ≤ R) (hR8 : R ≤ 9 / 8) (hℓ : θ₂ - θ₁ ≤ π / 3) {z z' : ℂ}
    (hz : z ∈ lensOutSet P θ₁ θ₂ R) (hz' : z' ∈ lensOutSet P θ₁ θ₂ R) : dist z z' < 1 := by
  have key : ∀ {θ t θ' t' : ℝ}, θ ∈ Ioo θ₁ θ₂ → t ∈ Ico 1 (outerProf θ₁ θ₂ R θ) → θ' ∈ Ioo θ₁ θ₂ →
      t' ∈ Ico 1 (outerProf θ₁ θ₂ R θ') → θ ≤ θ' → dist (P + (t : ℂ) * e θ) (P + (t' : ℂ) * e θ') < 1 := by
    intro θ t θ' t' hθ ht hθ' ht' hle
    refine dist_lt_one_of_thin (α₁ := θ₁) (α₂ := θ₂) (κ := R - 1) hℓ hθ.1 hle hθ'.2 (by linarith) ht.1 ?_ ht'.1 ?_
    · have := tangRad_sub_one_le hR (θ - θ₁)
      linarith [ht.2, outerProf_le_left (R := R) (Ioo_subset_Icc_self hθ)]
    · have := tangRad_sub_one_le hR (θ₂ - θ')
      linarith [ht'.2, outerProf_le_right (R := R) (Ioo_subset_Icc_self hθ')]
  obtain ⟨θ, hθ, t, ht, rfl⟩ := hz
  obtain ⟨θ', hθ', t', ht', rfl⟩ := hz'
  rcases le_total θ θ' with h | h
  · exact key hθ ht hθ' ht' h
  · rw [dist_comm]; exact key hθ' ht' hθ ht h

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
