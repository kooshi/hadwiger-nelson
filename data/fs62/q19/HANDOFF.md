# q = 19 — state at 2026-09-19, and what to do next

*Written at a context compaction. Everything below is on disk; nothing depends on a live session.*

## The question

Is there an independent set of **78** points in `UD(𝔽₁₉,2)`? A refutation gives `α(19) ≤ 77`, hence
`c(19) = α/q^{3/2} ≤ 0.930`, under the 0.933 that G59's uniform-bound reading needs. **Still open.**

Standing: `76 ≤ α(19) ≤ 99` proven (ratio bound), `≤ 80.59` as an uncertified relaxation reading.

## NEXT ACTION — the centroid normalisation (not yet implemented)

**This is the top of the queue and the reason the case split was stopped.**

`tools/fs65_indep_sat.py` pins the origin into the set. That is sound but **worth only 4.63, not 361**:
a 78-set has trivial translation stabiliser (19 ∤ 78), so its orbit has 361 members, of which **78**
contain the origin. With the 40-map lex break the total reduction was ~185, not 14,440 — **a factor of
78 of the symmetry was never broken**, which is why the earlier conclusion ("the hardness is in the
instance, not the encoding") is **retracted and must not be repeated**.

The exact fix: the centroid `c(S) = 78⁻¹ Σ v = 10 Σ v` over `𝔽₁₉²` satisfies `c(S+t) = c(S)+t`, so
exactly one translate has `c = 0`. Impose

    Σ a·x_{a,b} ≡ 0 (mod 19)    and    Σ b·x_{a,b} ≡ 0 (mod 19)

and exactly one representative per translation orbit survives — the full 361. The 40 orthogonal maps
fix the condition, so the lex break still composes with it.

**To implement:** two modular counters over 361 variables in `fs65_indep_sat.py`, replacing the
`cnf.add(X[0])` origin pin (a residue-state sequential encoding, 19 states × 361 positions per
equation, ~14k auxiliary variables for the pair). **Control it at `q = 11` first**, where the value is
known exactly: `k = 28` must be SAT and `k = 29` UNSAT. Note `11^... ` — at `q = 11` the target size
must also be coprime to 11 for the stabiliser argument, so check that before reusing the control.

## What has been tried, and the verdict on each

| route | verdict |
|---|---|
| local search for 78 (24 threads, 1 h, 521,874 restarts) | not found; a null at a budget |
| KaMIS branch-and-reduce / struction | **failed** — 70 and 66, below what local search finds in seconds |
| level-3 relaxation | 80.59, a float reading, **not a certificate** |
| SAT + lex break, single solver (1 h) | undecided |
| SAT + lex break, cube-and-conquer | split rate diverges (23 % → 49 % → 62 %); **conclusion retracted, see above** |
| SAT + line case split (`tools/fs65_lines.py`) | **9 of 204 cases refuted**, 96 undecided at a 5,400 s cap |

## The line case split — resumable, and why it stalled

`data/fs62/q19/lines/DECIDED.json` holds the 9 refuted cases; `RESUME-QUEUE.txt` holds the 195 that
remain, one `r case` pair per line, hardest-first. Resume with:

    xargs -P 26 -n 2 bash -c 'python3 -u tools/fs65_lines.py --q 19 --k 78 --r $0 --case $1 \
      --timeout <CAP> --scratch /tmp/fs65q --out data/fs62/q19/lines/r$0-c$1.json' \
      < data/fs62/q19/lines/RESUME-QUEUE.txt

**The driver has no built-in resume** — it would redo every case unless fed the queue file above. Fix
that before any further run rather than relying on memory.

**Why it stalled:** the refutation rate collapses as the fullest line empties — 100 % at `r = 9`
(1/1), 50 % at `r = 8`, 8 % at `r = 7`, **0 % of 56 attempted at `r = 6`**, and `r = 5` (79 cases)
never reached. Fixing `r` points also excludes their neighbours, so high `r` determines far more of the
graph. The 155 cases at `r = 5, 6` are the bulk and are out of reach at this cap. **A proof needs all
204, so partial progress is worth nothing on its own.**

**A timed-out case is not resumable** — the solver keeps no state, so a higher cap redoes it from zero.
That cost has now been paid twice, at 600 s and at 5,400 s.

## Also untried: the reviewer's 574 moment equations

For the level-3 relaxation, impose `Σ_{v ∉ T ∪ N(T)} y_{T∪{v}} = (78 − |T|)·y_T` for every independent
`T` with `|T| ≤ 3`. The orbit counts are 1, 1, 17, 555 = **574**, matching the level-3 variable set, so
**no new moment variables are needed**. Their own first recommendation; feasibility-control it with the
known 76-point construction.

## The 76-point set, in closed form

`S = {(x,y) : y − x ∈ {0,3,8,11}}` — four parallel lines in direction `(1,1)`. Independent because a
unit distance needs `(2t+d)² = 2 − d²`, and the offset differences `d ∈ {0,±3,±5,±8}` give
`2 − d² ∈ {2,12,15,14}`, **all non-residues mod 19**. It meets every one of the 190 unit-direction
lines in **exactly 4** points. `(1,1)` is not a unit direction (`1/2 = 10` is not a square). Verified
here; the set we had found by search has the same maximum occupancy. This came from an external review —
we built the object months ago and never asked what it was.
