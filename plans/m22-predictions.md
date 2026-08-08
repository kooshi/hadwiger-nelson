# M22 §0 predictions — registered before instrument code exists

*Written 2026-08-08, desktop, immediately after the M22 go and before any §0 script.
The M21 discipline: every measurement below is predicted first; refuted predictions are
reported as refuted. Instruments: A = kill-structure census (`m22kills.py`, scratch),
B = near-relation spectrum (`m22near.py`), C = partner-closure spike (`m22partner.py`).
Data already in hand: the 229 ambient-kill pattern pairs in
`build/m21-joint-695-2044.json` (committed by the M21 close), re-runnable at median
0.37 s per SAT call.*

## A — the kill-structure census (fresh 1500-pair frame + the 229 committed kills)

* **A1 (rigidity gradient).** Ambient kills concentrate where the local escape count
  is already low: the median number of locally-valid palette injections among
  ambient-KILLED instances is at most HALF the median among ambient-SAT instances.
  Mechanism: fewer palette escapes = less slack for the ambient graph to absorb.
  Confidence medium.
* **A2 (the inner circle carries the mechanism).** Relaxing the π_b partition
  constraint on the INNER-circle members of S_b alone (outer pins kept) revives at
  least 50% of ambient kills. Mechanism: M20's cap runs through the inner rainbow
  triangles (the compulsion), so the pair pressure should too. Confidence low-medium —
  the honest alternative is that the outer hexagon alternation carries it; refutation
  is as informative as confirmation. Registered branch either way: whichever circle
  family revives kills names the clamp family for gadget design.
* **A3 (kills have small cores).** Greedy pin-deletion on the π_a side (unpin one
  S_a member at a time, keep only deletions that preserve UNSAT) terminates with at
  most 8 of 21 pins still active, for at least 75% of a 60-kill subsample. Mechanism:
  forcing structures are gadget-sized, not diffuse. Confidence medium.
* **A4 (local kills are single-bottleneck).** Among local-conflict instances in the
  fresh frame, at least 80% fail through a single starved class (one π_b class whose
  allowed set is smaller than its need), not through multi-class parity. Confidence
  medium-high.

## B — the near-relation spectrum (exact angles, mpmath 60 digits)

* **B1 (the ladder almost closes, canonically).** At the canonical d = 1 pair the
  pure ladder spectrum — minimize |l·θ_σ + k·60°| mod 360° with θ_σ = arctan(√11) —
  reaches discrepancy < 0.1° within |l| ≤ 60, at an l appearing among the
  continued-fraction denominators of θ_σ/60°, with the usual exponential thinning of
  best discrepancies. Confidence high (number theory, not colouring).
* **B2 (the closure pairs are NOT near-misses).** At the four M21 phase-probe pairs,
  no (m, l, k) with |m|, |l| ≤ 12, k < 6 comes within 1° of closing — the exact
  search's emptiness is robust, not a threshold artifact. Confidence medium.
  If REFUTED: that pair becomes the first partner-adjunction target (an almost-cycle
  at closure scale).
* **B3 (near-cycles name short chords).** The best |l| ≤ 60 canonical near-relation
  corresponds to an adjunction point at distance < 0.002 from an existing lattice
  point (2·sin(δ/2)·radius at δ < 0.1°) — the discrepancy IS a short new chord, the
  concrete aiming quantity for entanglement. Confidence high given B1.

## C — the partner-closure spike (representation cost decides the instrument shape)

* **C1 (the fork stays closed at depth 1).** The depth-1 partner closure of the
  d = 1 lattice (adjoin every unit-partner of every lattice point on the four
  circles) stays SAT at k = 4. Confidence LOW-MEDIUM — this is the milestone's first
  live-fork measurement, exactly as M21's D1 was. Registered branch: UNSAT ⇒ stop
  everything, re-verify exactly, shrink, kernel route (a two-point continuum χ ≥ 5
  candidate).
* **C2 (exact arithmetic is the bottleneck, and triage must be float).** Symbolic
  exact unit-distance tests between partners of different quadratic extensions
  (sympy, minimal-polynomial route) cost at least 100× the 80-digit mpmath float
  test; a fully exact closure beyond ~10³ points is not affordable in-session.
  Decision this registers: if confirmed, the promoted instrument is float-triage with
  exact confirmation ONLY for the edges of any claimed witness (the M21 "float
  prefilter, exact confirm" rule, applied per-claim instead of per-edge).
  Confidence medium-high.
* **C3 (the field really grows).** At least 90% of depth-1 partner points have
  intersection discriminant that is NOT a square in ℚ(√3,√11) — quantifying the M21
  caveat that move-closed ≠ partner-closed. Confidence medium.
* **C4 (collisions exist).** After dedupe, depth-1 closure multiplies the point count
  by at most 3× (raw partner generation is 4–8×; the near-cycle structure predicts
  some partners land ON existing lattice points). Confidence low — exploratory; a
  measured collision census is itself an aiming signal (collisions = exact cycles).

## Registered decision criteria

| Outcome | Consequence |
|---|---|
| C1 refuted (UNSAT) | Drop all other threads; verify → shrink → kernel route |
| C2 confirmed | Promoted instrument = float triage + exact-on-demand |
| B2 refuted at some pair | That pair jumps the aiming queue for adjunction |
| A2 confirmed | M22 report names inner-circle clamps as the gadget family |
| A2 refuted (outer revives) | Outer-alternation clamps named instead — same instrument, opposite target |
