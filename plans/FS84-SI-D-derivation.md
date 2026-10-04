*Derivation record of crunch job **J45** ("J36-D"), de Bruijn, Opus 5.5, 2026-09-25. Brief:
`data/crunch-2026-09-25/briefs/J45-SI-derivation.md`, with `data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. The claims are
the Poros record's §4.4 (`plans/POROS-2026-09-25-infinitely-many-primes.md`), checked verbatim below. No subagents; no finite-witness
search (ban to 2026-10-01); I touch only this file, `data/fs84/j45/` and `tools/crunch_j45_*`. A blind verifier (J46) works the same list;
I have not contacted it.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J45-N1 | `E_S = T + A + Fin_S` is exactly the group of characters continuous for `R → R̂_prof × (L⊗ℝ) × ∏_{v∈S} L_v`; `R` is dense there; `E_S` is a proper dense σ-compact subgroup, Haar-null, `U`-invariant, Borel-isomorphic to the dual group | [hand] | §2.1 |
| J45-N2 | the vectors of `L²(μ)` with spectral measure on `E_S` are `L²(𝒜_S)` for a translation-invariant σ-algebra, and `Π(E_S) = E[·|𝒜_S]` | [hand] | §2.1 |
| J45-SI-1 | `−1/3 = E⟨h(0), h(u)⟩ + ∫_{R̂∖E_S} χ(u) dσ_μ` for every `u ∈ U` | [hand] | §2.2 |
| J45-SI-2 | `c(x) ∈ supp P(c(x) = · \| 𝒜_S)` a.s., for every `μ` (so the claim's clause is automatic) | [hand] | §2.2 |
| J45-SI-3 | `∫_{R̂∖E_S} Re χ(u) dσ_μ = −(4/3) P(c¹(0) = c²(u))` (relatively independent self-joining over `𝒜_S`); `≤ 0`, `= 0` iff the supports are disjoint on every `u`-edge | [hand] | §2.2 |
| J45-SI-4 | equality at every `u` ⟹ every selection from the supports is an `𝒜_S`-measurable equivariant proper four-colouring | [hand] | §2.2 |
| J45-SI-5 | under (G2), "`𝒜_S` carries a proper colouring ⟹ equality" holds for every `μ` over `F` iff every `μ` over `F` has equality at `S` | [hand] | §2.2 |
| J45-SI-J | the `E_S`-factor of an independent product of a finite translation system, a Bernoulli process and `c₂` is `σ(Φ) ∨ 𝒜_S(c₂)` | [hand] | §2.2 |
| J45-G2 | ℚ(√11) satisfies (G2) at 7: C9's `⌊4θ⌋` on `Γ₇` has 14 gapped vertices (`7θ ∈ {0, 5}`), all missing colour 3, spanning 28 directed edges | [tools exact; plants fire] | §2.2, `tools/crunch_j45_gap7.py` |
| J45-SI-C | F2's noisy colourings over ℚ(√11) satisfy SI with equality at every `u` and `S`, with `σ_μ(R̂ ∖ E) > 0` | [hand + tools exact] | §2.3 |
| J45-A⁺ | over ℚ(√47), given T-C(A): every `μ`, every finite `S`, some `u` has strict inequality (constant in `u` if `μ` is rotation-invariant) | [hand] | §Stage 3 |
| J45-B⁺ | over a type-(B) field, given T-C and FS38-D2-A: equality at every `u` ⟹ carried by Pull; so equality ⟺ Pull ⟺ spectrum on `E_S` | [hand] | §Stage 3 |
| J45-RU | every finite `U`-invariant measure on `R̂` gives `E_S ∖ (T + A)`, hence `E ∖ (T + A)`, measure 0; every real number field | [hand] | §4.1 |
| J45-SP-oi | SP's "only if" | [hand] | §4.2 |
| J45-SP-if | SP's "if" (positive measures; complex with `\|ν\|(E) = 0`) | [hand] | §4.2 |
| J45-SP-Cor | over ℚ(√47), given T-C(A) at `S = ∅`: if every `U`-invariant finite positive `E`-null measure on `R̂` is a Haar multiple, `χ(ℚ(√47)²) ≥ 5` | [hand] | §4.2 |

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

## Stage 4 — SAVED (R-U and SP)

**Verdicts. R-U: TRUE** [hand], for every real number field, every finite `S`, and every finite (positive, signed or complex) `U`-invariant
measure. **SP, "only if": TRUE** [hand; one line]. **SP, "if": TRUE** [hand] for finite positive measures (the standard reading, 1.2), and for
signed or complex ones when "`τ(E) = 0`" is read as `|τ|(E) = 0`; under the literal value reading for signed measures the hypothesis is always
met (below), so that reading would make SP's "if" assert the open existence question outright — it is not the claim's intended sense.

### 4.1 R-U

**Lemma R-U [hand].** Every finite `U`-invariant measure `ν` on `R̂` has `|ν|(E_S ∖ (T + A)) = 0` for every finite `S`; hence also
`|ν|(E ∖ (T + A)) = 0`.
*Proof.* `|ν|` is again invariant, so take `ν ≥ 0`. `E_S` is `U`-invariant, and by N1 (b) `ρ` is a `U`-equivariant Borel isomorphism
`Ĝ′_S → E_S`; let `ν̃` be `ν|_{E_S}` pulled back, and `ν_S` its push-forward to the `S`-component `∏_{v∈S} L̂_v ≅ ∏_{v∈S} L_v`, on which `u` acts
by multiplication by `u_v` (the trace pairing). For `v ∈ S`, `v` split, write `L_v = L_𝔓 × L_𝔓̄ ≅ F_v × F_v` and take `z` with `(z) = 𝔓^h`,
`h` the class number of `L`, and `u = z/z̄ ∈ U` (`N_{L/F}(u) = 1`). At `v`, `u` acts as `(ξ₁, ξ₂) ↦ (tξ₁, t⁻¹ξ₂)` with `|t|_v = |z|_𝔓 < 1`
(`z̄` generates `𝔓̄^h` and is a unit at `𝔓 ≠ 𝔓̄`); at every other place of `S` it acts by units. The sets
`uⁿ{ξ : 1 ≤ |ξ₁|_v < |t|_v⁻¹}`, `n ∈ ℤ`, are disjoint, of equal `ν_S`-measure, with union `{ξ₁ ≠ 0}`; finiteness forces
`ν_S{ξ₁ ≠ 0} = 0`, and `u⁻¹` does the same for `ξ₂`. Over all `v ∈ S`, `ν_S` is a point mass at 0, so `ν̃` is carried by `{ψ_S = 1}`, whose
image is `T + A` (N1 (a)); by injectivity `ν(E_S ∖ (T + A)) = 0`. `E` is a countable union. ∎
*Against the sketch.* The Poros record's F4 proof is this one; it cites Lusin–Souslin for "a Borel copy of `Ĝ_S`", which needs `R` dense in
`G_S` (J28D's C1: strong approximation and Lemma R (a)). With `G′_S`, N1 (b) supplies density with no Lemma R, so R-U holds for every real
number field.

### 4.2 SP

**Lemma SP-only-if [hand].** If a finite positive `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`, then `τ` itself is a `U`-invariant
finite measure with `τ(E) = 0` that is not a multiple of Haar: `∫ χ(1) dHaar = 0` because `1 ≠ 0` in `R`. ∎

**Lemma SP-if [hand].** If some finite positive `U`-invariant `ν` with `ν(E) = 0` is not a multiple of Haar, then some finite positive
`U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`.
*Proof.* (1) By Fourier uniqueness on the compact `R̂`, `ν̂(r₀) = ∫ χ(r₀) dν ≠ 0` for some `r₀ ≠ 0`; `−1 ∈ U` gives `ν̂(r₀) = ν̂(−r₀) = conj ν̂(r₀)`,
so it is real. (2) Let `m(χ) = χ(r₀ ·)`, the dual of multiplication by `r₀` on the ring `R`, and `τ′ = m_*ν`: positive, `U`-invariant (`m`
commutes with the action), `τ̂′(1) = ν̂(r₀)`. **Off `E`:** if `χ(r₀·) ∈ E_S` then `χ ∈ E_S`. Indeed `r₀R ⊇ MR` for a non-zero integer `M`
(J28V-7), so `r₀R` is open in `τ′_S` (it contains the profinitely open `MR`); on it `χ(y) = χ(r₀·)(y/r₀)`, and `y ↦ y/r₀` is `τ′_S`-continuous
`r₀R → R` (continuous at the archimedean and `S`-places; and `y ∈ MN′R ⟹ y/r₀ ∈ N′R`, because `MR ⊆ r₀R`); a character continuous on an open
subgroup is continuous. So `m⁻¹(E) ⊆ E` and `τ′(E) ≤ ν(E) = 0`. If `ν̂(r₀) < 0`, take `τ = τ′`. (3) If `ν̂(r₀) > 0`, fix a real place of `F`
(one exists, `F ⊆ ℝ`) and the complex place `w₀` of `L` above it; let `λ` be the uniform probability on the archimedean characters
`x ↦ exp(2πi Re(ξ x_{w₀}))`, `|ξ| = r` (other archimedean components 0), with `2πr = j₁,₁ ≈ 3.8317`, so `λ̂(1) = J₀(2πr) ≈ −0.4028`. `U` acts
on this circle by the rotation `ξ ↦ u_{w₀}ξ`, `|u_{w₀}| = 1`, so `λ` is `U`-invariant; `τ = τ′ * λ` is positive, `U`-invariant (the action is by
automorphisms), `τ̂(1) = ν̂(r₀) J₀(2πr) < 0`, and `τ(E) = ∫ τ′(E − a) dλ(a) = τ′(E) = 0` because `λ` is carried by `A ⊆ E` and `E` is a group. ∎
*Against the sketch.* Steps 1–3 are the Poros record's F5, verbatim in route. Its step 2 cites "`r₀R` is `τ_S`-open in `R`, of finite index
(J28V-7)": for J28D's `τ_S` (stable places at full depth) that openness needs torsion characters to be stable-continuous (Lemma C (d)); for
`τ′_S` it is immediate. The two agree wherever Lemma C holds.

**Readings.** For a *complex* `ν` with `|ν|(E) = 0`: `Re ν`, `Im ν` and their Jordan parts are `U`-invariant (uniqueness of the decomposition)
and `E`-null, and one of them is a non-Haar positive measure: SP-if applies. Under the *literal value* reading "`ν(E) = 0`" for signed `ν`, the
hypothesis holds over every real number field — `ν = λ_r − λ_{r′}` for two archimedean circles, `r ≠ r′` (`U`-invariant, `ν(E) = 1 − 1 = 0`,
not a multiple of Haar) — so "if" would assert that the sign problem has answer yes everywhere, which is the open question itself. Not the
intended sense; recorded so that no one reads it that way.

**Corollary SP-Cor (why SP matters; the Poros record's F4 chain, re-derived) [hand; given T-C(A) at `S = ∅`].** Over ℚ(√47): if every finite
positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`.
*Proof.* If `X₄(F) ≠ ∅`, it is compact and invariant under the countable amenable (abelian-by-abelian) group `R ⋊ U` acting by `c ↦ c(v· + y)`;
take an invariant `μ`. Then `C(vy) = C(y)` (a rotation about 0 fixes `c(0)`), so `σ_μ` is `U`-invariant; R-U gives `σ_μ(E ∖ (T + A)) = 0`, so
`τ := σ_μ|_{R̂∖E}` is positive, `U`-invariant, `E`-null, and `∫ Re χ(1) dτ = ∫_{R̂∖E_∅} Re χ(1) dσ_μ < 0` by A⁺ at `S = ∅` with its remark (ii).
So `τ` is not a multiple of Haar. ∎ Only T-C(A) at `S = ∅` is used, so the split-place lemma C14.2 (c) is not an input (the Poros record's F4
"fewer inputs", confirmed). **Not claimed:** the converse, or anything about whether non-Haar invariant measures off `E` exist (the
zero-entropy Furstenberg-type question the Poros record's F5 names; nothing here decides it).

### Would-have-searched-here log (stage 4)

- Would have searched for a non-Haar `U`-invariant measure on `R̂` off `E` (e.g. from a character orbit reading infinitely many split places).
  Instead: none; SP is a derived equivalence and needs no instance.

## Stage 5 — SAVED (the hand-off)

### 5.1 Verdicts, per claim (the fixed list, Poros record §4.4)

| claim | verdict | grade | in one line |
|---|---|---|---|
| SI, the inequality | **TRUE** | [hand] | exactly `−(4/3)` times the collision probability of the relatively independent self-joining over `𝒜_S` (SI-3) |
| SI, "equality for every `u` ⟹ carries `c′`, `c(x) ∈ supp`" | **TRUE** | [hand] | any selection from the supports (SI-4); the `supp` clause holds for every `μ` (SI-2) |
| SI, "carries ⟹ equality" | **GAP** | — | at the step "an `𝒜_S`-measurable proper colouring forces adjacent supports apart"; over a (G2) field, ℚ(√11) among them, equivalent to "every four-colouring has equality at `S`" (SI-5), an open statement; vacuous at ℚ(√47) given T-C(A) |
| A⁺ | **TRUE** given T-C(A) | [hand] | SI-4 and T-C(A) |
| B⁺ | **TRUE** given T-C and FS38-D2-A | [hand] | one selection is a pullback; a second support colour would be a gap of the tight `P₄` |
| R-U | **TRUE** | [hand] | wandering at each split place of `S`, through a Borel copy of `Ĝ′_S` (N1) |
| SP, "only if" | **TRUE** | [hand] | Haar has mean 0 at `1` |
| SP, "if" | **TRUE** | [hand] | push-forward by `r₀` stays off `E`; a `J₀`-negative archimedean circle fixes the sign; positive measures (the standard reading) |
| Control | **TRUE** | [hand + tools exact] | F2's supports are disjoint on every edge of `Γ₇`; its spectrum still charges `R̂ ∖ E` |

**Inputs, by name.** Bochner (discrete `R`, and LCA `G′_S`); Fourier–Stieltjes uniqueness on `R̂`; Steinhaus–Weil; the open-mapping theorem for
σ-compact LCA groups; Lusin–Souslin; weak approximation for the norm-one torus of `L/F` (a rational curve); the pointwise ergodic theorem along
tempered Følner sequences (SI-5 (c) only); J28V-7 (`[LevitzMott1972]`); Lebesgue spectrum of Bernoulli shifts; `J₀(j₁,₁) < 0`. Given, per claim:
T-C(A) (A⁺, SP-Cor at `S = ∅`), T-C and FS38-D2-A with row 67's tightness of `P₄` (B⁺), C9's colouring (SI-5 at ℚ(√11), the control).
**Not used:** Lemma R, Lemma C, strong approximation, `[AmbrusEtAl2023]`, FS-66, C14.

### 5.2 Corrections owed (proposed; the front-page lane decides)

1. **Poros record §4.1 (a)**, "The shadow relation is exact. By Lemma SI (F3), EI-2 holds for a colouring iff the part of its spectrum that no
   finite set of places reads is not anticorrelated at unit distance": one direction only (SI-4). The converse per colouring is SI's "⟸", a GAP,
   and over ℚ(√11) it fails as soon as one anticorrelated colouring exists there (SI-5). Also, with `E` in place of `E_S`, equality gives a factor
   colouring measurable for `⋁_S 𝒜_S`, not continuous at finitely many places (J28D's R1).
2. **Poros record §F3**, "T-C⁺ is strictly wider than T-C: it admits mass off `E_S`, provided that mass is not anticorrelated": given T-C, no `μ`
   with mass off `E_S` meets T-C⁺'s hypothesis (B⁺'s remark (ii)); state the dichotomy instead — Pull, or strictly anticorrelated off `E_S`.
3. **The claim list's SI**: the clause "`c(x) ∈ supp P(c(x) = · | E_S-factor)`" is automatic (SI-2). The true iff is SI-3's: equality at `u`
   ⟺ supports disjoint on `u`-edges.
4. **Scope, in the Poros record's F4 and F5**: the Lusin–Souslin step and "`r₀R` is `τ_S`-open" rest on density of `R` in `G_S` and on
   stable-continuity of torsion characters (Lemma R (a), Lemma C (d)). With `G′_S` (profinite in place of the stable places) neither is needed, and
   R-U, SP hold for every real number field.

### 5.3 C0 scored

Every modal outcome was met: SI inequality TRUE (0.95); SI "⟹" TRUE (0.90); SI "⟸" GAP (0.70); A⁺ TRUE (0.90); B⁺ TRUE (0.85); R-U TRUE (0.80);
SP "only if" TRUE (0.97); SP "if" TRUE (0.75); control TRUE (0.90). C0 was written after one mental pass, which had already seen SI-2's reading
issue; its SI "⟸" row is therefore not an independent prediction. Mean probability on the realised outcome 0.86; no surprises, which after a
mental pass measures the pass as much as the claims (G21).

### 5.4 Lemma statements for J46

*One line each, no proofs. Notation as §1.2 (`G′_S`, `τ′_S`, `𝒜_S`, `p`, `M`, (G2)).*

- N1: `T + A + Fin_S` equals the group of `τ′_S`-continuous characters of `R`; `R` is dense in `G′_S`; `E_S` is a proper, dense, Haar-null Borel subgroup of `R̂`.
- N2: for `f ∈ L²(μ)`, `σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous, and these `f` are exactly `L²(𝒜_S)` for a translation-invariant σ-algebra `𝒜_S`.
- SI-1: for every `u ∈ U`, `−1/3 = E⟨h(0), h(u)⟩ + ∫_{R̂∖E_S} χ(u) dσ_μ(χ)`, with `h = E[g | 𝒜_S]`.
- SI-2: for every `μ` and `x`, `c(x) ∈ supp P(c(x) = · | 𝒜_S)` almost surely.
- SI-3: `∫_{R̂∖E_S} Re χ(u) dσ_μ = −(4/3) Σ_j E[P(c(0) = j | 𝒜_S) P(c(u) = j | 𝒜_S)]`; it is `0` iff the supports at `x` and `x + u` are a.s. disjoint for every `x`.
- SI-4: if equality holds for every `u ∈ U`, then `x ↦ min supp P(c(x) = · | 𝒜_S)` is an `𝒜_S`-measurable, translation-equivariant proper four-colouring.
- SI-5: if `F` satisfies (G2) and some `μ₂` has strict inequality at some `u₀`, then some `μ` has strict inequality at some `u` while `𝒜_S(μ)` carries an equivariant proper four-colouring `c′` with `c′(x) ∈ supp P(c(x) = · | 𝒜_S)`.
- SI-J: for independent `Φ` (a uniform translate of a periodic colouring), `c₂` (stationary) and `ε` (Bernoulli), the `E_S`-factor of `(Φ, c₂, ε)` is `σ(Φ) ∨ 𝒜_S(c₂)`.
- G2-11: C9's colouring `⌊4(2x + 3y)/7⌋` of `Γ₇` is proper, its gapped vertices are the 14 with `2x + 3y ∈ {0, 5} mod 7`, all missing colour 3, and some two of them are adjacent.
- SI-C: F2's colourings over ℚ(√11) (C9's `γ`, `Z̄ = {θ = 0}`, missing colour 3, fair bits) satisfy SI with equality at every `u` and every `S`.
- A⁺: over ℚ(√47), given T-C(A), every `μ` and every finite `S` have some `u` with strict inequality.
- B⁺: over a type-(B) field, given T-C, equality at every `u` implies `μ` is carried by Pull.
- R-U: every finite `U`-invariant measure on `R̂` gives `E_S ∖ (T + A)` measure 0, for every finite `S`.
- SP-if: a non-Haar finite positive `U`-invariant `E`-null measure yields a finite positive `U`-invariant `E`-null `τ` with `∫ Re χ(1) dτ < 0`.
- SP-Cor: over ℚ(√47), given T-C(A) at `S = ∅`, if every finite positive `U`-invariant `E`-null measure on `R̂` is a multiple of Haar, then `χ(ℚ(√47)²) ≥ 5`.

### 5.5 Would-have-searched-here log (stage 5)

- None.

## Where the 2026-09-26 work on this lives

*Pointer block (consolidation job C1, 2026-09-26): addresses only — each result lives in its ledger row and derivation entry; the per-job index is `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`.*

See: `LEDGER.md` row 117 (`plans/FS100-derivation.md` FS100-K0); row 121 (`plans/FS100-derivation.md` FS100-Q47); row 123 (`plans/FS100-derivation.md` FS100-K0b, FS100-SPC).

## Filed by FS129-Z1 (2026-10-03): eight theorems this record proved and no entry carried

*Dated entries, appended by FS-129's record job (`plans/FS129-Z1-record.md`; `plans/FS129-close-inventory.md` item 110), found by FS129-SA1
(`plans/FS129-SA1-audit.md` § 4.2). They are inputs of row 121, `χ(ℚ(√47)²) = 5`: FS100-Q47's grade (`plans/FS100-derivation.md` line 204) reads
"SP-Cor three minds (J45; J46-13 from its statement; X05V blind) over N1, N2, R-U, A⁺ each two blind minds (J45; J46-1, J46-7, J46-5)", and FS103-F-*'s
(`plans/FS103-derivation.md` line 72) names "J45-N1/N2, R-U, SP-oi". Each statement is this file's "Theorems this phase proved" row, verbatim (for
SP-oi and SP-if the row points to SP, so the lemma of § 4.2 is quoted after it, verbatim); the notation is § 1.2's; the grade is the row's. The mind
count is J45's own (one deriver; the rows state no count). J46's blind verification (`plans/FS84-SI-V-verification.md`) is named where it touches a
statement and is not counted: this file does not count it, and the record job raises no grade. Uses-only, not-claimed and model lines are read off
the proofs above, by the record job; nothing above this section is changed.*

derivation: J45-N1
  statement: `E_S = T + A + Fin_S` is exactly the group of characters continuous for `R → R̂_prof × (L⊗ℝ) × ∏_{v∈S} L_v`; `R` is dense there;
    `E_S` is a proper dense σ-compact subgroup, Haar-null, `U`-invariant, Borel-isomorphic to the dual group
  uses only: J28V-7's finite index of `NR` in `R` (`[LevitzMott1972]`); weak approximation for the norm-one torus of `L/F`; that characters of a
    closed subgroup of an LCA group extend; Lusin–Souslin; the open-mapping theorem for σ-compact LCA groups; Steinhaus–Weil (Lemma N1's proof,
    § 2.1; § 5.1's "Inputs, by name")
  not claimed: Lemma R or Lemma C (neither is used); that `E_S` is J28D's `G_S`-continuity group in general — the two agree when every torsion
    character is stable-continuous (§ 1.2; the Remark after Lemma N2)
  converse: § 2.1 The two notation lemmas
  argument: § 2.1 The two notation lemmas
  verdict: derived
  grade: hand
  minds: 1 — J45's derivation; FS100-Q47's grade counts a blind second derivation by J46 (J46-1), not counted here
  model: `F = ℚ(√47)`, `S = ∅`: `E_∅ = T + A`, a proper dense Haar-null subgroup of `R̂` (the setting of SP-Cor, § 4.2)
  prior art: owed — none recorded in this file; FS129-SA1 found the statement and ran no search
  handoff: de Bruijn — an input of FS100-Q47 (row 121); FS129-SA1 § 6.3 lists it among the statements upstream of FS100-Q47 with no entry

Rests on it: J45-N2, J45-SI-J (through N1 (c)), J45-SP-if (the openness of `r₀R`), R-U (FS100-EFZ's first clause), and through them A⁺, SP-Cor and
FS100-Q47 (row 121).

derivation: J45-N2
  statement: the vectors of `L²(μ)` with spectral measure on `E_S` are `L²(𝒜_S)` for a translation-invariant σ-algebra, and `Π(E_S) = E[·|𝒜_S]`
  uses only: Bochner on `G′_S`; J45-N1 (b) (`R` dense in `G′_S`); uniqueness of Fourier–Stieltjes coefficients on the compact `R̂`; dominated
    convergence (`G′_S` metrizable); that the bounded vectors with `τ′_S`-continuous orbits form a conjugation-closed algebra closed under `|·|` and
    truncation; that `Π(E_S)` commutes with every `V_y` (Lemma N2's proof, § 2.1)
  not claimed: anything about which `μ` has its spectrum on `E_S`; the same with `E = ⋃_S E_S` read as one factor — equality there gives a colouring
    measurable for `⋁_S 𝒜_S`, not for a single `𝒜_S` (§ 2.2, "What SI-5 means")
  argument: § 2.1 The two notation lemmas
  verdict: derived
  grade: hand
  minds: 1 — J45's derivation; FS100-Q47's grade counts a blind second derivation by J46 (J46-1), not counted here
  model: J45-SI-C's colouring `μ` over ℚ(√11): its `𝒜_S` contains `σ(Φ)`'s torsion eigenfunctions, and the constant `1` lies in `L²(𝒜_S)`
  prior art: owed — none recorded in this file
  handoff: de Bruijn — with J45-N1, an input of FS100-Q47 (row 121)

Rests on it: the identity SI-1, J45-SI-4 (`p(x)` is `𝒜_S`-measurable), and through SI-4 A⁺ and FS100-Q47.

derivation: J45-SI-4
  statement: equality at every `u` ⟹ every selection from the supports is an `𝒜_S`-measurable equivariant proper four-colouring
  uses only: SI-3 (equality at `u` makes the supports at `x` and `x + u` disjoint) and SI-2; J45-N2 (`p(x)` is `𝒜_S`-measurable); the versions
    `p_j(x) = p_j(0) ∘ T_x` (§ 2.2)
  not claimed: the converse, SI's "⟸" (a GAP at "an `𝒜_S`-measurable proper colouring forces adjacent supports apart"; over a (G2) field equivalent to
    universal equality, J45-SI-5); that the selection is `c` itself
  argument: § 2.2 SI
  verdict: derived
  grade: hand
  minds: 1 — J45's derivation; J46 derived the min-support selection blind (J46-3, `plans/FS84-SI-V-verification.md`'s divergence table, row "SI ⟹"),
    not counted here
  model: J45-SI-C's colourings over ℚ(√11): equality at every `u`, and the min-support selection is C9's `γ_Φ`, proper
  prior art: owed — none recorded in this file
  handoff: de Bruijn — FS129-SA1 § 4.2: "A⁺ is SI-4 with N2 (FS100-K0)"; an input of FS100-Q47 (row 121)

Rests on it: A⁺ (with T-C(A)), and through it SP-Cor and FS100-Q47 (row 121).

derivation: J45-SI-5
  statement: under (G2), "`𝒜_S` carries a proper colouring ⟹ equality" holds for every `μ` over `F` iff every `μ` over `F` has equality at `S`
  uses only: SI-3; J45-SI-J; rotation by `v ∈ U` (`E_S` is `U`-invariant, J45-N1); (G2)'s adjacent gapped pair with one missing colour; the pointwise
    ergodic theorem along tempered Følner sequences (`γ_Φ ∘ π_𝔓` is `c`-measurable); torsion eigenfunctions (Lemma SI-5's proof (a)–(d), § 2.2)
  not claimed: that either side holds — over a (G2) field, ℚ(√11) among them, both are open, which is why SI's "⟸" is a GAP; anything over a field
    without (G2)
  converse: § 2.2 SI
  argument: § 2.2 SI
  verdict: derived
  grade: hand
  minds: 1 — J45's derivation; J46 re-derived it from J45's statement (J46-11, "hand; from J45's statement"), a sighted reading, not counted here
  model: `F = ℚ(√11)`, which satisfies (G2) at 7 (J45-G2, tools exact: C9's `⌊4θ⌋` on `Γ₇` has 14 gapped vertices, all missing colour 3, spanning
    28 directed edges)
  prior art: owed — none recorded in this file
  handoff: de Bruijn — FS129-SA1 § 6.3 lists it among the statements upstream of FS100-Q47 with no entry; it scopes SI's "⟸"

Rests on it: the GAP verdict on SI's "⟸" (§ 5.1) and the correction to the Poros record's EI-2 reading (§ 2.2, "What SI-5 means").

derivation: J45-SI-J
  statement: the `E_S`-factor of an independent product of a finite translation system, a Bernoulli process and `c₂` is `σ(Φ) ∨ 𝒜_S(c₂)`
  uses only: `L²(Φ)` is a finite sum of torsion eigenlines; Bernoulli shifts have Lebesgue spectrum, so a vector of `L²₀(ε)` has spectral measure
    `≪ Haar`, which gives `E_S` measure 0 (J45-N1 (c)); spectral measures of independent tensor products convolve; `T ⊆ E_S`, a subgroup (Lemma
    SI-J's proof, § 2.2)
  not claimed: anything for a dependent product, or for noise that is not Bernoulli
  argument: § 2.2 SI
  verdict: derived
  grade: hand
  minds: 1 — J45's derivation; J46 re-derived it with SI-5 (J46-11), not counted here
  model: J45-SI-C's construction — `Φ` a uniform translate of C9's colouring of `Γ₇`, `ε` fair bits, no `c₂`
  prior art: owed — none recorded in this file
  handoff: de Bruijn — with J45-SI-5 and J45-SI-C, which use it

Rests on it: J45-SI-5 (step (c)) and J45-SI-C.

derivation: J45-SI-C
  statement: F2's noisy colourings over ℚ(√11) satisfy SI with equality at every `u` and `S`, with `σ_μ(R̂ ∖ E) > 0`
  uses only: C9's colouring `γ = ⌊4θ⌋` of `Γ₇` and the exact facts of `tools/crunch_j45_gap7.py` (2)–(4) — `Z̄ = {θ = 0}` independent, every vertex of
    it gapped with missing colour 3, the supports disjoint on all 392 directed edges; J45-SI-J; SI-3; J45-N1 (c) (§ 2.3)
  not claimed: that every four-colouring over ℚ(√11) has equality (open: J45-SI-5's equivalent); anything over ℚ(√47)
  argument: § 2.3 The control: F2's colourings satisfy SI with equality
  verdict: derived
  grade: hand — the row's grade is "[hand + tools exact]": the tool's items (2)–(4), exact over `Γ₇`'s 49 vertices and 392 directed edges, its two
    plants firing (§ 2.3)
  minds: 1 — J45's derivation; J46's control (J46-9, "TRUE under 'a.s. proper'") fixed the hypothesis, not the example, and is not counted here
  model: the colouring itself — `γ = ⌊4(2x + 3y)/7⌋` on `Γ₇`, `Z̄ = {θ = 0}`, missing colour 3, fair bits
  prior art: owed — none recorded in this file
  handoff: de Bruijn — FS129-SA1 § 6.3 lists it among the statements upstream of FS100-Q47 with no entry; its finite facts are a `decide` over `Γ₇`

Rests on it: SI's control (§ 5.1): equality with spectrum off `E`, so equality does not force the spectrum onto `E`.

derivation: J45-SP-oi
  statement: SP's "only if" — Lemma SP-only-if (§ 4.2), verbatim: "If a finite positive `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`,
    then `τ` itself is a `U`-invariant finite measure with `τ(E) = 0` that is not a multiple of Haar"
  uses only: `∫ χ(1) dHaar = 0` on the compact `R̂`, because `1 ≠ 0` in `R` (§ 4.2)
  not claimed: SP's "if" (J45-SP-if); that such a `τ` exists (the open sign problem the Poros record's F5 names)
  argument: § 4.2 SP
  verdict: derived
  grade: hand
  minds: 1 — J45's derivation (the row: "[hand]", § 5.1 "one line")
  model: none known — a finite positive `U`-invariant `E`-null `τ` with negative mean at `1` is exactly the open object; the statement is the one-line
    direction of SP's equivalence, used inside SP-Cor's chain
  prior art: owed — none recorded in this file
  handoff: de Bruijn — FS103-F-*'s grade names it (`plans/FS103-derivation.md` line 72); with SP-Cor's chain (FS100-SPC, FS100-K0b, row 123)

Rests on it: SP's equivalence and, through it, SP-Cor's reading of MR (§ 4.2); FS103-F-* (line 72).

derivation: J45-SP-if
  statement: SP's "if" (positive measures; complex with `|ν|(E) = 0`) — Lemma SP-if (§ 4.2), verbatim: "If some finite positive `U`-invariant `ν` with
    `ν(E) = 0` is not a multiple of Haar, then some finite positive `U`-invariant `τ` has `τ(E) = 0` and `∫ Re χ(1) dτ < 0`."
  uses only: Fourier uniqueness on the compact `R̂`; `−1 ∈ U` (so `ν̂(r₀)` is real); J28V-7 (`MR ⊆ r₀R`, so `r₀R` is `τ′_S`-open and the dual of
    multiplication by `r₀` keeps characters off `E`); a real place of `F` and the archimedean circle measure of radius `r`, `2πr = j₁,₁`,
    `J₀(j₁,₁) < 0`; that `E` is a group containing `A` (§ 4.2); for complex `ν`, the Jordan parts of `Re ν`, `Im ν` (§ 4.2, Readings)
  not claimed: the literal value reading for signed measures, under which the hypothesis always holds and "if" would assert the open sign problem
    itself (§ 4.2, Readings); that a non-Haar `E`-null invariant measure exists
  argument: § 4.2 SP
  verdict: derived
  grade: hand
  minds: 1 — J45's derivation (the row: "[hand]")
  model: none known for the hypothesis — a non-Haar finite positive `U`-invariant `E`-null measure is the zero-entropy question the Poros record's F5
    names; the statement is a reduction, used through SP
  prior art: owed — none recorded in this file
  handoff: de Bruijn — FS129-SA1 § 6.3 lists it among the statements upstream of FS100-Q47 with no entry; with SP-Cor's chain (FS100-SPC, FS100-K0b)

Rests on it: SP's equivalence (with J45-SP-oi), hence the form of SP-Cor in which MR's measure statement is what decides `χ(ℚ(√47)²) ≥ 5`.
