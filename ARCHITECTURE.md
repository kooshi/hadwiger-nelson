# Architecture — the Hadwiger–Nelson problem in Lean 4

> How many colours does the plane need so that no two points at distance exactly 1 share one?
> Nelson, 1950; bounded in `[4, 7]` that year; de Grey moved the floor to 5 in 2018. This repository
> kernel-checks the whole classical interval, **5 ≤ χ(ℝ²) ≤ 7**, on axioms exactly
> `[propext, Classical.choice, Quot.sound]`, and hunts above it.

This file describes the code as it stands: the statement (§ 1), how the two certified computations are
built and why (§ 2), the module map read off the import graph (§ 3), where the roadmap lives (§ 4),
trust (§ 5), the defences against proving the wrong theorem (§ 6), and the standing limits (§ 7). What
the results mean and what to work on next is `CLAUDE.md` § Frontier. The file is rewritten in place and
its history is in git; the last version before the 2026-09-10 rewrite is commit `fcbee06`.

## 1. The statement

```lean
-- UnitDistance.lean
def unitDistance (V : Type*) [MetricSpace V] : SimpleGraph V where
  Adj x y := dist x y = 1

-- Instances/Interval.lean
theorem chromaticNumber_plane_interval :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ∧
      (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7
```

The lower half is `chromaticNumber_plane_ge_five` (`Instances/DeGrey/Bound.lean`, proved again from two
unrelated witnesses as `chromaticNumber_plane_ge_five_510` and `chromaticNumber_plane_ge_five_553`); the
upper half is `chromaticNumber_plane_le_seven` (`Instances/Seven.lean`). `SimpleGraph.chromaticNumber` is
valued in `ℕ∞`, and `chromaticNumber_le_iff_colorable` turns a lower bound into `¬ Colorable k`: **no
function ℝ² → Fin k avoids monochromatic unit-distance pairs.**

Three generalizations carry the rest of the library, each stated once:

- **The plane as ℂ.** Most theorems work over `unitDistance ℂ`. `chromaticNumber_plane_eq_complex`
  (`Reduction.lean`) is an equality, proved by an isometry, so nothing is lost crossing it.
- **Other forbidden distances.** `distanceGraph V D` for any set `D` (`DistanceGraph.lean`), with
  `unitDistance_eq_distanceGraph_singleton`.
- **Other coordinate rings.** `unitQuadrance R` over any commutative ring and its instance
  `finitePlane p` at `ZMod p` (`UnitQuadrance.lean`). A plane over a number field is an induced subgraph
  of `unitDistance ℂ` (`seamPlane` in `FieldWall4.lean`).

Getting the statement right is the highest-stakes decision in the project. The characteristic failure of
machine-written Lean is proving the wrong theorem efficiently, and here the wrong theorem is easy to
write and looks identical: `≠ 1` for `= 1`, `≤` for `<`, a graph whose `Adj` is vacuous, a quantifier over
an empty type. § 6 is the defence.

## 2. The shape of the argument

```
                        chromaticNumber_plane_ge_five
                                     │
        restrict a colouring of the plane to a finite drawing   (UnitDistance, Reduction)
                                     │
                 ¬ Colorable 4 (edgeGraph 1581 deGreyRot.edges)
                 ╱                                          ╲
   every listed edge has length 1                  no proper 4-colouring exists
   exact arithmetic in Q4 = ℚ(√3,√5,√7,√11)        a refutation checker the kernel runs
   deGreyRot_valid                                 deGreyRot_not_colorable_four
```

Two certified computations, joined by one reduction. Neither is trusted on its own say-so, and their
failure modes are independent: bad geometry means the graph is not a unit-distance graph, and the exact
arithmetic refuses it; bad combinatorics means the graph is 4-colourable, and the checker cannot certify
a satisfiable formula. Every lower bound in the repository has this shape. Upper bounds replace the
refutation by a colouring the kernel checks proper: a periodic table on the plane (`Brick.lean`), a
residue map on a number-field plane (`ResidueColouring.lean`, `FieldWall4.lean`), or a table on a finite
plane pulled back along a ring homomorphism (`UnitQuadrance.lean`).

### 2.1 Geometry — why exact arithmetic, and which field

De Grey's coordinates are built from √3 and √11 (the seed points), √15 (rotation by `2·arcsin(1/4)`:
`cos = 7/8`, `sin = √15/8`) and √7 (rotations by `π/2 ± arcsin(1/8)`: `cos = ∓1/8`, `sin = 3√7/8`).
Every vertex therefore lives in the **multiquadratic field ℚ(√3,√5,√7,√11)** — degree 16 over ℚ, basis
`{√(∏S) : S ⊆ {3,5,7,11}}` — represented as an iterated quadratic extension with ℤ leaves and one global
denominator per certificate (`Field/Quadratic.lean`):

```lean
structure Adjoin (d : ℕ) (K : Type*) where   -- K[√d]
  re : K
  im : K                                      -- the coefficient of √d

abbrev Q4 : Type := Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))
```

**ℤ leaves, not ℚ.** The kernel accelerates `Nat` and `Int` with GMP, but `Rat` multiplication routes
through `Nat.gcd`, which it does not. A rational tower would put the geometry check out of the kernel's
reach.

**The embedding `Q4 → ℝ` is never claimed injective; it is only a ring homomorphism** (`Q4.eval`). A
vertex list that names one plane point twice is harmless: the reduction restricts a plane colouring along
the map, extra edges only make a graph harder to colour, and a spurious "edge" between two names for one
point fails `distSq = 1` anyway. That deletes the linear independence of the sixteen basis monomials from
the proof — one `Real.sq_sqrt` per generator is the whole of the number theory. It is also why
`Motion.lean` cancels scale factors as natural numbers (`NatCancel`) rather than in `Q4`, which is not
known here to be a domain.

Where a theorem needs more than a ring homomorphism, it buys exactly that:

- **Real distinctness of given values**: integer interval bounds on literals (`Field/Approx.lean`,
  `index_eq_of_eval_eq`), still with no injectivity claim.
- **Linear independence**: proved locally, for the radicals a theorem uses — `sqrt_indep` over
  `{1, √3, √11, √33}` (`Ladder.lean`), `sqrt5_indep` by a mod-5 descent (`Quadrature.lean`).
- **Another field**: its own order, not a larger tower. Theorem B works in `ℤ[ω, i, T]` with
  `T = (1+√33)/2`, built from one generic quadratic layer `Quad` (`FieldWall4.lean`); certificates reach
  it through the √5- and √7-free subring `Q4.seamFree` (`SeamCert.lean`).
- **A finite plane**: a certificate reduces into any ring, given a subring holding its coordinates, a ring
  homomorphism out of it and an inverse of the denominator (`UDCert.drawing_adj`); at `p = 11` through
  `Q4.sevenFree`, the √7-free elements.

**Packed geometry** (`Packed.lean`). A squared distance depends only on a difference, and these graphs
have few distinct differences — 133 for de Grey's 7,877 edges, 66 and 82 for Heule's two witnesses. The
check pays two squarings in `Q4` once per difference and one big-integer subtraction per edge over packed
coordinates (`UDCert.valid_of_diffWitness`): de Grey's geometry costs 55.9 CPU seconds in two modules,
against 246.2 in nine unpacked. The number of differences grows with the construction (it doubles when
the construction doubles); what stays stable is the ratio, about 118 edges per difference.

### 2.2 Combinatorics — why a kernel-run LRAT checker

`k`-colourability of a graph on `Fin n` becomes a CNF over `n·k` variables (`coloringCNF`,
`Sat/Encoding.lean`): one at-least-one-colour clause per vertex, and `¬x_{u,c} ∨ ¬x_{w,c}` for each edge
and colour. At-most-one clauses are omitted: the edge clauses already make adjacent vertices' colour sets
disjoint, so a satisfying assignment yields a proper colouring by choosing one colour per vertex, and the
only direction consumed is `Colorable k → Sat`. CaDiCaL, bundled with the toolchain, is an untrusted
oracle; the DIMACS it reads is printed from the Lean definition (`scripts/Dimacs.lean`, via
`Std.Sat.CNF.dimacs`).

**Core's verified checker cannot be run by the kernel.** `Std.Tactic.BVDecide.LRAT.check` ships with
`check_sound`, but on the smallest unsatisfiable CNF with a one-action certificate, `decide +kernel`
sticks inside `Formula.performRupAdd`: `DefaultClause.ofArray` builds a `Std.HashMap`, whose bucket index
computes on `USize`, whose width is an `@[extern] opaque`. Only `native_decide` evaluates it, and that is a
trust purchase (§ 5). It is ingested in `Sat/Lrat.lean` and used only by the Moser spindle's cross-check
routes.

**So the checker is this repository's own** (`Sat/Mask.lean`, `Sat/ClauseTable.lean`,
`Sat/MaskCheck.lean`). Every clause a refutation touches — the formula's and the solver's derived ones —
lives in one emitted literal table, re-checked against the formula Lean computes (`agreesWithCNF`). A
certificate is hint lists only: clause ids are consumed densely, so the checker's whole state is a
watermark. `maskCheck_sound` is proved for every decoder, so the certificate's packing is untrusted as a
matter of type. A certificate is cut into segments, each an implication from one watermark to the next,
which compose only if they chain, and which elaborate in parallel. Measured: about 1.35 ms of kernel time
per hint entry, and a segment's memory peak of about 3.4 GB + 0.81 GB per certificate chunk.

The certificates in the tree:

| Witness | What is refuted | Size | Where |
|---|---|---|---|
| de Grey's 1581, 4 colours | one 791-vertex copy's forcing; the other copy is the same refutation moved by `deGrey_rotation` | 18,441,901 hint entries, 1,222 segments, 15.0 CPU hours | `Instances/DeGrey/HalfA/` |
| Heule's 510 and 553, 4 colours | the whole graph, one triangle's colours pinned | 1,413,841 and 1,104,106 propagation steps, 82 segments each | `Instances/Heule510/Cnf/`, `Instances/Heule553/Cnf/` |
| Mycielski-47, 5 colours | the whole graph | 387,065 propagation steps, 16 segments | `Instances/Mycielski/Cnf/` |
| the 122-point carrier, 4 colours | the pair-augmented edge list | 7,892 derived clauses, 16 segments | `Instances/Core122/Cnf/` |
| the 23-vertex gap core, 6 colours | the core's constraint graph | 219 derived clauses, 2 segments | `Instances/Core23/Cnf/` |

Two levers shape every certificate, both measured on Heule's witnesses: **pinning one triangle's colours**
(sound by a palette permutation, `exists_perm_apply_eq`; 20× there, 160× at six colours on the gap core),
and **racing solver configurations on the trimmed hint count** (a further 10.5×).

**Composition beats monolithic search at scale.** A gadget (`Gadget.lean`) turns a refutation into a
checked property of a few port vertices, and properties compose by intersection, widening and transport
along vertex maps. De Grey's proof is three gadgets on three vertices (`Instances/DeGrey/Forcing.lean`):
one refutation, the same refutation transported by a rotation, and the joining edge. The monolithic
instance does not finish under any solver setup tried (six configurations with proof logging, six
without, and a 64-cube split): two loosely coupled copies joined at one vertex defeat clause learning,
while handing a human a two-line argument.

### 2.3 The colour-cube split — sound, useful to the solver, dead as a certificate route

`not_colorable_of_cubes` (`Sat/Encoding.lean`): fix the colours of a vertex list `W`; the `k^|W|`
sub-instances cover the original, and the proof is one line, since a colouring induces its own cube. It
exists because a monolithic CaDiCaL run on de Grey's full instance — 6,324 variables, 33,089 clauses, eight
configurations raced — did not finish in 10 minutes and had already emitted 2.0 GB of partial LRAT.

As a route to a checked proof it is dead at de Grey's scale, by measurement: all 1,024 depth-5 cubes
solved to UNSAT carry 3.06 × 10⁹ hint entries (1.50 × 10⁹ after trimming), projected at 563 CPU hours
against a 40-hour threshold, as about 4 GB of certificate literals. `native_decide` does not rescue it:
the obstacle is data volume, not trust — compiled evaluation checks a term the elaborator must accept
first, and Lean does not elaborate certificate data at that scale. Deeper splits are worse (7.16× the
hints per three more pinned vertices). The numbers are in `plans/M06-chi-ge-five.md` § 0, which
supersedes `plans/spike-kernel-lrat.md` § 4's sampled 1.30 × 10⁷ (wrong by 115×).

Cubes survive where their count is small: the Moser spindle's nine-cube route
(`Instances/SpindleBound.lean`), and composed objects whose cube cover is itself a kernel pigeonhole.

### 2.4 The kernel facts the layout depends on

The general cost model is `CLAUDE.md` § The kernel's cost model. These are the parts that fix this
repository's shape:

- **Reduction steps are the cost; bit width is not.** GMP-backed `Nat` arithmetic and bitwise operations
  are free at thousands of bits, so certificates pack many values into few big `Nat` literals, and tables
  are emitted as literals rather than accumulated during a kernel evaluation.
- **Geometry is chunked.** The unpacked edge check runs at about 0.17 s per edge with memory linear in
  the chunk; one `List.all` over 7,877 edges was still running at 5 minutes and 8.5 GB. Validity is a
  conjunction of chunks (`valid_of_chunks`), and packing (§ 2.1) removed most of the work.
- **Doc strings are environment data.** Editing a declaration or a `/-- -/` or `/-! -/` doc string
  rebuilds every dependent module; editing a `--` comment in place does not (measured; `CLAUDE.md`
  § Building). Upstream of a certificate family, a doc string edit costs hours (§ 3.10, § 4).
- **Memory, not time, sets the build width.** A certificate segment peaks at about 3.4 GB + 0.81 GB per
  chunk. Build only through `scripts/build.sh`.

## 3. Module map — the import graph

The library is **1,627 `.lean` files** under `Proofs/`: 74 theory modules (`Proofs/HadwigerNelson/*.lean`, `Field/` and `Sat/`), the scaffold `Proofs/Basic.lean`, 61 instance modules named one per row below, and **1,491 files in eight generated certificate families** (§ 3.9). The descriptions are written by hand; the **Imports** column, the counts, the layer table and §§ 3.9–3.10 were generated from the `import` lines, not from memory. **Imports** lists each module's direct imports inside `Proofs`, exactly as its header states them (Mathlib and `Std` imports omitted; a run of numbered siblings is written `Rows00…07`); `scripts/build_order.py` computes the same graph and is what `scripts/build.sh` builds from. **Row** is the `CLAUDE.md` § The novel-results ledger row whose result the module holds (rows name their modules or theorems) or, for a model module, the row it models; `—` means infrastructure, or a module older than the ledger. **When** is the milestone that created the module.

`Proofs.lean`, the flat import surface, imports 120 modules: every module below except the 16 emitted data modules reached through their aggregates (`Core122/Aug`, `Core122/Base`, `Core23/Edges`, `DeGrey/Diffs`, `DeGrey/Edges`, `DeGrey/Table`, `DeGrey/Valid`, `Heule510/Diffs`, `Heule510/Edges`, `Heule510/Table`, `Heule510/Valid`, `Heule553/Diffs`, `Heule553/Edges`, `Heule553/Table`, `Heule553/Valid`, `SpindleLrat`), and none of the generated families.

**The layers are acyclic**: each theory layer imports only from the layers above it in this table, apart from the 2 theory modules that import an instance module for a concrete object (§ 3.10). Generated families sit between a witness's data modules and its bound, so they import from and are imported by § 3.8.

| Layer | Imports modules from |
|---|---|
| § 3.1 Foundations | Mathlib and Std only |
| § 3.2 SAT and the checker | § 3.1 Foundations |
| § 3.3 Colouring theory | § 3.1 Foundations, § 3.2 SAT and the checker |
| § 3.4 Seam-field geometry | § 3.1 Foundations, § 3.3 Colouring theory |
| § 3.5 Where a compulsion can live | § 3.1 Foundations, § 3.2 SAT and the checker, § 3.3 Colouring theory, § 3.4 Seam-field geometry |
| § 3.6 Arithmetic colourings and planes | § 3.1 Foundations, § 3.3 Colouring theory, § 3.4 Seam-field geometry, § 3.5 Where a compulsion can live |
| § 3.7 Cell family and bricks | § 3.1 Foundations |
| § 3.8 Instances | § 3.1 Foundations, § 3.2 SAT and the checker, § 3.3 Colouring theory, § 3.5 Where a compulsion can live, § 3.6 Arithmetic colourings and planes, § 3.7 Cell family and bricks, § 3.9 generated families |

### 3.1 Foundations: the statement, graph presentations, exact geometry

The reduction every bound uses, the edge-list presentation certificates arrive in, and the exact coordinate tower.

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Basic` | Scaffold sanity module at `Proofs/Basic.lean`: `two_add_two` confirms the toolchain and Mathlib are wired. | — | — | scaffold |
| `UnitDistance` | The unit-distance graph of any metric space (`unitDistance`), its isometry invariance (`chromaticNumber_unitDistance_congr`), and the finite-drawing reduction `add_one_le_chromaticNumber_unitDistance`. | — | — | M01 |
| `EdgeList` | `edgeGraph n E`, the presentation every certificate uses (`edgeGraph_adj`), and the reduction at that shape (`add_one_le_chromaticNumber_unitDistance_edgeList`). | `UnitDistance` | — | M01 |
| `DistanceGraph` | `distanceGraph V D` for a set of forbidden distances; `unitDistance_eq_distanceGraph_singleton`, `chromaticNumber_unitDistance_le_distanceGraph`, `add_one_le_chromaticNumber_distanceGraph_edgeList`. | `EdgeList` | 44 | M49 |
| `Field/Quadratic` | One quadratic layer `Adjoin d K`, the tower `Q4 = ℚ(√3,√5,√7,√11)` with sixteen ℤ leaves, and `Q4.eval`, a ring homomorphism to ℝ never claimed injective (§ 2.1). | — | — | M02 |
| `Field/Approx` | Integer interval bounds for `Q4.eval` on literals, so given field values are certified distinct as reals without injectivity (`index_eq_of_eval_eq`, `pairwise_ne_of_sepChain`). | `Field/Quadratic` | — | M16 |
| `Certificate` | `Pt` and `UDCert n` (exact points, an edge list, one denominator), the decidable `Valid` with `valid_sound`, chunked validity `valid_of_chunks`, and `add_one_le_chromaticNumber_of_valid`. | `Field/Quadratic`, `EdgeList` | — | M02 |
| `PairDist` | `UDCert.PairsAt`: a pair list certified at one class distance √r (`UDCert.pairsAt_sound`), the form the pigeonhole carriers and the residue distance law state their pairs in. | `Certificate` | — | M34 |
| `Motion` | Exact plane similarities cleared of their denominator (rotations, reflections, translations, composition); a copy placed by a motion inherits validity with no per-edge check (`UDCert.validOn_map_of_motion`, `UDCert.validOn_map_of_scaling`). | `Certificate` | — | M09, M11 |
| `Assembly` | Many placed copies as one certificate: intra-copy edges come from the base check and only seams are checked (`valid_of_cross`); geometry and colouring transport share one map, `embed`. | `Motion`, `EdgeList` | — | M12 |
| `AssemblyDiagnose` | `#eval`-only: which seam failed, by copy and base vertex. | `Assembly` | — | M12 |
| `Packed` | Packed coordinates, one squared norm per distinct edge difference and one subtraction per edge (`DiffWitness`, `UDCert.valid_of_diffWitness`); `Packable.pack_inj` keeps the packing injective. | `Certificate` | — | M08 |
| `PackedDiagnose` | `#eval`-only geometry faults; `firstFault_eq_none_iff` ties the report to the check. | `Packed` | — | M08 |

### 3.2 SAT encoding, the kernel-run refutation checker, and the composite

The combinatorial half (§ 2.2) and the module where it meets the geometry. `Sat/Mask`, `Sat/ClauseTable` and `Sat/MaskCheck` sit upstream of every certificate family and are settled (§ 3.10).

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Sat/Encoding` | `coloringCNF k n E` (at-least-one-colour and edge clauses, no at-most-one), `not_colorable_of_unsat`, the cube cover `not_colorable_of_cubes`, palette pinning `exists_perm_apply_eq`. | `EdgeList` | — | M03 |
| `Sat/Lrat` | Ingestion of core's verified LRAT checker: `unsat_of_check`, axiom-clean itself, since whatever evaluates its hypothesis makes the trust purchase (§ 5); `badCubes` names a misfiled cube. | `Sat/Encoding` | — | M03 |
| `Sat/Mask` | Clauses and partial assignments as one bitmask type; unit propagation with `propagate_conflict_sound` and `propagate_prop_sound`. | — | — | M05 |
| `Sat/ClauseTable` | Every clause a refutation touches, emitted as a chunked literal and re-checked against the formula Lean computes (`agreesWithCNF`, `justified_of_agreesWithCNF`). | `Sat/Mask` | — | M05 |
| `Sat/MaskCheck` | The checker the kernel can run: hint lists over a watermark, cut into chaining segments (`runSegment_sound`), and `maskCheck_sound`, proved for every decoder. | `Sat/ClauseTable` | — | M05, M06 |
| `Sat/Diagnose` | `#eval`-only rendering of a failed check, downstream of the checker so rewriting it re-checks no certificate. | `Sat/MaskCheck` | — | M07 |
| `Pattern` | Colour patterns, one per partition of the positions (first-occurrence numbering): `samePattern`, `exists_mem_canonPatterns`. Mathlib only. | — | — | M11 |
| `Gadget` | `Gadget k n m E p`: a checked colouring property of port vertices, at any colour count, composable by intersection, widening and `transport`; the terminal check `survivors` and `not_colorable_of_gadget`. | `Sat/Encoding`, `Pattern` | — | M09, M11 |
| `Reduction` | Where geometry meets refutation: `chromaticNumber_plane_eq_complex` (an equality, by isometry) and `UDCert.add_one_le_chromaticNumber_plane_of_valid`, with its `…_of_unsat` and `…_of_cubes` forms. | `Certificate`, `Sat/Encoding` | — | M03 |

### 3.3 Colouring theory: forcing, fans, criticality, arity

Statements about every proper colouring of a graph at once (forced pairs, virtual edges, fans, the arity of a compulsion), none of them using plane geometry beyond `DistanceGraph`.

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Forcer` | `Forces G k p q` (every proper colouring paints the pair alike) and the spindle that closes it: `not_colorable_of_spindled_forcer`, `Forces.of_gadget`, `rhombus_forces`, `spindleEdges`. | `Gadget` | — | M13 |
| `ForcerDiagnose` | `#eval`-only: which side condition refused a spindled candidate. | `Forcer` | — | M13 |
| `Fan` | `Fan` (the pivot is painted like some partner) and `Separated` (a virtual edge); `not_colorable_of_spindled_fan`, `fan_iff_not_colorable`; a forced pair is the width-one fan. | `Forcer` | — | M14 |
| `FanMono` | Deletion never creates a fan: `edgeGraph_mono`, `Fan.of_subset`, `not_fan_of_subset`. | `Fan` | — | M17 |
| `Critical` | A fan is one removable vertex (`fan_univ_iff`, `colorable_delete_iff_exists_isolating`); `colorable_succ_of_colorable_delete`; the packed criticality certificate `no_fan_of_packed`. | `Fan` | — | M15 |
| `CriticalDiagnose` | `#eval`-only: why a criticality certificate was refused. | `Critical` | — | M15 |
| `NarrowFan` | The narrow-fan certificate (classed distances, one separating colouring per class, real distinctness from `Field/Approx`): `NarrowCert.check`, `NarrowCert.sound`. | `Field/Approx`, `Certificate`, `Critical`, `Fan` | — | M16 |
| `NarrowFanDiagnose` | `#eval`-only fault walk whose honesty is a theorem: `firstFault_none_iff_check`. | `NarrowFan` | — | M16 |
| `Coverage` | A fan is exactly compulsory colour coverage of N(p) ∪ Q: `fan_iff_coverage`. | `Fan` | 4 | M18 |
| `CoverageMono` | The coverage ratchet `CoverAtLeast`, monotone under adding edges, widening the class and lowering the level: `fan_iff_coverAtLeast`. | `Coverage` | 3 | M19 |
| `Greedy` | Greedy colouring, absent from Mathlib: `SimpleGraph.colorable_of_degree_lt`. | — | 7 | M18 |
| `Fractional` | `fractionalChromaticNumber` and the certificate-to-bound theorems `le_fractionalChromaticNumber_of_weights`, `fractionalChromaticNumber_mono_of_hom`. Mathlib only. | — | — | M10 |
| `FractionalSpec` | Validation on the graph that discriminates the definition: `C5_fractional`, χ_f(C₅) = 5/2. | `Fractional` | — | M10 |
| `IndepSearch` | The pruned kernel-run search for a heavy independent set (`noHeavy_sound`) and its plane consumer `le_fractionalChromaticNumber_unitDistance_edgeList`. | `EdgeList`, `Fractional` | — | M10 |
| `SpareColour` | The spare-colour lemma: a `k`-colourable graph has no pair compulsion at `k + 1` colours (`not_forces_of_colorable`, `not_separated_of_colorable`). | `Fan` | 45 | M51 |
| `EntropyFloor` | A `k`-colourable graph with at least `k·n` vertices has at least `2^n` proper `(k+1)`-colourings (`two_pow_le_card_coloring`), and the screen `not_colorable_of_card_coloring_lt`. | `SpareColour` | — | M51 |
| `Palette` | Compulsions depend on the palette's size, not on `Fin k`: `Forces.of_equiv`, `Separated.of_equiv`, `not_forces_of_coloring_ne`, for colourings valued in a group or a residue field. | `Fan` | — | FS-24 |
| `Arity` | The arity floor: a compulsion as a partial colouring that does not extend; `arityFloor`, `arityFloor_eq_zero_iff`, `arityFloor_le_of_degree`, `arityFloor_le_of_embedding`. | `Coverage`, `Pattern` | 42, 43 | M45, M48 |
| `Homogeneous` | Transport of a pair compulsion along an isometry: `transport_pair_of_isometry`, `Separated.planeIn`, `Forces.planeIn`. | `Arity`, `DistanceGraph` | 43 | M48 |
| `Limit` | The limit lemma: bounded-size drawings within every ε of unit length force χ (`add_one_le_chromaticNumber_unitDistance_of_bounded_family`). | `UnitDistance`, `Reduction` | 41 | M44 |
| `Mascot` | The Moser recipe's threshold: `not_forces_of_drawing` (a host with no k-clique draws no minimal forcing gadget), `not_forces_of_unit_drawing` (k ≥ 4), `exists_forces_of_unit_drawing_three`. | `Forcer`, `DistanceGraph` | 58 | 2026-09-09 |

### 3.4 Seam-field geometry: two circles, gluing, and the exact closures

Unit-distance structure over ℂ built from the hexagonal step ζ₆ and the seam rotation σ = (√3 + i√33)/6; the three closures are each exactly 4-chromatic.

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `TwoCircle` | Every unit-distance graph on the circles of radius 1 and 1/√3 about a point is 3-colourable (`colorable_three_induce`); the seam rotation has infinite order (`seam_pow_ne_one`). | `UnitDistance` | 1, 2 | M19 |
| `ClassGeometry` | The 120° class: in-class degree ≤ 2, so no class confines a fan (`not_fan_classOnlyGraph`); a unit triangle lies on a circle iff r² = 1/3 (`exists_unit_triangle_iff`); `rot3_unit_triangle`. | `Fan`, `Greedy` | 5, 6 | M18 |
| `Compulsion` | The 120° compulsion `no_mono_outer_triple` and the one-pivot cap `chromaticNumber_concentric` (= 4). | `TwoCircle`, `ClassGeometry` | 9, 10 | M20 |
| `Strip` | The strip automaton over literal tables: `twostep_card` (×12 per column) and `window_extends`. | — | 11 | M20 |
| `Coupled` | Two unit-separated pivots: each circle-pair intersection is {point, mirror} under `reflAcross` (`outer_inter_outer` and its three siblings); `four_le_chromaticNumber_of_system_subset`. | `Compulsion` | 14 | M21 |
| `Glue` | The general gluing classification `sphere_inter_sphere` with the mirror `reflAxis`; the certified near-relation `zeta6_mul_seam_pow_nine_ne_one`. | `Coupled` | 17, 18 | M22 |
| `PartnerLattice` | Depth-one completeness: `Glue.eq_gluePoint_of_dist_pair`, `Glue.finite_two_unit_neighbors`. | `Glue` | 45 | M50 |
| `Triangle` | The pivot triangle and its metapivot: self-gluing, ten shared points (`ncard_system_inter_system`), rigid outer chords, `rot_hexagon`, `seam_hexagon`. | `Glue` | 20 | M23 |
| `Ladder` | The matched ladder pair is exactly 4-chromatic (`chromaticNumber_ladderPair`), every chord family classified; `sqrt_indep` over {1, √3, √11, √33}. | `Triangle` | 22 | M24 |
| `MetaLadder` | The four-ladder object is exactly 4-chromatic (`chromaticNumber_fourLadder`), via √3·ζ₁₂ = 1 + ζ₆ and the mod-9 `adjacent_kill`. | `Ladder` | 23 | M25 |
| `Hexagram` | The hexagram (six pivots at 1/√3 about the metapivot, seven ladders) is exactly 4-chromatic (`chromaticNumber_hexagram`), with a rot6-equivariant colouring. | `MetaLadder` | 24 | M26 |
| `FieldWall` | The Moser twist is a seam-group word: `moserTwist_mul_seam_sq` (ρσ² = −1). | `TwoCircle` | 25 | M30 |
| `Quadrature` | The 2-adic kill engine: `sqrt5_indep` by a mod-5 descent, `sqrt15_split`, `sqrt_indep₈`, `quadrature_rho15`. | `Ladder` | 28 | M32 |
| `Copy` | The spindle rotation at any pair distance (`spindleRot`, `self_chord_iff`) and copy unions (`copyUnion`, `chromaticNumber_copyUnion_le`). | `Quadrature`, `FieldWall`, `DistanceGraph` | 46 | M52 |

### 3.5 Where a compulsion can live: pigeonholes, spindles, critical sets, absorption

Compulsion theorems that use the gluing classification of § 3.4, and the pieces a compulsion cannot see.

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Pigeonhole` | The bridge from class avoidance to colourability of the augmented edge list (`mono_pair_of_not_colorable_append`), `mono_pair_of_clique`, the `transmuter`, `not_colorable_iff_covers`. | `EdgeList`, `Critical`, `Instances/Triangle` | 31, 32 | M34 |
| `OneDefect` | The spindle theorem `not_colorable_of_forced_equal` (a forced-equal pair at any distance ≥ 1/2) and `add_one_le_chromaticNumber_unitDistance_of_one_defect`. | `Homogeneous`, `Glue`, `Pigeonhole`, `Gadget` | 44 | M49 |
| `CriticalSet` | `CriticalSet G k` and where a compulsion can live: `criticalSet_subset_inter_neighborSet_of_forces`, `criticalSet_subset_union_neighborSet_of_separated`, `encard_criticalSet_le_two_of_forces`. | `Critical`, `PartnerLattice` | 48 | M54 |
| `Absorb` | Absorption: `Extends G A k` (every colouring of the piece extends), `extends_of_repaint`, `extends_of_hubs`, `extends_symCopy`. | `CriticalSet`, `SpareColour` | 49 | M55 |

### 3.6 Arithmetic colourings, field planes, finite planes

Colourings built from arithmetic rather than found: additive colourings, residue maps at a prime (Theorems A and B), and the finite planes `finitePlane p` that number-field planes map into.

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Additive` | Fischer's additive colourings: `additiveColoring`, `not_forces_of_addMonoidHom`, `addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul`. | `Fan`, `Palette` | 50 | M56 |
| `AdditiveRigid` | `IsAdditive`, `AdditivelyRigid`, `forces_of_additivelyRigid`, `six_le_chromaticNumber_plane_of_additivelyRigid`. | `Additive`, `OneDefect` | 51 | M57 |
| `UnitQuadrance` | `unitQuadrance R` over any commutative ring and `finitePlane p`; `unitQuadrance.map` (a ring homomorphism is a graph homomorphism); `UDCert.drawing_adj` (a certificate reduced into a ring); `add_one_le_chromaticNumber_unitQuadrance`. | `Certificate`, `EdgeList` | 53 | M58 |
| `ResidueColouring` | Theorem A: `colorable_of_residue` (a graph drawn in an abelian group, edge differences in a subgroup and nonzero under a homomorphism out of it); `normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`, `normOneColoring`; the general residue law `map_mul_conj_eq_zero_iff`. | `Additive`, `Palette`, `UnitQuadrance` | 57, 59 | Thm A |
| `FieldWall4` | Theorem B: `chromaticNumber_seamPlane`, χ(ℚ(√3,√11)²) = 4, by residue maps onto 𝔽₄ in an order built from `Quad` and a parity descent; `not_forces_five_of_subset_seamPlane`. | `Ladder`, `ResidueColouring`, `SpareColour`, `FieldWall`, `Instances/SpindleBound` | 57 | Thm B |
| `SeamCert` | Theorem B delivered to certificates: the √5- and √7-free subring `Q4.seamFree` and `UDCert.colorable_four_of_seamFree`. | `FieldWall4`, `UnitQuadrance` | 31 | FS-27 |
| `ValuationLaw` | The 2-adic law of four-colour compulsions over ℚ(√3,√11): `residueColouring_eq_iff_psiA_zero`, `not_forces_of_residue_ne_zero`, `not_separated_of_residue_eq_zero`, and the rows of `[Parts2020a]` Table 1 (`not_separated_dist_eight_thirds` and its siblings). | `FieldWall4` | 59 | 2026-09-09 |
| `TwoColourResidue` | **Skeleton (FS-36).** Theorem A's two-colour case: a residue map into a reduced ring of characteristic two that conjugation does not move two-colours every unit-distance graph drawn over its valuation subring (`colorable_two_unitDistance_induce_of_valuationSubring`, `colorable_two_of_normOne_of_conj_eq`). | `ResidueColouring`, `FieldWall4` | — | FS-36 |
| `SquareClass` | **Skeleton (FS-36).** Positive rational square classes and localization at 2 (`sqClass`, `loc2`); the Galois connection between square-class groups and real fields (`gc_sqrtField_kummerClasses`); the 2-adic splitting of a square-class group holding [2] (`inf_comap_blockTwo_sup_inf_comap_blockTen`); every real multiquadratic field in the compositum of two fields that pass the four-colour test (`mqField_le_sup`), with de Grey's field worked (`mqField_deGrey_le`). | `FieldWall4` | — | FS-36 |
| `Lift` | Lower bounds pull back along an injective drawing (`add_one_le_chromaticNumber_plane_of_lift`); the first-order obstruction `stressPairing_eq_zero_of_lift`. | `UnitQuadrance` | 54 | M59 |
| `ResidueObstruction` | Compulsions map forward (`Forces.image`, `Separated.image`); one aperiodic table decides a Cayley graph's pair compulsions (`forces_iff_eq_of_aperiodic`); the distance law `Forces.quad_sub_eq_zero`, for certificates at an integer or rational squared distance (`not_forces_of_distSq_ratio`, `PairsAtRatio`). | `Lift`, `Arity`, `PairDist` | 55 | M60 |
| `LocalGlobal` | `addCayleyMap`, the periodic quotient `unitQuadrance_colorable_of_quotient`, `card_le_chromaticNumber_mul_indepNum`, and the tightness mechanism `Forces.isEmpty_ringHom_of_spindle_radicand`. | `ResidueObstruction` | 56 | M61 |
| `PlaneRotation` | Rotations of the quadrance plane (`rotHom`, `quarterTurnHom`) and plane freedom `finitePlane_forces_iff`; the tightness mechanism with colourability as its hypothesis (`Forces.isEmpty_ringHom_of_spindle_radicand_of_colorable`). | `LocalGlobal` | 56, 60 | FS-25 |

### 3.7 The cell family and brick colourings

Colourings constant on lattice cells or on bricks: the upper-bound machinery, and the family whose floor is seven.

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Coset` | Colourings constant on the nearest-point cells of the triangular lattice: `coset_chromatic_eq_seven`, `seven_le_card_of_cell_constant`, `eight_le_card_of_cell_constant`, `twelve_le_card_of_cell_constant`, `seven_le_card_shell4`, `no_coset_seven_on_gap`, `exists_unit_pair_corner`. Mathlib only. | — | 34–36, 39 | M37–M42 |
| `Brick` | Periodic brick colourings and their boundary-tight certificate: `Brick.check`, `check_pos`, `Brick.sound`. | `UnitDistance` | 32, 33 | M35, M36 |
| `BrickDistance` | A passing brick certificate colours `distanceGraph ℂ D` for the distances its guards avoid (`Brick.colorable_distanceGraph`, `Brick.chromaticNumber_distanceGraph_le`). | `Brick`, `DistanceGraph` | 61 | FS-24 |

### 3.8 Instances

Concrete objects: witnesses, certificates, carriers, and the models that show a theory module's hypotheses can be met. Everything a reader re-checks lives here or in § 3.9.

#### The Moser spindle (rung A)

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Instances/Triangle` | M01's model of its own hypotheses: the unit triangle (`three_le_chromaticNumber_plane`) and the adjacency and non-adjacency examples for `unitDistance`. | `EdgeList` | — | M01 |
| `Instances/Spindle` | The Moser spindle's certificate, 7 points of ℚ(√3) and 11 edges: `moserSpindle_valid`. | `Certificate` | — | M02 |
| `Instances/SpindleLrat` | Generated LRAT certificates for the spindle, one monolithic and nine cubes (emitted by `scripts/EmitLrat.lean`). | — | — | M03 |
| `Instances/SpindleBound` | χ(ℝ²) ≥ 4 three ways: `four_le_chromaticNumber_plane` (kernel `decide`) beside the two certificate routes that make the repository's only trust purchases (§ 5); `moserSpindle_not_colorable_three_spindled`. | `Instances/Spindle`, `Instances/SpindleLrat`, `Reduction`, `Sat/Lrat`, `Forcer` | — | M03, M13 |

#### De Grey's graph and Heule's two witnesses (rung B)

`Table`, `Edges` and `Diffs` are emitted data; `Valid` decides the geometry; the aggregate module states the claims.

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Instances/DeGrey/Table` | Emitted: the 1581 vertices as one literal. | `Certificate` | — | M04 |
| `Instances/DeGrey/Edges` | Emitted: the certificate and the 7877 edges in 45 chunks, ordered `halfA ++ halfB ++ cross`. | `Instances/DeGrey/Table` | — | M04 |
| `Instances/DeGrey/Diffs` | Emitted: the 133-difference witness. | `Instances/DeGrey/Edges`, `Packed` | — | M08 |
| `Instances/DeGrey/Valid` | `deGrey_valid`: every edge at exact unit distance. | `Instances/DeGrey/Diffs` | — | M04, M08 |
| `Instances/DeGrey` | The geometry claims: `deGrey_unit_distances`, `deGrey_bound_of_not_colorable`. | `Instances/DeGrey/Valid`, `Reduction` | — | M04 |
| `Instances/DeGrey/Split` | The two 791-point copies, sharing vertex 14 and joined by edge 11–802 (`deGrey_halfA_subset`, `deGrey_cross_mem`); upstream of all of `DeGrey/HalfA/` (§ 4). | `Instances/DeGrey/Edges`, `Sat/Encoding` | — | M06 |
| `Instances/DeGrey/Rotation` | `deGrey_rotation`: 791 exact coordinate identities carrying the first copy onto the second about (−2, 0). | `Instances/DeGrey`, `Instances/DeGrey/Split`, `Motion` | — | M09 |
| `Instances/DeGrey/Rotated` | `deGreyRot`, the graph with its second copy derived from the first; `deGreyRot_valid`. | `Instances/DeGrey/Rotation` | — | M09 |
| `Instances/DeGrey/Forcing` | The three gadgets on vertices 14, 11 and 802: one refutation, the same refutation transported by the rotation, and the joining edge (definitions only). | `Instances/DeGrey/HalfA/Cert`, `Instances/DeGrey/Rotated`, `Gadget` | — | M06, M09 |
| `Instances/DeGrey/Bound` | `deGreyRot_not_colorable_four` and `chromaticNumber_plane_ge_five`. | `Instances/DeGrey/Forcing` | — | M06 |
| `Instances/DeGrey/Controls` | Committed negative controls: `deGrey_forcing_alone_admits`, `halfA_table_refuses_halfB_cnf`, `not_valid_comp_of_not_injective`. | `Instances/DeGrey/HalfA/Table`, `Instances/DeGrey/Forcing`, `Sat/Diagnose` | — | M07, M09 |
| `Instances/DeGrey/Narrow630` | Emitted narrow-fan certificate at pivot 630: `deGrey_no_narrow_fan_630`. | `NarrowFan`, `Instances/DeGrey/Edges` | — | M16 |
| `Instances/DeGrey/Narrow633` | The same at pivot 633: `deGrey_no_narrow_fan_633`. | `NarrowFan`, `Instances/DeGrey/Edges` | — | M16 |
| `Instances/DeGrey/Narrow1420` | The same at pivot 1420: `deGrey_no_narrow_fan_1420`. | `NarrowFan`, `Instances/DeGrey/Edges` | — | M16 |
| `Instances/DeGrey/Narrow1423` | The same at pivot 1423: `deGrey_no_narrow_fan_1423`. | `NarrowFan`, `Instances/DeGrey/Edges` | — | M16 |
| `Instances/DeGreyBalanced` | A balanced proper 5-colouring, class sizes [317, 316, 316, 316, 316]: `deGrey_balanced`, `deGrey_colorable_five`. | `Instances/DeGrey` | 8 | M19 |
| `Instances/Heule510/Table` | Emitted: the 510 vertices. | `Certificate` | — | M07 |
| `Instances/Heule510/Edges` | Emitted: the certificate and 2504 edges in 14 chunks. | `Instances/Heule510/Table` | — | M07 |
| `Instances/Heule510/Diffs` | Emitted: the 66-difference witness. | `Instances/Heule510/Edges`, `Packed` | — | M08 |
| `Instances/Heule510/Valid` | `heule510_valid`. | `Instances/Heule510/Diffs` | — | M07, M08 |
| `Instances/Heule510` | The geometry claims: `heule510_unit_distances`, `heule510_bound_of_not_colorable`. | `Instances/Heule510/Valid`, `Reduction` | — | M07 |
| `Instances/Heule510/Bound` | `heule510_not_colorable_four`, `chromaticNumber_plane_ge_five_510`. | `Instances/Heule510/Cnf/Cert`, `Gadget`, `Instances/Heule510` | — | M07 |
| `Instances/Heule510/Critical` | Five-vertex-critical, so no five-colour fan: `heule510_vertex_critical`, `heule510_no_five_fan`. | `Instances/Heule510/Critical/Rows00…07` | — | M15 |
| `Instances/Heule553/Table` | Emitted: the 553 vertices. | `Certificate` | — | M07 |
| `Instances/Heule553/Edges` | Emitted: the certificate and 2722 edges in 16 chunks. | `Instances/Heule553/Table` | — | M07 |
| `Instances/Heule553/Diffs` | Emitted: the 82-difference witness. | `Instances/Heule553/Edges`, `Packed` | — | M08 |
| `Instances/Heule553/Valid` | `heule553_valid`. | `Instances/Heule553/Diffs` | — | M07, M08 |
| `Instances/Heule553` | The geometry claims: `heule553_unit_distances`, `heule553_bound_of_not_colorable`. | `Instances/Heule553/Valid`, `Reduction` | — | M07 |
| `Instances/Heule553/Bound` | `heule553_not_colorable_four`, `chromaticNumber_plane_ge_five_553`. | `Instances/Heule553/Cnf/Cert`, `Gadget`, `Instances/Heule553` | — | M07 |
| `Instances/Heule553/Critical` | Five-vertex-critical: `heule553_vertex_critical`, `heule553_no_five_fan`, and `chromaticNumber_heule553` (= 5). | `Instances/Heule553/Bound`, `Instances/Heule553/Critical/Rows00…08` | — | M15 |

#### Calibration objects

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Instances/Mycielski` | The 47-vertex Mycielski graph defined in Lean, with `mycielski47_colorable_six` guarding that the sixth colour is used. | `Gadget` | — | M12 |
| `Instances/Mycielski/Bound` | `mycielski47_not_colorable_five`, the first five-colour refutation. | `Instances/Mycielski`, `Instances/Mycielski/Cnf/Cert` | — | M12 |
| `Instances/CoreSpindle/Weights` | Emitted weights and search plan for the 63-vertex core-and-spindle graph. | `IndepSearch` | — | M10 |
| `Instances/CoreSpindle/Cert` | Emitted certificate, 63 vertices and 216 edges: `coreSpindle_valid`. | `Certificate` | — | M10 |
| `Instances/CoreSpindle/Search` | The weight bound decided: `coreSpindle_noHeavy`. | `Instances/CoreSpindle/Weights`, `Instances/CoreSpindle/Cert` | — | M10 |
| `Instances/CoreSpindle/Bound` | χ_f(ℝ²) ≥ 65/18 (`fractionalChromaticNumber_plane_ge`) and `four_le_chromaticNumber_plane_fractional`. | `Instances/CoreSpindle/Search`, `Reduction` | — | M10 |
| `Instances/CoreSpindle/Diagnose` | `findHeavy_isNone`: the failure report agrees with the check. | `Instances/CoreSpindle/Bound` | — | M10 |

#### Pigeonhole carriers and the six-target

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Instances/Core9` | The nine-point √3-pair carrier `core9_pigeonhole` with its inhabitant `core9_colorable_three`; `core9_plane` is vacuous (§ 6). | `PairDist`, `Pigeonhole` | 31 | M34 |
| `Instances/Core122/Base` | Emitted certificate, 122 vertices and 421 edges: `core122_valid`. | `Certificate` | 31 | M34 |
| `Instances/Core122/Aug` | The augmented edge list the certificate refutes: 421 unit edges and the 40 distance-2 pairs. | `Instances/Core122/Base` | 31 | M34 |
| `Instances/Core122` | The distance-2 carrier `core122_pigeonhole` with its inhabitant `core122_colorable_four` (by Theorem B); `core122_plane` is vacuous (§ 6). | `Instances/Core122/Cnf/Cert`, `Gadget`, `PairDist`, `Pigeonhole`, `SeamCert` | 31 | M34, FS-27 |
| `Instances/HexShell` | The closed hex shell is a K₇ of the {1, √3, 2}-distance graph (`hexShell_pigeonhole`, `seven_le_chromaticNumber_hexShell_distances`); the six-target `add_one_le_chromaticNumber_plane_of_forced_pairs` and `six_le_chromaticNumber_oneTwo_of_forced_sqrt3`. | `PairDist`, `Pigeonhole`, `DistanceGraph` | 32, 43, 61 | M35, M48, FS-24 |
| `Instances/Core23/Edges` | The 23 addresses of the G* gap core and the constraint graph derived from them by one norm filter. | — | 39 | M42 |
| `Instances/Core23` | `core23_not_colorable_six` and `core23_colorable_seven` (χ = 7 at ω = 4), carried to the plane as `seven_le_card_gap`. | `Instances/Core23/Edges`, `Instances/Core23/Cnf/Cert`, `Gadget`, `Coset` | 39 | M42 |

#### Upper bounds and the interval

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Instances/Seven` | `sevenBrick` and `chromaticNumber_plane_le_seven`. | `Brick` | 33 | M36 |
| `Instances/Nine` | `nineBrick`, `plane_colorable_nine`, `chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine`. | `Brick`, `BrickDistance` | 32, 61 | M35 |
| `Instances/Interval` | `chromaticNumber_plane_interval` (5 ≤ χ(ℝ²) ≤ 7) and `isEmpty_coloring_plane_four`. | `Instances/DeGrey/Bound`, `Instances/Seven`, `Reduction` | 31, 33 | M36 |

#### Models of theory-module hypotheses

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Instances/AritySpec` | Models for the arity floor: `p5_arityFloor` (a five-vertex graph whose floor is 3), `tri_arityFloor`, `k4_arityFloor_zero`. | `Arity`, `Homogeneous`, `Sat/Encoding` | 42 | M45 |
| `Instances/LimitSpec` | Models of the limit lemma, including the red `collapsed_drawing_satisfies_one_tolerance`. | `Limit`, `Instances/Triangle` | 41 | M44 |
| `Instances/OneDefectSpec` | The Moser bound through the abstract spindle theorem: `four_le_chromaticNumber_plane_of_rhombus`. | `OneDefect`, `PairDist` | 44 | M49 |

#### Finite planes

| Module | What it holds | Imports | Row | When |
|---|---|---|---|---|
| `Instances/FinitePlane11` | `chromaticNumber_finitePlane11` (= 5, no solver), `chromaticNumber_heule510` (= 5), `five_le_chromaticNumber_finitePlane131`. | `UnitQuadrance`, `Instances/Heule510/Bound` | 53 | M58 |
| `Instances/LiftObstruction131` | The 1581's merged image at 131 has no lift modulo 131²: `merged131_no_lift`, `merged131_no_drawing`. | `Lift` | 54 | M59 |
| `Instances/LiftObstruction11` | The 5-critical core of `finitePlane 11` has no lift modulo 11²: `core11_no_lift`. | `Lift` | 54 | M59 |
| `Instances/LiftObstruction19` | The 5-critical core of `finitePlane 19` has no lift modulo 19²: `core19_no_lift`. | `Lift` | 54 | M59 |
| `Instances/ResidueObstruction11` | `finitePlane11_forces_iff`, `finitePlane11_separated_iff`, `not_separated_sqrt3_11`, `not_separated_two_11`; `not_forces_five_thirds_11` (Polymath16's 5/3 question, modelled on Heule-510). | `ResidueObstruction`, `Instances/FinitePlane11`, `Instances/HexShell` | 55 | M60 |
| `Instances/LocalGlobal19` | `chromaticNumber_finitePlane19_le_five` (a 19-entry periodic table), `finitePlane3_forces_iff`, `Forces.isEmpty_ringHom_of_spindle_radicand_11`. | `LocalGlobal`, `Instances/ResidueObstruction11`, `Instances/OneDefectSpec` | 56 | M61 |
| `Instances/PlaneFreedom` | The four measured primes re-derived from `finitePlane_forces_iff`: `finitePlane7_colorable_four`, `finitePlane19_forces_eq`. | `PlaneRotation`, `Instances/LocalGlobal19` | 60 | FS-25 |

### 3.9 Generated certificate families

Emitted by `tools/` (untrusted) and never edited by hand. Every `Cnf/` and `HalfA/` family has one shape: each `TableNN` chunk imports `Sat/ClauseTable`; `Table` imports the chunks, the edge list the formula is computed from, and `Sat/MaskCheck`; each `SegNNN` imports `Table` and is one implication between watermarks; `Cert` imports the segments and chains them. The `Critical/` families are the rows of a packed criticality certificate.

| Family | Files | Count | Imports from outside the family | Consumed by |
|---|---|---|---|---|
| `Instances/DeGrey/HalfA/` | `Table00…15`, `Table`, `Seg000…1221`, `Cert` | 1,240 | `Instances/DeGrey/Split`, `Sat/ClauseTable`, `Sat/MaskCheck` | `Instances/DeGrey/Controls`, `Instances/DeGrey/Forcing` |
| `Instances/Heule510/Cnf/` | `Table00…03`, `Table`, `Seg000…081`, `Cert` | 88 | `Instances/Heule510/Edges`, `Sat/ClauseTable`, `Sat/Encoding`, `Sat/MaskCheck` | `Instances/Heule510/Bound` |
| `Instances/Heule553/Cnf/` | `Table00…03`, `Table`, `Seg000…081`, `Cert` | 88 | `Instances/Heule553/Edges`, `Sat/ClauseTable`, `Sat/Encoding`, `Sat/MaskCheck` | `Instances/Heule553/Bound` |
| `Instances/Heule510/Critical/` | `Rows00…07` | 8 | `Critical`, `Instances/Heule510/Edges` | `Instances/Heule510/Critical` |
| `Instances/Heule553/Critical/` | `Rows00…08` | 9 | `Critical`, `Instances/Heule553/Edges` | `Instances/Heule553/Critical` |
| `Instances/Mycielski/Cnf/` | `Table00`, `Table`, `Seg000…015`, `Cert` | 19 | `Instances/Mycielski`, `Sat/ClauseTable`, `Sat/Encoding`, `Sat/MaskCheck` | `Instances/Mycielski/Bound` |
| `Instances/Core122/Cnf/` | `Table00…15`, `Table`, `Seg000…015`, `Cert` | 34 | `Instances/Core122/Aug`, `Sat/ClauseTable`, `Sat/Encoding`, `Sat/MaskCheck` | `Instances/Core122` |
| `Instances/Core23/Cnf/` | `Table00`, `Table`, `Seg000…001`, `Cert` | 5 | `Instances/Core23/Edges`, `Sat/ClauseTable`, `Sat/Encoding`, `Sat/MaskCheck` | `Instances/Core23` |

### 3.10 Layout rules the graph encodes

- **Upstream of a certificate, an edit costs hours.** These 24 modules are ancestors of at least one generated family, so changing a declaration or a doc string in any of them rebuilds certificates (a `--` comment does not; `CLAUDE.md` § Building): `Certificate`, `Critical`, `EdgeList`, `Fan`, `Field/Quadratic`, `Forcer`, `Gadget`, `Instances/Core122/Aug`, `Instances/Core122/Base`, `Instances/Core23/Edges`, `Instances/DeGrey/Edges`, `Instances/DeGrey/Split`, `Instances/DeGrey/Table`, `Instances/Heule510/Edges`, `Instances/Heule510/Table`, `Instances/Heule553/Edges`, `Instances/Heule553/Table`, `Instances/Mycielski`, `Pattern`, `Sat/ClauseTable`, `Sat/Encoding`, `Sat/Mask`, `Sat/MaskCheck`, `UnitDistance`. Settle them before a long generated build.
- **Geometry never sits upstream of a certificate.** Each family's `Table` imports only the edge list its formula is computed from (`Heule510/Edges`, `Heule553/Edges`, `Core122/Aug`, `Core23/Edges`, `Instances/Mycielski`, and for de Grey `DeGrey/Split`, which imports only `DeGrey/Edges` and `Sat/Encoding`), never a `Diffs`, `Valid` or aggregate module, so re-certifying geometry re-checks no segment.
- **Diagnostics are downstream.** None of the `#eval`-only modules is an ancestor of a certificate family, so rewriting one re-checks nothing: `AssemblyDiagnose`, `PackedDiagnose`, `Sat/Diagnose` (imported only by `Instances/DeGrey/Controls`), `ForcerDiagnose`, `CriticalDiagnose`, `NarrowFanDiagnose`, `Instances/CoreSpindle/Diagnose`.
- **Theory modules that import an instance**, each for a concrete object its proof uses: `FieldWall4` imports `Instances/SpindleBound`, `Pigeonhole` imports `Instances/Triangle`. `FieldWall4` uses the spindle's edge list and the kernel-decided `moserSpindle_not_colorable_three`, not the certificate routes, and axioms are counted per declaration, so the import buys nothing (§ 5).
- **A dangling citation.** The doc strings of `DistanceGraph` and `Homogeneous` cite `Instances/OneTwo`, the intended home of a certified {1, 2} six-forcer; that certificate was priced and deferred (ledger row 44) and the module does not exist.

## 4. Roadmap

This file carried the roadmap for milestones M01–M20. **From M21 onward the roadmap is `CLAUDE.md`
§ Frontier** — the state of the art, the novel-results ledger and the ranked paths forward — **and
`plans/FRONTIER-STUBS.md`**, which is authoritative: every candidate milestone as a full stub, ranked, with
its bearing on χ(ℝ²) ≥ 6 stated. Subplans are `plans/M<nn>-*.md`, and the stub rule is `WORKFLOW.md`
§ Plan. Nothing after M20 is tracked here.

What M01–M20 delivered:

| # | What landed | Headline |
|---|---|---|
| M01 | The statement: `unitDistance` and the finite-drawing reduction | `add_one_le_chromaticNumber_unitDistance` |
| M02 | Exact geometry: the ℤ-leaf tower, `UDCert`, the Moser spindle certified | `moserSpindle_valid` |
| M03 | The SAT bridge; χ(ℝ²) ≥ 4 three ways (rung A) | `four_le_chromaticNumber_plane` |
| M04 | De Grey's graph, 1581 vertices and 7877 edges, as certified data | `deGrey_valid` |
| M05 | The kernel-run refutation checker | `maskCheck_sound` |
| M06 | χ(ℝ²) ≥ 5 through de Grey's two-copy decomposition, after the cube split was measured dead | `chromaticNumber_plane_ge_five` |
| M07 | The same bound from Heule's 510 and 553 at about 1/25 the cost; de Grey's graph does not shrink | `chromaticNumber_plane_ge_five_510` |
| M08 | Packed geometry, one norm per distinct difference | `UDCert.valid_of_diffWitness` |
| M09 | The gadget algebra; de Grey's second copy derived by a rotation, deleting a certificate | `not_colorable_of_gadget`, `deGrey_rotation` |
| M10 | χ_f(ℝ²) ≥ 65/18 from a 63-vertex graph and a pruned kernel search | `fractionalChromaticNumber_plane_ge` |
| M11 | The search instrument: colour-generic gadgets, one pattern per partition, similarities | `exists_mem_canonPatterns` |
| M12 | Candidate construction; the first five-colour refutation | `mycielski47_not_colorable_five` |
| M13 | De Grey's construction as four primitive moves; forced pairs | `not_colorable_of_spindled_forcer` |
| M14 | The fan, the property his seed configuration has | `not_colorable_of_spindled_fan` |
| M15 | A fan is a removable vertex; Heule's witnesses are vertex-critical | `heule510_no_five_fan` |
| M16 | No known five-colour fan is confined to one distance | `deGrey_no_narrow_fan_630` |
| M17 | Deletion never creates a fan; the growth-family hunt exhausted | `not_fan_of_subset` |
| M18 | The 120° class; fan ⟺ compulsory coverage; greedy colouring | `fan_iff_coverage` |
| M19 | The two-circle theorem; the coverage ratchet; de Grey's balanced 5-colouring | `colorable_three_induce` |
| M20 | The 120° compulsion, the one-pivot cap, the strip automaton | `chromaticNumber_concentric` |

M01–M06 are rung B, with rung A (χ(ℝ²) ≥ 4) landing at M03; M07–M17 built the search instrument
(rung C); M18 onward is the hunt.

**Stale prose left in place: `Instances/DeGrey/Split.lean`.** The module sits upstream of all 1,240 files
of `Instances/DeGrey/HalfA/`, about 15 CPU hours of kernel checking, and its prose predates M09 in two
places. Its module doc string (lines 14–17) and the doc string of `deGrey_cross_mem` describe the argument
as two forcing lemmas proved from certificates, the pre-M09 shape; since M09 it is one certificate,
transported by `deGrey_rotation` and composed as gadgets. Doc strings are environment data, so correcting
them rebuilds that whole family, and they are not corrected. A `--` comment (lines 53–58) names
`not_colorable_of_forcing`, which M09 deleted in favour of `not_colorable_of_gadget`. By the measured rule
in `CLAUDE.md` § Building, an in-place edit of a `--` line that keeps the line count rebuilds only
`Split.lean` itself; that has not been measured on this file.

## 5. Trust

The de Bruijn criterion, operationalized: everything here reduces to what the kernel checked plus what
was explicitly chosen to trust. `scripts/Axioms.lean` audits the public surface through
`scripts/axioms.sh` at every milestone; the current count is in `CLAUDE.md` § Trust ledger.

| Entry | Status |
|---|---|
| `propext`, `Classical.choice`, `Quot.sound` | accepted silently |
| `sorryAx` | the gate fails on it |
| `<decl>._native.native_decide.ax_N_M` | **a purchase, listed below per declaration** |

**Grep for the right name.** At toolchain v4.32.0, `native_decide` mints a per-declaration axiom, and
`Lean.ofReduceBool` does not appear in `#print axioms` at all:

```
'foo' depends on axioms: [propext, Classical.choice, Quot.sound, foo._native.native_decide.ax_1_1]
```

An audit that looks only for `Lean.ofReduceBool` passes a native purchase in silence; the audit greps for
`native_decide.ax`.

### The purchases

Five declarations, all in `Instances/SpindleBound.lean`, all buying one thing: evaluation of core's
`LRAT.check` on a CaDiCaL certificate for the Moser spindle. Re-verified on 2026-09-10 with
`rg "native_decide" Proofs`: exactly ten `by native_decide` terms, at lines 82 and 131–139 of that file;
every other match is prose (the explanation in `Sat/Lrat.lean`, a doc string in
`Instances/DeGrey/Bound.lean`).

| Declaration | Axioms bought | Why |
|---|---|---|
| `moserSpindle_cnf_unsat` | `ax_1_1` | route B, the monolithic certificate |
| `moserSpindle_not_colorable_three_lrat` | inherited | route B's conclusion |
| `moserSpindleCubes_unsat` | `ax_1_1` … `ax_1_9` | route C, one certificate per cube |
| `moserSpindle_not_colorable_three_cubes` | inherited | route C's conclusion |
| `four_le_chromaticNumber_plane_certified` | inherited | route C composed with the geometry |

They are kept as cross-checks of the encoder: `four_le_chromaticNumber_plane` proves the same bound by
`decide +kernel` over all `3^7` colourings and buys nothing. **No headline theorem buys anything.** Every
refutation of rung B and beyond goes through `maskCheck_sound`, whose hypotheses are closed `Bool`s the
kernel decides, and the audit's only purchases are these five.

**Two ledgers, compared by the gate.** Each purchasing declaration's doc string opens with
`**Trust purchase: native evaluation.**` — the source-side ledger, `grep -rn "Trust purchase" Proofs/` —
and each is audited under the `PURCHASED` banner in `scripts/Axioms.lean`, the environment-side ledger.
`scripts/axioms.sh` extracts both and fails on any disagreement, and fails if the audit output lacks
either banner, so an audit that could not elaborate cannot read as a pass.

### Why a purchase would sit on the worst possible claim

The bound rests on two computations, and they are not equally checkable by a human:

- **Every listed edge is exactly one unit long.** If this were wrong it would be detectable: compute three
  edges in any computer-algebra system. It is kernel-checked anyway.
- **No `k`-colouring of the graph exists.** If this were wrong it would not be detectable by inspection:
  it quantifies over `4^1581` colourings, a 952-digit number.

A certificate is what makes the second claim checkable at all, by turning "no colouring exists anywhere in
that space" into a finite chain of elementary deductions. Checking that chain with compiled code rather
than the kernel gives back much of what the certificate was for. That is why a native purchase is a
footnote for a known theorem and the entire objection for a new one, and why no certificate of rung B or
later carries one.

### What compiled evaluation trusts

Lean lets a definition's compiled behaviour differ from the definition itself (`@[implemented_by]`,
`@[extern]`), so native evaluation can return an answer the definition contradicts, anywhere in the
dependency chain; the kernel only unfolds definitions and cannot be misled that way. Beyond that hole:
the code generator, the C toolchain, the runtime and its GMP bindings, and the CPU — none written to be a
proof checker.

### Independent replay

`lean4checker` replays modules through a second kernel (`scripts/lean4checker.sh`). It is a publication
gate, not a milestone gate (`CLAUDE.md` § Trust ledger), and it cannot re-check a native purchase: a
purchase is recorded as an axiom, and every kernel accepts axioms. It has replayed de Grey's geometry
(his 7,877 distance identities recomputed by a second kernel) and the proof structure around his
certificate, but never the certificate itself (18.4 × 10⁶ steps, single-threaded), and the two Heule
witnesses' complete chains at M07 (214 modules, propagation steps included). Modules beneath all three
witnesses, `Gadget.lean` among them, have changed since, so **no replay covers the current tree.**

### Not trusted, and not on the critical path

`tools/` (generators and instruments), CaDiCaL, and every float computation used to propose candidates.
Every claim they make is re-derived in Lean from emitted data, so a generator bug can only produce data the
kernel refuses. The statement-level check that catches a true theorem over an empty domain is
`scripts/vacuity.sh` (`CLAUDE.md` § The gate).

## 6. Defences against proving the wrong theorem

A green checkmark certifies exactly the statement written. The specific ways this repository could produce
a meaningless one, and the countermeasure for each:

| Failure | Defence |
|---|---|
| `unitDistance` has a vacuous `Adj` | `example : (unitDistance ℂ).Adj 0 1` and a non-adjacency `example`, in `Instances/Triangle.lean` (M01) |
| `χ ≥ 5` stated as `χ > 5`, as `≤`, or over a truncating `ℕ` | the statement is in `ℕ∞`, read through `chromaticNumber_le_iff_colorable`, and read aloud against the informal claim |
| The bridge proved in the wrong direction (`Sat → Colorable`) | only `Colorable → Sat` is ever consumed, stated with `¬` outside |
| A theorem true over an empty domain, so it says nothing | `scripts/vacuity.sh` demands an inhabitant or a declared emptiness for every structure-valued hypothesis; each carrier ships its inhabitant (`core9_colorable_three`, `core122_colorable_four`, `core23_colorable_seven`); `core9_plane` and `core122_plane` are vacuous, say so, and support nothing, because `isEmpty_coloring_plane_four` makes the emptiness a theorem |
| A hypothesis made free by an empty domain | `finitePlane_forces_iff` takes colourability of the plane as a hypothesis, and `finitePlane3_not_colorable_two` ships beside it as the case where the statement without it is false |
| A generalized theorem silently changing what an old name means | the pre-generalization type of each cited name is pinned by a compiled type ascription, and a mutated pin was watched to fail (FS-24) |
| The CNF encoding wrong, making any graph "unsatisfiable" | the spindle refuted three ways that agree, and `exists_sat_coloringCNF_four` shows the same encoder satisfiable at four colours from a real colouring (M03); `coloringCNF 4 553 E` is clause-for-clause identical to Heule's independently authored `553-4.cnf` (M07) |
| The encoder checked only against itself | the spec `#guard`s in `Instances/SpindleBound.lean` evaluate the formula on hand-written assignments (M03) |
| A certificate from a different CNF than the one reasoned about | the CNF is defined once in Lean and the DIMACS handed to CaDiCaL is printed from that definition (`scripts/Dimacs.lean`); **the Python side never authors a CNF**, only candidate geometry |
| A checker that accepts everything | committed negative controls: a certificate filed against the wrong cube fails, no certificate refutes the satisfiable four-colour formula (M03), and the mask checker refuses a satisfiable formula the clause table agrees with and a clause citing itself, each fault pinned by `#guard_msgs` (M05) |
| A hypothesis of the checker's soundness is decorative | dropping the non-tautology hypothesis makes `propagate_prop_sound` false, and the countermodel is committed as an `example : ¬ …` (M05) |
| The checker's answer and its diagnosis drift apart | the `Bool` is defined as "the diagnostic reports no fault", one computation read two ways (`maskCheck`, `Gadget.survivors`); where a check and its report are separate functions, their agreement is a theorem (`findHeavy_isNone`, `firstFault_none_iff_check`). Two functions related only by a separately proved lemma is the weaker arrangement, and is not used for new checks |
| The packed certificate format silently trusted | the decoder is a parameter of the checker and soundness is proved for every function of its type (M05) |
| A cube certificate attached to the wrong cube | the cube list is a literal tied to `allCubes` by `rfl`, so a misfile is a type error naming the cube; `#eval badCubes …` reports every wrong and missing index (M03) |
| A segment attached at the wrong watermark, so the chain skips work | segment k concludes at the watermark segment k+1 assumes, so the composition typechecks only if they chain (M06) |
| A certificate attached to the wrong witness | `halfA_table_refuses_halfB_cnf : halfATable.agreesWithCNF halfBCnf = false`, kernel-decided on every build (M07) |
| The forcing argument proved about the wrong graph | the copies are contiguous segments of `deGrey.edges` by construction, the inclusions are `List.mem_append_left`, and the split's shape (3938 + 3938 + 1, one shared vertex) is `#guard`ed (M06) |
| Colour symmetry used to prove more than it can | relabelling requires an injection, which is the hypothesis the theorem consumes (M06) |
| One systematic error sinks the bound | χ(ℝ²) ≥ 5 is proved from three graphs sharing no vertex, edge or certificate; what they share is the encoding and the checker, and a fault there would have to certify three unrelated graphs (M07) |
| The difference table's keys wrong, certifying a different graph | the keys are walked in lockstep against the certificate's own edge list; a length disagreement is a named `false`, never a truncating `zip` (M08) |
| The packing collapses two points | `Packable.pack_inj` is proved, and the two counterexamples showing its digit bound is load-bearing are committed as `#guard`s (M08) |
| The generator and Lean disagree about the packing convention | `tools/emit_diffs.py` and `Packed.lean` both assert the packing of one fixed point, whose thirty-two digits are 1…32 in lane order; that one number fixes lane width, lane order and coordinate order (M08) |
| The rotation asserted rather than checked | `deGrey_rotation` decides 791 exact coordinate identities, and `31² + (3√7)² = 32²` is checked as a field of `Motion` (M09) |
| A transported gadget attached to the wrong ports | `transport` takes the port images as pointwise equations, so a wrong image is a type error (M09) |
| The composition refutes whatever it is handed | dropping the joining edge leaves exactly one surviving pattern, and `deGrey_forcing_alone_admits` is that as a theorem (M09, M11) |
| A transported gadget collapses an edge | the transport hypothesis is `Adj`, which carries distinctness; for de Grey it is `deGreyPhiNat_inj` (M09) |
| A scale factor cancelled unsoundly | it is cancelled as a natural number through `NatCancel`; nothing assumes `Q4` has no zero divisors (M09) |
| The pruned search skips a subtree it has not bounded | weakening the prune's hypothesis breaks `noHeavy_sound` at exactly that step (M10) |
| The weight bound certified against a mask that invents edges | `nbrMask_and_two_pow_eq_zero`: a set bit is a listed pair (M10) |
| The fractional chromatic number silently the ordinary one | `C5_fractional` pins χ_f(C₅) = 5/2, not an integer, in both directions (M10) |
| The terminal check's one colouring per partition lets a colouring slip through | `not_colorable_of_gadget` relabels the colouring before handing it on, and deleting the relabelling breaks the proof at that step (M11) |
| The partition enumeration skips one | pinned in both directions at four ports and five colours, all 625 patterns decided (M11) |
| A "motion" that is not one | each of the three similarity laws has its own committed countermodel (M11) |
| Two `Q4`-distinct distances that are the same real, merging two classes | real distinctness is certified by integer interval arithmetic (`sepChain`, `index_eq_of_eval_eq`): sorted values whose adjacent intervals are strictly disjoint, with no injectivity claim about `Q4.eval` (M16) |
| Same-class vertices citing different separating colourings | the colouring hint is per class, not per vertex, so the mistake is unrepresentable (M16) |
| The five-colour question asked at four by accident | `mycielski47_not_colorable_five` is paired with `mycielski47_colorable_six`, an existence claim guarding that the sixth colour is used (M12) |
| A generated graph that is not the construction it describes | the Mycielski witness is defined in Lean, not emitted (M12); the gap core's edges are derived from its 23 addresses by one norm filter (M42) |
| A placed copy certified for a copy never placed | coordinates are derived from the base and the motion, so geometry and colouring transport are the same map, `embed` (M12) |
| The seams of an assembly fail silently | `AssemblyDiagnose` names the failing seam by copy and base vertex, pinned by `#guard_msgs` in both directions (M12) |
| "Spindle a forcer and the colour count rises" is a story | `not_colorable_of_spindled_forcer` is that argument over any graph and colour count, and the Moser spindle is re-derived through it from a four-vertex rhombus (M13) |
| A placement that is not a placement | `spindleEdges` is defined as the two placed copies plus the joining edge, so each placement is a homomorphism structurally (M13) |
| A degenerate vertex list (all points equal, or empty) | vertex and edge counts asserted by `#guard`, and several distances evaluated |
| A geometry check that accepts everything, or a negative control that perturbs nothing | committed `#guard`s collapse vertex 1 onto vertex 0 and demand the check fail naming exactly the edges at vertex 1, in `Instances/Heule510.lean`, `Instances/Heule553.lean` and `Instances/CoreSpindle/Bound.lean`; vertex 1 rather than 0, because in those witnesses vertex 0 is the origin and moving it moves nothing (M07) |

## 7. Honest failure modes

Standing limits, stated as they are. The live register of what could stop the hunt is `plans/RISKS.md`,
and the ranked obstacles are in `CLAUDE.md` § Frontier.

- **χ(ℝ²) ≥ 6 may be false, or its witness astronomically large.** χ could be 5, 6 or 7; strong SAT
  researchers and Polymath16 stalled at exactly this point. Rung D is a gamble; the rungs below it are not,
  which is why the ratchet is built this way.
- **Refutation cost is not monotone in graph size, and five colours cost far more than four.** Heule's
  510-vertex witness costs 28% more than his 553-vertex one, and de Grey's 1581 has no monolithic
  refutation at all. At five colours the cost was 227× the four-colour cost on one fixed 47-vertex graph
  and 10–30× at matched size. What a 6-chromatic candidate would cost is unmeasured, because none exists.
- **Certificate size decides what reaches the kernel.** The fine-tail cell core at `p = 1/7` was priced at
  about 800,000 LRAT lines per cube and declined; Exoo and Ismailescu's {1, 2} six-forcer was priced at
  about 50 million hints and deferred, which is why `Instances/OneTwo` does not exist (§ 3.10).
- **Field-level statements rest on hand arguments.** Two steps are not in the kernel: that a number field
  with a conjugation-fixed prime supplies a valuation subring with residue field of size N(𝔭) (ledger
  row 57), and the integrality of unit vectors at the primes above `p` behind the finite-plane bound
  (row 52). The kernel holds both theorems only through an explicit subring and ring homomorphism
  (`colorable_unitDistance_induce_of_valuationSubring`, `UDCert.drawing_adj`).
- **No independent replay covers the current tree** (§ 5).
- **A tools-side negative measures its enumeration** (`CLAUDE.md` § Grokkings, G21). Rows of the ledger
  marked [tools] are measurements with controls, not theorems, and nothing in `tools/` is trusted.
- **Our marginal edge at rung D is unproven.** Persistence, verified modular composition and a search that
  does not tire are real advantages; nobody has shown they are enough here.
