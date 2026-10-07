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

*Correction, dated 2026-10-07 (16:48 UTC; filed by the coordinator; source: FS136-E1's record, `plans/FS136-E1-derivation.md` § 2.2 item 4, with its control `rings-r7`, re-run by the coordinator): the control at seven as worded above is wrong. In the deriver's words: "Adjacent lattice points lack *different* labels, so two of them carry all seven: 54 pairs in the window read, at 96 common unit points inside, every one with a full table and no violation. The count is not special to six: it holds at any number of labels when the pair's labels are all the labels … What fails at seven is a pair that covers six of seven (C124-FORCED-SEVEN)." The control that passes: the tight seven-colouring's covering pairs obey the table.*

*Checked, dated 2026-10-07 (FS136-P1, the asking lane): the correction above says what this lane would say. One line added from this lane's reading (`data/fs136/p1/germs_read.out`, floats): at each of R7's 96 points every member bars exactly one label, and it is the label the point lacks ("1:192", "192 of 192") — six labels at the point and one spent on its ring; a pair that covers six of seven leaves the seventh free everywhere, which is why the count fails there.*

*Correction, dated 2026-10-07 (FS136-P1, the asking lane; source: FS136-E1's plan, `plans/FS136-the-point-across.md` §PA item 1, and its record § 6.3 item 2): C-COVER's "Restates" line above — "no held entry found for a member of four labels" — is wrong. Held for maps since 2026-09-27: the union definition of a covering pair (`data/fs110/claims.md` l. 327), FS110-CALC's A-EXACT and A-SIX (three minds), FS110-N-SEAM (a)–(b) (two minds, one blind), and N-E2 (`plans/FS110-N-proof.md` l. 96) — members of any number of colours, families of any size. The search that missed them read rows 135–138 and 145–150 and the files they name; rows 133–134 hold FS-110. C-STOP's "Restates" line also stops short: FS114-Y3-RSTOP (two minds) holds the bowtie fragment's stop, and FS114-Y-PENT and FS114-Y3-RSTOP are statements about germs ("near").*

### Registered expectations (Poros, 2026-10-07, before any derivation of these)

C-RINGS-READ's statement holds on the strip, the disk and the flower 0.85; on FS114-Y2-BOWTIE 0.5. C-COVER derived as posed
0.9. C-ONE 0.9. C-PARTNERS 0.9. C-STOP: the disk's rim by the first-order lemma 0.7; the flower's far vertex by the
first-order lemma alone 0.35. The card: always 0.08; a ring by formula 0.12; by type 0.8. An exclusion at an explicit radius
for every pieced ring of a named type, within this milestone: 0.1. A six-coloured fragment past `φ²/√2` about a point of four
or more labels, by formula or search: 0.1. Six against seven decided here: 0.03.

## The question, second round (Poros, 2026-10-07, after FS136-E1)

*Written by FS136-P1 (`plans/POROS-2026-10-07-fs136-round1.md`, Stages 1–3) after the first round's ten entries. The section
above stands as the card the first round answered. **The unit changes**: not the ring of a point of four or more labels
(read by nothing at the point across: FS136-E1 § 2.2 item 5), and not "the point across" either — it is a **seed**, a finite
family of pieces at finitely many points, and what the table forces from it. A covering pair is the smallest seed whose
table can empty a cell or fill one. **Nothing here says a weak six-colouring has a piece.***

### The card

question: how-far-does-a-seed-force
  evidence: `data/fs136/p1/germs_read.out` — "singleton cells per coloured point … 0:12 1:6 2:12 3:6 4:6" (flower), "0:71 3:34" and
    "420 of 420" (strip), "384 of 384" (R7): at 142 of 257 coloured common unit points read, some cell has exactly one unbarred label;
    `plans/FS124-derivation.md` l. 427, C124-FOUR *not claimed*: "or that each region carries one label"; `plans/FS136-E1-derivation.md`
    l. 322, C136-ONE *not claimed*: "that one label fills a side"; and "still with an empty cell by germs: … rho=0.0125" at 70 of 70 stops
  expected: that the table only empties cells — every entry of two milestones reads pieces at all its named points and concludes an
    exclusion, and "none gives a colouring a piece" (`CLAUDE.md` item 31)
  ask: Run forward, with a cell of one unbarred label a piece and that piece a member at the next point, how far do the pieces at one covering pair force a weak six-colouring: to an empty cell, a free cell, or a whole ring?
  if an empty cell is reached from the pair alone: that pair is excluded on a disc about it — an exclusion whose hypothesis is two pieced
    points, not the tiles of a held object at every named point; for maps a pair of vertex figures struck from every design; for seven a
    smaller seed to ask the existence stubs for
  if the closure stalls at free cells: those cells are where six has room — each a finite choice among two or more labels; the forced part
    is a derivation's, the choices are the Searcher's (queue line 15 re-posed on the closure), and a stall with two labels in a cell goes to
    the transfer of rows 155 and 159
  if the closure closes round a ring with no cell empty and none free: a six-coloured fragment by formula that nothing but its seed chose —
    its exact check by a second script and a picture, then growth; past `φ²/√2` it is the first fragment past print
  answered by: derivation — Ephodos, a second round of FS-136 on the first claims below
  cost: one stage for the forward statement and its controls; one exact computation per seed, by forced steps only (a branch is a search
    request, never taken in the derivation lane)
  hunch: it stalls at free cells within two steps on every held six-coloured seed (stall 0.65; an empty cell from a pair alone, beyond the
    pair's own two common unit points, 0.25; closes round a ring 0.10)
  falsifier: the closure of the strip's pair, or of the flower's pair at `e(180°)`, `e(270°)`, running three steps or more — or a derivation
    that the forward statement is false as posed
  rank: 1

### Existence form

Is there a finite seed — finitely many points of an open set, each with a finite family of pieces — in some weak six-colouring,
whose forced closure fills a neighbourhood of every point of the closed disc of radius 2 about one of its points, with no cell
empty and none free? Such a closure is a six-coloured fragment given by formula from its seed alone. Held: none; on the held
objects the closure has been read one step only, from pairs (`data/fs136/p1/germs_read.out`).

### Structural form

In **every** weak `k`-colouring of an open set and for **every** finite family of pieces in it: at each point `w` of the set,
and each cell cut near `w` by the unit circles about the pieced points one unit from `w`, the labels present in the cell are
among those the pieces leave unbarred (C136-TABLE); where exactly one is left the cell is a piece (C-FORCED below), which is
then a member for every point one unit from `w`. So the colouring contains the **forced closure** of each of its finite
families — the least family closed under that step. What is the closure of a seed: where does it reach an empty cell (the seed
is excluded there), where does it leave two or more labels (and what do those cells obey — on the strip and on R7 the pair's
table is exact at every cell, 420 of 420 and 384 of 384), and can it close up? It is asked at every number of labels and for
every seed, and it cannot be answered without the invariant every colouring carries: its own closure under the table. It is
not the existence form reworded: that asks for one seed whose closure is a disc; this asks what every colouring obeys around
every family of pieces it has.

*For a stranger, with the field named*: finitely many labelled connected open sets; a label is allowed at a point when the
unit circle about the point meets none of its sets; where one label is allowed on an open set, that set joins the family;
iterate. This is **constraint propagation** — the fixpoint of a monotone step, unique and independent of the order of the
steps; a conflict at the fixpoint is a refutation with no branching, and a stall is where branching begins. The lanes divide
on that line: forced steps are exact arithmetic (a derivation); a branch is a search.

### What each answer gives

| answer | toward six | toward seven |
|---|---|---|
| the forward statement holds (C-FORCED) | every construction's forced moves are computed, not chosen; a unit arc at a point where one member alone pays is forced, not designed | the table gives pieces at new points from pieces at old ones — the first statement of either milestone that puts a region where none was kept |
| a seed's closure reaches an empty cell beyond the pair's own common unit points | that pair of vertex figures is removed from every design | an exclusion on a disc about a two-point seed; with a statement that every weak six-colouring has such a seed (FS-127, FS-128, FS-135), seven; alone, nothing |
| the closure stalls | the list of free cells is the whole design space near the seed — the Searcher's family, in place of wedges | where it stalls with two labels in a cell, the transfer of rows 155 and 159 has its hypotheses supplied by pieces |
| a closure closes round a ring | a fragment by formula past print; with growth at every radius, six | G83's killing test fires for that seed |
| on R7 at seven the closure reproduces R7 near the seed | — | tightness at seven is rigid from two points: the control every six-coloured closure is compared with |

### The first claims a deriver takes

*Order: as listed. Each says whether it **reads regions somebody keeps** or **forces a region**. Each names the held entry it
would restate, searched for by file in `plans/FS107-`, `FS110-`, `FS112-`, `FS114-`, `FS116-` and `FS124-derivation.md`
(terms: "fills", "is a piece", "forced piece", "singleton", "only one label", "exactly one label"; entries on reciprocity,
cones, seams, germs read at their statements). Controls: what was run is `data/fs136/p1/germs_read.py` (floats, one mind,
this lane's reader over the deriver's loaders) unless said.*

- **C-FORCED (forces a region; first).** *Let `c` be a weak `k`-colouring of `U`, `w` a point of `U`, `x_1, …, x_m` distinct
  points with `|x_i − w| = 1`, `𝒫_i` a family of pieces at `x_i`, and for each `i` a side of `S(x_i)`, such that the cell `C` of
  points on those sides meets every ball about `w` in a non-empty open set. Suppose every label but one, `ℓ`, is a label of
  some `𝒫_i` at which it is not pure at `w` on the chosen side (not inner-pure for the inside, not outer-pure for the
  outside). Then there is `η > 0` such that almost every point of `C ∩ B(w, η)` has the label `ℓ`. If two such cells lie on
  the two sides of one `S(x_i)` and on the same sides of the others, with labels `ℓ ≠ ℓ′`, then near `w` almost every point on
  one side of that arc of `S(x_i)` has the label `ℓ` and almost every point on the other `ℓ′`.* *Smallest form*: `m = 1`, a
  family carrying all the labels with exactly one inner-pure label at `w` (C136-ONE with its pure labels counted).
  *Controls, on objects with no margin*: the flower at `w = (−1, −1)`, `x = e(180°)`, `y = e(270°)` — C136-COVER's own model:
  cells "in/in=0 in/out=1 out/in=0 out/out=1", labels present "01" (`data/fs136/e1/out/sixfrag.txt`); the strip's 34
  three-label coloured points, three such cells each; **at seven, R7** — one or two such cells at each of its 96 points, and
  at every cell the labels present are exactly the unbarred ones (384 of 384): the tight seven-colouring survives, the label
  the statement forces being the label it has there. The deriver's plant: bar one more label in a cell that holds it; the
  samples must then violate. *Restates*: for maps nothing to state (a map has tiles at `w`; FS110-N-SEAM (b) puts each on one
  side). In measure not found in the six files; **declined twice** — C124-FOUR's *not claimed* ("or that each region carries
  one label") and C136-ONE's ("that one label fills a side"). Nearest held sentences, for the deriver's prior-art gate to read
  first: FS132-E3's paragraph as `plans/STUB-seed-remainder.md` question 3 keeps it ("a region where one label is forced
  survives" — palettes at a triangle centre; unread by this lane at its source) and C124-SIX-CONES (labels confined to
  regions bounded by unit circles through the point). *Side*: neither alone; the instrument of the next claim.
- **C-CLOSE (forces regions; the card's claim, per seed).** *Definition*: the forced closure of a finite family of pieces in
  `U` is the least family containing it and, for every point `w` of `U` and all members of the family at points one unit from
  `w`, every piece C-FORCED gives at `w`. *Statement to derive*: every weak colouring of `U` that has the seed has its
  closure. *Then, for each seed, by exact arithmetic in the object's own field and forced steps only*: the closure out to the
  object's edge, and at each point reached the cells forced, free (two or more unbarred labels) and empty. **Seeds, in
  order**: (a) **at seven, R7** — the germs of the six tiles at each of two adjacent lattice points: no cell may come out
  empty at any step (it is a colouring: this is the survival control, and a failure is a defect in C-FORCED or the script,
  never a finding); measure how many of R7's germs at the common unit points and beyond the closure gives. (b) **the flower**
  — the germs at `e(180°)` and `e(270°)`, whose common unit point `(−1, −1)` is filled whole. (c) **the strip** — the six tiles
  of a covering pair at one of its 34 three-label coloured points. For (b) and (c) the closure must agree with the object
  wherever both are defined (a second survival control, at six), and the product is the list of points it reaches and where
  it stalls. *Restates*: for maps a forced step is what the ring calculus calls placing — G91; FS116-RING-TRANSFER-QC,
  FS116-N3-SEMI, FS116-N2-STAR and -N2-RECIP at a four-colour vertex's change points; N-E2 ("Siamese … or outer") is the table
  read from both ends of one unit segment. In measure: not found. *Side*: an empty cell beyond the pair's own points — toward
  seven for that seed; a closed ring — toward six; a stall — the free cells, to the Searcher.
- **C-STOP-GERMS (reads regions somebody keeps — as germs; short; it corrects the first round's closing sentence).** *Each
  of C136-STOP-DISK, C136-STOP-STRIP and C136-STOP-BOWTIE holds with "the parts of the named tiles within `r` of the two
  members" in place of the tiles, for every `0 < r ≤ r₀`, with a ball about the point across of radius at least `c·r` on the
  strip and the disk (every witness first order) and of order `r²` on the bowtie fragment.* *Controls*: this lane's reading —
  70 of 70 stops keep an empty cell at `ρ = 0.2, 0.05, 0.0125` (flower 6, disk 20, bowtie fragment 10, strip 34); depth
  exponents 0.60–1.05 at all 540 witnesses of the strip and the disk, near 2 at 12 of the flower's and 16 of the bowtie
  fragment's; the scan (the germ class differs from the whole-tile class at 2,990 of 34,200 triples on the disk, always as
  crossing against inner). R7 has no stop to survive. *Restates*: for maps FS114-Y-PENT ("agrees with the disk near") and
  FS114-Y3-RSTOP ("agrees with it near `q1` and `q2`") are already statements about germs; for two sector points it is
  C124-BOTH with germs as its pieces; C136-STOP-FLOWER-GERMS is the fourth. *Why it is here*: the first round's closing
  question ("which pieces at the members … must reach across") rests on "crossing is a fact about a piece's extent"; read on
  the objects, extent only ever turns an inner germ into a crossing tile. A stop is a fact about two vertex figures; what
  extent decides is whether a coloured point stays coloured. *Side*: none; it is the form the Searcher's screen takes.

**Not posed, and why.** *"Which pieces at the members must reach across the far circle?"* — at every held stop, the ones
whose germ already does; no claim is needed beyond C-STOP-GERMS. *"That some piece at a member reaches across" for every
colouring* — that is a first piece, and nothing here gives one: FS-127 and FS-128, not re-posed by this card. *A relation
between the tables of one ring* — posed, as C-CLOSE: the relation is that a piece forced at one point is a member at the
next.

### Registered expectations (Poros, 2026-10-07, before any derivation of these)

C-FORCED derived as posed 0.9; found already held under another name 0.2. C-CLOSE: on R7 no cell empty 0.97; the closure of
R7's pair gives at least one of R7's germs at a common unit point 0.9, all six there 0.3; the flower's pair reaches a point
beyond `(−1, −1)` with a forced cell 0.35; the strip's pair a third point 0.4; an empty cell from a pair alone beyond its own
two common unit points, on any seed tried, 0.25 (the card's number). C-STOP-GERMS as posed 0.85 (the bowtie fragment's
radius law is the uncertain part). A fragment by formula past `φ²/√2` from a closure, within this round: 0.05. Six against
seven decided here: 0.02.

### Failure clauses for this round

- If C-FORCED is already held (FS132-E3's paragraph, or an entry this lane's search missed), say so in the headline and pose
  only C-CLOSE.
- If the closure on R7 empties a cell, stop: the defect is in the statement or the script, and it goes to the coordinator at
  once.
- If every closure stalls at its first step, the product is the list of free cells per seed and the re-posed search line —
  and this milestone goes to its record job.
- Every statement says in its headline that it is about colourings that have the seed, and that no weak six-colouring is
  known to have one.

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

**Replacement drafted by the first round's deriver, filed by the asking lane as a dated block (2026-10-07, FS136-P1; source:
`plans/FS136-E1-derivation.md` Stage 0, "A draft for the asking lane"; the paragraph above is left standing). Corrected in
two places where the deriver's later stages and this lane's reading overtook it, each marked.**

G13 (the point across is a coverage question: each cell cut there by the members' unit circles needs a label no piece
bars; "a member separates" is the pair-level shadow of it); G86 (count labels, not pieces: a label with an inner and an
outer piece at one member is barred on both sides); G92 with G99 (the count's argument reads any finite set of members and
any number of labels; for maps it is FS-110's — FS110-CALC's A-EXACT and A-SIX, FS110-N-SEAM, N-E2 — which the card's
search of rows 135–138 and 145–150 did not reach); G96 (every hypothesis is ball data at the members, and the passage to
the point's circle is one connected piece — *corrected*: the draft read "a kept region is a named open set, never a germ";
the same record's C136-STOP-FLOWER-GERMS keeps germs, and by this lane's reading germs suffice at every held stop, 70 of 70,
at first order on the strip and the disk: `plans/POROS-2026-10-07-fs136-round1.md` § 1.3, S1); G84, G85 (at the flower the
unit circle about the point across is tangent at a member to an edge's circle: cones do not decide a side there, points do);
G83, G91, G98 (the unit; `6 − m` labels left for the ring of a point of `m` labels, none at six — *added*: read at the
members, each bars at the point only labels the point lacks; R7 bars exactly one per member, the six-coloured stops two);
G97 as amended (pieces, not palettes; no weak six-colouring is known to have them); G21, G95 (three stops are three objects;
R7 is every control at seven); G79 (the table is the example's invariant — and its forward half, a cell with one unbarred
label, is what the second round asks). Rows 133–134 (FS-110: the covering pair, the seam point), 135–138, 147–148, 155, 157,
159. Entries FS110-CALC, FS110-N-SEAM, FS110-NB-5, FS110-N-X (`plans/FS110-derivation.md`), C124-TYPE, C124-FORCED-PIECES,
C124-LONE, C124-BOTH, C124-FOUR, C124-SIX-CONES, C124-EDGE-CLOSED (`plans/FS124-derivation.md`), C136-TABLE, C136-COVER,
C136-ONE and the five C136-STOP entries (`plans/FS136-E1-derivation.md`), FS112-EDGE, FS112-STOP, FS112-DISK-RIM,
FS112-C-PARTNERS, FS114-Y-PAIRSHARE, -Y-PENT, -Y3-RSTOP, FS116-Y2-SIXOFF, -N2-SIXRING, -N2-STAR, -N2-RECIP, -N3-SEMI,
-RING-TRANSFER-QC. Stubs FS-127 and FS-128 (a first piece), FS-135 (its question 3 holds the nearest sentence to a forced
region), FS-117 (the count).
