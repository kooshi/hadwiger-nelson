import Proofs.HadwigerNelson.Instances.Mycielski
import Proofs.HadwigerNelson.Instances.Mycielski.Cnf.Cert

/-!
# The first refutation of a five-colouring in this project

`χ(ℝ²) ≥ 5` means *no 4-colouring*; **`χ(ℝ²) ≥ 6` means no 5-colouring**, and until this module
nothing here had ever asked that question. `coloringCNF 5` and `Colorable 5` appeared exactly zero
times across the whole repository, so every cost in `plans/` was a four-colour cost — in a project
where refutation cost is already measured *non-monotone* in graph size.

This is the **calibration instance** for the colour count rung D needs, exactly as the Moser spindle
was for rung A: no geometry, no plane, no unit distances, only the combinatorial half of the pipeline
run at five colours. What it establishes is a *cost*, and the cost is the point.

## What it cost, measured

| | |
|---|---|
| the solver | 0.22 s, 38,743 LRAT actions |
| after backward trimming | 21,240 actions, **387,065 hint entries** |
| the same graph refuted at five colours **without** naming the ports' colours | **10,224,710** hint entries |
| for comparison, the 553-point unit-distance witness at *four* colours (M07) | 1,104,106 |

So a 47-vertex graph at five colours costs a third of what a 553-vertex graph costs at four. The
subplanning measurement predicted 387,065 before a line of this was written, and the certificate
came in at exactly that.

## Two ports, and why not three

Every other witness here names a **triangle**'s colours — three mutually adjacent ports, worth 20× at
four colours and 8.5–53× at five. Mycielski's construction introduces no triangle, so the largest
clique in this graph is an edge and the lever is the weaker one: 26×, which is the whole difference
between the two rows above. A real unit-distance candidate has equilateral triangles everywhere and
gets the stronger version; this graph is a calibration instance, not a candidate.

## The argument, in one paragraph

Suppose the graph had a proper 5-colouring. Its two ports are adjacent, so they take different
colours, and renaming colours is free — some permutation sends them to 0 and 1, and applying it gives
another proper colouring, one satisfying the pinned formula. That formula has a kernel-checked
refutation, so no such colouring exists. The partner theorem `mycielski47_colorable_six` shows six
colours *do* suffice, so this is a statement about five and not about the graph being uncolourable
outright.
-/

namespace HadwigerNelson

namespace Mycielski
/-- The two ports: the ends of the original edge, which survives every Mycielskian.

Two ports and not three, because **this graph is triangle-free** — Mycielski's construction is what
introduces no triangle — so the three-mutually-adjacent-ports gadget every other witness here uses
(`Instances/Heule553/Bound.lean` and its two siblings) has nothing to attach to. The largest clique
is an edge, and an edge is what gets pinned. -/
def ports : Fin 2 → Fin size := ![0, 1]

/-- **Naming one edge's colours**, which is the only colour-symmetry lever a triangle-free graph has.

Measured before this was written: 387,065 trimmed hint entries with the edge pinned against
10,224,710 without — 26×, and the difference between about ten minutes of kernel time and four
hours. A unit-distance candidate would have a triangle here and the lever would be worth 8.5–53×. -/
def portsEdge : Gadget 5 size 2 edges ports :=
  Gadget.edge 0 1 (edgeGraph_adj_of_mem (by decide) (by decide +kernel))

/-- **The solver's half**: with the two ports pinned to different colours, the formula is
unsatisfiable. This is the one leaf that needs a certificate — everything else about this witness is
derived from the construction. -/
theorem pinned_unsat :
    (coloringCNF 5 size edges ++ cubeCNF 5 size (pinCube ports ![0, 1])).Unsat := by
  have h : mycielski47Cnf = coloringCNF 5 size edges ++ cubeCNF 5 size (pinCube ports ![0, 1]) := by
    simp only [mycielski47Cnf, ports, pinCube]
    rfl
  exact h ▸ mycielski47_unsat

/-- The two gadgets composed. At two ports and five colours there are exactly two colour-partitions
to rule out, and each gadget rules out one: the edge kills "the ends agree", the certificate kills
"the ends differ". -/
def gadgets : Gadget 5 size 2 edges ports :=
  (Gadget.ofUnsat ![0, 1] pinned_unsat).inter portsEdge

end Mycielski

-- The `fail` branch is unreachable *when the gadgets refute*, which is when the linter runs.
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **The first refutation of a five-colouring in this project.**

47 vertices, 236 edges, and no proper colouring with five colours. Kernel-checked through the same
route every other witness here uses: a solver certificate, re-checked by `Sat/MaskCheck.lean`, with
CaDiCaL trusted for nothing. -/
theorem mycielski47_not_colorable_five :
    ¬ (edgeGraph Mycielski.size Mycielski.edges).Colorable 5 :=
  not_colorable_of_gadget Mycielski.gadgets (by
    first
      | decide +kernel
      | fail "Mycielski.gadgets admits a port colouring, so this graph is not refuted. What \
              survives is `Mycielski.gadgets.survivors` — one entry per colour-partition of the two \
              ports, each a list of (vertex, colour) pins. Print it with, inside \
              `namespace HadwigerNelson`,  #eval Mycielski.gadgets.survivors")


end HadwigerNelson
