import Proofs.HadwigerNelson.Plane.ValidMap.BaseDense
import Proofs.HadwigerNelson.Plane.ValidMap.MapGraph
set_option pp.fullNames true
-- FS131-IP2's declarations (expected: the standard three)
#print axioms HadwigerNelson.Plane.BranchGerms.eventually_dir_lt_nextDir
#print axioms HadwigerNelson.Plane.BranchGerms.next_injective
#print axioms HadwigerNelson.Plane.BranchGerms.dir_lt_dir
#print axioms HadwigerNelson.Plane.BranchGerms.dir_le_dir
#print axioms HadwigerNelson.Plane.BranchGerms.dir_lt_dir_zero_add
#print axioms HadwigerNelson.Plane.BranchGerms.exists_far_side
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_sector_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_two_tiles
#print axioms HadwigerNelson.Plane.ArcMap.compl_outerDom_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.outerDom_subset_of_encloses
#print axioms HadwigerNelson.Plane.ArcMap.not_encloses_of_hull_eq
#print axioms HadwigerNelson.Plane.ArcMap.exists_outermost
#print axioms HadwigerNelson.Plane.ArcMap.unenclosed_of_rim_vertex
#print axioms HadwigerNelson.Plane.ArcMap.exists_unenclosed_or_bad
#print axioms HadwigerNelson.Plane.BranchGerms.branchPt_mem_closure_sector
#print axioms HadwigerNelson.Plane.BranchGerms.eq_or_next_eq_of_mem_closure_sector
#print axioms HadwigerNelson.Plane.ArcMap.exists_isRingArc_of_touch
-- partners (expected: sorryAx); exists_eleventh_of rests on noBoth (wave 4's leaf, sorry at the pin)
#print axioms HadwigerNelson.Plane.ArcMap.noBoth
#print axioms HadwigerNelson.Plane.ArcMap.exists_eleventh_of
#print axioms HadwigerNelson.Plane.ArcMap.localDense
