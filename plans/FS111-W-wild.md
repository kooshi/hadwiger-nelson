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

## Would-have-searched-here log (standing rule 3)

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
