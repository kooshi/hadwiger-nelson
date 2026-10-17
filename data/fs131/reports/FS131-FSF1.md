JOB FS131-FSF1 — DONE   harness≈150k (own≈120k)
RESULT: FS131-ISF2's drafts 1, 2, 3, 4, 5, 6, 8, 9 and 11 filed verbatim by script (`data/fs131/fcs1/file-fsf1.py`); no result of mine. Every slot matched exactly once, whitespace-insensitively, with no word differing.
RECORD: data/fs131/reports/FS131-FSF1.md (the script `data/fs131/fcs1/file-fsf1.py`, audit outputs `data/fs131/fcs1/fsf1-audit.txt`, `fsf1-dupes.txt`)   COMMITS: see the hand-back line (one commit on `fs131-fsf1`)

FILED (file:line after filing)
- D1 `CLAUDE.md` § The gate counts line (l. 479): `declarations=23377 refutations-skipped=247 sites=1477` ...
- D2 `CLAUDE.md` § Trust ledger audit sentence (l. 421): 11436 clean, 730 axiom-free, 12,291 records at FS131-ISF2.
- D3 `CLAUDE.md` "Last filed" (l. 187) replaced; the displaced rational four-space entry moved in full, as "before it **rational four-space at four colours** (...)", to the top of `plans/FILINGS.md` (l. 8), in FRF1's form. In the new line the list reads "before it, **rational four-space at four colours** (FS131-KFS1, FS131-IRF1), **the ring of unit vectors** ..." per the draft.
- D4 `LEDGER.md` row 71 (l. 115): claim clause regraded `[kernel]` with the draft's parenthetical; address column gained `Proofs/HadwigerNelson/Instances/SeamFractional.lean`, `Proofs/HadwigerNelson/Plane/G27/` (appended after the last address, comma-separated); milestone column now `FS-56; FS-131 (FS131-KFS1, FS131-ISF1, FS131-ISF2)`.
- D5 `LEDGER.md` § B row FS56-T3 (l. 427): grade `kernel (FS131-ISF1, gated by FS131-ISF2)`; address gained `; ` + the draft's `Instances/SeamFractional` (...) parenthetical.
- D6 `CLOSED-QUESTIONS.md` § 1.6 (l. 264): "**Not kernel-checked** beyond Theorem B." replaced by the draft's text.
- D8 `BIBLIOGRAPHY.md` `[MatolcsiEtAl2025]` (l. 196) and `[CranstonRabern2015]` (l. 124), the "what of ours rests on it" cell, quoted additions appended.
- D9 `plans/KERNEL-HOLDS.md` clause directly after the rational four-space clause, before "Also χ(Heule-510) ...".
- D11 `LEAN.md`: (a)-(c) as three bullets at the end of § The kernel's cost model (l. 209-211); (d) as a bullet at the end of § Building (l. 153); (e), (f) as two bullets at the end of § The gate's list (l. 660-661), before the InfoView paragraph.
NOT filed (per brief): drafts 7, 10, 12; no "In short:" clause; README.md and RESULTS.md untouched.

SUBSTITUTIONS / FORMS (mine, not the drafts')
- D11: each italic item written as a "- " bullet, italics markers and the "(a)"-"(f)" letters dropped, whitespace flattened; words unchanged.
- D8: joiner between the existing cell text and the quoted addition: ". " after `[MatolcsiEtAl2025]`'s cell (it ended without a period), "; " after `[CranstonRabern2015]`'s; the quoted text is copied unchanged (so a lower-case "the question is answered..." follows the semicolon).
- D5: the address addition is joined by "; ", the cell's own separator.

SLOT MISMATCHES: none.

CHECKS
- Script: all 13 slots matches=1 before writing. Plants (PLANT=1, 4, 9, 13: a D1 character, a row-71 character, the Cranston row regex, the LEAN.md InfoView anchor) each exited 1 with "FAIL: slots not found exactly once". Real run exit 0.
- `python3 tools/check_architecture.py` last line: `RESULT: PASS` (exit 0).
- Fact audit (`--base main --also ...`): exit 1, AUDIT FAILED (9 failures), all superseded counts or the regraded tag replaced by the drafts' new values: lost code token 'declarations=22802 refutations-skipped=246 sites=1477'; lost num tokens '11106', '11806', '22802', '246'; lost tag token '[hand + cert]' (row 71's grade, regraded by draft 4); lost chunk tokens 'declarations=22802', 'refutations-skipped=246'; gate-report counts changed ('11106','5') -> ('11436','5'). Nothing else failed. Sizes: CLAUDE.md 75,017 of 80,000 bytes; grokkings file 187,057 of 200,000.
- `--dupes` exit 0 (a list of short repeated fragments printed, none a failure).

HELD FOR THE COORDINATOR
- CHECK: draft 11 names no line-level slot within LEAN.md for (d), (e), (f) beyond "under § Building and § The gate": I put (d) at the end of § Building, (e) and (f) at the end of the gate's bullet list, (a)-(c) at the end of § The kernel's cost model. Move if you meant otherwise.
- CHECK: draft 11's (a)-(c) were sliced from `plans/FS131-ISF1-seam-fractional.md` § 5.2 draft 4, as ISF2's draft names them; ISF2's own record does not repeat them.
- The module docstring of `Instances/SeamFractional` stays stale (your ruling, item 1095); not touched.
