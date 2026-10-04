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

/-! ## Horns as sets: open, connected, and the tangent arc inside them -/

/-- The horn is open. -/
theorem isOpen_hornSet (v : ℂ) (α κ₁ κ₂ r : ℝ) : IsOpen (hornSet v α κ₁ κ₂ r) := by
  have hX : Continuous (frameX v α) := by unfold frameX; fun_prop
  have hY : Continuous (frameY v α) := by unfold frameY; fun_prop
  have hT : ∀ κ, Continuous fun z => tanHeight κ (frameX v α z) (frameY v α z) := fun κ => by
    unfold tanHeight; fun_prop
  exact ((isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter (isOpen_lt continuous_const hX)).inter
    ((isOpen_lt continuous_const (hT κ₁)).inter (isOpen_lt (hT κ₂) continuous_const)) |>.preimage continuous_id
    |> fun h => by simpa [hornSet, TanAbove, TanBelow, Set.setOf_and, Set.inter_assoc] using h

/-- **The horn is connected** (a sector of the two-germ chart `(α, κ₁), (α, κ₂)`), for `κ₁ < κ₂` and `|κᵢ| r < 2`. -/
theorem isPreconnected_hornSet (v : ℂ) (α : ℝ) {κ₁ κ₂ r : ℝ} (hlt : κ₁ < κ₂) (h1 : |κ₁| * r < 2) (h2 : |κ₂| * r < 2) :
    IsPreconnected (hornSet v α κ₁ κ₂ r) := by
  have hπ := Real.pi_pos
  set G : BranchGerms 2 := ⟨![α, α], ![κ₁, κ₂]⟩ with hG
  have hb : ∀ κ s, |κ| * r < 2 → s ∈ Ioo 0 r → κ * s / 2 ∈ Icc (-1 : ℝ) 1 := fun κ s hκ hs =>
    half_curv_mem_Icc (s := s) (r := r) hκ.le hs.1.le hs.2.le
  have hord : ∀ s ∈ Ioo 0 r, ∀ i, G.dir i s < G.nextDir i s := by
    intro s hs i
    have hs1 := hb κ₁ s h1 hs
    have hs2 := hb κ₂ s h2 hs
    have hlt' : κ₁ * s / 2 < κ₂ * s / 2 := by have := mul_lt_mul_of_pos_right hlt hs.1; linarith
    have ha := Real.arcsin_lt_arcsin hs1.1 hlt' hs2.2
    fin_cases i
    · simp [BranchGerms.dir, BranchGerms.nextDir, BranchGerms.nextβ, BranchGerms.nextκ, germDir, hG]
      exact ha
    · simp [BranchGerms.dir, BranchGerms.nextDir, BranchGerms.nextβ, BranchGerms.nextκ, germDir, hG]
      have := Real.arcsin_le_pi_div_two (κ₂ * s / 2)
      have := Real.neg_pi_div_two_le_arcsin (κ₁ * s / 2)
      linarith
  have hsec : G.sector v r 0 = hornSet v α κ₁ κ₂ r := by
    have : G.sector v r 0 = sectorBetween v α κ₁ α κ₂ r := by
      simp [BranchGerms.sector, BranchGerms.nextβ, BranchGerms.nextκ, hG]
    rw [this, sectorBetween_eq_hornSet v α κ₁ κ₂ r h1.le h2.le]
  rw [← hsec]
  exact G.isPreconnected_sector hord le_rfl 0

/-- An empty horn: no point lies strictly above the arc of curvature `κ₁` and below that of `κ₂ ≤ κ₁`. -/
theorem hornSet_eq_empty {v : ℂ} {α κ₁ κ₂ r : ℝ} (h : κ₂ ≤ κ₁) : hornSet v α κ₁ κ₂ r = ∅ :=
  eq_empty_of_forall_notMem fun z ⟨_, _, hA, hB⟩ => by
    have := tanHeight_anti h (frameX v α z) (frameY v α z)
    unfold TanAbove at hA; unfold TanBelow at hB; linarith

/-- **A point on the tangent arc of curvature `σ` in the right half-ball is a branch point**: `tanHeight σ = 0` with `frameX > 0` and
`0 < ‖z − v‖`, `|σ| ‖z − v‖ ≤ 2`, gives `z = branchPt v α σ ‖z − v‖`. -/
theorem eq_branchPt_of_tanHeight_eq_zero {v z : ℂ} {α σ : ℝ} (hX : 0 < frameX v α z)
    (hT : tanHeight σ (frameX v α z) (frameY v α z) = 0) (hσ : |σ| * ‖z - v‖ ≤ 2) :
    z = branchPt v α σ ‖z - v‖ := by
  set w := (z - v) * starRingEnd ℂ (e α) with hw
  have hwre : 0 < w.re := hX
  have hw0 : w ≠ 0 := fun h => by rw [h, Complex.zero_re] at hwre; exact lt_irrefl 0 hwre
  have hnw : ‖w‖ = ‖z - v‖ := by rw [hw, norm_mul, Complex.norm_conj, norm_e, mul_one]
  set s := ‖z - v‖ with hs
  have hs0 : 0 < s := by rw [← hnw]; exact norm_pos_iff.mpr hw0
  set ψ := Complex.arg w with hψ
  have hψb : |ψ| < π / 2 := Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl hwre)
  have hzpol : z = v + (s : ℂ) * e (α + ψ) := by
    have h1 : w = (s : ℂ) * e ψ := by rw [← hnw]; exact eq_polar_arg w
    have h2 : z - v = w * e α := by
      rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e α)), e_mul_conj_e, mul_one]
    rw [e_add, ← mul_assoc, mul_comm (s : ℂ) (e α), mul_assoc, ← h1, mul_comm, ← h2]; ring
  have ha := half_curv_mem_Icc hσ hs0.le le_rfl
  have hT' : s * (Real.sin ψ - σ * s / 2) = 0 := by
    have := hT; rw [hzpol, tanHeight_polar, add_sub_cancel_left] at this; exact this
  have hsin : Real.sin ψ = σ * s / 2 := by
    rcases mul_eq_zero.mp hT' with h | h
    · exact absurd h hs0.ne'
    · linarith
  have hψ' : ψ = Real.arcsin (σ * s / 2) := by
    rw [← hsin, Real.arcsin_sin (by linarith [(abs_lt.mp hψb).1]) (by linarith [(abs_lt.mp hψb).2])]
  conv_lhs => rw [hzpol]
  rw [hψ', branchPt]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- A valid map's interior point is clear for its own colour. -/
theorem isClear_col (hF : F.Valid) {z : ℂ} (hz : z ∈ F.interiorPts) : F.IsClear (F.col z) z :=
  fun y hy hzy => hF z hz y hy.1 hzy (by have := hy.2; simp only [mem_preimage, mem_singleton_iff] at this; rw [this])

/-- **Counting sectors from a partition** (pieces possibly empty): if the interior points of `B(v, r)` are the union of open, connected,
pairwise disjoint pieces, each non-empty one holding `v` in its closure and lying in one colour's class, then the sectors of colour `c`
at radius `r` are the non-empty pieces of colour `c`. -/
theorem encard_sectorsOf_of_partition {ι : Type*} {A : ι → Set ℂ} {colA : ι → Fin k} {v : ℂ} {r : ℝ}
    (hU : F.interiorPts ∩ ball v r = ⋃ i, A i) (hopen : ∀ i, IsOpen (A i)) (hpre : ∀ i, IsPreconnected (A i))
    (hdisj : ∀ i j, i ≠ j → Disjoint (A i) (A j)) (hcl : ∀ i, (A i).Nonempty → v ∈ closure (A i))
    (hcol : ∀ i, A i ⊆ F.col ⁻¹' {colA i}) (c : Fin k) :
    (F.sectorsOf v r c).encard = {i | (A i).Nonempty ∧ colA i = c}.encard := by
  have hcomp : ∀ i, ∀ x ∈ A i, connectedComponentIn (F.interiorPts ∩ ball v r) x = A i :=
    fun i x hx => connectedComponentIn_eq_of_iUnion hU hopen hpre hdisj hx
  have heq : F.sectorsOf v r c = A '' {i | (A i).Nonempty ∧ colA i = c} := by
    ext S
    constructor
    · rintro ⟨⟨x, hx, rfl, -⟩, hSc⟩
      rw [hU] at hx
      obtain ⟨i, hi⟩ := mem_iUnion.mp hx
      rw [hcomp i x hi] at hSc ⊢
      refine ⟨i, ⟨⟨x, hi⟩, ?_⟩, rfl⟩
      have h1 := hSc hi
      have h2 := hcol i hi
      simp only [mem_preimage, mem_singleton_iff] at h1 h2
      rw [← h2, h1]
    · rintro ⟨i, ⟨⟨x, hx⟩, hic⟩, rfl⟩
      refine ⟨⟨x, by rw [hU]; exact mem_iUnion.mpr ⟨i, hx⟩, (hcomp i x hx).symm, hcl i ⟨x, hx⟩⟩, ?_⟩
      intro y hy
      have := hcol i hy
      simp only [mem_preimage, mem_singleton_iff] at this ⊢
      rw [this, hic]
  rw [heq]
  refine InjOn.encard_image fun i hi j hj hij => ?_
  by_contra hne
  obtain ⟨x, hx⟩ := hi.1
  exact disjoint_left.mp (hdisj i j hne) hx (hij ▸ hx)

/-- **The sectors of colour `c` in a chart** are the chart sectors of colour `c`. -/
theorem IsSectorChart.encard_sectorsOf {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {col : Fin n → Fin k} (hcol : ∀ i, G.sector v r i ⊆ F.region (col i))
    (c : Fin k) : (F.sectorsOf v r c).encard = {i | col i = c}.encard := by
  rw [encard_sectorsOf_of_partition (A := G.sector v r) (colA := col) (by rw [inter_comm]; exact hC.cover r hr hn)
    (hC.isOpen r hr) (hC.isPreconnected r hr) (hC.disjoint r hr) (fun i _ => hC.mem_closure_sector hr i)
    (fun i => (hcol i).trans inter_subset_right) c]
  congr 1
  ext i
  simp only [mem_setOf_eq, and_iff_right_iff_imp]
  exact fun _ => hC.sector_nonempty hr i

/-- **Finitely many points of a unit circle on `Γ` near a point**, under Condition 5 (a good ball meets finitely many arcs). -/
theorem finite_inter_sphere_of_subset_Γ {v : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) (h5 : F.Condition5) {C : Set ℂ}
    (hC : C ⊆ F.Γ ∩ ball v ρ₀) (p : ℂ) : (C ∩ sphere p 1).Finite := by
  refine (hG.fin.biUnion fun a ha => h5 a ha.1 p).subset ?_
  rintro z ⟨hz, hzs⟩
  obtain ⟨⟨hzd, hza⟩, hzb⟩ := hC hz
  obtain ⟨a, ha, hza'⟩ := mem_iUnion₂.mp hza
  exact mem_iUnion₂.mpr ⟨a, ⟨ha, z, hza', hzb⟩, ⟨hza', hzd⟩, hzs⟩

end ArcMap

/-- The whole circle about `v` of radius `ρ > 0` is the carrier of `circ v ρ 0 (2π)`. -/
theorem carrier_circ_full' (v : ℂ) {ρ : ℝ} (hρ : 0 < ρ) : (Arc.circ v ρ 0 (2 * π)).carrier = sphere v ρ := by
  ext z
  simp only [Arc.carrier, mem_image, mem_Icc, mem_sphere_iff_norm]
  constructor
  · rintro ⟨θ, -, rfl⟩
    rw [add_sub_cancel_left, norm_mul_e hρ.le]
  · intro hz
    have hpol : z - v = (ρ : ℂ) * e (arg (z - v)) := by
      have := eq_polar_arg (z - v)
      rw [hz] at this; exact this
    have hπ := Real.pi_pos
    rcases le_or_gt 0 (arg (z - v)) with h | h
    · exact ⟨arg (z - v), ⟨h, by linarith [Complex.arg_le_pi (z - v)]⟩, by rw [← hpol]; ring⟩
    · refine ⟨arg (z - v) + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg (z - v)], by linarith⟩, ?_⟩
      rw [e_add_two_pi, ← hpol]; ring

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- `e (G.nextβ p) = e (G.β (next p))`: the germ after `p` is `next p`'s, up to a turn. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.e_nextβ {n : ℕ} (G : BranchGerms n) (p : Fin n) :
    e (G.nextβ p) = e (G.β (BranchGerms.next p)) := by
  have := G.e_nextDir p 0
  simpa [BranchGerms.nextDir, BranchGerms.dir] using this

/-- **The sector after a germ holds the branch points just above it**: at a small distance `s`, some curvature `m ∈ (κ, κ')` has its
branch point (along `α`, the germ's direction mod `2π`) in the sector after the germ. -/
theorem IsSectorChart.exists_branchPt_mem_sector_after {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hs₀ : s₀ ≤ r₀) (hord : ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s)
    {j : Fin n} {α κ κ' : ℝ} (hβ : e (G.β j) = e α) (hκ : G.κ j = κ) (hκ' : κ < κ') {s : ℝ} (hs : s ∈ Ioo 0 s₀) :
    ∃ m ∈ Ioo κ κ', |m| * s < 2 ∧ branchPt v α m s ∈ G.sector v s₀ j := by
  have hcs : |κ| * s < 2 := by
    rw [← hκ]; exact lt_of_le_of_lt (mul_le_mul_of_nonneg_left (hs.2.le.trans hs₀) (abs_nonneg _)) (hC.curv j)
  have hf : Continuous fun m : ℝ => G.β j + Real.arcsin (m * s / 2) :=
    continuous_const.add (Real.continuous_arcsin.comp (by fun_prop))
  have h0 : G.β j + Real.arcsin (κ * s / 2) < G.nextDir j s := by
    have := hord s hs j; rwa [BranchGerms.dir, germDir, hκ] at this
  have ev1 : ∀ᶠ m in 𝓝 κ, G.β j + Real.arcsin (m * s / 2) < G.nextDir j s :=
    (hf.tendsto κ).eventually (gt_mem_nhds h0)
  have ev2 : ∀ᶠ m in 𝓝 κ, |m| * s < 2 :=
    ((continuous_abs.mul continuous_const).tendsto κ).eventually (gt_mem_nhds hcs)
  obtain ⟨m, ⟨h1, h2⟩, hm⟩ := ((ev1.and ev2).filter_mono nhdsWithin_le_nhds |>.and
    (Ioo_mem_nhdsGT hκ')).exists (f := 𝓝[>] κ)
  refine ⟨m, hm, h2, s, hs, G.β j + Real.arcsin (m * s / 2), ⟨?_, h1⟩, ?_⟩
  · show germDir (G.β j) (G.κ j) s < _
    rw [germDir, hκ]
    have hb1 := half_curv_mem_Icc hcs.le hs.1.le le_rfl
    have hb2 := half_curv_mem_Icc h2.le hs.1.le le_rfl
    have : κ * s / 2 < m * s / 2 := by have := mul_lt_mul_of_pos_right hm.1 hs.1; linarith
    linarith [Real.arcsin_lt_arcsin hb1.1 this hb2.2]
  · rw [branchPt, e_add, e_add, hβ]

/-- **The sector before a germ holds the branch points just below it** (the mirror of `exists_branchPt_mem_sector_after`). -/
theorem IsSectorChart.exists_branchPt_mem_sector_before {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hs₀ : s₀ ≤ r₀) (hord : ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s)
    {p : Fin n} {α κ κ' : ℝ} (hβ : e (G.nextβ p) = e α) (hκ : G.nextκ p = κ) (hκ' : κ' < κ) {s : ℝ} (hs : s ∈ Ioo 0 s₀) :
    ∃ m ∈ Ioo κ' κ, |m| * s < 2 ∧ branchPt v α m s ∈ G.sector v s₀ p := by
  have hcs : |κ| * s < 2 := by
    rw [← hκ]; exact lt_of_le_of_lt (mul_le_mul_of_nonneg_left (hs.2.le.trans hs₀) (abs_nonneg _)) (hC.curv_next p)
  have hf : Continuous fun m : ℝ => G.nextβ p + Real.arcsin (m * s / 2) :=
    continuous_const.add (Real.continuous_arcsin.comp (by fun_prop))
  have h0 : G.dir p s < G.nextβ p + Real.arcsin (κ * s / 2) := by
    have := hord s hs p; rwa [BranchGerms.nextDir, germDir, hκ] at this
  have ev1 : ∀ᶠ m in 𝓝 κ, G.dir p s < G.nextβ p + Real.arcsin (m * s / 2) :=
    (hf.tendsto κ).eventually (lt_mem_nhds h0)
  have ev2 : ∀ᶠ m in 𝓝 κ, |m| * s < 2 :=
    ((continuous_abs.mul continuous_const).tendsto κ).eventually (gt_mem_nhds hcs)
  obtain ⟨m, ⟨h1, h2⟩, hm⟩ := ((ev1.and ev2).filter_mono nhdsWithin_le_nhds |>.and
    (Ioo_mem_nhdsLT hκ')).exists (f := 𝓝[<] κ)
  refine ⟨m, hm, h2, s, hs, G.nextβ p + Real.arcsin (m * s / 2), ⟨h1, ?_⟩, ?_⟩
  · show _ < germDir (G.nextβ p) (G.nextκ p) s
    rw [germDir, hκ]
    have hb1 := half_curv_mem_Icc hcs.le hs.1.le le_rfl
    have hb2 := half_curv_mem_Icc h2.le hs.1.le le_rfl
    have : m * s / 2 < κ * s / 2 := by have := mul_lt_mul_of_pos_right hm.2 hs.1; linarith
    linarith [Real.arcsin_lt_arcsin hb2.1 this hb1.2]
  · rw [branchPt, e_add, e_add, hβ]

/-- **The flank above a germ is the colour of the sector after it.** -/
theorem IsSectorChart.col_eq_of_flankAbove {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hs₀ : s₀ ∈ Ioc 0 r₀) (hord : ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s) {col : Fin n → Fin k}
    (hcol : ∀ i, G.sector v s₀ i ⊆ F.region (col i)) {j : Fin n} {α κ : ℝ} {g : Fin k} (hβ : e (G.β j) = e α)
    (hκ : G.κ j = κ) (hg : F.IsFlankAbove v α κ g) : col j = g := by
  obtain ⟨κ', hκ', hev⟩ := hg
  obtain ⟨r, hr, hr0⟩ := (hev.and (Ioo_mem_nhdsGT hs₀.1)).exists
  obtain ⟨m, hm, hms, hmem⟩ := hC.exists_branchPt_mem_sector_after hs₀.2 hord hβ hκ hκ' (s := r / 2)
    ⟨by linarith [hr0.1], by linarith [hr0.1, hr0.2]⟩
  have h1 := (hcol j hmem).2
  have h2 := (hr (branchPt_mem_hornSet v α hm.1 hm.2 (by linarith [hr0.1]) (by linarith [hr0.1]) hms)).2
  simp only [mem_preimage, mem_singleton_iff] at h1 h2
  rw [← h1, h2]

/-- **The flank below a germ is the colour of the sector before it.** -/
theorem IsSectorChart.col_eq_of_flankBelow {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hs₀ : s₀ ∈ Ioc 0 r₀) (hord : ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s) {col : Fin n → Fin k}
    (hcol : ∀ i, G.sector v s₀ i ⊆ F.region (col i)) {p : Fin n} {α κ : ℝ} {h : Fin k} (hβ : e (G.nextβ p) = e α)
    (hκ : G.nextκ p = κ) (hh : F.IsFlankBelow v α κ h) : col p = h := by
  obtain ⟨κ', hκ', hev⟩ := hh
  obtain ⟨r, hr, hr0⟩ := (hev.and (Ioo_mem_nhdsGT hs₀.1)).exists
  obtain ⟨m, hm, hms, hmem⟩ := hC.exists_branchPt_mem_sector_before hs₀.2 hord hβ hκ hκ' (s := r / 2)
    ⟨by linarith [hr0.1], by linarith [hr0.1, hr0.2]⟩
  have h1 := (hcol p hmem).2
  have h2 := (hr (branchPt_mem_hornSet v α hm.1 hm.2 (by linarith [hr0.1]) (by linarith [hr0.1]) hms)).2
  simp only [mem_preimage, mem_singleton_iff] at h1 h2
  rw [← h1, h2]

/-- **A branch point lies in the closure of the sector after its germ.** -/
theorem IsSectorChart.branchPt_mem_closure_sector_after {n : ℕ} {G : BranchGerms n} {v : ℂ} {s₀ : ℝ}
    (hord : ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s) {r : ℝ} (hr : r ≤ s₀) (j : Fin n) {s : ℝ}
    (hs : s ∈ Ioo 0 r) : branchPt v (G.β j) (G.κ j) s ∈ closure (G.sector v r j) := by
  have hgap : 0 < G.nextDir j s - G.dir j s := sub_pos.mpr (hord s ⟨hs.1, hs.2.trans_le hr⟩ j)
  have ht : Tendsto (fun t : ℝ => v + (s : ℂ) * e (G.dir j s + t)) (𝓝[>] 0) (𝓝 (branchPt v (G.β j) (G.κ j) s)) := by
    have hc : Continuous fun t : ℝ => v + (s : ℂ) * e (G.dir j s + t) :=
      continuous_const.add (continuous_const.mul (continuous_e.comp (continuous_const.add continuous_id)))
    have := (hc.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
    simpa [branchPt_eq, BranchGerms.dir] using this
  refine mem_closure_of_tendsto ht ?_
  filter_upwards [Ioo_mem_nhdsGT hgap] with t htt
  exact ⟨s, hs, G.dir j s + t, ⟨show G.dir j s < G.dir j s + t by linarith [htt.1],
    show G.dir j s + t < G.nextDir j s by linarith [htt.2]⟩, rfl⟩

/-- **A branch point lies in the closure of the sector before its germ.** -/
theorem IsSectorChart.branchPt_mem_closure_sector_before {n : ℕ} {G : BranchGerms n} {v : ℂ} {s₀ : ℝ}
    (hord : ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s) {r : ℝ} (hr : r ≤ s₀) (p : Fin n) {s : ℝ}
    (hs : s ∈ Ioo 0 r) :
    branchPt v (G.β (BranchGerms.next p)) (G.κ (BranchGerms.next p)) s ∈ closure (G.sector v r p) := by
  have hgap : 0 < G.nextDir p s - G.dir p s := sub_pos.mpr (hord s ⟨hs.1, hs.2.trans_le hr⟩ p)
  have ht : Tendsto (fun t : ℝ => v + (s : ℂ) * e (G.nextDir p s - t)) (𝓝[>] 0)
      (𝓝 (branchPt v (G.β (BranchGerms.next p)) (G.κ (BranchGerms.next p)) s)) := by
    have hc : Continuous fun t : ℝ => v + (s : ℂ) * e (G.nextDir p s - t) :=
      continuous_const.add (continuous_const.mul (continuous_e.comp (continuous_const.sub continuous_id)))
    have := (hc.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
    rw [sub_zero, BranchGerms.e_nextDir] at this
    simpa [branchPt_eq, BranchGerms.dir] using this
  refine mem_closure_of_tendsto ht ?_
  filter_upwards [Ioo_mem_nhdsGT hgap] with t htt
  exact ⟨s, hs, G.nextDir p s - t, ⟨show G.dir p s < G.nextDir p s - t by linarith [htt.2],
    show G.nextDir p s - t < G.nextDir p s by linarith [htt.1]⟩, rfl⟩

/-- **Near a branch point the chart has only the two sectors beside its germ and the branch itself** (where the germs are apart). -/
theorem IsSectorChart.exists_ball_subset_of_branchPt {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ s₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hs₀ : s₀ ≤ r₀)
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 s₀, e (G.dir i s) ≠ e (G.dir j s)) {r : ℝ} (hr : r ∈ Ioc 0 s₀)
    {p : Fin n} {s : ℝ} (hs : s ∈ Ioo 0 r) :
    ∃ ε > 0, ball (branchPt v (G.β (BranchGerms.next p)) (G.κ (BranchGerms.next p)) s) ε ⊆
      G.sector v r p ∪ G.sector v r (BranchGerms.next p) ∪
        branchPt v (G.β (BranchGerms.next p)) (G.κ (BranchGerms.next p)) '' Ioo 0 r := by
  set j := BranchGerms.next p with hj
  set x := branchPt v (G.β j) (G.κ j) s with hx
  have hn : 0 < n := p.pos
  have hdisj' : ∀ i l, i ≠ l → ∀ t ∈ Ioo 0 r, e (G.dir i t) ≠ e (G.dir l t) :=
    fun i l hil t ht => hdisj i l hil t ⟨ht.1, ht.2.trans_le hr.2⟩
  have hrr₀ : r ∈ Ioc 0 r₀ := ⟨hr.1, hr.2.trans hs₀⟩
  have hxn : ‖x - v‖ = s := norm_branchPt_sub v _ _ hs.1.le
  set Bad : Set ℂ := (⋃ i ∈ {i : Fin n | i ≠ p ∧ i ≠ j}, closure (G.sector v r i)) ∪
    (⋃ l ∈ {l : Fin n | l ≠ j}, branchPt v (G.β l) (G.κ l) '' Icc 0 r) ∪ closedBall v 0 ∪ (ball v r)ᶜ with hBad
  have hBadc : IsClosed Bad := by
    refine ((((Set.toFinite _).isClosed_biUnion fun i _ => isClosed_closure).union
      ((Set.toFinite _).isClosed_biUnion fun l _ => (isCompact_Icc.image (continuous_branchPt v _ _)).isClosed)).union
      isClosed_closedBall).union isOpen_ball.isClosed_compl
  have hxBad : x ∉ Bad := by
    rintro (((h | h) | h) | h)
    · obtain ⟨i, ⟨hip, hij⟩, hi⟩ := mem_iUnion₂.mp h
      rcases hC.eq_or_next_eq_of_mem_closure (hr.2.trans hs₀) hdisj' hs hi with h' | h'
      · exact hij h'
      · exact hip (BranchGerms.next_injective h')
    · obtain ⟨l, hl, t, ht, hlt⟩ := mem_iUnion₂.mp h
      have htn : t = s := by
        have := norm_branchPt_sub v (G.β l) (G.κ l) ht.1
        rw [hlt, hxn] at this; exact this.symm
      rw [htn] at hlt
      exact hl (eq_of_branchPt_eq hdisj' hs hlt)
    · rw [mem_closedBall, dist_eq_norm, hxn] at h; linarith [hs.1]
    · exact h (by rw [mem_ball, dist_eq_norm, hxn]; exact hs.2)
  obtain ⟨ε, hε, hεB⟩ := Metric.isOpen_iff.mp hBadc.isOpen_compl x hxBad
  refine ⟨ε, hε, fun y hy => ?_⟩
  have hyB : y ∉ Bad := hεB hy
  have hyr : y ∈ ball v r := by by_contra h; exact hyB (Or.inr h)
  have hyv : y ≠ v := by
    rintro rfl; exact hyB (Or.inl (Or.inr (mem_closedBall_self le_rfl)))
  by_cases hyI : y ∈ F.interiorPts
  · have : y ∈ ball v r ∩ F.interiorPts := ⟨hyr, hyI⟩
    rw [hC.cover r hrr₀ hn] at this
    obtain ⟨i, hi⟩ := mem_iUnion.mp this
    by_cases hip : i = p
    · subst hip; exact Or.inl (Or.inl hi)
    by_cases hij : i = j
    · rw [hij] at hi; exact Or.inl (Or.inr hi)
    · exact absurd (show y ∈ Bad from Or.inl (Or.inl (Or.inl (mem_iUnion₂.mpr ⟨i, ⟨hip, hij⟩, subset_closure hi⟩)))) hyB
  · obtain ⟨l, hl⟩ := hC.exists_branchPt_eq hyv (ball_subset_ball hrr₀.2 hyr) hyI
    have hyn : ‖y - v‖ ∈ Ioo 0 r := ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hyv), by rw [← dist_eq_norm]; exact hyr⟩
    by_cases hlj : l = j
    · rw [hlj] at hl; exact Or.inr ⟨‖y - v‖, hyn, hl.symm⟩
    · exact absurd (show y ∈ Bad from
        Or.inl (Or.inl (Or.inr (mem_iUnion₂.mpr ⟨l, hlj, ‖y - v‖, ⟨hyn.1.le, hyn.2.le⟩, hl.symm⟩)))) hyB

end ArcMap

/-! ## The data near a point: a chart, its ordered radius, a good ball, the sectors' colours -/

namespace ArcMap

variable {k : ℕ}

/-- **The data the moves read near `v`**: a sector chart out to `r₀`, a radius `s₀ ≤ r₀` below which the germs are apart and
ordered, a good ball of radius `ρ₀`, and each chart sector's colour. -/
structure Near (F : ArcMap k) (v : ℂ) where
  /-- The number of germs. -/
  n : ℕ
  /-- The germs. -/
  G : BranchGerms n
  /-- The chart's radius. -/
  r₀ : ℝ
  /-- The radius below which the germs are apart and ordered. -/
  s₀ : ℝ
  /-- A good radius. -/
  ρ₀ : ℝ
  /-- The colour of each chart sector. -/
  col : Fin n → Fin k
  hC : F.IsSectorChart G v r₀
  hs₀ : s₀ ∈ Ioc 0 r₀
  hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 s₀, e (G.dir i s) ≠ e (G.dir j s)
  hord : ∀ s ∈ Ioo 0 s₀, ∀ i, G.dir i s < G.nextDir i s
  hG : F.GoodAt v ρ₀
  hcol : ∀ i, ∀ r ∈ Ioc 0 r₀, G.sector v r i ⊆ F.region (col i)

/-- Every point of the domain has its near data. -/
theorem exists_near {F : ArcMap k} {v : ℂ} (hv : v ∈ F.dom) : Nonempty (F.Near v) := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  obtain ⟨s₀, hs₀, hs₀r₀, hdisj, hord⟩ := hC.eventually_ord
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hv
  choose col hcol using hC.exists_col
  exact ⟨⟨n, G, r₀, s₀, ρ₀, col, hC, ⟨hs₀, hs₀r₀⟩, hdisj, hord, hG, hcol⟩⟩

namespace Near

variable {F : ArcMap k} {v : ℂ} (X : F.Near v)

/-- A radius small enough for the moves: below the ordered radius, the good radius and `1/2`. -/
def Small (ρ : ℝ) : Prop := 0 < ρ ∧ ρ < X.s₀ ∧ ρ < X.ρ₀ ∧ ρ < 1 / 2

theorem eventually_small : ∀ᶠ ρ in 𝓝[>] (0 : ℝ), X.Small ρ := by
  have h := lt_min (lt_min X.hs₀.1 X.hG.pos) (by norm_num : (0 : ℝ) < 1 / 2)
  filter_upwards [Ioo_mem_nhdsGT h] with ρ hρ
  exact ⟨hρ.1, lt_of_lt_of_le hρ.2 ((min_le_left _ _).trans (min_le_left _ _)),
    lt_of_lt_of_le hρ.2 ((min_le_left _ _).trans (min_le_right _ _)), lt_of_lt_of_le hρ.2 (min_le_right _ _)⟩

include X in
theorem mem_dom : v ∈ F.dom := X.hG.subdom (mem_ball_self X.hG.pos)

variable {X}

theorem Small.lt_r₀ {ρ : ℝ} (h : X.Small ρ) : ρ < X.r₀ := h.2.1.trans_le X.hs₀.2

theorem Small.mem_Ioc {ρ : ℝ} (h : X.Small ρ) : ρ ∈ Ioc 0 X.r₀ := ⟨h.1, h.lt_r₀.le⟩

theorem Small.curv {ρ : ℝ} (h : X.Small ρ) (i : Fin X.n) : |X.G.κ i| * ρ ≤ 2 :=
  ((mul_le_mul_of_nonneg_left h.lt_r₀.le (abs_nonneg _)).trans (X.hC.curv i).le)

variable (X)

/-- The sector colours at the ordered radius. -/
theorem hcol₀ : ∀ i, X.G.sector v X.s₀ i ⊆ F.region (X.col i) := fun i => X.hcol i X.s₀ X.hs₀

/-- The chart's germ arc out to `ρ`. -/
noncomputable def germ (ρ : ℝ) (i : Fin X.n) : Arc := germArc v (X.G.β i) (X.G.κ i) ρ

variable {X}

theorem carrier_germ {ρ : ℝ} (h : X.Small ρ) (i : Fin X.n) :
    (X.germ ρ i).carrier = branchPt v (X.G.β i) (X.G.κ i) '' Icc 0 ρ :=
  carrier_germArc v _ h.1.le (h.curv i)

/-- **A point of the open ball on a germ arc** is `v` or the germ's branch point at its distance. -/
theorem mem_carrier_germ_iff {ρ : ℝ} (h : X.Small ρ) (i : Fin X.n) {z : ℂ} (hz : z ∈ ball v ρ) :
    z ∈ (X.germ ρ i).carrier ↔ z = v ∨ (z ≠ v ∧ z = branchPt v (X.G.β i) (X.G.κ i) ‖z - v‖) := by
  rw [carrier_germ h]
  constructor
  · rintro ⟨s, hs, rfl⟩
    rcases eq_or_lt_of_le hs.1 with h0 | h0
    · left; rw [← h0]; simp [branchPt]
    · right
      have hn := norm_branchPt_sub v (X.G.β i) (X.G.κ i) hs.1
      refine ⟨fun h' => by rw [h', sub_self, norm_zero] at hn; linarith, by rw [hn]⟩
  · rintro (rfl | ⟨-, hz'⟩)
    · exact ⟨0, ⟨le_rfl, h.1.le⟩, by simp [branchPt]⟩
    · refine ⟨‖z - v‖, ⟨norm_nonneg _, ?_⟩, hz'.symm⟩
      rw [mem_ball, dist_eq_norm] at hz; exact hz.le

/-- **A point of the punctured small ball is interior to `F` exactly when it is on no branch.** -/
theorem mem_interiorPts_iff {ρ : ℝ} (h : X.Small ρ) {z : ℂ} (hz : z ∈ ball v ρ) (hzv : z ≠ v) :
    z ∈ F.interiorPts ↔ ∀ i, z ≠ branchPt v (X.G.β i) (X.G.κ i) ‖z - v‖ := by
  have hzr : z ∈ ball v X.r₀ := ball_subset_ball h.lt_r₀.le hz
  have hzn : ‖z - v‖ ∈ Ioo 0 X.r₀ := ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), by rw [← dist_eq_norm]; exact hzr⟩
  constructor
  · intro hI i heq
    have := X.hC.branchPt_mem_Γ i hzn
    rw [← heq] at this
    exact hI.2 this.2
  · intro hne
    by_contra hI
    obtain ⟨m, hm⟩ := X.hC.exists_branchPt_eq hzv hzr hI
    exact hne m hm

/-- `v` lies on the arcs when the chart has a germ. -/
theorem mem_Γ (X : F.Near v) (hn : 0 < X.n) : v ∈ F.Γ := X.hC.mem_Γ.mpr hn

end Near

end ArcMap

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} (X : F.Near v)

/-- **The arcs a move adds inside `B̄(v, ρ)`**: the arcs of the kept germs `K`, extra arcs `E`, and the whole circle `∂B(v, ρ)`. -/
def newArcs (ρ : ℝ) (K : Set (Fin X.n)) (E : Set Arc) : Set Arc := X.germ ρ '' K ∪ E ∪ {Arc.circ v ρ 0 (2 * π)}

variable {X}

theorem circ_nondegenerate {ρ : ℝ} (hρ : 0 < ρ) : (Arc.circ v ρ 0 (2 * π)).Nondegenerate :=
  ⟨hρ, by positivity, by linarith⟩

theorem newArcs_nondegenerate {ρ : ℝ} (h : X.Small ρ) {K : Set (Fin X.n)} {E : Set Arc} (hE : ∀ a ∈ E, a.Nondegenerate) :
    ∀ a ∈ X.newArcs ρ K E, a.Nondegenerate := by
  rintro a ((⟨i, -, rfl⟩ | ha) | ha)
  · exact germArc_nondegenerate v _ _ h.1
  · exact hE a ha
  · rw [mem_singleton_iff] at ha; subst ha; exact circ_nondegenerate h.1

theorem newArcs_finite {ρ : ℝ} {K : Set (Fin X.n)} {E : Set Arc} (hE : E.Finite) : (X.newArcs ρ K E).Finite :=
  (((Set.toFinite K).image _).union hE).union (finite_singleton _)

theorem newArcs_subset_closedBall {ρ : ℝ} (h : X.Small ρ) {K : Set (Fin X.n)} {E : Set Arc}
    (hE : ∀ a ∈ E, a.carrier ⊆ closedBall v ρ) : ∀ a ∈ X.newArcs ρ K E, a.carrier ⊆ closedBall v ρ := by
  rintro a ((⟨i, -, rfl⟩ | ha) | ha)
  · rw [carrier_germ h]
    rintro z ⟨s, hs, rfl⟩
    rw [mem_closedBall, dist_eq_norm, norm_branchPt_sub v _ _ hs.1]; exact hs.2
  · exact hE a ha
  · rw [mem_singleton_iff] at ha; subst ha
    rw [carrier_circ_full' v h.1]; exact sphere_subset_closedBall

theorem sphere_subset_newArcs {ρ : ℝ} (h : X.Small ρ) {K : Set (Fin X.n)} {E : Set Arc} :
    sphere v ρ ⊆ ⋃ a ∈ X.newArcs ρ K E, a.carrier := fun z hz =>
  mem_iUnion₂.mpr ⟨_, Or.inr rfl, by rw [carrier_circ_full' v h.1]; exact hz⟩

/-- A germ's arc lies in `Γ` (its points are `v` and branch points). -/
theorem germ_subset_Γ {ρ : ℝ} (h : X.Small ρ) (i : Fin X.n) : (X.germ ρ i).carrier ⊆ F.Γ := by
  rw [carrier_germ h]
  rintro z ⟨s, hs, rfl⟩
  rcases eq_or_lt_of_le hs.1 with h0 | h0
  · rw [← h0]; simpa [branchPt] using X.mem_Γ i.pos
  · exact X.hC.branchPt_mem_Γ i ⟨h0, hs.2.trans_lt h.lt_r₀⟩

theorem newArcs_unit {ρ : ℝ} (h : X.Small ρ) {K : Set (Fin X.n)} {E : Set Arc} (hE : ∀ a ∈ E, ¬ a.IsUnitArc) :
    ∀ a ∈ X.newArcs ρ K E, a.IsUnitArc → a.carrier ∩ F.dom ⊆ F.Γ := by
  rintro a ((⟨i, -, rfl⟩ | ha) | ha) hu
  · exact fun z hz => germ_subset_Γ h i hz.1
  · exact absurd hu (hE a ha)
  · rw [mem_singleton_iff] at ha; subst ha
    exact absurd hu (by show ρ ≠ 1; linarith [h.2.2.2])

theorem newArcs_condition5 {ρ : ℝ} (h : X.Small ρ) {K : Set (Fin X.n)} {E : Set Arc}
    (hE : ∀ a ∈ E, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    F.Condition5 → ∀ a ∈ X.newArcs ρ K E, ∀ p, (a.carrier ∩ F.dom ∩ sphere p 1).Finite := by
  intro h5
  rintro a ((⟨i, -, rfl⟩ | ha) | ha) p
  · refine (finite_inter_sphere_of_subset_Γ X.hG h5 (C := (X.germ ρ i).carrier) ?_ p).subset
      fun z hz => ⟨hz.1.1, hz.2⟩
    intro z hz
    refine ⟨germ_subset_Γ h i hz, ?_⟩
    have := newArcs_subset_closedBall (K := {i}) (E := ∅) h (fun _ h => absurd h (notMem_empty _)) _
      (Or.inl (Or.inl ⟨i, rfl, rfl⟩)) hz
    exact closedBall_subset_ball h.2.2.1 this
  · exact (hE a ha p).subset fun z hz => ⟨hz.1.1, hz.2⟩
  · rw [mem_singleton_iff] at ha; subst ha
    rcases Arc.finite_inter_sphere_or_eq_circ _ (circ_nondegenerate h.1) p with hf | ⟨θ₀, θ₁, heq⟩
    · exact hf.subset fun z hz => ⟨hz.1.1, hz.2⟩
    · simp only [Arc.circ.injEq] at heq; linarith [h.2.2.2, heq.2.1]

/-- **Membership in the new arcs in the open ball**: `v` (when a germ is kept), a kept germ's branch point, or an extra arc. -/
theorem mem_newArcs_iff {ρ : ℝ} (h : X.Small ρ) {K : Set (Fin X.n)} (hK : K.Nonempty) {E : Set Arc} {z : ℂ}
    (hz : z ∈ ball v ρ) :
    z ∈ ⋃ a ∈ X.newArcs ρ K E, a.carrier ↔
      z = v ∨ (z ≠ v ∧ ∃ i ∈ K, z = branchPt v (X.G.β i) (X.G.κ i) ‖z - v‖) ∨ z ∈ ⋃ a ∈ E, a.carrier := by
  constructor
  · intro hm
    obtain ⟨a, ((⟨i, hi, rfl⟩ | ha) | ha), hza⟩ := mem_iUnion₂.mp hm
    · rcases (mem_carrier_germ_iff h i hz).mp hza with h1 | ⟨h1, h2⟩
      · exact Or.inl h1
      · exact Or.inr (Or.inl ⟨h1, i, hi, h2⟩)
    · exact Or.inr (Or.inr (mem_iUnion₂.mpr ⟨a, ha, hza⟩))
    · rw [mem_singleton_iff] at ha; subst ha
      rw [carrier_circ_full' v h.1, mem_sphere] at hza
      rw [mem_ball] at hz; linarith
  · rintro (rfl | ⟨h1, i, hi, h2⟩ | hE)
    · obtain ⟨i, hi⟩ := hK
      exact mem_iUnion₂.mpr ⟨_, Or.inl (Or.inl ⟨i, hi, rfl⟩), (mem_carrier_germ_iff h i hz).mpr (Or.inl rfl)⟩
    · exact mem_iUnion₂.mpr ⟨_, Or.inl (Or.inl ⟨i, hi, rfl⟩), (mem_carrier_germ_iff h i hz).mpr (Or.inr ⟨h1, h2⟩)⟩
    · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hE
      exact mem_iUnion₂.mpr ⟨a, Or.inl (Or.inr ha), hza⟩

/-- **The move at `v`**: the surgery with the new arcs `X.newArcs ρ K E` and the colouring `col'`. -/
noncomputable def move {ρ : ℝ} (h : X.Small ρ) (K : Set (Fin X.n)) (E : Set Arc) (col' : ℂ → Fin k)
    (hE : ∀ a ∈ E, a.Nondegenerate) (hEf : E.Finite)
    (hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ K E, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x) : ArcMap k :=
  F.surgery v ρ (X.newArcs ρ K E) col' X.mem_dom h.1 (newArcs_nondegenerate h hE) (newArcs_finite hEf) hlc

section Move

variable {ρ : ℝ} {h : X.Small ρ} {K : Set (Fin X.n)} {E : Set Arc} {col' : ℂ → Fin k}
  {hE : ∀ a ∈ E, a.Nondegenerate} {hEf : E.Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ K E, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}

theorem move_dom : (X.move h K E col' hE hEf hlc).dom = F.dom := rfl
theorem move_col : (X.move h K E col' hE hEf hlc).col = col' := rfl

/-- In the open ball, the move's interior points are the points off the new arcs. -/
theorem mem_move_interiorPts_iff {z : ℂ} (hz : z ∈ ball v ρ) :
    z ∈ (X.move h K E col' hE hEf hlc).interiorPts ↔ z ∉ ⋃ a ∈ X.newArcs ρ K E, a.carrier := by
  have hd : z ∈ F.dom := X.hG.subdom (ball_subset_ball h.2.2.1.le hz)
  unfold move
  show z ∈ F.dom \ _ ↔ _
  rw [Set.mem_sdiff, surgery_mem_arcs_iff_of_mem X.hG h.2.2.1 hz]
  exact ⟨fun h' => h'.2, fun h' => ⟨hd, h'⟩⟩

/-- Off the closed ball, the move has `F`'s interior points. -/
theorem mem_move_interiorPts_iff_of_not_mem (hEin : ∀ a ∈ E, a.carrier ⊆ closedBall v ρ) {z : ℂ} (hz : z ∉ closedBall v ρ) :
    z ∈ (X.move h K E col' hE hEf hlc).interiorPts ↔ z ∈ F.interiorPts := by
  unfold move
  show z ∈ F.dom \ _ ↔ z ∈ F.dom \ _
  rw [Set.mem_sdiff, Set.mem_sdiff, surgery_mem_arcs_iff_of_not_mem (newArcs_subset_closedBall h hEin) hz]

/-- No point of the circle `∂B(v, ρ)` is interior to the move. -/
theorem not_mem_move_interiorPts_of_sphere {z : ℂ} (hz : z ∈ sphere v ρ) :
    z ∉ (X.move h K E col' hE hEf hlc).interiorPts := fun hI =>
  hI.2 (mem_iUnion₂.mpr ⟨_, Or.inr (Or.inr rfl), by rw [carrier_circ_full' v h.1]; exact hz⟩)

theorem move_agreesOff (hEin : ∀ a ∈ E, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z) :
    (X.move h K E col' hE hEf hlc).AgreesOff F (closedBall v ρ) :=
  surgery_agreesOff (newArcs_subset_closedBall h hEin) hcol

theorem move_ringArcsWithin (hEu : ∀ a ∈ E, ¬ a.IsUnitArc) : (X.move h K E col' hE hEf hlc).RingArcsWithin F :=
  surgery_ringArcsWithin (newArcs_unit h hEu)

theorem move_condition5 (hE5 : ∀ a ∈ E, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    F.Condition5 → (X.move h K E col' hE hEf hlc).Condition5 :=
  surgery_condition5 (newArcs_condition5 h hE5)

/-- **The move is valid** when every interior point of the ball is clear in `F` for its new colour. -/
theorem move_valid (hF : F.Valid) (hEin : ∀ a ∈ E, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z)
    (hclear : ∀ z ∈ ball v ρ, z ∈ (X.move h K E col' hE hEf hlc).interiorPts → F.IsClear (col' z) z) :
    (X.move h K E col' hE hEf hlc).Valid := by
  refine Valid.of_agreesOff hF (move_agreesOff hEin hcol) (fun z hz => ?_) (fun z hz y hy hzy => ?_)
  · obtain ⟨hzU, hzI⟩ := hz
    rcases lt_or_eq_of_le (mem_closedBall.mp hzU) with hlt | heq
    · exact hclear z hlt hzI
    · exact absurd hzI (not_mem_move_interiorPts_of_sphere heq)
  · exfalso
    have := dist_triangle_right z y v
    have hzU := mem_closedBall.mp hz.1
    have hyU := mem_closedBall.mp hy.1
    linarith [h.2.2.2]

end Move

end Near

end ArcMap

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v}

section MoveColours

variable {ρ : ℝ} {h : X.Small ρ} {K : Set (Fin X.n)} {E : Set Arc} {col' : ℂ → Fin k}
  {hE : ∀ a ∈ E, a.Nondegenerate} {hEf : E.Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ K E, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}

/-- **`v` gains no colour** when every interior point of the ball keeps its point and colour of `F`, or takes a colour `F` carries
at `v`. -/
theorem move_coloursAt_self
    (hin : ∀ z ∈ ball v ρ, z ∈ (X.move h K E col' hE hEf hlc).interiorPts →
      col' z ∈ F.coloursAt v ∨ (z ∈ F.interiorPts ∧ col' z = F.col z)) :
    (X.move h K E col' hE hEf hlc).coloursAt v ⊆ F.coloursAt v := by
  intro j hj
  by_contra hjF
  have hj : v ∈ closure ((X.move h K E col' hE hEf hlc).region j) := hj
  have hj' : v ∈ closure ((X.move h K E col' hE hEf hlc).region j ∩ ball v ρ) := by
    rw [mem_closure_iff_nhds] at hj ⊢
    intro t ht
    obtain ⟨y, hyt, hyj⟩ := hj (t ∩ ball v ρ) (inter_mem ht (isOpen_ball.mem_nhds (mem_ball_self h.1)))
    exact ⟨y, hyt.1, hyj, hyt.2⟩
  apply hjF
  refine closure_mono ?_ hj'
  rintro z ⟨⟨hzI, hzj⟩, hzb⟩
  have hzj' : col' z = j := hzj
  rcases hin z hzb hzI with h1 | ⟨h1, h2⟩
  · exact absurd (hzj' ▸ h1) hjF
  · exact ⟨h1, by show F.col z = j; rw [← h2, hzj']⟩

/-- **The colours at a point of the circle `∂B(v, ρ)`** after a move: `F`'s there, and the colours `C` of the recoloured set `R`
when the point is in its closure. -/
theorem move_coloursAt_sphere (hEin : ∀ a ∈ E, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z)
    {R : Set ℂ} {C : Set (Fin k)}
    (hR : ∀ z ∈ ball v ρ, z ∈ (X.move h K E col' hE hEf hlc).interiorPts → z ∉ R → z ∈ F.interiorPts ∧ col' z = F.col z)
    (hRC : ∀ z ∈ R ∩ ball v ρ, z ∈ (X.move h K E col' hE hEf hlc).interiorPts → col' z ∈ C) (x : ℂ) :
    (X.move h K E col' hE hEf hlc).coloursAt x ⊆ F.coloursAt x ∪ {j | x ∈ closure R ∧ j ∈ C} := by
  intro j hj
  have hj : x ∈ closure ((X.move h K E col' hE hEf hlc).region j) := hj
  have hsub : (X.move h K E col' hE hEf hlc).region j ⊆ F.region j ∪ (R ∩ {z | j ∈ C}) := by
    rintro z ⟨hzI, hzj⟩
    have hzj' : col' z = j := hzj
    rcases lt_trichotomy (dist z v) ρ with hlt | heq | hgt
    · by_cases hzR : z ∈ R
      · exact Or.inr ⟨hzR, by rw [mem_setOf_eq, ← hzj']; exact hRC z ⟨hzR, hlt⟩ hzI⟩
      · obtain ⟨h1, h2⟩ := hR z hlt hzI hzR
        exact Or.inl ⟨h1, by show F.col z = j; rw [← h2, hzj']⟩
    · exact absurd hzI (not_mem_move_interiorPts_of_sphere heq)
    · have hzc : z ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
      refine Or.inl ⟨(mem_move_interiorPts_iff_of_not_mem hEin hzc).mp hzI, ?_⟩
      show F.col z = j; rw [← hcol z hzc, hzj']
  have := closure_mono hsub hj
  rw [closure_union] at this
  rcases this with h1 | h1
  · exact Or.inl h1
  · refine Or.inr ⟨closure_mono inter_subset_left h1, ?_⟩
    obtain ⟨z, hz⟩ : (R ∩ {z | j ∈ C}).Nonempty := by
      by_contra hc; rw [not_nonempty_iff_eq_empty] at hc; rw [hc, closure_empty] at h1; exact h1
    exact hz.2

end MoveColours

end Near

end ArcMap

/-! ## The cut: merging two sectors of one colour across the germ between them -/

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} (X : F.Near v)

/-- The cut branch: germ `j`'s branch inside `B(v, ρ)`. -/
def cutSet (ρ : ℝ) (j : Fin X.n) : Set ℂ := branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 ρ

/-- The cut's colouring: `c` on the cut branch, `F`'s elsewhere. -/
noncomputable def cutCol (ρ : ℝ) (j : Fin X.n) (c : Fin k) : ℂ → Fin k := fun z => by
  classical exact if z ∈ X.cutSet ρ j then c else F.col z

variable {X}

theorem cutCol_of_mem {ρ : ℝ} {j : Fin X.n} {c : Fin k} {z : ℂ} (hz : z ∈ X.cutSet ρ j) : X.cutCol ρ j c z = c := by
  simp [cutCol, hz]

theorem cutCol_of_not_mem {ρ : ℝ} {j : Fin X.n} {c : Fin k} {z : ℂ} (hz : z ∉ X.cutSet ρ j) :
    X.cutCol ρ j c z = F.col z := by
  simp [cutCol, hz]

theorem norm_of_mem_cutSet {ρ : ℝ} {j : Fin X.n} {z : ℂ} (hz : z ∈ X.cutSet ρ j) :
    ‖z - v‖ ∈ Ioo 0 ρ ∧ z = branchPt v (X.G.β j) (X.G.κ j) ‖z - v‖ := by
  obtain ⟨s, hs, rfl⟩ := hz
  rw [norm_branchPt_sub v _ _ hs.1.le]; exact ⟨hs, rfl⟩

theorem cutSet_subset_ball {ρ : ℝ} {j : Fin X.n} : X.cutSet ρ j ⊆ ball v ρ := fun z hz => by
  rw [mem_ball, dist_eq_norm]; exact (norm_of_mem_cutSet hz).1.2

theorem ne_of_mem_cutSet {ρ : ℝ} {j : Fin X.n} {z : ℂ} (hz : z ∈ X.cutSet ρ j) : z ≠ v := fun h' => by
  have := (norm_of_mem_cutSet hz).1.1; rw [h', sub_self, norm_zero] at this; exact lt_irrefl 0 this

theorem not_mem_interiorPts_of_mem_cutSet {ρ : ℝ} (h : X.Small ρ) {j : Fin X.n} {z : ℂ} (hz : z ∈ X.cutSet ρ j) :
    z ∉ F.interiorPts := by
  obtain ⟨s, hs, rfl⟩ := hz
  exact fun hI => hI.2 (X.hC.branchPt_mem_Γ j ⟨hs.1, hs.2.trans h.lt_r₀⟩).2

theorem cutSet_subset_closure {ρ : ℝ} (h : X.Small ρ) {j : Fin X.n} :
    X.cutSet ρ j ⊆ closure (F.region (X.col j)) := by
  rintro z ⟨s, hs, rfl⟩
  exact closure_mono (X.hcol₀ j) (IsSectorChart.branchPt_mem_closure_sector_after X.hord le_rfl j ⟨hs.1, hs.2.trans h.2.1⟩)

theorem closure_cutSet_subset {ρ : ℝ} {j : Fin X.n} :
    closure (X.cutSet ρ j) ⊆ branchPt v (X.G.β j) (X.G.κ j) '' Icc 0 ρ :=
  closure_minimal (image_mono Ioo_subset_Icc_self) (isCompact_Icc.image (continuous_branchPt v _ _)).isClosed

/-- In the punctured small ball a point off the branches of the kept germs `≠ j` is interior to `F` or on the cut. -/
theorem mem_interiorPts_or_cutSet {ρ : ℝ} (h : X.Small ρ) {j : Fin X.n} {z : ℂ} (hz : z ∈ ball v ρ) (hzv : z ≠ v)
    (hne : ∀ i, i ≠ j → z ≠ branchPt v (X.G.β i) (X.G.κ i) ‖z - v‖) : z ∈ F.interiorPts ∨ z ∈ X.cutSet ρ j := by
  by_cases hzj : z = branchPt v (X.G.β j) (X.G.κ j) ‖z - v‖
  · right
    refine ⟨‖z - v‖, ⟨norm_pos_iff.mpr (sub_ne_zero.mpr hzv), by rw [← dist_eq_norm]; exact hz⟩, hzj.symm⟩
  · left
    refine (X.mem_interiorPts_iff h hz hzv).mpr fun i => ?_
    by_cases hij : i = j
    · rw [hij]; exact hzj
    · exact hne i hij

variable (X)

/-- The cut's colouring is locally constant off the new arcs (`X.newArcs ρ {i | i ≠ j} ∅`), when the sectors on the two sides of
germ `j = next p` have the colour `c`. -/
theorem cut_hlc {ρ : ℝ} (h : X.Small ρ) {p : Fin X.n} (hpj : p ≠ BranchGerms.next p) {c : Fin k} (hp : X.col p = c)
    (hj : X.col (BranchGerms.next p) = c) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.newArcs ρ {i | i ≠ BranchGerms.next p} ∅, a.carrier →
      ∀ᶠ y in 𝓝 x, X.cutCol ρ (BranchGerms.next p) c y = X.cutCol ρ (BranchGerms.next p) c x := by
  set j := BranchGerms.next p with hjdef
  refine surgery_hlc_of X.hG h.1 (fun z hz => cutCol_of_not_mem fun hz' =>
    hz (ball_subset_closedBall (cutSet_subset_ball hz'))) (sphere_subset_newArcs h) fun x hx hxA => ?_
  have hK : ({i | i ≠ j} : Set (Fin X.n)).Nonempty := ⟨p, hpj⟩
  rw [mem_newArcs_iff h hK hx] at hxA
  push Not at hxA
  obtain ⟨hxv, hxb, -⟩ := hxA
  have hne : ∀ i, i ≠ j → x ≠ branchPt v (X.G.β i) (X.G.κ i) ‖x - v‖ := fun i hi => hxb hxv i hi
  rcases mem_interiorPts_or_cutSet h hx hxv hne with hI | hcut
  · -- an interior point away from the cut
    have hxcl : x ∉ closure (X.cutSet ρ j) := by
      intro hcl
      obtain ⟨t, ht, hxt⟩ := closure_cutSet_subset hcl
      have htn : t = ‖x - v‖ := by rw [← hxt, norm_branchPt_sub v _ _ ht.1]
      rcases eq_or_lt_of_le ht.1 with h0 | h0
      · rw [← h0] at hxt; exact hxv (by rw [← hxt]; simp [branchPt])
      · have hxs : ‖x - v‖ < ρ := by rw [← dist_eq_norm]; exact hx
        have hcut : x ∈ X.cutSet ρ j := ⟨t, ⟨h0, htn ▸ hxs⟩, hxt⟩
        exact not_mem_interiorPts_of_mem_cutSet h hcut hI
    have hev : ∀ᶠ y in 𝓝 x, y ∉ X.cutSet ρ j := by
      have := isClosed_closure.isOpen_compl.mem_nhds hxcl
      filter_upwards [this] with y hy hy' using hy (subset_closure hy')
    filter_upwards [F.locallyConstant x hI.1 hI.2, hev] with y hy hy'
    rw [cutCol_of_not_mem hy', cutCol_of_not_mem (fun h' => hev.self_of_nhds h'), hy]
  · -- a point of the cut: near it, the two sectors beside germ `j` and the cut itself, all coloured `c`
    obtain ⟨hsn, hxj⟩ := norm_of_mem_cutSet hcut
    obtain ⟨ε, hε, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj ⟨h.1, h.2.1.le⟩ (p := p) hsn
    rw [← hjdef, ← hxj] at hball
    filter_upwards [Metric.ball_mem_nhds x hε] with y hy
    rw [cutCol_of_mem hcut]
    rcases hball hy with (hy' | hy') | hy'
    · have hyI := X.hC.sector_subset_interiorPts p.pos h.mem_Ioc p hy'
      rw [cutCol_of_not_mem fun h' => not_mem_interiorPts_of_mem_cutSet h h' hyI]
      have := (X.hcol p ρ h.mem_Ioc hy').2
      simp only [mem_preimage, mem_singleton_iff] at this; rw [this, hp]
    · have hyI := X.hC.sector_subset_interiorPts p.pos h.mem_Ioc j hy'
      rw [cutCol_of_not_mem fun h' => not_mem_interiorPts_of_mem_cutSet h h' hyI]
      have := (X.hcol j ρ h.mem_Ioc hy').2
      simp only [mem_preimage, mem_singleton_iff] at this; rw [this, hj]
    · exact cutCol_of_mem hy'

end Near

end ArcMap

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {X : F.Near v}

/-- **The cut's sector count**: a map whose interior points in `B(v, ρ)` are `F`'s and the cut branch of germ `j = next p`, coloured
by the cut, has one sector of colour `c` fewer at `v` when the sectors `p` and `j` beside the germ both have colour `c`. -/
theorem cut_hasSectors {F' : ArcMap k} {ρ : ℝ} (h : X.Small ρ) {p : Fin X.n} (hpj : p ≠ BranchGerms.next p) {c : Fin k}
    (hp : X.col p = c) (hj : X.col (BranchGerms.next p) = c) {m : ℕ} (hm : {i | X.col i = c}.encard = m + 1)
    (hint : ∀ z ∈ ball v ρ, z ∈ F'.interiorPts ↔ z ≠ v ∧ (z ∈ F.interiorPts ∨ z ∈ X.cutSet ρ (BranchGerms.next p)))
    (hcol' : ∀ z, F'.col z = X.cutCol ρ (BranchGerms.next p) c z) : F'.HasSectors v c m := by
  set j := BranchGerms.next p with hjdef
  have hn : 0 < X.n := p.pos
  filter_upwards [Ioc_mem_nhdsGT h.1] with r hr
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr.1, hr.2.trans h.lt_r₀.le⟩
  have hrs : r ∈ Ioc 0 X.s₀ := ⟨hr.1, hr.2.trans h.2.1.le⟩
  set B := branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 r with hB
  set M := X.G.sector v r p ∪ B ∪ X.G.sector v r j with hM
  set A : {i : Fin X.n // i ≠ j} → Set ℂ := fun i => if i.1 = p then M else X.G.sector v r i.1 with hA
  have hsecI : ∀ i, X.G.sector v r i ⊆ F.interiorPts := X.hC.sector_subset_interiorPts hn hr₀
  have hsecv : ∀ i, ∀ z ∈ X.G.sector v r i, z ≠ v := fun i z hz h' => by
    obtain ⟨hs, -⟩ := X.G.mem_sector_iff.mp hz; rw [h', sub_self, norm_zero] at hs; exact lt_irrefl 0 hs.1
  have hBcut : B ⊆ X.cutSet ρ j := image_mono (Ioo_subset_Ioo_right hr.2)
  have hBball : B ⊆ ball v r := by
    rintro z ⟨s, hs, rfl⟩; rw [mem_ball, dist_eq_norm, norm_branchPt_sub v _ _ hs.1.le]; exact hs.2
  have hBI : ∀ z ∈ B, z ∉ F.interiorPts := fun z hz => not_mem_interiorPts_of_mem_cutSet h (hBcut hz)
  have hAp : A ⟨p, hpj⟩ = M := by simp [hA]
  have hAi : ∀ i : {i : Fin X.n // i ≠ j}, i.1 ≠ p → A i = X.G.sector v r i.1 := fun i hi => by simp [hA, hi]
  -- the partition
  have hU : F'.interiorPts ∩ ball v r = ⋃ i, A i := by
    ext z
    constructor
    · rintro ⟨hzI, hzr⟩
      obtain ⟨hzv, hz'⟩ := (hint z (ball_subset_ball hr.2 hzr)).mp hzI
      rcases hz' with hzF | hzc
      · have : z ∈ ball v r ∩ F.interiorPts := ⟨hzr, hzF⟩
        rw [X.hC.cover r hr₀ hn] at this
        obtain ⟨i, hi⟩ := mem_iUnion.mp this
        by_cases hij : i = j
        · rw [hij] at hi; exact mem_iUnion.mpr ⟨⟨p, hpj⟩, by rw [hAp]; exact Or.inr hi⟩
        by_cases hip : i = p
        · rw [hip] at hi; exact mem_iUnion.mpr ⟨⟨p, hpj⟩, by rw [hAp]; exact Or.inl (Or.inl hi)⟩
        · exact mem_iUnion.mpr ⟨⟨i, hij⟩, by rw [hAi ⟨i, hij⟩ hip]; exact hi⟩
      · obtain ⟨hsn, hzj⟩ := norm_of_mem_cutSet hzc
        have hzr' : ‖z - v‖ < r := by rw [← dist_eq_norm]; exact hzr
        exact mem_iUnion.mpr ⟨⟨p, hpj⟩, by rw [hAp]; exact Or.inl (Or.inr ⟨‖z - v‖, ⟨hsn.1, hzr'⟩, hzj.symm⟩)⟩
    · intro hz
      obtain ⟨i, hi⟩ := mem_iUnion.mp hz
      have key : z ∈ ball v r ∧ z ≠ v ∧ (z ∈ F.interiorPts ∨ z ∈ X.cutSet ρ j) := by
        by_cases hip : i.1 = p
        · rw [show A i = M by simp [hA, hip]] at hi
          rcases hi with (hi | hi) | hi
          · exact ⟨X.G.sector_subset_ball p hi, hsecv p z hi, Or.inl (hsecI p hi)⟩
          · exact ⟨hBball hi, ne_of_mem_cutSet (hBcut hi), Or.inr (hBcut hi)⟩
          · exact ⟨X.G.sector_subset_ball j hi, hsecv j z hi, Or.inl (hsecI j hi)⟩
        · rw [hAi i hip] at hi
          exact ⟨X.G.sector_subset_ball _ hi, hsecv _ z hi, Or.inl (hsecI _ hi)⟩
      exact ⟨(hint z (ball_subset_ball hr.2 key.1)).mpr ⟨key.2.1, key.2.2⟩, key.1⟩
  -- the merged piece is open and connected
  have hMopen : IsOpen M := by
    rw [Metric.isOpen_iff]
    intro z hz
    rcases hz with (hz | hz) | hz
    · obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp (X.hC.isOpen r hr₀ p) z hz
      exact ⟨ε, hε, fun y hy => Or.inl (Or.inl (hball hy))⟩
    · obtain ⟨s, hs, rfl⟩ := hz
      obtain ⟨ε, hε, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj hrs (p := p) hs
      refine ⟨ε, hε, fun y hy => ?_⟩
      rcases hball hy with (hy' | hy') | hy'
      · exact Or.inl (Or.inl hy')
      · exact Or.inr hy'
      · exact Or.inl (Or.inr hy')
    · obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp (X.hC.isOpen r hr₀ j) z hz
      exact ⟨ε, hε, fun y hy => Or.inr (hball hy)⟩
  have hMpre : IsPreconnected M := by
    have h1 : IsPreconnected (X.G.sector v r p ∪ B) := by
      refine (X.hC.isPreconnected r hr₀ p).subset_closure subset_union_left (union_subset subset_closure ?_)
      rintro z ⟨s, hs, rfl⟩
      exact IsSectorChart.branchPt_mem_closure_sector_before X.hord hrs.2 p hs
    have h2 : IsPreconnected (B ∪ X.G.sector v r j) := by
      refine (X.hC.isPreconnected r hr₀ j).subset_closure subset_union_right (union_subset ?_ subset_closure)
      rintro z ⟨s, hs, rfl⟩
      exact IsSectorChart.branchPt_mem_closure_sector_after X.hord hrs.2 j hs
    have hne : ((X.G.sector v r p ∪ B) ∩ (B ∪ X.G.sector v r j)).Nonempty :=
      ⟨_, Or.inr ⟨r / 2, ⟨by linarith [hr.1], by linarith [hr.1]⟩, rfl⟩,
        Or.inl ⟨r / 2, ⟨by linarith [hr.1], by linarith [hr.1]⟩, rfl⟩⟩
    have := h1.union' hne h2
    rwa [show X.G.sector v r p ∪ B ∪ (B ∪ X.G.sector v r j) = M by
      rw [hM]; ext z; simp only [mem_union]; tauto] at this
  have hdisjS := X.hC.disjoint r hr₀
  have hMdisj : ∀ i, i ≠ p → i ≠ j → Disjoint M (X.G.sector v r i) := by
    intro i hip hij
    refine disjoint_union_left.mpr ⟨disjoint_union_left.mpr ⟨hdisjS p i (Ne.symm hip), ?_⟩, hdisjS j i (Ne.symm hij)⟩
    exact disjoint_left.mpr fun z hzB hzi => hBI z hzB (hsecI i hzi)
  refine (encard_sectorsOf_of_partition (F := F') (A := A) (colA := fun i => X.col i.1) hU ?_ ?_ ?_ ?_ ?_ c).trans ?_
  · intro i
    by_cases hip : i.1 = p
    · rw [show A i = M by simp [hA, hip]]; exact hMopen
    · rw [hAi i hip]; exact X.hC.isOpen r hr₀ _
  · intro i
    by_cases hip : i.1 = p
    · rw [show A i = M by simp [hA, hip]]; exact hMpre
    · rw [hAi i hip]; exact X.hC.isPreconnected r hr₀ _
  · intro i i' hii'
    have hne : i.1 ≠ i'.1 := fun h' => hii' (Subtype.ext h')
    by_cases hip : i.1 = p <;> by_cases hip' : i'.1 = p
    · exact absurd (hip.trans hip'.symm) hne
    · rw [show A i = M by simp [hA, hip], hAi i' hip']
      exact hMdisj i'.1 hip' i'.2
    · rw [show A i' = M by simp [hA, hip'], hAi i hip]
      exact (hMdisj i.1 hip i.2).symm
    · rw [hAi i hip, hAi i' hip']; exact hdisjS _ _ hne
  · intro i _
    by_cases hip : i.1 = p
    · rw [show A i = M by simp [hA, hip]]
      exact closure_mono (subset_union_left.trans subset_union_left) (X.hC.mem_closure_sector hr₀ p)
    · rw [hAi i hip]; exact X.hC.mem_closure_sector hr₀ _
  · intro i z hz
    have hsec : ∀ l, z ∈ X.G.sector v r l → F'.col z = X.col l := fun l hzl => by
      rw [hcol', cutCol_of_not_mem fun h' => not_mem_interiorPts_of_mem_cutSet h h' (hsecI l hzl)]
      have := (X.hcol l r hr₀ hzl).2; simpa using this
    show F'.col z = X.col i.1
    by_cases hip : i.1 = p
    · rw [show A i = M by simp [hA, hip]] at hz
      rw [hip]
      rcases hz with (hz | hz) | hz
      · exact hsec p hz
      · rw [hcol', cutCol_of_mem (hBcut hz), hp]
      · rw [hsec j hz, hj, hp]
    · rw [hAi i hip] at hz; exact hsec _ hz
  · -- the count
    have hall : ∀ i, (A i).Nonempty := fun i => by
      by_cases hip : i.1 = p
      · rw [show A i = M by simp [hA, hip]]
        exact (X.hC.sector_nonempty hr₀ p).mono (subset_union_left.trans subset_union_left)
      · rw [hAi i hip]; exact X.hC.sector_nonempty hr₀ _
    have hset : {i | (A i).Nonempty ∧ X.col i.1 = c} = Subtype.val ⁻¹' ({i | X.col i = c} \ {j}) := by
      ext i; simp only [mem_setOf_eq, mem_preimage, Set.mem_sdiff, mem_singleton_iff]
      exact ⟨fun h' => ⟨h'.2, i.2⟩, fun h' => ⟨hall i, h'.1⟩⟩
    rw [hset, encard_preimage_of_injective_subset_range Subtype.val_injective (fun i hi => ⟨⟨i, hi.2⟩, rfl⟩)]
    have h1 := encard_sdiff_singleton_add_one (show j ∈ {i | X.col i = c} from hj)
    rw [hm] at h1
    exact ENat.add_left_injective_of_ne_top (by simp) h1

end Near

end ArcMap

end HadwigerNelson.Plane
