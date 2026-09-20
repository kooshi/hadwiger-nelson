# FS-61 phase 0 — the instrument: the phase record

*Plan: `plans/FS61-quadratic-census.md` §6 phase 0, §5 rule 16. Implementer: de Bruijn (Opus 5), 2026-09-19.
Machine for every number below: **the desktop, 16 physical cores / 32 threads, 128 GB**, idle, one
heavy job at a time. Timings are wall seconds on that machine unless a row says CPU seconds. Every command is pasteable
from the repository root after `source scripts/dev-env.sh`.*

**What phase 0 built.** `tools/fs61_census.py`, the census driver: a thin layer over the frozen FS-58 instrument
(`tools/fs58_search.py`, `fs58_local.py`, `fs58_chain.py` — imported and called, never edited). It enumerates a field's
lattices at a named depth, gives each one a canonical name so that one lattice has one name however many class specs
produce it, asserts that every unit vector lying in a lattice is one of its generators, asks whether balls of those
lattices are 3-colourable, and records all of it as JSONL that a re-run resumes from.

**Verdict: 8 of 8 gate items green**, each with its command, artifact and output line below. Four carry a finding that
changes what a later phase should do, gate 0.5's planted fault is unreachable *as the plan words it*, and one run was
lost to a rule I broke — all of it written out below rather than smoothed over. Nothing halted (plan §5 rule 15).

---

## The gate

| # | item | command (pasteable) | artifact | the line that shows the pass | exit |
|---|---|---|---|---|---|
| 0.1 | FS-58 regression, lattices | `python3 tools/fs61_census.py regress lattices --jobs 16` | `data/fs61/regress/lattices.jsonl`, `data/fs61/regress/lattices-<d>.jsonl` | `DONE regress lattices: 14 fields, 0 failures` — and per field, e.g. `d= 11 nmax=180: 388 FS-58 records (388 rank 4) -> 70 distinct lattices; FS-61 70 specs -> 70 rank-4 keys; 36 keys carry more than one spec; PASS [1.8 s]` | 0 |
| 0.2 | FS-58 regression, refusals | `python3 tools/fs61_census.py regress refusals` | `data/fs61/regress/refusals.jsonl`, `data/fs61/fields/<d>/balls.jsonl` | `DONE regress refusals: 5 balls, 0 failures` | 0 |
| 0.3 | FS-58's certificates still certify | `python3 tools/fs61_census.py regress certificates` | `data/fs61/regress/certificates.jsonl` | `DONE regress certificates: 6 witnesses, 0 failures` | 0 |
| 0.4 | paired negative controls | `python3 tools/fs61_census.py regress controls --jobs 16` (which runs, per field, `lattices` then `filter` then `scan --filter-off`, and applies the three pass conditions) | `data/fs61/regress/controls.jsonl`, `data/fs61/controls.md`, `data/fs61/fields/<d>/balls.jsonl` | `DONE regress controls: 8 fields, 0 failures` — and per field, e.g. `d= 47 (positive control, chi=at least 4): 55 lattices (8 bipartite), 110 balls -> 47 Colourable (colouring verified), 59 Over cap (not asked), 3 Refused (solver claim), 1 Unknown (budget); PASS` | 0 |
| 0.5 | canonical keys | `python3 tools/fs61_census.py selftest --section keys` | stdout | `DONE selftest: 1 sections, 0 failures` | 0 |
| 0.6 | saturation is asserted | `python3 tools/fs61_census.py selftest --section saturation` and gate 0.1's generator comparison over the 14 fields | stdout, `data/fs61/regress/lattices.jsonl` (`generator_sha_mismatches: []`) | `DONE selftest: 1 sections, 0 failures` | 0 |
| 0.7 | resume | see §0.7 below | `data/fs61/fields/143/balls.jsonl` | see §0.7 | 0 |
| 0.8 | FS-58 untouched | `python3 tools/fs61_census.py regress untouched` | `data/fs61/regress/untouched.jsonl` | `fs61 regress untouched: ... -> 0 modified paths` | 0 |



---

## §0.1 and §0.6 — the FS-58 regression: one lattice, one name, and every unit vector a generator

```
python3 tools/fs61_census.py regress lattices --jobs 16      # 6.6 s wall, the 14 fields, resumable per field
```

FS-58's fourteen fields, each at **FS-58's own depth** — which this run determined from the records rather than taking
from the plan: `NMAX = 180` for twelve fields, **300 for `d = 23`** and **420 for `d = 167`**, the plan's claim confirmed
by rebuilding each field's class-combination list at 180, 300 and 420 and keeping the one that reproduces FS-58's key set
exactly.

| d | depth | FS-58 records (all rank 4) | distinct lattices | keys with more than one spec | verdict |
|---|---|---|---|---|---|
| 11 | 180 | 388 | 70 | 36 | PASS |
| 23 | 300 | 599 | 170 | 92 | PASS |
| 35 | 180 | 134 | 53 | 21 | PASS |
| 47 | 180 | 101 | 55 | 24 | PASS |
| 59 | 180 | 61 | 29 | 7 | PASS |
| 71 | 180 | 161 | 50 | 21 | PASS |
| 83 | 180 | 21 | 18 | 3 | PASS |
| 95 | 180 | 70 | 41 | 14 | PASS |
| 107 | 180 | 18 | 16 | 2 | PASS |
| 131 | 180 | 28 | 22 | 4 | PASS |
| 143 | 180 | 32 | 24 | 6 | PASS |
| 167 | 420 | 81 | 57 | 17 | PASS |
| 179 | 180 | 24 | 15 | 4 | PASS |
| 191 | 180 | 43 | 28 | 10 | PASS |
| **total** | | **1,761** | **648** | **261** | **0 failures** |

Two comparisons run, and they catch different things:

* **the key sets** (`keys_only_in_fs61`, `keys_only_in_fs58` — both empty on every field): FS-61's canonicalisation of its
  own class combinations, and FS-61's canonicalisation of the vector lists FS-58 recorded, name the same 648 lattices;
* **the generator sets** (`generator_sha_mismatches` — empty on every field): for every shared key, the saturation FS-61
  recomputes from the canonical key (enumerate the unit vectors of denominator `M`, test membership through the Hermite
  form) is byte-identical to the one FS-58's `_saturate_one` computed by a different route (`inverse()` over `Fraction`s).
  This is gate 0.6 over all fourteen fields at once, and it is a two-implementation cross-check, not a self-check.

**261 of 648 keys carry more than one class spec** — 40 % of FS-58's lattice records are duplicates under another name.
That is decision C's cost, measured.

## §0.5 — canonical keys, and what a key can and cannot see

```
python3 tools/fs61_census.py selftest --section keys          # 0.4 s
python3 tools/fs61_census.py selftest --section saturation    # 0.4 s
```

Checks, all PASS: two specs of one lattice (`119: q1+60.1`, `q1+12+60.1`) give one key; a different lattice
(`119: q1+12`) gives a different key; 25 randomly permuted, sign-flipped, unimodularly transformed bases of one lattice
all give the same key; the saturation of `119 q1+12+60.1` is its own generating set (28 of 28).

**Finding — the plan's 0.5 plant is unreachable as written, and the reason matters.** The plan asks that "a key computed
from a non-saturated vector list must differ". It cannot. The key is a function of the **lattice**, and these generating
sets are closed under negation (FS-58's `orbit()` includes the quarter turn), so removing, doubling or otherwise mutating
a **single** generator leaves `-v` in the list and the ℤ-span unmoved. Confirmed by exhaustion in the selftest: all 28
single-generator deletions from `119 q1+12+60.1` give the identical key.

So the protection is split, and both halves are tested:

| what goes wrong | what catches it | shown to fire by |
|---|---|---|
| the generator set is not the full saturation | `lattice_record`'s explicit assertion → `saturated: false` and the missing vectors **named** | selftest plant (names `[0, 0, 60, 0]`, and confirms that vector really is a unit vector of the lattice) |
| a generator is corrupted (dropped or doubled) | the `generators_sha256` comparison | two regression plants in a scratch tree: `generator mismatches 1`, key sets unchanged |
| the lattice itself is wrong | the key-set comparison | a third regression plant (one record cut to its rational generators — a genuinely smaller lattice): `only-fs61 1, only-fs58 1`, generator shas unchanged |

The third plant exists because the key comparison would otherwise be a check whose informative outcome was never shown
reachable. Each plant fires on its own clause and leaves the others silent.

## §0.2 — FS-58's five refusing balls, re-asked through the census's own `scan`

```
python3 tools/fs61_census.py regress refusals        # 299.2 s wall, resumable per ball
```

```
  d=  47 q1+12+60             R=1.5: 8629 points, 41144 edges -> Refused (solver claim) [0.45 s] (FS-58: 8629, 41144) PASS
  d=  71 q1+q5+60.2+120.2     R=1.5: 47597 points, 227726 edges -> Refused (solver claim) [0.07 s] (FS-58: 47597, 227726) PASS
  d=  95 q1+12+60.2           R=1.5: 17169 points, 82206 edges -> Refused (solver claim) [1.07 s] (FS-58: 17169, 82206) PASS
  d= 191 q1+q5+20+60.1        R=1.5: 53177 points, 325524 edges -> Refused (solver claim) [0.11 s] (FS-58: 53177, 325524) PASS
  d=  23 q1+q5+12.1+60.2      R=1.3: 248213 points, 1220300 edges -> Refused (solver claim) [54.88 s] (FS-58: 248213, 1220300) PASS
DONE regress refusals: 5 balls, 0 failures -> data/fs61/regress/refusals.jsonl
```

Every point count and every edge count is identical to FS-58's record, and every verdict is a refusal. (Solve times are
not compared: they are a different run on a different day, and FS-58's were taken under a sixteen-way pool.)

**Two things this establishes beyond the gate.** First, all five of FS-58's refusing pools **already are** saturated
lattices — the saturation adds nothing to any of them (`saturated_equals_fs58_pool: true` in every row), so the census's
"full unit-distance graph" view and FS-58's pool view give the same graph on these five, and the comparison is
like-for-like rather than an inequality that happens to point the safe way. Second, each is reached through the
census's own tier-1 lattice enumeration and named by its canonical key, and **each of the five carries two class specs**
(e.g. 47's is both `q1+60|sat` and `q1+12+60|sat`), so the regression also exercises the deduplication.

## §0.3 — FS-58's certificates still certify, and the checker can still refuse

```
python3 tools/fs61_census.py regress certificates      # 2.6 s; exit status read from the command, never through a pipe
```

Six witnesses, six `CERTIFIED`, exit 0 each: `d = 23` (475 points, 1,099 edges), `47` (169, 385), `71` (148, 346),
`95` (1,068, 3,096), `191` (483, 1,203) — the five the gate names — and `d = 11` (204, 455), added because it is the
field whose lower bound is in the Lean kernel and it costs nothing.

**Plant, because a checker that only ever says yes is not evidence:**

```
python3 tools/fs58_check_witness.py --radicand 59 data/fs58/witness-47/witness.json   # exit 1
REFUSED EDGE_NOT_UNIT: the file lists edge [0, 69] between [0, 0, 0, 0, 1] and [35, -1, -5, -7, 60],
which are not at distance 1
```

The same witness under the wrong radicand is refused, by name, with a non-zero exit — the same move gate C.3 will make
for every witness this milestone produces.

## §0.7 — resume: stop a scan mid-run and re-run the identical command

The resume command was written to a file **before the launch** (plan rule 1):

```
RESUME COMMAND: python3 tools/fs61_census.py scan 143 --tier 1 --jobs 16
State: data/fs61/fields/143/balls.jsonl, one JSON line per (lattice, radius), flushed and fsynced; a partial
trailing line is truncated on the next read.  A kill at any instant redoes at most the balls in flight.
```

The run was launched under `setsid`, its process group **found by the inode of the log file it holds open** (never by
matching a command line), and stopped by `kill -TERM -<pgid>` then `-KILL`, at the first moment a record existed.

```
GUARD before launch: records = 0 (must be 0), file exists: no
first record appeared at 14 records; stopping pgid 1404423 (found by log inode)
--- verify by effect ---
pid 1404423 absent from ps
left in group: 0
digest 793bda2d8654b758 then 793bda2d8654b758 -> STATIC          (ten seconds apart)
records after the stop: 18
```

Then the identical command, to completion:

```
  L54356af8 R=1.5 283485 points 1737874 edges -> Refused (solver claim) [115.95 s]
  L54356af8 R=1.8 587333 points 4478850 edges -> Refused (solver claim) [238.69 s]
  Le97d9d15 R=1.5 587341 points 1999514 edges -> Unknown (budget) [600.85 s]
DONE 3 Colourable (colouring verified), 2 Refused (solver claim), 1 Unknown (budget); 0 defects
[scan: 607.9 s wall]                                                                    exit=0

records after the kill: 18; after the resume: 24
duplicate keys in the final file: 0
finished records lost by the resume: 0
records present before AND after but not byte-identical: 0
```

All three pass conditions met. **A first attempt at this item failed its own arming guard and is recorded because the
guard is the point**: the waiter was armed on "at least three records" when eighteen already existed, so it fired
instantly and measured nothing. The condition is now evaluated and asserted false *before* the launch, which is what
caught it.

**Free findings.** The `d = 143` scan reproduces both of the plan's priced facts (O4) at once — the ball of radius 1.5
(283,485 points) and of radius 1.8 (587,333 points) on `L54356af8` both refuse — which is half of gate B.4, landed in
phase 0. And one 587,341-point ball ran to the 600-second wall and is recorded `Unknown (budget)`, never as anything
else: the plan's rule 4, exercised by an instance rather than asserted.

## §0.8 — FS-58 untouched

```
python3 tools/fs61_census.py regress untouched
git status --porcelain data/fs58 tools/fs58_*        # what it runs, verbatim
```

Run at the end of the phase, after every other item. FS-61 imports `fs58_search`, `fs58_local` and `fs58_chain` and
calls `tools/fs58_check_witness.py` as a subprocess; it edits none of them, and it never writes under `data/fs58/`,
because `fs58_search.outdir` is rebound to `data/fs61/fields/<d>/` at this module's import (see the plants below).

## Plants and controls — every one executed, and every one named with the clause it fired on

| # | plant | fired as | which clause |
|---|---|---|---|
| 1 | a non-saturated generating set (the raw `119 q1+60.1`, 20 vectors) | `saturated=False`, 8 missing generators named | `lattice_record`'s saturation assertion |
| 2 | one generator removed from the saturated set | `saturated=False`, `[[0, 0, 60, 0]]` named — and that vector shown to be a unit vector of the lattice | the same assertion, firing for *its* reason |
| 3 | a genuinely different lattice (one Hermite pivot doubled) | a different key, with a vector exhibited in one lattice and not the other | the canonical key |
| 4 | one generator dropped from an FS-58 record, in a scratch tree | `generator mismatches 1`, key sets unchanged | the regression's generator-sha comparison |
| 5 | one generator doubled in an FS-58 record | `generator mismatches 1`, key sets unchanged | the same |
| 6 | an FS-58 record cut to its rational generators (a smaller lattice) | `only-fs61 1, only-fs58 1`, generator shas unchanged | the regression's key-set comparison |
| 7 | a record claiming 3-integrality with its forms mod 3 removed | `3-integral (3 does not divide M=20) but no linear form mod 3` | `barrier_violation`'s barrier clause |
| 8 | a record whose `three_integral` flag disagrees with its own `M` | `claims three_integral=True while its own denominator is M=60` | `barrier_violation`'s consistency clause |
| 9 | the rebinding of FS-58's output directory applied *after* the import (the naive shape) | `forkserver -> data/fs58/search-11`, `spawn -> data/fs58/search-11` | the start-method trap |
| 10 | the rebinding removed altogether | the ball worker returns `ERROR: fs58_search.outdir is not bound into data/fs61 in this worker`, and the same ball with the binding returns `Colourable (colouring verified)` | the in-worker guard, two-sided |
| 11 | every covolume doubled in the point-count law | worst error 51.12 %, above the 15 % bound (against 2.24 % unplanted) | the bidisc prediction |
| 12 | a certified witness checked under the wrong radicand | `REFUSED EDGE_NOT_UNIT`, exit 1 | the frozen checker |

Plants 4, 5 and 6 exist as a set because each of the other two is silent where that one speaks: a single-generator
mutation never moves the key, and a changed lattice never shows up as a generator mismatch.

## §0.4 — the paired controls

```
python3 tools/fs61_census.py regress controls --jobs 16      # 2,559 s wall for the second half; resumable per field
```

The table is `data/fs61/controls.md`, regenerated from `data/fs61/regress/controls.jsonl` by that command. Summary:

| d | role | χ (prior art) | lattices (bipartite) | balls asked | Refused | verdicts |
|---|---|---|---|---|---|---|
| 2 | negative | 2 | 174 (174) | 348 | **0** | 125 Colourable (colouring verified), 218 Over cap, 5 Unknown (budget) |
| 5 | negative | 2 | 133 (133) | 266 | **0** | 91 / 169 / 6 |
| 7 | negative | 3 | 143 (32) | 286 | **0** | 111 / 171 / 4 |
| 13 | negative | 2 | 65 (65) | 130 | **0** | 47 / 80 / 3 |
| 19 | negative | 3 | 56 (25) | 112 | **0** | 52 / 59 / 1 |
| 31 | negative | 3 | 75 (18) | 150 | **0** | 72 / 76 / 2 |
| 43 | negative | 3 | 29 (10) | 58 | **0** | 27 / 27 / 4 |
| **47** | **positive** | ≥ 4 | 55 (8) | 110 | **3** | 47 / 59 / 1 |

All three pass conditions met: zero refusals on the seven; every lattice over `d = 2, 5, 13` bipartite (174 of 174,
133 of 133, 65 of 65 — §7's string for it is `Colourable (form mod 2)`); at least one refusal at `d = 47` on the
**identical** `--filter-off` command, so the path is shown able to go red.

**The population the zero is over is 550, not 1,350** (owner's correction, 2026-09-20; the per-field rows above and
`controls.md` were already right, the summary sentence was not). Of the seven negative fields' **1,350 ball records**,
**800 are `Over cap (not asked)`** — the lattice was too fine for the tier's 600,000-point cap and no graph was ever
built — 525 are verified colourable and 25 are `Unknown (budget)`. So **550 balls were asked and none refused.** Across
all eight fields: 1,460 records, 859 over cap, **601 asked** (572 verified colourable, 26 `Unknown`, 3 `Refused`). A number travels with what it measures, and "balls
recorded" is not "balls asked": at `d = 47` alone, 59 of 110 records are over cap.

**What `--filter-off` means here.** Every rank-4 lattice is considered at both tier-1 radii whatever certificate it
already carries — not merely the 3-non-integral ones FS-58's `colour-scan` selects — and is *asked* when its predicted
point count is under the tier's cap. 1,460 ball records over the eight fields, of which **601 were asked**.

**Finding — the three-chromatic controls are a theorem-backed null, not a budget null, and that both strengthens and
limits them.** Over `d = 7, 19, 31, 43` **no lattice is `Open`**: every one carries an exact certificate. The reason is
the plan's own prime-support law (D-H.2): 3 divides a class denominator only when `(d/3) = −1`, i.e. `d ≡ 2 (mod 3)`,
and these four fields are all `≡ 1 (mod 3)`, so no denominator is ever divisible by 3, every lattice is 3-integral, and
the kernel barrier (row 72) hands each one a linear form mod 3. Checked on every lattice built in this phase:

```
law D-H.2 on 1,091 lattices at twelve fields: 0 violations
```

and the converse holds exactly too — a lattice has a form mod 3 **iff** `3 ∤ M`, on all 1,091 (and on all 1,761 of
FS-58's rank-4 records). So the seven negatives are strong evidence that the instrument does not *invent* refusals, and
they say nothing about how it behaves on certificate-free lattices, because those fields have none. That is exactly
what the positive control at 47 — 29 `Open` lattices, three refusing balls — is for, and it is why the pairing is on
one command rather than two.

**Finding — `Unknown (budget)` carries no information about the graph, demonstrated on instances where a colouring is
certain.** Twenty-six of the 601 control balls asked ran the solver to its 600-second wall. Five of them are on `d = 2`
lattices that are **provably bipartite** — an exact linear form mod 2 two-colours the whole infinite lattice graph —
so a 3-colouring certainly exists and the solver did not find one:

```
  Lbcd39694 R=1.8 193233 points  470652 edges  bipartite=True  spec=q1+81
  Le2185b21 R=1.8 179653 points  451896 edges  bipartite=True  spec=q1+57.2
  Lb55fea91 R=1.8 428181 points 1041820 edges  bipartite=True  spec=q1+121
  Lad952572 R=1.8 510709 points 1245880 edges  bipartite=True  spec=q1+131
  L8b37408a R=1.8 547497 points 1389764 edges  bipartite=True  spec=q1+134
```

against a median colourable solve of **0.21 s** and one coloured ball of 557,065 points. The plan's rule 4 ("no
`Unknown` is ever read as a refusal or as anything else") therefore has five self-certifying instances in this phase,
not an argument. A cheap consequence for phase B is proposed below.

## Cost and machine

Everything on the desktop (16 physical cores / 32 threads, 128 GB), one heavy job at a time,
16 worker processes unless stated.

| step | wall | CPU | note |
|---|---|---|---|
| `regress lattices` (14 fields) | 6.6 s | — | odd girth not computed: this regression compares lattices and generators |
| `lattices 11 --tier 1` (70 lattices) | 115.4 s | **1,648 s** | with the tier's 400,000-point odd-girth search |
| `lattices 23 --tier 1` (94 lattices) | 103.0 s | **1,118 s** | as above |
| `regress refusals` (5 balls + 5 fields' lattices) | 299.2 s | — | |
| `regress certificates` (6 witnesses) | 2.6 s | — | |
| `scan 143 --tier 1` (gate 0.7, resumed) | 607.9 s | — | one ball at the 600 s wall |
| `regress controls` (8 fields, 1,460 balls) | 2,559 s + ~2,600 s lost | — | see the incident below |
| `selftest` (5 sections, 19 checks) | 1.1 s | — | |

**The one number phase B needs.** The tier's odd-girth search dominates `lattices`: **1,648 CPU-seconds for `d = 11`
against 1.8 seconds with it off**, roughly 900×, because the breadth-first search runs to 400,000 points on lattices of
up to 300 generators (the worst single lattice: 6.9 s). Across the census's 40 fields that is of the order of an hour of
wall time, which is affordable — and it buys the thing FS-58's records could not give: at the 20,000-point cap FS-58
used, 11's lattices report `odd: None` where at 400,000 they report an actual length (5, 7, 9, 11, 25), and O1's caveat
that `None` means only "none below the cap" is what makes R-cycle unscoreable on FS-58's own numbers. Twenty of 42
non-bipartite lattices at `d = 11` still return only a bound, now `none_up_to` between 9 and 25 instead of 3 and 15.

**One deviation from the tier's wording, in the direction of more information.** Decision B says the odd girth is
"exact to length 15 or a 400,000-point BFS cap, whichever first". FS-58's `odd_girth`, which this tool calls unchanged,
has only the point cap, so on a sparse lattice it can run past length 15 and report, say, `none_up_to: 25`. Every record
carries the search's own `bfs_cap`, `explored` and `levels`, so nothing is ambiguous; the recorded value is never less
than the tier promises.

## The incident: a `timeout` wrapper, and what the checkpoints saved

The first controls run was launched as `timeout 3000 python3 ... | tail -6 &`. That breaks two standing rules at once
(`CLAUDE.md`'s PROTECTED paragraph: **no `timeout` wrapper on a solve** — killing the wrapper kills the child; and: a
gate's exit status is never read through a pipe). The wall fired at fifty minutes and killed the run four fields in.

**Cost: nothing but time, because every unit was checkpointed.** The four finished fields' records were on disk, and the
per-ball records of the field in flight were too, so the relaunch redid only the balls that were in flight. The run was
relaunched under `setsid`, with no wrapper and no pipe, output to a file, its process group identified by the inode of
the log file it holds open, and it completed.

Two smaller defects found the same way and repaired:

* **Resume was per lattice where the unit of work is per class spec.** Re-running `lattices` rebuilt every combination
  whose lattice had first been recorded under a *different* spec — 40 % of them, at full cost. The tool now keeps a spec
  ledger (`lattices-specs.jsonl`) beside the lattice records. Measured after the fix: a second `lattices 119` run costs
  **0.0 s against 29.9 s**.
* **Finished fields were not being skipped** on a resume: the ledger is keyed by the record's own `d`, an integer, and
  the check compared it against a string. Caught twice. First in `regress controls`, within seconds of the relaunch,
  because the first field re-reported in 0.7 s instead of being skipped; the run was stopped, the comparison fixed, and
  the duplicate rows removed. Then **the same bug in the sibling `regress lattices`**, caught only by re-running every
  gate command once more at the end of the phase and reading the counts: it printed `14 fields` on the first run and
  `28 fields` on the second. Fixed, the file deduplicated, and every gate command now re-runs to a 0.0-second no-op:

```
  `selftest`              -> exit 0 | DONE selftest: 5 sections, 0 failures                  | 1.1 s
  `regress lattices`      -> exit 0 | DONE regress lattices: 14 fields, 0 failures           | 0.0 s
  `regress refusals`      -> exit 0 | DONE regress refusals: 5 balls, 0 failures             | 0.0 s
  `regress certificates`  -> exit 0 | DONE regress certificates: 6 witnesses, 0 failures     | 0.0 s
  `regress controls`      -> exit 0 | DONE regress controls: 8 fields, 0 failures            | 0.0 s
  `regress untouched`     -> exit 0 | DONE regress untouched: PASS                           | 0.0 s
```

  The cheap habit that found it: **re-run every gate command after the phase and read the counts, not the exit status**
  — both runs exited 0, and only the number moved.

## What I would change in the plan, and what phase B should inherit

1. **Gate 0.5's plant cannot work as written** (§0.5 above). The canonical key is a function of the lattice, and these
   generating sets are negation-closed, so no single-generator corruption can move it. Three plants replace it, one per
   clause. *Proposed change to §6: state 0.5's plant as "a corrupted generator set must move `generators_sha256` while
   leaving the key fixed, and a genuinely different lattice must move the key".*
2. **The odd-girth cost belongs in decision B's tuple** as a measured number, not only a cap: ~1,650 CPU-seconds for the
   largest field. Nothing needs changing; the tier is affordable. But `lattices` now takes `--no-girth`, and the
   regression uses it, so the phase-0 gate does not pay for a column it does not compare.
3. **A lattice with a form mod 2 or mod 3 should have its ball colourings *constructed* from the form rather than
   searched.** Five provably bipartite balls burned 600 seconds each in the controls. The colouring is `form(x) mod p`,
   exact, instant, and verifiable on every edge by the same code that verifies a solver's model. This changes nothing
   about the census's conclusions — phase B's filter closes those lattices before any ball is asked — but it would make
   any future `--filter-off` control run in minutes instead of 43. *Proposed as a phase-B improvement, not made here,
   because the controls' value is partly that they exercise the SAT path.*
4. **The negative controls cannot test the `Open` population** (§0.4), for the arithmetic reason that `d ≡ 1 (mod 3)`
   fields have no 3-non-integral lattice at all. Worth saying in §6's 0.4 row so that a future reader does not read the
   seven zeros as stronger than they are.

## Verdict

**8 of 8 gate items green**, each backed by a row above with its command, artifact and output line. Twelve planted
faults, every one executed and every one fired on its named clause. `data/fs58/` and `tools/fs58_*.py` are unmodified.
