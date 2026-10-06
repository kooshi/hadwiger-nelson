import Proofs.HadwigerNelson.Plane.Chord
namespace HadwigerNelson.Plane
open Complex Set Filter Topology Metric

/-- A function within `K (u − u₀)²` of the line of slope `c` through `(u₀, g u₀)`, near `u₀`, has derivative `c`
there. -/
theorem hasDerivAt_of_sq_bound {g : ℝ → ℝ} {u₀ c K ε : ℝ} (hε : 0 < ε)
    (hb : ∀ u, |u - u₀| < ε → |g u - g u₀ - c * (u - u₀)| ≤ K * (u - u₀) ^ 2) : HasDerivAt g c u₀ := by
  rw [hasDerivAt_iff_isLittleO_nhds_zero, Asymptotics.isLittleO_iff]
  intro c' hc'
  have hK : 0 < |K| + 1 := by positivity
  have hδ : 0 < min ε (c' / (|K| + 1)) := lt_min hε (div_pos hc' hK)
  filter_upwards [Metric.ball_mem_nhds (0 : ℝ) hδ] with t ht
  rw [mem_ball, dist_zero_right, Real.norm_eq_abs, lt_min_iff] at ht
  have h1 := hb (u₀ + t) (by rw [add_sub_cancel_left]; exact ht.1)
  rw [add_sub_cancel_left] at h1
  have h2 : |t| * (|K| + 1) < c' := (lt_div_iff₀ hK).1 ht.2
  rw [Real.norm_eq_abs, Real.norm_eq_abs, smul_eq_mul, mul_comm t c]
  have h3 : K * t ^ 2 ≤ |K| * (|t| * |t|) := by
    rw [← pow_two, sq_abs]
    exact mul_le_mul_of_nonneg_right (le_abs_self K) (sq_nonneg _)
  nlinarith [abs_nonneg t, abs_nonneg K, mul_nonneg (abs_nonneg t) (abs_nonneg K)]

/-- The two-disc inequality in graph coordinates gives a Lipschitz bound. -/
theorem abs_le_of_two_disc_bound {a b n₁ n₂ : ℝ} (hn₁ : |n₁| ≤ 1) (hn₂ : 1 / 2 ≤ n₂) (ha : |a| ≤ 1)
    (hb : |b| ≤ 1 / 2) (h : |n₁ * a + n₂ * b| ≤ (a ^ 2 + b ^ 2) / 2) : |b| ≤ 6 * |a| := by
  have h1 : n₂ * |b| ≤ |n₁| * |a| + (a ^ 2 + b ^ 2) / 2 := by
    have := abs_sub_abs_le_abs_sub (n₂ * b) (-(n₁ * a))
    rw [sub_neg_eq_add, add_comm, abs_mul, abs_neg, abs_mul, abs_of_pos (by linarith : (0 : ℝ) < n₂)] at this
    linarith
  have h2 : a ^ 2 = |a| * |a| := by rw [← pow_two, sq_abs]
  have h3 : b ^ 2 = |b| * |b| := by rw [← pow_two, sq_abs]
  nlinarith [abs_nonneg a, abs_nonneg b, abs_nonneg n₁, mul_nonneg (abs_nonneg a) (abs_nonneg n₁)]

/-- The two-disc inequality in graph coordinates gives the derivative of the graph: `g′ = −n₁/n₂`. -/
theorem hasDerivAt_of_two_disc_bound {g : ℝ → ℝ} {u₀ n₁ n₂ ε : ℝ} (hε : 0 < ε) (hn₁ : |n₁| ≤ 1)
    (hn₂ : 1 / 2 ≤ n₂) (hg : ∀ u, |u - u₀| < ε → |g u - g u₀| ≤ 1 / 2)
    (hb : ∀ u, |u - u₀| < ε →
      |n₁ * (u - u₀) + n₂ * (g u - g u₀)| ≤ ((u - u₀) ^ 2 + (g u - g u₀) ^ 2) / 2) :
    HasDerivAt g (-n₁ / n₂) u₀ := by
  have hn₂0 : 0 < n₂ := by linarith
  refine hasDerivAt_of_sq_bound (K := 37) (lt_min hε one_pos) fun u hu => ?_
  rw [lt_min_iff] at hu
  have hL := abs_le_of_two_disc_bound hn₁ hn₂ hu.2.le (hg u hu.1) (hb u hu.1)
  have h1 := hb u hu.1
  have h2 : g u - g u₀ - -n₁ / n₂ * (u - u₀) = (n₁ * (u - u₀) + n₂ * (g u - g u₀)) / n₂ := by
    field_simp; ring
  rw [h2, abs_div, abs_of_pos hn₂0, div_le_iff₀ hn₂0]
  have h3 : (g u - g u₀) ^ 2 ≤ 36 * (u - u₀) ^ 2 := by
    rw [← sq_abs (g u - g u₀), ← sq_abs (u - u₀)]
    nlinarith [abs_nonneg (g u - g u₀), abs_nonneg (u - u₀)]
  nlinarith [sq_nonneg (u - u₀)]

end HadwigerNelson.Plane
