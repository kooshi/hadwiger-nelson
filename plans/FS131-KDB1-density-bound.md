# FS131-KDB1 — the density bound `m₁(ℝ²) ≤ 0.2470`, planned for the kernel to its leaves and priced

*de Bruijn, the planner (Opus 5.5), 2026-10-14. Brief: `data/fs131/briefs/FS131-KDB1-density-bound.md` (with `plans/STANDING-RULES.md`).
Branch `fs131-wdb`, tree `.claude/worktrees/fs131-w10g`. Resuming: read this file and the brief, check the last SAVED stage against
`git log -- plans/FS131-KDB1-density-bound.md`, and continue at the first stage not SAVED.*

## Theorems this phase proved

None. A planning job: the statements are typed with `sorry` at their leaves, and the first leaves written for pricing are scratch
(`data/fs131/kdb1/`), not library theorems.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, against their sources (standing rule 3)

Checked mechanically (every `> ` line of the brief searched verbatim in its named source):

| # | the brief quotes | source | verdict |
|---|---|---|---|
| Q1 | W2 (2026-10-13) "I choose the second form. Any finding of ours must be formalized. …" | `data/fs131/REQUEST-2026-10-13.md` line 4 | verbatim |
| Q2 | item 818 (FS131-KR1's classical input; the rulings) | `plans/FS131-close-inventory.md` line 9255 | verbatim |
| Q3 | item 823 (FS131-KR1 handed back) | same file, line 9260 | verbatim |
| Q4 | item 828 (Kooshi's answers, W6) | same file, line 9265 | verbatim |
| Q5 | "Yes, prove the density bound." (inside Q4) | `data/fs131/REQUEST-2026-10-13.md` W6, line 26 | verbatim |
| Q6 | Theorem 1: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." (inside Q2) | the paper, held v3, p. 4 | verbatim |

No mismatch.

### 1.2 The first commit

`git checkout fs131-wkr -- Proofs/HadwigerNelson/Plane/OneAvoidingDensity.lean` (branch `fs131-wkr` at `3fabd5e10`); `git diff fs131-wkr
-- <path>` is empty (text unchanged); its import line after `Plane.Suprema` in `Proofs.lean` and its `ARCHITECTURE.md` row copied
verbatim from `fs131-wkr`; `tools/check_architecture.py` PASS. Build: `scripts/slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8
./scripts/build.sh` — **exit 0**, 249 batches, 2 modules rebuilt (the new module 1.0 s, and `Proofs`), 7 m 35 s; the one warning is the
module's own leaf (`OneAvoidingDensity.lean:54:8: declaration uses sorry`, `upperDensity_le_of_oneAvoidingDensityBound`). Log:
`data/fs131/kdb1/build1.log`. Commit `affb9142e`.

### 1.3 The statement, read aloud against the paper

`Plane.OneAvoidingDensityBound` (`Plane/OneAvoidingDensity.lean`, line 33):

```
∀ A : Set (EuclideanSpace ℝ (Fin 2)), NullMeasurableSet A volume → (∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) →
  ∀ x : EuclideanSpace ℝ (Fin 2),
    limsup (fun R : ℝ => volume (A ∩ ball x R) / volume (ball x R)) atTop ≤ ENNReal.ofReal 0.2470
```

| the paper (p. 2, eq. (1); p. 4) | the Lean | reading |
|---|---|---|
| "Lebesgue measurable" | `NullMeasurableSet A volume` | the completion of Borel for `volume` — exactly Lebesgue measurability |
| "1-avoiding": "independent in the unit distance graph" (p. 2) | `∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1` | the same; `a = b` gives `dist = 0 ≠ 1`, no exclusion needed |
| "planar set", `λ₂` | `EuclideanSpace ℝ (Fin 2)` with `volume` | Lebesgue measure on ℝ² |
| `δ(A) = lim sup_{R→∞} λ_d(A ∩ B_d(x,R))/λ_d(B_d(x,R))`, "where x is fixed"; "independent of the choice of x" | `∀ x, limsup … atTop` | the paper fixes one `x` and asserts independence; the Lean states it at every `x` — equal in truth (KR1's reading, item 823, confirmed); stronger in form, so a proof must work at an arbitrary centre (ours does: § 2) |
| `B_d(x,R)` "the ball of radius R centred at x" | `ball x R` (open) | open and closed balls differ by a null circle |
| "at most 0.2470" | `≤ ENNReal.ofReal 0.2470` | the real literal `0.2470 = 247/1000`; the ratio is an `ENNReal` (`0/0 = 0` for `R ≤ 0`, irrelevant along `atTop`) |

**No domain is empty**: the module's own `oneAvoidingDensityBound_model` (the open ball of radius `1/2`) inhabits the hypotheses; the
proof (§ 2) uses no hypothesis beyond the three. Not vacuous, not weaker than the page. **The proof target:** a theorem
`Plane.oneAvoidingDensityBound : OneAvoidingDensityBound` in a new module downstream of the parts (§ 3), the statement unchanged.

### 1.4 The paper's proof, as a chain of steps (held v3, read in full this job: §§ 1–9 and Tables 1–2; the certificate files as J26 found them)

| step | page | what it states | what it reads |
|---|---|---|---|
| P1 — periodic reduction | p. 5, §2 | "m₁(ℝ²) may be approximated arbitrarily well by densities of 1-avoiding, measurable, periodic sets [deOV10, KeMOR16]" | the upper density (p. 2); cited, not proved in the paper |
| P2 — autocorrelation | p. 5, eqs. (2), (3) | `f(x) = δ(A ∩ (A − x))`; `δ(A) = f(0)`; `f(x) = 0` for unit `x` | P1's periodicity (the density exists) |
| P3 — Lemma 1 (atoms) | pp. 5–6, eqs. (5), (6) | `a_X(ε) = δ(⋂(A − x_i)^{ε_i})`; (ieP) `≥ 0`, (ieI) `= 0` on non-independent atoms, (ieT) total 1, (ie1) `Σ_{σ(n;i)} = f(0)`, (ie2) `Σ_{σ(n;i,j)} = f(x_i − x_j)` | translation invariance of the density |
| P4 — O(2) averaging | pp. 8–9, eqs. (12), (13), (ieC) | `å_X`, `f̊` radial; congruent index sets give equal averaged sums (reflections included, so O(2), not SO(2)) | P3; Haar measure on O(2) |
| P5 — Fourier side | pp. 10–11, eqs. (14)–(17) | Fourier series on `ℝ²/L`: `f̂(u) = |1̂_A(u)|² ≥ 0` (Parseval); `f̊(x) = Σ_t κ(t) Ω₂(t|x|)`, `κ ≥ 0`, `Σκ = δ(A)`; `Ω₂ = J₀` (Schoenberg, p. 17) | P1 (the torus) |
| P6 — Proposition 1 (weak duality) | pp. 13–14, eqs. (19)–(21) | if `W(t) ≥ 1` on `[0, ∞)` and `V(ε) ≥ 0` for every `ε`, then `m₁(ℝ²) ≤ w_T`; only independent atoms need `V ≥ 0` (p. 14) | P2–P5 |
| P7 — the certificate | pp. 15–19, 23–24 | `X₂₃` (Table 1), `w` (Table 2 and [Web], 2,350 coefficients); `V ≥ −ν`, `ν = 10⁻⁵`; `ϕ(t) ≥ 1 − µ` on `[0, 10⁴]`, `µ = 6·10⁻⁵`, by "interval arithmetic"; the tail `t > 10⁴` by (23)–(24) with Watson §7.21 and §15.31; `m₁ ≤ (w_T + ν)/(1 − µ) = 0.24699… < 0.2470` | P6; the classical Bessel facts cited |
| P8 — symbolic checks | pp. 19–20, §9 | unit distances symbolically 1; congruences valid | exact algebra in the Moser ring |

What this project already holds on P7–P8 (read, not re-derived): J26 (`plans/PA-ambrus2023-audit.md`) — H1 47 unit pairs, H2 all 2,321
congruences exact (the notebook's own test proved only similarity), H3 13,552 atoms with `min V = −6.712244·10⁻⁸` exactly, H6
`(w_T + 10⁻⁶)/(1 − 6·10⁻⁵) = 0.246988449 < 0.2470`, `d_min = 0.21494` over the 26 `w₂` pairs; J49 (`plans/FS100-KT1-ambrus-ball.md`) — H4
on `[0, 10⁴]` in arb at 80 bits on J26's 493,471-point covering, margin `2.348·10⁻⁶`, H5 (tail) `1.0107 > 1`, both resting on Watson
§13.74 and §15.31 by citation. The paper's eq. (23) typo `w₁(4)` for `w₁(1)` (J26).

## Stage 2 — SAVED: the route

### 2.1 The route in one paragraph, and where it leaves the paper

The certificate is the paper's (`X₂₃`, `g23.csv`, J26's exact reading); the argument around it is restructured so that every step is
either a finite exact check or a short piece of real analysis that Mathlib nearly holds. **(R1) A finite window replaces the periodic
reduction (P1).** Fix `A` (Lebesgue measurable, 1-avoiding), a centre `x₀` and `R > 0`; replace `A` by a Borel subset of full measure
(still 1-avoiding) and put `E = A ∩ B(x₀, R)`. Everything below is about the one bounded Borel set `E`; no density, no lattice, no torus.
The result of R2–R4 is `(1 − µ)·vol E ≤ (w_T + ν)·vol B(x₀, R + D)` with `D = max |x_i| = √3`, for every `R`; hence the ratio is at most
`β·((R + D)/R)²` with `β = (w_T + ν)/(1 − µ) = 0.246988449… < 0.2470`, and the `limsup` is at most `β`. **(R2) An expectation over
patterns replaces the LP atoms (P3, P4, P6's atom half).** Parametrize O(2) as `ρ_{θ,b}(z) = e^{iθ}·(b ? z̄ : z)`, `θ ∈ [0, 2π]`,
`b ∈ Bool`, and put `pat(y, θ, b) = {i : y + ρ_{θ,b}(x_i) ∈ E}`. Integrating over `y ∈ ℂ` (Lebesgue, **not** normalized) and `(θ, b)`:
`P(S) = Σ_b ∫_θ vol{y : pat = S}`, `N(I) = Σ_{S ⊇ I} P(S) = Σ_b ∫_θ vol ⋂_{i∈I}(E − ρx_i)` for `I ≠ ∅`. Then `N({i}) = 4π vol E`,
`N({i,j}) = 4π F̊(|x_i − x_j|)` with `F(z) = vol(E ∩ (E − z))` and `F̊` its circle average, `N(I) = N(J)` for congruent index sets, `P(S) = 0`
unless `S` is independent, and `Σ_{S ≠ ∅} P(S) ≤ 4π vol B(x₀, R + D)` (a nonempty pattern puts `y` in that ball). The certificate's
`V(S) ≥ −ν` on nonempty independent `S`, summed against `P`, gives `w₁·vol E + Σ w₂ F̊(d_ij) ≤ (w_T + ν)·vol B(x₀, R + D)` — exact, with
no boundary error, because translation invariance is used on all of `ℂ` and normalization only at the end. **(R3) Gaussian
regularization replaces the Fourier series (P5).** For `E` bounded, `F` is continuous and integrable, and for radii `r_k` and reals
`c_k` with `Σ c_k J₀(t r_k) ≥ 0` for all `t ≥ 0`, `Σ c_k F̊(r_k) ≥ 0`: write `Q_ε(v) = ∬ 1_E(y)1_E(y′)Γ_ε(y′ − y − v)`; by the Gaussian's
Fourier integral and Fubini, `Σ c_k (circle average of Q_ε)(r_k) = (4π²)⁻¹∫ e^{−ε|ξ|²/4}|1̂_E(ξ)|² Σ c_k J₀(r_k|ξ|) dξ ≥ 0`, and `Q_ε → F`
pointwise as `ε → 0` (a peak-function limit at a point of continuity), boundedly. Applied with `c = (w₀ at r = 1, w₁ − (1 − µ) at r = 0,
w₂ at d_ij)`, `F̊(1) = 0` (KMOR Lemma 3.2 (1)'s analogue: `E ∩ (E − z) = ∅` for `|z| = 1`) and `F(0) = vol E`, it gives
`(1 − µ) vol E ≤ w₁ vol E + Σ w₂ F̊(d_ij)`. **(R4) `J₀` from its integral, its ODE, and certified polynomial chains replace the paper's
"interval arithmetic" and both Watson citations (P7).** `J₀(x) = (2π)⁻¹∫₀^{2π} cos(x sin θ)dθ`, `J₁(x) = (2π)⁻¹∫₀^{2π} sin θ sin(x sin θ)dθ`;
`J = (J₀, J₁)` solves `J₀′ = −J₁`, `J₁′ = J₀ − J₁/x` (`x > 0`), `J(0) = (1, 0)`; `|J|²` has derivative `−2J₁²/x ≤ 0`, so `|J|` is
antitone on `(0, ∞)`. (a) **An ODE comparison lemma**: if a polynomial pair `p` has defect `|p′ − A(x)p| ≤ D` on `[a, b]`, then
`|J(x) − p(x)| ≤ |J(a) − p(a)| + (x − a)D` there — the contraction `⟨e, A e⟩ = −e₁²/x ≤ 0` is what keeps errors from compounding. (b) The
kernel builds each polynomial itself (the Taylor recurrence of the ODE from the cell's entry value), bounds its defect exactly, and
propagates the state; any polynomial would do — the recurrence is only a good guess. (c) On each cell `[t₀, t₀ + w]` of `t`, the 27
polynomials combine into one polynomial `Q(τ)`, re-centred, whose quadratic part is minimized exactly and higher part bounded crudely;
`Q − errors ≥ 1 − µ`. (d) **The tail**: for `t ≥ T₁ = 800`, `|J₀(t d)| ≤ |J(T₁ d)|` by antitonicity, read from the chain's last state:
`w₁ − Σ|w_k||J(800 d_k)| ≥ 1 − µ` with slack `0.0100`. Watson §13.74 (used by J26/J49 for Lipschitz constants) and §15.31 (decreasing
extrema, for the tail) are **not needed**. **(R5) The finite checks**: unit edges and congruences exactly in `ℚ(√3, √11)(i)`
(`Field/Quadratic`'s tower), the 27 distances to `2⁻⁶⁴` (`Field/Approx`'s style), the atom check by a DFS over independent sets — all
`decide +kernel` on integer data; no `native_decide`.

**Against the paper's chain (§ 1.4):** P1 and P5 are replaced (R1, R3) — the periodic approximation [deOV10, KeMOR16] and the Fourier
series on a torus are never used; P3–P4 and P6 are the same mathematics reorganized as one expectation (R2); P7's analytic half is
replaced (R4), its numbers kept; P8 kept (R5). **A finding, reported at once (§ 2.5):** the bound needs neither the periodic reduction nor
any Bessel fact beyond the ODE `J₀′ = −J₁, (xJ₁)′ = xJ₀` and the integral formula — not Schoenberg's identification beyond the circle
average (`Ω₂ = J₀` is our definition), not Watson §7.21, §13.74 or §15.31.

### 2.2 Each step: what Mathlib holds (each name `#check`ed at the pin, `data/fs131/kdb1/probes/Names.lean`), what must be built

| step | Mathlib at the pin | to build | lines (est.) |
|---|---|---|---|
| R1 window and `limsup` | `NullMeasurableSet.exists_measurable_subset_ae_eq`, `Complex.volume_ball`, `EuclideanSpace.volume_ball`, `ENNReal.limsup_mul_le`, `limsup_le_of_le`, `LinearIsometryEquiv.measurePreserving`, `Complex.orthonormalBasisOneI` | the ratio bound `β((R+D)/R)²` and its `limsup`; the transfer `ℂ → EuclideanSpace ℝ (Fin 2)` (balls, distances, volume) | 250 |
| R2 patterns | `Measure.prod_apply`, `lintegral_prod`, `lintegral_finsetSum`, `measure_biUnion_finset`, `measure_preimage_add_right`, `Function.Periodic.intervalIntegral_add_eq`, `measurePreserving_add_right` | `pat` and its measurability; the Venn identity `N(I) = Σ_{S⊇I} P(S)`; translation, rotation and reflection invariance; independence; the ball bound; the summation against the certificate (`ℝ`-valued, finite sums over `Finset (Fin 23)`, never computed) | 900 |
| R3 positive definiteness | `GaussianFourier.integral_cexp_neg_mul_sq_norm_add`, `GaussianFourier.integral_rexp_neg_mul_sq_norm`, `tendsto_integral_comp_smul_smul_of_integrable'`, `tendsto_measure_symmDiff_preimage_nhds_zero`, `integral_prod`, `integral_integral_swap`, `intervalIntegral.tendsto_integral_filter_of_dominated_convergence`, `Complex.norm_exp_ofReal_mul_I` | `F` continuous and integrable; the Fubini chain for `Q_ε`; the circle average of `exp(i⟨ξ, r e^{iθ}⟩)` is `J₀(r|ξ|)`; the limit | 900 |
| R4 `J₀`, ODE, energy | `intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le`, `intervalIntegral.integral_mul_deriv_eq_deriv_mul`, `antitoneOn_of_deriv_nonpos`, `image_sub_le_mul_sub_of_deriv_le`; **no Bessel function anywhere in Mathlib** (grep) | definitions, `J(0)`, bounds `|J₀|, |J₁| ≤ 1`, the two derivatives (one integration by parts), the energy, the comparison lemma (via `√(|e|² + κ²)`, `κ → 0`) | 600 |
| R4 certificate semantics | — | integer polynomials and their evaluation; the defect computation's soundness; one cell's soundness (`Q`'s assembly, the shift, the quadratic minimum); the covering assembly; the tail | 900 |
| R5 exact algebra | `Field/Quadratic` (`Adjoin`, `eval`), `Field/Approx` (`Ival`, `SqrtBounds`), `IndepSearch.nbrMask_and_two_pow_eq_zero` (in the library) | the 23 points ×12 in `Adjoin 11 (Adjoin 3 ℤ)`; 47 edges; 2,321 congruences through a generic "cross-ratio identities give an isometry" lemma; the 27 distances' bounds; the atom DFS and its soundness | 700 |
| data | — | generated modules: points, edges, congruence witnesses, the dual (2,350 coefficients), cell states (847 × 27 × 3 integers), atom groups | generated |

About 4,250 hand-written lines plus generated data. **Routes weighed where there were two:**
- *Fourier side:* (i) Gaussian regularization on `ℂ` (chosen); (ii) the paper's torus — Mathlib holds `UnitAddTorus`/`mFourier`
  (`Mathlib/Analysis/Fourier/AddCircleMulti.lean`), but the route needs the periodic reduction first (a separate argument of its own,
  §2 of the paper cites it) and lattice bookkeeping for `2πL*`; (i) needs neither. (iii) Bochner's theorem on ℝ² — not in Mathlib,
  larger than (i).
- *`J₀`:* (i) integral definition + ODE + defect-certified chains (chosen: one analytic lemma, any accuracy at any argument, cost linear
  in the range); (ii) the power series — exact, but costs `O(x)` terms per evaluation (`x` up to 1,833 here) and needs termwise
  integration; (iii) Hankel's asymptotic expansion with error bounds — the textbook tool for the tail, a large formalization; replaced by
  the energy bound at `T₁ = 800`.
- *The tail threshold:* `T₁ = 600` already passes (tail sum 0.0570 < 0.0594); 800 is taken for slack (0.0494; measured on the Lean-run
  chain: 0.04940).
- *The atom check:* (i) DFS over independent sets, each term added when its highest vertex is decided (chosen; 7.19 M mask tests at the
  natural order, 4.98 M by incidence order); (ii) recomputing `L(S)` at every leaf — 63 M tests; (iii) aggregating equal masks — 4,669
  terms on 3,640 masks, a 22 % saving that costs a regrouping proof; not taken.

### 2.3 What is not ours and must be said

The certificate, the point set, the LP and its dual form are `[AmbrusEtAl2023]`'s; the averaging, the inclusion–exclusion constraints
and the Fourier relaxation descend from `[OliveiraVallentin2010]`, `[KMOR2016]` and `[Szekely1984]`. Gaussian regularization and the
energy monotonicity of `J₀² + J₁²` are classical techniques; nothing here is new mathematics. What is this route's: the arrangement that
needs no periodic reduction and no Bessel asymptotics, and the kernel certification of the analytic half.

### 2.4 The probes this stage rests on

`data/fs131/kdb1/proto/proto_chain.py` (the covering, exact Fractions), `proto_atoms.py` (the atom DFS), `data/fs131/kdb1/probes/`
(`CellProbe.lean` and its generators); their numbers are Stage 4's.

## Stage 3 — SAVED: the statements typed, the two modeling passes, the plan per leaf

### 3.1 The modules (built: `scripts/build.sh` exit 0, `data/fs131/kdb1/build3.log`; kernel signatures `data/fs131/kdb1/probes/KernelSigs.out`)

`Proofs/HadwigerNelson/Plane/DensityBound/`: `Bessel` (13 leaves), `BesselDefect` (4), `Autocorr` (5), `Pattern` (2), `Window` (3); with
`Plane/OneAvoidingDensity`'s own leaf, **28 leaves**, each a `theorem … := by sorry`; no `sorry` in a definition. `#print axioms
DualCert.oneAvoidingDensityBound_of` reads `[propext, sorryAx, Classical.choice, Quot.sound]` (the leaves). `ARCHITECTURE.md` rows in
the same commits; `tools/check_architecture.py` PASS.

### 3.2 The two modeling passes (each a fresh Skill invocation, scoped to this job; their changes in the stage 3 commit)

- **`debruijn-domain-modeling`** (on `J0`, `J1`, `jdist`, `autocorr`, `circleAvg`, `DualCert`…). Two changes. (i) **The circle average is
  Mathlib's**: `Real.circleAverage f c R` (`Mathlib/MeasureTheory/Integral/CircleAverage.lean`) exists with constants, monotonicity,
  `|·|`, sums, `circleAverage_eq_integral_add` (rotation) — my hand-made `circleAvg` was the same object without the API; it is
  removed, and `J0`, `J1` are now *defined* as circle averages over the unit circle, so `|J₀| ≤ 1` is 14 lines (§ 4.1). (ii) **The
  state is one complex number**: the Bessel system is a 2-dimensional linear system with a contraction in the Euclidean norm, so
  `Jc = J₀ + iJ₁ : ℝ → ℂ` and `besselField x w = i w − i (w.im/x)` replace the pair of reals and the hand-written `√(·² + ·²)`; the
  comparison lemma is now `‖Jc x − p x‖ ≤ ‖Jc a − p a‖ + (x − a)D` with `p : ℝ → ℂ`, and the energy is `antitoneOn_norm_Jc`
  (`HasDerivAt.norm_sq` gives `‖Jc‖²′ = 2⟨Jc, besselField x Jc⟩ = −2J₁²/x`). Kept: `DualCert` with list data (it is the published
  certificate's shape), `IsIndep` semantic (a listed-edge check implies it in the right direction: fewer edges, more sets), `Congruent`
  by an explicit isometry with the reflection bit (that is O(2)'s parametrization in `window_bound`), `w₀` outside `DualCert` (it lives
  on the Fourier side only). Unsampled members checked: `n = 0` makes `limsup_le`'s `hW` unsatisfiable (`J₀` has zeros), not a false
  conclusion; `I = ∅` in a congruence forces `J = ∅`, so `L(∅) = 0` and the infinite mass of the empty pattern is never summed.
- **`debruijn-obligation-modeling`** (on every new statement). Each statement derives in local steps; no hidden hypothesis; children
  below. Two decisions: (i) the comparison lemma keeps its hypothesis on `Ioo a b` because at `a = 0` `J₁`'s formula derivative is
  singular — its proof is the `0 < a` case plus a limit by continuity; (ii) `window_le`'s Fourier input is `sum_circleAvg_autocorr_nonneg`
  at an index type of `w₂.length + 2` terms (`w₀` at radius 1, `Σw₁ − (1 − µ)` at radius 0), so `hW` is `phi` rearranged. **A model of
  every structure-hypothesis theorem** is in its file: `trivialCert` + `trivialCert_valid` (Pattern), the `hW` example at `trivialCert`,
  `w₀ = 0`, `µ = 0` (Window; `limsup_le` then says `≤ 1`, true), the disc of radius `1/2` with the one term `c = 1, r = 0`
  (Autocorr), a defect-`1` constant pair (BesselDefect).

### 3.3 Each statement read aloud, and its plan

| leaf | says | route; Mathlib (`#check`ed) | children | hard part |
|---|---|---|---|---|
| `J0_eq_integral`, `J1_eq_integral` | the circle averages are `(2π)⁻¹∫₀^{2π} cos(x sin θ)`, `… sin θ sin(x sin θ)` | `Real.circleAverage_def`, `circleMap` at `0`, `1`: `im = sin θ` | — | none |
| `J0_zero`, `J1_zero` | `J(0) = (1, 0)` | `Real.circleAverage_const` (**proved, § 4.1**: 2 lines) | — | none |
| `abs_J0_le_one`, `abs_J1_le_one` | `|J₀|, |J₁| ≤ 1` | `abs_circleAverage_le_circleAverage_abs`, `circleAverage_mono`, `circleAverage_const` (**proved, § 4.1**: 14 lines) | — | none |
| `hasDerivAt_J0` | `J₀′ = −J₁` | `intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le` (bound `1`) | the integrand's `HasDerivAt` | measurability side goals |
| `hasDerivAt_J1` | `J₁′ = J₀ − J₁/x`, `x ≠ 0` | the same; then `intervalIntegral.integral_mul_deriv_eq_deriv_mul` on `cos θ · (sin(x sin θ))′/x` | `∫ cos²θ cos(x sin θ) = x⁻¹∫ sin θ sin(x sin θ)` (boundary terms `0` by `2π`-periodicity) | the integration by parts |
| `continuous_J0`, `continuous_J1` | continuity | from `HasDerivAt`; `J₁` at `0` by `intervalIntegral.continuous_parametric_intervalIntegral_of_continuous` | — | none |
| `antitoneOn_norm_Jc` | `‖J₀ + iJ₁‖` decreases on `[0, ∞)` | `antitoneOn_of_deriv_nonpos`, `HasDerivAt.norm_sq` | `hasDerivAt_Jc`; `⟪w, besselField x w⟫ = −w.im²/x` | none |
| `abs_J0_sub_le` | `J₀` is 1-Lipschitz | `Convex.norm_image_sub_le_of_norm_deriv_le` with `|J₁| ≤ 1` | — | none |
| `circleAverage_exp_inner` | `circleAverage (exp(i⟨ξ, ·⟩)) 0 r = J₀(r‖ξ‖)` | `Real.circleAverage_eq_integral_add` (rotate by `arg ξ − π/2`), `Function.Periodic.intervalIntegral_add_eq` | `⟪ξ, r e^{iθ}⟫ = r‖ξ‖cos(θ − arg ξ)`; `∫₀^{2π} sin(s sin θ) = 0` (`θ ↦ −θ` with periodicity) | the angle bookkeeping |
| `norm_Jc_sub_le_of_defect` | the comparison lemma | `HasDerivAt.norm_sq`, `image_le_of_deriv_right_le_deriv_boundary` (or `image_sub_le_mul_sub_of_deriv_le` on `√(‖e‖² + κ²)`) | (a) `0 < a`: `f_κ′ ≤ D` from `⟪e, besselField x e⟫ ≤ 0`; (b) `κ → 0`; (c) `a = 0` by `a′ ↓ 0` and continuity | the `a = 0` limit |
| `hasDerivAt_Jc` | `J` solves the system | `HasDerivAt` of `Complex.mk` from the two components | — | none |
| `abs_J0_sub_re_le`, `abs_J0_le_of_le` | a state bounds `J₀`; the tail | `Complex.abs_re_le_norm`, `antitoneOn_norm_Jc` | — | none |
| `autocorr_eq_zero_of_norm_eq_one` | KMOR Lemma 3.2 (1) | **proved, § 4.1** (8 lines) | — | none |
| `circleAvg_autocorr_one`, `_zero` | `F̊(1) = 0`, `F̊(0) = vol E` | `Real.circleAverage_congr_sphere`, `circleAverage_const`; at `r = 0` `circleMap` is constant | — | none |
| `continuous_autocorr` | `F` continuous | `tendsto_measure_symmDiff_preimage_nhds_zero` with translations as continuous maps, `|vol(A) − vol(B)| ≤ vol(A Δ B)` | — | the `C(ℂ, ℂ)`-valued family's convergence |
| `sum_circleAvg_autocorr_nonneg` | positive definiteness against `J₀` | `GaussianFourier.integral_cexp_neg_mul_sq_norm_add` (`b = ε/4`, `c = i`), `integral_prod`, `integral_integral_swap`, `tendsto_integral_comp_smul_smul_of_integrable'`, `intervalIntegral.tendsto_integral_filter_of_dominated_convergence`, `circleAverage_exp_inner` | (a) `Q_ε v = ∫ F(z)Γ_ε(z − v)`; (b) `Γ_ε` as a Gaussian Fourier integral; (c) Fubini to `(4π²)⁻¹∫ e^{−ε‖ξ‖²/4}|1̂_E|² Σ c_k J₀(r_k‖ξ‖)`; (d) `≥ 0` by `hW` at `t = ‖ξ‖`; (e) `Q_ε → F` pointwise; (f) circle averages converge, bounded by `vol E` | the integrability side conditions of the triple Fubini |
| `DualCert.window_bound` | the pattern expectation | `Measure.prod_apply`, `lintegral_prod`, `lintegral_finsetSum`, `measure_biUnion_finset`, `measure_preimage_add_right`, `Function.Periodic.intervalIntegral_add_eq` | `pat`; measurability; `pat` independent; Venn `N(I) = Σ_{S⊇I} P(S)` (`I ≠ ∅`); `N({i}) = 4π vol E`, `N({i,j}) = 4π F̊`, congruence invariance (translation in `y`, rotation in `θ`, reflection swaps `b`); `Σ_{S≠∅} P(S) ≤ 4π vol B(x₀, R + D)`; the summation (finite, over `Finset (Fin n)`, symbolic) | the bookkeeping of `Σ_S Σ_list` exchanges; keep `P` in `ℝ≥0∞` until finiteness is shown |
| `trivialCert_valid` | the model | `decide` on `Fin 1` subsets, `simp` | — | none |
| `DualCert.window_le` | `(1 − µ)vol E ≤ bound · vol B(x₀, R + D)` | `sum_circleAvg_autocorr_nonneg` on `Fin (w₂.length + 2)`; `window_bound`; `circleAvg_autocorr_one`, `_zero` | the reindexing of `phi` as `Σ c_k J₀(t r_k)` | none |
| `DualCert.limsup_le` | Prop. 1, finite-window form, every centre | `NullMeasurableSet.exists_measurable_subset_ae_eq`, `Complex.volume_ball`, `limsup_le_of_le`, `ENNReal.limsup_mul_le` | (a) a Borel `A′ ⊆ A` of full measure; (b) the per-`R` bound with `D = max‖X i‖`; (c) `vol B(R + D)/vol B(R) = ((R + D)/R)²`; (d) the limit | ENNReal arithmetic in (d) |
| `DualCert.oneAvoidingDensityBound_of` | the composition | `Complex.orthonormalBasisOneI.repr`, `LinearIsometryEquiv.measurePreserving`, `ENNReal.ofReal_le_ofReal` | the transfer of balls, distances and the `limsup` | none |
| `upperDensity_le_of_oneAvoidingDensityBound` (KR1's) | the reverse transfer | the same isometry | — | none |

**Statements typed in this record, not yet as modules** (each lane's first step; the names and types are fixed here):

```lean
-- Plane/DensityBound/BesselCert  (lane C)  — the checker is the probe's (data/fs131/kdb1/probes/CellProbe.lean), restated freely
structure St where (m0 m1 r : ℤ)                       -- |Jc x − (m0 + i m1)/2⁶⁴| ≤ r/2⁶⁴
def St.Valid (st : St) (x : ℝ) : Prop := ‖Jc x - ⟨st.m0 / 2 ^ 64, st.m1 / 2 ^ 64⟩‖ ≤ st.r / 2 ^ 64
theorem cellCheck_sound … : cellCheck … = true → (∀ k, (sts k).Valid (t0 * D k)) →
    (∀ t ∈ Icc t0 (t0 + w), 1 - mu ≤ w1 + Σ k, W k * J0 (t * D k) - ε_cell) ∧ ∀ k, (sts' k).Valid ((t0 + w) * D k)
theorem phiApprox_ge (covering + tail) : ∀ t : ℝ, 0 ≤ t → 1 - mu ≤ w1 + Σ k, W k * J0 (t * D k) - t * η'
-- Plane/DensityBound/X23  (lane X)  — generated data, exact algebra, the atom DFS
noncomputable def X23 : DualCert 23         -- Table 1 (the notebook's list) ×12 in Adjoin 11 (Adjoin 3 ℤ); g23.csv; bound = w_T + 10⁻⁶
noncomputable def X23w0 : ℝ := 0.378583312921677
theorem X23_valid : X23.Valid
theorem X23_phi : ∀ t : ℝ, 0 ≤ t → 1 - 6 / 10 ^ 5 ≤ X23.phi X23w0 t
theorem X23_ratio : X23.bound / (1 - 6 / 10 ^ 5) ≤ 0.2470
-- Plane/DensityBound/Theorem
theorem Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound :=
  X23.oneAvoidingDensityBound_of X23_valid (by norm_num) X23_phi X23_ratio
```

## Stage 4 — SAVED: priced from first leaves

### 4.1 The leaves written (`data/fs131/kdb1/leaves/Leaves.lean`, elaborated against the built skeleton; each on the standard three)

| leaf | lines | elaboration | result |
|---|---|---|---|
| `autocorr_eq_zero_of_norm_eq_one` (KMOR Lemma 3.2 (1), finite-window form) | 8 | the file 2.4 s, 3.1 GB (Mathlib's import) | `[propext, Classical.choice, Quot.sound]` |
| `abs_J0_le_one` (a `J₀` bound of the kind `ϕ` needs) | 14 | | the same |
| `J0_zero` | 2 | | the same |

Control: the distance step replaced by `simp` → an error (the file is checked). Each closed at the first attempt: the API the domain
pass chose carries them.

### 4.2 The certificate's arithmetic in the kernel (core only, `decide +kernel`, no `native_decide`; laptop)

**The covering of `[0, 800]`** (`data/fs131/kdb1/probes/CellProbe.lean`; plan `data/fs131/kdb1/proto/plan800.json`, generated by
`proto_chain.py`; states recomputed by the Lean evaluator, `gen_dump.py`, 9.5 s for all 847 cells, every cell passing). 847 cells
(widths `2⁻⁸ … 1`, degrees 6–23, `Σ N = 18,915`); min margin `4.24·10⁻⁶` over `1 − µ = 0.99994` (the cell `[3.75, 3.8125]` at
`9.08·10⁻⁶`); chain radius at `t = 800` at most `1.8·10⁻¹⁰`; tail at `T₁ = 800`: `Σ|w_k|‖J(800 d_k)‖ = 0.04940 ≤ 0.05944` (slack 0.0100).

| cut | cells | kernel time | peak RSS (`lean`) |
|---|---|---|---|
| `[0, 6]`, chained (states as computed terms) | 21 | **457 s** (21.8 s/cell) | 3.2 GB |
| `[0, 6]`, each cell from literal entry to literal exit states | 21 | **32.8 s** (1.5 s/cell; `Σ N = 277`) | 1.76 GB |
| `t ≈ 500`, literal states, `N = 23` | 20 | **63.7 s** (3.1 s/cell) | 1.73 GB |

Rate `≈ 0.136 s` per unit of `N` per cell (27 terms). **Whole covering: `≈ 2,570 s ≈ 43 min` CPU**, split into about 45 modules of ~19
cells (≈ 60 s and ≤ 1.8 GB each). Controls: target `1 − 4.9·10⁻⁵` (above the true minimum `0.99995003`) → the evaluator says `none`.

**The atom check** (`proto_atoms.py`, `gen_atoms.py`): 47 unit edges, 4,669 terms (3,640 masks), 13,552 independent sets, **min V =
−6.712244·10⁻⁸** (J26's); the DFS adds a term when its highest vertex is decided: 7,190,266 mask tests in the natural order. Controls:
bound − `9.3·10¹³/10²⁰` passes (slack `9.329·10⁻⁷`), bound − `10⁻⁶` fails. Kernel: the subtree "vertices 0–13 out" (96,253 tests) **15.0 s,
2.23 GB**; the subtree "0–7 out" (664,098 tests) passed 8 GiB in 51 s and was killed by its cap (the coordinator's diagnosis: exit
143 was the scope's OOM kill). So **≈ 100 µs and ≈ 15 KB of kernel cache per test**: the whole check is **≈ 12 min CPU**, split into
about 75 subtree theorems of ≤ 100 k tests (a prefix enumeration whose completeness is one small DFS). Unmeasured: whether a module
holding ten such theorems peaks at one theorem's memory (the kernel's caches are per declaration — to confirm on the first module).

**Not yet measured**: the 47 edges and 2,321 congruences in `ℚ(√3, √11)(i)` (J26 took 2.7 s in Python; `Field/Quadratic` measured 99 de
Grey edges at 13.8 s in the kernel, so ~5,000 small identities is minutes), the 27 distance enclosures.

### 4.3 The price

| part | lines (est.; the three priced leaves ran at or under estimate) | kernel CPU |
|---|---|---|
| Bessel + BesselDefect (17 leaves) | 600 | — |
| Autocorr (5) | 900 | — |
| Pattern + Window + the transfer (6) | 1,150 | — |
| BesselCert: checker, soundness, covering assembly, tail | 900 + generator | 43 min (covering) |
| X23: data generator, edges, congruences, distances, atom DFS + soundness | 700 + generator | 12 min (atoms) + minutes |
| **total** | **≈ 4,250 hand-written** (≈ 2,500–6,500) | **≈ 1 h**, splittable to ≈ 10 min wall on 12 cores |

At the measured 900 lines per active hour and implementers at one half to three quarters of a planner's lines: **about 3–5 active
hours per lane-sum, a few agent-days in all** — against KR1's 3–6 agent-weeks from coverage. No classical input prices over 2,000
lines; no certificate cut is near an hour or 16 GiB.

## Stage 5 — SAVED: lanes (no shared file)

| lane | files | leaves | lines | waits on |
|---|---|---|---|---|
| **B — Bessel** | `Plane/DensityBound/Bessel`, `BesselDefect` | 17 | 600 | nothing |
| **F — Fourier** | `Plane/DensityBound/Autocorr` | 5 | 900 | B's statements only (imports them; can run against B's `sorry`s) |
| **P — patterns and window** | `Plane/DensityBound/Pattern`, `Window`; `Plane/OneAvoidingDensity`'s leaf | 6 | 1,150 | F's statements |
| **C — the covering** | `Plane/DensityBound/BesselCert` + generated `Plane/DensityBound/Cells/*` (≈ 45) + `tools/fs131_kdb1_cells.py` | checker soundness + data | 900 | B's statements (`norm_Jc_sub_le_of_defect`, `abs_J0_le_of_le`, `abs_J0_sub_le`) |
| **X — the instance** | `Plane/DensityBound/X23*` (data, edges, congruences, distances, atoms) + `Plane/DensityBound/Theorem` + `tools/fs131_kdb1_x23.py` | `X23_valid`, `X23_phi`, `X23_ratio`, the theorem | 700 | P's `DualCert` (definitions only) for the data; C's `phiApprox_ge` and its own distance bounds for `X23_phi` |

The critical path is C (kernel time plus the checker's soundness proof). Every lane's statements are fixed here; the checker functions
inside C and X are the implementers' to restructure (the probe is a measured prototype, not a statement).

## Stage 6 — SAVED: drafts (for the files Keryx writes)

**`data/fs131/claims-NF2.md`**, after its last line:
- 2026-10-14 — **The density bound has a route with no periodic reduction and no Bessel citation** (FS131-KDB1): `DualCert.oneAvoidingDensityBound_of` (`Plane/DensityBound/Window`) — any valid dual certificate with `bound/(1 − µ) ≤ 0.2470` and `ϕ ≥ 1 − µ` on `[0, ∞)` proves `Plane.OneAvoidingDensityBound`; finite window `E = A ∩ B(x₀, R)`, patterns integrated over all of `ℂ`, Gaussian-regularized positive definiteness, `J₀` by its integral, its ODE and the antitone `‖J₀ + iJ₁‖`; `[AmbrusEtAl2023]`'s certificate unchanged.
- 2026-10-14 — **The certificate's analytic half is priced in the kernel** (FS131-KDB1): 847 cells cover `[0, 800]` with margin `4.24·10⁻⁶` (≈ 43 min CPU, ≤ 1.8 GB per module), the tail at `T₁ = 800` by the energy with slack 0.0100; the atom check 7.19 M mask tests (≈ 12 min CPU in ≤ 100 k-test theorems); `min V = −6.712244·10⁻⁸` reproduced.

**`BIBLIOGRAPHY.md`**: `[AmbrusEtAl2023]` read column — add "re-read in full, §§ 1–9 and Tables 1–2 (FS131-KDB1, 2026-10-14)"; role
column — add "Theorem 1 formalized on a finite-window route (FS131-KDB1, `plans/FS131-KDB1-density-bound.md`): Watson §§ 7.21, 13.74,
15.31 and the periodic reduction [deOV10, KeMOR16] not used". `[KMOR2016]` read column — add "§ 3, Lemma 3.2 and pp. 9–11 (FS131-KDB1)".
No new key: the route cites nothing the paper does not.

**`LEAN.md` § The kernel's cost model**, after the line on `∀ x ∈ l`:
- A chained kernel computation whose state is passed on as computed terms re-pays them: 21 cells of the `J₀` covering took 21.8 s per cell chained and 1.5 s per cell when each cell was checked from literal entry states to literal exit states (`data/fs131/kdb1/probes/`). Check a long chain link by link, the states as literals produced by the evaluator (FS131-KDB1).
- A kernel DFS of mask tests costs about 100 µs and 15 KB of cache per test: 96 k tests 15 s and 2.2 GB, 664 k tests past 8 GiB in 51 s. Split such a check into theorems of at most about 100 k tests (FS131-KDB1).

**`LEAN.md` § Searching — Lean**:
- A list literal of 4,669 `(Nat × Int)` pairs with negative entries exhausts 200,000 heartbeats in elaboration and, with the limit off, `maxRecDepth` after 110 s; the same data as 4,669 packed `Nat`s (`mask + 2²³·(c + 2⁶⁸)`) under `set_option maxRecDepth 100000` elaborates in about 5 s (FS131-KDB1).
- Mathlib's `Real.circleAverage f c R` (`Mathlib/MeasureTheory/Integral/CircleAverage.lean`) carries constants, monotonicity, `|·|`, sums and `circleAverage_eq_integral_add`; defined through it, `|J₀| ≤ 1` is 14 lines. Mathlib has no Bessel function (FS131-KDB1).
- The micro sign `µ` (U+00B5) is not an identifier character ("expected token"); Greek `μ` (U+03BC) is (FS131-KDB1).
