import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- A tile's closure lies in `B̄(0, ‖x‖ + 1)` for any point `x` of the tile (`IsTile.closure_subset_closedBall`). -/
theorem IsTile.closure_subset_closedBall_zero (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hx : x ∈ T) :
    closure T ⊆ closedBall 0 (‖x‖ + 1) := by
  intro z hz
  have := hT.closure_subset_closedBall hF (subset_closure hx) hz
  rw [mem_closedBall, dist_zero_right]; rw [mem_closedBall] at this
  linarith [norm_le_norm_add_norm_sub' z x, dist_eq_norm z x]

/-- A point outside `B̄(0, R)`. -/
theorem exists_not_mem_closedBall_zero (R : ℝ) : ∃ z : ℂ, z ∉ closedBall (0 : ℂ) R :=
  ⟨((|R| + 1 : ℝ) : ℂ), by
    rw [mem_closedBall, dist_zero_right, Complex.norm_real, Real.norm_of_nonneg (by positivity), not_le]
    linarith [le_abs_self R]⟩

/-- **The outer domain of a set with bounded closure is one complementary component**: the one through any point outside a disc holding
the closure. -/
theorem outerDom_eq_connectedComponentIn {T : Set ℂ} {R : ℝ} (hTR : closure T ⊆ closedBall 0 R) {z₀ : ℂ}
    (hz₀ : z₀ ∉ closedBall (0 : ℂ) R) : outerDom T = connectedComponentIn (closure T)ᶜ z₀ := by
  have hsub : (closedBall (0 : ℂ) R)ᶜ ⊆ connectedComponentIn (closure T)ᶜ z₀ :=
    (isPreconnected_compl_closedBall 0 R).subset_connectedComponentIn hz₀ (compl_subset_compl.mpr hTR)
  have hunb : ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z₀) := by
    intro hb
    obtain ⟨R', hR'⟩ := hb.subset_closedBall 0
    obtain ⟨w, hw⟩ := exists_not_mem_closedBall_zero (max R R')
    exact hw (closedBall_subset_closedBall (le_max_right _ _) (hR' (hsub fun h =>
      hw (closedBall_subset_closedBall (le_max_left _ _) h))))
  have hbd : Bornology.IsBounded (closure T) := isBounded_closedBall.subset hTR
  ext z
  constructor
  · rintro ⟨hzT, hz⟩
    rw [← connectedComponentIn_eq_of_not_isBounded hbd hz hunb]
    exact mem_connectedComponentIn hzT
  · intro hz
    exact ⟨connectedComponentIn_subset _ _ hz, by rw [← connectedComponentIn_eq hz]; exact hunb⟩

theorem exists_rim_vertex' (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) (hdom : (outerDom T)ᶜ ⊆ F.dom)
    (hno : ∀ T', F.IsTile T' → ¬ EnclosesTile T' T) :
    ∃ X Y v, F.IsTile X ∧ F.IsTile Y ∧ X ≠ Y ∧ X ⊆ outerDom T ∧ Y ⊆ outerDom T ∧ v ∈ frontier (outerDom T) ∧
      v ∈ closure T ∧ v ∈ closure X ∧ v ∈ closure Y := by
  obtain ⟨x, hx⟩ := hT.nonempty
  have hTR := hT.closure_subset_closedBall_zero hF hx
  obtain ⟨z₀, hz₀⟩ := exists_not_mem_closedBall_zero (‖x‖ + 1)
  have hW := outerDom_eq_connectedComponentIn hTR hz₀
  set W := outerDom T with hWdef
  have hcl : IsClosed (closure T) := isClosed_closure
  have hWo : IsOpen W := by rw [hW]; exact hcl.isOpen_compl.connectedComponentIn
  set Φ := frontier W with hΦ
  -- the rim: preconnected, inside `cl T`, compact, nonempty
  have hΦpre : IsPreconnected Φ := by
    rw [hΦ, hW]; exact isPreconnected_frontier_connectedComponentIn hcl hT.isPreconnected.closure z₀
  have hΦT : Φ ⊆ closure T := by
    rw [hΦ, hW]; intro v hv; simpa using frontier_connectedComponentIn_subset hcl.isOpen_compl z₀ hv
  have hΦc : IsCompact Φ := (isCompact_closedBall 0 (‖x‖ + 1)).of_isClosed_subset isClosed_frontier (hΦT.trans hTR)
  have hΦd : Φ ⊆ F.dom := fun v hv => hdom (fun hvW => (hWo.inter_frontier_eq.subset ⟨hvW, hv⟩ : v ∈ (∅ : Set ℂ)))
  have hz₀W : z₀ ∈ W := by rw [hW]; exact mem_connectedComponentIn (fun h => hz₀ (hTR h))
  have hΦne : Φ.Nonempty := by
    rw [hΦ, nonempty_frontier_iff]
    refine ⟨⟨z₀, hz₀W⟩, fun h => ?_⟩
    exact (h ▸ mem_univ x : x ∈ W).1 (subset_closure hx)
  -- a tile meeting `W` lies in `W`
  have hinW : ∀ X, F.IsTile X → (X ∩ W).Nonempty → X ⊆ W := by
    rintro X hX ⟨w, hwX, hwW⟩
    have hXT : X ≠ T := by rintro rfl; exact hwW.1 (subset_closure hwX)
    rw [hW] at hwW ⊢
    rw [connectedComponentIn_eq hwW]
    exact hX.isPreconnected.subset_connectedComponentIn hwX (IsTile.subset_compl_closure hT hX hXT)
  -- the tiles of `W` touching the rim: finitely many, covering it
  set s := {X | F.IsTile X ∧ X ⊆ W ∧ (closure X ∩ Φ).Nonempty} with hs
  have hsfin : s.Finite := (finite_tiles_closure_inter hΦc hΦd).subset fun X hX => ⟨hX.1, hX.2.2⟩
  have hcov : Φ ⊆ ⋃ X ∈ s, closure X := by
    intro v hv
    obtain ⟨X, hX, hXW, hvX⟩ := exists_tile_mem_closure_of_mem_closure hWo (hΦd hv) hv.1
    exact mem_iUnion₂.mpr ⟨X, ⟨hX, hinW X hX hXW, v, hvX, hv⟩, hvX⟩
  -- two of them: one alone would enclose `T` (the last exit)
  obtain ⟨v₀, hv₀⟩ := hΦne
  obtain ⟨X, hXs, hv₀X⟩ := mem_iUnion₂.mp (hcov hv₀)
  obtain ⟨Y, hYs, hXY⟩ : ∃ Y ∈ s, X ≠ Y := by
    by_contra hall
    push Not at hall
    -- the rim lies in `cl X`
    have hΦX : Φ ⊆ closure X := by
      intro v hv
      obtain ⟨Y, hYs, hvY⟩ := mem_iUnion₂.mp (hcov hv)
      rwa [← hall Y hYs] at hvY
    have hXT : X ≠ T := by
      rintro rfl
      obtain ⟨w, hw⟩ := hXs.1.nonempty
      exact (hXs.2.1 hw).1 (subset_closure hw)
    have hxX : x ∉ closure X := by
      intro h
      obtain ⟨w, hw, hwx⟩ := (closure_inter_open_nonempty_iff hT.isOpen).mp ⟨x, h, hx⟩
      exact Set.disjoint_left.mp (Set.disjoint_left.mpr fun a ha haT =>
        hXT (hXs.1.eq_of_mem hT ha haT)) hw hwx
    apply hno X hXs.1
    refine ⟨x, ⟨hx, hxX⟩, ?_⟩
    have hbd : Bornology.IsBounded (closure T) := isBounded_closedBall.subset hTR
    have hunb : ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z₀) := by
      rw [← hW]; intro hb
      exact hz₀W.2 (by rw [← connectedComponentIn_eq (by rw [← hW]; exact hz₀W)]; rw [hW] at hb; exact hb)
    exact isBounded_connectedComponentIn_of_frontier_subset hcl hbd isClosed_closure hunb
      (by rw [← hW]; exact hΦX) (by rw [← hW]; exact fun h => h.1 (subset_closure hx)) hxX
  obtain ⟨X', hX's, Y', hY's, hne, v, ⟨hvΦ, hvX'⟩, hvY'⟩ :=
    exists_inter_of_finite_closed_cover hΦpre hsfin (fun X => closure X) (fun _ _ => isClosed_closure) hcov hXs hYs hXY
      ⟨v₀, hv₀, hv₀X⟩ (by obtain ⟨w, hw1, hw2⟩ := hYs.2.2; exact ⟨w, hw2, hw1⟩)
  exact ⟨X', Y', v, hX's.1, hY's.1, hne, hX's.2.1, hY's.2.1, hvΦ, hΦT hvΦ, hvX', hvY'⟩

end ArcMap

end HadwigerNelson.Plane
