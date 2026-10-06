import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The normals of two curves that are not parallel give four germ directions, pairwise distinct. -/
theorem e_arg_sub_ne {b b' : ℂ} (hT : (b * starRingEnd ℂ b').im ≠ 0) (τ : ℂ) (hτ : τ = 1 ∨ τ = -1) :
    e (arg b - π / 2) ≠ τ * e (arg b' - π / 2) := by
  intro h
  have h1 : e (arg b) = I * e (arg b - π / 2) := by
    have := e_add_pi_div_two (arg b - π / 2); rwa [sub_add_cancel] at this
  have h1' : e (arg b') = I * e (arg b' - π / 2) := by
    have := e_add_pi_div_two (arg b' - π / 2); rwa [sub_add_cancel] at this
  have h2 : e (arg b) = τ * e (arg b') := by rw [h1, h1', h]; ring
  have hb : (‖b‖ : ℂ) * e (arg b) = b := by unfold e; exact Complex.norm_mul_exp_arg_mul_I b
  have hb' : (‖b'‖ : ℂ) * e (arg b') = b' := by unfold e; exact Complex.norm_mul_exp_arg_mul_I b'
  have hn : e (arg b') * starRingEnd ℂ (e (arg b')) = 1 := by
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e]; norm_num
  apply hT
  have : b * starRingEnd ℂ b' = (‖b‖ : ℂ) * (‖b'‖ : ℂ) * τ := by
    rw [← hb, ← hb', h2, map_mul, Complex.conj_ofReal]
    linear_combination ((‖b‖ : ℂ) * (‖b'‖ : ℂ) * τ) * hn
  rw [this]
  rcases hτ with rfl | rfl <;> simp

/-- A curve through `x` and `v` that holds a point farther from `v` than `x` is not tangent at `x` to the circle about `v`. -/
theorem im_ne_zero_of_far {v x w : ℂ} {κ' : ℝ} {b : ℂ} (hb : b ≠ 0) (hvx : v ≠ x) (hv : v ∈ curveAt x κ' b)
    (hw : w ∈ curveAt x κ' b) (hfar : dist x v < dist w v) : ((v - x) * starRingEnd ℂ b).im ≠ 0 := by
  intro him
  simp only [curveAt, mem_setOf_eq, Complex.normSq_apply, Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.conj_re,
    Complex.conj_im] at hv hw
  simp only [Complex.mul_im, Complex.sub_re, Complex.sub_im, Complex.conj_re, Complex.conj_im] at him
  have hfar2 : dist x v ^ 2 < dist w v ^ 2 := pow_lt_pow_left₀ hfar dist_nonneg (by norm_num)
  rw [Complex.dist_eq, Complex.dist_eq, Complex.sq_norm, Complex.sq_norm, Complex.normSq_apply, Complex.normSq_apply] at hfar2
  simp only [Complex.sub_re, Complex.sub_im] at hfar2
  set p1 := v.re - x.re with hp1
  set p2 := v.im - x.im with hp2
  set q1 := w.re - x.re with hq1
  set q2 := w.im - x.im with hq2
  have hP : 0 < p1 * p1 + p2 * p2 := by
    by_contra hP
    have h0 : p1 * p1 + p2 * p2 = 0 := le_antisymm (not_lt.mp hP) (by positivity)
    have h1 : p1 = 0 := by nlinarith [mul_self_nonneg p1, mul_self_nonneg p2]
    have h2 : p2 = 0 := by nlinarith [mul_self_nonneg p1, mul_self_nonneg p2]
    apply hvx
    apply Complex.ext
    · linarith
    · linarith
  have hb1 : b.re = κ' * p1 / 2 := by
    have : b.re * (p1 * p1 + p2 * p2) = (κ' * p1 / 2) * (p1 * p1 + p2 * p2) := by linear_combination p1 / 2 * hv - p2 * him
    exact mul_right_cancel₀ hP.ne' this
  have hb2 : b.im = κ' * p2 / 2 := by
    have : b.im * (p1 * p1 + p2 * p2) = (κ' * p2 / 2) * (p1 * p1 + p2 * p2) := by linear_combination p2 / 2 * hv + p1 * him
    exact mul_right_cancel₀ hP.ne' this
  have hκ : κ' ≠ 0 := by
    rintro rfl
    apply hb
    apply Complex.ext
    · rw [hb1]; simp
    · rw [hb2]; simp
  have hq : q1 * q1 + q2 * q2 = q1 * p1 + q2 * p2 := by
    have : κ' * (q1 * q1 + q2 * q2) = κ' * (q1 * p1 + q2 * p2) := by rw [hw, hb1, hb2]; ring
    exact mul_left_cancel₀ hκ this
  have e1 : x.re - v.re = -p1 := by rw [hp1]; ring
  have e2 : x.im - v.im = -p2 := by rw [hp2]; ring
  have e3 : w.re - v.re = q1 - p1 := by rw [hp1, hq1]; ring
  have e4 : w.im - v.im = q2 - p2 := by rw [hp2, hq2]; ring
  rw [e1, e2, e3, e4] at hfar2
  nlinarith [mul_self_nonneg q1, mul_self_nonneg q2]

/-- The circle about `v` through `x`, as a curve through `x`. -/
theorem mem_curveAt_of_dist_eq {v x z : ℂ} (hz : dist z v = dist x v) : z ∈ curveAt x 1 (v - x) := by
  have h2 : dist z v ^ 2 = dist x v ^ 2 := by rw [hz]
  rw [Complex.dist_eq, Complex.dist_eq, Complex.sq_norm, Complex.sq_norm, Complex.normSq_apply, Complex.normSq_apply] at h2
  simp only [Complex.sub_re, Complex.sub_im] at h2
  simp only [curveAt, mem_setOf_eq, Complex.normSq_apply, Complex.mul_re, Complex.sub_re, Complex.sub_im, Complex.conj_re,
    Complex.conj_im, one_mul]
  linear_combination h2

namespace ArcMap

variable {k : ℕ}

/-- The cleaned map's arcs lie on the map's. -/
theorem cleanKeep_Γ_subset (M : ArcMap k) : M.cleanKeep.Γ ⊆ M.Γ := by
  rw [cleanKeep_Γ]; exact essSet_subset_Γ

/-- **A point with one colour near it is on no arc of the cleaned map.** -/
theorem not_mem_cleanKeep_Γ_of_const {M : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : IsOpen U) (hw : w ∈ U) {a : Fin k}
    (h : ∀ y ∈ U, y ∈ M.interiorPts → M.col y = a) : w ∉ M.cleanKeep.Γ := by
  rw [cleanKeep_Γ]
  rintro ⟨-, h2⟩
  have hsub : M.coloursAt w ⊆ {a} := by
    intro j hj
    obtain ⟨y, hyU, hyI, hyj⟩ := mem_closure_iff.mp hj U hU hw
    have hyj' : M.col y = j := hyj
    rw [mem_singleton_iff, ← hyj']; exact h y hyU hyI
  have := ncard_le_ncard hsub (finite_singleton _)
  rw [ncard_singleton] at this
  omega

/-- **A point of a clean map near which `Γ` lies on two transversal curves through it, one of whose four branches is dead**
(points of the two curves off `Γ` arbitrarily near), is no site and carries at most three colours. -/
theorem not_isSite_of_two_curves {M : ArcMap k} (hc : M.IsClean) {x : ℂ} (hx : x ∈ M.dom) {κ κ' : ℝ} (hκ : 0 ≤ κ)
    (hκ' : 0 ≤ κ') {b b' : ℂ} (hT : (b * starRingEnd ℂ b').im ≠ 0) {ρ : ℝ} (hρ : 0 < ρ)
    (hΓ : ∀ z ∈ M.Γ, z ∈ ball x ρ → z ∈ curveAt x κ b ∨ z ∈ curveAt x κ' b')
    (hdead : ∀ ε > 0, ∃ w ∈ ball x ε, w ≠ x ∧ (w ∈ curveAt x κ b ∨ w ∈ curveAt x κ' b') ∧ w ∉ M.Γ) :
    ¬ M.IsSite x ∧ (M.coloursAt x).ncard ≤ 3 := by
  classical
  have hb : b ≠ 0 := by rintro rfl; simp at hT
  have hb' : b' ≠ 0 := by rintro rfl; simp at hT
  have hbn : 0 < ‖b‖ := norm_pos_iff.mpr hb
  have hbn' : 0 < ‖b'‖ := norm_pos_iff.mpr hb'
  obtain ⟨ρ', hρ', hρ'ρ, hκρ', hκ'ρ'⟩ : ∃ ρ' > 0, ρ' ≤ ρ ∧ κ * ρ' < 2 * ‖b‖ ∧ κ' * ρ' < 2 * ‖b'‖ := by
    refine ⟨min ρ (min (‖b‖ / (κ + 1)) (‖b'‖ / (κ' + 1))), lt_min hρ (lt_min (by positivity) (by positivity)),
      min_le_left _ _, ?_, ?_⟩
    · have h1 : min ρ (min (‖b‖ / (κ + 1)) (‖b'‖ / (κ' + 1))) ≤ ‖b‖ / (κ + 1) :=
        (min_le_right _ _).trans (min_le_left _ _)
      have h2 : κ * (‖b‖ / (κ + 1)) ≤ ‖b‖ := by
        rw [← mul_div_assoc, div_le_iff₀ (by linarith)]
        nlinarith [hbn.le, hκ]
      nlinarith [mul_le_mul_of_nonneg_left h1 hκ]
    · have h1 : min ρ (min (‖b‖ / (κ + 1)) (‖b'‖ / (κ' + 1))) ≤ ‖b'‖ / (κ' + 1) :=
        (min_le_right _ _).trans (min_le_right _ _)
      have h2 : κ' * (‖b'‖ / (κ' + 1)) ≤ ‖b'‖ := by
        rw [← mul_div_assoc, div_le_iff₀ (by linarith)]
        nlinarith [hbn'.le, hκ']
      nlinarith [mul_le_mul_of_nonneg_left h1 hκ']
  have e1 : ∀ (κ : ℝ) (b : ℂ), e (curveGerm κ b 1).1 = e (arg b - π / 2) := fun κ b => by
    have := e_toIcoMod_add (arg b - 1 * (π / 2)) 0
    rw [add_zero, add_zero] at this
    rw [curveGerm]; dsimp only; rw [this, one_mul]
  have e2 : ∀ (κ : ℝ) (b : ℂ), e (curveGerm κ b (-1)).1 = - e (arg b - π / 2) := fun κ b => by
    have := e_toIcoMod_add (arg b - -1 * (π / 2)) 0
    rw [add_zero, add_zero] at this
    rw [curveGerm]; dsimp only
    rw [this, show arg b - -1 * (π / 2) = (arg b - π / 2) + π by ring, e_add_pi]
  have hT' : (b' * starRingEnd ℂ b).im ≠ 0 := by
    intro h; apply hT
    have : b * starRingEnd ℂ b' = starRingEnd ℂ (b' * starRingEnd ℂ b) := by simp [mul_comm]
    rw [this, Complex.conj_im, h, neg_zero]
  set 𝒟 : Finset (ℝ × ℝ) := {curveGerm κ b 1, curveGerm κ b (-1), curveGerm κ' b' 1, curveGerm κ' b' (-1)} with h𝒟
  have hdir : ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, e g.1 = e g'.1 → g = g' := by
    intro g hg g' hg' h
    simp only [h𝒟, Finset.mem_insert, Finset.mem_singleton] at hg hg'
    rcases hg with rfl | rfl | rfl | rfl <;> rcases hg' with rfl | rfl | rfl | rfl
    · rfl
    · exact absurd h (e_curveGerm_ne κ b)
    · rw [e1, e1] at h; exact absurd (by rw [h, one_mul]) (e_arg_sub_ne hT 1 (Or.inl rfl))
    · rw [e1, e2] at h; exact absurd (by rw [h]; ring) (e_arg_sub_ne hT (-1) (Or.inr rfl))
    · exact absurd h.symm (e_curveGerm_ne κ b)
    · rfl
    · rw [e2, e1] at h; exact absurd (by rw [← h]; ring) (e_arg_sub_ne hT (-1) (Or.inr rfl))
    · rw [e2, e2] at h; exact absurd (by rw [neg_inj.mp h, one_mul]) (e_arg_sub_ne hT 1 (Or.inl rfl))
    · rw [e1, e1] at h; exact absurd (by rw [h, one_mul]) (e_arg_sub_ne hT' 1 (Or.inl rfl))
    · rw [e1, e2] at h; exact absurd (by rw [h]; ring) (e_arg_sub_ne hT' (-1) (Or.inr rfl))
    · rfl
    · exact absurd h (e_curveGerm_ne κ' b')
    · rw [e2, e1] at h; exact absurd (by rw [← h]; ring) (e_arg_sub_ne hT' (-1) (Or.inr rfl))
    · rw [e2, e2] at h; exact absurd (by rw [neg_inj.mp h, one_mul]) (e_arg_sub_ne hT' 1 (Or.inl rfl))
    · exact absurd h.symm (e_curveGerm_ne κ' b')
    · rfl
  have hgerm : ∀ z, z ∈ ball x ρ' → z ≠ x → (z ∈ curveAt x κ b ∨ z ∈ curveAt x κ' b') →
      ∃ g ∈ 𝒟, z = branchPt x g.1 g.2 ‖z - x‖ := by
    intro z hzb hzx hz
    have hzb' : ‖z - x‖ < ρ' := by rwa [mem_ball, dist_eq_norm] at hzb
    rcases hz with hz | hz
    · obtain ⟨σ, hσ, hzσ⟩ := exists_eq_branchPt_curveGerm hκ hb hz hzx
        (by nlinarith [mul_le_mul_of_nonneg_left hzb'.le hκ])
      rcases hσ with rfl | rfl
      · exact ⟨_, by simp [h𝒟], hzσ⟩
      · exact ⟨_, by simp [h𝒟], hzσ⟩
    · obtain ⟨σ, hσ, hzσ⟩ := exists_eq_branchPt_curveGerm hκ' hb' hz hzx
        (by nlinarith [mul_le_mul_of_nonneg_left hzb'.le hκ'])
      rcases hσ with rfl | rfl
      · exact ⟨_, by simp [h𝒟], hzσ⟩
      · exact ⟨_, by simp [h𝒟], hzσ⟩
  obtain ⟨h0, -, hdeg⟩ := hasHornCount_zero_of_germs hx 𝒟 hdir hρ' (fun z hz hzb hzx =>
    hgerm z hzb hzx (hΓ z hz (ball_subset_ball hρ'ρ hzb)))
  -- one of the four branches is dead
  obtain ⟨g₀, hg₀, hfreq⟩ : ∃ g₀ ∈ 𝒟, ∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x g₀.1 g₀.2 s ∉ M.Γ := by
    by_contra hcon
    push Not at hcon
    have hall : ∀ᶠ s in 𝓝[>] (0 : ℝ), ∀ g ∈ 𝒟, branchPt x g.1 g.2 s ∈ M.Γ :=
      (Filter.eventually_all_finset 𝒟).mpr fun g hg => by
        have := hcon g hg
        rwa [Filter.not_frequently] at this
        
    obtain ⟨u, hu, huP⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp hall
    have hu0 : (0 : ℝ) < u := hu
    obtain ⟨w, hwb, hwx, hwc, hwΓ⟩ := hdead (min u ρ') (lt_min hu0 hρ')
    have hwn : ‖w - x‖ < min u ρ' := by rwa [mem_ball, dist_eq_norm] at hwb
    obtain ⟨g, hg, hwg⟩ := hgerm w (ball_subset_ball (min_le_right _ _) hwb) hwx hwc
    apply hwΓ
    rw [hwg]
    exact huP ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hwx), hwn.trans_le (min_le_left _ _)⟩ g hg
  obtain ⟨m, hcol, hm⟩ := exists_hasDegree_of_mem_dom hx
  have hm3 : m ≤ 3 := by
    have h1 := hdeg g₀ hg₀ hfreq m hm
    have h2 : 𝒟.card ≤ 4 := by
      refine (Finset.card_insert_le _ _).trans ?_
      refine (Nat.succ_le_succ ((Finset.card_insert_le _ _).trans ?_))
      exact Nat.succ_le_succ ((Finset.card_insert_le _ _).trans (by simp))
    omega
  exact ⟨not_isSite_of_hasHornCount_zero h0 (not_hasRepeatedColour_of_degree_le_three hc hx hm hm3), hcol.trans hm3⟩

end ArcMap

end HadwigerNelson.Plane
