import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A tile at a chart's point holds a sector of every small radius**: if `v ∈ cl A` and `v`'s chart has germs, then for every `r ∈ (0, r₀]`
some sector of radius `r` lies in `A` (a sector meeting `A` is preconnected inside the interior points, so inside `A`'s component). -/
theorem IsSectorChart.exists_sector_subset_tile {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {A : Set ℂ} (hA : F.IsTile A) (hvA : v ∈ closure A) : ∃ i, G.sector v r i ⊆ A := by
  obtain ⟨w, hwA, hwb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvA, mem_ball_self hr.1⟩
  have hw : w ∈ ball v r ∩ F.interiorPts := ⟨hwb, hA.subset_interiorPts hwA⟩
  rw [hC.cover r hr hn] at hw
  obtain ⟨i, hi⟩ := mem_iUnion.mp hw
  refine ⟨i, ?_⟩
  obtain ⟨x, hx, rfl⟩ := hA
  rw [connectedComponentIn_eq hwA]
  exact (hC.isPreconnected r hr i).subset_connectedComponentIn hi (hC.sector_subset_interiorPts hn hr i)

/-- **Two tiles of one colour at a point give it a repeated colour**: each holds a sector of every small radius, and the two sectors differ. -/
theorem hasRepeatedColour_of_two_tiles {v : ℂ} (hv : v ∈ F.dom) {A B : Set ℂ} {c : Fin k} (hA : F.TileOf c A)
    (hB : F.TileOf c B) (hAB : A ≠ B) (hvA : v ∈ closure A) (hvB : v ∈ closure B) : F.HasRepeatedColour v := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  have hn : 0 < n := by
    by_contra h0
    have hball := hC.empty (by omega)
    obtain ⟨a, haA, hab⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvA, mem_ball_self hC.pos⟩
    obtain ⟨b, hbB, hbb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvB, mem_ball_self hC.pos⟩
    have h1 : ball v r₀ ⊆ A := by
      obtain ⟨x, hx, hAx⟩ := hA.1
      rw [hAx, connectedComponentIn_eq (hAx ▸ haA)]
      exact (convex_ball v r₀).isPreconnected.subset_connectedComponentIn hab hball
    exact hAB (hA.1.eq_of_mem hB.1 (h1 hbb) hbB)
  refine ⟨c, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
  obtain ⟨i, hi⟩ := hC.exists_sector_subset_tile hn hr hA.1 hvA
  obtain ⟨j, hj⟩ := hC.exists_sector_subset_tile hn hr hB.1 hvB
  have hne : G.sector v r i ≠ G.sector v r j := by
    intro h
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr i
    exact hAB (hA.1.eq_of_mem hB.1 (hi hw) (hj (h ▸ hw)))
  have hSi : G.sector v r i ∈ F.sectorsOf v r c := ⟨(hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, hi.trans hA.2⟩
  have hSj : G.sector v r j ∈ F.sectorsOf v r c := ⟨(hC.isSector_iff hn hr).mpr ⟨j, rfl⟩, hj.trans hB.2⟩
  calc (2 : ℕ∞) = ({G.sector v r i, G.sector v r j} : Set (Set ℂ)).encard := (Set.encard_pair hne).symm
    _ ≤ (F.sectorsOf v r c).encard := Set.encard_le_encard (insert_subset_iff.mpr ⟨hSi, singleton_subset_iff.mpr hSj⟩)

theorem isCubicTrichromatic_of_three_tiles' {v : ℂ} (hv : v ∈ F.dom) {A B C : Set ℂ} (hA : F.IsTile A) (hB : F.IsTile B)
    (hC : F.IsTile C) (hAB : A ≠ B) (hAC : A ≠ C) (hBC : B ≠ C) (hvA : v ∈ closure A) (hvB : v ∈ closure B) (hvC : v ∈ closure C)
    (hgood : v ∉ F.fourSet ∪ F.repSet) : F.IsCubicTrichromatic v := by
  have hnr : ¬ F.HasRepeatedColour v := fun h => hgood (Or.inr ⟨hv, h⟩)
  -- each tile has one colour, carried at `v`
  have hcol : ∀ {P}, F.IsTile P → v ∈ closure P → ∃ c, F.TileOf c P ∧ c ∈ F.coloursAt v := by
    intro P hP hvP
    obtain ⟨p, hp⟩ := hP.nonempty
    refine ⟨F.col p, hP.tileOf hp, ?_⟩
    show v ∈ closure (F.region (F.col p))
    have hsub : P ⊆ F.region (F.col p) := fun z hz => ⟨hP.subset_interiorPts hz, (hP.tileOf hp).2 hz⟩
    exact closure_mono hsub hvP
  obtain ⟨a, ha, hav⟩ := hcol hA hvA
  obtain ⟨b, hb, hbv⟩ := hcol hB hvB
  obtain ⟨c, hc, hcv⟩ := hcol hC hvC
  -- distinct tiles at `v` have distinct colours (else a repeated colour)
  have hdist : ∀ {P Q : Set ℂ} {p q : Fin k}, F.TileOf p P → F.TileOf q Q → P ≠ Q → v ∈ closure P → v ∈ closure Q → p ≠ q := by
    rintro P Q p q hP hQ hPQ hvP hvQ rfl
    exact hnr (hasRepeatedColour_of_two_tiles hv hP hQ hPQ hvP hvQ)
  have hab := hdist ha hb hAB hvA hvB
  have hac := hdist ha hc hAC hvA hvC
  have hbc := hdist hb hc hBC hvB hvC
  have h3 : (F.coloursAt v).ncard = 3 := by
    have hge : 3 ≤ (F.coloursAt v).ncard := by
      have : ({a, b, c} : Set (Fin k)).ncard = 3 := Set.ncard_eq_three.mpr ⟨a, b, c, hab, hac, hbc, rfl⟩
      rw [← this]
      exact Set.ncard_le_ncard (insert_subset_iff.mpr ⟨hav, insert_subset_iff.mpr ⟨hbv, singleton_subset_iff.mpr hcv⟩⟩)
        (Set.toFinite _)
    have hle : (F.coloursAt v).ncard < 4 := by
      by_contra h
      push Not at h
      exact hgood (Or.inl ⟨hv, h⟩)
    omega
  exact isCubicTrichromatic_of_three_of_noRep hv h3 hnr

end ArcMap

end HadwigerNelson.Plane
