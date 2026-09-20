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

*(the timings and the results are filled in below as the run completes)*

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
