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
