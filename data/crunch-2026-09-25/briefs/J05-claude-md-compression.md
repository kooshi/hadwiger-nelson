*Brief for job **J05**: a no-loss compression pass on `CLAUDE.md`, to bring it well under its 300,000-byte budget. Opus 5.5, 2026-09-26.
Written by the product owner at Kooshi's request, after the crunch: *"We should also probably start with the CLAUDE.md compression session,
back down to 300k."*.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the editor of this project's front page**, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`
in full, twice: once as its reader, and once as its editor. Its header rules are yours:
- current state only;
- one home per fact;
- the size budget;
- the `[PROTECTED]` tag.

Also read `WORKFLOW.md` and `DEBRUIJN.md`. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your record `data/crunch-2026-09-25/j05-record.md` already exists, you are resuming.** Check its last SAVED stage against `git log`
and continue at the first stage not SAVED.

## The job

`CLAUDE.md` stands at about 296,400 bytes against a budget of 300,000. The next two milestones' closes will add several thousand bytes.
**Free at least 15,000 bytes, without losing a fact.** That brings the file to about 281,000 or less. **Aim for 20,000.**

The history of this budget is the warning. Kooshi raised it on 2026-09-15 *"after a rule's reasoning was trimmed to fit and its loss cost
hours"*. A no-loss pass on 2026-09-21 measured the file's floor at about 228,000 bytes, so there is room — but only through **moving and
de-duplicating, never through trimming reasoning**.

## What counts as no loss

- **`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASSES after every batch.** Every number and name in the old file
  is still in `CLAUDE.md` or `LEDGER.md`.
  - An ALLOW line is admissible **only** for a token that is genuinely superseded history, and only with its reason. An ALLOW line exists
    to record that a token was superseded, never to let a real fact disappear.
  - List every ALLOW line you add in your record and your report. I review each one.
- **`--dupes`** must not rise above 13. Lower it where a fact is retold: each such fact keeps one home, and every other mention points to it.
- **Never touch:**
  - a `[PROTECTED — never compress …]` paragraph;
  - a grokking's status tag;
  - a *Do* line;
  - a killing test;
  - a demotion record (G67's form and the "never deleted" rule for dead grokkings).
- **Moving is allowed; deleting is not.** Text that belongs elsewhere goes to its home, and `CLAUDE.md` keeps a pointer. Candidate homes:
  - a ledger row's mechanism, to `LEDGER.md`;
  - a milestone's story, to its plan;
  - a stub's detail, to `plans/FRONTIER-STUBS.md` (already authoritative);
  - a run record, to `plans/PROTOCOL-competitor-and-advisor.md`.

  The moved text must land in the target file in the same commit, and the audit must see it there.
- **Current state only:** text that is superseded — a dated amendment, a correction trail, a stale count — comes out whether or not it
  saves bytes. The history stays in git.

## Where the bytes probably are (candidates, not orders — measure first)

- **The paths-forward table.** Its rows re-describe stubs that `plans/FRONTIER-STUBS.md` holds in full. The precedent is FS-86's close,
  which cut rows to their first clauses.
- **Instance lists inside `[method]` grokkings** (G21, G49, G50, G51). Each instance that a milestone's plan already records can shrink to a
  one-clause pointer. Keep the rule and its sharp examples.
- **Frontier items** that retell a ledger row's mechanism, which belongs in `LEDGER.md`.
- **Retold facts** that `--dupes` lists.

## Stages (save and commit after each: `git commit <paths>`, subject "J05: stage n"; push after each; never force-push)

1. **The survey** (~60k). Write the table into your record before editing anything. One row per candidate, with:
   - its section;
   - its bytes;
   - what moves or shrinks, and where it goes;
   - the saving;
   - the risk (does it touch reasoning?).

   Sum the table.
2. **Batches** (~180k), each about 3,000–6,000 bytes. For each batch:
   - apply it;
   - run the fact audit and `--dupes`;
   - check `tools/bib_audit.py` and `tools/fs71_ledger_b_check.py --strict` if `LEDGER.md` was touched;
   - quote the verdicts in your record;
   - commit.

   Read every exit status directly, never through a pipe, and **never commit a batch whose audit failed.**
3. **The close** (~30k). Record:
   - the final byte count;
   - the ALLOW lines added, with reasons;
   - the dupes count;
   - what moved where;
   - a five-line "how to find what moved" note, kept in your record.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved batch and tell me what is left.
- **Touch only:**
  - `CLAUDE.md`;
  - `LEDGER.md` (receiving moved mechanism text);
  - `plans/FRONTIER-STUBS.md`;
  - `plans/PROTOCOL-competitor-and-advisor.md`;
  - plan files receiving moved text (append only, in a section headed "Moved from CLAUDE.md, 2026-09-26");
  - the ALLOW table of `tools/claude_md_fact_audit.py`;
  - your record.
- **A Poros session is reading `CLAUDE.md` to choose the next milestones.** Your edits change nothing it needs, because moved text stays
  findable. Never contact it.
- **Commits by explicit path.** End commit messages with your harness's attribution lines. Push after each commit; never force-push.
- **Budget:** about 300k by the harness's count; hand back by 400k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J05.md`, committed, and by SendMessage
  `to: "main"`, with the byte count before and after and every gate's result. Keep your turn's final text content-free: "J05 idle; report
  sent to the owner by SendMessage".

Thank you.
