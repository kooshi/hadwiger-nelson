*Brief for job **X22V** (wave 3): a blind verifier for list X22 (the type-(B) fields given MR, and SEL-k). Opus 5.5. Written by the crunch
planner. **Sized for about 45 minutes and 220k harness tokens.** A derivation job works on the same claims; never contact it.*

Hello. You are Coxeter, a verifier, in `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** Its clock is replaced here: **your stop time is 12:30 UTC.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X22V-verification.md`.

## Blind — the fences (until your stage 3 is committed)

Do not open: `plans/FS100-X22D-derivation.md`, `data/fs100/x22d/`, the brief `X22D-*.md`, the reports `data/crunch-2026-09-26-x2x3/reports/X2*.md`,
the advisor's record `plans/POROS-2026-09-26-x2x3-crunch.md`, **`plans/FS100-X03D-derivation.md` §3.2's proof of FL-K** (its statement is open),
and the bodies of commits whose subjects start "X22D" or "X23 advisor". Everything else is open.

## The claims

Copy §7's first paragraph and **list X22** from `plans/CRUNCH-2026-09-26-x2x3-queue.md` (C-0 to C-4, SEL-k, with the quoted inputs) into your
record first, verbatim. **Verified inputs, by statement:** MR(F) at §7's scope; T-J38-1 to -3 (stub §2); rows 67, 88, 90–92, 111, 112
(Theorem C); J45's lemma statements.

## Stages

1. Quotation check; C0 per claim. Save.
2. Blind derivation: C-0, then C-1 (name the step of T-J38-2 that used T-B1, and whether MR with Theorem C replaces it for invariant
   measures), C-2, C-3, C-4 (at most 20 minutes; say what a wrong-reason pass would look like), then SEL-k with FL-K derived blind. Save.
3. The write-up, with a verdict per claim; commit **before** opening anything fenced. Save.
4. Fallback (only after stage 3): X22D's lemma statements, not proofs. Save; the report.

**Stop rule:** at 200k harness tokens or 12:30 UTC, finish the current claim, save, report. Do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The ban** (standing rule 3); keep a "would have searched here" log. Exact arithmetic of seconds that checks a derived claim is in.
- **Record** `plans/FS100-X22V-verification.md` with "Theorems this phase proved"; working files `data/fs100/x22v/`; checks `tools/x22v_*.py` with plants watched firing.
  Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the stub or the queue; propose edits in your record.
- **Commits:** by explicit path, subjects "X22V: stage n"; never amend; push after each commit; never force-push.
- **Report** (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X22V.md`, committed, and by SendMessage to "main". Final turn text:
  "X22V idle; report sent to the owner by SendMessage".

Thank you.
