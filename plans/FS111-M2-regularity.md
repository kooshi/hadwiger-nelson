# FS111-M2 — the regularity side of FS-111, round 2: the rungs on maximal covers, the selection at five, the top rung

*Job FS111-M2 (de Bruijn, Opus 5.5), opened 2026-09-28 08:47 UTC. Brief: `data/fs111/briefs/M2-111-regularity-round2.md`, which points to FS111-M's
brief `data/fs111/briefs/M-111-regularity.md` and to `data/fs111/briefs/STANDING-RULES.md` (rule 0 read first); where they differ the round-2 brief
wins. Working files: `data/fs111/fs111-m2/`; tools `tools/fs111_m2_*.py`. Saved in stages; each stage's section is headed "Stage n — SAVED" and
committed before the next begins. Notation: `data/fs111/claims.md` §0 (D-NF, `S̃_j`, `P(x)`, `A*_j`, `∂_e S_j`, free, contact, fill) and round 1's
M-SATC (`plans/FS111-M-regularity.md` §2.2: admissible cover, `≤`, `F_j = supp A_j`).*

## Theorems this phase proved

*(one line per theorem: statement, grade, count of minds, address; every structural theorem names its `k = 7` inhabitant)*

- **M2-COV** — a `k`-tuple of measurable sets is a maximal admissible cover iff each coordinate is a maximal (a.e.) unit-avoiding set and their union
  has full measure: every regularity rung on maximal covers is a statement about one maximal unit-avoiding set — class by class — and the colour count
  enters only through "the union is full" and the selection — [hand, one mind] §1.4. Inhabitants at `k = 7`: R7 (a partition), DISC7 (§1.6, with
  overlaps).
- **M2-ZERO** — a measurable `A` is maximal unit-avoiding iff `A = {φ_A = 0}` a.e., where `φ_A(p) = σ{w ∈ S¹ : p + w ∈ A}` (the circular average
  of `1_A`): unit-avoiding is `φ_A = 0` a.e. on `A`, maximal is `φ_A > 0` a.e. off `A` (independent and dominating, measurably) — [hand, one mind] §1.4.
- **M2-INT** — for every a.e.-unit-avoiding `A`, the topological interior of its density set, `int Ã`, contains no point at distance exactly 1 from
  `cl Ã`: `int Ã ∩ (cl Ã + S¹) = ∅` — [hand, one mind; over I-D1, two minds] §1.5.
- **M2-FIX** — a maximal unit-avoiding set `A` that is regular (`A = F` a.e. and `|∂F| = 0`, `F = supp A`) satisfies the shadow identity
  `int F = ℝ² ∖ (F + S¹)`: the unit shadow of `F` is exactly the complement of its interior; so every unit circle centred in `F` misses `int F`, and
  every component of `int F` lies inside or outside each such circle — [hand, one mind] §1.5. Inhabitants: R7's classes, DISC7's classes.
- **M2-DISC7** — the circumscribed discs of the tight hexagonal seven-colouring (radius `1/2`, centred at the hexagon centres, coloured as the
  hexagons) form a maximal admissible seven-cover with regular classes whose overlaps have positive measure; each class has density
  `π/(21√3/2) = 2π/(21√3) ≈ 0.1727`, and the seven sum to Kershner's thinnest-covering density `2π/(3√3)` — [hand + exact check pending stage 2] §1.6.
- **M2-HULLC** — C-HULL-REG on maximal covers: every component of a regular maximal class lies inside or outside each unit circle centred in the
  class, so it satisfies the exterior ball condition of radius `1/2`, is semiconcave with constant 1 where its boundary is a graph, and has finite
  perimeter; near any point the class is carved by the unit circles about its own points (near components through their open spindle hulls, far ones
  through their unit neighbourhoods), so its boundary lies on unit parallels (outer and far) of its own components; on the pinch set of two classes
  M-PINCH/M-C11 hold verbatim. Semiconvexity (`|κ| ≤ 1` on the convex side) FAILS on covers (DISC7: curvature 2) — [hand, one mind; finite perimeter
  over a classical fact] §2.1. Inhabitants: R7, DISC7 (exact), SQ9 at nine.
- **M2-EXTREME-C** — round 1's M-EXTREME is FALSE on maximal covers (DISC7's components have no singular point) — [hand + exact, one mind] §2.2.
- **M2-PINCH-C** — a regular maximal class containing two blocks at vertical distance 2 whose facing boundaries are flat and a smooth graph touching
  its flat unit parallel exactly on a Cantor set, and otherwise isolated near the gap, has infinitely many components accumulating on that Cantor set —
  [hand, one mind; conditional on such a class existing, which is the reading "MUA-FIN-U is FALSE"] §2.3.
- **M2-SELCOMP** — in a saturated colouring, for every unit-avoiding enlargement `A` of a class, no interface point lies in `int Ã`, so the class is
  null or full on each component of `int Ã`: saturated means maximal at interfaces; from a regular maximal cover a saturated selection is a choice of
  whole components forming a partition; if every component has exclusive points, a saturated selection exists only if the cover is a partition; and a
  regular maximal partition (a measurable fall colouring) is saturated — [hand, one mind; over Federer 4.5.11, external] §3.1. Inhabitant: R7.
- **M2-NOSEL** — DISC7 has no saturated selection (the lens): selecting from a given maximal cover is not a colour-generic route to honest saturation
  — [hand + exact, one mind] §3.1.
- **M2-REDUCE-C** — if some maximal `k`-cover has regular classes whose boundaries form a locally finite plane graph (REG-J′-C_k), then REG-I_k; at
  `k = 5`, with FS106-AE-MAP6, `χ_m⁰(ℝ²) ≥ 6`, hence `χ(ℝ²) ≥ 6` given MR — with **no** honest saturation: the selection is the free colouring of the
  arrangement's faces, and the colour count enters only at FS106-AE-MAP6 — [derived, one mind; over FS106-AE-MAP6's grade] §3.2.
- **M2-INTRAD** — in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′),
  the unit parallel of every (tangent) interface arc is again an interface arc, so radii of curvature drop by exactly 1 toward the centre and must stop at
  1: every interface has **integer** radius of curvature a.e., and is a chain of segments and circular arcs with finitely many of each radius locally —
  REG-CHAIN in a strong form; accumulation with radii → ∞ (LRA, FS-115's stuck ray) not excluded — [hand, one mind] §4.1.
  Controls: R7, the strip, SQ9, HEX9.
- **M2-REDUCE-A** — REG-A_k ⟸ honest C-SAT-T_k ∧ REG-J′_k ∧ ¬LRA; at six with Q-NO, `χ_m⁰(ℝ²) ≥ 7` — [derived, one mind] §4.1.
- **M2-DISCK7** — translates of a smooth non-circular body of constant width 1 (support `1/2 + sin³(3θ)/200`) at hex7's colour lattices form a regular
  maximal seven-cover with a locally finite arrangement: the cover form of REG-A is FALSE at seven, and on the cover route the NO at six must cover
  self-parallel curved boundaries (NO-PAR) — [hand + tools exact (sympy + rationals, three plants), one mind] §4.2.
- **M2-KERSHNER** — no admissible five-cover has classes that are unions of discs of radius `1/2`: such a class has density at most `π/(8√3)`, and five
  of them fall below `2π/(3√3)` — [hand over Kershner 1939 and Fejes Tóth's packing bound, external] §1.6.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none. (Four zbMATH queries for prior art, §1.3, are reading, not search.)
- Stage 2: would have searched for a wild maximal unit-avoiding set (a colourer or optimiser over pixel sets with an inclusion-maximality
  objective) → instead derived the local form of the shadow identity (M2-HULLC (iv)) and wrote a Cantor pinch down by formula (M2-PINCH-C), leaving its
  global completion as the named killing test.
- Stage 3: none (the lens is exhibited by formula, DISC7; no selection was searched for).
- Stage 4: would have searched for a saturated six-colouring or an interface of radius 2 → derived the radius descent (M2-INTRAD) instead; the
  curved maximal cover DISCK7 was written by formula (a support function), not found.

## Fence log (standing rule 13)

- Stage 1: `ls data/fs111/reports/` printed the names of round 1's reports (not fenced in round 2; none opened). The start-up git status printed the
  name `tools/fs114_yb2_exact.py` and `git log` printed FS-114 commit subjects ("FS114-YB2: stage 1b", "FS-114: proof round 3 logged; boundary audit
  launched", "FS114-N4: …"): names only, nothing of FS-114's opened. `plans/STUB-global-step.md` (open by the brief) grepped for two FS-114 names.

## Stage 1 — SAVED: quotation check; the cover as `k` maximal unit-avoiding sets; the shadow identity; DISC7

### 1.0 Resuming check

`plans/FS111-M2-regularity.md` and `data/fs111/fs111-m2/` did not exist at start: fresh start at stage 1.

### 1.1 Files read, in order

The round-2 brief; `data/fs111/briefs/STANDING-RULES.md`; FS111-M's brief `data/fs111/briefs/M-111-regularity.md`; `CLAUDE.md` § The aim and
§ Counter-priors (rule 0), G24, G54 (fall colouring), G82, G83 (in context and on disk); `plans/FS111-M-regularity.md` in full (my round-1 record);
`plans/FS111-VMW-verification.md` in full; `plans/FS111-W-wild.md` in full (open in round 2); `data/fs111/claims.md` in full; `data/fs106/claims.md`
§0 (D-SV, Conditions 1–5); `plans/FS106-derivation.md` (FS106-TW, -WO, -SV1, -SV2, -AE-CLOSED, -AE-POLY, -AE-CONV, -AE-NICE, -AE-MAP6, -AE-FA,
-AE-Q2); I-D1's two proofs (`plans/FS103-M-derivation.md` §3.1 D1; `plans/FS111-V0-verification.md` V0-ID1) — both use only that the class has null
unit pairs, so I-D1 holds for every a.e.-unit-avoiding set; `plans/STUB-global-step.md` (grep only); `BIBLIOGRAPHY.md` (grep "fall colo").

### 1.2 Quotation check (standing rule 5)

*Checked against the source on disk; "brief" is the round-2 brief unless marked.*

| # | quotation or attributed statement | source | verdict |
|---|---|---|---|
| 1 | "R7 (de Grey's Reuleaux 4+3 seven-colouring) is saturated, and it is a maximal admissible cover" | VMW §1.5 verdict; VMW-R7-COVER ("R7's seven classes form a **maximal admissible cover** in M-SATC's sense with disjoint classes") | faithful |
| 2 | "C-SAT-T's existence form is TRUE at `k ≥ 7`, a GAP at `k = 5, 6`. W-P1 and W-P2 are FALSE." | VMW D11, §2.4 | faithful |
| 3 | "REG-B: its existence form is TRUE and its universal form is FALSE (DECO-B)" | VMW D6: "REG-B_k (existence) TRUE at `k ≥ 7`; the universal form FALSE at `k = 7`" | **scope dropped**: "at `k ≥ 7`" and "at `k = 7`" are missing; the existence form is a GAP at `k = 5, 6` (round 1 §4.2). Nothing downstream here uses the dropped scope |
| 4 | "C-HULL-REG's common form is M-PINCH/M-C11, which needs no partner density. It has three minds on its cases." | VMW D2 ("M's form is the common form … Case analysis: three minds") | faithful |
| 5 | "W-NEG is TRUE: no wild object refutes an existence rung except by proving `χ_m⁰ ≤ k`" | VMW-NEG ("first two clauses TRUE; … B-RR … MISSTATED"); VMW D5 ("W's statement is my corrected form") | faithful for the clauses the gloss uses (1–2) |
| 6 | "M-REDUCE-I … honest saturation plus a locally finite singular set Σ at five colours gives `χ_m⁰(ℝ²) ≥ 6`" | round 1 §5.1: "(ii) singular set Σ is locally finite **with finitely many interface arcs at each of its points** (REG-J′_k, §4.1)" | **clause dropped — the same drop VMW §2.1 row 11 flagged in the round-1 brief**, repeated here and in item 1 of "Your side" ("REG-J′ (Σ locally finite)"). This record works REG-J′ with the clause |
| 7 | M-DEADLOCK: "no change near an edge saturates the hexagonal colouring" | round 1 §2.5 (no a.e.-proper colouring agreeing off `B(x, ρ)` has a contact for either edge colour inside `B(x, ρ)`) | faithful |
| 8 | REG-CHAIN: "chains of unit-parallel curves straight or ending at unit arcs, through row 134's shadow map" | round 1 §5.2: "every chain is straight or ends at (split) arcs **or at Σ**" | **clause dropped** ("or at Σ"); worked with it |
| 9 | C-SEVEN-M, "Given FS-114's NO this is seven" | `data/fs111/claims.md` §3: "Q-NO ∧ REG-A₆ ⟹ `χ_m⁰(ℝ²) ≥ 7`" | faithful (Q-NO is row 134 with FS-114's NO) |
| 10 | "every valid unit-arc map has a vertex of at least four colours (FS114-CV-EXISTS, two minds)"; "C114-LOCAL-F" | FS-114's working files (fenced); `plans/STUB-global-step.md` holds neither name (grep) | **not verifiable here** (fenced); used as context only, as the brief says |
| 11 | (FS111-M's brief, carried) "My goal is to fully solve, and then verify in Lean, HN. Then we publish." / "Let's see some ambition. I know we can do it." | `CLAUDE.md` § The aim / § Counter-priors | verbatim prefixes (checked in round 1 §1.2, re-read) |
| 12 | the owner's ruling (run the rungs on maximal covers; the selection last, where the count enters) | the brief itself | the owner's words; worked as stated |

### 1.3 Prior-art gate for the object this round introduces (reading, four queries)

The object of round 2 is **a maximal (by inclusion, up to null sets) measurable set with no unit pair in positive measure**, and **a partition of the
plane into such sets**. In graph theory the second is a **fall colouring** (idomatic partition: a partition into independent dominating sets), which
`BIBLIOGRAPHY.md` already holds under FS-67 (Dunbar, Hedetniemi, Hedetniemi, Jacobs, Knisely, Laskar, Rall, *Fall colorings of graphs*, 2000,
Zbl 0962.05020; title and review read, J40): FS-67 and G54 call it *gap-free*. In descriptive combinatorics the first is a measurable maximal
independent set. zbMATH (API, `ab:` field): `"unit distance" & "maximal" & "measurable"` — 1 hit (tropical norm, not this); `"fall coloring" &
"infinite"` — 2 hits (finite graphs); `"distance" & "measurable" & "maximal independent"` — 0; `"one-avoiding" | "1-avoiding"` — 47 hits, the
unit-avoiding density literature (`[AmbrusEtAl2023]`'s line) and nothing on maximality by inclusion. **Negative, at these words** (G21: the zero
measures the query): maximal unit-avoiding sets by inclusion and measurable fall colourings of the plane were not found in print.

### 1.4 M2-COV and M2-ZERO — a maximal cover is `k` maximal unit-avoiding sets [hand, one mind]

*Definitions.* A measurable `A ⊆ ℝ²` is **unit-avoiding** if `(Leb ⊗ σ){(p, w) : p ∈ A, p + w ∈ A} = 0`, and **maximal unit-avoiding** (MUA) if
moreover no unit-avoiding `A′ ⊇ A` has `|A′ ∖ A| > 0`. `φ_A(p) := σ{w ∈ S¹ : p + w ∈ A}` (defined for every `p` once a Borel version of `A` is fixed;
changing `A` on a null set changes `φ_A` on a null set, by Fubini).

**M2-COV.** An admissible cover `(A_1, …, A_k)` is maximal iff every `A_j` is MUA. *Proof.* Enlarging one coordinate keeps the cover property and
touches only that coordinate's pair condition; so the product order is maximal iff each coordinate is. ∎ *With M-SATC (i):* every a.e.-proper
`k`-colouring lies below a maximal cover, so **a maximal `k`-cover exists iff `χ_m⁰(ℝ²) ≤ k`**, and every regularity statement about maximal covers is a
statement about MUA sets taken one at a time (G24's rule: said so; no such statement decides a colour count).

**M2-ZERO.** `A` is MUA iff `φ_A = 0` a.e. on `A` and `φ_A > 0` a.e. on `ℝ² ∖ A`. *Proof.* The pair measure is `∫_A φ_A`, so unit-avoiding is
`φ_A = 0` a.e. on `A`. If `G = {p ∉ A : φ_A(p) = 0}` has positive measure, some `G′ = G ∩ B(z, 1/3)` does; `A ∪ G′` has null pairs — `A × A` null;
pairs from `G′` into `A` have measure `∫_{G′} φ_A = 0`; pairs from `A` into `G′` have the same measure (`σ` is symmetric under `w ↦ −w`; substitute
`q = p + w`); `G′ × G′` has none (diameter `< 1`) — so `A` is not maximal. Conversely if `φ_A > 0` a.e. off `A` and `A′ ⊇ A` has `|A′ ∖ A| > 0`, the
pairs from `A′ ∖ A` into `A ⊆ A′` have measure `∫_{A′∖A} φ_A > 0`. ∎ *Reading.* A MUA set is a measurable **independent dominating set** of the unit
distance graph, and a maximal cover with pairwise null overlaps is a **measurable fall colouring** (every point sees every other colour at distance 1
in positive circle measure) — FS-67's and G54's *gap-free* colouring, now in the plane.

### 1.5 M2-INT and M2-FIX — interiors see no unit distance; the shadow identity [hand, one mind]

**M2-INT.** Let `A` be unit-avoiding, `Ã` its density-1 points. Then no point of `int Ã` is at distance exactly 1 from a point of `cl Ã`.
*Proof.* Let `x ∈ int Ã`, `B(x, ρ) ⊆ Ã`, and `y ∈ cl Ã` with `|x − y| = 1`. Take `q ∈ Ã` with `|q − y| < ρ/2` and put `x′ = q + (x − q)/|x − q|`. Then
`|x′ − q| = 1` and `|x′ − x| = ||x − q| − 1| ≤ |q − y| < ρ/2`, so `x′ ∈ Ã`. Two density-1 points of `A` at distance 1 contradict I-D1 (with `θ = 1`),
whose proof uses only that `A` has null unit pairs (§1.1). ∎

**Regular.** A MUA set `A` with support `F = supp A = cl Ã` is **regular** if `|F ∖ A| = 0` and `|∂F| = 0`. Then `int F ⊆ Ã` (a ball in `F` is
a.e. in `A`, so every point of it has density 1), hence `int F = int Ã`.

**M2-FIX.** If `A` is MUA and regular, then `int F = ℝ² ∖ (F + S¹)`, where `F + S¹ = {z : |z − y| = 1 for some y ∈ F}`. *Proof.* `⊆`: M2-INT with
`int F = int Ã` and `F = cl Ã`. `⊇`: M-SATC (ii), `ℝ² = int F ∪ (F + S¹)`, proved in round 1 §2.2 from maximality alone. ∎

*Consequences, used from here on.*
- **(F1) cut circles:** for every `y ∈ F`, `T₁(y) ⊆ F + S¹` misses `int F`; so every component `U` of `int F` (open, connected) lies in `B(y, 1)` or in
  `ℝ² ∖ B̄(y, 1)`. This is round 1's M-HULL1 promoted from density points to every point of `F`, and from path-connected pieces of `S̃_j` to
  components of `int F`.
- **(F2) contacts:** every point of `∂F` and every point outside `F` lies on a unit circle centred in `F`.
- **(F3) the class is a fixed point:** `int F = {z : T₁(z) ∩ F = ∅}` — the interior of a regular MUA set is exactly the set of points whose unit circle
  misses it. In graph terms, `F` is closed under "complement of the neighbourhood": a maximal independent set.
- *What regularity costs.* M2-FIX needs `int F ⊆ Ã`. For a general MUA set this is not proved: a MUA set whose support carries a positive-measure
  "dust" of holes (each hole point excluded by material at distance 1) is not ruled out here. In one dimension such sets exist (`A ∩ [2n, 2n+1) = E +
  2n`, `A ∩ [2n+1, 2n+2) = ([0,1) ∖ E) + 2n + 1`, `E` a fat Cantor set, is maximal for the distance 1 on `ℝ` with support all of `ℝ`); in the plane the
  question is **MUA-REG** (stage 2), a named hypothesis of every statement below that says "regular".

### 1.6 M2-DISC7 — a maximal seven-cover with lenses, by formula [hand; the exact check is stage 2's tool]

*The object.* Hex7: regular hexagons of circumradius `1/2`, centres `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4)`, colour `(m + 3n) mod 7` (round 1 and W §1.5).
**DISC7:** class `a` is `D_a = ⋃ {B̄(c(m, n), 1/2) : m + 3n ≡ a (mod 7)}`, the circumscribed discs.
- *The colour lattice.* `L_0 = {c(m, n) : m + 3n ≡ 0 (7)}` is spanned by `c(1, 2) = (√3, 3/2)` and `c(−3, 1) = (−5√3/4, 3/4)`, both of norm `√21/2`;
  it is a hexagonal lattice of minimum distance `√21/2 ≈ 2.291` and covering radius `√21/(2√3) = √7/2 ≈ 1.323`.
- *Unit-avoiding.* A disc has diameter 1 (its unit pairs are the antipodal boundary pairs, null); two discs of one class are at distance
  `≥ √21/2 − 1 > 1.29`.
- *Maximal.* A point `z` outside every disc of class `a` has a class-`a` centre `c` with `1/2 ≤ |z − c| ≤ √7/2 < 3/2`; for `1/2 < |z − c| < 3/2` the
  circle `T₁(z)` crosses the disc `B̄(c, 1/2)` in an arc of positive length, so `φ_{D_a} > 0` a.e. off `D_a` (M2-ZERO).
- *Regular, a cover, with lenses.* Each class is a union of closed discs (regular). The discs contain the hexagons, so the seven classes cover the plane.
  Neighbouring centres are `√3/2 < 1` apart, so each disc meets six discs of other classes in lenses of positive area; each centre is at distance
  `√3/2 > 1/2` from every other centre, so every disc has **exclusive points** (in no other class).
- *Densities.* One class: `(π/4)/(21√3/8) = 2π/(21√3) ≈ 0.17274`; seven: `2π/(3√3) ≈ 1.2092`, Kershner's thinnest covering density by equal discs —
  DISC7 is the hexagonal thinnest covering by discs of diameter 1, split into seven 2-separated classes.
- *Shadow identity, by hand.* For `z` outside the open discs of class `a`: `T₁(z)` meets `D_a` iff `1/2 ≤ |z − c| ≤ 3/2` for some class-`a` centre,
  which always holds (covering radius `√7/2 < 3/2`); for `z` in an open disc of class `a`, `|z − c| < 1/2` and every other class-`a` centre is more than
  `√21/2 − 1/2 > 3/2` away, so `T₁(z)` misses `D_a`. So `int D_a = ℝ² ∖ (D_a + S¹)` exactly (M2-FIX).

**M2-KERSHNER** [hand over two classical bounds, external]. A class that is a union of discs of radius `1/2` with null unit pairs has its centres
pairwise more than 2 apart (two such discs whose centres are within 2 have interior points at distance 1), so by the packing bound for discs of
radius 1 its centre density is at most `1/(2√3)` and its density at most `π/(8√3) ≈ 0.2267`; five classes cover density at most `5π/(8√3) ≈ 1.134`,
below Kershner's bound `2π/(3√3) ≈ 1.209` for any covering by equal discs. So **no admissible five-cover is made of radius-`1/2` discs**; six classes
(`≈ 1.360`) are not excluded by this count. *What it shows:* a count can enter through the covering condition — how the classes fit together — and
not class by class (G24): the bound is Kershner's covering density of the pieces' shape, which is available only because the pieces are congruent
discs. For general pieces of diameter `≤ 1` the covering density of the shape can be 1 (hexagons tile), and no such count is known.

## Stage 2 — SAVED: the rungs on maximal covers — C-HULL-REG and REG-J′ for covers; where the overlaps change round 1

*By M2-COV every rung here is a statement about one maximal unit-avoiding set, class by class (G24's rule: said so; none decides a colour count).
"Regular" (§1.5) is a named hypothesis, **MUA-REG**, wherever it appears.*

### 2.1 M2-HULLC — C-HULL-REG on covers [hand, one mind; (iii) over a classical fact]

*Statement (every `k`).* Let `F` be the support of a regular MUA set (a class of a regular maximal cover), `x ∈ ∂F`, and `U` a component of `int F`
with `x ∈ cl U`.
- **(i) one-sided unit discs.** For every contact `y ∈ F ∩ T₁(x)` (one exists, (F2)): `U ⊆ B(y, 1)` ("in") or `U ∩ B̄(y, 1) = ∅` ("out") — (F1). So
  at every point of `∂U` the open ball of radius `1/2` tangent there on the far side misses `U` (in: `B(x + (x − y)/2, 1/2)`, externally tangent to
  `B̄(y, 1)`; out: `B(x + (y − x)/2, 1/2) ⊆ B(y, 1)`): **`U` satisfies the uniform exterior ball condition of radius `1/2`**.
- **(ii) semiconcave where a graph.** Where `∂U` is locally the graph of a continuous `u` with `U` below it, both cases touch `u` from above by a function
  of second derivative `≤ 1`, so `u − s²/2` is concave: `u` is semiconcave with constant 1 (round 1's M-COVER-SC, now for components of `int F`).
- **(iii) finite perimeter per component.** Let `C` be the closure of the set of centres of the balls in (i). Every `x ∈ ∂U` has `d_C(x) = 1/2` (it lies
  on its own ball's circle, and inside no ball, since the balls are open and miss `U` while `x ∈ cl U`), so `∂U ⊆ {d_C = 1/2}`, the boundary of the
  `1/2`-neighbourhood of a compact set, which has finite length [external, classical, not read here: Federer 1959 — the complement of an open
  `r`-neighbourhood has reach `≥ r`, and sets of positive reach have boundaries of locally finite `H¹`]. So **every component has finite perimeter**.
  Whether a class does (finitely many components locally) is MUA-FIN, §2.3.
- **(iv) generation: the class is carved by unit circles about its own points.** For `r < 1/2`, `int F ∩ B(x, r) = B(x, r) ∖ ⋃_{p ∈ F_x} T₁(p)`, where
  `F_x = F ∩ cl A_r(x)` (the part of `F` within `r` of `T₁(x)`) — (F3), since every circle through a point of `B(x, r)` centred in `F` is centred in
  `F_x`. If `F_x` has finitely many components `K_1, …, K_m` (compact, connected), then, since `T₁(z)` meets a connected `K` iff
  `d_K(z) ≤ 1 ≤ D_K(z)` (`D_K` the farthest distance),

  `int F ∩ B(x, r) = B(x, r) ∩ ⋂_i ( H_i ∪ E_i )`, `H_i = ⋂_{p ∈ K_i} B(p, 1)` (the open spindle hull of `K_i`), `E_i = {d_{K_i} > 1}`,

  with `H_i ∩ E_i = ∅`. So near `x` every component of `int F` is, for each `i`, either **near** `K_i` (inside the intersection of the open unit discs
  about all its points — a convex set whose boundary curves by at least 1) or **far** from it (outside the union of the closed unit discs about its
  points), and `∂F ∩ B(x, r) ⊆ ⋃_i (∂H_i ∪ {d_{K_i} = 1})`: **the class boundary near `x` lies on finitely many "far levels" `{D_{K_i} = 1}` (convex
  arcs, the class inside) and "near levels" `{d_{K_i} = 1}` (outer unit parallels, the class outside)**. This is round 1's REG-CHAIN structure (unit-
  parallel curves) found inside one class: every boundary arc of a maximal class is a unit parallel (outer, or far) of another part of the same class.
- **(v) two-sided on the pinch set.** Where `∂F_a` and `∂F_b` of two classes coincide along an arc and, near a point `x` of it, only `a` and `b` carry
  measure (`N ⊆ A_a ∪ A_b` a.e.) with `A_a ∩ N` and `A_b ∩ N` each a.e. one connected open set with `x` in both closures, round 1's M-PINCH and M-C11
  hold verbatim: `C^{1,1}`, `|κ| ≤ 1`, a unit arc of kind both or two tangent unit discs (the overlap change in (out, out) is in §2.2).

*Inhabitants at `k = 7`* (exact, §2.4). **R7** — a maximal cover with disjoint classes (VMW-R7-COVER): every class boundary point is a pinch point, every
interface is (v)'s (split) type, and each Reuleaux tile is carved by the unit circles about its own three corners (a constant-width body is its own
spindle hull: `⋂_{p ∈ K} B̄(p, 1) = K`). **DISC7** — overlapping classes: every class boundary point lies inside another class's disc (a lens arc), so
only (i)–(iv) apply; the contact of every boundary point is its antipode in the same disc ("in"), every disc is its own spindle hull, and the class
boundary has curvature 2. **SQ9** (`k = 9`) — disjoint; every edge point is "out" on both sides at distance 1, the outer parallel of a flat edge a flat
edge (W's LADDER).

*What survives of C-HULL-REG as stated, on covers.* **Semiconcavity: yes** (ii). **Semiconvexity (`|κ| ≤ 1` on the convex side): no** — DISC7's class
boundaries have curvature 2; the round-1 bound `|κ| ≤ 1` comes from the partner colour's contact, which a cover does not supply off the pinch set.
**"Graph of a Lipschitz function": GAP**, as in round 1, at two named configurations: a component's horn (R7's down tiles at their cusps; a
horn tip is not a single graph) and two components of one class touching at a point (the honest bichromatic vertex of degree `≥ 4`).

### 2.2 Where a cover's overlaps change round 1's proofs

| round-1 result | on a maximal cover | the change, named |
|---|---|---|
| M-HULL1, M-HULL2 | hold, and stronger: (F1) holds for **every** `y ∈ F`, not only density points, and for components of `int F` | M2-INT replaces the density-point hypothesis (regularity used) |
| M-SATC | holds (it is where covers come from) | — |
| M-PINCH Step 1 | holds (class by class) | — |
| M-PINCH Step 2 | needs two contacts **at one point**; a cover supplies them only on the pinch set `∂F_a ∩ ∂F_b`. Off it (a point of `∂F_a` inside `int F_b`, a lens arc) only (i) holds | **the overlap band**: a cover puts the two classes' boundaries on different curves |
| M-PINCH, case (out, out) | round 1 used that `S_a`, `S_b` are disjoint ("the two open discs meet `N` in disjoint sets"). On a cover: `B(y_b, 1) ∩ N ⊆ A_a` a.e. (cover, and `A_b ∩ N` misses `B(y_b, 1)`), while `A_a ∩ N ∩ B(y_a, 1)` is null; so `B(y_a, 1) ∩ B(y_b, 1) ∩ N` is null, hence empty: tangent, as before | disjointness replaced by the one-component hypothesis on `A_a ∩ N` |
| M-C11 | holds on arcs of the pinch set; off it only (ii) | as above |
| M-EXTREME | **FALSE on covers**: DISC7's components have smooth boundaries and no singular point at all | round 1's proof put a unit disc of the region's own colour inside the region at an extreme point; that disc came from the partner's contact (two-sided), which a lens arc lacks |
| M-HALF, M-POLAR | hold (class by class) | — |
| M-BLOCK-EQ | holds (class by class) | — |
| M-REDUCE-I | its arc-closing step (via M-EXTREME) fails: DISC7's class boundaries are closed loops with no singular point | replaced in stage 3 (M2-REDUCE-C): the vertices are the crossings of different classes' boundaries |

### 2.3 REG-J′ on covers — verdict

**REG-J′-C_k** (this record's): *if a maximal `k`-cover exists, then one exists whose classes are regular (MUA-REG) and in which every bounded set meets
only finitely many components of the classes' interiors, and `⋃_j ∂F_j` is, in every bounded set, a finite union of Jordan arcs (MUA-FIN).*

| form | verdict | grade, minds |
|---|---|---|
| existence, `k ≥ 7` | **TRUE**: R7 (unit arcs), DISC7 (circles of radius `1/2`), each exact (§2.4); SQ9 at `k = 9` | [hand + exact], one mind |
| existence, `k ≤ 4` | vacuous (`χ_m⁰(ℝ²) ≥ 5`) | — |
| existence, `k = 5, 6` | **GAP at MUA-REG and MUA-FIN.** At `k = 5`, given FS106-AE-MAP6 and stage 3's M2-REDUCE-C, it is equivalent to `χ_m⁰(ℝ²) ≥ 6` (as C-REG-EQ: the rung is vacuous if `χ_m⁰ ≥ 6`), so it is not a smaller statement; its colour-generic forms below are | [derived], one mind |
| MUA-REG-U: every MUA set is regular | open; its one-dimensional analogue is FALSE (§1.5) | — |
| MUA-FIN-U: every regular MUA set has locally finitely many components | **reading: FALSE**, by M2-PINCH-C below; killing test: a regular MUA set by formula containing the configuration, or a proof that M2-FIX forbids it globally | [reading], one mind |
| MUA-FIN-P: every regular maximal cover can be modified, keeping it a maximal cover, into one satisfying MUA-FIN | open; the colour-generic procedural rung | — |

**M2-PINCH-C — a class can pinch along a Cantor set** [hand, one mind; conditional]. Let `g : ℝ → [0, ∞)` be `C^∞` with `|g″| ≤ 1/2`, zero set exactly
a Cantor set `Z ⊂ (−1/8, 1/8)` (a smooth function can have any closed zero set). Put `P = [−1/4, 1/4] × [−1/2, 0]` and
`P′ = {(s, t) : |s| ≤ 1/4, 2 + g(s) ≤ t ≤ 5/2}`. *If* a regular MUA set `F` contains `P ∪ P′` and every point of `F` within `11/10` of the strip `W = [−1/8, 1/8] × [9/10, 11/10]` lies in
`P ∪ P′ ∪ W`, then `int F ∩ W` has infinitely many components, accumulating at every point of `Z × {1}`.
*Proof.* For `z ∈ W`, (iv) gives `z ∈ int F` iff `T₁(z)` misses `P` and `P′` iff `d_P(z) > 1` and `d_{P′}(z) > 1` (the far alternatives fail:
`D_P(z), D_{P′}(z) ≥ 7/5`; and a unit circle about a point of `W` misses `W`, whose diameter is below 1). `d_P(z) > 1` iff `t > 1`. `d_{P′}(z) > 1` iff `z` lies below the lower unit parallel of `P′`'s bottom, a curve
`t = ℓ(s)` with `ℓ ≥ 1` and `ℓ(s) = 1` iff `s ∈ Z` (a point `(s, 1)` has distance `≥ 1` from `P′`, with equality only at `(s, 2)` with `g(s) = 0`, where
`g′(s) = 0`). So `int F ∩ W = {1 < t < ℓ(s)}`, one thin lens over each gap of `Z` and nothing over `Z`. ∎
*Consistency (why this is a reading of FALSE and not a curiosity).* The configuration satisfies M2-FIX locally: `P`'s interior has diameter `< 1` and
is more than 1 from the lenses and `P′`; every point strictly between the blocks outside the lenses lies on a unit circle about `P` or `P′`; the pinch
points `(c, 1)` lie in `F` (closure) with density 0 and have contacts `(c, 0)` and `(c, 2)`, touched tangentially. Nothing local forbids it; what is not
done is the completion to a global MUA set (the lenses' own shadows, the blocks' other sides, and the horizontal cut-off of the rung by other material
of the class). In an honest saturated colouring the same picture puts infinitely many cusp points of Σ on a Cantor set: round 1's REG-J′ fails for
it in the same way. So local finiteness is **not** a consequence of maximality class by class; it must come from a modification (MUA-FIN-P), or from
the whole cover. *The local repair:* raising `P′` by any `τ > 0` turns the lenses into one strip; whether the raise propagates through `P′`'s other
contacts is W §2.7's self-sustaining question.

### 2.4 Exact checks

`tools/fs111_m2_covers.py` (exact rational arithmetic; output `data/fs111/fs111-m2/covers.out`, exit 0, 22 s):
- **DISC7** — grid points `z = (i√3/16, 3j/16)` (every `|z − c|²` rational), 2,173 points covering a period cell of the colour lattice with margin, each
  against all seven classes: the shadow identity `z ∈ int F_a` XOR `z ∈ F_a + S¹` holds at every point and class; every point is covered; same-class
  centres are more than 2 apart; every disc's centre is exclusive; neighbouring discs overlap (lens). **0 failures.** *(A sampled check of M2-DISC7;
  the proof is §1.6's.)*
- **SQ9**, class `(0, 0)` — 5,329 exact rational points over a period cell with margin: the shadow identity holds everywhere. **0 failures.**
- **R7** — not re-checked here: VMW's exact results are the inhabitant (VMW-R7-MAX, reading (A), the 144-point grid: every point outside a class is on a
  unit circle about it; VMW-R7-PROPER: no interior pair at distance 1), which together are M2-FIX's two halves at R7.
- **Plants, each firing exactly its named failure and nothing else:** radius `11/20` → "both" (internal diameter `1.1`); colours `m + 4n mod 13`
  (covering radius `√13/2 > 3/2`) → "neither" (free points); only six of DISC7's classes → "cover"; squares at period 2 → "neither" (slack frees the
  boundary, M-SLACKFREE); squares of side `3/4` at period `3/2` → "both".

## Stage 3 — SAVED: the selection at five — saturated selections are component choices, the lens blocks them, and the route does not need them

### 3.1 M2-SELCOMP — a saturated class never has an interface inside a unit-avoiding enlargement of itself [hand, one mind; over Federer]

*Statement (every `k`).* Let `f` be an a.e.-proper colouring in D-NF that is saturated (every `x ∈ ∂_e S_a` is an `a`-contact point, C-SAT-T's
conclusion), and `A ⊇ S_a` (a.e.) any unit-avoiding set. Then `∂_e S_a ∩ int Ã = ∅`, and on every connected component `U` of `int Ã` the class `S_a` is
a.e. null or a.e. full.
*Proof.* If `x ∈ ∂_e S_a ∩ int Ã`, saturation gives `y ∈ cl S̃_a ⊆ cl Ã` with `|x − y| = 1`, against M2-INT. So every point of `U` has `S_a`-density 0
or 1: `U` meets no point of the measure-theoretic boundary of `S_a` (our `∂_e`), so `S_a` has perimeter 0 in `U` (Federer 4.5.11: a set whose
measure-theoretic boundary has locally finite `H¹` has locally finite perimeter, equal to that `H¹`) and `1_{S_a}` is a.e. constant on the connected
`U`. [external, classical, not read here: Federer, *Geometric Measure Theory*, 4.5.11] ∎

*Corollaries.*
- **(a) saturated = interface-maximal.** In a saturated colouring no class can be enlarged, keeping it unit-avoiding, by material adjacent to it across
  an interface: every unit-avoiding enlargement of `S_a` (e.g. its Zorn completion to a MUA set) adds only **new components** of `int Ã`. Saturation
  is maximality at interfaces; maximality (M2-ZERO) is saturation everywhere.
- **(b) from a regular maximal cover, a saturated selection is a component choice.** If `(A_j)` is a regular maximal cover and `S_j ⊆ A_j` a saturated
  selection, then each `S_j` is a.e. a union of whole components of `int F_j`, the chosen components forming an a.e. partition of the plane. (Regularity:
  `A_j = int F_j` a.e.)
- **(c) the lens blocks it.** If every component of every `int F_j` has **exclusive points** (a positive-measure part covered by no other class), all
  components must be chosen, so a saturated selection exists only if the classes' overlaps are null — only if the cover is already a partition.
- **(d) a regular maximal partition is saturated.** If the classes of a regular maximal cover are pairwise a.e. disjoint, the colouring they define is
  saturated: `x ∈ ∂_e S_j` has density `< 1`, so `x ∉ int F_j`, so `x ∈ F_j + S¹` (M-SATC (ii)). With M2-ZERO: **a regular maximal partition is a
  measurable fall colouring (every point sees every other colour at distance 1 in positive circle measure), and it is saturated.** R7 is one at seven
  (VMW-R7-COVER), SQ9 and HEX9 at nine.

**M2-NOSEL — DISC7 has no saturated selection** [hand + exact, one mind]. DISC7 is a regular maximal seven-cover in which every disc has exclusive
points and neighbouring discs overlap in lenses (§1.6, exact in §2.4); by (c) no measurable selection from it is saturated. This is round 1's
M-DEADLOCK in global form, at `k = 7`: M-DEADLOCK said no *local* change binds a hexagonal edge; M2-NOSEL says no *selection* from the cover above
the hexagonal colouring that DISC7 is can be saturated at all. So **"select at the end" is not a colour-generic way to reach honest saturation**: from
a given maximal cover it succeeds only when that cover is a partition, and at seven the partition (R7) is a different cover altogether, on a
different tiling.

### 3.2 M2-REDUCE-C — the route at five needs no honest saturation [derived, one mind; over FS106-AE-MAP6's grade]

*Statement.* If REG-J′-C_k holds (a maximal `k`-cover exists whose classes are regular and whose class boundaries `⋃_j ∂F_j` form, in every bounded set,
finitely many Jordan arcs meeting only at endpoints), then an a.e.-proper map-type `k`-colouring (S–V Conditions 2–4, D-AEMAP) exists, i.e. REG-I_k.
At `k = 5`, with FS106-AE-MAP6: **REG-J′-C₅ ⟹ `χ_m⁰(ℝ²) ≥ 6`**, hence `χ(ℝ²) ≥ 6` given MR (row 130).
*Proof.* Let `𝒜 = ⋃_j ∂F_j`, a locally finite plane graph. (1) *Faces are coloured.* A face `R` of `𝒜` (a component of `ℝ² ∖ 𝒜`) is connected and
meets no `∂F_j`, so for each `j` it lies in `int F_j` or outside `F_j`; the `int F_j` cover a.e. (regular cover), so `R ⊆ int F_j` for some `j`; colour
`R` by the least such `j`. (2) *Proper, pointwise.* Two faces of colour `j` lie in `int F_j = int Ã_j`, and M2-INT forbids any two points of
`int Ã_j` at distance 1: D-AEMAP holds, even everywhere on the open regions. (3) *Map-type.* Erase every edge with the same colour on both sides and
every vertex of degree 2 (merging its two edges); what remains is locally finite (Condition 3). A remaining closed edge with no vertex bounds an island:
recolour the island by the colour of the face around it; the surrounding face lies in one component of `int F_c`, of diameter `≤ 1` (M-HULL2), so the
filled face has the same outer boundary, its points are within `< 1` of every point of a "near" component of colour `c` (the maximum of `|· − q|` over
the filled face is taken on its outer boundary) and farther than 1 from every "far" one (a segment from the island to it crosses the surrounding face):
properness is kept (as V0-CLEAN). Every vertex left has degree `≥ 3` with distinct colours on adjacent faces (Condition 2). (4) At `k = 5` this map
contradicts FS106-AE-MAP6. ∎

*What it changes.* Round 1's M-REDUCE-I needed (i) honest saturation at five and (ii) REG-J′₅ for the saturated colouring; **(i) is gone**. Saturation's
two jobs in round 1 were regularity of interfaces (M-PINCH's `C^{1,1}`) and closing arcs at singular points (M-EXTREME); on a cover neither is needed,
because FS106-AE-MAP6 asks only for Jordan boundaries and local finiteness, and the maximal cover's class boundaries supply the edges and their crossings
the vertices. **The owner's ruling holds in the strongest form: the selection is the free face-colouring of step (1), and the colour count enters only
at FS106-AE-MAP6 — Woodall and Townsend's map argument.** What is left at five is REG-J′-C₅ alone: MUA-REG and MUA-FIN for one maximal five-cover.

*Grade and minds.* One mind; the island fill as in round 1 (V0-CLEAN, VMW D4). As an existence statement REG-J′-C₅ is equivalent to the answer given
FS106-AE-MAP6 (it is vacuous if `χ_m⁰ ≥ 6`), so M2-REDUCE-C moves no value; it removes a hypothesis (honest saturation) that M2-NOSEL shows cannot be had
by selection in general.

### 3.3 The selection at `k = 5`, answered

| the brief's question | answer | grade, minds |
|---|---|---|
| "from a maximal cover of a tight five-colouring to an honest saturated colouring whose Σ is locally finite" — derive it, or name the step and the configuration | **As a selection: FALSE colour-generically** — the configuration is the **lens** (two overlapping components of different classes, each with exclusive points), M2-SELCOMP (c); DISC7 inhabits it at seven (M2-NOSEL). **As an existence statement at five:** equivalent to `χ_m⁰ ≥ 6` given FS106-AE-MAP6, and **not needed** (M2-REDUCE-C) | [hand + exact; derived], one mind |
| what a five-colour deadlock would need | a tight five-colouring **no** maximal five-cover of which (over every Zorn completion) can be refined into a partition: in every regular one, some components that no choice separates — two overlapping components with exclusive points, as in DISC7. Equivalently: no measurable fall five-colouring exists although a five-colouring does | [derived], one mind |
| whether the count forbids it | **No**, as far as counting goes: five unit-avoiding classes have density sum at most `5 m₁(ℝ²) < 1.235` (row 129: `1/m₁ ≥ 4.0487`), so up to `0.235` of overlap is allowed per unit area, and nothing forces it to vanish. The count forbids a whole cover only for special piece shapes (M2-KERSHNER: discs of radius `1/2`), never a deadlock by density. And after M2-REDUCE-C a deadlock does not block the route | [hand, over row 129], one mind |
| M-DEADLOCK at seven | subsumed: DISC7 is the maximal cover above the hexagonal colouring's circumscribed discs, and M2-NOSEL shows it has no saturated selection; R7, a partition, is the saturated seven-colouring | [hand + exact], one mind |

**The route at five, as it now stands.** `χ_m⁰(ℝ²) ≥ 6` (so `χ(ℝ²) ≥ 6` given MR) ⟸ some maximal five-cover satisfies MUA-REG and MUA-FIN
(M2-REDUCE-C, FS106-AE-MAP6). Its contrapositive is an invariant of every hypothetical counterexample (G79's form): **if the plane has an a.e.-proper
measurable five-colouring, then every maximal five-cover above it is irregular or has class boundaries that accumulate** — in the local form of
M2-PINCH-C, unit parallels of one class touching along infinite sets. The colour-generic question that is smaller than the answer is MUA-FIN-P: can a
regular maximal cover always be modified into a locally finite one? Its known obstruction is M2-PINCH-C's tangency, removable locally (raise the upper
block) but with a propagation question at distance 1.

### 3.4 Proposed for the close (I edit none of these files)

- **`data/fs111/claims.md`:** C-SAT-T — add "a regular maximal partition (measurable fall colouring) is saturated (M2-SELCOMP (d)); from a maximal cover
  a saturated selection is a component choice and the lens blocks it (M2-SELCOMP, M2-NOSEL)". C-HULL-REG — the cover form (M2-HULLC): semiconcave yes,
  semiconvex no (DISC7). REG-J′ — its cover form REG-J′-C_k, with MUA-REG and MUA-FIN named. M-REDUCE-I — superseded at five by M2-REDUCE-C.
- **`LEDGER.md` (FS-111's row):** M2-COV, M2-ZERO, M2-INT, M2-FIX, M2-HULLC, M2-SELCOMP, M2-NOSEL, M2-REDUCE-C [hand, one mind each]; M2-DISC7 [hand +
  exact]; the reading M2-PINCH-C. "It moves no value."
- **A grokking (draft G84, replacing round 1's draft), in G67's form:** *A maximal class is a fixed point of its own unit shadow. [hand, one mind]* A
  maximal unit-avoiding set is exactly a measurable independent dominating set of the unit-distance graph (`A = {φ_A = 0}`); when regular, its interior
  is the set of points whose unit circle misses it, so it is carved by the unit circles about its own points and its boundary lies on unit parallels
  of its own components. A maximal cover is `k` such sets covering; a maximal partition is a measurable fall colouring, and it is saturated. *Do:
  when a question about a tight `k`-colouring needs regularity, pass to a maximal cover (Zorn, free) and ask it of one maximal class — never ask a
  selection to be saturated unless the cover is a partition (the lens blocks it); spend the colour count only at the map theorem. Killing test: a
  regular maximal class whose boundary near some point is not contained in the unit parallels (outer or far) of its own components within distance 1.*
- **Stubs to mint or re-aim:** (a) round 1's stub "honest saturation" is **retired as unnecessary** (M2-REDUCE-C) — keep its banner; (b) **MUA-FIN-P**
  (the colour-generic rung: make a regular maximal cover locally finite), with MUA-REG — provisional bearings G82, G79, G71's heights (a MUA set's
  boundary pieces as level sets), W §2.7; (c) M2-PINCH-C's completion (a regular MUA set with infinitely many components), the killing test of the
  reading MUA-FIN-U FALSE.
- **`BIBLIOGRAPHY.md`:** Federer, *Geometric Measure Theory* (1969), 4.5.11 (the criterion for finite perimeter) and Federer 1959 (curvature measures;
  reach of the complement of a parallel body), cited as classical, not read here — debts; Kershner 1939 (thinnest covering of the plane by equal
  discs, `2π/√27`) and the hexagonal packing bound for equal discs, cited as classical (M2-KERSHNER); Dunbar et al. 2000 (fall colourings, already held
  under FS-67) now also for M2-ZERO's reading.

## Stage 4 — SAVED: the six-colour top rung — REG-CHAIN proved in a strong form on the honest route; the cover route needs a larger NO

### 4.1 M2-INTRAD — saturated interfaces have integer radii [hand, one mind]

*Setting.* `f` an honest a.e.-proper colouring in D-NF, saturated (C-SAT-T's conclusion). **Σ** as in round 1 (§3.3, §4.1 there): the essential
boundary points at which M-PINCH's hypotheses (H1), (H2) fail, together with every point of `supp S_j` at which `S_j` has density 0 (cusps). **REG-J′**
(with its clause, §1.2 item 6): Σ locally finite, finitely many interface arcs at each of its points; then (M-REDUCE-I's proof) every bounded set meets
finitely many interface arcs, each `C^{1,1}` off Σ (M-C11).

*Statement.* Under REG-J′, (i) every interface arc has radius of curvature in **`{1, 2, 3, …} ∪ {∞}` at almost every point**; (ii) for each `n`, its
points of radius `n` form, near any point, finitely many arcs of circles of radius `n`, each concentric with a chain of `n − 1` parallel interface arcs
ending at a unit arc of kind both or at a unit arc centred at a point of Σ; so (iii) an interface is a `C¹` chain of segments and circular arcs of
integer radius in which arcs of any bounded radius are locally finitely many — **infinitely many arcs can accumulate at a point only with radii tending
to infinity** (call that **LRA**, large-radius accumulation; not excluded here).

*Proof.* (1) *Partners are interfaces.* On an open subarc `J` of type (tangent) (between `a` and `b`, `ν` the unit normal into `b`), M-PINCH puts the
`a`-contact of `x` at `x + ν(x)` and the `b`-contact at `x − ν(x)`. So the unit parallels `J^± = {x ± ν(x)}` lie in `supp S_a`, resp. `supp S_b`, and miss
`S̃_a`, resp. `S̃_b` (I-D1: `d̄_a(x) > 0`). At a point `y ∈ J^+ ∖ Σ`, `S_a` has positive upper density (Σ contains the cusps) and `y ∉ S̃_a`, so `y` is an
interface point where (H1), (H2) hold; with `P_a` the `a`-part near `y`, `J^+ ⊆ cl P_a ∖ P_a = ∂P_a`, which is one `C^{1,1}` curve with `|κ| ≤ 1` (M-C11):
**the unit parallel of a (tangent) arc is again an interface arc**, on both sides.
(2) *Radius descent.* Parametrise `J` by arclength, `κ(s)` its curvature toward the side of its centre of curvature, `ρ = 1/κ`. The parallel at distance 1
toward the centre is `γ + ν′` with speed `(1 − κ)` and radius `ρ − 1` (the shadow map in radius form; row 134's `λ ↦ λ/(1 + λ)` read toward the centre).
By (1) it is an interface with radius `≥ 1` wherever it is regular and off Σ, so a (tangent) point has `ρ ≥ 2` unless `ρ = 1` exactly (then the parallel
toward the centre collapses to a point). Iterate: the chain of parallels toward the centre has radii `ρ, ρ − 1, …` and continues through (tangent)
points; it stops only at a point of type (split), which forces the whole local interface to be one unit arc (M-C11 (iii)) — radius exactly 1 — or at a
(tangent) point of radius exactly 1, whose partner toward the centre is a single point `z`, which lies in Σ (the partner colour near `z` avoids the unit
discs about every point of the arc, an angle larger than `π`, so it is a sector: a corner), or at Σ. The normals along which the chain meets Σ form a
null set of `s` (Σ is locally finite; a positive-measure set of normals through one point `p` makes the arc a circle about `p`, which is covered by the
same count). So **`ρ(s) ∈ {1, 2, 3, …} ∪ {∞}` for almost every `s`**.
(3) *Piecewise circular.* Let `E_n = {s : ρ(s) = n}` and, for a terminal centre `p` (a centre of a unit arc of kind both, or a point of Σ — finitely
many near `J` under REG-J′), `E_{n,p}` the part of `E_n` whose chain ends at a unit arc centred at `p`; there `γ(s) + nν′(s) = p`. Put
`f(s) = |γ(s) − p|² − n²`: `f = f′ = 0` on `E_{n,p}`, and near it `f″ = 2(1 − nκ(s)(1 + o(1)))`, which is `> 0` on `E_0` and on `E_k` for `k > n`.
For `n = 1`, `|κ| ≤ 1` makes `f` convex near `E_{1,p}`, so `E_{1,p}` is locally an interval (a convex function vanishing with its derivative at two
points vanishes between them). Inductively, `f″ < 0` only on `⋃_{k<n} E_k`, locally finitely many intervals; on each complementary interval `f` is convex
and `E_{n,p}` meets it in an interval. So every `E_n` is locally a finite union of intervals. ∎ *Not proved:* that only finitely many `n` occur near
a point. Arcs of radii `n_i → ∞` accumulating at a flat point have chains of length `n_i`, ending at unit arcs near `n_i` along the normal — far apart,
consistent with REG-J′'s local finiteness. This is FS-112's stuck ray in another form: row 135 found the one-sided chain "a pencil of circles of radius
`k + 1`" consistent and noted that "a ray needs arcs of every radius `≥ k + 1`, doubly periodic maps have none".

*Controls.* R7: every interface a unit arc of kind both (`n = 1`). The strip (row 136): unit arcs of kind both and segments (`n = 1, ∞`). SQ9, HEX9:
segments (the ladder, `n = ∞`). None exhibits `n ≥ 2`; a radius-2 arc would sit concentric with a unit arc of kind both. *Would kill it:* a saturated
colouring with locally finite Σ and an interface arc of non-integer radius (a defect in M-PINCH's (tangent) partners or in the descent).

**M2-REDUCE-A** [derived, one mind]. *REG-A_k ⟸ C-SAT-T_k (honest, existence) ∧ REG-J′_k ∧ ¬LRA.* M-REDUCE-I's construction gives a map-type
colouring whose boundaries are the interface arcs; by M2-INTRAD, with no large-radius accumulation, each is a finite chain of segments and circular arcs:
a segment-and-arc map, a.e.-proper. **At six, with Q-NO (row 134 with FS-114's NO): honest saturation at six, REG-J′₆ and ¬LRA give
`χ_m⁰(ℝ²) ≥ 7`** (C-SEVEN-M), so `χ(ℝ²) = 7` given MR. REG-CHAIN is proved in its strong form (every chain toward the centre ends at a unit arc or at
Σ, and the radii are integers); NO-C11 is not needed on this route; what REG-CHAIN left open is now LRA, which is where FS-112's stuck ray sits
(FS-115). *Audit (standing rule 4):* the first draft of this stage claimed a finite concatenation outright; the accumulation with radii `→ ∞` was
found on re-reading step (3), before the report.

### 4.2 M2-DISCK7 — on covers, class boundaries need not be arcs [hand + exact, one mind]

*The object.* `K` is the convex body with support function `h(θ) = 1/2 + sin³(3θ)/200`. **DISCK7:** class `a` is the union of the translates of `K`
centred at hex7's colour-`a` centres (§1.6). Checked (`tools/fs111_m2_disck7.py`, sympy + exact rationals, output `data/fs111/fs111-m2/disck7.out`, exit 0):
`h(θ) + h(θ + π) = 1` (constant width 1); radius of curvature `h + h″ = 1/2 + (54s − 80s³)/200`, `s = sin 3θ`, with exact range `[37/100, 63/100]` —
positive and **not constant**, so `∂K` is smooth, strictly convex and not a circle; `K` contains the regular hexagon of circumradius `1/2` (an exact
sufficient inequality at `u = 11/20 > π/6`); `K` lies within `0.51` of its centre and contains the disc of radius `0.495`; so copies in one class are
more than 1 apart (`√21/2 − 1.02 > 1`), every point is within `√7/2 − 0.495 < 1` of a copy, and each centre is exclusive (`√3/2 > 0.51`). Plants fire
for their own reasons: `sin²` (not constant width), `δ = 1/30` (not convex; the containment and radius bounds fail with it), `δ = 0` (a circle).
*Consequences, by hand.* A set of constant width 1 is its own spindle hull, so each copy's interior misses its own unit shadow, and a point outside
every copy of class `a` has `dist < 1 ≤ dmax` to the nearest: each class is MUA and regular, the seven cover the plane (`K ⊇` hexagon), and two
translates of a strictly convex curve cross at most twice, so the arrangement is locally finite: **DISCK7 satisfies REG-J′-C₇, and its class boundaries
have non-constant curvature** — the cover form of REG-A ("maximal classes are bounded by segments and circular arcs") is **FALSE at seven**. Through
M2-REDUCE-C it is a map-type a.e.-proper seven-colouring with smooth non-circular boundaries. The mechanism is M2-HULLC (iv)'s far level: a
constant-width body is its own far parallel (`ρ(θ) + ρ(θ + π) = 1`), a chain closing in two steps — the involution `ρ ↦ 1 − ρ` that honest saturation
excludes ((in, in) is impossible, and (in, out) forces a unit arc).

### 4.3 The top rung, as it stands

| route | what it needs at six | status |
|---|---|---|
| **honest** (round 1, completed here) | honest saturation (C-SAT-T₆) ∧ REG-J′₆ ∧ ¬LRA, then Q-NO | REG-A₆ ⟸ these three (M2-REDUCE-A, with M2-INTRAD); LRA is FS-115's stuck ray in another form; **but** honest saturation cannot be reached by selecting from a maximal cover (M2-NOSEL), so it needs a global re-choice of the cover — a measurable fall six-colouring, or at least an interface-maximal one (M2-SELCOMP (a)). GAP there |
| **cover** (this round) | REG-J′-C₆ (free saturation; MUA-REG, MUA-FIN), then a NO for maps whose boundaries are unit parallels, outer and far, of their own classes' components (**NO-PAR**, proposed) | Q-NO does not suffice: DISCK7 shows maximal classes with non-circular boundaries at seven. GAP at MUA-FIN and at NO-PAR |

*The trade, in one line:* **covers give saturation for free and lose circularity; honest saturation gives circularity (integer radii) and cannot be had by
selection.** Given FS-114's NO, the answer at six is decided by either "some tight six-colouring is interface-maximal with locally finite Σ" (honest) or
"some maximal six-cover is locally finite, and NO-PAR" (cover). *Would have searched here:* for a saturated six-colouring, or a chain of radius 2 — did not;
the object side is W's and, by W-NEG, would be `χ_m⁰ ≤ 6`.

### 4.4 Proposed for the close, added (I edit none of these files)

- **`LEDGER.md`:** M2-INTRAD and M2-REDUCE-A [hand/derived, one mind] — REG-CHAIN in a strong form; M2-DISCK7 [hand + exact]. "It moves no value."
- **`data/fs111/claims.md`:** REG-A — the cover form FALSE at seven (DISCK7); REG-CHAIN — TRUE under honest saturation and REG-J′, with integer radii
  (M2-INTRAD); NO-C11 — not needed on the honest route; **NO-PAR** proposed for the cover route.
- **Stub to mint:** *interface-maximal six-colourings* — does some tight six-colouring admit a modification that is saturated (equivalently, no class
  extends across an interface) with locally finite Σ? Its seven-colour inhabitant is R7, its known obstruction the lens (M2-NOSEL). Provisional bearings:
  G54 (fall colourings; gap-free), G82, G83.
- **A second grokking draft (G85), in G67's form:** *Saturated interfaces have integer radii. [hand, one mind]* Off a locally finite singular set, the unit
  parallel of a saturated interface is again an interface, so radii of curvature fall by exactly 1 toward the centre and the fall must stop at 1: every
  interface is a chain of segments and circular arcs of integer radius, finitely many of each radius locally. *Do: before asking whether a hypothetical
  saturated colouring has curved interfaces, read the chain of unit parallels toward the centre; if it cannot end at a unit arc or at a singular point,
  the arc cannot exist; what remains is accumulation with radii → ∞ (the stuck ray). Killing test: a saturated colouring with locally finite Σ and an
  interface of non-integer radius.*
