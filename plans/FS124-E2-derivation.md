# FS124-E2 — the second round: what it costs a six-colouring to save a close complementary pair: the record

*Job FS124-E2 (brief `data/fs124/briefs/FS124-E2-second-round.md`), 2026-10-07 (UTC). Identity: Ephodos. The round's re-walk of the
grokkings, its prior-art pass, its route and its registered predictions are the dated additions at the end of
`plans/FS124-tight-pairs.md`. This file is the job's record: stages headed "Stage n — SAVED", each committed before the next.
Scripts and outputs: `data/fs124/e2/`. Gate: `python3 ../.claude/skills/ephodos/scripts/derive_gate.py all FS124-E2-derivation.md`,
from `plans/`.*

## Theorems this phase proved

*One line per theorem, with its grade and its address; filled as each stage is saved. Every one is [hand] or derived from [hand]
entries, **one mind, kernel pending**.*

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
