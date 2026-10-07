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
