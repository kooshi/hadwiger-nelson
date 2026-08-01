import Proofs.HadwigerNelson.Instances.DeGrey.HalfA.Cert
import Proofs.HadwigerNelson.Instances.DeGrey.Rotated
import Proofs.HadwigerNelson.Gadget

/-!
# de Grey's graph is not 4-colourable — three constraints on three vertices

de Grey's whole argument concerns **three vertices**: the one his two copies share, and the two ends
of the single edge joining them. Everything a proper 4-colouring could do to those three is
enumerated below and every possibility is excluded, so no proper 4-colouring exists.

| the constraint | where it comes from |
|---|---|
| the shared vertex and the first copy's end **agree** | one kernel-checked refutation |
| the shared vertex and the second copy's end **agree** | *the same refutation*, moved by the rotation |
| the two ends **differ** | they are joined by an edge |

The three cannot hold at once. That is the entire proof, and the final step is one `decide` over the
64 ways three vertices can take four colours.

## What is new here, against M06

M06 proved the second constraint with a **second SAT certificate** — 1,043 generated modules, 180 MB,
12.8 hours of processor time. It is now the first constraint transported along the rotation that
carries de Grey's first copy onto his second (`Instances/DeGrey/Rotation.lean`), which the kernel
checks in 86 seconds. The two facts that make the transport land on the right vertices are the two
`by decide`s in `deGreyForcedB` below: the rotation **fixes vertex 14** and **sends vertex 11 to
vertex 802**.
-/

namespace HadwigerNelson

/-- The three vertices de Grey's argument is about: the copies' shared vertex, and the two ends of
the edge joining them. -/
def deGreyPorts : Fin 3 → Fin 1581 := ![14, 11, 802]

/-- Half A's certificate was filed against the cube `[(14, 0), (11, 1)]`, which is what pinning these
two ports to this pattern means. Checked, so a certificate filed against anything else does not
typecheck here. -/
private theorem halfA_pinCube : pinCube ![(14 : Fin 1581), 11] ![0, 1] = halfACube := by decide

/-- The forcing fact both copies share: pinning the shared vertex and a copy's endpoint to
*different* colours leaves that copy 4-uncolourable. One certificate, and by colour symmetry it
covers all twenty-four relabellings. -/
def deGreyForced : Gadget 4 1581 2 deGreyHalfAEdges ![14, 11] :=
  Gadget.ofUnsat ![0, 1] (by rw [halfA_pinCube]; exact halfA_unsat)

/-- **The first copy forces its end of the joining edge to the shared vertex's colour.** -/
def deGreyForcedA : Gadget 4 1581 3 deGreyRotEdges deGreyPorts :=
  (deGreyForced.mono deGreyRot_halfA_subset).widen ![0, 1] (by decide)

/-- **The second copy forces its end to the shared vertex's colour too — from the same certificate.**

The two `by decide`s are the mathematics: the rotation **fixes vertex 14**, the copies' shared vertex,
and **sends vertex 11 to vertex 802**, the other end of the joining edge. Nothing else about the
second copy is asserted anywhere. -/
def deGreyForcedB : Gadget 4 1581 3 deGreyRotEdges deGreyPorts :=
  (deGreyForced.transport deGreyPhi deGreyRot_adj_map (pt := ![14, 802]) (by decide)).widen
    ![0, 2] (by decide)

/-- **The joining edge forbids its two ends from agreeing.** The base gadget: no certificate, no
computation. -/
def deGreyJoin : Gadget 4 1581 3 deGreyRotEdges deGreyPorts :=
  Gadget.edge 1 2 (edgeGraph_adj_of_mem (by decide) deGreyRot_cross_mem)

/-- **The three constraints, composed.** `Instances/DeGrey/Bound.lean` shows they admit nothing.

Named, and living in *this* module rather than beside the theorem that consumes it, for one reason:
when that theorem fails this module still builds, so the directive its failure prints — `#eval
deGreyGadgets.survivors` — can actually be run. A diagnostic that is only reachable from a module
that does not compile is not a diagnostic. -/
def deGreyGadgets : Gadget 4 1581 3 deGreyRotEdges deGreyPorts :=
  deGreyForcedA.inter (deGreyForcedB.inter deGreyJoin)

end HadwigerNelson
