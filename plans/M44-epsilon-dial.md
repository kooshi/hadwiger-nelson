# M44 — The ε-dial: the cell family is not a door, it is a dial, and its limit is the problem
#
# SUBPLAN — written 2026-08-13 on Kooshi's "go for M44 subplanning and implementation".
# Supersedes the stub of the same date (kept in git history). Machine: DESKTOP,
# 32 cores / 125 GB. Read order for a fresh session: this file WHOLE; then
# `plans/M43-fine-tail.md` §R, `plans/M40-chi-omega-hunt.md` §R, CLAUDE.md G23/G24/G28/G29/G30.

## The mission, for a reader who knows nothing about this project

Colour every point of the plane so that no two points exactly one unit apart get the same
colour. Nobody knows whether 5, 6, or 7 colours are needed — that is the Hadwiger–Nelson
problem, open since 1950. This project built, over five milestones, a family of finite
computable graphs `G(p)` — one for each grid scale `p` — whose colourings are exactly the plane
colourings that are constant on the cells of a triangular grid at that scale. We measured that
`G(p)` needs **seven** colours at every scale where we ever got a verdict, and then closed the
family as a research direction because no six-colouring can live in it.

That verdict was right and the closure was wrong, for a reason nobody checked: being constant on
cells of size `p` forbids not just the distance 1 but a whole small **interval** of distances
around 1, and that interval shrinks as the cells shrink. So the family is a **dial**. At the
coarse end sits the classical seven-colouring. As the dial turns down, the cells shrink to
points, the constancy restriction evaporates, and **the limit is the original unit-distance
problem itself**. The answer is seven at every setting of the dial. It can be five or six only
exactly at the limit.

This milestone (i) proves the theorem that makes that limit statement precise and checks it in
the proof kernel, and (ii) measures the one quantity the theorem says matters: how large the
smallest forcing configuration must be as the dial turns down. The theorem says that if that
size stays **bounded**, then the plane needs seven colours — so its **growth is a necessary
condition for the answer being six**, and its rate is the first quantity this project has
produced that speaks to *which* of 5, 6, 7 is true.

---

## §0′ — What the domain-modeling pass changed (2026-08-13, run on the subplan above)

The pass found the milestone was carrying **four co-equal objects** (`δ`, `η`, `ν`, `defect`) where
the problem has **one primitive and one derived summary**, and that the Lean statement had
serialized a quantifier that should have stayed a quantifier. Five changes, each with the smell
that produced it:

1. **`defect` is the primitive; everything else is derived or orthogonal.** For a finite graph `H`,
   `defect(H)` = the least, over drawings of `H` in the plane, of the largest deviation of an edge
   length from 1. Then `ν(ε) = min { |H| : χ(H) ≥ 7, defect(H) ≤ ε }` — **`ν` is not a second
   measurement, it is the lower envelope of the points `(|H|, defect(H))`** over every certified
   non-6-colourable graph we hold. And `η(p) = 2p/√3` is not a co-equal object either: it is the
   **free initial upper bound** on `defect` of a cell core, the one the cell-centre drawing hands
   you before any optimization. The campaign therefore measures exactly one number per object.
2. **`δ` leaves the main line.** It belongs to the *interval* story (the conditional bridge to
   Voronov's theorem) and plays no part in producing witnesses. Keeping it beside `η` is what
   created the conflation hazard that §0a below tried to police with a driver-level guard — an
   apologetic comment standing in for a model. With `δ` demoted to its own short section the
   guard is unnecessary, and it is removed.
3. **The Lean statement takes `∀ ε > 0`, not a sequence.** `ε : ℕ → ℝ` with `Tendsto … 0` plus a
   matching `z : ℕ → ι → ℂ` is a *serialization* of "for every tolerance there is a drawing" —
   incidental structure, and structure the caller would have to manufacture, since our family is
   indexed by bands rather than by ℕ. The sequence belongs inside the proof, where a subsequence
   is extracted; it does not belong in the statement.
4. **The theorem is not about `ℂ`.** Its proof uses only that closed balls are compact, so it is
   stated for `[MetricSpace V] [ProperSpace V]` — which is the argument's actual generality, and
   matches the house `unitDistance` API, itself stated for an arbitrary metric space. `ℂ` is
   where our *construction* lives; making it the theorem's home would be incidental structure.
   The headline instantiates at `ℂ` and rides `chromaticNumber_plane_eq_complex` to the plane.
5. **Neither `defect` nor `ν` is defined in Lean.** Each would owe a lemma API for a single use —
   speculative structure. The Lean theorem *is* the statement "`defect = 0` with bounded drawings
   forces the plane bound", written without naming it; the names live on the measurement side
   where the numbers are.

Two consequences worth stating because they were not visible before the pass:

* **The boundedness hypothesis is free, and the note belongs on paper rather than in the type.**
  A graph that is not `k`-colourable has a connected component that is not `k`-colourable, so the
  minimizer in `ν` is WLOG connected; a connected graph with edges of length `≈ 1` has diameter
  at most its vertex count. So bounding the vertex count bounds the region automatically, and
  `ν` needs no diameter clause. The Lean theorem still takes the bound explicitly (our caller
  measures it anyway, and deriving it would cost a walk induction that buys us nothing).
* **The `defect` model generalizes and the `η` model did not.** Test applied: does the
  representation earn the next theorem for free? Any certified non-6-colourable graph from any
  source — including the kernel-checked 23-vertex core — drops onto the same curve, because
  `defect` is defined for graphs and not for scales. The old organization could only speak about
  cell cores.

## §0 — Registration (committed BEFORE any instrument runs; the standing discipline)

### 0a. The tolerances (rewritten by §0′; `δ` retained here only for its own separate claim)

Working in lattice units where the grid's minimal vector has length 1 and `T = 1/p`, the exact
criterion (`celllat.interval`, already validated) gives for every address offset `d` the closed
interval `[mn_d, mx_d]` of squared lattice norms realizable between the two cells. Physical
distances realizable at that offset are `[p·√mn_d, p·√mx_d]`, and `d` is an edge of `G(p)`
exactly when that interval contains 1.

* **δ(p) — the AVOIDED interval half-width.** `δ(p) = min over all d (including d = 0) whose
  interval misses 1, of the distance from 1 to that interval.` Every proper colouring of `G(p)`,
  read as a plane colouring, avoids every distance in `(1−δ, 1+δ)`. This is the quantity in
  M43's bridge to Voronov, here made explicit and computable. **It bounds nothing about our
  refutations** — the implication runs from the interval theorem *to* our family, never back
  (M43 §R states this correctly; it is restated here because the temptation to reverse it is
  strong and would be a fake result).
* **η(p) — the REALIZATION tolerance, and the one this milestone lives on.** Pick any point in
  each cell (the centre will do). Two cells joined by an edge realize distance 1 somewhere, and
  moving each endpoint to its cell's chosen point moves the distance by at most the covering
  radius `p/√3` each. So **every edge of a core, drawn at cell centres, has length within
  `η(p) = 2p/√3` of 1.** This is monotone in `p` and it is what makes a core into a point
  configuration.

`δ` is used for exactly one claim in this milestone (the conditional literature bridge, §D) and
appears nowhere in the `defect`/`ν` line. `η` is the free initial upper bound on `defect`, superseded
per-object by phase 4's optimization.

### 0b. The primitive, and the summary derived from it

> **`defect(H)` := the least, over drawings of the finite graph `H` in the plane, of the largest
> deviation of an edge's length from 1.**

`defect(H) = 0` exactly when `H` is a unit-distance graph. It is **attained** for connected `H`
(the sublevel sets are compact once one vertex is pinned — the same compactness that proves §A's
D2), so "least" is a minimum, not an infimum. This is the milestone's single measured quantity:
one real number per certified non-6-colourable graph, and the first *continuous* meter this
project has had.

> **`ν(ε)` := min { |V(H)| : `H` not 6-colourable, `defect(H) ≤ ε` }** — the **lower envelope** of
> the points `(defect(H), |V(H)|)` over our whole inventory, not a separate measurement.

`ν` is non-increasing in `ε`, and — this is §A's D2 — **`χ(ℝ²) ≥ 7` if and only if `ν` stays
bounded as `ε ↓ 0`.** Everything this milestone produces is an **upper** bound: a drawing found
by local optimization bounds `defect(H)` above and never below, and each such bound with its vertex
count bounds `ν` above at that tolerance. No row may state otherwise, and the driver records
`bound_direction: "upper"` on every one.

### 0c. The objects

The five k = 6 cores already recorded (`build/m40-chiomega.json`, `build/m43-finetail.json`),
re-derived under one procedure, plus new rungs below `p ≈ 0.109`:

| band scale `T = 1/p` | `p` | recorded `N` | recorded ball radius |
|---|---|---|---|
| 13/6 | 0.4615 | 23 | 4 |
| 353/120 | 0.3399 | 28 | 5 |
| 467/120 | 0.2570 | 66 | 5 |
| 299/50 | 0.1672 | 117 | 8 |
| 48/7 | 0.1458 | 160 | 9 |

### 0d. The confound found while subplanning, and why phase 1 exists

Computing the physical size of those five cores gives a physical **diameter** in `[1.80, 2.49]`
while `p` varies by a factor of 3.16, and `N ∼ p^(−1.76)` over the same span. That is the
observation that motivated the milestone — and it is **not yet evidence**, because the ball
radius at each band was a number the experimenter chose, and the core is a subset of that ball.
The core's physical diameter is bounded above by twice the ball's, which for these five rows is
`2.57–3.69` — so the cores fill 65–95% of a box whose size was set by hand. **If the radii were
chosen by "smallest that refutes", the invariance is mathematics; if they were chosen by taste,
the invariance is an artifact of taste.** Phase 1 removes the confound by re-measuring the
minimal refuting radius `R*(p)` by bisection under one procedure and one cap.

### 0e. Registered predictions, with the evidence both ways

| # | prediction | prior | evidence for | evidence against |
|---|---|---|---|---|
| P1 | The limit lemma (D2) survives careful writing and formalizes in ≤ 300 lines of Lean | 85% | the existing `unitDistance` API already turns "a map with unit-length edges" into a plane bound, so the only new content is one existence lemma; Mathlib has compactness of closed balls in `ι → ℂ` and subsequence extraction | the collision case (two vertices converging to one point) needs care; sequence-of-subsequences bookkeeping is where such proofs bloat |
| P2 | `R*(p)·p` (minimal refuting ball, physical) stays within a factor 1.5 across the whole re-measured ladder | 60% | the five recorded cores' physical diameters span only 1.39× over 3.16× of scale | the radii were partly chosen; the two coarsest bands are structurally different (they have large cliques) and may not belong on the same curve |
| P3 | `N(p)` grows as a power of `1/p` with exponent in `[1.4, 2.2]` | 70% | five points give 1.76; a fixed physical region sampled at scale `p` holds `∼ p^(−2)` cells, so an exponent just under 2 is what a scale-invariant region predicts | the recorded points are an anthology across three milestones |
| P4 | The δ-maximizing scale within a band beats `canonical_T` by ≥ 2× in `δ` on at least half the bands | 75% | subplanning measurement: `canonical_T` gives `δ = 0.0033` at the band below `T² = 36` while the band's optimum is `0.024`, a 7× miss; `canonical_T` optimizes smallest denominator, i.e. nothing relevant | on wide bands the two may coincide |
| P5 | The embedding optimizer (phase 4) drives some core's max edge error below its trivial bound `η(p)` by ≥ 2× | 55% | the centres are an arbitrary choice and nothing was optimized; the graph has many more degrees of freedom (`2N`) than edge constraints in the sparse cores | the dense cores (2,978 edges on 160 vertices) are heavily over-constrained and may sit at the trivial bound |
| P6 | No core embeds with max edge error 0 (i.e. no core is secretly a unit-distance graph) | 97% | it would be `χ(ℝ²) ≥ 7`, and would have been noticed | — |

### 0f. Failure and halt clauses

* **`unknown at cap` is never a verdict.** A band that does not decide is recorded as undecided
  with its cap, and is excluded from every fit, with the exclusion stated in the plot.
* **P1's clause: if the limit lemma does not survive careful writing in §A, the milestone reports
  that and STOPS the measurement.** The numbers without the bridge are a curiosity, and shipping
  them dressed as a programme would be exactly the failure G30 names.
* **HALT AND VERIFY (P6):** any configuration found with `χ ≥ 7` and max edge error exactly 0 is
  `χ(ℝ²) ≥ 7` — the top end of the problem settled. Re-derive the graph independently,
  re-refute in a second encoding, verify every distance in exact arithmetic, and report before
  interpreting a single thing.
* **G21 clause, applied to this milestone's own acceptance test:** the refutation criterion here
  (a ball of `G(p)` is not 6-colourable) is *exact* for the cell-constant class and *sufficient
  only* for anything else. Every row states which.

### 0g. Controls that must be seen red and green

1. **Mass red** — the same ball asked at `k = 12` must be SAT everywhere on the ladder (the
   family's known upper bound at these bands), and at `k = 2` must be UNSAT everywhere.
2. **Green reproduction** — phase 1's re-derivation must reproduce the recorded `N` at
   `T = 48/7` (160 vertices, 2,978 edges, edge norms `{36,37,39,43,48,49,52,57,61,63}`) exactly.
   A disagreement halts the phase and is diagnosed before anything else runs.
3. **Embedding optimizer, both ways** — it must find max edge error `0` (to numerical tolerance,
   then confirmed exactly) on a graph known to be a unit-distance graph (the Moser spindle, and
   de Grey's 1581 from `tools/degrey_graph.json`), and must NOT on `K₄`, whose true minimum is a
   positive number computable in closed form and checked against.
4. **δ against a planted scale** — at a band boundary `δ` must be exactly 0, and `band_of` must
   refuse the scale; inside, `δ > 0` strictly.

---

## §A — The derivation (paper first; this is the milestone's spine)

### D1 — the realization lemma (elementary, stated for the record)

Let `C` be a set of addresses whose induced subgraph of `G(p)` is not 6-colourable. Choose any
point `q_a` in each cell. Then the graph on `{q_a}` with the same edge set is not 6-colourable
(it is the same abstract graph), and every edge has length within `η(p) = 2p/√3` of 1. Hence
`ν(η(p)) ≤ |C|`. *Note what is NOT claimed: nothing about non-edges, which may sit at distance 1
in the drawing. Extra edges only raise the chromatic number, so they cannot hurt — which is why
this lemma is free.*

### D2 — the limit lemma (the new content; statement per §0′.3–4)

> Let `G` be a fixed finite graph that is not `k`-colourable, drawn in a proper metric space.
> Suppose **for every tolerance `ε > 0`** there is a drawing of `G` inside one fixed closed ball
> with every edge's length within `ε` of 1. **Then the space's unit-distance graph is not
> `k`-colourable** — at the plane, `χ(ℝ²) ≥ k + 1`.

Proof. Instantiate the hypothesis at `ε = 1/(n+1)` to get drawings `z_n`, all inside the ball.
Drawings of a finite vertex set into a fixed closed ball form a compact set (a finite product of
compacts, the balls compact because the space is proper), so some subsequence converges pointwise
to a drawing `q`. For an edge `uv`, `dist(z_n u, z_n v)` converges to `dist(q u, q v)` by
continuity of the distance, and lies within `1/(n+1) → 0` of 1, so by uniqueness of limits
`dist(q u, q v) = 1` exactly. Then `q` sends every edge to a unit-distance pair, so it is a
homomorphism into the unit-distance graph, and a `k`-colouring of the space would pull back to a
`k`-colouring of `G`. ∎

**The collision subtlety, handled by not needing to handle it:** two vertices may converge to the
same point. The proof never asks `q` to be injective — it pulls a colouring *back* along `q` —
and adjacent vertices cannot collide anyway, since their limiting distance is 1.

### D3 — the headline corollary (bounded family ⟹ the plane bound)

> If there is a fixed vertex bound `N` and a fixed region such that **for every `ε > 0`** some
> graph on at most `N` vertices, not 6-colourable, is drawable in that region with all edge
> lengths within `ε` of 1, then `χ(ℝ²) ≥ 7`.

Proof. There are only finitely many graphs on a fixed `N`-element vertex set, so as `ε` runs
through `1/(n+1)` one graph `G` recurs for infinitely many `n`; that `G` satisfies D2's
hypothesis at every `ε > 0` (given `ε`, pick a recurrence with `1/(n+1) ≤ ε`). ∎

**Equivalently: `ν` bounded as `ε ↓ 0` ⟺ `χ(ℝ²) ≥ 7`**, so **the divergence of `ν(ε)` is a
necessary condition for `χ(ℝ²) ≤ 6`.** (⇒ is D1 applied to a 7-forcing unit-distance graph,
which has `ε = 0`; the region clause is free by §0′'s connectivity note.)

**Attribution, stated plainly and up front:** D2 is a compactness argument that any specialist
would produce on request, and no novelty is claimed for it. What this milestone contributes is
the formalization, the identification of the cell family as a computable source of upper bounds
on `ν`, and the measurement of those bounds — none of which exists anywhere in the record.

---

## §B — The Lean skeleton (spec ELABORATES; obligation pass run 2026-08-13)

### §B′ — what the obligation-modeling pass changed and confirmed

**Statement change: `IsCompact K` replaces "closed ball + `ProperSpace`".** Compactness is the
whole of what the argument uses; taking it as the hypothesis drops the `[ProperSpace V]`
instance from every statement in the file and lets the plane instance recover the bounded form
in one step via `isCompact_closedBall`. Strictly more general, strictly simpler to prove.

**There is no induction in this milestone, and saying so is the pass's main structural finding.**
The space is the *finite edge set*; the local obligation is per-edge (`dist (q i) (q j) = 1`),
discharged uniformly by uniqueness of limits. No recursor, no measure, no `generalizing`. The
pass's work was therefore routing — finding the four library steps and *proving they fire* rather
than recalling that they should.

**All four resistance points were probed in a scratch file and cleared first try**, so the proof
is routing rather than invention:

| # | step | route, confirmed by elaboration |
|---|---|---|
| R1 | squeeze: `\|a n − 1\| ≤ b n`, `b n → 0` ⟹ `a n → 1` | `tendsto_iff_dist_tendsto_zero` + `squeeze_zero` + `Real.dist_eq` |
| R2 | componentwise limit out of the product | `((continuous_apply i).tendsto q).comp h` |
| R3 | pigeonhole: one graph recurring arbitrarily late | `Finite.exists_infinite_fiber` (`SimpleGraph.instFinite` supplies `Finite`), then `Set.infinite_coe_iff` + `Set.Infinite.exists_gt` |
| R4 | product of compacts, and enough first-countability for a subsequence | `isCompact_univ_pi` + `IsCompact.tendsto_subseq`; the instance chain `Fintype ι → Countable ι → FirstCountableTopology (ι → V)` is found automatically |

**Method note, and it is the house rule paying out twice in one hour:** `squeeze_zero` did not
appear in the first grep and does exist — *a failed search is not an absence*. Both it and the
compactness route were settled by making the elaborator answer, not by recalling.

**The skeleton elaborates.** All four signatures type-check with every instance resolved, four
`sorry`s and no other diagnostic, before a single line of proof was written.

## §B — The Lean skeleton (spec elaborates before any proof effort)

New module `Proofs/HadwigerNelson/Limit.lean`, importing `UnitDistance` and Mathlib's topology.
The existing API already carries everything downstream of the realization, so **the entire new
content is one existence lemma**; the plane corollary is a two-line composition with
`add_one_le_chromaticNumber_unitDistance`.

```lean
variable {V ι : Type*} [MetricSpace V] [Fintype ι]

/-- **The limit of approximate drawings.** If a finite graph can be drawn inside one fixed ball
with every edge's length within `ε` of 1, for *every* `ε > 0`, then it can be drawn there with
every edge's length exactly 1. -/
theorem exists_unitDist_drawing_of_approx {G : SimpleGraph ι} {K : Set V} (hK : IsCompact K)
    (h : ∀ ε > 0, ∃ z : ι → V, (∀ i, z i ∈ K) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε) :
    ∃ q : ι → V, ∀ i j, G.Adj i j → dist (q i) (q j) = 1 := sorry

/-- **The limit lemma.** A fixed finite non-`k`-colourable graph, drawable in a bounded region
with edge lengths approaching 1, forces the whole space past `k` colours. -/
theorem add_one_le_chromaticNumber_of_approx {G : SimpleGraph ι} {k : ℕ} (c : V) (D : ℝ)
    (h : ∀ ε > 0, ∃ z : ι → V, (∀ i, z i ∈ Metric.closedBall c D) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε)
    (hG : ¬ G.Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance V).chromaticNumber := sorry

/-- **The headline (D3).** A family of non-`k`-colourable graphs on a *bounded vertex count*,
drawable in a fixed region at every tolerance, forces the bound — the graph may differ per
tolerance, which is what makes this a statement about `ν` rather than about one witness. -/
theorem add_one_le_chromaticNumber_of_bounded_family {k N : ℕ} (c : V) (D : ℝ)
    (h : ∀ ε > 0, ∃ (G : SimpleGraph (Fin N)) (z : Fin N → V),
          ¬ G.Colorable k ∧ (∀ i, z i ∈ Metric.closedBall c D) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance V).chromaticNumber := sorry

/-- The plane instance: `ν` bounded as the tolerance shrinks forces seven colours. -/
theorem seven_le_chromaticNumber_plane_of_bounded_family {N : ℕ} (c : ℂ) (D : ℝ)
    (h : ∀ ε > 0, ∃ (G : SimpleGraph (Fin N)) (z : Fin N → ℂ),
          ¬ G.Colorable 6 ∧ (∀ i, z i ∈ Metric.closedBall c D) ∧
          ∀ i j, G.Adj i j → |dist (z i) (z j) - 1| ≤ ε) :
    (7 : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := sorry
```

**Spec validation, per the standing rule that a `∀` over an empty domain proves everything.**
Three `example`s, each a model of the hypotheses, because the whole statement is a `∀ ε` and a
vacuous one would elaborate and prove nothing:

1. **Exact** — an equilateral triangle of side 1, the same drawing for every `ε`, recovering
   `χ(ℝ²) ≥ 3`. Confirms the hypotheses are inhabitable at all.
2. **Genuinely approximate** — a triangle of side `1 + ε/2`, a *different* drawing per `ε` and
   never an exact one, so the tolerance is doing real work and the theorem is not silently the
   exact case. This is the `example` that would fail if the statement had accidentally demanded
   one fixed drawing.
3. **Red** — a drawing family whose edges sit at length `2` for every `ε`: the hypothesis is
   unsatisfiable for `ε < 1`, so no bound follows. Stated as `¬ (∀ ε > 0, …)` and proven, so the
   red is a theorem rather than an absence of a proof.

---

## §C–§F — The phases (tools-side; desktop, 32 cores)

**Parallelism plan.** Every solver ask is an independent single-threaded `cadical` run.
Phases 1–3 fan out at **28 concurrent workers** (leaving two cores for the shell and one for
headroom), each capped by `systemd-run --scope -p MemoryMax=3G` per worker — SAT at these sizes
peaks in the tens of MB, so 28 × 3 GB is a backstop three orders above the expectation and
nowhere near the 125 GB the box has. Phase 4's optimizer is pure float work and fans out at 30.
Nothing here goes near the memory regime that has taken this machine down; the hazard in this
milestone is wall-clock, not RAM.

* **§C / phase 1 — comparability (the confound removal).** For each of the five recorded bands,
  bisect on the ball radius to find the **minimal** `R*` that refutes six colours, under one
  encoding, one cap, one symmetry-breaking choice; then shrink to a 1-minimal core with necessity
  witnesses. Record `(T, p, R*, N*, physical diameter, ω, orbit profile)`. Green control 2 must
  fire here. **Gate: if the re-measured five do not reproduce the qualitative shape of §0d, the
  headline observation is retracted in §R and the ladder is re-scoped to a plain `N(p)` census.**
* **§D / phase 2 — the embedding gradient (the milestone's spine, per §0′.1).** Measure `defect(H)`
  for every certified non-6-colourable graph in the inventory — the re-derived cell cores, and
  also the **kernel-checked 23-vertex core**, which belongs on the curve for free and which the
  pre-pass organization could not have spoken about. Optimize a smooth surrogate (sum of squared
  edge errors, then a softmax sharpening) from many random restarts — embarrassingly parallel,
  30 workers — and then **report the exact ℓ∞ error of the drawing actually found**, never the
  surrogate's value: the reported number must be a true "all edges within this of 1" figure, and
  it is an **upper** bound on `defect`, since local optimization cannot certify a minimum. Controls
  per §0g.3 both ways. Each object contributes one point `(defect upper bound, |V|)`; the lower
  envelope of those points is the `ν` curve, and it is the milestone's headline object.
* **§E / phase 3 — the ladder.** New rungs below `p ≈ 0.109`, as far as the solver reaches,
  same procedure, each new core feeding phase 2. The twelve deep-tail bands M43 left undecided at
  cap sit on this ladder and get a second, better-aimed attempt as a by-product — reported as
  such, never as the point.
* **§F / phase 4 — the interval side, kept separate (the `δ` line).** `δ(p)` per band exactly, in
  rational arithmetic, with the δ-maximizing scale found per band (P4) — `canonical_T` optimizes
  smallest denominator and therefore nothing, and the subplanning measurement already found a 7×
  miss. This section states one claim only: the widest explicit interval around 1 for which we
  hold a finite certificate that cell-constant colourings need seven. **It is not part of the
  `defect`/`ν` line and shares no axis with it** (§0′.2); it exists because it sharpens the
  conditional bridge to the literature, and it is reported under its own heading with its own
  scope clause.

---

## §0″ — What the experience-modeling pass changed (2026-08-13)

Four changes, each from a consumer whose seat I sat in rather than from taste.

1. **The Lean names broke the family they belong to, and now continue it.** `UnitDistance.lean`
   already owns `lt_chromaticNumber_unitDistance`, `add_one_le_chromaticNumber_unitDistance`,
   `..._edgeList` — head, then one suffix naming what is supplied. My first names dropped
   `unitDistance` from the head, so a user who knows the family could not predict them. Fixed:
   `add_one_le_chromaticNumber_unitDistance_of_approx` and `..._of_bounded_family`.
2. **`emb` is renamed `defect` — the unit-distance defect of a graph.** `emb` reads as
   "embedding", and the number is not an embedding: it is the *error of the best one*. Someone
   would read "emb = 0.15" as a property of a drawing rather than as a distance-from-perfect, and
   the misreading is silent. `defect(H) = 0` iff `H` is a unit-distance graph says exactly what it
   means. Since the name is entering the project's permanent vocabulary, it is worth the edit now.
3. **The bound direction moves into the identifier, and the two axes move into two files.** The
   JSON field is `defect_upper`, never `defect` — a reader cannot treat it as a minimum without
   typing a name that contradicts them, which is stronger than any comment. And the `δ` rows go to
   a **separate artifact** (`build/m44-interval.json`) rather than sharing a file with a
   `tolerance_kind` discriminator: a field can be ignored, a second file must be opened
   deliberately. The `bound_direction` field the earlier pass added is consequently **deleted** —
   it is now redundant with the field name, and one unrequested byte is the author's frame
   creeping back.
4. **The asymmetry gets stated in the schema, because it is the misreading that will actually
   happen.** A *small* `defect_upper` is a hard fact — an exhibited drawing achieves it. A *large*
   one says nothing at all; it may only mean the optimizer did not find the good drawing. So a row
   licenses "this graph is close to being a unit-distance graph" and never licenses "this graph is
   far from one". The schema line says so in those words, and the row carries **the drawing
   itself**, so the number is re-checkable without re-running the search (the house rule: the
   artifact is the certificate, never the search).

Also settled here: the three `example`s in the Lean file double as **templates** — the second one
supplies the full hypothesis with a genuinely different drawing at each tolerance, which is the
shape a real caller must produce — and the module docstring records the three frictions a caller
hits (the `abs_le` conversion, that the vertex count is a bound so padding with isolated vertices
is free, and that the converse is true, trivial, and deliberately not formalized so its absence
is not mistaken for difficulty).

## Deliverables

1. `Proofs/HadwigerNelson/Limit.lean` — the limit lemma (D2), the bounded-family headline (D3)
   and its plane instance, kernel-checked on axioms exactly
   `[propext, Classical.choice, Quot.sound]`, with the three spec examples and the planted red.
2. `tools/celllat.py` — `minimal_radius` (bisection for `R*`), `delta_of`, `best_scale_in_band`,
   and the M44 campaign driver, each with a planted self-test in `self_test44`.
3. `tools/embed.py` — the defect-gradient instrument (the milestone's spine) with its red and
   green controls, reporting exact ℓ∞ error of found drawings as upper bounds on `defect`.
4. `build/m44-dial.json` — the `defect`/`ν` line only: every row schema-tagged, the measured
   field named `defect_upper`, each row carrying the drawing that achieves it.
   `build/m44-interval.json` — the `δ` line only, physically separate so the two axes cannot be
   plotted together by accident.
5. `plans/M44-epsilon-dial.md` §R — the results, the predictions scored, the retractions if any.
6. CLAUDE.md § Frontier + § Grokkings updated in the closing commit (WORKFLOW step 9).

## The honest prior, restated at subplan time

The measurement will almost certainly show `ν` diverging, which proves nothing and refutes
nothing. Its value is that the divergence is now *the named obstruction* rather than an
unexamined background fact, that the rate is data nobody has, and that phase 4 turns "how far are
we from a 7-forcing unit-distance graph" from a rhetorical question into a number. The one
outcome that would change the milestone's character is P6 firing, which is why it has a halt
clause even at 3% prior.
