# FS131-EN1 — does the proof under rows 121 and 123 need the split places? Five statements read off the kernel proof, derived or refuted from the derivations

*Derivation record of job **FS131-EN1** (Ephodos, Opus 5.5, 2026-10-13). Brief: `data/fs131/briefs/FS131-EN1-shorter-route.md`, with
`plans/STANDING-RULES.md` as part of it. The statements are `data/fs131/claims-EN1.md`'s, fixed before launch in the proposer's words (the kernel
planner's message, item 642 of `plans/FS131-close-inventory.md`). I write this file, `data/fs131/en1/` and `data/fs131/reports/FS131-EN1.md`,
and nothing else; no agent of my own; no search; no Lean build. An erratum to an older file is drafted here, never written there.*

## Theorems this phase proved

*(filled at each stage's save; one line per statement, with its grade and its address in this file)*

## Stage 1 — SAVED (readback: the quotations, the symbols, the statements in my words)

### 1.1 Quotation check (standing rule 3)

`data/fs131/en1/quote_check.py` takes every block quotation of the brief (a line `> …` followed by `> — source: <path>`) and looks for it as a
verbatim line of the file its source line names. Run 2026-10-13: `0 7` — seven quotations, none missing (W2 against
`data/fs131/REQUEST-2026-10-13.md` line 4; the six EN1 lines against `data/fs131/claims-EN1.md` lines 7–11 and 15). With `--plant` (one
character of each quotation changed) it prints `7 7`: the check can fail.

| # | in the brief | source | result |
|---|---|---|---|
| Q1 | W2, Kooshi's rule (brief l. 26) | `data/fs131/REQUEST-2026-10-13.md` l. 4 | verbatim |
| Q2–Q6 | EN1-MRPLUS, -FROM-TWO, -SPCOR, -APLUS, -OFFPATH (brief ll. 47–59) | `data/fs131/claims-EN1.md` ll. 7–11 | verbatim, each |
| Q7 | EN1-NC (brief l. 62) | `data/fs131/claims-EN1.md` l. 15 | verbatim |
| Q8 | "`Interface.mr_of_pe2_efPlus` at its line 196 and `x4_eq_empty` near line 519" (not a block quotation) | `Proofs/HadwigerNelson/SpectralChain.lean` ll. 196, 519 | both declarations are at those lines |
| Q9 | "(the proposer says a clause named `hHE` there is bound and never used)", attached by the brief's sentence to `x4_eq_empty` | the proposer's message, `plans/FS131-close-inventory.md` item 642: "The kernel proof does exactly this; its Haar-null clause `hHE` is bound and never used" — said of the proof of the sentence it calls MR⁺, i.e. of `mr_of_pe2_efPlus` | **a mismatch in the brief's paraphrase, not in a quoted statement**: `hHE` is bound at l. 198, inside `Interface.mr_of_pe2_efPlus`; the name does not occur in `x4_eq_empty` (`data/fs131/en1/unused_check.py`: 1 occurrence in the first theorem — its binder — and 0 in the second). The proposer's own sentence is right as it stands |

Q9 changes nothing below: the clause in question is PE-2's "`τH I.E = 0`" (l. 179, "the Haar part is `E`-null (N1)"), and where it is read is
§ Stage 4.

### 1.2 The symbols, each resolved to its entry and address

| symbol | what it is | where it is fixed |
|---|---|---|
| `F`, `L`, `U = U_F`, `R = ℤ[U_F]`, `R̂` | a real number field; `L = F(i)`; the norm-one elements of `L/F` (the unit vectors of `F²`); the ring they generate; its dual, `U` acting by `(u·χ)(r) = χ(ur)` | `plans/FS84-SI-D-derivation.md` § 1.2 (ll. 41–44); `plans/FS100-derivation.md` ll. 8–10 |
| `R = O′` | `R` is the ring of elements of `L` integral at every stable prime (the split primes inverted) — row 100's Lemma C′, unconditional except possibly at a stable dyadic place ramified in `L/F` | `LEDGER.md` row 100; `plans/FS100-X01D-derivation.md` § 2.0 (l. 116) |
| `T`, `A` | the torsion characters of `R`; the archimedean ones (continuous for the topology `R` gets from `L ⊗ ℝ`) | `plans/R88-derivation.md` l. 21; `plans/FS84-SI-D-derivation.md` § 1.2 |
| `Fin_S`, `E_S`, `E` | characters continuous for the `S`-adic topology, `S` a finite set of split places; `E_S = T + A + Fin_S`; `E = ⋃_S E_S`. So `E_∅ = T + A` | `plans/FS100-derivation.md` ll. 9–10; `plans/FS84-SI-D-derivation.md` § 1.2 (l. 53) |
| "the profinite-plus-archimedean topology" | `τ′_∅`: the topology on `R` induced by the diagonal map `R → G′_∅ = R̂_prof × (L ⊗ ℝ)` (J45's `G′_S` at `S = ∅`) | `plans/FS84-SI-D-derivation.md` § 1.2 (ll. 53–57), § 2.1 Lemma N1 (l. 105) |
| `m`; `h_τ(u)` | Haar probability on `R̂`; the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `τ` | `plans/FS100-derivation.md` l. 150 |
| PE-2 | "for every real number field `F`, every `U`-invariant finite positive measure `τ` on `R̂` is `a·m + τ′`, `a ≥ 0`, `τ′` `U`-invariant with `h_{τ′}(u) = 0` for every `u ∈ U`" | FS100-PE2, `plans/FS100-derivation.md` l. 191; proofs `plans/FS100-X02D-derivation.md` § 3, `plans/FS100-X02V-verification.md` § 2.3 |
| EF_F⁺ | "for every real number field `F` (with `R = O′`), every `U`-invariant finite positive Borel measure `μ` on `R̂` with `h_μ(u*) = 0` for one non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`" | FS100-EFP, `plans/FS100-derivation.md` l. 162; proofs `plans/FS100-X01D-derivation.md` § 3, `plans/FS100-X12B-derivation.md` § 2 |
| MR(F) | "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar" | FS100-MR, `plans/FS100-derivation.md` l. 201; `LEDGER.md` row 120 |
| R-U | "every finite `U`-invariant measure on `R̂` gives `E_S ∖ (T + A)` measure 0, for every finite `S`" | J45-RU, `plans/FS84-SI-D-derivation.md` § 4.1 (l. 280), § 5.4 (l. 394); FS100-EFZ, `plans/FS100-derivation.md` l. 176 |
| N1, N2 | the group `E_S` (a: `E_S` is the group of `τ′_S`-continuous characters; b: `R` dense in `G′_S`, a `U`-equivariant Borel isomorphism `Ĝ′_S → E_S`; c: `E_S` proper, dense, Haar-null, hence `Haar(E) = 0`); the `E_S`-factor `𝒜_S` | J45-N1, J45-N2, `plans/FS84-SI-D-derivation.md` § 2.1 (ll. 105, 126), entries at ll. 419, 439 |
| SI-3, SI-4 | the off-`E_S` integral as a collision probability; equality at every `u` gives an `𝒜_S`-measurable proper colouring | `plans/FS84-SI-D-derivation.md` § 2.2 (ll. 153, 159); J45-SI-4's entry at l. 456 |
| A⁺ | "over ℚ(√47) (and every field in T-C(A)'s class), for every translation-invariant random proper four-colouring `μ` and every finite set `S` of split places, some `u ∈ U` has `∫_{R̂∖E_S} Re χ(u) dσ_μ < 0`", with remark (ii): constant in `u` when `μ` is rotation-invariant | `plans/FS84-SI-D-derivation.md` § Stage 3 (ll. 240–250) |
| T-C(A) at `S = ∅` | "no translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A`" — R88-TCA at `S = ∅` | `plans/R88-derivation.md` R88-TCA (l. 161); `LEDGER.md` row 113; in every degree FS100-TCA, `plans/FS100-derivation.md` l. 291 |
| SP-Cor | "over ℚ(√47): if every finite positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`", given T-C(A) at `S = ∅`; over the class, FS100-K0, K0b, SPC | `plans/FS84-SI-D-derivation.md` § 4.2 (l. 321); `plans/FS100-derivation.md` ll. 129, 277, 295 |
| rows 121, 123 | `χ(ℚ(√47)²) = 5`; the main clause through five | `LEDGER.md` ll. 166, 168; FS100-Q47, FS100-COR (`plans/FS100-derivation.md` ll. 206, 299) |
| rows 112, 116–118 | Theorem C (R88-TC); Kronecker selection; T-C(A)'s class with K0; rank one of the selection | `LEDGER.md` ll. 157, 161–163 |
| the kernel's interface | `Interface` carries sets `E`, `TA` and a function `h`; `RU`, `APlus0`, `PE2`, `EFPlus`, `MR` are `Prop`s about them | `Proofs/HadwigerNelson/SpectralChain.lean` ll. 130–193 |

Nothing in the five statements is unresolved. Two words need a reading, fixed here before any derivation:

- **"finite … measure"** (EN1-MRPLUS). Read as *finite positive Borel measure*: that is the Lean `Measure` of the interface the statement was
  read from, and the records' own sense (J45 § 1.2: "a finite positive Borel measure (the standard sense …)"). The signed reading is scored
  separately in § Stage 4.
- **"the path of ledger rows 121 and 123"** (EN1-OFFPATH). Read as: the set of hand results and outside theorems that a complete proof of the two
  rows cites, taking each cited result's *proof* in the records as it is written, down to textbook facts. A result is *on the path* if some proof
  on it cites it or runs its argument; so I list both citations and mechanisms (brief, § Done means, item 3).

### 1.3 The statements, in my own words

- **EN1-MRPLUS** names a sentence: over a real number field `F`, a finite positive measure on `R̂` that is invariant under every rotation and
  gives the set `T + A` measure zero is a multiple of Haar measure, said through its Fourier coefficients (`∫ χ(r) dτ = 0` for every `r ≠ 0` of
  `R`). It is MR(F) with the hypothesis "`τ(E) = 0`" weakened to "`τ(T + A) = 0`"; since `T + A ⊆ E`, MR⁺ is the stronger sentence.
- **EN1-FROM-TWO** says MR⁺(F) is a three-line consequence of PE-2 and EF_F⁺ and of nothing else of ours: decompose `τ`, note that the
  zero-entropy part `τ′` is below `τ` and so null on `T + A`, and that EF_F⁺ makes it null off `T + A`.
- **EN1-SPCOR** says the proof that a four-colouring of the plane is impossible (SP-Cor), run with the set `T + A` in the place of `E`, uses of
  our hand results only MR⁺(F) and A⁺ at `S = ∅`, and that R-U then reads "the empty set has measure zero".
- **EN1-APLUS** says the proof of A⁺ at `S = ∅` — through SI-3, SI-4 and N2 at `S = ∅` — never reads the set `E` except as `E_∅ = T + A`, and
  that N2 at `S = ∅` does still rest on N1 (a) at `S = ∅`.
- **EN1-OFFPATH** says: once SP-Cor and MR are run at `T + A`, no proof on the path of rows 121 and 123 cites R-U, or the split-place topology
  R-U stands on, or N1's clauses about split places, or `Haar(E) = 0`; and nothing changes for rows 112 and 116–118, which do use the
  split-place `E`.
- **EN1-NC** disclaims: novelty; R-U being false or unneeded elsewhere; other rows; that the kernel's theorems already state MR⁺(F).

### 1.4 What I read before any verdict

In full: the brief; `plans/STANDING-RULES.md`; `data/fs131/claims-EN1.md`; `Proofs/HadwigerNelson/SpectralChain.lean`;
`plans/FS84-SI-D-derivation.md` (J45); `plans/FS100-derivation.md`; `plans/FS100-X01D-derivation.md` §§ 2–4; `plans/FS100-X12B-derivation.md`
§ 2; `plans/FS100-X02D-derivation.md` §§ 2.2–3; `plans/FS100-K-kernel-47.md` §§ 1.3–1.4 and the stage-2 addendum; `LEDGER.md` rows 99, 100,
120, 121, 123; `plans/R88-derivation.md` ll. 15–23, 83–121, 161–172; `plans/FS86-R88-D-derivation.md` § 3.2 C1–C5;
`plans/FS100-three-field-lemma.md` §R-close (stage 5) 1.2 (the six-link ladder); item 642 of `plans/FS131-close-inventory.md`. By grep, for the
words `R-U`, `N1`, `E`, `split`: `plans/FS84-SI-V-verification.md` (J46), `plans/FS100-X02D-derivation.md`. What is read later is said at the
stage that reads it.
