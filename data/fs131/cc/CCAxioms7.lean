import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
set_option pp.fullNames true
/-- A planted control: its record must hold `sorryAx`. -/
theorem ccControlPlanted : (1 : ℕ) = 2 := sorry
-- EXPECT STANDARD — the collar bend and the last leaf
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
#print axioms HadwigerNelson.Plane.ArcMap.exists_collarFit
-- EXPECT STANDARD — stage 7's new supporting theorems
#print axioms HadwigerNelson.Plane.ArcMap.collarK_thin
#print axioms HadwigerNelson.Plane.ArcMap.exists_lens_clear
#print axioms HadwigerNelson.Plane.ArcMap.exists_pos_forall_le
#print axioms HadwigerNelson.Plane.ArcMap.branch_transversal
#print axioms HadwigerNelson.Plane.ArcMap.branch_tangent
#print axioms HadwigerNelson.Plane.ArcMap.exists_end_free
#print axioms HadwigerNelson.Plane.ArcMap.exists_collar_free
-- EXPECT STANDARD — every lemma the assembly cites, and the leaves beneath them
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_valid
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_eq_self
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_fix_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasRepeatedColour
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R3
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_inert
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_lensCurve
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.coloursAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.side_ne_inner_of_mem_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.degree_openArc
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.pushProfiles
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_mem_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_col_apply
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_homeo
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_hasDegree
-- EXPECT SORRY — the planted control
#print axioms ccControlPlanted
