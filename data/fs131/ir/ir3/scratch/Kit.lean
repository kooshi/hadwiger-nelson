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
    have h3 : b * starRingEnd ℂ b' = ((‖b‖ : ℂ) * e (arg b)) * starRingEnd ℂ ((‖b'‖ : ℂ) * e (arg b')) := by rw [hb, hb']
    rw [h3, h2, map_mul, Complex.conj_ofReal]
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
    have h0 : p1 * p1 + p2 * p2 = 0 := le_antisymm (not_lt.mp hP) (add_nonneg (mul_self_nonneg _) (mul_self_nonneg _))
    have h1 : p1 = 0 := by nlinarith [mul_self_nonneg p1, mul_self_nonneg p2]
    have h2 : p2 = 0 := by nlinarith [mul_self_nonneg p1, mul_self_nonneg p2]
    apply hvx
    apply Complex.ext
    · linarith
    · linarith
  have hb1 : b.re = κ' * p1 / 2 := by
    have : b.re * (p1 * p1 + p2 * p2) = (κ' * p1 / 2) * (p1 * p1 + p2 * p2) := by linear_combination p2 * him - p1 / 2 * hv
    exact mul_right_cancel₀ hP.ne' this
  have hb2 : b.im = κ' * p2 / 2 := by
    have : b.im * (p1 * p1 + p2 * p2) = (κ' * p2 / 2) * (p1 * p1 + p2 * p2) := by linear_combination -p1 * him - p2 / 2 * hv
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
      (Filter.eventually_all_finset 𝒟).mpr fun g hg => hcon g hg
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

/-- **A junction of a branch from `v` with the circle of radius `ρ` about `v`** (the two-curve lemma at a point of a move's rim): if
near the branch's point at distance `ρ` the arcs of a clean map lie on that circle and on the branch (out to some `r > ρ` at which it
is still a graph), and points of the circle or the branch off the arcs lie arbitrarily near, the point is no site and carries at most
three colours. The branch is transversal to the circle there: its curve passes through `v` and holds a point farther from `v`. -/
theorem not_isSite_of_rim_junction {M : ArcMap k} (hc : M.IsClean) {v : ℂ} {β κ ρ r : ℝ} (hρ : 0 < ρ) (hρr : ρ < r)
    (hκr : |κ| * r < 2) (hx : branchPt v β κ ρ ∈ M.dom) {ε : ℝ} (hε : 0 < ε)
    (hΓ : ∀ z ∈ M.Γ, z ∈ ball (branchPt v β κ ρ) ε → z ∈ sphere v ρ ∨ ∃ t ∈ Icc 0 r, z = branchPt v β κ t)
    (hdead : ∀ ε' > 0, ∃ w ∈ ball (branchPt v β κ ρ) ε', w ≠ branchPt v β κ ρ ∧
      (w ∈ sphere v ρ ∨ ∃ t ∈ Icc 0 r, w = branchPt v β κ t) ∧ w ∉ M.Γ) :
    ¬ M.IsSite (branchPt v β κ ρ) ∧ (M.coloursAt (branchPt v β κ ρ)).ncard ≤ 3 := by
  set x := branchPt v β κ ρ with hxdef
  have hxv : dist x v = ρ := by rw [dist_eq_norm, norm_branchPt_sub v β κ hρ.le]
  obtain ⟨κ', b, hκ', hb, hcurve⟩ := exists_curveAt_of_branch v β κ hκr (s₁ := ρ) ⟨hρ.le, hρr.le⟩
  have hvx : v ≠ x := fun h => by rw [← h, dist_self] at hxv; linarith
  have hT : ((v - x) * starRingEnd ℂ b).im ≠ 0 := by
    refine im_ne_zero_of_far hb hvx ?_ (hcurve r ⟨by linarith, le_rfl⟩) ?_
    · have h0 : branchPt v β κ 0 = v := by simp [branchPt]
      have := hcurve 0 ⟨le_rfl, by linarith⟩
      rwa [h0] at this
    · rw [hxv, dist_eq_norm, norm_branchPt_sub v β κ (by linarith)]; exact hρr
  have hcases : ∀ z, (z ∈ sphere v ρ ∨ ∃ t ∈ Icc 0 r, z = branchPt v β κ t) →
      z ∈ curveAt x 1 (v - x) ∨ z ∈ curveAt x κ' b := by
    rintro z (hz | ⟨t, ht, rfl⟩)
    · exact Or.inl (mem_curveAt_of_dist_eq (by rw [hxv]; exact hz))
    · exact Or.inr (hcurve t ht)
  exact not_isSite_of_two_curves hc hx zero_le_one hκ' hT hε (fun z hz hzb => hcases z (hΓ z hz hzb))
    (fun ε' hε' => by
      obtain ⟨w, hwb, hwx, hw, hwΓ⟩ := hdead ε' hε'
      exact ⟨w, hwb, hwx, hcases w hw, hwΓ⟩)

/-- **The points of a move's disc, in one statement**: let the arcs of a clean map `M` in the punctured ball `B(v, R)` lie on the
circle of radius `ρ₁` about `v` and on finitely many branches from `v`, pairwise apart and each a graph out to `R`. Then a point
`x ≠ v` of the ball is no site and carries at most three colours, provided that where a branch meets the circle at `x`, points of the
circle or of that branch off the arcs lie arbitrarily near `x` (one of the junction's four branches is dead). Off the circle, or off
every branch, `x` lies on at most one curve (`not_isSite_of_curve`); at a junction, `not_isSite_of_rim_junction`. -/
theorem not_isSite_of_branches {M : ArcMap k} (hc : M.IsClean) {v : ℂ} {R ρ₁ : ℝ} (hρ₁ : 0 < ρ₁) (hρ₁R : ρ₁ < R)
    (hdom : ball v R ⊆ M.dom) (𝒢 : Finset (ℝ × ℝ)) (hcurv : ∀ g ∈ 𝒢, |g.2| * R < 2)
    (hapart : ∀ g ∈ 𝒢, ∀ g' ∈ 𝒢, ∀ t ∈ Ioo 0 R, branchPt v g.1 g.2 t = branchPt v g'.1 g'.2 t → g = g')
    (hΓ : ∀ z ∈ M.Γ, z ∈ ball v R → z ≠ v → z ∈ sphere v ρ₁ ∨ ∃ g ∈ 𝒢, z = branchPt v g.1 g.2 ‖z - v‖)
    {x : ℂ} (hx : x ∈ ball v R) (hxv : x ≠ v)
    (hdead : ∀ g ∈ 𝒢, x = branchPt v g.1 g.2 ρ₁ → ∀ ε > 0, ∃ w ∈ ball x ε, w ≠ x ∧
      (w ∈ sphere v ρ₁ ∨ ∃ t ∈ Icc 0 R, w = branchPt v g.1 g.2 t) ∧ w ∉ M.Γ) :
    ¬ M.IsSite x ∧ (M.coloursAt x).ncard ≤ 3 := by
  classical
  have hxd : x ∈ M.dom := hdom hx
  set s := ‖x - v‖ with hs
  have hs0 : 0 < s := norm_pos_iff.mpr (sub_ne_zero.mpr hxv)
  have hsR : s < R := by rw [hs, ← dist_eq_norm]; exact hx
  -- the branches not through `x` stay away from it
  set Bad : Set ℂ := ⋃ g ∈ 𝒢.filter (fun g => x ≠ branchPt v g.1 g.2 s),
    branchPt v g.1 g.2 '' Icc (s / 2) ((s + R) / 2) with hBad
  have hBadc : IsClosed Bad :=
    isClosed_biUnion_finset fun g _ => (isCompact_Icc.image (continuous_branchPt v _ _)).isClosed
  have hxBad : x ∉ Bad := by
    intro h
    obtain ⟨g, hg, t, ht, hxt⟩ := mem_iUnion₂.mp h
    have hts : t = s := by
      have := norm_branchPt_sub v g.1 g.2 (show 0 ≤ t by linarith [ht.1])
      rw [hxt] at this; rw [hs, ← this]
    exact (Finset.mem_filter.mp hg).2 (by rw [← hts, hxt])
  obtain ⟨ε₀, hε₀, hball⟩ := Metric.isOpen_iff.mp hBadc.isOpen_compl x hxBad
  set ε := min ε₀ (min (s / 2) ((R - s) / 2)) with hεdef
  have hε : 0 < ε := lt_min hε₀ (lt_min (by linarith) (by linarith))
  have hnear : ∀ z ∈ ball x ε, ‖z - v‖ ∈ Ioo (s / 2) ((s + R) / 2) := by
    intro z hz
    have hzx : dist z x < ε := hz
    have h1 : ε ≤ s / 2 := (min_le_right _ _).trans (min_le_left _ _)
    have h2 : ε ≤ (R - s) / 2 := (min_le_right _ _).trans (min_le_right _ _)
    have h3 := dist_triangle z x v
    have h4 := dist_triangle x z v
    rw [dist_comm x z] at h4
    rw [dist_eq_norm z v, dist_eq_norm x v, ← hs] at h3 h4
    exact ⟨by linarith, by linarith⟩
  have hΓ' : ∀ z ∈ M.Γ, z ∈ ball x ε → z ∈ sphere v ρ₁ ∨
      ∃ g ∈ 𝒢, x = branchPt v g.1 g.2 s ∧ z = branchPt v g.1 g.2 ‖z - v‖ := by
    intro z hz hzb
    have hzn := hnear z hzb
    have hzR : z ∈ ball v R := by rw [mem_ball, dist_eq_norm]; linarith [hzn.2]
    have hzv : z ≠ v := fun h => by rw [h, sub_self, norm_zero] at hzn; linarith [hzn.1]
    rcases hΓ z hz hzR hzv with h | ⟨g, hg, hzg⟩
    · exact Or.inl h
    · refine Or.inr ⟨g, hg, ?_, hzg⟩
      by_contra hne
      exact hball (ball_subset_ball (min_le_left _ _) hzb)
        (mem_iUnion₂.mpr ⟨g, Finset.mem_filter.mpr ⟨hg, hne⟩, ‖z - v‖, ⟨hzn.1.le, hzn.2.le⟩, hzg.symm⟩)
  by_cases hρ : s = ρ₁
  · -- on the circle
    by_cases hg : ∃ g ∈ 𝒢, x = branchPt v g.1 g.2 s
    · obtain ⟨g₀, hg₀, hxg₀⟩ := hg
      rw [hρ] at hxg₀
      have key := not_isSite_of_rim_junction hc (β := g₀.1) (κ := g₀.2) hρ₁ hρ₁R (hcurv g₀ hg₀) (hxg₀ ▸ hxd) hε
        (fun z hz hzb => by
          rw [← hxg₀] at hzb
          rcases hΓ' z hz hzb with h | ⟨g, hg, hxg, hzg⟩
          · exact Or.inl h
          · have hgg : g = g₀ := hapart g hg g₀ hg₀ s ⟨hs0, hsR⟩ (by rw [← hxg, hρ, ← hxg₀])
            have hzn := hnear z hzb
            exact Or.inr ⟨‖z - v‖, ⟨by linarith [hzn.1], by linarith [hzn.2]⟩, hgg ▸ hzg⟩)
        (fun ε' hε' => by
          obtain ⟨w, hwb, hwx, hw, hwΓ⟩ := hdead g₀ hg₀ hxg₀ ε' hε'
          exact ⟨w, hxg₀ ▸ hwb, hxg₀ ▸ hwx, hw, hwΓ⟩)
      rw [← hxg₀] at key
      exact key
    · have hvx : v - x ≠ 0 := sub_ne_zero.mpr (Ne.symm hxv)
      obtain ⟨h1, h2⟩ := not_isSite_of_curve hc hxd zero_le_one hvx hε (fun z hz hzb => by
        rcases hΓ' z hz hzb with h | ⟨g, hg', hxg, -⟩
        · refine mem_curveAt_of_dist_eq ?_
          rw [dist_eq_norm x v, ← hs, hρ]; exact h
        · exact absurd ⟨g, hg', hxg⟩ hg)
      exact ⟨h1, h2.trans (by norm_num)⟩
  · -- off the circle: a smaller ball misses it
    have hgap : 0 < |s - ρ₁| := abs_pos.mpr (sub_ne_zero.mpr hρ)
    set ε' := min ε |s - ρ₁| with hε'def
    have hε' : 0 < ε' := lt_min hε hgap
    have hoff : ∀ z ∈ ball x ε', z ∉ sphere v ρ₁ := by
      intro z hz hzs
      have hzx : dist z x < |s - ρ₁| := lt_of_lt_of_le hz (min_le_right _ _)
      have h3 := dist_triangle z x v
      have h4 := dist_triangle x z v
      rw [dist_comm x z] at h4
      rw [mem_sphere.mp hzs, dist_eq_norm x v, ← hs] at h3 h4
      have : |s - ρ₁| ≤ dist z x := abs_le.mpr ⟨by linarith, by linarith⟩
      linarith
    by_cases hg : ∃ g ∈ 𝒢, x = branchPt v g.1 g.2 s
    · obtain ⟨g₀, hg₀, hxg₀⟩ := hg
      obtain ⟨κ', b, hκ', hb, hcurve⟩ := exists_curveAt_of_branch v g₀.1 g₀.2 (hcurv g₀ hg₀) (s₁ := s) ⟨hs0.le, hsR.le⟩
      rw [← hxg₀] at hcurve
      obtain ⟨h1, h2⟩ := not_isSite_of_curve hc hxd hκ' hb hε' (fun z hz hzb => by
        have hzb' : z ∈ ball x ε := ball_subset_ball (min_le_left _ _) hzb
        rcases hΓ' z hz hzb' with h | ⟨g, hg, hxg, hzg⟩
        · exact absurd h (hoff z hzb)
        · have hgg : g = g₀ := hapart g hg g₀ hg₀ s ⟨hs0, hsR⟩ (by rw [← hxg, ← hxg₀])
          have hzn := hnear z hzb'
          rw [hzg, hgg]
          exact hcurve _ ⟨by linarith [hzn.1], by linarith [hzn.2]⟩)
      exact ⟨h1, h2.trans (by norm_num)⟩
    · obtain ⟨h1, h2⟩ := not_isSite_of_curve hc hxd (κ := 0) le_rfl (b := 1) one_ne_zero hε' (fun z hz hzb => by
        rcases hΓ' z hz (ball_subset_ball (min_le_left _ _) hzb) with h | ⟨g, hg', hxg, -⟩
        · exact absurd h (hoff z hzb)
        · exact absurd ⟨g, hg', hxg⟩ hg)
      exact ⟨h1, h2.trans (by norm_num)⟩

/-- A branch has points before `ρ` arbitrarily near its point at `ρ`. -/
theorem _root_.HadwigerNelson.Plane.exists_branchPt_near_lt (v : ℂ) (β κ : ℝ) {ρ : ℝ} (hρ : 0 < ρ) {ε : ℝ} (hε : 0 < ε) :
    ∃ t ∈ Ioo 0 ρ, dist (branchPt v β κ t) (branchPt v β κ ρ) < ε := by
  have ht : Tendsto (branchPt v β κ) (𝓝[<] ρ) (𝓝 (branchPt v β κ ρ)) :=
    ((continuous_branchPt v β κ).tendsto ρ).mono_left nhdsWithin_le_nhds
  obtain ⟨t, htε, htt⟩ := ((ht.eventually (ball_mem_nhds _ hε)).and (Ioo_mem_nhdsLT hρ)).exists
  exact ⟨t, htt, htε⟩

/-- A branch has points after `ρ` arbitrarily near its point at `ρ`. -/
theorem _root_.HadwigerNelson.Plane.exists_branchPt_near_gt (v : ℂ) (β κ : ℝ) {ρ r : ℝ} (hρr : ρ < r) {ε : ℝ} (hε : 0 < ε) :
    ∃ t ∈ Ioo ρ r, dist (branchPt v β κ t) (branchPt v β κ ρ) < ε := by
  have ht : Tendsto (branchPt v β κ) (𝓝[>] ρ) (𝓝 (branchPt v β κ ρ)) :=
    ((continuous_branchPt v β κ).tendsto ρ).mono_left nhdsWithin_le_nhds
  obtain ⟨t, htε, htt⟩ := ((ht.eventually (ball_mem_nhds _ hε)).and (Ioo_mem_nhdsGT hρr)).exists
  exact ⟨t, htt, htε⟩

namespace Near

variable {F : ArcMap k} {v : ℂ}

/-- **The points of a move's disc, read in the chart of the map before it** (`not_isSite_of_branches` with the chart's germs and
finitely many extra branches `𝒠` — SHAVE's arc, OPEN's ray — each apart from the germs and from one another). -/
theorem not_isSite_of_chart (X : F.Near v) {R ρ₁ : ℝ} (hR : X.Small R) (hρ₁ : 0 < ρ₁) (hρ₁R : ρ₁ < R) {M : ArcMap k}
    (hc : M.IsClean) (hdom : M.dom = F.dom) (𝒠 : Finset (ℝ × ℝ)) (hcurv : ∀ g ∈ 𝒠, |g.2| * R < 2)
    (hapart : ∀ g ∈ 𝒠, ∀ t ∈ Ioo 0 R, (∀ i, branchPt v g.1 g.2 t ≠ branchPt v (X.G.β i) (X.G.κ i) t) ∧
      ∀ g' ∈ 𝒠, branchPt v g.1 g.2 t = branchPt v g'.1 g'.2 t → g = g')
    (hΓ : ∀ z ∈ M.Γ, z ∈ ball v R → z ≠ v → z ∈ sphere v ρ₁ ∨ (∃ i, z = branchPt v (X.G.β i) (X.G.κ i) ‖z - v‖) ∨
      ∃ g ∈ 𝒠, z = branchPt v g.1 g.2 ‖z - v‖)
    {x : ℂ} (hx : x ∈ ball v R) (hxv : x ≠ v)
    (hdead : ∀ i, x = branchPt v (X.G.β i) (X.G.κ i) ρ₁ → ∀ ε > 0, ∃ w ∈ ball x ε, w ≠ x ∧
      (w ∈ sphere v ρ₁ ∨ ∃ t ∈ Icc 0 R, w = branchPt v (X.G.β i) (X.G.κ i) t) ∧ w ∉ M.Γ)
    (hdeadE : ∀ g ∈ 𝒠, x = branchPt v g.1 g.2 ρ₁ → ∀ ε > 0, ∃ w ∈ ball x ε, w ≠ x ∧
      (w ∈ sphere v ρ₁ ∨ ∃ t ∈ Icc 0 R, w = branchPt v g.1 g.2 t) ∧ w ∉ M.Γ) :
    ¬ M.IsSite x ∧ (M.coloursAt x).ncard ≤ 3 := by
  classical
  set 𝒢 : Finset (ℝ × ℝ) := (Finset.univ.image fun i : Fin X.n => (X.G.β i, X.G.κ i)) ∪ 𝒠 with h𝒢
  have hmem : ∀ g ∈ 𝒢, (∃ i : Fin X.n, g = (X.G.β i, X.G.κ i)) ∨ g ∈ 𝒠 := by
    intro g hg
    rcases Finset.mem_union.mp hg with h | h
    · obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp h
      exact Or.inl ⟨i, rfl⟩
    · exact Or.inr h
  have hsub : ball v R ⊆ M.dom := by rw [hdom]; exact X.hG.subdom.trans' (ball_subset_ball hR.2.2.1.le)
  refine not_isSite_of_branches hc hρ₁ hρ₁R hsub 𝒢 ?_ ?_ ?_ hx hxv ?_
  · intro g hg
    rcases hmem g hg with ⟨i, rfl⟩ | h
    · exact lt_of_le_of_lt (mul_le_mul_of_nonneg_left hR.lt_r₀.le (abs_nonneg _)) (X.hC.curv i)
    · exact hcurv g h
  · intro g hg g' hg' t ht heq
    have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, ht.2.trans hR.2.1⟩
    rcases hmem g hg with ⟨i, rfl⟩ | h <;> rcases hmem g' hg' with ⟨i', rfl⟩ | h'
    · rw [eq_of_branchPt_eq X.hdisj hts heq]
    · exact absurd heq.symm ((hapart g' h' t ht).1 i)
    · exact absurd heq ((hapart g h t ht).1 i')
    · exact (hapart g h t ht).2 g' h' heq
  · intro z hz hzR hzv
    rcases hΓ z hz hzR hzv with h | ⟨i, hi⟩ | ⟨g, hg, hzg⟩
    · exact Or.inl h
    · exact Or.inr ⟨(X.G.β i, X.G.κ i), Finset.mem_union_left _ (Finset.mem_image.mpr ⟨i, Finset.mem_univ _, rfl⟩), hi⟩
    · exact Or.inr ⟨g, Finset.mem_union_right _ hg, hzg⟩
  · intro g hg hxg
    rcases hmem g hg with ⟨i, rfl⟩ | h
    · exact hdead i hxg
    · exact hdeadE g h hxg

/-- **Points of the circle of radius `ρ` in the chart sector after a germ, arbitrarily near the germ's point there.** -/
theorem exists_rim_mem_sector (X : F.Near v) {R ρ : ℝ} (hR : X.Small R) (hρ : 0 < ρ) (hρR : ρ < R) (i : Fin X.n) {ε : ℝ}
    (hε : 0 < ε) :
    ∃ w ∈ X.G.sector v R i, dist w v = ρ ∧ dist w (branchPt v (X.G.β i) (X.G.κ i) ρ) < ε := by
  have hρs : ρ ∈ Ioo 0 X.s₀ := ⟨hρ, hρR.trans hR.2.1⟩
  have hgap : 0 < X.G.nextDir i ρ - X.G.dir i ρ := sub_pos.mpr (X.hord ρ hρs i)
  have ht : Tendsto (fun t : ℝ => v + (ρ : ℂ) * e (X.G.dir i ρ + t)) (𝓝[>] 0)
      (𝓝 (branchPt v (X.G.β i) (X.G.κ i) ρ)) := by
    have hc : Continuous fun t : ℝ => v + (ρ : ℂ) * e (X.G.dir i ρ + t) :=
      continuous_const.add (continuous_const.mul (continuous_e.comp (continuous_const.add continuous_id)))
    have := (hc.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
    simpa [branchPt_eq, BranchGerms.dir] using this
  obtain ⟨t, htε, htt⟩ := ((ht.eventually (ball_mem_nhds _ hε)).and (Ioo_mem_nhdsGT hgap)).exists
  refine ⟨_, ⟨ρ, ⟨hρ, hρR⟩, X.G.dir i ρ + t, ⟨show X.G.dir i ρ < X.G.dir i ρ + t by linarith [htt.1],
    show X.G.dir i ρ + t < X.G.nextDir i ρ by linarith [htt.2]⟩, rfl⟩, ?_, htε⟩
  rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hρ.le]

/-- **Points of the circle of radius `ρ` in the chart sector before a germ, arbitrarily near the germ's point there.** -/
theorem exists_rim_mem_sector_before (X : F.Near v) {R ρ : ℝ} (hR : X.Small R) (hρ : 0 < ρ) (hρR : ρ < R) (p : Fin X.n)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ w ∈ X.G.sector v R p, dist w v = ρ ∧
      dist w (branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) ρ) < ε := by
  have hρs : ρ ∈ Ioo 0 X.s₀ := ⟨hρ, hρR.trans hR.2.1⟩
  have hgap : 0 < X.G.nextDir p ρ - X.G.dir p ρ := sub_pos.mpr (X.hord ρ hρs p)
  have ht : Tendsto (fun t : ℝ => v + (ρ : ℂ) * e (X.G.nextDir p ρ - t)) (𝓝[>] 0)
      (𝓝 (branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) ρ)) := by
    have hc : Continuous fun t : ℝ => v + (ρ : ℂ) * e (X.G.nextDir p ρ - t) :=
      continuous_const.add (continuous_const.mul (continuous_e.comp (continuous_const.sub continuous_id)))
    have := (hc.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
    have he : v + (ρ : ℂ) * e (X.G.nextDir p ρ) =
        branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) ρ := by
      rw [branchPt_eq, BranchGerms.nextDir, germDir, germDir, e_add, e_add, X.G.e_nextβ, BranchGerms.nextκ_eq]
    simpa [he] using this
  obtain ⟨t, htε, htt⟩ := ((ht.eventually (ball_mem_nhds _ hε)).and (Ioo_mem_nhdsGT hgap)).exists
  refine ⟨_, ⟨ρ, ⟨hρ, hρR⟩, X.G.nextDir p ρ - t, ⟨show X.G.dir p ρ < X.G.nextDir p ρ - t by linarith [htt.2],
    show X.G.nextDir p ρ - t < X.G.nextDir p ρ by linarith [htt.1]⟩, rfl⟩, ?_, htε⟩
  rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hρ.le]

variable {X : F.Near v} {ρ : ℝ} {h : X.Small ρ} {K : Set (Fin X.n)} {E : Set Arc} {col' : ℂ → Fin k}
  {hE : ∀ a ∈ E, a.Nondegenerate} {hEf : E.Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ K E, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}

/-- **A chart sector on which a move keeps the map's colour holds no arc of the cleaned move** (out to any small radius `R` above
the move's): on both sides of the rim the sector has its one colour. -/
theorem move_not_mem_cleanKeep_Γ {R : ℝ} (hR : X.Small R)
    (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z) {i : Fin X.n} (hi : ∀ z ∈ X.G.sector v ρ i, col' z = X.col i) {w : ℂ}
    (hw : w ∈ X.G.sector v R i) : w ∉ (X.move h K E col' hE hEf hlc).cleanKeep.Γ := by
  refine not_mem_cleanKeep_Γ_of_const (X.hC.isOpen R hR.mem_Ioc i) hw (a := X.col i) fun y hy hyI => ?_
  rcases lt_trichotomy (dist y v) ρ with hlt | heq | hgt
  · rw [move_col]
    exact hi y (mem_sector_of_lt hy (by rwa [← dist_eq_norm]))
  · exact absurd hyI (not_mem_move_interiorPts_of_sphere heq)
  · have hyc : y ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
    rw [move_col, hcol y hyc]
    have := (X.hcol i R hR.mem_Ioc hy).2
    simpa using this

/-- **The arcs of a move near `v`, off `v`**: the rim circle, a branch of the chart, or an extra arc. -/
theorem move_Γ_cases {R : ℝ} (hR : X.Small R) (hK : K.Nonempty) (hEin : ∀ a ∈ E, a.carrier ⊆ closedBall v ρ) {z : ℂ}
    (hz : z ∈ (X.move h K E col' hE hEf hlc).Γ) (hzR : z ∈ ball v R) (hzv : z ≠ v) :
    z ∈ sphere v ρ ∨ (∃ i, z = branchPt v (X.G.β i) (X.G.κ i) ‖z - v‖) ∨ (z ∈ ball v ρ ∧ z ∈ ⋃ a ∈ E, a.carrier) := by
  rcases lt_trichotomy (dist z v) ρ with hlt | heq | hgt
  · have hzn : z ∈ ⋃ a ∈ X.newArcs ρ K E, a.carrier := by
      by_contra hcon
      exact ((mem_move_interiorPts_iff (h := h) (hE := hE) (hEf := hEf) (hlc := hlc) hlt).mpr hcon).2 hz.2
    rcases (mem_newArcs_iff h hK hlt).mp hzn with h1 | ⟨-, i, -, h2⟩ | h3
    · exact absurd h1 hzv
    · exact Or.inr (Or.inl ⟨i, h2⟩)
    · exact Or.inr (Or.inr ⟨hlt, h3⟩)
  · exact Or.inl heq
  · have hzc : z ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
    have hzI : z ∉ F.interiorPts := fun hI =>
      ((mem_move_interiorPts_iff_of_not_mem (h := h) (hE := hE) (hEf := hEf) (hlc := hlc) hEin hzc).mpr hI).2 hz.2
    exact Or.inr (Or.inl (X.hC.exists_branchPt_eq hzv (ball_subset_ball hR.lt_r₀.le hzR) hzI))

end Near

namespace Near

variable {F : ArcMap k} {v : ℂ} {X : F.Near v} {ρ α κ₁ κ₂ κ₃ κ₄ : ℝ} {i₀ i₁ : Fin X.n}

/-- **The vertex step from a ray merge** (FS110-N4-RAY's construction, cleaned): `Near.move` with the kept germs `rayKeep` and the
colouring `rayCol`, then `cleanKeep`. The count is `pot_lt_of_interior` at the lower horn's upper germ, which the merge drops; a
point of the rim on a kept germ has the sector after the germ of one colour on both sides of the rim, a point on a dropped germ has
the germ's inner branch interior to the merged horn (`not_isSite_of_chart`). The gap need hold no chart sector of another colour
only: `RayConfig.exists_merge`'s hypothesis `hfree` is not read, so the two given horns serve as they are. -/
theorem RayConfig.exists_step (hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁) {R : ℝ} (hRs : X.Small R) (hρR : ρ < R) (hF : F.Valid)
    (hc : F.IsClean) {c : Fin k} (hci₀ : X.col i₀ = c) (hci₁ : X.col i₁ = c)
    (hclear : ∀ z ∈ hornSet v α κ₂ κ₃ ρ, F.IsClear c z) {m j : ℕ} (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  have h := hR.small
  have hn0 : 0 < X.n := i₀.pos
  obtain ⟨-, hκ2, hκ3, -⟩ := hR.abs_curv_le
  have hEnd : ∀ a ∈ (∅ : Set Arc), a.Nondegenerate := fun a ha => absurd ha (notMem_empty a)
  have hEin : ∀ a ∈ (∅ : Set Arc), a.carrier ⊆ closedBall v ρ := fun a ha => absurd ha (notMem_empty a)
  have hcol : ∀ z ∉ closedBall v ρ, F.rayCol v α κ₁ κ₄ ρ c z = F.col z := fun z hz =>
    rayCol_of_not_mem fun hz' => hz (ball_subset_closedBall hz'.1)
  have hK : (X.rayKeep α κ₂ κ₃).Nonempty := ⟨i₀, hR.mem_keep₀⟩
  set F₁ := X.move h (X.rayKeep α κ₂ κ₃) ∅ (F.rayCol v α κ₁ κ₄ ρ c) hEnd finite_empty (hR.hlc c) with hF₁
  have hint : ∀ z ∈ ball v ρ, z ∈ F₁.interiorPts ↔ z ∈ hornSet v α κ₁ κ₄ ρ ∨ z ∈ F.interiorPts := by
    intro z hz
    rw [mem_move_interiorPts_iff hz, mem_newArcs_iff h hK hz, ← hR.off_keep_iff hz]
    constructor
    · intro hn
      push Not at hn
      obtain ⟨hzv, hzb, -⟩ := hn
      exact ⟨hzv, fun i hi => hzb hzv i hi⟩
    · rintro ⟨hzv, hzb⟩ (h1 | ⟨-, i, hi, h2⟩ | h3)
      · exact hzv h1
      · exact hzb i hi h2
      · simp at h3
  have hcolc : ∀ {i : Fin X.n}, X.col i = c → ∀ z ∈ X.G.sector v ρ i, F.IsClear c z := fun {i} hic z hz => by
    have hI := X.hC.sector_subset_interiorPts hn0 h.mem_Ioc i hz
    have hzc : F.col z = c := by
      have := (X.hcol i ρ h.mem_Ioc hz).2
      simp only [mem_preimage, mem_singleton_iff] at this
      rw [this, hic]
    have := isClear_col hF hI
    rwa [hzc] at this
  have hval : F₁.Valid := by
    refine move_valid hF hEin hcol fun z hz hzI => ?_
    by_cases hM : z ∈ hornSet v α κ₁ κ₄ ρ
    · rw [rayCol_of_mem hM]
      have hzρ : ‖z - v‖ < ρ := by rw [← dist_eq_norm]; exact hz
      have hzv : z ≠ v := fun h' => by have := hM.2.1; rw [h', frameX_self] at this; exact lt_irrefl 0 this
      have hz0 : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
      rcases RayGap.mem_hornSet_cases hM (hR.curv_lt hκ2 hzρ.le).le (hR.curv_lt hκ3 hzρ.le).le with
        h1 | h1 | h1 | h1 | h1
      · exact hcolc hci₀ z (by rw [hR.sec₀ ρ h.mem_Ioc]; exact h1)
      · refine isClear_of_mem_closure hclear ?_
        rw [h1]; exact branchPt_mem_closure_hornSet_lower v α hR.h23 hz0 hzρ (hR.curv_lt hκ2 hzρ.le)
      · exact hclear z h1
      · refine isClear_of_mem_closure hclear ?_
        rw [h1]; exact branchPt_mem_closure_hornSet_upper v α hR.h23 hz0 hzρ (hR.curv_lt hκ3 hzρ.le)
      · exact hcolc hci₁ z (by rw [hR.sec₁ ρ h.mem_Ioc]; exact h1)
    · rw [rayCol_of_not_mem hM]
      exact isClear_col hF (((hint z hz).mp hzI).resolve_left hM)
  have hself : F₁.coloursAt v ⊆ F.coloursAt v := by
    refine move_coloursAt_self fun z hz hzI => ?_
    by_cases hM : z ∈ hornSet v α κ₁ κ₄ ρ
    · left
      rw [rayCol_of_mem hM]
      show v ∈ closure (F.region c)
      rw [← hci₀]
      exact closure_mono (X.hcol₀ i₀) (X.hC.mem_closure_sector X.hs₀ i₀)
    · right
      exact ⟨((hint z hz).mp hzI).resolve_left hM, rayCol_of_not_mem hM⟩
  -- the points of the disc other than `v`
  have hpts : ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F₁.cleanKeep.IsSite x ∧ (F₁.cleanKeep.coloursAt x).ncard ≤ 3 := by
    intro x hx hxv
    refine X.not_isSite_of_chart (M := F₁.cleanKeep) hRs h.1 hρR cleanKeep_isClean rfl ∅ (by simp) (by simp) ?_
      (closedBall_subset_ball hρR hx) hxv ?_ (by simp)
    · intro z hz hzR hzv
      rcases move_Γ_cases hRs hK hEin (cleanKeep_Γ_subset _ hz) hzR hzv with h1 | h1 | ⟨-, h1⟩
      · exact Or.inl h1
      · exact Or.inr (Or.inl h1)
      · simp at h1
    · intro i hxi ε hε
      by_cases hi : i ∈ X.rayKeep α κ₂ κ₃
      · -- a kept germ: the rim points in the sector after it
        obtain ⟨w, hw, hwρ, hwx⟩ := X.exists_rim_mem_sector hRs h.1 hρR i hε
        refine ⟨w, by rw [mem_ball, hxi]; exact hwx, fun hwx' => ?_, Or.inl hwρ, ?_⟩
        · have hI := sector_subset_interiorPts hRs i hw
          rw [hwx', hxi] at hI
          exact hI.2 (X.hC.branchPt_mem_Γ i ⟨h.1, h.lt_r₀⟩).2
        · refine move_not_mem_cleanKeep_Γ hRs hcol (i := i) (fun z hz => ?_) hw
          by_cases hi0 : i = i₀
          · rw [hi0] at hz ⊢
            rw [hR.sec₀ ρ h.mem_Ioc] at hz
            rw [rayCol_of_mem (hornSet_mono le_rfl (by linarith [hR.h23, hR.h34]) hz), hci₀]
          · have hi1 : i ≠ i₁ := fun h' => hi (by
              rw [h']; exact ⟨hR.germ₃.1, by rw [hR.germ₃.2]; exact hR.h23.le, le_of_eq hR.germ₃.2⟩)
            have hG : ¬ X.G.sector v ρ i ⊆ hornSet v α κ₂ κ₃ ρ := fun hsub => by
              obtain ⟨-, hβ, hk2, hlt, hk3⟩ := hR.gap_sector ⟨z, hz, hsub hz⟩
              exact hi ⟨hβ, hk2, hlt.le.trans hk3⟩
            rw [rayCol_of_not_mem (disjoint_left.mp (hR.sector_disjoint hi0 hi1 hG) hz)]
            have := (X.hcol i ρ h.mem_Ioc hz).2
            simpa using this
      · -- a dropped germ: its inner branch is interior to the merged horn
        simp only [rayKeep, mem_setOf_eq, not_not] at hi
        obtain ⟨hβ, hk2, hk3⟩ := hi
        obtain ⟨t, ht, htε⟩ := exists_branchPt_near_lt v (X.G.β i) (X.G.κ i) h.1 hε
        have hκi : |X.G.κ i| ≤ 1 := abs_le.mpr ⟨by linarith [hR.h1, hR.h12], by linarith [hR.h34, hR.h4]⟩
        have htb : branchPt v (X.G.β i) (X.G.κ i) t ∈ ball v ρ := by
          rw [mem_ball, dist_branchPt i ht.1.le]; exact ht.2
        refine ⟨_, by rw [mem_ball, hxi]; exact htε, fun heq => ?_,
          Or.inr ⟨t, ⟨ht.1.le, (ht.2.trans hρR).le⟩, rfl⟩, fun hΓ => ?_⟩
        · have := congrArg (fun z => dist z v) heq
          simp only [hxi, dist_branchPt i ht.1.le, dist_branchPt i h.1.le] at this
          linarith [ht.2]
        · have hI : branchPt v (X.G.β i) (X.G.κ i) t ∈ F₁.interiorPts := by
            refine (hint _ htb).mpr (Or.inl ?_)
            rw [branchPt_congr_dir hβ]
            exact branchPt_mem_hornSet v α (by linarith [hR.h12]) (by linarith [hR.h34]) ht.1 ht.2
              (hR.curv_lt hκi ht.2.le)
          exact hI.2 (cleanKeep_Γ_subset _ hΓ).2
  have hvd : v ∈ F₁.cleanKeep.dom := X.mem_dom
  obtain ⟨m', -, hm'⟩ := exists_hasDegree_of_mem_dom hvd
  obtain ⟨j', hj'⟩ := exists_hasHornCount hvd
  refine ⟨F₁.cleanKeep, cleanKeep_valid hval, cleanKeep_isClean,
    surgery_cleanKeep_localStep hc (newArcs_subset_closedBall h hEin) hcol,
    ⟨rfl, fun p x hp => move_ringArcsWithin (fun a ha => absurd ha (notMem_empty a)) p x
      (cleanKeep_isModification.ringArcsWithin p x hp), fun x h4 => ?_⟩,
    ⟨m', j', pot_lt_of_interior X (X.two_le_of_isClean hc hn0) ?_ (p := i₀) ?_ hdeg hhorn hm' hj', hm', hj'⟩,
    by rw [coloursAt_cleanKeep]; exact hself, fun x hx hxv => (hpts x hx hxv).1⟩
  · rw [coloursAt_cleanKeep]
    by_cases hxb : x ∈ closedBall v ρ
    · by_cases hxv : x = v
      · rw [hxv]; exact hself
      · have := (hpts x hxb hxv).2
        rw [coloursAt_cleanKeep] at this h4
        omega
    · exact (coloursAt_eq_of_agreesOn (W := (closedBall v ρ)ᶜ) (by rw [compl_compl]; exact move_agreesOff hEin hcol)
        isClosed_closedBall.isOpen_compl hxb).subset
  · filter_upwards [Ioo_mem_nhdsGT h.1] with r hr
    rintro z ⟨hzI, hzb⟩
    exact F₁.interiorPts_subset_cleanKeep ((hint z (ball_subset_ball hr.2.le hzb)).mpr (Or.inr hzI))
  · filter_upwards [Ioo_mem_nhdsGT h.1] with s hs
    refine F₁.interiorPts_subset_cleanKeep ((hint _ ?_).mpr (Or.inl ?_))
    · rw [mem_ball, dist_branchPt _ hs.1.le]; exact hs.2
    · rw [branchPt_congr_dir hR.germ₂.1, hR.germ₂.2]
      exact branchPt_mem_hornSet v α hR.h12 (by linarith [hR.h23, hR.h34]) hs.1 hs.2 (hR.curv_lt hκ2 hs.2.le)

end Near

/-- test: the case -/
theorem exists_rayStep' {F : ArcMap k} (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k} {n : ℕ}
    (hn : F.HasSectors v c (n + 1)) (h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) {m j : ℕ} (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  have _ := hn
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨i₀, hβ₀, hnβ₀, hκ₀, hnκ₀, hci₀, hsec₀⟩ := X.horn_index hH
  obtain ⟨i₁, hβ₁, hnβ₁, hκ₁', hnκ₁, hci₁, hsec₁⟩ := X.horn_index hH'
  obtain ⟨R, hRs, hRδ⟩ := (X.eventually_small.and (Ioo_mem_nhdsGT hδ)).exists
  obtain ⟨ρ, ⟨hs, hcl⟩, hρR⟩ :=
    ((X.eventually_small.and (ray_clear hF h23 hH hH' h1 h4)).and (Ioo_mem_nhdsGT hRs.1)).exists
  have hR : X.RayConfig ρ α κ₁ κ₂ κ₃ κ₄ i₀ i₁ :=
    { small := hs, sec₀ := hsec₀, sec₁ := hsec₁, germ₀ := ⟨hβ₀, hκ₀⟩,
      germ₂ := ⟨by rw [← BranchGerms.e_nextβ, hnβ₀, hβ₀], by rw [← BranchGerms.nextκ_eq, hnκ₀]⟩,
      germ₃ := ⟨hβ₁, hκ₁'⟩,
      germ₄ := ⟨by rw [← BranchGerms.e_nextβ, hnβ₁, hβ₁], by rw [← BranchGerms.nextκ_eq, hnκ₁]⟩,
      h1 := h1, h12 := hH.1, h23 := h23, h34 := hH'.1, h4 := h4 }
  exact ⟨ρ, hs.1, hρR.2.trans hRδ.2, hR.exists_step hRs hρR.2 hF hc hci₀ hci₁ hcl hdeg hhorn⟩

end ArcMap

end HadwigerNelson.Plane
