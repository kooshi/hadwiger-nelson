# FS-61 phase B — the census scan, tier 1, all forty fields: the phase record

*Plan: `plans/FS61-quadratic-census.md` §6 phase B, §5 rule 16. Implementer: de Bruijn (Opus 5), 2026-09-20.
Machine: **the desktop, 16 physical cores / 32 threads, 128 GB**, idle, one heavy job at a time,
16 workers. Timings are wall seconds on that machine.*

## The launch — written before the run started (plan §5 rules 1 and 3)

```
COMMAND     python3 tools/fs61_census.py census --jobs 16 --budget 7200
RESUME      the identical command.  Finished fields are read back from data/fs61/census-progress.jsonl and
            skipped; inside a field, every lattice, every certificate and every ball is its own JSONL record,
            so a kill at any instant redoes at most the units in flight.
STATE       data/fs61/census-progress.jsonl        one line per finished field
            data/fs61/fields/<d>/lattices.jsonl    one line per distinct lattice
            data/fs61/fields/<d>/poset.jsonl       the inclusion pairs (derived, rewritten each run)
            data/fs61/fields/<d>/filter.jsonl      one line per lattice state
            data/fs61/fields/<d>/balls.jsonl       one line per (lattice, radius)
LAUNCHED    setsid, no `timeout` wrapper, no pipe; stdout to a file; the process group found by the inode of
            the log file it holds open, never by matching a command line.
PGID        1579088   (found by the inode of /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/logs/census.log; stop with `kill -TERM -1579088`, verify by effect)
STOP RULE   two hours per field (--budget 7200), then the remainder is left UNRECORDED rather than written as
            `Over cap (not asked)`, so that `table --check` reports it as "Open with no R=1.5 record" and a
            reader sees a gap instead of a verdict.  That is a deliberate departure from the plan's wording,
            in the direction of visibility.
```

## The order of work, per field

`lattices` → `filter` → `scan`, which is the plan's order and its reasons:

* **certificates top-down.** A 3-colouring of a lattice's graph restricts to every sublattice, so colourability is
  inherited *downward* along the inclusion poset. The finest lattices are certified first (form mod 2, then form mod 3,
  then up to 24 verified periodic quotient colourings) and everything under a colourable one is closed without being
  asked.
* **balls bottom-up**, in ascending predicted points: `R = 1.5` for every `Open` lattice under the tier's 600,000-point
  cap — the census's comparable column — then `R = 1.8` only for those colourable at 1.5, then the onset radii 1.2 and
  1.0 only for lattices that refused, at a 120-second wall because the band just under the threshold stalls (O3, O4).
* **refusal upward.** A refusing ball closes every lattice above it, recorded as `Refused (inherited from <id>)` with
  the key it came from — except where the lattice above already carries a colourability certificate, which is left
  alone for B.1b to name rather than papered over.

*(results below, filled as fields complete)*

---

## The gate

| # | item | command (pasteable) | artifact | the line that shows the pass | exit |
|---|---|---|---|---|---|
| B.1 | completeness | `python3 tools/fs61_census.py table --check` | `data/fs61/census.md`, `census.jsonl` | `DONE table --check: 40 fields, 0 defects` | 0 |
| B.1b | the two monotonicity controls | the same command | the same | included in the 0 defects; both clauses shown to fire below | 0 |
| B.2 | every `Colourable` verdict verified | `python3 tools/fs61_census.py scan <d> --reverify` over the 40 fields | `data/fs61/fields/<d>/models/` | **18 stored colourings re-checked on the full exact edge set, 0 failures** | 0 |
| B.3 | every `Colourable` lattice carries its certificate | `python3 tools/fs61_census.py filter <d> --reverify` over the 40 fields | `data/fs61/fields/<d>/filter.jsonl`, `quotients/` | **655 certificates re-checked against the full generator set, 0 failures** | 0 |
| B.4 | the priced facts reproduce | in `data/fs61/fields/{119,143}/balls.jsonl` | those files | `d=119 R=1.5 13605 points -> Refused`; `d=143 R=1.5 283485 points -> Refused` | 0 |
| B.5 | budget honesty | `table` | `census.md` | the per-field **balls asked / over cap / unknown** column, and the totals line | 0 |
| B.6 | the table regenerates | `table` twice | `census.{md,jsonl}` | byte-identical on a second run: **PASS** | 0 |
| B.7 | machine and cost | this record | — | below | — |

**40 fields, 1.01 h, 0 defects, nothing halted.**

## What the census found

**898 lattices over the forty fields**, by state: 209 colourable by a form mod 2, 268 by a form mod 3, **268 by a
verified periodic quotient colouring**, 43 refused, **110 still open**. The quotient certificate is doing a third of
the work; without it those 268 lattices would all have been balls to ask.

**Nine fields have a refusing ball at tier 1:**

| d | mod 8 | L | N₁ | N₃ | lattices (C2/C3/Cq/O/R) | smallest refusing ball | bracket |
|---|---|---|---|---|---|---|---|
| **11** | **3** | 4 | 6 | 6 | 70 (28/17/19/2/4) | 45,521 pts | – … 1.0 |
| 23 | 7 | 4 | 8 | 12 | 94 (20/35/12/21/6) | 248,213 | 1.8 … 1.3 |
| 47 | 7 | 5 | 12 | 12 | 55 (8/18/0/24/5) | **3,565** | 1.8 … 1.2 |
| 71 | 7 | 4 | 12 | 12 | 50 (11/17/14/1/7) | 47,597 | 1.0 … 1.2 |
| 95 | 7 | 4 | 12 | 12 | 41 (10/11/14/0/6) | 6,997 | 1.0 … 1.2 |
| 119 | 7 | 4 | 12 | 12 | 54 (9/15/22/1/7) | 5,605 | 1.0 … 1.2 |
| 143 | 7 | 5 | 12 | 12 | 24 (7/5/0/11/1) | 283,485 | 1.8 … 1.5 |
| 191 | 7 | 4 | 20 | 48 | 28 (3/11/10/0/4) | 21,845 | – … 1.2 |
| **359** | 7 | **4** | 36 | 36 | 12 (2/4/2/1/3) | 46,421 | – … 1.2 |

**`d = 359` is new** — not among FS-58's six, not priced in phase 0. Its local bound is **4**, so if phase C certifies
it, `χ(ℚ(√359)²) = 4` is a new exact value. (Everything in this table is a *solver claim* until the frozen checker
says otherwise; the `evidence` column of `census.md` says so field by field.)

The onset radii also **shrank two known refusals**: `d = 47`'s smallest refusing ball is now **3,565 points** against
FS-58's 8,629, and `d = 95`'s is 6,997 against 17,169 — cheaper starting points for phase C's extraction.

## The two registered predictions this phase scores — both lost, and the second for an instructive reason

**P2 — "tier 1 yields no refusing ball at any of the twenty `d ≡ 3 (mod 8)` fields (inherited refusals over 11
excluded)": LOST.** `d = 11` produced **four genuine ball refusals**, all on one lattice,
`q1+q5+6+10.1+10.2+15.1+15.2+30.1+30.2+30.3` (`M = 30`, 108 generators, covolume 2.17e-4), down to radius **1.0**
(45,521 points, 376,224 edges). These are ball refusals, not inheritance: the lattice is **not** FS-58's witness
lattice (that one has `M = 150`, and `150 ∤ 30`, so it cannot even be contained in this one).

Checked before believing it, because a refusal that arrives in 0.09 s on a 10-million-edge instance deserves it:

```
  generators failing a^2+c^2+11(b^2+e^2)=M^2: 0        (exact integer test, all 108)
  generators not in the lattice: 0
  triangles through the origin: 0                      (G57 predicts 0: sqrt3 is not in Q(sqrt11))
  400 sampled edges re-derived from the definition: 400/400 exact unit distances in Q(sqrt11)
```

So the graph is a genuine induced piece of the plane over `ℚ(√11)`, and **triangle-free**, like FS-58's 204-point
witness. **The direct route does land at a `d ≡ 3 (mod 8)` field.** What survives of R-mod8 is its refinement rather
than its claim: the refusing lattice draws on **ten classes** (`q1, q5, 6, 10.1, 10.2, 15.1, 15.2, 30.1, 30.2, 30.3`),
exactly the plan's own note that "whatever refuses over `d ≡ 3 (mod 8)` is rich in classes, not coarse".

**P3 — "among the twenty `d ≡ 7 (mod 8)` fields, tier 1 yields a `Refused` ball at ten or more": LOST**, 8 of 20.

**And the reason both nulls must be read carefully is the column B.5 now carries.** Of the twenty `d ≡ 3 (mod 8)`
fields, **eighteen asked ZERO balls** — every lattice was either certified colourable or over the tier's point cap, so
nothing was ever put to a solver:

```
d = 3 (mod 8): 20 fields,   6 balls asked, 38 over cap; 18 fields asked ZERO balls
               [35, 59, 83, 107, 131, 179, 203, 227, 251, 299, 323, 347, 371, 395, 419, 443, 467, 491]
d = 7 (mod 8): 20 fields, 118 balls asked, 181 over cap;  6 fields asked ZERO balls
               [167, 239, 383, 407, 455, 479]
```

Only **two** `d ≡ 3 (mod 8)` fields asked anything at all: `d = 11` (4 asked, 4 refused) and `d = 155` (2 asked, 2
colourable). **So P2's null was tested at two fields of twenty, and lost at one of them.** Over the whole family the
census asked **124 balls** against 343 records — 219 were over cap and 20 ran to the wall. `d = 167` asked **zero**.

That is the honest shape of "Not landed at tier 1" for 31 of the 40 fields: overwhelmingly *nothing was askable at
this depth*, not *asked and colourable*.

## Cost, and the projection reconciled against it

| | |
|---|---|
| total | **1.01 h** wall, 40 fields, 16 workers |
| mean, `d ≡ 3 (mod 8)` | **22 s** per field |
| mean, `d ≡ 7 (mod 8)` | **159 s** per field |
| slowest | 95 (575 s), 119 (534 s), 23 (508 s), 359 (474 s), 71 (455 s) |

The running projection moved 2.3 h → 2.6 h → 1.6 h → 1.3 h → 1.0 h. **The drift is the mod-8 split, not noise**: the
family alternates between an expensive half and a cheap one, and the first six fields (11, 23, 35, 47, 59, 71) contain
four of the expensive kind, so the early mean was biased high by about 2.3×. Predicted-beside-measured caught this as
soon as the second projection moved the wrong way; the population, not the rate, was what changed.

## Plants and controls

| plant | fired as | which clause |
|---|---|---|
| declare a superlattice of a refusing lattice `Colourable (form mod 3)` in a scratch copy of `d = 71` | `DEFECT monotone d=71: L3e1c94c6 Refused inside Lc223387a Colourable (form mod 3) … HALT, plan rule 15` — and it named all four such pairs | B.1b's inclusion clause |
| record a `Colourable` ball at `R = 1.8` above a refusal at `R = 1.5` | `DEFECT monotone d=71: L9a15a47c colourable at R=1.8 above a refusal at R=1.5 … HALT` | B.1b's radius clause |
| (standing, re-run green) the barrier clause of `barrier_violation` on every lattice of every field | 0 violations over all 898 | B.1b's third clause |

## A deliberate departure from the plan's wording

The two-hour stop rule leaves a field's remaining balls **unrecorded** rather than writing them as
`Over cap (not asked)`. A reader then sees `table --check` report "Open with no R=1.5 record" — a gap — instead of a
verdict the instrument did not earn. No field reached the budget in this phase, so nothing was affected.
