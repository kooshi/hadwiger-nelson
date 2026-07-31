import Proofs.HadwigerNelson.Instances.Heule553.Valid
import Proofs.HadwigerNelson.Reduction

/-!
# A 553-point unit-distance graph — the geometry, certified

**553 points of the plane** with **2722 edges**, published by
Marijn Heule (`github.com/marijnheule/CNP-SAT`, `vtx/553.vtx` and `edge/553.edge`), vendored here at
`tools/heule/` and re-derived into exact arithmetic by `tools/heule.py`.

This module certifies the geometry and nothing else: every one of the 2722 listed pairs really is at
distance exactly 1. That the graph needs five colours is `Instances/Heule553/Bound.lean`.

## Whose work this is

The points are Heule's. What is proved here is a statement about those points **as written** — that
2722 named pairs are exactly one unit apart, and (next door) that no assignment of four colours to the
553 points avoids giving some named pair the same colour. Neither claim depends on how the points were
found, which is why the artifact carries the coordinates and not the search. The graph is his; the
geometry check, the certificate and the formalization are ours.

That independence is also why the provenance is not a hypothesis anywhere: a bound proved from *some*
553-point unit-distance graph is a bound on the plane whoever first drew it.

## Why a third witness at all

`Instances/DeGrey/Bound.lean` and `Instances/Heule510/Bound.lean` already prove `χ(ℝ²) ≥ 5`. This one
proves the same statement from a third graph, sharing no vertex, no edge and no certificate with
either — see that module's "For a reader who
trusts none of this", which is the one place the corroboration argument is made.

## The field

Heule's coordinates use `√3`, `√5`, `√11` and their products, which is a *subfield* of the
`ℚ(√3,√5,√7,√11)` tower M02 built for de Grey. So the `√7` components are identically zero here and
nothing needed changing — the whole geometry is 2722 kernel decisions at the same per-edge cost.

## If the geometry ever fails to check

```lean
#eval heule553.badEdges     -- every offending pair, and the squared distance it actually has
#eval heule553.denomSq      -- the squared distance a real unit edge must show
```
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The data, as it stands

`Valid = true` alone is a weak claim — a certificate with no edges satisfies it — so these pin the
shape of the data. They run compiled on every build and catch a regenerated file that silently changed
size or order. -/

#guard heule553.edges.length = 2722
#guard heule553Chunks.length = 16
#guard heule553.edges.eraseDups.length = 2722
#guard heule553.edges.all fun e => e.1 < e.2
#guard (heule553.edges.map (·.1) ++ heule553.edges.map (·.2)).eraseDups.length = 553
#guard heule553.denom = 288

-- **The triangle the refutation pins**, asserted here as data rather than discovered downstream.
-- `Instances/Heule553/Bound.lean` names its three colours, which is free and worth a measured 20×.
#guard heule553.edges.contains (0, 9)
#guard heule553.edges.contains (0, 10)
#guard heule553.edges.contains (9, 10)

-- **The compiled cross-check.** `heule553_valid` is 16 kernel reductions; this is the same predicate
-- evaluated by the *compiler*. Two independent evaluators agreeing on 2722 edges is worth its
-- runtime, and when they disagree this line is what says so.
#guard heule553.badEdges.isEmpty

-- **The negative control.** Collapse vertex 1 onto vertex 0 and the check must fail, naming exactly
-- the edges at vertex 1. Without it, every claim above would also hold of a `Valid` that is constantly
-- `true`.
--
-- **Vertex 1, not vertex 0** — and that is the control's own control. Written first as "move vertex 0
-- to the origin", it passed the `all` clause and failed the `isEmpty` one, because in this witness
-- vertex 0 *is* the origin: the perturbation perturbed nothing. A negative control that does not move
-- the thing it claims to move is exactly the check that reports nothing when it cannot run. Vertex 1
-- is `(1, 0)` and is adjacent to vertex 0, so collapsing it onto the origin gives that edge length 0.
#guard (({ heule553 with verts := fun i => if i = 1 then heule553.verts 0 else heule553.verts i } :
  UDCert 553)).badEdges.all fun be => be.1.1 = 1 ∨ be.1.2 = 1

#guard !(({ heule553 with verts := fun i => if i = 1 then heule553.verts 0 else heule553.verts i } :
  UDCert 553)).badEdges.isEmpty

/-! ### The claims -/

/-- **The geometry, in the plane's own terms.** Every listed edge joins two points of `ℂ` at distance
exactly 1 — no floating point anywhere, the whole claim reduced to identities between integers. -/
theorem heule553_unit_distances :
    ∀ e ∈ heule553.edges, dist (heule553.point e.1) (heule553.point e.2) = 1 :=
  heule553.valid_sound (by decide) heule553_valid

/-- **The hand-off.** Supply "this graph has no 4-colouring" and the bound `χ(ℝ²) ≥ 5` follows;
everything geometric is discharged inside this proof. -/
theorem heule553_bound_of_not_colorable
    (hG : ¬ (edgeGraph 553 heule553.edges).Colorable 4) :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  heule553.add_one_le_chromaticNumber_plane_of_valid heule553_valid hG

end HadwigerNelson
