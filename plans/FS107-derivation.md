# FS-107 — theorems proved outside the kernel (the derivation file)

*Filed by the close planner FS107-C (de Bruijn, Opus 5.5), 2026-09-27, from the records `plans/FS107-R-stability.md` (R, competitor for stability),
`plans/FS107-W-near-colourings.md` (W, competitor for near-colourings; R and W blind to each other until hand-back), `plans/FS107-V-verification.md`
(V, blind on R until its stage 3, `abcb19ac`), `plans/FS107-VW-verification.md` (VW, blind on W until its stage 3, `ef9e955a`), and the advisors'
records `plans/POROS-2026-09-27-fs107-stability.md` (FS107-A, planning) and `plans/POROS-2026-09-27-fs107-competition.md` (A2, competition; §5 the
round's verdict). Reconciliation: `plans/FS107-stability.md` §R-close stage 1. Notation: `data/fs107/claims.md` §0 and `data/fs106/claims.md` §0;
SEQ is the sequence object (periodic grid-square partial six-colourings with slack `ε_n → 0` and holes `δ_n → 0`), LIM the limit object (a tight
a.e.-proper six-colouring in the normal form). A **fat junction** (R §3.2): three arcs `I_a, I_b, I_c` with truncated cones `K(x, I_j; r, s) ⊆ C_j`
(`r` the void's radius, `s` the scale); it **blocks direction `θ` on side `σ` with margin `µ`** if each `I_j` meets the open arc of half-width `π/2 − µ`
about `θ` (or `θ + π`). `𝓜_K` (W §2.1, VW §4): periodic designs with at most `K` circular or straight arcs per tile, arc radii at least `1/K`, at most
`K` tiles per unit disc. Grades carry no nested brackets (FS-106 inventory item 83).*

**The milestone's result in one paragraph.** Both competitors' claims are GAP, and their open steps pair up exactly. R's reduction: stability
(`χ_m⁰(ℝ²) ≥ 7`, row 131) follows from (A) a forced complementary pair of fat junctions blocking toward a common unit point in every disc `U_R`
and (B) a lower bound on the junctions' cone scale — because two such junctions force holes of area independent of the band (FS107-R-CP, two minds,
one blind). W's equivalence: at bounded arc complexity, vanishing holes exist iff a full tight a.e.-proper six-colouring by a map of that complexity
exists (W-EQ-K, two minds, one blind); in such a map every pair of complementary-type vertices within distance 2 is a tangent pair or a bowtie
(W-TAN, over C-T-TAN), except possibly at cusp vertices. The two meet at one question — the tangency-seam question, FS-110 — and at one regularity
statement for unbounded complexity (REG-SCALE). No-gos: polygonal bounded designs keep their holes (W-POLY, bar `d = 2`); an argument reading only
the away-facing colour at a flat swap is of hitting form (OB′ corrected). Measured: the hexagonal seven-colouring with one class absorbed by straight
triangles stalls at hole density `π/(42√3) ≈ 0.0432` (HX-STALL). Nothing moves a value.

## §1. The stability side (R), verified by V

**FS107-R-SAT — For a saturated band-proper partial six-colouring (`ε > 0`), the uncovered set is almost everywhere the open set `{z : |A_ε(z) ∩ C_j| > 0 for all six j}`, `A_ε(z)` the band annulus about `z`. [hand; two minds, one blind: R; V]**
*Proof:* R §3.1; V §2.4 (`g_j = 1_{C_j} ∗ 1_{A_ε}` is continuous; Fubini one way, saturation plus a density point the other). *Proof verdict:*
TRUE by both, same proof; needs `ε > 0` (V). Saturated families exist (R, Zorn along a countable cofinal sequence; V: standard). *Rests on it:* R's
WLOG on the hole set; the example invariant of X19. *Prior art:* a standard density-point argument; the statement not found in print. *Kernel:*
declined — a lemma of an open programme; formalized with R's half if it lands (X17).

**FS107-R-CP — Two fat junctions of complementary types (K-C6), at distance in `[η, 2 − η]`, both blocking with margin `µ` toward a point `w` at distance 1 from both, with scales `s, s′ ≤ s₀(µ, η) = µη²/100` and voids `2r < t₁`, `2r′ < t₁′`, force `|H ∩ B(w, µ/4)| ≥ (t₁ − 2r)(t₁′ − 2r′)`, `t₁ = s·sin(µ/2)/3`, for every `ε ≥ 0`; the bound is moved only `O(ρs)` by any repair inside radius `ρ` of the junctions, and the forced region contains an uncovered disc. [hand; two minds, different routes, one blind: R; V]**
*Proof:* R §3.2, Claims 1–2 (the ray–circle quadratic solved exactly; a box pulled back by `(|z − x| − 1, |z − x′| − 1)`); V §2.2 (V-CP, below:
projection with explicit curvature and direction errors), and V §4.2's line-by-line check of R's Claims (one harmless slip: `ρ ≥ t(1 − t/2)`, not
`ρ ≥ t`; only `ρ > r` is used). *Proof verdict:* TRUE under R §3.2's hypotheses; at `µ = 20°`, `s = 0.3` the forced area is `3.55·10⁻³` against the
bound `2.68·10⁻⁴`, and `37×` the bound at `s = 0.001` (`data/fs107/fs107-v/cp_check_R_hyp.out`). **The one-line form in R's "Theorems this phase proved"
omits the scale bound, the void bound and the definition of blocking, and is false without them** (V's C1, under V-CP). On LIM it is the cone case of
TS's C-T-TAN, quantified: C-T-TAN's cone case now has three derivations (TS; R, sighted of TS; V, blind to R). *Rests on it:* RR; the meeting point
(W-TAN ≡ CP on LIM, A2 §5.1); the tangency-seam question. *Prior art:* the qualitative form is `[Voronov2023]` Prop. 2.2's tangent form, FS106-TAN
(TS); the area bound not found in print. *Kernel:* stub — FS-101, with R's half if (A) and (B) land.

**FS107-V-CP — Read with fatness as "each colour's cone projects onto `(r, s·sin(µ/2))`" and blocking as a projection condition, with `s, s′ ≤ min(sin(µ/2), sin θ/18)`: `|H ∩ B(w, µ/4)| ≥ (s·sin(µ/2)/4 − r)(s′·sin(µ/2)/4 − r′)` for every `ε ≥ 0`, with an uncovered disc, stable to `O(ρs)` under repairs; for unrestricted `s` it fails (C1: `µ = 20°`, `s = 0.33`, holes `2.165·10⁻⁴` against `3.277·10⁻⁴`; failure window `≈ 1.54 sin(µ/2) < s < 2 sin(µ/2)`). [hand, one mind: V; the counterexample tools, float, grid-converged]**
*Proof:* V §2.2. *Proof verdict:* TRUE (one mind). *Rests on it:* the lesson that the curvature of unit circles subtracts up to `s²/2` from a
colour's exclusion range, so any quantified cone lemma carries a scale bound. *Prior art:* none found. *Kernel:* declined (FS107-R-CP is the form used).

**FS107-RR — R's reduction: given FS107-R-CP, (A) and (B) imply C-Q-STAB's disc form. (A): for some `R, η, µ` and every band-proper partial six-colouring with holes `< δ` in `U_R`, `U_R` contains a complementary pair of fat junctions at distance in `[η, 2 − η]` blocking toward a point at distance 1 from both. (B): those junctions are fat at a scale `s ≥ s₀`, with voids small relative to `min(s, µη²/100)`. Then `|H ∩ U_{R+1+µ/4}|` is bounded below independently of `ε`. The implication to C-VOID (R′) does not follow. [hand; two minds, one blind: R; V, after V's two repairs; the failure of R′ one mind: V]**
*Proof:* R §3.4 (Reading RR); V §2.3 and §4.2 (repairs: the disc lies in `U_{R+1+µ/4}`, not `U_{R+1}`; (B)'s `s₀` is a lower bound while CP's `s₀(µ, η)`
is an upper bound, so the cones are truncated at `s* = min(s, µη²/100)` and (B) bounds the voids relative to `s*`; quantifiers: `δ₀ = min(δ|U_R|,
(s₀σ/6)²)/|U_{R*}|`, all `ε`-independent). *Proof verdict:* the implication TRUE after the two repairs; **(A), (A″) and (B) open**; ⟹ R′ GAP at the
branch "holes `≥ δ` in `U_R`", which produces no disc (V). (A″), R's alternative to (A): price `[Voronov2023]` Lemma 6.1 branch (i) — the swap's
two-colour cost `≳ s^k` and S–V's deformed annulus (TS [G2]) — or re-route it ("bicycle-free Voronov") to end at a complementary pair. *Killing
test* (R §3.4): a proof of R using neither a complementary pair nor a scale lower bound; or a W family with holes `→ 0` whose junctions keep a cone
scale bounded below (then (B) true, (A) false). *Rests on it:* FS-110 (door (A)), REG-SCALE (door (B)), SWAP-PRICE (A″). *Prior art:* none found.
*Kernel:* declined — a reduction to open statements.

**FS107-R-SW — At a flat interface of scale `s` where a same-multicolour unit pair must swap: holes `≥ 2ε√(s² − ε²)` from the away-facing colour's pairs, sharp at `2εs`; and `|H ∩ (B(p, s) ∪ B(q, s))| ≥ s³/256` from the facing colour's pairs alone, for `s ≤ 1/2`, every `ε ≤ s²/32` and every hole set. [hand, with tools for two inequalities; the `εs` part two minds, one blind: R; V; the `s³` part one mind: V, blind, R's strips-only sketch agreeing]**
*Proof:* R §3.3 (pointwise on SEQ, `ε ≤ s/2`, `s ≤ 1/10`; the `s³` a sketch: strips of total width `≳ s²/2 + ε`); V §2.5 (a.e. fibre argument, so for
measurable classes too; the `s³` bound by a double count of band pairs between two regions of the facing half-discs, `β* ∈ (5s²/128, 0.53s²)`,
margin `1.2ε`; `tools/fs107_v_sw_check.py`). *Proof verdict:* TRUE; V audited the `s³` bound at a FALSE's rate (V stage 3) — its reach is narrow:
flat facing configurations, which a colouring avoids by curving its boundaries (TS-U's side cones). *Rests on it:* OB′ corrected; (A″)'s swap price
(`k = 3` at flat swaps). *Prior art:* none found. *Kernel:* declined.

**FS107-R-OB2 — (FS107-R-OB′, corrected) An argument that reads, at a flat swap, only the pairs of the away-facing colour is capped at `2εs(1 + o(1))` per swap (hitting form). As R stated it — "only the pairs of one colour … Stability must read both colours at a swap" — it is FALSE: the facing colour's pairs alone certify `s³/256`. [hand, one mind: V; R's statement FALSE]**
*Proof:* V §2.6 and §4.2 item 5 (the `εs` strip realises the cap; the `s³` proof reads only the facing colour). *Proof verdict:* corrected form TRUE;
R's form FALSE. *Rests on it:* E4's scoring (a named class of arguments, of HIT's logical type). *Prior art:* FS106-HIT (strips) is its sibling.
*Kernel:* declined.

**FS107-V-C5 — (observation) At a fixed scale `s`, a ring junction (three colours filling `B(x, s) ∖ B(x, r)`) with an interface exactly along `e_u^⊥` still forces a band of depth `≍ s²/2` on the inner side: configuration C5 forces area `6.8·10⁻⁵` at `s = 0.1` against an exactly tangent interface. Sketch of the general claim: "every ring junction blocks every direction, on one side or the other, at depth `≳ min(s·(angular margin), s²/2)`, unless a colour is a sliver near `θ ± 90°`". [tools, one instance, and a sketch; one mind: V]**
*Proof:* V §4.3 (for `ρ ∈ (−s²/2, 0)` the unit circle about `z` bends into the front half at radius `√(2|ρ|) ≤ s` and meets the front colour, its back
part the other two). *Proof verdict:* the instance TRUE (one mind); the general claim a candidate. *Killing test* (V): a ring junction and a direction
`θ` with no forced band on either side. *Rests on it:* if it holds, blocking is automatic for ring junctions, and the escapes left to door (A) are
cusps, bowties, slivers and scale `→ 0` — FS-110's first lemma. *Prior art:* none found. *Kernel:* declined.

*Not theorems, recorded here:* C-T-BIKE — R's hand arithmetic shows the pure `π/3`-arc shared-colour ansatz fails narrowly at `d = 1.9` (branch gap
58.4° and 59.3° against `> 60°`, two windows); the general tight two-colouring `E ∪ (E′ + 60°) ∪ …` unused; not decided (R §3.6).

## §2. The near-colouring side (W), verified by VW

**FS107-W-EQ-K — In `𝓜_K`, band-proper designs with `ε_n, δ_n → 0` exist iff a full tight a.e.-proper six-colouring by tiles of complexity at most `K` exists; ⟸ at complexity `O(K)`, periodised by a seam strip, with `δ(ε) = O(ε)`. [hand; two minds, one blind: W; VW]**
*Proof:* W §2.2 (tiles converge in a compact parameter space; recentring by TQ §3.3's maximal inequality); VW §2b.1 (arcs and faces converge; a
weighted average), with VW's sub-lemmas: **VW-ERODE** — a full a.e.-proper colouring by tiles with connected interiors, eroded by `r`, is band-proper at
every `ε < 2r`, with holes `O(Kr)` and complexity `≤ 2K` [hand, one mind: VW]; **VW-CPT** — designs with at most `K` arcs meeting each unit disc and
`ε_n, δ_n → 0` have, after recentring and a subsequence, a Hausdorff limit that is a full a.e.-proper six-colouring with `≤ K` arcs per unit disc [hand,
one mind: VW]; the seam strip (VW §4 item 2): cut a box of side `L`, remove a strip of width `1 + ε` along its boundary, cost `O(1/L)`, `L ≥ 1/ε`.
*Proof verdict:* TRUE at W's class; under a per-tile count alone (VW's (Ct)) the compactness step is a GAP that does not bear on `𝓜_K`. *Rests on it:*
door (A) = C-AE-Q2's question at bounded complexity; FS-110's decisive direction. *Prior art:* compactness (Blaschke selection); the periodic
approximation of one class is `[DeCorteOliveiraVallentin2022]` Lemma 6.2; the equivalence not found in print. *Kernel:* stub — FS-101, after row 131's
FS106-EQ, when door (A) is decided.

**FS107-W-POLY — Polygonal designs in `𝓜_K` have hole density `≥ δ₀(K) > 0` at every slack, bar FS106-AE-POLY's `d = 2` configuration. [hand; two minds, one blind: W; VW; over FS106-AE-POLY]**
*Proof:* W §2.3; VW §2b.3 (a polygonal limit by VW-CPT, excluded by AE-POLY). *Proof verdict:* TRUE. *Rests on it:* the claim-list correction of A2 §3.3's
"tight polygonal tilings … would do" (empty at bounded complexity, bar `d = 2`); E5 met. *Prior art:* over `[SokolovVoronov2025]` Thm 2 (FS-106's
repair). *Kernel:* declined.

**FS107-W-RATE — A full tight colouring in `𝓜_K` gives `δ(ε) = O(ε)`; `O(ε²)` when its contacts are uniformly isolated and linearly transversal (VW-PIN: one disc of radius `2ε/c` removed per contact). [hand; two minds, one blind: W; VW; the pinhole-test clause a reading]**
*Proof:* W §2.4 (hypothesis "as in 2.2"); VW §2b.2 (tangent contacts `O(ε^{3/2})`, tight curves `O(ε·length)` in both). *Proof verdict:* TRUE with
the hypothesis; the table line needs "as in W-EQ-K (`𝓜_K`)". *Rests on it:* the floor's order; R's pinhole test (pinholes sit at contacts, not
junctions, VW). *Prior art:* none found. *Kernel:* declined.

**FS107-W-TAN — In a full tight a.e.-proper six-colouring by a locally finite map whose boundaries are C¹ arcs with tangents at the vertices, two vertices at distance `< 2` whose essential multicolours are complementary three-sets form a tangent pair or include a bowtie; off those and the collinear distance-2 configuration, the three-element (and larger) vertex types of two adjacent tiles pairwise intersect. At a cusp vertex (a tile of angle 0), with types read as closure multicolours, it is a GAP. [derived; two minds, one blind: W; VW; over C-T-TAN, one mind: TS]**
*Proof:* W §2.5; VW §2b.4 (every blow-up is a cone for C¹ arcs; both `w₀` must be blocked). *Proof verdict:* first clause TRUE over C-T-TAN off cusps;
**GAP at cusp vertices** — the cusp colour has density 0 there, so `|P(u)| = 2` and C-T-TAN, which needs "all six classes in `P(u) ∪ P(v)`", is silent
(VW §4 item 4); general Jordan boundaries (spiralling, oscillating: C-T-TAN's exceptional set, AE-Q2's [G2]) GAP, outside `𝓜_K`; the second clause as
W stated it ("an intersecting family" of all vertex types) is MISSTATED — bichromatic vertices of degree `≥ 4` have two-element types disjoint from a
three- or four-set with no complementary pair; it holds for trivalent maps. *Rests on it:* FS-110's rule; the meeting point (≡ CP on LIM). *Prior art:*
none found. *Kernel:* declined.

**FS107-HX-STALL — Family HX (the hexagonal seven-colouring, the colour-0 hexagon absorbed by straight triangles into a six-chromatic junction, a void of radius `ρ` at its centre; `0 < ρ < R`, `ε > 0`) is band-proper in D-MU's null form iff `7R² − 4Rρ + ρ² ≤ (1 − ε)²` and `4R² + 2Rρ + ρ² ≥ (1 + ε)²`; every other same-colour class is implied by the second (pair 2); `δ = (2π/(21√3))(ρ/R)²`; the conditions force `ρ/R > 1/2`, so `inf δ = π/(42√3) ≈ 0.0432`, approached as `ε → 0` at `R = 2/√21`, `ρ = R/2`, attained by no member. [hand and tools, exact in ℚ(√3); two minds, one blind: W; VW]**
*Proof:* W §3.3–3.5 (pairs located from checker diagnostics; P-W1 and P-W2 lost, P-W3 won); VW §2a.2 (symbolic, every parameter: pair 2 minus pair 1
is `6t − 3`; the norm-4 hexagon slack by `3R(R − ρ)`), `tools/fs107_vw_hx_derive.py`, `tools/fs107_vw_hx_check.py`. *Proof verdict:* TRUE, stronger
than W stated (for every parameter, not only at members); nits: the null form allows equality where W writes `>`; the stall is an infimum.
*Rests on it:* E5 met; break-table row 3 fired (A2 §5.6); the stall is set by the islands constraint (K-ISL), a geometric fact inside the family, not
compactness. *Prior art:* the hexagonal seven-colouring is classical; the family not found in print. *Kernel:* declined — a measured fact about one
family.

**Tools (exact).** **W-CHK** (`tools/fs107_w_check.py`, closed squares, integer arithmetic on squared distances, three planted faults caught) and **W-HEX**
(the rasterised hexagonal seven-colouring with one class blank, `u = (31, 0)`, `v = (15, 27)`, `h = 1/40`: slack `1 − √1322/40 ≈ 0.0910`, uncovered density
exactly `1/7`) [tools, exact: W]; **VW-GRID** (`tools/fs107_vw_grid_check.py`, half-open squares, Fractions, a Hermite torus; hex7 − 1 blank density
`2513/17655` under centre rasterisation) and `tools/fs107_vw_member_check.py` (W's six members re-checked, all verdicts, exact slacks and densities
agree; `data/fs107/fs107-vw/members_check.out`) [tools, exact: VW]. *Kernel:* declined.

## §3. The advisors' results and the meeting point

**FS107-K-C6 — In a six-colour palette two three-element multicolours are disjoint iff complementary; a colouring avoids C-T-TAN's configuration iff in every disc of diameter 2 its junction types choose at most one triple from each of the 10 complementary pairs. [hand, one mind, trivial: FS107-A]**
*Proof:* FS107-A's record `plans/POROS-2026-09-27-fs107-stability.md` l. 16–19 (stage 1, E2), graded there "[hand, one mind, trivial.]"; no proof text recorded beyond that.
*Proof verdict:* "TRUE; one mind; CP is its metric content (R stage 4)" (`plans/FS107-stability.md` §R-close 1.3, l. 574). *Rests on it:*
FS107-R-CP's "complementary types (K-C6)" (§1 above); R's registered part (2), "I expect the voids at junctions of complementary type within
distance 2 (K-C6) to stop shrinking before that balance is met" (A2 §5.1, `plans/POROS-2026-09-27-fs107-competition.md` l. 265–267); FS107-A's
W-orient test (FS107-A l. 88–92). *Prior art:* none recorded (FS107-A l. 16–19 and the plan's §PA, `plans/FS107-stability.md` l. 366–396, checked). *Kernel:* declined.

**FS107-K-BICH — A map whose face-adjacency graph is connected and whose every vertex meets at most two colours uses at most two colours; so every six-colour map has a vertex where three colours meet. [hand, one mind: FS107-A]**
*Proof:* FS107-A's record l. 20–23 (stage 1, E2): "merge equal-coloured neighbours; then colours alternate around each vertex, so every
edge-neighbour of a face of colour `a` has one colour `b`, and connectivity spreads the pair." *Proof verdict:* "TRUE; one mind" (§R-close 1.3,
l. 575). *Rests on it:* FS107-A's door (R-ρ₀), "Anchors can be junctions, because junctions are unavoidable (BICH: every six-colour map has a
vertex where three colours meet)" (FS107-A l. 72–73); its W-orient test, "A single star (every junction contains colour 1) fails by BICH applied
to the complement of colour 1" (l. 91–92). *Prior art:* none recorded (FS107-A l. 20–23 and the plan's §PA, `plans/FS107-stability.md` l. 366–396, checked). *Kernel:* declined.

**FS107-K-AD — (a) An argument whose only use of the holes is "an effective hole within `Cε` of every anchor of a set `A`" certifies at most `≍ N(A ∩ Q, ε)·ε²` of hole area per unit square. (b) Reading: `Θ(1)` comes only from anchors of positive measure or holes of `ε`-independent size. [hand for a, one mind: FS107-A, credit TQ §4.4; b a reading]**
*Proof:* FS107-A's record l. 12–15 (stage 1, E1): the count by the `ε`-covering number, "`ε²` for finitely many anchors per unit area (A8b,
TQ-EPS2), `ε` for curves of anchors (TQ-HIT), `Θ(1)` only for anchors of positive measure — or for holes of an `ε`-independent size `ρ₀`"; the
grades split at l. 175–177, (a) "K-HIT's logical type, [hand, one mind]", (b) "the [reading]". *Proof verdict:* (a) TRUE; (b) not fired — FS107-R-CP's
holes are of the second kind (R stage 4). *Killing test of (b):* an argument whose anchors form a null set of dimension `< 2` certifying hole area bounded
below uniformly in `ε`. *Rests on it:* FS107-A's "So R has exactly two doors (TQ §4.4 names both; AD above interpolates)" (l. 70); the plan's
prediction E7, "K-AD (b) predicts it needs curves of anchors" (`plans/FS107-stability.md` l. 481). *Prior art:* none recorded in print
(the plan's §PA, `plans/FS107-stability.md` l. 366–396, checked); in-house, "it is TQ §4.4's dichotomy with the exponent interpolated, credit TQ" (FS107-A l. 15). *Kernel:* declined.

**FS107-MEET — The meeting point: R's (A) and (B) are W's doors (A) and (B) seen from the proof side; W-TAN and FS107-R-CP are one fact, C-T-TAN's cone case, read as a design rule and as an area. [derived, one mind: A2; each part two minds, one blind]**
*Proof:* A2 §5.1. *Proof verdict:* "a synthesis; both halves rest on C-T-TAN, whose cone case now has three derivations: TS; R (sighted of TS); V
(blind to R, read TS)" (§R-close 1.3, l. 578). *Rests on it:* FS-110 (bounded complexity) and REG-SCALE (unbounded). *Prior art:* none recorded
(A2 §5.1 and the plan's §PA, `plans/FS107-stability.md` l. 366–396, checked). *Kernel:* declined.

## §4. Re-attribution (prior art, not ours)

**FS106-SUP's periodic half, one class:** `[DeCorteOliveiraVallentin2022]` §6.1 Lemma 6.2 — "If D ⊆ (0, ∞) is bounded, then lim sup_{L→∞}
α_vol(G(Rⁿ/LZⁿ, D))/vol(Rⁿ/LZⁿ) = α_δ̄(G(Rⁿ, D))" — is the one-class form of "`µ₆^per(ε) = µ₆(ε)`", in print since 2018 (arXiv); the six-class form and
the tight–slack equality not found (plan §PA row 2). Its Lemma 6.1 is W's torus in their words.

## §5. Errata (appended by later closes; the text above stands as written)

**Erratum, 2026-09-28 — FS-111's close (job FS111-C), to FS107-HX-STALL's reading of HX's junctions.** Source: `plans/FS111-W-wild.md` §3.4
(FS111-W-HX-PAIRS [tools, float with margins; the junction types exact; one mind]), filed in `plans/FS111-derivation.md` § FS111-W-HX-PAIRS; inventory
`plans/FS111-close-inventory.md` item 21. **HX-STALL's statement above is unchanged and correct** (the band-properness conditions, the hole density,
the stall `π/(42√3)`). What is corrected is the gloss in its source record, `plans/FS107-W-near-colourings.md` (the junction paragraph after the stall
check, ll. 313–315): *"no complementary three-element types exist (K-C6 vacuous)"*. That counts only hole components. Under FS107-R-CP's definition HX
carries complementary pairs of fat junctions at distance `√7·R`, blocking toward points that lie inside its voids; so HX is not a family avoiding
complementary pairs (the kind R-P3 expected), and FS107-R-CP locates HX's holes without sizing them (its bound at HX's parameters is about `10⁻¹¹`,
against the stall `0.0432`; the size is K-ISL's, as this file says). Nothing in this file rested on the gloss: HX-STALL's *Rests on it* line names E5,
the break table and K-ISL only.
