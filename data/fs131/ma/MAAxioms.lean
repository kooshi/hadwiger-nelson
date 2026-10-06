import Proofs.HadwigerNelson.Plane.Models.Moves
import Proofs.HadwigerNelson.Plane.Models.Stuck
import Proofs.HadwigerNelson.Plane.Models.Bends

/-! FS131-MA1: the axioms print of this job's records, read by `tools/fs131_ma_axioms.py`.
Above the line `-- CONTROL`: every theorem of `Plane/Models/Paint` and `Plane/Models/Moves`; each must rest on a subset of the
standard three axioms. Below it: the controls, each of which must be reported with `sorryAx`. -/

-- Plane/Models/Paint: the general layer (FS131-KM1), its 13 leaves and the helpers (FS131-MA1)
#print axioms HadwigerNelson.Plane.ArcMap.relabel_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.relabel_Γ
#print axioms HadwigerNelson.Plane.ArcMap.relabel_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.relabel_region
#print axioms HadwigerNelson.Plane.ArcMap.relabel_region_eq_empty
#print axioms HadwigerNelson.Plane.ArcMap.relabel_valid
#print axioms HadwigerNelson.Plane.ArcMap.relabel_condition5
#print axioms HadwigerNelson.Plane.ArcMap.paint_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.paint_col_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.paint_col_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_paint
#print axioms HadwigerNelson.Plane.ArcMap.region_paint
#print axioms HadwigerNelson.Plane.ArcMap.paint_valid
#print axioms HadwigerNelson.Plane.ArcMap.paint_condition5
#print axioms HadwigerNelson.Plane.ArcMap.region_paint_of_region_eq_empty
#print axioms HadwigerNelson.Plane.ArcMap.region_paint_subset
#print axioms HadwigerNelson.Plane.ArcMap.isClear_paint_of_mem_region
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_paint_inter_ball
#print axioms HadwigerNelson.Plane.brickBase_valid
#print axioms HadwigerNelson.Plane.brickBase_isPlaneMap
#print axioms HadwigerNelson.Plane.brickBase_condition5
#print axioms HadwigerNelson.Plane.brickBase_region_spare
#print axioms HadwigerNelson.Plane.brick_floor_eq
#print axioms HadwigerNelson.Plane.not_int_between
#print axioms HadwigerNelson.Plane.brickBase_mem_interiorPts
#print axioms HadwigerNelson.Plane.brickBase_col_eq
#print axioms HadwigerNelson.Plane.brickBase_col_zero
#print axioms HadwigerNelson.Plane.plantPt_re
#print axioms HadwigerNelson.Plane.plantPt_im
#print axioms HadwigerNelson.Plane.plantDir_re
#print axioms HadwigerNelson.Plane.plantDir_im
#print axioms HadwigerNelson.Plane.tangentCentre_re
#print axioms HadwigerNelson.Plane.tangentCentre_im
#print axioms HadwigerNelson.Plane.norm_plantDir
#print axioms HadwigerNelson.Plane.dist_tangentCentre
#print axioms HadwigerNelson.Plane.tangentDisc_subset_ball
#print axioms HadwigerNelson.Plane.hornArcs_nondegenerate
#print axioms HadwigerNelson.Plane.hornArcs_finite
#print axioms HadwigerNelson.Plane.closure_hornSet_subset
#print axioms HadwigerNelson.Plane.tanHeight_zero_left
#print axioms HadwigerNelson.Plane.half_le_one_sub
#print axioms HadwigerNelson.Plane.abs_frameY_le
#print axioms HadwigerNelson.Plane.eq_of_frame_eq_zero
#print axioms HadwigerNelson.Plane.self_mem_carrier_germArc
#print axioms HadwigerNelson.Plane.mem_carrier_germArc_of_tanHeight_eq_zero
#print axioms HadwigerNelson.Plane.frontier_hornSet_subset
#print axioms HadwigerNelson.Plane.hornArcs_carrier_subset
#print axioms HadwigerNelson.Plane.isOpen_fanRest
#print axioms HadwigerNelson.Plane.frameX_combo
#print axioms HadwigerNelson.Plane.convex_frameX_neg
#print axioms HadwigerNelson.Plane.dist_fromFrame_lt
#print axioms HadwigerNelson.Plane.isPreconnected_fanRest
#print axioms HadwigerNelson.Plane.exists_sign_change
#print axioms HadwigerNelson.Plane.frame_of_mem_carrier_germArc
#print axioms HadwigerNelson.Plane.fan_tanHeight_of_mem_hornSet
#print axioms HadwigerNelson.Plane.ball_diff_fan
#print axioms HadwigerNelson.Plane.iUnion_fanPiece
#print axioms HadwigerNelson.Plane.Ioo_subset_coneAt_fanRest
#print axioms HadwigerNelson.Plane.interior_coneAt_fanRest_nonempty
#print axioms HadwigerNelson.Plane.fanPiece_data
#print axioms HadwigerNelson.Plane.isSector_fan_iff
#print axioms HadwigerNelson.Plane.fanRest_ne_hornSet
#print axioms HadwigerNelson.Plane.frameX_zero
#print axioms HadwigerNelson.Plane.frameY_zero
#print axioms HadwigerNelson.Plane.abs_re_sub_le_dist
#print axioms HadwigerNelson.Plane.abs_im_sub_le_dist
#print axioms HadwigerNelson.Plane.mem_hornArcs_carrier_iff_of_mem_ball
#print axioms HadwigerNelson.Plane.disjoint_hornSet_carrier_germArc
#print axioms HadwigerNelson.Plane.disjoint_hornSet_hornArcs
#print axioms HadwigerNelson.Plane.disjoint_fanRest_hornSet
#print axioms HadwigerNelson.Plane.disjoint_hornSet_hornSet
#print axioms HadwigerNelson.Plane.fanPiece_mono_radius
#print axioms HadwigerNelson.Plane.fanPiece_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.false_of_col
#print axioms HadwigerNelson.Plane.plantBall_subset_brick
#print axioms HadwigerNelson.Plane.brickBase_mem_interiorPts_zero
#print axioms HadwigerNelson.Plane.plantBall_subset_interiorPts
#print axioms HadwigerNelson.Plane.plantBall_subset_region_zero
#print axioms HadwigerNelson.Plane.tangentBrick_subset_interiorPts
#print axioms HadwigerNelson.Plane.closedBall_tangentCentre_subset_tangentBrick
#print axioms HadwigerNelson.Plane.tangentDisc_subset_interiorPts
#print axioms HadwigerNelson.Plane.isOpen_tangentBrick
#print axioms HadwigerNelson.Plane.convex_tangentBrick
#print axioms HadwigerNelson.Plane.closure_tangentBrick_subset
#print axioms HadwigerNelson.Plane.mem_tangentBrick_of_mem_interiorPts
#print axioms HadwigerNelson.Plane.tangentDisc_far
#print axioms HadwigerNelson.Plane.tangentDisc_subset_closedBall
#print axioms HadwigerNelson.Plane.disjoint_tangentDisc_sphere
#print axioms HadwigerNelson.Plane.disjoint_plantBall_tangent
#print axioms HadwigerNelson.Plane.hornSet_subset_plantBall
#print axioms HadwigerNelson.Plane.tangentCircle_carrier
#print axioms HadwigerNelson.Plane.tangentCircle_nondegenerate
#print axioms HadwigerNelson.Plane.frontier_tangentDisc
#print axioms HadwigerNelson.Plane.horn_ineq
#print axioms HadwigerNelson.Plane.dist_tangentCentre_le_of_mem_hornSet
#print axioms HadwigerNelson.Plane.dist_lt_one_of_hornZone
#print axioms HadwigerNelson.Plane.closure_inter_sphere_subset
#print axioms HadwigerNelson.Plane.ArcMap.tangent_contact_cone

-- Plane/Models/Moves: the two models, their 18 leaves, the four moves applied
#print axioms HadwigerNelson.Plane.hornB_nondegenerate
#print axioms HadwigerNelson.Plane.hornB_finite
#print axioms HadwigerNelson.Plane.frontier_hornW_subset
#print axioms HadwigerNelson.Plane.hornModel_isPlaneMap
#print axioms HadwigerNelson.Plane.hornModel_covers
#print axioms HadwigerNelson.Plane.hornModel_eq_paint
#print axioms HadwigerNelson.Plane.hornFan_strictMono
#print axioms HadwigerNelson.Plane.hornFan_bound
#print axioms HadwigerNelson.Plane.hornB_inter_ball
#print axioms HadwigerNelson.Plane.hornModel_interiorPts_inter_ball
#print axioms HadwigerNelson.Plane.hornModel_isSector_iff
#print axioms HadwigerNelson.Plane.hornW_disjoint_hornB
#print axioms HadwigerNelson.Plane.hornW_subset_interiorPts
#print axioms HadwigerNelson.Plane.hornModel_region_seven
#print axioms HadwigerNelson.Plane.hornModel_col_of_mem
#print axioms HadwigerNelson.Plane.hornModel_col_of_not_mem
#print axioms HadwigerNelson.Plane.hornModel_valid
#print axioms HadwigerNelson.Plane.hornModel_horn_subset_col
#print axioms HadwigerNelson.Plane.hornModel_fanRest_subset_region
#print axioms HadwigerNelson.Plane.hornModel_isHorn
#print axioms HadwigerNelson.Plane.hornModel_hasSectors
#print axioms HadwigerNelson.Plane.hornModel_hasDegree
#print axioms HadwigerNelson.Plane.hornModel_hasHornCount
#print axioms HadwigerNelson.Plane.hornModel_flanks
#print axioms HadwigerNelson.Plane.hornModel_clear
#print axioms HadwigerNelson.Plane.hornW_subset
#print axioms HadwigerNelson.Plane.hornModel_contact_cone
#print axioms HadwigerNelson.Plane.hornModel_contact
#print axioms HadwigerNelson.Plane.hornModel_cone
#print axioms HadwigerNelson.Plane.hornModel_shaveAvailable
#print axioms HadwigerNelson.Plane.hornModel_shave
#print axioms HadwigerNelson.Plane.hornModel_open
#print axioms HadwigerNelson.Plane.holedTile_eq
#print axioms HadwigerNelson.Plane.isOpen_holedTile
#print axioms HadwigerNelson.Plane.closure_holedTile_subset
#print axioms HadwigerNelson.Plane.holedTile_subset_interiorPts
#print axioms HadwigerNelson.Plane.mem_holedTile_of_mem_closure
#print axioms HadwigerNelson.Plane.isPreconnected_holedTile
#print axioms HadwigerNelson.Plane.hornModel_holedTile
#print axioms HadwigerNelson.Plane.twoHornB_nondegenerate
#print axioms HadwigerNelson.Plane.twoHornB_finite
#print axioms HadwigerNelson.Plane.frontier_twoHornW_subset
#print axioms HadwigerNelson.Plane.twoHornModel_isPlaneMap
#print axioms HadwigerNelson.Plane.twoHornModel_covers
#print axioms HadwigerNelson.Plane.twoHornModel_eq_paint
#print axioms HadwigerNelson.Plane.twoHornFan_strictMono
#print axioms HadwigerNelson.Plane.twoHornFan_bound
#print axioms HadwigerNelson.Plane.twoHornB_inter_ball
#print axioms HadwigerNelson.Plane.twoHornModel_interiorPts_inter_ball
#print axioms HadwigerNelson.Plane.twoHornModel_isSector_iff
#print axioms HadwigerNelson.Plane.twoHornW_disjoint_twoHornB
#print axioms HadwigerNelson.Plane.twoHornW_subset_interiorPts
#print axioms HadwigerNelson.Plane.twoHornModel_region_seven
#print axioms HadwigerNelson.Plane.twoHornModel_col_of_mem
#print axioms HadwigerNelson.Plane.twoHornModel_col_of_not_mem
#print axioms HadwigerNelson.Plane.twoHornModel_valid
#print axioms HadwigerNelson.Plane.twoHornModel_horns_subset_col
#print axioms HadwigerNelson.Plane.twoHornModel_rest_gap_subset_col
#print axioms HadwigerNelson.Plane.twoHornModel_isHorn
#print axioms HadwigerNelson.Plane.twoHornModel_hasSectors
#print axioms HadwigerNelson.Plane.twoHornW_subset
#print axioms HadwigerNelson.Plane.twoHornModel_cone
#print axioms HadwigerNelson.Plane.twoHornModel_available
#print axioms HadwigerNelson.Plane.twoHornModel_rayMerge
#print axioms HadwigerNelson.Plane.twoHornModel_merge

namespace MAControl

open HadwigerNelson.Plane Metric

/-- The planted fault of control 2: `hornModel`'s validity leaf reopened. -/
theorem planted_valid : hornModel.Valid := by sorry

/-- `hornModel_shave` with one leaf reopened beneath it: its axioms print must show `sorryAx`. -/
theorem planted_shave : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff hornModel (closedBall plantPt ρ) ∧
    F'.HasSectors plantPt 7 0 := by
  obtain ⟨ρ, hρ, F', h1, h2, -, -, h3, -⟩ := ArcMap.exists_shave planted_valid hornModel_covers (n := 0) (σ := 0)
    hornModel_hasSectors hornModel_isHorn (by norm_num) (by norm_num) hornModel_flanks.1 hornModel_flanks.2 (by norm_num)
    (by norm_num) (hornModel_clear.mono fun _ hr z hz => ⟨fun _ => hr z hz, fun _ => hr z hz⟩)
  exact ⟨ρ, hρ, F', h1, h2, h3⟩

/-- The planted fault of control 3: `twoHornModel`'s cone leaf reopened. -/
theorem planted_cone : (interior (twoHornModel.allowedCone plantPt 7)).Nonempty := by sorry

/-- `twoHornModel_merge` with one leaf reopened beneath it: its axioms print must show `sorryAx`. -/
theorem planted_merge : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff twoHornModel (closedBall plantPt ρ) ∧
    F'.HasSectors plantPt 7 1 := by
  obtain ⟨ρ, hρ, F', h1, h2, -, -, h3, -⟩ := ArcMap.exists_merge twoHornModel_valid twoHornModel_covers (n := 1) le_rfl
    twoHornModel_hasSectors.1 planted_cone
  exact ⟨ρ, hρ, F', h1, h2, h3⟩

end MAControl

-- CONTROL (each must carry sorryAx)
-- control 1: implementer B's models, open on this branch (drop these two lines when `Stuck` and `Bends` are whole)
#print axioms HadwigerNelson.Plane.stuckModel_hyps
#print axioms HadwigerNelson.Plane.awayModel_hyps
-- controls 2 and 3: a model theorem of each model with one leaf reopened beneath it (stay valid after the lane lands)
#print axioms MAControl.planted_shave
#print axioms MAControl.planted_merge
