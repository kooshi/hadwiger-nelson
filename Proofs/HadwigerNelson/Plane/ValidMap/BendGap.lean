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

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

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
"none" case, forced by `hgap`), hence farther than `1` (`end_cap`, once `R ≤ ρ₀ − 1`). **Open — `sorry`** (child C4, the new
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
`exists_collar_free`, **as it stands** (the collar is the toward bend's). **Open — `sorry`** (child C5; short once C4 is in). -/
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

/-! ### The outward collar's access lemmas (mirrors of `CollarFit`'s, under names of their own: the other half of the bend holds
`CollarMapOut`, and the final sync keeps one of each) -/

/-- The three profiles at an angle: `0 < a < 1 < l < b` inside the sector, all `1` off it. -/
theorem CollarFitOut.prof_cases (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') (θ : ℝ) :
    (θ ∈ Ioo θ₁ θ₂ ∧ 0 < lensProf θ₁ θ₂ R' θ ∧ lensProf θ₁ θ₂ R' θ < 1 ∧ 1 < outerProf θ₁ θ₂ R θ ∧
        outerProf θ₁ θ₂ R θ < outerProf θ₁ θ₂ R'' θ) ∨
      (θ ∉ Ioo θ₁ θ₂ ∧ lensProf θ₁ θ₂ R' θ = 1 ∧ outerProf θ₁ θ₂ R θ = 1 ∧ outerProf θ₁ θ₂ R'' θ = 1) := by
  by_cases hθ : θ ∈ Ioo θ₁ θ₂
  · exact Or.inl ⟨hθ, hfit.pushOutProfiles.inside θ hθ⟩
  · exact Or.inr ⟨hθ, hfit.pushOutProfiles.off θ hθ⟩

/-- The outward lens boundary lies in the collar. -/
theorem CollarFitOut.lensOutCurve_subset_collar (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    lensOutCurve P θ₁ θ₂ R ⊆ collarK P θ₁ θ₂ R' R'' := by
  refine polarSet_mono subset_rfl fun θ _ => ?_
  rintro t rfl
  rcases hfit.prof_cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
  · exact ⟨by linarith, h3.le⟩
  · rw [h1, h2, h3]; exact ⟨le_rfl, le_rfl⟩

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
  rcases hfit.prof_cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
  · exact ⟨h1.le, by linarith⟩
  · rw [h1, h3]; exact ⟨le_rfl, le_rfl⟩

/-- The collar is closed. -/
theorem CollarFitOut.collar_isClosed (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : IsClosed (collarK P θ₁ θ₂ R' R'') := by
  have hp := hfit.pushOutProfiles
  refine (isCompact_polarSet_Icc P hp.cont_a hp.cont_b fun θ _ => ?_).isClosed
  rcases hfit.prof_cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
  · linarith
  · rw [h1, h3]

/-- The collar meets `ω(P)` only on the closed arc. -/
theorem CollarFitOut.collar_inter_sphere (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    collarK P θ₁ θ₂ R' R'' ∩ sphere P 1 ⊆ ringArc P θ₁ θ₂ := by
  rintro _ ⟨⟨θ, hθ, t, ht', rfl⟩, hs⟩
  have ht : t ∈ Icc (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ) := ht'
  have ht0 : 0 < t := by
    rcases hfit.prof_cases θ with ⟨-, h0, -, -, -⟩ | ⟨-, h1, -, -⟩
    · exact h0.trans_le ht.1
    · rw [h1] at ht; linarith [ht.1]
  rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht0.le] at hs
  exact ⟨θ, hθ, by rw [hs]; simp [ringPt]⟩

/-- The homeomorphism is the identity off the collar. -/
theorem CollarFitOut.homeo_off_collar (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ}
    (hz : z ∉ collarK P θ₁ θ₂ R' R'') : hfit.homeo z = z ∧ hfit.homeo.symm z = z :=
  pushOutHomeo_eq_self hfit.pushOutProfiles fun h => hz (polarSet_mono Ioo_subset_Icc_self (fun _ _ => Ioo_subset_Icc_self) h)

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

/-- The homeomorphism fixes `Γ` off the open arc. -/
theorem CollarFitOut.homeo_fix_Γ_off_arc (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ F.Γ)
    (hzO : z ∉ ringPt P '' Ioo θ₁ θ₂) : hfit.homeo z = z := by
  by_cases hK : z ∈ collarK P θ₁ θ₂ R' R''
  · obtain ⟨θ, hθ, rfl⟩ := hfit.free ⟨hz, hK⟩
    have hθ' : θ ∉ Ioo θ₁ θ₂ := fun h => hzO ⟨θ, h, rfl⟩
    refine (pushOutHomeo_eq_self hfit.pushOutProfiles ?_).1
    rw [show ringPt P θ = P + ((1 : ℝ) : ℂ) * e θ by simp [ringPt]]
    refine polar_not_mem_polarSet hfit.short hθ hθ' one_pos fun θ' t ht => ?_
    rcases hfit.prof_cases θ' with ⟨-, h0, -, -, -⟩ | ⟨-, h1, -, -⟩
    · exact h0.trans ht.1
    · rw [h1] at ht; exact lt_trans one_pos ht.1
  · exact (hfit.homeo_off_collar hK).1

/-- No unit arc is created (mirror of `CollarFit.map_ringArcsWithin`: the lens curve has radius `R ≠ 1`). **Open — `sorry`** (child C6). -/
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
of `CollarFit.lensCurve_subset` and `collarOutArcs_carrier`; `map_agreesOff` weakened to the collar). **Open — `sorry`** (child C7). -/
theorem CollarFitOut.map_localStep (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    LocalStep F hfit.map (collarK P θ₁ θ₂ R' R'') := by
  have hag := hfit.map_agreesOff
  refine LocalStep.of_cutArcs (S := {collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R}) hfit.ring.1
    ⟨hag.1, fun z hz => hag.2 z fun h => hz (h.elim (fun h => hfit.lensOutSet_subset_collar h)
      (fun h => hfit.lensOutCurve_subset_collar h))⟩ rfl ?_ hfit.ringArc_subset_collar
  intro a ha
  refine Subset.trans ?_ hfit.lensOutCurve_subset_collar
  rw [← collarOutArcs_carrier (P := P) hfit.params.2.2.1 hfit.ring.1 hfit.short]
  rcases ha with rfl | rfl
  · exact subset_union_left
  · exact subset_union_right

/-- **The horn clause for the outward bend** (the arc step's form; the same route as `CollarFit.map_hornCount_le`, plan § 4): off the
collar `hasHornCount_iff_of_agree`; in the collar and not an end, `0` (`hasHornCount_zero_of_mem_interiorPts`, or
`hasHornCount_zero_of_two_spheres` on the lens curve's two circles); at an end `hasHornCount_iff_of_germ_swap` with `κ₀ = ±1`,
`κ₀' = ±1/R`. **Open — `sorry`** (child C8). -/
theorem CollarFitOut.map_hornCount_le (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}
    (hj : F.HasHornCount x j) : ∃ j' ≤ j, hfit.map.HasHornCount x j' := by
  sorry

/-- **The outward collar bend is an away bend** over its arc: every field of `AwayBend` for `hfit.map`, `hfit.homeo` and the collar.
Fields: `valid` `map_valid`; `compact` `isCompact_polarSet_Icc`; `thick`, `free` the fit's; `ring_K` by the collar's polar form;
`step` `map_localStep`; `fix_off`, `maps`, `fix_Γ` the mirrors of `homeo_eq_self`, `homeo_mem_collarK`, `homeo_fix_Γ`; `interior`,
`colours`, `degree`, `repeated` the `pushforward_*` lemmas (`pushforward_hasDegree`; off the domain the maps agree near the point);
`horn` `map_hornCount_le`; `within`, `r1`, `r2` above; `bent` by `map_lens` at `t = 1`, so `rest` is empty. **Open — `sorry`**
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
      have hid : ∀ x ∈ ball z r, hfit.homeo.symm x = x := fun x hx => (hfit.homeo_off_collar (hball hx)).2
      rw [(hfit.homeo_off_collar hzK).1]
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
        rcases hfit.prof_cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
        · linarith
        · rw [h1, h3]
      thick := hfit.sub_thick
      free := hfit.free
      ring_K := hfit.collar_inter_sphere
      step := hfit.map_localStep
      fix_off := fun z hz => (hfit.homeo_off_collar hz).1
      maps := fun z hz => hfit.homeo_maps_collar hz
      fix_Γ := fun z hz hzO => hfit.homeo_fix_Γ_off_arc hz hzO
      interior := fun z => ⟨pushforward_mem_interiorPts_iff z, fun _ => pushforward_col_apply z⟩
      colours := fun z => pushforward_coloursAt z
      degree := fun z n => (hdeg z).1 n
      repeated := fun z => (hdeg z).2
      horn := fun x j hj => hfit.map_hornCount_le hF hj
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
