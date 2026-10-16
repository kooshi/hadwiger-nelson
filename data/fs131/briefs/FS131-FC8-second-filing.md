# Brief FS131-FC8 — the second filing: find every front-page draft the last two weeks left unfiled, file the ready ones word for word, and table the rest

*Written 2026-10-16 03:55 UTC by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-FC8
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing, and before it its finder
  role: the finder and pen for one filing — four lists of corrections and drafts owed to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, and a few stubs) were written across four handoffs; you find, for each item, whether it is already filed, where its drafted words are, and whether their slot is on `main` exactly once; you file the ready ones word for word, and table every other one for my ruling
  launch: now, in a worktree of your own; beside you a kernel planner works in another worktree and writes none of these files
  mission: § Why this job
  statements: § What is owed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage when stage 2's table is committed, and at once if a check fails in a way no draft explains; the report goes to `data/fs131/reports/FS131-FC8.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (rules 6 and 13 changed today: never push; everything committed may be published)
  record: `data/fs131/reports/FS131-FC8.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/filing2` (branch `fs131-fc8`, cut from `main` at `5af212aca`; no Lean build, no `.lake`): the files the ready drafts name — of `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, `CLOSED-QUESTIONS.md`, `plans/FRONTIER-STUBS.md` and the `plans/STUB-*.md` files — and nothing else of the front files; never a file under `Proofs/` or `scripts/`; your table, scripts and outputs under `data/fs131/fc8/`; `data/fs131/reports/FS131-FC8.md`. Commit on your branch by explicit path; the coordinator merges it; never push
  budget: about 250k by the harness's count, as guidance; save a stage (a commit) after each stage below; hand back at a saved stage before about 350k

Hello. Seven filings like this have been done here; the clerks who did them guessed at nothing and wrote `CHECK:` where
they would have had to, and every one of those lines was ruled on. This one is larger and older: its items were
written down across four days, and some may already be done.

## Why this job

The repository went public this morning (`https://github.com/kooshi/hadwiger-nelson`). Its front page and ledger still
carry a few statements that the records already correct — one undersells a result of ours as "not new" where the
reading says its plane case is not in print, one row's "Not claimed" still lists a kernel proof the kernel now holds —
and a backlog of `LEAN.md` lines and bibliography lines the lanes drafted and nobody filed. Those drafts are the lanes'
words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would have to guess, write a
`CHECK:` line and do not guess.

## What is owed

The newest list, which names the next older one:

> 3. **The second filing**: `plans/SESSION-HANDOFF-2026-10-15.md` § 6, less two items now done — the first pass's bibliography drafts
>    (filed, item 961) and the README's gated-commit hash (`752b11569`).
> — source: plans/SESSION-HANDOFF-2026-10-16.md § 4. Next, in order

That older list (the 2026-10-15 handoff's "second filing"):

> - `LEDGER.md` notes for rows 120, 121, 123, 127 and 128;
> - the `[Davies2026]` corrections (item 948);
> - FS131-PR1's drafts D1–D8 (item 951);
> - FS131-PS2's bibliography drafts D1–D5 (item 955);
> - the counts in `ARCHITECTURE.md` § 5;
> - the `LEAN.md` lines of the older handoff's § 6;
> - the prices to correct: M13, the dyadic certificates, IKC4, the search's estimate, and F2's design;
> - EN1-UQ4's grade line;
> - the README's "gated at commit" hash. After the rewrite this must be the new history's hash for the gated commit
>   (filter-repo's commit map).
> — source: plans/SESSION-HANDOFF-2026-10-15.md § 6. Owed, in the new working copy

It names the 2026-10-14 handoff's list, whose first bullet is:

> - **The second filing** (base `8eece67b0`): the older handoff's § 7 list; the `LEAN.md` lines drafted in today's records (KN7, KN8,
>   KN9, KT1, K8B1, KPD1, KR1, K12A, KDB1, KC13, KM11, ITK1, IJ1, IJ2, IJ3, IM11, ILA1, ICL1, ICL2, ICM1, ICM2, IKC1–IKC3, IDB1–IDB3,
>   IN1L, IDG1, IG1, IPA1, IPB1, IPD1, IP23, ITT1, the port's classes); bibliography lines (`[EinsiedlerLindenstrauss2022]`,
>   `[OAIMath2026]`, `[Rudin1962]`, `[AmbrusEtAl2023]` with p. 18's sign of `J₀′`, `[KMOR2016]`, Schur 1912 (key `Schur1912`, "recalled, not read"), and
>   those KR1, K12A, KC13 drafted); corrections: `plans/EXT-OAI1-audit.md` 16,600 → 12,005 lines; `scripts/Vacuity.lean` l. 561; the
>   density bound's price (items 818, 823); M13's prices (items 848, 893, 905); K2's price (item 886); F2's price (item 902); J26/J49's
>   grade note (item 845); KDB1's prototype truncation (item 911); the IDB1 record's mis-headed last section (item 895); J45's erratum
>   (item 873); FS-133's deriver's predictions to score; the `--dupes` +1 run.
> — source: plans/SESSION-HANDOFF-2026-10-14.md § 6. Owed, not done

which in turn names the 2026-10-13 handoff's § 7, whose first bullet is:

> - **One filing by the Clerk, when no landing is in flight** — drafts exist in the lanes' records: the direction change
>   on the front page (`CLAUDE.md` § The aim takes W1 and W2; the open-milestones line; item 636); `LEDGER.md` § The
>   claim list's "Not ours" phrase (item 640); rows 52, 57, 121, 127 (item 643, the map's § X9); row 128's prior-art
>   clause, `CLOSED-QUESTIONS.md` § 1.7 and § 3, the write-up stub's banner (items 644, 655); row 121's source cell and
>   two errata (item 651); the row for FS129-SA1-FALC-RED — its bound is on the Borel number (item 684); `[Davies2026]`
>   to "read in full" (item 655); a `LEAN.md` rule on axiom binders (item 659 (a)) and the implementers' `LEAN.md` lines;
>   FS-136's record note (FS-124 item 52 (3)); the asking lane's parked re-rank draft.
> — source: plans/SESSION-HANDOFF-2026-10-13.md § 7. Owed, not done

The README job's drafts D1–D8 are copied, unchanged, into `data/fs131/filing2/pr1-drafts.md` (its record is not in this
repository's history; the copy's header says where it came from). The two inventory items that bear on them:

> 948. **FS131-PR1 asks two questions on `[Davies2026]` (logged 2026-10-15 01:59 UTC; by message).** Its words: "(1) The density equality (row 129, FS-133) … The row never cites [Davies2026] … CLAUDE.md l. 158 says: 'the statement is not new (`[Davies2026]`, in dimension four and up, names the plane as its aim)'"; "(2) BIBLIOGRAPHY.md l. 978 … 'A full reading is owed before rows 121–123 or 128 are announced.' … Is that reading owed before the push?" **My receipts:** `BIBLIOGRAPHY.md` l. 978 reads as quoted; the full reading exists — `plans/FS131-ER1-davies-reading.md` (FS131-ER1, 2026-10-13; items 654–655), its § Stage 7: the d = 2 density equality "is not singled out anywhere" in the paper, which proves it for d ⩾ 4; item 654: rows 121 and 123 "posed as open on p. 5, by the three classes modulo 168 … not proved or implied". **Rulings, four parts.** (1) *Row 129's wording on the page:* "prior art not found in print" for the plane, `[Davies2026]` Thm 1.1 the same equality for d ⩾ 4, the plane's case posed by `[DuczVarga2026]` Conj. 1 and `[MatolcsiEtAl2025]` §2; alternative, `CLAUDE.md`'s "not new … names the plane as its aim" — declined, ER1 § Stage 7 says the paper does not single the plane's density equality out, and "not new" misstates a result whose plane case is not in print; high. (2) *The reading owed:* already done (ER1); the README may name rows 121–123, the question worded by item 655 (c); alternative, a fresh reading before the push — declined, the record is a full reading with its limits stated; high. **Corrections owed (the second filing), my slip:** item 655's `BIBLIOGRAPHY.md` correction for `[Davies2026]` ("read in full") was never filed; `CLAUDE.md` l. 158 and l. 196 overstate against ER1 § Stage 7 — the README's drafter (FS131-PR1) drafts them.
> — source: plans/FS131-close-inventory.md

> 951. **FS131-PR1 handed back: the public README and roadmap drafted (logged 2026-10-15 02:14 UTC; "JOB FS131-PR1 — DONE"; 386k by the harness's count; branch `fs131-pr1` at `8b63d9a51`, tree `fs131-wq1`; record `plans/FS131-PR1-readme.md`, report `data/fs131/reports/FS131-PR1.md` there).** From its hand-back message: "`README.md` (root, 173 lines) drafted"; "`ROADMAP.md` (root, 292 lines) drafted. The body is ranked by bearing on six against seven"; "four directory READMEs"; "every Lean name the two pages cite (43) elaborates"; corrections owed, drafted as D1–D8 in its record § Stage 2 (`CLAUDE.md` ll. 158, 196; `plans/FRONTIER-STUBS.md` l. 28; `plans/STUB-one-class-transfer.md` l. 3; `BIBLIOGRAPHY.md` l. 978 and FS131-ER1 § 9.2's unfiled drafts; row 123's "Not claimed"; row 120's grade; `ARCHITECTURE.md` § 5's counts); a question: "row 128's collapse is 'given MR'. The kernel now holds `Rigidity.mrPlus (F) : MRPlus F` for every real number field … I have not checked whether `MRPlus` is the form row 128's proof uses"; held for Kooshi: the licence, the repository's name, what is public, the README naming him and the agents' maker. **My receipts:** nine commits on `fs131-pr1`, touching `README.md`, `ROADMAP.md`, four directory READMEs, its record and `data/` only; I read `README.md` in full and `ROADMAP.md` §§ 1–2: every path the README names exists (`lakefile.toml` with `rev = "v4.32.0"`, `install-toolchain.sh`, `scripts/dev-env.sh`, `Instances/SpindleBound.lean`, the gate scripts; `build.sh`'s defaults `BATCH=10`, `MEMMAX=100G` as stated); its novelty wording is the ledger's ("prior art: not found in print", the parts not ours named; the `[Davies2026]` clauses as item 948 ruled); W2's pricing sentence quoted correctly. **One overstatement found:** `ROADMAP.md` l. 30 says the unlanded waves are "proved on branches but not yet merged"; the branches `fs131-w7`, `w7a`, `w7b`, `w7f`, `w7m`, `w9`, `w9b` (last commits 2026-10-06) are unmerged and carry `sorry` tokens in `Plane/` (5 to 29 each, by `git grep -c -w`) — skeletons and partial proofs, not proofs. **Rulings, four parts.** (1) *The drafts go to Kooshi with the held decisions; the l. 30 fix and his answers are made in one round on the same branch before it is merged:* alternative, merge now and fix after — declined, the sanitized copy is cut from `main`; high. (2) *Row 128 and `MRPlus`:* a planner's question for the next working session (W6: "Then we'll get back to work"), told to Kooshi as bearing on the answer; alternative, a job now — declined, the publication pass holds the slots' purpose and the question is not on its path; medium — changed if Kooshi wants it before the push. (3) *Corrections D1–D8:* the second filing, with the owed list; high. (4) *`CLAUDE.md`'s rule that the cost of landing on the standard three is measured "before publishing":* W6 directs the repository's push now; the measurement stays owed before a write-up, and `ROADMAP.md` § 2 says so; high. **Credited:** the four stale front-page claims found by reading, and the `MRPlus` question.
> — source: plans/FS131-close-inventory.md

Other drafts named above are in this repository: `plans/FS131-ER1-davies-reading.md` § 9.2 (the `[Davies2026]` cell
and rows 121, 123, 128, 129's prior-art lines); each job record the 2026-10-14 bullet names (`plans/FS131-<job>-*.md`,
their sections that draft `LEAN.md` or `BIBLIOGRAPHY.md` lines); `plans/FS131-EN1-derivation.md` (EN1-UQ4); the
inventory items each list cites (`plans/FS131-close-inventory.md`, one numbered line each). An item's later filing may
be recorded in a later inventory item or in a commit (`git log -S'<distinctive words>' -- <file>` finds when words
entered a file).

## Done means

1. **Stage 1 — the readback.** Check each quotation above against its source; restate in your report, in a short
   list, the four lists' items as you read them, and log any mismatch.
2. **Stage 2 — the table** (`data/fs131/fc8/owed.md`), one row per owed item, every item of all four lists and each
   of D1–D8 and § 9.2's drafts its own row: the item in a few words; its source (list and item number); its draft's
   address (file, section or line) or "no draft found"; its slot on `main` (the file and the exact words it replaces or
   follows) and how many times those words occur; and one status of four — **filed** (where and, if you can find it,
   by which commit), **ready** (a draft found and its slot found exactly once), **CHECK** (a draft found but its slot
   not found exactly once, or two drafts touch the same words, or the draft offers a choice — say which), or **no
   draft** (a list names a correction but no lane drafted its words — say what the list says is wrong and quote what
   the file says now). Commit; message me the counts of each status. Then go straight on to stage 3 with the
   **ready** rows; I rule on the others from the table.
3. **Stage 3 — the ready drafts in, by a script** (`data/fs131/fc8/file_owed.py`; the pattern is
   `data/fs131/fc6/file_fs131_ldb1.py`): it asserts every slot before it writes anything, puts each draft's text in
   exactly (nothing reworded, nothing added; joined as the target file wraps its lines), and prints what it did per
   row. A draft whose slot moved between your table and the script is skipped and becomes a `CHECK:`. (A saved stage.)
4. **Stage 4 — the checks**, each with its full output under `data/fs131/fc8/`:
   - `python3 tools/claude_md_fact_audit.py --base 5af212aca` (nothing lost by this filing) and the same with
     `--base 3c854fc0d` (the last filing; tokens it reports lost that this filing did not touch are listed, not acted on),
     and with `--dupes`. **A token reported lost is never allow-listed by you**: list it as a `CHECK:` with where it was
     and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes — it is at 79,235 now, so the
     `CLAUDE.md` drafts may not all fit: if one would cross the line, file nothing more in `CLAUDE.md` and write a
     `CHECK:` with the byte count, because the move that meets a budget is mine to rule).
5. **The report** (`data/fs131/reports/FS131-FC8.md`, and the same text as your hand-back), in the standing rules' form:
   the table's counts, per filed row what it did, each check's last lines, every `CHECK:`, the commits on your branch.

## What is yours to decide

How you search, the table's layout beyond the columns above, and how your script matches a slot. Where a draft in one
list is superseded by a later one for the same words, the later one is ready and the earlier is filed-by-supersession;
say so in the row. If an item looks wrong to you — a draft that would make a statement false against the ledger or the
kernel's print — mark it `CHECK:` and say why: a wrong draft reported is a finding. **My choices where a draft leaves
one to the coordinator:**

1. D7 (row 120's grade) is filed as its proposal reads.
2. D5 means `plans/FS131-ER1-davies-reading.md` § 9.2's drafts as written.
3. Whose a result is, exactly as the drafts say it: "prior art: not found in print" for ours; never "new" or "first",
   and never "not new" for a result of ours.
4. No milestone changes state in this filing, and the Proof Atlas is not touched.
5. Rows that need a lane's words that nobody drafted (prices to correct, predictions to score, a grade to restate) are
   **no draft**, never written by you.

## Amendment 1 (2026-10-16 04:09 UTC) — my rulings on stage 2's CHECK rows

Read from your table (`data/fs131/fc8/owed.md` at `828207831`). Each row's id is yours. The standing rules still hold in full:
no agents of your own (rule 1, because only the coordinator can review work it knows exists), never push (rule 6).

**File, as an extension of stage 3** (your touches grow by exactly the three derivation records named here, for these rows only):
1. **AXIOMS-ARCH** — read `ARCHITECTURE.md` § Trust; if KN3 § 5.3 item 4's line is absent, file KN7's version of it; if it is
   present without KN7's parenthesis, add the parenthesis as KN7 drafts it; if it is present with it, the row is filed. Say which.
2. **LEAN-KN7-A** — file KN7 ll. 660–662's instance as the last sentence of `LEAN.md` § Assumptions item 2.
3. **ERR-FS84-N1** and **ERR-FS100-Q47** — file EN1 § 8.3's drafted dated errata into `plans/FS84-SI-D-derivation.md` and
   `plans/FS100-derivation.md` at the slots they name, if each slot is found exactly once; otherwise a `CHECK:`.
4. **FS136-NOTE** — file the landing's draft 11 (c) words for C136-PARTNERS into `plans/FS136-derivation.md`, at the slot the
   draft names, if found exactly once; otherwise a `CHECK:`.
5. **The bibliography appends** (your 13 ready rows) and **BIB-Tate-Weil** (KN9's draft, the later of the two, one row each,
   placed with the other rows held "not held, not read") — after stage 4, if you are under about 300k by your own estimate;
   otherwise leave them listed as ready, and that is a good report.

**Declined, nothing to file** (each stays in your table with this reason):
- **L57kn1** — the slot moved; the words are owed to the next kernel-lane record that touches row 57.
- **LEAN-A-binder-rule** — the fact is already filed in KN3's words (your row above it).
- **LEAN-KR1-A** — moot: the density bound was proved, not declared (W6; FS131-LDB1).
- **LEAN-IPA1-IPB1**, **LEAN-IPD1-a** — no words quoted; owed to a de Bruijn record.
- **ERR-FS100-L5**, **ERR-K47**, **ERR-J45-KM11** — no words drafted; owed to a deriver.
- **RERANK** — stale: ranking the frontier is the asking lane's, when the frontier work resumes.
- **BIB-PS2**'s D3 — removed by Kooshi's word W14 (`data/fs131/REQUEST-2026-10-15.md`); D1, D2, D4, D5 are the filed ones.
