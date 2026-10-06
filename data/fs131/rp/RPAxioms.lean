/-
FS131-RP1 — the axioms of every statement this pass changed, of the declaration it added, of every declaration it kept of a
doubled pair (and of the three it moved), and of the callers it touched.  Run from the worktree, after the build:
  lake env lean data/fs131/rp/RPAxioms.lean > data/fs131/rp/RPAxioms.out
and read by `tools/fs131_rp_axioms.py`.  `exists_arcStep` is the control: on this line it rests on `sorryAx` (the outward
bend's open children), so the print is seen to show a `sorry` where there is one.
-/
import Proofs.HadwigerNelson.Plane.ValidMap.BaseDense
import Proofs.HadwigerNelson.Arith.FalconerField
import Proofs.HadwigerNelson.Arith.Dyadic

-- statements changed (rulings 441 (a); 419 (d), 427 (a); 450 (c); 419 (a))
#print axioms HadwigerNelson.Plane.ArcMap.nb4p
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
#print axioms HadwigerNelson.Plane.ArcMap.exists_rayStep
#print axioms HadwigerNelson.Plane.ArcMap.exists_shaveStep
#print axioms HadwigerNelson.Arith.placeHom_step
#print axioms HadwigerNelson.Arith.falconerFan_five_placeHom
-- the theorems stating the changed definition `DyadicSqrt3Conclusion`
#print axioms HadwigerNelson.Arith.sqrt3_local_of_congr
#print axioms HadwigerNelson.Arith.sqrt3_local
#print axioms HadwigerNelson.Arith.sqrt3_dyadic
-- added, and the model it now carries
#print axioms HadwigerNelson.Plane.ArcMap.collarModel_hyps
#print axioms HadwigerNelson.Plane.ArcMap.collarModel
-- moved (one declaration where two modules declared it, or beside its definition)
#print axioms HadwigerNelson.Plane.conj_e
#print axioms HadwigerNelson.Plane.sq_norm_eq
#print axioms HadwigerNelson.Plane.ArcMap.HasDegree.unique
-- kept of a doubled pair
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_eq_singleton_of_interior
#print axioms HadwigerNelson.Plane.dist_sq_re_im
#print axioms HadwigerNelson.Plane.ringArc_add_two_pi_mul
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_add_int
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.union
#print axioms HadwigerNelson.Plane.ArcMap.finite_arcs_inter_compact
-- callers touched
#print axioms HadwigerNelson.Plane.ArcMap.exists_vertexStep
#print axioms HadwigerNelson.Arith.exists_isPlaceHom
-- the control: through `sorryAx` on this line until the outward bend lands
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcStep
