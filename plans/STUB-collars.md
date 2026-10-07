# FS-137 — collars: what a point carrying all labels but one forces along its unit circle, and what those collars force one unit further on (stub)

*Minted 2026-10-07 by FS-136's record job (FS136-Z1; `plans/FS136-Z1-record.md` Stage 4), from the one result of FS-136 that
forces a region of definite extent: the entry C136-COLLAR (`plans/FS136-derivation.md` § 2; derived, one mind, kernel
pending), found by FS-136's second deriver after its verdicts (`plans/FS136-E2-derivation.md` Stage 8). Its number is the
brief's (FS-137); the coordinator files the banner. **State: Not started. Unranked — the asking lane ranks it and writes
its question section, which is left empty below.** **Solver column: in-ban** — derivation and exact arithmetic on named
corners; a step that branches on a free corner is a `search request`, never taken here. **Nothing in this stub is a
statement about every weak six-colouring: every statement is about colourings that already have a point with labelled
corners carrying five of the six labels, and no weak six-colouring is known to have one.** Written for a session with no
memory of FS-136: read `plans/FS136-derivation.md` §§ 1–2 (C136-TABLE, C136-CORNERS, C136-CLASS, C136-FORCED, C136-CLOSE,
C136-COLLAR, each with its `not claimed:` line), then `plans/FS136-E2-derivation.md` Stage 8.*

## The mission, in plain language

The plane needs six colours or seven so that no two points at distance exactly 1 share one (`[OAIMath2026]`; in this
library on one declared outside theorem). It needs seven exactly when some open disc has no *weak six-colouring* — a
measurable map to six labels giving almost no two points at distance 1 the same label — and six exactly when every disc
has one (ledger row 161; [kernel], the half toward seven on one declared outside theorem). So one disc that cannot be
six-coloured decides the problem one way, and six-coloured discs of every radius decide it the other.

Everything this project can say about a weak six-colouring near a point starts from a **piece**: a connected open set
almost all of one label. One lemma does the work (C124-SHADOW-OPEN, C124-TYPE; ledger row 162): an open set almost all of
one label bars that label at almost every point whose unit circle meets it. FS-136 ran that lemma at a point `w` with
several pieced points on its unit circle (the table, C136-TABLE), and then forward: where the pieces one unit from `w` bar
every label but one on a corner at `w`, that corner has the one label (C136-FORCED). Chained, this forces labelled corners
at further points (C136-CLOSE) — but each forced corner is a **germ**: it is had at some radius that nothing bounds below.
On every seed tried — two points with three or four labels each — the chain stalled within two steps and forced no region
of definite size.

There is one exception, and this stub is about it. **A point that already carries all the labels but one forces the
missing label along whole arcs of its unit circle**: at every point of an arc where none of its own labels is pure on a
side, the only label left on that side is the missing one, so the missing label fills a one-sided strip — a *collar* — of
the whole arc. A collar has a definite length (60° of the unit circle on the one held object that has one) and no definite
width. It is the first region of definite extent that either FS-124 or FS-136 forces where none was kept. **What a collar
forces one unit further on has not been computed**, and that is the question a milestone here would take.

## Terms, each with its address

*All in `data/fs136/claims.md`: "Definitions, stated once"; the dated line of 16:06 UTC ("Added by this plan"); the dated
line of 18:25 UTC ("Added by this round").*

- `S(p)`: the unit circle about `p`. A **weak `k`-colouring** of an open set `U`: a measurable map from `U` to `k` labels
  with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit vector `u` with `z + u` in `U`.
- A **piece**: a connected open subset of `U` almost every point of which has one label. A **family of pieces at `x`**: a
  finite set of pieces, each with `x` in its closure. For `|w − x| = 1` a piece is **inner at `w`** if it lies in the closed
  unit disc about `w`, **outer** if it misses the open one, **crossing** otherwise; a label of the family is **inner-pure**
  (**outer-pure**) at `w` if every piece of that label is inner (outer), and **barred** otherwise.
- A **corner at `x`**: two curves from `x`, each a ray or a circular arc; a **labelled corner** is a corner with a label; a
  colouring **has** it if, for some `ρ > 0`, almost every point between the curves within `ρ` of `x` has the label. A
  corner is **inner**, **outer** or **crossing at `w`** as its small parts are (C136-CLASS decides which, exactly, from
  directions and signed curvatures).
- A **collar** (this stub's word for C136-COLLAR's conclusion): a connected open set `V` inside (or outside) `S(x)`, almost
  all of one label, containing a one-sided neighbourhood of every point of an open arc `A` of `S(x)`.

## The entry it starts from

**C136-COLLAR** (`plans/FS136-derivation.md` § 2; copied from `plans/FS136-E2-derivation.md` Stage 8; **derived from
C136-FORCED; one mind; kernel pending**). Its statement, verbatim:

> About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, whose labels are all the labels but one, ℓ, and A an open arc of S(x) lying in U such that at every point w of A each label of F has a corner in F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x).

Its *not claimed* line, verbatim:

> that a weak colouring has such corners; any width — η depends on w and on c and is bounded below by nothing, at the ends of A or anywhere along it; anything at the end points of A; anything for a point whose corners lack two labels (two labels are left on each side) or lack none (there a side on which no label is pure cannot be coloured at all: C136-ONE); that an arc A exists for a given F (it is read from the corners by C136-CLASS: for the flower's centre and for R7's lattice points there is none); that V is a tile, reaches beyond its collar, or has ℓ everywhere and not almost everywhere; what V bars one unit further on (a fact about its extent; not computed here)

Its argument is three steps (`plans/FS136-E2-derivation.md` § Argument — the collar): C136-FORCED with the one member `x`
at each point of the arc; a countable subcover; connectedness of a union of half-discs along a connected arc. Its control
(`forced-arc`) is the engine's scan on the held object below, with a planted fault.

## What is held on objects (the observations; each with its address)

- **The bowtie fragment** (FS114-Y2-BOWTIE, `tools/fs114_y2_k1.py`; a six-coloured fragment by formula holding the closed
  disc of radius `3√3/5` about `p = (0, 0)`). Its two five-label points are `q₂ = (√3/2, −1/2)`, which lacks the label 4,
  and `q₁ = (√3/2, 1/2)`, which lacks 2. From the second deriver's Stage 8, verbatim: "Along the open arc of `S(q₂)` from
  the origin to `(0, −1)` — directions `150°` to `210°` from `q₂` — the corner inside `S(q₂)` has, at every point, exactly one
  label left: `4`. Along the arc of directions `−30°` to `30°` the corner outside `S(q₂)` has only `4` left. The mirror image
  holds at `q₁` with the label `2`." Four collars: two inside the fragment, two beyond its radius. **Why there**: "`q₂`'s
  corners have cones of `30°`, `120°`, `120°`, `6.9°`, `83.1°`, and for a direction in `(150°, 210°)` the tangent line cuts both
  `120°` corners and the near half-plane holds no whole corner — no label of `q₂` is inner-pure." **Checked on another
  path**: "the fragment has the label `4` at 118 of 118 float samples just inside the first arc and `2` at 118 of 118
  inside `q₁`'s". The arcs' classes are exact (`data/fs136/e2/closure.py close bowtie12`; output
  `data/fs136/e2/out/bowtie12.txt`, first line "seed=10 corners at 2 points … arc-scans=2 arc-forced=4").
- **The closure of that seed as computed is a lower bound.** The engine lists five forced corners at three points — at the
  origin the labels 2, 4, 1 on three corners; at `(0, −1)` the label 6; at `(0, 1)` the label 5 — the four arcs, and the
  known emptied corner at the fragment's stop `(√3, 0)`, which lies outside the fragment. "The engine does not propagate
  from a collar (its header's LIMIT)". "What a collar bars one unit away is C124-TYPE on a piece with extent along an arc;
  nothing in this record computes it."
- **The flower's centre** (FS116-Y2-SIXFRAG's six-label vertex; `data/fs136/e2/out/flower0.txt`): no arc: "along its unit
  circle every open arc between critical directions leaves two labels on each side (`arc-forced=0`); at the six mid-arc
  ring points `e(60j + 30°)` the inside has one label left — the sector's own — and those six corners are forced (all six
  the fragment's colours), and then the closure stops."
- **The tight seven-colouring R7** (the calibration at seven): its lattice points carry six of seven labels and "never do
  this: every half-plane there holds a whole Reuleaux corner or a cusp, so each side keeps two labels or more — its scans
  read `arc-forced=0`".

*Correction, dated 2026-10-07 (20:10 UTC; filed by the coordinator; source: the asking lane's re-read, job FS136-P2, checked by the coordinator at `data/fs136/e1/out/bowtie.txt` l. 1, "5-label:4"): the bowtie fragment has **four** five-label points, not two. The arc scan was seeded with two of them (`q₂`, `q₁`), and what is said here of "its two five-label points" is said of those two; the other two have not been scanned. No verdict moves.*

## The smallest open form, the second deriver's (verbatim, `plans/FS136-E2-derivation.md` Stage 8)

> *a pieced point carrying five of six labels forces its sixth along every arc of its unit circle on whose side none of its own labels is pure; what do two such collars, or a collar and a pieced point, force one unit further on — a corner emptied, a stall, or a second collar?*

## The question (Poros, 2026-10-07)

*Posed by the asking lane at FS-136's Derived (job FS136-P2; record `plans/POROS-2026-10-07-fs136-derived.md`, where the
evidence, the expectations written first and the ledger are). **Everything below is about weak colourings that already
have labelled corners at named points; no weak six-colouring is known to have one, and no answer to this card fixes the
value of χ(ℝ²) by itself.** The question is wider than the stub's title: a collar is one reading of a count that every
point with corners carries, and the card is about the count.*

**What the count is, in the held words.** Let `c` have at `x` a finite set `F` of labelled corners filling a
neighbourhood of `x`, and let `w = x + e(θ)`. A label of `F` is *inner-pure at θ* if every corner of `F` with that label
is inner at `w` (C136-CLASS decides it), *outer-pure* likewise. Write `I(θ)` for the labels of no corner of `F` together
with the labels inner-pure at `θ`, and `O(θ)` the same with outer: by C136-TABLE at one member these are the only labels
almost every point near `w` inside (outside) `S(x)` can have. Call `I(θ)`, `O(θ)` the **palettes** of `x`, and the set of
`θ` at which a label is inner-pure its **window**. A side is *forced* where the palette is one label (C136-FORCED), *empty*
where it is none, *free* otherwise. A collar is an arc on which the palette is the one absent label.

### The card

question: can-a-ring-afford-its-points-at-six
  evidence: `plans/FS136-derivation.md` l. 547 — at the bowtie fragment's stop `(√3, 0)` "out/in=4 … in/out=2 out/out=EMPTY(order 1)", and `(√3, 0) = q₂ + e(30°) = q₁ + e(−30°)` is the common end of the two outer collar arcs (ll. 75–78 above); `data/fs136/e2/out/bowtie12.txt` seed line — the arc comes from two corners of 120°, a window of exactly 60°; `plans/FS116-derivation.md` ll. 655–658 — "r(θ) or r(θ + 60°) lies on a (Q) arc; so the (Q) arcs of the ring have total length at least 180°"; `data/fs136/e1/out/*.txt` l. 1 — strip "3-label:40 4-label:10" reaching 1.8512, bowtie "5-label:4" and flower "6-label:1" reaching 1.7321, R7 "6-label:16" of seven with no cell empty anywhere; `plans/STUB-q-ring.md` l. 229 — "a skeleton that saves every complementary pair at both common unit points has five-label centres"
  expected: a collar is a curiosity of one fragment, the stops are facts about pairs of tiles, and how many labels a point carries is "not read by anything at the point across" (FS-136's first round)
  ask: at six, can the points round one ring both pay at every point across (four labels or more, or three with a unit-arc edge) and keep a label on each side of their own unit circles, as R7's points do at seven?
  if the count falls short for every assignment of corners round a ring: an exclusion within 2 of a point for every weak six-colouring that has corners there and at the points of its ring — the first of this line whose hypothesis is "has vertex figures", not "keeps these tiles"; the existence stubs are re-aimed at exactly what it reads, and route T's count (FS-117) is re-read with directions in place of tiles
  if an assignment fits at first order: it is the Searcher's line-15 object with its reason — which numbers of labels sit where — and goes to line 16 to be grown into pieces; the palettes say where a construction has no freedom (forced arcs) and where it has (palettes of two)
  if it fits only with unit-arc edges at three-label points: the unit arc is the equality case of the count, the strip's way is the only way, and FS-124's cases 1, 3 and 5 become one question: how many such edges a ring needs and whether it has room for them
  answered by: derivation — Ephodos, for the count and its first four claims below; the lattice family of the ask's first-order form is the Searcher's line 15, which runs beside it
  cost: one round for claims 1–5 (each a few lines over C136-TABLE and C136-CLASS, with an exact read of a held output as its control); the ring question itself unpriced
  hunch: at first order the count falls short on the nineteen-point lattice family and fits only with unit-arc edges — 0.6; a count that excludes every ring at six with no family named — 0.12; that any of this moves the value — 0.01
  falsifier: a labelled set of corners at a point and the six points of its ring, with every cell at every common unit point within 2 non-empty at first order and no edge along a unit circle about a point across
  rank: 1

### Existence form

Is there a weak six-colouring of an open set containing the closed unit disc about a point `x` at which it has labelled
corners carrying five of the six labels — a five-label point *with its whole ring*? None is held: FS116-N2-FIVERING's
model line reads "none held with five colours at a vertex", and the bowtie fragment's four five-label points
(`data/fs136/e1/out/bowtie.txt` l. 1: "5-label:4") lie one unit from its centre, on the rim of what it holds. One ring
further: is there one containing the closed disc of radius 2 about a point with corners, with corners at the six points
of its ring 60° apart? *On corners, not pieces*: by C136-CLOSE's *not claimed* line a set of corners with every side
non-empty is a labelled skeleton, a design for the search lane's line 16 to grow, never a fragment.

### Structural form

For every weak `k`-colouring and every point `x` at which it has labelled corners filling a neighbourhood: **what must
the palettes of `x` be for both sides of `S(x)` to be coloured all the way round — points of `S(x)` 60° apart being one
unit apart — and what must the palettes of two such points be for every cell at their common unit points to keep a
label?** Is there one inequality between the numbers of labels at a point and at the points of its ring that every such
colouring satisfies, that R7 meets at seven with every vertex carrying six of seven, and that no assignment meets at
six? This is a question about every colouring with corners, at every `k`; it cannot be answered without something every
such colouring carries (the palettes, and what their sizes sum to), and it is the relation between the tables of one
ring that FS-136's structural form asked for twice and did not get (`plans/FS136-derivation.md` § 7 item 5).

### What each answer gives

- **Toward seven.** A count that falls short is an exclusion, at an explicit radius (at most 2), of every weak
  six-colouring that has corners at a point and at the points of its ring. It is seven only with a statement that every
  weak six-colouring has such a point (FS-127, FS-128; a point of four or more labels: FS-122, FS-130), which nothing
  held gives. What it would change at once: what those stubs must supply, said exactly.
- **Toward six.** A ring that fits is a skeleton with its reason, the first object of this line whose forced parts
  (collars, own-label arcs) nobody chose. It is six only as far as the search lane can grow it and then only disc by
  disc (ledger row 161).
- **Either way** the first five claims stand as instruments; none of them moves the value.

### The first claims a deriver takes, in order

*Each is put at the widest form its argument reads (the kernel planner's relay of 2026-10-07: the table reads neither
the number of labels nor the distance 1 beyond the cut at `w`; the forward step's label half is on the cell, "the whole
set of such points, connected or not"). Names are proposals; the coordinator fixes the claim list. For each: its
smallest form; its control on an object with no margin, **and what was run**; whether it reads regions somebody keeps or
forces one; the side it would move. Held antecedents were looked for in nine derivation files by five terms (`on
average`, `average number`, `mean number`, `total length`, `half-plane`) and in the entries the stub names; a search by
terms measures the terms.*

1. **C137-BUDGET — what the windows sum to.** *Plane geometry; no colouring.* For labelled corners at `x`, each of angle
   at most 180°, filling a neighbourhood of `x`: the windows' lengths sum to at most `180°·(c − 2)`, `c` the number of
   corners, with equality exactly when every label has one corner; so with `m` labels, one corner each, the mean over
   `θ` of `|I(θ)|` is `k − 1 − m/2`. *Smallest form*: one corner of angle `α` is inner at `x + e(θ)` for `θ` in an arc of
   length `180° − α` (its two ends by curvature, C136-CLASS). *Control, no margin*: R7 at a lattice point — three
   corners of 120° and three cusps, six of seven labels: mean `3`; the bowtie fragment's `q₂` — cones 30°, 120°, 120°,
   6.9°, 83.1°: windows 150° + 60° + 60° + 173.1° + 96.9° = 540° = `180°·3`, mean `2.5`, and the one direction set no
   window covers is `(150°, 210°)`, the collar's arc. **What was run**: nothing; both by hand from angles read in
   `data/fs136/e2/out/bowtie12.txt` and the stub. The control to run is the engine's scan of a unit circle, summed.
   *Reads* corners somebody keeps; *forces* nothing. *Side*: neither — it is the instrument, and it is where six and
   seven differ: one label fewer on every side of every ring, whatever the corners. *Not found held.*
2. **C137-THREE — a three-label point pays only along a unit arc.** At a point with three labels on three corners
   filling a neighbourhood, edges rays or circular arcs, a direction at which one label is inner-pure and another
   outer-pure is perpendicular to an edge, and that edge begins along the unit circle about `x + e(θ)`. So in C136-COVER
   a three-label member separates at `w` only if one of its edges begins with an arc of `S(w)`. *Smallest form*: two
   corners sharing a straight edge — at the direction perpendicular to it neither is inner. *It restates, by another
   route*, C124-BOTH's second sentence ("each has an edge that contains an arc of S(w) with an end at the member";
   one mind, over C124-LONE, the step its deriver flagged) and for maps FS112-N3-COR3; what would be new is the reason —
   it is BUDGET's equality case at `m = 3`, where the windows sum to exactly 180° and a window meets another's antipode
   in one direction — and that four labels or more pay on open sets of directions. *Control, no margin*: the strip's 17
   pairs with both common unit points inside (`partners-held`: "both=17"). **What was run**: nothing new; the control
   to run reads the paying member's edge at those 17, exactly. R7 has no three-label vertex: it is silent there, say
   so. *Reads* kept corners; *excludes* (payment at first order). *Side*: both.
3. **C137-SIXTY — FS116-N2-FIVERING's second clause, in measure.** Let `c` have at `x` corners carrying all labels but
   `ℓ`, and let `N` be the directions at which no label of them is inner-pure. If `θ` and `θ + 60°` are both interior to
   `N` and `x + e(θ)`, `x + e(θ + 60°)` lie in the domain, the two one-sided neighbourhoods inside `S(x)` hold a set of
   unit pairs of positive measure with both ends `ℓ` (points at depth `s` in directions `60° + δ` apart, `s` of the
   order of `δ`): so no domain holds both. Hence `N` has no two interior directions 60° apart, every arc of `N` had
   whole is at most 60°, `N` has length at most 180°, and two adjacent one-corner labels span at most 240°. The same
   outside. *Smallest form*: one arc longer than 60°. *Control,
   no margin*: the bowtie fragment's `q₂`, where `N = (150°, 210°)` is exactly 60° and its ends `(0, 0)`, `(0, −1)` are
   one unit apart — it must pass with nothing to spare. **What was run**: nothing new; read from the engine's
   `forced-arc` line and the seed line. R7 passes with room (`N` empty: "arc-forced=0") — a control satisfied with
   room measures the room (G21). *It restates* FS116-N2-FIVERING's clause "r(θ) or r(θ + 60°) lies on a (Q) arc" with
   no map and no disc; read that entry's argument first — C136-COLLAR's `prior art:` line quotes only its first
   clause. *Reads* kept corners; *excludes* vertex figures. *Side*: both.
4. **C137-OWN — a point with every label forces its own.** In C136-COLLAR put "an open arc along which `I(θ)` is one
   label `ℓ`" for "whose labels are all the labels but one, `ℓ`": the conclusion and the argument are the same
   (C136-FORCED's hypothesis never asks that `ℓ` be absent at the member), and by SIXTY's argument each such arc is at
   most 60°. So G100's "extent is forced in one way" has a second: at a point of all `k` labels, an arc on whose side
   exactly one label is pure. *Smallest form*: C136-FORCED at one member with `ℓ` the one pure label. *Control, no
   margin*: the flower's centre — six corners of 60°, windows of length zero: six isolated forced corners, "the
   sector's own", and no arc. **What was run**: the second deriver's `flower0` (not re-run by me). **No held object has
   an arc of this kind** — the claim is about colourings nobody holds an example of, and its headline says so. For
   maps it is FS116-N2-SIXRING ("six 60° (Q) arcs, one per tile"). *Reads* kept corners; *forces* a region with length
   and no width. *Side*: both.
5. **C137-MEET — where two collars meet.** *A corollary of C136-TABLE on the cell.* For `x`, `y` with
   `0 < |x − y| < 2`, corners at each, and `w` a common unit point: on the cell at `w` on given sides of `S(x)` and
   `S(y)` the labels left are the two palettes' common labels. If `x` lacks exactly `a` and `y` exactly `b ≠ a`, the
   cell is empty unless `a` is pure for `y` on its side, or `b` for `x`, or one label is pure for both. *On the held
   object*: `(√3, 0)` is the common end of the outer collar arcs of `q₂` (label 4) and `q₁` (label 2), and the cell
   outside both circles is empty (C136-STOP-GERMS (c), read this way); at the pair's other common unit point, the
   origin, the inner arcs end and the cell inside both is coloured, by the label of a tile both points carry (`t1`).
   So with both points' corners kept neither outer arc lies whole in any domain (C136-STOP-GERMS-RADIUS). *Control, no
   margin*: R7 — adjacent lattice points lack different labels, and `forced-r7-window` reads "empty=0" over 432
   corners at the 108 common unit points of 54 pairs: at each, one of the three alternatives must hold. **What was
   run**: the second deriver's control (not by me); the control to run names which alternative, corner by corner.
   *Reads* kept corners; *forces* nothing; *excludes*. *Side*: both — a design rule (two five-label points lacking
   different labels need a common pure label at both their common unit points) and the mechanism of one held stop.
6. **The ring itself**, the card's ask. *Smallest form*: a point, the six points of its ring 60° apart, corners at all
   seven, and every cell at the nineteen lattice points within 2 non-empty — the search lane's line 15 is its
   first-order lattice family. For the deriver: is there an inequality from BUDGET, summed over the seven points and
   the cells they cut, that R7's labelling meets at seven and no labelling meets at six? *Controls*: it must not fire
   on R7; it must not fire on the strip, the disk, the flower or the bowtie fragment at any point they hold; a count
   that excludes a held object is a defect.

**The seeds, by their labels** (G100's *Do*, done before the word "forced" was written): claims 3 and 4 start from a
point of `k − 1` or `k` labels — the only kind from which an arc is forced; claims 2 and 5 force nothing; no claim asks a
closure for a fragment.

### Registered before any deriver reads this

BUDGET as stated 0.9; THREE for rays and arcs 0.8; SIXTY 0.85; OWN 0.85; MEET's rule 0.9, and on R7 every cell passing
by one of its three alternatives 0.9. The ring: a count excluding every assignment, no family named, 0.12; a first-order
ring out to 2, by derivation or by line 15, 0.3; neither within the milestone 0.6. The value: 0.01.

### The record job's remark below — the asking lane's position

True, and it is the one lemma itself (C124-SHADOW-OPEN applied to `V`), not a consequence to derive. By hand (one
mind, no control) the region is the union of the unit circles about the arc's points — for 60°, two lunes each holding a
disc of radius 1/2, joined by a thin bridge — and on it the colouring uses five labels. A collar forces nothing there by
itself: it brings one bar where a forced side needs five. What is new in a collar is the kind of bar, on an open
region where a germ bars at corners of isolated points; whether that is ever the fifth bar is claim 5's question on
the held object, not a separate computation. The stub's first failure clause covers the case that it never is.

### The stop for this line, set now

FS-124 ended at eight cases and FS-136 at lists of free corners. **If claim 6 ends at a list too — no count, no ring —
the asking lane poses no fourth card on local configurations**: the next opening is the existence step (FS-127 with
FS-122), in whatever form it then has, or an honest exit to Kooshi saying it has none.

## What the record job noticed while filing — one line, not an entry, checked by no control

A collar `V` is itself an open set almost all of one label `ℓ`, so the one lemma applies to it as it stands
(C124-SHADOW-OPEN): `ℓ` is barred at almost every point at distance exactly 1 from a point of `V`. That set contains every
point `z` of `U` with `0 < |z − x| < 2` one of whose two unit points on `S(x)` lies in the arc `A` — the unit circle about
`z` crosses `S(x)` there, so it enters the collar. So the first thing a collar does one unit further on is **exclude** its
label, on a region of definite area swept by the unit circles about the arc's points; it forces a label there only where
the other labels are barred too. Whether that is so on the bowtie fragment's four collars is the first exact computation
a deriver would run. *One mind's remark made while reading; it is to be derived, or refuted, before anything rests on it.*

## The held map entry it restates

**FS116-N2-FIVERING** (`plans/FS116-derivation.md` l. 655, as the second deriver quotes it): "in a valid fragment on a
closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change point" —
"read at its statement only, its argument and mind count not read". In G98's count: one label is left for the ring of a
point of five labels. What C136-COLLAR adds, in its deriver's words: "the class (no map, no disc about the point, nothing
assumed on the ring) and the hypothesis read arc by arc". **A deriver here reads FS116-N2-FIVERING's argument first**
(a prior-art debt), and with it the map entries on placing that the forward step restates (FS116-RING-TRANSFER-QC,
-N3-SEMI, -N2-STAR, -N2-RECIP: named by FS-136's claim list, read by neither deriver).

## Controls a deriver should run

- **At seven, R7 reads zero**: no lattice point of the tight seven-colouring forces an arc (`closure.py close r7`:
  "arc-scans=2 arc-forced=0"). Any statement about collars must leave R7 alone; a corner emptied on R7 is a defect, never a
  finding.
- **The flower's centre gives isolated points**: six forced corners at the six mid-arc ring points and no arc.
- **The bowtie fragment agrees with its own collars**: the label forced along each arc inside the fragment is the
  fragment's (118 of 118 samples, floats). A propagation from a collar must agree with the fragment wherever both are
  defined.
- **The planted fault** of the arc scan (`--fault=bar`: one wrong bar) must empty a corner.
- G21, G95: run each control where the hypothesis is tight — R7 and the two fragments have no margin anywhere.

## Bearing on the answer (the asking lane's, 2026-10-07, FS136-P2)

None on the value as it stands, and none from any answer alone: every statement here is about colourings that have
corners at named points. It is the local half of both roads, asked for the first time as one count — what a point's own
corners leave on each side of its unit circle, over all directions — instead of object by object. *Toward seven*: a count
that falls short round every ring is an exclusion within 2 of a point for every weak six-colouring with corners there
and on its ring; it is seven only with a statement that every weak six-colouring has such a point, which nothing held
gives (FS-127, FS-128; a point of four or more labels: FS-122, FS-130). *Toward six*: a ring that fits is a skeleton
with its reason for the search lane to grow; it is six only disc by disc (ledger row 161). The asking lane's number
that this milestone moves the value: 0.01. Why it is posed all the same: two milestones ended at lists, and the lists
are of one kind — sides with two labels left — which a count over directions is the instrument for and a table at one
point is not.

## Owed second minds

C136-COLLAR, C136-FORCED and C136-CLASS's order are one mind's each: "each has controls on another code path … and no
second derivation" (FS-136 inventory item 14). The kernel is the workflow's second check and none of FS-136's entries is
in it; C136-COLLAR's `handoff:` line says what its kernel statement needs — "`ae_onSide_of_label` at the one member for
each point of the arc, a countable subcover, and the connectedness of a union of half-discs along an arc" — and
`ae_onSide_of_label` is kernel-checked on a branch, not through the gate.

## Registered expectations

None is registered: the second deriver registered nothing on collars (the arc scan was run after its verdicts, "on seeds
nobody had named"), and the record job registers none. The asking lane registers its own with its card.

## Failure clauses

- If what a collar bars one unit away is, on the held object, only what the point's own corners already bar there, the
  product is that sentence, exact, and the stub closes on it.
- If a propagation from collars empties a corner on R7, stop: the defect is in the statement or the engine, and it goes to
  the coordinator at once.
- A label forced on a region of definite area, or two collars that close up, is a region nobody kept: to the coordinator
  at once, as "claimed by one mind, unchecked" (FS-136 inventory, the announcement rule and item 12 (d)).
- Every statement says in its headline that it is about colourings that have the five-label point's corners, and that no
  weak six-colouring is known to have one.
- Three failed attempts on one step: stop and hand the stalled form back.

## Deliverables

Entries in the deriver's grammar, each with its control and planted fault; the engine extended to propagate from a collar
(its header's LIMIT names the gap), under a new job's directory, the original left as it is; and an explorable picture of
the bowtie fragment with its two five-label points, their corners, the four collars and whatever the collars bar or force
one unit on.

## Provisional bearings

*The asking lane's line (FS136-P2), which the deriver's re-grokking replaces at the opening:* G98 (its count read with
pure labels added: `k − m` absent and, on average, `m/2 − 1` pure — so `k − 1 − m/2` labels on a side, one fewer at six
than at seven for every `m`); G100 (extent forced from a point of `k − 1` labels — and, by C136-FORCED's own hypothesis,
from a point of `k` with one label pure: its "one way" is two); G97 with G84 (the unit arc about a ring point as the
equality case of the count at three labels: where a three-label point can pay at all); G99 and G92 (each first claim
names the map entry it restates — FS116-N2-FIVERING *both clauses*, FS116-N2-SIXRING, FS112-N3-COR3 — and is put at the
class its argument reads); G86 (a count over tiles is blind to Siamese pairs; a count over directions at a point reads
them as own-label arcs — a reading of the asking lane's, basis analogy, untested); G91 (points of a ring 60° apart are
one unit apart: the hexagon the palettes must colour); G21, G95 (every control on R7 and the held fragments, none with
a margin; say of each what was run). Ledger rows 137, 149, 161–167. *The record job's line, kept:*

G98 (the count: `k − 1` labels at a point leave one for its ring — at six, a five-label point; the collar is that count
for pieces, arc by arc); G96 (a forced corner is a germ; a collar is the first forced piece with a definite extent, and it
has length and no width — "a connected piece of definite size" is still owed across it); G84, G90 (a corner's class is
decided by curvature where directions are tangent: the classes along an arc are exact, by C136-CLASS); G13 (the hypothesis
is a coverage statement at each point of the arc: no label of the point pure on that side); G91 with G99 (for maps the
forced step is placing and the five-colour ring is FS116-N2-FIVERING: read them before posing; no weak six-colouring is
known to have the corners); G97 (pieces at named points, not palettes); G21, G95 (R7 and the flower's centre are the
controls; a zero from the scan measures which arcs were scanned); G83, G86 (the bowtie fragment is a Siamese-class object:
a count over tiles says nothing here). Ledger rows 161–162 (the disc criterion; the one lemma), FS-136's rows as filed;
entries C136-TABLE, C136-CORNERS, C136-CLASS, C136-FORCED, C136-CLOSE, C136-COLLAR, C136-ONE, C136-STOP-GERMS (c)
(`plans/FS136-derivation.md`); C124-SHADOW-OPEN, C124-TYPE (`plans/FS124-derivation.md` § 2); FS116-N2-FIVERING,
FS116-N2-SIXRING (`plans/FS116-derivation.md`); FS114-Y2-BOWTIE and FS114-Y3-RSTOP (`plans/FS114-derivation.md`). Stubs
FS-136 (`plans/STUB-covering-pairs.md`, the predecessor), FS-127 and FS-128 (a first piece), FS-135 (the seed's
remainder), FS-124 (`plans/STUB-q-ring.md`, case 4: the five- and six-colour vertices). Search queue lines 15 and 17–20
(the skeleton search and the free corners of FS-136's four closures).
