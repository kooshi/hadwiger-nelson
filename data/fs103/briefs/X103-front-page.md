*Brief for job **FS103-X**: the front-page pass for FS-103's close. Opus 5.5, 2026-09-26. Written by the product owner. Its template is X10F's
brief (`data/crunch-2026-09-26-x2x3/briefs/X10F-front-page.md`); the changes below override it. **Sized for about 200k harness tokens; hand
back by 280k.***

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page editor**, in `/home/kooshi/source/lean-dir`. Re-read `CLAUDE.md`'s header rules from
disk (current state only; one home per fact; **the 300,000-byte budget**; WORKFLOW step 9's "file new instances out of `CLAUDE.md`").
**`data/fs103/briefs/STANDING-RULES.md` is part of this brief.**

**If your record `data/fs103/fs103-x/record.md` already exists, you are resuming;** continue at its first stage not SAVED.

## What you apply

1. FS103-C's drafts in `plans/FS103-collapse-cp-plane.md` §R-close, exactly:
   - the `LEDGER.md` rows from 128 with their § B lines;
   - the `CLAUDE.md` lines;
   - the `BIBLIOGRAPHY.md` and `CLOSED-QUESTIONS.md` rows;
   - the `plans/FRONTIER-STUBS.md` rows;
   - the `plans/GROKKING-INSTANCES.md` instances.

   Where a draft is missing, apply nothing in its place, and list it as left.
2. Mirror the ranking change in `CLAUDE.md`'s paths-forward table, from `plans/FRONTIER-STUBS.md`.
3. **The budget:** `CLAUDE.md` stays **under 300,000 bytes**; report the count before and after. If the drafts would cross it:
   - first move instances to `plans/GROKKING-INSTANCES.md`, per step 9;
   - then shorten the new rows (they point to the ledger);
   - never cut an intrinsic.

   If it is still over, stop, commit nothing that crosses, and report under HELD FOR THE OWNER. Kooshi decides the cache design at that
   point.

## Gates (read every exit status directly, never through a pipe)

- `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`: PASS, with any reviewed ALLOW line stated with its reason. `--dupes`:
  not above 10.
- `python3 tools/fs71_ledger_b_check.py --strict`, `python3 tools/bib_audit.py`, `python3 tools/check_architecture.py`: PASS.

Never commit a stage whose gate failed on your own edits.

## Rules

- **Touch only** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `plans/GROKKING-INSTANCES.md`,
  `tools/claude_md_fact_audit.py` (reviewed table lines only), and your record.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **Commits:** by explicit path, subjects "FS103-X: stage n". Never amend; push after each (on a race, `git pull --rebase origin main`, then
  push); never force-push.
- **Report** (standing rule 9) to `data/fs103/reports/FS103-X.md`, committed, and by SendMessage to "main", with every gate's result and
  `CLAUDE.md`'s byte count. Final turn text: "FS103-X idle; report sent to the owner by SendMessage".

Thank you.
