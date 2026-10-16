JOB FS131-FRU1 — DONE   harness≈150k (own≈90k)
RESULT: filed FS131-IRU2 Stage 4's D1, D2, D3, D4, D5, D6, D8 (both halves), D9, D10, D11 and the `LEAN.md` Building line, and FS131-PAS1 § 5.4 item 1, verbatim by script (`data/fs131/fcs1/file-fru1.py`, output `file-fru1.out`). Every slot found exactly once before writing (13 of 13, whitespace-insensitive); plants on slots 1, 5 and 13 each failed loudly (exit 1). Not filed (as ruled): D7, PAS1 items 2-3, § 6.4, `CLAUDE.md`'s "In short:" clause, anything in `BIBLIOGRAPHY.md`.
RECORD: data/fs131/reports/FS131-FRU1.md   COMMITS: (the commit of this branch `fs131-fru1` carrying these files; hash in the hand-back message's git log)
FILED, with file and line after filing:
- D1: `CLAUDE.md` l. 421 (audit 11043 clean, 11,743 records at FS131-IRU1).
- D2: `CLAUDE.md` l. 479 (`declarations=22728 refutations-skipped=246 sites=1465`; second part and `rests=168` untouched).
- D3: `LEDGER.md` l. 145 (row 100): Not-claimed text, then the **Kernel** sentence before **Prior art**; PAS1 § 5.4 item 1 in the Prior art field (its quoted old text equals the slot).
- D4: `LEDGER.md` l. 150 (row 105).
- D5: `LEDGER.md` l. 213, new row 168, directly after row 167.
- D6: `ROADMAP.md` § 3: item 2 deleted; sentence added to the opening paragraph.
- D8a: `CLAUDE.md` l. 187 ("Last filed"); the density entry moved whole to `plans/FILINGS.md` l. 8 (top, before the five-colour entry), as "before it **the density form …** (…moved.)".
- D8b: `plans/KERNEL-HOLDS.md` l. 7, after "(`QuadraticPrime.exists_maximal_card_eq`, `…_of_ramified`)".
- Building line + D9: `LEAN.md` l. 538-543.
- D10: `plans/POROS-2026-10-13-number-field-findings.md` after the Rank 8 paragraph.
- D11: `plans/FS131-KCS1-class-plan.md`, under the § 2.6 heading.
SUBSTITUTIONS: "<landing>" → "FS131-IRU1" in D3's Kernel sentence and D4 (none left: grep 0 in LEDGER.md, CLAUDE.md, KERNEL-HOLDS.md); D5's last column "FS-131" → "FS-131 (2026-10-16)". Slots that did not match: none.
CHECKS:
- `tools/check_architecture.py`: RESULT: PASS (exit 0).
- fact audit (`--base main --also …`): exit 1, 9 failures (`data/fs131/fcs1/fru1-audit.out`), all superseded counts the drafts replace, plus one finding: lost code token `declarations=22683 refutations-skipped=245 sites=1465`; lost num tokens `10998`, `11698`, `22683`, `245`; lost chunk tokens `declarations=22683`, `refutations-skipped=245`; "gate-report counts changed ('10998','5') -> ('11043','5')" (expected); and lost num token `1964` — this is the year in row 100's replaced phrase "Shimura 1964 undecided" (D3 / PAS1 item 1 replace it with the key `[Shimura1964]`), no count. `size:` CLAUDE.md 74,329 of 80,000; grokkings 187,057 of 200,000.
- `--dupes`: exit 0.
INVENTORY:
- slip — LEAN.md: D9's and the Building draft's slot says "§ Building", but the slot line (FS131-ICS1's "A landing whose branch changed …") sits at the end of § Searching — Lean in the file (Building is l. 106-151) — IRU2 record / LEAN.md l. 537
- slip — D6 draft's "appendix's row 100/105 entry" conditional: ROADMAP.md's appendix holds no row 100 or 105 entry (grep), so nothing to remove — ROADMAP.md
HELD FOR THE COORDINATOR:
- CHECK: D10 names only the section ("§ 3.3 (C8)") not a slot; I appended the sentence as its own paragraph after the Rank 8 (C8) paragraph, before Rank 9. Move it if you meant it inside the paragraph.
- CHECK: D9's fifth bullet says the planner's § 3.7 item 6 line "stands as drafted"; I filed that line verbatim from `plans/FS131-KRU1-ring-plan.md` § 3.7 item 6 (the Mathlib.Data.Fintype.Units deprecation, `LEAN.md` l. 543) after the four bullets, not the bullet's own sentence. Absent from LEAN.md before.
- CHECK: order in LEAN.md: the Building line is directly after its slot line, D9's lines after it.
- CHECK: D6: item numbering left as 1, 3, 4 (the draft said delete, not renumber). The opening paragraph's lines were re-wrapped by the whitespace-insensitive match.
- CHECK: D11's banner is wrapped in italics (`*Superseded by … F1).*`); no word added.
- CHECK: KERNEL-HOLDS l. 7: D8b's insertion text copied from the draft; "In short:" clause in `CLAUDE.md` left for you.
