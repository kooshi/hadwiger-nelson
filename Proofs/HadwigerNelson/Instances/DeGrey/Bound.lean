import Proofs.HadwigerNelson.Instances.DeGrey.Forcing
import Proofs.HadwigerNelson.Instances.DeGrey

/-!
# χ(ℝ²) ≥ 5 — the plane needs five colours

The headline. Colour the points of the plane so that no two points exactly one unit apart share a
colour: four colours are not enough.

## The argument, in one paragraph

de Grey's graph is two copies of a smaller graph, sharing one vertex and joined by one edge
(`Instances/DeGrey/Split.lean`). Suppose the whole graph had a proper 4-colouring. Restricted to
either copy it is still proper, and each copy *forces* its end of the joining edge to take the shared
vertex's colour (`Sat/Forcing.lean`, from one kernel-checked refutation per copy). So both ends of the
joining edge have the shared vertex's colour — and they are joined by an edge, which forbids exactly
that. Hence no proper 4-colouring exists; and since every listed edge really is one unit long (M04's
geometry, `deGrey_valid`), the plane needs a fifth colour.

## What this rests on

Nothing but the kernel and the three standard axioms. The two refutations are checked by
`HadwigerNelson.runChunks`, whose soundness is proved in `Sat/MaskCheck.lean`; the geometry is 7877
exact identities in `ℚ(√3,√5,√7,√11)` decided by kernel reduction; the reduction from a finite graph
to the plane is M01's. **No native evaluation anywhere** — `scripts/Axioms.lean` is the receipt.

CaDiCaL proposed the two certificates and is trusted for neither: a wrong certificate fails a segment
check, and a wrong clause table fails `agreesWithCNF`.
-/

namespace HadwigerNelson

/-- **χ(ℝ²) ≥ 5.** No assignment of four colours to the points of the Euclidean plane avoids giving
two points at distance exactly 1 the same colour.

Read against the informal claim: `unitDistance V` is the graph on a metric space whose edges join
points at distance exactly 1, `chromaticNumber` is Mathlib's `⨅ n ∈ {n | Colorable n}, n` in `ℕ∞`,
and `5 ≤ ·` says every colouring with four or fewer colours fails. The bound is a lower bound on the
chromatic number of the plane, which is the Hadwiger–Nelson quantity. -/
theorem chromaticNumber_plane_ge_five :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  deGrey_bound_of_not_colorable deGrey_not_colorable_four

end HadwigerNelson
