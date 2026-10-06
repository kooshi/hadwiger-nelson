import Proofs

-- FS131-I5n stage 41: the axioms of this stage's declarations, read from the build's oleans; controls at the end.
#print axioms HadwigerNelson.Plane.ArcMap.flank_radial_N
#print axioms HadwigerNelson.Plane.ArcMap.flank_radial_S
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_N_subset_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_S_subset_of_flankBelow
#print axioms HadwigerNelson.Plane.mem_coneAt_of_e_eq
#print axioms HadwigerNelson.Plane.not_mem_angleIcc_of_gap
#print axioms HadwigerNelson.Plane.mem_angleIoo_of_e_ne
#print axioms HadwigerNelson.Plane.mem_angleIoo_half
#print axioms HadwigerNelson.Plane.BranchGerms.exists_succ
#print axioms HadwigerNelson.Plane.BranchGerms.exists_pred
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.false_of_full
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.card_le_encard_sectorsOf
#print axioms HadwigerNelson.Plane.ArcMap.mergeAvailable_of_two_sectors
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_index_of_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.cv_hd_main_inType
-- its consumers (over y3_end_needs, still open: sorryAx expected)
#print axioms HadwigerNelson.Plane.ArcMap.cv_hd_main
#print axioms HadwigerNelson.Plane.ArcMap.cv_hd
-- controls: open leaves must read sorryAx; a closed one the standard three
#print axioms HadwigerNelson.Plane.ArcMap.y3_end_needs
#print axioms HadwigerNelson.Plane.ArcMap.exists_merge
#print axioms HadwigerNelson.Plane.ArcMap.upper_bounds_of_inType_N
