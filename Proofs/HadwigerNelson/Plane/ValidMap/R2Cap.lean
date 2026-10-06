import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
import Proofs.HadwigerNelson.Plane.ValidMap.BendAway

/-!
# The radius-2 circle over a constant-sided unit arc: the crescent, the dichotomy, the subdivision (FS131-KA1's skeleton)

What the away bend reads of the inner colour's class near the radius-2 arc `R₂(ᾱ)` over a constant-sided unit arc of a valid map
(`plans/FS131-bendaway-kernel-plan.md` § 3, lane C):

* `exists_r2_crescent_free` — the radius-2 form of `exists_end_free`: near a point of the domain on the radius-2 circle, the arcs of
  `Γ` in the crescent between the circles of radius `2(1 − τ)` and `2(1 + τ)` tangent there lie on the radius-2 circle.
* `r2_side_dichotomy` — on each side of a radius-2 point over the arc, the contacts are **all or none**, and in the "none" case the
  class stays off a disc of radius `ρ₀ > 2` tangent to the radius-2 circle at the point (FS131-E5 § 4.2's premise).
* `exists_r2Subdiv` — so `[θ₁, θ₂]` has a finite subdivision into contact pieces and gaps, when `R₂(ᾱ)` lies in the domain. **This is
  where a plane map is needed** (inventory items 290–291).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Near a radius-2 point, the arcs of `Γ` in the crescent hugging the radius-2 circle lie on it** (the radius-2 form of
`exists_end_free`, at any point `P + 2 e(θ_E)` of the domain and either side `σ`). Route: `exists_end_free`'s proof with the frame at
`P + 2 e(θ_E)`: `branch_transversal` applies as it stands (`R' = 2(1 − τ) > 1/2`, `R'' = 2(1 + τ) > 1`); `branch_tangent` applies to
the halved variables `(X/2, Y/2, s/2, 2κ)`, which turn the radius-2 crescent into the unit one. **Proved (FS131-BA2)** (child C1).
Inhabitant of the hypotheses: any point of a plane map. -/
theorem exists_r2_crescent_free (F : ArcMap k) {P : ℂ} {θE σ : ℝ} (hE : P + 2 * e θE ∈ F.dom) (hσ : σ = 1 ∨ σ = -1) :
    ∃ ρ > 0, ∃ τ₀ > 0, ∀ τ, 0 < τ → τ < τ₀ → ∀ z ∈ F.Γ, dist z (P + 2 * e θE) < ρ → ∀ X Y : ℝ,
      z - (P + 2 * e θE) = ((Y : ℂ) + (X : ℂ) * I) * e θE → 0 ≤ σ * X → 0 ≤ 2 * (2 * (1 - τ)) * Y + (X ^ 2 + Y ^ 2) →
        2 * (2 * (1 + τ)) * Y + (X ^ 2 + Y ^ 2) ≤ 0 → dist z P = 2 := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hE
  obtain ⟨s₀, hs₀, hs₀i⟩ := exists_pos_forall_le
    (fun i : Fin n => min (if Real.cos (G.β i - θE) = 0 then 1 else |Real.cos (G.β i - θE)| / (2 + |G.κ i|)) (1 / (1 + |G.κ i|)))
    (fun i => by
      have hκ := abs_nonneg (G.κ i)
      refine lt_min ?_ (by positivity)
      split_ifs with h
      · exact one_pos
      · exact div_pos (abs_pos.mpr h) (by positivity))
  obtain ⟨τ₀, hτ₀, hτ₀i⟩ := exists_pos_forall_le
    (fun i : Fin n => if σ * (2 * G.κ i) = 1 then 1 else |σ * (2 * G.κ i) - 1| / (|σ * (2 * G.κ i)| + 1))
    (fun i => by
      have hκ := abs_nonneg (σ * (2 * G.κ i))
      split_ifs with h
      · exact one_pos
      · exact div_pos (abs_pos.mpr (sub_ne_zero.mpr h)) (by positivity))
  refine ⟨min r₀ s₀, lt_min hC.pos hs₀, min (1 / 2) τ₀, lt_min (by norm_num) hτ₀, ?_⟩
  intro τ hτ hττ z hzΓ hzd X Y hz hσX h1 h2
  have hτ2 : τ < 1 / 2 := lt_of_lt_of_le hττ (min_le_left _ _)
  have hττ₀ : τ < τ₀ := lt_of_lt_of_le hττ (min_le_right _ _)
  -- on the radius-2 circle exactly when `4Y + N = 0`
  have hdP : dist z P ^ 2 = 4 * Y + (X ^ 2 + Y ^ 2) + 4 := by
    have hzP : z - P = ((Y : ℂ) + (X : ℂ) * I + 2) * e θE := by
      rw [add_mul, ← hz]; ring
    rw [dist_eq_norm, hzP, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
    simp
    ring
  suffices h : 4 * Y + (X ^ 2 + Y ^ 2) = 0 by
    rw [h, zero_add] at hdP
    have h0 := dist_nonneg (x := z) (y := P)
    nlinarith
  by_cases hzE : z = P + 2 * e θE
  · have h0 : ((Y : ℂ) + (X : ℂ) * I) * e θE = 0 := by rw [← hz, hzE, sub_self]
    have h0' : (Y : ℂ) + (X : ℂ) * I = 0 := (mul_eq_zero.mp h0).resolve_right (e_ne_zero θE)
    have hY0 : Y = 0 := by simpa using congrArg Complex.re h0'
    have hX0 : X = 0 := by simpa using congrArg Complex.im h0'
    rw [hY0, hX0]; ring
  · have hmem : z ∈ (F.Γ ∩ ball (P + 2 * e θE) r₀) \ {P + 2 * e θE} :=
      ⟨⟨hzΓ, lt_of_lt_of_le hzd (min_le_left _ _)⟩, hzE⟩
    rw [hC.branches] at hmem
    obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hmem
    have hds : dist (branchPt (P + 2 * e θE) (G.β i) (G.κ i) s) (P + 2 * e θE) = s := by
      rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]
    rw [hds] at hzd
    have hss₀ : s < s₀ := lt_of_lt_of_le hzd (min_le_right _ _)
    have hκs : |G.κ i| * s < 2 := lt_of_le_of_lt (mul_le_mul_of_nonneg_left hs.2.le (abs_nonneg _)) (hC.curv i)
    have hx1 : -1 < G.κ i * s / 2 ∧ G.κ i * s / 2 < 1 := by
      have := abs_lt.mp (show |G.κ i * s| < 2 by rw [abs_mul, abs_of_pos hs.1]; exact hκs)
      constructor <;> linarith [this.1, this.2]
    set a := Real.arcsin (G.κ i * s / 2) with ha
    have hsa : Real.sin a = G.κ i * s / 2 := Real.sin_arcsin hx1.1.le hx1.2.le
    have hca : 0 < Real.cos a :=
      Real.cos_pos_of_mem_Ioo ⟨Real.neg_pi_div_two_lt_arcsin.mpr hx1.1, Real.arcsin_lt_pi_div_two.mpr hx1.2⟩
    -- the frame coordinates of the branch point
    have hW : (Y : ℂ) + (X : ℂ) * I = (s : ℂ) * e (G.β i - θE + a) := by
      have h3 : ((Y : ℂ) + (X : ℂ) * I) * e θE = (s : ℂ) * e (G.β i + a) := by
        rw [← hz, branchPt]; ring
      have h4 : e (G.β i + a) = e (G.β i - θE + a) * e θE := by rw [← e_add]; congr 1; ring
      rw [h4, ← mul_assoc] at h3
      exact mul_right_cancel₀ (e_ne_zero θE) h3
    have hYe : Y = s * Real.cos (G.β i - θE + a) := by
      have := congrArg Complex.re hW
      simpa [re_e] using this
    have hXe : X = s * Real.sin (G.β i - θE + a) := by
      have := congrArg Complex.im hW
      simpa [im_e] using this
    rw [Real.cos_add] at hYe
    rw [Real.sin_add] at hXe
    have hN : X ^ 2 + Y ^ 2 = s ^ 2 := by
      rw [hXe, hYe]
      linear_combination s ^ 2 * (Real.cos a ^ 2 + Real.sin a ^ 2) * Real.sin_sq_add_cos_sq (G.β i - θE) +
        s ^ 2 * Real.sin_sq_add_cos_sq a
    have hs₀' := hs₀i i
    have hs2 : s * (1 + |G.κ i|) < 1 := by
      have h5 : s < 1 / (1 + |G.κ i|) := lt_of_lt_of_le hss₀ (hs₀'.trans (min_le_right _ _))
      rwa [lt_div_iff₀ (by positivity)] at h5
    by_cases hgx : Real.cos (G.β i - θE) = 0
    · -- along the tangent: the halved variables turn the radius-2 crescent into the unit one
      have hgy : Real.sin (G.β i - θE) = 1 ∨ Real.sin (G.β i - θE) = -1 := by
        have h5 := Real.sin_sq_add_cos_sq (G.β i - θE)
        rw [hgx] at h5
        have h6 : (Real.sin (G.β i - θE) - 1) * (Real.sin (G.β i - θE) + 1) = 0 := by ring_nf; linarith
        rcases mul_eq_zero.mp h6 with h | h
        · exact Or.inl (by linarith)
        · exact Or.inr (by linarith)
      rw [hgx] at hYe hXe
      have hkey : 2 * (Y / 2) + ((X / 2) ^ 2 + (Y / 2) ^ 2) = 0 := by
        refine branch_tangent (κ := 2 * G.κ i) (s := s / 2) (sa := Real.sin a) hgy hσ (by linarith [hs.1]) hca
          (by rw [hsa]; ring) (by rw [hXe]; ring) (by rw [hYe]; ring) (by linear_combination hN / 4)
          (by linarith) hτ ?_ (by linarith) (by linarith)
        by_cases hv : σ * (2 * G.κ i) = 1
        · exact Or.inl hv
        · right
          have h5 := hτ₀i i
          simp only [if_neg hv] at h5
          have h6 : τ < |σ * (2 * G.κ i) - 1| / (|σ * (2 * G.κ i)| + 1) := lt_of_lt_of_le hττ₀ h5
          rwa [lt_div_iff₀ (by positivity)] at h6
      linarith
    · -- across the tangent
      exfalso
      have h5 : s < |Real.cos (G.β i - θE)| / (2 + |G.κ i|) := by
        have h6 := hs₀'.trans (min_le_left _ _)
        simp only [if_neg hgx] at h6
        exact lt_of_lt_of_le hss₀ h6
      rw [lt_div_iff₀ (by positivity)] at h5
      exact branch_transversal (gy := Real.sin (G.β i - θE)) (Real.cos_sq_add_sin_sq _) hs.1 h5 hs2 hca
        (Real.cos_sq_add_sin_sq a) hsa hYe hN (show (1 : ℝ) / 2 < 2 * (1 - τ) by linarith)
        (show (1 : ℝ) < 2 * (1 + τ) by linarith) h1 h2

/-! ## The frame at a radius-2 point, and the half-crescent on one side (helpers of `r2_side_dichotomy`) -/

end ArcMap

/-- The tangential frame coordinate of `z` at the radius-2 point `P + 2 e(θ₀)` (along `i e(θ₀)`, the direction of increasing angle). -/
noncomputable def r2X (P : ℂ) (θ₀ : ℝ) (z : ℂ) : ℝ := ((z - (P + 2 * e θ₀)) * starRingEnd ℂ (e θ₀)).im

/-- The radial frame coordinate of `z` at the radius-2 point `P + 2 e(θ₀)` (along `e(θ₀)`, away from `P`). -/
noncomputable def r2Y (P : ℂ) (θ₀ : ℝ) (z : ℂ) : ℝ := ((z - (P + 2 * e θ₀)) * starRingEnd ℂ (e θ₀)).re

/-- Spec: at `P = 0`, `θ₀ = 0` the frame is the plane's own, moved to `2`: the point `2 + i` has coordinates `(X, Y) = (1, 0)`. -/
example : r2X 0 0 (2 + I) = 1 ∧ r2Y 0 0 (2 + I) = 0 := by simp [r2X, r2Y, e_zero]

theorem conj_e_mul_e' (θ : ℝ) : starRingEnd ℂ (e θ) * e θ = 1 := by
  rw [mul_comm, conj_e_mul_e]

/-- A point from its frame coordinates. -/
theorem r2_frame (P : ℂ) (θ₀ : ℝ) (z : ℂ) :
    z - (P + 2 * e θ₀) = ((r2Y P θ₀ z : ℂ) + (r2X P θ₀ z : ℂ) * I) * e θ₀ := by
  rw [r2X, r2Y, Complex.re_add_im, mul_assoc, conj_e_mul_e', mul_one]

/-- The frame coordinates of a point given by them. -/
theorem r2_coords (P : ℂ) (θ₀ X Y : ℝ) :
    r2X P θ₀ (P + 2 * e θ₀ + ((Y : ℂ) + (X : ℂ) * I) * e θ₀) = X ∧
      r2Y P θ₀ (P + 2 * e θ₀ + ((Y : ℂ) + (X : ℂ) * I) * e θ₀) = Y := by
  have h : (P + 2 * e θ₀ + ((Y : ℂ) + (X : ℂ) * I) * e θ₀ - (P + 2 * e θ₀)) * starRingEnd ℂ (e θ₀) = (Y : ℂ) + (X : ℂ) * I := by
    rw [add_sub_cancel_left, mul_assoc, conj_e_mul_e, mul_one]
  rw [r2X, r2Y, h]
  simp

/-- **Distances along the normal line in the frame**: the squared distance from `z` to `P + (2 − a) e(θ₀)` is `a² + 2aY + (X² + Y²)`
(`a = 0`: the radius-2 point; `a = 2`: `P`; `a = ρ₀`: the centre of the circle of radius `ρ₀` tangent there from `P`'s side). -/
theorem r2_dist_sq (P : ℂ) (θ₀ a : ℝ) (z : ℂ) :
    dist z (P + ((2 - a : ℝ) : ℂ) * e θ₀) ^ 2 = a ^ 2 + 2 * a * r2Y P θ₀ z + (r2X P θ₀ z ^ 2 + r2Y P θ₀ z ^ 2) := by
  have hz : z - (P + ((2 - a : ℝ) : ℂ) * e θ₀) = ((r2Y P θ₀ z : ℂ) + (r2X P θ₀ z : ℂ) * I + (a : ℂ)) * e θ₀ := by
    rw [add_mul, ← r2_frame]; push_cast; ring
  rw [dist_eq_norm, hz, norm_mul, norm_e, mul_one, Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_re, Complex.mul_im, Complex.I_re,
    Complex.I_im]
  ring

theorem r2_dist_sq_base (P : ℂ) (θ₀ : ℝ) (z : ℂ) : dist z (P + 2 * e θ₀) ^ 2 = r2X P θ₀ z ^ 2 + r2Y P θ₀ z ^ 2 := by
  have := r2_dist_sq P θ₀ 0 z
  simpa using this

theorem r2_dist_sq_center (P : ℂ) (θ₀ : ℝ) (z : ℂ) : dist z P ^ 2 = 4 + 4 * r2Y P θ₀ z + (r2X P θ₀ z ^ 2 + r2Y P θ₀ z ^ 2) := by
  have := r2_dist_sq P θ₀ 2 z
  simp only [sub_self, Complex.ofReal_zero, zero_mul, add_zero] at this
  rw [this]; ring

/-- The tangential coordinate read from `P`. -/
theorem r2X_eq (P : ℂ) (θ₀ : ℝ) (z : ℂ) : r2X P θ₀ z = ((z - P) * starRingEnd ℂ (e θ₀)).im := by
  have h : (z - (P + 2 * e θ₀)) * starRingEnd ℂ (e θ₀) = (z - P) * starRingEnd ℂ (e θ₀) - 2 := by
    rw [show z - (P + 2 * e θ₀) = (z - P) - 2 * e θ₀ by ring, sub_mul, mul_assoc, conj_e_mul_e, mul_one]
  rw [r2X, h]
  simp

/-- The frame coordinates of a radius-2 point. -/
theorem r2_coords_r2 (P : ℂ) (θ₀ u : ℝ) :
    r2X P θ₀ (P + 2 * e (θ₀ + u)) = 2 * Real.sin u ∧ r2Y P θ₀ (P + 2 * e (θ₀ + u)) = 2 * (Real.cos u - 1) := by
  have h : (P + 2 * e (θ₀ + u) - (P + 2 * e θ₀)) * starRingEnd ℂ (e θ₀) = 2 * e u - 2 := by
    rw [e_add, show P + 2 * (e θ₀ * e u) - (P + 2 * e θ₀) = (2 * e u - 2) * e θ₀ by ring, mul_assoc, conj_e_mul_e, mul_one]
  rw [r2X, r2Y, h]
  simp [re_e, im_e]
  ring

theorem continuous_r2X (P : ℂ) (θ₀ : ℝ) : Continuous (r2X P θ₀) := by
  unfold r2X; fun_prop

theorem continuous_r2Y (P : ℂ) (θ₀ : ℝ) : Continuous (r2Y P θ₀) := by
  unfold r2Y; fun_prop

/-- **The side of a radius-2 point under a tangent circle** (an open set): the points on the side `σ` of the normal line, within `x₁`
of it, with `Y > −1`, strictly inside the circle of radius `ρ₀` tangent to the radius-2 circle at the point from `P`'s side. Its part
outside the radius-2 circle is the open half-crescent. -/
def r2Side (P : ℂ) (θ₀ σ ρ₀ x₁ : ℝ) : Set ℂ :=
  {z | 0 < σ * r2X P θ₀ z ∧ σ * r2X P θ₀ z < x₁ ∧ -1 < r2Y P θ₀ z ∧
    2 * ρ₀ * r2Y P θ₀ z + (r2X P θ₀ z ^ 2 + r2Y P θ₀ z ^ 2) < 0}

/-- Spec: at `P = 0`, `θ₀ = 0`, `ρ₀ = 3` the point `2 − 1/100 + i/10` (frame coordinates `(1/10, −1/100)`) lies on the side `+1`. -/
example : (2 - 1 / 100 + (1 / 10 : ℂ) * I) ∈ r2Side 0 0 1 3 (1 / 2) := by
  have hX : r2X 0 0 (2 - 1 / 100 + (1 / 10 : ℂ) * I) = 1 / 10 := by simp [r2X, e_zero]
  have hY : r2Y 0 0 (2 - 1 / 100 + (1 / 10 : ℂ) * I) = -1 / 100 := by simp [r2Y, e_zero]; norm_num
  rw [r2Side, Set.mem_setOf_eq, hX, hY]
  norm_num

theorem isOpen_r2Side (P : ℂ) (θ₀ σ ρ₀ x₁ : ℝ) : IsOpen (r2Side P θ₀ σ ρ₀ x₁) := by
  have hX := continuous_r2X P θ₀
  have hY := continuous_r2Y P θ₀
  refine (isOpen_lt continuous_const (continuous_const.mul hX)).and ((isOpen_lt (continuous_const.mul hX) continuous_const).and
    ((isOpen_lt continuous_const hY).and (isOpen_lt ?_ continuous_const)))
  fun_prop

/-- Outside the radius-2 circle, in the frame. -/
theorem two_lt_dist_iff (P : ℂ) (θ₀ : ℝ) (z : ℂ) :
    2 < dist z P ↔ 0 < 4 * r2Y P θ₀ z + (r2X P θ₀ z ^ 2 + r2Y P θ₀ z ^ 2) := by
  have h := r2_dist_sq_center P θ₀ z
  have h0 := dist_nonneg (x := z) (y := P)
  constructor <;> intro h1 <;> nlinarith

/-- **The open half-crescent lies within `2 x₁` of the radius-2 point.** -/
theorem dist_lt_of_mem_r2Crescent {P : ℂ} {θ₀ σ ρ₀ x₁ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hρ₀ : 0 < ρ₀) (hx₁ : 0 < x₁) (hx₁1 : x₁ ≤ 1)
    {z : ℂ} (hz : z ∈ r2Side P θ₀ σ ρ₀ x₁ ∩ {z | 2 < dist z P}) : dist z (P + 2 * e θ₀) < 2 * x₁ := by
  obtain ⟨⟨h1, h2, h3, h4⟩, h5⟩ := hz
  have h5' := (two_lt_dist_iff P θ₀ z).mp h5
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hX2 : r2X P θ₀ z ^ 2 < x₁ ^ 2 := by
    have : (σ * r2X P θ₀ z) ^ 2 < x₁ ^ 2 := by nlinarith
    rwa [mul_pow, hσ2, one_mul] at this
  have hY0 : r2Y P θ₀ z < 0 := by nlinarith [sq_nonneg (r2X P θ₀ z), sq_nonneg (r2Y P θ₀ z)]
  have hY1 : -(r2Y P θ₀ z) * 3 < r2X P θ₀ z ^ 2 := by nlinarith
  have hY2 : r2Y P θ₀ z ^ 2 < x₁ ^ 2 := by nlinarith
  have hd := r2_dist_sq_base P θ₀ z
  have h0 := dist_nonneg (x := z) (y := P + 2 * e θ₀)
  nlinarith

/-- **The open half-crescent is connected**: each of its slices `X = const` is an interval in `Y`, and the parabola
`Y = −X²/(4 + 2τ)` runs through all of them. -/
theorem isPreconnected_r2Crescent {P : ℂ} {θ₀ σ τ x₁ : ℝ} (hσ : σ = 1 ∨ σ = -1) (hτ : 0 < τ) (hx₁ : 0 < x₁) (hx₁τ : x₁ ≤ τ)
    (hτ1 : τ ≤ 1 / 2) : IsPreconnected (r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P}) := by
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  -- membership through the frame coordinates
  have hmem : ∀ X Y : ℝ, P + 2 * e θ₀ + ((Y : ℂ) + (X : ℂ) * I) * e θ₀ ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P} ↔
      (0 < σ * X ∧ σ * X < x₁ ∧ -1 < Y ∧ 2 * (2 * (1 + τ)) * Y + (X ^ 2 + Y ^ 2) < 0) ∧ 0 < 4 * Y + (X ^ 2 + Y ^ 2) := by
    intro X Y
    obtain ⟨hX, hY⟩ := r2_coords P θ₀ X Y
    rw [Set.mem_inter_iff, Set.mem_setOf_eq, two_lt_dist_iff P θ₀, r2Side, Set.mem_setOf_eq, hX, hY]
  have hpt : ∀ z : ℂ, z = P + 2 * e θ₀ + ((r2Y P θ₀ z : ℂ) + (r2X P θ₀ z : ℂ) * I) * e θ₀ := fun z => by
    rw [← r2_frame]; ring
  -- the spine
  have hspine : ∀ ξ ∈ Ioo (0 : ℝ) x₁, P + 2 * e θ₀ + (((-ξ ^ 2 / (4 + 2 * τ) : ℝ) : ℂ) + ((σ * ξ : ℝ) : ℂ) * I) * e θ₀ ∈
      r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P} := by
    intro ξ hξ
    rw [hmem]
    have hm : (4 + 2 * τ) * (-ξ ^ 2 / (4 + 2 * τ)) = -ξ ^ 2 := by field_simp
    set m := -ξ ^ 2 / (4 + 2 * τ) with hmdef
    have hξ2 : 0 < ξ ^ 2 := by have := hξ.1; positivity
    have hm0 : m < 0 := by nlinarith
    have hξτ : ξ ^ 2 < τ ^ 2 := by nlinarith [hξ.1, hξ.2]
    have hm1 : -(2 * τ) < m := by nlinarith
    have hσξ : σ * (σ * ξ) = ξ := by rw [← mul_assoc, hσ2, one_mul]
    have hσξ2 : (σ * ξ) ^ 2 = ξ ^ 2 := by rw [mul_pow, pow_two σ, hσ2, one_mul]
    rw [hσξ, hσξ2]
    refine ⟨⟨hξ.1, hξ.2, by nlinarith, by nlinarith⟩, by nlinarith⟩
  have hbase : (x₁ / 2) ∈ Ioo (0 : ℝ) x₁ := ⟨by linarith, by linarith⟩
  refine isPreconnected_of_forall (P + 2 * e θ₀ + (((-(x₁ / 2) ^ 2 / (4 + 2 * τ) : ℝ) : ℂ) + ((σ * (x₁ / 2) : ℝ) : ℂ) * I) * e θ₀)
    fun z hz => ?_
  set X := r2X P θ₀ z with hXdef
  set Y := r2Y P θ₀ z with hYdef
  have hzXY := hpt z
  rw [← hXdef, ← hYdef] at hzXY
  have hzc := hz
  rw [hzXY, hmem] at hzc
  obtain ⟨⟨c1, c2, c3, c4⟩, c5⟩ := hzc
  have hξ : σ * X ∈ Ioo (0 : ℝ) x₁ := ⟨c1, c2⟩
  have hXσ : σ * (σ * X) = X := by rw [← mul_assoc, hσ2, one_mul]
  have hsp := hspine (σ * X) hξ
  rw [hXσ] at hsp
  have hspc := hsp
  rw [hmem] at hspc
  obtain ⟨⟨-, -, s3, s4⟩, s5⟩ := hspc
  refine ⟨(fun ξ : ℝ => P + 2 * e θ₀ + (((-ξ ^ 2 / (4 + 2 * τ) : ℝ) : ℂ) + ((σ * ξ : ℝ) : ℂ) * I) * e θ₀) '' Ioo 0 x₁ ∪
      (fun t : ℝ => P + 2 * e θ₀ + ((t : ℂ) + (X : ℂ) * I) * e θ₀) '' uIcc (-(σ * X) ^ 2 / (4 + 2 * τ)) Y, ?_, ?_, ?_, ?_⟩
  · rintro _ (⟨ξ, hξ', rfl⟩ | ⟨t, ht, rfl⟩)
    · exact hspine ξ hξ'
    · rw [hmem]
      have hτ' : 0 < 2 * (1 + τ) := by linarith
      rcases Set.mem_uIcc.mp ht with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · refine ⟨⟨c1, c2, by linarith, ?_⟩, ?_⟩
        · nlinarith [mul_nonneg (sub_nonneg.mpr h2) (by linarith : (0 : ℝ) ≤ Y + t + 2 * (2 * (1 + τ)))]
        · nlinarith [mul_nonneg (sub_nonneg.mpr h1) (by linarith : (0 : ℝ) ≤ t + -(σ * X) ^ 2 / (4 + 2 * τ) + 4)]
      · refine ⟨⟨c1, c2, by linarith, ?_⟩, ?_⟩
        · nlinarith [mul_nonneg (sub_nonneg.mpr h2) (by linarith : (0 : ℝ) ≤ -(σ * X) ^ 2 / (4 + 2 * τ) + t + 2 * (2 * (1 + τ)))]
        · nlinarith [mul_nonneg (sub_nonneg.mpr h1) (by linarith : (0 : ℝ) ≤ t + Y + 4)]
  · exact Or.inl ⟨x₁ / 2, hbase, rfl⟩
  · exact Or.inr ⟨Y, right_mem_uIcc, hzXY.symm⟩
  · have hcont1 : Continuous fun ξ : ℝ => P + 2 * e θ₀ + (((-ξ ^ 2 / (4 + 2 * τ) : ℝ) : ℂ) + ((σ * ξ : ℝ) : ℂ) * I) * e θ₀ := by
      fun_prop
    have hcont2 : Continuous fun t : ℝ => P + 2 * e θ₀ + ((t : ℂ) + (X : ℂ) * I) * e θ₀ := by fun_prop
    refine IsPreconnected.union (P + 2 * e θ₀ + (((-(σ * X) ^ 2 / (4 + 2 * τ) : ℝ) : ℂ) + (X : ℂ) * I) * e θ₀) ?_ ?_
      (isPreconnected_Ioo.image _ hcont1.continuousOn) (isPreconnected_uIcc.image _ hcont2.continuousOn)
    · exact ⟨σ * X, hξ, by dsimp only; rw [hXσ]⟩
    · exact ⟨_, left_mem_uIcc, rfl⟩

/-- **The radius-2 points next to the base point on the side `σ` lie on that side under the tangent circle.** -/
theorem r2pt_mem_r2Side {P : ℂ} {θ₀ σ τ x₁ t : ℝ} (hσ : σ = 1 ∨ σ = -1) (hτ : 0 < τ) (hx₁1 : x₁ ≤ 1 / 2) (ht : t ∈ Ioo 0 (x₁ / 2)) :
    P + 2 * e (θ₀ + σ * t) ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ := by
  obtain ⟨hX, hY⟩ := r2_coords_r2 P θ₀ (σ * t)
  have hπ := Real.pi_gt_three
  have hsin : Real.sin (σ * t) = σ * Real.sin t := by rcases hσ with rfl | rfl <;> simp
  have hcos : Real.cos (σ * t) = Real.cos t := by rcases hσ with rfl | rfl <;> simp
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hs0 : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht.1 (by linarith [ht.2])
  have hs1 : Real.sin t < t := Real.sin_lt ht.1
  have hc0 : 1 - t ^ 2 / 2 ≤ Real.cos t := Real.one_sub_sq_div_two_le_cos
  have hc1 : Real.cos t < 1 := cos_lt_one_of_abs (by rw [abs_pos]; exact ht.1.ne') (by rw [abs_of_pos ht.1]; linarith [ht.2])
  have hsc := Real.sin_sq_add_cos_sq t
  have hσX : σ * (2 * (σ * Real.sin t)) = 2 * Real.sin t := by rw [mul_left_comm, ← mul_assoc σ σ, hσ2, one_mul]
  have hXsq : (2 * (σ * Real.sin t)) ^ 2 = 4 * Real.sin t ^ 2 := by
    rw [mul_pow, mul_pow, pow_two σ, hσ2]; ring
  rw [r2Side, Set.mem_setOf_eq, hX, hY, hsin, hcos, hσX, hXsq]
  refine ⟨by linarith, by linarith [ht.2], by nlinarith [ht.1, ht.2], by nlinarith⟩

/-- The points at distance at least `a` from `P` are limits of points farther than `a`. -/
theorem mem_closure_dist_gt {y P : ℂ} {a : ℝ} (ha : 0 < a) (h : a ≤ dist y P) : y ∈ closure {z : ℂ | a < dist z P} := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  have hs : 0 < dist y P := ha.trans_le h
  have hq : ε / (2 * dist y P) * dist y P = ε / 2 := by field_simp
  refine ⟨P + ((1 + ε / (2 * dist y P) : ℝ) : ℂ) * (y - P), ?_, ?_⟩
  · show a < dist _ P
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by positivity), ← dist_eq_norm]
    nlinarith
  · rw [dist_eq_norm, show y - (P + ((1 + ε / (2 * dist y P) : ℝ) : ℂ) * (y - P)) = -(((ε / (2 * dist y P) : ℝ) : ℂ) * (y - P)) by
      push_cast; ring, norm_neg, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by positivity), ← dist_eq_norm]
    linarith

/-- **The point one unit under `y` toward `P`**: for `y` at distance `s ≥ 1` from `P`, the point `x = P + (1 − 1/s)(y − P)` is at
distance `1` from `y`, at distance `s − 1` from `P`, and within twice `|y − (P + 2 e(β))|` of the ring point `r(β)`. -/
theorem under_point {y P : ℂ} (β : ℝ) (hs : 1 ≤ dist y P) :
    dist y (P + ((1 - 1 / dist y P : ℝ) : ℂ) * (y - P)) = 1 ∧
      dist (P + ((1 - 1 / dist y P : ℝ) : ℂ) * (y - P)) P = dist y P - 1 ∧
      dist (P + ((1 - 1 / dist y P : ℝ) : ℂ) * (y - P)) (ringPt P β) ≤ 2 * dist y (P + 2 * e β) := by
  have hs0 : 0 < dist y P := by linarith
  have hsn : ‖y - P‖ = dist y P := (dist_eq_norm y P).symm
  have h1s : 0 ≤ 1 - 1 / dist y P := by rw [sub_nonneg, div_le_one hs0]; exact hs
  refine ⟨?_, ?_, ?_⟩
  · rw [dist_eq_norm, show y - (P + ((1 - 1 / dist y P : ℝ) : ℂ) * (y - P)) = ((1 / dist y P : ℝ) : ℂ) * (y - P) by push_cast; ring,
      norm_mul, Complex.norm_real, Real.norm_of_nonneg (by positivity), hsn]
    field_simp
  · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_of_nonneg h1s, hsn]
    field_simp
  · set v := y - (P + 2 * e β) with hv
    have hyP : y - P = v + 2 * e β := by rw [hv]; ring
    have hkey : P + ((1 - 1 / dist y P : ℝ) : ℂ) * (y - P) - ringPt P β =
        ((1 - 1 / dist y P : ℝ) : ℂ) * v + ((1 - 2 / dist y P : ℝ) : ℂ) * e β := by
      rw [ringPt, hyP]; push_cast; ring
    have h2 : |dist y P - 2| ≤ ‖v‖ := by
      have := abs_norm_sub_norm_le (v + 2 * e β) (2 * e β)
      rw [add_sub_cancel_right, ← hyP, hsn, norm_mul, norm_e, mul_one] at this
      simpa using this
    have h3 : |1 - 2 / dist y P| ≤ ‖v‖ := by
      have : 1 - 2 / dist y P = (dist y P - 2) / dist y P := by field_simp
      rw [this, abs_div, abs_of_pos hs0, div_le_iff₀ hs0]
      nlinarith [norm_nonneg v]
    have h4 : 1 - 1 / dist y P ≤ 1 := by
      have : 0 ≤ 1 / dist y P := by positivity
      linarith
    have hdv : dist y (P + 2 * e β) = ‖v‖ := dist_eq_norm _ _
    rw [dist_eq_norm, hkey, hdv]
    calc ‖((1 - 1 / dist y P : ℝ) : ℂ) * v + ((1 - 2 / dist y P : ℝ) : ℂ) * e β‖
        ≤ ‖((1 - 1 / dist y P : ℝ) : ℂ) * v‖ + ‖((1 - 2 / dist y P : ℝ) : ℂ) * e β‖ := norm_add_le _ _
      _ = (1 - 1 / dist y P) * ‖v‖ + |1 - 2 / dist y P| := by
          rw [norm_mul, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_of_nonneg h1s, norm_e, mul_one, Real.norm_eq_abs]
      _ ≤ 2 * ‖v‖ := by nlinarith [norm_nonneg v]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Near an interior point of a constant-sided unit arc, the inside of `ω(P)` lies in the closure of the inner colour's class**:
the other classes' parts inside `ω(P)` stay off a ball about the point (`innerColours = {c}`), and interior points are dense. -/
theorem IsRingArc.exists_inner_ball {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {θ : ℝ}
    (hθ : θ ∈ Ioo θ₁ θ₂) : ∃ r > 0, closure (ball (ringPt P θ) r ∩ ball P 1) ⊆ closure (F.region c) := by
  have hin := (hA.2.2 θ hθ).1
  have hcl1 : IsClosed (⋃ j ∈ {j : Fin k | j ≠ c}, closure (F.region j ∩ ball P 1)) :=
    (Set.toFinite _).isClosed_biUnion fun j _ => isClosed_closure
  have hx1 : ringPt P θ ∉ ⋃ j ∈ {j : Fin k | j ≠ c}, closure (F.region j ∩ ball P 1) := by
    intro h
    obtain ⟨j, hj, hxj⟩ := mem_iUnion₂.mp h
    have : j ∈ F.innerColours P (ringPt P θ) := hxj
    rw [hin] at this
    exact hj this
  obtain ⟨r₁, hr₁, hb₁⟩ := Metric.isOpen_iff.mp hcl1.isOpen_compl _ hx1
  have hΓ : ringPt P θ ∈ F.Γ := hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  obtain ⟨r₂, hr₂, hb₂⟩ := Metric.isOpen_iff.mp F.isOpen_dom _ hΓ.1
  refine ⟨min r₁ r₂, lt_min hr₁ hr₂, closure_minimal (fun z hz => ?_) isClosed_closure⟩
  have hO : IsOpen (ball (ringPt P θ) (min r₁ r₂) ∩ ball P 1) := isOpen_ball.inter isOpen_ball
  have hzd : z ∈ F.dom := hb₂ (ball_subset_ball (min_le_right _ _) hz.1)
  refine closure_mono ?_ (hO.inter_closure ⟨hz, F.dense_interiorPts hzd⟩)
  rintro y ⟨⟨hy1, hy2⟩, hyI⟩
  refine ⟨hyI, ?_⟩
  by_contra hne
  exact hb₁ (ball_subset_ball (min_le_left _ _) hy1) (mem_iUnion₂.mpr ⟨F.col y, hne, subset_closure ⟨⟨hyI, rfl⟩, hy2⟩⟩)

/-- **All or none**: over a constant-sided unit arc of a valid map, at a radius-2 point `w₀ = P + 2 e(θ₀)` of the domain and on a
side `σ` on which the arc continues (`θ₀ + σ δ₀ ∈ [θ₁, θ₂]`), either every nearby radius-2 point on that side is a contact of the
inner colour's class, or none is and the class's points near `w₀` on that side that are not inside the radius-2 circle lie off the disc
of radius `ρ₀ > 2` tangent to it at `w₀` from `P`'s side (centre `P + (2 − ρ₀) e(θ₀)`). Route: the open crescent between the
radius-2 circle and the circle of radius `2(1 + τ)` on that side is free of `Γ` (`exists_r2_crescent_free`), connected and in the
domain, so of one colour `j`; a radius-2 point `w` next to `w₀` on that side has a neighbourhood whose part outside the radius-2 circle
is in the crescent and whose part inside or on it misses the class (inside by `ne1_region` against the inner side of the arc near
`r(θ)`, an interior point of the arc; on the circle because the class is open), so `w` is a contact iff `j = c`. **Proved (FS131-BA2)** (child C2). Inhabitant of the
hypotheses: owed with the away bend's model (plan § 5). -/
theorem r2_side_dichotomy (hF : F.Valid) {P : ℂ} {θ₁ θ₂ θ₀ σ δ₀ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hσ : σ = 1 ∨ σ = -1) (hθ₀ : θ₀ ∈ Icc θ₁ θ₂) (hδ₀ : 0 < δ₀) (hside : θ₀ + σ * δ₀ ∈ Icc θ₁ θ₂)
    (hw : P + 2 * e θ₀ ∈ F.dom) :
    ∃ δ > 0, ∃ η > 0, ∃ ρ₀ > 2,
      (∀ t ∈ Ioo 0 δ, P + 2 * e (θ₀ + σ * t) ∈ closure (F.region c)) ∨
      ((∀ t ∈ Ioo 0 δ, P + 2 * e (θ₀ + σ * t) ∉ closure (F.region c)) ∧
        ∀ y ∈ F.region c, dist y (P + 2 * e θ₀) < η → 0 < σ * ((y - P) * starRingEnd ℂ (e θ₀)).im → 2 ≤ dist y P →
          ρ₀ ≤ dist y (P + ((2 - ρ₀ : ℝ) : ℂ) * e θ₀)) := by
  obtain ⟨ρc, hρc, τ₀, hτ₀, hC1⟩ := exists_r2_crescent_free F hw hσ
  obtain ⟨ρd, hρd, hballd⟩ := Metric.isOpen_iff.mp F.isOpen_dom _ hw
  -- the parameters: the tangent circle's radius `2(1 + τ)`, the crescent's width `x₁`
  obtain ⟨τ, hτ, hττ₀, hτ1⟩ : ∃ τ : ℝ, 0 < τ ∧ τ < τ₀ ∧ τ ≤ 1 / 2 :=
    ⟨min τ₀ 1 / 2, by have := lt_min hτ₀ one_pos; linarith, by have := min_le_left τ₀ 1; have := lt_min hτ₀ one_pos; linarith,
      by have := min_le_right τ₀ 1; linarith⟩
  obtain ⟨x₁, hx₁, hx₁τ, hx₁c, hx₁d⟩ : ∃ x₁ : ℝ, 0 < x₁ ∧ x₁ ≤ τ ∧ 2 * x₁ ≤ ρc ∧ 2 * x₁ ≤ ρd :=
    ⟨min (min ρc ρd / 2) τ, lt_min (by have := lt_min hρc hρd; linarith) hτ, min_le_right _ _,
      by have := min_le_left (min ρc ρd / 2) τ; have := min_le_left ρc ρd; linarith,
      by have := min_le_left (min ρc ρd / 2) τ; have := min_le_right ρc ρd; linarith⟩
  have hρ₀ : (0 : ℝ) < 2 * (1 + τ) := by linarith
  have hpre : IsPreconnected (r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P}) :=
    isPreconnected_r2Crescent hσ hτ hx₁ hx₁τ hτ1
  have hHball : ∀ z ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P}, dist z (P + 2 * e θ₀) < 2 * x₁ :=
    fun z hz => dist_lt_of_mem_r2Crescent hσ hρ₀ hx₁ (by linarith) hz
  -- the open half-crescent holds interior points only
  have hHint : r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P} ⊆ F.interiorPts := by
    intro z hz
    have hzd : z ∈ F.dom := hballd (lt_of_lt_of_le (hHball z hz) hx₁d)
    refine ⟨hzd, fun hcar => ?_⟩
    have hzb := lt_of_lt_of_le (hHball z hz) hx₁c
    obtain ⟨⟨h1, -, -, h4⟩, h5⟩ := hz
    have h5' := (two_lt_dist_iff P θ₀ z).mp h5
    have h5'' : 2 < dist z P := h5
    have hY0 : r2Y P θ₀ z < 0 := by nlinarith [sq_nonneg (r2X P θ₀ z), sq_nonneg (r2Y P θ₀ z)]
    have := hC1 τ hτ hττ₀ z ⟨hzd, hcar⟩ hzb (r2X P θ₀ z) (r2Y P θ₀ z) (r2_frame P θ₀ z) h1.le (by nlinarith) (by linarith)
    linarith
  have hconst : ∀ z ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P},
      ∀ z' ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P}, F.col z = F.col z' :=
    fun z hz z' hz' => hpre.constant (F.continuousOn_col.mono hHint) hz hz'
  have hU : IsOpen (r2Side P θ₀ σ (2 * (1 + τ)) x₁) := isOpen_r2Side P θ₀ σ (2 * (1 + τ)) x₁
  refine ⟨min (x₁ / 2) δ₀, lt_min (by linarith) hδ₀, x₁, hx₁, 2 * (1 + τ), by linarith, ?_⟩
  have hwt : ∀ t ∈ Ioo 0 (min (x₁ / 2) δ₀), P + 2 * e (θ₀ + σ * t) ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ :=
    fun t ht => r2pt_mem_r2Side hσ hτ (by linarith) ⟨ht.1, ht.2.trans_le (min_le_left _ _)⟩
  have hd2 : ∀ β : ℝ, dist (P + 2 * e β) P = 2 := fun β => by simp [dist_eq_norm]
  by_cases hall : ∀ z ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P}, F.col z = c
  · -- all: the crescent has the inner colour, and every radius-2 point next to the base point is a limit of it
    left
    intro t ht
    have h1 : P + 2 * e (θ₀ + σ * t) ∈ closure {z : ℂ | 2 < dist z P} :=
      mem_closure_dist_gt (by norm_num) (by rw [hd2])
    have hsub : r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P} ⊆ F.region c := fun z hz => ⟨hHint hz, hall z hz⟩
    exact closure_mono hsub (hU.inter_closure ⟨hwt t ht, h1⟩)
  · -- none: the crescent has another colour
    right
    push Not at hall
    obtain ⟨z₁, hz₁, hz₁c⟩ := hall
    have hne : ∀ z ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ ∩ {z | 2 < dist z P}, F.col z ≠ c :=
      fun z hz h => hz₁c ((hconst z₁ hz₁ z hz).trans h)
    refine ⟨fun t ht hcl => ?_, fun y hy hyη hyσ hy2 => ?_⟩
    · -- a radius-2 point next to the base point has a ball off the class
      have htδ₀ : t < δ₀ := ht.2.trans_le (min_le_right _ _)
      have hθ : θ₀ + σ * t ∈ Ioo θ₁ θ₂ := by
        rcases hσ with rfl | rfl
        · exact ⟨by linarith [hθ₀.1, ht.1], by linarith [hside.2]⟩
        · exact ⟨by linarith [hside.1], by linarith [hθ₀.2, ht.1]⟩
      obtain ⟨r', hr', hinner⟩ := hA.exists_inner_ball hθ
      obtain ⟨ε₁, hε₁, hballU⟩ := Metric.isOpen_iff.mp hU _ (hwt t ht)
      obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hcl (min ε₁ (min (r' / 2) 1))
        (lt_min hε₁ (lt_min (by linarith) one_pos))
      have hyd' : dist y (P + 2 * e (θ₀ + σ * t)) < min ε₁ (min (r' / 2) 1) := by rwa [dist_comm]
      rcases lt_or_ge 2 (dist y P) with h2 | h2
      · exact hne y ⟨hballU (hyd'.trans_le (min_le_left _ _)), h2⟩ hy.2
      · have hs1 : 1 < dist y P := by
          have h3 := dist_triangle (P + 2 * e (θ₀ + σ * t)) y P
          rw [hd2] at h3
          have h4 := hyd.trans_le ((min_le_right _ _).trans (min_le_right _ _))
          linarith
        obtain ⟨hx1, hx2, hx3⟩ := under_point (y := y) (P := P) (θ₀ + σ * t) hs1.le
        have hxcl : P + ((1 - 1 / dist y P : ℝ) : ℂ) * (y - P) ∈ closure (F.region c) := by
          apply hinner
          refine isOpen_ball.inter_closure ⟨?_, ?_⟩
          · rw [mem_ball]
            have h4 := hyd'.trans_le ((min_le_right _ _).trans (min_le_left _ _))
            linarith
          · rw [closure_ball P one_ne_zero, mem_closedBall, hx2]; linarith
        exact ne1_region hF hxcl hy hx1
    · -- the cap: a point of the class near the base point, on the side, not inside the radius-2 circle, is off the tangent disc
      by_contra hlt
      push Not at hlt
      have hyU : y ∈ r2Side P θ₀ σ (2 * (1 + τ)) x₁ := by
        have hN := r2_dist_sq_base P θ₀ y
        have hO := r2_dist_sq P θ₀ (2 * (1 + τ)) y
        have hd0 := dist_nonneg (x := y) (y := P + 2 * e θ₀)
        have hd1 := dist_nonneg (x := y) (y := P + ((2 - 2 * (1 + τ) : ℝ) : ℂ) * e θ₀)
        have hNlt : r2X P θ₀ y ^ 2 + r2Y P θ₀ y ^ 2 < x₁ ^ 2 := by rw [← hN]; nlinarith
        have hσX : 0 < σ * r2X P θ₀ y := by rw [r2X_eq]; exact hyσ
        have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
        have hσXsq : (σ * r2X P θ₀ y) ^ 2 = r2X P θ₀ y ^ 2 := by rw [mul_pow, hσ2, one_mul]
        refine ⟨hσX, ?_, ?_, ?_⟩
        · nlinarith [sq_nonneg (r2Y P θ₀ y)]
        · nlinarith [sq_nonneg (r2X P θ₀ y), sq_nonneg (r2Y P θ₀ y + 1)]
        · nlinarith
      have hycl := mem_closure_dist_gt (a := 2) (by norm_num) hy2
      obtain ⟨z, ⟨hzc, hzU⟩, hz2⟩ := mem_closure_iff.mp hycl _ ((F.isOpen_region c).inter hU) ⟨hy, hyU⟩
      exact hne z ⟨hzU, hz2⟩ hzc.2

/-- **The radius-2 contacts over a constant-sided unit arc have a finite subdivision** when `R₂(ᾱ)` lies in the domain: by
`r2_side_dichotomy` each angle of `[θ₁, θ₂]` has, on each side, a one-sided neighbourhood wholly in the contacts or wholly off them;
`R2Subdiv.of_local` joins the pieces (near `x` an interval `(u, v)` is one piece if `x ∉ (u, v)` and two joined at `x` otherwise). **Proved (FS131-BA2)** (child C3). Inhabitant of the hypotheses: owed with the away bend's model. -/
theorem exists_r2Subdiv (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom) : R2Subdiv {θ | P + 2 * e θ ∈ closure (F.region c)} θ₁ θ₂ := by
  refine R2Subdiv.of_local hA.1 fun x hx => ?_
  have hw : P + 2 * e x ∈ F.dom := hdom ⟨x, hx, rfl⟩
  -- to the right of `x`
  have hright : ∃ δ > 0, ∀ u v : ℝ, x ≤ u → u < v → v ≤ θ₂ → v - x < δ →
      R2Subdiv {θ | P + 2 * e θ ∈ closure (F.region c)} u v := by
    by_cases hxθ : x < θ₂
    · obtain ⟨δ, hδ, _, _, _, _, h⟩ := r2_side_dichotomy hF hA (σ := 1) (δ₀ := θ₂ - x) (Or.inl rfl) hx (by linarith)
        ⟨by linarith [hx.1], by linarith⟩ hw
      refine ⟨δ, hδ, fun u v hxu huv _ hvδ => ?_⟩
      have hmem : ∀ θ ∈ Ioo u v, θ - x ∈ Ioo 0 δ := fun θ hθ => ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
      have hrw : ∀ θ : ℝ, x + 1 * (θ - x) = θ := fun θ => by ring
      rcases h with h | ⟨h, -⟩
      · refine .contact huv fun θ hθ => ?_
        have := h (θ - x) (hmem θ hθ)
        rwa [hrw] at this
      · refine .gap huv (Set.disjoint_left.mpr fun θ hθ hC => ?_)
        have := h (θ - x) (hmem θ hθ)
        rw [hrw] at this
        exact this hC
    · exact ⟨1, one_pos, fun u v hxu huv hv _ => absurd (lt_of_le_of_lt hxu (huv.trans_le hv)) hxθ⟩
  -- to the left of `x`
  have hleft : ∃ δ > 0, ∀ u v : ℝ, θ₁ ≤ u → u < v → v ≤ x → x - u < δ →
      R2Subdiv {θ | P + 2 * e θ ∈ closure (F.region c)} u v := by
    by_cases hxθ : θ₁ < x
    · obtain ⟨δ, hδ, _, _, _, _, h⟩ := r2_side_dichotomy hF hA (σ := -1) (δ₀ := x - θ₁) (Or.inr rfl) hx (by linarith)
        ⟨by linarith, by linarith [hx.2]⟩ hw
      refine ⟨δ, hδ, fun u v _ huv hvx huδ => ?_⟩
      have hmem : ∀ θ ∈ Ioo u v, x - θ ∈ Ioo 0 δ := fun θ hθ => ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
      have hrw : ∀ θ : ℝ, x + -1 * (x - θ) = θ := fun θ => by ring
      rcases h with h | ⟨h, -⟩
      · refine .contact huv fun θ hθ => ?_
        have := h (x - θ) (hmem θ hθ)
        rwa [hrw] at this
      · refine .gap huv (Set.disjoint_left.mpr fun θ hθ hC => ?_)
        have := h (x - θ) (hmem θ hθ)
        rw [hrw] at this
        exact this hC
    · exact ⟨1, one_pos, fun u v hu huv hvx _ => absurd (lt_of_le_of_lt hu (huv.trans_le hvx)) hxθ⟩
  obtain ⟨δr, hδr, hr⟩ := hright
  obtain ⟨δl, hδl, hl⟩ := hleft
  refine ⟨min δr δl, lt_min hδr hδl, fun u v huv hu hv hux hvx => ?_⟩
  have hux' := abs_lt.mp hux
  have hvx' := abs_lt.mp hvx
  have hδ1 := min_le_left δr δl
  have hδ2 := min_le_right δr δl
  rcases le_or_gt x u with hxu | hxu
  · exact hr u v hxu huv hv.2 (by linarith)
  · rcases le_or_gt v x with hvx2 | hvx2
    · exact hl u v hu.1 huv hvx2 (by linarith)
    · exact .join (hl u x hu.1 hxu le_rfl (by linarith)) (hr x v le_rfl hvx2 hv.2 (by linarith))

end ArcMap

end HadwigerNelson.Plane
