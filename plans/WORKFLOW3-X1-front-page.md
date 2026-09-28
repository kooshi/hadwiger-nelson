# X1 — the front page: the closes of FS-114 and FS-111 filed verbatim (de Bruijn, front-page lane, 2026-09-28)

*Brief: `data/workflow3/briefs/X1-front-page.md` (commit 0dc62ab0), with `plans/STANDING-RULES.md`. Worktree `/home/kooshi/source/lean-dir-close`,
branch `close-2026-09-28`, created from `main` at 0dc62ab0. Every filing is done by a script under `data/workflow3/x1/` that extracts each draft from
its source by exact text, applies the named corrections and ruled merges as exact replacements (each asserted to occur exactly once), and writes the
target; the scripts are the record of what was changed.*

## Theorems this phase proved

None: this is a filing job. It proves nothing.

## Would-have-searched-here log (standing rule 5)

- Stage 1: none — reading and exact text checks only.

## Fence log (standing rule 8)

- None: the brief fences nothing, and no fenced text was met.

## Stage 1 — SAVED: the readback, the worktree, the manifest

### 1.1 Read in full, in order

The brief; `plans/STANDING-RULES.md`; `.claude/output-styles/keryx.md` § A milestone, end to end (step 7); `plans/FS114-C-close.md` § Drafts for the
front page; `plans/FS111-C-close.md` § Drafts for the front page (D1–D10); `plans/POROS-2026-09-28-close-reread.md` § Draft re-rank and § Draft for
CLAUDE.md § Paths forward; `data/workflow3/r1/assemble.py`, `open-unit.md`; `data/fs114/fs114-c/claude_md_units.py`; the two ticks files (heads);
the targets' structure (`LEDGER.md` §§ A–B, `BIBLIOGRAPHY.md` §§ A, A′, C, G, `plans/GROKKING-INSTANCES.md`, `plans/FRONTIER-STUBS.md`, the two
claim lists, the two close inventories, the stubs D8, F2 and F3 edit, `visualizations/proof-atlas/README.md`).

### 1.2 The brief's quotations, checked against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "Understood. Let's close up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old." | `plans/WORKFLOW3-test-drive.md` row K2 (l. 12) | MATCH, verbatim |
| "a radius uniform in `K` exists iff C-LOCAL holds" | `plans/FS114-derivation.md` l. 289, the statement of FS114-N114-COMPACT ("C114-COMPACT: TRUE at every `K`; a radius uniform in `K` exists iff C-LOCAL holds, and then …") | MATCH, a verbatim substring |

The brief's other statements, checked: Poros's corrections are its § Draft re-rank item 6 (F1, F9, F3, F2, F6) — MATCH; FS-111's § B block has 85 lines —
MATCH (85 lines `| FS111-…` in D1); FS-114's § B block is `data/fs114/fs114-c/ledger-b-draft.md` — 46 lines (the draft's heading says "49 lines", its text
"46 entries"; the file has 46: **a slip in the draft's heading**, nothing to file); FS-114's corrections to rows 134, 135 and FS-111's to rows 130,
131, 133, 136 — MATCH; FS-111's inventory items 38–42 exist, and item 43 (R1 DONE) is "any after"; FS-114's inventory has item 126 (R1 DONE) after 121–125.

### 1.3 The manifest as a table

| # | target | unit | source address | corrections and merges applied |
|---|---|---|---|---|
| 1a | `LEDGER.md` § A | rows 137, 138 (after row 136) | `plans/FS114-C-close.md` § `LEDGER.md` — § A, rows 137–138 | F1 (row 137's bold opening; its "So S–V's Question 2 …" sentence) |
| 1b | `LEDGER.md` § A | rows 139, 140, 141 | `plans/FS111-C-close.md` §D1 § A, three rows | `‹R111-a/b/c›` → 139/140/141 (ruling 3); F9 does not touch row 139 ("‹R111-a›'s own sentence … can stand") |
| 1c | `LEDGER.md` § A | rows 134, 135 corrected | `plans/FS114-C-close.md` § corrections owed, bullets 1–2 | — |
| 1d | `LEDGER.md` § A | rows 130, 131, 133, 136 corrected | `plans/FS111-C-close.md` §D1 "Corrections to existing rows" | ruling 3 in row 133's new text |
| 2a | `LEDGER.md` § B | FS-114's 46 lines after FS-112's | `data/fs114/fs114-c/ledger-b-draft.md` | — |
| 2b | `LEDGER.md` § B | FS-111's 85 lines after FS-114's | `plans/FS111-C-close.md` §D1 § B | ruling 3 |
| 2c | `LEDGER.md` § B | FS112-L60, -N3-BASE, -C-ENDS, -C-PARTNERS, -C-DOUBLE; 29 kernel cells "stub (FS-114)" → "stub (FS-116)" | `plans/FS114-C-close.md` § corrections owed, bullets 3–7 | — |
| 3a | `CLAUDE.md` | units last, prog, i31, g83 (+ G86), g72, rows | `plans/FS114-C-close.md` § `CLAUDE.md` (and `data/fs114/fs114-c/claude_md_units.py --emit`) | F1 (last, prog, i31 ×2, G83); F6 (g72); `‹last›` = 141 |
| 3b | `CLAUDE.md` | FS-111's four clauses at `‹FS-111›` | `plans/FS111-C-close.md` §D2 items 1–4 | F9 (item 4); rulings 1, 2 (full stop; semicolon), ruling "item 31's heading parenthesis", ruling 3 |
| 3c | `CLAUDE.md` | G84, G85 between G83 and G86 | `plans/FS111-C-close.md` §D4 | ruling 3 |
| 3d | `CLAUDE.md` § Paths forward | the ranked rows (29 + the group row) | `plans/POROS-2026-09-28-close-reread.md` § Draft for CLAUDE.md § Paths forward = `data/workflow3/r1/claude-paths-forward.md` (re-assembled and compared) | ruling 3 where present |
| 3e | `CLAUDE.md` | the open-milestones unit (Poros's whole unit) | same § "The 'Open milestones' unit" = `data/workflow3/r1/open-unit.md` | ruling 3 |
| 4 | `plans/GROKKING-INSTANCES.md` | instances under §G21, §G30, §G51, §G67 (new), §G72, §G79, § Make the gate fail | FS-114: § `plans/GROKKING-INSTANCES.md`; FS-111: §D4 "Instances" | — |
| 5 | `BIBLIOGRAPHY.md` | § A rows, § A′ alias, row edits (FS-114); § A amendments and rows, § C rows (FS-111 D5) | FS-114: § `BIBLIOGRAPHY.md`; FS-111: §D5 | — |
| 6a | `data/fs114/claims.md` | § 9 | FS-114: § `data/fs114/claims.md` | F1 (the C114-LOCAL-FR line) |
| 6b | `data/fs111/claims.md` | a dated section at the end | FS-111: §D3 | — |
| 7a | `plans/STUB-global-step.md` | the closed banner under the title | FS-114: § `plans/STUB-global-step.md` | F1 (the banner) |
| 7b | `plans/STUB-reg-scale.md` | the closed banner under the title | FS-111: §D7 | ruling 3 |
| 7c | stubs FS-114, FS-115, FS-104, FS-108, FS-109, FS-113, FS-101 | D8 bearing lines | FS-111: §D8 | — |
| 7d | `plans/STUB-local-exclusion.md`, `plans/STUB-map-step.md` | F3, F2 | Poros § Draft re-rank item 6 | — |
| 8 | `plans/FRONTIER-STUBS.md` | the re-rank paragraph; the ranked table; the open-milestones sentences; two closed-list lines; the FS-115 banner | Poros § Draft re-rank blocks 1–5 (the table = `data/workflow3/r1/ranked-table.md`, re-assembled and compared) | ruling 3 |
| 9 | `plans/FS114-close-inventory.md`, `plans/FS111-close-inventory.md` | the proposed ticks; items 121–126 and 38–43 given their where | `data/fs114/fs114-c/ticks.md`, `data/fs111/fs111-c/ticks.md` | — |
| 10 | `tools/viz_proof_atlas_facts.py` | FS-114's entries and node edits; FS-111's D9 | FS-114: § `tools/viz_proof_atlas_facts.py`; FS-111: §D9 | F1 (LOCALF and its edges), F9 (FS111's text) |
| 11 | `tools/fs111_m3_honey.py`, `tools/fs111_m4_rungs.py`, `tools/fs111_m2_disck7.py` | the output path; the one-line banner | the brief § The manifest item 11 | — |

### 1.4 Held for the coordinator before filing (sent to "main", 22:55 UTC)

The questions are in the message; their answers are logged in stage 2 below as they arrive.
Nine items: Q1 F6's G72 wording; Q2 row 133's kept parenthesis; Q3 D8's STUB-global-step fit; Q4 D8's "add" slots and form; Q5 FS-111's § B
milestone column ("139" or "row 139"); Q6 the bibliography's fit issues (a duplicate key `[AxenovichLiuSagdeev2025]`, a no-op `[Oostema2020]` edit,
prose edits' forms, `[Sirgedas2021]` and the group row's read cells, the § A′ form); Q7 the instances' headers, the G67 section, "Twenty-first";
Q8 the claim-list headings; Q9 findings (F1's conflation in two unlisted texts; LOCALF's own quote; DESIGN.md not in the manifest).
