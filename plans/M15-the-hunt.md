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

### (f) Heule's 510-point witness has no removable vertex at all

Every one of its 510 vertices swept, no sampling:

| witness | pts | removable vertices | unsettled | time | worst single call |
|---|---|---|---|---|---|
| Heule 510 | 510 | **0** | 0 | 114.1 s | 7.16 s |

**Zero.** The graph is five-vertex-critical everywhere, so by § (b) **no five-colour fan sits
anywhere in it, at any pivot, at any width** — the de Grey route has no place to start. This is not
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
