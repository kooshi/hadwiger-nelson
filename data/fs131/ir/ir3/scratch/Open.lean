import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

namespace Near

variable {v : ℂ} {X : F.Near v} {s : Fin X.n} {b : ℕ}

/-- **The vertex step from OPEN's surgery** (FS131-E6-OPEN's construction, cleaned): the surgery at radius `ρ` with `openArcs` and
`openCol` — the gap `s, 0, b` and the wedge recoloured `c` inside `ρ/2`, the ray added, the rim arcs at `ρ/2` — then `cleanKeep`. The
count is `open_degree_horns` and `cleanKeep_pot_le`. The arcs of the surgery lie on the map's arcs, on the circle of radius `ρ/2`
and on the ray, a branch apart from the chart's germs below `ρc`; at a gap germ on that circle the germ's inner branch is interior
(`OpenConfig.not_mem_openArcs`); at another germ, a sector beside it is neither a gap sector nor the partial sector, so its points
on the circle are interior (`mem_open_interiorPts_of_sector_off`); at the ray's end the ray's continuation is interior to the
partial sector (`mem_open_interiorPts_of_mem`). -/
theorem exists_openStep_aux {c : Fin k} {up : Bool} {ψ ρc ρ ρ' : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h' : X.Small ρ')
    (hρρ' : ρ < ρ') (hρ'c : ρ' ≤ ρc) (h : X.Small ρ) (hF : F.Valid) (hc : F.IsClean) {m j : ℕ} (hdeg : F.HasDegree v m)
    (hhorn : F.HasHornCount v j) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  classical
  have hρc : ρ ≤ ρc := hρρ'.le.trans hρ'c
  have hn2 := cfg.two_le
  have hhalf : 0 < ρ / 2 := by linarith [h.1]
  have hhalfρ' : ρ / 2 < ρ' := by linarith [h.1]
  set F₁ := F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) X.mem_dom h.1
    (openArcs_nondegenerate cfg h hρc) (openArcs_finite ρ) (open_hlc cfg h' hρρ' h hρc) with hF₁
  have hval : F₁.Valid := open_valid hF cfg h' hρρ' h hρc
  have hself : F₁.coloursAt v ⊆ F.coloursAt v := open_coloursAt_self cfg h hρc
  have hcol : ∀ z ∉ closedBall v ρ, X.G.openCol v X.col F.col up s b ψ c ρ z = F.col z := by
    intro z hz
    have hz' : z ∉ ball v ρ := fun h'' => hz (ball_subset_closedBall h'')
    have hW : z ∉ X.G.openWedge v up s b ψ ρ := fun h'' =>
      hz' (ball_subset_ball (by linarith [h.1]) (X.G.openWedge_subset_ball v up s b ψ ρ h''))
    simp only [BranchGerms.openCol, if_neg hW]
    exact mergeCol_of_not_mem h hz'
  -- the ray as a branch from `v`, inside the partial sector below `ρ'`
  have hray : ∀ t : ℝ, branchPt v ψ 0 t = v + (t : ℂ) * e ψ := fun t => by simp [branchPt]
  have hraysec : ∀ t ∈ Ioo 0 ρ', v + (t : ℂ) * e ψ ∈ X.G.sector v ρ' (BranchGerms.idx s (BranchGerms.rayPos up b)) :=
    fun t ht => (X.G.mem_sector_idx s _).mpr ⟨t, ht, ψ, cfg.ray t ⟨ht.1, ht.2.trans_le hρ'c⟩, rfl⟩
  -- the arcs of the surgery
  have hΓ₁ : ∀ z ∈ F₁.Γ, z ∈ F.Γ ∨ z ∈ sphere v (ρ / 2) ∨ ∃ t ∈ Icc 0 (ρ / 2), z = v + (t : ℂ) * e ψ := by
    rintro z ⟨hzd, hzA⟩
    obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp hzA
    rcases hB with hB | hB | rfl | rfl
    · obtain ⟨-, a', ha', hsub, -⟩ := (F.trimArcs_spec X.mem_dom h.1).1 B hB
      exact Or.inl ⟨hzd, mem_iUnion₂.mpr ⟨a', ha', hsub hzB⟩⟩
    · rcases mergeArcs_cases h hB with ⟨j', hj'⟩ | ⟨-, rfl⟩
      · exact Or.inl (germ_subset_Γ h j' (hj' hzB))
      · right; left
        rw [mem_sphere, dist_eq_norm]; exact norm_of_mem_rimArc h hzB
    · exact Or.inr (Or.inr (eq_of_mem_openRay h.1 hzB))
    · exact Or.inr (Or.inl (X.G.openRim_subset_sphere v up s b ψ h.1.le hzB))
  have hpts : ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F₁.cleanKeep.IsSite x ∧ (F₁.cleanKeep.coloursAt x).ncard ≤ 3 := by
    intro x hx hxv
    refine X.not_isSite_of_chart (M := F₁.cleanKeep) h' hhalf hhalfρ' cleanKeep_isClean rfl {(ψ, 0)} ?_ ?_ ?_
      (closedBall_subset_ball hρρ' hx) hxv ?_ ?_
    · intro g' hg'
      rw [Finset.mem_singleton] at hg'
      subst hg'
      simp
    · intro g' hg' t ht
      rw [Finset.mem_singleton] at hg'
      subst hg'
      refine ⟨fun i heq => ?_, fun g'' hg'' _ => (Finset.mem_singleton.mp hg'').symm⟩
      have hI := sector_subset_interiorPts h' _ (hraysec t ht)
      rw [← hray, show branchPt v ψ 0 t = branchPt v (X.G.β i) (X.G.κ i) t from heq] at hI
      exact hI.2 (X.hC.branchPt_mem_Γ i ⟨ht.1, ht.2.trans h'.lt_r₀⟩).2
    · intro z hz hzR hzv
      rcases hΓ₁ z (cleanKeep_Γ_subset _ hz) with h1 | h1 | ⟨t, ht, rfl⟩
      · exact Or.inr (Or.inl (X.hC.exists_branchPt_eq hzv (ball_subset_ball h'.lt_r₀.le hzR) fun hI => hI.2 h1.2))
      · exact Or.inl h1
      · refine Or.inr (Or.inr ⟨(ψ, 0), Finset.mem_singleton_self _, ?_⟩)
        rw [add_sub_cancel_left, norm_mul_e ht.1]
        exact (hray t).symm
    · -- a germ of the chart on the circle of radius `ρ/2`
      intro i hxi ε hε
      have hxΓ : x ∈ F.Γ := hxi ▸ X.hC.branchPt_mem_Γ i ⟨hhalf, hhalfρ'.trans h'.lt_r₀⟩
      by_cases hi : i ∈ BranchGerms.gapGerm s 0 b
      · -- a gap germ: its branch inside `ρ/2` is interior to the recoloured gap
        obtain ⟨m', hm1, hm2, rfl⟩ := hi
        obtain ⟨t, ht, htε⟩ := exists_branchPt_near_lt v (X.G.β (BranchGerms.idx s m')) (X.G.κ (BranchGerms.idx s m'))
          hhalf hε
        have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
        have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
        have hmono := X.G.liftDir_mono X.hord s hts
        have hne : X.G.liftDir s m' t ≠ ψ := by
          cases up
          · have h3 := (cfg.ray t htc).2
            simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at h3
            exact ne_of_gt (lt_of_lt_of_le h3 (hmono.monotone (show 1 ≤ m' by omega)))
          · have h3 := (cfg.ray t htc).1
            simp only [BranchGerms.rayPos, if_true] at h3
            exact ne_of_lt (lt_of_le_of_lt (hmono.monotone hm2) h3)
        have hnot := cfg.not_mem_openArcs h hρc ht (hmono (show 0 < m' by omega)) (hmono (show m' < b + 1 by omega)) hne
        rw [← X.G.branchPt_idx v s m' t] at hnot
        have htb : branchPt v (X.G.β (BranchGerms.idx s m')) (X.G.κ (BranchGerms.idx s m')) t ∈ ball v ρ := by
          rw [mem_ball, dist_branchPt _ ht.1.le]; linarith [ht.2]
        have hI : branchPt v (X.G.β (BranchGerms.idx s m')) (X.G.κ (BranchGerms.idx s m')) t ∈ F₁.interiorPts :=
          (mem_open_interiorPts_iff h htb).mpr hnot
        refine ⟨_, by rw [mem_ball, hxi]; exact htε, fun heq => ?_,
          Or.inr ⟨t, ⟨ht.1.le, by linarith [ht.2, h.1]⟩, rfl⟩, fun hΓ => hI.2 (cleanKeep_Γ_subset _ hΓ).2⟩
        have h3 := congrArg (fun z => dist z v) heq
        simp only [hxi, dist_branchPt _ ht.1.le, dist_branchPt _ hhalf.le] at h3
        linarith [ht.2]
      · by_cases hir : i = BranchGerms.idx s (BranchGerms.rayPos up b)
        · -- the sector after the germ is the partial sector: the sector before it is neither that nor a gap sector
          obtain ⟨p, hp⟩ := exists_next_eq (X := X) i
          have hpi : p ≠ i := fun h'' => BranchGerms.next_ne_self hn2 p (by rw [hp, h''])
          have hpg : p ∉ BranchGerms.gapSec s 0 b := by
            rintro ⟨m', h1, h2, rfl⟩
            exact hi ⟨m' + 1, by omega, by omega, by rw [← BranchGerms.next_idx, hp]⟩
          obtain ⟨w, hw, hwρ, hwx⟩ := X.exists_rim_mem_sector_before h' hhalf hhalfρ' p hε
          rw [hp] at hwx
          have hwρ' : w ∈ X.G.sector v ρ p := mem_sector_of_lt hw (by rw [← dist_eq_norm, hwρ]; linarith [h.1])
          have hwI₁ : w ∈ F₁.interiorPts := mem_open_interiorPts_of_sector_off cfg h hρc (hir ▸ hpi) hpg hwρ'
          exact ⟨w, by rw [mem_ball, hxi]; exact hwx,
            fun hwx' => (sector_subset_interiorPts h' p hw).2 (hwx' ▸ hxΓ).2, Or.inl hwρ,
            fun hΓ => hwI₁.2 (cleanKeep_Γ_subset _ hΓ).2⟩
        · -- the sector after the germ is neither the partial sector nor a gap sector
          have hig : i ∉ BranchGerms.gapSec s 0 b := fun ⟨m', h1, h2, he⟩ => hi ⟨m', h1, h2.le, he⟩
          obtain ⟨w, hw, hwρ, hwx⟩ := X.exists_rim_mem_sector h' hhalf hhalfρ' i hε
          have hwρ' : w ∈ X.G.sector v ρ i := mem_sector_of_lt hw (by rw [← dist_eq_norm, hwρ]; linarith [h.1])
          have hwI₁ : w ∈ F₁.interiorPts := mem_open_interiorPts_of_sector_off cfg h hρc hir hig hwρ'
          exact ⟨w, by rw [mem_ball, hxi]; exact hwx,
            fun hwx' => (sector_subset_interiorPts h' i hw).2 (hwx' ▸ hxΓ).2, Or.inl hwρ,
            fun hΓ => hwI₁.2 (cleanKeep_Γ_subset _ hΓ).2⟩
    · -- the ray's end: past `ρ/2` the ray's line is interior to the partial sector
      intro g' hg' hxg ε hε
      rw [Finset.mem_singleton] at hg'
      subst hg'
      obtain ⟨t, ht, htε⟩ := exists_branchPt_near_gt v ψ 0 hhalfρ' hε
      have htR : t ∈ Ioo 0 ρ' := ⟨hhalf.trans ht.1, ht.2⟩
      have hwI : branchPt v ψ 0 t ∈ F.interiorPts := by
        rw [hray]; exact sector_subset_interiorPts h' _ (hraysec t htR)
      have hd : ‖branchPt v ψ 0 t - v‖ = t := norm_branchPt_sub v _ _ htR.1.le
      have hI₁ : branchPt v ψ 0 t ∈ F₁.interiorPts := mem_open_interiorPts_of_mem h hwI (by rw [hd]; exact ht.1)
      refine ⟨_, by rw [mem_ball, hxg]; exact htε, fun heq => ?_, Or.inr ⟨t, ⟨htR.1.le, htR.2.le⟩, rfl⟩,
        fun hΓ => hI₁.2 (cleanKeep_Γ_subset _ hΓ).2⟩
      have h3 := congrArg (fun z => ‖z - v‖) heq
      simp only [hxg, hd, norm_branchPt_sub v ψ 0 hhalf.le] at h3
      linarith [ht.1]
  -- the count: OPEN's own, and cleaning raises neither number
  have hdh : ∃ m₁ j₁, m₁ ≤ m ∧ j₁ < j ∧ F₁.HasDegree v m₁ ∧ F₁.HasHornCount v j₁ :=
    open_degree_horns cfg h' hρρ' h hρc hdeg hhorn
  obtain ⟨m₁, j₁, hm₁, hj₁, hdeg₁, hhorn₁⟩ := hdh
  exact surgery_step hc (openArcs_subset_closedBall h) hcol hval (open_ringArcsWithin h) hself hpts
    (fun m' j' hm' hj' => by
      obtain ⟨h1, h2⟩ := cleanKeep_pot_le (M := F₁) X.mem_dom hdeg₁ hhorn₁ hm' hj'
      omega)

end Near

/-- test: OPEN's case -/
theorem exists_openStep' (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : F.HasSectors v c 1) (hD : (interior (F.allowedCone v c)).Nonempty) {m j : ℕ}
    (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  classical
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨up, s, b, ψ, ρc, cfg⟩ := Near.exists_openConfig hF hv X hH h1 hD
  obtain ⟨ρ₀, h₀⟩ := X.eventually_small.exists
  have h' : X.Small (min ρ₀ ρc) := h₀.mono (lt_min h₀.1 cfg.hρc) (min_le_left _ _)
  have hρ0 : 0 < min (min ρ₀ ρc / 2) (δ / 2) := lt_min (by linarith [h'.1]) (by linarith)
  have hρρ' : min (min ρ₀ ρc / 2) (δ / 2) < min ρ₀ ρc := (min_le_left _ _).trans_lt (by linarith [h'.1])
  exact ⟨_, hρ0, (min_le_right _ _).trans_lt (by linarith),
    Near.exists_openStep_aux cfg h' hρρ' (min_le_right _ _) (h'.mono hρ0 hρρ'.le) hF hc hdeg hhorn⟩

end ArcMap

end HadwigerNelson.Plane
