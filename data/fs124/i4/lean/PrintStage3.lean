import Proofs.HadwigerNelson.Plane.ClosePairModel
import Proofs.HadwigerNelson.Plane.SectorPoint
/-! FS124-I4, stage 3 — the axioms of the three witnesses, read from the build; the control is a leaf of
`Plane/SectorPoint` still `sorry` at this stage: it must print `sorryAx`. -/
open HadwigerNelson.Plane
#print axioms exists_closePair_seven_not_separatesAt
#print axioms exists_closePair_not_separatesAt
#print axioms exists_closePair_full
#print axioms squarePair
#print axioms isWeakColouringOn_squareCol
#print axioms splitPoint
#print axioms split_inner_lt
#print axioms split_outer_gt
-- control: must print sorryAx
#print axioms exists_closePair_sector
