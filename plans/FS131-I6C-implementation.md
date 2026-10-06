# FS131-I6C — wave 6's bridge, line C: unit-speed curves with 1-Lipschitz tangent (`Curve`), then the local graph off the cusps (`LocalGraph`)

*de Bruijn, the implementer (Opus 5.5), on branch `fs131-w6c` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c`, cut from
`fs131-w6` at `32f2ab4c`. Brief: `data/fs131/briefs/FS131-I6C-wave6-bridge.md` (main tree; its Amendment 1 of 2026-10-06 is part of it).
Started 2026-10-06.*

## Theorems this phase proved

*Filled stage by stage; each line names the declaration, its module, its axioms as printed from the build's oleans, and the entry it was read
against. "Wired" means proved here over a child that is still `sorry` on this branch — not yet a kernel theorem.*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]` (Stage 2; build `data/fs131/i6c/logs/build-1-curve.log`, axioms
`data/fs131/i6c/logs/axioms-1-curve.out`, whose control `c11_discs` reads `sorryAx`), all in `Plane/Saturated/Curve`:
- `HadwigerNelson.Plane.IsUnitCurve.chord` — FS131-E8 § 3.2 (1), the chord bound (C1).
- `HadwigerNelson.Plane.IsUnitCurve.sin_le_inner` — FS131-E8 § 3.3's displayed inequality (C2).
- `HadwigerNelson.Plane.IsUnitCurve.strictMonoOn_dist` — FS131-E8-BETA's "the distance from z is strictly increasing".
- `HadwigerNelson.Plane.IsUnitCurve.norm_sub_le` — FS131-E8 § 3.3's `|γ(s) − z − sT(0)| ≤ s²/2`.
- `HadwigerNelson.Plane.IsUnitCurve.one_le_dist` — FS131-E8-OUTSIDE (the deriver's § 6.3; the planner's assembly).
- `HadwigerNelson.Plane.lipschitzOnWith_of_chord` — the last sentence of the erratum under FS131-E8-LOCAL.
- Children (mine): `IsUnitCurve.sin_add_sin_le` (C1 and C2 as one inequality, at length `ℓ ≤ π`), `IsUnitCurve.hasDerivWithinAt_re_mul`,
  `IsUnitCurve.hasDerivWithinAt_norm_sq`, `IsUnitCurve.abs_sub_le`, `IsUnitCurve.one_le_dist_of_sign`, `two_sin_le_norm_e_sub_e`,
  `lt_mul_of_two_sin_le`, `le_add_of_chord`; `isUnitCurve_circle` (the unit circle, the sharpness example the plan's § 12.2 owed).

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

## Stage 2 — SAVED (FS131-I6C): `Curve`'s six leaves, the unit circle, the re-pricing

### 2.1 What was proved, and by which route

All six leaves of `Plane/Saturated/Curve` are closed; the module has no `sorry`. **No integral is taken** (§ 1.4 item 1, confirmed): each
inequality is the monotonicity on `[0, ℓ]` of one real function whose derivative has a sign, read on the open interval only
(`monotoneOn_of_hasDerivWithinAt_nonneg`, `strictMonoOn_of_hasDerivWithinAt_pos`), so the plan's "hard part" (one-sided derivatives at the ends of
`Icc`) does not arise.

| leaf | route (as proved) | against its entry (verbatim words in quotes) |
|---|---|---|
| `IsUnitCurve.chord` | `sin_add_sin_le` at `u₀ = 0`, `s = ℓ` | E8 § 3.2 (1): "`⟨γ(ℓ) − γ(0), T(0)⟩ … ≥ … sin ℓ`" for "`ℓ ≤ π/2`" — `((γ ℓ − γ 0) * conj (e (ψ 0))).re` is the real inner product with `T(0) = e(ψ 0)`. As stated |
| `IsUnitCurve.sin_le_inner` | `sin_add_sin_le` at `u₀ = s` | E8 § 3.3: "`2⟨γ(s) − z, T(s)⟩ … ≥ … 2 sin s`", `z = γ(0)` — as stated, on the closed interval |
| `IsUnitCurve.strictMonoOn_dist` | `(d/du)‖γ u − γ 0‖² = 2⟨γ u − γ 0, T(u)⟩ ≥ 2 sin u > 0` on `(0, ℓ)`; then the square root | E8-BETA: "the distance from z is strictly increasing" — on `[0, ℓ]`, ends included |
| `IsUnitCurve.norm_sub_le` | `image_norm_le_of_norm_deriv_right_le_deriv_boundary` with `B u = u²/2`; `‖e(ψ u) − e(ψ 0)‖ ≤ u` (`norm_e_sub_e_le`, wave 1) | E8 § 3.3: "`|γ(s) − z − sT(0)| ≤ … ≤ s²/2`" — no bound on `ℓ`, as stated |
| `IsUnitCurve.one_le_dist` | `one_le_dist_of_sign` for `σ = ±1`: `‖γ u − γ 0 − σ i e(ψ 0)‖²` has derivative `2⟨γ u − γ 0, T(u)⟩ − 2σ sin(ψ u − ψ 0) ≥ 2 sin u − 2 sin u` | FS131-E8-OUTSIDE: "stays outside the two open unit discs tangent to it at its starting point" — the planner's three lines, the deriver's § 6.3 |
| `lipschitzOnWith_of_chord` | `le_add_of_chord` for `ψ` and for `−ψ`: the right slopes of `ψ` are eventually below every `r > 1` (`two_sin_le_norm_e_sub_e`, `lt_mul_of_two_sin_le` from `x − x³/6 < sin x`), then `image_le_of_liminf_slope_right_le_deriv_boundary` | the erratum under FS131-E8-LOCAL: "a continuous tangent angle with that property is 1-Lipschitz" — **no subdivision** and no limit of `n · 2 arcsin (d/2n)` (§ 1.4 item 2, confirmed) |

**The one inequality** (`IsUnitCurve.sin_add_sin_le`): for `s, u₀ ∈ [0, ℓ]` and `ℓ ≤ π`,
`sin (s − u₀) + sin u₀ ≤ ⟨γ s − γ 0, e (ψ u₀)⟩` — from `G u = ⟨γ u − γ 0, e (ψ u₀)⟩ − sin (u − u₀)`, `G′ u = cos (ψ u − ψ u₀) − cos (u − u₀) ≥ 0`.

**A generalization, kernel-checked for two of the three** (route note, no defect): `chord` and `sin_le_inner` hold for `ℓ ≤ π`, not only
`ℓ ≤ π/2` — `sin_add_sin_le` is proved at `ℓ ≤ π` and the two leaves are its cases. `strictMonoOn_dist` holds for `ℓ ≤ π` by the same proof
(`sin u > 0` on `(0, π)`); stated at `π` in the next stage as a child, so that it is checked and not claimed. `one_le_dist` does read `π/2` (the
sine's monotonicity on `[−π/2, π/2]`), and `gamma`'s `L ≤ π/2` is from `R ≤ 1/2`, not from these.

**A docstring edited, no statement**: `lipschitzOnWith_of_chord`'s docstring named the route not taken ("subdivide: `2 arcsin (d/2n)` summed over
`n` pieces tends to `d`"); it now names the route taken. The module docstring gained two bullets. The statement check (below) is on statements.

**The sharpness example** (the plan's § 12.2, owed): `isUnitCurve_circle (J) : IsUnitCurve e (fun s => s + π/2) J`, and two `example`s: on the
unit circle `chord`'s and `sin_le_inner`'s right-hand sides are exactly `sin s`, and the distance to the centre `γ 0 + i e(ψ 0) = 0` of one of
the two tangent discs is exactly `1`.

### 2.2 Checks

- **Build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` — OK, 466 of 466 batches, 4 modules rebuilt (`Curve`,
  `LocalGraph`, `FanBridge`, `Proofs`), exit 0 (`data/fs131/i6c/logs/build-1-curve.exit`; `build-1-curve.log`;
  `build/gate/build/20261006T145204Z-752120.log`). Warnings: 25, every one `declaration uses sorry` — `LocalGraph` 5, `FanBridge` 12, `Pinch` 7,
  `MapColouring` 1; **`Curve` none** (31 − 6).
- **Axioms** (`data/fs131/i6c/I6cAxioms.lean`, run with `lake env lean` on the build's oleans; output `logs/axioms-1-curve.out`): the control
  `c11_discs` prints `[propext, sorryAx, Classical.choice, Quot.sound]` — the reader reports `sorry` where there is one — and each of the fifteen
  declarations of this stage prints `[propext, Classical.choice, Quot.sound]`. The fifteen lines are in `scripts/Axioms.lean`'s new block
  "FS131-I6C", above the `=== PURCHASED ===` banner.
- **Statements** (`tools/fs131_i6c_statements.py`, against `32f2ab4c`; `logs/statements-2.out`): 16 of 16 the same, no `axiom`, no
  `native_decide`; with one character altered (`--plant`, `logs/statements-plant.out`) it reports the changed declaration and exits 1.
- **Names**: each new name grepped over `Proofs/` and `scripts/` before it was added (0 hits each); `norm_e_sub_e_eq` exists in
  `Plane/ValidMap`, which `Curve` does not import, so the chord inequality is stated under a name of its own, `two_sin_le_norm_e_sub_e`
  (an inequality, not that equality).

### 2.3 The re-pricing (the brief's item 2)

The plan priced `Curve` at 2.5 agent-days (20 h): 4, 3, 3, 2, 3, 5 h. As done: the six leaves, eight children and the circle in **six
elaborations** of 2.5 s each and one build — well under an hour of work. The plan expected its computational prices "high by a factor of two to
three"; **they are high by more than ten** (Z2 met). For what is left, re-priced from these: `LocalGraph`'s three small leaves (10.5 h in the
plan) — about an hour; `local_graph`'s children (a)–(g), (i) (27 h in the plan) are of the same computational kind and I price them at half a
day together; (h), the curve by arclength (2 d in the plan), is the one I do not re-price down from these leaves — its difficulty is a missing
construction (an arclength reparametrization), not a computation — and it carries the width.
