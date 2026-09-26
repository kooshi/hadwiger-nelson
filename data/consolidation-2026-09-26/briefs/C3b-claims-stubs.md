*Brief for job **C3b**: bring the ranked stubs and every stub file up to date with the new evidence. Opus 5.5, 2026-09-26. Written by the
product owner. Launch after C1 (which adds pointer blocks to stub files) has handed back.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the roadmap editor, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` from disk (C3a rewrote it
today; its Frontier is current), `WORKFLOW.md` (step 2's stub rule; step 9) and `DEBRUIJN.md`. **`data/consolidation-2026-09-26/briefs/STANDING-RULES.md`
is part of this brief.** Read C3a's report and record first: `data/consolidation-2026-09-26/reports/C3a.md`, `data/consolidation-2026-09-26/C3a-record.md`
(its table of claims changed, and its "owed to C3b" list), and C2's report `data/consolidation-2026-09-26/reports/C2.md` (its "owed (C3b/plans)").

## Kooshi's words (2026-09-26, verbatim; C3a quoted them in CLAUDE.md)

> "We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be fascinating) and potentially answer the
> HN problem definitively."

> "I'm not interested in taking the time to find a triangle free graph. That's incidental to the goal."

## What to do

1. **`plans/FRONTIER-STUBS.md`** — authoritative for the ranking (WORKFLOW step 2): every row the new evidence changes, rewritten in place to
   current state, matching `CLAUDE.md`'s paths-forward table row for row (C3a changed ranks 1, 2, 5, 6, 12, 16, 20 there; C3a's owed list names
   FS-80, FS-72, FS-64, FS-90's bearing cells). The closed list: FS-84 closed (Kooshi: the triangle-free graph is incidental), with its record's
   address. Keep every rank number stable (the FS-97 precedent: a closed row keeps its rank).
2. **Every stub file** the new evidence touches — at least FS-59 (its question answered at five, [hand]; re-aimed to six at ℚ(√167), rank kept
   at 1 unless you argue otherwise in your report), FS-84 (a banner: closed, why, with Kooshi's words), FS-100, FS-101, FS-98, FS-64, FS-96,
   FS-97 (banner), FS-48, FS-72, FS-78, FS-62, FS-80, FS-90, FS-75, FS-60 — and any other whose status line or provisional-bearings line rows
   120–127 change: update its status block and provisional-bearings line to current state, at the grades the rows give. Deprecate, never
   delete (banners for closed or superseded stubs).
3. **Mint the write-up stub** (owner ruling: the stub rule says every future milestone lives as a stub; Kooshi's "writing this up will be our
   fallback"): `plans/STUB-writeup-main-clause-five.md` — the fallback write-up of rows 120–123 (the algebraic `χ ≥ 5`, the main clause
   through five, `χ(ℚ(√47)²) = 5`), with Kooshi's words verbatim, the publication rule "half fires", the prior-art state (X24R; Johnson
   2000/2006 "Kooshi, acquiring"), the naming rule (§ Publication: the discipline's vocabulary, `BIBLIOGRAPHY.md` §E), and the comparator
   artifact shape. Add its row to `plans/FRONTIER-STUBS.md` at a rank you argue (default: just below the six-hunt stubs), and mirror it in
   `CLAUDE.md`'s paths-forward table **only if it fits in the byte budget** — the file has about 1,000 bytes of room; if not, list it as owed.
4. **The derivation file and plan lines C2 found stale:** `plans/FS100-derivation.md`, FS100-PE2's prior-art field ("EL2021 §2 unread …" —
   X24R read §2: set-up only, PE-2 is not in it; quote X24R's record); `plans/FS100-three-field-lemma.md` lines ~1874, 1884, 1892 ("to move to
   `~/source/library/pdf/`" — done at X30F, commit 3b1952a6): annotate as done, do not rewrite a closed record's history.

## Gates (exit statuses read directly)

`python3 tools/fs71_ledger_b_check.py --strict` PASS; `python3 tools/bib_audit.py` PASS; `python3 tools/check_architecture.py` PASS; and, if you
touch `CLAUDE.md` at all, `python3 tools/claude_md_fact_audit.py --base <HEAD at launch>` PASS with `CLAUDE.md` under 300,000 bytes.

## Rules

- **Touch only** `plans/FRONTIER-STUBS.md`, `plans/STUB-*.md`, the new write-up stub, the two plan files in item 4 (the named lines only),
  `CLAUDE.md` (the paths-forward table's rows only, and only within the budget), and your record `data/consolidation-2026-09-26/C3b-record.md`.
  Never `LEDGER.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, Lean files, `scripts/`, frozen tools.
- Keep a table in your record: file, location, old text (quoted), new text, the row that justifies it.
- **Budget:** about 250k by the harness's count; hand back by 350k.
- Report per standing rule 9 to `data/consolidation-2026-09-26/reports/C3b.md`.

Thank you.
