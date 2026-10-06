/-
FS131-L5 — the receipt that wave 5 is whole after the merge of `fs131-w5z`: the seven heads the brief names, and with them every
record FS131-M7's print (`data/fs131/m7/M7AxiomsFinal.out`, the line before the merge) showed through `sorryAx`.
Run from the worktree, after the build:
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/l5/L5Axioms.lean > data/fs131/l5/L5Axioms.out
and read by `tools/fs131_l5_axioms.py`.  The control is M7's print itself: the same reader on it must fail on each of these.
-/
import Proofs.HadwigerNelson.Plane.ValidMap.BaseDense

-- the seven heads of the brief's step 2
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.of_cutArcs
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_localStep
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_part
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcStep
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminalMap
#print axioms HadwigerNelson.Plane.ArcMap.exists_red
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminal
-- the other five M7's print showed through `sorryAx`
#print axioms HadwigerNelson.Plane.ArcMap.exists_procStep
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminalSeq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hornCount_le
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcBend_toward
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.arcBend
-- the outward bend's own heads (FS131-BA3's receipt, re-read on the joined line)
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_gap
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_subdiv
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.awayBend
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R2
