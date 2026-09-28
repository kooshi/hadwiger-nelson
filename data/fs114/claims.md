# FS-114 — the fixed claim list (statements only)

*Written by the milestone planner (job FS114-P), 2026-09-27. **Statements only: no proof, no sketch, no route.** Every quotation is verbatim, with
its source address, and was checked by `tools/fs114_p_quotes.py --file data/fs114/fs114-p/quotes-claims.tsv` (output
`data/fs114/fs114-p/quotes-claims.out`); text outside quotation marks is this list's own and is marked "(this list)". Grades are `CLAUDE.md`
§ Notation's; "minds" counts derivations. Give every claim you work one verdict — **TRUE** (with your derivation), **FALSE** (with a
counterexample), **GAP at a named step**, or **MISSTATED** (with the corrected statement, graded) — with your count of minds and your grade. FALSE and
GAP are results, as valuable as TRUE (standing rule 4). **Every statement about a valid map is about a possible object**: the class is not known to be
non-empty, and it is empty exactly when the NO holds. This list follows `data/fs112/claims.md` (FS-112's), whose §§0–9 stay in force where this list
does not restate them, with its §11 corrections applied.*

## 0. Definitions (quoted)

- **Valid map, unit arc, (Q), (R2), `M*`, `F(M)`, `R(M)`** (`plans/FS112-derivation.md`, header, verbatim): "A map is **valid** when it is a locally
  finite map of the plane bounded by segments and circular arcs, **arcs of radius 1 allowed** (Condition 5 dropped), carrying a six-colouring in which no
  two interior points of one colour are at distance exactly 1. A **unit arc** is a boundary arc of radius 1; **(Q)** an arc whose centre carries both
  side colours and at least four colours; **(R2)** an arc whose centre carries the outer side colour and not the inner, with an inner-colour tile along
  the radius-2 circle over the whole arc. `M*` is a terminal valid modification (N2-TERM). `F(M)`: the vertices of at least four colours; `R(M)`: the
  vertices carrying a repeated colour."
- **`𝓜_K`** (`data/fs112/claims.md` §0, verbatim, quoting `plans/FS107-derivation.md`): "periodic designs with at most `K` circular or straight arcs
  per tile, arc radii at least `1/K`, at most `K` tiles per unit disc"; for the limit object "the same bounds without periodicity".
- **Siamese** (`[Polymath16threads]` `[10.59]`, de Grey, 2018-09-03, verbatim in `data/fs112/fs112-pa/extracts.md`): "tiles that lie entirely within
  each other’s annulus of exclusion". *(this list)* A vertex at which two tiles of one colour meet carries a repeated colour, so it is in `R(M)`.
- **Scalable** (`[16.349]`, Pálvölgyi, 2021-02-01, verbatim in `data/fs112/fs112-pa/extracts.md`): "Call a coloring scalable, if there is some small
  positive number eps such that the coloring remains unit-distance-free after you enlarge/shrink some of the tiles by at most eps. This is equivalent
  to the fact that the coloring avoids all distances in [1-eps,1+eps]." *(this list)* A valid map with a unit arc is not scalable; this project's word
  is "slack".
- **Nice, and the map graph** (`[Thomassen1999]`, held text, verbatim as quoted in `plans/FS106-V-verification.md` V3 stage 2): "we assume that each
  face (i.e., arcwise connected component of S\G) has diameter less than 1, is homeomorphic to a disc, and is bounded by a cycle in G. Now a nice coloring
  of S obtained from G is a coloring such that each color class is the union of faces (and part of their boundaries) such that the distance between any
  two of these faces is greater than 1."; and (`~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt`, the proof of
  Theorem 1, verbatim) "We define the map graph M = M(G, S) as the graph whose vertices are the faces of G such that two vertices in M are neighbors if
  and only if the corresponding facial cycles in G intersect." *(this list)* The **map degree** of a face is its degree in `M`.
- **Close complementary pair** *(this list, from FS112-N3-COR3's statement, §2)*: two cubic trichromatic vertices with disjoint multicolours at distance
  below 2.
- **Local** *(this list)*: a statement or a step **reads radius `R`** when its hypotheses and its conclusion concern only the map inside a closed disc of
  radius `R`. A **valid fragment on a disc** `D` is a map of an open set containing `D`, bounded by segments and circular arcs, six-coloured with no two
  interior points of one colour at distance exactly 1.

## 1. The questions

- **Q-full** (`data/fs112/claims.md` §1, verbatim, from `plans/STUB-unit-arc-half.md`): "a locally finite map bounded by segments and circular arcs, arcs
  of radius 1 allowed, carrying a six-colouring in which no two interior points of one colour are at distance exactly 1." **Q-full_K** *(this list)*:
  Q-full within `𝓜_K`.
- **The question in print, four times.**
  - `[SokolovVoronov2025]` Question 2 (`data/fs112/claims.md` §1, verbatim): "Is it true that 7 colors are needed to color a locally finite map in the
    plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?"
  - `[Polymath2021]` p. 199 (`data/fs112/claims.md` §1, verbatim): "It may be possible to eliminate criterion (ii) via an exhaustive computer search of
    all possibilities, but this has, as yet, remained beyond our reach."
  - **The local form** — Mixon, `[Polymath16threads]` thread 7, 2018-06-16 (`data/fs114/fs114-p/polymath16-greps.txt`, verbatim): "What is the radius of
    the largest disk in $\mathbb{R}^2$ that can be 6-colored?"
  - **The non-Siamese case** — de Grey, `[16.317]`, 2020-10-31 (`data/fs112/fs112-pa/extracts.md`, verbatim): "to prove that the plane cannot be
    6-tlled with a non-Siamese tiling; Tom Sirgedas got very close to such a proof a while back and is trying a new approach now."
- **The global step** (`plans/STUB-global-step.md`, verbatim): "Is there a valid six-map with unit arcs — equivalently, since every valid map has the
  property, one in which a vertex of at least four colours or a repeated colour lies within 3 of every point? **Exclude it** (the NO), or **build one**
  (the YES)."

## 2. The inputs held (statements verbatim from `plans/FS112-derivation.md`; grades as filed there)

- **FS112-N3-DENSE3** [hand; two minds, one blind: N3; NB3; over FS112-N3-BASE and FS112-DISC1]: "Every closed disc of radius 3 of every valid map holds
  a vertex of at least four colours or a vertex with a repeated colour."
- **FS112-N3-BASE** [hand; two minds, one blind; over row 134's base at its grade, unre-derived there]: "In a valid map, if the closed disc of radius 2
  about a cubic trichromatic vertex `u` holds no vertex of at least four colours and none with a repeated colour, row 134's base refutes the map near `u`
  (inert unit arcs centred within 1 of `u` first bent toward their centres)."
- **FS112-N3-COR3** [hand; two minds, one blind]: "In a valid map, a close complementary pair of cubic trichromatic vertices `u, u′` (disjoint
  multicolours, `d < 2`) sits on a unit rhombus `u, q₊, u′, q₋` whose other corners are vertices of at least four colours, each a leaving centre of both
  `u` and `u′`, a unit arc of each leaving centre's circle being both-kind there: T2 is forced at both common unit points."
- **FS112-C-PARTNERS** [hand; one mind: FS112-C]: "In a valid map, every close complementary cubic trichromatic partner of a cubic trichromatic vertex
  `u` is the fourth corner `w_i + w_j − u` of a unit rhombus on two of `u`'s leaving centres, so `u` has at most three such partners."
- **FS112-N3-NOBOTH** [hand; two minds, one blind]: "The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour."
- **FS112-N2-RED** [hand; two minds, one blind]: "Every valid map has a valid modification by W-MERGE and whole-arc bends, creating no unit arc, in which
  every unit arc is (Q) or (R2); the procedure terminates with no stubs."
- **FS112-NB4P** [hand; three minds, one blind]: "NB-4 corrected: at a vertex of exactly four colours, let `(v, y₀)` be a covering pair at a change point
  of its ring; if no point of `y₀`'s `σ_v`-orbit lies in the closure of an arc of `Γ` on `ω(v)`, and no arc of `Γ` on `ω(y_{k±1})` has `y_k` in its
  closure, contradiction; the bound on the colours at `y_k` is not needed."
- **FS112-A4SIX** [hand; three minds, one blind]: "A four-colour vertex with no covering pair on its unit circle has on that circle arcs of `Γ` centred at
  it of total length at least 60°, or at least six, one in each of six consecutive 60° windows (C-UA-BUDGET, branch 1)."
- **FS112-SIX** [hand; two minds, one blind]: "A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole
  unit circle lies in `Γ`, every arc of kind both."
- **FS112-N2-TERM** [hand; two minds, one blind]: "Every valid map has a valid modification `M*`, creating no unit arc, in which every unit arc is (Q) or
  (R2); every vertex is cubic, an NB4P exception with at least four colours, or stuck; every stuck vertex lies on a stuck chain along its normal line
  that is not bi-infinite, each finite end within distance 1 of a (Q) or (R2) arc or an NB4P exception, every horn bound `±1` on it a (Q) or (R2) arc;
  one-sided infinite chains are a GAP."
- **FS112-C-ENDS** [hand; one mind: FS112-C, repaired by FS112-C2]: "In a terminal valid map, the point of the normal line one step beyond each finite
  end of a stuck chain has at least four colours, except possibly beside a one-vertex chain bounded by unit arcs on both sides but not on all four horn
  arcs, at a bound on an (R2) arc — a residue not walked."
- **FS112-C-COMPOSE** [hand; one mind: FS112-C]: "The two gaps compose as follows: (1) since every valid map has `F ∪ R` within 3 of every point,
  excluding such maps is the NO for every valid map, periodic or not, with no ray step; (2) for a doubly periodic map, the terminal modification's
  four-colour vertices meet every closed disc of radius `|K| + 2`, `K` its finite curvature set, so the NO reduces to the four-colour form with no ray
  step and no third step; (3) for aperiodic maps the four-colour form needs both the stuck ray excluded (b′) and a uniform bound on the length of finite
  stuck chains, a third GAP, (b″)."
- **FS112-N3-PER** [hand; two minds, one blind]: "A doubly periodic valid map has a periodic terminal modification, so finitely many arc classes: it has
  no stuck ray and its chains are bounded; for a non-periodic map with finitely many arc classes whether its terminal modification keeps finitely many
  is a GAP, N3-ALPH."
- **The controls' radii** (`plans/FS112-derivation.md`, verbatim): DENSE3's entry, "On both positives it holds (four-colour midline vertices within 1.834
  of every point of the strip; the disk's corners)."; FS112-DISC, "No vertex-centred disc of radius above `φ` lies in any valid extension of the disk,
  and a valid extension holds `B̄(A_0, φ)`: φ is attained".

## 3. The forms of the global step (stage 5 of the plan chooses; each is a claim to decide)

- **GS-D — DENSE3's form** *(this list)*: no valid map exists (Q-full's NO), attacked with FS112-N3-DENSE3 as a held property of every counterexample.
  By FS112-C-COMPOSE (1) it is the NO itself.
- **GS-4 — the four-colour form** (`plans/STUB-global-step.md`, verbatim): "no valid map whose vertices of at least four colours come within `R` of every
  point". *(this list)* For doubly periodic maps it is the NO by FS112-C-COMPOSE (2); for aperiodic maps it needs FS-115's (b′) and (b″).
- **GS-1 — one four-colour vertex** (`plans/POROS-2026-09-27-night-aim.md` §5 hunch `every-valid-map-has-a-four-colour-vertex`, verbatim): "the terminal
  modification of every valid six-map with unit arcs has a vertex of at least four colours, outside FS112-C-ENDS's named residue"; and §6, verbatim: "A
  local exclusion about **one** four-colour vertex would be the whole NO, with no ray step and no density". [one mind: NIGHT-A, over the close's links]
- **C114-EXISTS-F** *(this list; GS-1's first half as a claim)*: every valid map has a valid modification with a vertex of at least four colours — with
  FS112-C-ENDS's residue closed, or named as the one case it misses.
- **C114-LOCAL-F** *(this list; card 2's falsifier as a claim)*: there are an explicit radius `R` and a derivation that no valid fragment exists on the
  closed disc of radius `R` about a vertex of at least four colours. *(this list)* By the strip, any such `R` exceeds `√15/4 + √3/2 ≈ 1.834`.
- **C114-LOCAL-FR** *(this list)*: the same with "a vertex of at least four colours or a vertex with a repeated colour" in place of "a vertex of at least four
  colours". *(this list)* With FS112-N3-DENSE3 it is the NO with no further step; C114-LOCAL-F needs C114-EXISTS-F beside it.
- **C-LOCAL** (`data/fs112/claims.md` §6, verbatim, carried): "is there a NO of Q-full whose every step reads a disc of bounded radius `R`? TRUE (with
  `R`) / FALSE / GAP." Its FS-112 verdict (`data/fs112/claims.md` §11 item 13): "**C-LOCAL: GAP** (no explicit radius for a NO; N3-DENSE3's radius 3 is not
  a NO)."
- **C114-COMPACT** (`data/fs112/claims.md` §6, C-LOCAL's own note, verbatim): "At bounded `K`, a NO gives some radius by compactness [hand, one mind:
  FS112-A, over `plans/FS107-derivation.md` W-EQ-K's compactness step". *(this list)* Stated as a claim: for each `K`, Q-full_K's NO holds if and only if
  some radius `R(K)` admits no valid fragment of complexity at most `K` on a disc of that radius. The question card 2 leaves is whether an explicit `R`,
  and one uniform in `K`, exists.

## 4. The route claims (each a question the proof side decides; none held)

- **C114-VOR** *(this list)*: `[Voronov2023]` Thm 1.3's argument (six closed sets covering a disc of radius 3 realise the unit distance; verified at
  FS-106, row 132) either survives for valid maps with unit arcs, read almost everywhere, on a disc of explicit radius, or fails at a named step; name
  the step closedness buys (row 132: "closedness enters once, as compactness giving a band", `CLAUDE.md` § The aim, link 4).
- **C114-THOM-TOP** *(this list)*: `[Thomassen1999]`'s Lemma 1 ("If G is a connected, locally finite, and locally Hamiltonian graph with at least 13
  vertices, then G has a vertex of degree at least 6.", verbatim) and the topological steps of his Theorem 1's proof hold for the map graph of every
  valid map, with FS106-V3's repairs (`plans/FS106-V-verification.md` V3 stage 2).
- **C114-RAINBOW** *(this list; §IQ candidate (a))*: in a valid map, if two faces of one colour both meet the closure of a face `x` (either may be `x`),
  then they are Siamese or they are separated by a unit arc (the unit-radius tactic) — a reading; decide it, or state what else occurs.
- **C114-CURV** *(this list)*: there is an explicit `R₀(K)` such that every closed disc of radius `R₀(K)` of a map of complexity at most `K` whose faces
  have diameter at most 1 contains a face of map degree at least 6.
- **C114-SKELETON** *(this list; §IQ candidate (b))*: the four-colour vertices of a valid map, with the rhombus completions of their close complementary
  pairs (FS112-C-PARTNERS), satisfy local rules stated as a discrete planar structure (Sirgedas's `[16.346]`: "Arrows in the dual graph correspond to
  curved edges in the tile graph. Each quad in the dual graph “emits” four arrows."); state the rules, derive each, and say whether they lose information
  a NO needs.
- **C114-BUDGET** *(this list; §IQ candidate (c))*: a charge on vertices and faces, fixed by Euler's formula on the torus (doubly periodic maps) and
  averaging to that value on the plane (aperiodic maps of bounded complexity), is positive at every vertex type a valid map allows, or the types where it
  is not are named.

## 5. The construction side's claims (each checked exactly on an object given by formula; none held)

- **C114-PENT** (`plans/STUB-global-step.md` open item 3, verbatim): "on the disk's pentagon skeleton, can the trivalent `B_k` (two unit-arc boundaries,
  centres `A_k`, `A_{k+1}`) be given a third unit-arc boundary whose completions are exactly their complementary partners (`B_0`'s current partners
  `Z^R_0`, `Z^L_1` are not completions)?" — "And the disk's blue and orange routes to a fourth colour at `C_0`, never analysed (Y3 §4.4 (ii))."
- **C114-DIAL** *(this list)*: a valid fragment, by formula and checked exactly, on a closed disc of radius above `≈ 1.834` about a vertex of at least four
  colours — or a derived obstruction at a named radius.
- **C114-TORUS** *(this list)*: a doubly periodic valid map by formula (a map on a torus), checked exactly — or, for a named family, the derived reason each
  member fails, with its free parameters counted against the configuration's (G21).
- **C114-SIRGEDAS-FORM** *(this list)*: a valid map, or a fragment on a disc of radius above `≈ 2.124`, with no Siamese pair (every vertex of `R(M)`
  absent) — the case de Grey's `[16.317]` names.

## 6. Shared constraints (verbatim where quoted; the rest of `data/fs112/claims.md` §§7–9 stays in force)

- **Controls** (`data/fs112/claims.md` §7): CAL-STRIP, CAL-DISK, CAL-7 and CAL-FRAGS as there, with FS112-BOWTIE (`tools/fs112_yb3_frags.py bowtie`) and the
  hexagonal seven-colouring; every new checker accepts them before any refusal is believed, and every ACCEPT prints the number of tile pairs examined
  against the number the object has.
- **Killing tests** (`data/fs112/claims.md` §8, carried): 1 (the seven-colour control: "The argument must fail on the slack hexagonal 7-colouring, and
  must name the step where "six" is spent (TS's K1 rule).") and 8 (the local positives: "every NO route fails on CAL-STRIP (and, once rebuilt, CAL-DISK) at
  a named step and says where the plane beyond them is spent (C-BEYOND). A route with no such step is refuted by the strip."). *(this list)* A local route
  also fails on the strip at radius `≈ 1.834` about a midline vertex and says so.
- **Failure clauses** (`plans/STUB-global-step.md`, verbatim): "A NO for doubly periodic maps only is a result, not the question (W-EQ-K's limits); a NO
  that uses the complexity bound where row 134's chain did not must say so; a NO at bounded `K` only answers Q-full_K, not Q-full."; "A YES candidate that
  fails the exact check measures the candidate; a family of formula candidates that all fail measures the family's image (state its free parameters
  against the configuration's)."; "No argument one class at a time (row 129)."
- **The ban and beyond it** (`CLAUDE.md` § Toolchain; Kooshi): candidates by formula, checked exactly; "search for a finite graph is out." *(this list)* No
  enumeration of maps, colourings, tile graphs or dual graphs, by any program.

## 7. Not claimed (for reference)

Any value of `χ(ℝ²)`; unbounded complexity in FS-107's sense (FS-111); boundaries other than segments and circular arcs; FS-115's (b′), (b″) and
bowtie end (c) as questions of their own; C-HOCK (FS-112: no instance); `[Kainen1992]`'s robustness conjecture; C-VOID (FS-109).

## 8. Added at the plan's stage 5b, after the Google group was fetched (2026-09-27; `plans/FS114-unit-arc-question.md` stage 5b)

*Sources: `~/source/library/hadwiger-nelson-problem-group/threads/J_Tw1_hUxQI.txt` ("Graph Coloring by Simulation") and `…/Z50mmulkXCQ.txt` ("6-coloring a
degree 5 graph"); quotations checked, `data/fs114/fs114-p/quotes-group.out`. In Sirgedas's words a "vertex" is a tile, its "degree" the number of tiles
sharing an edge with it, and a "polygon" or "quad" a map vertex where that many tiles meet.*

- **C114-EDGE-RAINBOW** *(this list)*: in a valid map, two faces of one colour that each share a boundary arc of positive length with a face `x` (either may
  be `x`) are Siamese. Its non-Siamese reading is Sirgedas's (`Z50mmulkXCQ`, 2020-09-12, verbatim): "Degree 6 isn't possible with only 6 colors."
- **C114-DUAL-COUNT** (Sirgedas, `Z50mmulkXCQ`, 2022-05-01, verbatim): "1 quad "emits" 4 curved edges. This is 2n edges (80% of all edges)." *(this list)*
  Stated for a doubly periodic valid map with no Siamese pair in which every tile has five edge-neighbours: decide it; then say what replaces it when
  tiles with four edge-neighbours occur (Sirgedas, `J_Tw1_hUxQI`, 2020-01-21, verbatim: "Allowing a degree-4 vertex can prevent curved edges adjacent to
  that vertex, but I think it creates another quad/pentagon.") and when Siamese pairs occur.
- **C114-REDBLOCK** (Sirgedas, `Z50mmulkXCQ`, 2021-06-27, verbatim): "Then, a 6-colored 5-regular graph that covers the plane can be partitioned into red
  blocks"; "Also this graph can't have pentagons."; "Similarly the metagraph can't have a quadrilateral. (Well, I'm pretty certain, but the proof below is a
  bit sloppy(?))."; "So, the red metagraph must have only triangles." *(this list)* Each for valid maps with no Siamese pair and five edge-neighbours per
  tile: TRUE, FALSE or GAP, by derivation.
- **C114-ENCLOSED3** (Sirgedas, `J_Tw1_hUxQI`, 2020-03-08, verbatim, **a finding of a search later found flawed**): "So, a valid tiling can't have an
  enclosed vertex with 3 neighbors." *(this list)* Derive or refute by hand, for non-Siamese valid maps; the search is no input.
- **C114-FIVE-COUNT** (Sirgedas, `J_Tw1_hUxQI`, 2020-01-21, verbatim): "so 200% of the edges are curved, so a 5-coloring is impossible." *(this list)* The
  positive control of any counting route: it must yield that non-Siamese valid five-colour maps do not exist (a known value, row 132), and name the step
  where six's room enters.
