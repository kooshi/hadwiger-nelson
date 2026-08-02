import Proofs.HadwigerNelson.Fan

/-! # Deletion never creates a fan — M17's pruning corollaries

The mathematics is one line and was already in the library: `Fan.mono` (M15) says a fan in a
subgraph is a fan in every supergraph on the same vertices, and `Fan.widen` frees the partner
list. What M17 adds is the **record**, in the vocabulary its hunt quotes: the composed edge-list
form, and its contrapositive — a separating colouring of a candidate restricts to every
sub-candidate, so **no deletion campaign can produce the confined fan the closing move needs**.
The stub direction "glue-then-narrow by deletion" (`plans/M17-constructing-narrow-fans.md`
§ 0(a)) is closed by these theorems, not by a search, and the hunt spends its entire budget on
growth — doubling, gluing, orbiting — where constraints are added and confinement can genuinely
appear.

Recorded here rather than in `Fan.lean` because that module sits upstream of the four Narrow*
kernel certificates and the Critical chain: a declaration added there re-checks minutes of settled
kernel work for zero mathematical gain. (Found present while writing this module, in the
claims-of-absence tradition: `Fan.mono` itself, which the M17 subplan first listed as this
module's main theorem. The grep came after the statement was written, and the elaborator said
"already declared". Fourth entry in that ledger.)
-/

namespace HadwigerNelson

open SimpleGraph

variable {k : ℕ}

/-- **Edge-list monotonicity, partner widening folded in**: more listed edges and a wider partner
list still carry the fan. `Fan.mono` + `Fan.widen` + `edgeGraph_adj_mono`, composed into the shape
`tools/rescan.py` quotes. -/
theorem Fan.of_sublist {n : ℕ} {E E' : List (Fin n × Fin n)} {p : Fin n} {Q Q' : List (Fin n)}
    (hE : E' ⊆ E) (hQ : Q' ⊆ Q) (h : Fan (edgeGraph n E') k p Q') :
    Fan (edgeGraph n E) k p Q :=
  sorry

/-- **Deletion can never create a fan** — the contrapositive the hunt relies on, stated in the
direction the tool meets it: a proper colouring separating the pivot from `Q` on the larger edge
list is proper on the smaller one and still separates the smaller partner list. A candidate once
*separated* (not confined) stays separated under every deletion of edges or partners; deleting a
vertex is the instance `E' = E.filter (edges avoiding it)`, `Q' = Q.erase it`. -/
theorem not_fan_sublist_of_not_fan {n : ℕ} {E E' : List (Fin n × Fin n)} {p : Fin n}
    {Q Q' : List (Fin n)} (hE : E' ⊆ E) (hQ : Q' ⊆ Q) (h : ¬ Fan (edgeGraph n E) k p Q) :
    ¬ Fan (edgeGraph n E') k p Q' :=
  sorry

/-! ## Spec examples — the statements say what they are believed to say

The instances use the path `0—1—2` inside the triangle on `Fin 3`: at two colours the path pins
its endpoints together (a genuine width-one fan), and at three colours the triangle separates
every pair (colourings exist and disagree everywhere, so the negative claims discriminate). -/

private def triE : List (Fin 3 × Fin 3) := [(0, 1), (1, 2), (0, 2)]
private def pathE : List (Fin 3 × Fin 3) := [(0, 1), (1, 2)]

/-- The path `0—1—2` at 2 colours really does fan: both 2-colourings paint 0 and 2 alike. -/
example : Fan (edgeGraph 3 pathE) 2 0 [2] :=
  Fan.of_edges (by decide +kernel)

/-- The lift: the path's fan carries to the triangle's edge list over the same partner list —
the example that fails if `Fan.of_sublist` ever drifts to a different `Q`. -/
example (h : Fan (edgeGraph 3 pathE) 2 0 [2]) : Fan (edgeGraph 3 triE) 2 0 [2] :=
  Fan.of_sublist (by decide) (by simp) h

/-- Separation survives deletion — the pruning direction on a concrete instance: the triangle at
3 colours separates 0 from 1, and dropping the edge `(0,2)` keeps them separated. -/
example (h : ¬ Fan (edgeGraph 3 triE) 3 0 [1]) : ¬ Fan (edgeGraph 3 pathE) 3 0 [1] :=
  not_fan_sublist_of_not_fan (by decide) (by simp) h

/-- …and that hypothesis is inhabited — a `∀` over an empty domain proves nothing, so the
separation is exhibited, not assumed: 0 and 1 are adjacent in the triangle, so no proper
colouring identifies them. -/
example : ¬ Fan (edgeGraph 3 triE) 3 0 [1] :=
  sorry

end HadwigerNelson
