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

## §0 — Registration (committed BEFORE any instrument runs; the standing discipline)

### 0a. The two tolerances, which are NOT the same number (fixed here so nothing conflates them)

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

**Registered confusion-guard:** any row, plot, or sentence produced by this milestone states
which of `δ` and `η` it uses. A claim about the interval problem that cites `η`, or a claim
about our own witnesses that cites `δ`, is a bug and the campaign driver refuses to record it.

### 0b. The definition the milestone is organized around

> **`ν(ε)` := the least number of points in a finite planar configuration carrying a graph whose
> every edge has length within `ε` of 1, and which is not 6-colourable.**

`ν` is non-increasing in `ε` (a larger tolerance is a weaker constraint), and — this is §A's D2 —
**`χ(ℝ²) ≥ 7` if and only if `ν` stays bounded as `ε ↓ 0`.** Our refutations produce explicit
*upper* bounds `ν(η(p)) ≤ N(p)`. Everything measured below is an upper bound on `ν` at an
explicit rational tolerance; nothing here lower-bounds `ν`, and no row may say otherwise.

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

### D2 — the limit lemma (the new content)

> Let `G` be a fixed finite graph that is not `k`-colourable. Suppose for each `n` there is a
> drawing `z_n : V → ℂ` with all points in a bounded region and every edge's length within `ε_n`
> of 1, where `ε_n → 0`. **Then the plane's unit-distance graph is not `k`-colourable**, i.e.
> `χ(ℝ²) ≥ k + 1`.

Proof. The drawings live in a product of closed balls, which is compact because `V` is finite, so
some subsequence converges pointwise to a drawing `q`. For an edge `uv`, the distance
`dist(z_n u, z_n v)` converges to `dist(q u, q v)` by continuity, and is within `ε_n → 0` of 1, so
`dist(q u, q v) = 1` exactly. Now `q` is a map sending every edge to a unit-distance pair, so it
is a homomorphism into the plane's unit-distance graph, and a `k`-colouring of the plane would
pull back to a `k`-colouring of `G`. ∎

**The collision subtlety, handled by not needing to handle it:** two vertices may converge to the
same point. The proof never asks `q` to be injective — it pulls a colouring *back* along `q` —
and adjacent vertices cannot collide anyway, since their limiting distance is 1.

**Corollary (the milestone's headline statement).** `ν` is bounded as `ε ↓ 0` **iff**
`χ(ℝ²) ≥ 7`. Equivalently: **the divergence of `ν(ε)` as `ε → 0` is a necessary condition for
`χ(ℝ²) ≤ 6`.** (⇐ is D2 applied along a bounded subsequence, using that there are finitely many
graphs on a bounded vertex count so one recurs infinitely often; ⇒ is D1 applied to a
7-forcing unit-distance graph, which has `ε = 0`.)

**Attribution, stated plainly and up front:** D2 is a compactness argument that any specialist
would produce on request, and no novelty is claimed for it. What this milestone contributes is
the formalization, the identification of the cell family as a computable source of upper bounds
on `ν`, and the measurement of those bounds — none of which exists anywhere in the record.

---

## §B — The Lean skeleton (spec elaborates before any proof effort)

New module `Proofs/HadwigerNelson/Limit.lean`, importing `UnitDistance` and Mathlib's topology.
The existing API already carries everything downstream of the realization, so **the entire new
content is one existence lemma**; the plane corollary is a two-line composition with
`add_one_le_chromaticNumber_unitDistance`.

```lean
/-- The limit of approximate drawings. -/
theorem exists_unitDist_drawing_of_approx
    {ι : Type*} [Fintype ι] {G : SimpleGraph ι} (D : ℝ)
    (ε : ℕ → ℝ) (hε : Filter.Tendsto ε Filter.atTop (nhds 0))
    (z : ℕ → ι → ℂ) (hbd : ∀ n i, ‖z n i‖ ≤ D)
    (hlen : ∀ n i j, G.Adj i j → |dist (z n i) (z n j) - 1| ≤ ε n) :
    ∃ q : ι → ℂ, ∀ i j, G.Adj i j → dist (q i) (q j) = 1 := sorry

/-- **The limit lemma.** A fixed finite non-`k`-colourable graph, drawable in a bounded region
with edge lengths tending to 1, forces the plane past `k` colours. -/
theorem add_one_le_chromaticNumber_plane_of_approx
    {ι : Type*} [Fintype ι] {G : SimpleGraph ι} {k : ℕ} (D : ℝ)
    (ε : ℕ → ℝ) (hε : Filter.Tendsto ε Filter.atTop (nhds 0))
    (z : ℕ → ι → ℂ) (hbd : ∀ n i, ‖z n i‖ ≤ D)
    (hlen : ∀ n i j, G.Adj i j → |dist (z n i) (z n j) - 1| ≤ ε n)
    (hG : ¬ G.Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := sorry
```

**Spec validation, per the standing rule that a `∀` over an empty domain proves everything:**
two `example`s exhibiting models of the hypotheses — an exact equilateral triangle (`ε ≡ 0`,
recovering `χ(ℝ²) ≥ 3`), and a genuinely approximate sequence (a triangle of side `1 + 1/(n+1)`,
so the tolerance is doing work and the theorem is not silently the exact case). A third
`example` planting a **red**: the same statement with `ε ≡ 1/2` constant must NOT be provable by
this route, confirmed by the absence of a `Tendsto` hypothesis discharge.

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
* **§D / phase 2 — the exact tolerances.** `δ(p)` and `η(p)` per band, exactly, in rational
  arithmetic, with the δ-maximizing scale found per band (P4). Cheap, pure arithmetic, no solver.
  Deliverable: every band's certificate re-stated at its **best** scale rather than at
  `canonical_T`, which optimizes smallest denominator and therefore nothing.
* **§E / phase 3 — the ladder.** New rungs below `p ≈ 0.109`, as far as the solver reaches,
  same procedure. The twelve deep-tail bands M43 left undecided at cap sit on this ladder and get
  a second, better-aimed attempt as a by-product — reported as such, never as the point.
* **§F / phase 4 — the embedding gradient (the new instrument).** For a finite graph `H`, define
  `emb(H)` = the least, over drawings of `H` in the plane, of the largest deviation of an edge
  length from 1. Then `emb(H) = 0` exactly when `H` is a unit-distance graph, our cores satisfy
  `emb ≤ η(p)` by D1, and **`emb` is a continuous measure of how close a certified
  non-6-colourable graph is to settling the top of the problem.** Minimize by
  Levenberg–Marquardt on the soft-max of edge errors with many random restarts (embarrassingly
  parallel across restarts), controls per §0g.3, and report the best value found as an **upper**
  bound on `emb` — never as the minimum, which local optimization cannot certify. This is the
  first continuous distance-to-target meter this project has had; every previous meter was binary
  and read flat.

---

## Deliverables

1. `Proofs/HadwigerNelson/Limit.lean` — the limit lemma, kernel-checked, on axioms exactly
   `[propext, Classical.choice, Quot.sound]`, with its spec examples and its planted red.
2. `tools/celllat.py` — `delta_of`, `eta_of`, `best_scale_in_band`, `minimal_radius` (bisection),
   and the M44 campaign driver, each with a planted self-test in `self_test44`.
3. `tools/embed.py` — the embedding-gradient instrument with its red/green controls.
4. `build/m44-dial.json` — every row, schema-tagged, with `tolerance_kind` on every row per §0a.
5. `plans/M44-epsilon-dial.md` §R — the results, the predictions scored, the retractions if any.
6. CLAUDE.md § Frontier + § Grokkings updated in the closing commit (WORKFLOW step 9).

## The honest prior, restated at subplan time

The measurement will almost certainly show `ν` diverging, which proves nothing and refutes
nothing. Its value is that the divergence is now *the named obstruction* rather than an
unexamined background fact, that the rate is data nobody has, and that phase 4 turns "how far are
we from a 7-forcing unit-distance graph" from a rhetorical question into a number. The one
outcome that would change the milestone's character is P6 firing, which is why it has a halt
clause even at 3% prior.
