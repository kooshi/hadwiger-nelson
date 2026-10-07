# FS-127 — lateral extent: is the singular set of every honest saturated colouring of the plane locally finite? (stub)

> **Re-aimed, 2026-10-07 (FS132-P2, FS124-P1): it carries the existence of a point with usable data — C132-WIT-EX's form (O), C132-RING-TAME's first clause, the REG-J′ side question — for all weak colourings or for honest ones (row 143). Ranked by bearing, 6 → 3; left unopened by Kooshi's word of 2026-10-07.**

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

*Since FS-132 (FS132-Z2, 2026-10-07) — this stub now carries the existence question FS-132 gave up.* By Kooshi's word of
2026-10-07 (`data/external/EXT-OAI1-request.md` § Kooshi's sixth word: "I agree with all 3", the first of the three being that
FS-132 "stop asking whether readable meeting points must exist and deliver 'what any such point's circle forces'"; the
coordinator's reading there: the question "stays with FS-127 and FS-128"; `plans/FS132-close-inventory.md` items 23 (b), 24,
32 (a)), **whether every weak measurable six-colouring has a point with usable data on its unit circle is no longer FS-132's
question.** What FS-132 derived of it (`plans/FS132-derivation.md` §§ 2, 3, 8; each [hand] or derived from [hand] entries, one mind, kernel pending):

- **Centres exist with no hypothesis**: every closed disc of radius above 1 holds a cyclic centre, at every number of colours
  (C132-CORES-FREE). A square form, side above 1, is posed by the kernel planner and entered as a gap (C132-CORES-SQUARE).
- **Data at a centre, under a hypothesis nobody supplies at six**: on a closed disc of radius above 1 with finitely many cyclic
  centres, one centre carries a label cycle with continua, limiting directions and the two-label exclusions (C132-EXT-DISC).
  What its argument reads of the hypothesis is zero length of the centres and **isolation of the one essential centre**; at the
  island colouring's accumulation centre the conclusion with its clause (4) is false, and true at the isolated ones (control
  `hex7-islands`).
- **Where isolation is read**: not in the exclusion's proof — that runs from any connected subset of one smoothed class's
  superlevel set, "no hole, no exceptional set, no centre, no isolation, one label at a time" (C132-WIT-SUPER) — but in the
  step before it, the selection of a point through which connected pieces of two smoothed classes pass and reach a common
  second point. Existence with no hypothesis on the centres stalls there (C132-WIT-EX). Its smallest open form (O), verbatim:
  "a weak colouring and a disc of radius above 1 in which, at every point, the graph of witnessed label pairs is a forest".
- **Data are free where there is a margin, and do not locate a centre** (C132-WIT-MARGIN): labels whose supports keep off an
  annulus about a point's unit circle are witnessed there by every nearby point. So the question is real only for colourings
  with no margin. FS132-E5's question for this stub: do this project's tight seven-colourings have a disc with no margin for
  any three labels at any point?
- **Two inclusions, not one place** (the asking lane; `plans/FS132-close-inventory.md` item 21): a point's *transition graph*
  is a property of every small ball about it, its *witness graph* a property of its unit circle. FS-132's exclusions read the
  second; no entry derives circle data at a point from its small balls.

The asking lane's re-aim of this stub — honest colourings; "an essential centre is isolated and the centres have zero length"
(`plans/POROS-2026-10-07-fs132-night.md` § The ranked table, rank 4, and § Banners) — is drafted, not filed. Of FS132-E1's two
proposals: the extraction for countable closed sets of centres was declined as a stub by the asking lane (the same record,
§ The debts); its side question — under REG-J′, are a saturated colouring's cyclic centres locally finite, "a candidate,
unchecked" — was not started, and belongs beside FS131-E8's line above. Grokkings: G94; proposed G96.

*Since FS-124 (FS124-Z1, the record job, 2026-10-07; every entry named is in `plans/FS124-derivation.md`, [hand] or derived from [hand] entries, **one mind, kernel pending**):* every entry of that file's §§ 2–4 that is not an
object begins from an open one-label set (C124-SHADOW-OPEN) or a connected one (C124-TYPE), and no entry gives a weak
six-colouring either. So what this stub's regularity would supply to that file is the piece, and no more is asked of it: with
three pieces at each of two points less than 2 apart carrying all six labels, C124-FORCED-PIECES applies as it stands; an arc on
the circle needs sector points (C124-FORCED), and "both members" full ones (C124-BOTH).

*Since FS-136 (FS136-Z1, the record job, 2026-10-07; every entry named is in `plans/FS136-derivation.md`, [hand], derived from [hand] entries or computed exactly over named corners, **one mind each, kernel pending**; each is about weak colourings that already have the named regions or corners, and none is known to):* every entry of that file begins from pieces or
labelled corners at named points, and none gives a weak six-colouring one. Two bear on what this stub would have to
supply. **C136-FORCED** gives a piece at a new point from pieces at old ones, and what it gives is a germ — its *not
claimed* line: "a lower bound for η (it is half the least witness depth of the bars used, and shrinks at every step)";
chained (**C136-CLOSE**), "no region of definite size is forced". So a radius for a forced corner is this stub's ground —
"a piece of definite size" (the second deriver's sweep, `plans/FS136-E2-derivation.md` § 7.4) — and nothing in FS-136
supplies it. **C136-COLLAR** forces a region with a definite length and no definite width, and only from a point that
already carries five of the six labels. **This stub's question was not re-posed by FS-136**: the first round's closing
sentence, which pointed back here ("which pieces at the members must reach across its unit circle?"), is withdrawn by a
dated erratum under it — a held stop is excluded by the corner patterns at its two members alone (**C136-STOP-GERMS**).
