# FS131-I6C — wave 6's bridge, line C: unit-speed curves with 1-Lipschitz tangent (`Curve`), then the local graph off the cusps (`LocalGraph`)

*de Bruijn, the implementer (Opus 5.5), on branch `fs131-w6c` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c`, cut from
`fs131-w6` at `32f2ab4c`. Brief: `data/fs131/briefs/FS131-I6C-wave6-bridge.md` (main tree; its Amendment 1 of 2026-10-06 is part of it).
Started 2026-10-06.*

## Theorems this phase proved

*Filled stage by stage; each line names the declaration, its module, its axioms as printed from the build's oleans, and the entry it was read
against. "Wired" means proved here over a child that is still `sorry` on this branch — not yet a kernel theorem.*

(none yet — Stage 1 is the readback)

## What I may and may not change (the brief's `touches:` and § Done means, item 4)

- **May**: the proofs of the eleven leaves of `Proofs/HadwigerNelson/Plane/Saturated/Curve.lean` (six) and `.../LocalGraph.lean` (five); new
  helper declarations in those two files, under names no other module declares (checked by grep over `Proofs/` before each is added; the join's
  `dupnames.sh` is the gate's); a new module of my own beside them, with its line in `Proofs.lean` and `ARCHITECTURE.md`; a block headed
  "FS131-I6C" in `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i6c_*.py`; `data/fs131/i6c/`;
  `data/fs131/reports/FS131-I6C.md`.
- **May not**: any statement or definition (`IsUnitCurve`, `IsInterfaceChart`, the eleven theorem statements — checked against `32f2ab4c` at
  every saved stage by `tools/fs131_i6c_statements.py`); `Basic`, `Pinch`, `MapColouring`, `Fan`, `FanExamples`, `FanBridge`; the planners' record;
  any landed module beyond new declarations; `main`; no `axiom`, no `native_decide`; no merge of another branch; the gate is not mine to run.
- **Rest on, as stated** (another implementer's leaves, `sorry` on this branch): `c11_discs`, `TwoColourOn.essBoundary_inter_eq` (`Pinch`). A
  theorem of mine that uses one is *wired*, and its axioms print shows `sorryAx` until the join.

## Stage 1 — SAVED (FS131-I6C): the readback, the as-given build

### 1.1 The brief's quotations against their sources (standing rule 3)

By script (`tools/fs131_i6c_quotes.py`: exact substring match of each `>`-block against the file its `— source:` line names; it exits 2 if the
brief holds no quotation, so an empty read cannot pass; output `data/fs131/i6c/logs/quotes.out`): **24 quotations, 24 exact, 0 mismatched**,
exit 0. With one character of the first quotation altered (`--plant`) it reports 1 mismatch and exits 1 (`quotes-plant.out`). No finding about the
brief.

### 1.2 Read, in order

The brief with its amendment; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` §§ Building, Make the gate fail; the planners' record
`plans/FS131-w6-kernel-plan.md` Stages 8–12 whole (§ 9 for the foundation; §§ 11.3–11.5, 12.1–12.2 for my leaves); the deriver's record
`plans/FS131-E8-derivation.md` (main) §§ 3.1–3.7 with the erratum under § 3.1 and the note under FS131-E8-FAN, and Stage 6 whole (§ 6.3 is the
check of `one_le_dist`, § 6.4 of the planner's `3.5δ`, § 6.5 the read-backs — `local_graph`'s `bdry` is about `essBoundary A`, "a line the
colouring form owes"); inventory items 499, 501, 502; the modules `Plane/Saturated/Basic`, `Pinch`, `Curve`, `LocalGraph` whole, and `Plane/Chord`,
`Plane/Cover`, `Plane/UnitPairs`, `Plane/AeColouring` for the definitions the leaves read. **Not yet read**: `Fan`, `FanExamples`, `FanBridge`
(read where a leaf needs them: `notMem_essClosure_of_mem_densitySet` lives in `Fan`, which `LocalGraph` does not import — see § 1.4).

### 1.3 The branch builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1804 modules already up to date, nothing built, 5
modules with warnings**, exit 0 (read from the file the driver wrote, `data/fs131/i6c/logs/build-0-as-given.exit`; log
`build-0-as-given.log`; `build/gate/build/20261006T144523Z-729186.log`). Every warning is `declaration uses sorry`: **31** — `Curve` 6,
`LocalGraph` 5, `FanBridge` 12, `Pinch` 7, `MapColouring` 1. Eleven are mine.

### 1.4 What the readback found before any proof was written

1. **`Curve`'s six leaves need no integral.** The plan's routes are integrals of cosines (`intervalIntegral.integral_eq_sub_of_hasDeriv_right`,
   with one-sided derivatives at the ends of `Icc` named as the hard part). Each inequality is instead the monotonicity of one auxiliary real
   function on `[0, ℓ]` whose derivative has a sign (`monotoneOn_of_hasDerivWithinAt_nonneg`, which reads the derivative on the interior only), so
   the end-point derivatives are never read. Registered before writing: **C1 and C2 are one lemma** —
   `sin (s − u₀) + sin u₀ ≤ ⟨γ s − γ 0, e (ψ u₀)⟩` for `s, u₀ ∈ [0, ℓ]`, from `G u = ⟨γ u − γ 0, e (ψ u₀)⟩ − sin (u − u₀)`,
   `G′ u = cos (ψ u − ψ u₀) − cos (u − u₀) ≥ 0` — and **it reads `ℓ ≤ π`, not `ℓ ≤ π/2`** (a route note, to be confirmed by the proof: the
   statements' `π/2` is then stronger than `chord` and `sin_le_inner` need; `one_le_dist` does read `π/2`, for the sine's monotonicity).
2. **`lipschitzOnWith_of_chord` without subdivision**: the plan's route sums `2 arcsin (Δ/2)` over `n` pieces and takes `n → ∞`. Planned
   instead: `image_le_of_liminf_slope_right_le_deriv_boundary` (Mathlib's comparison for a continuous function whose right slopes are frequently
   below `r` for every `r > 1`) with `B x = ψ u + (x − u)`; the slope bound from `‖e a − e b‖ = 2 |sin ((a − b)/2)|` and
   `x − x³/4 < sin x` near `0`. To be confirmed by the proof.
3. **`notMem_essClosure_of_mem_densitySet` is in `Plane/Saturated/Fan`**, which `LocalGraph` does not import (the plan's row says "import
   it"). `Fan` is not mine to edit and an import line is not a statement; if the three small leaves need it I add the import to `LocalGraph`
   (its consumer `FanBridge` already imports `Fan` through `FanExamples`, so no cycle), and say so in the stage.

### 1.5 Registered expectations (before the first proof)

| # | expectation | probability / interval |
|---|---|---|
| Z1 | `Curve`'s six leaves close in this job, with no statement defect | 0.9 |
| Z2 | the plan's price for `Curve` (2.5 d = 20 h) is high by a factor of at least five by my count of elaborations | 0.7 |
| Z3 | `LocalGraph`'s three small leaves close in this job | 0.85 |
| Z4 | `local_graph` closes in this job (over `c11_discs` and `essBoundary_inter_eq` as statements) | 0.35; if not, children (a)–(g) stated and proved and (h), (i) left with a work list: 0.4 |
| Z5 | a statement defect among my eleven (a hypothesis missing, not a route note) | 0.2; the likeliest: `IsInterfaceChart.sides` or `.bdry` against what the square gives (the chart `Q` must be chosen so that `Q ∖ γ` is exactly two connected open sets); `local_graph`'s `hsatA`/`hsatB` against `c11_discs`' contact hypotheses |
| Z6 | `TwoColourOn.disj` is read in `local_graph` at exactly one step (the amendment's question) | 0.6 |
