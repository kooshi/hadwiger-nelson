*Verification record of crunch job **X05V** (Coxeter, blind verifier, Opus 5.5), the ×2×3 crunch, 2026-09-26. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X05V-sp-cor-flip-verifier.md`, with `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` as part of
it. Blind to X03D (fences in the brief). No subagents; no finite-witness search (ban to 2026-10-01). I touch only this file,
`data/fs100/x05v/`, `tools/x05v_*.py` and my report.*

## Theorems this phase proved

*(filled at stage 3)*

## Stage 1 — SAVED (quotation check, C0)

### 1.1 Quotation check (standing rule 5)

| item in the brief | source | result |
|---|---|---|
| SP-Cor, "Over ℚ(√47): if every finite positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`." | `plans/FS84-SI-D-derivation.md` l. 321–322 (the statement lines only; §4's proof not read) | **verbatim match**; grade "[hand; given T-C(A) at `S = ∅`]" matches |
| FL-1, FL-2 and §2's notation paragraph | `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, list X03 | copied verbatim below (1.2) |
| KC, "MR is consistent with Theorem B at K and with ℚ(√11)'s non-periodic four-colourings (row 94), whose spectral measures lie in T + Fin_S plus Haar. SP-Cor fails at those fields exactly at T-C(A)." | the advisor's [P-5a], in `plans/POROS-2026-09-26-x2x3-crunch.md` (fenced) | **not checkable** (source fenced); taken as the brief states it. Content note for stage 2: row 94's non-periodic colouring `⌊4θ⌋` has an archimedean term, so its spectrum is on `T + A` (row 112: "C9's colouring has spectrum on `T + A`"), not on `T + Fin_S` |
| "J45's lemma statements (§5.4: SI-1 to SI-5, RU, SP-oi, SP-if, A⁺, B⁺)" | `plans/FS84-SI-D-derivation.md` §5.4 | §5.4 lists N1, N2, SI-1…SI-5, SI-J, G2-11, SI-C, A⁺, B⁺, R-U, SP-if, SP-Cor. **SP-oi is not in §5.4**; it appears only in the theorems table (l. 24) as "SP's 'only if'". SP's statement is taken from J45's brief, quoted verbatim from the Poros record §4.4 (below) |
| R88-TCA | `plans/R88-derivation.md` l. 161 | read, statement only (quoted in 1.2) |
| rows 94, 98, 105, 112, 113, 117 | `LEDGER.md` | read |

### 1.2 The inputs, verbatim

**Notation** (queue §2, verbatim): "`F ⊆ ℝ` a real number field, `L = F(i)`, `U = U_F` the unit vectors (norm-one elements of `L/F`),
`R = ℤ[U]`, `R̂` its dual; `T` the torsion characters, `A(R_F)` the archimedean ones, `E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the
finite set `S` of split places) — `LEDGER.md` rows 98, 113." Added there: "`U` acts on `R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on
`R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`; for `u ∈ U`, `H(u) = ∏_w max(1, |u|_w)` over the finite places `w` of `L`
(normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`."

**FL-1** (queue §2, list X03, verbatim): "Over ℚ(√47), given T-C(A) at `S = ∅` and rows 112–113's inputs: for every translation- and
rotation-invariant random proper four-colouring of the plane, with the colours embedded as the vertices of a regular tetrahedron centred at
`0` and `σ` the trace of its spectral measure on `R̂` (`σ(R̂) = 1`), write `σ = a·m + σ_E + τ` with `σ_E` carried by `E` and `τ(E) = 0`
non-Haar. Then `τ ≠ 0`, and `τ̂(u) = τ̂(1) ≤ −τ(R̂)/3` for every `u ∈ U`."

**FL-2** (verbatim): "Over ℚ(√47), given T-C(A) at `S = ∅`: if every `U`-invariant, `E`-null finite positive measure `τ` on `R̂` satisfies
`τ̂(1) > −τ(R̂)/3` whenever `τ ≠ 0`, then `χ(ℚ(√47)²) = 5`."

**SP** (J45's brief, quoting the Poros record §4.4, verbatim): "a `U_F`-invariant finite positive measure `τ` on `R̂` with `τ(E) = 0` and
`∫ Re χ(1) dτ < 0` exists if and only if some `U_F`-invariant finite measure on `R̂` with `τ(E) = 0` is not a multiple of Haar measure."

**R88-TCA** (`plans/R88-derivation.md` l. 161, statement): "over ℚ(√47), and (J28D) over every real field whose stable places all have
all-levels ratio `< 1/4`, no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A + Fin_S` for a finite
set `S` of split places, dyadic ones included; …"

J45's §5.4 statements used below (verbatim): "SI-1: for every `u ∈ U`, `−1/3 = E⟨h(0), h(u)⟩ + ∫_{R̂∖E_S} χ(u) dσ_μ(χ)`, with
`h = E[g | 𝒜_S]`." "SI-3: `∫_{R̂∖E_S} Re χ(u) dσ_μ = −(4/3) Σ_j E[P(c(0) = j | 𝒜_S) P(c(u) = j | 𝒜_S)]`; it is `0` iff the supports at `x`
and `x + u` are a.s. disjoint for every `x`." "SI-4: if equality holds for every `u ∈ U`, then `x ↦ min supp P(c(x) = · | 𝒜_S)` is an
`𝒜_S`-measurable, translation-equivariant proper four-colouring." "A⁺: over ℚ(√47), given T-C(A), every `μ` and every finite `S` have some `u`
with strict inequality." "R-U: every finite `U`-invariant measure on `R̂` gives `E_S ∖ (T + A)` measure 0, for every finite `S`." "N1: … `E_S`
is a proper, dense, Haar-null Borel subgroup of `R̂`." "N2: for `f ∈ L²(μ)`, `σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous, and
these `f` are exactly `L²(𝒜_S)` for a translation-invariant σ-algebra `𝒜_S`."

### 1.3 C0 — probabilities per claim

*Honest timing:* written after reading the inputs above and a first informal pass (about ten minutes), not as a clean prior.

| claim | TRUE | GAP | FALSE |
|---|---|---|---|
| SP-Cor (re-derived from the lemma statements) | 0.85 | 0.12 | 0.03 |
| KC (the chain stops exactly at T-C(A) at K and at ℚ(√11)) | 0.80 | 0.15 | 0.05 |
| FL-1 as written, every clause | 0.25 | 0.60 | 0.15 |
| FL-2 | 0.30 | 0.60 | 0.10 |

### 1.4 Slips, logged as they happen

- **Fence touched (05:53):** a `grep -n "P-5a\|P-5\b"` over the whole queue printed line 228, which is in §6 (fenced): "P-5 (adopted): a blind
  check of SP-Cor (X05V) and the headline cap (inventory item 8); the known-positive control KC." Nothing about any derivation; no further
  §6 text read. Logged for the owner.

### 1.5 Would-have-searched-here log

- none in stage 1.
