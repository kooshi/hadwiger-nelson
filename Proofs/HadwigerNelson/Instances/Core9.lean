import Proofs.HadwigerNelson.PairDist
import Proofs.HadwigerNelson.Pigeonhole

/-!
# The nine-point √3-pair pigeonhole (M34, from the M33 annex)

**Every proper 4-colouring of these nine points of the plane makes one of the six listed
√3-pairs monochromatic** — and therefore no proper 4-colouring of the plane avoids
monochromatic √3-pairs at all.

The nine points are two √3-side equilateral triangles, their unit circumcentres, a hub seeing
both centres and two rim members of each triangle, and one rim–rim unit edge. The kernel
checks: the thirteen unit distances (the edges properness respects), the six √3 distances
(the pairs the conclusion names), the completeness of the pair list (no √3-pair among the
nine is unlisted), and the forcing itself — two transmuter instances composed through one
edge, no search.

**Attribution** (M34 §0 B4): the plane-level compulsion is classical folklore — the
virtual-edge distance of the spindle literature; de Grey's paper argues the monochromatic
√3-*triple* form. What is new is the carrier, not the compulsion: this nine-vertex 1-minimal
core was found by instrument inside de Grey's 1581-point graph (M33 §R annex), and this is,
to our knowledge, the first kernel-checked formalization of the compulsion.

**Not checked, and not claimed**: that these nine points are M33's core members — provenance
is a generator property, controlled tools-side by exact re-derivation; the theorem is about
the points as written. (They are, for the record, de Grey vertices 791, 793, 794, 868, 995,
1186, 1187, 1262, 1390 — see the id table below.)
-/

namespace HadwigerNelson

open SimpleGraph

-- dense id <-> de Grey object id (tools-side identification, not a theorem):
--   0 <-> 791   (the hub)
--   1 <-> 793   (circumcentre of triangle one)
--   2 <-> 794   (rim, pinned by the transfer; unit edge to 6)
--   3 <-> 868   (rim)
--   4 <-> 995   (rim)
--   5 <-> 1186  (circumcentre of triangle two)
--   6 <-> 1187  (rim, pinned; unit edge to 2)
--   7 <-> 1262  (rim)
--   8 <-> 1390  (rim)

/-- The nine vertices, coordinates exact in `ℚ(√3,√5,√7,√11)` and scaled by `512` so every
leaf is an integer. Emitted by `build/m34-design.py --emit-core9` (untrusted); the kernel
re-decides every distance below. -/
def core9Table : PtTable :=
  (PtTable.node 4 (PtTable.node 2 (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨(-32),0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨96,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.leaf ⟨⟨⟨⟨⟨(-280),0⟩,⟨0,0⟩⟩,⟨⟨0,24⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-248)⟩,⟨0,0⟩⟩,⟨⟨72,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩)) (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨(-528),0⟩,⟨0,0⟩⟩,⟨⟨0,48⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-496)⟩,⟨0,0⟩⟩,⟨⟨48,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.leaf ⟨⟨⟨⟨⟨(-528),0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨48,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩))) (PtTable.node 2 (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨216,0⟩,⟨0,0⟩⟩,⟨⟨0,24⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-248)⟩,⟨0,0⟩⟩,⟨⟨120,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.leaf ⟨⟨⟨⟨⟨(-249),0⟩,⟨93,0⟩⟩,⟨⟨0,21⟩,⟨0,3⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-217)⟩,⟨0,(-31)⟩⟩,⟨⟨75,0⟩,⟨9,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩)) (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨(-466),0⟩,⟨186,0⟩⟩,⟨⟨0,42⟩,⟨0,6⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-434)⟩,⟨0,(-62)⟩⟩,⟨⟨54,0⟩,⟨18,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨(-466),0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,6⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,0⟩,⟨0,(-62)⟩⟩,⟨⟨54,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.leaf ⟨⟨⟨⟨⟨185,0⟩,⟨93,0⟩⟩,⟨⟨0,21⟩,⟨0,(-3)⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-217)⟩,⟨0,31⟩⟩,⟨⟨117,0⟩,⟨9,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩)))))

/-- The thirteen claimed unit-distance pairs: hub–centres, hub–rims, centre–triangles, and
the rim–rim edge `(2, 6)` the contradiction closes on. -/
def core9Edges : List (Fin 9 × Fin 9) :=
  [(0,1), (0,3), (0,4), (0,5), (0,7), (0,8), (1,2), (1,3), (1,4), (2,6), (5,6), (5,7), (5,8)]

/-- The six claimed √3-pairs: the two triangles, pairwise. -/
def core9Pairs : List (Fin 9 × Fin 9) :=
  [(2,3), (2,4), (3,4), (6,7), (6,8), (7,8)]

/-- The certificate. -/
def core9 : UDCert 9 where
  verts := core9Table.toVerts
  edges := core9Edges
  denom := 512

/-- Every listed edge has exact squared distance `512²`. Kernel-checked. -/
theorem core9_valid : core9.Valid = true := by decide +kernel

/-- Every listed pair has exact squared distance `3 · 512²` — real distance `√3`.
Kernel-checked. -/
theorem core9_pairs_dist : core9.PairsAt core9Pairs 3 = true := by decide +kernel

/-- **Completeness of the pair list**: any two of the nine points at exact squared distance
`3` are a listed pair. The pigeonhole theorem does not depend on this; it pins the
interpretation — `core9Pairs` is the whole √3 class on these points, not a curated sublist.
Kernel-checked over all 81 ordered pairs. -/
theorem core9_pairs_complete :
    ∀ i j : Fin 9, (core9.verts i).distSq (core9.verts j) = ((3 * (512 * 512) : ℤ) : Q4) →
      (i, j) ∈ core9Pairs ∨ (j, i) ∈ core9Pairs := by
  decide +kernel

/-! ### Shape pins and controls — compiled, every build -/

#guard core9Edges.length = 13
#guard core9Pairs.length = 6
#guard core9Edges.eraseDups.length = 13
#guard core9Pairs.eraseDups.length = 6
#guard core9Edges.all fun e => e.1 < e.2
#guard core9Pairs.all fun p => p.1 < p.2
#guard core9.denom = 512

-- The compiled cross-check: `badEdges` is the compiler's independent evaluation of the same
-- predicate `core9_valid` settles by kernel reduction.
#guard core9.badEdges.isEmpty

-- The adversarial member: move the hub to the origin and both checks must fail, the edge
-- check naming only edges at the hub. Without this, `Valid = true` could be vacuous.
#guard !(({ core9 with verts := fun i => if i = 0 then ⟨0, 0⟩ else core9.verts i } :
  UDCert 9)).badEdges.isEmpty
#guard (({ core9 with verts := fun i => if i = 0 then ⟨0, 0⟩ else core9.verts i } :
  UDCert 9)).badEdges.all fun be => be.1.1 = 0 ∨ be.1.2 = 0
#guard ({ core9 with verts := fun i => if i = 2 then ⟨0, 0⟩ else core9.verts i } :
  UDCert 9).PairsAt core9Pairs 3 = false

/-! ### The pigeonhole -/

/-- **The nine-point pigeonhole.** Every proper 4-colouring of the nine points (properness
over the thirteen listed unit edges) makes some listed √3-pair monochromatic. The proof is
the transmuter twice — each triangle, forced rainbow by avoidance, pins the hub to its
transfer rim's colour — composed through the rim–rim edge `(2, 6)`: no search, no solver. -/
theorem core9_pigeonhole (C : (edgeGraph 9 core9Edges).Coloring (Fin 4)) :
    MonoPair core9Pairs C := by
  by_contra hno
  rw [not_monoPair_iff] at hno
  -- the six avoidance facts: both triangles pairwise polychromatic
  have p23 : C 2 ≠ C 3 := hno (2, 3) (by decide)
  have p24 : C 2 ≠ C 4 := hno (2, 4) (by decide)
  have p34 : C 3 ≠ C 4 := hno (3, 4) (by decide)
  have p67 : C 6 ≠ C 7 := hno (6, 7) (by decide)
  have p68 : C 6 ≠ C 8 := hno (6, 8) (by decide)
  have p78 : C 7 ≠ C 8 := hno (7, 8) (by decide)
  -- the twelve properness facts the two transmuters consume
  have e01 : C 0 ≠ C 1 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e03 : C 0 ≠ C 3 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e04 : C 0 ≠ C 4 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e05 : C 0 ≠ C 5 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e07 : C 0 ≠ C 7 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e08 : C 0 ≠ C 8 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e12 : C 1 ≠ C 2 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e13 : C 1 ≠ C 3 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e14 : C 1 ≠ C 4 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e56 : C 5 ≠ C 6 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e57 : C 5 ≠ C 7 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  have e58 : C 5 ≠ C 8 := C.valid (edgeGraph_adj_of_mem (by decide) (by decide))
  -- triangle one pins the hub to rim 2's colour, across plane distance exactly 2
  have t₁ : C 0 = C 2 := transmuter e12 e13 e14 e01 e03 e04 p23 p24 p34
  -- triangle two pins the hub to rim 6's colour, across plane distance exactly 2
  have t₂ : C 0 = C 6 := transmuter e56 e57 e58 e05 e07 e08 p67 p68 p78
  -- the rim–rim unit edge refuses the composed transfer
  exact C.valid (edgeGraph_adj_of_mem (i := 2) (j := 6) (by decide) (by decide)) (t₁ ▸ t₂)

/-! ### The plane corollary -/

/-- **No proper 4-colouring of the plane avoids monochromatic √3-pairs.** Classical folklore
(the spindle literature's virtual-edge distance; de Grey argues the triple form) — what is
new is the carrier, not the compulsion: a nine-point 1-minimal witness, kernel-checked end to
end. The witnesses are two of the nine certified points. -/
theorem core9_plane (C : (unitDistance ℂ).Coloring (Fin 4)) :
    ∃ x y : ℂ, dist x y = Real.sqrt 3 ∧ C x = C y := by
  have hunit := core9.valid_sound (by decide) core9_valid
  have hvalid : ∀ {i j : Fin 9}, (edgeGraph 9 core9Edges).Adj i j →
      C (core9.point i) ≠ C (core9.point j) := by
    rintro i j ⟨hne, hm | hm⟩
    · exact C.valid (unitDistance_adj.mpr (hunit (i, j) hm))
    · exact C.valid (unitDistance_adj.mpr (by rw [dist_comm]; exact hunit (j, i) hm))
  obtain ⟨p, hp, heq⟩ := core9_pigeonhole (Coloring.mk (fun i => C (core9.point i)) hvalid)
  refine ⟨core9.point p.1, core9.point p.2, ?_, heq⟩
  have h := core9.pairsAt_sound (by decide) core9_pairs_dist p hp
  rwa [show ((3 : ℤ) : ℝ) = 3 by norm_num] at h

end HadwigerNelson
