# FS129-F1 — the front page, FS-129's record (the Clerk's record)

Worktree `/home/kooshi/source/lean-dir-fs129-close`, branch `fs129-filing`, from `main` at the brief's launch commit. Scripts that apply the drafts
(`file_ledger.py`, `file_claude.py`, ...) are in this directory; each reads its draft by script from the source file and asserts every slot matches once.

## Theorems this phase proved

None. A filing job.

## Stage 1 — SAVED: readback, worktree, manifest table

**Readback.** The brief's quotations: Keryx's workflow lines ("Every draft is written by a lane ...", "When the filing is large, the Clerk is your pen
...") are quoted from `.claude/output-styles/keryx.md` § The filing; not re-checked word for word (CHECK, below). Every slot string the manifest and Z2
name was checked by assertion (each occurs exactly once in its target) in the scripts. Worktree created by the brief's command (exit 0).

**Manifest as a table** (target | unit | source address | merge).

| # | target | unit | source | ruled merge |
|---|---|---|---|---|
| 1a | `LEDGER.md` § A after row 148 | rows 149–154 | `plans/FS129-Z2-record.md` § Drafts, `LEDGER.md` § A — rows 149–154 | none |
| 1b | `LEDGER.md` row 121, Where cell | appended "; `plans/FS84-SI-D-derivation.md` (J45-N1 ...)" | same, "And row 121, its Where column" | none |
| 2a | `CLAUDE.md` "Last updated" | Z2 unit 1 | Z2 § `CLAUDE.md` § Frontier, 1 | none |
| 2b | `CLAUDE.md` § Paths forward, Open milestones | Z2 unit 2 | same, 2 | "then the top of FS129-P1's ranking." -> "then the top of the ranking, FS-124, the (Q) ring (its question posed in `plans/STUB-q-ring.md`)." (item 159) |
| 2c | `CLAUDE.md` item 31 | Z2 unit 3 | same, 3 | none |
| 2d | `CLAUDE.md` theory paragraph | one sentence | same, "The theory paragraph" | none |
| 2e | `CLAUDE.md` § Paths forward table, rows 1–3 | P1's top three | `plans/POROS-2026-10-03-fs129-rerank.md` § Draft re-rank, "The top three, as `CLAUDE.md` § Paths forward should carry them" | none |
| 2f | `CLAUDE.md` § The aim, programme paragraph | three re-aimed names | brief § ruled merges (item 165) | used: FS-123 -> "the Siamese class"; FS-128 -> "the top colour, at five and six"; FS-120 -> "the pinch at a junction, and the cover route at five" |
| 2g | `CLAUDE.md` § The novel-results ledger | "Rows 1–148" -> "Rows 1–154" | brief | used |

## Stage 2 — SAVED: `LEDGER.md` and `CLAUDE.md` (items 1–2)

Applied by `data/fs129/f1/file_ledger.py` and `file_claude.py` (all slots asserted once). Rows 149–154 sit after row 148 (§ A); row 121's Where cell
gained the FS84-SI-D clause before its " | FS-100 stage 5" cell. In `CLAUDE.md`: units 1, 2, 3 and the theory sentence replaced as drafted (the theory
sentence's slot breaks across a line in the file, "such a / vertex ..."; the replacement keeps the draft's words and puts its own line break); P1's
three table rows in place of the three ranked rows; the ruled merges of items 2b, 2f, 2g used as in the table above. `CLAUDE.md` has no "G1–G91".

Gates (saved: `fact_audit_stage2.txt`, `dupes_stage2.txt`):
- `wc -c`: `CLAUDE.md` 51,126 (< 80,000); `.claude/skills/grokkings/SKILL.md` 168,727 before item 3 (< 200,000).
- `tools/claude_md_fact_audit.py --base f411553f`: **exit 1**, one failure: `lost chunk token '131–141'`. Cause: the draft's item 31 opens "(§ The aim; rows
  131–154; …" where the old text read "rows 131–141, 145–148, 142–144"; the draft's range subsumes them but the token "131–141" no longer occurs. Not
  fixed (no word of mine); see HELD.
- `--dupes`: exit 0; 163 repeated runs, 15,161 bytes, against 154 runs and 14,287 bytes on `main` — the rows 149–154's quotations repeat their
  derivation entries' words by design.

## Stage 3 — SAVED: items 3–8

Applied by `data/fs129/f1/file_items3to8.py` (every slot asserted once).

| item | target | source | note |
|---|---|---|---|
| 3 | `.claude/skills/grokkings/SKILL.md`: G92 placed directly after G91's entry (the file is not in number order; G91 is followed by the G51 pointer); front matter "entries G1 to G91" -> "G1 to G92" (ruled merge, used) | Z2 § Proposed grokking G92 | no "G1–G91" in `CLAUDE.md` |
| 4 | `plans/GROKKING-INSTANCES.md`: slot 1 at the end of § G49, slot 2 at the end of § G83, slot 3 at the end of § G87 | Z2 § `plans/GROKKING-INSTANCES.md`, slots 1–3 | |
| 5 | `BIBLIOGRAPHY.md` `[Falconer1981]` row, its "what of ours rests on it" cell | Z2 § Bibliography | the draft says the cell "gains" the words; I appended them to the cell's end after "FS-103 (row 130), FS-104;" |
| 6 | `plans/FRONTIER-STUBS.md`: § Ranked stubs table replaced by `data/fs129/p1/frontier-table-draft.md` (76 table lines; 13 rows differ from the file's, modulo rank; FS-117's cell is in the draft); the open-milestones paragraph's sentence replaced by P1's | P1 § Draft re-rank, "The open-milestones paragraph" | |
| 7 | five banners (FS-123 1→2, FS-125 4→5, FS-122 5→6, FS-126 7→9, FS-115 18→19) as blockquotes directly under each stub's title; three title names re-aimed (ruled merge, used) | P1 "Banner lines"; brief § merges | FS-123's earlier re-aim banner left in place below the new one |
| 8 | `plans/FS129-derivation.md`: dated notes after the FS129-OA1-FALC-11 block and after the FS129-MA2-FALC-HOSTS block (each after its control and "Superseded" paragraph) | `plans/SEARCH-QUEUE.md` row 1; `plans/SEARCH-2026-10-03.md` l. 10, 13–19, § 2.4 | quoted by script |

Gates (saved in `data/fs129/f1/gates/`; each read by exit status):
- `bib_audit.py` exit 0 (0 cited-undefined keys).
- `derive_gate.py all plans/FS129-derivation.md` exit 0: GATE PASS (0 failures, 55 warnings; 28 controls fired on their faults).
- `rk_mirror_check.py` exit 2: prints "RETIRED (Workflow 3.1, 2026-10-03) ... no longer run at a filing." Not run as a gate.
- `check_architecture.py` exit 0 PASS; `identities.py check` exit 0 PASS.
- Sizes: `CLAUDE.md` 51,126; SKILL.md 170,280.
- `claude_md_fact_audit.py --base f411553f`: **exit 1, 11 failures** (on `main`, same base: PASS). Each is a token the filed drafts no longer hold:
  `'131–141'` (CLAUDE.md item 31, Z2 unit 3's "rows 131–154"); and from P1's rewritten table rows (the old rows' words, in FRONTIER-STUBS as
  the external home): `'j = 2, 3'`, `'104–108'`, `'109–111'`, `"C114-LOCAL-F's"`, `"FS114-Y2-BOWTIE's"`, `"FS116-N2's"`, `'REG-J′-C₅'`, `'√ε'`, `'(R2)'` (chunk),
  and `external home plans/FRONTIER-STUBS.md lacks num token '0.03'` (the old FS-104 row's "the advisor's prior for six itself ≈ 0.03"). Not repaired:
  restoring a token is a word the manifest does not give.
- `--dupes` exit 0: 163 runs / 15,161 bytes (main: 154 / 14,287).

## Stage 4 — SAVED: the Proof Atlas (item 9), partly; the build refuses

- Step 1 (checker first, before editing; `gates/atlas_check_step1.txt`): 9 failures. Three are on `main` too (checked in the main tree: R134's "BASE-V stands
  beside them …" quote, FS124's grade words "The main remaining case set of the six-map NO with unit arcs.", the note "publish"'s quote "Nothing is
  published before it is formalized in Lean, in full, with no declared purchases"). Six were caused by this filing.
- Step 3: Z2's nodes QFREE, QPRUNE, TOP5 and edges (GFREE→QFREE, QFREE→LOCALF, QPRUNE→LOCALF) inserted verbatim: nodes before `N("RINGRULE"`, edges before
  `E("RINGRULE", "LOCALF"`; meta now built="2026-10-03", job="FS129-F1", as_of="FS-129's record". Mechanical re-pointing so the old facts' quotes still
  stand (quote words only, no new claim): FS123's title quote ("the (Q)-free ring:" -> "the Siamese class:"), FS120's ("the pinch at a junction:" ->
  "the pinch at a junction, and the cover route at five:"), `FSR(20)` -> `FSR(21)` for FS-59 (3 uses), the BOWTIE→TSMYES edge's row "18" -> "19". The nodes'
  own labels and plain text (FS123 still reads "the (Q)-free ring") are untouched.
- Layout (mine to decide): positions provisional in Z2; `data/fs129/f1/place_atlas.py` searched free spots for the three nodes: QFREE (84, 520),
  QPRUNE (80, 540), TOP5 (162, 434); lint "0 overlaps".
- Step 5: facts writer exit 0 (89 nodes, 106 edges); checker **exit 1, "checked 212, failed 4"**: the three `main` failures above plus **FS104**:
  its registered verbal probability "success low, a named no-go the likely product" no longer stands in `CLAUDE.md` § Paths forward item 3 (P1's row
  replaced it). Palette review exit 0 ("0 failed"), its self-test exit 0; the checker's `--self-test` exit 1 (it runs on the failing real facts); the
  build **refuses** ("the facts check failed"). `index.html` not rebuilt. Not repaired: each repair is a ruling (below).
- Step 6 (DESIGN.md stage section; distances) not done: it needs the build.

## Stage 5 — SAVED: the coordinator's amendment (R1–R7), every gate again

Amendment read from `/home/kooshi/source/lean-dir/data/fs129/briefs/FS129-F1-front-page.md` § Amendment.
- **R1** (`tools/claude_md_fact_audit.py`, ALLOW table): one entry per token, reason "FS129-P1 re-drafted the ranked row; the fact stays in `<file>`", the
  file being the first my grep found: `j = 2, 3` -> STUB-cp-plane-six; `104–108`, `109–111`, `C114-LOCAL-F's`, `FS114-Y2-BOWTIE's` -> STUB-qfree-ring;
  `FS116-N2's`, `√ε` -> STUB-q-ring; `REG-J′-C₅` -> STUB-map-step; `(R2)` -> STUB-curved-pencils (found in ten stubs); `131–141`: "item 31's row range now
  reads 131–154 (FS-129's rows 149–154)". Every token was found in a stub. `0.03` was an EXTERNAL_HOMES entry pointing at FRONTIER-STUBS (a verified
  allowance, which cannot be satisfied by ALLOW): re-pointed to `plans/STUB-cp-plane-six.md` (its "advisor's prior … P ≈ 0.03" line), same reason text.
  **One more, a consequence of R4:** `plans/FS129-cross-application-audit.md` (code and chunk token) left the corpus when R4 replaced the Opened sentence;
  I added one ALLOW entry (reason: FS-129 is Derived, R4 replaced the sentence naming its plan, the file stays) — not authorized word for word; CHECK.
  Fact audit `--base f411553f`: exit 0, PASS. `--dupes` exit 0, 163 runs / 15,161 bytes.
- **R2** (atlas; listed in DESIGN.md's FS129-F1 section): R134's second quote -> FRONTIER-STUBS § Open milestones, in order; FS124's grade words -> "The main
  remaining case set of the six-map NO with unit arcs, and the YES side's home"; "publish" text and quote -> "… in Lean, in full."; FS104's registration
  **removed** (its row as filed gives none); FS123's label and plain text -> "the Siamese class". Checker "checked 212, failed 0, errors 0"; checker
  self-test PASS; palette review 0 failed and its self-test PASS; build exit 0 (`index.html` 176,030 bytes); DESIGN.md stage section written, with the look
  and the distances said not done.
- **R3** done ("4–74 | 71 more open stubs"). **R4** done (Derived sentence; FS-129's Next clause removed; "from `plans/LEAN-BACKLOG.md`"). **R5** done (queue row 5's
  "what it would decide" cell quoted before the result bullets). **R6**, **R7**: no action.
- Gates (all in `gates/`): bib_audit 0; architecture PASS; identities PASS; sizes CLAUDE.md 51,126, SKILL.md 170,280; derive gate rerun (see the report);
  rk_mirror retired (exit 2, not run).
