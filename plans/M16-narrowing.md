# M16 — Narrowing (stub)

*Carry-forward notes, written 2026-08-02 as M15 closed. Not yet subplanned.*

> **M15 made a fan's *existence* free and left its *narrowness* exactly where it was. Narrowness is
> now the entire problem, so it gets its own milestone.**

---

## 1. The entry point, which M15 did not have

**Four pivots are known to carry a five-colour fan**, in the one graph that sits at the χ ≥ 5
boundary and was never shrunk:

| graph | pivots with a five-colour fan | cost to confirm each |
|---|---|---|
| de Grey's 1581 | **630, 633, 1420, 1423** | 5,955–6,763 s (1.7–1.9 h) |

Two rotation-symmetric pairs — `1420 − 630 = 1423 − 633 = 790`, his halves' index offset — and the
count matches M07's independent single-deletion sweep. M15 § 0(g).

So M16 does not open by searching for a fan. It opens with four of them and one question:

> **Does any of these four fans narrow to a single spindle-able distance class, at width 1, or at
> width 2 with the partners diametrically opposite the pivot at `r² = 1/2`?**

Anything wider cannot be closed — two unit circles meet twice — so the win condition is unchanged
from M14 and is a small target, not a scale.

## 2. What M15 measured that shapes this

* **Existence is free; narrowness is untouched.** M15's hunt glued two copies of a five-chromatic
  witness, making every vertex of one copy removable by construction. Six candidates, every one
  carrying a fan, **none** with the fan confined to a single distance class.
* **The shrunk witnesses are dead ends and this is proved**, not assumed: `heule510_no_five_fan`,
  `heule553_no_five_fan`. Do not re-search them.
* **Spindling does not narrow the fan at its own pivot** (M14 § 0(k)) — the narrower fan appears at
  a *different* pivot, so every move demands a re-scan.
* **Five colours is cheap to satisfy and brutal to refute.** See § 3.

## 3. The triage rule — chase the cheap answer, park the expensive one

**This is a scheduling rule, and § 4 is the discipline that keeps it from becoming a claim.**

Both questions the search asks have the same polarity:

| question | SAT | UNSAT |
|---|---|---|
| is `G − p` colourable with one colour fewer? | **no fan here — reject** | a fan sits here |
| is `G` with the pivot joined to `Q` still colourable? | **not a fan — reject** | **a fan of that width** |

**The rejection is always the SAT answer, and SAT is the cheap one.** Almost every candidate is
rejected, so almost every solve is fast. The rule:

> **Give every solve a short budget. A fast SAT clears the candidate and the sweep moves on. A solve
> that does not answer inside the budget is *presumed* to be the expensive branch — presumed a hit —
> and is written to a deferred-leads log with everything needed to rebuild it, then abandoned for
> now.**

What a lead must carry to be resumable, since "come back to it" is worthless without it: the
candidate's **construction** (the seed set and the exact sequence of moves that built it), the
**pivot**, the **partner set and its squared distance**, the **colour count**, the **elapsed time**,
and the **budget it was cut at**.

**The operating point is measured, not guessed.** M15's de Grey sweep at a 300 s budget:

| | |
|---|---|
| pivots settled fast | **1,566 of 1,581** (99.05%), a rejected pivot costing about a second |
| deferred | **15** (0.95%) |
| of those, real hits | **4** (27% of deferrals) |
| of those, slow negatives | **11**, costing 189–387 s each to settle later |

So 300 s is a good starting budget at this scale: it defers under 1% of the work and a quarter of
what it defers is real. **Deferral is not free** — eleven of the fifteen were negatives whose cost
was moved rather than avoided — which is the argument for a log that lets the deferred queue be run
once, in bulk, at leisure, rather than re-derived.

## 4. What the presumption may never do

**A presumed UNSAT is a decision about where to spend time. It is never a verdict, and it never
reaches Lean.** This project's standing rule is that UNKNOWN is not folded into either answer, and
this milestone is precisely where a failure-open would enter, so:

* the log records **`DEFERRED`** with its elapsed time — never `unsat`, never "fan found";
* a summary line states the deferred count **unconditionally**, so "no fan found" is never readable
  without knowing how much was skipped (M15 gave `Filtered.line()` this shape already);
* a lead becomes a claim only after a **full-budget re-run settles it**, exactly as de Grey's four
  pivots were settled at four hours each after being deferred at 300 s;
* nothing Lean checks rests on the presumption — the certificate is colourings and refutations, and
  a deferred solve produces neither.

The negative control that must be watched: inject an oracle that never answers, and confirm the
sweep reports every candidate deferred and **refuses to print a verdict about the graph** — not that
it found nothing.

## 5. Open, and to be settled at subplanning

* **Whether the four known fans narrow at all.** If they do not, M16's result is another honest
  negative, and the next question is whether a *different* construction can produce a narrow one.
* **What to do with a width-2 fan that is not in the closable geometry.** M14 measured the closing
  move works at width 1 and at exactly one width-2 configuration. A width-2 fan elsewhere is a near
  miss with no known move — worth knowing whether one exists before designing for it.
* **Cost of narrowing at de Grey's scale.** Each distance-class test is a five-colour question on
  ~1581 points. M15 measured five-colour refutation at 511 points at 447.7 s; at 1581 it is unmeasured
  and must be measured before the sweep is designed.
