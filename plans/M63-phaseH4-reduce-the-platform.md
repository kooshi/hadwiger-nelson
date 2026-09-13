# Phase H4 — reduce the platform. Working plan and record.

*Opened 2026-09-12 at Kooshi's direction: "the next step should be an optimization focused one… If we can
turn the refutation into algebra, or use our optimized engine."*

---

## §1 — The mission, in one paragraph

Phase H2 produced a five-chromatic unit-distance graph in a **6-open** field — 51,133 vertices at `ρ₆₃` in
`ℚ(√3,√7,√11)`. Phase H3 established, by closing its own direction, that **this is the right object**: `n = 16`
is the cheapest member that is both 6-open and immune to the additive-pair attack, and nothing lies below it.
**This phase shrinks it**, so that the six-colour design target (FS-6) has something small enough to search
*inside* rather than merely to refute.

## §2 — WITHDRAWN 2026-09-12: this section's premise was a misused number

> **The claim below is FALSE and was load-bearing for this phase. The 20.03 core-hours was never a
> per-deletion cost — it was the census of a SECOND, RETIRED route (phase H2 established its verdict twice;
> the surviving argument is 20 UNSAT claims, not 552 half-refutations).** Measured on this desktop, one
> per-deletion answer is **50.6 s cold and 10.87 s warm**, so a full pass is **~77 core-hours warm, under
> five hours on this machine** — four orders of magnitude cheaper than the section claims. **The naive loop
> was never dead; I killed it with a number that measures something else**, which is the seventh instance of
> that error in this milestone and the first to be load-bearing for a phase. Kept, not deleted, per the
> project's rule. §7 and §8 carry the corrected picture.

### The withdrawn text

`[Parts2020a]`'s reduction is a loop: delete a vertex, re-ask *is it still five-chromatic*, keep or restore.
**Phase H2 needed 20.03 core-hours for one such answer on this object.** There are ~25,567 deletable base
vertices. **Even at one minute per incremental ask — far below any honest estimate — that is 426 core-hours,
about thirteen days of the full desktop.** The naive loop is not expensive, it is **dead**, and "price it,
then run it" was a proposal to spend a day discovering that. It also runs against Kooshi's standing
instruction of 2026-09-02: **better algorithms first, before compute.**

## §3 — The algebra, and why it only became available yesterday

The refutation does not run on the object. It runs on a **31-vertex interface** — the 30 circle points plus
the shared centre. An arena four-colouring is a **pair** of base colourings agreeing at the centre and
disagreeing across the interface; the refutation says no pair of achievable interface patterns survives the
cross edges (phase H2's trust core: 20 claims, and the pattern list need only be a **superset**).

**Phase H3 proved the interface pattern set is monotone non-increasing as a base grows.** Run backwards:

> **Deleting a vertex can only GROW the interface pattern set. Never shrink it.**

So the reduction is not *"re-refute a 51,133-vertex graph after every deletion"* but *"track a monotonically
growing set of patterns on 31 vertices, and stop when it grows past what the cross edges can kill."*
**Monotone means no backtracking and no cold re-solve** — precisely the property that kills the naive loop.

## §4 — Deletions we can certify with NO solver call

- **Absorption (G40, kernel).** If every proper four-colouring of `G − S` extends to `G`, then `G` is
  four-colourable iff `G − S` is — so **`S` is safe to delete, by theorem rather than by search.** Its
  cheapest instance is the 4-core peel (a vertex with fewer than four neighbours always extends); richer
  instances exist wherever a set has a spare colour.
- **Theorem B.** The base lies in `K²` and is four-colourable **however large it grows**, so no deletion can
  break the base half. **Every deletion that can matter touches the interface or the cross-edge structure** —
  a small characterised population, not 25,567 candidates.

**If those take out most of the object, the engine question changes shape entirely** — which is why they are
measured before any engine work. Phase H3's lesson was that the cheap screen should have run first; the same
trap is open here.

---

## §5 — Registered before anything ran (product owner)

### P-H4-1 — the free certificates take out LESS than 25% of this object

Phase H3's thin shape-free object gave **23%** to the 4-core (32,617 → 25,201) because it carried a long
low-degree tail including 264 isolated vertices. **`ρ₆₃` is the opposite kind of object**: mean degree
**21.30**, degeneracy **13**, and **32.1% of its base at full degree 30**. Dense objects have little to peel —
and the control at the other end is `[Parts2020a]`'s own base, which peels **374 → 374, nothing at all**.

**Prediction: the no-solver certificates remove under 25% of the 51,133-vertex arena, and I expect 5–15%.**
Scoring: met below 25%; not met at or above — which is the *good* failure, since it would mean the solver-bound
population is small and the engine matters less than I think. **Both outcomes reachable**: the two calibration
points sit at 0% and 23%, bracketing the range, and nothing ties this object to either.

### P-H4-2 — the solver-bound population is where the cost lives, and I do not have a number

**Stated as a weak prior, deliberately.** I expect **most** vertices to need an ask, because every base vertex
constrains base colourings and therefore the interface pattern set. But I have no mechanism-backed estimate
and will not manufacture one. **This is the quantity the measurement exists to produce**, and any number I
attach now would be a number with no units. *No scoring — this is a measurement, not a prediction.*

### P-H4-3 — what would change the plan

If the incremental ask under the interface formulation comes in **below ~1 core-second**, the reduction is
affordable in days and the engine is a convenience. **Above ~1 core-minute, the engine is the whole project**
and its data model must be built for the interface ask specifically. The measurement's job is to say which
side of that line we are on — **not** to produce a schedule.

---

## §6 — Work in flight

| # | work | where | state |
|---|---|---|---|
| 1 | free-deletion census + incremental ask cost on `ρ₆₃` | `lean-dir` | launched |
| 2 | survey the descent engine: what asks it supports, how fast, what its data model is | `~/source/descent-engine` | launched |
| 3 | scope the engine work order | — | blocked on 1 and 2 |

---

## §7 — The engine survey landed, and it found the evidence against this plan (2026-09-12)

Survey: `~/source/descent-engine/SURVEY-2026-09-12-interface-reduction.md`.

### What exists

**Nine Rust crates, 56,945 lines, eleven completed work orders, last commit 2026-09-02 — finished software,
not scaffolding.** The release binary's own control suite ran **269 controls, 269 passed, 5.9 s** on this
desktop today; about a fifth of all source is control suites, shipped inside the binary because the target
machine has no build tools. Standards and code agree almost everywhere; three drifts listed, none a
correctness problem.

**Two asks exist and only one is our shape.** The one the repo is named for fixes a 214-vertex colouring and
asks whether it extends to a candidate pool — irrelevant, since our arena has no fixed colouring. The
relevant one, *"does this graph admit a proper 5-colouring"*, lives in `descent-cull` and `descent-enum`, and
**is not incremental across probes by deliberate design** — a fresh CaDiCaL per probe, after measurement.
Measured here: **0.601 µs per clause loaded**; cold first solve **~1.4 s** against **1.2 ms** warm on a
1,008-vertex stage, an **832×** ratio; whole-graph refutation probes on a 1,981-vertex object averaged
**114 s**.

**The data model is already right.** A vertex deletion **never extracts a subgraph and never moves an
index** — every edge carries the groups it depends on and fails a presence predicate. And a
distinguished-subset abstraction exists: `Projection` in `descent-fmt`, an ascending column list the class
key gathers and the blocking clause names, **built because a seed deletion broke a prefix assumption in
August.** Two catches: `descent-cull` passes the identity projection and so always refutes over the whole
graph, and no command line names an arbitrary block today.

**The decisive absence: the largest bare graph ever enumerated or culled here is 1,981 vertices.** The
175,642-variable instance that looks comparable is the pool model with narrow colour lists — a materially
easier question — and must not be quoted as evidence about this object. Reported as an absence rather than
extrapolated past, which is the survey's most useful move.

### The finding that argues against this plan, and it is ours

> **"No cold re-solves" is the one premise this repository has already tested and lost.**

A walk that never re-solves cold needs one long-lived solver whose edges can vanish without rebuilding —
every deletable vertex behind a selector literal. **That encoding exists (`--encoding guarded`) and was
measured three times, all against: 1.6× slower per conflict; undecided at 900 s on a control the plain
encoding decided in 294.5 s; 1.65× the processor time to decide one fewer group.** And the palette-breaking
order cannot be fixed for a solver outliving the standing set — choosing it per probe was worth 2.1–2.9×.

**The scope cuts both ways and is the reason to measure rather than the answer.** Every one of those was a
**hard refutation under a conflict budget**; this walk mostly asks *"find a colouring whose interface pattern
is new"* on a base **known colourable by a kernel theorem**. Incremental solving under assumptions behaves
differently on satisfiable and unsatisfiable regimes, and all three measurements are from the wrong one.
**But it is the only evidence that exists, this project took it on its own instances, and it points the wrong
way.**

**Commissioned, on the survey's own recommendation: the three numbers that decide the architecture** — one
cold plain solve on the base half, one warm solve under presence assumptions after a deletion, and **the same
after a hundred deletions**, that third being the point, since a long-lived solver's failure mode is
degradation rather than first-probe cost. **No number anywhere in that repository answers them.**

### Two things I settled for both agents

**1. The walk runs on the HALVES — 25,567, not 51,133.** An arena four-colouring is a **pair** `(f,g)` of
half-colourings agreeing at the centre and disagreeing across the cross edges; the rotated half is isometric
and carries the same internal edge list, so the arena is never solved as one object. Every cost in the survey
roughly halves, and the `u16` index ceiling gains 2.5× headroom instead of 22%.

**Flagged regardless: that ceiling SATURATES SILENTLY rather than refusing**, which is this project's oldest
named failure mode — a check reporting nothing when it cannot run. One line, worth fixing before anything
runs at scale.

**2. The per-deletion ask may not be a refutation at all** — sent to both agents as a structure to check, not
a measurement to adopt. Phase H2 established its verdict twice: **(a)** 552 interface patterns with **0 of
304,704** pairs admissible, combinatorial on **31 vertices**; **(b)** 552 half-refutations, **20.03
core-hours**. **The 552 is a SUPERSET and only ever needs to be one**, so **(a) alone suffices and (b) was
confirmation.** If that survives a deletion, the ask is *recompute the superset, re-run a 31-vertex pair
check* — **and the whole cost lives in maintaining the superset**, a different engineering problem from the
one the survey scoped, and probably a better one. **Timing the refutation instead would be a right
measurement of the wrong thing — the error this milestone hit six times.** Both agents are to report **both**
costs, labelled, and never let one stand in for the other.

---

## §8 — The three measurements land, and they overturn this phase's premise (2026-09-12)

Harness `~/source/descent-engine/crates/descent-sat/examples/h2probe.rs`, raw log in that repo's
`scratch/h2probe/`. Desktop, single-threaded, `nice -n 10`, with another agent's solver on one core
throughout. It reproduced **25,567 vertices / 272,232 edges / 1,267,897 clauses / 31 delta-touched vertices**
before measuring anything, and checked the edge-versus-at-most-one classification by exhaustion in both
directions.

| | |
|---|---|
| **M0** base half alone, nothing blocked | **SAT, 0.025 s** |
| **M1** cold plain, one claim | **UNSAT, 50.6 s** |
| **M2** guarded warm-up, all present | **UNSAT, 99.2 s and 103.3 s** — a 1.96× first-solve penalty |
| **M3** 29 warm probes | **mean 10.87 s**, median **0.001 s**, 24.1% expensive (mean 44.8 s) |

### The cost wall is gone, and it was never there

**A full reduction pass is ~77 core-hours warm — under five hours on this desktop**, and about eleven even
cold. **Four orders of magnitude cheaper than §2 assumed, and none of it from any new engine**: it came from
the decomposition phase H2 already had.

### The contrary evidence is retired, by mechanism rather than by verdict

The long-lived presence-encoded solver is **4.65× cheaper per probe**, with the 1.96× first-solve penalty
**repaid inside three probes**. And the prior evidence's first-solve half **transfers exactly** — it was not
wrong. **It measured a single ask and never a walk**, and those are different quantities. That is a cleaner
resolution than my framing, which was that the old numbers came from the wrong satisfiable/unsatisfiable
regime — **and M0 refuted that framing**: satisfiable asks cost **25 ms**, every second of the 50.6 is spent
proving UNSAT, and *"this deletion changed nothing"* is proved by **exhaustion**. **No reasoning about
regimes would have produced that. The measurement did.**

### Two errors of mine, corrected against the file

1. **The interface is 66 vertices, not 31.** I conflated the genuine coupling with the counting criterion's
   object — and **that criterion fails on this object anyway**: `L = 10` against a circle count of 30, one
   third where more than one half is needed, with 72 ordered pairs surviving the diagonal-only check by
   explicit witnesses. I carried 31 into two briefs and a committed plan.
2. **The 20.03 core-hours misuse**, above — **seventh instance in this milestone, first to be load-bearing
   for a phase.** What survives of my structural reading: the 552 patterns with 0 of 304,704 pairs admissible
   (confirmed, with a discrimination ladder 18,432 → 6,144 → 4,224 → 2,688 → 768 → 0), and the superset
   property (confirmed, the record's own §10 marking achievability "not load-bearing"). **Refined:** after
   the superset simplification the solver core is **20 UNSAT claims, not 552.**

### The wall that may have replaced it, and it is mathematical

> **At deletion 30 the instance flipped to SAT and stayed there.** Twenty-nine deletions out of 25,567 were
> enough to add a **twentieth** achievable circle pattern.

The walk detects it in **22 ms**. But **the pattern superset is not robust to deletion on this object**, so a
walk meets superset growth constantly rather than rarely — and **whether the refutation survives a superset
that keeps climbing is what the reduction actually turns on.** Nothing measured yet answers it: that harness
never runs the pair check and never restores a vertex.

**Scope, stated rather than hedged:** one deletion order, **ascending index, which deletes a CLUMP rather
than a scatter.** Twenty-nine index-adjacent lattice points are plausibly far more damaging than twenty-nine
spread ones, so **step 30 is an upper bound on fragility, not a measurement of it.**

> **Deletion order is now a first-class design variable.** It was on nobody's list an hour ago.

### Commissioned

1. **The scattered-order run, with the pair check and a vertex restore** — scoring superset growth against
   *"does the refutation survive"* rather than *"did the superset grow"*, and giving a walk that can back out
   a different cost model from one that cannot. **An hour, not a week.**
2. **The `u16` fix** — four sites spelling `try_from(...).unwrap_or(u16::MAX)`, which above 65,535 emit **a
   well-formed formula for a different graph, silently.** Cannot bite at 25,567; authorised anyway at twenty
   minutes with a red-watch control per site. **The engineer declined to make the change unasked on a
   reconnaissance brief — *"I do not treat a written endorsement as a lifted constraint"* — which cost one
   round trip against a class of error that costs days. Right call.**
3. **The free-deletion census, now the more valuable half.** If absorption certifies that every proper
   four-colouring of `G − S` extends to `G`, and `S` holds no interface vertex, then `G` and `G − S` present
   **exactly the same interface patterns** — the extension is the bijection. **So an absorption-certified
   deletion should be superset-NEUTRAL where an arbitrary one demonstrably is not.** If that holds, **the
   free deletions are not merely free, they are the only SAFE ones**, and the reduction splits into a
   superset-neutral phase needing no solver and no fragility risk, then a much smaller solver-bound phase.
   **Out for checking against `Absorb.lean`'s actual statements, not against my sentence.**

---

## §9 — The free-deletion census: ZERO, and the reason is one measured fact (2026-09-12)

Record: `plans/M63-phaseH4-freecensus.md`; evidence `build/m63-phaseH4/`; checkpoints outside `build/`.

> **Free deletions: 0 of 51,133.** Base-side 0 of 25,567, copy-side 0 of 25,566. **The arena's minimum degree
> is 6, and the only absorption certificate that applies at four colours cannot see a vertex above degree 3.**

Every certificate checked against the **Lean statements**, not the ledger's summary:

| certificate | fires? |
|---|---|
| greedy absorption (`extends_of_extensionOrder`) — the 4-core peel | the only one that applies; **removes 0** |
| `extends_symCopy` | cannot — the centre is fused and 36 of 66 couplings are off-diagonal. **And it MUST not fire, or the arena would be four-colourable** |
| `extends_of_hubs` / `_matching` / `_hub_matching` | need the piece **3-colourable**; the radius-2 ball about the centre (451 vertices) is measured **not** 3-colourable |
| non-adjacent domination (folklore, not in `Absorb.lean`) | **0 of 51,066** |

**P-H4-1: met on the threshold, outside my band on the low side.** I predicted under 25%, expecting 5–15%;
the answer is **0%**. Scored that way rather than claimed as a hit.

**Controls, all before any `ρ₆₃` number:** Parts's **374 → 374** on all four variants, with his registered
5/6/7-cores (350/340/265) reproduced through the same code path; phase H3's arena **32,617 → 25,201** plus
four more registered values, **five exact**. And on the object itself the identical peeler removes 252 at
`k = 7` and 24,780 at `k = 13` — so the instrument is not simply inert.

### The superset-neutrality idea: proved, and empty

`Extends G A 4` with `S ∩ I = ∅` gives `P(G) = P(G−S)` **exactly**, both halves from statements in
`Absorb.lean`. **And it has no inhabitant on this object.** The no-solver phase does not exist here; **all
25,500 non-interface base vertices need a solver.** A clean kill rather than a hopeful one.

**The caution attached to it is worth more than the derivation.** Phase H3's 22.7% peel is **not**
superset-neutral: it deletes **120 of 241 interface vertices, including all 60 circle points.** Its claim
stands — that was about four-colourability, where the 4-core is exactly right — **it is the interface
formulation the peel breaks, object by object.** I had been carrying that 23% as a free win in two places;
**it is free for the wrong question.**

### The ask cost, now from two harnesses sharing no code

**≈46 CPU-seconds** (16 deletions across four strata, median 45.6 s, **all UNSAT**) against the engine's
**50.6 s** — agreeing to within the measured contention factor. SAT answers cost **0.4–3 s**. **That is the
number.**

### Two findings that specify the loop

- **Scattering is worth at least 2.5–3.4×**, a lower bound: random-shuffle nested prefixes survive to **75
  accepted, rejected at 100**, against ascending order's **29 accepted, rejected at 30** — and the scattered
  test blocks all 552 full patterns where the other is circle-level, so the comparison is conservative.
- **Rescue by growing the pattern list is not cheap** — ≥79 new patterns and **576 CPU-s with the enumeration
  not exhausted** — while **bisecting down after a rejection costs 0.4–3 s. So the loop bisects.**

### What the census wants checked, pointed at its own result

> *"My positive controls pass, which by this project's own rule is not evidence the zero is real."*

The specific gap it named: `Absorb.lean` is **one construction, the repaint lemma**, and **a cleverer choice
of piece colouring is exactly the free parameter it did not vary.**

**That gap has a classical name, and this is a G46 recognition rather than a search: absorption IS
reducibility.** A configuration is **D-reducible** when every colouring of its boundary ring extends into it —
`Extends` with the boundary as the ring — and **C-reducible** widens that with **Kempe chain** interchanges
before extending. Sixty years of machinery: Birkhoff's diamond, ring-colouring enumeration, the Appel–Haken
and Robertson–Sanders–Seymour–Thomas catalogues. **The reducibility half of that theory does not need
planarity** — planarity enters only in discharging, which we do not want. **C-reducibility is the systematic
version of "a cleverer piece colouring", and it is mechanical.**

**Commissioned as recognition-then-price, not construction:** search it in its own vocabulary (never ours —
"absorption" appears in no paper), then answer whether it would fire on an object of minimum degree 6, where
the relevant rings start at size 6 and ring-colouring counts grow fast. **If ring size 6 is already too
expensive, or provably never fires at four colours off the plane, that is a finding that retires a
direction.** The reduction is affordable without it, so its value is **a theorem we would own**, not an
afternoon saved.

### Commissioned: the loop, piloted

Warm long-lived presence-encoded solver; **scattered** order with the choice stated; **restore and bisect**
on rejection; **the pair check as the acceptance test**, so a deletion is scored on *"does the refutation
survive"* and not on *"did the superset grow"*. **A few hundred deletions, reporting the ACCEPT RATE and a
projected final size — about an hour against five for the full pass. The full run is not authorised until
that rate is on the table**, since a loop whose accept rate collapses at 300 has a different answer from one
that holds.

**Minor correction folded in:** phase H2's "8,208 at degree 30" is **8,239** — the 8,208 counted a
272,262-entry list with its 30 repeats.

---

## §10 — Reducibility: recognised exactly, and CLOSED by 61 orders of magnitude (2026-09-12)

Record: `plans/M63-phaseH4-freecensus.md` §10. Bibliography updated with `[Steinberger2010]`, Appel–Haken,
Robertson–Sanders–Seymour–Thomas, Borodin, Erdős–Rubin–Taylor and two Cranston–Rabern surveys;
`tools/bib_audit.py` green.

### The recognition was exact

**D-reducible IS `Extends`, verbatim** — a configuration `S`, ring `R = N(S) ∖ S`, D-reducible when every
proper four-colouring of the ring extends into it. **Our 4-core peel is the degeneracy corner of a machine
built between 1913 and 1996.**

And the second discipline handed over a boundary we did not have: **Borodin (1977) and
Erdős–Rubin–Taylor (1979) — a connected graph is degree-choosable iff it is not a Gallai tree** — so
free-by-degree deletion at four colours needs `deg ≤ 4`, not `≤ 3`.

**Singletons are dead by a two-line theorem rather than a measurement:** any graph on ≥ 4 vertices has a
*surjective* proper four-colouring (split a class), so `{v}` is D-reducible **iff `deg(v) ≤ 3`**. The 4-core
peel is not an approximation to singleton D-reducibility — **it is singleton D-reducibility.**

### The verdict, and it is arithmetic

| the classical machinery | `ρ₆₃` |
|---|---|
| ring size ≤ 14 (Appel–Haken, RSST), ≤ 16 (Steinberger) | **no configuration of ≤ 27 vertices exists anywhere** — exact closure, not a search |
| cost **×4 per unit of ring size**; ring 16 ≈ "a few minutes" | smallest non-singleton ring **77**; at the smallest permitted size (28) the best greedy ring is **161** |
| 199,291 ring colourings at ring 14 | ≈ **2 × 10³⁵** at ring 77 — about **4⁶¹** times a few minutes |

**Closed, and the closure is exact rather than a failed search.**

### My planarity claim was half wrong, and it was the half that mattered

I briefed that *"the reducibility half of that theory does not need planarity."* **True of D. False of C — and C was the whole point**, since C-reducibility is the systematic version of the "cleverer piece colouring" the census named as its unvaried free parameter.

C-reducibility's power comes from **consistent sets of colourings**, and Steinberger §2 buys that in one
step: *"Because `G` is planar, each `V_i` is a subset of the same component of `R ∖ V_j` for all `j ≠ i`."*
The Kempe classes on the ring form a **non-crossing** family, and his "signed path arrangements" are that
fact's bookkeeping. **Off the plane the disjunction runs over ALL partitions instead of the laminar ones —
so non-planar C-reducibility is STRICTLY HARDER, not merely more expensive.**

**§PA negative, recorded as a finding:** no application of reducibility off the plane exists in the
literature, and §10.3 says why that is an obstruction rather than an opening.

### A claim of its own that the check refuted, and the correction is worth more

It wrote that the Gallai-tree refinement would bite on Parts's base, whose minimum degree is 4. **It does
not:** the 18–24 degree-≤ 4 vertices there are **pairwise non-adjacent**, so every candidate piece is a
single vertex, and a single vertex **is** a Gallai tree. Controls fired (`C₄` is not a Gallai tree; `K₃`,
`P₃`, `K₁` are). **So the reusable screen is not "minimum degree ≤ 4" but "do the degree-≤ 4 vertices touch
each other in a piece containing an even cycle?"** — rarer, and **zero on both objects we hold.**

### Correction folded in

Phase H2's `8,208 (32.1%)` at full unit degree 30 is **`8,239 (32.2%)`**, fixed in place in all three live
locations with no correction trail.

---

## §11 — A claim of mine to the product owner's own report, corrected before it cost anything

I told Kooshi that a compulsion sweep of this object *"does not depend on the reduction finishing."*
**That is wrong.** De Grey's swept object is 1,581 vertices — **1.25 M pairs**. Ours is 51,133 —
**1.31 BILLION pairs, about 1,046×.** At even a millisecond per pair that is 363 hours. **The sweep as I
described it is not affordable and does depend on the reduction.**

**What rescues it is one of this project's own theorems rather than more compute.** Ledger row 59: the
residue colouring identifies two `K`-points **iff** their distance lies in the prime above 2, so **a
forced-monochromatic pair needs `v_𝔭(d) > 0`** and a virtual edge needs `v_𝔭(d) = 0`. That is an **exact,
cheap, arithmetic pre-filter** on the pair population, applied before any solver sees anything — and G39
confines a forced pair's critical set to `N(p) ∩ N(q)`, which filters again.

> **So the sweep is affordable — but as *arithmetic filter first, solver second*, not as a sweep.** Stated
> here because the corrected version is the one to run, and because the uncorrected version was one
> authorisation away from costing a fortnight.
