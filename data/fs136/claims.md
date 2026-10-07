# FS-136 — the claim list

*Fixed by Keryx, 2026-10-07 (15:51 UTC), from the asking lane's question card (`plans/STUB-covering-pairs.md` § The question
(Poros, 2026-10-07); record `plans/POROS-2026-10-07-fs124-round2.md`), by script: the definitions and the five first claims —
each claim as posed up to its controls, with the name the stub writes C- read C136-; nothing of its controls, the held entry
it would restate, or its side (those are in the stub). **Every statement here is posed, none derived.** A weak six-colouring
of an open set `U` is a measurable map from `U` to six labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of
`U` and a unit vector `u` with `z + u` in `U` (`data/fs124/claims.md` § The class). In the order the deriver takes them. Each
claim's *not claimed* line is stated by the deriver in its plan before it derives, and fixed here by a dated line; any other
change is a dated line at the end.*

**Definitions, stated once.** `c` is a weak six-colouring of an open set `U`. A **piece** is a connected open subset of `U` almost every point of which has one label. A **pieced point** is a point `x` of `U` with a neighbourhood that is, up to a null set, the union of finitely many disjoint pieces, each with `x` in its closure; its **labels** are its pieces' labels (a three-piece point of FS-124 is one with three pieces and three labels). For `|w − x| = 1` a piece of `x` is **inner at `w`** if it lies in the closed unit disc about `w`, **outer at `w`** if it misses the open one, **crossing** otherwise; `x` **separates at `w`** if it has an inner and an outer piece there (`plans/FS124-E2-derivation.md` § Notation). A **covering pair** is two pieced points `x`, `y` with `0 < |x − y| < 2` such that each of the six labels is a label of `x` or of `y`. Its **common unit points** are the two points one unit from both. For a point `p`, a covering pair **on the ring of `p`** is one with `|x − p| = |y − p| = 1`; `p` is then one common unit point and **the point across** is the other.

**C136-RINGS-READ** (a reading; first) — as posed: On every held six-coloured object — FS-112's strip and disk, FS-114's capped strip and its bowtie fragment FS114-Y2-BOWTIE, FS116-Y2-SIXFRAG, fragments T2, S1, MX, BB, the Searcher's kept model — at every point of four or more labels: the pieced points of three or more labels on its unit circle; the covering pairs among them; for each, whether the point across is inside the object; if it is, who separates there and the labels present; if not, its distance from the centre. *Statement to verify*: on each object and at each such centre, the least distance of a point across not inside the object equals the radius the object attains about that centre (strip and capped strip `φ²/√2`; disk `φ`; the flower's family `√3`).

**C136-COVER** (spends six) — as posed: *Let `c` be a weak six-colouring of `U`, `(x, y)` a covering pair of pieced points and `w` a common unit point of the pair lying in `U`. Then `x` or `y` separates at `w`.* *Smallest form*: the argument of C124-FORCED-PIECES, which reads "every label is the label of a piece of `x` or of `y`" and nowhere "two disjoint triples".

**C136-ONE** (spends six) — as posed: *A pieced point `p` carrying all six labels separates at every point `w` of its unit circle in `U`, and near `w` almost every point inside the unit circle about `p` has the label of a piece of `p` inner at `w`, almost every point outside the label of one outer at `w`.*

**C136-PARTNERS** (spends six) — as posed: *A sector point `x` has at most three points `w` such that an edge of `x` begins with an arc of the unit circle about `w`; every close complementary sector partner `y` of `x` both of whose common unit points lie in `U` is `w_i + w_j − x` for two of them; so `x` has at most three such partners.*

**C136-STOP** (spends six; the card's claim on held rings) — as posed: For the nearest point across `p′` on the disk (a rim point) and on the flower (`√3 e(60j)`): no weak six-colouring of an open set containing `p′` keeps the named regions at `p`, `x` and `y`. *Smallest form*: C124-EDGE-CLOSED's method — six uses of C124-TYPE and exact comparisons.
