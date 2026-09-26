*Brief for job **X10F**: the front-page pass for FS-100 stage 5 (the ×2×3 crunch). Opus 5.5. Written by the crunch planner. **Its template
is J55's brief** (`data/crunch-2026-09-25/briefs/J55-front-page-FS100.md`); read it and follow its gates. The changes below override it.
**Launch at 07:10, or when X09C reports.***

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page editor**, in `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context;
re-read its header rules from disk (current state only, one home per fact). **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is
part of this brief.**

**If your record `data/fs100/x10f-record.md` already exists, you are resuming;** continue at its first stage not SAVED.

## What you apply

1. X09C's drafts in `plans/FS100-three-field-lemma.md` §R-close (stage 5), drafts part: the `LEDGER.md` rows from 120 with their § B
   lines, the `CLAUDE.md` lines, the `BIBLIOGRAPHY.md` rows, and the `plans/FRONTIER-STUBS.md` rows (following the re-aimed stub files).
   Apply each exactly. Where a draft is missing, apply nothing in its place, and list it as left.
2. **§5 of `plans/CRUNCH-2026-09-26-x2x3-queue.md`**: add a column scoring each expectation once, from X09C's §R-close. Add a banner at the
   top of the queue plan, "CLOSED 2026-09-26 by X10F", and set every §4 status to its final value.
3. **The budget line.** `CLAUDE.md` has no byte budget during this crunch (Kooshi). **Compress nothing.** Report the file's byte count
   before and after. The header line recording the temporary suspension was written by the clerk's K0 job; leave it as it is. Whether the
   300,000 ceiling returns after the crunch is Kooshi's call, so list it under HELD FOR THE OWNER.

## Gates (read every exit status directly, never through a pipe)

- `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`: PASS, with any reviewed ALLOW line stated with its reason.
  `--dupes`: report the count.
- `tools/bib_audit.py`: PASS.
- `python3 tools/fs71_ledger_b_check.py --strict`: PASS.

Never commit a stage whose gate failed on your own edits. If the clock reaches 07:24 with a gate failing, commit nothing more, and report
the failure.

## Rules

- **Touch only** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the queue plan's §5, banner and §4 status cells,
  and your record.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **Commits:** by explicit path, with subjects "X10F: stage n". Never amend. Push after each commit (on a ref-lock race, `sleep 4` and
  retry). Never force-push.
- **Budget:** about 150k harness tokens.
- **Report** (standing rule 9): to `data/crunch-2026-09-26-x2x3/reports/X10F.md`, committed, and by SendMessage to "main", with every
  gate's result and `CLAUDE.md`'s byte count. Your final turn's text: "X10F idle; report sent to the owner by SendMessage".

Thank you.
