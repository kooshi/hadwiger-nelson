import Proofs.HadwigerNelson.Plane.ClosePair
/-! FS124-I3 — the five theorems of the four claims as the kernel holds them (`#check`: every binder of the stored
type), and the definitions their statements read. Read from the build; never evidence of a proof. -/
open HadwigerNelson.Plane
set_option pp.fullNames false
#check @closePair_forced_pieces
#check @closePair_lone
#check @closePair_both_separate
#check @closePair_both_saved
#check @closePair_four
#print ClosePair
#print ThreePiece
#print IsCommonUnitPoint
#print ThreePiece.SeparatesAt
#print ThreePiece.OneOfEach
#print ThreePiece.IsFull
#print ThreePiece.HasArcEdges
#print ThreePiece.Saves
#print HasUnitArcFrom
#print ThreePiece.edge
#print presentAt
#print InnerAt
#print OuterAt
#print CrossingAt
