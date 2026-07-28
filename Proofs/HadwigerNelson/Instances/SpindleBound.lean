import Proofs.HadwigerNelson.Instances.Spindle
import Proofs.HadwigerNelson.Reduction
import Proofs.HadwigerNelson.Sat.Lrat

/-!
# The Moser spindle — χ(ℝ²) ≥ 4, three ways

`Instances/Spindle.lean` certified the geometry: seven points of `ℚ(√3)`, eleven exact unit
distances, kernel-decided. This module supplies the other half — the spindle needs four colours —
and reads off the bound.

The combinatorial half is proved **three times over the same graph**, which is the whole reason
this milestone exists at spindle scale:

| route | mechanism | axioms |
|---|---|---|
| **A** brute force | `decide` over all `3 ^ 7` colourings | clean |
| **B** monolithic SAT | one CaDiCaL certificate, `LRAT.check` | native purchase |
| **C** cube split | nine certificates, one per colouring of `{0, 1}` | native purchase |

A is the oracle. It exists only at this scale — `4 ^ 1581` is not a number one enumerates — and its
job is to catch an encoder that is wrong in a way no certificate could reveal, since a certificate
proves *some* formula unsatisfiable and cannot tell you it is the wrong formula. B checks the
encoder against A. C checks the split against B. M05 has only C.

The headline below is proved through **A**, so `four_le_chromaticNumber_plane` carries no native
axiom; the routes through certificates are stated separately and say so.

## Non-vacuity

The spindle *is* 4-colourable, and that is asserted here too. Without it, an encoder or a decision
procedure that answered "not colourable" unconditionally would satisfy everything above.
-/

namespace HadwigerNelson

open Std.Sat SimpleGraph

/-! ## Route A — brute force, no solver -/

/-- **The spindle needs four colours**, by exhaustion over all `3 ^ 7 = 2187` colourings.

The oracle for routes B and C: no CNF, no certificate, no external tool. -/
theorem moserSpindle_not_colorable_three : ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 := sorry

/-- An explicit 4-colouring of the spindle — **the concrete model** of `sat_colouringCNF`'s
hypotheses, so that nothing below is a `∀` over an empty domain. -/
def spindleFour : Fin 7 → Fin 4 := ![0, 1, 2, 0, 1, 2, 3]

/-- **Non-vacuity.** Four colours *do* suffice, so the decision above is a fact about the spindle
and not a constant answer. -/
theorem moserSpindle_colorable_four : (edgeGraph 7 moserSpindleEdges).Colorable 4 := sorry

/-! ## Route B — the SAT bridge

`scripts/Dimacs.lean` prints the DIMACS **from the Lean definition** (`ARCHITECTURE.md` § 6: the
Python side never authors a CNF), CaDiCaL proposes an LRAT certificate, and `unsat_of_check`
verifies it. -/

/-- The encoding of the spindle at three colours is unsatisfiable.

**Trust purchase: native evaluation.** The certificate check is not kernel-reducible at any size —
see `Sat/Lrat.lean` — so this declaration carries `…_native.native_decide.ax_…`. Nothing that route
A proves depends on it. -/
theorem moserSpindle_cnf_unsat : (colouringCNF 3 7 moserSpindleEdges).Unsat := sorry

/-- The spindle needs four colours, **through the SAT bridge**. Agrees with
`moserSpindle_not_colorable_three`, which is the point: the encoder is cross-checked against an
independent oracle at a scale where the oracle exists. Carries the native axiom. -/
theorem moserSpindle_not_colorable_three_lrat : ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 :=
  sorry

/-- **The encoder is not constantly unsatisfiable.** At four colours the same formula is
satisfiable, witnessed by an actual colouring pushed through `sat_colouringCNF` — which also
exercises the direction the project proves, positively. -/
theorem exists_sat_colouringCNF_four :
    ∃ a, CNF.Sat a (colouringCNF 4 7 moserSpindleEdges) := sorry

/-! ## Route C — the cube split

M05's only route, exercised here where every piece is small enough to check by hand. Splitting on
`W = [0, 1]` gives `3 ^ 2 = 9` cubes, hence nine independent CaDiCaL runs and nine certificates. -/

/-- The split set: the two vertices whose colours are fixed by each cube. -/
def moserSpindleSplit : List (Fin 7) := [0, 1]

/-- The spindle needs four colours, **through the cube split**. Carries the native axiom, once per
cube. -/
theorem moserSpindle_not_colorable_three_cubes : ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 :=
  sorry

/-! ## The headline -/

/-- **χ(ℝ²) ≥ 4.** The Moser spindle is a unit-distance graph in the plane needing four colours.

Proved through route A, so the axiom list is `propext`, `Classical.choice`, `Quot.sound` and
nothing else — a fully kernel-checked bound. -/
theorem four_le_chromaticNumber_plane :
    4 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := sorry

/-- The same bound assembled the way M05 must assemble its own: exact geometry plus a verified
certificate, through `add_one_le_chromaticNumber_plane_of_cubes`. Carries the native axiom, and
exists to prove that the M05 call site type-checks with real data in it. -/
theorem four_le_chromaticNumber_plane_certified :
    4 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := sorry

/-! ## Spec checks

The encoder, checked against real assignments in both directions on every build — so `colouringCNF`
is known to track the colouring rather than answer a constant, which no amount of `Unsat` evidence
could establish.

The assignments below are **written out by hand** rather than built with the module's own
`ofColoring`. That is deliberate: an encoder checked with the same machinery that produced its
satisfying assignments only tests self-consistency. Here the two sides are independent. -/

section Spec

-- Seven at-least-one clauses, plus three per edge.
#guard (colouringCNF 3 7 moserSpindleEdges).clauses.size = 40

-- A real 4-colouring satisfies the 4-colour encoding. Variable `4 * v + c` is true iff vertex `v`
-- has colour `c`.
#guard CNF.eval (fun m => m % 4 == [0, 1, 2, 0, 1, 2, 3].getD (m / 4) 0)
          (colouringCNF 4 7 moserSpindleEdges)

-- The best available 3-colouring fails, and fails on an *edge* clause: vertices 3 and 6 are
-- adjacent and both land on colour 0.
#guard !CNF.eval (fun m => m % 3 == [0, 1, 2, 0, 1, 2, 0].getD (m / 3) 0)
          (colouringCNF 3 7 moserSpindleEdges)

-- Nine cubes over two vertices at three colours.
#guard (allCubes 3 moserSpindleSplit).length = 9

end Spec

end HadwigerNelson
