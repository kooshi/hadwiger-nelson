import Proofs.HadwigerNelson.Plane.ClosePairModel
/-! FS124-I3 — the axioms of the five theorems of the four claims, printed from the build of Stage 2 (the interface and
`Plane/ClosePair` proved; the two constructions of `Plane/ThreePiece` still `sorry`), then four controls. -/
set_option pp.fullNames true
#print axioms HadwigerNelson.Plane.closePair_forced_pieces
#print axioms HadwigerNelson.Plane.closePair_lone
#print axioms HadwigerNelson.Plane.closePair_both_separate
#print axioms HadwigerNelson.Plane.closePair_both_saved
#print axioms HadwigerNelson.Plane.closePair_four
-- CONTROLS (each must print `sorryAx`): a theorem planted here on `sorry`; a theorem planted here that cites it; a
-- theorem of my own file that at this stage still rests on a `sorry` of mine (the sector point's fields); and a theorem
-- of the third job's file, which this branch holds as a skeleton
theorem FS124I3.control_planted : (2 : Nat) + 2 = 4 := by sorry
theorem FS124I3.control_cites : (2 : Nat) + 2 = 4 := FS124I3.control_planted
#print axioms FS124I3.control_planted
#print axioms FS124I3.control_cites
#print axioms HadwigerNelson.Plane.sectorPoint_isFull
#print axioms HadwigerNelson.Plane.exists_closePair_full
