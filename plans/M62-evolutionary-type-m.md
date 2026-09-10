# M62 — the evolutionary type-M search

*Minted 2026-09-09 on Kooshi's go ("we're going to find the world record 5 chromatic graph … it's a
rehearsal for the real hunt"). Numbering note: FS-6 had been chosen as M62 at the M61 close; the
milestone that RUNS first takes the number, so **FS-6 becomes M63** and this is M62. FS-6 is this
milestone's sequel by design — same search, one colour up, over a 5-sealed field.*

**Mission in one line.** Beat 509 — the smallest known 5-chromatic unit-distance graph — with an
evolutionary search whose genome, feasibility filter, and fitness are all derived from this
project's own theorems rather than from geometry-blind mutation.

---

## §PA — Prior art (WORKFLOW step 3a, run BEFORE any derivation)

*Searched 2026-09-09 in four vocabularies: the combinatorics one ("unit-distance graph chromatic
number minimization"), the ML one ("reinforcement learning constructions extremal combinatorics"),
the crossover ("machine learning Hadwiger–Nelson"), and the record itself. Result: **the gate
changed the milestone's shape twice.** Below, and every item is a blocking read, not a queue entry
(G50).*

### PA1. The record is 509 and it is NOT a symmetric spindle — my earlier arithmetic was wrong

`[Parts2020a]` (arXiv:2010.12665, **held and re-read here today, §§3–5 and 6**) — 509 vertices,
2442 edges, still standing as of `[Haugland2026]`. Confirmed by search 2026-09-09.

The construction is **`G = L ∪ ρS`**: a large subgraph `L` and a **small** one `S`, differing about
threefold, rotated by `ρ` about **one shared vertex**. Heule's 553 was 420 + 134; his 529 was
393 + 137; Parts's 509 reduced `L` to **375** and barely touched `S`.

**So the naive "spindle a forcer, pay 2n − 1" arithmetic I gave Kooshi in conversation is the wrong
cost model, and the 255-vertex target it produced is wrong.** The right model is asymmetric:
`|L| + |S| − 1`. Beating 509 means beating **375 + 135**, and Parts's own text says where the slack
is (below, PA3).

### PA2. Type M's cross-edge structure is classified, and two open questions are posed in print

Parts §4 classifies all known 5-chromatic families by construction (types A, M, J, T). **Type M is
the record type**, and its cross edges come in exactly two kinds:

| kind | endpoints | orbit | filling |
|---|---|---|---|
| **reference** | at Euclidean distance **2** from the rotation centre | `(0,4,4,0)`, 12 vertices | **always full** |
| **auxiliary** | at distances **`√11/2 ± √3/6`** from the centre | `(0,0,2,6)`, 12 vertices | may be partial |

The auxiliary count names the subtype: **M3** (three aux edges — enough only for the large
symmetric `L ∪ ρL`), **M6A / M6B / M6C** (six aux edges; *exactly three* configurations exist up to
symmetry), **M10** (Heule 553), **M12** (full). Heule's 529 is M6A.

Two questions are posed verbatim and neither is answered:

1. *"The question arises, which subtype leads to the smallest 5-chromatic graph?"* — and Parts adds
   that **"subtypes M6B and M6C received much less attention, and it can be expected that the
   results will slightly converge."** This is a **finite** question: five subtypes.
2. *"Working constructions of type M with other rotations are not known yet."* — every type-M graph
   ever built uses `ρ`, the Moser twist. **Nobody knows a second rotation that works.**

Also stated: *"the existence of triangles of the second kind is essential"* (unlike type A) — i.e.
the auxiliary edges are load-bearing and he does not say why.

### PA3. Parts's method, and where our advantage actually is

His method is **not** a one-off construction; it is a tuned parallel search:
alternating **reduction** (delete vertices; prune by the observation that a vertex whose deletion
loses the property is in every solution) and **expansion** (add whole **orbits** of the order-24
symmetry group), with an "output symmetry" order dialled 24 → 6 → 3 → 2 → 1 as it converges.

**Any claim that we are doing something new must be measured against this, not against
"nobody has searched".** What is genuinely ours:

| his | ours |
|---|---|
| Mathematica 10, laptop, **4 cores / 6 GB**; ~10 s per unsatisfiability check; **100 laptop-hours to find 509 from scratch** | 32-core desktop (256-core server available), six years of solver progress |
| Orbits of one fixed base graph, one fixed rotation `ρ` | The **whole field plane `K²`** — rank 8, where every published construction lives in the rank-4 Moser lattice (`[MatolcsiEtAl2025]`, `[Ducz2026]`) |
| Cross-edge kinds found empirically; other rotations unknown | **The quadrature law (G12)** — derived a priori at M31, verified at 26 exact censuses, kernel-checked at `ρ₁₅` — says *which* radius pairs can carry a unit chord to a detuned copy, for *any* rotation |
| No arithmetic filter on distances | **The 2-adic law** (ledger row 59, kernel, 2026-09-09) — which distances can carry a four-colour mono-pair at all |

**Honest reading: the compute advantage alone is ~100× and is not by itself interesting. The
milestone is worth running because of the second and third rows** — we can ask his open question 2
(other rotations) with a theorem instead of a search.

### PA4. Machine learning on this problem — occupied on the other side, and NOT in our bibliography

- **`[Wagner2021]`** arXiv:2104.14516, *Constructions in combinatorics via neural networks* — the
  deep cross-entropy method for finding combinatorial constructions; the founding reference for
  this milestone's genre. Follow-ups: arXiv:2403.18429, arXiv:2406.12667, arXiv:2306.07956
  (nested Monte-Carlo / NRPA, "refuting conjectures within seconds").
- **`[MundingerEtAl2025]`** arXiv:2501.18527, *Neural Discovery in Mathematics: Do Machines Dream
  of Colored Planes?*, **ICML 2025** — neural networks on **Hadwiger–Nelson itself**, finding two
  novel six-colourings, *"the first improvement in thirty years to the off-diagonal variant"*.

**This is the closest ML-on-our-problem prior art in existence and it was not in `BIBLIOGRAPHY.md`.**
It works the **upper bound** — differentiable relaxation to *find colourings*. We work the **lower
bound** — search for *graphs*. Complementary, and the abstract makes no lower-bound claim; but the
paper must be obtained and read before any write-up, and §PA of the write-up must state the split.
**Neither of us knew this existed forty minutes ago.**

### PA5. What was searched and found nothing

No evolutionary/genetic search for unit-distance graphs of given chromatic number; no ML applied to
the lower-bound side; no search over type-M rotations. Recorded as a negative per G21 — the
enumeration is the four vocabularies above, and absence here is weak evidence, not proof.

---

## §0 — Derivations before any code (G30/G46: the search must only produce the theory's instances)

### §0a. Does the quadrature law reproduce Parts's two cross-edge kinds? **[blocking]**

G12 says a unit chord between a point at radius `t` and a point of a `W`-rotated copy at radius `r`
exists only on an explicit conic — `t² + r² − 2 Re(W)·(±tr) = 1` (anchor-collinear, `W` an even
half-spindle word) or the `Im` form (perpendicular, `W` odd). Parts's two kinds are a
`(t, r) = (2, 2)` family and a `(√11/2 + √3/6, √11/2 − √3/6)` family, both at `W = ρ`.

**A first arithmetic attempt here did NOT close** (`t = r = 2` with `Re ρ = 5/6` gives `4/3`, not
`1`; the same substitution with `Re = 7/8` — i.e. `ρ₁₅` — gives exactly `1`). Three live readings,
and settling which is the milestone's opening obligation:

1. Parts's "distance 2 from the centre" means something other than the radius I assumed.
2. The relevant `W` is a half-spindle word (`√ρ₁₅`, `η = √ρ`), not `ρ` itself — G8's half-spindle
   group is exactly the group in which the 1581's directions close, and `η² = ρ` was verified
   numerically on 2026-09-09.
3. The conic's sign/branch convention differs from the one I applied.

**This must close before the search is designed**, because if the law does reproduce his two kinds,
it *predicts the admissible cross-edge radii for every other rotation* — which is his open question
2, answered by derivation. Half a day. If it cannot be made to close, the milestone falls back to
the search-only plan and says so.

### §0b. Which rotations are admissible at all?

Compose: (i) the base must lie in `K` (Theorem B — so the base is 4-colourable and the rotation is
what buys the fifth colour); (ii) a four-colour mono-pair needs `v_𝔭(d) > 0` (ledger row 59); (iii)
the spindle radicand `4d² − 1` must leave `K` (G48 — automatic, and worth re-deriving as a check);
(iv) G12's conic must have solutions on *both* an in-lattice reference family and an auxiliary one
(Parts: the second kind is essential). Output: **a finite, enumerable candidate list of rotations**,
each with its predicted admissible radius pairs. This list is the search's outer loop.

### §0c. Is gauge-zero reachable at four colours in `K`? **[blocking, half a day]**

M57 records that at four colours *every `K`-chunk beyond the rhombus is Kempe-open* **by a rank
argument** — one `ζ₆`-orbit per residue, so `Λ_c` has rank ≤ 3. If that argument covers general
`K`-points and not just three-ladder material, **`γ = 0` is unreachable by theorem and any
termination condition built on it never fires.** Settle the scope of the rank argument before it
is wired into a loop. (This is why the fitness below is not `γ`.)

### §0d. The fitness, derived rather than chosen

The property to preserve is *non-4-colourability of `L ∪ ρS`*. A Boolean gives a genetic algorithm
no gradient, so the fitness is the **number of proper 4-colourings, capped** — zero is the target,
small is close, and it is exactly the quantity measured against the free algebraic score this
morning (Spearman 0.75, 92 % of decided pairs, and the free score never misses a forced pair
because `F_true ⊆ F_K` is a theorem). Two-stage by construction:

| stage | cost | role |
|---|---|---|
| algebraic score (free) | ms | reject; **admissible** — a theorem says it never discards a winner |
| capped colouring count | seconds | rank the survivors |
| certified refutation | minutes | only on candidates that reach zero |

`γ`'s **Kempe part** (total minus the loose part) survives as a tiebreak; its **loose part** is a
degree statistic in disguise and is used only to drive density in generation 1.

---

## §1 — Phases

- **A. Derivations §0a–§0d.** No code. Gate: §0a closes or the milestone is re-scoped in writing.
- **B. The genome and the generator.** Orbit-filling representation over a base graph with its
  symmetry group, plus the rotation. Glue-point generation (`Glue.sphere_inter_sphere`, kernel) with
  the exact in-field test — **not** random walks, which produce trees.
- **C. The engine.** Population, the four structure-preserving operators, geometric crossover,
  parallel evaluation. Rust where the inner loop is hot; Python for orchestration.
- **D. The run.** Desktop first; server on measured need.
- **E. Certification.** Any find goes through the existing certified pipeline (exact geometry in the
  tower, LRAT, kernel replay) — a record claimed on an uncertified SAT verdict is not a record here.

## §2 — Registered predictions (scored at the close, met or missed, with numbers)

- **P1.** §0a closes: the quadrature law reproduces both of Parts's cross-edge kinds. *Confidence
  medium — my first substitution failed and reading 2 is a guess.*
- **P2.** §0b yields **at least one** admissible rotation other than `ρ`. *Confidence low-medium;
  this is Parts's open question and a negative is publishable-adjacent in its own right.*
- **P3.** The free algebraic score's rank correlation with the capped colouring count on THIS
  milestone's objects is ≥ 0.6. *Confidence medium — measured 0.75 today on a different family.*
- **P4.** We reach ≤ 509 vertices. *Confidence LOW. Parts spent 100 laptop-hours and a tuned method;
  our edge is compute and arithmetic, not search craft.*
- **P5.** M6B or M6C beats M6A at equal effort. *Confidence low — but Parts says both are
  under-explored, so this is the cheapest place a record could be hiding.*
- **P6.** `γ = 0` is unreachable in `K` at four colours (§0c). *Confidence medium-high.*

## §3 — Failure clauses (pre-committed, per G30)

- If §0a does not close, the derivation half is reported **not landed**, and the milestone continues
  as a pure search with its advantage restated honestly as compute.
- If the search plateaus above 509, that is reported as a plateau **with its vertex count and CPU
  cost**, never as "further progress is possible".
- A negative on P2 (no second rotation) is a **finding**, is reported as one, and answers a question
  posed in print.
- Any 5-chromatic find is not a result until certified; an uncertified verdict is a candidate.

## §4 — Deliverables

Tools under `tools/`; data under `data/m62/`; the Lean consumer for a certified find; a
`BIBLIOGRAPHY.md` pass adding `[Wagner2021]`, `[MundingerEtAl2025]` and the RL follow-ups; and
this file's §R with every prediction scored.

---

## §M1 — Domain modeling pass (`debruijn-domain-modeling`, 2026-09-09)

### §M1.0 — §0a IS CLOSED, and P1 is MET. The coupling constant is `7/8`, not the Moser twist.

The skill's first instruction is to externalize at the tripwire rather than head-simulate, and the
tripwire was already tripped once (the subplan records a failed substitution). Externalized twice —
against the paper's arithmetic, then **decorrelated against the object itself**.

**Against the arithmetic.** Parts's auxiliary radii `√11/2 ± √3/6` square to **`(17 ± √33)/6`** with
product **`8/3`** — which is, character for character, M31's **conjugate-ring channel**, derived a
priori in the M31 subplan on 2026-08-10 and verified at 26 exact censuses. M31's quadrature conic
`t² + r² − 2·Re(W)·tr = 1` returns **exactly 1** for *both* of Parts's families at `Re(W) = 7/8`,
and returns `4/3` and `11/9` at `Re(ρ) = 5/6`.

**Against the object** (`tools/heule510.json`, exact field-16 coordinates, centre = vertex 0):

| | measured on Heule-510 | Parts §4 says | conic at `Re = 7/8` |
|---|---|---|---|
| vertices at `r² = 4` | **24** (= 12 per copy) | reference orbit `(0,4,4,0)`, 12, *always full* | — |
| vertices at `r² = (17±√33)/6` | **9 and 9** | auxiliary orbit `(0,0,2,6)`, 12, *may be partial* | — |
| ref–ref edges | **12** | reference edges | `= 1` ✓ |
| aux+ – aux− edges | **6** | auxiliary edges, "connected crosswise" | `= 1` ✓ |
| aux+ – aux+ | **0** | — | `0.948` ✗ |
| aux− – aux− | **0** | — | `0.469` ✗ |

Every cross edge of the object sits at `cos θ = 7/8` at the centre, and the conic **selects exactly
the two families that occur and rejects the two that do not.** Six auxiliary edges — subtype M6,
matching Parts's classification of the Heule lineage.

**`7/8 = Re(ρ₁₅)`**, the distance-2 spindle rotation, which this project has carried since M31.
Parts writes *"the rotation multiplier is ρ"*; whatever his `ρ` denotes, the coupling invariant of
the record's own construction is `7/8`, and **the quadrature law is the general form of a fact he
states as an observation and calls essential without explaining.**

**Why this is the milestone's lever.** His open question — *"working constructions of type M with
other rotations are not known yet"* — becomes computable: for a coupling constant `c`, the
admissible cross-edge families are the base-lattice radius pairs on `t² + r² − 2c·tr = 1`, in
closed form, **before any graph is built.**

### §M1.1 — Theorem B pins the rotation. It is a constraint, not an obstacle.

The candidate obstruction: if the rotation lies in the norm-one group of `K(i)`, the whole object
stays in `K²` and **Theorem B makes it 4-colourable** — the search would be hunting an object our
own kernel forbids. Checked: Heule-510 carries `√5` (G27), and `ρ₁₅` adjoins `√15 = √3·√5`. So the
rotation *must* leave `K`, exactly as the 2-adic wall requires, and the constraint is sharp:

> **The rotation is a norm-one element of `K(i)(√w)` for a wall-breaking `w`, its real part is
> rational, and that real part must admit at least two radius families in the base lattice** —
> Parts: *"the existence of triangles of the second kind is essential."*

**This also kills the milestone's worst adversarial member for free.** A candidate could satisfy the
letter (not 4-colourable) while violating the intent (`L` alone is already 5-chromatic, the cross
edges doing nothing). **Theorem B makes that unrepresentable**: `L ⊆ K²` is always 4-colourable, so
every find's fifth colour is necessarily bought by the coupling. No guard needed; the theorem is
the guard.

### §M1.2 — The genome: a bitset pair over a fixed base lattice. Points are never moved.

The tension in the pass's brief resolves to **orbit-structured subsets of a fixed lattice**, and the
record-holder says so himself: *"The orbit-filling tables are usually more informative than the
graph image, and allow one to compare different graphs and to devise directions of further attack."*

The intrinsic structure is a **selection**, not a placement:

```
Base       B     : a finite G-closed set of K-points, computed once   (immutable, shared)
           E_int : all unit pairs inside B                            (immutable, shared)
           E_cross(ρ) : all (u,v) with |u − ρv| = 1                   (immutable per rotation)
Candidate  (L, S) : two bitsets over B, both containing the centre
Graph      V = L ⊔ ρS with the centre identified
           E = E_int|_L  ∪  E_int|_S  ∪  E_cross ∩ (L × S)
```

**`S`'s internal edges are `E_int`, the same table, because `ρ` is an isometry.** Three fixed tables
and two bitmasks are the whole object.

What this representation deletes, which is the measure of its rightness:

| ugliness in the conversational plan | why it is gone |
|---|---|
| "move a point to a nearby location in K" severs every unit edge | there is no *nearby* — only *a different orbit member*. Every candidate is a valid unit-distance graph in the base by construction |
| random walks generate trees | the base's edges are precomputed; a selection inherits them |
| 50/50 point crossover leaves two disconnected halves | crossover is a bitwise mix on a **shared** index set — the halves are already registered to each other |
| the 1 % in-field glue-point hit rate | paid once, when `B` is built, not per mutation |
| unit-distance validity as a per-candidate check | an invariant of the base; a candidate cannot express an invalid graph |

**The rotation is NOT a gene.** `E_cross` changes discontinuously with `ρ`, so crossover between
rotations is meaningless; `ρ` indexes independent runs (§0b's finite candidate list is the
experiment design). This is the intrinsic/incidental cut applied: the rotation is not a coordinate
of the search space, it is the space's identity.

### §M1.3 — Placement cut: everything extrinsic, and the reason

`UDCert` already exists and its validity **decides**; the LRAT chain already turns a refutation into
`¬ Colorable 4`. So a certified find needs **no new Lean type** — the candidate is a bitmask in the
untrusted searcher and a certificate at the boundary, which is *parse, don't validate* with the
parse already written (M05/M06). Two statements are wanted and one is new:

- `¬ (graph).Colorable 4` — existing pipeline, exact geometry + LRAT.
- `chromaticNumber = 5` **exactly** — the upper half via `colorable_succ_of_colorable_delete`
  (FS-28's one-line find, which gave `χ(Heule-553) = 5`). A record claimed without it is a lower
  bound wearing an equality.

### §M1.4 — Seam checks (the skill's non-vacuity discipline)

| member | expected | status |
|---|---|---|
| empty candidate (`L = S = {centre}`) | one vertex, 4-colourable, worst fitness | must not crash the scorer |
| full candidate (`L = S = B`) | **the seed the search starts from** — Parts reduces from a large graph; if the full base is 4-colourable the base is too poor and the run is vacuous | **blocking pre-run check per rotation** |
| `L` alone | 4-colourable **by Theorem B** | free adversary exclusion (§M1.1) |
| a rotation with one radius family | should fail — Parts says the second kind is essential | negative control for §0b |

**The full-base check is the non-vacuity gate for the whole milestone** and it is one SAT call per
rotation: a base whose *entire* selection is 4-colourable contains no find, and every generation
spent on it is measuring the base rather than the problem.

---

## §M2 — Obligation modeling pass (`debruijn-obligation-modeling`, 2026-09-09)

### §M2.1 — §0b made finite: vote, then filter by Theorem B. **The naive objective is backwards.**

The chord condition, written algebraically rather than angularly (`u, v ∈ K² ≅ K(i)`, `ρ` norm-one):

> `|u − ρv|² = 1  ⟺  Re(ρ · ū v) = (|u|² + |v|² − 1)/2`

For a **fixed pair** `(u, v)` this is a line meeting the unit circle: **at most two rotations make any
given pair adjacent.** So the candidate rotations are enumerable by *voting* — scan `B × B`, solve the
quadratic, tally — a Hough transform over the base lattice. `O(|B|²)`, embarrassingly parallel, and
**the tally is `|E_cross(ρ)|`, so the enumeration and the precomputation §M1.2 needs are one
computation.** That is the convergence signal this pass looks for.

Run twice, and each run corrected the design:

**(i) On Heule-510 — measured the wrong population (G21).** 47,755 candidate rotations, but the top
votes are the lattice's own `±60°, ±120°, 180°` symmetries, because the 510-point set **already is**
`L ∪ ρS`. A rotation vote over a finished object recovers its symmetry group, not its construction.

**(ii) On a fresh Moser-lattice ball** (873 points, 4,702 unit edges, radius 2.05 — the literature's
own base, `ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩`): 135,833 candidate rotations, and the top non-symmetry hits sit at
`cos = ±√33/6 ≈ ±0.957427`, `±0.728714`, `±0.228714`. **`7/8` — the record's own coupling constant —
is nowhere near the top.**

That is not a defect in the enumeration; it is the objective being **anti-correlated with the goal**,
and the reason is a theorem we already own:

> A rotation that creates the *most* cross edges is one that nearly preserves the base lattice.
> Preserving the lattice means lying in the norm-one group of `K(i)`. Lying there keeps the whole
> union inside `K²`. **And Theorem B four-colours everything in `K²`.**

Checked: `cos = √33/6` has `sin = √3/6`, both in `K` — the top-voted rotations are *exactly* the
useless ones. `ρ₁₅ = (7 + i√15)/8` scores low precisely because `√15 ∉ K`, so it carries the base
into a different lattice and only sparse coincidences survive. **Maximal coupling is a symptom of
staying inside the wall.**

**So the enumeration's obligation order is fixed, and the order is the content:**

| step | rule | licence |
|---|---|---|
| 1 | vote over `B × B`, exact arithmetic | completeness of the pair scan |
| 2 | **reject every `ρ` with `Re ρ, Im ρ ∈ K`** | Theorem B — the union would be 4-colourable |
| 3 | keep `ρ` whose surviving cross edges fall in **≥ 2 radius families** | Parts: *"the existence of triangles of the second kind is essential"* |
| 4 | prefer wall-breaking radicands (`≡ 5, 7 mod 8`) | the 2-adic law, ledger row 59 |
| 5 | rank the survivors — **not by raw vote count** | step 2's finding |

Steps 2–4 are three of our own theorems used as a *sieve on the search space* rather than as
commentary, which is what "combining CS and our math" has to mean if it means anything.

### §M2.2 — The free pre-filter, derived rather than borrowed

The conversational plan proposed the algebraic forced-pair predictor (`F_true ⊆ F_K`) as the
admissible filter. **Wrong target here**: the property is *non-4-colourability*, not *has a forced
pair*. The right filter falls out of Theorem B instead:

> `L ⊆ K²` and `S ⊆ K²`, so **each carries the residue 4-colouring**. Compose them across the
> rotation and test all 24 palette permutations against `E_cross`. If any is proper, the object is
> 4-colourable — **rejected, with an exhibited colouring.**

Cost: `24 × |E_cross|` integer comparisons, no solver. **Admissible in the strongest sense — it does
not estimate, it produces a witness**, so it cannot discard a winner. Widenable for free to all
additive 4-colourings of each side (M56 found eight on one object). Obligation: **none new in Lean**
— a rejection is never reported as a result, and the properness check is verified in the tool against
a planted control.

### §M2.3 — Lean-side obligations for a certified find

| half | obligation | status |
|---|---|---|
| `¬ Colorable 4` | exact geometry (`UDCert.valid`, decides) + LRAT replay | **exists**, M05/M06 |
| `Colorable 5` | a colour table + properness by `decide` over the edge list | routine |
| `chromaticNumber = 5` | `le_antisymm` of the two | **wanted as a named helper** — M09 did this ad hoc for de Grey; a record claimed without the upper half is a lower bound wearing an equality |

Nothing else is new. The searcher is untrusted; the certificate is the boundary, which is
*parse, don't validate* with the parser already written.

### §M2.4 — Measures, so the loops terminate by construction

- **Local (memetic) step:** greedy vertex deletion preserving non-4-colourability — `|L| + |S|`
  strictly decreases, so it terminates; this is Parts's own reduction stage, and his pruning rule
  (*a vertex whose deletion loses the property is in every solution*) is the criticality argument
  already in `CriticalSet.lean`.
- **Outer GA:** stochastic, no monotone measure; bounded by generation count and **reported as
  bounded**, never as converged.
- **Enumeration:** `|B|²`, finite.

### §M2.5 — §0c is DEMOTED from blocking to optional

*Decision, four parts.* **Choice:** stop treating "is gauge-zero reachable in `K` at four colours"
as a gate. **Alternative weighed:** keep it blocking, costing half a day before any code.
**Why:** §0d already replaced the gauge as the fitness and §M2.2 replaced it as the filter, so
nothing in the loop can hang on the answer; the rank argument would only tell us how constrained
`K`-fabric's colourings are, which is background. **Confidence:** high — if any later phase reaches
for the gauge, the question returns as blocking at that moment. *P6 stays registered and will be
scored if the question is answered in passing.*

### §M2.6 — Adversarial validation registered for the enumeration

Per the skill's mutation discipline, each of these must be **seen to fire** before any run is believed:

- plant a pair whose solving rotation is irrational / outside every candidate field → must be rejected
  by the exact disposal (the float-propose/exact-dispose seam is where a spurious rotation enters);
- plant `ρ ∈ K(i)` norm-one → must be rejected at step 2, and the object it builds must be
  4-colourable by the residue filter, **both**;
- plant a rotation with exactly one radius family → must be rejected at step 3;
- **the base non-vacuity gate**: the full base at the chosen `ρ` must refuse 4 colours, or the run is
  measuring the base and not the problem (§M1.4).

---

## §M3 — Experience modeling pass (`debruijn-experience-modeling`, 2026-09-09)

*Three consumers, and what each actually holds when the surface reaches them.*

### §M3.1 — The verdict vocabulary, and the one distinction the tool must be unable to blur

The milestone's whole risk is one word. A solver returning UNSAT is **not a find**; it is a
candidate. The verdicts:

| verdict | means | may it accompany a vertex-count claim? |
|---|---|---|
| `FOUR-COLOURED` | a proper 4-colouring was **exhibited** (residue filter or solver model) — a certificate of *not a find*, and it carries the colouring | n/a |
| `REFUSED-4` | the solver returned UNSAT | **NO** |
| `CERTIFIED` | exact geometry decided + LRAT replayed + a verified 5-colouring | **yes, and only this** |
| `UNDECIDED-AT-CAP` | the cap was reached — not a negative, not a positive | no |
| `VACUOUS-BASE` | the **full** base at this rotation is 4-colourable, so no selection from it can be a find | no |
| `REJECTED-IN-K` | the rotation lies in `K(i)`; Theorem B four-colours anything it builds | no |

Following *parse, don't validate*: **the record-claim formatter accepts only a `Certified` value, and
only the Lean-acceptance path constructs one.** A `REFUSED-4` cannot be formatted into a record
sentence because the type does not permit it — not because the author remembered. No verdict word
means "clean", and every count is printed with its enumeration in the *same sentence* (G21's third
instance: scope lines inside an artifact do not survive into summaries).

### §M3.2 — The progress line: what separates working from stalled

The naive line (`gen 47  best 612`) is a number with no reference — it cannot distinguish a search
that is converging from one that died twenty generations ago. What Kooshi holds at that moment is a
terminal and no memory of generation 27, so the line carries the **derivative and the diversity**:

```
gen  47 | best 612 v (flat 19 gen) | feasible 34/200 | div 0.61 | 1420 asks, 2.1 s mean | control OK
```

- **`flat 19 gen`** — generations since the best improved. The single most informative number on the
  line; a rising flat count is the honest signal that the run is finished whatever the budget says.
- **`feasible 34/200`** — how many individuals refuse four colours. **Zero means the population is
  wandering in 4-colourable space and the size objective is meaningless there**; that is a different
  failure from a plateau and must look different.
- **`div`** — genome diversity. Collapse means restart, regardless of generations remaining.
- **`control OK`** — see §M3.4. A run whose live control is failing must say so on every line.

### §M3.3 — Fingerprints, so "same object?" is a comparison and not a memory

Every artifact carries a **base fingerprint** (hash of the exact sorted point list *and* the edge
list), an **exact rotation** (its algebraic representation, never a float), and a **candidate
fingerprint** (the two bitsets plus the base fingerprint). A tool handed an artifact whose base
fingerprint does not match the base it has loaded **refuses**, and does not silently proceed — the
M52 incident (an M06-era vertex order against the standing loader, caught only by a control) is the
recorded reason.

### §M3.4 — The live control, because a broken fitness looks exactly like a working search

This milestone's most dangerous failure is silent: a search that runs, reports generations, and is
optimizing the wrong thing looks identical to one that works. The defence is the rule G21 earned
three times this session — *point every instrument at a known positive before believing any zero*:

> **Seed the population with a known 5-chromatic object expressed in the genome** (Heule-510, when
> the base contains it) and re-check every generation that the scorer ranks it feasible. If the
> known winner is not ranked feasible, **the fitness is broken and the run must halt loudly**, not
> print another generation line.

This is a control that runs *continuously*, not once at startup, because the failure it guards
against can arrive mid-run with a cache eviction or a base edit.

### §M3.5 — The checkpoint contract

The standing rule's audit question — *if this process dies at any instant, what does the relaunch
redo?* — answered in the design rather than discovered at the loss (the M51 incident: 19 hours lost
because the state lived in a parent process):

- Checkpointed every generation: **the population, the RNG state, the generation counter, and the
  evaluation cache** (solver verdicts keyed by candidate fingerprint).
- The evaluation cache is the expensive object and is persisted separately, append-only.
- **Answer: at most one generation of work, and zero solver calls** — every prior verdict is a cache
  hit keyed by a fingerprint that survives the restart.
- Resume is *exact*: the RNG state is part of the checkpoint, so a resumed run continues the same
  sequence rather than a statistically-similar one.

### §M3.6 — What the artifact must say for a reader with no memory of this session

Self-describing or it is not an artifact: `kind`; `base {fingerprint, n, edges, radius, generators}`;
`rotation {exact, cos, in_K, radicand, wall_breaking}`; `run {seed, generations, population, every
cap}`; the results; and `claim_scope` — the house field, carrying **what was not explored**, because
a count without its enumeration is the failure mode this repository has recorded five times.

---

## §M4 — Ferrous domain modeling pass (data structures, 2026-09-09)

### §M4.1 — The collapse: one mask, not two, and "which side" becomes an index

The de Bruijn pass left a candidate as *two* subsets `(L, S)`. Carried into code that is a case
analysis at every use — which block is this vertex in, which table do I consult. The collapse:

> Index the candidate on a **fixed `2|B|`-vertex space** — `L` at `0..|B|`, `S` at `|B|..2|B|` — and
> precompute, **once per rotation**, a single immutable bit-matrix whose three blocks are
> `(L,L) = adj_int`, `(S,S) = adj_int` *(the same table — the rotation is an isometry)*, and
> `(L,S) = adj_cross`.

Then **a candidate is one `2|B|`-bit mask** and its induced graph is `adj[v] & present`. The L/S
distinction is incidental — it is *which copy* — and it survives only as an index range. This is the
"N structures identical modulo naming" cure: the role is named, the copies are demoted.

```rust
pub struct Arena {                    // immutable, shared, one per (base, rotation)
    pub n: usize,                     // 2|B|
    pub adj: Vec<Bits>,               // 2|B| rows, block structure above
    pub valid: Bits,                  // trailing-bit mask; every constructor ANDs with it
    pub orbit_mask: Vec<Bits>,        // one mask per symmetry orbit -> orbit flip is ONE bitop
    pub orbit_of: Vec<u16>,
    pub fp: [u8; 16],                 // base+rotation fingerprint (exact, not float-derived)
}
pub type Bits = [u64; W];             // W fixed, not generic
#[derive(Clone, Copy)] pub struct Cand(pub Bits);   // Copy: mutation and crossover allocate NOTHING
```

**The centre is L-side only** and bit `|B|` is permanently unset. No special case follows: the centre
sits at the origin, so `adj_cross[0] = { v : |v| = 1 }` falls out of the same table as everything
else. One invariant, stated once, rather than a branch in the hot loop.

**`W` is fixed, not a const generic.** We will not vary it enough to pay for a parameter threading
through every signature — the skill's own injunction against speculative structure. At `W = 64`
(4096 bits) a candidate is 512 bytes, a population of 200 is 100 KB, and the matrix is ~2 MB: L2/L3
resident, shared read-only across every thread.

### §M4.2 — Adjacency bitsets, not edge lists, and the reason is the consumer

The tables could be `Vec<(u16,u16)>` and restriction a filter. Rejected: **the consumer is a
colouring algorithm, which wants neighbourhoods, not pairs.** DSATUR's inner question is "which
colours appear in `N(v)`", and with bitset adjacency that is `adj[v] & colour_class[c]` plus a
popcount — the representation *is* the algorithm's question. An edge list would be re-derived into
this on every evaluation.

### §M4.3 — The fingerprint trap, which is a real Rust trap and not a style note

The experience pass requires fingerprints **stable across process restarts**. Rust's default
`HashMap` hasher is **randomly seeded per process**, so the obvious implementation produces a cache
that silently misses everything after a restart — a checkpoint contract that appears to work, costs
nothing to violate, and shows up only as "why is the resumed run slow".

- **Persisted key: BLAKE3-128 of the candidate's raw bytes plus the arena fingerprint.** Deterministic
  by construction.
- In-memory map: `FxHashMap` keyed on the same 16 bytes — fast and irrelevant to persistence.
- The cache is an **append-only log** of `(key, verdict, cost)`, replayed on start. Crash-safe by
  construction rather than by flushing discipline.

### §M4.4 — Seam validation (the skill's unsampled-member discipline)

| member | realistic? | must do |
|---|---|---|
| `|B|` not a multiple of 64 | **yes, generically** | `valid` mask on every constructor, or popcount lies about the vertex count |
| symmetry group of order 1 | **yes — Parts dials output symmetry down to 1 at convergence** | orbit flip degenerates to bit flip; must work, not divide by zero |
| `E_cross` empty | yes, for most rotations | two disjoint `K`-graphs, both 4-colourable — caught by the base non-vacuity gate, never by a crash |
| `L` empty | yes, under mutation | fitness and diversity must be defined |

### §M4.5 — Next-feature test: does this earn FS-6 (the 5 → 6 milestone) for free?

Yes, and that is the strongest evidence the model is intrinsic rather than fitted to this milestone.
FS-6 wants the same search one colour up over a 5-sealed field: **the genome, the arena, the
operators and the cache are unchanged**; the colour count is a parameter and the field lives in the
base construction. Nothing in this representation knows it is working at four colours.

---

## §M5 — Ferrous execution modeling pass (parallelism and invariants, 2026-09-09)

### §M5.1 — The invariant that resolves "exact resume" against "full parallelism"

The two hard constraints look opposed. They are not, and one sentence separates them:

> **Evaluating a candidate is a pure function of `(arena, candidate, budget)`.**

So determinism belongs to the *decisions*, and freedom belongs to the *schedule*. Each generation is
three phases with the serialization exactly where the dependencies already force it:

| phase | order | parallel? |
|---|---|---|
| **breed** — `(population, RNG state) → next genomes` | deterministic, pure bit-ops, no evaluation | no, and it costs microseconds |
| **evaluate** — `genomes → verdicts` | **an antichain — genomes are independent** | fully, work-stealing |
| **select** — `(genomes, verdicts) → survivors` | deterministic, **total order with fingerprint tie-break** so equal fitness still orders stably | no |

**Invariant I3 (determinism):** the population at generation `g` is a function of `(seed, g, arena)`.
**Checked, not assumed** — each checkpoint stores a population digest, and a resumed run recomputes
it and compares. "Exact resume" becomes a comparison rather than a hope.

### §M5.2 — The heterogeneity constraint, and the trap inside the obvious fix

Constraint (2) says a generation must not block on one candidate, so the obvious fix is a wall-clock
timeout. **That breaks I3**: a candidate that times out on one machine and finishes on another makes
the population diverge, and the divergence is silent.

> **Budget in solver conflicts, not seconds.** A conflict limit is machine-independent and, with the
> solver version pinned (the toolchain ships `cadical`), makes `UNDECIDED-AT-CAP` a *stable verdict
> at that budget* rather than a property of the afternoon.

The budget is therefore part of the cache key `(candidate fp, arena fp, budget)` — **invariant I4**:
a verdict computed under one budget is never silently reused under another.

The heterogeneity then mostly evaporates for a second reason: the residue-composition filter and the
greedy pass are microseconds, so only a handful of each generation's candidates ever reach the
solver. The generation's makespan is bounded by the *budget*, not by the sum over the population.

### §M5.3 — The shrink phase, designed around M52's measured wall rather than into it

WO-14 measured that accepted deletions are sequential whatever the worker count — a refutation
against a stale snapshot licenses nothing — at two minutes per drop on twelve workers. The named
repair was chunking; here it is the design from the start:

- **Propose a chunk of `k` deletions and test the chunk in one call.** UNSAT accepts all `k`; SAT
  bisects. That is delta-debugging (`ddmin`), turning `n` sequential asks into `O(k log n)`, and the
  M49/M50 parallel-ddmin implementation already exists.
- **Disjoint chunks are independent**, so proposals parallelize even though *commits* serialize.
- **Measure:** `|present|` strictly decreases per accepted chunk, so the phase terminates — the local
  obligation, named, rather than "it obviously finishes".

### §M5.4 — Coordination placed where the dependencies already force it

The one shared mutable object is the evaluation cache. Rather than locking it on the hot path:

- workers **read** from an immutable snapshot taken at the generation barrier;
- new verdicts go to a lock-free append queue;
- the queue is **merged at the barrier** — the serialization point that `breed`/`select` already
  require.

No lock is added anywhere the dependency order did not already have one, which is this pass's whole
standard.

### §M5.5 — The invariants, each with how it is checked

| # | invariant | checked by |
|---|---|---|
| I1 | centre bit set, S-side centre bit clear, `present ⊆ valid` | `debug_assert` on construction; mask test at each generation barrier |
| I2 | **elitism** — best feasible size never worsens | asserted at `select`; a violation is a selection bug, not noise |
| I3 | population digest is a function of `(seed, g)` | recomputed and compared on every resume (§M5.1) |
| I4 | a cached verdict is reused only at matching `(cand, arena, budget)` | the key *is* the triple; a mismatch is a miss |
| I5 | the live control ranks feasible **every generation** | §M3.4 — halts loudly, does not warn |
| I6 | **evaluation is pure** — the same key twice gives the same verdict | with small probability, re-evaluate a cached key and compare. A few percent of cost, and it is the only thing that would catch solver nondeterminism or a corrupted cache before they silently poison every downstream generation |

I6 is the one that would not have been written without this pass. Every other invariant guards a
mistake; I6 guards the *assumption the other five rest on*.

### §M5.6 — Termination, stated rather than assumed

Shrink terminates on a strictly decreasing `|present|`. The rotation enumeration is `|B|²`, finite.
**The GA has no monotone measure** — it is stochastic, bounded by generation count, and will be
**reported as bounded, never as converged** (§3's failure clause).

---

## §R — Results (running; phases B–E NOT run)

### §R1 — Phase A CLOSED. §0a met, §0b delivered. `tools/typem.py`, `data/m62/`.

**P1 MET.** M31's quadrature law reproduces both of Parts's cross-edge kinds, exactly (§M1.0), and
the object confirms it independently of the paper (12 reference + 6 auxiliary cross edges on
Heule-510, all at `cos = 7/8`, with the conic accepting exactly those two families and rejecting the
two that do not occur).

**§0b delivered as an exact enumeration.** The sieve needs **no floating point in any verdict**: for
radii `|u|² , |v|²` the rotation adjoins `√D` with `D = |u|²|v|² − k²`, `k = (|u|²+|v|²−1)/2`, all in
`K`, and the three outcomes are decided by an exact tower squareness test —

| outcome | meaning |
|---|---|
| `D < 0` | the radius pair admits no rotation |
| `D` a square in `K` | the rotation lies in `K(i)`, the union stays in `K²`, **Theorem B four-colours it** |
| else | the rotation adjoins `√D` and leaves `K` — a candidate |

**Measured** (Moser lattice, radius 2.05, span 4 — 873 points, 4,702 exact unit edges, 87 distinct
squared radii; 46 s):

- 762,129 radius pairs → **125,232 REJECTED-IN-K by Theorem B**, 123,785 admitting no rotation.
- 2,042 raw radicands → **1,336 rotation classes** after merging by square class.
- **412 of the 1,336 are type-M admissible** (≥ 2 radius families — Parts's *"the existence of
  triangles of the second kind is essential"*). Max families in any class: **31**.
- **The record's own rotation is in the enumeration and carries both of its known kinds**: the
  `√15` class contains Parts's reference family `(4, 4)` **and** his auxiliary family
  `((17±√33)/6)`, both confirmed `True`, and **ranks 58th of 1,336 by family count.**

**So Parts's stated open question — *"Working constructions of type M with other rotations are not
known yet"* — now has an enumerable candidate list where it had none: 411 other admissible rotation
classes on this base alone, 57 of them richer in cross-edge kinds than the one every published
construction uses.** Whether any yields a 5-chromatic object is the search (phases B–E); the
**candidate list is the derivation**, and it costs 46 seconds.

**A second, sharper lead fell out.** The record's rotation has **seven** radius families and Parts
uses **two**. His subtypes M3/M6A/M6B/M6C/M10/M12 enumerate how many *auxiliary* edges are used —
i.e. how much of the **second** kind. He never considers a **third**. Five unused cross-edge kinds
sit at the very rotation the record is built on, and the two he uses are the two smallest-radius
ones. That is a concrete, cheap direction independent of the whole evolutionary apparatus.

**Two corrections made in flight, both by controls:**
1. **Grouping by radicand splits rotations.** `15/4` (reference) and `5/3` (auxiliary) differ by
   `(3/2)²`, so they are ONE rotation — which is *why* a single rotation realises both of Parts's
   kinds. Grouping by `D` alone undercounts exactly the quantity Parts calls essential; the sieve
   merges by square class, `2042 → 1336`.
2. **A control caught a wrong expectation of mine, not a bug.** The Moser lattice's origin has
   **18** unit neighbours, not 6 — three direction families × six hex rotations, which is T13's
   ladder structure (ledger row 46). The assertion now carries the measured number and the reason.

**Registered honestly:** `--self-test` is green (24 controls, including the planted Theorem-B
rejection and the exact reproduction of `ρ₁₅`'s radicand from the reference family). The count
**412 is a property of THIS base's radius spectrum and does not transfer** to another base — the
`claim_scope` field in the artifact says so. Admissibility is **necessary and not sufficient**: no
claim is made that any listed rotation yields a 5-chromatic graph.

### §R2 — Not run

Phases **B** (genome and generator), **C** (the engine), **D** (the run) and **E** (certification)
are **not run**. Predictions P2–P6 are unscored. No search has been executed and no candidate
5-chromatic object exists; the record stands at 509.

### §R3 — Phase B: the arena, and a base correction the gate caught before any search ran

**The cross-edge law, derived exactly and confirmed on the record's own object.** For
`ρ₁₅ = (7 + i√15)/8`, writing `ū v = p + iq` with `p, q ∈ K`, the condition `Re(ρ · ū v) = k'`
splits over `K(√15)`: the `√15`-part forces **`q = 0` — the two points are collinear with the
centre** — and the `K`-part forces `p = 4(|u|² + |v|² − 1)/7`. **Verified on Heule-510: all 18 of
its cross edges subtend exactly `arccos(7/8)` at the centre**, i.e. every pre-image pair is
collinear, to nine decimals. This is M31's quadrature law's *anchor-collinear* clause, on the
record's lineage. No floating point in the test.

**The base was wrong, and the non-vacuity gate caught it in 0 seconds on the first real run.**
Building the arena over the **Moser lattice** `ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩` (the literature's own name for
our direction ladder, and the natural first guess) gave `k = 4` **SAT** on the full selection —
`VACUOUS-BASE`, and since a subgraph of a 4-colourable graph is 4-colourable, **no selection from it
could ever have been a find.** A search would have run indefinitely against a wall we could prove.

Diagnosed rather than guessed: **only 90 of Heule-510's 510 points lie in the Moser lattice at any
radius.** The record's lineage descends from Heule's `G2167 = ⊕⁸ C_{1/3}`, where `C_{1/3}` is the
radius-`1/3` hexagon together with the 90°-rotated hexagon of radius `(√3+√11)/6` — squared radius
`(7+√33)/18`, **a seam radius**. The base is the *seam* lattice, not the Moser lattice.

**Rebuilt, and the validation is exact:** the seam base at radius 2.5 contains **375** of
Heule-510's 510 points — and `[Parts2020a]` Table 2 records Heule-510's `L`-subgraph as **375
vertices**. The base contains the record's entire `K`-side, vertex for vertex. The other 135 are the
rotated `ρS` side, which is outside `K` by construction.

**The arena** (7,173 base points → **14,346 vertices**; 62,714 exact internal unit edges by
float-propose/exact-dispose; **126 cross edges** in exactly Parts's three families — 30 reference at
radius 2, 36 auxiliary at `(17±√33)/6`, 60 at the centre):

> **NON-VACUITY GATE: `k = 4` UNSAT in 18 seconds. The arena is 5-chromatic.** Reduction can start.

### §R4 — Phase C: the reduction, in flight

`typem.shrink` — Parts's reduction stage with adaptive chunk halving (his own "8-4-2-1"), designed
around M52's WO-14 measurement that accepted drops serialise whatever the worker count, so the width
goes into the **chunk** and not the worker count. Checkpointed every accepted drop
(`data/m62/shrink-ckpt.json`), so a crash redoes at most one ask.

Running at the time of writing: **14,345 → 12,552 vertices on its first ask (53 s).** The target is
509. **`REFUSED-4` is a candidate verdict and is not a find** (§M3.1); nothing is a record until the
exact geometry decides and an LRAT replay is kernel-checked.

### §R5 — An incident, recorded

`pkill -f "build_seam_base"` **killed its own shell** — the wrapper matched its own pattern. This is
a trap this project has a standing note about (anchor the pattern or use PIDs). No work was lost;
the background job it was meant to kill had already completed successfully. Recorded because the
note existed and was not consulted.
