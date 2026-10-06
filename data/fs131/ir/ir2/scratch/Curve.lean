import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ}

--BEGIN
/-- A point with no horn sector and no repeated colour is no site. -/
theorem not_isSite_of_hasHornCount_zero {M : ArcMap k} {x : ℂ} (h0 : M.HasHornCount x 0)
    (hrep : ¬ M.HasRepeatedColour x) : ¬ M.IsSite x := by
  rintro ⟨-, hr | ⟨α, κ₁, κ₂, c, hlt, hH⟩⟩
  · exact hrep hr
  · obtain ⟨r, ⟨hS, -⟩, h0r⟩ := (hH.and h0).exists
    rw [Nat.cast_zero, encard_eq_zero] at h0r
    exact (eq_empty_iff_forall_notMem.mp h0r) _ ⟨hS, α, κ₁, κ₂, hlt, rfl⟩

/-- The two germs of a line or circle leave its point in opposite directions. -/
theorem _root_.HadwigerNelson.Plane.e_curveGerm_ne (κ : ℝ) (b : ℂ) : e (curveGerm κ b 1).1 ≠ e (curveGerm κ b (-1)).1 := by
  have e1 : e (curveGerm κ b 1).1 = e (arg b - π / 2) := by
    have := e_toIcoMod_add (arg b - 1 * (π / 2)) 0
    rw [add_zero, add_zero] at this
    rw [curveGerm]; dsimp only; rw [this, one_mul]
  have e2 : e (curveGerm κ b (-1)).1 = - e (arg b - π / 2) := by
    have := e_toIcoMod_add (arg b - -1 * (π / 2)) 0
    rw [add_zero, add_zero] at this
    rw [curveGerm]; dsimp only
    rw [this, show arg b - -1 * (π / 2) = (arg b - π / 2) + π by ring, e_add_pi]
  rw [e1, e2]
  intro h
  have h2 : (2 : ℂ) * e (arg b - π / 2) = 0 := by linear_combination h
  have h3 := congrArg norm h2
  rw [norm_mul, norm_e, Complex.norm_two, norm_zero] at h3
  norm_num at h3

/-- **A point of a clean map near which `Γ` lies on one line or circle through it is no site**, and carries at most two colours
(the form in which a point of a move's disc on one germ or one new arc is read; `not_isSite_of_goodAt` is the case of a good ball). -/
theorem not_isSite_of_curve {M : ArcMap k} (hc : M.IsClean) {x : ℂ} (hx : x ∈ M.dom) {κ : ℝ} (hκ : 0 ≤ κ) {b : ℂ}
    (hb : b ≠ 0) {ρ : ℝ} (hρ : 0 < ρ) (hΓ : ∀ z ∈ M.Γ, z ∈ ball x ρ → z ∈ curveAt x κ b) :
    ¬ M.IsSite x ∧ (M.coloursAt x).ncard ≤ 2 := by
  classical
  have hbn : 0 < ‖b‖ := norm_pos_iff.mpr hb
  obtain ⟨ρ', hρ', hρ'ρ, hκρ'⟩ : ∃ ρ' > 0, ρ' ≤ ρ ∧ κ * ρ' < 2 * ‖b‖ := by
    refine ⟨min ρ (‖b‖ / (κ + 1)), lt_min hρ (by positivity), min_le_left _ _, ?_⟩
    have h1 : min ρ (‖b‖ / (κ + 1)) ≤ ‖b‖ / (κ + 1) := min_le_right _ _
    have h2 : κ * (‖b‖ / (κ + 1)) ≤ ‖b‖ := by
      rw [← mul_div_assoc, div_le_iff₀ (by linarith)]
      nlinarith [hbn.le, hκ]
    nlinarith [mul_le_mul_of_nonneg_left h1 hκ]
  set 𝒟 : Finset (ℝ × ℝ) := {curveGerm κ b 1, curveGerm κ b (-1)} with h𝒟
  have hdir : ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, e g.1 = e g'.1 → g = g' := by
    intro g hg g' hg' h
    simp only [h𝒟, Finset.mem_insert, Finset.mem_singleton] at hg hg'
    rcases hg with rfl | rfl <;> rcases hg' with rfl | rfl
    · rfl
    · exact absurd h (e_curveGerm_ne κ b)
    · exact absurd h.symm (e_curveGerm_ne κ b)
    · rfl
  obtain ⟨h0, hdeg, -⟩ := hasHornCount_zero_of_germs hx 𝒟 hdir hρ' (fun z hz hzb hzx => by
    have hzb' : ‖z - x‖ < ρ' := by rwa [mem_ball, dist_eq_norm] at hzb
    obtain ⟨σ, hσ, hzσ⟩ := exists_eq_branchPt_curveGerm hκ hb (hΓ z hz (ball_subset_ball hρ'ρ hzb)) hzx
      (by nlinarith [mul_le_mul_of_nonneg_left hzb'.le hκ])
    rcases hσ with rfl | rfl
    · exact ⟨_, by simp [h𝒟], hzσ⟩
    · exact ⟨_, by simp [h𝒟], hzσ⟩)
  obtain ⟨m, hcol, hm⟩ := exists_hasDegree_of_mem_dom hx
  have hm2 : m ≤ 2 := by
    have h1 := hdeg m hm
    have h2 : 𝒟.card ≤ 2 := (Finset.card_insert_le _ _).trans (by simp)
    omega
  exact ⟨not_isSite_of_hasHornCount_zero h0 (not_hasRepeatedColour_of_degree_le_three hc hx hm (by omega)),
    hcol.trans hm2⟩

/-- **A line or circle through `v`, read from another of its points** `y`: the same curve, with the data at `y`. -/
theorem _root_.HadwigerNelson.Plane.curveAt_rebase {v y : ℂ} {κ : ℝ} {b : ℂ} (hy : y ∈ curveAt v κ b) :
    curveAt v κ b = curveAt y κ (b + (κ : ℂ) * (v - y)) := by
  ext z
  simp only [curveAt, mem_setOf_eq, Complex.normSq_apply, Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.conj_re,
    Complex.conj_im, Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_im] at hy ⊢
  constructor <;> intro h
  · linear_combination h - hy
  · linear_combination h + hy
--END

end ArcMap

end HadwigerNelson.Plane
