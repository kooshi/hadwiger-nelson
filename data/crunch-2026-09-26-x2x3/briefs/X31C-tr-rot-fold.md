*Brief for job **X31C**: the follow-on fold of X27D and X27V (TR-ROT) — close-math and front page in one small job. Opus 5.5, 2026-09-26.
Written by the product owner. Templates: X29C's brief (`X29C-close-math-wave3.md`) and X30F's (`X30F-front-page-wave3.md`); read both. Launch
only after X30F has handed back (it edits the same files).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the close planner and front-page editor for one small result, in `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md`, `WORKFLOW.md` (step 9) and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief.**
If your section below exists in the plan, you are resuming.

## What landed (read the two reports, then the records at exact scope)

`data/crunch-2026-09-26-x2x3/reports/X27D.md` and `X27V.md`; `plans/FS100-X27D-derivation.md`, `plans/FS100-X27V-verification.md`. In short:
TR-ROT is GAP at one named step, NA₀ ("no non-zero finite E-null measure on `R̂` has all its `U`-Følner averages converging onto `T₄`", pure
dynamics of `U ↷ R̂`; X27V's COL-E is the same step in measure form, and NA₀ ⟹ COL-E); given MR, TR-ROT is all of Q-μ at the type-(B) fields
(X27D-EQ = X27V-EQ, blind); **X27D-E = X27V-TA+FS**: given MR, every translation-invariant random four-colouring has `σ_μ(E ∖ T₄) = 0`, so
T-C′'s (R1) is closed given MR; X27D-ATT (the counterexample's shape); X27D-SIERP (the two-summand combinatorial route is false); X27V-PM.

## The owner's rulings (apply them)

1. X27D-E / X27V-TA+FS is graded **two derivations, blind** (X27V derived it before opening anything fenced, and re-derived X27D's SPL step at
   its stage 4), given MR and X22D-QR.
2. The flip (TR-ROT-flip) is **retired** as equivalent to TR-ROT (X27D-FL, X27V-F2); not re-posed.
3. NA₀ goes in as **a line** in FS-100's stub (`plans/STUB-measure-rigidity-three-fields.md`, the J38 block) and in FS-98's
   (`plans/STUB-ultrametric-continuation.md`, beside T-B1 and TR-ROT), not as a stub of its own.
4. **An owner slip for the record:** the owner's X27 briefs posed the flip without X22V's qualifiers "affine, `U`-invariant", which made it
   vacuous — a G21 instance (a paraphrase that empties a claim). Add it to G21's instance list in one clause.
5. G79's data point (both minds; X27D §3.4, X27V's held item): X27D-E came from an example invariant; the flip's counterexample-invariant form
   gave only an equivalence. Add it to G79's record in one clause.

## Outputs

- **Derivation entries** in `plans/FS100-derivation.md` (a new §5, home FS100, the entry form `tools/fs71_ledger_b_check.py`'s `ENTRY_RE`
  parses — read it first), one per theorem: X27D-EQ, X27D-E, X27D-ATT, X27D-FL, X27D-SIERP, X27V-PM (and X27V-R1 as a corollary line in X27D-E's
  entry), with grade, proof address, what rests on it, prior art ("not searched; home discipline: homoclinic points of algebraic actions,
  `[LindSchmidt1999]` reviews only, unread" — logged as a prior-art debt), kernel decision (declined: no entropy in Mathlib).
- **A short §R-close (stage 5, wave 3b)** in `plans/FS100-three-field-lemma.md`: verdicts, the rulings above, predictions scored (both C0
  tables), the ban log, slips (X27V's two disclosed; the owner's).
- **Front page:** one `LEDGER.md` row (next number after X30F's last) for X27D-E and NA₀; the § B lines; corrections to rows 88/113 or
  item 24's text where X30F's text says "TR-ROT under attack" (replace with the verdict); `plans/R88-derivation.md` §G T-C′'s line ((R1)
  closed given MR); the two stub lines; G21 and G79 clauses; `plans/FRONTIER-STUBS.md` rows for FS-100 and FS-98; the wave-3 inventory
  (`plans/FS100-x2x3-wave3-close-inventory.md`): append the two reports' INVENTORY lines and tick every one.
- `CLAUDE.md` has no byte budget during this crunch; compress nothing.

## Gates (exit statuses read directly)

`python3 tools/claude_md_fact_audit.py --base <HEAD at your launch>` PASS (any reviewed ALLOW line stated with its reason); `--dupes` at the
launch count or explained; `python3 tools/fs71_ledger_b_check.py --strict` PASS; `python3 tools/bib_audit.py` PASS;
`python3 tools/check_architecture.py` PASS.

## Rules

- **Touch only** the files named above. Never Lean files, `scripts/`, `ARCHITECTURE.md`, other jobs' records or tools.
- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- No finite-witness search (the ban); keep the "would have searched here" log.
- Commits by explicit path, subjects "X31C: stage n", never amend, push after each commit (on a ref-lock race, `sleep 4` and retry), never
  force-push; end with your harness's attribution lines.
- **Budget:** about 150k by the harness's count; hand back by 220k.
- Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X31C.md` and by SendMessage to "main", with every gate's result and
  `CLAUDE.md`'s byte count. Final turn text: "X31C idle; report sent to the owner by SendMessage".

Thank you.
