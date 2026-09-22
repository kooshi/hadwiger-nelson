# FS-70 phase 1f — what deciding the last live lattice would cost

*Implementer: Opus 5. Machine: the desktop (16 physical cores / 32 threads, 125 GB),
otherwise idle; the peak was **13 concurrent single-threaded solvers on 16 physical cores** (the sample's 6,
the symmetry run's 1, and arm 1f's 6 for 38 seconds), so every solver always had a physical core and no verdict
here is a contention artefact — the one place it could matter, arm 1f's 1.74 s mean, is a measurement of a
memory-bandwidth-shared machine and is stated as such. Solver: `kissat` 4.0.4 throughout. **This phase decides nothing.** Every solver run below
is on one formula — the `k = 4` control of `group:u3:2+w4` — or on a sub-ball of it, and the big formula's body
reproduces byte for byte the CNF of the four attempts that came before it: the sha256 of the correct header
plus the body is `89eadac453b93924617724fa2ceec48646048ad26cc1947b7a3635f48299e9b8`, the `cnf_sha256` carried by
phase 1b's and phase 1e's rows in `data/fs70/asks.jsonl`. So every comparison below differs from those four in
exactly one thing.*

---

## 1. Headline

**The cube pass has no operating point, and the margin is fifteen orders of magnitude. What replaces it is
named and its first stage is 25× cheaper — but its total cost turns on one number this phase could not
measure, and says so.**

1. **The branching-set repair the brief asked for works.** The origin's neighbourhood in this ball is **84
   vertices forming fourteen disjoint hexagonal wheels**, and branching on whole wheels cuts the tree hard:
   **726 cubes from 10 vertices**, where phase 1b's degree-ranked set gave 65,536 from 8. Exact counts
   `11 × 66^h`; confirmed independently by a random-descent estimator that reproduces the exact depth-22 count
   to within one standard error (§2).
2. **Deep cubes decide; affordable cubes do not; the two depths are 10²¹ cubes apart.** Sixteen cubes at each
   of depths 10, 16 and 22 (726 / 47,916 / 3,162,456 cubes) are **all 48 UNKNOWN at 600 s**. Two cubes at
   each of depths 40 and 58 are UNKNOWN at 600 s. **At depth 82 — the origin's entire first shell fixed — both
   probes are UNSAT, in 43 s and 93 s**, and three cubes fixing the whole radius-2 ball are UNSAT in 7.3–8.0 s.
   The crossover sits between depth 58 (2.6 × 10¹⁷ cubes) and depth 82 (5.0 × 10²⁴ cubes): **the shallowest
   branching whose cubes decide costs 9.4 × 10²² core-hours, and the deepest branching whose cubes a machine
   could enumerate decides nothing** (§3, §4).
3. **And the deep refutations are LOCAL, which is the finding.** A depth-82 cube is **SAT on the radius-2 ball
   and UNSAT on the 95,389-vertex radius-3 ball**, in 2.1 s and 8.3 s — the full 1.89 M-point ball is never
   needed. So **120 random first-shell colourings were tested against the radius-3 ball alone: 120 of 120
   refuted, at 1.74 s each**, with a positive control confirming that a genuine surviving colouring exists, lies
   in the generator's image, and reads SAT in 3.20 s (§4.3). **The first shell is almost entirely killed by a
   graph that solves in seconds.** That names the instrument this lattice actually wants — enumerate the
   first-shell colourings that survive radius 3, and ask only those — in place of a blind cube pass. **Its cost
   is not established**: enumerating the survivors directly produced 269 in 666 s with no exhaustion, which
   bounds their number from below and not at all from above (§4.5). A projected model counter, not a longer
   finder, is what would settle it.
4. **The symmetry break cannot move anything, and that is a derivation rather than a measurement.** The ball's
   automorphism group is exactly the brief's **96** (`ζ₁₂`, conjugation, the two Galois flips; all eight maps
   verified edge-preserving, not merely point-permuting). But **the existing triangle pin already leaves only
   an order-8 residual**, which is the hard ceiling on what any break can buy on this formula. Encoded as
   307,740 lex-leader clauses with a three-part control — 1 of 8 orbit members survives, the encoding is
   verified on a real model, and the `strict` plant fires UNSAT — the run is **UNKNOWN at 1,800 s**, exactly as the ceiling predicts (§5).
5. **The `k = 5` ball is 29,082,973 points at mean degree 19.2, and phase 1e's reading of the degree was
   wrong.** Exact, not estimated. Phase 1e's §6.3 says "the word ball is the only affordable shape and **its
   degree stops at 15.4**"; the family reads **11.53 → 15.40 → 19.23** at `k = 3, 4, 5`, so `k = 5` is above
   G65's degree-14 threshold where "almost everything decides in seconds". What stops is the size, not the
   degree (§6).
6. **A shape 2.6× smaller at the same degree exists, and nobody had looked for it.** Taking the **132** unit
   vectors of word-length ≤ 5 as the generator set instead of the 84 of word-length 1, the radius-4 ball is
   **11,091,217 points at mean degree 18.72** against the `k = 5` ball's 29,082,973 at 19.23 (§6.6).
7. **The ball's degree distribution is bimodal, not tight.** Shells 0–3 have mean degree **84.7**; shell 4 —
   94.9 % of the ball — has **11.7**. The 13-core is empty because peeling a thin outer shell cascades inward,
   not because the ball has no dense part (§6.2). The core profile, recomputed by an independent
   implementation, reproduces phase 1e's committed table to the integer.

---

## 1a. The object, verified exactly — a control the phase owed and had not run

Every number here is about `build/fs70/L3-w4/graph.json`. Before pricing it, it was checked to *be* what it
claims: a unit-distance graph. With a point as `(x, y)`, `x = (a + b√3 + c√5 + d√15)/72` and `z = x + iy`, the
condition `|z|² = 1` expands in the basis `(1, √3, √5, √15)` into **four integer identities** with the
denominator cleared, so the check is exact and uses no floats:

`a² + 3b² + 5c² + 15d² + e² + 3f² + 5g² + 15h² = 5184`, `ab + 5cd + ef + 5gh = 0`,
`ac + 3bd + eg + 3fh = 0`, `ad + bc + eh + fg = 0`.

| | |
|---|---|
| edges checked | **14,523,840 — all of them** |
| edges failing the identity | **0** |
| planted control (one coordinate of one endpoint moved by 1, on 5 edges) | **5 of 5 now fail — FIRED** |

**What it rules out, stated exactly** (`CLAUDE.md`'s measured/derived rule, which cuts the other way from how
it first reads here): the check confirms that every *listed* edge is a unit edge, so it rules out an **invented**
edge — and an invented edge is what would inflate the degrees, the core numbers and the wheel structure of §2
and §6. It does **not** rule out a **missing** edge, which is this construction's own risk, since the edges were
enumerated geometrically. A missing edge makes colouring easier: it cannot manufacture an UNKNOWN or an UNSAT,
but it would mean the true degrees in §6 are higher than reported and the true `k = 5` ball denser. Every
degree figure in this record is therefore a lower bound on both counts.

---

## Theorems this phase proved

**None.** This is a pricing exercise: every number is a measurement of an instrument or an exact count of a
finite object, and nothing here is a statement about the chromatic number of any lattice. Two facts are
derivations rather than measurements, and neither is a theorem about the mathematics:

* the residual symmetry of a triangle-pinned instance is the setwise stabiliser of its two non-origin pinned
  vertices (§5.2) — elementary, and it is why the break's ceiling is 8;
* the propagation-pruned cube decomposition is sound (§2.2) — the standard unit-propagation argument.

`plans/FS70-derivation.md` gains no row.

---

## 2. Arm 1a — the branching set: the repair works, and the wheels are independent

Phase 1b priced the cube pass at **65,536 cubes** from 8 branching vertices and said the repair was to *branch
on a clique or a tight neighbourhood*, because the eight highest-degree vertices of a lattice ball are mutually
non-adjacent and the enumerator — which prunes only by edges *inside* the branching set — therefore prunes
nothing. Nobody had done it.

### 2.1 Fourteen hexagonal wheels, not two

`N(0)` is **84 vertices forming fourteen disjoint 6-cycles** — measured, and the tool asserts it rather than
assuming it. `N(0)` is 2-regular with no triangle in it, which it must be: a triangle inside a neighbourhood is
a `K4`, and four points of the plane are never pairwise at unit distance (row 58). So each 6-cycle plus the
origin is a hexagonal wheel — the densest structure a unit-distance graph admits — and there are fourteen,
not the two the brief expected from `ζ₁₂`. The pinned triangle `[0, 25, 27]` sits inside one of them
(`[25, 35, 33, 31, 29, 27]`), so that wheel has two of its six rim vertices already coloured.

### 2.2 The cube counts

A cube is enumerated by depth-first search over the branching set with **unit propagation through the entire
71-million-clause formula** after every assignment, not merely by the edges inside the set. The decomposition
is sound: propagation derives only implied literals, so a pruned branch is one the formula itself refutes, and a
level whose vertex propagation has already forced carries no other colour; the leaves cover every proper
colouring, and the instance is UNSAT iff every leaf's cube is.

| depth | branching set | cubes | `4^depth` | reduction | DFS nodes | branches propagation refuted | levels propagation forced | time |
|---|---|---|---|---|---|---|---|---|
| 4 | the pinned wheel's 4 free rim vertices | **11** | 256 | 23× | 20 | 0 | 5 | 0.0 s |
| 10 | + one whole wheel | **726** | 1,048,576 | 1,444× | 1,439 | 0 | 335 | 0.0 s |
| 16 | + two whole wheels | **47,916** | 4,294,967,296 | 89,635× | 95,093 | 0 | 22,115 | 2.1 s |
| 22 | + three whole wheels | **3,162,456** | 17,592,186,044,416 | 5,563,000× | 6,276,257 | 0 | 1,459,595 | 145.3 s |

**Against phase 1b's 65,536 cubes from 8 vertices, 10 vertices now give 726.** The repair is real and cheap.

### 2.3 But propagation never leaves the wheel — at any depth

The counts are exactly `11 × 66^h` for `h` whole extra wheels, `66` being the number of proper 3-colourings of
a 6-cycle, which is what a rim vertex has left once the hub takes colour 0. **The wheels are completely
independent.** Measured three ways:

* after the three pins, 254 domains are touched and 3 vertices forced; after a whole wheel is assigned, 589
  domains are touched and **exactly the 7 assigned vertices are forced**, none beyond;
* the column `branches propagation refuted` is **0 at every depth** — a conflict is never reached, because
  within a wheel the last rim vertex is forced before it can conflict;
* **and it still holds at depth 82**, where all fourteen wheels are fixed. A Knuth random-descent estimator
  (400 probes, the arithmetic mean unbiased for the leaf count) reads:

| depth | Knuth estimate | standard error | probes that died | `11 × 66^h` |
|---|---|---|---|---|
| 22 | 3.189 × 10⁶ | 1.3 × 10⁵ | **0** / 400 | 3,162,456 *(exact — the estimator's own control, and it agrees within 1 SE)* |
| 40 | 9.136 × 10¹¹ | 5 × 10¹⁰ | **0** / 400 | 9.092 × 10¹¹ |
| 58 | 2.842 × 10¹⁷ | 2.6 × 10¹⁶ | **0** / 400 | 2.614 × 10¹⁷ |
| 82 | 4.25 × 10²⁴ | 3.4 × 10²³ | **0** / 400 | 4.96 × 10²⁴ |

*The depth-82 estimate sits 2.1 standard errors below the formula. Knuth's estimator is heavy-tailed — a few
probes carry most of the mass — so its arithmetic mean approaches the truth from below on a budget of 400, and
the agreement should be read as "the same order of magnitude", which is all the pricing needs. What is exact
and needs no reading is the column of zeros.*

So on this ball **unit propagation through the whole formula is worth exactly the edges inside the branching
set plus the hub, at every depth**, and phase 1b's enumerator was not the weak part — its branching *set* was.
*(I had assumed the opposite when the ladder came back: see §7.)*

---

## 3. Arm 1b — the sample at the affordable depths

*Every row: the same 71,302,690-clause, 7,547,044-variable formula plus the cube's unit clauses, piped into a
fresh `kissat -q -n --time=600`. Cubes drawn uniformly at random from the enumerated set (seed 20260922), 16 at
each of three depths, 6 workers. The brief asked for 48 cubes at one depth; they were spent at three instead,
because a pricing exercise needs the derivative — whether depth buys anything — and one depth cannot show it.*

| depth | branching set | cubes in a full pass | sampled | decided | at the wall | mean kissat s | max kissat s | RSS range |
|---|---|---|---|---|---|---|---|---|
| 10 | the pinned wheel + 1 whole wheel | 726 | 16 | **0** (UNKNOWN: 16) | 16/16 | 602.9 | 611.8 | 3.91–5.16 GB |
| 16 | + 2 whole wheels | 47,916 | 16 | **0** (UNKNOWN: 16) | 16/16 | 601.9 | 607.0 | 4.03–5.11 GB |
| 22 | + 3 whole wheels | 3,162,456 | 16 | **0** (UNKNOWN: 16) | 16/16 | 602.1 | 607.9 | 4.92–5.27 GB |

**48 of 48 cubes are UNKNOWN at 600 s — the decided fraction is 0 at every depth, so the sample yields no mean time of decided cubes and no finite extrapolation.** Deeper branching inside the range the brief named buys nothing: 16 cubes with 22 vertices fixed behave exactly like 16 cubes with 10 fixed. The fraction at the wall is 1.00, 1.00, 1.00.

**Verification that an UNKNOWN is a solver timeout and not a parse failure:** every row records `kissat`'s exit
status, and every one is **0** — ran to the `--time` limit with no verdict. A malformed header exits **1**,
confirmed by feeding kissat a deliberately wrong clause count. Every row also spent its full budget
(600.04–611.79 s of kissat time).

### 3.1 The engine: a piped subprocess is 2.7–5.4× lighter than phase 1b's in-process cube engine

The brief asked whether a subprocess `kissat` on a per-cube CNF is lighter than phase 1b's in-process CaDiCaL,
and by how much. It is, and the shape that makes it cheap is not the one the brief described:

*Measured on ONE worker first, as the brief asked, before six were launched: a single `kissat` on the piped
formula peaks at **1.91 GB** after parsing and **3.95 GB** after 60 s of search, so six workers were safely
within the machine (peak observed across the whole phase: 5.16 GB, six workers, 31 GB of 125).*

| | phase 1b, in-process (`pysat:cadical195`) | this phase, piped subprocess |
|---|---|---|
| RSS per worker | **14.0 GB** (5.9 GB of it the Python side) | **1.9 GB at parse, 2.6–5.2 GB in search** across 57 measured runs |
| per-cube budget | **none** — PySAT's CaDiCaL has no `solve_limited` | `--time=600`, honoured to the centisecond |
| per-cube I/O | none | the 1.4 GB body is **never copied**: `{ printf header; cat body units; } \| kissat` |
| parse cost per cube | 54 s of Python clause ingest, once per worker | **6.06 s**, once per cube (measured) |
| safe worker count on 125 GB | 4 ("not a pass, a wall") | **16+** |

Writing a per-cube CNF file — what `fs70_ask.py`'s file engine does, and what its `CUBE_FILE_CLAUSE_CAP` of
4 M clauses exists to prevent — would be 1.4 GB per cube. Piping the body instead costs 6.06 s of parse, **1 %
of a 600 s budget**, and no disk at all. That removes phase 1b's memory objection entirely; it does not remove
the objection in §4.

---

## 4. Arm 1c — the hardness ladder, and where the refutation actually lives

The sample prices depths a real pass could afford. This asks the other question: **is there any depth at which
a cube decides?** These probes are not passes — their cube counts are astronomical — and they are one-sided: a
SAT verdict would decide the whole instance (the fabric four-colours), while UNSAT or UNKNOWN says only that
this one cube was refuted or was still hard.

### 4.1 The ladder

| depth | what is fixed | cubes in a full pass | probes | verdict at 600 s |
|---|---|---|---|---|
| 40 | 40 of the origin's 84 neighbours | 9.09 × 10¹¹ | 2 | **UNKNOWN** (600.1 s, 610.7 s) |
| 58 | 58 of them | 2.61 × 10¹⁷ | 2 | **UNKNOWN** (607.1 s, 615.7 s) |
| **82** | **the origin's entire first shell** | **4.96 × 10²⁴** | 2 | **UNSAT** — **42.89 s**, **93.12 s** |
| 3,526 | the whole word-distance-≤ 2 ball (3,529 vertices) | — | 3 | **UNSAT** — 7.33 s, 7.64 s, 8.04 s |

**The crossover is between depth 58 and depth 82.** Below it nothing decides in 600 s; at it, cubes fall in
under two minutes.

### 4.2 But the deep refutations are local, and that types the ladder

Before reading "cubes decide at depth 82" as a fact about the bulk, the same cubes were re-asked on sub-balls
(regenerated from the same seed and code path):

| cube | on the radius-2 ball (3,529 vertices) | on the radius-3 ball (95,389 vertices) |
|---|---|---|
| depth 40, both | SAT, 0.01 s | **SAT**, 18.7 s / 44.6 s |
| depth 58, both | SAT, 0.01 s | **SAT**, 176.0 s / 5.0 s |
| **depth 82, both** | SAT, 0.01 s | **UNSAT**, **8.34 s** / **2.12 s** |

So a depth-82 cube survives the second shell and dies at the third, and **the 1.89 M-point ball is never
needed**: the 43 s and 93 s of §4.1 are a 71 M-clause formula slowly rediscovering a refutation that a
2.9 M-clause formula finds in seconds. The ladder's verdict is a statement about a radius-3 neighbourhood, not
about the bulk of the graph.

### 4.3 The consequence, measured: the radius-3 ball kills 120 of 120 first-shell colourings

| | |
|---|---|
| random first-shell colourings drawn (one proper colouring per wheel, independently) | **120** |
| refuted by the radius-3 ball alone | **120** — every one |
| mean time | **1.74 s** |
| budget each | 300 s (never approached) |
| survival rate | **0 of 120**, so **< 2.5 %** at 95 % confidence (rule of three) |

**The positive control this demands, and it passes.** The radius-3 ball *is* 4-colourable — SAT in 24.07 s
here, and 14.6 s in the committed `k = 3` control row — so some first-shell colouring must survive, and if none
of mine could, the 120/120 would be measuring my cube construction rather than the fabric. Taking a real
4-colouring of that ball, reading its first shell off, and feeding it back as a cube: **every wheel is
separately proper (so the random generator could have drawn it) and the cube comes back SAT in 3.20 s.**
The generator's image contains survivors; there are just very few of them.

### 4.4 The cost model, as arithmetic against the sample

A pass at depth `d` costs `cubes(d) × time(d)`. Both factors are measured:

| depth | cubes | measured per-cube time | pass cost |
|---|---|---|---|
| 10 | 726 | **> 600 s** (0 of 16 decided) | **> 121 core-hours**, and the sample gives no upper bound |
| 16 | 47,916 | **> 600 s** (0 of 16) | **> 7,986 core-hours** |
| 22 | 3,162,456 | **> 600 s** (0 of 16) | **> 527,000 core-hours ≈ 60 core-years** |
| 40 | 9.09 × 10¹¹ | > 600 s (0 of 2) | > 1.5 × 10¹¹ core-hours |
| 58 | 2.61 × 10¹⁷ | > 600 s (0 of 2) | > 4.4 × 10¹⁶ core-hours |
| 82 | 4.96 × 10²⁴ | **68 s** (2 of 2 decided) | **9.4 × 10²² core-hours** |
| 82, two-stage | 4.96 × 10²⁴ | 1.74 s local + > 600 s on < 2.5 % | **≥ 2.4 × 10²¹ core-hours** |

> **The cube count rises by 66× per wheel while the per-cube time falls by at most 10×, so the product is
> minimised at the shallowest depth — and the shallowest depth is exactly where nothing decides. There is no
> operating point.** The best two-stage reading, using the radius-3 test as a cheap filter, still costs
> 2.4 × 10²¹ core-hours, because 5 × 10²⁴ cubes have to be *generated* even when each is refuted in 1.74 s.

**Arithmetic check against the sample, as `CLAUDE.md` § Toolchain requires:** 6 workers at ~605 s per cube
predicts `6 × 3600/605 = 35.7` cubes/hour. Measured over the complete run: **48 cubes in 4,825 s = 35.8
cubes/hour**, and at the 12-cube mark 35.7. The predicted rate divides back out of the observed one at both
points, so the cost model is not fitted to the population it prices.

**What the phase spent**, against the brief's 12 CPU-hour cap: **9.62 CPU-hours of solver** (the sample
8.05, the ladder 0.72, arm 2's run 0.50, arms 1e–1g 0.31, the controls and calibrations 0.06) plus about 0.3
of exact arithmetic in numpy.

### 4.5 How many survive? Measured from below, and only from below

If the surviving set were small, the two-stage instrument above would be a real pass. So the survivors were
enumerated directly — solve the radius-3 ball, project the model onto the 82 free first-shell vertices, block
that projection, repeat — on an incremental CaDiCaL for 600 s:

| | |
|---|---|
| distinct survivors enumerated | **269** |
| wall | 666.6 s |
| rate | **0.40 / s** overall; **0.51 / s** over the first 200, **0.25 / s** over the next 69 |
| exhausted? | **no** — the solver never returned UNSAT |

**This is a finder, and it bounds `|survivors|` from below and not at all from above** (G21). The halving of
the rate is what accumulating blocking clauses do at *any* set size, so it is not evidence of exhaustion; and
0.40 survivors per second is itself a ceiling on the instrument, since even 10⁶ survivors would take 29 days
of one core just to *list*. The informative outcome — the enumeration stalling, which would have bounded the
set — did not occur, and the uninformative one is what this row records.

**What would settle it** is a projected model counter (`ganak`, `d4`; neither installed) rather than a
finder, and that is the single measurement standing between this lattice and a priced decision.

---

## 5. Arm 2 — the symmetry break: the pin already spent it

### 5.1 The group is exactly 96, and it is verified on the edges

All eight candidate maps permute the ball's 1,886,761 points, and each was separately checked to carry **edges
to edges** on a 1-in-97 sample of all 14,523,840 of them — a bijection of the point set is not an automorphism:

| map | what it is | permutes | edge-preserving | fixed points |
|---|---|---|---|---|
| `ζ₁₂`, `ζ₆`, `i`, `neg` | rotation by `(√3 + i)/2` and its powers | yes | yes | 1 each |
| `conj` | complex conjugation | yes | yes | 879 |
| `gal3`, `gal5`, `gal15` | the Galois flips `√3 ↦ −√3`, `√5 ↦ −√5` (G27) | yes | yes | 11,341 / 3,601 / 949 |

The Galois flips are not isometries of the plane; they are automorphisms because `x² + y² = 1` has rational
coefficients, so they carry unit vectors to unit vectors and differences to differences. The group they
generate, closed as permutations, has order **96** — exactly the brief's ceiling.

### 5.2 What the existing pin leaves: 8, and that is a derivation

An element `(σ, π)` of `Aut × S₄` maps the *pinned* solution set into itself only if `σ` permutes the pinned
vertices among themselves — otherwise it would have to fix the colour of an unpinned vertex across every
solution, and no vertex does that. Every element here fixes the origin, so the condition is that `σ` stabilises
`{25, 27}` setwise, and `π` is then determined (the identity if `σ` fixes both, the transposition `(1 2)` if it
swaps them). **That subgroup has order 8** — 4 fixing 25 and 27 pointwise, 4 swapping them.

> **The triangle pin already reduces the unpinned problem's 2,304 symmetries (96 automorphisms × 24 colour
> permutations) to 8 — it has spent a factor of 288 of them. A factor of 8 is the hard ceiling on what any
> symmetry break can buy on this formula.**

On 7,547,044 variables, a factor of 8 is not an instrument. That is the answer to arm 2 *before* any solver
runs, and the brief priced the break against the wrong group: its ceiling is 8, not 96 × 24.

### 5.3 The break, encoded, with a three-part control

Lex-leader constraints `C ≤_lex π ∘ C ∘ σ` for each of the 7 non-identity elements, over the first 4,096
vertices in index order (a prefix constraint is implied by the full one, so it is sound, and the lex-least
member of every orbit survives). **307,740 clauses, 27,977 auxiliary variables** — 0.43 % of the formula's clauses. Every image index under
the 7 elements stays inside the first 90,038 vertices, so the prefix is not wasted on vertices the maps send
far away.

The control bed is the `k = 3` ball of the same lattice (95,389 points), which carries the **same order-96
group and the same order-8 residual** and is SAT in 14.6 s, so a break that turns SAT into UNSAT is visible.
Its base body reproduces `fs70_ask.py`'s own committed CNF sha for that instance (`f22d4fda4a56f16e…`) — a
second, independent confirmation of the writer used for the `k = 4` body.

| check | what it must do | result |
|---|---|---|
| (A) orbit, no solver | take a model of the unbroken instance, build its 8-member orbit, assert every member proper and pinned, count how many survive the break's condition | 8 of 8 proper and pinned; **exactly 1 survives** → sound (≥ 1) and effective (< 8) |
| (B) the real run | `kissat` on base + break must be SAT, and the model proper, pinned, and lex-least for all 7 | **SAT**, 0 monochromatic edges, pin held, lex holds for all 7 — so the *encoding* enforces the theory |
| (P) the plant `strict` | the same clauses with `a ≥ b` forbidden instead of `a > b`, rejecting a colouring equal to its own image | **UNSAT — FIRED.** The control has a reachable failure mode and has therefore been tested by passing |

### 5.4 The measurement

One run, `kissat` 4.0.4 default configuration, 1,800 s, on the formula plus the break — **the only thing that
differs from phase 1b's default-configuration row is the 307,740 break clauses and the budget**:

| # | phase | solver | configuration | budget | verdict | RSS |
|---|---|---|---|---|---|---|
| 1 | 1b | `kissat` | default | 1,500 s | UNKNOWN at 1,500.34 s | — |
| 2 | 1b | `kissat` | `--sat` (`--target=2 --restartint=50`) | 2,400 s | UNKNOWN at 2,400.07 s | — |
| 3 | 1e | `kissat` | `--unsat` | 5,400 s | UNKNOWN at the wall | — |
| 4 | 1e | `cadical` 2.1.2 | default | 5,400 s | UNKNOWN at the wall | — |
| **5** | **1f** | **`kissat`** | **default + the order-8 lex-leader break** | **1,800 s** | **UNKNOWN at 1,800.03 s** | **5.03 GB** |

**The break does not move the instance**, which is what §5.2's ceiling predicts and is the honest way to read
it: a factor of 8 was never going to show against 7.5 M variables. Five attempts now stand on this one control
— **16,592 s ≈ 4.6 CPU-hours, two code bases, four configurations, two encodings** — and by G21 that is a
statement about the encodings and the configurations, never about the graph.

*Caveat on the comparison, stated rather than buried: row 5 differs from row 1 in two things, the break and the
budget (1,800 s against 1,500 s). Since both are UNKNOWN at their walls and the longer budget can only help
row 5, the comparison survives it — but it is not the single-difference comparison the rest of this record
holds itself to, and a rerun at 1,500 s would cost 25 minutes if anyone wants it clean.*

---

## 6. Arm 3 — the `k = 5` ball, priced exactly, and a shape nobody had looked for

The brief asked for the `k = 5` ball's size from a 10 % sample of the `k = 4` boundary. The exact computation
turned out to cost six minutes of one core, so the numbers below are exact and the brief's estimator is scored
against them in §6.5.

### 6.1 The shells, exact, checked against a committed number

| shell (word distance) | 0 | 1 | 2 | 3 | 4 |
|---|---|---|---|---|---|
| points | 1 | 84 | 3,444 | 91,860 | **1,791,372** |

Sum 1,886,761 — the ball. Shells 0–3 sum to **95,389**, exactly the committed size of the `k = 3` ball: the
word-distance computation reproduces a number written by a different tool.

### 6.2 The degree profile, and what "average degree 15.4" was hiding

| shell | points | mean degree | min | max |
|---|---|---|---|---|
| 0 | 1 | **84.0** | 84 | 84 |
| 1 | 84 | **86.9** | 84 | 88 |
| 2 | 3,444 | **85.1** | 84 | 92 |
| 3 | 91,860 | **84.7** | 84 | 92 |
| **4** | **1,791,372** | **11.7** | 3 | 34 |

> **The ball's interior has degree 85, not 15.4. The 15.4 is a boundary average, and the boundary is 94.9 % of
> the ball.**

That reframes the 13-core's emptiness, which phase 1e read as "the degree distribution is tight, there is no
dense sub-object". The distribution is not tight — it is bimodal, 85 against 11.7 — and the 13-core is empty
because peeling the thin outer shell cascades inward and takes the interior with it. The core-number profile
shows the cascade: the maximum core number is **12**, and it is 12 in *every* shell, interior and boundary
alike.

**Control:** the core profile, recomputed here in one bucket-peel pass by an independent implementation,
reproduces phase 1e's committed table to the integer — 6-core 1,886,425; 10-core 1,395,289; 12-core 1,374,661;
13-core 0.

### 6.3 The `k = 5` ball, exactly

| quantity | `k = 3` | `k = 4` | **`k = 5`** |
|---|---|---|---|
| points | 95,389 | 1,886,761 | **29,082,973** |
| edges | 549,744 | 14,523,840 | **≥ 279,644,187** |
| mean degree | 11.53 | 15.40 | **19.23** |
| boundary share | — | 94.94 % | 93.51 % |
| the origin's degree | 84 | 84 | **132** |

The mean degree is measured, not extrapolated: on a sample of the ball's points over **all 132 unit vectors of
the lattice that fit inside it** (the 84 of word-length 1 plus the 48 of word-length 5), the old `k = 4` points
read **85.39** (min 84, max 104) and the new shell-5 points **14.64** (min 4, max 50). It is a lower bound —
a unit vector of word-length ≥ 6 can still join two `k = 5` points, which in the `k = 4` ball accounted for
1.97 % of the edges.

The mechanism is the last row: **48 more of the lattice's 324 unit vectors become expressible in 5 generator
steps**, so the origin's degree rises from 84 to 132.

> **The word ball's degree does NOT stop at 15.4.** Phase 1e's §6.3 concluded "the word ball is the only
> affordable shape and its degree stops at 15.4". The family reads 11.53 → 15.40 → **19.23**, and `k = 5` is
> above G65's degree-14 threshold, where "almost everything decides in seconds". What stops is the size.

### 6.4 What it would cost, and the brief's stop rule

The brief said: *if the 14-core is under ~2 M points and buildable in under 40 GB, say so and stop.* **It is
not, and the ball itself is the obstacle rather than its core.**

| | `k = 5` ball |
|---|---|
| points / edges | 29,082,973 / ≥ 279,644,187 |
| CNF | **≈ 1.32 billion clauses, 116,331,892 variables** |
| DIMACS on disk | **26–32 GB** (the `k = 4` body is 1.399 GB at 19.6 bytes/clause; wider variable numbers cost more) |
| `kissat` RSS | **≈ 36 GB to parse, ≈ 103 GB after ten minutes of search** — both extrapolated from this phase's own measurements on the `k = 4` formula: **27.4 bytes/clause** at parse (1.91 GB on 71.3 M clauses) and **77.7** at the worst RSS seen in 57 cube runs (5.16 GB) |
| `graph.json` | ≈ 5.5 GB (the `k = 4` one is 328 MB) |

And the 14-core cannot be under 2 M points: **all 1,886,761 of the old `k = 4` points have degree ≥ 84** in the
`k = 5` ball, and **65.9 % of the 27.2 M shell-5 points already have degree ≥ 14** before any peeling. *Reading,
with its basis: by the `k = 4` analogue — shell mean 11.7, maximum core number 12 — the `k = 5` ball's maximum
core number should be about 14 and its 14-core of order 20 M points. Only building the ball settles it, and the
brief said not to.*

### 6.5 The brief's 10 % estimator is biased by 3.94×, and the reason is worth keeping

| estimator | value |
|---|---|
| exact `\|shell 5\|` | **27,196,212** |
| 10 % of shell 4, distinct new points found, ÷ 0.1 | **107,276,370** — **3.94× too high** |

A new point has on average **4.78 parents** in shell 4, so a 10 % parent sample finds it with probability
`1 − 0.9^4.78 = 0.40`, not 0.10. **Counting distinct children from a parent sample is biased; summing an
incidence count over a parent sample is not** — which is why the shell-5 internal incidence count in §6.3 was
estimated that way and the point count was not estimated at all.

### 6.6 A shape 2.6× smaller at the same degree

The `k = 5` ball's degree rose because 48 more unit vectors became expressible. So take **those 132 unit
vectors as the generator set** — the same lattice, the same unit-distance graph, a different shape — and build
word balls in that metric:

| radius (132-generator metric) | points | mean degree | min | max | boundary share |
|---|---|---|---|---|---|
| 1 | 133 | 3.97 | 3 | 132 | 99.2 % |
| 2 | 8,713 | 8.05 | 3 | 132 | 98.5 % |
| 3 | 368,977 | 12.54 | 3 | 132 | 97.6 % |
| **4** | **11,091,217** | **18.72** | 3 | 132 | 96.7 % |

**11.09 M points at degree 18.72, against the `k = 5` ball's 29.08 M at 19.23** — the same density for 38 % of
the size, ≈ 500 M clauses instead of ≈ 1.32 G. *(Degrees counted over the 132 unit vectors, so a lower bound by
the same 1.97 % argument.)* Every one of these balls is ≥ 96 % boundary, which is the structural reason no
word ball in this lattice is ever interior-dominated.

### 6.7 What this does to G65 and G69, both written while this phase ran

*Flagged for the close to act on, not acted on here. The numbers are §6.2, §6.3 and §6.6.*

**G65's new clause** — *"on a word ball, compute the core numbers before promising a denser core; in rank 8
expect none above ~12"* — has exactly the right mechanism, and §6.2 is that mechanism with the numbers filled
in: the `≤ 3` interior's degree **inside the ball** is 84.7 while its **induced** degree among itself is 11.5,
and the shell carrying the difference peels first. What over-generalises is the ceiling. **12 is the `k = 4`
ball's number, not rank 8's**: the ceiling tracks the *outermost shell's* mean degree, which is **11.7 at
`k = 4`** (ceiling 12, i.e. shell mean + 0.3) and **14.64 at `k = 5`**, so the same argument predicts ~14–15
one radius out. The form that survives is radius-indexed and rank-free: *a word ball's core number is set by
its outermost shell's mean degree, and that shell is ≥ 93 % of the ball at every radius measured.*

**G69's clause** is the one to look at hardest: *"where rigidity is possible, density is not"*, with the
imperative *"if that lattice's rank is the field's full degree, expect no dense finite piece"*. **A dense
finite piece exists here. It is large, not absent.** The `k = 5` word ball is **29,082,973 points at mean
degree 19.23**, and the radius-4 ball in the 132-unit-vector metric is **11,091,217 at 18.72** — both above
G65's degree-14 threshold, and the second of them is a shape nobody had enumerated. So the honest quantifier is
that **density over this lattice starts at ~10⁷ points**, against the 2.3 × 10⁴ of the dense, rigid object over
`K`. Three orders of magnitude is a price; "none" is a closed direction, and the two license different
decisions.

*What this does NOT touch:* G69's main claim. The rank-8 lattice has no periodic four-colouring at any
admissible modulus in reach, so the quotient instrument G69 is built on is silent there, and nothing in this
phase measures the rigidity of these dense pieces — only their size and their degree.

---

## 7. Where the brief was wrong, and where I was

| where | what it says | what is the case |
|---|---|---|
| **the brief, arm 1** | "the origin and its 12 neighbours `ζ₁₂^k` (they form two 6-cycles under unit distance)" | the origin has **84** neighbours in this ball, forming **fourteen** disjoint 6-cycles — `N(0)` is the whole generator set. Branching on two wheels is depth 16, not 12 |
| **the brief, arm 1** | "Enumerate the cubes … **with unit propagation** through the whole formula after each assignment … report the count that survives" | done, and **propagation buys nothing beyond the branching set's own edges** — 0 branches refuted at every depth up to 82, counts exactly `11 × 66^h`, a whole assigned wheel forcing exactly its own 7 vertices. Phase 1b's enumerator was not the weak part; its branching *set* was |
| **the brief, arm 1** | "sample 48 cubes at random, 600 s each" at one depth | spent at **three** depths, 16 each. One depth cannot show whether depth buys anything, which is the derivative a pricing exercise needs — and the ladder (§4) then showed the crossover sits far outside the range the brief named |
| **the brief, arm 2** | "a group of order up to 96; add lex-leader constraints … for it" | the group is exactly 96, but **the existing pin already leaves only 8 of it** (§5.2). The break's ceiling is a factor of 8, not 96 × 24, and that is a derivation available before any run |
| **the brief, arm 3** | "Count the ≤ 5 ball's points … on a sample of 10 % of its boundary and scaling" | the exact count was affordable (6 min), so it was computed: **27,196,212**. The brief's estimator overshoots by **3.94×** (§6.5) — worth keeping for the next boundary estimate |
| **the brief, arm 3** | "If the 14-core is under ~2 M points and buildable in under 40 GB, say so and stop" | it is not, but the stop rule was aimed at the wrong quantity: the interesting fact about the `k = 5` ball is not its core, it is that **the whole ball is already at degree 19.2** — and that a 2.6× smaller shape reaches the same degree (§6.6) |
| **phase 1e, §6.3** (quoted by the brief) | "the word ball is the only affordable shape and **its degree stops at 15.4**" | it does not. `k = 5` is at **19.23**, above G65's decide-in-seconds threshold. What stops is the size, which is a different objection with a different answer |
| **phase 1e, §6.3** | "the degree distribution is tight, there is no dense sub-object" | it is **bimodal**: 85 in shells 0–3, 11.7 in shell 4. The 13-core is empty because the boundary is 94.9 % of the ball and peeling it cascades |
| **mine, on first seeing the ladder** | I concluded the depth-82 UNSAT meant propagation must be pruning hard there, so `11 × 66^13` had to be a wild overcount, and wrote an estimator to correct it | **the formula was right and I was wrong**: 0 of 400 probes died at depth 82 and the estimate agrees with `11 × 66^13`. The estimator earned its place anyway, because its depth-22 run reproduces the exact count and because the correction I expected would have changed the headline by twenty orders of magnitude had it been real |
| **mine, second reading of the ladder** | my next guess was that the depth-82 cubes die at the second shell, the wheels having been coloured independently | **also wrong**: both are **SAT on the radius-2 ball** and die at radius 3 (§4.2). Two wrong mechanisms in a row on the same observation, each settled by a one-minute run rather than by argument |
| **mine, the ladder ledger** | I wrote `'cube': None` into `ladder.jsonl` to keep the rows small | that threw away the cubes I then needed for §4.2, and they had to be regenerated from the seed. A ledger row that cannot reproduce its own input is not a record |
| **mine, arm 1g's design** | I registered its informative direction as *"if survivors pour out, the set is large and the route is dead"* | **that outcome was unreachable by construction and I did not check.** A blocking-clause enumeration on this formula runs at ~0.4 solves per second, so 600 s can produce at most ~300 survivors — never a number that reads as "many". `CLAUDE.md` says to state the uninformative outcome and confirm the informative one is reachable *before* the run; I stated it and never priced it, so the run could only ever land in the ambiguous middle, which is exactly where it landed. The honest fix is a model counter, not a longer finder (§4.5) |

---

## 8. What a kill would have redone, and how to regenerate everything

Every run carried an in-flight marker under `data/fs70/inflight/` with its pgid file and its resume command,
and every marker was removed at its verdict. Both solver arms append one row per cube to a ledger **as it
lands**, so a kill costs only the cubes in flight (at most 6 × 600 s for the sample, 4 × 600 s for the ladder)
and the rerun skips every tag already in the ledger. The numpy computations write their JSON only at the end,
so a kill leaves nothing partial to distrust; each is under six minutes of one core.

```bash
# the cache and the base body -- `base` refuses a body that is not the four prior attempts' formula  ~1 min
python3 tools/fs70_price_cubes.py prep build/fs70/L3-w4/graph.json --out build/fs70/1f
python3 tools/fs70_price_cubes.py base build/fs70/L3-w4/graph.json --out build/fs70/1f

# arm 1a: the wheels and the exact cube counts                                        ~3 min
python3 tools/fs70_price_cubes.py branch --out build/fs70/1f --nbranch 4,10,16,22 --cap 4000000

# arm 1b: the sample, resumable by tag                                                8 CPU-hours
python3 tools/fs70_price_cubes.py sample --out build/fs70/1f --depths 10,16,22 \
        --per-depth 16 --budget 600 --jobs 6 --seed 20260922

# arm 1c-f: the ladder, the cube-count estimator, where the refutation lives, the survival rate
python3 -u build/fs70/1f/arm1c.py                # 1.5 CPU-hours
python3 -u build/fs70/1f/arm1d.py 22,40,58,82 400   # ~10 s
python3 -u build/fs70/1f/arm1e.py                # ~6 min
python3 -u build/fs70/1f/arm1f.py 120            # ~4 min on 6 workers
python3 -u build/fs70/1f/arm1f_control.py        # the positive control -- must read SAT
python3 -u build/fs70/1f/arm1g.py 600            # enumerate the survivors (one-sided)

# arm 2: the group, the break, its control on the k = 3 ball, and the one run         ~40 min
python3 tools/fs70_price_cubes.py symbreak --out build/fs70/1f --prefix 4096
python3 tools/fs70_price_cubes.py prep build/fs70/L3-w3/graph.json --out build/fs70/1f-w3
python3 tools/fs70_price_cubes.py base build/fs70/L3-w3/graph.json --out build/fs70/1f-w3 --want none
python3 build/fs70/1f/arm2_control.py            # (A) orbit, (B) the run, (P) the plant `strict`
bash build/fs70/1f/symrun.sh

# arm 3: the shells, the k = 5 ball exactly, the degrees, the 132-generator shapes    ~20 min
python3 tools/fs70_price_cubes.py shell --out build/fs70/1f --chunk 40000 --frac 0.1
python3 -u build/fs70/1f/arm3.py                 # degree and core profile by shell
python3 -u build/fs70/1f/arm3b.py                # the k = 5 mean degree, measured
python3 -u build/fs70/1f/arm3c.py                # the 132-generator balls

# the geometry control: every edge exactly unit, in integer arithmetic         ~11 s
python3 -u build/fs70/1f/arm0_geometry.py
```

Committed: `tools/fs70_price_cubes.py` (the instrument), this record, and under
`data/fs70/records/phase-1f/` both solver ledgers (`sample.jsonl`, `ladder.jsonl`), every JSON result, and all
ten scratch scripts so they are not lost with `build/`. Left under the gitignored `build/fs70/1f/` and regenerable by the commands above: the
1.4 GB base body, the 435 MB shell-5 point array, the `.npy` caches.

---

## 9. Ranked, for the close

*Four things to spend on and three that are closed. Each open item carries the alternative I weighed and my
confidence, because each is a decision the close has to take.*

### 1. The 12-core, which has never been asked — one 600-second run

**The choice:** ask the `k = 4` ball's 12-core before building anything new.

It is **1,374,661 points at mean degree 16.08** — 27 % smaller and strictly denser than the ball that has now
absorbed five solver attempts — and a refusal on it carries up to the whole ball, because it is a subgraph.
Checked against `data/fs70/asks.jsonl`: the only cored ask in the whole milestone is L6's 14-core, twice; **no
core of this lattice has ever been asked.**

**Alternative weighed:** phase 1e computed this core and declined it, on the ground that it buys only +0.69 of
average degree for 27 % fewer points. **Why I would ask it anyway:** that reasoning used the ball's *average*
degree, and §6.2 shows the average is a boundary artefact — the object is bimodal, and the 12-core is exactly
the part that survives peeling. It costs one run to find out, which is less than this sentence took to check.
**Confidence: medium-low that it decides, high that it is the cheapest unasked object in the milestone.**

### 2. The two-stage instrument — and the one number nobody has measured

**The choice:** ask this lattice through the radius-3 ball, not through the full ball.

Every 4-colouring of the `k = 4` ball restricts to a first-shell colouring that survives the radius-3 ball, and
the radius-3 ball is **25× smaller** (2.87 M clauses against 71.3 M) and refutes in **1.74 s** what the full
ball takes 43–93 s to rediscover (§4.2, §4.3). So a complete decision procedure is: *enumerate the first-shell
colourings that survive radius 3; ask only those against the full ball.*

**Alternatives weighed.** Continue the single-solver route — five attempts, 4.6 CPU-hours, two code bases, four
configurations, every one UNKNOWN (§5.4). Or the blind cube pass — no operating point, by fifteen orders of
magnitude (§4.4). Both are measured, not guessed.

**Why this one:** it is the only route this phase found where the expensive formula is touched once per
*survivor* instead of once per *cube*.

**And the number it turns on is `|survivors|`, which is unmeasured.** Arm 1g is the only read there is:
**269 distinct survivors enumerated in 666 s**, with no exhaustion and a rate that halved as blocking clauses accumulated (§4.5). That is a finder's rate and it measures the incremental solver as much as it measures the set
(G21) — it bounds `|survivors|` from below and **not at all from above**. Two things would settle it, neither
run here: a projected model counter (`ganak`, `d4` — neither installed), and a faster enumerator, since at
0.4 survivors per second even 10⁶ of them is 23 days of one core.

**Confidence: high that the route is correct by construction, low that it is affordable.** `|survivors|` could
be 10⁴ or 10²⁰ and nothing measured here distinguishes those.

### 3. The 132-generator radius-4 ball — 11.09 M points at degree 18.72

**The choice:** if the close wants this lattice at a degree above 15.4, build in the 132-unit-vector metric,
not at `k = 5`.

**11,091,217 points at 18.72** against the `k = 5` ball's **29,082,973 at 19.23** — the same density for 38 %
of the size, ≈ 493 M clauses instead of ≈ 1.32 G, and ≈ 37 GB of solver memory instead of ≈ 103 GB (§6.6).
Both are above G65's degree-14 threshold, where "almost everything decides in seconds".

**Alternative weighed:** the `k = 5` ball itself, which the brief asked me to price and which is buildable on
this machine at the edge. **Why the smaller one:** one thing differs between them — the generator set — and the
smaller wins on every other axis. **Confidence: high on the arithmetic, medium on whether either decides**;
G65's threshold is a regularity across this project's instances, not a law about this lattice.

### 4. A lookahead cuber is the only cube-and-conquer left

**The choice:** if cube-and-conquer is tried again here, it needs `march_cu` (or another adaptive cuber), which
`CLAUDE.md` lists as *not installed; build from source when wanted*.

This phase measured why: with a **fixed, origin-centred** branching set the cube count rises 66× per hexagonal
wheel while the per-cube time falls by at most 10×, so the product is minimised at the shallowest depth and
the shallowest depth decides nothing (§4.4). That is a statement about *fixed* branching sets. An adaptive
cuber choosing variables by lookahead is a different instrument, and it is the one the literature uses at this
scale. **Confidence: medium** — nothing here measures a lookahead cuber, and the ladder gives it no guarantee.

### Closed by this phase — do not spend on them again

| what | why |
|---|---|
| **the symmetry break** | its ceiling is a **factor of 8**, derived before any run (§5.2), and the run is UNKNOWN at 1,800 s (§5.4). The group is exactly 96 and the pin has already spent 288 of it |
| **the blind cube pass over hexagonal wheels** | no operating point: **> 121 core-hours with nothing decided** at the cheapest depth, **9.4 × 10²² core-hours** at the shallowest depth whose cubes decide (§4.4) |
| **the brief's 10 % boundary estimator** | biased **3.94×** high, because a new point has 4.78 parents; count incidences over a parent sample, never distinct children (§6.5) |
