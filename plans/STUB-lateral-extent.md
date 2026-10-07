# FS-127 — lateral extent: is the singular set of every honest saturated colouring of the plane locally finite? (stub)

> Re-aimed 2026-10-07 (FS132-P1): at local finiteness of the *cyclic centres* of an honest saturated colouring (the reading's [L₆]) — no arcs, no integer radii — the statement `[OAIMath2026]`'s extraction consumes; and behind FS-132's card 2, which asks whether the extraction needs even that.

*Minted 2026-10-03 by FS-121's close (FS121-Z1, stage 5), carrying inventory item 67 (LAT's card for Poros) and item 74's owed minds. Route M's honest
branch; siblings FS-126 and FS-128; FS-120's pinch lies on its path. **Solver column: in-ban** — derivation, constructions by formula with exact
checks. Read first: `plans/FS121-derivation.md` round 4; `plans/FS121-D4-proof.md` §§ 1.2, 3.1.*

## The question, in plain language

In an honest saturated colouring (no REG-J′ assumed), can infinitely many singular points, or infinitely many boundary arcs, crowd into a bounded set?
FS121-D4 found that every shape of crowding it examined is an accumulation of same-colour pieces, and that the plane's unit circle, through its
curvature, forbids two of them facing each other across a small gap with enough lateral room (FS121-D4-FACE, held): a flat side of colour `c` facing
another `c`-piece of half-width `ρ` across a gap `g` with `2g < ρ²` loses its contact, so `c` has density 1 there. **LAT:** at every accumulation point
some colour has two pieces in that position. LAT with FACE gives the claim.

## What FS-121 established

- C121-REGJ holds on every honest saturated grid colouring with countable breakpoints, every `k` (FS121-D4-GRID, held with item 73's caveat); for an
  uncountable breakpoint set the breakpoint clause is false (FS121-V5-GRID-CANTOR, one mind) and the Σ clause open.
- The line analogue is false with two colours (FS121-D4-LINE): the dimension is spent here. Regions can be as small as wished at sixteen colours
  (FS121-D4-TINY16, exact): no count per region bounds Σ. A region with a hole has a singular shore (FS121-D4-HOLE).
- FACE's margin is sharp at `ρ² ≥ 2g − g²` (FS121-V5-FACE-SHARP, one mind).
- A measurable fall colouring with a non-locally-finite Σ refutes the claim (FS121-D4-FALL): FS-120's Cantor pinch, if it sits in a fall colouring, is a
  counterexample.

## The open case (LAT's card, for Poros)

Point-like accumulation: same-colour pieces of diameter `r_n` at mutual gaps `g_n ≫ r_n²` accumulating at a point, the sea between them cut into
several regions. *Existence form:* an honest saturated colouring at some `k ≥ 7`, by formula, with such an accumulation. *Structural form, a
suggestion:* what does every accumulation of pieces carry at distance exactly 1 — the one scale where the obstruction lives (D4 § 3.1, attempt 2)?

## Bearing on the answer

**None alone; a colour-generic rung.** REG-J′ is one of the honest route's three conditions for the map step at six (FS111-M2-REDUCE-A); a YES at any
`k ≥ 7` (a wild Σ) would show the honest route needs regularity it cannot get colour-blind; a NO is a rung, true or false about real objects at seven.

## Owed second minds

FS121-D4-HOLE, -LINE, -TINY16, -FALL; FS121-V5-FACE-SHARP, -GRID-CANTOR, -PAIR.

## Registered expectations (provisional)

- LAT decided at one mind within the milestone: 0.25. A wild-Σ saturated colouring by formula, if decided: 0.4.

## Failure clauses

- A derivation of REG-J′ may not rest on C121-ENDS, -OUT, -PER or -LRA-LINE, which assume it (`data/fs121/claims.md` § 4).
- A count per region is not a bound (FS121-D4-TINY16).

## Provisional bearings

G84, G85; the drafted G90 (lateral extent against gap); G54 (fall colourings); G21. Stubs: FS-120 (the pinch), FS-126, FS-128.

Since FS131-E8 (`plans/FS131-E8-derivation.md`; [hand], one mind, kernel pending): in a saturated colouring a locally finite Σ gives a fan with end
tangents at each of its points and finitely many interface arcs in every bounded set (FS131-E8-BRIDGE, -CLAUSE2), so C121-REGJ is its first clause —
the question is the singular points alone, and infinitely many boundary arcs in a bounded set are a wild Σ, never a second kind of crowding.
