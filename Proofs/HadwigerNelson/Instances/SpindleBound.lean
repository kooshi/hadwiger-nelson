import Proofs.HadwigerNelson.Instances.Spindle
import Proofs.HadwigerNelson.Instances.SpindleLrat
import Proofs.HadwigerNelson.Reduction
import Proofs.HadwigerNelson.Sat.Lrat
import Proofs.HadwigerNelson.Forcer

/-!
# The Moser spindle — χ(ℝ²) ≥ 4, three ways

`Instances/Spindle.lean` certified the geometry: seven points of `ℚ(√3)`, eleven exact unit
distances, kernel-decided. This module supplies the other half — the spindle needs four colours —
and reads off the bound.

The combinatorial half is proved **three times over the same graph**, which is the whole reason
this milestone exists at spindle scale:

| route | mechanism | axioms |
|---|---|---|
| **A** brute force | `decide +kernel` over all `3 ^ 7` colourings | clean |
| **B** monolithic SAT | one CaDiCaL certificate, `LRAT.check` | native purchase |
| **C** cube split | nine certificates, one per colouring of `{0, 1}` | native purchase |

A is the oracle. It exists only at this scale — `4 ^ 1581` is not a number one enumerates — and its
job is to catch an encoder that is wrong in a way no certificate could reveal, since a certificate
proves *some* formula unsatisfiable and cannot tell you it is the wrong formula. B checks the
encoder against A. C checks the split against B. M05 has only C.

The headline is proved through **A**, so `four_le_chromaticNumber_plane` carries no native axiom;
the routes through certificates are stated separately and say so in their first line.

## When the routes disagree

If A proves and B's certificate will not check, the encoder is the suspect, not the solver — a
certificate cannot be wrong in the direction that matters (see `Sat/Encoding.lean`), but it can
certify the wrong formula. Three instruments, in order: the spec `#guard`s at the bottom of this
file (do a real colouring and the formula still agree?), `#eval badCubes …` (which cube, and is the
certificate stale?), and `#eval CNF.dimacs (coloringCNF 3 7 moserSpindleEdges)` compared against the
file actually handed to CaDiCaL.
-/

namespace HadwigerNelson

open Std.Sat Std.Tactic.BVDecide SimpleGraph

/-! ## Route A — brute force, no solver -/

/-- **The spindle needs four colours**, by exhaustion over all `3 ^ 7 = 2187` colourings.

The oracle for routes B and C: no CNF, no certificate, no external tool.

`decide +kernel` rather than plain `decide`, on measurement. Plain `decide` evaluates the
`Decidable` instance in the elaborator *and then* has the kernel re-check it, so the enumeration
runs twice: 8.3 s of work, and it needs `maxRecDepth` raised past 4000 because the elaborator's own
recursion tracks the 2187 functions. The kernel route runs it once, in 2.6 s, at the default
recursion depth. Same axioms either way — this is the same `Decidable` instance, evaluated once
instead of twice. -/
theorem moserSpindle_not_colorable_three : ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 := by
  rw [not_colorable_edgeGraph_iff]
  decide +kernel

/-- An explicit 4-colouring of the spindle — **the concrete model** of `exists_sat_coloringCNF`'s
hypotheses, so that nothing below is a `∀` over an empty domain. -/
def spindleFour : Fin 7 → Fin 4 := ![0, 1, 2, 0, 1, 2, 3]

/-- **Non-vacuity.** Four colours *do* suffice, so the decision above is a fact about the spindle
and not a constant answer. -/
theorem moserSpindle_colorable_four : (edgeGraph 7 moserSpindleEdges).Colorable 4 :=
  colorable_iff_exists.mpr ⟨spindleFour, by simp only [edgeGraph_adj]; decide⟩

/-! ## Route B — the SAT bridge

`scripts/Dimacs.lean` prints the DIMACS **from the Lean definition** (`ARCHITECTURE.md` § 6: the
Python side never authors a CNF), CaDiCaL proposes an LRAT certificate, and `unsat_of_check`
verifies it. -/

/-- **Trust purchase: native evaluation.** The certificate check is not kernel-reducible at any
size — see `Sat/Lrat.lean` — so this declaration carries `…_native.native_decide.ax_…`. Nothing
route A proves depends on it.

The encoding of the spindle at three colours is unsatisfiable. -/
theorem moserSpindle_cnf_unsat : (coloringCNF 3 7 moserSpindleEdges).Unsat :=
  unsat_of_check (π := spindleCert) (by native_decide)

/-- **Trust purchase: native evaluation.** Inherited from `moserSpindle_cnf_unsat`.

The spindle needs four colours, **through the SAT bridge**. Agrees with
`moserSpindle_not_colorable_three`, which is the point: the encoder is cross-checked against an
independent oracle at a scale where the oracle exists. -/
theorem moserSpindle_not_colorable_three_lrat : ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 :=
  not_colorable_of_unsat moserSpindle_cnf_unsat

/-- **The encoder is not constantly unsatisfiable.** At four colours the same formula is
satisfiable, witnessed by an actual colouring pushed through `exists_sat_coloringCNF` — which also
exercises the direction the project proves, positively. -/
theorem exists_sat_coloringCNF_four :
    ∃ a, CNF.Sat a (coloringCNF 4 7 moserSpindleEdges) :=
  moserSpindle_colorable_four.elim fun C => exists_sat_coloringCNF C

/-! ## Route C — the cube split

M05's only route, exercised here where every piece is small enough to check by hand. Splitting on
`W = [0, 1]` gives `3 ^ 2 = 9` cubes, hence nine independent CaDiCaL runs and nine certificates. -/

/-- The split set: the two vertices whose colours are fixed by each cube. -/
def moserSpindleSplit : List (Fin 7) := [0, 1]

/-- The nine cubes, **as a literal list**, exactly as `scripts/Dimacs.lean` printed them from
`allCubes 3 7 moserSpindleSplit`. `moserSpindleCubes_eq` ties this literal to the enumeration; the
literal is what makes a misfiled certificate report a readable type mismatch. -/
def moserSpindleCubes : List (Cube 7 3) :=
  [[(0, 0), (1, 0)], [(0, 1), (1, 0)], [(0, 2), (1, 0)],
   [(0, 0), (1, 1)], [(0, 1), (1, 1)], [(0, 2), (1, 1)],
   [(0, 0), (1, 2)], [(0, 1), (1, 2)], [(0, 2), (1, 2)]]

/-- The literal list above really is the enumeration — the whole covering argument, in one `rfl`. -/
theorem moserSpindleCubes_eq : allCubes 3 7 moserSpindleSplit = moserSpindleCubes := rfl

/-- **Trust purchase: native evaluation.** Nine of them, one per cube.

Every cube's formula is refuted by its certificate — the obligation
`add_one_le_chromaticNumber_plane_of_cubes` and `not_colorable_of_cubes` both take, named once here
so the nine certificate checks are evaluated once rather than once per consumer.

`List.forall_iff_forall_mem.mp ⟨…⟩` rather than `intro cb hcb; fin_cases hcb; exacts [...]`: a plain
tuple, no tactic search, and a misfiled certificate reports *every* mismatched entry rather than
stopping at the first. Nine entries in `moserSpindleCubes` order — the order
`scripts/Dimacs.lean` and `scripts/EmitLrat.lean` both walk. -/
theorem moserSpindleCubes_unsat : ∀ cb ∈ moserSpindleCubes,
    (coloringCNF 3 7 moserSpindleEdges ++ cubeCNF 3 7 cb).Unsat :=
  List.forall_iff_forall_mem.mp
    ⟨unsat_of_check (π := spindleCubeCert0) (by native_decide),
     unsat_of_check (π := spindleCubeCert1) (by native_decide),
     unsat_of_check (π := spindleCubeCert2) (by native_decide),
     unsat_of_check (π := spindleCubeCert3) (by native_decide),
     unsat_of_check (π := spindleCubeCert4) (by native_decide),
     unsat_of_check (π := spindleCubeCert5) (by native_decide),
     unsat_of_check (π := spindleCubeCert6) (by native_decide),
     unsat_of_check (π := spindleCubeCert7) (by native_decide),
     unsat_of_check (π := spindleCubeCert8) (by native_decide)⟩

/-- **Trust purchase: native evaluation.** Inherited from the nine cube certificates.

The spindle needs four colours, **through the cube split**. -/
theorem moserSpindle_not_colorable_three_cubes : ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 :=
  not_colorable_of_cubes moserSpindleSplit moserSpindleCubes moserSpindleCubes_eq
    moserSpindleCubes_unsat

/-! ## The headline -/

/-- **χ(ℝ²) ≥ 4.** The Moser spindle is a unit-distance graph in the plane needing four colours.

Proved through route A, so the axiom list is `propext`, `Classical.choice`, `Quot.sound` and
nothing else — a fully kernel-checked bound. -/
theorem four_le_chromaticNumber_plane :
    4 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  moserSpindle.add_one_le_chromaticNumber_plane_of_valid (k := 3) moserSpindle_valid
    moserSpindle_not_colorable_three

/-- **Trust purchase: native evaluation.** Inherited from the nine cube certificates.

The same bound assembled the way M05 must assemble its own: exact geometry plus verified
certificates, through `add_one_le_chromaticNumber_plane_of_cubes`. It exists to prove that the M05
call site type-checks with real data in it — and that it is one term, not a proof script. -/
theorem four_le_chromaticNumber_plane_certified :
    4 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  moserSpindle.add_one_le_chromaticNumber_plane_of_cubes (k := 3) moserSpindle_valid
    moserSpindleSplit moserSpindleCubes moserSpindleCubes_eq moserSpindleCubes_unsat

/-! ## Spec checks

The encoder, checked against real assignments in both directions on every build — so `coloringCNF`
is known to track the colouring rather than answer a constant, which no amount of `Unsat` evidence
could establish.

The assignments below are **written out by hand** rather than built with the module's own
`ofColoring`. That is deliberate: an encoder checked with the same machinery that produced its
satisfying assignments only tests self-consistency. Here the two sides are independent. -/

section Spec

-- Seven at-least-one clauses, plus three per edge.
#guard (coloringCNF 3 7 moserSpindleEdges).clauses.size = 40

-- A real 4-colouring satisfies the 4-colour encoding. Variable `4 * v + c` is true iff vertex `v`
-- has colour `c`.
#guard CNF.eval (fun m => m % 4 == [0, 1, 2, 0, 1, 2, 3].getD (m / 4) 0)
          (coloringCNF 4 7 moserSpindleEdges)

-- The best available 3-colouring fails, and fails on an *edge* clause: vertices 3 and 6 are
-- adjacent and both land on colour 0.
#guard !CNF.eval (fun m => m % 3 == [0, 1, 2, 0, 1, 2, 0].getD (m / 3) 0)
          (coloringCNF 3 7 moserSpindleEdges)

-- Nine cubes over two vertices at three colours.
#guard moserSpindleCubes.length = 9

/-! ### Negative controls on the certificate pipeline

The build already proves every certificate *does* check — that is what `moserSpindleCubes_unsat`
is. Nothing in the build proves a certificate can **fail**, and a checker that accepted everything
would satisfy every theorem in this file. These are the checks that the pipeline discriminates.

They run interpreted at elaboration, cost milliseconds, and buy no axioms: `#guard` is a command,
not a proof. -/

-- A certificate does not check against a cube it was not made for. Certificate 0 refutes the cube
-- giving vertices 0 and 1 both colour 0 — adjacent, so immediate — and that refutation cannot
-- transfer to a cube that colours them differently.
#guard !LRAT.check spindleCubeCert0
          (coloringCNF 3 7 moserSpindleEdges ++ cubeCNF 3 7 [(0, 1), (1, 0)])

-- No certificate refutes a satisfiable formula. At four colours the spindle *is* colourable
-- (`moserSpindle_colorable_four`), so nothing can certify otherwise.
#guard !LRAT.check spindleCert (coloringCNF 4 7 moserSpindleEdges)

-- The diagnostic names the culprit rather than merely saying "no": swapping certificates 0 and 1
-- must report exactly indices 0 and 1, with the cubes they were filed against.
#guard (badCubes 3 7 moserSpindleEdges moserSpindleCubes
          (spindleCubeCert1 :: spindleCubeCert0 :: spindleCubeCerts.drop 2)).map (·.1) = [0, 1]

-- A ledger with certificates missing reports them, rather than letting `zip` drop them silently.
#guard (badCubes 3 7 moserSpindleEdges moserSpindleCubes
          (spindleCubeCerts.take 7)).map (·.1) = [7, 8]

end Spec

/-! ## A fourth route: the forcer and its spindle

`Forcer.lean` states the argument both known rungs of this problem share — a configuration that
paints two of its points the same colour in every `k`-colouring, placed twice so the copies share
the first point and the second points land a unit apart. de Grey's graph is that argument at four
colours on 791 points. **The Moser spindle is it at three colours on four**, and the decomposition
is exact rather than approximate:

    rhombus                                (0,1) (0,2) (1,2) (1,3) (2,3)
    rhombus under 0,1,2,3 ↦ 0,4,5,6        (0,4) (0,5) (4,5) (4,6) (5,6)
    the joining edge                       (3,6)

So this route decides a **four**-vertex rhombus and places it twice, where the three routes above
each decide the whole seven-vertex graph. It is here rather than in `Forcer.lean` so that a reader
comparing routes finds them in one file, and so that the general module depends on no instance. -/

namespace SpindleForcer

/-- The first rhombus, as it sits in the Moser spindle: the identity on `0,1,2,3`. -/
def copyA : Fin 4 → Fin 7 := ![0, 1, 2, 3]

/-- The second rhombus: the same four vertices carried to `0,4,5,6`, sharing the pivot `0`. -/
def copyB : Fin 4 → Fin 7 := ![0, 4, 5, 6]

/-- The two placed copies and the joining edge, **built** by `spindleEdges` rather than written out,
so this exercises the same construction a search's output uses. -/
def edges : List (Fin 7 × Fin 7) := spindleEdges copyA copyB rhombus (copyA 3, copyB 3)

-- **The decomposition is checked, not asserted.** A placement typo that quietly built a different
-- graph would go red here rather than prove a theorem about something else.
#guard edges.length = moserSpindleEdges.length
#guard edges.all (· ∈ moserSpindleEdges)
#guard moserSpindleEdges.all (· ∈ edges)

-- The pivot really is shared, and the partners really are the joining edge's ends.
#guard copyA 0 == copyB 0
#guard (copyA 3, copyB 3) == ((3 : Fin 7), (6 : Fin 7))

end SpindleForcer

/-- **The Moser spindle has no 3-colouring, from the rhombus that forces its far corners.**

The fourth independent route to `moserSpindle_not_colorable_three`, and the only one that never
looks at all seven vertices at once. -/
theorem moserSpindle_not_colorable_three_spindled :
    ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 :=
  not_colorable_of_spindled_forcer
    (edgeHom SpindleForcer.copyA (by decide)) (edgeHom SpindleForcer.copyB (by decide))
    rfl (by refine ⟨by decide, Or.inl (by decide)⟩) rhombus_forces

/-- **The same rung through the construction route**, which is the one that scales: the graph is
*constructed* by `spindleEdges`, so neither placement is searched for — only three disequality
checks linear in the forcer's edge list. This is the shape a candidate the search proposes arrives
in, exercised here at a size where the answer is known by hand. -/
theorem spindleFromRhombi_not_colorable_three :
    ¬ (edgeGraph 7 SpindleForcer.edges).Colorable 3 :=
  not_colorable_spindleEdges (E := rhombus) (p := 0) (q := 3)
    SpindleForcer.copyA SpindleForcer.copyB (by decide) (by decide) rfl (by decide) rhombus_forces

-- **A model of every hypothesis the closing lemma has**, so none of it quantifies over an empty
-- domain: the spindle is 4-colourable, the rhombus forces at three colours, and both placements
-- exist above.
example : (edgeGraph 7 moserSpindleEdges).Colorable 4 :=
  colorable_iff_exists.mpr ⟨![0, 1, 2, 0, 1, 2, 3], by simp only [edgeGraph_adj]; decide⟩

-- **The joining edge is load-bearing.** Delete `(3,6)` and the remaining ten edges are 3-colourable,
-- so `hjoin` cannot be dropped from the closing lemma.
example : (edgeGraph 7 [(0,1), (0,2), (0,4), (0,5), (1,2), (1,3), (2,3), (4,5), (4,6), (5,6)]
    ).Colorable 3 :=
  colorable_iff_exists.mpr ⟨![0, 1, 2, 0, 1, 2, 0], by simp only [edgeGraph_adj]; decide⟩

-- **The shared pivot is load-bearing, and this is the control easiest to get wrong.** Place the
-- second rhombus on four *fresh* vertices, keep both forcers and keep a joining edge `(3,7)`, and
-- the union is 3-colourable after all. Each copy still forces its own pair; what fails is that the
-- two forced colours are now unrelated.
example : (edgeGraph 8 [(0,1), (0,2), (1,2), (1,3), (2,3),
                        (4,5), (4,6), (5,6), (5,7), (6,7), (3,7)]).Colorable 3 :=
  colorable_iff_exists.mpr ⟨![0, 1, 2, 0, 1, 0, 2, 1], by simp only [edgeGraph_adj]; decide⟩

end HadwigerNelson
