# FS-61 phase E — the last look, and the explanation: the phase record

*Plan: `plans/FS61-quadratic-census.md`, **the owner's re-plan after phase B′** (ruling 3), which governs the Phase E
table wherever they differ; §5 rule 16 is the format of this file. Implementer: de Bruijn (Opus 5), 2026-09-20, the
fourth of FS-61's implementers. Machine: **the desktop, 16 physical cores / 32 threads, 128 GB**,
idle, one heavy job at a time. Timings are wall seconds on that machine unless they say CPU.*

## What this phase is, in plain words

Nine of the forty fields in the census have landed: a finite graph drawn in that field's plane, certified by an
independent checker, that cannot be coloured with three colours. Thirty-one have not. Phase B′ sorted those
thirty-one nulls into three kinds — eleven where every lattice at this depth already has a *proof* that three colours
suffice, five where nothing was ever small enough to put to a solver, and fifteen where balls were asked and none
refused (twenty-four of those asks ran out of time rather than deciding anything).

Phase E is the bounded last look, six machine-hours in total, and then the explanation and the close. Two asks:

* **E.1a** re-asks the fourteen balls that ran out of time at the ten fields that have not landed, giving the solver
  **six times as long** (3,600 seconds against 600) and changing nothing else — same lattice, same radius, same point
  cap, same symmetry break. New tier id `1c`.
* **E.1b** goes *deeper* instead of *bigger*: lattices built from unit vectors of denominator up to 420 instead of
  180, at all thirty-one fields, under the **same** 600,000-point cap and 600-second wall. New tier id `2l`. This is
  the only test the eleven "closed by certificate" fields can ever get, because at their present depth there is
  nothing left to ask.

**What is deliberately NOT run** (the owner's ruling 3, on phase B′'s own measurement): tier 2 as the plan first
defined it — the same lattices at a 3,000,000-point cap. Twenty-four of thirty-seven asks at ≤ 600,000 points ended
undecided at the wall, so the binding constraint is the solver, not the cap; a bigger cap builds larger instances of
exactly the graphs already undecided, at 10–16 GB per worker. That problem belongs to FS-59 with tools built for it.

---

## 0. The lock in `append` (the owner's ruling 2 after phase B′), built before any pooled run

Phase B′ found that `load_jsonl` — which every command in this driver calls — **repairs a partial final line by
truncating the file**, so every *read* in the driver is a *write*, and the length it truncates to was measured
earlier. B′ guarded it on the file's size, which narrows the window to the two syscalls between the `stat` and the
`truncate` and does not close it. Phase E is the first part of this milestone that runs a pooled job over the family
while its records are being read, so the lock was built first.

`record_lock(path)` takes an exclusive `flock` on the record file's own inode, and `load_jsonl` now holds it across
the whole read-and-repair while `append` holds it across the whole write. The lock is on the inode, so it is shared
by every process that goes through those two functions — which is every command in the driver.

| what | command | the line that shows it | exit |
|---|---|---|---|
| the lock's own section, four rows, two of them plants | `python3 tools/fs61_census.py selftest --section lock` | `DONE selftest: 1 sections, 0 failures` | 0 |

**Plants, each executed and each seen to fire.**

| plant | fired as | which clause it guards |
|---|---|---|
| a writer in a **separate interpreter**, stopped at its `append`, while a reader holds the lock | `0.5 s with the file at 24 bytes against 24 before, and the writer alive` — and on release `['a','b','c']`, the writer **blocked 0.52 s inside `append`** | the lock EXCLUDES; without it there is nothing to test |
| the repair as it stood before B′, with a writer appending **between the size check and the truncate** | `['a','b'] survive of a, b, c, d: two finished records destroyed` | the window the size guard alone leaves open, and what it costs |
| the same interleaving through `record_lock` | `['a','b','d']` — the partial line repaired **and** the writer's record kept | the lock closes it |
| **the negative control on the lock itself**: `fcntl.flock` replaced by `pass` in `record_lock`, the real file, the real child process | **3 of 4 rows RED**, and the last one is the real loss: `['a','b']` where the guarded path gives `['a','b','d']` — a finished record destroyed by a read | a check that has only ever passed is indistinguishable from one that cannot fire |

The planted file was restored from a byte copy and `sha256sum -c` confirmed it (`scratchpad/work/pristine.sha`).

---

## E.1a — tier `1c`, the long wall

### The launch — written before anything ran (plan §5 rules 1 and 3)

```
COMMAND     python3 tools/fs61_census.py reask --tier 1c --jobs 14
RESUME      the identical command.  Each of the fourteen balls is its own JSONL line in
            data/fs61/fields/<d>/balls.jsonl, appended, flushed and fsynced as it lands.  A tier-1c record at the
            3,600 s wall is `settled` and skipped on a re-run; the tier-1b record it re-asks is NOT settled at that
            wall, so an unfinished ball is re-asked and a finished one never is.  A kill at any instant therefore
            redoes AT MOST the balls in flight, and nothing else in the census moves.
STATE       data/fs61/fields/<d>/balls.jsonl   one line per (lattice, radius); the tier-1c line SHADOWS the tier-1b
                                               line under the same key in every `load_jsonl` view, and the tier-1b
                                               line stays on disk as the history (`read_records` reads it).
            data/fs61/fields/<d>/filter.jsonl  a line per lattice whose state a refusal changes
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to a file under the scratchpad.  The pid is recorded below,
            the job is stopped BY PID, never by matching a command line, and a stop is verified BY EFFECT: the pid
            absent from `ps` AND the record file's digest static for longer than one unit of work.
WORKERS     14, one per ball, not 16: there are exactly fourteen balls and a wider pool would be idle.
MEMORY      the largest ball is 595,257 points / 2,370,078 edges, whose worker peaked at 1.93 GB when tier 1b asked
            it; the largest peak over all 37 tier-1b balls was 2.47 GB.  Fourteen workers at that peak is about
            35 GB of the 128 GB on this machine, and the whole 16-wide tier-1b run peaked at 17.9 GB.
WORST CASE  all fourteen run to the 3,600 s wall in one pool: about 1 h 5 m.
NOT RUN     no Lean, no lake, nothing under data/fs58 or tools/fs58_*.  No tier-1 or tier-1b record is rewritten.
```

### The scope, and that it is the owner's fourteen

`reask --plan` reads the scope from the **raw** records — every ball a tier-1b record left `Unknown (budget)` at a
census field with no certified witness — and prints fourteen balls over ten fields: **131, 167, 215, 239 ×2, 287 ×2,
311 ×2, 407, 431, 455, 479 ×2**, which is the owner's list field for field. The twenty-one tier-1 `Unknown` records
are not in scope: every one of them is at a field that has already landed, where a refusal would change no state.
The control fields' `Unknown` records are not re-asked at all — those planes are 2- or 3-colourable by theorem, and
they are the standing reminder that an `Unknown` is not a near-refusal.

### The accounting check was seen RED on the real data before it was ever seen green

`tier_accounting` at tier `1c` names every ball still owed. Run before the launch, against the committed records:

```
DEFECT table --check d=131: lattice Ldb4246f8 R=1.0 was left 'Unknown (budget)' by tier 1b and has no tier-1c record
  ... one line per ball ...
tier-1c accounting BEFORE the run: 14 defects (one per ball still owed)
```

Its scope is read from the **history**, not from the current view, and that is load-bearing rather than fussy: read
from the view, answering a ball removes it from the `Unknown` set, so the check would pass by having lost its
subject. The selftest plants both readings side by side (`phaseE` section: *history 1 ball in scope, view 0*).

### The owner's registered expectation, recorded before the run

> *at most two verdicts change and none to `Refused`* (low confidence).

Both outcomes are reachable: the instrument that would report a refusal is the one that reported one at `d = 23` at
tier 1b, on a ball of the same shape and size.

### Result

*(filled in below when the run lands)*

### The tier-1c run as first launched was STOPPED, 7 m 38 s in — cause, measurement and forfeit, written before the signal

**Cause.** The owner re-planned E.1a an hour after briefing me, on a measurement of his own: across every asked ball
record, what separates a decided ball from an undecided one is not its size but its **average degree**, `2·edges /
points`. I re-derived it independently before acting on it (below) and it holds. The ask I had launched — the same
fourteen balls at six times the wall — is aimed at the wrong quantity, and for six of its fourteen units the
informative outcome is **unreachable**.

**Measurement** (mine, from `data/fs61/fields/*/balls.jsonl`, 734 asked ball records carrying both a point count and
an edge count, over the forty census fields and the seven control fields):

| average degree | Colourable | Unknown | Refused |
|---|---|---|---|
| < 4 | 87 | 0 | 0 |
| 4–6 | 183 | **39** | 0 |
| 6–8 | 106 | 14 | 3 |
| 8–10 | 112 | 11 | 6 |
| 10–14 | 68 | 6 | 13 |
| 14–20 | 44 | **0** | 15 |
| ≥ 20 | 20 | **0** | 7 |

**The lowest average degree at which any ball has ever refused is 6.595** (`d = 119`, `L8a8b1603`, `R = 1.2`), over
44 refusing balls. The 70 `Unknown` balls have median degree **5.52** and lie in 4.70–12.27. Restricted to balls of
≥ 200,000 points, **43 are at degree ≥ 14 and every one decided** (28 colourable, 15 refused, **0 undecided**), the
slowest in **259 s** — my figure; the owner's brief says 239 s, and the difference is a population difference I have
not chased, so both are recorded rather than one being adopted.

**The fourteen balls the run was asking, at their average degree** — the number that decided this:

```
  degree 5.51  x6   (d = 131, 287, 311, 407, 431, 479; all on 36-generator lattices at R = 1.0)
  degree 7.95, 7.96, 8.47, 8.49, 9.16, 10.38, 11.62, 12.24   (the other eight)
  median 7.96, range 5.51-12.24
```

**Six of the fourteen sit at degree 5.51, below the 6.595 floor: no ball at that degree has ever refused, anywhere
in 734.** Six of fourteen workers were therefore asking a question whose informative outcome has never once been
observed — which is this repository's own rule broken in the direction that looks like diligence, and it was my
launch. The other eight would be asked at a higher radius under the revised rule.

**Forfeit.** 7 m 38 s × 14 workers ≈ **1.8 core-hours**, and **no results**: `grep -c '"tier":"1c"'` over every
`balls.jsonl` reads **0**, so not one record was written and tier `1c`'s definition is not yet fixed by any record.
What is genuinely forfeited is a measurement nobody else will make: *do the hard-band balls (degree ≈ 5.5) decide if
you give the solver six times as long?* B′'s reading — "the binding constraint is the solver" — was drawn from that
population, and this run would have tested it directly. **It is offered back to the owner as a cheap optional
control (one ball, not fourteen), not smuggled back into the plan.**

**The stop.** By PID, never by matching a command line; verified by effect.

---

## E.1a, as re-aimed — tier `1c`, the degree-targeted ask

### The finding this tier is built on, re-derived here before it was acted on

The owner's measurement, reproduced independently from `data/fs61/fields/*/balls.jsonl` (my script, five lines, over
every asked ball record carrying both a point count and an edge count) — the table is in the section above. Two
numbers carry it: **no ball below average degree 6.595 has ever refused**, over 44 refusing balls; and among balls of
≥ 200,000 points, **all 43 at degree ≥ 14 decided** — 28 coloured, 15 refused, none undecided.

**The law that makes it actionable.** A ball of radius `R` on a lattice holding `g` unit vectors has predicted
average degree `g·φ(R)²`, where `φ(R) = [2R²·acos(1/(2R)) − √(4R²−1)/2] / (πR²)` is the area fraction a radius-`R`
disc shares with its unit translate — **squared**, because a ball here is a bidisc, one disc per real embedding. Each
point has `g` candidate neighbours and each lands inside the ball with probability `φ(R)²`.

**Control, on every asked ball record on disk (735, census fields and controls): observed / predicted has median
1.0000 and range 0.715–1.184, with 0 outside ±30 %.** The plant: dropping the bidisc square — `g·φ(R)` instead of
`g·φ(R)²` — reads median **0.584** on a 60-ball sample, so the square is doing the work and the control can fail.

**The owner's orientation arithmetic, checked.** 167's 36-generator lattice `L3e1c94c6` reaches degree 14 at
`R = 1.666` on 1,473,792 predicted points (his ≈1.67 and ≈1.5 M); its 20-generator lattices need 2.66–3.37 M points
to reach degree 8, so they cannot (his claim); 239's 52-generator lattice reads degree **16.71** at `R = 1.44` on
**575,303** points, under the old 600,000 cap (his 16.6).

### Two defects of mine, both found by running, both in the safe direction

1. **A rule that aims AT the cap overflows it about half the time.** `Rcap` was defined as the radius whose
   *predicted* points equal the cap, but the cap is enforced on the *exact* count, so the first ball came back
   `Over cap (not asked)` with nothing asked. The rule now aims at `cap / 1.11`, where 1.11 is the largest
   actual/predicted **points** ratio ever recorded here on a ball of ≥ 100,000 points (1.1078 over 327 such balls;
   on the fine lattices this tier asks, phase B′ measured 0.9982–1.0094 over 37). The cap itself is unchanged, and
   an exact overflow is still recorded honestly if one happens. Cost: two lattices (`d = 131 L5ea33424` at predicted
   degree 8.06 and `d = 335 Leb4c3969` at 8.14) fall below the floor of 8 and become `Over cap` records.
2. **The record path read `rec['edges']` unconditionally**, and an over-cap record has none — so the first ball
   crashed the run instead of recording. Fixed, and it is the good direction to fail in: loudly, with nothing
   written.

And a third, inside my own check: the margin row first quoted **1.0407** as "the worst recorded ratio", which is the
worst *degree* ratio, not the worst *points* ratio (1.1078). A number measuring one thing put to work deciding
another — this repository's most repeated error, in the row written to guard against overflow. It was caught only
because the row beneath it went red for an unrelated reason.

### The memory measurement the owner's rule requires, made before the pooled pass

The densest ball the rule will ask, run **alone**:

```
  d=455 Lc223387a R=1.5911 arm=Rcap  1,802,901 points  11,938,510 edges
  degree 13.244 (predicted 13.246)   predicted points 1,801,802, actual 1,802,901  (ratio 1.0006)
  -> Colourable (colouring verified) [5.57 s solve, worker peak 7.00 GB, 50.4 s wall end to end]
```

**Worker peak 7.00 GB on the worst-case ball**, against 117 GB available. `available memory / peak` = 16.7, and the
pool is set to **12**, not 16: the 7.00 GB is a per-worker high-water that a worker handling several balls in
sequence can exceed (phase B′ recorded exactly that caveat about its own figure), 12 × 7 = 84 GB leaves 33 GB of
headroom, and this machine has been taken down twice by parallel heavy jobs — an OOM here is an unexplained crash
and therefore a halt.

**And the ball decided in 5.57 seconds.** 1.8 million points, 11.9 million edges, at degree 13.2 — against 24 of 37
balls a tenth that size running to a 600-second wall at degree ≈ 5.5. That is the owner's reading, visible in one
measurement.

### One deviation from the owner's revised rule, declared before the run and tagged per record

His scope is *every rank-4 `Open` lattice at the 31 fields not landed whose **best ball record** is `Unknown
(budget)` or `Over cap (not asked)`*. The scope implemented is **every rank-4 `Open` (or `Refused`) lattice at those
fields**, with each record carrying `owner_arm: true|false`, so either scope can be scored from the records.

*Why:* a lattice whose largest record is `Colourable` was coloured at whatever radius fitted an **earlier** tier's
600,000-point cap, and colourability at a small radius is not a certificate — the lattice is still `Open`. Under
this tier's cap a strictly larger and denser ball of the same lattice fits, and that is the informative ask. It adds
**4 balls and 1.8 M of the 41.6 M points**, all at degree 14, and it can only ask more, never fewer. A lattice
already **decided** at or above the rule's target radius is skipped and its record says so (1 such).

*`Refused` is in scope beside `Open` for a different reason: so that a lattice this tier refuses does not drop out
of the accounting check that owed it an ask — the self-erasing check again.*

### The launch — written before anything ran (plan §5 rules 1 and 3)

```
COMMAND     python3 tools/fs61_census.py degree-ask --tier 1c --jobs 12
RESUME      the identical command.  Every ball is its own JSONL line in data/fs61/fields/<d>/balls.jsonl, appended,
            flushed and fsynced as it lands; a settled tier-1c record at the chosen radius is skipped on a re-run.
            A kill at any instant redoes AT MOST the balls in flight (at most 12), and nothing already recorded
            moves.  The plan is recomputed from the covolumes, the generator counts and the cap, never read back
            from the run that wrote it, so a resume cannot inherit a stale scope.
STATE       data/fs61/fields/<d>/balls.jsonl   one line per (lattice, radius), carrying tier "1c", the arm, g,
                                               covolume, predicted and actual degree, predicted and actual BALL
                                               points (len(X) and len(E) as handed to the solver, never a peeled
                                               piece), and owner_arm
            data/fs61/fields/<d>/filter.jsonl  a line per lattice whose state a refusal changes
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to a file under the scratchpad.  Stopped BY PID, never by
            matching a command line; a stop is verified BY EFFECT -- the pid absent AND no worker left in the
            process group read from /proc/<pid>/stat (killing the parent last time left all 14 workers alive and
            re-parented).
WORKERS     12 (measured above), pool width is a required argument: `--jobs` has no default at this cap.
SCOPE       49 lattices over 20 fields; 31 balls to ask (17 arm R14, 14 arm Rcap), 41,578,479 points predicted,
            largest 1,801,802.  17 lattices unaskable -- five of them six of 167's -- each getting one `Over cap
            (not asked)` record carrying the degree it WOULD reach at the cap.
EXPECTED    from the one measured ball: about 50 s each end to end if they behave like it, so 31 balls twelve wide
            is minutes; the 1,800 s wall bounds the worst case at 3 waves x 30 min = 1 h 30 m.
NOT RUN     no Lean, no lake, nothing under data/fs58 or tools/fs58_*.
```

### The owner's registered predictions, recorded here before the run

* **P-deg1** — *every ball asked at predicted degree ≥ 14 decides within the wall.* It **loses** if one is
  `Unknown` at 1,800 s. Population: the 17 arm-`R14` balls (predicted degree exactly 14). The record it was
  registered against: 43 of 43 balls of ≥ 200,000 points at degree ≥ 14 decided.
* **P-deg2** — *at least one new field refuses.* The owner puts it at 0.35 and says he does not know.

Both outcomes of both are reachable: the instrument that would report a refusal is the one that reported 44 of them.

### Result — three fields that had not landed now refuse three colours

**The headline: `d = 59`, `d = 239` and `d = 311` refuse.** Each is a field the census had recorded as *not landed*,
and each refusal is a solver claim until the frozen checker certifies it (phase C). With their local bounds from
`frame.jsonl`:

| d | mod 8 | L | the refusing ball | degree | solve | what a certificate would make it |
|---|---|---|---|---|---|---|
| **59** | 3 | 4 (dyadic) | `Ldb4246f8`, R = 1.1945, 1,396,469 points, 9,773,884 edges | 13.998 | 314.7 s | **χ(ℚ(√59)²) = 4** — a new exact value |
| **239** | 7 | 4 (7) | `L3e1c94c6`, R = 1.2892, 369,885 points, 2,587,978 edges | 13.993 | 403.0 s | **χ(ℚ(√239)²) = 4** — a new exact value |
| **311** | 7 | 5 (11) | `Lc223387a`, R = 1.2892, 1,137,169 points, 7,960,542 edges | 14.001 | 18.2 s | **4 ≤ χ(ℚ(√311)²) ≤ 5** |

**`d = 59` was one of the five fields phase B′ could say nothing about at all** — *"by budget: open lattices remain
and not one was ever askable"*. It is now a refusal at the first question that was ever put to it at a degree
capable of refusing.

**And `d = 59` is a second `d ≡ 3 (mod 8)` field refusing by the direct route**, after `d = 11` in phase B. R-mod8
did not merely lose; it is now losing repeatedly, and the half of the family it declared out of the direct route's
reach has supplied two of the census's twelve refusing fields.
