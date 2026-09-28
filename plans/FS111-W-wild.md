# FS111-W — competitor W of FS-111: the wild side (where route M's rungs and route R's (A) fail)

*Job FS111-W (de Bruijn, Opus 5.5), opened 2026-09-28 06:46 UTC. Brief: `data/fs111/briefs/W-111-wild.md`, with
`data/fs111/briefs/STANDING-RULES.md` (rule 0 read first) and the owner's launch notes (FS111-V0's §2 open to me; competitor M's files and
FS-114's files fenced). Working files: `data/fs111/fs111-w/`; exact checks: `tools/fs111_w_*.py`. No children were started; my only contact is
"main". The record is saved in stages (standing rule 2).*

## Theorems this phase proved

*(one line per theorem: statement, grade, count of minds, address)*

- **FS111-W-NEG** — every existence rung of route M (REG-A_k, REG-I_k, REG-J_k, REG-B_k) is TRUE at every `k ≥ 7` (the tight hexagonal
  seven-colouring is its own witness) and vacuous at `k ≤ 4`; its negation at `k ∈ {5, 6}` asserts a tight a.e.-proper `k`-colouring, so
  implies `χ_m⁰(ℝ²) ≤ k`. Route R's A-ALL is implied by seven, and its negation implies `χ_m⁰(ℝ²) ≤ 6`. [hand, one mind] Stage 1 §1.4.
- **FS111-W-SQ9** — the colouring of the plane by closed squares of side `1/2`, square `(i, j)` coloured `(i mod 3, j mod 3)`, is a.e.-proper,
  tight and saturated (no essential boundary point is free for any colour of its multicolour): an inhabitant of C-SAT-T's conclusion class at
  `k = 9`. [tools, exact: `tools/fs111_w_check.py`] Stage 1 §1.5.

- **FS111-W-HEX9** — hexagons of width `1/2`, coloured by `Λ/3Λ`, form a saturated tight nine-colouring. [tools, exact] Stage 2 §2.4.
- **FS111-W-C11** — at every point of a saturated colouring where only two colours occur locally, each locally connected (H2), with H-DEN,
  the interface is `C^{1,1}` of curvature `≤ 1`, and each point is either sandwiched between two externally tangent unit discs (both contacts
  outer) or on a unit arc of kind both. [hand, one mind; the `C^{1,1}` step a standard fact about the uniform ball condition] Stage 2 §2.2.
- **FS111-W-NOBEND**, **FS111-W-CURV** — corollaries of C11: no bend; curvature `≤ 1`. [hand, one mind] §2.2.
- **FS111-W-NOREP** — at a cone vertex of a saturated colouring no colour occupies two sectors. [hand, one mind] §2.3.
- **FS111-W-LADDER** — a flat edge of a saturated map carries interfaces at every unit translate along its normal, with the colour rule
  `β_{k+1} = τ_{k−1}`. [hand, one mind] §2.4.
- **FS111-W-HEXSAT** — a regular hexagonal tiling is saturable only at width `1/m`; at width `1/2` exactly nine colours; no recolouring of hex7's
  or the brick's tiling is saturated. [hand, one mind; HEX9 exact] §2.4.
- **FS111-W-HEX7-RIGID** — in the tight hexagonal seven-colouring no local modification creates a junction or an island. [derived; sampled exact
  check `tools/fs111_w_hex7_free.py`] §2.5.
- **FS111-W-FILL-FREE** — a fill never creates a contact for the filled colour. [hand, one mind] §2.6.
- **FS111-W-DECO-B** — hex7 decorated with two squares per hexagon: tight, a.e.-proper, no class with tight block structure (REG-B's universal
  form FALSE at `k = 7`). [tools, exact: `tools/fs111_w_blocks.py`] §2.6.
- **C-HULL-REG TRUE on saturated maps without cusps** (C11 + NOBEND + NOREP). [hand, one mind] §2.6.

## Would-have-searched-here log (standing rule 3)

- Stage 2: (a) local search for saturated 7-/8-colourings over periodic polygonal tilings → derived LADDER and HEXSAT; (b) a finder for tight
  seven-colourings with accumulating junctions → exact freeness probe of hex7 and HEX7-RIGID; (c) a scan over island shapes → the island
  obstruction (§2.7).
- Stage 1: would have run a colouring finder over small periodic tilings to find a saturated colouring with few colours → instead derived the
  facing-edge condition (every edge faced at distance exactly 1 by a same-coloured edge) and wrote the nine-colour square tiling down by formula.

## Fence log (standing rule 13)

- Stage 1: no fenced path opened. The listing `ls data/fs111/briefs/` printed the file name `M-111-regularity.md` (competitor M's brief); the
  file was not opened. `plans/FS111-cone-scale.md` read at its header (ll. 1–35) and stages 2, 3b, 4, 5 only; stage 6 not opened.

## Stage 1 — SAVED: quotation check; each claim's object, complexity class and boundary class; the controls by formula with my checker

### 1.1 Files read from disk, in order

`data/fs111/briefs/W-111-wild.md`; `data/fs111/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim, § Counter-priors, G20, G21, G22, G24, G40, G60,
G71, G79, G82, G83 (the session's loaded copy; `git log -- CLAUDE.md` shows no commit after `a9410925`, FS-112's close, so it matches disk);
`LEDGER.md` rows 129–136; `plans/FS111-cone-scale.md` ll. 1–35 and stages 2, 3b, 4, 5; `data/fs111/claims.md` in full; `data/fs106/claims.md`
§0–§1; `plans/FS107-derivation.md` in full; `plans/FS107-W-near-colourings.md` stages 2–4; `plans/FS107-R-stability.md` stage 3 (for (A), CP and
P3 in their home words); `~/source/library/pdf/arXiv-2407.05071-cohen-mani-clustering-unit-distance-avoiding-sets.pdf` §5 (pp. 15–17, in full)
and `arXiv-2304.10163-voronov.pdf` §2 (pp. 3–6, in full) by `pdftotext -layout`; `plans/FS111-V0-verification.md` (header, stage 2, stage 3)
and `data/fs111/fs111-v0/hex_check.out`, `tools/fs111_v0_hex.py` (header); `Proofs/HadwigerNelson/Instances/Seven.lean` (the brick's formula);
`plans/CONSOLIDATION-2026-09-27.md` l. 75 (one quotation).

### 1.2 Quotation check (standing rule 5)

| quotation (brief or standing rules) | source | verdict |
|---|---|---|
| "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | verbatim (the source continues with a parenthesis) |
| "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim (the brief adds the final full stop) |
| "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | verbatim |
| "From here on out, you may doubt your ability … you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim |
| "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | `CLAUDE.md` § Toolchain | verbatim |
| "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress." | `plans/CONSOLIDATION-2026-09-27.md` l. 75 | verbatim |
| R-P3: "**P3:** "bicycle-free Voronov" (A) is FALSE as a universal statement, and a W-type construction avoids complementary pairs at every scale (0.6)." | `plans/FS107-R-stability.md` l. 323 (§3.5) | verbatim |
| HX-STALL "(`plans/FS107-derivation.md` §2) … stalled at a named constraint" | `plans/FS107-derivation.md` §2 | TRUE: the constraint is K-ISL (l. 112, "the islands constraint (K-ISL), a geometric fact inside the family") |
| the brief's route-R target, "a family given by formula with holes decreasing and no complementary pair of junctions blocking toward a common unit point at any scale — R's own registration, P3 (0.6), expects one" | P3 above | **a paraphrase, flagged**: P3 says "avoids complementary pairs at every scale" and says nothing of holes; "holes decreasing" comes from P3's first clause through (A)'s hypothesis ("holes `< δ` in `U_R`"). Nothing emptied; I work P3 as quoted |
| the owner's notes on FS111-V0 (C-HULL MISSTATED, first clause TRUE, "so" FALSE; V0-WIG7; V0-WIGGLE; V0-RESCALE; C1-GAP and C1-FALS MISSTATED; seven claims TRUE at two minds) | `plans/FS111-V0-verification.md` §2.8, §2.1, §2.5–§2.6, stage 3 ("TRUE on both records: **two minds, one blind**") | TRUE as summaries; every claim name exists in `data/fs111/claims.md` |

### 1.3 Each claim's object, complexity class, boundary class and logical form

*Object* as in `data/fs111/claims.md` (SEQ, LIM, MAP, ARG). *Form*: **E** an existence statement ("if a tight colouring exists, then a regular one
exists"); **U** universal over a class of colourings; **L** a hypothesis read on a bounded region only. The last two columns are FS111-W-NEG (§1.4).

| claim | object | complexity class of its hypothesis → conclusion | boundary class of its hypothesis → conclusion | form | at `k ≥ 7` | its negation at `k ≤ 6` implies |
|---|---|---|---|---|---|---|
| REG-A_k | LIM → MAP | unbounded → locally finite, arbitrary per disc | measurable → segments and circular arcs | E | TRUE (hex7) | `χ_m⁰(ℝ²) ≤ k` |
| REG-I_k | LIM → MAP | unbounded → locally finite | measurable → Jordan curves (S–V Conditions 2–4) | E | TRUE (hex7) | `χ_m⁰(ℝ²) ≤ k` |
| REG-J_k | LIM → LIM | unbounded → locally finite junctions | measurable → sectors at junctions, interfaces free | E | TRUE (hex7) | `χ_m⁰(ℝ²) ≤ k` |
| REG-B_k | LIM → LIM | unbounded → blocks | measurable → blocks of diameter `≤ 1`, gaps `≥ 1` | E | TRUE (hex7) | `χ_m⁰(ℝ²) ≤ k` |
| C-SEVEN-M, C-SIX-M, C-REG-EQ | ARG | — | — | implication | TRUE (V0, two minds) | — |
| C-HULL | LIM | unbounded | measurable (one class, one path-connected piece) | U | first clause TRUE; "so" FALSE at hex7 (V0) | — |
| C-FILL | LIM | unbounded | measurable, one disc changed | U | TRUE (V0, two minds) | — |
| C-SAT-T_k | LIM → LIM | unbounded → unbounded | measurable → "saturated" (every essential boundary point a contact for each colour of its multicolour) | U over tight colourings, then E (modification unrestricted as written) | TRUE at `k ≥ 9` (FS111-W-SQ9); **open at `k = 7, 8`**: TRUE iff a saturated a.e.-proper 7- (8-)colouring exists | `χ_m⁰(ℝ²) ≤ k` |
| C-HULL-REG | LIM (saturated) | unbounded | saturated → Lipschitz, semiconcave or semiconvex at every bichromatic point | U over saturated colourings, every `k` | **refutable by one object at any `k`**; holds at SQ9 | — |
| PER | SEQ | unbounded → bounded perimeter density | any → finite perimeter | E, six only | — | `χ_m⁰(ℝ²) ≤ 6` |
| NO-C2 | MAP | locally finite | piecewise `C²` | U (a NO), six only | — | `χ_m⁰(ℝ²) ≤ 6` (a `C²` six-map) |
| CM-Q5.1 | one class | — | block structure | E (open question) | — | — |
| A-ALL | SEQ | every complexity | any | ∃`R, η, µ, δ` ∀ colourings with holes `< δ` in `U_R` | — | `χ_m⁰(ℝ²) ≤ 6` |
| B-RR | SEQ | every complexity | any | U over (A)'s pairs in near-optimal colourings | — | `χ_m⁰(ℝ²) ≤ 6` |
| B-NONABS | SEQ | every complexity | any | **L** ("holes `< δ` near the forced point") | — | nothing global: **refutable by a local fragment** |
| R-P3 | registration | — | — | "(A) is FALSE as a universal statement" | — | `χ_m⁰(ℝ²) ≤ 6` if it comes true |

### 1.4 FS111-W-NEG — what a wild object can and cannot refute  [hand, one mind]

**Statement.** (i) For every `k ≥ 7`, REG-A_k, REG-I_k, REG-J_k and REG-B_k are TRUE. (ii) For `k ≤ 4` they are vacuously TRUE. (iii) For
`k ∈ {5, 6}`, the negation of each asserts that a tight a.e.-proper `k`-colouring exists, hence `χ_m⁰(ℝ²) ≤ k`. (iv) If `χ_m⁰(ℝ²) ≥ 7`, A-ALL and B-RR
hold (vacuously for large `R` and small `δ`); the negation of A-ALL implies `χ_m⁰(ℝ²) ≤ 6`. (v) So R-P3's first clause, "(A) is FALSE as a
universal statement", is a registration that `χ_m⁰(ℝ²) ≤ 6`.

*Proof.* (i) The hexagonal seven-colouring by regular hexagons of circumradius `1/2`, coloured `(m + 3n) mod 7` (`tools/fs111_w_check.py`, object
`hex7`, and V0's `tools/fs111_v0_hex.py`), is a.e.-proper and tight (a hexagon's diameter is exactly 1); it is a segment map with trivalent
vertices whose blow-ups are three 120° sectors, and each class is a union of blocks (the closed hexagons, diameter 1) at mutual distance
`> 1.29 ≥ 1`. It witnesses the conclusion of every REG rung at `k = 7`, and at `k > 7` with colours unused. (ii) `χ_m⁰(ℝ²) ≥ χ(ℝ²) ≥ 5` (row 130's
I-EASY, two minds; rung B in the kernel), so no a.e.-proper `k`-colouring exists for `k ≤ 4`. (iii) Each rung is "if a tight a.e.-proper
`k`-colouring exists, then …"; its negation contains the antecedent, and a tight a.e.-proper `k`-colouring witnesses `χ_m⁰(ℝ²) ≤ k` (D-M).
(iv) (A) reads "for some `R, η, µ` [and `δ`] and every band-proper partial six-colouring with holes `< δ` in `U_R`, `U_R` contains …". Its negation
gives, for every `R` and `δ`, a band-proper partial six-colouring (slack `ε_{R,δ} > 0`) with holes `< δ` in `U_R`. Restrict it to the square of side
`ℓ = R√2` inscribed in `U_R` and repeat that square periodically with period `ℓ + g`, `g = 1 + 2ε_{R,δ}`, leaving the strips between copies
uncovered: two points in different copies are more than `1 + ε` apart, so the periodic partial colouring is band-proper at slack `ε_{R,δ}`, and its
uncovered density is at most `(2gℓ + g² + δ)/(ℓ + g)² → 0` as `R → ∞`, `δ → 0`. So `sup_ε µ₆(ε) = 1`, i.e. `lim_{ε→0} µ₆(ε) = 1`, which is
`χ_m⁰(ℝ²) ≤ 6` by H-EQ (row 131). Conversely, if `χ_m⁰(ℝ²) ≥ 7` the same periodisation shows that for some `R, δ` no band-proper partial six-colouring
has holes `< δ` in `U_R`, and (A) holds vacuously there; B-RR likewise. (v) is (iv) applied to P3's first clause. ∎

*What it means for this job* (G21, the generator-image rule): **a wild object at `k = 7` cannot refute any existence rung**; the claim list's
vacuity rule ("a derivation of it must name an inhabitant at `k = 7`") is met by hex7 automatically, so a `k = 7` test of an existence rung is a
control whose failure mode is unreachable. What a wild object *can* refute is: (a) the **universal and procedural forms** a colour-generic proof
of REG would pass through — "every tight colouring is (or can be moved locally into) a regular one" — which is where M's rungs would be proved if
REG is colour-generic (the plan's stage 5: "REG is colour-generic; the colour count enters only at the NO"); (b) **C-SAT-T at `k = 7, 8`**, by a
theorem that no saturated 7- (8-)colouring exists; (c) **C-HULL-REG**, by one saturated colouring at any `k`; (d) **B-NONABS**, whose hypothesis
is local. Route R's A-ALL and B-RR cannot be refuted without proving `χ_m⁰(ℝ²) ≤ 6`; there my product is a family that stalls, and where. Stages 2–3
are aimed accordingly.

### 1.5 The controls by formula, and the checker

`tools/fs111_w_check.py` — exact arithmetic in `ℚ(√3)` (class `Q3`, exact sign); periodic tilings by closed convex polygons given by formula;
checks **P** (a.e.-proper: no same-coloured pair of tiles has `dist < 1 < maxdist`, no tile of diameter `> 1`), **T** (tight: a same-coloured
distance interval ends at exactly 1), **S** (saturated, a sufficient test: every edge covered by same-coloured facing edges at distance exactly
1 on its outer side, every vertex with a pointwise contact), **F** (a named point free for every colour there, strict), **J** (vertex
multicolours). Output: `data/fs111/fs111-w/controls.out`; self-test `data/fs111/fs111-w/check_selftest.out` (exit 0).

| control | formula | P | T | S | free point | junctions |
|---|---|---|---|---|---|---|
| **hex7** | regular hexagons, circumradius `1/2`, centres `m(√3/2, 0) + n(√3/4, 3/4)`, colour `(m + 3n) mod 7` | holds | holds (diameter exactly 1) | fails (12 edges uncovered) | edge midpoint `(√3/8, 3/8)`, free for both its colours | trivalent, types `{0,1,3}, {0,2,3}, {0,2,6}, {0,4,6}, {0,4,5}, {0,1,5}` about the base hexagon |
| **brick7** | closed `4/5 × 3/5` cells, row `j` shifted `2j/5`, colour `(i + 3j) mod 7` (`sevenBrick`) | holds | holds (cells `(0,0)`, `(−1,−2)` at distance exactly 1; diagonal 1) | fails (6 edges) | `(1/5, 0)` free for colours 0 and 4; the edge midpoint `(2/5, 0)` is a T-vertex with a contact | trivalent T-vertices, types `{0,4,6}, {0,1,5}, {0,1,3}, {0,2,6}` |
| **sq9** (FS111-W-SQ9) | closed squares of side `1/2`, colour `(i mod 3, j mod 3)` | holds | holds (squares 3 apart in a row at distance exactly 1) | **holds** | none: the edge midpoint has a contact (the free-point test fails, as planted) | four-colour vertices only; no bichromatic vertex |

*Why SQ9 is saturated (the derivation behind the check):* a same-coloured square lies three squares away in each axis direction, so every edge
faces a same-coloured parallel edge at distance exactly `3/2 − 1/2 = 1` on its outer side, over its whole length, for the square's own colour; the
colour across the edge is the neighbouring square's, and it faces its own partner edge from the other side. Contacts are outer on both sides — the
shape FS111-W's stage 2 derives for every flat interface of a saturated colouring.

*Planted faults* (each must fail at exactly its named set, and the message names the pair or edge): `hexbig` (circumradius `11/20`) fails
{P (own diameter), T, S}; `hexcol` (colour `(m + 2n) mod 7`) fails {P (tiles `(0,0)`, `(−2,1)`), S}; `sq16` (period 4) fails {T (slack), S};
`sq9shear` (rows shifted `j/4`) fails {S} only (its horizontal edges); `sq9j2` (colour `(i mod 3, j mod 2)`) fails {P (rows two apart), S};
`sq9free` (the free-point test at SQ9's edge midpoint) fails {F}. All six fired for their own reasons; the first run's failure of the brick's
free-point test was the checker telling me that `(2/5, 0)` is a T-vertex with a contact, not a defect of the object.

## Stage 1 — SAVED

## Stage 2 — SAVED: route M's rungs, lowest first

*Aimed by FS111-W-NEG (§1.4): the existence rungs cannot fail at `k ≥ 7`; the targets are C-SAT-T at `k = 7, 8`, C-HULL-REG at any `k`, and
the universal forms of REG-B and REG-J. C-FILL and C-HULL are V0's (C-FILL TRUE, two minds; C-HULL's first clause TRUE, its "so" FALSE) and are used,
not re-derived. Throughout, a colouring is **saturated** if it is in C-SAT-T's conclusion: in D-NF, no `x ∈ ∂_e S_j` is `j`-free, for every `j`.*

### 2.1 Two standing hypotheses, named so that every result below says what it uses

- **H-DEN** — every contact point `y` of a colour `a` (a point of `cl S̃_a` at distance exactly 1 from an essential boundary point) has
  `d̄_a(y) > 0`. True in every map whose sectors at vertices have positive angle (no cusps).
- **H2(x)** — `x` has an open disc `U` in which, up to null sets, only two colours `a, b` occur and `S̃_a ∩ U`, `S̃_b ∩ U` are path-connected.
  True at every interior point of an edge of a map, and at a map vertex where exactly two sectors meet (a *bend*); false at a vertex with a
  repeated colour, at a comb, and wherever a third colour accumulates.

### 2.2 FS111-W-C11 — the two-colour sandwich: a saturated interface is `C^{1,1}` with curvature at most 1  [hand, one mind]

**Statement.** Let `f` be saturated, `x` a point with H2(x) and H-DEN at its contacts. Then there is a disc `U′ ∋ x` in which the interface
`∂S̃_a ∩ U′` is a `C^{1,1}` curve of curvature at most 1, and at every point `p` of it exactly one of the following holds: **(i)** the colours'
contacts are `p + n_b(p)` for `a` and `p − n_b(p)` for `b` (`n_b` the unit normal pointing into `b`), both *outer*: `a`'s partner lies beyond
the `b`-side at distance 1 and conversely, and the open unit discs about them are externally tangent at `p`, one inside each colour; **(ii)** the
interface is, near `p`, an arc of the unit circle about a point `y` that is a contact for **both** colours (`y ∈ cl S̃_a ∩ cl S̃_b`): a unit arc
of kind both (FS-112's word).

*Proof.* Let `y_a, y_b` be contacts of `x` (saturation; H-DEN puts them in `A*_a`, `A*_b`). C-HULL's first clause (TRUE, two minds) applied at
`y_a` to the path-connected set `C_a = S̃_a ∩ U`: `C_a ⊂ B(y_a, 1)` ("inner") or `C_a ∩ B̄(y_a, 1) = ∅` ("outer"); likewise for `b`. Since `U ⊂ C_a ∪
C_b` up to a null set: *outer–outer* gives `B(y_a, 1) ∩ U ⊂ C_b` and `B(y_b, 1) ∩ U ⊂ C_a`, two open unit discs with `x` on both boundaries lying in
disjoint sets, so their circles are externally tangent at `x` (circles crossing at `x`, or equal, would make the discs overlap near `x`): case (i).
*Inner–outer* gives `B(y_b, 1) ∩ U ⊂ C_a ⊂ B(y_a, 1)`: a unit disc through `x` contained near `x` in another unit disc through `x` is the same
disc, so `y_a = y_b =: y`, `C_a = B(y, 1) ∩ U` a.e., the interface is `T₁(y) ∩ U`, and `y` is a contact of both colours: case (ii). *Inner–inner*
gives `U ⊂ B(y_a, 1) ∪ B(y_b, 1)` up to a null set, impossible: two closed unit discs with `x` on both boundaries leave a set of positive measure
uncovered in every neighbourhood of `x` (half of it if they coincide, a sector if they cross, two cusp regions if they are tangent). Every point of
the interface in a smaller disc `U′` has H2 and so the same dichotomy; so the region `C_a` satisfies the interior and the exterior unit-ball
condition at every boundary point in `U′` (in case (ii) the exterior of a unit disc contains an externally tangent unit disc), and a region with
the two-sided ball condition of radius 1 has `C^{1,1}` boundary of curvature at most 1 (a standard fact about the uniform ball condition, not
re-derived here; prior-art debt: its source is not yet in `BIBLIOGRAPHY.md`). ∎

*Corollaries.* **FS111-W-NOBEND:** a saturated colouring (H-DEN) has no bend — two edges meeting at an angle `≠ π` with two colours around —
since H2 holds there and C11 gives a `C^1` interface. [hand, one mind] **FS111-W-CURV:** at every point with H2, the interface's curvature is at
most 1, equal to 1 exactly on arcs of kind both. [hand, one mind] So **V0-WIG7's wiggled hexagons are not saturated** (their edge points are free,
and C11 forbids curvature above 1), and saturation removes exactly the freedom V0-WIG7 used.

### 2.3 FS111-W-NOREP — no colour occupies two sectors at a vertex of a saturated map  [hand, one mind]

**Statement.** Let `x` be a cone point of a saturated colouring (H-DEN): finitely many arcs end at `x` with distinct tangent directions, the
sectors between them have positive angle, each sector is one colour, and H2 holds at the arc points near `x`. Then the sectors at `x` carry
pairwise distinct colours. In particular a saturated map has no bichromatic vertex of degree `≥ 4` and no vertex with a repeated colour.

*Proof.* Let sectors `A, A′` have colour `a`, and `r` an edge of `A` with unit normal `n` at `x` pointing out of `A`. For `p ∈ r` near `x`, C11 at
`p`: in case (i), `a`'s contact is `y_a(p) = p + n(p)` and (C-HULL at `p`) the `a`-piece at `y_a(p)` lies outside `B̄(p, 1)` — if it lay inside, the
fat `a`-regions near `p` (on the `−n` side) and near `y_a(p)` (on the `−n` side of it) would contain pairs at every distance near 1, a violation. As
`p` runs over a subarc of `r`, the points `y_a(p)` sweep an arc near `x + n` with a set of positive measure of `a`-density points just beyond it.
If `A′` contains a direction `δ` with `δ · n > 0`, the unit circles about those points cut `A′` near `x` in arcs of positive length, a set of
monochromatic unit pairs of positive `Leb ⊗ σ` measure: violation. In case (ii), `r` is a unit arc of kind both centred at `y ≈ x − n`, and the
`a`-piece at `y` is within distance `< 1` of `A`, so `y`'s piece, `A` and `A′` (which touches `A` at `x`) lie in one block, whose diameter is at most
1; hence `A′ ⊂ B̄(y, 1)`, which near `x` is the closed half-plane on `A`'s side of `r`'s tangent. Either way `A′` lies in that closed half-plane; by
the same argument at `A`'s other edge `r′`, `A′` lies in the intersection of the two closed half-planes, which is `A` itself when `A` is convex and a
subset of `A` when it is not. `A′` has interior directions outside `A`: contradiction. ∎

### 2.4 FS111-W-LADDER — a flat edge of a saturated map carries a ladder of interfaces at unit spacing  [hand, one mind]

**Statement.** Let `e` be a segment of interface of a saturated map (H-DEN, H2 along it), colour `a` on the `−n` side and `b` on the `+n` side. Then
`e + kn` lies in the interfaces for every `k ∈ ℤ` (at generic points of `e`); along the normal line through a generic `x ∈ e`, write
`x_k = x + kn` and let `β_k, τ_k` be the colours just above `x_k` and just below `x_{k+1}`: then `β_k ≠ τ_k` (so every unit segment of the line
contains a colour change strictly inside it) and `β_{k+1} = τ_{k−1}`.

*Proof.* A flat edge is not a unit arc, so C11 case (i) holds along `e`: `a`'s partners `x + n` and `b`'s partners `x − n`. As `x` runs over `e`
they sweep the segments `e ± n`, which are therefore interfaces (every partner is an essential boundary point), flat, with H2 at generic points;
apply case (i) there and induct. The colour rules: at `x_k` the colour below (`τ_{k−1}`) has its outer partner at `x_{k+1}` with that colour beyond,
so `β_{k+1} = τ_{k−1}`; `β_k = τ_k` would put fat regions of one colour facing each other at distance 1. ∎

*Consequences, exact.* (1) **FS111-W-HEXSAT** — a tiling by congruent regular hexagons carries a saturated colouring only if its width (distance
between parallel edges) is `1/m`, `m ≥ 2` (parallel edges along a normal line are spaced by the width, the ladder needs spacing dividing 1, and
diameter `≤ 1` needs width `≤ √3/2`); at width `1/2` the colour rule forces period 3 along every lattice line, so the colouring is `3Λ`-periodic, and
no two of the nine classes can share a colour (every merge of two cosets of `3Λ` puts two hexagons with `dist < 1 < maxdist`): **exactly nine colours,
`HEX9`**, checked exactly (`tools/fs111_w_check.py`, object `hex9`: P, T and S hold; plants `hex16` and `hex9big` fail T and S). [hand, one mind; the
colouring exact] (2) **No recolouring of the tight hexagonal seven-colouring's tiling, and none of the brick tiling's, is saturated**: along a normal
line the hexagons' parallel edges are spaced `√3/2` and the bricks' `4/5` (rows) and `3/5` (columns), so the rung `e + n` falls in a tile's interior.
[hand, one mind] (3) SQ9 and HEX9 satisfy the ladder with case (i) at every edge point (outer contacts on both sides), as the check's facing-edge test
certifies.

### 2.5 FS111-W-HEX7-RIGID — the tight hexagonal seven-colouring admits no local junction or island  [derived; sampled exact check]

**Statement.** In hex7 (circumradius `1/2`), a colour `c` is *free* at `p` (a small disc about `p` may be recoloured `c` with no unit pair of interior
points) only if `c` is the colour of a tile containing `p` or, near an edge, the colour across it. Near a vertex `v` of colours `a, b, c` the
colours admissible for a modification supported near `v` are confined, to first order, to three open half-planes (the unit discs about the vertices
opposite `v` in the three hexagons), whose pairwise intersections are cones of half-width 30° disjoint from the third half-plane. Hence **every
a.e.-proper colouring that agrees with hex7 outside a small neighbourhood of a vertex or an edge has, in that neighbourhood, no junction other than
the original vertex and no island**. *Derivation:* the half-plane computation (the `a`-hexagon's far vertex `v′_a` is at distance exactly 1 from
`v`, so an `a`-point near `v` must lie in `B(v′_a, 1)`, the open half-plane of directions within 90° of the bisector of `a`'s sector; the three
bisectors are 120° apart). *Check:* `tools/fs111_w_hex7_free.py` (exact, sampled: 114 edge points, 169 interior points of the base hexagon): no edge
point has a free third colour and no interior point has two free foreign colours; the plant (the same test at circumradius `2/5`, where the colouring
has slack) finds a free third colour at 36 edge points and two foreign colours at 14 interior points — the instrument sees freedom where there is
some. Output `data/fs111/fs111-w/hex7_free.out`. *What it means:* the one tight seven-colouring the claim list uses as a control is locally rigid;
every accumulation or decoration of a tight seven-colouring lives where the colouring has slack (V0-WIG7's principle), where a local modification
also removes it.

### 2.6 The verdicts on route M's rungs

| claim | verdict | grade, minds | evidence |
|---|---|---|---|
| **C-SAT-T** | **TRUE at `k ≥ 9`; GAP at `k = 7, 8`** — as written (modification unrestricted) it is TRUE at `k` iff a saturated a.e.-proper `k`-colouring exists; SQ9 and HEX9 give `k ≥ 9`; at `k = 7, 8` none is known, and any would have to have `C^{1,1}` interfaces of curvature `≤ 1` (C11), no bend, rainbow vertices (NOREP), flat edges only in unit ladders with `β_{k+1} = τ_{k−1}` (LADDER), and unit arcs only of kind both; the two tight seven-colourings held (hex7, brick7) cannot be recoloured into one (HEXSAT (2)). At `k ≤ 6` its negation implies `χ_m⁰(ℝ²) ≤ k` (W-NEG) | [tools, exact] for `k ≥ 9`; [hand, one mind] for the structure | §1.5, §2.2–§2.4 |
| C-SAT-T, the **fill reading** (the brief's "fills never saturate") | **TRUE in the weak sense, and it is the reason saturation is a limit**: FS111-W-FILL-FREE — after a fill on `B(x, η/2)` at a `j`-free `x` (`A_η(x) ∩ S̃_j` null), every new `j`-boundary point `y` is `j`-free (`A_{η/2}(y) ⊂ A_η(x)`); so no finite sequence of fills creates a contact for the filled colour, and fills are not monotone (the colours removed may become free at the new boundary). Starting from hex7 no fill sequence can reach a saturated colouring with hex7's edges (HEXSAT (2)) | [hand, one mind] | §2.4 |
| **C-HULL-REG** | **TRUE at every bichromatic point with H2 and H-DEN; so TRUE on every saturated map without cusps** (a map's bichromatic points are edge-interior points and bends; NOBEND removes bends, NOREP removes repeated colours, C11 gives a `C^{1,1}` graph, semiconcave and semiconvex). It can fail only at a bichromatic point where H2 fails: a comb or accumulation of components, or a third colour accumulating with density 0. *The named kind it survives:* every saturated map without cusps (G21) | [hand, one mind] | §2.2–§2.3; SQ9, HEX9 as inhabitants |
| **REG-B_k**, existence form | TRUE at `k ≥ 7` (hex7), not W-refutable at `k ≤ 6` (W-NEG) | [hand] | §1.4 |
| REG-B, **universal form** ("every tight colouring's classes have tight block structure") | **FALSE at `k = 7`**: FS111-W-DECO-B, hex7 with two squares `[1/2, 13/25] × [−1/50, 1/50]` and its mirror added to every hexagon's class (inside the neighbouring hexagons), is a.e.-proper and tight, and every class has a hexagon within distance `< 1` of two squares at mutual distance exactly 1 with maxdist `√677/25 > 1`: no block structure. A decoration — a local modification removes it | [tools, exact: `tools/fs111_w_blocks.py`, three plants each firing for its own reason; output `data/fs111/fs111-w/blocks.out`] | this table |
| **REG-J_k**, existence form | TRUE at `k ≥ 7` (hex7), not W-refutable at `k ≤ 6` (W-NEG) | [hand] | §1.4 |
| REG-J, universal and local forms | **no wild object found, and the reason is named**: hex7 is junction-rigid under local modification (HEX7-RIGID); junction accumulation is available only where a colouring has slack (V0-WIG7's principle), where a local modification removes it. "Junctions that accumulate in every modification" at `k ≥ 7` is impossible for global modifications (W-NEG) and would need, for local ones, a *self-sustaining* forcing: an accumulation at `p` forced by the colouring at distance 1, itself accumulating — the same propagation the island analysis below meets | [derived] | §2.5 |
| REG-I_k, REG-A_k | existence forms TRUE at `k ≥ 7`, not W-refutable at `k ≤ 6` (W-NEG); their universal forms fail at `k = 7` by V0-WIG7 (non-arc smooth interfaces), which I do not re-derive | [hand] | §1.4 |
| PER, NO-C2 | not W-refutable (W-NEG: their failure is a six-colouring). *A bearing for M:* if route M passes through saturation, the NO it needs is for `C^{1,1}` interfaces of curvature `≤ 1` with rainbow vertices and kind-both unit arcs (C11, NOREP) — a class neither contained in NO-C2's (`C²`) nor containing it, and much smaller than NO-C2's in its curvature | [derived] | §2.2 |

### 2.7 Where C-HULL-REG could still fail: the island obstruction (a reading, with its test)

A bichromatic point `x` violating H2 through a third colour `c` accumulating at density 0 needs small `c`-pieces near `x`, each saturated. A
`c`-piece `Q` of diameter `< 1` has no inner contact except within a block of diameter exactly 1, and its outer contacts lie on the outer parallel
curve `∂N₁(Q)` at distance 1. If `Q`'s boundary is smooth, its outer-contact points form a closed curve of diameter `≥ 2` whose `c`-pieces are
chained at mutual distance `< 1`, i.e. one block of diameter `≥ 2`: impossible. So a small piece must be polygonal with corners (its facing
partners break at the corner arcs, of chord `2 sin(θ/2)` for an exterior angle `θ`, which must be `≥ 1`: at most six sides), and its partners
are facing edges at distance exactly 1 — themselves small where the pieces near `x` differ in position by less than their size, so the
accumulation propagates to the points at distance 1 along the ladders (§2.4). *Reading:* **a saturated colouring with a bichromatic point where a
third colour accumulates is a web of accumulation points closed under the ladder translations, and none exists.** *Killing test:* such a web
given by formula (a self-similar or lattice-periodic saturated colouring with accumulating polygonal islands). [reading, one mind]

### 2.8 Registered (instruments for G21, scored at the close)

- **W-P1:** no saturated a.e.-proper 7-colouring exists (0.65). If it comes true, C-SAT-T is not colour-generic, and a route-M proof through
  saturation must use six specifically. Both outcomes reachable: a saturated 7-colouring by formula refutes it; a proof that saturated maps need
  eight or more confirms it.
- **W-P2:** the least `k` with a saturated a.e.-proper `k`-colouring is 9 (0.3). Reachable both ways: an eight-colour saturated colouring, or a proof.

*Would-have-searched here, stage 2:* (a) a local search for a saturated 7- or 8-colouring over periodic polygonal tilings → instead derived the ladder
rule and HEXSAT, which say which tilings can be saturated at all; (b) a finder for tight seven-colourings with accumulating junctions → instead
probed hex7's free colours exactly and derived HEX7-RIGID; (c) a scan over island shapes near a bichromatic point → instead derived the island
obstruction (§2.7).

## Stage 2 — SAVED
