*Brief for job **J55**: the front-page pass for two closes — FS-100's in-ban round and FS-75's minimal instance. Opus 5.5, 2026-09-26. Written by the product owner. **Its
template is J44's brief** (`data/crunch-2026-09-25/briefs/J44-front-page-row88-FS67.md`), which rests on J24's: read both in full and follow
them. The changes below override them where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page editor**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md` (the header rules, above all current-state-only and one-home-per-fact), `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your record `data/fs100/j55-record.md` already exists, you are resuming.** Check its last SAVED stage against `git log` and continue at
the first stage not SAVED.

## What you apply

1. **FS-100's close:** `plans/FS100-three-field-lemma.md` §R-close (J53's stages 1–3 and J53b's stages 4–5; the drafts are in §R-close 4.3,
   5.1–5.5) and `plans/FS100-derivation.md` (15 entries). It brings:
   - `LEDGER.md` rows **116–118**, row 98's "Not claimed" addition, the claim-list line (`LEDGER.md` § The claim list), and the § B lines
     (`data/fs100/j53/ledger-b-draft.md`, checked by `data/fs100/j53/check_b_draft.py`);
   - the `CLAUDE.md` drafts (net +2,357 bytes by J53b's count: items 10 and 27, G21, G50 with the owner's Do, G72, G76, G79, the FS-100 and
     FS-64 Paths-forward rows, the "Last updated" line), anchored by `data/fs100/j53/front_page_drafts.py` — run it before you apply, and
     apply each draft exactly;
   - the `BIBLIOGRAPHY.md` drafts (§R-close 5.3): updates to `[EinsiedlerLindenstrauss2022]`, `[Wang2012]`, the Einsiedler–Lindenstrauss
     listing and the Rudolph/Johnson/Host row; new `[EinsiedlerLindenstrauss2003]`, `[LindenstraussWang2012]`, `[BekkaFrancini2022]`;
   - the re-aimed stub files (FS-100, FS-64), already written: make `plans/FRONTIER-STUBS.md`'s rows follow them.
1b. **FS-75's close** (a kernel milestone): `plans/FS75-kernel-167.md` §R-close (job J54) and `plans/FS75-derivation.md`. It brings the
   `LEDGER.md` row or row-79 update J54 ruled on (its number follows FS-100's 118), its § B lines, its `CLAUDE.md` drafts (at most 1,500
   bytes net: "What the kernel holds", the FS-75 Paths-forward row, "Open milestones"), and the re-aimed stub files for FS-75 and FS-60, whose
   `plans/FRONTIER-STUBS.md` rows follow them. **The trust ledger's count:** `CLAUDE.md` § Trust ledger reads "1130 clean"; the axioms gate
   now reads 1193 clean, 11 axiom-free, 5 purchases (`build/gate/axioms/20260926T053431Z-866750.log`). Update the sentence to current state,
   and add the reviewed transition `('1130', '5') -> ('1193', '5')` with that log to the fact audit's gate-count table
   (`tools/claude_md_fact_audit.py`, the table under "Reviewed transitions of the gate-report sentence's … counts"), in the form its existing
   entry uses.
2. **Two provisional-bearings lines** J53b drafted outside its lane (§R-close 5.4): FS-84's stub (`plans/STUB-five-colours-47.md`) and
   FS-92's (`plans/STUB-character-classification.md`). Apply them to those two lines only.
3. **One correction owed since the crunch** (the visualization job J43 found it): eight `LEDGER.md` table lines carry an unescaped `|` inside
   a code span, which splits the table cell — rows 75, 76, 78, 80, 85, 86 and the § B lines FS66-L1 and M3-J22-T8. Escape each as `\|`.
   **Before editing the two § B lines, read `tools/fs71_ledger_b_check.py`'s `ROW_RE` and check the escape keeps them parsing**; if it would
   not, leave those two, and say so.
4. **The current-state lines in `CLAUDE.md`:** in "Open milestones", FS-100's in-ban round is CLOSED (stage 4 re-aimed; the plan's §R-close
   first), and **FS-75's minimal instance, `χ(ℚ(√167)²) ≥ 4` in the kernel, is CLOSED** (`plans/FS75-kernel-167.md` §R-close). FS-84 stays
   open with its next stages post-ban. Keep the "Last updated" line to one sentence of current state.

**Not yours:** the local–global map's tag of ℚ(√143), ℚ(√311), ℚ(√335) (§R-close 5.4's third draft) waits for Kooshi's first look at the map;
leave `visualizations/` alone.

## Gates

- **`CLAUDE.md` under 300,000 bytes.** It stands at 283,904; the two closes' drafts add about 4,000. If the file would cross 290,000, stop
  and report.
- **`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>`** PASS, with any reviewed ALLOW line stated and its reason.
- **`--dupes`** at 7 or fewer, or report the new count and why.
- **`tools/bib_audit.py`** PASS.
- **`python3 tools/fs71_ledger_b_check.py --strict`** PASS. It fails now on the 15 FS100 ids and FS-75's new ids; your § B lines fix that.
- **Architecture** (`tools/check_architecture.py`) PASS; it passed at the owner's gate re-run, and you do not touch its inputs.

Read every exit status directly, never through a pipe. Never commit a stage whose gate failed on your own edits.

## Rules

- **Touch only** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md` (only if the close drafted an
  entry for it), `plans/STUB-five-colours-47.md` and `plans/STUB-character-classification.md` (their provisional-bearings lines only), the
  gate-count table of `tools/claude_md_fact_audit.py` (one reviewed transition), and your record `data/fs100/j55-record.md`. **Never** touch job records, close records, plans' bodies, `ARCHITECTURE.md`, `Proofs.lean`,
  `scripts/`, Lean files, or `visualizations/`.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a saved stage
  and tell me what is left.
- **Commits by explicit path**, subjects "J55: stage n"; never amend. End commit messages with your harness's attribution lines. Push after
  each commit (on a ref-lock race, `sleep 4` and retry); never force-push.
- **Budget:** about 250k by the harness's count; hand back by 330k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J55.md`, committed, and by SendMessage
  `to: "main"`, with every gate's result and `CLAUDE.md`'s byte count. Keep your turn's final text content-free: "J55 idle; report sent to
  the owner by SendMessage".

Thank you.
