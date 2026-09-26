*Brief for job **E1**: design (b) on `CLAUDE.md` — remove the incidentals, keep the intrinsics. Opus 5.5, 2026-09-26. Written by the product
owner. A verifier, E2, reads your diff afterwards.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the editor of the project's instructions file, in `/home/kooshi/source/lean-dir`. Read from disk:
`CLAUDE.md` in full (its header rules first), `WORKFLOW.md`, `DEBRUIJN.md`, `data/consolidation-2026-09-26/briefs/STANDING-RULES.md` (part of
this brief), and **`plans/PROPOSAL-claude-md-knowledge-cache.md` in full** — §1 measures every section and entry, and §2's row (b) is the
design you implement.

## Kooshi's words (2026-09-26, verbatim)

> "Implement b on the file. Remove incidentals, keep intrinsics."

> "We'll revisit a cache implementation next time we hit the cap at a point where we're too dense to compress or remove further incidentals."

## What is intrinsic, and what is incidental

- **Intrinsic — stays in `CLAUDE.md`:** every rule's statement; its reasoning (the *why* — Kooshi, 2026-09-15: a rule's reasoning trimmed to
  fit once cost hours); every grokking's head, grade, mechanism, *Do* line and killing test; **one** example per rule (the one that best shows
  the failure); every demotion record the § Grokkings preamble requires (one or two sentences: what the entry wrongly claimed and what killed
  it); every `[PROTECTED — never compress …]` paragraph, **untouched, word for word**; every current-state fact the Frontier or a grokking
  reasons from.
- **Incidental — moves out:** the second and later instances of a rule (the instance lists of G21, G49, G50, G72, and their like); incident
  narratives (which agent, which night, which pid) behind a rule already stated; the prior-art position's long "Not ours" enumeration; paths-forward
  rows at rank ≥ 30 (they live in `plans/FRONTIER-STUBS.md` already); counts and dates that record history rather than state.
- **When unsure, it is intrinsic.** A sentence that carries a *why*, a condition, or the only example stays.

## Where incidentals go — nothing is deleted

1. **A new file, `plans/GROKKING-INSTANCES.md`** — like `LEDGER.md`, "read by address, never loaded": one section per source (by grokking id,
   or by `CLAUDE.md` section for the § Building and gate-failure stories), holding each moved passage **verbatim**, with the address it came
   from. Each source keeps a pointer: "More instances: `plans/GROKKING-INSTANCES.md` §G21."
2. The "Not ours" enumeration → `LEDGER.md`, beside § The claim list, verbatim; the prior-art position keeps its first sentence and a pointer.
3. Paths-forward ranks ≥ 30 → already in `plans/FRONTIER-STUBS.md` (check each row is there, current, before cutting); keep one pointer line.
4. **The header:** record the pass in the budget's history parenthesis (Kooshi's words and date), and add `plans/GROKKING-INSTANCES.md` to the
   one-home-per-fact sentence beside `LEDGER.md`.
5. **The fact audit** (`tools/claude_md_fact_audit.py`) must count the new file as a home, so "nothing lost" stays true across
   `CLAUDE.md` + `LEDGER.md` + `plans/GROKKING-INSTANCES.md`: extend it minimally, and **plant a fault** — delete one moved fact from the new
   file and watch the audit go red; restore it and watch it go green (a partner that must pass). Record both runs.

## Stages (each saved and committed; every gate green at every commit)

1. **The inventory:** a table in your record of every passage you propose to move — address, bytes, incidental because …, destination. No edits
   yet. Save; commit. (E2 reads this.)
2. **The tooling:** the fact-audit extension with its planted fault and partner. Save; commit.
3. **The moves,** section by section (§ Grokkings' instance lists; § Frontier's "Not ours" and ranks ≥ 30; § Building and "Make the gate fail"
   incident stories), one commit each, each move and its pointer in the same commit.
4. **The header,** and the report.

## Gates at every commit (exit status read directly)

`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS (every ALLOW line reviewed and stated with its reason — prefer
extending the audit's homes to adding ALLOW lines); `--dupes` at 10 or fewer (a moved passage must not remain in two places);
`python3 tools/fs71_ledger_b_check.py --strict` PASS; `python3 tools/bib_audit.py` PASS; `python3 tools/check_architecture.py` PASS.

## Stop rules

- **Target:** the proposal's ≈ 267–270k. Stop when the incidentals are out, whatever the number — never cut an intrinsic to reach it.
- If a passage is both (a story that is also the rule's only example), keep it.
- Never touch a `[PROTECTED]` paragraph. Never rename or renumber an identifier (G1–G80, row numbers, FS numbers).

## Rules

- **Touch only** `CLAUDE.md`, `LEDGER.md` (the "Not ours" block beside § The claim list), `plans/GROKKING-INSTANCES.md` (new),
  `tools/claude_md_fact_audit.py` (the homes list and its controls), and your record `data/consolidation-2026-09-26/E1-record.md`.
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- **Budget:** about 350k by the harness's count; hand back by 450k.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/E1.md`: `CLAUDE.md`'s bytes before and after, the new file's bytes,
  every gate, and the commit before your first edit (E2 diffs from it).

Thank you.
