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
