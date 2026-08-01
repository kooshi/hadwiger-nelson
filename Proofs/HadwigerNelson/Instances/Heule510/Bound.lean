import Proofs.HadwigerNelson.Instances.Heule510.Cnf.Cert
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.Instances.Heule510

/-!
# χ(ℝ²) ≥ 5, from a 510-point witness

The same theorem `Instances/DeGrey/Bound.lean` proves, from a graph a third the size that shares
nothing with de Grey's. **That module carries the argument for why two proofs of one theorem are
worth having, and the four commands a sceptical reader should run**; this one is the second witness
and says only what is different about it.

## What is different

* **510 points, 2504 edges** against de Grey's 1581 and 7877 — the smallest witness here, and
  vertex-critical: `tools/shrink.py` removed every vertex in turn and the graph stopped being
  5-chromatic every time (`plans/M07-shrinking.md` § 5.1).
* **One certificate, and no decomposition.** de Grey's graph has no refutation of its own — measured,
  repeatedly — so M06 had to recover his two-copy argument and prove a forcing lemma about each half.
  This graph simply refutes, in 1,413,841 propagation steps against 34,169,571.
* **One triangle's colours are named.** Vertices 0, 27 and 28 are mutually adjacent, so in any proper
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
def heule510Ports : Fin 3 → Fin 510 := ![0, 27, 28]

/-- The certificate was filed against the cube pinning that triangle to `0, 1, 2`. -/
private theorem heule510_pinCube : pinCube heule510Ports ![0, 1, 2] = heule510Cube := by decide

/-- **The refutation**: the three triangle vertices are not all differently coloured — which for a
triangle is impossible, and that is the contradiction. One certificate covers all `4! = 24`
relabellings, by colour symmetry. -/
def heule510Refuted : Gadget 510 3 heule510.edges heule510Ports :=
  Gadget.ofUnsat ![0, 1, 2] (by rw [heule510_pinCube]; exact heule510_unsat)

/-- **The triangle**: its three edges, each forbidding its ends from agreeing. -/
def heule510Triangle : Gadget 510 3 heule510.edges heule510Ports :=
  (Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide))).inter
    ((Gadget.edge 0 2 (edgeGraph_adj_of_mem (by decide) (by decide))).inter
      (Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide) (by decide))))

/-- **The four constraints, composed.** `#eval heule510Gadgets.survivors` when this stops refuting. -/
def heule510Gadgets : Gadget 510 3 heule510.edges heule510Ports := heule510Refuted.inter heule510Triangle

-- The `fail` branch is unreachable *when the gadgets refute*, which is when the linter runs.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **The graph is not 4-colourable.** One kernel-checked refutation and the triangle's own three
edges admit no colouring of the triangle at all, decided over all 64. -/
theorem heule510_not_colorable_four : ¬ (edgeGraph 510 heule510.edges).Colorable 4 :=
  not_colorable_of_gadget heule510Gadgets (by
    first
    | decide
    | fail "the gadgets do not jointly refute. For the port colourings that survive, in a file \
            with `import Proofs.HadwigerNelson.Instances.Heule510.Bound` and inside `namespace \
            HadwigerNelson`:  #eval heule510Gadgets.survivors")

/-- **χ(ℝ²) ≥ 5**, from the 510-point witness. Identical in statement to
`chromaticNumber_plane_ge_five`; the number in the name is the size of the graph it came from, which
is the only thing that differs. -/
theorem chromaticNumber_plane_ge_five_510 :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  heule510_bound_of_not_colorable heule510_not_colorable_four

end HadwigerNelson
