*Brief for crunch job **J15**, milestone M2 (FS-39 route C, `plans/STUB-plane-bridge.md` phase B′), kernel. Opus 5.5, 2026-09-25. Written by
J04 (`plans/M2-kernel-lane.md` §S).*

Hello. You are de Bruijn (`DEBRUIJN.md`), the kernel engineer for FS-39's route C, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`,
`WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** No
children: do not use the Agent tool, a fork or a workflow (delegation is one level deep; staffing is Kooshi's budget decision and the owner can
only review work it knows about). **If your record already exists, you are resuming: read it and the brief, check the last SAVED stage against
`git log -- <record>`, and continue at the first stage not SAVED. Redo nothing saved.**

## The question, and why now
Transcendence is free: `χ(F(t)²) = χ(F²)` for `t` transcendental over `F ⊆ ℝ` (`[Fischer1990]` Thm 6; `CLAUDE.md` G63). A half-day kernel
theorem whose two generic leaves J04 already closed, and the valuation-theoretic half of FS-39's bridge. **Every outcome counts** (rule 4): the one
hard leaf, named with its obstruction, is a result.

## The statements (verbatim)
- G63 (`CLAUDE.md`): "For any `F ⊆ ℝ` and any `t` transcendental over `F`, **`χ(F(t)²) = χ(F²)`**." Fischer's Thm 6 (held PDF, p. 188): "F^d
  can be k-colored (has an additive k-coloring) iff F(α)^d can".
- The Lean statements: `data/m2/j04/K2Transcendental.lean` (elaborates today; `planeOverIso` and `unitQuadrance_colorable_of_subring` closed), as
  refined by `plans/M2-kernel-lane.md` §4.4: **the core theorem is `chromaticNumber_unitQuadrance_ratFunc {F} [Field F] [IsFormallyReal F]`**
  (inhabitant `F = ℚ`, free); the `Subfield ℝ` form `chromaticNumber_planeOver_adjoin_transcendental_eq` its corollary, the adjunction defined with
  no proof argument; the Liouville inhabitant (π's transcendence is not in Mathlib).

## Read first, from disk
`plans/M2-kernel-lane.md` §2.1–2.2 (**`colorable_unitDistance_induce_of_valuationSubring` does not fit: its colours are a finite ring's elements;
the route is `cosetResidue` + `unitQuadrance_colorable_of_ringHom`**), §3.2, §4.4 obligation item 3 (the general valuation lemma, 15 lines, and the
one named leaf: a residue ring hom `B →+* F` from the `X`-adic valuation subring of `RatFunc F` whose kernel is `B.nonunits`). Mathlib:
`RingTheory/LaurentSeries.lean` (`polynomialValuationX`, `powerSeriesRingEquiv`, `coe_coe`), `FieldTheory/RatFunc/Basic.lean` (`liftRingHom`,
`liftRingHom_injective`), `Algebra/Ring/IsFormallyReal.lean`, `RingTheory/Valuation/ValuationSubring.lean`.

## Fenced
Nothing is fenced from you.

## Stages
1. The quotation check; C0 (P-J15a–b of §P); **price the residue-hom leaf from its first two sub-leaves** by two routes — (i) through
   `powerSeriesRingEquiv` and `PowerSeries.constantCoeff`, (ii) through polynomials and `Polynomial.X_dvd_iff` — and pick the cheaper (~60k). Save.
2. `Proofs/HadwigerNelson/Transcendental.lean`: the two closed leaves moved in; the general valuation lemma; the residue hom; the core theorem with
   `F = ℚ` as inhabitant (~120k). Save.
3. The `Subfield ℝ` corollary, the adjunction and its lift equivalence, the Liouville inhabitant, a planted fault watched red (e.g. the valuation
   lemma with `IsFormallyReal` removed must fail to elaborate) (~80k). Save.
4. The gate, the module map, the report (~40k).

## Kernel lines (verbatim, every kernel brief)
- "Build only as `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, never `lake build`; iterate with
  `scripts/slot.py --mem <measured> --cpus 4 -- lake env lean <file>` (it builds nothing, and does not apply the lakefile's options:
  `autoImplicit` is off only in the real build)."
- "On a slot refusal (exit 75), wait ten minutes and retry; never raise a cap."
- "The gate: the build green, zero `sorry`, `./scripts/axioms.sh` and `./scripts/vacuity.sh` green with their counts reported, an inhabitant per
  structure hypothesis, a spec example per definition."
- "Prose in any module a certificate imports is written as `--` comments."
- "You are the only kernel job running; the owner starts the next one when you report."

Also: new module only; add it to `Proofs.lean`, `ARCHITECTURE.md`'s module map (`python3 tools/check_architecture.py`) and `scripts/Axioms.lean`.
Measured iteration peak 3.4 GB. No solver, no `native_decide`; keep the "would have searched here" log. `χ(ℚ²) = 2` is **not** in the kernel (row
63): do not claim `χ(ℚ(L)²) = 2`; the inhabitant is the equality with `χ(ℚ²)`.

## Record and paths
Record: `plans/M2-S2K-route-c.md`, with "Theorems this phase proved". Working files: `data/m2/j15/`. Budget 300k (harness); hand back by 420k. Stop
rule: at 2 hours without the residue hom, land the core theorem with that hom as an explicit hypothesis (DECLARED if uninhabited) and report GAP at
that leaf, the obstruction named. Report (rule 9) to `data/crunch-2026-09-25/reports/J15.md`, SendMessage to `"main"`.
