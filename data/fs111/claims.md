# FS-111 — the fixed claim list (statements only)

*Written by the milestone planner (job FS111-P), 2026-09-27. **Statements only: no proof, no sketch, no route.** Every quotation is verbatim, with
its source address; text outside quotation marks is this list's own and says so. Grades are `CLAUDE.md` § Notation's; "minds" counts derivations.
Give every claim you work one verdict — **TRUE** (with your derivation), **FALSE** (with a counterexample), **GAP at a named step**, or **MISSTATED**
(with the corrected statement, graded) — with your count of minds and your grade. FALSE and GAP are results, as valuable as TRUE (standing rule 4).*

**Objects.** Every claim names its object:
- **SEQ** — band-proper partial colourings (a slack `ε > 0`; holes allowed), in particular hole-vanishing sequences (`data/fs107/claims.md`, "SEQ").
- **LIM** — tight a.e.-proper full colourings in D-NF (below), in particular the limits of hole-vanishing sequences.
- **MAP** — map-type colourings (S–V Conditions 2–4), a.e.-proper (D-AEMAP).
- **ARG** — a statement about implications between other claims.

**The vacuity rule for this list (G30 failure mode 5; `CLAUDE.md` § The gate).** A claim about tight six-colourings may quantify over an empty
domain (it is empty iff `χ_m⁰(ℝ²) ≥ 7`, row 130). So every structural claim below is stated for **every `k`**, and a derivation of it must name an
inhabitant at `k = 7` (a tight seven-colouring given by formula) or say that it has none.

## 0. Definitions

- **`𝓜_K`** (`plans/FS107-W-near-colourings.md` §2.1, step 1, verbatim): "a periodic partial six-colouring of the plane by closed tiles, each bounded
  by at most `K` circular arcs (radius `≥ 1/K`) or segments, at most `K` tiles meeting any unit disc, periodic under a lattice." *Band-proper at slack
  `ε`*: "no monochromatic pair at any distance in `[1 − ε, 1 + ε]`" (`data/fs107/claims.md` §0, SEQ).
- **`f_K`, `δ₀(K)`** (this list's): `f_K(ε) = inf{uncovered density of P : P ∈ 𝓜_K band-proper at slack ε}` (`inf ∅ = 1`); `δ₀(K) = inf_{ε > 0} f_K(ε)`.
- **D-NF** (`data/fs106/claims.md` §0, verbatim): "For a measurable `f : ℝ² → [k]` proper at `Leb ⊗ σ`-almost every edge: `S_j = f⁻¹(j)`; `S̃_j` the
  points of density 1 of `S_j`; `E = ℝ² ∖ ⋃_j S̃_j` (Falconer's null set); `d̄_j(x) = limsup_{r→0} |S_j ∩ B(x, r)|/|B(x, r)|`; **`P(x) = {j : d̄_j(x) > 0}`**,
  the *essential multicolour*."
- **D-SLACK** (`data/fs106/claims.md` §0, verbatim): "A measurable `f` has *slack `ε`* in form (a) if `(Leb ⊗ Leb){(x, y) : f(x) = f(y), 1 − ε ≤ |x − y|
  ≤ 1 + ε} = 0` … *Tight*: slack for no `ε > 0`".
- **D-AEMAP** (`data/fs106/claims.md` §0, verbatim): "For a map-type colouring (Conditions 2–4) *a.e.-proper* means: no two points of **open regions**
  of one colour are at distance 1; boundaries and vertices carry no colour."
- **S–V Conditions 2–5** (`[SokolovVoronov2025]` §2, verbatim in `data/fs106/claims.md` §0, D-SV): Condition 2, "A Jordan (proper) coloring of the plane
  is a coloring in which the plane is partitioned into vertices, boundaries, and regions …"; Condition 3, "A Jordan coloring of a plane is called
  locally finite if any bounded subset of the plane intersects only a finite number of boundaries."; Condition 4, "A map-type coloring is a Jordan
  coloring that is also locally finite."; Condition 5, "If any boundary intersects with a circle of unit radius at a finite set of points, we say that
  arcs of unit curvature are forbidden."
- **Segment-and-arc map** (this list's): a map-type colouring whose boundaries are finite unions of segments and circular arcs.
- **Essential closure, essential boundary** (this list's): `A*_j = {x : d̄_j(x) > 0}`; `∂_e S_j = A*_j ∖ S̃_j`.
- **Free, contact** (this list's; `A_η(x) = {y : ||y − x| − 1| ≤ η}`): a point `x ∈ A*_j` is **`j`-free** if `|S̃_j ∩ A_η(x)| = 0` for some `η > 0`, and a
  **`j`-contact point** if some `y` in the closure of `S̃_j` has `|x − y| = 1`.
- **Fill move** (this list's): replace the colouring on a disc `B(x, ρ)` by the constant colour `j`.
- **Block structure** (Cohen–Mani, arXiv:2407.05071 §5, after `[KMOR2016]`, verbatim): "|x − y| < 1 for x, y in the same block A j , and |x − y| > 1 for
  x, y in different blocks". **Tight block structure** (this list's): a class is, up to a null set, a union of blocks of diameter `≤ 1` with
  `dist(B, B′) ≥ 1` for distinct blocks.
- **Q-NO** (this list's name for the map NO): `LEDGER.md` row 134 (verbatim: "no locally finite map of the plane whose boundaries are segments and circular
  arcs, none of radius 1, carries a six-colouring in which no two interior points of one colour are at distance exactly 1") together with FS-114's NO,
  the same with arcs of radius 1 allowed (`plans/STUB-global-step.md`; **open**).

## 1. Held inputs (use as held; each with its grade)

- **H-EQ** (row 131; `data/fs107/claims.md` §1, verbatim): "χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k ⟺ µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1 ⟺ for every δ > 0 there are ε > 0
  and a periodic partial k-colouring by half-open grid squares with no monochromatic pair at any distance in [1 − ε, 1 + ε], leaving density ≤ δ
  uncovered." [hand; two minds, one blind]
- **Row 130** (verbatim): "Given MR (row 128): `χ(ℝ²) = χ_m⁰(ℝ²)`". A tight D-NF `k`-colouring exists iff `χ_m⁰(ℝ²) ≤ k` (this list's reading of the
  definition D-M, `data/fs106/claims.md` §0).
- **I-D1** (`data/fs106/claims.md` §1, verbatim): "If `y ∈ S̃_j` and `d̄_j(x) = θ > 0`, then `|x − y| ≠ 1`." [hand, one mind]
- **W-EQ-K** (`plans/FS107-derivation.md` §2, verbatim): "In `𝓜_K`, band-proper designs with `ε_n, δ_n → 0` exist iff a full tight a.e.-proper
  six-colouring by tiles of complexity at most `K` exists; ⟸ at complexity `O(K)`, periodised by a seam strip, with `δ(ε) = O(ε)`." [hand; two minds, one blind]
- **FS107-RR, (A) and (B)** (`plans/FS107-derivation.md` §1, verbatim): "(A): for some `R, η, µ` and every band-proper partial six-colouring with holes
  `< δ` in `U_R`, `U_R` contains a complementary pair of fat junctions at distance in `[η, 2 − η]` blocking toward a point at distance 1 from both. (B): those
  junctions are fat at a scale `s ≥ s₀`, with voids small relative to `min(s, µη²/100)`. Then `|H ∩ U_{R+1+µ/4}|` is bounded below independently of `ε`."
  [hand; two minds, one blind, after two repairs]
- **FS107-R-CP** (`plans/FS107-derivation.md` §1, statement verbatim there, with its hypotheses) [hand; two minds, different routes, one blind].
- **FS107-R-SAT** (`plans/FS107-derivation.md` §1, verbatim): "For a saturated band-proper partial six-colouring (`ε > 0`), the uncovered set is almost
  everywhere the open set `{z : |A_ε(z) ∩ C_j| > 0 for all six j}`, `A_ε(z)` the band annulus about `z`." [hand; two minds, one blind]
- **FS106-AE-MAP6** (`plans/FS106-derivation.md` l. 121, verbatim): "No map-type colouring (Conditions 2–4) with five colours is almost-everywhere proper,
  modulo Townsend's simplification (c) as filled by Woodall's steps 2, 3, 5" [hand; one mind per link; the fill in outline]
- **`[Voronov2023]` Prop. 2.1** (verbatim): "Suppose that for D = [1 − ε, 1 + ε] there exists some proper k-coloring of the plane. Let the plane, in
  addition, be divided into tiles of arbitrary shape, different tiles can be of different shapes, the diameter of each tile does not exceed h, and 2h
  < ε. Then for the interval of positive length Dh = [1 − (ε − 2h), 1 + (ε − 2h)] there exists a proper k-coloring of the plane, in which the interior of
  each tile is monochromatic, and the border points are colored in some color of the adjacent tiles." [external, read]
- **`[Bukh2008]` Lemma 12 and the Supersaturation lemma** (arXiv:math/0703856v2, verbatim): Lemma 12, "If P is a finite supersaturable property, and A1 ,
  A2 , . . . is a sequence of sets with property P whose characteristic functions converge in the weak* topology of L∞ (Rd ). Then there is a nonnegative
  function A ∈ L∞ (Rd ) such that A1 , A2 , . . . → A in the weak* topology, and supp A = {x : A(x) > 0} has the property P ."; Supersaturation lemma, "For
  every ε1 , ε2 > 0 there is a constant c = c(ε1 , ε2 ) > 0 such that for any R > 0 there is δ0 = δ0 (ε1 , ε2 , R) such that the following holds. For any δ
  ≤ δ0 and any measurable set A ⊂ Rd if dQ(0,R) (Zδ (ε1 )A) > mQ(0,R) (P )(1 + ε2 ), then IP (A) ≥ cRd ." [external, read]
- **Cohen–Mani Lemma 2.4** (arXiv:2407.05071, verbatim): "Suppose Φ j ∈ L 2 (T2K ) is a uniformly bounded sequence which weakly converges in L 2 to Φ ∈
  L 2 (T2K ). Let f j◦ be the radialized autocorrelation function of Φ j and f ◦ the radialized autocorrelation function of Φ. We have f j◦ (r ) → f ◦ (r ) for
  every r ." [external, read]

## 2. Card 1 — the composition (object ARG; stage 2 of `plans/FS111-cone-scale.md`, one mind, FS111-P; for phase 0's blind verifier)

- **FS111-C1-UNIF** (verbatim): "`1 − lim_{ε→0} µ₆(ε) = inf_K δ₀(K)`. Hence (H-EQ at `k = 6`): **`χ_m⁰(ℝ²) ≥ 7` ⟺ `inf_K δ₀(K) > 0`.**" [hand, one mind]
- **FS111-C1-PW** (verbatim): "Q-NO ⟹ `δ₀(K) > 0` for every `K`." [derived, one mind; over W-EQ-K, row 134 and FS-114's NO]
- **FS111-C1-GAP** (verbatim): "Q-NO ∧ (B), in any of the three readings, implies seven only together with a third statement covering, respectively, `𝒩` at
  unbounded complexity (the first two readings) or the interfaces of the limit (the third)." Here `𝒩` is "the band-proper partial six-colourings (any `ε`,
  any `K`) with holes `< δ` in `U_R` and **no** such pair in `U_R`", and the three readings are "(B) as FS107-RR poses it", "(B) standalone at complementary
  pairs" and "(B) standalone at every junction, ring form (REG-J)" (stage 2, §2.4's table). [derived, one mind]
- **FS111-C1-FALS** (this list's wording of stage 2's check): the card's falsifier — "a derivation that every family with holes → 0 and cone scale ≥ s₀ has
  a subsequence of bounded complexity whose limit is a segment-and-arc map" — does not follow from (B) in any reading: its first half needs "cone scale
  `≥ s₀` ⟹ bounded complexity", and complexity also counts interfaces, which no reading of (B) constrains. [derived, one mind]
- **FS111-C1-ROUTES** (this list's summary of stage 2 §2.5): (R) CP + (A) at every complexity + (B) ⟹ `χ_m⁰(ℝ²) ≥ 7`, Q-NO idle; (M) Q-NO + REG₆ (§3) ⟹
  `χ_m⁰(ℝ²) ≥ 7`, the cone scale entering only as REG's rung REG-J. The front page's composition is (M) with REG-I and REG-A missing, or (R) with (A) at
  every complexity missing. [derived, one mind]

## 3. Route M — regularity (objects LIM and MAP; every claim for every `k ≥ 2` unless it says otherwise)

- **REG-A_k** (this list's): if a tight a.e.-proper `k`-colouring of `ℝ²` exists, then a segment-and-arc map carries an a.e.-proper `k`-colouring.
- **REG-I_k** (this list's): if a tight a.e.-proper `k`-colouring exists, then a map-type colouring (Conditions 2–4) is a.e.-proper with `k` colours.
- **REG-J_k** (this list's): if a tight a.e.-proper `k`-colouring exists, then one exists in D-NF whose points with `|P(x)| ≥ 3` form a locally finite set,
  at each of which the blow-up is a partition of the plane into finitely many closed sectors.
- **REG-B_k** (this list's): if a tight a.e.-proper `k`-colouring exists, then one exists each of whose classes has tight block structure.
- **C-SEVEN-M** (ARG, this list's): Q-NO ∧ REG-A₆ ⟹ `χ_m⁰(ℝ²) ≥ 7`.
- **C-SIX-M** (ARG, this list's): FS106-AE-MAP6 ∧ REG-I₅ ⟹ `χ_m⁰(ℝ²) ≥ 6`; given MR (row 130), `χ(ℝ²) ≥ 6`.
- **C-REG-EQ** (ARG, this list's): given Q-NO, REG-A₆ ⟺ `χ_m⁰(ℝ²) ≥ 7`; given FS106-AE-MAP6, REG-I₅ ⟺ `χ_m⁰(ℝ²) ≥ 6`. (REG's top rung at `k` is not a
  smaller statement than the answer at `k`; its rungs are.)
- **C-HULL** (this list's): let `S̃_j` be a class of a tight a.e.-proper `k`-colouring in D-NF and `C ⊆ S̃_j` path-connected; then every `x ∈ A*_j` has
  `C ⊆ B(x, 1)` or `C ∩ B̄(x, 1) = ∅`, so `A*_j ⊆ {x : sup_{c ∈ C} |x − c| < 1} ∪ {x : dist(x, C) > 1}`.
- **C-FILL** (this list's): if `x` is `j`-free with `|S̃_j ∩ A_η(x)| = 0`, the fill move on `B(x, η/2)` with colour `j` keeps the colouring a.e.-proper.
- **C-SAT-T** (this list's; the tight analogue of FS107-R-SAT): every tight a.e.-proper `k`-colouring can be modified, keeping it a.e.-proper with `k`
  colours, into one in D-NF in which no `x ∈ ∂_e S_j` is `j`-free, for every `j`; so every essential boundary point is a `j`-contact point for every
  `j ∈ P(x)`.
- **C-HULL-REG** (this list's): in a colouring as in C-SAT-T's conclusion, every `x` with `P(x) = {a, b}` has a neighbourhood in which `∂_e S_a` is the graph
  of a Lipschitz function, locally semiconcave or semiconvex (the planar description of `r`-convex boundaries; Rataj–Zajíček, arXiv:2512.17606 §1).
- **PER** (this list's; `CLAUDE.md` § The aim link 6's reading, verbatim: "finite perimeter is Lipschitz-in-probability, the quantitative form of the
  continuity every CP colouring has. Killing test: a CP colouring whose disagreement `P(c(0) ≠ c(h))` is continuous but not `O(|h|)` along every optimal
  family."): every hole-vanishing sequence of band-proper partial six-colourings can be replaced by one, still hole-vanishing, whose classes have perimeter
  density bounded uniformly in `n`.
- **NO-C2** (this list's; the curved extension of Q-NO): no map-type colouring whose boundaries are finite unions of `C²` arcs per bounded set carries an
  a.e.-proper six-colouring.
- **CM-Q5.1** (calibration, one class; Cohen–Mani §5, verbatim): "Question 5.1. Does there exist a set A with block structure and δ(A) = m 1 ?"

## 4. Route R — the cone scale on the sequence (object SEQ)

- **A-ALL** (this list's): FS107-RR's (A), quantified over every band-proper partial six-colouring of every complexity.
- **B-RR** (this list's): FS107-RR's (B) as posed, for the pair A-ALL supplies.
- **B-NONABS** (this list's; G40's form): at a close complementary pair of junctions blocking toward a common unit point, a band-proper partial six-colouring
  with holes `< δ` near the forced point has the junctions' cone scale `≥ s₀(δ) > 0`.
- **R-P3** (FS107-R's registration, verbatim, `plans/FS107-R-stability.md` §3.5): "**P3:** "bicycle-free Voronov" (A) is FALSE as a universal statement, and
  a W-type construction avoids complementary pairs at every scale (0.6)."

## 5. Controls (every phase)

- **The seven-colour controls** (row 33; G20): the hexagonal seven-colouring and the boundary-tight brick seven-colouring. Every structural claim of §3
  holds or fails on a tight seven-colouring in a named way, and every NO says where six is spent.
- **The strip and the disk** (row 136, verbatim: "valid six-colourings, tight, every unit arc of kind both and centred at a four-colour vertex"): valid
  tight six-coloured fragments; every local claim of §3 must hold on them.
