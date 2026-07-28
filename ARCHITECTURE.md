# Architecture — the Hadwiger–Nelson problem in Lean 4

> How many colours does the plane need so that no two points at distance exactly 1 share one?
> Nelson, 1950. Bounded in `[4,7]` that same year; de Grey moved the floor to 5 in 2018. This
> workspace formalizes the floor and then tries to raise it.

## 1. The statement

Everything aims at one declaration, phrased against Mathlib so it is citable rather than bespoke:

```lean
/-- The unit-distance graph on a metric space: `x ~ y` exactly when `dist x y = 1`. -/
def unitDistanceGraph (V : Type*) [MetricSpace V] : SimpleGraph V :=
  SimpleGraph.fromRel fun x y => dist x y = 1

theorem chromaticNumber_plane_ge_five :
    5 ≤ (unitDistanceGraph (EuclideanSpace ℝ (Fin 2))).chromaticNumber
```

`SimpleGraph.chromaticNumber : ℕ∞` is `⨅ n ∈ {n | G.Colorable n}, n`, and
`chromaticNumber_le_iff_colorable : G.chromaticNumber ≤ n ↔ G.Colorable n` turns the goal into
`¬ Colorable 4`, i.e. **no function `ℝ² → Fin 4` avoids monochromatic unit-distance pairs**.

Getting this statement right is the highest-stakes decision in the project. The characteristic
failure of machine-written Lean is proving the wrong theorem efficiently, and here the wrong
theorem is easy to write and looks identical: an `≠ 1` where `= 1` belongs, a `≤` for a `<`, a
graph whose `Adj` is vacuous, a quantifier over the empty set. § 6 is the defence.

## 2. The shape of the argument

```
                    chromaticNumber_plane_ge_five
                                │
              ¬ Colorable 4 (unitDistanceGraph ℝ²)
                                │   restrict a plane colouring to a finite witness
                    ¬ Colorable 4 (deGrey.graph)
                    ╱                           ╲
     every listed edge has length 1        the abstract graph has no 4-colouring
     ── exact field arithmetic ──          ── verified LRAT checker ──
     Q(√3,√5,√7,√11) as ℤ-tower           Std.Tactic.BVDecide.LRAT.check_sound
```

Two certified computations, joined by one reduction. Neither computation is trusted on its own
say-so, and the two failure modes are independent: bad geometry means the "graph" is not a
unit-distance graph (caught by the field arithmetic); bad combinatorics means it is 4-colourable
(caught by the checker, which cannot certify a satisfiable formula).

### 2.1 Geometry — why exact arithmetic, and which field

De Grey's coordinates are built from √3 and √11 (the seed points), √15 (rotation by
`2·arcsin(1/4)`: `cos = 7/8`, `sin = √15/8`), and √7 (rotations by `π/2 ± arcsin(1/8)`:
`cos = ∓1/8`, `sin = 3√7/8`). So every vertex lives in the **multiquadratic field
ℚ(√3,√5,√7,√11)** — degree 16 over ℚ, with basis `{√(∏S) : S ⊆ {3,5,7,11}}`.

We represent it as an **iterated quadratic extension with ℤ leaves**, all coordinates carrying one
global denominator `scale`:

```lean
structure Adjoin (d : ℕ) (K : Type) where   -- K[√d]
  re : K
  im : K                                     -- coefficient of √d

abbrev Q4 := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))
```

ℤ leaves, not ℚ: the Lean kernel accelerates `Nat`/`Int` with GMP, but `Rat` multiplication routes
through `Nat.gcd`, which it does not. A rational representation would make the geometry check
unreducible in the kernel; an integer one keeps it in reach.

The load-bearing observation, and the reason this stays cheap: **we never need the embedding
`Q4 → ℝ` to be injective.** We only need it to be a *ring homomorphism*. A vertex list that
happened to name one plane point twice would be harmless — the reduction restricts a plane
colouring along the map, so extra edges only make the graph harder to colour, and a spurious
"edge" between two names for the same point would fail the `distSq = 1` check anyway. This deletes
the entire number-theoretic burden (linear independence of the 16 basis monomials over ℚ) from the
proof. One `Real.sq_sqrt` per generator is the whole story.

### 2.2 Combinatorics — why LRAT, and what it costs

`k`-colourability of a graph on `Fin n` becomes a CNF over `n·k` variables (`x_{v,c}` at index
`v*k+c`):

- one **at-least-one-colour** clause per vertex, `⋁_c x_{v,c}`;
- for each edge and colour, `¬x_{u,c} ∨ ¬x_{w,c}`.

At-most-one clauses are deliberately omitted: the edge clauses already force the colour sets of
adjacent vertices to be disjoint, so any satisfying assignment yields a proper colouring by
choosing an arbitrary colour per vertex. Fewer clauses, same theorem — and the direction we must
prove is only `Colorable k → Sat cnf`, whose contrapositive is what we want.

Unsatisfiability comes from `Std.Tactic.BVDecide.LRAT`, shipped **verified** in Lean core:

```lean
def check (lratProof : Array IntAction) (cnf : CNF Nat) : Bool
theorem check_sound : check lratProof cnf → cnf.Unsat
```

CaDiCaL (bundled at `$(lean --print-prefix)/bin/cadical`) is an untrusted oracle proposing the
certificate. The residual trust question is only *how the `Bool` is evaluated* — kernel `decide`
or `native_decide`. See § 5.

### 2.3 The colour-cube split — mandatory, not an optimization

**Measured, 2026-07-23, 32-core box.** A monolithic CaDiCaL run on the full 6324-variable /
33089-clause instance (8 configurations raced: `--unsat`, default, `--plain`, `--sat`, two seeds
each) **did not terminate within 10 minutes, and the partial LRAT was already 2.0 GB.** Extrapolating
a certificate of that order into Lean is hopeless for the kernel and painful even for
`native_decide` (LRAT-Catcher reports ~9 GB resident for a 628 MB certificate). So the split below
is load-bearing, not a wall-clock nicety.

CaDiCaL is single-threaded. Rather than race one monolithic run, split the search:

```lean
theorem not_colorable_of_cubes (W : List (Fin n))
    (h : ∀ φ : Fin W.length → Fin k, ¬ ∃ c : Coloring, ∀ i, c W[i] = φ i) : ¬ Colorable k G
```

— trivial to prove (a colouring induces its own cube), `k^|W|` independent CaDiCaL runs, and each
subproblem is much easier. This is not only 32× wall-clock; **many small certificates are far more
likely to be kernel-reducible than one large one**, which is the difference between paying
`Lean.ofReduceBool` and not. Two multipliers on top:

- **Colour symmetry.** Max clique in a plane unit-distance graph is 3 (four mutually
  unit-distant points would be a regular tetrahedron), and these graphs are full of unit
  triangles. Fixing one triangle to colours `0,1,2` is sound via a permutation of `Fin 4` and
  cuts the space by `4! = 24`.
- **Certificate trimming.** `Lean.Meta.Tactic.BVDecide.LRAT.Trim` ships in the toolchain.

## 3. Module DAG (leaf-first)

```
Mathlib ─┐
         ├─► HadwigerNelson/UnitDistance.lean      graph on a metric space; χ transfer   [M01]
         │
Std.Sat ─┤
         ├─► HadwigerNelson/Field/Quadratic.lean   Adjoin d K, CommRing, eval : K →+* ℝ  [M02]
         │        └─► HadwigerNelson/Geometry/Point.lean   Pt K, toPlane, distSq         [M02]
         │                 └─► HadwigerNelson/Certificate.lean   UDCert, Valid, sound    [M02]
         │
         ├─► HadwigerNelson/Sat/Encoding.lean      colouringCNF + Colorable → Sat        [M03]
         │        └─► HadwigerNelson/Sat/Lrat.lean  certificate ingestion, cube cover    [M03]
         │
         └─► HadwigerNelson/Reduction.lean          UDCert + Unsat ⟹ bound on χ          [M03]
                  ├─► HadwigerNelson/Instances/Spindle.lean   Moser spindle, χ ≥ 4       [M03]
                  └─► HadwigerNelson/Instances/DeGrey.lean    1581 vertices, χ ≥ 5   [M04–M05]

HadwigerNelson.lean  — flat public surface
tools/               — UNTRUSTED generators (Python): graph construction, DIMACS, cube split
```

## 4. Roadmap

Leaf-first, one milestone at a time, green manifold at every step. Subplans in `plans/`.

| # | Milestone | Terminal test |
|---|---|---|
| **M01** | **The statement.** `unitDistanceGraph`; transfer from a finite witness to `χ(ℝ²)`. No data, no SAT. | `chromaticNumber_ge_of_not_colorable_finite` green; the statement reads correctly against the informal claim; a concrete model of the hypotheses exhibited. |
| **M02** | **Exact geometry.** Quadratic tower + `eval` ring hom + `UDCert` and its soundness. | Moser spindle's 7 points / 11 edges certified unit-distance by kernel `decide`; `#eval` shows the right numerics. |
| **M03** | **The SAT bridge, and χ ≥ 4.** `colouringCNF`, `Colorable → Sat`, LRAT ingestion, cube cover. | Spindle non-3-colourable **twice** — by `decide` and through LRAT — and `4 ≤ χ(ℝ²)` with a clean axiom list. |
| **M04** | **de Grey's graph as certified data.** 1581 vertices, 7877 edges, geometry verified in Lean. | `deGrey.Valid = true`; vertex/edge counts match the paper (397 / 1581 / 7877 — already reproduced by `tools/degrey.py`). |
| **M05** | **χ(ℝ²) ≥ 5.** Cube split, certificates ingested, `¬ Colorable 4`, headline theorem, trust receipt. | `chromaticNumber_plane_ge_five` green, zero `sorry`, `#print axioms` recorded, `lean4checker` re-check. |
| **M06** | **Shrinking.** Re-verify smaller witnesses (Heule 553, Parts 509) on the same infrastructure; automate vertex-deletion search. | A certified witness strictly smaller than 1581. |
| **M07** | **Fractional bounds.** Fractional chromatic number machinery; the 383/102 record as a certified statement. | A certified fractional lower bound. |
| **M08** | **The hunt.** Gadget algebra, spindle catalogs, composition search for a 6-chromatic witness. | Honest report — including "not found". |

M01–M05 constitute rung B and are the publishable unit. M06+ is rung C, and M08 is rung D.

## 5. Trust

The de Bruijn criterion, operationalized. Audited by `scripts/Axioms.lean` at every milestone.

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `Lean.ofReduceBool` | **purchase — recorded below, per declaration** |

*Purchases so far: none.*

Two `Bool`s carry the weight, and each has a kernel route and a native route:

1. **`UDCert.Valid deGrey`** — 7877 edge checks over a 16-dimensional ℤ-algebra. **Measured
   (2026-07-23): kernel-feasible, but only in chunks.** ~0.17 s/edge and memory roughly linear in
   the chunk size; a single `List.all` over all 7877 edges was still running at 5 minutes and 8.5 GB
   when aborted, while 514 edges take 87 s and ~0.85 GB. M04 therefore splits the check into ~16–32
   independent slices, which parallelise. No trust is spent — the chunks' conjunction is the whole
   theorem. Two representation findings fed this: indexed lookup costs the same as pre-resolved
   endpoint pairs (the tower arithmetic dominates, not the lookup), and multiplying by the radicand
   as a *scalar* rather than a ring element is a measured 1.67×.
2. **`LRAT.check π cnf`** — the certificate check. Measurement (§ 2.3) has already settled the
   monolithic case: not reducible by anything, kernel or native. The cube split is how this becomes
   tractable at all, and how it might become kernel-reducible. If it does not, we buy
   `Lean.ofReduceBool` here, name it in the docstring, and keep the kernel route as tracked open
   work. **This is the one place where the project may end up trusting the compiler, and it will
   say so out loud.**

`lean4checker` (independent kernel, via elan) re-checks at each milestone boundary.

Not trusted, and not on the critical path: `tools/*` (generators), CaDiCaL, the float grid used to
propose candidate edge pairs. Every claim they make is re-derived in Lean from the emitted data.

## 6. Defences against proving the wrong theorem

A green checkmark certifies exactly the statement written. The specific ways this project could
produce a meaningless one, and the specific countermeasure for each:

| Failure | Defence |
|---|---|
| `unitDistanceGraph` has vacuous `Adj` (e.g. `fromRel` collapsing) | `example : (unitDistanceGraph ℂ).Adj 0 1` proved; a non-adjacency proved too |
| CNF encoding subtly wrong, making *any* graph "unsatisfiable" | Moser spindle proved non-3-colourable by `decide` **and** by LRAT; and `colouringCNF` on a 3-colourable graph shown **satisfiable** |
| Vertex list degenerate (all points equal / empty) | vertex count and edge count asserted by `#guard`; a `#eval` of several distances |
| Wrong direction of the bridge (proving `Sat → Colorable`) | the reduction only ever consumes `Colorable → Sat`; stated with `¬` on the outside and read aloud |
| `χ ≥ 5` stated as `χ > 5`, `≤`, or over `ℕ` with truncation | statement in `ℕ∞`, cross-checked against `chromaticNumber_le_iff_colorable`, plus a deliberately-failing variant kept in a comment |
| Certificate from a *different* CNF than the one we reason about | the CNF is defined once in Lean; the DIMACS handed to CaDiCaL is printed **from that Lean definition** via `Std.Sat.CNF.dimacs`, not re-derived in Python |

That last row is a hard rule: **the Python side never authors the CNF.** It authors candidate
geometry only.

## 7. Honest failure modes

Stated up front, per doctrine, and to be reported as-is:

- **The 6-chromatic witness may not exist, or may be astronomically large.** χ could be 5, 6, or 7.
  Polymath16 and strong SAT researchers stalled at exactly this point. Rung D is a genuine gamble;
  rungs A–C are not, which is why the ratchet is built the way it is.
- **Kernel-reducibility of the certificate is unproven at this size.** If it fails we pay
  `ofReduceBool` and say so; the theorem is still worth having (it is the standard for SAT-backed
  formalization) but it is a weaker artifact than a kernel-only one.
- **Our marginal edge at rung D is unproven at this scale.** Persistence, verified modular
  composition, and no fatigue in a gadget search are real advantages, but nobody has demonstrated
  they are enough here.
