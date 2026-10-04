import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk

/-!
# Row 134's base with unit arcs, and the density rows that rest on it

Moved from `Plane/ValidMap/Dense` by job FS131-KB (statements unchanged), downstream of the walk's leaves (`Plane/ValidMap/BaseWalk`):
`row134BaseUA` (the walk's assembly, `plans/FS131-w5base-kernel-plan.md` § 4) and its consumers FS112-N3-BASE (`n3_base`),
FS129-OR1-LOCALDENSE (`localDense`), FS112-N3-DENSE3 (`dense3`), FS114-CV-EXISTS (`cv_exists`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS112-N3-BASE, FS129-OR1-LOCALDENSE, FS112-N3-DENSE3 -/

/-- **The walk's assembly: row 134's base with unit arcs** (`Row134BaseUA`; FS112-N3-BASE's table, `plans/FS112-N-proof.md` stage N3-3,
NB3 § 1.4 steps 1–12; the leaves are `Plane/ValidMap/BaseWalk`'s, the assembly `plans/FS131-w5base-kernel-plan.md` § 4 leaf F1). Given the
base's context at `u`: the pseudo-colouring of `ω(u)` as a circle colouring (`exists_pseudoCircle`); the returning arcs removed (`reduce` over
`retArc_partner`, `retArcs_finite`, `retArcs_nested`); the selection (`select`) — its hexagon refuted by `hex_base`, else three change points per
absent pair, pairwise more than `1` apart, each with an endpoint (`exists_endpoint`); the eleventh point (`exists_eleventh`, **a GAP as the walk
stands**); the count (`eleventh_type`) yields two endpoints with one multicolour or the eleventh point and a complementary endpoint; the first are
at distance in `[1, 2]` (`endpoint_dist_ge`, `vin_antipodal`) and not `1` (`pair_P'`), so `l3_base` refutes them; the second are at distance
below `2` (`eleventh_antipodal`), so `cor3_base` refutes them. No piece of `[SokolovVoronov2025]` enters by statement except the eleventh point's
sentence (p. 28), which the walk must prove (plan § 2). A refutation's engine: no model expected (`not_row134BaseUA_seven` shows six colours are
spent). -/
theorem row134BaseUA : Row134BaseUA := by
  sorry

/-- **FS112-N3-BASE** (caution C116: a regrade only): in a valid six-coloured fragment covering `B̄(u, 2)`, a cubic trichromatic vertex `u` whose disc
`B̄(u, 2)` holds no vertex of at least four colours and none with a repeated colour does not exist — "row 134's base refutes the map near
`u`", after the inert unit arcs centred within `1` of `u` are bent toward their centres (the proof: FS112-N2-BENDS' toward bend, then
the walk, `row134BaseUA`). Stated on fragments (FS129-OR1-LOCALDENSE's reading: the base reads `B̄(u, 2)` alone). A refutation: no model expected. -/
theorem n3_base {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hu2 : F.Covers u 2)
    (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u) : False := by
  sorry

/-- **FS129-OR1-LOCALDENSE**: every valid six-coloured fragment on a closed disc `B̄(x, 3)` has, in `B̄(x, 3)`, a
vertex of at least four colours or a vertex with a repeated colour. No model held (no valid six-coloured fragment on a disc of radius
`3` is known — the row's own model line); `GENERIC`. -/
theorem localDense {F : ArcMap 6} (hF : F.Valid) {x : ℂ} (hx : F.Covers x 3) :
    ∃ y ∈ closedBall x 3, y ∈ F.fourSet ∪ F.repSet := by
  sorry

/-- **FS112-N3-DENSE3**: every closed disc of radius `3` of every valid six-coloured map of the plane holds a vertex of
at least four colours or a vertex with a repeated colour (`localDense` on the plane). No valid six-map of the plane is known (`GENERIC`). -/
theorem dense3 {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) :
    ∃ y ∈ closedBall x 3, y ∈ F.fourSet ∪ F.repSet := by
  sorry

/-! ## FS114-CV-EXISTS -/

/-- **FS114-CV-EXISTS**: every valid six-coloured map of the plane has a vertex of at least four colours, in the map
itself. The proof (FS114-CVB's route, `plans/FS114-CVB-verification.md` § 1.4) passes through `M*` (`exists_terminal`): with no such
vertex, `dense3` on `M*` gives a stuck vertex whose run is bi-infinite, against N4-FIN (`n4_fin`); a four-colour vertex of `M*` carries
its colours in the map (`IsModification.coloursAt_subset`). It uses neither CV-HD nor C-ENDS, and no strict bound (FS114-L60-WALK: over
`l60_le`). No valid six-map of the plane is known (`GENERIC`). -/
theorem cv_exists {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ x, 4 ≤ (F.coloursAt x).ncard := by
  sorry

end ArcMap

end HadwigerNelson.Plane
