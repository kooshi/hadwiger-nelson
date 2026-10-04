# FS129-F1 — the front page, FS-129's record (the Clerk's record)

Worktree `/home/kooshi/source/lean-dir-fs129-close`, branch `fs129-filing`, from `main` at the brief's launch commit. Scripts that apply the drafts
(`file_ledger.py`, `file_claude.py`, ...) are in this directory; each reads its draft by script from the source file and asserts every slot matches once.

## Theorems this phase proved

None. A filing job.

## Stage 1 — SAVED: readback, worktree, manifest table

**Readback.** The brief's quotations: Keryx's workflow lines ("Every draft is written by a lane ...", "When the filing is large, the Clerk is your pen
...") are quoted from `.claude/output-styles/keryx.md` § The filing; not re-checked word for word (CHECK, below). Every slot string the manifest and Z2
name was checked by assertion (each occurs exactly once in its target) in the scripts. Worktree created by the brief's command (exit 0).

**Manifest as a table** (target | unit | source address | merge).

| # | target | unit | source | ruled merge |
|---|---|---|---|---|
| 1a | `LEDGER.md` § A after row 148 | rows 149–154 | `plans/FS129-Z2-record.md` § Drafts, `LEDGER.md` § A — rows 149–154 | none |
| 1b | `LEDGER.md` row 121, Where cell | appended "; `plans/FS84-SI-D-derivation.md` (J45-N1 ...)" | same, "And row 121, its Where column" | none |
| 2a | `CLAUDE.md` "Last updated" | Z2 unit 1 | Z2 § `CLAUDE.md` § Frontier, 1 | none |
| 2b | `CLAUDE.md` § Paths forward, Open milestones | Z2 unit 2 | same, 2 | "then the top of FS129-P1's ranking." -> "then the top of the ranking, FS-124, the (Q) ring (its question posed in `plans/STUB-q-ring.md`)." (item 159) |
| 2c | `CLAUDE.md` item 31 | Z2 unit 3 | same, 3 | none |
| 2d | `CLAUDE.md` theory paragraph | one sentence | same, "The theory paragraph" | none |
| 2e | `CLAUDE.md` § Paths forward table, rows 1–3 | P1's top three | `plans/POROS-2026-10-03-fs129-rerank.md` § Draft re-rank, "The top three, as `CLAUDE.md` § Paths forward should carry them" | none |
| 2f | `CLAUDE.md` § The aim, programme paragraph | three re-aimed names | brief § ruled merges (item 165) | used: FS-123 -> "the Siamese class"; FS-128 -> "the top colour, at five and six"; FS-120 -> "the pinch at a junction, and the cover route at five" |
| 2g | `CLAUDE.md` § The novel-results ledger | "Rows 1–148" -> "Rows 1–154" | brief | used |

## Stage 2 — SAVED: `LEDGER.md` and `CLAUDE.md` (items 1–2)

Applied by `data/fs129/f1/file_ledger.py` and `file_claude.py` (all slots asserted once). Rows 149–154 sit after row 148 (§ A); row 121's Where cell
gained the FS84-SI-D clause before its " | FS-100 stage 5" cell. In `CLAUDE.md`: units 1, 2, 3 and the theory sentence replaced as drafted (the theory
sentence's slot breaks across a line in the file, "such a / vertex ..."; the replacement keeps the draft's words and puts its own line break); P1's
three table rows in place of the three ranked rows; the ruled merges of items 2b, 2f, 2g used as in the table above. `CLAUDE.md` has no "G1–G91".

Gates (saved: `fact_audit_stage2.txt`, `dupes_stage2.txt`):
- `wc -c`: `CLAUDE.md` 51,126 (< 80,000); `.claude/skills/grokkings/SKILL.md` 168,727 before item 3 (< 200,000).
- `tools/claude_md_fact_audit.py --base f411553f`: **exit 1**, one failure: `lost chunk token '131–141'`. Cause: the draft's item 31 opens "(§ The aim; rows
  131–154; …" where the old text read "rows 131–141, 145–148, 142–144"; the draft's range subsumes them but the token "131–141" no longer occurs. Not
  fixed (no word of mine); see HELD.
- `--dupes`: exit 0; 163 repeated runs, 15,161 bytes, against 154 runs and 14,287 bytes on `main` — the rows 149–154's quotations repeat their
  derivation entries' words by design.
