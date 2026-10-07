import Proofs.HadwigerNelson.Plane.ClosePairModel
/-! FS124-I4, stage 2 — the axioms of the two witnesses proved, read from the build; the control is the third witness,
still `sorry` at this stage: it must print `sorryAx`. -/
open HadwigerNelson.Plane
#print axioms exists_closePair_seven_not_separatesAt
#print axioms exists_closePair_not_separatesAt
#print axioms sevenPair
#print axioms lonePair
#print axioms isWeakColouringOn_sevenCol
#print axioms isWeakColouringOn_loneCol
-- control: must print sorryAx
#print axioms exists_closePair_full
