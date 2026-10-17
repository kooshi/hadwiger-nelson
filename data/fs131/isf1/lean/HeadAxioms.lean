import Proofs.HadwigerNelson.Instances.SeamFractional
/-! FS131-ISF1: the axioms of the head statements and of the certificate's bound, by full name. Run from the worktree root:
  lake env lean data/fs131/isf1/lean/HeadAxioms.lean -/
set_option pp.fullNames true
#print axioms HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.finIndepRatio_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.iSup_fractionalChromaticNumber_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.IndepLaw.density_le_quarter_seamField
#print axioms HadwigerNelson.Instances.SeamFractional.numberField_seamField
#print axioms HadwigerNelson.G27.density_le_quarter
#print axioms HadwigerNelson.G27.cert_bound
#print axioms HadwigerNelson.G27.good_root
#check @HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane
#check @HadwigerNelson.Instances.SeamFractional.iSup_fractionalChromaticNumber_seamPlane
#check @HadwigerNelson.Instances.SeamFractional.finIndepRatio_seamPlane
