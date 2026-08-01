import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows00
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows01
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows02
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows03
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows04
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows05
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows06
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows07
import Proofs.HadwigerNelson.Instances.Heule553.Critical.Rows08

/-! # `heule553` is five-vertex-critical: no five-colour fan sits anywhere in it

Every one of the 553 vertices is *needed*. Deleting any one of them leaves a graph four colours
suffice for, and `Instances/Heule553/Bound.lean` already proves the whole graph needs five — so this
graph is five-vertex-critical in the textbook sense, written out as two theorems.

**Why that closes a route.** M14 found the property de Grey's construction has: a *fan* at a pivot
`p` over partners `Q`, meaning every proper colouring paints `p` like at least one member of `Q`.
M15 found what having one means — `Critical.lean`'s correspondence — namely that a fan of **any**
width sits at `p` exactly when deleting `p` leaves the graph still needing the colour it needed. No
removable vertex, therefore no fan, therefore nothing here for de Grey's route to start from.

**And the limit, which travels with the result.** This is a statement about *this graph*. It says
nothing about the plane, nothing about six-chromatic unit-distance graphs, and nothing about graphs
this one is a subgraph of. Fans exist — `Critical.lean` commits one — they are simply not here.

The evidence is 553 explicit four-colourings, one per deleted vertex, checked by the kernel against
this file's own edge list. No solver is trusted and no SAT certificate is involved.
-/

namespace HadwigerNelson

/-- One proper 4-colouring of `heule553` minus each vertex's edges, packed 2 bits per vertex,
row `p` for pivot `p`. Assembled from 9 chunks because one kernel reduction over all
553 rows was measured at 41.7 GB. -/
def heule553Criticality : List Nat :=
  heule553Rows00 ++
  heule553Rows01 ++
  heule553Rows02 ++
  heule553Rows03 ++
  heule553Rows04 ++
  heule553Rows05 ++
  heule553Rows06 ++
  heule553Rows07 ++
  heule553Rows08

theorem heule553_criticality :
    criticalFrom heule553.edges 2 4 0 heule553Criticality = true :=
  criticalFrom_append_of (c := heule553Rows00) (d := heule553Rows01 ++ heule553Rows02 ++ heule553Rows03 ++ heule553Rows04 ++ heule553Rows05 ++ heule553Rows06 ++ heule553Rows07 ++ heule553Rows08)
        (len := 64) (by decide) heule553Chunk00
        (criticalFrom_append_of (c := heule553Rows01) (d := heule553Rows02 ++ heule553Rows03 ++ heule553Rows04 ++ heule553Rows05 ++ heule553Rows06 ++ heule553Rows07 ++ heule553Rows08)
            (len := 64) (by decide) heule553Chunk01
            (criticalFrom_append_of (c := heule553Rows02) (d := heule553Rows03 ++ heule553Rows04 ++ heule553Rows05 ++ heule553Rows06 ++ heule553Rows07 ++ heule553Rows08)
                (len := 64) (by decide) heule553Chunk02
                (criticalFrom_append_of (c := heule553Rows03) (d := heule553Rows04 ++ heule553Rows05 ++ heule553Rows06 ++ heule553Rows07 ++ heule553Rows08)
                    (len := 64) (by decide) heule553Chunk03
                    (criticalFrom_append_of (c := heule553Rows04) (d := heule553Rows05 ++ heule553Rows06 ++ heule553Rows07 ++ heule553Rows08)
                        (len := 64) (by decide) heule553Chunk04
                        (criticalFrom_append_of (c := heule553Rows05) (d := heule553Rows06 ++ heule553Rows07 ++ heule553Rows08)
                            (len := 64) (by decide) heule553Chunk05
                            (criticalFrom_append_of (c := heule553Rows06) (d := heule553Rows07 ++ heule553Rows08)
                                (len := 64) (by decide) heule553Chunk06
                                (criticalFrom_append_of (c := heule553Rows07) (d := heule553Rows08)
                                    (len := 64) (by decide) heule553Chunk07
                                    (heule553Chunk08))))))))

set_option maxRecDepth 4000 in
/-- **Every vertex of `heule553` is needed**: delete any one vertex's edges and 4 colours suffice.

Read with `heule553_not_colorable_four` in `Bound.lean`, which says 4 colours do *not* suffice for
the whole graph, this is five-vertex-criticality stated in full. -/
theorem heule553_vertex_critical (p : Fin 553) :
    ((edgeGraph 553 heule553.edges).deleteIncidenceSet p).Colorable 4 :=
  forall_colorable_delete_of_packed (bits := 2) (cs := heule553Criticality) (by norm_num)
    (by rw [everyVertexCritical, heule553_criticality]; rfl) p

/-- **No 5-colour fan sits anywhere in `heule553`** — at any pivot, over any partners.

`p` and `Q` are explicit so the quantifier is on the page: this is not "we checked one `Q`".

`p ∉ Q` is not bookkeeping. A pivot listed among its own partners satisfies `Fan` for free, since
every colouring paints `p` like `p`; without the hypothesis the statement would be false, and with
it the theorem covers every fan that says anything. -/
theorem heule553_no_five_fan (p : Fin 553) (Q : List (Fin 553)) (hp : p ∉ Q) :
    ¬ Fan (edgeGraph 553 heule553.edges) 5 p Q :=
  not_fan_of_vertex_critical heule553_vertex_critical hp

end HadwigerNelson
