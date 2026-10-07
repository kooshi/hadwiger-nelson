# FS-124 — the kernel lane's claim list, second module (what one piece of a colour forces at distance 1; a close complementary pair)

*Fixed by Keryx, 2026-10-07 (15:15 UTC), for the kernel lane's planner: definitions, and the statements with their not-claimed
lines, copied by script from the derivers' entries and the claim list's definitions, and nothing else — no grade, no route, no
model. `S(p)` is the unit circle about `p`, `B(p, r)` the open disc, `B̄(p, r)` the closed one; "almost every" is for plane
Lebesgue measure, and for pairs of a point and a unit vector the product of Lebesgue measure and arc length. In the order the
planner takes them. A later change is a dated line at the end.*

**The class.** A *weak `k`-colouring* of an open set `U` of the plane is a measurable map `c` from `U` to `k` labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit vector `u` with `z + u` in `U` (the wording of `plans/FS132-derivation.md`'s entries). A label is *present* at a point when the point lies in the closed essential support of its class.

**The object, stated once.** Let `c` be a weak colouring of `U`, `q` and `z` two points with `|q − z| = 1` and `z` in `U`, and `a ≠ b` two labels. The pair `(q, z)` is **tight for `(a, b)`** when there is `ρ > 0` with `B(z, ρ) ⊂ U` such that almost every point `w` of `B(z, ρ)` with `|w − q| < 1` has the label `a` and almost every point `w` of `B(z, ρ)` with `|w − q| > 1` has the label `b`. `q` is the pair's **centre**, `z` its **far end**, `a` its inside label, `b` its outside label; the two points `q + R^{±1}(z − q)`, `R` the rotation by `π/3`, are its **rhombus completions** (each is at distance 1 from both `q` and `z`). The pair is **of kind both** when `a` and `b` are both present at `q`. In a map a boundary arc of the unit circle about `q` is a tight pair at each of its interior points, with no dictionary: a tile is an open set of one label. The map class's (Q) arc is a tight pair of kind both whose centre carries at least four colours; FS-132's two appearances, (α) and (β), are a tight pair read from its centre and from its far end (`plans/POROS-2026-10-07-fs124-question.md` § 1.2).

For a tight pair `(q, z)` with radius `ρ`, its **collars** are the open sets `W_a = B(z, ρ) ∩ B(q, 1)` (label `a` almost everywhere) and `W_b = B(z, ρ) ∖ B̄(q, 1)` (label `b` almost everywhere).

**Definitions, stated once.** `c` is a weak six-colouring of an open set `U` (the class of the section above). A **three-piece point** is a point `x` of `U` with a neighbourhood that is, up to a null set, the union of three connected open sets, each with `x` in its closure and one label almost everywhere, the three labels distinct; its **edges** are the three common boundaries of two of the pieces near `x`. A **close complementary pair** is two three-piece points `x`, `y` with `0 < |x − y| < 2` whose six labels are distinct. Its **common unit points** are the two points `w` with `|w − x| = |w − y| = 1`. A common unit point `w` in `U` is **saved by `x`** when some edge of `x` contains an arc of the unit circle about `w` with an end at `x`; the **pattern** at `w` is the pair (number of such edges of `x`, number of such edges of `y`). A map's vertex of three tiles is a three-piece point with no dictionary.

- A **decomposition** at a three-piece point `x` is a choice of the neighbourhood `N` and the three disjoint connected open sets `P_0, P_1, P_2` of the definition (two open sets with different labels almost everywhere are disjoint). Its **edges** are the sets `cl(P_i) ∩ cl(P_j) ∩ N`.

- For a point `w` with `|w − x| = 1`, a piece `P` is **inner at `w`** if `P ⊂ B̄(w, 1)`, **outer at `w`** if `P ∩ B(w, 1) = ∅`, and **crossing at `w`** otherwise (it has a point strictly inside and a point strictly outside `S(w)`). A non-empty open set lies on no circle, so every piece is exactly one of the three. `x` **separates at `w`** if it has an inner and an outer piece there.

- A three-piece point is **full** (for a decomposition) if for every two of its pieces `x` is a limit of points other than `x` of their edge. It is a **sector point** if for some `r > 0` there are three arcs `J_0, J_1, J_2` (homeomorphic images of `[0, 1]`) from `x` to the circle `∂B(x, r)`, inside `B(x, r)` but for their far ends and disjoint but for `x`, such that the three components of `B(x, r) ∖ (J_0 ∪ J_1 ∪ J_2)` are the pieces. A map's vertex of three tiles is a sector point; a sector point is full; a **bowtie** (sectors `a, b, a, c` at the point) is a three-piece point by the letter when its two `a`-sectors are joined inside the neighbourhood, and it is not full (the `b`- and `c`-pieces meet at the point only).

**C124-SHADOW-OPEN** — statement: Let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i.

*Not claimed (C124-SHADOW-OPEN):* anything for a set W that is not open; anything at a point whose unit circle meets only the boundary of W; that any weak colouring has an open one-label set

**C124-CENTRE-HALF** — statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| < 1 has a label other than a.

*Not claimed (C124-CENTRE-HALF):* anything about the other collar; that (q, z) is tight

**C124-CENTRE** — statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with |w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b.

*Not claimed (C124-CENTRE):* that a or b is present at q (C124-KIND: neither need be); anything about the other labels near q; that this is all a tight pair forces at q — with a second tight far end z′ for the same (a, b) the conclusions intersect, and near q the label a is confined to B̄(z, 1) ∩ B̄(z′, 1), a region with angle π − ∠zqz′ at q

**C124-STRADDLE** — statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has a label other than a and other than b.

*Not claimed (C124-STRADDLE):* a uniform η as p tends to q or to 2z − q (it tends to 0); anything at those two points (C124-CENTRE, C124-ANTIPODE); anything that reads the radius of the interface — for an interface of any shape the statement at a point whose unit circle crosses it is C132-WITNESS's

**C124-TYPE** — statement: Let c be a weak k-colouring of an open set U, P a connected open subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with |w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| < 1 has a label other than i.

*Not claimed (C124-TYPE):* anything for a piece that is not connected or not open; a uniform η over pieces or over the point of P chosen; anything on the side not named; that any weak colouring has such a piece

**C124-FORCED-PIECES** — statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w).

*Not claimed (C124-FORCED-PIECES):* that a weak six-colouring has a three-piece point, or a close complementary pair; which member separates, or that both do (C124-BOTH needs full members; in fragment S1 one does not); that the edge of the two pieces is more than the member itself (at a bowtie it is not); anything with seven labels (C124-FORCED-SEVEN)

**C124-LONE** — statement: In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only.

*Not claimed (C124-LONE):* that a weak six-colouring has a three-piece point, or a close complementary pair; that such a configuration is impossible — it is fragment S1's (C124-LONE-EXISTS); anything about the edges of the crossing piece (one of them may lie on S(w)); that (x, w′) is tight on both sides of S(y)

**C124-BOTH** — statement: In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone.

*Not claimed (C124-BOTH):* that a weak six-colouring has a full three-piece point, or a close complementary pair; that exactly one edge of each member lies on S(w) (T2, the kept model: two at one member); anything when a member is not full (S1: one member saves alone)

**C124-FOUR** — statement: In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces.

*Not claimed (C124-FOUR):* that a weak six-colouring has a full three-piece point, or a close complementary pair; which label fills which of the four regions, or that each region carries one label; anything when a member has two inner or two outer pieces (T2: five labels allowed, four present)
