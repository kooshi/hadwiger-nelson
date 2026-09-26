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
