*Brief for crunch job **J44**: the front-page pass for two closes, row 88's question and FS-67, plus one grokking of Kooshi's. Opus
5.5, 2026-09-25. Written by the product owner. **Its template is J24's brief** (`data/crunch-2026-09-25/briefs/J24-front-page.md`, the
front page for M1–M3): read it in full and follow it. The changes below override it where they differ.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the front-page editor**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md` (the header rules, above all current-state-only and one-home-per-fact), `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from
disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your record `data/crunch-2026-09-25/j44-record.md` already exists, you are resuming.** Check its last SAVED stage against `git log`
and continue at the first stage not SAVED.

## What you apply

1. **Row 88's close:** `plans/FS86-row88-rigidity.md` §R-close (its stages 3–4) and `plans/R88-derivation.md`. It brings:
   - `LEDGER.md` rows 111–113 and 19 § B lines;
   - 13 exact `CLAUDE.md` edit pairs (net +2,246 bytes), checked by `data/fs86r88/j41/claude_drafts.py`;
   - 15 `BIBLIOGRAPHY.md` rows and 2 corrections;
   - new stubs FS-97, FS-98 and FS-99, plus the re-aims of FS-84, FS-64 and FS-90, already written as files — update
     `plans/FRONTIER-STUBS.md` to match.

   The FS86-V2 correction is drafted there as well.
2. **FS-67's close:** `plans/FS67-tight-products.md` §R-close and `plans/FS67-derivation.md`. It brings:
   - `LEDGER.md` rows 114–115 and 20 § B lines;
   - `CLAUDE.md` drafts (+2,406 bytes, G72's eleventh count);
   - bibliography rows;
   - the re-aimed stub `plans/STUB-tight-product-colourings.md`, whose `plans/FRONTIER-STUBS.md` row and `CLAUDE.md` § Paths forward row
     follow it.

   Its verdict is "Paid (theorem and no-go)". Its bearing on χ ≥ 6 is none.
3. **One new grokking, Kooshi's**, from `plans/CRUNCH-2026-09-25-post-close-inventory.md` row 25. His words, verbatim: *"This is an
   interesting grokking too: walls often show up as 'the (impossible?) counter-example invariant' and we have had a successful breakthrough
   when looking for the 'example invariant'."*
   - Mint it as **G79**, a [method] entry in G67's form: a trigger, a *Do*, and a killing test. Keep it within about 1,500 bytes.
   - Link it to G72, which it pairs with as the dual move.
   - Give its instances only as addresses:
     - the counterexample invariants: row 96, T-C(A) (row 113 or whichever row carries it), G22, G48/G31, G57;
     - the example invariants: G71/G74's slope, G75's eigen-equation, G76's locality, row 95.
   - The three wanted-poster Poros sessions (J37–J39) are queued to test it. Say that the entry is new and untested, and let its killing
     test be one a later close can score.
4. **The post-close inventory:** in `plans/CRUNCH-2026-09-25-post-close-inventory.md`, apply every open row whose target is a front-page
   file, and tick it "done", or "declined, with the reason". Leave rows aimed at job records or Lean files open, and list them in your
   report.
5. **The current-state lines:**
   - `CLAUDE.md`'s "Open milestones" paragraph and "Last updated" line: row 88's question and FS-67 are CLOSED. FS-84 stays open; its S1
     and S1V are done and its next stages are post-ban.
   - The crunch index `plans/CRUNCH-2026-09-25-INDEX.md`: add address-only rows for the two closes and FS-84's S1/S1V. Blind verifiers
     never read it.

**Two owner rulings to apply as you go:**
- FS67-CL's grade is "hand, one mind (J40) + a one-step check (J42)".
- "B(n) and A(n) are false for n ≥ 4" is a composition of print, not ours, and not a `CLOSED-QUESTIONS.md` entry.

## Gates (J24's, with these numbers)

- **`CLAUDE.md` under 300,000 bytes.** It stood at 286,449 at J24's close, and these drafts add about 6,200 bytes. If the file would cross
  the limit, stop and report. Never trim a `[PROTECTED]` paragraph.
- **`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS**, with any reviewed ALLOW line stated.
- **`--dupes`** at 11, or report the new count and why.
- **`tools/bib_audit.py`** PASS.
- **`python3 tools/fs71_ledger_b_check.py --strict`** PASS. It fails now on the R88 and FS67 ids; your § B lines fix that.
- **Architecture** PASS (`tools/check_architecture.py`).

Read every exit status directly, never through a pipe.

## Rules

- **Touch only** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md` (only if a close drafted an
  entry for it), the stub files the closes name, `plans/CRUNCH-2026-09-25-INDEX.md`, the post-close inventory's ticks, and your record.
  **Never** touch job records, close records, plans' bodies, or Lean files.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **Commits by explicit path**, subjects "J44: stage n". End commit messages with your harness's attribution lines. Push after each
  commit; never force-push.
- **Budget:** about 300k by the harness's count; hand back by 400k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J44.md`, committed, and by SendMessage
  `to: "main"`, with every gate's result. Keep your turn's final text content-free: "J44 idle; report sent to the owner by SendMessage".

Thank you.
