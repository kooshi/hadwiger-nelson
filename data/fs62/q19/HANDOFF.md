# q = 19 — state at 2026-09-19, and what to do next

*Everything below is on disk; nothing depends on a live session.*

## The question

Is there an independent set of **78** points in `UD(𝔽₁₉,2)`? A refutation gives `α(19) ≤ 77`, hence
`c(19) = α/q^{3/2} ≤ 0.930`, under the 0.933 that G59's uniform-bound reading needs. **Still open.**

Standing: `76 ≤ α(19) ≤ 99` proven (ratio bound), `≤ 80.59` as an uncertified relaxation reading.

## What was done on 2026-09-19

Both of the previous handoff's queued items, and a measurement neither of them expected.

1. **The centroid normalisation is implemented** (`tools/fs65_indep_sat.py --break centroid`, now the
   default), with the retraction it corrects written into the file's own docstring. Controls:
   `--selftest` runs the modular-sum encoding against brute force on every assignment of a small
   instance, then `q = 11, k = 28` (must be SAT) and `k = 29` (must be UNSAT). All pass.
2. **The line case split is resumable** (`tools/fs65_lines.py --state DIR`), and it now has an
   end-to-end control it never had: at `q = 11`, where `α = 28` is known exactly, `k = 29` refutes in
   all 10 cases and `k = 28` comes back satisfiable in 2 — so the exhaustiveness argument is checked
   against a known answer in both directions.
3. **And the centroid break is SLOWER than the origin pin it replaces** — by an order of magnitude.
   See the table below. This does not undo the retraction (the origin pin really is worth 4.63 and
   not 361) but it inverts the recommendation that followed from it.

## NEXT ACTION

**Not more SAT.** Three encodings have now been measured on this graph and the best of them cannot
decide `k = 120`, let alone 78 (`data/fs62/q19/README.md` § The symmetry breaks measured). The
remaining live routes, in order:

1. **The 574 fixed-cardinality moment equations** for the level-3 relaxation — `Σ_{v ∉ T ∪ N(T)}
   y_{T∪{v}} = (78 − |T|)·y_T` for every independent `T` with `|T| ≤ 3`. The orbit counts are
   1, 1, 17, 555 = 574, matching the level-3 variable set, so **no new moment variables are needed**.
   This was the external review's own first recommendation and it is still untried. Feasibility-control
   it with the known 76-point construction before believing any bound it produces.
2. **Round the 80.59 into an exact rational certificate**, which would make `α(19) ≤ 80` proven and
   is the same instrument FS-50 and FS-54 already own.
3. **D2/D4 of the stub** — a MIP with published symmetry handling, or orbital branching. The SAT
   measurements are now the case *for* these rather than a reason to keep tuning the encoding.

## The symmetry breaks, measured

Three sound normalisations of the 361 translations, one thing differing between them:

| break | keeps per translation orbit | `q=11, k=29` (UNSAT, α = 28) |
|---|---|---|
| `none` | 361 | 286.6 s, 320.4 s |
| `origin` — pin `x₀ = 1` | 78 of 361 (**4.63**) | **22.4 s, 22.5 s** |
| `centroid` — `Σa·x ≡ Σb·x ≡ 0` | 1 of 361 (**361**) | 238.0 s, 244.5 s |
| `lex` — `x ≤ t(x)` for all 360 `t` | 1 of 361 (**361**) | see README |

**The origin pin's power was never its symmetry reduction.** It puts 13 unit clauses into the
instance — the origin true and its 12 neighbours false — and that propagation is worth more to CDCL
than a 78× larger quotient. The centroid equations fix no variable at all and are modular sums, which
is the constraint family CDCL is worst at. So the correct reading is that **both** of the earlier
claims were wrong in opposite directions: the symmetry accounting was off by 78, and the fix for it
costs more than it buys.

## What has been tried, and the verdict on each

| route | verdict |
|---|---|
| local search for 78 (24 threads, 1 h, 521,874 restarts) | not found; a null at a budget |
| KaMIS branch-and-reduce / struction | **failed** — 70 and 66, below what local search finds in seconds |
| level-3 relaxation | 80.59, a float reading, **not a certificate** |
| SAT, origin pin, single solver (1 h) | undecided |
| SAT, origin pin, cube-and-conquer | split rate diverges; **the conclusion drawn from it is retracted** |
| SAT, centroid or lex break | slower than the origin pin (above) |
| SAT + line case split (`tools/fs65_lines.py`) | **9 of 204 cases refuted**, the rest undecided |
| **how far SAT gets at all** | `k = 130` refutes in 16 s, `k = 150` in 3 s, and **`k ≤ 120` does not refute in 900 s** — the frontier is ~50 above the answer |

## The line case split — now resumable

`tools/fs65_lines.py --state data/fs62/q19/lines` reads the 149 records already there, skips what is
decided, and writes each new case atomically as it lands, so a kill costs one case per worker.

    # what is left, and the tally
    python3 tools/fs65_lines.py --q 19 --k 78 --state data/fs62/q19/lines --status
    # run it, 26 at a time, no xargs and no queue file
    python3 -u tools/fs65_lines.py --q 19 --k 78 --state data/fs62/q19/lines \
        --timeout <CAP> --jobs 26 --scratch /tmp/fs65q

**An UNKNOWN is credited with the time it actually SPENT, never the cap it was launched with** — a
case whose solver was killed lands as UNKNOWN too, and crediting it with a nominal cap would drop it
silently out of every future queue while nothing had decided it. So a re-run at the same cap does
nothing and a re-run at a higher cap redoes exactly the undecided ones. **Choose the cap deliberately:
a timed-out case keeps no solver state, so raising the cap redoes it from zero, and that cost has been
paid twice here already** (600 s and 5,400 s).

**Why it stalled:** the refutation rate collapses as the anchor line empties — 1 of 1 at `r = 9`,
5 of 10 at `r = 8`, 3 of 38 at `r = 7`, **0 of 76 at `r = 6`**, and `r = 5` (79 cases) barely touched.
Fixing `r` points also excludes their neighbours, so a fuller anchor line pins far more of the graph.
The 155 cases at `r = 5, 6` are the bulk and are out of reach at this cap. **A proof needs all 204, so
partial progress is worth nothing on its own.**

## The 76-point set, in closed form

`S = {(x,y) : y − x ∈ {0,3,8,11}}` — four parallel lines in direction `(1,1)`. Independent because a
unit distance needs `(2t+d)² = 2 − d²`, and the offset differences `d ∈ {0,±3,±5,±8}` give
`2 − d² ∈ {2,12,15,14}`, **all non-residues mod 19**. It meets every one of the 190 unit-direction
lines in **exactly 4** points. `(1,1)` is not a unit direction (`1/2 = 10` is not a square). Verified
here; the set we had found by search has the same maximum occupancy. This came from an external review —
we built the object months ago and never asked what it was.
