import Proofs.HadwigerNelson.Plane.ValidMap.BendStep
set_option pp.fullNames true
-- lane H (HornChart): the four children, and their helpers
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_iff_of_agree
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_zero_of_mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.branch_frequently_mem_sphere
#print axioms HadwigerNelson.Plane.ArcMap.branch_curv_eq_of_two_spheres
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_zero_of_two_spheres
#print axioms HadwigerNelson.Plane.ArcMap.germ_eq_of_frequently_branchPt_eq
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_iff_of_germ_swap
-- lane C (R2Cap): the three children, and their helpers
#print axioms HadwigerNelson.Plane.ArcMap.exists_r2_crescent_free
#print axioms HadwigerNelson.Plane.conj_e_mul_e'
#print axioms HadwigerNelson.Plane.r2_frame
#print axioms HadwigerNelson.Plane.r2_coords
#print axioms HadwigerNelson.Plane.r2_dist_sq
#print axioms HadwigerNelson.Plane.r2_dist_sq_base
#print axioms HadwigerNelson.Plane.r2_dist_sq_center
#print axioms HadwigerNelson.Plane.r2X_eq
#print axioms HadwigerNelson.Plane.r2_coords_r2
#print axioms HadwigerNelson.Plane.continuous_r2X
#print axioms HadwigerNelson.Plane.continuous_r2Y
#print axioms HadwigerNelson.Plane.isOpen_r2Side
#print axioms HadwigerNelson.Plane.two_lt_dist_iff
#print axioms HadwigerNelson.Plane.dist_lt_of_mem_r2Crescent
#print axioms HadwigerNelson.Plane.isPreconnected_r2Crescent
#print axioms HadwigerNelson.Plane.r2pt_mem_r2Side
#print axioms HadwigerNelson.Plane.mem_closure_dist_gt
#print axioms HadwigerNelson.Plane.under_point
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.exists_inner_ball
#print axioms HadwigerNelson.Plane.ArcMap.r2_side_dichotomy
#print axioms HadwigerNelson.Plane.ArcMap.exists_r2Subdiv
-- lane C (BendGap): the clearance (C4), the collar (C5), and their helpers
#print axioms HadwigerNelson.Plane.r2Y_eq
#print axioms HadwigerNelson.Plane.r2X_polar
#print axioms HadwigerNelson.Plane.r2_dist_sq_pair
#print axioms HadwigerNelson.Plane.tangRad_neg
#print axioms HadwigerNelson.Plane.dist_lt_of_lt_tangRad
#print axioms HadwigerNelson.Plane.lens_end_far
#print axioms HadwigerNelson.Plane.two_le_dist_of_far
#print axioms HadwigerNelson.Plane.ArcMap.tangRad_sub_one_le_mul
#print axioms HadwigerNelson.Plane.ArcMap.neg_two_lt_r2Y
#print axioms HadwigerNelson.Plane.ArcMap.lens_far_end
#print axioms HadwigerNelson.Plane.ArcMap.exists_gap_cap
#print axioms HadwigerNelson.Plane.ArcMap.exists_gap_middle_far
#print axioms HadwigerNelson.Plane.ArcMap.exists_lensOut_clear
#print axioms HadwigerNelson.Plane.ArcMap.exists_collarFitOut
-- lane C (BendGap): proved from the other half's children (open in this tree until the merge), and the assembly
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_localStep
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.awayBend
-- still open at this stage
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_hornCount_le
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hornCount_le
