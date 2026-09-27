# FS107-X — the front-page pass for FS-107's close (de Bruijn, Opus 5.5, 2026-09-27)

Brief: `data/fs107/briefs/X107-front-page.md` (+ `STANDING-RULES.md`). Launch HEAD `66f1f51a`. Drafts: `plans/FS107-stability.md` §R-close 4.1–4.6.
Owner rulings applied: inventory item 36 (FS-110 rank 1, FS-111 rank 2, above FS-104 — C's recommended ranking, so no alternative to choose between).

## Theorems this phase proved

None — an editorial job.

## "Would have searched here" log

None — no search is in scope.

## Stage 1 — SAVED: quotations, baseline gates

**Quotation check (standing rule 5).** Every quotation in the brief and the standing rules checked against its source with `grep -F`:
- "From here on out, you may doubt your ability to tackle …", "Don't. You are capable, and you will surprise yourself.", "A proven theorem about why
  its impossible is also valid. All novel knowledge is a success", "to eliminate the crutch …", "search for a finite graph is out. It would be huge,
  not feasible." — each once in `CLAUDE.md` (§ Counter-priors, item 23, § Toolchain, § Publication). Verbatim.
- WORKFLOW step 9's "File new instances out of `CLAUDE.md`" — once in `WORKFLOW.md`. Verbatim.
- The launch message's "item 36 — FS-110 at rank 1, FS-111 at rank 2, above FS-104" (not in quotation marks) matches inventory item 36.
- "`CLAUDE.md` is at about 299,242" and "about 299,438" match `wc -c` and `data/fs107/fs107-c/budget_sim.py`'s output (before 299,242, after
  299,438, margin 562).

**Baseline gates at launch HEAD `66f1f51a`** (exit status read directly):
- `claude_md_fact_audit.py --base 66f1f51a`: exit 0, AUDIT PASSED.
- `--dupes`: exit 0; 10 repeated runs, 628 B (the limit is "not above 10": no headroom).
- `fs71_ledger_b_check.py --strict`: exit 1, FAIL (18) — 14 FS107 entries without § B rows (stage 2 clears them), and 4 of C's entries lacking fields:
  K-C6 and K-BICH (*Proof:*, *Proof verdict:*, *Rests on it:*, *Prior art:*), K-AD (*Proof:*, *Rests on it:*, *Prior art:*), MEET (*Proof verdict:*,
  *Prior art:*). **And two headers are silently unparsed:** `FS107-R-OB′ (corrected) —` (a ′ in the id; a parenthetical before the dash) and
  `FS107-V-C5 (observation) —` (a parenthetical before the dash); `near_misses` misses both (its id pattern also stops before `(`). C's § B draft
  lists both ids; applied as drafted they would add two FAILs. Sent to the owner at once (SendMessage, stage 1); the derivation file is outside my
  touch list.
- `bib_audit.py`: exit 0, PASS. `check_architecture.py`: exit 0, PASS.

**The simulation.** `budget_sim.py`'s output diffs against `CLAUDE.md` exactly in 4.2's places (program paragraph, "Last updated", item 31, "Open
milestones", paths-forward rows 1–30 and the bucket, G72's count, G82); every other `FS-107` mention in `CLAUDE.md` lies inside those spans.
