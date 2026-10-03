# WORKFLOW3-CL3 — the search ban's log lines, counted

*Job CL3 (the Clerk), 2026-10-03. Brief `data/workflow3/briefs/CL3-ban-audit.md`. A count of what the record says; whether the ban helped or hindered is Kooshi's, from these counts.*

## Stage 1 — SAVED: the readback, the file list, the extraction script and its failing plant

**Readback.** The brief's one quotation (Kooshi, 2026-10-03, "As for the ban - have a clerk count …") is verbatim at `plans/FS116-close-inventory.md` row O7: matches. The brief's addresses exist: FS116 items 82, 86 (rulings), 122, 139 (Y4-EMPTY), 129 (the standing-rule-5 question). `CLAUDE.md` § Toolchain's ban paragraph and `plans/STANDING-RULES.md` rule 5 exist as cited. No mismatch found.

**Finding about the brief.** It says about 277 files mention the phrase; `grep -rIli 'would.have.searched' plans data` finds 469 on 2026-10-03 (151 are briefs, which only instruct a job to keep the log; 8 are reports, which only point at it). 291 files hold at least one extracted log unit (`data/workflow3/cl3/raw_units.tsv`). Every file with a unit has a first commit on or after 2026-09-24 (the phrase first appears with the ban), so the date filter removed none.

**How the sections were found** (`tools/cl3_extract.py`): (H) a heading line containing the phrase (spaces or hyphens, any case), the section running to the next heading of the same or a higher level; (L) a non-table line that opens with the phrase or carries it in an emphasised label (`**…**`, `*…*`), its text after the label and its continuation lines, or, when the label stands alone, the list under it; (I) a sentence that opens "Would have searched here:" inside a paragraph; (M) two units added by hand (`plans/CRUNCH-2026-09-26-x2x3-INDEX.md` 244, `plans/FS111-M3-finiteness.md` 376). A unit is one bullet, numbered item, table row or paragraph, its continuation lines joined; table headers, separator rows and bare labels are dropped. Mentions that are not logs (briefs, plan text saying "every brief carries the log", ranges of instruction text) are in `other_mentions.tsv`, not counted.

**Plant.** Each of the four scripts has a `selftest` and a `--plant` run, shown to fail: `data/workflow3/cl3/plants.txt` (extract: a bullet removed, 5 of 6 units, exit 1; classify: N lines misread, exit 1; candidates: the planted line names no identifier, exit 1; rulings: a nonexistent row, exit 1). All four plain selftests pass, exit 0. The first extraction self-test failed on my own wrong expected count (7 for 6), and the first extraction took 465 "L" units from close inventories and plan text (table rows and instruction lists that merely mention the log); that was caught by reading the L units and repaired (table rows excluded from L, label must open the line), which is why the counts below rest on a reviewed extraction.

## Stage 2 — SAVED: the lines sorted, the rulings copied, the context counts

**Sorting.** `tools/cl3_classify.py` classes each unit from its own words, in this order: **N** if it opens "none / nothing / no search …" and names no open marker; else **O** if it carries a *strong* open marker (GAP, left open, stall, deferred, post-ban / after 2026-10-01, not established, stated as open, named as a step or debt); else **R** if it carries a result word (instead, derived, proved, exact, checked, by hand, replaced, lemma, obstruction, count, → …); else **O** if only a *weak* marker (not run, not done, did not, not built, not attempted); else **U**. The order is my reading of the brief's rule: a line that says only that the search was not run still says nothing about the step staying open if a result is named, because every log line says the search was not run. **Mixed O**: an O line that also names a result reached ("instead derived X … left GAP") is counted O and carries the flag `also-R`; the count of such lines is given below so the bound is visible. Then every U and every O was read by me, and 32 overrides were set by hand from the line's words (`data/workflow3/cl3/overrides.tsv`, each with its reason: 26 set a class, 6 drop absorbed non-log text; the script then dropped 7 override-dropped, 8 placeholder, 15 "papers for Kooshi" lines of `plans/FS67-PA-close.md`, and 49 + 2 + 7 lines of mixed files `M3-exotic-colourings`, `FS89-rational-band-rigidity`, `PROTOCOL-crunch` that are instruction text). N lines longer than 110 characters (68) were read; none changed class. The R lines were scanned by their markers only, not read one by one: a limit of this count.

**Excluded from the count, and where listed.** Instruction and plan text with a log-shaped label (standing rules, stubs, hand-off, the queues; `tools/cl3_classify.py` `EXCL_FILES`); 8 placeholder lines; absorbed non-log lines (`EXCL_LINES`); and 40 *aggregate* lines (planners' and closes' re-counts of other jobs' lines, count tables): `data/workflow3/cl3/aggregates.tsv`. The stub files carry 10 forward-looking lines on what the ban excludes for the future milestone (not job logs): `plans/STUB-map-step.md` 179, `STUB-pinch-at-junction.md` 99, `STUB-reg-scale.md` 61, `STUB-regular-half-residuals.md` 55, `STUB-tangency-seam.md` 111, `STUB-cp-plane-six.md` 95, `STUB-collapse-cp-plane.md` 117, `STUB-harden-mr.md` 69, `STUB-regularity-wall.md` 143, `STUB-four-colour-rigidity-without-triangles.md` 126 — not classed.

**Dates.** *job_date* is the file's first commit; *written* is `git blame`'s commit date for the line's first line, and *AFTER* marks written after 2026-10-01. A line re-committed in a later pass shows the later date.

**Rulings and requests** (item 2): `data/workflow3/cl3/rulings.md`, 15 rows copied verbatim by `tools/cl3_rulings.py` (it fails loud on a missing or ambiguous row), including FS116 items 82 and 86 and O7. Rows that merely mention a search without ruling on one were left out; the choice of the 15 is mine and the search that produced the candidate list (115 rows, 33 after a kind-and-keyword filter) is not saved.

**Context counts** (item 3, `data/workflow3/cl3/context.tsv`): 44 derivation files first committed 2026-09-24 to 2026-10-03. `derivation:` blocks: 292, in five files (FS111 85, FS114 47, FS116 91, FS121 65, TC1 4). For the older shape, entries counted as lines opening `**ID — `: 704 in 20 files (FS79 49, FS81 25, FS85 39, FS86 68, FS89 64, FS91 73, FS67 20, FS75 7, M2 12, M3 46, R88 19, FS100 63, FS103 33, FS105 19, FS106 46, FS107 16, FS110 49, FS112 56). That counter agrees with the headers where a header states a number (FS75 "Seven entries", M2 "twelve theorems", FS103 33). The per-job derivation files (`FS100-X*D`, `FS84-S1`, `FS89-S1D`, `FS106-T*` …, 22 files) use neither shape and count 0 here: their entries are not counted, so 996 is a floor for entries in those files, and says nothing of non-derivation progress.

## Stage 3 — SAVED: the counts

All counts are over `data/workflow3/cl3/lines.tsv` (981 lines, one row per log line; columns: file, line, job, job_date, written, after_1001, text, class, mixed, cause_flag, written_epoch, candidates). "Job" below means the record file; a record that logs several jobs counts once, so job counts are of records.

```
TOTAL {'N': 358, 'R': 511, 'O': 103, 'U': 9} 981
MIXED O (also names a result) 58 of 103
O flagged nonban? 5
AFTER 10-01 {'N': 19, 'R': 8, 'O': 2}
O with candidates 49
### by milestone
| key | R | O | N | U | total |
|---|---|---|---|---|---|
| BASE | 4 | 1 | 0 | 0 | 5 |
| CRUNCH | 0 | 0 | 4 | 0 | 4 |
| FS100 | 49 | 7 | 64 | 0 | 120 |
| FS103 | 4 | 1 | 16 | 0 | 21 |
| FS105 | 11 | 0 | 12 | 0 | 23 |
| FS106 | 9 | 7 | 16 | 0 | 32 |
| FS107 | 7 | 6 | 3 | 1 | 17 |
| FS110 | 31 | 2 | 11 | 0 | 44 |
| FS111 | 27 | 4 | 6 | 0 | 37 |
| FS112 | 45 | 4 | 3 | 2 | 54 |
| FS114 | 77 | 3 | 6 | 2 | 88 |
| FS116 | 15 | 4 | 24 | 0 | 43 |
| FS121 | 16 | 8 | 9 | 0 | 33 |
| FS67 | 8 | 7 | 1 | 0 | 16 |
| FS75 | 0 | 0 | 15 | 0 | 15 |
| FS84 | 18 | 4 | 4 | 1 | 27 |
| FS85 | 27 | 5 | 1 | 1 | 34 |
| FS86 | 41 | 8 | 11 | 0 | 60 |
| FS89 | 19 | 3 | 2 | 0 | 24 |
| FS91 | 46 | 5 | 15 | 1 | 67 |
| M2 | 9 | 2 | 23 | 0 | 34 |
| M3 | 19 | 11 | 4 | 1 | 35 |
| PA | 2 | 1 | 1 | 0 | 4 |
| POROS | 25 | 10 | 32 | 0 | 67 |
| PROPOSAL-claude-md-knowledge-cache | 0 | 0 | 1 | 0 | 1 |
| PROTOCOL | 0 | 0 | 3 | 0 | 3 |
| RERANK | 0 | 0 | 2 | 0 | 2 |
| WORKFLOW3-CL1-bibliography | 0 | 0 | 1 | 0 | 1 |
| WORKFLOW3-CL2-n7-definitions | 0 | 0 | 1 | 0 | 1 |
| WORKFLOW3-TB1-ledger-check | 0 | 0 | 1 | 0 | 1 |
| WORKFLOW3-TC1-theory-corrections | 0 | 0 | 1 | 0 | 1 |
| WORKFLOW3-TP1-theory-paragraph | 0 | 0 | 1 | 0 | 1 |
| WORKFLOW3-X1-front-page | 0 | 0 | 1 | 0 | 1 |
| data:consolidation-2026-09-26 | 0 | 0 | 9 | 0 | 9 |
| data:consolidation-2026-09-27 | 0 | 0 | 12 | 0 | 12 |
| data:crunch-2026-09-25 | 1 | 0 | 10 | 0 | 11 |
| data:fs100 | 0 | 0 | 23 | 0 | 23 |
| data:fs103 | 0 | 0 | 1 | 0 | 1 |
| data:fs105 | 0 | 0 | 1 | 0 | 1 |
| data:fs106 | 0 | 0 | 1 | 0 | 1 |
| data:fs107 | 0 | 0 | 1 | 0 | 1 |
| data:fs110 | 0 | 0 | 1 | 0 | 1 |
| data:fs112 | 1 | 0 | 1 | 0 | 2 |
| data:gate-fix | 0 | 0 | 1 | 0 | 1 |
| data:m2 | 0 | 0 | 1 | 0 | 1 |
| data:reframe-2026-09-26 | 0 | 0 | 1 | 0 | 1 |
### by job kind
| key | R | O | N | U | total |
|---|---|---|---|---|---|
| Poros | 25 | 10 | 32 | 0 | 67 |
| construction | 32 | 3 | 7 | 0 | 42 |
| opening | 9 | 0 | 9 | 0 | 18 |
| other | 176 | 40 | 201 | 4 | 421 |
| proof | 100 | 24 | 42 | 1 | 167 |
| verifier | 169 | 26 | 67 | 4 | 266 |
### by job date
| key | R | O | N | U | total |
|---|---|---|---|---|---|
| 2026-09-24 | 42 | 5 | 3 | 1 | 51 |
| 2026-09-25 | 177 | 50 | 117 | 3 | 347 |
| 2026-09-26 | 53 | 10 | 138 | 0 | 201 |
| 2026-09-27 | 123 | 20 | 47 | 3 | 193 |
| 2026-09-28 | 85 | 6 | 17 | 2 | 110 |
| 2026-09-29 | 23 | 10 | 17 | 0 | 50 |
| 2026-10-03 | 8 | 2 | 19 | 0 | 29 |
RECORDS with a log (units): 278 ; with >=1 O: 71 ; with all N: 87
RECORDS-with-log by kind: {'other': 122, 'verifier': 76, 'proof': 38, 'opening': 4, 'construction': 13, 'Poros': 25} with O: {'verifier': 24, 'other': 26, 'proof': 12, 'construction': 3, 'Poros': 6}
```

**Reading the counts.** Lines by class: R 511, N 358, O 103, U 9 (total 981). Of the 103 O lines, 58 are *mixed* (they also name a result), 5 carry the flag `nonban?` (their words give budget, time box or a held-paper reason). 49 O lines have a candidate later entry. Written after 2026-10-01: 29 lines (N 19, R 8, O 2).

**Job-kind** is a guess from the record's file name (`jobinfo` in `tools/cl3_classify.py`); "other" (421 lines) holds plans with several jobs' logs, data-directory records, kernel-lane and reading jobs.

## The O lines, in full (103)

Format: `file:line` [flags] — the line verbatim — candidate later entries (a candidate, not a finding; the match is on identifier-like words and on "X's word" phrases, so a generic identifier can match many entries).

- `plans/BASE-V-verification.md:396` [also-R] — - | a search for the Lemma 4 configuration (nine endpoint vertices) on sampled maps | named the GAP (1b.5) instead |
- `plans/FS100-KT1-ambrus-ball.md:32` [] — - Would have tuned the grid until the margin closed — not done; the grid is J26's, unchanged. A refinement is run only if the verdict is `inconclusive`, and then with its shape fixed before it runs (Stage 3).
- `plans/FS100-X01V-verification.md:240` [also-R] — - EF_F: would have searched for a zero-entropy non-`E` measure (e.g. random invariant measures on finite quotients); instead derived the entropy-transfer content and the coset argument, and left the question as the named gap.
- `plans/FS100-X05V-verification.md:256` [also-R] — - Would have searched for a stationary four-colouring model on a toy abelian Cayley graph whose `E`-factor is a `J₀`-type wave, to test QTCA numerically. Instead: derived the equivalence (X05V-5), the spectral no-go (X05V-6) and the reduction (X05V-7), and left QTCA as a named GAP. — **a later entry names it: FS100-SPEC, plans/FS100-derivation.md; FS100-FLH, plans/FS100-derivation.md**
- `plans/FS100-X21D-derivation.md:329` [nonban?] — - Prior art: "look up `m_j(ℝ²)`, `j ≥ 2`, in the literature" — reading is allowed but not done in the time box; logged as a prior-art debt.
- `plans/FS100-X23V-verification.md:245` [also-R] — - Would have searched for a field realising the CLS gap by sweeping number fields. Instead: derived the local shape (`U_f(√3)`, `f` odd ≥ 7) and built one field by hand (ℚ(√3)·M₇, `M₇ ⊂ ℚ(ζ₂₉)`: 2 and 3 have order 28 mod 29), confirmed by one PARI factorisation (seconds). — **a later entry names it: FS100-CLS, plans/FS100-derivation.md; FS100-DLP, plans/FS100-derivation.md; FS100-G27, plans/FS100-derivation.md; FS100-TCA, plans/FS100-derivation.md; FS100-COR, plans/FS100-derivation.md; FS100-GF, plans/FS100-derivation.md**
- `plans/FS100-X27D-derivation.md:318` [] — - I would have tried to build a three-summand Sierpiński decomposition by computer on a finite set of circles. Not done (a finite-witness search); stated as open.
- `plans/FS100-X27V-verification.md:185` [] — - COL-E(pm): I would have tested points-to-measures on the ×2×3 circle numerically (empirical measures of random Følner schemes on a measure built from thick bad sets). Not done; named as a step. — **a later entry names it: FS100-X27D-ATT, plans/FS100-derivation.md; FS100-X27V-PM, plans/FS100-derivation.md**
- `plans/FS103-M-derivation.md:280` [also-R] — - a search over tight 5- or 6-colourings for a non-list-colourable boundary configuration; instead, the configuration was characterised (D1–D5) and left as the stated obstruction. *A hunch, not claimed:* two adjacent points of `E` cannot have `P(x) = P(y) = {a, b}` (a blow-up argument makes the colouring locally a function of `(· − x)·v`, and the unit-pair constraint then forces it constant); killing test: an a.e.-proper colouring with such a pair. Even if true it does not close D3 (lists of size two on non-cycles can fail).
- `plans/FS106-QB-verification.md:370` [nonban?] — - Would have reconstructed Parts's tiling numerically to test the endpoint `δ = δ₆` of C-Q-LOCAL — not a search, but outside the budget; left as the named GAP.
- `plans/FS106-TQ-derivation.md:39` [also-R] — - Stage 4: an optimiser over periodic grid-square partial six-colourings with slack `ε`, to trace `1 − µ₆(ε)` as `ε → 0`. Instead: the bracket `ε²/78 ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)` was derived (§4.2, §4.3), and the experiment is proposed for after the ban.
- `plans/FS106-TQ-derivation.md:486` [also-R] — - a tabu or local-search optimiser over periodic grid-square partial six-colourings with slack `ε`, to trace `1 − µ₆(ε)` as `ε → 0` (TQ-EQ (e) makes it the natural numerical experiment). Instead: the two-sided bracket `ε²/78 ≤ 1 − µ₆(ε) ≤ δ₆ + O(ε)` was derived, and the experiment is proposed for after 2026-10-01 (stub proposal in the report).
- `plans/FS106-TS-derivation.md:43` [also-R] — - Stage 4: C-T-BIKE — a scan over the arc offset for a 3-colouring; instead reduced to the forced set `F`, left GAP. — **a later entry names it: FS106-BIKE, plans/FS106-derivation.md; FS107-V-C5, plans/FS107-derivation.md; FS110-Y-BIKE-3C, plans/FS110-derivation.md**
- `plans/FS106-TS-derivation.md:260` [also-R] — - C-T-BIKE — a scan over the offset `φ` (and `d`) for an arc 3-colouring; instead the reduction to the forced set `F` was written and the claim left GAP. — **a later entry names it: FS106-BIKE, plans/FS106-derivation.md; FS107-V-C5, plans/FS107-derivation.md; FS110-Y-BIKE-3C, plans/FS110-derivation.md**
- `plans/FS106-VB-verification.md:215` [also-R] — - Would have run a small geometric search for the Obs. 1 counter-configuration inside an actual proper map colouring; instead recorded the local configuration and graded Obs. 1 a GAP, not FALSE.
- `plans/FS106-VB-verification.md:217` [also-R] — - Would have numerically traced the three complementary curves of Lemma 3; instead graded the step a GAP with the parity core verified.
- `plans/FS107-R-stability.md:328` [also-R] — - C-T-BIKE: the offset scan over `(φ, ψ)` for TS's shared-colour arc ansatz (`T₁(u)` in `{1, 2}`, `T₁(v)` in `{1, 3}`, alternating `π/3` arcs). Instead I worked two windows by hand at `d = 1.9`. With the colour-1 arc of `T₁(u)` at `[−30°, 30°)`, the branch gap `min(α + β) − max(α − β)` is 58.4°; shifted by 9° it is 59.3°; the ansatz needs `> 60°`. So the **pure `π/3`-arc ansatz fails narrowly there** (hand arithmetic, not a claim about C-T-BIKE: general tight 2-colourings of a circle are `E ∪ (E′ + 60°) ∪ …` for any `E ⊂ [0, 60°)`, and I did not use that freedom). I stopped rather than scan. — **a later entry names it: FS107-V-C5, plans/FS107-derivation.md; FS110-Y-BIKE-3C, plans/FS110-derivation.md**
- `plans/FS107-V-verification.md:215` [] — - The Parts calibration per junction: I would have coloured the Parts tiling from its figure and scanned its complementary pairs. Not done (the colour assignment is not in the text layer); the test was run at the level of constants (§2.1).
- `plans/FS107-VW-verification.md:222` [also-R] — - Cusp counterexamples to W-TAN's first clause under (Tm): I would have searched for a local cusp configuration. Instead I named the step C-T-TAN does not cover, and derived no counterexample (GAP, not FALSE). — **a later entry names it: FS107-R-CP, plans/FS107-derivation.md; FS107-W-TAN, plans/FS107-derivation.md; FS107-K-C6, plans/FS107-derivation.md; FS107-MEET, plans/FS107-derivation.md; FS110-CALC, plans/FS110-derivation.md; FS110-CUSP-K, plans/FS110-derivation.md**
- `plans/FS107-W-near-colourings.md:27` [also-R] — - | 2 | Scan HX's spacing `D`, void `ρ` or triangle shape for a smaller stall | Derived the stall exactly (3.3) and placed four members by the derivation |
- `plans/FS107-W-near-colourings.md:319` [also-R] — - the natural next move — scan `(D, ρ)` or the triangle shape for a smaller stall — is an optimiser; instead the stall was derived (3.3) and the members placed by the derivation.
- `plans/FS107-stability.md:21` [nonban?] — - §PA: an OpenAlex cross-check of the citing lists (not a search for a witness; skipped for budget, named as a debt in §PA row 7).
- `plans/FS110-YB-verification.md:14` [also-R] — - Y-BIKE-3C: I would have scanned the offsets `(φ, ψ)` of the two circles' 60° grids for a colouring whose cross curve passes through grid vertices (the case my argument leaves open). Instead: one candidate was derived by hand (a grid vertex at a point of the cross curve with `θ + η = 240°`, its swap partner then also a vertex) and checked at one `d`; the rest is recorded as a GAP (§3.6). — **a later entry names it: FS110-N2-RING, plans/FS110-derivation.md; FS110-Y-BIKE-3C, plans/FS110-derivation.md**
- `plans/FS110-YB3-verification.md:235` [also-R] — - Would have searched for a local fragment where `W` jumps across a same-type edge; instead named the picture (§2.4) and left it a GAP.
- `plans/FS111-M2-regularity.md:472` [] — - for a saturated six-colouring, or a chain of radius 2 — did not; the object side is W's and, by W-NEG, would be `χ_m⁰ ≤ 6`. — **a later entry names it: FS111-W-NEG, plans/FS111-derivation.md; FS111-W-SEA-PACK, plans/FS111-derivation.md**
- `plans/FS111-M4-cascade.md:42` [also-R] — - Stage 4: would have searched for the cascade's end state (a partition after M3-MOVE) → did not; derived that it is carried by the ladder and named the singular set as the open step. — **a later entry names it: FS111-M3-MOVE, plans/FS111-derivation.md; FS111-M3-COVER, plans/FS111-derivation.md; FS111-M4-MOVE, plans/FS111-derivation.md**
- `plans/FS111-VMW-verification.md:42` [] — - Stage 1: would have searched for a saturated seven-colouring with positive-density partners (the reading under which R7 fails) — did not; recorded it open (§1.5 (e)).
- `plans/FS111-cone-scale.md:30` [also-R] — - Card 1: a numerical study of `δ₀(K)` along `K` (optimised designs of growing complexity) to see whether it tends to 0 → instead derived that seven is exactly its uniform positivity (C1-UNIF); the dial is FS-109's, post-ban. — **a later entry names it: FS111-C1-UNIF, plans/FS111-derivation.md; FS111-C1-PW, plans/FS111-derivation.md; FS111-C1-GAP, plans/FS111-derivation.md; FS111-C1-ROUTES, plans/FS111-derivation.md**
- `plans/FS112-N-proof.md:32` [] — - N112-RED's termination and end-vertex cases could be probed by enumerating vertex figures at an arc's end: not done; named as a GAP. — **a later entry names it: FS112-N2-RED, plans/FS112-derivation.md; FS112-SEAMS-TWO, plans/FS112-derivation.md**
- `plans/FS112-N-proof.md:329` [] — - The stuck ray's realisability (a family of horn lines): not built; named GAP (N2-4, N2-5). — **a later entry names it: FS112-N2-FLANK-Q, plans/FS112-derivation.md; FS112-N2-RAY, plans/FS112-derivation.md; FS112-N2-TERM, plans/FS112-derivation.md; FS112-N2-DENSE, plans/FS112-derivation.md; FS112-DISC1, plans/FS112-derivation.md; FS112-C-ENDS, plans/FS112-derivation.md**
- `plans/FS112-N-proof.md:579` [also-R] — - whether the stuck ray is realisable (a line of horn pairs; a parameter family by formula with an exact check would be in-ban, but its free parameters were not derived) — named as a GAP instead.
- `plans/FS112-NB3-verification.md:35` [also-R] — - NB3-I's residue (mutual both-centres): I would have searched for a local fragment; named as a GAP instead.
- `plans/FS114-N3-proof.md:37` [] — - | build and check a DR fragment by solver or by a parameter scan | not done: the fragment is the construction side's kind of object; stated as K1's killing test (§2.3) |
- `plans/FS114-NB6-verification.md:42` [also-R] — - | build a fragment by formula with a (Q) arc ending 60° after a change point, to decide N6-WIN (iii) | read the strip's `P_1` (a held rebuild) as a near-instance; the sub-case left a GAP (§1b.2) | — **a later entry names it: FS114-N6-NOQ, plans/FS114-derivation.md**
- `plans/FS114-YB4-verification.md:30` [also-R] — - | 1b | build a both-(B) alternating fragment by formula to see whether it survives | none built: recorded as a GAP in my derivation, to be read against the side's argument in stage 2 |
- `plans/FS116-V2-verification.md:369` [] — - A search for a fragment with a qualifying window (a model for RING-TWIST-C's window clauses): out under the ban and not attempted; the clauses are verdicted as the conditionals they are. — **a later entry names it: FS116-N1-QFREE4, plans/FS116-derivation.md**
- `plans/FS116-Y2-construction.md:28` [also-R] — - Stage 2: (a) I would have searched re-rimmings of the disk for the disk-corner configuration beyond `φ`; instead I derived where any obstruction of it must read (FS116-Y2-DCREAD) and recorded the held stalls of the rim moves. (b) I would have searched colourings of the outer layers of a six-colour flower for the largest radius; instead the forced colours (the sector straddles, lens adjacency, the two cyclic patterns) were derived by hand and the stop point proved (FS116-Y2-SIXOFF); the one fragment built (FS116-Y2-SIXFRAG) is given by formula, its colouring the pattern the derivation forces. — **a later entry names it: FS116-Y2-DCREAD, plans/FS116-derivation.md; FS116-Y2-SIXFRAG, plans/FS116-derivation.md; FS116-Y2-SIXOFF, plans/FS116-derivation.md; FS116-N2-SIXRING, plans/FS116-derivation.md; FS116-C114-LOCAL-F, plans/FS116-derivation.md**
- `plans/FS116-Y3-construction.md:48` [also-R AFTER] — - Stage 4: would have searched colourings of the outer wedges about HEX3's star toward radius 2 (and, after 2026-10-01, a solver could have been asked); instead read one branch at `2y_0` by hand and stopped, writing the stalled form (§ 4.3). — **a later entry names it: FS116-N2-STAR, plans/FS116-derivation.md; FS116-N2-RECIP, plans/FS116-derivation.md; FS116-N2-ANTI, plans/FS116-derivation.md; FS116-N2-HEX6, plans/FS116-derivation.md; FS116-N2-HEX3, plans/FS116-derivation.md; FS116-RING-TRANSFER-C, plans/FS116-derivation.md; FS116-Y3-TIPS, plans/FS116-derivation.md; FS116-Y3-HUBCOL, plans/FS116-derivation.md; FS116-Y3-NBTIP, plans/FS116-derivation.md; FS116-Y3-STARFORCE, plans/FS116-derivation.md; FS116-N3-STAR2, plans/FS116-derivation.md; FS116-N3-SEMI, plans/FS116-derivation.md (+7 more)**
- `plans/FS116-Y4-construction.md:52` [also-R AFTER] — - Stage 3: would have searched colourings of the second shell (and, after 2026-10-01, asked a solver); instead compared two of round 3's derived edges, which ended the question.
- `plans/FS121-D1-proof.md:36` [also-R] — - Stage 2: would have run a finder for the band structure of the corner (non-concentric interfaces in the disc sector and band 1 over the window, with z's colours fixed at q, r, s). Did not; derived FS121-D1-FIRSTORDER, -EROSION and -R2CORNER, and named the band structure as the GAP. — **a later entry names it: FS116-Y1-STRIPCEIL, plans/FS116-derivation.md; FS121-D1-XCORNER, plans/FS121-derivation.md; FS121-D1-EROSION, plans/FS121-derivation.md; FS121-V2-EROSION-DIAM, plans/FS121-derivation.md; FS121-D1-FIRSTORDER, plans/FS121-derivation.md; FS121-D1-R2CORNER, plans/FS121-derivation.md; FS121-R2-FOUR, plans/FS121-derivation.md**
- `plans/FS121-D1-proof.md:38` [also-R] — - Stage 3: would have run a finder for a transverse subdivision of the offset-pencil sub-bands. Did not; built the radial structure by formula (FS121-D1-DOUBLE) and named the transverse subdivision as the GAP. — **a later entry names it: FS121-D1-DOUBLE, plans/FS121-derivation.md; FS121-R2-FOUR, plans/FS121-derivation.md; FS121-CURVED, plans/FS121-derivation.md**
- `plans/FS121-D1-proof.md:413` [] — - a finder for that transverse subdivision; did not.
- `plans/FS121-D2-proof.md:30` [] — - Stage 1: would have searched for a saturated colouring with a curved interface whose pieces accumulate (a finder over piecewise-circular fronts with prescribed ladders). Did not; the recognition below asks what every LRA configuration must carry first. — **a later entry names it: FS121-O1-PER, plans/FS121-derivation.md; FS121-O1-LRA-LINE, plans/FS121-derivation.md; FS121-CURVED, plans/FS121-derivation.md; FS121-SAT6, plans/FS121-derivation.md; FS121-D2-THIN, plans/FS121-derivation.md; FS121-D2-SYM, plans/FS121-derivation.md; FS121-D2-PERFIN, plans/FS121-derivation.md; FS121-NOLRA, plans/FS121-derivation.md; FS121-V5-SYM-CPT, plans/FS121-derivation.md; FS121-Z1-NOCURVED, plans/FS121-derivation.md**
- `plans/FS121-D2-proof.md:34` [also-R] — - Stage 3: would have run a finder for an aperiodic saturated colouring with thin pencils. Did not; the open step is named for a derivation.
- `plans/FS121-D2-proof.md:381` [also-R] — - a finder for an aperiodic saturated colouring with thin pencils — did not; the step is named for a derivation.
- `plans/FS121-DB1-verification.md:31` [] — - Would have searched here: for a saturated colouring with a curved tangent interface or with LRA, to test C121-OUT's and C121-LRA-LINE's classes on an object. Did not: the ban, and the object is C121-CURVED's and C121-NOLRA's question (other jobs'); the attacks say that no object tests these classes. — **a later entry names it: FS121-O1-PER, plans/FS121-derivation.md; FS121-O1-LRA-LINE, plans/FS121-derivation.md; FS121-CURVED, plans/FS121-derivation.md; FS121-SAT6, plans/FS121-derivation.md; FS121-D2-INCURVED, plans/FS121-derivation.md; FS121-D2-THIN, plans/FS121-derivation.md; FS121-D2-SYM, plans/FS121-derivation.md; FS121-D2-PERFIN, plans/FS121-derivation.md; FS121-NOLRA, plans/FS121-derivation.md; FS121-V5-SYM-CPT, plans/FS121-derivation.md; FS121-Z1-NOCURVED, plans/FS121-derivation.md**
- `plans/FS121-V2-verification.md:25` [also-R] — - | search for a saturated colouring with an interface chain holding an interior radius-1 piece curving toward `b`, to decide FS121-D1-VT under reading (B) | worked the corner by hand (§ 2.6); reported GAP under (B), derived under (W) | — **a later entry names it: FS116-Y1-STRIPCEIL, plans/FS116-derivation.md; FS121-D1-VT, plans/FS121-derivation.md; FS121-D1-EROSION, plans/FS121-derivation.md; FS121-D1-R2SMOOTH, plans/FS121-derivation.md; FS121-D1-RUNG2, plans/FS121-derivation.md; FS121-D1-R2CORNER, plans/FS121-derivation.md; FS121-D1-PENCILWIN, plans/FS121-derivation.md; FS121-CURVED, plans/FS121-derivation.md**
- `plans/FS67-J27D-derivation.md:322` [also-R] — - | a 3-colouring finder on the nonzero-winding part of `E_3(C₅)` (60 maps, 60 edges) | not run; DB-1 left GAP at that step; its structure evaluated exactly (a fixed 243-map set — at the edge, logged) | — **a later entry names it: FS67-DB1R, plans/FS67-derivation.md; FS67-W, plans/FS67-derivation.md; FS67-DB1Z, plans/FS67-derivation.md; FS67-C5, plans/FS67-derivation.md; FS67-DD2N, plans/FS67-derivation.md**
- `plans/FS67-J27D-derivation.md:323` [] — - | a hunt for a 3-gap-free `G` with `χ(E_3(G)) ≥ 4` (a DB-1 counterexample) | not run; post-ban stage PB-1 below | — **a later entry names it: T1, plans/ASTRA-2026-09-14-derivation.md; T6, plans/ASTRA-2026-09-14-derivation.md; T7, plans/ASTRA-2026-09-14-derivation.md; T9, plans/ASTRA-2026-09-14-derivation.md; FS100-L0, plans/FS100-derivation.md; FS100-KS2, plans/FS100-derivation.md; FS100-CP, plans/FS100-derivation.md; FS100-X1, plans/FS100-derivation.md; FS100-X2B, plans/FS100-derivation.md; FS100-KS3, plans/FS100-derivation.md; FS100-T5, plans/FS100-derivation.md; FS100-R, plans/FS100-derivation.md (+476 more)**
- `plans/FS67-J27D-derivation.md:324` [] — - | a sweep of regular graphs `X` for a Hedetniemi partner with `μ_min(X) ≥ −d/(k−1)` (DD-2) | not run; the ingredient named; PB-2 below | — **a later entry names it: FS67-DD2R, plans/FS67-derivation.md; FS67-DD2N, plans/FS67-derivation.md**
- `plans/FS67-J27D-derivation.md:327` [] — - | searching IS-imprimitive vertex-transitive graphs with connected dual solutions (Zhang's exception) | not run; DD-1's sub-question left GAP | — **a later entry names it: FS67-DD1, plans/FS67-derivation.md**
- `plans/FS67-J27D-derivation.md:329` [also-R] — **Post-ban stages (≥ 2026-10-01; not queued):** PB-1 — an exact 3-colouring finder on `E_3(G)`'s nonzero-winding part for `G = C₅`, `C₇`, `K₃ × C₅`, generator image stated (G21); a found colouring suggests the missing construction, a refusal at `C₅` is FALSE for DB-1's first clause (not for its gap-free clause). PB-2 — spectra of `[Tardif2023]`'s `Ω_w(K_m)` and of the factors in `[Tardif2022frac]` once held. — **a later entry names it: FS121-D1-FIRSTORDER, plans/FS121-derivation.md; FS121-R2-FOUR, plans/FS121-derivation.md; FS67-DB1R, plans/FS67-derivation.md; FS67-DB1Z, plans/FS67-derivation.md; FS67-C5, plans/FS67-derivation.md; FS67-DD2R, plans/FS67-derivation.md**
- `plans/FS67-J27V-verification.md:62` [] — 3. *Would have searched for a regular graph `X` with `λ_min(X) ≥ −d_X/(k−1)` and a Hedetniemi partner (V-DD-2).* Declined; GAP recorded (§2.10). — **a later entry names it: FS100-L0, plans/FS100-derivation.md; FS100-KS2, plans/FS100-derivation.md; FS100-CP, plans/FS100-derivation.md; FS100-X1, plans/FS100-derivation.md; FS100-X2B, plans/FS100-derivation.md; FS100-KS3, plans/FS100-derivation.md; FS100-T5, plans/FS100-derivation.md; FS100-R, plans/FS100-derivation.md; FS100-EQ, plans/FS100-derivation.md; FS100-C45, plans/FS100-derivation.md; FS100-T1, plans/FS100-derivation.md; FS100-K0, plans/FS100-derivation.md (+462 more)**
- `plans/FS67-tight-products.md:474` [] — - | The stub's D2: SAT with model counting over tight Cayley graphs ≤ 100 vertices against `K₄`, the spindle, `UD(𝔽₇, 2)` | Moved to PB (post-ban), with its generator image to be stated; the question it asked ("is gap-freedom enough?") answered at `k ≥ 4` by print (DSW + Tardif 2023) | — **a later entry names it: FS67-DA3, plans/FS67-derivation.md**
- `plans/FS84-S1-derivation.md:368` [nonban?] — - Would have computed the odd girth of `Cay(Λ₂₄₀, U₂₄₀)` by a meet-in-the-middle sum search to fix `W`; not run (budget), named as S1d's next step.
- `plans/FS84-S1V-verification.md:170` [] — - | V3 (ii) | a `Θ₄` tree over candidate lattices plus a colouring finder, for a four-colourable `Λ` with `Θ₄ = ∅` | GAP, with the route named | — **a later entry names it: FS100-L0, plans/FS100-derivation.md; FS100-KS2, plans/FS100-derivation.md; FS100-CP, plans/FS100-derivation.md; FS100-X1, plans/FS100-derivation.md; FS100-X2B, plans/FS100-derivation.md; FS100-KS3, plans/FS100-derivation.md; FS100-T5, plans/FS100-derivation.md; FS100-R, plans/FS100-derivation.md; FS100-EQ, plans/FS100-derivation.md; FS100-C45, plans/FS100-derivation.md; FS100-T1, plans/FS100-derivation.md; FS100-K0, plans/FS100-derivation.md (+462 more)**
- `plans/FS84-SI-D-derivation.md:230` [also-R] — - Would have searched ℚ(√11) (or ℚ, ℚ(√3)) for a stationary four-colouring with an anticorrelated off-`E_S` part, to turn SI's "⟸" GAP into a FALSE. Instead: proved (SI-5) that one such colouring suffices and that none is needed if none exists — the step is equivalent to that open existence question.
- `plans/FS84-SI-V-verification.md:299` [also-R] — 4. *Would have* searched for a non-window, non-local random colouring over ℚ with overlapping `E_S`-supports and parity in its factor (a counterexample to (SI)'s "⟸"). *Instead:* named the step as a GAP and proved the window shape is excluded (J46-4).
- `plans/FS85-C-Coxeter.md:237` [] — 5. (PL): would have searched small subgraphs of `Λ` for a certificate that the pair index is additive. Not done; (PL) left open.
- `plans/FS85-C-Coxeter.md:413` [] — 6. Whether the 5-family graph has colourings with order-10 spectrum: would have asked a solver on `Λ₅/40Λ₅`. Not done; the 5-part is left open.
- `plans/FS85-C-Coxeter.md:415` [] — 7. Would have searched for a G481-analogue for families ±3, ±4. Not done; R2.4 explains why G481 cannot reach them.
- `plans/FS85-C-deBruijn.md:437` [also-R] — 8. Would have enumerated the colourings of the finite quotient `M/2(T₀ ⊕ η²T₀)`-type system to see which families of `η²T₀`-stripes survive E1–E2 (gap A). Instead derived it by the D/C case analysis of dB11 step 3.
- `plans/FS85-input-audit.md:110` [] — - Where a cell was hard to read, the obvious move was to try the candidate digits and keep the one that walks — a search over readings. Not done: every cell was read at 1.5× before any walk, and none needed a second reading after one.
- `plans/FS86-C-Coxeter.md:574` [also-R] — 2. Would have searched for a gapped four-colouring of a dyadic target of some extension of ℚ(√59) (e.g. `U₈ = Cay(𝔽₆₄, μ₉)` via the real cubic of conductor 7), to get a "no" through C6. Instead: derived C7 — no such gap exists, by transfer from VK.
- `plans/FS86-C-deBruijn.md:783` [also-R] — 4. A SAT or colouring search on finite pieces of ℚ(√−709)'s plane for a non-periodic colouring, or for a triangle-free forcer — instead: Theorem C (`F_μ = P` by derivation) and the reduction T1; the upgrade to `F` left open (§5.4).
- `plans/FS86-C-deBruijn.md:790` [also-R] — 7. (seat III) The exact cell tree of `Θ₄(Λ)` on `Λ₅₁₀` and a saturation of it, to decide HD1 outright — instead: Theorem HD1-cert (§7.3) proves that this finite computation decides HD1 when HD1 is true, and records it as the post-ban computation. — **a later entry names it: FS116-N1-AXIS, plans/FS116-derivation.md; FS116-S1-RUNG, plans/FS116-derivation.md; FS116-S1-LENS, plans/FS116-derivation.md; FS116-SAT-STRIP, plans/FS116-derivation.md; FS86-V2, plans/FS86-derivation.md; FS86-dB-T1, plans/FS86-derivation.md; FS86-dB-Theta, plans/FS86-derivation.md; FS86-dB-HDint, plans/FS86-derivation.md; FS86-dB-HDfin, plans/FS86-derivation.md; FS86-dB-Sv, plans/FS86-derivation.md; FS86-dB-HDcert, plans/FS86-derivation.md; FS86-VD-1, plans/FS86-derivation.md (+14 more)**
- `plans/FS86-R88-V-verification.md:28` [] — - T-B1: would have run a SAT search on a ball of `Λ₅₁₀` for a colouring agreeing with a pullback on an inner ball and differing outside (a converging family of non-pullbacks). Not run (ban); recorded as GAP with the reductions B1-a–c. — **a later entry names it: FS100-Q47, plans/FS100-derivation.md; FS100-X22, plans/FS100-derivation.md; R88-TA1, plans/R88-derivation.md; R88-TA2, plans/R88-derivation.md; R88-J28V-7, plans/R88-derivation.md; R88-J28V-8d, plans/R88-derivation.md**
- `plans/FS86-V-D-verification.md:24` [also-R] — - VD-cert ⟹: would have run the `Θ₄` relation tree on `Λ₅₁₀` to see whether its pullback points are isolated (positive spanning of `V(θ₀)`). Instead: proved isolation exists on *some* finitely generated lattice by the density argument, and recorded that Λ₅₁₀'s own check is a post-ban exact computation not implied by R1–R4. — **a later entry names it: FS110-CE3, plans/FS110-derivation.md; FS110-CE6, plans/FS110-derivation.md; FS86-A3, plans/FS86-derivation.md; FS86-dB-HDcert, plans/FS86-derivation.md**
- `plans/FS86-V-D-verification.md:27` [] — - VD-cert, the certificate: would have searched for a `Λ₁` with `4θ(1) = 0` on `Θ₄(Λ₁)`. Not run (the brief forbids it by name); recorded that only existence follows. — **a later entry names it: T1, plans/ASTRA-2026-09-14-derivation.md; T6, plans/ASTRA-2026-09-14-derivation.md; T7, plans/ASTRA-2026-09-14-derivation.md; T9, plans/ASTRA-2026-09-14-derivation.md; FS100-L0, plans/FS100-derivation.md; FS100-KS2, plans/FS100-derivation.md; FS100-CP, plans/FS100-derivation.md; FS100-X1, plans/FS100-derivation.md; FS100-X2B, plans/FS100-derivation.md; FS100-KS3, plans/FS100-derivation.md; FS100-T5, plans/FS100-derivation.md; FS100-R, plans/FS100-derivation.md (+641 more)**
- `plans/FS86-row88-rigidity.md:533` [also-R] — - Would have searched for a triangle-free forcer of `(0, 4)`. Instead: stage Y1, dated after 2026-10-01, priced by G65's band. — **a later entry names it: FS110-N2-RING, plans/FS110-derivation.md; FS110-Y-BIKE-3C, plans/FS110-derivation.md; FS111-M3-HC, plans/FS111-derivation.md; FS111-M3-BAND, plans/FS111-derivation.md**
- `plans/FS86-row88-rigidity.md:534` [also-R] — - Would have computed χ_gf of layered configurations over ℚ(√59) by LP. Instead: stage Y2, post-ban, with the configurations to be fixed by a derivation first.
- `plans/FS89-S1VB-verification.md:394` [also-R] — - **B1, the stall.** I would have run the rank-two window at `{5, 13}` outward from S0B's lens, to look for a switching array or a Toeplitz-type minimal set with a 5-adic odometer factor. Instead I recorded the stall as a named GAP and moved on; B2 closed it by derivation. — **a later entry names it: FS114-N4-D, plans/FS114-derivation.md; FS114-N4-LEMMAS, plans/FS114-derivation.md; FS116-S1-RUNG, plans/FS116-derivation.md; FS116-S1-LENS, plans/FS116-derivation.md; FS116-S1-EXIT, plans/FS116-derivation.md; FS116-S1-QF, plans/FS116-derivation.md; FS116-Y3-LENS, plans/FS116-derivation.md; FS116-Y3-TIGHTLENS, plans/FS116-derivation.md; FS116-Y3-STARFORCE, plans/FS116-derivation.md; FS116-V5-LENS, plans/FS116-derivation.md**
- `plans/FS89-rational-band-rigidity.md:904` [] — - Would have extended S0B's torsion list past `N = 130` to test U5; did not (inventory item 17 is Kooshi's).
- `plans/FS89-rational-band-rigidity.md:905` [nonban?] — - Not searched (budget, not a search ban): authors' personal pages for Berend 1983/1984; Semantic Scholar's citation lists.
- `plans/FS91-S0V-band-to-nine.md:298` [] — - | 3 | Enumerate band torsion characters of `ℤ[i]/N` at bands 1/6–1/9 to see the leaf discs | not needed for the verdicts (VB3's finiteness is non-effective); the explicit lists are named as not established | — **a later entry names it: FS91-J01-7, plans/FS91-derivation.md; FS91-J01-8, plans/FS91-derivation.md; FS91-J03a-6, plans/FS91-derivation.md**
- `plans/FS91-S1V-character.md:209` [] — - | 3 | enumerate the `q²` level-one characters of `Γ₂₃`, `Γ₄₃` to replace FS-53's and FS-66's certificates in C-167 by "no band 5-character" | not run; S0A-9 (a verified input) suffices | — **a later entry names it: FS100-T1, plans/FS100-derivation.md; FS100-CLS, plans/FS100-derivation.md; FS100-DLP, plans/FS100-derivation.md; FS86-Cx-C14, plans/FS86-derivation.md; FS86-CL1, plans/FS86-derivation.md; FS91-J07-10, plans/FS91-derivation.md; FS91-J07-12, plans/FS91-derivation.md; FS91-J07-13, plans/FS91-derivation.md; M3-J21-D1fac, plans/M3-derivation.md; M3-J22-T10, plans/M3-derivation.md; R88-TC-tab, plans/R88-derivation.md**
- `plans/FS91-S1V-character.md:342` [also-R] — - | 7 | search `f = 3`, `e = 2` towers for a band-7 character at level 5 (to refute or confirm (g3)'s `e = 1`) | not run (`729⁵` characters); recorded as a GAP in the lemmas instead |
- `plans/FS91-S1V-character.md:380` [] — - | 9 | search a `q = 3^f`, `e = 2` tower for a band-7 character at level 5 to settle row 10 | not run (out of the ban and out of reach: `729⁵` characters); row 10 recorded as a GAP in the lemmas |
- `plans/FS91-S1V-one-prime.md:135` [] — 2. X2: would have run the entropy-compression algorithm to print a long admissible 9-power-free word — not run; existence is by counting.
- `plans/M2-kernel-lane.md:276` [also-R] — - | X3 | a fresh LRAT of the 588-core to make the K(√7) theorem unconditional | the theorem is stated conditionally on `G₄`, declared for vacuity; the LRAT is post-ban |
- `plans/M2-kernel-lane.md:833` [also-R] — - | J04 X3 | a fresh LRAT of the 588-core, to make the `K(√7)` theorem unconditional | the conditional theorem; the LRAT is post-ban |
- `plans/M3-S1A-rank-one.md:90` [] — - | W1 | recompute the phases of T36's 377 all-rigid sets and classify them by chirality, to see whether the null ever sampled a chiral rigid phase | not run (a scan over many `D`); the question is kept as a reading in stage 3: T34 makes an all-achiral shift wall-free for free, so the null may measure achirality, not R2 |
- `plans/M3-S1A-rank-one.md:313` [] — - | W4 | enumerate non-BFS wall points of the control, to hunt one whose swaps all stay rigid (a KE falsifier) | not run; named in §3.5 as KE's killing test | — **a later entry names it: M3-J18-CTL, plans/M3-derivation.md; M3-J18-DPR, plans/M3-derivation.md**
- `plans/M3-S1B-rank-one.md:335` [also-R] — - | W2 | search `D` for a rigid–rigid wall between Kempe-frozen periodic points, to instantiate J19-KEF and refute KE outright | stated the class and KE♯ by derivation; left open | — **a later entry names it: M3-J18-KEimplies, plans/M3-derivation.md; M3-J19-FRZ, plans/M3-derivation.md; M3-J19-KEF, plans/M3-derivation.md; M3-J19-KT, plans/M3-derivation.md; M3-J19-AFx, plans/M3-derivation.md; M3-J20-NAMED, plans/M3-derivation.md**
- `plans/M3-S1D-windows-five.md:103` [] — - | W1 | run FS-66's second-level moment relaxation at 43 (84 GPU-days) to certify the all-levels ratio `< 1/5` | not run (banned; machine-long); D1-43 named GAP with the level-one partial (§2.6) | — **a later entry names it: FS100-T1, plans/FS100-derivation.md; FS100-CLS, plans/FS100-derivation.md; FS100-DLP, plans/FS100-derivation.md; FS86-Cx-C14, plans/FS86-derivation.md; FS86-CL1, plans/FS86-derivation.md; FS91-J07-12, plans/FS91-derivation.md; FS91-J07-13, plans/FS91-derivation.md; M3-J21-D1fac, plans/M3-derivation.md; M3-J21-D1-43p, plans/M3-derivation.md; M3-J22-T10, plans/M3-derivation.md; M3-J22-T2, plans/M3-derivation.md; R88-TC-tab, plans/R88-derivation.md**
- `plans/M3-S1D-windows-five.md:104` [] — - | W2 | search `Γ₄₃`'s level-two graph for an independent set above `0.2·43⁴` (to refute D1-43) | not run; recorded as the killing test of the partial | — **a later entry names it: M3-J21-D1-43p, plans/M3-derivation.md; M3-J22-T10, plans/M3-derivation.md; M3-J22-T2, plans/M3-derivation.md**
- `plans/M3-S1D-windows-five.md:106` [] — - | W4 | search `Γ₂₃` for two edge-free sets of size `≥ 106` each (to show 23 is non-thick in the strong, combinatorial sense) | not run; 23 is reported "not thick by the spectral criterion", and whether such a pair exists is left open |
- `plans/M3-S1V-rank-one.md:257` [also-R] — - A-C / A-T1: would have enumerated `D` beyond FS79-T36's range hunting an all-rigid set with a wall. Did instead: the stall analysis of §2.4; A-C left GAP. — **a later entry names it: FS110-CALC, plans/FS110-derivation.md; FS112-STRIP-CHAIN, plans/FS112-derivation.md; FS114-L60-WALK, plans/FS114-derivation.md; M3-J18-F3, plans/M3-derivation.md; M3-J20-T35W, plans/M3-derivation.md; M3-J18-EQ, plans/M3-derivation.md; M3-J18-DC, plans/M3-derivation.md; M3-J20-CUT, plans/M3-derivation.md; M3-J18-KEimplies, plans/M3-derivation.md; M3-J19-KC, plans/M3-derivation.md; M3-J19-KT, plans/M3-derivation.md; M3-J19-BIN, plans/M3-derivation.md (+2 more)**
- `plans/M3-S1V-windows-five.md:78` [also-R] — - D2(a), the split places: *would have searched* for a cross-independent pair of density `≥ 1/5` in the level-one Kloosterman graph `Cay(𝔽_q², {(ε, ε⁻¹)})` at `q = 9, 61` (is `κ < 1/5` on the standard piece?); *did instead:* the structural construction J22-T4 on the full local graph, and recorded `κ` on the standard piece as the open step. — **a later entry names it: M3-J21-NG3, plans/M3-derivation.md**
- `plans/M3-S1V-windows-five.md:81` [also-R] — - D1-43: *would have run* a fibre-share relaxation `B₁` at 43 (FS-69; machine-long); *did instead:* recorded GAP with the step named. — **a later entry names it: M3-J21-D1-43p, plans/M3-derivation.md; M3-J22-T10, plans/M3-derivation.md; M3-J22-T2, plans/M3-derivation.md**
- `plans/M3-S1V-windows-five.md:87` [also-R] — - D1-43p: *would have run* a fibre-share moment relaxation `B₁(43)` (FS-69, priced at 84 GPU-days; machine-long, out); *did instead:* proved `B₁(43) < Hoffman` strictly by hand, and recorded `B₁(43) < 1849/5` as the open step. — **a later entry names it: M3-J21-D1-43p, plans/M3-derivation.md; M3-J22-T10, plans/M3-derivation.md; M3-J22-T2, plans/M3-derivation.md**
- `plans/M3-exotic-colourings.md:584` [] — - | X4 | search Polymath16's MCNP ≥ 6 criterion (a five-colouring of `V_A ⊕ V_A ⊕ V_A` with a forced {1,2}-vertex) | not run; quoted in §PA as the archimedean corner's state of the art |
- `plans/PA-ambrus2023-audit.md:42` [] — - Would have evaluated `W(t)` in ball arithmetic (arb) at the ~640k grid points — not done: `python-flint` is not installed (an install request, not made) and the float result already has a 2.3·10⁻⁶ margin; listed as the one step still on numerical trust.
- `plans/POROS-2026-09-25-fs86-next.md:278` [] — - once. I would have enumerated the first few 5-adic digit levels of the single-prime band set to test `one-prime-is-not-enough-at-four-colours`. I left it as a registered hunch for A′'s Stage 0.
- `plans/POROS-2026-09-25-infinitely-many-primes.md:105` [] — - Would have searched a finite `H ⊂ ℚ(√47)²` with `α(H) < |H|/4` (the fractional route). Not run; its price is corrected in Stage 4.
- `plans/POROS-2026-09-25-infinitely-many-primes.md:106` [] — - Would have run a `Θ₄` tree and a colouring finder for a four-colourable unit-distance lattice with `Θ₄ = ∅` (EI-1's falsifier, Stage 4). Not run (ban); posed.
- `plans/POROS-2026-09-25-wanted-poster-47.md:123` [also-R] — - Would have searched a finite ℚ(√47) graph for `α(H) < |H|/4` (a Dúcz–Varga-type graph in the field). Instead: recorded it as a post-ban construction problem (Stage 4, R3).
- `plans/POROS-2026-09-25-wanted-poster-47.md:125` [also-R] — - Would have enumerated small lattices for a four-colourable `Λ` with `Θ₄(Λ) = ∅` (S1V's GAP). Instead: left it on EI-1's line, unchanged from J36. — **a later entry names it: FS100-L0, plans/FS100-derivation.md; FS100-KS2, plans/FS100-derivation.md; FS100-CP, plans/FS100-derivation.md; FS100-X1, plans/FS100-derivation.md; FS100-X2B, plans/FS100-derivation.md; FS100-KS3, plans/FS100-derivation.md; FS100-T5, plans/FS100-derivation.md; FS100-R, plans/FS100-derivation.md; FS100-EQ, plans/FS100-derivation.md; FS100-C45, plans/FS100-derivation.md; FS100-T1, plans/FS100-derivation.md; FS100-K0, plans/FS100-derivation.md (+432 more)**
- `plans/POROS-2026-09-25-wanted-poster-47.md:425` [also-R] — - Would have sampled finite graphs in ℚ(√47)² for independence ratio below 1/4. Instead: EI-F registered and a post-ban stub proposed (R4).
- `plans/POROS-2026-09-25-wanted-poster-59.md:268` [also-R] — - Would have hunted a stationary defect process over a pullback (a G-f witness) on a finite quotient. Instead: named DP and located it at J45's GAP (§3.3 (b)).
- `plans/POROS-2026-09-25-wanted-poster-59.md:450` [also-R] — - Would have searched finite quotients for a gap-free periodic colouring that fails isolation (the T-B1 falsifier). Instead: stated it as a card and pointed to a record read (row 80's T35 phases, for gaps). — **a later entry names it: FS100-Q47, plans/FS100-derivation.md; FS100-X22, plans/FS100-derivation.md**
- `plans/POROS-2026-09-26-hn-paths.md:207` [also-R] — - P1's calibration: I would have run the invariant LP on small configurations in `K(√5)` to see whether `χ_g` reaches 5 below 509 points; instead I derived its upper bound by the field wall (fact 3) and its sandwich `χ(H) ≤ χ_g ≤ χ(ΓH)` (fact 2), which say where and why it can help, and left the calibration post-ban.
- `plans/POROS-2026-09-27-fs106-close-and-fs107.md:15` [also-R] — - Stage 3: a numerical trace of `1 − µ₆^per(ε)` along eroded `[Parts2020c]` tilings, to see whether the hole gap is flat or falling. Instead it goes to FS-107 as a registered dial for after 2026-10-01, with both outcomes stated. — **a later entry names it: FS106-CS, plans/FS106-derivation.md; FS106-PR, plans/FS106-derivation.md; FS106-AE-SLACK, plans/FS106-derivation.md; FS106-AE-CLOSED, plans/FS106-derivation.md; FS106-AE-POLY, plans/FS106-derivation.md; FS106-AE-NICE, plans/FS106-derivation.md; FS106-AE-Q2, plans/FS106-derivation.md; FS106-TS-U, plans/FS106-derivation.md; FS106-TS-C, plans/FS106-derivation.md; FS106-TS-C2, plans/FS106-derivation.md; FS106-IND, plans/FS106-derivation.md; FS106-IND-X, plans/FS106-derivation.md (+17 more)**

## The U lines (9), each also a CHECK in the report

- `plans/FS107-stability.md:724` — - P: an OpenAlex cross-check of the citing lists (a debt, §PA row 7); planning none.
- `plans/FS112-N-proof.md:33` — - Whether CAL-STRIP's and CAL-DISK's arcs are all of type (Q): not fitted to any figure; read from the printed words only (§2.4) and registered.
- `plans/FS112-NB-verification.md:32` — - | probe tangent bends at isolated radius-2 contacts with random curvatures | a second-order comparison, stated as a sketch (§1.5, BEND) |
- `plans/FS114-YB-verification.md:25` — - Stage 1: the four entries at the end of stage 1c.
- `plans/FS114-YB5-verification.md:30` — - | 1c | scan probe radii near the Pointing boundaries | registered one probe per check; the one that sat on a boundary is recorded (run 1) |
- `plans/FS84-S1V-verification.md:171` — - | V2 | a vertex-transitive non-amenable counterexample to the `ι` clause | not needed for the claim; logged |
- `plans/FS85-C-deBruijn.md:432` — 6. **A breach, logged plainly:** to close gap B I scanned the 31 unions of `η`-power generator classes for a Hoffman-tight, `8Λ`-pure sub-quotient on five non-tight `L`-types (`tools/Lsub.py`). That is a small sweep over sets, which the week excludes. It found nothing and nothing rests on it.
- `plans/FS91-S0V-band-to-nine.md:296` — - | 1 | — | — |
- `plans/M3-S1B-rank-one.md:337` — - | W4 | run the strand tool over all 377 all-rigid sets of the FS-79 scan to test AF broadly | one `D`, chosen by a stated rule before the run (§1.5), at the ban's edge |

## Aggregates not counted (40), by file

- `plans/FS100-three-field-lemma.md`: 2
- `plans/FS103-collapse-cp-plane.md`: 1
- `plans/FS105-harden-mr.md`: 1
- `plans/FS106-regular-half.md`: 13
- `plans/FS107-stability.md`: 4
- `plans/FS110-tangency-seam.md`: 1
- `plans/FS112-unit-arc-half.md`: 1
- `plans/FS86-dyadic-rigidity.md`: 1
- `plans/FS86-row88-rigidity.md`: 4
- `plans/FS91-character-local-global.md`: 12

## Would-have-searched-here log (this job)

- Stage 1: none (reading and grep). Stage 2: none. Stage 3: none. The scripts read text files and `git blame`; nothing was searched for a finite object.

## Fence log

No fences in this brief. No fenced text touched.

## Theorems this phase proved

None — a counting job.

## Held for the coordinator

See the report, `data/workflow3/reports/CL3.md`.
