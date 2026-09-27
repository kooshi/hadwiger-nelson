# FS106-TS — the structural route: the regular classes almost everywhere, then Voronov's method on density-open classes

*Job FS106-TS (de Bruijn), Opus 5.5, 2026-09-27. Brief `data/fs106/briefs/TS106-structural.md` (the owner's re-brief block first) with
`data/fs106/briefs/STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors read from disk before anything else). Inputs
read from disk: `plans/FS106-regular-half.md` (all), `data/fs106/claims.md`, `plans/FS106-V-verification.md` (with § Continuation — FS106-V2),
`plans/FS106-VB-verification.md`, `plans/FS103-M-derivation.md` §3.1, `plans/POROS-2026-09-26-fs106-regular-half.md` stage 4. Not blind to the
print or to wave 1; blind to FS106-TQ until my verdict stage for items 1–2 is committed. Grades are `CLAUDE.md` § Notation's. Working files:
`data/fs106/fs106-ts/`; exact checks `tools/fs106_ts_*.py`. Text layers of the two papers (`pdftotext -layout`) in my own scratchpad
subdirectory `…/scratchpad/fs106-ts/`.*

## Theorems this phase proved

*(one line each, grade and address; filled stage by stage)*

- **TS-U**, the unit-arc lemma: a unit-arc boundary with colours `c | c′` puts `c` in the wedge facing it and `c′` in the wedge facing away at its
  centre, and neither in the two side cones — [hand, one mind], §2.2.
- **TS-L1**: S–V Lemma 1 for a.e.-proper maps with no Condition 5 and no Condition 6 — [hand, one mind], §2.3.
- **TS-C**: a chain of same-colour regions whose closures meet has diameter `≤ 1` (any map, a.e.-proper) — [hand, one mind], §2.4.
- **TS-T**: a point of chromaticity `≥ 3` within 1 of every point (any a.e.-proper map); with Conditions 5, 6 it is trichromatic, closing SV-L4 (a)
  — [hand, one mind], §2.4.
- **C-AE-POLY** at SV-2's repaired grade except its `d = 2` edge case, by a region-only route that never uses Observation 1 (Prop. 7 region-only);
  hence SV-2 without Observation 1 — [hand, one mind here + V2], §3.
- **C-AE-CONV** with 7 colours for locally finite convex tilings, from C-AE-POLY — [hand, one mind], §3.
- **C5**: a local configuration satisfying Prop. 5's hypothesis and every pairwise constraint, where Prop. 5's conclusion fails (unit arcs
  allowed) — [hand, one mind], §2.5.

## Would-have-searched-here log

- Stage 1: none (a quotation check and the controls, by hand).
- Stage 3: none.
- Stage 2: a search for a global 6-colouring extending C5, or realising [G3]'s cone; instead each stated as a local configuration and checked by hand.

## Stage 1 — SAVED: quotation check and the controls

### 1.1 Quotation check (standing rule 5)

**Instrument.** `tools/fs106_ts_quotes.py`: each row is a quotation, its source, and the verdict expected; the quotation is split at ellipses and
each piece must occur in the source after deleting whitespace and joining line-end hyphens; a miss prints the longest present prefix. A source
that quotes its own body is cut at a marker (the brief's planner text starts at "*Brief for job"), because the first run found the re-brief's
quotation of the planner's text inside the file itself and read OK — an instrument defect, repaired before the run recorded here. **Plant:**
`--plant` mutates one present quotation (its longest word reversed) and adds an invented sentence; both read MISS, the untouched row OK
(`plant exit=0`). **Recorded run: 15 rows, 0 unexpected (exit 0).**

| quotation (where my brief or its standing rules hand it on) | source | verdict |
|---|---|---|
| re-brief: "send the advisor a short note" | the planner's text of the same brief: "Send the advisor (its id comes from the owner) a short note after each saved stage." | **paraphrase in quotation marks** (capital, and the parenthesis dropped); harmless — nothing lost |
| re-brief: C-AE-CLOSED is equivalent to "no almost-everywhere-proper six-colouring of `U₃(0)` with essentially closed classes" | `plans/FS106-V-verification.md` §2.1: "no a.e.-proper measurable 6-colouring of `U₃(0)` has essentially closed classes" | **paraphrase in quotation marks; it drops "measurable"**. The word carries weight: "essentially closed" (`|supp S_j ∖ S_j| = 0`) is defined through Lebesgue measure of the classes. Read here with "measurable" restored |
| rule 0: "From here on out, you may doubt your ability … you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim |
| rule 4: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim |
| rule 3: "The intent of the ban is to eliminate the crutch …" | `CLAUDE.md` § Toolchain quotes only "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | the rules' extra words "The intent of the ban is" are not in `CLAUDE.md`'s quotation (they may be Kooshi's own; unverifiable here); not load-bearing |
| C-AE-Q2's Question 2, D-SV Conditions 5 and 6, SV-L1, SV-1, C-T-CHR4's Lemma 2 | `[SokolovVoronov2025]` v1 text layer | verbatim (as FS106-V and FS106-VB found) |
| V-P2.2 | `[Voronov2023]` v3 text layer | verbatim |
| C-T-TAN, the advisor's wording "the unit relation becomes 'same projection onto e = w₀−u' …" | `plans/POROS-2026-09-26-fs106-regular-half.md` | **not on disk verbatim** (as FS106-V found): the record carries it in other words; the quoted form is from a message. I state C-T-TAN from its content, not its wording |

The brief's glosses (no quotation marks), checked: Question 2 as "maps whose open regions are properly coloured, boundaries free" — that is
C-AE-Q2 (D-AEMAP), not Question 2 as posed (C-AE-Q2-EV); both are on my list, so nothing is lost. "`[SokolovVoronov2025]` has already carried
Voronov's circle method … for maps with no unit-arc boundaries and no high-degree trichromatic vertices" — matches Conditions 5 and 6 and SV-1.
The three source paths in the re-brief exist on disk. The claim ids the brief lists all occur in `data/fs106/claims.md`.

### 1.2 The controls (standing objects every verdict below is checked against)

- **K1 — the tight hexagonal 7-colouring.** Regular hexagons of side `1/2` (diameter exactly 1), open hexagons coloured by the standard 7-colouring
  (the colour classes are cosets of an index-7 sublattice), boundaries free. It is a map (Conditions 2–4), polygonal (Condition 8), satisfies
  Conditions 5 and 7, and is a.e.-proper (D-AEMAP): two points of one open hexagon are `< 1` apart, and two hexagons of one colour are more than
  1 apart (`√7/2 ≈ 1.32` at this size), so distance exactly 1 inside one colour occurs only between opposite vertices of one closed hexagon. It is **tight** (D-SLACK: an open hexagon of diameter 1
  realises every distance in `(1 − ε, 1)`). **What it forces on an argument:** at a vertex `u` (multicolour of size 3), the colour of each hexagon
  `H` at `u` touches `ω(u)` **from inside**, at the vertex of `H` opposite `u`, in a direction interior to `H`'s own sector at `u`. So "the circle
  about a trichromatic point avoids its multicolour" holds only as S–V's Corollary 2 states it (some sector, inner or outer, is free at each
  direction), never as a full annulus; any step that needs a full annulus in the complementary colours is wrong at exact distance. And every
  "needs seven" argument must spend the count six at a named step that K1 fails.
- **K2 — `[Townsend1981]`'s unit-arc sector** (p. 114, read from the scan by FS106-V and FS106-VB: the sector "subtended by the angle ⅔π", split by
  "the arc of unit radius centre a"). A boundary may contain an arc of a unit circle and a 2-colouring of the pieces may avoid the monochrome unit
  that a sector of that angle is otherwise forced to carry. **What it forces:** no argument may conclude "no boundary contains a unit arc" from
  properness alone; a statement about unit arcs must hold on K2 (there the arc's centre `a` sits at the edge of the coloured set).
- **K3 — a density-open class with a fat-Cantor edge.** Let `K ⊂ [0, 1/4]` be a closed nowhere-dense set of positive length (a fat Cantor set) and
  `A = {(s, t) : s ∈ (−1/4, 1/4) ∖ K, |t| < 1/4}` with `B` its complement in the square. `A` and `B` are, up to null sets, a two-colouring whose
  topological boundary contains `K × (−1/4, 1/4)`, of positive area, while the essential boundary (points of density 1 for neither) is null
  (Lebesgue: a.e. point of `K × ℝ` is a density point of `B`). **What it forces:** an argument that works with regions, components or topological
  boundaries says nothing about density-open classes; a claim in D-NF must survive a class whose topological boundary is fat.

## Stage 1 — SAVED

## Stage 2 — SAVED: C-AE-Q2 and C-AE-Q2-EV

*Setting: a map-type colouring (Conditions 2–4) with `k` colours, boundaries allowed to contain arcs of unit circles, vertices of any degree,
**a.e.-proper** (D-AEMAP: no two points of open regions of one colour at distance 1; boundaries and vertices uncoloured). I read "partitioned into
vertices, boundaries, and regions" (Condition 2) as: two boundaries meet only at vertices. "Region point" = a point of an open region. For a
point `x`, `c(x)` is its multicolour (Definition 2) and a neighbourhood `U(x)` is taken so small that it meets only regions whose closure contains
`x` (possible by Condition 3; S–V's own convention, p. 4). `ω(x)` is the unit circle about `x`.*

### 2.1 The claim, its two forms, and what each would give

- **C-AE-Q2 ⟹ C-AE-Q2-EV** (a colouring proper at every point is a.e.-proper), so a FALSE for Question 2 as posed is a FALSE for C-AE-Q2.
- **Null boundaries.** If the boundaries are Lebesgue-null, colouring each boundary point by any adjacent region gives a measurable colouring
  proper at `Leb ⊗ σ`-a.e. edge, so **a six-colour counterexample to C-AE-Q2 with null boundaries is `χ(ℝ²) ≤ 6` with no MR** (I-EASY). And
  C-AE-CLOSED ⟹ C-AE-Q2 for null-boundary maps (FS106-V §2.1: the closures of the colour classes are six closed sets covering with a null set of
  unit pairs). So C-AE-Q2 with null boundaries is a special case of C-AE-CLOSED with a map's topology added.
- **Fat boundaries.** A Jordan arc may have positive area (Osgood). C-AE-Q2 as worded covers such maps, but there D-AEMAP leaves a set of
  positive measure uncoloured, so a counterexample there says nothing about `χ(ℝ²)`. The HN-relevant form is the null-boundary one.

### 2.2 Lemma TS-U (the unit-arc lemma: a unit arc on a boundary splits the neighbourhood of its centre into wedges)

**Statement.** In an a.e.-proper map colouring, let a boundary contain an arc `A = {y + (cos θ, sin θ) : θ ∈ [θ₁, θ₂]}` of `ω(y)`, `θ₁ < θ₂`, with
the region on its inner side (toward `y`) of colour `c` and on its outer side of colour `c′` (`c ≠ c′`, Condition 2). Then near `y`:
(i) every colour-`c` region point `y + b` has `b·(cos θ, sin θ) ≥ −C|b|²` for all `θ ∈ [θ₁, θ₂]` (colour `c` lies in the wedge **facing** `A`,
of angle `π − (θ₂ − θ₁)`);
(ii) every colour-`c′` region point has `b·(cos θ, sin θ) ≤ C|b|²` for all `θ` (colour `c′` lies in the wedge facing **away**);
(iii) the two open **side cones** `Σ± = {b : ±b·(cos θ₁, sin θ₁)^⊥ … }` — precisely, the directions strictly between `θ₁ + π/2` and `θ₂ + π/2`
and strictly between `θ₁ − π/2` and `θ₂ − π/2`, each of angle `θ₂ − θ₁` — contain, near `y`, no region point of colour `c` or `c′`. In
particular `c(y)` contains a colour other than `c, c′`.

**Proof.** Shrink `[θ₁, θ₂]` so that no vertex lies on `A`; then along `A` the inner side is one region `R_in` of colour `c` containing a collar
`{y + (1 − s)(cos θ, sin θ) : θ ∈ [θ₁, θ₂], 0 < s < s₀}` and the outer side a region `R_out` of colour `c′` with the collar `1 < r < 1 + s₀` (a
point of a boundary arc that is not a vertex has exactly the two regions of its two sides near it). For small `b`, the circle `ω(y + b)` meets
the ray from `y` in direction `θ` at radius `r = −b·n + √((b·n)² + 1 − |b|²) = 1 + b·(cos θ, sin θ) + O(|b|²)`, `n = −(cos θ, sin θ)`. If
`y + b` is a region point of colour `c` with `b·(cos θ, sin θ) < −C|b|²` for some `θ ∈ [θ₁, θ₂]` (and `|b|` small against `s₀`), this radius
lies in `(1 − s₀, 1)`, so `ω(y + b)` meets `R_in`: a unit pair in the open colour-`c` regions, excluded by D-AEMAP. That is (i); (ii) is the same
with `R_out`. For (iii), a direction strictly between `θ₁ + π/2` and `θ₂ + π/2` has `b·(cos θ₁, sin θ₁) < 0 < b·(cos θ₂, sin θ₂)` with both
of size `≥ κ|b|` on a closed sub-cone, so for `|b| < κ/C` such `b` violates (i) at `θ₁` and (ii) at `θ₂`; the other side cone likewise. The side
cones are open, contain region points (boundaries are nowhere dense), and meet only regions whose closure contains `y`. ∎ [hand, one mind]

**Controls.** K2 (Townsend's sector): the arc's centre `a` sits at the edge of the coloured set, so the side cones lie outside it — consistent.
K1 has no unit-arc boundaries, but its point-touch is the degenerate case: the hexagon `H` at a vertex `u` touches `ω(u)` from inside at the
opposite vertex, in a direction inside `H`'s own sector — the inner colour facing the touch, as (i) requires.

### 2.3 Lemma TS-L1 (S–V Lemma 1 with no Condition 5 and no Condition 6, a.e.-proper)

**Statement.** In an a.e.-proper map colouring, no two points `x, y` with `|x − y| = 1` have `c(x) = c(y) = {a, b}`. [hand, one mind]

**Proof.** *Step 1* (FS106-V's region-only argument, §3.1, re-checked): for a colour-`a` region point `q` near `y`, `ω(q)` misses the open
colour-`a` regions near `x`; since `y` is a limit of colour-`a` region points and those regions near `x` are open, `ω(y) ∩ U(x)` misses them, and
likewise for `b`. So `ω(y) ∩ U(x)` lies in the boundary set. *Step 2*: the arc `ω(y) ∩ U(x)` is covered by finitely many boundaries (Condition
3), so by Baire one of them contains a sub-arc `A` of `ω(y)`, with no vertex on it, inside `U(x)`. Its two sides carry two different colours,
both in `c(x) = {a, b}`: so `{c, c′} = {a, b}`. By TS-U (iii) at the centre `y`, the side cones at `y` contain no region point of colour `a` or
`b` — but every region meeting `U(y)` has colour in `c(y) = {a, b}`, and the side cones contain region points. Contradiction. ∎

What changed against the print: S–V's proof needs Observation 1 (boundary colours); FS106-V's region-only proof needs Condition 5 at Step 2. Step
2 here replaces Condition 5 by TS-U: **the unit-arc configuration that V left open ("each boundary through `x` contains an arc of `ω(y)`") is
impossible for bichromatic pairs.** Consequence: S–V's Prop. 12 and Cor. 4 (the index, as FS106-V repaired it with Lemma 1 and Prop. 3) hold with
no Condition 5 wherever their curves exist. **Control K1:** two points on `{i, j}`-edges lie on distinct `i`-hexagons (each hexagon has one
`j`-neighbour), which are `≥ 1.32` apart — the lemma's conclusion holds there, as it must.

### 2.4 Lemma TS-C (clusters have diameter at most 1) and Corollary TS-T (a point of chromaticity ≥ 3 within 1 of every point)

**TS-C.** In an a.e.-proper map colouring, if `R₀, …, R_m` are regions of one colour with `cl R_{i−1} ∩ cl R_i ≠ ∅`, then
`diam ⋃ cl R_i ≤ 1`. Hence every connected component of the union of the closures of one colour's regions (a **cluster**) has diameter `≤ 1`.
[hand, one mind]

**Proof.** Same-colour closures meet only at vertices (a non-vertex boundary point has two regions of different colours beside it), so pick
touching vertices `t_i ∈ cl R_{i−1} ∩ cl R_i`, finitely many. Suppose `p ∈ R₀`, `q ∈ ⋃ cl R_i`, `|p − q| > 1`. Choose `p′ ∈ R₀` so close to `p`
that `|p′ − q| > 1` and `|p′ − t_i| ≠ 1` for every `i` (avoid finitely many circles). `ω(p′)` misses every `R_i` (a.e.-properness), so
`cl R_i ∖ ω(p′)` lies between `R_i` and `cl R_i` and is connected; consecutive ones share `t_i ∉ ω(p′)`; so `X = ⋃ cl R_i ∖ ω(p′)` is connected.
But `X` is split by `ω(p′)` into its points inside (containing `p′`) and outside (containing `q`), both open in `X` and nonempty. Contradiction.
A general pair `p, q` in the union is handled by approximating `p` from `R₀`. Components of the union are exactly chain classes (by local
finiteness the union is closed, and two chain classes whose closures met would be one). ∎

**TS-T.** For every point `x` there is a point of chromaticity `≥ 3` within distance 1 of `x`. [hand, one mind] *Proof:* Voronov's ring argument
with R3's hull growth (FS106-V §2.1 V-2.2), run on clusters instead of regions: take the cluster `X ∋ x` (or of a region at `x`); walk the
outer frontier of `X`; the outside sectors at a frontier vertex have colours `≠` `X`'s (a same-colour region touching `X` would be in `X`), and if
all outside sectors along the frontier have one colour `c′`, then at each frontier vertex there is only one outside sector (two consecutive
sectors of one colour would share a boundary), so the outside is a single region `R′` whose fill contains `X`; pass to `R′`'s cluster and
repeat. Fills strictly grow and each has diameter `≤ 1` (TS-C), and finitely many regions lie within 1 of `x`, so the process stops at a
frontier vertex where the outside colour changes: chromaticity `≥ 3`, within `diam ≤ 1` of `x`. ∎

**This closes FS106-V2's open step in SV-L4 (a)** ("the same along chains of ≥ 3 regions") for every map, not only under Condition 6. Under
Condition 5 (Lemma 2 caps chromaticity at 3) it gives a **trichromatic** point within 1 of every point, so SV-L4 (a) is TRUE under Conditions 5
and 6 [hand, one mind]. Without Condition 5 it gives chromaticity `≥ 3` only. **Controls.** K1: clusters are single hexagons, of diameter
exactly 1 — the bound `≤ 1` is attained, so it cannot be sharpened to `< 1` (the tight control earns its keep here); every point of K1 is within 1
of a vertex. K3 is not a map (the lemma is about regions), so nothing is claimed there.

### 2.5 The rest of SV-1's chain with Conditions 5 and 6 removed, step by step

| step (S–V, as repaired by FS106-V/V2) | uses | status for C-AE-Q2 |
|---|---|---|
| Props. 1–4, Prop. 3 | region points only | hold |
| Lemma 1 | Cond. 5 (V's proof) | **holds: TS-L1** |
| Prop. 12, Cor. 4 (the index) | Lemma 1, Prop. 3 | hold wherever the curves exist |
| Lemma 4 (a), a point of chromaticity ≥ 3 within 1 | Cond. 7 or the chain step | **holds: TS-T** (chromaticity `≥ 3`) |
| **Prop. 5** (at two colour-change points `x, y` of `ω(u)` at distance 1, other colours on both sides of `ω`) | "the arc of `ω(y)` is not a boundary" | **fails at one of the two points** — configuration C5 below; its conclusion does hold at `y` (TS-U (iii): the side cones at `y` straddle `ω(u)`) |
| **Prop. 6, Lemma 2** (chromaticity `≤ 3`) | Cond. 5 at three places (finitely many non-monochromatic points on `ω(x)`; Prop. 5; "arcs of circles cannot serve as boundaries" in the `x₂` step) | **GAP [G1]**. What survives: region points of `ω(u)` avoid `c(u)` (a region disc about a point of `ω(u)` sweeps a neighbourhood of `u` with unit circles). What is left: a 4-chromatic `u` whose `ω(u)` runs along boundaries. TS-U forbids the naive version — `ω(u)` a boundary circle with the inner colour at direction `θ` equal to `u`'s sector colour there — only in part: it passes TS-U (the side cones at `u` fall in the neighbouring sectors) and dies instead on the inner collar's own unit pairs (an inner collar of one colour on an arc longer than `π/3` holds a unit pair), which leaves a circle-colouring problem of Prop. 17's kind, not written |
| **Props. 9–10, Cor. 2** (the deformed annulus in the complementary colours) | Cond. 6 (three boundary types at `u`), Cond. 5 (Prop. 10), tangent directions at `u` (V2, from Cond. 5) | **GAP [G2]**, three escapes: (a) the bowtie (a degree-4 trichromatic vertex `4,5,4,6`; Prop. 9's "two of three" fails in some directions — FS106-V); (b) Prop. 10's escape: a boundary through `u` contains an arc of `ω(v)`, `v ∈ ω(u)` (TS-U then forces the two colours of that boundary out of `v`'s side cones, which are tangent to `ω(u)` at `v`; it does not produce the curve); (c) without Cond. 5 a boundary may spiral into `u`, and the angles `α₄₅, α₄₆, α₅₆` that Prop. 9 uses need not exist |
| Cor. 3; Lemma 3 (transplanted bicycle, V2) | the curves of Cor. 2; Lemma 3's point choices ("no arc of `ω(p)` can form a boundary") | inherit [G2]; the point choice also uses Cond. 5 |
| Prop. 14/15 (the pseudo-colouring of `ω` is proper) | Prop. 5 | inherit [G1]'s configuration C5 |
| **Prop. 17** (no six-arc cyclic colouring) | its last step is "a unit arc on a boundary, against Cond. 5" | **GAP [G3]**. TS-U applied to that arc (centre `x₂`) is **consistent** with the outer colour-4 cone `B(x₂)` at `x₂`: checked in coordinates (`u = 0`, `x₁ = (1, 0)`, `x₂ = (1/2, √3/2)`): the arc of `ω(x₂)` bounding `B(x₁)` spans directions `[300°, 300° + Δ]` from `x₂`, its away wedge is `[−90° + Δ, 90°]` relative to `x₂ − x₁`, and `B(x₂)` is `(30°, 90°)` there — inside the wedge. So TS-U does not finish Prop. 17; had the arc bent the other way it would have |
| Prop. 19, Lemma 4's fills | fills (valid for open regions at exact distance: V, VB) | the fills hold; Cond. 6 is not a hypothesis here, but the degree-4 trichromatic vertices fills create fall into [G2] (a) |

**Configuration C5 (Prop. 5 fails at `x` without Condition 5).** `u = 0`-free description: `x, y` on `ω(u)`, `|x − y| = 1`. Near `x`: colour 1
on `int ω(y)`, colour 2 on `ext ω(y)` (the arc of `ω(y)` through `x` is the boundary; `ω(u)` crosses it transversally at `60°`). Near `y`, with
`φ₀ < π/3` the half-angle of that arc as seen from `y`: colour 1 in the open wedge of directions within `π/2 − φ₀` of `x − y`, colour 2 in the
opposite wedge, and two further colours in the two side cones. Checked: every pair of colour-1 (resp. colour-2) points from the two
neighbourhoods is at distance `≠ 1` (TS-U's radius formula, with strict wedges); the half-neighbourhoods of `x` and `y` along `ω(u)` carry 1
toward each other and 2 away, as Prop. 5's hypothesis asks (the tangent of `ω(u)` at `y` makes `30°` with `x − y`, inside the colour-1 wedge);
and `x` is adjacent to colours 1 and 2 only. So Prop. 5 is not a local consequence of a.e.-properness once unit arcs are allowed; whether C5
embeds in a global 6-colouring is exactly what [G1] asks. Its everywhere-proper form (Question 2 as posed) also passes: `x`'s own colour is 1 or
2, `y`'s is one of the side-cone colours, and every point of the arc is at distance 1 from `y` and coloured 1 or 2.

### 2.6 Verdicts

| claim | verdict | minds / grade |
|---|---|---|
| **C-AE-Q2** | **GAP at three named steps**: [G1] chromaticity `≤ 3` (S–V Lemma 2) without Cond. 5 — the local configuration C5 shows its Prop. 5 input fails; [G2] the deformed annulus (Cor. 2) at a bowtie vertex, at a boundary through `u` lying on a unit circle about a point of `ω(u)`, and at spiralling boundaries; [G3] Prop. 17's last step (a colour cone bounded by a unit arc), which TS-U does not exclude. **No counterexample**: every configuration found is local. Proved on the way, with no Condition 5 or 6: TS-U, TS-L1, TS-C, TS-T | 1 / [hand] for TS-U, TS-L1, TS-C, TS-T; the GAPs by explicit local configuration (C5) or by the failed check ([G3]) |
| **C-AE-Q2-EV** | **GAP at the same three steps**; the everywhere form adds boundary colours, and C5 accommodates them | 1 / [hand] |
| SV-L4 (a) under Conditions 5, 6 (FS106-V2's open step) | **TRUE** (TS-C, TS-T, Lemma 2) | 1 / [hand] |

**Registered expectation E6** (planner: TRUE 0.5, FALSE 0.15, GAP 0.35) — scored at the close; this job's verdict is GAP. **For FS-107:** [G1]–[G3]
are W's openings with a map's topology intact — a six-colouring would have to use a unit-arc boundary at a colour-change point of the circle about
a 4-chromatic point, or a unit-arc boundary through a trichromatic point, or a bowtie; TS-L1 and TS-C are constraints W cannot escape.

**Would have searched here:** a search for a global 6-colouring extending C5, or a map realising [G3]'s cone; instead each was stated as a local
configuration and checked by hand.

## Stage 2 — SAVED

## Stage 3 — SAVED: the other regular classes almost everywhere

*FS106-V3 had committed nothing when this stage ran (`git fetch`: no commits past `0254a287`), so `[Thomassen1999]` was read here (the text
file, pp. 849–852: statement, the nice-colouring definition, Lemma 1's statement, Theorem 1's proof — read once, the clique step checked, the
2-separator surgery read, not re-derived). Townsend's manuscript was not read (see C-AE-MAP6). SV-2's `d = 2` edge case is V3's and is not
touched here.*

| claim | verdict | minds / grade | the argument |
|---|---|---|---|
| **C-AE-POLY** | **TRUE except one named step** — it rests on SV-2's repaired form (FS106-V2) and inherits its open edge case: two `pⱼ` of one multicolour antipodal on `ω` (`d = 2`), held by FS106-V3; and SV-L3's transplanted bicycle at V2's sketch grade | 1 (V2) + 1 (this job, for the region-only reading) / [hand] | Every step V2 verified is region-only (V2's map). The two steps V2 flagged as using boundary colours are **moot in the a.e. form**, which has no boundary colours: (i) Prop. 7, region-only: a unit circle meeting `int(pqz)` either crosses `zx` or `zy` transversally — then it enters the colour-1 region beside the segment — or it has both ends of its arc inside `xyz` on `xy` (a tangency from inside does not stop it), where its sagitta is at most that of `ω(v)`'s chord `xy`, which is the distance from `xy` to `l`, so it cannot reach `int(pqz)`; or it passes through `z`, where Prop. 4 runs on the colour-1 **regions** flanking `zx` and `zy` (the crossing of `ω(u′)` with the path is not at `z` because `|u′ − z| ≠ 1`). So Prop. 7 and Prop. 8 hold region-only, and **FS106-VB's GAP on Prop. 8 and Observation 1 does not touch the a.e. form**: VB's counter-configuration is about a boundary point's colour. Since an everywhere-proper polygonal colouring is a.e.-proper, **C-AE-POLY ⟹ SV-2** by a route that never uses Observation 1. Controls: K1 is polygonal, a.e.-proper, 7 colours, and every step that spends "six" (Lemma 2, Cor. 3, Lemma 3) fails on it as V/VB recorded. |
| **C-AE-FA** | **GAP at one named step**: Prop. 19's fill step under Condition 6 (FS106-V2's residual: a boundary walk from a chosen point returning to an unchosen point within 1; fills can create trichromatic vertices of degree 4) — plus C-AE-POLY's edge case | 1 / [hand] | SV-1's other open step, **SV-L4 (a), is closed here** (TS-C, TS-T with Lemma 2, stage 2 §2.4). Everything else is region-only (V2's map). |
| **C-AE-NICE** (the a.e. form of `[Thomassen1999]` Theorem 1 on the plane) | **its a.e. form is the theorem itself**: Thomassen's nice condition is already a condition on open faces ("each color class is the union of faces (and part of their boundaries) such that the distance between any two of these faces is greater than 1", faces of "diameter less than 1"), and his proof uses no boundary point's colour — only that a face and every face whose facial cycle meets its cycle are pairwise at distance `< 1` (checked: two such neighbours `y, z` of `x` have points `p ∈ C_y ∩ C_x`, `q ∈ C_z ∩ C_x` with `|p − q| ≤ diam cl F_x < 1`), so they form a clique of the colour-conflict graph, and a map-graph vertex of degree `≥ 6` (his Lemma 1 after the 2-separator surgery) gives 7 colours. So C-AE-NICE ⟺ TH-99 on the plane; its truth is TH-99's proof, whose verification is V3's. **The relaxation that matters is different**: faces of one colour with no unit pair between them (instead of distance `> 1`) is a subcase of C-AE-Q2, and there Thomassen's clique step fails — two small faces of one colour on the rim of a third face can be `< 1` apart with no unit pair (their union of diameter `< 1`) — so that form is **GAP with C-AE-Q2** | 1 / [hand] + [external, read once] | For the plane, (i)–(iii) of TH-99 hold; nice colourings are everywhere proper for every choice of boundary colours (a monochromatic unit pair on closures would put two faces of one colour at distance `≤ 1`). |
| **C-AE-CONV** (the a.e. form of `[Coulson2004]`) | **TRUE with 7 colours at C-AE-POLY's grade, for locally finite tilings by convex polygons**; the non-locally-finite case is outside this reduction | 1 / [hand] | Merge adjacent tiles of one colour across their shared open edges: no unit pair is created (a unit circle through an interior point of an open edge enters one of the two open tiles beside it, so the conflict existed before), and the result is an a.e.-proper polygonal map; apply C-AE-POLY. That is stronger than Coulson's six. **Reading debt:** Coulson's own hypotheses (local finiteness, tile sizes) are unread here — `[Coulson2004]` is held and unread (FS106-V's stage 5); the verdict is stated for the locally finite case only. |
| **C-AE-MAP6** (the a.e. form of `[Townsend2005]` / Townsend's manuscript: five colours) | **GAP, pending FS106-V3's reading of Townsend's proof; reduced here to one step** | 1 / [hand] | What holds with no Condition 5 or 6, five colours, a.e.-proper: TS-T gives a point `u` of chromaticity `≥ 3` within 1 of every point; region points of `ω(u)` avoid `c(u)` (stage 2 §2.5, row "Prop. 6, Lemma 2"), so they use at most two colours; a region arc of `ω(u)` of one colour longer than `π/3` carries a unit pair. **What is left is exactly Townsend's printed lemma in a.e. form** (TW-81: "any 2-colouring of A° contains a monochrome unit" for a "finitely disconnected unit annulus" with a cut-point-free segment of length `> π/3`): the two free colours must fill a deformed annulus about `ω(u)`, and unit-arc boundaries are what disconnect it (K2 is the reason the hypothesis has cut points). The exact-distance circle alone does not refute two colours (alternating arcs of `π/3`), so the thickening is essential. **"Boundaries of measure 0" is not used by any step written here**; it matters only for the link to `χ_m⁰` (a fat boundary is an uncoloured positive-measure set). |

**Would have searched here:** none.

## Stage 3 — SAVED
