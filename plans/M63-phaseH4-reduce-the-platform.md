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
