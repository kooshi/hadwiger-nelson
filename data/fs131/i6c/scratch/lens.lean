import Proofs.HadwigerNelson.Plane.Saturated.Curve
namespace HadwigerNelson.Plane
open Complex Set Filter Topology Metric

/-- The lens inequality in the five quantities it reads. -/
theorem lens_ineq_real {D a b s K : ℝ} (hD : 0 ≤ D) (ha1 : -D / 2 ≤ a) (hb1 : -D / 2 ≤ b)
    (hs0 : 0 < s) (hs1 : s ≤ 1 / 2) (hL : 4 * D < s * K) :
    1 + D - 2 * b * (1 - s) - 2 * s * a - s * (1 - s) * K < 1 := by
  have h1 : -(2 * b * (1 - s)) ≤ (1 - s) * D := by nlinarith
  have h2 : -(2 * s * a) ≤ s * D := by nlinarith
  have h3 : s * K / 2 ≤ s * (1 - s) * K := by
    nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ 1 / 2 - s) (by linarith : (0 : ℝ) ≤ s * K)]
  nlinarith

/-- The lens point in coordinates. -/
theorem lens_point_real {wr wi nr ni mr mi s : ℝ} (hn : nr ^ 2 + ni ^ 2 = 1) (hm : mr ^ 2 + mi ^ 2 = 1)
    (ha1 : -(wr ^ 2 + wi ^ 2) / 2 ≤ wr * nr + wi * ni) (hb1 : -(wr ^ 2 + wi ^ 2) / 2 ≤ wr * mr + wi * mi)
    (hs0 : 0 < s) (hs1 : s ≤ 1 / 2)
    (hL : 4 * (wr ^ 2 + wi ^ 2) < s * ((nr - mr) ^ 2 + (ni - mi) ^ 2)) :
    (s * (mr - nr) + nr) ^ 2 + (s * (mi - ni) + ni) ^ 2 < 1 ∧
      (wr + s * (mr - nr) - mr) ^ 2 + (wi + s * (mi - ni) - mi) ^ 2 < 1 := by
  have hsK : 0 < s * ((nr - mr) ^ 2 + (ni - mi) ^ 2) := by nlinarith [sq_nonneg wr, sq_nonneg wi]
  have e1 : (s * (mr - nr) + nr) ^ 2 + (s * (mi - ni) + ni) ^ 2 =
      1 - s * (1 - s) * ((nr - mr) ^ 2 + (ni - mi) ^ 2) := by
    linear_combination (1 - s) * hn + s * hm
  have e2 : (wr + s * (mr - nr) - mr) ^ 2 + (wi + s * (mi - ni) - mi) ^ 2 =
      1 + (wr ^ 2 + wi ^ 2) - 2 * (wr * mr + wi * mi) * (1 - s) - 2 * s * (wr * nr + wi * ni) -
        s * (1 - s) * ((nr - mr) ^ 2 + (ni - mi) ^ 2) := by
    linear_combination (1 - s) * hm + s * hn
  refine ⟨?_, ?_⟩
  · rw [e1]
    have : 0 < (1 - s) * (s * ((nr - mr) ^ 2 + (ni - mi) ^ 2)) := mul_pos (by linarith) hsK
    linarith
  · rw [e2]
    exact lens_ineq_real (by positivity) ha1 hb1 hs0 hs1 hL

/-- **The lens point, far regime** (FS131-E8 § 3.1 (3)(c)): unit normals `ν`, `ν'` at `x`, `x'` that differ by more
than six times `‖x − x'‖` put a point `p` within `τ` of `x` in both the open unit disc about `x − ν` and the one about
`x' + ν'` — as soon as `x'` is outside the open unit disc about `x + ν`, `x` outside the one about `x' − ν'`, and
`2 ‖x − x'‖ ≤ τ`. -/
theorem exists_lens_point_far {x x' ν ν' : ℂ} {τ : ℝ} (hν : ‖ν‖ = 1) (hν' : ‖ν'‖ = 1)
    (h1 : 1 ≤ ‖x' - (x + ν)‖) (h4 : 1 ≤ ‖x - (x' - ν')‖) (hτ : 0 < τ) (hδ : 2 * ‖x - x'‖ ≤ τ)
    (hL : 6 * ‖x - x'‖ < ‖ν - ν'‖) : ∃ p, ‖p - x‖ ≤ τ ∧ ‖p - (x - ν)‖ < 1 ∧ ‖p - (x' + ν')‖ < 1 := by
  have hδ0 := norm_nonneg (x - x')
  have hL0 : 0 < ‖ν - ν'‖ := lt_of_le_of_lt (by positivity) hL
  set t : ℝ := min (‖ν - ν'‖ / 2) τ with ht
  have ht0 : 0 < t := lt_min (by positivity) hτ
  have ht1 : t ≤ ‖ν - ν'‖ / 2 := min_le_left _ _
  have ht2 : t ≤ τ := min_le_right _ _
  have htL : 4 * ‖x - x'‖ ^ 2 < t * ‖ν - ν'‖ := by
    rcases min_choice (‖ν - ν'‖ / 2) τ with h | h
    · rw [ht, h]; nlinarith
    · rw [ht, h]; nlinarith
  set s : ℝ := t / ‖ν - ν'‖ with hs
  have hs0 : 0 < s := div_pos ht0 hL0
  have hs1 : s ≤ 1 / 2 := by rw [hs, div_le_iff₀ hL0]; linarith
  have hsL : s * ‖ν - ν'‖ = t := div_mul_cancel₀ t hL0.ne'
  have hn : ν.re ^ 2 + ν.im ^ 2 = 1 := by rw [← sq_norm_eq, hν, one_pow]
  have hm : ν'.re ^ 2 + ν'.im ^ 2 = 1 := by rw [← sq_norm_eq, hν', one_pow]
  have hw : ‖x - x'‖ ^ 2 = (x.re - x'.re) ^ 2 + (x.im - x'.im) ^ 2 := by
    rw [sq_norm_eq, Complex.sub_re, Complex.sub_im]
  have hK : ‖ν - ν'‖ ^ 2 = (ν.re - ν'.re) ^ 2 + (ν.im - ν'.im) ^ 2 := by
    rw [sq_norm_eq, Complex.sub_re, Complex.sub_im]
  have ha1 : -((x.re - x'.re) ^ 2 + (x.im - x'.im) ^ 2) / 2 ≤ (x.re - x'.re) * ν.re + (x.im - x'.im) * ν.im := by
    have h := one_le_pow₀ (n := 2) h1
    rw [sq_norm_eq, Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im] at h
    nlinarith
  have hb1 : -((x.re - x'.re) ^ 2 + (x.im - x'.im) ^ 2) / 2 ≤ (x.re - x'.re) * ν'.re + (x.im - x'.im) * ν'.im := by
    have h := one_le_pow₀ (n := 2) h4
    rw [sq_norm_eq, Complex.sub_re, Complex.sub_im, Complex.sub_re, Complex.sub_im] at h
    nlinarith
  have hLs : 4 * ((x.re - x'.re) ^ 2 + (x.im - x'.im) ^ 2) <
      s * ((ν.re - ν'.re) ^ 2 + (ν.im - ν'.im) ^ 2) := by
    rw [← hw, ← hK, pow_two ‖ν - ν'‖, ← mul_assoc, hsL]
    exact htL
  obtain ⟨k1, k2⟩ := lens_point_real hn hm ha1 hb1 hs0 hs1 hLs
  refine ⟨x + (s : ℂ) * (ν' - ν), ?_, ?_, ?_⟩
  · rw [add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hs0, norm_sub_rev, hsL]
    exact ht2
  · have hre : (x + (s : ℂ) * (ν' - ν) - (x - ν)).re = s * (ν'.re - ν.re) + ν.re := by simp
    have him : (x + (s : ℂ) * (ν' - ν) - (x - ν)).im = s * (ν'.im - ν.im) + ν.im := by simp
    rw [← sq_lt_one_iff₀ (norm_nonneg _), sq_norm_eq, hre, him]
    exact k1
  · have hre : (x + (s : ℂ) * (ν' - ν) - (x' + ν')).re = x.re - x'.re + s * (ν'.re - ν.re) - ν'.re := by
      simp; ring
    have him : (x + (s : ℂ) * (ν' - ν) - (x' + ν')).im = x.im - x'.im + s * (ν'.im - ν.im) - ν'.im := by
      simp; ring
    rw [← sq_lt_one_iff₀ (norm_nonneg _), sq_norm_eq, hre, him]
    exact k2

/-- **The lens point**: unit normals at `x`, `x'` that differ by more than `‖x − x'‖` put a point within `τ` of `x` in
two opposite open unit discs, one at each point — as soon as each point is outside the two open unit discs at the
other and `4 ‖x − x'‖ ≤ τ`. Far apart (`> 6 ‖x − x'‖`) it is `exists_lens_point_far`'s point; otherwise the midpoint of
two centres less than `2` apart (`norm_sub_le_of_discs`), within `3.5 ‖x − x'‖` of `x`. -/
theorem exists_lens_point {x x' ν ν' : ℂ} {τ : ℝ} (hν : ‖ν‖ = 1) (hν' : ‖ν'‖ = 1)
    (h1 : 1 ≤ ‖x' - (x + ν)‖) (h4 : 1 ≤ ‖x - (x' - ν')‖) (hτ : 0 < τ) (hδ : 4 * ‖x - x'‖ ≤ τ)
    (hL : ‖x - x'‖ < ‖ν - ν'‖) :
    ∃ p, ‖p - x‖ ≤ τ ∧ ((‖p - (x - ν)‖ < 1 ∧ ‖p - (x' + ν')‖ < 1) ∨ (‖p - (x + ν)‖ < 1 ∧ ‖p - (x' - ν')‖ < 1)) := by
  have hδ0 := norm_nonneg (x - x')
  rcases lt_or_ge (6 * ‖x - x'‖) ‖ν - ν'‖ with hfar | hnear
  · obtain ⟨p, hp, hp1, hp2⟩ := exists_lens_point_far hν hν' h1 h4 hτ (by linarith) hfar
    exact ⟨p, hp, Or.inl ⟨hp1, hp2⟩⟩
  · have hmid : ∀ c₁ c₂ : ℂ, ‖c₁ - c₂‖ < 2 →
        ‖((1 / 2 : ℝ) : ℂ) * (c₁ + c₂) - c₁‖ < 1 ∧ ‖((1 / 2 : ℝ) : ℂ) * (c₁ + c₂) - c₂‖ < 1 := by
      intro c₁ c₂ hc
      have e1 : ((1 / 2 : ℝ) : ℂ) * (c₁ + c₂) - c₁ = ((1 / 2 : ℝ) : ℂ) * (c₂ - c₁) := by push_cast; ring
      have e2 : ((1 / 2 : ℝ) : ℂ) * (c₁ + c₂) - c₂ = ((1 / 2 : ℝ) : ℂ) * (c₁ - c₂) := by push_cast; ring
      rw [e1, e2, norm_mul, norm_mul, Complex.norm_real, norm_sub_rev c₂ c₁]
      norm_num
      linarith
    have hnot : ¬ (2 ≤ ‖(x + ν) - (x' - ν')‖ ∧ 2 ≤ ‖(x - ν) - (x' + ν')‖) := fun h =>
      not_le.2 hL (norm_sub_le_of_discs hν hν' h.1 h.2)
    rw [not_and_or, not_le, not_le] at hnot
    have hdist : ∀ σ : ℂ, ‖σ‖ = ‖ν - ν'‖ → ‖((1 / 2 : ℝ) : ℂ) * ((x + σ) + x') - x‖ ≤ τ := by
      intro σ hσ
      have e : ((1 / 2 : ℝ) : ℂ) * ((x + σ) + x') - x = ((1 / 2 : ℝ) : ℂ) * ((x' - x) + σ) := by push_cast; ring
      rw [e, norm_mul, Complex.norm_real]
      have := norm_add_le (x' - x) σ
      rw [norm_sub_rev x' x, hσ] at this
      norm_num
      linarith
    rcases hnot with h | h
    · obtain ⟨m1, m2⟩ := hmid _ _ h
      refine ⟨((1 / 2 : ℝ) : ℂ) * ((x + ν) + (x' - ν')), ?_, Or.inr ⟨m1, m2⟩⟩
      have := hdist (ν - ν') rfl
      convert this using 3; ring
    · obtain ⟨m1, m2⟩ := hmid _ _ h
      refine ⟨((1 / 2 : ℝ) : ℂ) * ((x - ν) + (x' + ν')), ?_, Or.inl ⟨m1, m2⟩⟩
      have := hdist (ν' - ν) (norm_sub_rev _ _)
      convert this using 3; ring

end HadwigerNelson.Plane
