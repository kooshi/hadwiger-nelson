import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Combinatorics.SimpleGraph.Finite

/-!
# Greedy colouring: every degree below `k` makes a graph `k`-colourable

The classical bound `χ(G) ≤ Δ(G) + 1`, in the form the greedy argument actually proves and M18
consumes: a finite graph all of whose degrees are strictly below `k` admits a proper
`k`-colouring. Searched for and not found in Mathlib (2026-08-03: no greedy, no `Δ + 1`, no
degeneracy colouring under `Colorable`/`degree`/`maxDegree` vocabulary) — to be re-queried by
shape with `exact?` and Loogle before this `sorry` is burned, per the claims-of-absence rule;
three such claims have been wrong in this workspace, though none survived that re-query.

M18 uses it at `k = 3`: a distance class's internal unit-distance graph has maximum degree 2
(`ClassGeometry.lean`), so three colours always suffice for a class by itself — which is why no
class can confine a five-colour fan alone.
-/

namespace SimpleGraph

/-- **Greedy colouring.** A finite graph each of whose vertices has degree strictly less than
`k` is `k`-colourable. -/
theorem colorable_of_degree_lt {V : Type*} [Fintype V] (G : SimpleGraph V)
    [DecidableRel G.Adj] {k : ℕ} (h : ∀ v, G.degree v < k) : G.Colorable k := by
  sorry

end SimpleGraph
