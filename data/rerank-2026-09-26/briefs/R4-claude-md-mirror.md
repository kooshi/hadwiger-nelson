*Brief for job **R4**: finish R3's stage 3 — mirror the applied ranking in `CLAUDE.md`. Opus 5.5, 2026-09-26. Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the front-page editor, in `/home/kooshi/source/lean-dir`. Read from disk `CLAUDE.md` (the disk copy),
`WORKFLOW.md` step 9, `DEBRUIJN.md`, and `data/consolidation-2026-09-26/briefs/STANDING-RULES.md` (part of this brief). Then read R3's brief
(`data/rerank-2026-09-26/briefs/R3-apply-rerank.md`), its report (`data/rerank-2026-09-26/reports/R3.md`) and **its record's "§Stage 3"** in
`plans/RERANK-2026-09-26.md`, which lists the steps. `plans/FRONTIER-STUBS.md` (re-ranked by R3, authoritative) is your source for every row.

## Kooshi's words (verbatim)

> "I agree and approve all suggestions. Set things up, then prepare for compaction, and we'll focus on that as the milestone."

## The job

1. **`CLAUDE.md` § Paths forward, ranked:** rewrite the table to the new order — ranks 1–29 as rows (short rows for the stubs new to the top:
   FS-103, 104, 105, 62, 49, 44, 69, 57, 65, 17, 42, 43, 39, as R3's §Stage 3 lists), and ranks 30 and below as the one pointer row. Each row's
   question and bearing in today's terms, taken from its `plans/FRONTIER-STUBS.md` row — never a result claimed there that its stub does not
   claim; FS-103's row states the collapse as a **candidate** to verify.
2. **"Open milestones"**: next is **FS-103, the collapse** (Kooshi chose it). **"Last updated"**: one clause for the re-rank.
3. **The fact audit:** add `EXTERNAL_HOMES` entries for the tokens of the rows that leave the table (R3 lists them: FS-84, 97, 92, 48, 77, 88,
   72, 93, 94, 60, 47, 46, 68, 95, 87), each verified present in `plans/FRONTIER-STUBS.md`, in the table's existing form.
4. **Three stubs R3 moved without reading in full** — FS-100 (`plans/STUB-measure-rigidity-three-fields.md`), FS-75
   (`plans/STUB-three-colour-criterion-kernel.md`), FS-39 (`plans/STUB-plane-bridge.md`): read each in full and confirm its head block and status
   are current; fix only what is stale, at the grades the ledger gives.
5. Owner rulings on R3's held items (for the record): the advisor's order applies to the minor disagreement too (FS-49 and FS-44 above FS-69 and
   FS-57, since both relaxations are post-ban); R1's list order stands as written for FS-22.

## Gates (exit statuses read directly)

`python3 tools/claude_md_fact_audit.py --base 2b7348dc` PASS; `--dupes` not above 10; `python3 tools/fs71_ledger_b_check.py --strict`,
`python3 tools/bib_audit.py`, `python3 tools/check_architecture.py` PASS; **`CLAUDE.md` under 300,000 bytes** (about 5,900 of room). If the table
would cross it, shorten the new rows (they point to `plans/FRONTIER-STUBS.md`), never an intrinsic elsewhere; if still over, stop and report.

## Rules

- **Touch only** `CLAUDE.md` (the paths-forward table, "Open milestones", "Last updated"), `tools/claude_md_fact_audit.py` (`EXTERNAL_HOMES`
  lines only), the three stub files in item 4, and a record section "§ Application — R4" appended to `plans/RERANK-2026-09-26.md`.
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- Report per standing rule 9 to `data/rerank-2026-09-26/reports/R4.md`, with `CLAUDE.md`'s byte count and every gate.

Thank you.
