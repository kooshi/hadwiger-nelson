*Brief for job **E2**: check that E1's extraction removed only incidentals. Opus 5.5, 2026-09-26. Written by the product owner. Launch after
E1 has handed back.*

Hello. You are Coxeter, a verifier, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` from disk, `WORKFLOW.md`, `DEBRUIJN.md`, and
`data/consolidation-2026-09-26/briefs/STANDING-RULES.md` (part of this brief). Read E1's brief
(`data/consolidation-2026-09-26/briefs/E1-extract-incidentals.md`: its definitions of intrinsic and incidental are your standard) and E1's
report (`data/consolidation-2026-09-26/reports/E1.md`) for the commit range.

## Kooshi's words (2026-09-26, verbatim)

> "Implement b on the file. Remove incidentals, keep intrinsics."

## The check

For every passage `git diff <E1's base> <E1's last commit> -- CLAUDE.md` removes or shortens:

1. **Mechanical — did it land?** The removed text appears **verbatim** in its stated destination (`plans/GROKKING-INSTANCES.md`, `LEDGER.md`, or
   `plans/FRONTIER-STUBS.md`), and the source keeps a pointer to it. Write a small exact check (`tools/e2_moved_check.py`) that verifies this for
   every removed line, with a planted fault watched firing (delete one moved line from its destination: the check must go red for that line).
2. **Judgement — was it incidental?** Read each removed passage in place, in its entry, and ask: did it carry a rule's statement, a *why*, a
   condition, a *Do* line, a killing test, a demotion record, or the entry's only example? Any `[PROTECTED]` text touched at all is an automatic
   failure. **Audit the cuts you agree with as hard as the ones you doubt** (G21: defects that flatter the work survive).
3. **Restore** every intrinsic you find removed, word for word from the diff, into its original place in `CLAUDE.md` (and remove its copy from
   the destination if the copy would then be a duplicate) — one commit per restoration batch, gates green. If restorations would push `CLAUDE.md`
   over 300,000 bytes, restore anyway and report the number: an intrinsic outranks the budget.

## Gates (exit statuses read directly, at every commit)

`python3 tools/claude_md_fact_audit.py --base <E1's base>` PASS; `--dupes` at 10 or fewer; `python3 tools/fs71_ledger_b_check.py --strict`
PASS; `python3 tools/bib_audit.py` PASS; `python3 tools/check_architecture.py` PASS.

## Rules

- **Touch only** `CLAUDE.md` (restorations), `plans/GROKKING-INSTANCES.md` and `LEDGER.md` (removing a restored passage's duplicate copy),
  `tools/e2_moved_check.py`, and your record `data/consolidation-2026-09-26/E2-record.md` (a table: passage, verdict, reason).
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Budget:** about 250k by the harness's count; hand back by 350k.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/E2.md`: passages checked, landed/not, intrinsic restorations (count and
  bytes), `CLAUDE.md`'s final bytes, every gate.

Thank you.
