import Proofs.HadwigerNelson.Instances.DeGrey.Edges
import Proofs.HadwigerNelson.Sat.Encoding

/-!
# de Grey's graph is two copies of one smaller graph

The construction's last step rotates a single 791-point set twice, so the 1581-vertex graph is two
copies of it. Measured (`plans/M06-chi-ge-five.md` § 0(e)), the two copies:

* **share exactly one vertex** — number 14;
* are joined by **exactly one edge** — 11 to 802;
* and account for all 7877 edges: 3938 inside each copy, plus that one.

That is not a curiosity, it is the proof. A colouring of the whole graph restricts to a colouring of
each copy; each copy forces its own end of the joining edge to take the shared vertex's colour; and
the joining edge forbids its two ends from agreeing. `Instances/DeGrey/Forcing.lean` proves the two
forcing steps from certificates, and `Instances/DeGrey/Bound.lean` puts them together.

## Why the edge list is a concatenation

Everything below is a `List` fact with **no arithmetic and no comparisons in it**, because the edge
list is *emitted* as `halfA ++ halfB ++ cross` (`tools/degrey.py` orders it, `tools/emit_cert.py`
chunks it to match, at 179 edges per chunk because 3938 = 22 × 179). Deciding the same inclusions
against an unordered list would be 3938 × 7877 kernel comparisons of `Fin` pairs.

The geometry is unaffected: the same 7877 pairs are certified, in a different order.
-/

-- The shape checks below walk 7876-element lists in the interpreter, which is deeper than the
-- default recursion budget; the *theorems* need none of it.
set_option maxRecDepth 100000

namespace HadwigerNelson

/-! ### The shape of the data, asserted on every build

`Valid = true` says nothing about the *split*, so these pin it. Each runs compiled and would catch a
regenerated file whose halves changed size or whose joining edge moved. -/

#guard deGreyHalfAEdges.length = 3938
#guard deGreyHalfBEdges.length = 3938
#guard deGreyCrossEdge = [(11, 802)]

-- The two halves are genuinely vertex-disjoint apart from vertex 14 — the fact that makes a
-- colouring of the whole graph decompose into a colouring of each half.
#guard (deGreyHalfAEdges.map (·.1) ++ deGreyHalfAEdges.map (·.2)).eraseDups.length = 791
#guard (deGreyHalfBEdges.map (·.1) ++ deGreyHalfBEdges.map (·.2)).eraseDups.length = 791
#guard ((deGreyHalfAEdges.map (·.1) ++ deGreyHalfAEdges.map (·.2)).eraseDups.filter fun v =>
          (deGreyHalfBEdges.map (·.1) ++ deGreyHalfBEdges.map (·.2)).eraseDups.contains v) = [14]

-- The joining edge is not inside either half.
--
-- **This is a claim about the data, not a soundness condition** — and an earlier version of this
-- comment said otherwise ("the argument would be circular"), which was wrong. `not_colorable_of_forcing`
-- needs only three inclusions; if the joining edge *were* also inside a half, the forcing fact would
-- be stronger, the derivation would still be valid, and nothing would break. What these two lines
-- guard is that the split is the one described above, so a regenerated file that mixed the copies is
-- caught here rather than becoming a silently different theorem.
#guard !deGreyHalfAEdges.contains (11, 802)
#guard !deGreyHalfBEdges.contains (11, 802)

/-! ### The three inclusions the proof consumes -/

/-- Every edge of the first copy is an edge of de Grey's graph. -/
theorem deGrey_halfA_subset : deGreyHalfAEdges ⊆ deGrey.edges :=
  fun _ h => List.mem_append_left _ (List.mem_append_left _ h)

/-- Every edge of the second copy is an edge of de Grey's graph. -/
theorem deGrey_halfB_subset : deGreyHalfBEdges ⊆ deGrey.edges :=
  fun _ h => List.mem_append_left _ (List.mem_append_right _ h)

/-- **The joining edge.** One edge between the two copies, and it is what the two forcing lemmas
walk into. -/
theorem deGrey_cross_mem : ((11 : Fin 1581), (802 : Fin 1581)) ∈ deGrey.edges :=
  List.mem_append_right _ (by decide)

/-- The joining edge, as an adjacency in the graph. -/
theorem deGrey_adj_cross : (edgeGraph 1581 deGrey.edges).Adj 11 802 :=
  edgeGraph_adj_of_mem (by decide) deGrey_cross_mem

end HadwigerNelson
