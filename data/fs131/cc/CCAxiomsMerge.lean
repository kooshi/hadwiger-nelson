import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
set_option pp.fullNames true
/-- A planted control: its record must hold `sorryAx`. -/
theorem ccControlPlanted : (1 : ℕ) = 2 := sorry
-- EXPECT STANDARD — lane G's children (KP2's 20 in RadialPush, 12 in CollarMap), merged from fs131-w5 at 5059983d
#print axioms HadwigerNelson.Plane.push1_push1
#print axioms HadwigerNelson.Plane.push1_image_Ico
#print axioms HadwigerNelson.Plane.push1_image_Ioc
#print axioms HadwigerNelson.Plane.pushInv_pushFun
#print axioms HadwigerNelson.Plane.pushFun_pushInv
#print axioms HadwigerNelson.Plane.continuous_pushFun
#print axioms HadwigerNelson.Plane.continuous_pushInv
#print axioms HadwigerNelson.Plane.pushHomeo_polar
#print axioms HadwigerNelson.Plane.pushHomeo_eq_self
#print axioms HadwigerNelson.Plane.pushHomeo_image_polarSet
#print axioms HadwigerNelson.Plane.tangRad_spec
#print axioms HadwigerNelson.Plane.tangRad_lt_one
#print axioms HadwigerNelson.Plane.one_lt_tangRad
#print axioms HadwigerNelson.Plane.tangRad_lt_tangRad
#print axioms HadwigerNelson.Plane.one_sub_tangRad_le
#print axioms HadwigerNelson.Plane.tangRad_sub_one_le
#print axioms HadwigerNelson.Plane.pushProfiles_collar
#print axioms HadwigerNelson.Plane.one_sub_lensProf_le
#print axioms HadwigerNelson.Plane.collarArcs_carrier
#print axioms HadwigerNelson.Plane.dist_lt_one_of_mem_polarSet
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.kin_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.kout_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_eq_self
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_ringPt
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_fix_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_image_dom
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.collarArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.collarArcs_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_valid
-- EXPECT STANDARD — Pushforward (KP2's children, CC1's chart on a circle)
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_region
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_agree
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_charts
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_Γ
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_mem_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_col_apply
#print axioms HadwigerNelson.Plane.ArcMap.isSectorChart_circle
#print axioms HadwigerNelson.Plane.ArcMap.degree_of_circle
-- EXPECT STANDARD — CC1's lemmas in BendCollar that read only lane G's children
#print axioms HadwigerNelson.Plane.ArcMap.isCompact_polarSet_Icc
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_not_mem_openArc_of_end
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_region_inter_iff_of_agree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.degree_openArc
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lensProf_le_one
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.isClosed_closedLens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.isClosed_collarK
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lens_subset_closedLens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R3
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.coloursAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.side_ne_inner_of_mem_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.pushProfiles
-- EXPECT SORRY — CC1's lemmas that read lane C's open leaves (`sides_end`; `map_degree_lensCurve`, `map_degree_end`)
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_inert
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_and_repeated
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasRepeatedColour
-- EXPECT SORRY — the four open leaves, the assembly, and the planted control
#print axioms HadwigerNelson.Plane.ArcMap.exists_collarFit
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_lensCurve
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_end
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
#print axioms ccControlPlanted
