JOB FS131-FRF1 — DONE   harness≈100k (own≈60k)
RESULT: rational four-space's drafts 1-6 and 8 and its two LEAN.md lines filed verbatim on branch `fs131-frf1`, with the brief's three substitutions; the fact audit's 10 FAIL lines are all superseded counts (below); architecture PASS; `--dupes` exit 0.
RECORD: data/fs131/reports/FS131-FRF1.md (script `data/fs131/fcs1/file-frf1.py`, outputs `file-frf1.out`, `frf1-arch.out`, `frf1-audit.out`, `frf1-dupes.out` beside it)   COMMITS: see the hand-back line

FILED (file: place after filing)
- Draft 1, CLAUDE.md § The gate: `declarations=22802 refutations-skipped=246 sites=1477`, `vacuous=0 stale=0 declared=3 witnessed=52 generic=1420 unknown=2`.
- Draft 2, CLAUDE.md § Trust ledger: audit sentence now 11106 clean ... 11,806 records at FS131-IRF1.
- Draft 3, LEDGER.md: row 169, a new line directly after row 168; four columns; last column "FS-131 (2026-10-17)".
- Draft 4, CLOSED-QUESTIONS.md § 3, the `ℚ⁴` entry: `**Not claimed:** a gate; the kernel.` replaced by the `**Kernel-checked**` text (the slot occurs once in the file).
- Draft 5, plans/KERNEL-HOLDS.md: clause appended after the file's last clause (after "Also χ(Heule-510) ... ≤ 5.").
- Draft 6, CLAUDE.md § Frontier "Last filed": replaced; the ring-of-unit-vectors entry moved in full to the top of plans/FILINGS.md as "before it **the ring of unit vectors** (...)", and shortened in CLAUDE.md's "before it," list to "**the ring of unit vectors** (FS131-KRU1, FS131-IRU1, FS131-IRU2)" (the form FS131-FRU1 used).
- Draft 8, BIBLIOGRAPHY.md: the "what of ours rests on it" cell (third cell; for [Zaks1999], in § C, the second and last cell) of [BendaPerles2000], [Johnson1990], [Johnson2006], [KubickiLehelMorayne2002], [Zaks1999], each with its draft clause appended.
- LEAN.md § Searching — Lean: the record's two Stage 2 items ("A coercion ℚ → ℍ[ℚ] ...", "An anonymous constructor ascribed ℍ[ℚ] ...") as two bullets at the section's end.
- Not filed, as told: draft 7 (Atlas), draft 9, README, RESULTS, the "In short:" clause.

SUBSTITUTIONS
- Draft 3: "**Prior art:** pending `[KubickiLehelMorayne2002]`." -> "**Prior art:** " + PAS3 § 3.4 item 5 from "the answer to" to "The kernel proof is this project's." (LEDGER.md row 169).
- "N" -> 169 (draft 3). "pending `[KubickiLehelMorayne2002]`" occurs nowhere else in the filed drafts (post-check: 0 in every touched file).

SLOTS THAT DID NOT MATCH: none. All 12 slots found exactly once; plants 1-12 each failed the script before any write.

CHECKS
- `python3 tools/check_architecture.py`: exit 0, last line "RESULT: PASS".
- fact audit (`--base main --also ...`): exit 1, 10 FAIL lines, all superseded counts the drafts replace: code tokens `declarations=22728 refutations-skipped=246 sites=1465` and `vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`; num tokens 11043, 11743, 1465, 22728; chunk tokens `declarations=22728`, `sites=1465`, `witnessed=40`; "gate-report counts changed ('11043','5') -> ('11106','5')". Nothing else. `size: CLAUDE.md 74,787 of 80,000 bytes`; grokkings 187,057 of 200,000.
- `--dupes`: exit 0.

HELD FOR THE COORDINATOR
- CHECK: row 169's last column. Draft 3 ends "| consolidation run (2026-09-27); FS-131 (FS131-KFS1, FS131-IRF1) |"; the brief says "FS-131 (2026-10-17)", which I used. The draft's "consolidation run (2026-09-27)" dates are therefore not in the row.
- CHECK: KERNEL-HOLDS placement. "A clause after the last" read literally: appended after the file's final sentence, in the same paragraph. Earlier landings' clauses sit elsewhere (e.g. the Cayley clause just before "**Theorems A and B**"); move it if you want it there.
- CHECK: BIBLIOGRAPHY.md. Draft 8 gives no cell structure; I appended each clause to the cell with my own lead-in "**In the kernel (FS131-IRF1):**" and a closing period where the draft clause had none. The [KubickiLehelMorayne2002] cell still opens "**Nothing of ours rests on it; C7's structure clause reproves its Thm 4.3.**", which now sits beside "Thm 4.3's rigidity half is `RationalFour.coloring_eq_of_eqOn_isOpen`"; I did not touch it.
- CHECK: LEAN.md bullets carry no FS131-IRF1 tag (verbatim from the record; the report line says "drafted here").
- CHECK: CLAUDE.md "Last filed" list: draft 6 says only "the previous filing moving to the 'before it' list"; the shortened ring entry's wording is FRU1's form.
