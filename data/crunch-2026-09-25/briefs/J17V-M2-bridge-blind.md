*Brief for crunch job **J17V** (optional, P3), milestone M2 (FS-39's hand step), blind verifier. Opus 5.5, 2026-09-25. Written by J04
(`plans/M2-kernel-lane.md` §S) before any claim exists.*

Hello. You are de Bruijn (`DEBRUIJN.md`), a blind verifier, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from
disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No children (delegation is one level deep;
staffing is Kooshi's budget decision). **If your record already exists, you are resuming: read it and the brief, check the last SAVED stage against
`git log -- <record>`, and continue at the first stage not SAVED.**

## The question
Are these four statements true, and by what argument? Derive each from the statements alone. **Every outcome counts** (rule 4): FALSE with a
counterexample or GAP at a named step is as valuable as TRUE.

## The statements (verbatim; the fixed list)
- **C1** — "For every finite graph `H` and every map `f : V(H) → ℝ²` with `‖f(x) − f(y)‖ = 1` on every edge, there is a real number field `F` and a
  map `g : V(H) → F²` with `‖g(x) − g(y)‖ = 1` on every edge." (Non-injective `g` allowed.)
- **C2** — "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, the chromatic number of `F²` meaning that of the unit-distance graph on `F × F`."
- **C3** — "`[Fischer1990]` Remark 1's first sentence is false: there is a finitely generated field `E ⊂ ℝ` over `ℚ` that is not a purely
  transcendental extension of any finite algebraic extension of `ℚ`." (With an explicit `E`.)
- **C4** — "`χ(ℝ²) ≠ 6` if and only if every real number field `F` with `χ(F²) = 6` has a finite extension `F′ ⊂ ℝ` with `χ(F′²) = 7`", given C2.

## Read first, from disk
`[Fischer1990]` §2 (held PDF, `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`); `CLAUDE.md` § Notation. Any textbook on real algebra you
can reach.

## Fenced until your verdicts are committed
`plans/M2-S1D-bridge.md` (J17's record), `data/m2/j17/`, `data/crunch-2026-09-25/briefs/J17-M2-bridge-derivation.md`, `plans/M2-kernel-lane.md` §2.3,
§4.1–4.4, `plans/M2-close-inventory.md`, `plans/STUB-plane-bridge.md`, `CLAUDE.md` G63–G64, `[Madore2015]`, and every commit whose subject names J17.

## Stages
1. The quotation check; C0 (a probability per claim); the blind derivations; verdicts TRUE / FALSE / GAP-at-step, committed (~100k). Save.
2. After committing, read J17's record and write a divergence table (route, scope, truth) (~40k). Save and report.

## Record and paths
Record: `plans/M2-S1V-bridge.md`. Budget 150k (harness); hand back by 200k. Report (rule 9) to `data/crunch-2026-09-25/reports/J17V.md`,
SendMessage to `"main"`.
