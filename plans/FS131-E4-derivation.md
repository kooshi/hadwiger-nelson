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
