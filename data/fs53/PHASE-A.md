# FS-53 phase A — the finding side: α and six-colourings across the window

*Runner: de Bruijn (experiment runner), 2026-09-15, desktop (16 physical cores / 32 threads).
A second agent holds the two graphics cards and a little CPU, so this phase runs at **≤ 24 threads at any instant**.
Scope: the seven **prime** members 23, 31, 43, 47, 59, 67, 79. `q = 27 = 3³` is excluded — both Rust tools take
`--p <PRIME>` only — and goes to a separate work order.*

## What this phase can and cannot say

Both instruments are local searches. `plane-independent` reports a set only after a pairwise sweep from the
definition; it can never say a larger set does not exist. `plane-colour` reports a colouring only after an
independent sweep of every vertex pair; it can never say no colouring exists. **Every `not_found` here is a null at
a stated budget, never a refusal, and every largest set reached is written "plateau at N under budget B", never as
α.**

## Controls, before anything was launched

| control | result |
|---|---|
| `plane-independent --self-test` | 28 controls, 28 passed (`log/selftest-indep.txt` in the job scratch) |
| `plane-colour --self-test` | 25 controls, 25 passed |
| planted failure for the verification step | see § The plant, below |

## The run schedule, and the resume command for every stage (written BEFORE launch)

Scratch (records and logs, not committed): `/home/kooshi/.claude/jobs/b1507518/tmp/phaseA/{rec,log}/`.
**One `--out` path per run, never shared** — `plane-independent`'s temporary file is a fixed `<path>.tmp`, so two
concurrent runs on one path can rename a hybrid record (the engine's D91, ruled "manageable by convention" in
`plans/STUB-sixth-colour.md` §S13.2 A0.3). Every run's `--out` below is unique to that run.

Both tools rewrite the whole record through a temporary file and a rename at **every progress tick**, so a run
killed at any instant leaves a complete, already-verified record. **That is this phase's checkpoint**, and it lives
in the job scratch, outside `build/`. The driver is a snapshot copy (`build/…` is never used); it is launched under
`setsid` with its pgid in `phaseA/pgid.txt`, and it is stopped by `kill -- -<pgid>`, never by matching a command line.

| stage | what runs | budget | threads | resume command |
|---|---|---|---|---|
| A.1 s1 | free α search, all 7 members concurrent | 900 s each | 7 × 3 = 21 | `phaseA/drive.sh s1` |
| A.1 s2 | α under each rotation order dividing `q+1`, and the line quotient | 180 s each | 8 × 3 = 24 | `phaseA/drive.sh s2` |
| A.1 s3 | free α search chained with `--start` from the best set of s1+s2 | 3600 s at 23, 31; 1800 s elsewhere | 22 | `phaseA/drive.sh s3` |
| A.2 s4 | `plane-colour --k 6`, all 7 members concurrent | 1800 s each | 7 × 3 = 21 | `phaseA/drive.sh s4` |
| A.2 s5 | `plane-colour --k 5` at 23; `fplane.py equivariant` at the prime members | see below | ≤ 24 | `phaseA/drive.sh s5` |

Every stage is idempotent: a re-run overwrites its own scratch records and nothing else. A stage killed part way
is resumed by re-running it; the runs that already finished cost their budget again, which is the price of not
having a stage-level checkpoint, and is minutes rather than hours at every stage but s3.

*(The results tables below are filled in as the stages land.)*

## The calibration, before any result (2026-09-15, the runner)

**Two threads reach 87 at `q = 23` in fifteen seconds** — the best size found anywhere for that plane, from a
cold start, on a fifteen-second smoke test. The search saturates at the best known size almost immediately. So
**the question at 23 is not whether the search is strong enough to reach the neighbourhood; it is whether 88
exists at all.** That changes what a null at 23 means: it stops being "we did not look hard enough" and becomes
weak but real evidence about the graph. It is still a null at a budget and it is never a refusal — a local
search cannot bound α from above, and only a certificate can.

## The prediction on trial (the product owner, registered in `plans/STUB-sixth-colour.md` §S6)

The bias-corrected growth law — corrected against the one plane whose α is known exactly — predicts
**α(23) ≈ 96–97** and **α(31) ≈ 166**, both **above** the six-thresholds this phase targets (89 and 161). The
law is the milestone's durable product, and this phase is its test. A plateau well below those numbers at both
members says the law's shape is wrong below `q ≈ 30`; that is a real outcome and is reported as one.

## The plant, fired (standing rule 9)

The false positive that would move this milestone is a claimed 88 or 89 at `q = 23` that is not independent. It
was fabricated exactly: the real 87-set plus one point adjacent to a member of it
(`rec/PLANT-q23-unitpair.json` in the job scratch, vertex 29 = (1, 6) beside vertex 6 = (0, 6) under the
record's own `v = x·p + y` index). It was pointed at the **product owner's** verifier, not at the runner's own:

```
python3 tools/fplane_review_verify.py indep --q 23 --json <plant> --path best_set
  independent set of size 88; internal edges 16
  NOT INDEPENDENT: e.g. [(6, 29), (29, 30), (29, 52)]          exit 1
```

It refused by name, naming the offending pairs, before printing any threshold consequence. The same script
verifies the real 87-set as INDEPENDENT with 0 internal edges, so both outcomes of the control are reachable.

## The positive control: the instrument at the one plane whose α is known exactly

`α(UD(𝔽₁₁,2)) = 28` exactly (FS-50: a search reaching 28 under a certificate of `α ≤ 29.18`). Pointed at it
cold, **one thread reaches 28 in two seconds** and holds it for the rest of a 60-second budget across 378
restarts (`rec/ctl-q11-known.json`). The instrument attains the true α where the true α is known — reach
28/28. That is what licenses reading a plateau elsewhere as weak evidence about the graph rather than only
about the search, and it is the control G21 demands before any zero is believed.

**The comparison it does not license.** At 11 the search reaches 0.810 of the ratio bound (28/34.55) and at 23
it reaches 0.660 (87/131.76), but those two numbers differ in **two** things — the plane and the search effort
per vertex — so the drop is not evidence that α sits lower against its bound at 23. The 11-plane has 121
vertices and the 23-plane 529; one thread saturates the first in seconds.

## A.1 stage 1 — the free search, 900 s × 3 threads, seed 1, at every member

Every set below was re-verified from the definition by the product owner's independent script
(`tools/fplane_review_verify.py indep`), which shares no code with the search: **0 internal edges in all seven.**

| q | plateau under this budget | six needs α ≥ | plateau / threshold | restarts | verdict |
|---|---|---|---|---|---|
| 23 | **87** | 89 | 0.978 | 9,330 | `not_found` at 900 s |
| 31 | **146** | 161 | 0.907 | 8,658 | `not_found` at 900 s |
| 43 | **258** | 309 | 0.835 | 5,978 | `not_found` at 900 s |
| 47 | **265** | 369 | 0.718 | 6,049 | `not_found` at 900 s |
| 59 | **363** | 581 | 0.625 | 4,139 | `not_found` at 900 s |
| 67 | **422** | 749 | 0.563 | 4,015 | `not_found` at 900 s |
| 79 | **523** | 1041 | 0.502 | 3,806 | `not_found` at 900 s |

**Every row is a plateau at N under a budget of 900 seconds on 3 threads at seed 1, and none of them is α.**
A local search bounds α from below only; nothing here refuses six colours anywhere.

**Read the last column before the third.** The seven rows differ in **two** things at once — the plane and the
search effort per vertex — because the budget is flat while the graph grows from 529 to 6,241 vertices. The
23-plane gets 9,330 restarts and the 79-plane 3,806 on a graph 11.8× larger. So the fall-off of
plateau/threshold with `q` is **not** a measurement of the planes; it is mostly a measurement of a flat budget
spread over growing graphs. The one row where the plateau is near-converged is **23**, where all three threads
independently sit at exactly 87 (`spread_low = spread_high = 87`), the best was reached in the first fifteen
seconds, and 9,330 restarts over fifteen minutes never moved it.

## A.1 stage 2 — the symmetry sweeps: every rotation order dividing `q + 1`, and the line quotient

58 runs, 180 s × 3 threads × seed 1 each (`--rotation-order m` searches only the sets invariant under a rotation
of order `m`; `--line-direction` only those invariant under the translations along a line). Best per member,
beside stage 1's free plateau:

| q | free, 900 s | best restricted, 180 s | which | change |
|---|---|---|---|---|
| 23 | 87 | 86 | rotation order 2 | −1 |
| 31 | 146 | 146 | rotation order 2 | 0 |
| 43 | 258 | 258 | line quotient, and rotation order 2 | 0 |
| 47 | 265 | 265 | rotation orders 2, 3, 4, 12, 24 | 0 |
| 59 | 363 | 363 | rotation order 2 | 0 |
| 67 | 422 | **443** | rotation orders 17 and 34 | **+21** |
| 79 | 523 | **578** | rotation order 2 | **+55** |

The two improved sets were re-verified from the definition: 443 at 67 and 578 at 79, **0 internal edges** in
each. They are independent sets of the whole plane, not of a quotient.

**The finding, and the direction of the comparison is what is safe in it.** At the two largest members a
*restricted* search beat the free one **on one fifth of the budget**. Restriction and budget both differ
between those two numbers, so the *size* of the gain is not measured — but the sign is, because the winner had
less of everything except the symmetry. Searching only the invariant sets divides the search space by the
rotation order, and on a graph of 4,489 or 6,241 vertices that is worth more than 5× the wall clock.

**What it says about stage 1's table.** The free plateaus at 67 and 79 were **not** converged: 180 seconds of a
better-shaped search moved them by 21 and 55. So the fall-off of plateau/threshold with `q` in stage 1 was, as
that table said in advance, mostly a measurement of a flat budget spread over growing graphs — and here is the
direct evidence, rather than the caveat. The result stands for 23 in the other direction: no rotation order and
no line quotient reaches even 87 there, so 23's plateau is the one that does not move under a change of method.
