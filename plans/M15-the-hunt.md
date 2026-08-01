# M15 — The hunt

*Subplanned 2026-08-01, immediately after M14 landed the fan. Rung D: a 6-chromatic unit-distance
graph would be new mathematics, and a reader's default is to disbelieve it. The terminal test is an
honest report, including "not found".*

> **M14 found the property de Grey's construction actually has — a *fan*, a pivot `p` and partners
> `Q` such that every proper 4-colouring paints `p` like at least one member of `Q`.**
>
> **M15 subplanning found what a fan *is*. `Fan G k p Q` for the widest possible `Q` holds exactly
> when deleting `p` leaves a graph that still needs `k` colours. The fan is vertex redundancy.**
>
> **Three consequences, all measured: the search's existence test drops one colour and gets 7.6×
> cheaper; a whole pivot is ruled out in one call instead of one per distance class; and every
> witness this project holds is closed to the route, because shrinking a witness drives it toward
> criticality and criticality is exactly what kills the fan.**

---

## 0. Measurements — taken before anything was specified

Desktop (32 cores, 125 GB), 2026-08-01. `cadical` from the toolchain. Wall clock for solver runs,
single runs unless stated; **CPU seconds, minimum of three runs** for anything the Lean side pays.

### (a) Five colours is cheap to satisfy and brutal to refute

The first five-colour questions this project has asked at witness scale.

| graph | pts | edges | four colours | five colours |
|---|---|---|---|---|
| Heule 510 | 510 | 2504 | **unsat, 58.7 s** | sat, 0.01 s |
| Heule 553 | 553 | 2722 | **unsat, 71.3 s** | sat, 0.02 s |
| de Grey 1581 | 1581 | 7877 | unsat, **> 10 min** | sat, *(pending)* |

Finding a five-colouring of a five-chromatic witness is instant — these graphs are nowhere near
tight at five. **Refuting one is where the whole cost sits**, and that is the only direction the
hunt cares about.

### (b) The widest fan is vertex deletion — an identity, not a heuristic

Join `p` to **every** other vertex. A proper `k`-colouring of that graph is exactly a proper
`k`-colouring of `G` in which `p`'s colour is used by nobody else — which is a proper
`(k−1)`-colouring of `G` with `p` removed, plus one spare colour for `p`. So

> **`Fan G k p (everything except p)` ⟺ `G − p` is not `(k−1)`-colourable.**

and, since `Fan.widen` makes a fan survive enlarging `Q`, the widest fan is the *easiest* one:

> **a fan of any width sits at `p` ⟺ `G − p` is not `(k−1)`-colourable.**

Verified as two independent computations — join-and-refute versus delete-and-colour — on Heule's
510-point witness at **both** colour counts, six pivots each:

| k | pivot | widest fan at `p` | `G − p` is `(k−1)`-colourable | |
|---|---|---|---|---|
| 4 | 0, 1, 7, 100, 300, 509 | fan (0.01 s) | no (0.01 s) | agree, 6/6 |
| 5 | 0, 1, 7, 100, 300, 509 | separated (0.03–0.16 s) | yes (0.02–0.15 s) | agree, 6/6 |

Twelve instances, two formulas, never a disagreement.

### (c) The identity is worth 7.6× on the only question that costs anything

The two formulas ask the same question at **different colour counts**, and the cheaper one is the
one the identity supplies:

| does a five-colour fan sit at a new apex over… | as a fan (5 colours) | as a deletion (4 colours) | |
|---|---|---|---|
| Heule 510 | 511 pts, 3014 edges, **447.7 s** | 510 pts, 2504 edges, **58.7 s** | **7.6×** |
| Heule 553 | 554 pts, 3275 edges, **483.7 s** | 553 pts, 2722 edges, **71.3 s** | **6.8×** |

And it is the expensive case by construction: the fan test is only slow when the answer is *yes*,
because a narrow join leaves the graph easily colourable and cadical says so instantly.

### (d) As a search filter it is one-sided, cheap, and worth running first

One `(k−1)`-colour call per pivot rules out **every** distance class at that pivot at once.

| configuration | pts | pivots surviving the filter | filter cost | what M14's sweep would have cost |
|---|---|---|---|---|
| de Grey's seed `S` | 39 | **0 of 39** | 39 calls, **0.15 s** | 70 four-colour calls |
| `orbit(S, hex₁₂)` | 397 | **397 of 397** | 397 calls, **6.16 s** | 2878 four-colour calls ≈ 960 s |

So the filter **rejects and never guides**: it settles the seed — which M14 measured has no
disjunctive property at all — in a seventh of a second, and it prunes nothing at all on the one
configuration that carries the fan. It costs 0.6% of the sweep it can save entirely, so it runs
first unconditionally.

*(This is the same one-sidedness M14 recorded for symmetry: it can promote a candidate and can never
reject one. Here it is the other way round.)*

### (e) The certified negative is affordable: 0.42 CPU s per colouring

A pivot with no fan is certified by **exhibiting a `(k−1)`-colouring of `G − p`** — no SAT
certificate, no solver, one function the kernel checks against the edge list. Marginal cost measured
on Heule's 510-point graph, colours packed two bits per vertex into one `Nat`, minimum of three runs
on the desktop:

| colourings in the module | CPU s | marginal |
|---|---|---|
| 1 | 3.53 | — |
| 8 | 6.40 | 0.41 s each |
| 32 | 17.04 | 0.44 s each |

**≈ 0.42 CPU s per 510-vertex colouring over 2504 edges**, so certifying that *every* vertex of a
witness is redundant costs:

| witness | colourings | projected |
|---|---|---|
| Heule 510 | 510 | **≈ 3.6 min** |
| Heule 553 | 553 | ≈ 4.2 min |
| de Grey 1581 | 1581 | **≈ 35 min** |

Under an hour of processor time for all three, against M06's 27.8 hours for one refutation. **The
honest negative is three orders of magnitude cheaper than the positive it replaces**, which is what
makes "searched X, found nothing" statable as a theorem rather than asserted from Python.

### (f) Neither Heule witness has a removable vertex at all

Every one of its 510 vertices swept, no sampling:

| witness | pts | removable vertices | unsettled | time | worst single call |
|---|---|---|---|---|---|
| Heule 510 | 510 | **0** | 0 | 114.1 s | 7.16 s |
| Heule 553 | 553 | **0** | 0 | 124.0 s | 2.85 s |

**Zero, both of them.** Each graph is five-vertex-critical at every vertex, so by § (b) **no
five-colour fan sits anywhere in either, at any pivot, at any width** — the de Grey route has no
place to start. This is not
bad luck: M07 *produced* this graph by a shrinking search, and shrinking is the search for removable
vertices. The milestone that made the certificate affordable is the milestone that closed the route.

### (g) *(pending)* de Grey's own 1581-point graph

M07 measured that his graph shrinks 1581 → 1577 and stops, so some vertices there *are* removable —
and by § (b) a removable vertex is exactly a five-colour fan. Sweep running.

The sweep's own cost is the honest statement of what rung D asks: at a *removable* pivot the fan
test is a four-colour refutation of a 1580-point graph, and **cadical has not refuted de Grey's
1581 at four colours directly in an hour** — which is why M06 used his two-copy decomposition rather
than the whole graph. So a confirmed fan in de Grey's graph costs what the χ ≥ 5 proof costs. A
rejected pivot costs a second.

---

## 1. What M14 left (carried forward unchanged)

* The fan is the seed-quality score, and it discriminates perfectly: **no fan at all** in any of the
  33 configurations M13 searched, **width 3** in `orbit(S, hex₁₂)`.
* **`Fan.mono` is the only monotone guarantee** — a fan survives adding edges. There is no cheaper
  per-pivot proxy.
* **Spindling does not narrow the fan at its own pivot**; the narrower fan appears elsewhere, so a
  search must re-scan pivots after every move.
* **The closing move needs width 1**, or width 2 in exactly one geometry (partners diametrically
  opposite the pivot at `r² = 1/2`, closed by a quarter turn). Width ≥ 3 is impossible — two unit
  circles meet twice. **This analysis is pure geometry and carries to five colours unchanged.**
* Refutation cost is not monotone in graph size (M07), and at five colours instances of the same
  size varied by two orders of magnitude (M12).
* Nothing here forces any port property at five colours (M11): a five-colour gadget catalogue must
  be constructed, not harvested.

---

## 2. The shape — Lean

**`Proofs/HadwigerNelson/Critical.lean`** — the identity and the certificate. Skeleton elaborates
green with 15 sorried leaves.

`SimpleGraph.deleteIncidenceSet` is **Mathlib's**, found by grepping the source rather than written
here: it deletes the edges at `p` and keeps `p` in the vertex type as an isolated point, which is
exactly the model wanted — an induced subgraph on a subtype would make every statement a transport
instead of an inclusion.

| statement | what it is |
|---|---|
| `not_fan_of_colorable_delete` | one colouring of `G` minus `p`'s edges kills every fan at `p`, **any width** |
| `not_forces_of_colorable_delete` | the same for M13's forced pair — one call instead of `n − 1` |
| `fan_univ_of_not_colorable_delete` | the converse: a removable vertex carries the widest fan |
| `fan_univ_iff` | the identity |
| `not_fan_of_vertex_critical` | a graph with no removable vertex has no fan anywhere |

The two directions are not equally useful and the asymmetry is deliberate. The **negative** needs no
side condition and its evidence is one explicit colouring; the **positive** needs `0 < k`, because
at `k = 0` on a one-point graph the hypothesis holds and the conclusion `Fan G 1 p []` is false.

### The certificate: one packed `Nat` per colouring

```
unpackColor bits k c v      = (c >>> (bits * v)) % 2 ^ bits % k
properOffPivot E bits k c p = every edge of E not incident to p is bichromatic under that
everyVertexCritical E bits k cs = cs.length = n, and row p certifies pivot p
```

Two moduli and both are load-bearing: `% 2 ^ bits` **extracts** the field (a shift alone leaves
every higher vertex's colour above it), `% k` **bounds** it — and the second cannot be dropped in
favour of the first, because the colour count rung D asks about is **five**, which is not a power of
two, so a three-bit field admits 5, 6 and 7. Because the composition is total, **soundness never
depends on the pack being faithful**: a mis-packed number yields a different valid colour, and the
properness check either passes — in which case the clamped function really is a proper colouring and
the theorem is true anyway — or fails. That is M05's rule, that the certificate's packing is
untrusted as a matter of type.

Validated by `#eval` before any proof effort: `unpackColor 2 2 16` over the rhombus's four vertices
is `[0, 0, 1, 0]`, the check passes at pivot 1 and fails at all three others, and a five-colour
three-bit field packed with `[5, 6, 7, 2]` clamps to `[0, 1, 2, 2]`.

**Per-witness modules** carrying the emitted colourings, at the cost measured in § 0(e):

| module | rows | projected |
|---|---|---|
| `Instances/Heule510/Critical.lean` | 510 | ≈ 3.6 min |
| `Instances/Heule553/Critical.lean` | 553 | ≈ 4.2 min |
| `Instances/DeGrey/Critical.lean` | 1581, **if the graph is critical at all** | ≈ 35 min |

## 3.0 The domain pass — what it changed

Run against the skeleton at commit `d3b39dc`. Five findings, four of which moved a declaration, and
two of which were settled by running the toolchain rather than by reasoning about it.

### The `k + 1` offset is free, and that was measured, not assumed

Every statement trades one colour for the deletion: `Fan G (k+1) p Q` against `Colorable k`. The
worry was that a caller holding `Fan G 5 p Q` must see `5` as `4 + 1`, and that unification would
balk. **It does not.** Three probes elaborated with no error, including the one that matters — the
packed certificate produces `Colorable 4`, and the theorem is stated at the literal `5`:

```lean
example … (h : everyVertexCritical E 2 4 cs = true) … : ¬ Fan (edgeGraph n E) 5 p Q :=
  no_fan_of_packed (by norm_num) h hp        -- elaborates
```

So the three alternatives are all worse and none is needed: `Colorable (k − 1)` would import
truncated subtraction, which this project treats as a modelling failure; a linking hypothesis
`j + 1 = k` would appear in every signature to buy nothing; inverting the primitive would put the
offset on the *fan* side, where callers live.

### The correspondence is instance-free, and the skeleton had hidden that

The skeleton stated the converse as `Fan G (k+1) p (Finset.univ.erase p).toList`, dragging
`[Fintype V]` and `[DecidableEq V]` into the identity. The content needs neither. Split into the two
halves of one correspondence — **the spare colour and the deleted vertex are the same thing** —
each over an arbitrary vertex type:

| | |
|---|---|
| `exists_isolating_of_colorable_delete` | a `k`-colouring of `G − p`, plus a spare colour for `p` |
| `colorable_delete_of_exists_isolating` | drop `p`'s private colour and the rest is a `k`-colouring |

The gain is not tidiness. **`0 < k` now sits on the compression alone**, where the demand really is
— at `k = 0` on a one-point graph the compression's hypothesis holds vacuously and its conclusion
demands an empty vertex type — so the *workhorse*, the negative the hunt calls constantly, carries
no side condition at all. On the skeleton's shape it inherited one it never used.

`Fintype` and `DecidableEq` survive on `fan_univ_iff` and nowhere else, and there they are
intrinsic: "the widest `Q`" is a list of everything, and everything is only listable when there is
finitely much of it.

### Every fan-facing statement is now one line

Confirmed by elaborating them before adopting the shape. `not_fan_of_colorable_delete`,
`not_forces_of_colorable_delete` and `not_fan_of_vertex_critical` are two, two and one lines over
the correspondence — which is the evidence that the pair above is the right pair, rather than an
opinion about it. M13's forced pair is reached as the width-one reading, not re-proved.

### Two names deliberately not minted, and one lemma deliberately not written

* **The vertex property.** `(G.deleteIncidenceSet p).Colorable k` appears seven times and stays
  spelled out. Mathlib has **no** vertex-criticality notion to reuse — grepped, not recalled — so a
  name would be minted here, and "critical" is a word graph theory applies to a *graph*, never to a
  vertex: `Critical G k p` would read as a term of art that is not one. The composite already says
  what it means in vocabulary every Mathlib reader holds.
* **The isolating colouring.** `∀ q, q ≠ p → C p ≠ C q` appears three times, is six tokens, and its
  only consumers are the two theorems that mention it. A predicate with no API is a layer.
* **Transport down along subgraphs.** `deleteIncidenceSet` is monotone (three lines) and
  `SimpleGraph.Colorable.mono_left` **already exists in Mathlib** — a fourth claim of absence
  avoided by grepping. But the next-lemma test says do not write it: the hunt builds candidates by
  *growing*, so a negative on a big graph covering its subgraphs is a lemma nothing asks for.

### The clamp is a decoder, not a junk value

`unpackColor`'s two moduli do different jobs, and only one is load-bearing. `% 2 ^ bits` **decodes**
— a shift alone leaves every higher vertex's colour above the field. `% k` **bounds**, and it is the
only one soundness rests on: whatever `bits` says, the result lands in `Fin k`. So `bits` is a
*tuning* parameter and every theorem holds for every value of it. That is M05's rule — soundness
proved for every decoder, the packing untrusted as a matter of type — and it is not junk-value
totality, because nothing downstream believes the pack was faithful. It is also what makes the
`k = 5` case work at all: five is not a power of two, and a three-bit field admits 5, 6 and 7.

### The list stays a list

`everyVertexCritical` keeps `cs : List ℕ` with a length conjunct rather than `Vector ℕ n`, for a
measured reason: an `Array` literal is built by a chain of applications, so the kernel pays O(its
whole size) per access (M04's finding), whereas `zipIdx` and `all` walk a literal `List` once. The
length check is what the `Vector` would have carried, and it belongs in the `Bool` anyway — the data
arrives from an untrusted emitter and must be checked rather than believed.

### Seams walked

`Q = []` reads as "`G` itself is `(k+1)`-colourable", true and non-vacuous. `p ∈ Q` makes the fan
trivially true and is excluded by `hp`, which is therefore load-bearing. `bits = 0` collapses every
vertex to colour 0, so the check passes only for stars — sound. `n = 0` is vacuous. `E = []` passes
trivially and its conclusion is true. No adversarial member found: `properOffPivot` passing *is*
`k`-colourability of the deleted graph, with no gap between them.

## 3.0.1 The obligation pass — what it changed

Run against the skeleton at commit `2e3205f`. **The module is now proved: zero `sorry`, zero
errors.** Six findings.

### Both predicted traps were already solved in the libraries

The pass opened by naming two obligations it expected to be hard, and both dissolved on a grep:

* **Renumbering `Fin (k+1)` minus a point into `Fin k`** looked like `if c < C p then c else c - 1`
  — truncated subtraction on a value known to be nonzero, the junk-value shape this project treats
  as a modelling failure. **`Mathlib.Logic.Equiv.Fin.Basic` has `finSuccEquiv' (i : Fin (n+1)) :
  Fin (n+1) ≃ Option (Fin n)`**, which removes a designated point and reports the removal as
  `none`. The compression is nine lines with no arithmetic in it at all.
* **Getting from a `zipIdx`-indexed `List.all` to `∀ p : Fin n`** was budgeted as "the one genuine
  induction in the module". **It is not an induction.** Core has
  `List.mk_mem_zipIdx_iff_getElem? : (x, i) ∈ zipIdx l ↔ l[i]? = some x`, and the whole theorem is
  five lines.

That is the **fifth and sixth** claims of absence this project has made and had refuted by grepping
the toolchain source. The rule earns its place again.

### One lemma minted: deleting a vertex is filtering the list

Every negative claim about a deleted graph was stranded outside the `not_colorable_edgeGraph_iff`
route that `decide +kernel` already travels. `delete_edgeGraph` bridges it:

```lean
(edgeGraph n E).deleteIncidenceSet p = edgeGraph n (E.filter fun e => e.1 != p && e.2 != p)
```

Three spec examples close by `rw [delete_edgeGraph, not_colorable_edgeGraph_iff]; decide +kernel`,
and both edge orientations are handled — the seam M14 was bitten by.

### The mutation audit found a check that could not fail

Seven mutations, run rather than planned. Five went red immediately. Two came back **green**, and
they were different problems:

| mutation | first result | what it was |
|---|---|---|
| drop `hp : p ∉ Q` | red (10 errors) | load-bearing |
| drop the length conjunct | red | load-bearing |
| drop `% k` from `unpackColor` | red | load-bearing |
| handle one edge orientation only | red | load-bearing |
| drop the pivot guard from `properOffPivot` | red (3) | load-bearing |
| drop `hk : 0 < k` | **green** | **the mutation was miswritten** — it left `hk` in place as an `autoParam` |
| drop `% 2 ^ bits` | **green** | **a real gap** — nothing in the module could tell |

The second is the finding. The domain pass had already argued that `% 2 ^ bits` is a decoder choice
rather than a soundness obligation, and that is true — but it means the *spec examples* were the
only thing that could catch a wrong decode, and at two colours on the rhombus the leaked high bits
happen not to change any answer. **The check could not fail.** Fixed by adding the one example that
discriminates: at three colours in two-bit fields, vertex 0 of `16` decodes to `16 % 4 = 0`, where a
reader that only reduced modulo `k` would report `16 % 3 = 1`. Both mutations now go red.

The `0 < k` side condition is likewise no longer argued but **exhibited**: the one-point graph with
no edges satisfies the compression's hypothesis vacuously at `k = 0` and refutes its conclusion, and
both halves are committed as examples.

### The certificate must be chunked, and the width is measured

One `decide +kernel` over all 510 rows **peaks at 41.7 GB**, with the edge list stored as a literal
*and* as the committed chunked one — so the cost is the run length and nothing else. Measured
scaling on the desktop:

| rows in one `decide +kernel` | peak RSS | CPU |
|---|---|---|
| 32 | 5.25 GB | 22.1 s |
| 64 | 7.77 GB | 43.7 s |
| 128 | 12.79 GB | 87.1 s |
| 510 | 41.7 GB | ~142 s |

Time is **linear at 0.68 s per row**; memory is **linear at ≈ 79 MB per row over a 2.7 GB floor**,
which is ≈ 31 KB per row per edge. So the chunk width follows the edge count, and it is not the same
for the three witnesses:

| witness | edges | MB per row | rows per chunk | peak | chunks |
|---|---|---|---|---|---|
| Heule 510 | 2504 | 79 | **64** | 7.8 GB | 8 |
| Heule 553 | 2722 | 86 | **64** | 8.2 GB | 9 |
| de Grey 1581 | 7877 | 249 | **24** | 8.7 GB | 66 |

`criticalFrom_append` is the lemma that lets the chunks add up — a run of rows splits wherever the
list does, with the offset carried. It exists because of that 41.7 GB, not for tidiness.

### The obligations outside Lean

* **The emitter refuses rather than pads**, and both refusals were **watched**. Forcing every pivot
  unsettled (a 1 ms timeout) prints the count, names the pivots, says "nothing written", exits 1, and
  writes no file. Bolting a pendant vertex onto Heule's 510 — which makes that vertex removable —
  is refused the same way and names vertex 510 as the one carrying a five-colour fan.
* **My own control was miswritten, again by a pipeline.** The removable-vertex control read `exit=0`
  because `head -4` supplied the status, not the emitter. Re-run without the pipe: exit 1. Third
  time this project has been bitten by a shell pipeline swallowing the status a check depends on.
* **Agreement with Lean's edge list is by construction, not by cross-check.** Lean checks the rows
  against *its own* committed edge list, so a wrong vertex numbering in the tool cannot pass — it
  would leave some edge monochromatic and `properOffPivot` would refuse it. That is stronger than
  M14's fan-tool agreement, which needed both sides to build the same joined list.

### PROVE / TEST / ASSUME

* **Prove** — the correspondence (2 theorems), the fan-facing corollaries (4), the delete/filter
  bridge (1), the certificate chain (3), the chunk law (1).
* **Test** — 13 examples, of which 6 are countermodels, plus the decode discriminator and the
  `0 < k` countermodel. The fan in `triangleAndPoint` is established by **M14's oracle** and its
  removability by **this module**, so the identity's two sides share no lemma.
* **Assume** — `p ∉ Q` and `0 < k`, both discharged by the caller at every call site in the module;
  the emitted rows are **checked, never assumed**.

## 3. The shape — tools

* **`tools/forcer.py` gains `removable(n, edges, p, k)`** — the identity as a filter, three outcomes,
  `UNKNOWN` never folded. `best_fan` runs it first per pivot: it costs 0.6% of the sweep and can
  save all of it (§ 0(d)).
* **`tools/emit_critical.py`** — the packed colourings, one row per vertex, emitted only when the
  sweep settled every pivot. A row that did not settle is a refusal to emit, not a gap in the file.
* **`tools/hunt.py` gains the five-colour hunt**, driven by the filter rather than by fan calls.
* Controls in the shared table shape M14 adopted: one graph source, data rows, expected outcomes —
  because two of M14's own controls were miswritten and both read as tool bugs.

## 4. Scope

**In.** The identity and its certificate in Lean (§ 2). The per-witness certified negatives, for
every witness the sweep settles. The filter and the emitter in the tool (§ 3). The hunt, run, and
reported honestly either way.

**Out.** A five-colour gadget catalogue. M11 measured that one cannot be harvested from the
literature and M12 did not construct one; § 0 now says why it is the bottleneck rather than an
accessory, and building it is a milestone, not a corner of this one.

## 5. Honest risks

* **This milestone is expected to report "not found".** No 6-chromatic unit-distance graph is known;
  the ratchet says so, and the terminal test is an honest report. What is *not* expected to fail is
  the structural half: the identity is proved, and the certified negatives are measured affordable.
* **The certified negative is only as broad as the sweep.** It says "no fan in *this* graph", not
  "no fan in the plane". The write-up must not let the second read out of the first.
* **A confirmed fan costs what the χ ≥ 5 proof costs** (§ 0(g)), so the hunt's budget is spent almost
  entirely on its near-misses; its rejections are free.
* **Refutation cost is not monotone in graph size** (M07), and at five colours instances of the same
  size varied by two orders of magnitude (M12). Carried forward; still true.
* **Symmetry carries no colouring information.** It can promote a candidate and can never reject one.
  Carried forward. The identity is the mirror image: it can reject and can never promote.
