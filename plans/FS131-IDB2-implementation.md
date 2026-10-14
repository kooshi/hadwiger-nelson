# FS131-IDB2 — the density bound's second implementer: the Fourier side (lane F), the patterns and the window (lane P), the instance and the theorem (lane X)

*de Bruijn, the implementer (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-IDB2-fourier-window-x23.md` (on `main`), with
`plans/STANDING-RULES.md`. Branch `fs131-wdb2`, cut from `fs131-wdb1` at `c180a0f33`; tree `.claude/worktrees/fs131-w10g`. The plan
is the planner's record `plans/FS131-KDB1-density-bound.md` (§ 3.3 per leaf, § 5 the lanes); the first implementer's record is
`plans/FS131-IDB1-implementation.md`. Resuming: read this file, check its last SAVED stage against
`git log -- plans/FS131-IDB2-implementation.md`, continue at the first stage not SAVED.*

## Theorems this phase proved

Every record below is kernel-checked in the built tree of `fs131-wdb2` (build `data/fs131/idb2/build1-full.log`, exit 0) and its
axioms are printed from that tree (`data/fs131/idb2/axioms.txt`, read by `tools/fs131_idb2_axioms.py`): **each on
`[propext, Classical.choice, Quot.sound]`; none on `sorryAx`, none on a native axiom.**

- `HadwigerNelson.DensityBound.autocorr_eq_zero_of_norm_eq_one` (`Plane/DensityBound/Autocorr`) — `[KMOR2016]` Lemma 3.2 (1),
  finite-window form — [kernel], the standard three.
- `HadwigerNelson.DensityBound.circleAvg_autocorr_one`, `circleAvg_autocorr_zero`, `continuous_autocorr` (`Autocorr`) — [kernel],
  the standard three.
- **`HadwigerNelson.DensityBound.sum_circleAvg_autocorr_nonneg`** (`Autocorr`) — for a bounded measurable `E ⊆ ℂ`: if
  `Σ c_k J₀(t r_k) ≥ 0` for every `t ≥ 0` then `Σ c_k F̊(r_k) ≥ 0`, `F̊` the circle average of `vol(E ∩ (E − ·))`; the Fourier
  side of `[AmbrusEtAl2023]` Proposition 1 with no torus and no periodic reduction — [kernel], the standard three.
- **`HadwigerNelson.DensityBound.DualCert.window_bound`** (`Plane/DensityBound/Pattern`) — the pattern expectation: a valid
  certificate gives `(Σw₁)·vol E + Σ w₂ F̊(|xᵢ − xⱼ|) ≤ bound · vol B(x₀, R + D)` for a measurable 1-avoiding `E ⊆ B(x₀, R)`,
  `‖xᵢ‖ ≤ D`; the atom half of Proposition 1 — [kernel], the standard three.
- `HadwigerNelson.DensityBound.trivialCert_valid` (`Pattern`) — the model of `DualCert.Valid` — [kernel], the standard three.
- `HadwigerNelson.DensityBound.DualCert.window_le` (`Plane/DensityBound/Window`) — `(1 − µ) vol E ≤ bound · vol B(x₀, R + D)`
  — [kernel], the standard three.
- **`HadwigerNelson.DensityBound.DualCert.limsup_le`** (`Window`) — Proposition 1 in finite-window form, on `ℂ`, at every
  centre: `limsup_R vol(A ∩ B(x₀, R))/vol B(x₀, R) ≤ bound/(1 − µ)` — [kernel], the standard three.
- **`HadwigerNelson.DensityBound.DualCert.oneAvoidingDensityBound_of`** (`Window`) — any valid certificate with
  `ϕ ≥ 1 − µ` on `[0, ∞)`, `µ < 1` and `bound/(1 − µ) ≤ 0.2470` proves `Plane.OneAvoidingDensityBound` — [kernel], the
  standard three.
- `HadwigerNelson.Plane.upperDensity_le_of_oneAvoidingDensityBound` (`Plane/OneAvoidingDensity`) — the paper's form carried
  to the library's plane `ℂ` — [kernel], the standard three; with it `mOne_le_of_oneAvoidingDensityBound` and
  `mOne_lt_quarter` (unchanged) now rest on the standard three.

**Not proved: `Plane.OneAvoidingDensityBound` itself** — it waits on lane X, the certificate as a Lean instance (stage 5).

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

## Stage 2 — SAVED: lane F, the Fourier side (`Autocorr`, 5 leaves)

All five leaves of `Plane/DensityBound/Autocorr` are proved, in the copy `data/fs131/idb2/work/Autocorr.lean` (elaborated under
the slot with `-DautoImplicit=false`, 5.4 s, 3.2 GB, no error and no warning) and copied over the module; the text diff against
the skeleton removes exactly the five `sorry` lines and adds the proofs, nine private helpers and one import line
(`Mathlib.Analysis.Fourier.Inversion`, whose own imports — `PeakFunction`, `Gaussian.FourierTransform` — the module already
had, so the instance paths its stored statements read cannot move; the kernel-side check is stage 4's). Each leaf's axioms,
printed from the copy: `[propext, Classical.choice, Quot.sound]`.

| leaf | proof |
|---|---|
| `autocorr_eq_zero_of_norm_eq_one` | the planner's scratch proof, folded in unchanged |
| `circleAvg_autocorr_one` | `Real.circleAverage_const_on_circle` with the leaf above |
| `circleAvg_autocorr_zero` | the same, on `sphere 0 0 = {0}` |
| `continuous_autocorr` | `tendsto_measure_symmDiff_preimage_nhds_zero` for the family `z ↦ (· + z)` (`ContinuousMap.curry`), with a private `|vol(E ∩ A) − vol(E ∩ B)| ≤ vol(A Δ B)` |
| `sum_circleAvg_autocorr_nonneg` | below |

**The route actually taken for the positive definiteness** — the plan's, with Mathlib's Fourier inversion machinery doing the
Gaussian work. Private helpers: `fourier_autocorr` — `𝓕 F = |𝓕 1_E|²` for `F = autocorr E` (one Fubini on `(w, y)`, a
translation, `integral_conj`); `tendsto_smooth` — for integrable `f` continuous at `z`,
`∫ e^{−‖ξ‖²/a + 2πi⟨z,ξ⟩} 𝓕f(ξ) dξ → f(z)` as `a → ∞` (Mathlib's `Real.tendsto_integral_gaussian_smul'`, its
peak-function limit, carried to the Fourier side by `VectorFourier.integral_fourierIntegral_smul_eq_flip` and
`fourier_gaussian_innerProductSpace'`, as in Mathlib's own proof of the inversion formula); `circleAverage_fourierWeight` — for
continuous integrable `w`, the circle average of `z ↦ ∫ w(ξ) e^{2πi⟨z,ξ⟩}` at radius `r` is `∫ w(ξ) J₀(2πr‖ξ‖)` (Fubini on
`[0, 2π] × ℂ`, then `circleAverage_exp_inner`). The assembly: with `w_a = e^{−‖ξ‖²/a}|𝓕1_E|² ≥ 0`, the smoothed
autocorrelation `Φ_a` has `Σ c_k F̊_a(r_k) = ∫ w_a Σ c_k J₀(2π‖ξ‖ r_k) ≥ 0` by `hW`; `‖Φ_a(z)‖ ≤ Φ_a(0) → vol E` dominates the
circle averages (no Gaussian normalization is computed: the positive-definite bound `|Φ(z)| ≤ Φ(0)` replaces it), and
`Φ_a → F` pointwise; so the limit `Σ c_k F̊(r_k)` is `≥ 0`.

**Re-priced.** The planner priced lane F at 900 lines; the five leaves came to 365 lines with the helpers (the two first leaves
13 lines together; the positive definiteness about 300). **0.4×** the plan. No message owed.

## Stage 3 — SAVED: lane P, the patterns and the window (`Pattern` 2, `Window` 3, `Plane/OneAvoidingDensity` 1); the build, the statements, the axioms

### 3.1 The six leaves

All proved in the copies under `data/fs131/idb2/work/` and copied over the modules; the text diff against the skeletons removes
exactly the six `sorry` lines (`git diff` shows no other removed line) and adds proofs and private helpers; no import line
changed in `Pattern`, `Window` or `Plane/OneAvoidingDensity`.

| leaf | proof |
|---|---|
| `DualCert.window_bound` | the plan's pattern expectation, as lower integrals. Private helpers: `rho θ b z = e^{iθ}(b ? z̄ : z)` with `rho_comp` (O(2) composes: `ρ_{θ,b}(u·(b′ ? z̄ : z)) = ρ_{θ ± arg u, b ⊕ b′}(z)`), `lintegral_Ioc_shift` (a `2π`-periodic function's lower integral over `(0, 2π]` is shift-invariant, through `AddCircle.lintegral_preimage` and Haar invariance on `AddCircle (2π)`); `hitVol I b θ = vol{y : ∀ i ∈ I, y + ρ(xᵢ) ∈ E}` and `patVol S b θ = vol{y : pat = S}`, measurable in `θ` (`measurable_measure_prodMk_right`); the Venn identity `hitVol I = Σ_{S ⊇ I} patVol S` (`measure_biUnion_finset`); `hitVol {i} = vol E`; `hitVol {i, j} = F(ρ(xⱼ − xᵢ))` and `∫_{(0,2π]} F(ρ_θ v) = 2π F̊(‖v‖)` (`circleAverage_eq_integral_add`); congruence invariance (a translation in `y`, a shift in `θ`, a flip of `b`); `patVol S = 0` off independent `S`; `Σ_{S ≠ ∅} patVol S ≤ vol B(x₀, R + D)`. The assembly sums `N(I) = Σ_b ∫ hitVol` and `P(S) = Σ_b ∫ patVol` in `ℝ≥0∞`, takes real parts on the nonempty patterns (each finite, `≤ N({i})`), and expands `Σ_S P(S) L(S)` by the private `sum_mul_L`; the congruence terms cancel, the rest is `4π` times the left side, and `L(S) ≤ bound` on independent `S` bounds it by `4π · bound · vol B` |
| `trivialCert_valid` | `L S = |S| ≤ 1` on `Fin 1` |
| `DualCert.window_le` | `sum_circleAvg_autocorr_nonneg` on the index type `Option (Option (Fin w₂.length))` (`w₀` at radius 1, `Σw₁ − (1 − µ)` at radius 0, `w₂` at the pair distances), the list sum read as a `Fin` sum through `List.ofFn_getElem`; `circleAvg_autocorr_one`, `_zero`; `window_bound` |
| `DualCert.limsup_le` | a measurable `A′ ⊆ A` of full measure (`exists_measurable_subset_ae_eq`); `D := Σ‖xᵢ‖`; for `R > 0` the ratio is at most `ofReal(β((R + D)/R)²)`, `β = bound/(1 − µ)`, from `window_le` and `vol B(x₀, r) = πr²`; that bound tends to `ofReal β` |
| `DualCert.oneAvoidingDensityBound_of` | `Complex.orthonormalBasisOneI.repr`, measure-preserving (`LinearIsometryEquiv.measurePreserving`), a measurable embedding; balls and distances carried; `limsup_le` |
| `upperDensity_le_of_oneAvoidingDensityBound` | the same isometry reversed; `BandFree A 0` gives `dist ≠ 1` |

**Re-priced.** The planner priced lane P at 1,150 lines; the six leaves came to 545 lines with their helpers (`Pattern` +429
over its skeleton, `Window` +101, `Plane/OneAvoidingDensity` +18): **0.47×**. Lanes F and P together: 910 lines against
2,050 planned, **0.44×**. No message owed.

### 3.2 One build under the slot

`scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` — **exit 0**, 256 batches, 5 modules rebuilt
(`Autocorr` 4.5 s, `Pattern` 4.1 s, `Window` 3.0 s, `Plane/OneAvoidingDensity` 2.5 s, `Proofs` 2.2 s), **"0 module(s) with
warnings"**, 7 m 23 s (`data/fs131/idb2/build1-full.log`; Lake's log `build/gate/build/20261014T175113Z-4141683.log`). Each file
through `lake env lean` under a 4 GiB cap: 3.0–5.6 s, 3.13–3.24 GB resident (Mathlib's mapped `.olean`s are ≈ 3.1 GB of it).
`sorry` appears in no file of `Plane/DensityBound/` nor in `Plane/OneAvoidingDensity` (`grep -c`, all 0); `native_decide` in
none (`grep -rln`, exit 1).

### 3.3 No statement and no definition changed, from the kernel's side

`data/fs131/idb2/statements-after.txt` (stage 1's dump re-run on the built tree) against `statements-before.txt`:
`tools/fs131_idb2_statement_diff.py` — **47 constants checked, 0 differences** (every stored type of the four modules, every
stored value of `autocorr`, `DualCert`'s fields, `L`, `IsIndep`, `Congruent`, `phi`, `trivialCert`, `OneAvoidingDensityBound`,
`mOne`); the private helpers are internal names and no public constant was added. **A planted change, watched firing from the
kernel's side**: the copy `data/fs131/idb2/work/WindowCtl.lean` (the module's text with a footer printing the stored type's
hash of `DualCert.window_le` as elaborated in the file) prints `3481863677`, the hash the built module stores; the copy
`WindowPlant.lean`, the same with one added hypothesis `(_hplant : 0 ≤ mu)`, prints `178506245`. The reader's self-test (stage 1)
fires on a changed type, a changed value, a removed constant and a new public constant.

### 3.4 The axioms of every public declaration of these files, from the built tree

`data/fs131/idb2/lean/AxiomsIDB2.lean` prints `Lean.collectAxioms` of every non-internal constant of the four modules;
`tools/fs131_idb2_axioms.py` reads it: **47 records, all 47 on `[propext, Classical.choice, Quot.sound]`; no `sorryAx`, no
native axiom** (`data/fs131/idb2/axioms.txt`). The two planted records show what was planted (`withSorry` → `[sorryAx]`,
`withNative` → `[FS131IDB2Plant.withNative._native.native_decide.ax_1_1]`); a copy of the print with `window_le`'s list made
`[propext, sorryAx]` and the sorry plant's made `[propext]` is refused on both counts (exit 1).

### 3.5 Linters

`lake lint --no-build -- --no-build --trace` under the slot: exit 0, `-- Linting passed for Proofs.`, every linter passed, no
finding in `Plane/DensityBound/` or `Plane/OneAvoidingDensity` (`data/fs131/idb2/lint.log`). No planted lint control was run
(it needs a rebuild); the landing's gate runs the lint's own.
