import Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub
import Proofs.HadwigerNelson.Plane.RingCalculus.StarChart

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The chord of the unit circle between the angles `m − x` and `m + x`. -/
theorem e_add_sub_e_sub (m x : ℝ) : e (m + x) - e (m - x) = ((2 * Real.sin x : ℝ) : ℂ) * (e m * I) := by
  rw [e_add, sub_eq_add_neg m x, e_add, e_eq x, e_neg x]
  push_cast
  ring

/-- **A germ approaches its ring point along the tangent**: if the germ of `ω(p)` on side `s` of `r(θ)` lies in `S`,
then `S` approaches `r(θ)` along `θ + 90°` (counter-clockwise) or `θ − 90°` (clockwise). -/
theorem GermIn.tangent_mem_coneAt {p : ℂ} {θ : ℝ} {s : Side} {S : Set ℂ} (h : GermIn p θ s S) :
    θ + s.sign * (π / 2) ∈ coneAt S (ringPt p θ) := by
  obtain ⟨δ, hδ, hS⟩ := h
  intro ε hε
  obtain ⟨t, ht0, htδ, htε, ht1⟩ : ∃ t : ℝ, 0 < t ∧ t < δ ∧ t < ε ∧ t ≤ 1 :=
    ⟨min (δ / 2) (min (ε / 2) 1), lt_min (by linarith) (lt_min (by linarith) one_pos),
      lt_of_le_of_lt (min_le_left _ _) (by linarith),
      lt_of_le_of_lt ((min_le_right _ _).trans (min_le_left _ _)) (by linarith),
      (min_le_right _ _).trans (min_le_right _ _)⟩
  have hsin : 0 < Real.sin (t / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [Real.pi_gt_three])
  have hchord : ringPt p (θ + s.sign * t) - ringPt p θ =
      ((2 * Real.sin (t / 2) : ℝ) : ℂ) * e (θ + s.sign * (π / 2 + t / 2)) := by
    cases s
    · have h1 := e_add_sub_e_sub (θ - t / 2) (-(t / 2))
      rw [show θ - t / 2 + -(t / 2) = θ + -1 * t by ring, show θ - t / 2 - -(t / 2) = θ by ring, Real.sin_neg] at h1
      have h2 : e (θ + -1 * (π / 2 + t / 2)) = e (θ - t / 2) * -I := by
        rw [show θ + -1 * (π / 2 + t / 2) = (θ - t / 2) + -(π / 2) by ring, e_add, e_neg, Real.cos_pi_div_two,
          Real.sin_pi_div_two]
        push_cast
        ring
      simp only [ringPt, Side.sign]
      rw [h2, show p + e (θ + -1 * t) - (p + e θ) = e (θ + -1 * t) - e θ by ring, h1]
      push_cast
      ring
    · have h1 := e_add_sub_e_sub (θ + t / 2) (t / 2)
      rw [show θ + t / 2 + t / 2 = θ + 1 * t by ring, show θ + t / 2 - t / 2 = θ by ring] at h1
      have h2 : e (θ + 1 * (π / 2 + t / 2)) = e (θ + t / 2) * I := by
        rw [show θ + 1 * (π / 2 + t / 2) = (θ + t / 2) + π / 2 by ring, e_add, e_pi_div_two]
      simp only [ringPt, Side.sign]
      rw [h2, show p + e (θ + 1 * t) - (p + e θ) = e (θ + 1 * t) - e θ by ring, h1]
  have hnorm : ‖ringPt p (θ + s.sign * t) - ringPt p θ‖ = 2 * Real.sin (t / 2) := by
    rw [hchord, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  refine ⟨ringPt p (θ + s.sign * t), hS ⟨t, ⟨ht0, htδ⟩, rfl⟩, fun heq => ?_, ?_, ?_⟩
  · rw [heq, sub_self, norm_zero] at hnorm
    linarith
  · rw [dist_comm]
    exact lt_of_le_of_lt (ArcMap.dist_ringPt_germ_le p θ s ht0.le) htε
  · rw [hnorm, hchord, mul_div_cancel_left₀ _ (by
      rw [Ne, Complex.ofReal_eq_zero]; linarith)]
    refine lt_of_le_of_lt (norm_e_sub_e_le _ _) ?_
    rw [show θ + s.sign * (π / 2 + t / 2) - (θ + s.sign * (π / 2)) = s.sign * (t / 2) by ring, abs_mul,
      abs_of_pos (by linarith : (0 : ℝ) < t / 2)]
    have : |s.sign| = 1 := by cases s <;> simp [Side.sign]
    rw [this]
    linarith

end HadwigerNelson.Plane
