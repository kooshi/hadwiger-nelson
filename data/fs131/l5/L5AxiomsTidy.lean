/-
FS131-L5 — after the tidies of Stage 3: the seven statements that lost their unread `hF`, their callers, the lemma kept of the
`ringPt` pair with the theorems of `BaseDense` that now read it, and the wave's heads again.
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/l5/L5AxiomsTidy.lean > data/fs131/l5/L5AxiomsTidy.out
read by `tools/fs131_l5_axioms.py` (each on exactly the standard three).
-/
import Proofs.HadwigerNelson.Plane.ValidMap.BaseDense

-- the seven statements changed (rulings 457 (b), 465 (a))
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hornCount_le
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R2
-- their callers
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_inert
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_isR2Arc
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.arcBend
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.awayBend
-- the lemma kept of the pair, and the heads again
#print axioms HadwigerNelson.Plane.ringPt_inj_of_abs_sub_lt
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.of_cutArcs
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_localStep
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_part
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcStep
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminalMap
#print axioms HadwigerNelson.Plane.ArcMap.exists_red
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminal
#print axioms HadwigerNelson.Plane.ArcMap.row134BaseUA
