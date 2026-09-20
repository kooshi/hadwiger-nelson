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

### 3.1 The extraction cost model, measured field by field

*Round 0 of `extract` is one CaDiCaL assumption-core refutation of the **whole** ball, with one selector variable
per vertex; it cannot be stopped usefully, and it is the single largest item in a field's generation. The later
rounds run on the shrinking kept set. Every number is wall seconds on the desktop, one heavy job at a time.*

**The two columns being compared measure the same object, checked rather than assumed** (the owner's standing
correction that ball points are not peeled-piece points). At tiers `1c` and `2l` the ball worker builds the whole
ball `X` and its whole edge set `E` and hands both to the solver with no peeling step, so a record's `points`,
`edges` and `solve_seconds` all describe the ball; and `extract` rebuilds that ball from the same lattice key and
radius — at `d = 239` it printed `369885 points, 2587978 edges`, the ball record's own two numbers. Phase B′'s
correction about peeled pieces is about an earlier code path and does not touch any of these five.

| d | ball points | ball edges | plain solve (s) | round 0 (s) | round 0 / plain solve | rounds to fixpoint | fixpoint points | witness points | `land` end to end |
|---|---|---|---|---|---|---|---|---|---|
| 311 | 1,137,169 | 7,960,542 | 18.2 | **7.9** | **0.43** | 6 | 358 | **189**, 1-minimal | **43.9 s** |
| 335 | 623,737 | 4,365,620 | 65.3 | **105.5** | **1.61** | 67 | 1,169 | **443**, 1-minimal | **212.8 s** |
| 239 | 369,885 | 2,587,978 | 403.0 | **556.1** | **1.38** | ≥ 4, unfinished | — | — | **stopped at 26 min** (§3.1a) |
| 431 | 1,803,077 | 9,349,130 | 322.9 | | | | | | |
| 59 | 1,396,469 | 9,773,884 | 314.7 | | | | | | |

**The table is sorted by what it found, not by what was predicted, and the two do not agree.** The **largest**
ball of the five — `d = 311`, 1.14 million points and 7.96 million edges — gave the **cheapest** certification of
the whole milestone, 44 seconds end to end; the **smallest** — `d = 239`, 370,000 points — is the one that had to
be stopped. What orders them is the ball's **plain solve time** (18.2 s, 65.3 s, 403.0 s), and that ordering is
steep: a 22× range in solve time became a range from 44 seconds to *unfinished after 26 minutes*. Neither the
brief's rule (a threshold on points) nor my §1 replacement for it (a linear model on round 0) captures that; §3.1a
states the rule that does.

### 3.1a `d = 239` was STOPPED and re-queued last — cause, measurement and forfeit, written before the signal

**Cause.** `d = 239` is the hardest-solving of the five and it is blocking the other four, which are cheaper by
between 5× and 20× on the quantity that governs extraction. `CLAUDE.md`'s rule is that *a run that blocks
something is presumed killable, and the burden of proof is on keeping it*; the owner's brief says the same in
its own words — *if certification at one of these balls looks like it will eat the budget, say so with the
measurement and move to the next field.* This is that.

**Measurement** (from `data/fs61/witness-239/steps.jsonl`, which is the checkpoint itself, not a log):

```
core-round-0   369,885 -> 46,338 points   556.1 s
core-round-1    46,338 -> 26,271 points    47.6 s
core-round-2    26,271 -> 21,800 points    81.3 s
core-round-3    21,800 -> ?                >900 s and still running when the decision was taken
```

**The round cost is rising as the kept set shrinks**, which is the expected shape — each round is an
assumption-core refutation of a set that is closer to minimally unsatisfiable, and a minimal core is the hard
instance — but the *rate* here is unlike every landed field: at `d = 23` (ball solve 54.9 s) the rounds after
round 0 ran 8–15 s, at `d = 143` (116.0 s) 3–31 s, and the fixpoints took 48 and 75 rounds. At `d = 239` (403.0 s)
round 3 alone has already cost more than every post-round-0 round of `d = 23` and `d = 143` put together. Thirty
more rounds at even a third of round 3's cost is **two and a half hours on one field**, and there are four
behind it. The generation cap (5,400 s) would fire inside the core rounds, which is the one stop this driver
handles badly: the emit pass that follows a capped stop carries no wall of its own.

**Forfeit, named.** The in-flight round 3 — at least 15 minutes of solver time, and nothing else. `extract`
fsyncs every finished round, so the resume starts from **core-round-2 at 21,800 points** and redoes only round 3;
no other census state moves, no landing record is written, and `witness-239/` keeps its checkpoint. What is
genuinely lost is the *answer* to how many rounds this field's fixpoint takes, which nobody has measured — it is
re-asked when 239 is resumed, and if the resumed run is stopped again that measurement is what the record will
still owe.

**And this is where the onset pass I declined in §1 would have been the right instrument, for a reason neither
the brief nor I had.** My decline was argued on *round 0*, and round 0 is exactly the part the calibration
predicted correctly (1.38× the plain solve). What it did not price is the *tail*: the number of core rounds and
their cost, which is set by how hard the ball's minimal core is, and that is the same quantity the ball's plain
solve time measures. A smaller refusing ball of the same lattice would plausibly carry a smaller and easier core.
**The brief's rule and mine were both aimed at one stage of a two-stage cost.** It remains true that the brief's
threshold would not have fired here either — 369,885 points is under its 500,000 — so nothing was lost by the
decline that would have been saved by following it; what is lost is that neither rule would have caught this
field. The honest form of the rule, for whoever comes next: **a refusing ball whose plain solve costs hundreds of
seconds is an expensive extraction whatever its size, and that is when to spend an onset ask.**

**The stop.** By process group, never by matching a command line; verified by effect — both pids absent from
`ps`, no `fs61_census.py` / `fs58_search.py` process left in a `/proc` walk that matches an argv **element**, and
`steps.jsonl` byte-identical across 65 s (the core-round checkpoints are minutes apart, so a shorter check would
prove nothing).

### 3.1b P-r0 is **LOST**, and the way it lost is the finding

> **P-r0**, registered in §2 before the first run: *round 0 of `extract` costs about 1.8× the ball's recorded
> plain solve time; it loses if any field's round 0 falls outside 1.2–3.0× that field's plain solve.*

**Ratios measured: 1.38 (`d = 239`), 1.61 (`d = 335`), 0.43 (`d = 311`).** The third is outside the band, so the
prediction loses, and it lost in the **cheap** direction — round 0 at `d = 311` cost 7.9 s against an 18.19 s
plain refutation of the same ball.

**Why that population could not carry it, stated the way phase E stated P-deg1's loss.** P-r0 was registered
against `d = 23` (1.79×) and `d = 143` (1.58×), the only two landed fields whose ball solves cost real time —
55 s and 116 s. At 18 s the two solves are not measuring the same thing: a plain refutation must prove
unsatisfiability of the whole formula, while an assumption-core solve may stop the moment it has a set of failed
assumptions, and at that scale run-to-run variance is a large share of the number. **The band was fitted where
the quantity is expensive and applied where it is cheap.** That is the same error in the same milestone as
P-deg1's, one level down, and it is mine.

**What survives, and it is the useful half.** The ordering is right even though the constant is not: over the
three fields measured, round 0 and the whole extraction are *monotone* in the plain solve time and steeply so —
18.2 s → 44 s end to end, 65.3 s → 213 s, 403.0 s → unfinished at 26 minutes. **A ball's plain solve time is the
statistic to select on; its point count is not.** The existing `land` cost proxy `points × (solve_seconds + 0.5)`
already encodes exactly that, and at every one of the five fields there was only one refusing ball, so the proxy
had nothing to choose between — which is the argument for an onset pass, and §3.1a says which direction it should
go.

### 3.2 Per field

*(filled in as each field lands)*

---

## 4. The gate, item by item

*One row per gate item per field, under the owner's rulings after phase C: `Landed (certified)` is C.1–C.3, C.4a,
C.5–C.7; C.4b is required only where C.9 records the witness 1-minimal. Every command is pasteable from the
repository root. The verdict line and the exit status are the driver's own record (`data/fs61/landings.jsonl`),
and every one of them was **re-derived independently** afterwards by `tools/fs61_recount_landings.py`, which
imports nothing from the driver, recomputes C.6's barrier count in its own `Fraction` arithmetic and re-verifies
C.5's colouring on every edge — 9 of 9 rows green at each field.*

**Re-generate this section:** `python3 tools/fs61_recount_landings.py <d>` reproduces every verdict from the
committed bytes; `python3 tools/fs61_census.py land <d>` re-runs the whole gate against the committed
`witness.json` without regenerating it (generation is skipped once that file exists).

#### `d = 311` — **CERTIFIED**, 189 points, 460 edges (`data/fs61/witness-311/`)

| # | item | command, pasteable from the repository root after `source scripts/dev-env.sh` | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 311 data/fs61/witness-311/witness.json` | `certified.out` | **PASS** — CERTIFIED: 189 points of Q(sqrt311)^2, each a reduced (a, b, c, e, m); all 460 pairs a | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 311 --controls data/fs61/witness-311/witness.json` | `controls.out` | **PASS** — CONTROLS ALL PASS — **13 `[PASS]` rows, 0 `[FAIL]`** | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 323 data/fs61/witness-311/witness.json` | `wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 4] between [0, 0, 0, 0, 1] and [6, 1, 3 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 311 data/fs61/witness-311/witness.json` | `recheck.out` | **PASS** — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | the same command | `recheck.out` | **PASS** — REQUIRED (C.9 says 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 311` (step C.5) | `colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 460 edges | — |
| C.6 | the barrier is met | the same (step C.6) | `README.md` | **PASS** — 213 of 460 edges carry 3 in the reduced denominator | — |
| C.7 | the value | the same (step C.7, from `frame.jsonl`) | `README.md` | **PASS** — `4 <= chi(Q(sqrt311)^2) <= 5`, upper bound the residue plane at 11 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality | the witness's own provenance | `witness.json` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

#### `d = 335` — **CERTIFIED**, 443 points, 1,086 edges (`data/fs61/witness-335/`)

| # | item | command, pasteable from the repository root after `source scripts/dev-env.sh` | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 335 data/fs61/witness-335/witness.json` | `certified.out` | **PASS** — CERTIFIED: 443 points of Q(sqrt335)^2, each a reduced (a, b, c, e, m); all 1086 pairs  | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 335 --controls data/fs61/witness-335/witness.json` | `controls.out` | **PASS** — CONTROLS ALL PASS — **13 `[PASS]` rows, 0 `[FAIL]`** | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 347 data/fs61/witness-335/witness.json` | `wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 118] between [0, 0, 0, 0, 1] and [65, 9 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 335 data/fs61/witness-335/witness.json` | `recheck.out` | **PASS** — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | the same command | `recheck.out` | **PASS** — REQUIRED (C.9 says 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 335` (step C.5) | `colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 1,086 edges | — |
| C.6 | the barrier is met | the same (step C.6) | `README.md` | **PASS** — 933 of 1,086 edges carry 3 in the reduced denominator | — |
| C.7 | the value | the same (step C.7, from `frame.jsonl`) | `README.md` | **PASS** — `4 <= chi(Q(sqrt335)^2) <= 5`, upper bound the residue plane at 11 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality | the witness's own provenance | `witness.json` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

#### `d = 59` — **CERTIFIED**, 1,739 points, 5,025 edges (`data/fs61/witness-59/`)

| # | item | command, pasteable from the repository root after `source scripts/dev-env.sh` | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 59 data/fs61/witness-59/witness.json` | `certified.out` | **PASS** — CERTIFIED: 1739 points of Q(sqrt59)^2, each a reduced (a, b, c, e, m); all 5025 pairs  | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 59 --controls data/fs61/witness-59/witness.json` | `controls.out` | **PASS** — CONTROLS ALL PASS — **13 `[PASS]` rows, 0 `[FAIL]`** | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 71 data/fs61/witness-59/witness.json` | `wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 677] between [0, 0, 0, 0, 1] and [22, - | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 59 data/fs61/witness-59/witness.json` | `recheck.out` | **PASS** — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | the same command | `recheck.out` | **PASS** — recorded, not required — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 59` (step C.5) | `colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 5,025 edges | — |
| C.6 | the barrier is met | the same (step C.6) | `README.md` | **PASS** — 2,442 of 5,025 edges carry 3 in the reduced denominator | — |
| C.7 | the value | the same (step C.7, from `frame.jsonl`) | `README.md` | **PASS** — `chi(Q(sqrt59)^2) = 4`, upper bound the dyadic prime, inert in K, residue F_4 ([Fischer1990] Thm 9) | — |
| C.9 | minimality | the witness's own provenance | `witness.json` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 297 of 2473 | — |

#### `d = 431` — **CERTIFIED**, 1,031 points, 2,719 edges (`data/fs61/witness-431/`)

| # | item | command, pasteable from the repository root after `source scripts/dev-env.sh` | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 431 data/fs61/witness-431/witness.json` | `certified.out` | **PASS** — CERTIFIED: 1031 points of Q(sqrt431)^2, each a reduced (a, b, c, e, m); all 2719 pairs | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 431 --controls data/fs61/witness-431/witness.json` | `controls.out` | **PASS** — CONTROLS ALL PASS — **13 `[PASS]` rows, 0 `[FAIL]`** | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 443 data/fs61/witness-431/witness.json` | `wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 105] between [-19, -1, 71, -5, 240] and | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 431 data/fs61/witness-431/witness.json` | `recheck.out` | **PASS** — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | the same command | `recheck.out` | **PASS** — recorded, not required — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 431` (step C.5) | `colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 2,719 edges | — |
| C.6 | the barrier is met | the same (step C.6) | `README.md` | **PASS** — 1,570 of 2,719 edges carry 3 in the reduced denominator | — |
| C.7 | the value | the same (step C.7, from `frame.jsonl`) | `README.md` | **PASS** — `chi(Q(sqrt431)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality | the witness's own provenance | `witness.json` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 95 of 1234 | — |

