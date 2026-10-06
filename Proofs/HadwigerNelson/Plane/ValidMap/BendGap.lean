import Proofs.HadwigerNelson.Plane.ValidMap.CollarMapOut
import Proofs.HadwigerNelson.Plane.ValidMap.R2Cap
import Proofs.HadwigerNelson.Plane.ValidMap.HornChart

/-!
# The away bend of one gap: the outward collar bend (FS131-KA1's skeleton; mirror of `Plane/ValidMap/BendCollar`)

`bend_away_gap`: on a valid map, a constant-sided unit arc whose inner colour is absent at the centre, near whose interior points `Γ`
is `ω(P)` alone, whose radius-2 arc lies in the domain and **has no contact of the inner colour at an interior angle**, bends away
from the centre by a homeomorphism supported in a collar — the clause package `AwayBend` (`plans/FS131-bendaway-kernel-plan.md` § 3,
lane C). The ends may be contacts: there the lens is tangent to `ω(P)`, and its clearness is FS131-E5's end case (`claim_e`,
`end_cap`, `r2_side_dichotomy`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The lens against a far point near an end of the gap (pure geometry; helpers of `exists_lensOut_clear`) -/

/-- The radial coordinate read from `P`. -/
theorem r2Y_eq (P : ℂ) (θ₀ : ℝ) (z : ℂ) : r2Y P θ₀ z = ((z - P) * starRingEnd ℂ (e θ₀)).re - 2 := by
  have h : (z - (P + 2 * e θ₀)) * starRingEnd ℂ (e θ₀) = (z - P) * starRingEnd ℂ (e θ₀) - 2 := by
    rw [show z - (P + 2 * e θ₀) = (z - P) - 2 * e θ₀ by ring, sub_mul, mul_assoc, conj_e_mul_e, mul_one]
  rw [r2Y, h]
  simp

/-- The tangential coordinate of a point given in polar form about `P`. -/
theorem r2X_polar (P : ℂ) (θ₀ t φ : ℝ) : r2X P θ₀ (P + (t : ℂ) * e φ) = t * Real.sin (φ - θ₀) := by
  rw [r2X_eq, add_sub_cancel_left, conj_e, mul_assoc, ← e_add, Complex.im_ofReal_mul, im_e, sub_eq_add_neg]

/-- **The frame is an isometry**: the squared distance of two points from their frame coordinates. -/
theorem r2_dist_sq_pair (P : ℂ) (θ₀ : ℝ) (z z' : ℂ) :
    dist z z' ^ 2 = (r2X P θ₀ z - r2X P θ₀ z') ^ 2 + (r2Y P θ₀ z - r2Y P θ₀ z') ^ 2 := by
  have h : z - z' = (((r2Y P θ₀ z - r2Y P θ₀ z' : ℝ) : ℂ) + ((r2X P θ₀ z - r2X P θ₀ z' : ℝ) : ℂ) * I) * e θ₀ := by
    have h1 := r2_frame P θ₀ z
    have h2 := r2_frame P θ₀ z'
    have h3 : z - z' = (z - (P + 2 * e θ₀)) - (z' - (P + 2 * e θ₀)) := by ring
    rw [h3, h1, h2]; push_cast; ring
  rw [dist_eq_norm, h, norm_mul, norm_e, mul_one, Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_re, Complex.mul_im, Complex.I_re,
    Complex.I_im]
  ring

/-- `tangRad` is even in the angle. -/
theorem tangRad_neg (R u : ℝ) : tangRad R (-u) = tangRad R u := by
  unfold tangRad; rw [Real.cos_neg]

/-- **Strictly under the radial graph is strictly inside the tangent circle** (the strict form of `tangRad_spec`). -/
theorem dist_lt_of_lt_tangRad {R : ℝ} (hR : 1 / 2 < R) (P : ℂ) (θ u : ℝ) {t : ℝ} (ht : 0 < t) (h : t < tangRad R u) :
    dist (P + (t : ℂ) * e (θ + u)) (P + ((1 - R : ℝ) : ℂ) * e θ) < R := by
  have hRpos : 0 < R := by linarith
  have hd : dist (P + (t : ℂ) * e (θ + u)) (P + ((1 - R : ℝ) : ℂ) * e θ) ^ 2 =
      R ^ 2 + (t ^ 2 - 2 * (1 - R) * t * Real.cos u - (2 * R - 1)) := by
    rw [dist_polar_polar_sq, add_sub_cancel_left]; ring
  have hq := (lt_tangRad_iff hR u ht).mp h
  have h0 := dist_nonneg (x := P + (t : ℂ) * e (θ + u)) (y := P + ((1 - R : ℝ) : ℂ) * e θ)
  nlinarith

/-- **A far point near an end of the gap is farther than `1` from the lens** (FS131-E5's end case, plan § 2.5): let `z` be a point not
inside `ω(P)`, strictly inside the end's circle (radius `R > 1`, tangent to `ω(P)` at `r(θ_E)` and enclosing it), on the gap's side `σ`
of the line through `P` and the end; let `y` be at distance at least `1` from the end, and — if it is on the gap's side — off the disc of
radius `ρ₀ ≥ R + 1` tangent to the radius-2 circle at `P + 2 e(θ_E)` from `P`'s side. Then `|y − z| > 1`: beyond the end by `claim_e`
(no smallness), on the gap's side by `end_cap`. -/
theorem lens_end_far {P y z : ℂ} {θE σ R ρ₀ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hR : 1 < R) (hRρ : R ≤ ρ₀ - 1)
    (hz1 : 1 ≤ dist z P) (hzC : dist z (P + ((1 - R : ℝ) : ℂ) * e θE) < R) (hzσ : 0 ≤ σ * r2X P θE z)
    (hyA : 1 ≤ dist y (ringPt P θE)) (hy0 : -2 < r2Y P θE y)
    (hcap : 0 < σ * r2X P θE y → ρ₀ ≤ dist y (P + ((2 - ρ₀ : ℝ) : ℂ) * e θE)) : 1 < dist y z := by
  by_cases hside : 0 < σ * r2X P θE y
  · refine end_cap (C := P + ((1 - R : ℝ) : ℂ) * e θE) (O := P + ((2 - ρ₀ : ℝ) : ℂ) * e θE) ?_ hzC (hcap hside)
    rw [dist_eq_norm, show P + ((1 - R : ℝ) : ℂ) * e θE - (P + ((2 - ρ₀ : ℝ) : ℂ) * e θE) = ((ρ₀ - 1 - R : ℝ) : ℂ) * e θE by
      push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  · push Not at hside
    have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
    have hzP := r2_dist_sq_center P θE z
    have hzC' := r2_dist_sq P θE (1 + R) z
    rw [show (2 - (1 + R) : ℝ) = 1 - R by ring] at hzC'
    have hyA' := r2_dist_sq P θE 1 y
    rw [show P + ((2 - 1 : ℝ) : ℂ) * e θE = ringPt P θE by rw [ringPt]; norm_num] at hyA'
    have hyz := r2_dist_sq_pair P θE y z
    have hdC := dist_nonneg (x := z) (y := P + ((1 - R : ℝ) : ℂ) * e θE)
    have hdP := dist_nonneg (x := z) (y := P)
    have hdA := dist_nonneg (x := y) (y := ringPt P θE)
    have hdyz := dist_nonneg (x := y) (y := z)
    have hC2 : dist z (P + ((1 - R : ℝ) : ℂ) * e θE) ^ 2 < R ^ 2 := pow_lt_pow_left₀ hzC hdC two_ne_zero
    have hP2 : 1 ≤ dist z P ^ 2 := one_le_pow₀ hz1
    have hA2 : 1 ≤ dist y (ringPt P θE) ^ 2 := one_le_pow₀ hyA
    have hprod : (R - 1) * (1 + r2Y P θE z) < 0 := by
      have h1 : (R - 1) * (1 + r2Y P θE z) =
          (dist z (P + ((1 - R : ℝ) : ℂ) * e θE) ^ 2 - R ^ 2 - (dist z P ^ 2 - 1)) / 2 := by rw [hzC', hzP]; ring
      rw [h1]; linarith
    have hYz : r2Y P θE z < -1 := by
      by_contra h
      push Not at h
      have := mul_nonneg (show (0 : ℝ) ≤ R - 1 by linarith) (show (0 : ℝ) ≤ 1 + r2Y P θE z by linarith)
      linarith
    have hsqz : (σ * r2X P θE z) ^ 2 = r2X P θE z ^ 2 := by rw [mul_pow, hσ2, one_mul]
    have hsqy : (σ * r2X P θE y) ^ 2 = r2X P θE y ^ 2 := by rw [mul_pow, hσ2, one_mul]
    have hsqd : (σ * r2X P θE y - σ * r2X P θE z) ^ 2 = (r2X P θE y - r2X P θE z) ^ 2 := by
      rw [← mul_sub, mul_pow, hσ2, one_mul]
    have hz : 1 ≤ (r2Y P θE z + 2) ^ 2 + (σ * r2X P θE z) ^ 2 := by
      have h1 : (r2Y P θE z + 2) ^ 2 + (σ * r2X P θE z) ^ 2 = dist z P ^ 2 := by rw [hsqz, hzP]; ring
      rw [h1]; exact hP2
    have key := claim_e (z₁ := r2Y P θE z + 2) (z₂ := σ * r2X P θE z) (p₁ := r2Y P θE y + 2) (p₂ := σ * r2X P θE y)
      (by linarith) hzσ hz (by linarith) hside
    have e1 : (r2Y P θE y + 2 - 1) ^ 2 + (σ * r2X P θE y) ^ 2 = dist y (ringPt P θE) ^ 2 := by rw [hsqy, hyA']; ring
    have e2 : (r2Y P θE y + 2 - (r2Y P θE z + 2)) ^ 2 + (σ * r2X P θE y - σ * r2X P θE z) ^ 2 = dist y z ^ 2 := by
      rw [hsqd, hyz]; ring
    rw [e1, e2] at key
    exact lt_of_pow_lt_pow_left₀ 2 hdyz (by rw [one_pow]; linarith)

/-- **A far point near an end of the gap, on the gap's side, is not inside the radius-2 circle** (plan § 2.4, N-c): its direction from
`P` is an angle of the closed arc, and it is at distance at least `1` from the arc's point in that direction. -/
theorem two_le_dist_of_far {P y : ℂ} {a b θE σ η : ℝ} (hσE : (σ = 1 ∧ θE = a) ∨ (σ = -1 ∧ θE = b)) (hab : a < b)
    (hℓ : b - a ≤ π / 3) (hfar : ∀ θ ∈ Icc a b, 1 ≤ dist y (ringPt P θ)) (hη : η ≤ 1 / 2) (hη' : η ≤ Real.sin (b - a))
    (hd : dist y (P + 2 * e θE) < η) (hside : 0 < σ * r2X P θE y) : 2 ≤ dist y P := by
  have hπ := Real.pi_pos
  have hσ : σ = 1 ∨ σ = -1 := hσE.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1)
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hN := r2_dist_sq_base P θE y
  have hd0 := dist_nonneg (x := y) (y := P + 2 * e θE)
  have hNη : r2X P θE y ^ 2 + r2Y P θE y ^ 2 < η ^ 2 := by rw [← hN]; nlinarith
  have hXη : σ * r2X P θE y < η := by
    have h1 : (σ * r2X P θE y) ^ 2 < η ^ 2 := by rw [mul_pow, hσ2, one_mul]; nlinarith [sq_nonneg (r2Y P θE y)]
    nlinarith
  have hY : -(1 / 2) < r2Y P θE y := by nlinarith [sq_nonneg (r2X P θE y), sq_nonneg (r2Y P θE y + 1 / 2)]
  have hwim : ((y - P) * starRingEnd ℂ (e θE)).im = r2X P θE y := (r2X_eq P θE y).symm
  have hwre : ((y - P) * starRingEnd ℂ (e θE)).re = r2Y P θE y + 2 := by rw [r2Y_eq]; ring
  have hnorm : ‖(y - P) * starRingEnd ℂ (e θE)‖ = dist y P := by
    rw [norm_mul, RCLike.norm_conj, norm_e, mul_one, dist_eq_norm]
  have hs : 3 / 2 < dist y P := by
    have := Complex.re_le_norm ((y - P) * starRingEnd ℂ (e θE))
    rw [hnorm, hwre] at this
    linarith
  have hpol := eq_polar_frameDir P y θE
  have hα2 : |arg ((y - P) * starRingEnd ℂ (e θE))| < π / 2 :=
    Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl (by rw [hwre]; linarith))
  have hsin : Real.sin (arg ((y - P) * starRingEnd ℂ (e θE))) = r2X P θE y / dist y P := by
    rw [Complex.sin_arg, hwim, hnorm]
  generalize arg ((y - P) * starRingEnd ℂ (e θE)) = α at hpol hα2 hsin
  have hsinσ : Real.sin (σ * α) = σ * r2X P θE y / dist y P := by
    rcases hσ with rfl | rfl
    · rw [one_mul, one_mul, hsin]
    · rw [neg_one_mul, Real.sin_neg, hsin]; ring
  have hsin0 : 0 < Real.sin (b - a) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hpos : 0 < Real.sin (σ * α) := by rw [hsinσ]; exact div_pos hside (by linarith)
  have hlt : Real.sin (σ * α) < Real.sin (b - a) := by
    rw [hsinσ, div_lt_iff₀ (by linarith)]
    nlinarith
  have hσα : |σ * α| < π / 2 := by rcases hσ with rfl | rfl <;> simpa using hα2
  have h0 : 0 < σ * α := by
    by_contra h
    push Not at h
    have := Real.sin_nonpos_of_nonpos_of_neg_pi_le h (by linarith [(abs_lt.mp hσα).1])
    linarith
  have h1 : σ * α < b - a := by
    by_contra h
    push Not at h
    have := Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) (abs_lt.mp hσα).2.le h
    linarith
  have hθ : θE + α ∈ Icc a b := by
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · exact ⟨by linarith, by linarith⟩
    · exact ⟨by linarith, by linarith⟩
  have hdist := dist_polar_ringPt P (dist y P) (θE + α)
  rw [← hpol] at hdist
  have := hfar _ hθ
  rw [hdist, abs_of_neg (by linarith)] at this
  linarith

/-! ## The horn clause of a collar bend, either way (FS131-BA2; plan § 4) -/

/-- **A circle tangent to `ω(P)` from inside or around meets it only at the point of tangency**: a point of `ω(P)` on the circle of
radius `R ≠ 1` about `P + (1 − R) e(θ)` is `r(θ)`. -/
theorem eq_ringPt_of_mem_tangentCircle {P z : ℂ} {θ R : ℝ} (hR1 : R ≠ 1) (hz1 : dist z P = 1)
    (hzR : dist z (P + ((1 - R : ℝ) : ℂ) * e θ) = R) : z = ringPt P θ := by
  have h1 := r2_dist_sq_center P θ z
  have h2 := r2_dist_sq P θ (1 + R) z
  rw [show (2 - (1 + R) : ℝ) = 1 - R by ring, hzR] at h2
  rw [hz1] at h1
  have h3 : (R - 1) * (1 + r2Y P θ z) = 0 := by linear_combination (h1 - h2) / 2
  have hY : r2Y P θ z = -1 := by
    rcases mul_eq_zero.mp h3 with h | h
    · exact absurd (by linarith) hR1
    · linarith
  have hX : r2X P θ z = 0 := by
    have : r2X P θ z ^ 2 = 0 := by rw [hY] at h1; linarith
    exact pow_eq_zero_iff (two_ne_zero) |>.mp this
  have hf := r2_frame P θ z
  rw [hY, hX] at hf
  have hf' : z - (P + 2 * e θ) = -e θ := by rw [hf]; push_cast; ring
  rw [ringPt]
  linear_combination hf'

/-- **Two circles of one radius whose centres are apart, and closer than a diameter, cross**: at a common point the two radii are not
parallel. -/
theorem im_ne_zero_of_two_spheres {x q q' : ℂ} {R : ℝ} (hq : dist x q = R) (hq' : dist x q' = R) (hne : q ≠ q')
    (hlt : dist q q' < 2 * R) : ((x - q) * starRingEnd ℂ (x - q')).im ≠ 0 := by
  intro him
  have hR : 0 < R := by
    have := dist_pos.mpr hne
    linarith
  have hu : Complex.normSq (x - q) = R ^ 2 := by rw [Complex.normSq_eq_norm_sq, ← dist_eq_norm, hq]
  have hv : Complex.normSq (x - q') = R ^ 2 := by rw [Complex.normSq_eq_norm_sq, ← dist_eq_norm, hq']
  have hprod : Complex.normSq ((x - q) * starRingEnd ℂ (x - q')) = R ^ 2 * R ^ 2 := by
    rw [Complex.normSq_mul, Complex.normSq_conj, hu, hv]
  rw [Complex.normSq_apply, him] at hprod
  have hsub := Complex.normSq_sub (x - q) (x - q')
  rw [hu, hv, show x - q - (x - q') = q' - q by ring, Complex.normSq_eq_norm_sq, ← dist_eq_norm, dist_comm] at hsub
  have hd0 := dist_pos.mpr hne
  set a := ((x - q) * starRingEnd ℂ (x - q')).re with ha
  have hfac : (a - R ^ 2) * (a + R ^ 2) = 0 := by nlinarith
  rcases mul_eq_zero.mp hfac with h | h
  · have : dist q q' ^ 2 = 0 := by rw [hsub]; linarith
    nlinarith
  · have : dist q q' ^ 2 = (2 * R) ^ 2 := by rw [hsub]; linarith
    nlinarith

/-- **A branch at an end of the arc, in the end's frame**: the branch from `r(θ_E)` along the arc's direction on the side `σ`, of
curvature `σ/ρ`, is `P + (1 + s e(σ(π/2 + arcsin(s/(2ρ))))) e(θ_E)`. -/
theorem branchPt_end_frame (P : ℂ) (θE ρ s : ℝ) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) :
    branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s =
      P + (1 + (s : ℂ) * e (σ * (π / 2 + Real.arcsin (s / (2 * ρ))))) * e θE := by
  have harc : Real.arcsin (σ / ρ * s / 2) = σ * Real.arcsin (s / (2 * ρ)) := by
    rcases hσ with rfl | rfl
    · rw [one_mul]; congr 1; ring
    · rw [show (-1 : ℝ) / ρ * s / 2 = -(s / (2 * ρ)) by ring, Real.arcsin_neg]; ring
  rw [branchPt, harc, ringPt, show θE + σ * (π / 2) + σ * Real.arcsin (s / (2 * ρ)) =
    σ * (π / 2 + Real.arcsin (s / (2 * ρ))) + θE by ring, e_add]
  ring

/-- `e (σ φ)` is `e φ` or its conjugate. -/
theorem e_sign_mul {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (φ : ℝ) :
    (σ = 1 ∧ e (σ * φ) = e φ) ∨ (σ = -1 ∧ e (σ * φ) = starRingEnd ℂ (e φ)) := by
  rcases hσ with rfl | rfl
  · exact Or.inl ⟨rfl, by rw [one_mul]⟩
  · exact Or.inr ⟨rfl, by rw [neg_one_mul, conj_e]⟩

/-- **A branch at an end of the arc lies on its tangent circle** (`germ_tangentCircle`, in either direction). -/
theorem dist_branchPt_end (P : ℂ) (θE : ℝ) {ρ s σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hρ : 0 < ρ) (hs : 0 ≤ s) (hs2 : s ≤ 2 * ρ) :
    dist (branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s) (P + ((1 - ρ : ℝ) : ℂ) * e θE) = ρ := by
  obtain ⟨g1, -, -⟩ := germ_tangentCircle hρ hs hs2
  rw [branchPt_end_frame P θE ρ s hσ, dist_eq_norm,
    show P + (1 + (s : ℂ) * e (σ * (π / 2 + Real.arcsin (s / (2 * ρ))))) * e θE - (P + ((1 - ρ : ℝ) : ℂ) * e θE) =
      (1 + (s : ℂ) * e (σ * (π / 2 + Real.arcsin (s / (2 * ρ)))) - ((1 - ρ : ℝ) : ℂ)) * e θE by ring, norm_mul, norm_e, mul_one]
  rcases e_sign_mul hσ (π / 2 + Real.arcsin (s / (2 * ρ))) with ⟨-, h⟩ | ⟨-, h⟩
  · rw [h]; exact g1
  · have key : ‖1 + (s : ℂ) * starRingEnd ℂ (e (π / 2 + Real.arcsin (s / (2 * ρ)))) - ((1 - ρ : ℝ) : ℂ)‖ =
        ‖1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * ρ))) - ((1 - ρ : ℝ) : ℂ)‖ := by
      rw [← RCLike.norm_conj (1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * ρ))) - ((1 - ρ : ℝ) : ℂ))]
      congr 1
      simp only [map_sub, map_add, map_one, map_mul, Complex.conj_ofReal]
    rw [h, key]; exact g1

/-- **A branch at an end of the arc, in polar form about `P`** (`germ_tangentCircle`, `polar_tangentCircle`, `eq_of_tangentCircle`, the
intermediate value theorem on the chord): for `ρ > 1/2` and a chord `s ≤ 1`, the branch point is `P + tangRad ρ u · e(θ_E + σ u)` for an
angle `u ∈ [0, π/2]` whose chord is `s`. -/
theorem branchPt_end_polar (P : ℂ) (θE : ℝ) {ρ s σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hρ : 1 / 2 < ρ) (hs : 0 ≤ s) (hs1 : s ≤ 1) :
    ∃ u ∈ Icc (0 : ℝ) (π / 2), branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s = P + (tangRad ρ u : ℂ) * e (θE + σ * u) ∧
      ‖(tangRad ρ u : ℂ) * e u - 1‖ = s := by
  have hπ := Real.pi_pos
  have hρ0 : 0 < ρ := by linarith
  have hcont : Continuous fun u : ℝ => ‖(tangRad ρ u : ℂ) * e u - 1‖ :=
    ((Complex.continuous_ofReal.comp (continuous_tangRad ρ)).mul continuous_e).sub continuous_const |>.norm
  have hf0 : ‖(tangRad ρ 0 : ℂ) * e 0 - 1‖ = 0 := by rw [tangRad_zero hρ0.le, e_zero]; simp
  have hf1 : s ≤ ‖(tangRad ρ (π / 2) : ℂ) * e (π / 2) - 1‖ := by
    obtain ⟨-, -, h3⟩ := polar_tangentCircle hρ (show (0 : ℝ) ≤ π / 2 by linarith) (by linarith)
    rw [Real.cos_pi_div_two, mul_zero, sub_zero, mul_one] at h3
    have hn := norm_nonneg ((tangRad ρ (π / 2) : ℂ) * e (π / 2) - 1)
    nlinarith
  obtain ⟨u, hu, hus⟩ := intermediate_value_Icc (show (0 : ℝ) ≤ π / 2 by linarith) hcont.continuousOn
    (show s ∈ Icc (‖(tangRad ρ 0 : ℂ) * e 0 - 1‖) (‖(tangRad ρ (π / 2) : ℂ) * e (π / 2) - 1‖) from ⟨by rw [hf0]; exact hs, hf1⟩)
  have hus' : ‖(tangRad ρ u : ℂ) * e u - 1‖ = s := hus
  refine ⟨u, hu, ?_, hus'⟩
  obtain ⟨g1, g2, g3⟩ := germ_tangentCircle hρ0 hs (by linarith)
  obtain ⟨p1, p2, -⟩ := polar_tangentCircle hρ hu.1 (by linarith [hu.2])
  have heq : 1 + (s : ℂ) * e (π / 2 + Real.arcsin (s / (2 * ρ))) = (tangRad ρ u : ℂ) * e u :=
    eq_of_tangentCircle hρ0 g1 p1 g2 p2 (by rw [g3, hus'])
  rw [branchPt_end_frame P θE ρ s hσ, e_add, mul_comm (e θE), ← mul_assoc]
  congr 2
  rcases e_sign_mul hσ (π / 2 + Real.arcsin (s / (2 * ρ))) with ⟨rfl, h⟩ | ⟨rfl, h⟩
  · rw [h, heq, one_mul]
  · rw [h, neg_one_mul, ← conj_e u, ← Complex.conj_ofReal (tangRad ρ u), ← map_mul, ← heq]
    simp only [map_add, map_one, map_mul, Complex.conj_ofReal]

/-- **The arc's own branch at an end**: the branch of curvature `σ` is `ω(P)`, the point at chord `s ≤ 1` being `r(θ_E + σ u)` with
`2 sin (u/2) = s`, `u ∈ [0, π/2]`. -/
theorem branchPt_end_unit (P : ℂ) (θE : ℝ) {s σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hs : 0 ≤ s) (hs1 : s ≤ 1) :
    ∃ u ∈ Icc (0 : ℝ) (π / 2), branchPt (ringPt P θE) (θE + σ * (π / 2)) σ s = ringPt P (θE + σ * u) ∧
      2 * Real.sin (u / 2) = s := by
  have hπ := Real.pi_pos
  obtain ⟨u, hu, h1, h2⟩ := branchPt_end_polar P θE (ρ := 1) hσ (by norm_num) hs hs1
  refine ⟨u, hu, ?_, ?_⟩
  · have ht : tangRad 1 u = 1 := by unfold tangRad; norm_num
    rw [div_one, ht] at h1
    rw [h1, ringPt]; simp
  · have ht : tangRad 1 u = 1 := by unfold tangRad; norm_num
    rw [ht] at h2
    have h3 := norm_e_sub_e_eq u 0
    rw [e_zero, sub_zero, abs_of_nonneg (Real.sin_nonneg_of_nonneg_of_le_pi (by linarith [hu.1]) (by linarith [hu.2]))] at h3
    rw [← h3, ← h2]; simp

/-- On `[0, π/2]` a smaller sine is a smaller angle. -/
theorem lt_of_sin_lt_sin {u u₁ : ℝ} (hu : u ∈ Icc (0 : ℝ) (π / 2)) (hu₁ : 0 ≤ u₁) (h : Real.sin u < Real.sin u₁) : u < u₁ := by
  have hπ := Real.pi_pos
  by_contra hle
  push Not at hle
  have := Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) hu.2 hle
  linarith

/-- A curvature between `1` and `1/R` (after the sign) is `1/ρ` for a radius `ρ` strictly between any `R' < min R 1` and
`R'' > max R 1`. -/
theorem inv_between {R' R R'' m : ℝ} (hR' : 0 < R') (hR'R : R' < R) (hR'1 : R' < 1) (hRR'' : R < R'') (h1R'' : 1 < R'')
    (hm1 : min 1 (1 / R) ≤ m) (hm2 : m ≤ max 1 (1 / R)) : 0 < m ∧ R' < 1 / m ∧ 1 / m < R'' := by
  have hR0 : 0 < R := by linarith
  have hinv : 0 < 1 / R := by positivity
  have hm0 : 0 < m := lt_of_lt_of_le (lt_min one_pos hinv) hm1
  refine ⟨hm0, ?_, ?_⟩
  · rw [lt_div_iff₀ hm0]
    rcases le_max_iff.mp hm2 with h | h
    · nlinarith
    · have : m * R ≤ 1 := by rwa [le_div_iff₀ hR0] at h
      nlinarith
  · rw [div_lt_iff₀ hm0]
    rcases min_le_iff.mp hm1 with h | h
    · nlinarith
    · have : 1 ≤ m * R := by rwa [div_le_iff₀ hR0] at h
      nlinarith

/-- **Near an end of the arc, the branches along the arc in polar form, with small angles** (the radius the end case works in): for
`s < r` the arc's own branch point is `r(θ_E + σ u)` and the branch point of radius `ρ > 1/2` is `P + tangRad ρ u · e(θ_E + σ u)`,
with `0 < u < θ₂ − θ₁` so small that the other end's two profiles stay off `1` there. -/
theorem exists_collar_end_radius (P : ℂ) (θE : ℝ) {θ₁ θ₂ σ R' R'' b : ℝ} (hσ : σ = 1 ∨ σ = -1) (h12 : θ₁ < θ₂)
    (hℓ : θ₂ - θ₁ ≤ π / 3) (hR' : 1 / 2 < R') (hR'1 : R' < 1) (h1R'' : 1 < R'') (hb : 0 < b) :
    ∃ r > 0, r ≤ 1 / 2 ∧ r ≤ b ∧
      (∀ s ∈ Ioo 0 r, ∃ u, 0 < u ∧ u < θ₂ - θ₁ ∧
        branchPt (ringPt P θE) (θE + σ * (π / 2)) σ s = ringPt P (θE + σ * u) ∧ 2 * Real.sin (u / 2) = s) ∧
      ∀ ρ : ℝ, 1 / 2 < ρ → ∀ s ∈ Ioo 0 r, ∃ u, 0 < u ∧ u < θ₂ - θ₁ ∧
        tangRad R' (θ₂ - θ₁ - u) < tangRad R' u ∧ tangRad R'' u < tangRad R'' (θ₂ - θ₁ - u) ∧
        branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s = P + (tangRad ρ u : ℂ) * e (θE + σ * u) := by
  have hπ := Real.pi_pos
  have hℓ0 : 0 < θ₂ - θ₁ := by linarith
  -- near angle `0` the other end's two profiles stay off `1`
  obtain ⟨u₀, hu₀, hprof⟩ : ∃ u₀ > 0, ∀ u : ℝ, |u| < u₀ →
      tangRad R' (θ₂ - θ₁ - u) < tangRad R' u ∧ tangRad R'' u < tangRad R'' (θ₂ - θ₁ - u) := by
    have hc1 : Continuous fun u : ℝ => tangRad R' u - tangRad R' (θ₂ - θ₁ - u) :=
      (continuous_tangRad R').sub ((continuous_tangRad R').comp (continuous_const.sub continuous_id))
    have hc2 : Continuous fun u : ℝ => tangRad R'' (θ₂ - θ₁ - u) - tangRad R'' u :=
      ((continuous_tangRad R'').comp (continuous_const.sub continuous_id)).sub (continuous_tangRad R'')
    have hab : 0 < |θ₂ - θ₁| ∧ |θ₂ - θ₁| ≤ π := by rw [abs_of_pos hℓ0]; exact ⟨hℓ0, by linarith⟩
    have h1 : (0 : ℝ) < tangRad R' 0 - tangRad R' (θ₂ - θ₁ - 0) := by
      rw [tangRad_zero (by linarith), sub_zero]
      linarith [tangRad_lt_one hR' hR'1 hab.1 hab.2]
    have h2 : (0 : ℝ) < tangRad R'' (θ₂ - θ₁ - 0) - tangRad R'' 0 := by
      rw [tangRad_zero (by linarith), sub_zero]
      linarith [one_lt_tangRad h1R'' hab.1 hab.2]
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp
      ((hc1.continuousAt.eventually (lt_mem_nhds h1)).and (hc2.continuousAt.eventually (lt_mem_nhds h2)))
    refine ⟨ε, hε, fun u hu => ?_⟩
    have := hball (show dist u 0 < ε by rwa [Real.dist_eq, sub_zero])
    exact ⟨by linarith [this.1], by linarith [this.2]⟩
  obtain ⟨u₁, hu₁0, hu₁u₀, hu₁ℓ⟩ : ∃ u₁ > 0, u₁ ≤ u₀ ∧ u₁ ≤ θ₂ - θ₁ :=
    ⟨min u₀ (θ₂ - θ₁), lt_min hu₀ hℓ0, min_le_left _ _, min_le_right _ _⟩
  have hsu₁ : 0 < Real.sin u₁ := Real.sin_pos_of_pos_of_lt_pi hu₁0 (by linarith)
  obtain ⟨r, hr, hr2, hrb, hrs⟩ : ∃ r > 0, r ≤ 1 / 2 ∧ r ≤ b ∧ 2 * r ≤ Real.sin u₁ := by
    refine ⟨min (min (1 / 2) b) (Real.sin u₁ / 2), lt_min (lt_min (by norm_num) hb) (by linarith),
      (min_le_left _ _).trans (min_le_left _ _), (min_le_left _ _).trans (min_le_right _ _), ?_⟩
    have h1 : min (min (1 / 2) b) (Real.sin u₁ / 2) ≤ Real.sin u₁ / 2 := min_le_right _ _
    linarith
  refine ⟨r, hr, hr2, hrb, fun s hs => ?_, fun ρ hρ s hs => ?_⟩
  · obtain ⟨u, hu, h1, h2⟩ := branchPt_end_unit P θE hσ hs.1.le (by linarith [hs.2])
    have hu0 : 0 < u := by
      rcases eq_or_lt_of_le hu.1 with h | h
      · rw [← h] at h2; simp at h2; linarith [hs.1]
      · exact h
    have hsin : Real.sin u ≤ s := by
      have h3 := Real.sin_two_mul (u / 2)
      rw [show 2 * (u / 2) = u by ring] at h3
      have hc := Real.cos_le_one (u / 2)
      have hs0 : 0 ≤ Real.sin (u / 2) := Real.sin_nonneg_of_nonneg_of_le_pi (by linarith) (by linarith [hu.2])
      nlinarith
    have hlt : u < u₁ := lt_of_sin_lt_sin hu hu₁0.le (by linarith [hs.2])
    exact ⟨u, hu0, hlt.trans_le hu₁ℓ, h1, h2⟩
  · obtain ⟨u, hu, h1, h2⟩ := branchPt_end_polar P θE hσ hρ hs.1.le (by linarith [hs.2])
    have ht := tangRad_pos hρ u
    have hu0 : 0 < u := by
      rcases eq_or_lt_of_le hu.1 with h | h
      · rw [← h, tangRad_zero (by linarith), e_zero] at h2; simp at h2; linarith [hs.1]
      · exact h
    have hnorm : ‖(tangRad ρ u : ℂ) * e u‖ = tangRad ρ u := by
      rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.le]
    have htge : 1 - s ≤ tangRad ρ u := by
      have h3 := norm_sub_norm_le (1 : ℂ) ((tangRad ρ u : ℂ) * e u)
      rw [norm_one, hnorm, norm_sub_rev, h2] at h3
      linarith
    have him : tangRad ρ u * Real.sin u ≤ s := by
      have h3 := Complex.abs_im_le_norm ((tangRad ρ u : ℂ) * e u - 1)
      rw [h2, Complex.sub_im, Complex.im_ofReal_mul, im_e, Complex.one_im, sub_zero] at h3
      exact (le_abs_self _).trans h3
    have hsu : 0 ≤ Real.sin u := Real.sin_nonneg_of_nonneg_of_le_pi hu.1 (by linarith [hu.2])
    have hlt : u < u₁ := by
      refine lt_of_sin_lt_sin hu hu₁0.le ?_
      nlinarith [hs.2, mul_nonneg hsu (show (0 : ℝ) ≤ tangRad ρ u - 1 / 2 by linarith [hs.2])]
    obtain ⟨a3, a4⟩ := hprof u (by rw [abs_of_pos hu0]; linarith)
    exact ⟨u, hu0, hlt.trans_le hu₁ℓ, a3, a4, h1⟩

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A branch at an end with a curvature strictly between the arc's and the lens's is off `Γ`**: it lies in the collar (between the
profiles of radii `R'` and `R''`: the polar form) and off `ω(P)` (radius `≠ 1`), and `Γ` meets the collar only on the arc. -/
theorem branch_between_notMem_Γ {P : ℂ} {θ₁ θ₂ θE σ R' R R'' κ s : ℝ} (hσE : (σ = 1 ∧ θE = θ₁) ∨ (σ = -1 ∧ θE = θ₂))
    (hℓ : θ₂ - θ₁ ≤ π / 3) (hR' : 1 / 2 < R') (hR'R : R' < R) (hR'1 : R' < 1) (hRR'' : R < R'') (h1R'' : 1 < R'')
    (hfree : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂)
    (hκ1 : min σ (σ / R) ≤ κ) (hκ2 : κ ≤ max σ (σ / R)) (hκne : κ ≠ σ)
    (hpol : ∀ ρ : ℝ, 1 / 2 < ρ → ∃ u, 0 < u ∧ u < θ₂ - θ₁ ∧
      tangRad R' (θ₂ - θ₁ - u) < tangRad R' u ∧ tangRad R'' u < tangRad R'' (θ₂ - θ₁ - u) ∧
      branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / ρ) s = P + (tangRad ρ u : ℂ) * e (θE + σ * u)) :
    branchPt (ringPt P θE) (θE + σ * (π / 2)) κ s ∉ F.Γ := by
  intro hzΓ
  have hπ := Real.pi_pos
  have hσ : σ = 1 ∨ σ = -1 := hσE.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1)
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hm : min 1 (1 / R) ≤ σ * κ ∧ σ * κ ≤ max 1 (1 / R) := by
    rcases hσ with rfl | rfl
    · rw [one_mul]; exact ⟨hκ1, hκ2⟩
    · rw [neg_div, min_neg_neg] at hκ1
      rw [neg_div, max_neg_neg] at hκ2
      exact ⟨by linarith, by linarith⟩
  obtain ⟨hm0, hρlo, hρhi⟩ := inv_between (by linarith) hR'R hR'1 hRR'' h1R'' hm.1 hm.2
  have hm1 : σ * κ ≠ 1 := fun h => hκne (by have := congrArg (σ * ·) h; simpa [← mul_assoc, hσ2] using this)
  have hκρ : κ = σ / (1 / (σ * κ)) := by
    rw [div_div_eq_mul_div, div_one, ← mul_assoc, hσ2, one_mul]
  have hρ1 : 1 / (σ * κ) ≠ 1 := fun h => hm1 (by rw [div_eq_one_iff_eq hm0.ne'] at h; exact h.symm)
  have hρ2 : (1 : ℝ) / 2 < 1 / (σ * κ) := by linarith
  obtain ⟨u, hu0, hu1, a3, a4, hz⟩ := hpol (1 / (σ * κ)) hρ2
  rw [← hκρ] at hz
  have huabs : 0 < |u| ∧ |u| ≤ π := by
    rw [abs_of_pos hu0]
    exact ⟨hu0, by linarith⟩
  have ht := tangRad_pos hρ2 u
  have a1 := tangRad_lt_tangRad hR' hρlo huabs.1 huabs.2
  have a2 := tangRad_lt_tangRad hρ2 hρhi huabs.1 huabs.2
  have hθ : θE + σ * u ∈ Icc θ₁ θ₂ := by
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> constructor <;> linarith
  have hclamp : clampAngle θ₁ θ₂ (θE + σ * u) = θE + σ * u := by
    unfold clampAngle; rw [min_eq_left hθ.2, max_eq_right hθ.1]
  have hzK : branchPt (ringPt P θE) (θE + σ * (π / 2)) κ s ∈ collarK P θ₁ θ₂ R' R'' := by
    rw [hz]
    refine ⟨_, hθ, _, ⟨?_, ?_⟩, rfl⟩
    · unfold lensProf
      rw [hclamp]
      rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
      · rw [show θE + 1 * u - θE = u by ring, show θ₂ - (θE + 1 * u) = θ₂ - θE - u by ring]
        exact max_le a1.le (a3.le.trans a1.le)
      · rw [show θE + -1 * u - θ₁ = θE - θ₁ - u by ring, show θE - (θE + -1 * u) = u by ring]
        exact max_le (a3.le.trans a1.le) a1.le
    · unfold outerProf
      rw [hclamp]
      rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
      · rw [show θE + 1 * u - θE = u by ring, show θ₂ - (θE + 1 * u) = θ₂ - θE - u by ring]
        exact le_min a2.le (a2.le.trans a4.le)
      · rw [show θE + -1 * u - θ₁ = θE - θ₁ - u by ring, show θE - (θE + -1 * u) = u by ring]
        exact le_min (a2.le.trans a4.le) a2.le
  obtain ⟨θ', -, hθ'⟩ := hfree ⟨hzΓ, hzK⟩
  have hd1 : dist (branchPt (ringPt P θE) (θE + σ * (π / 2)) κ s) P = 1 := by rw [← hθ']; exact dist_ringPt P θ'
  rw [hz, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.le] at hd1
  rcases lt_or_gt_of_ne hρ1 with h | h
  · linarith [tangRad_lt_one hρ2 h huabs.1 huabs.2]
  · linarith [one_lt_tangRad h huabs.1 huabs.2]

/-- **`Γ_M` near an end of a collar bend**: `Γ_F` with the arc's branch replaced by the lens arc's. -/
theorem collar_end_Γ {M : ArcMap k} {P : ℂ} {θ₁ θ₂ θE σ R dE r : ℝ} {L' : Set ℂ}
    (hσE : (σ = 1 ∧ θE = θ₁) ∨ (σ = -1 ∧ θE = θ₂)) (hR0 : 0 < R) (hdE : 0 < dE) (hdE2 : dE ≤ 2 * R) (hrd : r ≤ dE)
    (hballL : ball (ringPt P θE) r ⊆ L'ᶜ)
    (hunit : ∀ s ∈ Ioo 0 r, ∃ u, 0 < u ∧ u < θ₂ - θ₁ ∧
      branchPt (ringPt P θE) (θE + σ * (π / 2)) σ s = ringPt P (θE + σ * u) ∧ 2 * Real.sin (u / 2) = s)
    (hu2 : θ₂ - θ₁ ≤ π / 3)
    (hΓ : M.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪
      ((germArc (ringPt P θE) (θE + σ * (π / 2)) (σ / R) dE).carrier ∪ L')) :
    (M.Γ ∩ ball (ringPt P θE) r) \ {ringPt P θE} =
      ((F.Γ ∩ ball (ringPt P θE) r) \ {ringPt P θE}) \ (branchPt (ringPt P θE) (θE + σ * (π / 2)) σ '' Ioo 0 r) ∪
        branchPt (ringPt P θE) (θE + σ * (π / 2)) (σ / R) '' Ioo 0 r := by
  have hπ := Real.pi_pos
  have hσ : σ = 1 ∨ σ = -1 := hσE.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1)
  have hσabs : |σ| = 1 := by rcases hσ with rfl | rfl <;> simp
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hangO : ∀ u : ℝ, 0 < u → u < θ₂ - θ₁ → θE + σ * u ∈ Ioo θ₁ θ₂ := by
    intro u h0 h1
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> constructor <;> linarith
  have hdistb : ∀ {β κ s : ℝ}, 0 < s → dist (branchPt (ringPt P θE) β κ s) (ringPt P θE) = s := fun {β κ s} hs => by
    rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs.le]
  have hneb : ∀ {β κ s : ℝ}, 0 < s → branchPt (ringPt P θE) β κ s ≠ ringPt P θE := fun {β κ s} hs h => by
    have := hdistb (β := β) (κ := κ) hs
    rw [h, dist_self] at this
    linarith
  have hκR : |σ / R| * dE ≤ 2 := by
    rw [abs_div, hσabs, abs_of_pos hR0, div_mul_eq_mul_div, one_mul, div_le_iff₀ hR0]; linarith
  rw [hΓ, carrier_germArc _ _ hdE.le hκR]
  ext z
  constructor
  · rintro ⟨⟨hzM, hzb⟩, hzx⟩
    rcases hzM with ⟨hzΓ, hzO⟩ | ⟨s, hs, rfl⟩ | hzL
    · refine Or.inl ⟨⟨⟨hzΓ, hzb⟩, hzx⟩, ?_⟩
      rintro ⟨s, hs, rfl⟩
      obtain ⟨u, hu0, hu1, h1, -⟩ := hunit s hs
      exact hzO ⟨_, hangO u hu0 hu1, h1.symm⟩
    · have hs0 : 0 < s := lt_of_le_of_ne hs.1 fun h => hzx (by rw [← h]; simp [branchPt])
      rw [mem_ball, hdistb hs0] at hzb
      exact Or.inr ⟨s, ⟨hs0, hzb⟩, rfl⟩
    · exact absurd hzL (hballL hzb)
  · rintro (⟨⟨⟨hzΓ, hzb⟩, hzx⟩, hzB⟩ | ⟨s, hs, rfl⟩)
    · refine ⟨⟨Or.inl ⟨hzΓ, ?_⟩, hzb⟩, hzx⟩
      rintro ⟨θ, hθ, rfl⟩
      apply hzB
      have hs'0 : 0 < dist (ringPt P θ) (ringPt P θE) := dist_pos.mpr hzx
      have hs'r : dist (ringPt P θ) (ringPt P θE) < r := hzb
      obtain ⟨u, hu0, hu1, h1, h2⟩ := hunit _ ⟨hs'0, hs'r⟩
      refine ⟨_, ⟨hs'0, hs'r⟩, ?_⟩
      rw [h1]
      have hv : 0 < σ * (θ - θE) ∧ σ * (θ - θE) ≤ θ₂ - θ₁ := by
        rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> constructor <;> linarith [hθ.1, hθ.2]
      have hchord : dist (ringPt P θ) (ringPt P θE) = 2 * Real.sin (σ * (θ - θE) / 2) := by
        rw [dist_eq_norm, ringPt, ringPt, add_sub_add_left_eq_sub, norm_e_sub_e_eq]
        have hnn : 0 ≤ Real.sin (σ * (θ - θE) / 2) :=
          Real.sin_nonneg_of_nonneg_of_le_pi (by linarith [hv.1]) (by linarith [hv.2])
        rcases hσ with rfl | rfl
        · rw [one_mul] at hnn ⊢; rw [abs_of_nonneg hnn]
        · rw [show -1 * (θ - θE) / 2 = -((θ - θE) / 2) by ring, Real.sin_neg] at hnn ⊢
          rw [abs_of_nonpos (by linarith)]
      have hsin : Real.sin (u / 2) = Real.sin (σ * (θ - θE) / 2) := by linarith
      have huv := Real.injOn_sin ⟨by linarith, by linarith⟩ ⟨by linarith [hv.1], by linarith [hv.2]⟩ hsin
      have hσu : σ * u = θ - θE := by
        have : u = σ * (θ - θE) := by linarith
        rw [this, ← mul_assoc, hσ2, one_mul]
      rw [hσu]; ring_nf
    · exact ⟨⟨Or.inr (Or.inl ⟨s, ⟨hs.1.le, hs.2.le.trans hrd⟩, rfl⟩), by rw [mem_ball, hdistb hs.1]; exact hs.2⟩, hneb hs.1⟩

/-- **The horn count at an end of a collar bend is kept** (plan § 4, the end case; either bend, either end): `M`'s `Γ` is `F`'s with the
open arc cut out, the lens arc from the end `r(θ_E)` (the germ arc of curvature `σ/R` along the arc's direction) and a closed set off
the end; `F.Γ` meets the collar only on the arc. Near the end `Γ_M` is `Γ_F` with the arc's branch (curvature `σ`) replaced by the lens
arc's (curvature `σ/R`), and a branch of a curvature between lies in the collar off `ω(P)` — `hasHornCount_iff_of_germ_swap`. -/
theorem hasHornCount_iff_collar_end {M : ArcMap k} {P : ℂ} {θ₁ θ₂ θE σ R' R R'' dE : ℝ} {L' : Set ℂ}
    (hσE : (σ = 1 ∧ θE = θ₁) ∨ (σ = -1 ∧ θE = θ₂)) (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3)
    (hR' : 1 / 2 < R') (hR'R : R' < R) (hR'1 : R' < 1) (hRR'' : R < R'') (h1R'' : 1 < R'')
    (hdom : M.dom = F.dom) (hring : ringArc P θ₁ θ₂ ⊆ F.Γ) (hfree : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂)
    (hdE : 0 < dE) (hdE2 : dE ≤ 2 * R) (hL' : IsClosed L') (hxL' : ringPt P θE ∉ L')
    (hΓ : M.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪
      ((germArc (ringPt P θE) (θE + σ * (π / 2)) (σ / R) dE).carrier ∪ L')) (j : ℕ) :
    M.HasHornCount (ringPt P θE) j ↔ F.HasHornCount (ringPt P θE) j := by
  have hσ : σ = 1 ∨ σ = -1 := hσE.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1)
  have hσabs : |σ| = 1 := by rcases hσ with rfl | rfl <;> simp
  have hR0 : 0 < R := by linarith
  have hθE : θE ∈ Icc θ₁ θ₂ := by
    rcases hσE with ⟨-, rfl⟩ | ⟨-, rfl⟩
    · exact ⟨le_rfl, h12.le⟩
    · exact ⟨h12.le, le_rfl⟩
  obtain ⟨δ', hδ', hballL⟩ := Metric.isOpen_iff.mp hL'.isOpen_compl _ hxL'
  obtain ⟨r, hr, hr2, hrb, hunit, hpolar⟩ := exists_collar_end_radius P θE hσ h12 hℓ hR' hR'1 h1R'' (lt_min hdE hδ')
  refine hasHornCount_iff_of_germ_swap (F := F) (M := M) (β₀ := θE + σ * (π / 2)) (κ₀ := σ) (κ₀' := σ / R) (r := r)
    (hring ⟨θE, hθE, rfl⟩).1 hdom hr ?_ ?_ ?_ ?_ j
  · rw [abs_div, hσabs, abs_of_pos hR0, div_mul_eq_mul_div, one_mul, div_lt_iff₀ hR0]; nlinarith
  · rintro _ ⟨s, hs, rfl⟩
    obtain ⟨u, hu0, hu1, h1, -⟩ := hunit s hs
    rw [h1]
    refine hring ⟨_, ?_, rfl⟩
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> constructor <;> linarith
  · exact collar_end_Γ hσE hR0 hdE hdE2 (hrb.trans (min_le_left _ _))
      ((ball_subset_ball (hrb.trans (min_le_right _ _))).trans hballL) hunit hℓ hΓ
  · intro κ hκ1 hκ2 hκne s hs
    exact branch_between_notMem_Γ hσE hℓ hR' hR'R hR'1 hRR'' h1R'' hfree hκ1 hκ2 hκne fun ρ hρ => hpolar ρ hρ s hs

/-- **The horn clause of a collar bend, either way** (plan § 4): `M` agrees with `F` off the closed collar, whose `Γ` is the arc; `M`'s
`Γ` is `F`'s with the open arc cut out and the two lens arcs (germ arcs of curvature `±1/R`, `R ≠ 1`, from the ends). Then no horn count
rises: off the collar the maps agree near the point (`hasHornCount_iff_of_agree`); in the collar and not an end the point is interior
in `M` or on the lens arcs, which lie on two circles that cross (`hasHornCount_zero_of_two_spheres`); at an end the count is kept
(`hasHornCount_iff_collar_end`). -/
theorem hornCount_le_of_collarBend {M : ArcMap k} {P : ℂ} {θ₁ θ₂ R' R R'' dA dB : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3)
    (hR' : 1 / 2 < R') (hR'R : R' < R) (hR'1 : R' < 1) (hRR'' : R < R'') (h1R'' : 1 < R'') (hR1 : R ≠ 1)
    (hdom : M.dom = F.dom) (hKdom : collarK P θ₁ θ₂ R' R'' ⊆ F.dom) (hKcl : IsClosed (collarK P θ₁ θ₂ R' R''))
    (hring : ringArc P θ₁ θ₂ ⊆ F.Γ) (hfree : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂)
    (hag : ∀ z ∉ collarK P θ₁ θ₂ R' R'', (z ∈ M.interiorPts ↔ z ∈ F.interiorPts))
    (hdA : 0 < dA) (hdA2 : dA ≤ 2 * R) (hdB : 0 < dB) (hdB2 : dB ≤ 2 * R)
    (hΓ : M.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ ((germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier ∪
      (germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB).carrier))
    {x : ℂ} {j : ℕ} (hj : F.HasHornCount x j) : ∃ j' ≤ j, M.HasHornCount x j' := by
  have hπ := Real.pi_pos
  have hR0 : 0 < R := by linarith
  have hA : germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA = germArc (ringPt P θ₁) (θ₁ + 1 * (π / 2)) (1 / R) dA := by rw [one_mul]
  have hB : germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB = germArc (ringPt P θ₂) (θ₂ + -1 * (π / 2)) (-1 / R) dB := by
    rw [show θ₂ + -1 * (π / 2) = θ₂ - π / 2 by ring, neg_div]
  have hκA : |(1 : ℝ) / R| * dA ≤ 2 := by rw [abs_of_pos (by positivity), div_mul_eq_mul_div, one_mul, div_le_iff₀ hR0]; linarith
  have hκB : |(-1 : ℝ) / R| * dB ≤ 2 := by
    rw [abs_div, abs_neg, abs_one, abs_of_pos hR0, div_mul_eq_mul_div, one_mul, div_le_iff₀ hR0]; linarith
  have hcarA : ∀ z ∈ (germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier, dist z (P + ((1 - R : ℝ) : ℂ) * e θ₁) = R := by
    intro z hz
    rw [hA, carrier_germArc _ _ hdA.le hκA] at hz
    obtain ⟨s, hs, rfl⟩ := hz
    exact dist_branchPt_end P θ₁ (Or.inl rfl) hR0 hs.1 (hs.2.trans hdA2)
  have hcarB : ∀ z ∈ (germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB).carrier, dist z (P + ((1 - R : ℝ) : ℂ) * e θ₂) = R := by
    intro z hz
    rw [hB, carrier_germArc _ _ hdB.le hκB] at hz
    obtain ⟨s, hs, rfl⟩ := hz
    exact dist_branchPt_end P θ₂ (Or.inr rfl) hR0 hs.1 (hs.2.trans hdB2)
  have hene : e θ₁ ≠ e θ₂ := by
    intro h
    have h1 := norm_e_sub_e_eq θ₂ θ₁
    rw [h, sub_self, norm_zero] at h1
    have h2 : 0 < Real.sin ((θ₂ - θ₁) / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
    rw [abs_of_pos h2] at h1
    linarith
  have hne12 : ringPt P θ₁ ≠ ringPt P θ₂ := fun h => hene (add_left_cancel h)
  by_cases hxK : x ∈ collarK P θ₁ θ₂ R' R''
  · by_cases hend : x = ringPt P θ₁ ∨ x = ringPt P θ₂
    · rcases hend with rfl | rfl
      · refine ⟨j, le_rfl, (hasHornCount_iff_collar_end (L' := (germArc (ringPt P θ₂) (θ₂ - π / 2) (-(1 / R)) dB).carrier)
          (Or.inl ⟨rfl, rfl⟩) h12 hℓ hR' hR'R hR'1 hRR'' h1R'' hdom hring hfree hdA hdA2 (Arc.isClosed_carrier _) ?_ ?_ j).mpr hj⟩
        · exact fun h => hne12 (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ₁) (hcarB _ h))
        · rw [hΓ, hA]
      · refine ⟨j, le_rfl, (hasHornCount_iff_collar_end (L' := (germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier)
          (Or.inr ⟨rfl, rfl⟩) h12 hℓ hR' hR'R hR'1 hRR'' h1R'' hdom hring hfree hdB hdB2 (Arc.isClosed_carrier _) ?_ ?_ j).mpr hj⟩
        · exact fun h => hne12 (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ₂) (hcarA _ h)).symm
        · rw [hΓ, hB, union_comm (germArc (ringPt P θ₁) (θ₁ + π / 2) (1 / R) dA).carrier]
    · refine ⟨0, Nat.zero_le _, ?_⟩
      have hxd : x ∈ F.dom := hKdom hxK
      by_cases hxI : x ∈ M.interiorPts
      · exact hasHornCount_zero_of_mem_interiorPts hxI
      · have hxM : x ∈ M.Γ := ⟨hdom ▸ hxd, by_contra fun h => hxI ⟨hdom ▸ hxd, h⟩⟩
        have hxF : x ∉ F.Γ := by
          intro hxF
          obtain ⟨θ, hθ, rfl⟩ := hfree ⟨hxF, hxK⟩
          rw [hΓ] at hxM
          rcases hxM with ⟨-, hO⟩ | hA' | hB'
          · have hθ' : θ ∉ Ioo θ₁ θ₂ := fun h => hO ⟨θ, h, rfl⟩
            rcases eq_or_lt_of_le hθ.1 with h1 | h1
            · exact hend (Or.inl (by rw [h1]))
            · exact hend (Or.inr (by rw [le_antisymm hθ.2 (not_lt.mp fun h2 => hθ' ⟨h1, h2⟩)]))
          · exact hend (Or.inl (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ) (hcarA _ hA')))
          · exact hend (Or.inr (eq_ringPt_of_mem_tangentCircle hR1 (dist_ringPt P θ) (hcarB _ hB')))
        have hxFI : x ∈ F.interiorPts := ⟨hxd, fun h => hxF ⟨hxd, h⟩⟩
        obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts x hxFI
        have hqne : P + ((1 - R : ℝ) : ℂ) * e θ₁ ≠ P + ((1 - R : ℝ) : ℂ) * e θ₂ := by
          intro h
          have h1 : ((1 - R : ℝ) : ℂ) ≠ 0 := by
            rw [Ne, Complex.ofReal_eq_zero]; exact fun h => hR1 (by linarith)
          exact hene (mul_left_cancel₀ h1 (add_left_cancel h))
        have hqlt : dist (P + ((1 - R : ℝ) : ℂ) * e θ₁) (P + ((1 - R : ℝ) : ℂ) * e θ₂) < 2 * R := by
          rw [dist_eq_norm, show P + ((1 - R : ℝ) : ℂ) * e θ₁ - (P + ((1 - R : ℝ) : ℂ) * e θ₂) =
            ((1 - R : ℝ) : ℂ) * (e θ₁ - e θ₂) by ring, norm_mul, Complex.norm_real, Real.norm_eq_abs]
          have h1 := norm_e_sub_e_le θ₁ θ₂
          rw [abs_of_neg (by linarith)] at h1
          have h2 : |1 - R| < R := abs_lt.mpr ⟨by linarith, by linarith⟩
          have h3 := abs_nonneg (1 - R)
          have hπ4 := Real.pi_lt_four
          nlinarith [norm_nonneg (e θ₁ - e θ₂)]
        refine hasHornCount_zero_of_two_spheres (F := M) (q := P + ((1 - R : ℝ) : ℂ) * e θ₁)
          (q' := P + ((1 - R : ℝ) : ℂ) * e θ₂) (ρ := R) (ρ' := R) (hdom ▸ hxd) hr ?_ ?_
        · rintro z ⟨hzM, hzb⟩
          rw [hΓ] at hzM
          rcases hzM with ⟨hzF, -⟩ | hA' | hB'
          · exact absurd hzF.2 (hball hzb).2
          · exact Or.inl (mem_sphere.mpr (hcarA z hA'))
          · exact Or.inr (mem_sphere.mpr (hcarB z hB'))
        · intro h1 h2
          exact Or.inr (im_ne_zero_of_two_spheres (mem_sphere.mp h1) (mem_sphere.mp h2) hqne hqlt)
  · obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hKcl.isOpen_compl x hxK
    exact ⟨j, le_rfl, (hasHornCount_iff_of_agree hr (fun y hy => hag y (hball hy)) j).mpr hj⟩

section Gap

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **The height of a thin outward lens**: `tangRad (1 + τ/2) u − 1 ≤ τ u` on `[0, π/3]` (`tangRad_sub_one_le`). -/
theorem tangRad_sub_one_le_mul {τ u : ℝ} (hτ : 0 ≤ τ) (hu0 : 0 ≤ u) (hu1 : u ≤ π / 3) : tangRad (1 + τ / 2) u - 1 ≤ τ * u := by
  have hπ4 := Real.pi_lt_four
  have h1 := tangRad_sub_one_le (show (1 : ℝ) ≤ 1 + τ / 2 by linarith) u
  nlinarith [mul_nonneg (mul_nonneg hτ hu0) (show (0 : ℝ) ≤ 2 - u by linarith)]

/-- A point within `1/2` of the radius-2 point has its radial frame coordinate above `−2`. -/
theorem neg_two_lt_r2Y {P y : ℂ} {θE η : ℝ} (hη : η ≤ 1 / 2) (hd : dist y (P + 2 * e θE) < η) : -2 < r2Y P θE y := by
  have hN := r2_dist_sq_base P θE y
  have hd0 := dist_nonneg (x := y) (y := P + 2 * e θE)
  have h1 : dist y (P + 2 * e θE) ^ 2 < 1 := by nlinarith
  nlinarith [sq_nonneg (r2X P θE y), sq_nonneg (r2Y P θE y + 2)]

/-- **The lens against a far point near an end of the gap** (the end case of `exists_lensOut_clear`, at either end): a lens point
`P + t e(φ)` strictly under the end's circle of radius `1 + τ/2` is farther than `1` from a far point `y` within `η` of the end's
radius-2 point, given the cap there (`r2_side_dichotomy`'s "none" case) with `τ < 2(ρ₀ − 2)`. -/
theorem lens_far_end {P y : ℂ} {a b θE σ η τ ρ₀ φ t : ℝ} (hσE : (σ = 1 ∧ θE = a) ∨ (σ = -1 ∧ θE = b)) (hab : a < b)
    (hℓ : b - a ≤ π / 3) (hτ : 0 < τ) (hτρ : τ < 2 * (ρ₀ - 2)) (hφ : φ ∈ Ioo a b) (ht1 : 1 < t)
    (htE : t < tangRad (1 + τ / 2) (φ - θE)) (hfar : ∀ θ ∈ Icc a b, 1 ≤ dist y (ringPt P θ)) (hη : η ≤ 1 / 2)
    (hη' : η ≤ Real.sin (b - a)) (hd : dist y (P + 2 * e θE) < η)
    (hcap : 0 < σ * r2X P θE y → 2 ≤ dist y P → ρ₀ ≤ dist y (P + ((2 - ρ₀ : ℝ) : ℂ) * e θE)) :
    1 < dist y (P + (t : ℂ) * e φ) := by
  have hπ := Real.pi_pos
  have ht0 : 0 < t := by linarith
  have hσ : σ = 1 ∨ σ = -1 := hσE.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1)
  have hθE : θE ∈ Icc a b := by
    rcases hσE with ⟨-, rfl⟩ | ⟨-, rfl⟩
    · exact ⟨le_rfl, hab.le⟩
    · exact ⟨hab.le, le_rfl⟩
  refine lens_end_far (θE := θE) (σ := σ) (R := 1 + τ / 2) (ρ₀ := ρ₀) hσ (by linarith) (by linarith) ?_ ?_ ?_
    (hfar θE hθE) (neg_two_lt_r2Y hη hd) fun hs' => hcap hs' (two_le_dist_of_far hσE hab hℓ hfar hη hη' hd hs')
  · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht0.le]
    exact ht1.le
  · have := dist_lt_of_lt_tangRad (show (1 : ℝ) / 2 < 1 + τ / 2 by linarith) P θE (φ - θE) ht0 htE
    rwa [show θE + (φ - θE) = φ by ring] at this
  · rw [r2X_polar]
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · rw [one_mul]
      exact mul_nonneg ht0.le (Real.sin_nonneg_of_nonneg_of_le_pi (by linarith [hφ.1]) (by linarith [hφ.2]))
    · have := Real.sin_nonpos_of_nonpos_of_neg_pi_le (show φ - θE ≤ 0 by linarith [hφ.2]) (by linarith [hφ.1])
      rw [neg_one_mul, ← mul_neg]
      exact mul_nonneg ht0.le (neg_nonneg.mpr this)

/-- **The cap at an end of a gap** (`r2_side_dichotomy` on the gap's side of the end; its "all" case contradicts `hgap`). -/
theorem exists_gap_cap (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) {θE σ : ℝ}
    (hσE : (σ = 1 ∧ θE = θ₁) ∨ (σ = -1 ∧ θE = θ₂)) (hw : P + 2 * e θE ∈ F.dom) :
    ∃ η > 0, ∃ ρ₀ > 2, ∀ y ∈ F.region c, dist y (P + 2 * e θE) < η → 0 < σ * r2X P θE y → 2 ≤ dist y P →
      ρ₀ ≤ dist y (P + ((2 - ρ₀ : ℝ) : ℂ) * e θE) := by
  have h12 := hA.1
  have hσ : σ = 1 ∨ σ = -1 := hσE.elim (fun h => Or.inl h.1) (fun h => Or.inr h.1)
  have hθE : θE ∈ Icc θ₁ θ₂ := by
    rcases hσE with ⟨-, rfl⟩ | ⟨-, rfl⟩
    · exact ⟨le_rfl, h12.le⟩
    · exact ⟨h12.le, le_rfl⟩
  have hside : θE + σ * (θ₂ - θ₁) ∈ Icc θ₁ θ₂ := by
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · exact ⟨by linarith, by linarith⟩
    · exact ⟨by linarith, by linarith⟩
  obtain ⟨δ, hδ, η, hη, ρ₀, hρ₀, h⟩ := r2_side_dichotomy hF hA (δ₀ := θ₂ - θ₁) hσ hθE (by linarith) hside hw
  refine ⟨η, hη, ρ₀, hρ₀, ?_⟩
  rcases h with h | ⟨-, h⟩
  · exfalso
    have hm := lt_min hδ (show 0 < θ₂ - θ₁ by linarith)
    have hml := min_le_left δ (θ₂ - θ₁)
    have hmr := min_le_right δ (θ₂ - θ₁)
    refine hgap (θE + σ * (min δ (θ₂ - θ₁) / 2)) ?_ (h _ ⟨by linarith, by linarith⟩)
    rcases hσE with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · exact ⟨by linarith, by linarith⟩
    · exact ⟨by linarith, by linarith⟩
  · intro y hy hyd hys hy2
    exact h y hy hyd (by rw [← r2X_eq]; exact hys) hy2

/-- **The middle of the radius-2 arc over a gap is a positive distance from the inner colour's class** (compact against closed). -/
theorem exists_gap_middle_far (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) {η : ℝ} (hη : 0 < η) :
    ∃ d₀ > 0, ∀ θ ∈ Icc (θ₁ + η / 4) (θ₂ - η / 4), ∀ y ∈ F.region c, d₀ ≤ dist y (P + 2 * e θ) := by
  have hK : IsCompact ((fun θ : ℝ => P + 2 * e θ) '' Icc (θ₁ + η / 4) (θ₂ - η / 4)) :=
    isCompact_Icc.image (continuous_const.add (continuous_const.mul continuous_e))
  have hdisj : Disjoint ((fun θ : ℝ => P + 2 * e θ) '' Icc (θ₁ + η / 4) (θ₂ - η / 4)) (closure (F.region c)) := by
    rw [Set.disjoint_left]
    rintro _ ⟨θ, hθ, rfl⟩ hcl
    exact hgap θ ⟨by linarith [hθ.1], by linarith [hθ.2]⟩ hcl
  obtain ⟨d, hd, hdd⟩ := hdisj.exists_thickenings hK isClosed_closure
  refine ⟨d, hd, fun θ hθ y hy => ?_⟩
  by_contra hlt
  push Not at hlt
  exact Set.disjoint_left.mp hdd (Metric.mem_thickening_iff.mpr ⟨_, ⟨θ, hθ, rfl⟩, hlt⟩)
    (Metric.self_subset_thickening hd _ (subset_closure hy))

/-- **A thin outward lens over a gap is clear for the inner colour** (the mirror of `exists_lens_clear`, with the tangent ends): for
`R = 1 + τ/2` close to `1`. Route (plan § 2.5): a point of the class at distance `1` from a lens point is near or far (`n2_sign`);
near, it is within `< 1` (`n2_env_near_away`, the class off a disc about `P` by `hin`); far, it is within `r` of the radius-2 arc
(`n2_env_away`), so — the arc off small discs about its ends being compact and off the class's closure (`hgap`) — within `η` of an
end, where it is beyond the end (`claim_e`) or on the gap's side at distance `≥ 2` from `P` and off the cap (`r2_side_dichotomy`'s
"none" case, forced by `hgap`), hence farther than `1` (`end_cap`, once `R ≤ ρ₀ − 1`). **Proved (FS131-BA2)** (child C4, the new
mathematics of the bend). Inhabitant of the hypotheses: owed with the away bend's model (plan § 5). -/
theorem exists_lensOut_clear (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom) (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) :
    ∀ᶠ τ in 𝓝[>] (0 : ℝ), ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo 1 (outerProf θ₁ θ₂ (1 + τ / 2) θ)), F.IsClear c z := by
  have h12 := hA.1
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  obtain ⟨rP, hrP0, hrP⟩ : ∃ r > 0, ∀ y ∈ F.region c, r ≤ dist y P := by
    have hP : P ∉ closure (F.region c) := hin
    rw [Metric.mem_closure_iff] at hP
    push Not at hP
    obtain ⟨r, hr0, hr⟩ := hP
    exact ⟨r, hr0, fun y hy => by rw [dist_comm]; exact hr y hy⟩
  -- the caps at the two ends, the size of the two end zones, the middle
  obtain ⟨ηa, hηa, ρa, hρa, hcapa⟩ := exists_gap_cap hF hA hgap (Or.inl ⟨rfl, rfl⟩) (hdom ⟨θ₁, left_mem_Icc.mpr h12.le, rfl⟩)
  obtain ⟨ηb, hηb, ρb, hρb, hcapb⟩ := exists_gap_cap hF hA hgap (Or.inr ⟨rfl, rfl⟩) (hdom ⟨θ₂, right_mem_Icc.mpr h12.le, rfl⟩)
  obtain ⟨η, hη, hηa', hηb', hη2, hηs⟩ : ∃ η > 0, η ≤ ηa ∧ η ≤ ηb ∧ η ≤ 1 / 2 ∧ η ≤ Real.sin (θ₂ - θ₁) := by
    have hs : 0 < Real.sin (θ₂ - θ₁) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
    exact ⟨min (min ηa ηb) (min (1 / 2) (Real.sin (θ₂ - θ₁))), lt_min (lt_min hηa hηb) (lt_min (by norm_num) hs),
      (min_le_left _ _).trans (min_le_left _ _), (min_le_left _ _).trans (min_le_right _ _),
      (min_le_right _ _).trans (min_le_left _ _), (min_le_right _ _).trans (min_le_right _ _)⟩
  obtain ⟨d₀, hd₀, hmid⟩ := exists_gap_middle_far hgap hη
  obtain ⟨ψ₁, hψ₁, henv⟩ := n2_env_away P h12 hℓ (show 0 < min d₀ (η / 2) from lt_min hd₀ (by linarith))
  obtain ⟨ψ₂, hψ₂, hnear⟩ := n2_env_near_away P h12 hℓ hrP0
  have hbound : 0 < min (min ψ₁ ψ₂) (min (2 * (ρa - 2)) (2 * (ρb - 2))) :=
    lt_min (lt_min hψ₁ hψ₂) (lt_min (by linarith) (by linarith))
  refine Filter.eventually_of_mem (Ioo_mem_nhdsGT hbound) ?_
  rintro τ ⟨hτ0, hτ⟩ z ⟨φ, hφ, t, ht, rfl⟩ y hy hzy
  have hτψ₁ : τ < ψ₁ := lt_of_lt_of_le hτ ((min_le_left _ _).trans (min_le_left _ _))
  have hτψ₂ : τ < ψ₂ := lt_of_lt_of_le hτ ((min_le_left _ _).trans (min_le_right _ _))
  have hτa : τ < 2 * (ρa - 2) := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_left _ _))
  have hτb : τ < 2 * (ρb - 2) := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_right _ _))
  have hcl : clampAngle θ₁ θ₂ φ = φ := by unfold clampAngle; rw [min_eq_left hφ.2.le, max_eq_right hφ.1.le]
  have ht' : t < min (tangRad (1 + τ / 2) (φ - θ₁)) (tangRad (1 + τ / 2) (θ₂ - φ)) := by
    have := ht.2; unfold outerProf at this; rwa [hcl] at this
  have ht1 : t < tangRad (1 + τ / 2) (φ - θ₁) := ht'.trans_le (min_le_left _ _)
  have ht2 : t < tangRad (1 + τ / 2) (φ - θ₂) := by
    rw [show φ - θ₂ = -(θ₂ - φ) by ring, tangRad_neg]; exact ht'.trans_le (min_le_right _ _)
  -- the lens point lies under both envelope profiles
  have hm0 : 0 ≤ min (φ - θ₁) (θ₂ - φ) := le_min (by linarith [hφ.1]) (by linarith [hφ.2])
  have hs : t - 1 ≤ τ * min (φ - θ₁) (θ₂ - φ) := by
    rw [mul_min_of_nonneg _ _ hτ0.le]
    have h1 := tangRad_sub_one_le_mul hτ0.le (show 0 ≤ φ - θ₁ by linarith [hφ.1]) (by linarith [hφ.2])
    have h2 := tangRad_sub_one_le_mul hτ0.le (show 0 ≤ θ₂ - φ by linarith [hφ.2]) (by linarith [hφ.1])
    have h3 := ht'.trans_le (min_le_left _ _)
    have h4 := ht'.trans_le (min_le_right _ _)
    exact le_min (by linarith) (by linarith)
  have hzform : P + (1 + ((t - 1 : ℝ) : ℂ)) * e φ = P + (t : ℂ) * e φ := by push_cast; ring
  have hcont : Continuous fun θ : ℝ => dist y (ringPt P θ) := by unfold ringPt e; fun_prop
  have hzy' : dist y (P + (t : ℂ) * e φ) = 1 := by rw [dist_comm]; exact hzy
  by_cases hU : y ∈ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1
  · -- a near point of the class is closer than `1` (as in `away_clear`)
    obtain ⟨θ₀, hθ₀, hy0⟩ := mem_iUnion₂.mp hU
    rw [mem_ball] at hy0
    rcases n2_sign hF hA (Or.inl rfl) hy with hlt | hgt
    · have hle := le_on_Icc_of_Ioo hcont h12 fun θ hθ => (hlt θ hθ).le
      have hyP : y ∉ ball P rP := fun h' => by rw [mem_ball] at h'; linarith [hrP y hy]
      have := hnear φ hφ (t - 1) (by linarith [ht.1]) (hs.trans (mul_le_mul_of_nonneg_right hτψ₂.le hm0)) y
        ⟨⟨mem_closedBall.mpr (hle θ₁ ⟨le_rfl, h12.le⟩), mem_closedBall.mpr (hle θ₂ ⟨h12.le, le_rfl⟩)⟩, hyP⟩
      rw [hzform] at this
      linarith
    · have hge := ge_on_Icc_of_Ioo hcont h12 fun θ hθ => (hgt θ hθ).le
      linarith [hge θ₀ hθ₀]
  · -- a far point is within `min d₀ (η/2)` of the radius-2 arc, so near one of its ends
    have hfar : ∀ θ ∈ Icc θ₁ θ₂, 1 ≤ dist y (ringPt P θ) := by
      intro θ hθ
      by_contra hlt
      push Not at hlt
      exact hU (mem_iUnion₂.mpr ⟨θ, hθ, mem_ball.mpr hlt⟩)
    have hyb : y ∈ closedBall (P + (1 + ((t - 1 : ℝ) : ℂ)) * e φ) 1 := by
      rw [hzform, mem_closedBall]; exact hzy'.le
    have hth := henv φ hφ (t - 1) (by linarith [ht.1]) (hs.trans (mul_le_mul_of_nonneg_right hτψ₁.le hm0)) ⟨hyb, hU⟩
    obtain ⟨_, ⟨θ, hθ, rfl⟩, hyθ⟩ := Metric.mem_thickening_iff.mp hth
    have hyθ1 := hyθ.trans_le (min_le_left _ _)
    have hyθ2 := hyθ.trans_le (min_le_right _ _)
    have h2e : ∀ θ' : ℝ, dist (P + 2 * e θ) (P + 2 * e θ') ≤ 2 * |θ - θ'| := by
      intro θ'
      rw [dist_eq_norm, show P + 2 * e θ - (P + 2 * e θ') = 2 * (e θ - e θ') by ring, norm_mul]
      have := norm_e_sub_e_le θ θ'
      have h2 : ‖(2 : ℂ)‖ = 2 := by simp
      rw [h2]; linarith
    rcases lt_or_ge θ (θ₁ + η / 4) with hθa | hθa
    · -- near the end `θ₁`
      have hyw : dist y (P + 2 * e θ₁) < η := by
        have h3 := dist_triangle y (P + 2 * e θ) (P + 2 * e θ₁)
        have h4 := h2e θ₁
        rw [abs_of_nonneg (by linarith [hθ.1])] at h4
        linarith
      have hgt := lens_far_end (P := P) (Or.inl ⟨rfl, rfl⟩) h12 hℓ hτ0 hτa hφ ht.1 ht1 hfar hη2 hηs hyw
        (hcapa y hy (hyw.trans_le hηa'))
      linarith
    · rcases lt_or_ge (θ₂ - η / 4) θ with hθb | hθb
      · -- near the end `θ₂` (the mirror)
        have hyw : dist y (P + 2 * e θ₂) < η := by
          have h3 := dist_triangle y (P + 2 * e θ) (P + 2 * e θ₂)
          have h4 := h2e θ₂
          rw [abs_of_nonpos (by linarith [hθ.2])] at h4
          linarith
        have hgt := lens_far_end (P := P) (Or.inr ⟨rfl, rfl⟩) h12 hℓ hτ0 hτb hφ ht.1 ht2 hfar hη2 hηs hyw
          (hcapb y hy (hyw.trans_le hηb'))
        linarith
      · have := hmid θ ⟨hθa, hθb⟩ y hy
        linarith

/-- **The outward collar exists** over a gap (mirror of `exists_collarFit`): radii `R' = 1 − τ`, `R = 1 + τ/2`, `R'' = 1 + τ`, each
clause for all small `τ` — `clear` by `exists_lensOut_clear`; thin and in the domain by `collarK_thin`; `Γ`-free off the arc by
`exists_collar_free`, **as it stands** (the collar is the toward bend's). **Proved (FS131-BA2)** (child C5; short once C4 is in). -/
theorem exists_collarFitOut (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1)
    (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) (hε : 0 < ε) :
    ∃ R' R R'', CollarFitOut F P θ₁ θ₂ c c' ε R' R R'' := by
  have h12 := hA.1
  have hℓ := l60_le hF hA
  obtain ⟨δ, hδ, hδdom⟩ := (isCompact_Icc.image (by unfold ringPt e; fun_prop) :
    IsCompact (ringArc P θ₁ θ₂)).exists_thickening_subset_open F.isOpen_dom (fun y hy => (hA.2.1 hy).1)
  have hpos : (0 : ℝ) < min (1 / 4) (min (ε / 2) (δ / 2)) := lt_min (by norm_num) (lt_min (by linarith) (by linarith))
  obtain ⟨τ, ⟨hclear, hfr⟩, hτ0, hτ⟩ :=
    (((exists_lensOut_clear hF hA hin hdom hgap).and (exists_collar_free hF hA hfree)).and (Ioo_mem_nhdsGT hpos)).exists
  have hτ4 : τ < 1 / 4 := lt_of_lt_of_le hτ (min_le_left _ _)
  have hτε : τ < ε / 2 := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_left _ _))
  have hτδ : τ < δ / 2 := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_right _ _))
  have hthin : ∀ η, 2 * τ < η → collarK P θ₁ θ₂ (1 - τ) (1 + τ) ⊆ thickening η (ringArc P θ₁ θ₂) := by
    intro η hη z hz
    obtain ⟨ψ, hψ, t, -, hzt, ht⟩ := collarK_thin hτ0 hτ4.le hℓ hz
    exact mem_thickening_ringArc_of_polar hψ hzt (lt_of_le_of_lt ht hη)
  exact ⟨1 - τ, 1 + τ / 2, 1 + τ, ⟨hA, hℓ, ⟨by linarith, by linarith, by linarith, by linarith, by linarith⟩, hfree,
    hthin ε (by linarith), (hthin δ (by linarith)).trans hδdom, hfr, hclear⟩⟩

/-! ### The outward collar's access lemmas that `CollarMapOut` does not hold (the others are FS131-BA1's there: `PushOutProfiles.cases`,
`CollarFitOut.lensOutCurve_subset`, `.homeo_eq_self`, `.homeo_fix_Γ`; merged under inventory ruling 452 (b)) -/

/-- The outward lens lies in the collar. -/
theorem CollarFitOut.lensOutSet_subset_collar (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    lensOutSet P θ₁ θ₂ R ⊆ collarK P θ₁ θ₂ R' R'' := by
  refine polarSet_mono Ioo_subset_Icc_self fun θ hθ => ?_
  rintro t ⟨ht1, ht2⟩
  obtain ⟨-, h1, h2, h3⟩ := hfit.pushOutProfiles.inside θ hθ
  exact ⟨by linarith, by linarith⟩

/-- The closed arc lies in the collar. -/
theorem CollarFitOut.ringArc_subset_collar (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    ringArc P θ₁ θ₂ ⊆ collarK P θ₁ θ₂ R' R'' := by
  rintro _ ⟨θ, hθ, rfl⟩
  refine ⟨θ, hθ, 1, ?_, by simp [ringPt]⟩
  show (1 : ℝ) ∈ Icc (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ)
  rcases hfit.pushOutProfiles.cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
  · exact ⟨h1.le, by linarith⟩
  · rw [h1, h3]; exact ⟨le_rfl, le_rfl⟩

/-- The collar is closed. -/
theorem CollarFitOut.collar_isClosed (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : IsClosed (collarK P θ₁ θ₂ R' R'') := by
  have hp := hfit.pushOutProfiles
  refine (isCompact_polarSet_Icc P hp.cont_a hp.cont_b fun θ _ => ?_).isClosed
  rcases hfit.pushOutProfiles.cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
  · linarith
  · rw [h1, h3]

/-- The collar meets `ω(P)` only on the closed arc. -/
theorem CollarFitOut.collar_inter_sphere (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    collarK P θ₁ θ₂ R' R'' ∩ sphere P 1 ⊆ ringArc P θ₁ θ₂ := by
  rintro _ ⟨⟨θ, hθ, t, ht', rfl⟩, hs⟩
  have ht : t ∈ Icc (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ) := ht'
  have ht0 : 0 < t := by
    rcases hfit.pushOutProfiles.cases θ with ⟨-, h0, -, -, -⟩ | ⟨-, h1, -, -⟩
    · exact h0.trans_le ht.1
    · rw [h1] at ht; linarith [ht.1]
  rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht0.le] at hs
  exact ⟨θ, hθ, by rw [hs]; simp [ringPt]⟩

/-- The homeomorphism maps the collar into itself. -/
theorem CollarFitOut.homeo_maps_collar (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ}
    (hz : z ∈ collarK P θ₁ θ₂ R' R'') : hfit.homeo z ∈ collarK P θ₁ θ₂ R' R'' := by
  have hp := hfit.pushOutProfiles
  by_cases hO : z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ))
  · obtain ⟨ψ, hψ, t, ht, rfl⟩ := hO
    have hin := hp.inside ψ hψ
    have ht0 : 0 < t := hin.1.trans ht.1
    rw [CollarFitOut.homeo, pushOutHomeo_polar hp hψ ht0]
    have := push1_mem_Ioo (m := 1) (m' := outerProf θ₁ θ₂ R ψ) hin.2.1 (by linarith) (by linarith) hin.2.2.2 ht
    exact ⟨ψ, Ioo_subset_Icc_self hψ, _, Ioo_subset_Icc_self this, rfl⟩
  · rw [CollarFitOut.homeo, (pushOutHomeo_eq_self hp hO).1]
    exact hz

/-- No unit arc is created (mirror of `CollarFit.map_ringArcsWithin`: the lens curve has radius `R ≠ 1`). **Proved (FS131-BA2)** (child C6). -/
theorem CollarFitOut.map_ringArcsWithin (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.RingArcsWithin F := by
  obtain ⟨-, -, hR1, -, -⟩ := hfit.params
  have hR : 0 < R := by linarith
  have hR1' : 1 / R ≠ 1 := fun h => by rw [div_eq_one_iff_eq hR.ne'] at h; linarith
  refine ringArcsWithin_of_Γ_subset (A' := {collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R}) rfl
    (fun a ha => hfit.collarOutArcs_nondegenerate a (Or.inr ha))
    (fun x _ => ⟨univ, univ_mem, (Set.toFinite ({collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R} : Set Arc)).subset
      fun a ha => ha.1⟩) ?_ ?_
  · intro a ha
    rcases ha with rfl | rfl
    · unfold collarOutArcA
      rw [germArc_isUnitArc_iff, abs_of_pos (by positivity)]
      exact hR1'
    · unfold collarOutArcB
      rw [germArc_isUnitArc_iff, abs_neg, abs_of_pos (by positivity)]
      exact hR1'
  · intro z hz
    rw [hfit.map_Γ] at hz
    rcases hz with ⟨hzΓ, -⟩ | hzL
    · exact Or.inl hzΓ
    · right
      rw [← collarOutArcs_carrier hR1 hfit.ring.1 hfit.short] at hzL
      rcases hzL with h | h
      · exact mem_iUnion₂.mpr ⟨_, Or.inl rfl, h⟩
      · exact mem_iUnion₂.mpr ⟨_, Or.inr rfl, h⟩

/-! ### The sides of a unit circle at a point of `Γ` off the open arc (FS131-BA3; mirrors of `CollarFit.exists_one_side`, `sides_end`,
`sides_eq`). Inhabitant of the `CollarFitOut` hypotheses: `exists_collarFitOut`, at any map satisfying `bend_away_gap`'s. -/

/-- **Near an end the collar set lies on one side of every other unit circle** — `CollarFit.exists_one_side` stated for the set
`collarK P θ₁ θ₂ R' R''` alone, which is all its proof reads of a fit (`1/2 < R'`, `1 < R''`, an arc of at most `60°`), so that it
serves the outward collar, the same set: for `Q ≠ P` and an end `x` of the arc there is a radius within which every collar point but
`x` is inside `ω(Q)`, or every one is outside. On `ω(Q)` this is `side_core` in the end's frame (`collarK_frame`); off it, continuity
of the distance. -/
theorem collarK_one_side (hR' : 1 / 2 < R') (hR'' : 1 < R'') (hℓ : θ₂ - θ₁ ≤ π / 3) {Q x : ℂ} (hQ : Q ≠ P)
    (hx : x = ringPt P θ₁ ∨ x = ringPt P θ₂) :
    ∃ ρ > 0, (∀ z ∈ collarK P θ₁ θ₂ R' R'', z ≠ x → dist z x < ρ → dist z Q < 1) ∨
      (∀ z ∈ collarK P θ₁ θ₂ R' R'', z ≠ x → dist z x < ρ → 1 < dist z Q) := by
  rcases lt_trichotomy (dist x Q) 1 with hlt | heq | hgt
  · exact ⟨1 - dist x Q, by linarith, Or.inl fun z _ _ hz => by linarith [dist_triangle z x Q]⟩
  · -- on `ω(Q)`: the frame at the end
    obtain ⟨θE, σ, hσ, rfl, hfr⟩ : ∃ θE σ : ℝ, (σ = 1 ∨ σ = -1) ∧ x = ringPt P θE ∧
        ∀ z ∈ collarK P θ₁ θ₂ R' R'', ∃ X Y : ℝ, z - ringPt P θE = ((Y : ℂ) + (X : ℂ) * I) * e θE ∧ 0 ≤ σ * X ∧
          0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2) ∧ 2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0 := by
      rcases hx with rfl | rfl
      · refine ⟨θ₁, 1, Or.inl rfl, rfl, fun z hz => ?_⟩
        obtain ⟨X, Y, h0, h1, h2, h3⟩ := (collarK_frame hR' hR'' hℓ hz).1
        exact ⟨X, Y, h0, by linarith, h2, h3⟩
      · refine ⟨θ₂, -1, Or.inr rfl, rfl, fun z hz => ?_⟩
        obtain ⟨X, Y, h0, h1, h2, h3⟩ := (collarK_frame hR' hR'' hℓ hz).2
        exact ⟨X, Y, h0, by linarith, h2, h3⟩
    set m : ℂ := ringPt P θE - Q with hm
    set g : ℂ := m * starRingEnd ℂ (e θE) with hg
    have hmn : ‖m‖ = 1 := by rw [hm, ← dist_eq_norm]; exact heq
    have hgn : Complex.normSq g = 1 := by
      rw [hg, Complex.normSq_mul, Complex.normSq_conj, Complex.normSq_eq_norm_sq, Complex.normSq_eq_norm_sq, hmn, norm_e]
      norm_num
    have hαβ : g.re ^ 2 + g.im ^ 2 = 1 := by rw [← hgn, Complex.normSq_apply]; ring
    have hmg : m = g * e θE := by
      rw [hg, mul_assoc, mul_comm (starRingEnd ℂ (e θE)), e_mul_conj_e, mul_one]
    have hne : ¬ (g.re = 1 ∧ g.im = 0) := by
      rintro ⟨h1, h2⟩
      have hg1 : g = 1 := Complex.ext (by simpa using h1) (by simpa using h2)
      apply hQ
      have : ringPt P θE - Q = e θE := by rw [← hm, hmg, hg1, one_mul]
      rw [ringPt] at this
      linear_combination -this
    obtain ⟨ρ, hρ, hcore⟩ := side_core hαβ hne hσ
    -- the distance to `Q` in the frame
    have hdist : ∀ z : ℂ, ∀ X Y : ℝ, z - ringPt P θE = ((Y : ℂ) + (X : ℂ) * I) * e θE →
        dist z Q ^ 2 = X ^ 2 + Y ^ 2 + 2 * (g.re * Y + g.im * X) + 1 ∧ dist z (ringPt P θE) ^ 2 = X ^ 2 + Y ^ 2 := by
      intro z X Y hz
      have hzQ : z - Q = ((Y : ℂ) + (X : ℂ) * I + g) * e θE := by
        rw [add_mul, ← hmg, ← hz, hm]; ring
      have hre : ((Y : ℂ) + (X : ℂ) * I + g).re = Y + g.re := by simp
      have him : ((Y : ℂ) + (X : ℂ) * I + g).im = X + g.im := by simp
      refine ⟨?_, ?_⟩
      · rw [dist_eq_norm, hzQ, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply, hre, him]
        linear_combination hαβ
      · rw [dist_eq_norm, hz, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
        simp
        ring
    have hsmall : ∀ z : ℂ, z ≠ ringPt P θE → dist z (ringPt P θE) < min 1 ρ → ∀ X Y : ℝ,
        dist z (ringPt P θE) ^ 2 = X ^ 2 + Y ^ 2 → 0 < X ^ 2 + Y ^ 2 ∧ X ^ 2 + Y ^ 2 < ρ := by
      intro z hzx hzd X Y hN
      have hd0 : 0 < dist z (ringPt P θE) := dist_pos.mpr hzx
      have hd1 : dist z (ringPt P θE) < 1 := lt_of_lt_of_le hzd (min_le_left _ _)
      have hd2 : dist z (ringPt P θE) < ρ := lt_of_lt_of_le hzd (min_le_right _ _)
      rw [← hN]
      exact ⟨by positivity, by nlinarith⟩
    refine ⟨min 1 ρ, lt_min one_pos hρ, ?_⟩
    rcases hcore with hc | hc
    · refine Or.inr fun z hzK hzx hzd => ?_
      obtain ⟨X, Y, hz, hX, h1, h2⟩ := hfr z hzK
      obtain ⟨hdQ, hdx⟩ := hdist z X Y hz
      obtain ⟨hN0, hNρ⟩ := hsmall z hzx hzd X Y hdx
      have := hc X Y R' R'' hR' hR'' hX h1 h2 hN0 hNρ
      nlinarith [dist_nonneg (x := z) (y := Q)]
    · refine Or.inl fun z hzK hzx hzd => ?_
      obtain ⟨X, Y, hz, hX, h1, h2⟩ := hfr z hzK
      obtain ⟨hdQ, hdx⟩ := hdist z X Y hz
      obtain ⟨hN0, hNρ⟩ := hsmall z hzx hzd X Y hdx
      have := hc X Y R' R'' hR' hR'' hX h1 h2 hN0 hNρ
      nlinarith [dist_nonneg (x := z) (y := Q)]
  · exact ⟨dist x Q - 1, by linarith, Or.inr fun z _ _ hz => by
      have := dist_triangle x z Q
      rw [dist_comm x z] at this
      linarith⟩

/-- Spec: `collarK_one_side` applies at numbers — the collar of radii `3/4`, `5/4` over `[0, π/6]` about `0`, its end `ringPt 0 0`,
and the unit circle about `2`, which touches `ω(0)` there from outside. -/
example : ∃ ρ > 0, (∀ z ∈ collarK (0 : ℂ) 0 (π / 6) (3 / 4) (5 / 4), z ≠ ringPt 0 0 → dist z (ringPt 0 0) < ρ → dist z 2 < 1) ∨
    (∀ z ∈ collarK (0 : ℂ) 0 (π / 6) (3 / 4) (5 / 4), z ≠ ringPt 0 0 → dist z (ringPt 0 0) < ρ → 1 < dist z 2) :=
  collarK_one_side (by norm_num) (by norm_num) (by linarith [Real.pi_pos]) (by norm_num) (Or.inl rfl)

/-- The outward lens profile is at least `1` (above `1` over the open sector, `1` off it). -/
theorem CollarFitOut.one_le_outerProf (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') (θ : ℝ) : 1 ≤ outerProf θ₁ θ₂ R θ := by
  rcases hfit.pushOutProfiles.cases θ with ⟨-, -, -, h, -⟩ | ⟨-, -, h, -⟩
  · exact h.le
  · exact h.ge

/-- **The closed outward lens is closed**: `{P + t e(θ) : θ ∈ [θ₁, θ₂], 1 ≤ t ≤ outerProf θ}` (mirror of
`CollarFit.isClosed_closedLens`; the lens is on the other side of `ω(P)`). -/
theorem CollarFitOut.isClosed_closedLensOut (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    IsClosed (polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ)) :=
  (isCompact_polarSet_Icc P continuous_const hfit.pushOutProfiles.cont_l fun θ _ => hfit.one_le_outerProf θ).isClosed

/-- The outward lens with its boundary lies in the closed outward lens. -/
theorem CollarFitOut.lensOut_subset_closedLensOut (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    lensOutSet P θ₁ θ₂ R ∪ lensOutCurve P θ₁ θ₂ R ⊆ polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ) := by
  rintro z (⟨θ, hθ, t, ht, rfl⟩ | ⟨θ, hθ, t, ht, rfl⟩)
  · exact ⟨θ, Ioo_subset_Icc_self hθ, t, ⟨ht.1, ht.2.le⟩, rfl⟩
  · rw [mem_singleton_iff] at ht
    exact ⟨θ, hθ, t, ⟨ht ▸ hfit.one_le_outerProf θ, ht.le⟩, rfl⟩

/-- **The sides of a unit circle through an end are kept** by the outward bend (mirror of `CollarFit.sides_end`; validity is not
read): near an end the homeomorphism moves points only inside the collar, which lies on one side of `ω(Q)` for `Q ≠ P`
(`collarK_one_side`), so it moves no point across `ω(Q)`, and the closures at the end of each class met with either side are carried
to themselves. No colour is named: the lens's colour — the inner one here, the outer one for the toward bend — plays no part at an
end. -/
theorem CollarFitOut.sides_end (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hQ : Q ≠ P)
    (hx : x = ringPt P θ₁ ∨ x = ringPt P θ₂) :
    hfit.map.innerColours Q x = F.innerColours Q x ∧ hfit.map.outerColours Q x = F.outerColours Q x := by
  have h12 := hfit.ring.1
  obtain ⟨ρ, hρ, hside⟩ :=
    collarK_one_side hfit.params.1 (hfit.params.2.2.1.trans hfit.params.2.2.2.1) hfit.short hQ hx
  -- the end is fixed
  have hfix : hfit.homeo x = x := by
    obtain ⟨ψ, hψ, hψ', rfl⟩ : ∃ ψ, ψ ∈ Icc θ₁ θ₂ ∧ ψ ∉ Ioo θ₁ θ₂ ∧ x = ringPt P ψ := by
      rcases hx with rfl | rfl
      · exact ⟨θ₁, ⟨le_rfl, h12.le⟩, fun h => lt_irrefl _ h.1, rfl⟩
      · exact ⟨θ₂, ⟨h12.le, le_rfl⟩, fun h => lt_irrefl _ h.2, rfl⟩
    exact hfit.homeo_fix_Γ (hfit.ring.2.1 ⟨ψ, hψ, rfl⟩) (ringPt_not_mem_openArc hfit.short hψ hψ')
  -- a ball about the end whose image stays within `ρ` of it
  obtain ⟨δ, hδ, hδb⟩ := Metric.continuousAt_iff.mp hfit.homeo.continuous.continuousAt ρ hρ
  rw [hfix] at hδb
  set ρ' := min δ ρ with hρ'
  have hρ'0 : 0 < ρ' := lt_min hδ hρ
  -- on that ball the homeomorphism moves no point across `ω(Q)`
  have hiff : ∀ z ∈ ball x ρ', (dist (hfit.homeo z) Q < 1 ↔ dist z Q < 1) ∧ (dist (hfit.homeo z) Q ≤ 1 ↔ dist z Q ≤ 1) := by
    intro z hz
    by_cases hzK : z ∈ collarK P θ₁ θ₂ R' R''
    · by_cases hzx : z = x
      · rw [hzx, hfix]
        exact ⟨Iff.rfl, Iff.rfl⟩
      · have h1 : dist z x < ρ := lt_of_lt_of_le (mem_ball.mp hz) (min_le_right _ _)
        have h2 : dist (hfit.homeo z) x < ρ := hδb (lt_of_lt_of_le (mem_ball.mp hz) (min_le_left _ _))
        have hne : hfit.homeo z ≠ x := fun h => hzx (hfit.homeo.injective (h.trans hfix.symm))
        rcases hside with hs | hs
        · have a1 := hs z hzK hzx h1
          have a2 := hs _ (hfit.homeo_maps_collar hzK) hne h2
          exact ⟨iff_of_true a2 a1, iff_of_true a2.le a1.le⟩
        · have a1 := hs z hzK hzx h1
          have a2 := hs _ (hfit.homeo_maps_collar hzK) hne h2
          exact ⟨iff_of_false (not_lt.mpr a2.le) (not_lt.mpr a1.le), iff_of_false (not_le.mpr a2) (not_le.mpr a1)⟩
    · rw [(hfit.homeo_eq_self hzK).1]
      exact ⟨Iff.rfl, Iff.rfl⟩
  -- the closures at the end, of a class met with a set the homeomorphism respects near the end
  have key : ∀ S : Set ℂ, (∀ z ∈ ball x ρ', (hfit.homeo z ∈ S ↔ z ∈ S)) → ∀ d : Fin k,
      x ∈ closure (hfit.map.region d ∩ S) ↔ x ∈ closure (F.region d ∩ S) := by
    intro S hS d
    have hreg : hfit.map.region d = hfit.homeo '' F.region d := pushforward_region d
    have hWo : IsOpen (hfit.homeo '' ball x ρ') := hfit.homeo.isOpenMap _ isOpen_ball
    have hxW : x ∈ hfit.homeo '' ball x ρ' := ⟨x, mem_ball_self hρ'0, hfix⟩
    have himg : hfit.homeo '' ball x ρ' ∩ (hfit.homeo '' F.region d ∩ S) = hfit.homeo '' (ball x ρ' ∩ (F.region d ∩ S)) := by
      ext y
      constructor
      · rintro ⟨⟨z, hzW, rfl⟩, ⟨z', hz', hzz⟩, hyS⟩
        obtain rfl := hfit.homeo.injective hzz
        exact ⟨z', ⟨hzW, hz', (hS z' hzW).mp hyS⟩, rfl⟩
      · rintro ⟨z, ⟨hzW, hzr, hzS⟩, rfl⟩
        exact ⟨⟨z, hzW, rfl⟩, ⟨z, hzr, rfl⟩, (hS z hzW).mpr hzS⟩
    have hloc : x ∈ closure (hfit.homeo '' F.region d ∩ S) ↔
        x ∈ closure (hfit.homeo '' ball x ρ' ∩ (hfit.homeo '' F.region d ∩ S)) :=
      ⟨fun h => hWo.inter_closure ⟨hxW, h⟩, fun h => closure_mono inter_subset_right h⟩
    rw [hreg, hloc, himg, ← hfit.homeo.image_closure]
    constructor
    · rintro ⟨y, hy, hyx⟩
      have hyx' : y = x := hfit.homeo.injective (hyx.trans hfix.symm)
      rw [hyx'] at hy
      exact closure_mono inter_subset_right hy
    · intro h
      exact ⟨x, isOpen_ball.inter_closure ⟨mem_ball_self hρ'0, h⟩, hfix⟩
  refine ⟨Set.ext fun d => ?_, Set.ext fun d => ?_⟩
  · exact key (ball Q 1) (fun z hz => by simp only [mem_ball]; exact (hiff z hz).1) d
  · show x ∈ closure (hfit.map.region d \ closedBall Q 1) ↔ x ∈ closure (F.region d \ closedBall Q 1)
    rw [sdiff_eq, sdiff_eq]
    exact key (closedBall Q 1)ᶜ (fun z hz => by
      simp only [mem_compl_iff, mem_closedBall]; exact not_congr (hiff z hz).2) d

/-- **The sides at a point of `F.Γ` off the open arc are kept** by the outward bend (mirror of `CollarFit.sides_eq`; the common step
of R1 and R2): off the closed outward lens the two maps agree near the point (`map_agreesOff`, closures being local); on it, such a
point is an end of the arc — over the open sector the lens off `ω(P)` lies in the **outer** collar, interior in `F` (`kout_subset`;
the toward bend's lens lies in the inner collar) — where `sides_end` applies for a centre other than `P`. -/
theorem CollarFitOut.sides_eq (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hxΓ : x ∈ F.Γ)
    (hxO : x ∉ ringPt P '' Ioo θ₁ θ₂) (hQ : (x = ringPt P θ₁ ∨ x = ringPt P θ₂) → Q ≠ P) :
    hfit.map.innerColours Q x = F.innerColours Q x ∧ hfit.map.outerColours Q x = F.outerColours Q x := by
  have hp := hfit.pushOutProfiles
  by_cases hxV : x ∈ polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ)
  · obtain ⟨ψ, hψ, t, ht, hxe⟩ := hxV
    by_cases hψ' : ψ ∈ Ioo θ₁ θ₂
    · exfalso
      rcases eq_or_lt_of_le ht.1 with ht1 | ht1
      · subst ht1
        exact hxO ⟨ψ, hψ', by rw [hxe]; simp [ringPt]⟩
      · exact (hfit.kout_subset ⟨ψ, hψ', t, ⟨ht1, ht.2.trans (hp.inside ψ hψ').2.2.2.le⟩, hxe⟩).1.2 hxΓ.2
    · have ht1 : t = 1 := le_antisymm ((hp.off ψ hψ').2.1 ▸ ht.2) ht.1
      have hxe' : x = ringPt P ψ := by rw [hxe, ht1]; simp [ringPt]
      have hend : x = ringPt P θ₁ ∨ x = ringPt P θ₂ := by
        rcases eq_or_lt_of_le hψ.1 with h1 | h1
        · exact Or.inl (hxe'.trans (by rw [h1]))
        · exact Or.inr (hxe'.trans (by rw [le_antisymm hψ.2 (not_lt.mp fun h2 => hψ' ⟨h1, h2⟩)]))
      exact hfit.sides_end (hQ hend) hend
  · have hO : IsOpen (polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ))ᶜ := hfit.isClosed_closedLensOut.isOpen_compl
    have hag : ∀ z ∈ (polarSet P (Icc θ₁ θ₂) fun θ => Icc 1 (outerProf θ₁ θ₂ R θ))ᶜ,
        (z ∈ hfit.map.interiorPts ↔ z ∈ F.interiorPts) ∧ hfit.map.col z = F.col z :=
      fun z hz => ⟨(hfit.map_agreesOff.2 z fun hzU => hz (hfit.lensOut_subset_closedLensOut hzU)).1.symm,
        (hfit.map_agreesOff.2 z fun hzU => hz (hfit.lensOut_subset_closedLensOut hzU)).2.symm⟩
    have hloc := fun j S => mem_closure_region_inter_iff_of_agree hO hxV (fun z hz => (hag z hz).1)
      (fun z hz => (hag z hz).2) j S
    refine ⟨Set.ext fun j => hloc j (ball Q 1), Set.ext fun j => ?_⟩
    show x ∈ closure (hfit.map.region j \ closedBall Q 1) ↔ x ∈ closure (F.region j \ closedBall Q 1)
    rw [sdiff_eq, sdiff_eq]
    exact hloc j (closedBall Q 1)ᶜ

/-- **The open arc is interior in the outward bent map** (`map_lens` at `t = 1`: the lens with the open arc takes the inner colour),
so off its `Γ`. -/
theorem CollarFitOut.ringPt_notMem_map_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {ψ : ℝ} (hψ : ψ ∈ Ioo θ₁ θ₂) :
    ringPt P ψ ∉ hfit.map.Γ := fun hΓ =>
  (hfit.map_lens ⟨ψ, hψ, 1, ⟨le_rfl, (hfit.pushOutProfiles.inside ψ hψ).2.2.1⟩, by simp [ringPt]⟩).1.2 hΓ.2

/-- **R1** for the outward bend (mirror of `CollarFit.map_R1`, through the mirrors of `exists_one_side`, `sides_end`, `sides_eq`:
near an end the collar lies on one side of `ω(Q)`, `Q ≠ P`, and both its halves keep their colours and the end in their closures).
**Open — `sorry`** (child C6). -/
theorem CollarFitOut.map_R1 (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d' := by
  sorry

/-- **R2** for the outward bend (mirror of `CollarFit.map_R2`). **Open — `sorry`** (child C6). -/
theorem CollarFitOut.map_R2 (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : F.IsRingArc Q a b d d') (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) :
    hfit.map.IsRingArc Q a b d d' := by
  sorry

/-- **The outward bend is a local step on its collar** (`LocalStep.of_cutArcs` with the two lens arcs, inside the collar by the mirror
of `CollarFit.lensCurve_subset` and `collarOutArcs_carrier`; `map_agreesOff` weakened to the collar). **Proved (FS131-BA2)** (child C7). -/
theorem CollarFitOut.map_localStep (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    LocalStep F hfit.map (collarK P θ₁ θ₂ R' R'') := by
  have hag := hfit.map_agreesOff
  refine LocalStep.of_cutArcs (S := {collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R}) hfit.ring.1
    ⟨hag.1, fun z hz => hag.2 z fun h => hz (h.elim (fun h => hfit.lensOutSet_subset_collar h)
      (fun h => hfit.lensOutCurve_subset h))⟩ rfl ?_ hfit.ringArc_subset_collar
  intro a ha
  refine Subset.trans ?_ hfit.lensOutCurve_subset
  rw [← collarOutArcs_carrier (P := P) hfit.params.2.2.1 hfit.ring.1 hfit.short]
  rcases ha with rfl | rfl
  · exact subset_union_left
  · exact subset_union_right

/-- **The horn clause for the outward bend** (the arc step's form; the same route as `CollarFit.map_hornCount_le`, plan § 4): off the
collar `hasHornCount_iff_of_agree`; in the collar and not an end, `0` (`hasHornCount_zero_of_mem_interiorPts`, or
`hasHornCount_zero_of_two_spheres` on the lens curve's two circles); at an end `hasHornCount_iff_of_germ_swap` with `κ₀ = ±1`,
`κ₀' = ±1/R`. **Proved (FS131-BA2)** (child C8). -/
theorem CollarFitOut.map_hornCount_le (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}
    (hj : F.HasHornCount x j) : ∃ j' ≤ j, hfit.map.HasHornCount x j' := by
  obtain ⟨hR', hR'1, hR1, hRR'', -⟩ := hfit.params
  have h12 := hfit.ring.1
  have hπ := Real.pi_pos
  have hRh : (1 : ℝ) / 2 < R := by linarith
  have hu0 : 0 < (θ₂ - θ₁) / 2 := by linarith
  have hu1 : (θ₂ - θ₁) / 2 < π := by linarith [hfit.short]
  refine hornCount_le_of_collarBend (F := F) (M := hfit.map) (dA := dist (ringPt P θ₁) (collarOutMid P θ₁ θ₂ R))
    (dB := dist (ringPt P θ₂) (collarOutMid P θ₁ θ₂ R)) h12 hfit.short hR' (by linarith) hR'1 hRR'' (by linarith) hR1.ne' rfl
    hfit.sub_dom hfit.collar_isClosed hfit.ring.2.1 hfit.free (fun z hz => ?_) ?_ ?_ ?_ ?_ ?_ hj
  · have := (pushforward_mem_interiorPts_iff (hfit.homeo.symm z) :
      hfit.homeo (hfit.homeo.symm z) ∈ hfit.map.interiorPts ↔ hfit.homeo.symm z ∈ F.interiorPts)
    rwa [hfit.homeo.apply_symm_apply, (hfit.homeo_eq_self hz).2] at this
  · rw [dist_collarOutMid_left h12.le]; exact norm_tangRad_sub_one_pos hRh hu0 hu1
  · rw [dist_collarOutMid_left h12.le]; exact norm_tangRad_sub_one_le hRh hu0.le hu1.le
  · rw [dist_collarOutMid_right h12.le]; exact norm_tangRad_sub_one_pos hRh hu0 hu1
  · rw [dist_collarOutMid_right h12.le]; exact norm_tangRad_sub_one_le hRh hu0.le hu1.le
  · rw [hfit.map_Γ, ← collarOutArcs_carrier hR1 h12 hfit.short]; rfl

/-- **The outward collar bend is an away bend** over its arc: every field of `AwayBend` for `hfit.map`, `hfit.homeo` and the collar.
Fields: `valid` `map_valid`; `compact` `isCompact_polarSet_Icc`; `thick`, `free` the fit's; `ring_K` by the collar's polar form;
`step` `map_localStep`; `fix_off`, `maps`, `fix_Γ` the mirrors of `homeo_eq_self`, `homeo_mem_collarK`, `homeo_fix_Γ`; `interior`,
`colours`, `degree`, `repeated` the `pushforward_*` lemmas (`pushforward_hasDegree`; off the domain the maps agree near the point);
`horn` `map_hornCount_le`; `within`, `r1`, `r2` above; `bent` by `map_lens` at `t = 1`, so `rest` is empty. **Proved (FS131-BA2)**
(child C9, the assembly). -/
theorem CollarFitOut.awayBend (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    AwayBend F hfit.map hfit.homeo (collarK P θ₁ θ₂ R' R'') P θ₁ θ₂ c ε := by
  have hp := hfit.pushOutProfiles
  -- degrees and repeated colours: on the collar by the pushforward, off it because the maps agree near the point
  have hdeg : ∀ z, (∀ n, hfit.map.HasDegree (hfit.homeo z) n ↔ F.HasDegree z n) ∧
      (hfit.map.HasRepeatedColour (hfit.homeo z) ↔ F.HasRepeatedColour z) := by
    intro z
    by_cases hzK : z ∈ collarK P θ₁ θ₂ R' R''
    · exact pushforward_hasDegree (hfit.sub_dom hzK)
    · obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hfit.collar_isClosed.isOpen_compl z hzK
      have hid : ∀ x ∈ ball z r, hfit.homeo.symm x = x := fun x hx => (hfit.homeo_eq_self (hball hx)).2
      rw [(hfit.homeo_eq_self hzK).1]
      refine hasDegree_iff_of_agree hr (fun x hx => ?_) (fun x hx _ => ?_)
      · have := (pushforward_mem_interiorPts_iff (hfit.homeo.symm x) :
          hfit.homeo (hfit.homeo.symm x) ∈ hfit.map.interiorPts ↔ hfit.homeo.symm x ∈ F.interiorPts)
        rwa [hfit.homeo.apply_symm_apply, hid x hx] at this
      · show F.col (hfit.homeo.symm x) = F.col x
        rw [hid x hx]
  have hbent : ∀ θ ∈ Ioo θ₁ θ₂, ringPt P θ ∈ hfit.map.region c := by
    intro θ hθ
    have := hfit.map_lens (z := ringPt P θ) ⟨θ, hθ, 1, ⟨le_rfl, (hp.inside θ hθ).2.2.1⟩, by simp [ringPt]⟩
    exact ⟨this.1, this.2⟩
  exact
    { valid := hfit.map_valid hF
      compact := isCompact_polarSet_Icc P hp.cont_a hp.cont_b fun θ _ => by
        rcases hfit.pushOutProfiles.cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
        · linarith
        · rw [h1, h3]
      thick := hfit.sub_thick
      free := hfit.free
      ring_K := hfit.collar_inter_sphere
      step := hfit.map_localStep
      fix_off := fun z hz => (hfit.homeo_eq_self hz).1
      maps := fun z hz => hfit.homeo_maps_collar hz
      fix_Γ := fun z hz hzO => hfit.homeo_fix_Γ hz hzO
      interior := fun z => ⟨pushforward_mem_interiorPts_iff z, fun _ => pushforward_col_apply z⟩
      colours := fun z => pushforward_coloursAt z
      degree := fun z n => (hdeg z).1 n
      repeated := fun z => (hdeg z).2
      horn := fun x j hj => hfit.map_hornCount_le hj
      within := hfit.map_ringArcsWithin
      r1 := fun Q a' b' d d' h => hfit.map_R1 hF h
      r2 := fun Q a' b' d d' h hd => hfit.map_R2 hF h hd
      bent := fun θ hθ => Or.inr (hbent θ hθ)
      rest := Set.Finite.subset Set.finite_empty fun θ hθ => hθ.2.1 (hbent θ hθ.1) }

/-- **The away bend of one gap**: the outward collar bend exists and is an away bend. Inhabitant of the hypotheses: owed with the away
bend's model (plan § 5; on a fragment, `isoFrag`'s half-arcs on either side of its isolated contact). -/
theorem bend_away_gap (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1)
    (hgap : ∀ θ ∈ Ioo θ₁ θ₂, P + 2 * e θ ∉ closure (F.region c)) (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ), AwayBend F M h K P θ₁ θ₂ c ε := by
  obtain ⟨R', R, R'', hfit⟩ := exists_collarFitOut hF hA hin hdom hfree hgap hε
  exact ⟨hfit.map, hfit.homeo, _, hfit.awayBend hF⟩

end Gap

end ArcMap

end HadwigerNelson.Plane
