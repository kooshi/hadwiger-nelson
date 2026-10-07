import Proofs.HadwigerNelson.Plane.Saturated.LocalGraph
namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Filter Topology Metric

/-! ## The inhabitant of `local_graph`: `sq9` at the edge point -/

/-- **No cusp of the two classes in the edge ball of `sq9`** (owed by `local_graph`'s inhabitant note): on its own
closed side a class has positive upper density (`sq9Sq_subset_essClosure`), and strictly on the other side it is
absent near the point. -/
theorem sq9_not_isCuspAt_near_edge {x : ℂ} (hx : x ∈ ball sqEdgePt (1 / 8)) :
    ¬ IsCuspAt (sq9.cls sqColA) x ∧ ¬ IsCuspAt (sq9.cls sqColB) x := by
  obtain ⟨hre, him⟩ := sqEdge_coords hx
  obtain ⟨h1, h2⟩ := abs_lt.mp hre
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  have hfar : ∀ (col : Fin 9) (s : ℝ),
      (∀ z ∈ ball sqEdgePt (1 / 8), 0 < s * (z.re - 1 / 2) → sq9Col z ≠ col) → (s = 1 ∨ s = -1) →
      0 < s * (x.re - 1 / 2) → x ∉ essSupport (sq9.cls col) := by
    intro col s hcol hs hpos hsupp
    have hxd : dist x sqEdgePt < 1 / 8 := hx
    have hr : 0 < min (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt) := lt_min hpos (by linarith)
    have hempty : sq9.cls col ∩ ball x (min (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt)) = ∅ := by
      ext z
      simp only [mem_inter_iff, mem_empty_iff_false, iff_false, not_and]
      intro hzc hz
      rw [mem_ball] at hz
      have hzb : z ∈ ball sqEdgePt (1 / 8) := by
        rw [mem_ball]
        linarith [dist_triangle z x sqEdgePt, min_le_right (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt)]
      refine hcol z hzb ?_ hzc
      have h5 := Complex.abs_re_le_norm (z - x)
      rw [← dist_eq_norm, Complex.sub_re, abs_le] at h5
      have h6 := min_le_left (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt)
      rcases hs with rfl | rfl <;> linarith [h5.1, h5.2]
    have := hsupp _ hr
    rw [hempty, measure_empty] at this
    exact lt_irrefl _ this
  constructor
  · rintro ⟨hs, hn⟩
    rcases le_or_gt x.re (1 / 2) with hle | hgt
    · refine hn ?_
      have := sq9Sq_subset_essClosure 0 0 (show x ∈ sq9Sq 0 0 from
        ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩)
      simpa [sqColA] using this
    · exact hfar sqColA 1 (fun z hz hpos => by
        rw [sq9Col_near_edge hz, if_neg (by linarith)]; exact sqColA_ne_sqColB.symm) (Or.inl rfl) (by linarith) hs
  · rintro ⟨hs, hn⟩
    rcases le_or_gt (1 / 2) x.re with hle | hgt
    · refine hn ?_
      have := sq9Sq_subset_essClosure 1 0 (show x ∈ sq9Sq 1 0 from
        ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩)
      simpa [sqColB] using this
    · exact hfar sqColB (-1) (fun z hz hpos => by
        rw [sq9Col_near_edge hz, if_pos (by linarith)]; exact sqColA_ne_sqColB) (Or.inr rfl) (by linarith) hs

/-- The edge point is an essential boundary point of the left-hand class: both squares have positive upper density
there. -/
theorem sqEdgePt_mem_essBoundary : sqEdgePt ∈ essBoundary (sq9.cls sqColA) := by
  have hA : sqEdgePt ∈ essClosure (sq9.cls sqColA) := by
    have := sq9Sq_subset_essClosure 0 0 (show sqEdgePt ∈ sq9Sq 0 0 from by
      refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [sqEdgePt])
    simpa [sqColA] using this
  have hB : sqEdgePt ∈ essClosure (sq9.cls sqColB) := by
    have := sq9Sq_subset_essClosure 1 0 (show sqEdgePt ∈ sq9Sq 1 0 from by
      refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [sqEdgePt])
    simpa [sqColB] using this
  exact ⟨hA, fun hd => notMem_essClosure_of_mem_densitySet (sq9.measurableSet_cls _)
    (sq9.pairwise_disjoint_cls sqColA_ne_sqColB) hd hB⟩

/-- **Inhabitant of `local_graph`**: `sq9` at the edge point, `N = U = B(sqEdgePt, 1/8)` — every hypothesis at
once (`sq9_twoColourNhd`, no cusp in the ball, saturated by `sq9_tight_saturated`), so the theorem gives a chart of the
edge there. -/
theorem sq9_exists_isInterfaceChart : ∃ Q γ ψ h', Q ⊆ ball sqEdgePt (1 / 8) ∧
    IsInterfaceChart (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt Q γ ψ h' :=
  local_graph (sq9.measurableSet_cls _) (sq9.unitPairsNull _) (sq9.measurableSet_cls _) (sq9.unitPairsNull _)
    sq9_twoColourNhd.two isOpen_ball Subset.rfl (fun _ hx => sq9_not_isCuspAt_near_edge hx)
    (fun x hx => sq9_tight_saturated.2.1 _ x hx.1) (fun x hx => sq9_tight_saturated.2.1 _ x hx.1)
    ⟨sqEdgePt_mem_essBoundary, sqEdgePt_mem_ball⟩

end HadwigerNelson.Plane
