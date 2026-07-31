import Proofs.HadwigerNelson.Instances.Heule553.Cnf.Cert
import Proofs.HadwigerNelson.Sat.Forcing

/-!
# χ(ℝ²) ≥ 5, from a 553-point witness

The same theorem `Instances/DeGrey/Bound.lean` proves, from a third graph, sharing nothing with
de Grey's or with the 510-point one. **That module carries the argument for why three proofs of one theorem are
worth having, and the four commands a sceptical reader should run**; this one is the third witness and
says only what is different about it.

## What is different

* **553 points, 2722 edges** against de Grey's 1581 and 7877 — and the *cheapest* of the three to
  check, at 1,104,106 propagation steps: the 510-point graph is smaller but less constrained, so its
  refutation is 28% longer. Smaller graph, smaller proof is not a rule
  (`plans/M07-shrinking.md` § 1).
* **One certificate, and no decomposition.** de Grey's graph has no refutation of its own — measured,
  repeatedly — so M06 had to recover his two-copy argument and prove a forcing lemma about each half.
  This graph simply refutes, in 1,104,106 propagation steps against 34,169,571.
* **One triangle's colours are named.** Vertices 0, 9 and 10 are mutually adjacent, so in any proper
  colouring they take three different colours, and renaming colours is free. Pinning them to 0, 1, 2
  makes the solver's job 20× smaller and the certificate 20× shorter — measured, and it costs exactly
  the one lemma below.

## The argument, in one paragraph

Suppose the graph had a proper 4-colouring. Its three triangle vertices get three distinct colours, so
some permutation of the four colours sends them to 0, 1 and 2, and applying that permutation gives
another proper colouring — one that satisfies the pinned formula. But that formula has a kernel-checked
refutation, so no such colouring exists. Every listed edge is exactly one unit long, so the plane needs
a fifth colour.
-/

namespace HadwigerNelson

/-- **The graph is not 4-colourable.** One kernel-checked refutation of the formula with the triangle
`0, 9, 10` pinned to colours `0, 1, 2`, plus the relabelling lemma that makes that pinning free. -/
theorem heule553_not_colorable_four : ¬ (edgeGraph 553 heule553.edges).Colorable 4 :=
  not_colorable_of_triangle_pinned
    (edgeGraph_adj_of_mem (by decide) (by decide))
    (edgeGraph_adj_of_mem (by decide) (by decide))
    (edgeGraph_adj_of_mem (by decide) (by decide))
    heule553_unsat

/-- **χ(ℝ²) ≥ 5**, from the 553-point witness. Identical in statement to
`chromaticNumber_plane_ge_five`; the number in the name is the size of the graph it came from, which
is the only thing that differs. -/
theorem chromaticNumber_plane_ge_five_553 :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  heule553_bound_of_not_colorable heule553_not_colorable_four

end HadwigerNelson
