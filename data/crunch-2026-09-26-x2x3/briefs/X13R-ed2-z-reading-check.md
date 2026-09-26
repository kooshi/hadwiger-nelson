*Brief for job **X13R**: a reading check of two results of X03D. Opus 5.5, 2026-09-26, 06:04. Written by the product owner. Not blind: you
read the proofs. **Hard stop: 11:50 UTC.***

Hello. You are Coxeter, a checker, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` and `DEBRUIJN.md`
from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full.** If your record exists, you are
resuming: continue at the first stage not SAVED.

## What to check

In `plans/FS100-X03D-derivation.md`: the theorems table rows **X03D-ED2** and **X03D-Z** (lines 18–19), and their proofs in **§4 (Stage 4,
§4.1–§4.4)**; the claim ED-2 and the hypothesis of ED-1 are quoted there verbatim in §1.1 (from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2).
The exact check is `tools/x03d_*.py` (whichever the record names for ED-2).

1. **X03D-ED2 (ED-2 FALSE).** Check, step by step: that `χ_{P′}` is a well-defined character of `R = ℤ[U_ℚ]`; that it lies outside
   `E = ⋃_S (T + A + Fin_S)`; and the Weyl-limit computation `∏_{P′}(1 − 1/p) ≠ 0`, including the "one classical equidistribution input" —
   name that input exactly and say whether it is correctly stated and applicable. Read the exact tool: does its plant fire for the right
   reason, and does its check test the claim or something adjacent (G21)?
2. **X03D-Z.** Check that no `U`-invariant finite measure off `T + A` charges the summable set `Z`, step by step, including its use of R-U's
   wandering-set argument.

Per result: **VALID**, **FAILS at a named line** (quote it), or **UNDECIDED at a named step**. Every outcome counts (standing rule 4); do not
lean toward VALID. One stage per result, saved; then the report.

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- The ban on finite-witness search holds (to 2026-10-01); keep a "would have searched here" log. Exact checks of seconds are fine.
- Record `plans/FS100-X13R-check.md`, with "Theorems this phase proved" (likely none: a check). Touch nothing else but your record, your report
  and `tools/x13r_*.py` if you write a check (with a plant watched firing).
- Commits by explicit path, subjects "X13R: stage n", never amend, push after each commit (on a ref-lock race, `sleep 4` and retry), never
  force-push; end with your harness's attribution lines.
- **Budget:** about 120k by the harness's count; hand back by 180k.
- Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X13R.md`, committed, and by SendMessage to "main"; final turn text "X13R idle;
  report sent to the owner by SendMessage".

Thank you.
