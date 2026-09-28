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
- **M2-KERSHNER** — no admissible five-cover has classes that are unions of discs of radius `1/2`: such a class has density at most `π/(8√3)`, and five
  of them fall below `2π/(3√3)` — [hand over Kershner 1939 and Fejes Tóth's packing bound, external] §1.6.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none. (Four zbMATH queries for prior art, §1.3, are reading, not search.)

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
