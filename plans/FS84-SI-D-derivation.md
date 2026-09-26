*Derivation record of crunch job **J45** ("J36-D"), de Bruijn, Opus 5.5, 2026-09-25. Brief:
`data/crunch-2026-09-25/briefs/J45-SI-derivation.md`, with `data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. The claims are
the Poros record's §4.4 (`plans/POROS-2026-09-25-infinitely-many-primes.md`), checked verbatim below. No subagents; no finite-witness
search (ban to 2026-10-01); I touch only this file, `data/fs84/j45/` and `tools/crunch_j45_*`. A blind verifier (J46) works the same list;
I have not contacted it.*

## Theorems this phase proved

*(Filled at stage 5; one line each, grade and address.)*

## Stage 1 — SAVED (quotation check, notation, C0)

### 1.1 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | the fixed claim list, "Let `F` be a real number field … must satisfy (SI) with equality." (brief ll. 26–36) | Poros record §4.4, ll. 352–362 | **byte-identical** (`diff` of the two line ranges: no output) |
| Q2 | Kooshi, *"indeed, verify Poros' derivation"* | not in a file I hold (relayed by the owner) | not checkable; logged |
| Q3 | "T-C(A) says: over ℚ(√47), no translation-invariant random four-colouring has its spectral measure carried by `T + A + Fin_S` …" (not in quotation marks) | `plans/R88-derivation.md` R88-TCA | agrees in substance with R88-TCA's statement |
| Q4 | "random noise on gapped colourings over ℚ(√11) already puts a spectrum off every `E_S` (its F2)" (not in quotation marks) | Poros record §F2 | agrees |

### 1.2 Notation — fixed here, and where each term comes from

From `plans/R88-derivation.md`'s Notation block: `F` real, `L = F(i)`, `U = U_F` (norm-one elements of `L`, i.e. the unit vectors of `F²`),
`R = ℤ[U]`, `X₄(F)` the proper four-colourings of `Cay(R, U)`, **Pull**, `T` the torsion characters, `A` the archimedean ones, `Fin_S` those
continuous for the `S`-adic topology, `S` a finite set of split places. Characters are written multiplicatively, `χ : R → S¹`, and `U` acts on
`R̂` by `(u·χ)(r) = χ(ur)`.

Fixed here, because the claim list leaves them undefined (the Poros record's §F3 is the source of each reading):

- **Tetrahedral embedding.** `e₀, …, e₃ ∈ ℝ³` unit vectors with `⟨e_i, e_j⟩ = (4/3)δ_ij − 1/3`; `g(x) = e_{c(x)}`.
- **Trace spectral measure `σ_μ`.** The finite positive measure on `R̂` with `∫ χ(y) dσ_μ(χ) = C(y) := E_μ⟨g(0), g(y)⟩` for every `y ∈ R`
  (Bochner on the discrete group `R`; `C` is positive definite, real and even, so `σ_μ` is symmetric under `χ ↦ χ̄`). Equivalently
  `σ_μ = Σ_k σ_{g_k(0)}`, the sum of the spectral measures of the three coordinates of `g(0)` in the Koopman representation
  `(V_y f)(c) = f(c(· + y))` on `L²(μ)`. This is J28V's `μ_sp = tr M` (`plans/FS86-R88-V-verification.md` §2 Setting).
- **`E_S`** `= T + A + Fin_S`, read literally. I use it through one topology: `τ′_S`, the topology on `R` induced by the diagonal map
  `R → G′_S := R̂_prof × (L ⊗ ℝ) × ∏_{v∈S} L_v` (`R̂_prof` the profinite completion). **Lemma N1 (§2.1) proves `E_S` is exactly the group of
  `τ′_S`-continuous characters.** This differs from J28D's `G_S` (all stable places at full depth) only in the non-archimedean compact factor;
  the two continuity groups coincide when every torsion character is continuous for the stable topology (J28D's C1, via Lemma C (d) /
  Lemma R (b)). **I use `G′_S` so that nothing below needs Lemma R or Lemma C**; T-C and T-C(A) are used only as stated, on `T + A + Fin_S`.
- **The `E_S`-factor.** `𝒜_S` := the σ-algebra of events whose indicator has spectral measure carried by `E_S`. Lemma N2 (§2.1) proves that
  the vectors with spectral measure on `E_S` are exactly `L²(𝒜_S)`, so the orthogonal projection onto them is `E[· | 𝒜_S]` (the Poros record's
  "factor σ-algebra of the `τ_S`-continuous vectors", F3). Write `p_j(x) = P(c(x) = j | 𝒜_S)`, `p(x) = (p_j(x))_j`, `M(x) = supp p(x)`,
  `h(x) = E[g(x) | 𝒜_S] = Σ_j p_j(x) e_j`.
- **"carries a translation-equivariant proper four-colouring `c′`"**: an `𝒜_S`-measurable map `ω ↦ c′_ω ∈ X₄(F)` (a.s.) with
  `c′_{T_y ω} = c′_ω(· + y)`.
- **"`c(x) ∈ supp P(c(x) = · | E_S-factor)`"**: `c(x) ∈ M(x)`. **Reading note, recorded before any proof:** as written, this clause
  constrains `c`, not `c′`. Lemma SI-2 (§2.2) shows it holds for every `μ`. I therefore score SI's "if" direction under the literal reading
  (the clause is automatic) and under the selection reading (`c′(x) ∈ M(x)`), and say where they differ.
- **"finite measure"** in R-U and SP: a finite positive Borel measure (the standard sense; SP's first half says "positive"). Signed and
  complex readings are scored separately where they change a verdict.
- **type (B)**, **Pull**, **P₄**, **T-C**, **T-C(A)**: `plans/R88-derivation.md` Notation, R88-TC, R88-TCA, verbatim.

### 1.3 C0 — probabilities per claim

*Written after reading the sources (the Poros record in full; R88-derivation in full; J28D §3; J28V §2.1–2.2; ledger rows 94–99) and one
mental pass, before any written derivation. The mental pass had already noticed the reading issue in 1.2, so the SI "if" numbers are informed
by it.*

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| SI, the inequality | 0.95 | 0.01 | 0.04 | an orthogonal decomposition plus the tetrahedral identity |
| SI, "equality ⟹ carries" | 0.90 | 0.02 | 0.08 | risk: the factor step (N2) |
| SI, "carries ⟹ equality" | 0.10 | 0.20 | 0.70 | the clause does not tie `c′` to `c`; I expect it to be equivalent to an open statement |
| A⁺ given T-C(A) | 0.90 | 0.02 | 0.08 | one line from SI's ⟹ once the factor colouring's law is shown to satisfy T-C(A)'s hypothesis |
| B⁺ given T-C | 0.85 | 0.03 | 0.12 | needs gap-freeness of every colouring of `P₄` |
| R-U | 0.80 | 0.05 | 0.15 | risk: identifying `E_S` with a copy of a dual group (density of `R`) |
| SP, "only if" | 0.97 | 0.01 | 0.02 | Haar has zero mean at `1` |
| SP, "if" | 0.75 | 0.05 | 0.20 | risk: the push-forward staying off `E` |
| Control (F2 with equality) | 0.90 | 0.03 | 0.07 | |

### 1.4 Would-have-searched-here log (running)

- (none yet)

## Stage 2 — SAVED (SI, and its control)

**Verdicts.** SI's inequality: **TRUE** [hand]. SI's "equality for every `u` ⟹ the `E_S`-factor carries `c′` with `c(x) ∈ supp`": **TRUE**
[hand]. SI's "⟸": **GAP** at the step "an `𝒜_S`-measurable proper colouring forces the supports `M(x)`, `M(x + u)` apart" — under both
readings of 1.2, and over ℚ(√11) (indeed over every field with hypothesis (G2) below) that step is **equivalent** to "every
translation-invariant four-colouring of the field satisfies SI with equality at `S`", an open statement (Lemma SI-5). The sharp form that
*is* an iff: **equality at `u` ⟺ the supports are disjoint on every `u`-edge** (Lemma SI-3, TRUE). **Control: TRUE** [hand + tools exact].
All statements hold for every real number field `F` and every finite `S`, with no input beyond Bochner, Steinhaus–Weil, the open-mapping
theorem, weak approximation for the norm-one torus of `L/F` (a rational curve), and J28V-7's finite index (in print, `[LevitzMott1972]`).

### 2.1 The two notation lemmas

**Lemma N1 (the group `E_S`).** Let `G′_S = R̂_prof × (L ⊗ ℝ) × ∏_{v∈S} L_v` and `ρ : Ĝ′_S → R̂` restriction along the diagonal `R → G′_S`.
(a) `ρ(Ĝ′_S) = T + A + Fin_S`, and this is exactly the set of `τ′_S`-continuous characters. (b) `R` is dense in `G′_S`, so `ρ` is injective,
`E_S` is σ-compact, and `ρ` is a Borel isomorphism onto `E_S` (Lusin–Souslin), equivariant for the action of `U` by multiplication (on `G′_S`
factorwise; on `L̂_v ≅ L_v` through `ψ_v(Tr(ξx))` it is `ξ ↦ uξ`). (c) `E_S` is a proper dense subgroup of `R̂`, so `Haar(E_S) = 0`; hence
`Haar(E) = 0` for `E = ⋃_S E_S`, a countable directed union of subgroups, itself a Borel subgroup.
*Proof.* (a) A character of `R` is continuous for the profinite topology iff it kills a finite-index subgroup iff it has finite order, because
`NR` has finite index (`|R/NR| ≤ N^{rank R}`, `rank R ≤ 2[F:ℚ]`; J28V-7): so the `R̂_prof`-continuous characters are `T`, the archimedean
ones `A`, the `S`-adic ones `Fin_S`. A sum of the three is continuous for the diagonal topology; conversely a `τ′_S`-continuous character
extends to the closure of `R` in the LCA group `G′_S`, then to `G′_S` (characters of closed subgroups extend), and a character of a product
is the product of characters of the factors. (b) Suppose `ψ = ψ_T ψ_A ψ_S ∈ Ĝ′_S` kills `R`. `ψ_T` is trivial on `NR` for some `N`, so
`ψ_Aψ_S` kills `NR`. Weak approximation for the norm-one torus `𝕋` of `L/F` (a smooth rational curve, `x² + y² = 1`) makes `U` dense in
`𝕋_∞ × ∏_{v∈S} 𝕋(F_v)` (`𝕋_∞` the archimedean points); the `ℤ`-span of `N·U` therefore has closure containing the closed subgroup generated by
`N·(𝕋_∞ × ∏_S 𝕋(F_v))`, which contains all differences `N(t − t′)` in one factor with the others fixed at 1. Those differences span: at a
complex place of `L` above a real place of `F`, `S¹ − S¹` is the disc of radius 2; above a complex place of `F`, and at a split `v`, the
circle is `{(t, t⁻¹)}` and `N(t, t⁻¹) − N(t(1+ϖ^k), (t(1+ϖ^k))⁻¹)` with `|t| → ∞` gives, after scaling by `ℤ_p`, every `(a, 0)`, and
symmetrically `(0, b)`. So `NR` is dense in `(L⊗ℝ) × ∏_S L_v`, `ψ_Aψ_S = 1`, then `ψ_T` kills `R`, which is dense in `R̂_prof`: `ψ = 1`.
(c) `A` separates points (`R ⊂ L ⊂ L ⊗ ℝ`), so `E_S` is dense. If `E_S = R̂`, the open-mapping theorem for the continuous surjection `ρ` of
σ-compact LCA groups makes `R̂ ≅ Ĝ′_S` topologically; then `G′_S` would be discrete, but the elements of `U` within `ε` of 1 at every place of
`G′_S` (infinitely many, by weak approximation) lie in a compact set. A Borel subgroup of positive Haar measure in a compact group is open
(Steinhaus–Weil), hence closed of finite index; being dense it would be everything. ∎

**Lemma N2 (the `E_S`-factor).** For `f ∈ L²(μ)`, `σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous. These `f` form `L²(𝒜_S)` for a
translation-invariant σ-algebra `𝒜_S`, and the spectral projection `Π(E_S)` is `E[· | 𝒜_S]`.
*Proof.* `‖V_y f − f‖² = 2(‖f‖² − Re σ̂_f(y))`. (⟹) dominated convergence along sequences (`G′_S` is metrizable). (⟸) `σ̂_f` is positive
definite, so continuity at 0 is uniform continuity; it extends to a continuous positive-definite function on `G′_S` (N1 (b)); Bochner there
gives `ν` on `Ĝ′_S`, and uniqueness of Fourier–Stieltjes coefficients on the compact `R̂` gives `σ_f = ρ_*ν`, carried by `E_S`. The set `H_S`
of such `f` is closed and translation-invariant; since `V_y` is multiplicative, `‖V_y(fh) − fh‖₂ ≤ ‖V_y f − f‖₂‖h‖_∞ + ‖f‖_∞‖V_y h − h‖₂`, so
bounded elements of `H_S` form a conjugation-closed algebra, closed under the 1-Lipschitz maps `|·|` and truncation. So the sets whose
indicators lie in `H_S` form a σ-algebra `𝒜_S` (complements, products, monotone limits), every bounded real `f ∈ H_S` is `𝒜_S`-measurable
(`{f > t}` is a monotone limit of `min(1, n(f − t)⁺)`), and truncation shows the bounded part is dense in `H_S`: `H_S = L²(𝒜_S)`. `Π(E_S)`
commutes with every `V_y`, so `𝒜_S` is invariant and `Π(E_S)` is the orthogonal projection onto `L²(𝒜_S)`, i.e. `E[· | 𝒜_S]`. ∎

*Remark.* N1–N2 hold for `E_S` read literally as `T + A + Fin_S`, with no Lemma R and no Lemma C. The Poros sketch's "`τ_S`-continuous"
(J28D's `G_S`, stable places at full depth) gives the same group whenever torsion characters are stable-continuous.

### 2.2 SI

Fix `μ`, `S`. Choose a version of `p_j(0) = P(c(0) = j | 𝒜_S)` and set `p_j(x) := p_j(0) ∘ T_x` (a version of `P(c(x) = j | 𝒜_S)`, `𝒜_S` being
invariant); `M(x) = {j : p_j(x) > 0}`.

**Lemma SI-1 (the identity) [hand].** For every `u ∈ U`: `−1/3 = E⟨h(0), h(u)⟩ + ∫_{R̂∖E_S} χ(u) dσ_μ(χ)`, and the integral is real.
*Proof.* With `g_k` the coordinates of `g(0)`, `C(u) = Σ_k ⟨V_u g_k, g_k⟩`. Split `g_k = Πg_k + (1 − Π)g_k`, `Π = Π(E_S)`; `Π` commutes with
`V_u`, so the cross terms vanish and `⟨V_u(1−Π)g_k, (1−Π)g_k⟩ = ∫_{R̂∖E_S} χ(u) dσ_{g_k}`. By N2, `Πg_k = h_k(0)` and `V_u h_k(0) = h_k(u)`.
`C(u) = −1/3` because `c` is proper surely; the first term is real, so the integral is. ∎

**Lemma SI-2 [hand].** For every `μ`, `S` and `x`: `c(x) ∈ M(x)` a.s. *Proof.* `P(c(x) = j, p_j(x) = 0) = E[1[p_j(x) = 0] p_j(x)] = 0`. ∎
*So the clause "`c(x) ∈ supp P(c(x) = · | E_S-factor)` almost surely" in the claim holds for every `μ`; it adds nothing to either side.*

**Lemma SI-3 (the inequality, exactly) [hand].** For every `u ∈ U`,
`∫_{R̂∖E_S} Re χ(u) dσ_μ = −(4/3) Σ_j E[p_j(0) p_j(u)] = −(4/3) P(c¹(0) = c²(u))`, where `(c¹, c²)` is the relatively independent self-joining
of `μ` over `𝒜_S`. Hence it is `≤ 0`, and it is `0` iff a.s. `M(x) ∩ M(x + u) = ∅` for every `x ∈ R`.
*Proof.* `⟨Σ_i p_i e_i, Σ_j q_j e_j⟩ = (4/3)Σ_j p_j q_j − 1/3` for probability vectors; put it in SI-1. The sum vanishes iff `p_j(0)p_j(u) = 0`
for every `j` a.s.; stationarity carries this to every `x`, and `R` is countable. ∎

**Lemma SI-4 (equality ⟹ a factor colouring) [hand].** If equality holds for every `u ∈ U`, then for every choice function `f` on the
non-empty subsets of `{0, 1, 2, 3}` (e.g. `min`, `max`), `c′ = f ∘ M` is a.s. a proper four-colouring, `𝒜_S`-measurable, translation-equivariant,
with `c′(x) ∈ M(x)`; and `c(x) ∈ M(x)` a.s. (SI-2). *Proof.* SI-3: adjacent sets are disjoint, so any selection is proper; `M(x)` is a function
of `p(x)`, which is `𝒜_S`-measurable, and `M(x + y) = M(x) ∘ T_y` by the choice of versions. ∎

**Verdict on SI.** The inequality: **TRUE** (SI-3, with an exact formula). "Equality for every `u` ⟹ carries": **TRUE** (SI-4). The claim's
"⟸" — *if the `E_S`-factor carries an equivariant proper four-colouring `c′` (with `c(x) ∈ M(x)`, automatic; or with `c′(x) ∈ M(x)`), then
equality for every `u`* — is **not proved by the sketch** (its item 4 is the ⟹ only), and Lemma SI-5 shows what it would take.

**Hypothesis (G2)** on `F`: some stable place `𝔓` has a residue plane `P = Cay(O/𝔓, Ū)` (`Ū` the image of `U`) with a proper four-colouring `γ`
and adjacent vertices `ā ~ b̄`, each **gapped with the same missing colour `m`** (`m ∉ γ(N[ā]) ∪ γ(N[b̄])`).
**ℚ(√11) satisfies (G2) at 7** [tools exact]: C9's `γ = ⌊4θ⌋`, `θ = (2x + 3y)/7`, is proper on `Γ₇`; its gapped vertices are exactly the 14
with `7θ ∈ {0, 5}`, all missing colour 3, and they span 28 directed edges (`tools/crunch_j45_gap7.py` (1), (2), (5) →
`data/fs84/j45/gap7.out`).

**Lemma SI-5 (the "⟸" direction is equivalent to universal equality, under (G2)) [hand].** Let `F` satisfy (G2) and fix `S`. If some
translation-invariant random proper four-colouring `μ₂` has strict inequality at some `u₀ ∈ U`, then some translation-invariant random proper
four-colouring `μ` has strict inequality at some `u`, while its `E_S`-factor carries the equivariant proper four-colouring `γ_Φ ∘ π_𝔓`, a
selection (`γ_Φ(π_𝔓 x) ∈ M(x)` a.s.). Hence, over `F` at `S`: *"SI's ⟸ holds for every `μ`" ⟺ "every `μ` satisfies SI with equality"*, under
the literal and the selection reading alike.
*Proof.* (a) *Rotate.* For `v ∈ U`, `x ↦ c₂(vx)` is again a stationary proper colouring; its off-`E_S` integral at `u` is `μ₂`'s at `vu`
(multiplication by `v` is a `τ′_S`-homeomorphism of `R`, so `E_S` is `U`-invariant). Pick `u` with `π_𝔓(u) = b̄ − ā` and `v = u₀u⁻¹`: strict at `u`.
By SI-3 there is a colour `j₀` with `P(q_{j₀}(0) > 0, q_{j₀}(u) > 0) > 0`, `q` the conditional law of `c₂` given `𝒜_S(c₂)`.
(b) *Build.* Independently: `Φ` a uniform translate `a ∈ O/𝔓` (so `γ_Φ = γ(· + a)`, `W_Φ = {x : π_𝔓x + a ∈ W̄}`, `W̄` the vertices of `γ` gapped
with missing `m`); `c₂`; `ε` i.i.d. with `P(ε = 1) = 1/3`. Put `c(x) = m` if `x ∈ W_Φ`, `c₂(x) = j₀`, `ε(x) = 1`, and `c(x) = γ_Φ(π_𝔓 x)`
otherwise. The recoloured set lies in the independent set `{c₂ = j₀}`, and `m` is absent from `γ_Φ` on every closed neighbourhood of `W_Φ`
(the tool's (5)), so `c` is proper; it is stationary by construction.
(c) *The factor.* By Lemma SI-J below, `𝒜_S(c) ⊆ σ(Φ) ∨ 𝒜_S(c₂)`. `γ_Φ ∘ π_𝔓` is `c`-measurable (on each residue class its colour has frequency
`≥ 2/3`, any other `≤ 1/3`: ergodic averages along a tempered Følner sequence), takes finitely many values permuted by `R` through the finite
`O/𝔓`, so its `L²` is spanned by eigenfunctions of torsion characters: it is `𝒜_S(c)`-measurable. It is proper and equivariant, and
`P(c(x) = m | 𝒜_S(c)) ≤ 1/3`, so `γ_Φ(π_𝔓x) ∈ M(x)`.
(d) *Strict.* For `x ∈ W_Φ` (an `𝒜_S(c)`-event), `p^c_m(x) = E[(1/3) q_{j₀}(x) | 𝒜_S(c)]` (tower property; `ε`, `Φ` independent of `c₂`), so
`q_{j₀}(x) > 0 ⟹ p^c_m(x) > 0` a.s. The event `{x, x + u ∈ W_Φ} ∩ {q_{j₀}(x) > 0, q_{j₀}(x+u) > 0}` has positive probability (independence;
`π_𝔓 u = b̄ − ā`), and on it `m ∈ M^c(x) ∩ M^c(x + u)`. SI-3: strict at `u`. The "⟸" of the equivalence is trivial. ∎

**Lemma SI-J (the factor of an independent product) [hand].** If `Φ` is a finite translation system (`R` acting through a finite quotient),
`ε` Bernoulli, and `c₂` any stationary process, all independent, then the `E_S`-factor of `(Φ, c₂, ε)` is `σ(Φ) ∨ 𝒜_S(c₂)`.
*Proof.* `L²(Φ)` is a finite sum of lines `e_t` with torsion eigencharacters `t`; every vector of `L²₀(ε)` has spectral measure `≪ Haar`
(Bernoulli: Lebesgue spectrum). `e_t ⊗ f₂ ⊗ f₃` has spectral measure `δ_t * σ_{f₂} * σ_{f₃}`. With `f₃ ∈ L²₀(ε)` it is `≪ Haar`, which gives `E_S`
measure 0 (N1 (c)); the absolutely continuous vectors form a closed invariant subspace, so `Π(E_S)` kills `L²(Φ) ⊗ L²(c₂) ⊗ L²₀(ε)`. With
`f₃ = 1`, `δ_t * σ_{f₂}` is carried by `E_S` iff `σ_{f₂}` is (`t ∈ T ⊆ E_S`, a subgroup). So `H_S = ⊕_t e_t ⊗ H_S(c₂) ⊗ 1`. And the factor of a
factor process is contained in the factor of the extension (a spectral measure does not depend on the ambient system). ∎

**What SI-5 means.** Over ℚ(√11), SI's "⟸" as a statement about every `μ` is exactly *"no four-colouring of ℚ(√11)'s plane has an
off-`E_S` part anticorrelated at unit distance"* — the negation of the Poros record's EI-2 falsifier (§4.2, its `S`-form). That is open, so
the step is a **GAP**, not a FALSE: a counterexample needs one colouring with strict inequality over a (G2) field, and none is known (C9's
spectrum is on `T + A`; F2's has equality, below). Over ℚ(√47), given T-C(A), "⟸" holds vacuously (no `𝒜_S` carries a proper colouring;
see A⁺, stage 3). **Consequence for the Poros record** (correction owed, §4.1 (a)): "By Lemma SI (F3), EI-2 holds for a colouring iff the part
of its spectrum that no finite set of places reads is not anticorrelated at unit distance" uses the unproved "⟸". What holds: non-anticorrelation
off `E_S` ⟹ a proper factor colouring on `𝒜_S` (SI-4); the converse, per colouring, fails over ℚ(√11) as soon as one anticorrelated colouring
exists there (SI-5's `μ` carries `γ_Φ` on `𝒜_S` for every `S`, the same construction run with `E` in place of `E_S`). A second scope point: with
`E = ⋃_S E_S` in place of `E_S`, equality gives a colouring measurable for `⋁_S 𝒜_S`, not for a single `𝒜_S` (J28D's R1), so "continuous at
finitely many places" does not follow either.

### 2.3 The control: F2's colourings satisfy SI with equality

**Lemma SI-C [hand + tools exact].** Over ℚ(√11), let `γ = ⌊4θ⌋` on `Γ₇` (C9), `Z̄ = {θ = 0}`, `g ≡ 3`, `Φ` a uniform translate, `ω` i.i.d. fair
bits, and `c(z) = 3` if `π₇z + a ∈ Z̄` and `ω(z) = 1`, else `γ(π₇z + a)` (the Poros record's F2 with these choices). Then `c` is a proper
stationary four-colouring, **SI holds with equality at every `u` and every `S`**, and `σ_μ(R̂ ∖ E) > 0`.
*Proof.* `Z̄` is independent and every vertex of it is gapped with missing colour 3 (tool (3)), so `c` is proper. SI-J with no `c₂`:
`𝒜_S(c) ⊆ σ(Φ)`. The conditional law of `c(x)` given `σ(Φ)` is `δ_{γ_Φ(x̄)}` off `Z_Φ` and `½δ₀ + ½δ₃` on `Z_Φ`, a function of `γ_Φ` alone
(`Z̄` is the set of gapped vertices of colour 0, tool (2)); `γ_Φ` is `c`-measurable (the colour sets seen on each residue class) and
`𝒜_S(c)`-measurable (torsion spectrum), so `p(x)` is that law, for every `S`. Its supports are disjoint on every edge of `Γ₇` (tool (4): 0 of
392 directed edges meet), so SI-3 gives equality at every `u`. The centred noise `1[c(0) = 3] − p₃(0)` is a non-zero vector of
`L²(Φ) ⊗ L²₀(ω)`, with spectral measure `≪ Haar`, which gives `E` measure 0 (N1 (c)). ∎

The tool's plants fire for the right reasons: `PLANT=1` (a non-band functional) fails (1), (3), (4); `PLANT=2` (the wrong missing colour) fails
(3) and (4) while (1), (2), (5) still pass — the paired form (`data/fs84/j45/gap7-plant1.out`, `gap7-plant2.out`, both exit 1).

### 2.4 Would-have-searched-here log (stage 2)

- Would have searched ℚ(√11) (or ℚ, ℚ(√3)) for a stationary four-colouring with an anticorrelated off-`E_S` part, to turn SI's "⟸" GAP into a
  FALSE. Instead: proved (SI-5) that one such colouring suffices and that none is needed if none exists — the step is equivalent to that open
  existence question.
- The tool is a complete enumeration of `Γ₇` (49 vertices, 8 unit vectors), a set the derivation fixed: the ban's edge, logged.

## Stage 3 — SAVED (A⁺ and B⁺)

**Verdicts. A⁺: TRUE given T-C(A)** [hand]. **B⁺: TRUE given T-C** and the gap-freeness of every proper four-colouring of `P₄` (FS38-D2-A,
Blokhuis–Brouwer–Haemers's equality case) [hand]. Neither uses SI's unproved "⟸".

**Lemma A⁺ [hand; given T-C(A)].** Over ℚ(√47) (and every field in T-C(A)'s class), for every translation-invariant random proper four-colouring
`μ` and every finite set `S` of split places, some `u ∈ U` has `∫_{R̂∖E_S} Re χ(u) dσ_μ < 0`; equivalently (SI-3) the relatively independent
self-joining over `𝒜_S` has `P(c¹(0) = c²(u)) > 0`.
*Proof.* If equality held for every `u`, SI-4 gives `c′ = min ∘ M`, a.s. in `X₄(F)`, `𝒜_S`-measurable and equivariant. Its law `μ′` (restricted to
the invariant full-measure event `{c′ ∈ X₄(F)}`) is a translation-invariant Borel probability on `X₄(F)`. The coordinates of `e_{c′(0)}` lie in
`L²(𝒜_S)`, so their spectral measures — the same in `μ`'s Koopman representation and in `μ′`'s, the factor map intertwining them — are carried
by `E_S` (N2): `σ_{μ′}` is carried by `T + A + Fin_S`, which T-C(A) (R88-TCA, verbatim: "no translation-invariant Borel probability on `X₄(F)`
has spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places") forbids. ∎
*Remarks.* (i) The `E_S` here is T-C(A)'s own, read literally (N1): nothing is transported between topologies. (ii) If `μ` is also
rotation-invariant (`R ⋊ U`), `σ_μ` and `E_S` are `U`-invariant, so `u ↦ ∫_{R̂∖E_S} χ(u) dσ_μ` is constant on `U`: strict at every `u`, in
particular at `u = 1`.

**Lemma B⁺ [hand; given T-C].** Over a type-(B) field (and every field in T-C's class, `P₄` being that class's tight level), if a
translation-invariant random proper four-colouring `μ` satisfies `∫_{R̂∖E_S} Re χ(u) dσ_μ = 0` for every `u ∈ U`, for some finite `S`, then `μ`
is carried by Pull.
*Proof.* SI-4: `c₁ = min ∘ M` is an `𝒜_S`-measurable equivariant proper colouring, and as in A⁺ its law has spectral measure on `E_S`; T-C makes it
a.s. a pullback, `c₁ = γ₁ ∘ π₄`, `γ₁` a proper four-colouring of `P₄ = Cay(O/𝔓⁴, S₄)`, `S₄ = π₄(U)`. Suppose `|M(x₀)| ≥ 2` with positive
probability and pick there `j ∈ M(x₀) ∖ {c₁(x₀)}`. For every `u ∈ U`, `c₁(x₀ + u) ∈ M(x₀ + u)`, which is disjoint from `M(x₀) ∋ j` (SI-3); and
`c₁(x₀) ≠ j`. Since `π₄(x₀ + U) = π₄x₀ + S₄`, the colour `j` is missing from `γ₁` on the closed neighbourhood of `π₄x₀`: a gap. `P₄` is
Hoffman-tight at four colours (row 67; J28D's Lemma D, FS38-D2-B), so every proper four-colouring of it is gap-free (FS38-D2-A). So a.s. every
`M(x)` is a singleton, `c = c₁` on `R` (SI-2; `R` countable), and `μ` is carried by Pull. ∎
*Remarks.* (i) One selection suffices; the Poros sketch's two (`min`, `max`) reach the same gap. (ii) The converse is immediate (a pullback has
spectral measure on `T`, so `σ_μ(R̂ ∖ E_S) = 0`), so **given T-C, at type (B): equality for every `u` ⟺ carried by Pull ⟺ spectral measure on
`E_S`**. **Correction owed** to the Poros record §F3 ("T-C⁺ is strictly wider than T-C: it admits mass off `E_S`, provided that mass is not
anticorrelated at unit distance"): wider as a hypothesis, but, given T-C, no `μ` with mass off `E_S` satisfies it. The content is the
dichotomy: **every `μ` over a type-(B) field is carried by Pull or strictly anticorrelated off every `E_S` at some unit vector** — A⁺'s shape.

### Would-have-searched-here log (stage 3)

- None: both lemmas are two-line compositions of SI-3/SI-4 with T-C(A), T-C and D2-A.
