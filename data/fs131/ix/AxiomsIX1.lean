import Proofs.HadwigerNelson.Plane.PlaneTopology
import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk
-- FS131-IX1: the axiom receipt, run against the build's oleans by `lake env lean`. The last line is the partner that must show `sorryAx`
-- (`retArcs_not_interleaved`, FS131-IP2's leaf, still `sorry` on this branch).
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved
#print axioms HadwigerNelson.Plane.exists_eq_of_interleaved_paths
#print axioms HadwigerNelson.Plane.e_mul_e_neg
#print axioms HadwigerNelson.Plane.arg_one_sub_e
#print axioms HadwigerNelson.Plane.arg_one_sub_e_of_neg
#print axioms HadwigerNelson.Plane.re_pos_of_mem_closedBall
#print axioms HadwigerNelson.Plane.ringPt_sub_ringPt_mul_e_neg
#print axioms HadwigerNelson.Plane.im_sub_eq_arg_sub
#print axioms HadwigerNelson.Plane.continuous_discRetract
#print axioms HadwigerNelson.Plane.discRetract_mem
#print axioms HadwigerNelson.Plane.discRetract_of_mem
#print axioms HadwigerNelson.Plane.dist_discRetract_le
#print axioms HadwigerNelson.Plane.isPreconnected_thickening
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved_of_isClosed_left
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.retArcs_not_interleaved
