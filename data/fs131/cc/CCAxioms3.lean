import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
-- FS131-CC1 stage 3: proved with no `sorry` of their own and none beneath (expected: the standard three or fewer)
#print axioms HadwigerNelson.Plane.ArcMap.isCompact_polarSet_Icc
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_not_mem_openArc_of_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lensProf_le_one
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.isClosed_closedLens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.isClosed_collarK
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_region_inter_iff_of_agree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.degree_openArc
-- proved, resting on lane G's open children (expected: sorryAx until lane G lands; the second list says which)
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lens_subset_closedLens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R3
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.coloursAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.side_ne_inner_of_mem_lens
-- proved, resting also on lane C's open children (`sides_end`, `map_degree_lensCurve`, `map_degree_end`)
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_inert
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_and_repeated
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasRepeatedColour
-- controls (expected: sorryAx): an open child of lane C, the assembly
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_end
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
