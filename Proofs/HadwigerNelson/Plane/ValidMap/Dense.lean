import Proofs.HadwigerNelson.Plane.ValidMap.Terminal

/-!
# Density: discs of radius 1 and 3, row 134's base with unit arcs, a four-colour vertex in every valid map

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 3). Rows: **FS129-SR2-DISC1TS** with FS112-DISC1 merged (`disc1ts`,
`disc1ts_degree`; the fragment form FS129-OR1-LOCALDENSE reads, `disc1_local`), **FS112-N3-COR3** (`cor3`), **FS112-N3-BASE**
(`n3_base`), **FS129-OR1-LOCALDENSE** (`localDense`), **FS112-N3-DENSE3** (`dense3`), **FS114-CV-EXISTS** (`cv_exists`), and the
seven-colour control of `Row134BaseUA` (`not_row134BaseUA_seven`). `Row134BaseUA` (the foundation, `Plane/ValidMap/Chain`) is wave 5's
intermediate statement of the base, proved here as `row134BaseUA` (FS112-N3-BASE's walk; inventory item 197). Still to be stated by the successor planner: FS112-ROTHEX, FS114-BV-HEX, FS114-CVB-THOM (plan § 5).
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

/-! ## FS112-N3-BASE, FS129-OR1-LOCALDENSE, FS112-N3-DENSE3 -/

/-- **The walk's assembly: row 134's base with unit arcs** (`Row134BaseUA`; FS112-N3-BASE's table, `plans/FS112-N-proof.md` stage N3-3,
NB3 § 1.4 steps 1–12): CB's route with CE's repairs, CUSP-BASE, S–V Lemmas 3–6, Props. 10, 17–19 and Cor. 3, each use of Condition 5
replaced by a walked step (`pair_P'`, `pair_i`, `pair_ii`, `fail_leavingCentre`, `fail_colours`, `anti`, `noBoth`, `cor3`, the ring lemmas
of FS112-ROTHEX, FS114-BV-HEX). **Its hypotheses are owed** (inventory item 197; plan § 5.1): the pieces of `[SokolovVoronov2025]` the walk
uses by statement, as named outside `Prop`s — added here by the successor planner, and then carried by `n3_base`, `localDense`, `dense3`,
`cv_exists`. A refutation's engine: no model expected (`not_row134BaseUA_seven` shows six colours are spent). -/
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

/-! ## The seven-colour control: `Row134BaseUA` spends six colours -/

/-- **`Row134BaseUA`'s seven-colour form is false**: the seven-brick map's corner `0` is a cubic trichromatic vertex of a valid
seven-coloured map of the plane with no point of `F(M) ∪ R(M)` in `B̄(0, 2)` and no unit arc anywhere. So the base's six colours are
load-bearing, and the hypothesis is not true for a reason that ignores the colour count. -/
theorem not_row134BaseUA_seven :
    ¬ ∀ (F : ArcMap 7) (u : ℂ), F.Valid → F.Covers u 2 → F.IsCubicTrichromatic u → F.BaseHyp u → F.NoInertNear u → False := by
  sorry

end HadwigerNelson.Plane
