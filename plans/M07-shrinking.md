# M07 — Shrinking

> A certified 5-chromatic unit-distance graph strictly smaller than de Grey's 1581 vertices, on the
> same infrastructure. Terminal test: `chromaticNumber_plane_ge_five` re-proved from a witness of
> **510** vertices and again from one of **553**, zero `sorry`, axioms exactly
> `[propext, Classical.choice, Quot.sound]`, and — for the first time on a certificate —
> `lean4checker` actually able to finish.

*Subplanned 2026-07-30 on the desktop (32 cores, 125 GB), one other project running at 1–2 cores.
Kernel projections use M06's measured per-hint cost. Solver runs are single-threaded CaDiCaL 2.1.2
from the toolchain; timings are wall seconds unless marked otherwise.*

---

## 0. What this subplan measured, and what it overturned

Five measurements. The first two kill the route the milestone's own name implies; the last three
replace it with one that is **31× cheaper than the proof M06 shipped** and makes the witness a third
of the size.

### (a) de Grey's graph does not shrink — it is a fixed point under every handle we own

`ARCHITECTURE.md` § 7 flagged "smaller graph, smaller proof" as an assumption M07 must measure. The
measurement is worse than that warning: de Grey's graph does not shrink *at all* through the only
decomposition that makes it checkable.

The proof M06 shipped needs each 791-vertex half to *force* its end of the joining edge to the shared
vertex's colour. So a vertex may be deleted only if that forcing survives. Measured, on half A:

| instrument | result |
|---|---|
| **core-guided deletion** — which clauses does the trimmed refutation actually cite? | **16,382 of 17,333**, touching **all 791 vertices**. Nothing is deletable for free. |
| **single-deletion sweep** — 789 independent refutations, 4 min on 28 cores | **2** vertices deletable |
| **iterated to a fixed point** | **789 vertices**, reached in two rounds |

So the whole of M06's witness shrinks from 1581 to **1577**, and stops. The forcing gadget is
essentially vertex-critical, which is a real fact about de Grey's construction and a complete answer
to the milestone's first idea.

### (b) And the whole graph cannot be probed directly, because it does not refute

To ask "is `G − v` still 5-chromatic" one must refute `G − v`, and de Grey's graph has no monolithic
refutation. M06 measured six configurations passing 1.5 GB of certificate without terminating; this
subplan re-ran them **without proof logging**, in case the certificate was the obstacle rather than
the search. Six configurations, 12 minutes on 6 cores: **none terminated.** A depth-3
cube-and-conquer split, 64 cubes on 28 cores, did not terminate either.

The only oracle that answers at all is M06's depth-5 split — **99 minutes of processor time per
question**. At 1581 questions per sweep that is a route, but a hundred-fold worse than the one below.

### (c) The published smaller witnesses are in a field this project already has

Marijn Heule's `CNP-SAT` repository publishes vertex and edge lists for 5-chromatic unit-distance
graphs at 874, 826, 803, 633, 610, 553, 529, 517 and **510** vertices, in exact Mathematica
coordinates. Every radical that occurs is `Sqrt[3]`, `Sqrt[5]`, `Sqrt[11]` and their products —
**ℚ(√3,√5,√11), a subfield of the ℚ(√3,√5,√7,√11) tower M02 built.** No new field, no new geometry
machinery.

Re-derived from the coordinates alone by `tools/heule.py`, in 8 seconds each:

| | 510 | 553 |
|---|---|---|
| distinct points | 510 ✓ | 553 ✓ |
| listed edges at exactly unit distance | **2504 of 2504** | **2722 of 2722** |
| unit-distance pairs the file *omits* | **0** | **0** |
| common denominator | 96 | 288 |

The last row of that table is the one that matters for provenance: re-deriving *every* unit-distance
pair among the listed points returns exactly the listed edge set, so the file is not a curated
subgraph whose completeness we would have to take on trust.

**Provenance is worth nothing to the theorem, and that is the point.** The claim quantifies over the
points as written; a reader needs the coordinates and the checks in Lean, never the search that found
them. This is a weaker dependence on someone else's work than a construction narrative would be, not
a stronger one.

### (d) They refute monolithically — and pinning a triangle is worth 20×

| | 510 | 553 |
|---|---|---|
| monolithic, best of four configurations | UNSAT in **99 s**, 470 MB | UNSAT in **78 s**, 314 MB |
| trimmed hint entries | 31,808,514 | 28,252,564 |
| **with one triangle pinned to colours 0,1,2** | UNSAT in **2 s**, 24 MB | UNSAT in **2 s**, 18 MB |

Naming a triangle's three colours is free — colour names are arbitrary, so a graph is 4-colourable
iff it is 4-colourable with a fixed triangle taking 0, 1, 2 — and it removes the 24-fold colour
symmetry that the solver otherwise re-derives inside every branch. It is the single largest lever in
this subplan and it costs one lemma.

### (e) Racing the certificate is worth another 10.5×

M06 § 7 ranked "race more solver configurations on trimmed hint count" as the top unmeasured lever.
Here a run costs 2 seconds, so it was swept properly: 10 triangles × 4 configurations × 4 seeds =
160 certificates per graph, every one backward-trimmed and counted.

| | best | worst | spread |
|---|---|---|---|
| 510 | **1,413,841** hints, 33,995 additions | 14,828,439 | **10.5×** |
| 553 | **1,104,106** hints, 25,579 additions | 11,034,947 | **10.0×** |

Both winners are `--unsat` on a triangle of high-degree vertices. A tenfold spread across choices
that all look equivalent is why raw file size may never be the selection criterion.

## 1. The cost, and what it buys

| | M06, shipped | M07: 553 | M07: 510 |
|---|---|---|---|
| vertices | 1581 | 553 | 510 |
| edges | 7877 | 2722 | 2504 |
| certificates | 2 | **1** | **1** |
| base clauses | 33,089 (17,335 per half) | 11,444 | 10,529 |
| derived clauses | 561,827 | 25,579 | 33,995 |
| **trimmed hint entries** | **34,169,571** | **1,104,106** | **1,413,841** |
| projected kernel | — | **0.41 h** | **0.53 h** |
| measured kernel | **27.8 h** | | |
| source artifact | 396 MB | ~14 MB | ~18 MB |

The per-hint figure is **1.35 ms**, not M06's realised 2.93 ms: that number rose with table size, and
M06 measured 1.35 ms at a 33.5k-clause table — which is exactly the scale here (37k and 45k, against
M06's 317k). Both witnesses together are projected at **~1 hour of processor time**, against 27.8
hours for the proof already in the tree.

**Three things that hour buys beyond a smaller number:**

1. **`lean4checker` can finish.** M06's one incomplete gate item is that replaying its certificates
   through an independently written kernel repeats every reduction single-threaded — another 27.8
   hours, in one process that cannot be split. At 1.4 M hints the replay is **1–2 hours**. The
   independent-kernel claim stops being partial.
2. **The proof structure collapses.** No decomposition, no forcing lemmas, no two halves, no
   watermark chaining. `not_colorable_of_unsat` composed with one symmetry lemma.
3. **Two independent witnesses of one theorem.** 510 and 553 are different graphs with different
   certificates. A bug in the encoding or the checker that certified both would have to be a bug that
   certifies two unrelated graphs — which is a materially stronger statement than one witness makes.

**Decision — certify both 510 and 553, with 510 as the headline.** *Alternative:* 553 alone, which is
the cheaper certificate by 0.12 h and would halve the generated modules. *Why this one:* the second
witness costs about twenty minutes of build and buys the cross-check in point 3, which is the only
evidence available against a systematic error in our own pipeline; and 510 is the smaller headline
number and the one our own search proved critical (§ 5). *Confidence: high* — both certificates are in
hand and both geometries are verified.

**Decision — keep M06's de Grey proof in the tree rather than retiring it.** *Alternative:* delete the
2,265 generated segment modules and let M07's witness carry the theorem, recovering 27.8 hours from
every clean build and 297 MB of compiled output. *Why this one:* M06 is de Grey's own graph proved by
de Grey's own argument, which is the historically faithful formalization and the thing a referee of
the χ ≥ 5 result would want to see; M07 is a different and better-engineered claim, not a replacement.
Clean builds are rare and incremental builds pay nothing. *Confidence: medium — if a from-scratch
rebuild becomes routine (a toolchain bump, a Mathlib bump), this is the first thing to reconsider.*

## 2. The shape

```
                  chromaticNumber_plane_ge_five                    [Instances/Heule/Bound.lean]
                          │  M01's reduction, unchanged
              ¬ Colorable 4 (edgeGraph 510 heule510.edges)
                          │  a proper 4-colouring C
                          │  C u, C v, C w pairwise distinct — u,v,w is a triangle
                          │  relabel by a permutation taking them to 0,1,2
              (coloringCNF 4 510 E ++ cubeCNF 4 510 [(u,0),(v,1),(w,2)]).Unsat
                          │  one kernel-checked refutation, ~32 segments
                  runSegment / justified_of_segment                [Sat/MaskCheck.lean — M05, unchanged]
```

Everything below the reduction is M05 and M06 machinery used verbatim. The only new *proof* is the
triangle-symmetry step, which is M06's two-vertex normalisation with one more swap.

### 2.1 The witness is data, and the geometry is small

Each witness gets its own directory under `Instances/Heule/`, laid out exactly as M04 laid out de
Grey's: a point table as a literal, an edge list split into chunks, one geometry module per chunk,
and a `Valid` module that cites the chunks rather than re-deciding them. At 2504 and 2722 edges
against de Grey's 7877, and M04's measured 0.045 s per edge, the whole geometry is **under four
minutes** — one module per witness would do, and the chunking exists only to keep peak memory flat.

### 2.2 The certificate needs no segmentation it cannot afford

M06 split each certificate into 2,265 modules because 34 M hints at 3 GB of peak memory per job had
to be spread across twelve concurrent builds. At 1.4 M hints the same emitter with `PER_MODULE`
raised produces **~32 segments per witness**, one per core, each about two minutes. The measured
memory model — 3.4 GB plus 0.81 GB per certificate chunk — puts a 32-way build at well under half
this machine's memory, so no `systemd-run` cap and no batching is needed.

### 2.3 What does *not* change

`Sat/Mask.lean`, `Sat/ClauseTable.lean`, `Sat/MaskCheck.lean`, `Sat/Encoding.lean`,
`Certificate.lean`, `EdgeList.lean`, `Reduction.lean` — untouched. `tools/emit_geometry.py`,
`tools/emit_cert.py`, `tools/emit_mask.py` — parameterised, not rewritten. **If any of these needs a
change, that is a finding, and it goes in § 4.5 rather than being made quietly**: M05 and M06 claimed
this infrastructure was general, and M07 is the first test of that claim.

## 3. The statements

### 3.1 `Sat/Forcing.lean` — the triangle normalisation

M06 proved that a 4-colouring can be relabelled so that two chosen vertices take colours 0 and 1,
given only that they differ. A triangle gives three pairwise-distinct colours, and the same
construction with one more transposition sends them to 0, 1, 2.

```lean
/-- Any three pairwise-distinct colours can be relabelled to `0, 1, 2` by a permutation. -/
theorem exists_perm_apply_three {a b c : Fin 4} (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    ∃ σ : Equiv.Perm (Fin 4), σ a = 0 ∧ σ b = 1 ∧ σ c = 2

/-- A proper 4-colouring can be relabelled so that a chosen triangle takes `0, 1, 2`. -/
theorem exists_normalized₃ {G : SimpleGraph (Fin n)} {f : Fin n → Fin 4} (u v w : Fin n)
    (hf : ∀ i j, G.Adj i j → f i ≠ f j)
    (huv : G.Adj u v) (huw : G.Adj u w) (hvw : G.Adj v w) :
    ∃ g : Fin n → Fin 4, (∀ i j, G.Adj i j → g i ≠ g j) ∧ g u = 0 ∧ g v = 1 ∧ g w = 2

/-- **The bridge M07's witnesses consume.** One refutation of the formula with a triangle pinned to
`0, 1, 2` proves the graph has no 4-colouring at all. -/
theorem not_colorable_of_triangle_pinned {E : List (Fin n × Fin n)} {u v w : Fin n}
    (huv : (u, v) ∈ E) (huw : (u, w) ∈ E) (hvw : (v, w) ∈ E)
    (hne : u ≠ v ∧ u ≠ w ∧ v ≠ w)
    (h : (coloringCNF 4 n E ++ cubeCNF 4 n [(u, 0), (v, 1), (w, 2)]).Unsat) :
    ¬ (edgeGraph n E).Colorable 4
```

The last one is the whole consumer surface: a generated witness module cites it once and is done.
Note what it does *not* assume — no decomposition, no subgraph inclusions, no watermarks.

**Domain pass, 2026-07-30 — what it changed and what it refused.**

*Changed: the triangle arrives as three adjacency facts, not six list facts.* The skeleton took three
list memberships plus three `≠`; the proof consumes neither — it consumes "these three colours are
pairwise distinct", which is three `Adj` facts. Six hypotheses became three, and the call site pays
the same `by decide` either way. The finding that made it worth doing is the second-order one:
`SimpleGraph.Adj` is irreflexive, so a **degenerate triangle is uninhabited rather than unprovable**.
`eq_of_pinned_unsat`, one screen above it, has to argue in a docstring why a degenerate cube is
harmless — and M06's negative control caught that docstring being wrong. This shape has no such
argument to get wrong. *Confidence: high.*

*Refused: unifying the two top-level theorems.* `not_colorable_of_forcing` (de Grey's) and
`not_colorable_of_triangle_pinned` (M07's) look like one idea — "a refutation of a constrained
formula proves the unconstrained claim" — and they are not. The first can only derive an *equality*
(pinning `u→0, a→1` is realisable only when the colours differ, so the refutation yields
`C a = C u` and the contradiction must come from a further edge); the second derives the
contradiction *directly* (a triangle's colours always differ, so the relabelling exists
unconditionally). Their shared content is `not_pinned`, which already exists and is already cited by
both. *Alternative:* one lemma over a list of pinned vertices whose colours are pairwise distinct,
with both as instances. *Why not:* Mathlib has no "extend a partial injection to a permutation" in
that shape — `Equiv.Perm.extendDomain` is a different construction — so the general form costs an
induction, while the concrete form is `decide +kernel` over 24 permutations against 64 colour
triples, **elaborating in 1.1 s**. Generalising here would add structure to save nothing.
*Confidence: high — both proofs are written and green.*

*Refused: a bundled `Triangle E` subtype.* One construction site per witness, one elimination site,
and the three adjacency facts are already the smart constructor's output. A type with one inhabitant
per use is the speculative structure the standard forbids. *Confidence: high.*

*Refused: a narrower field for Heule's coordinates.* They live in ℚ(√3,√5,√11), so eight of the
tower's sixteen basis elements are identically zero and every multiplication costs 4× what it needs.
But `Pt` is fixed to `Q4` by M04, and parameterising it would touch `Pt.distSq`, `eval_distSq`,
`dist_toPlane_eq_one`, `UDCert` and every geometry theorem — to save about three minutes on a
four-minute geometry. The zero components are a fact about *these two witnesses*, not about
unit-distance graphs; de Grey's needs `√7`. Incidental structure, correctly not represented.
*Confidence: high — and if M08 makes geometry the bottleneck, it changes the per-edge cost model, not
this decision.*

*Refused: teaching Lean the generator's JSON shape.* The JSON is untrusted input to an untrusted
tool. What Lean should see is not the schema but the *claims* — vertex count, edge count, denominator,
the triangle's adjacency — each pinned by `#guard` in the generated module, exactly as M04 pinned de
Grey's. The schema gets **one** reader instead of three, though: `tools/emit_geometry.py`,
`emit_cert.py` and `emit_mask.py` each currently hard-code a witness, and that *is* the
N-declarations-identical-modulo-naming smell — it just lives in `tools/`, not in Lean.
*Confidence: medium — if a fourth witness ever wants a different module layout, the parameterisation
is where it will show.*

*Confirmed: the role is already named.* What "de Grey", "Heule 510" and "Heule 553" have in common is
`UDCert n` — a point table, a denominator, an edge list, and `Valid`. The shared theorem is
`add_one_le_chromaticNumber_of_valid`. Both exist since M04, so M07 adds no abstraction: one
generated directory per witness, and de Grey's halves-and-crossing structure stays his alone.

### 3.2 `Instances/Heule/G510.lean` and `G553.lean` — the witnesses

Mirroring `Instances/DeGrey.lean`:

```lean
/-- Every listed edge joins two points of the plane at distance exactly 1. -/
theorem heule510_unit_distances : ∀ e ∈ heule510.edges, dist (…) (…) = 1

/-- A finite unit-distance graph with no 4-colouring bounds the chromatic number of the plane. -/
theorem heule510_bound_of_not_colorable
    (h : ¬ (edgeGraph 510 heule510.edges).Colorable 4) :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber

/-- The graph is 5-chromatic: one kernel-checked refutation, via the triangle normalisation. -/
theorem heule510_not_colorable_four : ¬ (edgeGraph 510 heule510.edges).Colorable 4
```

### 3.3 `Instances/Heule/Bound.lean` — the headline, re-proved

```lean
/-- **χ(ℝ²) ≥ 5**, from a 510-vertex witness. -/
theorem chromaticNumber_plane_ge_five' :
    5 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber :=
  heule510_bound_of_not_colorable heule510_not_colorable_four
```

**The name is a decision, not a default.** *The choice:* M06's `chromaticNumber_plane_ge_five` keeps
its name and M07's witnesses prove separately-named corollaries. *Alternative:* re-point the headline
name at the cheap witness and rename M06's. *Why this one:* the headline name is cited in
`ARCHITECTURE.md`, `scripts/Axioms.lean` and M06's own docstrings, and a formalization whose flagship
theorem changes meaning between commits is one a reader cannot cite. *Confidence: high.*

### 3.4 Obligation pass, 2026-07-30 — where the obligations actually live

Almost every obligation in this milestone is *generated*, which changes what the pass is for: there is
no induction to design, so the question is which claims are **proved**, which are **tested**, and which
are **assumed** — decided once, deliberately, rather than left to whatever closed.

| claim | rung | why that rung |
|---|---|---|
| every listed edge is unit distance | **proved** — kernel decision per chunk, glued by `valid_of_chunks` | the whole point of exact arithmetic |
| the chunks concatenate to the edge list | **proved** — `rfl`, because the edge list *is* the flattened chunks | free by construction |
| the clause table matches the formula | **proved** — `agreesWithCNF`, kernel | the certificate is meaningless without it |
| the table does *not* match the other witness's formula | **proved** — new, see below | was a procedure; is now an obligation |
| the certificate refutes | **proved** — segments chained by type | the milestone |
| the triangle is a triangle | **proved** — three `Adj`, `by decide` | three literals |
| vertex count, edge count, denominator | **tested** — `#guard` | facts about data, not about the theorem |
| the coordinates are the ones Heule published | **assumed, and irrelevant** | the theorem quantifies over the points as written |

*Confirmed: `valid_of_chunks` is the right recursor, and there is nothing to strengthen.* `ValidOn` is
a `List.all`, `&&` is an associative combine with a unit, and `validOn_flatten` is literally
`List.all_flatten` — no proof at all. The gluing is free because the combine is a monoid homomorphism,
which is also exactly why splitting the work across modules needs no justification. Chunk count is
therefore a pure cost choice, not a shape one: **eight modules per witness**, ~313 edges each, chosen
so wall clock is one job per core rather than for any property of the statement.

*Confirmed: the flat implication chain is the right composition, and its depth limit is a cost fact
rather than a shape fact.* The tempting alternative is a list of segments folded by a lemma. It is
strictly worse, and the reason is the safety property M06 identified: each segment is
`Justified t f wₖ → Justified t f wₖ₊₁`, so **the chain typechecks only if the watermarks chain**, and
the elaborator does that check for free. A homogeneous list would need the watermarks existentially
packed, converting a typing check into a proof obligation someone must state — the witnessing
hierarchy's top rung traded for a lower one. *Confidence: high.* One change follows: M06 emitted
`set_option maxRecDepth` into every generated header because 2,265 segments overflowed at 1,222. At
~32 segments the knob is unnecessary, so **the emitter stops emitting it below 500 segments** — which
makes its presence a signal rather than boilerplate.

*New: cross-filing becomes a theorem instead of a procedure.* `halfA_agrees` says half A's table
matches half A's formula — which a table matching *everything* would also satisfy, and such a table
would certify anything. The missing half of the pair is now committed, for M06 as well as M07:

```lean
theorem halfA_table_refuses_halfB_cnf : halfATable.agreesWithCNF halfBCnf = false := by decide +kernel
```

It costs 9.5 s including loading two 45 MB table modules, because `agreesWithCNF` is
`(firstFault f).isNone` and `firstFault` stops at the first disagreement. Watched to fail: asserting
`halfATable.agreesWithCNF halfACnf = false` exits 1. **Its error message is unreadable** — a
pretty-printer recursion overflow, the failure mode already tabulated in `Sat/MaskCheck.lean` — so the
remedy stays `#eval t.firstFault f`, and that is why the table of build faults exists.

*Answered: the wrong-CNF bug is an emitter *signature* problem, not a checking problem.* M06's emitter
took a CNF and a pin list and appended the pins — so handing it an already-pinned CNF double-counted
the cube, and the bug surfaced two stages later as a failing size theorem. The statement that catches
it at emission is a property of the input: **a base formula for `coloringCNF` has no unit clauses**
(every clause is an at-least-one of width 4 or an edge clause of width 2; a pin is the only width-1
clause). So the emitter asserts it on read, and — better — only ever accepts the unpinned base, which
makes the wrong input unrepresentable at the tool boundary rather than detected downstream. The Lean
size theorem stays; the emitter check buys a localised failure, never trust.

*Answered: the two witnesses share everything general already, and nothing specific can be shared.*
Each obligation that is *about* a witness is a kernel reduction over a distinct literal — different
tables, different formulas, no common subterm — so no parameterisation can discharge them once.
Everything not about a witness (`justified_of_agreesWithCNF`, `runSegment_sound`,
`valid_of_chunks`, `not_colorable_of_triangle_pinned`) is already proved once and cited. The
duplication is textual, it belongs to the generator, and that is the correct place for it.

## 4. The generated data, and the emitter

| tool | change |
|---|---|
| `tools/heule.py` | **new** — parse Mathematica coordinates into the ℚ(√3,√5,√7,√11) tower, verify every listed edge, re-derive the full unit-distance edge set, emit the same JSON shape as `degrey_cert.json` |
| `tools/shrink.py` | **new** — the deletion search: `core` (which clauses the refutation cited), `probe` (one parallel single-deletion sweep), `strip` (iterate to a fixed point) |
| `tools/emit_geometry.py` | parameterise the input JSON and the output module path |
| `tools/emit_cert.py` | same; drop the halves/cross split, which is de Grey's alone |
| `tools/emit_mask.py` | `PER_MODULE` and `TABLE_MODULES` from the certificate size rather than fixed |

## 5. Negative controls — every check watched to fail

Per the standing rule, each of these is run, seen red, and put back.

| control | must go red |
|---|---|
| move one witness vertex off its coordinate | the geometry check names that edge, and `badEdges` reports it |
| hand the checker a **satisfiable** formula (the graph minus a vertex, still triangle-pinned) | no certificate exists; the refutation cannot be built |
| file the 510 certificate against the 553 formula | `agreesWithCNF` false — the table does not match the CNF |
| pin a triangle that is **not** a triangle (drop one edge from the hypothesis) | `not_colorable_of_triangle_pinned` does not elaborate |
| pin *four* vertices to four distinct colours | must be **unprovable**: a unit-distance graph in the plane has no `K₄`, so there is no such hypothesis to supply — recorded as prose beside the lemma, with the reason |
| `tools/shrink.py` reporting "nothing is deletable" | must be shown to find deletions where they exist — it found **2** on de Grey's half A and **hundreds** on Heule's 874 (§ 5.1) |

### 5.1 The deletion search, run in both directions

A tool whose only output is "found nothing" is a tool nobody should believe. `strip` was run on three
graphs:

| graph | result |
|---|---|
| de Grey half A, 791 vertices, forcing preserved | 2 deletions, then a fixed point at **789** |
| Heule 874 | **0 deletions — vertex-critical** |
| Heule 510, triangle-pinned | **0 deletions — vertex-critical** |
| **the control:** Heule 510 with five pendant vertices bolted on | **exactly those five**, then the same fixed point at 510 |

Three of those four say "nothing to delete", which is precisely the shape of a check that reports
nothing when it cannot run. So the fourth is not optional: five vertices of degree 1 cannot
participate in any colouring obstruction, so a working search must remove all five and no more. It
does. Heule's published graphs each being vertex-critical is then a believable finding rather than a
tool failure — his sequence 874 → … → 510 was not produced by deleting vertices from the previous
graph, so each is minimal in its own right.

That Heule's 510 is vertex-critical is this subplan's own result, independently derived: 510
refutations, none of which succeeded, which is why the milestone stops at 510 rather than pushing
below it.

### 5.2 The encoding, checked against someone else's

Heule's repository publishes the DIMACS file for his 553-vertex graph. Sorted and compared against
what `coloringCNF 4 553 E` produces here, the two are **clause-for-clause identical**. Two
independently written encoders of "this graph has no proper 4-colouring", agreeing exactly — which is
a check on the one component that no theorem in this project can validate, because a wrong encoding
proves a true statement about the wrong formula.

## 6. Measured, do not re-derive

* de Grey's graph is a **fixed point at 1577** under the only decomposition that refutes it, and has
  no monolithic refutation with or without proof logging.
* Heule's published coordinates at 510 and 553 lie in **ℚ(√3,√5,√11)**, are exactly unit-distance on
  every listed edge, and list **every** unit-distance pair among their points.
* **Pinning one triangle is worth 20×** on certificate size and 50× on solve time.
* **Racing triangle × configuration × seed is worth 10.5×** on trimmed hints; `--unsat` wins both.
* Best certificates: **510 → 1,413,841 hints** (triangle `(0,27,28)`, `--unsat`, seed 2);
  **553 → 1,104,106 hints** (triangle `(0,9,10)`, `--unsat`, seed 3).
* Heule's **510 and 874 are both vertex-critical**; the deletion search finds bolted-on pendant
  vertices and nothing else, so those are findings rather than a silent tool failure.
* Our `coloringCNF 4 553 E` is **clause-for-clause Heule's own `553-4.cnf`**.
* Per-hint kernel cost is **1.35 ms at a ~35k-clause table**, 2.93 ms at 317k — the table size, not
  the graph size, is what moved it.

## 7. Unmeasured, ranked by what it would move

1. **Deleting *pairs* rather than single vertices from the 510.** Single deletion is a fixed point;
   pairs are 130k probes at 2 s, about 2.5 hours on this machine. Jaan Parts published **509**, so a
   result below that would be new mathematics and would need the § "standard of evidence above rung
   B" treatment in full. Ranked first because it is cheap and it is the only route here to a number
   nobody has.
2. **Parts' 509 itself.** Not in Heule's repository; not pursued. One vertex.
3. **More seeds.** 160 runs found a 10.5× spread; the top eight are within 10% of each other, so the
   next factor is likely small.
4. **Segment width.** Chosen at ~32 per witness for one-per-core; unswept.

## 8. Fallbacks

* If the triangle normalisation resists, the unpinned certificates already exist — 31.8 M hints for
  the 510, which is M06's cost for a smaller witness. Costs the 20×, not the milestone.
* If a witness's geometry fails in Lean where `tools/heule.py` accepted it, that is a disagreement
  between two independent implementations of the same field arithmetic, and it is a finding about
  M02's tower rather than about the witness. Report it as such.
* There is no fallback in which de Grey's graph shrinks. § 0(a) is complete.
