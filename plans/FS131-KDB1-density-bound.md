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
