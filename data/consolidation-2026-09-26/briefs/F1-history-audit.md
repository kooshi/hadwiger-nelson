*Brief for job **F1**: audit `CLAUDE.md`'s git history for what earlier compression passes removed. Opus 5.5, 2026-09-26. Written by the
product owner. Launch after E2 has handed back (E1 created `plans/GROKKING-INSTANCES.md`, the home for moved incidentals).*

Hello. You are Coxeter, an archivist, in `/home/kooshi/source/lean-dir`. Read from disk `CLAUDE.md` (its header: the budget's history, current
state only, one home per fact, `[PROTECTED]`), `WORKFLOW.md`, `DEBRUIJN.md`, `data/consolidation-2026-09-26/briefs/STANDING-RULES.md` (part of
this brief), E1's brief and report and E2's report (`data/consolidation-2026-09-26/briefs/E1-extract-incidentals.md`, `reports/E1.md`,
`reports/E2.md`) — their definitions of intrinsic and incidental are your standard.

## Kooshi's words (2026-09-26, verbatim)

> "When that's done, have one audit the git history to catch instances that were previously compressed out. It's been a long struggle to
> maintain the balance."

## The question

Across `git log -p -- CLAUDE.md` (and the `LEDGER.md` extraction of 2026-09-22), which removals were **compression** — text cut to fit a byte
budget — rather than **current-state rewrites** (a superseded claim replaced by its correction, which the header requires and git keeps)? For each
compression removal: was the removed text **intrinsic** (a rule's statement, its reasoning, a condition, a *Do* line, a killing test, a demotion
record, an entry's only example) or **incidental** (a further instance, an incident story)? Kooshi's own history of this: a rule's reasoning was
trimmed to fit and "its loss cost hours" (2026-09-15, the reason `[PROTECTED]` exists).

## Where to look first

The passes the header and the records name: the 2026-09-15 trim; the budget raises of 2026-09-17, 09-21, 09-25; the no-loss passes (the
2026-09-21 pass that measured a floor near 228k; J05 on 2026-09-25, `data/crunch-2026-09-25/j05-record.md`); the `fd658af` narrative cut
(2026-09-10); the `LEDGER.md` extraction (2026-09-22); and any commit whose subject says compress, trim, shorten, tighten, budget or no-loss.
Use `git log --format='%h %ad %s' --date=iso -- CLAUDE.md` to list them, then read the diffs.

## What to do with what you find

- **Intrinsic, lost:** restore it, verbatim from the diff, into `CLAUDE.md` where it belongs today (rewritten only where today's current state
  requires, with the old words quoted in your record). If the budget cannot take it, put it in `plans/GROKKING-INSTANCES.md` with a pointer from
  its entry and list it as "intrinsic, parked for lack of room" — Kooshi decides.
- **Incidental, lost:** restore it verbatim into `plans/GROKKING-INSTANCES.md` under its entry or section, with the commit it was cut in.
- **Current-state rewrites and incidentals already in plans or records:** leave them; list the count.
- **When unsure whether a cut was compression or correction,** read the commit message and the milestone plan it names; if still unsure, park it
  in `plans/GROKKING-INSTANCES.md` and say so.

## Stages (each saved and committed; every gate green at every commit)

1. The list of compression commits, with bytes removed and a one-line reason each. Save.
2. The audit, commit by commit: a table in your record (commit, removed passage's first words, compression or correction, intrinsic or
   incidental, action). Save as you go — this is the long stage; split it across saves.
3. The restorations, in batches, gates green. Save.
4. The report: counts by kind, `CLAUDE.md`'s bytes, anything parked for Kooshi.

## Gates (exit statuses read directly)

`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS; `--dupes` not above its launch count; `python3 tools/fs71_ledger_b_check.py
--strict` PASS; `python3 tools/bib_audit.py` PASS; `python3 tools/check_architecture.py` PASS. `CLAUDE.md` under 300,000 bytes (park rather
than cross it).

## Rules

- **Touch only** `CLAUDE.md` (restorations), `plans/GROKKING-INSTANCES.md`, and your record `data/consolidation-2026-09-26/F1-record.md`.
  Never rewrite history (no rebase, no amend, no force-push); you read git, you do not change it.
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Budget:** about 350k by the harness's count; hand back by 450k — stop at a saved stage if the history outgrows it and say which commits are
  left.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/F1.md`.

Thank you.
