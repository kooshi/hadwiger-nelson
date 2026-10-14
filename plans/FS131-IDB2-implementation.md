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

## Stage 4 — SAVED: lane X, the paper read against the library first

Read this job, from the held copy `~/source/library/pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf`
(v3; text extracted with `pdftotext -layout`, every line below checked against that text): p. 4 (Theorem 1), pp. 5–6 (`σ(n)`,
`σ(n; I)`), p. 9 (`C(X)`, (ieC)), pp. 13–14 (Proposition 1, eqs. (19)–(21)), pp. 16–19 (§ 8: eq. (22), (23), (24), `µ`, `ν`, the
final bound). Reading status: those pages read in full this job; Tables 1–2 and §§ 1–3, 5–7, 9 not re-read (the planner read
§§ 1–9 in full, FS131-KDB1).

**Theorem 1** (p. 4), word for word: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." — the
library's `Plane.OneAvoidingDensityBound` (`Plane/OneAvoidingDensity`), read aloud by the planner (FS131-KDB1 § 1.3) and
unchanged here: `NullMeasurableSet A volume` for "Lebesgue measurable", `∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1` for "1-avoiding",
`EuclideanSpace ℝ (Fin 2)` with `volume`, the `limsup` of `vol(A ∩ B(x, R))/vol(B(x, R))` at **every** centre `x` (the paper
fixes one `x` and calls the value independent of it), `≤ ENNReal.ofReal 0.2470`. No difference.

**Eq. (22)** (p. 17), word for word: "ϕ(t) = w0 J0(t) + Σ_{i∈[n]} w1(i) + Σ_{{i,j}∈([n] choose 2)} w2(i, j) J0(t|xi − xj|)
with xi being defined by Table 1 and the non-zero coefficients w specified by Table 2." The library's
`DualCert.phi w0 t = w0 * J0 t + ∑ i, C.w1 i + (C.w2.map fun e => e.2.2 * J0 (t * ‖C.X e.1 - C.X e.2.1‖)).sum`
(`Plane/DensityBound/Pattern`).

| the paper | the library | match |
|---|---|---|
| `ϕ` (eq. (22)) | `DualCert.phi w0 t` | term for term, with the pair sum read as a list of `(i, j, w₂(i, j))`, one entry per unordered pair carrying a nonzero weight (g23.csv lists each pair once); `J₀` is the library's `J0` (`Plane/DensityBound/Bessel`, the circle average `(2π)⁻¹∫cos(x sin θ)`, which is the Bessel function of the first kind of order 0 — the paper's "Ω₂ = J₀ (Schoenberg)") |
| `µ = 0.00006` ("ϕ(t) > 1 − µ with µ = 0.00006 for t ∈ [0, T]", p. 18) | `mu := 6 / 10 ^ 5` in `X23_phi`, `X23_ratio`; `1 - mu ≤ C.phi w0 t` for **all** `t ≥ 0` | the same `µ`; the library asks it on all of `[0, ∞)`, which the paper establishes for `t ∈ [0, T]` and, for `t > T`, the stronger `ϕ(t) > 1` (p. 18) |
| `w0 = 0.378583312921677` (Table 2; g23.csv row `w_0`) | `X23w0 := 0.378583312921677`; `P23.Ws`'s first entry `37858331292167700000 = w0 · 10²⁰` at distance `2⁶⁴/2⁶⁴ = 1` (`Cells/Data`) | the same number |
| `w1(i) = 0` except `w1(1) = 1.059383649998022` (p. 17) | `X23.w1` with `w1 0 = 1.059383649998022` (0-based), others `0`; `P23.w1N = 105938364999802200000 = w1(1) · 10²⁰` | the same, the index shifted from 1-based to `Fin 23` |
| `w2(i, j)` (Table 2; 26 nonzero, g23.csv rows `w_2`) | `X23.w2 : List (Fin 23 × Fin 23 × ℝ)`; `P23.Ws` entries 2–27 are the weights grouped by distance | to be checked by lane X's identification (the 26 g23 pairs fall on 26 distinct distances, J26's `d_min = 0.21494` over them) |
| `wc(I, J)`, `{I, J} ∈ C(X)`, `C(X) = {{I, J} : I, J ⊂ [n], I ≠ J, X|I ≅ X|J}` (p. 9), "X|J = ϕ(τ(X|I))", ϕ orthogonal, τ a translation | `X23.wc : List (Finset (Fin 23) × Finset (Fin 23) × ℝ)` with `Valid.cong : C.Congruent e.1 e.2.1`, `Congruent I J := ∃ u v b, ‖u‖ = 1 ∧ (z ↦ u·(b ? z̄ : z) + v) '' X''I = X''J` | the same class of maps (`ϕ ∘ τ` is `z ↦ u·(b ? z̄ : z) + v`), the same set equality; `I ≠ J` is not asked by the library (a weaker hypothesis) |
| `V(ε) = wT − Σ_{εi=1} w1 − Σ_{εi=εj=1} w2 + Σ_{ε∈σ(n;I)} wc − Σ_{ε∈σ(n;J)} wc` (eq. (20)), `σ(n; I) = {ε : ε|I = 1}` (p. 5), "V(ε) ⩾ 0 for every ε ∈ σ(n)" | `L S = Σ_{i∈S} w1 + Σ_{e.1,e.2.1∈S} w2 − Σ wc([I ⊆ S] − [J ⊆ S])` (eq. (20)'s `wT − V`), `Valid.atoms : S.Nonempty → C.IsIndep S → C.L S ≤ C.bound`, `Valid.bound_nonneg : 0 ≤ C.bound` | `V(ε) = bound − L(I(ε))` term for term; the library asks `V ≥ 0` only on nonempty independent `S` and `V(∅) = bound ≥ 0` — a subset of the paper's conditions, enough for the proof (`window_bound`), as the paper itself notes for (ieI) |
| `ν = 10⁻⁵`, "changing wT to w̃T = wT + ν" (p. 16) | `X23.bound` | to be fixed by lane X: the paper's `ν = 10⁻⁵` gives `(wT + 10⁻⁵)/(1 − 6·10⁻⁵) = 0.24699740… < 0.2470`; the planner's record typed `wT + 10⁻⁶` (the notebook's `ν`, `NU_NB` in `tools/j26_ambrus_check.py`; J26's H6 `0.246988449`). Both are below 0.2470; the minimum `V = −6.712244·10⁻⁸` (J26) is above `−10⁻⁶` |
| "m1(R²) ⩽ w̃T/(1 − µ) = (wT + ν)/(1 − µ) = 0.24699 … < 0.2470" (p. 19) | `X23_ratio : X23.bound / (1 - 6 / 10 ^ 5) ≤ 0.2470`, `DualCert.oneAvoidingDensityBound_of … (hβ : C.bound / (1 - mu) ≤ 0.2470)` | the same quotient; the paper's "divide all the coefficients w by the factor (1 − µ)" is `limsup_le`'s `bound/(1 − µ)` |
| `wT = 0.24697262945998308` (g23.csv row `w_T`) | `X23.bound = wT + ν` | — |

**One misprint in the paper, not material**: p. 18, "Note that J0′(t) = J1(t)" — the derivative is `−J₁` (`Bessel.hasDerivAt_J0`:
`J0′ = −J1`); the paper uses only `|J0′| = |J1|`. (J26 recorded the other, eq. (23)'s `w1(4)` for `w1(1)`.)

**Verdict: the paper's eq. (22) and Theorem 1 agree with the library in every respect**; the library's hypotheses are the
paper's or weaker (`V ≥ 0` on nonempty independent atoms only; `I ≠ J` not asked; `ϕ ≥ 1 − µ` asked on `[0, ∞)`, which the
paper proves). One choice is open and is lane X's to make and state: `ν = 10⁻⁵` (the paper's) or `10⁻⁶` (the notebook's and
the planner's typed block). No message to the coordinator is owed under the brief's "differs in any respect" clause.

### 4.1 Two exact checks that de-risk lane X (untrusted planning instruments, `data/fs131/idb2/proto/`)

- **Every listed congruence has an explicit isometry of the library's form.** `proto_cong.py` (exact `Fraction` arithmetic in
  `ℚ(√3, √11)(i)`, the points read by `tools/j26_ambrus_check.py` from the notebook, the correspondence `I[k] ↦ J[k]` in the
  notebook's order): for each of the 2,321 `w_C` rows it builds `u = (y₁ − y₀)/(p₁ − p₀)`, `v = y₀ − u·p₀` with `p = xᵢ` or
  `x̄ᵢ`, and checks `|u|² = 1` and `u·pₖ + v = yₖ` for every `k`: **2,321 of 2,321 found**, the lcm of the denominators of `u`
  and `v` at most 804 (the points' own lcm 12). Control: one row's correspondence swapped (`[2, 6, 8] → [8, 3, 6]`) → "none 1".
  So `Valid.cong` is a finite exact check with data the generator emits (`b`, `u`, `v` per row).
- **The identification `X23.phi X23w0 t = P23.w1N/P23.WS + jsum P23.Ws d t / P23.WS` holds exactly** (item 866's question).
  `proto_phi.py`: the 26 `w_2` pairs fall on 26 distinct exact squared distances; `w₀·10²⁰ = P23.Ws[0]` at `P23.Ds[0] = 2⁶⁴`
  (distance 1), `w₁(1)·10²⁰ = P23.w1N`, and for each pair its weight times `10²⁰` **equals** the `P23.Ws` entry whose
  `P23.Ds/2⁶⁴` lies within `2⁻⁶⁴` of its distance (`mpmath`, 50 digits) — every entry of `P23.Ws` used once. So `X23_phi` is
  `phiApprox_ge` at `d = [1, |x_{i₁} − x_{j₁}|, …]` in `P23.Ds`'s order, once the `w₂` list is permuted to that order and each
  `|dₖ − Dₖ/2⁶⁴| ≤ 2⁻⁶⁴` is proved (squared distances exact in the field, `√3`, `√11` and the square root enclosed).
