# FS105-X — the front page for FS-105's close (record)

*Job FS105-X, Opus 5.5, 2026-09-26. Brief: `data/fs105/briefs/X105-front-page.md`, with `data/fs105/briefs/STANDING-RULES.md`. Drafts
applied: `plans/FS105-harden-mr.md` §R-close stage 4 (4.1–4.8), with the exact pairs of `data/fs105/fs105-c/claude_md_drafts.py` and
`data/fs105/fs105-c/ledger_drafts.py`. HEAD at launch: `1796ca10`.*

## Theorems this phase proved

None: this job applies drafts and proves nothing.

## Owner rulings and scope

- Held item (1), C's report: FS-103's blind grades stay as recorded; the G51 instance records the channels (applied verbatim, §G51).
- Held item (2): rank 1 after FS-105 is FS-104, the default C drafted; Kooshi may choose the FS-102 write-up instead.
- **Touch list extended by the owner** (message from "main", this session, answering my question): `plans/FS100-derivation.md`
  (FS100-PE2, FS100-EFP, FS100-EFG (b)), `plans/FS103-derivation.md` (FS103-DG's grade) and `data/fs105/claims.md` (the one-line note on
  (a0)), "Apply exactly C's drafts there (ledger_drafts.py pairs and §R-close 4.1), nothing else in those files, so each home matches its
  § B projection."

## Stage 1 — SAVED (quotation check; baseline gates; the plan)

**Quotation check (standing rule 5).** The brief quotes no mathematical statement; its quotations are rules. The standing rules' two
Kooshi quotations checked against `CLAUDE.md` on disk: "A proven theorem about why its impossible is also valid. All novel knowledge is a
success" — **matches** (§ Where the problem stands, item 23); "to eliminate the crutch of feeling like we're accomplishing something by
asking uncomputable problems for days at a time" — **matches** the portion `CLAUDE.md` § Toolchain carries (the standing rule's fuller
"The intent of the ban is …" frame is the same sentence). The brief's header-rule paraphrases (current state only; one home per fact; the
300,000-byte budget; step 9's "file new instances out of `CLAUDE.md`") re-read from disk: `CLAUDE.md` lines 12–31, `WORKFLOW.md` line 249 —
**match**.

**Baseline gates at `1796ca10`, before any edit** (each exit status read directly):
| gate | exit | reading |
|---|---|---|
| `claude_md_fact_audit.py --base 1796ca10` | 0 | AUDIT PASSED (0 failures) |
| `claude_md_fact_audit.py --dupes` | 0 | 10 repeated runs, 628 B (the limit is "not above 10") |
| `fs71_ledger_b_check.py --strict` | 1 | FAIL (19): the 19 FS105 entries have no § B rows yet — the drafts supply them |
| `bib_audit.py` | 1 | UNLOGGED PRIOR ART: 3 — arXiv:2605.28709, arXiv:2607.05083 (FS105-W's titles, drafted for § C) and `[BekkaFrancini2020]` (FS105-R; C: "the plan's `[BekkaFrancini2020]` is this held paper") |
| `check_architecture.py` | 0 | PASS |

`CLAUDE.md` before: **296,232 bytes**. `claude_md_drafts.py --check`: 296,232 → 296,382 (+150), PASS; `--self-test`: the planted pair
refused.

**The plan.** Stage 2: `LEDGER.md`, `plans/FS100-derivation.md`, `plans/FS103-derivation.md` from `ledger_drafts.py`; the (a0) note.
Stage 3: `CLAUDE.md` from `claude_md_drafts.py`. Stage 4: `BIBLIOGRAPHY.md` (4.3) and `plans/FRONTIER-STUBS.md` (4.4). Stage 5:
`plans/GROKKING-INSTANCES.md` (4.6) and the two protocol fixes (4.7). Stage 6: every gate, the report.

**Would have searched here:** nothing — this job edits text from drafts.

### Stage 1 — SAVED

## Stage 2 — SAVED (`LEDGER.md`, the two derivation homes, the (a0) note)

- `ledger_drafts.py --check --dir <my scratch>`: PASS (every pair once; FS105 entries 19 = § B rows 19); `--self-test`: the planted row
  caught. The copies were diffed against the files before copying: `LEDGER.md` lines 165 (row 120), 173–174 (rows 128, 129), 922, 926,
  977 (§ B: FS100-EFP, FS100-PE2, FS103-DG) and 19 appended § B rows (1002a1003,1021); `plans/FS100-derivation.md` lines 160, 189, 214
  (`pe2`, `efp`, `efg`); `plans/FS103-derivation.md` line 52 (`dg`). Nothing else moved. Bytes: `LEDGER.md` 422,988 → 428,504.
- `data/fs105/claims.md`: C's note (§R-close 4.1) added verbatim, italic, under the (a0) bullet; the fixed list itself untouched.
- **Gates after stage 2:** `fs71_ledger_b_check.py --strict` exit 0, PASS (836 § B rows); `claude_md_fact_audit.py --base 1796ca10`
  first read exit 1, three lost tokens from row 120's superseded text — `§§2–9` (its old grade), `§4.1–4.3` (its old reading scope),
  `c·M^{1/[F:ℚ]}` (its old count) — each superseded by C's drafts, so three ALLOW lines were added with those reasons under an FS105-X
  comment in `tools/claude_md_fact_audit.py`; re-run exit 0, AUDIT PASSED; `--self-test` exit 0; `--dupes` 10 (unchanged).

### Stage 2 — SAVED

## Stage 3 — SAVED (`CLAUDE.md`)

- `claude_md_drafts.py --check --out <my scratch>`: PASS, 296,232 → 296,382 (+150). The copy's diff against `CLAUDE.md` touched exactly the
  drafted lines — 138 (Last updated), 145 (the lower end's row-120 clause), 269 (Open milestones), 275–303 → 275–302 (FS-105's rank-1 row
  out, ranks 2–28 → 1–27, `29–61` → `28–60`; FS-104 at rank 1; FS-100's and FS-102's cells), 872 (G50), 1433 (G72's count and
  fifteenth), 1505 (G79), 1508 and 1510 (G80's body and *Do*) — then copied into place. **`CLAUDE.md`: 296,232 → 296,382 bytes, under
  300,000.** A grep of the new file for `Thm 1.2`, `EL2003`, `degree 16`, `harden`, `Sataev` found no other stale mention.
- **Fact audit** first read exit 1, eight lost tokens, each from text the drafts replaced: FS-103's Last-updated clause
  (`plans/RERANK-2026-09-26.md`, `RERANK`) and FS-105's departed rank-1 row (`plans/STUB-harden-mr.md`, `121–130`, `§§3`, `5–9`), all
  given **verified** `EXTERNAL_HOMES` entries (the audit reads the home and must find the token: `plans/FRONTIER-STUBS.md`,
  `plans/STUB-harden-mr.md`), and the group label `29–61` (renumbered `28–60`) an ALLOW line on the `30–62` precedent. Re-run: exit 0,
  AUDIT PASSED, the six homed tokens reported HOMED in their files; `--self-test` exit 0; `--dupes` 10 (unchanged, not above 10).

### Stage 3 — SAVED

## Stage 4 — SAVED (`BIBLIOGRAPHY.md`; `plans/FRONTIER-STUBS.md`)

**`BIBLIOGRAPHY.md`** by `data/fs105/fs105-x/bib_edits.py` (14 exact pairs, each required once; `--check` PASS, `--self-test` refuses a
plant; 455,266 → 459,970 bytes). C's §R-close 4.3 texts verbatim; where the file needed a cell C did not draft, the addition is minimal and
named here:
- `[EinsiedlerLindenstrauss2003]` moved from § C to § A (after EL2022) with C's read text in the read column and the path, md5
  (`430849cf…`, re-computed here: matches) and page count in the copy column; its "what rests" cell, not drafted, reads "row 120's grade
  (FS-105): the announcement EL2021 p. 2 cites for its Thm 1.2's proof, which it gives only in outline". A § B line for the PDF (drafted).
- `[EinsiedlerLindenstrauss2022]`: § A read column = C's text, **followed by the old column's facts C's text does not supersede** (§2
  set-up only; Lemma 4.2; the copies' provenance: md5, `0c61c274`, X10F's removal); § B line = C's text.
- `[Sataev1975]`: § C verdict = C's text; R.6 row's state "**closed** (FS-105): held and read (§ C)" (C: "The R.6 row closes as a debt").
  **RULE addition:** a § B line for its PDF (`BIBLIOGRAPHY.md` § D rule 0b: a read status lives in § A/§ C and the file's § B line).
- `[LindWard1988]` / `[ChothiEverestWard1997]`: C's text as the R.6 row's state (C's "(R.6, line 718)" read as the R.6 debt, whose
  detail row is § C line 718, left unchanged).
- New R.6 row, EL2021's `[10]`, `[11]`, `[5]`: keys `[EinsiedlerLindenstrauss2010]`, `[EinsiedlerLindenstrauss2019]`,
  `[EinsiedlerKatok2005]` (author-year, the file's convention); C's text split into the "rests" and "state" cells. **RULE addition:** three
  § C rows (titles, "not held, unread"), because a key cited in R.6 must resolve (`tools/bib_audit.py`); no arXiv ids written (none
  verified; "on arXiv" only, as C wrote).
- Jungić's line 635: doi and Zbl added, no new row (drafted). The two sphere titles: one § C row (drafted: "§ C, sphere problems by their
  titles"). Re-reads (W §5.3): appended to the § A read columns of `[AmbrusEtAl2023]`, `[DuczVarga2026]`, `[MatolcsiEtAl2025]`, the FS103
  precedent (§ A only; § B status unchanged).
- **RULE addition:** § A′ alias `[BekkaFrancini2020]` → `[BekkaFrancini2022]` (C: "the plan's `[BekkaFrancini2020]` is this held paper";
  C drafted no new row, and bib_audit read the arXiv-year key as unlogged). `tools/bib_audit.py`: exit 0, "every cited work resolves".

**`plans/FRONTIER-STUBS.md`** by `data/fs105/fs105-x/frontier_edits.py` (5 pairs + the renumbering; `--check` PASS, `--self-test`
refuses a plant; 123,055 → 123,592): Open milestones (C's text); the header note above FS-103's (C's text); FS-105's rank-1 row out, ranks
2–61 → 1–60 (60 rows moved, checked); FS-100's "MR's hardening moves to FS-105." → "MR hardened at FS-105 (row 120's grade)."; FS-102's row
gains 4.8's sentence ("EL2021's" added before `[11]` so the numeral names its paper); the closed list's head entry (C's text). **The
mirror:** `CLAUDE.md` ranks 1–27 and the `28–60` group checked against this table by script — 27 of 27 and 33 of 33 agree.

**Gates:** fact audit exit 0 (the seven HOMED tokens found in `plans/FRONTIER-STUBS.md` and `plans/STUB-harden-mr.md` after the edit);
`bib_audit.py` exit 0.

### Stage 4 — SAVED

## Stage 5 — SAVED (`plans/GROKKING-INSTANCES.md`; the two protocol fixes)

- **Instances** by `data/fs105/fs105-x/instances_edits.py` (each at the end of its section, before the next heading; `--check` PASS,
  `--self-test` refuses a planted heading; 70,388 → 73,765 bytes): §G50, §G51, §G72, §G79, § The standard of evidence — C's five texts,
  checked verbatim by script against §R-close 4.6 (5 of 5 found). **First application raised `--dupes` from 10 to 12**: my attribution
  line (`*FS105-X, a new instance, FS-105's close (\`plans/FS105-harden-mr.md\` §R-close 4.6):*`) ran into the instances' own opening
  address, a repeated 10-word run; reverted, the attribution shortened to `*FS105-X, FS-105's close (§R-close 4.6):*` (each instance
  carries its full source address in its first words), re-applied: `--dupes` 10.
- **Protocols** (by hand, after reading each target): `plans/PROTOCOL-competitor-and-advisor.md` rule 1, C's paragraph after the first
  sentence's instance ("… Give each session its own directory and say so."); `plans/PROTOCOL-crunch.md` §6.1 item 6, C's clause after "the
  bodies of the fenced jobs' commits"; §7's rules table, rule 10, the same list and C's incident sentence. All three checked verbatim by
  script against §R-close 4.7 (whitespace-normalised: 3 of 3).
- **Gates:** fact audit exit 0, AUDIT PASSED; `--dupes` 10.

### Stage 5 — SAVED

## Stage 6 — SAVED (the final gates; what is left; the report)

**Final gates** (HEAD `039e6f08` plus this stage's record; each exit status read directly):
| gate | exit | reading |
|---|---|---|
| `claude_md_fact_audit.py --base 1796ca10` | 0 | AUDIT PASSED — with four ALLOW lines (`§§2–9`, `§4.1–4.3`, `c·M^{1/[F:ℚ]}`: row 120's superseded text; `29–61`: the renumbered group label) and six verified EXTERNAL_HOMES (`plans/RERANK-2026-09-26.md`, `RERANK`, `plans/STUB-harden-mr.md` in `plans/FRONTIER-STUBS.md`; `121–130`, `§§3`, `5–9` in `plans/STUB-harden-mr.md`), each with its reason in the tool |
| `claude_md_fact_audit.py --dupes` | 0 | 10 (not above 10; unchanged from launch) |
| `claude_md_fact_audit.py --self-test` | 0 | SELF-TEST PASSED |
| `fs71_ledger_b_check.py --strict` | 0 | PASS (836 § B rows; launch: FAIL (19), the missing FS105 rows) |
| `bib_audit.py` | 0 | every cited work resolves (launch: 3 unlogged) |
| `check_architecture.py` | 0 | PASS |

**`CLAUDE.md`: 296,232 bytes before, 296,382 after** (+150, C's figure), under 300,000; nothing moved to the instances file for budget.

**Verbatim check** (script, whitespace-normalised) of C's quoted texts against the files: §R-close 4.2 — every new text present, every
old text gone; 4.3 — every text present except the two C wrote as one string that the file's columns split (EL2003's held/path/md5
sentence; the new R.6 row's rests/state), both present cell by cell; 4.4 — every text present; 4.6 — 5 of 5; 4.7 — 3 of 3.

**Left (applied nothing in its place):**
- `CLOSED-QUESTIONS.md`: C drafted no row; untouched.
- §R-close 4.8: FS-102's **stub** (`plans/STUB-writeup-main-clause-five.md`) gaining the Thm 1.3 / `[11]` Prop. 6.4 sentence (its
  FRONTIER-STUBS row has it), and FS-100's "MR's complex-place case on an instance now carries B's scope remark (ii), Lemma 0, as its named
  step" (no exact text drafted for the row or the stub): outside the touch list.
- Noticed, not drafted: `BIBLIOGRAPHY.md` § A `[EinsiedlerLindenstrauss2022]`'s "what rests" cell still reads "its Thm 1.2 (EL2003's
  Thm 1.1) … PE-2's positive-entropy input (row 120)"; row 120 now names Thm 1.3 plus FS105-DED as the input.

### Stage 6 — SAVED
