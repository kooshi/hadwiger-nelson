import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
set_option pp.fullNames true
/-- A planted control: its record must hold `sorryAx`. -/
theorem ccControlPlanted : (1 : ℕ) = 2 := sorry
-- EXPECT STANDARD — FS131-CC2's new supporting theorems (Pushforward: germ counts under a homeomorphism; BendCollar: the collar in an end's frame)
#print axioms HadwigerNelson.Plane.ArcMap.exists_subset_of_isPreconnected_iUnion
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_injective_of_homeo
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_homeo
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.collarK_frame
#print axioms HadwigerNelson.Plane.ArcMap.side_core_pos
#print axioms HadwigerNelson.Plane.ArcMap.side_core_neg
#print axioms HadwigerNelson.Plane.ArcMap.crescent_Y
#print axioms HadwigerNelson.Plane.ArcMap.side_core
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.exists_one_side
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_mem_collarK
-- EXPECT STANDARD — three of lane C's four leaves, proved at stage 6
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_lensCurve
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_end
-- EXPECT STANDARD — every clause lemma of the assembly (CC1's and lane G's), off sorryAx now
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_inert
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_and_repeated
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasRepeatedColour
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R3
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.coloursAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.side_ne_inner_of_mem_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_valid
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.degree_openArc
-- EXPECT SORRY — the one open leaf, the assembly over it, and the planted control
#print axioms HadwigerNelson.Plane.ArcMap.exists_collarFit
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
#print axioms ccControlPlanted
