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
