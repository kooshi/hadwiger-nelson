# FS107-VW — blind verification of FS107-W's results

*Job FS107-VW (de Bruijn, Opus 5.5), 2026-09-27. Brief: `data/fs107/briefs/V107-blind-verifier.md` with the instance block
`data/fs107/briefs/V107-instance-W.md` and `data/fs107/briefs/STANDING-RULES.md`. Blind until stage 3 is committed: W's record, tools and data,
the other verifier's record, the advisors' records, the close inventory, the reports and git history beyond `git log -1` (`30fb4472` at start) are
unopened. Fence touches: none.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| VW-HX | For every `0 < ρ < R`, `ε > 0`, family HX is band-proper (null form) iff `7R² − 4Rρ + ρ² ≤ (1−ε)²` and `4R² + 2Rρ + ρ² ≥ (1+ε)²`; every other same-colour class is implied; `δ = (2π/(21√3))(ρ/R)²`, and the two conditions force `ρ/R > 1/2`, so `inf δ = π/(42√3)`, attained by no member | [hand + tools, exact in ℚ(√3)]; one mind here | §2a.2; `tools/fs107_vw_hx_derive.py`, `tools/fs107_vw_hx_check.py` |
| VW-ERODE | A full a.e.-proper colouring by tiles with connected interiors, eroded by `r`, is band-proper at every `ε < 2r`; with `≤ K` arcs per unit disc its holes are `O(Kr)` and its complexity `≤ 2K` | [hand], one mind | §2b.1 ⟸ |
| VW-CPT | Designs with `≤ K` circular arcs or segments meeting each unit disc, `ε_n, δ_n → 0`, have (after recentring and a subsequence) a Hausdorff limit that is a full a.e.-proper six-colouring by tiles with `≤ K` arcs per unit disc | [hand], one mind | §2b.1 ⟹ |
| VW-PIN | A full a.e.-proper colouring whose contacts are uniformly isolated and linearly transversal becomes band-proper at slack `ε` after removing one disc of radius `2ε/c` per contact: holes `O(ε²)` | [hand], one mind | §2b.2 |
| VW-POLY | Polygonal designs with `≤ K` segments per unit disc have hole density `≥ δ₀(K) > 0` at every slack, unless the limit is FS106-AE-POLY's `d = 2` configuration | [hand], one mind; over AE-POLY and VW-CPT | §2b.3 |
| VW-TAN | In a full a.e.-proper six-colouring by a locally finite map with C¹ arcs having tangents at the vertices, two vertices at distance `< 2` with complementary three-element essential multicolours form a tangent pair or include a bowtie; off those and the collinear distance-2 configuration, the vertex types of size `≥ 3` of two adjacent tiles pairwise intersect | [derived], one mind; over C-T-TAN (one mind) | §2b.4 |
| VW-GRID | An exact checker for periodic grid-square colourings (offsets classified in ℚ, colours compared exactly) certifies the rasterised hexagonal 7-colouring with one class blank (blank density `2513/17655`) and a rasterised HX member (`1414/17287`) band-proper; planted squares fire | [tools, exact]; controls | `tools/fs107_vw_grid_check.py` |

## Would have searched here

See §2b.5 (three moves, each replaced by a derivation or declined).

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation in the instance block | source | result |
|---|---|---|
| W-EQ-K, W-RATE, W-POLY, HX-STALL, W-TAN, "verbatim from W's 'Theorems this phase proved'" | `plans/FS107-W-near-colourings.md` | **deferred to stage 4**: the source is fenced until stage 3 is committed; checked there |
| W-POLY's input grade: "AE-POLY (two minds, one blind; SV-L3 a sketch)" | `plans/FS106-derivation.md` l. 105: "[hand; two minds on the chain, one blind: TS (region-only), SB; the V line; SV-L3's repair one mind, sketch]" | matches in substance |
| "FS106-AE-POLY's `d = 2` case" | same, l. 105: "except possibly at the d = 2 edge case of FS106-SV2"; l. 50: "two same-multicolour points antipodal on ω (d = 2)" | matches |
| W-TAN's input "C-T-TAN (one mind)" | `plans/FS106-TS-derivation.md` l. 258, grade column "1 / [hand]" | matches |
| "The definitions are in `data/fs107/claims.md` and `LEDGER.md` row 131" | both read in full (claims.md) and row 131 | µ₆, µ₆⁰, D-SLACK ("*Tight*: slack for no `ε > 0`"), D-JUNC, K-C6 present; **"arc complexity", "design", "contact", "transversal", "tile", "vertex type" are defined in neither** — they are W's, and my readings are stated in §1.2 |
| Known positive: "The hexagonal seven-colouring, rasterised, with one class left blank, is band-proper at positive slack with uncovered density `1/7`" | the owner's sentence | TRUE for the unrasterised design (`2R < 1 − ε`, `√7R > 1 + ε`); rasterised, the blank density is `1/7` only up to the rasterisation (exactly `1/7` when every square takes the colour of its corner and the counts balance; `1/7 + O(h)` when boundary squares are left blank). I build both (stage 2) |

### 1.2 The statements in my own words, and the readings I fix before deriving

Readings (W's terms are undefined in the claim list; I fix these before reading W, and derive under each where the verdict depends on it):

- **Design of arc complexity `K`**: a partial six-colouring whose classes are unions of *tiles*, a tile a closed region bounded by circular arcs and
  segments, band-proper at slack `ε` (no monochromatic pair at distance in `[1 − ε, 1 + ε]`, D-MU's null form). Two readings of "complexity `≤ K`":
  **(Cu)** at most `K` arcs meet every unit disc; **(Ct)** every tile has at most `K` arcs (no bound on the number of tiles per unit area).
- **Full tight a.e.-proper six-colouring by tiles**: a locally finite tiling covering the plane, open tiles coloured, boundaries free (D-AEMAP), no
  two points of one colour's open tiles at distance 1, slack for no `ε` (D-SLACK).
- **Contact**: a same-colour pair of tile points at distance exactly 1 in the closure (the tile pair's `max = 1` or `min = 1`). **Transversal**: the
  distance grows (for `min`) or falls (for `max`) at least linearly in the displacement from the contact within the two tiles.
- **Vertex type** (W-TAN): two readings — **(Tm)** the map multicolour (S–V Definition 2: colours of the tiles whose closure contains the vertex);
  **(Te)** the essential multicolour `P(x)` of D-NF (positive upper density). They differ at cusps.

Restatements:
1. **W-EQ-K.** Compactness at bounded complexity: vanishing-hole designs of complexity `K` exist iff a full tight six-colouring by complexity-`K`
   tiles exists; conversely such a colouring, eroded, gives designs with holes `O(ε)`.
2. **W-RATE.** Eroding a full tight colouring costs `O(ε)` of holes; if its unit-distance contacts are isolated and transversal, pinholes of
   radius `O(ε)` at the contacts suffice, `O(ε²)`, the order of the floor `ε²/(6+ε)²`.
3. **W-POLY.** Polygonal designs of bounded complexity cannot drive holes to 0: `δ ≥ δ₀(K) > 0` — by 1's compactness and FS106-AE-POLY, except
   where the limit is AE-POLY's `d = 2` case.
4. **HX-STALL.** Take the hexagonal 7-colouring (hexagon circumradius `R`), drop colour 0, give each colour-0 hexagon's six centre-to-edge
   triangles to the neighbour across the edge, and leave a disc of radius `ρ` at the centre uncovered. Against two named same-colour pairs the design
   is band-proper iff `ρ` exceeds the stated max; the uncovered density is `πρ²/(7·(3√3/2)R²)`, minimised over the admissible region as `ε → 0` at
   `R = 2/√21`, `ρ = R/2`, value `π/(42√3)`. So HX never drives holes below 0.0432.
5. **W-TAN.** In a full tight six-colouring by a locally finite map, two vertices of complementary three-colour types within distance `< 2` must be
   a tangent pair or a bowtie (C-T-TAN's cone exceptions); away from those, the vertex types of two adjacent tiles pairwise intersect.

### 1.3 Registered expectations (before any derivation; both outcomes reachable)

| statement | I expect | P | the outcome that would teach me something, and that it is reachable |
|---|---|---|---|
| HX-STALL | the two named pairs are the binding ones near the stall, the stall value checks | 0.8 | a third pair (the triangle against the second-ring hexagons, or against its own translates) binds at or near the stall and moves the value — reachable: the second-ring hexagons sit at `≈ 1.13–1.15` at the stall, only ~0.13 clear |
| W-EQ-K | TRUE under (Cu); GAP or MISSTATED under (Ct) at the compactness step | 0.6 | TRUE under (Ct) too (tiny tiles cannot carry positive area in the limit) — reachable if small tiles' total area is forced to vanish |
| W-RATE | TRUE once "tiles of complexity `≤ K`" (finite boundary length per unit area, uniform contact constants) is made explicit; a bare "full tight colouring" is MISSTATED | 0.7 | an isolated transversal contact still needing `≍ ε` of holes per unit area — reachable, e.g. if a contact pair's neighbourhood must be eroded along a whole edge |
| W-POLY | TRUE over AE-POLY, given W-EQ-K's ⟹ under (Cu) | 0.7 | the limit leaves AE-POLY's hypotheses (not locally finite, or a degenerate tile) — reachable under (Ct) |
| W-TAN | GAP at cusps (reading Tm), or at two-colour vertices / distance exactly 2 in the second clause | 0.5 | TRUE as stated under (Te) with the second clause restricted to three-colour types — reachable |

## Stage 2a — SAVED: HX-STALL, reconstructed from the statement alone, with my own exact checkers

### 2a.1 The family, as I reconstruct it

Hexagons of circumradius `R` (side `R`), centres on the triangular lattice `a = √3R(1, 0)`, `b = √3R(1/2, √3/2)`, colour of the centre
`xa + yb` = `(x − 2y) mod 7` (colour lattice `L7 = ⟨2a + b, −a + 3b⟩`, index 7). Colour 0 is dropped. In each colour-0 hexagon (centre `O`), the
triangle `T_m = conv(O, R·u(60m − 30°), R·u(60m + 30°))` goes to the neighbour `H_m` across that edge, and the open disc `D(O, ρ)` is left
uncovered. Uncovered density `δ = πρ²/(7·(3√3/2)R²) = (2π/(21√3))·(ρ/R)²`. This reconstruction reproduces the stated stall value exactly, which is
evidence it is W's family (confirmed or not at stage 4).

### 2a.2 The derivation, for every parameter value (not only members)

With `t = ρ/R ∈ (0, 1)`, the exact distance ranges of the same-colour pieces are (tool `tools/fs107_vw_hx_derive.py`, output
`data/fs107/fs107-vw/hx_derive.out`; the numeric columns are exact computations in ℚ(√3) at `R = 1`, the rest symbolic):

| class | extreme | value² | source |
|---|---|---|---|
| a piece `H_m ∪ (T_m ∖ D)` with itself | max | `7R² − 4Rρ + ρ²` — far vertex of `H_m` to the arc end on the opposite leg; every other hull pair is `≤` it for `t ∈ [0, 1]` (checked symbolically) | **pair 1**; `(2R − ρ)² + 3R²` is the same polynomial |
| `T_m ∖ D` against its colour's hexagon at the norm-3 site (distance `3R`) | min | `4R² + 2Rρ + ρ²` — the hexagon's vertex at `2R` from `O` to the arc end at 120° from it | **pair 2**; `(ρ + R)² + 3R²` is the same |
| against the norm-4 hexagon | min | `27R²/4` for `t ≤ 1/2`, `(ρ − R/2)² + 27R²/4` for `t ≥ 1/2` | minus pair 2: `(11R² − 8Rρ − 4ρ²)/4 > 0`, resp. `3R(R − ρ) > 0` |
| against every hexagon of its colour at norm ≥ 7 | min | `≥ 3R` (triangle bound, exact constants 3, √12, 4, √19, … at `R = 1`) | `> √7R >` pair 2 |
| hexagon–hexagon, triangle–triangle (L7) | min | `7R²`, `13R²` | minus pair 2: `(R − ρ)(3R + ρ) > 0`, `9R² − 2Rρ − ρ² > 0` |
| a hexagon with itself | max | `4R²` | `< ` pair 1 since `3R² − 4Rρ + ρ² = (3R − ρ)(R − ρ) > 0` |

So **for every `0 < ρ < R` and `ε > 0`, HX is band-proper (in D-MU's null sense) iff `7R² − 4Rρ + ρ² ≤ (1 − ε)²` and `4R² + 2Rρ + ρ² ≥ (1 + ε)²`**:
every other class is implied. For `ρ ≥ √3R/2` the void also cuts the triangles' bases and the hexagons' near edges; the pieces only shrink and the
two extremes are still attained at the arc ends, so the statement holds on the whole range. W's form `ρ > max(2R − √((1−ε)² − 3R²), √((1+ε)² −
3R²) − R)` is the same pair of conditions, strict where D-MU's null form allows equality (a null set of pairs). **W's parenthesis ("the design's
other pairs, checked at members") is stronger than needed: the other pairs are implied for every parameter.**

**The stall.** Dividing by `R²`: pair 2 − pair 1 `= 6t − 3`, and band-properness needs pair 1 `≤ (1−ε)² < (1+ε)² ≤` pair 2, so `t > 1/2`
strictly for every `ε > 0`; conversely for every `t > 1/2` some `ε > 0` and `R` work (the two conditions leave an interval of `R` once
`(4 + 2t + t²)/(7 − 4t + t²) > ((1+ε)/(1−ε))²`). Hence `inf δ = (2π/(21√3))/4 = π/(42√3) = 0.043186…`, approached as `ε → 0` at `t = 1/2`,
`R = 2/√21` (where both conditions are equalities at `ε = 0`), **attained at no member**. HX has no driving parameter (W's killing test 4 fails,
as W's statement says); it passes the floor (0.0432 ≫ `ε²/78`) and class density (`1/6 − δ/6 < 0.2470`).

### 2a.3 Exact checks of members (`tools/fs107_vw_hx_check.py`, output `data/fs107/fs107-vw/hx_check.out`, 15 s)

Continuous design, exact in ℚ(√3), every same-colour piece pair within reach over L7, all six colours:

| member `(R, ε)` | binding (formula) | faithful `ρ` | result | planted `ρ` (just below) | result |
|---|---|---|---|---|---|
| `(873/2000, 1/100)` | pair 1 | `117/500` | 0 violations, `δ = 0.049644`, tightest = pair 1 (margin 9.2e-5) | `2337/10000` | 6 violations, all pair 1 (piece self-pair max 0.990102) — fires for its own reason |
| `(9/20, 1/100)` | pair 1 | `2897/10000` | 0, `δ = 0.071593`, tightest pair 1 | `1447/5000` | 6, pair 1 |
| `(21/50, 1/100)` | pair 2 | `351/1250` | 0, `δ = 0.077214`, tightest pair 2 (norm-3 hexagon) | `561/2000` | 12, all pair 2 (min 1.009901 < 1.01) |
| `(1091/2500, 1/1000)` | pair 2 | `11/50` | 0, `δ = 0.043901`, tightest pair 2 then pair 1 | `2197/10000` | 12, pair 2 |

Geometry plants on the first member: a triangle given to the wrong neighbour (18 violations), the void removed (18 violations) — both fire.
Known positive (unrasterised): the hexagonal 7-colouring with colour 0 blank at `R = 11/25`, `ε = 1/50` passes (margins 0.10 diameter, 0.145 same
colour); plants `R = 51/100` (diameter) and `R = 37/100` (same-colour distance) fire.

**Grid-square form** (`tools/fs107_vw_grid_check.py`, output `data/fs107/fs107-vw/grid_check.out`, 5 s): a periodic colouring by half-open
squares of side `h = 1/100`, period lattice `L7` rounded to the grid (so also `Dℤ²`-periodic), squares coloured by their centres; the check
classifies every index offset exactly in ℚ (W's killing test 1) and compares colours exactly. The rasterised known positive passes with blank
density `2513/17655 = 0.142339` (`1/7` only up to rasterisation, as noted in stage 1); a rasterised HX member (`R = 0.4365`, `ρ = 0.30`,
`ε = 1/100`) passes with blank density `1414/17287 = 0.081796` (continuous value 0.0816). One planted square in each fires at the plant (1,322 and
900 violations); the unplanted colouring is its faithful stub.

**Verdict material for HX-STALL:** TRUE, and stronger than stated (the "iff" holds for every parameter, the other pairs being implied). Two
nits: the strict inequality (the null band condition allows equality), and "stop at … at `R = 2/√21`, `ρ = R/2`" is an infimum approached as
`ε → 0`, attained by no member.

## Stage 2b — SAVED: the four hand statements, derived before reading W

### 2b.1 W-EQ-K (compactness at bounded complexity)

**⟸.** Let a full a.e.-proper six-colouring be given by closed tiles with connected interiors. For two tiles `T, T′` of one colour (possibly
`T = T′`), `{|x − y| : x ∈ T°, y ∈ T′°}` is connected (image of a connected set) and misses 1 (a unit pair between open sets carries positive
`Leb ⊗ σ` measure), so on closures it is `⊆ [0, 1]` or `⊆ [1, ∞)`. Erode by `r`: `T_r = {x : B̄(x, r) ⊆ T}`. For `x ∈ T_r`, `y ∈ T′_r`, `d = |x − y|`,
`u = (x − y)/d`: the points `x ± ru ∈ T`, `y ∓ ru ∈ T′` are at distance `d + 2r` and `|d − 2r|`, so `d ≤ 1 − 2r` in the first case and `d ≥ 1 + 2r`
in the second (if `d < 2r` the two balls meet, giving distance 0 in the second case, impossible). **So the eroded colouring is band-proper at every
`ε < 2r`.** Holes `⊆ N_r(∪∂T)`; a circular arc (or segment) of length `ℓ` has `|N_r| ≤ 2rℓ + πr²`, and arcs of tiles of diameter `≤ 1` have
length `≤ π`. Under reading **(Cu)** (`≤ K` arcs meet each unit disc) the hole density is `≤ C·K·r`: **`δ(ε) = O(ε)` with constant `O(K)`** ✓.
Correction: `T_r`'s boundary is the inner parallels of `T`'s arcs plus one arc of radius `r` at each reflex corner, so the eroded designs have
complexity `≤ 2K`, not `≤ K` (exactly `K` for convex tiles). Tightness is not used.

**⟹ under (Cu).** Designs `D_n` of complexity `≤ K`, slack `ε_n → 0`, hole upper density `δ_n → 0`. (1) *Recentre:* the weighted hole proportion
`Σ_M 2^{−M}|H_n ∩ B(x, M)|/|B_M|` averages to `≤ δ_n + o(1)` over large boxes, so some `x_n` has `|H_n ∩ B(x_n, M)| ≤ 2^{M+1}δ_n|B_M|` for every
`M`; translate `x_n` to 0. (2) *Compactness:* each `B(0, M)` meets `≤ C K M²` arcs of bounded length; circular arcs and segments in a compact region
have Hausdorff limits among arcs, segments, circles and points (three points determine an arc); diagonalise over `M`. The limit set `Γ` is locally a
finite union of arcs, so null, with finitely many complementary faces per bounded region. (3) *Colours:* a compact connected `K ⊂ U`, `U` a face of
`ℝ² ∖ Γ`, eventually misses `Γ_n` and so lies in one face of `D_n` (a tile of some colour, or a hole); along a further subsequence each face has a
constant status, and "hole" is impossible for a face of positive area by (1). (4) *a.e.-proper:* compact `K ⊂ U`, `K′ ⊂ U′` of one colour lie
eventually in same-colour tiles at slack `ε_n`, so `|x − y| ≠ 1` on `K × K′`; every pair of `U × U′` lies in such a `K × K′`. (5) *Complexity:* a limit
arc meeting an open unit disc is a limit of arcs meeting it, so `≤ K` (coinciding limits only lower the count). **So ⟹ holds under (Cu).**
"Tight" in the conclusion is automatic given `[Voronov2023]` Thm 1.3 (FS106-AE-SLACK) and unused otherwise.

**⟹ under (Ct)** (`≤ K` arcs per tile, no count per unit area): half-open grid squares have 4 arcs each, so "(Ct)-designs with `ε_n, δ_n → 0` exist"
is W's claim itself (H-EQ), and ⟹ would turn `µ₆⁰ = 1` into a colouring by tiles of `≤ 4` arcs — a regularity theorem no compactness gives (the
limit of ever-smaller tiles is a weak-* limit, row 131). **GAP at the compactness step under (Ct).** So the statement needs (Cu).

**Periodicity.** If W's "designs" must be periodic, ⟸ needs a periodic tight colouring, or H-EQ's periodisation, which does not keep complexity
bounded. Reading-dependent; W's record decides.

### 2b.2 W-RATE

- **`O(ε)`**: TRUE for a full tight colouring by tiles of complexity `≤ K` (2b.1 ⟸). **For a bare "full tight colouring" it is MISSTATED**: a
  measurable (CP) six-colouring with no boundary regularity has no erosion bound. The needed hypothesis is finite boundary length (Minkowski
  content) per unit area.
- **`O(ε²)`**: fix the reading. *Contact*: a same-colour tile pair with `sup = 1` or `inf = 1`, at points `(x₀, y₀)`, `|x₀ − y₀| = 1`. *Transversal*:
  `||x − y| − 1| ≥ c(|x − x₀| + |y − y₀|)` near the contact. *Isolated*: uniformly finitely many per unit area, with a uniform gap `η` from 1
  elsewhere. Remove `B(x₀, ε/c)` from `T` (one disc per contact suffices). Remaining pairs near the contact deviate by `≥ ε`; pairs away from every
  contact deviate by `≥ η > ε`. Holes: `π(ε/c)²` per contact, **`O(ε²)` per unit area**: TRUE under this reading. Transversality holds at a min-type
  contact when the tangent cones at `x₀` and `y₀` lie strictly inside the facing half-planes. It fails at a smooth boundary point (`|x − y| − 1`
  quadratic along the tangent): pinholes then need area `ε^{3/2}`, and arcs of contacts need `≍ ε` per unit length. "The floor's order": the floor
  `ε²/(6+ε)²` (given V-1.3) is `Θ(ε²)` ✓.
- **"R's pinhole test is the test against these"** is a reading, not a theorem. Note that W-RATE's pinholes sit at **contacts** (same-colour unit
  pairs), where killing test 5 puts its discs "at each junction or at each of the argument's certificates". The two coincide only if contacts count
  as certificates.

### 2b.3 W-POLY

Negate: some `K` admits polygonal designs with `δ_n → 0` at slacks `ε_n`. Replace `ε_n` by `min(ε_n, 1/n)`: slack is monotone, and
`[1 − ε′, 1 + ε′] ⊆ [1 − ε, 1 + ε]`. 2b.1's ⟹ under (Cu) with segments: limits of segments are segments or points. It gives a full a.e.-proper
six-colouring by polygons, `≤ K` segments per unit disc. Face closures have diameter `≤ 1`. Clean up to a map-type polygonal colouring (Conditions
2–4, 8): merge same-colour faces across shared edges, delete degree-2 vertices. FS106-AE-POLY excludes this except in its `d = 2` edge case. So
**`δ₀(K) > 0`, uniformly in `ε`, bar `d = 2`: TRUE**, over AE-POLY (two minds, one blind; SV-L3 a sketch) and 2b.1 ⟹ (Cu). Under (Ct) it inherits
2b.1's GAP. Non-simply-connected faces are covered by AE-POLY's fill step.

### 2b.4 W-TAN

C-T-TAN (`plans/FS106-TS-derivation.md` l. 258, one mind) excludes `|P(u)| = |P(v)| = 3`, disjoint, `|u − v| < 2`, whenever for some `w₀` both slice
supports `T_u, T_v` have positive length along strong blow-ups. For cone blow-ups the failures are an interface at `u` (or `v`) tangent to the unit
circle about `w₀`, or a bowtie. Beyond cones it also fails at cusps and at weak-* blow-ups.

- **First clause.** Suppose the map's boundaries are C¹ arcs with tangent directions at the vertices (circular arcs, W-EQ-K's limits). Then every
  blow-up is a cone: strong, along every sequence. With types read as essential multicolours (Te), "complementary-type vertices at distance `< 2`"
  is exactly C-T-TAN's hypothesis (K-C6: disjoint three-sets are complementary). Both `w₀` must be blocked, so each is a tangency at `u` or `v`, or
  a bowtie. **TRUE over C-T-TAN.** Two cases are not covered:
  - **(Tm)** types (the colours of the tiles whose closure contains the vertex) at a vertex with a **cusp** tile: its colour has density 0 there,
    so `|P(u)| = 2` and C-T-TAN is silent. **GAP.**
  - **general Jordan boundaries** (S–V's map type): spiralling or oscillating boundaries give non-cone or weak-* blow-ups, which is C-T-TAN's
    exceptional set and AE-Q2's [G2]. **GAP.**
- **Second clause.** Two vertices of adjacent tiles are within `|v − z| + |z − w| ≤ 2` of each other, `z` a shared point. Equality (both
  diameters 1, collinear) is outside the first clause's `< 2` — AE-POLY's `d = 2` shape again. Three-element types then pairwise intersect.
  A type of size `≥ 4` meets every three-set. **But a bichromatic vertex of degree `≥ 4` has a two-element type**, e.g. `{1, 2}`. It can be
  disjoint from a three-set `{3, 4, 5}` or a four-set `{3, 4, 5, 6}` without either being a complementary three-set, and C-T-TAN says nothing
  about such pairs. These vertices are live: row 132 names them as where hole-filling fails. **MISSTATED as "an intersecting family" of all
  vertex types.** The corrected statement: off tangent pairs, bowties and the collinear distance-2 configuration, the three-element (and larger)
  vertex types of two adjacent tiles pairwise intersect. For a trivalent map (Condition 7) every type has three elements, and the stated form holds
  bar `d = 2`.
- The domain (full tight six-colourings by curved locally finite maps) is not known to be non-empty. It is the open question (K-REG), so these
  are statements about a possible object, not vacuous ones.

### 2b.5 Would have searched here

- The HX optimum: I would have swept `(R, ρ, ε)` numerically. Instead I derived it: pair 2 − pair 1 `= 6t − 3` (2a.2).
- Cusp counterexamples to W-TAN's first clause under (Tm): I would have searched for a local cusp configuration. Instead I named the step
  C-T-TAN does not cover, and derived no counterexample (GAP, not FALSE).
- A better absorption than HX (a smaller stall): not my job. I searched nothing.

## Stage 3 — SAVED: verdicts (written before opening W's record)

| statement | verdict | minds (mine) | grade | the step or correction |
|---|---|---|---|---|
| **W-EQ-K** | **TRUE under reading (Cu)** (at most `K` arcs meet each unit disc; arcs circular or straight), with two corrections: ⟸ gives complexity `≤ 2K` (reflex corners add one arc each; `K` for convex tiles), and "tight" is automatic given V-1.3 and unused otherwise. **GAP under (Ct)** (per-tile count) at the compactness step, which there would be a regularity theorem for W's own claim | 1, blind to W | [hand] | §2b.1 |
| **W-RATE** | **TRUE with its hypotheses made explicit**: `O(ε)` for tiles of bounded complexity (finite boundary length per unit area); `O(ε²)` for uniformly isolated, linearly transversal contacts. **MISSTATED as "a full tight colouring"** with no boundary regularity. The pinhole-test clause is a reading, and its pinholes sit at contacts, not junctions | 1 | [hand]; the last clause [reading] | §2b.2 |
| **W-POLY** | **TRUE** over FS106-AE-POLY (bar `d = 2`) and W-EQ-K ⟹ under (Cu); GAP under (Ct) | 1 | [hand], over AE-POLY (two minds, one blind; SV-L3 a sketch) | §2b.3 |
| **HX-STALL** | **TRUE, and stronger than stated**: the "iff" holds for every parameter, not only at checked members, because every other same-colour class is implied by pair 2. Two nits: the null band condition allows equality where W writes `>`; and `δ*_HX` is an infimum approached as `ε → 0` at `R = 2/√21`, `ρ = R/2`, attained by no member | 1, plus exact checks of four members with plants and faithful stubs, and a rasterised member | [hand + tools, exact] | §2a |
| **W-TAN** | **First clause TRUE over C-T-TAN** for maps with C¹ arcs having tangents at the vertices, types read as essential multicolours; **GAP** for types read as closure multicolours at **cusp** vertices, and for general Jordan-boundary maps (non-cone and weak-* blow-ups). **Second clause MISSTATED**: two-element types (bichromatic vertices of degree `≥ 4`) can be disjoint from three- or four-element types without C-T-TAN saying anything, and the collinear distance-2 configuration is excluded. Corrected statement: VW-TAN | 1 | [derived], over C-T-TAN (one mind) | §2b.4 |

**Registered expectations scored (§1.3).** HX-STALL: expected the named pairs to bind and the value to hold (P 0.8). **Met**, and more: no third
pair binds anywhere; the norm-4 hexagon, which I flagged as the risk, is always slack by `3R(R − ρ)`. W-EQ-K: TRUE under (Cu), GAP under (Ct)
(P 0.6), **met**. W-RATE: TRUE with explicit hypotheses, MISSTATED bare (P 0.7), **met**. W-POLY (P 0.7): **met**. W-TAN: GAP at cusps or
two-colour vertices (P 0.5), **met on both halves**, plus the Jordan-boundary gap I had not registered.

**Audit of the TRUEs at a FALSE's rate** (standing rule 4). The flattering result for W is HX's "iff for every parameter". I re-derived each class
symbolically and checked it against the exact checker at five values of `t`. The norm-3 class equals pair 2 exactly at all five. The diameter claim
holds symbolically over every hull pair. The stall uses only pair 1 and pair 2, both confirmed by planted members that fail for exactly that pair.
None of the TRUEs moves the answer: HX stalls at 0.0432, and W-EQ-K/W-POLY are compactness around held theorems.

## Stage 4 — SAVED: W's record read (after stage 3's commit `ef9e955a`); divergences

**Quotation check, deferred from stage 1.** All five statements in the instance block match W's table
(`plans/FS107-W-near-colourings.md` ll. 10–20) verbatim. The instance block's HX-STALL grade omits W's "prediction P-W3 won", which abbreviates
it and does not change it.

**W's given members, re-checked with my own reader and checker** (`tools/fs107_vw_member_check.py`; output
`data/fs107/fs107-vw/members_check.out`, 11 s). My checker uses only the member files' data: its own Hermite reduction, strict and closed band
forms, and its own exact slack. **All six agree with W's reports:**

| member | W | mine |
|---|---|---|
| hex7 − one class, `h = 1/40` | ACCEPT, slack `1 − √1322/40`, `δ = 1/7` | ACCEPT, `1 − h√1322`, `1/7` |
| HX `ρ = .30`, `h = 1/80` | ACCEPT, `h√6964 − 1`, `451/5460` | same |
| HX `ρ = .28` | ACCEPT, 0.0259, `14/195` | same (`h√6736 − 1`) |
| HX `ρ = .26` | ACCEPT, 0.0165, `49/780` | same (`h√6613 − 1`) |
| HX `ρ = .24` | REJECT at `1/100`, slack 0.0007, `29/546` | same (`h√6409 − 1`) |
| HX58 `ρ = .16` | REJECT | REJECT (464 offsets) |

**Divergences of truth**

1. **HX-STALL — none in truth; mine is stronger.** W checked "the design's other pairs … at members"; §2a.2 derives them for every parameter:
   pair 2 implies all of them. W's route went through two lost predictions (P-W1: a first-order estimate; P-W2: the collinear corner instead of
   the 120° one, with an interim stall of 0.0243 in W §3.1). Its final pairs (a) and (b′) are exactly my pair 1 and pair 2. The nit stands:
   D-MU's null form allows equality where W writes `>`.
2. **W-EQ-K ⟸ — two small steps W does not write, both closable:**
   - W's ⟸ proof ends in a rasterised grid family, whose complexity is unbounded. The iff's left side is designs in `𝓜_K`, W's class: `≤ K`
     arcs per tile, radius `≥ 1/K`, `≤ K` tiles per unit disc, periodic. Erosion leaves `𝓜_K` in two ways: reflex corners get arcs of radius
     `κ → 0`, and convex arcs lose `κ` of radius. Cutting reflex corners by chords (inside the eroded set, so still band-proper) and taking
     `K′ = 2K` restores a bounded class. **⟸ holds at complexity `O(K)`, not `K`.**
   - The limit `M` of ⟹ need not be periodic, while `𝓜_K`'s designs are. Periodise by cutting a box of side `L` and removing a strip of width
     `1 + ε` along its boundary: every cross-seam pair is then `> 1 + ε` apart, at cost `O(1/L)`. With `L ≥ 1/ε`, `δ(ε) = O(ε)` survives.
   - ⟹ under W's `𝓜_K` agrees with my (Cu) derivation. Different route: W converges tiles in a compact parameter space and recentres by TQ §3.3's
     maximal inequality; I converge arcs and faces and recentre by a weighted average. **Verdict unchanged: TRUE at W's reading with ⟸ at
     `O(K)`.** My (Ct) GAP does not bear on W, whose class bounds tiles per unit disc.
3. **W-RATE — my MISSTATED is against the table line only.** W §2.4 opens "Let `M` be a full tight colouring as in 2.2" (bounded complexity), so
   the hypothesis I asked for is W's. The table line should carry it. W's tangent contacts (`O(ε^{3/2})`) and tight curves (`O(ε·length)`) agree
   with my §2b.2. **TRUE**, the pinhole clause a reading.
4. **W-TAN — one gap stands against W's own text.** W §2.5: "For a map every vertex is a cone point (strong blow-ups hold)". That is true for
   `𝓜_K` tiles. But **a cusp is a cone point whose tile has angle 0**:
   - its colour has density 0 at the vertex, so a vertex with three colours in the closure has `|P(u)| = 2`, and C-T-TAN does not apply;
   - the cusp colour escapes C-T-TAN's pigeonhole at `w₀`, which needs "all six classes in `P(u) ∪ P(v)`";
   - a cusp constrains that colour near `w₀` only on one side of a slab.
   **GAP at cusp vertices** unless "type" is the essential multicolour. W's second clause includes the `d = 2` caveat, and its "one triple from
   each complementary pair" reads types as triples, so my distance-2 point is W's too. The two-element types remain: bichromatic vertices of
   degree `≥ 4`, whose types need not meet a three- or four-set. W's "intersecting family" assumes every vertex is trichromatic, which holds for
   trivalent maps. The general-Jordan-boundary gap does not bear on W's scope (`𝓜_K`); it bears only on the table's "locally finite map".
5. **W-POLY, W-HEX — agree.** W's exact `1/7` comes from a coset rasterisation; mine, by centres, gave `2513/17655`. Both are band-proper, and
   the owner's "uncovered density `1/7`" is exact for W's construction.

**Divergences of route only:** W's checker uses closed squares and integer arithmetic; mine uses half-open squares, Fractions and a Hermite
torus. I added a continuous-design checker in ℚ(√3), which W did not have, and derived HX symbolically where W located pairs from checker
diagnostics.

**Proposed for the close (I edit none of these):**
- In W's table: W-RATE and W-TAN carry "as in W-EQ-K (`𝓜_K`)".
- W-TAN is restricted to trichromatic vertices with no cusp tile, off `d = 2`.
- W-EQ-K reads "⟸ at complexity `O(K)`, periodised by a seam strip".
- HX-STALL's parenthesis becomes "every other pair implied (FS107-VW §2a.2)", and its grade becomes two minds, one blind, with exact checks by
  two independent checkers.
- W-TAN at cusp vertices is a named step for W's door-(A) stub (i).
