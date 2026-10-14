# FS131-IDB2 — the density bound's second implementer: the Fourier side (lane F), the patterns and the window (lane P), the instance and the theorem (lane X)

*de Bruijn, the implementer (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-IDB2-fourier-window-x23.md` (on `main`), with
`plans/STANDING-RULES.md`. Branch `fs131-wdb2`, cut from `fs131-wdb1` at `c180a0f33`; tree `.claude/worktrees/fs131-w10g`. The plan
is the planner's record `plans/FS131-KDB1-density-bound.md` (§ 3.3 per leaf, § 5 the lanes); the first implementer's record is
`plans/FS131-IDB1-implementation.md`. Resuming: read this file, check its last SAVED stage against
`git log -- plans/FS131-IDB2-implementation.md`, continue at the first stage not SAVED.*

## Theorems this phase proved

(Filled as leaves fall; none yet.)

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, against their sources (standing rule 3)

Checked mechanically: every `> ` line of the brief searched verbatim in the file its `— source:` line names (on `main`), and
the inline quotation of W6.

| # | the brief quotes | source | verdict |
|---|---|---|---|
| Q1 | W2 (2026-10-13) "I choose the second form. Any finding of ours must be formalized. …" | `data/fs131/REQUEST-2026-10-13.md` | verbatim |
| Q2 | dated line 2026-10-14 "The density bound has a route with no periodic reduction and no Bessel citation" | `data/fs131/claims-NF2.md` | verbatim |
| Q3 | dated line 2026-10-14 "The certificate's analytic half is priced in the kernel" | `data/fs131/claims-NF2.md` | verbatim |
| Q4 | item 845 "FS131-KDB1 handed back: …" | `plans/FS131-close-inventory.md` | verbatim |
| Q5 | item 866 "FS131-IDB1 handed back: …" | `plans/FS131-close-inventory.md` | verbatim |
| Q6 | "Yes, prove the density bound." (W6, inline) | `data/fs131/REQUEST-2026-10-13.md` | verbatim (one occurrence) |

No mismatch.

### 1.2 Each leaf of lanes F, P and X, restated in one line beside its plan (`plans/FS131-KDB1-density-bound.md` § 3.3, § 3.3's typed block)

| leaf (module) | what it says | plan |
|---|---|---|
| `autocorr_eq_zero_of_norm_eq_one` (Autocorr) | a 1-avoiding `E` has `vol(E ∩ (E − z)) = 0` for `‖z‖ = 1` | proved in scratch (`data/fs131/kdb1/leaves/Leaves.lean`, 8 lines): fold in |
| `circleAvg_autocorr_one` (Autocorr) | the circle average of `autocorr E` at radius 1 is 0 | `Real.circleAverage_congr_sphere` with the leaf above |
| `circleAvg_autocorr_zero` (Autocorr) | at radius 0 it is `(vol E).toReal` | the circle of radius 0 is the point `0`; `autocorr E 0 = vol E` |
| `continuous_autocorr` (Autocorr) | `autocorr E` is continuous for measurable `E` of finite measure | `tendsto_measure_symmDiff_preimage_nhds_zero`, `|vol A − vol B| ≤ vol(A Δ B)` |
| `sum_circleAvg_autocorr_nonneg` (Autocorr) | if `Σ c_k J₀(t r_k) ≥ 0` for every `t ≥ 0`, then `Σ c_k F̊(r_k) ≥ 0`, for bounded measurable `E` | Gaussian regularization, Fubini, `circleAverage_exp_inner`, `ε → 0` |
| `DualCert.window_bound` (Pattern) | a valid certificate gives `(Σw₁) vol E + Σ w₂ F̊(|X i − X j|) ≤ bound · vol B(x₀, R + D)` | the pattern expectation over `y ∈ ℂ` and `O(2)` |
| `trivialCert_valid` (Pattern) | the one-point certificate is valid | `decide` on `Fin 1`, `simp` |
| `DualCert.window_le` (Window) | `(1 − µ) vol E ≤ bound · vol B(x₀, R + D)` | `sum_circleAvg_autocorr_nonneg` on `w₂.length + 2` terms, `window_bound`, the two circle averages |
| `DualCert.limsup_le` (Window) | the `limsup` of the density ratio at any centre is at most `bound/(1 − µ)` | a Borel `A′ ⊆ A` of full measure; `((R + D)/R)² → 1` |
| `DualCert.oneAvoidingDensityBound_of` (Window) | a valid certificate with `bound/(1 − µ) ≤ 0.2470` proves `Plane.OneAvoidingDensityBound` | the volume-preserving isometry `ℂ ≅ EuclideanSpace ℝ (Fin 2)` |
| `upperDensity_le_of_oneAvoidingDensityBound` (Plane/OneAvoidingDensity) | the paper's form gives `upperDensity A ≤ 0.2470` on `ℂ` for measurable band-free `A` | the same isometry, reversed |
| `X23_valid`, `X23_phi`, `X23_ratio`, `Plane.oneAvoidingDensityBound` (lane X, new) | the paper's certificate is valid, `ϕ ≥ 1 − 6·10⁻⁵` on `[0, ∞)`, `bound/(1 − 6·10⁻⁵) ≤ 0.2470`, and the theorem | generated data; exact algebra; the atom DFS; `BesselCert.Cells.phiApprox_ge` |

### 1.3 The stored statements, dumped from the built tree before any edit

The tree's build is current for `c180a0f33`: `./scripts/build.sh` under the slot, "all 1943 modules already up to date, nothing
built" (`data/fs131/idb2/build0.log`). `data/fs131/idb2/lean/StatementDump.lean` (every constant of `Autocorr`, `Pattern`,
`Window`, `Plane/OneAvoidingDensity` from the modules' own compiled data: kind, name, stored type, a definition's stored value)
under the slot: `data/fs131/idb2/statements-before.txt` — 53 constants (6 + 36 + 3 + 8), 47 not internal. Reader
`tools/fs131_idb2_statement_diff.py` (FS131-IDB1's reader, its module list changed); its self-test (a changed type, a changed
value, a removed constant, a new public constant, each planted in a copy of the dump) fires on all four, and the faithful copy
reads 0 differences over 47 constants.
