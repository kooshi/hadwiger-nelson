import Proofs.HadwigerNelson.Plane.Models.Moves
import Proofs.HadwigerNelson.Plane.Models.Stuck
import Proofs.HadwigerNelson.Plane.Models.Bends

-- FS131-MA1: every theorem of Plane/Models/Paint (the general layer KM1 proved, the 13 leaves, the helpers)
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

-- CONTROL (each must carry sorryAx: implementer B's models, open on this branch)
#print axioms HadwigerNelson.Plane.stuckModel_hyps
#print axioms HadwigerNelson.Plane.awayModel_hyps
