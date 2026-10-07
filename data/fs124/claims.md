# FS-124 — the claim list

*Fixed by Keryx, 2026-10-07 (12:49 UTC), from the asking lane's question card (`plans/STUB-q-ring.md` § The question (Poros,
2026-10-07); record `plans/POROS-2026-10-07-fs124-question.md`), by script: the class, the object, and the six first claims —
each claim's statement and its smallest form, as posed, and nothing of its expected route, its controls or its side (those are
in the stub). **Every statement here is posed, none derived.** In the order the deriver takes them. Each claim's *not claimed*
line is stated by the deriver in its plan before it derives, and fixed here by a dated line; any other change is a dated line
at the end.*

**The class.** A *weak `k`-colouring* of an open set `U` of the plane is a measurable map `c` from `U` to `k` labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit vector `u` with `z + u` in `U` (the wording of `plans/FS132-derivation.md`'s entries). A label is *present* at a point when the point lies in the closed essential support of its class.

**The object, stated once.** Let `c` be a weak colouring of `U`, `q` and `z` two points with `|q − z| = 1` and `z` in `U`, and `a ≠ b` two labels. The pair `(q, z)` is **tight for `(a, b)`** when there is `ρ > 0` with `B(z, ρ) ⊂ U` such that almost every point `w` of `B(z, ρ)` with `|w − q| < 1` has the label `a` and almost every point `w` of `B(z, ρ)` with `|w − q| > 1` has the label `b`. `q` is the pair's **centre**, `z` its **far end**, `a` its inside label, `b` its outside label; the two points `q + R^{±1}(z − q)`, `R` the rotation by `π/3`, are its **rhombus completions** (each is at distance 1 from both `q` and `z`). The pair is **of kind both** when `a` and `b` are both present at `q`. In a map a boundary arc of the unit circle about `q` is a tight pair at each of its interior points, with no dictionary: a tile is an open set of one label. The map class's (Q) arc is a tight pair of kind both whose centre carries at least four colours; FS-132's two appearances, (α) and (β), are a tight pair read from its centre and from its far end (`plans/POROS-2026-10-07-fs124-question.md` § 1.2).

**C124-RADIUS** (the YES side's clause; C132-RADIUS re-posed as two statements) — statement: *(up)* For every integer `k ≥ 1`: if for every `R > 0` the open disc of radius `R` about the origin has a weak measurable `k`-colouring, then every finite unit-distance graph in the plane has a proper `k`-colouring, and `χ(ℝ²) ≤ k`. *(down)* If `χ(ℝ²) ≤ 6`, every open disc has a weak measurable six-colouring.

*Smallest form of (up) (C124-RADIUS):* one finite unit-distance graph of diameter `D`, one disc of radius above `D`: among the rigid motions carrying the graph into the disc, those making an edge monochromatic form a null set.

**C124-CENTRE** (no side: the object's first property, at every `k`) — statement: Let `c` be a weak `k`-colouring of an open set `U`, `q` and `z` points of `U` with `|q − z| = 1`, and `(q, z)` tight for `(a, b)`. Then there is `η > 0` such that almost every point `w` of `B(q, η)` with `|w − z| > 1` has a label other than `a`, and almost every point `w` of `B(q, η)` with `|w − z| < 1` has a label other than `b`.

*Smallest form (C124-CENTRE):* one of the two sentences — it is C132-SHADOW (`plans/FS132-derivation.md` § 2) with `p = q`, `p′ = z`, the open piece on one side of the arc and `v` radial.

**C124-COMPLETION** (decides between: the first thing a tight pair passes on, at every `k`) — statement: Let `c` be a weak `k`-colouring of `U`, `(q, z)` tight for `(a, b)`, and `w` a rhombus completion of the pair lying in `U`. Then there is `η > 0` such that almost every point of `B(w, η)` has a label other than `a` and other than `b`.

*Smallest form (C124-COMPLETION):* one label, one side of the unit circle about `z` near `w` — C132-SHADOW with `p = w`, `p′ = z`, the half-disc of `a` at `z`, and a direction `v` in it with `v·(z − w) > 0`; then one with `v·(z − w) < 0`.

**C124-KIND** (a calibration: is "of kind both" a property or a hypothesis?) — statement: There is a weak measurable seven-colouring of the plane, by formula, with a tight pair `(q, z)` for `(a, b)` at which neither `a` nor `b` is present at `q`.

*Smallest form (C124-KIND):* the hexagonal seven-colouring at circumradius `2/5` with one straight edge replaced, inside its margin, by an arc of the unit circle about a point whose neighbourhood carries neither tile's label; an exact check of the two margins.

**C124-SIX** (decides between: the first statement on the arc's side that reads no ring label) — statement: Let `k ≥ 4`, `U` an open set containing the closed unit disc about `q`, `c` a weak `k`-colouring of `U`, `ψ` an angle, `z_j = q + e(ψ + jπ/3)` for `j = 0, …, 5`, and `a, b, a′, b′` four distinct labels such that for `j = 0, 2, 4` the pair `(q, z_j)` is tight for `(a, b)` or for `(b, a)`, and for `j = 1, 3, 5` the pair `(q, z_j)` is tight for `(a′, b′)` or for `(b′, a′)`. Then a label other than `a, b, a′, b′` is present at `q`.

*Smallest form (C124-SIX):* three pairs — if `(q, z_0)`, `(q, z_2)`, `(q, z_4)` are tight for `(a, b)` or `(b, a)`, then near `q` almost every point of label `a` lies in the intersection of the closed unit discs about the `z_j` at which `a` is the inside label and of the complements of the open unit discs about the others, a set that is `{q}` when the three agree and has angle `π/3` at `q` when they do not.

**C124-HALF** (the NO side: row 135's rhombus in measure, first half; C132-ARC with its sides named) — statement: In the setting of C132-COMP-SHARP (`plans/FS132-derivation.md` § 4), suppose exactly one of the six sets, `K_0`, a set of `x` with labels `t_0, t_1`, is contained in the unit circle about the common unit point `w`, and at least two of the three sets of `y` have a point strictly inside the unit circle about `w`. Then, after exchanging the names `t_0, t_1` if need be, there is `η > 0` such that almost every point of `B(w, η)` outside the unit circle about `y` has the label `t_1` if it lies inside the unit circle about `x` and the label `t_0` if it lies outside it.

*Smallest form (C124-HALF):* `x`'s two other sets are blocked on opposite sides of the unit circle about `w` (else a quadrant at `w` has no label left: C132-CROSS).

*Second statement, two sets (C124-HALF):* if exactly `K_0` and one set `K′_0` of `y`, with labels `t′_0, t′_1`, are contained in the unit circle about `w`, `x`'s two other sets have points strictly on opposite sides of that circle, and `y`'s two other sets likewise, then almost every point near `w` has one of the four labels `t_0, t_1, t′_0, t′_1`.

*Not asked here (C124-HALF):* that a label of `y` is present at `w` — the map class's "four-colour corners", forced there (row 135) and open in measure; it is the first thing the skeleton round asks.

- **2026-10-07 (13:11 UTC; after FS124-E1's first message, commit `1524a765`; FS-124 inventory item 6): each claim's statement
  as its verdict will be about it, with its *not claimed* line — copied by script from the deriver's record,
  `plans/FS124-E1-derivation.md` § 1.1, whole and in its order.** Six claims are kept as posed (C124-RADIUS (up), C124-CENTRE,
  C124-COMPLETION, C124-KIND, C124-SIX, C124-HALF); **one is restated** — C124-RADIUS (down), at every number of colours and
  every open set, of which the claim as posed is an instance; **seven are added**, each with the deriver's reason:
  C124-RADIUS-GRAPH, C124-RADIUS-FIVE, C124-SHADOW-OPEN, C124-OPEN, C124-STRADDLE, C124-ANTIPODE, C124-SIX-CONES. Its tags:
  P, true at every number of labels and silent alone on six against seven; X, spends the count. **Posed, none derived.**

  1. **C124-RADIUS-GRAPH** (added: the relay under (up), and the form the kernel lane should plan; P). *Let `k ≥ 1`, `U` an open set of the plane, `c` a weak `k`-colouring of `U`, and `V` a finite subset of `U`. Then the rigid motions `g` with `g(V) ⊂ U` form a non-empty open set, and for almost every one of them the points `g(v)`, `g(v′)` have different labels for every two points `v, v′` of `V` at distance 1; so the unit-distance graph on `V` has a proper `k`-colouring.* **Not claimed**: anything for an infinite `V`; that any open set has a weak `k`-colouring; a bound on the measure of the good motions beyond "full".

  2. **C124-RADIUS (up)** — as posed. **Not claimed**: an explicit radius at any `k`; the converse, which is (down) and uses an import; that the hypothesis holds at `k = 6`; anything from one disc beyond the finite graphs that fit inside it.

  3. **C124-RADIUS (down)** — **restated at every `k` and every open set**: *For every integer `k ≥ 1`: if `χ(ℝ²) ≤ k`, every open set of the plane has a weak measurable `k`-colouring.* The claim as posed (`k = 6`, discs) is its instance. Why: the import it uses is stated at every `k`, and nothing in the restriction reads a disc. **Not claimed**: anything without the declared outside theorem `Outside.OAI158.proper_to_borel_weak`; that `χ(ℝ²) ≤ 6`; any regularity of the colouring obtained.

  4. **C124-RADIUS-FIVE** (added: the card's control "at `k = 5` (up) must fire", as a statement; P). *There is `R > 0` such that no open disc of radius `R` has a weak measurable five-colouring.* **Not claimed**: any value of `R` — the argument gives the radius of a disc holding a finite unit-distance graph that is not five-colourable, which exists by compactness and has not been exhibited; the same at six.

  5. **C124-SHADOW-OPEN** (added: the one lemma; it is the second half of C132-SHADOW's own argument, G92; P). *Let `U` be an open set of the plane, `c` a measurable map from `U` to a finite set of labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit vector `u` with `z + u` in `U`, `i` a label, and `W` an open subset of `U` almost every point of which has the label `i`. Then the set of points of `U` at distance exactly 1 from some point of `W` is open, and almost every point of it has a label other than `i`.* **Not claimed**: anything for a set `W` that is not open; anything at a point whose unit circle meets only the boundary of `W`.

  6. **C124-OPEN** (added: the object has ends; P). *If `(q, z)` is tight for `(a, b)` with radius `ρ`, then `(q, z′)` is tight for `(a, b)` for every point `z′` with `|z′ − q| = 1` and `|z′ − z| < ρ`.* **Not claimed**: anything at an end of a maximal arc of tight far ends; that such an arc has ends in `U`.

  7. **C124-CENTRE** — as posed. **Not claimed**: that `a` or `b` is present at `q` (C124-KIND); anything about the other labels near `q`; that this is all a tight pair forces at `q` — with a second tight far end `z′` for the same `(a, b)` the two conclusions intersect, and near `q` the label `a` is confined to `B̄(z, 1) ∩ B̄(z′, 1)`, a region with angle `π − ∠zqz′` at `q`.

  8. **C124-COMPLETION** — as posed. **Not claimed**: that any given label is present at `w`; that `w` is an end of a tight pair, or carries more than one label; anything that spends the number of labels.

  9. **C124-STRADDLE** (added: the wider form the argument carries; P). *Let `c` be a weak `k`-colouring of `U`, `(q, z)` tight for `(a, b)`, and `p` a point of `U` with `|p − z| = 1`, `p ≠ q` and `p ≠ 2z − q`. Then there is `η > 0` such that almost every point of `B(p, η)` has a label other than `a` and other than `b`.* The rhombus completions are the two such points at distance 1 from `q`. **Not claimed**: a uniform `η` as `p` tends to `q` or to `2z − q`; anything at those two points.

  10. **C124-ANTIPODE** (added: the far unit parallel, G85; P). *Let `c` be a weak `k`-colouring of `U`, `(q, z)` tight for `(a, b)`, and suppose `p = 2z − q` lies in `U`. Then there is `η > 0` such that almost every point of `B(p, η)` has a label other than `b`, and almost every point `w` of `B(p, η)` with `|w − q| < 2` has a label other than `a`.* **Not claimed**: that `a` is present near `p`; that the circle of radius 2 about `q` is an interface there.

  11. **C124-KIND** — as posed, with the colouring named: the hexagonal seven-colouring at circumradius 2/5 with one tile enlarged by a cap of a unit disc of height 1/61 over the middle of one edge. **Not claimed**: anything at six; that a tight pair with neither label present at its centre occurs in any weak six-colouring; that the modified colouring is saturated or honest.

  12. **C124-SIX** — as posed. **Not claimed**: that the configuration exists at any `k` (no held object meets the hypothesis); which label the fifth one is, or that five suffice; anything when the six pairs use three or more label pairs (R7's centres). Its smallest form is stated as its own relay, **C124-SIX-CONES** (X): *in the setting of C124-SIX, there is `η > 0` such that almost every point of `B(q, η)` with a label among `a, b, a′, b′` lies in a closed set that is the union of at most four regions, each bounded near `q` by two unit circles through `q` meeting at the angle `π/3`, or reduced to `{q}`.*

  13. **C124-HALF** — as posed (both statements). **Not claimed**: that a label of `y` is present at `w`; anything inside the unit circle about `y` for the first statement; that the first statement's class is inhabited at six.

- **2026-10-07 (13:20 UTC; after FS124-E1's Stage 3; FS-124 inventory item 7): the first claim has its verdict — C124-RADIUS is
  derived, both halves, with its relay and its control** (C124-RADIUS-GRAPH, C124-RADIUS-UP, C124-RADIUS-DOWN, C124-RADIUS-FIVE:
  each "derived", [hand] or derived from a [hand] entry, one mind, kernel pending; C124-RADIUS-DOWN and C124-RADIUS-FIVE each
  over one declared outside theorem). **One statement added by the deriver, derived with them**: **C124-RADIUS-COUNTABLE** —
  statement: Let k ≥ 1, U an open set of the plane, c a weak k-colouring of U, and V a countable subset of U whose closure is a compact subset of U. Then the unit-distance graph on V has a proper k-colouring of the form v ↦ c(g(v)) for a rigid motion g with g(V) ⊂ U. *Not claimed (C124-RADIUS-COUNTABLE):* anything for an uncountable V; anything for a countable V that accumulates at the boundary of U; that the colouring obtained is measurable in any sense on a larger set. **It fixes no value of `χ(ℝ²)`.**

