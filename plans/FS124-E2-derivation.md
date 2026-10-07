# FS124-E2 — the second round: what it costs a six-colouring to save a close complementary pair: the record

*Job FS124-E2 (brief `data/fs124/briefs/FS124-E2-second-round.md`), 2026-10-07 (UTC). Identity: Ephodos. The round's re-walk of the
grokkings, its prior-art pass, its route and its registered predictions are the dated additions at the end of
`plans/FS124-tight-pairs.md`. This file is the job's record: stages headed "Stage n — SAVED", each committed before the next.
Scripts and outputs: `data/fs124/e2/`. Gate: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-E2-derivation.md`,
from `plans/`.*

## Theorems this phase proved

*One line per theorem, with its grade and its address; filled as each stage is saved. Every one is [hand] or derived from [hand]
entries, **one mind, kernel pending**.*

- **C124-EVERY-DIRECTION** — [hand], one mind — Stage 4, § Argument — every direction (the kernel lane's question).
- **C124-TYPE** — [hand] over the first round's C124-SHADOW-OPEN, one mind — Stage 4, § Argument — one piece, one side.
- **C124-FORCED-PIECES** — derived from C124-TYPE, one mind — Stage 4, § Argument — four regions, six pieces.
- **C124-FORCED** (as posed, for sector points) — derived from it, one mind, one topological input recalled — Stage 4, § Argument — sector points.
- **C124-FORCED-AS-POSED** — **refuted** by the letter: fragment BB with two bands — Stage 4, § Argument — the banded bowtie.
- **C124-FORCED-SEVEN** — [hand] with an exact check, one mind — Stage 4, § Argument — the honeycomb at seven.
- **C124-CENTRE-HALF** — [hand] over the first round's argument, one mind; **C124-LONE** — derived, one mind; **C124-BOTH**, **C124-FOUR** — derived from C124-LONE, one mind — Stage 5, § Argument — the save by one member.
- **C124-LONE-EXISTS** — [hand] on fragment S1's exact check, one mind: a save by one member, at a bowtie, on four flowers and a band — Stage 5.
- **C124-EDGE** (as posed) — [hand], one mind; **C124-EDGE-CLOSED** — [hand] with an exact check, one mind — Stage 6, § Argument — the strip's top edge.
- **C124-SECOND** (for sector points) — derived from C124-BOTH and C124-FOUR, one mind — Stage 6, § Argument — the two points of a pair.
- The reading C124-READ-SAVES is [tools], one mind, and proves nothing: Stage 3.

## Notation used by every entry

`S(p)` is the unit circle about `p`, `B(p, r)` the open disc, `B̄(p, r)` the closed one. A *weak `k`-colouring*, *present*, *tight
for `(a, b)`*: `data/fs124/claims.md` § The class, § The object. A *three-piece point*, a *close complementary pair*, its *common
unit points*, *saved by*, the *pattern*: `data/fs124/claims.md`, the dated line of 13:59 UTC, § Definitions. Added by this record:

- A **decomposition** at a three-piece point `x` is a choice of the neighbourhood `N` and the three disjoint connected open sets
  `P_0, P_1, P_2` of the definition (two open sets with different labels almost everywhere are disjoint). Its **edges** are the
  sets `cl(P_i) ∩ cl(P_j) ∩ N`.
- For a point `w` with `|w − x| = 1`, a piece `P` is **inner at `w`** if `P ⊂ B̄(w, 1)`, **outer at `w`** if `P ∩ B(w, 1) = ∅`, and
  **crossing at `w`** otherwise (it has a point strictly inside and a point strictly outside `S(w)`). A non-empty open set lies on
  no circle, so every piece is exactly one of the three. `x` **separates at `w`** if it has an inner and an outer piece there.
- A three-piece point is **full** (for a decomposition) if for every two of its pieces `x` is a limit of points other than `x` of
  their edge. It is a **sector point** if for some `r > 0` there are three arcs `J_0, J_1, J_2` (homeomorphic images of `[0, 1]`)
  from `x` to the circle `∂B(x, r)`, inside `B(x, r)` but for their far ends and disjoint but for `x`, such that the three
  components of `B(x, r) ∖ (J_0 ∪ J_1 ∪ J_2)` are the pieces. A map's vertex of three tiles is a sector point; a sector point is
  full; a **bowtie** (sectors `a, b, a, c` at the point) is a three-piece point by the letter when its two `a`-sectors are joined
  inside the neighbourhood, and it is not full (the `b`- and `c`-pieces meet at the point only).

## Stage 1 — SAVED: the readback, the re-walk, and the claims as my verdicts will be about them

**The readback and the re-walk** are in `plans/FS124-tight-pairs.md` § Second round: 13 of 13 quotations match
(`data/fs124/e2/quote_check.py`, exit 0; exit 1 with its fault); the grokkings walked from inside the save; the prior-art pass; the
route; five registered predictions. **One finding of the readback, about the card and not the brief's quotations**: the card's
question — must one edge of each member lie on the point's unit circle — is answered for maps by a held result the card does not
cite, FS112-N3-COR3 (row 135; `plans/FS112-derivation.md` l. 158): "each a leaving centre of both `u` and `u′`"; its verification
note has the sentence "**One failure is not enough**" (`plans/FS112-NB3-verification.md` l. 125).

### 1.1 The claims, as stated to the coordinator

*Kept **as posed** unless a line says "restated"; added statements are marked "added" with the reason. Every *not claimed* line is
mine, and every one includes: **that a weak six-colouring has a three-piece point, or a close complementary pair, is not claimed.**
Tags: P = per class (true at every number of labels); X = spends the number six.*

1. **C124-TYPE** (added: the one lemma of the round; C132-WITNESS and C132-WIT-SIDE in one statement, on C124-SHADOW-OPEN alone; P).
   *Let `c` be a weak `k`-colouring of an open set `U`, `P` a connected open subset of `U` almost every point of which has the
   label `i`, `x` a point of the closure of `P`, and `w` a point of `U` with `|w − x| = 1`. If `P` has a point strictly inside
   `S(w)`, there is `η > 0` such that almost every point `z` of `B(w, η)` with `|z − x| > 1` has a label other than `i`; if `P` has
   a point strictly outside `S(w)`, there is `η > 0` such that almost every point `z` of `B(w, η)` with `|z − x| < 1` has a label
   other than `i`.* **Not claimed**: anything for a piece that is not connected or not open; a uniform `η`; anything on the side
   not named.
2. **C124-READ-SAVES** — as posed, with two additions to what is listed (each member's pieces by side of the point's unit circle;
   every vertex of three labels and four sectors with its pairs) and one change of enumeration (vertices from the tiles' own pieces,
   not from the ends of unit arcs). **Not claimed**: anything about objects not held; that the list of held objects is complete.
3. **C124-FORCED** — **restated as two statements**, because as posed it can be defeated by a degenerate case: by the letter of the
   definition two pieces of a three-piece point may meet at the point only (a bowtie whose repeated label is joined inside the
   neighbourhood), their "edge" is then one point, and C132-COMP-SHARP's conclusion is met by that point with no arc.
   - **C124-FORCED-PIECES** (X). *Let `c` be a weak six-colouring of `U`, `(x, y)` a close complementary pair of three-piece points,
     each with a decomposition, and `w` a common unit point of the pair lying in `U`. Then `x` or `y` separates at `w`: one of its
     pieces lies in the closed unit disc about `w` and another is disjoint from the open unit disc about `w`; the edge of those two
     pieces lies on `S(w)`.*
   - **C124-FORCED** (X), as posed, **for sector points**: *if moreover `x` and `y` are sector points, then `w` is saved by `x` or by
     `y`, and for every interior point `z` of the arc so obtained the pair `(w, z)` is tight for the two labels of that edge, in one
     order along the arc.*
   **Not claimed**: the statement as posed for every three-piece point by the letter (at a point that is not full it is not derived,
   and the reading says whether a held fragment refutes it); which member separates; anything with seven labels.
4. **C124-FORCED-SEVEN** (added: the card's "fails at seven", as a statement; a calibration). *In the hexagonal seven-colouring at
   circumradius `2/5` there are two vertices less than 2 apart whose label triples are disjoint, with a common unit point interior
   to a tile of the seventh label; neither vertex separates there and no boundary of the colouring lies on a circle.* **Not
   claimed**: anything at six.
5. **C124-ONE-MEMBER** — **restated as statements with verdicts of their own**; the card's "derive … then decide" is their sum.
   - **C124-LONE** (X). *In the setting of C124-FORCED-PIECES suppose `y` does not separate at `w`. Then `x` has exactly one inner
     piece, one outer piece and one crossing piece at `w`, with labels `a`, `b`; there are a side of `S(y)` and `η > 0` such that
     almost every point of `B(w, η)` on that side has the label `a` if it lies inside `S(x)` and `b` if outside; and there are a
     point `w′ ≠ w` of `S(x)` and `η′ > 0` such that inside `B(x, η′)` the inner piece lies in `B̄(w, 1) ∩ B̄(w′, 1)`, the outer
     piece is disjoint from `B(w, 1) ∪ B(w′, 1)`, and their closures meet at `x` only.*
   - **C124-BOTH** (X). *In the setting of C124-FORCED-PIECES, if `x` and `y` are full, both separate at `w`. If they are sector
     points, each has an edge that contains an arc of `S(w)` with an end at the member: no common unit point of a close
     complementary pair of sector points is saved by one member alone.*
   - The card's derivation (what C124-HALF gives, and "each of `x`, `w` is a centre of an arc through the other") is kept as the
     argument's first half; the step at which no such colouring exists for sector points is named in the entry.
   **Not claimed**: that no weak six-colouring has a save by one member — at a member that is not full nothing is excluded, and
   whether a held bowtie fragment is such an object is read in Stage 3; any exclusion of close complementary pairs; any value.
6. **C124-FOUR** (added: the card reads it — "91 of 91" — and says "the equality is read … not derived"; X). *In the setting of
   C124-FORCED-PIECES let `x` and `y` be full, each with exactly one inner piece, one outer piece and one crossing piece at `w`.
   Then exactly four labels are present at `w`: those of the two inner and the two outer pieces.* **Not claimed**: which label
   fills which of the four regions; anything when a member has two inner or two outer pieces.
7. **C124-EDGE** — first sentence as posed (a computation on the strip); **second sentence restated** once Stage 3 has read what
   "agrees with the strip on `|y| ≤ √15/4`" fixes at the member on the line `y = √15/4` — the restatement is given with the verdict.
   **Not claimed**: anything beyond the strip's family.
8. **C124-SECOND** — as posed, **for sector points** (the class in which "pattern (1, 1)" has its meaning). **Not claimed**: that
   the saves close up; any exclusion.

**Stage 1 — SAVED** (2026-10-07).

*Gate at this stage*: `derive_gate.py all` reports one failure by construction — "no derivation entry" — until Stage 4's first
entry; every later stage is committed with the gate at exit 0.

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh) on the five claims

**The stall read.** No claim has stalled; the card's shape meets three of the skill's conditions. *A clause per case*: the pattern
is a pair of counts with a case per value — (1, 1), (1, 0), "three sets" in fragment T2 — and C124-HALF splits nine side patterns of
two edge sets. *A known theorem that almost applies*: C132-COMP-SHARP's conclusion "one of the six sets … is contained in the unit
circle about w" is met by a one-point set. *A result proved only at instances*: "exactly one edge of each" is read at 94 points of
two objects built by one recipe.

**For a stranger** (a geometer who knows open sets, connectedness and Fubini; no word of this project). *A measurable map from an
open plane set to six labels gives almost no two points at distance 1 the same label. Near a point `x` three connected open sets,
each carrying one label, fill a neighbourhood up to a null set, and `x` is in the closure of each; the same at a point `y` with the
three other labels; `0 < |x − y| < 2`; `w` is a point at distance 1 from both. A connected open set of label `i` with a point at
distance less than 1 from a point `p` and a point at distance more than 1 has a point at distance exactly 1, so `i` is null near
`p`. Which of the six sets can still reach the four regions into which the unit circles about `x` and `y` cut a neighbourhood of
`w`?* **This is a** covering question for four open regions by six sets, each of which is confined to one side of one circle
according to whether a connected set lies in a closed disc, in the complement of the open disc, or in neither. The reader stops at
no word: "edge", "saved", "pattern", "tight" were not needed.

**The features, sorted** (receipt beside each):

| feature | sort | receipt |
|---|---|---|
| each piece is connected and open, with its member in its closure | determines | the intermediate value along a path in the piece; without connectedness a label can sit on both sides of `S(w)` and reach both sides at `w` (the bowtie's repeated label read as one piece) |
| the side of a piece at `w` (inner, outer, crossing) | determines | C124-TYPE; control `quadrant-count`: the count over the four regions is a function of the six sides and of nothing else |
| the edges, as sets | accompanies — it **splits**: consumed only as "two points of the closure of one connected piece" | C132-COMP-SHARP's *uses only* line reads of a set `K` two of its points; an edge that is one point satisfies every hypothesis and carries nothing |
| an edge contains an arc of `S(w)` with an end at the member | accompanies for the count; **determines** for the statement "saved by" | for sector points it is equivalent to an inner and an outer piece meeting along it; at a bowtie the inner and outer pieces meet at the point only and no arc exists |
| six labels | determines | two disjoint triples are all the labels; at seven the honeycomb's seventh label fills the point (C124-FORCED-SEVEN) |
| `0 < |x − y| < 2` | determines | the two circles cross at `w`, so all four regions are non-empty; at distance 2 one is empty (C132-CROSS's fault) |
| the tangent directions of the pieces at the member; curvature of the edges | accompanies | no step reads them: the sides are read on the pieces as sets |
| "exactly one edge of each member" (the card's pattern) | unsorted before the reading; **sorted in Stage 5** | it is the case in which the third piece of each member is crossing |
| the neighbourhood's size; which decomposition | accompanies, with a caution | every statement holds for each decomposition; a point may be full for one and not for another only through connectedness of a piece away from the point |

**The homes** (each tested):

1. *This project's map class* — the object is a close complementary pair of cubic trichromatic vertices, the theorems FS107-W-TAN
   ("a tangent pair or include a bowtie") and FS112-N3-COR3 ("each a leaving centre of both"; "One failure is not enough"), two
   minds on each. **Adopted as the theorem to carry across.** Dictionary: tile ↔ connected open one-label piece; leaving centre of
   `u` ↔ `u` separates at the point; both-kind arc ↔ the edge of an inner and an outer piece; bowtie ↔ a three-piece point that is
   not full; "strip holds on a clean side" ↔ no piece of the member is inner (or none outer). *The old proof's step that must
   change*: N3-COR3 reads tangent directions and side cones of arcs (`±t_u`, N112-U1); a measurable piece has neither. The
   replacement: C124-CENTRE's computation at the member for one neighbour `w′` of `w` — exact unit circles in place of cones.
   *The exceptions vanish*: the patterns (1, 0), (2, 1), "three sets" become one statement about sides. *It predicts a neighbour*:
   the label set at `w` is exactly four when each member has one piece of each side (C124-FOUR) — read by the asking lane, derived
   by nobody.
2. *Last night's exact class* (C132-CROSS, C132-COMP-SHARP: a measurable labelling with exclusion sets, no properness). **Adopted
   for the count only**; its unit (the exclusion set) is the accompaniment the split above removes.
3. *Helly-type or covering arguments for discs* (the four regions as a nerve). **Not adopted**: the count is four lines and names
   no theorem; recalled, not read, and it predicts nothing the direct count does not.

**The transfer.** Theorem read: FS112-N3-COR3 at its statement and its verification paragraph (not its full proof, nor N112-U1).
Hypotheses to discharge here: none is taken from it — the measurable statements are derived from C124-SHADOW-OPEN and C124-CENTRE
(first round, [hand], one mind), so N3-COR3 is prior art and a second route in the map class, not an input. *The remaining step is
not the problem renamed*: after C124-TYPE each claim is a finite count or a computation with two circles.

**The class.** C124-TYPE at every number of labels; the count at six for three-piece points by the letter; the exclusion of a save
by one member for full points; "saved by" and tightness along an arc for sector points. **A recognition that differs from the
card's**: the unit a save is paid in is not an edge on a circle but a pair of pieces on the two sides of it; the card's pattern is
its shadow for sector points, and the card's open branch (a save by one member) is, in measure, exactly the bowtie of the map class.

**Stage 2 — SAVED** (2026-10-07).

## Stage 3 — SAVED: the reading (C124-READ-SAVES), and a relay from the kernel lane addressed first

### 3.0 The relay (FS124-K1, through the coordinator, mid-stage) — read before going on

The kernel lane's planner, typing the first round's radius clause, reports that measurability is idle in the finite-set form, that
the identification of unit pairs with rigid motions is the whole proof, and that (down) holds for every subset; and it asks whether,
for a measurable weak colouring of a measurable set, *every* direction is good. **How it changes this round's work: it does not** —
no statement here reads a fixed direction; every one goes through C124-SHADOW-OPEN, whose fibres are open sets of directions. The
question is answered as an entry, because it is true by four lines and a later statement about one side of one circle may want it:
C124-EVERY-DIRECTION, Stage 4. Its remarks (a)–(e) are the first round's entries' business and go to the report unchanged.

### 3.1 What was read, and how

`data/fs124/e2/saves_read.py` (its header says what it reads and what it cannot see). Vertices are taken from the tiles' own
pieces — every end of a boundary piece — not from the ends of unit arcs; members are the vertices with exactly three labels, with
three sectors (**sector**) or four sectors `a, b, a, c` (**bowtie**); a common unit point is read only if both circles about it are
wholly inside the object. **Grade: [tools], one mind; floats from the objects' exact pieces, boundaries refined by bisection, "on
the circle" decided at `10⁻⁹` at two radii.** Two instrument defects met and repaired before any count was kept, both of which
under-counted and neither of which flattered: the tiles' bounding boxes were tight at an arc's extreme point (two of the disk's arcs
read as not of kind both), and the point location took two rays (now five vote). Outputs: `data/fs124/e2/out/<object>.txt`.

| object | members (sector + bowtie) | pairs | common unit points inside | patterns | who separates | exactly four labels | HALF-TWO's hypothesis | unit arcs of kind both / edges of a save |
|---|---|---|---|---|---|---|---|---|
| FS-112's strip (tiles −4 … 6) | 40 + 0 | 54 | 71 | (1, 1): 71 | both: 71 | 71 of 71 | 71 of 71 | 38 / 38 |
| FS-112's disk | 25 + 0 | 20 | 20 | (1, 1): 20 | both: 20 | 20 of 20 | 20 of 20 | 20 / 15 |
| FS-114's capped strip | 40 + 0 | 54 | 71 | (1, 1): 71 | both: 71 | 71 of 71 | 71 of 71 | 38 / 38 |
| fragment T2 | 2 + 0 | 1 | 2 | (1, 2), (2, 1) | both: 2 | — | — | 4 / 4 |
| the bowtie fragment BB | 0 + 2 | 1 | 2 | (0, 0): 2 | both: 2 | 2 of 2 | — | 0 / 0 |
| fragment S1 | 1 + 1 | 1 | 2 | (0, 0): 2 | **the bowtie alone: 2** | — | — | 4 / 0 |
| fragment MX | 1 + 1 | 1 | 2 | (0, 2), (2, 1) | both: 2 | 1 of 1 | — | 2 / 2 |
| FS116-Y2-SIXFRAG | 6 + 0 | **0** | 0 | — | — | — | — | 18 / 0 |
| the Searcher's kept model | 4 + 0 | 3 | 6 | (1, 1): 3, (1, 2): 1, (2, 1): 2 | both: 6 | 3 of 3 | 3 of 3 | 9 / 9 |
| R7 (seven labels; control) | 0 | 0 | — | — | — | — | — | — |
| the honeycomb at 2/5 (seven; control) | 66 + 0 | 66 | 132 | (0, 0): 132 | nobody: 132 | — | — | — |

("Exactly four labels" is counted where each member has one inner, one outer and one crossing piece; the strip's 71 are the asking
lane's 74 less its three centres on the window's cut; S1 and MX were read beside the brief's list because BB's verdict needs them.)

### 3.2 The statement to verify, and the attack on the card

**On the three maps the statement holds, read whole**: at every common unit point inside the strip, the disk and the capped strip
(71, 20, 71) the pattern is (1, 1), C124-HALF-TWO's hypothesis holds, and the labels present are exactly the four labels of the two
edges. The asking lane's sample counts are **reproduced** (strip 71 of 74 with 3 on the cut; disk 20 of 20), none corrected; every
three-tile vertex of both maps is an end of a unit arc, so its enumeration by arc ends missed no member.

**On the other objects it does not hold as stated, and three objects break the frame.**
1. *Patterns other than (1, 1)*: T2, MX, the kept model (three of its six points), BB, S1 — four of the five objects the card left
   unread, and S1.
2. *A point saved with no edge on its circle*: BB, at both points — each member is a bowtie whose two single-sector pieces lie one
   in the closed unit disc about the point and one outside the open disc, and meet at the member only.
3. *A point saved by one member alone*: S1, at both points — by the bowtie; its partner, a three-sector vertex, has no piece on the
   outer side at one point and none on the inner side at the other. Two labels are present at the point, split along the unit circle
   about the bowtie. No point read is saved by one **sector** member alone (0 of 170 points whose members are both sectors).
4. *A tight arc of kind both that is no edge of a save* — the falsifier of the asking lane's hunch `centres-are-saved-points`:
   **SIXFRAG, 18 of 18** (12 about the six-label vertex, 6 about its four-label ring points) **with no close complementary pair in
   the fragment at all**; **S1, 4 of 4** (centred at the saving bowtie, through the saved point: the boundary a save by one member
   forces *at the point*); **the disk, 5 of 20** (the sides of the central Reuleaux pentagon, whose ends are four-label corners; the
   centres are saved points, the arcs are no member's edge). On the strip, the capped strip, T2, MX and the kept model every one is
   an edge of a save.
So a save is one cause of a tight arc of kind both and not the only one; "exactly one edge of each member" is the law of the two
printed maps and of the capped strip — objects built by one recipe — and of nothing else held.

**What the reading says of the round's route** (pieces by side): at every one of the 176 common unit points read inside a
six-coloured object some member separates; whenever both members are sectors both separate (170 of 170: 71 + 20 + 71 + 2 + 6;
MX and S1 have a bowtie member, BB two); wherever each member has one inner, one outer and one crossing piece exactly those
four labels are present (168 of 168). At seven nobody separates at any of the honeycomb's 132 points, and R7 has no member.

**Predictions scored.** Q1: first part met (71 of 71, 20 of 20); "some object shows another pattern" met; "every three-sector
member separates at every common unit point" **missed as worded** — S1's sector member does not, its partner being a bowtie; the
statement the route derives is for two full members, and there the reading has no exception; "a held fragment saved by a bowtie
alone" met (S1). The asking lane's: its statement on the strip and the disk — met; another pattern on an unread object — met; a
save by one member on a held object — **met, against its 0.1** (S1, which it did not list); every tight arc of kind both on the
unread objects an edge of a save — **missed** (SIXFRAG, as it guessed, and S1).

*The reading's controls are entered with the entries they test (Stages 4–6): `saves-maps`, `saves-fragments`, `saves-lone`,
`saves-r7`, `seven-exact`.*

**Stage 3 — SAVED** (2026-10-07).

## Stage 4 — SAVED: C124-FORCED — the lemma, the count on pieces, the posed form for sector points, its failure by the letter, its failure at seven

*A correction to Stage 3's prose, made here in place: the points whose two members are both sectors number 170 (71 + 20 + 71 + 2 + 6),
not 172 as first written; the table's rows were right.*

derivation: C124-EVERY-DIRECTION
  statement: Let U be a measurable subset of the plane and c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U. Then for every unit vector u, c(z) ≠ c(z + u) for almost every point z of U with z + u in U.
  uses only: that translation is continuous in L² of the plane; Fubini for the pairs (z, u); that a continuous non-negative function vanishing at almost every point of the unit circle vanishes on it; countably many labels and radii
  not claimed: anything for a colouring that is not measurable (the kernel lane's remark is that the finite-set clause needs no measurability; this statement does); anything at distances other than 1; any use in this round — no entry below reads a fixed direction
  argument: § Argument — every direction
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring at circumradius 2/5 on the plane: for every unit vector u no point z at all has the label of z + u (tiles of diameter 4/5, same-label tiles more than 1 apart: C124-KIND's margins, first round)
  prior art: partly: by the kernel lane's planner it is the argument of a lemma of `[OAIMath2026]` for the whole plane (its relay, 2026-10-07; not read by me); the restriction to a measurable subset is the same four lines
  handoff: de Bruijn — only with a consumer; the planner asked the question, and the statement to read back is "for every unit vector, almost every point"

derivation: C124-TYPE
  statement: Let c be a weak k-colouring of an open set U, P a connected open subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with |w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| < 1 has a label other than i.
  uses only: C124-SHADOW-OPEN (`plans/FS124-E1-derivation.md` Stage 4; [hand], one mind — inherited, its argument read whole) for W = P; that a connected open set is path-connected; the intermediate value theorem for the distance to z along a path; that x is a limit of points of P
  not claimed: anything for a piece that is not connected or not open; a uniform η over pieces or over the point of P chosen; anything on the side not named; that any weak colouring has such a piece
  argument: § Argument — one piece, one side
  verdict: derived
  grade: hand
  minds: 1
  model: FS-112's strip at w = (0, 0), x = (1/2, √3/2): its three tiles there read inner (P), outer (O) and crossing (G), and at w the label P is read only inside S(x), O only outside, G nowhere (control `saves-maps`, Stage 5: 71 points, four labels each)
  prior art: partly: it is C132-WITNESS followed by C132-WIT-SIDE (`plans/FS132-derivation.md` § 2; statements read, arguments not) in one statement on C124-SHADOW-OPEN; for maps the edge exclusion (`[SokolovVoronov2025]` Props. 1–2 by row 134, not read by me); this form not found in print (the plan's §PA, second round)
  handoff: de Bruijn — the statement as written, after C124-SHADOW-OPEN: a path, one intermediate value, one inclusion in a set of the form W + S¹

derivation: C124-FORCED-PIECES
  statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w).
  uses only: C124-TYPE for the six pieces; that a non-empty open set lies on no circle, so each piece has a point strictly inside or strictly outside S(w); that 0 < |x − y| < 2 makes w − x and w − y linearly independent, so the four regions cut at w by S(x) and S(y) are non-empty and open; that two disjoint triples of six labels are all the labels; one identity of propositional logic
  not claimed: that a weak six-colouring has a three-piece point, or a close complementary pair; which member separates, or that both do (C124-BOTH needs full members; in fragment S1 one does not); that the edge of the two pieces is more than the member itself (at a bowtie it is not); anything with seven labels (C124-FORCED-SEVEN)
  argument: § Argument — four regions, six pieces
  verdict: derived
  grade: derived from: C124-TYPE
  minds: 1
  model: fragment T2 at w = (1/2, √3/2): x = (0, 0) has two outer pieces and one inner, y = (1, 0) one of each side; fragment BB: both members bowties, each with one inner and one outer piece meeting at the member only (control `saves-fragments`)
  prior art: partly: C132-COMP-SHARP (`plans/FS132-derivation.md` § 4, one mind) is the statement on exclusion sets, whose conclusion a one-point set satisfies; for maps FS107-W-TAN ("a tangent pair or include a bowtie", `plans/FS107-derivation.md` l. 100) and FS112-N3-COR3 (row 135); the piece form, in measure, not found in print
  handoff: de Bruijn — the statement as written, after C124-TYPE: six applications, four non-empty open regions, and (A ∨ C)(A ∨ D)(B ∨ C)(B ∨ D) = AB ∨ CD. Read the formal statement back against "inside the closed disc" and "disjoint from the open disc" — not against "an edge lies on the circle"

derivation: C124-FORCED
  statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of sector points and w a common unit point of the pair lying in U. Then w is saved by x or by y; and for every interior point z of the arc so obtained the pair (w, z) is tight for the two labels of that edge, in one order along the arc.
  uses only: C124-FORCED-PIECES; for a sector point, that each of the three arcs of its decomposition lies in the closure of exactly two of the three components and that every two components share one arc (the θ-curve form of the Jordan–Schoenflies theorem: recalled, not read); that a connected subset of a circle containing two points contains an arc between them; that an open subset of a closed disc lies in the open disc
  not claimed: that a weak six-colouring has a sector point, or a close complementary pair; the same for every three-piece point by the letter (C124-FORCED-AS-POSED: refuted); that only one edge lies on S(w) (fragment T2 and the kept model have two at one member); that the arc is maximal or where it ends
  argument: § Argument — sector points
  verdict: derived
  grade: derived from: C124-FORCED-PIECES
  minds: 1
  model: the strip, the disk, the capped strip, fragment T2 and the kept model: at each of their 170 common unit points inside, both members are sectors and each has an edge on the point's unit circle (controls `saves-maps`, `saves-fragments`)
  prior art: partly: for maps it is half of FS112-N3-COR3 (row 135: each corner "a leaving centre of both"; two minds, one blind); in measure, posed by the asking lane's card (`plans/STUB-q-ring.md`, the section after the first round); not found in print
  handoff: de Bruijn — after C124-FORCED-PIECES, and only if the kernel lane wants the map-shaped corollary: its one topological input is the θ-curve lemma, which is not in the statement of C124-FORCED-PIECES

derivation: C124-FORCED-AS-POSED
  statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points and w a common unit point of the pair lying in U. Then w is saved by x or by y; and for every interior point z of the arc so obtained the pair (w, z) is tight for the two labels of that edge, in one order along the arc.
  uses only: the definitions of the claim list, read by the letter; fragment BB of FS110-FRAGS (`tools/fs110_y_fragments.py`, valid by FS110-Y's exact checker: control `seam-fragments` of `plans/FS132-derivation.md` § 4 prints ACCEPT); two bands, each inside a disc of radius 3/10 about a member
  not claimed: that the posed statement fails for sector points or for full points (C124-FORCED: derived); that the banded fragment extends beyond its flowers and bands; anything about a three-piece point whose pieces stay connected in every small disc about it
  argument: § Argument — the banded bowtie
  verdict: refuted: fragment BB with each bowtie's repeated label joined by a band — both members are three-piece points by the letter, their labels are 1, 2, 3 and 4, 5, 6, they are 1 apart, and no edge of either contains an arc of a circle
  grade: hand
  minds: 1
  model: the object itself: at both common unit points the reader finds no boundary of either member on the point's unit circle, and both members separating (control `saves-fragments`: "BB … patterns=00:2 separating=xy(bb):2")
  prior art: partly: the bowtie as the exception is FS107-W-TAN's and C132-COMP-SHARP's *not claimed* line ("fragments S1, BB and MX … are valid with one"); the letter of the card's definition admitting it is this job's reading
  handoff: none — a refuted statement; what crosses is C124-FORCED-PIECES

derivation: C124-FORCED-SEVEN
  statement: In the hexagonal seven-colouring at circumradius 2/5 there are two vertices less than 2 apart whose label triples are disjoint, with a common unit point interior to a tile of the seventh label; neither vertex separates there and no boundary of the colouring lies on a circle.
  uses only: the colouring (hexagon about m(2√3/5, 0) + n(√3/5, 3/5) coloured (m + 3n) mod 7); exact arithmetic in ℚ(√3, √2); that two of the three 120° sectors at a vertex share a segment, which lies on no circle, against C124-FORCED-PIECES's last clause
  not claimed: anything at six; that a seven-colouring cannot have a separating vertex (C124-KIND's capped honeycomb has unit arcs)
  argument: § Argument — the honeycomb at seven
  verdict: derived
  grade: hand
  minds: 1
  model: x the common vertex of the hexagons (0, 0), (1, 0), (0, 1), labels 0, 1, 3; y the common vertex of (−1, 1), (−2, 2), (−1, 2), labels 2, 4, 5; |x − y|² = 28/25; a common unit point strictly inside the inscribed disc of the hexagon (0, 2), of label 6 (control `seven-exact`); and over a window, 66 such pairs and 132 points, none with a separating member (Stage 3's table)
  prior art: partly: C132-CROSS's control `hex7-crossings` (`plans/FS132-derivation.md` § 4: 342 vertex pairs, "a label outside both triangles always exists"); as the failure of a save at seven, posed by the card
  handoff: none — a calibration; it crosses only if the kernel lane wants the count's sharpness in six stated

### Argument — every direction

Fix a label `i` and `R > 0`; let `f` be the indicator of `c⁻¹(i) ∩ B(0, R)`, a function in `L²`. Then `g(v) = ∫ f(z) f(z + v) dz` is
continuous in `v` (Cauchy–Schwarz and the continuity of translation in `L²`) and non-negative. The set of pairs `(z, u)` with `z`,
`z + u` in `U` and `c(z) = c(z + u)` is null, so for almost every unit vector `u` its section is null, and `g(u)` is at most the
measure of that section: `g(u) = 0` for almost every `u` of the unit circle, hence on a dense subset of it, hence on all of it. So
for every unit `u` the points `z` with `z`, `z + u` in `c⁻¹(i) ∩ B(0, R)` form a null set; take the union over the labels and over
integer `R`. ∎

### Argument — one piece, one side

Let `q ∈ P` with `|q − w| < 1` and `η = (1 − |q − w|)/2`, small enough that `B(w, η) ⊂ U`. Let `z ∈ B(w, η)` with `|z − x| > 1`.
Then `|z − q| < 1`; and since `x` is a limit of points of `P`, some `x₁ ∈ P` has `|z − x₁| > 1`. A path in `P` from `q` to `x₁`
carries the distance to `z` from below 1 to above 1, so it has a point at distance exactly 1 from `z`: `S(z)` meets `P`. By
C124-SHADOW-OPEN almost every point of `U` whose unit circle meets `P` has a label other than `i`. The other case is the same with
the inequalities reversed (`q` strictly outside, `η = (|q − w| − 1)/2`, `|z − x| < 1`, `x₁` with `|z − x₁| < 1`). ∎

### Argument — four regions, six pieces

Each piece is open and non-empty, so it has a point off `S(w)`; an inner piece then has a point strictly inside, an outer piece a
point strictly outside, a crossing piece both. By C124-TYPE, with `η` the least of the radii it gives: near `w` the label of an
inner piece of `x` is absent outside `S(x)`, that of an outer piece inside `S(x)`, that of a crossing piece on both sides; the same
for `y` and `S(y)`. The unit vectors `w − x`, `w − y` are independent, so each of the four sets `{z ∈ B(w, η) : ±(|z − x| − 1) > 0,
±(|z − y| − 1) > 0}` is open and non-empty; almost every point of it has one of the six labels, and every label is the label of
exactly one of the six pieces. A point inside `S(x)` and inside `S(y)` can only carry the label of an inner piece of `x` or of an
inner piece of `y`; and so for the three other regions. Write `A`, `B` for "`x` has an inner piece", "`x` has an outer piece", and
`C`, `D` the same for `y`: all four of `A ∨ C`, `A ∨ D`, `B ∨ C`, `B ∨ D` hold, and their conjunction is `AB ∨ CD`. If `P ⊂ B̄(w, 1)`
and `P′ ∩ B(w, 1) = ∅`, then `cl(P) ∩ cl(P′)` lies in the closed disc and in the complement of the open one: on `S(w)`. ∎

### Argument — sector points

Let `x` be the member that separates, with inner piece `P_i`, outer piece `P_j`, and `J` the arc of its decomposition that the two
components share. `J ⊂ cl(P_i) ∩ cl(P_j) ⊂ S(w)` (C124-FORCED-PIECES); `J` is connected and contains `x` and a point at distance `r`
from it, so it contains an arc of `S(w)` with an end at `x`: `w` is saved by `x`. Let `z` be an interior point of that arc. Choose
`ρ` with `B(z, ρ) ⊂ B(x, r)`, with `B(z, ρ)` missing the two other arcs of the decomposition, and with `S(w) ∩ B(z, ρ) ⊂ J`. Then
`B(z, ρ) ∖ S(w)` has two components, each connected and disjoint from the three arcs, so each inside one piece. `P_i` is an open
subset of the closed disc, hence of the open disc; it meets `B(z, ρ)` because `z ∈ cl(P_i)`; so the component inside `S(w)` lies in
`P_i`. Likewise the component outside lies in `P_j`. So `(w, z)` is tight for (the label of `P_i`, the label of `P_j`) — the same
ordered pair at every interior point. ∎

### Argument — the banded bowtie

Fragment BB has, at `u = (0, 0)`, four tiles inside `B̄(u, 1/4)`: two rhombi of label 1 about the directions 0° and 180°, a triangle
of label 2 in the sector (60°, 120°) and one of label 3 in (240°, 300°); at `v = (1, 0)` the point reflection of these about
`(1/2, 0)` with labels 4, 4, 5, 6; at `w = (1/2, √3/2)` and `w′ = (1/2, −√3/2)` four quadrants with the labels 2, 3, 5, 6. Add the
band `β_u = {z : |arg(z − u)| < 2°, 1/5 < |z − u| < 3/10} ∪ {z : 13/50 < |z − u| < 3/10} ∪ {z : |arg(z − u) − 180°| < 2°, 1/5 <
|z − u| < 3/10}` with the label 1, and its reflection `β_v` with the label 4. Inside `B̄(u, 1/4)` the band lies in the two rhombi
(at distance `t` from `u` along the axis a rhombus has half-width `(1/4 − t)√3`, the band `t sin 2°`); outside it meets no tile. Every
point of label 1 lies in `B̄(u, 3/10)`, of diameter `3/5 < 1`, and every point of label 4 in `B̄(v, 3/10)`; so the monochromatic unit
pairs of the banded colouring are those of BB, a null set (its exact check). It is a weak six-colouring of the union `U` of the
flowers' interiors and the bands. The interior of (the flower at `u` together with the closure of `β_u`) is a neighbourhood of `u`
that is, up to the null set of the tiles' sides, the union of three connected open sets — the two rhombi's interiors with `β_u`; the
triangle of label 2; the triangle of label 3 — each with `u` in its closure, with three labels: `u` is a three-piece point by the
letter, and so is `v`. The six labels are distinct and `|u − v| = 1`. The edges at `u` are two pairs of segments and the single
point `u`: none contains an arc of a circle. So `w` is saved by neither member, in the claim list's sense. ∎ (In the sense of
C124-FORCED-PIECES both members separate at `w`: the triangle of label 2 is inner, that of label 3 outer.)

### Argument — the honeycomb at seven

The three hexagons at a vertex have the labels `c, c + 1, c + 3` (a vertex below a hexagon) or `c + 1, c + 3, c + 4` (above one),
`c = m + 3n` modulo 7. For the two vertices of the model the triples are `{0, 1, 3}` and `{2, 4, 5}`, the squared distance is
`28/25 < 4`, and one of the two common unit points lies strictly inside the inscribed disc of the hexagon `(0, 2)`, of label
`6` — all exact (control `seven-exact`). Near that point the colouring is constant with a label of neither vertex. Every two of the
three pieces at a vertex share a segment; an inner and an outer piece would share a boundary on `S(w)`. ∎

control: quadrant-count
  of: C124-FORCED-PIECES — the count as a function of the six sides alone: over the 729 assignments of inner, outer, crossing to the six pieces, the number in which "each of the four regions has a piece of its side at x or at y" differs from "x or y has an inner and an outer piece"; the fault lets a crossing piece of x serve its regions
  run: python3 -c "import itertools as I;print(sum(all(any(s==a for s in p[:3]) or any(s==b for s in p[3:]) for a in 'io' for b in 'io')!=(('i' in p[:3] and 'o' in p[:3]) or ('i' in p[3:] and 'o' in p[3:])) for p in I.product('ioc',repeat=6)))"
  expect: 0
  fault: python3 -c "import itertools as I;print(sum(all(any(s in a+'c' for s in p[:3]) or any(s==b for s in p[3:]) for a in 'io' for b in 'io')!=(('i' in p[:3] and 'o' in p[:3]) or ('i' in p[3:] and 'o' in p[3:])) for p in I.product('ioc',repeat=6)))"

control: saves-fragments
  of: C124-FORCED-PIECES — the reader on fragments T2, BB and MX and on the Searcher's kept model: members (sectors + bowties), pairs, common unit points inside, patterns (edges of x, edges of y on the point's circle), who separates (x, y, by member kind), the four-label count, C124-HALF-TWO's hypothesis, unit arcs of kind both and how many are edges of saves. Tight on these models: none has a margin. The fault moves every common unit point by 0.01
  run: python3 ../data/fs124/e2/saves_read.py T2 BB MX kept --brief
  expect: T2: members=2s+0b pairs=1 inside=2 patterns=12:1,21:1 separating=xy(ss):2 four=0/0 half-two=0/0 arcs-of-kind-both=4 edges-of-saves=4
    BB: members=0s+2b pairs=1 inside=2 patterns=00:2 separating=xy(bb):2 four=2/2 half-two=0/0 arcs-of-kind-both=0 edges-of-saves=0
    MX: members=1s+1b pairs=1 inside=2 patterns=02:1,21:1 separating=xy(bs):2 four=1/1 half-two=0/0 arcs-of-kind-both=2 edges-of-saves=2
    kept: members=4s+0b pairs=3 inside=6 patterns=11:3,12:1,21:2 separating=xy(ss):6 four=3/3 half-two=3/3 arcs-of-kind-both=9 edges-of-saves=9
  fault: python3 ../data/fs124/e2/saves_read.py T2 BB MX kept --brief --fault

control: saves-r7
  of: C124-FORCED-PIECES — where the hypothesis is not met it must not be read as met: R7 on 49 lattice points has no vertex of three labels, so no member and no pair; the fault reads the honeycomb at 2/5 with the same reader (66 members)
  run: python3 ../data/fs124/e2/saves_read.py r7 --brief
  expect: r7: members=0s+0b pairs=0 inside=0 patterns=none separating=none four=0/0 half-two=0/0
  fault: python3 ../data/fs124/e2/saves_read.py hex7 --brief

control: seven-exact
  of: C124-FORCED-SEVEN — exact, in sympy: the two vertices, their triples, their squared distance, and the common unit point strictly inside the inscribed disc of a hexagon of the seventh label; the fault pairs the first vertex only with vertices of its own orientation, whose triples always meet
  run: python3 ../data/fs124/e2/edge_check.py seven
  expect: circumradius=2/5 x=up(0,0) x-labels=[0, 1, 3] y=down(-2,1) y-labels=[2, 4, 5] squared-distance=28/25 common-unit-point-strictly-inside-the-inscribed-disc-of-hexagon=(0, 2) of-label=6 seven: OK
  fault: python3 ../data/fs124/e2/edge_check.py seven --fault

**What rests on these.** C124-TYPE is the round's one tool: every later entry is six applications of it and a count, or one of
C124-CENTRE's computations beside it. C124-FORCED-PIECES is the statement to build on and to formalize; C124-FORCED is its shadow
for sector points and the form the card posed. **Predictions scored**: Q2 — met on all three parts (the piece form derived; the
posed form derived for sector points; by the letter it fails where two pieces meet only at the member — exhibited). The asking
lane's "derived as posed 0.8, restated at its wording 0.15": the second.

**Stage 4 — SAVED** (2026-10-07).

## Stage 5 — SAVED: C124-ONE-MEMBER — the save by one member: what it forces, where it is excluded, where it exists; and the labels at a saved point

derivation: C124-CENTRE-HALF
  statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| < 1 has a label other than a.
  uses only: the argument of C124-CENTRE (`plans/FS124-E1-derivation.md` § Argument — the centre, the straddle, the antipode, "The centre": [hand], one mind — inherited, read whole), which treats its two sentences separately, each from one collar and C124-SHADOW-OPEN
  not claimed: anything about the other collar; that (q, z) is tight
  argument: § Argument — the save by one member
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at a lattice point, as C124-CENTRE's (first round, control `r7-tight`): each of its two counts there is one half of this statement
  prior art: partly: it is C124-CENTRE with its hypothesis split (G92); C132-SHADOW with a radial direction
  handoff: de Bruijn — state C124-CENTRE in this form: one collar, one conclusion; the two-collar statement is its conjunction

derivation: C124-LONE
  statement: In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only.
  uses only: C124-TYPE for the six pieces; C124-CENTRE-HALF at the centre x for one far end w′ of S(x) near w, strictly on the chosen side of S(y); that two distinct unit circles through x that are not tangent there cut every small disc about x into four non-empty open sets and meet near x at x only; that the three pieces fill a neighbourhood of x up to a null set
  not claimed: that a weak six-colouring has a three-piece point, or a close complementary pair; that such a configuration is impossible — it is fragment S1's (C124-LONE-EXISTS); anything about the edges of the crossing piece (one of them may lie on S(w)); that (x, w′) is tight on both sides of S(y)
  argument: § Argument — the save by one member
  verdict: derived
  grade: derived from: C124-FORCED-PIECES, C124-CENTRE-HALF
  minds: 1
  model: fragment S1 at w = (1/2, √3/2): y = (1, 0) has pieces crossing, inner, crossing; x = (0, 0) has the piece of label 2 inner, of label 3 outer, of label 1 crossing; the labels at w are 2 and 3, split along S(x); the pieces of labels 2 and 3 are the opposite sectors (60°, 120°) and (240°, 300°) and meet at x only (control `saves-lone`)
  prior art: partly: for maps it is the content of FS112-N3-COR3's step "One failure is not enough" (`plans/FS112-NB3-verification.md` ll. 125–128: side cones of arcs against N112-U1; statement and that paragraph read, the lemmas under it not) and of FS107-W-TAN's alternative "or include a bowtie"; in measure, with unit circles in place of side cones, not found in print
  handoff: de Bruijn — the statement as written, after C124-FORCED-PIECES and C124-CENTRE-HALF: a case split on (inner, outer) counts (1, 2), (2, 1), (1, 1) and two inclusions

derivation: C124-BOTH
  statement: In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone.
  uses only: C124-LONE in both orders; the definition of full; for sector points the argument of C124-FORCED and that a sector point is full
  not claimed: that a weak six-colouring has a full three-piece point, or a close complementary pair; that exactly one edge of each member lies on S(w) (T2, the kept model: two at one member); anything when a member is not full (S1: one member saves alone)
  argument: § Argument — the save by one member
  verdict: derived
  grade: derived from: C124-LONE
  minds: 1
  model: FS-112's strip and disk and FS-114's capped strip: at each of their 71, 20 and 71 common unit points inside, both members are sectors and both separate, with one edge of each on the point's circle (control `saves-maps`)
  prior art: partly: for maps FS112-N3-COR3 (row 135; [hand], two minds, one blind: "each a leaving centre of both u and u′") — this is its form for a weak measurable colouring and full three-piece points, by another route; not found in print
  handoff: de Bruijn — the statement's first sentence, after C124-LONE; the second sentence with C124-FORCED's topological input

derivation: C124-LONE-EXISTS
  statement: There is a weak six-colouring of an open set U, by formula, with a close complementary pair (x, y) of three-piece points and a common unit point w of the pair in U at which y does not separate.
  uses only: fragment S1 of FS110-FRAGS (`tools/fs110_y_fragments.py`; valid by FS110-Y's exact checker: control `seam-fragments` of `plans/FS132-derivation.md` § 4 prints ACCEPT for S1); the band β_u of C124-FORCED-AS-POSED's argument, which S1's bowtie admits unchanged (the same four tiles at u, label 1 repeated, no label 1 elsewhere)
  not claimed: a value of the chromatic number of the plane — the object lives on four flowers of radius at most about 1/4 and one band and fixes none; that it extends to any larger set; a save by one member at a full member (C124-BOTH excludes it); the card's pattern "exactly one edge of x on the circle" — here no edge of x lies on S(w); that x is a three-piece point in any sense but the letter's (its repeated label is connected only through the band)
  argument: § Argument — the save by one member
  verdict: derived
  grade: hand
  minds: 1
  model: the object itself: x = (0, 0) a bowtie with labels 1 (two sectors, joined by the band), 2, 3; y = (1, 0) a sector point with labels 4, 5, 6; w = (1/2, √3/2); near w only the labels 2 and 3, inside and outside S(x) (control `saves-lone`)
  prior art: known: the fragment is FS110-Y2's S1 ("a bowtie u whose unit circle carries two boundary arcs … through w and w′; v generic trivalent", row 134's "exact local fragments of every seam"); read as a save by one member, and joined so as to be a three-piece point by the letter, here
  handoff: none — a local object; it is the model that keeps C124-LONE from being a statement over an empty class

derivation: C124-FOUR
  statement: In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces.
  uses only: C124-TYPE (at most those four); the second half of C124-LONE's argument applied to a side of S(y), or of S(x), on which one of the four labels is absent; fullness of both members
  not claimed: that a weak six-colouring has a full three-piece point, or a close complementary pair; which label fills which of the four regions, or that each region carries one label; anything when a member has two inner or two outer pieces (T2: five labels allowed, four present)
  argument: § Argument — the save by one member
  verdict: derived
  grade: derived from: C124-LONE
  minds: 1
  model: the strip at w = (0, 0) with x = (1/2, √3/2), y = (1/2, −√3/2): labels P, O, M, B present, G and R (the crossing pieces') absent; and 168 of 168 such points over the held objects (controls `saves-maps`, `saves-fragments`)
  prior art: partly: for maps FS112-N3-COR3's "vertices of at least four colours" (row 135); the equality was read by the asking lane ("91 of 91", `plans/POROS-2026-10-07-fs124-round1.md` § 1.3) with the remark that it "is read … not derived" (`plans/STUB-q-ring.md`, the section after the first round); C124-HALF-TWO (first round) is the upper bound
  handoff: de Bruijn — after C124-LONE; with C124-TYPE it is the first statement of this milestone that determines a point's label set from a count on six

### Argument — the save by one member

*The half-collar (C124-CENTRE-HALF).* The first round's argument for C124-CENTRE shows, for `p ∈ B(q, η)`: if `|p − z| > 1` the
point of `S(p)` on the segment from `p` to `z` lies in `B(z, ρ) ∩ B(q, 1)`, and if `|p − z| < 1` the point of `S(p)` beyond `z` on
that line lies in `B(z, ρ) ∖ B̄(q, 1)`. Each sentence then follows from C124-SHADOW-OPEN for that one open set. ∎

*Step I — the half-window at `w` (C124-LONE).* `y` has no inner piece or no outer piece. In the first case each of its pieces has
a point strictly outside `S(w)`, so by C124-TYPE its three labels are absent near `w` inside `S(y)`; in the second, outside `S(y)`.
Call that side `Σ` (inside a ball `B(w, η)` on which all six applications of C124-TYPE hold). On `Σ` almost every point has a label
of `x`; the label of a crossing piece is absent, that of an inner piece absent outside `S(x)`, that of an outer piece absent inside
`S(x)`. `Σ ∩ B(x, 1)` and `Σ ∖ B̄(x, 1)` are non-empty and open, so `x` has an inner and an outer piece: its sides are (inner,
outer) = (1, 1) with one crossing piece, or (1, 2), or (2, 1).

*Step II — the two circles at `x`.* Take `w′ ∈ S(x) ∩ B(w, η)` strictly on the side `Σ` of `S(y)` (`S(x)` crosses `S(y)` at `w`),
`w′ ≠ w`, and `ρ` with `B(w′, ρ) ⊂ B(w, η)` on that side. If `x` has one inner piece `P_a`, almost every point of `B(w′, ρ) ∩
B(x, 1)` has the label `a`, and C124-CENTRE-HALF gives `η′` with: almost every `p ∈ B(x, η′)` with `|p − w′| > 1` has a label other
than `a`; `P_a` being open with the label `a` almost everywhere, `P_a ∩ B(x, η′) ⊂ B̄(w′, 1)`. If `x` has one outer piece `P_b`,
likewise `P_b ∩ B(x, η′) ∩ B(w′, 1) = ∅`. Take `η′ ≤ 1/2` and inside the neighbourhood of the decomposition. The unit vectors
`w − x`, `w′ − x` are independent, so `D = {p ∈ B(x, η′) : |p − w| < 1 < |p − w′|}` and `E = {p ∈ B(x, η′) : |p − w′| < 1 < |p − w|}`
are non-empty open sets. *Sides (1, 2)*: no point of `D` is in `P_a` (it is outside `B̄(w′, 1)`) nor in an outer piece (it is
inside `B(w, 1)`); so the non-empty open set `D` lies in the null set the pieces leave: impossible. *Sides (2, 1)*: the same for
`E`, which misses `P_b` (inside `B(w′, 1)`) and both inner pieces (outside `B̄(w, 1)`). *Sides (1, 1)*: both inclusions hold;
`cl(P_a) ∩ cl(P_b) ∩ B(x, η′)` lies in both closed discs and in neither open disc, so on `S(w) ∩ S(w′)`, whose second point is at
distance `2 cos(∠wxw′/2) ≥ √3` from `x`: it is `{x}`. (And `D`, `E` lie in the crossing piece up to null sets.) ∎

*Both (C124-BOTH).* If `y` did not separate, C124-LONE would make `x` an isolated point of the edge of its inner and outer pieces,
against fullness of `x`; and the same with the names exchanged. For sector points every two components share an arc of the
decomposition (C124-FORCED's input), so a sector point is full, and the argument of C124-FORCED gives each member its arc of `S(w)`.
**This is the named step at which no save by one member exists for sector points: the saving edge lies in the closures of the inner
and the outer piece, and the half-window puts those closures in two opposite lenses that meet at the member only.** The card's
derivation is Step I and the first inclusion of Step II in its words: `(x, w′)` is tight for `(a, b)` on the half-window; `(w, z)`
is tight for `(a, b)` along the edge (C124-FORCED); "each of `x`, `w` is a centre of an arc through the other" — and C124-CENTRE-HALF
at `x` then forbids the label `b` just outside `S(w)` on one side of `x` along `S(w)` and the label `a` just inside it on the other.

*The object (C124-LONE-EXISTS).* S1's four tiles at `u = (0, 0)` are BB's (read from the loader: the same four polygons, labels 1,
1, 2, 3, inside `B̄(u, 1/4)`); `v = (1, 0)` has three sectors with labels 4, 5, 6; at `w` and `w′` two labels, 2 and 3, across the
unit circle about `u`. With `β_u` labelled 1 — the label 1 occurs nowhere else, and `β_u` meets no other flower (it lies in
`B̄(u, 3/10)`; the flower at `w` lies beyond distance `3/4` from `u`) — the colouring is weak on the union `U` of the flowers'
interiors and the band, `u` is a three-piece point by the letter, `v` is a sector point, the labels are complementary, `|u − v| = 1`,
and at `w` the member `v` has no outer piece. ∎ **What it is and is not**: a weak six-colouring of four small flowers and a band;
checked by FS110-Y's exact checker for S1 and by the diameter of the label 1's set for the band; it shows that C124-LONE's class is
inhabited at a member that is not full, and nothing about any larger set or any value.

*Four labels (C124-FOUR).* By C124-TYPE only the labels `a, b` of `x`'s inner and outer pieces and `a′, b′` of `y`'s can be present
at `w`, each on its side. Suppose `a′` is absent on a ball about `w`. Inside `S(y)` the label `b′` is absent too, so there almost
every point has the label `a` inside `S(x)` and `b` outside: Step II applies to that side and makes `x` an isolated point of the
edge of `P_a` and `P_b` — against fullness of `x`. If `b′` is absent, the same on the side outside `S(y)`; if `a` or `b` is absent,
the same with the members exchanged, against fullness of `y`. ∎

control: saves-lone
  of: C124-LONE-EXISTS — the reader on fragment S1: one sector member and one bowtie member, one pair, both common unit points inside, no boundary of either member on the point's circle, the bowtie alone separating ("x-(bs)": the first member, a bowtie, separates; the second, a sector, does not). The fault moves the two points by 0.01 (nobody separates)
  run: python3 ../data/fs124/e2/saves_read.py S1 --brief
  expect: S1: members=1s+1b pairs=1 inside=2 patterns=00:2 separating=x-(bs):2 four=0/0 half-two=0/0 arcs-of-kind-both=4 edges-of-saves=0
  fault: python3 ../data/fs124/e2/saves_read.py S1 --brief --fault

control: saves-maps
  of: C124-BOTH — the reader on FS-112's strip and disk and FS-114's capped strip, each read whole from its tiles: at every common unit point inside, the pattern, who separates, the four-label count where each member has one piece of each side, C124-HALF-TWO's hypothesis, and the unit arcs of kind both against the edges of saves. Tight on these models: none has a margin. The fault moves every common unit point by 0.01
  run: python3 ../data/fs124/e2/saves_read.py strip disk capped --brief
  expect: strip: members=40s+0b pairs=54 inside=71 patterns=11:71 separating=xy(ss):71 four=71/71 half-two=71/71 arcs-of-kind-both=38 edges-of-saves=38
    disk: members=25s+0b pairs=20 inside=20 patterns=11:20 separating=xy(ss):20 four=20/20 half-two=20/20 arcs-of-kind-both=20 edges-of-saves=15
    capped: members=40s+0b pairs=54 inside=71 patterns=11:71 separating=xy(ss):71 four=71/71 half-two=71/71 arcs-of-kind-both=38 edges-of-saves=38
  fault: python3 ../data/fs124/e2/saves_read.py strip disk capped --brief --fault

**Read against the card.** Its ask — "must one edge of each member lie on its unit circle?" — is answered **yes for sector
points** (a map's three-tile vertices) and for every pair of full members in the piece sense, **no in general**: the exception is
exactly a member whose inner and outer pieces meet at the member only, and S1 is one. Of its three branches it is the first ("one
edge of each member is forced"), for the class in which its pattern has a meaning, with the second branch's object existing only
outside that class and with no edge on the circle. Its registered 0.45 for an object "on a neighbourhood of the rhombus" and 0.2
for "excluded" were both posed without row 135's FS112-N3-COR3, which had the map-class answer. **C124-HALF** (first round) is not
a statement over an empty class: S1 meets its hypothesis with the one-point set `{x}` as the set on the circle — which is also why
its conclusion there carries no arc. **Predictions scored**: Q3 — met (excluded for full members; no object at a full member). Q4's
third part — met (C124-FOUR derived).

**Stage 5 — SAVED** (2026-10-07).

## Stage 6 — SAVED: C124-EDGE, C124-SECOND; the sweeps; where a successor takes over

derivation: C124-EDGE
  statement: On FS-112's strip, let w be a point of the top edge y = √15/4 + √3/2 that is a common unit point of a close complementary pair of the strip's three-piece points. Then the member of the pair on the line y = √3/2 has no edge free for the unit circle about w: its three edges lie on the unit circles about two midline vertices and on a vertical wall. Hence a weak six-colouring of a neighbourhood of the closed strip that agrees with the strip on |y| ≤ √15/4 saves no such w by both members.
  uses only: the strip's tiles (`tools/fs112_yb2_objects.py`): the vertex (m/2, √3/2) has the edges x = m/2 below it and the arcs of the unit circles about ((m − 1)/2, 0) and ((m + 1)/2, 0) above it; that two tiles of the top half sharing an arch label or a top label rule out every pair but a vertex on y = √3/2 with a vertex on y = √15/4; that a segment lies on no circle and w is no midline vertex
  not claimed: anything beyond the strip's family; that the top edge is open to a save by the other member — it is not (C124-EDGE-CLOSED); the bottom edge except by the mirror, which this job did not check against the strip's labels
  argument: § Argument — the strip's top edge
  verdict: derived
  grade: hand
  minds: 1
  model: w = (1/4, √15/4 + √3/2) with the pairs (1/2, √3/2), (−1/4, √15/4) and (0, √3/2), (3/4, √15/4) — the card's smallest form (control `edge-exact`: w is at distance 1 from all four)
  prior art: known: row 136's stop ("each stops at the unsaved second common unit point of a close complementary pair saved at its first", FS112-STOP, FS112-EDGE) says it for the strip as a map; the asking lane computed the member's edges by hand (`plans/POROS-2026-10-07-fs124-round1.md` § 1.3)
  handoff: none — a computation on one held object; subsumed by C124-EDGE-CLOSED

derivation: C124-EDGE-CLOSED
  statement: There is no weak six-colouring of an open set that contains the point w = (1/4, √15/4 + √3/2), the three arches U_{−1}, U_0, U_1 of FS-112's strip and the parts of its tiles T_0, T_1, T_2 below the line y = √15/4, and that gives almost every point of each of these six sets the strip's label.
  uses only: C124-TYPE six times, with the members (1/2, √3/2) for U_0, U_1 and the part of T_1, (−1/4, √15/4) for U_{−1} and the part of T_0, (3/4, √15/4) for the part of T_2; exact comparisons in ℚ(√3, √15) (control `edge-exact`); that the six labels are distinct and are all the labels
  not claimed: anything about colourings that change the strip below y = √15/4; anything at seven (a seventh label takes the point); the same at the points (1/4 + k/2, √15/4 + √3/2) except through the strip's translation by 1/2, which permutes its labels (not checked against the label tables by this job beyond k = 0); that no six-coloured object extends above the strip's top edge
  argument: § Argument — the strip's top edge
  verdict: derived
  grade: hand
  minds: 1
  model: the strip itself, which stops at w: its own tiles carry no label into the open set near w in the directions between arcsin(1/4) and 30° above the top edge (row 136's colourless cone is (arcsin ¼, 180° − arcsin ¼))
  prior art: partly: for extensions of the strip as a map that keep all its tiles it is FS112-EDGE ("no valid extension of the strip holds a neighbourhood of Q", `tools/fs114_y_dial.py`'s header; row 136); for every weak measurable six-colouring that keeps only the part below y = √15/4, here — not found in print
  handoff: de Bruijn — only with a consumer: six instances of C124-TYPE with explicit points; it is the first exclusion in this milestone of every weak six-colouring of a named open set by first-order tools

derivation: C124-SECOND
  statement: In the setting of C124-FORCED for sector points let both common unit points w, w′ lie in U, each with pattern (1, 1). Then the edge of x on the unit circle about w and its edge on the unit circle about w′ are different edges, and the edge of y on the unit circle about w and its edge on the unit circle about w′ are different edges; the labels present at w and those present at w′ are two sets of four with exactly two labels in common, one of each member; their absent pairs are disjoint; and the six labels have a cyclic order in which the three pairs read at w (the two edges, the absent pair) and the three read at w′ alternate.
  uses only: C124-BOTH and C124-FOUR at both points; that with exactly one edge of a sector member on S(w) its third piece is crossing (an inner or outer third piece would put a second arc of the decomposition on S(w)); that an arc from x has nested initial pieces, and two distinct circles share at most two points; a count over 36 label patterns
  not claimed: that a weak six-colouring has a sector point, or a close complementary pair; that the saves close up along a chain of pairs; any exclusion; anything when a pattern is not (1, 1) (T2: (2, 1) and (1, 2))
  argument: § Argument — the two points of a pair
  verdict: derived
  grade: derived from: C124-BOTH, C124-FOUR
  minds: 1
  model: the strip's pair x = (1/2, √3/2) (labels G, O, P), y = (1/2, −√3/2) (B, M, R): at (0, 0) the edges P|O and M|B, absent G, R; at (1, 0) the edges G|O and R|B, absent P, M; common labels O and B; the cyclic order P, O, G, R, B, M (`data/fs124/e2/out/strip.txt`, the two rows of that pair)
  prior art: partly: posed by the asking lane with the strip's order; C124-HALF-TWO (first round) for the upper bound on the labels; not found in print
  handoff: de Bruijn — after C124-FOUR: a finite count; the statement to read back is the alternation, not only "different edges"

### Argument — the strip's top edge

*As posed.* In the top half the three-tile vertices are the valleys `V_m = (m/2, √3/2)` (tiles `T_m`, `U_{m−1}`, `U_m`) and the
apexes `A_j = (j/2 + 1/4, √15/4)` (tiles `U_j`, `T_j`, `T_{j+1}`); two valleys share an arch label or have four arch labels among
three, two apexes likewise for the top labels, so a pair with a common unit point on the top edge is a valley with an apex. The
edges at `V_m` are the wall `x = m/2` and arcs of the unit circles about `P_{m−1}` and `P_{m+1}` (`P_j = (j/2, 0)`); `w` is neither
point and a segment lies on no circle. ∎

*Closed.* Write `V_1 = (1/2, √3/2)`, `A_{−1} = (−1/4, √15/4)`, `A_1 = (3/4, √15/4)`; all three are at distance 1 from `w`. Each
arch has a point strictly inside and a point strictly outside `S(w)` — `U_0`: `(1/4, 9/10)`, `(1/4, 1/10)`; `U_1`: `(51/100, 87/100)`,
`(3/4, 1/10)`; `U_{−1}`: `(−1/100, 87/100)`, `(−1/4, 1/10)` — and has `V_1` (for `U_0`, `U_1`) or `A_{−1}` (for `U_{−1}`) in its
closure; so by C124-TYPE the three arch labels are absent on a ball about `w`. The part of `T_1` below the line is the open region
bounded by the arc `V_1 A_0` of `S(P_0)`, the arc `V_1 A_1` of `S(P_2)` and the segment `A_0 A_1`; it is connected, has `V_1` in its
closure and points strictly inside `S(w)` (near `A_0`, at distance `√3/2` from `w`): its label is absent near `w` outside `S(V_1)`.
The part of `T_0`, its mirror image in the line `x = 1/4`, has `A_{−1}` in its closure and points strictly inside `S(w)`: its label
is absent near `w` outside `S(A_{−1})`. The part of `T_2` has `A_1` in its closure and points strictly outside `S(w)` (near
`V_2 = (1, √3/2)`, at squared distance `3/2`): its label is absent near `w` inside `S(A_1)`. The points `w + t(12, 5)/13`, `t > 0`
small, are outside `S(V_1)`, outside `S(A_{−1})` and inside `S(A_1)` (the three scalar products have the signs `+, +, −`), and
these conditions are open: on a non-empty open set all six labels are absent. ∎ **So the card's branch "the strip cannot be
continued upward with its two rows kept" holds with no hypothesis on the continuation** — it needs neither C124-BOTH nor any
regularity above the line.

### Argument — the two points of a pair

At each point both members separate (C124-BOTH) and, the pattern being (1, 1), each has one inner, one outer and one crossing piece:
were the third piece inner or outer, it and the piece of the opposite side would share an arc of the decomposition lying on the
circle, a second edge. So C124-FOUR gives the four labels at each point: those of the two saving edges. The saving edge of `x` at
`w` is the arc of its decomposition shared by its inner and outer pieces there, and begins with an arc of `S(w)`; if the same arc of
the decomposition served at `w′`, it would begin with an arc of `S(w′)`, and of two initial pieces of one arc one contains the
other — a non-trivial arc on two distinct circles. So `x`'s two saving edges are different arcs, their label pairs are two different
pairs out of three labels, and they share exactly one label; the same for `y`. The rest is the count of control `second-count`: in
each of the 36 patterns the two label sets share exactly two labels, the absent pairs are disjoint, and the six pairs form one
hexagon whose sides alternate between the two points. ∎

control: edge-exact
  of: C124-EDGE-CLOSED — exact, in sympy: w at distance 1 from the four members; the circles about the midline vertices meeting S(w) at the members; the sides of the six kept pieces at named points; the direction (12, 5)/13; the six labels read from the strip's own tiles. The fault reads the point w + (1/50, 0)
  run: python3 ../data/fs124/e2/edge_check.py edge
  expect: w-at-distance-1-from-V1,V0,A-1,A1=True circles-meet-S(w)-at-the-members=True T1-part-inner=[-1, -1, -1] T0-part-inner=[-1, -1, -1] T2-part-has-a-point-outside=True arches-crossing=[True, True, True] direction-(12,5)/13:outside-S(V1),outside-S(A-1),inside-S(A1)=True labels-T0,T1,T2,U-1,U0,U1=ROMBPG edge: OK
  fault: python3 ../data/fs124/e2/edge_check.py edge --fault

control: second-count
  of: C124-SECOND — the 36 label patterns with different saving edges at the two points: labels in common, disjoint absent pairs, one alternating hexagon; the fault allows the same edge of x at both points (then three labels can be common)
  run: python3 ../data/fs124/e2/edge_check.py second
  expect: cases=36 labels-in-common=[2] absent-pairs-disjoint=36 one-alternating-hexagon=36 second: OK
  fault: python3 ../data/fs124/e2/edge_check.py second --fault

**Predictions scored.** Q4 — met on all three parts (the top-edge computation as read; C124-SECOND derived for sector points;
C124-FOUR derived). Q5 — **met**: G97's killing test fires in its second clause twice — C124-BOTH excludes a unit-arc configuration
(the save by one sector member) by first-order tools, and C124-EDGE-CLOSED excludes every weak six-colouring of a named open set.
The asking lane's: C124-ONE-MEMBER "an object by formula 0.45, excluded 0.2, a gap 0.35" — excluded in the class where its pattern
has a meaning, an object only at a bowtie; C124-EDGE "holds as read 0.7" — met; C124-SECOND "derived as posed 0.9" — met for sector
points; "one edge of each member forced 0.2" — that branch.

### The sweeps a successor needs (the record job's are not this job's)

- **What is carried and not yet drawn.** (1) C124-TYPE with a *region's own two members*: a connected one-label piece whose closure
  holds two points `p, p′` at distance 1 from `w` is barred near `w` outside both `S(p)` and `S(p′)` if it has a point inside
  `S(w)` — used in C124-EDGE-CLOSED; as a general statement it is the "tile through two ring points" rule and is not entered.
  (2) C124-LONE's lenses are a statement about any half-window, with no pair: *wherever `(x, w′)` is tight for `(a, b)` on a set of
  far ends accumulating at `w`, no boundary between `a` and `b` runs along `S(w)` into `x` with `a` inside* — a per-class
  reciprocity rule, true at every number of labels; it is why R7's mutual centres carry different outside labels. Not entered.
  (3) C124-EDGE-CLOSED's method — keep some pieces, bar all six labels on an open set — is a finite computation for any held
  object's stop: the disk's ten rim points are the next instance (not run).
- **For the asking lane.** The unit "a save" is right for the three maps and wrong as the *only* source of tight arcs of kind both
  (SIXFRAG: 18 with no pair). What the six-label vertex's ring is, in this round's terms, is not derived. The search drafted as
  queue line 14 (a save by one member in the wedge family) is answered without a search for sector flowers (C124-BOTH: none) —
  a `declined` line is drafted in the report.
- **For the kernel lane.** The module after C124-SHADOW-OPEN: C124-TYPE, C124-CENTRE-HALF, C124-FORCED-PIECES, C124-LONE,
  C124-BOTH (first sentence), C124-FOUR. No θ-curve lemma is needed for any of them.

**Where a successor takes over.** Every claim of the round is at a verdict. Owed, in order of bearing: (1) a second mind on
C124-LONE's Step II (the one new argument); (2) the full-member class against the map class — whether every vertex of a locally
finite arc map with three labels and three sectors is a sector point in this record's sense when a tile has a cusp there (row
133's "GAP at cusp vertices"): the definition used here asks only for three arcs from the point, and a cusp is allowed; not
examined on an object with cusps; (3) the disk's rim by C124-EDGE-CLOSED's method; (4) the prior-art debts of both rounds.

**Stage 6 — SAVED** (2026-10-07).

*Gate on the whole record at the hand-back*: 14 entries (13 derived, 1 refuted), 8 controls, 8 faults fired, `GATE: PASS (0 failures, 0 warnings)`, exit 0 (`data/fs124/e2/out/gate-final.txt`). The run takes over two minutes because the three maps are read twice; each control is within 120 seconds. **An order slip, said here**: Stage 6 was appended while Stage 5's gate ran, and the two stages are in one commit.
