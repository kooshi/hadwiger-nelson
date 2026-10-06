import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Joining a component across one of its open set's points**: if `A` lies in a component of the open set `W`, a point `b` of `W`
is in the closures of `A` and of a preconnected `B ⊆ W`, then `B` lies in that component (a small ball about `b` meets both). -/
theorem _root_.HadwigerNelson.Plane.subset_connectedComponentIn_of_mem_closure {W : Set ℂ} (hW : IsOpen W) {x₀ b : ℂ}
    {A B : Set ℂ} (hA : A ⊆ connectedComponentIn W x₀) (hbA : b ∈ closure A) (hbW : b ∈ W) (hB : IsPreconnected B)
    (hBW : B ⊆ W) (hbB : b ∈ closure B) : B ⊆ connectedComponentIn W x₀ := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hW b hbW
  obtain ⟨y, hy, hyb⟩ := Metric.mem_closure_iff.mp hbA ε hε
  have hyS := hA hy
  have hballS : ball b ε ⊆ connectedComponentIn W x₀ := by
    rw [connectedComponentIn_eq hyS]
    exact (convex_ball b ε).isPreconnected.subset_connectedComponentIn (by rw [mem_ball, dist_comm]; exact hyb) hball
  obtain ⟨y', hy', hy'b⟩ := Metric.mem_closure_iff.mp hbB ε hε
  have hy'S := hballS (by rw [mem_ball, dist_comm]; exact hy'b)
  rw [connectedComponentIn_eq hy'S]
  exact hB.subset_connectedComponentIn hy' hBW

/-- **A point of the domain with one colour near it is interior to the cleaned map.** -/
theorem mem_cleanKeep_interiorPts_of_const {M : ArcMap k} {w : ℂ} (hwd : w ∈ M.dom) {U : Set ℂ} (hU : IsOpen U) (hw : w ∈ U)
    {a : Fin k} (h : ∀ y ∈ U, y ∈ M.interiorPts → M.col y = a) : w ∈ M.cleanKeep.interiorPts := by
  rw [cleanKeep_interiorPts]
  exact ⟨hwd, fun hE => not_mem_cleanKeep_Γ_of_const hU hw h (by rw [cleanKeep_Γ]; exact hE)⟩

/-- **The vertex step from a surgery** (the assembly the four cases share): a valid surgery at `v` of radius `ρ` that creates no
unit arc and adds no colour at `v`, whose cleaned map has no site and at most three colours at the other points of the closed disc
and a lower potential at `v`, gives the step — `cleanKeep_valid`, `cleanKeep_isClean`, `surgery_cleanKeep_localStep`, and
`IsModification`'s colour clause read off the disc by locality, at `v` by the surgery's clause, elsewhere in the disc by the bound
three. -/
theorem surgery_step (hc : F.IsClean) {v : ℂ} {ρ : ℝ} {A : Set Arc} {col' : ℂ → Fin k} {hv : v ∈ F.dom} {hρ : 0 < ρ}
    {hA : ∀ a ∈ A, a.Nondegenerate} {hAf : A.Finite}
    {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}
    (hAin : ∀ a ∈ A, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z)
    (hval : (F.surgery v ρ A col' hv hρ hA hAf hlc).Valid)
    (hring : (F.surgery v ρ A col' hv hρ hA hAf hlc).RingArcsWithin F)
    (hself : (F.surgery v ρ A col' hv hρ hA hAf hlc).coloursAt v ⊆ F.coloursAt v)
    (hpts : ∀ x ∈ closedBall v ρ, x ≠ v → ¬ (F.surgery v ρ A col' hv hρ hA hAf hlc).cleanKeep.IsSite x ∧
      ((F.surgery v ρ A col' hv hρ hA hAf hlc).cleanKeep.coloursAt x).ncard ≤ 3)
    {m j : ℕ} (hpot : ∀ m' j', (F.surgery v ρ A col' hv hρ hA hAf hlc).cleanKeep.HasDegree v m' →
      (F.surgery v ρ A col' hv hρ hA hAf hlc).cleanKeep.HasHornCount v j' → m' + j' < m + j) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  set F₁ := F.surgery v ρ A col' hv hρ hA hAf hlc with hF₁
  have hvd : v ∈ F₁.cleanKeep.dom := hv
  obtain ⟨m', -, hm'⟩ := exists_hasDegree_of_mem_dom hvd
  obtain ⟨j', hj'⟩ := exists_hasHornCount hvd
  refine ⟨F₁.cleanKeep, cleanKeep_valid hval, cleanKeep_isClean, surgery_cleanKeep_localStep hc hAin hcol,
    ⟨rfl, fun p x hp => hring p x (cleanKeep_isModification.ringArcsWithin p x hp), fun x h4 => ?_⟩,
    ⟨m', j', hpot m' j' hm' hj', hm', hj'⟩, by rw [coloursAt_cleanKeep]; exact hself, fun x hx hxv => (hpts x hx hxv).1⟩
  rw [coloursAt_cleanKeep]
  by_cases hxb : x ∈ closedBall v ρ
  · by_cases hxv : x = v
    · rw [hxv]; exact hself
    · have := (hpts x hxb hxv).2
      rw [coloursAt_cleanKeep] at this h4
      omega
  · exact (coloursAt_eq_of_agreesOn (W := (closedBall v ρ)ᶜ) (by rw [compl_compl]; exact surgery_agreesOff hAin hcol)
      isClosed_closedBall.isOpen_compl hxb).subset

namespace Near

variable {v : ℂ}

/-- **The vertex step from a `Near.move`** (`surgery_step` for MERGE-RAY's and SHAVE's construction). -/
theorem move_step (hc : F.IsClean) {X : F.Near v} {ρ : ℝ} {h : X.Small ρ} {K : Set (Fin X.n)} {E : Set Arc}
    {col' : ℂ → Fin k} {hE : ∀ a ∈ E, a.Nondegenerate} {hEf : E.Finite}
    {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ K E, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}
    (hEin : ∀ a ∈ E, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z)
    (hEu : ∀ a ∈ E, ¬ a.IsUnitArc) (hval : (X.move h K E col' hE hEf hlc).Valid)
    (hself : (X.move h K E col' hE hEf hlc).coloursAt v ⊆ F.coloursAt v)
    (hpts : ∀ x ∈ closedBall v ρ, x ≠ v → ¬ (X.move h K E col' hE hEf hlc).cleanKeep.IsSite x ∧
      ((X.move h K E col' hE hEf hlc).cleanKeep.coloursAt x).ncard ≤ 3)
    {m j : ℕ} (hpot : ∀ m' j', (X.move h K E col' hE hEf hlc).cleanKeep.HasDegree v m' →
      (X.move h K E col' hE hEf hlc).cleanKeep.HasHornCount v j' → m' + j' < m + j) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x :=
  surgery_step (hv := X.mem_dom) (hρ := h.1) (hA := newArcs_nondegenerate h hE) (hAf := newArcs_finite hEf) (hlc := hlc) hc
    (newArcs_subset_closedBall h hEin) hcol hval
    (move_ringArcsWithin (h := h) (K := K) (col' := col') (hE := hE) (hEf := hEf) (hlc := hlc) hEu) hself hpts hpot

/-- **The vertex step from SHAVE's recolouring** (FS110-N4-SHAVE's construction, cleaned): `Near.move` with every germ kept, the
arc of curvature `σ` added and the colouring `shaveCol`, then `cleanKeep`. The count is `pot_lt_of_sectors` with the shaved horn:
a sector of the cleaned map holds an interior point of the move; off the horn its chart sector lies in it; in the horn above the
`σ`-arc, the upper piece, the points of the germ above it — interior after cleaning, the flank's colour `g` on both sides — and the
flank sector do; below, the same with `h`. The rim: the sector after a germ other than the horn's lower one keeps its colour, and so
does the sector before that one; the `σ`-arc ends at the rim, its continuation interior to the horn (`not_isSite_of_chart`). -/
theorem exists_shaveStep_aux (X : F.Near v) {ρ R : ℝ} (hs : X.Small ρ) (hRs : X.Small R) (hρR : ρ < R) (hF : F.Valid)
    (hc : F.IsClean) {α κ₁ κ₂ σ : ℝ} {g h : Fin k} {i₀ p : Fin X.n} (hp : BranchGerms.next p = i₀)
    (hβ : e (X.G.β i₀) = e α) (hnβ : X.G.nextβ i₀ = X.G.β i₀) (hκ : X.G.κ i₀ = κ₁) (hnκ : X.G.nextκ i₀ = κ₂)
    (hsec : ∀ r ∈ Ioc 0 X.r₀, X.G.sector v r i₀ = hornSet v α κ₁ κ₂ r)
    (hcg : X.col (BranchGerms.next i₀) = g) (hch : X.col p = h) (h1 : -1 ≤ κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ ≤ 1)
    (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    (hcl : ∀ z ∈ hornSet v α κ₁ κ₂ ρ, (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z))
    {m j : ℕ} (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  classical
  have hn0 : 0 < X.n := i₀.pos
  have hn2 : 2 ≤ X.n := X.two_le_of_isClean hc hn0
  have hσ : |σ| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
  have hκ1 : |κ₁| ≤ 1 := abs_le.mpr ⟨h1, by linarith⟩
  have hκ2 : |κ₂| ≤ 1 := abs_le.mpr ⟨by linarith, h2⟩
  have hσρ : |σ| * ρ ≤ 2 := by nlinarith [hs.2.2.2, abs_nonneg σ, hs.1]
  have hE : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.Nondegenerate := shaveArcs_nondegenerate hs.1
  have hEf := shaveArcs_finite v α κ₁ κ₂ σ ρ
  have hEin : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.carrier ⊆ closedBall v ρ := shaveArcs_subset_closedBall hs.1.le hσρ
  have hEu : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, ¬ a.IsUnitArc := shaveArcs_not_isUnitArc h1 h2
  have hcol : ∀ z ∉ closedBall v ρ, F.shaveCol v α κ₁ κ₂ σ ρ g h z = F.col z := fun z hz =>
    shaveCol_of_not_mem fun hz' => hz (ball_subset_closedBall hz'.1)
  have hlc := X.shave_hlc (g := g) (h := h) hs hsec hσ hσ₁ hσ₂
  have hK : (univ : Set (Fin X.n)).Nonempty := ⟨⟨0, hn0⟩, trivial⟩
  set F₁ := X.move hs univ (shaveArcs v α κ₁ κ₂ σ ρ) (F.shaveCol v α κ₁ κ₂ σ ρ g h) hE hEf hlc with hF₁
  have hint : ∀ z ∈ ball v ρ, z ∈ F₁.interiorPts ↔
      z ∈ F.interiorPts ∧ (z ∈ hornSet v α κ₁ κ₂ ρ → tanHeight σ (frameX v α z) (frameY v α z) ≠ 0) :=
    fun z hz => shave_mem_interiorPts_iff hn0 hσ hσ₁ hσ₂ hz
  have hHρ := hsec ρ hs.mem_Ioc
  have hHR := hsec R hRs.mem_Ioc
  have hpi : p ≠ i₀ := fun h' => BranchGerms.next_ne_self hn2 p (by rw [hp, h'])
  have hni : BranchGerms.next i₀ ≠ i₀ := BranchGerms.next_ne_self hn2 i₀
  have hval : F₁.Valid := by
    refine move_valid hF hEin hcol fun z hz hzI => ?_
    obtain ⟨hzF, -⟩ := (hint z hz).mp hzI
    by_cases hzt : z ∈ hornSet v α κ₁ κ₂ ρ
    · by_cases hT : TanAbove v α σ z
      · rw [shaveCol_of_above hzt hT]; exact (hcl z hzt).1 hT
      · rw [shaveCol_of_not_above hzt hT]; exact (hcl z hzt).2 hT
    · rw [shaveCol_of_not_mem hzt]; exact isClear_col hF hzF
  have hself : F₁.coloursAt v ⊆ F.coloursAt v := by
    refine move_coloursAt_self fun z hz hzI => ?_
    by_cases hzt : z ∈ hornSet v α κ₁ κ₂ ρ
    · left
      rcases shaveCol_mem (F := F) (σ := σ) (g := g) (h := h) hzt with h' | h'
      · rw [h', ← hcg]; exact closure_mono (X.hcol₀ _) (X.hC.mem_closure_sector X.hs₀ _)
      · rw [h', ← hch]; exact closure_mono (X.hcol₀ _) (X.hC.mem_closure_sector X.hs₀ _)
    · right
      exact ⟨((hint z hz).mp hzI).1, shaveCol_of_not_mem hzt⟩
  -- a sector other than the horn's keeps its colour
  have hkeep : ∀ i, i ≠ i₀ → ∀ z ∈ X.G.sector v ρ i, F.shaveCol v α κ₁ κ₂ σ ρ g h z = X.col i := by
    intro i hi z hz
    have hzn : z ∉ hornSet v α κ₁ κ₂ ρ := fun hzt => by
      rw [← hHρ] at hzt
      exact disjoint_left.mp (X.hC.disjoint ρ hs.mem_Ioc i i₀ hi) hz hzt
    rw [shaveCol_of_not_mem hzn]
    have := (X.hcol i ρ hs.mem_Ioc hz).2
    simpa using this
  have hΓi : ∀ (i : Fin X.n) {t : ℝ}, t ∈ Ioo 0 R → branchPt v (X.G.β i) (X.G.κ i) t ∈ F.Γ := fun i t ht =>
    X.hC.branchPt_mem_Γ i ⟨ht.1, ht.2.trans hRs.lt_r₀⟩
  -- the points of the disc other than `v`
  set 𝒠 : Finset (ℝ × ℝ) := if κ₁ < σ ∧ σ < κ₂ then {(α, σ)} else ∅ with h𝒠
  have h𝒠mem : ∀ g' ∈ 𝒠, g' = (α, σ) ∧ κ₁ < σ ∧ σ < κ₂ := by
    intro g' hg'
    rw [h𝒠] at hg'
    split_ifs at hg' with hc'
    · exact ⟨Finset.mem_singleton.mp hg', hc'⟩
    · simp at hg'
  have hσR : |σ| * R < 2 := by nlinarith [hRs.2.2.2, abs_nonneg σ, hRs.1]
  have hσmem : κ₁ < σ → σ < κ₂ → ∀ t ∈ Ioo 0 R, branchPt v α σ t ∈ X.G.sector v R i₀ := fun h1' h2' t ht => by
    rw [hHR]
    exact branchPt_mem_hornSet v α h1' h2' ht.1 ht.2 (by nlinarith [abs_nonneg σ, hRs.2.2.2, ht.1, ht.2])
  have hpts : ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F₁.cleanKeep.IsSite x ∧ (F₁.cleanKeep.coloursAt x).ncard ≤ 3 := by
    intro x hx hxv
    refine X.not_isSite_of_chart (M := F₁.cleanKeep) hRs hs.1 hρR cleanKeep_isClean rfl 𝒠 ?_ ?_ ?_
      (closedBall_subset_ball hρR hx) hxv ?_ ?_
    · intro g' hg'
      obtain ⟨rfl, -, -⟩ := h𝒠mem g' hg'
      exact hσR
    · intro g' hg' t ht
      obtain ⟨rfl, h1', h2'⟩ := h𝒠mem g' hg'
      refine ⟨fun i heq => ?_, fun g'' hg'' _ => ((h𝒠mem g'' hg'').1).symm⟩
      have hI := sector_subset_interiorPts hRs i₀ (hσmem h1' h2' t ht)
      rw [show branchPt v α σ t = branchPt v (X.G.β i) (X.G.κ i) t from heq] at hI
      exact hI.2 (hΓi i ht).2
    · intro z hz hzR hzv
      rcases move_Γ_cases hRs hK hEin (cleanKeep_Γ_subset _ hz) hzR hzv with h1' | h1' | ⟨-, h1'⟩
      · exact Or.inl h1'
      · exact Or.inr (Or.inl h1')
      · obtain ⟨h3, h4, h5⟩ := mem_shaveArcs_carrier.mp h1'
        rw [carrier_germArc v α hs.1.le hσρ] at h5
        obtain ⟨s, hs', rfl⟩ := h5
        refine Or.inr (Or.inr ⟨(α, σ), by rw [h𝒠, if_pos ⟨h3, h4⟩]; exact Finset.mem_singleton_self _, ?_⟩)
        rw [norm_branchPt_sub v _ _ hs'.1]
    · -- a germ of the chart: a sector beside it keeps its colour across the rim
      intro i hxi ε hε
      have hxΓ : x ∈ F.Γ := hxi ▸ hΓi i ⟨hs.1, hρR⟩
      by_cases hi : i = i₀
      · obtain ⟨w, hw, hwρ, hwx⟩ := X.exists_rim_mem_sector_before hRs hs.1 hρR p hε
        rw [hp, ← hi] at hwx
        exact ⟨w, by rw [mem_ball, hxi]; exact hwx, fun hwx' => (sector_subset_interiorPts hRs p hw).2 (hwx' ▸ hxΓ).2,
          Or.inl hwρ, move_not_mem_cleanKeep_Γ hRs hcol (i := p) (fun z hz => (hkeep p hpi z hz).trans rfl) hw⟩
      · obtain ⟨w, hw, hwρ, hwx⟩ := X.exists_rim_mem_sector hRs hs.1 hρR i hε
        exact ⟨w, by rw [mem_ball, hxi]; exact hwx, fun hwx' => (sector_subset_interiorPts hRs i hw).2 (hwx' ▸ hxΓ).2,
          Or.inl hwρ, move_not_mem_cleanKeep_Γ hRs hcol (i := i) (hkeep i hi) hw⟩
    · -- the `σ`-arc's end on the rim: past the rim its curve is interior to the horn
      intro g' hg' hxg ε hε
      obtain ⟨rfl, h1', h2'⟩ := h𝒠mem g' hg'
      obtain ⟨t, ht, htε⟩ := exists_branchPt_near_gt v α σ hρR hε
      have htR : t ∈ Ioo 0 R := ⟨hs.1.trans ht.1, ht.2⟩
      have hI : branchPt v α σ t ∈ F.interiorPts := sector_subset_interiorPts hRs i₀ (hσmem h1' h2' t htR)
      have hd : dist (branchPt v α σ t) v = t := by rw [dist_eq_norm, norm_branchPt_sub v _ _ htR.1.le]
      have htc : branchPt v α σ t ∉ closedBall v ρ := by rw [mem_closedBall, hd, not_le]; exact ht.1
      refine ⟨_, by rw [mem_ball, hxg]; exact htε, fun heq => ?_, Or.inr ⟨t, ⟨htR.1.le, htR.2.le⟩, rfl⟩, fun hΓ => ?_⟩
      · have h3 := congrArg (fun z => dist z v) heq
        simp only [hxg, hd, dist_eq_norm, norm_branchPt_sub v α σ hs.1.le] at h3
        linarith [ht.1]
      · exact ((mem_move_interiorPts_iff_of_not_mem hEin htc).mpr hI).2 (cleanKeep_Γ_subset _ hΓ).2
  -- the count: the germs beside a piece of the horn that takes its flank's colour become interior
  have hcont : Continuous fun z => tanHeight σ (frameX v α z) (frameY v α z) := by
    unfold tanHeight frameX frameY; fun_prop
  have hupper : σ < κ₂ → ∀ s ∈ Ioo 0 ρ, branchPt v α κ₂ s ∈ F₁.cleanKeep.interiorPts := by
    intro hlt s hs'
    have hbeq : branchPt v (X.G.β (BranchGerms.next i₀)) (X.G.κ (BranchGerms.next i₀)) s = branchPt v α κ₂ s := by
      rw [← BranchGerms.nextκ_eq, hnκ]
      exact branchPt_congr_dir (by rw [← BranchGerms.e_nextβ, hnβ, hβ]) κ₂ s
    obtain ⟨ε, hε, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj ⟨hs.1, hs.2.1.le⟩ (p := i₀) hs'
    rw [hbeq] at hball
    have hbT : 0 < tanHeight σ (frameX v α (branchPt v α κ₂ s)) (frameY v α (branchPt v α κ₂ s)) := by
      rw [tanHeight_branchPt v α κ₂ σ (by nlinarith [abs_nonneg κ₂, hs.2.2.2, hs'.1, hs'.2]) hs'.1.le]
      have := hs'.1
      have h3 : 0 < κ₂ - σ := by linarith
      positivity
    have hbd : branchPt v α κ₂ s ∈ F₁.dom :=
      X.hG.subdom (by rw [mem_ball, dist_eq_norm, norm_branchPt_sub v _ _ hs'.1.le]; exact hs'.2.trans hs.2.2.1)
    refine mem_cleanKeep_interiorPts_of_const hbd
      (U := ball (branchPt v α κ₂ s) ε ∩ {z | 0 < tanHeight σ (frameX v α z) (frameY v α z)})
      (isOpen_ball.inter (isOpen_lt continuous_const hcont)) ⟨mem_ball_self hε, hbT⟩ (a := g) ?_
    rintro y ⟨hyb, hyT⟩ hyI
    rcases hball hyb with (hy | hy) | hy
    · rw [hHρ] at hy
      exact shaveCol_of_above hy hyT
    · exact (hkeep _ hni y hy).trans hcg
    · obtain ⟨t, ht, rfl⟩ := hy
      exfalso
      have hyb' : branchPt v (X.G.β (BranchGerms.next i₀)) (X.G.κ (BranchGerms.next i₀)) t ∈ ball v ρ := by
        rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ ht.1.le]; exact ht.2
      exact ((hint _ hyb').mp hyI).1.2 (hΓi _ ⟨ht.1, ht.2.trans hρR⟩).2
  have hlower : κ₁ < σ → ∀ s ∈ Ioo 0 ρ, branchPt v α κ₁ s ∈ F₁.cleanKeep.interiorPts := by
    intro hlt s hs'
    have hbeq : branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) s = branchPt v α κ₁ s := by
      rw [hp, hκ]
      exact branchPt_congr_dir hβ κ₁ s
    obtain ⟨ε, hε, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj ⟨hs.1, hs.2.1.le⟩ (p := p) hs'
    rw [hbeq, hp] at hball
    have hbT : tanHeight σ (frameX v α (branchPt v α κ₁ s)) (frameY v α (branchPt v α κ₁ s)) < 0 := by
      rw [tanHeight_branchPt v α κ₁ σ (by nlinarith [abs_nonneg κ₁, hs.2.2.2, hs'.1, hs'.2]) hs'.1.le]
      have := hs'.1
      have h3 : κ₁ - σ < 0 := by linarith
      have h4 : 0 < s ^ 2 := by positivity
      nlinarith
    have hbd : branchPt v α κ₁ s ∈ F₁.dom :=
      X.hG.subdom (by rw [mem_ball, dist_eq_norm, norm_branchPt_sub v _ _ hs'.1.le]; exact hs'.2.trans hs.2.2.1)
    refine mem_cleanKeep_interiorPts_of_const hbd
      (U := ball (branchPt v α κ₁ s) ε ∩ {z | tanHeight σ (frameX v α z) (frameY v α z) < 0})
      (isOpen_ball.inter (isOpen_lt hcont continuous_const)) ⟨mem_ball_self hε, hbT⟩ (a := h) ?_
    rintro y ⟨hyb, hyT⟩ hyI
    rcases hball hyb with (hy | hy) | hy
    · exact (hkeep _ hpi y hy).trans hch
    · rw [hHρ] at hy
      exact shaveCol_of_not_above hy (fun h' => by unfold TanAbove at h'; exact lt_asymm h' hyT)
    · obtain ⟨t, ht, rfl⟩ := hy
      exfalso
      have hyb' : branchPt v (X.G.β i₀) (X.G.κ i₀) t ∈ ball v ρ := by
        rw [mem_ball, dist_eq_norm, norm_branchPt_sub _ _ _ ht.1.le]; exact ht.2
      exact ((hint _ hyb').mp hyI).1.2 (hΓi _ ⟨ht.1, ht.2.trans hρR⟩).2
  have hcount : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∃ H, F.IsSector v r H ∧
      ∀ S₂, F₁.cleanKeep.IsSector v r S₂ → ∃ S₁, F.IsSector v r S₁ ∧ S₁ ≠ H ∧ S₁ ⊆ S₂ := by
    filter_upwards [Ioo_mem_nhdsGT hs.1] with r hr
    have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr.1, (hr.2.trans hs.lt_r₀).le⟩
    have hrs : r ≤ X.s₀ := (hr.2.trans hs.2.1).le
    have hsecS : ∀ i, F.IsSector v r (X.G.sector v r i) := fun i => (X.hC.isSector_iff hn0 hr₀).mpr ⟨i, rfl⟩
    have hne : ∀ i, i ≠ i₀ → X.G.sector v r i ≠ X.G.sector v r i₀ := fun i hi heq => by
      have hd := X.hC.disjoint r hr₀ i i₀ hi
      rw [heq] at hd
      obtain ⟨w, hw⟩ := X.hC.sector_nonempty hr₀ i₀
      exact disjoint_left.mp hd hw hw
    refine ⟨X.G.sector v r i₀, hsecS i₀, ?_⟩
    rintro S₂ ⟨x₀, hx₀, rfl, -⟩
    set W := F₁.cleanKeep.interiorPts ∩ ball v r with hW
    have hWo : IsOpen W := F₁.cleanKeep.isOpen_interiorPts.inter isOpen_ball
    have hsecW : ∀ i, i ≠ i₀ → X.G.sector v r i ⊆ W := fun i hi y hy => by
      have hyb : y ∈ ball v r := X.G.sector_subset_ball i hy
      refine ⟨F₁.interiorPts_subset_cleanKeep ((hint y (ball_subset_ball hr.2.le hyb)).mpr
        ⟨X.hC.sector_subset_interiorPts hn0 hr₀ i hy, fun hyt => ?_⟩), hyb⟩
      rw [← hHρ] at hyt
      exact absurd hyt (disjoint_left.mp (X.hC.disjoint ρ hs.mem_Ioc i i₀ hi) (sector_mono hr.2.le i hy))
    have hhornI : hornSet v α κ₁ κ₂ r ⊆ F.interiorPts := by
      rw [← hsec r hr₀]; exact X.hC.sector_subset_interiorPts hn0 hr₀ i₀
    obtain ⟨z, hz, hzI⟩ := mem_closure_iff.mp (F₁.dense_interiorPts hx₀.1.1) _ hWo.connectedComponentIn
      (mem_connectedComponentIn hx₀)
    have hzb : z ∈ ball v r := (connectedComponentIn_subset _ _ hz).2
    obtain ⟨hzF, hzT⟩ := (hint z (ball_subset_ball hr.2.le hzb)).mp hzI
    have hz' : z ∈ ⋃ i, X.G.sector v r i := by rw [← X.hC.cover r hr₀ hn0]; exact ⟨hzb, hzF⟩
    obtain ⟨i, hi⟩ := mem_iUnion.mp hz'
    by_cases hii : i = i₀
    swap
    · refine ⟨X.G.sector v r i, hsecS i, hne i hii, ?_⟩
      rw [connectedComponentIn_eq hz]
      exact (X.hC.isPreconnected r hr₀ i).subset_connectedComponentIn hi (hsecW i hii)
    rw [hii, hsec r hr₀] at hi
    have hT := hzT (hornSet_mono_radius hr.2.le hi)
    have hκr : ∀ κ : ℝ, |κ| ≤ 1 → |κ| * r < 2 := fun κ hκ => by nlinarith [abs_nonneg κ, hr.1, hr.2, hs.2.2.2]
    have hhalf : r / 2 ∈ Ioo 0 r := ⟨by linarith [hr.1], by linarith [hr.1]⟩
    have hhalfρ : r / 2 ∈ Ioo 0 ρ := ⟨hhalf.1, hhalf.2.trans hr.2⟩
    have hbb : ∀ κ : ℝ, branchPt v α κ (r / 2) ∈ ball v r := fun κ => by
      rw [mem_ball, dist_eq_norm, norm_branchPt_sub v _ _ hhalf.1.le]; exact hhalf.2
    have hκh : ∀ κ : ℝ, |κ| ≤ 1 → |κ| * (r / 2) < 2 := fun κ hκ => by nlinarith [abs_nonneg κ, hr.1, hr.2, hs.2.2.2]
    rcases lt_or_gt_of_ne hT with hlt | hgt
    · -- below the `σ`-arc: the lower piece, the horn's lower germ, the sector before it
      have hσ₁' : κ₁ < σ := lt_of_le_of_ne hσ₁ fun h' => by
        have := hi.2.2.1; unfold TanAbove at this; rw [h'] at this; linarith
      have hL : hornSet v α κ₁ σ r ⊆ W := fun y hy =>
        ⟨F₁.interiorPts_subset_cleanKeep ((hint y (ball_subset_ball hr.2.le hy.1)).mpr
          ⟨hhornI (hornSet_mono le_rfl hσ₂ hy), fun _ => ne_of_lt hy.2.2.2⟩), hy.1⟩
      have hLS : hornSet v α κ₁ σ r ⊆ connectedComponentIn W x₀ := by
        rw [connectedComponentIn_eq hz]
        exact (isPreconnected_hornSet v α hσ₁' (hκr κ₁ hκ1) (hκr σ hσ)).subset_connectedComponentIn
          ⟨hi.1, hi.2.1, hi.2.2.1, hlt⟩ hL
      have hbp : branchPt v α κ₁ (r / 2) ∈ closure (X.G.sector v r p) := by
        have h3 := IsSectorChart.branchPt_mem_closure_sector_before (v := v) X.hord hrs p hhalf
        rw [hp, hκ, branchPt_congr_dir hβ] at h3
        exact h3
      exact ⟨X.G.sector v r p, hsecS p, hne p hpi, subset_connectedComponentIn_of_mem_closure hWo hLS
        (branchPt_mem_closure_hornSet_lower v α hσ₁' hhalf.1 hhalf.2 (hκh κ₁ hκ1))
        ⟨hlower hσ₁' _ hhalfρ, hbb κ₁⟩ (X.hC.isPreconnected r hr₀ p) (hsecW p hpi) hbp⟩
    · -- above the `σ`-arc: the upper piece, the horn's upper germ, the sector after it
      have hσ₂' : σ < κ₂ := lt_of_le_of_ne hσ₂ fun h' => by
        have := hi.2.2.2; unfold TanBelow at this; rw [← h'] at this; linarith
      have hU : hornSet v α σ κ₂ r ⊆ W := fun y hy =>
        ⟨F₁.interiorPts_subset_cleanKeep ((hint y (ball_subset_ball hr.2.le hy.1)).mpr
          ⟨hhornI (hornSet_mono hσ₁ le_rfl hy), fun _ => ne_of_gt hy.2.2.1⟩), hy.1⟩
      have hUS : hornSet v α σ κ₂ r ⊆ connectedComponentIn W x₀ := by
        rw [connectedComponentIn_eq hz]
        exact (isPreconnected_hornSet v α hσ₂' (hκr σ hσ) (hκr κ₂ hκ2)).subset_connectedComponentIn
          ⟨hi.1, hi.2.1, hgt, hi.2.2.2⟩ hU
      have hbq : branchPt v α κ₂ (r / 2) ∈ closure (X.G.sector v r (BranchGerms.next i₀)) := by
        have h3 := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord hrs (BranchGerms.next i₀) hhalf
        rw [← BranchGerms.nextκ_eq, hnκ, branchPt_congr_dir (by rw [← BranchGerms.e_nextβ, hnβ, hβ] :
          e (X.G.β (BranchGerms.next i₀)) = e α)] at h3
        exact h3
      exact ⟨X.G.sector v r (BranchGerms.next i₀), hsecS _, hne _ hni, subset_connectedComponentIn_of_mem_closure hWo hUS
        (branchPt_mem_closure_hornSet_upper v α hσ₂' hhalf.1 hhalf.2 (hκh κ₂ hκ2))
        ⟨hupper hσ₂' _ hhalfρ, hbb κ₂⟩ (X.hC.isPreconnected r hr₀ _) (hsecW _ hni) hbq⟩
  exact move_step hc hEin hcol hEu hval hself hpts
    (fun m' j' hm' hj' => pot_lt_of_sectors X.mem_dom hcount hdeg hhorn hm' hj')

end Near

/-- test: SHAVE's case -/
theorem exists_shaveStep' (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k} {n : ℕ}
    (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z))
    {m j : ℕ} (hdeg : F.HasDegree v m) (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.IsClean ∧ LocalStep F F' (closedBall v ρ) ∧ F.IsModification F' ∧
      (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ closedBall v ρ, x ≠ v → ¬ F'.IsSite x := by
  have _ := hn
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨i₀, hβ, hnβ, hκ, hnκ, -, hsec⟩ := X.horn_index hH
  obtain ⟨p, hp⟩ := Near.exists_next_eq (X := X) i₀
  have hcg : X.col (BranchGerms.next i₀) = g :=
    IsSectorChart.col_eq_of_flankAbove X.hC X.hs₀ X.hord X.hcol₀ (by rw [← BranchGerms.e_nextβ, hnβ, hβ])
      (by rw [← BranchGerms.nextκ_eq, hnκ]) hg
  have hch : X.col p = h :=
    IsSectorChart.col_eq_of_flankBelow X.hC X.hs₀ X.hord X.hcol₀ (by rw [BranchGerms.e_nextβ, hp, hβ])
      (by rw [BranchGerms.nextκ_eq, hp, hκ]) hh
  obtain ⟨R, hRs, hRδ⟩ := (X.eventually_small.and (Ioo_mem_nhdsGT hδ)).exists
  obtain ⟨ρ, ⟨hs, hcl⟩, hρR⟩ := ((X.eventually_small.and hclear).and (Ioo_mem_nhdsGT hRs.1)).exists
  exact ⟨ρ, hs.1, hρR.2.trans hRδ.2, X.exists_shaveStep_aux hs hRs hρR.2 hF hc hp hβ hnβ hκ hnκ hsec hcg hch h1 hH.1 h2
    hσ₁ hσ₂ hcl hdeg hhorn⟩

end ArcMap

end HadwigerNelson.Plane
