# STUB — the point across: two rich points on one unit circle whose colours together are all six

> **FS-136 (numbered 2026-10-07 by Keryx). Opened 2026-10-07**: its inventory is `plans/FS136-close-inventory.md`, its claim list `data/fs136/claims.md`; in the claim list and everywhere after it the first claims' names read C136- where this stub's question section writes C-.

*Minted 2026-10-07 by FS124-P3 (`plans/POROS-2026-10-07-fs124-round2.md`), the asking lane, after FS-124's second round. Its
number is the coordinator's to give. **Not started.** It is FS-124's successor: FS-124 (`plans/STUB-q-ring.md`) answered what a
tight unit pair passes on and what a close complementary pair costs; its eight cases, listed there (ll. 17–55), are open and
pass here, at the unit they were minted at. Nothing in this stub is derived: every statement is held at the address given,
read from a held object by a named script, or posed, and says which.*

## The mission, in plain language

The plane needs six or seven colours so that no two points at distance exactly 1 share one (`[OAIMath2026]`; in this library
on one declared outside theorem). It needs seven exactly when some disc has no *weak six-colouring* — a measurable map to six
labels giving almost no two points at distance 1 the same label — and six exactly when every disc has one (C124-RADIUS,
`plans/FS124-E1-derivation.md`; [hand], one mind, in the kernel lane). So a six-coloured piece of the plane that can be grown
forever decides the problem one way, and one disc that cannot be six-coloured decides it the other.

Three six-coloured pieces are held, each exact: a strip from print (`[AxenovichEtAl2014]`), a disk from print
(`[Polymath2021]`, Gibbs's), and a flower about a point where all six colours meet (FS116-Y2-SIXFRAG). Each has points where
four or more colours meet. Measured from such a point, the strip reaches `φ²/√2 ≈ 1.8512`, the disk `φ ≈ 1.618`, and the
flower's straight-sector family dies at `√3` (`LEDGER.md` rows 138, 136, 148). **Read today: the three stopping points are
one kind of point.** Take the point `p` where the colours meet, and two further points `x`, `y` on the unit circle about `p`
at which three or more colours meet and whose colours together are all six. There are exactly two points one unit from both
`x` and `y`: `p` itself, and the point across, `p′ = x + y − p`, at distance `2 cos(θ/2)` from `p` when `x` and `y` subtend
the angle `θ` at `p`. On the strip the nearest such `p′` with no colouring is at `φ²/√2` exactly; on the disk at `φ`; on the
flower at `√3 e(60j)`, where the two ring points are four-colour points and no "close complementary pair" in FS-124's sense
exists (`plans/POROS-2026-10-07-fs124-round2.md` § 1.3, S1: the strip and the disk are FS112-STOP's, held, two minds; the
flower is read from FS116-Y2-SIXOFF's words and one reader's output, one mind).

Why `p′` is where six colours run out, in one line: a connected open region of one colour that has a point nearer than 1 to
a point `z` and a point farther than 1 has a point at distance exactly 1, so its colour is barred at `z`
(C124-SHADOW-OPEN; C124-TYPE is its form for a region touching the unit circle about `z` at one point: barred on one side).
At `p′` each colour of `x` and each colour of `y` is barred on one side of a unit circle or on both; with all six colours
spoken for by `x` and `y`, a colour is left only where a region of `x` or of `y` lies wholly inside, or wholly outside, the
unit disc about `p′` (C124-FORCED-PIECES for two triples, `plans/FS124-E2-derivation.md`; derived, one mind). At seven
colours the seventh fills `p′` and nothing is forced.

## Definitions, stated once

`c` is a weak six-colouring of an open set `U`. A **piece** is a connected open subset of `U` almost every point of which has
one label. A **pieced point** is a point `x` of `U` with a neighbourhood that is, up to a null set, the union of finitely many
disjoint pieces, each with `x` in its closure; its **labels** are its pieces' labels (a three-piece point of FS-124 is one with
three pieces and three labels). For `|w − x| = 1` a piece of `x` is **inner at `w`** if it lies in the closed unit disc about
`w`, **outer at `w`** if it misses the open one, **crossing** otherwise; `x` **separates at `w`** if it has an inner and an
outer piece there (`plans/FS124-E2-derivation.md` § Notation). A **covering pair** is two pieced points `x`, `y` with
`0 < |x − y| < 2` such that each of the six labels is a label of `x` or of `y`. Its **common unit points** are the two points
one unit from both. For a point `p`, a covering pair **on the ring of `p`** is one with `|x − p| = |y − p| = 1`; `p` is then
one common unit point and **the point across** is the other.

## The question (Poros, 2026-10-07)

### The card

question: is-the-point-across-forced-empty
  evidence: `data/fs124/p3/pairs_read.out` — strip "unsaved-point-at-distance={0.5: 1, 1.0: 2, 1.851: 34}", "pairs-per-point={2: 1, 5: 1, 8: 8}";
    disk "unsaved-point-at-distance={1.618: 10, 1.764: 8, 1.765: 2}"; `plans/FS116-derivation.md` l. 395, FS116-Y2-SIXOFF: "the lenses'
    corners e(60j ± 30°) and far vertices √3 e(60j)"; `data/fs124/e2/out/sixfrag.txt`: "labels-at-centre=0135", "0124",
    "close-complementary-pairs=0", "of-kind-both=18 edge-of-a-save=0"; `LEDGER.md` row 138 "every disc of radius below `φ²/√2`",
    row 136 "no vertex-centred disc beyond `φ`", row 137 "negative only at a degree-4 four-colour vertex with three or four such edges"
  expected: that the boundary on a unit circle has one cause, the rescue of two three-label points, and that six is spent there
  ask: About a point of four or more labels, must some two pieced points of its unit circle whose labels together are all six have a second common unit point, within 2, that no weak six-colouring can contain?
  if always: an explicit radius, at most 2, about every point of four or more labels whose ring points are pieced — for maps, with FS114-CV-EXISTS,
    the six-map NO for the ring types covered; in measure, seven given a pieced seed (FS-127's)
  if some ring has every such point filled, by formula: the first six-coloured fragment past `φ`, `φ²/√2` and `√3` about its centre, a design to
    grow by C124-RADIUS's clause, and the rule it met is the YES side's
  if it turns on the ring's type: FS-124's eight cases are re-indexed by the pair that stops each, and each case is a finite exact computation
    of C124-EDGE-CLOSED's kind — the disk's rim and the flower's far vertices first
  answered by: derivation — Ephodos, the opening job and first round, on the first claims below
  cost: one reading round on the held rings with members of four and more labels; then four claims of a stage or less each
  hunch: it turns on the ring's type — the three held stops are one kind of point reached by two different kills, a count at the strip and a
    second-order horn at the flower (always 0.08; a ring by formula 0.12; by type 0.8)
  falsifier: a held object whose stop about a point of four or more labels is not the second common unit point of two pieced ring points whose
    labels are all six — FS114-Y2-BOWTIE's fragment is unread; or a derivation of the first branch
  rank: 1

### Existence form

Is there a weak six-colouring of an open set containing the closed disc of radius 2 about a pieced point `p` with four or more
labels? At radius 2 the point across of every covering pair on the ring of `p` lies inside, so each must be coloured. Held,
each a map: every disc of radius below `φ²/√2` about a four-colour vertex of the capped strip (row 138); `φ` about a corner of
the disk (row 136); every radius below `3/2` about the six-colour vertex of FS116-Y2-SIXFRAG, whose straight-sector family
dies at `√3` (row 148); the Searcher's kept model, seven flowers of radius about `0.25` with nothing between them, whose
covering pairs inside the unit disc all have their point across on the ring (`data/fs124/p3/pairs_read.out`, "kept"; row 160).
Nothing past `φ²/√2`. The large form is FS-124's and stands: weak six-colourings of discs of every radius are `χ(ℝ²) = 6`.

### Structural form

In **every** weak six-colouring of an open set, for every point `p` and all the pieced points of the unit circle about `p`
that lie in the set: which pairs of them are covering pairs; at the point across of each, which member separates, by which
pieces, and which labels are present there; and what must the whole family of covering pairs on one ring satisfy for every
one of its points across within the set to be coloured? The question is about every solution, in the widest class where a
pieced point makes sense (it is asked at every number of labels, and six enters where "all the labels" is used), and it
cannot be answered without naming what a ring carries: the candidate is the **covering graph** of the ring — its pieced
points with their labels and, at `p`, the side of each piece — together with, for each member, the finitely many points at
which it can separate through two pieces that share an edge (for a sector point at most three: FS112-C-PARTNERS for maps)
and the sets of directions in which it separates through two pieces that do not. It is not the existence form reworded: that
asks for one coloured disc; this asks what every ring's covering pairs obey, and its answer either forces an uncoloured point
across within 2 or is the rule a construction must meet. **Not asked here, and to be said in every claim**: that a weak
six-colouring has a pieced point, or one with four labels — the first is FS-127's, the second FS-122's and, for maps, held
(FS114-CV-EXISTS).

### What each answer gives

| answer | toward six | toward seven |
|---|---|---|
| the count for a covering pair holds (C-COVER below) | what every construction must supply at each point across: an inner and an outer region of one member | the count at any two rich points, not only two triples; fails at seven |
| the nearest uncoloured point across is the radius each held object attains | the three held stops are one obstruction, and a design past them is one that fills that point | the stop law of row 136 for every held ring, with the six-colour vertex in it |
| the point across is excluded on the disk's and the flower's rings by the first-order lemma | the same objects, stopped for every weak six-colouring that keeps named regions — not only as maps | the first exclusions in measure at four-label and six-label points |
| a ring by formula with every point across within 2 coloured | the first fragment past print; with growth at every radius, six | G83's killing test fires; the exclusion at radius 2 is false for that type |
| some ring type forces an uncoloured point across within 2 | that type is removed from every design | an explicit radius for that type — with FS114-CV-EXISTS, part of the six-map NO; with a pieced seed, part of seven |

### The first claims a deriver takes

*Order: as listed. Kinds: **reading**; **spends six** (holds at six, fails at seven, the witness named); **per class**. Each
names the held entry it would restate — searched for in `LEDGER.md` rows 135–138 and 145–150 and the derivation files they
name before it was posed. Entry names are placeholders until the milestone has its number.*

- **C-RINGS-READ (a reading; first).** On every held six-coloured object — FS-112's strip and disk, FS-114's capped strip
  and its bowtie fragment FS114-Y2-BOWTIE, FS116-Y2-SIXFRAG, fragments T2, S1, MX, BB, the Searcher's kept model — at every
  point of four or more labels: the pieced points of three or more labels on its unit circle; the covering pairs among them;
  for each, whether the point across is inside the object; if it is, who separates there and the labels present; if not, its
  distance from the centre. *Statement to verify*: on each object and at each such centre, the least distance of a point
  across not inside the object equals the radius the object attains about that centre (strip and capped strip `φ²/√2`; disk
  `φ`; the flower's family `√3`). *Controls*: R7 has no covering pair (six labels of seven at each lattice point); the plant
  moves one ring point by `0.01`. *Restates*: FS112-STOP for the strip and the disk (two minds); for members of four labels
  nothing found. *Needs*: `data/fs124/e2/saves_read.py`'s member test widened from three labels to three or more (a new
  reader, not an edit of that job's tool).
- **C-COVER (spends six).** *Let `c` be a weak six-colouring of `U`, `(x, y)` a covering pair of pieced points and `w` a
  common unit point of the pair lying in `U`. Then `x` or `y` separates at `w`.* *Smallest form*: the argument of
  C124-FORCED-PIECES, which reads "every label is the label of a piece of `x` or of `y`" and nowhere "two disjoint triples".
  *Controls*: tight on SIXFRAG's six adjacent ring pairs at the six-colour vertex; **fails at seven** on R7 at two adjacent
  lattice points. *Restates*: C124-FORCED-PIECES's own argument at the class it reads (G92); for maps FS112-N3-COR3 is the
  case of two cubic trichromatic vertices; no held entry found for a member of four labels.
- **C-ONE (spends six).** *A pieced point `p` carrying all six labels separates at every point `w` of its unit circle in
  `U`, and near `w` almost every point inside the unit circle about `p` has the label of a piece of `p` inner at `w`, almost
  every point outside the label of one outer at `w`.* *Control*: SIXFRAG's twelve arcs about its vertex; fails at seven on
  R7's lattice points. *Restates*: FS116-N2-SIXRING ("the ring lies in Γ … every ring arc is a (Q) arc"; one mind,
  non-Siamese) — here with no Siamese clause and no map.
- **C-PARTNERS (spends six).** *A sector point `x` has at most three points `w` such that an edge of `x` begins with an arc
  of the unit circle about `w`; every close complementary sector partner `y` of `x` both of whose common unit points lie in
  `U` is `w_i + w_j − x` for two of them; so `x` has at most three such partners.* *Controls*: the kept model's centre
  (three, attained); the strip, where no three-label point has more than three partners and 34 of 54 pairs have a common unit
  point outside (`pairs_read.out`). *Restates*: FS112-C-PARTNERS (one mind) and FS114-Y-PAIRSHARE (two minds) — carried by
  C124-BOTH at both points and C124-SECOND's "two distinct circles share at most two points".
- **C-STOP (spends six; the card's claim on held rings).** For the nearest point across `p′` on the disk (a rim point) and
  on the flower (`√3 e(60j)`): no weak six-colouring of an open set containing `p′` keeps the named regions at `p`, `x` and
  `y`. *Smallest form*: C124-EDGE-CLOSED's method — six uses of C124-TYPE and exact comparisons. *Controls*: the strip's
  `(1/4, √15/4 + √3/2)` must reproduce C124-EDGE-CLOSED; the plant moves `p′` by `1/50`. *Restates*: FS114-Y-PENT and
  FS112-DISK-RIM for the disk, FS116-Y2-SIXOFF for the flower — whose Step 3 is "second order along the lens boundary", so
  whether the first-order lemma reaches the flower's far vertex is this claim's content.

### Registered expectations (Poros, 2026-10-07, before any derivation of these)

C-RINGS-READ's statement holds on the strip, the disk and the flower 0.85; on FS114-Y2-BOWTIE 0.5. C-COVER derived as posed
0.9. C-ONE 0.9. C-PARTNERS 0.9. C-STOP: the disk's rim by the first-order lemma 0.7; the flower's far vertex by the
first-order lemma alone 0.35. The card: always 0.08; a ring by formula 0.12; by type 0.8. An exclusion at an explicit radius
for every pieced ring of a named type, within this milestone: 0.1. A six-coloured fragment past `φ²/√2` about a point of four
or more labels, by formula or search: 0.1. Six against seven decided here: 0.03.

## Bearing on the answer

It is the local half of both roads, at the one unit a six-coloured map is known to have. **Toward seven**: an uncoloured point
across forced within 2 of every pieced point of four or more labels is, for maps, the explicit radius row 137 says suffices
(FS114-CV-EXISTS supplies the point; FS-123's Siamese class and the map step stand beside it), and in measure it is seven
only with a statement that every weak six-colouring has such a point with pieced ring points (FS-127; C132-LONG's stall).
**Toward six**: a ring whose every point across within 2 is coloured is the first fragment past the three radii print and
this project reach, and the screen it passed is what a construction at every radius must meet. Alone it delivers neither
value. What it is not: a statement that a weak six-colouring has a piece. Nothing held gives one.

## Failure clauses

- If C-RINGS-READ finds a held stop that is not a point across (FS114-Y2-BOWTIE first), the card's evidence is three objects'
  and the unit is re-posed from the fourth; say so in the headline.
- If C-STOP's flower needs second order, the first-order lemma has a named limit and the milestone's product is that limit —
  which kills read the unit circle to first order and which do not.
- Every exclusion states its class in its headline: which regions are kept, and that no weak six-colouring is known to have
  them (G21).

## Deliverables

The reading's table for every held ring; the entries above at their verdicts; if a ring by formula appears, its exact check
by a second script and an explorable picture of it (the ring, its covering pairs, each point across with its barred sides).

## Provisional bearings

G83 (the question lives at one four-colour vertex: this stub returns to that unit, reading its ring by the pieced points on
it); G91 (the ring is the pigeonhole: a covering pair is two of its pieced points, the point across where their bars meet);
G92 (C124-FORCED-PIECES's argument reads "all six labels are spoken for", not "two triples"); G97 (its killing test fired at
FS-124's second round: the first-order lemma excludes configurations with a unit arc — an amendment is drafted in
`plans/POROS-2026-10-07-fs124-round2.md` Stage 4); G86 (no count over tiles: the count here is over sides of finitely many
regions at one point); G21 (three held stops, one kind of point: a pattern on objects built to reach far, not a law); G96
(every hypothesis here is ball data at `p`, `x`, `y`; the conclusion is at a fourth point on their unit circles). Rows 135–138
(the rhombus, the stop, the count's room, the kills), 147–148 (the placing rule; the six-colour vertex), 157. Entries
C124-TYPE, C124-FORCED-PIECES, C124-LONE, C124-BOTH, C124-FOUR, C124-SECOND, C124-EDGE-CLOSED (`plans/FS124-E2-derivation.md`);
FS112-C-PARTNERS, FS112-STOP (`plans/FS112-derivation.md`); FS114-Y-PAIRSHARE, -Y-STRIPK6, -Y-PENT (`plans/FS114-derivation.md`);
FS116-Y2-SIXOFF, -N2-SIXRING, -N3-SEMI (`plans/FS116-derivation.md`). Stubs FS-124 (the predecessor, whose eight cases pass
here), FS-127 (the seed), FS-122 (the forced pair), FS-117 (the count, and its untried torus design meeting the pair screens).

*From FS-124's theorem record (FS124-Z1, the record job, 2026-10-07; every entry named is in `plans/FS124-derivation.md`, [hand] or derived from [hand] entries, **one mind, kernel pending**). None says that a weak
six-colouring has a piece, a three-piece point or a close complementary pair:*

- **The tool every first claim here would use: C124-TYPE** ([hand] over C124-SHADOW-OPEN; § 2) — every weak `k`-colouring of an
  open set, one connected open one-label piece with a point of its closure one unit from `w`; it reads no number of labels. In
  the kernel lane's second module, being planned blind.
- **The count, as an entry, is for three-piece points with disjoint triples: C124-FORCED-PIECES** (derived from C124-TYPE; § 3).
  That its argument reads "every label is a label of a piece at one of the two points" is the asking lane's reading of the
  argument, not an entry: for members of four labels or more the count is to be derived here, not cited.
- **What is held at the pair, each for its class**: C124-FORCED (sector points: an arc of an edge on the point's unit circle;
  one topological input recalled, not read); C124-LONE (three-piece points by the letter: what a save by one member forces),
  with its object C124-LONE-EXISTS (one held family: fragment S1 with a band, a three-piece point by the letter only);
  C124-BOTH (full members: both separate; sector points: no save by one member alone); C124-FOUR (full members with one piece
  of each side: exactly four labels at the point); C124-SECOND (sector points, both common unit points in the set, pattern
  (1, 1): different edges, two labels in common, a cyclic order of the six). **C124-BOTH, C124-FOUR and C124-SECOND rest on
  C124-LONE, on whose Step II its deriver asks for a second mind**; cite them outside FS-124 with that said.
- **The method for a stop: C124-EDGE-CLOSED** ([hand], exact comparisons; § 4) — one held family: no weak six-colouring keeps
  six named pieces of FS-112's strip at their labels and contains the point `(1/4, √15/4 + √3/2)`. It uses C124-TYPE six times
  and no entry of § 3. The held map statement about the strip's six tiles is FS114-Y-STRIPK6 (row 138; two minds, blind);
  neither statement is the other. The disk's rim and the flower's far vertex by this method are not run.
- **Calibrations at seven** (§ 6): C124-FORCED-SEVEN (the count fails on the honeycomb at circumradius 2/5, exact) and
  C124-KIND (a tight pair with neither label present at its centre).
- **The reading** C124-READ-SAVES ([tools], one mind; § 7): the three maps read whole are of pattern (1, 1) at every common unit
  point inside; FS116-Y2-SIXFRAG has eighteen tight arcs of kind both and no close complementary pair.
- **The consumer of either answer: the radius clause** (§ 1). Weak measurable six-colourings of the open discs of every radius
  give `χ(ℝ²) ≤ 6` (C124-RADIUS-UP; no import); a disc with none gives seven only over the declared outside theorem
  `Outside.OAI158.proper_to_borel_weak` (C124-RADIUS-DOWN). Its module is complete on branch `fs124-wk1` — kernel-checked on a
  branch, not through the gate, not held.
- **Not held, that a claim here might assume** (that file's § 8): a piece in any weak six-colouring; anything for a member of
  four or more labels; whether a three-tile vertex of an arc map with a cusp is a sector point.
