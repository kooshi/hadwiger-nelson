*Brief for crunch job **J49**: KT-1, FS-100's stage 2 — `[AmbrusEtAl2023]`'s obligation H4 re-checked in ball arithmetic. Opus 5.5,
2026-09-25. Written by the product owner; Kooshi approved installing `python-flint` for it. This is an exact check of an existing certificate,
which the ban allows.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (§ The gate,
"Make the gate fail, and watch it fail" in full; § Building's resource rules), `WORKFLOW.md` and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief.** I'm the product owner.

**If your record `plans/FS100-KT1-ambrus-ball.md` already exists, you are resuming:** continue at the first stage not SAVED.

## The question

`[AmbrusEtAl2023]` bound the plane's measurable independence density, `m₁(ℝ²) ≤ 0.2470`. That bound is an input to:
- T-C and T-C(A) (`plans/R88-derivation.md`);
- row 92's clause at ℚ(√47);
- T-J37-1 (the case with an archimedean part);
- FS-84's A⁺ and SP-Cor;
- T-J38-1/2/3.

J26 re-checked the certificate with our own tool (`plans/PA-ambrus2023-audit.md`, above all Stage 3 and its H4 rows; `tools/j26_ambrus_check.py`). It found:
- the paper's "interval arithmetic" for H4 is grid sampling plus a derivative bound, and that bound omitted chain-rule factors;
- J26 re-derived the Lipschitz constant and checked the covering in double precision, with a worst margin of 2.3·10⁻⁶, "not
  interval-certified".

**Your job is to certify it or break it: evaluate J26's own covering in ball arithmetic.** That means J26's points and its derived Lipschitz
constants, with the Bessel sums in `arb` and every rounding enclosed.

`python-flint` 0.9.0 is installed in `build/venv-flint`, and `arb.bessel_j` exists. It is a regenerable venv; use
`build/venv-flint/bin/python`.

## Stages (save and commit after each: `git commit <paths>`, subject "J49: stage n"; push after each; never force-push)

1. **Read and restate** (~30k): H4's exact obligation as the paper states it and as J26 repaired it, with the repaired Lipschitz constant
   and J26's grid, quoted with addresses. Say what "certified" means here: every grid cell's lower enclosure plus the rigorous Lipschitz
   slack stays above the target.
2. **The ball-arithmetic checker** (~60k): `tools/fs100_kt1_ball.py`. It imports J26's data read-only (never edit `tools/j26_ambrus_check.py`)
   and evaluates each grid point's `W(t)` as an `arb` ball at a precision you justify. Required behaviour:
   - It reports the minimum certified margin, and the cell where it occurs.
   - It exits 0 if certified, 1 if inconclusive (balls too wide to decide), and 2 if violated (a certified margin below zero).
   - Its failure path is louder than its success path.
   - Controls, both directions:
     - plant a Lipschitz constant halved and watch the check go red for that reason;
     - plant a target raised past the true minimum and watch it go red;
     - a faithful run must pass.
   - Bound each plant on both sides.
   - Use `scripts/slot.py` if a run needs over 2 GiB or over 2 minutes.
3. **The run and the verdict** (~30k): `certified` / `inconclusive` / `violated`, with the margin and its enclosure, saved under
   `data/fs100/kt1/`. For `inconclusive`, say what precision or grid refinement would decide it, and run that refinement if it costs minutes.
   Use the FS-100 stub's §6.2 table (`plans/STUB-measure-rigidity-three-fields.md`) to say what your verdict does to each row.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision, and I can only review work I know about.
- **Touch only** `plans/FS100-KT1-ambrus-ball.md`, `tools/fs100_kt1_*.py` and `data/fs100/kt1/`. Never edit a frozen tool, J26's tool, or
  any plan other than your record. A violated H4 is reported, never "fixed".
- Read every exit status from the tool itself, never through a pipe.
- **All novel knowledge is a success** (Kooshi): `violated` is as valuable as `certified`. Do not lean toward either.
- **Commits by explicit path.** End commit messages with your harness's attribution lines. Push after each commit; never force-push.
- **Budget:** about 150k by the harness's count; hand back by 200k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J49.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J49 idle; report sent to the owner by SendMessage".

Thank you.
