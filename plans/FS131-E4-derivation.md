# FS131-E4 — GAP-ELEVEN: the eleventh point of row 134's base with unit arcs

*Ephodos (derivation job FS131-E4), 2026-10-04. Brief: `data/fs131/briefs/FS131-E4-eleventh-point.md`; claim list `data/fs131/claims-E4.md`;
standing rules `plans/STANDING-RULES.md`. Nothing in this milestone is blind (inventory ruling 1). Lean text read on branch `fs131-w5b`
(worktree `.claude/worktrees/fs131-w5b`, head `49ed9cc4`).*

## Theorems this phase proved

*(filled as stages land; one line per theorem, its grade and its address)*

## Stage 1 — SAVED: the readback, the questions restated, the predictions

### 1.1 Quotations checked (standing rule 3), by script

| quotation | in | against | result |
|---|---|---|---|
| Q1–Q4 (four truncated block quotes) | the brief | `data/fs131/claims-E4.md` § The questions | verbatim (each a prefix, truncation marked by "—") |
| GAP-ELEVEN's first sentence | claim list | `.claude/worktrees/fs131-w5b/plans/FS131-w5base-kernel-plan.md` § 2.3 | verbatim |
| FS110-CD § 2.6 ("Let `R*` be the connected component …") | claim list | `plans/FS110-CD-verification.md` § 2.6 | verbatim |
| FS110-CD § 2.8 item 2 | claim list | `plans/FS110-CD-verification.md` § 2.8 | verbatim |
| FS112-N3-3's eleventh-point paragraph | claim list | `plans/FS112-N-proof.md` § Stage N3-3 | verbatim |
| FS110-CE E6's eleventh-point bullet | claim list | `plans/FS110-CE-verification.md` § E6 | verbatim |
| `Row134BaseUA`'s Lean text (lines 98–105) | claim list | `Plane/ValidMap/Chain.lean` on `fs131-w5b`, lines 98–105 | verbatim (the block opens mid-docstring at line 98, as its address says) |
| rows 134, 135, 137 | claim list | `LEDGER.md` | verbatim, all three |

No mismatch. The brief's quotations are true to the claim list, and the claim list's to its sources.

### 1.2 Read, in this order

`plans/FS112-N-proof.md` § Stage N3-3 (in full, l. 722–838); `plans/FS110-CD-verification.md` §§ 1.2–2.10 (in full); `plans/FS110-CB-verification.md`
§§ D1–D6 (in full); `plans/FS110-CE-verification.md` § E6; the planner's record `plans/FS131-w5base-kernel-plan.md` (branch) §§ 1–3; on the branch,
`Plane/ArcMap.lean` (the structure, `Valid`, `Covers`, `coloursAt`, tiles), `Plane/LocalMap.lean` (tiles, ring arcs), `Plane/ValidMap/Basic.lean`
(sectors, degree, repeated colour, cubic trichromatic, contacts, `Inert`), `Plane/ValidMap/Chain.lean` (`fourSet`, `repSet`, `BaseHyp`, `NoInertNear`,
`Row134BaseUA`), `Plane/ValidMap/BaseWalk.lean` (in full: `BaseCtx`, every leaf, `exists_eleventh`), `Plane/ValidMap/BaseDense.lean` (in full:
`row134BaseUA`, `n3_base`, `localDense`, `dense3`, `cv_exists`), `Plane/ValidMap/Dense.lean` (`not_row134BaseUA_seven`); the filed entries
FS110-CLOSURE, FS110-COR1-NOD2, FS110-CUSP-BASE (`plans/FS110-derivation.md`), FS112-N3-BASE, FS112-N3-DENSE3, FS112-DISC1 (`plans/FS112-derivation.md`),
NB2-DISC1's proof (`plans/FS112-NB2-verification.md` § 1.4 item 3), FS129-OR1-LOCALDENSE and FS129-OR1-DISCF-NS (`plans/FS129-derivation.md`),
FS114-CVB § 1.9 (B1–B2, the holed-tile fragment and the hole-filling repair of Thomassen's steps); first-hand in the held PDFs, `[Voronov2023]`
Observation 2.2 and Lemma 6.1 (`library/pdf/arXiv-2304.10163-voronov.pdf`, pp. 4, 12) and `[SokolovVoronov2025]`'s proof of Lemma 4, the last
paragraph (`library/pdf/arXiv-2502.01958-maptype.pdf`, pp. 27–28).

Two things the reading settled before any derivation:
- **The setting has no merging.** In an `ArcMap` a tile is a component of the interior points, and two tiles of one colour may be adjacent. Under
  `BaseHyp u` that cannot happen inside `B̄(u, 2)`: a point in the closure of two tiles of one colour, or of one tile twice, carries a repeated colour.
  So inside `B̄(u, 2)` tiles play the role the sources' merged regions play, and a tile, not a merged region, is what can be multiply connected.
- **The printed sentence and Voronov's proof.** S–V p. 28: *"It remains to notice that on the boundary of the union of three regions of colors 1, 2, 3
  whose vertex is u, there is at least one more trichromatic point (Fig. 6)."* Voronov's Lemma 6.1 proves it for *"a maximal region R colored in 1, 2, 3
  and containing u"*: *"Along the boundary of R there cannot be tiles of only one of the colors 1, 2, 3, because the monochromatic regions are
  1-connected."* Both colourings are of the whole plane, made 1-connected first by Observation 2.2 (recolour everything inside a region's outer boundary).
  So the printed step is a step about a plane colouring after a global modification, as the planner found.

### 1.3 The questions, restated in this record's words (the quoted text is the claim list's § The questions)

Setting throughout: `B : F.BaseCtx u` — a valid six-coloured fragment covering `B̄(u, 2)`, `u` cubic trichromatic with colours `C = P_cl(u)`,
`BaseHyp u`, `NoInertNear u`. `R*`: the component containing `u` of the union of the closures of the tiles of colours in `C`. `U∞`: the unbounded
component of `ℂ ∖ R*`. The step: `exists_eleventh` — a point `q ∈ B̄(u, 1)` with three colours, exactly two of them in `C`, whose tiles of those two
colours lie in `B(u, 1)`.
- **Q1** — can a tile of a colour of `u` enclose `u` inside `B(u, 1)` with `u`'s other tiles in its hole, under every hypothesis of `BaseCtx`? Exclude it,
  or exhibit it exactly.
- **Q2** — if it can, does the `10 + 1` count close in that case another way?
- **Q3** — if neither, which repair holds, at what cost to `localDense`, FS112-N3-DENSE3, FS114-CV-EXISTS and the rows; drafted statements.
- **Q4** — do rows 134, 135, 137, as their derivations prove them, rest on the base at a fixed `u` or on a hole-filled global form?

### 1.4 Registered predictions (G21), before the written derivation

Registered after the reading in § 1.2 and a first pass of thought, before any stage below was written. Each names the decision it governs.

| id | prediction | p | decides |
|---|---|---|---|
| E4-P1 | Q1's exclusion is derived in this job | 0.15 | whether any statement changes |
| E4-P2 | a configuration for Q1 is exhibited exactly in this job | 0.02 | whether rows 135 and 137 lose a step to a counterexample |
| E4-P3 | Q2's count closes by another route, derived | 0.10 | the same as E4-P1 |
| E4-P4 | a repair holds with `localDense`, `dense3` and `cv_exists` unchanged in statement (radius 3 kept), only `Row134BaseUA` and `n3_base` gaining a hypothesis | 0.80 | which Lean change goes to de Bruijn, and whether row 135's headline number changes |
| E4-P5 | row 134 rests on the hole-filled global form, rows 135 and 137 on the base at a fixed vertex (through FS112-N3-DENSE3) | 0.85 | which rows need correction text |

## Stage 1 — SAVED

## Stage 2 — SAVED: recognition (the opening play), on each claim

*`ephodos-recognition`, invoked fresh. The stall read first, then the stranger, the features with receipts, the homes, and what each claim is.*

### 2.1 The stall

Two dispatch shapes at once. **A known theorem that almost applies:** `[Voronov2023]` Lemma 6.1 proves the eleventh point, and one hypothesis fails as
the object is described — its regions are 1-connected (made so by Observation 2.2, a global recolouring), and a tile of a fragment need not be. **A wall
that describes a counterexample:** the planner's picture (a tile of a colour of `u` wrapped round `u`) is what a counterexample to the step must carry.
The stall is located exactly: the walk's paragraph "The eleventh point [hand, one mind]" (`plans/FS112-N-proof.md` l. 796–798) proves where `R` lies
(`R ⊂ B(u, 1)`, through NOBOTH) and never that the point exists; its table row "the eleventh point | `R` inside `γ(u)` | `R ⊂ B(u, 1)` by N-E1 | nowhere"
records the location step and is silent on existence.

### 2.2 For a stranger: a plane topologist

*Let `K ⊂ ℝ²` be a compact connected set that is the union of the closures of finitely many open, connected, pairwise disjoint sets ("tiles"), each
labelled with one of three labels, two tiles with a common closure point never sharing a label. Let `W` be the unbounded component of `ℝ² ∖ K`.
Must some point of the frontier of `W` lie in the closures of two tiles with different labels?*

Every word is the reader's. Struck as accompaniment by the translation: the six colours, the unit distance, the radius 2 of `BaseHyp`, unit arcs, the
pseudo-colouring of `ω(u)`. They enter the walk elsewhere; the existence of the point reads none of them. Kept as determiners, with their roles: "two
tiles with a common closure point never share a label" (in the base it is `BaseHyp`'s no-repeated-colour clause, read inside `B̄(u, 1)`); "`K` lies in
`B(u, 1)`" (Lemma H and NOBOTH, which make `q`'s tiles lie in `B(u, 1)`); and three colours at `q`, not four (`BaseHyp`'s four-colour clause).

**This is the frontier of a complementary domain of a plane continuum**, and the home theorem is classical: *the frontier of each component of the
complement of a continuum in the sphere is connected* (unicoherence of `S²`; Janiszewski; for a finite cell complex, the boundary of the outer face of a
connected plane graph is connected). Read in this form, not proved here; Mathlib holds no unicoherence or Janiszewski lemma (grep of
`.lake/packages/mathlib`, 2026-10-04: no hit for unicoherent, Janiszewski or a frontier-of-component lemma). With it the answer is: **yes, unless one tile's
closure contains the whole frontier of `W`**, and then every other tile of `K` lies in a bounded component of the complement of that tile's closure — that
tile encloses the rest.

### 2.3 The features, sorted (with receipts)

| feature | sort | receipt |
|---|---|---|
| every region 1-connected (Voronov's hypothesis) | **splits**: consumed only as "the frontier of `W` is not inside one tile's closure"; that consequence determines, the rest accompanies | Voronov's own sentence uses it once, for exactly this (`[Voronov2023]` p. 12, quoted in § 1.2); stage 3's E4-RIM runs with the split hypothesis alone |
| the split hypothesis, at `u`: no tile has a tile at `u` in a bounded component of the complement of its closure | **determines** | E4-RIM consumes it; without it the model below has no eleventh point (`fs131-e4-model`: `eleventh=0` with `encloses=True`) |
| validity (no unit pair of one colour) | **accompanies** the existence of enclosure; **determines** Lemma H (the location) | the model is valid because its domain has diameter `9/10 < 1`, and it encloses `u` |
| `BaseHyp` read inside a small disc about `u` | **accompanies** the existence of enclosure | the model has five vertices, all cubic trichromatic, no repeated colour, no four colours (`bad=0`) |
| `NoInertNear` read inside a small disc about `u` | **accompanies** | the model has no unit arc (its arcs have radius `1/10`, `3/10`, or are segments) |
| the types of the pigeonhole's points | **cannot** close the count without a tenth point in the nine endpoint classes | `fs131-e4-count`: nine endpoint types occupy nine distinct classes, none is `u`'s, each `q`-type's class holds exactly one endpoint type, and `u` with nine distinct endpoints is not forced to collide (`forced=False`) |
| where the endpoints lie, and how far apart same-type points of `B(u, 1)` are | **unsorted** for Q2 | no argument found consumes it to a collision (stage 4) |

### 2.4 What each claim is, recognized

- **Q1 is not a lemma about enclosure; it is the base itself at an enclosed `u`.** The small model satisfies every hypothesis of `BaseCtx` that reads
  only a disc of radius `0.34` about `u` (validity, cubic trichromatic `u`, no repeated colour, no four colours, no inert unit arc), with `u` enclosed and
  no eleventh point. So **no exclusion of enclosure reading only near `u` exists** — in particular neither of the two attacks the brief names: all
  distances inside the hole are below 1 in the model (a distance bound inside the hole is satisfied, not violated), and the enclosing tile's boundary
  carries no unit arc (`NoInertNear` read there is vacuous). Any exclusion must read the map out to `ω(u)` and beyond, where the only machinery is the
  base's. And since stage 3 proves the base at every un-enclosed `u` given the rest of the walk, "`BaseCtx` with `u` enclosed is impossible" is the same
  statement as "`BaseCtx` is impossible", i.e. `Row134BaseUA` given the walk's other leaves. The remaining step of Q1 is the problem renamed (the
  recognition's mirror test, run and passed honestly: it is a mirror). FS114-CVB § 1.9's annulus fragment is the same observation for holed tiles in general.
- **Q2 is the pigeonhole without its tenth point.** Types alone never collide (the count tool); a collision needs geometry: either a second point in one
  of the nine endpoint classes, or a same-type pair at a distance some lemma refutes. Candidate homes: the parity of the network of `C|C` arcs (handshake
  lemma), Voronov's hole-filling, a second base vertex. Stage 4 tests each.
- **Q3 is the split of Voronov's hypothesis.** The global argument consumes 1-connectedness only as "the base is run at a vertex no tile encloses". So the
  class is the un-enclosed vertices, and the repair is to say so in the statement and to choose such a vertex in the consumer: the maximal element of the
  laminar family of filled tiles containing a given point (stage 3). This is Observation 2.2 read locally: Voronov fills; we choose the outermost tile
  and stand on its rim, which needs no modification of the map and keeps `u`'s neighbourhood as it is.
- **Q4 is a dependency trace**: for each row, the vertex at which its derivation runs the base, and whether that vertex was chosen after a global
  hole-filling (row 134: CB D6, inside FS110-COR1-NOD2) or as an arbitrary vertex of a disc (rows 135, 137: FS112-N3-DENSE3's vertex from FS112-DISC1's
  nesting chain, which stops at the first branch point and is not the outermost tile).

control: fs131-e4-count
  of: E4-RIM — the recognition's sort: the pigeonhole's types alone never force a collision without a tenth point in the nine endpoint classes
  run: python3 ../tools/fs131_e4_count.py
  expect: classes=10 endpoint=9/9 ucls=False qcomp=[1] forced=False
  fault: python3 ../tools/fs131_e4_count.py --fault

control: fs131-e4-model
  of: E4-RIM — the recognition's sort: a valid fragment about u with u enclosed and every near-u hypothesis of BaseCtx holding has no eleventh point
  run: python3 ../tools/fs131_e4_enclosure_model.py
  expect: valid=True cubic_u=True vertices=5 bad=0 encloses=True eleventh=0
  fault: python3 ../tools/fs131_e4_enclosure_model.py --fault

## Stage 2 — SAVED

## Stage 3 — SAVED: the step at an un-enclosed vertex; the outermost tile; the base's consumers repaired at radius 3

*Words used below.* `Unenclosed v`: for every tile `T` and every tile `S` with `v ∈ cl S`, every point of `S ∖ cl T` lies in an unbounded component of
`ℂ ∖ cl T` (no tile has a tile at `v` in a hole). `UnenclosedC v`: the same with `T` ranging over tiles of colours carried at `v` only; `Unenclosed`
implies it. E4-RIM and E4-N3BASE-UN carry `UnenclosedC` (all their arguments read); E4-OUTERMOST delivers `Unenclosed`. For a tile `T` with bounded closure, `W_T` is the unbounded component of `ℂ ∖ cl T` and
`hull T = ℂ ∖ W_T`. A **bad point** is a point of `F(M) ∪ R(M)` (four or more colours, or a repeated colour). `BaseCtx F u` is the planner's bundle
(valid, covers `B̄(u, 2)`, `u` cubic trichromatic, `BaseHyp u`, `NoInertNear u`).

derivation: E4-RIM
  statement: in the base's context at u (BaseCtx F u), if no tile of a colour of u has a tile at u in a bounded component of the complement of its
    closure, then some point q of B̄(u, 1) carries exactly three colours, exactly two of them colours of u, and every tile of either of those two colours whose
    closure holds q lies in B(u, 1)
  uses only: validity (a tile of a colour of u meeting B(u, 1) lies in B(u, 1), Lemma H(a); no tile of a colour of u meets ω(u), N-E1); u cubic
    trichromatic; BaseHyp read inside B̄(u, 1) (no repeated colour, no four colours); no both-kind unit arc centred at u (N3-NOBOTH, which reads BaseHyp
    at u); local finiteness; the hypothesis, read only at u's three tiles against tiles of u's colours (so
    Unenclosed u, which reads every tile, implies it); the frontier of the unbounded complementary component
    of a plane continuum is connected (unicoherence of the plane, read, not proved here)
  not claimed: the converse — an enclosed u may still have such a point (in a hole of its component bordered by two of its colours, or on another
    component); that q lies in the open disc (it may lie on ω(u), where eleventh_antipodal applies); anything about NoInertNear, which is not used
  argument: § Argument for E4-RIM
  verdict: derived
  grade: hand
  minds: 1
  model: none expected for the whole context (BaseCtx is what row134BaseUA refutes); the topological core (steps 2–5) is modelled by the faulted
    enclosure model (tools/fs131_e4_enclosure_model.py --fault): a valid fragment about u = (1/10, 0) with u's enclosing tile cut open, in which two such
    points appear on the enclosing tile's rim
  prior art: partly — [Voronov2023] Lemma 6.1 (read 2026-10-04, p. 12) proves the point when every monochromatic region is 1-connected; the hypothesis
    split to "no tile encloses a tile at u" is not found in print (searched only in [SokolovVoronov2025] and [Voronov2023])
  handoff: de Bruijn — BaseCtx.exists_eleventh gains the hypothesis Unenclosed u; its proof is § Argument for E4-RIM, over one planar lemma (the outer
    frontier of a continuum is connected) that Mathlib does not hold

derivation: E4-OUTERMOST
  statement: in a valid fragment covering B̄(x, 1 + ρ) for some ρ > 0, either B̄(x, 1) holds a point of F(M) ∪ R(M), or B̄(x, 1) holds a cubic trichromatic
    vertex v with Unenclosed v
  uses only: validity (a tile has diameter at most 1); local finiteness (finitely many tiles meet B̄(x, 1), and near a point the tiles holding it in
    their closure are its sectors); the frontier of the unbounded complementary component of a plane continuum is connected; that three tiles of three
    distinct colours at a point with no repeated colour and no fourth colour make it cubic trichromatic (wave 5's isCubicTrichromatic_of_three_of_noRep)
  not claimed: that v is the vertex FS112-DISC1's nesting chain finds (that chain stops at the first branch point, and its vertex may be enclosed by a
    tile further out); anything about colour counts — the statement holds for every k
  argument: § Argument for E4-OUTERMOST
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring with hexagons of diameter just below 1 (any point x; T* the hexagon whose closure holds x, every hexagon its own
    hull; v a corner) — the statement is colour-free; and the unfaulted enclosure model with x = u = (1/10, 0): T* = R_4 (the annulus), v any of its three
    outer-rim vertices, where u itself is enclosed
  prior art: owed — in-house; its global relative is [Voronov2023] Observation 2.2 (fill every hole; read 2026-10-04, p. 4), which this replaces by a choice
  handoff: de Bruijn — a new lemma for localDense's proof (it replaces FS112-DISC1's vertex)

derivation: E4-BEND-UN
  statement: the toward-bend of a whole inert unit arc (FS112-N2-BENDS, N2-TOWARD), with its lens chosen inside a collar of the arc in its inner tile,
    keeps Unenclosed u, for u an end of the arc or off a neighbourhood of the lens
  uses only: that the bend is induced by a homeomorphism of the plane supported in a small neighbourhood of the lens's closure, fixing the arc's ends,
    carrying each old tile onto the new tile of the same index; that enclosure is invariant under homeomorphisms of the plane
  not claimed: that every bend N2-BENDS allows has its lens in a collar (a lens may be chosen so; the existing bend lemma is not re-read for it); the
    away-bend
  argument: § Argument for E4-BEND-UN
  verdict: derived
  grade: hand
  minds: 1
  model: the bend of any inert unit arc of a held fragment with unit arcs — FS112-BOWTIE's inert arcs, if any; none checked here
  prior art: owed — in-house
  handoff: de Bruijn — a child of n3_base's pre-bend (the planner already owes a strengthened-bend child keeping u cubic trichromatic; this clause joins it)

derivation: E4-N3BASE-UN
  statement: in a valid six-coloured fragment covering B̄(u, 2), a cubic trichromatic vertex u with no point of F(M) ∪ R(M) in B̄(u, 2) and no tile of a
    colour of u having a tile at u in a bounded component of the complement of its closure does not exist
  uses only: FS112-N3-BASE's walk at its filed grade with its eleventh-point step replaced by E4-RIM; the pre-bend of inert unit arcs centred in B̄(u, 1),
    with E4-BEND-UN keeping the new hypothesis
  not claimed: the same statement without the new hypothesis (FS112-N3-BASE as filed): at an enclosed u the step is open (stage 4, Q1 and Q2); that the
    walk's other steps are stronger than their grade (CUSP-BASE's D5 items 1–4 and 6 one mind)
  argument: § Argument for E4-N3BASE-UN
  verdict: derived
  grade: hand
  minds: 1
  model: none expected — a refutation; its seven-colour form is false at the seven-brick map's corner, whose tiles are rectangles (so Unenclosed holds),
    as not_row134BaseUA_seven already shows for the form without the hypothesis
  prior art: partly — S–V Cor. 1 ([SokolovVoronov2025]) is the global form; with unit arcs and at a fixed un-enclosed vertex, not found in print
  handoff: de Bruijn — Row134BaseUA and n3_base gain the hypothesis Unenclosed u (stage 5's drafts)

derivation: E4-LOCALDENSE
  statement: every valid six-coloured fragment on a closed disc B̄(x, 3) has, in B̄(x, 3), a vertex of at least four colours or a vertex with a repeated
    colour
  uses only: E4-OUTERMOST at x (a bad point in B̄(x, 1), or a cubic trichromatic un-enclosed v ∈ B̄(x, 1)); E4-N3BASE-UN at v, whose disc B̄(v, 2) lies in
    B̄(x, 3)
  not claimed: anything below radius 3; that the class is inhabited (no valid six-coloured fragment on a disc of radius 3 is held); that the vertex found
    has four colours (it may have a repeated colour)
  argument: § Argument for E4-LOCALDENSE
  verdict: derived
  grade: derived from: E4-OUTERMOST, E4-N3BASE-UN
  minds: 1
  model: none held — FS129-OR1-LOCALDENSE's own model line (the largest held fragment is FS112-CAL-DISK's, radius ≈ 2.1246)
  prior art: owed — in-house; FS112-N3-DENSE3's own prior art is not found in print
  handoff: de Bruijn — localDense's statement unchanged; its proof replaces FS112-DISC1's vertex by E4-OUTERMOST's and calls n3_base with Unenclosed

### Argument for E4-RIM

`C = P_cl(u)`; `S₁, S₂, S₃` the tiles at `u` (one sector per colour, and every tile holding `u` in its closure contributes a sector, so these are all).

1. **The tiles of `u`'s component lie in `B(u, 1)`.** A tile `T′` of a colour `j ∈ C` meeting `B(u, 1)`: the set `S_j × T′` is connected, carries no
   distance `1` (validity), and holds a pair at distance below `1` (points of `S_j` near `u`); so all its distances are below `1`, and letting the first
   point tend to `u` gives `T′ ⊆ B̄(u, 1)`, hence `T′ ⊆ B(u, 1)` (open). No tile of a colour of `C` meets `ω(u)`: a point of `ω(u)` inside such a tile has
   a neighbourhood in it, and points of `u`'s tile of that colour near `u` realise distance `1` to it. Let `K₀` be the union of the closures of the
   (finitely many) tiles of colours in `C` meeting `B(u, 1)`, and `R*` its component containing `u`. A tile `T′` of a colour in `C` whose closure meets
   the closure of such a tile `T` at `z`: if `z ∈ B(u, 1)`, `T′` meets `B(u, 1)`; if `z ∈ ω(u)`, `T′` misses `B(u, 1)` and `ω(u)`, so lies outside
   `B̄(u, 1)`; at `z` the arc of `Γ` separating the sectors of `T` and `T′` (adjacent, `z` having at most three sectors) lies in `B̄(u, 1) ∩ (ℂ ∖ B(u, 1))
   = ω(u)` — an arc of `Γ` on `ω(u)` whose two sides carry colours of `u`: a both-kind arc centred at `u`, which N3-NOBOTH forbids at a cubic
   trichromatic vertex. So every tile of a colour in `C` whose closure meets `R*` is a tile of `R*`, and lies in `B(u, 1)`; `R* ⊆ B̄(u, 1)`.
2. **The outer frontier.** `R*` is a continuum. Let `W` be the unbounded component of `ℂ ∖ R*` and `Φ` its frontier: `Φ ⊆ R*`, non-empty, and
   connected (the home theorem). `Φ` is the union of the closed sets `cl T ∩ Φ` over the tiles `T` of `R*` whose closures meet it.
3. **At least two tiles on `Φ`.** Suppose one tile `R°` alone has closure meeting `Φ`; `R°` is a tile of `R*`, so of a colour of `u`. Take a tile `S`
   at `u` other than `R°`; `S ∩ cl R° = ∅`. If a point `y ∈ S` lay in the unbounded component of `ℂ ∖ cl R°`, a path from `y` to a far point (in `W`)
   would avoid `cl R°`; at its last time in `R*` (closed) it is at a point of `cl W ∩ R* = Φ ⊆ cl R°` — a contradiction. So `S` lies in a bounded component
   of `ℂ ∖ cl R°`, against `UnenclosedC u`.
4. **The point.** `Φ` connected and covered by finitely many closed sets `cl T ∩ Φ`, at least two non-empty: grouping one against the rest, two meet. So
   some `q ∈ Φ` lies in `cl T₀ ∩ cl T₁` for tiles `T₀ ≠ T₁` of `R*`.
5. **Its colours.** `q ∈ R* ⊆ B̄(u, 1)`. `T₀`, `T₁` are distinct tiles at `q`, so (no repeated colour) of distinct colours, both in `C`. `q ∈ Φ = ∂W`:
   `W ∩ B(q, ε)` is open and non-empty, so it holds interior points (`Γ` is nowhere dense), and for small `ε` every interior point of `B(q, ε)` lies in a
   tile holding `q` in its closure (local finiteness: the arcs meeting `B(q, ε)` pass through `q`). So a tile `Y` at `q` meets `W`. `Y` has no colour of
   `C`: such a tile would be a tile of `R*` (step 1), and `R* ∩ W = ∅`. Hence `P_cl(q)` contains `c(T₀), c(T₁) ∈ C` and `c(Y) ∉ C`; no four colours, so
   exactly these three, exactly two in `C`. A second tile of colour `c(T₀)` at `q` would be a second sector of one colour, so `T₀` is the only one, and
   likewise `T₁`; both lie in `B(u, 1)` (step 1). ∎

*Where the six colours, the radius 2 and `NoInertNear` went:* nowhere. The step is topology plus Lemma H; enclosure is the only way it fails.

### Argument for E4-OUTERMOST

Suppose `B̄(x, 1)` holds no bad point.
1. **Hulls.** A tile has diameter at most 1 (a connected open set of larger diameter holds a pair at distance exactly 1, of one colour). `ℂ ∖ conv(cl T)`
   is connected, unbounded and misses `cl T`, so lies in `W_T`: `hull T ⊆ conv(cl T)`, of diameter at most 1. If a tile `T₁` has a tile `T₀` in a bounded
   component of `ℂ ∖ cl T₁`, then `cl T₀ ⊆ hull T₁`, so `W_{T₁}` (connected, unbounded, missing `cl T₀`) lies in `W_{T₀}`: `hull T₀ ⊆ hull T₁`. The
   inclusion is strict: equal hulls would put the frontier of their common outer domain inside both `cl T₀` and `cl T₁` on the same side, and a point
   of an arc of that frontier has one tile on each side.
2. **The outermost tile.** Take a tile `T₀` with `x ∈ cl T₀`. While some tile has the current tile in a bounded component of the complement of its closure,
   pass to it: the hulls strictly increase, each contains `x` and has diameter at most 1, so each tile met lies in `B̄(x, 1)`, and finitely many tiles
   meet `B̄(x, 1)`. The process stops at a tile `T*` with `x ∈ hull T*` that **no tile encloses**.
3. **Its rim has two outer tiles.** Let `Φ* = ∂W_{T*} ⊆ cl T* ⊆ B̄(x, 1)`. Each point of `Φ*` lies in the closure of a tile meeting `W_{T*}` (as in E4-RIM
   step 5), and such a tile, being connected and missing `cl T*`, lies in `W_{T*}`. If one tile `X` alone did, then near `Φ*` the domain `W_{T*}` lies in
   `cl X` (an arc with `X` on both sides would be a repeated-colour point of `B̄(x, 1)`), and the last-exit argument of E4-RIM step 3 puts `T*` in a bounded
   component of `ℂ ∖ cl X` — against step 2. So two tiles `X ≠ Y` of `W_{T*}` touch `Φ*`, and since `Φ*` is connected (`cl T*` is a continuum), their
   closures meet it at a common point `v` (E4-RIM step 4).
4. **`v` is cubic trichromatic.** `T*`, `X`, `Y` are three distinct tiles at `v ∈ B̄(x, 1)`. Two of one colour would be a repeated colour; a fourth colour
   would be four colours: neither is there. So `v` has exactly three colours, one sector each.
5. **`v` is un-enclosed.** Let `T` be a tile and `S ∈ {T*, X, Y}`, `S ≠ T`. If `S = T*`, step 2. If `S = X` (or `Y`) lay in a bounded component `B` of
   `ℂ ∖ cl T`: when `v ∉ cl T` a small disc about `v` misses `cl T` and meets `X` and `T*`, so `T* ⊆ B` — against step 2; when `v ∈ cl T`, `T` is `T*` or
   `Y`; `T = T*` is impossible since `X ⊆ W_{T*}`; for `T = Y`, the sectors of `T*` and `X` at `v` with the arc between them (minus `v`) form a connected
   set missing `cl Y`, so again `T* ⊆ B`. ∎ And `|v − x| ≤ diam hull T* ≤ 1`.

### Argument for E4-BEND-UN

The bend replaces the inert arc `α` of `ω(P)` by a curve `β` bowing toward `P`, the lens `L` between them recoloured with the outer colour; `L` is chosen
inside a collar of `α` in the inner tile `T_in` (a neighbourhood of `α°` in `cl T_in` homeomorphic to `α° × [0, 1)`, which local finiteness supplies, the
lens's two tips at `α`'s ends inside `T_in`'s sectors there). Pushing `α` across the collar to `β` is a homeomorphism `h` of the plane supported in a
small neighbourhood of `cl L`, fixing `α`'s ends, with `h(T_in) = T_in ∖ cl L`, `h(T_out) = T_out ∪ α° ∪ L`, and `h` the identity on every other tile. A
homeomorphism of the plane carries bounded components of `ℂ ∖ cl T` to bounded components of `ℂ ∖ cl h(T)`, so `Unenclosed` holds at `h(u)` in the bent
map; and `h(u) = u` because `u` is an end of `α` or off the support. Iterated bends: by induction. ∎

### Argument for E4-N3BASE-UN

FS112-N3-BASE's walk (`plans/FS112-N-proof.md` stage N3-3, as the planner cut it into `BaseWalk`'s leaves) uses the eleventh point only as the input to
the count (`eleventh_type`, then `cor3_base` or `eleventh_antipodal`). E4-RIM supplies it under `UnenclosedC u`, after the pre-bend, which keeps
it (E4-BEND-UN, whose argument holds for either form) and adds no colour or sector to any point (so `BaseHyp u` survives, as the walk already says). Every other leaf is read as
filed. ∎

### Argument for E4-LOCALDENSE

Suppose `B̄(x, 3)` holds no bad point. E4-OUTERMOST gives a cubic trichromatic `v ∈ B̄(x, 1)` with `Unenclosed v`, hence `UnenclosedC v`. `B̄(v, 2) ⊆ B̄(x, 3)`, so the fragment
covers `B̄(v, 2)` and `BaseHyp v` holds; E4-N3BASE-UN at `v` is a contradiction. ∎ FS112-DISC1 is no longer needed: E4-OUTERMOST supplies a vertex in
`B̄(x, 1)` directly, and the right one.

## Stage 3 — SAVED
