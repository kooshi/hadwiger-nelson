import Proofs.HadwigerNelson.Plane.Basic

/-!
# Chords of unit circles, two unit circles, and the corner of two lines (FS-131 wave 1)

Rows: **FS116-V4-CHORD**, **FS129-SR1-TWOCIRC**, **FS121-D1-XCORNER**. Plan: `plans/FS131-kernel-plan.md` § 6.
Pure plane trigonometry: no colouring, no map. The angle convention is `Plane/Basic`'s (`e θ = exp(θ i)`,
counter-clockwise).
-/

namespace HadwigerNelson.Plane

open Complex Real Set

/-- `e (π/2) = i`. -/
theorem e_pi_div_two : e (π / 2) = I := by
  rw [e_eq]; simp

/-- `e (−θ) = cos θ − i sin θ`. -/
theorem e_neg (θ : ℝ) : e (-θ) = (Real.cos θ : ℂ) - (Real.sin θ : ℂ) * I := by
  rw [e_eq]; simp [sub_eq_add_neg]

/-- `e θ` is never zero (it has norm `1`). -/
theorem e_ne_zero (θ : ℝ) : e θ ≠ 0 := by
  intro h; have := norm_e θ; rw [h, norm_zero] at this; exact zero_ne_one this

/-- Squared norm of `−1 + e u + e v`, in coordinates. -/
theorem norm_sq_neg_one_add_e_add_e (u v : ℝ) :
    ‖(-1 : ℂ) + e u + e v‖ ^ 2 = (-1 + Real.cos u + Real.cos v) ^ 2 + (Real.sin u + Real.sin v) ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply, e_eq, e_eq]
  simp [-Complex.ofReal_cos, -Complex.ofReal_sin]
  ring

/-- The difference of the two turned points is `(y₁ − y₀)(−1 + e(σ s) + e(−σ t))`. -/
theorem twoCirc_diff (y₀ y₁ : ℂ) (u v : ℝ) :
    (y₀ + (y₁ - y₀) * e u) - (y₁ + (y₀ - y₁) * e v) = (y₁ - y₀) * ((-1 : ℂ) + e u + e v) := by
  ring

/-- The chord of a unit circle as a vector: `r(β) − r(α) = 2 sin((β − α)/2) · e((α + β)/2 + π/2)`. -/
theorem ringPt_sub_ringPt (p : ℂ) (α β : ℝ) :
    ringPt p β - ringPt p α = ((2 * Real.sin ((β - α) / 2) : ℝ) : ℂ) * e ((α + β) / 2 + π / 2) := by
  obtain ⟨m, d, rfl, rfl⟩ : ∃ m d : ℝ, α = m - d ∧ β = m + d :=
    ⟨(α + β) / 2, (β - α) / 2, by ring, by ring⟩
  have h1 : (m - d + (m + d)) / 2 + π / 2 = m + π / 2 := by ring
  have h2 : (m + d - (m - d)) / 2 = d := by ring
  rw [h1, h2, e_add m (π / 2), e_pi_div_two]
  simp only [ringPt, add_sub_add_left_eq_sub, sub_eq_add_neg m d, e_add, e_neg, e_eq d]
  push_cast
  ring_nf

/-- **FS116-V4-CHORD**, distance: two points of a unit circle at angular separation `δ = |α − β| ∈ [0, π]` are at
distance `2 sin(δ/2)`. -/
theorem dist_ringPt_ringPt (p : ℂ) {α β : ℝ} (hδ : |α - β| ≤ π) :
    dist (ringPt p α) (ringPt p β) = 2 * Real.sin (|α - β| / 2) := by
  rw [dist_eq_norm, ringPt_sub_ringPt p β α, norm_mul, norm_e, mul_one, Complex.norm_real,
    Real.norm_eq_abs]
  have hsin : |Real.sin ((α - β) / 2)| = Real.sin (|α - β| / 2) := by
    rcases le_total 0 (α - β) with h | h
    · rw [abs_of_nonneg h]
      exact abs_of_nonneg (Real.sin_nonneg_of_nonneg_of_le_pi (by linarith)
        (by rw [abs_of_nonneg h] at hδ; linarith))
    · rw [abs_of_nonpos h, show -(α - β) / 2 = -((α - β) / 2) by ring, Real.sin_neg]
      exact abs_of_nonpos (Real.sin_nonpos_of_nonpos_of_neg_pi_le (by linarith)
        (by rw [abs_of_nonpos h] at hδ; linarith))
  rw [abs_mul, abs_two, hsin]

/-- **FS116-V4-CHORD**, the three regimes: at separation `δ ∈ [0, π]` the distance is `1` exactly at `δ = π/3`, below
`1` for `δ < π/3`, above `1` for `π/3 < δ`. -/
theorem dist_ringPt_ringPt_cmp_one (p : ℂ) {α β : ℝ} (hδ : |α - β| ≤ π) :
    (dist (ringPt p α) (ringPt p β) = 1 ↔ |α - β| = π / 3) ∧
    (dist (ringPt p α) (ringPt p β) < 1 ↔ |α - β| < π / 3) ∧
    (1 < dist (ringPt p α) (ringPt p β) ↔ π / 3 < |α - β|) := by
  rw [dist_ringPt_ringPt p hδ]
  have h0 : 0 ≤ |α - β| / 2 := by positivity
  have h1 : |α - β| / 2 ≤ π / 2 := by linarith
  have h6 : Real.sin (π / 6) = 1 / 2 := Real.sin_pi_div_six
  have hmono : StrictMonoOn Real.sin (Icc (-(π / 2)) (π / 2)) := Real.strictMonoOn_sin
  have hmem : |α - β| / 2 ∈ Icc (-(π / 2)) (π / 2) := ⟨by linarith [Real.pi_pos], h1⟩
  have hmem6 : π / 6 ∈ Icc (-(π / 2)) (π / 2) := ⟨by linarith [Real.pi_pos], by linarith [Real.pi_pos]⟩
  have hlt := hmono.lt_iff_lt hmem hmem6
  have hgt := hmono.lt_iff_lt hmem6 hmem
  have heq := hmono.injOn.eq_iff hmem hmem6
  rw [h6] at hlt hgt heq
  refine ⟨⟨fun h => ?_, fun h => ?_⟩, ⟨fun h => ?_, fun h => ?_⟩, ⟨fun h => ?_, fun h => ?_⟩⟩
  · have := heq.mp (by linarith); linarith
  · have : |α - β| / 2 = π / 6 := by linarith
    rw [this, h6]; norm_num
  · have := hlt.mp (by linarith); linarith
  · have := hlt.mpr (by linarith); linarith
  · have := hgt.mp (by linarith); linarith
  · have := hgt.mpr (by linarith); linarith

/-- **FS129-SR1-TWOCIRC**: let `|y₀ − y₁| = 1` and let `p = y₀ + (y₁ − y₀) e(σπ/3)` (`σ = ±1`: `p` is the third vertex
of a unit equilateral triangle on `y₀y₁`, and `σ` is the turning sense "toward `p`"); put
`a(s) = y₀ + (y₁ − y₀) e(σ s)` (from `y₁`, turning `s` about `y₀` toward `p`) and `b(t) = y₁ + (y₀ − y₁) e(−σ t)`
(from `y₀`, turning `t` about `y₁` toward `p`). Then
`|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) = 2(1 − cos s)(1 − cos t) − 2 sin s sin t`. -/
theorem twoCirc_identity {y₀ y₁ : ℂ} (h01 : dist y₀ y₁ = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (s t : ℝ) :
    ‖(y₀ + (y₁ - y₀) * e (σ * s)) - (y₁ + (y₀ - y₁) * e (-(σ * t)))‖ ^ 2 - 1 =
      -8 * Real.sin (s / 2) * Real.sin (t / 2) * Real.cos ((s + t) / 2) ∧
    ‖(y₀ + (y₁ - y₀) * e (σ * s)) - (y₁ + (y₀ - y₁) * e (-(σ * t)))‖ ^ 2 - 1 =
      2 * (1 - Real.cos s) * (1 - Real.cos t) - 2 * Real.sin s * Real.sin t := by
  have hu : ‖y₁ - y₀‖ = 1 := by rw [norm_sub_rev, ← dist_eq_norm, h01]
  have hnorm : ‖(y₀ + (y₁ - y₀) * e (σ * s)) - (y₁ + (y₀ - y₁) * e (-(σ * t)))‖ ^ 2 =
      (-1 + Real.cos (σ * s) + Real.cos (-(σ * t))) ^ 2
        + (Real.sin (σ * s) + Real.sin (-(σ * t))) ^ 2 := by
    rw [twoCirc_diff, norm_mul, hu, one_mul, norm_sq_neg_one_add_e_add_e]
  rw [hnorm]
  obtain ⟨a, rfl⟩ : ∃ a, s = 2 * a := ⟨s / 2, by ring⟩
  obtain ⟨b, rfl⟩ : ∃ b, t = 2 * b := ⟨t / 2, by ring⟩
  have hA := Real.sin_sq_add_cos_sq a
  have hB := Real.sin_sq_add_cos_sq b
  have e1 : (2 * a + 2 * b) / 2 = a + b := by ring
  have e2 : (2 * a) / 2 = a := by ring
  have e3 : (2 * b) / 2 = b := by ring
  rw [e1, e2, e3, Real.cos_add]
  rcases hσ with rfl | rfl
  · simp only [one_mul, neg_mul, Real.cos_neg, Real.sin_neg, Real.cos_two_mul, Real.sin_two_mul]
    constructor
    · linear_combination (4 * Real.cos a ^ 2 - 8 * Real.sin b ^ 2) * hA + (8 * Real.cos a ^ 2 + 4 * Real.cos b ^ 2 - 8) * hB
    · linear_combination (4 * Real.cos a ^ 2) * hA + (4 * Real.cos b ^ 2) * hB
  · simp only [neg_mul, one_mul, neg_neg, Real.cos_neg, Real.sin_neg, Real.cos_two_mul, Real.sin_two_mul]
    constructor
    · linear_combination (4 * Real.cos a ^ 2 - 8 * Real.sin b ^ 2) * hA + (8 * Real.cos a ^ 2 + 4 * Real.cos b ^ 2 - 8) * hB
    · linear_combination (4 * Real.cos a ^ 2) * hA + (4 * Real.cos b ^ 2) * hB

/-- **FS129-SR1-TWOCIRC**, the regimes: for `0 < s, t < π`, `|a(s) − b(t)|` is below `1` when `s + t < π`, equal to `1`
when `s + t = π`, above `1` when `s + t > π`. -/
theorem twoCirc_cmp_one {y₀ y₁ : ℂ} (h01 : dist y₀ y₁ = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {s t : ℝ}
    (hs : 0 < s) (hs' : s < π) (ht : 0 < t) (ht' : t < π) :
    (s + t < π → dist (y₀ + (y₁ - y₀) * e (σ * s)) (y₁ + (y₀ - y₁) * e (-(σ * t))) < 1) ∧
    (s + t = π → dist (y₀ + (y₁ - y₀) * e (σ * s)) (y₁ + (y₀ - y₁) * e (-(σ * t))) = 1) ∧
    (π < s + t → 1 < dist (y₀ + (y₁ - y₀) * e (σ * s)) (y₁ + (y₀ - y₁) * e (-(σ * t)))) := by
  have hid := (twoCirc_identity h01 hσ s t).1
  rw [dist_eq_norm]
  set N := ‖(y₀ + (y₁ - y₀) * e (σ * s)) - (y₁ + (y₀ - y₁) * e (-(σ * t)))‖ with hN
  have hN0 : 0 ≤ N := norm_nonneg _
  have hsa : 0 < Real.sin (s / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hsb : 0 < Real.sin (t / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hP : 0 < Real.sin (s / 2) * Real.sin (t / 2) := mul_pos hsa hsb
  refine ⟨fun h => ?_, fun h => ?_, fun h => ?_⟩
  · have hc : 0 < Real.cos ((s + t) / 2) :=
      Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
    have : N ^ 2 < 1 := by nlinarith [mul_pos hP hc]
    nlinarith
  · have hc : Real.cos ((s + t) / 2) = 0 := by
      rw [h, Real.cos_pi_div_two]
    have h2 : N ^ 2 = 1 := by rw [hc] at hid; linarith
    nlinarith
  · have hc : Real.cos ((s + t) / 2) < 0 :=
      Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith) (by linarith)
    have : 1 < N ^ 2 := by nlinarith [mul_pos hP (neg_pos.mpr hc)]
    nlinarith

/-- The row's hypothesis read back: every `p` with `|p − y₀| = |p − y₁| = 1 = |y₀ − y₁|` is `y₀ + (y₁ − y₀) e(σπ/3)`
for one of `σ = ±1`, so `twoCirc_identity` covers every configuration the row names. -/
theorem exists_sign_of_equilateral {y₀ y₁ p : ℂ} (h01 : dist y₀ y₁ = 1) (hp0 : dist p y₀ = 1)
    (hp1 : dist p y₁ = 1) : ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ p = y₀ + (y₁ - y₀) * e (σ * (π / 3)) := by
  have hne : y₁ - y₀ ≠ 0 := by
    intro h; rw [sub_eq_zero] at h; rw [h, dist_self] at h01; exact zero_ne_one h01
  have hu : ‖y₁ - y₀‖ = 1 := by rw [norm_sub_rev, ← dist_eq_norm, h01]
  set w : ℂ := (p - y₀) / (y₁ - y₀) with hw
  have hpw : p = y₀ + (y₁ - y₀) * w := by rw [hw]; field_simp; ring
  have hw1 : ‖w‖ = 1 := by
    rw [hw, norm_div, hu, div_one, ← dist_eq_norm, hp0]
  have hw2 : ‖w - 1‖ = 1 := by
    have : w - 1 = (p - y₁) / (y₁ - y₀) := by rw [hw]; field_simp; ring
    rw [this, norm_div, hu, div_one, ← dist_eq_norm, hp1]
  have h1 : w.re ^ 2 + w.im ^ 2 = 1 := by
    have := Complex.sq_norm w
    rw [hw1, Complex.normSq_apply] at this
    nlinarith
  have h2 : (w.re - 1) ^ 2 + w.im ^ 2 = 1 := by
    have := Complex.sq_norm (w - 1)
    rw [hw2, Complex.normSq_apply] at this
    simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im] at this
    nlinarith
  have hre : w.re = 1 / 2 := by nlinarith
  have him : w.im ^ 2 = (√3 / 2) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num)]; rw [hre] at h1; nlinarith
  have hs3 : 0 < √3 / 2 := by positivity
  have hcs : e (π / 3) = ⟨1 / 2, √3 / 2⟩ := by
    rw [e_eq, Real.cos_pi_div_three, Real.sin_pi_div_three]
    apply Complex.ext <;> simp
  rcases sq_eq_sq_iff_eq_or_eq_neg.mp him with h | h
  · refine ⟨1, Or.inl rfl, ?_⟩
    rw [hpw, one_mul, hcs]; congr 2; apply Complex.ext <;> simp [hre, h]
  · refine ⟨-1, Or.inr rfl, ?_⟩
    rw [hpw, show (-1 : ℝ) * (π / 3) = -(π / 3) by ring, e_neg, Real.cos_pi_div_three,
      Real.sin_pi_div_three]
    congr 2; apply Complex.ext <;> simp [hre, h]

/-- **FS121-D1-XCORNER**: at a convex corner `z` of angle `θ ∈ (0, π)` with straight edges along `e(φ)` and
`e(φ + θ)`, the inner unit parallels of the two edges (`z + s e(φ) + e(φ + π/2)` and `z + t e(φ + θ) + e(φ + θ − π/2)`)
meet exactly when `s = t = cot(θ/2)`, at the point at distance `1/sin(θ/2)` from `z` on the bisector. -/
theorem xcorner {θ : ℝ} (hθ : 0 < θ) (hθ' : θ < π) (z : ℂ) (φ : ℝ) (s t : ℝ) :
    (z + s * e φ + e (φ + π / 2) = z + t * e (φ + θ) + e (φ + θ - π / 2) ↔
      s = Real.cot (θ / 2) ∧ t = Real.cot (θ / 2)) ∧
    z + (Real.cot (θ / 2) : ℂ) * e φ + e (φ + π / 2) = z + ((1 / Real.sin (θ / 2) : ℝ) : ℂ) * e (φ + θ / 2) := by
  obtain ⟨c, rfl⟩ : ∃ c, θ = 2 * c := ⟨θ / 2, by ring⟩
  have hc : 2 * c / 2 = c := by ring
  rw [hc]
  have hc0 : 0 < c := by linarith
  have hc1 : c < π / 2 := by linarith
  have hsc : 0 < Real.sin c := Real.sin_pos_of_pos_of_lt_pi hc0 (by linarith)
  have hcc : 0 < Real.cos c := Real.cos_pos_of_mem_Ioo ⟨by linarith, hc1⟩
  have hpy := Real.sin_sq_add_cos_sq c
  have hcot : Real.cot c = Real.cos c / Real.sin c := Real.cot_eq_cos_div_sin c
  have e1 : e (φ + π / 2) = e φ * I := by rw [e_add, e_pi_div_two]
  have e2 : e (φ + 2 * c) = e φ * e (2 * c) := e_add _ _
  have e3 : e (φ + 2 * c - π / 2) = e φ * (e (2 * c) * (-I)) := by
    rw [show φ + 2 * c - π / 2 = φ + (2 * c + -(π / 2)) by ring, e_add, e_add, e_neg,
      Real.cos_pi_div_two, Real.sin_pi_div_two]
    simp
  have e4 : e (φ + c) = e φ * e c := e_add _ _
  have hsin2 : Real.sin (2 * c) = 2 * Real.sin c * Real.cos c := Real.sin_two_mul c
  have hcos2 : Real.cos (2 * c) = 2 * Real.cos c ^ 2 - 1 := Real.cos_two_mul c
  refine ⟨?_, ?_⟩
  · have hE : (z + s * e φ + e (φ + π / 2) = z + t * e (φ + 2 * c) + e (φ + 2 * c - π / 2)) ↔
        ((s : ℂ) + I = ((t : ℂ) - I) * e (2 * c)) := by
      rw [e1, e2, e3]
      constructor
      · intro h
        have : e φ * ((s : ℂ) + I) = e φ * (((t : ℂ) - I) * e (2 * c)) := by linear_combination h
        exact mul_left_cancel₀ (e_ne_zero φ) this
      · intro h; linear_combination e φ * h
    rw [hE, Complex.ext_iff, e_eq]
    simp [-Complex.ofReal_cos, -Complex.ofReal_sin]
    rw [hcot, hsin2, hcos2]
    constructor
    · rintro ⟨h1, h2⟩
      have ht : t = Real.cos c / Real.sin c := by
        field_simp
        nlinarith
      refine ⟨?_, ht⟩
      rw [ht] at h1
      rw [h1]; field_simp; nlinarith
    · rintro ⟨h1, h2⟩
      subst h1; subst h2
      constructor
      · field_simp; nlinarith
      · field_simp; nlinarith
  · rw [e1, e4, hcot, e_eq c]
    have hs0 : (Real.sin c : ℂ) ≠ 0 := by exact_mod_cast hsc.ne'
    simp only [Complex.ofReal_div, Complex.ofReal_one]
    field_simp
    ring

end HadwigerNelson.Plane
