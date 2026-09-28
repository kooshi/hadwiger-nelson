# Brief X1 — the front page: file the closes of FS-114 and FS-111, verbatim, in one closing commit

*Written 2026-09-28 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: X1
  identity: de Bruijn — your agent file (`.claude/agents/debruijn.md`) is your identity; this job is clerical engineering held to your standard: every edit exact, every gate read by its exit status
  role: the front-page lane: file the lanes' drafts into the files Keryx alone writes, verbatim, and run the close's gates
  launch: after Poros's re-rank job, R1, has handed back and the coordinator has reviewed it
  mission: § Why this job
  statements: none — a filing job; every text it files is a draft named by address in § The manifest, and nothing else is written
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running; both milestones are closed
  channel: message the coordinator ("main") by SendMessage with any question mid-flight — and before writing any word the manifest does not give you; the report goes to `data/workflow3/reports/X1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-X1-front-page.md`
  touches: `plans/WORKFLOW3-X1-front-page.md`, `data/workflow3/x1/`, `data/workflow3/reports/X1.md`, and, in the worktree `/home/kooshi/source/lean-dir-close` on branch `close-2026-09-28` only, the targets in § The manifest
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are de Bruijn, acting as the front-page lane. Two milestones, FS-114 and FS-111, closed today under the new pipeline
(`CLAUDE.md` § The pipeline). Each close job wrote its derivation file and stubs directly and drafted every change to the front page;
Poros drafted the re-rank. The front page — `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`, `plans/GROKKING-INSTANCES.md`,
`plans/FRONTIER-STUBS.md`, the frozen claim lists and the close inventories — has one writer, Keryx, who files the lanes' drafts
verbatim and authors nothing. The filing is large, so Keryx's workflow (`.claude/output-styles/keryx.md` § A milestone, end to end, step
7) hands it to a front-page lane under the same rule. That is you.

## Why this job

Kooshi ruled today:

> "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old."
> — source: plans/WORKFLOW3-test-drive.md row K2

A fresh session opens the next milestone from what you file, so the front page must say exactly what the closes found, at their grades,
and nothing they did not.

## Where you work

Create a worktree from `main` and work only there, committing each stage on its branch and pushing the branch:
`git -C /home/kooshi/source/lean-dir worktree add /home/kooshi/source/lean-dir-close -b close-2026-09-28 main`. The main tree stays
untouched while you work; at the end Keryx folds your branch into `main` as the one closing commit. If the worktree already exists, you
are resuming: read your record there.

## The manifest

**First, before any draft is filed: Poros's corrections to the closes' drafts** (`plans/POROS-2026-09-28-close-reread.md` § Draft
re-rank, item 6 — F1, F9, F3, F2 and F6). Apply each to the draft it names, then file the corrected draft. The coordinator checked F1 at
its source — `plans/FS114-derivation.md`, FS114-N114-COMPACT's statement: "a radius uniform in `K` exists iff C-LOCAL holds" — and rules
all five filed: each narrows a claim to what the derivations show. F3 and F2 edit two stubs the closes wrote (`plans/STUB-local-exclusion.md`,
`plans/STUB-map-step.md`); F6 sets G72's count to "eighteen of twenty-one", in place of FS-114's drafted count.

Every draft below is filed as it stands. The sources are the two close records, `plans/FS114-C-close.md` (its `## Drafts for the front
page`) and `plans/FS111-C-close.md` (its `## Drafts for the front page`, D1–D10), the files they name, and Poros's record,
`plans/POROS-2026-09-28-close-reread.md` (its `## Draft re-rank` and `## Draft for CLAUDE.md § Paths forward`).

1. **`LEDGER.md` § A**: FS-114's rows 137 and 138, then FS-111's three rows, numbered **139, 140, 141** in place of `‹R111-a›`,
   `‹R111-b›`, `‹R111-c›`; then each close's corrections to existing rows (FS-114: rows 134, 135; FS-111: rows 130, 131, 133, 136).
2. **`LEDGER.md` § B**: FS-114's block, `data/fs114/fs114-c/ledger-b-draft.md`, then FS-111's 85 lines (D1), placeholders numbered as in
   item 1, both after FS-112's lines; then FS-114's corrections to FS-112's lines.
3. **`CLAUDE.md`**:
   - FS-114's unit replacements, each old unit found exactly once (its checker, `data/fs114/fs114-c/claude_md_units.py`, run from the
     repository root, confirms it; `--emit` prints the pairs): "Last updated", the open-milestones line, the programme line, item 31,
     G83 and the new G86, G72's count, "Rows 1–‹last›" with `‹last›` = 141.
   - FS-111's four clauses (D2), each at FS-114's `‹FS-111›` marker in the matching unit; G84 and G85 (D4), placed with G86 after G83 in
     numeric order.
   - Poros's § Paths forward table (its `## Draft for CLAUDE.md § Paths forward`, with the in-place amendments listed in
     `data/workflow3/r1/assemble.py`'s AMEND list), and **Poros's whole open-milestones unit**, which replaces FS-114's drafted one and
     already merges FS-111's clause.
4. **`plans/GROKKING-INSTANCES.md`**: both closes' instances, each under its rule's section (create a section in the file's form only
   where none exists, as for G67).
5. **`BIBLIOGRAPHY.md`**: FS-114's rows, alias and edits; FS-111's D5 (§ A amendments and rows, § C rows).
6. **`data/fs114/claims.md`**: FS-114's corrections as its § 9; **`data/fs111/claims.md`**: FS-111's D3 as a dated section at the end.
7. **Stubs**: the closed banners on `plans/STUB-global-step.md` (FS-114's draft) and `plans/STUB-reg-scale.md` (FS-111's D7), each under
   its title line; FS-111's D8 bearing lines in the stubs it names.
8. **`plans/FRONTIER-STUBS.md`**: Poros's draft re-rank (`data/workflow3/r1/ranked-table.md`, assembled by its script) with every block of
   its § Draft re-rank — its dated paragraph in the file's own form, its open-milestones text, the closed-list lines for FS-114 and FS-111,
   and its banner for `plans/STUB-stuck-ray.md`.
9. **The close inventories**: apply each close's proposed ticks (`data/fs114/fs114-c/ticks.md`, `data/fs111/fs111-c/ticks.md`),
   and tick "done" every later item the coordinator logged (FS-114 items 121–125, FS-111 items 38–42 and any after), each with where.
10. **The Proof Atlas**: both closes' entries and FS-114's "edits to existing nodes" into `tools/viz_proof_atlas_facts.py`; place the
    nodes (the drafts' coordinates are placeholders; `visualizations/proof-atlas/README.md` says how the layout lint judges them); run the
    checker and the build as that README says. Keryx republishes the page.
11. **Three tool repairs the coordinator assigns you** (standing rule 7's "never edit another job's tools" is lifted for these three only):
    make `tools/fs111_m3_honey.py` and `tools/fs111_m4_rungs.py` write their outputs to a path resolved from the script's own location,
    so each exits 0 on a pass from any directory, and show both runs, from the root and from `plans/`, before and after; add a one-line
    banner to `tools/fs111_m2_disck7.py` saying its HEX check builds a hexagon rotated 30° from its record's lattice and pointing to
    `tools/fs111_vm2_disc7.py`, which holds both orientations. Change nothing else in them.

**The merges Keryx has ruled, the only words you may add:**
- FS-111's "Last updated" clause ends with a full stop where it stands; its programme-line clause ends with a semicolon.
- Item 31's heading parenthesis reads "(§ The aim; rows 131–141; FS-116, FS-117, FS-120–FS-122)".
- Every `‹R111-a›`, `‹R111-b›`, `‹R111-c›` in any draft, Poros's included, becomes 139, 140, 141, and `‹R111-a›–‹R111-c›` becomes 139–141.

Anything else that seems to need a word of yours, a draft that does not fit its target, or two drafts that disagree: stop and ask "main".

## Done means

- Every manifest item filed on the branch, each listed in your record with its source address and its target, and every ruled merge
  listed where it was used.
- **The gates, each run in the worktree and read by its exit status** (standing rule 9), their outputs saved under `data/workflow3/x1/`:
  - `python3 tools/fs71_ledger_b_check.py --strict` exit 0;
  - `python3 tools/bib_audit.py` exit 0;
  - `python3 tools/claude_md_fact_audit.py --base a9410925` (FS-112's close) and `--dupes`: both clean, or every flag explained. If
    the base run flags tokens that this morning's refactor moved, run `--base 6f77a0ed` as well and report both;
  - `wc -c CLAUDE.md` under 300,000;
  - `python3 data/rerank-2026-09-27/rk_mirror_check.py`, `python3 tools/check_architecture.py`, `python3 scripts/identities.py check`;
  - `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS114-derivation.md` and the same for FS-111's;
  - the atlas checker and build.
- The report, in the standing rules' form, naming the branch's last commit.

## What is yours to decide

The order of the stages, how to apply each draft exactly (a script is better than hand edits), and the atlas layout. If a draft is
wrong — a quotation that does not match its source, a row that contradicts its derivation entry, a number that does not re-read — say so
rather than file it: that is a finding, not a refusal.

## Stages (save each in your record, and commit it on the branch; standing rule 2)

1. The readback; the worktree; the manifest turned into a table in your record (target, unit, source address, merge).
2. `LEDGER.md` (items 1–2), with the census check.
3. `CLAUDE.md` (item 3), with the size and the fact audit.
4. Items 4–8, with the bibliography audit and the mirror check.
5. Items 9–11, with the atlas checker and build.
6. Every gate, and the report.

Thank you.

## Amendment 1 — 2026-09-28 22:53 UTC, from the coordinator: rulings on X1's nine questions

Each ruling is the coordinator's, and these are the only words it adds beyond the merges above. The no-agents rule stands
(`plans/STANDING-RULES.md` rule 1). Touches unchanged.

- **Q1, G72's unit** — file exactly: "**The count so far — eighteen of twenty-one** (each derivation close's §IQ record; milestone by
  milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-114 and FS-111, both through)." Alternative weighed: your proposal,
  built from the drafts' own words — lost because the instances file is those words' home (one home per fact) and `CLAUDE.md` is at
  its budget. Confidence medium-high.
- **Q2, row 133** — option (a): keep the FS-110 parenthesis, as it stands, right after "route M, the map NO (FS-110's question, then
  FS-114's)". FS-111's draft says it is kept; (b) would drop a clause no draft asked to drop. High.
- **Q3, the global-step stub's bearing** — your proposal, which moves words and adds none. High.
- **Q4, D8's "add" lines** — your form, "*At FS-111's close:* …" appended to the sections you name; for FS-104, "## Bearing on χ ≥ 6",
  its bearing section, as D8 says "bearing". High.
- **Q5, § B's milestone column** — "row 139", "row 140", "row 141", the column's form in every other line. High.
- **Q6, the bibliography** — (a) no § A row for `[AxenovichLiuSagdeev2025]`; § C's row stands. (b) the `[Oostema2020]` edit is a no-op;
  say so in your record. (c) your separators. (d) `[Sirgedas2021]`'s read cell becomes the draft's text, "read: pp. 1–11 and 13
  (FS114-Y); its stitch is a seven-colour device"; the Google group row's verdict "**Held, unread**" becomes "**Held, partly read**", and
  the draft's text is appended — "unread" is no longer true, and this file holds current state. (e) the alias in the table's backtick form.
  High.
- **Q7, the instances** — your header for FS-111's instances; the new G67 section where you say; FS-111's G72 instance opens
  "Twenty-first, FS-111:", the form its siblings use. High.
- **Q8, the claim-list headings** — as you propose. High.
- **Q9** — apply F1's substitution to the two texts F1 missed: in `plans/STUB-global-step.md`'s "At FS-114's close" paragraph, "is the
  whole NO" → "suffices for the whole NO"; in the atlas node CVEXISTS, "So the unit-arc NO is one local statement about one such vertex"
  → "So one local statement about one such vertex suffices for the unit-arc NO". Re-quote LOCALF from the corrected row 137. The
  atlas README's step 6 (the DESIGN.md stage record) is not in the manifest: skip it, and list it in your report as owed. High.
- **The "49 lines" heading in FS-114's drafts** (46 in the file): noted as FS114-C's slip; file the 46.
