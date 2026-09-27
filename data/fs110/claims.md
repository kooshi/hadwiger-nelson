# FS-110 — the fixed claim list (statements only)

*Written by the milestone planner (job FS110-P), 2026-09-27. **Statements only: no proof, no sketch, no route.** Every quotation is verbatim, with
its source address; text outside quotation marks is this list's own and is marked "(this list)". Grades are `CLAUDE.md` § Notation's; "minds" counts
derivations. Give every claim you work one verdict — **TRUE** (with your derivation), **FALSE** (with a counterexample), **GAP at a named step**, or
**MISSTATED** (with the corrected statement, graded) — with your count of minds and your grade. FALSE and GAP are results, as valuable as TRUE
(standing rule 4). **Every statement about a tight six-map is about a possible object**: the domain is not known to be non-empty (VW §2b.4: "these
are statements about a possible object, not vacuous ones").*

**Objects.** **LIM**: a full tight a.e.-proper six-colouring by a map (the limit object). **SEQ**: band-proper partial six-colourings with slack
`ε > 0` and small holes (the sequence object; its members are eroded maps, VW-ERODE). **both**: statements about every such colouring, or about
arguments. Every claim names its object. Names: **V-C5** is FS107-V's tangent ring (FS107-V l. 145); **TS-C5** is FS-106's configuration where S–V's
Prop. 5 fails (`plans/FS106-TS-derivation.md` l. 200). Never write a bare "C5".

## 0. Definitions (quoted)

- **`𝓜_K`** (`plans/FS107-derivation.md`, header): "periodic designs with at most `K` circular or straight arcs per tile, arc radii at least `1/K`, at
  most `K` tiles per unit disc". *(this list)* For LIM, the same bounds without periodicity (VW-CPT's limit: "a full a.e.-proper six-colouring with
  `≤ K` arcs per unit disc").
- **Tight** (`data/fs106/claims.md` §0, D-SLACK): "*Tight*: slack for no `ε > 0`". Never Hoffman's sense (`CLAUDE.md` G54).
- **Siamese and outer** (`plans/FS107-stability.md` l. 348, after `[Parts2020c]` p. 2): "two distinct tiles of one colour have all cross-distances
  `≥ 1`, or all `≤ 1` (a "Siamese" pair, `[Parts2020c]` p. 2)".
- **Types** (`plans/STUB-tangency-seam.md`, § Types): "Say which multicolour a vertex carries: the *essential* one (colours of positive density at the
  vertex) or the *closure* one (colours of tiles whose closure contains it). They differ exactly at cusps; W-TAN's first clause holds for essential
  types, and is a GAP for closure types at cusps." Every claim below that mentions a type says which. *(this list)* "They differ exactly at cusps" is
  itself a claim, **D-TYPE**, open, for maps whose arcs have one-sided tangents at the vertices.
  The advisor's precise forms (FS110-A to FS110-P, 2026-09-27, verbatim): "`P_ess(u)`, the colours of positive upper density at u; and `P_cl(u)`, the
  colours of tiles whose closure contains u. `P_ess ⊆ P_cl`, with equality except at zero-angle tiles (cusps)." Written `P_ess`, `P_cl` below.
- **Covering pair** *(this list, after FS110-A's A-SIX)*: two vertices whose types (of one named kind) are disjoint and together hold all six colours.
  At sizes (3, 3) it is K-C6's complementary pair; sizes (2, 4) are the new case. C-T-TAN's proof uses its size hypothesis only through "(all six
  classes are in `P(u) ∪ P(v)`)" (TS l. 258), per A-SIX (§1b).
- **Complementary** (FS107-K-C6, `plans/FS107-derivation.md` §3): "In a six-colour palette two three-element multicolours are disjoint iff
  complementary". [hand, one mind, trivial]
- **Tangent pair and bowtie** (`plans/FS106-TS-derivation.md` l. 258, C-T-TAN's failure set): "**an interface at `u` tangent to the unit circle about
  `w₀`**"; "with one class in two opposite sectors (**the bowtie** `4,5,4,6`)".
- **Cusp** (`plans/FS107-VW-verification.md` §4 item 4): "**a cusp is a cone point whose tile has angle 0**: its colour has density 0 at the vertex, so a
  vertex with three colours in the closure has `|P(u)| = 2`, and C-T-TAN does not apply".
- **Ring junction** (`plans/FS107-derivation.md`, FS107-V-C5): "a ring junction (three colours filling `B(x, s) ∖ B(x, r)`)".
- **Sliver** — *(this list)* **undefined in its source** (V-C5's sketch: "unless a colour is a sliver near `θ ± 90°`"). Each job that uses it states its
  definition before its first use; the verifiers check that both sides used one definition.
- **Fat junction; blocking** (`plans/FS107-derivation.md`, header, after R §3.2): "A **fat junction** (R §3.2): three arcs `I_a, I_b, I_c` with
  truncated cones `K(x, I_j; r, s) ⊆ C_j` (`r` the void's radius, `s` the scale); it **blocks direction `θ` on side `σ` with margin `µ`** if each `I_j`
  meets the open arc of half-width `π/2 − µ` about `θ` (or `θ + π`)."
- **Close pair** — *(this list)* two vertices at distance `< 2`; W-TAN's `d = 2` collinear configuration is separate (§3).

## 1. The questions

- **Q-full** (the stub, § The question, verbatim): "Does a full tight a.e.-proper six-colouring of the plane by a locally finite map of bounded arc
  complexity exist?" Object: LIM.
  - YES: "a YES is decisive (`χ(ℝ²) ≤ 6` with no MR, through W-EQ-K)" (A2 §5.9). *(this list)* With five colours it would be `χ(ℝ²) ≤ 5`, a different
    outcome (G64); report it as such.
  - NO: "door (A) is dead at every `K` and C-AE-Q2 holds a.e. for locally finite arc-bounded maps" (A2 §5.1). *(this list)* `χ(ℝ²) = 7` follows only
    jointly with FS-111's (B) and only given MR (rows 128, 131, 133).
- **Q-rule** (A2 §5.1, verbatim): "is there a planar six-coloured map, tiles of diameter `≤ 1`, classes `≤ 0.2470`, same-colour tiles Siamese or `≥ 1`
  apart, whose complementary-type vertex pairs within distance 2 are all tangent pairs or bowties (and whose equal-type pairs in `(1, 2)` survive
  K-KILL's second half)?" — the stub adds: "**with cusps listed beside tangent pairs and bowties** (VW's GAP; inventory item 30)". Object: LIM.
  - "NO ⟹ door (A) is dead at every `K` and C-AE-Q2 holds a.e. for locally finite arc-bounded maps" (A2 §5.1).
  - "YES ⟹ a candidate door-(A) design, to be eroded and checked exactly" (A2 §5.1) — "not yet a colouring: the rule is necessary, not sufficient
    (G21)" (the stub).
- **Q-rule_cl and Q-rule_ess** *(this list)*: Q-rule read with closure types and covering pairs (the working form), and Q-rule read with essential
  types (W-TAN's form). Q-rule_ess's necessity rests on W-TAN (two minds, one blind); **Q-rule_cl's necessity rests on A-EXACT (§1b, one mind)**, and is
  used as necessary only once A-EXACT has a second mind. A NO of Q-rule_cl then covers cusps by construction.
- **The question in print** (`[SokolovVoronov2025]`, Question 2, held PDF): "Is it true that 7 colors are needed to color a locally finite map in the
  plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?" Their Condition 5: "If any
  boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden." Condition 6: "There
  are no trichromatic vertices of degree greater than 3." *(this list)* Q-full is Question 2 almost everywhere at bounded arc complexity, with cusps
  added (plan §PA row 3).
- **C-ACT1, Act One — seams are necessary** (`plans/FS107-W-near-colourings.md` §2.5, verbatim): "decide whether any planar map with six colours, tiles
  of diameter `≤ 1`, class densities `≤ 0.2470` and Siamese-or-`≥ 1` same-colour pairs satisfies the adjacent-tile intersecting rule with no tangency at
  all". *(this list)* The NO needs it: a map with no close complementary pair and no equal-type pair in `(1, 2)` would meet Q-rule vacuously. Object: LIM.
  Status: open.

## 1b. The local calculus — fixed before either side starts; each side derives these at its first stage, blind to the advisor's routes

- **A-EXACT** (`plans/POROS-2026-09-27-fs110-tangency-seam.md` l. 8, verbatim): "on a full tight a.e.-proper map colouring (open tiles, boundaries
  null), an interior point `z` of a colour-`j` tile has no interior point of a colour-`j` tile at distance exactly 1; so for a vertex `u` the set `B_u(s) =
  {z : ω(z) meets a tile of every colour of P_cl(u) inside B(u, s)}` is open and must be coloured outside `P_cl(u)`." **[hand, one mind, trivial: FS110-A]**.
  Its consequence (l. 58): "For complementary `u, v` the open sets `B_u(s)`, `B_v(s)` must be **disjoint**". Object: LIM.
- **A-CIRC** (l. 11, verbatim): "on such a map, every tile-interior point of `ω(u)` has a colour outside `P_cl(u)` (the closure type): the distance map on
  `tile(x) × sector` is open, connected and takes values on both sides of 1." **[hand, one mind, sketch: FS110-A]**. *(this list)* Check it for a cusp
  colour (a sector of angle 0). Object: LIM.
- **A-SIX** (l. 13, verbatim): "FS106-TS's proof of C-T-TAN uses `|P(u)| = |P(v)| = 3` only through "all six classes are in `P(u) ∪ P(v)`"; so it holds
  verbatim for disjoint types of sizes (2, 4)." **[read + hand, one mind: FS110-A]**. Object: LIM.
- **C-TAN-POS** (FS110-A to FS110-P, 2026-09-27, verbatim): "at positive scale a complementary pair survives at w₀ only by a strong escape on one side or
  a double unit-arc seam". Falsifier (same message): "a tight 𝓜_K map with a ring junction against a partner that blocks with margin." Status: open.
  Object: LIM. *(this list)* "Strong escape" (same message): "a colour in two sectors straddling the tangent line with margin".
- **D-TYPE** (§0): open.

## 2. The seams (each: close it, realise it, or name its GAP)

- **SEAM-T splits in two** (after FS110-A's record l. 103): **SEAM-T1**, a one-sided tangent interface, or a tangent interface whose relative curvature
  `κ` against `ω(w₀)` is not 1; **SEAM-T2, the double unit-arc seam**, verbatim: "`u, v` both emit arcs of `ω(w₀)`, and of `ω(w₀′)` for the second unit
  point, so `u w₀ v w₀′` is a unit rhombus of **vertices** (the spindle's rhombus), `ω(w₀) ∩ ω(w₀′) = {u, v}`". Townsend's ⅔π sector (§3) is a
  one-sided local model of T2 (the advisor's reading). V-C5 below is the band form of the tangent seam:
- **SEAM-T, tangent pairs — V-C5** (`plans/FS107-derivation.md`, FS107-V-C5, verbatim): "At a fixed scale `s`, a ring junction (three colours filling
  `B(x, s) ∖ B(x, r)`) with an interface exactly along `e_u^⊥` still forces a band of depth `≍ s²/2` on the inner side: configuration C5 forces area
  `6.8·10⁻⁵` at `s = 0.1` against an exactly tangent interface. Sketch of the general claim: "every ring junction blocks every direction, on one side or
  the other, at depth `≳ min(s·(angular margin), s²/2)`, unless a colour is a sliver near `θ ± 90°`"." **[tools, one instance, and a sketch; one
  mind: V]**. Killing test (V §4.3): "a ring junction and a direction `θ` with no forced band on either side." Object: SEQ.
  - **C-TAN-K, T1 closed** (FS110-A's restatement, verbatim): "in 𝓜_K no close covering pair is saved at a common unit point w₀ by a T1 tangent
    interface (one-sided, or κ ≠ 1)." Status: open. Object: LIM.
  - **C-T2**, the double unit-arc seam, split (after FS110-A): **(i) local** — *(this list)* is a double unit-arc seam consistent at `u, v, w₀, w₀′` (its
    cascade: `w₀, w₀′` are vertices whose own close pairs must also be seams) in a tight local fragment? **(ii) global** — can a whole tight `𝓜_K` map use
    it at every close covering pair it does not otherwise escape? Status: open.
- **SEAM-B, bowties** (`plans/FS106-derivation.md` l. 129, FS106-AE-Q2, verbatim in part): "[G2] Cor. 2's annulus at a bowtie, at a unit-arc boundary
  through u, at spiralling boundaries"; "[G4] Prop. 12's swap exclusion (FS106-IND-X)" — **[hand; one mind per step]**. FS106-IND-X (l. 172):
  "At a unit-arc interface facing a bowtie (or a 4-chromatic point) — configuration C5 with a colour in the side cones at y — complementary translate
  curves swap and |Ind γ₁ − Ind γ₂| = 2; the swap needs a unit-arc interface whenever the curves cross non-tangentially." **[hand + measured; one mind:
  SB; the checker re-run by A2]** (its "configuration C5" is TS-C5). **C-BOW-K**, split (FS110-A, verbatim): **(i) local** — "a bowtie with margin µ has
  B_u ∩ B(w₀, c) = ∅ for tilts < µ" (the advisor predicts TRUE: the bowtie is then realisable locally; a TRUE here is not a refutation of the NO);
  **(ii) global** — "no tight 𝓜_K map uses strong escapes at every close covering pair" — "This is where the NO must win: by area, by a priced swap, or by
  forcing a non-escaping partner." Status: both open.
- **SEAM-C, cusps** (`plans/FS107-derivation.md`, FS107-W-TAN, verbatim in part): "At a cusp vertex (a tile of angle 0), with types read as closure
  multicolours, it is a GAP." VW §4 item 4: "the cusp colour escapes C-T-TAN's pigeonhole at `w₀`, which needs "all six classes in `P(u) ∪ P(v)`"; a
  cusp constrains that colour near `w₀` only on one side of a slab." *(this list)* **C-CUSP-K**: in `𝓜_K`, no close pair of complementary closure
  types is saved by a cusp. Status: open. The advisor's hunch, registered beside it (`plans/POROS-2026-09-27-fs110-tangency-seam.md` §1.7, verbatim):
  "with closure types, a cusp vertex's blocking set near `w₀` is nonempty, so the cusp seam reduces to the tangent seam"; falsifier: "a cusp vertex with
  a blocking partner whose blocking set near `w₀` is empty".
- **SEAM-S, the same-type half (SWAP-PRICE, the bicycle)**:
  - K-KILL's second half (`plans/FS106-TS-derivation.md` l. 275, verbatim): "Same multicolour at distance in `(1, 2)`: Lemma 3's transplanted bicycle
    needs C-T-ANN's curves and C-T-IND's finiteness." **GAP** [hand, one mind].
  - C-T-BIKE (TS §4, verbatim): "**GAP — undecided here**; the step named: an explicit proper 3-colouring of `T₁(u) ∪ T₁(v)` by finitely many arcs (or
    a proof none exists), for each `d = |u − v| ∈ (1, 2)`". R's hand arithmetic (FS107-R §3.6): "the **pure `π/3`-arc ansatz fails narrowly there**"
    at `d = 1.9`; "general tight 2-colourings of a circle are `E ∪ (E′ + 60°) ∪ …` for any `E ⊂ [0, 60°)`, and I did not use that freedom".
  - (A″), R §3.4 verbatim: "price branch (i) instead: prove the swap's two-colour cost `≳ s^k` (the §3.3 sketch says `k = 3`), and price the deformed
    annulus (TS [G2]) likewise"; or "**"bicycle-free Voronov"**: re-route the same-type branch so that it too ends at a complementary pair. A first
    handle: in the overlap of the two deformed annuli about same-type junctions `u, v`, any junction of the three complementary colours is complementary
    to `u` at distance `≈ 1`, so it is priced by CP."
  - FS-108 item 2 (`plans/STUB-regular-half-residuals.md` l. 15): "**A second mind on S–V Lemma 3 at `√3 ≤ d < 2`** (FS106-SVL3): the printed
    three-curve proof covers `1 < d < √3` only; FS106-V2's transplanted bicycle is a sketch (constants not computed)". Shared with FS-108.
- **V5, the fifth vertex kind — bichromatic vertices of degree `≥ 4`, and four-colour vertices** (VW §2b.4, verbatim): "**But a bichromatic vertex of degree `≥ 4` has a
  two-element type**, e.g. `{1, 2}`. It can be disjoint from a three-set `{3, 4, 5}` or a four-set `{3, 4, 5, 6}` without either being a complementary
  three-set, and C-T-TAN says nothing about such pairs. These vertices are live: row 132 names them as where hole-filling fails." *(this list)*
  **C-V5-K**: in `𝓜_K`, a bichromatic vertex of degree `≥ 4` within distance 2 of a vertex whose type is disjoint from it is excluded, or realisable,
  or a named GAP. Status: open. Four-colour vertices (K-CHR4: "`|P(x)| = 4` open") enter through A-SIX's (2, 4) covering pairs; the advisor: "A
  four-colour vertex in a bowtie direction is an escape the stub does not list (G21)" (FS110-A to FS110-P, 2026-09-27).
- **C-SEAMLIST** *(this list; G21)*: at a vertex of a map in `𝓜_K`, the ways C-T-TAN's hypothesis can fail at a close pair are exactly: a tangent
  interface (T1 or T2), a bowtie or strong escape, a cusp, a sliver, a type with fewer than three essential colours or with four (V5), and `d = 2`. Status: open; an omission found is a result.

## 3. Shared constraints (each statement verbatim from `plans/FS107-derivation.md` unless marked; the grade as FS-107's close left it)

| id | statement | grade | object |
|---|---|---|---|
| W-EQ-K | "In `𝓜_K`, band-proper designs with `ε_n, δ_n → 0` exist iff a full tight a.e.-proper six-colouring by tiles of complexity at most `K` exists; ⟸ at complexity `O(K)`, periodised by a seam strip, with `δ(ε) = O(ε)`." | [hand; two minds, one blind: W; VW] | both |
| VW-ERODE | "a full a.e.-proper colouring by tiles with connected interiors, eroded by `r`, is band-proper at every `ε < 2r`, with holes `O(Kr)` and complexity `≤ 2K`" | [hand, one mind: VW] | both |
| W-TAN | "In a full tight a.e.-proper six-colouring by a locally finite map whose boundaries are C¹ arcs with tangents at the vertices, two vertices at distance `< 2` whose essential multicolours are complementary three-sets form a tangent pair or include a bowtie; off those and the collinear distance-2 configuration, the three-element (and larger) vertex types of two adjacent tiles pairwise intersect. At a cusp vertex (a tile of angle 0), with types read as closure multicolours, it is a GAP." | [derived; two minds, one blind: W; VW; over C-T-TAN, one mind: TS] | LIM |
| C-T-TAN | TS l. 258: "Let `k = 6`, `\|u − v\| < 2`, `P(u) ∩ P(v) = ∅`, `\|P(u)\| = \|P(v)\| = 3`. Suppose that along one sequence `r_n → 0` the rescaled classes … converge in `L¹_loc` … **If `T_u` and `T_v` both have positive length, the configuration does not occur.**" (the full statement at the address) | [hand, one mind: TS]; its cone case three derivations (TS; R sighted; V blind) | LIM |
| R-CP | "Two fat junctions of complementary types (K-C6), at distance in `[η, 2 − η]`, both blocking with margin `µ` toward a point `w` at distance 1 from both, with scales `s, s′ ≤ s₀(µ, η) = µη²/100` and voids `2r < t₁`, `2r′ < t₁′`, force `\|H ∩ B(w, µ/4)\| ≥ (t₁ − 2r)(t₁′ − 2r′)`, `t₁ = s·sin(µ/2)/3`, for every `ε ≥ 0`; the bound is moved only `O(ρs)` by any repair inside radius `ρ` of the junctions, and the forced region contains an uncovered disc." | [hand; two minds, different routes, one blind: R; V] | both |
| V-CP | the scale-restricted reading, and "for unrestricted `s` it fails (C1 …; failure window `≈ 1.54 sin(µ/2) < s < 2 sin(µ/2)`)" | [hand, one mind: V] | both |
| R-SW | "At a flat interface of scale `s` where a same-multicolour unit pair must swap: holes `≥ 2ε√(s² − ε²)` from the away-facing colour's pairs, sharp at `2εs`; and `\|H ∩ (B(p, s) ∪ B(q, s))\| ≥ s³/256` from the facing colour's pairs alone, for `s ≤ 1/2`, every `ε ≤ s²/32` and every hole set." | [hand, with tools; the `εs` part two minds, one blind; the `s³` part one mind: V] | SEQ |
| R-OB2 | "An argument that reads, at a flat swap, only the pairs of the away-facing colour is capped at `2εs(1 + o(1))` per swap (hitting form)." | [hand, one mind: V] | arguments |
| RR | "given FS107-R-CP, (A) and (B) imply C-Q-STAB's disc form" (the full (A), (B) at the address) | [hand; two minds, one blind, after V's two repairs] | both |
| W-POLY | "Polygonal designs in `𝓜_K` have hole density `≥ δ₀(K) > 0` at every slack, bar FS106-AE-POLY's `d = 2` configuration." | [hand; two minds, one blind] | SEQ |
| W-RATE | "A full tight colouring in `𝓜_K` gives `δ(ε) = O(ε)`; `O(ε²)` when its contacts are uniformly isolated and linearly transversal" | [hand; two minds, one blind; the pinhole clause a reading] | SEQ |
| HX-STALL | "`inf δ = π/(42√3) ≈ 0.0432`, approached as `ε → 0` at `R = 2/√21`, `ρ = R/2`, attained by no member" (family HX, at the address) | [hand and tools, exact in ℚ(√3); two minds, one blind] | SEQ |
| K-BICH | "A map whose face-adjacency graph is connected and whose every vertex meets at most two colours uses at most two colours; so every six-colour map has a vertex where three colours meet." | [hand, one mind: FS107-A] | LIM |
| TS-U | `plans/FS106-TS-derivation.md` l. 15: "a unit-arc boundary with colours `c \| c′` puts `c` in the wedge facing it and `c′` in the wedge facing away at its centre, and neither in the two side cones" | row 132: "TS-U … two, one blind" | LIM |
| TS-C | "clusters have diameter at most 1" (TS §2.4 heading) | "[two minds, one blind]" (`data/fs107/claims.md` K-ISL) | both |
| FS106-IND | "complementary curves with no swap satisfy \|Ind γ₁ − Ind γ₂\| ≤ 1 for any continuous lifts" (`plans/FS106-derivation.md`) | [hand; the bound two minds, one blind] | LIM |
| K-DENS | "each class `≤ m₁(ℝ²) ≤ 0.2470` (row 129's input)" (`data/fs107/claims.md` §2) | [external]; `0.246989` re-checked [cert + hand] | both |
| K-INT | "one-class-at-a-time and fractional arguments stop below 4.37 colours" (`data/fs107/claims.md` §2) | [hand], two minds (row 129) | arguments |
| K-TIGHT | FS106-AE-SLACK: "an a.e.-proper colouring with slack needs seven" | [hand; two minds, one blind], given `[Voronov2023]` Thm 1.3 | LIM |
| K-REG | "only polygonal limits are excluded (bar `d = 2`); curved bounded-complexity limits are live and decided by C-AE-Q2's [G1]–[G4]" (`data/fs107/claims.md` §2, the owner's correction) | row 132's grades | LIM |
| K-CHR4 | TS §5: "**GAP** — proved for `\|P(x)\| ≥ 5` off a null set; `\|P(x)\| = 4` open" | [hand, one mind] | LIM |
| K-HIT, K-AD | as `data/fs107/claims.md` §2 (arguments counting holes at circles cap at `ε`; anchors on a null set cap below `Θ(1)`) | [hand; two minds, one blind]; K-AD (a) one mind, (b) a reading | arguments |
| Townsend ⅔π | `plans/FS106-V-verification.md` l. 368–374: "So the counterexample is right, and **sharp at `2π/3`**. It uses a boundary that is a **unit arc**" | [hand, one mind: FS106-V] | a local model |

## 4. Killing tests

1. **V-C5's** (FS107-V §4.3): "a ring junction and a direction `θ` with no forced band on either side."
2. **RR's** (FS107-R §3.4): "a proof of R that uses neither a complementary pair nor a scale lower bound; or a W family with holes `→ 0` whose junctions
   keep a cone scale bounded below."
3. **The seven-colour control** (after `data/fs107/claims.md` §3, R's test 2): "The argument must fail on the slack hexagonal 7-colouring, and must name
   the step where "six" is spent (TS's K1 rule)." *(this list)* Also on the tight hexagonal seven-colouring and on Townsend's ⅔π sector.
4. **The Parts calibration** (`data/fs107/claims.md` §3, R's test 1): "Apply R's mechanism to `[Parts2020c]`'s tiling, eroded to slack `2κ`. If the
   argument forces more than `δ₆ + O(ε)` of holes there, it is wrong."
5. **Strip and pinhole tests** (`data/fs107/claims.md` §3, R's tests 3 and 5), for every area argument.
6. **The exact check** (`data/fs107/claims.md` §3, W's test 1): "Its falsifier is a monochromatic pair of squares whose distance interval `[min, max]`
   meets `[1 − ε, 1 + ε]`." *(this list)* For a full tight map: a same-colour tile pair — **including a tile with itself (diameter `≤ 1`)**, FS110-A —
   whose exact cross-distance range has 1 in its interior (for open connected tiles, the same as "contains 1"). "W's
   exact check certifies MEMBERS" (FS107-A, `data/fs107/claims.md` §3).
7. **Class density** (W's test 3): "Each class's density is at most 0.2470."
8. **G71's** (`CLAUDE.md` G71): the index bound "fails only at a swap"; *(this list)* a bowtie seam that defeats the index without a swap refutes it.
9. **C-TAN-POS's** (the advisor, verbatim): "a tight 𝓜_K map with a ring junction against a partner that blocks with margin."
10. **The bicycle's** (the advisor, verbatim): "a formula arc 3-colouring of T₁(u) ∪ T₁(v) at some d ∈ (1,2). Checking it exactly is allowed under the
   ban; scanning φ is not."
11. **Act One's** (the advisor, verbatim): "a tight 𝓜_K map in which every diameter-2 disc's junction types form an intersecting family (K-C6) and there
   is no same-type pair in (1,2)."
12. **C-SEAMLIST's** *(this list)*: a close complementary (or V5) pair in a `𝓜_K` map, not at `d = 2`, where C-T-TAN's conclusion fails and none of the
   listed failures occurs.

## 5. Failure clauses (the stub, § Registered expectations, verbatim; two added)

- "a NO for trivalent maps only is a result, not the question (bichromatic vertices of degree `≥ 4` stay live)".
- "a NO that uses a per-tile complexity count alone meets VW's (Ct) compactness GAP".
- "a YES candidate that fails the exact check measures the candidate, not the question."
- *(this list)* A list of seam kills with no Act One (C-ACT1) decides nothing.
- *(this list)* A seam priced only in the blow-up (scale `→ 0`) is FS-111's (G82), not FS-110's; at bounded `K` state the feature scale `s(K)`.

## 6. Not claimed (for reference)

W-TAN at cusps; C-VOID (FS-109); (A), (A″), (B) of RR; FS107-V's general C5 claim (one instance and a sketch); any value of `χ(ℝ²)`.


## 7. Round 3 (the owner's addendum, 2026-09-27; the two sides' records and the verifiers' carry the proofs)

**Round 2's product, as the round-3 frame.**
- **NB-4:** under Condition 5, no vertex of a tight six-map in `𝓜_K` has four colours.
- **NB-5:** so under Condition 5 no tight six-map has a close covering pair.

Both are [hand], two minds, one of them blind: FS110-NB derived them, and FS110-A4 checked them step by step. A4's precision on NB-5: it needs no
disjointness, because the branch colours at the seam point lie outside `u`'s type and outside `v`'s type, which are two disjoint sets.

**The round-3 question**, quoted verbatim from the competition advisor's record (`plans/POROS-2026-09-27-fs110-competition.md` § A4-2.3; the grades are
A4's):


**Under Condition 5 (no boundary arc of radius 1), the tangency seam is closed.** A tight six-map in `𝓜_K` has:
- no four-colour vertex (NB-4) and no close covering pair (NB-5), hence no swap (N2-SWAP) and no odd tile (N2-FLIP);
- rings that all wind, `|W| ≥ 2`, consistently along edges (N2-TRANS);
- no same-type monotone pair in `(1, 2)`, given A4-BAND and a transposed swap.

So **Q-full under Condition 5 is one question: does a winding map exist?** W-POLY adds that such a map is not polygonal (bar `d = 2`), so it needs
curved arcs of radius `≠ 1`. [NB-4/NB-5: two minds, one blind; the rest one mind each, as stated.] **Outside Condition 5** the live objects are:
- (S1) and T2;
- NB-4's exception (arcs of `ω(y_k)` through the change points);
- A4-SIX-ARCS's `≥ 6` unit arcs at a four-colour vertex.

**W-3 (the winding question).** Does a winding map exist? A winding map is a tight six-map in `𝓜_K` satisfying Condition 5, in which:
- every trivalent vertex's ring winds `|W| ≥ 2`, consistently along edges (N2-TRANS);
- every tile has an even count (N2-FLIP);
- there are no four-colour vertices (NB-4).
- **YES** (a winding map, given by formula and checked exactly) is a full tight six-map, so `χ(ℝ²) ≤ 6` with no MR (W-EQ-K).
- **NO** decides the Condition-5 half of `[SokolovVoronov2025]` Question 2 almost everywhere, at bounded `K`: a partial answer, and reported as one.

The unit-arc branch ((S1), T2, NB-4's exception, A4-SIX-ARCS) is not round 3's object.
