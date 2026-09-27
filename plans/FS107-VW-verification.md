# FS107-VW — blind verification of FS107-W's results

*Job FS107-VW (de Bruijn, Opus 5.5), 2026-09-27. Brief: `data/fs107/briefs/V107-blind-verifier.md` with the instance block
`data/fs107/briefs/V107-instance-W.md` and `data/fs107/briefs/STANDING-RULES.md`. Blind until stage 3 is committed: W's record, tools and data,
the other verifier's record, the advisors' records, the close inventory, the reports and git history beyond `git log -1` (`30fb4472` at start) are
unopened. Fence touches: none.*

## Theorems this phase proved

*(filled at stage 3)*

## Would have searched here

*(one line per move; filled as they come)*

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
