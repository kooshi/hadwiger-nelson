# Brief X2 — the front page: file the closes of FS-116 and FS-121, verbatim, in one closing commit

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: X2
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; this job makes you Keryx's pen for the front page, verbatim, from named drafts
  role: the front-page lane: file the lanes' drafts into the files Keryx alone writes, verbatim, and run the close's gates
  launch: now; Poros's re-rank job, R2, has handed back and the coordinator has reviewed it
  mission: § Why this job
  statements: none — a filing job; every text it files is a draft named by address in § The manifest, and nothing else is written
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running; both milestones are closed
  channel: message the coordinator ("main") by SendMessage with any question mid-flight — and before writing any word the manifest does not give you; the report goes to `data/workflow3/reports/X2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-X2-front-page.md`
  touches: `plans/WORKFLOW3-X2-front-page.md`, `data/workflow3/x2/`, `data/workflow3/reports/X2.md`, and, in the worktree `/home/kooshi/source/lean-dir-close` on branch `close-2026-10-03` only, the targets in § The manifest
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. Two milestones closed today, FS-116 (the local exclusion) and FS-121 (the map step). Each close wrote its derivation file and stubs directly
and drafted every change to the front page; Poros drafted the re-rank. The front page — `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`, the grokkings file,
`plans/GROKKING-INSTANCES.md`, `plans/FRONTIER-STUBS.md`, the frozen claim lists, the close inventories and `plans/STANDING-RULES.md` — has one writer,
Keryx, who files the lanes' drafts verbatim and authors nothing. The filing is large, so Keryx's workflow (`.claude/output-styles/keryx.md` § A
milestone, end to end, step 7) hands it to you under the same rule. The last filing of this kind, on 2026-09-28, is your worked example: its brief
`data/workflow3/briefs/X1-front-page.md` (with its four amendments, which show the questions such a filing raises) and its record
`plans/WORKFLOW3-X1-front-page.md`.

## Why this job

Kooshi's instruction for this run:

> Please revive your agents with messages, and continue with the milestone.
> — source: plans/FS116-close-inventory.md row 74

The next milestone opens from what you file, so the front page must say exactly what the closes found, at their grades, and nothing they did not.

## Where you work

Create a worktree from `main` and work only there, committing each stage on its branch and pushing the branch:
`git -C /home/kooshi/source/lean-dir worktree add /home/kooshi/source/lean-dir-close -b close-2026-10-03 main`. The main tree stays untouched while you
work; at the end Keryx folds your branch into `main` as the one closing commit. If the worktree already exists, you are resuming: read your record there.

## The manifest

The sources are FS-121's close record `plans/FS121-Z1-close.md` (its `## Drafts for the front page`, D1–D11), FS-116's close record
`plans/FS116-Z2-close.md` (its `## Drafts for the front page`, D1–D10), the files they name, and Poros's record `plans/POROS-2026-10-03-close-reread.md`
(its `## Draft re-rank`, items 1–6, and `## Draft for CLAUDE.md § Paths forward`), with its assembler's output `data/workflow3/r2/ranked-table.md`.
The coordinator's rulings on R2's drafts are `plans/FS116-close-inventory.md` items 152–153: file them as written there.

1. **`LEDGER.md` § A**: FS-121's rows (its D1), numbered **142, 143, 144** in place of `‹R121-a›`, `‹R121-b›`, `‹R121-c›`; then FS-116's rows (its D1),
   numbered **145, 146, 147, 148** in place of `‹R116-a›` … `‹R116-d›`; then each close's corrections to existing rows (FS-116's D1: row 137's prior-art
   clause; FS-121's D1 if any).
2. **`LEDGER.md` § B**: FS-121's 65 lines (`data/fs121/fs121-z1/ledger-b-draft.md`), then FS-116's 91 lines (`data/fs116/fs116-z2/ledger-b-draft.md`),
   placeholders numbered as in item 1; then FS-116's FS-114 lines (its D1: FS114-N7-HUB's new line and FS114-N7-3T's replacement line).
3. **`CLAUDE.md`**:
   - FS-116's D2: the four shared units **in full** (the "Last updated" line, the open-milestones line, § The aim's programme line, "Where the problem
     stands" item 31), with FS-121's clauses already placed; then FS-116's corrections in the same D2;
   - FS-121's D2 corrections that FS-116's D2 does not already carry (its theory-paragraph clause);
   - Poros's § Paths forward table, and **Poros's "Next:" clause**, in place of the "Next:" clause of FS-116's drafted open-milestones unit;
   - "Rows 1–141" becomes "Rows 1–148".
4. **The grokkings file**, `.claude/skills/grokkings/SKILL.md`: FS-121's D4 (G85's last sentence rewritten; G88, G89, G90) and FS-116's D3 (G91), each
   new entry in numeric order.
5. **`plans/GROKKING-INSTANCES.md`**: FS-121's instances (its D4) and FS-116's (its D3), each under its rule's section, in the file's form.
6. **`BIBLIOGRAPHY.md`**: FS-121's D5 and FS-116's D4.
7. **The frozen claim lists**: FS-121's D6 as a dated section at the end of `data/fs121/claims.md`; FS-116's D5 as a dated section at the end of
   `data/fs116/claims.md`. No statement above is edited.
8. **Stubs**: the closed banners on `plans/STUB-map-step.md` (FS-121's D7) and `plans/STUB-local-exclusion.md` (FS-116's D6), each under its title line;
   R2's banner on `plans/STUB-stuck-ray.md` and its bearing lines for FS-123, FS-125 and FS-126 (its § Draft re-rank items 5–6); and R2's four cards
   (`plans/POROS-2026-10-03-close-reread.md` § 2.5, each from its `question:` line to the line before the next card or heading), verbatim, at the end of
   `plans/STUB-qfree-ring.md` (card 1, does-a-fragment-bend-keep-the-class), `plans/STUB-q-ring.md` (card 2, where-else-the-identity, with its ranking
   paragraph), `plans/STUB-curved-pencils.md` (card 3) and `plans/STUB-top-colour.md` (card 4), each under the heading
   "## Carried card (Poros, R2, 2026-10-03; verbatim from `plans/POROS-2026-10-03-close-reread.md` § 2.5)".
9. **`plans/FS111-derivation.md`**: FS-121's D3 erratum, a dated paragraph under the entry FS111-W-NOREP, the original text standing above it.
10. **`plans/FRONTIER-STUBS.md`**: Poros's draft re-rank with every block of its § Draft re-rank — its dated paragraph, the open-milestones text (with
    FS-129, the cross-application audit, placed where Kooshi fixed it: after the workflow refinement, unranked), the closed-list lines for FS-116 and
    FS-121, and its banners.
11. **The close inventories**: apply each close's proposed ticks (`data/fs121/fs121-z1/ticks.md`; `data/fs116/fs116-z1/ticks.md`, with part 2's
    record for the items it finished), and tick "done" every later item the coordinator logged, each with where.
12. **The Proof Atlas**: FS-121's D9 and FS-116's D8 into `tools/viz_proof_atlas_facts.py`; place the new nodes by the layout lint
    (`visualizations/proof-atlas/README.md`); update the facts writer's meta to built="2026-10-03", job="X2", as_of="FS-116's and FS-121's closes"; run the
    checker and the build as that README says. Keryx republishes the page.
13. **The search ban is not touched by this filing**: `plans/STANDING-RULES.md` rule 5 and `CLAUDE.md` § Toolchain's ban paragraph stay as they
    are (Kooshi asked for a count before deciding, FS-116 item O7); only the closes' drafted Frontier lines, which already drop the two stale
    "until 2026-10-01" sentences, are filed as drafted.

**The merges Keryx has ruled, the only words you may add:**
- Every `‹R121-a›`, `‹R121-b›`, `‹R121-c›` becomes 142, 143, 144, and every `‹R116-a›` … `‹R116-d›` becomes 145 … 148, in every draft, Poros's included;
  a range `‹R121-a›–‹R121-c›` becomes 142–144 and `‹R116-a›–‹R116-d›` 145–148.
- FS-121's drafted clause "(the cover route parked behind FS-116)", wherever it is filed, reads "(the cover route parked behind FS-125's NO-SAT)"
  (item 152).
- The cards' heading above, the only text added to the four stubs beyond the cards themselves.
- The two pipes inside cells of `plans/FRONTIER-STUBS.md` (ll. 108, 134) escaped, as R2's table does.

Anything else that seems to need a word of yours, a draft that does not fit its target, or two drafts that disagree: stop and ask "main".

## Done means

- Every manifest item filed on the branch, each listed in your record with its source address and its target, and every ruled merge listed where it
  was used.
- **The gates, each run in the worktree and read by its exit status** (standing rule 9), their outputs saved under `data/workflow3/x2/`:
  - `python3 tools/fs71_ledger_b_check.py --strict` exit 0;
  - `python3 tools/bib_audit.py` exit 0;
  - `python3 tools/claude_md_fact_audit.py --base de616ed9` (the last close's filing) and `--dupes`: both clean, or every flag explained;
  - `wc -c CLAUDE.md` under 80,000 and `wc -c .claude/skills/grokkings/SKILL.md` under 200,000;
  - `python3 data/rerank-2026-09-27/rk_mirror_check.py`, `python3 tools/check_architecture.py`, `python3 scripts/identities.py check`;
  - `python3 .claude/skills/ephodos/scripts/derive_gate.py all` on `plans/FS121-derivation.md`, `plans/FS116-derivation.md`,
    `plans/FS114-derivation.md` and `plans/FS111-derivation.md`;
  - the atlas checker, its self-test, and the build.
- The report, in the standing rules' form, naming the branch's last commit. Your last words are exactly "X2 idle; report sent to the coordinator", and
  the hand-back carries nothing else.

## What is yours to decide

The order of the stages, how to apply each draft exactly (a script is better than hand edits), and the atlas layout. If a draft is wrong — a quotation
that does not match its source, a row that contradicts its derivation entry, a number that does not re-read — say so rather than file it: that is a
finding, not a refusal.

## Stages (save each in your record, and commit it on the branch; standing rule 2)

1. The readback; the worktree; the manifest turned into a table in your record (target, unit, source address, merge).
2. `LEDGER.md` (items 1–2), with the census check.
3. `CLAUDE.md` (item 3), with the size and the fact audit.
4. Items 4–10, with the bibliography audit and the mirror check.
5. Items 11–13, with the atlas checker and build.
6. Every gate, and the report.

You start no agent of your own (`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
