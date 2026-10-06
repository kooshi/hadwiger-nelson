import Proofs.HadwigerNelson.Plane.Models.Paint

/-!
# Models of the four local moves: one horn and two horns in a brick, with a tangent disc (FS131-KM1; its leaves FS131-MA1)

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

**How the facts are read off the picture** (FS131-MA1, `plans/FS131-MA1-implementation.md` § 3.2). The class of `7` is the painted set
(`hornModel_region_seven`); near the planted vertex the new arcs are a fan of tangent arcs, so the sectors are the fan's rest and its
horns for every radius up to `1/10` (`hornModel_isSector_iff`, `twoHornModel_isSector_iff`); and the class reaches `ω(plantPt)` at the
tangent point only, so the allowed cone is the closed half-plane `d · plantDir ≥ 0` (`hornModel_allowedCone`).
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
  rintro a (ha | ha)
  · exact hornArcs_nondegenerate plantPt 0 (by norm_num) (by norm_num) (by rw [abs_of_neg] <;> norm_num)
      (by rw [abs_of_pos] <;> norm_num) a ha
  · rw [mem_singleton_iff] at ha
    rw [ha]
    exact tangentCircle_nondegenerate

theorem hornB_finite : hornB.Finite := (hornArcs_finite _ _ _ _ _).union (finite_singleton _)

theorem frontier_hornW_subset : frontier hornW ⊆ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ hornB, a.carrier := by
  intro z hz
  rcases frontier_union_subset _ _ hz with ⟨h, -⟩ | ⟨-, h⟩
  · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp (frontier_hornSet_subset plantPt 0 (by norm_num) (by norm_num)
      (by rw [abs_of_neg] <;> norm_num) (by rw [abs_of_pos] <;> norm_num) h)
    exact mem_iUnion₂.mpr ⟨a, Or.inr (Or.inl ha), hza⟩
  · rw [frontier_tangentDisc] at h
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inr rfl), h⟩

/-- **One horn in a brick**: the brick map in eight colours, the colour `7` on a horn at `plantPt` between the tangent arcs of
curvatures `∓1/2` and on a disc of radius `1/20` internally tangent to `ω(plantPt)`. -/
noncomputable def hornModel : ArcMap 8 :=
  (brickBase 8 (by norm_num)).paint hornW hornB hornB_nondegenerate hornB_finite frontier_hornW_subset (fun _ => 7)
    (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl)

/-- `hornModel` is a map of the plane. -/
theorem hornModel_isPlaneMap : hornModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 8 _)

/-- `hornModel` covers the closed unit disc about the planted vertex. -/
theorem hornModel_covers : hornModel.Covers plantPt 1 := ArcMap.covers_of_isPlaneMap hornModel_isPlaneMap _ _

/-- `hornModel`, unfolded: the painting it is. -/
theorem hornModel_eq_paint : hornModel = (brickBase 8 (by norm_num)).paint hornW hornB hornB_nondegenerate hornB_finite
    frontier_hornW_subset (fun _ => 7) (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl) := rfl

/-- The fan of `hornModel` at the planted vertex: the tangent arcs of curvatures `∓1/2`. -/
noncomputable def hornFan : Fin 2 → ℝ := ![-1 / 2, 1 / 2]

-- spec example for `hornFan`
example : hornFan 0 = -1 / 2 ∧ hornFan 1 = 1 / 2 := ⟨rfl, rfl⟩

/-- The fan's curvatures increase. -/
theorem hornFan_strictMono : StrictMono hornFan := by
  rw [Fin.strictMono_iff_lt_succ]
  intro i
  fin_cases i
  show (-1 / 2 : ℝ) < 1 / 2
  norm_num

/-- The fan's arcs out to `1/10` are graphs over the radius. -/
theorem hornFan_bound (i : Fin 2) : |hornFan i| * (1 / 10) ≤ 1 := by
  fin_cases i
  · show |(-1 / 2 : ℝ)| * (1 / 10) ≤ 1
    rw [abs_of_neg (by norm_num)]; norm_num
  · show |(1 / 2 : ℝ)| * (1 / 10) ≤ 1
    rw [abs_of_pos (by norm_num)]; norm_num

/-- **Near the planted vertex the new arcs of `hornModel` are its fan.** -/
theorem hornB_inter_ball {r : ℝ} (hr : r ≤ 1 / 10) {z : ℂ} (hz : z ∈ ball plantPt r) :
    z ∈ ⋃ a ∈ hornB, a.carrier ↔ z ∈ ⋃ i, (germArc plantPt 0 (hornFan i) (1 / 10)).carrier := by
  have hd : dist z plantPt < 1 / 10 := lt_of_lt_of_le hz hr
  rw [hornB, biUnion_union, mem_union, biUnion_singleton, tangentCircle_carrier, mem_hornArcs_carrier_iff_of_mem_ball hd,
    mem_iUnion, Fin.exists_fin_two]
  constructor
  · rintro (h | h)
    · exact h
    · have := tangentDisc_far (le_of_eq (mem_sphere.mp h))
      linarith
  · exact fun h => Or.inl h

/-- The interior points of `hornModel` near the planted vertex are the ball off the fan. -/
theorem hornModel_interiorPts_inter_ball {r : ℝ} (hr : r ≤ 1 / 10) :
    hornModel.interiorPts ∩ ball plantPt r = ball plantPt r \ ⋃ i, (germArc plantPt 0 (hornFan i) (1 / 10)).carrier :=
  ArcMap.interiorPts_paint_inter_ball
    ((ball_subset_closedBall.trans (closedBall_subset_closedBall hr)).trans (plantBall_subset_interiorPts _))
    (fun _ hz => hornB_inter_ball hr hz)

/-- **The sectors of `hornModel` at the planted vertex**, for every radius up to `1/10`: the rest and the horn. -/
theorem hornModel_isSector_iff {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 10) {S : Set ℂ} :
    hornModel.IsSector plantPt r S ↔ S = fanRest plantPt 0 (-1 / 2) (1 / 2) r ∨ S = hornSet plantPt 0 (-1 / 2) (1 / 2) r := by
  rw [isSector_fan_iff hornFan hornFan_strictMono hr0 hr hornFan_bound (by show (-1 / 2 : ℝ) < 0; norm_num) (by show (0 : ℝ) < 1 / 2; norm_num)
    (hornModel_interiorPts_inter_ball hr)]
  constructor
  · rintro (h | ⟨i, h⟩)
    · exact Or.inl h
    · fin_cases i; exact Or.inr h
  · rintro (h | h)
    · exact Or.inl h
    · exact Or.inr ⟨0, h⟩

/-- The painted set misses the new arcs. -/
theorem hornW_disjoint_hornB : Disjoint hornW (⋃ a ∈ hornB, a.carrier) := by
  rw [hornW, hornB, biUnion_union, biUnion_singleton, tangentCircle_carrier]
  refine Disjoint.union_left (Disjoint.union_right ?_ ?_) (Disjoint.union_right ?_ ?_)
  · exact disjoint_hornSet_hornArcs le_rfl (by rw [abs_of_neg] <;> norm_num) (by rw [abs_of_pos] <;> norm_num)
      (Or.inl le_rfl) (Or.inr le_rfl)
  · rw [disjoint_left]
    intro z hz hs
    have := tangentDisc_far (le_of_eq (mem_sphere.mp hs))
    linarith [hz.1]
  · rw [disjoint_left]
    intro z hz ha
    have h1 := hornArcs_carrier_subset plantPt 0 (by norm_num : (0 : ℝ) < 1 / 10) (by rw [abs_of_neg] <;> norm_num)
      (by rw [abs_of_pos] <;> norm_num) ha
    have h2 := tangentDisc_far (le_of_lt (mem_ball.mp hz))
    rw [mem_closedBall] at h1
    linarith
  · rw [disjoint_left]
    intro z hz hs
    rw [tangentDisc, mem_ball] at hz
    rw [mem_sphere] at hs
    linarith

/-- The painted set consists of interior points of the base. -/
theorem hornW_subset_interiorPts : hornW ⊆ (brickBase 8 (by norm_num)).interiorPts := by
  rintro z (hz | hz)
  · exact plantBall_subset_interiorPts _ (mem_closedBall.mpr hz.1.le)
  · exact tangentBrick_subset_interiorPts _ (closedBall_tangentCentre_subset_tangentBrick
      ((le_of_lt (mem_ball.mp hz)).trans (by norm_num)))

/-- **The class of `7` in `hornModel` is the painted set.** -/
theorem hornModel_region_seven : hornModel.region 7 = hornW := by
  rw [hornModel_eq_paint, ArcMap.region_paint_of_region_eq_empty (brickBase_region_spare _ (by decide))]
  ext z
  constructor
  · rintro ⟨⟨⟨-, hz⟩, -⟩, -⟩
    exact hz
  · intro hz
    exact ⟨⟨⟨hornW_subset_interiorPts hz, hz⟩, rfl⟩, disjoint_left.mp hornW_disjoint_hornB hz⟩

/-- The colour of a painted point. -/
theorem hornModel_col_of_mem {z : ℂ} (hz : z ∈ hornW) : hornModel.col z = 7 := ArcMap.paint_col_of_mem hz

/-- The colour of a point near the planted vertex off the painted set: the brick's colour `0`. -/
theorem hornModel_col_of_not_mem {z : ℂ} (hz : z ∉ hornW) (hd : dist z plantPt ≤ 1 / 10) : hornModel.col z = 0 := by
  rw [hornModel_eq_paint, ArcMap.paint_col_of_not_mem hz]
  exact Fin.ext (brickBase_col_zero _ (plantBall_subset_brick hd).1 (plantBall_subset_brick hd).2)

/-- `hornModel` is valid: the class of `7` is the horn and the tangent disc, any two of whose points are less than `1` apart. -/
theorem hornModel_valid : hornModel.Valid := by
  refine ArcMap.paint_valid (brickBase_valid 8 _) (fun x hx y hy _ _ hxy => ?_) (fun x _ _ y hy => ?_)
  · have hzone : ∀ z ∈ hornW, (dist z plantPt < 1 / 10 ∧ dist z (plantPt + 19 / 20 * plantDir) ≤ 19 / 20) ∨ z ∈ tangentDisc := by
      rintro z (hz | hz)
      · exact Or.inl ⟨hz.1, dist_tangentCentre_le_of_mem_hornSet (by norm_num) (by norm_num) hz⟩
      · exact Or.inr hz
    exact absurd hxy (dist_lt_one_of_hornZone (hzone x hx) (hzone y hy)).ne
  · rw [brickBase_region_spare _ (by decide)] at hy
    exact absurd hy (notMem_empty y)

/-- The horn is painted. -/
theorem hornModel_horn_subset_col {r : ℝ} (hr : r ≤ 1 / 10) :
    hornSet plantPt 0 (-1 / 2) (1 / 2) r ⊆ hornModel.col ⁻¹' {7} :=
  fun _ hz => hornModel_col_of_mem (Or.inl (hornSet_mono_radius hr hz))

/-- The rest is of the brick's colour `0`. -/
theorem hornModel_fanRest_subset_region {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 10) :
    fanRest plantPt 0 (-1 / 2) (1 / 2) r ⊆ hornModel.region 0 := by
  intro z hz
  refine ⟨(ArcMap.IsSector.subset ((hornModel_isSector_iff hr0 hr).mpr (Or.inl rfl)) hz).1, ?_⟩
  refine hornModel_col_of_not_mem ?_ (hz.1.le.trans hr)
  rintro (h | h)
  · exact disjoint_left.mp (disjoint_fanRest_hornSet le_rfl le_rfl) hz h
  · have := tangentDisc_far (le_of_lt (mem_ball.mp h))
    linarith [hz.1]

/-- The horn of colour `7` at the planted vertex. -/
theorem hornModel_isHorn : hornModel.IsHorn plantPt 0 (-1 / 2) (1 / 2) 7 := by
  refine ⟨by norm_num, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
  exact ⟨(hornModel_isSector_iff hr.1 hr.2).mpr (Or.inr rfl), hornModel_horn_subset_col hr.2⟩

/-- The colour `7` has one sector at the planted vertex. -/
theorem hornModel_hasSectors : hornModel.HasSectors plantPt 7 1 := by
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
  have h : hornModel.sectorsOf plantPt r 7 = {hornSet plantPt 0 (-1 / 2) (1 / 2) r} := by
    ext S
    simp only [ArcMap.sectorsOf, mem_setOf_eq, mem_singleton_iff]
    constructor
    · rintro ⟨hS, hc⟩
      rcases (hornModel_isSector_iff hr.1 hr.2).mp hS with rfl | rfl
      · exact (hS.false_of_col hc (fun z hz => (hornModel_fanRest_subset_region hr.1 hr.2 hz).2) (by decide)).elim
      · rfl
    · rintro rfl
      exact ⟨(hornModel_isSector_iff hr.1 hr.2).mpr (Or.inr rfl), hornModel_horn_subset_col hr.2⟩
  rw [h, encard_singleton]
  rfl

/-- The planted vertex has degree `2`: the horn and the rest of the brick. -/
theorem hornModel_hasDegree : hornModel.HasDegree plantPt 2 := by
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
  have h : {S | hornModel.IsSector plantPt r S} =
      {fanRest plantPt 0 (-1 / 2) (1 / 2) r, hornSet plantPt 0 (-1 / 2) (1 / 2) r} := by
    ext S
    simp only [mem_setOf_eq, mem_insert_iff, mem_singleton_iff]
    exact hornModel_isSector_iff hr.1 hr.2
  rw [h, encard_pair (fanRest_ne_hornSet plantPt 0 hr.1 0 (-1 / 2) (1 / 2))]
  rfl

/-- **A positive horn count**: the planted vertex has exactly one horn. -/
theorem hornModel_hasHornCount : hornModel.HasHornCount plantPt 1 := by
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
  have h : {S | hornModel.IsSector plantPt r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet plantPt α κ₁ κ₂ r} =
      {hornSet plantPt 0 (-1 / 2) (1 / 2) r} := by
    ext S
    simp only [mem_setOf_eq, mem_singleton_iff]
    constructor
    · rintro ⟨hS, α, κ₁, κ₂, -, hSh⟩
      rcases (hornModel_isSector_iff hr.1 hr.2).mp hS with rfl | rfl
      · exact absurd hSh (fanRest_ne_hornSet plantPt 0 hr.1 α κ₁ κ₂)
      · rfl
    · rintro rfl
      exact ⟨(hornModel_isSector_iff hr.1 hr.2).mpr (Or.inr rfl), 0, -1 / 2, 1 / 2, by norm_num, rfl⟩
  rw [h, encard_singleton]
  rfl

/-- Both flanks of the horn are the brick's colour `0`. -/
theorem hornModel_flanks : hornModel.IsFlankAbove plantPt 0 (1 / 2) 0 ∧ hornModel.IsFlankBelow plantPt 0 (-1 / 2) 0 := by
  constructor
  · refine ⟨1, by norm_num, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
    exact fun z hz => hornModel_fanRest_subset_region hr.1 hr.2 ⟨hz.1, Or.inr (Or.inr hz.2.2.1)⟩
  · refine ⟨-1, by norm_num, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
    exact fun z hz => hornModel_fanRest_subset_region hr.1 hr.2 ⟨hz.1, Or.inr (Or.inl hz.2.2.2)⟩

/-- Every point of the horn is clear for the brick's colour: it was a point of that colour in the valid brick map. -/
theorem hornModel_clear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet plantPt 0 (-1 / 2) (1 / 2) r, hornModel.IsClear 0 z := by
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr z hz
  exact ArcMap.isClear_paint_of_mem_region (brickBase_valid 8 _) (fun _ _ => by decide)
    (plantBall_subset_region_zero (mem_closedBall.mpr (hz.1.le.trans hr.2)))

/-- The painted set lies in the small disc about the planted vertex and the tangent disc. -/
theorem hornW_subset : hornW ⊆ closedBall plantPt (1 / 10) ∪ tangentDisc := by
  rintro z (hz | hz)
  · exact Or.inl (mem_closedBall.mpr hz.1.le)
  · exact Or.inr hz

/-- **The class of `7` against `ω(plantPt)`**: `7` is carried at the planted vertex, its class lies in `B(plantPt, 1)`, holds the tangent
disc, and reaches `ω(plantPt)` at the tangent point only — the hypotheses of `ArcMap.allowedCone_tangent`. -/
theorem hornModel_tangent : 7 ∈ hornModel.coloursAt plantPt ∧ hornModel.region 7 ⊆ ball plantPt 1 ∧
    tangentDisc ⊆ hornModel.region 7 ∧ closure (hornModel.region 7) ∩ sphere plantPt 1 ⊆ {plantPt + plantDir} := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · show plantPt ∈ closure (hornModel.region 7)
    rw [hornModel_region_seven]
    exact closure_mono subset_union_left (mem_closure_of_mem_coneAt
      (mem_coneAt_hornSet plantPt 0 (by norm_num : (-1 / 2 : ℝ) < 1 / 2) (by norm_num : (0 : ℝ) < 1 / 10)))
  · rw [hornModel_region_seven]
    rintro z (hz | hz)
    · exact mem_ball.mpr (hz.1.trans (by norm_num))
    · exact tangentDisc_subset_ball.1 hz
  · rw [hornModel_region_seven]
    exact subset_union_right
  · rw [hornModel_region_seven]
    exact closure_inter_sphere_subset hornW_subset

/-- **The allowed cone of `7` at the planted vertex is the closed half-plane `d · plantDir ≥ 0`**: one contact, in-type and not
out-type. -/
theorem hornModel_allowedCone : hornModel.allowedCone plantPt 7 = {d | 0 ≤ dot d plantDir} :=
  (ArcMap.allowedCone_tangent hornModel_tangent.1 hornModel_tangent.2.1 hornModel_tangent.2.2.1 hornModel_tangent.2.2.2).2.2.2

/-- **The contact and the cone of `7` in `hornModel`.** -/
theorem hornModel_contact_cone : hornModel.IsContact plantPt 7 (plantPt + plantDir) ∧
    hornModel.InType plantPt 7 (plantPt + plantDir) ∧ -plantDir ∉ hornModel.allowedCone plantPt 7 ∧
    (interior (hornModel.allowedCone plantPt 7)).Nonempty :=
  ArcMap.tangent_contact_cone hornModel_tangent.1 hornModel_tangent.2.1 hornModel_tangent.2.2.1 hornModel_tangent.2.2.2

/-- **The contact**: the tangent point is an in-type contact of `7` at the planted vertex, and the opposite direction is not allowed —
the allowed cone is not the whole plane. -/
theorem hornModel_contact : hornModel.IsContact plantPt 7 (plantPt + plantDir) ∧ hornModel.InType plantPt 7 (plantPt + plantDir) ∧
    -plantDir ∉ hornModel.allowedCone plantPt 7 :=
  ⟨hornModel_contact_cone.1, hornModel_contact_cone.2.1, hornModel_contact_cone.2.2.1⟩

/-- The allowed cone of `7` at the planted vertex has interior points (it is the half-plane `d · plantDir ≥ 0`). -/
theorem hornModel_cone : (interior (hornModel.allowedCone plantPt 7)).Nonempty := hornModel_contact_cone.2.2.2

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

/-- The holed tile is the tangent brick off the closed tangent disc. -/
theorem holedTile_eq : holedTile = tangentBrick \ closedBall (plantPt + 19 / 20 * plantDir) (1 / 20) := by
  rw [holedTile, tangentDisc, closure_ball _ (by norm_num : (1 / 20 : ℝ) ≠ 0)]
  rfl

/-- The holed tile is open. -/
theorem isOpen_holedTile : IsOpen holedTile := by
  rw [holedTile_eq]
  exact isOpen_tangentBrick.sdiff isClosed_closedBall

/-- The closure of the holed tile lies in the closed rectangle, off the open tangent disc. -/
theorem closure_holedTile_subset : closure holedTile ⊆
    {z : ℂ | 2 / 5 ≤ z.re ∧ z.re ≤ 6 / 5 ∧ 3 / 5 ≤ z.im ∧ z.im ≤ 6 / 5} ∩ tangentDiscᶜ := by
  intro z hz
  refine ⟨closure_tangentBrick_subset (closure_mono (by rw [holedTile_eq]; exact sdiff_subset) hz), ?_⟩
  have hsub : holedTile ⊆ tangentDiscᶜ := by
    rw [holedTile_eq]
    exact fun w hw hD => hw.2 (ball_subset_closedBall hD)
  exact closure_minimal hsub (isOpen_ball.isClosed_compl) hz

/-- The holed tile consists of interior points of `hornModel`. -/
theorem holedTile_subset_interiorPts : holedTile ⊆ hornModel.interiorPts := by
  rw [hornModel_eq_paint, ArcMap.interiorPts_paint, holedTile_eq]
  rintro z ⟨hz, hzc⟩
  refine ⟨tangentBrick_subset_interiorPts _ hz, fun hB => ?_⟩
  rw [hornB, biUnion_union, biUnion_singleton, tangentCircle_carrier] at hB
  rcases hB with h | h
  · have h1 := hornArcs_carrier_subset plantPt 0 (by norm_num : (0 : ℝ) < 1 / 10) (by rw [abs_of_neg] <;> norm_num)
      (by rw [abs_of_pos] <;> norm_num) h
    have := (plantBall_subset_brick (mem_closedBall.mp h1)).2.2
    linarith [hz.2.2.1]
  · exact hzc (sphere_subset_closedBall h)

/-- **An interior point of `hornModel` in the closure of the holed tile is in it**: the tile's frontier is cell edges and the tangent
circle. -/
theorem mem_holedTile_of_mem_closure {z : ℂ} (hzI : z ∈ hornModel.interiorPts) (hz : z ∈ closure holedTile) : z ∈ holedTile := by
  obtain ⟨hrect, hD⟩ := closure_holedTile_subset hz
  rw [hornModel_eq_paint, ArcMap.interiorPts_paint] at hzI
  rw [holedTile_eq]
  refine ⟨mem_tangentBrick_of_mem_interiorPts _ hzI.1 hrect, fun hc => hzI.2 ?_⟩
  have hs : z ∈ sphere (plantPt + 19 / 20 * plantDir) (1 / 20) := by
    rw [mem_sphere]
    have h1 : ¬ dist z (plantPt + 19 / 20 * plantDir) < 1 / 20 := fun h => hD (mem_ball.mpr h)
    exact le_antisymm (mem_closedBall.mp hc) (not_lt.mp h1)
  rw [hornB, biUnion_union, biUnion_singleton, tangentCircle_carrier]
  exact Or.inr hs

/-- A point of the holed tile: `1/2 + (7/10) i`, in the brick's lower left corner. -/
theorem holedTile_base_mem : ((1 / 2 : ℝ) : ℂ) + ((7 / 10 : ℝ) : ℂ) * I ∈ holedTile := by
  rw [holedTile_eq]
  refine ⟨mk_mem_tangentBrick (by norm_num) (by norm_num), fun h => ?_⟩
  have h1 := abs_le.mp ((abs_re_sub_le_dist _ _).trans (mem_closedBall.mp h))
  rw [tangentCentre_re, re_add_mul_I] at h1
  linarith [h1.1]

/-- **The holed tile is connected**: the four rectangles of the brick off the disc's bounding square are convex and chained at the
corners, and every other point `y` is joined to them by the radial segment `[y, c + (3/2)(y − c)]`. -/
theorem isPreconnected_holedTile : IsPreconnected holedTile := by
  set c : ℂ := plantPt + 19 / 20 * plantDir with hc
  set U : Set ℂ := tangentBrick ∩ ({z | 51 / 50 < z.re} ∪ {z | 111 / 100 < z.im} ∪ {z | z.re < 92 / 100} ∪ {z | z.im < 101 / 100})
    with hU
  have hfar : ∀ z : ℂ, dist z c ≤ 1 / 20 → (92 / 100 ≤ z.re ∧ z.re ≤ 51 / 50) ∧ (101 / 100 ≤ z.im ∧ z.im ≤ 111 / 100) := by
    intro z hz
    have h1 := abs_le.mp ((abs_re_sub_le_dist z c).trans hz)
    have h2 := abs_le.mp ((abs_im_sub_le_dist z c).trans hz)
    rw [hc, tangentCentre_re] at h1
    rw [hc, tangentCentre_im] at h2
    exact ⟨⟨by linarith [h1.1], by linarith [h1.2]⟩, ⟨by linarith [h2.1], by linarith [h2.2]⟩⟩
  have hUsub : U ⊆ holedTile := by
    rw [holedTile_eq]
    rintro z ⟨hzb, hz⟩
    refine ⟨hzb, fun hzc => ?_⟩
    obtain ⟨⟨a1, a2⟩, ⟨a3, a4⟩⟩ := hfar z (mem_closedBall.mp hzc)
    rcases hz with ((h | h) | h) | h
    · exact absurd h (not_lt.mpr a2)
    · exact absurd h (not_lt.mpr a4)
    · exact absurd h (not_lt.mpr a1)
    · exact absurd h (not_lt.mpr a3)
  -- the four convex pieces, chained at three corners
  have hconv : ∀ H : Set ℂ, Convex ℝ H → IsPreconnected (tangentBrick ∩ H) := fun H hH =>
    (convex_tangentBrick.inter hH).isPreconnected
  have hp12 : ((11 / 10 : ℝ) : ℂ) + ((23 / 20 : ℝ) : ℂ) * I ∈ tangentBrick := mk_mem_tangentBrick (by norm_num) (by norm_num)
  have hp23 : ((1 / 2 : ℝ) : ℂ) + ((23 / 20 : ℝ) : ℂ) * I ∈ tangentBrick := mk_mem_tangentBrick (by norm_num) (by norm_num)
  have hp34 : ((1 / 2 : ℝ) : ℂ) + ((7 / 10 : ℝ) : ℂ) * I ∈ tangentBrick := mk_mem_tangentBrick (by norm_num) (by norm_num)
  have hx0D : ((1 / 2 : ℝ) : ℂ) + ((7 / 10 : ℝ) : ℂ) * I ∈ {z : ℂ | z.im < 101 / 100} := by
    show (_ : ℂ).im < 101 / 100
    rw [im_add_mul_I]; norm_num
  have hUpre : IsPreconnected U := by
    rw [hU, inter_union_distrib_left, inter_union_distrib_left, inter_union_distrib_left]
    exact IsPreconnected.union _
        (Or.inr ⟨hp34, by show (_ : ℂ).re < 92 / 100; rw [re_add_mul_I]; norm_num⟩) ⟨hp34, hx0D⟩
      (IsPreconnected.union _
          (Or.inr ⟨hp23, by show 111 / 100 < (_ : ℂ).im; rw [im_add_mul_I]; norm_num⟩)
          ⟨hp23, by show (_ : ℂ).re < 92 / 100; rw [re_add_mul_I]; norm_num⟩
        (IsPreconnected.union _
            ⟨hp12, by show 51 / 50 < (_ : ℂ).re; rw [re_add_mul_I]; norm_num⟩
            ⟨hp12, by show 111 / 100 < (_ : ℂ).im; rw [im_add_mul_I]; norm_num⟩
          (hconv _ (convex_halfSpace_re_gt _)) (hconv _ (convex_halfSpace_im_gt _)))
        (hconv _ (convex_halfSpace_re_lt _))) (hconv _ (convex_halfSpace_im_lt _))
  refine isPreconnected_of_forall (((1 / 2 : ℝ) : ℂ) + ((7 / 10 : ℝ) : ℂ) * I) fun y hy => ?_
  have hx0 : ((1 / 2 : ℝ) : ℂ) + ((7 / 10 : ℝ) : ℂ) * I ∈ U := ⟨hp34, Or.inr hx0D⟩
  by_cases hyU : y ∈ U
  · exact ⟨U, hUsub, hx0, hyU, hUpre⟩
  -- `y` is in the disc's bounding square: push it radially out of the square
  have hyb : y ∈ tangentBrick := by rw [holedTile_eq] at hy; exact hy.1
  have hyc : 1 / 20 < dist y c := by
    rw [holedTile_eq] at hy
    exact not_le.mp fun h => hy.2 (mem_closedBall.mpr h)
  have hsq : ¬ (51 / 50 < y.re ∨ 111 / 100 < y.im ∨ y.re < 92 / 100 ∨ y.im < 101 / 100) := by
    intro h
    refine hyU ⟨hyb, ?_⟩
    rcases h with h | h | h | h
    · exact Or.inl (Or.inl (Or.inl h))
    · exact Or.inl (Or.inl (Or.inr h))
    · exact Or.inl (Or.inr h)
    · exact Or.inr h
  push Not at hsq
  obtain ⟨b1, b2, b3, b4⟩ := hsq
  have hcre : c.re = 97 / 100 := by rw [hc, tangentCentre_re]
  have hcim : c.im = 106 / 100 := by rw [hc, tangentCentre_im]
  have hd2 : (1 / 20 : ℝ) ^ 2 < (y.re - 97 / 100) ^ 2 + (y.im - 106 / 100) ^ 2 := by
    have := pow_lt_pow_left₀ hyc (by norm_num) (by norm_num : (2 : ℕ) ≠ 0)
    rwa [dist_sq_re_im, hcre, hcim] at this
  set y' : ℂ := c + ((3 / 2 : ℝ) : ℂ) * (y - c) with hy'
  have hy're : y'.re = 97 / 100 + 3 / 2 * (y.re - 97 / 100) := by
    rw [hy', Complex.add_re, Complex.re_ofReal_mul, Complex.sub_re, hcre]
  have hy'im : y'.im = 106 / 100 + 3 / 2 * (y.im - 106 / 100) := by
    rw [hy', Complex.add_im, Complex.im_ofReal_mul, Complex.sub_im, hcim]
  have hy'b : y' ∈ tangentBrick := by
    refine ⟨?_, ?_, ?_, ?_⟩
    · show 2 / 5 < y'.re; rw [hy're]; linarith
    · show y'.re < 6 / 5; rw [hy're]; linarith
    · show 3 / 5 < y'.im; rw [hy'im]; linarith
    · show y'.im < 6 / 5; rw [hy'im]; linarith
  have hy'U : y' ∈ U := by
    refine ⟨hy'b, ?_⟩
    by_contra hcon
    simp only [mem_union, mem_setOf_eq, not_or, not_lt] at hcon
    obtain ⟨⟨⟨c1, c2⟩, c3⟩, c4⟩ := hcon
    rw [hy're] at c1 c3
    rw [hy'im] at c2 c4
    nlinarith
  have hseg : segment ℝ y y' ⊆ holedTile := by
    rw [holedTile_eq]
    intro z hz
    refine ⟨convex_tangentBrick.segment_subset hyb hy'b hz, fun hzc => ?_⟩
    obtain ⟨a, b, ha, hb, hab, rfl⟩ := hz
    have hzd := pow_le_pow_left₀ dist_nonneg (mem_closedBall.mp hzc) 2
    rw [dist_sq_re_im, hcre, hcim] at hzd
    simp only [Complex.add_re, Complex.add_im, Complex.real_smul, Complex.re_ofReal_mul, Complex.im_ofReal_mul, hy're, hy'im]
      at hzd
    have ha' : a = 1 - b := by linarith
    subst ha'
    have e1 : (1 - b) * y.re + b * (97 / 100 + 3 / 2 * (y.re - 97 / 100)) - 97 / 100 = (1 + b / 2) * (y.re - 97 / 100) := by ring
    have e2 : (1 - b) * y.im + b * (106 / 100 + 3 / 2 * (y.im - 106 / 100)) - 106 / 100 = (1 + b / 2) * (y.im - 106 / 100) := by
      ring
    rw [e1, e2] at hzd
    have hb1 : 1 ≤ (1 + b / 2) ^ 2 := by nlinarith
    nlinarith [sq_nonneg (y.re - 97 / 100), sq_nonneg (y.im - 106 / 100)]
  exact ⟨U ∪ segment ℝ y y', union_subset hUsub hseg, Or.inl hx0, Or.inr (left_mem_segment ℝ y y'),
    IsPreconnected.union y' hy'U (right_mem_segment ℝ y y') hUpre (convex_segment y y').isPreconnected⟩

/-- **A tile with a hole in a valid map of the plane**: `holedTile` is a tile of `hornModel` and the tangent disc is a hole of it — the
four clauses of wave 5's `IsHoleOf holedTile tangentDisc` (`Plane/ValidMap/MapGraph`), written out. -/
theorem hornModel_holedTile : hornModel.IsTile holedTile ∧ tangentDisc.Nonempty ∧ tangentDisc ⊆ (closure holedTile)ᶜ ∧
    Bornology.IsBounded tangentDisc ∧ Disjoint (closure tangentDisc) (closure ((closure holedTile)ᶜ \ tangentDisc)) := by
  have hx0 := holedTile_base_mem
  refine ⟨⟨_, holedTile_subset_interiorPts hx0, ?_⟩, ⟨_, mem_ball_self (by norm_num)⟩, ?_, Metric.isBounded_ball, ?_⟩
  · -- the tile through `x₀` is the holed brick
    refine Subset.antisymm (isPreconnected_holedTile.subset_connectedComponentIn hx0 holedTile_subset_interiorPts) ?_
    refine IsPreconnected.subset_left_of_subset_union isOpen_holedTile isClosed_closure.isOpen_compl
      (disjoint_left.mpr fun z hz hzc => hzc (subset_closure hz)) (fun z hz => ?_)
      ⟨_, mem_connectedComponentIn (holedTile_subset_interiorPts hx0), hx0⟩ isPreconnected_connectedComponentIn
    by_cases hzc : z ∈ closure holedTile
    · exact Or.inl (mem_holedTile_of_mem_closure (connectedComponentIn_subset _ _ hz) hzc)
    · exact Or.inr hzc
  · exact fun z hz hzc => (closure_holedTile_subset hzc).2 hz
  · -- off the closure of the tile and off the disc is off the open brick, which holds the closed disc
    have hX : (closure holedTile)ᶜ \ tangentDisc ⊆ tangentBrickᶜ := by
      rintro p ⟨hpc, hpD⟩ hpb
      refine hpc ?_
      by_cases hpB : p ∈ closedBall (plantPt + 19 / 20 * plantDir) (1 / 20)
      · -- on the circle: a limit of points of the brick outside the closed disc
        have hs : p ∈ sphere (plantPt + 19 / 20 * plantDir) (1 / 20) := by
          rw [mem_sphere]
          exact le_antisymm (mem_closedBall.mp hpB) (not_lt.mp fun h => hpD (mem_ball.mpr h))
        rw [← frontier_closedBall _ (by norm_num : (1 / 20 : ℝ) ≠ 0), frontier_eq_closure_inter_closure] at hs
        rw [holedTile_eq, sdiff_eq]
        exact isOpen_tangentBrick.inter_closure ⟨hpb, hs.2⟩
      · exact subset_closure (by rw [holedTile_eq]; exact ⟨hpb, hpB⟩)
    have hcl : closure ((closure holedTile)ᶜ \ tangentDisc) ⊆ tangentBrickᶜ :=
      closure_minimal hX isOpen_tangentBrick.isClosed_compl
    rw [tangentDisc, closure_ball _ (by norm_num : (1 / 20 : ℝ) ≠ 0)]
    rw [disjoint_left]
    intro z hz hzX
    rw [tangentDisc] at hcl
    exact hcl hzX (closedBall_tangentCentre_subset_tangentBrick ((mem_closedBall.mp hz).trans (by norm_num)))

/-! ## Two horns on one ray -/

/-- The painted set of `twoHornModel`: two horns along `e 0` at the planted vertex and the tangent disc. -/
noncomputable def twoHornW : Set ℂ :=
  hornSet plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornSet plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪ tangentDisc

/-- The new arcs of `twoHornModel`. -/
noncomputable def twoHornB : Set Arc :=
  hornArcs plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornArcs plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪
    {Arc.circ (plantPt + 19 / 20 * plantDir) (1 / 20) 0 (2 * π)}

theorem twoHornB_nondegenerate : ∀ a ∈ twoHornB, a.Nondegenerate := by
  rintro a ((ha | ha) | ha)
  · exact hornArcs_nondegenerate plantPt 0 (by norm_num) (by norm_num) (by rw [abs_of_neg] <;> norm_num)
      (by rw [abs_of_neg] <;> norm_num) a ha
  · exact hornArcs_nondegenerate plantPt 0 (by norm_num) (by norm_num) (by rw [abs_of_pos] <;> norm_num)
      (by rw [abs_of_pos] <;> norm_num) a ha
  · rw [mem_singleton_iff] at ha
    rw [ha]
    exact tangentCircle_nondegenerate

theorem twoHornB_finite : twoHornB.Finite :=
  ((hornArcs_finite _ _ _ _ _).union (hornArcs_finite _ _ _ _ _)).union (finite_singleton _)

theorem frontier_twoHornW_subset : frontier twoHornW ⊆ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ twoHornB, a.carrier := by
  intro z hz
  rcases frontier_union_subset _ _ hz with ⟨h, -⟩ | ⟨-, h⟩
  · rcases frontier_union_subset _ _ h with ⟨h', -⟩ | ⟨-, h'⟩
    · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp (frontier_hornSet_subset plantPt 0 (by norm_num) (by norm_num)
        (by rw [abs_of_neg] <;> norm_num) (by rw [abs_of_neg] <;> norm_num) h')
      exact mem_iUnion₂.mpr ⟨a, Or.inr (Or.inl (Or.inl ha)), hza⟩
    · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp (frontier_hornSet_subset plantPt 0 (by norm_num) (by norm_num)
        (by rw [abs_of_pos] <;> norm_num) (by rw [abs_of_pos] <;> norm_num) h')
      exact mem_iUnion₂.mpr ⟨a, Or.inr (Or.inl (Or.inr ha)), hza⟩
  · rw [frontier_tangentDisc] at h
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inr rfl), h⟩

/-- **Two horns on one ray in a brick**: the brick map in eight colours, the colour `7` on two horns at `plantPt` along `e 0` (between the
curvatures `−3/4, −1/2` and `1/2, 3/4`) and on the tangent disc. -/
noncomputable def twoHornModel : ArcMap 8 :=
  (brickBase 8 (by norm_num)).paint twoHornW twoHornB twoHornB_nondegenerate twoHornB_finite frontier_twoHornW_subset (fun _ => 7)
    (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl)

/-- `twoHornModel` is a map of the plane. -/
theorem twoHornModel_isPlaneMap : twoHornModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 8 _)

/-- `twoHornModel` covers the closed unit disc about the planted vertex. -/
theorem twoHornModel_covers : twoHornModel.Covers plantPt 1 := ArcMap.covers_of_isPlaneMap twoHornModel_isPlaneMap _ _

/-- `twoHornModel`, unfolded. -/
theorem twoHornModel_eq_paint : twoHornModel = (brickBase 8 (by norm_num)).paint twoHornW twoHornB twoHornB_nondegenerate
    twoHornB_finite frontier_twoHornW_subset (fun _ => 7) (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl) := rfl

/-- The fan of `twoHornModel` at the planted vertex: the tangent arcs of curvatures `−3/4, −1/2, 1/2, 3/4`. -/
noncomputable def twoHornFan : Fin 4 → ℝ := ![-3 / 4, -1 / 2, 1 / 2, 3 / 4]

-- spec example for `twoHornFan`
example : twoHornFan 0 = -3 / 4 ∧ twoHornFan 1 = -1 / 2 ∧ twoHornFan 2 = 1 / 2 ∧ twoHornFan 3 = 3 / 4 := ⟨rfl, rfl, rfl, rfl⟩

/-- The fan's curvatures increase. -/
theorem twoHornFan_strictMono : StrictMono twoHornFan := by
  rw [Fin.strictMono_iff_lt_succ]
  intro i
  fin_cases i
  · show (-3 / 4 : ℝ) < -1 / 2
    norm_num
  · show (-1 / 2 : ℝ) < 1 / 2
    norm_num
  · show (1 / 2 : ℝ) < 3 / 4
    norm_num

/-- The fan's arcs out to `1/10` are graphs over the radius. -/
theorem twoHornFan_bound (i : Fin 4) : |twoHornFan i| * (1 / 10) ≤ 1 := by
  fin_cases i
  · show |(-3 / 4 : ℝ)| * (1 / 10) ≤ 1
    rw [abs_of_neg (by norm_num)]; norm_num
  · show |(-1 / 2 : ℝ)| * (1 / 10) ≤ 1
    rw [abs_of_neg (by norm_num)]; norm_num
  · show |(1 / 2 : ℝ)| * (1 / 10) ≤ 1
    rw [abs_of_pos (by norm_num)]; norm_num
  · show |(3 / 4 : ℝ)| * (1 / 10) ≤ 1
    rw [abs_of_pos (by norm_num)]; norm_num

/-- **Near the planted vertex the new arcs of `twoHornModel` are its fan.** -/
theorem twoHornB_inter_ball {r : ℝ} (hr : r ≤ 1 / 10) {z : ℂ} (hz : z ∈ ball plantPt r) :
    z ∈ ⋃ a ∈ twoHornB, a.carrier ↔ z ∈ ⋃ i, (germArc plantPt 0 (twoHornFan i) (1 / 10)).carrier := by
  have hd : dist z plantPt < 1 / 10 := lt_of_lt_of_le hz hr
  rw [twoHornB, biUnion_union, biUnion_union, mem_union, mem_union, biUnion_singleton, tangentCircle_carrier,
    mem_hornArcs_carrier_iff_of_mem_ball hd, mem_hornArcs_carrier_iff_of_mem_ball hd, mem_iUnion]
  constructor
  · rintro (((h | h) | (h | h)) | h)
    · exact ⟨0, h⟩
    · exact ⟨1, h⟩
    · exact ⟨2, h⟩
    · exact ⟨3, h⟩
    · have := tangentDisc_far (le_of_eq (mem_sphere.mp h))
      linarith
  · rintro ⟨i, hi⟩
    fin_cases i
    · exact Or.inl (Or.inl (Or.inl hi))
    · exact Or.inl (Or.inl (Or.inr hi))
    · exact Or.inl (Or.inr (Or.inl hi))
    · exact Or.inl (Or.inr (Or.inr hi))

/-- The interior points of `twoHornModel` near the planted vertex are the ball off the fan. -/
theorem twoHornModel_interiorPts_inter_ball {r : ℝ} (hr : r ≤ 1 / 10) :
    twoHornModel.interiorPts ∩ ball plantPt r =
      ball plantPt r \ ⋃ i, (germArc plantPt 0 (twoHornFan i) (1 / 10)).carrier :=
  ArcMap.interiorPts_paint_inter_ball
    ((ball_subset_closedBall.trans (closedBall_subset_closedBall hr)).trans (plantBall_subset_interiorPts _))
    (fun _ hz => twoHornB_inter_ball hr hz)

/-- **The sectors of `twoHornModel` at the planted vertex**, for every radius up to `1/10`: the rest, the lower horn, the gap and the
upper horn. -/
theorem twoHornModel_isSector_iff {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 10) {S : Set ℂ} :
    twoHornModel.IsSector plantPt r S ↔ S = fanRest plantPt 0 (-3 / 4) (3 / 4) r ∨
      S = hornSet plantPt 0 (-3 / 4) (-1 / 2) r ∨ S = hornSet plantPt 0 (-1 / 2) (1 / 2) r ∨
      S = hornSet plantPt 0 (1 / 2) (3 / 4) r := by
  rw [isSector_fan_iff twoHornFan twoHornFan_strictMono hr0 hr twoHornFan_bound (by show (-3 / 4 : ℝ) < 0; norm_num)
    (by show (0 : ℝ) < 3 / 4; norm_num) (twoHornModel_interiorPts_inter_ball hr)]
  constructor
  · rintro (h | ⟨i, h⟩)
    · exact Or.inl h
    · fin_cases i
      · exact Or.inr (Or.inl h)
      · exact Or.inr (Or.inr (Or.inl h))
      · exact Or.inr (Or.inr (Or.inr h))
  · rintro (h | h | h | h)
    · exact Or.inl h
    · exact Or.inr ⟨0, h⟩
    · exact Or.inr ⟨1, h⟩
    · exact Or.inr ⟨2, h⟩

/-- The painted set misses the new arcs. -/
theorem twoHornW_disjoint_twoHornB : Disjoint twoHornW (⋃ a ∈ twoHornB, a.carrier) := by
  have hA1 := hornArcs_carrier_subset plantPt 0 (κ₁ := -3 / 4) (κ₂ := -1 / 2) (by norm_num : (0 : ℝ) < 1 / 10)
    (by rw [abs_of_neg] <;> norm_num) (by rw [abs_of_neg] <;> norm_num)
  have hA2 := hornArcs_carrier_subset plantPt 0 (κ₁ := 1 / 2) (κ₂ := 3 / 4) (by norm_num : (0 : ℝ) < 1 / 10)
    (by rw [abs_of_pos] <;> norm_num) (by rw [abs_of_pos] <;> norm_num)
  rw [twoHornW, twoHornB, biUnion_union, biUnion_union, biUnion_singleton, tangentCircle_carrier]
  refine Disjoint.union_left (Disjoint.union_left ?_ ?_) ?_
  · refine Disjoint.union_right (Disjoint.union_right ?_ ?_) ?_
    · exact disjoint_hornSet_hornArcs le_rfl (by rw [abs_of_neg] <;> norm_num) (by rw [abs_of_neg] <;> norm_num)
        (Or.inl le_rfl) (Or.inr le_rfl)
    · exact disjoint_hornSet_hornArcs le_rfl (by rw [abs_of_pos] <;> norm_num) (by rw [abs_of_pos] <;> norm_num)
        (Or.inr (by norm_num)) (Or.inr (by norm_num))
    · exact disjoint_plantBall_tangent (hornSet_subset_plantBall le_rfl) sphere_subset_closedBall
  · refine Disjoint.union_right (Disjoint.union_right ?_ ?_) ?_
    · exact disjoint_hornSet_hornArcs le_rfl (by rw [abs_of_neg] <;> norm_num) (by rw [abs_of_neg] <;> norm_num)
        (Or.inl (by norm_num)) (Or.inl (by norm_num))
    · exact disjoint_hornSet_hornArcs le_rfl (by rw [abs_of_pos] <;> norm_num) (by rw [abs_of_pos] <;> norm_num)
        (Or.inl le_rfl) (Or.inr le_rfl)
    · exact disjoint_plantBall_tangent (hornSet_subset_plantBall le_rfl) sphere_subset_closedBall
  · refine Disjoint.union_right (Disjoint.union_right ?_ ?_) ?_
    · exact (disjoint_plantBall_tangent hA1 tangentDisc_subset_closedBall).symm
    · exact (disjoint_plantBall_tangent hA2 tangentDisc_subset_closedBall).symm
    · exact disjoint_tangentDisc_sphere

/-- The painted set consists of interior points of the base. -/
theorem twoHornW_subset_interiorPts : twoHornW ⊆ (brickBase 8 (by norm_num)).interiorPts := by
  rintro z ((hz | hz) | hz)
  · exact plantBall_subset_interiorPts _ (hornSet_subset_plantBall le_rfl hz)
  · exact plantBall_subset_interiorPts _ (hornSet_subset_plantBall le_rfl hz)
  · exact tangentDisc_subset_interiorPts _ hz

/-- **The class of `7` in `twoHornModel` is the painted set.** -/
theorem twoHornModel_region_seven : twoHornModel.region 7 = twoHornW := by
  rw [twoHornModel_eq_paint, ArcMap.region_paint_of_region_eq_empty (brickBase_region_spare _ (by decide))]
  ext z
  constructor
  · rintro ⟨⟨⟨-, hz⟩, -⟩, -⟩
    exact hz
  · intro hz
    exact ⟨⟨⟨twoHornW_subset_interiorPts hz, hz⟩, rfl⟩, disjoint_left.mp twoHornW_disjoint_twoHornB hz⟩

/-- The colour of a painted point. -/
theorem twoHornModel_col_of_mem {z : ℂ} (hz : z ∈ twoHornW) : twoHornModel.col z = 7 := ArcMap.paint_col_of_mem hz

/-- The colour of a point near the planted vertex off the painted set: the brick's colour `0`. -/
theorem twoHornModel_col_of_not_mem {z : ℂ} (hz : z ∉ twoHornW) (hd : dist z plantPt ≤ 1 / 10) : twoHornModel.col z = 0 := by
  rw [twoHornModel_eq_paint, ArcMap.paint_col_of_not_mem hz]
  exact Fin.ext (brickBase_col_zero _ (plantBall_subset_brick hd).1 (plantBall_subset_brick hd).2)

/-- `twoHornModel` is valid. -/
theorem twoHornModel_valid : twoHornModel.Valid := by
  refine ArcMap.paint_valid (brickBase_valid 8 _) (fun x hx y hy _ _ hxy => ?_) (fun x _ _ y hy => ?_)
  · have hzone : ∀ z ∈ twoHornW,
        (dist z plantPt < 1 / 10 ∧ dist z (plantPt + 19 / 20 * plantDir) ≤ 19 / 20) ∨ z ∈ tangentDisc := by
      rintro z ((hz | hz) | hz)
      · exact Or.inl ⟨hz.1, dist_tangentCentre_le_of_mem_hornSet (by norm_num) (by norm_num) hz⟩
      · exact Or.inl ⟨hz.1, dist_tangentCentre_le_of_mem_hornSet (by norm_num) (by norm_num) hz⟩
      · exact Or.inr hz
    exact absurd hxy (dist_lt_one_of_hornZone (hzone x hx) (hzone y hy)).ne
  · rw [brickBase_region_spare _ (by decide)] at hy
    exact absurd hy (notMem_empty y)

/-- The two horns are painted. -/
theorem twoHornModel_horns_subset_col {r : ℝ} (hr : r ≤ 1 / 10) :
    hornSet plantPt 0 (-3 / 4) (-1 / 2) r ⊆ twoHornModel.col ⁻¹' {7} ∧
      hornSet plantPt 0 (1 / 2) (3 / 4) r ⊆ twoHornModel.col ⁻¹' {7} :=
  ⟨fun _ hz => twoHornModel_col_of_mem (Or.inl (Or.inl (hornSet_mono_radius hr hz))),
    fun _ hz => twoHornModel_col_of_mem (Or.inl (Or.inr (hornSet_mono_radius hr hz)))⟩

/-- The rest and the gap between the horns are of the brick's colour `0`. -/
theorem twoHornModel_rest_gap_subset_col {r : ℝ} (hr : r ≤ 1 / 10) :
    fanRest plantPt 0 (-3 / 4) (3 / 4) r ⊆ twoHornModel.col ⁻¹' {0} ∧
      hornSet plantPt 0 (-1 / 2) (1 / 2) r ⊆ twoHornModel.col ⁻¹' {0} := by
  constructor
  · intro z hz
    refine twoHornModel_col_of_not_mem ?_ (hz.1.le.trans hr)
    rintro ((h | h) | h)
    · exact disjoint_left.mp (disjoint_fanRest_hornSet le_rfl (by norm_num)) hz h
    · exact disjoint_left.mp (disjoint_fanRest_hornSet (by norm_num) le_rfl) hz h
    · have := tangentDisc_far (le_of_lt (mem_ball.mp h))
      linarith [hz.1]
  · intro z hz
    refine twoHornModel_col_of_not_mem ?_ (hz.1.le.trans hr)
    rintro ((h | h) | h)
    · exact disjoint_left.mp (disjoint_hornSet_hornSet le_rfl) h hz
    · exact disjoint_left.mp (disjoint_hornSet_hornSet le_rfl) hz h
    · have := tangentDisc_far (le_of_lt (mem_ball.mp h))
      linarith [hz.1]

/-- The two horns of colour `7` along `e 0`. -/
theorem twoHornModel_isHorn : twoHornModel.IsHorn plantPt 0 (-3 / 4) (-1 / 2) 7 ∧ twoHornModel.IsHorn plantPt 0 (1 / 2) (3 / 4) 7 := by
  constructor
  · refine ⟨by norm_num, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
    exact ⟨(twoHornModel_isSector_iff hr.1 hr.2).mpr (Or.inr (Or.inl rfl)), (twoHornModel_horns_subset_col hr.2).1⟩
  · refine ⟨by norm_num, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
    exact ⟨(twoHornModel_isSector_iff hr.1 hr.2).mpr (Or.inr (Or.inr (Or.inr rfl))), (twoHornModel_horns_subset_col hr.2).2⟩

/-- The colour `7` has two sectors at the planted vertex (and the brick's colour `0` two: the gap between the horns and the rest). -/
theorem twoHornModel_hasSectors : twoHornModel.HasSectors plantPt 7 2 ∧ twoHornModel.HasSectors plantPt 0 2 := by
  constructor
  · filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
    have hiff := @twoHornModel_isSector_iff r hr.1 hr.2
    obtain ⟨h7a, h7b⟩ := twoHornModel_horns_subset_col hr.2
    obtain ⟨h0a, h0b⟩ := twoHornModel_rest_gap_subset_col hr.2
    have h : twoHornModel.sectorsOf plantPt r 7 =
        {hornSet plantPt 0 (-3 / 4) (-1 / 2) r, hornSet plantPt 0 (1 / 2) (3 / 4) r} := by
      ext S
      simp only [ArcMap.sectorsOf, mem_setOf_eq, mem_insert_iff, mem_singleton_iff]
      constructor
      · rintro ⟨hS, hc⟩
        rcases hiff.mp hS with rfl | rfl | rfl | rfl
        · exact (hS.false_of_col hc h0a (by decide)).elim
        · exact Or.inl rfl
        · exact (hS.false_of_col hc h0b (by decide)).elim
        · exact Or.inr rfl
      · rintro (rfl | rfl)
        · exact ⟨hiff.mpr (Or.inr (Or.inl rfl)), h7a⟩
        · exact ⟨hiff.mpr (Or.inr (Or.inr (Or.inr rfl))), h7b⟩
    have hne : hornSet plantPt 0 (-3 / 4) (-1 / 2) r ≠ hornSet plantPt 0 (1 / 2) (3 / 4) r :=
      (disjoint_hornSet_hornSet (by norm_num)).ne (hiff.mpr (Or.inr (Or.inl rfl))).nonempty.ne_empty
    rw [h, encard_pair hne]
    rfl
  · filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
    have hiff := @twoHornModel_isSector_iff r hr.1 hr.2
    obtain ⟨h7a, h7b⟩ := twoHornModel_horns_subset_col hr.2
    obtain ⟨h0a, h0b⟩ := twoHornModel_rest_gap_subset_col hr.2
    have h : twoHornModel.sectorsOf plantPt r 0 =
        {fanRest plantPt 0 (-3 / 4) (3 / 4) r, hornSet plantPt 0 (-1 / 2) (1 / 2) r} := by
      ext S
      simp only [ArcMap.sectorsOf, mem_setOf_eq, mem_insert_iff, mem_singleton_iff]
      constructor
      · rintro ⟨hS, hc⟩
        rcases hiff.mp hS with rfl | rfl | rfl | rfl
        · exact Or.inl rfl
        · exact (hS.false_of_col hc h7a (by decide)).elim
        · exact Or.inr rfl
        · exact (hS.false_of_col hc h7b (by decide)).elim
      · rintro (rfl | rfl)
        · exact ⟨hiff.mpr (Or.inl rfl), h0a⟩
        · exact ⟨hiff.mpr (Or.inr (Or.inr (Or.inl rfl))), h0b⟩
    rw [h, encard_pair (fanRest_ne_hornSet plantPt 0 hr.1 0 (-1 / 2) (1 / 2))]
    rfl

/-- The planted vertex of `twoHornModel` has degree `4`: the rest, the two horns and the gap between them. -/
theorem twoHornModel_hasDegree : twoHornModel.HasDegree plantPt 4 := by
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
  exact encard_sectors_fan twoHornFan twoHornFan_strictMono hr.1 hr.2 twoHornFan_bound (by show (-3 / 4 : ℝ) < 0; norm_num)
    (by show (0 : ℝ) < 3 / 4; norm_num) (twoHornModel_interiorPts_inter_ball hr.2)

/-- The planted vertex of `twoHornModel` has three horns: the two painted ones and the gap between them, which is a horn set of the
brick's colour. -/
theorem twoHornModel_hasHornCount : twoHornModel.HasHornCount plantPt 3 := by
  filter_upwards [Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num)] with r hr
  exact encard_horns_fan twoHornFan twoHornFan_strictMono hr.1 hr.2 twoHornFan_bound (by show (-3 / 4 : ℝ) < 0; norm_num)
    (by show (0 : ℝ) < 3 / 4; norm_num) (twoHornModel_interiorPts_inter_ball hr.2)

/-- The painted set lies in the small disc about the planted vertex and the tangent disc. -/
theorem twoHornW_subset : twoHornW ⊆ closedBall plantPt (1 / 10) ∪ tangentDisc := by
  rintro z ((hz | hz) | hz)
  · exact Or.inl (hornSet_subset_plantBall le_rfl hz)
  · exact Or.inl (hornSet_subset_plantBall le_rfl hz)
  · exact Or.inr hz

/-- **The class of `7` against `ω(plantPt)`** in `twoHornModel`: the hypotheses of `ArcMap.allowedCone_tangent`. -/
theorem twoHornModel_tangent : 7 ∈ twoHornModel.coloursAt plantPt ∧ twoHornModel.region 7 ⊆ ball plantPt 1 ∧
    tangentDisc ⊆ twoHornModel.region 7 ∧ closure (twoHornModel.region 7) ∩ sphere plantPt 1 ⊆ {plantPt + plantDir} := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · show plantPt ∈ closure (twoHornModel.region 7)
    rw [twoHornModel_region_seven]
    exact closure_mono (subset_union_left.trans subset_union_left) (mem_closure_of_mem_coneAt
      (mem_coneAt_hornSet plantPt 0 (by norm_num : (-3 / 4 : ℝ) < -1 / 2) (by norm_num : (0 : ℝ) < 1 / 10)))
  · rw [twoHornModel_region_seven]
    rintro z ((hz | hz) | hz)
    · exact mem_ball.mpr (hz.1.trans (by norm_num))
    · exact mem_ball.mpr (hz.1.trans (by norm_num))
    · exact tangentDisc_subset_ball.1 hz
  · rw [twoHornModel_region_seven]
    exact subset_union_right
  · rw [twoHornModel_region_seven]
    exact closure_inter_sphere_subset twoHornW_subset

/-- **The allowed cone of `7` at the planted vertex of `twoHornModel` is the closed half-plane `d · plantDir ≥ 0`.** -/
theorem twoHornModel_allowedCone : twoHornModel.allowedCone plantPt 7 = {d | 0 ≤ dot d plantDir} :=
  (ArcMap.allowedCone_tangent twoHornModel_tangent.1 twoHornModel_tangent.2.1 twoHornModel_tangent.2.2.1
    twoHornModel_tangent.2.2.2).2.2.2

/-- The allowed cone of `7` at the planted vertex has interior points, and is not the whole plane (the tangent point is an in-type
contact). -/
theorem twoHornModel_cone : (interior (twoHornModel.allowedCone plantPt 7)).Nonempty ∧
    twoHornModel.IsContact plantPt 7 (plantPt + plantDir) ∧ -plantDir ∉ twoHornModel.allowedCone plantPt 7 := by
  have h := ArcMap.tangent_contact_cone twoHornModel_tangent.1 twoHornModel_tangent.2.1 twoHornModel_tangent.2.2.1
    twoHornModel_tangent.2.2.2
  exact ⟨h.2.2.2, h.1, h.2.2.1⟩

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
