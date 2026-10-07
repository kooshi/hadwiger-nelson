/-! ## FS124-I5 — three arcs from a point of a disc to its rim (planned by FS124-K3): `Plane/ThreeArcs`. Pure plane
topology, no colouring and no measure: the closed disc is unicoherent; the θ-lemma `IsTriodCut.exists_opposite` (given
three open preconnected pairwise disjoint sets filling the disc less three arcs from its centre to its rim, each arc
lies in the closures of exactly two of them and every two share one) and the form `ThreePiece.IsSector.hasArcEdges`
reads, `IsTriodCut.exists_arc`. No import and no declared hypothesis: every record is CLEAN. -/
-- FS124-I5: Plane/ThreeArcs
#print axioms HadwigerNelson.Plane.ballRetract_one
#print axioms HadwigerNelson.Plane.continuous_ballRetract
#print axioms HadwigerNelson.Plane.ballRetract_mem
#print axioms HadwigerNelson.Plane.ballRetract_of_mem
#print axioms HadwigerNelson.Plane.ballRetract_of_mem_segment
#print axioms HadwigerNelson.Plane.isPreconnected_preimage_ballRetract
#print axioms HadwigerNelson.Plane.isPreconnected_inter_of_union_eq_closedBall
#print axioms HadwigerNelson.Plane.isPreconnected_inter_halves
#print axioms HadwigerNelson.Plane.RimOrder.rotate
#print axioms HadwigerNelson.Plane.RimOrder.eq_or
#print axioms HadwigerNelson.Plane.polarPt_add_turn
#print axioms HadwigerNelson.Plane.fin_three_eq_or_of_ne
#print axioms HadwigerNelson.Plane.exists_ne_ne_fin_three
#print axioms HadwigerNelson.Plane.fin_three_add_one_ne
#print axioms HadwigerNelson.Plane.isClosed_iUnion_range_arc
#print axioms HadwigerNelson.Plane.exists_arc_range_subset_inter
#print axioms HadwigerNelson.Plane.IsTriod.apply_mem_closedBall
#print axioms HadwigerNelson.Plane.IsTriod.apply_mem_ball
#print axioms HadwigerNelson.Plane.IsTriod.apply_one_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.eq_one_of_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.apply_one_ne
#print axioms HadwigerNelson.Plane.IsTriod.isPreconnected_range_union_range
#print axioms HadwigerNelson.Plane.IsTriod.isPreconnected_iUnion_range
#print axioms HadwigerNelson.Plane.IsTriod.polarPt_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.range_subset_of_isPreconnected
#print axioms HadwigerNelson.Plane.IsTriod.apply_one_eq_polarPt
#print axioms HadwigerNelson.Plane.IsTriod.isPreconnected_image_Icc
#print axioms HadwigerNelson.Plane.IsTriod.exists_rimOrder
#print axioms HadwigerNelson.Plane.IsTriod.eq_apply_one_of_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.notMem_iUnion_range_of_mem_Ioo
#print axioms HadwigerNelson.Plane.IsTriod.not_mem_closure_both_sides
#print axioms HadwigerNelson.Plane.IsTriodCut.mem_diff_of_mem
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_mem_piece
#print axioms HadwigerNelson.Plane.IsTriodCut.eq_of_mem_of_mem_closure
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_piece_subset_closedBall
#print axioms HadwigerNelson.Plane.IsTriodCut.piece_subset_ball
#print axioms HadwigerNelson.Plane.IsTriodCut.disjoint_iUnion_range
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_unique_mem_closure
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_inter_closure_subset
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_forall_rimArc
#print axioms HadwigerNelson.Plane.IsTriodCut.disjoint_range_union_range
#print axioms HadwigerNelson.Plane.IsTriodCut.ne_of_rimOrder
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_rimPieces
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_inter_nonempty
#print axioms HadwigerNelson.Plane.IsTriodCut.isPreconnected_closure_inter
#print axioms HadwigerNelson.Plane.IsTriodCut.rimPiece_spec
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_opposite
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_range_subset
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_inter_closure_inter_ball
#print axioms HadwigerNelson.Plane.IsTriodCut.mem_closure
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_arc
-- FS124-I5 block end
