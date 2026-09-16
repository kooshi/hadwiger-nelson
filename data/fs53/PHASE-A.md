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

## A.1 stage 3 — chained from each member's best, and the seven filed records

Each run resumed with `--start` from the best set any earlier run of that member reached, at seed 2.
**Nothing moved at any member.**

| q | filed record | α ≥ (verified) | six needs | short by | the budget behind the plateau |
|---|---|---|---|---|---|
| 23 | `alpha-q23-ge87.json` | **87** | 89 | **2** | 900 s × 3 + 58 symmetry runs + 3600 s × 6 threads; **≈ 96,000 restarts, no movement past 87** |
| 31 | `alpha-q31-ge146.json` | **146** | 161 | 15 | same shape; 75,852 restarts in the chained hour alone |
| 43 | `alpha-q43-ge258.json` | **258** | 309 | 51 | 900 s × 3, then 1800 s × 2 |
| 47 | `alpha-q47-ge265.json` | **265** | 369 | 104 | same |
| 59 | `alpha-q59-ge363.json` | **363** | 581 | 218 | same |
| 67 | `alpha-q67-ge443.json` | **443** | 749 | 306 | same, seeded from rotation order 34 |
| 79 | `alpha-q79-ge578.json` | **578** | 1041 | 463 | same, seeded from rotation order 2 |

Every filed set was re-verified from the definition by the product owner's script **as committed**, not merely
in scratch: 0 internal edges in all seven. Each record carries its budget, threads, seed and `halt`.

**None of these numbers is α.** Each is a plateau at the stated budget; a local search bounds α from below only
and refuses nothing. No six-colour threshold was cleared at any member, so the phase clears no member for six
and eliminates none either.

## The prediction on trial, scored

The bias-corrected growth law predicted **α(23) ≈ 96–97** and **α(31) ≈ 166**. The searches reached **87** and
**146** — 10 % and 12 % below the predicted values, and both **below** the six-thresholds the law put them
above.

**At 23 this is close to as strong as a search verdict gets, and it is still not a refutation.** The instrument
attains the true α at the one plane where the true α is known (28 at `q = 11`, in two seconds on one thread);
at 23 it saturates at 87 within fifteen seconds of a cold start, and then roughly 96,000 restarts across three
stages, three seeds, eight rotation orders, a line quotient and eight core-hours never produce an 88. The
predicted 96 would need **nine** more vertices than anything the search has ever touched there.

**At 31 the same reading is weaker**, because the 31-plane is 1.8× the 23-plane and got the same wall clock;
146 against a predicted 166 is a 20-vertex gap on a graph where the search is less converged.

So: **the law's shape is wrong below `q ≈ 30`, on this evidence** — it over-predicts at both live members, and
at the one member where the search is near-converged it over-predicts by 10 %. That is the milestone's durable
product taking a hit, and it is reported as the outcome it is. What survives is the law's *ordering*: 23 and 31
are still the members closest to their thresholds, by a wide margin.

## A.2 re-aimed: six exact certificates moved the window mid-stage (the product owner, 2026-09-15)

Certificates landed at six members while stage 4 was running. **Five colours are refused at 43 (α ≤ 365) and at
47 (α ≤ 377), and six is refused at 59, 67 and 79.** So 43 and 47 are now the only members of the window where
a single six-colouring settles the question outright — it would exhibit the first exactly six-chromatic finite
Euclidean plane — while at 59, 67 and 79 a six-colour search is now looking for something proved not to exist.

**Cross-instrument consistency, checked before anything was killed.** Every α lower bound this phase verified
sits under the new certified ceiling at the same member: 258 ≤ 365 at 43, 265 ≤ 377 at 47, 363 ≤ 580 at 59,
443 ≤ 748 at 67, 578 ≤ 1040 at 79. The finding side and the certificate side agree at all five. A violation
would have meant one of the two was wrong, so the check is recorded whichever way it came out.

**The three condemned runs were captured before they were signalled, and they are a free negative control.**
At 162 seconds each, `k = 6` at 59, 67 and 79 stood at 5,238 / 104,430, 9,859 / 152,626 and 13,046 / 249,640
monochromatic edges and reported `not_found`. The instrument did not report a six-colouring at three planes
where a certificate now proves none exists — a control that costs nothing because the runs had already been
paid for. It is weak (162 seconds is a short look) and it is recorded as weak. They were then stopped by
`SIGTERM` to the five binaries' own pids, selected by reading `/proc`-backed `ps` output and requiring
`argv[0]` to end in `/plane-colour` — never by matching a command line, which would match this agent's own
shell and other agents' monitors.

**The re-aimed runs** (four, 14,400 s each, seed 3, 24 threads in total, checkpointed through the same
per-tick record; resume: `phaseA/drive2.sh long`):

| run | what | threads | resumed from |
|---|---|---|---|
| `a2-q43-k6-long` | `plane-colour --k 6` at 43 | 8 | the killed stage-4 record, its conflict count re-derived by an independent sweep before it ran |
| `a2-q47-k6-long` | `plane-colour --k 6` at 47 | 4 | likewise |
| `a1-q43-push309` | `plane-independent --target 309` at 43 | 4 | `alpha-q43-ge258.json` |
| `a1-q47-push369` | `plane-independent --target 369` at 47 | 2 | `alpha-q47-ge265.json` |

**Why the last two, which were not asked for.** A six-colouring of the 43-plane partitions 1,849 vertices into
six independent sets, so one of them has at least ⌈1849/6⌉ = **309** vertices — the colour search cannot
succeed unless α(43) ≥ 309, and the best set eight core-hours of a dedicated maximiser reached there is **258**.
The same arithmetic at 47: 369 needed against 265 reached. This is the plan's own peel-and-colour precondition
(§S13.2 A.2), which it states at 23 and says "applies at every member". It does not make the colour search
illegitimate — a free search is not a fixed-class search, and it could in principle discover a 309-class it
never found while maximising — but it does say that the cheaper instrument measures the precondition directly.
So both run, and **the independent-set side is the one that can return an informative negative**: if α at 43
will not pass 309 under hours of a maximiser, that is the reason the colour search came back empty, and it is a
statement about the plane rather than about the colouring search.

**The honest prior, recorded before the results:** 309 needed against 258 reached at 43 is a 20 % gap, and
369 against 265 at 47 is a 39 % gap. Both are long shots and nulls are expected.

## A.2 at 23 and 31, and the one instrument in this phase that decides

**The local searches** (filed as `colour-q23-k6.json`, `colour-q31-k6.json`, `colour-q23-k5.json`):

| record | budget | verdict |
|---|---|---|
| `q = 23`, six colours | 1800 s × 3 threads, seed 1 | not found; best 121 of 6,348 edges monochromatic (1.91 %) |
| `q = 31`, six colours | 1800 s × 3 threads, seed 1 | not found; best 195 of 15,376 (1.27 %) |
| `q = 23`, five colours | 1800 s × 6 threads, seed 1 | not found; best 229 of 6,348 (3.61 %) |

All three are nulls at their budgets. None refuses anything.

**The equivariant sweep at 23 is a different kind of instrument, and it is the strongest thing in this phase.**
`tools/fplane.py equivariant --p 23 --k 6` asks, for one rotation of each order about the origin and one colour
permutation τ per conjugacy class of compatible order, whether a six-colouring exists with `col(r·z) = τ(col z)`
— and each row is a **SAT decision**, not a search. The sweep is committed as `equivariant-q23-k6.json`:

> **47 rows: 0 satisfiable, 43 refused, 4 undecided** at a budget of 5,000,000 conflicts per row; 921.8 s wall
> on 2 jobs, quotient formulation.

So **no six-colouring of `UD(𝔽₂₃,2)` is equivariant under any rotation about the origin under any admissible
colour permutation**, on 43 of the 47 symmetry classes — a refusal, not a null, though **a refusal on the
solver's word and not the kernel's**, and restricted to rotation-equivariant colourings: the plane may still
have a six-colouring with no rotational symmetry at all, and nothing here touches that. The four undecided rows
(rotation orders 2, 2, 3 and 4) are being re-asked at 40,000,000 conflicts, and until they land the sweep's
honest form is "43 of 47 classes refused, 4 open".

This is what the `α` side could not give: at 23 the search side can only say 87 and never 88, which is evidence
about a plateau; the equivariant side says *no* for a whole structured family, by decision.

## The equivariant sweeps at 43 and 47, and what their zeros do **not** say

`tools/fplane.py equivariant --p <q> --k 6`, one rotation of each order about the origin and one colour
permutation τ per conjugacy class of compatible order, each row a SAT decision on the quotient:

| q | rows | satisfiable | refused | undecided at 5,000,000 conflicts | wall |
|---|---|---|---|---|---|
| 23 | 47 | **0** | 43 | 4 | 921.8 s, 2 jobs |
| 43 | 21 | **0** | 18 | 3 | 801.1 s, 4 jobs |
| 47 | 63 | **0** | 59 | 4 | 932.2 s, 4 jobs |

Committed as `equivariant-q23-k6.json`, `equivariant-q43-k6.json`, `equivariant-q47-k6.json`. Every refusal is
**the solver's word, not the kernel's**, and every row is about *rotation-equivariant* colourings only: a
six-colouring with no rotational symmetry is untouched at all three members.

**The undecided rows are the same rows at all three members, and that is the finding.** They are

  rotation order 2 with τ of cycle type (2,2,1,1) and (2,1,1,1,1); order 3 with (3,1,1,1); order 4 with (4,1,1)

— at 43 the order-3 row is simply absent, because 3 ∤ 44. These are precisely the **least constrained**
instances in each sweep: the lowest rotation orders, so the quotient is largest, with the colour permutations
having the most fixed points, so the colouring has the most freedom.

**So the zeros are concentrated where a colouring was least likely to be, and silent where it was most likely
to be.** A sweep that refuses 59 of 63 classes sounds close to exhaustive and is not: the four it could not
decide are the four with the largest search space, which is both why the solver could not finish them and why
they are the rows a six-colouring would plausibly occupy. This is the standing rule that a negative measures
its enumeration — the acceptance test here is "the solver closed it within five million conflicts", and the
rows that fail that test are systematically the informative ones. The 23 sweep's four are being re-asked at
40,000,000 conflicts; the same push at 43 and 47 is not yet run and is the obvious continuation.
