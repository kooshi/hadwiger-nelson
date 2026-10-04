import Proofs.HadwigerNelson.Plane.ValidMap.Terminal
import Proofs.HadwigerNelson.Plane.ValidMap.HexRing

/-!
# Density: discs of radius 1 and 3, row 134's base with unit arcs, a four-colour vertex in every valid map

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 3). Rows: **FS129-SR2-DISC1TS** with FS112-DISC1 merged (`disc1ts`,
`disc1ts_degree`; the fragment form FS129-OR1-LOCALDENSE reads, `disc1_local`), **FS112-N3-COR3** (`cor3`), **FS112-N3-BASE**
(`n3_base`), **FS129-OR1-LOCALDENSE** (`localDense`), **FS112-N3-DENSE3** (`dense3`), **FS114-CV-EXISTS** (`cv_exists`), and the
seven-colour control of `Row134BaseUA` (`not_row134BaseUA_seven`). `Row134BaseUA` (the foundation, `Plane/ValidMap/Chain`) is wave 5's
intermediate statement of the base; `row134BaseUA` and its four consumers moved to `Plane/ValidMap/BaseDense`, downstream of the walk's leaves
(`Plane/ValidMap/BaseWalk`, job FS131-KB). FS112-ROTHEX and FS114-BV-HEX, which the walk reads, are stated in `Plane/ValidMap/HexRing`; FS114-CVB-THOM in `Plane/ValidMap/MapGraph` (plan § 8).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS129-SR2-DISC1TS (FS112-DISC1 merged) -/

/-- **FS129-SR2-DISC1TS**, chromaticity form: every closed disc of radius `1` of a valid map of the plane holds a point of at least
three colours — FS106-TS-T's `1/√2 + ε < 1` (`ts_t`). Stronger than FS112-DISC1's "a vertex of degree at least 3" (`disc1ts_degree`).
Inhabitant: `sevenBrickMap` (valid, of the plane). -/
theorem disc1ts (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) : ∃ y ∈ closedBall x 1, 3 ≤ (F.coloursAt y).ncard := by
  sorry

/-- **FS112-DISC1** as FS129-SR2-DISC1TS states it: every closed disc of radius `1` of a valid map of the plane contains a vertex of
degree at least `3`. -/
theorem disc1ts_degree (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) :
    ∃ y ∈ closedBall x 1, ∃ n, 3 ≤ n ∧ F.HasDegree y n := by
  sorry

/-- **FS112-DISC1 on a fragment** (FS129-OR1-LOCALDENSE's use: "read on a fragment: its argument nests tiles surrounding `x`, each of
diameter at most 1 and so inside `B̄(x, 1)`"): a valid fragment covering `B̄(x, 1)` has a point of at least three colours in `B̄(x, 1)`.
A supporting lemma (the merged row read at the class LOCALDENSE's argument reads). Inhabitant: `sevenBrickMap`. -/
theorem disc1_local (hF : F.Valid) {x : ℂ} (hx : F.Covers x 1) : ∃ y ∈ closedBall x 1, 3 ≤ (F.coloursAt y).ncard := by
  sorry

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

/-! ## The seven-colour control: `Row134BaseUA` spends six colours -/

/-- **`Row134BaseUA`'s seven-colour form is false**: the seven-brick map's corner `0` is a cubic trichromatic vertex of a valid
seven-coloured map of the plane with no point of `F(M) ∪ R(M)` in `B̄(0, 2)` and no unit arc anywhere. So the base's six colours are
load-bearing, and the hypothesis is not true for a reason that ignores the colour count. -/
theorem not_row134BaseUA_seven :
    ¬ ∀ (F : ArcMap 7) (u : ℂ), F.Valid → F.Covers u 2 → F.IsCubicTrichromatic u → F.BaseHyp u → F.NoInertNear u → False := by
  sorry

end HadwigerNelson.Plane
