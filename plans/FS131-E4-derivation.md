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
