import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps

/-!
# FS112-N3-COR3: a close complementary pair sits on a rhombus of four-colour leaving centres

Wave 5's `cor3`, moved here verbatim from `Plane/ValidMap/Dense` (statement, docstring and proof; inventory item 299 (a), job FS131-I5e) so that
`Plane/ValidMap/HexRing`'s N2-ROT (`rot_noThird`, whose hand proof rests on it) can cite it: every name its statement uses is upstream of `HexRing`
(`IsCubicTrichromatic`, `BothKind` in `Plane/ValidMap/Basic`, `IsLeavingCentre` in `Plane/ValidMap/BaseSteps`, `Covers`, `Valid`, `coloursAt` in
`Plane/ArcMap`). Row: **FS112-N3-COR3** (`cor3`, over its local form `cor3_local`, inventory item 218 (b)).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

/-! ## FS112-N3-COR3 -/

/-- **FS112-N3-COR3, local form** (inventory item 218 (b): "`cor3_local`, reading small discs only"; item 299 (c)): `cor3`'s conclusion
with its two covering hypotheses `Covers u 1`, `Covers u′ 1` replaced by what N3-COR3's argument (`plans/FS112-NB3-verification.md` § 1.4) reads —
`u`, `u′` and the two common unit points in the domain, which is open, so each with a small disc about it: the strips at the crossings `w₀, w₀′`
(NB3-FAIL at `w`; `fail_leavingCentre` and `fail_colours` read only `u ∈ F.dom`, the chart at `u` and the map near `w`), the arcs of `ω(w)` ending at
`u`, `u′` (inside the charts there), and N112-U1 at `w` (`ringArc_cone_outer`, which reads no covering). `cor3` is its instance. The form the base
reads at a centre `p ∈ B̄(u, 1)` and a point `x ∈ ω(p)`, where `B̄(x, 1)` need not lie in the base's `B̄(u, 2)` (`pseudo_ncard_le_two_of_baseHyp`). Six
colours are spent. No inhabitant: a valid fragment with such a pair is FS112-STOP's object; `GENERIC`, as `cor3`. -/
theorem cor3_local {F : ArcMap 6} (hF : F.Valid) {u u' : ℂ} (hu : F.IsCubicTrichromatic u) (hu' : F.IsCubicTrichromatic u')
    (hud : u ∈ F.dom) (hud' : u' ∈ F.dom) (hq : ∀ q, dist q u = 1 → dist q u' = 1 → q ∈ F.dom)
    (hdis : Disjoint (F.coloursAt u) (F.coloursAt u')) (hd : dist u u' < 2) :
    ∃ qp qm : ℂ, qp ≠ qm ∧ ∀ q ∈ ({qp, qm} : Set ℂ), dist q u = 1 ∧ dist q u' = 1 ∧ 4 ≤ (F.coloursAt q).ncard ∧
      F.IsLeavingCentre u q ∧ F.IsLeavingCentre u' q ∧ ∃ θ₁ θ₂, F.BothKind q θ₁ θ₂ := by
  sorry

/-- **FS112-N3-COR3**: in a valid six-coloured map, a close complementary pair of cubic trichromatic vertices `u, u′` (disjoint
multicolours, `|u − u′| < 2`) sits on a unit rhombus `u, qp, u′, qm` whose other corners carry at least four colours, each a leaving
centre of both `u` and `u′` and the centre of a both-kind unit arc ("T2 is forced at both common unit points"). Stated for fragments
covering `B̄(u, 1)` and `B̄(u′, 1)` (the class the argument reads: the strips at `q±` and the arcs at `u`, `u′`) — a widening of "in a
valid map", reported. Six colours are spent ("the complement of `c(u′)` is `c(u)`"). No inhabitant: a valid fragment with such a pair is
FS112-STOP's object (the strip's printed colouring violates it); `GENERIC`. -/
theorem cor3 {F : ArcMap 6} (hF : F.Valid) {u u' : ℂ} (hu : F.IsCubicTrichromatic u) (hu' : F.IsCubicTrichromatic u')
    (hcu : F.Covers u 1) (hcu' : F.Covers u' 1) (hdis : Disjoint (F.coloursAt u) (F.coloursAt u')) (hd : dist u u' < 2) :
    ∃ qp qm : ℂ, qp ≠ qm ∧ ∀ q ∈ ({qp, qm} : Set ℂ), dist q u = 1 ∧ dist q u' = 1 ∧ 4 ≤ (F.coloursAt q).ncard ∧
      F.IsLeavingCentre u q ∧ F.IsLeavingCentre u' q ∧ ∃ θ₁ θ₂, F.BothKind q θ₁ θ₂ :=
  cor3_local hF hu hu' (hcu (mem_closedBall_self zero_le_one)) (hcu' (mem_closedBall_self zero_le_one))
    (fun _ hq _ => hcu (by rw [mem_closedBall, hq])) hdis hd

end ArcMap

end HadwigerNelson.Plane
