import Proofs.HadwigerNelson.Instances.Heule553.Cnf.Cert
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.Instances.Heule553

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

/-- The triangle whose colours are named: three mutually adjacent vertices. -/
def heule553Ports : Fin 3 → Fin 553 := ![0, 9, 10]

/-- The certificate was filed against the cube pinning that triangle to `0, 1, 2`. -/
private theorem heule553_pinCube : pinCube heule553Ports ![0, 1, 2] = heule553Cube := by decide

/-- **The refutation**: the three triangle vertices are not all differently coloured — which for a
triangle is impossible, and that is the contradiction. One certificate covers all `4! = 24`
relabellings, by colour symmetry. -/
def heule553Refuted : Gadget 4 553 3 heule553.edges heule553Ports :=
  Gadget.ofUnsat ![0, 1, 2] (by rw [heule553_pinCube]; exact heule553_unsat)

/-- **The triangle**: its three edges, each forbidding its ends from agreeing. -/
def heule553Triangle : Gadget 4 553 3 heule553.edges heule553Ports :=
  (Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide))).inter
    ((Gadget.edge 0 2 (edgeGraph_adj_of_mem (by decide) (by decide))).inter
      (Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide) (by decide))))

/-- **The four constraints, composed.** `#eval heule553Gadgets.survivors` when this stops refuting. -/
def heule553Gadgets : Gadget 4 553 3 heule553.edges heule553Ports := heule553Refuted.inter heule553Triangle

-- The `fail` branch is unreachable *when the gadgets refute*, which is when the linter runs.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **The graph is not 4-colourable.** One kernel-checked refutation and the triangle's own three
edges admit no colouring of the triangle at all, decided over all 64. -/
theorem heule553_not_colorable_four : ¬ (edgeGraph 553 heule553.edges).Colorable 4 :=
  not_colorable_of_gadget heule553Gadgets (by
    first
    | decide
    | fail "heule553Gadgets admits a port colouring, so this graph is not refuted. What survives is \
            `heule553Gadgets.survivors` — one entry per colour-partition of the ports, each a list of \
            (vertex, colour) pairs, and each a cube a solver will take as it stands. This module \
            no longer builds, so read it from a fresh file: import Proofs.HadwigerNelson.Instances.Heule553.Bound \
            and, inside `namespace HadwigerNelson`,  #eval heule553Gadgets.survivors")

/-- **χ(ℝ²) ≥ 5**, from the 553-point witness. Identical in statement to
`chromaticNumber_plane_ge_five`; the number in the name is the size of the graph it came from, which
is the only thing that differs. -/
theorem chromaticNumber_plane_ge_five_553 :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  heule553_bound_of_not_colorable heule553_not_colorable_four

end HadwigerNelson
