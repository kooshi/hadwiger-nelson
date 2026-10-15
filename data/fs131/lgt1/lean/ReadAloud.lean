import Proofs
/-! FS131-LGT1 — the read-aloud's print, from the gated build: the two headline statements and M15's other values, each
with its axioms, and every defined term their statements name, traced to its definition. -/
set_option pp.fullNames true
open HadwigerNelson
#check @Rigidity.min_localBound_five_le_chromaticNumber
#print axioms Rigidity.min_localBound_five_le_chromaticNumber
#check @SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
#print axioms SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
#check @Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound
#print axioms Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound
#check @SqrtClassValues.chromaticNumber_planeOver_sqrt143_eq_five
#print axioms SqrtClassValues.chromaticNumber_planeOver_sqrt143_eq_five
#check @SqrtClassValues.chromaticNumber_planeOver_sqrt311_eq_five
#print axioms SqrtClassValues.chromaticNumber_planeOver_sqrt311_eq_five
#check @SqrtClassValues.chromaticNumber_planeOver_sqrt335_eq_five
#print axioms SqrtClassValues.chromaticNumber_planeOver_sqrt335_eq_five
#check @SqrtClassValues.chromaticNumber_planeOver_sqrt3_sqrt5_eq_five
#print axioms SqrtClassValues.chromaticNumber_planeOver_sqrt3_sqrt5_eq_five
#check @SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167
#print axioms SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167
#check @SqrtFortySeven.five_le_localBound_sqrt47
#print axioms SqrtFortySeven.five_le_localBound_sqrt47
-- the defined terms
#print planeOver
#print unitDistance
#print SpectralChain.localBound
#print SpectralChain.StablePrime
#print SpectralChain.fieldI
#print UnitRing.planeOverSubfield
#print SpectralChain.levelTarget
#print SquareClass.fieldOfRadicands
#print SqrtFortySeven.F47
#print SimpleGraph.chromaticNumber
#print SimpleGraph.induce
#check @SqrtFortySeven.numberField_F47
#print axioms SqrtFortySeven.numberField_F47
#check @Rigidity.positive_entropy_rigidity
#check @StandingFive.kloosterman_bound
