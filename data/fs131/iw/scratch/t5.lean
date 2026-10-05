import Proofs.HadwigerNelson.Plane.Woodall.Collar
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

/-- The frame distance formula: the squared distance from `framePt v β x (κ x²/2)` to the point `v + ρ e(β + σπ/2 + τ)`. -/
theorem norm_sq_framePt_sub {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) (v : ℂ) (β κ ρ τ x : ℝ) :
    ‖framePt v β x (κ * x ^ 2 / 2) - (v + (ρ : ℂ) * e (β + σ * (π / 2) + τ))‖ ^ 2 =
      x ^ 2 * (1 - σ * κ * ρ * Real.cos τ) + 2 * σ * ρ * Real.sin τ * x + κ ^ 2 * x ^ 4 / 4 + ρ ^ 2 := by
  have hc : Real.cos (σ * (π / 2) + τ) = -σ * Real.sin τ ∧ Real.sin (σ * (π / 2) + τ) = σ * Real.cos τ := by
    rcases hσ with rfl | rfl
    · rw [one_mul, add_comm, Real.cos_add_pi_div_two, Real.sin_add_pi_div_two]; simp
    · rw [neg_one_mul, neg_add_eq_sub, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two]
      simp
  have h : framePt v β x (κ * x ^ 2 / 2) - (v + (ρ : ℂ) * e (β + σ * (π / 2) + τ)) =
      e β * (((x : ℂ) + ((κ * x ^ 2 / 2 : ℝ) : ℂ) * I) - (ρ : ℂ) * e (σ * (π / 2) + τ)) := by
    rw [framePt, add_assoc β, e_add β]; ring
  rw [h, norm_mul, norm_e, one_mul, Complex.sq_norm, Complex.normSq_apply, e_eq, hc.1, hc.2]
  simp only [Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  linear_combination (ρ ^ 2 * σ ^ 2) * Real.sin_sq_add_cos_sq τ + ρ ^ 2 * hσ2

end HadwigerNelson.Plane

namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

theorem collarAt_shadow_of_parabola' {S : Set ℂ} {v : ℂ} {β κ σ r : ℝ} (hσ : σ = 1 ∨ σ = -1) (hr : 0 < r)
    (hS : ∀ x ∈ Ioo 0 r, framePt v β x (κ * x ^ 2 / 2) ∈ S) :
    (σ * κ < 1 → CollarAt (shadow S) v .inner (β + σ * (π / 2))) ∧
      (1 < σ * κ → CollarAt (shadow S) v .outer (β + σ * (π / 2))) := by
  set w : ℝ → ℂ := fun x => framePt v β x (κ * x ^ 2 / 2) with hw
  set Q : ℝ → ℝ → ℝ → ℝ := fun ρ τ x =>
    x ^ 2 * (1 - σ * κ * ρ * Real.cos τ) + 2 * σ * ρ * Real.sin τ * x + κ ^ 2 * x ^ 4 / 4 + ρ ^ 2 with hQ
  have hwc : Continuous w := by simp only [hw, framePt]; fun_prop
  have hQc : ∀ ρ τ, Continuous (Q ρ τ) := fun ρ τ => by simp only [hQ]; fun_prop
  have hQcp : ∀ x, Continuous (fun p : ℝ × ℝ => Q p.1 p.2 x) := fun x => by simp only [hQ]; fun_prop
  have hQ0 : ∀ ρ τ, Q ρ τ 0 = ρ ^ 2 := by intro ρ τ; simp [hQ]
  -- the shadow from two points of the arc, one inside and one outside
  have hshadow : ∀ (z : ℂ) (x₀ : ℝ), 0 < x₀ → x₀ < r → (∃ x₁ ∈ Ioc 0 x₀, dist z (w x₁) < 1) →
      (∃ x₂ ∈ Ioc 0 x₀, 1 < dist z (w x₂)) → z ∈ shadow S := by
    rintro z x₀ h0 hr' ⟨x₁, hx₁, h1⟩ ⟨x₂, hx₂, h2⟩
    have hR : IsPreconnected (w '' Ioc 0 x₀) := isPreconnected_Ioc.image _ hwc.continuousOn
    obtain ⟨y, ⟨x, hx, rfl⟩, hy⟩ := mem_shadow_of_preconnected hR (mem_image_of_mem w hx₁) (mem_image_of_mem w hx₂) h1 h2
    exact ⟨w x, hS x ⟨hx.1, lt_of_le_of_lt hx.2 hr'⟩, hy⟩
  have hdist : ∀ ρ τ x : ℝ, dist (v + (ρ : ℂ) * e (β + σ * (π / 2) + τ)) (w x) ^ 2 = Q ρ τ x := by
    intro ρ τ x
    rw [dist_eq_norm, ← norm_neg, neg_sub]
    exact norm_sq_framePt_sub hσ v β κ ρ τ x
  -- small parameters on the arc
  have hsmall_lt : ∀ ρ τ x₀ : ℝ, 0 < x₀ → ρ ^ 2 < 1 → ∃ x₁ ∈ Ioc 0 x₀, Q ρ τ x₁ < 1 := by
    intro ρ τ x₀ hx₀ hρ
    have hev : ∀ᶠ x in 𝓝 (0 : ℝ), Q ρ τ x < 1 :=
      (hQc ρ τ).continuousAt.eventually_lt continuousAt_const (by rw [hQ0]; exact hρ)
    obtain ⟨δ, hδ, hd⟩ := Metric.eventually_nhds_iff.mp hev
    refine ⟨min x₀ (δ / 2), ⟨lt_min hx₀ (by positivity), min_le_left _ _⟩, hd ?_⟩
    rw [Real.dist_eq, sub_zero, abs_of_pos (lt_min hx₀ (by positivity))]
    exact lt_of_le_of_lt (min_le_right _ _) (by linarith)
  have hsmall_gt : ∀ ρ τ x₀ : ℝ, 0 < x₀ → 1 < ρ ^ 2 → ∃ x₁ ∈ Ioc 0 x₀, 1 < Q ρ τ x₁ := by
    intro ρ τ x₀ hx₀ hρ
    have hev : ∀ᶠ x in 𝓝 (0 : ℝ), 1 < Q ρ τ x :=
      continuousAt_const.eventually_lt (hQc ρ τ).continuousAt (by rw [hQ0]; exact hρ)
    obtain ⟨δ, hδ, hd⟩ := Metric.eventually_nhds_iff.mp hev
    refine ⟨min x₀ (δ / 2), ⟨lt_min hx₀ (by positivity), min_le_left _ _⟩, hd ?_⟩
    rw [Real.dist_eq, sub_zero, abs_of_pos (lt_min hx₀ (by positivity))]
    exact lt_of_le_of_lt (min_le_right _ _) (by linarith)
  constructor
  · intro hσκ
    set x₀ := r / 2 with hx₀
    have hx₀0 : 0 < x₀ := by positivity
    have hx₀r : x₀ < r := by linarith
    have hQ1 : (1 : ℝ) < Q 1 0 x₀ := by
      simp only [hQ, Real.cos_zero, Real.sin_zero]
      nlinarith [sq_nonneg (κ * x₀ ^ 2), sq_pos_of_pos hx₀0]
    have hev : ∀ᶠ p in 𝓝 ((1 : ℝ), (0 : ℝ)), 1 < Q p.1 p.2 x₀ :=
      continuousAt_const.eventually_lt (hQcp x₀).continuousAt hQ1
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp hev
    set h := min (ε / 2) (1 / 2) with hh
    have hh0 : 0 < h := lt_min (by positivity) (by norm_num)
    refine ⟨h, hh0, fun z hz => ?_⟩
    obtain ⟨ρ', hρ', θ', hθ', rfl⟩ := (mem_collar_iff _ _ _ _ _ _).mp hz
    have hρ'' : 1 - h < ρ' ∧ ρ' < 1 := hρ'
    set τ := θ' - (β + σ * (π / 2)) with hτ
    have hθ'τ : θ' = β + σ * (π / 2) + τ := by rw [hτ]; ring
    have hτh : |τ| < h := by rw [abs_lt]; constructor <;> linarith [hθ'.1, hθ'.2]
    have hρ0 : 0 < ρ' := by have : h ≤ 1 / 2 := min_le_right _ _; linarith [hρ''.1]
    have hpd : dist (ρ', τ) ((1 : ℝ), (0 : ℝ)) < ε := by
      rw [Prod.dist_eq, max_lt_iff, Real.dist_eq, Real.dist_eq]
      have : h ≤ ε / 2 := min_le_left _ _
      constructor
      · rw [abs_lt]; constructor <;> linarith [hρ''.1, hρ''.2]
      · rw [sub_zero]; linarith
    have hQout : 1 < Q ρ' τ x₀ := hball hpd
    rw [hθ'τ]
    refine hshadow _ x₀ hx₀0 hx₀r ?_ ⟨x₀, ⟨hx₀0, le_rfl⟩, ?_⟩
    · obtain ⟨x₁, hx₁, hlt⟩ := hsmall_lt ρ' τ x₀ hx₀0 (by nlinarith [hρ''.1, hρ''.2])
      refine ⟨x₁, hx₁, ?_⟩
      have := hdist ρ' τ x₁
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₁)]
    · have := hdist ρ' τ x₀
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₀)]
  · intro hσκ
    set m := σ * κ - 1 with hm
    have hm0 : 0 < m := by rw [hm]; linarith
    set x₀ := min (r / 2) (min 1 (m / (κ ^ 2 + 1))) with hx₀
    have hκ2 : 0 < κ ^ 2 + 1 := by positivity
    have hx₀0 : 0 < x₀ := lt_min (by positivity) (lt_min one_pos (by positivity))
    have hx₀r : x₀ < r := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hx₀1 : x₀ ≤ 1 := (min_le_right _ _).trans (min_le_left _ _)
    have hx₀m : x₀ * (κ ^ 2 + 1) ≤ m := by
      have : x₀ ≤ m / (κ ^ 2 + 1) := (min_le_right _ _).trans (min_le_right _ _)
      rwa [le_div_iff₀ hκ2] at this
    have hQ1 : Q 1 0 x₀ < 1 := by
      simp only [hQ, Real.cos_zero, Real.sin_zero]
      have h0 : x₀ ^ 2 ≤ x₀ := by nlinarith
      have h1 : κ ^ 2 * x₀ ^ 2 ≤ κ ^ 2 * x₀ := mul_le_mul_of_nonneg_left h0 (sq_nonneg κ)
      have h2 : κ ^ 2 * x₀ < m := by nlinarith
      have h3 : x₀ ^ 2 * (1 - σ * κ) + κ ^ 2 * x₀ ^ 4 / 4 < 0 := by
        have : x₀ ^ 2 * (-m + κ ^ 2 * x₀ ^ 2 / 4) < 0 := by
          apply mul_neg_of_pos_of_neg (by positivity)
          nlinarith
        nlinarith
      nlinarith
    have hev : ∀ᶠ p in 𝓝 ((1 : ℝ), (0 : ℝ)), Q p.1 p.2 x₀ < 1 :=
      (hQcp x₀).continuousAt.eventually_lt continuousAt_const hQ1
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp hev
    set h := min (ε / 2) 1 with hh
    have hh0 : 0 < h := lt_min (by positivity) one_pos
    refine ⟨h, hh0, fun z hz => ?_⟩
    obtain ⟨ρ', hρ', θ', hθ', rfl⟩ := (mem_collar_iff _ _ _ _ _ _).mp hz
    have hρ'' : 1 < ρ' ∧ ρ' < 1 + h := hρ'
    set τ := θ' - (β + σ * (π / 2)) with hτ
    have hθ'τ : θ' = β + σ * (π / 2) + τ := by rw [hτ]; ring
    have hτh : |τ| < h := by rw [abs_lt]; constructor <;> linarith [hθ'.1, hθ'.2]
    have hpd : dist (ρ', τ) ((1 : ℝ), (0 : ℝ)) < ε := by
      rw [Prod.dist_eq, max_lt_iff, Real.dist_eq, Real.dist_eq]
      have : h ≤ ε / 2 := min_le_left _ _
      constructor
      · rw [abs_lt]; constructor <;> linarith [hρ''.1, hρ''.2]
      · rw [sub_zero]; linarith
    have hQin : Q ρ' τ x₀ < 1 := hball hpd
    rw [hθ'τ]
    refine hshadow _ x₀ hx₀0 hx₀r ⟨x₀, ⟨hx₀0, le_rfl⟩, ?_⟩ ?_
    · have := hdist ρ' τ x₀
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₀)]
    · obtain ⟨x₂, hx₂, hgt⟩ := hsmall_gt ρ' τ x₀ hx₀0 (by nlinarith [hρ''.1])
      refine ⟨x₂, hx₂, ?_⟩
      have := hdist ρ' τ x₂
      nlinarith [dist_nonneg (x := v + (ρ' : ℂ) * e (β + σ * (π / 2) + τ)) (y := w x₂)]

end HadwigerNelson.Plane
