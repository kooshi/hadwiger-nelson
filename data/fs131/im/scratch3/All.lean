import Proofs.HadwigerNelson.Plane.ValidMap.Moves

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- A germ whose next germ has the same direction is not its own next germ (a one-germ chart's next direction is a turn on). -/
theorem BranchGerms.ne_next_of_nextβ_eq {n : ℕ} {G : BranchGerms n} {i : Fin n} (h : G.nextβ i = G.β i) :
    i ≠ BranchGerms.next i := by
  intro hi
  have := G.nextDir_of_next_eq hi.symm 0
  simp only [BranchGerms.nextDir, BranchGerms.dir, germDir, mul_zero, zero_div, Real.arcsin_zero, add_zero] at this
  rw [h] at this
  linarith [Real.pi_pos]

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} (X : F.Near v)

/-- **A horn's chart index in the near data**: a `c`-horn is the chart sector after a germ of direction `α` (mod `2π`) and curvature
`κ₁` whose next germ has the same direction and curvature `κ₂`, and that sector has colour `c`. -/
theorem horn_index {α κ₁ κ₂ : ℝ} {c : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∃ i, e (X.G.β i) = e α ∧ X.G.nextβ i = X.G.β i ∧ X.G.κ i = κ₁ ∧ X.G.nextκ i = κ₂ ∧ X.col i = c ∧
      ∀ r ∈ Ioc 0 X.r₀, X.G.sector v r i = hornSet v α κ₁ κ₂ r := by
  obtain ⟨r, ⟨hS, hc⟩, hr⟩ := (hH.2.and (Ioc_mem_nhdsGT X.hC.pos)).exists
  obtain ⟨i, hβ, hnβ, hκ, hnκ, hsec⟩ := X.hC.index_of_isSector_hornSet hr hH.1 hS
  refine ⟨i, hβ, hnβ, hκ, hnκ, ?_, hsec⟩
  obtain ⟨z, hz⟩ := X.hC.sector_nonempty hr i
  have h1 := (X.hcol i r hr hz).2
  have h2 := hc (hsec r hr ▸ hz)
  simp only [mem_preimage, mem_singleton_iff] at h1 h2
  rw [← h1, h2]

/-- **The sector count in the near data**: `s_c(v) = m` is the number of chart sectors of colour `c`. -/
theorem encard_col_eq (hn0 : 0 < X.n) {c : Fin k} {m : ℕ} (hm : F.HasSectors v c m) : {i | X.col i = c}.encard = m := by
  obtain ⟨r, hr', hr⟩ := (hm.and (Ioc_mem_nhdsGT X.hC.pos)).exists
  rw [← hr', X.hC.encard_sectorsOf hn0 hr (fun i => X.hcol i r hr) c]

end Near

variable {k : ℕ} {F : ArcMap k}

/-- **SHAVE when the upper flank is the horn's colour**: the cut across the horn's upper germ merges the horn with its upper flank. -/
theorem exists_shave_of_flankAbove (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (hg : F.IsFlankAbove v α κ₂ c) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 2 := by
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨i, hβ, hnβ, -, hnκ, hci, -⟩ := X.horn_index hH
  have hnext : X.col (BranchGerms.next i) = c :=
    IsSectorChart.col_eq_of_flankAbove X.hC X.hs₀ X.hord X.hcol₀ (by rw [← BranchGerms.e_nextβ, hnβ, hβ])
      (by rw [← BranchGerms.nextκ_eq, hnκ]) hg
  obtain ⟨ρ, hρ⟩ := X.eventually_small.exists
  exact ⟨ρ, hρ.1, X.exists_cut hF hρ (BranchGerms.ne_next_of_nextβ_eq hnβ) hci hnext (X.encard_col_eq i.pos hn)⟩

/-- **SHAVE when the lower flank is the horn's colour**: the cut across the horn's lower germ merges the horn with its lower flank. -/
theorem exists_shave_of_flankBelow (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (hh : F.IsFlankBelow v α κ₁ c) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 2 := by
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨i, hβ, hnβ, hκ, -, hci, -⟩ := X.horn_index hH
  obtain ⟨p, hp⟩ := (Finite.injective_iff_surjective.mp BranchGerms.next_injective) i
  have hcp : X.col p = c :=
    IsSectorChart.col_eq_of_flankBelow X.hC X.hs₀ X.hord X.hcol₀ (by rw [BranchGerms.e_nextβ, hp, hβ])
      (by rw [BranchGerms.nextκ_eq, hp, hκ]) hh
  have hpj : p ≠ BranchGerms.next p := by
    intro h'
    apply BranchGerms.ne_next_of_nextβ_eq hnβ
    rw [← hp, ← h']; exact h'
  obtain ⟨ρ, hρ⟩ := X.eventually_small.exists
  exact ⟨ρ, hρ.1, X.exists_cut hF hρ hpj hcp (by rw [hp]; exact hci) (X.encard_col_eq i.pos hn)⟩

end ArcMap

/-- A non-degenerate arc that is no unit arc meets every unit circle in finitely many points. -/
theorem Arc.finite_inter_sphere_of_not_isUnitArc {a : Arc} (ha : a.Nondegenerate) (hu : ¬ a.IsUnitArc) (p : ℂ) :
    (a.carrier ∩ sphere p 1).Finite := by
  rcases a.finite_inter_sphere_or_eq_circ ha p with hf | ⟨θ₀, θ₁, rfl⟩
  · exact hf
  · exact absurd (show (Arc.circ p 1 θ₀ θ₁).IsUnitArc from rfl) hu

/-- **The tangent arc of curvature `σ` inside a horn**: a point of `hornSet v α κ₁ κ₂ ρ` lies on `germArc v α σ ρ` exactly when it
is on the tangent circle of curvature `σ` (`|σ| ρ ≤ 2`). -/
theorem mem_germArc_iff_of_mem_hornSet {v z : ℂ} {α κ₁ κ₂ σ ρ : ℝ} (hρ : 0 ≤ ρ) (hσρ : |σ| * ρ ≤ 2)
    (hz : z ∈ hornSet v α κ₁ κ₂ ρ) :
    z ∈ (germArc v α σ ρ).carrier ↔ tanHeight σ (frameX v α z) (frameY v α z) = 0 := by
  rw [carrier_germArc v α hρ hσρ]
  constructor
  · rintro ⟨s, hs, rfl⟩
    rw [tanHeight_branchPt v α σ σ ((mul_le_mul_of_nonneg_left hs.2 (abs_nonneg _)).trans hσρ) hs.1]; ring
  · intro hT
    have hzρ : ‖z - v‖ < ρ := by rw [← dist_eq_norm]; exact hz.1
    exact ⟨‖z - v‖, ⟨norm_nonneg _, hzρ.le⟩,
      (eq_branchPt_of_tanHeight_eq_zero hz.2.1 hT ((mul_le_mul_of_nonneg_left hzρ.le (abs_nonneg _)).trans hσρ)).symm⟩

/-- SHAVE's new arc: the tangent arc of curvature `σ` out to `ρ`, when `σ` lies strictly between the horn's curvatures. -/
def shaveArcs (v : ℂ) (α κ₁ κ₂ σ ρ : ℝ) : Set Arc := {a | κ₁ < σ ∧ σ < κ₂ ∧ a = germArc v α σ ρ}

theorem mem_shaveArcs_carrier {v z : ℂ} {α κ₁ κ₂ σ ρ : ℝ} :
    z ∈ ⋃ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.carrier ↔ κ₁ < σ ∧ σ < κ₂ ∧ z ∈ (germArc v α σ ρ).carrier := by
  constructor
  · intro hz
    obtain ⟨a, ⟨h1, h2, rfl⟩, hza⟩ := mem_iUnion₂.mp hz
    exact ⟨h1, h2, hza⟩
  · rintro ⟨h1, h2, hz⟩
    exact mem_iUnion₂.mpr ⟨_, ⟨h1, h2, rfl⟩, hz⟩

theorem shaveArcs_finite (v : ℂ) (α κ₁ κ₂ σ ρ : ℝ) : (shaveArcs v α κ₁ κ₂ σ ρ).Finite :=
  (finite_singleton (germArc v α σ ρ)).subset fun _ ha => ha.2.2

theorem shaveArcs_nondegenerate {v : ℂ} {α κ₁ κ₂ σ ρ : ℝ} (hρ : 0 < ρ) : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.Nondegenerate := by
  rintro a ⟨-, -, rfl⟩; exact germArc_nondegenerate v α σ hρ

theorem shaveArcs_not_isUnitArc {v : ℂ} {α κ₁ κ₂ σ ρ : ℝ} (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1) :
    ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, ¬ a.IsUnitArc := by
  rintro a ⟨hσ₁, hσ₂, rfl⟩ hu
  rw [germArc_isUnitArc_iff] at hu
  rcases abs_eq (zero_le_one) |>.mp hu with h | h <;> linarith

theorem shaveArcs_subset_closedBall {v : ℂ} {α κ₁ κ₂ σ ρ : ℝ} (hρ : 0 ≤ ρ) (hσρ : |σ| * ρ ≤ 2) :
    ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.carrier ⊆ closedBall v ρ := by
  rintro a ⟨-, -, rfl⟩
  rw [carrier_germArc v α hρ hσρ]
  rintro z ⟨s, hs, rfl⟩
  rw [mem_closedBall, dist_eq_norm, norm_branchPt_sub v _ _ hs.1]; exact hs.2

namespace ArcMap

variable {k : ℕ}

/-- **SHAVE's colouring**: in the tip `hornSet v α κ₁ κ₂ ρ`, `g` above the tangent arc of curvature `σ` and `h` on or below it; `F`'s
elsewhere. -/
noncomputable def shaveCol (F : ArcMap k) (v : ℂ) (α κ₁ κ₂ σ ρ : ℝ) (g h : Fin k) : ℂ → Fin k := fun z => by
  classical exact if z ∈ hornSet v α κ₁ κ₂ ρ then (if TanAbove v α σ z then g else h) else F.col z

variable {F : ArcMap k} {v : ℂ} {α κ₁ κ₂ σ ρ : ℝ} {g h : Fin k}

theorem shaveCol_of_not_mem {z : ℂ} (hz : z ∉ hornSet v α κ₁ κ₂ ρ) : F.shaveCol v α κ₁ κ₂ σ ρ g h z = F.col z := by
  simp [shaveCol, hz]

theorem shaveCol_of_above {z : ℂ} (hz : z ∈ hornSet v α κ₁ κ₂ ρ) (hT : TanAbove v α σ z) :
    F.shaveCol v α κ₁ κ₂ σ ρ g h z = g := by
  simp [shaveCol, hz, hT]

theorem shaveCol_of_not_above {z : ℂ} (hz : z ∈ hornSet v α κ₁ κ₂ ρ) (hT : ¬ TanAbove v α σ z) :
    F.shaveCol v α κ₁ κ₂ σ ρ g h z = h := by
  simp [shaveCol, hz, hT]

theorem shaveCol_mem {z : ℂ} (hz : z ∈ hornSet v α κ₁ κ₂ ρ) : F.shaveCol v α κ₁ κ₂ σ ρ g h z = g ∨ F.shaveCol v α κ₁ κ₂ σ ρ g h z = h := by
  by_cases hT : TanAbove v α σ z
  · exact Or.inl (shaveCol_of_above hz hT)
  · exact Or.inr (shaveCol_of_not_above hz hT)

namespace Near

variable {X : F.Near v}

/-- `v` is no interior point when the chart has a germ. -/
theorem not_mem_interiorPts_self (X : F.Near v) (hn0 : 0 < X.n) : v ∉ F.interiorPts := fun hI =>
  hI.2 (X.mem_Γ hn0).2

/-- **SHAVE's interior points in the ball**: with every germ kept and the `σ`-arc added, a point of `B(v, ρ)` is interior to the move
exactly when it is interior to `F` and, inside the tip, off the tangent circle of curvature `σ`. -/
theorem shave_mem_interiorPts_iff {ρ : ℝ} {hs : X.Small ρ} (hn0 : 0 < X.n) (hσ : |σ| ≤ 1) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    {col' : ℂ → Fin k} {hE : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.Nondegenerate} {hEf : (shaveArcs v α κ₁ κ₂ σ ρ).Finite}
    {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ univ (shaveArcs v α κ₁ κ₂ σ ρ), a.carrier →
      ∀ᶠ y in 𝓝 x, col' y = col' x} {z : ℂ} (hz : z ∈ ball v ρ) :
    z ∈ (X.move hs univ (shaveArcs v α κ₁ κ₂ σ ρ) col' hE hEf hlc).interiorPts ↔
      z ∈ F.interiorPts ∧ (z ∈ hornSet v α κ₁ κ₂ ρ → tanHeight σ (frameX v α z) (frameY v α z) ≠ 0) := by
  have hσρ : |σ| * ρ ≤ 2 := by nlinarith [hs.2.2.2, abs_nonneg σ, hs.1]
  have hK : (univ : Set (Fin X.n)).Nonempty := ⟨⟨0, hn0⟩, trivial⟩
  rw [mem_move_interiorPts_iff hz, mem_newArcs_iff hs hK hz, mem_shaveArcs_carrier]
  constructor
  · intro hn
    push Not at hn
    obtain ⟨hzv, hzb, hzE⟩ := hn
    refine ⟨(X.mem_interiorPts_iff hs hz hzv).mpr fun i => hzb hzv i trivial, fun hzt hT => ?_⟩
    have hσ₁' : κ₁ < σ := lt_of_le_of_ne hσ₁ fun h' => by
      have := hzt.2.2.1; unfold TanAbove at this; rw [h'] at this; linarith
    have hσ₂' : σ < κ₂ := lt_of_le_of_ne hσ₂ fun h' => by
      have := hzt.2.2.2; unfold TanBelow at this; rw [← h'] at this; linarith
    exact hzE hσ₁' hσ₂' ((mem_germArc_iff_of_mem_hornSet hs.1.le hσρ hzt).mpr hT)
  · rintro ⟨hzI, hzt⟩ (h1 | ⟨-, i, -, h2⟩ | ⟨h3, h4, h5⟩)
    · exact X.not_mem_interiorPts_self hn0 (h1 ▸ hzI)
    · have hzv : z ≠ v := fun h' => X.not_mem_interiorPts_self hn0 (h' ▸ hzI)
      exact ((X.mem_interiorPts_iff hs hz hzv).mp hzI i) h2
    · rw [carrier_germArc v α hs.1.le hσρ] at h5
      obtain ⟨s, hs', rfl⟩ := h5
      have hsρ : s < ρ := by
        have := mem_ball.mp hz; rwa [dist_eq_norm, norm_branchPt_sub v _ _ hs'.1] at this
      rcases eq_or_lt_of_le hs'.1 with h0 | h0
      · subst h0
        exact X.not_mem_interiorPts_self hn0 (by simpa [branchPt] using hzI)
      · have hσs : |σ| * s < 2 := by nlinarith [abs_nonneg σ, hs.2.2.2]
        have hmem := branchPt_mem_hornSet v α h3 h4 h0 hsρ hσs
        exact hzt hmem ((mem_germArc_iff_of_mem_hornSet hs.1.le hσρ hmem).mp
          (by rw [carrier_germArc v α hs.1.le hσρ]; exact ⟨s, hs', rfl⟩))

/-- **The colours at a point of a chart sector's closure**: those of the sector, the sector before it and the sector after it. -/
theorem coloursAt_subset_of_mem_closure_sector (X : F.Near v) {i q : Fin X.n} (hq : BranchGerms.next q = i) {x : ℂ}
    (hx : x ∈ closure (X.G.sector v X.s₀ i)) (hxv : x ≠ v) (hxs : x ∈ ball v X.s₀) :
    F.coloursAt x ⊆ {X.col q, X.col i, X.col (BranchGerms.next i)} := by
  have hsub := X.hC.coloursAt_subset_image i.pos X.hs₀ X.hcol₀ hxs
  have hx0 : 0 < ‖x - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hxv)
  have hxs' : ‖x - v‖ < X.s₀ := by rw [mem_ball, dist_eq_norm] at hxs; exact hxs
  have hset : {j | x ∈ closure (X.G.sector v X.s₀ j)} ⊆ {q, i, BranchGerms.next i} := by
    intro j hj
    rcases X.G.closure_sector_cases hx hx0 hxs' with h | h | h
    · exact Or.inr (Or.inl (X.hC.eq_of_mem_closure_of_mem X.hs₀ h hj))
    · rw [mem_setOf_eq, h] at hj
      rcases X.hC.eq_or_next_eq_of_mem_closure X.hs₀.2 X.hdisj ⟨hx0, hxs'⟩ hj with h' | h'
      · exact Or.inr (Or.inl h')
      · exact Or.inl (BranchGerms.next_injective (h'.trans hq.symm))
    · rw [mem_setOf_eq, h] at hj
      rcases X.hC.eq_or_next_eq_of_mem_closure X.hs₀.2 X.hdisj ⟨hx0, hxs'⟩ hj with h' | h'
      · exact Or.inr (Or.inr h')
      · exact Or.inr (Or.inl (BranchGerms.next_injective h'))
  intro c hc
  obtain ⟨j, hj, rfl⟩ := hsub hc
  rcases hset hj with rfl | rfl | rfl
  · exact Or.inl rfl
  · exact Or.inr (Or.inl rfl)
  · exact Or.inr (Or.inr rfl)

/-- **SHAVE's sector count**: a map whose interior points in `B(v, ρ)` are `F`'s off the tangent circle of curvature `σ` inside the tip,
coloured by `shaveCol`, has one `c`-sector fewer at `v` than `F` when the horn is the chart sector `i₀` of colour `c` and neither flank
colour is `c`: the horn's sector is replaced by its two pieces above and below the `σ`-arc, coloured `g` and `h`. -/
theorem shave_hasSectors {F' : ArcMap k} {ρ : ℝ} (hs : X.Small ρ) {i₀ : Fin X.n}
    (hsec : ∀ r ∈ Ioc 0 X.r₀, X.G.sector v r i₀ = hornSet v α κ₁ κ₂ r) {c : Fin k} (hgc : g ≠ c) (hhc : h ≠ c)
    (hσ : |σ| ≤ 1) (h1 : |κ₁| ≤ 1) (h2 : |κ₂| ≤ 1) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    {m : ℕ} (hm : {i | X.col i = c}.encard = m + 1) (hci : X.col i₀ = c)
    (hint : ∀ z ∈ ball v ρ, z ∈ F'.interiorPts ↔
      z ∈ F.interiorPts ∧ (z ∈ hornSet v α κ₁ κ₂ ρ → tanHeight σ (frameX v α z) (frameY v α z) ≠ 0))
    (hcol' : ∀ z, F'.col z = F.shaveCol v α κ₁ κ₂ σ ρ g h z) : F'.HasSectors v c m := by
  filter_upwards [Ioc_mem_nhdsGT hs.1] with r hr
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hr.2.trans hs.lt_r₀.le⟩
  have hρ₀ : ρ ∈ Ioc 0 X.r₀ := hs.mem_Ioc
  have hn : 0 < X.n := i₀.pos
  have hr2 : r < 1 / 2 := lt_of_le_of_lt hr.2 hs.2.2.2
  have hsecI : ∀ i, X.G.sector v r i ⊆ F.interiorPts := X.hC.sector_subset_interiorPts hn hr₀
  have hnot : ∀ i, i ≠ i₀ → ∀ z ∈ X.G.sector v r i, z ∉ hornSet v α κ₁ κ₂ ρ := by
    intro i hi z hz hzt
    rw [← hsec ρ hρ₀] at hzt
    exact disjoint_left.mp (X.hC.disjoint ρ hρ₀ i i₀ hi) (X.G.sector_mono hr.2 i hz) hzt
  have hHr : hornSet v α κ₁ κ₂ r ⊆ hornSet v α κ₁ κ₂ ρ := hornSet_mono_radius hr.2
  have hHI : hornSet v α κ₁ κ₂ r ⊆ F.interiorPts := by rw [← hsec r hr₀]; exact hsecI i₀
  have hUH : hornSet v α σ κ₂ r ⊆ hornSet v α κ₁ κ₂ r := hornSet_mono hσ₁ le_rfl
  have hLH : hornSet v α κ₁ σ r ⊆ hornSet v α κ₁ κ₂ r := hornSet_mono le_rfl hσ₂
  set A : {i : Fin X.n // i ≠ i₀} ⊕ Bool → Set ℂ :=
    Sum.elim (fun i => X.G.sector v r i.1) (fun b => bif b then hornSet v α σ κ₂ r else hornSet v α κ₁ σ r) with hA
  set colA : {i : Fin X.n // i ≠ i₀} ⊕ Bool → Fin k := Sum.elim (fun i => X.col i.1) (fun b => bif b then g else h) with hcolA
  have hAl : ∀ i, A (.inl i) = X.G.sector v r i.1 := fun _ => rfl
  have hAt : A (.inr true) = hornSet v α σ κ₂ r := rfl
  have hAf : A (.inr false) = hornSet v α κ₁ σ r := rfl
  have hHdisj : ∀ i, i ≠ i₀ → Disjoint (X.G.sector v r i) (hornSet v α κ₁ κ₂ r) := fun i hi => by
    rw [← hsec r hr₀]; exact X.hC.disjoint r hr₀ i i₀ hi
  have hUL : Disjoint (hornSet v α σ κ₂ r) (hornSet v α κ₁ σ r) := disjoint_left.mpr fun z hU hL => by
    have h1 := hU.2.2.1; have h2 := hL.2.2.2; unfold TanAbove at h1; unfold TanBelow at h2; linarith
  have hU : F'.interiorPts ∩ ball v r = ⋃ j, A j := by
    ext z
    constructor
    · rintro ⟨hzI, hzr⟩
      obtain ⟨hzF, hzc⟩ := (hint z (ball_subset_ball hr.2 hzr)).mp hzI
      have : z ∈ ball v r ∩ F.interiorPts := ⟨hzr, hzF⟩
      rw [X.hC.cover r hr₀ hn] at this
      obtain ⟨i, hi⟩ := mem_iUnion.mp this
      by_cases hii : i = i₀
      · rw [hii, hsec r hr₀] at hi
        rcases lt_or_gt_of_ne (hzc (hHr hi)) with hT | hT
        · exact mem_iUnion.mpr ⟨.inr false, by rw [hAf]; exact ⟨hi.1, hi.2.1, hi.2.2.1, hT⟩⟩
        · exact mem_iUnion.mpr ⟨.inr true, by rw [hAt]; exact ⟨hi.1, hi.2.1, hT, hi.2.2.2⟩⟩
      · exact mem_iUnion.mpr ⟨.inl ⟨i, hii⟩, hi⟩
    · intro hz
      obtain ⟨j, hj⟩ := mem_iUnion.mp hz
      match j, hj with
      | .inl i, hj =>
        rw [hAl] at hj
        exact ⟨(hint z (ball_subset_ball hr.2 (X.G.sector_subset_ball i.1 hj))).mpr
          ⟨hsecI i.1 hj, fun hzt => absurd hzt (hnot i.1 i.2 z hj)⟩, X.G.sector_subset_ball i.1 hj⟩
      | .inr true, hj =>
        rw [hAt] at hj
        refine ⟨(hint z (ball_subset_ball hr.2 hj.1)).mpr ⟨hHI (hUH hj), fun _ => ?_⟩, hj.1⟩
        exact ne_of_gt hj.2.2.1
      | .inr false, hj =>
        rw [hAf] at hj
        refine ⟨(hint z (ball_subset_ball hr.2 hj.1)).mpr ⟨hHI (hLH hj), fun _ => ?_⟩, hj.1⟩
        exact ne_of_lt hj.2.2.2
  have hκr : ∀ κ : ℝ, |κ| ≤ 1 → |κ| * r < 2 := fun κ hκ => by nlinarith [abs_nonneg κ, hr.1]
  refine (encard_sectorsOf_of_partition (F := F') (A := A) (colA := colA) hU ?_ ?_ ?_ ?_ ?_ c).trans ?_
  · intro j
    match j with
    | .inl i => exact X.hC.isOpen r hr₀ _
    | .inr true => exact isOpen_hornSet v α σ κ₂ r
    | .inr false => exact isOpen_hornSet v α κ₁ σ r
  · intro j
    match j with
    | .inl i => exact X.hC.isPreconnected r hr₀ _
    | .inr true =>
      show IsPreconnected (hornSet v α σ κ₂ r)
      by_cases hlt : σ < κ₂
      · exact isPreconnected_hornSet v α hlt (hκr σ hσ) (hκr κ₂ h2)
      · rw [hornSet_eq_empty (not_lt.mp hlt)]; exact isPreconnected_empty
    | .inr false =>
      show IsPreconnected (hornSet v α κ₁ σ r)
      by_cases hlt : κ₁ < σ
      · exact isPreconnected_hornSet v α hlt (hκr κ₁ h1) (hκr σ hσ)
      · rw [hornSet_eq_empty (not_lt.mp hlt)]; exact isPreconnected_empty
  · intro j j' hjj'
    match j, j', hjj' with
    | .inl i, .inl i', hjj' =>
      exact X.hC.disjoint r hr₀ _ _ fun h' => hjj' (congrArg Sum.inl (Subtype.ext h'))
    | .inl i, .inr true, _ => exact (hHdisj i.1 i.2).mono_right hUH
    | .inl i, .inr false, _ => exact (hHdisj i.1 i.2).mono_right hLH
    | .inr true, .inl i', _ => exact ((hHdisj i'.1 i'.2).mono_right hUH).symm
    | .inr false, .inl i', _ => exact ((hHdisj i'.1 i'.2).mono_right hLH).symm
    | .inr true, .inr false, _ => exact hUL
    | .inr false, .inr true, _ => exact hUL.symm
    | .inr true, .inr true, hjj' => exact absurd rfl hjj'
    | .inr false, .inr false, hjj' => exact absurd rfl hjj'
  · intro j hj
    match j, hj with
    | .inl i, _ => exact X.hC.mem_closure_sector hr₀ _
    | .inr true, hj =>
      have hlt : σ < κ₂ := by
        by_contra hlt; rw [hAt, hornSet_eq_empty (not_lt.mp hlt)] at hj; exact not_nonempty_empty hj
      exact mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α hlt hr.1)
    | .inr false, hj =>
      have hlt : κ₁ < σ := by
        by_contra hlt; rw [hAf, hornSet_eq_empty (not_lt.mp hlt)] at hj; exact not_nonempty_empty hj
      exact mem_closure_of_mem_coneAt (mem_coneAt_hornSet v α hlt hr.1)
  · intro j z hz
    show F'.col z = colA j
    match j, hz with
    | .inl i, hz =>
      rw [hcol', shaveCol_of_not_mem (hnot i.1 i.2 z hz)]
      have := (X.hcol i.1 r hr₀ hz).2
      simp only [mem_preimage, mem_singleton_iff] at this
      exact this
    | .inr true, hz => exact (hcol' z).trans (shaveCol_of_above (hHr (hUH hz)) hz.2.2.1)
    | .inr false, hz =>
      refine (hcol' z).trans (shaveCol_of_not_above (hHr (hLH hz)) fun hT => ?_)
      have := hz.2.2.2; unfold TanAbove at hT; unfold TanBelow at this; linarith
  · have hset : {j | (A j).Nonempty ∧ colA j = c} = Sum.inl '' (Subtype.val ⁻¹' ({i | X.col i = c} \ {i₀})) := by
      ext j
      match j with
      | .inl i =>
        simp only [mem_setOf_eq, mem_image, Sum.inl.injEq, exists_eq_right, mem_preimage, Set.mem_sdiff,
          mem_singleton_iff]
        exact ⟨fun h' => ⟨h'.2, i.2⟩, fun h' => ⟨X.hC.sector_nonempty hr₀ _, h'.1⟩⟩
      | .inr true =>
        simp only [mem_setOf_eq, mem_image, reduceCtorEq, and_false, exists_false, iff_false, not_and]
        exact fun _ h' => hgc h'
      | .inr false =>
        simp only [mem_setOf_eq, mem_image, reduceCtorEq, and_false, exists_false, iff_false, not_and]
        exact fun _ h' => hhc h'
    rw [hset, Sum.inl_injective.encard_image,
      encard_preimage_of_injective_subset_range Subtype.val_injective (fun i hi => ⟨⟨i, hi.2⟩, rfl⟩)]
    have h1 := encard_sdiff_singleton_add_one (show i₀ ∈ {i | X.col i = c} from hci)
    rw [hm] at h1
    exact ENat.add_left_injective_of_ne_top (by simp) h1

/-- **SHAVE's colouring is locally constant off the new arcs**: in the tip off the `σ`-circle the side of the circle is locally
constant; off the tip, off its closure too, where the colouring is `F`'s. -/
theorem shave_hlc (X : F.Near v) {ρ : ℝ} (hs : X.Small ρ) {i₀ : Fin X.n}
    (hsec : ∀ r ∈ Ioc 0 X.r₀, X.G.sector v r i₀ = hornSet v α κ₁ κ₂ r) (hσ : |σ| ≤ 1) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ univ (shaveArcs v α κ₁ κ₂ σ ρ), a.carrier →
      ∀ᶠ y in 𝓝 x, F.shaveCol v α κ₁ κ₂ σ ρ g h y = F.shaveCol v α κ₁ κ₂ σ ρ g h x := by
  have hn0 : 0 < X.n := i₀.pos
  have hσρ : |σ| * ρ ≤ 2 := by nlinarith [hs.2.2.2, abs_nonneg σ, hs.1]
  refine surgery_hlc_of X.hG hs.1 (fun z hz => shaveCol_of_not_mem fun hz' => hz (ball_subset_closedBall hz'.1))
    (sphere_subset_newArcs hs) fun x hx hxA => ?_
  have hK : (univ : Set (Fin X.n)).Nonempty := ⟨⟨0, hn0⟩, trivial⟩
  rw [mem_newArcs_iff hs hK hx, mem_shaveArcs_carrier] at hxA
  push Not at hxA
  obtain ⟨hxv, hxb, hxE⟩ := hxA
  have hxI : x ∈ F.interiorPts := (X.mem_interiorPts_iff hs hx hxv).mpr fun i => hxb hxv i trivial
  by_cases hxt : x ∈ hornSet v α κ₁ κ₂ ρ
  · have hT : tanHeight σ (frameX v α x) (frameY v α x) ≠ 0 := fun hT => by
      have hσ₁' : κ₁ < σ := lt_of_le_of_ne hσ₁ fun h' => by
        have := hxt.2.2.1; unfold TanAbove at this; rw [h'] at this; linarith
      have hσ₂' : σ < κ₂ := lt_of_le_of_ne hσ₂ fun h' => by
        have := hxt.2.2.2; unfold TanBelow at this; rw [← h'] at this; linarith
      exact hxE hσ₁' hσ₂' ((mem_germArc_iff_of_mem_hornSet hs.1.le hσρ hxt).mpr hT)
    have hcont : Continuous fun z => tanHeight σ (frameX v α z) (frameY v α z) := by
      unfold tanHeight frameX frameY; fun_prop
    have htip : ∀ᶠ y in 𝓝 x, y ∈ hornSet v α κ₁ κ₂ ρ := (isOpen_hornSet v α κ₁ κ₂ ρ).mem_nhds hxt
    rcases lt_or_gt_of_ne hT with hlt | hgt
    · have hev : ∀ᶠ y in 𝓝 x, tanHeight σ (frameX v α y) (frameY v α y) < 0 :=
        (hcont.tendsto x).eventually (gt_mem_nhds hlt)
      filter_upwards [htip, hev] with y hy hy'
      rw [shaveCol_of_not_above hy (fun h' => by unfold TanAbove at h'; linarith),
        shaveCol_of_not_above hxt (fun h' => by unfold TanAbove at h'; linarith)]
    · have hev : ∀ᶠ y in 𝓝 x, 0 < tanHeight σ (frameX v α y) (frameY v α y) :=
        (hcont.tendsto x).eventually (lt_mem_nhds hgt)
      filter_upwards [htip, hev] with y hy hy'
      rw [shaveCol_of_above hy hy', shaveCol_of_above hxt hgt]
  · have hS : F.IsSector v ρ (hornSet v α κ₁ κ₂ ρ) := by
      rw [← hsec ρ hs.mem_Ioc]; exact (X.hC.isSector_iff hn0 hs.mem_Ioc).mpr ⟨i₀, rfl⟩
    have hxcl : x ∉ closure (hornSet v α κ₁ κ₂ ρ) := fun hcl =>
      not_mem_interiorPts_of_mem_closure_sector hS hx hcl hxt hxI
    have hev : ∀ᶠ y in 𝓝 x, y ∉ hornSet v α κ₁ κ₂ ρ := by
      filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hxcl] with y hy hy' using hy (subset_closure hy')
    filter_upwards [F.locallyConstant x hxI.1 hxI.2, hev] with y hy hy'
    rw [shaveCol_of_not_mem hy', shaveCol_of_not_mem hxt, hy]

end Near

/-- **SHAVE when neither flank is the horn's colour** (§ 6.3's case 3): recolouring the horn's tip `g` above the tangent arc of
curvature `σ` and `h` below it, with that arc added when `κ₁ < σ < κ₂`, removes the horn's `c`-sector. -/
theorem exists_shave_recolour (hF : F.Valid) (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn : F.HasSectors v c (n + 1))
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1) (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h)
    (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂) (hgc : g ≠ c) (hhc : h ≠ c)
    (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨i₀, hβ, hnβ, hκ, hnκ, hci, hsec⟩ := X.horn_index hH
  have hn0 : 0 < X.n := i₀.pos
  obtain ⟨p, hp⟩ := (Finite.injective_iff_surjective.mp BranchGerms.next_injective) i₀
  have hcg : X.col (BranchGerms.next i₀) = g :=
    IsSectorChart.col_eq_of_flankAbove X.hC X.hs₀ X.hord X.hcol₀ (by rw [← BranchGerms.e_nextβ, hnβ, hβ])
      (by rw [← BranchGerms.nextκ_eq, hnκ]) hg
  have hch : X.col p = h :=
    IsSectorChart.col_eq_of_flankBelow X.hC X.hs₀ X.hord X.hcol₀ (by rw [BranchGerms.e_nextβ, hp, hβ])
      (by rw [BranchGerms.nextκ_eq, hp, hκ]) hh
  have hσ : |σ| ≤ 1 := abs_le.mpr ⟨by linarith, by linarith⟩
  have hκ1 : |κ₁| ≤ 1 := abs_le.mpr ⟨h1, by linarith [hH.1]⟩
  have hκ2 : |κ₂| ≤ 1 := abs_le.mpr ⟨by linarith [hH.1], h2⟩
  obtain ⟨ρ, hs, hcl⟩ := (X.eventually_small.and hclear).exists
  have hσρ : |σ| * ρ ≤ 2 := by nlinarith [hs.2.2.2, abs_nonneg σ, hs.1]
  have hE : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.Nondegenerate := shaveArcs_nondegenerate hs.1
  have hEf := shaveArcs_finite v α κ₁ κ₂ σ ρ
  have hEin : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, a.carrier ⊆ closedBall v ρ := shaveArcs_subset_closedBall hs.1.le hσρ
  have hEu : ∀ a ∈ shaveArcs v α κ₁ κ₂ σ ρ, ¬ a.IsUnitArc := shaveArcs_not_isUnitArc h1 h2
  have hcol : ∀ z ∉ closedBall v ρ, F.shaveCol v α κ₁ κ₂ σ ρ g h z = F.col z := fun z hz =>
    shaveCol_of_not_mem fun hz' => hz (ball_subset_closedBall hz'.1)
  have hlc := X.shave_hlc (g := g) (h := h) hs hsec hσ hσ₁ hσ₂
  set F' := X.move hs univ (shaveArcs v α κ₁ κ₂ σ ρ) (F.shaveCol v α κ₁ κ₂ σ ρ g h) hE hEf hlc with hF'
  have hint : ∀ z ∈ ball v ρ, z ∈ F'.interiorPts ↔
      z ∈ F.interiorPts ∧ (z ∈ hornSet v α κ₁ κ₂ ρ → tanHeight σ (frameX v α z) (frameY v α z) ≠ 0) :=
    fun z hz => Near.shave_mem_interiorPts_iff hn0 hσ hσ₁ hσ₂ hz
  refine ⟨ρ, hs.1, F', ?_, Near.move_agreesOff hEin hcol, Near.move_ringArcsWithin hEu,
    Near.move_condition5 (fun a ha q => Arc.finite_inter_sphere_of_not_isUnitArc (hE a ha) (hEu a ha) q),
    Near.shave_hasSectors hs hsec hgc hhc hσ hκ1 hκ2 hσ₁ hσ₂ (X.encard_col_eq hn0 hn) hci hint (fun z => rfl), ?_, ?_⟩
  · refine Near.move_valid hF hEin hcol fun z hz hzI => ?_
    obtain ⟨hzF, -⟩ := (hint z hz).mp hzI
    by_cases hzt : z ∈ hornSet v α κ₁ κ₂ ρ
    · by_cases hT : TanAbove v α σ z
      · rw [shaveCol_of_above hzt hT]; exact (hcl z hzt).1 hT
      · rw [shaveCol_of_not_above hzt hT]; exact (hcl z hzt).2 hT
    · rw [shaveCol_of_not_mem hzt]; exact isClear_col hF hzF
  · refine Near.move_coloursAt_self fun z hz hzI => ?_
    by_cases hzt : z ∈ hornSet v α κ₁ κ₂ ρ
    · left
      rcases shaveCol_mem (F := F) (σ := σ) (g := g) (h := h) hzt with h' | h'
      · rw [h', ← hcg]; exact closure_mono (X.hcol₀ _) (X.hC.mem_closure_sector X.hs₀ _)
      · rw [h', ← hch]; exact closure_mono (X.hcol₀ _) (X.hC.mem_closure_sector X.hs₀ _)
    · right
      exact ⟨((hint z hz).mp hzI).1, shaveCol_of_not_mem hzt⟩
  · intro x hx
    have hsub := Near.move_coloursAt_sphere (h := hs) (hE := hE) (hEf := hEf) (hlc := hlc)
      hEin hcol (R := hornSet v α κ₁ κ₂ ρ) (C := {g, h})
      (fun z hz hzI hzR => ⟨((hint z hz).mp hzI).1, shaveCol_of_not_mem hzR⟩)
      (fun z hz _ => by
        rcases shaveCol_mem (F := F) (σ := σ) (g := g) (h := h) hz.1 with h' | h' <;> rw [h'] <;> simp) x
    have hxv : x ≠ v := fun h' => by rw [h', mem_sphere, dist_self] at hx; linarith [hs.1]
    have hxs : x ∈ ball v X.s₀ := by rw [mem_ball]; rw [mem_sphere] at hx; rw [hx]; exact hs.2.1
    by_cases hxR : x ∈ closure (hornSet v α κ₁ κ₂ ρ)
    · have hcl' : x ∈ closure (X.G.sector v X.s₀ i₀) :=
        closure_mono (by rw [← hsec ρ hs.mem_Ioc]; exact X.G.sector_mono hs.2.1.le i₀) hxR
      have hF3 := X.coloursAt_subset_of_mem_closure_sector hp hcl' hxv hxs
      have hsub3 : F'.coloursAt x ⊆ {h, c, g} := by
        intro j hj
        rcases hsub hj with h' | ⟨-, h'⟩
        · have := hF3 h'; rwa [hch, hci, hcg] at this
        · rcases h' with rfl | rfl
          · exact Or.inr (Or.inr rfl)
          · exact Or.inl rfl
      calc (F'.coloursAt x).ncard ≤ ({h, c, g} : Set (Fin k)).ncard := ncard_le_ncard hsub3 (toFinite _)
        _ ≤ ({c, g} : Set (Fin k)).ncard + 1 := ncard_insert_le _ _
        _ ≤ (({g} : Set (Fin k)).ncard + 1) + 1 := by gcongr; exact ncard_insert_le _ _
        _ = 3 := by rw [ncard_singleton]
    · have hsub2 : F'.coloursAt x ⊆ F.coloursAt x := fun j hj => (hsub hj).resolve_right fun h' => hxR h'.1
      exact (ncard_le_ncard hsub2 (toFinite _)).trans
        ((X.hC.ncard_coloursAt_le_two X.hs₀ X.hdisj hxv hxs).trans (by norm_num))

end ArcMap

end HadwigerNelson.Plane
