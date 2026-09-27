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
