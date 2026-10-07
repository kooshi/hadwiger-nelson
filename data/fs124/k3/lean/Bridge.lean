import Proofs.HadwigerNelson.Plane.SectorPoint
import Proofs.HadwigerNelson.Plane.ThreeArcs

/-! FS124-K3: the proof of `ThreePiece.IsSector.hasArcEdges` over `IsTriodCut.exists_arc`, checked as an `example`
(the theorem itself is in `Plane/SectorPoint.lean`, the implementer's file while FS124-I4 runs). -/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric Topology

variable {α : Type*} {U : Set ℂ} {c : ℂ → α} {x : ℂ}

/-- The data of a sector point is a cut disc in three pieces, field for field. -/
example {D : ThreePiece U c x} (h : D.IsSector) : ∃ r J, IsTriodCut x r J D.piece := by
  obtain ⟨r, hr, J, h1, h2, h3, h4, h5, -, h7⟩ := h
  exact ⟨r, J, ⟨hr, h1, h2, h3, h4, h5⟩, D.isOpen_piece, D.isPreconnected_piece, fun _ _ hab => D.disjoint_piece hab, h7⟩

/-- **The leaf**, over `IsTriodCut.exists_arc`. -/
example {D : ThreePiece U c x} (h : D.IsSector) : D.HasArcEdges := by
  obtain ⟨r, hr, J, h1, h2, h3, h4, h5, -, h7⟩ := h
  exact fun i j hij => IsTriodCut.exists_arc ⟨⟨hr, h1, h2, h3, h4, h5⟩, D.isOpen_piece, D.isPreconnected_piece,
    fun _ _ hab => D.disjoint_piece hab, h7⟩ D.nbhd_mem hij

#print axioms IsTriod.not_mem_closure_both_sides
#print axioms isPreconnected_inter_of_union_eq_closedBall
#print axioms isPreconnected_inter_halves
#print axioms IsTriodCut.exists_arc

end HadwigerNelson.Plane
