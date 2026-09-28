# FS-114 — the global step: can a six-map with unit arcs have a vertex of four colours or a repeated colour within 3 of every point? (stub)

*Minted 2026-09-27 by the close planner FS112-C at FS-112's close, on Kooshi's ruling (`plans/FS112-close-inventory.md` item 59: *"When round 3
finishes, let's close this milestone, and point two milestones at the two gaps, so we can focus on them specifically. They seem to require more
research and careful exploration, and may be more complicated than they appear."*), rank 1, above FS-111; its sibling is FS-115, the stuck ray
(`plans/STUB-stuck-ray.md`). **Solver column: in-ban** — derivation, reading, and exact checks of objects given by formula; after 2026-10-01 still no
finite-witness search (Kooshi: *"search for a finite graph is out. It would be huge, not feasible."*). Written for a session with no memory of
FS-112: read `CLAUDE.md` § The aim and § Counter-priors first, then `LEDGER.md` rows 131–136, `plans/FS112-derivation.md` (§§1–4 in full),
`plans/FS112-unit-arc-half.md` §R-close, and `data/fs112/fs112-c/reconciliation.md` §§1.5–1.6 and 1.8–1.9.*

**Provisional bearings** (WORKFLOW 3.1 replaces them at the opening): G83 if minted at FS-112's close (four-colour vertices), G82, G79, G72, G13,
G15, G21, G22, G24 and G60 (no argument one class at a time), G46, G49, G50, G51, G17; rows 131–136; stubs FS-115, FS-111.

## The question, in plain language

Colour the plane with six colours so that no two points of one colour are exactly one unit apart. Hadwiger–Nelson asks whether that is possible.
This project has reduced the answer, at bounded complexity and with no measure-rigidity hypothesis, to a question about **maps**: finitely many tiles
per unit disc, each bounded by straight segments and circular arcs, six colours, and no two interior points of one colour at distance exactly 1 —
a **valid map** (`LEDGER.md` row 133, W-EQ-K: vanishing holes at bounded complexity exist iff such a map exists). Row 134 proved that no valid map
exists if no boundary arc has radius exactly 1. FS-112 took the case with **unit arcs** — boundary arcs of radius 1, the "unit-radius tactic" of
`[Polymath2021]` p. 194 — and did not decide it. It proved (row 135, two minds, one blind) that **every valid map has, within distance 3 of every
point, a vertex where at least four colours meet or a vertex where one colour appears in two separate sectors** (FS112-N3-DENSE3). So:

> **The global step.** Is there a valid six-map with unit arcs — equivalently, since every valid map has the property, one in which a vertex of at
> least four colours or a repeated colour lies within 3 of every point? **Exclude it** (the NO), or **build one** (the YES).

The global step in this form **is the NO itself**, for every valid map, periodic or not, with no step about stuck rays (FS112-C-COMPOSE, one mind).
What FS-112 adds is the property every counterexample carries, to be used (G79's example invariant). In its **four-colour form** — "no valid map whose
vertices of at least four colours come within `R` of every point" — it suffices for **doubly periodic** maps alone (every point of a periodic map's
terminal modification is within `|K| + 2` of a four-colour vertex, `K` its finite set of arc curvatures); for aperiodic maps that form needs FS-115's
two steps beside it (no stuck ray; finite stuck chains of bounded length). Choosing the form is the milestone's first decision.

## Bearing on the answer

**Decisive both ways at bounded complexity.** A NO answers `[SokolovVoronov2025]` Question 2 ("Is it true that 7 colors are needed …?") **yes** for
its unit-arc half, almost everywhere, for locally finite segment-and-arc maps, answers `[Polymath2021]` p. 199's hope ("to strengthen the seminal result
of Thomassen", eliminating "(ii) the unit-radius tactic") for such tilings, and closes door (A) of row 133; with FS-111's door (B) it gives
`χ_m⁰(ℝ²) = 7`, and `χ(ℝ²) = 7` given MR (rows 128, 131). A YES gives `χ(ℝ²) ≤ 6` with no MR (row 131's periodic form through W-EQ-K; a YES with five
colours would be `χ(ℝ²) ≤ 5`, a different outcome). A NO for doubly periodic maps only is a result, not the question: W-EQ-K's limit objects need not
be periodic — but it kills every YES given by formula.

## What FS-112 established about the object (addresses in `plans/FS112-derivation.md`)

- **Every unit arc reduces to one kind.** Every valid map has a valid modification, creating no unit arc, in which every unit arc is **(Q)** — centred
  at a vertex of at least four colours that carries both of the arc's side colours (Polymath's tactic at a vertex of degree at least 4) — or **(R2)**,
  an arc whose inner colour runs along the radius-2 circle about its centre (FS112-N2-RED, two minds, one blind). The centre's wedges: the inner side
  colour faces the arc, the outer faces away, the side cones hold neither (FS112-U1). A unit arc is shorter than 60° (FS112-L60).
- **Every four-colour vertex is tied to unit arcs** (FS112-NB4P, three minds): either unit arcs centred at it (at least 60° or six of them when its
  ring has no covering pair, FS112-A4SIX) or an arc through a point of a covering pair's orbit on its unit circle. Five colours force at least 180° of
  arcs centred at the vertex; six force its whole unit circle into the boundary (FS112-SIX).
- **The base still works away from four-colour and repeated-colour vertices** (FS112-N3-BASE, two minds, one blind): row 134's base (S–V Cor. 1, made
  curved and almost everywhere) refutes a valid map near any cubic trichromatic vertex whose closed disc of radius 2 holds neither. **Its residue, shared
  by both walks and unre-derived at FS-112: S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE, at row 134's grade** — a common error would
  sit there, and a second derivation of those steps is owed before anything final rests on them.
- **Close complementary pairs are rhombi with four-colour corners** (FS112-N3-COR3, two minds, one blind): two cubic trichromatic vertices with
  disjoint colour sets at distance below 2 sit on a unit rhombus whose other two corners are vertices of at least four colours, each the centre of unit
  arcs leaving both — FS-110's seam T2, forced. So a cubic trichromatic vertex has at most three such partners, at the rhombus completions of its
  leaving centres (FS112-C-PARTNERS, one mind: the close, over N3-COR3 and Y3's count).
- **The composition** (FS112-C-COMPOSE, one mind): the repeated-colour vertices of a terminal map that are far from four-colour vertices lie on
  **stuck chains** — degree-4 vertices at unit spacing along a line (FS112-N2-TERM) — and the point one step beyond each finite end of a chain has at
  least four colours (FS112-C-ENDS, one mind; at a single vertex bounded by unit arcs on both sides — FS112-BOWTIE's kind — through FS112-C-DOUBLE, one
  mind, with one residue named in FS-115's stub). No line of this stub rests on FS112-Y3-END-NEEDS. Trading repeated colours for four colours is FS-115's
  business.

## The held objects, and where each stops

- **The strip** (`[AxenovichEtAl2014]` Thm 4.2, height `√15/2 + √3` ≈ 3.668): three independent exact rebuilds, three checkers
  (FS112-CAL-STRIP). Every unit arc is (Q): four arcs centred at each midline vertex, a four-colour vertex whose whole unit circle lies inside the
  strip. It stops at the edge vertex `Q = (1/4, H/2)`, the second common unit point of the complementary pair valley `{1,3,5}`, apex `{2,4,6}` at
  distance ≈ 0.757, whose first common point is a four-colour midline vertex; the colourless cone at `Q` is `(arcsin ¼, 180° − arcsin ¼)`
  (FS112-EDGE). Twelve such pairs per period; the valley and apex sectors are forced by the midline quadrants (FS112-FORCE); cutting the top tiles
  along `ω(Q)` fails one ring further out (FS112-Y3-PIN, one mind).
- **The disk** (`[Polymath2021]` Fig. 10, radius `√((25 + 9√5)/10)` ≈ 2.124): two blind rebuilds, identical, two checkers (FS112-CAL-DISK). Its
  20 unit arcs are all (Q), four at each corner of a central Reuleaux pentagon. It stops at the ten rim points `C_k`, `D_k` (colourless cones of 108°,
  FS112-DISK-RIM), again the unsaved second common unit point of a complementary pair saved at a four-colour vertex (FS112-STOP). The tactic's own move
  at the rim corner frees a third colour and shrinks the cone to 36°, and stalls (FS112-MOVE); the next move fails at a named corner (FS112-Y3-PIN).
  No vertex-centred disc beyond `φ` fits in any valid extension, and `φ` is attained (FS112-DISC).
- **The law both obey** (FS112-STOP, two minds, one blind): they stop exactly where FS112-N3-COR3 says a valid map needs a second four-colour vertex.
  This is the milestone's meeting point: the proof side derived what every valid map carries at both corners; the construction side found both
  positives supply one corner and stop at the other.

## What is open, named

1. **The global step itself**, in the form chosen (DENSE3's, or the four-colour form with FS-115).
2. **C-LOCAL**: a NO whose every step reads a disc of explicit radius `R` (FS-112's steps read radius at most 3; none is a NO).
3. **The design principle for a YES** (Y3 §4.2, now a theorem by C-PARTNERS): every close complementary pair of trivalent vertices must be a rhombus
   completion of their unit-arc centres. Y3's first test, not run: on the disk's pentagon skeleton, can the trivalent `B_k` (two unit-arc boundaries,
   centres `A_k`, `A_{k+1}`) be given a third unit-arc boundary whose completions are exactly their complementary partners (`B_0`'s current partners
   `Z^R_0`, `Z^L_1` are not completions)? And the disk's blue and orange routes to a fourth colour at `C_0`, never analysed (Y3 §4.4 (ii)).
4. **A second derivation of row 134's base steps** that N3-BASE inherits (above), and second minds on FS112-C-ENDS (with its stage-1b repair),
   C-COMPOSE and C-PARTNERS.
5. **C-HOCK**: whether boundary arcs of radius below 1 can always be filled to radius 1 (Hockertz, `[Polymath16threads]` `[06.91]`, stated only). No held
   valid object has such an arc between two tiles, so it has no instance; the opposite direction (unit arcs bent off radius 1) is FS112-N2-RED.

## Reading (a reading room before a route; nothing below is chosen in advance)

**Disciplines whose methods bear.**
- *Planar map colouring and discharging.* The four-colour theorem's method — unavoidable configurations and a discharging count — is the classical
  tool for "every map has a configuration of a named kind within bounded distance". DENSE3 is an unavoidability statement already; FS112-A's hunch
  `h-discharging` (untested) proposes the count: each unit arc transfers angular budget between its centre and its ends, every trichromatic or
  four-colour vertex needs a positive net budget. Euler's formula for locally finite maps with tiles of diameter at most 1.
- *Convex geometry of diameter 1.* Reuleaux polygons, sets of constant width, ball polygons (spindle convexity; FS-110's PA-1 vocabulary): a
  four-colour vertex with its unit arcs is a Reuleaux structure, and the disk is a Reuleaux pentagon grown.
- *Tilings and their dual graphs.* Sirgedas's dual graph (`[Polymath16threads]` `[16.346]`: "In the dual graphs, they both have quads on the interior,
  and triangles on the exterior. Arrows in the dual graph correspond to curved edges in the tile graph. Each quad in the dual graph “emits” four
  arrows."; `[16.347]`: the strip "can’t be extended. A triangle can’t be added because all 6 colors are within two “steps” of the new vertex. A quad
  can’t be added because each new vertex will emit a conflicting arrow") — the quads are FS-112's (Q) centres and the "two steps" its rhombus. A
  candidate discrete form of the global step.
- *Measure and density.* Per-class density arguments stop below 4.37 colours (row 129; G24, G60): a NO must use how the classes fit together.

**Held papers whose methods bear:** `[SokolovVoronov2025]` (Cor. 1, Lemma 3, Props. 7–19, §9; the base); `[Woodall1973]` §3 (steps 2, 3, 5: degree
reduction); `[Thomassen1999]` (nice colourings: his proof reads no boundary colour; his hypothesis excludes the tactic); `[Townsend2005]`,
`[Coulson2004]` (maps need six); `[Voronov2023]`; `[Polymath2021]` pp. 190–201 (the strip, the disk, the tactic); `[Polymath16threads]` threads 6–9 and
16 (extracts `data/fs112/fs112-pa/extracts.md`: de Grey's tile rules `[08.45]`–`[08.65]`, Gibbs's constraint `[08.39]` and program, the six-colour
vertex sketch `[08.17]`–`[08.18]`); `[Parts2020c]` (optimised tilings, "vertices in which three or more colored tiles converge are disadvantageous").

**The prior-art gate's questions** (WORKFLOW 3.2, in the discipline's words):
1. **Sirgedas's near-proof that the plane cannot be six-tiled with a non-Siamese tiling** (`[Polymath16threads]` `[16.317]`, de Grey, 2020: "Tom
   Sirgedas got very close to such a proof a while back"). Siamese tiles are, in de Grey's words, "tiles that lie entirely within each other’s
   annulus of exclusion" (`[10.59]`); two tiles of one colour meeting at a vertex are Siamese, so in a non-Siamese tiling whose tiles are bounded by
   simple closed curves no vertex repeats a colour, and DENSE3 puts a four-colour vertex within 3 of every point: his argument is the global step's
   four-colour form, restricted to such tilings (a tile touching itself at a vertex is the other source of a repeated colour). **Unheld**, in the Google group
   `hadwiger-nelson-problem`; obtaining it is the gate's first debt (fetching from outside the project is Kooshi's call).
2. The slack form of FS112-N3-COR3 is in print (`[17.282]`, de Grey, 2022: no two trichromatic points sharing no colour less than 2 apart in a tiling
   avoiding `[1, d]`); search its citing and neighbouring comments for the tight form.
3. zbMATH: "discharging" with "unit distance" or "tiling"; "Reuleaux" with "colouring" and "plane"; "constant width" with "tiling"; the posers' full
   author listings in the question's vocabulary (Sirgedas, Gibbs, Hockertz, Parts, de Grey) — pre-2000 is not the issue here, blogs and groups are.
4. Hockertz's manuscript *Exclusion zones in infinite graphs* (dropbox, thread 6) and the Polymath16 wiki's tile-rule page (`[08.67]`): unheld.
5. The Geombinatorics issues after April 2021 (held, `~/source/library/geombinatorics/`) for any paper citing `[Polymath2021]`'s disk or strip.

## Registered expectations (instruments for G21, scored at the close; never caps — `CLAUDE.md` § Counter-priors, rule 2)

| expectation | p | both outcomes reachable |
|---|---|---|
| the global step decided (NO or YES) at one mind within FS-114 | 0.2 | a NO by derivation, or a valid map by formula checked exactly |
| a YES by formula | 0.03 | the checker and a formula; a NO by derivation |
| a NO for doubly periodic maps (the four-colour form), one mind | 0.3 | derivation, or a periodic valid map by formula |
| a discrete (dual-graph) form of the local structure at four-colour vertices, derived | 0.4 | derived, or shown to lose information a NO needs |
| a second mind confirms FS112-C-PARTNERS and FS112-C-ENDS | 0.8 | a counterexample configuration refutes either |
| a named obstruction or GAP as the product | 0.85 | — |

## Failure clauses

- A NO for doubly periodic maps only is a result, not the question (W-EQ-K's limits); a NO that uses the complexity bound where row 134's chain did not
  must say so; a NO at bounded `K` only answers Q-full_K, not Q-full.
- Killing test 8 of FS-112 stands: every NO route fails on the strip and the disk at a named step and says where the plane beyond them is spent; a route
  with no such step is refuted by the strip.
- The seven-colour control: an argument must fail on the hexagonal seven-colouring and name where six is spent.
- A YES candidate that fails the exact check measures the candidate; a family of formula candidates that all fail measures the family's image (state
  its free parameters against the configuration's).
- No argument one class at a time (row 129).

## Deliverables

The plan with §G, §PA and §IQ; `plans/FS114-derivation.md`; exact checks under `tools/fs114_*`; a verdict on the global step in the form chosen, with its
grade; second minds on C-ENDS, C-COMPOSE and C-PARTNERS; the prior-art gate's first debt (Sirgedas's argument) read or named as unobtainable; the
pentagon-skeleton design test, derived before anything is built.
