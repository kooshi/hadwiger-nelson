import Proofs
set_option pp.fullNames true
-- FS131-I5q, stage 58: `bv_l3` in `BaseWalk`, over `l3_core`; `l3_base` over the same core
#print axioms HadwigerNelson.Plane.ArcMap.bv_l3
#print axioms HadwigerNelson.Plane.ArcMap.bv_l3_dbl
#print axioms HadwigerNelson.Plane.ArcMap.l3_core
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.l3_base
#print axioms HadwigerNelson.Plane.ArcMap.not_onRingArc_of_finite
#print axioms HadwigerNelson.Plane.ArcMap.ringCircle_val_germ
#print axioms HadwigerNelson.Plane.ArcMap.ringCircle_noSwap
#print axioms HadwigerNelson.Plane.ArcMap.eq_or_eq_neg_of_dot_I_mul_e
#print axioms HadwigerNelson.Plane.CircleColouring.link_bad_finite
#print axioms HadwigerNelson.Plane.CircleColouring.link_val_right_side
#print axioms HadwigerNelson.Plane.CircleColouring.link_val_left_side
-- what rests on `l3_base`, and the pre-bend's consumers, unchanged
#print axioms HadwigerNelson.Plane.ArcMap.row134BaseUA
#print axioms HadwigerNelson.Plane.ArcMap.exists_preBend
#print axioms HadwigerNelson.Plane.ArcMap.n3_base
#print axioms HadwigerNelson.Plane.ArcMap.localDense
#print axioms HadwigerNelson.Plane.ArcMap.dense3
-- control: still on `sorry` (the `Terminal` lane's stale copy)
#print axioms HadwigerNelson.Plane.ArcMap.cv_exists
