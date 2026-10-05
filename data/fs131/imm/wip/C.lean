import Proofs.HadwigerNelson.Plane.ValidMap.MergeMove
-- FS131-IMM4 working file (iteration only; moved into `MergeMove` at each stage).

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **The height above the tangent circle along a segment**: `tanHeight κ` in plane coordinates is a quadratic with Hessian `−κ`. -/
theorem tanHeight_combo (κ : ℝ) (y z : ℂ) (t : ℝ) :
    tanHeight κ ((1 - t) • y + t • z).re ((1 - t) • y + t • z).im =
      (1 - t) * tanHeight κ y.re y.im + t * tanHeight κ z.re z.im + κ / 2 * t * (1 - t) * ‖y - z‖ ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply]
  simp only [tanHeight, Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, Complex.sub_re, Complex.sub_im,
    smul_eq_mul]
  ring

/-- The inequality behind a side's star: the height at a point of the segment from the star's centre stays positive. -/
theorem side_ineq {b r K D S0 Sz : ℝ} (hb0 : 0 ≤ b) (hb1 : b ≤ 1) (hr : 0 < r) (hK : 0 ≤ K) (hKr : K * r ≤ 2 / 5)
    (hS0 : r / 2 - K * r ^ 2 / 8 ≤ S0) (hSz : 0 < Sz) (hD : D ≤ 9 * r ^ 2 / 4) :
    0 < (1 - b) * S0 + b * Sz - K / 2 * b * (1 - b) * D := by
  have hbD : b * D ≤ 9 * r ^ 2 / 4 := by nlinarith
  have h1 : K / 2 * b * (1 - b) * D ≤ (1 - b) * (9 / 8 * K * r ^ 2) := by
    have h2 : 0 ≤ K * (1 - b) := mul_nonneg hK (by linarith)
    nlinarith
  have h3 : 5 / 4 * K * r ^ 2 ≤ r / 2 := by nlinarith
  rcases eq_or_lt_of_le hb0 with hb | hb
  · subst hb; nlinarith
  · nlinarith [mul_pos hb hSz]


/-- **A side of a tangent circle inside a small ball is preconnected** (in plane coordinates): for `w₀` on the circle of curvature `κ`
through `0` (`tanHeight κ = 0`) and `|κ| r ≤ 2/5`, each side `{σ · tanHeight > 0}` of it inside `B(w₀, r)` is star-convex about the
point at distance `r/2` from `w₀` along its normal, on that side — one argument for both sides and every sign of `κ`. -/
theorem isPreconnected_side_plane {κ σ r : ℝ} {w₀ : ℂ} (hT : tanHeight κ w₀.re w₀.im = 0) (hσ : σ = 1 ∨ σ = -1) (hr : 0 < r)
    (hκr : |κ| * r ≤ 2 / 5) : IsPreconnected {w : ℂ | w ∈ ball w₀ r ∧ 0 < σ * tanHeight κ w.re w.im} := by
  set u := σ * r / 2 with hu
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hσκ : -|κ| ≤ σ * κ ∧ σ * κ ≤ |κ| := by
    rcases hσ with rfl | rfl
    · simp only [one_mul]; exact ⟨neg_abs_le κ, le_abs_self κ⟩
    · constructor <;> [linarith [le_abs_self κ]; linarith [neg_abs_le κ]]
  set y₀ : ℂ := ⟨w₀.re * (1 - u * κ), w₀.im + u * (1 - κ * w₀.im)⟩ with hy₀
  have hT' : w₀.im - κ * (w₀.re ^ 2 + w₀.im ^ 2) / 2 = 0 := hT
  have hdist : ‖y₀ - w₀‖ = r / 2 := by
    have h2 : ‖y₀ - w₀‖ ^ 2 = (r / 2) ^ 2 := by
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp only [hy₀, Complex.sub_re, Complex.sub_im]
      have : u ^ 2 = (r / 2) ^ 2 := by rw [hu]; nlinarith [hσ2]
      linear_combination (-(2 * κ * u ^ 2)) * hT' + this
    exact (sq_eq_sq₀ (norm_nonneg _) (by linarith)).mp h2
  have hTy : σ * tanHeight κ y₀.re y₀.im = r / 2 - σ * κ * r ^ 2 / 8 := by
    have h1 : tanHeight κ y₀.re y₀.im = u - κ * u ^ 2 / 2 := by
      simp only [tanHeight, hy₀]
      linear_combination (1 - u * κ) ^ 2 * hT'
    rw [h1, hu]
    have : σ * (σ * r / 2 - κ * (σ * r / 2) ^ 2 / 2) = σ ^ 2 * (r / 2) - σ * σ ^ 2 * κ * r ^ 2 / 8 := by ring
    rw [this, hσ2]; ring
  have hy₀S : y₀ ∈ {w : ℂ | w ∈ ball w₀ r ∧ 0 < σ * tanHeight κ w.re w.im} := by
    refine ⟨by rw [mem_ball, dist_eq_norm, hdist]; linarith, ?_⟩
    rw [hTy]
    have : σ * κ * r ^ 2 / 8 ≤ |κ| * r ^ 2 / 8 := by nlinarith [hσκ.2]
    nlinarith
  have hstar : StarConvex ℝ y₀ {w : ℂ | w ∈ ball w₀ r ∧ 0 < σ * tanHeight κ w.re w.im} := by
    intro z hz a b ha hb hab
    refine ⟨(convex_ball w₀ r) hy₀S.1 hz.1 ha hb hab, ?_⟩
    obtain rfl : a = 1 - b := by linarith
    rw [tanHeight_combo]
    have hyz : ‖y₀ - z‖ < 3 * r / 2 := by
      have := norm_sub_le_norm_sub_add_norm_sub y₀ w₀ z
      have hz' : ‖w₀ - z‖ < r := by rw [← dist_eq_norm, dist_comm]; exact hz.1
      linarith
    have hD : ‖y₀ - z‖ ^ 2 ≤ 9 * r ^ 2 / 4 := by nlinarith [norm_nonneg (y₀ - z)]
    have hS0 : r / 2 - |κ| * r ^ 2 / 8 ≤ σ * tanHeight κ y₀.re y₀.im := by rw [hTy]; nlinarith [hσκ.2]
    have hmain := side_ineq hb (by linarith) hr (abs_nonneg κ) hκr hS0 hz.2 hD
    have hlow : -(|κ| / 2 * b * (1 - b) * ‖y₀ - z‖ ^ 2) ≤ σ * (κ / 2 * b * (1 - b) * ‖y₀ - z‖ ^ 2) := by
      have hnn : 0 ≤ b * (1 - b) * ‖y₀ - z‖ ^ 2 := mul_nonneg (mul_nonneg hb (by linarith)) (sq_nonneg _)
      nlinarith [hσκ.1]
    nlinarith
  exact (hstar.isPathConnected hy₀S).isConnected.isPreconnected


/-- The frame along `e β` at `v` reads `v + w e β` as `w`. -/
theorem frame_mul_e (v : ℂ) (β : ℝ) (w : ℂ) : (v + w * e β - v) * starRingEnd ℂ (e β) = w := by
  rw [add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]

/-- **A side of a germ's tangent circle inside a small ball is preconnected**: for `x` on the circle of curvature `κ` tangent to
`e β` at `v` and `|κ| r ≤ 2/5`, each side `{σ · tanHeight > 0}` of it inside `B(x, r)` is preconnected (the plane form, moved by the
frame's isometry). -/
theorem isPreconnected_side (v : ℂ) (β κ : ℝ) {σ r : ℝ} {x : ℂ} (hT : tanHeight κ (frameX v β x) (frameY v β x) = 0)
    (hσ : σ = 1 ∨ σ = -1) (hr : 0 < r) (hκr : |κ| * r ≤ 2 / 5) :
    IsPreconnected {z : ℂ | z ∈ ball x r ∧ 0 < σ * tanHeight κ (frameX v β z) (frameY v β z)} := by
  set Φ : ℂ → ℂ := fun z => (z - v) * starRingEnd ℂ (e β) with hΦ
  have hW := isPreconnected_side_plane (w₀ := Φ x) hT hσ hr hκr
  have hx : x = v + Φ x * e β := by
    simp only [hΦ]; rw [mul_assoc, mul_comm (starRingEnd ℂ (e β)), e_mul_conj_e, mul_one]; ring
  have heq : {z : ℂ | z ∈ ball x r ∧ 0 < σ * tanHeight κ (frameX v β z) (frameY v β z)} =
      (fun w => v + w * e β) '' {w : ℂ | w ∈ ball (Φ x) r ∧ 0 < σ * tanHeight κ w.re w.im} := by
    ext z
    constructor
    · rintro ⟨hz, hzT⟩
      refine ⟨Φ z, ⟨?_, hzT⟩, ?_⟩
      · rw [mem_ball, dist_eq_norm, show Φ z - Φ x = (z - x) * starRingEnd ℂ (e β) by simp only [hΦ]; ring, norm_mul,
          Complex.norm_conj, norm_e, mul_one, ← dist_eq_norm]; exact hz
      · show v + (z - v) * starRingEnd ℂ (e β) * e β = z
        rw [mul_assoc, mul_comm (starRingEnd ℂ (e β)), e_mul_conj_e, mul_one]; ring
    · rintro ⟨w, ⟨hw, hwT⟩, rfl⟩
      have hfr : (v + w * e β - v) * starRingEnd ℂ (e β) = w := frame_mul_e v β w
      refine ⟨?_, ?_⟩
      · rw [mem_ball, dist_eq_norm]
        conv_lhs => rw [hx]
        rw [show v + w * e β - (v + Φ x * e β) = (w - Φ x) * e β by ring, norm_mul, norm_e, mul_one, ← dist_eq_norm]
        exact hw
      · show 0 < σ * tanHeight κ ((v + w * e β - v) * starRingEnd ℂ (e β)).re ((v + w * e β - v) * starRingEnd ℂ (e β)).im
        rw [hfr]; exact hwT
  rw [heq]
  exact hW.image _ (by fun_prop)


/-- **Two open pieces covered by two preconnected sides are the sides**: if disjoint, open, non-empty `A` and `B` have the union of
two preconnected sets `P` and `Q`, then each of `A`, `B` is one of `P`, `Q`, so both are preconnected. -/
theorem isPreconnected_of_two_sides {A B P Q : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAB : Disjoint A B)
    (hAn : A.Nonempty) (hBn : B.Nonempty) (hP : IsPreconnected P) (hQ : IsPreconnected Q) (hPQ : A ∪ B = P ∪ Q) :
    IsPreconnected A ∧ IsPreconnected B := by
  have hPs : P ⊆ A ∪ B := hPQ ▸ subset_union_left
  have hQs : Q ⊆ A ∪ B := hPQ ▸ subset_union_right
  have key : ∀ {Y Z : Set ℂ}, Y ⊆ A → Z ⊆ B → A ∪ B = Y ∪ Z → A = Y ∧ B = Z := by
    intro Y Z hY hZ hYZ
    constructor
    · refine Subset.antisymm (fun z hz => ?_) hY
      rcases (hYZ ▸ Or.inl hz : z ∈ Y ∪ Z) with h | h
      · exact h
      · exact absurd (hZ h) (disjoint_left.mp hAB hz)
    · refine Subset.antisymm (fun z hz => ?_) hZ
      rcases (hYZ ▸ Or.inr hz : z ∈ Y ∪ Z) with h | h
      · exact absurd (hY h) (disjoint_right.mp hAB hz)
      · exact h
  rcases hP.subset_or_subset hA hB hAB hPs with hPA | hPB <;>
    rcases hQ.subset_or_subset hA hB hAB hQs with hQA | hQB
  · exfalso
    obtain ⟨z, hz⟩ := hBn
    rcases (hPQ ▸ Or.inr hz : z ∈ P ∪ Q) with h | h
    · exact disjoint_left.mp hAB (hPA h) hz
    · exact disjoint_left.mp hAB (hQA h) hz
  · obtain ⟨h1, h2⟩ := key hPA hQB hPQ; exact ⟨h1 ▸ hP, h2 ▸ hQ⟩
  · obtain ⟨h1, h2⟩ := key hQA hPB (by rw [hPQ, union_comm]); exact ⟨h1 ▸ hQ, h2 ▸ hP⟩
  · exfalso
    obtain ⟨z, hz⟩ := hAn
    rcases (hPQ ▸ Or.inl hz : z ∈ P ∪ Q) with h | h
    · exact disjoint_right.mp hAB (hPB h) hz
    · exact disjoint_right.mp hAB (hQB h) hz

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v}

/-- **The sides lemma** (record § 5.2, § 8.2 item 1): near a germ's point at a small distance `ρ`, the two chart sectors beside the
germ, cut down to a small ball about the point, are preconnected — each is one side of the germ's tangent circle in the ball
(`isPreconnected_side`), since the circle meets the ball in the branch only (`eq_branchPt_of_tanHeight_eq_zero`). -/
theorem sides_preconnected {ρ ρ' : ℝ} (h' : X.Small ρ') (hρ0 : 0 < ρ) (hρρ' : ρ < ρ') {p j : Fin X.n}
    (hpj : BranchGerms.next p = j) (hpj' : p ≠ j) :
    ∃ ε > 0, ∀ r ∈ Ioo 0 ε,
      IsPreconnected (X.G.sector v ρ' p ∩ ball (branchPt v (X.G.β j) (X.G.κ j) ρ) r) ∧
        IsPreconnected (X.G.sector v ρ' j ∩ ball (branchPt v (X.G.β j) (X.G.κ j) ρ) r) := by
  set β := X.G.β j with hβ
  set κ := X.G.κ j with hκ
  set x := branchPt v β κ ρ with hx
  have hxv : dist x v = ρ := by rw [dist_eq_norm]; exact norm_branchPt_sub v β κ hρ0.le
  have hcurv : |κ| * ρ' ≤ 2 := h'.curv j
  have hcurv' : |κ| * ρ < 2 :=
    lt_of_le_of_lt (mul_le_mul_of_nonneg_left (hρρ'.trans h'.lt_r₀).le (abs_nonneg κ)) (X.hC.curv j)
  obtain ⟨ε₁, hε₁, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ') ⟨h'.1, h'.2.1.le⟩ (p := p)
    ⟨hρ0, hρρ'⟩
  rw [hpj] at hball
  have hX0 : 0 < frameX v β x := frameX_branchPt_pos v β κ hcurv' hρ0
  have hcont : Continuous (frameX v β) := by unfold frameX; fun_prop
  obtain ⟨ε₂, hε₂, hX⟩ := Metric.isOpen_iff.mp (isOpen_lt continuous_const hcont) x hX0
  have hε₃ : 0 < ρ' - ρ := by linarith
  have hε₄ : 0 < 2 / 5 / (|κ| + 1) := by positivity
  refine ⟨min (min ε₁ ε₂) (min (ρ' - ρ) (2 / 5 / (|κ| + 1))), lt_min (lt_min hε₁ hε₂) (lt_min hε₃ hε₄), fun r hr => ?_⟩
  have hr1 : r < ε₁ := hr.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))
  have hr2 : r < ε₂ := hr.2.trans_le ((min_le_left _ _).trans (min_le_right _ _))
  have hr3 : r < ρ' - ρ := hr.2.trans_le ((min_le_right _ _).trans (min_le_left _ _))
  have hr4 : r < 2 / 5 / (|κ| + 1) := hr.2.trans_le ((min_le_right _ _).trans (min_le_right _ _))
  have hκr : |κ| * r ≤ 2 / 5 := by
    rw [lt_div_iff₀ (by positivity)] at hr4
    nlinarith [abs_nonneg κ, hr.1]
  have hB : ball x r ⊆ X.G.sector v ρ' p ∪ X.G.sector v ρ' j ∪ branchPt v β κ '' Ioo 0 ρ' :=
    (ball_subset_ball hr1.le).trans hball
  have hBX : ∀ z ∈ ball x r, 0 < frameX v β z := fun z hz => hX (ball_subset_ball hr2.le hz)
  have hBv : ∀ z ∈ ball x r, ‖z - v‖ < ρ' := fun z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle z x v
    rw [mem_ball] at hz
    linarith
  have hTx : tanHeight κ (frameX v β x) (frameY v β x) = 0 := by
    rw [hx, tanHeight_branchPt v β κ κ hcurv'.le hρ0.le]; ring
  have hbr : ∀ z ∈ branchPt v β κ '' Ioo 0 ρ', tanHeight κ (frameX v β z) (frameY v β z) = 0 := by
    rintro z ⟨t, ht, rfl⟩
    rw [tanHeight_branchPt v β κ κ ((mul_le_mul_of_nonneg_left ht.2.le (abs_nonneg κ)).trans hcurv) ht.1.le]; ring
  have hT0 : ∀ z ∈ ball x r, tanHeight κ (frameX v β z) (frameY v β z) = 0 → z ∈ branchPt v β κ '' Ioo 0 ρ' := by
    intro z hz h0
    have hzv : z ≠ v := fun he => by have := hBX z hz; rw [he, frameX_self] at this; exact lt_irrefl 0 this
    refine ⟨‖z - v‖, ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), hBv z hz⟩, ?_⟩
    exact (eq_branchPt_of_tanHeight_eq_zero (hBX z hz) h0
      ((mul_le_mul_of_nonneg_left (hBv z hz).le (abs_nonneg κ)).trans hcurv)).symm
  have hP := isPreconnected_side v β κ hTx (Or.inl rfl) hr.1 hκr
  have hQ := isPreconnected_side v β κ hTx (Or.inr rfl) hr.1 hκr
  have hmem : ∀ i, ∀ z ∈ X.G.sector v ρ' i, z ∉ branchPt v β κ '' Ioo 0 ρ' := fun i z hz =>
    not_mem_branch_of_mem_sector h' hz j
  refine isPreconnected_of_two_sides ((X.hC.isOpen ρ' h'.mem_Ioc p).inter isOpen_ball)
    ((X.hC.isOpen ρ' h'.mem_Ioc j).inter isOpen_ball)
    ((X.hC.disjoint ρ' h'.mem_Ioc p j hpj').mono inter_subset_left inter_subset_left) ?_ ?_ hP hQ ?_
  · have hcl := IsSectorChart.branchPt_mem_closure_sector_before (v := v) X.hord h'.2.1.le p ⟨hρ0, hρρ'⟩
    rw [hpj] at hcl
    obtain ⟨z, hz⟩ := mem_closure_iff.mp hcl (ball x r) isOpen_ball (mem_ball_self hr.1)
    exact ⟨z, hz.2, hz.1⟩
  · have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h'.2.1.le j ⟨hρ0, hρρ'⟩
    obtain ⟨z, hz⟩ := mem_closure_iff.mp hcl (ball x r) isOpen_ball (mem_ball_self hr.1)
    exact ⟨z, hz.2, hz.1⟩
  · ext z
    constructor
    · rintro (⟨hzs, hz⟩ | ⟨hzs, hz⟩)
      · have hne : tanHeight κ (frameX v β z) (frameY v β z) ≠ 0 := fun h0 => hmem p z hzs (hT0 z hz h0)
        rcases lt_or_gt_of_ne hne with h | h
        · exact Or.inr ⟨hz, by linarith⟩
        · exact Or.inl ⟨hz, by linarith⟩
      · have hne : tanHeight κ (frameX v β z) (frameY v β z) ≠ 0 := fun h0 => hmem j z hzs (hT0 z hz h0)
        rcases lt_or_gt_of_ne hne with h | h
        · exact Or.inr ⟨hz, by linarith⟩
        · exact Or.inl ⟨hz, by linarith⟩
    · rintro (⟨hz, hzT⟩ | ⟨hz, hzT⟩)
      · rcases hB hz with (h | h) | h
        · exact Or.inl ⟨h, hz⟩
        · exact Or.inr ⟨h, hz⟩
        · have := hbr z h; rw [this] at hzT; linarith
      · rcases hB hz with (h | h) | h
        · exact Or.inl ⟨h, hz⟩
        · exact Or.inr ⟨h, hz⟩
        · have := hbr z h; rw [this] at hzT; linarith


/-- **At most one sector of each colour** where the interior points of the ball are preconnected (every sector is their component,
so the whole set). -/
theorem _root_.HadwigerNelson.Plane.ArcMap.encard_sectorsOf_le_one {G : ArcMap k} {x : ℂ} {r : ℝ}
    (hP : IsPreconnected (G.interiorPts ∩ ball x r)) (c' : Fin k) : (G.sectorsOf x r c').encard ≤ 1 := by
  rw [Set.encard_le_one_iff]
  rintro S S' ⟨⟨y, hy, rfl, -⟩, -⟩ ⟨⟨y', hy', rfl, -⟩, -⟩
  rw [hP.connectedComponentIn hy, hP.connectedComponentIn hy']

/-- The rim arc lies on the circle of radius `ρ/2`. -/
theorem norm_of_mem_rimArc {ρ : ℝ} (h : X.Small ρ) {s : Fin X.n} {a b : ℕ} {z : ℂ}
    (hz : z ∈ (X.G.rimArc v s a b ρ).carrier) : ‖z - v‖ = ρ / 2 := by
  obtain ⟨θ, -, rfl⟩ := hz
  rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith [h.1])]

/-- **MERGE's colour of a sector point off `B̄(v, ρ/2)`** (out to a small `ρ' > ρ`) is the sector's colour. -/
theorem mergeCol_of_mem_sector_out {ρ ρ' : ℝ} (h' : X.Small ρ') (h : X.Small ρ) {s : Fin X.n} {a b : ℕ} {c : Fin k} {i : Fin X.n}
    {z : ℂ} (hz : z ∈ X.G.sector v ρ' i) (hzr : ρ / 2 < ‖z - v‖) : X.G.mergeCol v X.col F.col s a b c ρ z = X.col i := by
  by_cases hzb : z ∈ ball v ρ
  · have hz' := mem_sector_of_lt hz (by rwa [mem_ball, dist_eq_norm] at hzb)
    rw [mergeCol_of_mem_sector h hz', if_neg (fun h1 => (not_lt.mpr hzr.le) h1.2)]
  · rw [mergeCol_of_not_mem h hzb]; simpa using (X.hcol i ρ' h'.mem_Ioc hz).2

variable {s : Fin X.n} {a b : ℕ}

section Surgery

variable {c : Fin k} {ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ} {hA : ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.Nondegenerate}
  {hAf : (X.G.mergeArcs v X.col s a b ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ A ∈ F.trimArcs v ρ ∪ X.G.mergeArcs v X.col s a b ρ, A.carrier →
    ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s a b c ρ y = X.G.mergeCol v X.col F.col s a b c ρ x}

/-- **An interior point of `F` off the rim arc is interior to MERGE's map**: the new map's arcs are `F`'s trimmed arcs, germ arcs of
`F`, and the rim arc. -/
theorem mem_merge_interiorPts_of_mem (h : X.Small ρ) {z : ℂ} (hz : z ∈ F.interiorPts)
    (hzr : z ∉ (X.G.rimArc v s a b ρ).carrier) :
    z ∈ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).interiorPts := by
  refine ⟨hz.1, fun hzA => ?_⟩
  obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp hzA
  rcases hB with hB | hB
  · obtain ⟨-, a', ha', hsub, -⟩ := (F.trimArcs_spec hv hρ).1 B hB
    exact hz.2 (mem_iUnion₂.mpr ⟨a', ha', hsub hzB⟩)
  · rcases mergeArcs_cases h hB with ⟨j, hj⟩ | ⟨-, rfl⟩
    · exact hz.2 (germ_subset_Γ h j (hj hzB)).2
    · exact hzr hzB

/-- **A germ's point between `ρ/2` and a small `ρ' > ρ` is interior to MERGE's map** exactly when it is inside `ρ` on a phantom germ
(the phantom germs are cut in the annulus; a germ's rim point is on the trimmed arcs; beyond `ρ` the map is `F`). -/
theorem branchPt_mem_merge_interiorPts_iff {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (j : Fin X.n) {t : ℝ}
    (ht : t ∈ Ioo (ρ / 2) ρ') :
    branchPt v (X.G.β j) (X.G.κ j) t ∈
        (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).interiorPts ↔
      t < ρ ∧ BranchGerms.Phantom X.col j := by
  have ht0 : 0 < t := by linarith [ht.1, h.1]
  have hdist : dist (branchPt v (X.G.β j) (X.G.κ j) t) v = t := dist_branchPt j ht0.le
  constructor
  · intro hzI
    have htρ : t < ρ := by
      by_contra hge
      rcases eq_or_lt_of_le (not_lt.mp hge) with heq | hgt
      · obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp (branchPt_rim_mem_trimArcs h' hρ hρρ' j)
        rw [heq] at hzB
        exact hzI.2 (mem_iUnion₂.mpr ⟨B, Or.inl hB, hzB⟩)
      · have hzc : branchPt v (X.G.β j) (X.G.κ j) t ∉ closedBall v ρ := by
          rw [mem_closedBall, hdist, not_le]; exact hgt
        have hzF := ((merge_agreesOff (X := X) (s := s) (a := a) (b := b) (c := c) (hv := hv) (hρ := hρ) (hA := hA)
          (hAf := hAf) (hlc := hlc) h).2 _ hzc).1.mpr hzI
        exact hzF.2 (X.hC.branchPt_mem_Γ j ⟨ht0, ht.2.trans h'.lt_r₀⟩).2
    refine ⟨htρ, ?_⟩
    by_contra hph
    have hzb : branchPt v (X.G.β j) (X.G.κ j) t ∈ ball v ρ := by rw [mem_ball, hdist]; exact htρ
    exact (mem_merge_interiorPts_iff h hzb).mp hzI (branchPt_mem_mergeArcs_outer h hph ⟨ht.1, htρ.le⟩)
  · rintro ⟨htρ, hph⟩
    have hzb : branchPt v (X.G.β j) (X.G.κ j) t ∈ ball v ρ := by rw [mem_ball, hdist]; exact htρ
    refine (mem_merge_interiorPts_iff h hzb).mpr fun hzA => ?_
    obtain ⟨A, hA', hzA'⟩ := mem_iUnion₂.mp hzA
    rcases mem_mergeArcs.mp hA' with ⟨j', -, rfl⟩ | ⟨j', hj', hA''⟩ | ⟨-, rfl⟩
    · rw [carrier_germ h.half] at hzA'
      obtain ⟨t', ht', he⟩ := hzA'
      have := congrArg (fun z => dist z v) he
      simp only [dist_branchPt j' ht'.1, hdist] at this
      linarith [ht'.2, ht.1]
    · obtain ⟨t', ht', he⟩ := outer_subset h j' A hA'' hzA'
      have htt : t' = t := by
        have := congrArg (fun z => dist z v) he
        simp only [dist_branchPt j' (by linarith [ht'.1, h.1] : (0 : ℝ) ≤ t'), hdist] at this
        exact this
      subst htt
      exact hj' ((eq_of_branchPt_eq X.hdisj ⟨ht0, ht.2.trans h'.2.1⟩ he) ▸ hph)
    · have := norm_of_mem_rimArc h hzA'
      rw [← dist_eq_norm, hdist] at this
      linarith [ht.1]


theorem merge_not_hasRepeatedColour_rim_test {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b)
    (hbn : b < X.n) {x : ℂ} (hx : x ∈ sphere v ρ) :
    ¬ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).HasRepeatedColour x := by
  classical
  set F' := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc with hF'
  have hn : 0 < X.n := by omega
  have hxv : dist x v = ρ := mem_sphere.mp hx
  have hxv' : x ≠ v := fun he => by rw [he, dist_self] at hxv; linarith [h.1]
  suffices hle : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ c', (F'.sectorsOf x r c').encard ≤ 1 by
    rintro ⟨c', hc'⟩
    obtain ⟨r, hr2, hr1⟩ := (hc'.and hle).exists
    have := hr2.trans (hr1 c')
    norm_num at this
  -- a sector point off `B̄(v, ρ/2)` is interior to the new map
  have hsecI : ∀ i, ∀ z ∈ X.G.sector v ρ' i, ρ / 2 < ‖z - v‖ → z ∈ F'.interiorPts := fun i z hz hzr =>
    mem_merge_interiorPts_of_mem h (sector_subset_interiorPts h' i hz)
      (fun hzA => by rw [norm_of_mem_rimArc h hzA] at hzr; exact lt_irrefl _ hzr)
  -- points of a ball of radius `< ρ/2` about `x` are off `B̄(v, ρ/2)`
  have hfar : ∀ r, r ≤ ρ / 2 → ∀ z ∈ ball x r, ρ / 2 < ‖z - v‖ := fun r hr z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle x z v
    rw [mem_ball, dist_comm] at hz
    linarith
  have hnear : ∀ r, r ≤ ρ' - ρ → ∀ z ∈ ball x r, ‖z - v‖ < ρ' := fun r hr z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle z x v
    rw [mem_ball] at hz
    linarith
  by_cases hxI : x ∈ F.interiorPts
  · -- (R1) on no germ: one sector
    obtain ⟨i, hi⟩ : ∃ i, x ∈ X.G.sector v ρ' i := by
      have : x ∈ ball v ρ' ∩ F.interiorPts := ⟨by rw [mem_ball, hxv]; exact hρρ', hxI⟩
      rw [X.hC.cover ρ' h'.mem_Ioc hn] at this
      exact mem_iUnion.mp this
    obtain ⟨ε, hε, hεs⟩ := Metric.isOpen_iff.mp (X.hC.isOpen ρ' h'.mem_Ioc i) x hi
    filter_upwards [Ioo_mem_nhdsGT (lt_min hε (half_pos h.1))] with r hr c'
    have hU : F'.interiorPts ∩ ball x r = ball x r := by
      refine inter_eq_right.mpr fun z hz => hsecI i z (hεs (ball_subset_ball (hr.2.trans_le (min_le_left _ _)).le hz)) ?_
      exact hfar r (hr.2.trans_le (min_le_right _ _)).le z hz
    exact encard_sectorsOf_le_one (by rw [hU]; exact (convex_ball x r).isPreconnected) c'
  · -- on a germ `j`, with `p` the sector before it
    obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hxv' (by rw [mem_ball, hxv]; exact hρρ'.trans h'.lt_r₀) hxI
    rw [← dist_eq_norm, hxv] at hj
    subst hj
    obtain ⟨p, hpj⟩ := exists_next_eq j
    have hpj' : p ≠ j := by
      intro he
      have h1 : BranchGerms.next (BranchGerms.idx p 0) = BranchGerms.idx p 1 := BranchGerms.next_idx p 0
      rw [BranchGerms.idx_zero, hpj, ← he] at h1
      exact BranchGerms.idx_ne (s := p) (show 0 < 1 by omega) (show 1 < 0 + X.n by omega) (by rw [BranchGerms.idx_zero]; exact h1)
    obtain ⟨ε, hε, hside⟩ := sides_preconnected h' h.1 hρρ' hpj hpj'
    obtain ⟨ε₁, hε₁, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ') ⟨h'.1, h'.2.1.le⟩ (p := p)
      ⟨h.1, hρρ'⟩
    rw [hpj] at hball
    have hpos : 0 < min (min ε ε₁) (min (ρ / 2) (ρ' - ρ)) :=
      lt_min (lt_min hε hε₁) (lt_min (half_pos h.1) (sub_pos.mpr hρρ'))
    filter_upwards [Ioo_mem_nhdsGT hpos] with r hr c'
    have hrε : r < ε := hr.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))
    have hrε₁ : r < ε₁ := hr.2.trans_le ((min_le_left _ _).trans (min_le_right _ _))
    have hrρ : r ≤ ρ / 2 := (hr.2.trans_le ((min_le_right _ _).trans (min_le_left _ _))).le
    have hrρ' : r ≤ ρ' - ρ := (hr.2.trans_le ((min_le_right _ _).trans (min_le_right _ _))).le
    set x := branchPt v (X.G.β j) (X.G.κ j) ρ with hx
    have hB : ball x r ⊆ X.G.sector v ρ' p ∪ X.G.sector v ρ' j ∪ branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 ρ' :=
      (ball_subset_ball hrε₁.le).trans hball
    obtain ⟨hSp, hSj⟩ := hside r ⟨hr.1, hrε⟩
    -- a branch point of the ball is at distance in `(ρ/2, ρ')`
    have hbrt : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r → t ∈ Ioo (ρ / 2) ρ' := by
      intro t ht hz
      have := hfar r hrρ _ hz
      rw [norm_branchPt_sub v _ _ ht.1.le] at this
      exact ⟨this, ht.2⟩
    -- the ball's points beside the germ, in the sectors, are interior to the new map
    have hSpI : X.G.sector v ρ' p ∩ ball x r ⊆ F'.interiorPts := fun z hz => hsecI p z hz.1 (hfar r hrρ z hz.2)
    have hSjI : X.G.sector v ρ' j ∩ ball x r ⊆ F'.interiorPts := fun z hz => hsecI j z hz.1 (hfar r hrρ z hz.2)
    -- a germ point of the ball is in the closure of the sector after it, inside the ball
    have hclj : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r →
        branchPt v (X.G.β j) (X.G.κ j) t ∈ closure (X.G.sector v ρ' j ∩ ball x r) := by
      intro t ht hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h'.2.1.le j ht
      rw [inter_comm]; exact isOpen_ball.inter_closure ⟨hz, hcl⟩
    have hclp : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r →
        branchPt v (X.G.β j) (X.G.κ j) t ∈ closure (X.G.sector v ρ' p ∩ ball x r) := by
      intro t ht hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_before (v := v) X.hord h'.2.1.le p ht
      rw [hpj] at hcl
      rw [inter_comm]; exact isOpen_ball.inter_closure ⟨hz, hcl⟩
    by_cases hph : BranchGerms.Phantom X.col j
    · -- (R3) a phantom germ, cut inside `ρ`: one sector
      refine encard_sectorsOf_le_one ?_ c'
      obtain ⟨δ, hδ, hδc⟩ := Metric.continuousAt_iff.mp (continuous_branchPt v (X.G.β j) (X.G.κ j)).continuousAt r hr.1
      set t₀ := ρ - min δ (ρ / 2) / 2 with ht₀
      have hm : 0 < min δ (ρ / 2) := lt_min hδ (half_pos h.1)
      have hm' : min δ (ρ / 2) ≤ ρ / 2 := min_le_right _ _
      have ht₀ρ : t₀ < ρ := by linarith
      have ht₀2 : ρ / 2 < t₀ := by linarith
      have hy₀ : branchPt v (X.G.β j) (X.G.κ j) t₀ ∈ ball x r := by
        rw [mem_ball]; refine hδc ?_
        rw [Real.dist_eq, abs_of_neg (by linarith)]; linarith [min_le_left δ (ρ / 2)]
      have ht₀' : t₀ ∈ Ioo 0 ρ' := ⟨by linarith [h.1], ht₀ρ.trans hρρ'⟩
      have hy₀I : branchPt v (X.G.β j) (X.G.κ j) t₀ ∈ F'.interiorPts :=
        (branchPt_mem_merge_interiorPts_iff h' hρρ' h j ⟨ht₀2, ht₀'.2⟩).mpr ⟨ht₀ρ, hph⟩
      set y₀ := branchPt v (X.G.β j) (X.G.κ j) t₀ with hy₀def
      have hS₁ : IsPreconnected (X.G.sector v ρ' p ∩ ball x r ∪ {y₀}) :=
        hSp.subset_closure subset_union_left (union_subset subset_closure (singleton_subset_iff.mpr (hclp t₀ ht₀' hy₀)))
      have hS₂ : IsPreconnected ({y₀} ∪ X.G.sector v ρ' j ∩ ball x r) :=
        hSj.subset_closure subset_union_right (union_subset (singleton_subset_iff.mpr (hclj t₀ ht₀' hy₀)) subset_closure)
      have hS := hS₁.union y₀ (Or.inr rfl) (Or.inl rfl) hS₂
      refine hS.subset_closure ?_ ?_
      · rintro z ((hz | rfl) | (rfl | hz))
        · exact ⟨hSpI hz, hz.2⟩
        · exact ⟨hy₀I, hy₀⟩
        · exact ⟨hy₀I, hy₀⟩
        · exact ⟨hSjI hz, hz.2⟩
      · rintro z ⟨-, hz⟩
        rcases hB hz with (hz' | hz') | ⟨t, ht, rfl⟩
        · exact subset_closure (Or.inl (Or.inl ⟨hz', hz⟩))
        · exact subset_closure (Or.inr (Or.inr ⟨hz', hz⟩))
        · exact closure_mono (subset_union_right.trans subset_union_right) (hclj t ht hz)
    · -- (R2) a non-phantom germ: two sectors, of the two colours beside it
      have hcol : X.col p ≠ X.col j := fun he => hph ⟨p, hpj, he⟩
      have hU : F'.interiorPts ∩ ball x r = ⋃ b' : Bool, cond b' (X.G.sector v ρ' p ∩ ball x r) (X.G.sector v ρ' j ∩ ball x r) := by
        rw [← union_eq_iUnion]
        ext z
        constructor
        · rintro ⟨hzI, hz⟩
          rcases hB hz with (hz' | hz') | ⟨t, ht, rfl⟩
          · exact Or.inl ⟨hz', hz⟩
          · exact Or.inr ⟨hz', hz⟩
          · exact absurd ((branchPt_mem_merge_interiorPts_iff h' hρρ' h j (hbrt t ht hz)).mp hzI).2 hph
        · rintro (hz | hz)
          · exact ⟨hSpI hz, hz.2⟩
          · exact ⟨hSjI hz, hz.2⟩
      rw [encard_sectorsOf_of_partition (colA := fun b' => cond b' (X.col p) (X.col j)) hU ?_ ?_ ?_ ?_ ?_ c']
      · rw [Set.encard_le_one_iff]
        rintro b₁ b₂ ⟨-, h₁⟩ ⟨-, h₂⟩
        cases b₁ <;> cases b₂ <;> simp only [cond_true, cond_false] at h₁ h₂ ⊢
        · exact (hcol (h₂.trans h₁.symm)).elim
        · exact (hcol (h₁.trans h₂.symm)).elim
      · intro b'; cases b'
        · exact (X.hC.isOpen ρ' h'.mem_Ioc j).inter isOpen_ball
        · exact (X.hC.isOpen ρ' h'.mem_Ioc p).inter isOpen_ball
      · intro b'; cases b'
        · exact hSj
        · exact hSp
      · intro b₁ b₂ hb
        have hd := (X.hC.disjoint ρ' h'.mem_Ioc p j hpj').mono (inter_subset_left (t := ball x r))
          (inter_subset_left (t := ball x r))
        cases b₁ <;> cases b₂
        · exact absurd rfl hb
        · exact hd.symm
        · exact hd
        · exact absurd rfl hb
      · intro b' _; cases b'
        · exact hclj ρ ⟨h.1, hρρ'⟩ (mem_ball_self hr.1)
        · exact hclp ρ ⟨h.1, hρρ'⟩ (mem_ball_self hr.1)
      · intro b' z hz; cases b'
        · show X.G.mergeCol v X.col F.col s a b c ρ z = X.col j
          exact mergeCol_of_mem_sector_out h' h hz.1 (hfar r hrρ z hz.2)
        · show X.G.mergeCol v X.col F.col s a b c ρ z = X.col p
          exact mergeCol_of_mem_sector_out h' h hz.1 (hfar r hrρ z hz.2)

end Surgery

end Near

end ArcMap

end HadwigerNelson.Plane

/-! ## FS131-IMM4: `D_c(v′)` off the disc — the new map's colour class and its tiles (record § 8.2 item 2) -/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **A step of a strictly increasing sequence holds each value between two of its terms**: `θ ∈ [f m₀, f m₁]` is `f m₁` or lies in
`[f m, f (m + 1))` for some `m ∈ [m₀, m₁)`. -/
theorem exists_step_of_strictMono {f : ℕ → ℝ} (hf : StrictMono f) {m₀ m₁ : ℕ} (hm : m₀ ≤ m₁) {θ : ℝ}
    (h1 : f m₀ ≤ θ) (h2 : θ ≤ f m₁) : θ = f m₁ ∨ ∃ m, m₀ ≤ m ∧ m < m₁ ∧ f m ≤ θ ∧ θ < f (m + 1) := by
  induction m₁, hm using Nat.le_induction with
  | base => left; exact le_antisymm h2 h1
  | succ m₁ hm ih =>
    by_cases hθ : θ ≤ f m₁
    · rcases ih hθ with he | ⟨m, hm1, hm2, hm3, hm4⟩
      · right; exact ⟨m₁, hm, by omega, he.ge, by rw [he]; exact hf (by omega)⟩
      · right; exact ⟨m, hm1, by omega, hm3, hm4⟩
    · rcases eq_or_lt_of_le h2 with he | hlt
      · left; exact he
      · right; exact ⟨m₁, hm, by omega, (not_le.mp hθ).le, hlt⟩

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Finitely many tiles meet a ball inside a good ball** (each meets a circle of the good ball, `GoodAt.finite_tiles_sphere`, since
no tile lies inside a good ball). -/
theorem finite_tiles_ball_of_goodAt {x : ℂ} {ρ₀ r : ℝ} (hG : F.GoodAt x ρ₀) (hr : 0 < r) (hrρ : r < ρ₀) :
    {T | F.IsTile T ∧ (T ∩ ball x r).Nonempty}.Finite := by
  refine (hG.finite_tiles_sphere (ρ := (r + ρ₀) / 2) (by linarith) (by linarith)).subset ?_
  rintro T ⟨hT, p, hpT, hp⟩
  refine ⟨hT, ?_⟩
  have hpρ : p ∈ ball x ((r + ρ₀) / 2) := ball_subset_ball (by linarith) hp
  have hnot : ¬ T ⊆ ball x ((r + ρ₀) / 2) := fun h => hG.not_tile_subset_ball hT (by linarith) h
  obtain ⟨q, hqT, hq⟩ := Set.not_subset.mp hnot
  by_contra hne
  have hno : ∀ y ∈ T, y ∉ sphere x ((r + ρ₀) / 2) := fun y hy hys => hne ⟨y, hy, hys⟩
  obtain ⟨y, hy, hy1, hy2⟩ := hT.isPreconnected (ball x ((r + ρ₀) / 2)) (closedBall x ((r + ρ₀) / 2))ᶜ isOpen_ball
    isClosed_closedBall.isOpen_compl (fun y hy => by
      by_cases h1 : y ∈ ball x ((r + ρ₀) / 2)
      · exact Or.inl h1
      · right
        intro h2
        exact hno y hy (le_antisymm (mem_closedBall.mp h2) (not_lt.mp h1)))
    ⟨p, hpT, hpρ⟩ ⟨q, hqT, fun h2 => hno q hqT (le_antisymm (mem_closedBall.mp h2) (not_lt.mp hq))⟩
  exact hy2 (ball_subset_closedBall hy1)

/-- **An interior point in the closure of a tile is in the tile** (tiles are the components of the open interior points). -/
theorem IsTile.mem_of_mem_closure {T : Set ℂ} (hT : F.IsTile T) {z : ℂ} (hzI : z ∈ F.interiorPts) (hz : z ∈ closure T) :
    z ∈ T := by
  have hz' := mem_connectedComponentIn hzI
  obtain ⟨y, hy1, hy2⟩ := mem_closure_iff.mp hz _ (F.isOpen_interiorPts.connectedComponentIn) hz'
  exact (IsTile.eq_of_mem ⟨z, hzI, rfl⟩ hT hy1 hy2) ▸ hz'

end ArcMap

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}

/-- **A sector point on the rim arc is in a gap sector**: the rim arc's directions lie between the gap's end germs, so off the germs
they are the gap sectors'. -/
theorem gapSec_of_mem_rimArc {ρ : ℝ} (h : X.Small ρ) (hab : a < b) {i : Fin X.n} {z : ℂ} (hz : z ∈ X.G.sector v ρ i)
    (hzr : z ∈ (X.G.rimArc v s a b ρ).carrier) : i ∈ BranchGerms.gapSec s a b := by
  obtain ⟨θ, hθ, rfl⟩ := hzr
  have ht : ρ / 2 ∈ Ioo 0 X.s₀ := ⟨by linarith [h.1], by linarith [h.1, h.2.1]⟩
  have hbr : ∀ m, v + ((ρ / 2 : ℝ) : ℂ) * e (X.G.liftDir s m (ρ / 2)) ∉ X.G.sector v ρ i := fun m hm => by
    rw [← X.G.branchPt_idx] at hm
    exact branchPt_not_mem_sector h _ ⟨by linarith [h.1], by linarith [h.1]⟩ i hm
  rcases exists_step_of_strictMono (X.G.liftDir_mono X.hord s ht) (show a + 1 ≤ b by omega) hθ.1 hθ.2 with
    he | ⟨m, hm1, hm2, hm3, hm4⟩
  · rw [he] at hz; exact absurd hz (hbr b)
  · rcases eq_or_lt_of_le hm3 with he | hlt
    · rw [← he] at hz; exact absurd hz (hbr m)
    · have hzm : v + ((ρ / 2 : ℝ) : ℂ) * e θ ∈ X.G.sector v ρ (BranchGerms.idx s m) :=
        (X.G.mem_sector_idx s m).mpr ⟨ρ / 2, ⟨by linarith [h.1], by linarith [h.1]⟩, θ, ⟨hlt, hm4⟩, rfl⟩
      rw [sector_disjoint h hz hzm]
      exact ⟨m, by omega, hm2, rfl⟩

/-- The chain lies in the ball of its radius. -/
theorem chain_subset_ball {r : ℝ} {m : ℕ} : chain X s a r m ⊆ ball v r := by
  intro z hz
  rw [mem_ball, dist_eq_norm]
  rcases mem_chain.mp hz with hz' | ⟨m', -, -, ⟨t, ht, rfl⟩ | hz'⟩
  · exact (norm_of_mem_sector hz').2
  · rw [norm_branchPt_sub v _ _ ht.1.le]; exact ht.2
  · exact (norm_of_mem_sector hz').2

/-- The chain out to a small radius is open. -/
theorem isOpen_chain {r : ℝ} (hrs : r ∈ Ioc 0 X.s₀) (hab : a < b) : IsOpen (chain X s a r b) := by
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hrs.1, hrs.2.trans X.hs₀.2⟩
  rw [isOpen_iff_mem_nhds]
  intro z hz
  rcases mem_chain.mp hz with hz' | ⟨m', h1, h2, ⟨t, ht, rfl⟩ | hz'⟩
  · exact Filter.mem_of_superset ((X.hC.isOpen r hr₀ _).mem_nhds hz') (sector_subset_chain le_rfl hab.le)
  · obtain ⟨p, hpj⟩ := exists_next_eq (BranchGerms.idx s m')
    obtain ⟨m'', hm, ham, rfl⟩ := gap_sides_idx hpj h1 h2 rfl
    obtain ⟨ε, hε, hsub⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj hrs (p := BranchGerms.idx s m'') ht
    rw [hpj] at hsub
    refine Filter.mem_of_superset (ball_mem_nhds _ hε) (hsub.trans ?_)
    rintro y ((hy | hy) | hy)
    · exact sector_subset_chain ham (by omega) hy
    · exact sector_subset_chain (by omega) h2 hy
    · exact mem_chain.mpr (Or.inr ⟨m', h1, h2, Or.inl hy⟩)
  · exact Filter.mem_of_superset ((X.hC.isOpen r hr₀ _).mem_nhds hz') (sector_subset_chain (by omega) h2)

/-- **The chain out to `ρ` is clear for `c`** in `F`: its `c`-sectors by validity, its gap points by the gap's clearness. -/
theorem isClear_chain (hF : F.Valid) {ρ : ℝ} (h : X.Small ρ) {c : Fin k} (hca : X.col (BranchGerms.idx s a) = c)
    (hcb : X.col (BranchGerms.idx s b) = c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ)) :
    ∀ z ∈ chain X s a ρ b, F.IsClear c z := by
  have hreg : ∀ i, X.col i = c → ∀ z ∈ X.G.sector v ρ i, F.IsClear c z := fun i hi z hz => by
    have hzr := X.hcol i ρ h.mem_Ioc hz
    have hcz : F.col z = c := by rw [← hi]; exact hzr.2
    rw [← hcz]; exact isClear_col hF hzr.1
  intro z hz
  rcases mem_chain.mp hz with hz' | ⟨m, h1, h2, ⟨t, ht, rfl⟩ | hz'⟩
  · exact hreg _ hca z hz'
  · rw [X.G.branchPt_idx]
    have hφ := liftDir_gap_germ (s := s) (⟨ht.1, ht.2.trans h.2.1⟩ : t ∈ Ioo 0 X.s₀) h1 h2
    exact hgc t ⟨ht.1, ht.2.trans_le hρc⟩ _ hφ.1 hφ.2
  · rcases eq_or_lt_of_le h2 with rfl | h2
    · exact hreg _ hcb z hz'
    · obtain ⟨φ, hφ, hzφ⟩ := exists_dir_of_mem_gapSec h ⟨m, h1, h2, rfl⟩ hz'
      rw [hzφ]
      exact hgc _ ⟨(norm_of_mem_sector hz').1, (norm_of_mem_sector hz').2.trans_le hρc⟩ φ hφ.1 hφ.2

/-- **The closure of the gap out to `ρ/2`** lies in `{v}` and the chain out to `ρ`. -/
theorem closure_gapSet_subset {ρ : ℝ} (h : X.Small ρ) :
    closure (X.G.gapSet v s a b (ρ / 2)) ⊆ {v} ∪ chain X s a ρ b := by
  unfold BranchGerms.gapSet
  rw [closure_union, (Set.toFinite _).closure_biUnion, (Set.toFinite _).closure_biUnion]
  refine union_subset (iUnion₂_subset fun i hi => ?_) (iUnion₂_subset fun j hj => ?_)
  · obtain ⟨m, h1, h2, rfl⟩ := hi
    intro z hz
    have hz' := closure_mono (sector_mono (by linarith [h.1] : ρ / 2 ≤ ρ) _) hz
    have hzle := (BranchGerms.mem_closure_sector hz).1
    by_cases hzv : z = v
    · exact Or.inl hzv
    · right
      have hz0 : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
      have hzρ : ‖z - v‖ < ρ := by linarith [h.1]
      rcases BranchGerms.closure_sector_cases hz' hz0 hzρ with h3 | h3 | h3
      · exact sector_subset_chain (by omega) h2.le h3
      · exact mem_chain.mpr (Or.inr ⟨m, h1, h2.le, Or.inl ⟨‖z - v‖, ⟨hz0, hzρ⟩, h3.symm⟩⟩)
      · rw [BranchGerms.next_idx] at h3
        exact mem_chain.mpr (Or.inr ⟨m + 1, by omega, by omega, Or.inl ⟨‖z - v‖, ⟨hz0, hzρ⟩, h3.symm⟩⟩)
  · obtain ⟨m, h1, h2, rfl⟩ := hj
    intro z hz
    have hz' : z ∈ branchPt v (X.G.β (BranchGerms.idx s m)) (X.G.κ (BranchGerms.idx s m)) '' Icc 0 (ρ / 2) :=
      closure_minimal (image_mono Ioo_subset_Icc_self) (isCompact_Icc.image (continuous_branchPt v _ _)).isClosed hz
    obtain ⟨t, ht, rfl⟩ := hz'
    rcases eq_or_lt_of_le ht.1 with h0 | h0
    · left; rw [← h0]; simp [branchPt]
    · right; exact mem_chain.mpr (Or.inr ⟨m, h1, h2, Or.inl ⟨t, ⟨h0, by linarith [ht.2, h.1]⟩, rfl⟩⟩)

section Surgery

variable {c : Fin k} {ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ} {hA : ∀ A ∈ X.G.mergeArcs v X.col s a b ρ, A.Nondegenerate}
  {hAf : (X.G.mergeArcs v X.col s a b ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ A ∈ F.trimArcs v ρ ∪ X.G.mergeArcs v X.col s a b ρ, A.carrier →
    ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s a b c ρ y = X.G.mergeCol v X.col F.col s a b c ρ x}

/-- **`F`'s colour class of `c` survives MERGE**: a point of it is interior to the new map (off the rim arc, which runs through the gap
sectors, none of colour `c`) and keeps the colour `c`. -/
theorem merge_region_of_region (h : X.Small ρ) (hab : a < b) (hbn : b < X.n)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {z : ℂ} (hz : z ∈ F.region c) :
    z ∈ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c := by
  have hn : 0 < X.n := by omega
  have hzc : F.col z = c := hz.2
  have hsec : z ∈ ball v ρ → ∃ i, z ∈ X.G.sector v ρ i ∧ X.col i = c := fun hzb => by
    have hzv : z ≠ v := fun he => hz.1.2 (he ▸ (X.mem_Γ hn).2)
    rcases ball_cases h hn hzb hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · refine ⟨i, hi, ?_⟩
      have h1 : F.col z = X.col i := (X.hcol i ρ h.mem_Ioc hi).2
      rw [← h1, hzc]
    · exact absurd (X.hC.branchPt_mem_Γ j ⟨ht.1, ht.2.trans h.lt_r₀⟩).2 hz.1.2
  refine ⟨mem_merge_interiorPts_of_mem h hz.1 fun hzr => ?_, ?_⟩
  · have hzb : z ∈ ball v ρ := by rw [mem_ball, dist_eq_norm, norm_of_mem_rimArc h hzr]; linarith [h.1]
    obtain ⟨i, hi, hic⟩ := hsec hzb
    obtain ⟨m, h1, h2, rfl⟩ := gapSec_of_mem_rimArc h hab hi hzr
    exact hgap m h1 h2 hic
  · show X.G.mergeCol v X.col F.col s a b c ρ z = c
    by_cases hzb : z ∈ ball v ρ
    · obtain ⟨i, hi, hic⟩ := hsec hzb
      rw [mergeCol_of_mem_sector h hi]; split_ifs <;> [rfl; exact hic]
    · rw [mergeCol_of_not_mem h hzb]; exact hzc

/-- **The new map's colour class of `c`**: each of its points is in `F`'s class, in the gap out to `ρ/2`, or a cut branch point inside
`ρ` of a germ with `c` after it. -/
theorem merge_region_cases {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n) {z : ℂ}
    (hz : z ∈ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c) :
    z ∈ F.region c ∨ z ∈ X.G.gapSet v s a b (ρ / 2) ∨
      ∃ j, X.col j = c ∧ ∃ t ∈ Ioo 0 ρ, z = branchPt v (X.G.β j) (X.G.κ j) t := by
  obtain ⟨hzI, hzc⟩ := hz
  have hzc' : X.G.mergeCol v X.col F.col s a b c ρ z = c := hzc
  rcases lt_trichotomy (dist z v) ρ with hlt | heq | hgt
  · have hzv : z ≠ v := by
      rintro rfl; exact (mem_merge_interiorPts_iff h hlt).mp hzI (v_mem_mergeArcs h hab hbn)
    rcases ball_cases h (by omega) hlt hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · rw [mergeCol_of_mem_sector h hi] at hzc'
      split_ifs at hzc' with hg
      · exact Or.inr (Or.inl ((mem_gapSet_of_mem_sector h (by linarith [h.1]) hi).mpr hg))
      · left
        have h1 : F.col z = X.col i := (X.hcol i ρ h.mem_Ioc hi).2
        exact ⟨sector_subset_interiorPts h i hi, by show F.col z = c; rw [h1, hzc']⟩
    · rw [mergeCol_branchPt h j ht] at hzc'
      split_ifs at hzc' with hg
      · exact Or.inr (Or.inl ((branchPt_mem_gapSet_iff h (by linarith [h.1]) j ht).mpr hg))
      · exact Or.inr (Or.inr ⟨j, hzc', t, ht, rfl⟩)
  · left
    refine ⟨mem_interiorPts_of_merge_rim h' hρρ' heq hzI, ?_⟩
    show F.col z = c
    rw [← mergeCol_of_not_mem h (c := c) (s := s) (a := a) (b := b) (by rw [mem_ball, heq]; exact lt_irrefl ρ)]
    exact hzc'
  · left
    have hzc2 : z ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
    have hA' := (merge_agreesOff (X := X) (s := s) (a := a) (b := b) (c := c) (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
      (hlc := hlc) h).2 z hzc2
    refine ⟨hA'.1.mpr hzI, ?_⟩
    show F.col z = c
    rw [hA'.2]; exact hzc'

/-- **The closure of the new map's colour class of `c`** lies in the closure of `F`'s and the closure of the gap out to `ρ/2`. -/
theorem closure_merge_region {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n) :
    closure ((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c) ⊆
      closure (F.region c) ∪ closure (X.G.gapSet v s a b (ρ / 2)) := by
  have hsub : (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c ⊆
      closure (F.region c) ∪ X.G.gapSet v s a b (ρ / 2) := by
    intro z hz
    rcases merge_region_cases h' hρρ' h hab hbn hz with h1 | h1 | ⟨j, hj, t, ht, rfl⟩
    · exact Or.inl (subset_closure h1)
    · exact Or.inr h1
    · exact Or.inl (hj ▸ cutSet_subset_closure h ⟨t, ht, rfl⟩)
  refine (closure_mono hsub).trans ?_
  rw [closure_union, closure_closure]

/-- **The chain out to `ρ/2` is in the new map's colour class of `c`.** -/
theorem chain_subset_merge_region (h : X.Small ρ) (hca : X.col (BranchGerms.idx s a) = c)
    (hcb : X.col (BranchGerms.idx s b) = c) :
    chain X s a (ρ / 2) b ⊆
      (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c := by
  have hρ2 : ρ / 2 ≤ ρ := by linarith [h.1]
  have hball2 : ∀ {z : ℂ}, ‖z - v‖ < ρ / 2 → z ∈ ball v (ρ / 2) := fun hz => by rw [mem_ball, dist_eq_norm]; exact hz
  have hsecI : ∀ i, ∀ z ∈ X.G.sector v (ρ / 2) i, z ∈
      (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).interiorPts :=
    fun i z hz => mem_merge_interiorPts_of_mem h (sector_subset_interiorPts h.half i hz) fun hzr => by
      have := (norm_of_mem_sector hz).2; rw [norm_of_mem_rimArc h hzr] at this; exact lt_irrefl _ this
  intro z hz
  rcases mem_chain.mp hz with hz' | ⟨m', h1, h2, ⟨t, ht, rfl⟩ | hz'⟩
  · refine ⟨hsecI _ z hz', ?_⟩
    show X.G.mergeCol v X.col F.col s a b c ρ z = c
    rw [mergeCol_of_mem_sector h (sector_mono hρ2 _ hz')]; split_ifs <;> [rfl; exact hca]
  · have hzr : ‖branchPt v (X.G.β (BranchGerms.idx s m')) (X.G.κ (BranchGerms.idx s m')) t - v‖ < ρ / 2 := by
      rw [norm_branchPt_sub v _ _ ht.1.le]; exact ht.2
    refine ⟨(mem_merge_interiorPts_iff h (ball_subset_ball hρ2 (hball2 hzr))).mpr fun hzA => ?_, ?_⟩
    · rcases mem_mergeArcs_inner h (hball2 hzr) hzA with h0 | ⟨j, hj, t', ht', he⟩
      · have := congrArg (fun z => ‖z - v‖) h0
        simp only [norm_branchPt_sub v _ _ ht.1.le, sub_self, norm_zero] at this; linarith [ht.1]
      · have := eq_of_mem_branch (r := ρ / 2) h ⟨ht'.1, by linarith [ht'.2, h.1]⟩ ⟨t, ht, he⟩
        exact hj (this ▸ ⟨m', h1, h2, rfl⟩)
    · show X.G.mergeCol v X.col F.col s a b c ρ _ = c
      rw [mergeCol_branchPt h _ ⟨ht.1, by linarith [ht.2]⟩, if_pos ⟨⟨m', h1, h2, rfl⟩, ht.2⟩]
  · refine ⟨hsecI _ z hz', ?_⟩
    show X.G.mergeCol v X.col F.col s a b c ρ z = c
    rw [mergeCol_of_mem_sector h (sector_mono hρ2 _ hz')]
    split_ifs with hg
    · rfl
    · rcases eq_or_lt_of_le h2 with h2 | h2
      · rw [h2, hcb]
      · exact absurd ⟨⟨m', h1, h2, rfl⟩, (norm_of_mem_sector hz').2⟩ hg

/-- **A `c`-tile of the new map at `v` holds a `c`-sector of `F` at `v`**: near `v` its points are in a `c`-sector off the gap, or in
the merged chain, which holds the first `c`-sector. -/
theorem v_mem_closure_merge_tile (h : X.Small ρ) (hab : a < b) (hbn : b < X.n) (hca : X.col (BranchGerms.idx s a) = c)
    (hcb : X.col (BranchGerms.idx s b) = c) {T' : Set ℂ}
    (hT' : (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).TileOf c T')
    (hvT : v ∈ closure T') : v ∈ closure (T' ∩ F.region c) := by
  have hn : 0 < X.n := by omega
  have hρ2 : ρ / 2 ≤ ρ := by linarith [h.1]
  have hr2 : ρ / 2 ∈ Ioc 0 X.r₀ := ⟨h.half.1, hρ2.trans h.lt_r₀.le⟩
  have hrs : ρ / 2 ∈ Ioc 0 X.s₀ := ⟨h.half.1, by linarith [h.1, h.2.1]⟩
  obtain ⟨z, hzb, hzT⟩ := mem_closure_iff.mp hvT (ball v (ρ / 2)) isOpen_ball (mem_ball_self h.half.1)
  have hzI := (hT'.subset_region hzT).1
  have hzv : z ≠ v := by
    rintro rfl; exact (mem_merge_interiorPts_iff h (mem_ball_self h.1)).mp hzI (v_mem_mergeArcs h hab hbn)
  -- a sector of `F` at `v`, inside `T'` and `F`'s class of `c`, gives the closure point
  have hfin : ∀ i, X.G.sector v (ρ / 2) i ⊆ T' → X.col i = c → v ∈ closure (T' ∩ F.region c) := fun i hi hic =>
    closure_mono (s := X.G.sector v (ρ / 2) i) (t := T' ∩ F.region c)
      (fun y hy => ⟨hi hy, hic ▸ X.hcol i (ρ / 2) hr2 hy⟩) (X.hC.mem_closure_sector hr2 i)
  -- the chain out to `ρ/2`, once it meets `T'`, lies in it
  have hchain : (chain X s a (ρ / 2) b ∩ T').Nonempty → v ∈ closure (T' ∩ F.region c) := fun ⟨y, hy, hyT⟩ => by
    have hsub : chain X s a (ρ / 2) b ⊆ T' := hT'.1.subset_of_preconnected (isPreconnected_chain hrs hab.le)
      (fun z hz => (chain_subset_merge_region h hca hcb hz).1) hy hyT
    exact hfin _ ((sector_subset_chain le_rfl hab.le).trans hsub) hca
  rcases ball_cases h.half hn hzb hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
  · by_cases hig : i ∈ BranchGerms.gapSec s a b
    · obtain ⟨m, h1, h2, rfl⟩ := hig
      exact hchain ⟨z, sector_subset_chain h1.le h2.le hi, hzT⟩
    · have hzc : X.G.mergeCol v X.col F.col s a b c ρ z = c := (hT'.subset_region hzT).2
      rw [mergeCol_of_mem_sector h (sector_mono hρ2 _ hi), if_neg (fun h1 => hig h1.1)] at hzc
      refine hfin i (hT'.1.subset_of_preconnected (X.hC.isPreconnected _ hr2 i) (fun y hy => ?_) hi hzT) hzc
      exact mem_merge_interiorPts_of_mem h (sector_subset_interiorPts h.half i hy) fun hyr => by
        have := (norm_of_mem_sector hy).2; rw [norm_of_mem_rimArc h hyr] at this; exact lt_irrefl _ this
  · have hjg : j ∈ BranchGerms.gapGerm s a b := by
      by_contra hjg
      exact (mem_merge_interiorPts_iff h (ball_subset_ball hρ2 hzb)).mp hzI
        (branchPt_mem_mergeArcs_inner h hjg ⟨ht.1, ht.2.le⟩)
    obtain ⟨m, h1, h2, rfl⟩ := hjg
    exact hchain ⟨_, mem_chain.mpr (Or.inr ⟨m, h1, h2, Or.inl ⟨t, ht, rfl⟩⟩), hzT⟩

/-- **Each `c`-tile of `F` lies in a `c`-tile of the new map.** -/
theorem merge_exists_tile (h : X.Small ρ) (hab : a < b) (hbn : b < X.n)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {T : Set ℂ} (hT : F.TileOf c T) :
    ∃ T', (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).TileOf c T' ∧
      T ⊆ T' := by
  set F' := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc with hF'
  obtain ⟨y, hy⟩ := hT.1.nonempty
  have hreg : ∀ z ∈ T, z ∈ F'.region c := fun z hz => merge_region_of_region h hab hbn hgap (hT.subset_region hz)
  have hyI := (hreg y hy).1
  refine ⟨_, ?_, hT.1.isPreconnected.subset_connectedComponentIn hy fun z hz => (hreg z hz).1⟩
  have hT1 : F'.IsTile (connectedComponentIn F'.interiorPts y) := ⟨y, hyI, rfl⟩
  have h1 := hT1.tileOf (mem_connectedComponentIn hyI)
  rwa [show F'.col y = c from (hreg y hy).2] at h1

/-- **A `c`-tile of the new map lies inside or outside the unit circle about a point of the closure of its colour class** (the new
map is valid, `merge_valid`). -/
theorem merge_tile_split (hF : F.Valid) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b)
    (hbn : b < X.n) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ))
    {T' : Set ℂ}
    (hT' : (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).TileOf c T')
    {v' : ℂ}
    (hv' : v' ∈ closure ((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf
      hlc).region c)) :
    T' ⊆ ball v' 1 ∨ Disjoint T' (closedBall v' 1) := by
  have hval := merge_valid (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) hF h' hρρ' h hab hbn hρc hgc
  have hne : ∀ z ∈ T', dist v' z ≠ 1 := fun z hz => by
    rw [dist_comm]; exact ne1_region hval hv' (hT'.subset_region hz)
  rcases preconnected_dist_lt_or_gt hT'.1.isPreconnected hne with h1 | h1
  · left; intro z hz; rw [mem_ball, dist_comm]; exact h1 z hz
  · right; rw [disjoint_left]; intro z hz hz'; rw [mem_closedBall, dist_comm] at hz'; linarith [h1 z hz]

/-- **A `c`-tile of the new map at a contact holds a `c`-tile of `F` at that contact** (record § 5.2): the new tile's points are `F`'s
class, the gap out to `ρ/2`, or cut branch points in the closure of its part in `F`'s class; the gap's closure is `v` (handled by
`v_mem_closure_merge_tile`) and the chain, an open set clear for `c` that meets no unit circle about a point of the class's closure; and
the new tile holds finitely many tiles of `F` (each meets a ball inside the good ball, or the new tile is a tile of `F`). -/
theorem merge_tile_cover (hF : F.Valid) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n)
    (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ))
    {T' : Set ℂ}
    (hT' : (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).TileOf c T')
    {v' w : ℂ} (hv' : v' ∈ closure (F.region c)) (hw : dist w v' = 1) (hwT : w ∈ closure T') :
    ∃ T, F.TileOf c T ∧ T ⊆ T' ∧ w ∈ closure T := by
  set F' := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc with hF'
  have hreg : ∀ z ∈ F.region c, z ∈ F'.region c := fun z hz => merge_region_of_region h hab hbn hgap hz
  -- each `c`-tile of `F` meeting `T'` lies in it
  have hsubT : ∀ T, F.TileOf c T → (T ∩ T').Nonempty → T ⊆ T' := fun T hT ⟨y, hyT, hyT'⟩ =>
    hT'.1.subset_of_preconnected hT.1.isPreconnected (fun z hz => (hreg z (hT.subset_region hz)).1) hyT hyT'
  by_cases hTB : (T' ∩ closedBall v ρ).Nonempty
  swap
  · -- `T'` misses the disc: it is a tile of `F`
    obtain ⟨y, hy⟩ := hT'.1.nonempty
    have hsubF : T' ⊆ F.region c := fun z hz => by
      have hzc : z ∉ closedBall v ρ := fun hzc => hTB ⟨z, hz, hzc⟩
      have hA' := (merge_agreesOff (X := X) (s := s) (a := a) (b := b) (c := c) (hv := hv) (hρ := hρ) (hA := hA)
        (hAf := hAf) (hlc := hlc) h).2 z hzc
      refine ⟨hA'.1.mpr (hT'.subset_region hz).1, ?_⟩
      show F.col z = c
      rw [hA'.2]; exact (hT'.subset_region hz).2
    obtain ⟨hT0, hyT0⟩ := tileOf_component (hsubF hy)
    have h1 : T' ⊆ connectedComponentIn F.interiorPts y :=
      hT0.1.subset_of_preconnected hT'.1.isPreconnected (fun z hz => (hsubF hz).1) hy hyT0
    have h2 := hsubT _ hT0 ⟨y, hyT0, hy⟩
    exact ⟨_, hT0, h2, (Subset.antisymm h1 h2) ▸ hwT⟩
  -- (1) the new tile lies in the closure of its part in `F`'s class, and the gap
  have hstep1 : T' ⊆ closure (T' ∩ F.region c) ∪ X.G.gapSet v s a b (ρ / 2) := by
    intro z hz
    rcases merge_region_cases h' hρρ' h hab hbn (hT'.subset_region hz) with h1 | h1 | ⟨j, hj, t, ht, rfl⟩
    · exact Or.inl (subset_closure ⟨hz, h1⟩)
    · exact Or.inr h1
    · left
      obtain ⟨δ, hδ, hδI⟩ := Metric.isOpen_iff.mp F'.isOpen_interiorPts _ (hT'.subset_region hz).1
      have hball : ball (branchPt v (X.G.β j) (X.G.κ j) t) δ ⊆ T' :=
        hT'.1.subset_of_preconnected (convex_ball _ δ).isPreconnected hδI (mem_ball_self hδ) hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h.2.1.le j ht
      refine closure_mono ?_ (isOpen_ball.inter_closure ⟨mem_ball_self hδ, hcl⟩)
      rintro y ⟨hy1, hy2⟩
      exact ⟨hball hy1, hj ▸ X.hcol j ρ h.mem_Ioc hy2⟩
  -- (2) the contact is a closure point of that part
  have hwF : w ∈ closure (T' ∩ F.region c) := by
    have hw2 : w ∈ closure (T' ∩ F.region c) ∪ closure (X.G.gapSet v s a b (ρ / 2)) := by
      have := closure_mono hstep1 hwT
      rwa [closure_union, closure_closure] at this
    rcases hw2 with hw2 | hw2
    · exact hw2
    · rcases closure_gapSet_subset h hw2 with rfl | hwc
      · exact v_mem_closure_merge_tile h hab hbn hca hcb hT' hwT
      · exact absurd hw (dist_ne_one_of_isOpen_isClear (isOpen_chain ⟨h.1, h.2.1.le⟩ hab)
          (isClear_chain hF h hca hcb hρc hgc) hwc hv')
  -- (3) finitely many tiles of `F` cover that part
  set S := {T | F.TileOf c T ∧ T ⊆ T'} with hS
  have hcov : T' ∩ F.region c ⊆ ⋃ T ∈ S, T := by
    rintro z ⟨hzT, hzF⟩
    obtain ⟨hTz, hzTz⟩ := tileOf_component hzF
    exact mem_iUnion₂.mpr ⟨_, ⟨hTz, hsubT _ hTz ⟨z, hzTz, hzT⟩⟩, hzTz⟩
  have hr₁ : ρ < (ρ + X.ρ₀) / 2 := by linarith [h.2.2.1]
  have hfin : S.Finite := by
    refine (finite_tiles_ball_of_goodAt X.hG (r := (ρ + X.ρ₀) / 2) (by linarith [h.1]) (by linarith [h.2.2.1])).subset ?_
    rintro T ⟨hT, hTT'⟩
    refine ⟨hT.1, ?_⟩
    by_contra hTn
    have hT'U : T' ⊆ T ∪ (closure T)ᶜ := by
      intro z hz
      by_cases hzT : z ∈ T
      · exact Or.inl hzT
      · right
        intro hzc
        by_cases hzb : z ∈ ball v ((ρ + X.ρ₀) / 2)
        · obtain ⟨y, hyb, hyT⟩ := mem_closure_iff.mp hzc _ isOpen_ball hzb
          exact hTn ⟨y, hyT, hyb⟩
        · have hzcb : z ∉ closedBall v ρ := fun h1 => hzb (closedBall_subset_ball hr₁ h1)
          have hA' := (merge_agreesOff (X := X) (s := s) (a := a) (b := b) (c := c) (hv := hv) (hρ := hρ) (hA := hA)
            (hAf := hAf) (hlc := hlc) h).2 z hzcb
          exact hzT (hT.1.mem_of_mem_closure (hA'.1.mpr (hT'.subset_region hz).1) hzc)
    rcases hT'.1.isPreconnected.subset_or_subset hT.1.isOpen isClosed_closure.isOpen_compl
        (disjoint_compl_right.mono_right (compl_subset_compl.mpr subset_closure)) hT'U with h1 | h1
    · obtain ⟨z, hzT', hzc⟩ := hTB
      exact hTn ⟨z, h1 hzT', closedBall_subset_ball hr₁ hzc⟩
    · obtain ⟨y, hy⟩ := hT.1.nonempty
      exact h1 (hTT' hy) (subset_closure hy)
  have : w ∈ ⋃ T ∈ S, closure T := by rw [← hfin.closure_biUnion]; exact closure_mono hcov hwF
  obtain ⟨T, hT, hwT⟩ := mem_iUnion₂.mp this
  exact ⟨T, hT.1, hT.2, hwT⟩

/-- **The contacts of `c` at a point off `B̄(v, ρ)` are unchanged by MERGE**: the colours there agree, `F`'s class lies in the new
one, and a closure point of the new class off the closure of `F`'s is in the closure of the gap — `v` (in the closure of `F`'s class) or
a point of the chain, at distance `≠ 1` from every closure point of `F`'s class. -/
theorem merge_isContact_iff (hF : F.Valid) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n)
    (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ)) {v' : ℂ} (hv' : v' ∉ closedBall v ρ) (w : ℂ) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).IsContact v' c w ↔ F.IsContact v' c w := by
  have hreg : ∀ z ∈ F.region c, z ∈ (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c := fun z hz => merge_region_of_region h hab hbn hgap hz
  have hcl := closure_merge_region (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) h' hρρ' h hab hbn
  have hvF : v ∈ closure (F.region c) :=
    closure_mono (s := X.G.sector v ρ (BranchGerms.idx s a)) (fun y hy => hca ▸ X.hcol _ ρ h.mem_Ioc hy)
      (X.hC.mem_closure_sector h.mem_Ioc _)
  constructor
  · rintro ⟨hc', hd, hw'⟩
    have hc : c ∈ F.coloursAt v' := by
      rcases hcl hc' with h1 | h1
      · exact h1
      · exfalso
        rcases closure_gapSet_subset h h1 with h2 | h2
        · exact hv' (by rw [h2]; exact mem_closedBall_self h.1.le)
        · exact hv' (ball_subset_closedBall (chain_subset_ball h2))
    refine ⟨hc, hd, ?_⟩
    rcases hcl hw' with h1 | h1
    · exact h1
    · rcases closure_gapSet_subset h h1 with rfl | h2
      · exact hvF
      · exact absurd hd (dist_ne_one_of_isOpen_isClear (isOpen_chain ⟨h.1, h.2.1.le⟩ hab)
          (isClear_chain hF h hca hcb hρc hgc) h2 hc)
  · rintro ⟨hc, hd, hw⟩
    exact ⟨closure_mono hreg hc, hd, closure_mono hreg hw⟩

/-- **The in-type contacts of `c` at a contact of `F` are unchanged by MERGE.** -/
theorem merge_inType_iff (hF : F.Valid) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n)
    (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ)) {v' w : ℂ} (hw : F.IsContact v' c w) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).InType v' c w ↔ F.InType v' c w := by
  have hv'' : v' ∈ closure ((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c) :=
    closure_mono (fun z hz => merge_region_of_region h hab hbn hgap hz) hw.1
  constructor
  · intro hin T hT hwT
    obtain ⟨T', hT', hTT'⟩ := merge_exists_tile (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) h hab hbn hgap hT
    exact hTT'.trans (hin T' hT' (closure_mono hTT' hwT))
  · intro hin T' hT' hwT'
    obtain ⟨T, hT, hTT', hwT⟩ := merge_tile_cover hF h' hρρ' h hab hbn hca hcb hgap hρc hgc hT' hw.1 hw.2.1 hwT'
    obtain ⟨y, hy⟩ := hT.1.nonempty
    rcases merge_tile_split hF h' hρρ' h hab hbn hρc hgc hT' hv'' with h1 | h1
    · exact h1
    · exact absurd (ball_subset_closedBall (hin T hT hwT hy)) (disjoint_left.mp h1 (hTT' hy))

/-- **The out-type contacts of `c` at a contact of `F` are unchanged by MERGE.** -/
theorem merge_outType_iff (hF : F.Valid) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b) (hbn : b < X.n)
    (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ)) {v' w : ℂ} (hw : F.IsContact v' c w) :
    (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).OutType v' c w ↔ F.OutType v' c w := by
  have hv'' : v' ∈ closure ((F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).region c) :=
    closure_mono (fun z hz => merge_region_of_region h hab hbn hgap hz) hw.1
  constructor
  · intro hout T hT hwT
    obtain ⟨T', hT', hTT'⟩ := merge_exists_tile (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) h hab hbn hgap hT
    exact (hout T' hT' (closure_mono hTT' hwT)).mono_left hTT'
  · intro hout T' hT' hwT'
    obtain ⟨T, hT, hTT', hwT⟩ := merge_tile_cover hF h' hρρ' h hab hbn hca hcb hgap hρc hgc hT' hw.1 hw.2.1 hwT'
    obtain ⟨y, hy⟩ := hT.1.nonempty
    rcases merge_tile_split hF h' hρρ' h hab hbn hρc hgc hT' hv'' with h1 | h1
    · exact absurd (ball_subset_closedBall (h1 (hTT' hy))) (disjoint_left.mp (hout T hT hwT) hy)
    · exact h1

theorem merge_allowedCone_test (hF : F.Valid) (hv1 : F.Covers v 1) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
    (hab : a < b) (hbn : b < X.n) (hca : X.col (BranchGerms.idx s a) = c) (hcb : X.col (BranchGerms.idx s b) = c)
    (hgap : ∀ m, a < m → m < b → X.col (BranchGerms.idx s m) ≠ c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ)) :
    ∀ v' ∉ closedBall v ρ,
      (F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) hv hρ hA hAf hlc).allowedCone v' c =
        F.allowedCone v' c := by
  intro v' hv'
  have hci := merge_isContact_iff (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) hF h' hρρ' h hab hbn hca hcb
    hgap hρc hgc hv'
  have hin := fun {w : ℂ} (hw : F.IsContact v' c w) => merge_inType_iff (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
    (hlc := hlc) hF h' hρρ' h hab hbn hca hcb hgap hρc hgc hw
  have hout := fun {w : ℂ} (hw : F.IsContact v' c w) => merge_outType_iff (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
    (hlc := hlc) hF h' hρρ' h hab hbn hca hcb hgap hρc hgc hw
  ext d
  constructor
  · intro hd w hw
    obtain ⟨h1, h2⟩ := hd w ((hci w).mpr hw)
    exact ⟨fun hi => h1 ((hin hw).mpr hi), fun ho => h2 ((hout hw).mpr ho)⟩
  · intro hd w hw'
    have hw := (hci w).mp hw'
    obtain ⟨h1, h2⟩ := hd w hw
    exact ⟨fun hi => h1 ((hin hw).mp hi), fun ho => h2 ((hout hw).mp ho)⟩

end Surgery

end Near

end ArcMap

end HadwigerNelson.Plane
