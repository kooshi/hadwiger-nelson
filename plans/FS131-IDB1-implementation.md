# FS131-IDB1 — the density bound's first implementer: the `J₀` covering (lane C), then the Bessel lemmas (lane B)

*de Bruijn, the implementer (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-IDB1-covering-bessel.md` (on `main`), with
`plans/STANDING-RULES.md`. Branch `fs131-wdb1`, cut from `fs131-wdb` at `4311c0fe0`; tree `.claude/worktrees/fs131-w10g`. The plan is
the planner's record `plans/FS131-KDB1-density-bound.md` (§ 3.3 per leaf, § 4.2 the kernel cuts, § 5 the lanes). Resuming: read
this file, check its last SAVED stage against `git log -- plans/FS131-IDB1-implementation.md`, continue at the first stage not
SAVED.*

## Theorems this phase proved

(Filled as leaves fall; one line per kernel theorem with its declaration and its axioms.)

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, against their sources (standing rule 3)

Checked mechanically: every `> ` line of the brief searched verbatim in the file its `— source:` line names, and the inline
quotation of W6.

| # | the brief quotes | source | verdict |
|---|---|---|---|
| Q1 | W2 (2026-10-13) "I choose the second form. Any finding of ours must be formalized. …" | `data/fs131/REQUEST-2026-10-13.md` | verbatim |
| Q2 | dated line 2026-10-14 "The density bound has a route with no periodic reduction and no Bessel citation" | `data/fs131/claims-NF2.md` | verbatim |
| Q3 | dated line 2026-10-14 "The certificate's analytic half is priced in the kernel" | `data/fs131/claims-NF2.md` | verbatim |
| Q4 | item 845 "FS131-KDB1 handed back: …" | `plans/FS131-close-inventory.md` | verbatim |
| Q5 | "Yes, prove the density bound." (W6, inline) | `data/fs131/REQUEST-2026-10-13.md` | verbatim (one occurrence) |

No mismatch.

### 1.2 Each leaf of lanes B and C, restated in one line beside its plan (`plans/FS131-KDB1-density-bound.md` § 3.3)

| leaf (module) | what it says | plan |
|---|---|---|
| `J0_eq_integral` (Bessel) | `J0 x = (2π)⁻¹∫₀^{2π} cos(x sin θ)` | `Real.circleAverage_def`, `circleMap 0 1 θ` has `im = sin θ` |
| `J1_eq_integral` (Bessel) | `J1 x = (2π)⁻¹∫₀^{2π} sin θ sin(x sin θ)` | the same |
| `J0_zero`, `J1_zero` (Bessel) | `J0 0 = 1`, `J1 0 = 0` | `Real.circleAverage_const` (`J0_zero` proved in scratch) |
| `abs_J0_le_one`, `abs_J1_le_one` (Bessel) | `|J0 x| ≤ 1`, `|J1 x| ≤ 1` | circle-average monotonicity (`abs_J0_le_one` proved in scratch) |
| `hasDerivAt_J0` (Bessel) | `J0′ = −J1` at every `x` | differentiation under the integral, bound 1 |
| `hasDerivAt_J1` (Bessel) | `J1′ = J0 − J1/x` at `x ≠ 0` | the same, then one integration by parts over a period |
| `continuous_J0`, `continuous_J1` (Bessel) | continuity | from the derivatives; `J1` at 0 by parametric continuity |
| `antitoneOn_norm_Jc` (Bessel) | `x ↦ ‖J0 x + i J1 x‖` antitone on `[0, ∞)` | `‖Jc‖²′ = −2J1²/x`, `antitoneOn_of_deriv_nonpos` |
| `abs_J0_sub_le` (Bessel) | `|J0 x − J0 y| ≤ |x − y|` | mean value with `|J1| ≤ 1` |
| `circleAverage_exp_inner` (Bessel) | `circleAverage (exp(i⟪ξ, ·⟫)) 0 r = J0(r‖ξ‖)` | rotation by `arg ξ`, the sine part integrates to 0 |
| `norm_Jc_sub_le_of_defect` (BesselDefect) | `‖Jc x − p x‖ ≤ ‖Jc a − p a‖ + (x − a)D` on `[a, b]`, `0 ≤ a`, for `p′ = q` on `[a, b]` and defect `≤ D` on `(a, b)` | `HasDerivAt.norm_sq`, a comparison on `√(‖e‖² + κ²)`, `κ → 0`, `a = 0` by a limit |
| `hasDerivAt_Jc` (BesselDefect) | `Jc′ = besselField x (Jc x)` at `x ≠ 0` | the two components |
| `abs_J0_sub_re_le` (BesselDefect) | `|J0 x − w.re| ≤ ‖Jc x − w‖` | `|re| ≤ ‖·‖` |
| `abs_J0_le_of_le` (BesselDefect) | `0 ≤ a ≤ x → |J0 x| ≤ ‖w‖ + ‖Jc a − w‖` | `antitoneOn_norm_Jc` |
| lane C (`BesselCert`, new) | an accepted cell bounds `w₁ + Σ W_k J0(t d_k)` below on its interval and passes valid states on; the covering of `[0, 800]` and the tail give `ϕ ≥ 1 − µ` on `[0, ∞)` | the planner's § 2.1 R4 (a)–(d); the probe `data/fs131/kdb1/probes/CellProbe.lean` restructured (§ 2 below) |

### 1.3 The stored statements, dumped from the built tree before any edit

`data/fs131/idb1/lean/StatementDump.lean` (every constant of `Bessel`, `BesselDefect`, `Window` from the modules' own compiled
data: kind, name, stored type, a definition's stored value), run under the slot against the tree as built for `4311c0fe0`:
`data/fs131/idb1/statements-before.txt` — 24 constants (16 + 5 + 3), none internal. Reader `tools/fs131_idb1_statement_diff.py`;
its self-test (a changed type, a changed value, a removed constant, a new public constant planted in copies of the dump) fires
on all four, the faithful copy reads 0 differences over 24 constants.

## Stage 2 — SAVED: lane C's checker, its soundness, the generator

### 2.1 The checker, restructured from the probe (`Proofs/HadwigerNelson/Plane/DensityBound/BesselCert.lean`, 1,168 lines)

The probe's fused pass (`data/fs131/kdb1/probes/CellProbe.lean`) is split into list functions that each have a one-line
semantics, so that soundness is a chain of short lemmas:

| piece | kernel function | semantics lemma |
|---|---|---|
| polynomials | `addL`, `smulL`, `absL`, `dL` (via `derivAux`), `affX`/`shiftL`, `powScale`, `homogL`, `evZ`, `evF` (forward homogenized Horner) | `ev_addL`, `ev_smulL`, `abs_ev_le`, `hasDerivAt_ev`, `ev_shiftL`, `ev_powScale`, `ev_homogL`, `cast_evZ`, `evF_eq` + `cast_Wh` |
| Taylor recurrence | `taylor` (the probe's, rounded) | none: **no proof reads it**; the soundness holds for any coefficient lists `a = m0 :: ta`, `b = m1 :: tb` |
| one term, one cell | `coreOf` (defect lists `δ₀ = a′ + b`, `δ₁` by `xList`: `C·g + SC·(s g + b)` at `C ≠ 0`, `g + b/s` at `C = 0`), `termOk` | `defect_bound`, then `coreOf_sound` through `norm_Jc_sub_le_of_defect` |
| all terms | `termsOut` | `termsOut_sound` (with `|dₖ − Dₖ/S| ≤ 1/S` and `abs_J0_sub_le`) |
| the cell polynomial | `cellCheck` (re-centred by `shiftL`, homogenized at `K = 2⁸⁵`, quadratic part by `quadOk`, higher part by `evZ` of absolute values) | `quadOk_sound` (endpoints, and the vertex when inside: exact), `cellCheck_sound` |
| states | packed in one `ℕ` per boundary, three 72-bit fields per term (`decode`) | none needed: the checker reads the decoded lists and the soundness is over any lists |
| chain, tail, whole | `Linked`, `chainEnd`, `chainExit`, `tailCheck` | `chain_sound` (on `[start, end)`), `abs_J0_tail` + `tailCheck_sound` (antitone `‖J‖`), `covering_sound` |

The probe's `rnd` of the exit state is no longer checked as an equality: an exit state is accepted when its radius covers
the error plus its distance to `p(c + h)` (`termOk`), so the generator's rounding is untrusted too. `^` on `ℤ` is avoided
in kernel code (under Mathlib it elaborates through `Monoid.npow`, `data/fs131/idb1/probes/Names.lean`): `pw`.

`covering_sound` (generic in the parameters) is the module's headline: an accepted linked chain from `J(0) = (1, 0)` and an
accepted tail give `TN/TD ≤ w₁ + Σₖ Wₖ J₀(t dₖ)` (scaled) for every `t ≥ 0` and **every** list `d` with
`|dₖ − Dₖ/2⁶⁴| ≤ 2⁻⁶⁴`, `dₖ ≥ 0` (`Close`). The module elaborates with no `sorry` of its own; its axioms reach `sorryAx`
only through lane B's leaves (`norm_Jc_sub_le_of_defect`, `abs_J0_sub_re_le`, `abs_J0_sub_le`, `abs_J0_le_of_le`,
`J0_zero`, `J1_zero`). Built: `data/fs131/idb1/build1.log` (exit 0, 2 modules rebuilt, no warning from the file).

### 2.2 The generator (`tools/fs131_idb1_cells.py`) and its reproducibility

`chain` writes `data/fs131/idb1/gen/Chain.lean`, which runs the chain with **the checker's own** `termNext` and `core` in
Lean's compiled evaluator, prints one packed code per boundary, and runs the compiled `cellCheck` of every cell on the
decoded codes: 848 codes, 847 of 847 cells `true` with the encode–decode round trip `true` (22 s, 3.2 GB). `modules`
refuses unless every cell passed and the tail passes, then writes `Cells/Data.lean` (the parameters), 46 parts
`Cells/Part00 … Part45.lean` (cells grouped to a degree sum ≤ 420, 18–29 cells each), `Cells/Covering.lean`. Tail slack
`0.010040` (the planner's 0.0100). **Run twice from the plan file, identical:** the 50 output files' SHA-256 sums
(`data/fs131/idb1/gen/run1.sha256`, `run2.sha256`) agree.

### 2.3 Measured kernel cost, and the plants

`decide +kernel` on two parts elaborated as standalone files (Data's text + the part's, `data/fs131/idb1/probes/Cut00.lean`,
`Cut40.lean`; under the slot at a 4 GiB cap): Part00 (29 cells, degree sum 419) **51.6 s**, RSS 5.10 GB; Part40
(18 cells, degree sum 414, `N = 23`) **61.4 s**, RSS 4.60 GB (Mathlib's mapped `.olean`s are ~3.1 GB of that; neither run
reached its 4 GiB cgroup cap). That is 0.115–0.14 s per unit of degree per cell — the probe's rate (0.118–0.138) — so the
46 parts are ≈ 41 min of kernel CPU.

Plants (`data/fs131/idb1/probes/Plants.lean`), each beside its faithful partner:
- cell 0 with its exit code's first radius one unit smaller → **refused** by the kernel ("decide proved that the
  proposition … is false"); the faithful cell 0 passes;
- cell 58 (`t ∈ [29, 29.25]`, the plan's least margin `4.24·10⁻⁶`) against the target raised to `99995/100000` →
  **refused**; the faithful cell 58 against `99994/100000` passes.

### 2.4 Re-priced from the first two leaves

The planner priced lane C at 900 lines plus a generator; the checker and its soundness came to 1,168 lines (with docs and
the spec examples) and the generator to 289: **1.3×** the plan on lines, the kernel rate as measured. No message owed.
