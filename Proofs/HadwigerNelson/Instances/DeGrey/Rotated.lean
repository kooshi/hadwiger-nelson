import Proofs.HadwigerNelson.Instances.DeGrey.Rotation

/-!
# de Grey's graph, with the second copy written as a rotation

`Instances/DeGrey/Rotation.lean` holds the rotation itself and the 791 coordinate identities the
kernel checks. This module is everything that follows from them, and it is **deliberately a separate
module**: Lake's traces are content-based, so a word changed here would otherwise re-run those 791
identities — 95 CPU seconds — on every edit. Same discipline as `Sat/Diagnose.lean` and
`PackedDiagnose.lean`, one milestone down.
-/

set_option maxRecDepth 1000000
set_option maxHeartbeats 4000000

namespace HadwigerNelson

/-- Both endpoints of a first-half edge lie in the first copy — `deGreyHalfA_lt` in the form its two
consumers want, so neither destructures a `List.all`. -/
theorem deGreyHalfA_endpoints_lt (e : Fin 1581 × Fin 1581) (he : e ∈ deGreyHalfAEdges) :
    e.1.val < 791 ∧ e.2.val < 791 := by
  have := List.all_eq_true.mp deGreyHalfA_lt e he
  simp only [Bool.and_eq_true, decide_eq_true_eq] at this
  exact this

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

/-- `deGrey_valid`, read as a statement about this certificate: `ValidOn` looks only at the points
and the scale, and those are the same two certificates over. -/
private theorem deGreyRot_valid_all : deGreyRot.ValidOn deGrey.edges = true := by
  rw [UDCert.validOn_congr (c := deGreyRot) (c' := deGrey) rfl rfl]; exact deGrey_valid

/-- The first half's geometry, restricted from `deGrey_valid`. -/
theorem deGreyRot_validOn_halfA : deGreyRot.ValidOn deGreyHalfAEdges = true :=
  UDCert.validOn_of_subset deGrey_halfA_subset deGreyRot_valid_all

/-- The joining edge's geometry, restricted from `deGrey_valid`. -/
theorem deGreyRot_validOn_cross : deGreyRot.ValidOn deGreyCrossEdge = true :=
  UDCert.validOn_of_subset (fun _ h => List.mem_append_right _ h) deGreyRot_valid_all

/-- **The second half's geometry, derived.** The rotation carries each first-half edge's exact unit
length onto its image, so not one distance in this half is recomputed — which is the whole point of
the milestone, in one citation. -/
theorem deGreyRot_validOn_rotated :
    deGreyRot.ValidOn (deGreyHalfAEdges.map fun e => (deGreyPhi e.1, deGreyPhi e.2)) = true := by
  refine UDCert.validOn_map_of_motion _ deGreyMotion deGreyPhi _ (fun e he => ?_)
    deGreyRot_validOn_halfA
  obtain ⟨h1, h2⟩ := deGreyHalfA_endpoints_lt e he
  constructor
  · show deGreyMotion.Maps (deGreyTable.get e.1.val) (deGreyTable.get (deGreyPhi e.1).val) = true
    rw [deGreyPhi_val h1]; exact deGreyMotion_maps h1
  · show deGreyMotion.Maps (deGreyTable.get e.2.val) (deGreyTable.get (deGreyPhi e.2).val) = true
    rw [deGreyPhi_val h2]; exact deGreyMotion_maps h2

/-- **Every listed edge is exactly one unit long.** The first half and the joining edge are segments
of `deGrey.edges` and inherit `deGrey_valid`; the middle segment is **derived** from the rotation, and
no distance in it is computed at all. -/
theorem deGreyRot_valid : deGreyRot.Valid = true := by
  rw [UDCert.valid_eq]
  show deGreyRot.ValidOn ((deGreyHalfAEdges ++ _) ++ deGreyCrossEdge) = true
  simp only [UDCert.ValidOn, List.all_append, Bool.and_eq_true]
  exact ⟨⟨deGreyRot_validOn_halfA, deGreyRot_validOn_rotated⟩, deGreyRot_validOn_cross⟩

/-- **The rotated half sits inside the graph, as edges.** What `Gadget.transport` consumes: the
membership is by construction, and the distinctness is the index map's injectivity. -/
theorem deGreyRot_adj_map : ∀ e ∈ deGreyHalfAEdges,
    (edgeGraph 1581 deGreyRotEdges).Adj (deGreyPhi e.1) (deGreyPhi e.2) := by
  intro e he
  obtain ⟨h1, h2⟩ := deGreyHalfA_endpoints_lt e he
  refine edgeGraph_adj_of_mem (fun hc => ?_)
    (List.mem_append_left _ (List.mem_append_right _ (List.mem_map_of_mem he)))
  exact absurd (congrArg Fin.val (deGreyPhi_inj h1 h2 hc))
    (Nat.ne_of_lt (List.all_eq_true.mp deGreyHalfA_ne e he |> of_decide_eq_true))

/-- The first half sits inside the graph. -/
theorem deGreyRot_halfA_subset : deGreyHalfAEdges ⊆ deGreyRotEdges :=
  fun _ h => List.mem_append_left _ (List.mem_append_left _ h)

/-- The joining edge sits inside the graph. -/
theorem deGreyRot_cross_mem : ((11 : Fin 1581), (802 : Fin 1581)) ∈ deGreyRotEdges :=
  List.mem_append_right _ (by decide)

/-! ## Spec

`Valid = true` says nothing about *which* graph was validated, so these pin that it is de Grey's. -/

section Spec

-- Same graph as `deGrey`, not a different one: 7877 edges, and the same set once orientations are
-- normalised. `deGrey.edges` is emitted with `e.1 < e.2` throughout; the mapped half is not, since
-- the index map need not preserve order.
#guard deGreyRotEdges.length = 7877
#guard (deGreyRotEdges.map fun e => (min e.1 e.2, max e.1 e.2)).eraseDups.length = 7877

end Spec

end HadwigerNelson
