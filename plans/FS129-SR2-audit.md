# FS129-SR2 — pass 3 of the cross-application audit, lane R, second part: the rest of the Lean-order sweep, the open steps of the Lean order, item 81's leads

*Ephodos, the deriver (read as files, by Kooshi's decision 2), as a `general-purpose` agent on Opus. Brief:
`data/fs129/briefs/FS129-SR2-pass3.md`. Plan: `plans/FS129-cross-application-audit.md` § 3, Stage 4, scoped first to the Lean order
(`data/fs129/index/lean-order.md`). Continues `plans/FS129-SR1-audit.md` from its § 6.3 and redoes nothing it saved: its vacuity sort (§ Stage 5)
and its edge sort (§ 4.1; 12 false and 2 reversed edges in `data/fs129/index/edges.csv`, discounted here wherever dependents are read) stand.
Writes only this file, `data/fs129/sr2/`, `tools/fs129_sr2_*.py` and `data/fs129/reports/FS129-SR2.md`. Started 2026-10-04 00:59 UTC.*

## Theorems this phase proved

*Filled at each stage.* Every entry is **derived, one mind, kernel pending**; none moves a value or the answer's bearing.

- **FS129-SR2-CLOSURE** — an open set with `Leb ⊗ σ`-null unit pairs has no point at distance 1 from its closure; FS106-DIAM (iii), FS111-V0-CLOSE and
  FS116-V5-NE1's first clause are its cases — derived from FS111-M2-INT — § 2.2.
- **FS129-SR2-HULLSET** — FS111-C-HULL for one measurable set with `Leb ⊗ σ`-null unit pairs (no colouring, no tightness, no normal form) — derived
  from FS111-V0-ID1 — § 2.2.
- **FS129-SR2-SUPK** — FS106-SUP's equality of the tight, slack, tiled and periodic suprema at every `k` — derived from FS106-SUP — § 2.2.
- **FS129-SR2-DISC1TS** — FS112-DISC1 as a case of FS106-TS-T — derived from FS106-TS-T — § 2.2.
- **FS129-SR2-YESLIM-EQ** — FS116-O1-YESLIM as FS106-EQ's (c) ⟹ (a) at `k` composed with Lemma P — derived from FS106-EQ — § 3.2.
- **FS129-SR2-QFCASE** — FS116-S1-QF as a case of FS129-OR1-QFREE (simple at `p` is automatic) — derived from FS129-OR1-QFREE — § 3.2.
- **FS129-SR2-TOUCHW** — FS116-N1-TOUCH without its idle hypothesis — derived from FS116-N1-TOUCH (FS116-V3's reading) — § 3.2.

## Stage 1 — SAVED: readback and registered expectations

**Readback.** Read in full before this stage: the brief; `.claude/skills/ephodos/SKILL.md`; `.claude/agents/ephodos.md` from
`# Ephodos in lean-dir — the workflow` to its end (`## A derivation job` and `## What leaves your lane` govern this job; `## The record job` is not
mine); `plans/STANDING-RULES.md`; `plans/FS129-SR1-audit.md` §§ Stage 1, 3 (head and table), 4, 6 and its report; `plans/FS129-cross-application-audit.md`
§§ 3, 7; `plans/FS129-close-inventory.md` items 76–84, 98–104. Not yet read, on purpose, until these expectations are saved: any derivation file, any
grokking, `data/fs129/index/open-steps.md`, and the statements of the rows below.

**Quotation check** (standing rule 3), by script (blockquotes joined on whitespace, `> ` stripped from the sources): the request against
`plans/STUB-cross-application-audit.md`, decisions 1–4 and the note on roots against `plans/FS129-cross-application-audit.md`, and Kooshi's reading
against `plans/FS129-close-inventory.md` — **all four found, verbatim**. No mismatch; no finding about the brief.

**Scope, counted before reading.** SR1's § 6.3 row list is **151 rows** of `data/fs129/index/lean-order.md`, all lane R: FS-116 45, FS-111 32,
FS-112 26, FS-114 26, FS-106 11, FS-121 11; 53 seeds and 98 upstream. With SR1's 44 swept rows and lane A's two conditional seeds (rows 196, 197,
lane A's), that is all 197.

**Registered expectations** (2026-10-04 00:59 UTC, before any statement of these rows, any derivation file, any grokking or `open-steps.md` was read
for this pass; scored at hand-back and at FS129-Z1; instruments for G21, never caps):

| quantity | expectation | reasoning |
|---|---|---|
| merges in the 151 rows (one statement, one a case of another, or a stronger form already held elsewhere) | 8 (range 3–15) | SR1 found 5 in its 44 rows, but those were pre-flagged by passes 1–2; the unflagged FS-111 and FS-114 rows hold superseded forms kept as a route |
| hypotheses weakened, the weaker form derived as an entry | 2 (range 0–5) | most hand results are stated at the class their argument used; FS-111's and FS-112's six-colour hypotheses are the likeliest to drop to any `k` |
| results the vacuity lists missed (a class nothing satisfies, found in the sweep) | 2 (range 0–6) | the index flagged only `none-known` and negative-pattern models; a named model can still sit in a class a later no-go emptied |
| records that disagree (two records stating one thing differently) | 3 (range 1–8) | item 63's GAP lines will show some GAPs answered elsewhere without a link back, as FS110-A3-HOLE was (item 78) |
| item 63: GAP lines of Lean-order lane-R ids answered or shortened by a held result elsewhere | 4 (range 1–10) | MR1 found one by accident; nobody has read these lines against the later milestones |
| item 81 lead 1: a held result (G83's straddle, TWOCIRC) kills at least one of FS114-K1's (Q)-ring residues (S6, the wrap, the Reuleaux `(2, 1, 1, 0)`) | P = 0.30 | S1 died to PXKILL, which is TWOCIRC; the residues survived FS-114 for a reason |
| item 81 lead 2 / (d): a wider V6-ADJ (outer pairs off (Q)) derived | P = 0.45 | DOUBLETIP widened V6-HUG the same way; V6-ADJ's pinning of the outer tiles is the step that may not widen |
| item 81 lead 3: the coupling of two circles' windings for FS106-BIKE derived | P = 0.10 | a missing step since FS-106; RINGBAND sharpened only the one-circle input |
| (e): an O1-OUT analogue for valid maps derived | P = 0.15; refuted (a valid-map pencil whose windows shrink) P = 0.15 | SR1's stall names a continuation property valid maps do not obviously have |
| pass 3 (this part) finds a held result false | P = 0.12 | SR1 found none in the pre-flagged rows; the unflagged rows were each checked at filing |
| this agent reaches the end of the sweep (all 151 rows) before handing back | P = 0.55 | 151 rows at a line each is reachable; the named leads after it are heavy |

**Gate at this stage.** `derive_gate.py all` fails here on one item only, "no derivation entry": this stage registers expectations and holds no
merge or weakening, which is what the brief's gate rule binds (§ Done means 4). It is committed anyway because the registration must be dated before
the corpus is read; every later stage is committed only with the gate passing. (SR1 logged the same case as a slip, its item 102; this is the same
choice, made openly.)

## Stage 2 — SAVED: the sweep, rows 1–27, 30–45, 47–64, 67–100 (FS-106, FS-111, FS-112, FS-114's first half); the cycles; the errata the index misses

*Read for this stage: each row's statement, `uses only:` and handoff (`data/fs129/sr2/rows.md`, written by `tools/fs129_sr2_rows.py` from the index);
FS-106's and FS-112's older-format entries in their derivation files (the index holds no statement for them); `plans/FS111-V0-verification.md` §§ 2.1,
2.8; `plans/FS106-TQ-derivation.md` §§ 3.1–3.3; `plans/FS112-derivation.md` § Errata and regrades appended at FS-114's close; the `uses only:` lines of
FS114-CV-EXISTS, -N4-D, -Y3-RSTOP, -N6-NOQ, FS116-V5-NE1 and FS129-OR1-QFREE. No grokking was needed for this stage.*

### 2.1 The sweep (brief § Done means 4), first part

One line per row of `data/fs129/index/lean-order.md`. "Leaves the order" means no seed rests on the row once the false and reversed edges of SR1's
§ 4.1 and of § 2.3 below are dropped (`tools/fs129_sr2_cycles.py -v`); it is a fact about the Lean order, not a verdict on the result.

| row | id | line |
|---|---|---|
| 1 | FS106-COMP | its first clause is FS106-EQ's (c) ⟹ (a) at `k = 6`, and EQ states it at every `k`: formalize once, at `k`, as EQ's; the second clause (equivalence with V-1.1) separately. Leaves the order (it was there only through EQ → SUP, false) |
| 2 | FS106-DIAM | **merge**: clause (iii) is FS129-SR2-CLOSURE (§ 2.2), with FS111-V0-CLOSE and FS116-V5-NE1's first clause; clause (ii) is FS106-TS-C at a chain of two; clause (i) is the one connectedness lemma under FS116-V5-NE1's "in particular", TS-C, FS111-C-HULL and -M-HULL2 — formalize (i) once |
| 3 | FS106-L | unchanged: CLOSURE applied to each colour class when the classes are open; Townsend's setting colours boundary points too, and V3's proof (stage 1) was not read here, so no merge is claimed |
| 4 | FS106-REM | unchanged; leaves the order (with EQ) |
| 5 | FS106-EQ | unchanged; **its every-`k` form rests on FS106-SUP, which is stated at six only** — FS129-SR2-SUPK (§ 2.2) states SUP at every `k`, so EQ's (e) has its input as stated; its (c) ⟺ (d) is SUPK read at the value 1. Leaves the order (its one seed edge, EQ → SUP, is false: § 2.3) |
| 6 | FS106-SUP | **hypothesis weakened**: six → every `k` (FS129-SR2-SUPK); formalize SUPK in its place |
| 7 | FS106-TS-C | unchanged; carries DIAM (ii) as its two-region case |
| 8 | FS106-TS-T | unchanged; **carries FS112-DISC1** (row 51; FS129-SR2-DISC1TS) |
| 9–11 | FS106-WO, -TW, -AE-MAP6 | unchanged (declined; the repairs of printed proofs) |
| 12 | FS111-C-FILL | unchanged |
| 13 | FS111-C-HULL-SO | **refuted** — do not formalize; leaves the order (SR1's false edge) |
| 14 | FS111-M-R7 | unchanged (a control object, exact) |
| 15, 16, 18 | FS111-M-SATC, -M2-COV, -M2-ZERO | unchanged; SATC's shadow identity `ℝ² = int F_j ∪ (F_j + S¹)` is FS111-M2-FIX's maximality half read coordinatewise through COV, and needs no regularity — FIX's regularity is spent on its other half |
| 17 | FS111-M2-DISC7 | unchanged (a control object); leaves the order (its edge into M2-HULLC is a scope marker, § 2.3) |
| 19 | FS111-V0-CLOSE | **merge**: a case of FS129-SR2-CLOSURE (`U` the union of the open colour-`j` regions) — formalize CLOSURE once |
| 20 | FS111-V0-CLEAN | unchanged; leaves the order (with C1-PW) |
| 21, 22 | FS111-C1-PW, -C1-UNIF | unchanged; their mutual edges are companion mentions (§ 2.3), so the cycle breaks and PW leaves the order |
| 23 | FS111-V0-ID1 | unchanged; **its argument reads one class only** (a measurable set with `Leb ⊗ σ`-null unit pairs), which is what FS129-SR2-HULLSET uses |
| 24 | FS111-C-HULL | **hypothesis weakened**: "a tight a.e.-proper k-colouring in D-NF" → one measurable set with `Leb ⊗ σ`-null unit pairs (FS129-SR2-HULLSET); formalize HULLSET in its place — its consumers (M-PINCH, M-HULL2, M2-FIX, M-COVER-SC, M-HALF) then need no colouring for this step |
| 25 | FS111-M-COVER-SC | **records disagree**: its handoff says "superseded by FS111-M2-HULLC's fuller form", but HULLC adds "with regular classes" and COVER-SC's semiconcavity holds on every maximal cover (it uses SATC and C-HULL only). Formalize COVER-SC's semiconcavity in place of HULLC's semiconcave clause; leaves the order (its edge into HULLC is not a use, § 2.3) |
| 26 | FS111-M-HALF | unchanged |
| 27 | FS111-M-HULL2 | unchanged (already stated for any a.e.-proper colouring; it is HULLSET plus path-connectedness of the second piece); leaves the order (its consumers in the order were SR1's false edges) |
| 30 | FS111-M-C11 | unchanged |
| 31 | FS111-M2-INT | unchanged; **the measurable form of CLOSURE** — CLOSURE, V0-CLOSE, DIAM (iii) and V5-NE1's first clause are its open-set case |
| 32 | FS111-M2-FIX | unchanged; the cycle FIX → HC → IRREG → FIXCONV → FIX breaks at FIXCONV → FIX, a scope marker (§ 2.3) |
| 33–36 | FS111-M3-BAND, -FIXCONV, -HC, -IRREG | unchanged (design facts, a scope marker, a counterexample to a universal form, a no-go); all four leave the order |
| 37 | FS111-M2-HULLC | unchanged, except its semiconcave clause, which COVER-SC carries without regular classes (row 25) |
| 38 | FS111-V0-RESCALE | unchanged |
| 39 | FS111-C-SIX-M | unchanged |
| 40 | FS111-M2-REDUCE-C | unchanged (its second clause is C-SIX-M composed with its first) |
| 41–43 | FS111-W-KB-DIR, -W-NOBEND, -W-NOREP | unchanged (corollaries of M-PINCH, M-C11) |
| 44 | FS111-W-SQ9 | unchanged (a control object; it inhabits FS121-O1-OUT, SR1 § 5.1) |
| 45 | FS111-M2-INTRAD | unchanged |
| 47 | FS112-A4SIX | unchanged |
| 48, 50, 62, 71, 68 | FS112-BOWTIE, -C-DOUBLE, -N3-END, -C-ENDS, FS114-CV-HD | unchanged, but **CV-EXISTS's own statement says it uses neither CV-HD nor C-ENDS**: these five are in the order only through FS114-CV's older route into CV-EXISTS, and leave it when the order follows first routes. C-ENDS's **erratum governs** (its residue clause deleted, `plans/FS112-derivation.md` § Errata … item 2) — quote the corrected form |
| 49 | FS112-BUDGET2 | **FALSE as stated** — do not formalize; leaves the order (its edge into NB4P names the corrected form, § 2.3) |
| 51 | FS112-DISC1 | **stated in a stronger form already held**: FS106-TS-T (a point of chromaticity ≥ 3 within `1/√2 + ε` of every point; FS129-SR2-DISC1TS) — formalize TS-T in its place |
| 52 | FS112-FLANK | unchanged (an exception to N4-FLANK; FS112-N2-FLANK-Q classifies it) |
| 53, 54 | FS112-ISO, -LOCK | unchanged |
| 55 | FS112-BEND | **stated in a stronger form already held**: FS112-N2-BENDS (the whole arc, end vertices included), and through it FS129-SR1-BENDANY — do not formalize BEND separately |
| 56 | FS112-N2-BENDS | SR1's line stands |
| 57–61, 63 | FS112-N2-FLANK-Q, -N2-RAY, -N3-ANTI, -N3-FAIL, -N3-NOBOTH, -N3-PAIRS | unchanged |
| 64 | FS112-NB4P | unchanged |
| 67 | FS114-BV-HEX | unchanged |
| 69 | FS114-CVB-THOM | unchanged |
| 70 | FS114-L60-LE | unchanged; **formalize it in place of FS112-L60** (row 72) |
| 72 | FS112-L60 | **FALSE as stated at exactly 60°** (its erratum, `plans/FS112-derivation.md` § Errata … item 1; FS114-L60-REAL realises equality) — do not formalize as stated; FS114-L60-LE in its place, which every consumer accepts (FS114-L60-WALK) |
| 73 | FS112-N2-RED | **a case of FS112-N2-TERM**: its conclusion is TERM's first clause; formalize TERM, with RED's procedure as its lemma |
| 74–78 | FS112-N2-TERM, -N3-BASE, -N3-COR3, -N3-DENSE3, -ROTHEX | unchanged; N3-BASE's regrade (erratum item 5) governs its grade line. The ten-member cycle breaks at three edges out of FS114-CV-EXISTS (§ 2.3) |
| 79 | FS114-CV-EXISTS | unchanged; its first route is CVB's (DENSE3, N2-TERM, N4-FIN) |
| 80 | FS114-L60-WALK | unchanged (an audit of a chain) |
| 81–84 | FS114-N114-RD, -N114-EULER, -N2-FIVE, -N114-ROOM | unchanged |
| 85 | FS114-N2-ENDS | unchanged; **its model line carries an erratum** (FS116-O1, 2026-09-29, under the entry) — quote it with the entry |
| 86 | FS114-N3-LOCAL | unchanged |
| 87 | FS114-N3-DR | **stated in a stronger form already held**: FS114-Y4-RSTOPALL (its handoff says so); its lemmas N3-CONT, N3-DR1 cross only as N4-D's inputs |
| 88 | FS114-N3-JOINT | **merge**: its first clause, `N + U + 3V₆ = V₄`, is FS114-N2-ENDS's identity halved (`Σ n = 2N`, each non-tactic edge counted at both ends) — one identity, formalized once as N2-ENDS's; its model line carries the same erratum. Leaves the order |
| 89 | FS114-N4-LEMMAS | unchanged; its input FS112-SIX reads as FS116-N2-FIVERING / FS129-SR1-SIXQ (SR1 § 6.2 item 3) |
| 90 | FS114-Y-EDGE | unchanged; leaves the order |
| 91, 92 | FS114-Y2-BOWTIE, -Y4-LUNE | unchanged |
| 93 | FS114-N4-D | **a case of FS114-Y4-RSTOPALL** (Γ-free lune rings, the same non-Siamese simple class and radius `√3`); its handoff already says so — formalize RSTOPALL; N4-D is a second route |
| 94 | FS114-N5-GRING | unchanged (a second route to RSTOPALL's ΓRING case) |
| 95 | FS114-Y3-RSTOP | unchanged, and **not** a case of RSTOPALL: it allows Siamese pairs (its own statement) for Y2's bowtie, so its handoff's "a member of FS114-Y4-RSTOPALL" holds only on the non-Siamese simple part; RSTOPALL uses its lemma Y3-R |
| 96 | FS114-Y4-RSTOPALL | unchanged; carries N4-D and N3-DR |
| 97 | FS114-N6-NOQ | within the non-Siamese simple class its main clause is a case of FS129-OR1-QFREE (a pinwheel's centre is a four-colour vertex; radius `1 + ε` is "above 1"); QFREE is one mind and NOQ's class is not fixed in its statement line, so unchanged, with QFREE formalized for the class |
| 98 | FS114-Y5-PINALL | unchanged; leaves the order (its edges into K1 and N6-NOQ were SR1's false edge and a companion mention) |
| 99, 100 | FS114-N7-QOPP, -Y6-HALF | unchanged |

### 2.2 The entries

derivation: FS129-SR2-CLOSURE
  statement: let U ⊆ ℝ² be open, with (Leb ⊗ σ){(x, w) ∈ U × S¹ : x + w ∈ U} = 0; then no point of U is at distance exactly 1 from a point of cl U
  uses only: FS111-M2-INT with A = U; that every point of an open set is a Lebesgue density point of it, so U ⊆ int Ũ; that every density point of U
    lies in cl U, so cl Ũ = cl U
  not claimed: anything for a point of cl U against another point of cl U (two boundary points may be at distance 1: the hexagonal seven-colouring's
    opposite vertices, FS111-C-HULL-SO's object); anything for sets that are not open (that is FS111-M2-INT itself)
  argument: § 2.2.1 FS129-SR2-CLOSURE, the argument
  verdict: derived
  grade: derived from: FS111-M2-INT
  minds: 1
  model: U the open hexagon of circumradius 1/2 (diameter 1, so no two of its points are at distance 1); cl U's farthest point from any point of U is
    below 1
  prior art: partly: in-house three times — FS106-DIAM's third clause, FS111-V0-CLOSE, FS116-V5-NE1's first clause — and FS111-M2-INT is its measurable form
  handoff: de Bruijn — formalize once, as FS111-M2-INT's corollary for open sets (or by V0-CLOSE's translation argument directly), in place of FS106-DIAM
    (iii), FS111-V0-CLOSE and FS116-V5-NE1's first clause; the statement and its not claimed

derivation: FS129-SR2-HULLSET
  statement: let A ⊆ ℝ² be measurable with (Leb ⊗ σ){(x, w) : x ∈ A, x + w ∈ A} = 0, Ã its Lebesgue density points and A* = {x : d̄_A(x) > 0}; for
    every path-connected C ⊆ Ã and every x ∈ A*, either |x − c| < 1 for every c ∈ C or |x − c| > 1 for every c ∈ C; when C is compact, either
    sup_{c∈C}|x − c| < 1 or dist(x, C) > 1
  uses only: FS111-V0-ID1's argument, which reads only that A's own unit pairs are null; continuity of c ↦ |x − c| on a path-connected C; a continuous
    function on a compact set attains its bounds
  not claimed: A* ⊆ {x : sup_{c∈C}|x − c| < 1} ∪ {x : dist(x, C) > 1} for non-compact C (FALSE: FS111-C-HULL-SO); anything at points of density 0
  argument: § 2.2.2 FS129-SR2-HULLSET, the argument
  verdict: derived
  grade: derived from: FS111-V0-ID1
  minds: 1
  model: A one hexagon of the tight hexagonal seven-colouring (FS111-C-HULL's model), C its interior, x a point of another hexagon of the same colour
    (distance above 1.29 to every point of C)
  prior art: partly: FS111-C-HULL (the same conclusion for tight a.e.-proper colourings in D-NF), FS-106's I-D1 for tight colourings
  handoff: de Bruijn — in place of FS111-C-HULL: one measurable set, no colouring, no tightness, no normal form; C-HULL is its case S_j = A

derivation: FS129-SR2-SUPK
  statement: for every k ≥ 1, µ_k⁰ = lim_{ε→0} µ_k(ε) = lim_{ε→0} µ_k^tile(ε) = lim_{ε→0} µ_k^per(ε), with µ_k⁰, µ_k(ε), µ_k^tile(ε), µ_k^per(ε)
    defined as FS106-SUP defines them at six (the suprema of the upper densities covered by a.e.-proper, band-proper, band-proper tiled, and
    band-proper periodic tiled partial k-colourings)
  uses only: FS106-SUP's argument (plans/FS106-TQ-derivation.md § 3.2) and its Lemmas P and T (§ 3.1) and TQ-REM-i, none of which reads the number of
    classes: Lemma P copies a colouring of a square, Lemma T colours each grid square by the least class meeting it in positive measure, REM-i keeps
    points class by class
  not claimed: SUP's second clause (µ^per(ε) = µ(ε) at each ε, and attainment) at every k — QB's stronger form was not read here; any value of µ_k⁰
  argument: § 2.2.3 FS129-SR2-SUPK, the argument
  verdict: derived
  grade: derived from: FS106-SUP
  minds: 1
  model: k = 7 — the tight hexagonal seven-colouring covers everything with no monochromatic unit pair a.e., so µ₇⁰ = 1, and its slack shrinkings
    show lim µ₇(ε) = 1
  prior art: partly: FS106-SUP at six (two minds); FS106-EQ's every-k form already uses it at every k
  handoff: de Bruijn — in place of FS106-SUP; then FS106-EQ's (e) has its input as stated, and EQ's (c) ⟺ (d) is SUPK at the value 1

derivation: FS129-SR2-DISC1TS
  statement: every closed disc of radius 1 of a valid map contains a vertex of degree at least 3 (FS112-DISC1's statement), as a case of FS106-TS-T
  uses only: FS106-TS-T (every point of an almost-everywhere-proper map has a point of chromaticity at least 3 within 1/√2 + ε); that a valid map is an
    almost-everywhere-proper map in TS-T's sense (FS-112's definition: a locally finite map by open connected tiles, no two interior points of one
    colour at distance 1); that in a locally finite map a point in the closures of tiles of three colours is a vertex where at least three tiles meet
  not claimed: anything sharper than TS-T's radius 1/√2 + ε; the trichromatic or cubic forms TS-T gives under Conditions 5 or 6
  argument: § 2.2.4 FS129-SR2-DISC1TS, the argument
  verdict: derived
  grade: derived from: FS106-TS-T
  minds: 1
  model: none known for valid maps, which are six-coloured and whose non-existence is the map NO itself (hypothetical by design, a step toward the
    NO); TS-T's own class, a.e.-proper maps with any number of colours, is inhabited by the tight hexagonal seven-colouring, which has a vertex of
    degree 3 within 1/2 of every point
  prior art: partly: CB's D6 (the trichromatic form for cubic maps), as FS112-DISC1's entry says
  handoff: de Bruijn — formalize FS106-TS-T in place of FS112-DISC1; DISC1's consumers (FS112-N2-DENSE, -N3-DENSE3) read it as TS-T's corollary

#### 2.2.1 FS129-SR2-CLOSURE, the argument

`U` is open, so each `x ∈ U` has a disc in `U` and is a density point of `U`: `U ⊆ Ũ`, and as `U` is open, `U ⊆ int Ũ`. A density point of `U` is a
limit of points of `U`, so `Ũ ⊆ cl U` and `cl Ũ = cl U`. FS111-M2-INT, applied to `A = U` (an a.e. unit-avoiding set by hypothesis), says that
`int Ũ` holds no point at distance exactly 1 from `cl Ũ`; so no point of `U` is at distance 1 from a point of `cl U`. ∎ The three in-house statements
are this with `U` named: FS106-DIAM (iii) ("an open set avoiding distance 1 has `ω(p)` disjoint from it for every `p` in its closure"); FS111-V0-CLOSE
(`U` the union of the open colour-`j` regions of a D-AEMAP-proper map; V0's own proof is the translation argument, which needs no density); FS116-V5-NE1's
first clause (`U` the union of the open colour-`c` tiles of a valid fragment). V5-NE1's "in particular" adds FS106-DIAM (i)'s connectedness step: `T`
is connected, `z ↦ |z − x|` is continuous on it, avoids 1, and takes values near 0 near `x ∈ cl T`, so it stays below 1.

#### 2.2.2 FS129-SR2-HULLSET, the argument

FS111-V0-ID1's proof (`plans/FS111-V0-verification.md` § 2.1): with `|x − y| = 1`, `y ∈ S̃_j`, `d̄_j(x) = θ > 0`, it bounds below the measure of pairs
`(x′, w)` with `x′ ∈ S_j ∩ B(x, r)` and `x′ + w ∈ S_j ∩ B(y, 2r)`, using only that `y` is a density point of `S_j` and `x` a point of positive upper
density of `S_j`; the contradiction is with "`S_j`'s monochromatic unit pairs are `Leb ⊗ σ`-null". No other class, no covering, no tightness and no
normal form enters. So for `A` as stated, `|x − c| ≠ 1` for `c ∈ Ã`, `x ∈ A*`. FS111-C-HULL's first-clause argument (V0 § 2.8) then runs verbatim:
`{|x − c| : c ∈ C}` is the continuous image of a path-connected set, an interval avoiding 1. For compact `C` the interval is closed, so it lies in
`[0, 1)` with its maximum below 1, or in `(1, ∞)` with its minimum above 1. ∎

#### 2.2.3 FS129-SR2-SUPK, the argument

TQ-SUP's five inequalities (`plans/FS106-TQ-derivation.md` § 3.2) with 6 replaced by `k`: `µ_k^per ≤ µ_k^tile ≤ µ_k` (the classes only widen);
`µ_k(ε) ≤ µ_k^tile(ε − 2√2 h)` (Lemma T, which colours each grid square by the least `j` with `|C_j ∩ τ| > 0`, for any number of classes);
`µ_k^tile(ε) ≤ µ_k^per(ε)` (restriction to a box and Lemma P, which copies a square's colouring on the lattice `(R + 2)ℤ²` whatever its classes);
`µ_k^tile(ε) ≤ µ_k⁰` (no band pair, so no unit pair); `µ_k⁰ ≤ lim µ_k^tile(ε)` (TQ-REM-i's kept set, class by class, then Lemmas P and T). Every
function of `ε` is monotone, so the limits exist and the order of limits is safe, as at six. ∎ The filed FS106-EQ is stated "for every k" and its
(e) rests on SUP; SUPK is the statement that use needs.

#### 2.2.4 FS129-SR2-DISC1TS, the argument

Let `D = B̄(x, 1)`. TS-T gives a point `y` of chromaticity at least 3 with `|y − x| ≤ 1/√2 + ε`; take `ε < 1 − 1/√2`, so `y ∈ D`. In a locally finite
map, `y` lies in the closures of tiles of at least three colours, hence of at least three tiles, and a point in the closure of three tiles is a vertex
of the map's boundary graph of degree at least 3 (a point interior to an edge lies in the closures of exactly two tiles). ∎ FS112-DISC1's own route
(NB2's proof) is a second route to its weaker radius.

### 2.3 The edges inside the lane-R cycles, sorted

The eleven lane-R cycles SR1 left (`data/fs129/index/cycles.md` less SR1's breaks) were read edge by edge: the `uses only:` line of the edge's head
against the "Rests on it" sentence of its tail (`data/fs129/sr2/cycle_edges.txt`). Same classes as SR1 § 4.1. Edges whose head's `uses only:` names
the tail are real and not listed.

| from | to | class | reading |
|---|---|---|---|
| FS111-C1-PW, FS111-C1-UNIF | each other | false (2) | "card 1's answer, with …": companions; neither's `uses only:` names the other |
| FS106-EQ | FS106-SUP | false | TQ-SUP's proof (TQ § 3.2) uses Lemmas P, T and REM-i, not EQ; EQ (e) rests on SUP, the true direction |
| FS121-D1-R2CORNER | FS121-D1-R2SMOOTH, FS121-D1-RUNG2 | reversed (2) | R2CORNER's `uses only:` names both; neither names R2CORNER |
| FS121-DB1-L4 | FS121-DB1-L1 | reversed | L4 uses L1; L1's `uses only:` reads straddles and FS112-U1's cones |
| FS121-V5-RAY | FS121-V5-LOC | reversed | RAY uses LOC; LOC reads the definitions, M-PINCH and M-C11 |
| FS111-M3-FIXCONV | FS111-M2-FIX | false | "the one-way wording of FIX": a scope marker in FIX's not claimed |
| FS114-CV-EXISTS | FS112-L60 | false | "its chain is intact at L60's boundary": a mention |
| FS114-CV-EXISTS | FS112-N3-DENSE3 | reversed | "It rests on FS112-N3-DENSE3": CV-EXISTS uses DENSE3 (already an edge) |
| FS114-CV-EXISTS | FS114-L60-WALK | reversed | L60-WALK audits CV-EXISTS's chain; CV-EXISTS's standing rests on it |
| FS114-N6-NOQ, FS114-Y5-PINALL | each other | false (2) | "the pinwheel closed from both ends": companions |
| FS114-N5-GRING | FS114-Y4-RSTOPALL | route | "the bowtie family's exclusion by two independent derivations" |
| FS114-Y3-RSTOP | FS114-N4-D | false | "the blind convergence at `√3`": a convergence note |
| FS114-Y3-RSTOP | FS114-Y4-RSTOPALL | real | RSTOPALL uses RSTOP's lemma Y3-R |
| FS114-Y4-RSTOPALL | FS114-N4-D, FS114-Y3-RSTOP | false (2) | "as members": the members do not use the family |
| FS111-M2-DISC7 | FS111-M2-HULLC | false | "the semiconvexity no-go in HULLC": a scope marker |
| FS111-M-COVER-SC | FS111-M2-HULLC | false | an extension note; HULLC is derived from FIX and C-HULL |
| FS112-BUDGET2 | FS112-NB4P | false | a refuted entry naming its corrected form |
| FS112-C-ENDS, FS114-CV-HD | FS114-CV-EXISTS | route (2) | FS114-CV's route; CV-EXISTS's statement: "it uses neither CV-HD nor FS112-C-ENDS" |

**Tally:** 23 edges — real 1, route 3, false 13, reversed 6. With SR1's sort applied too: **lane-R cycles 11 → 2** (left: N7-3T ↔ N7-HUB, both empty
given FS129-OR1-QFREE, SR1 § 5.1; and V5-LENS / Y3-SIX / Y3-TIPS, a second route kept on purpose). **The Lean order shrinks from 197 rows to 171**
when false and reversed edges are dropped, and **to 160** when route edges are dropped too (the order following first routes); the 26 and 11 rows are
listed by `tools/fs129_sr2_cycles.py -v`. For FS129-Z1, which re-runs the index: drop these 19 false and reversed edges with SR1's 14, mark the 3 route
edges with SR1's 6, and decide which closure the Lean order is.

control: fs129-sr2-cycles
  of: § 2.3 — every sorted edge is in edges.csv; with SR1's and this sort's false and reversed edges dropped, two lane-R cycles remain and the order has 171 rows (160 on first routes)
  run: cd .. && python3 tools/fs129_sr2_cycles.py
  expect: SR2 edges sorted: 23 (real 1, route 3, false 13, reversed 6); lane-R cycles 11 -> 2; Lean order 197 -> 171 (false, reversed dropped) -> 160 (route dropped too)
  fault: cd .. && python3 tools/fs129_sr2_cycles.py --fault

control: fs129-sr2-rows
  of: the row dump — SR1's § 6.3 list is 151 rows
  run: cd .. && python3 tools/fs129_sr2_rows.py
  expect: rows dumped: 151
  fault: cd .. && python3 tools/fs129_sr2_rows.py --fault

### 2.4 Errata the index does not carry (for FS129-L1, which quotes statements by script)

The index reads each entry, not the dated errata filed after it, and FS129-L1 quotes statements from the entries. Where an erratum governs, the
backlog must quote it with the entry, or it formalizes a false or superseded form:
- **FS112-L60** (row 72): FALSE at exactly 60°; the corrected statement is FS114-L60-LE's — `plans/FS112-derivation.md` § Errata and regrades appended
  at FS-114's close, item 1.
- **FS112-C-ENDS** (row 71): its residue clause deleted — same section, item 2.
- **FS112-C-DOUBLE** (row 50), **FS112-N3-BASE** (row 75): regrades — items 3, 5; and item 8: every FS-112 "*Kernel:* stub — with FS-114" reads "with
  FS-116".
- **FS114-N2-ENDS** (row 85) and **FS114-N3-JOINT** (row 88): their model lines — the errata of FS116-O1 (2026-09-29) under each entry,
  `plans/FS114-derivation.md` ll. 255, 277.
- **FS114-N7-3T** (row 102, SR1's): the erratum of FS116-Z2 under the entry (l. 740), which split FS114-N7-QFREE off it.

## Stage 3 — SAVED: the sweep, rows 104–193 (FS-114's last row, FS-116, FS-121)

*Read for this stage: each row's statement, `uses only:` and handoff (`data/fs129/sr2/rows.md`); FS116-N1-TOUCH's entry and
`plans/FS116-V3-verification.md` §§ 3.1, 4.4 (its idle hypothesis); FS116-V5-NE1's entry; FS129-OR1-QFREE's entry and `plans/FS129-OR1-audit.md`
§ J3; `plans/FS106-TQ-derivation.md` § 3.1 (Lemma P). With stage 2 this completes SR1's § 6.3 row list: all 151 rows swept.*

### 3.1 The sweep, second part

| row | id | line |
|---|---|---|
| 104 | FS116-N1-GERM-R | unchanged |
| 105 | FS116-N1-TWIST-D | unchanged; **carries** FS116-RING-TWIST-C's first clause (row 127) and FS116-V5-RING's first two clauses (row 146), and is SR1's SIXQ's source |
| 106 | FS116-N1-ECHO | unchanged (V3 § 4.4's statement defect for ECHO is FS-116's, already filed) |
| 107 | FS116-N1-GERM-S | unchanged; it carries RING-GERM's (iii) with Siamese pairs allowed, and (i), (ii) only in facing form, so neither is a case of the other — formalize both, GERM-S first (its handoff) |
| 109 | FS116-N1-TOUCH | **hypothesis weakened**: "in the closure of a tile of one of p's colours" is idle (FS116-V3 § 3.1, filed only as a uses-only note) — FS129-SR2-TOUCHW states it without; formalize TOUCHW in its place |
| 112 | FS116-N3-PAIR | unchanged; on FS116-V5-QCOL's setting (four colours at `p`) it is FS116-V5-DICHO's parenthetical clause, and DICHO adds the disjoint alternative |
| 113 | FS116-N3-STAR2 | unchanged |
| 114, 115 | FS116-O1-SATPIN, -N1-AXIS | unchanged |
| 116 | FS116-O1-YESLIM | **merge**: a corollary of FS106-EQ's (c) ⟹ (a) at `k` (FS106-COMP's first clause at `k`) by Lemma P — FS129-SR2-YESLIM-EQ; its own route is COMP's Route I (Rajchman, weak-* compactness), so de Bruijn formalizes the weak-* step once, in EQ, and YESLIM in two lines |
| 117 | FS116-RING-GERM | unchanged |
| 118–120 | FS116-N2-STAR, -N2-ANTI, -N2-RECIP | unchanged |
| 123, 124 | FS116-N3-CONE, -N3-CROSS | unchanged |
| 125 | FS116-RING-Q-PRIME | **a case of FS116-RING-Q-PRIME-S** (row 126): Q-PRIME-S allows Siamese pairs, radius above 1 and any ring; Q-PRIME's own `uses only:` ("a (Q) arc whose closure holds a ring point holds one of its two germs") forces its "on no (Q) arc" to be read as "on no closed (Q) arc", Q-PRIME-S's wording. Formalize Q-PRIME-S (over GERM-S) in its place; Q-PRIME over RING-GERM is the second route |
| 126 | FS116-RING-Q-PRIME-S | unchanged; carries Q-PRIME |
| 127 | FS116-RING-TWIST-C | its first clause is N1-TWIST-D's at four or more colours — formalize TWIST-D once; TWIST-C's other clauses over it |
| 129 | FS116-S1-CLUSTER | unchanged (V4-DICHOTOMY carried along a connected family) |
| 130, 131 | FS116-S1-EXIT, -S1-RUNG | unchanged |
| 132 | FS116-V4-CHORD | unchanged |
| 133 | FS116-V4-DICHOTOMY | its first clause is FS111-M-HULL2's case for two open tiles (every point of an open tile is a density point; a tile is path-connected), and "A ~ A" is FS106-DIAM (i) for a tile — one more member of SR1's group-4 family; its closure clause by continuity. Unchanged as a statement |
| 134–137 | FS116-V4-MEET, -V4-OUTER, -V4-PARTNER, -V4-TWIST | unchanged; second-route steps (SR1 § 4.1), they leave the order on first routes |
| 139, 140 | FS116-S1-PAIR, -S1-LENS | unchanged; S1-QF's inputs, a second route once S1-QF is read as QFREE's case |
| 141 | FS116-S1-QF | **stated in a stronger form already held**: FS129-OR1-QFREE (FS129-SR2-QFCASE) — at `p` a degree-4 vertex of four colours with four edges has one sector per tile, so S1-QF's class is simple at `p` and lies in QFREE's; **OR1 § J3's "what is left … their non-simple part (FS116-S1-QF is stated for non-Siamese fragments without 'simple')" is empty for S1-QF** |
| 142 | FS116-V5-NE1 | **merge**: its first clause is FS129-SR2-CLOSURE, its "in particular" FS106-DIAM (i)'s connectedness step — formalize those two once |
| 143–145, 147, 148 | FS116-V5-OUT, -V5-OUT2, -V5-QCOL, -V5-GERM, -V5-TIPSET | unchanged (relay-results of V5's route); V5-TIPSET's hub clause is FS116-V6-HUBS's tip clause (the two routes' copies of one fact) |
| 146 | FS116-V5-RING | its first two clauses are N1-TWIST-D's case with no arc of Γ (TWIST-D: Siamese allowed, any `k`); "exactly four colours" is its own (six colours, non-Siamese) |
| 153 | FS116-V5-DICHO | unchanged; carries N3-PAIR on its setting (row 112) |
| 154, 155 | FS116-N3-SEMI, -RING-TRANSFER-QC | unchanged |
| 156, 157, 159 | FS116-V6-HUBS, -V6-ANTI, -V6-COUNT | unchanged (V6's route to Y4-EMPTY, hypothetical by design under SR1's rule) |
| 160 | FS116-Y2-SIXFRAG | unchanged (an exact control object) |
| 172, 175 | FS121-C1-BOUND, -C1-SAT | unchanged |
| 176 | FS121-D1-XCORNER | unchanged (elementary) |
| 177, 178 | FS121-D2-EXT, -D2-THIN | unchanged |
| 179 | FS121-D3-FALLSAT | unchanged; its partitions are the maximal admissible covers (FS111-M2-COV, ⟸) that are partitions |
| 181 | FS121-DB1-L3 | unchanged; **it is FS111-W-NOREP's stronger form** (cusps allowed; honest saturated colourings with REG-J′ in place of saturated cusp-free maps; FS121-O1-ENDS already cites L3 in NOREP's place) — **row 43's line is corrected**: formalize L3 in place of NOREP |
| 182 | FS121-DB1-L7 | unchanged; INTRAD's outward step with REG-J′ dropped (already that weaker form); leaves the order (SR1's false edge) |
| 183 | FS121-O1-ENDS | unchanged |
| 192, 193 | FS121-V5-LOC, -V5-RAY | unchanged; the cycle breaks at RAY → LOC (reversed, § 2.3) |

### 3.2 The entries

derivation: FS129-SR2-YESLIM-EQ
  statement: for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment, then χ_m⁰(ℝ²) ≤ k (FS116-O1-YESLIM's
    first clause), as a corollary of FS106-EQ's implication (c) ⟹ (a) at k
  uses only: FS106-EQ (c) ⟹ (a) at k — if for every δ > 0 there are k disjoint measurable classes with Leb ⊗ σ-null monochromatic unit pairs whose union
    has upper density at least 1 − δ, then χ_m⁰(ℝ²) ≤ k (FS106-COMP's first clause, stated by EQ at every k); Lemma P of plans/FS106-TQ-derivation.md
    § 3.1 in its Leb ⊗ σ-null form; that a fragment's tile boundaries are Lebesgue-null and its colour classes have no unit pair between interior points
  not claimed: YESLIM's clause at six with no MR (that is row 130's χ(ℝ²) ≤ χ_m⁰(ℝ²), unchanged); anything about a single fragment of bounded radius
  argument: § 3.2.1 FS129-SR2-YESLIM-EQ, the argument
  verdict: derived
  grade: derived from: FS106-EQ
  minds: 1
  model: k = 7 — the tight hexagonal seven-colouring restricted to discs of every radius is a valid seven-coloured fragment on each, and χ_m⁰(ℝ²) ≤ 7
  prior art: partly: FS116-O1-YESLIM (the same statement by COMP's Route I directly), FS106-COMP
  handoff: de Bruijn — formalize FS106-EQ's (c) ⟹ (a) once at every k (the weak-* step), and YESLIM as this two-line corollary in place of its own
    weak-* argument

derivation: FS129-SR2-QFCASE
  statement: FS116-S1-QF's statement — no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a
    degree-4 vertex of four colours whose four edges are segments at right angles — is a case of FS129-OR1-QFREE
  uses only: FS129-OR1-QFREE; that a degree-4 vertex of four colours with four edges has four sectors, one tile each, so the fragment is simple at p;
    that radius 2 is above 1; FS-116's "valid fragment", six-coloured unless "k-coloured" is written
  not claimed: anything for S1-QF in a k-coloured reading with k ≥ 7 (QFREE's limit); anything about saturation's role (QFREE needs none); anything for
    rings carrying a (Q) arc
  argument: § 3.2.2 FS129-SR2-QFCASE, the argument
  verdict: derived
  grade: derived from: FS129-OR1-QFREE
  minds: 1
  model: none — a no-go, its class empty (by S1-QF's route and by QFREE); with "no (Q) arc" dropped the class is inhabited (QFREE's model,
    FS114-Y2-BOWTIE, whose ring carries two (Q) arcs), so the statement is not empty for want of fragments
  prior art: partly: FS116-S1-QF (its own route through S1-LENS, S1-EXIT, S1-CLUSTER); FS129-OR1-QFREE
  handoff: de Bruijn — formalize QFREE (over FS116-Y4-EMPTY) and read S1-QF as its case; S1-QF's own route (LENS, EXIT, CLUSTER) is then a second route

derivation: FS129-SR2-TOUCHW
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a
    point of ω(p) which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose none of the four arcs of ω(p) just clockwise and
    just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and just counter-clockwise of w lies in tiles of one
    colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent colour X̄ and of no tile of colour X, and no tile of
    colour X̄ has w in its closure
  uses only: FS116-N1-TOUCH's argument (plans/FS116-N1-proof.md § 4.2), in which the hypothesis "w in the closure of a tile of one of p's colours" is
    idle (FS116-V3 § 3.1: TRUE with it idle; § 4.4's uses-only note); FS116-N1-TWIST-D; N-E1; FS116-N1-GERM-R with c = X̄ at all four germs; six colours
  not claimed: anything at k ≥ 7; anything when a germ lies on a (Q) arc; that such a point exists in any fragment of SAT-QFREE's class
  argument: § 3.2.3 FS129-SR2-TOUCHW, the argument
  verdict: derived
  grade: derived from: FS116-N1-TOUCH
  minds: 1
  model: FS116-Y1-F15's F(1/5) at q_N — the ring there is R with germs G, as TOUCH's model line says, and q_N meets the hypotheses with or without the idle one
  prior art: owed — in-house (FS116-V3 § 3.1 found the hypothesis idle; this entry states the wider form)
  handoff: de Bruijn — in place of FS116-N1-TOUCH; FS116-N2-RECIP's use of TOUCH reads it

#### 3.2.1 FS129-SR2-YESLIM-EQ, the argument

Fix `δ > 0` and take `R` with `(R√2)²/(R√2 + 2)² ≥ 1 − δ`. Let `Q` be the square of side `R√2` inscribed in a disc of radius `R` carrying a valid
`k`-coloured fragment, and `C_j` the union of the colour-`j` tiles inside `Q`. The `C_j` are disjoint, open, cover `Q` up to the tile boundaries (a
null set), and no two points of one `C_j` are at distance exactly 1, so their monochromatic unit pairs are `Leb ⊗ σ`-null. Lemma P (TQ § 3.1, its
"`Leb ⊗ σ`-null at distance 1" form) copies them on the lattice `(R√2 + 2)ℤ²`: points of different copies are at distance at least 2, so the copies
are `k` disjoint measurable classes with null unit pairs, of density `|Q|/(R√2 + 2)² ≥ 1 − δ`. As `δ` was arbitrary, FS106-EQ's (c) ⟹ (a) at `k`
gives `χ_m⁰(ℝ²) ≤ k`. ∎

#### 3.2.2 FS129-SR2-QFCASE, the argument

Let a fragment be in S1-QF's class. At `p` the four edges cut a small disc into four sectors; the four colours of `p` are on four tiles, so each tile
of `p` has one sector at `p`: the fragment is simple at `p` (FS-116's "simple": one sector per tile at `p`). It is non-Siamese, valid (six colours),
on a closed disc of radius 2 > 1 about a vertex of four colours, and its ring carries no (Q) arc. FS129-OR1-QFREE says no such fragment exists. ∎
Saturation and the right angles are not used.

#### 3.2.3 FS129-SR2-TOUCHW, the argument

FS116-V3 § 3.1 derived TOUCH as stated and found the hypothesis "`w` in the closure of a tile of one of `p`'s colours" idle: the three conclusions come
from the `σ`-images of the ring germs (TWIST-D, N-E1) and GERM-R's four open intervals with `c = X̄`, none of which reads whether `w` lies in such a
closure; V3's attack (§ 3.2) placed the only failure at a germ on a (Q) arc, which TOUCHW keeps excluded. ∎ (One mind on the wider statement: V3's
reading, recorded here as an entry so that the backlog formalizes the wider form.)

### 3.3 Additions to the vacuity sort (brief § Done means 3)

None found. Every row this sweep reached whose class is known empty is already in SR1's § 5.1 lists or is a no-go in nonexistence form (FS116-S1-QF,
FS114-N6-NOQ, FS114-N4-D, FS114-Y4-RSTOPALL, FS114-Y5-PINALL); the FS-112 statements over valid maps (FS112-DISC1 among them) are hypothetical by
design, valid maps being the class whose emptiness is the map NO.

## Stage 4 — SAVED: item 63, scoped and partly read; the additions to SR1's list for FS129-L1; expectations scored; hand-back

### 4.1 Item 63 — the GAP lines of the Lean order, lane R beyond FS-110 (brief § Done means 2(b)) — partial

`tools/fs129_sr2_gaps.py` keeps the lines of `data/fs129/index/open-steps.md` § 3 that open-steps.md places "after entry X" for X a lane-R row of the
Lean order in FS-111's, FS-112's, FS-114's, FS-116's or FS-121's derivation file: **27 lines in 24 entries**, listed in `data/fs129/sr2/item63-gap-lines.md`.
Read against what this pass holds (each line's full text in its file), sorted:

| class | lines (row, id) |
|---|---|
| **answered elsewhere, no link back** | **43 FS111-W-NOREP** (l. 488: "the same for general saturated colourings (GAP: (H2) at the partners is not among C11's hypotheses there)"): answered for honest saturated colourings satisfying REG-J′ by **FS121-DB1-L3** (at every point of Σ no colour occupies two sectors of positive angle, whatever cusps); what is left is saturated colourings that are not honest or not REG-J′. A correction for FS129-Z1: NOREP's not-claimed line points to L3 |
| answered in place (the entry or its errata already link the answer) | 55 FS112-BEND (closed by FS112-N2-BENDS); 53 FS112-ISO (N112-RED's GAP, closed by FS112-N2-RED); 94 FS114-N5-GRING (N5-RV's GAP, FALSE by NB5-RVKILL); 124 FS116-N3-CROSS (V5's blind GAP, its stall closed); 58 FS112-N2-RAY and 74 FS112-N2-TERM (the stuck ray and one-sided chains: bypassed for the NO by FS114-CV-EXISTS, "no ray step", erratum item 4 of `plans/FS112-derivation.md`; open only for GS-4's density form, FS-115) |
| open, the frontier's own (a scope marker naming an open stub) | 97 FS114-N6-NOQ, 99 FS114-N7-QOPP, 102 FS114-N7-3T (×2), 125 FS116-RING-Q-PRIME, 126 -RING-Q-PRIME-S, 128 -RING-TRANSFER-C, 155 -RING-TRANSFER-QC: (Q) rings, RING-Q, RING-TRANSFER-Q and SEMI-PAR3 — FS-124's; 98 FS114-Y5-PINALL (×2): E1, E2 — FS114-Y6-E1CAP, -Y6-E2RED's residues, item 81 lead 1; 85 FS114-N2-ENDS: route T's GAP-μ and Siamese maps — FS-117 |
| **not read here, for FS129-SR3** | 28 FS111-M-PINCH (ll. 442, 447: the same without (H1) or (H2); VMW's stage-1 GAP at cusp partners); 31 FS111-M2-INT (l. 853: the same for the interior of a support — to read against FS111-M3-IRREG's pinch points, which may refute it); 65 FS112-SIX (l. 49: de Grey's covering step); 63 FS112-N3-PAIRS (l. 165); 67 FS114-BV-HEX (l. 968: row 134's Lemma 4 at cusps, not landed); 95 FS114-Y3-RSTOP (l. 607: Y3-D2 without reading R-T); 138 FS116-S1-KAPPA (l. 816); 188 FS121-D1-VT (l. 263: reading (B) — to read against FS121-V2-VT-W, SR1's stronger form) |

control: fs129-sr2-gaps
  of: § 4.1 — open-steps.md § 3 holds 27 GAP lines inside Lean-order lane-R entries beyond FS-110, in 24 entries
  run: cd .. && python3 tools/fs129_sr2_gaps.py
  expect: GAP lines in Lean-order lane-R entries: 27 in 24 entries
  fault: cd .. && python3 tools/fs129_sr2_gaps.py --fault

### 4.2 Items (c), (d), (e) — not reached

Not worked by this agent, and left whole for FS129-SR3 as SR1's § 4.2 states them: **(c)** item 81's three leads — G83's straddle against FS114-K1's
(Q)-ring residues (FS114-Y6-E2RED's survivor S6, the wrap, the Reuleaux `(2, 1, 1, 0)` past `√3`; FS129-SR1-TWOCIRC first, S1 having died to PXKILL);
V6-ADJ at adjacent change points whose outer pairs are off (Q); the coupling of two circles' windings for FS106-BIKE (FS129-SR1-RINGBAND sharpens the
one-circle input); **(d)** a wider V6-ADJ, DOUBLETIP's analogue (the same as (c)'s second lead; RING-GERM (ii) at both points and V6-ADJ's pinning of the
outer tiles to the lens arcs, TWOCIRC for the mirror apex); **(e)** group 5's stall — an O1-OUT analogue for valid maps (FS121-D2-SYM's window
hypothesis moved to FS112-N3-PER). One input for (e) this pass did read: FS121-DB1-L7 (INTRAD's outward step, REG-J′ not used) is the saturated-colouring
continuation property; a valid map has no saturation, so its analogue must come from the map's own stuck chains (FS112-N2-RAY's pencil), not from L7.

### 4.3 Additions to SR1's list for FS129-L1 (the Lean backlog's input; brief § Done means 5)

Read with `plans/FS129-SR1-audit.md` § 6.2, which stands; numbering continues it.

**Formalize X in place of A, B, C:**

9. **FS129-SR2-CLOSURE** (as FS111-M2-INT's corollary for open sets, or by V0-CLOSE's translation argument) in place of **FS106-DIAM (iii)**,
   **FS111-V0-CLOSE** and **FS116-V5-NE1's first clause**; and **FS106-DIAM (i)** (a connected set with no unit pair has diameter at most 1) once, in
   place of the connectedness step inside FS116-V5-NE1's "in particular", FS106-TS-C, FS116-V4-DICHOTOMY's "A ~ A" and FS111-V0-CLEAN's diameter step.
10. **FS129-SR2-HULLSET** in place of **FS111-C-HULL** (one measurable set with null unit pairs; no colouring, tightness or normal form). FS111-M-HULL2 over
    it; FS116-V4-DICHOTOMY's first clause is HULL2's case for two open tiles.
11. **FS129-SR2-SUPK** (every `k`) in place of **FS106-SUP** (six); FS106-EQ's (c) ⟺ (d) as its corollary at the value 1, and **FS106-COMP's first
    clause** as FS106-EQ's (c) ⟹ (a), stated at every `k`.
12. **FS106-TS-T** in place of **FS112-DISC1** (FS129-SR2-DISC1TS).
13. **FS112-N2-BENDS** (or SR1's BENDANY) in place of **FS112-BEND**; **FS112-N2-TERM** in place of **FS112-N2-RED** (RED's procedure as TERM's lemma).
14. **FS114-L60-LE** in place of **FS112-L60**.
15. **FS114-N2-ENDS** in place of **FS114-N3-JOINT's first clause** (one identity: `Σ n = 2N`).
16. **FS114-Y4-RSTOPALL** in place of **FS114-N4-D** and **FS114-N3-DR** (both cases; N4-D a second route). FS114-Y3-RSTOP stays separate (Siamese
    pairs allowed).
17. **FS111-M-COVER-SC's semiconcavity** (every maximal cover) in place of **FS111-M2-HULLC's semiconcave clause** (regular classes).
18. **FS106-EQ's (c) ⟹ (a) at every `k`** once (the weak-* step), and **FS116-O1-YESLIM** as its corollary by Lemma P (FS129-SR2-YESLIM-EQ), in
    place of YESLIM's own weak-* argument.
19. **FS129-OR1-QFREE** in place of **FS116-S1-QF** (FS129-SR2-QFCASE); S1-QF's route (S1-LENS, S1-EXIT, S1-CLUSTER) is then a second route.
20. **FS129-SR2-TOUCHW** in place of **FS116-N1-TOUCH** (its idle hypothesis dropped).
21. **FS116-RING-Q-PRIME-S** in place of **FS116-RING-Q-PRIME**; **FS116-N1-TWIST-D** in place of **FS116-RING-TWIST-C's first clause** and of
    **FS116-V5-RING's first two clauses**.
22. **FS121-DB1-L3** in place of **FS111-W-NOREP**.

**Do not formalize as stated:**
- **FS112-L60** (FALSE at exactly 60°; its erratum), **FS112-BUDGET2** (FALSE as stated), **FS111-C-HULL-SO** (refuted) — the last two are in the order
  only through false edges.
- Quote **FS112-C-ENDS** in its erratum's form (residue deleted), and **FS112-C-DOUBLE**, **FS112-N3-BASE**, **FS114-N2-ENDS**, **FS114-N3-JOINT**,
  **FS114-N7-3T** with the errata under them (§ 2.4): the backlog quotes entries by script and the index carries no erratum.
- No result this pass reached is empty beyond SR1's fifteen (§ 3.3).

**Index corrections the order needs** (§ 2.3): drop the 19 false and reversed edges of § 2.3 with SR1's 14; mark § 2.3's 3 route edges with SR1's 6.
Then lane-R cycles go from 11 to 2, and the Lean order from 197 rows to 171 (160 if it follows first routes); `tools/fs129_sr2_cycles.py -v` lists the
rows that leave. Among them are FS106-EQ, -COMP, -REM and FS111-V0-CLEAN, -C1-PW: results that no seed rests on, not results without value — the
backlog session decides whether to keep them.

### 4.4 Registered expectations, scored

| registered (stage 1) | outcome |
|---|---|
| merges in the 151 rows: 8 (3–15) | **18** (one statement, a case, or a stronger form held): DIAM (iii)/V0-CLOSE/V5-NE1 (CLOSURE); DIAM (ii) in TS-C; COMP (i) in EQ; DISC1 in TS-T; BEND in N2-BENDS; RED in TERM; L60 by L60-LE; JOINT in N2-ENDS; N4-D and N3-DR in RSTOPALL; YESLIM in EQ; S1-QF in QFREE; Q-PRIME in Q-PRIME-S; TWIST-C (i) and V5-RING (i)–(ii) in TWIST-D; NOREP in DB1-L3; N3-PAIR in V5-DICHO's setting; V5-TIPSET/V6-HUBS — above the range |
| hypotheses weakened, derived: 2 (0–5) | **4** (HULLSET, SUPK, TOUCHW; and COVER-SC's semiconcavity standing without HULLC's regularity, a line) |
| results the vacuity lists missed: 2 (0–6) | **0** |
| records that disagree: 3 (1–8) | **6**: COVER-SC's "superseded by HULLC"; EQ (every `k`) resting on SUP (six); RSTOP "a member of RSTOPALL" (Siamese allowed); OR1 § J3's non-simple remainder for S1-QF (empty); NOREP's GAP answered by DB1-L3 with no link; the index quoting L60 and C-ENDS without their errata |
| item 63: GAP lines answered or shortened elsewhere: 4 (1–10) | **1** answered with no link back (NOREP by DB1-L3), 6 answered in place, 11 open (the frontier's own); 8 lines not read (partial) |
| item 81 lead 1, P = 0.30 | not reached — unscored |
| item 81 lead 2 / (d), P = 0.45 | not reached — unscored |
| item 81 lead 3, P = 0.10 | not reached — unscored |
| (e), P = 0.15 derived, 0.15 refuted | not reached — unscored |
| a held result found false, P = 0.12 | **no** (FS112-L60 and BUDGET2 were already filed false) |
| reach the end of the sweep, P = 0.55 | **yes** |

Brier on the two scored binary predictions (false result 0.12 → 0; sweep finished 0.55 → 1): (0.0144 + 0.2025) / 2 = **0.108**. The merge count missed
high by a factor of two: most of the extra merges are the same lemma proved in two eras' vocabularies (density sets against open tiles; maps against
fragments), which no pass before this one compared row by row.
