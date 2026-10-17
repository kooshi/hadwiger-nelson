import Proofs
/-! FS131-ISF2 (after FS131-ISF1's `data/fs131/isf1/lean/HeadAxioms.lean`): the axioms of the head statements by full name,
on the gated build of the merged tree — `SeamFractional`'s three heads and two leaves, the certificate's bound and DFS, and
the heads of the two `RationalFour` modules the docstring edit recompiled. The last line is the positive control: an
imported record, whose print must name its declared outside theorem (a print that cannot show one proves nothing by
showing none). Run from the worktree root, under a slot:
  lake env lean data/fs131/isf2/lean/HeadAxioms.lean > data/fs131/isf2/head-axioms.txt -/
set_option pp.fullNames true
#print axioms HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.finIndepRatio_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.iSup_fractionalChromaticNumber_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.IndepLaw.density_le_quarter_seamField
#print axioms HadwigerNelson.Instances.SeamFractional.numberField_seamField
#print axioms HadwigerNelson.G27.density_le_quarter
#print axioms HadwigerNelson.G27.density_le_of_cert
#print axioms HadwigerNelson.G27.cert_bound
#print axioms HadwigerNelson.G27.good_root
#print axioms HadwigerNelson.RationalFour.forall_coloring_eq_iff
#print axioms HadwigerNelson.RationalFour.forall_coloring_ne_iff
#print axioms HadwigerNelson.RationalFour.exists_coloring_eq_and_ne_iff
#print axioms HadwigerNelson.RationalFour.exists_equiv_coloring_add_eq_residue
#print axioms HadwigerNelson.RationalFour.coloring_eq_of_eqOn_isOpen
#print axioms HadwigerNelson.RationalFour.exists_coloring_forbidding_iff
#print axioms HadwigerNelson.RationalFour.exists_coloring_forbidding_iff_padicValRat
#check @HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane
#check @HadwigerNelson.Instances.SeamFractional.iSup_fractionalChromaticNumber_seamPlane
#check @HadwigerNelson.Instances.SeamFractional.finIndepRatio_seamPlane
-- the positive control: an imported record
#print axioms HadwigerNelson.Rigidity.positive_entropy_rigidity_of_polishSpace
