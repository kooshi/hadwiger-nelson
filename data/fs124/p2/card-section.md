## The question (Poros, 2026-10-07, after the first round) — the save: a close complementary pair and its common unit points

*FS124-P2 (`plans/POROS-2026-10-07-fs124-round1.md`; brief `data/fs124/briefs/FS124-P2-round-one.md`). Posed after FS124-E1 brought the
six first claims of the section above to verdicts (`plans/FS124-E1-derivation.md`, sixteen entries, each derived, one mind). The two
cards above stand; the card of this morning is answered on its third branch — for one tight pair, at first order, nothing is forced
beyond the first step, at any number of labels. Nothing in this section is derived: every statement is posed, or read from a held
object by sample ([tools], one mind, `data/fs124/p2/centre_read.py`), and says which.*

**Why the unit changes.** A tight pair is not a cause. On both held six-coloured maps it is an effect, with one cause: every centre
of unit arcs inside FS-112's strip and disk is a point at distance 1 from two three-label points whose label triples are
complementary and which are less than 2 apart, with exactly one edge of each of the two on the centre's unit circle (94 of 94 such
points; the centre's four labels are those of the two edges and its absent pair the two third labels in 91 of 91 off the cut), and
no such point inside either object fails to be a centre (`unsaved_check.py`). The number six is spent there: two disjoint triples
are all six labels, so a point one unit from both has no label left unless a boundary at one of them runs along its unit circle
(C132-COMP-SHARP, `plans/FS132-derivation.md` § 4, derived, one mind). The tight seven-colouring R7 has no three-label point at all —
its only points of more than two labels are lattice points, with six — and so survives every statement below with nothing to check.

**Definitions, stated once.** `c` is a weak six-colouring of an open set `U` (the class of the section above). A **three-piece
point** is a point `x` of `U` with a neighbourhood that is, up to a null set, the union of three connected open sets, each with `x`
in its closure and one label almost everywhere, the three labels distinct; its **edges** are the three common boundaries of two of
the pieces near `x`. A **close complementary pair** is two three-piece points `x`, `y` with `0 < |x − y| < 2` whose six labels are
distinct. Its **common unit points** are the two points `w` with `|w − x| = |w − y| = 1`. A common unit point `w` in `U` is **saved
by `x`** when some edge of `x` contains an arc of the unit circle about `w` with an end at `x`; the **pattern** at `w` is the pair
(number of such edges of `x`, number of such edges of `y`). A map's vertex of three tiles is a three-piece point with no dictionary.

### The card

question: what-does-a-save-cost
  evidence: `data/fs124/p2/centre_read.py rhombi` — strip "three-label-ends=40 close-complementary-pairs=54 ends-in-some-pair=40",
    "(1, 1):74", "71 of 74"; disk "(1, 1):20", "20 of 20"; `data/fs124/p2/unsaved_check.py` — no common unit point that is not a
    centre lies inside either object; `plans/FS132-derivation.md` l. 742, C132-COMP-SHARP: "one of the six sets … is contained in the
    unit circle about w"; `plans/FS124-E1-derivation.md` l. 524, "No held object meets C124-HALF's hypothesis", and l. 536,
    C124-HALF-TWO's model "owed"
  expected: that after one tight pair the unit is the centre with all its tight arcs, and that a count on six is spent at the centre
  ask: When a close complementary pair is saved at a common unit point, must one edge of each member lie on its unit circle — and what does a weak six-colouring then carry there and at the second common unit point?
  if one edge of each member is forced: a saved point's four labels and absent pair are read off the pair (C124-HALF-TWO), every
    tight arc of kind both is half of a save, and the strip's top edge is closed to every colouring that keeps its two central rows;
    the YES side must change the rows, and the NO side has a rigid labelled incidence of pairs and points to count on
  if a save by one member alone exists (an object on a neighbourhood of the four points): six has a second kind of centre — a point
    that is centre and far end of the same arc's partner, as R7's lattice points are at seven — and it is the only kind the strip's
    top edge leaves room for; a third row above the strip by formula is then worth a design and a search at once
  if neither is decided by first-order tools: the pattern is read on the five held objects not yet read and asked of the Searcher's
    wedge family as a finite question, and the round's product is the datum a pair carries between its two common unit points
  answered by: derivation — Ephodos, FS-124's second round, on the first claims below
  cost: one reading round on five held objects; then four claims of a stage or less each
  hunch: one edge of each member is not forced — a save by one member is consistent with every first-order statement held, and
    nobody has built one (an object on a neighbourhood of the rhombus 0.45; excluded 0.2)
  falsifier: a derivation that in C132-COMP-SHARP's setting an edge of each member lies on the unit circle about every common unit
    point in the set; or, among the five unread held objects, a common unit point saved by one member alone
  rank: 1

### Existence form

Is there a weak measurable six-colouring of an open set containing a close complementary pair of three-piece points and both of its
common unit points, in which one of the two is saved by one member alone? Its large form is the section above's and stands: for
every `R > 0`, a weak six-colouring of the open disc of radius `R` — by C124-RADIUS (derived, one mind) a yes is `χ(ℝ²) = 6` and a
no at one radius is `χ(ℝ²) = 7`. Held: saves by both members at every centre of the strip and the disk; no save by one member
anywhere read; nothing above the strip's top edge `|y| = √15/4 + √3/2` or outside the disk.

### Structural form

In **every** weak measurable six-colouring of an open set, for every close complementary pair of three-piece points in it and every
common unit point of the pair in the set: which edges of which member lie on the unit circle about the point; which labels are
present there, and in which of the four regions cut by the unit circles about the two members; and what does the pattern at one
common unit point fix at the other? The question is about every solution in the widest class where a pair makes sense, and it
cannot be answered without naming what a pair carries from one of its common unit points to the other: the candidate is the pattern
together with a cyclic order of the six labels in which the pairs of the two points alternate (C124-SECOND below; on the strip the
order is `P, O, G, R, B, M`). It is not the existence form reworded: that asks for one object with one pattern. **Not asked here, and
said in every claim**: that a weak six-colouring has a three-piece point, or a close complementary pair — the second is FS-122's
question (the forced pair), the first FS-127's and FS-128's.

### What each answer gives

| answer | toward six | toward seven |
|---|---|---|
| C124-FORCED derived | every close complementary pair in a six-colouring of a region is paid for at each common unit point in the region by a boundary on a unit circle: what a construction must supply, pair by pair | the first statement of this milestone that holds at six and fails at seven; with a close complementary pair in every colouring (FS-122, not asked here) the tight pair is forced |
| one edge of each member is forced | the strip cannot be continued upward with its two rows kept; the next object changes the rows | every save is a four-label centre whose labels the pair fixes: a labelled incidence on which a count over a region can be posed |
| a save by one member exists | the shape of a third row; a design by formula, then a search | a second kind of centre to exclude or to count; C124-HALF stops being a statement over an empty class |
| C124-EDGE holds | the only open continuation above the strip is named | nothing beyond the strip's family (G21) |
| C124-SECOND derived | a pair's two saves use different edges at each member: each member's three edges are spent as one, one, and one left | the datum on which "does it close up" is asked; no exclusion alone |
| some held object has a tight arc of kind both that is no edge of a save | the frame of this section is wrong for that object, and the unit is re-posed from it | — |

### The first claims a deriver takes

*Order: as listed. Kinds: **reading** (no count), **spends six** (holds at six and fails at seven, the witness named), **per class**
(true at every number of labels). Controls are on objects with no margin; R7 survives each claim that spends six because it has no
three-piece point, and that is said once here.*

- **C124-READ-SAVES (a reading; first).** On every held six-coloured object — FS-112's strip and disk (read here by sample),
  FS-114's capped strip with its caps, fragment T2, the bowtie fragment, FS116-Y2-SIXFRAG, and the Searcher's kept model — list
  every close complementary pair of three-piece points and each of its common unit points inside the object, with: the pattern; for
  pattern (1, 1), C124-HALF-TWO's hypothesis read whole (each member's two other edges with points strictly on opposite sides of the
  unit circle about the point); the labels present at the point. *Statement to verify*: at every such point the pattern is (1, 1),
  that hypothesis holds, and the labels present are exactly the four labels of the two edges. Also: every tight arc of kind both of
  each object, and whether it is an edge of some save. *Controls*: the plant moves the point by 0.01 and the pattern must read
  (0, 0); R7 must return no pair. *Side*: none. It decides whether C124-HALF-TWO is the law of every held centre, whether any held
  object has a save by one member (the section above records "in fragment T2 three sets lie on that circle"), and whether a
  six-label centre (SIXFRAG's) is a saved point at all.
- **C124-FORCED (spends six).** Let `c` be a weak six-colouring of `U`, `(x, y)` a close complementary pair of three-piece points
  and `w` a common unit point of the pair lying in `U`. Then `w` is saved by `x` or by `y`; and for every interior point `z` of the
  arc so obtained the pair `(w, z)` is tight for the two labels of that edge, in one order along the arc. *Smallest form*:
  C132-COMP-SHARP applied to the six initial pieces of the edges of length `1/n`; one edge serves for infinitely many `n`, and an
  initial piece contained in a circle is an arc of it. *Controls*: the 94 points of the strip and the disk; **fails at seven** on
  the hexagonal seven-colouring at circumradius `2/5` — two vertices with disjoint label triples less than 2 apart and a common unit
  point interior to a tile, to be exhibited by formula. *Side*: both. It is the answer to the deriver's question as far as anything
  held reaches: at six a tight pair is forced one unit from a three-piece point that has a close complementary partner.
- **C124-ONE-MEMBER (spends six; decides the card).** In the setting of C124-FORCED suppose exactly one of the six edges, an edge
  of `x` with labels `t_0, t_1`, contains an arc of the unit circle about `w` at its member. *Derive* what C124-HALF then gives in
  this grammar — after exchanging the names if need be, near `w` and outside the unit circle about `y`, the label `t_1` inside the
  unit circle about `x` and `t_0` outside it — and its consequence: `(x, w′)` is tight for `(t_1, t_0)` for `w′` on that side of `w`,
  `(w, z)` is tight for `(t_1, t_0)` along the edge, so one label lies inside both circles and each of `x`, `w` is a centre of an arc
  through the other. *Then decide*: a weak six-colouring of an open set containing `x`, `y` and `w` with this pattern, by formula
  with an exact check — or the step at which none exists. *Smallest form*: which labels may be present near `w` inside the unit
  circle about `y`, given the sides of `y`'s three edges. *Controls*: the relation "each of two points one unit apart is the centre
  of an arc through the other, one label inside both" is R7's between adjacent lattice points (label `0` between `(0, 0)` and
  `(1, 0)`), at seven and with no pair; no held six-coloured object is known to have it (C124-READ-SAVES says). *Side*: YES if built;
  NO if excluded — then every save is by both members and C124-HALF is a statement over an empty class.
- **C124-EDGE (spends six, through C124-FORCED; a computation by formula on one held object).** On FS-112's strip, let `w` be a
  point of the top edge `y = √15/4 + √3/2` that is a common unit point of a close complementary pair of the strip's three-piece
  points. Then the member of the pair on the line `y = √3/2` has no edge free for the unit circle about `w`: its three edges lie on
  the unit circles about two midline vertices and on a vertical wall. Hence a weak six-colouring of a neighbourhood of the closed
  strip that agrees with the strip on `|y| ≤ √15/4` saves no such `w` by both members. *Smallest form*: `w = (1/4, √15/4 + √3/2)`
  with the pairs `(−1/4, √15/4)`, `(1/2, √3/2)` and `(0, √3/2)`, `(3/4, √15/4)`. *Control*: the same computation at the midline
  vertices must return the 74 saves read. *Side*: toward six it names the one continuation left open, a save by the upper member's
  upward edge alone (C124-ONE-MEMBER's pattern); toward seven nothing beyond this family.
- **C124-SECOND (spends six; the datum a pair carries).** In the setting of C124-FORCED let both common unit points `w`, `w′` lie
  in `U`, each with pattern (1, 1). Then the edge of `x` on the unit circle about `w` and its edge on the one about `w′` are
  different edges, likewise for `y`; with C124-HALF-TWO's hypothesis at both, the label sets at `w` and at `w′` have exactly two
  labels in common, one of each member, their absent pairs are disjoint, and the six labels have a cyclic order in which the three
  pairs read at `w` (the two edges, the absent pair) and the three read at `w′` alternate. *Smallest form*: two unit circles through
  `x` cross there, so no arc ending at `x` lies on both. *Control*: the strip's 20 pairs with both common unit points centres
  (the order `P, O, G, R, B, M` at `x = (1/2, √3/2)`, `y = (1/2, −√3/2)`); the disk has none. *Side*: none alone; it is the
  structural form's candidate invariant, and the statement on which "do the saves close up" is next asked.

**Which kind each is.** Reading: C124-READ-SAVES. Spends six: C124-FORCED, C124-ONE-MEMBER, C124-EDGE, C124-SECOND. Per class,
cited and not re-derived: C124-SHADOW-OPEN, C124-CENTRE, C124-STRADDLE.

**The deriver's question, answered as far as the record reaches.** *What the strip's ends are*: three-label points, 40 of 40
interior ones, each one unit from exactly two midline vertices — 20 at `(k/2, ±√3/2)`, the apex of a unit triangle on two vertices
one unit apart, and 20 at `(1/4 + k/2, ±√15/4)`, on the unit circles about two adjacent vertices. So "0 of 92 ends centre a unit
arc" is true and every end is the common end of two arcs about two centres. *Whether anything at six forces a centre of kind both one
unit from an end*: a close complementary pair forces a tight pair at each common unit point (C132-COMP-SHARP; C124-FORCED is its
form here), and on the strip every end is a member of such a pair. Two things nothing held forces: that an end has a complementary
partner within 2 (FS-122's), and that all four labels are present at the saved point — C124-HALF-TWO bounds them from above, and
the equality is read (91 of 91), not derived.

**One remark for the deriver, per class, unchecked** (`plans/POROS-2026-10-07-fs124-round1.md` § 1.2): when both labels of a tight
window have sectors at the centre, the line through the centre perpendicular to each direction of the window separates the two
sectors; so a window of positive length joins non-adjacent sectors, and at a point with four sectors the pairs are the two pairs of
opposite sectors. It is C124-CENTRE read on a whole window.

### Registered expectations (Poros, 2026-10-07, before any derivation of these)

C124-READ-SAVES: its statement holds on the strip and the disk read whole 0.9; some unread object shows a pattern other than (1, 1)
0.5; a save by one member on a held object 0.1; every tight arc of kind both on the five unread objects is an edge of a save 0.6
(SIXFRAG's vertex is the likeliest miss). C124-FORCED derived as posed 0.8, restated at its wording 0.15. C124-ONE-MEMBER: an
object by formula 0.45, excluded 0.2, a gap at a named step 0.35. C124-EDGE holds as read 0.7. C124-SECOND derived as posed 0.9.
The card: one edge of each member forced 0.2; a save by one member exists 0.45; neither decided 0.35. An exclusion at an explicit
radius, in measure, for every weak six-colouring with a close complementary pair, within this milestone: 0.07. A six-coloured
object above the strip's top edge or outside the disk, by formula or search, within this milestone: 0.12. Six against seven decided
by this milestone: 0.03.
