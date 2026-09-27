*Brief for job **FS106-X**: the front-page pass for FS-106's close. Opus 5.5, 2026-09-27. Written by the product owner. Its template is
FS105-X's brief (`data/fs105/briefs/X105-front-page.md`); the changes below override it. **Sized for about 200k tokens by the harness's count.
Your own count runs at 55–70 % of the harness's, so hand back when your own count reaches about 170k.***

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page editor**, in `/home/kooshi/source/lean-dir`. Re-read from disk:
- `CLAUDE.md`'s header rules (current state only; one home per fact; the byte budget);
- WORKFLOW step 9's "file new instances out of `CLAUDE.md`".

**`data/fs106/briefs/STANDING-RULES.md` is part of this brief.** **If your record `data/fs106/fs106-x/record.md` already exists, you are
resuming;** continue at its first stage not marked SAVED.

## What you apply

1. **FS106-C's drafts in `plans/FS106-regular-half.md` §R-close, exactly:**
   - the `LEDGER.md` changes (new rows, row 40's correction, any addendum) with their § B lines;
   - the `CLAUDE.md` lines, in the version the owner chose — see the owner's ruling in the close inventory (`plans/FS106-close-inventory.md`,
     the last "owner ruling" item on FS-107's name and link 5). If there is no ruling, apply C's recommended version and say so;
   - the `BIBLIOGRAPHY.md` and `CLOSED-QUESTIONS.md` rows;
   - the `plans/FRONTIER-STUBS.md` rows;
   - the `plans/GROKKING-INSTANCES.md` instances;
   - the `plans/PROTOCOL-competitor-and-advisor.md` §3 run record, if C drafted one.

   Where a draft is missing, apply nothing in its place, and list it as left.
2. **Mirror the ranking change** into `CLAUDE.md`'s paths-forward table, from `plans/FRONTIER-STUBS.md`.
3. **The budget returns.** Kooshi suspended the 300,000-byte limit only for the 2026-09-26 reframe (*"Ignore the 300kB limit while you
   reframe the file."*); the reframe is done. `CLAUDE.md` is at 304,245 bytes.
   - Bring it **under 300,000**, and report the count before and after.
   - Rewrite the header's parenthesis "(suspended for the 2026-09-26 reframe — …)" to current state: the limit applies, and it was suspended
     for the reframe and restored at FS-106's close.
   - To make room, in this order:
     1. move second and later instances to `plans/GROKKING-INSTANCES.md`, per step 9;
     2. make new and old lines point to a ledger row instead of retelling it (one home per fact);
     3. compress incidentals.
   - Never cut an intrinsic, and never touch a `[PROTECTED …]` paragraph (§ Counter-priors is one).
   - If the file is still over the limit, stop, commit nothing that crosses it, and report under HELD FOR THE OWNER. Kooshi decides the cache
     design at that point.

## Gates

Read every exit status directly, never through a pipe.
- `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`: PASS, with every reviewed ALLOW line stated with its reason.
- `python3 tools/claude_md_fact_audit.py --dupes`: not above 10.
- `python3 tools/fs71_ledger_b_check.py --strict`: PASS.
- `python3 tools/bib_audit.py`: PASS.
- `python3 tools/check_architecture.py`: PASS.

Never commit a stage whose gate failed on your own edits.

## Rules

- **Touch only** these files:
  - `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`;
  - `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`;
  - `plans/PROTOCOL-competitor-and-advisor.md` (its §3 run record only);
  - `tools/claude_md_fact_audit.py` (reviewed table lines only);
  - your record.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Commits:** by explicit path, with subjects "FS106-X: stage n". Never amend. Push after each commit; on a race, run
  `git pull --rebase origin main`, then push. Never force-push.
- **Report** (standing rule 9) to `data/fs106/reports/FS106-X.md`, committed, and by SendMessage to "main". Include every gate's result and
  `CLAUDE.md`'s byte count. Your final turn's text: "FS106-X idle; report sent to the owner by SendMessage".

Thank you.
