# FS-112 — the fixed claim list (statements only)

*Written by the milestone planner (job FS112-P), 2026-09-27. **Statements only: no proof, no sketch, no route.** Every quotation is verbatim, with
its source address; text outside quotation marks is this list's own and is marked "(this list)". Grades are `CLAUDE.md` § Notation's; "minds" counts
derivations. Give every claim you work one verdict — **TRUE** (with your derivation), **FALSE** (with a counterexample), **GAP at a named step**, or
**MISSTATED** (with the corrected statement, graded) — with your count of minds and your grade. FALSE and GAP are results, as valuable as TRUE
(standing rule 4). **Every statement about a tight six-map is about a possible object**: the domain is not known to be non-empty. Each claim names
the unit-arc kind it concerns (§0) when it concerns one. This list follows `data/fs110/claims.md` (FS-110's), whose §§0–9 stay in force where this
list does not restate them; its §9 corrections are applied here.*

## 0. Definitions (quoted)

- **`𝓜_K`** (`plans/FS107-derivation.md`, header, as quoted in `data/fs110/claims.md` §0): "periodic designs with at most `K` circular or straight arcs
  per tile, arc radii at least `1/K`, at most `K` tiles per unit disc"; for the limit object "the same bounds without periodicity". *(this list)* Row
  134's chain used no complexity bound ("No step uses the complexity bound", `LEDGER.md` row 134); `K` enters only W-EQ-K (§5).
- **Valid** (`plans/FS110-derivation.md`, header): "a map is **valid** when it is a full a.e.-proper six-colouring (no two interior points of one
  colour at distance exactly 1)". **Tight** (`data/fs106/claims.md` §0, D-SLACK): "*Tight*: slack for no `ε > 0`" — never Hoffman's sense.
- **Condition 5 and Condition 6** (`[SokolovVoronov2025]`, held PDF, as quoted in `data/fs110/claims.md` §1): "If any boundary intersects with a circle of
  unit radius at a finite set of points, we say that arcs of unit curvature are forbidden." / "There are no trichromatic vertices of degree greater than
  3." **Y3-C5** (`plans/FS110-derivation.md`): "In `𝓜_K` the print's Condition 5 coincides with "no boundary arc of radius 1"." [hand, trivial; three minds]
- **Types, covering pair, complementary, tangent pair, bowtie, cusp, close pair, strong escape**: as `data/fs110/claims.md` §0 with its §9 corrections 1
  ("the union of the closure types is all six; disjointness is an extra hypothesis where a lemma needs it") and 2 ("strong escape": "a class of `P(u)`
  wholly on each side"). `P_cl`, `P_ess`, `Γ` (the boundary set), `ω(x)` (the unit circle about `x`) as there.
- **Unit arc** *(this list)*: a boundary arc of radius 1 (the negation of Condition 5 in `𝓜_K`, by Y3-C5). For a unit arc `α ⊂ ω(P)` with centre `P`,
  its **inner** side colour `s_in` is the colour of the tile beside `α` on `P`'s side and its **outer** side colour `s_out` the colour on the other side.
  Four **contact kinds** at `P`, read off `P_cl(P)` (after FS110-N3-CONF's in- and out-type contacts, extended to arcs; the advisor FS112-A's proposal,
  adopted — `plans/FS112-unit-arc-half.md` stage 4):
  - **in-contact** — `s_in ∈ P_cl(P)`; **self** when the tile at `P` is the inner tile itself (its own diameter realised along `α`);
  - **out-contact** — `s_out ∈ P_cl(P)`: two tiles of colour `s_out` at distance exactly 1 along `α` (a tile of a valid map has diameter at most 1, so the
    tile at `P` is not the outer tile);
  - **both**; **inert** — neither.
  The prints, by their words: `[Polymath2021]` p. 194's tactic is **both** — self in-contact and out-contact ("a tile T of color 1 can share a boundary
  segment E with a tile U of color 2 and also a point P with a tile V also of color 2, if E is drawn as an arc of radius 1 centered on P": `T` is the inner
  tile, `V` has `U`'s colour); `[AxenovichEtAl2014]` Thm 4.2's strip is **self in-contact** by its words ("the rounded boundary being a circular arc of radius
  1 centered at the opposite corner of the tile"), and `[Polymath2021]` p. 194 says of that strip "It makes use of a tactic that we shall also employ below in
  relation to disks", so its out-contacts are **to be read from its reconstruction**, not assumed absent; `[Parts2021]` p. 181's wavy side is
  **out-contact** ("an arc with a radius of 1 centered at the nearest corner of the adjacent tile" of the same colour). FS-110's fragment S1 has an exact
  out-contact (`plans/FS110-Y-construction.md` §4.5, verbatim: "`u_b`–`w′_out` outer `[1, 1.35]`"), so out-contact is calibrated **locally**; no full strip
  or map with it is held by formula.
- **`[Thomassen1999]`'s hypothesis** (p. 850, verbatim): "we assume that each face (i.e., arcwise connected component of S\G) has diameter less than 1,
  is homeomorphic to a disc, and is bounded by a cycle in G. Now a nice coloring of S obtained from G is a coloring such that each color class is the union
  of faces (and part of their boundaries) such that the distance between any two of these faces is greater than 1." *(this list)* It excludes the
  self incidence (diameter `< 1`) and the pair incidence (distance `> 1`).

## 1. The questions

- **Q-full** (the stub `plans/STUB-unit-arc-half.md`, § The question, verbatim): "a locally finite map bounded by segments and circular arcs, arcs of radius
  1 allowed, carrying a six-colouring in which no two interior points of one colour are at distance exactly 1." Object: the limit object (a map).
  - YES (the stub, verbatim): "With FS-107's W-EQ-K (row 133) a YES at bounded complexity gives `χ(ℝ²) ≤ 6` with no MR". *(this list)* A YES with five
    colours would be `χ(ℝ²) ≤ 5`, a different outcome (G64); report it as such. A YES needs curved tiles with at least one unit arc (row 134; G22).
  - NO (the stub, verbatim): "a NO answers Question 2 almost everywhere for circular-arc maps and closes door (A)." *(this list)* `χ(ℝ²) = 7` follows only
    jointly with FS-111's (B) and only given MR (rows 128, 131, 133).
- **Q-full_K** *(this list)*: Q-full within `𝓜_K`. The form W-EQ-K consumes.
- **The question in print, twice.** `[SokolovVoronov2025]` Question 2 (held PDF, as quoted in `data/fs110/claims.md` §1): "Is it true that 7 colors are
  needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3
  are allowed?" `[Polymath2021]` p. 199: "Our failure to discover 6-tilings of larger disks motivates hope that one might be able to strengthen the seminal
  result of Thomassen [11], who showed that the plane cannot be tiled with six colors if the distance between adjacent tiles of the same color is
  strictly greater than 1, i.e. we prohibit tilings in which either (i) some unit-diameter circle encloses two same-colored tiles, or (ii) the unit-radius
  tactic is employed. It may be possible to eliminate criterion (ii) via an exhaustive computer search of all possibilities, but this has, as yet,
  remained beyond our reach." Its tilings (p. 191): "each point lies within a monochromatic region bounded by a closed curve (possibly including part of
  the perimeter of the portion of the plane being colored)". *(this list)* Q-full's NO answers the p. 199 hope for segment-and-arc tilings almost
  everywhere; outside that class it is silent (the stub's banner, item 1).
- **Q-rule** (`data/fs110/claims.md` §1, verbatim there), with **C-SEAMLIST replaced by the (S1)/(S2) dichotomy** (§9 correction 4; `plans/FS110-N-proof.md`
  §2.3, verbatim): "Let `u, v` be a covering pair (closure types, union `[6]`, any sizes, overlap allowed) in a map of `𝓜_K`, `|u − v| < 2`. The pair
  survives at a common unit point `w₀` only if `w₀ ∈ Γ` and one of: **(S1) `w₀` is not a vertex:** the arc through `w₀` is an arc of `ω(x)` for one
  `x ∈ {u, v}`, both its side colours are `x`'s, and `x`'s other colours fill both side cones (one colour in two sectors when `|P_cl(x)| = 3`; possibly two
  colours when `≥ 4`) — a unit-arc seam with an escape at its centre (N-SEAM (c)–(d)); **(S2) `w₀` is a vertex:** each tile at `w₀` lies on one side of
  `ω(x)` for every `x ∈ {u, v}` holding its colour (N-SEAM (b)); in particular each of the four unit directions at `w₀` (the tangents of `ω(u)` and
  `ω(v)`) is either the start of an arc of `Γ` or lies in the interior of a tile whose colour belongs only to the other point." **[hand; one mind (N),
  FS-110]**. Its (S2)-with-arcs cases, verbatim (§5.2): "**Verdict: GAP** at every pattern but N-X's (which N held)."
- **C-ACT1, Act One** (`data/fs110/claims.md` §1, verbatim there): "decide whether any planar map with six colours, tiles of diameter `≤ 1`, class
  densities `≤ 0.2470` and Siamese-or-`≥ 1` same-colour pairs satisfies the adjacent-tile intersecting rule with no tangency at all". *(this list)* With unit
  arcs allowed, "no tangency" includes no unit-arc seam. Status: open. A route that goes round Act One (as row 134's did) says so.

## 2. The three seams (each: close it, realise it, or name its GAP)

- **(S1), the unit-arc seam at a non-vertex** (definition in §1). What FS-110 holds on it:
  - **N2-S1** (`plans/FS110-derivation.md`, verbatim): "At an (S1) seam point on a unit arc of `ω(u)`, with `|u − v|` not 1 or `√3`, both hexagon
    neighbours of the seam point carry `u`'s bowtie colour on both sides along `ω(v)`." [hand; two minds, one blind: N2; NB]
  - **A4-S1-ONE** (`plans/POROS-2026-09-27-fs110-competition.md` § A4-1, verbatim): "N2-S1's two points `σ_v^{±1}w₀` are exactly `ω(v) ∩ ω(w₀)`. At
    `|u − v| ∈ {1, √3}` only one of them is exceptional: the tangency condition in N2-S1's proof holds at one neighbour and fails at the other." [hand, one mind]
  - **Y2-S1I** (`plans/FS110-derivation.md`, verbatim): "Every realisation of (S1) with the seam point an edge point has the arc's sides in `u`'s facing
    and away colours, `u` a strong escape, and the arc's ends vertices meeting a colour of `P(v)`." [hand; one mind, with YB's GAP at item 4] — the GAP
    (verbatim): "a GAP when both side colours are cusps at `u`".
  - **Fragment S1** (FS110-FRAGS, verbatim): "S1 (a bowtie centred on two boundary unit arcs)" — "ACCEPT and tight on both" checkers. [tools, exact]
  - **C-S1-G** *(this list)*: can a whole tight map use (S1) at every close covering pair it does not otherwise escape? Status: open. Its contact
    kind (in-, out-, both, inert; §0) at the arc's centre is part of any answer.
- **T2, the double unit-arc seam (the rhombus)** (`data/fs110/claims.md` §2, verbatim): "`u, v` both emit arcs of `ω(w₀)`, and of `ω(w₀′)` for the second
  unit point, so `u w₀ v w₀′` is a unit rhombus of **vertices** (the spindle's rhombus), `ω(w₀) ∩ ω(w₀′) = {u, v}`".
  - **Y-T2W** (`plans/FS110-derivation.md`, verbatim): "A pair saved at its seam point by T2 makes the point a vertex of degree at least 4 whose branches of
    the two unit circles alternate." [hand; two minds, one blind, at (3, 3): Y; YB; GAP at (2, 4)]
  - **Fragment T2** (FS110-FRAGS): "T2 (the `d = 1` rhombus)", ACCEPT on two checkers; A4-TSU's reading of it: "`P_cl(w) = {1, 3, 4, 5}`".
  - **C-T2 (ii)** (`data/fs110/claims.md` §2, verbatim): "can a whole tight `𝓜_K` map use it at every close covering pair it does not otherwise escape?"
    Status: open (row 134, Not claimed).
- **NB-4's four-colour exception.**
  - **NB-4, general form** (`plans/FS110-derivation.md`, FS110-NB-4, verbatim): "a four-colour vertex needs an arc of `Γ` of `ω(y)` or `ω(σ_v^{±1}y)`
    through a change point of every orbit of its ring." [hand; the Condition-5 statement two minds, one blind] — its source form
    (`plans/FS110-NB-verification.md` l. 164, verbatim): "if in one `σ_v`-orbit `y₀, …, y₅` of change points no `Γ`-arc of `ω(y_k)` or `ω(y_{k±1})`
    passes through `y_k`, then" — **MISSTATED-suspect** (FS112-A): `ω(y_k)` cannot pass through `y_k`; likely a slip for `ω(v)`. The proof side checks it
    against NB §2.3 before using it.
  - **A4-SIX-ARCS** (`plans/POROS-2026-09-27-fs110-competition.md` § A4-1, verbatim): "a four-colour vertex `v` (`P_cl(v) = [6] ∖ {e, f}`) with no covering
    pair `(v, y)`, `y ∈ ω(v)`, has on `ω(v)` either arcs of `Γ` of total length `≥ 60°`, or at least six arcs of `Γ` (centred at `v`), one inside each of
    six consecutive `60°` windows." [hand, one mind, trivial]
  - **C-SEAMS-TWO** *(this list; the advisor's reading, basis read)*: T2's seam points are four-colour vertices (in fragment T2, verbatim A4-TSU:
    "`P_cl(w) = {1, 3, 4, 5}`"; FS112-A: "P(w′) = {1,2,4,6}"), and N-X (verbatim: "At a seam point with no unit arc and disjoint types, the point is a four-colour vertex …") forces a four-colour
    vertex wherever no unit arc passes through the seam point **and the types are disjoint** —
    so the three seams are two species: a three-colour unit-arc centre ((S1)) and a four-colour vertex with its arcs (T2 = NB-4's exception at `w₀`).
    TRUE / FALSE / GAP.
  - **C-V4-K** *(this list)*: with unit arcs allowed, a four-colour vertex in a tight map is excluded, or realisable as a tight local fragment by formula,
    or a named GAP. **C-V56** *(this list)*: the same for five- and six-colour vertices; the print's sketch, verbatim (Polymath16 thread 7 or 8, a comment
    by Aubrey de Grey, `~/source/library/notes/polymath16-threads-1-18-text.txt`): "those six tiles must jointly cover a disk of radius 1 centred on V, and
    the boundaries between them must meet the edge of that disk at the vertices of a regular hexagon. Thus, each tile must lie entirely within the
    Reuleaux triangle defined by its vertices." [a blog sketch, everywhere-proper, unproved]
- **The seam kinds together.** **C-UA-SEAMS** *(this list)*: every close covering pair of a tight map with unit arcs is saved at its seam point by (S1),
  by T2, by an (S2) vertex with arcs (`plans/FS110-N-proof.md` §5.2's patterns), or at a four-colour vertex; an omission is a result.

## 3. The Condition-5 chain, step by step: statements, their grades, and the question for each

**Row 134's grade clause** (`LEDGER.md` row 134, verbatim): "[hand; the chain — NB-4, NB-5, W-MERGE and the cone removal — two minds, one blind (the N
side; NB, A4, NB3, NB4); S–V Cor. 1 a.e. with no `d = 2` exception two minds, both blind (CB, CD), the `d = 2` closure by two routes (CD's Theorem D2; CE's
Antipodal Lemma); the base at cusp sectors: D2, D5 item 5 and D1 two readings (A6, CC), D4 one reading (CE), D5 items 1–4, 6 true after CE's local repair
(R1–R4, the Antipodal Lemma) one mind, no step found failing that was not repaired; the residue lemma one mind (NB4); fragments tools, exact, two checkers]"

**The question for every step (C-CHAIN-n)** *(this list)*: with Condition 5 dropped (unit arcs allowed), the step (a) holds as written, (b) holds off a
named exception (at which contact kind of §0: in-, out-, both, inert; at the arc's centre, on the arc, at its ends), or (c) fails, with the configuration, given by
formula when it is a local one. **Name, per step, which unit circles the step reads**: two distinct unit circles meet in at most two points, so a
unit arc centred at `P` breaks Condition 5 on exactly one circle, `ω(P)` (FS112-A); "survives off unit-arc centres" is then a checkable scope. The first
failure in chain order is the milestone's first result either way. Statements verbatim from
`plans/FS110-derivation.md`:

| id | statement (Condition 5 in force) | grade under Condition 5 |
|---|---|---|
| C-CHAIN-1 NB-4 | "In a tight six-map in `𝓜_K` under Condition 5 no vertex has four colours (nor five)." | [hand; two minds, one blind: NB; A4] |
| C-CHAIN-2 NB-5 | "Under Condition 5 a tight six-map in `𝓜_K` has no close covering pair." | [hand; two minds, one blind: NB; A4] |
| C-CHAIN-3 N3-CONF | "Contacts of a colour on `ω(v)` are in-type or out-type; directions of `c`-sectors lie in `D_c(v)`; compact sets inside `int D_c(v)` are clear near `v`; tangent in- and out-contacts are upward closed." | [hand; two minds, one blind: N3; NB3] |
| C-CHAIN-4 W-MERGE | "Woodall's step 3 almost everywhere for curved arcs: if `int D_c(v)` is nonempty, two non-adjacent `c`-sectors at `v` are joined by recolouring the gap inside `D_c(v)` near `v`; validity and Condition 5 kept, types only shrink." | [hand; two minds, one blind: N3; NB3] |
| C-CHAIN-5 N3-DEG | "`int D_c(v)` is empty only in Woodall's cone: out-type `c`-contacts at both `v ± n`, every `c`-sector a cusp horn along `±a` with bounding curvatures in `(−1, 1)`." | [hand; three minds, two blind: N3; NB3; NB4] |
| C-CHAIN-6 N4-SHADOW | "The shadow near `v` of a tile at `N = v + n` beyond an arc tangent to `a` at `N` is one side of the circle through `v` concentric with that arc; curvature `f(λ) = λ/(1 + λ)` going down, `f̃(υ) = υ/(1 − υ)` going up; a horn is shadowed by its flanks only through out-type tiles at `S′` and `N` tangent to `a` (N4-FLANK)." | [hand; four minds, two blind] |
| C-CHAIN-7 N4-SHAVE | "A horn tip can be recoloured by its two flank colours, valid and keeping Condition 5, unless doubly shadowed (`σ_h < σ_g`); two horns of one colour on one ray merge (N4-RAY)." | [hand; two minds, one blind: N4; NB4] |
| C-CHAIN-8 N4-STUCK | "At a vertex admitting no merge, ray merge or shave, a two-sector colour has exactly two horns `±a`, the vertex has degree 4, and the antipodes carry `P_cl(N) = {c, h, r}`, `P_cl(S′) = {c, g, r′}` with double sectors; in a terminal map a stuck vertex forces stuck vertices at unit spacing along the normal line, bi-infinite (N4-PROP)." | [hand; two minds, one blind: N4; NB4] |
| C-CHAIN-9 N4-FIN | "No bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`." | [hand; two minds, one blind: N4; NB4] |
| C-CHAIN-10 N4-TERM | "Every valid map has a terminal valid modification (each point changed finitely often), and in it no colour has two sectors at any vertex: every vertex is cubic, sectors possibly cusp horns (N4-CONE, N4-RED)." | [hand; two minds, one blind: N4; NB4] |
| C-CHAIN-11 NB4-CS | "The terminal map's only surviving cusp horns are single horns that are doubly shadowed with `D_c(v)` the line `±a`: single-horn Woodall cones." | [hand; one mind: NB4] |
| C-CHAIN-12 P17 | "Under Condition 5 no vertex with exactly three sectors has a purely rotating ring (six 60° arcs)." | [hand; many minds, three blind] |
| C-CHAIN-13 COR1-NOD2 | "S–V Corollary 1 holds almost everywhere for curved cubic maps under Condition 5 with no `d = 2` exception, for same- and disjoint-multicolour pairs." | [hand; two minds, both blind, different routes: CB; CD] |
| C-CHAIN-14 CB-LEMMA3 | "S–V Lemma 3 holds almost everywhere for all `1 < d < 2`, by Voronov's bicycle run on the two pseudo-coloured circles; the printed Fig. 5 argument fails from `√3` on." | [hand and tools; two minds, one blind: CB; FS106-V's sketch] |
| C-CHAIN-15 CE5 | "The Antipodal Lemma: at a trichromatic cubic vertex u, cusps and double cusps allowed, no two M-in points of `ω(u)` are at distance 2; it is one-sided, and two antipodal points may both have the strip inside." | [hand and tools; one mind: CE] |
| C-CHAIN-16 CE6 | "CB's D5 repaired by R1–R4 and the Antipodal Lemma: every pair the chain hands to S–V Lemma 3 or Cor. 3 is at distance below 2, at cusp centres and cusp endpoints included, so S–V Cor. 1 almost everywhere needs no `d = 2` exception." | [hand; one mind by this route: CE] |
| C-CHAIN-17 CUSP-BASE | "CB's route holds at cubic vertices with a cusp or double cusp at D2's strip (a)–(c), D5 item 5 and D1's (P′); along a cusp's normal `\|u ± n − x(m)\|² − 1 = 4R(R ∓ 1)m²/(1 + m²)`." | [hand and tools; two readings at D2, D5 item 5, D1; D4 one reading, CE; D5 items 1–4, 6 one mind after CE's repair] |
| C-CHAIN-18 the headline | FS110-CLOSURE: "Under Condition 5 no locally finite map of the plane bounded by segments and circular arcs carries a full a.e.-proper six-colouring; the Condition-5 half of S–V Question 2 is answered yes, almost everywhere." | row 134's clause above |

*(this list)* The stub's registered expectation (verbatim, `plans/STUB-unit-arc-half.md`): "the chain's W-MERGE and N4 steps survive unit arcs outside
the arcs' centres (0.6)". Re-registered in `plans/FS112-unit-arc-half.md` stage 5 with its population.

## 4. The winding apparatus and FS-110's other open items (off row 134's path)

- **YB3-SAME** (`plans/FS110-derivation.md`, FS110-N2-TRANS's verdict, verbatim): "TRUE for `c ≠ d`; **across a same-type edge a GAP** (YB3-SAME, one mind:
  every merge meets an event type no hypothesis excludes; a `c`-tile ringed by `d, e, f` swept by `ω(p)` changes `W` by `±1`)". N2-TRANS itself: "Along an
  edge whose ends have different third colours, off the collinear `d = 2` configuration, the winding transports: `W(u)` on `(d, e, f)` equals `W(u′)` on
  `(c, e, f)`; bowties and cusps included." The owner's ruling (`plans/FS110-close-inventory.md` item 78, verbatim): "Same-type transport becomes a stub item
  (prove it, or refute it by an exact local fragment)". **C-SAME** *(this list)*: across a same-type edge, `W` is transported (TRUE), or an exact local
  fragment by formula changes it (FALSE), or a named GAP. **Bearing on Q-full: none** (FS112-A, adopted): YB3-SAME is a Condition-5 statement — `W` is
  defined only on rings carrying no arc of `Γ` — and its event (a `c`-tile swept by `ω(p)`) involves no unit arc. Ranked last; one in-ban exact fragment.
- **FS-110 item 68** (`plans/FS110-close-inventory.md`, verbatim): "Y3-SIX at bowties; the eight-arc aligned ring; whether a generic `|W| = 3` ring can be
  realised at one vertex". **C-68a, C-68b, C-68c** *(this list)*: those three, each decided or realised by formula.
- **Y-BIKE-3C** (verbatim): "No six-arc three-cycle colouring of each circle colours the bicycle at any `d` in `(1, 2)` whose cross curve meets no grid
  vertex." [hand; two minds, one blind; GAP at grid-corner passages] — the GAP is A4-BAND's cross-swap.
- **YB-V5X** (verbatim): "No bichromatic vertex of degree at least 4 ends a covering pair at a transversal common unit point." [hand; one mind: YB, blind]
  — "Rests on it: C-V5-K in the unit-arc half."
- **N2-SWAP** (verbatim): "A swap point gives a covering pair at distance 1 unless named unit arcs intervene; so under Condition 5 Act One holds in every tight
  six-map with a four-colour vertex or a three-colour vertex whose ring has a swap (N2-ACT1-W0)." Verdict there: "TRUE under Condition 5, GAP without."
- **FS110-A3-HOLE** (verbatim): "A2-V56 and the four-colour Act One step hold when the vertex's unit circle carries no arc of `Γ` and are a GAP when it does."

## 5. Shared constraints (verbatim; the rest of `data/fs110/claims.md` §3 stays in force)

| id | statement | grade |
|---|---|---|
| W-EQ-K | "In `𝓜_K`, band-proper designs with `ε_n, δ_n → 0` exist iff a full tight a.e.-proper six-colouring by tiles of complexity at most `K` exists; ⟸ at complexity `O(K)`, periodised by a seam strip, with `δ(ε) = O(ε)`." | [hand; two minds, one blind: W; VW] |
| W-TAN (as closed at cusps by FS110-CUSP-K) | "two vertices at distance `< 2` whose essential multicolours are complementary three-sets form a tangent pair or include a bowtie; off those and the collinear distance-2 configuration, the three-element (and larger) vertex types of two adjacent tiles pairwise intersect." (`data/fs110/claims.md` §3); FS110-CUSP-K: "A cusp horn is seen like a ray: close complementary pairs at cusp vertices are tangent pairs or bowties, closing W-TAN's cusp GAP." | [derived; two minds, one blind]; CUSP-K three minds, one blind |
| TS-U | `plans/FS106-TS-derivation.md` l. 15: "a unit-arc boundary with colours `c \| c′` puts `c` in the wedge facing it and `c′` in the wedge facing away at its centre, and neither in the two side cones" — read conditionally (A4-TSU, verbatim): "TS-U does **not** put a unit arc's side colours in its centre's type. Its text is conditional" | row 132: two, one blind; A4-TSU one mind |
| FS106-IND-X | "At a unit-arc interface facing a bowtie (or a 4-chromatic point) — configuration C5 with a colour in the side cones at y — complementary translate curves swap and \|Ind γ₁ − Ind γ₂\| = 2; the swap needs a unit-arc interface whenever the curves cross non-tangentially." | [hand + measured; one mind] |
| K-DENS | "each class `≤ m₁(ℝ²) ≤ 0.2470` (row 129's input)" | [external]; re-checked [cert + hand] |
| K-INT | "one-class-at-a-time and fractional arguments stop below 4.37 colours" | [hand], two minds (row 129) |
| K-CHR4 | TS §5: "**GAP** — proved for `\|P(x)\| ≥ 5` off a null set; `\|P(x)\| = 4` open" | [hand, one mind] |
| maps need six | row 132 (verbatim): "maps need six by `[Woodall1973]` Thm 6 with its step 6 repaired by Townsend's lemma, and by Townsend's 1979 manuscript with its step (c) filled by Woodall's" | row 132's grades |

## 6. The unit-arc centre (the structural form of `plans/FS112-unit-arc-half.md` §IQ; each a claim to decide, none held)

- **C-UA-INC** *(this list)*: which of the contact kinds of §0 (in-, with its self case; out-; both; inert) occur at the centre of a unit arc of a tight
  six-map.
- **C-UA-WEDGE** *(this list; §IQ candidate (a))*: if the centre `P` carries a side colour `c` of the arc, the `c`-tiles at `P` face the arc and both side
  cones at `P` are empty of both side colours. Killing test: a tight fragment whose unit-arc centre carries a side colour in a side cone.
- **C-UA-BUDGET** *(this list; §IQ candidate (b))*: at every four-colour vertex `v` of a tight six-map, **on the branch with no covering pair `(v, y)`,
  `y ∈ ω(v)`**, `v` is the centre of unit arcs of total length `≥ 60°` or of at least six (A4-SIX-ARCS, verbatim in §2); **on the other branch** (a covering
  pair at a ring point `y`), the arcs sit on `ω(σ_v^{±1}y)` through `y` — centred at ring points at distance 1 from `v`, not at `v` (NB §2.3; FS112-A). Each
  branch: TRUE / FALSE / GAP. Killing test: a tight four-colour vertex violating its branch's budget.
- **C-UA-CHAIN** *(this list; §IQ candidate (c))*: each unit arc forces a further unit arc (at its end vertices, or on the unit circles of its centre's
  partners); unit arcs therefore lie in chains or cycles, and a monotone quantity along a chain excludes bi-infinite chains. Killing test: a closed cycle of
  unit arcs realised as a tight local fragment by formula.
- **ARC-INERT** (FS112-A, one mind, as corrected by its author; a claim for a side to derive, not a lemma to assume), verbatim: "an inert unit arc
  can be bent off curvature 1 except at finitely many isolated contact points, where a tangent non-unit arc may be needed". Its author's analysis
  (verbatim): a same-colour tile in contact with an inert arc along a whole sub-arc is either "a Siamese contact, which forces P ∈ cl(tile), so the arc is
  not inert" or "an outer contact along the concentric circle of radius 2 about P. That is a d = 2 configuration, and only the INNER colour can do it";
  "At an isolated tight contact point a₀, neither bend is obviously free." — **a GAP at those points**. *(this list)* The radius-2 concentric partner is
  FS-110's `d = 2` geometry returning (G-CONE's antipodal contacts, CE5's Antipodal Lemma). If ARC-INERT holds, the object reduces to unit arcs with a
  contact at the centre (§0's in-, out- or both).
- **C-BEYOND** *(this list; FS112-A's naming)*: every NO route has a step that reads the plane beyond every strip of height `√15/2 + √3` (so beyond every disc
  of radius `(√15/2 + √3)/2 ≈ 1.834`, the largest a strip holds) — **and, once CAL-DISK is rebuilt (§7), beyond every disc of radius
  `√(5/2 + 9/(2√5)) ≈ 2.12426`** — because a valid six-colouring of the strip (and of the disk) is a local positive no argument confined to it can refute.
  The route names that step. (A radius-3 argument meets C-BEYOND; it is not a claim about globality.)
- **C-LOCAL** *(this list; FS112-A's rank-1 card)*: is there a NO of Q-full whose every step reads a disc of bounded radius `R`? TRUE (with `R`) / FALSE /
  GAP. Row 134's only unbounded step was N4-PROP's bi-infinite stuck line. *(this list)* At bounded `K`, a NO gives some radius by compactness; the claim
  asks for an explicit `R` from the route.
- **C-ARC-END** *(this list; FS112-A)*: the end vertices of a unit arc of a tight map are realised in a fully coloured neighbourhood (an **arc-closed**
  fragment), or excluded, or a GAP. FS-110's fragments realise the seams with **open** ends (S1's arc tiles closed by segments to `(9/10)w` and `(11/10)w`,
  uncoloured beyond the arc's ends; T2 and BB flowers truncated at `1/4` and `1/10`, FS112-A's reading); for (S1) the ends are Y2-S1I's item 4, "the
  arc's ends vertices meeting a colour of `P(v)`".
- **HOCK** (Polymath16 thread 6, "Wrestling with infinite graphs", a comment by Bernhard Hockertz, `~/source/library/notes/polymath16-threads-1-18-text.txt`,
  verbatim): "So far all possible tesselations that use some other kind of boundary can be reduced to one using only straight lines and unit radius arcs." and
  "The curvature of the boundary is limited to arcs with radius of unit distance or greater, because every arc with a radius that's smaller than 1 can be
  filled up to radius 1 without increasing the exclusion zone." *(this list)* A blog claim about everywhere-proper tilings, unproved in print. **C-HOCK**:
  in a tight six-map of the class, every boundary arc of radius `< 1` can be replaced keeping validity (TRUE / FALSE / GAP). N4's horn curvatures in
  `(−1, 1)` are radii `> 1`, which the claim allows; its first exact test instance is FS-110's A6-C2 (radii "2, 4, 9/10, 11/10 and segments",
  `plans/POROS-2026-09-27-fs110-competition.md` § Stage A6-3): fill its radius-`9/10` arc to radius 1 and check the result exactly (FS112-A).

## 7. Calibration: the known positive and the controls (every new checker, before any refusal is believed)

- **CAL-STRIP** (`[AxenovichEtAl2014]` Thm 4.2, p. 8, verbatim): "ω(6) ≥ √15/2 + √3" and "we consider a coloring, similar to one used by Pritikin, see Figure
  4. The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile. The tiles
  used in the top and bottom rows are determined by the distance 1 between the point of intersection of circular arcs and the opposite corner of a tile."
  *(this list)* Rebuilt **by formula from these words** (no coordinates are printed; the figure is not a source of numbers), its height checked to be exactly
  `√15/2 + √3`, and accepted by each new exact checker as a valid six-colouring **of the strip**. It calibrates the **self** incidence; which other incidences
  it has is found in the rebuild and stated. `[Polymath2021]` p. 197 cites it ("we have not improved the bound of √3 + √15/2 ≈ 3.668542 that was previously [8]
  demonstrated by the tiling shown in Fig. 6").
- **CAL-DISK** (`[Polymath2021]` p. 199, verbatim): "For k = 6, our best result is the disk shown in Fig. 10, whose radius is" — the radical is garbled in
  the text layer; the caption reads, on the page image, "A 6-tiling of a disk of radius √(5/2 + 9/(2√5))" — "(The relative simplicity of the expression for
  this radius arises because the points A,B,C,D,E lie at the vertices of a unit-edge regular pentagon.)"; and for `k = 4` (p. 198): "Note that we again
  employ the tactic of drawing inter-tile boundaries as arcs of radius 1"; for `k = 5`: "arises from a similar approach". *(this list)* No construction
  rule and no coordinates are printed. **No positive until rebuilt**, in three separated steps (FS112-A, adopted): the **combinatorics transcribed by eye**
  from Fig. 10 (tiles, adjacencies, which edges are unit arcs and where each is centred — reading, after FS-85's by-eye transcription of Parts's trees,
  protocol §1 rule 11); the **exact constraint system solved** by computer algebra; **fitting coordinates to pixels stays out** (a search). The built-in
  control: the rebuild reproduces `r² = (25 + 9√5)/10` exactly. Until then it enters no killing test. It is the only held positive that refutes a
  disc-local argument at radii between `≈ 1.834` and `≈ 2.124`.
- **CAL-7** *(this list)*: a tight seven-colouring fragment — row 33's boundary-tight brick colouring (G20: "boundary-tight by force (cell diagonal exactly
  1)") — accepted as valid. It calibrates straight self-contact.
- **CAL-FRAGS** *(this list)*: FS-110's fragments S1, T2, BB, MX, WC, WC1H and A6-C2, rebuilt from their formulas (`tools/fs110_y_fragments.py`,
  `tools/fs110_y_cone.py`, `data/fs110/fs110-a6/a6_c2_single_horn.py`), accepted by each new checker as the frozen checkers accept them.
- **The checker** *(this list; FS112-A item 6, adopted)*. No frozen checker can accept the strip: FS110-Y and FS110-YB compute in ℚ(√3) only, FS110-YB4
  falls to intervals and asserts equality with 1 only exactly; the strip needs ℚ(√3, √5) (its arches' sides `√3/2`, apex `√15/4`, FS112-A — to be confirmed
  in the rebuild) and the disk a nested radical. A new `tools/fs112_*` checker with exact number-field arithmetic is run in this order: FS-110's fragments
  (same verdicts as the frozen checkers on the same inputs), CAL-7, CAL-STRIP, CAL-DISK. An ACCEPT of the strip calibrates the pair (reconstruction,
  checker); a REJECT has three causes — a wrong rebuild, a wrong checker, a wrong print — and the record says how each is told apart. The robust form is
  two independent rebuilds (a side and its blind verifier).
- **CAL-PLANT** *(this list)*: for each checker, planted faults that fire for their own named reason — a unit arc's radius moved off 1 by a rational amount
  (a same-colour pair at distance exactly 1 appears or a gap opens, named in advance), a tile colour swapped, a tile whose diameter exceeds 1 — each beside
  its faithful twin, which must pass.

## 8. Killing tests

1. **The seven-colour control** (`data/fs110/claims.md` §4, test 3, verbatim): "The argument must fail on the slack hexagonal 7-colouring, and must name
   the step where "six" is spent (TS's K1 rule)." *(this list)* Also on CAL-7 and on the strip: an argument that refutes a map must not refute CAL-STRIP
   **as a strip** (the strip is valid; only its extension to the plane is in question).
2. **The exact check** (`data/fs110/claims.md` §4, test 6, verbatim): "a same-colour tile pair — **including a tile with itself (diameter `≤ 1`)**, FS110-A —
   whose exact cross-distance range has 1 in its interior". *(this list)* "W's exact check certifies MEMBERS": a fragment is a fragment, not a map.
3. **Class density** (W's test 3, verbatim): "Each class's density is at most 0.2470." (periodic candidates)
4. **G17's** *(this list, rewritten on FS112-A's reading)*: a unit-arc seam with no tight **arc-closed** local fragment by formula (C-ARC-END) — FS-110's
   fragments realise every seam with open ends, so the open-ended form cannot fire.
5. **G71's** *(this list)*: a bowtie seam with unit arcs that defeats the index `|Ind γ₁ − Ind γ₂| ≤ 1` with no swap.
6. **§IQ's three** *(this list)*: C-UA-WEDGE's, C-UA-BUDGET's, C-UA-CHAIN's (§6).
7. **The chain's** *(this list)*: a step of §3 declared to survive unit arcs, and a tight local fragment by formula violating its conclusion.
8. **The local positives** *(this list; FS112-A item 5)*: every NO route fails on CAL-STRIP (and, once rebuilt, CAL-DISK) at a named step and says where the
   plane beyond them is spent (C-BEYOND). A route with no such step is refuted by the strip.

## 9. Failure clauses

- (`data/fs110/claims.md` §5, verbatim) "a NO for trivalent maps only is a result, not the question (bichromatic vertices of degree `≥ 4` stay live)".
- (verbatim) "a YES candidate that fails the exact check measures the candidate, not the question."
- (verbatim) "A list of seam kills with no Act One (C-ACT1) decides nothing." — *(this list)* unless the route goes round Act One, as row 134's did, and says so.
- *(this list)* A family of formula candidates that all fail measures the family's image (state its free parameters against the configuration's; G21).
- *(this list)* A NO that uses the complexity bound where row 134's chain did not must say so; a NO at bounded `K` only is Q-full_K's, not Q-full's.
- *(this list)* An ACCEPT is the suspect verdict of an exact tile checker (a missed pair makes acceptance easy): every ACCEPT prints the number of tile
  pairs examined against the number the map has.

## 10. Not claimed (for reference)

Any value of `χ(ℝ²)`; unbounded complexity in FS-107's sense (FS-111); boundaries other than segments and circular arcs; `[Polymath2021]`'s question for
tilings bounded by general closed curves; `[Kainen1992]`'s robustness conjecture (its everywhere form is `χ(ℝ²) = 7` given `[Voronov2023]` Thm 1.1); C-VOID
(FS-109).
