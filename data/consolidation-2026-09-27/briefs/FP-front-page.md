*Brief for job **FP**: the consolidation run's front page — apply the reading jobs' drafts to the front files. Opus 5.5, 2026-09-27. Written by
the product owner. **Sized for about 300k tokens by the harness's count, as guidance.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/consolidation-2026-09-27/briefs/STANDING-RULES.md` is part of
this brief; read it first, rule 0 first** — except its rule 7: this brief names the front files you may edit. Then read from disk:
`plans/CONSOLIDATION-2026-09-27.md` (the run record, items 1 on); `CLAUDE.md` in full, with its header rules (the 300,000-byte budget, current state
only, one home per fact, `[PROTECTED …]` paragraphs never touched); `WORKFLOW.md` step 9.

## Why this job exists

Five reading jobs read the papers our claims waited on and walked the Geombinatorics archive. They moved credit, found questions posed in print
that our rows answer, and found a 1992 conjecture equivalent to `χ(ℝ²) = 7`. Everything bound for `CLAUDE.md`, `LEDGER.md` and the stubs is
drafted, none of it applied. Second readings checked the moves: LW2 checked LW's (its report's § 0), LV checked LP's (its report).

## Your sources, in order of precedence (a later second reading overrides the first)

1. `data/consolidation-2026-09-27/reports/LV.md` — the corrected set of LP's drafts, and LV's verdicts on P1–P6. Where LV differs from LP, LV wins;
   where LV found LP's edits already applied need correcting, LV applied them.
2. `data/consolidation-2026-09-27/lp/record.md` stage 5 — LP's drafts D-1 … D-7 (`CLAUDE.md`), `WORKFLOW.md` 3.2 item 8, the G49 instance, FS-20.
3. `data/consolidation-2026-09-27/reports/LW2.md` § 4 — its drafts, which supersede LW's where they overlap (link 2's wording in particular: the
   Gwyn–Stavrianos paper prints the argument, not link 2 itself).
4. `data/consolidation-2026-09-27/reports/LW.md` § 3 — its drafts, except where LW2 corrected them.

If job LW3's report (`data/consolidation-2026-09-27/reports/LW3.md`) exists when you reach stage 3, read its drafts too and apply the ones that are
plainly bookkeeping (bibliography keys, stub pointers); list the rest for the owner.

## The task, in stages (save after each)

1. **The drafts table.** List every draft from the four sources in one table in your record: target file and place, old text, new text, source
   address, and your decision (apply / apply amended / decline, with the reason). Check each quotation a draft carries into a front file against the
   source page it cites — this is the second reading for the few that had one reader only (Kainen 1992's *"The chromatic number of the plane is
   robust"*, p. 35, is one). Save.
2. **`LEDGER.md`, `CLOSED-QUESTIONS.md`, `BIBLIOGRAPHY.md` (outside § G), the derivation files, `plans/GROKKING-INSTANCES.md`.** Apply. Rows are
   never renumbered; a prior-art addition goes into the row's prior-art sentence; a new instance goes under its entry with its source address.
   `python3 tools/fs71_ledger_b_check.py --strict` and `python3 tools/bib_audit.py`, exit statuses read directly. Save.
3. **The stubs and `plans/FRONTIER-STUBS.md`.** FS-112 (`plans/STUB-unit-arc-half.md`) gets a banner at its head with its four re-aims (its question
   posed in print, `[Polymath2021]` p. 199; the strip, `[AxenovichEtAl2014]` Thm 4.2, as its one exact known positive; `[Parts2021]`'s measured
   saving from wavy sides, and a note that its registered expectation "a YES by formula (0.03)" is to be re-registered at the milestone's opening — **do not
   re-register it yourself**; Kainen's conjecture), and the bearing-on-the-answer text updated if the drafts say so. FS-111, FS-109, FS-108, FS-102,
   FS-20: the drafted notes. FRONTIER-STUBS rows as drafted; **no rank moves** (the owner's), and `CLAUDE.md`'s mirror kept in step. Save.
4. **`CLAUDE.md` and `WORKFLOW.md`.** Apply the drafts (LV's corrected set of LP's; LW2's link 2 and rows; anything else drafted for it). In
   `WORKFLOW.md`, only 3.2 item 8's sentence that `[Fischer1994]` is cited by nothing, corrected to the fact (both Johnson surveys restate it), with
   no other change. **The budget:** `CLAUDE.md` is 295,835 bytes against 300,000; report the count before and after. Pay for additions by pointing
   to rows rather than retelling them; never cut an intrinsic. Save.
5. **Gates**, each exit status read directly, never through a pipe: `python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS, every
   ALLOW line you add stated with its reason (add only reviewed lines for text that moved to another file or was corrected); `--dupes` not above 10;
   `python3 tools/fs71_ledger_b_check.py --strict` PASS; `python3 tools/bib_audit.py` PASS; `python3 tools/check_architecture.py` PASS;
   `python3 data/rerank-2026-09-27/rk_mirror_check.py` PASS.

## Rules

- **Touch only:** `CLAUDE.md`; `WORKFLOW.md` (3.2 item 8's one sentence); `LEDGER.md`; `CLOSED-QUESTIONS.md`; `BIBLIOGRAPHY.md` outside § G (job LW3
  writes § G in parallel — commit the file promptly after each edit, and on a rebase conflict keep both sides); `plans/FRONTIER-STUBS.md` (row text,
  never ranks); the stubs named above; `plans/GROKKING-INSTANCES.md`; the derivation files a draft names (`plans/FS103-derivation.md` for FS103-M-EASY);
  `tools/claude_md_fact_audit.py` (reviewed table lines only); and `data/consolidation-2026-09-27/fp/`.
- **Never** touch a `[PROTECTED …]` paragraph, re-rank a row, or re-register a prediction.
- **Record:** `data/consolidation-2026-09-27/fp/record.md`, with a heading "Theorems this phase proved" (expected empty).
- Commits by explicit path, subjects "FP: stage n". Never amend; push after each; never force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Report** to `data/consolidation-2026-09-27/reports/FP.md`, committed, and by SendMessage to `"main"`, with: the drafts table's decisions, the byte
  counts, what was declined and why, and each gate's result. Your final turn's text: "FP idle; report sent to the owner by SendMessage".

Thank you.
