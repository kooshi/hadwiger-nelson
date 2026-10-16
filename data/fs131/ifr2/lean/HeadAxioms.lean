import Proofs
/-! FS131-IFR2 — `#print axioms` of the head statements of the two landings this merge joins, on the merged build (the density
form of the collapse, FS131-IFR1; five colours by field and by class, FS131-ICS1). Read-only. Run from the worktree root, under a slot:
  lake env lean data/fs131/ifr2/lean/HeadAxioms.lean > data/fs131/ifr2/head-axioms.txt -/
set_option pp.fullNames true
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_localRatio
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_iSup_density
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_eq
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_mOne_of_thick
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_plane_of_thick
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_eq_plane_of_thick
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_sqrt635087
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_deGrey
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_sqrt635087
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_deGrey
#print axioms HadwigerNelson.Collapse.IndepLaw.density_le_localRatio
#print axioms HadwigerNelson.Collapse.IndepLaw.density_le_notThick
#print axioms HadwigerNelson.Collapse.le_volume_selection
#print axioms HadwigerNelson.Collapse.inv_le_localRatio_of_colorable
#print axioms HadwigerNelson.Collapse.inv_localRatio_lt_five
#print axioms HadwigerNelson.Collapse.exists_triangleFree_ratio_lt
#print axioms HadwigerNelson.Collapse.exists_finite_triangleFree_six_chromatic
#print axioms HadwigerNelson.Collapse.six_le_chromaticNumber_planeOver_sqrt635087
#print axioms HadwigerNelson.Collapse.chromaticNumber_planeOver_sqrt635087_le_seven
#print axioms HadwigerNelson.Collapse.exists_model_seven
#print axioms HadwigerNelson.Plane.pi_div_le_mOne
#print axioms HadwigerNelson.Plane.fifth_lt_mOne
#print axioms HadwigerNelson.Rigidity.ratioAtMost_of_charBound
#print axioms HadwigerNelson.SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff
#print axioms HadwigerNelson.SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five
#print axioms HadwigerNelson.Rigidity.five_le_localBound_iff
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.localBound_sqrt23_cbrt2_eq_five
#print axioms HadwigerNelson.UpperHalf.localBound_le_unitQuadrance
