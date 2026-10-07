import OAI.Geometry.PlaneColoring.Five
/-! EXT-OAI1: the axioms under the headline and under its two halves, printed, and checked as a set against the
three the release's comparator configuration permits. -/
#print axioms OAI.EuclideanFiveColor.no_proper_five_coloring
#print axioms OAI.EuclideanFiveColor.proper_to_borel_weak
#print axioms OAI.EuclideanFiveColor.no_measurable_weak_five_coloring
#print axioms OAI.PlaneFiveColor.Spectral.wild_fourier

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let permitted : List Name := [``propext, ``Quot.sound, ``Classical.choice]
  for n in [``OAI.EuclideanFiveColor.no_proper_five_coloring, ``OAI.EuclideanFiveColor.proper_to_borel_weak,
            ``OAI.EuclideanFiveColor.no_measurable_weak_five_coloring] do
    let ax ← liftCoreM (collectAxioms n)
    let extra := ax.toList.filter (fun a => !permitted.contains a)
    if extra.isEmpty then
      logInfo m!"AXIOM-SET PASS {n}: {ax.size} axioms, all among the three permitted: {ax.toList}"
    else
      throwError "AXIOM-SET FAIL {n}: outside the permitted three: {extra}"
