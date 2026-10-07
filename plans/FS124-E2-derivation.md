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
   about the bowtie. No point read is saved by one **sector** member alone (0 of 172 points whose members are both sectors).
4. *A tight arc of kind both that is no edge of a save* — the falsifier of the asking lane's hunch `centres-are-saved-points`:
   **SIXFRAG, 18 of 18** (12 about the six-label vertex, 6 about its four-label ring points) **with no close complementary pair in
   the fragment at all**; **S1, 4 of 4** (centred at the saving bowtie, through the saved point: the boundary a save by one member
   forces *at the point*); **the disk, 5 of 20** (the sides of the central Reuleaux pentagon, whose ends are four-label corners; the
   centres are saved points, the arcs are no member's edge). On the strip, the capped strip, T2, MX and the kept model every one is
   an edge of a save.
So a save is one cause of a tight arc of kind both and not the only one; "exactly one edge of each member" is the law of the two
printed maps and of the capped strip — objects built by one recipe — and of nothing else held.

**What the reading says of the round's route** (pieces by side): at every one of the 176 common unit points read inside a
six-coloured object some member separates; whenever both members are sectors both separate (172 of 172: 71 + 20 + 71 + 2 + 6 + MX's
none — MX and S1 have a bowtie member, BB two); wherever each member has one inner, one outer and one crossing piece exactly those
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
