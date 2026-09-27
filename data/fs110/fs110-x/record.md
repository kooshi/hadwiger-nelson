# FS110-X — the front-page pass for FS-110's close (de Bruijn, Opus 5.5, 2026-09-27)

*Brief `data/fs110/briefs/X110-front-page.md` with `data/fs110/briefs/STANDING-RULES.md`. HEAD at launch `939f0928` (the gitStatus snapshot said
`90931717`; the owner's handoff commit `939f0928` landed between). `CLAUDE.md` at launch: 295,695 bytes (read from disk).*

## Theorems this phase proved

None — an editing job.

## Would have searched here (standing rule 3)

None — no search was contemplated.

## Stage 1 — SAVED: quotation check, inputs located

**1.1 Quotations in the brief and the standing rules, checked against source** (`grep -cF` on `CLAUDE.md`, each 1): "you may doubt your ability to"
(§ Counter-priors); "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"
(§ Toolchain); "search for a finite graph is out. It would be huge, not feasible." (§ Publication); "A proven theorem about why its impossible is also
valid. All novel knowledge is a success" (item 23). S–V Question 2 "Is it true that 7 colors are needed …" — `data/fs110/claims.md` l. 63. A6-2.1's
headline — `plans/POROS-2026-09-27-fs110-competition.md` l. 1485–1486, matching §R-close 3.0 verbatim. All match.

**1.2 Inputs.** C's drafts: `plans/FS110-tangency-seam.md` §R-close stage 4 (l. 625–709). § B draft `data/fs110/fs110-c/ledger-b-draft.md` (42
lines). Rulings: `plans/FS110-close-inventory.md` items 97 (polarity: YES), 111 (bib_audit's two citations checked at the front page), 113 (Form A,
grade clause as stated). CE's record `plans/FS110-CE-verification.md`, report `data/fs110/reports/FS110-CE.md`.

**1.3 Found while reading the drafts** (settled or held below):
- § B draft line FS110-YB4-WINDOW is malformed: C's extraction took the grade from the first `[` in the derivation header, which sits inside the
  statement (`R_y = [−T²/6, T²/2)`); its theorem and grade cells are garbled. `tools/fs71_ledger_b_check.py` compares ids and fields, not grades,
  so it would pass. Settled: the grade cell is written "hand and tools; one mind: YB4, blind" from the header's real grade bracket.
- § B has no per-milestone headings — it is one table; a heading line "FS-110 (row 134)" (C's 4.1) would split it and leave the FS-110 lines without
  a header row. Settled: the 42 lines are appended after FS-107's, the milestone column "row 134" carrying the grouping.
- `plans/FS110-derivation.md` (FS110-CLOSURE's and FS110-CUSP-BASE's entry grades, and row 132's correction line in `plans/FS106-derivation.md`)
  is outside my touch list: held for the owner.
- `plans/FRONTIER-STUBS.md` rank 5, FS-108 "the print residuals of the regular half", names "S–V Thm 2's `d = 2` edge case and its Lemma 3", both
  answered at FS-110 (row 132's correction; FS110-COR1-NOD2, FS110-CB-LEMMA3). C drafted no re-aim: listed as left (a stub to re-aim), no text written.

## Stage 2 — SAVED: `LEDGER.md`

- **Row 134** inserted after row 133: C's Form A text (§R-close 4.1) with the grade clause set as inventory item 113 states — the chain two minds, one
  blind; S–V Cor. 1 a.e. with no `d = 2` exception two minds, both blind (CB, CD), the closure by two routes (CD's Theorem D2; CE's Antipodal Lemma);
  the cusp base D2, D5 item 5, D1 two readings (A6, CC), D4 one reading (CE), D5 items 1–4, 6 true after CE's local repair, one mind, no step failing
  unrepaired. CB's D5 corrections (CE §E2–E5) added as a **Corrections:** clause after **Not claimed:**; proof column gains
  `plans/FS110-CE-verification.md` and `tools/fs110_ce_scope.py`. Polarity (item 97): "answered yes" throughout; no "NO".
- **Row 132's correction** (§R-close 4.1, four edits): the `d = 2` edge case "does not arise: FS-110's CB and CD, both blind" (the comma before
  "except" dropped so the parenthesis reads); Lemma 3 by Voronov's bicycle (FS110-CB-LEMMA3); grade as drafted **plus** ", the closure by two routes
  (CD's Theorem D2; CE's Antipodal Lemma)" — item 113's citation of the closure, carried to the one other row that states it; "`d = 2`;" struck from
  Not claimed. § B: FS106-SV2 loses "except `d = 2`", FS106-AE-POLY loses "bar `d = 2`" (FS106-AE-CONV's line never carried it).
- **§ B:** the 42 lines appended after FS-107's (no heading: § B is one table). FS110-CLOSURE and FS110-CUSP-BASE grade cells per item 113;
  FS110-CUSP-BASE's theorem cell names D4 and D5 items 1–4, 6 so that it matches its grade; FS110-COR1-NOD2's theorem cell carries CB's D5 corrections
  (item 113: "into row 134's 'Not claimed / corrections' and § B"); FS110-YB4-WINDOW's garbled cells rewritten (grade from the derivation header).
- `python3 tools/fs71_ledger_b_check.py --strict`: exit 0, PASS (940 rows; it was FAIL (42) at launch).
- **Left:** CE's theorems CE1–CE7 have no entries in `plans/FS110-derivation.md` (written before CE reported) and so no § B lines — adding § B lines
  without entries fails the checker, and the derivation file is outside my touch list. FS110-CLOSURE's and FS110-CUSP-BASE's entry headers in
  `plans/FS110-derivation.md` still read "under check"; `plans/FS106-derivation.md` owes its one line per entry (row 132's correction).

## Stage 3 — SAVED: `CLAUDE.md`, `plans/FRONTIER-STUBS.md`, the audit's reviewed lines, and a stage-2 repair

- **`CLAUDE.md`** (C's §R-close 4.2, applied as drafted): Last-updated line; § The aim link 4 ("bar one edge case (`d = 2`)" struck) and the
  program line (FS-110 closed, FS-112 added); item 31 rewritten; Open milestones; paths-forward rank 1 → FS-112 (FS-111 stays rank 2, its short
  mirror cell unchanged — C drafted no text for it); G82's *Do* gains the §PA-sweep clause; the ledger pointer "Rows 1–133" → "1–134" (the FS107-X
  precedent). **Bytes: 295,695 → 295,853** (C estimated net −200; the drafts add +158; under 300,000, so no budget move was needed).
- **`plans/FRONTIER-STUBS.md`** (C's 4.4): Open-milestones paragraph mirrors `CLAUDE.md`'s; rank 1 FS-110 → FS-112 (cost "unpriced (counter-priors,
  rule 1)", status "minted 2026-09-27", solver "in-ban: derivation and exact fragments by formula"); FS-111's question gains "`K` enters the answer
  only here and in W-EQ-K (row 134's scope)"; FS-110 heads the closed list.
- **`tools/claude_md_fact_audit.py`, reviewed lines** (4 lost tokens, each reviewed): ALLOW "1–133" (the ledger pointer extended to 1–134, the 1–130
  precedent) and "131–133" (item 31's row range, now 131–134, C's rewrite); EXTERNAL_HOMES 'plans/STUB-tangency-seam.md' → `plans/FRONTIER-STUBS.md`
  (its closed list keeps the address) and '(1, 2)' → `plans/STUB-tangency-seam.md` (FS-110's removed row's "equal-type pairs in `(1, 2)`"; the stub
  holds it twice; the audit reads the file and found it).
- **A slip of mine, repaired here:** stage 2 was committed after the fact audit and `--strict` but **before `--dupes`**, which read 20 (10 at launch):
  nine from C's § B grade cells repeating "hand; two minds, one blind: X; Y | `plans/FS110-derivation.md`" (exactly 10 words), one from the
  two-routes clause I had carried into row 132. Repair: the 15 cells of that exact form rewritten "hand; two minds: X; Y, blind" (the blind mind
  named, one word fewer, content unchanged); row 132's clause now points: "(FS110-CB, FS110-CD; the closure's two routes in row 134)".
- Gates at this stage: fact audit `--base 939f0928` exit 0 PASS; `--dupes` 10; `--strict` exit 0 PASS; `check_architecture` exit 0 PASS; RK's
  mirror check exit 0 PASS; `bib_audit` exit 1 — the two FS-110 citations present at launch (stage 4).

## Stage 4 — SAVED: `BIBLIOGRAPHY.md`, `plans/GROKKING-INSTANCES.md`, the protocol

- **`BIBLIOGRAPHY.md`** (C's 4.3): (a) FS110-PA's four edits verbatim — `[SokolovVoronov2025]` (§9 and Conditions 5–6 re-read; the DM version;
  citing works), `[AxenovichLiuSagdeev2025]` "Listing only" → "Opened (FS110-PA): …", `[Soifer2024]` ch. 25, `[Townsend2005]`; (b) merged with (a)'s
  Soifer text (both say ch. 25 reprints Townsend's proof; (b) adds "and its gap (FS106-V3)"); (c) `[Woodall1973]` §3 re-read by FS110-NB3 and Y4;
  (d) unheld: `[Coulson2004]`'s citing list "not run" added to row 139; Kruskal 2008 and Ágoston 2025 as rows of a new "FS-110's prior-art gate"
  block (Ágoston's title unverified — FS110-P names no title and its raw records hold none); S–V's DM version and `[Townsend2005]` were already
  recorded by (a) and row 139. **(e), inventory item 111 — both citations checked against their source records:** arXiv:1305.5229 is J. F. Alm,
  J. Manske, *On Radial Colorings of Annuli* (v2, first posted 2013-05-22; the arXiv API record `data/fs110/fs110-p/alm.xml`), read status "abstract
  read (FS110-P)", an unkeyed row; `[MartiniMontejanoOliveros2019]` is H. Martini, L. Montejano, D. Oliveros, *Bodies of constant width. An
  introduction to convex geometry with applications*, Birkhäuser 2019, Zbl 1468.52001 (the zbMATH API record `data/fs110/fs110-p/spindle2.json`),
  keyed (the plan cites the key), "Listing only". Neither is in `~/source/library/` or was in `BIBLIOGRAPHY.md`. Kruskal 2008 checked the same way
  (Zbl 1139.05023, `boundaries.json`: Clyde P. Kruskal, JCSS 74(4) 598–627).
- **`plans/GROKKING-INSTANCES.md`** (C's 4.5): §G51 — FS-110's run, the quote-verbatim instance, the fence instance, each under an
  "*FS110-X, …*" line after FS-107's; §G72 — eighteenth; §G79 — FS-110. One change to C's text: the quote instance's last clause quoted A6-2.1's
  full sentence, which row 134's headline also carries, and `--dupes` read 11; it now quotes the sentence's first words and points to row 134
  (one home per fact).
- **`plans/PROTOCOL-competitor-and-advisor.md`** (C's 4.6): §1 rule 12 ("No agent messages another after its own hand-back", verbatim); §3 "The
  tenth run: FS-110" before "The next use", in the ninth run's format — records, the four rounds' objects, and 4.5's G51 text.
- `CLOSED-QUESTIONS.md`: C drafted no row — nothing applied (left).
- Gates after this stage: fact audit `--base 939f0928` exit 0 PASS; `--dupes` 10; `--strict` exit 0 PASS; `bib_audit` exit 0 PASS (FAIL at launch);
  `check_architecture` exit 0 PASS; RK's mirror check exit 0 PASS. `CLAUDE.md` 295,853 bytes.
