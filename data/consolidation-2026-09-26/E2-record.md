# E2 — record: did E1's extraction remove only incidentals?

*Job E2 of the 2026-09-26 documentation consolidation; brief `data/consolidation-2026-09-26/briefs/E2-intrinsics-check.md`. Opus 5.5,
verifier (Coxeter). The range checked is E1's: base `230ea964` (HEAD before its first edit) to `aeef4e58` (its last commit), on
`CLAUDE.md`. The standard is E1's brief's definitions of intrinsic and incidental.*

## Stage 1 — SAVED: the mechanical check

**The tool:** `tools/e2_moved_check.py`. It never reads E1's move list. It aligns the two `CLAUDE.md`s line by line, then word by word
inside each changed hunk, and calls each run of deleted old words a removed **span** (spans closer than 6 matched tokens are merged, so a
pointer that happens to contain "the" cannot split one moved passage). Then:
- **landed:** each span must be found **verbatim**, newlines included, in `plans/GROKKING-INSTANCES.md`, `LEDGER.md`,
  `plans/FRONTIER-STUBS.md` or the current `CLAUDE.md` (a restored passage). A span not found whole is reported line by line.
- **paths-forward rows** (E1's M10 copied nothing: its brief sent ranks ≥ 30 to the rows `plans/FRONTIER-STUBS.md` already holds):
  each removed row must have a FRONTIER-STUBS row for each stub it names, holding every fact token of the removed row. A token that is
  not there fails, unless it is in the tool's `ROW_ALLOW` table with a reviewed reason (the table below).
- **pointer:** each hunk whose text landed elsewhere must name that file, and for `GROKKING-INSTANCES.md` the section.
- **completeness:** every word that left `CLAUDE.md` must lie inside a reported span, so the word alignment cannot hide a removal.
- **rewrites** (spans under 24 visible characters) are listed for reading, not scored: there was one, "both" → "the three" in the
  header's audit sentence.

**Result on E1's range** (`python3 tools/e2_moved_check.py --homes-rev aeef4e58`, exit 0; the same on the working tree): 11 spans —
10 moved, 1 rewrite; 2,668 lost words, all inside spans.

| span | old line | bytes | landed | pointer |
|---|---:|---:|---|---|
| E1's M9, "Not ours" (from "band rigidity") | 254 | 4,626 | verbatim in `LEDGER.md` | "`LEDGER.md` § The claim list" |
| E1's M10, paths-forward ranks 30–59 (15 rows) | 309– | 4,843 | by tokens in each row's own FRONTIER-STUBS row; not verbatim (by design) | the "30–59 … `plans/FRONTIER-STUBS.md`'s alone" row |
| E1's M1, G21 "periodic search … period cap" | 528 | 348 | verbatim in §G21 | §G21 (the one pointer, "the third, and the rest") |
| E1's M2, G21 "one-period census" | 528 | 451 | verbatim in §G21 (ends trimmed: "P3b", which stayed) | §G21 |
| E1's M3, G21 from "a finite configuration" to "(row 126)" | 528 | 2,154 | verbatim in §G21 | §G21 |
| E1's M5, G49 from "FS-79's instance" | 826 | 1,328 | verbatim in §G49 | §G49 |
| E1's M6, G50 from "FS-79's instances" | 836 | 1,525 | verbatim in §G50 | §G50 |
| E1's M7, G50 "FS-100 stage 5's" | 836 | 368 | verbatim in §G50 | §G50 |
| E1's M8, G72's per-milestone count | 1400 | 2,388 | verbatim in §G72 | §G72 |
| E1's M11, § Building "(b) The repair attempt" | 1815 | 342 | verbatim in § Building | "§ Building" |

**Reviewed allowances for the row check** (`ROW_ALLOW`; each is a token the removed `CLAUDE.md` row carried and its FRONTIER-STUBS row
does not):

| row | token | why it may be absent |
|---|---|---|
| FS-65 (34) | G64 | a cross-reference; FRONTIER-STUBS's row states the consequence, and G56/G59/G64 hold the wall's meaning |
| FS-65 (34) | `α(Γ_q)` | notation: FRONTIER-STUBS writes `α(UD(𝔽_q,2))`, and Γ_q := UD(𝔽_q, 2) (§ Notation) |
| FS-41 … FS-52 (38–42) | row 66 | FS-42's row says "Row 66 leaves exactly one constructive residue route" (capital R) |
| FS-20, FS-17, FS-2 (43–45) | 97, FS-66 | **FRONTIER-STUBS's FS-17 row is stale**: it reads α ≤ 105 (FS-56); the CLAUDE.md row had α ≤ 97 by FS-66's certificate. The fact itself stays in `CLAUDE.md` (Frontier item 17: "`α(Γ₂₃) ≤ 97`"), so nothing is lost from the corpus, but the stub's own row is now the only stub-table text and it is out of date. FS-65's row ("certificate ≤ 105") likewise. Owed to FRONTIER-STUBS, outside E2's touch list: held for the owner |
| FS-20, FS-17, FS-2 (43–45) | row 71 | FS-17's row states five refused at 23 (FS-56's certificate) without the row number |
| FS-13 … FS-37 (46–49) | FS-47 | the FS-37 ↔ FS-47 link stays in `CLAUDE.md` from the other side (rank 27's FS-47 row, "with FS-37"; G35's gate) |
| FS-9, FS-10, FS-5 (57–59) | row 80 | FS-9's row cites row 80's derivation (`plans/FS79-derivation.md` T26); G30 and G73 carry row 80 |

**Planted faults** (`--self-test`, each on copies of the homes at `aeef4e58`, never in the tree), exit 0:

| plant | must | result |
|---|---|---|
| partner: homes as E1 left them | pass | 0 failures |
| 1: one moved line of M1 deleted from `GROKKING-INSTANCES.md` | fail for that line only | 1 failure: `LOST line … L3e1c94c6 …` |
| 2: one "Not ours" line deleted from `LEDGER.md` | fail for that line only | 1 failure: `LOST line … Sokolov–Voronov …` |
| 3: `` `struction` `` dropped from FS-65's FRONTIER-STUBS row | fail for that row | 1 failure: `LOST tokens of row ['FS-65']` |
| 4: the §G49 pointer dropped from `CLAUDE.md` | fail for that pointer | 1 failure: `NO POINTER in hunk 11 to §G49` |
| partner 5: M11 restored to `CLAUDE.md` and gone from its home | pass | 0 failures |
| 6: one removed span hidden from the checks | completeness fails | 1 failure: `UNCOVERED words …` |

**Mechanical verdict: every passage landed, and every hunk keeps a pointer.** Two weaknesses the tool passes and a reader should know:
the §G21 pointer ("the third, and the rest") sits after FS-81's items, so it does not visibly cover M1 and M2, which were cut from
earlier in the paragraph; and G68 ("row 81; G21") and G73 ("G21's one-period census") address M2 by its old place (stage 2).

Would-have-searched log: none.
