# Brief: FS-89's close, the last item (item 50/53), for a third close planner

You are **de Bruijn** (`DEBRUIJN.md`), working as the third planner for FS-89's close in `/home/kooshi/source/lean-dir`. I'm the product
owner. Two close planners have finished everything else, and every gate is green (inventory items 44 and 52). One item is left: fold in a
prior-art reading of Greenwell–Lovász 1974 and Larose–Tardif 2002.

## Read first

- `data/fs89/briefs/CL-close-planner-brief.md` and `CL2-close-planner-brief.md`. Their standards and rules apply to you; the changes are
  below.
- `plans/FS89-close-inventory.md` items 50 and 53. Item 53 is the checklist.
- `plans/PA-products-GL1974-LT2002.md`, the reader's record (commit 451542ce), **in full**. Read every number and quotation from it, never
  from item 53. The papers are in `~/source/library/pdf/`; the Greenwell–Lovász copy is a scan.

## The edits (item 53 lists them; the record has the exact sites)

1. **`BIBLIOGRAPHY.md`:**
   - the rows for `[GreenwellLovasz1974]` and `[LaroseTardif2002]`, "held, read in full", with the statement fixes;
   - a new `[Larose2002]` row (not held, a zbMATH listing);
   - correct the overstatement at line 66;
   - § D task 2, answered.

   Run `tools/bib_audit.py`.
2. **`LEDGER.md` row 86:** restore "connected" to the Greenwell–Lovász / Klotz–Sander sentence, in place, current state only. Say what
   changed in the commit message.
3. **Correction notes** in the finished records that misname a result. Use notes, not rewrites:
   - Coxeter and MASCOT's "uniquely `n`-colourable" gloss on `K₄ × K₄`: it is Corollary 3;
   - M50's and `STANDING-QUESTIONS.md`'s "strongly projective" attribution: it is Larose 2002, and the fact M50 uses is Corollary 3 at
     `n = 5`;
   - the stale "unread" markers the record lists;
   - the 2026-09-20 handoff's overstatement.
4. **FS-67:** add PA-P3 (settled for `G = K_k^s`, covering `Γ₃ ≅ K₃ × K₃` and `U₂ = K₄` with their powers) and PA-P5 (the equal-ratio
   case under IS-primitivity, conditional on Zhang) to `plans/STUB-tight-product-colourings.md`, and update `plans/FRONTIER-STUBS.md`
   row 10's wording to match. Check the reader's note that the stub reads Zhang's Theorem 1.8 for the strict case only against rows
   88–89, and resolve it or record it. Credit the dichotomy's first posing: `plans/POROS-2026-09-24-fs85-competition.md` hunch P-prod.
5. **`CLAUDE.md`:** only if a statement there is wrong at its scope. G70's sentence "whose only proper four-colourings are its two
   projections (Greenwell–Lovász)" is already correct (it is Corollary 3). If you edit anything, stay inside the 275,000-byte budget and
   rerun `tools/claude_md_fact_audit.py --base 052707ac` and `--dupes` (11).
6. **The side results PA-P2 to PA-P5:** their home is the reader's record, as with the Tardif reading's PA-T4 to PA-T6. Don't file them in
   FS-89's derivation file.
7. **Tick items 50 and 53** "done at <hash>".

Then rerun `tools/bib_audit.py`, `tools/fs71_ledger_b_check.py --strict`, and the fact audit if `CLAUDE.md` changed.

## Rules

- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation). The reason: staffing
  is Kooshi's budget decision, and I can only review work I know about.
- **Work in stages,** saving after each file.
- **Commits by explicit path**, after `git diff -- <path>`.
  - `git add` new files first; commit with `git commit <paths> -m …`.
  - Never amend. Don't push.
  - End messages with your harness's attribution lines.
  - Report each hash.
- **No search of any kind** (the ban runs to 2026-10-01). Never run `lake build`.
- **Budget:** about 150k tokens. **Your scratch directory:**
  `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs89-close3/`.
- **Reports** go to me by SendMessage (`to: "main"`). Keep your final turn text content-free: "close planner idle; reports go to the
  owner by SendMessage".

Thank you.
