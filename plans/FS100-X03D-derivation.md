*Derivation record of crunch job **X03D** (route (C) of the ×2×3 crunch: the Fourier form, the flip and the consumer), de Bruijn, Opus 5.5,
2026-09-26. Brief: `data/crunch-2026-09-26-x2x3/briefs/X03D-fourier-flip-derivation.md` (with its 05:45 addendum, commit `43b04d74`), and
`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` as part of it. No subagents; no finite-witness search (ban to 2026-10-01). I touch
only this file, `data/fs100/x03d/`, `tools/x03d_*.py` and my report. Blind verifiers (X02V, X05V) work the same claims; not contacted.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| X03D-FR1 | for every real number field `F`, the `U`-orbits on `R` are exactly the fibres of `x ↦ x x̄`; a finite measure `τ` on `R̂` is `U`-invariant iff `τ̂` is constant on those fibres (FR-1 TRUE) | [hand] | §2.1 |
| X03D-ED1 | for every real number field `F` and every sequence of finite non-empty `Y_N ⊆ U`: if every `χ ∉ E` has `(1/#Y_N) Σ_{u∈Y_N} χ(u) → 0`, then MR(F); so ED-1 is TRUE whenever `U_N` is finite, in particular for every totally real `F` | [hand] | §2.2 |
| X03D-FL-K | for every rotation-invariant random proper four-colouring over a real field, `ν := σ|_{R̂∖E}` has `ν̂(u)/ν(R̂) = −P(c¹(0) = c²(u)) / P(c¹(0) ≠ c²(0))` for every `u ∈ U`, `(c¹, c²)` the relatively independent self-joining over the `E`-factor | [hand] | §3.2 |
| X03D-FL-1a | FL-1's first two clauses: over ℚ(√47), given T-C(A) at `S = ∅`, `τ ≠ 0`, `τ` is not a Haar multiple, and `τ̂(u) = τ̂(1)` for every `u ∈ U`, for every admissible `a` | [hand] | §3.2 |
| X03D-SPEC | every `U`-invariant finite positive `ρ` carried by `T + A` has `ρ̂(1) ≥ −Λ(F)·ρ(R̂)`, `Λ(F) := −inf_{T+A} M ≥ −J₀(j₁,₁) = 0.402759` over every real field, and this is sharp; at ℚ(√47) `Λ = 0.402759` (the real place; 11 gives 0.3996, 19 gives 0.3805) | [hand + tools, float with controls] | §3.3, `tools/x03d_factor_minima.py` |
| X03D-FL-H | over a real field where T-C(A) holds at `S = ∅`, FL-1's inequality and FL-2's implication both follow from `Λ(F) ≤ 1/3`; that hypothesis fails over every real field (the real place) | [hand] | §3.4 |
| X03D-FL-12 | FL-1 ⟹ FL-2 (given T-C(A) at `S = ∅` and the upper bound `χ ≤ 5`) | [hand] | §3.5 |
| X03D-FL-Q | if `s_E := σ_E(R̂) ≤ s* < 1/(3Λ) = 0.8276` for every four-colouring, the consumer needs only "every non-zero `U`-invariant `E`-null `ν` has `ν̂(1)/ν(R̂) > (−1/3 + Λ s*)/(1 − s*)`", a threshold in `(−1/3, 0)` | [hand] | §3.5 |
| X03D-ED1-R | for `F` with a complex place (e.g. ℚ(∛2)), `U_1` is infinite (norm-one units, rank `r₂(F)`), so ED-1's average is undefined as written; with the archimedean places added to `H`, ED-1 holds with the same proof | [hand] | §2.2 |

## Stage 1 — SAVED (quotation check, claims copied, C0, the Bekka–Francini discharge)

### 1.1 The claims, copied verbatim from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2

**Notation** (from `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`, verbatim): "`F ⊆ ℝ` a real number field, `L = F(i)`,
`U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its dual; `T` the torsion characters, `A(R_F)` the archimedean ones,
`E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places) — `LEDGER.md` rows 98, 113." Added here: `U` acts on
`R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on `R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`; for `u ∈ U`,
`H(u) = ∏_w max(1, |u|_w)` over the finite places `w` of `L` (normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`.

- **FR-1.** "For every real number field `F`, the `U`-orbits on `R ∖ {0}` are exactly the non-empty fibres of `x ↦ x x̄`; so a finite
  positive measure `τ` on `R̂` is `U`-invariant if and only if `τ̂(x) = τ̂(y)` whenever `x x̄ = y ȳ`."
- **ED-1.** "If, for every `χ ∈ R̂ ∖ E`, `lim_{N→∞} (1/#U_N) Σ_{u ∈ U_N} χ(u) = 0`, then MR(F) holds."
- **ED-2.** "Over `F = ℚ`, the hypothesis of ED-1 holds." (TRUE, or FALSE with an explicit `χ ∉ E`, or GAP at a named step.)
- **FL-1** (the example invariant). "Over ℚ(√47), given T-C(A) at `S = ∅` and rows 112–113's inputs: for every translation- and
  rotation-invariant random proper four-colouring of the plane, with the colours embedded as the vertices of a regular tetrahedron centred at
  `0` and `σ` the trace of its spectral measure on `R̂` (`σ(R̂) = 1`), write `σ = a·m + σ_E + τ` with `σ_E` carried by `E` and `τ(E) = 0`
  non-Haar. Then `τ ≠ 0`, and `τ̂(u) = τ̂(1) ≤ −τ(R̂)/3` for every `u ∈ U`."
- **FL-2** (what the consumer needs). "Over ℚ(√47), given T-C(A) at `S = ∅`: if every `U`-invariant, `E`-null finite positive measure `τ` on
  `R̂` satisfies `τ̂(1) > −τ(R̂)/3` whenever `τ ≠ 0`, then `χ(ℚ(√47)²) = 5`."

MR(F), verbatim (`plans/STUB-measure-rigidity-three-fields.md` line 58, quoting J38 §3.5, T-J38-2 (iii)): "every `U`-invariant finite
positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure".

### 1.2 Quotation check (standing rule 5)

| quotation in the brief | source | result |
|---|---|---|
| MR(F) | stub §1, line 58 | **verbatim** |
| list X03 (FR-1 … FL-2) | queue §2 | copied from the source itself (1.1), so verbatim by construction |
| SP-Cor, A⁺, R-U, SP-if (read, used below) | `plans/FS84-SI-D-derivation.md` §Stage 3, §4.1, §4.2 | read in full; I quote them from there, not from the brief |
| the advisor on Bekka–Francini: "It assumes G(k) is generated by its unipotent elements, and its measure step is Ratner's theorem … Our group R ⋊ U is a torus acting on a line. It is not generated by unipotents." | `plans/POROS-2026-09-26-x2x3-crunch.md` line 134–135 reads: "it assumes `G(k)` is generated by unipotents, and it uses Ratner. `R ⋊ U` is a torus acting on a line, so the hypothesis fails." | **not verbatim; same substance.** The brief's wording is a paraphrase (or comes from a message not on disk). No claim changes. |
| the addendum's Poros quotations ("ED-2 is harder than MR …", "ED-1 itself is one line …") | relayed by the owner; not on disk in the Poros record I grepped | unchecked (relayed verbatim by the owner); I use them only as advice |
| "Nazarov's construction, reproduced in EF" | `data/crunch-2026-09-26-x2x3/poros/ef.txt` lines 259–262 ("It was pointed out to us by Fedor Nazarov that for every α ∉ ℚ …") | present in the source |

### 1.3 Bekka–Francini — discharged from the theorem's statement

Grep: `BIBLIOGRAPHY.md` has no row for arXiv 2002.07497 or Zbl 1518.22005 (only plans mention it); `~/source/library/` holds no copy. Fetched
the arXiv PDF (copy: `data/fs100/x03d/bekka-francini-2002.07497.pdf`, text `data/fs100/x03d/bf.txt`). **Read: abstract, §1 (pp. 1–5: Theorem 1.1,
its proof sketch, Remark 1.2 (i)–(v)); the rest unread.**

- Theorem 1.1, verbatim (p. 3): "Let G = G(k) be the group of k-rational points of a connected linear algebraic group G over a number field
  k. Assume that G is generated by its unipotent one-parameter subgroups and let G = LU be a Levi decomposition of G."
- Remark 1.2 (iii), verbatim (p. 5): "The assumption that G is generated by its unipotent one-parameter subgroups is equivalent to the
  assumption that the Levi component L of G is semi-simple and that L+ = L".
- Remark 1.2 (iv), verbatim: "A general result about Char(G) cannot be expected when the condition L = L+ is dropped".
- The measure step (p. 4): "We classify all such measures (Theorem 5.8); for this, we use Ratner's measure rigidity results for homogeneous
  spaces of S-adic Lie groups".

**Verdict [read, §1]: the advisor's reading is confirmed, with two independent reasons it does not apply.** (1) The algebraic group behind
our problem is `G = 𝔾_a² ⋊ T` over `F`, with `T = R¹_{L/F}𝔾_m` the norm-one torus acting on `L ≅ 𝔾_a²`. Its Levi component is the torus `T`,
which is not semisimple, so by Remark 1.2 (iii) the hypothesis of Theorem 1.1 fails; the unipotent elements generate only `L`. (2) Theorem 1.1
is about `G(k)`, whose unipotent radical is all of `L = F(i)`; MR is about the subring `R = ℤ[U] = O′` (row 100), an `S`-arithmetic lattice in
`L`, not a `k`-vector space. What *does* transfer is the frame: a `U`-invariant positive-definite function on `R` is a conjugation-invariant
function of positive type on `R ⋊ U` (extend by `0` off `R`), which is Bekka–Francini's object; and their Remark 1.2 (iv) says the torus
(anisotropic Levi) case is exactly the one where no general result is expected. **Proposed `BIBLIOGRAPHY.md` row** (for the front-page lane):
`[BekkaFrancini2022]` — B. Bekka, C. Francini, *Characters of algebraic groups over number fields*, Groups Geom. Dyn. (2022), arXiv 2002.07497,
Zbl 1518.22005; copy `data/fs100/x03d/bekka-francini-2002.07497.pdf` (to move to `~/source/library/`); read: abstract and §1 (Theorem 1.1,
Remark 1.2); §§2–7 unread; role: the nearest classification of invariant positive-type functions in print, inapplicable to FS-100's MR (torus Levi
component; `k`-points, not a ring).

### 1.4 C0 — probabilities before derivation

Written at 05:55 (an earlier text said 06:03, a slip), after the reading above and a ten-minute mental sketch while reading (so not a pure prior; said so).

| claim | P(TRUE as stated) | the step I expect to decide it |
|---|---|---|
| FR-1 | 0.97 | `y/x` has norm one, so it lies in `U`; then Fourier uniqueness |
| ED-1 | 0.85 | dominated convergence plus `r⁻¹E ⊆ E` (SP-if step 2); risk: `U_N` infinite when `F` has a complex place (norm-one units) |
| ED-2 | 0.2 | the planner's named risk: a character non-trivial only at a sparse set of split places; I expect a local-factor product `∏(1 − 1/p)` |
| FL-1 | 0.3 derivable from the named inputs (0.5 true) | whether the `E`-part's unit correlation per unit mass is `≥ −1/3`; I expect this needs a Hoffman-type spectral bound, which fails at the real place (`J₀(j₁,₁) ≈ −0.4028`) |
| FL-2 | 0.3 derivable | the same step as FL-1 |

### 1.5 Would-have-searched-here log (stage 1)

- None.

## Stage 2 — SAVED (FR-1 and ED-1)

**Verdicts. FR-1: TRUE** [hand], every real number field. **ED-1: TRUE** [hand] for every real number field where `U_N` is finite, which
includes every totally real `F` (so ℚ, ℚ(√47), ℚ(√167), K); **ill-posed as written** when `F` has a complex place, where `U_1` is already
infinite; true there too once `H` includes the archimedean places. The addendum's one-line proof ("dominated convergence, plus the fact that
r^{-1}E ⊆ E for r ≠ 0") is the proof below.

### 2.1 FR-1

*Proof.* Conjugation `x ↦ x̄` is the non-trivial automorphism of `L/F`, and `U` is the set of all `u ∈ L` with `u ū = 1` (notation, verbatim:
"the unit vectors (norm-one elements of `L/F`)"). (a) `R` is a ring containing `U`, so `U·x ⊆ R`, and `(ux)(ux)‾ = x x̄`: each orbit lies in a
fibre. (b) Let `x, y ∈ R ∖ {0}` with `x x̄ = y ȳ`. In the field `L`, `u := y/x` satisfies `u ū = y ȳ/(x x̄) = 1`, so `u ∈ U` and `y = u x`: the
fibre lies in one orbit. The fibre over `0` is `{0}`, since `x x̄ = 0` forces `x = 0` in a field. (c) For `u ∈ U`, the push-forward of `τ` under
`χ ↦ u·χ` has Fourier coefficients `∫ (u·χ)(x) dτ = ∫ χ(ux) dτ = τ̂(ux)`. A finite measure on the compact group `R̂` is determined by its
coefficients on the discrete group `R`, so `τ` is invariant under every `u` iff `τ̂(ux) = τ̂(x)` for all `u ∈ U`, `x ∈ R`, iff (by (a), (b))
`τ̂(x) = τ̂(y)` whenever `x x̄ = y ȳ`. ∎

*The Fourier form of MR, restated.* `τ̂(x) = φ(x x̄)` for a function `φ` on the norm set `{x x̄ : x ∈ R}`. So MR(F) says: every positive-definite
function on the discrete group `R` that factors through the quadrance `x ↦ x x̄` and has an `E`-null spectral measure is `c·δ₀`. This is a
Schoenberg-type statement (radial positive-definite functions), but on an `S`-arithmetic ring, not on a Euclidean space.

### 2.2 ED-1

**Lemma X03D-ED1 [hand].** Let `F` be a real number field and `(Y_N)` any sequence of finite non-empty subsets of `U`. If every `χ ∈ R̂ ∖ E`
satisfies `A_N(χ) := (1/#Y_N) Σ_{u∈Y_N} χ(u) → 0`, then MR(F).
*Proof.* Let `τ` be `U`-invariant, finite, positive, with `τ(E) = 0`, and fix `x ∈ R ∖ {0}`. By FR-1, `τ̂(ux) = τ̂(x)` for every `u ∈ U`, so
`τ̂(x) = (1/#Y_N) Σ_{u∈Y_N} τ̂(ux) = ∫ A_N(x·χ) dτ(χ)`, where `(x·χ)(r) = χ(xr)`. J45's SP-if step (2) (`plans/FS84-SI-D-derivation.md` §4.2,
verbatim: "**Off `E`:** if `χ(r₀·) ∈ E_S` then `χ ∈ E_S`") gives: `χ ∉ E ⟹ x·χ ∉ E`. So `A_N(x·χ) → 0` for `τ`-almost every `χ`, `|A_N| ≤ 1`, and
`τ` is finite: by dominated convergence `τ̂(x) = 0`. Hence `τ̂ = τ(R̂)·δ₀ = τ(R̂)·m̂`, and `τ = τ(R̂)·m`. ∎

**When `U_N` is finite.** For `u ∈ U`, `ū = u⁻¹`. If `F` is totally real, `L` is CM and conjugation is complex conjugation at every archimedean
place, so `|u|_w = 1` at every archimedean `w`; then `H(u)` is the full multiplicative height, and Northcott gives `#U_N < ∞`; `1 ∈ U_N`.
ED-1 is the lemma with `Y_N = U_N`.

**When it is not (X03D-ED1-R).** If `F` has a complex place, the relative norm-one units `{ε ∈ O_L^× : ε ε̄ = 1}` have rank
`rk O_L^× − rk O_F^× = (r₁(F) + 2r₂(F) − 1) − (r₁(F) + r₂(F) − 1) = r₂(F) ≥ 1`, and each has `H(ε) = 1` (a unit at every finite place). So
`U_1` is infinite and `(1/#U_N) Σ` is undefined; ED-1 as written is ill-posed there (F = ℚ(∛2): `r₂ = 1`). Adding the archimedean places to
`H` makes `U_N` finite (Northcott) and the lemma applies unchanged. This touches no field the project uses (all totally real so far).

*Remark (the addendum's point, recorded).* ED-1's hypothesis is sufficient, not necessary: the lemma needs pointwise convergence for every
`χ ∉ E`, while MR constrains only what an invariant measure can charge. Stage 4 makes this concrete over ℚ.

### Would-have-searched-here log (stage 2)

- None: both are short derivations.

## Stage 3 — SAVED (FL-1 and FL-2)

**Verdicts. FL-1: GAP.** Its first two clauses are TRUE (`τ ≠ 0`, non-Haar, `τ̂(u) = τ̂(1)`: X03D-FL-1a). Its inequality
`τ̂(1) ≤ −τ(R̂)/3` is **not derivable from T-C(A) and rows 112–113's inputs**. The planner's route (bound the `E`-part's unit correlation by
the factors) fails at one named step, and the step fails over **every** real field, not only ℚ(√47). **The step:** the `E`-part must satisfy
`σ̂_E(1) ≥ −(σ_E(R̂) + a)/3`, the Hoffman-type condition `Λ ≤ 1/3` on the `E`-completion. The spectral input gives only `≥ −Λ·σ_E(R̂)`, with
`Λ = 0.402759` at ℚ(√47): the real place's Bessel minimum, where the Hoffman bound is `0.2871 > 1/4`. The ratio-`< 1/4` inputs (`m₁ ≤ 0.2470`,
FS-66 at 11 and 19) are integrality statements and enter only through T-C(A), which gives `σ̂_E(1) > −1/3`, not normalised by mass. FL-1 is
vacuously true if `χ(ℚ(√47)²) = 5`, so no FALSE is available short of a four-colouring of that plane. **FL-2: GAP at the same step.** It
follows from FL-1 (X03D-FL-12), and its hypothesis is implied by MR, but its sufficiency is exactly FL-1's missing inequality.

### 3.1 Setting (J45's, `plans/FS84-SI-D-derivation.md` §1.2)

`μ` is an `R ⋊ U`-invariant probability on `X₄(F)`, `g(x) = e_{c(x)}` (tetrahedral), `σ = σ_μ` with `σ̂(y) = E⟨g(0), g(y)⟩`. So `σ(R̂) = 1`,
`σ̂(u) = −1/3` for every `u ∈ U` (properness), and `σ` is `U`-invariant (SP-Cor's proof). R-U gives `σ(E ∖ (T + A)) = 0`, so `σ_E := σ|_E = σ|_{T+A}`.
`ν := σ|_{R̂∖E}` is `U`-invariant, positive and `E`-null. Haar measure is `E`-null (J45-N1), so FL-1's `a·m + τ` is a split of `ν`. **Reading of
"non-Haar":** `a` is not fixed by the claim; I keep it free in `[0, a_max]`, `a_max = sup{b : ν − b·m ≥ 0}`. The inequality is weakest at
`a = a_max`, and every verdict below holds for every admissible `a`. `p(x) = P(c(x) = · | 𝒜_∅)`, `h = E[g | 𝒜_∅] = Σ_j p_j e_j`, and by J45-N2
`σ̂_E(y) = E⟨h(0), h(y)⟩`.

### 3.2 What every actual four-colouring's spectrum carries (the example invariant, G79)

**Lemma X03D-FL-K [hand].** With `(c¹, c²)` the relatively independent self-joining of `μ` over `𝒜_∅` and `u ∈ U`:
`ν̂(u) = −(4/3) P(c¹(0) = c²(u))`, `ν(R̂) = (4/3) P(c¹(0) ≠ c²(0))`, hence **`ν̂(u)/ν(R̂) = −P(c¹(0) = c²(u)) / P(c¹(0) ≠ c²(0))`.**
*Proof.* `⟨e_j, e_k⟩ = (4/3)δ_jk − 1/3` and `Σ_j p_j = 1` give `⟨h(0), h(y)⟩ = (4/3)⟨p(0), p(y)⟩ − 1/3`, and `E⟨p(0), p(y)⟩ = P(c¹(0) = c²(y))`
(conditional independence). At `y = u`: `ν̂(u) = σ̂(u) − σ̂_E(u) = −1/3 − (4/3)P(c¹(0) = c²(u)) + 1/3`. At `y = 0`:
`ν(R̂) = 1 − E|h(0)|² = (4/3)(1 − P(c¹(0) = c²(0)))`. ∎ The first identity is J45-SI-3 (read from the source, not re-proved). The ratio is new
here, as far as I know.

**Lemma X03D-FL-1a [hand; given T-C(A) at `S = ∅`].** For every admissible `a`: `τ := ν − a·m` is `U`-invariant, `τ̂(u) = τ̂(1)` for `u ∈ U`,
`τ ≠ 0`, and `τ` is not a multiple of Haar measure.
*Proof.* `ν` and `m` are `U`-invariant, and `u x̄u = 1 = 1·1̄`, so FR-1 gives `τ̂(u) = τ̂(1)`. A⁺ at `S = ∅` with its remark (ii) gives
`∫_{R̂∖E_∅} Re χ(1) dσ < 0`; `E ∖ E_∅` is `σ`-null (R-U), so `ν̂(1) < 0`. `m̂(1) = 0`, so `τ̂(1) = ν̂(1) < 0`, which no Haar multiple (`τ = 0`
included) has. ∎

So, in the joining's words, every four-colouring over ℚ(√47) carries: **a monochromatic unit edge between the two conditionally independent
copies has positive probability** (A⁺), and its ratio to a pointwise disagreement is the normalised unit correlation of the `E`-null part.
**FL-1's inequality, restated exactly:**

> (★) `P(c¹(0) = c²(u)) ≥ P(c¹(0) ≠ c²(0))/3 − a/4`, equivalently `σ̂_E(1) ≥ −(σ_E(R̂) + a)/3`.

The two copies independent (`p ≡ 1/4`) give `1/4` against `(3/4)/3`: equality at `a = 0`. (★) says the `E`-factor can never push the
cross-monochromatic rate below that independent baseline, per unit of disagreement.

### 3.3 The spectral input: `Λ`

**Lemma X03D-SPEC [hand; the numbers tools].** Let `ρ` be a `U`-invariant finite positive measure carried by `T + A`. Then
`ρ̂(1) = ∫ M(χ) dρ(χ)`, where `M(χ) = ∏_v M_v(χ_v)` is the mean of `χ` over the closure `Ū` of `U` in the compact group on which `χ|_U` is
continuous: the stable places at `χ`'s torsion level and the circles `T(F_v)` at the real places `v`. So `ρ̂(1) ≥ −Λ(F)·ρ(R̂)` with
`Λ(F) := −inf_{χ∈T+A} M(χ)`, and the bound is sharp.
*Proof.* A character in `T + A` is `θα` with `θ` of finite order `n`, factoring through `R/nR`, i.e. through the stable places dividing `n` at
finite level, and `α(r) = e(Σ_w Re(ξ_w r_w))` over the complex places `w` of `L`. On `U`, `χ` extends continuously to `Ū ⊆ ∏_{v∈Σ} T(F_v)`
(`Σ` finite: those stable places and the real places). `T = R¹_{L/F}𝔾_m` is rational, so weak approximation makes `U = T(F)` dense in
`∏_{v∈Σ} T(F_v)`: `Ū` is the whole product, and its Haar measure is the product. `ρ̂(u) = ρ̂(1)` on `U` (FR-1) and `u ↦ ρ̂(u)` is continuous
on `Ū` (dominated convergence), so `ρ̂(1) = ∫_Ū ρ̂ dHaar = ∫ (∫_Ū χ) dρ = ∫ M dρ` (Fubini). The local means are normalised eigenvalues:
`J₀(2π|ξ_w|)` at a real place, and the character sum over the circle at a stable place's level. Each lies in `[−Λ_v, 1]`, and an odd number of
negative factors gives a product `≥ −max_v Λ_v`. So `Λ(F) = max_v Λ_v`, attained by one factor at its minimum with every other factor
trivial. Sharpness: SP-if step (3)'s `λ` (uniform on the circle `|ξ| = j₁,₁/(2π)` at one complex place) is `U`-invariant, carried by
`A`, with `λ̂(1) = J₀(j₁,₁)`. ∎

**At ℚ(√47)** (`tools/x03d_factor_minima.py`; float with controls; the plant, one point dropped from the circle, turns the control at 31 red):
real place `J₀(j₁,₁) = −0.402759`; 11: `−0.399646`; 19: `−0.380486`; controls 23: `−0.331695` (margin `+1.638·10⁻³`, R88-TC-tab "23 by
`1.6·10⁻³`") and 31: margin `+4.880·10⁻⁶` (R88-TC-tab "31 by `4.9·10⁻⁶`"). Every other stable place satisfies H* (R88-TC-tab below 72; Weil
above), the dyadic place is split (no torsion characters: `1/2 ∈ R`), and inert towers keep the ratio (G54). So **`Λ(ℚ(√47)) = 0.402759`,
attained at the real place.** And `Λ(F) ≥ 0.402759` over **every** real field, because `A` always contains the circle characters.

### 3.4 Where the route stops, and a scenario the inputs cannot exclude

The inputs give two lower bounds on `σ̂_E(1)`: A⁺ (from T-C(A), hence from the ratio-`< 1/4` facts) gives `> −1/3`, and X03D-SPEC gives
`≥ −Λ·σ_E(R̂)`. (★) needs `≥ −(σ_E(R̂) + a)/3`. With `a = 0`, **the window `−Λ·s_E ≤ σ̂_E(1) < −s_E/3` (`s_E = σ_E(R̂) ∈ (0, 1)`) is excluded by
neither.** It is non-empty exactly because `Λ > 1/3`.

**Lemma X03D-FL-H [hand].** If `Λ(F) ≤ 1/3` and T-C(A) holds at `S = ∅`, then (★) holds for every `μ`, and so do FL-1's inequality and FL-2's
implication (both clauses). *Proof:* X03D-SPEC with `Λ ≤ 1/3` is (★) at `a = 0`, and a larger `a` only weakens (★). ∎ **Its hypothesis fails
over every real field** (the real place, 3.3). So the planner's route is closed for FL-1 everywhere, not only at ℚ(√47).

**The scenario (why no argument from these inputs alone can prove (★)).** Take `ξ` uniform on the circle `|ξ| = j₁,₁/(2π)` in the first
complex place, `φ` a uniform phase, `v ∈ ℝ⁴` with `Σ v_j = 0`, `ε|v_j| ≤ 1/4`, and set `p(x) = (1/4)𝟙 + ε v cos(2π Re(ξ̄ x_{w₁}) + φ)`.
- It is a stationary, rotation-invariant field of probability vectors indexed by `R`, and its spectrum lies on `A ⊆ E`.
- With `δ = p − 1/4`: `E⟨δ(0), δ(u)⟩ = J₀(j₁,₁)·E|δ(0)|² = −0.4028·V`, `V = E|δ|²`.
- If it were the `E`-projection of a four-colouring, then `P(c¹(0) = c²(u)) − P(c¹(0) ≠ c²(0))/3 = −(Λ − 1/3)V = −0.0694·V < 0`: (★) fails
  at `a = 0`.
- Meanwhile the joining's monochromatic rate is `1/4 − 0.4028·V > 0`, so A⁺'s conclusion holds.
- It is not a colouring (`p` is far from the vertices), so T-C(A) does not touch it.
- Its `E`-null complement would have normalised unit correlation `−1/3 + O(V)` above `−1/3`, so FL-2's hypothesis does not touch it either.

Whether a field of this kind can be the `E`-projection of a proper four-colouring of ℚ(√47)'s plane is exactly the missing input. This is
not a counterexample: a counterexample needs a four-colouring, and one would falsify the conjecture's five-clause at ℚ(√47) by itself. It
shows that (★) needs an input about how a proper colouring's fractional `E`-projection can oscillate, which the listed inputs do not supply.
The fractional side is where the real place's Hoffman value `0.2871 > 1/4` lives; `m₁ ≤ 0.2470` uses integrality (the set constraints of
`[AmbrusEtAl2023]`) that a conditional expectation does not satisfy.

### 3.5 FL-2, and what the consumer can be given instead

**Lemma X03D-FL-12 [hand].** FL-1 ⟹ FL-2. *Proof:* if `X₄ ≠ ∅`, take `μ` (SP-Cor's amenability step). FL-1's `τ ≠ 0` has
`τ̂(1) ≤ −τ(R̂)/3`, contradicting FL-2's hypothesis. So `χ ≥ 5`, and `χ ≤ 5` is row 84's. ∎

**FL-2 without FL-1.** Under FL-2's hypothesis, every four-colouring would sit in the window of 3.4 (`σ̂_E(1) < −s_E/3`, because
`ν̂(1) > −ν(R̂)/3` with `ν = τ + a·m` and `m̂(1) = 0`). Nothing listed excludes the window, so the implication is GAP at (★). FL-2's hypothesis is
implied by MR (for `ν = a·m`, `ν̂(1) = 0 > −a/3`), so FL-2 would be a genuinely smaller consumer if (★) were supplied.

**The only homogeneous consumer the spectral inputs support is SP's.** From 3.2–3.3, the normalised unit correlation of the `E`-null part obeys
`κ(ν) := ν̂(1)/ν(R̂) ≤ (−1/3 + Λ s_E)/(1 − s_E)`. As `s_E → 1` this bound tends to `+∞`, so without control of `s_E` all that survives is A⁺'s
`κ < 0`. "No `U`-invariant `E`-null `ν` has `κ(ν) < 0`" is equivalent to MR (J45's SP, both directions). So:
- **Lemma X03D-FL-Q [hand].** If some `s* < 1/(3Λ) = 0.8276` bounds `s_E` for every rotation-invariant four-colouring over ℚ(√47) (a
  *quantitative* T-C(A): the `E`-factor explains at most `s*` of the colouring's variance), then the consumer needs only "every non-zero
  `U`-invariant `E`-null `ν` has `κ(ν) > κ* := (−1/3 + Λ s*)/(1 − s*)`", with `κ* ∈ (−1/3, 0)`. *Proof:* the displayed bound at `s_E ≤ s*`,
  and `(−1/3 + Λs)/(1 − s)` increases in `s`. ∎
- T-C(A) itself says only `s_E < 1` for each `μ` (`s_E = 1` iff `c` is `𝒜_∅`-measurable). A uniform `s* < 0.8276` would be its stability
  form. It is open, and it is a statement about colourings, where the counting of R88-TC-count lives. The ratio margins are small
  (`1/4 − 0.2470 ≈ 0.003` at the real place), so any such `s*` would be close to 1, and the gain over MR's threshold `0` small.

### Would-have-searched-here log (stage 3)

- Would have searched for a stationary proper four-colouring of a model Cayley graph (a product `X × Y`, `X` with ratio `< 1/4` and `Λ_X > 1/3`)
  whose `X`-projection violates (★), as a relative counterexample. Instead: the scenario of 3.4, derived, with its status stated (not a
  counterexample).
- `tools/x03d_factor_minima.py` is an exact-shape evaluation of seconds checking a derived claim (four fixed primes and one Bessel zero), not a
  search.
