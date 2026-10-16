import Proofs.HadwigerNelson.Instances.SqrtTwentyThreeCbrtTwo
import Proofs.HadwigerNelson.Rigidity.FourColourPlaces
/-! FS131-ICS1 — the stored head statements read aloud against `LEDGER.md` row 123, printed from the gated build with full
names and every implicit argument a reader needs. Run from the worktree's root, under a slot:
  lake env lean data/fs131/ics1/lean/ReadAloud.lean > data/fs131/ics1/read-aloud.txt -/
set_option pp.fullNames true
set_option pp.funBinderTypes true
#check @HadwigerNelson.SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff
#check @HadwigerNelson.SqrtFiveClass.five_le_localBound_sqrt_iff
#check @HadwigerNelson.SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five
#check @HadwigerNelson.SqrtFiveClass.localBound_sqrt_eq_five
#check @HadwigerNelson.Rigidity.five_le_localBound_iff
#check @HadwigerNelson.Rigidity.colorable_four_levelTarget_one_iff
#check @HadwigerNelson.Rigidity.exists_ratioAtMost_lt_quarter_iff
#check @HadwigerNelson.Rigidity.tca_iff_forall_not_isFourColourPlace
#check @HadwigerNelson.Rigidity.five_le_localBoundAllLevels_iff
#check @HadwigerNelson.Rigidity.min_localBoundAllLevels_five
#check @HadwigerNelson.UpperHalf.localBound_le_unitQuadrance
#check @HadwigerNelson.UpperHalf.exists_stablePrime_card_eq_sq
#check @HadwigerNelson.SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five
#check @HadwigerNelson.SqrtTwentyThreeCbrtTwo.localBound_sqrt23_cbrt2_eq_five
#check @HadwigerNelson.SqrtTwentyThreeCbrtTwo.localBound_sqrt23_eq_four
#check @HadwigerNelson.SqrtTwentyThreeCbrtTwo.not_isTotallyReal_F23
#check @HadwigerNelson.Rigidity.ratioAtMost_dyadic_of_six_le
#print HadwigerNelson.Rigidity.IsFourColourPlace
#print HadwigerNelson.Rigidity.localBoundAllLevels
#print HadwigerNelson.SqrtTwentyThreeCbrtTwo.F23
#print HadwigerNelson.SqrtTwentyThreeCbrtTwo.cbrtTwo
#print HadwigerNelson.SpectralChain.localBound
#print HadwigerNelson.SpectralChain.levelTarget
#print HadwigerNelson.SpectralChain.StablePrime
#print HadwigerNelson.Rigidity.IsRamified
#print HadwigerNelson.Arith.IsUsablePrime
#print HadwigerNelson.SquareClass.fieldOfRadicands
#print HadwigerNelson.planeOver
#print HadwigerNelson.unitDistance
#print axioms HadwigerNelson.SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff
#print axioms HadwigerNelson.SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five
#print axioms HadwigerNelson.Rigidity.five_le_localBound_iff
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five
#print axioms HadwigerNelson.UpperHalf.localBound_le_unitQuadrance
