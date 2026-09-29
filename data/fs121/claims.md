# FS-121 — the proposed claim list (statements only)

*Proposed by the opening job FS121-O1 (Ephodos), 2026-09-29. **Frozen by Keryx, 2026-09-29 05:41 UTC**, with two edits for blindness only (no statement changed): § 2's heading, which named the claims a blind verifier takes, and one source note pointing into FS-116's plan, a fenced record; the proposal as written is in git (commit 59b23868). **Statements only: no proof, no sketch, no route, no
grade.** Every quotation is verbatim, with its source address, and was checked by `python3 tools/fs121_o1_quotes.py
data/fs121/o1/quotes-claims.tsv` (output `data/fs121/o1/quotes-claims.out`, 16 of 16). Text outside quotation marks is this list's
own and is marked "(this list)". Give every claim you work one verdict — **TRUE** (with your derivation), **FALSE** (with a counterexample), **GAP at a
named step**, or **MISSTATED** (with the corrected statement) — with your count of minds and your grade. FALSE and GAP are results, as valuable as TRUE.*

**The vacuity rule for this list.** A claim about tight six-colourings may quantify over an empty class: the class is empty exactly when
`χ_m⁰(ℝ²) ≥ 7`. So every structural claim is stated **for every number of colours `k`**, and each says whether a seven-colour (or nine-colour)
inhabitant of its hypotheses is held. An inhabitant at `k ≥ 7` of an existence statement tests nothing about six. It tests only universal forms and
procedures. **Where six is spent:** every claim in §§ 2–4 uses no colour count; six enters route M only at the map NO (`data/fs111/claims.md` § 0,
Q-NO) and in C121-SAT6.

## 0. Definitions

- **D-NF** (`data/fs111/claims.md` § 0, quoting `data/fs106/claims.md` § 0, verbatim): "For a measurable `f : ℝ² → [k]` proper at `Leb ⊗ σ`-almost
  every edge: `S_j = f⁻¹(j)`; `S̃_j` the points of density 1 of `S_j`; `E = ℝ² ∖ ⋃_j S̃_j` (Falconer's null set); `d̄_j(x) = limsup_{r→0} |S_j ∩ B(x,
  r)|/|B(x, r)|`; **`P(x) = {j : d̄_j(x) > 0}`**, the *essential multicolour*." **Tight** (the same list, D-SLACK, verbatim): "*Tight*: slack for no
  `ε > 0`".
- **Saturated** (`plans/FS111-M-regularity.md` § 2.1, verbatim): "every essential boundary point is at distance exactly 1 from the support of each colour
  of its essential multicolour". **Honest** (`plans/FS111-derivation.md`, FS111-C-SAT-T-HONEST, verbatim): "an honest (one colour per point) saturated
  one".
- **(H1), (H2)** (`plans/FS111-M-regularity.md` § 3, verbatim): "**(H1)** at `x`: a ball `N = B(x, ρ)` in which `S_c` is null for `c ∉ {a, b}`. **(H2)**
  at `x`: in `N`, `S_a` and `S_b` are each a.e. equal to a connected open set of density points, `P_a ⊆ S̃_a`, `P_b ⊆ S̃_b`, with `x ∈ cl P_a ∩ cl P_b`".
- **Σ, the singular set** (`plans/FS111-M2-regularity.md` § 4.1, verbatim): "the essential boundary points at which M-PINCH's hypotheses (H1), (H2)
  fail, together with every point of `supp S_j` at which `S_j` has density 0 (cusps)".
- **REG-J′** (`data/fs111/claims.md` § 6, verbatim): "**REG-J′_k**: a saturated colouring whose singular set Σ is locally finite, **each point of Σ
  meeting finitely many interface arcs** (the clause two briefs dropped)".
- **LRA** (`plans/FS111-M2-regularity.md` § 4.1, verbatim): "**infinitely many arcs can accumulate at a point only with radii tending to infinity** (call
  that **LRA**, large-radius accumulation; not excluded here)". *(this list)* **¬LRA**: no point is an accumulation point of interface pieces whose
  radii of curvature tend to infinity.
- **Kind both** (`plans/FS111-M-regularity.md` § 3.1, verbatim): "(split) is a **unit arc of kind both** (row 135's term): its centre `y` carries both
  side colours." **(Q), (R2)** (`data/fs114/claims.md` § 0, quoting `plans/FS112-derivation.md`, verbatim): "**(Q)** an arc whose centre carries both side
  colours and at least four colours; **(R2)** an arc whose centre carries the outer side colour and not the inner, with an inner-colour tile along the
  radius-2 circle over the whole arc." *(this list)* A point **carries** a colour `j` when it lies in `supp S_j`.
- *(this list)* **Tangent type, split type**: the two cases of FS111-M-PINCH (§ 1) at an interface point. **The ladder** of an interface arc `J`: the family
  of its unit parallel curves, at every integer distance on either side, as far as they are interface arcs. For an arc of radius `n` with centre `z`,
  its **inner end** is the last member before `z`, its **outer** members those of radius `n + 1, n + 2, …`.

## 1. Held inputs (use as held; each with its grade and minds, as filed)

- **FS111-M-PINCH** (`plans/FS111-derivation.md`, verbatim) [derived, three minds]: "at a saturated point x of an honest a.e.-proper colouring with a
  neighbourhood N in which only two colours a, b have positive measure and each is a.e. one connected open set of density points (H1, H2): either N is
  split by one unit circle T₁(y) with a inside and b outside or the reverse, y a contact of both colours, or two open unit discs tangent at x from
  opposite sides lie a.e. in S_a and in S_b; the case (in, in) is impossible; no positive density of the partner is needed"
- **FS111-M2-INTRAD** (`plans/FS111-derivation.md`, verbatim) [derived, two minds on its core, its finiteness step one]: "in an honest saturated colouring
  whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′), the unit parallel of every tangent-type interface arc
  is again an interface arc, so radii of curvature drop by exactly 1 toward the centre and stop at 1: every interface has integer radius of curvature
  almost everywhere and is locally a chain of segments and circular arcs, finitely many of each radius"
- **FS112-N3-NOBOTH** (`plans/FS112-derivation.md`, verbatim) [hand, two minds, one blind; stated for valid maps]: "The centre of a both-kind unit arc is a
  vertex with at least four colours or a repeated colour."
- **FS111-W-NOREP** (`plans/FS111-derivation.md`, verbatim) [derived, one mind]: "at a cone vertex of a saturated map without cusps, no colour occupies two
  sectors"
- **FS111-W-LADDER** (`plans/FS111-derivation.md`, verbatim) [derived, one mind]: "a flat edge of a saturated map carries interfaces at every unit translate
  along its normal, with the colour rule β_{k+1} = τ_{k−1}"
- **FS-116's qualification** (FS-116's opening, verbatim) [one mind]: "a saturated-class NO answers Question 2 for no map outside the
  class, and serves route M only with C-SAT-T-HONEST at six (FS111-C-SAT-T-HONEST, GAP, FS-121's)"
- **The controls** (all held, exact): R7 (`k = 7`), SQ9 and HEX9 (`k = 9`), DISC7 and DISCK7 (`k = 7`, covers), `plans/FS111-derivation.md`.

## 2. The ladder ends

- **C121-ENDS** (this list): in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius
  ends, off a null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind
  both and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or it does not
  — J_1 is (R2), and z is a point of Σ carrying at least three colours, and at least three distinct colours when no colour at z has density 0.
  *Not claimed:* that every chain ends at a (Q) arc; that an (R2) end exists in any saturated colouring; that an (R2) centre has four colours.
  *Colours:* every `k`. *Inhabitant:* `k = 7`, R7 (every interface a split unit arc; its centres carry six colours, with cusps).
- **C121-OUT** (this list): in an honest saturated colouring in D-NF satisfying REG-J′, the unit parallel away from the centre of every tangent-type
  interface arc of radius n (n a positive integer, or infinite for a segment) is, off Σ, a tangent-type interface arc of radius n + 1; so every curved
  interface of tangent type lies in a one-sided infinite family of concentric interface arcs of radii n, n + 1, n + 2, … over one angular window.
  *Not claimed:* that a saturated colouring with a curved tangent interface exists. *Colours:* every `k`. *Inhabitant:* `k = 9`, SQ9 (the flat case,
  `n` infinite); **none held for the curved case at any `k`**.
- **C121-PER** (this list): in an honest saturated colouring in D-NF satisfying REG-J′ whose interfaces carry only finitely many radii of curvature — in
  particular a doubly periodic one satisfying ¬LRA — every curved interface is a split unit arc of kind both and no (R2) arc occurs; where no colour has
  density 0 at an arc's centre, every such arc is (Q).
  *Not claimed:* that a tight colouring can be taken periodic. *Colours:* every `k`. *Inhabitant:* `k = 7`, R7.
- **C121-LRA-LINE** (this list): in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces of radii tending to infinity accumulate at
  a point x₀ of an interface curve with normal ν there, then pieces of radii tending to infinity accumulate at x₀ + kν for every integer k.
  *Not claimed:* that such a line is impossible. *Colours:* every `k`. *Inhabitant:* **none held** (no held saturated colouring has LRA; the statement is
  a reduction).
- **C121-R2-FOUR** (this list): in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, every centre z of an (R2) arc
  that ends a chain of unit parallels, at which no colour has density 0, carries at least four colours.
  *Not claimed:* anything at points where a colour has density 0; anything about the (Q) branch. *Colours:* every `k`. *Inhabitant:* **none held** (no held
  saturated colouring has an (R2) arc; by C121-PER none periodic has one). A three-colour (R2) end at any `k ≥ 7`, given by formula, refutes it.
- **C121-CURVED** (this list): for some k ≥ 7 there is an honest saturated colouring in D-NF satisfying REG-J′, with no colour of density 0 at any point,
  that has a tangent-type interface arc of finite radius.
  *Not claimed:* anything at `k ≤ 6`. *Role:* the inhabitant the classes of C121-OUT and C121-R2-FOUR lack (G21). A derived obstruction at every `k ≥ 7`
  is also a result.

## 3. Large-radius accumulation (job FS121-D2)

- **C121-NOLRA** (this list): in every honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, ¬LRA holds.
  *Not claimed:* anything without REG-J′. *Colours:* every `k`. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9 (none has LRA). A saturated colouring with
  LRA at any `k ≥ 7` refutes it.

## 4. Honest saturation and the singular set (jobs FS121-D3, FS121-D4)

- **C121-SAT6** (`plans/FS111-derivation.md`, FS111-C-SAT-T-HONEST, verbatim, **worked at `k = 6`**): "every tight a.e.-proper k-colouring can be
  modified, keeping it a.e.-proper with k colours, into an honest (one colour per point) saturated one, at k = 5 and k = 6".
  *Not claimed:* that the modification is local, or a selection from a given maximal cover. *Colours:* `k = 6` by nature (this list): its existence
  form holds at `k = 7` by R7 and tests nothing there, and the form "every tight `k`-colouring lies below an honest saturated one" is false at seven (the
  tight hexagonal seven-colouring is not saturated, and its classes cover the plane). *Where six is spent:* in the global re-choice, which no held
  argument names.
- **C121-REGJ** (this list): in every honest saturated colouring in D-NF, with any number of colours, the singular set Σ is locally finite and each point
  of Σ meets finitely many interface arcs.
  *Not claimed:* any bound on how many points of Σ a set of given size holds. *Colours:* every `k`. *Inhabitants:* `k = 7`, R7; `k = 9`, SQ9 and HEX9. A
  saturated colouring at any `k ≥ 7` whose Σ is not locally finite refutes it. **A derivation of it may not rest on C121-ENDS, C121-OUT, C121-PER or
  C121-LRA-LINE, which assume REG-J′.**

## 5. Added at round 2 (frozen by Keryx, 2026-09-29 06:28 UTC; statements verbatim from their proposing records, with their *not claimed* lines)

- **DB1-L3** *(proposed at round 1)*: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere *Not claimed:* that a colour cannot occupy a sector and a cusp, or two cusps, at one point; anything without REG-J′
- **FS121-D1-VT** *(proposed at round 1)*: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b that is not a unit arc curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior point of I, no interface arc ends at Y from the far side of L *Not claimed:* anything at the image of an endpoint of I (the far-side colour may change there); anything when I is a unit arc curving toward b (L is a point, the (Q) or (R2) end); anything with cusps (NOREP's hypothesis)
- **FS121-D1-EROSION** *(proposed at round 1)*: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π) and both its edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the two pieces has a point of Σ at distance cot(θ/2) from z *Not claimed:* anything for curved edges (their partner curves cross elsewhere, and FS121-D1-VT still forbids the crossing at images of interior points); anything at θ ≥ π; anything with cusps

## 6. Added at round 3 (frozen by Keryx, 2026-09-29 07:03 UTC; statements verbatim from their proposing records, with their *not claimed* lines)

- **FS121-V2-SECTOR** *(proposed at round 2)*: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a sector of positive angle occupies no other region there, of positive or of zero angle *Not claimed:* that a colour cannot occupy two zero-angle regions at one point; anything without REG-J′; that the point itself is saturated (not used)
- **FS121-D3-GRUNDY** *(proposed at round 2)*: every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified, keeping it a.e.-proper with k colours and never raising a point's colour index, into a measurable Grundy colouring (A_1, …, A_k): A_1 is a MUA set, each A_m is maximal among sets with null unit pairs inside the complement of A_1 ∪ … ∪ A_(m−1) that contain S_m minus that union, every point of the support of A_m is at distance exactly 1 from the support of A_i for every i < m, and so at every essential boundary point x every colour of P(x) other than the largest is bound at x *Not claimed:* that the colour max P(x) is bound (the output need not be saturated); uniqueness; that the output lies above f in any order; any regularity of the classes; that a saturated input stays saturated
- **FS121-D3-FALLSAT** *(proposed at round 2)*: every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null unit pairs (a measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated a.e.-proper k-colouring *Not claimed:* the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D, § 2.3; trivially also with an unused colour); that any idomatic partition exists with fewer than seven classes

## 7. Added at round 3: the cover route (proposed by FS121-C1, `data/fs121/c1/proposed-claims.md`; frozen by Keryx, 2026-09-29 07:06 UTC, verbatim)

**The vacuity rule, as the list states it, applied here.** Every claim below except C121-NOPAR and C121-NOPAR-C5 is stated for every number of colours
`k` and names its held inhabitant, or says none is held. C121-NOPAR and C121-NOPAR-C5 are NOs: six colours by nature, and each names the inhabitants
that show its class is not empty at seven or nine. **Where six is spent:** only in those two NOs, and in C121-C1-GMAP's clause (ii), which composes them.

### 7.0 Definitions (this addendum, except where quoted)

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

### 7.1 The rung

- **C121-NOPAR** (this addendum): `𝒫_6` is empty: no locally finite map colouring with six colours has a total order on its colours in which every point
  of every edge separating colours `i < m` lies on the outer unit parallel or on the far level of a connected component of `F_i`.
  *Not claimed:* that it gives seven without a regularity rung (C121-C1-GMAP (ii) needs G-FIN₆ beside it); anything about the map a maximal cover yields
  (C121-C1-COVMAP); the two-sided form alone (C121-C1-SAT relates it). *Colours:* six, a NO. *Inhabitants of `𝒫_k`:* `k = 7`, R7 (every order);
  `k = 9`, SQ9 and HEX9 (every order). The tight hexagonal seven-colouring is in no `𝒫_7`.
- **C121-NOPAR-C5** (this addendum): no member of `𝒫_6` satisfies Condition 5.
  *Not claimed:* anything with an edge on a unit circle. *Colours:* six, a NO. *Inhabitants of `𝒫_k` under Condition 5:* `k = 9`, SQ9 and HEX9; **none
  held at `k = 7`**.

### 7.2 Lemmas (every `k`)

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
