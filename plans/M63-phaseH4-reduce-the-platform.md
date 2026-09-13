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

---

## §12 — The pilot: 99.25% accept, flat — and the number NOT to quote (2026-09-12)

Checkpoint, log and the 552-pattern acceptance instance at `~/source/descent-engine/scratch/h2pilot/`, with
the resume command beside them.

| | |
|---|---|
| attempted | **400** |
| accepted / rejected | **397 / 3** |
| solver asks | **60** — batches drive cost, not deletions |
| cost | **15.0 minutes, one core** |
| per-100 windows | **99%, 100%, 99% — no decline** |
| opening control | refuted in 63.0 s **before anything was spent** |

Order is a **seeded uniform Fisher–Yates shuffle with a different seed** from the nested-prefix result — an
independent draw, not a replay.

**The 75-of-100 and the 99.25% are not in conflict; they measure different things.** A nested prefix stops
at its first rejection. This loop **bisects, refuses the boundary vertex permanently, and continues** —
rejections being permanent by monotonicity is exactly what lets one forward pass complete.

**Full pass, from this:** at batch 8, ~3,800 asks ≈ **16 core-hours** — and **the walk is sequential, so that
is ~16 hours of WALL CLOCK and does not divide by the core count.** Batch size is an unexercised lever: at
99% accept, batch 64 would cost ~1,550 asks ≈ 6.4 core-hours.

### The number not to quote, flagged by the engineer before anyone asked

The harness prints *"final size ≈ 258 of 25,567"*. **It is unquotable.** A linear extrapolation of a rate
measured over **1.6%** of the candidates, and **it cannot hold**: the reduction terminates at a minimal
refuting subgraph, so the accept rate **must** fall to zero. Early on almost nothing is needed — mean degree
21.3, minimum degree 6, massively redundant. **The pilot measured the redundant regime; the critical one has
not been entered.**

> **And it is exactly the number that would answer a question Kooshi asked today — whether this object can
> beat the 509-vertex record. A number that happens to answer the question you were asked is the one to
> distrust hardest.** It was volunteered rather than extracted, which is why it will not reach a report.

### The process miss, owned

I asked for the outcomes to be written down in advance; they were not. **Both were genuinely reachable —
three rejections landed — but "both were reachable" is weaker than "I said in advance which would mean
what", and only the weaker claim is available.** Pre-registration exists to prevent exactly that. Required
for the probe.

### The cost finding, now in `CLAUDE.md`

Scattered runs show **~75% expensive probes against ascending's 24%** — and the 24% came from a walk that had
**already fallen into the cheap satisfiable regime.**

> **A successful walk is the expensive walk.**

A cost measured on a failing run understates a succeeding one, here by 3×, and the tell is that **the cheap
steps are the failures.**

### Also landed

- **The `u16` work order, gate green** — 273 tests, 269 in-binary controls, clippy at `-D warnings`. **Three
  of four saturations DELETED rather than guarded**, so the bad case is unrepresentable instead of checked,
  with three new refusals covering the boundaries a type cannot, **each shipping a faithful partner that must
  pass** so a reader can tell the refusal came from the width and not the scaffolding. Both planted and
  watched red. It ran past twenty minutes because the type rippled through 15 files across six crates — named
  rather than left to stand. **Filed, not fixed:** `descent-fmt` has no in-binary control file, so two of the
  refusals are unit tests that do not ship; a courier-machine operator hitting the width refusal cannot run
  its control. Pre-existing, one crate's work.
- **The engineer killed its own three in-flight walks** the moment a correction of mine arrived — capturing
  their state first — because they were producing records under a superseded question. This project's own
  kill rule, applied by an agent to itself. It kept what they were worth: the ascending flip **reproduced
  exactly at step 30**, and the expensive-probe rate above.

### Authorised

**The probe only: accept rate at 5,000 and 10,000 attempts, resumed from the checkpoint.** Still ~99% at
10,000 makes the full pass near-certain; **a knee before then locates the critical regime, which is the
number that actually decides the final size.** Sixteen hours of sequential wall clock is too much to spend
before knowing where the knee is. With **outcomes pre-registered**, the **batch-size lever exercised** (larger
while accepts are cheap, shrinking as the knee approaches), and the rate **reported as a curve, since the
knee's location is the deliverable.**

---

## §13 — DIRECTION CHANGE: abandon shrinking, grow instead (Kooshi, 2026-09-12)

> *"I think we should abandon the shrinking path anyway. Going to 6 means we need to make the object as
> rigid as possible, which means growing. While we're measuring it, check its additive colorings and gauge
> and whatnot to see how far off we might be."*

**Accepted, and the reasoning is sharper than "growing helps".**

**Reaching six goes through additive rigidity, and this project holds the theorem in the kernel:**
`forces_of_additivelyRigid` and `six_le_chromaticNumber_plane_of_additivelyRigid` (ledger row 51) — an
additively rigid object **forces a pair**, and a forced pair at five colours spindles to `χ ≥ 6`. Rigidity is
therefore **upstream** of the other routes rather than an alternative to them: it *produces* the forced pair
that row 43's and G48's mechanisms need.

**And rigidity is a CLOSURE property.** The gauge `γ = Σ(components − 1)` counts **disconnected** two-colour
Kempe subgraphs, so **more edges close it and fewer edges open it.**

> **Shrinking moved the one dial that matters in exactly the wrong direction.** A minimal refuting subgraph
> is a size record; it is not a step toward six.

That also retires the question this phase was opened on. **Whether this object beats the 509-vertex record
is no longer worth the sixteen sequential hours to find out** — 509 is a size record in a 5-sealed field
that can never reach six.

### What the kill forfeits, named rather than left to disappear

- **The knee location** — where the accept rate breaks — and with it the minimal object's size. **The
  question of beating 509 goes UNANSWERED rather than answered negatively.**
- The probe's pre-registered outcomes, now unneeded.

**What it does not forfeit:** the reduction machinery is built, gate-green and **checkpointed**, with its
resume command written down — confirmation requested that resuming would not cost a rebuild, **while that
knowledge is cheap rather than in a month.** The `u16` correctness fix stays; it was to shipped code, not to
the reduction.

**Banked from the pilot, because it outlives the direction:** 99.25% accept over 400, flat; **60 solver asks
bought 400 deletions — batches drive cost, not deletions**; ~3,800 asks at batch 8 against ~1,550 at batch
64; **a successful walk is the expensive walk**; and the unquotable extrapolation, kept as unquotable with
its reason attached.

### The new main line: one dial, two curves

The family-keeping measurement is promoted from a side question and gains its second half:

> **As the object grows, does the gauge `γ` fall faster than the additive family dies?**

The two move **against** each other, and that tension is precisely what
`plans/STUB-family-keeping-thickening.md` was minted to dial. Growth follows its derivation **D1**: new
points must be **in-lattice** or **new-direction**, never **rational of order divisible by 5**.

**Its own P2 is registered against us and its author expected the principle to fail:** *no
in-lattice-plus-new-direction thickening reaches `γ̄` below half its value before its family falls below
100*, medium confidence. **Never tested on this field. Now being scored on our object.**

### The honest size of the target, stated up front

**G42: Exoo–Ismailescu's `G` is the only object here with `γ = 0`, and only WITH its cheats** — the gauge is
measured on a graph **including its non-unit edges**, never on the unit-distance graph alone. And *"every
unit-distance object held is Kempe-open by orders of magnitude."*

> **No pure unit-distance graph in this project has ever been rigid.** So the deliverable is **how far off we
> are, in orders of magnitude** — and if the honest answer is that the target has never been reached by any
> unit-distance object, that is the headline rather than a footnote.

**A gauge that falls is one obstruction receding, not rigidity achieved. Un-eliminated is not alive**, and
the gap G42 measures is orders of magnitude, not a margin.

---

## §14 — The reduction closed out, and the engine runs the RIGHT way for growth (2026-09-12)

### Resumability: tested, not asserted

**The checkpoint was resumed rather than declared resumable.** It loaded `accepted=981 rejected=4
cursor=985`, ran one further attempt, saved `accepted=982 cursor=986`. **Restarting costs one opening
control (~60 s) and no rebuild of anything.** State at the kill: **985 attempted, 981 accepted, 4 rejected**;
adaptive batching had climbed to **b = 128** and taken one halving on a rejection, the policy behaving as
designed.

**Two things came free with that test.**

1. **The registered end-of-run negative control fired and passed** — deleting 5,000 extra candidates returned
   **SATISFIABLE in 0.05 s**. So the acceptance test still discriminates, and **the 99% accept rate was a
   property of the object rather than of a broken instrument.** That validates the whole pilot retroactively.
2. **A defect in the engineer's own harness**: on a *resumed* run the summary divides cumulative accepted by
   this-invocation attempted, printing `accept_rate=982.000` and `final size ≈ −25,015,433`. Windows and
   checkpoint are correct; **the summary line and its projection must be ignored on any resume.** Its own
   description is the right one: *"same species as the unquotable 258 — a number that would read as a finding
   to anyone who did not know how it was computed."* **Two such numbers from one harness in one day.**

### The batch lever, measured without a confound

**Every policy replayed over the pilot's own recorded accept/reject sequence, rather than run a second
time** — one run, one population, exactly one thing differing — **with the control that the replay reproduces
the pilot's exact 60 asks.** The lever is worth **2.31×, not the ~2.9× estimated, and it saturates at 64.**
And **adaptive is slightly WORSE than fixed 64** at a 99% accept rate (2.14×): the halving and re-climb are
pure overhead until the rate falls. **Installed in `CLAUDE.md`** — a second run would have compared two
populations and one policy at once, and would likely have buried the adaptive result in noise.

### Addition versus deletion, answered from the code

> **The engine is asymmetric, and it runs the RIGHT way for the new direction.**

- **Solver layer: addition is native.** `SubsetSolver::admit` adds each new variable's clauses and every edge
  to an already-admitted variable **on a live solver**, idempotent and order-free, **keeping everything
  learned.** And it is structural rather than lucky: **CaDiCaL can only add clauses, never remove them** — so
  **deletion was the awkward direction**, the one needing the presence-literal trick, and it is the one being
  abandoned.
- **Data-model layer: growth IS a rebuild** — `GroupGraph` and `enumerate::Stage` have **zero `&mut self`
  methods between them**, each freezing its edges at construction. **But the rebuild is not the cost:** parse
  plus construct plus emit the full 1,267,897-clause formula measures **0.12–0.13 s** against solves of
  15–70 s — **about 0.2% of one ask.**

**Three things for a growth work order:**
1. `admit` lives in the pool/halo model, not the bare-graph one, so a growth loop needs an `admit`-shaped
   method of its own. Small; its design is already written down and controlled.
2. **The `u16` ceiling becomes LIVE under growth** — 2.5× headroom at 25,567, edges unbounded, added points
   walking toward it. **As of today it refuses loudly instead of emitting a formula for a different graph** —
   and the engineer named that as **luck, not foresight**: *"which I did not anticipate when I flagged it."*
   Same shape as this file's rule that an instance found by prior context is not evidence a rule reproduces.
3. **The number it refused to guess.** Everything measured today was a **fixed clause set with varying
   assumptions**; growth adds **permanent** clauses, and the memory model was fitted on fixed clause sets.
   *"Addition is cheap per operation"* is answered. **"Does a growing instance stay cheap over thousands of
   additions" is UNMEASURED, and it is the first number a growth work order should take.**

### Sequencing

**Not commissioned yet.** The family-keeping-and-gauge measurement decides whether growth is worth pursuing
at all — if the gauge does not fall faster than the additive family dies, there is nothing to build. **Measure
before building, which is the rule this phase has now been taught twice.**

### Housekeeping

`CLAUDE.md` is at **146,433 of its 150,000-character budget**. Several of today's entries are candidates for
compression at the next close; the budget is a ceiling and never a licence, and superseded text should come
out whether or not there is room.

---

## §15 — The gauge measured: our field IS family-keeping, and GROWING MAKES RIGIDITY WORSE (2026-09-12)

Record: `plans/M63-phaseH4-familykeeping.md`; evidence `data/m63/`.

### The positive half

**`ℚ(√3,√7,√11)` is family-keeping.** The `ρ₆₃` arena keeps **96 ℤ/5-homomorphisms exactly** — 24 colour
partitions — over its **63 distinct unit directions**, with **0 of 63 directions 5-divisible**. By **complete
enumeration of all `5⁸ = 390,625` maps**, which *is* the whole space, **so there is no generator gap** — the
failure mode that has produced three false zeros in this milestone cannot occur here.

**The family dial, by construction stage:** `48 → 2,304 → 240 → 96` (base · plus copy · plus 30 diagonal
cross edges · plus 36 off-diagonal), with `2,304 = 48²` exactly. **By radius: flat at 96 from `r = 4.000` to
`r = 5.000`, provably** — growth adds no direction and not one cross edge. **Shape is de Grey's (never dies),
not `F₂₄₇`'s (collapse).**

**D1's classifier, predicted then measured, and derived rather than lucky:** adjoining the copy is
**272,298 of 272,298** unit vectors new-direction (48 of 48 distinct), **0 killers**; radius growth is
**63 of 63** in-lattice, **0 killers**. The derivation: `ρ` moves every `K`-point outside `K²`, so the two
`ℚ`-spans meet only at 0, and a unit vector with `u/5` in the module would need norm `1/25` where every norm
lies in `(1/144)ℤ[√33]`.

> **So *"the one field we hold that is both 6-open and family-keeping"* is false. There are two, and ours is
> at half the degree — 8 against 16.**

### The negative half, and it refutes the direction I accepted four hours ago

On the **pure unit-distance graph, no cheats**:

| | |
|---|---|
| `γ̄` | **1,118.0** (γ = 107,328 over the family; 26,832 over its 24 partitions) |
| two-colour Kempe subgraphs **disconnected** | **960 of 960 — not one connected**, the best splitting into 33 components |
| `γ̄` as the arena grows 51,133 → 79,657 → 121,381 | **1,118.0 → 1,380.0 → 1,700.0** |
| what the whole cross structure (126 edges of 544,530, **0.023%**) is worth | **2.4% of `γ̄`** |

> ~~**GROWING MAKES THE GAUGE WORSE — up 52%.**~~ **WITHDRAWN 2026-09-12, same evening, by Kooshi: *"growing
> doesn't make rigidity worse. The gauge is just an upper bound, and scales with vertices."* He is right, and
> this is the EIGHTH instance in this milestone of a number read without its units — the fifth of them mine,
> and made hours after I installed the rule against it.**

**`γ` is EXTENSIVE — it sums `(components − 1)` over every two-colour subgraph, so it scales with vertices by
construction.** Reading its rise as a worsening credits to rigidity a change that belongs to size. The
agent **reported the vertex counts alongside**, so the data was there and both of us still misread it —
**printing the population beside the verdict is not enough; you have to DIVIDE.**

**The arithmetic, done properly:**

| vertices | `γ̄` | `γ̄ / n × 1000` |
|---|---|---|
| 51,133 | 1,118.0 | **21.86** |
| 79,657 | 1,380.0 | **17.32** |
| 121,381 | 1,700.0 | **14.01** |

> **`γ̄ ~ n^0.485` — essentially `√n`, on two independent steps (0.475 and 0.495). The NORMALISED gauge falls
> 35.9% while the object grows 2.37×.** Growth is making this object **relatively more connected**, not less.

**What that does and does not license, stated separately because they point opposite ways.**
- **For the object's relative health, growth wins**: component density falls like `1/√n`. Had `γ̄` scaled
  like `n`, growth would be useless; at `√n` it is slowly gaining.
- **For the target, `γ` must reach ZERO**, and `√n` is monotonically increasing — so **growth alone does not
  reach rigidity under this scaling**, which is a different and much weaker statement than "growing makes it
  worse". A power law never hits zero.
- **And I do not know which of those bears on the design**, because *"the gauge is just an upper bound"* is a
  claim about `γ` I have not verified: if `γ` overcounts — if some disconnected components are mergeable by
  means the count does not see — then even the second bullet is too pessimistic. **`γ = 0 ⟺ rigid` is how
  G42 states it; whether the computed `γ` is that quantity or an over-estimate of it is the open question,
  and it decides the direction.**

**The mechanism, stated as a reading rather than a derivation:** the only thing that closes the gauge is
**cross edges** — 0.023% of the edges moving `γ̄` by 2.4%, roughly **100× the per-edge effect of base
edges** — and **cross edges are capped at 126 by the endpoint bound, which is proved.** Radius growth adds
rim material, and phase H3 measured this family's rim to be thin, so it adds components faster than it
connects them. **The lever that works cannot be grown; the lever that can be grown works backwards.**

### FS-6's P2: MET, at a factor of twenty — first test outside `K(√247)`

From base-plus-copy (family 2,304, `γ̄ = 1,146.0`), the D1-clean thickenings take the family **below 100**
with `γ̄` having fallen **2.4%** against the **50%** P2 says it will not reach. **Its author registered it at
medium confidence expecting the principle to fail. It failed, on a second field, by twenty times.**

**By the stub's own §7, that hands the question to FS-2 — what carries forcing without rigidity.**

### The honest size, which was stated before the numbers arrived

**No pure unit-distance graph in this project has ever been Kempe-closed, or had even ONE connected
two-colour subgraph.** The sole `γ = 0` object is Exoo–Ismailescu's `{1,2}`-graph gauged **with** its 423
non-unit edges. **Ours is now the largest pure unit-distance object ever gauged here, and it is 100% open.**

### Two structural findings worth more than the verdict

1. **The arena's additive family FACTORS the same way its refutation does.** An additive `k`-colouring is a
   **pair** `(f, g)` of base colourings satisfying the cross-edge disequalities — **the `k = 5` twin of the
   object's own `k = 4` refutation certificate** — costing a rank-4 enumeration instead of rank-8. The same
   decomposition at both colour counts is a fact about type-M arenas, not about this object.
2. **The circle's multiplier kills `k = 4` and is harmless at `k = 5`**: `t ≡ 0 (mod 4)` gives `φ(tu) = 0` in
   every group of order 4. **That is phase H3's `4 | n` screen reached from the additive side** — two routes
   to one mechanism.

### Controls, and one incident

Eight controls, all seen to do something. **Known positive reproduced first** (Heule-510's 3,456 → 96,
identical fingerprints); the object rebuilt to its certificate on five counts; **zero shown reachable on the
same object** (`k = 4` gives 288 → 0); **two-sided plant** (adding direction `5u` → 0 homs with the
5-divisibility counter reading 1; adding `3u` → 96 unchanged).

**Incident, and it is a hazard `CLAUDE.md` names.** The **shared scratch directory** held another agent's
`additive.py`, and this agent's scripts put it on the module path — the *"loads two versions and identifies
them by name"* trap, with the registry being `sys.modules`. **It was caught only because the foreign module
lacked the class needed; had it had one, every number would have been wrong while printing normally.** Now
guarded by a provenance assertion, provoked and seen to refuse. **G51 already says to isolate each agent's
scratchpad because a shared temp directory is a covert channel; this is that rule firing for a second
reason.**

### A prediction of its own, scored not met

It predicted the full arena's family would be **zero**; it is **96**. Its heuristic treated the 36
off-diagonal constraints as independent — they cut by **2.5×, not 10⁻⁴**.

### What it wants checked, and the asymmetry is stated correctly

**That 96 counts the right set — that no unit direction is missing.** On this instrument **a missed direction
removes a constraint and makes the family TOO LARGE, so here a positive is the fragile verdict and a
refutation is the robust one** — the opposite of the usual asymmetry, and correctly identified. It verified
all 96 against its own edge list (**0 monochromatic edges in 52,274,880 checks**); the cheap independent check
is to rebuild the arena by another route and re-verify the stored homomorphisms against *that* edge list.

---

## §16 — The compulsion sweep: NOTHING, in either polarity — and my filter was self-defeating (2026-09-12)

Record: `plans/M63-phaseH4-sweep.md`; instrument `tools/arena_sweep.py` (`--self-test` green, 8 controls);
evidence `build/m63-phaseH4-sweep/` with resume commands; `data/fplane/spectral-p83.json`.

### The verdict

| | population | survivors |
|---|---|---|
| **forced pairs** | **1,307,266,278** — every pair | **0**, from model 80 |
| **virtual edges** | **1,306,721,748** — every non-adjacent pair | **0**, at model 4,480 |

**Certified by 4,480 exhibited proper five-colourings, each verified edge by edge. No solver UNSAT
anywhere — the survivor set is a SUPERSET of the truth by construction, so no positive could have hidden.**

**The stakes were maximal, not incremental:** `Forces.planeIn` with `not_colorable_of_forced_equal` means a
single forced pair at **any** distance ≥ 1/2 would have been **χ(ℝ²) ≥ 6 outright**, and row 55's usual
arithmetic bar genuinely does not apply in a 6-open field. **This was the first sweep in which a five-colour
forced pair was arithmetically permitted at every distance.** It is empty.

### And the emptiness is NOT about the field

**Three more objects, five seconds each.** Heule-510 and Heule-553 sit in a **5-sealed** field — G48's
*source* side, where the bar does apply — and also return **0 and 0**.

> **Four objects, both sealing statuses, the same null. The emptiness is not a field effect.**

That extends G31 from "existing witnesses hold nothing" to something stronger: **a produced, purpose-built
object in an unsealed field is just as empty.**

### My filter was invalid for two independent structural reasons

**1. The field has no sealing prime, and this is a THEOREM rather than bad luck.** The five-colour residue
law needs a **usable** prime whose finite plane is 5-colourable. Our field is multiquadratic, so every
Frobenius has order ≤ 2 and "odd residue degree" collapses to "degree one"; `fplane.py usable` enumerates the
entire supply — **83, 131, 167, 227, 479, 503, 563, …**, nothing below 83 — and at 83 the exact Kloosterman
spectrum gives a Hoffman floor of **5.743**, so χ ≥ 6, with every larger one ≥ 6 by Weil (threshold q ≥ 98).

> **A field is 5-sealed exactly when some usable prime's plane is 5-colourable — which IS the filter's
> hypothesis. So "6-open" and "residue-filterable at five colours" are COMPLEMENTARY BY DEFINITION: any
> object worth sweeping for χ ≥ 6 is un-filterable this way, necessarily.**

**My filter proposal was self-defeating by construction**, and that is a general fact, not a fact about this
object.

**2. My base–base rescue fails at a named step.** `Forces` is monotone **upward** in the graph
(`Forcer.Forces.mono`), so refuting a pair in `G[base]` says **nothing** about `G`. Refuting in `G` needs a
proper colouring **of `G`**, and **any** one does the job equally — the residue colouring has no operational
advantage even where it exists.

### And the cost model I built the filter on was wrong by three orders of magnitude

**I said 363 hours. It took about half an hour.**

My figure assumed **one solver call per pair**. **This project's own instrument has never worked that way** —
`rigidity.py` settled all 1.25 M pairs of the 1581 in **37 models and 30.2 s**. Actual cost here: 240 solver
calls for a colouring pool (~8 min) plus **1,212 s of single-core sweeping**. **The filter was never needed,
and I spent a message explaining to Kooshi why the sweep was unaffordable.**

### The critical-vertex screen: applies as a theorem, inert here, and for a flattering reason

De Grey's three critical vertices exist because his object is a **1-sum** — the whole coupling sits on one cut
vertex plus one edge. Measured on ours: **every interface vertex carries exactly one cross edge, maximum
cross-degree 1 across all 51,133.** **The screen that emptied his graph is inert here precisely because this
object is better built.** No solver hours were bought to certify that null, and the agent said so.

### Settled in passing, and it belongs in the ledger

> **χ(arena) = 5 exactly.** Nothing on record had the upper half. CaDiCaL could not find a five-colouring in
> 300 s; an explicit construction took **0.7 s**.

### The live residual, and the design number

**Arity 3 is NOT settled.** Swept on the **163 interface vertices only** — `1.6 × 10⁻⁷` of the space, **a
choice and not a derivation** — 3,502,728 questions leave **337 candidates**. **The arity-2 null makes any of
them irreducible if real.**

**The design number this hands over:** deleting **66 of 544,530 edges** four-colours the arena (verified, with
a paired control), so by the spare-colour lemma **the object's entire compulsion budget is 66 edges — 36
off-diagonal once G52's free diagonal is removed.**

> **Rank future bases on the compulsion budget, not on circle count.**

### What it wants checked — not the null, the edge list under it

**A missing unit edge makes colouring easier, produces more refutations, and reads as a CLEANER null.** It
checked: six decades of tolerance return exactly **544,530 edges, 0 missing and 0 extra**, nearest non-edge
**seven orders of magnitude** away. **But it checked in floating point, against coordinates rebuilt from a map
read out of `recon.py`** — and if that map is not the one that produced the committed list, its geometry and
its edge list are **two views of different objects that agree**, which is this repository's named
module-identity failure. **The specific check to buy: an independent exact re-derivation of the 126 cross
edges by code that is not `typem.CrossLaw`.**

### Three failures it logged against itself

A wall-clock flag that **was invalid and read as "unknown"** — a check reporting nothing when it cannot run,
now loud. **P-SW-2 missed by 18×**, from transferring a per-model decay rate off a **32× smaller** object.
And **three generator faults, each of which looked like a fact about the object and was a fact about the
generator** — every one caught by **a count that plateaued.**
