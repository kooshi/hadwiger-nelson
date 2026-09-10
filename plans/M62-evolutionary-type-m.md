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
