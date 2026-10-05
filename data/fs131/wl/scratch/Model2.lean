import Proofs.HadwigerNelson.Plane.Woodall.Steps

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **`sevenBrickMap` satisfies Condition 5**: its arcs are segments, and a segment meets a unit circle in finitely many points. -/
theorem sevenBrickMap_condition5 : sevenBrickMap.Condition5 := by
  intro a ha p
  rcases a.finite_inter_sphere_or_eq_circ (sevenBrickMap.nondegenerate a ha) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h.subset fun z hz => ⟨hz.1.1, hz.2⟩
  · exfalso
    change Arc.circ p 1 θ₀ θ₁ ∈ sevenBrickArcs at ha
    simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff] at ha
    obtain ⟨c, r, h | h⟩ := ha <;> cases h

/-- **The model of Woodall's Theorem 6's hypotheses on a plane map** (`woodall_thm6`; `LEAN.md` § The gate's inhabitant rule): at `k = 7`
the brick colouring itself agrees with `sevenBrickMap` at its interior points and is proper at every unit pair (`Brick.avoids`, M36). -/
theorem sevenBrickMap_thm6Model :
    sevenBrickMap.IsPlaneMap ∧ (∀ x ∈ sevenBrickMap.interiorPts, sevenBrickMap.col x = sevenBrickMap.col x) ∧
      ∀ x y : ℂ, dist x y = 1 → sevenBrickMap.col x ≠ sevenBrickMap.col y :=
  ⟨sevenBrickMap_isPlaneMap, fun _ _ => rfl, fun x y hxy =>
    sevenBrick.avoids (List.mem_singleton.mpr rfl) sevenBrick_check (by rw [hxy]; simp)⟩

namespace ArcMap

/-- **Adversary — a picture exists only at a point of the domain** (`SectorsAt`'s fifth clause, inventory item 155): `1` is not in
`threeSectorDisc`'s disc of radius `1/3`. A closed refutation, so a theorem taking this picture as a hypothesis is caught by the vacuity
scan. -/
theorem threeSectorDisc_not_sectorsAt_one : ¬ threeSectorDisc.SectorsAt 1 1 ![0, 2 * π] ![0] := by
  intro h
  have h1 : (1 : ℂ) ∈ ball (0 : ℂ) (1 / 3) := h.2.2.2.2.1
  rw [mem_ball, dist_zero_right, norm_one] at h1
  norm_num at h1

/-- **Adversary — `NiceAt` off the domain**: no picture, so no nice one, at `1 ∉ dom`. -/
theorem threeSectorDisc_not_niceAt_one : ¬ threeSectorDisc.NiceAt 1 := by
  rintro ⟨n, d, c, h, -⟩
  have h1 : (1 : ℂ) ∈ ball (0 : ℂ) (1 / 3) := h.2.2.2.2.1
  rw [mem_ball, dist_zero_right, norm_one] at h1
  norm_num at h1

/-- **A punctured three-sector disc**: `threeSectorDisc` with its centre removed from the domain. -/
noncomputable def puncturedThreeSectorDisc : ArcMap 3 where
  dom := ball 0 (1 / 3) \ {0}
  isOpen_dom := isOpen_ball.sdiff isClosed_singleton
  arcs := threeCuts
  nondegenerate := threeSectorDisc.nondegenerate
  locallyFinite := fun x hx => threeSectorDisc.locallyFinite x hx.1
  col := threeCol
  locallyConstant := fun x hx hcut => threeSectorDisc.locallyConstant x hx.1 hcut

/-- The centre lies on the cuts. -/
theorem zero_mem_threeCuts : (0 : ℂ) ∈ ⋃ a ∈ threeCuts, a.carrier :=
  mem_iUnion₂.mpr ⟨Arc.seg 0 (e 0 / 2), by simp [threeCuts], left_mem_segment ℝ _ _⟩

/-- Puncturing changes no colour class: the centre was on the cuts. -/
theorem puncturedThreeSectorDisc_region (j : Fin 3) : puncturedThreeSectorDisc.region j = threeSectorDisc.region j := by
  ext z
  constructor
  · rintro ⟨⟨⟨hz, -⟩, hcut⟩, hj⟩
    exact ⟨⟨hz, hcut⟩, hj⟩
  · rintro ⟨⟨hz, hcut⟩, hj⟩
    refine ⟨⟨⟨hz, fun h0 => hcut ?_⟩, hcut⟩, hj⟩
    rw [mem_singleton_iff.mp h0]; exact zero_mem_threeCuts

/-- The centre of the punctured disc still carries three colours. -/
theorem puncturedThreeSectorDisc_coloursAt_zero : (puncturedThreeSectorDisc.coloursAt 0).ncard = 3 := by
  have h : puncturedThreeSectorDisc.coloursAt 0 = threeSectorDisc.coloursAt 0 := by
    ext j; simp only [coloursAt, mem_setOf_eq, puncturedThreeSectorDisc_region]
  rw [h, threeSectorDisc_sectorsAt.coloursAt_eq]
  have : range (![0, 1, 2] : Fin 3 → Fin 3) = univ := by
    ext j; fin_cases j <;> simp
  rw [this, ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]

/-- **Adversary — the normal forms read the domain**: the punctured disc's centre carries three colours and lies outside its domain, so
no picture exists there and the map is not merged on the plane (FS131-QA2's lesson: a hypothesis is modelled where the theorem's others
hold — `aeMap6` asks for a map of the plane, and `exists_woodallMerged` gives the merged form only there). -/
theorem puncturedThreeSectorDisc_not_woodallMerged : ¬ puncturedThreeSectorDisc.WoodallMerged univ := by
  intro h
  obtain ⟨n, d, c, hS, -⟩ := h 0 (mem_univ _) puncturedThreeSectorDisc_coloursAt_zero.ge
  exact hS.2.2.2.2.1.2 rfl

/-- **Adversary — not in normal form**: as `puncturedThreeSectorDisc_not_woodallMerged`. -/
theorem puncturedThreeSectorDisc_not_woodallNormal : ¬ puncturedThreeSectorDisc.WoodallNormal univ := by
  intro h
  obtain ⟨n, d, c, hS, -⟩ := h 0 (mem_univ _) puncturedThreeSectorDisc_coloursAt_zero.ge
  exact hS.2.2.2.2.1.2 rfl

end ArcMap

#print axioms ArcMap.puncturedThreeSectorDisc_not_woodallNormal
#print axioms sevenBrickMap_condition5

end HadwigerNelson.Plane
