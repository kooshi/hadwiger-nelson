*Brief for job **FS112-X**: the front-page pass for FS-112's close. Opus 5.5, 2026-09-27. Written by the product owner. Its template is
FS110-X's brief (`data/fs110/briefs/X110-front-page.md`); the changes below override it. **Sized for about 200k tokens by the harness's count, as
guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page editor**, in `/home/kooshi/source/lean-dir`. Re-read from disk:
- `CLAUDE.md`'s header rules (current state only; one home per fact; the byte budget);
- WORKFLOW step 9's "file new instances out of `CLAUDE.md`".

**`data/fs112/briefs/STANDING-RULES.md` is part of this brief.** **If your record `data/fs112/fs112-x/record.md` already exists, you are resuming;**
continue at its first stage not marked SAVED.

## What you apply

1. **FS112-C's drafts in `plans/FS112-unit-arc-half.md` §R-close, exactly:**
   - the `LEDGER.md` changes (rows 135+, any correction to row 134 or its § B line) with their § B lines;
   - the `CLAUDE.md` lines. Where C drafted alternatives, apply the version the owner's latest ruling in `plans/FS112-close-inventory.md` names; if there
     is no ruling, apply C's recommendation and say so;
   - G83 (D7): the owner ruled to apply it (inventory item 65);
   - the `BIBLIOGRAPHY.md` and `CLOSED-QUESTIONS.md` rows;
   - the `plans/FRONTIER-STUBS.md` rows (FS-112 to the closed list; FS-114 and FS-115 at ranks 1–2; FS-111 re-aimed);
   - the `plans/GROKKING-INSTANCES.md` instances;
   - the `plans/PROTOCOL-competitor-and-advisor.md` amendment and its §3 run record, if C drafted them.

   Where a draft is missing, apply nothing in its place, and list it as left.
1a. **FS112-C2's stage-1b updates** are part of the drafts (`data/fs112/reports/FS112-C2.md`; §R-close 3.0–3.6, 4.1, 4.5–4.7): apply the versions in
   §R-close as they stand now, and C2's § Building instance draft.
1b. **The ranking of FS-114, FS-115 and FS-111 waits for the owner's message.** Kooshi deferred tonight's choice to a Poros advisor (NIGHT-A; inventory
   item 70), whose ranking may differ from C's draft. Apply everything else first; do the ranking and its mirror in your last stage, after the owner's
   message naming NIGHT-A's ruling. If you reach that stage with no message, report and wait.
2. **Mirror the ranking change** into `CLAUDE.md`'s paths-forward table from `plans/FRONTIER-STUBS.md`, and run
   `python3 data/rerank-2026-09-27/rk_mirror_check.py` (PASS).
3. **The budget.** `CLAUDE.md` is at 296,992 bytes against its 300,000 limit. Keep it **under 300,000**, and report the count before and after. To make
   room, in this order:
   1. move second and later instances to `plans/GROKKING-INSTANCES.md` (step 9);
   2. make lines point to a ledger row instead of retelling it (one home per fact);
   3. compress incidentals.

   Never cut an intrinsic, and never touch a `[PROTECTED …]` paragraph. If the file is still over after all three, stop, commit nothing that crosses, and
   report under HELD FOR THE OWNER.

## Gates

Read every exit status directly, never through a pipe.
- `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`: PASS, with every reviewed ALLOW line stated with its reason.
- `python3 tools/claude_md_fact_audit.py --dupes`: not above 10.
- `python3 tools/fs71_ledger_b_check.py --strict`: PASS.
- `python3 tools/bib_audit.py`: PASS.
- `python3 tools/check_architecture.py`: PASS.
- `python3 data/rerank-2026-09-27/rk_mirror_check.py`: PASS.

Never commit a stage whose gate failed on your own edits.

## Rules

- **Touch only** these files:
  - `CLAUDE.md`, `LEDGER.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`;
  - `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`;
  - `plans/PROTOCOL-competitor-and-advisor.md` (the amendment and the §3 run record);
  - `tools/claude_md_fact_audit.py` (reviewed table lines only);
  - `plans/FS110-derivation.md`: only the two corrections in §R-close 4.8 (FS110-NB-4's general form at l. 42, read as FS112-NB4P; FS110-CE5's note);
  - your record, `data/fs112/fs112-x/`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- **Commits:** by explicit path, with subjects "FS112-X: stage n". Never amend. Push after each commit. On a race, `git pull --rebase` refuses while other
  sessions' files are uncommitted in the shared tree: run `git fetch origin` and `git merge --ff-only origin/main`, then push. Never force-push.
- **Contact:** only `"main"`.
- **Report** (standing rule 9) to `data/fs112/reports/FS112-X.md`, committed, and by SendMessage to "main". Include every gate's result and `CLAUDE.md`'s
  byte count. Your final turn's text: "FS112-X idle; report sent to the owner by SendMessage".

Thank you.
