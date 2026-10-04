import Proofs.HadwigerNelson.Plane.ValidMap.Moves

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The chart near its point: germs apart, the closure of a sector, two colours at a point -/

/-- **Distinct germs of a sorted chart are distinct as germs**: two indices with one direction (mod `2π`) have different curvatures. -/
theorem BranchGerms.Sorted.κ_ne {n : ℕ} {G : BranchGerms n} (hS : G.Sorted) {i j : Fin n} (hij : i ≠ j)
    (hβ : e (G.β i) = e (G.β j)) : G.κ i ≠ G.κ j := by
  have hπ := Real.pi_pos
  have hM := hS.mono
  -- the claim for `i < j`
  have key : ∀ a b : Fin n, a < b → e (G.β a) = e (G.β b) → G.κ a ≠ G.κ b := by
    intro a b hab he hκ
    rcases hS.1 a b hab with hlt | ⟨-, hκlt⟩
    · obtain ⟨m, hm⟩ := e_eq_e_iff.mp he.symm
      have hb2 := hM.le_two_pi b
      have ha0 := hM.zero_le a
      have hm1 : (1 : ℝ) ≤ m := by
        have : (0 : ℝ) < m := by nlinarith
        have : (0 : ℤ) < m := by exact_mod_cast this
        exact_mod_cast this
      have hm1' : (m : ℝ) ≤ 1 := by nlinarith
      have hbeq : G.β b = G.β ⟨0, a.pos⟩ + 2 * π := by nlinarith
      have haeq : G.β a = G.β ⟨0, a.pos⟩ := by nlinarith
      set l : Fin n := ⟨n - 1, by omega⟩ with hl
      have hbl : b ≤ l := by rw [Fin.le_def]; simp only [hl]; omega
      have hβl : G.β l = G.β ⟨0, a.pos⟩ + 2 * π := le_antisymm (hM.le_two_pi l) (hbeq ▸ hM.le_of_le hbl)
      have hnext : G.nextβ l = G.β ⟨0, a.pos⟩ + 2 * π := by
        unfold BranchGerms.nextβ; rw [dif_neg (by simp only [hl]; omega)]
      have hκl : G.κ l < G.κ ⟨0, a.pos⟩ := by
        rcases hS.2 l with h | ⟨-, h⟩
        · rw [hnext, hβl] at h; exact absurd h (lt_irrefl _)
        · unfold BranchGerms.nextκ at h; rwa [dif_neg (by simp only [hl]; omega)] at h
      have hκbl : G.κ b ≤ G.κ l := by
        rcases eq_or_lt_of_le hbl with h | h
        · rw [h]
        · rcases hS.1 b l h with h' | ⟨-, h'⟩
          · rw [hβl, hbeq] at h'; exact absurd h' (lt_irrefl _)
          · exact h'.le
      have hκa0 : G.κ ⟨0, a.pos⟩ ≤ G.κ a := by
        by_cases h0 : a = ⟨0, a.pos⟩
        · rw [← h0]
        · have h0' : (⟨0, a.pos⟩ : Fin n) < a := by
            rw [Fin.lt_def]; simp only; exact Nat.pos_of_ne_zero (fun h => h0 (Fin.ext h))
          rcases hS.1 _ a h0' with h' | ⟨-, h'⟩
          · rw [haeq] at h'; exact absurd h' (lt_irrefl _)
          · exact h'.le
      linarith
    · exact hκlt.ne hκ
  rcases lt_or_gt_of_ne hij with h | h
  · exact key i j h hβ
  · exact fun hk => key j i h hβ.symm hk.symm

/-- **Two different germs never meet at one small distance**, in any normalisation: unless `e β = e β'` and `κ = κ'`, the
branches of `(β, κ)` and `(β', κ')` miss each other at every distance in some `(0, ε)`. -/
theorem exists_germDir_ne_of_ne {β β' κ κ' : ℝ} (h : ¬ (e β = e β' ∧ κ = κ')) :
    ∃ ε > 0, ∀ s ∈ Ioo 0 ε, e (germDir β κ s) ≠ e (germDir β' κ' s) := by
  have hmem : ∀ x : ℝ, toIcoMod Real.two_pi_pos 0 x ∈ Ico 0 (2 * π) := fun x => by
    simpa using toIcoMod_mem_Ico Real.two_pi_pos 0 x
  have he : ∀ x y : ℝ, e (toIcoMod Real.two_pi_pos 0 x + y) = e (x + y) := e_toIcoMod_add
  have hne : ((toIcoMod Real.two_pi_pos 0 β, κ) : ℝ × ℝ) ≠ (toIcoMod Real.two_pi_pos 0 β', κ') := by
    intro heq
    apply h
    refine ⟨?_, congrArg Prod.snd heq⟩
    have h1 := congrArg Prod.fst heq
    simp only at h1
    have a := he β 0
    have b := he β' 0
    rw [add_zero, add_zero] at a b
    rw [← a, ← b, h1]
  obtain ⟨ε, hε, hs⟩ := exists_germDir_ne (hmem β) (hmem β') hne
  refine ⟨ε, hε, fun s hs' heq => hs s hs' ?_⟩
  simp only [germDir] at heq ⊢
  rw [he, he]; exact heq

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Near its point a chart's germs are apart and ordered**: for all small `s`, distinct germs have distinct directions at
distance `s` and each germ's direction lies below the next one's. -/
theorem IsSectorChart.eventually_ord {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) :
    ∃ s₀ > 0, s₀ ≤ r₀ ∧ (∀ i j, i ≠ j → ∀ s ∈ Ioo 0 s₀, e (G.dir i s) ≠ e (G.dir j s)) ∧
      ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s := by
  have hpair : ∀ i j : Fin n, ∀ᶠ s in 𝓝[>] (0 : ℝ), i ≠ j → e (G.dir i s) ≠ e (G.dir j s) := by
    intro i j
    by_cases hij : i = j
    · exact Filter.Eventually.of_forall fun _ h => absurd hij h
    · have hg : ¬ (e (G.β i) = e (G.β j) ∧ G.κ i = G.κ j) := fun ⟨h1, h2⟩ => hC.sorted.κ_ne hij h1 h2
      obtain ⟨ε, hε, hs⟩ := exists_germDir_ne_of_ne hg
      filter_upwards [Ioo_mem_nhdsGT hε] with s hs' _
      exact hs s hs'
  have hall : ∀ᶠ s in 𝓝[>] (0 : ℝ), ∀ i j : Fin n, i ≠ j → e (G.dir i s) ≠ e (G.dir j s) :=
    Filter.eventually_all.mpr fun i => Filter.eventually_all.mpr fun j => hpair i j
  obtain ⟨s₁, hs₁, hsub⟩ := (mem_nhdsGT_iff_exists_Ioo_subset).mp hall
  set s₀ := min s₁ r₀ with hs₀
  have hs₀pos : 0 < s₀ := lt_min hs₁ hC.pos
  have hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 s₀, e (G.dir i s) ≠ e (G.dir j s) := fun i j hij s hs =>
    hsub ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩ i j hij
  have hcurv : ∀ i, |G.κ i| * s₀ < 2 := fun i =>
    lt_of_le_of_lt (mul_le_mul_of_nonneg_left (min_le_right _ _) (abs_nonneg _)) (hC.curv i)
  exact ⟨s₀, hs₀pos, min_le_right _ _, hdisj, G.dir_lt_nextDir hC.sorted hcurv hdisj⟩

end ArcMap

/-- **The closure of a chart sector** (polar form): a point of `cl (G.sector v r i)` other than `v` is `v + s e(φ)` with
`s = ‖x − v‖ ≤ r` and `φ` between the two germs' directions at distance `s`, ends included. -/
theorem BranchGerms.mem_closure_sector {n : ℕ} {G : BranchGerms n} {v : ℂ} {r : ℝ} {i : Fin n} {x : ℂ}
    (hx : x ∈ closure (G.sector v r i)) :
    ‖x - v‖ ≤ r ∧ ∃ φ ∈ Icc (G.dir i ‖x - v‖) (G.nextDir i ‖x - v‖), x = v + (‖x - v‖ : ℂ) * e φ := by
  set f : ℝ × ℝ → ℂ := fun p => v + (p.1 : ℂ) * e p.2 with hf
  have hfc : Continuous f := continuous_const.add ((Complex.continuous_ofReal.comp continuous_fst).mul
    (continuous_e.comp continuous_snd))
  set K : Set (ℝ × ℝ) := {p | p.1 ∈ Icc 0 r ∧ G.dir i p.1 ≤ p.2 ∧ p.2 ≤ G.nextDir i p.1} with hK
  have hKc : IsClosed K := by
    refine (isClosed_Icc.preimage continuous_fst).inter ((isClosed_le ((G.continuous_dir i).comp continuous_fst)
      continuous_snd).inter (isClosed_le continuous_snd ((G.continuous_nextDir i).comp continuous_fst)))
  have hKsub : K ⊆ Icc 0 r ×ˢ Icc (G.β i - π / 2) (G.nextβ i + π / 2) := by
    rintro ⟨s, φ⟩ ⟨hs, h1, h2⟩
    refine ⟨hs, ?_, ?_⟩
    · have := Real.neg_pi_div_two_le_arcsin (G.κ i * s / 2)
      have h1' : G.dir i s ≤ φ := h1
      unfold BranchGerms.dir germDir at h1'; linarith
    · have := Real.arcsin_le_pi_div_two (G.nextκ i * s / 2)
      have h2' : φ ≤ G.nextDir i s := h2
      unfold BranchGerms.nextDir germDir at h2'; linarith
  have hKcpt : IsCompact K := (isCompact_Icc.prod isCompact_Icc).of_isClosed_subset hKc hKsub
  have hsub : G.sector v r i ⊆ f '' K := by
    rintro z ⟨s, hs, φ, hφ, rfl⟩
    exact ⟨(s, φ), ⟨⟨hs.1.le, hs.2.le⟩, hφ.1.le, hφ.2.le⟩, rfl⟩
  have hxK : x ∈ f '' K := closure_minimal hsub (hKcpt.image hfc).isClosed hx
  obtain ⟨⟨s, φ⟩, ⟨hs, h1, h2⟩, rfl⟩ := hxK
  have hn : ‖f (s, φ) - v‖ = s := by
    simp only [hf, add_sub_cancel_left]; exact norm_mul_e hs.1 φ
  rw [hn]
  exact ⟨hs.2, φ, ⟨h1, h2⟩, rfl⟩

/-- The germ after `i` is `next i`'s: `next` is injective, its inverse the germ before. -/
theorem BranchGerms.next_injective {n : ℕ} : Function.Injective (BranchGerms.next : Fin n → Fin n) := by
  intro i j h
  unfold BranchGerms.next at h
  split_ifs at h with h1 h2 h2 <;> simp only [Fin.mk.injEq] at h <;> apply Fin.ext <;> omega

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- An interior point carries only its own colour. -/
theorem coloursAt_subset_of_mem_interiorPts {x : ℂ} (hx : x ∈ F.interiorPts) : F.coloursAt x ⊆ {F.col x} := by
  intro j hj
  have hev : ∀ᶠ y in 𝓝 x, F.col y = F.col x := F.locallyConstant x hx.1 hx.2
  obtain ⟨y, hyx, hyj⟩ := (mem_closure_iff_frequently.mp hj).and_eventually hev |>.exists
  rw [mem_singleton_iff, ← hyj]
  exact hyx.2.symm

/-- **A chart's branch point lies in `Γ`.** -/
theorem IsSectorChart.branchPt_mem_Γ {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (m : Fin n) {s : ℝ} (hs : s ∈ Ioo 0 r₀) : branchPt v (G.β m) (G.κ m) s ∈ F.Γ := by
  have h : branchPt v (G.β m) (G.κ m) s ∈ (F.Γ ∩ ball v r₀) \ {v} := by
    rw [hC.branches]; exact mem_iUnion.mpr ⟨m, s, hs, rfl⟩
  exact h.1.1

/-- **A point of the punctured chart ball off the interior points is a branch point.** -/
theorem IsSectorChart.exists_branchPt_eq {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    {x : ℂ} (hx0 : x ≠ v) (hxr : x ∈ ball v r₀) (hxI : x ∉ F.interiorPts) :
    ∃ m, x = branchPt v (G.β m) (G.κ m) ‖x - v‖ := by
  have hxΓ : x ∈ (F.Γ ∩ ball v r₀) \ {v} := by
    refine ⟨⟨⟨hC.subdom hxr, ?_⟩, hxr⟩, hx0⟩
    by_contra h
    exact hxI ⟨hC.subdom hxr, h⟩
  rw [hC.branches] at hxΓ
  obtain ⟨m, s, hs, rfl⟩ := mem_iUnion.mp hxΓ
  exact ⟨m, by rw [norm_branchPt_sub v _ _ hs.1.le]⟩

/-- **Two branch points at one small distance are one germ's** (the germs are apart there). -/
theorem eq_of_branchPt_eq {n : ℕ} {G : BranchGerms n} {v : ℂ} {s₀ : ℝ}
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 s₀, e (G.dir i s) ≠ e (G.dir j s)) {i j : Fin n} {s : ℝ} (hs : s ∈ Ioo 0 s₀)
    (h : branchPt v (G.β i) (G.κ i) s = branchPt v (G.β j) (G.κ j) s) : i = j := by
  by_contra hij
  rw [branchPt_eq, branchPt_eq] at h
  exact hdisj i j hij s hs ((polar_eq_iff hs.1 hs.1).mp h).2

/-- **The closure of a chart sector, by cases**: a point of `cl (G.sector v s₀ i)` in the punctured ball of radius `s₀` is in the
sector, or is the branch point of germ `i` or of the next germ at its distance. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.closure_sector_cases {n : ℕ} {G : BranchGerms n} {v : ℂ} {s₀ : ℝ} {i : Fin n} {x : ℂ}
    (hx : x ∈ closure (G.sector v s₀ i)) (hx0 : 0 < ‖x - v‖) (hxs : ‖x - v‖ < s₀) :
    x ∈ G.sector v s₀ i ∨ x = branchPt v (G.β i) (G.κ i) ‖x - v‖ ∨
      x = branchPt v (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) ‖x - v‖ := by
  obtain ⟨-, φ, ⟨h1, h2⟩, hxφ⟩ := G.mem_closure_sector hx
  rcases eq_or_lt_of_le h1 with h1 | h1
  · right; left
    rw [branchPt_eq]
    change x = v + (‖x - v‖ : ℂ) * e (G.dir i ‖x - v‖)
    rw [h1]; exact hxφ
  rcases eq_or_lt_of_le h2 with h2 | h2
  · right; right
    rw [branchPt_eq]
    change x = v + (‖x - v‖ : ℂ) * e (G.dir (BranchGerms.next i) ‖x - v‖)
    rw [← BranchGerms.e_nextDir, ← h2]; exact hxφ
  · left; exact ⟨‖x - v‖, ⟨hx0, hxs⟩, φ, ⟨h1, h2⟩, hxφ⟩

/-- **A branch point lies in the closure only of the sectors on its two sides**: the sector after its germ and the one before. -/
theorem IsSectorChart.eq_or_next_eq_of_mem_closure {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hs₀ : s₀ ≤ r₀)
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 s₀, e (G.dir i s) ≠ e (G.dir j s)) {m i : Fin n} {s : ℝ} (hs : s ∈ Ioo 0 s₀)
    (hx : branchPt v (G.β m) (G.κ m) s ∈ closure (G.sector v s₀ i)) : i = m ∨ BranchGerms.next i = m := by
  have hn : 0 < n := m.pos
  have hns := norm_branchPt_sub v (G.β m) (G.κ m) hs.1.le
  have hx0 : 0 < ‖branchPt v (G.β m) (G.κ m) s - v‖ := by rw [hns]; exact hs.1
  have hxs : ‖branchPt v (G.β m) (G.κ m) s - v‖ < s₀ := by rw [hns]; exact hs.2
  rcases G.closure_sector_cases hx hx0 hxs with h | h | h
  · exfalso
    have hI := hC.sector_subset_interiorPts hn ⟨hs.1.trans hs.2, hs₀⟩ i h
    exact hI.2 (hC.branchPt_mem_Γ m ⟨hs.1, hs.2.trans_le hs₀⟩).2
  · rw [hns] at h; exact Or.inl (eq_of_branchPt_eq hdisj hs h.symm)
  · rw [hns] at h; exact Or.inr (eq_of_branchPt_eq hdisj hs h.symm)

/-- **A sector point lies in the closure of no other sector.** -/
theorem IsSectorChart.eq_of_mem_closure_of_mem {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hs₀ : s₀ ∈ Ioc 0 r₀) {i j : Fin n} {x : ℂ} (hxj : x ∈ G.sector v s₀ j)
    (hx : x ∈ closure (G.sector v s₀ i)) : i = j := by
  have hn : 0 < n := i.pos
  obtain ⟨hs, -⟩ := G.mem_sector_iff.mp hxj
  have hI := hC.sector_subset_interiorPts hn hs₀ j hxj
  rcases G.closure_sector_cases hx hs.1 hs.2 with h | h | h
  · by_contra hij
    exact disjoint_left.mp (hC.disjoint s₀ hs₀ i j hij) h hxj
  · have hΓ := hC.branchPt_mem_Γ i ⟨hs.1, hs.2.trans_le hs₀.2⟩
    rw [← h] at hΓ
    exact absurd hΓ.2 hI.2
  · have hΓ := hC.branchPt_mem_Γ (BranchGerms.next i) ⟨hs.1, hs.2.trans_le hs₀.2⟩
    rw [← h] at hΓ
    exact absurd hΓ.2 hI.2

/-- **The colours at a point of the punctured chart ball are its sectors' colours**: those of the sectors whose closure holds it. -/
theorem IsSectorChart.coloursAt_subset_image {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hn : 0 < n) (hs₀ : s₀ ∈ Ioc 0 r₀) {col : Fin n → Fin k}
    (hcol : ∀ i, G.sector v s₀ i ⊆ F.region (col i)) {x : ℂ} (hxs : x ∈ ball v s₀) :
    F.coloursAt x ⊆ col '' {i | x ∈ closure (G.sector v s₀ i)} := by
  intro j hj
  have hj : x ∈ closure (F.region j) := hj
  have hj' : x ∈ closure (F.region j ∩ ball v s₀) := by
    rw [mem_closure_iff_nhds] at hj ⊢
    intro t ht
    obtain ⟨y, hyt, hyj⟩ := hj (t ∩ ball v s₀) (inter_mem ht (isOpen_ball.mem_nhds hxs))
    exact ⟨y, hyt.1, hyj, hyt.2⟩
  have hsub : F.region j ∩ ball v s₀ ⊆ ⋃ i, (G.sector v s₀ i ∩ F.region j) := by
    intro y ⟨hyj, hyb⟩
    have : y ∈ ball v s₀ ∩ F.interiorPts := ⟨hyb, hyj.1⟩
    rw [hC.cover s₀ hs₀ hn] at this
    obtain ⟨i, hi⟩ := mem_iUnion.mp this
    exact mem_iUnion.mpr ⟨i, hi, hyj⟩
  have := closure_mono hsub hj'
  rw [closure_iUnion_of_finite] at this
  obtain ⟨i, hi⟩ := mem_iUnion.mp this
  refine ⟨i, closure_mono inter_subset_left hi, ?_⟩
  obtain ⟨y, hy⟩ : (G.sector v s₀ i ∩ F.region j).Nonempty := by
    by_contra h
    rw [not_nonempty_iff_eq_empty] at h
    rw [h, closure_empty] at hi
    exact hi
  have h1 := (hcol i hy.1).2
  have h2 := hy.2.2
  simp only [mem_preimage, mem_singleton_iff] at h1 h2
  rw [← h1, h2]

/-- **At most two colours at a point of the punctured chart ball**, where the germs are apart. -/
theorem IsSectorChart.ncard_coloursAt_le_two {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hs₀ : s₀ ∈ Ioc 0 r₀)
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 s₀, e (G.dir i s) ≠ e (G.dir j s)) {x : ℂ} (hx0 : x ≠ v)
    (hxs : x ∈ ball v s₀) : (F.coloursAt x).ncard ≤ 2 := by
  have hxr : x ∈ ball v r₀ := ball_subset_ball hs₀.2 hxs
  rcases Nat.eq_zero_or_pos n with hn | hn
  · have hI : x ∈ F.interiorPts := hC.empty hn hxr
    calc (F.coloursAt x).ncard ≤ ({F.col x} : Set (Fin k)).ncard := ncard_le_ncard (coloursAt_subset_of_mem_interiorPts hI)
      _ ≤ 2 := by rw [ncard_singleton]; norm_num
  choose col hcol using hC.exists_col
  have hcol' : ∀ i, G.sector v s₀ i ⊆ F.region (col i) := fun i => hcol i s₀ hs₀
  have hsub := hC.coloursAt_subset_image hn hs₀ hcol' hxs
  have hx0' : 0 < ‖x - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hx0)
  have hxs' : ‖x - v‖ < s₀ := by rw [mem_ball, dist_eq_norm] at hxs; exact hxs
  -- the sectors whose closure holds `x`: one, or the two beside a branch
  obtain ⟨a, b, hab⟩ : ∃ a b : Fin n, {i | x ∈ closure (G.sector v s₀ i)} ⊆ {a, b} := by
    by_cases hI : x ∈ F.interiorPts
    · have : x ∈ ball v s₀ ∩ F.interiorPts := ⟨hxs, hI⟩
      rw [hC.cover s₀ hs₀ hn] at this
      obtain ⟨j, hj⟩ := mem_iUnion.mp this
      exact ⟨j, j, fun i hi => Or.inl (hC.eq_of_mem_closure_of_mem hs₀ hj hi)⟩
    · obtain ⟨m, hm⟩ := hC.exists_branchPt_eq hx0 hxr hI
      obtain ⟨p, hp⟩ : ∃ p : Fin n, BranchGerms.next p = m := by
        have hsurj : Function.Surjective (BranchGerms.next : Fin n → Fin n) :=
          Finite.injective_iff_surjective.mp BranchGerms.next_injective
        exact hsurj m
      refine ⟨m, p, fun i hi => ?_⟩
      rw [mem_setOf_eq, hm] at hi
      rcases hC.eq_or_next_eq_of_mem_closure hs₀.2 hdisj ⟨hx0', hxs'⟩ hi with h | h
      · exact Or.inl h
      · exact Or.inr (BranchGerms.next_injective (h.trans hp.symm))
  calc (F.coloursAt x).ncard ≤ (col '' {i | x ∈ closure (G.sector v s₀ i)}).ncard := ncard_le_ncard hsub (toFinite _)
    _ ≤ (col '' {a, b}).ncard := ncard_le_ncard (image_mono hab) (toFinite _)
    _ ≤ ({a, b} : Set (Fin n)).ncard := ncard_image_le (toFinite _)
    _ ≤ 2 := (ncard_insert_le a {b}).trans (by rw [ncard_singleton])

end ArcMap

/-! ## An arc's pieces outside a ball about one of its points (the surgery's old arcs) -/

namespace Arc

/-- The parametrisation of an arc: the segment's affine parameter, or the circle's angle. -/
noncomputable def pt : Arc → ℝ → ℂ
  | seg p q, t => p + (t : ℂ) * (q - p)
  | circ c R _ _, θ => c + (R : ℂ) * e θ

/-- The parameter interval of an arc. -/
def params : Arc → Set ℝ
  | seg _ _ => Icc 0 1
  | circ _ _ θ₀ θ₁ => Icc θ₀ θ₁

/-- The sub-arc over the parameters `[t₀, t₁]`. -/
noncomputable def sub : Arc → ℝ → ℝ → Arc
  | seg p q, t₀, t₁ => seg (p + (t₀ : ℂ) * (q - p)) (p + (t₁ : ℂ) * (q - p))
  | circ c R _ _, t₀, t₁ => circ c R t₀ t₁

theorem continuous_pt (a : Arc) : Continuous a.pt := by
  cases a with
  | seg p q => exact continuous_const.add (Complex.continuous_ofReal.mul continuous_const)
  | circ c R θ₀ θ₁ => exact continuous_const.add (continuous_const.mul continuous_e)

/-- An arc is the image of its parameter interval. -/
theorem carrier_eq_image (a : Arc) : a.carrier = a.pt '' a.params := by
  cases a with
  | seg p q =>
    show segment ℝ p q = _
    rw [segment_eq_image']
    simp only [params, pt, Complex.real_smul]
  | circ c R θ₀ θ₁ => rfl

/-- A sub-arc is the image of its parameters. -/
theorem carrier_sub (a : Arc) {t₀ t₁ : ℝ} (h : t₀ ≤ t₁) : (a.sub t₀ t₁).carrier = a.pt '' Icc t₀ t₁ := by
  cases a with
  | seg p q =>
    show segment ℝ _ _ = _
    rw [segment_eq_image']
    ext z
    simp only [mem_image, mem_Icc, pt, Complex.real_smul]
    constructor
    · rintro ⟨u, ⟨hu0, hu1⟩, rfl⟩
      refine ⟨t₀ + u * (t₁ - t₀), ⟨by nlinarith, by nlinarith⟩, ?_⟩
      push_cast; ring
    · rintro ⟨t, ⟨ht0, ht1⟩, rfl⟩
      rcases eq_or_lt_of_le h with heq | hlt
      · subst heq
        have : t = t₀ := le_antisymm ht1 ht0
        subst this
        exact ⟨0, ⟨le_rfl, zero_le_one⟩, by push_cast; ring⟩
      · refine ⟨(t - t₀) / (t₁ - t₀), ⟨div_nonneg (by linarith) (by linarith), (div_le_one (by linarith)).mpr (by linarith)⟩, ?_⟩
        have hne : ((t₁ : ℂ) - t₀) ≠ 0 := by
          rw [← Complex.ofReal_sub]; exact_mod_cast (sub_pos.mpr hlt).ne'
        push_cast
        field_simp
        ring
  | circ c R θ₀ θ₁ => rfl

/-- A sub-arc over a non-trivial sub-interval of a non-degenerate arc's parameters is non-degenerate. -/
theorem nondegenerate_sub {a : Arc} (ha : a.Nondegenerate) {t₀ t₁ : ℝ} (hlt : t₀ < t₁) (hsub : Icc t₀ t₁ ⊆ a.params) :
    (a.sub t₀ t₁).Nondegenerate := by
  cases a with
  | seg p q =>
    show p + (t₀ : ℂ) * (q - p) ≠ p + (t₁ : ℂ) * (q - p)
    intro h
    have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm ha)
    have : ((t₀ : ℂ) - t₁) * (q - p) = 0 := by linear_combination h
    rcases mul_eq_zero.mp this with h' | h'
    · have : (t₀ : ℝ) = t₁ := by exact_mod_cast sub_eq_zero.mp h'
      linarith
    · exact hqp h'
  | circ c R θ₀ θ₁ =>
    obtain ⟨hR, -, h2⟩ := ha
    have h0 := (hsub ⟨le_rfl, hlt.le⟩).1
    have h1 := (hsub ⟨hlt.le, le_rfl⟩).2
    exact ⟨hR, hlt, by linarith⟩

/-- The parameter of a point of the arc (a choice). -/
noncomputable def param (a : Arc) (v : ℂ) : ℝ := by
  classical
  exact if h : ∃ t ∈ a.params, a.pt t = v then h.choose else 0

theorem param_spec {a : Arc} {v : ℂ} (hv : v ∈ a.carrier) : a.param v ∈ a.params ∧ a.pt (a.param v) = v := by
  rw [carrier_eq_image] at hv
  have h : ∃ t ∈ a.params, a.pt t = v := hv
  unfold param
  rw [dif_pos h]
  exact h.choose_spec

/-- The two parameter intervals of `a` outside the open ball `B(v, ρ)`, `v` the point of parameter `a.param v`: for a segment,
the parameters at least `ρ/‖q − p‖` from `v`'s; for a circle of radius `R`, the angles at least `δ = 2 arcsin(ρ/2R)` from `v`'s
and at most `2π − δ`. -/
noncomputable def outerIv (v : ℂ) (ρ : ℝ) : Arc → Bool → ℝ × ℝ
  | a@(seg p q), b => if b then (0, a.param v - ρ / ‖q - p‖) else (a.param v + ρ / ‖q - p‖, 1)
  | a@(circ _ R θ₀ θ₁), b =>
      if b then (max θ₀ (a.param v - 2 * π + 2 * Real.arcsin (ρ / (2 * R))), a.param v - 2 * Real.arcsin (ρ / (2 * R)))
      else (a.param v + 2 * Real.arcsin (ρ / (2 * R)), min θ₁ (a.param v + 2 * π - 2 * Real.arcsin (ρ / (2 * R))))

/-- **The pieces of `a` outside `B(v, ρ)`**: the sub-arcs over the non-trivial outer parameter intervals. -/
noncomputable def outer (a : Arc) (v : ℂ) (ρ : ℝ) : Set Arc :=
  {b | ∃ j : Bool, (a.outerIv v ρ j).1 < (a.outerIv v ρ j).2 ∧ b = a.sub (a.outerIv v ρ j).1 (a.outerIv v ρ j).2}

theorem finite_outer (a : Arc) (v : ℂ) (ρ : ℝ) : (a.outer v ρ).Finite := by
  refine (Set.finite_range fun j : Bool => a.sub (a.outerIv v ρ j).1 (a.outerIv v ρ j).2).subset ?_
  rintro b ⟨j, -, rfl⟩
  exact ⟨j, rfl⟩

end Arc

/-- The chord between two points of a circle: `‖e θ − e θ'‖ = 2 |sin ((θ − θ')/2)|`. -/
theorem norm_e_sub_e_eq (θ θ' : ℝ) : ‖e θ - e θ'‖ = 2 * |Real.sin ((θ - θ') / 2)| := by
  have h := sq_norm_e_sub_e θ θ'
  have hc : Real.cos (θ - θ') = 1 - 2 * Real.sin ((θ - θ') / 2) ^ 2 := by
    rw [← Real.cos_two_mul_eq_one_sub]; ring_nf
  rw [hc] at h
  have h4 : ‖e θ - e θ'‖ ^ 2 = (2 * |Real.sin ((θ - θ') / 2)|) ^ 2 := by
    rw [h, mul_pow, sq_abs]; ring
  exact (pow_left_inj₀ (norm_nonneg _) (by positivity) two_ne_zero).mp h4

/-- `sin a ≤ |sin x|` on `[−π, π]` exactly between `a` and `π − a` in absolute value (`0 ≤ a ≤ π/2`). -/
theorem le_abs_sin_iff {a x : ℝ} (ha0 : 0 ≤ a) (ha : a ≤ π / 2) (hx : |x| ≤ π) :
    Real.sin a ≤ |Real.sin x| ↔ a ≤ |x| ∧ |x| ≤ π - a := by
  have hπ := Real.pi_pos
  have habs : |Real.sin x| = Real.sin |x| := by
    rcases le_or_gt 0 x with h | h
    · rw [abs_of_nonneg h, abs_of_nonneg (Real.sin_nonneg_of_nonneg_of_le_pi h (by rw [abs_of_nonneg h] at hx; exact hx))]
    · rw [abs_of_neg h, Real.sin_neg, abs_of_nonpos]
      exact Real.sin_nonpos_of_nonpos_of_neg_pi_le h.le (by rw [abs_of_neg h] at hx; linarith)
  rw [habs]
  set y := |x| with hy
  have hy0 : 0 ≤ y := abs_nonneg x
  constructor
  · intro h
    by_contra hc
    rw [not_and_or, not_le, not_le] at hc
    rcases hc with hc | hc
    · have := Real.sin_lt_sin_of_lt_of_le_pi_div_two (by linarith) ha hc
      linarith
    · have h1 : Real.sin y = Real.sin (π - y) := (Real.sin_pi_sub y).symm
      have := Real.sin_lt_sin_of_lt_of_le_pi_div_two (by linarith) ha (show π - y < a by linarith)
      linarith
  · rintro ⟨h1, h2⟩
    rcases le_or_gt y (π / 2) with hle | hgt
    · exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) hle h1
    · rw [← Real.sin_pi_sub y]
      exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) (by linarith) (by linarith)

/-- `|sin x| ≤ sin a` when `|x| ≤ a ≤ π/2` or `π − a ≤ |x| ≤ π`. -/
theorem abs_sin_le_of {a x : ℝ} (ha : a ≤ π / 2) (hx : |x| ≤ π) (h : |x| ≤ a ∨ π - a ≤ |x|) :
    |Real.sin x| ≤ Real.sin a := by
  have hπ := Real.pi_pos
  have habs : |Real.sin x| = Real.sin |x| := by
    rcases le_or_gt 0 x with h | h
    · rw [abs_of_nonneg h, abs_of_nonneg (Real.sin_nonneg_of_nonneg_of_le_pi h (by rw [abs_of_nonneg h] at hx; exact hx))]
    · rw [abs_of_neg h, Real.sin_neg, abs_of_nonpos]
      exact Real.sin_nonpos_of_nonpos_of_neg_pi_le h.le (by rw [abs_of_neg h] at hx; linarith)
  rw [habs]
  have hy0 : 0 ≤ |x| := abs_nonneg x
  rcases h with h | h
  · exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) ha h
  · rw [← Real.sin_pi_sub |x|]
    exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) ha (by linarith)

namespace Arc

/-- **The outer pieces of an arc through `v`** (the surgery's old arcs, FS131-IM1's `outer(a)`): each is a non-degenerate sub-arc
of `a` lying outside the open ball `B(v, ρ)`, and together they cover the part of `a` outside the closed ball. -/
theorem outer_spec {a : Arc} (ha : a.Nondegenerate) {v : ℂ} (hv : v ∈ a.carrier) {ρ : ℝ} (hρ : 0 < ρ) :
    (∀ b ∈ a.outer v ρ, b.Nondegenerate ∧ b.carrier ⊆ a.carrier ∧ ∀ z ∈ b.carrier, ρ ≤ dist z v) ∧
      a.carrier \ closedBall v ρ ⊆ ⋃ b ∈ a.outer v ρ, b.carrier := by
  have hπ := Real.pi_pos
  obtain ⟨htv, hptv⟩ := param_spec hv
  -- the three facts on parameters, by cases
  have key : (∀ j, (a.outerIv v ρ j).1 < (a.outerIv v ρ j).2 →
      Icc (a.outerIv v ρ j).1 (a.outerIv v ρ j).2 ⊆ a.params ∧
        ∀ t ∈ Icc (a.outerIv v ρ j).1 (a.outerIv v ρ j).2, ρ ≤ ‖a.pt t - v‖) ∧
      ∀ t ∈ a.params, ρ < ‖a.pt t - v‖ → ∃ j, (a.outerIv v ρ j).1 < (a.outerIv v ρ j).2 ∧
        t ∈ Icc (a.outerIv v ρ j).1 (a.outerIv v ρ j).2 := by
    cases a with
    | seg p q =>
      have hL : 0 < ‖q - p‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (Ne.symm ha))
      set tv := (seg p q).param v with htvdef
      have hdist : ∀ t, ‖(seg p q).pt t - v‖ = |t - tv| * ‖q - p‖ := by
        intro t
        rw [← hptv]
        simp only [pt]
        rw [show p + (t : ℂ) * (q - p) - (p + (tv : ℂ) * (q - p)) = ((t - tv : ℝ) : ℂ) * (q - p) by push_cast; ring,
          norm_mul, Complex.norm_real, Real.norm_eq_abs]
      have htv' : tv ∈ Icc (0 : ℝ) 1 := htv
      have hδ : 0 < ρ / ‖q - p‖ := div_pos hρ hL
      refine ⟨fun j hj => ?_, fun t ht hlt => ?_⟩
      · cases j
        · simp only [outerIv, Bool.false_eq_true, if_false] at hj ⊢
          refine ⟨fun t ht => ⟨by linarith [ht.1, htv'.1], ht.2⟩, fun t ht => ?_⟩
          rw [hdist, abs_of_nonneg (by linarith [ht.1])]
          have := (div_le_iff₀ hL).mp (show ρ / ‖q - p‖ ≤ t - tv by linarith [ht.1])
          linarith
        · simp only [outerIv, if_true] at hj ⊢
          refine ⟨fun t ht => ⟨ht.1, by linarith [ht.2, htv'.2]⟩, fun t ht => ?_⟩
          rw [hdist, abs_of_nonpos (by linarith [ht.2])]
          have := (div_le_iff₀ hL).mp (show ρ / ‖q - p‖ ≤ -(t - tv) by linarith [ht.2])
          linarith
      · rw [hdist] at hlt
        have ht' : t ∈ Icc (0 : ℝ) 1 := ht
        have h' : ρ / ‖q - p‖ < |t - tv| := by rw [div_lt_iff₀ hL]; exact hlt
        rcases le_or_gt 0 (t - tv) with h0 | h0
        · rw [abs_of_nonneg h0] at h'
          refine ⟨false, ?_, ?_⟩ <;> simp only [outerIv, Bool.false_eq_true, if_false]
          · linarith [ht'.2]
          · exact ⟨by linarith, ht'.2⟩
        · rw [abs_of_neg h0] at h'
          refine ⟨true, ?_, ?_⟩ <;> simp only [outerIv, if_true]
          · linarith [ht'.1]
          · exact ⟨ht'.1, by linarith⟩
    | circ c R θ₀ θ₁ =>
      obtain ⟨hR, h01, h02⟩ := ha
      set tv := (circ c R θ₀ θ₁).param v with htvdef
      have htv' : tv ∈ Icc θ₀ θ₁ := htv
      set a₀ := Real.arcsin (ρ / (2 * R)) with ha₀
      have ha₀0 : 0 ≤ a₀ := Real.arcsin_nonneg.mpr (by positivity)
      have ha₀π : a₀ ≤ π / 2 := Real.arcsin_le_pi_div_two _
      have hdist : ∀ θ, ‖(circ c R θ₀ θ₁).pt θ - v‖ = 2 * R * |Real.sin ((θ - tv) / 2)| := by
        intro θ
        rw [← hptv]
        simp only [pt]
        rw [show c + (R : ℂ) * e θ - (c + (R : ℂ) * e tv) = (R : ℂ) * (e θ - e tv) by ring, norm_mul,
          Complex.norm_real, Real.norm_eq_abs, abs_of_pos hR, norm_e_sub_e_eq]
        ring
      -- below `π/2`, `a₀` is exactly the half-angle of the chord `ρ`
      have hsin : a₀ < π / 2 → Real.sin a₀ = ρ / (2 * R) := by
        intro h
        have h1 : ρ / (2 * R) < 1 := by
          by_contra hc; push Not at hc
          rw [ha₀, Real.arcsin_of_one_le hc] at h; exact lt_irrefl _ h
        exact Real.sin_arcsin (by have : 0 < ρ / (2 * R) := by positivity
                                  linarith) h1.le
      refine ⟨fun j hj => ?_, fun t ht hlt => ?_⟩
      · cases j
        · simp only [outerIv, Bool.false_eq_true, if_false] at hj ⊢
          have hlt' : a₀ < π / 2 := by have := min_le_right θ₁ (tv + 2 * π - 2 * a₀); linarith
          refine ⟨fun t ht => ⟨by linarith [ht.1, htv'.1, ha₀0], le_trans ht.2 (min_le_left _ _)⟩, fun t ht => ?_⟩
          have ht2 := le_trans ht.2 (min_le_right _ _)
          rw [hdist]
          have hx : |(t - tv) / 2| ≤ π := by rw [abs_of_nonneg (by linarith [ht.1])]; linarith
          have := (le_abs_sin_iff ha₀0 ha₀π hx).mpr ⟨by rw [abs_of_nonneg (by linarith [ht.1])]; linarith [ht.1],
            by rw [abs_of_nonneg (by linarith [ht.1])]; linarith⟩
          rw [hsin hlt'] at this
          have h2R : 0 < 2 * R := by positivity
          have := mul_le_mul_of_nonneg_left this h2R.le
          rw [mul_div_cancel₀ _ h2R.ne'] at this
          linarith
        · simp only [outerIv, if_true] at hj ⊢
          have hlt' : a₀ < π / 2 := by have := le_max_right θ₀ (tv - 2 * π + 2 * a₀); linarith
          refine ⟨fun t ht => ⟨le_trans (le_max_left _ _) ht.1, by linarith [ht.2, htv'.2, ha₀0]⟩, fun t ht => ?_⟩
          have ht1 := le_trans (le_max_right _ _) ht.1
          rw [hdist]
          have hx : |(t - tv) / 2| ≤ π := by rw [abs_of_nonpos (by linarith [ht.2])]; linarith
          have := (le_abs_sin_iff ha₀0 ha₀π hx).mpr ⟨by rw [abs_of_nonpos (by linarith [ht.2])]; linarith [ht.2],
            by rw [abs_of_nonpos (by linarith [ht.2])]; linarith⟩
          rw [hsin hlt'] at this
          have h2R : 0 < 2 * R := by positivity
          have := mul_le_mul_of_nonneg_left this h2R.le
          rw [mul_div_cancel₀ _ h2R.ne'] at this
          linarith
      · have ht' : t ∈ Icc θ₀ θ₁ := ht
        rw [hdist] at hlt
        have hx : |(t - tv) / 2| ≤ π := by
          rw [abs_le]; constructor <;> linarith [ht'.1, ht'.2, htv'.1, htv'.2]
        have h2R : 0 < 2 * R := by positivity
        have hs1 : |Real.sin ((t - tv) / 2)| ≤ 1 := Real.abs_sin_le_one _
        have hlt' : a₀ < π / 2 := by
          rw [ha₀, Real.arcsin_lt_pi_div_two]
          rw [div_lt_one h2R]; nlinarith
        have hsl : Real.sin a₀ < |Real.sin ((t - tv) / 2)| := by
          rw [hsin hlt', div_lt_iff₀ h2R]; linarith
        have hmid : a₀ < |(t - tv) / 2| ∧ |(t - tv) / 2| < π - a₀ := by
          by_contra hc
          rw [not_and_or, not_lt, not_lt] at hc
          exact absurd (abs_sin_le_of ha₀π hx hc) (not_le.mpr hsl)
        rcases le_or_gt 0 (t - tv) with h0 | h0
        · rw [abs_of_nonneg (by linarith)] at hmid
          refine ⟨false, ?_, ?_⟩ <;> simp only [outerIv, Bool.false_eq_true, if_false]
          · exact lt_min (by linarith [ht'.2]) (by linarith)
          · exact ⟨by linarith, le_min ht'.2 (by linarith)⟩
        · rw [abs_of_neg (by linarith)] at hmid
          refine ⟨true, ?_, ?_⟩ <;> simp only [outerIv, if_true]
          · exact max_lt (by linarith [ht'.1]) (by linarith)
          · exact ⟨max_le ht'.1 (by linarith), by linarith⟩
  obtain ⟨hk1, hk2⟩ := key
  refine ⟨?_, ?_⟩
  · rintro b ⟨j, hj, rfl⟩
    obtain ⟨hsub, hdist⟩ := hk1 j hj
    refine ⟨nondegenerate_sub ha hj hsub, ?_, ?_⟩
    · rw [carrier_sub _ hj.le, carrier_eq_image]; exact image_mono hsub
    · rw [carrier_sub _ hj.le]
      rintro z ⟨t, ht, rfl⟩
      rw [dist_eq_norm]; exact hdist t ht
  · rintro z ⟨hz, hzb⟩
    rw [carrier_eq_image] at hz
    obtain ⟨t, ht, rfl⟩ := hz
    rw [mem_closedBall, not_le, dist_eq_norm] at hzb
    obtain ⟨j, hj, htj⟩ := hk2 t ht hzb
    refine mem_iUnion₂.mpr ⟨_, ⟨j, hj, rfl⟩, ?_⟩
    rw [carrier_sub _ hj.le]
    exact ⟨t, htj, rfl⟩

end Arc

/-! ## The surgery at a point (one construction for the three moves) -/

namespace ArcMap

variable {k : ℕ}

/-- **The arcs of `F` with the ball `B(v, ρ)` cut out**: the arcs missing `v` kept whole, each arc through `v` replaced by its outer
pieces (`Arc.outer`). -/
def trimArcs (F : ArcMap k) (v : ℂ) (ρ : ℝ) : Set Arc :=
  {a | a ∈ F.arcs ∧ v ∉ a.carrier} ∪ ⋃ a ∈ {a | a ∈ F.arcs ∧ v ∈ a.carrier}, a.outer v ρ

/-- Finitely many arcs pass through a point of the domain. -/
theorem finite_arcs_through (F : ArcMap k) {v : ℂ} (hv : v ∈ F.dom) : {a | a ∈ F.arcs ∧ v ∈ a.carrier}.Finite := by
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite v hv
  exact hfin.subset fun a ⟨ha, hva⟩ => ⟨ha, v, hva, mem_of_mem_nhds ht⟩

/-- The trimmed arcs: non-degenerate, each inside an arc of `F` (outside `B(v, ρ)` when that arc passes through `v`), covering
`F`'s arcs off the closed ball, and all but finitely many of them arcs of `F`. -/
theorem trimArcs_spec (F : ArcMap k) {v : ℂ} (hv : v ∈ F.dom) {ρ : ℝ} (hρ : 0 < ρ) :
    (∀ b ∈ F.trimArcs v ρ, b.Nondegenerate ∧ ∃ a ∈ F.arcs, b.carrier ⊆ a.carrier ∧
      (v ∈ a.carrier → ∀ z ∈ b.carrier, ρ ≤ dist z v)) ∧
    ((⋃ a ∈ F.arcs, a.carrier) \ closedBall v ρ ⊆ ⋃ b ∈ F.trimArcs v ρ, b.carrier) ∧
    ∃ T : Set Arc, T.Finite ∧ F.trimArcs v ρ ⊆ F.arcs ∪ T := by
  refine ⟨?_, ?_, ?_⟩
  · rintro b (⟨hb, hvb⟩ | hb)
    · exact ⟨F.nondegenerate b hb, b, hb, subset_rfl, fun h => absurd h hvb⟩
    · obtain ⟨a, ⟨ha, hva⟩, hba⟩ := mem_iUnion₂.mp hb
      obtain ⟨h1, -⟩ := Arc.outer_spec (F.nondegenerate a ha) hva hρ
      obtain ⟨hnd, hsub, hd⟩ := h1 b hba
      exact ⟨hnd, a, ha, hsub, fun _ => hd⟩
  · rintro z ⟨hz, hzb⟩
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hz
    by_cases hva : v ∈ a.carrier
    · obtain ⟨-, h2⟩ := Arc.outer_spec (F.nondegenerate a ha) hva hρ
      obtain ⟨b, hb, hzb'⟩ := mem_iUnion₂.mp (h2 ⟨hza, hzb⟩)
      exact mem_iUnion₂.mpr ⟨b, Or.inr (mem_iUnion₂.mpr ⟨a, ⟨ha, hva⟩, hb⟩), hzb'⟩
    · exact mem_iUnion₂.mpr ⟨a, Or.inl ⟨ha, hva⟩, hza⟩
  · refine ⟨⋃ a ∈ {a | a ∈ F.arcs ∧ v ∈ a.carrier}, a.outer v ρ,
      (F.finite_arcs_through hv).biUnion fun a _ => a.finite_outer v ρ, ?_⟩
    rintro b (⟨hb, -⟩ | hb)
    · exact Or.inl hb
    · exact Or.inr hb

/-- In a good ball, the trimmed arcs miss `B(v, ρ)`. -/
theorem trimArcs_disjoint_ball {F : ArcMap k} {v : ℂ} {ρ₀ ρ : ℝ} (hG : F.GoodAt v ρ₀) (hρ : 0 < ρ) (hρ₀ : ρ < ρ₀) :
    ∀ b ∈ F.trimArcs v ρ, ∀ z ∈ b.carrier, z ∉ ball v ρ := by
  intro b hb z hz hzb
  obtain ⟨h1, -, -⟩ := F.trimArcs_spec (hG.subdom (mem_ball_self hG.pos)) hρ
  obtain ⟨-, a, ha, hsub, hd⟩ := h1 b hb
  by_cases hva : v ∈ a.carrier
  · have := hd hva z hz
    rw [mem_ball] at hzb; linarith
  · exact hva (hG.through a ha ⟨z, hsub hz, ball_subset_ball hρ₀.le hzb⟩)

/-- **The surgery at `v`**: `F`'s domain, its arcs with `B(v, ρ)` cut out (`trimArcs`) together with a finite family `A` of new
arcs, and the colouring `col'`; `hlc` is the colouring's local constancy off the new arcs (each move proves it). -/
noncomputable def surgery (F : ArcMap k) (v : ℂ) (ρ : ℝ) (A : Set Arc) (col' : ℂ → Fin k) (hv : v ∈ F.dom) (hρ : 0 < ρ)
    (hA : ∀ a ∈ A, a.Nondegenerate) (hAf : A.Finite)
    (hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x) : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.trimArcs v ρ ∪ A
  nondegenerate := by
    rintro a (ha | ha)
    · exact ((F.trimArcs_spec hv hρ).1 a ha).1
    · exact hA a ha
  locallyFinite := by
    intro x hx
    obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
    obtain ⟨-, -, T, hT, hsub⟩ := F.trimArcs_spec hv hρ
    refine ⟨t, ht, (hfin.union (hT.union hAf)).subset ?_⟩
    rintro a ⟨ha | ha, hat⟩
    · rcases hsub ha with h | h
      · exact Or.inl ⟨h, hat⟩
      · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr ha)
  col := col'
  locallyConstant := hlc

section Surgery

variable {F : ArcMap k} {v : ℂ} {ρ : ℝ} {A : Set Arc} {col' : ℂ → Fin k} {hv : v ∈ F.dom} {hρ : 0 < ρ}
  {hA : ∀ a ∈ A, a.Nondegenerate} {hAf : A.Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}

/-- Off the closed ball the surgery has `F`'s arcs (the new arcs inside the closed ball). -/
theorem surgery_mem_arcs_iff_of_not_mem (hAin : ∀ a ∈ A, a.carrier ⊆ closedBall v ρ) {z : ℂ} (hz : z ∉ closedBall v ρ) :
    z ∈ ⋃ a ∈ (F.surgery v ρ A col' hv hρ hA hAf hlc).arcs, a.carrier ↔ z ∈ ⋃ a ∈ F.arcs, a.carrier := by
  obtain ⟨h1, h2, -⟩ := F.trimArcs_spec hv hρ
  constructor
  · intro h
    obtain ⟨b, hb | hb, hzb⟩ := mem_iUnion₂.mp h
    · obtain ⟨-, a, ha, hsub, -⟩ := h1 b hb
      exact mem_iUnion₂.mpr ⟨a, ha, hsub hzb⟩
    · exact absurd (hAin b hb hzb) hz
  · intro h
    obtain ⟨b, hb, hzb⟩ := mem_iUnion₂.mp (h2 ⟨h, hz⟩)
    exact mem_iUnion₂.mpr ⟨b, Or.inl hb, hzb⟩

/-- In the open ball the surgery's arcs are the new arcs (in a good ball). -/
theorem surgery_mem_arcs_iff_of_mem {ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) (hρ₀ : ρ < ρ₀) {z : ℂ} (hz : z ∈ ball v ρ) :
    z ∈ ⋃ a ∈ (F.surgery v ρ A col' hv hρ hA hAf hlc).arcs, a.carrier ↔ z ∈ ⋃ a ∈ A, a.carrier := by
  constructor
  · intro h
    obtain ⟨b, hb | hb, hzb⟩ := mem_iUnion₂.mp h
    · exact absurd hz (trimArcs_disjoint_ball hG hρ hρ₀ b hb z hzb)
    · exact mem_iUnion₂.mpr ⟨b, hb, hzb⟩
  · intro h
    obtain ⟨b, hb, hzb⟩ := mem_iUnion₂.mp h
    exact mem_iUnion₂.mpr ⟨b, Or.inr hb, hzb⟩

/-- **The surgery agrees with `F` off the closed ball** when its colouring does. -/
theorem surgery_agreesOff (hAin : ∀ a ∈ A, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z) :
    (F.surgery v ρ A col' hv hρ hA hAf hlc).AgreesOff F (closedBall v ρ) := by
  refine ⟨rfl, fun z hz => ⟨?_, (hcol z hz).symm⟩⟩
  have h := surgery_mem_arcs_iff_of_not_mem (F := F) (col' := col') (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
    (hlc := hlc) hAin hz
  show z ∈ F.dom \ _ ↔ z ∈ F.dom \ _
  rw [Set.mem_sdiff, Set.mem_sdiff, h]

/-- **The surgery creates no unit arc** when each new unit arc already lies in `F`'s `Γ`. -/
theorem surgery_ringArcsWithin (hAunit : ∀ a ∈ A, a.IsUnitArc → a.carrier ∩ F.dom ⊆ F.Γ) :
    (F.surgery v ρ A col' hv hρ hA hAf hlc).RingArcsWithin F := by
  obtain ⟨h1, -, -⟩ := F.trimArcs_spec hv hρ
  refine ringArcsWithin_of_Γ_subset rfl (A' := {a | a ∈ A ∧ ¬ a.IsUnitArc}) (fun a ha => hA a ha.1)
    (fun x _ => ⟨univ, univ_mem, (hAf.subset fun a ha => ha.1.1)⟩) (fun a ha => ha.2) ?_
  rintro z ⟨hzd, hz⟩
  obtain ⟨b, hb | hb, hzb⟩ := mem_iUnion₂.mp hz
  · obtain ⟨-, a, ha, hsub, -⟩ := h1 b hb
    exact Or.inl ⟨hzd, mem_iUnion₂.mpr ⟨a, ha, hsub hzb⟩⟩
  · by_cases hu : b.IsUnitArc
    · exact Or.inl (hAunit b hb hu ⟨hzb, hzd⟩)
    · exact Or.inr (mem_iUnion₂.mpr ⟨b, ⟨hb, hu⟩, hzb⟩)

/-- **The surgery keeps Condition 5** when each new arc meets every unit circle in the domain finitely often. -/
theorem surgery_condition5 (hA5 : F.Condition5 → ∀ a ∈ A, ∀ p, (a.carrier ∩ F.dom ∩ sphere p 1).Finite) :
    F.Condition5 → (F.surgery v ρ A col' hv hρ hA hAf hlc).Condition5 := by
  intro h5 b hb p
  obtain ⟨h1, -, -⟩ := F.trimArcs_spec hv hρ
  rcases hb with hb | hb
  · obtain ⟨-, a, ha, hsub, -⟩ := h1 b hb
    exact (h5 a ha p).subset fun z ⟨⟨hz, hzd⟩, hzs⟩ => ⟨⟨hsub hz, hzd⟩, hzs⟩
  · exact hA5 h5 b hb p

end Surgery

/-- **Local constancy of a surgery's colouring off the closed ball**: it is `F`'s there. -/
theorem surgery_hlc_of {F : ArcMap k} {v : ℂ} {ρ ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) (hρ : 0 < ρ) {A : Set Arc}
    {col' : ℂ → Fin k} (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z)
    (hrim : sphere v ρ ⊆ ⋃ a ∈ A, a.carrier)
    (hin : ∀ x ∈ ball v ρ, x ∉ ⋃ a ∈ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x := by
  have hv : v ∈ F.dom := hG.subdom (mem_ball_self hG.pos)
  obtain ⟨-, h2, -⟩ := F.trimArcs_spec hv hρ
  intro x hx hxa
  have hxA : x ∉ ⋃ a ∈ A, a.carrier := fun h => by
    obtain ⟨a, ha, hxa'⟩ := mem_iUnion₂.mp h
    exact hxa (mem_iUnion₂.mpr ⟨a, Or.inr ha, hxa'⟩)
  rcases lt_trichotomy (dist x v) ρ with h | h | h
  · exact hin x h hxA
  · exact absurd (hrim h) hxA
  · have hxc : x ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact h
    have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun hF => by
      obtain ⟨b, hb, hxb⟩ := mem_iUnion₂.mp (h2 ⟨hF, hxc⟩)
      exact hxa (mem_iUnion₂.mpr ⟨b, Or.inl hb, hxb⟩)
    have hopen : ∀ᶠ y in 𝓝 x, y ∉ closedBall v ρ := isClosed_closedBall.isOpen_compl.mem_nhds hxc
    filter_upwards [F.locallyConstant x hx hxF, hopen] with y hy hyc
    rw [hcol y hyc, hcol x hxc, hy]

end ArcMap

end HadwigerNelson.Plane
