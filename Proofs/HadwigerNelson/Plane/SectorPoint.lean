import Proofs.HadwigerNelson.Plane.ClosePair

/-!
# The claim list's sector point, and the bridge to arc edges (FS-124, second module; the θ-lemma is owed)

`data/fs124/claims-K2.md`: a three-piece point "is a sector point if for some r > 0 there are three arcs J_0, J_1,
J_2 (homeomorphic images of [0, 1]) from x to the circle ∂B(x, r), inside B(x, r) but for their far ends and disjoint
but for x, such that the three components of B(x, r) ∖ (J_0 ∪ J_1 ∪ J_2) are the pieces."

* `ThreePiece.IsSector` — that definition, for a decomposition.
* `ThreePiece.IsSector.hasArcEdges` — **the θ-lemma, a leaf of this module that no plan of FS124-K2 covers**: at a
  sector point every edge contains an arc from the point (an initial part of one of the three arcs). It is the
  θ-curve fact of plane topology — each of three arcs from the centre of a disc to its rim borders exactly two of the
  three complementary components, and every two components share one. Mathlib holds no Jordan curve theorem; this
  library's `Plane/PlaneTopology` holds unicoherence and the crossing of continua in a disc. Owed as a kernel job of
  its own (`plans/FS124-kernel-plan-2.md` § the sector clause; the coordinator's ruling of 2026-10-07).
* `closePair_both_saved_of_isSector` — **C124-BOTH's second clause in the claim list's own words**, over that leaf and
  `closePair_both_saved` (`Plane/ClosePair`), which is stated for arc-edged decompositions and does not read this module.
  "A sector point is full" (`ThreePiece.IsSector.isFull`) is over the same leaf.

**Inhabitant**: `sectorPoint_isSector` — the ordinary three-sector point of `Plane/ThreePiece` is a sector point, its
three arcs the radii along `1`, `i`, `−1 − i`. `exists_closePair_sector` — a close complementary pair of sector
points of a weak six-colouring, with a common unit point in the set (the hypotheses of `closePair_both_saved_of_isSector`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric Topology

variable {α : Type*}

namespace ThreePiece

variable {U : Set ℂ} {c : ℂ → α} {x : ℂ}

/-- The decomposition is that of a **sector point**: "for some r > 0 there are three arcs J_0, J_1, J_2 (homeomorphic
images of [0, 1]) from x to the circle ∂B(x, r), inside B(x, r) but for their far ends and disjoint but for x, such
that the three components of B(x, r) ∖ (J_0 ∪ J_1 ∪ J_2) are the pieces". An arc is an injective continuous map of
`[0, 1]`; that the three components are the pieces is said as: each piece is a component, and the pieces fill the
complement. -/
def IsSector (D : ThreePiece U c x) : Prop :=
  ∃ r > 0, ∃ J : Fin 3 → C(unitInterval, ℂ),
    (∀ m, Function.Injective (J m)) ∧ (∀ m, J m 0 = x) ∧ (∀ m, dist (J m 1) x = r) ∧
      (∀ m t, t ≠ 1 → dist (J m t) x < r) ∧
      (∀ m m' s t, m ≠ m' → J m s = J m' t → J m s = x) ∧
      (∀ i, ∃ z ∈ D.piece i, D.piece i = connectedComponentIn (ball x r \ ⋃ m, range (J m)) z) ∧
      ⋃ i, D.piece i = ball x r \ ⋃ m, range (J m)

/-- **The θ-lemma** (plane topology; owed as a kernel job of its own): at a sector point every edge contains an arc
from the point. -/
theorem IsSector.hasArcEdges {D : ThreePiece U c x} (h : D.IsSector) : D.HasArcEdges := by
  sorry

/-- "A sector point is full" (over the θ-lemma). -/
theorem IsSector.isFull {D : ThreePiece U c x} (h : D.IsSector) : D.IsFull :=
  h.hasArcEdges.isFull

end ThreePiece

/-- **Inhabitant**: the ordinary three-sector point is a sector point — its three arcs are the radii along `1`, `i`
and `−1 − i`. -/
theorem sectorPoint_isSector : sectorPoint.IsSector := by
  sorry

/-- **C124-BOTH**, second clause, in the claim list's words (`data/fs124/claims-K2.md`): "If they are sector points,
each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close
complementary pair of sector points is saved by one member alone." Over the θ-lemma
(`ThreePiece.IsSector.hasArcEdges`) and `closePair_both_saved`. Inhabitant of the hypotheses: `exists_closePair_sector`. -/
theorem closePair_both_saved_of_isSector {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c)
    {x y w : ℂ} (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w)
    (hsx : C.left.IsSector) (hsy : C.right.IsSector) : C.left.Saves w ∧ C.right.Saves w :=
  closePair_both_saved hU hc C hw hwu hsx.hasArcEdges hsy.hasArcEdges

/-- **Inhabitant of the hypotheses of `closePair_both_saved_of_isSector`**: a weak six-colouring of an open set with a close
complementary pair of sector points and a common unit point in the set. -/
theorem exists_closePair_sector :
    ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ C.left.IsSector ∧
        C.right.IsSector := by
  sorry

end HadwigerNelson.Plane
