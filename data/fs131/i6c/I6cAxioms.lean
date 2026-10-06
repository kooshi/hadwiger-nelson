import Proofs.HadwigerNelson.Plane.Saturated.LocalGraph
/-! FS131-I6C: the axioms of each declaration this job proved, read from the build's oleans
(`lake env lean data/fs131/i6c/I6cAxioms.lean`). The first print is the **control**: a declaration that still rests on
`sorry` on this branch must show `sorryAx`, so the reader is seen to report the failure it guards against. -/
open HadwigerNelson.Plane
set_option pp.fullNames true
#eval IO.println "=== CONTROL (must show sorryAx) ==="
#print axioms HadwigerNelson.Plane.c11_discs
#eval IO.println "=== Curve ==="
#print axioms HadwigerNelson.Plane.IsUnitCurve.hasDerivWithinAt_re_mul
#print axioms HadwigerNelson.Plane.IsUnitCurve.hasDerivWithinAt_norm_sq
#print axioms HadwigerNelson.Plane.IsUnitCurve.abs_sub_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_add_sin_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.chord
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_le_inner
#print axioms HadwigerNelson.Plane.IsUnitCurve.strictMonoOn_dist
#print axioms HadwigerNelson.Plane.IsUnitCurve.norm_sub_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.one_le_dist_of_sign
#print axioms HadwigerNelson.Plane.IsUnitCurve.one_le_dist
#print axioms HadwigerNelson.Plane.isUnitCurve_circle
#print axioms HadwigerNelson.Plane.two_sin_le_norm_e_sub_e
#print axioms HadwigerNelson.Plane.lt_mul_of_two_sin_le
#print axioms HadwigerNelson.Plane.le_add_of_chord
#print axioms HadwigerNelson.Plane.lipschitzOnWith_of_chord
#print axioms HadwigerNelson.Plane.IsUnitCurve.strictMonoOn_dist_of_le_pi
#eval IO.println "=== LocalGraph: the three small leaves and their children ==="
#print axioms HadwigerNelson.Plane.AeColouring.notMem_essBdry_of_mem_densitySet
#print axioms HadwigerNelson.Plane.AeColouring.exists_densitySet_of_notMem
#print axioms HadwigerNelson.Plane.AeColouring.isOpen_setOf_forall_notMem_essSupport
#print axioms HadwigerNelson.Plane.AeColouring.mem_densitySet_of_forall_notMem_essSupport
#print axioms HadwigerNelson.Plane.AeColouring.ae_one_colour_of_isConnected
#print axioms HadwigerNelson.Plane.AeColouring.closure_essBdry_subset
#eval IO.println "=== WIRED (over local_graph and Pinch's leaves: must show sorryAx) ==="
#print axioms HadwigerNelson.Plane.AeColouring.local_graph
#eval IO.println "=== Stage 4: the lens point, the two-set children, the arclength inverse ==="
#print axioms HadwigerNelson.Plane.lens_ineq_real
#print axioms HadwigerNelson.Plane.lens_point_real
#print axioms HadwigerNelson.Plane.exists_lens_point_far
#print axioms HadwigerNelson.Plane.exists_lens_point
#print axioms HadwigerNelson.Plane.TwoColourOn.false_of_mem_inter
#print axioms HadwigerNelson.Plane.TwoColourOn.notMem_essClosure_of_mem_densitySet
#print axioms HadwigerNelson.Plane.TwoColourOn.mem_interior_densitySet_of_notMem
#print axioms HadwigerNelson.Plane.TwoColourOn.mem_interior_densitySet_or
#print axioms HadwigerNelson.Plane.exists_arclength_inverse
#eval IO.println "=== Stage 4 WIRED (over Pinch's essBoundary_inter_eq: must show sorryAx) ==="
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.one_le_norm_sub
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.norm_sub_le
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.normal_unique
#eval IO.println "=== Stage 5: the graph theorem, the sides, the path ==="
#print axioms HadwigerNelson.Plane.hasDerivAt_of_sq_bound
#print axioms HadwigerNelson.Plane.abs_le_of_two_disc_bound
#print axioms HadwigerNelson.Plane.hasDerivAt_of_two_disc_bound
#print axioms HadwigerNelson.Plane.abs_inner_le_of_one_le
#print axioms HadwigerNelson.Plane.im_ge_of_norm_sub_I_le
#print axioms HadwigerNelson.Plane.e_neg_arcsin_re
#print axioms HadwigerNelson.Plane.exists_unit_curve_of_two_discs
#print axioms HadwigerNelson.Plane.isConnected_graph_side
#print axioms HadwigerNelson.Plane.interior_densitySet_inter_ae_le
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.subset_interior_densitySet
#print axioms HadwigerNelson.Plane.TwoColourOn.exists_mem_essBoundary_of_continuous
#print axioms HadwigerNelson.Plane.TwoColourOn.ae_le_of_isPreconnected
#eval IO.println "=== Stage 5 WIRED (over Pinch's c11_discs and essBoundary_inter_eq: must show sorryAx) ==="
#print axioms HadwigerNelson.Plane.local_graph
#eval IO.println "=== Stage 6: the inhabitant ==="
#print axioms HadwigerNelson.Plane.sq9_not_isCuspAt_near_edge
#print axioms HadwigerNelson.Plane.sqEdgePt_mem_essBoundary
#eval IO.println "=== Stage 6 WIRED (local_graph applied to sq9: must show sorryAx) ==="
#print axioms HadwigerNelson.Plane.sq9_exists_isInterfaceChart
