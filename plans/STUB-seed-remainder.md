# FS-135 — the seed's remainder: what a triangle point's unit circle forces beyond step form and near witnesses (stub)

> **Ranked 2, 2026-10-07 (FS124-P1).** Its question 4, the one-edge form of C132-TURN's stall, is not asked: its content returns as C124-CENTRE and C124-COMPLETION at the placed point (`plans/POROS-2026-10-07-fs124-question.md` § 3.4).

*Minted 2026-10-07 by FS-132's record job, part 2 (FS132-Z2; `plans/FS132-Z2-record.md` Stage 2), carrying four threads FS-132
left open on the side of its results where no boundary is a unit arc about a ring point: the gap C132-LENS-II (FS132-E6), the
three shift lemmas and the one-edge form of C132-TURN's stall (FS132-E4), and the third-label rigidity (FS132-E3). State: Not
started. Unranked; Poros ranks it, and decides whether its fourth question is a question at all. **Solver column: in-ban** —
derivation and exact checks; a step a finite enumeration could decide is a `search request`. Written for a session with no
memory of FS-132: read `plans/FS132-derivation.md` §§ 2, 4, 5 and 8 (the entries named below, with their `not claimed:`
lines), then the three sections of the derivers' records this stub addresses.*

## The setting, in plain language

The plane needs six colours or seven (`[OAIMath2026]`), and its number is that of **weak measurable colourings** — measurable
maps `c` to the colours with `c(z) ≠ c(z + u)` for almost every point `z` and unit vector `u`. FS-132 asked what such a
six-colouring is forced to do near a point that carries data on its unit circle, with no map. By Kooshi's word of 2026-10-07
that is what FS-132 delivers; whether every weak six-colouring *has* such a point left it (it is FS-127's and FS-128's).

**The terms** (FS-132's, each defined in `plans/FS132-derivation.md` or the record it names):

- `H_i`, the closed essential support of the class of label `i`. `Δ(K)`, the *straddle set* of a set `K`: the points with a
  point of `K` nearer than 1 and a point of `K` farther than 1.
- A **witnessed edge** `{i, j}` at a point `x`: a compact set through `x` holding another point, with `H_i` and `H_j` both
  disjoint from its straddle set. A **witnessed triangle**: three labels `T`, each pair a witnessed edge at `x`. A **seed**: a
  point with such data, however it came by them (`plans/FS132-close-inventory.md` item 23).
- The **ring** of `x`: its unit circle, read through the *palettes* `P_x(e)` (`[OAIMath2026]` Definition 5.1) — the labels of
  positive weight in direction `e`. The three labels outside `T` are written `a, b, n`. **Ring points** `y_k = x + e(ψ + kπ/3)`.
- A ring point is **outer-pure** when at least two of the three sets have a point strictly inside the unit circle about it —
  then, near it, the side outside `x`'s ring carries only `a, b, n` (C132-WIT-SIDE, C132-WIT-STRIP) — and **inner-pure** when
  at least two have a point strictly outside that circle.
- The **turning ring**: palettes reading `a, b, n, a, b, n` on six sectors of 60°. The **alternating ring**: `a, b, a, b, a, b`.
  The **lens** at `y_0`: the points near it inside the unit circles about both neighbours `y_1`, `y_{−1}`.
- **Step form**: the palettes are constant on each side of the change. A ring whose state is only measurable near a change is
  not in step form.

**What FS-132 derived here** (each [hand] or derived from [hand] entries, one mind, kernel pending; none has a model at six —
no weak six-colouring with a turning seed is held):

- **C132-ALT** — the alternating ring is excluded in step form wherever two adjacent ring points each have a pure side; for a
  ring only measurable, for two adjacent *inner-pure* points only (over C132-M-ORBIT's step lemma M8). In the search's finite
  wedge family the alternating ring has no model (SEARCH-1007-ALT, [cert] in that family).
- **C132-LENS, C132-LENS-SIDE** — on a turning seed, between two outer-pure neighbours the lens carries only labels of `T`,
  and the middle ring point has no pure inner side.
- **C132-LENS-FOUR, C132-LENS-GERM** — three consecutive outer-pure ring points make the middle one a point with four labels
  present; three such points exist when each of the three sets has a point strictly inside three of the six unit circles about
  the ring points and strictly outside the other three (as when each has a limiting direction at `x` perpendicular to no ring
  direction).
- **C132-TURN-EDGE** — at a step `a | b` of a turning ring whose two neighbours are outer-pure, `{a, b}` is not a witnessed
  edge at the ring point.

What happens at the placed four-label point is FS-124's (`plans/STUB-q-ring.md`): its unit circle runs along two unit arcs
there (C132-PLACED-RING). This stub is the rest.

## Questions, in order

1. **Far witnesses** (C132-LENS-II, a gap; `plans/FS132-E6-derivation.md` § The gap in clause (ii)). "Pure sides are opposite
   at antipodes" holds one way only: a point strictly inside the unit circle about `y` is strictly outside the one about
   `2x − y`, and not conversely — three sets `{x, q_j}` with `|q_j − x| = 3` make all six ring points inner-pure and none
   outer-pure. Sixteen sets of outer-pure points are left open: none, one point, two adjacent, two antipodal. Its smallest
   open form, verbatim: *"A six-sector turning seed in which every ring point has a pure inner side and no ring point has both
   neighbours outer-pure: is some ring point a four-label point — or does such a seed not exist?"* A remark of FS132-E6's, not
   entered and unchecked: when every witnessing point is farther than 2 from `x`, the labels of `T` are excluded from the whole
   open unit disc about `x`, which three labels cannot colour.
2. **The alternating ring for germs only measurable** (`plans/FS132-E4-derivation.md` § Argument — the alternating orbit,
   "Read off it" (ii); sketched, not entered). C132-ALT's measurable form is derived for two adjacent inner-pure points; the
   patterns outer–outer, outer–inner and inner–outer each need a shift lemma of the kind of C132-M-ORBIT's M8 for another
   arrangement of the two gaps — "one derivation stage for a successor" (FS132-E4's report). A second route for two of the four
   cases exists in step form, read off and not entered: C132-SHADOW (`plans/FS132-derivation.md` § 2).
3. **The turning ring for germs only measurable; the third outside label** (`plans/FS132-E4-derivation.md` § Where C132-TURN
   stalls, (ii): "only L7. No derived form" — L7 is the line "open: germs that are only measurable" of the list under C132-PLACE
   in that record; `plans/FS132-E3-derivation.md` § The coordinator's question). FS132-E3's paragraph:
   the transfer and the unit-pair shift carry over to a triangle centre word for word; a region where one label is forced
   survives; the *same* forced label near two ring points 60° apart does not; what there is, in the words
   `plans/FS132-derivation.md` § 9 keeps of it, is "a four-germ relation and a rigidity of the third outside label", unproved,
   "a job of its own". The search's hand argument does not close this:
   its step 3's second rule fails for germs only measurable (`plans/FS132-derivation.md` § 6, SEARCH-1007-TURN3-HAND).
4. **One edge** (`plans/FS132-E4-derivation.md` § Where C132-TURN stalls, (i)), verbatim: *"in a weak six-colouring, at a point
   `y` near which one side of a unit circle through `y` carries `a` and then `b` along the circle and nothing else, does every
   set of witnessed edges closing a cycle at `y` contain the pair `{a, b}`?"* With C132-TURN-EDGE a yes would exclude the
   turning step orbit at points that carry a witnessed cycle. **Read with its history**: the claim it came from, C132-TURN,
   "stands as stalled and is not re-posed in that form" — its poser found that it "attaches data of a unit circle to a point
   defined by its small balls, with nothing joining them" (`plans/FS132-derivation.md` § 8). This form reads circle data at
   `y` only; whether it is worth a card is the asking lane's.

**Not here.** Finiteness of a ring's changes (C132-RING-TAME's first clause) and the existence of a seed: FS-127, FS-128. A
ring point with no pure side — an edge set of `x` on the unit circle about it — and everything at the placed point: FS-124.

## Bearing on the answer

None on the value. It finishes, on the easy side, the list FS-132 began: the ways a six-colouring living on triangle points
alone could spend a ring. In step form with witnesses near the centre, the alternating ring is excluded and the turning ring
places a four-label point; the cases left are germs that are only measurable (questions 2, 3) and witnesses far from the
centre (question 1). Seven by this road needs every one of them to end in an exclusion or in FS-124's object; a seed by
formula in one of them would be a six-coloured local structure outside every map class this project holds. It ranks below
FS-124: the search's one kept model is the other case (its sides read inner at alternate ring points, none outer-pure), and
no statement here applies to it.

## Owed second minds

Every entry named above is one mind's. C132-PLACE (inside C132-LENS and C132-ALT) rests on the release's Lemma 5.2 read
locally — "not verified" by the one later user. The kernel is the second check; none of these is in FS-132's first Lean
module (the first night's exclusion).

## Registered expectations (provisional; instruments, never caps)

Question 2's three shift lemmas derived in one stage: 0.70. Question 1: the far-witness seed excluded outright when every
witness is farther than 2 (the remark made a derivation): 0.60; all sixteen sets decided in one job: 0.30. Question 3: a
derived statement for measurable turning germs within two jobs: 0.20.

## Failure clauses

- If question 1's remark fails (three labels do colour the unit disc weakly), the far-witness seed is a candidate object:
  state it by formula or say what a formula would need.
- If a shift lemma of question 2 is false, the alternating ring survives in measure in that pattern of sides: that is a
  finding for the coordinator at once, since C132-ALT's headline is "excluded in step form".
- Three failed attempts on one question: stop and hand the stalled form back.

## Deliverables

Entries in the deriver's grammar for each question taken, each with its control and planted fault; a dated line under
C132-LENS-II and C132-ALT in `plans/FS132-derivation.md` for whatever is closed.

## Provisional bearings

G91 (the ring's twisted colouring: these are its measurable germs), G83 (the straddle along two unit circles — the kill in
C132-ALT), G95 (a statement about every measurable ring must survive planted slack: test each lemma on the stripe colouring
first), G94 (what a consumer reads: here, three points and the ring), G21 (the second round's clean control counts were the
margin's — run every control at circumradius 1/2 as well as 2/5), G92; rows 148–150; stubs FS-124, FS-127, FS-128, FS-134.

*Since FS-124 (FS124-Z1, the record job, 2026-10-07; every entry named is in `plans/FS124-derivation.md`, [hand] or derived from [hand] entries, **one mind, kernel pending**):* two entries are stated on this stub's data —
exclusion sets at two points, no piece assumed: **C124-HALF** and **C124-HALF-TWO** ([hand] over the inherited C132-WIT-SIDE;
§ 5). With exactly one of the six sets on the unit circle about the common unit point, a neighbourhood of that point on one side
of one circle is split between two labels along the other circle; with one set of each point there, almost every point near it
has one of four labels. C124-HALF's class has one held member, with a one-point set on the circle (fragment S1; a dated
correction stands under the entry in `plans/FS124-E1-derivation.md`). **The line between this stub's arc-free side and the arc is
no wall for a statement that reads pieces**: C124-BOTH and C124-EDGE-CLOSED exclude configurations with a unit arc about a ring
point by the open-piece lemma (C124-SHADOW-OPEN, C124-TYPE) — G97's killing test, fired by its deriver's own scoring; an
amendment to G97 is drafted in `plans/FS124-Z1-record.md`. No entry gives a weak six-colouring a piece.
