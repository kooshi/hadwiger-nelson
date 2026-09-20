# FS-61 phase C — certify every refusal: the phase record

*Plan: `plans/FS61-quadratic-census.md` §6 phase C and the owner's re-plan block, §5 rule 16. Implementer: de Bruijn
(Opus 5), 2026-09-20. Machine: **the desktop, 16 physical cores / 32 threads, 128 GB**, idle, one
heavy job at a time.*

## The second implementer's launch — written before the run started (plan §5 rules 1 and 3), 2026-09-20

*Taking over phase C mid-stream; the record below this block is the first implementer's and the owner's, kept as
the history. What changed before this launch is the **deletion policy**, §"The deletion policy" below.*

```
COMMAND     python3 tools/fs61_census.py land-all
            (defaults: --deletion-budget 600 --gen-cap 5400)
ORDER       359, 11, 119, 143, 47, 95, 191, 71, 23   -- unchanged, the owner's priority
RESUME      the identical command.  A field whose data/fs61/landings.jsonl record says CERTIFIED is skipped;
            inside a field, `extract` resumes from witness-<d>/steps.jsonl and `land` skips generation entirely
            when witness.json is already on disk.
STATE       data/fs61/landings.jsonl, data/fs61/witnesses.jsonl, data/fs61/witness-<d>/
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to data/fs61/records/land-all.log.
PGID        written to data/fs61/records/land-all.pgid at launch; stop with `kill -TERM -$(cat …)`, then verify
            BY EFFECT: no `fs61_census.py`/`fs58_search.py` pid in `ps`, and the field's steps.jsonl (or the log)
            digest identical across 65 s -- the deletion checkpoints are 60 s apart, so a shorter check proves
            nothing.
AT LAUNCH   d = 359's witness.json and witness.lrat.gz already exist (the owner's --stop-deletion re-run finished
            at 05:27): 1,190 points, 3,243 edges, LRAT 87,375,793 bytes raw / 25 MB gzipped, emit 389 s.
            So 359 is the end-to-end test of C.1-C.9 with no generation.
```

## A stop, written here BEFORE the signal (2026-09-20 06:41) — `d = 95`'s `direct-witness`

**What I am about to stop and why.** `python3 tools/fs58_search.py direct-witness 95 q1+12+60.2 1.5 …`, pid 1800997,
at **2,124 s (35 min) with nothing on disk**. `direct-witness` neither checkpoints nor can be resumed, so plan rule 1
— *any run over ~15 minutes must be resumable* — has been violated by my own threshold for twenty minutes.

**The measurement that says the threshold is wrong, and it is not ball size.** `direct-witness` takes one Glucose4
assumption core over the whole ball and then deletes one vertex at a time, each test a solve **against the whole
ball's formula**; `extract` deletes against the kept set only. So the cost is set by the **core** size, which is not
known until the run has already started:

| d | ball | core it deletes over | generation |
|---|---|---|---|
| 47 | 8,629 | 169 | **5.7 s** |
| 119 | 13,605 | 456 | **51 s** |
| 95 | 17,169 | ≥ 1,737 (FS-58's `extract` fixpoint on this ball) | **> 2,124 s, unfinished** |

**What the kill forfeits:** a 1-minimal witness over 95, of unknown remaining cost. FS-58's own 95 witness is 1,068
points and *not* 1-minimal, so nothing certified is at stake — 95 is one of the five re-certifications, the lowest-value
end of the queue. The redo through `extract` is minutes (FS-58 reached the fixpoint on this very ball in ~2 min) and
is checkpointed. **The fix makes the redo cheaper than the run being protected**, which is the third shape
`CLAUDE.md` lists under *a run that blocks something is presumed killable*; and the run is producing a record under
code I am about to change, which is the second.

**What replaces the guess.** Not a new threshold number — the table above says ball size does not predict the cost.
`run_generation` now gives `direct-witness` a **wall** (`--direct-wall`, 900 s) and, if it is hit, stops it by pid and
**falls back to `extract`** on the same ball under the deletion budget. That is right wherever the cliff actually is,
and the phase record shows it firing here. The threshold moves 20,000 → 15,000 as well, so the common case does not
pay the wall.

**Stopped by pid, verified by effect:** `kill -TERM 1800997`; the pid absent from `ps`, and `land-all` recording
`FAIL: generation` for 95 and moving to the next field — which is the driver's own resumable path, so nothing else is
disturbed. `land 95` is re-run afterwards under the new policy. *(Outcome, after the signal: recorded in §Results.)*

**A second stop at `d = 95`, written before its signal (2026-09-20 08:22).** The re-run through `extract` certified a
1,024-point witness (C.1 CERTIFIED, C.2 all thirteen control rows pass) and then **failed C.4's minimality control**
— see §"What did not go green". I raised the deletion budget 600 → 2,400 s to try to shrink past it, and the
measurement says that cannot work: deletion resumed at position 399 of 1,024 and reached **407 in 724 s**, about
**87 s a test** on the shrunken graph, against ~8 s a test earlier in the same run. Six hundred more tests at that
rate is fifteen hours, for a coin flip on one vertex, on a field FS-58 has already certified. So the deletion is
stopped by pid, the witness emitted from the checkpoint, and **C.4 reported as not green with its diagnosis** — a
rung that does not land is reported as not landed.

**And a second, sharper reason it could not work, found while watching it** (a fact about the frozen `extract`, which
FS-61 may not edit): the deletion checkpoint stores a *scan position* into an order built from the kept set, and a
resume rebuilds that order from the **new, smaller** kept set while reusing the old position. The surviving vertices
keep their relative order, so position `p` in the old list is at most `p` in the new one — the resume therefore
**skips** the vertices that were deleted before it, and can never reach true 1-minimality after an interruption. That
is consistent with what `extract` claims (it says "refusing but NOT 1-minimal"), it costs no soundness, and it means
*a stopped deletion is not a deletion that can be finished later* — only a from-scratch run can be 1-minimal.

## The deletion policy (the owner's ask; my design)

**The rule: stage 1 runs to its fixpoint, stage 2 gets 600 seconds.** `extract`'s stage 1 — CaDiCaL assumption-core
rounds — is the reduction that matters (113,325 → 2,830 points at `d = 359`) and the frozen tool offers no way to
stop it. Stage 2 — deleting one vertex at a time down to 1-minimal — is a **nicety**: gate C.9 *records* minimality
and never requires it, and FS-58's own `witness-95` was certified with it stopped at 363 of 1,737. At `d = 359` it
ran at **45 s a step with ~700 steps left** — nine hours on one field. So stage 2 is given `--deletion-budget`
seconds from the moment its first checkpoint appears; the generator is then stopped **by pid** and re-run with
`--stop-deletion`, which resumes from the last checkpoint and emits. `--gen-cap 5400` is a backstop on the whole
call and not the plan; a field it stops is left resumable, never failed.

*Alternative weighed:* always pass `--stop-deletion` (the owner's first option). It is simpler and it forfeits the
deletion entirely — at 359 that is 2,830 points instead of 1,190, a 2.4× larger witness and, since LRAT size tracks
the graph, a 2–3× larger proof for every later consumer (the checker, FS-60's kernel form). Ten minutes a field buys
that back. *Why this one won:* same worst case, strictly better typical case, and it is what makes the minimality
row say something. *Confidence: high on soundness, and I was wrong about the gate.* A refusing set refuses whether
or not it is minimal, so the budget can never cost correctness — but at `d = 95` it cost a **gate item**: C.4's last
step deletes the pinned vertex and expects a 3-colouring, which a stopped deletion can leave false. That is recorded
under §"What did not go green" and the driver now names it in one line rather than printing a bare FAIL.

*What the stop does NOT do:* it cannot stop stage 1, so a field whose core rounds are slow (`d = 143` at 283,485
points and 116 s a solve; `d = 23` at 248,213 and 55 s) can still exceed half an hour in generation. That is
reported, not rescoped.

**`direct-witness` (balls ≤ 20,000 points) is run whole and unbudgeted**, measured rather than assumed: FS-58's own
log for `d = 47` (8,629 points) reads `5.6 s` end to end, because it takes one Glucose4 assumption core over the
whole ball first and only then deletes over the few hundred vertices that survive. Only `d = 47` (8,629) and
`d = 119` (13,605) take that path; their measured times are in the results table.

## Results — nine fields, eight certified

**Every number below is wall seconds on the desktop named in the header, one heavy job at a time.** The certificate
of a field is `witness.json` + `witness.lrat.gz` under `data/fs61/witness-<d>/`; everything else in that directory is
provenance or a control.

| d | points | edges | the ball it came from | generation | generator | C.9 minimality | edges with 3 in the denominator | witness.json / LRAT | phase C | the value stated |
|---|---|---|---|---|---|---|---|---|---|---|
| **11** | 189 | 452 | 45,521 @ `R=1.0` on `q1+q5+6+10.1+10.2+15.1+15.2+30.1+30.2+30.3` | 9 s | extract | **1-minimal** | 268 of 452 | 19 KB / 381 KB | **CERTIFIED** | `chi(Q(sqrt11)^2) = 4` |
| **23** | 573 | 1365 | 248,213 @ `R=1.3` on `q1+q5+12.1+60.2` | 1171 s | extract | stopped at 467 of 1280 | 866 of 1365 | 56 KB / 2867 KB | **CERTIFIED** | `chi(Q(sqrt23)^2) = 4` |
| **47** | 169 | 385 | 8,629 @ `R=1.5` on `q1+12+60` | 6 s | direct-witness | **1-minimal** | 358 of 385 | 16 KB / 211 KB | **CERTIFIED** | `4 <= chi(Q(sqrt47)^2) <= 5` |
| **71** | 131 | 306 | 47,597 @ `R=1.5` on `q1+q5+60.2+120.2` | 2 s | extract | **1-minimal** | 108 of 306 | 13 KB / 28 KB | **CERTIFIED** | `chi(Q(sqrt71)^2) = 4` |
| **95** | 1004 | 2829 | 17,169 @ `R=1.5` on `q1+12+60.2` | 0 s | extract | stopped at 407 of 1737 | 2484 of 2829 | 108 KB / 18545 KB | **INCOMPLETE** | `chi(Q(sqrt95)^2) = 4` |
| **119** | 456 | 1122 | 13,605 @ `R=1.5` on `q1+12+60.1` | 51 s | direct-witness | **1-minimal** | 996 of 1122 | 45 KB / 1589 KB | **CERTIFIED** | `chi(Q(sqrt119)^2) = 4` |
| **143** | 664 | 1600 | 283,485 @ `R=1.5` on `q1+q5+12+60` | 1161 s | extract | stopped at 1056 of 1769 | 1204 of 1600 | 65 KB / 2186 KB | **CERTIFIED** | `4 <= chi(Q(sqrt143)^2) <= 5` |
| **191** | 292 | 713 | 53,177 @ `R=1.5` on `q1+q5+20+60.1` | 20 s | extract | **1-minimal** | 89 of 713 | 29 KB / 788 KB | **CERTIFIED** | `chi(Q(sqrt191)^2) = 4` |
| **359** | 1190 | 3243 | 113,325 @ `R=1.5` on `q1+q5+60.1+60.2` | 0 s | extract | stopped at 483 of 2019 | 1997 of 3243 | 127 KB / 24487 KB | **CERTIFIED** | `chi(Q(sqrt359)^2) = 4` |

**Two of these are new mathematics and four are new certificates from this route.**

* **`d = 359` is a field nobody had scanned** — it came out of phase B's census, not out of FS-58 — and with the
  prior-art upper bound at the residue plane at 7 it gives **χ(ℚ(√359)²) = 4**, a new exact value.
* **`d = 119` likewise**: `4 ≤ χ` here is FS-61's, and with `L = 4` the value is **χ(ℚ(√119)²) = 4**. (Its ball was
  *priced* in this milestone's phase 0, but no certificate had been produced.)
* **`d = 11` now has a witness from the DIRECT route** — 189 points, 1-minimal, from a ball of 45,521 at `R = 1.0`.
  FS-58 landed 11 only through the chain route (a forcer plus four transported copies), and the milestone's own
  prediction P2 said the direct route would not reach it. It reaches it in **nine seconds**.
* **`d = 143`** was priced in phase 0 and never certified; `4 ≤ χ(ℚ(√143)²) ≤ 5` is now on the checker's word.
* `d = 23, 47, 71, 191` are re-certifications of fields FS-58 already holds, from FS-61's own ball selection. Two of
  them are *smaller* objects than FS-58's (`71`: 131 points; `191`: 292), `47` reproduces FS-58's 169-point witness
  exactly, and `23` is a different, smaller ball (248,213 at `R = 1.3` against FS-58's 440,077 at `R = 1.5`).

**What is NOT claimed.** Every upper bound is prior art at hand level, named in each README and taken from
`data/fs61/frame.jsonl`: the residue plane at 7 for `d = 11, 23, 71, 95, 119, 191, 359` (`L = 4`, so the value is
exactly 4) and at 11 for `d = 47, 143` (`L = 5`, so the bracket is `4 ≤ χ ≤ 5`). No README says more than the
certificate and the named bound give. Nothing here is kernel-checked; `d = 11`'s χ ≥ 4 is kernel from FS-58
(`four_le_chromaticNumber_planeOver_eleven`) and that is a fact about the field, not about this witness.

## The gate, item by item

*One row per gate item per field. Every command is pasteable from the repository root after
`source scripts/dev-env.sh`. `$D` below is the field's radicand.*

**The command that produces every row at once, and the one to re-run first:**

```
python3 tools/fs61_census.py land-all            # resumable; a field whose landing record says CERTIFIED is skipped
```

Its log is `data/fs61/records/land-all.log` (and `land-95.log`, `land-95b.log` for the two `d = 95` runs). The
per-item exit status, output line and seconds of every field are in `data/fs61/landings.jsonl`, one JSON object per
field, keyed by `steps`.

### `d = 11` — **CERTIFIED**, 189 points, 452 edges (`data/fs61/witness-11/`)

| # | item | command, pasteable (`$D` = 11, `$D2` = 23) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 11 data/fs61/witness-11/witness.json` | `data/fs61/witness-11/certified.out` | **PASS** — CERTIFIED: 189 points of Q(sqrt11)^2, each a reduced (a, b, c, e, m); all 452 pairs at distance exactly 1 re-derived in integer arithmetic (17766 cand | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 11 --controls data/fs61/witness-11/witness.json` | `data/fs61/witness-11/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 23 data/fs61/witness-11/witness.json` | `data/fs61/witness-11/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 15] between [0, 0, 0, 0, 1] and [5, 0, 0, -1, 6], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 11 data/fs61/witness-11/witness.json` | `data/fs61/witness-11/recheck.out` | **PASS** — RECHECK PASS: 189 points; 452 unit pairs by Fraction arithmetic over all 17766 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNSAT; | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 11   (step C.5)` | `data/fs61/witness-11/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 452 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 11   (step C.6)` | `data/fs61/witness-11/README.md` | **PASS** — 268 of 452 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 11   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-11/README.md` | **PASS** — `chi(Q(sqrt11)^2) = 4`, upper bound the dyadic prime, inert in K, residue F_4 ([Fischer1990] Thm 9) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 11   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 23` — **CERTIFIED**, 573 points, 1365 edges (`data/fs61/witness-23/`)

| # | item | command, pasteable (`$D` = 23, `$D2` = 35) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 23 data/fs61/witness-23/witness.json` | `data/fs61/witness-23/certified.out` | **PASS** — CERTIFIED: 573 points of Q(sqrt23)^2, each a reduced (a, b, c, e, m); all 1365 pairs at distance exactly 1 re-derived in integer arithmetic (163878 ca | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 23 --controls data/fs61/witness-23/witness.json` | `data/fs61/witness-23/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 35 data/fs61/witness-23/witness.json` | `data/fs61/witness-23/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 51] between [0, 0, 0, 0, 1] and [7, -1, 7, 1, 12], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 23 data/fs61/witness-23/witness.json` | `data/fs61/witness-23/recheck.out` | **PASS** — RECHECK PASS: 573 points; 1365 unit pairs by Fraction arithmetic over all 163878 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNSA | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 23   (step C.5)` | `data/fs61/witness-23/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 1365 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 23   (step C.6)` | `data/fs61/witness-23/README.md` | **PASS** — 866 of 1365 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 23   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-23/README.md` | **PASS** — `chi(Q(sqrt23)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 23   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 467 of 1280 | — |

### `d = 47` — **CERTIFIED**, 169 points, 385 edges (`data/fs61/witness-47/`)

| # | item | command, pasteable (`$D` = 47, `$D2` = 59) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 47 data/fs61/witness-47/witness.json` | `data/fs61/witness-47/certified.out` | **PASS** — CERTIFIED: 169 points of Q(sqrt47)^2, each a reduced (a, b, c, e, m); all 385 pairs at distance exactly 1 re-derived in integer arithmetic (14196 cand | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 47 --controls data/fs61/witness-47/witness.json` | `data/fs61/witness-47/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 59 data/fs61/witness-47/witness.json` | `data/fs61/witness-47/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 69] between [0, 0, 0, 0, 1] and [35, -1, -5, -7, 60], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 47 data/fs61/witness-47/witness.json` | `data/fs61/witness-47/recheck.out` | **PASS** — RECHECK PASS: 169 points; 385 unit pairs by Fraction arithmetic over all 14196 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNSAT; | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 47   (step C.5)` | `data/fs61/witness-47/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 385 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 47   (step C.6)` | `data/fs61/witness-47/README.md` | **PASS** — 358 of 385 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 47   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-47/README.md` | **PASS** — `4 <= chi(Q(sqrt47)^2) <= 5`, upper bound the residue plane at 11 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 47   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 71` — **CERTIFIED**, 131 points, 306 edges (`data/fs61/witness-71/`)

| # | item | command, pasteable (`$D` = 71, `$D2` = 83) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 71 data/fs61/witness-71/witness.json` | `data/fs61/witness-71/certified.out` | **PASS** — CERTIFIED: 131 points of Q(sqrt71)^2, each a reduced (a, b, c, e, m); all 306 pairs at distance exactly 1 re-derived in integer arithmetic (8515 candi | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 71 --controls data/fs61/witness-71/witness.json` | `data/fs61/witness-71/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 83 data/fs61/witness-71/witness.json` | `data/fs61/witness-71/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 64] between [0, 0, 0, 0, 1] and [61, -7, 61, 7, 120], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 71 data/fs61/witness-71/witness.json` | `data/fs61/witness-71/recheck.out` | **PASS** — RECHECK PASS: 131 points; 306 unit pairs by Fraction arithmetic over all 8515 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNSAT;  | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 71   (step C.5)` | `data/fs61/witness-71/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 306 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 71   (step C.6)` | `data/fs61/witness-71/README.md` | **PASS** — 108 of 306 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 71   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-71/README.md` | **PASS** — `chi(Q(sqrt71)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 71   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 95` — **INCOMPLETE**, 1004 points, 2829 edges (`data/fs61/witness-95/`)

> C.4 fails on its MINIMALITY control, not on the refutation: C.1 certified this witness and C.2 passed every plant. The deletion was stopped at 407 of 1737, leaving the pinned vertex redundant. Resume with a larger --deletion-budget (the checkpoint is on disk).

| # | item | command, pasteable (`$D` = 95, `$D2` = 107) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 95 data/fs61/witness-95/witness.json` | `data/fs61/witness-95/certified.out` | **PASS** — (5.2 s) CERTIFIED: 1004 points of Q(sqrt95)^2, each a reduced (a, b, c, e, m); all 2829 pairs at distance exactly 1 re-derived in integer arithmetic (503506 c | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 95 --controls data/fs61/witness-95/witness.json` | `data/fs61/witness-95/controls.out` | **PASS** — (15.0 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 107 data/fs61/witness-95/witness.json` | `data/fs61/witness-95/wrong-radicand.out` | **PASS** — (0.1 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 319] between [0, 0, 0, 0, 1] and [50, -1, -25, -2, 60], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 95 data/fs61/witness-95/witness.json` | `data/fs61/witness-95/recheck.out` | **FAIL** — (344.2 s) RECHECK FAIL: deleting vertex 7 leaves a graph that still refuses (control expected a colouring) | 1 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 95   (step C.5)` | `data/fs61/witness-95/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 2829 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 95   (step C.6)` | `data/fs61/witness-95/README.md` | **PASS** — 2484 of 2829 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 95   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-95/README.md` | **PASS** — `chi(Q(sqrt95)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 95   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 407 of 1737 | — |

### `d = 119` — **CERTIFIED**, 456 points, 1122 edges (`data/fs61/witness-119/`)

| # | item | command, pasteable (`$D` = 119, `$D2` = 131) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 119 data/fs61/witness-119/witness.json` | `data/fs61/witness-119/certified.out` | **PASS** — CERTIFIED: 456 points of Q(sqrt119)^2, each a reduced (a, b, c, e, m); all 1122 pairs at distance exactly 1 re-derived in integer arithmetic (103740 c | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 119 --controls data/fs61/witness-119/witness.json` | `data/fs61/witness-119/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 131 data/fs61/witness-119/witness.json` | `data/fs61/witness-119/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 19] between [0, 0, 0, 0, 1] and [5, 0, 0, 1, 12], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 119 data/fs61/witness-119/witness.json` | `data/fs61/witness-119/recheck.out` | **PASS** — RECHECK PASS: 456 points; 1122 unit pairs by Fraction arithmetic over all 103740 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNSA | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 119   (step C.5)` | `data/fs61/witness-119/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 1122 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 119   (step C.6)` | `data/fs61/witness-119/README.md` | **PASS** — 996 of 1122 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 119   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-119/README.md` | **PASS** — `chi(Q(sqrt119)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 119   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 143` — **CERTIFIED**, 664 points, 1600 edges (`data/fs61/witness-143/`)

| # | item | command, pasteable (`$D` = 143, `$D2` = 155) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 143 data/fs61/witness-143/witness.json` | `data/fs61/witness-143/certified.out` | **PASS** — CERTIFIED: 664 points of Q(sqrt143)^2, each a reduced (a, b, c, e, m); all 1600 pairs at distance exactly 1 re-derived in integer arithmetic (220116 c | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 143 --controls data/fs61/witness-143/witness.json` | `data/fs61/witness-143/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 155 data/fs61/witness-143/witness.json` | `data/fs61/witness-143/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 15] between [0, 0, 0, 0, 1] and [3, -4, 4, 3, 60], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 143 data/fs61/witness-143/witness.json` | `data/fs61/witness-143/recheck.out` | **PASS** — RECHECK PASS: 664 points; 1600 unit pairs by Fraction arithmetic over all 220116 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNSA | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 143   (step C.5)` | `data/fs61/witness-143/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 1600 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 143   (step C.6)` | `data/fs61/witness-143/README.md` | **PASS** — 1204 of 1600 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 143   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-143/README.md` | **PASS** — `4 <= chi(Q(sqrt143)^2) <= 5`, upper bound the residue plane at 11 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 143   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 1056 of 1769 | — |

### `d = 191` — **CERTIFIED**, 292 points, 713 edges (`data/fs61/witness-191/`)

| # | item | command, pasteable (`$D` = 191, `$D2` = 203) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 191 data/fs61/witness-191/witness.json` | `data/fs61/witness-191/certified.out` | **PASS** — CERTIFIED: 292 points of Q(sqrt191)^2, each a reduced (a, b, c, e, m); all 713 pairs at distance exactly 1 re-derived in integer arithmetic (42486 can | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 191 --controls data/fs61/witness-191/witness.json` | `data/fs61/witness-191/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 203 data/fs61/witness-191/witness.json` | `data/fs61/witness-191/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 145] between [0, 0, 0, 0, 1] and [39, 1, -13, 3, 60], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 191 data/fs61/witness-191/witness.json` | `data/fs61/witness-191/recheck.out` | **PASS** — RECHECK PASS: 292 points; 713 unit pairs by Fraction arithmetic over all 42486 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNSAT; | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 191   (step C.5)` | `data/fs61/witness-191/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 713 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 191   (step C.6)` | `data/fs61/witness-191/README.md` | **PASS** — 89 of 713 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 191   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-191/README.md` | **PASS** — `chi(Q(sqrt191)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 191   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 359` — **CERTIFIED**, 1190 points, 3243 edges (`data/fs61/witness-359/`)

| # | item | command, pasteable (`$D` = 359, `$D2` = 371) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 359 data/fs61/witness-359/witness.json` | `data/fs61/witness-359/certified.out` | **PASS** — CERTIFIED: 1190 points of Q(sqrt359)^2, each a reduced (a, b, c, e, m); all 3243 pairs at distance exactly 1 re-derived in integer arithmetic (707455  | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 359 --controls data/fs61/witness-359/witness.json` | `data/fs61/witness-359/controls.out` | **PASS** — CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 371 data/fs61/witness-359/witness.json` | `data/fs61/witness-359/wrong-radicand.out` | **PASS** — REFUSED EDGE_NOT_UNIT: the file lists edge [0, 427] between [0, 0, 0, 0, 1] and [38, -1, -19, -2, 60], which are not at distance 1 | 1 |
| C.4 | second opinion | `python3 tools/fs58_recheck_witness.py 359 data/fs61/witness-359/witness.json` | `data/fs61/witness-359/recheck.out` | **PASS** — RECHECK PASS: 1190 points; 3243 unit pairs by Fraction arithmetic over all 707455 pairs = the file; Lingeling UNSAT, Cadical153 UNSAT, MapleChrono UNS | 0 |
| C.5 | exactly four | `python3 tools/fs61_census.py land 359   (step C.5)` | `data/fs61/witness-359/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 3243 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 359   (step C.6)` | `data/fs61/witness-359/README.md` | **PASS** — 1997 of 3243 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 359   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-359/README.md` | **PASS** — `chi(Q(sqrt359)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 359   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 483 of 2019 | — |


**C.8, reproducibility, and the honest caveat on "byte-identical".**

Run by `python3 tools/fs61_phase_c_checks.py` (artifact: `data/fs61/records/phase-c-checks.out`), which reads the
**generation line out of each committed `run-all.sh`** — the line a reviewer would run — and re-runs it into a
scratch directory, then compares `witness.json` byte for byte:

| d | why this field is in the population | started from | seconds | `witness.json` |
|---|---|---|---|---|
| 47 | `direct-witness`, 1-minimal, the smallest witness here | **an EMPTY directory** | 5.7 | **byte-identical** |
| 71 | `extract`, 1-minimal — core rounds and the whole deletion rerun from nothing | **an EMPTY directory** | 2.0 | **byte-identical** |
| 143 | `extract`, deletion stopped at 1,056 of 1,769 | seeded with its own `steps.jsonl` | 15.5 | **byte-identical** |

**The caveat, stated rather than buried.** For a *stopped* witness, "byte-identical from a clean checkout" is not
attainable and this phase does not claim it: the extraction checkpoint `steps.jsonl` is what fixes where the deletion
stopped, and FS-58 gitignores it (witness-23, -95, -11) as provenance rather than evidence. FS-61 follows FS-58, and
each such `run-all.sh` says so in its own header: from an empty directory the core rounds rerun deterministically and
`--stop-deletion` then stops at position 0, giving the **larger** core-round witness; dropping the flag runs the full
deletion, also deterministic, giving a **smaller** 1-minimal one. What a reviewer checks either way is
`witness.json` + `witness.lrat.gz` **as committed**, through the frozen checker, which re-derives the graph from the
coordinates alone and needs no part of this.

**And the independent re-verification of everything, from the files as committed** (`data/fs61/records/recheck-all.out`):

```
for d in 11 23 47 71 95 119 143 191 359; do
  python3 tools/fs58_check_witness.py --radicand $d data/fs61/witness-$d/witness.json; done
```

→ **9 of 9 CERTIFIED, 0 not**, in 0.0–7.6 s each. (Note that this includes `d = 95`, whose certificate is sound; what
failed there is C.4's *minimality* control, below.)

**C.10** is the product owner's own decorrelated recheck and is not mine to run.

## The plants, and the line each turned red

*Plan rule 7: every new check ships a planted failure that is seen to fire, and both outcomes of every control are
shown reachable. `python3 tools/fs61_census.py selftest --section land` is the new section; it takes 7 s.*

| # | the plant | the line it turned red |
|---|---|---|
| 1 | C.9's reader given FS-58's own **stopped**-deletion provenance (witness-95's, verbatim) | `refusing but NOT 1-minimal: the deletion was stopped at position 363 of 1737` — it must not read `yes` |
| 2 | C.5's four-colouring given `K₅`, which needs five | `PLANT (C.5): K_5 is 5-chromatic, so four_colour must return nothing  --  None` |
| 3 | C.6's barrier counter given FS-58's certified `d = 47` witness with every denominator made prime to 3 | `PLANT (C.6): … counts zero, which is the defect reading  --  0 of 385 edges` (against **358 of 385** on the real points) |
| 4 | the checkpoint repair given a `steps.jsonl` with a truncated final record | `dropped a truncated final record of 38 bytes` — and an intact file is left byte-identical, so it cuts exactly one line |
| 5 | `Landed (certified)` asked about a field whose landing record has been mangled to `INCOMPLETE` | `a record that does not say CERTIFIED cannot promote a field` — **this one was live**: `d = 359` had a `certified.out` on disk and was correctly not landed |
| 6 | the stop verification, shown able to fire before it is shown passing: a child that is still writing | `digest changed while the child was still running`, then, stopped by pid, `reaped with exit -15 … digest static across 5 s` |
| 7 | the `direct-witness` wall, given 5 s on `d = 119`'s ball (`tools/fs61_phase_c_checks.py`) | `direct-witness hit its 5 s wall with nothing on disk; extract took over on the same ball` → a 418-point witness. **Both outcomes reachable**: the same ball with a 600 s wall finishes in `direct-witness` and the fallback never fires (456 points) |

`python3 tools/fs61_census.py selftest` — **7 sections, 38 PASS, 0 FAIL** (`data/fs61/records/selftest.out`).
`python3 tools/fs61_census.py regress untouched` — `git status --porcelain data/fs58 tools/fs58_*` → **0 modified
paths** (gate 0.8, re-read at this phase's end).

Beyond these, every field's C.2 runs the **frozen checker's own twelve plants** plus its faithful twin — 13 `[PASS]`
rows per field, 0 `[FAIL]`, counted by the driver rather than asserted — and C.3 is itself a plant (the same files
offered as a witness over `ℚ(√(d+12))`, refused with `EDGE_NOT_UNIT` and exit 1).

## What did not go green, in those words

**`d = 95`: C.4 is red, and it is red on its minimality control, not on the certificate.**

```
C.4 second opinion   exit 1  FAIL  RECHECK FAIL: deleting vertex 7 leaves a graph that still refuses
                                   (control expected a colouring)
```

What is true at 95 all the same: **C.1 CERTIFIED** by the frozen checker (1,004 points, 2,829 edges, re-verified above
from the committed file), **C.2 all thirteen control rows pass**, C.3 refuses the wrong radicand, C.5 exhibits a
verified 4-colouring, C.6 counts 2,484 of 2,829 barrier edges. What the frozen `fs58_recheck_witness.py` also does
before that control — re-derive every pair of the 1,004 points in exact `Fraction` arithmetic and match the edge list,
then refuse the graph with Lingeling, CaDiCaL 1.5.3 and MapleChrono — is not reached, because the control runs last and
exits at the first failure. So the *second opinion proper* is untested at 95 and the *minimality control* failed; the
driver's own recorded diagnosis says so.

**Why it fails, and why a bigger budget cannot fix it.** `extract` deletes outward-in, so the pinned vertex (at the
translated origin) is tested last and a stopped deletion never reaches it; whether it is load-bearing anyway is luck,
and the luck held at `d = 359, 143, 23` and not at 95. Two independent reasons more deletion does not help: the rate
had fallen to ~87 s a test with ~600 tests to go (fifteen hours), and — the sharper one — a **resumed** deletion in the
frozen `extract` reuses the old scan position against a rebuilt, smaller order, so it skips the vertices deleted
before it and can never reach 1-minimality after an interruption. Only a from-scratch run can.

**Not rescoped.** `d = 95` stands in `data/fs61/census.md` as **`Refusal claimed`**, not `Landed (certified)`, with
its own deepening command in the table — which is what the census language is for. FS-58's independently certified
95 witness (1,068 points, also not 1-minimal, and whose recheck *does* pass) is untouched and still holds
`χ(ℚ(√95)²) = 4`; nothing the project claims depends on this row.

**What would turn it green**, and it is now a flag rather than a paragraph: `python3 tools/fs61_census.py land 95
--ball-rank 2` — the third-cheapest refusing ball (6,997 points at `R = 1.2` on the same lattice) is small enough for
a from-scratch 1-minimal deletion. It writes to `data/fs61/witness-95-rank2/` and its own landing key, so it cannot
overwrite anything standing. **I did not run it**, deliberately: re-picking the object after a control goes red is one
step from tuning until the check agrees with you, and 95 is a re-certification of a field FS-58 already holds. It is
the owner's call whether the 1-minimal object is worth the run.

**Nothing else is red.** C.1–C.3 and C.5–C.7 are green at all nine fields; C.9 is a NOTE by construction; C.8 is
green on all three fields tested with the caveat stated above; C.10 is the owner's.

## Machine, cost, and what a resume looks like now

**Machine:** the desktop (16 physical cores / 32 threads, 128 GB), idle, **one heavy job at a
time throughout**; every number in this record is wall seconds on it.

| what | wall |
|---|---|
| `land-all`, the nine fields in one pass (d = 359's generation already done) | **5,148 s** (1 h 26 m) |
| of which `d = 23` | 1,196 s (core rounds 566 s to a 1,280-point fixpoint, deletion 600 s, emit 16 s, gate 25 s) |
| of which `d = 143` | 1,224 s (core rounds 75 to a 1,769-point fixpoint, deletion 600 s, emit, gate) |
| of which `d = 359` | 417 s, **all of it the gate** — C.4's three outside solvers over 707,455 exact pairs dominate |
| the six other fields | 5, 10, 14, 28, 72 and (95) 2,183 s |
| `d = 95`, three further runs | 2,124 s (stopped), 1,206 s, 365 s |
| C.8 + the wall plant (`fs61_phase_c_checks.py`) | 205 s |
| the full `selftest` | 8 s |
| **phase C total, this session** | **≈ 3 h 20 m of machine time** |

**Resume, for whoever is next.** `python3 tools/fs61_census.py land-all` — it skips every field whose landing record
says CERTIFIED, so today it would run `d = 95` alone; inside a field, `extract` resumes from `witness-<d>/steps.jsonl`
and `land` skips generation entirely when `witness.json` exists, **unless** `--deletion-budget` is larger than the one
that produced it, which is a request to shrink further.

## What the artifacts are, and what is committed

| path | what | committed? |
|---|---|---|
| `data/fs61/witness-<d>/witness.json`, `witness.lrat.gz` | **the certificate** — the only two files a reviewer needs | yes (`witness-359`'s LRAT is 24 MB; the nine total ≈ 33 MB) |
| `…/certified.out`, `controls.out`, `wrong-radicand.out`, `recheck.out` | the verbatim output of C.1–C.4 | yes |
| `…/colouring4.json` | C.5's verified 4-colouring | yes |
| `…/README.md` | written for a reviewer who trusts none of this: the claim, the one re-checking command and what it checks, **what is not claimed** (the upper bound, named prior art), sizes and hashes, and provenance marked as provenance | yes |
| `…/run-all.sh` | regeneration, with the stopped-deletion caveat in its header where it applies | yes |
| `…/generate.out` | the generator's own log, including every stop and its verification line | yes |
| `…/steps.jsonl` | the extraction checkpoint, megabytes of lattice coordinates | **no** — gitignored, following FS-58's witness-23, -95 and -11; provenance, not evidence |
| `data/fs61/landings.jsonl` | one JSON object per field: every C-item's exit status, output line, seconds, and the generation passes with what stopped them | yes |
| `data/fs61/witnesses.jsonl` | the manifest FS-60 consumes, now carrying `minimal` and `deletion_stopped_at` | yes |
| `data/fs61/records/land-all.log`, `land-95*.log`, `phase-c-checks.out`, `recheck-all.out`, `selftest.out`, `table-check.out` | the raw logs behind every row above | yes |


## What I would change in the plan (the owner's call, not mine)

1. **Gate C.8 asks for something a stopped deletion cannot give, and the plan should say which half it wants.**
   "`run-all.sh` from a clean checkout regenerates byte-identical `witness.json`" is true for every 1-minimal witness
   here and, for a stopped one, true only with the extraction checkpoint `steps.jsonl` present — which FS-58
   gitignores as provenance, and which this phase follows. Suggested wording: *regenerates byte-identical
   `witness.json` from the committed directory; where the deletion was stopped, the checkpoint is part of what makes
   that true and `run-all.sh` says so in its header.*

2. **Gate C.4 is two claims wearing one number, and only one of them is about the certificate.** The frozen
   `fs58_recheck_witness.py` re-derives every pair in exact `Fraction` arithmetic and refuses the graph with three
   solvers outside the generator's — that is the second opinion. Its third step then deletes the pinned vertex and
   expects a 3-colouring, which is a **minimality** question and can fail on a witness the frozen checker has
   certified (it did, at `d = 95`). The plan should score those separately, because "C.4 FAIL" currently reads as
   "the second opinion disagrees", and at 95 the second opinion agreed.

3. **The re-ask rule should be stated for the deletion as it is for balls.** §6 phase B says an `Unknown` ball is
   re-asked only when the wall or cap is larger than the recorded one. The same rule is what makes
   `--deletion-budget` mean anything on a re-run, and it was not in the plan; it is now in the code.

4. **C.9's wording.** "is it 1-minimal? recorded yes/no; not required" is right, and it would be worth adding *and a
   witness that is not 1-minimal is not a weaker certificate* — because a reader meeting `stopped at 467 of 1,280`
   in a README will ask, and the answer (a refusing set refuses whether or not it is smallest) belongs beside it.


---

*Everything below is the first implementer's and the product owner's record of the same phase, kept as its history.*

## The first implementer's launch — written before their run started (plan §5 rules 1 and 3)

```
COMMAND     python3 tools/fs61_census.py land-all
ORDER       359, 11, 119, 143, 47, 95, 191, 71, 23   -- the owner's priority: the four fields with no certified
            witness from this route first (359 and 11 are the genuinely new certificates), the five
            re-certifications of FS-58's witnesses last, so that a hand-back loses the least.
RESUME      the identical command.  A field whose data/fs61/landings.jsonl record says CERTIFIED is skipped;
            inside a field, `extract` checkpoints every core round in witness-<d>/steps.jsonl and resumes from it.
STATE       data/fs61/landings.jsonl     one line per field, with every C-item's exit status and output line
            data/fs61/witnesses.jsonl    the manifest FS-60 consumes
            data/fs61/witness-<d>/       witness.json, witness.lrat.gz, certified.out, controls.out,
                                         wrong-radicand.out, recheck.out, colouring4.json, run-all.sh, README.md
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to a file; pgid found by the log file's inode.
PGID        1679918   (stop with `kill -TERM -1679918`, verify by effect)
```

## A correction made before the run, and what it cost

The first attempt certified `d = 359` with FS-58's `direct-witness`, which shrinks a refusing ball to a 1-minimal
vertex set by deleting one vertex at a time. **It does not checkpoint.** At 46,421 points it was still running at
**33 minutes** with nothing on disk, while it blocked the other eight fields — so it was stopped (cleanly: the process
group signalled, nothing left in the group, no partial file) and the threshold between the two generators was lowered
from 100,000 points to **20,000**, above which `extract` is used instead. `extract` runs assumption-core rounds to a
fixpoint and writes `steps.jsonl` after each, so a kill costs one round; FS-58 used it on a **440,077-point** ball over
`d = 23` in about eleven minutes, so at this size it is both the faster tool and the only resumable one. Cost of the
correction: 33 minutes redone, which is what the checkpointing rule prices a mistake at.

## A second correction, made from the measurements, and it was the decisive one

The first `land-all` selected, per field, the **smallest** refusing ball. That is the wrong choice, and the data says
so sharply: the smallest refusing ball sits in **the hard band just under the threshold**, where a single solve costs a
hundred seconds (the plan's own O3 and O4), while an extraction is thousands of solves.

| d | smallest refusing ball | one solve | fastest refusing ball | one solve |
|---|---|---|---|---|
| 47 | 3,565 pts | **103.72 s** | 8,629 pts | **0.45 s** |
| 119 | 5,605 pts | **114.18 s** | 13,605 pts | **0.75 s** |
| 95 | 6,997 pts | 32.07 s | 17,169 pts | 1.07 s |
| 359 | 46,421 pts | 19.19 s | 113,325 pts | 1.75 s |

230× the cost per solve for 2.4× fewer vertices, at `d = 47`. The selection is now the cost proxy
**`points × (solve_seconds + 0.5)`** — which keeps a fast refusal cheap without picking an enormous graph merely
because the solver saw through it instantly.

**Measured effect on `d = 359`, the same field, the same tool, one thing changed:**

```
  smallest ball (46,421 pts, refuses in 19 s):   120 core rounds -> 5,061 points, ~14 s per round, still falling
  fastest  ball (113,325 pts, refuses in 1.8 s):  14 core rounds -> 2,830 points,  0.6 s per round
```

Twenty times faster per round, and converging to a **smaller** set from a **larger** ball. "Smallest ball" was a
plausible heuristic that the measurements refute; the cost of finding that out was the two stopped runs above.

## State at the hand-back

The certification run is **in flight and resumable**. `d = 359`'s extraction has passed its core-round fixpoint and is
in the per-vertex deletion phase, checkpointing as it goes. Nothing is certified yet, so **no field's value has
changed**, and nothing in `census.md` has been touched: every refusal remains `Refusal claimed`, which is what it was.

```
RESUME      python3 tools/fs61_census.py land-all
            A field whose data/fs61/landings.jsonl record says CERTIFIED is skipped; inside a field, extract
            resumes from witness-<d>/steps.jsonl.
RUNNING     pgid 1727573 (stop with `kill -TERM -1727573`, then verify by effect: the pid absent from `ps`
            and witness-359/steps.jsonl static across ten seconds).
```

**Nothing was pushed and nothing was rescoped.** P4 ("every tier-1 refusal certifies") is **not yet scored**: no
extraction has stalled under the corrected selection — the one that looked like stalling was stalling because of my
ball choice, not because of the object.

## HALT RESOLVED by the product owner (2026-09-20) — the death is explained: the owner stopped the run, and failed to say so here first

**Cause, established:** the product owner sent `kill -TERM -1727573` deliberately, after the implementer's hand-back. The defect is
the owner's and it is one of coordination: `CLAUDE.md` says *capture the run's state into the record before signalling, and name
what the kill forfeits* — the forfeit was named to Kooshi and the state was backed up, but **nothing was written in this record
before the signal**, so the implementer's waiter saw a process vanish with no explanation and did exactly what rule 15 asks:
halted, reported, relaunched nothing, and flagged its own hypothesis as a hypothesis. That is the rule working.

**Why it was stopped** (measured by the owner before signalling): the `d = 359` extraction was in its vertex-deletion phase at
**45 s per step** (positions 481 → 483 in 90 s) with about 700 steps left — roughly **nine more hours on one field, with eight
fields queued behind it** in a sequential driver. Vertex-minimality is *recorded, not required* (gate C.9), and FS-58's extractor
has `--stop-deletion` for exactly this (its 95 witness was certified that way). A run that blocks something is presumed killable,
and the checkpoint made the cost of being wrong a redo.

**What the kill forfeits:** a 1-minimal witness over 359, about nine hours away. The checkpoint at position 483 (1,190 points
kept) was copied aside first, so the deletion can be resumed from exactly there if anyone wants the smaller object.

**Verified by effect:** both pids of the group absent from `ps` five seconds after the signal; `steps.jsonl` byte-identical across
100 s (steps had been 45 s apart, so a 12-second check would have proved nothing).

**The implementer's hypothesis — that the harness reaps a subagent's detached jobs at hand-back — is NOT supported, and this run
is evidence against it:** the driver was launched before the hand-back and was alive, progressing and checkpointing at elapsed
1,393 s when the owner first inspected it, well after the hand-back. It died at the owner's signal and at no other time. The
alternative the implementer named — a fault in `extract`'s deletion phase at this scale — is also not indicated: the phase was
slow, not broken.

**Consequence for the driver** (for whoever continues phase C): `land` should pass `--stop-deletion` to `extract`, or run deletion
under a stated per-field time budget, so that one field cannot hold the queue; and a sequential driver should order its fields so
a slow one blocks the fewest.

---

## HALT — the certification run died without explanation (plan §5 rule 15)

Detected immediately after the hand-back, when the waiter armed on "four certificates or the process gone" fired with
**zero certificates**. Reported, not repaired: the plan's fifth halt is *any process dies unexplained*, and the rule is
stop and report, do not diagnose past it or retry.

**The facts, and only the facts:**

* the process group `1727573` is gone; no process of mine remains (`ps`);
* its log contains **no error, no traceback and no final line** — the last thing it wrote was the headline for
  `d = 359`;
* `data/fs61/witness-359/steps.jsonl` holds **94 checkpoints**, the last a `deletion` step at position 483 with
  `finished: false`. So it died *inside* the deletion phase, not between fields;
* **memory was not the cause**: 119 GB available now, and this extraction's worker peaked around 380 MB;
* `dmesg` is not readable as this user, so no kernel-side evidence was obtainable.

**Leading hypothesis, stated as a hypothesis:** the death coincides with the end of my turn, so the likeliest cause is
the harness reaping background processes when the session handed back — an environmental cause, not a fault in the
work. **It is not established**, and it is exactly the kind of "true, sufficient-sounding reason" that this project's
own rules warn stops you looking for the second one. The alternative worth ruling out before any long run is relaunched
is a fault in `extract`'s deletion phase at scale.

**Nothing is lost and nothing is claimed.** The 94 checkpoints are intact, `land-all` resumes from them, no field is
certified, no value changed, and `census.md` is untouched.
