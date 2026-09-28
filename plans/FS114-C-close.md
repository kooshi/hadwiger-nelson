# FS114-C — the close of FS-114, the unit-arc question (the close record)

*Job FS114-C (Ephodos, the close job; brief `data/fs114/briefs/C114-close.md`, standing rules `plans/STANDING-RULES.md`, both read in full
2026-09-28). Record of the close: the readback, the reconciliation, the derivation file, the sweeps and scored predictions, the successor stubs,
and the drafts of the front page. Launched beside FS111-C, which writes other files.*

## Theorems this phase proved

A close proves none of its own unless it does. Filled at stage 6 (the headline and each line's grade).

## Would-have-searched-here log (standing rule 5)

| stage | move a search would have made | what was done instead |
|---|---|---|
| 1 | — | none (reading only) |

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
