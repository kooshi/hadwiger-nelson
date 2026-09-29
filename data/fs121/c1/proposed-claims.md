# FS-121 — proposed addendum to the claim list: the cover route's NO (NO-PAR) and its lemmas (statements only)

*Proposed by FS121-C1 (Ephodos), 2026-09-29, for Keryx to freeze as a dated addendum to `data/fs121/claims.md`. **Statements only: no proof, no
route, no grade, no verdict, no mind count.** Every quotation is verbatim with its source address, checked by
`python3 tools/fs121_c1_quotes.py data/fs121/c1/quotes.tsv` (output `data/fs121/c1/quotes.out`, 17 of 17). Text outside quotation marks is this
addendum's own, marked "(this addendum)". The list's § 0 definitions (D-NF, *saturated*, *honest*, Σ, REG-J′) apply unchanged.*

**The vacuity rule, as the list states it, applied here.** Every claim below except C121-NOPAR and C121-NOPAR-C5 is stated for every number of colours
`k` and names its held inhabitant, or says none is held. C121-NOPAR and C121-NOPAR-C5 are NOs: six colours by nature, and each names the inhabitants
that show its class is not empty at seven or nine. **Where six is spent:** only in those two NOs, and in C121-C1-GMAP's clause (ii), which composes them.

## 0. Definitions (this addendum, except where quoted)

- **The stub's statement of the rung** (`plans/STUB-map-step.md` § The question, verbatim): "**At six, the cover route: NO-PAR** — no map whose
  boundaries lie on unit parallels (outer and far) of their own classes' components carries an a.e.-proper six-colouring."
- **Locally finite map colouring with `k` colours** (this addendum): a closed Lebesgue-null set `Γ ⊂ ℝ²` that is a locally finite plane graph (finitely
  many Jordan arcs in each bounded set, meeting only at endpoints; these arcs are its **edges**), and one of `k` colours for each component (**face**) of
  `ℝ² ∖ Γ`, such that no two points of faces of one colour are at distance exactly 1. `S_j` is the union of the faces of colour `j`, and `F_j = cl S_j`.
  An edge **separates** colours `i ≠ m` when it bounds a face of colour `i` and a face of colour `m`.
- **Bound** (this addendum; FS121-D3's word): a point `x` is **`j`-bound** when it is at distance exactly 1 from `F_j`, i.e. the unit circle `T₁(x)`
  about `x` meets `F_j`.
- **Outer unit parallel, far level** (this addendum, naming `plans/FS111-M2-regularity.md` § 2.1 (iv), verbatim: "the class boundary near `x` lies on
  finitely many "far levels" `{D_{K_i} = 1}` (convex arcs, the class inside) and "near levels" `{d_{K_i} = 1}` (outer unit parallels, the class
  outside)"): for a closed set `K`, `d_K(x)` is the distance from `x` to `K` and `D_K(x) = sup_{p ∈ K} |x − p|`; the **outer unit parallel** of `K` is
  `{d_K = 1}` and its **far level** is `{D_K = 1}`.
- **The class `𝒫_k`** (this addendum): the locally finite map colourings with `k` colours whose colours carry a total order in which every point of
  every edge separating colours `i < m` lies on the outer unit parallel or on the far level of a connected component of `F_i`.
- **MUA set** (`plans/FS111-derivation.md`, verbatim): "A **MUA set** is a maximal unit-avoiding set: measurable, with null unit pairs, maximal under
  inclusion up to null sets."
- **Grundy-bound colouring** (this addendum): a partition `(A_1, …, A_k)` of the plane, up to a null set, into measurable sets with null unit pairs, in
  which (FS121-D3-GRUNDY's clause, `plans/FS121-D3-proof.md`, verbatim) "every point of the support of A_m is at distance exactly 1 from the support of
  A_i for every i < m". FS121-D3-GRUNDY's statement begins (verbatim): "every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified,
  keeping it a.e.-proper with k colours and never raising a point's colour index, into a measurable Grundy colouring (A_1, …, A_k)"; its output is
  Grundy-bound.
- **χ_m⁰(ℝ²)** (`LEDGER.md` row 130, verbatim): "the least `k` with a Lebesgue-measurable `k`-colouring proper at almost every unit pair".
- **G-FIN₆** (this addendum): if an a.e.-proper measurable six-colouring of the plane exists, then some Grundy-bound six-colouring is a.e. equal to a
  locally finite map colouring (class `A_j` a.e. equal to `S_j`).
- **Condition 5** (`plans/FS110-derivation.md`, quoting `[SokolovVoronov2025]`, verbatim): "every boundary meets every unit circle in finitely many
  points".
- **DISC7** (`plans/FS111-derivation.md`, FS111-M2-DISC7, verbatim): "the circumscribed discs of the tight hexagonal seven-colouring (radius 1/2,
  centred at the hexagon centres, coloured as the hexagons) form a maximal admissible seven-cover with regular classes whose overlaps (lenses) have
  positive measure". Its merged map (FS111-M2-REDUCE-C's step (1), `plans/FS111-M2-regularity.md` § 3.2, verbatim: "colour `R` by the least such `j`"),
  under a total order of its seven colours: each face of the arrangement of the discs' boundary circles coloured by the least colour, in that order, of
  a disc containing it.
- **The chain's frame** (this addendum, after `plans/FS110-N-proof.md` § 2.1): `n`, `a` orthonormal, `P_k = kn` for `k ∈ ℤ`. A **germ at `P_k`** is the
  germ at `P_k` of the graph `{P_k + Xa + Y(X)n}` of a `C^∞` function `Y` with `Y(0) = Y′(0) = 0`; germs are ordered pointwise for small `|X|`. The
  **unit parallel toward `P_{k−1}`** of a germ `G` at `P_k` is the germ at `P_{k−1}` of `{p − ν(p) : p ∈ G}`, and its unit parallel toward `P_{k+1}` is
  that of `{p + ν(p)}`, `ν` the unit normal with positive `n`-component.

## 1. The rung

- **C121-NOPAR** (this addendum): `𝒫_6` is empty: no locally finite map colouring with six colours has a total order on its colours in which every point
  of every edge separating colours `i < m` lies on the outer unit parallel or on the far level of a connected component of `F_i`.
  *Not claimed:* that it gives seven without a regularity rung (C121-C1-GMAP (ii) needs G-FIN₆ beside it); anything about the map a maximal cover yields
  (C121-C1-COVMAP); the two-sided form alone (C121-C1-SAT relates it). *Colours:* six, a NO. *Inhabitants of `𝒫_k`:* `k = 7`, R7 (every order);
  `k = 9`, SQ9 and HEX9 (every order). The tight hexagonal seven-colouring is in no `𝒫_7`.
- **C121-NOPAR-C5** (this addendum): no member of `𝒫_6` satisfies Condition 5.
  *Not claimed:* anything with an edge on a unit circle. *Colours:* six, a NO. *Inhabitants of `𝒫_k` under Condition 5:* `k = 9`, SQ9 and HEX9; **none
  held at `k = 7`**.

## 2. Lemmas (every `k`)

- **C121-C1-BOUND** (this addendum): in a locally finite map colouring, a point `x` of `F_i ∖ S_i` is `i`-bound if and only if it lies on the outer unit
  parallel or on the far level of a connected component of `F_i`.
  *Not claimed:* which of the two levels, or that the component is unique. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9.
- **C121-C1-GMAP** (this addendum): (i) for every `k`, a Grundy-bound `k`-colouring that is a.e. equal to a locally finite map colouring makes that map
  colouring a member of `𝒫_k` under the order `1 < 2 < … < k`; (ii) G-FIN₆ and C121-NOPAR together imply `χ_m⁰(ℝ²) ≥ 7`, and given C121-NOPAR, G-FIN₆
  holds if and only if `χ_m⁰(ℝ²) ≥ 7`.
  *Not claimed:* G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring. *Inhabitants of (i):* `k = 7`, R7 (every class a MUA
  set).
- **C121-C1-SAT** (this addendum): for every `k`, a locally finite map colouring with `k` colours whose edges are finite chains of segments and circular
  arcs, and whose classes form an honest saturated colouring, is a member of `𝒫_k` under every total order of its colours; so C121-NOPAR implies that no
  honest saturated six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs.
  *Not claimed:* the converse (a member of `𝒫_k` need not be saturated). *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9.
- **C121-C1-COVMAP** (this addendum): under every total order of the seven colours, DISC7's merged map (the faces coloured by the least colour, in that
  order, of a disc containing them) has an edge point that is bound by neither of the two colours the edge separates; so it lies in `𝒫_7` under no order.
  *Not claimed:* anything about other maximal covers, or about DISC7's classes themselves (each disc is its own far level). *Colours:* seven, a
  statement about one object.
- **C121-C1-FLAT** (this addendum): there are germs `L_k`, `U_k` at `P_k`, for every `k ∈ ℤ`, with `U_k > L_k` on both sides of `P_k`, every one of
  curvature 0 at `P_k`, such that for every `k`: `L_k` is the unit parallel toward `P_k` of `L_{k+1}`, and `U_k` is the unit parallel toward `P_k` of
  `U_{k−1}`. (So the relations `plans/FS110-derivation.md` states on circular arcs as "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤
  f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`", read on germs with `L_k` below the parallel of `L_{k+1}` and `U_k` above the parallel of `U_{k−1}`, hold with
  equality for every `k`, and `λ_k = υ_k = 0`.)
  *Not claimed:* that any locally finite map colouring realises these germs; anything about the other steps of row 134's chain on smooth boundaries.
  *Colours:* none (a statement about germs of curves).
