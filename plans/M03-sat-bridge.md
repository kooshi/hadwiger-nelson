# M03 — The SAT bridge, and χ(ℝ²) ≥ 4

> The CNF encoding of graph colouring, the one direction of the correspondence the project
> consumes, LRAT certificate ingestion, and the cube split. Everything M05 does at 1581 vertices,
> done here at 7 — where an independent oracle still exists to check it against.

> **STATUS: subplanned (2026-07-27), domain + obligation passes applied.** Skeleton elaborates,
> 27 `sorry` at tracked leaves, 12 spec `#guard`s passing. Every leaf has a proof derived and
> checked in scratch — see the obligation pass below.

## De-risk already done (2026-07-27, before this plan was written)

The whole route was run end to end at spindle scale, and one architectural assumption was
**falsified**. Both results are load-bearing, so they are stated first.

### The pipeline works

```
colouringCNF 3 7 moserSpindleEdges          21 variables, 40 clauses
  → CNF.dimacs (printed from the Lean def)  "p cnf 21 40"
  → cadical --lrat --no-binary              exit 20 (UNSAT), instant
  → 26 LRAT actions, 658 bytes
  → Lean literal → LRAT.check → check_sound → Unsat        2.8 s for the whole module
```

with the negative control passing too: the same certificate returns `false` against
`colouringCNF 4 7 moserSpindleEdges`, so `check` is discriminating between formulas rather than
rubber-stamping.

The brute-force oracle also runs: `∀ f : Fin 7 → Fin 3, ∃ e ∈ moserSpindleEdges, …` and its k = 4
negation both close by `decide`, ~30 s of kernel work for the pair.

### The falsified assumption: **`LRAT.check` does not kernel-reduce, at any size**

`ARCHITECTURE.md` § 2.3 said "many small certificates are far more likely to be kernel-reducible
than one large one, which is the difference between paying `Lean.ofReduceBool` and not." That hope
is dead. Measured on `⟨#[[(0, true)], [(0, false)]]⟩` — the smallest unsatisfiable CNF there is,
with a one-action certificate:

| route | result |
|---|---|
| `by decide` | stuck immediately: the elaborator refuses `@[irreducible]` well-founded definitions, and `Array.anyM.loop` is one |
| `by decide +kernel` | reduces `Array.any`, the `@[no_expose]` `Decidable (∃ v, VarMem v f)` instance, and `compactLratChecker` on trivial input — then sticks inside `Formula.performRupAdd` after ~40 s |
| `by native_decide` | succeeds, instantly |

Core's own `bv_decide` does the same thing (`Lean/Meta/Tactic/BVDecide/Prover/Bitblast.lean` calls
`nativeEqTrue`), so this is the state of the art, not a defect in our setup. **The consequence for
the project: the SAT half buys a native-evaluation axiom, and the cube split's justification is now
solver tractability and memory alone — not trust.** A kernel-checked route would need an LRAT
checker written to reduce, with its own soundness proof; that is a milestone-sized undertaking and
is recorded as open work rather than attempted here.

### A live gate hole, found by the same probe

At v4.32.0 `native_decide` mints a **per-declaration** axiom and does **not** cite
`Lean.ofReduceBool`:

```
'spindle3_unsat' depends on axioms:
  [propext, Classical.choice, Quot.sound, spindle3_unsat._native.native_decide.ax_1_1]
```

`CLAUDE.md`, `ARCHITECTURE.md` § 5 and `scripts/Axioms.lean` all name `Lean.ofReduceBool` as the
thing to watch for. As written, our gate would have passed a native purchase in silence. Fixed as
part of this milestone: the audit greps for `native_decide.ax` as well.

## Why now

M02 left `UDCert.add_one_le_chromaticNumber_of_valid` wanting `¬ (edgeGraph n c.edges).Colorable k`.
Producing that at 1581 vertices is the open problem M03 solves — not by proving it, but by building
the machine that will consume a certificate for it. And M03 is the last milestone at which the
machine can be checked against something independent: at 7 vertices `decide` enumerates all `3 ^ 7`
colourings and answers the same question with no CNF, no solver, and no certificate in sight. At
1581 vertices nothing does. **The cross-check is the milestone.**

## The encoding, and why this shape

Variables are `x_{v,c}` at index `colourVar k v c = k * v + c`, over `ℕ` because that is what
`LRAT.check` consumes. Two clause families:

* one **at-least-one-colour** clause per vertex, `⋁_c x_{v,c}`;
* for each non-loop listed edge and each colour, `¬x_{u,c} ∨ ¬x_{w,c}`.

**At-most-one clauses are deliberately omitted.** The edge clauses already force adjacent vertices'
colour *sets* to be disjoint, so any satisfying assignment yields a proper colouring by picking a
colour per vertex. Fewer clauses, and the direction we prove is untouched.

**Only `Colorable k G → satisfiable` is proved**, and the domain pass sharpened *why* that is safe
rather than merely sufficient. Satisfiability is antitone in the clause set: an encoder emitting too
few clauses gives a satisfiable formula, which has no refutation, so no certificate exists and no
theorem is produced; an encoder emitting too many breaks `exists_sat_colouringCNF`, which fails to
elaborate. **The encoder cannot be wrong in a way that produces a false bound** — only in a way that
makes the certificate unobtainable. The residual risk is that the DIMACS handed to the solver is not
this formula, which is exactly what `ARCHITECTURE.md` § 6's hard rule guards.

**Loops are filtered, and must be.** `edgeGraph` strips loops structurally. A listed `(i, i)` left
in the clause set contributes `¬x_{i,c} ∨ ¬x_{i,c}`, which makes the formula unsatisfiable while the
graph stays colourable — i.e. it makes `exists_sat_colouringCNF` *false*. `colouringCNF` filters under the
same convention, and the correspondence is then unconditional. This is the constraint M01 recorded
in `EdgeList.lean` for M03 to honour.

## The cube split, and its shape

A monolithic CaDiCaL run on de Grey's instance did not terminate in 10 minutes and had emitted
2.0 GB of partial certificate. The split is mandatory: fix the colours of a small vertex set `W`,
solve one much easier instance per assignment.

The design mirrors `UDCert.valid_of_chunks` exactly, and deliberately — the project should have one
shape for "the big obligation is the conjunction of generated small ones":

| geometry (M02) | combinatorics (M03) |
|---|---|
| `chunks : List (List Edge)` | `allCubes k W : List (Cube n k)` — generated, not listed |
| `hjoin : chunks.flatten = c.edges` | `restrict_mem_allCubes` — proved once by induction on `W` |
| `∀ ch ∈ chunks, ValidOn ch` | `∀ cb ∈ allCubes k W, Unsat (cnf ++ cubeCNF k cb)` |
| call site: `fin_cases hch; exacts [...]` | `fin_cases hcb; exacts [...]`, or a plain tuple |

The alternative — an explicit cube list plus a covering hypothesis — was rejected: any covering
condition phrased over colourings quantifies over `k ^ n`, which is not checkable at n = 1581.
Generating the enumeration makes the covering fact a *theorem* (structural induction on `W`) rather
than a decision. `W = []` yields exactly one cube, the empty one, so the monolithic case is the
split's own base case rather than a separate mechanism.

## Scope

**In.**

1. `Sat/Encoding.lean` — `colourVar`, `atLeastOneClause`, `edgeClauses`, `colouringCNF`;
   `exists_sat_colouringCNF` and its contrapositive `not_colorable_of_unsat`, over a **private**
   `colourFn`/`ofColoring` and the arithmetic lemma underneath them.
2. Cubes, same module — `Cube`, `cubeCNF`, `restrict`, `allCubes`, `restrict_mem_allCubes`,
   `exists_sat_colouringCNF_cube`, `not_colorable_of_cubes`.
3. The independent route — `colorable_iff_exists` and `not_colorable_edgeGraph_iff`, which put
   colourability in a shape `decide` can run. Mathlib has no `Decidable (G.Colorable n)` instance
   (checked), so this is ours to state.
4. `Sat/Lrat.lean` — `unsat_of_check`, and the module docstring that names the trust boundary and
   records the measurement above.
5. `Reduction.lean` — the composite: valid certificate + unsatisfiable encoding ⟹ a bound on
   χ(ℝ²), in the plane rather than in `ℂ`. Two flavours, monolithic and cube-split; the second is
   the only thing M05's instance module calls.
6. `Instances/SpindleBound.lean` — the terminal test. `¬ Colorable 3` three ways (brute force,
   monolithic LRAT, cube split over `W = [0,1]`, 9 cubes), `Colorable 4` for non-vacuity, and
   `4 ≤ χ(ℝ²)` proved through the brute-force route so the headline stays axiom-clean.
7. `Instances/SpindleLrat.lean` — **generated**: the certificate arrays only, no theorems.
8. `scripts/Dimacs.lean` — writes DIMACS **from the Lean definition** via `CNF.dimacs`
   (`ARCHITECTURE.md` § 6's hard rule: the Python side never authors a CNF), one file per cube.
9. `scripts/EmitLrat.lean` — reads CaDiCaL's LRAT with core's own parser (`LRAT.loadLRATProof`) and
   prints the Lean literal. **No Python anywhere on the SAT path**, which removes a whole class of
   format-mismatch bug: the same library parses the certificate that later checks it.
10. `tools/solve.sh` — DIMACS in, LRAT out, one CaDiCaL invocation.
11. Gate repair — `scripts/Axioms.lean`, `CLAUDE.md`, `ARCHITECTURE.md` corrected for the
    `native_decide` axiom naming, and extended with M03's surface.

**Out** (carried forward, stubs in `plans/`).

* **Colour symmetry** — fixing a unit triangle to colours `0,1,2` cuts the cube space by `4! = 24`.
  A real theorem (permute `Fin k` along a clique) and a pure optimization. → M05.
* **Certificate trimming** (`LRAT.Trim`), binary LRAT, and anything about certificates too large to
  embed as a Lean literal. M03's are 658 bytes. → M05.
* **A kernel-reducible LRAT checker.** Now known to be the only route to a kernel-only χ ≥ 5. Not
  attempted; recorded as open work. → its own milestone if ever.
* **Cube-set search** — which `W` splits best is an empirical question about de Grey's graph, not
  about the bridge. → M05.

## The specification, validated at the skeleton

Run before any proof effort was spent, against the real definitions:

| check | result |
|---|---|
| `colourVar 3 2 1` | `7` = 2·3+1 |
| `(colouringCNF 3 7 moserSpindleEdges).clauses.size` | `40` = 7 + 3·11 |
| `(colouringCNF 3 2 [(0,0)]).clauses.size` | `2` — the self-loop contributes no clause |
| `(colouringCNF 3 2 [(0,1)]).clauses.size` | `5` = 2 + 3 |
| `(allCubes 3 [0,1]).length` | `9` = 3², and the nine cubes print correctly |
| `CNF.eval (ofColoring 4 (colourFn ![0,1,2,0,1,2,3])) (colouringCNF 4 …)` | `true` |
| `CNF.eval (ofColoring 3 (colourFn ![0,1,2,0,1,2,3])) (colouringCNF 3 …)` | `false` |
| `CNF.dimacs (colouringCNF 3 3 triangleEdges)` | `p cnf 9 12`, and the twelve clauses read correctly by eye |

The last two rows are the two-sided check that matters: the same colouring satisfies the formula at
four colours and fails it at three, so `colouringCNF` is tracking the colouring rather than
answering a constant.

**The concrete model of the hypotheses** is `spindleFour = ![0,1,2,0,1,2,3]`, a real 4-colouring of
the spindle verified above. It instantiates `exists_sat_colouringCNF` with something concrete,
which is what stops `not_colorable_of_unsat` from being a `∀` over an empty domain.

## Skeleton

Elaborating now, `sorry` at every leaf:

* `Proofs/HadwigerNelson/Sat/Encoding.lean` — 17 leaves, 10 of them private helpers
* `Proofs/HadwigerNelson/Sat/Lrat.lean` — 0 leaves (`unsat_of_check` is a one-liner over
  `check_sound`; the module's content is the boundary it documents)
* `Proofs/HadwigerNelson/Reduction.lean` — 2 leaves (the two composites are derived terms)
* `Proofs/HadwigerNelson/Instances/SpindleBound.lean` — 8 leaves

## Obligation-modeling pass (2026-07-27)

Every leaf below was **derived and closed in scratch before being written down**, so the skeleton's
finer agenda is a transcription of working proofs rather than a wish list. The leaf count went 20 →
27: one `sorry` replaced by finitely many strictly smaller ones, which is the only legal move.

### `sat_colouringCNF` — the milestone's theorem, and the space it lives in

There is no induction. `colouringCNF` is an append of two `map`s, so the space is the clause list and
`List.mem_append` carves it. The chain that gets there:

```
CNF.Sat → CNF.eval → List.all_toArray → List.all_eq_true → ∀ cl ∈ (vertices ++ edges)
                                                              └─ List.mem_append
```

and each side is one stated lemma. Five private helpers carry the arithmetic and the two clause
families, so the assembly is 18 lines with no step needing a walkthrough:

| lemma | content |
|---|---|
| `ofColoring_colourVar` | the round trip. `simp [ofColoring, colourVar, Nat.mul_add_div hk, Nat.mod_eq_of_lt hc, Nat.div_eq_of_lt hc]` — pinned; `Nat.mul_add_mod` turns out unnecessary, simp finds it |
| `colourFn_lt` | the extension lands in range everywhere — **this is where `hk` pays for the junk value** |
| `colourFn_val` | it agrees with the colouring in range |
| `ofColoring_self` | a vertex's own colour variable is set |
| `ofColoring_ne` | any other colour's variable is unset |
| `eval_atLeastOneClause` | the vertex clause, witnessed at `colourFn C v` |
| `eval_edgeClause` | the edge clause, by case split on `c = colourFn C u`; each branch cites `ofColoring_ne` |

The edge side of the assembly crosses three seams in order, and each has exactly one citation:
`List.mem_filter` (Bool `!=` to Prop `≠`, via `simpa`), `edgeGraph_adj_of_mem` (list membership to
`Adj` — the packaging M01 wrote for this call site), `Coloring.valid` (`Adj` to `C i ≠ C j`), then
`Fin.val_inj` to land on `colourFn`.

### One witness, named once

`exists_sat_colouringCNF` and `exists_sat_colouringCNF_cube` must agree on the assignment — the cube
split turns on a single `a` satisfying both halves of `CNF.eval_append`. So the witness is a private
lemma (`sat_colouringCNF`) and both existentials cite it.

The cube half, `sat_cubeCNF_restrict`, takes an **arbitrary `C : Fin n → Fin k`**, not a colouring:
satisfying one's own cube has nothing to do with the graph. Polya's direction — the more general
statement is the easier proof, and here it is also the honest one.

### `restrict_mem_allCubes` — the only induction

Structural on `W`, and it is the recursor `allCubes` already recurses along, which is the sign the
domain pass got the type right. Four lines: `nil` gives `[] ∈ [[]]` by `simp`; `cons` is
`List.mem_flatMap` → `List.mem_map` → `List.mem_finRange`, picking `cb = restrict W C` from the IH
and `c = C v`.

### The rest

* `not_colorable_of_unsat` / `not_colorable_of_cubes` — three and four lines. `rintro ⟨C⟩`, take the
  witness, contradict the `Unsat` at that assignment. The children are already-closed leaves, so the
  measure descends trivially. `not_colorable_of_cubes` is the one that also cites
  `restrict_mem_allCubes`; that is the only thing the split needs beyond the monolithic case.
* `not_colorable_edgeGraph_iff` — split in two, because it is two arguments. `exists_adj_eq_iff`
  (private) crosses the `Adj`-to-membership seam and absorbs the symmetric `(j, i) ∈ E` case as two
  `.symm`s; the theorem itself is then `colorable_iff_exists`, `push Not`, `exists_adj_eq_iff`.
  **`push_neg` is deprecated at v4.32.0** in favour of `push Not` — pinned here because the
  deprecation warning is the sort of thing that silently rots a proof.
* `Reduction.lean` restructured. `add_one_le_chromaticNumber_plane_of_valid` is now the primitive —
  geometry plus non-colourability, however obtained — and the `_of_unsat` and `_of_cubes` flavours
  are one-line compositions with the two producers. Three consumers (including the spindle's
  brute-force route), one place where the isometry is crossed. The module went from three `sorry` to
  two.

### Two findings with consequences outside this file

* **No new `DecidableRel` instance is needed.** `Colorable 4` for the spindle wants
  `∀ i j, Adj i j → f i ≠ f j` decided, and there is no `DecidableRel (edgeGraph n E).Adj` in scope.
  Rather than mint a global instance for one use, `simp only [edgeGraph_adj]; decide` works — M01's
  `@[simp]` lemma delivering exactly what its docstring promised, driving the goal out of graph
  vocabulary into decidable vocabulary. No new speech act.
* **The cube literals must come from Lean, not from Python.** After `fin_cases hcb` the goal carries
  the cube as the literal `allCubes` reduces to, and the generated per-cube theorem must state that
  same literal. So `scripts/Dimacs.lean` emits one DIMACS per cube by `#eval`ing `allCubes k W` and
  walking it **in that order** — the enumeration is never reimplemented on the Python side. Same
  discipline as § 6's rule for the CNF itself, one level down.

## Domain-modeling pass (2026-07-27)

Six questions went in; four confirmed the model, two changed it, and one measurement decided a
definition.

**Confirmed.**

* **`CNF ℕ` with `colourVar`, not `CNF (Fin n × Fin k)` + `CNF.relabel`.** A variable *is* a
  (vertex, colour) pair — intrinsic structure — but the placement is extrinsic: the certificate, the
  DIMACS and `LRAT.check` all want a flat `ℕ`, and exactly one lemma needs the pairing. The relabel
  route does not remove the arithmetic either; `unsat_relabel_iff` moves it into an injectivity
  obligation, and adds a `relabel` layer to every downstream statement M05 reads. Conflating
  intrinsic structure with intrinsic placement is the characteristic modelling error here, and this
  was it.
* **`Cube n k` stays an `abbrev`** — a type synonym naming a domain role, owed no lemma API because
  the elaborator sees straight through it. The type is lax (repeated vertices, conflicting colours,
  vertices outside `W` are all representable); that is safe because `allCubes` is the only producer,
  which makes it the smart constructor and the laxity unreachable. Said out loud in the docstring
  rather than left as an assumption.
* **`not_colorable_edgeGraph_iff` is a theorem, not a `Decidable` instance.** `Colorable` is
  Mathlib's; an instance would be a permanent utterance into every future `decide`, and one that
  invites `decide` to attempt `4 ^ 1581` in a context nobody asked. Making the caller name the
  rewrite makes the brute-force route a choice. The `e.1 ≠ e.2` conjunct is load-bearing (without it
  a listed self-loop proves non-colourability on no evidence) and is the same convention `edgeGraph`
  and `colouringCNF` apply — one convention, three sites.
* **The certificate does not carry its own ambient space.** `Q4` coordinates are Cartesian; the
  ambient space is an interpretation chosen once by `toPlane`, and indexing `UDCert` on it would tax
  every signature for something no consumer inspects.

**Changed.**

* **`colourVar k v c = k * v + c`**, not `v * k + c`. Measured: with `k * v + c` the round-trip lemma
  is one `simp` citing `Nat.mul_add_div` / `Nat.mul_add_mod`; with `v * k + c` the same call leaves
  `(v * k + c) / k = v` unsolved. Identical numbering, identical DIMACS — the definition was shaped
  around the statement, which is the whole move.
* **The satisfying assignment is a witness nobody consumes, so it went behind `∃` and its
  construction went `private`.** `colourFn` extends a colouring by a junk value off-range; that junk
  was sitting in the statement of the milestone's main theorem, and every consumer discards the
  assignment to contradict an `Unsat`. `sat_colouringCNF` became `exists_sat_colouringCNF`, and
  `colourFn`/`ofColoring`/`colourFn_val`/the round-trip lemma left the public surface. The junk still
  exists; it can no longer be tripped over.
  * A second win fell out: the spec check could no longer use `ofColoring`, so its assignments are
    now **written by hand**. Checking our encoder with our own assignment-builder only tested
    self-consistency; the two sides are now independent.
* **`chromaticNumber_plane_eq_complex` is an equality**, where the skeleton had a one-directional
  `le_chromaticNumber_plane_of_complex`. `chromaticNumber_unitDistance_congr` gives the equality, it
  is one line either way, and the one-directional version was weaker than the truth — rung C's
  shrinking and fractional work wants the other direction.

**Measured at the call site** (the thing M05 will do 256 times), both verified against
separately-stated literal-cube theorems:

| discharge route | 9 cubes | 64 | 256 |
|---|---|---|---|
| `intro cb hcb; fin_cases hcb; exacts [...]` | instant | ~2 s | ~9 s |
| `List.forall_iff_forall_mem.mp ⟨c₀, …⟩` | instant | — | no tactic search |

`fin_cases` scales super-linearly and is fine at M05's expected 64–256; the tuple form is the one to
prefer past ~100 cubes. Both produce goals matching literal-cube theorems exactly, so the generator
can emit either.

**Unsampled members, all checked and all consistent** (`#guard`s now permanent in the file): `n = 0`
gives no clauses and a colourable graph; `k = 0` gives one empty clause per vertex, hence
unsatisfiable, matching `Fin n → Fin 0` being uninhabited; `E = []` gives just the vertex clauses;
`W = []` gives exactly one cube and no extra clauses.

## Failure modes, stated plainly

* **The encoder is wrong and the certificate hides it.** A certificate proves *some* formula
  unsatisfiable; it cannot tell you it is the wrong formula. This is why route A exists and why the
  headline is proved through it. If routes A and B ever disagree, B is wrong.
* **The native purchase.** Every claim routed through a certificate carries
  `…_native.native_decide.ax_…`. It is named in the docstring of each such declaration, recorded in
  `ARCHITECTURE.md` § 5, and the kernel-only route is tracked open work. `four_le_chromaticNumber_plane`
  does not carry it.
* **The cube split may not be enough for de Grey.** M03 proves the machinery correct, not that any
  particular `W` makes the 1581-vertex instance solvable. That is M05's risk and it is untouched
  here.
* **`decide` on `∀ f : Fin n → Fin k` does not scale**, by design — it is the oracle, not a method.
  Past ~10 vertices it is gone, and M03 is the last milestone that has it.

## Gate

`lake build` green · zero `sorry` · `#print axioms` on the M03 surface, with the native purchases
enumerated and every other line clean · `lake exe runLinter Proofs` silent · spec `#guard`s passing ·
`./scripts/lean4checker.sh` green · **and the milestone's own test**: routes A, B and C all prove
`¬ (edgeGraph 7 moserSpindleEdges).Colorable 3`, and `4 ≤ χ(ℝ²)` reports exactly
`[propext, Classical.choice, Quot.sound]`.
