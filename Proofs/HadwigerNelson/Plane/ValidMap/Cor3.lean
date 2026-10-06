import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps

/-!
# FS112-N3-COR3: a close complementary pair sits on a rhombus of four-colour leaving centres

Wave 5's `cor3`, moved here verbatim from `Plane/ValidMap/Dense` (statement, docstring and proof; inventory item 299 (a), job FS131-I5e) so that
`Plane/ValidMap/HexRing`'s N2-ROT (`rot_noThird`, whose hand proof rests on it) can cite it: every name its statement uses is upstream of `HexRing`
(`IsCubicTrichromatic`, `BothKind` in `Plane/ValidMap/Basic`, `IsLeavingCentre` in `Plane/ValidMap/BaseSteps`, `Covers`, `Valid`, `coloursAt` in
`Plane/ArcMap`). Row: **FS112-N3-COR3** (`cor3`, over its local form `cor3_local`, inventory item 218 (b)).

`cor3_local`'s proof (job FS131-I5f) reads each crossing `w` of `ω(u)` and `ω(u′)` through the colours' cones at `w`: along each half-tangent
of `ω(u)` some colour of `u′` approaches `w` (`exists_tangent_colour`: colours of `u` on both sides of `ω(u)` along one direction would be the
two sides of one arc of `ω(w)` leaving `u`, `exists_ringArc_of_sides`, whose facing and away cones are disjoint, `IsRingArc.disjoint_coneAt`);
the two half-tangents lie on opposite sides of `ω(u′)`, so `w` carries an inner and an outer colour of `u′` — the two sides of one arc of
`ω(w)` leaving `u′` (`cor3_half`) — and, the roles exchanged, two colours of `u` (`cor3_at`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

/-! ## Children of `cor3_local`: the crossing of two unit circles, read through cones at the crossing -/

section Cor3Children

variable {k : ℕ} {F : ArcMap k}

/-- A unit complex number is `e` of its argument. -/
theorem e_arg_of_norm_eq_one {z : ℂ} (hz : ‖z‖ = 1) : e (arg z) = z := by
  have h := eq_polar_arg z
  rw [hz, Complex.ofReal_one, one_mul] at h
  exact h.symm

/-- **FS116-V5-U1, the facing and the away cone are disjoint**: the inner and the outer colour of an arc of `Γ` on `ω(z)` approach `z`
along no common direction (`ringArc_cone_inner`, `ringArc_cone_outer`: the two closed cones are separated by the side cones, each of
the arc's angle). -/
theorem IsRingArc.disjoint_coneAt (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    Disjoint (coneAt (F.region c) z) (coneAt (F.region c') z) := by
  rw [Set.disjoint_left]
  intro β h1 h2
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp (ringArc_cone_inner hF hA h1)
  obtain ⟨n, hn1, hn2⟩ := mem_iUnion.mp (ringArc_cone_outer hF hA h2)
  have hlt := hA.1
  have hπ := Real.pi_pos
  rcases lt_trichotomy m n with h | h | h
  · have hmn : (m : ℝ) + 1 ≤ n := by exact_mod_cast h
    nlinarith
  · subst h; linarith
  · have hmn : (n : ℝ) + 1 ≤ m := by exact_mod_cast h
    nlinarith

/-- **The arc between a colour of `u` inside `ω(u)` and one outside, at a point `w ∈ ω(u)`** (the chart at a cubic trichromatic vertex;
the content of N3-COR3's "inner and outer sets"): if `j` and `j′`, both carried at `u`, approach `w` from inside and from outside `ω(u)`
respectively, their two sectors of `u` lie inside and outside `ω(w)` (`closure_sector_subset_of_side`), so they are distinct and share a
germ, whose branch points lie on `ω(w)` at every radius; that germ runs along `ω(w)` (`germ_eq_of_two_on_circle`) and is an arc of `Γ`
on `ω(w)` ending at `u` with inner colour `j` and outer colour `j′` (`exists_isRingArc_of_along`). A step of `cor3_local`'s proof; its
hypotheses hold at any cubic vertex one of whose boundary germs is an arc of a unit circle `ω(w)` with three distinct side colours (none
is held as a named object here; `GENERIC`). -/
theorem exists_ringArc_of_sides (hF : F.Valid) {u w : ℂ} (hu : F.IsCubicTrichromatic u) (hud : u ∈ F.dom) (hw : dist w u = 1)
    {j j' : Fin k} (hj : j ∈ F.coloursAt u) (hj' : j' ∈ F.coloursAt u) (hin : w ∈ closure (F.region j ∩ ball u 1))
    (hout : w ∈ closure (F.region j' \ closedBall u 1)) :
    ∃ θ₁ θ₂, F.IsRingArc w θ₁ θ₂ j j' ∧ (ringPt w θ₁ = u ∨ ringPt w θ₂ = u) := by
  obtain ⟨r₀, G, hC, hdisj, f, -, hsec, hcol⟩ := hu.chart hud
  have hord := G.dir_lt_nextDir hC.sorted hC.curv hdisj
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have huw : dist u w = 1 := by rw [dist_comm]; exact hw
  obtain ⟨i, rfl⟩ := hcol j hj
  obtain ⟨i', rfl⟩ := hcol j' hj'
  have hcl := (closure_sector_subset_of_side hF hC hsec i).1 hin
  have hcl' := (closure_sector_subset_of_side hF hC hsec i').2 hout
  have hsub : G.sector u r₀ i ⊆ ball w 1 := by
    rw [← interior_closedBall w one_ne_zero]
    exact (hC.isOpen r₀ hr₀ i).subset_interior_iff.mpr (subset_closure.trans hcl)
  have hsub' : G.sector u r₀ i' ⊆ (closedBall w 1)ᶜ := by
    intro z hz
    have hint : z ∈ interior {z | 1 ≤ dist z w} :=
      (hC.isOpen r₀ hr₀ i').subset_interior_iff.mpr (subset_closure.trans hcl') hz
    have hcompl : {z : ℂ | 1 ≤ dist z w} = (ball w 1)ᶜ := by ext z; simp [mem_ball, not_lt]
    rw [hcompl, interior_compl, closure_ball w one_ne_zero] at hint
    exact hint
  have hne : i ≠ i' := by
    rintro rfl
    obtain ⟨z, hz⟩ := hC.sector_nonempty hr₀ i
    exact hsub' hz (ball_subset_closedBall (hsub hz))
  have hadj3 : ∀ a b : Fin 3, a ≠ b → ∃ g : Fin 3, (g = a ∨ BranchGerms.next a = g) ∧ (g = b ∨ BranchGerms.next b = g) := by
    decide
  obtain ⟨g, hgi, hgi'⟩ := hadj3 i i' hne
  -- a germ's branch points lie in the closures of the sectors on both sides of it
  have hbd : ∀ a, ∀ s ∈ Ioo 0 r₀, ∀ l, (l = a ∨ BranchGerms.next a = l) →
      branchPt u (G.β l) (G.κ l) s ∈ closure (G.sector u r₀ a) := by
    rintro a s hs0 l (rfl | rfl)
    · exact (BranchGerms.mem_closure_sector_of_lt hs0 l (hord s hs0 l)).1
    · rw [branchPt_eq]
      have : e (germDir (G.β (BranchGerms.next a)) (G.κ (BranchGerms.next a)) s) = e (G.nextDir a s) :=
        (G.e_nextDir a s).symm
      rw [this]; exact (BranchGerms.mem_closure_sector_of_lt hs0 a (hord s hs0 a)).2
  have hon : ∀ s ∈ Ioo 0 r₀, dist (branchPt u (G.β g) (G.κ g) s) w = 1 := fun s hs0 =>
    le_antisymm (hcl (hbd i s hs0 g hgi)) (hcl' (hbd i' s hs0 g hgi'))
  have hcurv : ∀ s ∈ Ioo 0 r₀, |G.κ g| * s ≤ 2 := fun s hs' =>
    (mul_le_mul_of_nonneg_left hs'.2.le (abs_nonneg _)).trans (hC.curv g).le
  have h1 : r₀ / 3 ∈ Ioo 0 r₀ := ⟨by linarith [hC.pos], by linarith [hC.pos]⟩
  have h2 : 2 * r₀ / 3 ∈ Ioo 0 r₀ := ⟨by linarith [hC.pos], by linarith [hC.pos]⟩
  obtain ⟨hσ, hβ⟩ := germ_eq_of_two_on_circle huw h1.1 h2.1 (ne_of_lt (by linarith [hC.pos])) (hcurv _ h1) (hcurv _ h2)
    (hon _ h1) (hon _ h2)
  obtain ⟨θ₁, θ₂, c, c', hR, hend, hint⟩ := hC.exists_isRingArc_of_along hdisj huw hσ hβ
  have hmi : (θ₁ + θ₂) / 2 ∈ Ioo θ₁ θ₂ := ⟨by linarith [hR.1], by linarith [hR.1]⟩
  obtain ⟨s, hs0, hsx⟩ := hint _ hmi
  have hin' : f i ∈ F.innerColours w (ringPt w ((θ₁ + θ₂) / 2)) := by
    rw [hsx]; exact closure_mono (subset_inter (hsec i) hsub) (hbd i s hs0 g hgi)
  have hout' : f i' ∈ F.outerColours w (ringPt w ((θ₁ + θ₂) / 2)) := by
    rw [hsx]
    exact closure_mono (t := F.region (f i') \ closedBall w 1) (fun z hz => ⟨hsec i' hz, hsub' hz⟩) (hbd i' s hs0 g hgi')
  rw [(hR.2.2 _ hmi).1] at hin'
  rw [(hR.2.2 _ hmi).2] at hout'
  rw [mem_singleton_iff.mp hin', mem_singleton_iff.mp hout']
  exact ⟨θ₁, θ₂, hR, hend⟩

/-- **A direction approached through an open set is a cone direction of one colour there** (pigeonhole over the colours, on interior
points, which are dense in the domain): if `A` is open and holds points tending to `w ∈ dom` along `e β`, then some colour's class meets
`A` along `e β` at `w`. -/
theorem exists_mem_coneAt_region_inter {w : ℂ} (hw : w ∈ F.dom) {A : Set ℂ} (hA : IsOpen A) {β : ℝ}
    (h : ∀ ε > 0, ∃ z ∈ A, z ≠ w ∧ dist z w < ε ∧ ‖(z - w) / (‖z - w‖ : ℂ) - e β‖ < ε) :
    ∃ j, β ∈ coneAt (F.region j ∩ A) w := by
  have hdir : ContinuousOn (fun z : ℂ => (z - w) / (‖z - w‖ : ℂ)) {z | z ≠ w} :=
    (continuousOn_id.sub continuousOn_const).div
      (Complex.continuous_ofReal.comp_continuousOn (continuousOn_id.sub continuousOn_const).norm) fun z hz =>
        Complex.ofReal_ne_zero.mpr (norm_ne_zero_iff.mpr (sub_ne_zero.mpr hz))
  have hcone : β ∈ coneAt (⋃ j ∈ (univ : Set (Fin k)), F.region j ∩ A) w := by
    intro ε hε
    obtain ⟨r, hr, hrsub⟩ := Metric.isOpen_iff.mp F.isOpen_dom w hw
    obtain ⟨z, hzA, hzw, hzd, hzdir⟩ := h (min ε r) (lt_min hε hr)
    set V : Set ℂ := A ∩ ({z | z ≠ w} ∩ (fun z : ℂ => (z - w) / (‖z - w‖ : ℂ)) ⁻¹' ball (e β) ε) ∩ ball w (min ε r) with hV
    have hVo : IsOpen V := (hA.inter (hdir.isOpen_inter_preimage isOpen_ne isOpen_ball)).inter isOpen_ball
    have hzV : z ∈ V := ⟨⟨hzA, hzw, by rw [mem_preimage, mem_ball, dist_eq_norm]; exact hzdir.trans_le (min_le_left _ _)⟩,
      by rw [mem_ball]; exact hzd⟩
    have hzdom : z ∈ F.dom := hrsub (ball_subset_ball (min_le_right _ _) hzV.2)
    obtain ⟨y, hyV, hyI⟩ := mem_closure_iff.mp (F.dense_interiorPts hzdom) V hVo hzV
    refine ⟨y, mem_iUnion₂.mpr ⟨F.col y, mem_univ _, ⟨hyI, rfl⟩, hyV.1.1⟩, hyV.1.2.1,
      (mem_ball.mp hyV.2).trans_le (min_le_left _ _), ?_⟩
    have := hyV.1.2.2
    rwa [mem_preimage, mem_ball, dist_eq_norm] at this
  obtain ⟨j, -, hj⟩ := coneAt_biUnion_finite (Set.toFinite _) _ hcone
  exact ⟨j, hj⟩

/-- **A cone direction crossing `ω(v)` keeps its side**: at `w ∈ ω(v)`, if `e β` points strictly into `B(v, 1)`, a set approaching `w`
along `e β` approaches it from inside `ω(v)` (the first-order step `cone_expand`). -/
theorem mem_coneAt_inter_ball_of_re_neg {S : Set ℂ} {v w : ℂ} (hw : dist w v = 1) {β : ℝ} (hβ : β ∈ coneAt S w)
    (hneg : ((w - v) * starRingEnd ℂ (e β)).re < 0) : β ∈ coneAt (S ∩ ball v 1) w := by
  obtain ⟨s₀, hs₀⟩ : ∃ s₀, s₀ = ((w - v) * starRingEnd ℂ (e β)).re := ⟨_, rfl⟩
  rw [← hs₀] at hneg
  intro ε hε
  obtain ⟨z, hz, hzw, hzd, hzdir⟩ := hβ (min ε (-s₀ / 2)) (lt_min hε (by linarith))
  refine ⟨z, ⟨hz, ?_⟩, hzw, hzd.trans_le (min_le_left _ _), hzdir.trans_le (min_le_left _ _)⟩
  have hn : ‖w - v‖ = 1 := by rw [← dist_eq_norm]; exact hw
  have hh : z - w ≠ 0 := sub_ne_zero.mpr hzw
  obtain ⟨hexp, hre⟩ := cone_expand hn hh (hzdir.trans_le (min_le_right _ _))
  rw [← hs₀, abs_le] at hre
  have hhn : ‖z - w‖ < -s₀ / 2 := by rw [← dist_eq_norm]; exact hzd.trans_le (min_le_right _ _)
  have hpos : 0 < ‖z - w‖ := norm_pos_iff.mpr hh
  have hlt : ‖w - v + (z - w)‖ ^ 2 - 1 < 0 := by
    rw [hexp]; apply mul_neg_of_pos_of_neg hpos; linarith [hre.2]
  rw [mem_ball, dist_eq_norm, show z - v = w - v + (z - w) by ring]
  nlinarith [norm_nonneg (w - v + (z - w))]

/-- **A cone direction crossing `ω(v)` keeps its side**, outward: if `e β` points strictly out of `B̄(v, 1)`, a set approaching `w`
along `e β` approaches it from outside `ω(v)`. -/
theorem mem_coneAt_diff_closedBall_of_re_pos {S : Set ℂ} {v w : ℂ} (hw : dist w v = 1) {β : ℝ} (hβ : β ∈ coneAt S w)
    (hpos' : 0 < ((w - v) * starRingEnd ℂ (e β)).re) : β ∈ coneAt (S \ closedBall v 1) w := by
  obtain ⟨s₀, hs₀⟩ : ∃ s₀, s₀ = ((w - v) * starRingEnd ℂ (e β)).re := ⟨_, rfl⟩
  rw [← hs₀] at hpos'
  intro ε hε
  obtain ⟨z, hz, hzw, hzd, hzdir⟩ := hβ (min ε (s₀ / 2)) (lt_min hε (by linarith))
  refine ⟨z, ⟨hz, ?_⟩, hzw, hzd.trans_le (min_le_left _ _), hzdir.trans_le (min_le_left _ _)⟩
  have hn : ‖w - v‖ = 1 := by rw [← dist_eq_norm]; exact hw
  have hh : z - w ≠ 0 := sub_ne_zero.mpr hzw
  obtain ⟨hexp, hre⟩ := cone_expand hn hh (hzdir.trans_le (min_le_right _ _))
  rw [← hs₀, abs_le] at hre
  have hhn : ‖z - w‖ < s₀ / 2 := by rw [← dist_eq_norm]; exact hzd.trans_le (min_le_right _ _)
  have hpos : 0 < ‖z - w‖ := norm_pos_iff.mpr hh
  have hgt : 0 < ‖w - v + (z - w)‖ ^ 2 - 1 := by
    rw [hexp]; apply mul_pos hpos; linarith [hre.1]
  rw [mem_closedBall, dist_eq_norm, show z - v = w - v + (z - w) by ring, not_le]
  nlinarith [norm_nonneg (w - v + (z - w))]


/-- **Points approaching `w ∈ ω(u)` along a tangent of `ω(u)`**, strictly inside `ω(u)` (`τ = −1`) or strictly outside (`τ = 1`): with
`e β = (w − u)(σ i)`, the points `w + t (w − u)(τ sin η + σ i cos η)` for small `t ≤ sin η` and `η`. -/
theorem exists_near_tangent {u w : ℂ} (hw : dist w u = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {β : ℝ}
    (hβ : e β = (w - u) * (σ * I)) {τ : ℝ} (hτ : τ = 1 ∨ τ = -1) {ε : ℝ} (hε : 0 < ε) :
    ∃ z, 0 < τ * (dist z u - 1) ∧ z ≠ w ∧ dist z w < ε ∧ ‖(z - w) / (‖z - w‖ : ℂ) - e β‖ < ε := by
  have hπ := Real.pi_gt_three
  obtain ⟨η, hη⟩ : ∃ η, η = min (ε / 4) 1 := ⟨_, rfl⟩
  have hη0 : 0 < η := hη ▸ lt_min (by linarith) one_pos
  have hη1 : η ≤ 1 := hη ▸ min_le_right _ _
  have hηε : η ≤ ε / 4 := hη ▸ min_le_left _ _
  have hs0 : 0 < Real.sin η := Real.sin_pos_of_pos_of_lt_pi hη0 (by linarith)
  have hsle : Real.sin η ≤ η := Real.sin_le hη0.le
  have hcle : Real.cos η ≤ 1 := Real.cos_le_one η
  have hcge : 1 - η ^ 2 / 2 ≤ Real.cos η := Real.one_sub_sq_div_two_le_cos
  have hsc : Real.sin η ^ 2 + Real.cos η ^ 2 = 1 := Real.sin_sq_add_cos_sq η
  have hτ2 : τ ^ 2 = 1 := by rcases hτ with rfl | rfl <;> norm_num
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hτa : |τ| = 1 := by rcases hτ with rfl | rfl <;> norm_num
  have hσa : |σ| = 1 := by rcases hσ with rfl | rfl <;> norm_num
  obtain ⟨ζ, hζ⟩ : ∃ ζ : ℂ, ζ = ((τ * Real.sin η : ℝ) : ℂ) + ((σ * Real.cos η : ℝ) : ℂ) * I := ⟨_, rfl⟩
  have hζre : ζ.re = τ * Real.sin η := by
    rw [hζ, Complex.add_re, Complex.ofReal_re, Complex.re_ofReal_mul, Complex.I_re, mul_zero, add_zero]
  have hζim : ζ.im = σ * Real.cos η := by
    rw [hζ, Complex.add_im, Complex.ofReal_im, Complex.im_ofReal_mul, Complex.I_im, mul_one, zero_add]
  obtain ⟨t, ht⟩ : ∃ t, t = min (Real.sin η) (ε / 2) := ⟨_, rfl⟩
  have ht0 : 0 < t := ht ▸ lt_min hs0 (by linarith)
  have hts : t ≤ Real.sin η := ht ▸ min_le_left _ _
  have htε : t ≤ ε / 2 := ht ▸ min_le_right _ _
  have hp : ‖w - u‖ = 1 := by rw [← dist_eq_norm]; exact hw
  have hζn : ‖ζ‖ = 1 := by
    have h := Complex.sq_norm ζ
    rw [Complex.normSq_apply, hζre, hζim] at h
    have h1 : ‖ζ‖ ^ 2 = 1 := by
      rw [h]; linear_combination (Real.sin η ^ 2) * hτ2 + (Real.cos η ^ 2) * hσ2 + hsc
    nlinarith [norm_nonneg ζ]
  have hnorm : ‖w + (t : ℂ) * ((w - u) * ζ) - w‖ = t := by
    rw [add_sub_cancel_left, norm_mul, norm_mul, hp, hζn, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; ring
  refine ⟨w + (t : ℂ) * ((w - u) * ζ), ?_, ?_, ?_, ?_⟩
  · have hzu : w + (t : ℂ) * ((w - u) * ζ) - u = (w - u) * (1 + (t : ℂ) * ζ) := by ring
    have hn : dist (w + (t : ℂ) * ((w - u) * ζ)) u = ‖1 + (t : ℂ) * ζ‖ := by
      rw [dist_eq_norm, hzu, norm_mul, hp, one_mul]
    have hsq : ‖1 + (t : ℂ) * ζ‖ ^ 2 = 1 + 2 * t * τ * Real.sin η + t ^ 2 := by
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp only [Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im, Complex.re_ofReal_mul,
        Complex.im_ofReal_mul, hζre, hζim]
      linear_combination (t ^ 2 * Real.sin η ^ 2) * hτ2 + (t ^ 2 * Real.cos η ^ 2) * hσ2 + t ^ 2 * hsc
    rw [hn]
    have hn0 := norm_nonneg (1 + (t : ℂ) * ζ)
    have hts' : t * t ≤ t * Real.sin η := mul_le_mul_of_nonneg_left hts ht0.le
    have hpos : 0 < t * Real.sin η := mul_pos ht0 hs0
    rcases hτ with rfl | rfl
    · nlinarith
    · nlinarith
  · intro h
    have h0 : ‖w + (t : ℂ) * ((w - u) * ζ) - w‖ = 0 := by rw [h, sub_self, norm_zero]
    rw [hnorm] at h0
    exact ht0.ne' h0
  · rw [dist_eq_norm, hnorm]; linarith
  · rw [hnorm, add_sub_cancel_left, mul_div_cancel_left₀ _ (by exact_mod_cast ht0.ne'), hβ,
      show (w - u) * ζ - (w - u) * (σ * I) = (w - u) * (ζ - σ * I) by ring, norm_mul, hp, one_mul]
    have hd : ζ - σ * I = ((τ * Real.sin η : ℝ) : ℂ) + ((σ * (Real.cos η - 1) : ℝ) : ℂ) * I := by
      rw [hζ]; push_cast; ring
    rw [hd]
    calc _ ≤ ‖((τ * Real.sin η : ℝ) : ℂ)‖ + ‖((σ * (Real.cos η - 1) : ℝ) : ℂ) * I‖ := norm_add_le _ _
      _ = Real.sin η + (1 - Real.cos η) := by
          rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs,
            abs_mul, abs_mul, hτa, hσa, one_mul, one_mul, abs_of_pos hs0, abs_of_nonpos (by linarith)]
          ring
      _ < ε := by nlinarith

/-- **A colour not carried at `u` on each half-tangent of `ω(u)` at `w`** (N3-COR3's "one failure is not enough", read through cones):
along `e β = (w − u)(σ i)`, colours approach `w` from inside and from outside `ω(u)` (`exists_mem_coneAt_region_inter` on the points of
`exists_near_tangent`); if both were colours of `u`, the arc between them (`exists_ringArc_of_sides`) would put `β` in its facing and in its
away cone (`IsRingArc.disjoint_coneAt`). Any `k`. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane:
`sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). -/
theorem exists_tangent_colour (hF : F.Valid) {u w : ℂ} (hu : F.IsCubicTrichromatic u) (hud : u ∈ F.dom) (hwd : w ∈ F.dom)
    (hwu : dist w u = 1) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {β : ℝ} (hβ : e β = (w - u) * (σ * I)) :
    ∃ x ∉ F.coloursAt u, β ∈ coneAt (F.region x) w := by
  have hpts : ∀ τ : ℝ, (τ = 1 ∨ τ = -1) → ∀ ε > 0, ∃ z ∈ {z : ℂ | 0 < τ * (dist z u - 1)}, z ≠ w ∧ dist z w < ε ∧
      ‖(z - w) / (‖z - w‖ : ℂ) - e β‖ < ε := fun τ hτ ε hε => by
    obtain ⟨z, h1, h2, h3, h4⟩ := exists_near_tangent hwu hσ hβ hτ hε
    exact ⟨z, h1, h2, h3, h4⟩
  have hopen : ∀ τ : ℝ, IsOpen {z : ℂ | 0 < τ * (dist z u - 1)} := fun τ =>
    isOpen_lt continuous_const (continuous_const.mul ((continuous_id.dist continuous_const).sub continuous_const))
  obtain ⟨j, hj⟩ := exists_mem_coneAt_region_inter hwd (hopen (-1)) (hpts (-1) (Or.inr rfl))
  obtain ⟨j', hj'⟩ := exists_mem_coneAt_region_inter hwd (hopen 1) (hpts 1 (Or.inl rfl))
  by_cases hju : j ∈ F.coloursAt u
  · by_cases hj'u : j' ∈ F.coloursAt u
    · exfalso
      have hin : w ∈ closure (F.region j ∩ ball u 1) := by
        refine closure_mono ?_ (mem_closure_of_mem_coneAt hj)
        rintro z ⟨hz, hz'⟩
        simp only [mem_setOf_eq] at hz'
        exact ⟨hz, by rw [mem_ball]; linarith⟩
      have hout : w ∈ closure (F.region j' \ closedBall u 1) := by
        refine closure_mono ?_ (mem_closure_of_mem_coneAt hj')
        rintro z ⟨hz, hz'⟩
        simp only [mem_setOf_eq] at hz'
        exact ⟨hz, by rw [mem_closedBall, not_le]; linarith⟩
      obtain ⟨θ₁, θ₂, hR, -⟩ := exists_ringArc_of_sides hF hu hud hwu hju hj'u hin hout
      exact Set.disjoint_left.mp (hR.disjoint_coneAt hF) (coneAt_mono inter_subset_left w hj)
        (coneAt_mono inter_subset_left w hj')
    · exact ⟨j', hj'u, coneAt_mono inter_subset_left w hj'⟩
  · exact ⟨j, hju, coneAt_mono inter_subset_left w hj⟩

/-- **The arc of `ω(w)` at `v` that `ω(u)` forces** (N3-COR3 at one crossing, `v`'s half): at `w ∈ ω(u) ∩ ω(v)`, crossing transversally,
with every colour carried at `u` or at `v`, the two half-tangents of `ω(u)` at `w` lie on opposite sides of `ω(v)`, and each carries a
colour of `v` (`exists_tangent_colour`): one inside `ω(v)`, one outside (`mem_coneAt_inter_ball_of_re_neg` and its outward form). The arc
between them (`exists_ringArc_of_sides` at `v`) is an arc of `Γ` on `ω(w)` ending at `v` whose two side colours, distinct
(`IsRingArc.disjoint_coneAt`), are carried at `w`. A step of `cor3_local`'s proof (no model expected at six colours; `GENERIC`). -/
theorem cor3_half (hF : F.Valid) {u v w : ℂ} (hu : F.IsCubicTrichromatic u) (hv : F.IsCubicTrichromatic v) (hud : u ∈ F.dom)
    (hvd : v ∈ F.dom) (hwd : w ∈ F.dom) (hwu : dist w u = 1) (hwv : dist w v = 1)
    (hcov : ∀ j, j ∉ F.coloursAt u → j ∈ F.coloursAt v) (htr : ((w - v) * starRingEnd ℂ (w - u)).im ≠ 0) :
    ∃ x x' θ₁ θ₂, x ≠ x' ∧ x ∈ F.coloursAt v ∧ x' ∈ F.coloursAt v ∧ x ∈ F.coloursAt w ∧ x' ∈ F.coloursAt w ∧
      F.IsRingArc w θ₁ θ₂ x x' ∧ (ringPt w θ₁ = v ∨ ringPt w θ₂ = v) := by
  have hp : ‖w - u‖ = 1 := by rw [← dist_eq_norm]; exact hwu
  have htan : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → ∃ β, e β = (w - u) * (σ * I) ∧
      ((w - v) * starRingEnd ℂ (e β)).re = σ * ((w - v) * starRingEnd ℂ (w - u)).im := by
    intro σ hσ
    have hn : ‖(w - u) * (σ * I)‖ = 1 := by
      rw [norm_mul, hp, one_mul, norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
      rcases hσ with rfl | rfl <;> norm_num
    refine ⟨arg ((w - u) * (σ * I)), e_arg_of_norm_eq_one hn, ?_⟩
    rw [e_arg_of_norm_eq_one hn, map_mul, map_mul, Complex.conj_ofReal, Complex.conj_I,
      show (w - v) * ((starRingEnd ℂ) (w - u) * ((σ : ℂ) * -I)) = (w - v) * (starRingEnd ℂ) (w - u) * ((σ : ℂ) * -I) by ring]
    simp only [Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.neg_re, Complex.neg_im,
      Complex.I_re, Complex.I_im]
    ring
  have hfin : ∀ (x x' : Fin k) (β β' : ℝ), x ∈ F.coloursAt v → x' ∈ F.coloursAt v → β ∈ coneAt (F.region x ∩ ball v 1) w →
      β' ∈ coneAt (F.region x' \ closedBall v 1) w → ∃ x x' θ₁ θ₂, x ≠ x' ∧ x ∈ F.coloursAt v ∧ x' ∈ F.coloursAt v ∧
        x ∈ F.coloursAt w ∧ x' ∈ F.coloursAt w ∧ F.IsRingArc w θ₁ θ₂ x x' ∧ (ringPt w θ₁ = v ∨ ringPt w θ₂ = v) := by
    intro x x' β β' hx hx' hb hb'
    obtain ⟨θ₁, θ₂, hR, hend⟩ := exists_ringArc_of_sides hF hv hvd hwv hx hx' (mem_closure_of_mem_coneAt hb)
      (mem_closure_of_mem_coneAt hb')
    have hxw : x ∈ F.coloursAt w := closure_mono inter_subset_left (mem_closure_of_mem_coneAt hb)
    have hx'w : x' ∈ F.coloursAt w := closure_mono sdiff_subset (mem_closure_of_mem_coneAt hb')
    refine ⟨x, x', θ₁, θ₂, ?_, hx, hx', hxw, hx'w, hR, hend⟩
    rintro rfl
    exact Set.disjoint_left.mp (hR.disjoint_coneAt hF) (coneAt_mono inter_subset_left w hb)
      (coneAt_mono inter_subset_left w hb)
  obtain ⟨β₁, hβ₁, hs₁⟩ := htan 1 (Or.inl rfl)
  obtain ⟨β₂, hβ₂, hs₂⟩ := htan (-1) (Or.inr rfl)
  obtain ⟨x₁, hx₁u, hx₁⟩ := exists_tangent_colour hF hu hud hwd hwu (Or.inl rfl) hβ₁
  obtain ⟨x₂, hx₂u, hx₂⟩ := exists_tangent_colour hF hu hud hwd hwu (Or.inr rfl) hβ₂
  rcases lt_or_gt_of_ne htr with hneg | hpos
  · exact hfin x₁ x₂ β₁ β₂ (hcov x₁ hx₁u) (hcov x₂ hx₂u)
      (mem_coneAt_inter_ball_of_re_neg hwv hx₁ (by rw [hs₁]; linarith))
      (mem_coneAt_diff_closedBall_of_re_pos hwv hx₂ (by rw [hs₂]; linarith))
  · exact hfin x₂ x₁ β₂ β₁ (hcov x₂ hx₂u) (hcov x₁ hx₁u)
      (mem_coneAt_inter_ball_of_re_neg hwv hx₂ (by rw [hs₂]; linarith))
      (mem_coneAt_diff_closedBall_of_re_pos hwv hx₁ (by rw [hs₁]; linarith))

/-- **N3-COR3 at one crossing**: at `w ∈ ω(u) ∩ ω(v)`, crossing transversally, `u` and `v` cubic trichromatic with disjoint colours
covering all colours, `w` carries two colours of `v` and two of `u` — four — and is a leaving centre of both, the centre of a both-kind
arc (`cor3_half` twice, the roles exchanged). At six colours a valid fragment with such a pair is FS112-STOP's object (no model; `GENERIC`,
as `cor3_local`). -/
theorem cor3_at (hF : F.Valid) {u v w : ℂ} (hu : F.IsCubicTrichromatic u) (hv : F.IsCubicTrichromatic v) (hud : u ∈ F.dom)
    (hvd : v ∈ F.dom) (hwd : w ∈ F.dom) (hwu : dist w u = 1) (hwv : dist w v = 1)
    (hunion : ∀ j, j ∈ F.coloursAt u ∨ j ∈ F.coloursAt v) (hdis : Disjoint (F.coloursAt u) (F.coloursAt v))
    (htr : ((w - v) * starRingEnd ℂ (w - u)).im ≠ 0) :
    4 ≤ (F.coloursAt w).ncard ∧ F.IsLeavingCentre u w ∧ F.IsLeavingCentre v w ∧ ∃ θ₁ θ₂, F.BothKind w θ₁ θ₂ := by
  obtain ⟨x, x', θ₁, θ₂, hxx', hx, hx', hxw, hx'w, hR, hend⟩ :=
    cor3_half hF hu hv hud hvd hwd hwu hwv (fun j hj => (hunion j).resolve_left hj) htr
  have htr' : ((w - u) * starRingEnd ℂ (w - v)).im ≠ 0 := by
    have h : ((w - u) * starRingEnd ℂ (w - v)).im = -((w - v) * starRingEnd ℂ (w - u)).im := by
      simp only [Complex.mul_im, Complex.conj_re, Complex.conj_im]; ring
    rw [h]; exact neg_ne_zero.mpr htr
  obtain ⟨y, y', φ₁, φ₂, hyy', hy, hy', hyw, hy'w, hR', hend'⟩ :=
    cor3_half hF hv hu hvd hud hwd hwv hwu (fun j hj => (hunion j).resolve_right hj) htr'
  refine ⟨?_, ⟨hwu, φ₁, φ₂, y, y', hR', hend'⟩, ⟨hwv, θ₁, θ₂, x, x', hR, hend⟩, θ₁, θ₂, x, x', hR, hxw, hx'w⟩
  have hne : ∀ a ∈ F.coloursAt v, ∀ b ∈ F.coloursAt u, a ≠ b := fun a ha b hb hab =>
    Set.disjoint_left.mp hdis hb (hab ▸ ha)
  have h4 : ({x, x', y, y'} : Set (Fin k)).ncard = 4 := by
    rw [Set.ncard_insert_of_notMem, Set.ncard_insert_of_notMem, Set.ncard_pair hyy']
    · simp only [mem_insert_iff, mem_singleton_iff, not_or]
      exact ⟨hne x' hx' y hy, hne x' hx' y' hy'⟩
    · simp only [mem_insert_iff, mem_singleton_iff, not_or]
      exact ⟨hxx', hne x hx y hy, hne x hx y' hy'⟩
  rw [← h4]
  refine Set.ncard_le_ncard ?_ (Set.toFinite _)
  simp only [insert_subset_iff, singleton_subset_iff]
  exact ⟨hxw, hx'w, hyw, hy'w⟩

/-- **The two crossings of two unit circles** whose centres are less than `2` apart: two distinct points at distance `1` from both, at
each of which the circles cross transversally (`Im((w − v) conj (w − u)) = ± |u − v| √(1 − |u − v|²/4) ≠ 0`). -/
theorem exists_crossings {u v : ℂ} (huv : u ≠ v) (hd : dist u v < 2) :
    ∃ w₁ w₂ : ℂ, w₁ ≠ w₂ ∧ ∀ w ∈ ({w₁, w₂} : Set ℂ), dist w u = 1 ∧ dist w v = 1 ∧
      ((w - v) * starRingEnd ℂ (w - u)).im ≠ 0 := by
  obtain ⟨D, hD⟩ : ∃ D, D = v - u := ⟨_, rfl⟩
  have hD0 : D ≠ 0 := by rw [hD]; exact sub_ne_zero.mpr huv.symm
  obtain ⟨d, hdd⟩ : ∃ d, d = ‖D‖ := ⟨_, rfl⟩
  have hd0 : 0 < d := hdd ▸ norm_pos_iff.mpr hD0
  have hd2 : d < 2 := by rw [hdd, hD, ← dist_eq_norm, dist_comm]; exact hd
  have hnsq : Complex.normSq D = d ^ 2 := by rw [hdd, Complex.sq_norm]
  obtain ⟨h, hh⟩ : ∃ h, h = Real.sqrt (1 - d ^ 2 / 4) := ⟨_, rfl⟩
  have hh0 : 0 < h := hh ▸ Real.sqrt_pos.mpr (by nlinarith)
  have hhsq : h ^ 2 = 1 - d ^ 2 / 4 := hh ▸ Real.sq_sqrt (by nlinarith)
  have key : ∀ σ : ℝ, σ ^ 2 = 1 → ∀ c : ℂ, c = (1 / 2 : ℂ) + ((σ * h / d : ℝ) : ℂ) * I →
      dist (u + D * c) u = 1 ∧ dist (u + D * c) v = 1 ∧ ((u + D * c - v) * starRingEnd ℂ (u + D * c - u)).im ≠ 0 := by
    intro σ hσ c hc
    have hcre : c.re = 1 / 2 := by rw [hc]; simp
    have hcim : c.im = σ * h / d := by rw [hc]; simp
    have hdn : d ≠ 0 := hd0.ne'
    have hsq1 : d ^ 2 * ((1 / 2) ^ 2 + (σ * h / d) ^ 2) = 1 := by
      field_simp
      linear_combination (4 * h ^ 2) * hσ + 4 * hhsq
    have hsq2 : d ^ 2 * ((1 / 2 - 1) ^ 2 + (σ * h / d) ^ 2) = 1 := by
      field_simp
      linear_combination (4 * h ^ 2) * hσ + 4 * hhsq
    have hv : v = u + D := by rw [hD]; ring
    have hnorm1 : ∀ z : ℂ, ‖z‖ ^ 2 = 1 → ‖z‖ = 1 := fun z hz => by nlinarith [norm_nonneg z]
    refine ⟨?_, ?_, ?_⟩
    · rw [dist_eq_norm, add_sub_cancel_left]
      apply hnorm1
      rw [Complex.sq_norm, Complex.normSq_mul, hnsq, Complex.normSq_apply, hcre, hcim]; linear_combination hsq1
    · rw [dist_eq_norm, hv, show u + D * c - (u + D) = D * (c - 1) by ring]
      apply hnorm1
      rw [Complex.sq_norm, Complex.normSq_mul, hnsq, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
        Complex.one_im, hcre, hcim]; linear_combination hsq2
    · rw [hv, show u + D * c - (u + D) = D * (c - 1) by ring, add_sub_cancel_left, map_mul,
        show D * (c - 1) * ((starRingEnd ℂ) D * (starRingEnd ℂ) c) = (D * (starRingEnd ℂ) D) * ((c - 1) * (starRingEnd ℂ) c) by ring,
        Complex.mul_conj, hnsq, Complex.im_ofReal_mul]
      simp only [Complex.mul_im, Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, Complex.conj_re, Complex.conj_im,
        hcre, hcim]
      have hσ0 : σ ≠ 0 := by rintro rfl; norm_num at hσ
      rw [show d ^ 2 * ((1 / 2 - 1) * -(σ * h / d) + (σ * h / d - 0) * (1 / 2)) = σ * d * h by field_simp; ring]
      exact mul_ne_zero (mul_ne_zero hσ0 hdn) hh0.ne'
  obtain ⟨c₁, hc₁⟩ : ∃ c : ℂ, c = (1 / 2 : ℂ) + (((1 : ℝ) * h / d : ℝ) : ℂ) * I := ⟨_, rfl⟩
  obtain ⟨c₂, hc₂⟩ : ∃ c : ℂ, c = (1 / 2 : ℂ) + (((-1 : ℝ) * h / d : ℝ) : ℂ) * I := ⟨_, rfl⟩
  refine ⟨u + D * c₁, u + D * c₂, ?_, ?_⟩
  · intro heq
    have h1 : D * (c₁ - c₂) = 0 := by linear_combination heq
    have h2 : c₁ - c₂ ≠ 0 := by
      intro h0
      have := congrArg Complex.im h0
      rw [hc₁, hc₂] at this
      simp at this
      have : h / d = 0 := by rw [neg_div] at this; linarith
      rw [div_eq_zero_iff] at this
      rcases this with h3 | h3
      · exact hh0.ne' h3
      · exact hd0.ne' h3
    exact h2 ((mul_eq_zero.mp h1).resolve_left hD0)
  · rintro w (rfl | rfl)
    · exact key 1 (by norm_num) c₁ hc₁
    · exact key (-1) (by norm_num) c₂ hc₂

end Cor3Children


/-! ## FS112-N3-COR3 -/

/-- **FS112-N3-COR3, local form** (inventory item 218 (b): "`cor3_local`, reading small discs only"; item 299 (c)): `cor3`'s conclusion
with its two covering hypotheses `Covers u 1`, `Covers u′ 1` replaced by what N3-COR3's argument (`plans/FS112-NB3-verification.md` § 1.4) reads —
`u`, `u′` and the two common unit points in the domain, which is open, so each with a small disc about it: the strips at the crossings `w₀, w₀′`
(NB3-FAIL at `w`; `fail_leavingCentre` and `fail_colours` read only `u ∈ F.dom`, the chart at `u` and the map near `w`), the arcs of `ω(w)` ending at
`u`, `u′` (inside the charts there), and N112-U1 at `w` (`ringArc_cone_outer`, which reads no covering). `cor3` is its instance. The form the base
reads at a centre `p ∈ B̄(u, 1)` and a point `x ∈ ω(p)`, where `B̄(x, 1)` need not lie in the base's `B̄(u, 2)` (`pseudo_ncard_le_two_of_baseHyp`). Six
colours are spent. No inhabitant: a valid fragment with such a pair is FS112-STOP's object; `GENERIC`, as `cor3`. -/
theorem cor3_local {F : ArcMap 6} (hF : F.Valid) {u u' : ℂ} (hu : F.IsCubicTrichromatic u) (hu' : F.IsCubicTrichromatic u')
    (hud : u ∈ F.dom) (hud' : u' ∈ F.dom) (hq : ∀ q, dist q u = 1 → dist q u' = 1 → q ∈ F.dom)
    (hdis : Disjoint (F.coloursAt u) (F.coloursAt u')) (hd : dist u u' < 2) :
    ∃ qp qm : ℂ, qp ≠ qm ∧ ∀ q ∈ ({qp, qm} : Set ℂ), dist q u = 1 ∧ dist q u' = 1 ∧ 4 ≤ (F.coloursAt q).ncard ∧
      F.IsLeavingCentre u q ∧ F.IsLeavingCentre u' q ∧ ∃ θ₁ θ₂, F.BothKind q θ₁ θ₂ := by
  -- six colours: the two disjoint triples are all of them
  have hunion : ∀ j, j ∈ F.coloursAt u ∨ j ∈ F.coloursAt u' := by
    have hU : F.coloursAt u ∪ F.coloursAt u' = univ := by
      refine Set.eq_of_subset_of_ncard_le (subset_univ _) ?_
      rw [Set.ncard_union_eq hdis, hu.2, hu'.2, Set.ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]
    intro j
    have hj : j ∈ F.coloursAt u ∪ F.coloursAt u' := by rw [hU]; exact mem_univ j
    exact hj
  have huu' : u ≠ u' := by
    rintro rfl
    have h0 : F.coloursAt u = ∅ := disjoint_self.mp hdis
    have h3 := hu.2
    rw [h0, Set.ncard_empty] at h3
    exact absurd h3 (by norm_num)
  obtain ⟨w₁, w₂, hne, hw⟩ := exists_crossings huu' hd
  refine ⟨w₁, w₂, hne, fun q hqm => ?_⟩
  obtain ⟨hqu, hqu', htr⟩ := hw q hqm
  obtain ⟨h4, hl, hl', hb⟩ := cor3_at hF hu hu' hud hud' (hq q hqu hqu') hqu hqu' hunion hdis htr
  exact ⟨hqu, hqu', h4, hl, hl', hb⟩

/-- **FS112-N3-COR3**: in a valid six-coloured map, a close complementary pair of cubic trichromatic vertices `u, u′` (disjoint
multicolours, `|u − u′| < 2`) sits on a unit rhombus `u, qp, u′, qm` whose other corners carry at least four colours, each a leaving
centre of both `u` and `u′` and the centre of a both-kind unit arc ("T2 is forced at both common unit points"). Stated for fragments
covering `B̄(u, 1)` and `B̄(u′, 1)` (the class the argument reads: the strips at `q±` and the arcs at `u`, `u′`) — a widening of "in a
valid map", reported. Six colours are spent ("the complement of `c(u′)` is `c(u)`"). No inhabitant: a valid fragment with such a pair is
FS112-STOP's object (the strip's printed colouring violates it); `GENERIC`. -/
theorem cor3 {F : ArcMap 6} (hF : F.Valid) {u u' : ℂ} (hu : F.IsCubicTrichromatic u) (hu' : F.IsCubicTrichromatic u')
    (hcu : F.Covers u 1) (hcu' : F.Covers u' 1) (hdis : Disjoint (F.coloursAt u) (F.coloursAt u')) (hd : dist u u' < 2) :
    ∃ qp qm : ℂ, qp ≠ qm ∧ ∀ q ∈ ({qp, qm} : Set ℂ), dist q u = 1 ∧ dist q u' = 1 ∧ 4 ≤ (F.coloursAt q).ncard ∧
      F.IsLeavingCentre u q ∧ F.IsLeavingCentre u' q ∧ ∃ θ₁ θ₂, F.BothKind q θ₁ θ₂ :=
  cor3_local hF hu hu' (hcu (mem_closedBall_self zero_le_one)) (hcu' (mem_closedBall_self zero_le_one))
    (fun _ hq _ => hcu (by rw [mem_closedBall, hq])) hdis hd

end ArcMap

end HadwigerNelson.Plane
