# Brief FS129-F1 — the front page: file FS-129's record, verbatim, in one commit on a branch

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS129-F1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; this job makes you Keryx's pen for the front page, verbatim, from named drafts
  role: the front-page filing of FS-129, the cross-application audit: the lanes' drafts filed into the files Keryx alone writes, verbatim, on a branch, with the filing's gates
  launch: now; every FS-129 job has reported and the coordinator has reviewed each
  mission: § Why this job
  statements: none — a filing job; every text it files is a draft named by address in § The manifest, and nothing else is written but the ruled merges listed there
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in FS-129 is blind (Workflow 3.1), and no other job is running
  channel: message the coordinator ("main") by SendMessage with any question mid-flight — and before writing any word the manifest does not give you; the report goes to `data/fs129/reports/FS129-F1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs129/f1/README.md`
  touches: `data/fs129/f1/`, `data/fs129/reports/FS129-F1.md`, and, in the worktree `/home/kooshi/source/lean-dir-fs129-close` on branch `fs129-filing` only, the targets of § The manifest: `LEDGER.md`, `CLAUDE.md`, `.claude/skills/grokkings/SKILL.md`, `plans/GROKKING-INSTANCES.md`, `BIBLIOGRAPHY.md`, `plans/FRONTIER-STUBS.md`, `plans/STUB-*.md` (titles and banners as listed), `plans/FS129-derivation.md` (two dated notes), `tools/viz_proof_atlas_facts.py`, `visualizations/proof-atlas/`, `data/viz/proof-atlas/`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. FS-129, the cross-application audit, has its record: a derivation file of 44 entries written by its record job, and drafts of every
change to the front page — the ledger rows, the Frontier lines, grokking instances, a proposed grokking, the atlas — from the record job's part 2
(FS129-Z2), and the re-ranked frontier from Poros (FS129-P1). The front page has one writer, Keryx, who files the lanes' drafts verbatim and
authors nothing; this filing is large, so you are the pen, under the same rule. When it lands, FS-129 is Derived. Your worked example is the last
filing of this kind: its brief `data/workflow3/briefs/X2-front-page.md` and its record `plans/WORKFLOW3-X2-front-page.md`.

## Why this job

Keryx's workflow (`.claude/output-styles/keryx.md` § The filing): "Every draft is written by a lane, and you file it verbatim, so that you
coordinate and do not author." and "When the filing is large, the Clerk is your pen, verbatim, on its own branch in its own worktree, and its
stage commits are merged as one commit (`--no-ff`)." The coordinator has reviewed every draft's source job (`plans/FS129-close-inventory.md`
items 141, 159) and ruled on them (items 142, 156, 160–165).

## Where you work

Create a worktree from `main` and work only there, committing each stage on its branch and pushing the branch:
`git -C /home/kooshi/source/lean-dir worktree add /home/kooshi/source/lean-dir-fs129-close -b fs129-filing main`. The main tree stays untouched; at
the end Keryx merges your branch into `main` as one commit. If the worktree already exists, you are resuming: read your record there.

## The manifest

The sources are the record job's drafts, `plans/FS129-Z2-record.md` § Drafts for the front page (each unit names its slot: the file, the section and
the exact words it replaces or follows); Poros's re-rank, `plans/POROS-2026-10-03-fs129-rerank.md` § Draft re-rank, with its whole table
`data/fs129/p1/frontier-table-draft.md`; and the day's search record `plans/SEARCH-2026-10-03.md` §§ 2.3–2.4.

1. **`LEDGER.md` § A**: Z2's rows **149–154**, after row 148; then Z2's addition to row 121's "Where" cell. No § B lines (Workflow 3.1).
2. **`CLAUDE.md`**: Z2's unit 1 (the "Last updated" line), unit 2 (the open-milestones line), unit 3 (item 31 of "Where the problem stands", in full),
   and the theory paragraph's one sentence; P1's top-three table ("The top three, as `CLAUDE.md` § Paths forward should carry them") in place of the
   three ranked rows of § Paths forward's table; and the ruled merges below.
3. **`.claude/skills/grokkings/SKILL.md`**: Z2's proposed G92, after G91, in G67's form as drafted.
4. **`plans/GROKKING-INSTANCES.md`**: Z2's slots 1–3 (instances under G49, G83, G87).
5. **`BIBLIOGRAPHY.md`**: Z2's one `[Falconer1981]` cell.
6. **`plans/FRONTIER-STUBS.md`**: P1's whole table (`data/fs129/p1/frontier-table-draft.md`) in place of § Ranked stubs' table; P1's open-milestones
   paragraph in place of the paragraph it names; P1's FS-117 row cell if it is not already in the table draft.
7. **Stubs**: P1's banner lines, each under the title of the stub it names, in the form of the banners already in those files; and the re-aimed
   names (ruled merge below) in the title lines of `plans/STUB-qfree-ring.md`, `plans/STUB-top-colour.md` and `plans/STUB-pinch-at-junction.md`.
   FS-123's banner is already filed (item 147): do not file it again.
8. **`plans/FS129-derivation.md`**: two dated notes (item 153), each directly under the entry it concerns, quoting the search record and the queue:
   under FS129-OA1-FALC-11, that queue row 1 ("A yes empties FALC-11's exception (t ≡ a)", `plans/SEARCH-QUEUE.md` row 1) was answered yes by
   SEARCH-1003-G11-DG [cert] (`plans/SEARCH-2026-10-03.md` § 2.3); under FS129-MA2-FALC-HOSTS, SEARCH-1003-U4-GAP, -U8-NOGAP and -U16-NOGAP with the
   consequence the search record § 2.4 states. Quote; do not paraphrase. Then re-run that file's derive gate.
9. **The Proof Atlas**: Z2's facts (nodes QFREE, QPRUNE, TOP5) into `tools/viz_proof_atlas_facts.py` at the slot Z2 names; the facts writer's meta to
   built="2026-10-03", job="FS129-F1", as_of="FS-129's record"; then `visualizations/proof-atlas/README.md` § Updating at a close, steps 1–6, and its
   § Build, check, publish commands. Keryx republishes the page.

**The merges Keryx has ruled, the only words you may add:**
- In `CLAUDE.md` Z2's unit 2, the words "then the top of FS129-P1's ranking." read "then the top of the ranking, FS-124, the (Q) ring (its
  question posed in `plans/STUB-q-ring.md`)." (item 159).
- In `CLAUDE.md` § The aim's programme paragraph (the paragraph beginning "**The program**"), three re-aimed names (item 165): "FS-123,
  the (Q)-free ring" (it breaks across a line there) reads "FS-123, the Siamese class"; "FS-128, the six-colour rungs" reads "FS-128, the top
  colour, at five and six"; "FS-120, the pinch at a junction" reads "FS-120, the pinch at a junction, and the cover route at five".
- In `CLAUDE.md` § The novel-results ledger, "Rows 1–148" reads "Rows 1–154".
- In the three stubs' title lines, the name between "— " and ":" becomes: FS-123 "the Siamese class"; FS-128 "the top colour, at five and six";
  FS-120 "the pinch at a junction, and the cover route at five". The rest of each title line stays.
- In `.claude/skills/grokkings/SKILL.md`'s front matter, "entries G1 to G91" reads "entries G1 to G92"; in `CLAUDE.md`, any "G1–G91" that
  names the range reads "G1–G92".

Anything else that seems to need a word of yours, a draft that does not fit its target, or two drafts that disagree: stop and ask "main".

## Done means

- Every manifest item filed on the branch, each listed in your record with its source address and its target, and every ruled merge listed where
  it was used.
- **The gates, each run in the worktree and read by its exit status** (standing rule 9), outputs saved under `data/fs129/f1/`:
  - `python3 tools/bib_audit.py` exit 0;
  - `python3 tools/claude_md_fact_audit.py --base f411553f` (the last commit that changed `CLAUDE.md`) and `--dupes`: both clean, or every flag
    explained;
  - `wc -c CLAUDE.md` under 80,000 and `wc -c .claude/skills/grokkings/SKILL.md` under 200,000;
  - `python3 data/rerank-2026-09-27/rk_mirror_check.py`, `python3 tools/check_architecture.py`, `python3 scripts/identities.py check`;
  - `python3 .claude/skills/ephodos/scripts/derive_gate.py all plans/FS129-derivation.md`;
  - the atlas checker, its self-test, the palette review, and the build.
  The census, `tools/fs71_ledger_b_check.py --strict`, is not run: § B takes no lines from Workflow 3.1 on (the handoff, § 3).
- The report, in the standing rules' form, naming the branch's last commit.

## What is yours to decide

The order of the stages, how to apply each draft exactly (a script is better than hand edits), and the atlas layout. If a draft is wrong — a
quotation that does not match its source, a row that contradicts its derivation entry, a number that does not re-read — say so rather than file
it: that is a finding, not a refusal.

## Stages (save each in your record, and commit it on the branch; standing rule 2)

1. The readback; the worktree; the manifest turned into a table in your record (target, unit, source address, merge).
2. `LEDGER.md` and `CLAUDE.md` (items 1–2), with the sizes and the fact audit.
3. Items 3–8, with the bibliography audit, the mirror check and the derive gate.
4. Item 9, the atlas, with its checker and build.
5. Every gate, and the report.

You start no agent of your own (`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and the coordinator can review only work it knows
exists). Thank you.

## Amendment, 2026-10-03 — the coordinator's rulings on your CHECKs (the only further words you may add)

Thank you: the stops were the right ones. `touches:` now also includes `tools/claude_md_fact_audit.py`, its ALLOW table only. Standing rules
unchanged — start no agent of your own (rule 1's reason: staffing is Kooshi's, and the coordinator reviews only work it knows exists).

**R1 — the fact audit's 11 tokens.** Every token lost from `plans/FRONTIER-STUBS.md` still lives in a stub file (the coordinator's grep found each
in at least one `plans/STUB-*.md`): FS129-P1 re-drafted the summary rows and the facts stay in the stubs, which the audit does not join. Add one
ALLOW entry per token, its reason exactly "FS129-P1 re-drafted the ranked row; the fact stays in `<the stub file that holds it>`", naming the file
your own grep finds; for `131–141`, the reason "item 31's row range now reads 131–154 (FS-129's rows 149–154)". A token you find in no stub file is
not allowed: stop and report it. Re-run the audit and `--dupes`.

**R2 — the atlas.** Re-point each failing quote to the current words of the same fact at its current address, verbatim, and list each change in
your record: R134's second quote to `plans/FRONTIER-STUBS.md` § Open milestones, "with BASE-V beside them (row 134's base re-derived but for Lemma 4
at cusps)"; FS124's grade words to the line of `plans/STUB-q-ring.md` that now states its standing; the "publish" note to `CLAUDE.md`'s current
sentence "Nothing is published before it is formalized in Lean, in full." in the section that holds it; FS104's verbal registration to the bearing
words of FS-104's row in `CLAUDE.md` § Paths forward as filed — or, if that row gives no verbal registration, remove the registration from the node
and say so (the atlas takes a stub's registration only for that event). The FS123 node's label and plain text: "the (Q)-free ring" reads "the
Siamese class". Then the checker, its self-test, the palette review, the build, and the DESIGN.md stage section (README step 6).

**R3 — `CLAUDE.md` § Paths forward**: the row "4–73 | 70 more open stubs" reads "4–74 | 71 more open stubs" (FS-130 entered).

**R4 — `plans/FRONTIER-STUBS.md` § Open milestones, its first paragraph**: "**FS-129, the cross-application audit, is Opened**
(`plans/FS129-cross-application-audit.md`; a special case, unranked)." reads "**FS-129, the cross-application audit, is Derived**
(`plans/FS129-derivation.md`, 44 entries; rows 149–154; a special case, unranked); it is Closed when its compositions pass the Lean gate, in the
Lean backlog's session."; and in "**Next, in Kooshi's order** (2026-10-03): **FS-129, the cross-application audit**
(`plans/STUB-cross-application-audit.md`; a special case, not ranked); then **the Lean backlog**, in a session of its own (the hand results of the
milestones closed before Workflow 3.1);" the words from "**FS-129, the cross-application audit**" through "not ranked); then " are removed, and
"(the hand results of the milestones closed before Workflow 3.1)" reads "(the hand results of the milestones closed before Workflow 3.1, from
`plans/LEAN-BACKLOG.md`)".

**R5 — the second dated note** (under FS129-MA2-FALC-HOSTS): add, as with the first, the queue's own statement of what row 5 decides, verbatim from
`plans/SEARCH-QUEUE.md` row 5 (its "what it would decide" cell), before the result bullets you quoted.

**R6 — your placement choices** (each dated note after its entry's whole block; the Falconer addition at the cell's end; G92 directly after G91's
entry; each re-rank banner directly under its title, above any existing banner): accepted as you made them.

**R7 — the brief's two quotations of `.claude/output-styles/keryx.md`**: the coordinator checked both, verbatim; no re-read needed.

Then every gate again, and the report as before, naming the branch's last commit.
