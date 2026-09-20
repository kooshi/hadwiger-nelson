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
rung that does not land is reported as not landed. *(Superseded by the owner's ruling 1 after phase C, and by the
correction under §"What did not go green": what is red at 95 is C.4b, the minimality control; C.4a, the second
opinion proper, passed, and `d = 95` is `Landed (certified)`. The paragraph is left as written because it is what
was known when the run was stopped.)*

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

## Results — nine fields, all nine certified

**Every number below is wall seconds on the desktop named in the header, one heavy job at a time.** The certificate
of a field is `witness.json` + `witness.lrat.gz` under `data/fs61/witness-<d>/`; everything else in that directory is
provenance or a control.

| d | points | edges | the ball it came from | generation | generator | C.9 minimality | C.4b | edges with 3 in the denominator | witness.json / LRAT | phase C | the value stated |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **11** | 189 | 452 | 45,521 @ `R=1.0` on `q1+q5+6+10.1+10.2+15.1+15.2+30.1+30.2+30.3` | 0 s | extract | **1-minimal** | PASS (required) | 268 of 452 | 19 KB / 381 KB | **CERTIFIED** | `chi(Q(sqrt11)^2) = 4` |
| **23** | 573 | 1365 | 248,213 @ `R=1.3` on `q1+q5+12.1+60.2` | 0 s | extract | stopped at 467 of 1280 | PASS (recorded) | 866 of 1365 | 56 KB / 2867 KB | **CERTIFIED** | `chi(Q(sqrt23)^2) = 4` |
| **47** | 169 | 385 | 8,629 @ `R=1.5` on `q1+12+60` | 0 s | direct-witness | **1-minimal** | PASS (required) | 358 of 385 | 16 KB / 211 KB | **CERTIFIED** | `4 <= chi(Q(sqrt47)^2) <= 5` |
| **71** | 131 | 306 | 47,597 @ `R=1.5` on `q1+q5+60.2+120.2` | 0 s | extract | **1-minimal** | PASS (required) | 108 of 306 | 13 KB / 28 KB | **CERTIFIED** | `chi(Q(sqrt71)^2) = 4` |
| **95** | 1004 | 2829 | 17,169 @ `R=1.5` on `q1+12+60.2` | 0 s | extract | stopped at 407 of 1737 | RED (recorded) | 2484 of 2829 | 108 KB / 18545 KB | **CERTIFIED** | `chi(Q(sqrt95)^2) = 4` |
| **119** | 456 | 1122 | 13,605 @ `R=1.5` on `q1+12+60.1` | 0 s | direct-witness | **1-minimal** | PASS (required) | 996 of 1122 | 45 KB / 1589 KB | **CERTIFIED** | `chi(Q(sqrt119)^2) = 4` |
| **143** | 664 | 1600 | 283,485 @ `R=1.5` on `q1+q5+12+60` | 0 s | extract | stopped at 1056 of 1769 | PASS (recorded) | 1204 of 1600 | 65 KB / 2186 KB | **CERTIFIED** | `4 <= chi(Q(sqrt143)^2) <= 5` |
| **191** | 292 | 713 | 53,177 @ `R=1.5` on `q1+q5+20+60.1` | 0 s | extract | **1-minimal** | PASS (required) | 89 of 713 | 29 KB / 788 KB | **CERTIFIED** | `chi(Q(sqrt191)^2) = 4` |
| **359** | 1190 | 3243 | 113,325 @ `R=1.5` on `q1+q5+60.1+60.2` | 0 s | extract | stopped at 483 of 2019 | PASS (recorded) | 1997 of 3243 | 127 KB / 24487 KB | **CERTIFIED** | `chi(Q(sqrt359)^2) = 4` |

*(`C.4b`, the pinned-vertex minimality control, is **required** at the five 1-minimal witnesses and green at all five; **recorded** at the four stopped ones and green at three of them. `d = 95` is the one red cell, and under the owner's ruling 1 it does not bear on landing — see §"What did not go green".)*

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

<!-- GATE:BEGIN -->
### `d = 11` — **CERTIFIED**, 189 points, 452 edges (`data/fs61/witness-11/`)

| # | item | command, pasteable (`$D` = 11, `$D2` = 23) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 11 data/fs61/witness-11/witness.json` | `data/fs61/witness-11/certified.out` | **PASS** — (0.2 s) CERTIFIED: 189 points of Q(sqrt11)^2, each a reduced (a, b, c, e, m); all 452 pairs at distance exactly 1 re-derived in integer arithmetic (17766 cand | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 11 --controls data/fs61/witness-11/witness.json` | `data/fs61/witness-11/controls.out` | **PASS** — (0.8 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 23 data/fs61/witness-11/witness.json` | `data/fs61/witness-11/wrong-radicand.out` | **PASS** — (0.0 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 15] between [0, 0, 0, 0, 1] and [5, 0, 0, -1, 6], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 11 data/fs61/witness-11/witness.json` | `data/fs61/witness-11/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 11 data/fs61/witness-11/witness.json` | `data/fs61/witness-11/recheck.out` | **PASS** — REQUIRED (C.9 says 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 11   (step C.5)` | `data/fs61/witness-11/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 452 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 11   (step C.6)` | `data/fs61/witness-11/README.md` | **PASS** — 268 of 452 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 11   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-11/README.md` | **PASS** — `chi(Q(sqrt11)^2) = 4`, upper bound the dyadic prime, inert in K, residue F_4 ([Fischer1990] Thm 9) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 11   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 23` — **CERTIFIED**, 573 points, 1365 edges (`data/fs61/witness-23/`)

| # | item | command, pasteable (`$D` = 23, `$D2` = 35) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 23 data/fs61/witness-23/witness.json` | `data/fs61/witness-23/certified.out` | **PASS** — (1.0 s) CERTIFIED: 573 points of Q(sqrt23)^2, each a reduced (a, b, c, e, m); all 1365 pairs at distance exactly 1 re-derived in integer arithmetic (163878 ca | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 23 --controls data/fs61/witness-23/witness.json` | `data/fs61/witness-23/controls.out` | **PASS** — (3.3 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 35 data/fs61/witness-23/witness.json` | `data/fs61/witness-23/wrong-radicand.out` | **PASS** — (0.1 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 51] between [0, 0, 0, 0, 1] and [7, -1, 7, 1, 12], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 23 data/fs61/witness-23/witness.json` | `data/fs61/witness-23/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 23 data/fs61/witness-23/witness.json` | `data/fs61/witness-23/recheck.out` | **PASS** — recorded, not required (C.9 says not 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 23   (step C.5)` | `data/fs61/witness-23/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 1365 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 23   (step C.6)` | `data/fs61/witness-23/README.md` | **PASS** — 866 of 1365 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 23   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-23/README.md` | **PASS** — `chi(Q(sqrt23)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 23   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 467 of 1280 | — |

### `d = 47` — **CERTIFIED**, 169 points, 385 edges (`data/fs61/witness-47/`)

| # | item | command, pasteable (`$D` = 47, `$D2` = 59) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 47 data/fs61/witness-47/witness.json` | `data/fs61/witness-47/certified.out` | **PASS** — (0.1 s) CERTIFIED: 169 points of Q(sqrt47)^2, each a reduced (a, b, c, e, m); all 385 pairs at distance exactly 1 re-derived in integer arithmetic (14196 cand | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 47 --controls data/fs61/witness-47/witness.json` | `data/fs61/witness-47/controls.out` | **PASS** — (0.7 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 59 data/fs61/witness-47/witness.json` | `data/fs61/witness-47/wrong-radicand.out` | **PASS** — (0.0 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 69] between [0, 0, 0, 0, 1] and [35, -1, -5, -7, 60], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 47 data/fs61/witness-47/witness.json` | `data/fs61/witness-47/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 47 data/fs61/witness-47/witness.json` | `data/fs61/witness-47/recheck.out` | **PASS** — REQUIRED (C.9 says 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 47   (step C.5)` | `data/fs61/witness-47/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 385 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 47   (step C.6)` | `data/fs61/witness-47/README.md` | **PASS** — 358 of 385 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 47   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-47/README.md` | **PASS** — `4 <= chi(Q(sqrt47)^2) <= 5`, upper bound the residue plane at 11 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 47   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 71` — **CERTIFIED**, 131 points, 306 edges (`data/fs61/witness-71/`)

| # | item | command, pasteable (`$D` = 71, `$D2` = 83) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 71 data/fs61/witness-71/witness.json` | `data/fs61/witness-71/certified.out` | **PASS** — (0.0 s) CERTIFIED: 131 points of Q(sqrt71)^2, each a reduced (a, b, c, e, m); all 306 pairs at distance exactly 1 re-derived in integer arithmetic (8515 candi | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 71 --controls data/fs61/witness-71/witness.json` | `data/fs61/witness-71/controls.out` | **PASS** — (0.5 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 83 data/fs61/witness-71/witness.json` | `data/fs61/witness-71/wrong-radicand.out` | **PASS** — (0.0 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 64] between [0, 0, 0, 0, 1] and [61, -7, 61, 7, 120], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 71 data/fs61/witness-71/witness.json` | `data/fs61/witness-71/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 71 data/fs61/witness-71/witness.json` | `data/fs61/witness-71/recheck.out` | **PASS** — REQUIRED (C.9 says 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 71   (step C.5)` | `data/fs61/witness-71/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 306 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 71   (step C.6)` | `data/fs61/witness-71/README.md` | **PASS** — 108 of 306 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 71   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-71/README.md` | **PASS** — `chi(Q(sqrt71)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 71   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 95` — **CERTIFIED**, 1004 points, 2829 edges (`data/fs61/witness-95/`)

> C.4b, the pinned-vertex MINIMALITY control, is red; C.4a -- the second opinion proper -- passed, and so did C.1 and every one of C.2's plants. The deletion was stopped at 407 of 1737, leaving the pinned vertex redundant. A larger --deletion-budget CANNOT fix this: the frozen extract resumes a deletion at a stale scan position and so skips, and only a from-scratch run can be 1-minimal. Regenerate on a smaller ball: `land 95 --ball-rank <k>`.

| # | item | command, pasteable (`$D` = 95, `$D2` = 107) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 95 data/fs61/witness-95/witness.json` | `data/fs61/witness-95/certified.out` | **PASS** — (5.3 s) CERTIFIED: 1004 points of Q(sqrt95)^2, each a reduced (a, b, c, e, m); all 2829 pairs at distance exactly 1 re-derived in integer arithmetic (503506 c | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 95 --controls data/fs61/witness-95/witness.json` | `data/fs61/witness-95/controls.out` | **PASS** — (14.9 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 107 data/fs61/witness-95/witness.json` | `data/fs61/witness-95/wrong-radicand.out` | **PASS** — (0.1 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 319] between [0, 0, 0, 0, 1] and [50, -1, -25, -2, 60], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 95 data/fs61/witness-95/witness.json` | `data/fs61/witness-95/recheck.out` | **PASS** — step (i)+(ii) — reached step (iii), which in this file is reachable only after (i) and (ii) passed | 1 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 95 data/fs61/witness-95/witness.json` | `data/fs61/witness-95/recheck.out` | **FAIL** — recorded, not required (C.9 says not 1-minimal) — RECHECK FAIL: deleting vertex 7 leaves a graph that still refuses (control expected a colouring) | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 95   (step C.5)` | `data/fs61/witness-95/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 2829 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 95   (step C.6)` | `data/fs61/witness-95/README.md` | **PASS** — 2484 of 2829 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 95   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-95/README.md` | **PASS** — `chi(Q(sqrt95)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 95   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 407 of 1737 | — |

### `d = 119` — **CERTIFIED**, 456 points, 1122 edges (`data/fs61/witness-119/`)

| # | item | command, pasteable (`$D` = 119, `$D2` = 131) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 119 data/fs61/witness-119/witness.json` | `data/fs61/witness-119/certified.out` | **PASS** — (0.5 s) CERTIFIED: 456 points of Q(sqrt119)^2, each a reduced (a, b, c, e, m); all 1122 pairs at distance exactly 1 re-derived in integer arithmetic (103740 c | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 119 --controls data/fs61/witness-119/witness.json` | `data/fs61/witness-119/controls.out` | **PASS** — (1.9 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 131 data/fs61/witness-119/witness.json` | `data/fs61/witness-119/wrong-radicand.out` | **PASS** — (0.1 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 19] between [0, 0, 0, 0, 1] and [5, 0, 0, 1, 12], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 119 data/fs61/witness-119/witness.json` | `data/fs61/witness-119/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 119 data/fs61/witness-119/witness.json` | `data/fs61/witness-119/recheck.out` | **PASS** — REQUIRED (C.9 says 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 119   (step C.5)` | `data/fs61/witness-119/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 1122 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 119   (step C.6)` | `data/fs61/witness-119/README.md` | **PASS** — 996 of 1122 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 119   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-119/README.md` | **PASS** — `chi(Q(sqrt119)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 119   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 143` — **CERTIFIED**, 664 points, 1600 edges (`data/fs61/witness-143/`)

| # | item | command, pasteable (`$D` = 143, `$D2` = 155) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 143 data/fs61/witness-143/witness.json` | `data/fs61/witness-143/certified.out` | **PASS** — (0.7 s) CERTIFIED: 664 points of Q(sqrt143)^2, each a reduced (a, b, c, e, m); all 1600 pairs at distance exactly 1 re-derived in integer arithmetic (220116 c | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 143 --controls data/fs61/witness-143/witness.json` | `data/fs61/witness-143/controls.out` | **PASS** — (2.7 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 155 data/fs61/witness-143/witness.json` | `data/fs61/witness-143/wrong-radicand.out` | **PASS** — (0.1 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 15] between [0, 0, 0, 0, 1] and [3, -4, 4, 3, 60], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 143 data/fs61/witness-143/witness.json` | `data/fs61/witness-143/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 143 data/fs61/witness-143/witness.json` | `data/fs61/witness-143/recheck.out` | **PASS** — recorded, not required (C.9 says not 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 143   (step C.5)` | `data/fs61/witness-143/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 1600 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 143   (step C.6)` | `data/fs61/witness-143/README.md` | **PASS** — 1204 of 1600 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 143   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-143/README.md` | **PASS** — `4 <= chi(Q(sqrt143)^2) <= 5`, upper bound the residue plane at 11 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 143   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 1056 of 1769 | — |

### `d = 191` — **CERTIFIED**, 292 points, 713 edges (`data/fs61/witness-191/`)

| # | item | command, pasteable (`$D` = 191, `$D2` = 203) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 191 data/fs61/witness-191/witness.json` | `data/fs61/witness-191/certified.out` | **PASS** — (0.3 s) CERTIFIED: 292 points of Q(sqrt191)^2, each a reduced (a, b, c, e, m); all 713 pairs at distance exactly 1 re-derived in integer arithmetic (42486 can | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 191 --controls data/fs61/witness-191/witness.json` | `data/fs61/witness-191/controls.out` | **PASS** — (1.2 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 203 data/fs61/witness-191/witness.json` | `data/fs61/witness-191/wrong-radicand.out` | **PASS** — (0.0 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 145] between [0, 0, 0, 0, 1] and [39, 1, -13, 3, 60], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 191 data/fs61/witness-191/witness.json` | `data/fs61/witness-191/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 191 data/fs61/witness-191/witness.json` | `data/fs61/witness-191/recheck.out` | **PASS** — REQUIRED (C.9 says 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 191   (step C.5)` | `data/fs61/witness-191/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 713 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 191   (step C.6)` | `data/fs61/witness-191/README.md` | **PASS** — 89 of 713 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 191   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-191/README.md` | **PASS** — `chi(Q(sqrt191)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 191   (step C.9)` | witness.json `construction.reduction` | **NOTE** — 1-minimal: deleting any single vertex leaves a 3-colourable graph | — |

### `d = 359` — **CERTIFIED**, 1190 points, 3243 edges (`data/fs61/witness-359/`)

| # | item | command, pasteable (`$D` = 359, `$D2` = 371) | artifact | the line that shows the verdict | exit |
|---|---|---|---|---|---|
| C.1 | the certificate | `python3 tools/fs58_check_witness.py --radicand 359 data/fs61/witness-359/witness.json` | `data/fs61/witness-359/certified.out` | **PASS** — (7.3 s) CERTIFIED: 1190 points of Q(sqrt359)^2, each a reduced (a, b, c, e, m); all 3243 pairs at distance exactly 1 re-derived in integer arithmetic (707455  | 0 |
| C.2 | planted faults | `python3 tools/fs58_check_witness.py --radicand 359 --controls data/fs61/witness-359/witness.json` | `data/fs61/witness-359/controls.out` | **PASS** — (19.8 s) CONTROLS ALL PASS | 0 |
| C.3 | wrong radicand | `python3 tools/fs58_check_witness.py --radicand 371 data/fs61/witness-359/witness.json` | `data/fs61/witness-359/wrong-radicand.out` | **PASS** — (0.2 s) REFUSED EDGE_NOT_UNIT: the file lists edge [0, 427] between [0, 0, 0, 0, 1] and [38, -1, -19, -2, 60], which are not at distance 1 | 1 |
| C.4a | second opinion (steps i, ii) | `python3 tools/fs58_recheck_witness.py 359 data/fs61/witness-359/witness.json` | `data/fs61/witness-359/recheck.out` | **PASS** — step (i)+(ii) — RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse | 0 |
| C.4b | pinned-vertex criticality (step iii) | `python3 tools/fs58_recheck_witness.py 359 data/fs61/witness-359/witness.json` | `data/fs61/witness-359/recheck.out` | **PASS** — recorded, not required (C.9 says not 1-minimal) — deleting the pinned vertex leaves a verified 3-colouring | — |
| C.5 | exactly four | `python3 tools/fs61_census.py land 359   (step C.5)` | `data/fs61/witness-359/colouring4.json` | **PASS** — a proper 4-colouring, verified on every one of 3243 edges | — |
| C.6 | the barrier is met | `python3 tools/fs61_census.py land 359   (step C.6)` | `data/fs61/witness-359/README.md` | **PASS** — 1997 of 3243 edges carry 3 in the reduced denominator | — |
| C.7 | the value | `python3 tools/fs61_census.py land 359   (step C.7, from data/fs61/frame.jsonl)` | `data/fs61/witness-359/README.md` | **PASS** — `chi(Q(sqrt359)^2) = 4`, upper bound the residue plane at 7 ([Moorhouse2010] Thm 8.1) | — |
| C.9 | minimality, recorded | `python3 tools/fs61_census.py land 359   (step C.9)` | witness.json `construction.reduction` | **NOTE** — refusing but NOT 1-minimal: the deletion was stopped at position 483 of 2019 | — |

<!-- GATE:END -->

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

**`d = 95`: C.4b is red — the pinned-vertex minimality control — and nothing else is.** Under the owner's ruling 1
after phase C, `Landed (certified)` is C.1–C.3, C.4a, C.5–C.7, so **`d = 95` is landed**; its C.4b is recorded red.

```
C.4a second opinion    exit 1  PASS  step (i)+(ii) — reached step (iii), which in this file is reachable
                                     only after (i) and (ii) passed
C.4b pinned-vertex             FAIL  recorded, not required (C.9 says not 1-minimal) — RECHECK FAIL:
                                     deleting vertex 7 leaves a graph that still refuses
```

**A CORRECTION TO THIS RECORD, against my own work, caught by the product owner.** This section first said that the
second opinion proper *"is not reached, because the control runs last and exits at the first failure"* — which
contradicts itself in one sentence and is wrong. `tools/fs58_recheck_witness.py` (frozen, sha256
`880f5bc48ef39b4c…`) is **straight-line**: (i) every pair re-derived in exact `Fraction` arithmetic must equal the
file's edge list, else it returns; (ii) Lingeling, CaDiCaL 1.5.3 and MapleChrono must each refuse three colours, else
it returns; (iii) deleting the pinned edge's second vertex must leave a 3-colourable graph. The line we got is printed
at step (iii), **so it is reachable only after (i) and (ii) passed**. At `d = 95` the second opinion proper was
**reached and passed**; what was lost was only its PASS line's wording. The owner's own independent recheck (C.10,
different code, two further solvers) reads `RECHECK PASS` on that same file, sha256 `a72fbb80d5f5ff8f…`. The error
was mine and it ran in my favour's opposite direction — it understated the evidence — which is not a reason to leave
it standing.

What is true at 95, in full: **C.1 CERTIFIED** by the frozen checker (1,004 points, 2,829 edges, re-verified from the
committed file), **C.2 all thirteen control rows pass**, **C.3** refuses the wrong radicand, **C.4a** passes, **C.5**
exhibits a verified 4-colouring, **C.6** counts 2,484 of 2,829 barrier edges, **C.7** states `χ(ℚ(√95)²) = 4` against
the named prior-art bound.

**Why C.4b fails, and why a bigger budget cannot fix it.** `extract` deletes outward-in, so the pinned vertex (at the
translated origin) is tested last and a stopped deletion never reaches it; whether it is load-bearing anyway is luck,
and the luck held at `d = 359, 143, 23` and not at 95. Two independent reasons more deletion does not help: the rate
had fallen to ~87 s a test with ~600 tests to go (fifteen hours), and — the sharper one — a **resumed** deletion in the
frozen `extract` reuses the old scan position against a rebuilt, smaller order, so it skips the vertices deleted
before it and can never reach 1-minimality after an interruption. **Only a from-scratch run can.** The driver's
diagnosis line said *"resume with a larger `--deletion-budget`"* until the owner's ruling; it now says what this
paragraph says — regenerate from scratch on a smaller ball (`--ball-rank`).

**Not rescoped, in either direction.** The row moved from `Refusal claimed` to `Landed (certified)` because the
*rule* changed under the owner's ruling and not because anything about the object did: `witness.json` is byte-identical
(`a72fbb80d5f5ff8f…`) and was not regenerated. FS-58's independently certified 95 witness (1,068 points, also not
1-minimal, and whose recheck does pass) is untouched.

**The 1-minimal object at 95, run as a nicety.** `land 95 --ball-rank 2` — the third-cheapest refusing ball (6,997
points at `R = 1.2` on the same lattice), small enough for a from-scratch 1-minimal deletion, into its own directory
and its own landing key so both witnesses stand. It is **not a repair**: 95's state no longer depends on it, so
re-picking the ball is not tuning an object until a check agrees. It is wanted because a later kernel formalisation's
cost tracks witness size. Its result is in §"The `--ball-rank 2` witness at 95" below.

**Nothing else is red.** C.1–C.3, C.4a and C.5–C.7 are green at all nine fields; C.4b is green at the five 1-minimal
witnesses (11, 47, 71, 119, 191) where it is *required*, and recorded at the four stopped ones (23, 143, 359, 95);
C.9 is a NOTE by construction; C.8 is green on all three fields tested with the caveat stated above; C.10 is the
owner's and passes on all nine.

## The `--ball-rank 2` witness at 95 — launch block, written before the run started

*A **nicety, not a repair**: `d = 95` is `Landed (certified)` on its standing witness under the owner's ruling 1, and
that witness is byte-identical to the one the owner's own recheck passed (`a72fbb80d5f5ff8f…`). Nothing about the
field's state depends on this run, which is exactly why running it is not tuning an object until a check agrees. It is
wanted because a later kernel formalisation's cost tracks witness size, and because a from-scratch deletion on a small
ball can be 1-minimal where a resumed one provably cannot.*

```
COMMAND     python3 tools/fs61_census.py land 95 --ball-rank 2
THE BALL    rank 2 of 95's seven refusing balls by the cost proxy: 6,997 points at R = 1.2 on q1+12+60.2,
            one solve 32.07 s.  (Rank 0 is the 17,169-point ball the standing witness came from, one solve
            1.07 s; rank 1 is 35,133 at 2.73 s.)  6,997 < 15,000, so `direct-witness` takes it first.
WHY IT MAY  `direct-witness` cost is set by the initial CORE, not the ball, and at 32 s a solve a core of a
BE SLOW     few hundred is hours.  It therefore runs under `--direct-wall` 900 s; if that fires it is stopped
            BY PID and the checkpointed `extract` takes over the same ball under `--deletion-budget` 600 s.
IF IT DIES  direct-witness phase: everything, it does not checkpoint -- at most 900 s by construction.
            extract phase: at most one core round or 60 s of deletion (witness-95-rank2/steps.jsonl).
RESUME      the identical command.  Generation is skipped once witness.json exists.
WRITES      data/fs61/witness-95-rank2/  and the landing key `95#rank2`.  IT CANNOT TOUCH the standing
            witness-95/ or the landing key `95`: both are separate paths by construction (--ball-rank != 0).
LAUNCHED    setsid, pgid to data/fs61/records/land-95rank2.pgid, no `timeout` wrapper, no pipe.
STOP RULE   it is optional value, not a gate item.  If it is still running after ~40 minutes it is stopped by
            pid, with cause, measurement and forfeit written HERE first, and reported as not landed.
```

### Outcome: NOT LANDED, stopped at 1,470 s by its own stop rule — and the reason is a finding

**What happened, in order.** `direct-witness` ran 905 s on the 6,997-point ball and hit its 900 s wall **with nothing
on disk** — the first time the wall has fired in production, and it did exactly what it is for: the generator was
stopped **by pid** (reaped, `generate.out` digest static across 5 s) and the checkpointed `extract` took over the same
ball. `extract`'s stage 1 then ran four assumption-core rounds:

```
  core round 0: 6997 -> 3308 points (97.4 s)
  core round 1: 3308 -> 2958 points ( 77.0 s)
  core round 2: 2958 -> 2808 points ( 96.7 s)
  core round 3: 2808 -> 2735 points ( 91.3 s)
```

**The measurement that decides it.** The round deltas are 3,689 → 350 → 150 → 73 at ~90 s a round: a slow tail, and
FS-58 needed **72 rounds** to reach its fixpoint on this field's other ball. So stage 1 alone is an hour or more, and
stage 1 **cannot be stopped usefully** — the frozen tool offers no way to halt it, and its intermediate state (2,735
points and falling) is *larger* than the standing witness's 1,004. After it, the deletion would run under the same
600 s budget and be stopped in its turn, so the object this run exists to produce — a **from-scratch 1-minimal**
witness — is not reachable on this ball either.

**So the nicety is declined on a measurement, not on a budget.** At `d = 95` the expensive population is the
deletion solve, on every ball: the standing witness's ball gave ~87 s a test after 400 tests, and this one costs
~90 s per *core round* before deletion even starts. Making 95 1-minimal is priced in hours on the two balls tried,
and the field is `Landed (certified)` without it.

**What the kill forfeits, named:** a witness at 95 that might have been smaller than 1,004 points (not 1-minimal —
that part is ruled out above), and the unmeasured chance that the core fixpoint here is small enough for a cheap
full deletion. Neither is worth an hour of the machine on an explicitly optional item, and neither is lost
permanently: `data/fs61/witness-95-rank2/steps.jsonl` holds the four rounds, and **re-running the identical command
resumes from them**.

**Verified by effect:** the process group signalled by pgid, both pids absent from `ps`, and
`witness-95-rank2/generate.out` byte-identical across 65 s (the core rounds are ~90 s apart, so a shorter check
would prove nothing). No `witness.json` was produced, so no landing record and no manifest line exist for
`95#rank2`; `data/fs61/witness-95/` is untouched and still `a72fbb80d5f5ff8f…`.

**If the owner wants it after all**, the honest command is not this one: it is
`land 95 --ball-rank 2 --deletion-budget <hours>` *after* the core rounds have reached their fixpoint, and the first
thing to measure is that fixpoint's size — the resume above gets there for the price of the rounds already done.


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


## A second, complete gate pass from the committed certificates (2026-09-20, the last thing run)

*The habit the previous implementer left behind — re-run every gate command at the end and read the **counts**, not
the exit codes — and it earned its keep twice today: it caught `/usr/bin/time` missing (the row read `0 of 9
CERTIFIED` while every exit status was 0) and, earlier, the C.2 defect.*

```
for d in 11 23 47 71 95 119 143 191 359; do python3 tools/fs61_census.py land $d; done
```

`data/fs61/records/land-final.log`. Generation is skipped at every field because `witness.json` is already on disk,
so this is **the whole gate re-run against the committed files**: 8 CERTIFIED, 1 INCOMPLETE (`d = 95`, the same C.4
row), identical verdicts to the first pass, and

```
git status --porcelain 'data/fs61/witness-*/witness.json' 'data/fs61/witness-*/witness.lrat.gz'   -> empty
```

— **not one certificate byte moved.** The pass also filled in the per-item seconds now shown in the gate tables
above (C.1 runs from under a second to 7 s; C.4 from 2.7 s to 390 s at `d = 359` and 345 s at `d = 95`, which is
where phase C's wall clock actually goes).

Re-read at the same time: `selftest` **7 sections, 38 PASS, 0 FAIL**; `table --check` **40 fields, 0 defects** and
`census.md` byte-identical on a second regeneration; `regress untouched` **0 modified paths** under `data/fs58` and
`tools/fs58_*`.


## What I proposed to change in the plan — all four accepted (the owner's rulings after phase C, plan §6)

1. **C.8's pass condition** now reads *byte-identical `witness.json` from the committed witness **directory***, with
   the gitignored `steps.jsonl` named as part of what makes that true where C.9 records a stopped deletion, and
   `run-all.sh` saying in its header what a rerun without it produces. The generator writes that header.
2. **C.4 is split.** `C.4a` = the second opinion proper (all pairs in exact `Fraction` arithmetic; Lingeling,
   CaDiCaL 1.5.3 and MapleChrono refusing), **required**. `C.4b` = the pinned-vertex criticality control,
   **required iff C.9 records the witness 1-minimal, otherwise recorded**. `Landed (certified)` = C.1–C.3, C.4a,
   C.5–C.7. The plan had contradicted itself — C.4 demanded what C.9 said was not required — and the driver now
   scores the two separately, tying the step-(iii) inference to the frozen tool's sha256 and **refusing the
   inference outright if that hash moves**, because the inference is about that file and not about the name.
3. **The re-ask rule for the deletion**, the sibling of the existing rule for `Unknown` balls: a
   `--deletion-budget` larger than the one a landing record carries means regenerate; the same or smaller is a
   no-op. Plus the finding that makes it matter — **a stopped deletion is never finished later**.
4. **C.9 gains its clause:** *a witness that is not 1-minimal is not a weaker certificate* — minimality buys size
   (the checker's time, a later formalisation's kernel cost), never soundness. It is in every README that needs it.

## For whoever runs B′ and the second certification pass

*Written for a colleague with only the repository and no memory of this phase. Everything here is something that
otherwise lives only in one session's head.*

**The one-line map.** `tools/fs61_census.py` is the census driver; `land` certifies one field and `land-all` walks
the priority order. Both are **resumable by re-running the identical command** — that is the only resume mechanism
and there is no separate resume flag.

**What `land <d>` does, in order.** Picks the field's refusing ball by the cost proxy `points × (solve_seconds +
0.5)` from `data/fs61/fields/<d>/balls.jsonl` (**not** the smallest ball — the smallest sits in the hard band just
under the threshold, 230× the cost per solve at `d = 47`); generates a witness with FS-58's frozen generator; then
runs C.1, C.2, C.3, C.4a, C.4b, C.5, C.6, C.7, C.9 and writes `README.md`, `run-all.sh`, `.gitignore`,
`landings.jsonl` and `witnesses.jsonl`.

**Resume semantics you will trip on if nobody says them.**
* `land-all` **skips a field whose landing record says `CERTIFIED`**. To redo one, run `land <d>` directly.
* `land <d>` **skips generation entirely when `witness.json` already exists** — so it is the cheap way to re-score a
  field under changed gate rules without touching the certificate, and the *expensive* way to notice that a flag you
  passed did nothing. The one exception is the re-ask rule: a `--deletion-budget` **larger** than the one in the
  landing record deletes `witness.json` and regenerates from the checkpoint. Equal or smaller is a no-op.
* Inside a field, FS-58's `extract` checkpoints every core round and every 60 s of deletion into
  `witness-<d>/steps.jsonl`, so a kill costs at most one round or one minute.

**The flags, and what they are for.**

| flag | default | why it exists |
|---|---|---|
| `--deletion-budget` | 600 s | stage 2, the one-vertex-at-a-time deletion, is a nicety C.9 records and never requires; at `d = 359` it ran at 45 s a step with ~700 steps left — nine hours on one field |
| `--gen-cap` | 5400 s | a backstop on the whole generation call, never the plan; a field it stops stays resumable |
| `--direct-wall` | 900 s | `direct-witness` cannot checkpoint, so it gets a wall and then `extract` takes over the same ball |
| `--ball-rank` | 0 | which refusing ball to shrink, cheapest first; a non-zero rank writes to `witness-<d>-rank<k>/` and its own landing key, so a standing witness is never overwritten |

**Which fields are slow, and why it is not the ball size.**
* `d = 23` (248,213-point ball, 55 s a solve) and `d = 143` (283,485, 116 s) spend **10 and 20 minutes in the
  assumption-core rounds alone**, which no flag can bound — the frozen `extract` offers no way to stop stage 1, and
  it is the reduction that matters (113,325 → 2,019 points at `d = 359`). Budget for that; it is not a hang.
* **`direct-witness`'s cost is set by the initial core, not by the ball**, and the core is unknown until it is
  running: 8,629 points → 5.7 s (core 169), 13,605 → 51 s (core 456), 17,169 → unfinished at 2,124 s (core ≥ 1,737).
  It deletes one vertex at a time *against the whole ball's formula*; `extract` deletes against the kept set only.
  That is why there is a wall and a fallback rather than a cleverer threshold.
* **A stopped deletion is never finished later.** `extract` stores a scan position into an order built from the kept
  set and, on resume, rebuilds that order from the *smaller* kept set while reusing the old position — so it skips
  the vertices already deleted. Sound (it only ever claims "refusing"), but only a from-scratch run is 1-minimal.

**Traps this phase paid for.**
* **A waiter armed on a log line the SUCCESS path prints at its START is already true when you arm it.** I did
  this twice in ten minutes at the end of this phase, watching for `d=95:` — which is the *headline* `fs61 land
  d=95: …` printed before any work — so the wait returned instantly and twice made a running job look finished.
  This repository's rules already carry that trap with two instances; here is a third, and it is mine. **Wait on a
  PID** (`while kill -0 <pid>; do sleep 20; done`), which cannot be true early and cannot self-match, and assert
  the condition is false in the same breath as arming it.
* **`/usr/bin/time` does not exist on this machine.** A verification loop using it returned exit status 0 on every
  field while its count read `0 of 9 CERTIFIED`. Read the *counts*, never the exit codes — it is how both of this
  phase's real defects were caught.
* A gate's verdict may not be on the **first** line: the frozen checker puts `CERTIFIED` first but
  `CONTROLS ALL PASS` **last**. C.2 could never have gone green until that was fixed.
* `Landed (certified)` must be read from the checker's **verdict**, never from `certified.out` existing — `land`
  writes that file whatever the checker says.
* Two `.out` files in a witness directory are a **transcript**, not a verdict: `recheck.out` at `d = 95` says
  `RECHECK FAIL` and the field is nonetheless landed, because that line is step (iii). See the correction above.

**What is committed and what is not.**
* Committed, and the whole of what a reviewer needs: `witness.json` + `witness.lrat.gz`, plus `certified.out`,
  `controls.out`, `wrong-radicand.out`, `recheck.out`, `colouring4.json`, `README.md`, `run-all.sh`, `generate.out`.
* **Gitignored: `witness-<d>/steps.jsonl`** (megabytes of lattice coordinates), following FS-58's own witness-23,
  -95 and -11. It is provenance, not evidence — **but it is what makes `run-all.sh` reproduce a stopped-deletion
  witness byte-identically**, so a rerun from a fresh clone gives the larger core-round witness with
  `--stop-deletion` and a smaller 1-minimal one without. Each such `run-all.sh` says this in its own header.
* Also gitignored: `data/fs61/records/*.pgid` (stale process-group ids).

**Sizes, so nothing surprises you.** The nine witness directories are ≈ 33 MB committed; `witness-359`'s proof is
24 MB and `witness-95`'s 18 MB. C.4a is where the wall clock goes on a big witness — 390 s at `d = 359` and 345 s at
`d = 95`, against 2.7 s at `d = 71` — because three older solvers re-refute a non-minimal graph.

**Standing rules that are not negotiable and cost real hours when broken.** `tools/fs58_*.py` and `data/fs58/` are
frozen — import and call, never edit, and `git status --porcelain data/fs58 tools/fs58_*` must stay empty. Plan edits
go only under §R. One heavy job at a time. Anything over ~15 minutes checkpoints, with its resume command written in
the phase record *before* launch. Stop a run **by pid or pgid**, never by matching a command line, and verify by
effect — the pid gone *and* the artifact it was writing static for longer than one unit of work (the deletion
checkpoints are 60 s apart, so a 12-second check proves nothing). No `timeout` wrapper and no pipe on a long run.

