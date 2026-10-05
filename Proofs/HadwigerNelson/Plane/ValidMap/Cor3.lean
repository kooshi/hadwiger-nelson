import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps

/-!
# FS112-N3-COR3: a close complementary pair sits on a rhombus of four-colour leaving centres

Wave 5's `cor3`, moved here verbatim from `Plane/ValidMap/Dense` (statement, docstring and proof; inventory item 299 (a), job FS131-I5e) so that
`Plane/ValidMap/HexRing`'s N2-ROT (`rot_noThird`, whose hand proof rests on it) can cite it: every name its statement uses is upstream of `HexRing`
(`IsCubicTrichromatic`, `BothKind` in `Plane/ValidMap/Basic`, `IsLeavingCentre` in `Plane/ValidMap/BaseSteps`, `Covers`, `Valid`, `coloursAt` in
`Plane/ArcMap`). Row: **FS112-N3-COR3** (`cor3`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

/-! ## FS112-N3-COR3 -/

/-- **FS112-N3-COR3**: in a valid six-coloured map, a close complementary pair of cubic trichromatic vertices `u, u′` (disjoint
multicolours, `|u − u′| < 2`) sits on a unit rhombus `u, qp, u′, qm` whose other corners carry at least four colours, each a leaving
centre of both `u` and `u′` and the centre of a both-kind unit arc ("T2 is forced at both common unit points"). Stated for fragments
covering `B̄(u, 1)` and `B̄(u′, 1)` (the class the argument reads: the strips at `q±` and the arcs at `u`, `u′`) — a widening of "in a
valid map", reported. Six colours are spent ("the complement of `c(u′)` is `c(u)`"). No inhabitant: a valid fragment with such a pair is
FS112-STOP's object (the strip's printed colouring violates it); `GENERIC`. -/
theorem cor3 {F : ArcMap 6} (hF : F.Valid) {u u' : ℂ} (hu : F.IsCubicTrichromatic u) (hu' : F.IsCubicTrichromatic u')
    (hcu : F.Covers u 1) (hcu' : F.Covers u' 1) (hdis : Disjoint (F.coloursAt u) (F.coloursAt u')) (hd : dist u u' < 2) :
    ∃ qp qm : ℂ, qp ≠ qm ∧ ∀ q ∈ ({qp, qm} : Set ℂ), dist q u = 1 ∧ dist q u' = 1 ∧ 4 ≤ (F.coloursAt q).ncard ∧
      F.IsLeavingCentre u q ∧ F.IsLeavingCentre u' q ∧ ∃ θ₁ θ₂, F.BothKind q θ₁ θ₂ := by
  sorry

end ArcMap

end HadwigerNelson.Plane
