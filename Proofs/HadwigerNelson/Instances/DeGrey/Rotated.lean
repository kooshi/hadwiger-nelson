import Proofs.HadwigerNelson.Instances.DeGrey.Rotation

/-!
# de Grey's graph, with the second copy written as a rotation

`Instances/DeGrey/Rotation.lean` holds the rotation itself and the 791 coordinate identities the
kernel checks. This module is everything that follows from them, and it is **deliberately a separate
module**: Lake's traces are content-based, so a word changed here would otherwise re-run those 791
identities — 86 seconds — on every edit. Same discipline as `Sat/Diagnose.lean` and
`PackedDiagnose.lean`, one milestone down.
-/

set_option maxRecDepth 1000000
set_option maxHeartbeats 4000000

namespace HadwigerNelson

/-- de Grey's edge list, with the second half **written as the rotation of the first** rather than
listed. The same 7877 pairs as `deGrey.edges`, up to the orientation of the mapped ones. -/
def deGreyRotEdges : List (Fin 1581 × Fin 1581) :=
  deGreyHalfAEdges ++ deGreyHalfAEdges.map (fun e => (deGreyPhi e.1, deGreyPhi e.2)) ++
    deGreyCrossEdge

/-- de Grey's certificate, with the second copy derived. Same points, same denominator; only the
edge list is written differently. -/
def deGreyRot : UDCert 1581 where
  verts := deGreyTable.toVerts
  edges := deGreyRotEdges
  denom := 768

/-- **Every listed edge is exactly one unit long.** The first half and the joining edge are segments
of `deGrey.edges` and inherit `deGrey_valid`; the middle segment is *derived* — the rotation carries
each first-half edge's exact unit length onto its image, and no new distance is computed. -/
theorem deGreyRot_valid : deGreyRot.Valid = true := sorry

/-- **The rotated half sits inside the graph, as edges.** What `Gadget.transport` consumes: the
membership is by construction, and the distinctness is the index map's injectivity. -/
theorem deGreyRot_adj_map : ∀ e ∈ deGreyHalfAEdges,
    (edgeGraph 1581 deGreyRotEdges).Adj (deGreyPhi e.1) (deGreyPhi e.2) := sorry

/-- The first half sits inside the graph. -/
theorem deGreyRot_halfA_subset : deGreyHalfAEdges ⊆ deGreyRotEdges := sorry

/-- The joining edge sits inside the graph. -/
theorem deGreyRot_cross_mem : ((11 : Fin 1581), (802 : Fin 1581)) ∈ deGreyRotEdges := sorry

/-! ## Spec

The rotation is only de Grey's construction if it lands on the vertices it is supposed to. These pin
that, and they run compiled on every build. -/

section Spec

-- The rotation centre is vertex 14, and it is its own image.
#guard deGreyPhiNat 14 = 14

-- The joining edge's ends are partners: vertex 11 in the first copy, vertex 802 in the second.
#guard deGreyPhiNat 11 = 802

-- The map is onto the second copy: `{14} ∪ [791, 1580]`.
#guard ((List.range 791).map deGreyPhiNat).eraseDups.length = 791
#guard ((List.range 791).map deGreyPhiNat).all fun j => j = 14 || (791 ≤ j && j < 1581)

-- Same graph as `deGrey`, not a different one: 7877 edges, and the same set once orientations are
-- normalised. `deGrey.edges` is emitted with `e.1 < e.2` throughout; the mapped half is not, since
-- the index map need not preserve order.
#guard deGreyRotEdges.length = 7877
#guard (deGreyRotEdges.map fun e => (min e.1 e.2, max e.1 e.2)).eraseDups.length = 7877

end Spec

end HadwigerNelson
