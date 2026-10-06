import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

namespace Near

variable {v : ℂ} {X : F.Near v} {s : Fin X.n} {a b : ℕ}

/-- **The vertex step from MERGE's surgery** (FS110-W-MERGE's construction, cleaned): the surgery at radius `ρ` with `mergeArcs` and
`mergeCol` — the gap recoloured `c` inside `ρ/2`, its germs dropped there, the rim arc at `ρ/2` across it — then `cleanKeep`. The
arcs of the surgery lie on the map's arcs and on the rim arc (`mem_merge_interiorPts_of_mem`), so the junctions are on the circle of
radius `ρ/2`: at a gap germ the germ's inner branch is interior to the recoloured gap; at any other germ the sector after it is no
gap sector, and its points on that circle are off the rim arc, interior to the surgery. The count is `pot_lt_of_interior` at the
gap's first germ. Neither the gap's freedom from `c`-sectors nor `a + 1 < b` is read. -/
theorem exists_mergeStep_aux {ρ ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hF : F.Valid) (hc : F.IsClean)
    {c : Fin k} (hab : a < b) (hbn : b < X.n) (hca : X.col (BranchGerms.idx s a) = c)
    (hcb : X.col (BranchGerms.idx s b) = c) {ρc : ℝ} (hρc : ρ ≤ ρc)
    (hgc : ∀ t ∈ Ioo 0 ρc, ∀ φ, X.G.liftDir s (a + 1) t ≤ φ → φ ≤ X.G.liftDir s b t → F.IsClear c (v + (t : ℂ) * e φ))
    {m j : ℕ} (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  have hn0 : 0 < X.n := s.pos
  have hhalf : 0 < ρ / 2 := by linarith [h.1]
  have hhalfρ' : ρ / 2 < ρ' := by linarith [h.1]
  set F₁ := F.surgery v ρ (X.G.mergeArcs v X.col s a b ρ) (X.G.mergeCol v X.col F.col s a b c ρ) X.mem_dom h.1
    (mergeArcs_nondegenerate h hbn) (mergeArcs_finite ρ) (merge_hlc h' hρρ' h hab hbn hca hcb) with hF₁
  have hval : F₁.Valid := merge_valid hF h' hρρ' h hab hbn hρc hgc
  have hself : F₁.coloursAt v ⊆ F.coloursAt v := merge_coloursAt_self h hab hbn hca
  -- an interior point of the map off the rim arc is interior to the surgery
  have hI₁ : ∀ z ∈ F.interiorPts, z ∉ (X.G.rimArc v s a b ρ).carrier → z ∈ F₁.interiorPts := fun z hz hzr =>
    mem_merge_interiorPts_of_mem h hz hzr
  have hΓ₁ : ∀ z ∈ F₁.Γ, z ∈ F.Γ ∨ z ∈ (X.G.rimArc v s a b ρ).carrier := by
    intro z hz
    by_contra hcon
    push Not at hcon
    exact (hI₁ z ⟨hz.1, fun hzF => hcon.1 ⟨hz.1, hzF⟩⟩ hcon.2).2 hz.2
  -- a gap germ's points inside `ρ/2` are interior to the surgery
  have hgapI : ∀ i ∈ BranchGerms.gapGerm s a b, ∀ t ∈ Ioo 0 (ρ / 2),
      branchPt v (X.G.β i) (X.G.κ i) t ∈ F₁.interiorPts := by
    intro i hi t ht
    have hzb : branchPt v (X.G.β i) (X.G.κ i) t ∈ ball v ρ := by
      rw [mem_ball, dist_branchPt i ht.1.le]; linarith [ht.2]
    have hzb2 : branchPt v (X.G.β i) (X.G.κ i) t ∈ ball v (ρ / 2) := by
      rw [mem_ball, dist_branchPt i ht.1.le]; exact ht.2
    refine (mem_merge_interiorPts_iff h hzb).mpr fun hzA => ?_
    rcases mem_mergeArcs_inner h hzb2 hzA with h1 | ⟨j', hj', t', ht', he⟩
    · have h3 := congrArg (fun z => dist z v) h1
      simp only [dist_branchPt i ht.1.le, dist_self] at h3
      linarith [ht.1]
    · have htt : t' = t := by
        have h3 := congrArg (fun z => dist z v) he
        simp only [dist_branchPt i ht.1.le, dist_branchPt j' ht'.1.le] at h3
        exact h3.symm
      subst htt
      exact hj' ((eq_of_branchPt_eq X.hdisj ⟨ht'.1, by linarith [ht'.2, h.1, h.2.1]⟩ he) ▸ hi)
  have hpts : ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F₁.cleanKeep.IsSite x ∧ (F₁.cleanKeep.coloursAt x).ncard ≤ 3 := by
    intro x hx hxv
    refine X.not_isSite_of_chart (M := F₁.cleanKeep) h' hhalf hhalfρ' cleanKeep_isClean rfl ∅ (by simp) (by simp) ?_
      (closedBall_subset_ball hρρ' hx) hxv ?_ (by simp)
    · intro z hz hzR hzv
      rcases hΓ₁ z (cleanKeep_Γ_subset _ hz) with h1 | h1
      · exact Or.inr (Or.inl (X.hC.exists_branchPt_eq hzv (ball_subset_ball h'.lt_r₀.le hzR) fun hI => hI.2 h1.2))
      · left
        rw [mem_sphere, dist_eq_norm]; exact norm_of_mem_rimArc h h1
    · intro i hxi ε hε
      by_cases hi : i ∈ BranchGerms.gapGerm s a b
      · -- a gap germ: its branch inside `ρ/2` is interior to the recoloured gap
        obtain ⟨t, ht, htε⟩ := exists_branchPt_near_lt v (X.G.β i) (X.G.κ i) hhalf hε
        refine ⟨_, by rw [mem_ball, hxi]; exact htε, fun heq => ?_,
          Or.inr ⟨t, ⟨ht.1.le, by linarith [ht.2, h.1]⟩, rfl⟩,
          fun hΓ => (hgapI i hi t ht).2 (cleanKeep_Γ_subset _ hΓ).2⟩
        have h3 := congrArg (fun z => dist z v) heq
        simp only [hxi, dist_branchPt i ht.1.le, dist_branchPt i hhalf.le] at h3
        linarith [ht.2]
      · -- another germ: the sector after it is no gap sector, its points at `ρ/2` are off the rim arc
        obtain ⟨w, hw, hwρ, hwx⟩ := X.exists_rim_mem_sector h' hhalf hhalfρ' i hε
        have hwρ' : w ∈ X.G.sector v ρ i := mem_sector_of_lt hw (by rw [← dist_eq_norm, hwρ]; linarith [h.1])
        have hwI : w ∈ F.interiorPts := sector_subset_interiorPts h' i hw
        have hwr : w ∉ (X.G.rimArc v s a b ρ).carrier := fun hr => by
          obtain ⟨m', h1, h2, he⟩ := gapSec_of_mem_rimArc h hab hwρ' hr
          exact hi ⟨m', h1, h2.le, he⟩
        refine ⟨w, by rw [mem_ball, hxi]; exact hwx, fun hwx' => ?_, Or.inl hwρ,
          fun hΓ => (hI₁ w hwI hwr).2 (cleanKeep_Γ_subset _ hΓ).2⟩
        rw [hwx', hxi] at hwI
        exact hwI.2 (X.hC.branchPt_mem_Γ i ⟨hhalf, hhalfρ'.trans h'.lt_r₀⟩).2
  refine surgery_step hc (mergeArcs_subset_closedBall h)
    (fun z hz => mergeCol_of_not_mem h fun hb => hz (ball_subset_closedBall hb)) hval (merge_ringArcsWithin h) hself hpts
    (fun m' j' hm' hj' => pot_lt_of_interior X (X.two_le_of_isClean hc hn0) ?_ (p := BranchGerms.idx s a) ?_ hdeg hhorn
      hm' hj')
  · filter_upwards [Ioo_mem_nhdsGT hhalf] with r hr
    rintro z ⟨hzI, hzb⟩
    refine F₁.interiorPts_subset_cleanKeep (hI₁ z hzI fun hzr => ?_)
    have h3 := norm_of_mem_rimArc h hzr
    rw [mem_ball, dist_eq_norm, h3] at hzb
    linarith [hr.2]
  · filter_upwards [Ioo_mem_nhdsGT hhalf] with t ht
    rw [BranchGerms.next_idx]
    exact F₁.interiorPts_subset_cleanKeep (hgapI _ ⟨a + 1, by omega, by omega, rfl⟩ t ht)

end Near

/-- test: MERGE's case -/
theorem exists_mergeStep' (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
    (hn : F.HasSectors v c (n + 1)) (hD : (interior (F.allowedCone v c)).Nonempty) {m j : ℕ} (hdeg : F.HasDegree v m)
    (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  classical
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨s, a, b, hab, hbn, hca, hcb, -, ρc, hρc0, hgc⟩ := X.exists_gap hF hv hn1 hn hD
  obtain ⟨ρ', h'⟩ := X.eventually_small.exists
  have hρ'0 := h'.1
  set ρ := min (min (ρ' / 2) (ρc / 2)) (δ / 2) with hρdef
  have hρ0 : 0 < ρ := lt_min (lt_min (by linarith) (by linarith)) (by linarith)
  have hρρ' : ρ < ρ' := ((min_le_left _ _).trans (min_le_left _ _)).trans_lt (by linarith)
  have hρc : ρ ≤ ρc := ((min_le_left _ _).trans (min_le_right _ _)).trans (by linarith)
  have hρδ : ρ < δ := (min_le_right _ _).trans_lt (by linarith)
  have h : X.Small ρ := h'.mono hρ0 hρρ'.le
  exact ⟨ρ, hρ0, hρδ, Near.exists_mergeStep_aux h' hρρ' h hF hc hab hbn hca hcb hρc hgc hdeg hhorn⟩

end ArcMap

end HadwigerNelson.Plane
