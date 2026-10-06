import Proofs.HadwigerNelson.Plane.Models.Moves
import Proofs.HadwigerNelson.Plane.Models.Stuck
import Proofs.HadwigerNelson.Plane.Models.Bends
import Proofs.HadwigerNelson.Plane.ValidMap.Procedure
import Proofs.HadwigerNelson.Plane.ValidMap.MapGraph
import Proofs.HadwigerNelson.Plane.ValidMap.Terminal
import Proofs.HadwigerNelson.Plane.ValidMap.BaseDense

/-!
# The example maps read against the theorems they serve (FS131-MC1)

`Plane/Models/{Moves, Stuck, Bends}` build the maps; this module applies the landed theorems to them, so that "the model meets every
hypothesis of the theorem" is a term the kernel checked and not a table. Each `example` below is one landed theorem applied to one model,
every hypothesis supplied by a named fact; the named theorems are the applications whose conclusions are worth citing.

* `hornModel`: a site (`hornModel_isSite`); a valid map of the plane with a holed tile, to which FS114-CVB-PINCH's hole clause applies
  (`hornModel_hole_disconnected`); the `_aux` forms of SHAVE, MERGE-RAY and MERGE.
* `stuckModel` at `plantPt`: nine of `Plane/ValidMap/FlankUA`'s ten stuck heads and ten of `Plane/ValidMap/Terminal`'s. **Not served**:
  `hasSectors_one_of_contacts` (its hypothesis lists every contact of a colour; only four contacts are stated for this map), and every
  theorem that assumes `F.Terminal` or `F.IsTerminalMap` — `stuckModel.Terminal` and `stuckModel.QROnly` are not proved in Lean
  (FS131-E7 § 7.4 derives both at [hand]; `plans/FS131-MC1-landing.md` has the route).
* `awayModel`: wave 5's outward bend (`awayModel_bend_away_part`), its subdivision and its gap lemmas; on the sub-arc `[1/5, 3/10]`, which
  lies in a gap of the radius-2 contacts (`awayModel_gap`), the whole-arc away bend (`awayModel_bend_away_whole`, ruling 471 (c)).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## `hornModel` and `twoHornModel` -/

/-- The planted vertex of `hornModel` is a site: it carries a horn. -/
theorem hornModel_isSite : hornModel.IsSite plantPt :=
  ⟨by rw [hornModel_isPlaneMap]; exact mem_univ _, Or.inr ⟨_, _, _, _, hornModel_isHorn⟩⟩

/-- The planted vertex of `twoHornModel` is a site: it carries a horn (and a repeated colour, `twoHornModel_hasSectors`). -/
theorem twoHornModel_isSite : twoHornModel.IsSite plantPt :=
  ⟨by rw [twoHornModel_isPlaneMap]; exact mem_univ _, Or.inr ⟨_, _, _, _, twoHornModel_isHorn.1⟩⟩

/-- **A valid map of the plane with a holed tile, and FS114-CVB-PINCH's hole clause on it**: in `hornModel` the brick around the tangent
disc is a tile (`holedTile`) whose hole is the disc (`hornModel_holedTile`), so removing that tile disconnects the map graph —
`ArcMap.cvb_hole_disconnected` applied. -/
theorem hornModel_hole_disconnected :
    ¬ (hornModel.mapGraph.induce {T' | T' ≠ ⟨holedTile, hornModel_holedTile.1⟩}).Connected :=
  ArcMap.cvb_hole_disconnected hornModel_valid hornModel_isPlaneMap hornModel_holedTile.1
    ⟨hornModel_holedTile.2.1, hornModel_holedTile.2.2.1, hornModel_holedTile.2.2.2.1, hornModel_holedTile.2.2.2.2⟩

-- `exists_vertexStep` (`Plane/ValidMap/Procedure`) on `hornModel`: every hypothesis but `IsClean`, which is not proved for it
example (hc : hornModel.IsClean) := ArcMap.exists_vertexStep hornModel_valid hc hornModel_covers
  (Or.inr (Or.inr hornModel_shaveAvailable)) hornModel_hasDegree hornModel_hasHornCount one_pos

-- `exists_shave_aux` (`Plane/ValidMap/Moves`) on `hornModel`: the hypotheses of `hornModel_shave`
example := ArcMap.exists_shave_aux hornModel_valid hornModel_covers (n := 0) (σ := 0)
  hornModel_hasSectors hornModel_isHorn (by norm_num) (by norm_num) hornModel_flanks.1 hornModel_flanks.2 (by norm_num)
  (by norm_num) (hornModel_clear.mono fun _ hr z hz => ⟨fun _ => hr z hz, fun _ => hr z hz⟩)

-- `exists_rayMerge_aux` on `twoHornModel`: the hypotheses of `twoHornModel_rayMerge`
example := ArcMap.exists_rayMerge_aux twoHornModel_valid twoHornModel_covers (n := 1)
  twoHornModel_hasSectors.1 (by norm_num : (-1 / 2 : ℝ) < 1 / 2) twoHornModel_isHorn.1 twoHornModel_isHorn.2 (by norm_num)
  (by norm_num)

-- `exists_merge_aux` on `twoHornModel`: the hypotheses of `twoHornModel_merge`
example := ArcMap.exists_merge_aux twoHornModel_valid twoHornModel_covers (n := 1) le_rfl
  twoHornModel_hasSectors.1 twoHornModel_cone.1

/-! ## `stuckModel` at its vertex: the stuck family's hypotheses -/

/-- The vertex of `stuckModel` carries exactly three colours. -/
theorem stuckModel_ncard : (stuckModel.coloursAt plantPt).ncard = 3 := by
  rw [stuckModel_coloursAt, Set.ncard_insert_of_notMem (by simp), Set.ncard_pair (by decide)]

/-- The vertex of `stuckModel` is a chain vertex: stuck, with three colours. -/
theorem stuckModel_isChainVertex : stuckModel.IsChainVertex plantPt := ⟨stuckModel_isStuck, stuckModel_ncard.le⟩

/-- The left horn of `stuckModel`, in the form the stuck family reads it (along `e (0 + π)`). -/
theorem stuckModel_isHorn_pi : stuckModel.IsHorn plantPt (0 + π) (-1) 1 9 := by
  rw [zero_add]; exact stuckModel_isHorn.2

/-- The vertex of `stuckModel` is no interior point: it carries a repeated colour. -/
theorem stuckModel_not_mem_interiorPts : plantPt ∉ stuckModel.interiorPts := fun h =>
  ArcMap.not_hasRepeatedColour_of_mem_interiorPts h ⟨9, stuckModel_hasSectors.1.mono fun r hr => by rw [hr]; norm_num⟩

/-- The allowed cone of the horns' colour at the vertex of `stuckModel` has empty interior (MERGE is not available and `9` has two
sectors). -/
theorem stuckModel_interior_allowedCone : interior (stuckModel.allowedCone plantPt 9) = ∅ :=
  Set.not_nonempty_iff_eq_empty.mp fun h => stuckModel_isStuck.1 ⟨9, 2, le_rfl, stuckModel_hasSectors.1, h⟩

/-- `stuckModel_contacts` with the poles written in the frame along `e 0`, as the stuck family's statements write them. -/
theorem stuckModel_contacts_frame :
    (stuckModel.IsContact plantPt 7 (plantPt + e (0 + π / 2)) ∧ stuckModel.InType plantPt 7 (plantPt + e (0 + π / 2))) ∧
    (stuckModel.IsContact plantPt 8 (plantPt - e (0 + π / 2)) ∧ stuckModel.InType plantPt 8 (plantPt - e (0 + π / 2))) ∧
    (stuckModel.IsContact plantPt 9 (plantPt + e (0 + π / 2)) ∧ stuckModel.OutType plantPt 9 (plantPt + e (0 + π / 2))) ∧
    (stuckModel.IsContact plantPt 9 (plantPt - e (0 + π / 2)) ∧ stuckModel.OutType plantPt 9 (plantPt - e (0 + π / 2))) := by
  rw [stuckModel_poles.1, stuckModel_poles.2.2.1]
  exact stuckModel_contacts

/-- **Both shadows are live on the right horn of `stuckModel`**: at every radius the horn holds a point in the shadow of the class of `7`
and in that of `8` (`stuckModel_shadow`: every horn point within `1/20` of the vertex is). -/
theorem stuckModel_horn_shadows : ∀ ρ > 0, ∃ z ∈ hornSet plantPt 0 (-1) 1 ρ,
    z ∈ shadow (stuckModel.region 7) ∧ z ∈ shadow (stuckModel.region 8) := by
  intro ρ hρ
  obtain ⟨z, hz, -, hd, -⟩ :=
    mem_coneAt_hornSet plantPt 0 (κ₁ := -1) (κ₂ := 1) (r := ρ) (by norm_num) hρ (1 / 20) (by norm_num)
  have hN : 1 < dist z plantN := by
    have := (tanBelow_one_iff plantPt 0 z).mp hz.2.2.2
    rwa [stuckModel_poles.1] at this
  have hS : 1 < dist z plantS := by
    have := (tanAbove_neg_one_iff plantPt 0 z).mp hz.2.2.1
    rwa [stuckModel_poles.2.2.1] at this
  obtain ⟨h7, h8⟩ := stuckModel_shadow hd
  exact ⟨z, hz, h7 hN, h8 hS⟩

-- `Plane/ValidMap/FlankUA`, nine heads
example := ArcMap.not_outType_N_of_flankAbove_one stuckModel_valid stuckModel_covers stuckModel_flanks.1.1
  stuckModel_contacts_frame.1.1.2.2
example := ArcMap.not_outType_S_of_flankBelow_neg_one stuckModel_valid stuckModel_covers stuckModel_flanks.1.2
  stuckModel_contacts_frame.2.1.1.2.2
example := ArcMap.srcG_of_shadow stuckModel_valid stuckModel_covers (κ₁ := -1) le_rfl (by norm_num) le_rfl stuckModel_flanks.1.1
  (fun ρ hρ => (stuckModel_horn_shadows ρ hρ).imp fun _ h => ⟨h.1, h.2.1⟩)
example := ArcMap.srcH_of_shadow stuckModel_valid stuckModel_covers (κ₂ := 1) le_rfl (by norm_num) le_rfl stuckModel_flanks.1.2
  (fun ρ hρ => (stuckModel_horn_shadows ρ hρ).imp fun _ h => ⟨h.1, h.2.2⟩)
example := ArcMap.region_near_of_inType stuckModel_valid stuckModel_covers stuckModel_contacts.1.1 stuckModel_contacts.1.2
example := ArcMap.flank_ne_of_shadows stuckModel_valid stuckModel_covers le_rfl (by norm_num) le_rfl stuckModel_flanks.1.1
  stuckModel_flanks.1.2 (fun ρ hρ => (stuckModel_horn_shadows ρ hρ).imp fun _ h => ⟨h.1, h.2.1⟩)
  (fun ρ hρ => (stuckModel_horn_shadows ρ hρ).imp fun _ h => ⟨h.1, h.2.2⟩)
example := ArcMap.horn_poles_contact stuckModel_valid stuckModel_covers stuckModel_isStuck.1 le_rfl stuckModel_hasSectors.1
  stuckModel_isHorn.1
example := ArcMap.horn_bounds_of_noMerge stuckModel_valid stuckModel_covers stuckModel_isStuck.1 le_rfl stuckModel_hasSectors.1
  stuckModel_isHorn.1
example := ArcMap.horn_bounds_of_interior_empty stuckModel_valid stuckModel_covers stuckModel_isHorn.1
  stuckModel_interior_allowedCone

-- `Plane/ValidMap/Terminal`, ten heads (none assuming `Terminal` or `IsTerminalMap`)
example := ArcMap.stuck_flanks_ua stuckModel_valid stuckModel_covers stuckModel_isStuck stuckModel_ncard.le stuckModel_isHorn.1
  stuckModel_isHorn_pi le_rfl le_rfl le_rfl le_rfl stuckModel_hasSectors.1 stuckModel_contacts_frame.2.2.1
  stuckModel_contacts_frame.2.2.2
example := ArcMap.stuck_structure_ua stuckModel_valid stuckModel_covers stuckModel_isStuck stuckModel_ncard.le le_rfl
  stuckModel_hasSectors.1
example := ArcMap.chainVertex_antipodal stuckModel_valid stuckModel_covers stuckModel_isStuck stuckModel_ncard.le
example := ArcMap.exists_horn_of_mem_coneAt_of_stuck stuckModel_valid stuckModel_covers stuckModel_isStuck
  stuckModel_not_mem_interiorPts le_rfl stuckModel_hasSectors.1 stuckModel_isHorn.1.mem_coneAt_region
example := ArcMap.upper_bounds_of_inType_N stuckModel_valid stuckModel_isPlaneMap stuckModel_isStuck stuckModel_ncard.le
  stuckModel_hasSectors.1 stuckModel_isHorn.1 stuckModel_isHorn_pi stuckModel_flanks.1.1 stuckModel_contacts_frame.1
example := ArcMap.stuck_turned_frame stuckModel_valid stuckModel_isPlaneMap stuckModel_isStuck stuckModel_ncard.le
  stuckModel_hasSectors.1 stuckModel_isHorn.1 stuckModel_isHorn_pi stuckModel_flanks.1.1 stuckModel_flanks.1.2
example := ArcMap.stuck_structure_at_axis stuckModel_valid stuckModel_covers stuckModel_isStuck stuckModel_ncard.le le_rfl
  stuckModel_hasSectors.1 stuckModel_isHorn.1
example := ArcMap.horn_flanks_of_isChainVertex stuckModel_valid stuckModel_covers stuckModel_isChainVertex stuckModel_isHorn.1
example := ArcMap.horn_colour_eq_of_isChainVertex stuckModel_valid stuckModel_covers stuckModel_isChainVertex
  stuckModel_isHorn.1 stuckModel_isHorn.2
example := ArcMap.eq_horn_colour_of_two_sectors stuckModel_valid stuckModel_covers stuckModel_isChainVertex stuckModel_isHorn.1
  (j := 9) (stuckModel_hasSectors.1.mono fun r hr => by rw [hr]; norm_num)

-- the three heads that assume a terminal map: every hypothesis but that one is met (`stuckModel.Terminal`, `stuckModel.QROnly` are open)
example (hT : stuckModel.Terminal) := ArcMap.n3_end_chain stuckModel_valid stuckModel_isPlaneMap hT stuckModel_isStuck
  stuckModel_ncard stuckModel_hasSectors.1 stuckModel_isHorn.1 stuckModel_flanks.1.1 stuckModel_contacts_frame.1
example (hM : stuckModel.IsTerminalMap) := ArcMap.cv_l0 hM stuckModel_isStuck stuckModel_ncard.le
example (hM : stuckModel.IsTerminalMap) (β : ℝ) := ArcMap.hornBoundsQR_of_isChainVertex hM stuckModel_isChainVertex β

/-! ## `awayModel`: the outward bend -/

/-- `awayModel`'s radius-2 arc lies in its domain: it is a map of the plane. -/
theorem awayModel_radiusTwoArc_subset (θ₁ θ₂ : ℝ) : ArcMap.radiusTwoArc awayP θ₁ θ₂ ⊆ awayModel.dom := fun z _ => by
  rw [awayModel_isPlaneMap]; exact mem_univ z

/-- **A gap of `awayModel`'s radius-2 contacts**: the angles `[1/5, 3/10]` lie inside the arc's `[−arcsin (3/10), arcsin (3/10)]` and
above the contacts' `[−arcsin (3/20), arcsin (3/20)]` (`awayModel_r2Contacts`; `sin (1/5) > 3/20`), so no point of the radius-2 arc over
them is in the closure of the class of `7`. -/
theorem awayModel_gap : (-(Real.arcsin (3 / 10)) ≤ 1 / 5 ∧ (3 / 10 : ℝ) ≤ Real.arcsin (3 / 10)) ∧
    ∀ θ ∈ Icc (1 / 5 : ℝ) (3 / 10), awayP + 2 * e θ ∉ closure (awayModel.region 7) := by
  have hπ := Real.pi_gt_three
  have h310 : (3 / 10 : ℝ) ≤ Real.arcsin (3 / 10) :=
    (Real.le_arcsin_iff_sin_le ⟨by linarith, by linarith⟩ ⟨by norm_num, by norm_num⟩).mpr (Real.sin_le (by norm_num))
  have h15 : Real.arcsin (3 / 20) < 1 / 5 := by
    rw [Real.arcsin_lt_iff_lt_sin ⟨by norm_num, by norm_num⟩ ⟨by linarith, by linarith⟩]
    have := Real.sin_gt_sub_cube (x := 1 / 5) (by norm_num)
    norm_num at this
    linarith
  refine ⟨⟨by linarith, h310⟩, fun θ hθ hcl => ?_⟩
  have hmem : θ ∈ awayModel.r2Contacts awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)) 7 :=
    ⟨⟨by linarith [hθ.1], hθ.2.trans h310⟩, hcl⟩
  rw [awayModel_r2Contacts] at hmem
  linarith [hmem.2, hθ.1]

/-- The sub-arc of `awayModel`'s ring arc over the gap `[1/5, 3/10]` is a ring arc with the same sides (`IsRingArc.mono`). -/
theorem awayModel_isRingArc_gap : awayModel.IsRingArc awayP (1 / 5) (3 / 10) 7 0 :=
  awayModel_hyps.2.2.1.mono awayModel_gap.1.1 (by norm_num) awayModel_gap.1.2

/-- **The model of `bend_away_part` (FS112-N2-AWAY with N2-TAN) on a map of the plane**: wave 5's outward bend applied to `awayModel`'s arc
of `ω(awayP)`, whose radius-2 contacts are an interval strictly inside the arc's angles (`awayModel_r2Contacts`) — its five hypotheses are
`awayModel_hyps`, in order. -/
theorem awayModel_bend_away_part : ∃ (M : ArcMap 8) (K : Set ℂ), M.Valid ∧ IsCompact K ∧
    K ⊆ thickening 1 (ringArc awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10))) ∧ ArcMap.LocalStep awayModel M K := by
  obtain ⟨M, -, K, h1, h2, h3, -, h5, -⟩ := ArcMap.bend_away_part awayModel_hyps.1 awayModel_hyps.2.1 awayModel_hyps.2.2.1
    awayModel_hyps.2.2.2.1 awayModel_hyps.2.2.2.2 one_pos
  exact ⟨M, K, h1, h2, h3, h5⟩

/-- **A model of `bend_away_whole` (FS112-N2-BENDS, N2-AWAY) on a map of the plane** (ruling 471 (c)): the whole-arc away bend applied
to `awayModel`'s sub-arc over the gap `[1/5, 3/10]`. The inner colour `7` is not carried at the centre, which carries `6`
(`awayModel_coloursAt`), and no point of the radius-2 arc over the gap is in the closure of the class of `7` (`awayModel_gap`) — where
`cuspFrag_bend_away`'s centre is off its fragment and its radius-2 arc is off the map. -/
theorem awayModel_bend_away_whole : ∃ F' : ArcMap 8, F'.Valid ∧
    ∀ θ ∈ Ioo (1 / 5 : ℝ) (3 / 10), ¬ F'.OnRingArc awayP (ringPt awayP θ) := by
  obtain ⟨F', h1, -, -, h2, -⟩ := ArcMap.bend_away_whole awayModel_hyps.1 awayModel_isRingArc_gap awayModel_hyps.2.2.2.1
    (Set.disjoint_left.mpr fun z hz hcl => by
      obtain ⟨θ, hθ, rfl⟩ := hz
      exact awayModel_gap.2 θ hθ hcl) one_pos
  exact ⟨F', h1, h2⟩

-- the subdivision of the whole arc by its contacts (`Plane/ValidMap/R2Cap`), and the bend over it (`Plane/ValidMap/BendStep`)
example := ArcMap.exists_r2Subdiv awayModel_hyps.1 awayModel_hyps.2.2.1 (awayModel_radiusTwoArc_subset _ _)
example := ArcMap.bend_away_subdiv
  (ArcMap.exists_r2Subdiv awayModel_hyps.1 awayModel_hyps.2.2.1 (awayModel_radiusTwoArc_subset _ _)) awayModel awayModel_hyps.1
  awayModel_hyps.2.1 awayModel_hyps.2.2.1 awayModel_hyps.2.2.2.1 awayModel_hyps.2.2.2.2 (fun _ => Iff.rfl) (1 / 2) (by norm_num) le_rfl
example := ArcMap.r2_side_dichotomy awayModel_hyps.1 awayModel_hyps.2.2.1 (σ := 1) (θ₀ := 0) (δ₀ := 1 / 5) (Or.inl rfl)
  ⟨by linarith [awayModel_gap.1.2], by linarith [awayModel_gap.1.2]⟩ (by norm_num)
  ⟨by norm_num; linarith [awayModel_gap.1.2], by norm_num; linarith [awayModel_gap.1.2]⟩
  (awayModel_radiusTwoArc_subset 0 0 ⟨0, ⟨le_rfl, le_rfl⟩, rfl⟩)

-- the gap `[1/5, 3/10]`: the away bend of one gap and its clear lens (`Plane/ValidMap/BendGap`)
example := ArcMap.bend_away_gap awayModel_hyps.1 awayModel_isRingArc_gap awayModel_hyps.2.2.2.1
  (awayModel_radiusTwoArc_subset _ _)
  (fun θ hθ => awayModel_hyps.2.2.2.2 θ ⟨by linarith [hθ.1, awayModel_gap.1.1], by linarith [hθ.2, awayModel_gap.1.2]⟩)
  (fun θ hθ => awayModel_gap.2 θ ⟨hθ.1.le, hθ.2.le⟩) one_pos
example := ArcMap.exists_lensOut_clear awayModel_hyps.1 awayModel_isRingArc_gap awayModel_hyps.2.2.2.1
  (awayModel_radiusTwoArc_subset _ _) (fun θ hθ => awayModel_gap.2 θ ⟨hθ.1.le, hθ.2.le⟩)

end HadwigerNelson.Plane
