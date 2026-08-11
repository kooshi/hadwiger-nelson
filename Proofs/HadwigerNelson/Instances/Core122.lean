import Proofs.HadwigerNelson.Instances.Core122.Cnf.Cert
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.PairDist
import Proofs.HadwigerNelson.Pigeonhole

/-!
# The 122-point distance-2 pigeonhole (M34, from the M33 core)

**Every proper 4-colouring of these 122 points of the plane makes one of the forty listed
distance-2 pairs monochromatic** — and therefore no proper 4-colouring of the plane avoids
monochromatic distance-2 pairs at all.

The 122 points are seam-lattice points of the certified hexagram chunk at seam depth 2
(coordinates in `ℚ(√3, √11)`, denominator 12), the 1-minimal core M33's class-avoidance
instrument shrank from the fired chunk. The kernel checks: the 421 unit distances (the edges
properness respects), the forty distance-2 pairs (the pairs the conclusion names), and the
refutation — an LRAT certificate of 7,892 derived clauses replayed step by step through the
mask checker. CaDiCaL proposed the certificate and is trusted for nothing: a wrong
certificate fails a segment check, a wrong clause table fails `core122_agrees`.

**Attribution** (M34 §0 B4): the plane-level compulsion is the pigeonhole shadow of what
Haugland (arXiv:2608.04542, 2026) builds as a forced-EQUAL pair at distance 2 (float + SAT
verified, ~2,000 vertices); what is new is the carrier, not the compulsion — this 122-vertex
1-minimal core, found by instrument inside our own kernel-certified hexagram (M33), and, to
our knowledge, the first kernel-checked formalization of a distance-2 compulsion. Distance 2
is the ρ₁₅ spindle distance (`4·2² − 1 = 15`): killing this pigeonhole is exactly what needs
`√15` — the field wall between the two acts (G16).

**Not checked, and not claimed**: that these points are M33's core members or hexagram chunk
members — provenance is a generator property, controlled tools-side by exact re-derivation;
the theorem is about the points as written. (The id table is a comment in `Aug.lean`.)

## The argument, in one paragraph

Suppose some proper 4-colouring of the 122 points avoided all forty pairs. Then it would be a
proper colouring of the augmented graph (unit edges plus pairs-as-edges — the bridge,
`Pigeonhole.lean`). The vertices 0, 1, 84 are mutually adjacent, so some relabelling of the
colours pins them to 0, 1, 2 — and the pinned formula carries a kernel-checked refutation.
No such colouring exists; some pair goes monochromatic.
-/

namespace HadwigerNelson

open SimpleGraph

/-- The triangle whose colours are named: three mutually unit-adjacent vertices. -/
def core122Ports : Fin 3 → Fin 122 := ![0, 1, 84]

/-- The certificate was filed against the cube pinning that triangle to `0, 1, 2`. -/
private theorem core122_pinCube : pinCube core122Ports ![0, 1, 2] = core122Cube := by decide

/-- **The refutation as a gadget**: no proper 4-colouring of the augmented graph gives the
triangle any relabelling of `(0, 1, 2)` — one certificate covers all `4! = 24` relabellings,
by colour symmetry. -/
def core122Refuted : Gadget 4 122 3 core122Aug core122Ports :=
  Gadget.ofUnsat ![0, 1, 2] (by rw [core122_pinCube]; exact core122_unsat)

/-- **The triangle**: its three edges, each forbidding its ends from agreeing. -/
def core122Triangle : Gadget 4 122 3 core122Aug core122Ports :=
  (Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide))).inter
    ((Gadget.edge 0 2 (edgeGraph_adj_of_mem (by decide) (by decide))).inter
      (Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide) (by decide))))

/-- The refutation and the triangle, composed. `#eval core122Gadgets.survivors` when this
stops refuting. -/
def core122Gadgets : Gadget 4 122 3 core122Aug core122Ports :=
  core122Refuted.inter core122Triangle

set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **The augmented graph is not 4-colourable** — the kernel-checked refutation plus the
triangle's own edges admit no port colouring at all. -/
theorem core122Aug_not_colorable : ¬ (edgeGraph 122 core122Aug).Colorable 4 :=
  not_colorable_of_gadget core122Gadgets (by
    first
    | decide
    | fail "core122Gadgets admits a port colouring, so the augmented graph is not refuted. \
            Run `#eval core122Gadgets.survivors` from a fresh file importing this module.")

/-- Every listed pair has exact squared distance `4 · 12²` — real distance `2`.
Kernel-checked. -/
theorem core122_pairs_dist : core122.PairsAt core122Pairs 4 = true := by decide +kernel

/-! ### Shape pins and controls — compiled, every build -/

#guard core122Edges.length = 421
#guard core122Pairs.length = 40
#guard core122Aug.length = 461
#guard core122Edges.eraseDups.length = 421
#guard core122Pairs.eraseDups.length = 40
#guard core122Aug.eraseDups.length = 461
#guard core122Edges.all fun e => e.1 < e.2
#guard core122Pairs.all fun p => p.1 < p.2
#guard core122.denom = 12

-- The compiled cross-check: `badEdges` is the compiler's independent evaluation of the same
-- predicate `core122_valid` settles by kernel reduction.
#guard core122.badEdges.isEmpty

-- The adversarial member: move vertex 0 to a far point and both checks must fail, the edge
-- check naming only edges at vertex 0. Without this, `Valid = true` could be vacuous.
#guard !(({ core122 with verts := fun i => if i = 0 then ⟨1000, 0⟩ else core122.verts i } :
  UDCert 122)).badEdges.isEmpty
#guard (({ core122 with verts := fun i => if i = 0 then ⟨1000, 0⟩ else core122.verts i } :
  UDCert 122)).badEdges.all fun be => be.1.1 = 0 ∨ be.1.2 = 0
#guard ({ core122 with verts := fun i => if i = 3 then ⟨1000, 0⟩ else core122.verts i } :
  UDCert 122).PairsAt core122Pairs 4 = false

-- The compiled face of the completeness check below — two independent evaluators on one fact.
#guard (List.finRange 122).all fun i => (List.finRange 122).all fun j =>
  !(decide ((core122.verts i).distSq (core122.verts j) = ((4 * (12 * 12) : ℤ) : Q4))) ||
    decide ((i, j) ∈ core122Pairs) || decide ((j, i) ∈ core122Pairs)

/-- **Completeness of the pair list**: any two of the 122 points at exact squared distance
`4` are a listed pair — `core122Pairs` is the whole distance-2 class on these points, not a
curated sublist. The pigeonhole theorem does not depend on this; it pins the interpretation
(the M33 class semantics). Kernel-checked over all 14,884 ordered pairs — 90 s, measured
within the §0g G-7 budget. -/
theorem core122_pairs_complete :
    ∀ i j : Fin 122, (core122.verts i).distSq (core122.verts j) = ((4 * (12 * 12) : ℤ) : Q4) →
      (i, j) ∈ core122Pairs ∨ (j, i) ∈ core122Pairs := by
  decide +kernel

/-! ### The pigeonhole -/

/-- **The 122-point pigeonhole.** Every proper 4-colouring of the 122 points (properness over
the 421 listed unit edges) makes some listed distance-2 pair monochromatic. The refutation is
the LRAT certificate above, carried across the bridge. -/
theorem core122_pigeonhole (C : (edgeGraph 122 core122Edges).Coloring (Fin 4)) :
    MonoPair core122Pairs C :=
  mono_pair_of_not_colorable_append core122Aug_not_colorable C

/-! ### The plane corollary -/

/-- **No proper 4-colouring of the plane avoids monochromatic distance-2 pairs.** The
pigeonhole shadow of Haugland's forced-equal pair (arXiv:2608.04542) — what is new is the
carrier, not the compulsion: a 122-point 1-minimal witness on the certified hexagram's seam
lattice, kernel-checked end to end. Distance 2 is the ρ₁₅ spindle distance; every kill of
this compulsion lives one field up (G16). The witnesses are two of the 122 certified
points. -/
theorem core122_plane (C : (unitDistance ℂ).Coloring (Fin 4)) :
    ∃ x y : ℂ, dist x y = 2 ∧ C x = C y := by
  have hunit := core122.valid_sound (by decide) core122_valid
  have hvalid : ∀ {i j : Fin 122}, (edgeGraph 122 core122Edges).Adj i j →
      C (core122.point i) ≠ C (core122.point j) := by
    rintro i j ⟨hne, hm | hm⟩
    · exact C.valid (unitDistance_adj.mpr (hunit (i, j) hm))
    · exact C.valid (unitDistance_adj.mpr (by rw [dist_comm]; exact hunit (j, i) hm))
  obtain ⟨p, hp, heq⟩ := core122_pigeonhole (Coloring.mk (fun i => C (core122.point i)) hvalid)
  refine ⟨core122.point p.1, core122.point p.2, ?_, heq⟩
  have h := core122.pairsAt_sound (by decide) core122_pairs_dist p hp
  rwa [show Real.sqrt ((4 : ℤ) : ℝ) = 2 by
    rw [show ((4 : ℤ) : ℝ) = (2 : ℝ) ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]] at h

end HadwigerNelson
