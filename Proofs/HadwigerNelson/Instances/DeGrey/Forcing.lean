import Proofs.HadwigerNelson.Instances.DeGrey.HalfA.Cert
import Proofs.HadwigerNelson.Instances.DeGrey.HalfB.Cert
import Proofs.HadwigerNelson.Sat.Forcing

/-!
# de Grey's graph is not 4-colourable

The two kernel-checked refutations meet the general argument here, and that is the whole module: one
citation.

`Sat/Forcing.lean` holds the argument — two subgraphs each forcing a vertex to take a shared vertex's
colour, plus an edge between them — over an arbitrary graph, because the graph enters only through
three list inclusions. `Instances/DeGrey/Split.lean` holds the three inclusions. The two `Cert`
modules hold the refutations. Nothing is left to assemble.

## What each certificate says

The first copy of de Grey's point set is 4-uncolourable once vertex 14 is pinned to colour 0 and
vertex 11 to colour 1; the second, once vertex 14 is pinned to 0 and vertex 802 to 1. One refutation
per copy covers all three failing colours, because relabelling the colours is free.

Pinning the *same* colour — vertex 11 at vertex 14's own colour — is **satisfiable**. That is why the
forcing facts are equalities and not something stronger, and it is the reason a checker that
"refuted" that case would be refuting a colouring that exists.
-/

namespace HadwigerNelson

/-- **de Grey's graph has no 4-colouring.**

Each of the two copies forces its end of the joining edge to the shared vertex's colour, and the
joining edge forbids its two ends from agreeing. Everything below the surface is kernel-checked: 34.2
million propagation steps across two certificates, and 7877 exact distance identities. -/
theorem deGrey_not_colorable_four : ¬ (edgeGraph 1581 deGrey.edges).Colorable 4 :=
  not_colorable_of_forcing deGrey_halfA_subset deGrey_halfB_subset deGrey_cross_mem
    (by decide) halfA_unsat halfB_unsat

end HadwigerNelson
