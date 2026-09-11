# M63 phase D — the loop, with a rule that finds its own moves

*Subplanned 2026-09-11 by de Bruijn (the phase D planner), for a fresh implementer, while phase C is still
being built. The milestone plan is `plans/M63-parts-reproduction.md`; **its §S is the current state** — the
goal (S.1), what planning measured (S.2), the gap audit (S.3), the roadmap C–G (S.4). Phase C's subplan is
`plans/M63-phaseC-joint-stage.md`; **its instruments are this phase's contract**, and the contract is the
committed code at HEAD, not that plan. This file is phase D only. The product owner reviews it before
implementation; the approval is recorded in §A at the end.*

*Two files this phase may not edit while phase C is open: `plans/M63-parts-reproduction.md` and
`plans/M63-phaseC-joint-stage.md`. Edits this phase wants made to them are written in §X below, under
headings the product owner can act on.*

---

## §0 — Purpose, and the shape in seven lines

Phase D delivers **the loop**: the thing that alternates expansion and reduction, carries `A = ⋃{M}`
between iterations, and finds its own moves. It is the instrument every later phase stands on — F beats
the record with it, E generalises it, G runs it at other rotations — so it is built once, frozen in a
commit, and judged by what it does rather than by what it reproduces.

| part | what | why it is in D |
|---|---|---|
| **D0** | the cost probe, and **the target knob** — a reduction asked as a *decision at a target* rather than as "close the optimum" | his §5.5 carries the incumbent across iterations; without it every failed candidate costs a full reduction, and D3's scoring is unaffordable |
| **D1** | the replay controls: 376 at rung 3 on `A451`, 374 at rung 1 on `A412`, 374 at the rung-2 subgroup, computed two ways | the only inputs-and-outputs he published; they calibrate the reduction half and produce the 374 level set nothing else can |
| **D2** | **his** published ranking device, scored first (§5.6's third strategy on §5.10's indicators) | the only published device that ranks an expansion; if it works, our rule is his rather than ours |
| **D3** | the expansion machinery — reserve `R`, candidate generators, the look-ahead — and **our rule**, registered and committed before it runs | S.1 2(b): a rule must find the move |
| **D4** | the loop runner: per-iteration line, `stalled` as a verdict, exact resume, the pre-level forecast, and the refusal to continue from a truncated level | §O(3): the loop has no measure, so its surface is the only thing that makes progress visible |
| **D5** | our own `L374 ∪ ρS136` at 509 / 2,442, refusing four colours on exact geometry | S.1 #1, the reproduction of the record |
| **D6** | **the outcome map** over the single-orbit expansion menu — the **large half's sweep on `A412` is D's first experiment and its first beat attempt**; FS-35's two quantities at each replayed state; **the greedy edge sweep of the 509** | the map is D's scoring surface (§3.2), and it replaces ranking against his one recorded move; FS35-1; and a record-bearing item §PA(e) found that the roadmap does not carry. **The menu's size is a parameter** (§1(e)3) |

**Not in D:** the joint level set as a loop start (F); the companion constructors and the held-out runs
(E); any kernel certificate (F); any rotation other than `ρ₁₅` (G). **The small half's six-move menu is
being run today by a scoped agent** (`aa10420df4950eda9`) outside this plan; D consumes its results rather
than re-deriving them (§3.5).

---

## §PA — The prior-art gate (WORKFLOW step 3a), proportionate to what is new

What is new in phase D, stated so it can be searched: **a local search whose move is "add vertices" and
whose evaluation is "enumerate the complete set of minimum solutions"**, plus **a look-ahead that prices a
candidate move before paying for its full evaluation**, plus **how to score a move-selection rule when the
literature contains exactly one recorded expert trajectory**.

**(a) The recognition sentences, and what each one's literature owns** (G46: name the object in the
discipline's vocabulary, and that sentence is the query).

| our object | the discipline's name for it | what the field owns that we do not | searched |
|---|---|---|---|
| expansion + reduction, alternating | **large neighbourhood search**; destroy-and-repair, and **adaptive LNS** when several move families compete on past performance | the adaptive-selection machinery: competing destroy operators scored by their own track record | *large neighborhood search neighborhood selection destroy repair evaluate move selection* |
| *"escape a local minimum by increasing the number of new vertices introduced in the expansion stage"* (`[Parts2020a]` §5.8) | **iterated local search, adaptive perturbation strength** — verbatim the same device | the dilemma is named and studied: too weak and the search falls back into the optimum just left, too strong and it is random restart; strength is adapted on the *quality of the neighbours the local search saw* | *iterated local search perturbation strength adaptive escape local optimum* |
| expansion adds vertices, i.e. **variables**, to a restricted problem | **column generation**: the reduction is the restricted master, the expansion is the **pricing problem**, and "which columns are worth adding" is the reduced cost | a principled answer to *which* variable to add, when the master is an LP; ours is an integer hitting-set master, where the dual is not a single price vector | *column generation pricing set covering which columns to add reduced cost* |
| **price a candidate expansion before paying to reduce it** (FS-35's re-aim) | **strong branching versus pseudocost branching**, and **reliability branching** as the hybrid | exactly our problem, solved: the expensive evaluation is run on the unreliable candidates and a cheap proxy on the rest, with a stated switch-over criterion | *strong branching pseudocost reliability branching cheap proxy expensive evaluation* |
| `Y` and `{M}` | **minimal correction sets** and **minimum hitting sets**; MUS/MCS duality; **smallest-MUS extraction** | CAMUS, MARCO, `forqes`; the **backbone** of a level set is our necessary atoms | *smallest MUS enumeration hitting set dualization* (also phase C §PA(b)) |
| the complete optimal level as the loop's state | **solution pools** and **diverse optimal solutions** | machinery for enumerating and diversifying optima; nothing that then *grows the instance* | *enumerate all optimal solutions solution pool diversification* |
| the symmetry rungs | **symmetric integer programming**: core points, orbitopes, orbital branching | the symmetry gap that M64 identified as overcompression | M64 §PA(b) |
| scoring a rule against one expert trajectory | **imitation learning for neighbourhood selection in LNS** | the standard is an expert policy run over *many* instances, a regime we do not have | *learning to select neighborhoods LNS imitation expert trajectory* |

**What this buys, concretely, and it is why the gate is run as aiming rather than as insurance:**

1. **Reliability branching answers FS-35's question in the affirmative and tells us its shape.** The
   look-ahead is not a measure and not a predictor to be trusted — it is a *cheap proxy used where the
   expensive evaluation has not yet been paid*, with the expensive evaluation run on the candidates the
   proxy cannot separate. D3 adopts that shape.
2. **Adaptive-perturbation ILS says his stall escape is a known device with a known failure mode**, and
   that the adaptation signal in the literature is the quality of the *neighbours seen*, not the number of
   iterations. D4's stall response uses the level's own statistics rather than a counter alone (§3.4).
3. **Nothing in any of these literatures enumerates the complete optimal level and then grows the
   instance.** Solution pools enumerate but do not grow; column generation grows but keeps one optimum;
   LNS grows and shrinks but keeps one incumbent. **If phase D holds a finding that is not about
   Hadwiger–Nelson, it is that combination** — and confirming or killing it is a read of
   `[LiffitonEtAl2016]`, `[BacchusKatsirelos2016]` and arXiv:2412.13606, which `BIBLIOGRAPHY.md` marks
   *not read — BLOCKING for any FS-35 novelty claim*. **D claims no novelty for the method**, so the read
   does not block this phase; it blocks the sentence, and the sentence is not written here.

**(b) The citation-graph walk, in two databases** (G49 rule 5, G50: cross-check two, they disagree).
OpenAlex holds `[Parts2020a]` as two records (`W3094611186`, `W4287634333`) with 5 and 3 citing works;
Semantic Scholar returns **19**. The union was read by title, and two were opened rather than
characterised from a title:

- **`[MundingerEtAl2025]`** — *Neural Discovery in Mathematics* (ICML 2025), already in `BIBLIOGRAPHY.md`,
  read status *abstract only*. It works the **upper** bound (find colourings); D works the lower bound
  (find graphs). **Not blocking for D**, and the bibliography row already says so.
- **`[deGreyParts2023]`** — **new, and it changes D's acceptance; see (e)**.

Nothing else in the union is a minimization paper; the rest are colourings, Minkowski planes, hyperbolic
and tropical variants, Ramsey results and surveys. **Nobody cites `[Parts2020a]` as a method**, which is
the finding: the algorithm this milestone reproduces has no reproduction literature.

**(c) Is 509 still the record?** Re-checked independently of phase C's gate, by a different query. Yes:
`[Haugland2026]`'s introduction (August 2026) says *"the current record is 509 vertices by Parts"*; a
fresh search returns nothing smaller; and `[deGreyParts2023]` — by Parts himself, three years after the
record — still cites `v5 ≤ 509`. **Falsifier:** any certified smaller graph found later.

**(d) How much room is below 509, published.** `[deGreyParts2023]` proves **`v5 ≥ 28`** (improving
Gwyn–Stavrianos's 22, itself improving Pritikin's `v5 > 12`), and `e5 ≥ 99`. **So no published result
obstructs any vertex count between 28 and 509** — a factor of eighteen, and every improvement in fifty
years has come from construction rather than from the bound.

**(e) The find that changes the acceptance, quoted verbatim.** `[deGreyParts2023]` footnote 2:

> *"In [5] the corresponding 509-vertex graph has 2442 edges, but is not edge-critical, which allows us to
> reduce `e5`. We were able to discard 36 edges, but we didn't perform an exhaustive search, so further
> improvements are possible."*

Three consequences, none of them in the roadmap:

1. **M63 §S.1 #4's secondary record bar is already beaten in print.** It reads *"509 vertices with fewer
   than 2,442 edges"*. The published state is **2,406**. §X.1 puts the correction to the product owner.
2. **The 509 is published as not edge-critical**, so an edge sweep on it has a *known non-zero answer* —
   a positive control as well as a record attempt.
3. **The search was not exhaustive.** An exhaustive edge minimisation at 509 vertices is our reduction
   machinery with edges as atoms, and nobody has run it. D6 carries it. **It cannot cost the vertex
   claim:** if `G − v` is 4-colourable then `(G − e) − v ⊆ G − v` is too, so **edge removal can never make
   a vertex removable** (Poros, phase D card 1 riders) — the 509's vertex-criticality and phase C's C4.1
   control survive any edge sweep.

**(f) Three things in his §§5.5–5.11 that no plan in this milestone carried, found by reading his sources
outward** (§L's lesson: audit the source, not the plan). All three are Poros's, adopted:

1. **parts:493-497 — the incumbent is a cutoff that crosses iterations.** *"It is enough to check only the
   subgraphs whose order does not exceed the order of the minimum graph `M` found at the previous
   iteration."* So a candidate expansion is asked as a **decision at a target** — *is there a refusing
   selection of at most `t`?* — not as "close the optimum". `reduce_stage` has `wall_ask`, `max_minima`
   and `phase2_wall` and **no target**. It is the largest cost lever for any sweep, it makes a *failed*
   candidate cheap, and it is his rule rather than ours. **D0.5 builds it**, and §3.2's scoring design is
   affordable only because of it.
2. **parts:544-545 — his SECOND strategy**, distinct from the §5.10 device D2 scores: *"filling and (or)
   adding a relatively large number of orbits, but with the subsequent removal of new vertices with a
   small final degree."* A cheap pre-filter that keeps the gap small while adding many orbits — the
   depth-2 enabler, and the only way a set-valued expansion is priceable. **D3's second candidate
   generator.**
3. **parts:724-729 — §5.11, the quantified reason his ranking device exists at all:** *"The maximum number
   of redundant vertices or orbits … is usually limited to several tens"*, with about 1,000 vertices under
   symmetry. **Our L451 stage carried gap 76** — we are already past the ceiling his §5.6 priority
   sentence is a response to, which is the frame for §3.2.

**(g) Searched and found nothing, recorded as the finding it is.** No prior art for: reproducing
`[Parts2020a]`'s algorithm; scoring an expansion rule against a complete outcome map in this setting; or
the `Σ(lo + hi) = 2|M|` identity of §1(e)2.

**(h) `BIBLIOGRAPHY.md` owes one new row**, drafted at §X.2. Our copy is filed at
`~/source/library/pdf/arXiv-2303.14714-degrey-parts-lower-bounds.pdf` (fetched 2026-09-11); read status
**read in full — four pages**.

---

## §1 — What the implementer must know before writing a line

**Read M63 §S.2 and phase C's §H first. Then read the contract at HEAD, not from any plan** — phase C
corrected itself twice during implementation, and this plan is written against the corrected code.

**(a) The contract, and the five details easiest to get wrong.**

- `tools/parts_run.py --help`, and `run_reduce` / `finish_record` for the schema-2 record.
- `tools/parts_reduce.py`: `Oracle.ask(kept, wall, slice_conflicts) -> ("sat"|"unsat"|"unknown", model)`,
  `ReductionState`, `reduce_stage`.
- `tools/parts_stage.py`: `Stage(base, L, S, side, rung, pin, rung_maps, cross_law)`.
- `reduce_stage` returns the record **with a live `state` object under the `state` key**; a caller pops it
  before serialising, as `finish_record` does.
- **Atom labels are `[half, lattice tuple]`**; on a joint stage the half is not the stage's side.
- **A capped level writes `A_sample` and no `A` field.** D4 makes that a halt, not a taint (§3.3).
- **`unknown` is a reachable verdict.** The ask wall is **not** a wall-clock interrupt: phase C's
  prediction P-C1.2 was falsified — PySAT's `cadical153` raises `NotImplementedError` on `interrupt()`,
  and from a timer thread that exception is printed and swallowed while the ask runs on. The committed
  mechanism is a loop over **conflict-budget slices** under a time wall. **Every forecast D writes is in
  asks, correction sets and conflicts, never in "the wall will stop it".**

**(b) The cost regime — the measurements, and what they do and do not explain.**

| stage | companion | gap | colourable | refusing |
|---|---|---|---|---|
| L451 (L reduced, S136 frozen) | frozen | 76 | 0.006 s | 0.02 s |
| S166 (S reduced, L374 frozen) | frozen | 30 | 0.009 s | 0.108 s |
| the joint stage, both halves deletable | **none** | 68 | **0.170 s** | **1.758 s** |
| — the full 576-atom graph, refusing | | | | **5.73 s** |
| — the record's own 508-atom selection, refusing | | | | **8.74 s** |
| — that selection minus one atom, colourable | | | **0.008 s** | |

*(C4.0's definitive measurement: CPU seconds on the quiet desktop, minimum of three fresh solvers per ask.
It supersedes every earlier figure.)*

**The honest reading, and it is weaker than "companion-free is the expensive regime."** That phrase is a
proxy with no mechanism behind it, and the data does not fit it cleanly: L451 has gap **76** at 0.02 s
refusing while the joint stage has gap **68** at 1.758 s, so neither the companion nor the gap explains
two orders of magnitude. **M62 §R22's measured law is slack over the nearest refutation**, and both
"frozen companion" and "small gap" are proxies for it (Poros, phase D). So:

- D's forecasts assume the L-side stages stay near the L451 rates, which is an **association, not a
  mechanism**, and **D0 measures it before anything long is launched**.
- **A specific reason to expect a rise where it hurts most:** his own M-type asks were ~10 s (parts:846),
  measured where the loop *ends* — near the global optimum, where the instance is tightest. Registered as
  **P-D0b**: refusing asks at the 374 level cost materially more than at the 375 level on the same kind of
  stage. If that fires, the wrong forecasts are the ones for the loop's last and longest iterations.
- **Corroboration from the small half, measured today under load** (the S-expansion engineer, on the
  32-core desktop at load ~6, sharing with phase C's three reductions and its own four): the `A166`
  baseline against the frozen `L374` regenerated at **12,532 colourable @ 0.0111 s and 3,033 refusing
  @ 0.1352 s**, level closed, zero undecided; and **four expanded stages at 542–557 vertices and 168–183
  atoms read 0.0096–0.0119 s colourable and 0.113–0.189 s refusing**. **So a frozen-companion stage stays
  in the cheap regime as its working graph grows, and the refusing mean moved by well under 2×** — which
  is the first direct evidence for P-D0a, on the side D does not run, and it is why D0 confirms rather
  than gambles.

**Price an iteration in correction sets, not in asks.** Harvesting dominates: on the L451 run each
correction set cost about **17 colourable asks and 2 refusing ones** — ~0.16 s at L451's rates and ~6 s at
the joint stage's. L451 harvested 703 and S166 773. **Every forecast below is in correction sets.**

**Wall design.** The joint stage runs about **16,600 conflicts per CPU second**, so a 100,000-conflict
slice is about 6 s — the granularity of any budgeted ask and the most a time wall can overshoot by. A
slice below the cost of one ask turns every ask into `unknown`. **State the slice beside any wall.**

**(c) The four conditional drops are back for D, F and G** — decided by the product owner on 2026-09-11
with C4.0's measurement as the stated reason, the conditional mechanism firing as designed. Each, with
what D uses it for:

| row | the item | what D uses it for |
|---|---|---|
| B-12 | his **8-4-2-1** batching | **the look-ahead** (D3): delete eight candidate-freed atoms at once; one refusal frees all eight. Also phase 1 of every reduction if D0 reads expensive |
| X-7 | the **level-size guard** | the pre-level forecast: refuse a level whose candidate count cannot be bounded **before** paying for it |
| D-6 | the **parallel level** | **after** the first optimum, where the level is an antichain. Before it the loop is sequential, each hitting set depending on the last. **And across candidates**, which is where D6's map gets its parallelism: the 55 moves are independent |
| C-5 | the cheap `Y` statistics | they **are** his §5.10 indicators (D2), and their sizing role returns |

**(d) A planning probe that failed, kept because its failure is a control.** I attempted to price the edge
sweep during planning. It printed `vertices 374 edges 1926` against the stage's own `509 vertices, 2442
edges`, and a full-graph refusal in 0.00 s. **Cause:** `Stage` numbers vertices over `range(2n)` with
`v < n` the L half and `v ≥ n` the S half, and the induced edge list is `stage.A.induced(stage.present)`;
my probe read `A.E_int` and `A.E_cross` raw against an L-only index range, so it built a graph that was not
the 509. **The result is discarded.** Carried forward as control **d6.1**: the sweep asserts 509 vertices
and 2,442 edges *before any ask*, and the planted negative is exactly this bug.

**(e) Three measurements taken in planning, solver-free. Each is re-derived by committed code before
anything rests on it.**

1. **Necessary atoms are the intersection of a complete level, not the harvested degree-1 layer.** On the
   stored L451 record: **336** atoms lie in every one of the 3,264 minima, while `Y`'s harvested degree-1
   layer has **312**; the 312 are a subset and 24 are missing — the gap the record's own note warns about.
   Every rule scoring "how many necessary atoms does this expansion free" must read
   `parts_faces.LevelSet.necessary()` on a **complete** level. **Consequence:** scoring his recorded move
   is *not* free, because the 374 level set does not exist on disk — only the 375 one does. It exists
   after D1, so D2 and D6's map run after D1, never beside it.
2. **FS-35's retirement precondition does not fire.** On his four published `{M}` columns
   (`data/m62/parts-table2-orbit-fillings.json`) the varying-orbit count reads **10 → 4 → 6** along
   376 → 375 → 374 (and 2 for M6C), so the quantity is not flat. Three of the four columns satisfy
   **`Σ_orbits (lo + hi) = 2·|M|` exactly** (750, 748, 748); the 376 column misses by **3** (749 vs 752).
   **What that identity is, corrected by Poros and adopted:** a realized 2-element exchange class summing
   to `c` contributes `2c`, and a stable orbit `2f`, so *pair classes ⟹ the identity*; the converse fails.
   A **larger** class of size 3 summing to `c` gives `Σ(lo+hi) = 3c − Σlo`, an **excess**, never a
   deficit. **So a deficit cannot come from bigger classes at all** — only from an unrealized corner (the
   range box is not tight, which is generic for a projected polytope) or a typo. **It is therefore not a
   transcription control**, since a correct table can violate it structurally, and a mismatch does not
   localise. It remains a structural probe, registered as P-D6. *(Visible in his own printed table:
   `(2,0,6,4)` 0–4 with `(10,0,2,4)` 8–12 gives `4 + 20 = 24 = 2 × 12`.)*
3. **The single-orbit expansion menu, its size, and the reading of his admission rule it depends on.**
   Re-derived here independently of Poros's card 1: `Base(2.6)` has **229 orbits, 4,513 points and 38,730
   exact unit edges**, and **all six** of his accumulator and minimum files lie entirely inside his
   `r = 2` disk (183 of the 229 orbits meet it).

   **The count is in dispute and is therefore a parameter, not a constant.** His rule (parts:517-521) is
   *"a base orbit is included in `R` if, when added to the graph `A`, the degree of some of its vertices
   is at least 4"*.

   | reading | degree measured in | `v403e2112` / `v412e2106` / `v166e774` |
   |---|---|---|
   | **(a) strict** — an absent vertex's unit neighbours **into `A`** | `A` alone | **49 / 49 / 6** — re-derived here; what Poros's card 1 counted |
   | **(b) literal, internal** — *"when added to the graph `A`"*, so the added orbit's own edges count | `A ∪ O` | **59 / 57 / 11** (Poros P5) |
   | **(c) literal, plus cross-edges to the frozen companion** | `A ∪ O ∪ C` | 59 / 57 / 12 — **unverified**: the advisor's own control failed, its cross-edge call returning 54 edges between `v374e1860` and `v136e564` against the record's 18 |

   **The caveat on (c) is lifted for the large half, by a squeeze that needs no run.** Reading (b) counts
   no cross edges, so `(b) ≤ (c)`; the correction only *removes* cross edges, so
   `corrected-(c) ≤ raw-(c)`; and on the large half `raw-(c) = (b)` already, cross-degree having promoted
   nothing. Hence `(b) ≤ corrected-(c) ≤ raw-(c) = (b)`: **57 at `A412` and 59 at `A403` are exact, and
   the small half is 12.** The 54 decomposes as **18 real + 36 centre-bookkeeping** against the stage's
   `30 = 18 + 12`, so it was a convention difference about which side owns the shared centre, not a
   defect in the law. **Size the sweep at 57; nothing waits on a re-run.**

   **Reading (b) is the better reading of his sentence** — the engineer's grammar is right and the
   advisor withdrew (a). **The menu is therefore 57 on the large half and 11–12 on the small, about 69
   in all and about 71 carrying the shoulder: +25% over the strict count, not the doubling that was
   feared, so §3.2's affordability argument is unchanged.** Size the sweep at **57**. The count still
   enters the plan only as `|menu|`.

   **Two things that did not move.** (i) **The closed list survives every reading**: zero orbits outside
   his `r = 2` disk are admitted under (a), (b) or (c), on all three accumulators — the claim is now
   robust to the rule rather than resting on one narrow reading, and P-D14 is scored **negative before
   the phase opens**. (ii) The advisor's pre-registered argument that reading (b) is *not a filter* —
   that it would admit ≥ 10 orbits touching `A` nowhere — **fired its own falsifier at 0**, so every
   orbit (b) adds already attaches to `A`, and the two readings differ only where an attaching vertex
   reaches degree 4 with help from its own orbit-mates.

   **On the void column (c), a reconciliation rather than a hunt.** The stage's own accounting is
   consistent: it reports the record at 509 vertices and 2,442 edges with 30 connection edges, and
   because the shared centre is counted on the L side, the S half's centre edges appear among the
   connection edges — `e(L) + e(S∖centre) + (centre edges + 18 off-centre) = 2,442` reproduces his
   `1860 + 564 + 12 + 6` exactly. So the factor of 3 is in the advisor's separate cross-edge call, not
   in the stage, and the sweep should take its edges from the stage (§M collapse 1) rather than from
   that call.

   **Top candidates, strict reading:** `(8,0,0,4)` at degree 10 with 12 of 12 absent on the large half;
   `(0,0,6,6)` at degree 8 with 12 of 12 absent on the small half — *the same orbit his own recorded L
   move added*.

   **The shoulder, re-derived exactly.** Orbits at degree exactly 3, just below his cut-off: **3 on the
   small half**, and including them makes the candidate list **independent of where his threshold is
   drawn**. One of the three, **`(0,4,8,0)`, lies outside his `r = 2` disk at radius exactly `√5`**
   (2.2360679…); the large half's shoulder likewise contains **`(18,0,0,6)`, also outside the disk and
   also at radius exactly `√5`**. **So the first material his own construction excluded sits at `√5` on
   both halves**, and it is absent from his base entirely. *(No field-theoretic consequence is claimed
   here — the lattice and its field are unchanged; the radius is a fact about his truncation.)*

   **And the obvious deflation fails, which turns the coincidence into a reading.** If `√5` were simply
   the first orbit radius past his cut, the pair would be an artefact of where he drew the line. It is
   not: the 46 excluded orbits begin at 2.00708, and **thirteen of them sit closer to his boundary than
   `√5` = 2.23607 while scoring below 3** (Poros P6). So **degree into the accumulator is not monotone
   in radius**, the best excluded scorer on each half sits further out rather than nearest, and the two
   halves agree independently. **Consequence for phase F:** his published negative — *"expanding the
   base graph and increasing the radius of the disk did not lead to new results in our case"* — is a
   fact about his **filter**, not about his **disk**, because radius was never the quantity that
   ordered admissibility. F(g)'s radius half therefore closes for a reason rather than for want of a
   measurement.

   **The two halves' neighbourhoods are asymmetric**, at degree ≥ 3: **9** orbits around `v166e774`
   (6 eligible + 3 shoulder) against about **72** around `v412e2106`; at degree ≥ 1, **78** of the small
   half's 217 candidate orbits against 161 of the large half's 209. **What that is and is not:** it is
   search-space *size*, **not** the density of successful moves, and the density is exactly what the map
   exists to measure (Poros, declining to let this into the plan as evidence — adopted). The
   counter-consideration belongs in the record: the large half is the half he actually worked — four
   states, ~100 laptop hours — while he never expanded the small half at all, so the prior per candidate
   is not equal across the two; against which his §7 says *"Not all options have been studied yet."*
   Registered as **P-D12**, the product owner's hunch with its falsifier, so the sweep scores it rather
   than assuming it.

**(f) Commands that work today** (run each before believing it):

```
python3 tools/parts_report.py            python3 tools/parts_faces.py --self-test
python3 tools/parts_repro.py             python3 tools/parts_stage.py
python3 tools/parts_reduce.py            python3 tools/parts_run.py --self-test
```

---

## §2 — The skeleton

*Signatures and docstrings are the specification; bodies are the implementer's. Every planted control is
named with the verdict it must flip. Every new artifact names its producer and stamps
`parts_report.provenance(config=…)`. Nothing here re-specifies an instrument phase C committed.*

### D0 — the cost probe, first, because every forecast depends on it

On the `A412`-against-`S136` L stage, measure both ask populations in **CPU seconds (user + sys), minimum
of three runs, machine and concurrent load named** — one refusing ask on the full working graph, the
phase-1 population, and twenty near-optimal asks. Report **correction sets per minute** as well as seconds
per ask, since that is the unit §5 forecasts in.

| outcome | consequence |
|---|---|
| near the L451/S166 rates | §5's forecasts stand. The four cost-control rows are built anyway (§1(c)); this outcome only means D is not blocked on them |
| near the joint stage's rates (0.170 / 1.758 s, single asks to 8.74 s) | **stop and report.** Every forecast in §5 is wrong; the order of work is re-planned before anything multi-hour launches, and the 8-4-2-1 batching is built **before** D1 |

### D0.5 — the target knob, his own cutoff

```python
# tools/parts_reduce.py -- a new OPTIONAL parameter; default None is today's behaviour exactly
def reduce_stage(stage, *, target: int | None = None, ...):
    """`target` turns the search from *close the optimum* into a **decision**: is there a refusing
    selection of weight ≤ `target`?  It is `[Parts2020a]` §5.5's own cutoff — *"it is enough to check
    only the subgraphs whose order does not exceed the order of the minimum graph M found at the
    previous iteration"* — and without it every FAILED candidate expansion costs a full reduction.

    Semantics, and they are what keeps the record honest:
      * the level loop stops as soon as the MaxSAT lower bound exceeds `target`; the verdict is
        `no-selection-at-target` and the record carries `Bound(lower, None, rung, undecided)` — a
        one-sided bound, never a minimum;
      * on success the behaviour is unchanged and the level at `w*` is enumerated as today;
      * **a record produced under a target may not be called a minimum**, and `Bound.render()` must
        say `no refusing selection of ≤ t` rather than anything with the word minimum in it.

    The completeness invariant (M63 §O(1c)) is untouched: the target prunes candidates that cannot
    reach it, which is the beat-the-incumbent pruning §O(2) already proved sound."""
```

*Control* **d0.1**: on the L451 stage, `target=374` must return the same level as the untargeted run, and
`target=373` must return `no-selection-at-target` with a lower bound of 374 — the second is the one that
can fail, and its answer is known from the stored record.

### D1 — the replay controls

| run | input | rung | attested target |
|---|---|---|---|
| D1.a | `v451e2400` against `v136e564` | 3 | 376 vertices, 96 minima, `A = v451e2400`, edges 1890–1947 |
| D1.b | `v412e2106` against `v136e564` | 1 | 374 vertices, 1,092 minima *under a convention he does not state*, `A = v412e2106`, edges 1860–1884 |
| D1.c | the same stage | rung-2 subgroup | 374 vertices, 78 minima, `A = v406e2082` up to the group, edges 1868–1884 |

**D1.c is computed twice — as a direct rung-2 reduction and as the invariant part of D1.b's rung-1
level — and the two must agree** (M64 §R10's free rung lattice used as a control, not as a shortcut).

`|{M}|` is reported under all three conventions of `parts_audit.canonical_counts` and **never gated**;
his 1,092 is un-gateable because his paper does not name the group.

### D2 — his own published ranking device, scored before anything of ours is registered

```python
# tools/parts_loop.py
def indicators(stage, level=None, *, ask=None, degree_cap: int = 3) -> dict:
    """`[Parts2020a]` §5.10's numerical indicators, which §5.6's third strategy ranks candidate
    expansions by — the ONLY published device that ranks an expansion.

    Verbatim: *"the number of free vertices, the number of hyperedges of some small degrees, the
    order of the maximum independent set for hyperedges of degree 2"*.  Returned separately and never
    combined into a score, because he states no combining rule and an invented one would be ours
    wearing his name:
      free_vertices  -- atoms in no degree-1 hyperedge (`LevelSet.free` on a complete level, else the
                        harvest's degree-1 layer, and the record says which)
      hyperedges     -- {degree: count} up to `degree_cap`
      alpha_degree2  -- independence number of the degree-2 hyperedge graph
    `ask` is required when no stored `Y` covers the enlarged stage; its cost is reported, never hidden."""

def score_his_device(base, A_tuples, companion, candidates, *, log=print) -> dict:
    """D2's run: `indicators` on each candidate expansion of our 375-level accumulator (= his `A403`),
    and the rank of the four orbits his own move used — the other halves of (0,0,2,2) and (0,0,2,6),
    plus (0,0,0,4) and (0,0,6,6) (M63 §S.2 #9).

    **Registered before the run:** if all four rank in the top half under at least one indicator, D
    registers HIS device as the rule and the earlier negative localises to two sentences rather than
    to his method.  If they do not, **no published device predicts his own recorded move**, D's rule
    is ours alone, and the record says so plainly rather than implying his craft is in the paper."""
```

*Cost:* ~14 candidates, ~6,000 asks, tens of minutes at the L451 rates. Discharges P6 in its useful form.

### D3 — the expansion machinery, and our rule

```python
@dataclass(frozen=True)
class Candidate:
    """One proposed expansion: **the vertices it adds**, and where the proposal came from.

    **`fills` and `adds` were one thing wearing two names** (§M collapse 3).  His prose distinguishes
    *completing a partially filled orbit* from *adding a reserve orbit*, but the object added is a set
    of base vertices not currently in `A` either way, and every consumer treated the two identically.
    The distinction is provenance, and provenance is already a field.

    `vertices` is in the base's own lattice tuples, and the constructor REFUSES an empty set: an
    expansion that adds nothing is his own recorded no-op (*"filling orbit (4,0,0,0)"*, already 6 of 6
    in `A403`), and it is now unrepresentable rather than filtered (control d3.1 becomes a constructor
    test).  The orbits are recoverable through `base.of`, so naming by orbit is a rendering and not a
    second copy of the datum."""
    vertices: frozenset[tuple[int, int, int, int]]
    provenance: str          # "partial-fill" | "reserve" | "many-then-trim" | "stall-escape" | "identity"

    @property
    def n_new(self) -> int:
        """Derived, never stored — his perturbation strength is `len(self.vertices)`."""

    @property
    def orbits(self) -> dict:
        """`{orbit label: how many of its members this candidate adds}`, for rendering and for the
        map's per-orbit columns."""

def reserve(base, A_tuples, *, min_degree: int = 4) -> list[tuple]:
    """His §5.6 reserve `R`: an orbit joins it *"if, when added to the graph A, the degree of some of
    its vertices is at least 4"*, offered *"in order of decreasing vertex degree"*.

    Planning re-derived the counts (§1(e)3): **49** on `v403e2112`, **49** on `v412e2106`, **6** on
    `v166e774`, against his *"about 40 are included in R"* on a smaller disk.  This function is what
    re-derives them in committed code; a different number is a finding, not a bug to be tuned away."""

def candidates(base, A_tuples, *, n_orbits: int = 2, include_full: bool = False) -> list[Candidate]:
    """His §5.6 candidate set: *"priority should be given to partially filled base orbits, and
    especially to orbits with a small number of vertices (6 or 12)"*, then reserve orbits.

    `include_full=False` is not an optimisation: an orbit already full in `A` adds no vertex, and
    proposing one is the no-op his own sentence contains — *"filling orbit (4,0,0,0)"*, already 6 of 6
    in `A403` (M63 §S.2 #9).  Control d3.1 plants a full orbit and requires it absent."""

def many_then_trim(base, A_tuples, *, n_orbits: int = 6, min_final_degree: int = 3) -> Candidate:
    """His SECOND strategy (parts:544-545), which no plan in this milestone carried: *"filling and (or)
    adding a relatively large number of orbits, but with the subsequent removal of new vertices with a
    small final degree."*  Add many orbits, then drop the added vertices whose degree INTO the enlarged
    graph stays below `min_final_degree`.  It is the only published way to make a set-valued expansion
    cheap, because the trim is what keeps the gap — and therefore the level — small."""

def look_ahead(stage, level, cand, *, batch: int = 8, ask=None) -> dict:
    """**Price a candidate before paying to reduce it** (FS-35, re-aimed), in the shape the MIP
    literature already settled: the cheap proxy of *pseudocost* branching, standing in for the *strong*
    branching that a full reduction is.  Never trusted alone — §3.2 spends the expensive evaluation
    where the proxy cannot separate.

    The proxy: **how many currently necessary atoms does this expansion free?**  An atom is necessary
    when it lies in every minimum of the COMPLETE level (`LevelSet.necessary()`; 336 on the L451 level
    against 312 in `Y`'s harvested degree-1 layer, §1(e)1), and an expansion helps exactly when the new
    material covers what such an atom covered alone.

    Priced by his §5.8 **8-4-2-1** batching: delete `batch` necessary atoms at once from the enlarged
    graph; a refusal frees all of them in one ask.  Reports `freed`, `asks`, `batch_collapses`.

    **Attribution:** the quantity is Poros's (2026-09-11), offered unverified; the correction that it
    must be read off a complete level rather than off `Y`'s degree-1 layer is this plan's, re-derived
    at §1(e)1."""

RULES = {...}   # name -> callable(list[Candidate], context) -> ranked list

def rank(cands, rule: str, ctx) -> list[tuple[Candidate, dict]]:
    """The frozen ranking.  The loop takes the rule BY NAME, so a control differs from the real run by
    one string:  "ours" | "random" | "his_degree" | "his_indicators" | "no_filter_random".

    A rule may read only: the candidate, the current complete level, the stored `Y`, the reserve, and
    the loop's own history.  It may NOT read his files, his tables, or any orbit name taken from them.
    `ctx` is the enforcement point and carries nothing else (control d3.4)."""
```

**Our rule, committed before it runs:**

> Rank by `look_ahead.freed` per vertex added, ties broken by his decreasing-degree order, restricted to
> candidates of at most `n_new_max` vertices; on a stall raise `n_new_max` — his own escape — and re-rank.
> Candidates the proxy cannot separate go to the expensive evaluation in proxy order until the budget is
> spent.

### D4 — the loop runner

```python
@dataclass
class LoopState:
    """The loop's state at one instant, resumable.  `A` is the union of ALL minima of the current level
    and is the loop's state variable; a level that was truncated has no `A` and therefore no successor
    (§3.3).  `history` is the per-iteration record his success criterion is about — `(|M|, |{M}|, |A|)`
    with the rung — and `stall` counts consecutive iterations in which all three were unchanged."""
    iteration: int; rung: str; A: list; history: list[dict]
    stall: int; n_new_max: int; rule: str
    freeze_commit: str; config_sha256: str; records: list[str]

def step(base, state, *, companion, rule, budget, log=print) -> dict:
    """One iteration: rank the candidates, expand `A` to a working graph `W`, reduce it at the current
    incumbent as `target` (D0.5), and fold the result back into `A`.

    His success criterion (§5.5), verbatim: *"The iteration is considered successful if it leads to a
    change in the graph A: that is, either to a reduction of the order of the minimum graph M or else
    to an expansion of the set of minimal graphs {M}."*  Both are recorded; **neither is a measure**.
    Verdicts: `improved`, `grew`, `unchanged`, `no-selection-at-target`, `level-truncated`, `base-fails`."""

def run_loop(base, start_record: str, *, rule: str, companion, max_iterations: int,
             stall_limit: int = 6, checkpoint: str | None = None, log=print) -> dict:
    """The loop, from a starting reduction RECORD rather than from a graph — so phase C's verdict and
    the small half's result are arguments, not code paths (§3.1, §3.5).  Refuses a starting record
    carrying `A_sample` and no `A`.

    Exact resume per ITERATION; the in-flight reduction resumes from its own checkpoint by phase C's
    mechanism.  A relaunch redoes at most one expansion ranking, and the log line says so.

    `stalled` is a VERDICT and not a success."""
```

**The per-iteration line** extends `parts_report.iteration_line`, which exists and is unused:

```
it 7  rung 1  rule ours  W 421  |M| 375 (+0)  |{M}| 312 (+30)  |A| 406 (+3)  Y: d1 318 d2 161 d3 64
      cand 14 ranked, top freed 9/6 new   target 374   corr 1.4k @0.16s
      asks 11.2k @0.007s / 4.1k @0.021s   STALL 0/6   ckpt …loop-L.ckpt.json 18 s ago  [f47e1f3·a19c4d21]
      kill-safe: a relaunch redoes this iteration's ranking (~40 s) + the reduction since its checkpoint
```

### D5 — our own record

```python
def assemble_record(base, L_minimum, S_minimum, *, cross_law=None) -> dict:
    """`L374 ∪ ρS136` from OUR minima: 509 vertices, 2,442 edges as 1860 + 564 + 12 + 6, refusing four
    colours by SAT on exact geometry (M63 §S.1 #1).  No Lean certificate: the object is his, and
    §O(4)'s decline stands for a reproduction."""
```

### D6 — the outcome map, FS-35's quantities, and the edge sweep

```python
def outcome_map(base, start_record, companion, *, menu=None, target=None, jobs=1, log=print) -> dict:
    """**D's scoring surface** (§3.2): `step` evaluated at EVERY candidate in the menu, instead of a
    ranking judged against his one recorded move.

    **It is the loop's own step function, tabulated** (§M collapse 2) — `[step(state, c) for c in
    menu]`, never a parallel implementation.  A separate one could drift from the loop and would then
    be measuring something the loop does not do, which is the whole failure this surface exists to
    avoid.  The rule is a *policy over the same step*: the map evaluates all of it, the loop evaluates
    it in the rule's order until its budget runs out.  Scoring is then well defined because both sides
    are literally the same function.

    For each candidate: expand, then `reduce_stage(..., target=incumbent-1)`.  A candidate that cannot
    reach the target is refuted cheaply and labelled `no`; a candidate that reaches it is labelled
    `yes` and is then re-run WITHOUT a target to enumerate its level, so the winners — and only the
    winners — cost a full reduction.  Columns per candidate: verdict, new `|M|`, new `|{M}|`, atoms
    freed, asks, correction sets, CPU seconds.

    The menu is closed at 55 single-orbit moves (§1(e)3), and the candidates are INDEPENDENT, so this
    is the one place in the phase with embarrassing parallelism: `jobs` up to 8.

    **Sequencing, and it is what keeps the evaluation honest: the map over `A403` is computed only
    AFTER the frozen rule has had its attempt** (§3.2).  Run before, it is the answer key."""

def look_ahead_quantities(level, base, stage) -> dict:
    """FS-35's two quantities at one state: the exchange-class vector (`parts_faces.exchange_classes`
    over the level's profiles) and the per-rung closure bound (`parts_faces.orbit_closure`), at each of
    D1's three replayed states plus our 375 level.  FS-35's retirement precondition was tested in
    planning on his four published columns and did NOT fire (§1(e)2); this re-derives that and extends
    it to the closure bound, which needs a level set at each state and so could not be tested before D1."""

def edge_atoms(stage) -> "Stage":
    """**The edge sweep is not a second instrument: it is the same stage with edges as its atoms**
    (§M collapse 1, and it is this pass's largest finding).

    `Stage` already models *a working graph, a frozen part, and a set of deletable units*, and
    `reduce_stage` already computes the minimum-weight hitting set over those units.  An edge is a
    deletable unit.  `R(S) := W with edge set S refuses four colours` is **upward closed** for exactly
    the reason the vertex version is — adding edges cannot make a graph easier to colour — so M63 §O
    carries verbatim: the MCS/MUS duality, phase 1, the correction sets, the completeness invariant,
    the bound, exact resume, the wall, the verdict vocabulary and the record schema all come for free.

    **Three consequences.**
      * The deliverable is no longer a greedy 1-minimal set but **the exact edge minimum** of the 509 —
        which is precisely what `[deGreyParts2023]` fn. 2 says was never computed (*"we didn't perform
        an exhaustive search"*), and it is the same machinery, not a new one.
      * **The pin stops being a special case.**  §5.9's symmetry break is sound only while its triangle
        is a triangle, so the pin's three edges go in `fixed` — where the shared centre already lives —
        instead of being protected by a flag.
      * **My failed probe's bug becomes unrepresentable.**  It hand-rolled a second CNF over a
        hand-rolled index space and silently built a 374-vertex graph where the stage said 509 (§1(d)).
        With edges drawn from `stage.A.induced(stage.present)` as the stage's own atoms, there is no
        second index space to get wrong.  Control d6.1 survives as a regression test, not as a guard
        against a live failure mode.

    Greedy remains available as a *cheap upper bound* to report beside the exact answer, and his 36 is
    the number to beat on either."""
```

### The artifact schema

`data/m62/m63-loop-<name>.json` and `m63-map-<name>.json`, schema 1, producers in `tools/parts_run.py`:

```json
{"kind": "m63-loop", "schema": 1, "producer": "tools/parts_run.py:run_loop",
 "headline": "loop from m63-L375 under rule `ours`: |M| 375 -> 374 in 3 iterations, 41k asks, verdict improved",
 "config": {"start_record": "…", "rule": "ours", "companion": {"source": "v136e564.vtx", "frame": {}},
            "budgets": {"max_iterations": 12, "stall_limit": 6, "n_new_max": 24, "target": "incumbent-1"},
            "freeze_commit": "…", "config_sha256": "…"},
 "iterations": [{"it": 1, "rung": "1", "candidate": {"fills": [], "adds": [], "n_new": 0},
                 "ranked": [{"cand": {}, "freed": 0, "rank": 1, "asks": 0}],
                 "record": "data/m62/m63-loop-…-it1.json",
                 "M": 375, "M_set": {}, "A": 403, "delta": [0, 0, 0],
                 "verdict": "grew", "asks": {}, "correction_sets": 0, "cpu_seconds": 0.0}],
 "verdict": "improved", "stalled_at": null,
 "his_move_rank": {"rank": 7, "of": 49, "note": "diagnostic, never a gate"},
 "predictions": [], "provenance": {}}
```

And the map, whose whole purpose is that **a ranking nobody has thought of yet is scorable from this file
alone** — so it stores *labels and costs*, never scores (§E1):

```json
{"kind": "m63-map", "schema": 1, "producer": "tools/parts_run.py:run_map",
 "headline": "A412 menu under reading (b), 57 candidates: 39 no, 4 yes, 2 unknown, 12 not run [random block complete]",
 "note": "no score is stored. Any ranking over these candidates is scored from this file by read-off;
          uniform random's expectation is a hypergeometric over the yes/no/unknown counts.",
 "menu": {"admission_reading": "b-literal-internal", "count": 57, "shoulder_included": true,
          "outside_his_disk": [[18, 0, 0, 6]], "provisional": []},
 "density": {"yes": 4, "no": 39, "unknown": 2, "not_run": 12,
             "note": "three-way and never two: an `unknown` is not a `no`"},
 "entries": [{"candidate": {"vertices": 12, "orbits": {"(8,0,0,4)": 12}, "provenance": "reserve"},
              "block": "random", "block_index": 3,
              "asked_at_target": 373, "verdict": "no",
              "M": null, "M_set": null, "freed": 7,
              "flags": ["outside-his-disk"],
              "asks": {}, "correction_sets": 812, "cpu_seconds": 154.0}],
 "predictions": [], "provenance": {}}
```

### Planted controls, each with the verdict it must flip

| control | plant | must read |
|---|---|---|
| d0.1 | `target=374` then `target=373` on the L451 stage | the level as stored; then `no-selection-at-target` with lower bound 374, and **no word meaning minimum** in the render |
| d1.1 | D1.c computed both ways | `rungs-agree`; a difference reads `rung-route-differs:<which>` |
| d1.2 | D1.b's level relabelled `truncated-at-budget` | every range, partition and necessary-atom claim refused (`LevelSet.require_complete`) |
| d1.3 | **free, no plant:** each replay stage contains a known minimum of his — ask that selection, and it minus one atom | `contains-a-known-minimum`: refusing, then colourable. It checks the stage is built over the object we think it is, at two asks and no plant. Phase C found the same control on the joint stage; **D runs it on all three replays** |
| d2.1 | `indicators` on a stage whose `Y` does not cover it, with `ask=None` | refuses, naming the missing coverage; never a silent partial |
| d3.1 | a candidate whose orbit is already full in `A` | absent from `candidates()`; `no-op-expansion` if forced |
| d3.2 | a candidate freeing zero necessary atoms beside one freeing many | `look_ahead` separates them; equal scores read `proxy-cannot-separate` |
| d3.3 | an 8-batch of atoms individually known critical | the batch verdict agrees with the eight individual verdicts: `batch-agrees` |
| d3.4 | `ctx` offered one of his files | `rule-read-his-data`, and the run aborts |
| d4.1 | a starting record carrying `A_sample` | `level-truncated`; the loop refuses to start |
| d4.2 | a loop killed mid-iteration and resumed | `loop-resume-identical` on the history and every completed iteration's minima |
| d4.3 | `stall_limit` iterations with all three quantities unchanged | verdict `stalled`, never `complete` |
| d4.4 | **an `A`-dependent choice re-resolved after an expansion** — run two iterations at a rung named `order:2`, and compare the group elements resolved at iteration 1 against those at iteration 2 | `rung-pinned`: identical element lists. If they differ, `rung-drifted:<iteration>` and the run stops — `Aut(A)` grew with `A` and the loop silently changed problems (§O2). The same control covers any pinned image or frame |
| d5.1 | our `L374 ∪ ρS136` | 509 vertices, 2,442 edges, `1860 + 564 + 12 + 6`, refusing |
| d6.1 | the edge sweep built over the L-only index space (§1(d)'s real bug) | `edge-sweep-wrong-graph`: the pre-ask assertion 509 / 2,442 fails |
| d6.2 | a pin-triangle edge offered to the sweep | refused, `pin-edge-protected` |
| d6.3 | the swept graph re-checked by a fresh solver sharing no CNF code | still refuses four colours |
| d6.4 | the map run with `jobs=16` against `jobs=1` on the same six candidates | identical verdicts and identical levels: `map-parallel-identical` |
| d6.5 | **free, the unsampled member (§M):** the **identity candidate** — expand by nothing, reduce at the incumbent | reproduces the unexpanded level exactly (`map-identity-agrees`). It validates the whole map pipeline against a level already on disk, and costs one entry |
| d6.6 | **free, a derived control (§M):** any map entry whose `\|M\|` is **larger** than the unexpanded level's | impossible — expansion enlarges the atom set, so the old selection is still available and the minimum is non-increasing at a fixed rung. A larger `\|M\|` is `map-entry-impossible`, a bug and never a finding |
| d6.7 | the edge-atom stage built on the record | 509 vertices, 2,442 edges, **and its atom count equals the edge count**; the exact edge minimum is reported beside the greedy upper bound |
| d6.8 | **one ask:** is the record minus its shared centre four-colourable? | `centre-critical`. C4.1 proved all 508 *atoms* critical and the centre is never an atom, so this is the hypothesis §O6's floor is missing — it raises the floor from 1,016 to 1,018, and an answer of "not colourable" would mean the record is not vertex-minimal, which is a loud finding |
| d6.9 | **an assertion on every object the sweep returns**, milliseconds each: minimum degree ≥ 4, and edge count ≥ the §O6 floor | a degree-3 vertex or a count below the floor reads `edge-sweep-impossible` — a bug, never a record. It fires on exactly the failure an edge sweep is prone to, an edge dropped whose loss is masked by a stale incumbent |

---

## §3 — The five decisions the product owner asked me to settle

### 3.1 — The branch on phase C's verdict: it changes the starting state, not the instrument

**Decision.** `run_loop` takes a **starting reduction record**, so C4's outcome is an argument.

| C4 reads | what D does |
|---|---|
| **exactly 509** (predicted, P-C4.1 at 0.60/0.65) | the joint material is a local optimum of his own accumulators, so beating it needs vertices from outside them — which is what expansion is. D's rule-driven loop runs on the **L level set**; the joint level goes to **F**, which must exhaust it or check completeness first |
| **≤ 508** | the record is already beaten and the reproduction clauses are untouched — they are about owning the algorithm. D **opens** with the exact-geometry re-check and LRAT refusal of the smaller object, and the loop's headline run starts from **that** level, exhausted rather than capped. The L-side reproduction run still happens: S.1 2(b) is not discharged by a better object |
| **does not close** | D runs on the L side exactly as in the 509 branch; the joint question stays F's. A loop is never started from an open bound |

*Alternative weighed:* branch inside the loop on which level set to expand. *Why not:* it makes the joint
case a second code path through the most delicate part of the phase, and phase C's domain pass already
paid for that lesson with `"LS"`.

### 3.2 — What the expansion rule is scored on: the complete outcome map of a closed menu

**The world we are in, stated plainly.** Of his three published devices, two were scored in planning and
**neither selects his recorded move** (Poros M3: the small-partial-orbit priority leaves a four-way choice
among half-filled 12-orbits and his move took two of them; the reserve's degree order puts the two named
additions 6th and 7th of 49, behind three orbits his own path had already discarded). The third — §5.6's
third strategy on §5.10's indicators — is **untested**, and D2 tests it first. **If D2 also comes back
negative, then no published device predicts his own recorded move, D's rule is ours alone, and the paper
does not contain his expansion craft.** That sentence goes in the record either way.

**Why "does it rank his move first" cannot be the scoring surface.** One recorded move is one bit, and not
a clean one: his move has at least a six-way tie on which partial orbits to fill and an unstated tabu on
orbits his path had discarded. A rule tuned until it ranks his move first is fitted to a single point.

**Decision: compute the outcome of every move in the menu, and score every ranking against that map.**
The menu is **closed at 55 single-orbit moves** — 49 on the large half, 6 on the small — re-derived at
§1(e)3. For each, expand and ask the reduction **as a decision at the incumbent** (D0.5): a candidate
that cannot improve is refuted cheaply; a winner is then enumerated in full. The map's columns are the
verdict, the new `|M|` and `|{M}|`, the atoms freed and the cost.

Given the map, **every ranking is scored exactly, by read-off, including rankings invented afterwards**:

- **uniform random at budget `k`** — its expected score is a hypergeometric read-off from the map's
  density of helpful moves, with no runs at all;
- **any ranking** — its score is its top-`k`, i.e. precision@k against the map's labels;
- **his degree order, his indicators, ours** — three columns of the same table.

So the four-arm comparison I first specified becomes **one computation instead of four campaigns**, and
the result is reusable where loop runs are not.

**Three things this design must not get wrong, each with its guard.**

1. **The map is the answer key, so it may not be computed before the rule is frozen.** The `A403` map runs
   **after** the frozen rule has had its attempt. The `A412` and `A166` maps are past his recorded path
   and touch no reproduction claim, so they may run at any time.
2. **Power is the base rate, and the base rate is what the map measures** (Poros's correction to my
   ablation design, adopted). If 0 of 49 moves help, every ranking ties at zero; if 25 help, every ranking
   succeeds; only a middle band discriminates. **The density is therefore the first thing reported**, and
   if it is degenerate the honest sentence is *"the menu cannot discriminate rules"* — which is a finding
   about the menu, not about the rule (G21: a negative measures its enumeration).
3. **All rankings share the candidate set, and that set is his reserve filter** — 229 orbits cut to 49.
   The filter is the single biggest decision in the rule and no ranking varies it, so a tie across
   rankings would read as *"our ranking does nothing"* when the truth might be *"the filter does
   everything"*. **The fifth arm, `no_filter_random`**, is uniform over all partially-absent orbits with
   no degree gate, and it is what measures the filter. Its map column is a **stated sample** of
   non-eligible orbits, not an exhaustive sweep of all 180, with its enumeration named.

**The sweep's shape, which is D's first implementation item.**

1. **It runs on `A412`, not `A403`** (Poros card 5, adopted; it was already §5's order and the card makes
   the reason a one-way door). `A403` is the state clause 2(b) judges the frozen rule from, so a sweep
   there *computes the answer the rule is supposed to find*, and it cannot be un-computed. `A412` is past
   his recorded stopping point: its candidates are **beat attempts** and touch no reproduction claim —
   **a 373 there ends the milestone**.
2. **The first candidate runs alone and timed**, before the other 48 go out in parallel (Poros card 5).
   Parallel runs contaminate per-run cost measurement, and the regime is load-bearing: four audit drops
   and every forecast in this plan rest on it, and three solver jobs already share the box. **Cost of the
   caution: one candidate's wall clock. Cost of skipping it: the one clean cost datum is never taken.**
   CPU seconds user + sys, minimum of three, machine and concurrent load named.
3. **Priority order: two blocks, and the reason is that "most valuable first" silently biases the map.**
   A sweep truncated in the rule's own order measures that rule's top-`k` on a sample the rule selected,
   which is precisely the bias the map exists to avoid. So:
   - **Block 1 — a seeded uniform-random sample of the menu.** Cut short at any point, it still gives an
     **unbiased** density and an unbiased precision estimate for *every* ranking, his and ours alike.
   - **Block 2 — the remainder in his decreasing-degree order**, so the most valuable candidates by his
     own criterion are answered next.

   Report any truncation as `Count(k, "truncated", of=|menu|, selected_by=…)` naming the block.
4. **The shoulder is included**, which makes the candidate list independent of where his threshold is
   drawn (§1(e)3), and **every candidate outside his `r = 2` disk is flagged as such in the map**.
   **In particular `(18,0,0,6)` is swept on the large half despite scoring 3** (Poros card 6, adopted;
   its sibling `(0,4,8,0)` is already in the small half's fourteen). These two are the *only* excluded
   material on either half that comes within one of his own threshold, both at radius exactly `√5`, and
   they are the first reduction ever run against material his own base excluded. One run out of 57, and
   it is the cheapest available test of the claim phase F's radius item rests on. **Expected inert** —
   the value is closing the question, not a find (P-D15).
5. **Parallelism, and what it wants.** The candidates are independent runs, so this is the one place in
   the phase where cores turn directly into wall clock (unlike the level loop before its first optimum).
   **Ask: 16 cores**, leaving the 32-core desktop's remainder for the joint runs (2) and the small-half
   probe, under the one-heavy-job rule interpreted per *job family* rather than per process. Control d6.4
   requires `jobs=16` and `jobs=1` to agree on verdicts and levels.

*Cost, priced both ways because §1(b) says the regime is an association and not a mechanism.* A full
untargeted reduction at the L451 rates is ~10 minutes; a targeted failure should be under a third of that
(P-D10). At **L451 rates**: ~49 failures × 3 min + a handful of winners × 15 min ≈ **4 core-hours**, about
**20 minutes on 16 cores**. At the **joint stage's rates** (×30): ~120 core-hours, about **8 hours on 16
cores**. **If the menu doubles under the literal reading (§1(e)3), both figures double and nothing in the
design changes.**

**If D0 reads expensive**, the exhaustive form is cut in this order, decided now rather than under time
pressure: (i) drop the `no_filter_random` sample; (ii) keep block 1 and truncate block 2, reporting the
count with its selector — block 1 alone still scores every ranking without bias; (iii) the irreducible
core is the small-half menu plus the rule's own attempt.

*Confidence:* medium-high. **What would change it:** a degenerate density (0 or near-49 helpful moves),
which makes the map a fact about the menu and returns the scoring question to E's held-out run.

### 3.3 — A capped level halts the loop, and the escape is a rung

**Decision.** A truncated level ends the run with verdict `level-truncated`, checkpoint intact. It does
not become `A`, and no successor iteration starts from it.

*Alternative weighed:* propagate a "sampled" taint and keep going. *Why not:* the loop's state variable
**is** `⋃{M}`, and a sample is a different algorithm. The derivation that a taint was never enough is
Poros's and is worth keeping: **for `A' ⊆ A` the reserve is non-monotone in both directions** — a vertex
absent from both loses degree, so candidates drop out; a vertex of `A ∖ A'` is newly absent and may enter
at degree ≥ 4, so candidates appear that the true `A` never offered. At menus of 49 and 6, one spurious
orbit is 2–17% of the menu.

**And the strictness costs nothing, because there is a principled escape: a rung, not a sample.** A
rung-`H` level is complete at that rung and strictly smaller, M64 §R10 gives every rung's minimum free
from `Y`, and his own path walks 24 → 6 → 3 → 2 → 1. **So when a level threatens the cap, D and F raise
the rung and keep an honest complete state.** *Confidence:* high.

### 3.4 — The stall response adapts on the level, not only on a counter

**Decision.** His escape — *"increasing the number of new vertices introduced in the expansion stage"* —
is implemented, and the adaptation reads the level's own statistics (how many candidates the proxy could
not separate; whether `{M}` grew at all) rather than the iteration counter alone.

*Why:* the ILS literature owns this device and names its failure mode — too strong a perturbation is a
random restart, too weak and the search falls back into the optimum it just left — and its adaptation
signal is the quality of the neighbours the local search saw (§PA(a)2). *Alternative:* a fixed schedule —
which is the knob his paper already has, and §O(3) called it a knob and not a criterion. *Confidence:*
medium — **what would change it:** if the loop stalls only once, the adaptive form is untested decoration.

### 3.5 — The small half's menu is being run outside this plan, and D consumes it

A scoped agent (`aa10420df4950eda9`) is running the six-move small-half menu today: the record's small
half is Heule's own, it has had one shrink and no growth, and one vertex below 136 beats the record. D
plans around its results rather than re-deriving them, and the branch is stated in advance:

| it returns | what D does |
|---|---|
| **136 across all six** | record it as a measured floor for the small half over his base and his expansion rule — worth having, since his §6 says he *"hardly improved the result of Heule at all"* there and nobody has ever grown it. It is also the **density datum** §3.2(2) needs on the small half: 0 of 6 helpful |
| **below 136** | D's starting object changes: the assembled record in D5, the loop's starting accumulator, and the edge baseline in D6 all move to the new object, and the vertex-count claim is escalated the same hour |

I have asked it for the per-candidate column rather than the best result, whether each level was exhausted
or capped, and its ask costs in CPU seconds — the last because its six runs are S-side against a frozen
companion and so are a direct test of §1(b)'s assumption.

---

## §4 — Registered predictions

*Committed with this subplan, before any run. Scored by name in M63 §R3.*

| # | prediction | falsifier | p |
|---|---|---|---|
| P-D0a | D's L-side stages stay near the L451 rates: refusing asks ≤ 0.15 s CPU | a refusing ask above 0.5 s | 0.70 |
| P-D0b | refusing asks at the **374** level cost materially more (≥ 3×) than at the 375 level on the same kind of stage — his own ~10 s asks were measured near the optimum | the two levels' refusing means within 3× | 0.60 |
| P-D1 | his §5.10 indicators do **not** rank all four of his move's orbits in the top half under any single indicator | all four in the top half under one indicator | 0.60 |
| P-D2 | the frozen rule reaches `\|M\| ≤ 374` from our 375-level accumulator within 12 iterations | it does not | 0.70 |
| P-D3 | the rule's precision@3 against the `A403` outcome map exceeds uniform random's expectation | it does not | 0.65 |
| P-D3b | the `A403` menu's helpful density is neither 0 nor ≥ 40 of 49 — i.e. the map can discriminate | a degenerate density | 0.70 |
| P-D4 | `{M}` grows at fixed `\|M\|` and fixed rung in at least one rule-driven iteration that added vertices | no such iteration | 0.60 |
| P-D5 | D1.b returns 374 with `A = v412e2106` as a set; `\|{M}\|` equals 1,092 under **none** of the three conventions | it equals 1,092 under one | 0.50 |
| P-D6 | `Σ(lo + hi) = 2·\|M\|` holds on our 375 and both 374 levels; our 376 level reproduces his deficit of 3 | the identity fails on a 374 level, or our 376 level reaches 752 (then his column has a typo) | 0.50 |
| P-D7 | the **exact** edge minimum of the 509 is **below 2,406** — i.e. his non-exhaustive 36-edge discard was not optimal | the exact minimum is 2,406 or above, which would make his greedy pass optimal after all | 0.80 |
| P-D7b | the exact edge minimum lies **strictly above** §O6's floor of 1,016–1,018 — the floor is honest but far from tight | it lands at or below the floor, which would mean the floor is the answer and the sweep has nothing to find | 0.90 |
| P-D8 | the two routes to D1.c agree exactly | they differ | 0.90 |
| P-D9 | the exchange-class vector changes at every one of D1's three replayed states | constant across two consecutive states | 0.80 |
| P-D10 | the targeted decision (D0.5) makes a failed candidate cost **< 1/3** of a full reduction | no material saving | 0.75 |
| P-D11 | the small-half menu returns 136 on every candidate | any candidate below 136 | 0.65 |
| P-D12 | **the product owner's hunch, registered so the sweep scores it rather than assuming it:** the large half's helpful-move density (per candidate) exceeds the small half's | the small half's density equals or exceeds the large half's — which would say his four states of work on the large half exhausted it, and the untouched half is the opportunity | 0.60 |
| P-D13 | under the **literal** reading of his admission rule the large half's menu grows by roughly the factor the small half's did (6 → 12) | it grows by less than 1.3× or more than 3× | 0.55 |
| P-D14 | ~~at least one candidate outside his `r = 2` disk qualifies under the literal reading~~ — **scored NEGATIVE before the phase opened** (Poros P5: zero outside-disk orbits qualify under any of the three readings, on all three accumulators). The closed list is robust to the reading, not an artefact of the strict one | — | — |
| P-D15 | the two excluded `√5` orbits, swept despite scoring 3, are **inert**: neither lowers `\|M\|` nor grows `{M}` | either one improves the object — which would make his own truncation the thing that capped the record | 0.80 |

---

## §5 — Order of work, compute, and stop rules

1. **D0**, the cost probe. Nothing long launches before it reads.
2. **D0.5**, the target knob, with control d0.1 — *before* D1, because everything after it is cheaper with
   it and D6's map is unaffordable without it.
3. **The large half's single-orbit sweep on `A412`** — D's first *experiment*, and the first thing that
   can beat the record. Its first candidate alone and timed; then the rest in parallel (§3.2). **It does
   not wait for D1**: the sweep's primary column is a targeted verdict, which needs no level set. Only
   the *atoms-freed* proxy column needs D1's 374 level, and it is filled in afterwards.
4. **D1.a–c**, the replays, with the two-route control and the free containment control d1.3.
   *Forecast, in correction sets:* L451 harvested 703 at 375; `A412` at 374 is a larger working graph with
   a smaller gap, so **800–1,600 correction sets** at ~0.16 s each is 2–5 minutes of harvesting, with the
   level enumeration at ~13k raw minima dominating at **20–90 minutes**, one core. They produce the 374
   and 376 level sets, which D2, D3 and D6 all need.
5. **D6's `look_ahead_quantities`** on the three replayed states plus our 375 level — solver-free, minutes,
   closes FS35-1.
6. **D2**, his device, scored and reported (~6,000 asks).
7. **D3**, the machinery; **then the rule is committed and the freeze commit is made**, with
   `require_frozen` exercised red and green on the real file. *The freeze precedes E and F.*
8. **D4**, the loop runner with its controls, then **the rule's own attempt from our 375 accumulator**.
9. **The `A403` map — only now, after step 8**, and never before: it is the answer key to the clause the
   rule is judged by. The `A412` sweep (step 3) and the small half's (running outside this plan) need no
   such wait, and their columns are folded in here.
10. **D5**, our own 509.
11. **D6's `edge_sweep`** on the assembled 509. *Forecast:* ~2,442 asks dominated by the cheap polarity (a
    critical edge answers `sat`), so minutes to an hour. **If it discards more than 36 edges, that is a
    secondary-record event: stop and report the same hour**, with exact geometry and an LRAT refusal, on
    phase C's §E5 template.
12. **Close:** write M63 §R3; update M63 §S.3's D rows in place; commit Poros's record by path; report.

**Compute rules.** At most 8 cores; one heavy job at a time; every job over a minute is a process group
(`setsid nohup …`, pgid to a file, stopped only by `kill -TERM -<pgid>`); every job over 15 minutes
checkpoints, resumes exactly and is announced with `--dry-run`'s generated text. **Phase C's joint runs
and the small-half agent may be on the box: check before launching.** Any unexplained crash — halt and
report, do not retry.

**Git.** Commit on `backlog`, stage by path only, never `git add -A` / `checkout --` / `reset` / `stash`,
and end every commit with the two attribution lines.

---

## §6 — What must not be done

1. **No rule that can see his answers**, and **no map computed before the rule it scores is frozen**
   (§3.2). Tuning on the L path is allowed, stamped TUNING, and followed by the freeze commit.
2. **No loop continued from a truncated level** (§3.3).
3. **No record produced under a `target` called a minimum** (D0.5).
4. **No forecast in wall-clock alone.** Asks, correction sets and conflicts; the wall is conflict slices
   and `unknown` is reachable.
5. **No joint result reported as a reproduction row**, and no reproduction claim from a run whose rule saw
   his orbits.
6. **No count without its enumeration, no bound without its rung, no verdict word meaning "clean".**
7. **No held-out problem touched** — M6B 374 at rung 2, M6C, S M6B and M6C, the 8/3 mono-pair, the √3
   triple stay untouched for E. The M6B 375 row is already SPENT by phase C3.
8. **No stored record overwritten**; regenerations go beside the originals.
9. **No Lean.** A sub-509 vertex count or sub-2,406 edge count goes to the product owner with exact
   geometry and an LRAT refusal; the kernel certificate is F's.
10. **No artifact without a committed producer.**

---

## §7 — Acceptance, as a checklist to tick item by item

**D0 / D0.5 — the regime and the knob**
- [ ] Ask costs in CPU seconds, minimum of three runs, machine and concurrent load named; correction sets
  per minute reported. P-D0a and P-D0b scored.
- [ ] `target=` implemented; **d0.1 fires** both ways; no targeted record renders as a minimum. P-D10 scored.

**D1 — the replays** *(tuning mode; `Comparison` rows; `|{M}|` reported, never gated)*
- [ ] 376 at rung 3 on `A451`: vertices, edges 1890–1947, `A`, counts under all three conventions.
- [ ] 374 at rung 1 on `A412`: vertices, edges 1860–1884, `A = v412e2106` as a set, counts.
- [ ] 374 at the rung-2 subgroup: vertices, edges 1868–1884, `A = v406e2082` up to the group, counts.
- [ ] **d1.1, d1.2, d1.3 fire** (d1.3 on all three replays).
- [ ] P8's revised forecast scored against the measured cost.

**D2 — his device**
- [ ] All three §5.10 quantities implemented, reported separately, never combined.
- [ ] Run on ~14 candidates; the rank of his four orbits reported under each indicator.
- [ ] **The verdict written either way**, in §3.2's words. **d2.1 fires.** P-D1 scored; P6 discharged.

**D3 — the machinery and the rule**
- [ ] `reserve` re-derives 49 / 49 / 6 (§1(e)3), or reports a different number with its reason.
- [ ] `candidates` proposes partial fills before reserve orbits; `many_then_trim` implemented (his second
  strategy); **d3.1 fires**.
- [ ] `look_ahead` reads necessary atoms off a **complete** level; the 336-against-312 distinction
  re-derived in committed code; **d3.2, d3.3 fire**.
- [ ] The rule written, committed, and the freeze commit made **before** any scored run; `require_frozen`
  exercised red and green. **d3.4 fires.**

**D4 — the loop**
- [ ] The per-iteration line carries `(|M|, |{M}|, |A|)` with deltas, rung, rule, `Y`'s shape, candidate
  count, target, correction sets, both ask populations, the stall counter, the checkpoint's age.
- [ ] `stalled` is a verdict; **d4.1, d4.2, d4.3 fire**.
- [ ] **From our 375-level accumulator, with no reference to his orbits, the loop reaches `|M| ≤ 374`**
  (S.1 2b) — or the failure is reported as a failure, with the budget it had.
- [ ] **`{M}` grows at fixed `|M|` and fixed rung in an iteration where the rule added vertices**
  (S.1 2c) — or reported not observed.
- [ ] The rank of his implied move under the rule, reported as a diagnostic.

**D5 — our own record**
- [ ] `L374 ∪ ρS136`: 509 vertices, 2,442 edges, `1860 + 564 + 12 + 6`, refusing on exact geometry.
  **d5.1 fires.**

**D6 — the sweep, the map, FS-35, the edges**
- [ ] **The `A412` sweep ran first**, its **first candidate alone and timed** in CPU seconds with the
  machine and concurrent load named, before any parallel launch.
- [ ] The menu was enumerated under a **stated reading** of his admission rule, with the count reported as
  a parameter and both readings' numbers given (§1(e)3). P-D13 and P-D14 scored.
- [ ] **Block 1 (seeded random) ran before block 2 (his degree order)**; any truncation is a `Count` naming
  its block; the shoulder orbits are included; every outside-his-disk candidate is flagged in the map.
- [ ] **The helpful density is reported first** (§3.2(2)), for each half separately; P-D3, P-D3b and P-D12
  scored.
- [ ] The `A403` map ran **only after** the rule's attempt; **d6.4 fires** at the core count used.
- [ ] **The map artifact carries what makes it re-scorable** (§E1): no stored score; `block` and
  `block_index` per entry; `asked_at_target` per entry; a **three-way** density with `not_run` beside it;
  the admission reading named; outside-his-disk and provisional entries flagged.
- [ ] **No rendering presents a one-sided bound as a minimum** (§E2), and the four refusal texts of §E3
  are asserted as golden strings by the self-tests.
- [ ] The `no_filter_random` sample run, with its enumeration named — or dropped under §3.2's stated cut,
  and said so.
- [ ] Exchange-class vector and per-rung closure bound at each replayed state plus our 375 level; FS35-1
  closed; P-D6 and P-D9 scored.
- [ ] The edge sweep run **as an edge-atom stage** (§M collapse 1), reporting **the exact edge minimum**
  with its bound closed, and the greedy 1-minimal count beside it as a cheap upper bound. **d6.1, d6.2,
  d6.3, d6.7, d6.8, d6.9 fire.** P-D7 scored; escalated the same hour if the count beats 2,406.
- [ ] The §O6 degree floor stated with its hypothesis — 1,016 as proved, 1,018 once d6.8 answers — and
  every returned object checked against it.
- [ ] The record says in one sentence that an edge-minimal subgraph is still a unit-distance graph
  (§O4(3)), since that is the reader's first objection.

**Close**
- [ ] M63 §R3 written; §S.3's D rows updated in place; every §4 prediction scored by name.
- [ ] The small-half agent's results folded in, with P-D11 scored (§3.5).
- [ ] `BIBLIOGRAPHY.md` carries the `[deGreyParts2023]` row (§X.2).
- [ ] Poros's phase D record committed by path; every card answered, adopted or declined with a reason.

---

## §8 — Decisions settled in planning

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| The loop takes a starting **record**, so C4's verdict and the small half's result are arguments (§3.1, §3.5) | branch inside the loop | one code path through the most delicate part of the phase; phase C paid for this lesson with `"LS"` | high |
| Score every ranking against **the complete outcome map of a closed 55-move menu** (§3.2) | four loop runs as ablation arms, which is what I first specified | the map scores every ranking exactly, including ones invented later, at one computation instead of four campaigns, and it *measures* the base rate the ablation silently assumed | medium-high |
| **The map is computed after the rule is frozen**, and the **first sweep runs on `A412`**, not `A403` | compute it first, it is cheaper to schedule | computed first it is the answer key and the reproduction claim dies; `A412` is past his recorded path, so its 49 are beat attempts that contaminate nothing | high |
| **The sweep's order is two blocks — a seeded random sample, then his degree order** | his degree order alone, "most valuable first", as the product owner suggested | a sweep truncated in any *ranking's* order measures that ranking on a sample it selected; block 1 keeps the density and every ranking's precision unbiased no matter where the sweep is cut, and block 2 still front-loads value | medium-high — if the sweep always runs to completion the blocks cost nothing and decide nothing |
| **The candidate count is a parameter**, not a constant | fix it at 55 from the strict reading | his sentence reads *"when added to the graph `A`"*, which counts the orbit's own edges; the small half's menu doubles under that reading, and the closed-list claim was computed under the stricter one | high |
| Build **the target knob** (D0.5) before D1 | keep `reduce_stage` as phase C committed it | it is his own §5.5 cutoff, it is the largest cost lever we do not have, and D6's map is unaffordable without it | high |
| A capped level **halts** the loop; the escape is a **rung** (§3.3) | a taint that propagates | the state variable *is* `⋃{M}`; and the reserve is non-monotone in both directions, so a sampled `A` invents and hides candidates | high |
| The look-ahead is a **proxy inside a reliability-branching shape** | trust the proxy's ranking outright | the MIP literature settled exactly this and names the failure mode; M64 §R9 measured that summaries at this level can wash out a real coupling | medium-high |
| **The edge sweep is in D** | leave all record attempts to F | minutes at the cheap polarity, a known non-zero answer (`[deGreyParts2023]` fn. 2), and it doubles as a control on a graph D builds anyway | medium — if D0 reads expensive it moves to F |
| FS-35 stays **live** | retire it on its own precondition | tested on his published columns; it did not fire (§1(e)2) | high for the published half; medium for the closure bound |
| The identity is **not** called a transcription control | use it to gate the transcription | a correct table can violate it structurally (an unrealized corner), so a mismatch does not localise — Poros's correction, adopted | high |
| My planning probe is **discarded and kept as control d6.1** | quietly re-run it correctly | it failed its own printed sanity check, and the bug is the one a reader of `Stage` would make | high |

---

## §X — Edits this phase wants in files it may not touch

### X.1 — M63 §S.1 #4's secondary record bar is out of date (a correction, not a preference)

**As written:** *"Secondary: 509 vertices with fewer than 2,442 edges, his own tie-break."*
**Published state:** `[deGreyParts2023]` fn. 2 — the 509 is **not edge-critical**, they discarded **36**
edges, and `e5 ≤ 2406` is in print. **Proposed replacement:**

> Secondary: **509 vertices with fewer than 2,406 edges** — `[deGreyParts2023]` fn. 2 reports discarding
> 36 edges from the 2,442 without an exhaustive search, so 2,406 is the bar and the true edge-minimum at
> 509 vertices is unknown and below it. Either record is called a record only once certified in the Lean
> kernel.

### X.2 — `BIBLIOGRAPHY.md` owes a row, drafted here for paste

> | **[deGreyParts2023]** | A. D. N. J. de Grey, J. Parts, *On lower bounds of the order of `k`-chromatic
> unit distance graphs*, arXiv:2303.14714 (26 March 2023); Geombinatorics | **The lower-bound side of the
> record, and it moves M63's secondary target.** Refines Gwyn–Stavrianos (Geombinatorics 32(1), named here
> and not held) by three devices: Ágoston–Pálvölgyi's improved edge–vertex relation in place of Erdős's
> `e < v^{3/2}`, Croft's tiling geometry, and algebraic rather than statistical integration of the
> monochromatic-edge probability. **Results: `e5 ≥ 99`, `v5 ≥ 28`, `e6 ≥ 182`, `v6 ≥ 42`**, and
> `v7 ≥ 6456` by a pentagonal tiling — below their own earlier `v7 > 6992`. **Footnote 2 is the
> load-bearing sentence for us:** *"In [5] the corresponding 509-vertex graph has 2442 edges, but is not
> edge-critical, which allows us to reduce `e5`. We were able to discard 36 edges, but we didn't perform
> an exhaustive search, so further improvements are possible."* — so the published edge record at 509
> vertices is **2,406**, M63 §S.1 #4's secondary bar of 2,442 is already beaten in print, and an
> exhaustive edge minimisation at 509 vertices is unrun (M63 phase D6). Also fixes the room below the
> record: **nothing published obstructs any vertex count between 28 and 509** |
> `library/pdf/arXiv-2303.14714-degrey-parts-lower-bounds.pdf` | **read in full (2026-09-11) — four pages** |

Also named by this row and not yet keys: `[Pritikin1998]` (JCTB 73, `v7 > 6197`, `v5 > 12`) and
`[GwynStavrianos2022]` (Geombinatorics 32(1), 2022).

### X.3 — M63 §S.4 phase F(g): the disk-radius re-test can be struck, and his negative explained instead

**As written**, F(g) is *"his own negative on the disk radius — 'expanding the base graph and increasing
the radius of the disk did not lead to new results in our case' — which he measured inside his own loop
… at 150× his reduction speed it is cheap to re-test."*

**It no longer needs a re-test, because the question is answered without one** (§1(e)3): under all three
readings of his admission rule, **zero** orbits outside his `r = 2` disk qualify, on all three
accumulators; and the deflation was tested — thirteen excluded orbits sit *closer* to his boundary than
the `√5` pair and all score lower, so **admissibility is not ordered by radius**. His negative is
therefore a fact about his **filter**, not about his **disk**. **Proposed:** strike the radius half of
F(g), keep the base-graph half (`⊕ⁿHᵐ`), and record the explanation in its place. Phase D still sweeps
the one `√5` orbit on each half (P-D15), so the claim is tested at two runs rather than re-measured at a
radius sweep.

---

## §P — Poros's cards, and their fates

*The advisor for phase D is `adbf37e0e65defce4`; its record is `plans/POROS-2026-09-11-m63-phaseD.md`,
committed by this phase. Consulted twice before this subplan was committed. Every card is answered.*

| card | question | fate |
|---|---|---|
| **1** (rank 1) | is the depth-one expansion menu enumerable at our speed, so D computes the outcome map instead of ranking against his one move? | **ADOPTED as §3.2 and D6's `outcome_map`, with its measurement re-derived here** (49 / 49 / 6, menu closed at 55; §1(e)3). **Two modifications, both mine:** the map is evaluated as *targeted decisions* (D0.5), without which 49 full reductions is 8–70 core-hours rather than a computation; and the `A403` map runs **after** the rule is frozen, since computed first it is the answer key. Its own proposed first run — `A412` plus `(8,0,0,4)` — is the map's first row |
| **2** (rank 2) | has anyone ever expanded the S half? | **ADOPTED, and overtaken by events:** the product owner launched it as a scoped run the same day (§3.5). D consumes the result and states both branches in advance rather than re-deriving it |
| **3** (rank 3) | what does a capped level leave as the loop's state? | **ADOPTED in the stricter form** (§3.3): a halt, not a taint. Its non-monotone-reserve derivation is kept as the reason, and its rung escape is adopted as what makes the strictness free |
| **5** (rank 5) | which accumulator does the first sweep run on, and does its first candidate run alone and timed? | **BOTH ADOPTED** (§3.2): the sweep runs on `A412`, because a sweep on `A403` computes the answer clause 2(b) judges the rule by and cannot be un-computed; and the first candidate runs alone and timed, because parallel runs contaminate the one cost datum four audit drops and every forecast here rest on. Its note is adopted too: *"the large half is where the room is"* is search-space **size**, not density, so it enters as **P-D12**, a hunch the sweep scores, and not as evidence |
| **6** (rank 6) | should the two `√5` orbits enter the sweeps despite scoring 3? | **ADOPTED** (§3.2 item 4). `(18,0,0,6)` joins the large half's sweep; `(0,4,8,0)` is already in the small half's. One run out of 57, and the only excluded material within one of his threshold on either half. Its **P6 deflation test is adopted as a reading**: thirteen excluded orbits sit closer to his cut and score lower, so degree is not monotone in radius and his radius negative is a fact about his *filter* (§1(e)3) |
| **P5** — the census dispute | which reading of his admission rule, and does the menu grow? | **RESOLVED, and the plan takes (b)**: 57 on `v412e2106`, 59 on `v403e2112`, 11 on `v166e774`; menu ≈ 69, +25% rather than a doubling, so §3.2's pricing stands and the sweep is sized at 57. The advisor withdrew its own reading when its pre-registered tie-breaker fired at 0. **Column (c) is not used**: its cross-edge control failed at 54 against the record's 18. **Reconciled here rather than left as a lead** — the stage reports `L-L 1860 + S-S 552 + cross 30`, with 12 of the 30 at the shared centre and **18 off-centre**, reproducing his `1860 + 564 + 12 + 6` exactly. The stage is sound; the discrepancy is in the advisor's separate call |
| its answer to my Q1 | the ablation is unpowered, not circular; the map is the cheaper way to run it | **ADOPTED**, including the fifth arm: `no_filter_random` measures his reserve filter, which no other arm varies, so a tie would otherwise read as "our ranking does nothing" when the truth might be "the filter does everything" |
| its answer to my Q3 | three things §§5.5–5.11 carry that no plan did | **ALL THREE ADOPTED**: the incumbent cutoff becomes **D0.5**, his second strategy becomes `many_then_trim`, and §5.11's "several tens" ceiling is §3.2's frame |
| its correction on the identity | a deficit cannot come from a bigger class, so it is not a transcription control | **ADOPTED**, and §1(e)2 rewritten. My "free transcription control" was wrong |
| its correction on the cost regime | "companion-free" is a proxy with no mechanism; the law is slack over the nearest refutation | **ADOPTED**, §1(b) rewritten, and its consequence registered as **P-D0b** — the expensive asks are near the optimum, which is where the loop's longest iterations are |
| its riders on the edge sweep | exhaustive gives the exact edge minimum; edge removal can never make a vertex removable | **ADOPTED**, and the second is in §PA(e)3: it is why the sweep cannot cost the vertex claim or phase C's C4.1 |
| **inherited from phase C** — card 8 (score his device first) | | **ADOPTED as D2** |
| inherited — the necessary-atom rule | | **ADOPTED as D3's proxy, corrected**: necessary means *in every minimum of a complete level* (336), not *a singleton in the harvested `Y`* (312); and its scoring of his move is a consequence of D1, not free. The advisor withdrew "free" on being shown this |
| inherited — card 6 (drops carry their regime) | | **ADOPTED as D0**, with the four returning items and their uses named in §1(c) |
| inherited — M3 (his priorities do not select his move) | | **carried as §3.2's premise**, re-derived by `reserve()` before any use |

---

## §M — The domain-modelling pass (WORKFLOW step 5, `debruijn-domain-modeling`, run fresh)

*Applied to phase D's five objects: the loop's state, a candidate expansion, the outcome map, a
reduction asked at a target, and the edge sweep. **Five collapses, three of which delete a code path
the skeleton would otherwise have shipped**, and three free controls that fell out of the seam hunt.*

### The cut it was run on

| intrinsic to the problem | incidental, and it had crept into the skeleton |
|---|---|
| an **atom** is a deletable unit; a stage is a working graph, a frozen part, and its atoms | atoms are *vertices*, and edges need their own instrument |
| a **candidate** is a set of base vertices not currently in `A` | `fills` and `adds` as separate fields, because his prose separates them |
| the **map** is the loop's own step function tabulated over the menu | a second function that evaluates candidates |
| a reduction is asked **relative to an incumbent** | "close the optimum" as the normal mode and a target as an exotic one |
| the **menu** is the admissible set under a *named reading* of his rule | a constant, 55 |

### The five collapses

1. **The edge sweep is the vertex reduction with edges as atoms** — the pass's largest finding, and it
   deletes an instrument. `R(S) := W with edge set S refuses four colours` is upward closed for the same
   one-line reason the vertex version is, so **M63 §O carries verbatim** and the whole apparatus — `Y`,
   phase 1, the hitting set, the completeness invariant, the bound, resume, the wall, the verdicts, the
   record schema — arrives free. **Three consequences:** the deliverable becomes the **exact** edge
   minimum rather than a greedy 1-minimal set, which is exactly what `[deGreyParts2023]` says was never
   computed; the pin's three edges become `fixed` rather than a `protect_pin` flag, where the shared
   centre already lives; and **my failed probe's bug becomes unrepresentable**, since there is no second
   CNF and no second index space to get wrong.
2. **The outcome map is `step` tabulated**, never a parallel implementation — otherwise it can drift and
   measure something the loop does not do, which is the one failure this surface exists to prevent. The
   rule is then a *policy over the same step*: the map evaluates all of it, the loop evaluates it in the
   rule's order until the budget ends. That is why scoring is well defined.
3. **`fills` and `adds` are one thing.** A candidate is the vertex set it adds; the distinction is
   provenance, which is already a field. `n_new` and the orbit breakdown become derived properties, and
   the empty candidate becomes unrepresentable — so his own recorded no-op is a constructor error rather
   than something a filter must catch.
4. **A target is an incumbent, not a mode.** Every reduction after the first has one; "close the
   optimum" is the case with no incumbent yet. This is his §5.5 read as written, and it makes
   `no-selection-at-target` the *normal* outcome of a failed candidate rather than an exotic verdict.
5. **The menu carries its reading.** Given the dispute at §1(e)3, `reserve(…, rule=)` takes the reading
   and every artifact records which one produced its count — so "49 or 57" is a field, not an argument.

### What the model now refuses to represent

A candidate that adds nothing; a candidate that stores its own size; an edge sweep with its own CNF,
its own index space or its own verdict words; a map computed by code the loop does not run; a menu whose
count does not say which reading produced it; a targeted record rendered with the word *minimum* in it.
Each was reachable in the skeleton as first written, and the first and third were live bugs.

### Seams checked, and three free controls that fell out

- **Unsampled member — the empty candidate.** Expand by nothing and reduce at the incumbent: it must
  reproduce the unexpanded level exactly. It validates the entire map pipeline against a level already
  on disk, at one entry. **Control d6.5.**
- **Adversarial member — an entry that gets worse.** Expansion enlarges the atom set, so the old
  selection survives and the minimum is non-increasing at a fixed rung. **A map entry with a larger
  `|M|` is therefore impossible, and is a bug rather than a finding. Control d6.6.**
- **Non-vacuity.** The map's instrument is exercised on a candidate whose answer is known before it is
  trusted; the identity candidate is that instance, and it is on `A412`, so it leaks nothing into the
  reproduction clause.
- **Next lemma for free.** E's held-out runs are `run_loop` with another companion; F's joint
  continuation is `run_loop` with a joint stage; G swaps the cross law, already a `Stage` parameter; and
  the edge minimisation applies to *any* stage, including whatever object F produces. Nothing in the
  model is specific to the L side or to `ρ₁₅`.

---

## §O — The obligation-modelling pass (WORKFLOW step 5, `debruijn-obligation-modeling`, run fresh)

*What phase D must **prove**, what it may only **test**, and what it **assumes**. Every proof is short
because the statement was chosen to make it short, and each is written out so an implementer can check it
rather than trust it. Nothing here is Lean: these are hand obligations over a Python instrument, and the
discipline is the same — a claim with no local obligation behind it is a `sorry` wearing prose.*

### O0 — The partition

| prove (here, by hand) | test (a planted control) | assume (named, and named again in every record) |
|---|---|---|
| non-increase under expansion (O2); the target's soundness (O3); upward closure for edge atoms (O4); what a cap destroys (O5); the degree floor (O6) | every control of §2; the identity candidate; the two parallel/serial agreements | CaDiCaL is a correct oracle; the base, group and cross-law are fixed; **his published minimality of 374 and 136**, which O6 leans on through phase C's C4.1; and that phase C's `reduce_stage` is correct, which D inherits rather than re-proves |

### O1 — The loop has no measure, the improvements are bounded, and the two are not in tension

M63 §O(3) established the absence. Phase D sharpens it in both directions.

**Why there is no measure, derived rather than observed.** `|W|` is unbounded above, since expansion adds
vertices. `{M}` grows and shrinks as `W` changes. And the obvious rescue fails: **this is not a monotone
map on a lattice, so Knaster–Tarski does not apply** — `A ↦ ⋃{M}(A ∪ Δ)` is not monotone in `A`, which is
exactly what overcompression says (M64 §R5: the minimal asymmetric graph is usually not a subgraph of the
minimal symmetric one). A fixed-point iteration with no monotonicity has no guaranteed fixed point and no
measure, and **that is a fact about the problem, not a gap in the plan**.

**What replaces it — a budget and a verdict, not a measure.** `stalled` after `stall_limit` unchanged
iterations; `max_iterations`; and the per-iteration line so a human sees the three quantities move.

**What IS bounded, and it is worth stating because nobody has:** the loop only ever accepts an improving
incumbent (O3 makes the target the incumbent), so at a fixed rung the sequence of incumbents is a strictly
decreasing sequence of positive integers, bounded below by the published `v5 ≥ 28` (§PA(d)). **So a run
starting at 375 can improve at most 347 times.** That bounds the *improvements*, never the iterations —
which is precisely the shape of the difficulty, and the honest sentence for the record.

### O2 — Expansion cannot make the minimum worse, at a fixed rung

> **Claim.** Let `W' = W ∪ Δ` with the same companion `C`, the same rung `H` and the same cross-law. Then
> `w*(W') ≤ w*(W)`, and every minimum of `W` is still a feasible selection in `W'`.
>
> *Proof.* Let `S` be a selection of `W`'s atoms with `R_W(S)`. The atoms of `W` are still atoms of `W'`
> (`H` acts on the enlarged deletable set; the old orbits are unchanged and `Δ` contributes new ones), so
> `S` is a selection of `W'`. And `W'[S ∪ fixed] ∪ C = W[S ∪ fixed] ∪ C` **as graphs**, because the
> vertices of `Δ` are not in `S` and are therefore not induced. So `R_{W'}(S)` holds with the same weight,
> the feasible set only grows, and the minimum is non-increasing. ∎

**This is control d6.6's proof**: a map entry reporting a *larger* `|M|` than the unexpanded level is
impossible, so it is a bug and never a finding.

**Hypothesis audit — delete each once, and confirm it was load-bearing.** *Same rung* is essential:
`H ↦ M_H` is order-preserving on the subgroup lattice (M64 §R10(c)), so raising the rung can strictly
raise the minimum — the L side reads 375 at rung 1 and 376 at three of its involutions. *Same companion*
is essential: a different `C` is a different key property. *Same cross-law* is essential for the same
reason. None is decoration.

**And the hypotheses have a practical form that will bite before the theory does.** The S-expansion
engineer hit it today: its per-candidate control chose *"the group image of the record's small half with
the smallest name that lies inside `A`"*, and because an expansion makes `A` larger, **more images fit** —
twelve of twenty-four at one candidate against six at the baseline — so the rule silently selected a
different image, which is a different problem that does not refuse. The control failed loudly and stopped
that candidate rather than poisoning the batch. The general statement, and it is this plan's to carry:

> **Anything chosen by a rule that reads `A` changes meaning when `A` grows.**

**So every `A`-dependent choice is pinned by value at the baseline, never re-resolved per iteration.**
Three of them are live in this phase, and the third is the dangerous one:
- the **companion's frame** — pinned by its image of `(2,0,4,2)`, which phase C's naming convention
  already does;
- the **image of any reference object** used in a control — pinned to the one the *baseline* `A` contains;
- the **rung**. A rung is a subgroup of `Aut(A)`, and **`Aut(A)` changes when `A` grows**, so `--rung
  order:2` names one group before an expansion and possibly another after it. The loop therefore carries
  its rung as an **explicit list of group elements**, resolved once, and `O2`'s *"same rung"* hypothesis
  becomes a checkable property of the run rather than an assumption about it. Rung 1 is immune, which is
  why the reproduction path is safe and F's symmetric seeds are not.

It is also the same fact as §3.3 from a second direction: a capped level gives a smaller `A`, so a rule
reading it proposes expansions the true `A` never offered and withholds ones it did.

### O3 — A target preserves completeness on success and yields a one-sided bound on failure

> **Claim.** Asking `reduce_stage` at target `t` (is there a refusing selection of weight ≤ `t`?) is sound
> in both outcomes.
>
> *Success.* The search returns `w* ≤ t` and enumerates the level at `w*`. The target removed only
> candidates of weight `> t ≥ w*`, which are not at weight `w*`, so **M63 §O(1c)'s completeness invariant
> is untouched** and `{M}` is complete at `w*`. The pruning is beat-the-incumbent pruning, which §O(2)
> already proved sound.
> *Failure.* The MaxSAT lower bound over the harvested `Y` exceeds `t`. Since `Y ⊆ Y*` gives
> `mhs(Y) ≤ mhs(Y*)`, we learn `w* > t` — a **lower bound of `t + 1`, and nothing else**. There is no
> level, no `A`, and no upper bound. ∎

**The step easy to get wrong, written down so it is not:** a failure is only a failure **if no ask came
back `unknown`**. With an undecided ask the run has not refuted the target, it has run out of budget —
verdict `unknown-at-target`, the bound stays open, and **"no improvement exists" may not be said**. This
is the same discipline `Bound.undecided` already enforces, applied to the target.

**And the reporting obligation that follows:** a record produced under a target carries
`Bound(lower, None, rung, undecided)` and **must not render with the word *minimum***. A one-sided bound
that reads like a minimum is exactly the verdict-word failure the milestone bans.

### O4 — Edges as atoms: upward closure holds, and three things do not carry

> **Claim.** For a fixed vertex set `V` and companion `C`, `R_E(S) := (V, S) ∪ C refuses four colours` is
> **upward closed** in `S ⊆ E`.
>
> *Proof.* Let `S ⊆ S'` and suppose `R_E(S)`. A proper four-colouring of `(V, S') ∪ C` is in particular a
> map on `V` proper on every edge of `S' ⊇ S`, hence proper on `(V, S) ∪ C` — so if `(V, S')` were
> colourable, `(V, S)` would be, contradicting `R_E(S)`. ∎

So M63 §O carries **verbatim**: MCS/MUS duality, phase 1 (a singleton correction set is a *critical edge*),
the hitting-set formulation, the completeness invariant and its lexicographic measure, the sandwich that
closes the bound. **The minimum hitting set over edge atoms is the exact edge minimum.**

**Three things that do NOT carry, and each is a soundness obligation rather than a detail.**

1. **`|M| = w* + 1` is a vertex-side identity** (the shared centre is the one fixed deletable-side vertex).
   For edges the objective is the edge count with no `+1`, and a record that applies the vertex formula to
   an edge run is off by one.
2. **The pin must be in `fixed`, and this is soundness, not speed.** §5.9's symmetry break is valid
   because pinning the present members of a clique to distinct colours is WLOG — which requires those
   vertices to be *pairwise adjacent in the graph being asked*. Delete a pin edge and the triangle is not
   a triangle, the break is no longer WLOG, and asks silently return `unsat` for a colourable graph.
   Phase C met the same hazard on the vertex side and its fix is the precedent (`pin_is_sound`).
3. **The object stays a unit-distance graph, and the plan says so once.** A unit-distance graph requires
   every *edge* to be a unit pair, never that every unit pair be an edge — so a refusing edge-subgraph on
   the same points is still a unit-distance witness. That is the convention `[deGreyParts2023]`'s own
   footnote uses when it discards 36, and stating it pre-empts the reader's objection that the drawing has
   been damaged.

### O5 — What a capped level destroys, stated as what it makes unsound

The **bound survives** a cap (the hitting set over `Y ⊆ Y*` is a lower bound; any verified selection is an
upper bound). What dies is everything downstream of completeness:

> **Claim.** If `{M}_capped ⊊ {M}` then `necessary({M}_capped) ⊇ necessary({M})`, and the containment is
> generally strict.
> *Proof.* `necessary` is the intersection over the level; intersecting over fewer sets can only grow it. ∎

So a capped level makes the look-ahead proxy **over-report necessity** — it would claim atoms are forced
that are not, and rank expansions by a quantity inflated in an unstated direction. Likewise
`A_capped ⊆ A`, the exchange classes and affine hull are unsound (M64 §0(ix) computes them from a complete
level by hypothesis), and the reserve built from `A_capped` is non-monotone in **both** directions, so
candidates both vanish and appear. **Together these are the proof that §3.3's halt is the right response
and a taint label was not**: there is no direction in which a sampled `A` errs consistently.

### O6 — A free degree floor on the edge minimum, and the one hypothesis it is missing

> **Claim.** Let `G` be the 509 and let `H ⊆ G` be any refusing subgraph on the *same* vertex set. Then
> every vertex `v` that is **critical in `G`** has `deg_H(v) ≥ 4`.
>
> *Proof.* `v` critical means `G − v` is four-colourable. `H − v ⊆ G − v` on the same vertices, so `H − v`
> is four-colourable. If `deg_H(v) ≤ 3`, at most three colours are forbidden at `v`, so a fourth is free
> and the colouring extends to all of `H` — contradicting that `H` refuses. ∎

**The bound, and the hypothesis I must not skip.** Phase C's C4.1 established that all **508 atoms** of the
record are critical — but **the shared centre is never an atom**, so its criticality is *not* among what
C4.1 proved. Hence, rigorously today:

`2·e(H) = Σ_v deg_H(v) ≥ 508 × 4 + deg_H(centre) ≥ 2032`, so **`e_min ≥ 1016`**,

and **`e_min ≥ 1018` once one ask confirms the centre is critical too** (is `G − centre` four-colourable?).
That ask is control **d6.8**, it costs one colourable ask, and it is the difference between a floor that
cites a hypothesis and one that assumes it.

**What the floor is worth.** It is far below the published `e5 ≤ 2406`, so it closes nothing — but it is a
floor nobody has stated, it costs nothing, and it makes the sweep **self-checking in two ways**: any
returned object with a degree-3 vertex is a bug (milliseconds per candidate), and **any reported edge count
below 1,016 is a failure rather than a record**. That is exactly the failure an edge sweep is prone to —
dropping an edge whose loss is masked by a stale incumbent — caught by an assertion rather than by a
reviewer. *Credit: Poros, 2026-09-11; the centre caveat and the 1,016/1,018 split are this pass's.*

---

## §E — The experience-modelling pass (WORKFLOW step 5, `debruijn-experience-modeling`, run fresh)

*Four consumers, and they want different things: the **implementer**, who inherits instruments; the
**product owner**, reviewing a run they did not launch; **whoever needs the machine** and must decide
whether killing a multi-hour job is safe; and the **reader of the record**, who was not here. The pass
asks one question of every surface — what does the system know here that the reader will not have?*

### E1 — Five things the system knows and no artifact in my skeleton said

1. **That a score was not stored, and why that is the point.** The map exists so a ranking invented later
   is scorable without re-running — but only if the file holds **labels and costs**, not the scores of
   the rankings we happened to think of. A reader who finds `his_move_rank` and nothing else will assume
   the stored scores are all there are. **Corrected:** the map stores per-candidate verdicts and costs,
   carries an explicit `note` saying any ranking is a read-off from it, and `his_move_rank` is labelled a
   diagnostic rather than a result.
2. **Which block an entry came from — the difference between an unbiased map and a biased one.** A reader
   seeing 30 of 57 entries cannot tell a random 30 (unbiased for every ranking) from the top 30 by his
   degree order (biased for exactly the comparison the map exists to make). **Corrected:** every entry
   carries `block` and `block_index`, and the headline says whether the random block is complete.
3. **Whether an entry was asked at a target.** `no` under target `t` means *"cannot reach `t`"*, not
   *"no improvement is possible"* — a one-sided bound wearing a verdict. **Corrected:** every entry
   carries `asked_at_target`.
4. **That an `unknown` is not a `no`.** With conflict-slice budgets, `unknown` is reachable, and a
   two-way density silently folds undecided candidates into refusals — inflating every ranking's apparent
   precision. **Corrected:** the density is **three-way and never two**, and `not_run` is a fourth field
   so a truncated map cannot be read as a complete one.
5. **Whether a kill is safe right now, and what it costs.** Phase C's progress line gives the
   checkpoint's age; a loop needs more, because an iteration spans an expansion ranking the checkpoint
   does not cover. **Corrected:** the per-iteration line ends with `kill-safe:` naming exactly what a
   relaunch redoes.

### E2 — The verdict vocabulary, extended, with the one confusion that matters

Phase C's closed list, plus phase D's: `no-selection-at-target`, `unknown-at-target`, `level-truncated`,
`stalled`, `map-entry-impossible`, `map-identity-agrees`, `map-parallel-identical`,
`edge-sweep-impossible`, `edge-sweep-wrong-graph`, `pin-edge-protected`, `centre-critical`,
`rule-read-his-data`, `no-op-expansion`, `proxy-cannot-separate`, `batch-agrees`, `rungs-agree`,
`contains-a-known-minimum`, `provisional`.

**No word means "clean"** — phase C's rule — and phase D adds a second: **no rendering may present a
one-sided bound as a minimum.** That is the confusion this phase is most likely to ship, because the
target knob makes one-sided bounds the *common* outcome of a sweep rather than an exotic one. So
`Bound.render()` on a targeted failure reads

```
no refusing selection of ≤ 373 (lower bound 374, rung 1, 0 undecided)
```

and the word *minimum* is unreachable in that branch by construction, not by discipline.

### E3 — Refusal texts, pinned as golden strings

Following phase C's genre — what happened in the reader's vocabulary, in which space the judgement was
made, and what to do next, pasteable. The self-tests assert the rendered text, because the message is the
product:

```
loop refused to start: the record data/m62/m63-joint-….json carries `A_sample`, not `A`.
  Its level was capped at 64 minima, so its union is a sample of the accumulator and not the
  accumulator. The loop's state variable is the union of ALL minima at the size.
  Exhaust the level first:  --max-minima 0 --phase2-wall 7200 --checkpoint <path>
  Or raise the rung, which keeps a complete level at a smaller one:  --rung order:2
```

```
refused to render a targeted search as a minimum.
  This run asked "is there a refusing selection of ≤ 373?" and the answer was no.
  That is a lower bound of 374, not a minimum of 374: an untargeted run may still find
  a smaller selection that this one never enumerated.
  Ask for the minimum:  drop --target
```

```
map refused to report a density: 2 of 57 entries are `unknown-at-target`.
  An undecided candidate is not a refused one, and folding them together would inflate
  every ranking's precision. Decide them or report the three-way split.
  Raise the budget on those two:  --slice-conflicts 400000 --wall-ask 1800 --only 17,42
```

```
edge sweep returned an impossible object: vertex (0,0,0,0) has degree 3.
  Every vertex critical in the 509 has degree ≥ 4 in any refusing edge-subgraph (plan §O6),
  so this object cannot refuse four colours and the sweep has a bug — most likely an edge
  dropped against a stale incumbent. The run is abandoned, not reported.
```

### E4 — The escalation, now in two currencies

Phase C's §E5 template covers a vertex count below 509. Phase D adds the **edge** currency, and it needs
two lines phase C's does not, because the objection is different — a reader's first thought on hearing
"we removed edges" is that the drawing is no longer unit-distance:

```
An edge minimisation returned <E> edges on 509 vertices, below the published 2406.
  problem     the assembled record, edges as atoms, pin edges fixed
  bound       <Bound.render()>        exact / one-sided: <which>
  floor       ≥ 1016 by the degree argument (1018 with the centre's criticality, control d6.8)
  still UD    every edge kept is a unit pair; a unit-distance graph does not require every
              unit pair to be an edge — the convention [deGreyParts2023] fn.2 itself uses
  geometry    exact unit-distance re-check: <pass/fail, how many edges>
  refutation  CaDiCaL <version>, LRAT proof <path>, checked by <tool>: <result>
  prior state 2442 in [Parts2020a]; 2406 in [deGreyParts2023] fn.2, by a NON-exhaustive discard
  NOT yet done: the Lean kernel certificate (phase F). This is not a record until that lands.
```

### E5 — What the record must not make the reader compute

A reviewer reads the head and stops, so the map and the loop records open with `headline` and `density`
and only then the per-entry table. Three things are stated rather than left derivable: **the reading of
his admission rule** that produced the menu (without it the count 57 is uninterpretable), **whether the
random block completed** (without it no precision estimate is meaningful), and **which entries are
`provisional`** under the unverified cross-edge column. Each is a fact the system holds at write time and
the reader cannot recover at read time.

### E6 — Three corrections this pass made to my own skeleton

1. The map schema stored no `block`, so a truncated map would have been uninterpretable — and truncation
   is the *expected* outcome if D0 reads expensive, which makes this the likeliest artifact to ship.
2. The density was two-way, which would have folded `unknown` into `no` and inflated every ranking.
3. The per-iteration line ended at the checkpoint's age, which answers "is a kill safe?" but not "what
   does it cost?" — the two questions whoever needs the machine actually holds.

---

## §A — The product owner's approval

*Pending. Implementation may not start until this section records it.*
