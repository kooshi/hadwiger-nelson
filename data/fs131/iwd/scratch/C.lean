import Proofs.HadwigerNelson.Plane.Woodall.Merge

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ}

/-- **E3-NICE's step** (stage 11's simpler measure): when the local data fail `niceAt_of_dirColourAt`'s run or poke condition, there are
two directions off `D`, less than `π` apart and of one colour, with a direction of `D` strictly between them at which a second colour
approaches `v` too. -/
theorem DirColourAt.exists_merge_dirs {F : ArcMap k} {v : ℂ} {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ)
    (hv : v ∈ F.dom)
    (h : ¬ ((∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁)) ∧
      ∀ δ ∈ D, ∀ j c : Fin k, δ ∈ coneAt (F.region j) v →
        (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c) → j = c)) :
    ∃ d₁ d₂ : ℝ, d₁ < d₂ ∧ d₂ - d₁ < π ∧ OffDirs D d₁ ∧ OffDirs D d₂ ∧ σ d₂ = σ d₁ ∧
      ∃ δ ∈ D, δ ∈ angleIoo d₁ d₂ ∧ ∃ j, j ≠ σ d₁ ∧ δ ∈ coneAt (F.region j) v ∧ δ ∈ coneAt (F.region (σ d₁)) v := by
  classical
  have hπ := Real.pi_pos
  have hper : ∀ (S : Set ℂ) (β : ℝ) (m : ℤ), β + 2 * π * m ∈ coneAt S v ↔ β ∈ coneAt S v := fun S =>
    periodic_int (fun _ => mem_coneAt_add_two_pi)
  -- a gap: an interval of length `< π` between two directions of one colour, holding a direction of another
  have key : ∀ d₁ d₂ ψ₀ : ℝ, d₁ < ψ₀ → ψ₀ < d₂ → d₂ - d₁ < π → OffDirs D d₁ → OffDirs D d₂ → OffDirs D ψ₀ →
      σ d₂ = σ d₁ → σ ψ₀ ≠ σ d₁ → ∃ d₁ d₂ : ℝ, d₁ < d₂ ∧ d₂ - d₁ < π ∧ OffDirs D d₁ ∧ OffDirs D d₂ ∧ σ d₂ = σ d₁ ∧
        ∃ δ ∈ D, δ ∈ angleIoo d₁ d₂ ∧ ∃ j, j ≠ σ d₁ ∧ δ ∈ coneAt (F.region j) v ∧ δ ∈ coneAt (F.region (σ d₁)) v := by
    intro d₁ d₂ ψ₀ h1 h2 h3 hd₁ hd₂ hψ₀ hσ hψσ
    have hT₂ : IsClosed (⋃ j ∈ (Finset.univ.filter fun j : Fin k => j ≠ σ d₁), coneAt (F.region j) v) :=
      isClosed_biUnion_finset fun j _ => isClosed_coneAt _ _
    obtain ⟨δ', hδ'I, hδ'1, hδ'2⟩ := isPreconnected_closed_iff.mp isPreconnected_Icc _ _ (isClosed_coneAt (F.region (σ d₁)) v)
      hT₂ (fun β _ => by
        obtain ⟨j, hj⟩ := F.exists_mem_coneAt_region hv β
        by_cases hjc : j = σ d₁
        · exact Or.inl (hjc ▸ hj)
        · exact Or.inr (mem_iUnion₂.mpr ⟨j, by simp [hjc], hj⟩))
      ⟨d₁, left_mem_Icc.mpr h1.le, hD.mem_coneAt hd₁⟩
      ⟨ψ₀, right_mem_Icc.mpr h1.le, mem_iUnion₂.mpr ⟨σ ψ₀, by simp [hψσ], hD.mem_coneAt hψ₀⟩⟩
    obtain ⟨j, hj, hδ'j⟩ := mem_iUnion₂.mp hδ'2
    have hjne : j ≠ σ d₁ := by simpa using hj
    have hnot : ¬ OffDirs D δ' := fun hoff =>
      hjne ((hD.eq_of_mem_coneAt hoff hδ'j).trans (hD.eq_of_mem_coneAt hoff hδ'1).symm)
    simp only [OffDirs, not_forall, not_not] at hnot
    obtain ⟨δ, hδ, m, hm⟩ := hnot
    have hδ'd₁ : d₁ < δ' := lt_of_le_of_ne hδ'I.1 fun he => hd₁ δ hδ m (he.trans hm)
    refine ⟨d₁, d₂, h1.trans h2, h3, hd₁, hd₂, hσ, δ, hδ, mem_iUnion.mpr ⟨-m, ?_, ?_⟩, j, hjne, ?_, ?_⟩
    · push_cast; linarith
    · push_cast; linarith [hδ'I.2]
    · rw [← hper _ δ m, ← hm]; exact hδ'j
    · rw [← hper _ δ m, ← hm]; exact hδ'1
  rw [not_and_or] at h
  rcases h with h | h
  · push Not at h
    obtain ⟨φ₁, φ₂, hφ₁, hφ₂, h12, h21, hσ12, ⟨ψ, hψ, hψD, hψσ⟩, ⟨ψ', hψ', hψ'D, hψ'σ⟩⟩ := h
    by_cases hle : φ₂ - φ₁ ≤ π
    · obtain ⟨r, hr, hnear⟩ := hD.eq_of_near hφ₂
      obtain ⟨d₂, hd₂, hd₂D⟩ := exists_offDirs_Ioo D (show max ψ (φ₂ - r) < φ₂ from max_lt hψ.2 (by linarith))
      have hσd₂ : σ d₂ = σ φ₁ := (hnear d₂ (abs_lt.mpr ⟨by linarith [le_max_right ψ (φ₂ - r), hd₂.1], by linarith [hd₂.2]⟩)
        hd₂D).trans hσ12.symm
      exact key φ₁ d₂ ψ hψ.1 (lt_of_le_of_lt (le_max_left _ _) hd₂.1) (by linarith [hd₂.2]) hφ₁ hd₂D hψD hσd₂ hψσ
    · push Not at hle
      have h1' : OffDirs D (φ₁ + 2 * π) := by
        have := (offDirs_add_int (D := D) (φ := φ₁) 1).mpr hφ₁; simpa using this
      have hσ1 : σ (φ₁ + 2 * π) = σ φ₂ := by
        have := hD.eq_add_int hφ₁ 1; simp only [Int.cast_one, mul_one] at this; rw [this, hσ12]
      exact key φ₂ (φ₁ + 2 * π) ψ' hψ'.1 hψ'.2 (by linarith) hφ₂ h1' hψ'D hσ1 (by rw [← hσ12]; exact hψ'σ)
  · push Not at h
    obtain ⟨δ, hδ, j, c', hj, ⟨t, ht, hσt⟩, hjc⟩ := h
    have hu : 0 < min t (π / 2) := lt_min ht (by positivity)
    have hu1 := min_le_left t (π / 2)
    have hu2 := min_le_right t (π / 2)
    obtain ⟨d₁, hd₁, hd₁D⟩ := exists_offDirs_Ioo D (show δ - min t (π / 2) < δ by linarith)
    obtain ⟨d₂, hd₂, hd₂D⟩ := exists_offDirs_Ioo D (show δ < δ + min t (π / 2) by linarith)
    have hσ₁ : σ d₁ = c' := hσt d₁ ⟨by linarith [hd₁.1], by linarith [hd₁.2]⟩ hd₁D
    have hσ₂ : σ d₂ = c' := hσt d₂ ⟨by linarith [hd₂.1], by linarith [hd₂.2]⟩ hd₂D
    have hR : rightCol D σ δ = c' := hD.rightCol_eq_of ht fun φ hφ hφD => hσt φ ⟨by linarith [hφ.1], hφ.2⟩ hφD
    refine ⟨d₁, d₂, hd₁.2.trans hd₂.1, by linarith [hd₁.1, hd₂.2], hd₁D, hd₂D, hσ₂.trans hσ₁.symm, δ, hδ,
      mem_iUnion.mpr ⟨0, by push_cast; linarith [hd₁.2], by push_cast; linarith [hd₂.1]⟩, j, by rw [hσ₁]; exact hjc, hj, ?_⟩
    rw [hσ₁, ← hR]; exact hD.rightCol_mem_coneAt δ

theorem exists_merge_at' {F : ArcMap k} (hF : F.Valid) (hP : F.IsPlaneMap) (v : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ ρ ∈ Ioo 0 ε, ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ (F.Condition5 → F'.Condition5) ∧
      (∀ j, F'.region j \ closedBall v ρ = F.region j \ closedBall v ρ) ∧ F'.WoodallMerged (closedBall v ρ) := by
  classical
  have hπ := Real.pi_pos
  have hvF : v ∈ F.dom := by rw [hP]; trivial
  obtain ⟨ρ₀, hG₀⟩ := F.exists_goodAt hvF
  have hρ₀ := hG₀.pos
  set ρ₁ := min (ε / 2) (ρ₀ / 2) with hρ₁
  have hρ₁0 : 0 < ρ₁ := lt_min (by linarith) (by linarith)
  have hρ₁ε : ρ₁ < ε := lt_of_le_of_lt (min_le_left _ _) (by linarith)
  have hρ₁ρ₀ : ρ₁ < ρ₀ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
  -- the measure: the colours approaching `v` along each direction of `D`, beyond the first
  obtain ⟨μ, hμ⟩ : ∃ μ : ArcMap k → Finset ℝ → ℕ, ∀ G D, μ G D =
      ∑ δ ∈ D, ((Finset.univ.filter fun j => δ ∈ coneAt (G.region j) v).card - 1) := ⟨_, fun _ _ => rfl⟩
  suffices key : ∀ N : ℕ, ∀ (G : ArcMap k) (D : Finset ℝ) (σ : ℝ → Fin k), μ G D = N → G.Valid → G.IsPlaneMap →
      (F.Condition5 → G.Condition5) → (∀ j, G.region j \ closedBall v ρ₁ = F.region j \ closedBall v ρ₁) →
      (∀ w ∈ closedBall v ρ₁, w ≠ v → 3 ≤ (G.coloursAt w).ncard → G.NiceAt w) → G.DirColourAt v D σ →
      ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ (F.Condition5 → F'.Condition5) ∧
        (∀ j, F'.region j \ closedBall v ρ₁ = F.region j \ closedBall v ρ₁) ∧ F'.WoodallMerged (closedBall v ρ₁) by
    obtain ⟨D, σ, hD⟩ := F.exists_dirColourAt hvF
    obtain ⟨F', h1, h2, h3, h4, h5⟩ := key _ F D σ rfl hF hP id (fun j => rfl)
      (fun w hw hwv h3 => absurd h3 (by
        have hwb : w ∈ ball v ρ₀ := by
          rw [mem_ball]; rw [mem_closedBall] at hw; linarith
        have := hG₀.ncard_coloursAt_le_two hwb hwv; omega)) hD
    exact ⟨ρ₁, ⟨hρ₁0, hρ₁ε⟩, F', h1, h2, h3, h4, h5⟩
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
  intro G D σ hμN hGv hGP hG5 hGreg hGnice hD
  have hvG : v ∈ G.dom := by rw [hGP]; trivial
  by_cases hnice : (∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁)) ∧
      ∀ δ ∈ D, ∀ j c : Fin k, δ ∈ coneAt (G.region j) v →
        (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c) → j = c
  · -- the local data are nice: the point itself is `NiceAt`
    refine ⟨G, hGv, hGP, hG5, hGreg, fun w hw h3 => ?_⟩
    by_cases hwv : w = v
    · subst hwv; exact niceAt_of_dirColourAt hvG hD hnice.1 hnice.2 h3
    · exact hGnice w hw hwv h3
  -- one merge at a wedge
  obtain ⟨d₁, d₂, hd, hπd, hd₁, hd₂, hσ, δ₀, hδ₀, hδ₀in, j₀, hj₀, hcj₀, hcc⟩ := hD.exists_merge_dirs hvG hnice
  obtain ⟨ra, hra, hsuba⟩ := hD d₁ hd₁
  obtain ⟨rb, hrb, hsubb⟩ := hD d₂ hd₂
  rw [hσ] at hsubb
  obtain ⟨ρg, hGg⟩ := G.exists_goodAt hvG
  have hρg := hGg.pos
  have hcos : 0 < Real.cos ((d₂ - d₁) / 2) := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  have hcos1 : Real.cos ((d₂ - d₁) / 2) ≤ 1 := Real.cos_le_one _
  set r₁ := min (min ra rb) (Real.cos ((d₂ - d₁) / 2) / 4) with hr₁
  have hr₁0 : 0 < r₁ := lt_min (lt_min hra hrb) (by positivity)
  have hr₁a : r₁ ≤ ra := (min_le_left _ _).trans (min_le_left _ _)
  have hr₁b : r₁ ≤ rb := (min_le_left _ _).trans (min_le_right _ _)
  have hr₁c4 : r₁ ≤ Real.cos ((d₂ - d₁) / 2) / 4 := min_le_right _ _
  have hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2 := by linarith
  set ρ' := min (min (r₁ * Real.cos ((d₂ - d₁) / 2) / 2) (ρg / 2)) (ρ₁ / 2) with hρ'
  have hρ'0 : 0 < ρ' := lt_min (lt_min (by positivity) (by positivity)) (by positivity)
  have hρ'r : ρ' ≤ r₁ * Real.cos ((d₂ - d₁) / 2) / 2 := (min_le_left _ _).trans (min_le_left _ _)
  have hρ'g : ρ' < ρg := lt_of_le_of_lt ((min_le_left _ _).trans (min_le_right _ _)) (by linarith)
  have hρ'1 : ρ' < ρ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
  have hρ'r₁ : ρ' < r₁ := lt_of_le_of_lt hρ'r (by nlinarith)
  have hρ'one : ρ' < 1 := by linarith
  have hd2 : d₂ ≤ d₁ + 2 * π := by linarith
  have hd2' : d₂ < d₁ + 2 * π := by linarith
  set G' := G.wedgeMerge v hρ'0 hd hd2 (σ d₁) with hG'
  have hedge : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ G.region (σ d₁) ∧ v + (s : ℂ) * e d₂ ∈ G.region (σ d₁) := fun s hs =>
    ⟨hsuba ⟨(s, d₁), ⟨⟨hs.1, by linarith [hs.2]⟩, ⟨by linarith, by linarith⟩⟩, rfl⟩,
      hsubb ⟨(s, d₂), ⟨⟨hs.1, by linarith [hs.2]⟩, ⟨by linarith, by linarith⟩⟩, rfl⟩⟩
  have hG'v : G'.Valid := wedgeMerge_valid hGv hρ'0 hd hπd hr₁0 hr₁c hρ'r fun s hs =>
    ⟨subset_closure (hedge s hs).1, subset_closure (hedge s hs).2⟩
  have hG'P : G'.IsPlaneMap := recolour_isPlaneMap hGP
  have hG'5 : F.Condition5 → G'.Condition5 := fun h => wedgeMerge_condition5 (hG5 h) hρ'0 hρ'one hd hd2
  have hdiff : ∀ j, G'.region j \ closedBall v ρ' = G.region j \ closedBall v ρ' := wedgeMerge_region_diff hρ'0 hd hd2
  have hBB : closedBall v ρ' ⊆ closedBall v ρ₁ := closedBall_subset_closedBall hρ'1.le
  have hG'reg : ∀ j, G'.region j \ closedBall v ρ₁ = F.region j \ closedBall v ρ₁ := fun j => by
    rw [← hGreg j]
    ext z
    constructor
    · rintro ⟨hz, hzB⟩
      have h' : z ∈ G'.region j \ closedBall v ρ' := ⟨hz, fun h => hzB (hBB h)⟩
      rw [hdiff] at h'
      exact ⟨h'.1, hzB⟩
    · rintro ⟨hz, hzB⟩
      have h' : z ∈ G.region j \ closedBall v ρ' := ⟨hz, fun h => hzB (hBB h)⟩
      rw [← hdiff] at h'
      exact ⟨h'.1, hzB⟩
  have hG'nice : ∀ w ∈ closedBall v ρ₁, w ≠ v → 3 ≤ (G'.coloursAt w).ncard → G'.NiceAt w := by
    intro w hw hwv h3
    by_cases hwB : w ∈ closedBall v ρ'
    · exact wedgeMerge_niceAt hGg hρ'0 hρ'g hd hπd hρ'r₁ hedge hwB hwv h3
    · have hU : (closedBall v ρ')ᶜ ∈ 𝓝 w := isClosed_closedBall.isOpen_compl.mem_nhds hwB
      have hreg : ∀ j, G'.region j ∩ (closedBall v ρ')ᶜ = G.region j ∩ (closedBall v ρ')ᶜ := fun j => by
        simpa [Set.sdiff_eq] using hdiff j
      have hcol := coloursAt_congr hU hreg
      exact (niceAt_congr (F := G') (F' := G) hU Iff.rfl hreg).mpr (hGnice w hw hwv (by rw [← hcol]; exact h3))
  have hD' := dirColourAt_wedgeMerge (c := σ d₁) hD hρ'0 hd hd2'
  -- the measure decreases
  have hnotD : ∀ d, OffDirs D d → d ∉ D := fun d hd hdD => hd d hdD 0 (by push_cast; ring)
  have hle1 : ∀ δ, (∀ j, δ ∈ coneAt (G'.region j) v → j = σ d₁) →
      (Finset.univ.filter fun j => δ ∈ coneAt (G'.region j) v).card - 1 = 0 := fun δ h => by
    have : (Finset.univ.filter fun j => δ ∈ coneAt (G'.region j) v).card ≤ 1 :=
      Finset.card_le_one.mpr fun a ha b hb => by
        rw [h a (Finset.mem_filter.mp ha).2, h b (Finset.mem_filter.mp hb).2]
    omega
  have hlt : μ G' (insert d₁ (insert d₂ D)) < μ G D := by
    rw [hμ, hμ, Finset.sum_insert (by simp only [Finset.mem_insert, not_or]; exact ⟨hd.ne, hnotD d₁ hd₁⟩),
      Finset.sum_insert (hnotD d₂ hd₂),
      hle1 d₁ fun j h => eq_of_mem_coneAt_wedgeMerge_of_subset hρ'0 hd hd2 hra hsuba h,
      hle1 d₂ fun j h => eq_of_mem_coneAt_wedgeMerge_of_subset hρ'0 hd hd2 hrb hsubb h, zero_add, zero_add]
    refine Finset.sum_lt_sum (fun δ hδ => ?_) ⟨δ₀, hδ₀, ?_⟩
    · by_cases hin : δ ∈ angleIoo d₁ d₂
      · rw [hle1 δ fun j h => eq_of_mem_coneAt_wedgeMerge hρ'0 hd hd2 hin h]; exact Nat.zero_le _
      · have hnot : δ ∉ angleIcc d₁ d₂ := fun h' => by
          obtain ⟨m, hm⟩ := mem_iUnion.mp h'
          rcases eq_or_lt_of_le hm.1 with h1 | h1
          · exact hd₁ δ hδ (-m) (by push_cast; linarith)
          rcases eq_or_lt_of_le hm.2 with h2 | h2
          · exact hd₂ δ hδ (-m) (by push_cast; linarith)
          exact hin (mem_iUnion.mpr ⟨m, h1, h2⟩)
        have heq : (Finset.univ.filter fun j => δ ∈ coneAt (G'.region j) v) =
            Finset.univ.filter fun j => δ ∈ coneAt (G.region j) v := by
          ext j
          simp only [Finset.mem_filter, Finset.mem_univ, true_and]
          exact coneAt_wedgeMerge_of_notMem hρ'0 hd hd2 hnot j
        rw [heq]
    · rw [hle1 δ₀ fun j h => eq_of_mem_coneAt_wedgeMerge hρ'0 hd hd2 hδ₀in h]
      have : 1 < (Finset.univ.filter fun j => δ₀ ∈ coneAt (G.region j) v).card :=
        Finset.one_lt_card.mpr ⟨j₀, by simp [hcj₀], σ d₁, by simp [hcc], hj₀⟩
      omega
  exact ih _ (by rw [← hμN]; exact hlt) G' _ _ rfl hG'v hG'P hG'5 hG'reg hG'nice hD'

end ArcMap

end HadwigerNelson.Plane
