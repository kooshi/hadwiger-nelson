import Proofs.HadwigerNelson.Plane.ValidMap.Procedure

/-! ## FS-131 wave 5 (job FS131-M7) — the join of wave 5's lines; the arc step proved from the bends (`Plane/ValidMap/Procedure`)

One new declaration: `IsMaxRingArc.meet` (FS131-IA1's W5, FS131-IA2's proof), on which `exists_arcStep`'s proof reads the maximality
of the bent arc. `exists_arcStep` itself has its record above (once); it holds no `sorry` of its own now and rests, through
`bend_away_part` and `exists_arcBend_toward`, on the open declarations of the six bend modules (`BendAway`, `LensOut`,
`CollarMapOut`, `R2Cap`, `HornChart`, `BendGap`) and on `BendStep`'s `CollarFit.map_hornCount_le`, so the gate fails on it, and on
what is proved over it, until they land. Moved by the join, in FS131-IA2's block above: `CollarFit.map_localStep` is through `sorryAx` until
`Plane/ValidMap/BendAway`'s `LocalStep.of_cutArcs` is proved (its proof stood in `ArcStep` on `fs131-w5y`; inventory item 448 (a)). -/

#print axioms HadwigerNelson.Plane.ArcMap.IsMaxRingArc.meet

