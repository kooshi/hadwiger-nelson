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
