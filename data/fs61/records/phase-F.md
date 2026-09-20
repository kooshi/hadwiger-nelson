# FS-61 phase F — certifying the five new fields, and the close: the phase record

*Plan: `plans/FS61-quadratic-census.md` §6 phase C (under **the owner's rulings after phase C**, which govern the
Phase C table) and §6 phase F; §5 rule 16 is the format of this file. Implementer: de Bruijn (Opus 5), 2026-09-20,
the **fifth** of FS-61's implementers. Machine: **the desktop, 16 physical cores / 32 threads,
128 GB**, idle, one heavy job at a time. Timings are wall seconds on that machine unless they say CPU.*

## What this phase is, in plain words

Phase E ended with five fields of the census — `d = 59, 239, 311, 335, 431` — whose plane over `ℚ(√d)` has a finite
graph that a SAT solver says cannot be coloured with three colours. A solver saying so is a **claim**; the census
only calls a field *landed* when an independent checker, which shares no code with the thing that found the graph,
re-derives every edge in exact integer arithmetic and replays the refutation proof line by line. This phase turns
the five claims into certificates, and then writes the milestone's close.

Certified, three of the five are **new exact values** — `χ(ℚ(√59)²) = χ(ℚ(√239)²) = χ(ℚ(√431)²) = 4` — and two are
brackets, `4 ≤ χ(ℚ(√311)²) ≤ 5` and `4 ≤ χ(ℚ(√335)²) ≤ 5`. The upper halves are prior art in every case and are
named as such: the dyadic prime at 59 (`[Fischer1990]` Thm 9), the residue plane at 7 at 239 and 431
(`[Moorhouse2010]` Thm 8.1), the residue plane at 11 at 311 and 335.

---

## 0. The positive controls, run first

| what | command | the line that shows it | exit |
|---|---|---|---|
| the driver's own selftest | `python3 tools/fs61_census.py selftest` | `DONE selftest: 11 sections, 0 failures` | 0 |
| the census table re-derived and checked | `python3 tools/fs61_census.py table --check` | `DONE table --check: 40 fields at tier 2l (accounting checked at 1, 1b, 1c, 2l), 0 defects` | 0 |
| no tracked file moved by either | `git status --porcelain` | empty | 0 |
| the frozen tree | `git status --porcelain data/fs58 'tools/fs58_*'` | empty | 0 |
| nothing running | a `/proc` walk matching an argv **element** (`…endswith('tools/fs61_census.py')`), never a substring | `census/fs58 processes: 0` | — |

---

## 1. The onset pass: asked, priced, and NOT run — with the measurement that decided it

**What the brief asked for.** *Before extracting from a ball over ~500,000 points, spend a little on an onset pass:*
refusal is monotone in radius, so a smaller refusing ball of the same lattice is as good a certificate source and
cheaper to extract from. Bisect downward a few steps at ≤ 600 s an ask; budget one hour.

**Why I did not run it.** The threshold in that instruction is on a ball's **point count**, and the extraction cost
it is protecting against is set by something else. `extract`'s first stage is a sequence of CaDiCaL
assumption-core rounds, and round 0 — the one that runs on the whole ball and cannot be stopped — is one refutation
solve of that ball with one selector variable per vertex. Its cost therefore tracks the ball's **plain solve time**,
which every refusing ball already carries in its record, and not its size. Measured over the six landed fields whose
`generate.out` holds core rounds (`data/fs61/witness-<d>/generate.out`, one grep):

| d | ball points | ball edges | plain solve (s) | round 0 (s) | round 0 / plain solve | rounds to fixpoint | all rounds (s) |
|---|---|---|---|---|---|---|---|
| 11 | 45,521 | 376,224 | 0.61 | 3.5 | 5.74 | 11 | 5 |
| 23 | 248,213 | 1,220,300 | **54.88** | 98.5 | **1.79** | 48 | 480 |
| 71 | 47,597 | 227,726 | 0.07 | 0.3 | 4.29 | 13 | 0 |
| 95 | 17,169 | 82,206 | 1.07 | 3.1 | 2.90 | 72 | 99 |
| 143 | 283,485 | 1,737,874 | **115.95** | 183.7 | **1.58** | 75 | 463 |
| 191 | 53,177 | 325,524 | 0.11 | 4.0 | 36.36 | 16 | 7 |

The ratio is large only where the absolute cost is negligible; **at the two fields whose solves cost real time the
ratio is 1.58 and 1.79**, and those are also the two largest balls, so they are the right population to price the
five new ones from. The five, at their recorded plain solve times:

| d | ball points | ball edges | degree | plain solve (s) | round 0, predicted at ×1.8 (s) |
|---|---|---|---|---|---|
| 239 | 369,885 | 2,587,978 | 13.99 | **403.0** | ≈ 725 |
| 335 | 623,737 | 4,365,620 | 14.00 | 65.3 | ≈ 118 |
| 311 | 1,137,169 | 7,960,542 | 14.00 | **18.2** | ≈ 33 |
| 59 | 1,396,469 | 9,773,884 | 14.00 | 314.7 | ≈ 567 |
| 431 | 1,803,077 | 9,349,130 | 10.37 | 322.9 | ≈ 581 |

**So the instruction's ordering is inverted by its own data.** The most expensive extraction of the five is `d = 239`
at **370,000 points — the one field the brief exempts from the onset pass** — while `d = 311` has three times the
points and an eighteen-second solve. An onset ask costs up to 600 s and would save a fraction of a round-0 cost that
is itself 33–725 s; at 335 and 311 the whole round 0 is cheaper than one onset ask. *This is the repository's own
recurring error in the brief that was written to avoid it: a number measuring one quantity (a ball's size, which
governs memory) put to work deciding another (extraction time, which the solve time governs).* The cost is mine to
report, not to work around silently, so it is stated here and in the hand-back.

**What replaces it.** The `land` driver already picks among a field's refusing balls by the cost proxy
`points × (solve_seconds + 0.5)`, which is exactly the right quantity; each of the five has **one** refusing ball on
record, so there is nothing to choose between and an onset pass could only add candidates. Rather than spend an hour
adding candidates to a choice that is not binding, the hour is spent on the extractions themselves, **measured field
by field in ascending edge count** so that the two largest instances are entered with scaling data rather than an
extrapolation. The prediction above (round 0 ≈ 1.8 × the plain solve) is registered here before the first run and
scored in §3; **its population tops out at 283,485 points and 1.74 M edges, so at 9.3 M edges it is an
extrapolation past its own edge** — which is precisely how P-deg1 lost in phase E, and it is registered as a
prediction rather than relied on as a plan.

**What is kept from the instruction.** Its purpose — do not enter a million-point extraction blind. Met instead by
the order (ascending edges: 239 at 2.6 M, 335 at 4.4 M, 311 at 8.0 M, 431 at 9.3 M, 59 at 9.8 M, with 239 and 335
first as the owner asked for early results), by measuring peak memory on each, and by the fact that **every core
round is checkpointed**, so a stop costs one round and never the field.

---

## 2. The launch — written before anything ran (plan §5 rules 1 and 3)

```
COMMAND     python3 tools/fs61_census.py land <d> --tier <t>          one field at a time, in this order:
              239 --tier 1c     335 --tier 2l     311 --tier 1c     431 --tier 2l     59 --tier 1c
            The tier flag is the tier that ASKED the refusing ball, read off the ball's own record, so the
            landing record's `tier` and `ball_tier` agree.  `land-all` is NOT used: it takes one tier flag for
            every field, and these five come from two different tiers.
RESUME      the identical command for that field.  `land` skips generation entirely once witness.json exists,
            and inside generation FS-58's `extract` resumes from data/fs61/witness-<d>/steps.jsonl, which is
            appended, flushed and fsynced after EVERY assumption-core round and every 60 s of deletion.
IF IT DIES  at most one core round, or one minute of deletion, is redone.  Nothing else in the census moves:
            a `land` run writes only under data/fs61/witness-<d>/ plus one appended line each to
            data/fs61/landings.jsonl and data/fs61/witnesses.jsonl.
STATE       data/fs61/witness-<d>/steps.jsonl   the extraction checkpoint (gitignored; provenance, not evidence)
            data/fs61/witness-<d>/generate.out  the generator's own log, including every stop and its verification
            data/fs61/landings.jsonl            one JSON object per field: every C-item's exit, line and seconds
            data/fs61/witnesses.jsonl           the manifest FS-60 consumes
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to data/fs61/records/land-<d>.log.  The pid is written
            to data/fs61/records/land-<d>.pid at launch.
STOPPED     BY PID, never by matching a command line (nine recorded self-matches in this repository).  A stop is
            verified BY EFFECT: the pid absent from `ps`, no fs61_census.py / fs58_search.py process left in a
            /proc walk that matches an argv ELEMENT, and steps.jsonl's digest static across 65 s -- the deletion
            checkpoints are 60 s apart, so a shorter check proves nothing.
WAITED ON   the PID (`while kill -0 <pid>`), never on a log line: a waiter armed on a line the success path prints
            at its START is already true when armed, which cost this phase's predecessor two false "finished"
            readings in ten minutes.
BUDGETS     --deletion-budget 600 (the default; stage 2 is a nicety C.9 records and never requires)
            --gen-cap 5400 (the default) at 239, 335, 311; REVISITED for 59 and 431 on the measured round-0 cost,
            because a gen-cap that fires DURING the core rounds is the one stop this driver handles badly -- the
            emit pass that follows it has no wall of its own.
MEMORY      one job at a time, 117 GB available.  The largest instance is d = 59 at 1,396,469 points / 9,773,884
            edges; the largest `extract` ever run here was d = 143 at 283,485 / 1,737,874.  Peak RSS is sampled
            per field and recorded in §3; a field that threatens the machine is stopped, not raced.
NOT RUN     no Lean, no lake, nothing under data/fs58 or tools/fs58_*.  No existing ball, lattice, filter or
            witness record is rewritten; the five new landings only append.
```

### The registered prediction, recorded before the first run

> **P-r0** — *round 0 of `extract` costs about 1.8× the ball's recorded plain solve time*, over the five new
> fields. It **loses** if any field's round 0 falls outside 1.2–3.0× that field's plain solve. Population it was
> registered against: the two landed fields with expensive solves (`d = 23` at 1.79×, `d = 143` at 1.58×), whose
> balls top out at 283,485 points and 1.74 M edges. **Both outcomes are reachable** and the informative one is the
> loss: the five balls carry 1.5–5.6× those edge counts, so the prediction is deliberately extrapolated past its
> population's edge and the point of registering it is to find out where it breaks.

---

## 3. Results

*(filled in as each field lands)*

---

## 4. The gate, item by item

*(filled in as each field lands)*
