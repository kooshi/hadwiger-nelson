import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ}

--BEGIN
/-! ## Points of a step's disc other than its centre: no horn, no repeated colour (FS131-IR2)

A point `x ≠ v` of a move's closed disc lies on at most two curves of the new map (a germ or a new arc; at a junction, also the
rim circle). Read at `x`: if the arcs near `x` lie on finitely many branches from `x` with pairwise distinct directions, no sector
at `x` is a horn and the degree is at most the number of branches — one fewer if one branch is dead
(`hasHornCount_zero_of_germs`); a clean map has no repeated colour at a point of degree at most three
(`not_hasRepeatedColour_of_degree_le_three`: its consecutive sectors differ in colour, `Near.col_ne_next_of_isClean`). -/

/-- **In a clean map consecutive chart sectors have different colours** (a point of the germ between them carries only their
colours, and at least two). -/
theorem Near.col_ne_next_of_isClean {F : ArcMap k} {v : ℂ} (X : F.Near v) (hc : F.IsClean) (p : Fin X.n) :
    X.col p ≠ X.col (BranchGerms.next p) := by
  intro heq
  have hn : 0 < X.n := p.pos
  set q := BranchGerms.next p with hq
  have hs : X.s₀ / 2 ∈ Ioo 0 X.s₀ := ⟨by linarith [X.hs₀.1], by linarith [X.hs₀.1]⟩
  set x := branchPt v (X.G.β q) (X.G.κ q) (X.s₀ / 2) with hx
  have hxΓ : x ∈ F.Γ := X.hC.branchPt_mem_Γ q ⟨hs.1, hs.2.trans_le X.hs₀.2⟩
  have hnorm := norm_branchPt_sub v (X.G.β q) (X.G.κ q) hs.1.le
  have hxs : x ∈ ball v X.s₀ := by rw [mem_ball, dist_eq_norm, hnorm]; exact hs.2
  have hsub : F.coloursAt x ⊆ {X.col q} := by
    intro j hj
    obtain ⟨i, hi, rfl⟩ := X.hC.coloursAt_subset_image hn X.hs₀ X.hcol₀ hxs hj
    rcases X.hC.eq_or_next_eq_of_mem_closure X.hs₀.2 X.hdisj hs hi with h | h
    · rw [h]; exact mem_singleton _
    · have hip : i = p := BranchGerms.next_injective h
      rw [hip, heq]; exact mem_singleton _
  have h1 := ncard_le_ncard hsub (finite_singleton _)
  rw [ncard_singleton] at h1
  have h2 := hc x hxΓ
  omega

/-- A clean map has at least two germs at a point of its arcs (one germ would have one sector on both sides). -/
theorem Near.two_le_of_isClean {F : ArcMap k} {v : ℂ} (X : F.Near v) (hc : F.IsClean) (hn : 0 < X.n) : 2 ≤ X.n := by
  by_contra h
  have h1 : X.n = 1 := by omega
  have hp : BranchGerms.next (⟨0, hn⟩ : Fin X.n) = ⟨0, hn⟩ := by
    apply Fin.ext
    unfold BranchGerms.next
    split_ifs with h2
    · simp at h2; omega
    · rfl
  exact X.col_ne_next_of_isClean hc ⟨0, hn⟩ (by rw [hp])

/-- **A clean map has no repeated colour at a point of degree at most three**: two sectors of one colour would be consecutive. -/
theorem not_hasRepeatedColour_of_degree_le_three {F : ArcMap k} (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.dom) {m : ℕ}
    (hm : F.HasDegree x m) (h3 : m ≤ 3) : ¬ F.HasRepeatedColour x := by
  obtain ⟨X⟩ := exists_near hx
  have hn3 : X.n ≤ 3 := by
    have := hm.eq X.hC.hasDegree
    omega
  rintro ⟨c, hrep⟩
  obtain ⟨r, h2, hr⟩ := (hrep.and (Ioc_mem_nhdsGT X.hC.pos)).exists
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · have h1 := h2.trans (encard_le_encard (show F.sectorsOf x r c ⊆ {ball x r} from fun S hS =>
      (X.hC.isSector_iff_of_zero hn hr).mp hS.1))
    rw [encard_singleton] at h1
    norm_num at h1
  · rw [X.hC.encard_sectorsOf hn hr (fun i => X.hcol i r hr) c] at h2
    obtain ⟨i, j, hi, hj, hij⟩ := one_lt_encard_iff.mp (lt_of_lt_of_le (by norm_num) h2)
    have hi : X.col i = c := hi
    have hj : X.col j = c := hj
    have hadj : BranchGerms.next i = j ∨ BranchGerms.next j = i := by
      have hi' := i.isLt
      have hj' := j.isLt
      have hne : i.val ≠ j.val := fun h => hij (Fin.ext h)
      by_cases h1 : (BranchGerms.next i).val = j.val
      · exact Or.inl (Fin.ext h1)
      · right
        apply Fin.ext
        unfold BranchGerms.next at h1 ⊢
        split_ifs at h1 ⊢ with ha hb <;> simp at h1 ⊢ <;> omega
    rcases hadj with h | h
    · exact X.col_ne_next_of_isClean hc i (by rw [h, hi, hj])
    · exact X.col_ne_next_of_isClean hc j (by rw [h, hi, hj])

/-- **A point whose arcs lie on finitely many branches with distinct directions**: if every point of `Γ` near `x` other than `x`
lies, at its own distance, on one of finitely many branches from `x` whose directions at `x` are pairwise distinct, then no sector
at `x` is a horn, and `x` has at most as many germs as there are branches — one fewer if some branch has points off `Γ` arbitrarily
near `x`. (The chart's germs are among the branches: two germs with one direction would be two branches with one direction.) -/
theorem hasHornCount_zero_of_germs {M : ArcMap k} {x : ℂ} (hx : x ∈ M.dom) (𝒟 : Finset (ℝ × ℝ))
    (hdir : ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, e g.1 = e g'.1 → g = g') {ρ : ℝ} (hρ : 0 < ρ)
    (hΓ : ∀ z ∈ M.Γ, z ∈ ball x ρ → z ≠ x → ∃ g ∈ 𝒟, z = branchPt x g.1 g.2 ‖z - x‖) :
    M.HasHornCount x 0 ∧ (∀ m, M.HasDegree x m → m ≤ max 𝒟.card 1) ∧
      ∀ g₀ ∈ 𝒟, (∃ᶠ s in 𝓝[>] (0 : ℝ), branchPt x g₀.1 g₀.2 s ∉ M.Γ) → ∀ m, M.HasDegree x m → m ≤ max (𝒟.card - 1) 1 := by
  classical
  obtain ⟨X⟩ := exists_near hx
  have hmin : 0 < min ρ X.s₀ := lt_min hρ X.hs₀.1
  have hg : ∀ i : Fin X.n, ∀ s ∈ Ioo 0 (min ρ X.s₀), ∃ g ∈ 𝒟,
      branchPt x (X.G.β i) (X.G.κ i) s = branchPt x g.1 g.2 s := by
    intro i s hs
    have hsr : s ∈ Ioo 0 X.r₀ := ⟨hs.1, hs.2.trans_le ((min_le_right _ _).trans X.hs₀.2)⟩
    have hnorm := norm_branchPt_sub x (X.G.β i) (X.G.κ i) hs.1.le
    obtain ⟨g, hg, heq⟩ := hΓ _ (X.hC.branchPt_mem_Γ i hsr)
      (by rw [mem_ball, dist_eq_norm, hnorm]; exact hs.2.trans_le (min_le_left _ _))
      (fun h => by rw [h, sub_self, norm_zero] at hnorm; linarith [hs.1])
    rw [hnorm] at heq
    exact ⟨g, hg, heq⟩
  have hdirs : ∀ {β κ β' κ' s : ℝ}, 0 < s → branchPt x β κ s = branchPt x β' κ' s →
      e (germDir β κ s) = e (germDir β' κ' s) := by
    intro β κ β' κ' s hs heq
    rw [branchPt_eq, branchPt_eq] at heq
    have hs0 : (s : ℂ) ≠ 0 := by exact_mod_cast hs.ne'
    exact mul_left_cancel₀ hs0 (add_left_cancel heq)
  have hinj : ∀ i j : Fin X.n, ∀ s ∈ Ioo 0 (min ρ X.s₀),
      branchPt x (X.G.β i) (X.G.κ i) s = branchPt x (X.G.β j) (X.G.κ j) s → i = j := by
    intro i j s hs heq
    by_contra hij
    exact X.hdisj i j hij s ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩ (hdirs hs.1 heq)
  -- no two germs share a direction
  have hcusp : ∀ i : Fin X.n, X.G.β i ≠ X.G.nextβ i := by
    intro i hβ
    set j := BranchGerms.next i with hj
    have hij : i ≠ j := BranchGerms.ne_next_of_nextβ_eq hβ.symm
    have hej : e (X.G.β j) = e (X.G.β i) := by rw [← X.G.e_nextβ i, ← hβ]
    have hf : Tendsto (fun s => ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖)
        (𝓝[>] 0) (𝓝 0) := by
      have hcont : Continuous (fun s => ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖) := by
        unfold germDir e; fun_prop
      have := (hcont.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
      simpa [germDir_zero, hej] using this
    have hpair : ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, g ≠ g' → ∀ᶠ s in 𝓝[>] (0 : ℝ),
        ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖ <
          ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖ := by
      intro g hg g' hg' hne
      have hd : 0 < ‖e g.1 - e g'.1‖ := norm_pos_iff.mpr (sub_ne_zero.mpr fun h => hne (hdir g hg g' hg' h))
      have hh : Tendsto (fun s => ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖) (𝓝[>] 0)
          (𝓝 ‖e g.1 - e g'.1‖) := by
        have hcont : Continuous (fun s => ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖) := by
          unfold germDir e; fun_prop
        have := (hcont.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
        simpa [germDir_zero] using this
      filter_upwards [hf.eventually (gt_mem_nhds (half_pos hd)), hh.eventually (lt_mem_nhds (half_lt_self hd))]
        with s h1 h2
      exact h1.trans h2
    have hall : ∀ᶠ s in 𝓝[>] (0 : ℝ), ∀ g ∈ 𝒟, ∀ g' ∈ 𝒟, g ≠ g' →
        ‖e (germDir (X.G.β i) (X.G.κ i) s) - e (germDir (X.G.β j) (X.G.κ j) s)‖ <
          ‖e (germDir g.1 g.2 s) - e (germDir g'.1 g'.2 s)‖ := by
      refine (Filter.eventually_all_finset 𝒟).mpr fun g hg => (Filter.eventually_all_finset 𝒟).mpr fun g' hg' => ?_
      by_cases hne : g = g'
      · exact Filter.Eventually.of_forall fun _ h => absurd hne h
      · exact (hpair g hg g' hg' hne).mono fun s h _ => h
    obtain ⟨s, hs1, hs⟩ := (hall.and (Ioo_mem_nhdsGT hmin)).exists
    obtain ⟨g, hg𝒟, hgeq⟩ := hg i s hs
    obtain ⟨g', hg'𝒟, hg'eq⟩ := hg j s hs
    have hne : g ≠ g' := fun h => hij (hinj i j s hs (by rw [hgeq, hg'eq, h]))
    have := hs1 g hg𝒟 g' hg'𝒟 hne
    rw [hdirs hs.1 hgeq, hdirs hs.1 hg'eq] at this
    exact lt_irrefl _ this
  have hcard : ∀ s ∈ Ioo 0 (min ρ X.s₀), ∀ 𝒟' : Finset (ℝ × ℝ),
      (∀ g ∈ 𝒟, branchPt x g.1 g.2 s ∈ M.Γ → g ∈ 𝒟') → X.n ≤ 𝒟'.card := by
    intro s hs 𝒟' h𝒟'
    choose g hg𝒟 hgeq using fun i : Fin X.n => hg i s hs
    have hsr : s ∈ Ioo 0 X.r₀ := ⟨hs.1, hs.2.trans_le ((min_le_right _ _).trans X.hs₀.2)⟩
    have h1 : (Finset.univ : Finset (Fin X.n)).card ≤ 𝒟'.card :=
      Finset.card_le_card_of_injOn g (fun i _ => h𝒟' _ (hg𝒟 i) (hgeq i ▸ X.hC.branchPt_mem_Γ i hsr))
        (fun i _ j _ hij => hinj i j s hs (by rw [hgeq i, hgeq j, hij]))
    simpa using h1
  have hhalf : min ρ X.s₀ / 2 ∈ Ioo 0 (min ρ X.s₀) := ⟨by positivity, by linarith⟩
  refine ⟨?_, fun m hm => ?_, fun g₀ hg₀ hdead m hm => ?_⟩
  · rcases Nat.eq_zero_or_pos X.n with hn | hn
    · filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
      rw [Nat.cast_zero, encard_eq_zero, eq_empty_iff_forall_notMem]
      rintro S ⟨hS, α, κ₁, κ₂, -, rfl⟩
      have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
      have hv' : x ∈ hornSet x α κ₁ κ₂ r := hball ▸ mem_ball_self hr.1
      have := hv'.2.1
      simp [frameX] at this
    · have h0 : {i : Fin X.n | X.G.β i = X.G.nextβ i} = ∅ := eq_empty_iff_forall_notMem.mpr fun i hi => hcusp i hi
      have h := X.hasHornCount_chart hn
      rw [h0, ncard_empty] at h
      exact h
  · have h1 := hm.eq X.hC.hasDegree
    have h2 := hcard _ hhalf 𝒟 (fun g hg _ => hg)
    omega
  · have h1 := hm.eq X.hC.hasDegree
    obtain ⟨s, hsdead, hs⟩ := (hdead.and_eventually (Ioo_mem_nhdsGT hmin)).exists
    have h2 := hcard s hs (𝒟.erase g₀) (fun g hg hgΓ => Finset.mem_erase.mpr ⟨fun h => hsdead (h ▸ hgΓ), hg⟩)
    rw [Finset.card_erase_of_mem hg₀] at h2
    omega
--END

end ArcMap

end HadwigerNelson.Plane
