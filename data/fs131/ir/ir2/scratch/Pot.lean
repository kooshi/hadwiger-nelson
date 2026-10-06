import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- With at least two germs, the next germ is another germ. -/
theorem BranchGerms.next_ne_self {n : ℕ} (hn : 2 ≤ n) (p : Fin n) : BranchGerms.next p ≠ p := by
  intro h
  have h' := congrArg Fin.val h
  rw [BranchGerms.next] at h'
  split_ifs at h' with h1
  · simp at h'
  · simp at h'; omega

namespace ArcMap

variable {k : ℕ}

--BEGIN
/-! ## Comparing the sectors of two maps at a point: the potential under a step (FS131-IR2)

The vertex step's count. A step's cleaned map is compared with the map before it through their sectors at one radius, as sets:
if every sector of the new map contains a sector of the old one, the new map has at most as many sectors and at most as many horns
(`pot_le_of_sectors`: distinct sectors are disjoint, and a chart sector inside a horn set is a horn set); if moreover one old
sector is never needed, the degree drops (`pot_lt_of_sectors`). Cleaning is the first case (`cleanKeep_pot_le`: a sector of the
cleaned map is a union of chart sectors of one colour and the germs between them, so it contains one); a move that keeps every old
interior point interior and makes one old germ interior is the second (`pot_lt_of_interior`). No chart of the new map is built. -/

/-- Two sectors at one radius that meet are equal. -/
theorem IsSector.eq_of_inter_nonempty {F : ArcMap k} {v : ℂ} {r : ℝ} {S S' : Set ℂ} (h : F.IsSector v r S)
    (h' : F.IsSector v r S') (hne : (S ∩ S').Nonempty) : S = S' := by
  obtain ⟨x, -, rfl, -⟩ := h
  obtain ⟨x', -, rfl, -⟩ := h'
  obtain ⟨z, hz, hz'⟩ := hne
  exact (connectedComponentIn_eq hz).trans (connectedComponentIn_eq hz').symm

/-- **Counting sectors by containment**: if each sector of `F₂` in a family `𝒜` contains a sector of `F₁` in a family `ℬ`, then
`𝒜` has at most as many members as `ℬ` (the contained sectors are distinct: sectors of `F₂` are disjoint). -/
theorem encard_le_of_forall_exists_subset {F₁ F₂ : ArcMap k} {v : ℂ} {r : ℝ} {𝒜 ℬ : Set (Set ℂ)}
    (h𝒜 : ∀ S ∈ 𝒜, F₂.IsSector v r S) (hℬ : ∀ S ∈ ℬ, F₁.IsSector v r S)
    (h : ∀ S₂ ∈ 𝒜, ∃ S₁ ∈ ℬ, S₁ ⊆ S₂) : 𝒜.encard ≤ ℬ.encard := by
  classical
  choose! f hf using h
  refine encard_le_encard_of_injOn (fun S hS => (hf S hS).1) fun S hS S' hS' hSS' => ?_
  obtain ⟨z, hz⟩ := (hℬ _ (hf S hS).1).nonempty
  exact (h𝒜 S hS).eq_of_inter_nonempty (h𝒜 S' hS') ⟨z, (hf S hS).2 hz, (hf S' hS').2 (hSS' ▸ hz)⟩

/-- **A sector inside a horn set is a horn set** (at a chart radius: `Near.horn_of_sector_subset_hornSet`; with no germ the one
sector is the ball, which holds `v`). -/
theorem IsSector.hornSet_of_subset {F : ArcMap k} {v : ℂ} (X : F.Near v) {r : ℝ} (hr : r ∈ Ioc 0 X.r₀) {S : Set ℂ}
    (hS : F.IsSector v r S) {α a b : ℝ} (hsub : S ⊆ hornSet v α a b r) :
    ∃ α' κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α' κ₁ κ₂ r := by
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · exfalso
    have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
    have hv' : v ∈ hornSet v α a b r := hsub (hball ▸ mem_ball_self hr.1)
    have := hv'.2.1
    simp [frameX] at this
  · obtain ⟨i, rfl⟩ := (X.hC.isSector_iff hn hr).mp hS
    obtain ⟨-, -, hlt, hsec⟩ := X.horn_of_sector_subset_hornSet hr hsub
    exact ⟨α, _, _, hlt, hsec r hr⟩

/-- The two counts at one chart radius: sectors against a family `ℬ` of old sectors, and horn sectors against horn sectors. -/
theorem encard_sectors_le_aux {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) {r : ℝ} (hr : r ∈ Ioc 0 X.r₀) {ℬ : Set (Set ℂ)}
    (hℬ : ∀ S ∈ ℬ, F₁.IsSector v r S) (h : ∀ S₂, F₂.IsSector v r S₂ → ∃ S₁ ∈ ℬ, S₁ ⊆ S₂) :
    {S | F₂.IsSector v r S}.encard ≤ ℬ.encard ∧
      {S | F₂.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard ≤
        {S | F₁.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard := by
  refine ⟨encard_le_of_forall_exists_subset (fun S hS => hS) hℬ fun S₂ hS₂ => h S₂ hS₂, ?_⟩
  refine encard_le_of_forall_exists_subset (F₁ := F₁) (F₂ := F₂) (fun S hS => hS.1) (fun S hS => hS.1) ?_
  rintro S₂ ⟨hS₂, α, κ₁, κ₂, -, rfl⟩
  obtain ⟨S₁, hS₁, hsub⟩ := h _ hS₂
  exact ⟨S₁, ⟨hℬ S₁ hS₁, IsSector.hornSet_of_subset X hr (hℬ S₁ hS₁) hsub⟩, hsub⟩

/-- **The potential does not rise** when, at every small radius, every sector of `F₂` at `v` contains a sector of `F₁`: neither
the degree nor the horn count rises. -/
theorem pot_le_of_sectors {F₁ F₂ : ArcMap k} {v : ℂ} (hv : v ∈ F₁.dom)
    (h : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S₂, F₂.IsSector v r S₂ → ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ⊆ S₂)
    {m₁ j₁ m₂ j₂ : ℕ} (hm₁ : F₁.HasDegree v m₁) (hj₁ : F₁.HasHornCount v j₁) (hm₂ : F₂.HasDegree v m₂)
    (hj₂ : F₂.HasHornCount v j₂) : m₂ ≤ m₁ ∧ j₂ ≤ j₁ := by
  obtain ⟨X⟩ := exists_near hv
  obtain ⟨r, ⟨⟨⟨⟨h, h1⟩, h2⟩, h3⟩, h4⟩, hr⟩ :=
    (((((h.and hm₁).and hj₁).and hm₂).and hj₂).and (Ioc_mem_nhdsGT X.hC.pos)).exists
  have key := encard_sectors_le_aux X hr (ℬ := {S | F₁.IsSector v r S}) (fun S hS => hS) h
  rw [h1, h2, h3, h4] at key
  exact ⟨by exact_mod_cast key.1, by exact_mod_cast key.2⟩

/-- **The potential drops** when, at every small radius, some sector `H` of `F₁` at `v` is such that every sector of `F₂` contains
a sector of `F₁` other than `H`: the degree drops and the horn count does not rise. -/
theorem pot_lt_of_sectors {F₁ F₂ : ArcMap k} {v : ℂ} (hv : v ∈ F₁.dom)
    (h : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∃ H, F₁.IsSector v r H ∧
      ∀ S₂, F₂.IsSector v r S₂ → ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ≠ H ∧ S₁ ⊆ S₂)
    {m₁ j₁ m₂ j₂ : ℕ} (hm₁ : F₁.HasDegree v m₁) (hj₁ : F₁.HasHornCount v j₁) (hm₂ : F₂.HasDegree v m₂)
    (hj₂ : F₂.HasHornCount v j₂) : m₂ + j₂ < m₁ + j₁ := by
  obtain ⟨X⟩ := exists_near hv
  obtain ⟨r, ⟨⟨⟨⟨⟨H, hH, h⟩, h1⟩, h2⟩, h3⟩, h4⟩, hr⟩ :=
    (((((h.and hm₁).and hj₁).and hm₂).and hj₂).and (Ioc_mem_nhdsGT X.hC.pos)).exists
  have key := encard_sectors_le_aux X hr (ℬ := {S | F₁.IsSector v r S} \ {H}) (fun S hS => hS.1)
    (fun S₂ hS₂ => by obtain ⟨S₁, a, b, c⟩ := h S₂ hS₂; exact ⟨S₁, ⟨a, b⟩, c⟩)
  have hH1 : ({S | F₁.IsSector v r S} \ {H}).encard + 1 = m₁ := by
    rw [encard_sdiff_singleton_add_one (show H ∈ {S | F₁.IsSector v r S} from hH), h1]
  rw [h3, h4, h2] at key
  have h5 : (m₂ : ℕ∞) + 1 ≤ m₁ := by rw [← hH1]; gcongr; exact key.1
  have h6 : m₂ + 1 ≤ m₁ := by exact_mod_cast h5
  have h7 : j₂ ≤ j₁ := by exact_mod_cast key.2
  omega

/-- **Every sector of `F₂` contains a sector of `F₁`** when the interior points of `F₁` near `v` are interior points of `F₂`: an
open set of the ball holds an interior point of `F₁`, whose component is a chart sector of `F₁`, connected and interior to `F₂`. -/
theorem exists_isSector_subset {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) {r : ℝ} (hr : r ∈ Ioc 0 X.r₀)
    (hsub : F₁.interiorPts ∩ ball v r ⊆ F₂.interiorPts) {S₂ : Set ℂ} (hS₂ : F₂.IsSector v r S₂) :
    ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ⊆ S₂ := by
  obtain ⟨x, hx, rfl, -⟩ := hS₂
  have hopen : IsOpen (connectedComponentIn (F₂.interiorPts ∩ ball v r) x) :=
    (F₂.isOpen_interiorPts.inter isOpen_ball).connectedComponentIn
  have hxd : x ∈ F₁.dom := X.hC.subdom (ball_subset_ball hr.2 hx.2)
  obtain ⟨z, hz, hzI⟩ := mem_closure_iff.mp (F₁.dense_interiorPts hxd) _ hopen (mem_connectedComponentIn hx)
  have hzb : z ∈ ball v r := (connectedComponentIn_subset _ _ hz).2
  have hzU : z ∈ F₁.interiorPts ∩ ball v r := ⟨hzI, hzb⟩
  refine ⟨connectedComponentIn (F₁.interiorPts ∩ ball v r) z, ⟨z, hzU, rfl, ?_⟩, ?_⟩
  · rcases Nat.eq_zero_or_pos X.n with hn | hn
    · have hball : ball v r ⊆ F₁.interiorPts ∩ ball v r := fun y hy =>
        ⟨X.hC.empty hn (ball_subset_ball hr.2 hy), hy⟩
      exact subset_closure ((convex_ball v r).isPreconnected.subset_connectedComponentIn hzb hball (mem_ball_self hr.1))
    · have hz' : z ∈ ⋃ i, X.G.sector v r i := by rw [← X.hC.cover r hr hn]; exact ⟨hzb, hzI⟩
      obtain ⟨i, hi⟩ := mem_iUnion.mp hz'
      rw [connectedComponentIn_eq_of_iUnion (by rw [inter_comm]; exact X.hC.cover r hr hn) (X.hC.isOpen r hr)
        (X.hC.isPreconnected r hr) (X.hC.disjoint r hr) hi]
      exact X.hC.mem_closure_sector hr i
  · rw [connectedComponentIn_eq hz]
    exact isPreconnected_connectedComponentIn.subset_connectedComponentIn (mem_connectedComponentIn hzU)
      ((connectedComponentIn_subset _ _).trans fun y hy => ⟨hsub hy, hy.2⟩)

/-- **… and one other than the sector before a germ that became interior**: if a point of the germ after the chart sector `p`
of `F₁` is interior to `F₂`, every sector of `F₂` that contains the sector `p` contains the next one too. -/
theorem exists_isSector_ne_subset {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) (hn : 2 ≤ X.n) {r : ℝ} (hr : r ∈ Ioc 0 X.s₀)
    (hsub : F₁.interiorPts ∩ ball v r ⊆ F₂.interiorPts) {p : Fin X.n} {s : ℝ} (hs : s ∈ Ioo 0 r)
    (hx : branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) s ∈ F₂.interiorPts)
    {S₂ : Set ℂ} (hS₂ : F₂.IsSector v r S₂) :
    ∃ S₁, F₁.IsSector v r S₁ ∧ S₁ ≠ X.G.sector v r p ∧ S₁ ⊆ S₂ := by
  have hr' : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hr.2.trans X.hs₀.2⟩
  have hn0 : 0 < X.n := by omega
  obtain ⟨S₁, hS₁, hS₁₂⟩ := exists_isSector_subset X hr' hsub hS₂
  by_cases hne : S₁ = X.G.sector v r p
  swap
  · exact ⟨S₁, hS₁, hne, hS₁₂⟩
  subst hne
  set q := BranchGerms.next p with hq
  set x := branchPt v (X.G.β q) (X.G.κ q) s with hxdef
  have hxb : x ∈ ball v r := by
    rw [mem_ball, dist_eq_norm, norm_branchPt_sub v _ _ hs.1.le]; exact hs.2
  set U := F₂.interiorPts ∩ ball v r with hU
  have hUo : IsOpen U := F₂.isOpen_interiorPts.inter isOpen_ball
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hUo x ⟨hx, hxb⟩
  have hsecU : ∀ i, X.G.sector v r i ⊆ U := fun i y hy =>
    ⟨hsub ⟨X.hC.sector_subset_interiorPts hn0 hr' i hy, (X.hC.cover r hr' hn0 ▸ mem_iUnion.mpr ⟨i, hy⟩ :
      y ∈ ball v r ∩ F₁.interiorPts).1⟩, (X.hC.cover r hr' hn0 ▸ mem_iUnion.mpr ⟨i, hy⟩ : y ∈ ball v r ∩ F₁.interiorPts).1⟩
  obtain ⟨x₀, hx₀, rfl, -⟩ := hS₂
  -- the small ball about `x` lies in the component
  obtain ⟨y, hy, hyx⟩ := Metric.mem_closure_iff.mp
    (IsSectorChart.branchPt_mem_closure_sector_before X.hord hr.2 p hs) ε hε
  have hyS : y ∈ connectedComponentIn U x₀ := hS₁₂ hy
  have hyb : y ∈ ball x ε := by rw [mem_ball]; rw [dist_comm] at hyx; exact hyx
  have hballS : ball x ε ⊆ connectedComponentIn U x₀ := by
    rw [connectedComponentIn_eq hyS]
    exact (convex_ball x ε).isPreconnected.subset_connectedComponentIn hyb hball
  obtain ⟨y', hy', hy'x⟩ := Metric.mem_closure_iff.mp
    (IsSectorChart.branchPt_mem_closure_sector_after X.hord hr.2 q hs) ε hε
  have hy'S : y' ∈ connectedComponentIn U x₀ := hballS (by rw [mem_ball]; rw [dist_comm] at hy'x; exact hy'x)
  refine ⟨X.G.sector v r q, (X.hC.isSector_iff hn0 hr').mpr ⟨q, rfl⟩, fun heq => ?_, ?_⟩
  · have hd := X.hC.disjoint r hr' q p (BranchGerms.next_ne_self hn p)
    rw [heq] at hd
    obtain ⟨w, hw⟩ := X.hC.sector_nonempty hr' p
    exact disjoint_left.mp hd hw hw
  · rw [connectedComponentIn_eq hy'S]
    exact (X.hC.isPreconnected r hr' q).subset_connectedComponentIn hy' (hsecU q)

/-- **The potential drops under a step that keeps the old interior and makes one germ interior**: `F₁` has at least two germs at
`v`, its interior points near `v` are interior points of `F₂`, and so are the points near `v` of one of its germs. -/
theorem pot_lt_of_interior {F₁ F₂ : ArcMap k} {v : ℂ} (X : F₁.Near v) (hn : 2 ≤ X.n)
    (hsub : ∀ᶠ r in 𝓝[>] (0 : ℝ), F₁.interiorPts ∩ ball v r ⊆ F₂.interiorPts) {p : Fin X.n}
    (hdrop : ∀ᶠ s in 𝓝[>] (0 : ℝ),
      branchPt v (X.G.β (BranchGerms.next p)) (X.G.κ (BranchGerms.next p)) s ∈ F₂.interiorPts)
    {m₁ j₁ m₂ j₂ : ℕ} (hm₁ : F₁.HasDegree v m₁) (hj₁ : F₁.HasHornCount v j₁) (hm₂ : F₂.HasDegree v m₂)
    (hj₂ : F₂.HasHornCount v j₂) : m₂ + j₂ < m₁ + j₁ := by
  refine pot_lt_of_sectors X.mem_dom ?_ hm₁ hj₁ hm₂ hj₂
  obtain ⟨u, hu, huP⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp hdrop
  have hu0 : (0 : ℝ) < u := hu
  filter_upwards [hsub, Ioc_mem_nhdsGT X.hs₀.1, Ioo_mem_nhdsGT hu0] with r hr1 hr2 hr3
  refine ⟨X.G.sector v r p, (X.hC.isSector_iff (by omega) ⟨hr2.1, hr2.2.trans X.hs₀.2⟩).mpr ⟨p, rfl⟩, fun S₂ hS₂ => ?_⟩
  exact exists_isSector_ne_subset X hn hr2 hr1 ⟨half_pos hr2.1, half_lt_self hr2.1⟩
    (huP ⟨half_pos hr2.1, by linarith [hr3.2]⟩) hS₂

/-- An interior point stays interior under cleaning (it carries one colour). -/
theorem interiorPts_subset_cleanKeep (M : ArcMap k) : M.interiorPts ⊆ M.cleanKeep.interiorPts := by
  intro z hz
  rw [cleanKeep_interiorPts]
  refine ⟨hz.1, fun hE => ?_⟩
  have := hE.2
  rw [coloursAt_eq_singleton_of_interior hz, ncard_singleton] at this
  omega

/-- **Cleaning raises neither the degree nor the horn count** at any point of the domain. -/
theorem cleanKeep_pot_le {M : ArcMap k} {v : ℂ} (hv : v ∈ M.dom) {m j m' j' : ℕ} (hm : M.HasDegree v m)
    (hj : M.HasHornCount v j) (hm' : M.cleanKeep.HasDegree v m') (hj' : M.cleanKeep.HasHornCount v j') :
    m' ≤ m ∧ j' ≤ j := by
  obtain ⟨X⟩ := exists_near hv
  refine pot_le_of_sectors hv ?_ hm hj hm' hj'
  filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr S₂ hS₂
  exact exists_isSector_subset X hr (inter_subset_left.trans M.interiorPts_subset_cleanKeep) hS₂

/-- **Cleaning creates no repeated colour**: two sectors of one colour of the cleaned map hold two of the map. -/
theorem hasRepeatedColour_of_cleanKeep {M : ArcMap k} {x : ℂ} (hx : x ∈ M.dom) (h : M.cleanKeep.HasRepeatedColour x) :
    M.HasRepeatedColour x := by
  obtain ⟨c, hc⟩ := h
  obtain ⟨X⟩ := exists_near hx
  refine ⟨c, ?_⟩
  filter_upwards [hc, Ioc_mem_nhdsGT X.hC.pos] with r h2 hr
  refine h2.trans (encard_le_of_forall_exists_subset (F₁ := M) (F₂ := M.cleanKeep) (v := x) (r := r)
    (fun S hS => hS.1) (fun S hS => hS.1) ?_)
  rintro S₂ ⟨hS₂, hcol⟩
  obtain ⟨S₁, hS₁, hsub⟩ := exists_isSector_subset X hr (inter_subset_left.trans M.interiorPts_subset_cleanKeep) hS₂
  refine ⟨S₁, ⟨hS₁, fun z hz => ?_⟩, hsub⟩
  have hzI : z ∈ M.interiorPts := by
    obtain ⟨y, -, rfl, -⟩ := hS₁
    exact (connectedComponentIn_subset _ _ hz).1
  have hzE : z ∈ M.dom \ M.essSet := by rw [← cleanKeep_interiorPts]; exact M.interiorPts_subset_cleanKeep hzI
  have h1 : M.cleanKeep.col z = c := hcol (hsub hz)
  rw [cleanKeep_col hzE, cleanCol_eq (coloursAt_eq_singleton_of_interior hzI)] at h1
  exact h1

/-- **A point with no horn and no repeated colour is no site after cleaning.** -/
theorem not_isSite_cleanKeep {M : ArcMap k} {x : ℂ} (hx : x ∈ M.dom) (h0 : M.HasHornCount x 0)
    (hrep : ¬ M.HasRepeatedColour x) : ¬ M.cleanKeep.IsSite x := by
  rintro ⟨-, hr | ⟨α, κ₁, κ₂, c, hlt, hH⟩⟩
  · exact hrep (hasRepeatedColour_of_cleanKeep hx hr)
  · obtain ⟨m, -, hm⟩ := exists_hasDegree_of_mem_dom hx
    obtain ⟨m', -, hm'⟩ := exists_hasDegree_of_mem_dom (F := M.cleanKeep) hx
    obtain ⟨j', hj'⟩ := exists_hasHornCount (F := M.cleanKeep) hx
    have hj0 : j' = 0 := Nat.le_zero.mp (cleanKeep_pot_le hx hm h0 hm' hj').2
    subst hj0
    obtain ⟨r, ⟨hS, -⟩, hr0⟩ := (hH.and hj').exists
    rw [Nat.cast_zero, encard_eq_zero] at hr0
    exact (eq_empty_iff_forall_notMem.mp hr0) _ ⟨hS, α, κ₁, κ₂, hlt, rfl⟩
--END

end ArcMap

end HadwigerNelson.Plane
