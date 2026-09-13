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

## §2 — Why the obvious route is dead, stated with its arithmetic

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
