# M03 — The SAT bridge, and χ(ℝ²) ≥ 4

> The CNF encoding of graph colouring, the one direction of the correspondence the project
> consumes, LRAT certificate ingestion, and the cube split. Everything M05 does at 1581 vertices,
> done here at 7 — where an independent oracle still exists to check it against.

> **STATUS: subplanned (2026-07-27), all three modelling passes applied.** Skeleton elaborates,
> 28 `sorry` at tracked leaves, 16 spec `#guard`s passing, linter clean. Every leaf has a proof
> derived and checked in scratch, and the M05-shaped call site has been written cold against the
> public API and shown to elaborate as a single term.

## De-risk already done (2026-07-27, before this plan was written)

The whole route was run end to end at spindle scale, and one architectural assumption was
**falsified**. Both results are load-bearing, so they are stated first.

### The pipeline works

```
coloringCNF 3 7 moserSpindleEdges          21 variables, 40 clauses
  → CNF.dimacs (printed from the Lean def)  "p cnf 21 40"
  → cadical --lrat --no-binary              exit 20 (UNSAT), instant
  → 26 LRAT actions, 658 bytes
  → Lean literal → LRAT.check → check_sound → Unsat        2.8 s for the whole module
```

with the negative control passing too: the same certificate returns `false` against
`coloringCNF 4 7 moserSpindleEdges`, so `check` is discriminating between formulas rather than
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

Variables are `x_{v,c}` at index `colorVar k v c = k * v + c`, over `ℕ` because that is what
`LRAT.check` consumes. Two clause families:

* one **at-least-one-colour** clause per vertex, `⋁_c x_{v,c}`;
* for each non-loop listed edge and each colour, `¬x_{u,c} ∨ ¬x_{w,c}`.

**At-most-one clauses are deliberately omitted.** The edge clauses already force adjacent vertices'
colour *sets* to be disjoint, so any satisfying assignment yields a proper colouring by picking a
colour per vertex. Fewer clauses, and the direction we prove is untouched.

**Only `Colorable k G → satisfiable` is proved**, and the domain pass sharpened *why* that is safe
rather than merely sufficient. Satisfiability is antitone in the clause set: an encoder emitting too
few clauses gives a satisfiable formula, which has no refutation, so no certificate exists and no
theorem is produced; an encoder emitting too many breaks `exists_sat_coloringCNF`, which fails to
elaborate. **The encoder cannot be wrong in a way that produces a false bound** — only in a way that
makes the certificate unobtainable. The residual risk is that the DIMACS handed to the solver is not
this formula, which is exactly what `ARCHITECTURE.md` § 6's hard rule guards.

**Loops are filtered, and must be.** `edgeGraph` strips loops structurally. A listed `(i, i)` left
in the clause set contributes `¬x_{i,c} ∨ ¬x_{i,c}`, which makes the formula unsatisfiable while the
graph stays colourable — i.e. it makes `exists_sat_coloringCNF` *false*. `coloringCNF` filters under the
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
| `hjoin : chunks.flatten = c.edges`, by `rfl` | `hcover : allCubes k n W = cubes`, by `rfl` |
| `∀ ch ∈ chunks, ValidOn ch` | `∀ cb ∈ cubes, Unsat (cnf ++ cubeCNF k n cb)` |
| call site: `fin_cases hch; exacts [...]` | `fin_cases hcb; exacts [...]`, or a plain tuple |

`cubeOf_mem_allCubes` is the covering lemma the `hcover` equation feeds.

The alternative — an explicit cube list plus a covering hypothesis — was rejected: any covering
condition phrased over colourings quantifies over `k ^ n`, which is not checkable at n = 1581.
Generating the enumeration makes the covering fact a *theorem* (structural induction on `W`) rather
than a decision. `W = []` yields exactly one cube, the empty one, so the monolithic case is the
split's own base case rather than a separate mechanism.

## Scope

**In.**

1. `Sat/Encoding.lean` — `colorVar`, `atLeastOneClause`, `edgeClauses`, `coloringCNF`;
   `exists_sat_coloringCNF` and its contrapositive `not_colorable_of_unsat`, over a **private**
   `colorFn`/`ofColoring` and the arithmetic lemma underneath them.
2. Cubes, same module — `Cube`, `cubeCNF`, `cubeOf`, `allCubes`, `cubeOf_mem_allCubes`,
   `exists_sat_coloringCNF_cube`, `not_colorable_of_cubes`.
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
| `colorVar 3 2 1` | `7` = 2·3+1 |
| `(coloringCNF 3 7 moserSpindleEdges).clauses.size` | `40` = 7 + 3·11 |
| `(coloringCNF 3 2 [(0,0)]).clauses.size` | `2` — the self-loop contributes no clause |
| `(coloringCNF 3 2 [(0,1)]).clauses.size` | `5` = 2 + 3 |
| `(allCubes 3 [0,1]).length` | `9` = 3², and the nine cubes print correctly |
| `CNF.eval (ofColoring 4 (colorFn ![0,1,2,0,1,2,3])) (coloringCNF 4 …)` | `true` |
| `CNF.eval (ofColoring 3 (colorFn ![0,1,2,0,1,2,3])) (coloringCNF 3 …)` | `false` |
| `CNF.dimacs (coloringCNF 3 3 triangleEdges)` | `p cnf 9 12`, and the twelve clauses read correctly by eye |

The last two rows are the two-sided check that matters: the same colouring satisfies the formula at
four colours and fails it at three, so `coloringCNF` is tracking the colouring rather than
answering a constant.

**The concrete model of the hypotheses** is `spindleFour = ![0,1,2,0,1,2,3]`, a real 4-colouring of
the spindle verified above. It instantiates `exists_sat_coloringCNF` with something concrete,
which is what stops `not_colorable_of_unsat` from being a `∀` over an empty domain.

## Skeleton

Elaborating now, `sorry` at every leaf:

* `Proofs/HadwigerNelson/Sat/Encoding.lean` — 17 leaves, 10 of them private helpers
* `Proofs/HadwigerNelson/Sat/Lrat.lean` — 0 leaves (`unsat_of_check` over `check_sound`, plus the
  `badCubes` diagnostic; the module's content is the boundary it documents)
* `Proofs/HadwigerNelson/Reduction.lean` — 2 leaves (the two composites are derived terms)
* `Proofs/HadwigerNelson/Instances/SpindleBound.lean` — 9 leaves

## Obligation-modeling pass (2026-07-27)

Every leaf below was **derived and closed in scratch before being written down**, so the skeleton's
finer agenda is a transcription of working proofs rather than a wish list. The leaf count went 20 →
27: one `sorry` replaced by finitely many strictly smaller ones, which is the only legal move.

### `sat_coloringCNF` — the milestone's theorem, and the space it lives in

There is no induction. `coloringCNF` is an append of two `map`s, so the space is the clause list and
`List.mem_append` carves it. The chain that gets there:

```
CNF.Sat → CNF.eval → List.all_toArray → List.all_eq_true → ∀ cl ∈ (vertices ++ edges)
                                                              └─ List.mem_append
```

and each side is one stated lemma. Five private helpers carry the arithmetic and the two clause
families, so the assembly is 18 lines with no step needing a walkthrough:

| lemma | content |
|---|---|
| `ofColoring_colorVar` | the round trip. `simp [ofColoring, colorVar, Nat.mul_add_div hk, Nat.mod_eq_of_lt hc, Nat.div_eq_of_lt hc]` — pinned; `Nat.mul_add_mod` turns out unnecessary, simp finds it |
| `colorFn_lt` | the extension lands in range everywhere — **this is where `hk` pays for the junk value** |
| `colorFn_val` | it agrees with the colouring in range |
| `ofColoring_self` | a vertex's own colour variable is set |
| `ofColoring_ne` | any other colour's variable is unset |
| `eval_atLeastOneClause` | the vertex clause, witnessed at `colorFn C v` |
| `eval_edgeClause` | the edge clause, by case split on `c = colorFn C u`; each branch cites `ofColoring_ne` |

The edge side of the assembly crosses three seams in order, and each has exactly one citation:
`List.mem_filter` (Bool `!=` to Prop `≠`, via `simpa`), `edgeGraph_adj_of_mem` (list membership to
`Adj` — the packaging M01 wrote for this call site), `Coloring.valid` (`Adj` to `C i ≠ C j`), then
`Fin.val_inj` to land on `colorFn`.

### One witness, named once

`exists_sat_coloringCNF` and `exists_sat_coloringCNF_cube` must agree on the assignment — the cube
split turns on a single `a` satisfying both halves of `CNF.eval_append`. So the witness is a private
lemma (`sat_coloringCNF`) and both existentials cite it.

The cube half, `sat_cubeCNF_cubeOf`, takes an **arbitrary `C : Fin n → Fin k`**, not a colouring:
satisfying one's own cube has nothing to do with the graph. Polya's direction — the more general
statement is the easier proof, and here it is also the honest one.

### `cubeOf_mem_allCubes` — the only induction

Structural on `W`, and it is the recursor `allCubes` already recurses along, which is the sign the
domain pass got the type right. Four lines: `nil` gives `[] ∈ [[]]` by `simp`; `cons` is
`List.mem_flatMap` → `List.mem_map` → `List.mem_finRange`, picking `cb = cubeOf W C` from the IH
and `c = C v`.

### The rest

* `not_colorable_of_unsat` / `not_colorable_of_cubes` — three and four lines. `rintro ⟨C⟩`, take the
  witness, contradict the `Unsat` at that assignment. The children are already-closed leaves, so the
  measure descends trivially. `not_colorable_of_cubes` is the one that also cites
  `cubeOf_mem_allCubes`; that is the only thing the split needs beyond the monolithic case.
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

## Experience-modeling pass (2026-07-27)

Run with M05's generated module as the primary user, and the decisive move was writing that call
site **cold, against the public API only**, before judging anything. It now elaborates as one term:

```lean
theorem headline : (4 : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  moserSpindle.add_one_le_chromaticNumber_plane_of_cubes moserSpindle_valid
    moserSpindleSplit moserSpindleCubes moserSpindleCubes_eq
    (List.forall_iff_forall_mem.mp ⟨u₀, …, u₈⟩)
```

No `by decide` for the denominator, no `by norm_num` for `0 < k`, no `norm_num at h; exact h`. Four
things had to change to get there.

### The breakdown surface changed the *signature*

The sharpest finding of the pass. With the obligation stated as `∀ cb ∈ allCubes k n W, …`, a
certificate filed against the wrong cube reports

```
q₅ has type Q [(0, 2), (1, 1)]
but is expected to have type
  Q ((fun c => (0, c) :: (fun c => [(1, c)]) ((fun i => i) ⟨1, ⋯⟩)) ((fun i => i) ⟨1, ⋯⟩))
```

— the *enumeration's implementation*, unreduced, with no indication of which cube. At 256 cubes
that is undiagnosable. Passing the cube list as a literal and tying it down with
`hcover : allCubes k n W = cubes` (by `rfl`, measured under 4 s at 256 cubes) makes the same mistake
report

```
q₅ has type Q [(0, 2), (1, 1)] but is expected to have type Q [(0, 1), (1, 1)]
```

So `not_colorable_of_cubes` and its `Reduction.lean` flavour now take `cubes` and `hcover`. This is
the *third* independent reason to land on `valid_of_chunks`' shape — the project now has one shape
for generated conjunctions, and it is the one whose errors name the culprit.

Both discharge routes were measured with a deliberately misfiled entry: `fin_cases hcb; exacts […]`
reports the first mismatch; `List.forall_iff_forall_mem.mp ⟨…⟩` reports *every* mismatch with column
positions and does no tactic search. Prefer the tuple past ~100 cubes.

### `n` had to become explicit

`cubeCNF 3 [(0,0),(1,0)]` does not elaborate — `n` is not determined by a cube literal, so every one
of M05's 256 generated theorems would have carried `(n := 1581)`. When every user writes the same
argument, the argument is the bug. `cubeCNF k n cb` and `allCubes k n W` are now explicit, matching
`coloringCNF k n E`, which already was.

### British prose, American identifiers

`colouringCNF` sat next to Mathlib's `Colorable` in every goal — two spellings of one word in one
expression, and a user who knows Mathlib will type the other one. Identifiers are now `coloringCNF`,
`colorVar`, `colorFn`; the prose stays British. `restrict` became `cubeOf`: it says what it returns
and cannot be confused with `Function.restrict`.

### `0 < k` and `denom ≠ 0` are `autoParam`s

Every call site has `k` and `denom` as literals. `(hk : 0 < k := by norm_num)` and
`(hd : c.denom ≠ 0 := by decide)` make the common path silent and the uncommon path stateable. They
must sit **last** in the signature: an `autoParam` mentioning `k` fires before `k` is known if it
comes before the hypothesis that determines it.

### Diagnosis: `badCubes`, the analogue of `badEdges`

`native_decide` can only say "no", and at 256 cubes it does not say which. `badCubes k n E cubes
proofs` (in `Sat/Lrat.lean`) runs compiled and returns the failing cubes with their indices,
including cubes with no certificate at all rather than letting `zip` drop them silently. Its
docstring names the three causes in decreasing order of likelihood — stale certificate, wrong cube,
genuinely satisfiable — because knowing *which* cube is only half of what the author needs.

For the other breakdown, "route A and route B disagree", no new code: the two-sided spec `#guard`s
already in `SpindleBound.lean` are the instrument, and the module docstring now names the diagnosis
order.

### The trust boundary, made a checked artifact rather than a reading

Two halves. In the source, every declaration that evaluates a certificate opens its docstring with
the exact phrase **"Trust purchase: native evaluation."**, so `grep -rn "Trust purchase" Proofs/`
is the ledger. In the environment, `scripts/Axioms.lean` now prints machine-readable `=== CLEAN ===`
and `=== PURCHASED ===` banners, and **`scripts/axioms.sh`** enforces the rule: no native axiom and
no `sorryAx` above the banner, no `sorryAx` and no *missing* purchase below it. A stale ledger entry
— a declaration that stopped needing the purchase and never told the audit — fails too.

This exists because the gate hole found at subplan time was exactly the kind a human reading twenty
`#print axioms` lines will miss: one long name, in the middle, that used to be spelled differently.
The script rejoins `#print axioms`' wrapped output before matching, since the lists wrap and a
line-oriented grep both misses records and mis-reports them.

### Docstring contracts

`coloringCNF` carries an unusual one, stated plainly: **it owes no lemma API and has none by
design.** Nothing downstream reasons about the formula's shape — it is printed to DIMACS and handed
to a checker — so the three theorems `exists_sat_coloringCNF` / `not_colorable_of_unsat` /
`not_colorable_of_cubes` are the entire reasoning surface, and the docstring says what to do instead
of unfolding. `ofColoring` and `colorFn` need no contract: they are `private`, so the question
cannot arise.

## Domain-modeling pass (2026-07-27)

Six questions went in; four confirmed the model, two changed it, and one measurement decided a
definition.

**Confirmed.**

* **`CNF ℕ` with `colorVar`, not `CNF (Fin n × Fin k)` + `CNF.relabel`.** A variable *is* a
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
  and `coloringCNF` apply — one convention, three sites.
* **The certificate does not carry its own ambient space.** `Q4` coordinates are Cartesian; the
  ambient space is an interpretation chosen once by `toPlane`, and indexing `UDCert` on it would tax
  every signature for something no consumer inspects.

**Changed.**

* **`colorVar k v c = k * v + c`**, not `v * k + c`. Measured: with `k * v + c` the round-trip lemma
  is one `simp` citing `Nat.mul_add_div` / `Nat.mul_add_mod`; with `v * k + c` the same call leaves
  `(v * k + c) / k = v` unsolved. Identical numbering, identical DIMACS — the definition was shaped
  around the statement, which is the whole move.
* **The satisfying assignment is a witness nobody consumes, so it went behind `∃` and its
  construction went `private`.** `colorFn` extends a colouring by a junk value off-range; that junk
  was sitting in the statement of the milestone's main theorem, and every consumer discards the
  assignment to contradict an `Unsat`. `sat_coloringCNF` became `exists_sat_coloringCNF`, and
  `colorFn`/`ofColoring`/`colorFn_val`/the round-trip lemma left the public surface. The junk still
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

---

## What landed (implementation, 2026-07-28)

All 28 skeleton leaves closed. The gate is green in full; see the run below.

### The pipeline, end to end

```
Sat/Encoding.lean  ──(scripts/Dimacs.lean)──▶  build/sat/*.cnf
                                                    │
                                             tools/solve.sh  (CaDiCaL 2.1.2, --lrat --no-binary)
                                                    ▼
                                              build/sat/*.lrat
                                                    │
                                          scripts/EmitLrat.lean  (core's own LRAT parser)
                                                    ▼
                              Instances/SpindleLrat.lean   ── committed, never hand-reviewed
```

Ten runs, all UNSAT: the monolithic instance (26 actions, 658 bytes) and nine cubes (5–20 actions
each). Cubes 0, 4 and 8 — the ones giving adjacent vertices 0 and 1 the same colour — need only 5
actions, which is the expected shape and a free sanity signal.

**Nothing outside Lean authors a clause or parses a certificate.** DIMACS is printed by
`Std.Sat.CNF.dimacs` applied to `coloringCNF` itself; the `.lrat` files are read by
`LRAT.loadLRATProof`, the same parser `bv_decide` uses. The `Array IntAction` written into the
generated module is by construction the one core's parser produces, so our reading of the LRAT
format cannot disagree with core's.

### Decisions implementation forced

* **`decide +kernel`, not `decide`, for route A.** Plain `decide` evaluates the `Decidable` instance
  in the elaborator *and* has the kernel re-check it, so the 2187-colouring enumeration runs twice:
  8.3 s of work, and it needs `maxRecDepth` raised past 4000 because the elaborator's own recursion
  tracks the enumeration. The kernel route runs it once, in 2.6 s, at the default recursion depth
  and with no `set_option` anywhere. Same instance, same axioms — evaluated once instead of twice.
  The alternative (raise `maxRecDepth` and keep plain `decide`) was live and rejected: it is 3×
  slower and adds a knob whose correct value nobody could predict at M04 scale.
* **The nine certificate checks are named once**, as `moserSpindleCubes_unsat`, rather than inlined
  into each consumer. `moserSpindle_not_colorable_three_cubes` and
  `four_le_chromaticNumber_plane_certified` both need the same `∀ cb ∈ cubes, Unsat` obligation;
  inlining would have evaluated all nine certificates twice and minted 18 axioms instead of 9.
* **`renderAction` emits dot notation**, not derived `Repr`. `Repr`'s output does re-elaborate, but
  spells `Std.Tactic.BVDecide.LRAT.Action.addRup` in full — ~40 bytes of namespace per action. At
  spindle scale that is cosmetic; at de Grey scale it is the difference between a file Lean can load
  and one it cannot. The match is total and unabbreviated, so a future constructor turns the file
  red rather than dropping actions.

### The gate hole this pass closed

`Sat/Lrat.lean` claimed *"`scripts/Axioms.lean` prints the same ledger from the environment; the two
must agree, and the gate compares them."* **The gate did not compare them.** It does now:
`scripts/axioms.sh` extracts the source-side ledger (declarations whose docstring opens with
`**Trust purchase: native evaluation.**`) and the environment-side ledger (the `PURCHASED` banner),
and fails on any disagreement in either direction. Verified by deleting a `#print axioms` line — the
gate exits 1 and names the declaration.

Writing the check found a second thing: matching the phrase anywhere caught `unsat_of_check`, whose
*module* docstring quotes the convention while the theorem itself is axiom-clean. The check now
matches `/-- **Trust purchase:` — the convention as actually stated, "opens its docstring".

### Negative controls, now permanent

The build proves every certificate *does* check; nothing in it proved one could **fail**, and a
checker that accepted everything would have satisfied every theorem in the file. Four `#guard`s in
`Instances/SpindleBound.lean` now run every build:

| control | result |
|---|---|
| certificate 0 against cube 1 | fails — the refutation cannot transfer |
| monolithic certificate against the *satisfiable* 4-colour formula | fails — no certificate exists |
| `badCubes` on a ledger with 0 and 1 swapped | names exactly `[0, 1]` |
| `badCubes` on a ledger missing two entries | names exactly `[7, 8]` |

### The breakdown surface, confirmed in practice

Deliberately swapping two certificates produces, for **both** wrong entries rather than the first:

```
error: Tactic `native_decide` evaluated that the proposition
  LRAT.check spindleCubeCert2 (coloringCNF 3 7 moserSpindleEdges ++ cubeCNF 3 7 [(0, 1), (1, 0)]) = true
is false
```

The cube is a readable literal. That is the payoff of the experience pass's signature change
(`cubes` supplied literally, tied by `hcover : allCubes k n W = cubes`), and it is the property M05
depends on at 256 cubes.

### Gate run

| check | result |
|---|---|
| `lake build` | green, 3158 jobs, no warnings |
| `sorry` | none in `Proofs/` |
| `lake exe runLinter Proofs` | "Linting passed for Proofs." |
| spec `#guard`s | 19, all passing at elaboration (9 encoding, 8 spindle, 2 geometry) |
| `./scripts/axioms.sh` | OK — 38 clean, 5 declared purchases, both ledgers agreeing |
| `./scripts/lean4checker.sh` | OK — 13 modules through the independent kernel |
| **routes A, B, C agree** | all three prove `¬ (edgeGraph 7 moserSpindleEdges).Colorable 3` |
| **headline axioms** | `four_le_chromaticNumber_plane` → `[propext, Classical.choice, Quot.sound]` |

### Carried to M05 unchanged

Colour symmetry breaking (fixing a triangle to colours 0,1,2), certificate trimming and the binary
LRAT format, which `W` splits the de Grey instance best, and the kernel-reducible LRAT checker
(tracked open work, not attempted).
