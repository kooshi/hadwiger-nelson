# BK — the bookkeeping of the consolidation and library run, 2026-09-27 (record)

*de Bruijn (Opus 5.5), job BK. Brief: `data/consolidation-2026-09-27/briefs/BK-bookkeeping.md`, with
`data/consolidation-2026-09-27/briefs/STANDING-RULES.md`. HEAD at launch: a5fe409d (the fact audit's `--base`). Rule 0 first: `CLAUDE.md` § The aim
and § Counter-priors read before anything else. Read from disk: `plans/CONSOLIDATION-2026-09-27.md`; `CLAUDE.md`'s header, § The aim,
§ Counter-priors, § Where the problem stands, § Paths forward; `WORKFLOW.md` steps 2 and 9; `plans/RERANK-2026-09-27.md` §§ 3–4; `LEDGER.md` rows
131–134.*

## Theorems this phase proved

None. This job files and rewrites; it derives nothing.

## Stage 1 — SAVED (CE1–CE7 filed)

**What was owed.** FS-110's close inventory item 115: *"Owed: CE1–CE7 derivation entries (no § B lines yet)"*. Source:
`plans/FS110-CE-verification.md` § "Theorems this phase proved" and the sections each cites (§E1–§E6, Stage 3's verdict table); grades as item 113
set them (D4 one reading, CE; D5 items 1–4, 6 true after CE's local repair, one mind; the `d = 2` closure by two routes, CD's Theorem D2 and CE's
Antipodal Lemma).

**Filed** in `plans/FS110-derivation.md` § 1, after FS110-CUSP-BASE, in that file's entry form (`**<id> — <title>. [<grade>]**` with the five
fields), and one `LEDGER.md` § B line each, milestone cell "row 134", placed after FS110-CUSP-BASE's line:

| id | the theorem | grade | kernel |
|---|---|---|---|
| FS110-CE1 | CB's D4 bicycle, overshoot included, holds at cusp and double-cusp vertices | hand and tools; one mind on cusps (CE); endpoint cases two minds (CB, CE) | with FS110-CLOSURE |
| FS110-CE2 | CB's "WLOG n = −1" completed: every band offset `k ≠ 0, −1` dies | hand and tools; one mind | with FS110-CLOSURE |
| FS110-CE3 | CB's D5 item 2 parenthetical FALSE at (β) and at spike returns, TRUE where the circle changes colour | hand and tools; two minds at (β) (CD, CE), one at spikes | declined (a counterexample to CB's text; its positive half inside CE6) |
| FS110-CE4 | CB's D5 item 4 a GAP at (E3) and (β), cusp instances included | hand and tools; two minds (CD, CE) | declined (superseded by CE6) |
| FS110-CE5 | the Antipodal Lemma, one-sided | hand and tools; one mind | with FS110-CLOSURE |
| FS110-CE6 | D5 repaired by R1–R4 and the Antipodal Lemma: no pair at distance 2 reaches Lemma 3 or Cor. 3 | hand; one mind by this route | with FS110-CLOSURE |
| FS110-CE7 | D5 item 1's "= 1 is (P′)" needs (ii) when the ends' third colours differ | hand; one mind | declined (carried inside CE6) |

Every header uses an ASCII id, has no parenthetical before the dash, and nests no brackets inside its grade.

**Stale text made current in the same file** (the file is BK's; each sentence described CE as running or the cusp steps as under check):
the header's source list now names `plans/FS110-CE-verification.md`; the one-paragraph result's grade ("**under check at D4 and D5 items 1–4, 6**
(FS110-CE)") now reads one reading at D4 and one mind after CE's repair at D5 items 1–4, 6; FS110-CLOSURE's proof verdict ("D4's bicycle and D5
items 1–4, 6 at cusp vertices under check") now cites CE1 and CE6; FS110-COR1-NOD2's proof verdict cites CE3–CE7 beside CD's route; FS110-CUSP-BASE's
proof verdict ("Not yet read at cusps: … (FS110-CE, running)") now cites CE1–CE7.

**Checks, each exit status read directly:** `python3 tools/fs110_ce_scope.py` exit 0, "ALL AS PREDICTED" (the addresses the entries cite);
`python3 tools/fs71_ledger_b_check.py --strict` exit 0, PASS, 947 rows (940 before), census FS110 = 49 (42 before);
`python3 tools/claude_md_fact_audit.py --dupes` exit 0, 10 repeated runs (10 before: the seven new § B lines add none).
