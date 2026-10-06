import Proofs.HadwigerNelson.Plane.Models.Paint

/-!
# Models of the four local moves: one horn and two horns in a brick, with a tangent disc (FS131-KM1, skeleton)

`plans/FS131-models-kernel-plan.md` § 3. Two maps of the plane in eight colours, each the brick map with one spare colour `7` painted on
small sets inside two bricks:

* `hornModel` — the horn `hornSet plantPt 0 (−1/2) (1/2) (1/10)` and the tangent disc. At `plantPt`: one horn of colour `7`, its one
  sector; both flanks the brick's colour `0`; degree `2`, one horn; the allowed cone of `7` a closed half-plane (one in-type contact, at
  the tangent point). **The model of `exists_shave` and of `exists_open`** (`hornModel_shave`, `hornModel_open`), a positive
  `HasHornCount plantPt 1`, and the holed tile `cvb_hole_disconnected` asks for (`hornModel_holedTile`: the tangent disc is a hole of
  its brick's tile).
* `twoHornModel` — the horns `hornSet plantPt 0 (−3/4) (−1/2) (1/10)` and `hornSet plantPt 0 (1/2) (3/4) (1/10)` and the tangent disc:
  two horns of colour `7` along one ray, two sectors of `7`, the same cone. **The model of `exists_rayMerge` and of `exists_merge`**
  (`twoHornModel_rayMerge`, `twoHornModel_merge`).

Each model theorem is the move applied to the map: it elaborates only if every hypothesis of the move is one of the facts proved here, at
once, on the one object. What each exercises and what it meets only degenerately is in the record, § 3.4.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## One horn in a brick -/

/-- The painted set of `hornModel`: the horn at the planted vertex and the tangent disc. -/
noncomputable def hornW : Set ℂ := hornSet plantPt 0 (-1 / 2) (1 / 2) (1 / 10) ∪ tangentDisc

/-- The new arcs of `hornModel`: the horn's three and the tangent disc's circle. -/
noncomputable def hornB : Set Arc :=
  hornArcs plantPt 0 (-1 / 2) (1 / 2) (1 / 10) ∪ {Arc.circ (plantPt + 19 / 20 * plantDir) (1 / 20) 0 (2 * π)}

theorem hornB_nondegenerate : ∀ a ∈ hornB, a.Nondegenerate := by
  sorry

theorem hornB_finite : hornB.Finite := (hornArcs_finite _ _ _ _ _).union (finite_singleton _)

theorem frontier_hornW_subset : frontier hornW ⊆ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ hornB, a.carrier := by
  sorry

/-- **One horn in a brick**: the brick map in eight colours, the colour `7` on a horn at `plantPt` between the tangent arcs of
curvatures `∓1/2` and on a disc of radius `1/20` internally tangent to `ω(plantPt)`. -/
noncomputable def hornModel : ArcMap 8 :=
  (brickBase 8 (by norm_num)).paint hornW hornB hornB_nondegenerate hornB_finite frontier_hornW_subset (fun _ => 7)
    (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl)

/-- `hornModel` is a map of the plane. -/
theorem hornModel_isPlaneMap : hornModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 8 _)

/-- `hornModel` covers the closed unit disc about the planted vertex. -/
theorem hornModel_covers : hornModel.Covers plantPt 1 := ArcMap.covers_of_isPlaneMap hornModel_isPlaneMap _ _

/-- `hornModel` is valid: the class of `7` is the horn and the tangent disc, any two of whose points are less than `1` apart. -/
theorem hornModel_valid : hornModel.Valid := by
  sorry

/-- The horn of colour `7` at the planted vertex. -/
theorem hornModel_isHorn : hornModel.IsHorn plantPt 0 (-1 / 2) (1 / 2) 7 := by
  sorry

/-- The colour `7` has one sector at the planted vertex. -/
theorem hornModel_hasSectors : hornModel.HasSectors plantPt 7 1 := by
  sorry

/-- The planted vertex has degree `2`: the horn and the rest of the brick. -/
theorem hornModel_hasDegree : hornModel.HasDegree plantPt 2 := by
  sorry

/-- **A positive horn count**: the planted vertex has exactly one horn. -/
theorem hornModel_hasHornCount : hornModel.HasHornCount plantPt 1 := by
  sorry

/-- Both flanks of the horn are the brick's colour `0`. -/
theorem hornModel_flanks : hornModel.IsFlankAbove plantPt 0 (1 / 2) 0 ∧ hornModel.IsFlankBelow plantPt 0 (-1 / 2) 0 := by
  sorry

/-- Every point of the horn is clear for the brick's colour: it was a point of that colour in the valid brick map. -/
theorem hornModel_clear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet plantPt 0 (-1 / 2) (1 / 2) r, hornModel.IsClear 0 z := by
  sorry

/-- **The contact**: the tangent point is an in-type contact of `7` at the planted vertex, and the opposite direction is not allowed —
the allowed cone is not the whole plane. -/
theorem hornModel_contact : hornModel.IsContact plantPt 7 (plantPt + plantDir) ∧ hornModel.InType plantPt 7 (plantPt + plantDir) ∧
    -plantDir ∉ hornModel.allowedCone plantPt 7 := by
  sorry

/-- The allowed cone of `7` at the planted vertex has interior points (it is the half-plane `d · plantDir ≥ 0`). -/
theorem hornModel_cone : (interior (hornModel.allowedCone plantPt 7)).Nonempty := by
  sorry

/-- SHAVE is available at the planted vertex of `hornModel`. -/
theorem hornModel_shaveAvailable : hornModel.ShaveAvailable plantPt :=
  ⟨7, 0, 0, 0, -1 / 2, 1 / 2, 0, hornModel_isHorn, hornModel_flanks.1, hornModel_flanks.2, by norm_num, by norm_num,
    hornModel_clear.mono fun _ hr z hz => ⟨fun _ => hr z hz, fun _ => hr z hz⟩⟩

/-- **The model of `exists_shave`**: the move applied to `hornModel` at the planted vertex (`n = 0`, the split at curvature `0`); the
shaved map has no sector of colour `7` there. -/
theorem hornModel_shave : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff hornModel (closedBall plantPt ρ) ∧
    F'.HasSectors plantPt 7 0 := by
  obtain ⟨ρ, hρ, F', h1, h2, -, -, h3, -⟩ := ArcMap.exists_shave hornModel_valid hornModel_covers (n := 0) (σ := 0)
    hornModel_hasSectors hornModel_isHorn (by norm_num) (by norm_num) hornModel_flanks.1 hornModel_flanks.2 (by norm_num)
    (by norm_num) (hornModel_clear.mono fun _ hr z hz => ⟨fun _ => hr z hz, fun _ => hr z hz⟩)
  exact ⟨ρ, hρ, F', h1, h2, h3⟩

/-- **The model of `exists_open`**: the move applied to `hornModel` at the planted vertex; the opened map has no horn there. -/
theorem hornModel_open : ∃ F' : ArcMap 8, F'.Valid ∧ F'.HasHornCount plantPt 0 := by
  obtain ⟨ρ, -, -, F', h1, -, -, -, -, ⟨m', j', -, hj, -, hj'⟩, -⟩ := ArcMap.exists_open hornModel_valid hornModel_covers
    hornModel_isHorn hornModel_hasSectors hornModel_cone hornModel_hasDegree hornModel_hasHornCount one_pos
  have : j' = 0 := by omega
  exact ⟨F', h1, this ▸ hj'⟩

/-- The tile of `hornModel` around the tangent disc: its brick `(2/5, 6/5) × (3/5, 6/5)` off the closed disc. -/
noncomputable def holedTile : Set ℂ :=
  {z | 2 / 5 < z.re ∧ z.re < 6 / 5 ∧ 3 / 5 < z.im ∧ z.im < 6 / 5} \ closure tangentDisc

/-- **A tile with a hole in a valid map of the plane**: `holedTile` is a tile of `hornModel` and the tangent disc is a hole of it — the
four clauses of wave 5's `IsHoleOf holedTile tangentDisc` (`Plane/ValidMap/MapGraph`), written out. -/
theorem hornModel_holedTile : hornModel.IsTile holedTile ∧ tangentDisc.Nonempty ∧ tangentDisc ⊆ (closure holedTile)ᶜ ∧
    Bornology.IsBounded tangentDisc ∧ Disjoint (closure tangentDisc) (closure ((closure holedTile)ᶜ \ tangentDisc)) := by
  sorry

/-! ## Two horns on one ray -/

/-- The painted set of `twoHornModel`: two horns along `e 0` at the planted vertex and the tangent disc. -/
noncomputable def twoHornW : Set ℂ :=
  hornSet plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornSet plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪ tangentDisc

/-- The new arcs of `twoHornModel`. -/
noncomputable def twoHornB : Set Arc :=
  hornArcs plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornArcs plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪
    {Arc.circ (plantPt + 19 / 20 * plantDir) (1 / 20) 0 (2 * π)}

theorem twoHornB_nondegenerate : ∀ a ∈ twoHornB, a.Nondegenerate := by
  sorry

theorem twoHornB_finite : twoHornB.Finite :=
  ((hornArcs_finite _ _ _ _ _).union (hornArcs_finite _ _ _ _ _)).union (finite_singleton _)

theorem frontier_twoHornW_subset : frontier twoHornW ⊆ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ twoHornB, a.carrier := by
  sorry

/-- **Two horns on one ray in a brick**: the brick map in eight colours, the colour `7` on two horns at `plantPt` along `e 0` (between the
curvatures `−3/4, −1/2` and `1/2, 3/4`) and on the tangent disc. -/
noncomputable def twoHornModel : ArcMap 8 :=
  (brickBase 8 (by norm_num)).paint twoHornW twoHornB twoHornB_nondegenerate twoHornB_finite frontier_twoHornW_subset (fun _ => 7)
    (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl)

/-- `twoHornModel` is a map of the plane. -/
theorem twoHornModel_isPlaneMap : twoHornModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 8 _)

/-- `twoHornModel` covers the closed unit disc about the planted vertex. -/
theorem twoHornModel_covers : twoHornModel.Covers plantPt 1 := ArcMap.covers_of_isPlaneMap twoHornModel_isPlaneMap _ _

/-- `twoHornModel` is valid. -/
theorem twoHornModel_valid : twoHornModel.Valid := by
  sorry

/-- The two horns of colour `7` along `e 0`. -/
theorem twoHornModel_isHorn : twoHornModel.IsHorn plantPt 0 (-3 / 4) (-1 / 2) 7 ∧ twoHornModel.IsHorn plantPt 0 (1 / 2) (3 / 4) 7 := by
  sorry

/-- The colour `7` has two sectors at the planted vertex (and the brick's colour `0` two: the gap between the horns and the rest). -/
theorem twoHornModel_hasSectors : twoHornModel.HasSectors plantPt 7 2 ∧ twoHornModel.HasSectors plantPt 0 2 := by
  sorry

/-- The allowed cone of `7` at the planted vertex has interior points, and is not the whole plane (the tangent point is an in-type
contact). -/
theorem twoHornModel_cone : (interior (twoHornModel.allowedCone plantPt 7)).Nonempty ∧
    twoHornModel.IsContact plantPt 7 (plantPt + plantDir) ∧ -plantDir ∉ twoHornModel.allowedCone plantPt 7 := by
  sorry

/-- MERGE and MERGE-RAY are both available at the planted vertex of `twoHornModel`. -/
theorem twoHornModel_available : twoHornModel.MergeAvailable plantPt ∧ twoHornModel.RayAvailable plantPt :=
  ⟨⟨7, 2, le_rfl, twoHornModel_hasSectors.1, twoHornModel_cone.1⟩,
    ⟨7, 0, -3 / 4, -1 / 2, 1 / 2, 3 / 4, by norm_num, twoHornModel_isHorn.1, twoHornModel_isHorn.2⟩⟩

/-- **The model of `exists_rayMerge`**: the move applied to `twoHornModel` at the planted vertex; the merged map has one sector of
colour `7` there. -/
theorem twoHornModel_rayMerge : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff twoHornModel (closedBall plantPt ρ) ∧
    F'.HasSectors plantPt 7 1 := by
  obtain ⟨-, ρ, hρ, F', h1, h2, -, -, h3, -⟩ := ArcMap.exists_rayMerge twoHornModel_valid twoHornModel_covers (n := 1)
    twoHornModel_hasSectors.1 (by norm_num : (-1 / 2 : ℝ) < 1 / 2) twoHornModel_isHorn.1 twoHornModel_isHorn.2 (by norm_num)
    (by norm_num)
  exact ⟨ρ, hρ, F', h1, h2, h3⟩

/-- **The model of `exists_merge`**: the move applied to `twoHornModel` at the planted vertex; the merged map has one sector of colour
`7` there. -/
theorem twoHornModel_merge : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff twoHornModel (closedBall plantPt ρ) ∧
    F'.HasSectors plantPt 7 1 := by
  obtain ⟨ρ, hρ, F', h1, h2, -, -, h3, -⟩ := ArcMap.exists_merge twoHornModel_valid twoHornModel_covers (n := 1) le_rfl
    twoHornModel_hasSectors.1 twoHornModel_cone.1
  exact ⟨ρ, hρ, F', h1, h2, h3⟩

end HadwigerNelson.Plane
