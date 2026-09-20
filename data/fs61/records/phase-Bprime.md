# FS-61 phase B′ — tier `1b`, the radius ladder: the phase record

*Plan: `plans/FS61-quadratic-census.md`, the owner's re-plan after phase B, ruling 2; §5 rule 16 is the format of this
file. Implementer: de Bruijn (Opus 5), 2026-09-20, the third of FS-61's implementers. Machine: **the desktop, 16 physical cores / 32 threads, 128 GB**, idle, one heavy job at a time, 16 workers. Timings are wall seconds
on that machine unless they say CPU.*

## What this phase is, in plain words

Phase B asked, of every lattice the census could not already close with a certificate, whether a ball of radius 1.5
around the origin can be coloured with three colours. It could only ask when the ball fitted under a cap of 600,000
points. **It did not fit 77 times out of 110**, and at thirteen fields it did not fit even once — so those fields'
"nothing found" measured the cap and not the field.

A ball is a product of two discs, so it holds points in proportion to `R⁴`: the same lattice at radius 1.2 holds 0.41
of the points, at radius 1.0 holds 0.20. Phase B′ walks that ladder down under the **same** cap and the **same**
600-second solver wall. Every refusal anywhere on record sits at a radius between 1.0 and 1.5, so this is the same
question asked lower down, not a different one. **Tier 1's definition, records and verdicts do not move**: tier `1b` is
a new id in `data/fs61/tiers.json`, and a standing check in `selftest` asserts that tier 1's fingerprint
(`7a520f29e32724da`, which 343 committed ball records carry) has not changed.

## The launch — written before anything ran (plan §5 rules 1 and 3)

```
COMMAND     python3 tools/fs61_census.py ladder-all --jobs 16
RESUME      the identical command.  Finished FIELDS are read back from data/fs61/ladder-progress-1b.jsonl and
            skipped; inside a field every rung of every lattice is its own JSONL line in
            data/fs61/fields/<d>/balls.jsonl, appended, flushed and fsynced as it lands, and a re-run recomputes
            the ladder from those records.  So a kill at any instant redoes AT MOST the balls in flight
            (at most 16) plus the unfinished part of one field.
STATE       data/fs61/ladder-progress-1b.jsonl    one line per finished field
            data/fs61/fields/<d>/balls.jsonl      one line per (lattice, radius), carrying tier "1b"
            data/fs61/fields/<d>/filter.jsonl     a line per lattice whose state the ladder changed
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to a file.  The process group is recorded below and the
            job is stopped BY PGID, never by matching a command line, and the stop is verified BY EFFECT: the pid
            absent from `ps` and the log's digest static across longer than one unit of work.
NOT RUN     no Lean, no lake, nothing under data/fs58 or tools/fs58_*.
```

```
PID   2004456        PGID 2004456        (data/fs61/records/bprime.pgid)
```

The pid was found by **reading `/proc/<pid>/fd/1` and comparing it with the log file's path** — not by matching a
command line, which would have matched the shell that launched it (this repository has nine recorded incidents of
exactly that, and my own first attempt at the inode lookup failed silently and returned an empty pid, which is why
the launch block above says *verify by effect*). Before arming a waiter on that pid I evaluated its condition and
asserted it was **false**: `kill -0 2004456` succeeded, so `until ! kill -0 2004456` could not fire early. The
predecessor's trap — a waiter armed on a log line the success path prints *before* any work — cannot occur on a pid.

The run was stopped after three fields and relaunched with a pooled pass (cause, measurement and forfeit below).
The second launch, under the same rules:

```
PID   2045706        PGID 2045706        log .../scratchpad/logs/bprime2.log
```

Its stop was verified by effect: `pid 2004456 absent from ps`, no process left in the group, and
`data/fs61/fields/47/balls.jsonl` digest `f8464add0b2bd40f` unchanged across twelve seconds — longer than one unit
of work. At the end of the phase no `fs61_census.py` process survives.

## The rung rule, and the one place I strengthened it

The owner's ruling 2 reads: *ask `R = 1.2` if its predicted points are under the cap, else `R = 1.0` if those are.*
Implemented as written, with one addition, stated here **before the run** because the owner asked to hear a better
shape for the ladder with its measurement first:

> **A rung whose EXACT point count overflows the cap descends to the next rung of the same ladder.**

The reason, measured on the records phase B already wrote: the predicted count is `π²R⁴/covolume`, and over the 327
committed balls of ≥ 100,000 points its ratio to the true count has **median 1.0098 and maximum 1.1078**. Of the 36
balls this phase will ask, **nine have a prediction above 541,516**, which is where a ratio of 1.108 crosses the
600,000 cap. Without the descent those nine could each come back "too big" while their next rung down — predicted
133,797 to 281,541 points — sits unasked and comfortably inside the cap, for no saving of solver time at all (the
enumeration that discovers the overflow is cheap; the solve is what costs).

It is the same two-rung ladder, it can only ask **more** and never fewer, it is written into `tiers.json` as the
tier's own `radius_rule`, and `table --check` re-derives it from the covolumes rather than trusting the run. It is
flagged here as a deviation for the owner to rule on.

> **Scored after the run: it never fired, and the measurement above was drawn from the wrong population.** No ball's
> exact count exceeded the cap; the ratio over the 37 balls actually asked ran **0.9982 to 1.0094**, not to 1.1078.
> The high ratios in the record base are all at the small control fields and at coarse lattices, where a ball is
> small enough for its boundary to matter. I priced a risk on a population my own balls were not in. The mechanism
> cost nothing to build and nothing to run, and it stays only because `table --check` re-derives it either way.

## What tier 1b asks, decided before it ran

110 rank-4 lattices are still `Open` across the forty fields. Of those:

| | lattices |
|---|---|
| asked at `R = 1.5` in phase B — **out of the ladder's scope**, the rule applies only to over-cap lattices | 33 |
| over cap at 1.5, a rung fits at `R = 1.2` | **15** |
| over cap at 1.5, no rung at 1.2 but one fits at `R = 1.0` | **21** |
| over cap at 1.5, and over cap at both 1.2 and 1.0 by prediction — one `Over cap (not asked)` record each | 41 |

**36 new balls, over 19 of the forty fields**, 277,442 to 594,931 predicted points each. The eight fields the owner
named as fitting at `R = 1.0` (131, 167, 179, 203, 239, 407, 455, 479) all appear, and the five he named as fitting
only under tier 2's cap (35, 59, 83, 251, 323) all come back with no rung under the cap — so the plan the driver
computes agrees with the owner's re-plan field for field.

The scope was computed **twice by two independent pieces of code** — a throwaway script written before the driver
gained a ladder, and `ladder_plan` inside the driver — and they agree on every one of the four counts above.

## The run was stopped and relaunched: cause, measurement, forfeit (written BEFORE the signal)

**Cause.** `ladder-all` walked the fields one at a time and opened a worker pool *inside* each field. Most fields
have one to three balls to ask, so the pool was one to three workers wide on a sixteen-core machine. Kooshi said so
from the outside — *"core utilization is practically nil"* — which is the same defect I had noted at launch and
then talked myself out of acting on, on the grounds that the total would still be tolerable. Tolerable is not the
standard: the machine was idle.

**Measurement.** Workers actually used, from the log and `ps`: `d = 11` **2 of 16** (151 s), `d = 23` **6 of 16**
(742 s), `d = 47` **3 of 16**. Three fields of the nineteen with asks were done in about 22 minutes at a mean of
roughly 3.7 workers, so the run was set to take about **2 hours using a quarter of one core-hour in every one it
held**. With the 36 balls in a single pool the makespan is bounded by (the 600-second wall) + (total work)/16 ≈
**25–30 minutes**.

**Forfeit.** Only the balls in flight at `d = 47` — at most three, at most 600 s each. Every finished ball is a
flushed, fsynced JSONL line and is never recomputed: the relaunch reads them back and skips them. That is the whole
point of the checkpoint rule, and it is why the cost of being wrong here is minutes and not results.

**The fix.** One pool over the **whole family** (`ladder_pooled_pass`), sized `--jobs`, asking the first rung of
every in-scope lattice at every field; the per-field pass then runs afterwards and finds those already settled,
doing only the cheap remainder (the over-cap records, any descent, the onset follow-ups, the refusal propagation).
The per-field code path is unchanged and still verified — the pooled pass is additive, and its `meta` is keyed by
**`(field, ball)`**, never by the ball key alone, because phase A found that 154 of 817 lattice shapes are shared
between fields and the bare key would collide across them.

## Two things I found before the run that a later phase should not rediscover

### 1. `load_jsonl` **writes to the file it reads**, so no command in this driver is read-only

`load_jsonl` (phase 0's, following FS-58's convention) repairs a partial final line by truncating the file:

```python
raw = path.read_bytes()
*complete, tail = raw.split(b'\n')
if tail:
    with open(path, 'r+b') as f:
        f.truncate(len(raw) - len(tail))
```

Two consequences, and the second is the dangerous one. A *reader* — `table`, `status`, `land`, or any throwaway
script that imports the module — mutates the records. And the length it truncates to is the length it read
**earlier**, so if the writing job appended a complete record in between, that record is destroyed. The window is
the sub-millisecond of one `write` + `fsync`, and every phase so far ran its commands one at a time, so it has
never been concurrent — until I read the live records during this run, which is how I noticed.

**Checked, read-only, straight off the bytes: 1,760 ball records across 36 files, every file ends with a newline
and every line parses. Nothing was lost.** The operational rule for the rest of this phase, and for anyone after
it: **do not read a field's records while a job is writing them** — copy the tree first, which is what the table
check below did. The repair is proposed at the end of this record; it is not made in flight, because changing the
instrument while it is producing records is the thing this project has a rule against.

### 2. The new accounting check was seen to fire on real data before it was ever seen to pass

Run against a snapshot of the tree taken while the ladder was a fifth of the way through, `table --check` reported
**62 incomplete ladders**, naming each lattice, its field, the rung the rule selects and its predicted size — for
example `d=23 L1510e5aa tier-1b ladder incomplete -- no tier-1b record at R=1.2 (predicted 461277 points, the rung
the rule selects)`. Those are exactly the lattices the run had not reached. A check whose failure mode has been
seen on the real data is a check; one that has only ever passed is indistinguishable from one that cannot fire.

---

# What phase B′ found

## The headline: nothing new lands, and the reason is the solver, not the cap

**36 balls asked, one refusal, and it is at `d = 23`, a field that was already landed.** So **no field lands at
tier 1b**, and no new value of `χ(ℚ(√d)²)` follows from this phase. That is the result; it is not rescoped.

What the phase did change is **what the nulls mean**, which was the reason the owner ordered it. At tier 1 thirteen
fields had asked *nothing at all* — every lattice over the point cap — so their "not landed" measured the cap. After
the ladder:

| the nulls, by kind | tier 1 | tier 1b |
|---|---|---|
| **by certificate** — no open lattice left; only deeper lattices can land it | 11 | **11** |
| **by budget** — open lattices remain and not one was ever askable | 13 | **5** |
| **asked and did not refuse** | 7 | **15** |

**Eight fields moved from "never asked" to "asked" — 131, 167, 179, 203, 239, 407, 455 and 479, exactly the eight
the owner named** — and the family's asked-ball count went from **124 to 161**. The five that remain unaskable are
35, 59, 83, 251 and 323, whose smallest open lattice needs more than 600,000 points even at radius 1.0.

## And the second headline: two thirds of the new asks decided nothing

| verdict | tier-1b ball records |
|---|---|
| `Colourable (colouring verified)` | 12 |
| `Refused (solver claim)` | **1** (`d = 23`) |
| `Unknown (budget)` — ran to the 600-second wall | **24** |
| `Over cap (not asked)` | 41 |
| | **78 records, 37 asked** |

This is the phase's real finding and it changes what tier 2 should expect. The lattices tier 1 could not ask are
*fine* lattices — small covolume, many generators — so their balls are big **and dense**: 277,000 to 595,000 points
carrying 0.7 to 3.3 million edges. CDCL does not decide graphs of that shape in ten minutes. **The binding
constraint has moved from the point cap to the solver**, and raising the cap (which is what tier 2 does) walks
further in the direction that is already not working. A tier 2 that only enlarges the ball will buy more
`Unknown (budget)`.

Because so many asks ended undecided, the census's third null phrase now carries that count in words — a field
reading *"asked: 2 of 2 Open lattices, no refusal, 2 undecided at the wall"* is not the same knowledge as
*"asked … no refusal"*, and without the clause the first reads like the second.

## `d = 167`, which is FS-59's field and the conjecture's cheapest exposed prediction

Its six open lattices were all over the cap at radius 1.5, so tier 1 asked it nothing. The ladder asked three:

```
  d=167 Laea68f14 R=1.0  313,748 points   ->  Colourable (colouring verified)  [0.63 s]
  d=167 L29e2893d R=1.0  397,140 points   ->  Colourable (colouring verified)  [1.46 s]
  d=167 L3e1c94c6 R=1.2  397,817 points   ->  Unknown (budget)                 [605 s]
```

**Two of the three are three-colourable, and the solver found the colouring in under two seconds** on graphs of
nearly 400,000 points. That is not a budget null: those balls are genuinely easy, which is the same signal FS-58
met at 167 (3-colourable balls to 215,409 points) one size up. The third is undecided. 167 is now *"asked: 3 of 6
Open lattices, no refusal, 1 undecided at the wall"* rather than *"nothing was askable"* — a small but real
sharpening of the input FS-59 was waiting for.

## The one refusal

```
  d=23 L1510e5aa R=1.2  462,045 points  3,265,070 edges  ->  Refused (solver claim)  [258.91 s]
```

`d = 23` is already `Landed (certified)` from a 573-point witness, so this changes no state and needs no
certification: it is a tenth refusing lattice at a field that had nine. The onset follow-up below it, at radius
1.0 (222,965 points), ran to the 120-second wall undecided, so it hands phase C nothing cheaper. `land 23` would
not choose this ball anyway — its cost proxy (points × solve seconds) is two orders of magnitude above the ball
the standing witness came from.

## B′.1 — the predicted-points formula decided every radius, and the strengthening never fired

Every one of the 37 asked records carries `ladder_rungs` (the prediction at both rungs), `ladder_rung_chosen`,
`ladder_rung_reason`, the prediction and the actual count. Against A.8's 15 % bound:

| | |
|---|---|
| records with prediction and actual | **37 of 37** |
| ratio actual/predicted | **0.9982 to 1.0094** |
| outside A.8's 15 % bound | **0** |

**And the descent I added never fired**: no ball's exact count exceeded the cap, so the ladder never stepped down
from 1.2 to 1.0 for that reason. The measurement that motivated it was real — over the 327 committed balls of
≥ 100,000 points the ratio reaches 1.1078 — but **that tail lives in a population these balls are not in**. The
high ratios are all at the small control fields (`d = 2, 5, 7, 13, 19, 31, 43`) and at coarse lattices, where a
ball holds few enough points that the boundary matters. On the census family's fine lattices the bidisc law is
accurate to **under 1 %**. I registered a mechanism against a risk estimated from the wrong population; it cost
nothing to build and nothing to run, and the honest record is that it was not needed.

## Cost, and the machine

| | |
|---|---|
| balls asked | 37 (36 planned + 1 onset follow-up) |
| wall, the pooled run | **20.5 min**, 16 workers |
| wall, the per-field run before it was stopped | 22 min for 3 fields of 19, at 2–6 workers |
| solver time | 24 balls at the 600 s wall; median solve of the 12 colourable ones **15.7 s** |
| peak memory, whole process group, 16 workers | **17.9 GB** of 128 GB (101 GB was free) |

## The memory measurement tier 2 needs, which is the owner's ruling 4

Every ball record now carries the worker's peak and end-of-ball resident memory.

| | |
|---|---|
| largest ball asked | **595,257 points, 2,370,078 edges** (`d = 215`, `Lc223387a`, R = 1.0) |
| that worker's peak RSS | **1.93 GB** (process high-water; it had handled other balls, so this is an upper bound for that ball) |
| its RSS at the end of the ball | 1.58 GB |
| **max worker peak over all 37 balls** | **2.47 GB** (`d = 47`, 551,921 points) |
| peak GB per million points | median **3.37**, max **5.22** |

**At tier 2's 3,000,000-point cap that is 10 to 16 GB per worker, so sixteen workers would ask for 160–250 GB on a
128 GB machine.** The plan's own rule is `available memory / peak`: with about 100 GB free that is **six workers,
and not more than eight**. The figure is a floor, not a ceiling: tier 2 raises `NMAX` from 180 to 420, which
produces *finer* lattices with more generators and therefore more edges per point, and memory here tracks edges
more closely than points (compare 565,081 points at 1.56 M edges → 1.50 GB against 569,965 points at 2.62 M edges
→ 2.13 GB). **Measure one worker on a real tier-2 ball before launching, as ruling 4 says; do not extrapolate mine
across a factor of five.**

---

# The gate (plan §6 phase B, re-read at tier `1b`, plus B′.1)

Every row is a command you can paste from the repository root after `source scripts/dev-env.sh`.

| # | item | command | artifact | the line that shows the pass | exit |
|---|---|---|---|---|---|
| B.1 | completeness | `python3 tools/fs61_census.py table --check` | `data/fs61/census.md`, `census.jsonl` | `DONE table --check: 40 fields at tier 1b (accounting checked at 1, 1b), 0 defects` | 0 |
| B.1b | the two monotonicity controls | the same command | the same | inside the 0 defects; both clauses were shown to fire in phase B, and the barrier clause re-runs green on all 898 lattices | 0 |
| B′.1 | the formula decides the radius; predicted beside actual | the records themselves | `data/fs61/fields/<d>/balls.jsonl` | 37 of 37 asked records carry `ladder_rungs`, `ladder_rung_chosen`, `ladder_rung_reason`, `predicted_points`, `points`; ratio **0.9982–1.0094**, **0** outside A.8's 15 % bound | — |
| B.2 | every `Colourable` verdict verified | `python3 tools/fs61_census.py scan <d> --reverify` (and, for the eight fields carrying a tier-1b colouring, at fraction 1.0) | `data/fs61/fields/<d>/models/` | **36 stored colourings re-checked on the full exact edge set — every one of the 12 new ones, not a sample — 0 failures**; plus the 10 % sample over 23 fields, 22 models, 0 failures | 0 |
| B.3 | every `Colourable` lattice carries its certificate | `python3 tools/fs61_census.py filter <d> --reverify`, all 40 fields | `filter.jsonl`, `quotients/` | **656 certificates re-checked against the full generator set, 0 failures across 40 fields** | 0 |
| B.4 | the priced facts reproduce | the records | `fields/{119,143}/balls.jsonl` | `d=119 R=1.5 13605 points -> Refused`; `d=143 R=1.5 283485 points -> Refused` | 0 |
| B.5 | budget honesty | `table` | `census.md` | the per-field **balls asked / over cap / unknown** column and the totals line: 421 census records, **161 asked**, 260 over cap, 44 unknown | 0 |
| B.6 | the table regenerates | `table` twice | `census.{md,jsonl}` | byte-identical on the second run: **PASS** | 0 |
| B.7 | machine and cost | this record | — | above | — |
| — | the instrument's own checks | `python3 tools/fs61_census.py selftest` | — | `DONE selftest: 8 sections, 0 failures` | 0 |
| — | FS-58 untouched | `python3 tools/fs61_census.py regress untouched` and `git status --porcelain data/fs58 tools/fs58_*` | `data/fs61/regress/untouched.jsonl` | `DONE regress untouched: PASS`; `git status` empty | 0 |

## Plants, and the line each turned red

Nine new checks ship with this phase; each was executed and each was seen to fail on its own clause before it was
seen to pass. They are the `ladder` section of `selftest` (23 rows, run in 0.04 s).

| plant | fired as | which clause it guards |
|---|---|---|
| the cap set one point below the top rung's prediction | `cap 295216 -> R=1.0, against R=1.2 at cap 600000` | the **rung rule**: the predicted-points formula is what selects the radius, and the other outcome is reachable |
| the record at the selected rung deleted | `no tier-1b record at R=1.2 (predicted 295217 points, the rung the rule selects)` | the **accounting**: an unasked lattice is named, never passed over |
| a record at the right rung stamped with the wrong tier | the same message | tier-1 records cannot be counted as tier-1b work |
| an exact over-cap at the top rung with no record below it | `no tier-1b record at R=1.0 (predicted 142369 points, the rung below R=1.2)` | the **descent** clause |
| …and the same ladder with the descent record present | `Refused (solver claim) at R=1.0` | PLANT RESOLVED: the check passes for the right reason |
| `over cap by PREDICTION` at a rung the prediction fits | `R=1.2 fits the cap by prediction (295217 points) yet its record is over cap by 'prediction', which the rule cannot produce at an askable rung` | **consistency** of a record with the rule that wrote it |
| an actual count at twice the prediction | `ratio 2.0` flagged outside the bound | **A.8**, and that it is reported as a finding rather than a defect |
| a ball that ran to the wall, offered as "asked and not refused" | `asked: 1 of 2 Open lattices, no refusal, 1 undecided at the wall` | the **null language**: undecided is not colourable |
| an open lattice with only an `Over cap` record, offered as asked | `by budget: 2 Open lattices, none askable` | the null language, the other way |
| a repair of a partial line against a **stale** length, after a writer appended two records | `34 -> 48 bytes, all 4 lines intact; unguarded it would truncate to 24 bytes and lose the last two records` | **data loss**: a read must not destroy records |
| a field refusing for the first time, offered to the hardcoded phase-C order | `[359, 11, 119, 143, 47, 95, 191, 71, 23, 239]` | a new landing is appended, never skipped |
| tier 1's or tier 2's definition altered | standing row: `7a520f29e32724da (minted 7a520f29e32724da)` | **tier 1 does not move**, and 343 committed records depend on that |

And one plant that fired on the real data rather than a fixture: `table --check` against a snapshot taken mid-run
named **62 incomplete ladders**, one line per lattice.

## My own defects in this phase, all found and all recorded

1. **I let the machine idle for 22 minutes.** `ladder-all` pooled inside a field, which is one to six workers on a
   sixteen-core box. I noticed it at launch, estimated the total as "tolerable", and carried on; Kooshi saw the core
   graph from outside and said so. The rule I broke is not a rule about parallelism — it is *a run that blocks
   something is presumed killable, and the burden of proof is on keeping it*. I had the measurement (2 workers at
   `d = 11`) in my own hands before the launch. **Fixed**: one pool over the whole family, 27 balls 16 wide,
   20.5 minutes against a projected two hours. Cause, measurement and forfeit are written above, before the signal.
2. **Two of my own shell-side checks reported a silent zero**, both by grepping for a line the tool does not print.
   `B.2` first read `0 models re-checked` because my pattern allowed an empty match, and `B.3` first read a blank
   total because I grepped `^DONE` where the tool prints `fs61 filter --reverify …`. Both were caught by reading
   the **counts** rather than the exit status — which is what the phase-C record told me to do, in writing, before
   I started. A gate wrapper is a check, and it needs the same negative control as the thing it wraps.
3. **The pooled pass prints nothing for a colourable ball**, so a healthy run looks hung: ten minutes passed with
   no output while seven balls finished. I read the records instead of fixing it mid-run. It is the shape this
   repository calls *silence is never success*, in my own new code, written the same day I quoted the rule.

## Proposals to the owner (§0–§9 are the specification; these are not edits)

1. **Ruling 6's dichotomy needs a third phrase, and the third is the majority case.** *By certificate* and *by
   budget: k Open lattices, none askable* cover 16 of the 31 nulls; the other 15 were asked and did not refuse.
   Implemented as `asked: j of k Open lattices, no refusal[, u undecided at the wall]`. The undecided clause is not
   decoration: 24 of 37 asks ended there.
2. **§7's `evidence ∈ {kernel (11 only), …}` is retired** — on the owner's own instruction, recorded here so the
   specification and the tool do not silently disagree. No row of `census.md` is kernel-checked; the kernel's
   `four_le_chromaticNumber_planeOver_eleven` rests on FS-58's 204-point **chain** witness, and this census's
   `d = 11` row is a 189-point **direct** witness. The legend, a note under the table, and the `d = 11` witness
   README each now say which is which.
3. **`load_jsonl` should not write.** It is guarded now (it refuses to truncate against a stale length and says so),
   but the complete fix is a lock in `append`, or splitting the repair out of the read path so only a writer ever
   performs it. Until then the operational rule stands: do not read a field's records while a job writes them.
4. **Tier 2 should not raise the cap first.** Its premise — that the point cap is what is binding — was true at
   tier 1 and is no longer true after this phase: 24 of 37 askable balls ran to the solver's wall. Raising the cap
   to 3,000,000 makes bigger instances of the graphs the solver already cannot decide, at 10–16 GB per worker.
   Cheaper things to try first, in the order I would try them: (a) **a longer wall on the balls already asked** —
   the 24 `Unknown` records are re-asked by re-running the same command with a larger wall, and cost nothing new to
   set up; (b) **cube-and-conquer** on one of them, priced on a sample as M63 phase H2 priced its 552 cubes;
   (c) **a smaller radius** — the ladder stopped at 1.0 because every refusal on record is at 1.0 or above, but a
   refusing *sub*-ball is what phase C wants anyway and `d = 11` refuses at exactly 1.0.
5. **`ladder-all`'s pooled pass should become the pattern for tier 2**, and its per-field descents and onset
   follow-ups should be pooled too if tier 2 produces many of them (this phase produced one onset ask and no
   descents, so it did not matter).

---

## A fourth instance of the self-match trap, in a counting costume

Verifying at the end that no job survived, I ran

```
ps -u $USER -o pid,args --no-headers | grep -c '[f]s61_census.py'
```

— the bracket trick, which is supposed to stop the pattern matching the process that runs it — **and it returned
2 with nothing running.** The bracket protects against the *pattern* matching itself, but the shell's command line
also carried earlier lines of the same multi-line invocation, one of which contained the literal
`python3 tools/fs61_census.py selftest`. So the shell matched on a different occurrence.

This repository's rule already covers it — *never let a pattern that can match the matching shell decide anything*
— and its recorded instances are kills and waiters. This is the third costume: a **count**, where the failure mode
is an inflated number that reads like a surviving job, which is the safe direction but is still a check reporting
about the wrong thing. The verification that stands is the one in the section above: a walk of `/proc` matching on
`comm` and `cmdline` while excluding the checker's own pid and its parent, which returned **NONE**.
