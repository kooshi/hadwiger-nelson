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

end HadwigerNelson.Plane
