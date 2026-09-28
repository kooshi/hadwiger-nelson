# FS114-C — the close of FS-114, the unit-arc question (the close record)

*Job FS114-C (Ephodos, the close job; brief `data/fs114/briefs/C114-close.md`, standing rules `plans/STANDING-RULES.md`, both read in full
2026-09-28). Record of the close: the readback, the reconciliation, the derivation file, the sweeps and scored predictions, the successor stubs,
and the drafts of the front page. Launched beside FS111-C, which writes other files.*

## Theorems this phase proved

**None of its own.** This close files the milestone's theorems (`plans/FS114-derivation.md`, 46 entries, at the grades the records support) and
derives nothing new: its reconciliation (stage 2), its comparison of R-E2 with E2 (stage 2 §2.5, not settled) and its divergence count are readings of
the records, not theorems.

## Would-have-searched-here log (standing rule 5)

| stage | move a search would have made | what was done instead |
|---|---|---|
| 1–6 | — | none: reading, filing and drafting only; no search of any kind (the only computations are the gates, the ledger checker, the Brier sum and a byte count) |

## Fence log (standing rule 8)

No fences: a close reads every record of its milestone (the brief's `fences: none`). Nothing was written to the auto-memory.

## Stage 1 — SAVED: the readback, and the proposed ticks

### 1.1 Files read in full, in this order

`data/fs114/briefs/C114-close.md`; `plans/STANDING-RULES.md`; `plans/FS114-close-inventory.md` (items 1–122); `data/fs114/claims.md` (§§0–8);
`plans/FS114-unit-arc-question.md` stage 5 (5.0–5.7); `plans/STUB-global-step.md` (head, ll. 1–60). The lane file (`.claude/agents/ephodos.md`) and
`CLAUDE.md` are loaded as context.

### 1.2 The brief's quotations, checked against their sources

| # | quotation (as in the brief) | source named | result |
|---|---|---|---|
| Q1 | "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old." | `plans/WORKFLOW3-test-drive.md` row K2 | **FOUND**, verbatim, row K2 (l. 12), dated 2026-09-28 ~21:35 UTC |
| Q2 | "FS-114 — the unit-arc question (its central statement, the global step): can a six-map with unit arcs have a vertex of four colours or a repeated colour within 3 of every point?" | `plans/STUB-global-step.md` | **FOUND**, verbatim, as the stub's title line (l. 1, between "# " and " (stub)") |

**Findings about the brief** (none changes a statement):
1. The brief asks for ticks on items 1–121; the inventory holds **122** items (item 122 is this job's launch). Ticked 1–122.
2. The brief lists the stub-to-mint items "8, 14, 28, 42, 55, 64, 69, 91, 101 and those after". Several are superseded inside the milestone
   (64 by rounds 4–5; 69's K1-ΓRING by NB5-BOWTIE and Y4-RSTOPALL); each is placed or declined in the ticks with the item that superseded it.

### 1.3 The claims restated beside the quotations (what this close must say)

- **The question (Q2).** A NO excludes every valid six-map with unit arcs (by FS112-N3-DENSE3 every valid map has the property, so the global step is
  the NO itself, FS112-C-COMPOSE (1)); a YES builds one. **Polarity, checked:** a NO answers `[SokolovVoronov2025]` Question 2 *yes* (seven are needed)
  for its unit-arc half; a YES gives `χ(ℝ²) ≤ 6` with no MR. The close states every verdict with the class it reaches (inventory item 22).
- **The ruling (Q1, with inventory item 121).** FS-114 closes now, undecided; round 7 is not run; its queue (a blind check of N7-HUB, the wrap lemma,
  the survivor OC, the rings with (Q) arcs) becomes the successor's opening; FS114-N7's N7-3T is filed at one mind.

### 1.4 The proposed ticks

`data/fs114/fs114-c/ticks.md` (committed with this stage): one row per inventory item 1–122, each "done" with where, or "declined" with the reason.
Rows whose "where" is a later stage of this record name that stage; the table is re-checked at stage 6 before the report.

## Stage 1 — SAVED

## Stage 2 — SAVED: the reconciliation

*Read for this stage, in full or at the named sections: all 26 reports in `data/fs114/reports/`; the "Theorems this phase proved" table of every
record (`plans/FS114-{N,N3,N4,N5,N6,N7}-proof.md`, `-{NB,NB4,NB5,NB6,YB,YB2,YB3,YB4,YB5,CV,CVB}-verification.md`, `-{Y,Y2,Y3,Y4,Y5,Y6}-construction.md`,
`-L60-audit.md`); `plans/FS114-N3-proof.md` §3.2 and stage 4; `plans/FS114-N7-proof.md` §3.2; `plans/FS114-Y5-construction.md` §3 (the pinwheel's
notation); the plan's §PA, §IQ and stage 5b; the inventory. Grades are the records'; "blind" means the mind derived before opening the first
derivation's record (each verifier's stage 1 was committed before its stage 2 opened the side's record, by its commit ids). Amendment 1 of the brief
(qualified ids; "Rests on it:" as prose) read and applied from stage 3 on.*

### 2.1 The minds, by round

| round | proof side | its blind verifier | construction side | its blind verifier | beside |
|---|---|---|---|---|---|
| 1 | FS114-N (stage 1), FS114-N2 (continuation) | FS114-NB | FS114-Y | FS114-YB | BASE-V (row 134's base); FS114-CV, then FS114-CVB (the composition; CVB part B the third mind on C114-THOM-TOP) |
| 2 | FS114-N3 | none run (item 57: the slot went to FS-111) | FS114-Y2 | FS114-YB2 (with round 3) | — |
| 3 | FS114-N4 | FS114-NB4 | FS114-Y3 | FS114-YB2 | FS114-L60 (the L60 audit, sighted on N4) |
| 4 | FS114-N5 | FS114-NB5 | FS114-Y4 | FS114-YB3 | — |
| 5 | FS114-N6 | FS114-NB6 | FS114-Y5 | FS114-YB4 | — |
| 6 | FS114-N7 | none (round 7's queue) | FS114-Y6 | FS114-YB5 | — |

The two sides were fenced from each other throughout; routes were never relayed mid-round (items 50, 57, 87). Three convergences between them were
blind: N3's DR is Y2's bowtie (item 58); N4-D and Y3-RSTOP reached `√3` by different routes (item 66); N5's residual (R-V) has the shape of Y3's escape E2
(item 85), and Y4-RSTOPALL excluded it where N5 left it open, blind to NB5, which excluded it too (items 88, 94).

### 2.2 Every claim and lemma: verdict, minds, blindness (proof side)

*"2 (1 blind)" is two minds, one blind; "2 (sighted)" is two minds with the second's step checked with the first in view. Where a later job re-derived
a lemma blind, the count includes it.*

| id | verdict | minds | notes and divergences (settled how) |
|---|---|---|---|
| N114-FAR | TRUE | 2 (1 blind: NB-FAR) | FS-110's N-E2 in interval form |
| N114-RD (the rainbow deficit) | TRUE | 2 (1 blind: NB-RD) | NB reads radius `1 + 1/√3` about the tile's centre; prior art in words: Gibbs's vertex-edge/vertex-vertex constraints and Mixon's, as search rules (item 33) |
| N114-EDGE-RB = C114-EDGE-RAINBOW | TRUE | 4 (N; Y-EDGE blind to N; NB, YB blind) | Y5-RAINBOW its non-Siamese form, re-derived (with YB4, two more) |
| N114-RB = C114-RAINBOW | MISSTATED | 4 agree MISSTATED (N, NB, Y, YB) | corrections differ in form, not truth: N's (B) type; Y's case (ii); YB's trichotomy (finite contact sets, cross distances 1) with its third case realised exactly on a fragment of radius 3/5 (one mind). One corrected statement: FS114-RAINBOW in the derivation file |
| N114-EULER | TRUE | 2 (1 blind: NB-EULER) | wording divergence: `μ` must count self-meetings (NB); N2 adopted it |
| N114-FIVE = C114-FIVE-COUNT | N: GAP at (B) → **TRUE** | 2 (1 blind: NB-ABSENT/NB-COUNT; N2-ABS/N2-FIVE sighted) | **truth divergence**, NB right: at most three tiles of a colour absent from a tile's edge-neighbours meet it; N2 withdrew its GAP. With N2-AVG: no simple non-Siamese valid five-colour map of the plane (N2-FIVE-PLANE, one mind) |
| N114-ROOM | TRUE | 2 (1 blind: NB-COUNT) | six's room is `V₄ ≥ 3V₆` |
| N114-CUBIC | TRUE | 2 (1 blind: NB-CUBIC) | a counting route to part of DENSE3 |
| N114-COMPACT = C114-COMPACT | TRUE for every `K` (the class limit); **not at a fixed `K`** | 2 (1 blind: NB) | **truth divergence** at fixed `K` (a pinching tile breaks "≤ `K` tiles per unit disc"), NB right; N2 withdrew |
| N114-VOR = C114-VOR | fails at C-CS-1 (c) — no contradiction from Voronov's argument | 2 (1 blind: NB-VOR) | NB: MISSTATED as N wrote it (the closed disc; a close-pair case missing); N2 withdrew the wording; the verdict "Voronov cannot refute a valid map; the band is what closedness buys" stands at two minds |
| N114-THOM = C114-THOM-TOP | **TRUE with a colour-free repair** (a pinch keeps `M − x` connected, a hole breaks it; fill holes; local finiteness replaces the count); Thomassen fails on valid maps only at the rainbow step | 3 (NB and CVB blind; N stage 1 against) | **truth divergence** on the pinch clause: N GAP, NB TRUE; the third mind (CVB part B) decided 2–1 for NB; N2 withdrew. The 2-separator criterion at pinches a sketch, one mind (CVB) |
| C114-DUAL-COUNT | **MISSTATED; corrected** (≥ `2n + 2V₅ + 6V₆` unit-arc edges of `5n/2`: at least 80 %, exactly Sirgedas's `2n` iff no vertex of degree 5 or 6) | 4 readings (N MISSTATED "emits"; Y TRUE as stated, an over-grade; NB TRUE with scope; YB MISSTATED with the exact count) | substance agrees (item 40); **truth divergence** on Y's "as stated", YB right (its premise "only triangles and quads" dropped). Corrected at two minds, both blind (NB, YB) |
| N2-ABS, N2-FIVE | TRUE | 2 (1 blind: NB) | the five-colour control, route T's positive control met |
| N2-SLACK (`A = E′ − V₄ + 3V₆ + U`) | TRUE | identity 1 (N2; tools exact); its inequality form 2 (1 blind: NB-ARCS) | — |
| N2-ENDS (the charge `n`, `n − 2`, `n`, `n + 6`, `2U`) | TRUE | 1 (tools exact, `tools/fs114_n2_count.py`) | negative only at a degree-4 vertex with ≥ 3 tactic edges: the source of K1 |
| N2-VCAP, N2-DIAM, N2-CROWN, N2-GROW, N2-REFINE, N2-SIAM, N2-MU | TRUE | 1 each | N2-REFINE: with Siamese pairs no density bound exists, so a Siamese kill must read points and distances, not tiles (N3 stage 4) |
| N2-KILL | TRUE (a reduction: the torus NO, non-Siamese, `μ = 0`, ⟸ K1 ∧ K2) | 1 | K1, K2 open; refined by N3-JOINT |
| N2-PENT (REDBLOCK's "no pentagons") | TRUE | 1 | — |
| N2-QUAD (REDBLOCK's "no quadrilateral") | GAP (the all-β configuration passes every local check) | 1 | — |
| N2-ENC3 = C114-ENCLOSED3 | GAP; it implies COVER-3 (insertion lemma) | 2 agree GAP (N2; Y) | COVER-3 to the successor |
| N2-AVG (averaging on discs, no complexity bound; N2-FIVE-PLANE) | TRUE | 2 for the averaging step (1 blind: NB6-FOLNER); the five-colour plane corollary 1 | NB6-FOLNER re-derived it blind as route T's aperiodic step |
| N2-CURV = C114-CURV | TRUE at every `K`, `R₀ = O(K²)` (simple maps); uniform `R₀` a reading | 1 | E7 scored at stage 4 |
| N2-GSD (GS-D) | GAP at K1, K2-loc, GAP-μ and the Siamese class | 1 | superseded by CV-EXISTS for the Siamese class: C114-LOCAL-F alone is the NO (N3 stage 4) |
| N3-FACE | TRUE | 2, blind to each other: N3; FS114-Y4-UPDOWN is the same statement in substance (derived on the fenced side; YB3 re-derived UPDOWN blind) | N-E2's cone form |
| N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N3-ODD | TRUE | 1 each (no blind verifier ran on N3, item 57) | used as inputs by N4–N7 and NB4–NB6 (stated in their briefs as tools, not re-derived) |
| N3-DR (DR's forced structure) | TRUE | 1 | = Y2's bowtie design, derived blind on the other side |
| N3-DR0 | conclusion TRUE (N4-D, at `√3`); **its proof GAP at step 1** | 2 (1 blind: NB4-DR0) + N4 | **truth divergence** in the proof, found by N4, confirmed blind by NB4 |
| N3-CONT, N3-PAY, N3-JOINT, N3-DR2 | TRUE | 1 each | route T's kill restated as a fractional assignment; K1 ∧ K2-loc its own-ends case |
| N3-DR1 | TRUE | 2 (1 blind: NB5-DR1, in N5's setting) + N4 (sighted) | — |
| N3-K1 | K1 GAP (not derivable at radius `1 + ε`) | 1 | the escape DR later excluded at `√3` (below) |
| K2-loc | moot (N3); its content is N3-JOINT's K2′ (an unused unit in every disc) | 1 | — |
| GAP-μ | stands (a pocket meets ≤ 65 tiles, non-Siamese; no payment rule) | 1 | route T only |
| SIAM-KILL | subsumed by C114-LOCAL-F once CV-EXISTS holds | 1 | a Siamese kill must read points and distances (N2-REFINE) |
| N4-OWN, N4-LENS (non-Siamese), N4-FIVE, N4-TOP | TRUE | 2 (1 blind: NB4) | N4-LENS FALSE without non-Siamese (NB4) |
| N4-OPP | **MISSTATED in general**; corrected second-order form | 2 (1 blind: NB4) | **truth divergence**, NB4 right (an edge curving toward `q` with curvature > 1 captures the branch); N4-OWN unaffected |
| N4-D | TRUE | 2 (1 blind: NB4-D, a different last step at `R* = q1 + top`) | — |
| N4-G | TRUE | 2 (NB4 blind on the reduction, **sighted on the kill step**, item 83) | a fully blind kill is owed only if N4-G is ever the sole support; it is not (Y4-RSTOPALL) |
| N4-BOWTIE | TRUE | 2 as N4-D, N4-G | superseded in scope by FS114-BOWTIE-SQRT3 (any lune rings) |
| N4-ARC, N4-A4NB, N4-TANG, N4-GP90, N4-HORN | TRUE | 1 each | FS112-SIX, A4SIX, NB4P add nothing at the bowtie |
| N4-L60 = FS112-L60 at 60° | FS112-L60 **FALSE at exactly 60°**; TRUE corrected `ℓ ≤ 60°` | 2 for the bound (N4; L60, not blind) | the erratum in `plans/FS112-derivation.md` (stage 3) |
| N5-BEND, -BENDG, -KAPPA, -UP, -DEG, -W, -XBAR, -R0, -SIGHT, -DR1, -ΓRING (the reduction) | TRUE | 2 (1 blind: NB5; N5-R0 by a different route) | N5-BEND's length bound derived for (R2) arcs only (a GAP if read for (Q) arcs; wording); N5-SIGHT in the non-Siamese class |
| N5-RV | structural clauses TRUE; **"Not excluded: K1-ΓRING is GAP at (R-V)" FALSE** | clauses 2 (1 blind); the kill 1 (NB5-RVKILL) and independently FS114-Y4-RSTOPALL | **truth divergence**, NB5 right; confirmed by the construction side's RSTOPALL, blind to both |
| N5-PIN0 | structural clauses TRUE; "no contradiction at `1 + ε`" not established; its "`α_j ∈ {60°, 180°}`" loses 180° (N6-PIN180) | 2 (1 blind) | — |
| NB5-BOWTIE | TRUE: the Reuleaux bowtie (non-Siamese, simple) with any lune rings does not exist on `B̄(p, √3)` | 1 on its last step (NB5-RVKILL); with FS114-Y4-RSTOPALL independent | filed as FS114-BOWTIE-SQRT3 |
| N6-KAPPA, -RING60 (after the bends), -NOQ, -PIN, -P60′, -ADJ, -QOUT, -QE1, -PIN180, -CENT | TRUE | 2 (1 blind: NB6) | N6-CENT's last clause read `0° < γ < 60°`; NB6-NOQ needs no PIN180 |
| N6-WIN | §2.2 form TRUE; **the table sentence MISSTATED** (the reach of `y + 60°` is conditional at a (Q) end) | 2 (1 blind) | truth divergence, NB6 right (NB6-WINFIX) |
| N6-COV | **MISSTATED**; TRUE with `κ` defined just beyond both windows | 2 (1 blind) | truth divergence, NB6 right (NB6-COVFIX) |
| N6-MTP (Kooshi's lead, item 79) | printed steps TRUE; "closes by printed theorems" **GAP** (hull limits of simple hole-free maps can be non-simple); the conclusion TRUE by N2-AVG | 2 for the conclusion (1 blind: NB6-FOLNER) | truth divergence in the route, NB6 right. The lead checked: the mass-transport route needs GAP-μ in the hull; the elementary disc average suffices |
| N6 §2.3 "(Q) arcs never start at a centre counter-clockwise" | GAP (NB6-QSTART: it rested on the withdrawn N6-P60) | 1 | K1-PINQ's residual gains a case |
| NB6-P60 | TRUE (a pinwheel lemma; the kill the cone `(240°, 300°)` at `q_j`) | 1 | — |
| N7-HUB, -REACH, -TAN, -TAC, -3T, -FLANK, -QOPP, -CHAIN, -HUBQ, -OCTB | TRUE as stated | **1 each** (no blind check; round 7's first job, item 119 (2)) | N7-3T filed at one mind, as the brief rules (item 118) |

### 2.3 Every claim and lemma: verdict, minds, blindness (construction side and composition)

| id | verdict | minds | notes and divergences (settled how) |
|---|---|---|---|
| FS114-Y-PENT, -STRIPK6, -STRIPRIGID, -DISKRIGID, -PAIRSHARE, -K6, -EDGE, -REDBLOCK1 | TRUE | 2 (1 blind: YB; rebuilds identical tile for tile; STRIPK6/STRIPRIGID/DISKRIGID by different routes) | DISKRIGID's chain clause dropped in the owner's instance (a slip, item 39); YB-LOCAL: the nine tiles at `B_k` do not force complementarity |
| FS114-Y-DIAL | TRUE: the capped strip is valid and holds `B̄(P_j, R)` for every `R < φ²/√2 ≈ 1.8512`; no extension of the strip does better | 2 (1 blind: YB-CAP) | C114-LOCAL-F's radius must exceed `φ²/√2` |
| FS114-Y-ROUTES | TRUE at named points; its one-line region-wide reading **FALSE at 3 of 11 points** | 2 (1 blind) | truth divergence in the headline sentence, YB right; the route's failure unaffected |
| FS114-Y-RAINBOW | MISSTATED as C114-RAINBOW's correction: case (ii) a subcase of YB's trichotomy | 2 | see C114-RAINBOW above |
| FS114-Y-DUALCOUNT | "TRUE as stated" an over-grade | see C114-DUAL-COUNT | — |
| C114-TORUS | F1, F2 excluded (by STRIPK6 and DISKRIGID/PENT); F3 budget derived, not decided; no torus member built | 1 (the families), 2 (the kills) | — |
| C114-SIRGEDAS-FORM | not landed (the non-Siamese record stays the disk's 2.1246) | 1 | — |
| E16 (G71's index at FS112-BOWTIE's seam) | not met at IND-X's grade (BOWTIE satisfies IND-X's hypothesis; the curves not built) | 1 | — |
| FS114-Y2-BOWTIE | TRUE: a non-Siamese valid fragment by formula (20 tiles over `ℚ(√3)`) holds `B̄(p, 3√3/5)` about a degree-4 four-colour vertex with four tactic edges | 2 (1 blind: YB2-BOW, an independent object, two checkers) | = N3's DR, built unprompted: K1 is not local at radius `3√3/5` |
| FS114-Y2-GAPS | TRUE | 2 (1 blind: YB2) | — |
| FS114-Y3-RSTOP | TRUE: Y2's bowtie extends to no disc of radius `≥ √3` | 2 (1 blind: YB2-RSTOP, the stop the cone `(−60°, 60°)` at `r`) | Siamese pairs irrelevant |
| FS114-Y3-R | TRUE as a necessary condition; clause (i) sharpened ("the sector starts after 60°") | 2 (1 blind) | wording |
| FS114-Y3-D2 | TRUE under reading R-T (the bowtie includes its four tactic edges; the owner's ruling, item 72) | 2 (1 blind) | without R-T one case a GAP (YB2) |
| FS114-Y3-FOUR | its general form not verified; **its "so five colours at `q_i` are not forced" FALSE once `top`'s neighbourhood is in the fragment** | 3 against (YB2 non-sequitur; YB3-FIVE; Y4-DIAG step 3) | truth divergence, the verifiers right; consistent with N4-FIVE (four-colour corners only in N4's general member, which N4-G excludes) |
| FS114-Y3-13 | TRUE, and the `(1 3)` class is **empty** | 2 (YB2-EMPTY13, one mind; its general form FS114-Y4-LUNE, 2 (1 blind)) | Y3's GAP decided "none exists" |
| FS114-Y4-SIDES, -D2ALL, -UPDOWN, -W, -E2X, -LUNE, -DIAG, -RSTOPALL | TRUE | 2 (1 blind: YB3; different routes at LUNE's frontier and W's colour steps) | LUNE needs no "simple" (YB3); DIAG step 5's written reason misses a cusp `T2` along 300°, closed by the `X2 \| N′` unit arc (YB3-CUSP, exact 5/5) — a route divergence in a reason, no statement changes |
| FS114-Y4-CHK | 19 of 19 exact checks as registered | tools | — |
| **The Reuleaux bowtie family at `√3`** | **excluded** (non-Siamese, simple; any lune rings) | **two independent derivations**: Y4-RSTOPALL (2, 1 blind: YB3) and N4-D/N4-G/N5-DEG/N5-R0/NB5-RVKILL (each link 2 but the last, NB5-RVKILL, 1) | filed as FS114-BOWTIE-SQRT3 |
| FS114-Y5-RAINBOW, -REGION, -ALT, -POCKET, -CASE, -REDUCE, -PXKILL | TRUE | 2 (1 blind: YB4) | PXKILL's contradiction appears only at second order (YB4-2ND) |
| FS114-Y5-MU | TRUE with two hypotheses its words omit ("simple"; edge `j + 1` below 60°) | 2 (1 blind) | wording/scope, YB4 right |
| FS114-Y5-PX | TRUE except "`λ_k = α_k − 60°`" — **a GAP (the wrap, YB4-WRAP)** | 2 (1 blind) for the rest | truth divergence, YB4 right; CASE survives |
| FS114-Y5-PIN120-60, -PIN120 | TRUE outside E1; their no-exception claims **GAPs** at named E1 subcases (PIN120-60's step 2 holds only at `α_D = 120°`; PIN120's CASE at `q_{k+1}` needs `μ_{k+1}`) | 2 (1 blind) outside E1 | truth divergence, YB4 right; the alternating member `(120°, 60°, 120°, 60°)` TRUE with no exception (the side's route closes YB4's open subcase) |
| **FS114-Y5-PINALL** | **TRUE outside E1 and E2**, which are exactly the cases the chain misses | 2 (1 blind: YB4) | with N6-NOQ (2, 1 blind) the pinwheel is closed from both sides at `1 + ε` outside E1, E2 |
| FS114-Y5-D90 | TRUE (one design; subsumed) | 1 | — |
| FS114-Y6-E1FORM, -E1Q3, -E1OMEGA, -E1K1 | TRUE | 2 (1 blind: YB5) | — |
| FS114-Y6-E1CAP | TRUE but "`λ_3 = α_3 − 60°`" **a GAP (the wrap)** | 2 (1 blind) for the rest | YB5-CAP2: a Jordan-curve route to the whole arc |
| FS114-Y6-E2RED | the chain TRUE; **the survivors sharpened from S1–S6 to S6** `(120°, b, 180° − b, 60°)` (S1 by PXKILL at `k = c + 1`, S2–S5 by YB5-E2-60, S5 also by YB5-CONE180); "all short of the tangent" **a GAP** (a full wrap) | 2 (1 blind) for the chain; the sharpening 1 (YB5) | truth divergence in the survivor list, YB5 right |
| FS114-Y6-HALF | **MISSTATED**: true iff `t_2`'s cone `> 60°` and `t_4`'s `≥ 60°` (YB5-HALF4) | 2 (1 blind) for the corrected form | truth divergence, YB5 right |
| FS114-Y6-HELD | a float survey, aiming only (degree-4 vertices of held fragments carry 0, 2 or 4 tactic edges, none 3) | tools, not evidence | the 5° grid of cone sequences (item 115) is a ban touch; nothing rests on it |
| BASE-V's regrade (row 134's base) | S–V Lemma 5, Prop. 18 TRUE blind (two minds, both blind, with FS110-CD); Lemma 6's `< 9` branch TRUE under H (BV-HEX); Lemma 3 and Cor. 3 at cusps TRUE; **Lemma 4 at cusps not landed** (CUSP-BASE's D5 items 1–4, 6 stay at CE's one mind) | as stated | upgrades only (item 12); the print's Prop. 18 sketch has one false sentence |
| CV-EXISTS = C114-EXISTS-F = GS-1 | **TRUE, with no residue: every valid map has a vertex of at least four colours** | **2, blind to each other** (CV; CVB, by a shorter route using neither CV-HD nor C-ENDS: no four-colour vertex ⟹ every stuck chain of `M*` bi-infinite ⟹ N4-FIN) | so **C114-LOCAL-F alone is the unit-arc NO, Siamese or not**; its chain intact at L60's boundary (L60-WALK, one mind) |
| CV-L0, CV-HD, CV-CLASS, CV-ENDS (C-ENDS's residue empty), CV-U, CV-L4 | TRUE | 2 (CV; CVB blind; CV-HD by different routes, CVB sighted on Y3-END-NEEDS's levels) | CV-HD step 3's wording omits the ring tile crossing `ω(E)` (CVB A-7) |
| CV-FLANK, CV-P | TRUE | 1 each (CV) | CVB proposes them for CV-EXISTS's grade line; CVB's own route does not use them |
| FS112-C-DOUBLE, FS112-C-PARTNERS, FS112-C-COMPOSE (1)–(3) | TRUE | 2 (FS112-C; CV blind) | C-COMPOSE (2)'s radius `\|K\| + 2` needs NB3's `2\|K\| − 3`; (3) is GS-4's density form, not needed for the NO |
| L60-LE, L60-EQ (outer), L60-REAL (cap), L60-2 (interior) | TRUE | 2 each (N4 or NB; L60, not blind) | — |
| L60-WALK, L60-D5, L60-PROOFS, L60-EQ (inner, ends) | TRUE | 1 each | the registered L60-P1, L60-P2 wait for a blind mind that never ran (stage 4) |

### 2.4 Divergences of truth, counted

Every round had at least one (E15 met): round 1 — C114-FIVE-COUNT (N GAP, NB TRUE), C114-THOM-TOP's pinch clause (N GAP; NB, CVB TRUE), N114-COMPACT at
fixed `K`, N114-RB's (B) "realised", C114-DUAL-COUNT "as stated" (Y), Y-ROUTES' region-wide sentence; round 2 — N3-DR0's proof (N4, NB4); round 3 —
N4-OPP (NB4), Y3-FOUR's "not forced" (YB2, YB3), FS112-L60 at 60° (N4, L60); round 4 — N5-RV's "not excluded" (NB5; RSTOPALL); round 5 — N6-WIN, N6-COV,
N6-MTP's route, N6's (Q)-start claim (NB6), Y5-PX's `λ`, PIN120-60's and PIN120's no-exception claims (YB4); round 6 — Y6-E1CAP's `λ_3`, E2RED's survivor
list, HALF (YB5). **Every one was settled for the second mind**, by its derivation, by a third mind (CVB on THOM-TOP) or by the first side withdrawing;
none left open. **Direction:** of the 21 listed, seventeen lowered a claim (a scope, a clause, a proof step) and four raised one, each a verifier
deriving more than its side had — C114-FIVE-COUNT, THOM-TOP's pinch clause, (R-V) excluded, E2's survivors cut to S6 — and all four flatter the NO. Their
audit (G21): FIVE-COUNT confirmed by N2 (sighted), THOM-TOP by a third mind (CVB), (R-V) by RSTOPALL (blind, a different route); **E2's cut to S6 stands
on YB5 alone**, and is filed at one mind. *(Corrected at stage 3: first written "of the 22, twenty lowered a claim; none raised one", a miscount.)*

### 2.5 Item 119 (1): is N7's reading R-E2 the construction side's E2?

**Not settled from the records; carried to the successor's first comparison.** On their face the two differ: R-E2 fixes a cone, "`α_{j+1} = 60°`,
`T_{j+2}` in the Reuleaux triangle, a (Q) arc of `T_{j+2}` from `q_j`" (`plans/FS114-N7-proof.md` §3.2, NB6-QSTART's member), while the construction
side's E2 fixes none: "a blade `t_{j+2}` whose side `M_{j+1}` is an arc of `ω(w_{j+1})`" (`plans/FS114-Y5-construction.md` §3, `w_{j+1}` the end of the
blade's clockwise edge). By YB5-E2-60 the construction side's E2 at a blade of cone 60° holds only with E1 at one of its edges, and its one surviving E2
family is S6 `(120°, b, 180° − b, 60°)`. So R-E2 is at most a subcase — either an E1 subcase (if its 60° cone is the E2 blade's) or NB6-QSTART's member,
which the construction side has not met. The two frames label cones and tiles differently (the proof side's `T_j`, `α_j` against `t_j`, `μ_j`, `M_j`);
mapping them is the comparison's work, not the close's.

### 2.6 The headline, in four parts

1. **What the NO reduces to, at what grades.** **Every valid six-map with unit arcs has a vertex of at least four colours** (CV-EXISTS, two minds
   blind to each other, over FS112-N3-DENSE3 at two minds, one blind, and row 134's base, whose Lemma 4 at cusps is still one mind). So **the unit-arc
   NO is exactly C114-LOCAL-F**: an explicit radius `R` about a vertex of at least four colours within which no valid fragment exists — Siamese pairs
   included, no ray step, no density, no residue. By the capped strip, `R > φ²/√2 ≈ 1.8512` (two minds, one blind). **The pieces held**, all at a
   degree-4 four-colour vertex with three or four tactic edges (the configurations where route T's charge goes negative), non-Siamese and simple:
   - the **Reuleaux bowtie family** (two Reuleaux triangles of width 1 corner to corner, four tactic edges; any lune rings) has no fragment on
     `B̄(p, √3)` — two independent derivations, the construction side's at two minds, one blind;
   - the **pinwheel** has none containing a neighbourhood of `B̄(p, 1)`, outside two named exceptions E1 (an edge of exactly 60°) and E2 (a blade's
     counter-clockwise side a unit arc about its clockwise edge end) — two minds, one blind, from each side (Y5-PINALL; N6-NOQ for (Q)-free rings);
   - **three or more tactic edges on a (Q)-free ring** have none at `1 + ε`, except the open-cap family OC — **one mind** (N7-3T).
   Route T, the count, reduces the non-Siamese NO (every complexity) to **K1′ ∧ K2′ ∧ GAP-μ** (the charge's deficient vertices paid locally, a surplus in
   every disc, repeated contacts): N2-ENDS exact, the averaging closed on discs (two minds, one blind). It is blind to Siamese pairs by theorem (N2-REFINE),
   so it can never be the whole NO; C114-LOCAL-F can.
2. **What the YES side holds, and where it stops.** Held exactly: the capped strip to `φ²/√2` (two minds); the Reuleaux bowtie to `3√3/5` (two
   independent objects); YB's rainbow fragment (radius 3/5, one mind); L60's equality fragment. Stopped: neither printed geometry is part of any valid map,
   under any colouring (STRIPK6, DISKRIGID with PENT, two minds); every Reuleaux bowtie stops before `r`, at `√3`; every pinwheel dies at `1 + ε` outside
   E1, E2; the torus families F1, F2 die, F3 undecided. No YES by formula (E12's 0.03 not met).
3. **What is open, named.** C114-LOCAL-F itself — at four-colour vertices of every type, including those with 0–2 tactic edges (the strip's and the disk's)
   and degree ≥ 5. Within K1: rings with (Q) arcs (N7-HUBQ's step; the (Q)-pinwheel's residual, NB6-QSTART); E1's residues E1-Z, E1-60, E1-ν and the
   combinations E1{1,2}, E1{1,4}, E1 with E2; E2's survivor S6; **the wrap** (a pocket tile wrapping round a blade's ring end — Y5-PX's `λ`, E1CAP's `λ_3`,
   E2RED's full wrap: one lemma closes three GAPs); OC (K1-OPENCAP); non-simple bowties; the Reuleaux `(2, 1, 1, 0)` past `√3` with (Q) rings. For route T:
   K2′, GAP-μ. Grades owed: a blind mind on N7-HUB (b) and the `+++ b = a + 1` step (N7-3T at one mind); on NB5-RVKILL's last step if RSTOPALL is ever
   withdrawn; on Lemma 4 at cusps before row 134 is published; E1/E2 sharpenings at one mind (YB5).
4. **Confidence.** That the NO holds for this class: **0.65** (every configuration examined in six rounds died within `√3`, most at `1 + ε`, and each
   escape named was narrower than the last); that C114-LOCAL-F lands at an explicit radius within one more milestone: **0.3**. **What would change it:** a
   valid fragment by formula around a four-colour vertex beyond `φ²/√2` whose ring carries (Q) arcs — the class every local exclusion so far has had to
   except — or an E1 or S6 member built past `1 + ε`. Either would lower the first number and move the target to the (Q)-rings; a derivation of the wrap
   lemma and of N7-HUBQ would raise the second.

**Class reached** (item 22): every verdict above is about valid maps with no complexity bound, almost everywhere, except where the row says
"non-Siamese" or "simple"; nothing here is a verdict at a fixed `K` alone. **Posed questions** (`CLOSED-QUESTIONS.md`): nothing answers one — the
reduction to C114-LOCAL-F is a partial reduction of `[SokolovVoronov2025]` Question 2's unit-arc half and of `[Polymath2021]` p. 199's hope, and no
explicit `R` landed for Mixon's thread-7 question's upper side. The five-colour plane corollary (N2-FIVE-PLANE, one mind) is row 132's "maps need six"
in the non-Siamese simple class by counting, a known value, not an answer.

## Stage 2 — SAVED

## Stage 3 — SAVED: the derivation file, and the FS-112 errata

- **`plans/FS114-derivation.md`**: 46 entries (43 derived, 3 stalled or gapped: FS114-ROUTE-T, FS114-K1, FS114-GSD), ids qualified and "Rests on it:" as
  prose (the brief's Amendment 1). Grouped entries quote each member's statement from its record's table with the member's id. Gate:
  `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS114-derivation.md` — **PASS, 0 failures, 0 warnings** (output
  `data/fs114/fs114-c/gate-derivation.out`). Two gate findings on the first run, fixed: N4-LENS's "(likewise `v`)" read as a rider (left out of the quoted
  statement and explained in prose: the mirror under `u ↔ v`); L60-EQ's "exactly the closed half-plane" read as two-way (its reverse inclusion is argued in
  the same section, given as the converse address). One warning ("the only" in E2RED) answered with a one-way reason.
- **Kernel decisions** (`handoff:`): four entries go to de Bruijn **deferred with D6** (Kooshi's held decision on a Lean skeleton of Q-full's statement):
  FS114-CV-EXISTS, FS114-N2-ENDS, FS114-Y4-RSTOPALL, and (by the brief's standing) any K1 piece once filed; every other entry is `none — <reason>` (a
  relay-result, a statement about one printed object, a reduction, or superseded). No entry is handed to the kernel now: the class Q-full is not yet
  fixed in Lean (the plan's D6), and publication waits on the NO.
- **`plans/FS112-derivation.md`**: a dated section appended, "Errata and regrades appended at FS-114's close", seven notes — FS112-L60's erratum (the
  brief's item 67/74); C-ENDS's residue deleted; C-DOUBLE, C-PARTNERS and C-COMPOSE regraded to two minds; N3-BASE's regrade from BASE-V (upgrades only,
  Lemma 4 at cusps still one mind); Y3-T2-BUDGET's not-claimed answered; row 135's not-claimed line walked. The entries above it are untouched.
- **Not filed as entries, with the reason:** the tools-only quotation checks (every job's `*-QT`); FS114-Y6-HELD (a float survey, aiming only); N3-DR0
  (its conclusion is FS114-N4-D's, its proof a GAP — in FS114-N3-DR's not-claimed line); N6-MTP (its route a GAP; its conclusion is FS114-N2-AVG's, with
  NB6-FOLNER as the second mind); YB2-EMPTY13 (an instance of FS114-Y4-LUNE); the FS-112 confirmations (in the errata section, where the entries live).

## Stage 3 — SAVED

## Stage 4 — SAVED: the sweeps, and every registered prediction scored

### 4.1 §G re-read (the plan's §G part 3, fifteen extractions)

| # | extraction | paid? | how |
|---|---|---|---|
| 1 | card 2 reframed by compactness (G17, G29, G82) | **paid** | FS114-N114-COMPACT (two minds): the local/global question became explicitness — C114-LOCAL-F is C-LOCAL's explicit form, and the milestone's verdict is stated as its stall |
| 2 | the G15 architecture (an unavoidable set by a count × each member excluded locally) | **paid, and it is the milestone's shape** | route T's charge (N2-ENDS) named the deficient configurations; rounds 2–6 excluded them one by one, locally |
| 3 | Voronov's radius 3 | paid, as a negative | FS114-N114-VOR: closedness buys the band; Voronov cannot refute a valid map |
| 4 | the torus first (G68) | paid | every count ran on torus maps (17 exact, NB), then on discs of the plane (N2-AVG, NB6-FOLNER) |
| 5 | swaps (G71) | silent in outcome | no winding route was run; E16 not reached |
| 6 | no argument one class at a time (G24, G60) | held | route T's count reads all colours at once (absent-colour capacities), never one class |
| 7 | calibration (G20, G21) | paid | every new checker accepted the five controls first; plants fired; six registration misses named before re-registering |
| 8 | what a YES must carry (G22, G79) | paid | Y derived PENT before building; STRIPK6 and the K6 screen came from COR3; Y2's bowtie was designed from K1's killing test |
| 9 | read at the opening (G46, G49, G50) | partly | Mohar and Ágoston fetched and read in part; Sirgedas's thread `J_Tw1_hUxQI` read in part (a debt, carried) |
| 10 | the base (BASE-V) | not needed | BASE-V found no failing step; R0 did not run |
| 11 | which vertices (G83) | paid | E14 met: every decisive argument reads four-colour vertices |
| 12 | scope (rows 131, 133) | paid | every verdict states its class (reconciliation §2.6) |
| 13 | staffing and counting (G51) | paid | a divergence of truth in every round; three blind convergences between the sides |
| 14 | registrations (G21) | partly | several populations ended unreached (E7, E16, E19; N3's, N6's, N7's, L60's) — each named with both outcomes, but the verifiers that would have scored them did not run |
| 15 | form (G67) | the close's | the drafted G83 rewrite and G86 are in G67's form |

**An entry that should have borne and was used late: G79.** Rounds 2–5 each excluded one escape configuration — counterexample invariants, one per round
(DR, the Γ-ring bowtie, the pinwheel, E1/E2). The example invariant at the same vertex — what every four-colour vertex's ring carries — arrived only in
rounds 5–6: N6-RING60 (a (Q)-free ring has six 60° ring tiles), N7-HUB (its six change points are four-colour vertices). G79's *Do* ("when a wall hands
back a no-go, flip the wanted poster") applied at round 2's boundary would have asked for N7-HUB three rounds sooner. A drafted instance for §G79.
**A miss of method, G21's boundary form:** FS112-L60 carried two minds and a tool, and its plant sat at 50° while the claim's boundary was 60° (the L60
audit); a drafted instance for §G21.

### 4.2 §IQ, G72's count and G79's record

- **§IQ's structural form** asked for a datum at every vertex of `F ∪ R`, valid locally, whose plane average topology fixes. **Route T's charge is that
  datum** (candidates (a) and (c) merged: N2-ENDS's `n`, `n − 2`, `n`, `n + 6` from tactic edges, average zero by Euler), and it located six's room at a
  degree-4 four-colour vertex with three or four tactic edges — the target of rounds 2–6. Candidate (b), the (Q) skeleton, appears only as N7-HUB's
  hexagon reading (untested, one mind); E13 not met.
- **G72: through** — the milestone's product (the charge, K1, and its local exclusions) came through the structural question; CV-EXISTS came from the
  composition (a statement every map carries, found by re-deriving a chain end). **Twentieth; the count becomes seventeen of twenty.**
- **G79's record:** the headline reduction (CV-EXISTS: every valid map carries a four-colour vertex) and the count (every map's charge sums to zero) from
  **example invariants**; the six rounds' exclusions from **counterexample invariants** (what an escape at a deficient vertex must carry, then killed);
  the lead for C114-LOCAL-F (N7-HUB) an example invariant, reached late (4.1). No breakthrough of the second kind.

### 4.3 §PA — what the prior art says the object is

1. **Route T is Sirgedas's program** (the Google group, 2020–22): the count, the cover rule, the red blocks; FS-114's route-T results are "proofs not
   found in print" of statements he stated or aimed at (FS114-N2-FIVE, FS114-NB-DUAL, FS114-Y-EDGE, FS114-Y-REDBLOCK1, FS114-N2-ENC3). **Ágoston 2025**
   states the plane's nice case from his Lemma 7 and `3n − 6` — pure Euler: prior art for FS114-N114-CUBIC's shape.
2. **The rainbow deficit's types (A) and (B) are Gibbs's vertex-edge and vertex-vertex constraints** (`[09.11]`, `[09.28]`) and Mixon's (`[08.14]`), used as
   search rules in 2018; FS114-N114-RD makes them a lemma about every valid map.
3. **Kooshi's mass-transport lead** (item 79), checked: stationary hulls of valid maps of bounded complexity are unimodular and hyperfinite
   (`[AldousLyons2007]` Ex. 9.5), but **the simple hole-free class is not closed under hull limits** (NB6-MTP), so the printed route needs GAP-μ in the hull;
   the elementary disc average (NB6-FOLNER) suffices. A recognition about the object: limits of valid maps may pinch or open holes — it bears on FS-111's
   limit objects (placed in the successor stub, with a pointer for FS-111).
4. **Mixon's thread-7 question** ("What is the radius of the largest disk in $\mathbb{R}^2$ that can be 6-colored?") is C114-LOCAL-F's printed form; its
   lower side for maps with unit arcs is the disk's 2.1246 (a non-Siamese fragment, FS112-DISC's `φ` about a vertex); no upper side landed.
5. **De Grey's ladder** ("6 if tile-based, 7 if scaleable-non-Siamese-tile-based", `[17.5]`) separates non-Siamese from scaleable; FS-114 explains why the
   non-Siamese hypothesis is where counting lives: with Siamese pairs no density bound exists (N2-REFINE), so a tile count reaches the non-Siamese part
   only. **Promoted to a drafted grokking, G86.**

### 4.4 The plan's "conjecture" and "not claimed" hits

- "conjecture": one hit, G58 (the antipodal conjecture) in §G, verdict silent — **declined** (no bearing on FS-114; FS-55's stub holds it).
- "not claimed": the claim list's §7 — each already stubbed or declined: any value of `χ(ℝ²)` (declined: not a milestone's claim); unbounded complexity
  (FS-111's stub); boundaries other than segments and circular arcs (declined: the class is W-EQ-K's); FS-115's (b′), (b″), (c) (FS-115's stub,
  re-aimed at stage 5); C-HOCK (declined: FS-112 found no instance); `[Kainen1992]`'s robustness conjecture (declined: no bearing found); C-VOID (FS-109's
  stub).
- The derivation file's "not claimed" lines that name open work (E1's residues, S6, the wrap, OC, (Q)-rings, COVER-3, GAP-μ in the hull, N7-3T's blind
  check, Lemma 4 at cusps) are all placed in the successor stubs (stage 5).

### 4.5 Every registered prediction, scored

**The plan's E1–E19** (`plans/FS114-unit-arc-question.md` 5.3 and 5b):

| # | registered | p | outcome | score |
|---|---|---|---|---|
| E1 | card 2 chooses a local route over a count | 0.55 | FS114-N chose route T, the count, with local kills | **not met** |
| E2 | an explicit radius for C114-LOCAL-FR or -F | 0.15 | C114-LOCAL-F not landed (pieces at `√3` for one configuration family) | not met |
| E3 | GS-D decided at one mind | 0.2 | undecided | not met |
| E4 | a NO for doubly periodic maps at one mind | 0.3 | reduced to K1′ ∧ K2′ ∧ GAP-μ, non-Siamese only | not met |
| E5 | C114-THOM-TOP TRUE | 0.7 | TRUE with a colour-free repair, 2–1 (three minds) | **met** |
| E6 | C114-RAINBOW TRUE as stated | 0.5 | MISSTATED (four minds) | not met |
| E7 | C114-CURV's radius depends on `K` | 0.7 | the derived radius is `O(K²)`; no uniform radius excluded or found | **not reached** |
| E8 | CV confirms C-ENDS, C-COMPOSE, C-PARTNERS | 0.8 | confirmed | met |
| E9 | CV closes C-ENDS's residue; C114-EXISTS-F at two minds | 0.55 | residue empty; EXISTS-F two minds, blind to each other | met |
| E10 | C114-PENT admits the third unit-arc boundary | 0.3 | no (FS114-Y-PENT, two minds) | not met |
| E11 | a fragment about a four-colour vertex beyond `≈ 1.834`, by formula | 0.25 | the capped strip, to `φ²/√2 ≈ 1.8512` | **met** (marginally) |
| E12 | a YES by formula | 0.03 | none | not met |
| E13 | C114-SKELETON derived | 0.4 | not derived (N7-HUB's hexagon reading untested) | not met |
| E14 | the decisive argument reads `F ∪ R` | 0.8 | K1's exclusions and CV-EXISTS read four-colour vertices | met |
| E15 | a blind verifier finds a divergence of truth | 0.6 | one in every round (reconciliation §2.4) | met |
| E16 | G71's index survives the bowtie seam | 0.75 | the curves not built | **not reached** |
| E17 | a named obstruction or GAP as the product | 0.85 | GS-D stalls at C114-LOCAL-F; K1's open cases named | met |
| E18 | the non-Siamese case decided at one mind | 0.25 | reduced to K1′ ∧ K2′ ∧ GAP-μ | not met |
| E19 | Sirgedas's red-block statements hold as stated | 0.6 | first clause and "no pentagons" TRUE; "no quadrilateral" GAP; "only triangles" undecided | **not reached** |

**Brier score over the sixteen resolved: 2.136 / 16 = 0.134.** Seven met, nine not met; three unreached (E7, E16, E19). **Direction:** the misses are
the ambitious ones (E2, E3, E4, E18 — a NO, or its periodic or non-Siamese part, within one milestone) at p 0.15–0.3, so the planner priced them low and
they did not land: the counter-prior rule's miscalibration (pricing a theorem landing too high) did not appear here; E11, met at 0.25, is the one
construction priced low that landed. E1's miss is informative: the planner's print evidence (PA-A, every printed NO local) leaned local, and the proof side
chose the count — then spent five rounds on local kills the count located, so the milestone ran both, as G15's architecture says.

**The jobs' registrations:**

| job | registered | p | outcome | score |
|---|---|---|---|---|
| FS114-N3 | a valid fragment realising DR with `s′ = −30°` exists at radius `1 + ε` | 0.7 | Y2 built DR's degenerate member at `3√3/5`; the general member (`s′ = −30°`) was never built, and N4-G excludes it at `√3` | not reached |
| FS114-N4 | the bowtie with a Γ-arc lune ring is excluded by N4's three moves at `R ≤ 2` | 0.6 | excluded at `√3`, but needing the bends and N5-UP and NB5-RVKILL | split — met in conclusion, not in method (NB5) |
| FS114-N5 | (R-V) dies within radius 2 | 0.4 | dies at `√3` (NB5-RVKILL; RSTOPALL) | met |
| FS114-N6 | the (Q)-pinwheel dies within `√3` | 0.5 | `P_x` dies at `1 + ε` (Y5-PXKILL, outside E2); NB6-QSTART's residual open | not reached |
| FS114-N7 | OC dies within `√3` | 0.5 | not run | not reached |
| FS114-N7 | every (Q)-ring survivor has a 60° (Q) arc or one ending 60° from a tactic centre | 0.4 | not run | not reached |
| FS114-L60 | L60-P1: a blind mind finds no strict use in the chain | 0.85 | no blind mind ran | not reached |
| FS114-L60 | L60-P2: the inner clause and the clause split confirmed | 0.9 | no blind mind ran | not reached |
| FS114-CV | CV-P1–P3 | — | met (scored by CV) | met |
| FS114-CVB | CVB-P1–P5 | — | P1 missed (CV also took the short route), P2–P5 met (scored by CVB) | as scored |
| tools | every exact check at named values (Y3 11/11; Y4 19/19; Y5 31/31, 11/11; Y6 10/10; YB4 53/53; YB5 31/31; YB3 5/5 and 13/13) | — | met at its final registration; six registration misses (Y2 `wide_t1`; Y5 `g_away`; Y6 three; YB4 run 1's five probes and two plants; YB5 run 1's boundary probe; YB2 three controls), each named before re-registering | the rule held |

**What unreached registrations say:** five of the jobs' eight probabilistic registrations were never scored because the mind that would score them did
not run (round 7 was cut; no blind check of L60 was spent). They carry to the successor stub, where round 7's queue scores N7's two.

## Stage 4 — SAVED

## Stage 5 — SAVED: the successor stubs and the bearing lines

- **FS-116, the local exclusion** — `plans/STUB-local-exclusion.md` (new): C114-LOCAL-F, the whole NO given FS114-CV-EXISTS; opens with round 7's queue in
  the coordinator's order (a blind check of FS114-N7-3T, N7-HUB (b) first; the wrap lemma; OC; the rings with (Q) arcs, beginning with the R-E2/E2
  comparison of stage 2 §2.5), then E1's residues, S6, non-simple bowties, the Reuleaux `(2, 1, 1, 0)` on (Q) rings; beyond K1, four-colour vertices with at
  most two tactic edges and degree ≥ 5, with N7-HUB's hexagon lead; the owed second minds (N3-LOCAL's four lemmas, N7-3T, YB5's cut to S6, L60-WALK, and
  row 134's Lemma 4 at cusps before any publication); construction targets; debts; D6.
- **FS-117, route T's count** — `plans/STUB-route-t-count.md` (new): K2′, GAP-μ (with its hull form from NB6-MTP, and a pointer for FS-111's limits),
  COVER-3, Sirgedas's metagraph, the torus design; partial by theorem (G86).
- **FS-118 and FS-119: not minted, skipped** (never reused). The second mind on row 134's Lemma 4 at cusps (inventory item 14) is a job, not a
  milestone: it is placed in FS-116's owed list, where anything final waits on it.
- **Placement of the inventory's stub items**: 8 → `plans/STUB-stuck-ray.md`'s bearing line (re-aimed by CV-EXISTS); 14 → FS-116 owed list; 28 → FS-116
  construction targets (curve pair carried; RAINBOW (ii) done; torus skeleton to FS-117; the 60° ring aim carried); 42 → K1 to FS-116, K2-loc declined
  (moot), SIAM-KILL declined (subsumed), COVER-3 to FS-117; 55 → K1′ in FS-116 and FS-117, K2′ in FS-117; 64 → declined (run in rounds 4–6); 69 →
  K1-ΓRING declined (closed at `√3`), K1-PIN's remainders to FS-116; 91, 101 → FS-116 (K1-PINQ residual, OC) and FS-117 (MTP's hull form).
- **Bearing lines written**: `plans/STUB-stuck-ray.md` (a dated paragraph under § Bearing on the answer, and its provisional-bearings line; item 78's
  FS-111 link named for Poros, FS-111's clause left to FS111-C); `plans/STUB-global-step.md` (a dated "At FS-114's close" paragraph before § What FS-112
  established, and l. 47's FS112-L60 sentence corrected in place with a dated note, inventory item 74). **No other open stub's bearing line is written:**
  the drafted G86 fires on tile-count arguments, which no other open stub runs (FS-109 traces holes along eroded tilings as a dial); the G83 rewrite bears
  on FS-111, whose stub FS111-C is closing now — the pointer is in FS-117's GAP-μ line and in the drafts.

## Stage 5 — SAVED

## Stage 6 — the drafts, and the report

## Drafts for the front page

*Each draft is written to be filed as it stands. Numbers: ledger rows 137–138 (the brief's); grokking G86 (G84–G85 are FS-111's); stubs FS-116 and
FS-117 written directly (stage 5), FS-118 and FS-119 unused and skipped. Where FS-111's clause belongs in a shared unit, the marker ‹FS-111› stands.*

### `LEDGER.md` — § A, rows 137–138 (to append after row 136)

| 137 | **With unit arcs, the six-map question is local: every locally finite map of the plane bounded by segments and circular arcs, arcs of radius 1 allowed, whose six-colouring puts no two interior points of one colour at distance exactly 1, has a vertex of at least four colours — in the map itself, with no ray step and no residue. So S–V's Question 2 with unit arcs is one local statement: its NO is exactly an explicit radius about a vertex of at least four colours within which no such map fragment exists, Siamese pairs included, and by the capped strip any such radius exceeds `φ²/√2 ≈ 1.8512` (row 138). The count on the map graph — Sirgedas's program, made exact — gives the other view: on a torus map with no Siamese pair a charge of `n`, `n − 2`, `n`, `n + 6` at vertices of degree 3–6 (`n` the edges that are not unit arcs about four-colour vertices at distance 1) sums to zero, it averages on discs of the plane at every complexity, and it is negative only at a degree-4 four-colour vertex with three or four such edges; with Siamese pairs no density bound exists, so the count reaches the non-Siamese part only. On the way: the five-colour count closes (maps need six, by counting); Thomassen's topological steps hold for every such map, and his argument fails only at the rainbow step; FS-112's chain-end residue is empty; FS112-L60 is false at exactly 60° and holds as "at most 60°", the chain intact. It moves no value** (FS-114; FS114-CV-EXISTS, CV-HD, N2-ENDS, N2-AVG, N2-FIVE, N114-RD, CVB-THOM, L60-LE and the rest of § B). **[hand; CV-EXISTS two minds, blind to each other (CV; CVB), over FS112-N3-DENSE3 and row 134's base, whose Lemma 4 at cusps is still one mind (BASE-V regraded the rest upward); the count's lemmas two minds, one blind (N, N2; NB), N2-ENDS's exact identity one mind with tools; the averaging two minds (N2; NB6, blind); C114-THOM-TOP three minds, decided 2–1; L60's correction two minds (N4; L60), its walk one mind]** Mechanism: a four-colour vertex is where the unit-radius tactic lives, and in a map with none every stuck chain of the terminal modification is bi-infinite, which N4-FIN forbids; a six-colouring pays for a tile's neighbours beyond five with repeated colours, each a unit arc about a four-colour vertex or a Siamese pair, and Euler's formula leaves room only at degree-4 four-colour vertices. **Not claimed:** the NO; an explicit radius (C114-LOCAL-F, FS-116); the non-Siamese NO (route T GAP at K1′ ∧ K2′ ∧ GAP-μ, FS-117); anything at a fixed complexity alone. **Prior art:** not found in print (FS-114's gate); route T's count, cover rule and red blocks are Sirgedas's program (the Google group, 2020–22, stated without proofs); the plane's nice case by pure Euler is Ágoston 2025's (`[Agoston2025]`); the rainbow deficit's two types are Gibbs's and Mixon's search constraints (`[Polymath16threads]` `[09.11]`, `[09.28]`, `[08.14]`). | `plans/FS114-derivation.md` §§1–2, 5; `plans/FS114-CV-verification.md`; `plans/FS114-CVB-verification.md`; `plans/FS114-N-proof.md`; `plans/FS114-NB-verification.md`; `plans/FS114-L60-audit.md`; `plans/BASE-V-verification.md`; `tools/fs114_n2_count.py`, `tools/fs114_nb_count.py`, `tools/fs114_l60_check.py` | FS-114 (2026-09-28) |
| 138 | **Where the count gives six room, the configurations die locally, and both printed positives are part of no six-map with unit arcs. At a degree-4 four-colour vertex with four edges that are unit arcs about four-colour vertices at distance 1: two width-1 Reuleaux triangles corner to corner (the bowtie) fit a closed disc of radius `3√3/5` exactly (a 20-tile fragment over ℚ(√3), built independently twice) and no disc of radius `√3`, whatever the colouring near their lunes (two independent derivations); four such edges turning one way (the pinwheel) die within `1 + ε` of the vertex except when an edge is exactly 60° long or a blade's side is a unit arc about its own edge's end, and those two exceptions reduce to named shapes (the first forces a second 60° arc under a Reuleaux cap; the second leaves one cone family); three or more such edges die at `1 + ε` on rings carrying no unit arc about the vertex with both side colours there, except one open-cap family. The strip's six tiles at a valley and the disk's pentagon skeleton are part of no valid map under any colouring, and each geometry has one colouring; the strip capped by unit arcs holds every disc of radius below `φ²/√2` about a four-colour vertex. Every kill is a straddle: two tiles of one colour forced along two unit circles to come within 1, seen at second order. It moves no value** (FS-114; FS114-Y4-RSTOPALL, N4-D, N5-GRING, Y2-BOWTIE, Y5-PINALL, N6-NOQ, Y6-E1CAP, Y6-E2RED, N7-3T, Y-DIAL, Y-PENT, Y-STRIPK6 and the rest of § B). **[hand and tools, exact; RSTOPALL two minds, one blind (Y4; YB3), and the proof side's chain (N4, N5, NB5) independent of both, its last step one mind; the bowtie fragment two independent objects, two checkers; the pinwheel two minds, one blind, on each side (Y5; YB4 — N6; NB6); E1CAP two minds with its λ clause a GAP (the wrap), E2's cut to one family one mind (YB5); N7-3T one mind; the printed geometries two minds, one blind (Y; YB)]** Mechanism: at a vertex with such edges every tile's cone and colour is pinned by the half-planes facing the edges' centres (N-E2's cone form), and a configuration that needs one colour on both sides of a point where two unit circles meet tangentially has no colour left. **Not claimed:** K1 (GAP at rings with (Q) arcs, the first exception's residues, the second's surviving family, the wrap, the open-cap family, non-simple bowties); four-colour vertices with at most two such edges or of degree ≥ 5; Siamese maps (every exclusion here is non-Siamese and simple); a YES. **Prior art:** not found in print (FS-114's gate); the strip is `[AxenovichEtAl2014]`'s and the disk `[Polymath2021]`'s (Gibbs's); the slack form of the partner lemma is de Grey's (`[Polymath16threads]` `[17.282]`). | `plans/FS114-derivation.md` §§3–4; `plans/FS114-Y2-construction.md` … `plans/FS114-Y6-construction.md`; `plans/FS114-N3-proof.md` … `plans/FS114-N7-proof.md`; the verifiers `plans/FS114-NB4-verification.md` … `-NB6-`, `-YB-` … `-YB5-verification.md`; `tools/fs114_y2_k1.py`, `tools/fs114_y4_diag.py`, `tools/fs114_y5_px.py`, `tools/fs114_nb5_check.py`, `tools/fs114_yb4_pin.py` | FS-114 (2026-09-28) |

### `LEDGER.md` — § B, 49 lines (to append after FS-112's)

**The block is `data/fs114/fs114-c/ledger-b-draft.md`, verbatim** (committed with this stage; 46 entries, one line each, the three stalled or gapped
entries included because the census counts them). **The census:** `python3 tools/fs71_ledger_b_check.py --strict` (TB1's version, commit 95efed69) on
a scratch copy of the repository with this block appended to `LEDGER.md`: **exit 0, "RESULT: PASS", "LEDGER § B rows: 1049"** with FS-111's
not-yet-filed `plans/FS111-derivation.md` left out of the copy (output `data/fs114/fs114-c/ledger-check-strict.out`); with it in, exit 1, all 85
failures FS-111's unfiled entries, none FS-114's. The first run found three FAILs of mine (the gapped entries FS114-ROUTE-T, -GSD, -K1 had no line),
fixed by adding their lines.

### `LEDGER.md` — corrections owed to existing rows and lines

- **Row 134's grade bracket** (inventory item 12, upgrades only): insert before its closing "]**": "; re-derived blind at FS-114 by BASE-V (`plans/BASE-V-verification.md`): S–V Lemma 5 and Prop. 18 (a third mind, with CB and CD), Lemma 3 and Cor. 3 at cusps, and D5 item 5 in substance under H with unit arcs (BV-HEX) — D5 items 1–4 and 6 (Lemma 4 at cusps) stay one mind". The Proof Atlas's "under blind check" ring on row 134 is stale (item 15).
- **Row 135:** in its statement, "(the close's assembly, one mind, bar one named residue at such single vertices)" → "(the close's assembly; the residue closed at FS-114, two minds)"; in its grade bracket, "over row 134's base at its grade, unre-derived here — S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE — where a common error of both walks would sit" → "over row 134's base, re-derived by BASE-V at FS-114 but for Lemma 4 at cusps (CUSP-BASE's D5 items 1–4, 6, one mind), where a common error would now sit", "the composition, C-ENDS and C-PARTNERS one mind (FS112-C)" → "the composition, C-ENDS (its residue empty) and C-PARTNERS two minds (FS112-C; FS114-CV, blind)", and "C-HORNEND and C-DOUBLE one mind (FS112-C2)" → "C-HORNEND one mind (FS112-C2); C-DOUBLE two minds (FS112-C2; FS114-CV)"; in its **Not claimed**, delete "a chain end at a unit arc bounding one horn only" (walked: FS114-CV-HD). *The Proof Atlas's N3BASE node quotes the old grade clause; its quotation moves with the row.*
- **§ B, l. 1144, FS112-L60:** "a unit arc with constant sides is shorter than 60°" → "a unit arc with constant sides is at most 60° long (filed as "shorter than 60°", false at exactly 60°; corrected at FS-114's close, FS114-L60-LE)"; grade → "hand; the corrected bound two minds: N4; L60; the strict form refuted".
- **§ B, FS112-N3-BASE:** grade "…; over row 134's base unre-derived" → "…; over row 134's base, re-derived by BASE-V but for Lemma 4 at cusps".
- **§ B, FS112-C-ENDS:** "… has ≥ 4 colours, bar one residue at one-vertex chains (not all four horn arcs unit, an R2 bound)" → "… has ≥ 4 colours (its residue empty: FS114-CV-HD)"; grade → "hand; two minds: FS112-C, repaired by FS112-C2; FS114-CV and FS114-CVB, blind".
- **§ B, FS112-C-PARTNERS:** grade → "hand; two minds: FS112-C; FS114-CV, blind, over N3-COR3; the count two minds: Y3; YB3". **FS112-C-DOUBLE:** grade → "hand; two minds: FS112-C2, a sketch; FS114-CV, blind".
- **§ B, every FS-112 line whose kernel column reads "stub (FS-114)"** → "stub (FS-116)" (D6 still held; `plans/FS112-derivation.md` § Errata item 8).

### `CLAUDE.md` — the shared units, the grokkings, and the corrections (net **+1,878 bytes**, the markers counted as written)

*Generated and checked by `data/fs114/fs114-c/claude_md_units.py` (run from the repository root: each old unit is found exactly once in `CLAUDE.md` at
288,911 bytes; `--emit` prints the pairs below). G86 follows G83 directly, before G51. The "Where the problem stands" item 31 and the three other
shared units carry ‹FS-111› where FS-111's clause belongs.*
#### last: replace (verbatim, the whole unit)

```text
*Last updated: 2026-09-27 — **FS-112, the unit-arc half, closed undecided** (rows 135–136; `plans/FS112-unit-arc-half.md` §R-close): the NO
reduced to four-colour and repeated-colour vertices (row 135), the YES stalled where the printed positives stop (row 136); its gaps are FS-114 and
FS-115. Before it, **FS-110** (row 134), **FS-107** (row 133) and **the reframe** (Kooshi,
2026-09-26): the aim is the answer, formalized in Lean (§ The aim). **No finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain).
Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*
```

with

```text
*Last updated: 2026-09-28 — **FS-114, the unit-arc question, closed undecided** (rows 137–138; `plans/FS114-C-close.md`): every six-map with
unit arcs has a four-colour vertex, so the NO is one exclusion at an explicit radius about such a vertex (row 137), and where the count gives six room
the configurations die locally but for named cases (row 138); its successors are FS-116 and FS-117. ‹FS-111› Before them, **FS-112** (rows 135–136),
**FS-110** (row 134), **FS-107** (row 133) and **the reframe** (Kooshi, 2026-09-26): the aim is the answer, formalized in Lean (§ The aim). **No
finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*
```

#### open: replace (verbatim, the whole unit)

```text
**Open milestones, in order.** **None is open.** FS-112, the unit-arc half (`plans/STUB-unit-arc-half.md`), is **closed undecided** (rows 135–136;
`plans/FS112-unit-arc-half.md` §R-close). **Next: FS-114, the unit-arc question, then FS-111, the cone scale** (`plans/STUB-global-step.md`, `plans/STUB-reg-scale.md`), beside BASE-V's blind re-derivation of row 134's print steps; FS-115 waits for FS-114's plan (NIGHT-A on Kooshi's deferral, `plans/POROS-2026-09-27-night-aim.md` §1); the finite-witness-free week runs to 2026-10-01 (§ Toolchain).
**M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list.
```

with

```text
**Open milestones, in order.** **None is open.** FS-114, the unit-arc question (`plans/STUB-global-step.md`), is **closed undecided** (rows 137–138;
`plans/FS114-C-close.md`), with BASE-V beside it (row 134's base re-derived but for Lemma 4 at cusps). ‹FS-111› **Next: Poros's re-rank**
(`plans/FRONTIER-STUBS.md`); FS-114's successors are **FS-116, the local exclusion** (`plans/STUB-local-exclusion.md`, opening with round 7's queue) and
**FS-117, route T's count** (`plans/STUB-route-t-count.md`); FS-115 bears only on the four-colour density form (row 137); the finite-witness-free week
runs to 2026-10-01 (§ Toolchain). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close:
`plans/FRONTIER-STUBS.md`'s closed list.
```

#### prog: replace (verbatim, the whole unit)

```text
**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half — closed** (rows 131–132); **FS-107, stability — closed** (row 133):
Voronov's contradiction survives a free colour if a complementary junction pair is forced at a scale bounded below, and vanishing holes at bounded
complexity are a tight six-map; **FS-110, the tangency seam — closed** (row 134: none under Condition 5); **FS-112, the unit-arc half — closed** (rows 135–136); **FS-114, the unit-arc question**; **FS-115, the stuck ray**;
**FS-111, the cone scale** — the same at unbounded complexity; **Lean throughout** — MR in full (Einsiedler–Lindenstrauss, Einsiedler–Fish), the
collapse, the measurable chain, the map argument.
```

with

```text
**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half — closed** (rows 131–132); **FS-107, stability — closed** (row 133):
Voronov's contradiction survives a free colour if a complementary junction pair is forced at a scale bounded below, and vanishing holes at bounded
complexity are a tight six-map; **FS-110, the tangency seam — closed** (row 134: none under Condition 5); **FS-112, the unit-arc half — closed** (rows 135–136);
**FS-114, the unit-arc question — closed** (rows 137–138: the NO is one local exclusion about a four-colour vertex); **FS-116, the local exclusion**;
**FS-117, route T's count** (the non-Siamese part); **FS-115, the stuck ray** (the density form only); ‹FS-111› **Lean throughout** — MR in full
(Einsiedler–Lindenstrauss, Einsiedler–Fish), the collapse, the measurable chain, the map argument.
```

#### i31: replace (verbatim, the whole unit)

```text
31. **The regularity wall, verified; the question is stability; at bounded complexity, four-colour vertices** (§ The aim; rows 131–136;
   FS-114, FS-115, FS-111). Regular classes need seven almost everywhere — slack, polygons, convex tilings, nice maps — and maps six; closed
   classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map
   exists (row 133): under Condition 5 none does (row 134); with unit arcs each would have a vertex of four colours or a repeated colour within 3 of
   every point, and both printed positives stop where a second four-colour vertex is missing (rows 135–136). Past it, whether junctions keep a cone scale.
   Bearing on the answer: none moved; half of door (A) closed, the other half reduced.
```

with

```text
31. **The regularity wall, verified; the question is stability; at bounded complexity, one four-colour vertex** (§ The aim; rows 131–138;
   FS-116, FS-117, ‹FS-111›). Regular classes need seven almost everywhere — slack, polygons, convex tilings, nice maps — and maps six; closed
   classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map
   exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a vertex of at least four colours (rows 135, 137), so the NO is one
   exclusion at an explicit radius, above `φ²/√2`, about such a vertex; where the count gives six room the configurations die at `√3` or `1 + ε` but for
   named cases, and both printed positives are part of no such map (rows 136, 138). ‹FS-111›
   Bearing on the answer: none moved; half of door (A) closed, the other half one local statement.
```

#### g83: replace (verbatim, the whole unit)

```text
* **G83 — With unit arcs, the tight question lives at four-colour vertices. [hand, two minds, one blind (rows 135–136); the reading one mind]**
  The unit-radius tactic survives reduction only at vertices of four or more colours; the base refutes a map around any cubic trichromatic vertex
  lacking a four-colour or repeated-colour vertex within 2; a close complementary pair sits on a unit rhombus with four-colour corners — and both printed
  positives stop exactly where a pair's second corner is missing. *Reading:* the unit-arc half is a placement problem for four-colour vertices, a
  discrete one (Sirgedas's quads); killing test: FS-114 decided by an argument that reads no such vertex. *Do: when a tight-map question admits unit
  arcs, list its four-colour and repeated-colour vertices first and read each close complementary pair's two rhombus corners — a construction that
  saves one has found its stop. Nothing kills the theorems but a defect in row 134's base; they forbid a valid map with unit arcs having a disc of
  radius 3 with no such vertex.*
```

with

```text
* **G83 — With unit arcs, the tight question lives at one four-colour vertex. [hand, two minds, one blind (rows 135–138); the reading one mind]**
  The unit-radius tactic survives reduction only at vertices of four or more colours, and every valid map has one (row 137, two minds blind to each
  other), so the NO is an exclusion at an explicit radius about a single such vertex; the count (route T) gives six room only at degree-4 four-colour
  vertices with three or four tactic edges, and every such configuration examined died by a straddle — two tiles of one colour forced along two unit
  circles to come within 1 — at `√3` or `1 + ε` (row 138). *Reading:* what is left is four-colour vertices whose rings carry (Q) arcs, the class every
  exclusion so far had to except; killing test: a valid fragment by formula about such a vertex beyond `φ²/√2`. *Do: when a tight-map question admits
  unit arcs, take one four-colour vertex and ask what its ring carries (a (Q)-free ring's change points are four-colour vertices, N7-HUB) before
  excluding its next escape, and hunt the straddle along two unit circles. Nothing kills the theorems but a defect in row 134's base; they forbid a
  valid map with unit arcs and no four-colour vertex.*
* **G86 — Tile counts are blind to Siamese pairs: a count reaches the non-Siamese part, and a Siamese kill reads points and distances. [hand, one mind
  (FS114-N2, row 137); the reading one mind]** Euler's formula fixes a map's average number of neighbours, and a six-colouring pays for neighbours beyond
  five with repeated colours — a unit arc about a four-colour vertex, or a Siamese pair (tiles of one colour within each other's exclusion annulus).
  Where Siamese pairs are allowed a tile can be cut into any two-colour map, so no density bound exists and a Siamese vertex pays its demand at no cost:
  no count over tiles charges it (N2-REFINE). So a count gives the non-Siamese NO at best — de Grey's target (`[16.317]`), Thomassen's theorem without
  scalability — and the whole NO must be a local exclusion reading distances between points of colour classes. *Do: before a counting or discharging
  route to a map-colouring NO, ask whether the class allows Siamese pairs; if it does, put "non-Siamese" in the count's headline and aim the rest at a
  distance argument. Nothing kills the refinement lemma; it forbids a tile-count proof of a NO for a class with Siamese pairs.*
```

#### g72: replace (verbatim, the whole unit)

```text
**The count so far — sixteen of nineteen** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-112, through: §IQ's per-centre question gave the reduction to four-colour vertices).
```

with

```text
**The count so far — seventeen of twenty** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-114, through: §IQ's per-vertex datum is route T's charge, which set FS-114's targets).
```

#### rows: replace (verbatim, the whole unit)

```text
**Rows 1–136 live in `LEDGER.md`**
```

with

```text
**Rows 1–‹last› live in `LEDGER.md`**
```

### `plans/GROKKING-INSTANCES.md` — new instances (each with its source)

- **§G21**, after its last instance: *FS114-C, FS-114's close (`plans/FS114-C-close.md` stage 4.1):* FS-114: FS112-L60 ("below 60°") stood on two minds,
  one blind, and a tool, and was false at exactly 60° — the frozen tools' plant sat at 50°, and their check computed a pair the equality tile never
  contains; the proof side found it by meeting the tile the bound excludes, the Reuleaux cap over a 60° arc (`plans/FS114-N4-proof.md` §2.6), and the
  audit found that both printed proofs break at the boundary, by different steps (`plans/FS114-L60-audit.md` §1.3). **A boundary claim needs a plant at the
  boundary, not only on each side of it.**
- **§G51**, after its last instance: *FS114-C, FS-114's close (stage 2 §2.1):* FS-114: six rounds of a proof side against a construction side, fenced
  from each other, with routes never relayed mid-round (inventory items 50, 57, 87); three blind convergences — the proof side's escape DR was the
  construction side's bowtie; both sides reached `√3` by different routes; the proof side's residual (R-V) had the construction side's escape E2's shape
  and was excluded by RSTOPALL, blind to NB5's own kill — each a second derivation a relay would have spent; and a divergence of truth in every round,
  21 in all, each settled for the second mind or by a third (C114-THOM-TOP, 2–1).
- **§G72**, after the nineteenth: *FS114-C, FS-114's close (stage 4.2):* Twentieth, FS-114: through — §IQ's per-vertex datum is route T's charge (FS114-N2-ENDS),
  which located six's room at degree-4 four-colour vertices with three or four tactic edges and set rounds 2–6's targets; FS114-CV-EXISTS came from
  re-deriving the composition's chain end.
- **§G79**, after FS-110's: *FS114-C, FS-114's close (stage 4.2):* FS-114: the headline (every valid map carries a four-colour vertex) and the count (every map's
  charge sums to zero) from example invariants; the six rounds' kills from counterexample invariants — what an escape at a deficient vertex must carry
  (DR, the Γ-ring bowtie, the pinwheel, E1, E2, OC), each then killed; the flip ran late: the example invariant at the same vertex — what every
  four-colour vertex's ring carries (N6-RING60, N7-HUB) — arrived in rounds 5–6 and is FS-116's lead. No breakthrough of the second kind.

### `BIBLIOGRAPHY.md` — rows (§ A form: key | work | what of ours rests on it | copy | read)

| **[Mohar2002]** | B. Mohar, *Light structures in infinite planar graphs without the strong isoperimetric property*, Trans. Amer. Math. Soc. 354(8) (2002) 3059–3074, Zbl 0996.05031 | nothing: discharging on infinite planar graphs of subexponential growth, named at FS-114's gate as route T's aperiodic tool; the step closed by averaging on discs instead (FS114-N2-AVG) | `~/source/library/pdf/` (fetched by FS114-N) | §§1–3 (FS114-N); §§1–2 (FS114-Y); the reviewer's review at the gate (FS114-P); the rest not read |
| **[Higuchi2001]** | Y. Higuchi, *Combinatorial curvature for planar graphs*, J. Graph Theory 38(4) (2001) 220–229, Zbl 0996.05041 | nothing: names route T's discipline (combinatorial curvature of infinite planar graphs) | not held | the author's summary only (a claim; FS114-P) |
| **[Agoston2025]** | P. Ágoston, *A lower bound on the number of colours needed to nicely colour a sphere*, Discrete Comput. Geom. 74(3) (2025) 691–718, Zbl 1580.05061; arXiv:2404.14398 (v2) | prior art for FS114-N114-CUBIC's shape: the plane's nice case from his Lemma 7 and `3n − 6`, pure Euler (row 137) | `~/source/library/pdf/` (arXiv v2, fetched by FS114-N) | §§1–2 in outline (FS114-N); §1 to §2.1's opening (FS114-Y); Lemma 7's proof not read |
| **[AxenovichLiuSagdeev2025]** | Axenovich, Liu and Sagdeev (first names not checked), arXiv:2512.15516 (2025), on Euclidean Ramsey problems for unit copies of a graph | nothing: the one work Semantic Scholar lists as citing `[SokolovVoronov2025]`; off topic | not held | abstract only (FS114-P) |
| **[AldousLyons2007]** | D. Aldous, R. Lyons, *Processes on unimodular random networks*, Electron. J. Probab. 12, Paper 54 (2007), 1454–1508; arXiv:math/0603062 (v6) (venue checked on the PDF by FS114-NB6) | FS114-N6's mass-transport route (Ex. 9.5: the Palm version of an isometry-invariant embedded graph is unimodular); the route needs GAP-μ in the hull (NB6-MTP), and the conclusion rests on FS114-N2-AVG instead | `~/source/library/pdf/arXiv-math-0603062-aldous-lyons-processes-on-unimodular-random-networks.pdf` | Def. 2.1 and Ex. 9.5 (FS114-N6); Thm 8.5's statement and the first half of Ex. 9.5's proof (FS114-NB6); the rest not read |
| **[AngelHutchcroftNachmiasRay2018]** | O. Angel, T. Hutchcroft, A. Nachmias, G. Ray, *Hyperbolic and parabolic unimodular random maps*, arXiv:1612.08693 (v2); venue as recalled GAFA 28 (2018), not checked | as `[AldousLyons2007]` (Thm 1, the Dichotomy Theorem; Thm 3.4) | `~/source/library/pdf/arXiv-1612.08693-angel-hutchcroft-nachmias-ray-hyperbolic-parabolic-unimodular-maps.pdf` | abstract; §1 to Thm 1; §§2.1–2.2; §§3.2–3.3; §4's opening; Ex. 4.3's proof; Ex. 4.11 (FS114-N6, FS114-NB6); the rest not read |
| **[BenjaminiSchramm2001]** | I. Benjamini, O. Schramm, *Recurrence of distributional limits of finite planar graphs*, arXiv:math/0011019 (venue not checked) | nothing: named in Kooshi's lead (inventory item 79); not about Euler counts | `~/source/library/pdf/arXiv-math-0011019-benjamini-schramm-recurrence-distributional-limits.pdf` | abstract, §§1.1–1.2 (FS114-N6) |

**§ A′ (alternate keys):** `| [AHNR2018] | **[AngelHutchcroftNachmiasRay2018]** | the short key FS114-N6 and FS114-NB6 used |`.
**Edits to existing rows:** `[Oostema2020]` — last page **389** (the publisher's page, doi 10.29007/btmj, reads "pages 373-389"; OpenAlex's 355 is its
record's defect; FS114-P). `[Sirgedas2021]` — read: pp. 1–11 and 13 (FS114-Y); its stitch is a seven-colour device. `[Thomassen1999]` — page images not
held, OCR only (FS114-CVB). `[Polymath16threads]` — add: thread 7's disk question (Mixon, 2018-06-16, "What is the radius of the largest disk in
$\mathbb{R}^2$ that can be 6-colored?"), the local form of C114-LOCAL-F; thread 16's non-Siamese search (de Grey, 2020-05-27); `[09.11]`, `[09.28]`
(Gibbs's "vertex-edge" and "vertex-vertex constraints") and `[08.14]` (Mixon) as prior art in words for FS114-N114-RD's two types, as search rules
(FS114-NB §1.2 item 1). **The Google group row** (`~/source/library/hadwiger-nelson-problem-group/`): archived 2026-09-27 with no browser profile
(`tools/fetch_hn_google_group.py`: all 11 conversations, message counts matching, 2 attachments); read: `Z50mmulkXCQ` in full (FS114-P, FS114-Y);
`J_Tw1_hUxQI` in part (FS114-P: ll. 1–40, 589–770, 885–945, 4150–4200, 4455–4545 and greps; about 4,300 lines unread); nine other threads by title;
attachments unopened; the HNT simulator thread `a701Kwnhp_A` (`[Parts2023]`'s [9]) to be checked against the archive — the inventory calls it unheld.
With these rows `tools/bib_audit.py`'s FS-114 failures (the four arXiv ids and six keys the brief lists) resolve; its FS-111 failures are FS111-C's.

### `data/fs114/claims.md` — corrections at the close (to append as its § 9; the list is frozen and Keryx's)

- **C114-RAINBOW: MISSTATED** (four minds). Corrected: "Siamese, or the unit-radius tactic (one face shares a unit arc of `ω(q)` with `x`, the other meets
  `cl x` only at `q`), or both meet `cl x` only in finite sets at mutual distance exactly 1" (FS114-YB §1c item 10; = FS114-N114-RD read on contact sets).
- **C114-DUAL-COUNT: MISSTATED.** Corrected (FS114-NB-DUAL, two minds, both blind): at least `2F + 2V₅ + 6V₆` of the `2.5F` edges are unit arcs — at least
  80 %, exactly `2n` iff no vertex has degree 5 or 6. FS114-Y's "TRUE as stated" an over-grade.
- **C114-FIVE-COUNT: TRUE** (FS114-N2-FIVE, two minds). **C114-EDGE-RAINBOW: TRUE** (four minds). **C114-THOM-TOP: TRUE with a colour-free repair**
  (three minds, 2–1). **C114-VOR:** fails at C-CS-1 (c) (two minds). **C114-COMPACT: TRUE for every `K`**; not at a fixed `K` read as "≤ `K` tiles per unit
  disc" (two minds). **C114-CURV: TRUE at each `K`**, `R₀ = O(K²)`; a uniform radius a reading. **C114-REDBLOCK:** first clause and "no pentagons" TRUE;
  "no quadrilateral" GAP; "only triangles" undecided. **C114-ENCLOSED3: GAP** (it implies COVER-3). **C114-PENT: no** (two minds); its second question
  answered at named points (FS114-Y-ROUTES). **C114-DIAL: met** (FS114-Y-DIAL). **C114-TORUS:** F1, F2 excluded; F3 undecided. **C114-SIRGEDAS-FORM:** not
  landed; its gloss "no Siamese pair (every vertex of `R(M)` absent)" is one-way — no Siamese pair implies no vertex of `R(M)`, not conversely (FS114-YB).
- **C114-EXISTS-F: TRUE, with no residue** (FS114-CV-EXISTS, two minds blind to each other). **GS-1:** delete "outside FS112-C-ENDS's named residue" and
  "the terminal modification" (every valid map itself has the vertex). **C114-LOCAL-F: GAP** — and its lower bound "`√15/4 + √3/2 ≈ 1.834`" → "`φ²/√2 ≈
  1.8512`" (FS114-Y-DIAL, two minds). **C114-LOCAL-FR:** not needed (C114-LOCAL-F alone is the NO). **GS-D:** stalls at C114-LOCAL-F.
- **Route T:** K1 GAP (at the named cases of FS114-K1); K2-loc moot (its content is K2′); GAP-μ stands; SIAM-KILL subsumed by C114-LOCAL-F. **C114-SKELETON:**
  not derived. **C114-BUDGET:** route T's charge (FS114-N2-ENDS) is non-negative at every vertex type but a degree-4 vertex with at least three tactic
  edges — named.

### `CLOSED-QUESTIONS.md` — declined

Nothing FS-114 holds answers a question the literature posed. The reduction to C114-LOCAL-F is partial for `[SokolovVoronov2025]` Question 2's unit-arc
half and for `[Polymath2021]` p. 199's hope; no explicit radius landed for Mixon's thread-7 question's upper side; the non-Siamese case (de Grey's
`[16.317]`) is reduced, not decided; the five-colour count by counting is a known value (row 132, `[Woodall1973]`).

### `plans/STUB-global-step.md` — the closed banner (to insert under its title line)

> **CLOSED 2026-09-28 — undecided** (FS-114; `plans/FS114-C-close.md`; `LEDGER.md` rows 137–138). Every valid map has a vertex of at least four
> colours, so the NO is one local statement, C114-LOCAL-F (an explicit radius about such a vertex). Successors: FS-116, the local exclusion
> (`plans/STUB-local-exclusion.md`), and FS-117, route T's count (`plans/STUB-route-t-count.md`). This stub stays as the record of the question as posed.

### `tools/viz_proof_atlas_facts.py` — entries (drafted; every quotation is from a drafted row or line above, so the checker runs after the filing)

```python
# ---- FS-114, the unit-arc question: closed undecided (rows 137–138); successors FS-116 (the local exclusion) and FS-117 (route T's count)
LSTUB = STUB("STUB-local-exclusion.md")
TSTUB = STUB("STUB-route-t-count.md")
N("CVEXISTS", "CV-EXISTS", "held", "Every six-map with unit arcs has a vertex of at least four colours, in the map itself. So the unit-arc NO is "
  "one local statement about one such vertex, Siamese pairs included, with no step about stuck rays.", B("FS114-CV-EXISTS"),
  "every valid map with unit arcs has a vertex of at least four colours, in the map itself",
  "hand; two minds, blind to each other: CV; CVB, by different routes; over FS112-N3-DENSE3, N2-TERM, N4-FIN", at=(20, 560), sector="seven",
  also=[({"file": "CLAUDE.md", "grok": "G83"}, "With unit arcs, the tight question lives at one four-colour vertex.")])
N("LOCALF", "the local exclusion (NO)", "question", "Exclude every six-map fragment on a disc of explicit radius about a four-colour vertex. With "
  "CV-EXISTS this is the whole unit-arc NO; the capped strip puts the radius above φ²/√2 ≈ 1.8512 (FS-116, the successor).", L(137),
  "its NO is exactly an explicit radius about a vertex of at least four colours within which no such map fragment exists",
  (L(137), "the NO; an explicit radius (C114-LOCAL-F, FS-116)"), at=(22, 525), sector="seven", tier=1)
N("BOWSQ3", "the bowtie dies at √3", "nogo", "Two width-1 Reuleaux triangles corner to corner at a four-colour vertex fit a disc of radius "
  "3√3/5 exactly and no disc of radius √3: two independent derivations.", B("FS114-Y4-RSTOPALL"),
  "no non-Siamese simple valid fragment holding a Reuleaux bowtie at `p` contains neighbourhoods of `B̄(p, 1)` and of `r = q1 + q2`",
  "hand; three minds: Y4; YB3, blind; the proof side (N4, N5, NB5) blind to both, its last step one mind", at=(34, 575), sector="seven")
N("PINW", "the pinwheel dies at 1 + ε", "nogo", "Four unit-arc edges turning one way at a four-colour vertex die within 1 + ε of it, but for "
  "two named exceptions (an edge exactly 60° long; a blade's side a unit arc about its own edge's end).", B("FS114-Y5-PINALL"),
  "except under E1 (an edge of exactly 60°) or E2 (a blade's counter-clockwise side a unit arc about its clockwise edge end)",
  "hand; two minds: Y5; YB4, blind; tools exact at named values", at=(48, 575), sector="seven")
N("ROUTET", "route T, the count", "held", "Euler's formula on the map graph: a charge summing to zero, negative only where four-colour vertices "
  "carry three or four unit-arc edges; it reaches the non-Siamese part only (FS-117).", B("FS114-N2-ENDS"),
  "negative only at a degree-4 vertex with at least three tactic edges",
  "hand; one mind: N2; tools exact; its inequality form two minds (NB-ARCS, blind)", at=(62, 560), sector="seven",
  words=(TSTUB, "K2′ derived under K1 at one mind (0.35)"))
N("CAPSTRIP", "the capped strip", "positive", "The strip with each top tile capped by a unit arc holds every disc of radius below φ²/√2 about a "
  "four-colour vertex, and no extension does better.", B("FS114-Y-DIAL"),
  "the capped strip is a valid fragment holding every closed disc of radius below `φ²/√2 ≈ 1.8512` about a midline four-colour vertex",
  "tools, exact; two minds: Y; YB, blind", at=(119, 440), sector="six-up")
E("N3DENSE3", "CVEXISTS", "rests", B("FS114-CV-EXISTS"), "over FS112-N3-DENSE3, N2-TERM, N4-FIN")
E("CVEXISTS", "LOCALF", "rests", L(137), "its NO is exactly an explicit radius about a vertex of at least four colours within which no such map fragment exists")
E("LOCALF", "UANO", "rests", L(137), "So S–V's Question 2 with unit arcs is one local statement")
E("BOWSQ3", "LOCALF", "context", L(138), "Where the count gives six room, the configurations die locally", label="a piece")
E("PINW", "LOCALF", "context", L(138), "Where the count gives six room, the configurations die locally", label="a piece")
E("ROUTET", "BOWSQ3", "context", B("FS114-N2-ENDS"), "negative only at a degree-4 vertex with at least three tactic edges", label="where six has room")
E("CAPSTRIP", "LOCALF", "blocks", B("FS114-Y-DIAL"), "no extension does better", label="R > φ²/√2")
```

**Edits to existing nodes** (the coordinator's, after the filing): **GSTEP** — its text gains "FS-114 closed undecided: the global step is now the local
exclusion (LOCALF)"; its `words` registration (0.2) is scored: not met. **N3BASE** — its note "is being re-derived blind tonight (BASE-V); row 134's grade
stands as printed until it reports" → "BASE-V re-derived row 134's print steps blind: every step but Lemma 4 at cusps upgraded"; its `also` quotation moves
with row 135's corrected clause. **TSMYES** — "By row 135 it must hold a four-colour or repeated-colour vertex within 3 of every point" gains "and, by row
137, a vertex of at least four colours"; its registration (0.03) scored not met. **FOURC**, **SRAY**, **CHAINB** — bearing reduced to GS-4's density form
(row 137); their `words` lines reference rank 1 and 4 of the old table, Poros's to update. Coordinates are placeholders for the layout.

### Questions and findings for another lane (for the coordinator)

1. **Workflow 3.0, the close job (Kooshi asked for the friction):** (a) the lane file's § The close job says "Enter every theorem … as an entry" and
   the census counts **gapped and stalled entries too** (the checker failed on FS114-ROUTE-T, -GSD, -K1 until each had a § B line) — the lane file should say
   § B carries one line per entry, gaps included; (b) the entry grammar has **no field for "rests on it"** and its `model:` field has no form for a
   statement about a class not known to be non-empty (every valid-map statement here) — I wrote the vacuity caveat into each model line; the grammar or the
   lane file should say so, since an empty class is exactly the NO; (c) the lane file names no place for **regrades of an earlier close's entries** (only
   errata): I appended both in one dated section; (d) grouped entries (a lemma family under one id, each member quoted with its id) were needed to keep 150
   record ids to 46 entries — the lane file is silent on grouping, and the census cannot see member ids; (e) the brief's "items 1–121" missed item 122.
2. **Standing rule 3, measured again:** the owner's summaries in FS-114 dropped or widened a clause six times (inventory items 34, 39, 82, 86, 90, 109);
   the repair adopted mid-milestone — verifier instances with statements scripted verbatim from the record's table — worked, and the one slip after it was
   in a definition the script did not copy (item 109). A candidate rule for Keryx's own workflow: script the definitions as well as the statements.
3. **For FS-111's close and Poros's re-rank:** NB6-MTP's recognition (limits of simple hole-free valid maps can pinch or open holes) bears on FS-111's limit
   objects; FS111-M2-INTRAD's link makes FS-115's bearing possibly larger through route M (item 78).
## Stage 6 — SAVED
