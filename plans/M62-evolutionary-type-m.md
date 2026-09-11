# M62 — the evolutionary type-M search

*Minted 2026-09-09 on Kooshi's go ("we're going to find the world record 5 chromatic graph … it's a
rehearsal for the real hunt"). Numbering note: FS-6 had been chosen as M62 at the M61 close; the
milestone that RUNS first takes the number, so this is M62 and **FS-6 takes a later number** (M63 went to the Parts reproduction). FS-6 is this
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

### §R6 — The cost structure is INVERTED from the assumption, and it changed the algorithm

Calibrating the cheap filter against the solver (16 rows, arena at `ρ₁₅`) produced the milestone's
most useful measurement, and it refuted my own diagnosis of the stall:

| kept vertices | edges | greedy | solver | solver seconds |
|---|---|---|---|---|
| 400 / 800 / 1500 | 98 / 428 / 1345 | 4-coloured | SAT | 0.73 / 0.04 / 0.05 |
| 3000 / 6000 | 5452 / 21667 | *missed* | SAT | 0.07 / 0.72 |
| 10000 | 61440 | *missed* | **UNSAT** | **127.9** |

**The solver is fast on 4-colourable and slow on NOT-4-colourable.** I had assumed the opposite and
wired a greedy filter to catch the cheap case. So:

> **Deleting vertices pays the expensive verdict on every ACCEPTED drop; growing pays the cheap one
> on every rejected prefix and the expensive one only ~log₂(N) times.** Same answer, inverted cost.

Measured directly against each other on the same arena: the shrink managed **one** accepted drop in
53 s and then stalled for minutes; **binary search over a radius-ordered prefix converged in 14 asks
and 118 seconds** to the smallest refusing prefix, 9,167 vertices. This is Parts's *expansion* stage
standing in for his *reduction* stage — chosen from a measurement rather than from his write-up.

The greedy filter stays: it is sound (it exhibits a colouring, re-verified against the induced edge
list before it is believed) and it is free. It is simply not where the cost was.

### §R7 — Two defects in my own base, both found by controls rather than by inspection

**(1) The "seam lattice" is not a lattice.** Four generators spanning a **rank-4 ℤ-module in the
plane** is *dense*, so "all points in a ball" is infinite — measured as a point count that never
converges (7,173 → 9,243 → 11,537 → 14,077 → 16,921 as the coefficient box grew). This is why
Heule's base is a **bounded Minkowski sum** and not a ball, and I had not registered the distinction.

**(2) The coefficient box broke the symmetry, and the orbit builder caught it.** Truncating a
dense module by a box in generator coordinates plus a radius is **not rotation-invariant**, so the
arena had **zero** symmetry generators and 14,346 singleton orbits. The orbit builder reported that
as its own output rather than crashing, which is what made it visible.

**The repair, and it costs nothing:** take the **symmetric core** — the points whose entire orbit
under `⟨rot₆, conjugation⟩` is already present.

| | span-7 ball | symmetric core |
|---|---|---|
| points | 7,173 | **5,401** |
| Heule-510's `L`-side contained | 375 of 375 | **375 of 375 — nothing lost** |
| valid symmetry generators | 0 | **2** |
| orbits / vertices | 14,346 / 14,346 | **948 / 10,802 → 11.4× reduction** |
| `k = 4` on the full selection | UNSAT (18 s) | **UNSAT (16 s)** |

**Orbit-level growth on the symmetric core: 614 orbits, 6,925 vertices, 10 asks, 87 seconds.** The
orbit-level reduction is running from there.

**Honest reading of where this sits: 6,925 against a record of 509.** A radius-ordered prefix is a
ball, and the record is a sparse selection — the shape is wrong, and closing that gap is what the
remaining phases are for. Nothing here is a find; every verdict is `REFUSED-4`.

### §R8 — THE PATTERN ENGINE: Theorem B turned into a search principle

This is the part of M62 that is this project's rather than the record-holder's, and it falls straight
out of a theorem we already own.

**The derivation.** `L` and `S` are both drawn in `K`, so **by Theorem B neither half can ever be the
obstruction** — each is 4-colourable on its own, always. The fifth colour is therefore bought
*entirely* by the cross edges, of which the whole arena has 126 and the record uses 18, and those
touch only a few dozen vertices per side. So:

> `L ∪ ρS` refuses four colours **iff** every pattern `L` can impose on its cross-endpoints clashes,
> on some cross edge, with every pattern `S` can impose on its own.

**The consequence is that the two halves become independently optimisable**, and the inner loop
never colours the union.

**Measured, and it is the night's best number:** the **entire** 5,401-point `L` half admits only
**55 patterns** on its 30 reference cross-endpoints — 55 out of `4³⁰ ≈ 10¹⁸` — enumerated exactly in
**57 seconds**. The enumeration blocks *patterns*, not colourings, so it runs `|P|` times rather
than once per colouring, which is what makes it affordable. `[Heule2019]` reports the analogue for
his own object without deriving it: *"the large part limits the number of valid 4-colorings of 12
vertices at distance 2 from the origin to 19."*

**The acceptance test that follows, one solver call per proposal on a HALF-SIZE graph.** Dropping
vertices can only relax a half's problem, so its pattern set can only **grow**; a drop is safe
exactly when it admits no pattern outside the set we started with — and that CNF is the one the
pattern enumeration has already built. Sufficient, not necessary (the set may grow and still clash),
and taken because it makes the halves independent. `tools/m62_run.py`, parallel over proposals.

### §R9 — Parts's "essential second kind", confirmed and made symmetric

Parts writes that for type M, *"unlike graphs of type A, the existence of triangles of the second
kind is essential"* — an assertion about the auxiliary edges, with no measurement and no statement
about the first kind. Tested directly on the symmetric core, full base:

| cross edges used | `k = 4` |
|---|---|
| reference only (90) | **SAT** — 4-colourable |
| auxiliary only (96) | **SAT** — 4-colourable |
| both (126) | **UNSAT** — 5-chromatic |

**Neither kind suffices; both are necessary.** His claim is confirmed, and the symmetric half of it —
that the *reference* kind is equally essential — is measured here for the first time.

**And the subtype question is finite.** The cross edges fall into exactly **seven orbits** under
`⟨rot₆, conjugation⟩` (three reference: 6, 12, 12 edges; four auxiliary: 12, 6, 12, 6), so Parts's
second open question — *"which subtype leads to the smallest 5-chromatic graph?"* — is an
**exhaustive search over 127 subsets**, running.

### §R10 — Where this honestly stands, and one observability defect

**Best refusing object: ~5,200 vertices. The record is 509.** An order of magnitude out, and the
reduction is grinding — two accepted drops in eighteen minutes, because each accepted drop is the
expensive verdict (§R6).

**Defect in my own instrument, recorded**: the subtype census uses `Pool.map`, which returns
everything at once, so it emits **no progress at all** until all 127 finish — exactly the "you
cannot tell a working search from a stalled one" failure §M3.2 was written to prevent, in a tool
written after §M3.2. The census is being allowed to finish rather than restarted, but the pattern is
worth the note: the experience pass's rule was applied to the *engine* and not to the *scripts around
it*.

### §R11 — POROS REVIEW (2026-09-10): the acceptance test had the WRONG FIXED POINT, and the record's own half fails it

Kooshi offered a decorrelated advisor for exactly the situation G51 describes, and it found by
**reading the code** what no amount of running it would have shown. Full report:
`plans/POROS-2026-09-10-m62.md`.

**The defect.** `tools/m62_run.py` computes `P_L` and `P_S` **once, on the full arena, and never
updates them**; the accept branch fires only when a reduced half admits no pattern outside that
**fixed** set. Since removing vertices can only *grow* a pattern set, the invariant maintained
across the whole descent is

> `P_{L'} = P_L(the full 5,401-point arena)` — exactly.

So the fixed point is *"the smallest `L` still realising the whole arena's own 55 patterns"*, not
*"the smallest `L` that `S` still kills"*. `typem.clash` computes the right condition **and is never
called in the loop**. My own comment conceded the test was "sufficient and not necessary" — that
undersold it. It is a different fixed point.

**Confirmed, by pointing the instrument at a known positive (G21's own rule, applied to me):**

> **The acceptance test REJECTS Heule-510's own `L`, in 0 seconds.** The descent provably could not
> have reached even the known 510-vertex object, let alone 509.

The engine had not been launched, so no compute was lost — but the test would have run all night
measuring itself.

**The repair, which Poros also supplied and is now implemented** (`typem.kills_all_boxes`): the
exact condition is that `L` must block every **box** `Safe(q)` — for a pattern `q` that `S` can
impose, a colouring of `L` survives `q` when `colour(u) ≠ q[v]` on every cross edge, which is one
forbidden colour per endpoint, i.e. **unit clauses**. So

> `L ∪ ρS` is 4-colourable **iff** for some `q ∈ P_S`, `L` admits a colouring surviving `q`.

Acceptance is `|P_S|` independent solver calls on the `L`-only graph, and **a single SAT rejects
immediately** — which matches the measured cost structure (§R6), since rejections are the cheap
verdict. Poros's further suggestion, not yet implemented: each UNSAT's **unsat core** is a set of
`L`-vertices sufficient to block that box, so the minimum `L` is a **minimum hitting set over the
cores** — generating rather than filtering, which is what §M3 asked for and did not get.

### §R12 — Four more findings from the same review, three of them against me

**(1) G50 in its sharpest form yet: `[Parts2020a]` §2's notation line reads `ρ = exp(i arccos 7/8)`.**
§M1.0 spent an entire modelling pass deriving that constant and calling it a finding. It is in the
paper's *notation section*. My §PA re-read covered "§§3–5 and 6" and skipped §2. **The rule that
exists because of exactly this — read what the search already found — was applied to the sections I
chose and not to the paper.**

**(2) The base is in the paper in closed form, and §R7's three rebuilds recover a worse version.**
`[Parts2020a]` §5.6: `B = ⊕⁴H²`, orbits on a disk of radius 2, *"only about 400 such orbits, of which
about 40 are included in R"*, and *"all useful orbits satisfy the relation `abcd = 0`"* — with the
coordinates and the order-24 symmetry group given explicitly in §2. Our 948 orbits over 5,401 points
with two generators is a poorer version of a published construction.

**(3) Pure reduction is what his paper says twice is insufficient.** §5.8: *"the minimal asymmetric
graph is usually **not** a subgraph of the minimal symmetric graph"*; §6: *"none of the 376-vertex
graphs is an overgraph of any of the 375-vertex graphs"*. His method **alternates** expansion with
reduction over an accumulative graph precisely to escape the local minimum phases C/D sit in. He
also caps his own asks: §5.11, *"the number of vertices is limited to about 1000"* — ours ran at
5,191–14,346.

**(4) The problem is named and solved in another literature.** "Smallest vertex subset preserving
unsatisfiability" is **smallest-MUS extraction**; Parts's hyperedges are **minimal correction sets**
and his subset enumeration is **MUS/MCS hitting-set dualization** (Liffiton–Sakallah), and his
"8-4-2-1" is QuickXplain/delta-debugging. There is a dedicated algorithm (Ignatiev et al., CP 2015)
and a tool, `forqes`. **The cost asymmetry §R6 reports as a surprising refutation of my assumption
is stated in his §5.8** as a named accelerator: *"to get the result True it takes an order of
magnitude less time than to get the result False."*

**And one wind-egg called, correctly.** §R1 describes the 412-rotation list as "the derivation".
It is not one yet: admissibility is necessary and not sufficient, **nothing has consumed the list**
(one `print` at `typem.py:305` is its only reader), and the arena is hard-wired to `ρ₁₅` — the
rotation every published construction already uses. It may become the milestone's product; it is not
one now, and §R1's wording is corrected here rather than left standing. **What IS already a
derivation is smaller and better: the quadrature law explains which cross-edge families a type-M
rotation can carry and rejects the ones that do not occur** — the mechanism behind a fact the
record-holder states as an observation and calls essential.

### §R13 — The corrected engine, and two more defects the controls caught

**Incremental solving, controlled.** Every walled solver call wrote ~190k clauses to disk and
spawned `cadical`, and a pattern enumeration paid that once per pattern. `typem.patterns_inc` and
`kills_all_boxes_inc` build the CNF once and use one live solver — blocking clauses for enumeration,
**assumptions** for the box test. Controlled against the walled version on the known case:
**55 patterns, exact, both ways; 93 s → 13.7 s (7×).**

**Defect 3, caught by the full-`L` control**: the box test excluded the **centre** cross edges while
the arena includes them, so it reported a survivor where the census says the base refuses four
colours. The repair is not to add them as endpoints (that would take the endpoint set from 18 to 49
and blow up `|P_S|`) — the shared centre is in `L` and **pinned to one colour**, so those edges say
exactly *"no `S` point of unit radius takes that colour"*: **thirty unit clauses, not a pattern
dimension.** With that, `|P_S| = 160` exact in 5 s and the full-`L` control passes in 11 s.

**Defect 4, caught by re-reading my own driver**: it shrank **only `L`**, against a fixed full-size
`S` — so the total could never fall below `|S| = 5,401` however well `L` did. `tools/m62_descent.py`
alternates: characterise one half, shrink the other against it, swap, repeat, with the
current-half-blocks-all-boxes control asserted **before every round** (a failure exits rather than
descending).

**And a self-inflicted one worth recording because it happened FOUR times in one session**: killing
a background job by matching its command line (`pkill -f`, `ps | grep | kill`) **matches the killing
shell itself**, because the wrapper's command line contains the pattern. This project has a standing
note about exactly that trap. It cost one lost file append (`build_c13_base`, silently absent until
an `AttributeError`) and three dead shells. **Rule adopted: background jobs write a PID file at
launch and are killed by PID, never by pattern.**

### §R14 — Parts's own base, built from his §2, is VACUOUS at `ρ₁₅` under our cross-edge law

Read properly after Poros flagged that §2 had been skipped. His construction, verbatim: `H = H⁰ = W₇`
the **7-vertex hexagonal wheel**; `η = exp(i arccos 5/6)` the **Moser twist**;
`ρ = exp(i arccos 7/8)` — `ρ₁₅`, in his *notation line*; `H^m = ⋃_{a=−m..m} η^a H`; and the base
`B = ⊕ⁿ H^m`, his working choice `⊕⁴H²` on a disk of radius 2.

**Control passed: `|H²| = 31` exactly — de Grey's own V31.** So the reconstruction is faithful at
least that far. Built: 13,063 points, **82,782 exact unit edges**, 2,246 orbits (he reports "about
400", so my truncation is about threefold too generous), **186 cross edges at `ρ₁₅`**.

> **NON-VACUITY GATE: `k = 4` SAT in 209 s. Parts's base, as reconstructed, is 4-colourable** — so
> no selection from it can be 5-chromatic under our cross-edge law.

Recorded as a **negative, not hidden**. Two readings and I cannot yet separate them: my
reconstruction is wrong somewhere (the `h = ⌈m/2⌉` denominator, the radius convention, or the orbit
truncation — his 400 against my 2,246 says something is off by a factor), **or** his construction
attaches the two halves by cross edges our collinearity law does not describe. The law itself is
derived and was confirmed on Heule-510 to nine decimals (§R3), so the second reading would mean his
`L ∪ ρS` shares more than the centre. **Either way the seam base stands as the working one** — it
passes the gate, contains all 375 of Heule-510's in-field points, and is what the descent runs on.

### §R15 — The descent's real bottleneck was not what I twice guessed, and the diagnosis was one measurement

Two rewrites chased the wrong cost. The truth, measured directly:

- **A single-orbit drop is accepted in ~7.5 s, and 8 of 8 sampled drops were accepted.** The descent
  could always move; the chunk ladder simply started at `|live|/4 ≈ 118` orbits, which always fails,
  and burned 28 proposals × 160 solver calls per failed round.
- CNF construction was **not** the bottleneck either (0.09 s once the flat edge list replaced the
  bitset walk — kept, since it is free).
- So the loop is inverted: **census every single drop in parallel, then batch-verify the accepted set
  with bisection.** Running: `473` orbits, **50 censused in 91 s and all 50 droppable.**

**And the observability rule of §M3.2 was broken twice more, by me, in scripts written after it.**
`Pool.map` returns everything at once, so two consecutive drivers printed nothing for tens of minutes
while working correctly — indistinguishable from a wedge, and I twice diagnosed a stall that was not
there. `imap_unordered` with a running count fixed it. **The rule was written for the engine and
applied to nothing around it; that is the whole lesson.**

### §R16 — The night's overnight state, and a process-management failure recorded five times over

**Where the descent stands.** The exact-box descent, alternating both halves on the seam base at
subtype `(1, 5)`, completed its first census: **471 of 473 `L`-orbits are individually droppable**
(669 s on 28 cores, visible progress throughout). `L` is therefore massively over-provisioned, and
the batch bisection was running when the machine was cleared. Relaunched under `setsid` with its
process group recorded at `/tmp/ed4.pgid`; log `/tmp/m62ed4b.log`.

**The failure, recorded because it happened FIVE times in one session and each time cost work.**
Every attempt to stop a background job by matching its command line — `pkill -f`, `ps | grep | kill`,
and finally an ancestry walk that did not account for the `timeout` wrapper — **killed the killer**,
or killed jobs it meant to keep. The last instance took down the live descent and the baseline
together, thirty seconds after they were the only things running.

**Standing rule adopted, and it is mechanical rather than a resolution to be careful:**

> A long job is launched with `setsid`, writes **both its PID and its process-group id** to a file at
> startup, and is stopped **only** by `kill -TERM -$(cat …pgid)`. No pattern ever matches a command
> line. The wrapper is part of the job, so the group is the unit — not the PID, and never the name.

This project already had a memory note about the `pkill -f` self-match. A note was not enough; the
launch discipline is.

### §R17 — Three blockers stubbed (2026-09-10, Kooshi: *"stub all 3; I suspect we won't get anywhere until those are addressed"*)

M62 does not continue as a compute problem until these are settled. All three are ranked **1a/1b/1c**
in `plans/FRONTIER-STUBS.md`, ahead of everything, and each is written to be picked up by a session
with no memory of this one.

| | stub | in one line |
|---|---|---|
| **1a** | `plans/STUB-parts-base-reconciliation.md` | **2,246 orbits against his 400, and our reconstruction of his base is 4-colourable.** Either the truncation is wrong or the cross-edge law is incomplete — and if it is the law, *every measurement M62 made is on an arena missing edges*. Hours to settle. |
| **1b** | `plans/STUB-smus-reduction.md` | The reduction stage is **smallest-MUS extraction**, solved in another literature with a tool. Calibrate by reproducing Heule's 375 from his 393. If it lands, all that is left is the expansion stage — where our theorems are. |
| **1c** | `plans/STUB-consume-rotation-list.md` | **412 admissible rotations on disk, one `print` as their only reader**, and every arena hard-wired to the rotation the record is already optimal for. |

**The through-line, and it is why Kooshi is right that compute will not help yet.** M62 spent a night
optimising *inside* a frame it had not checked: one rotation (the published one), one base (my own
reconstruction, now suspect), and one search stage (the one Parts's paper says twice is
insufficient). Every genuine gain of the night came from **checking the frame** — Theorem B giving
the pattern decomposition, the exhaustive subtype census, the exact-box acceptance test — and every
wasted hour came from grinding inside it. **1a says whether the arena is even right; 1b says whether
the stage we are grinding is worth grinding; 1c says whether the rotation is.** None is a compute
question and all three are days at most.

**Still running at the time of writing** (`setsid`, group id at `/tmp/ed4.pgid`, log
`/tmp/m62ed4b.log`): the alternating exact-box descent on the seam base at subtype `(1,5)`. Its
first census reproduces — **471 of 473 `L`-orbits individually droppable** — and it is on the batch
bisection. Whatever it returns is a `REFUSED-4` candidate at ~5,000 vertices, not a find, and it
does not bear on the three blockers above.

### §R18 — FS-31 partly answered the same night: the law is complete, the base was not closed, and `abcd = 0` is not what I read it as

Four measurements, in the order they settle the stub's two readings.

**1. The cross-edge law is COMPLETE — reading (B) is refuted.** Heule-510 splits **375 in-field /
135 out**, matching `[Parts2020a]`'s own recorded `L`-size exactly. Of the **30** edges running
between the two halves, **all 30 are explained**: 18 at `cos = 7/8` and 12 incident to the shared
centre. **No cross edge exists that the collinearity law does not predict**, so no M62 arena is
missing edges and every measurement at `ρ₁₅` stands.

**2. Our base IS in Parts's coordinate system.** All **5,401 of 5,401** points are expressible as
`(a + b√33 + i(c√3 + d√11))/12`, and **all 5,401 satisfy his congruence `a − b + c + d ≡ 0 (mod 4)`.**
That is a strong, unlooked-for validation of a base I reconstructed by guesswork.

**3. `abcd = 0` is NOT "the product of the four coordinates", and the test that showed it is worth
keeping.** His sentence — *"all useful orbits satisfy the relation `abcd = 0`"* — is about **orbits**,
so the condition must be group-invariant. Applying it as a product: it keeps 1,509 of 5,401 points,
**breaks the gate** (`k = 4` SAT in 1 s), and **is not preserved by his own 120° rotation** (broken on
2,412 of 5,401), while it *is* preserved by both reflections and by conjugation. A condition that
survives three generators and dies on the fourth is a misreading, not a filter. Most likely it is a
condition on the orbit's **canonical representative** — he sorts orbit members *"by the number of
nonzero and negative elements"* — i.e. every useful orbit contains a point with a zero coordinate.
**Not pursued further; recorded so the next session does not re-derive the dead end.**

**4. The base was not closed under his group, and closing it is free improvement.** His generators,
derived from the geometry rather than transcribed from a garbled PDF table — 120° rotation, both
reflections, and conjugation by `√33` (`b ↦ −b`, `d ↦ −d`, from his own footnote) — test as:
**rot120, refl-vert and refl-horz all map our base into itself; conjugation by `√33` does not, and
1,734 points leave.** So our base carried a third of its mass outside his symmetry, which is exactly
what inflates an orbit count.

| | seam base | **closed under his order-24 group** |
|---|---|---|
| points | 5,401 | **3,667** |
| orbits (our `⟨rot₆, conj⟩`) | 948 | **650** |
| cross edges at `ρ₁₅` | 126 | **126 — unchanged** |
| `k = 4` on the full base | UNSAT (16 s) | **UNSAT (12 s)** |

**A third smaller, a third fewer orbits, the same cross-edge structure, still 5-chromatic, and every
solver call correspondingly cheaper.** Saved at `/tmp/p24_arena.pkl`; the descent restarts on it.
Still 650 orbits against his "about 400", so the reconciliation is improved and not finished — the
remaining factor is the open half of FS-31.

### §R19 — FS-31 CLOSED: his base is in his own §5.6, the vacuity was ours, and his two connecting orbits fall out of our law by name

The open half of FS-31 — *"650 orbits against his 'about 400', and the untried lever is the
representative reading of `abcd = 0`"* — is answered, and the answer was **four paragraphs of
`[Parts2020a]` §5.6 that §PA had not read.** `G50` a second time in one milestone: the paper was on
the shelf, the section was named in §R14's own source reading, and the search stopped at §2. His
words, verbatim:

> We used the base graph `B = ⊕⁴H²`, choosing orbits that fall completely or partially on a disk of
> radius `r = 2` […]. The corresponding base orbits `(a,b,c,d)` satisfy the relations
> `(a−b√33)² + (c√3−d√11)² ≤ (12r)²`, `a,b,c,d ∈ |2ℤ|`, `a−b+c+d ∈ 4ℤ`.
> There are only about 400 such orbits, of which about 40 are included in R. We noticed that all
> useful orbits satisfy the relation `abcd = 0`.

**Four readings, each DERIVED and then measured rather than guessed.**

**(1) The group is `⟨ζ₆⟩ ⋊ Gal(K/ℚ)`, order 24 — and complex conjugation is one of its Galois
elements.** On a point `z = (a + b√33 + i(c√3 + d√11))/12`, the automorphism `√3 ↦ −√3, √11 ↦ −√11`
fixes `√33`, so it fixes `x` and negates `y`: it *is* the geometric reflection. His "dihedral plus
conjugation by `√33`" is therefore `ζ₆` together with the two single-radical flips, and the two
extra elements are **arithmetic symmetries with no geometric meaning** — which is why an orbit's
members carry two squared norms, `n` and `σ(n)`, and why a Euclidean disk had looked
group-incompatible. Every element preserves unit distance (a ring hom fixing `ℚ`, applied
coordinatewise) **and the `ρ₁₅` cross-edge law** (both of its conditions are polynomial identities
over `K`), so the whole type-M arena is equivariant and orbit-level selection is sound.

**(2) `arena_orbits` was using half his group.** It acts by `⟨rot₆, conj⟩` — order 12 — which is
exactly the geometric half. **That is where "650" came from.** Under the full order-24 group the
same seam core has **188** orbits, with sizes `{1: 1, 6: 13, 12: 49, 24: 125}` — his stated orders
`1, 6, 12, 24`, reproduced on a base built with no knowledge of them.

**(3) `a, b, c, d ∈ |2ℤ|` cannot be a condition on every point, and what IS stable is derivable.**
`ζ₆` sends `(a,b,c,d)` to `((a−3c)/2, (b−d)/2, (a+c)/2, (d+3b)/2)`, so `a = 2, c = 0` has an odd
image: all-even is not preserved. Integrality forces `a ≡ c` and `b ≡ d (mod 2)`; the congruence's
image is `a+b−c+d`, which agrees with `a−b+c+d` mod 4 exactly when `b ≡ c (mod 2)` — so the stable
lattice condition is **`a ≡ b ≡ c ≡ d (mod 2)`** together with `a−b+c+d ≡ 0 (mod 4)`. With it the
radius-2 set is **exactly closed: zero images outside, measured over all 24 elements.** All-even is
therefore a condition on the orbit's canonical **representative** — which is what his orbit labels
are, and **all nineteen labels published in his paper are all-even and non-negative.**

**(4) `abcd = 0` is the same kind of condition, and on this base it is the same condition.** Of the
92 orbit representatives (his own sort: fewest nonzeros, then fewest negatives, then lex), **84 are
all-even and the *same* 84 satisfy `abcd = 0`** — his two stated relations coincide here. And **all
nineteen of his published labels have a zero coordinate, 19 for 19.** The pointwise reading stays
dead (§R18).

**The base, and the control that decides it.**

| | ours (§R18) | `⊕⁴H²` r=2, our §2 build | **his §5.6 lattice, r = 2** |
|---|---|---|---|
| points | 3,667 | 5,995 (symmetric core) | **1,603** |
| orbits (order-24) | 188 | 307 | **92** |
| orbit sizes | {1,6,12,24} | {1,6,12,24} | **{1: 1, 6: 11, 12: 32, 24: 48}** |
| images outside the base | 0 | 0 | **0** |
| his 19 labels as canonical reps | — | — | **18 / 19** |
| unit edges | 30,846 | 32,268 | **11,286** |
| cross edges at `ρ₁₅` | 126 | 186 | **126** |
| **`k = 4` on the full arena** | UNSAT | **SAT — vacuous** | **UNSAT, 10 s** |

**So §R14's vacuity verdict was ours, not his.** The base built from §2 is 4-colourable and admits
no 5-chromatic selection; the base his §5.6 relations describe refuses four colours on 3,206
vertices in ten seconds. **Reading (A) of FS-31 is confirmed and repaired; reading (B) — that our
cross-edge law does not describe his construction — stays refuted, and is now refuted against his
own object rather than against Heule's.**

**The nineteenth label is what decides the disk reading.** `(0,0,6,6)` has `|z|² = (7+√33)/2 ≈
6.37 > 4` and conjugate `(7−√33)/2 ≈ 0.63 < 4`, so it is admitted only by his "falls completely **or
partially** on a disk" clause. Read as *completely inside*, the count is **92**; read as *meets the
disk*, over `⊕⁸H¹` (105,889 points, group-closed, and the smallest construction here containing all
nineteen labels), it is **1,023**, of which 515 also satisfy `abcd = 0`. His "about 400" sits between
and the text does not decide which he used. **What the text does decide is that the base is not
vacuous, and that is the question FS-31 was minted by.**

**Our §2 reconstruction of `B` is wrong, and the control says so plainly:** `⊕⁴H²` — untruncated,
27,301 points, group-closed — **misses eight of his nineteen labels, including both connecting
orbits.** `⊕⁸H¹` contains all nineteen. So `parts_base`/`H_m` do not build his base graph, and are
now marked as such; the §5.6 relations do, and `typem.parts_lattice` is that.

**And the cross-edge structure comes out as his two kinds, by name, with his counts.** §3: *"it is
enough to leave two base orbits to connect L and S, namely `(0,4,4,0)` and `(0,0,2,6)`. Each of the
orbits includes 12 vertices. The reference orbit `(0,4,4,0)` is always full, while the auxiliary
orbit `(0,0,2,6)` may be only partially filled."* Our law, run on our base with no input from that
sentence, returns five off-centre cross-edge orbit pairs:

| orbit pair | edges | `|u|²` | kind |
|---|---|---|---|
| **`(0,4,4,0)` × itself** | **12** | 4 | **reference — his** |
| `(20,0,0,4)` × itself | 12 | 4 | reference |
| `(24,0,0,0)` × itself | 6 | 4 | reference |
| **`(0,0,2,6)` × itself** | **12** | `(17−√33)/6` | **auxiliary — his** |
| `(16,0,6,2)` × itself | 24 | `(17−√33)/6` | auxiliary |

plus 60 centre-incident edges. **Both of his orbits, both at twelve edges, at exactly the two radii
M31's quadrature law predicts** — radius 2 for the reference kind and the conjugate-ring pair
`(17±√33)/6` with product `8/3` for the auxiliary. §0a's closure is now confirmed against the record
holder's own object and not only against Heule's.

**And his subtype is non-vacuous on our base:** restricted to those two orbits alone — 24 off-centre
cross edges plus the centre's 60 — the full arena still refuses four colours (11 s). His §3 claim,
reproduced from first principles.

**The descent restarts here**, and the base is better on every axis that costs: **1,603 points
against 5,401 (3.4×), 92 orbits against 473 (5.1×), 11,286 unit edges against 30,846 (2.7×)**, with
the acceptance test correspondingly cheaper. `data/m62/parts-lattice.json`,
`typem.parts_lattice/parts_group/parts_orbits`.

**Two instrument incidents, both caught by controls, both `G21`/`G30` again.**
*(a)* The first `abcd = 0` census used `parts_coords`, which accepted only denominator-12 points and
returned `None` otherwise — so every denominator-18 and -36 point of `⊕⁴H²` was **silently excluded
from the test**, and the count measured the extractor. It showed as an exact tie between two
different bases (43 orbits, 625 points, both), which is what made it visible. A zero coordinate is
scale-invariant and needs no denominator at all.
*(b)* The non-vacuity gate printed `SAT   (undecided at cap)` — the verdict was right and the gloss
named a branch that never fired, because the gloss tested for `'refuted'`/`'satisfiable'` where
`refuses_four` returns `'unsat'`/`'sat'`. **`G30`'s third failure mode inside a script written to
settle a vacuity question**; the verdict stood, the sentence beside it did not.

### §R20 — The subtype law on the corrected base, exhaustive: a connection works iff it carries BOTH kinds

With the base right (§R19), the subtype question is 32 exact asks instead of a search, and it comes
back as a clean characterisation. The five off-centre cross-edge orbit pairs split by radius into
Parts's own two kinds:

* **reference**, `|u|² = 4` (radius 2): `(0,4,4,0)` — 12 edges, **his** — plus `(20,0,0,4)` 12 and
  `(24,0,0,0)` 6.
* **auxiliary**, `|u|² = (17±√33)/6` (the conjugate-ring channel, product `8/3`): `(0,0,2,6)` — 12
  edges, **his** — plus `(16,0,6,2)` 24.

**All 32 subsets decided, no cap, no unknown:**

| | subsets | verdict |
|---|---|---|
| contains ≥ 1 reference **and** ≥ 1 auxiliary | **21** | **all UNSAT — the arena refuses four colours** |
| one kind only (or empty) | **11** | **all SAT — 4-colourable** |

`(2² − 1)(2³ − 1) = 21` and `2² + 2³ − 1 = 11`: the split is **exactly** by kind, with no exception
in either direction. **So `[Parts2020a]` §3's *"the existence of triangles of the second kind is
essential"* is proved rather than observed — and it is symmetric, which his sentence does not say:
the FIRST kind is equally essential.** The two sharp negatives are the ones a search would not have
bothered to run: **both auxiliary orbits together fail** (36 edges, SAT), and **all three reference
orbits together fail** (30 edges, SAT) — every reference cross edge the base has, and it is not
enough. The property is of the *radii*, not of the orbits.

**Six minimal subtypes, and the cheapest is not his.** `(0,0,2,6) + (24,0,0,0)` connects at **18
off-centre cross edges** (12 auxiliary + 6 reference) where his `(0,4,4,0) + (0,0,2,6)` uses 24.
Whether fewer cross edges is better for the descent is a separate question — fewer edges means a
looser arena and more patterns for the other side to kill — and is not claimed here.

`data/m62/pl-subtypes.json`, 497 s single-threaded. Cost asymmetry as everywhere in this milestone:
a SAT row costs ~1 s, an UNSAT row 10–50 s.

### §R21 — The box sweep goes parallel, and the measured ceiling is not the core count

§R15 recorded that parallelism bought nothing for this descent, on a measurement that was true when
it was taken: 160 box solves in 7.5 s. **On the corrected base it is no longer true.** The S side's
acceptance test now sweeps **18,408 boxes and costs 116 s**, because dropping orbits from `L` loosens
it and inflates the pattern set the other side must kill — the cost *grows as the descent succeeds*.
`|P_S| = 264` against `|P_L| = 18,408` on the same arena, the asymmetry structural: the shared centre
lives on the `L` side, so the `S` block carries 30 extra unit clauses ("no `S` point of norm 1 takes
colour 0") and is far more constrained.

`tools/boxsweep.py` fans the sweep out over **plain subprocesses — no pool, no queue, no epoll**,
because this project owns one multiprocessing wedge (a parent asleep in `do_epoll_wait` for 96
minutes) and five self-inflicted process kills. A worker prints one line and exits; the parent kills
the rest on the first survivor; a worker that fails **raises rather than returning a verdict**.

**Validated red/green before it decided anything**, against the sequential answer on both branches —
a state that blocks all 18,408 boxes, and a state with a survivor. Both agree.

**Measured, and the number is 4.1× rather than 28×:** sequential 116 s, parallel 28 s on 28 workers,
while another job held a core. The profile says why, and it is worth recording because it caps every
future fan-out of this shape: **load and bootstrap are free** (0.05 s together — 48,260 clauses and
18,408 boxes), and the whole cost is the solves, at **6.3 ms/box sequentially against 13 ms/box in a
worker.** The sequential sweep reuses ONE incremental solver across every box, so its learned clauses
accumulate; each worker starts cold and throws that away. So the achievable speedup is capped near
*half* the core count before contention, and memory bandwidth takes the rest.

**Incident, the sixth of its shape and the first that ran two jobs at once.** The relaunch that added
per-round logging wrote its pgid from `pgrep -f … | head -1`, which matched a process whose group was
not the job's, so the kill was a no-op and **two descents ran concurrently on one log**. The standing
memory note says the *script* writes its own pgid at startup; this launch did not. It does now
(`os.getpgid(0)`, first line of `__main__`).

### §R22 — THE ARENA WAS THE WRONG OBJECT: radius 2 excludes the record's own lineage, and radius 2.44 hands back a 757-vertex refuting selection for free

**The finding, and it came from an advisor rather than from the descent.** Poros was asked to
check the *frame* of a five-round campaign to make the reduction stage faster, and answered on the
**object** axis: the arena being descended cannot contain the objects the descent is aimed below.
Every number here was then re-derived independently before it was believed.

**Heule's published 510-vertex 5-chromatic graph is a type-M object at `ρ₁₅`, and 37 of its 510
points lie outside `parts_lattice(2.0)` — by radius alone.** Decoded from `tools/heule510.json`
into complex floats, all 2,504 of its edges are unit distance, its centre is the origin, and its
**maximum radius is 2.4320**. Since `|ρ₁₅| = 1`, every vertex of an arena built on a radius-`r`
base has radius `≤ r`, so a radius-2 arena **provably** misses them. Measured coverage of the 510
against `parts_lattice(r)`:

| `r` | base points | Heule-510 covered |
|---|---|---|
| 2.00 | 1,603 | **473 / 510** (L 369, `ρ`S 105) |
| 2.10 | 1,879 | 479 / 510 |
| 2.30 | 2,773 | 486 / 510 |
| **2.44** | **3,433** | **510 / 510** (L 375, `ρ`S 136) |

**At `r = 2.44` the arena contains Heule-510 exactly.** The base is group-closed (179 orbits, sizes
`{1: 1, 6: 14, 12: 49, 24: 115}`, **zero images outside**); the induced subgraph on those 510
vertices has **2,504 edges, every one of Heule's own and not one extra**; `refuses_four` returns
UNSAT in 10.5 s. That is an independent reconstruction of a published 5-chromatic record from our
own §5.6 lattice and our own `ρ₁₅` cross-edge law — a positive result that was sitting inside a
negative.

**And the orbit closure of those 510 points is 48 orbit-halves / 757 vertices, refusing four
colours in 7.5 s.** Against which the eight-seed portfolio of the same day, on the radius-2 arena,
had spent **4.4 CPU-hours to reach 2,310 and was still descending**.

**The cross-edge count does not move, and that is a theorem rather than a coincidence.** Collinearity
forces `|u − ρv|² = t² + s² − (7/4)ts = 1`; the form is positive definite (`(7/4)² < 4`), so its
solution set is an ellipse and real `s` requires `t² ≤ 4/(4 − (7/4)²) = 64/15`. **Every `ρ₁₅`
cross-edge endpoint has radius at most `8/√15 ≈ 2.0656`**, so enlarging the base past that adds
only interior material and the cross structure is already complete: **126 cross edges at `r = 2.00`
and 126 at `r = 2.44`, unchanged**, exactly as the bound predicts. §R20's exhaustive subtype law is
therefore untouched by the enlargement.

**One correction to §R3's own reading, and it is the useful half.** §R3 wrote *"dropping groups
moves the instance toward its satisfiability threshold, so the further a descent gets, the more each
step costs."* True inside one arena; **false as a law**. On the radius-2 arena an accept at weight
2,310 costs 295 s, while on the 2.1× LARGER radius-2.44 arena a selection of weight 757 costs 7.6 s
and the record's own 510 costs 10.5 s. The variable is **slack over the nearest refutation**, not
weight and not arena size — so "keep the instance near a thousand vertices, as Parts does" is not
the mechanism either; *working where the answer is not yet close* is, and seeding at 757 buys it.

**What this retires.** The eight portfolio trajectories are retired rather than optimised, and the
"23% spread from the deletion order" they were quoted for is withdrawn as stated: those were
**ten-minute snapshots of runs that had not converged**, so the spread mixes variance with progress
and measures neither. The deletion-order finding itself (WO-9) is untouched — it is measured
elsewhere — but this data does not support it.

**What was summarised rather than read, recorded because it is the mechanism.** §R19 closed FS-31
with the boundary question — *"whether his 'about 400' counts orbits INSIDE the disk (ours: 92) or
orbits MEETING it (ours: 1,023) — his text does not decide it"* — marked **immaterial**. It was not
immaterial: it is exactly the truncation that excludes the record. And a 510-point control was
available the whole time and never run — the lattice congruences check against Heule-510 in one
loop and pass 510 for 510, isolating the failure to radius; the milestone validated against
nineteen published orbit labels instead. `G21` again, and this time on the *boundary* of an
enumeration rather than on its contents.

### §R23 — The speed campaign: five rounds, and the fourth one measured that speed was never the binding constraint

Kooshi's instruction was *"iterate and optimize … improve the descent speed … at least 5 rounds of
optimization with your advisors."* Rounds 1–3 are speed and they landed; round 4 measured that no
amount of it reaches the target, and round 5 is the move that could.

**Round 1 — the ask kernel.** A recorded 14-ask trace, replayed under swappable backends, verdicts
compared against the reference on every row (a backend that is faster and answers differently is
not faster). Desktop, 32 cores: **CaDiCaL 1.5.3 = 73.5 s, 1.9.5 = 87.9 s (+19 %), 3.0.0 killed at
≥ 6×.** Newer is worse on this family; the advisor's own sweep puts 1.9.5 8 % *ahead* instead, so
that row is a disagreement and is recorded as one. Its mechanism, offered with its test: CaDiCaL 2.x
added gate and congruence extraction, and a one-hot colouring encoding is nothing *but* gates, while
96 % of the runtime is search. **The cost split is the useful half**: colourable asks 0.02–2.8 s,
refusing asks 10–15 s, and one refusing ask ran **17 minutes** before it was killed.

**Round 2 — the algorithm, and the measurement inverted my own design.** The census was built on a
theorem — colourability is downward closed, so a criticality witness is *permanent* — and run first
on the argument that a permanent fact should never be re-derived. Measured: the first **191 asks
came back 177 droppable-alone and 14 critical**, at a median 7.9 s each. **At the top of a descent
the census discriminates almost nothing; at the bottom it is exactly right**, because there almost
everything is critical and its asks are the cheap colourable ones. Driver rewritten as
descend-then-census (`tools/descent3.py`). The descent's own inner search became **gallop-then-
bisect** on the droppable prefix: refusal is monotone in the prefix length, and a plain bisection
spends `log2(n)` asks to learn that not even one vertex comes off, which is the common case late.

**Round 3 — three structural findings, two of them from the engineering advisor and all three
re-derived here before use.**

*(a) The census is 47 asks, not 756, and it is exact.* All 24 elements of the base's group are
automorphisms of the 757-vertex arena and the closure is orbit-closed, so deleting `v` and deleting
`g(v)` give **isomorphic** instances. Control: every member of orbits of size 6, 12 and 24 asked
separately — verdicts constant in each (`DDDDDD`, `CCCCCCCCCCCC`, `CCCCCCCCCCCCCCCCCCCCCCCC`).
**10 critical orbits / 144 vertices; LOWER BOUND 145.** The discount is available once per arena,
from the orbit-closed selection: Heule-510's setwise stabiliser in the group is trivial, so vertex
granularity really is forced after the first round.

*(b) Heule-510 is exactly vertex-critical.* A full 509-ask census, 8 workers, **40 seconds**:
**509 critical, 0 droppable-alone, 0 undecided.** So no proper subset of it refuses, and the
identity closes from both sides: `144 critical + 365 droppable-and-in-Heule + 1 centre = 510`.

*(c) Failed-assumption cores are worthless here, and the mechanism I first wrote for that was
wrong.* Measured: `asked 756 → core 756, zero free drops, fixed point at round one`. I read it as a
granularity effect — one literal per vertex, so every touched vertex is in the core. The derivation
runs the other way: a coarse group's literal is free only when **every** member is unused, which is
strictly stronger, so coarsening can only weaken cores. The discriminating ask at orbit granularity
returns **zero free orbits** as the derivation predicts. **The variable is how much of the object a
single refutation touches**, and this object is tightly coupled — which its vertex-critical core
independently confirms. `get_core()` is free, so call it; expect nothing on a tightly-coupled
object at any granularity.

**Round 4 — the measurement that ends the speed campaign.** Nine random-order 1-minimal descents
from the 757 closure, ~500–900 s each, twelve in parallel:

**582, 586, 589, 593, 595, 598, 599, 599, 609** — mean 594.4, standard deviation 7.6.

**The 510 all nine of them contain is eleven standard deviations below that mean.** The minimum of
`N` samples improves like `sqrt(2 ln N)`, so no number of orders and no amount of parallelism gets
there — 768 descents would be expected to reach 529, and that is eleven hours. **Order diversity is
not a route to the record, and every parallel shape converts cores into more samples of a fixed
distribution.** Three parallel shapes were priced against it and all lose: racing seeds is **3.1×
worse** than spending the same cores on more descents (the 23× heavy tail is on the *colourable*
asks, which are 80 % of the count and 18 % of the time, while the refusing asks that are 82 % of the
time have a 1.6× spread); cube-and-conquer is aimed three orders of magnitude away from a
65,000-conflict median accept; clause sharing is sound for free here (every worker bootstraps the
identical CNF) and still speeds up sampling, which is not the constraint.

**Round 5 — the move a descent cannot make.** `tools/lns_worker.py` and `tools/lns_guided.py`:
destroy `r` vertices of a solution and repair with material currently outside it, refusing to spend
`r` — a swap that must pay. The guided repair is this project's own kill engine (M49 §R8, M50) one
level up and **counterexample-guided**: ask, take the colouring the solver hands back, add a vertex
whose neighbourhood inside the selection is rainbow under it — which is the only way one vertex can
destroy one colouring — and repeat. Failing iterations cost about `log2(r)` colourable asks and run
at ~200 asks/s; only an iteration about to improve pays a refusing ask.

**Two wrong versions are kept in the files rather than deleted.** The first repair pool *contained*
the destroyed set, so it re-added 96 of 100, grew a 509-vertex object to 585, and then spent ~100
expensive asks trimming back toward where a plain descent lands anyway — an LNS that is a slow
re-run of the thing it exists to beat. The second had a gallop that never tested the full pool (1,
2, 4, 8, 16, 32, then exit at 64 with 48 candidates), so it reported "no repair" for a pool that
always had one — **silently, because that branch had no log line**, which is the blind-phase rule
broken again inside a tool written after it.

**What stands at the close.** The best object is **583 vertices (582 + the hard centre),
independently certified vertex-critical** — a fresh 582-ask census, 40 s, 582 critical / 0 droppable
/ 0 undecided. The sandwich for the 757 closure is **145 ≤ minimum ≤ 510**. **No object below 510
has been found, and the record of 509 is not beaten.** The guided search is running; it has found no
improving swap in several thousand iterations from either start, which is itself a statement about
how tight this object is.

**Speed, stated as the same task before and after.** *Produce a certified 1-minimal refusing
selection from the arena.* Before: eight seeded descents on the radius-2 arena, 43 minutes, **none
converged**, best 2,538 on an object that provably excludes the target. After: **nine converged and
certified 1-minimal objects in about fifteen minutes of wall clock**, on an arena that contains the
record's own lineage exactly.
