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

## Stage 2 — SAVED (recognition: what the five statements are, before any verdict)

*`ephodos-recognition`, invoked fresh, run on the claim list. The object here is not a theorem that will not come; it is a chain of proofs in
which a set `E` appears, and the question is which of `E`'s features the chain consumes. So the cut is the skill's one cut — what determines
against what accompanies — applied to `E`.*

### 2.1 For a stranger (an ergodic theorist who works on rigidity of algebraic actions)

A countable abelian group `U` acts by automorphisms on a compact abelian group `X = R̂`. There is a measure classification in two halves: every
finite invariant measure is `a·Haar` plus a part of zero entropy; and every invariant measure of zero entropy is carried by a named `U`-invariant
σ-compact subgroup `H ⊂ X` (here `H = T + A`). A consumer has a `U`-invariant finite measure `σ` on `X` with `∫_{X∖H} Re χ(1) dσ < 0` and wants a
contradiction. The records ran the consumer through a larger `U`-invariant subgroup `E ⊇ H`: they stated the classification as "an invariant
measure null on `E` is a Haar multiple", restricted `σ` to `X ∖ E`, and bridged the difference with a lemma, "no finite invariant measure
charges `E ∖ H`" (R-U). The five statements say: state the classification as "null on `H`" and the bridge is not needed.

**This is** a classification theorem whose exceptional set was written larger than the set its exceptional measures live on. In that field's
words the sharp form of "invariant and null on the exceptional set ⟹ Haar" takes the exceptional set to be exactly where the non-Haar
measures sit, and R-U is the statement that `E ∖ H` is a **wandering** piece of the action: for each split place there is a `u ∈ U` whose
powers move a shell `{1 ≤ |ξ₁|_v < |t|_v⁻¹}` off itself, so a finite invariant measure gives it nothing (Poincaré recurrence, read backwards).
That is J45's proof of R-U word for word (`plans/FS84-SI-D-derivation.md` § 4.1, "the sets `uⁿ{…}` are disjoint, of equal measure").

### 2.2 The features of `E`, sorted

| feature of `E` | determines / accompanies, on the path of rows 121 and 123 | receipt |
|---|---|---|
| `T + A ⊆ E` | **determines**, and it is the only consequence of "`τ(E) = 0`" that MR's proof consumes: the feature *splits* — "`τ` is null on `E`" is used as "`τ` is null on `T + A`" | FS100-MR (a): "`τ′ ≤ τ` carried by `T + A ⊆ E`, `τ(E) = 0`, so `τ′ = 0`"; the kernel proof, l. 204: `measure_mono_null I.TA_subset_E hE'` |
| `T + A` as EF_F⁺'s conclusion | **determines**; no smaller set will do | FS100-EFX: arc length on a circle of archimedean characters is invariant, of zero entropy and carried by `A`; the spectra of the four-colourings at K and ℚ(√11) sit on `T` (X01D § 4.2) |
| `T + A` as the continuity group of the profinite-plus-archimedean topology (N1 (a) at `S = ∅`) | **determines** N2 at `S = ∅` | N2's ⟸ runs through Bochner on the completion; without the identification its measure lands on an unnamed set (§ Stage 3) |
| `R` dense in `G′_∅` (N1 (b) at `S = ∅`) | **unsorted** at this stage | N2's proof cites it; whether it consumes it is § Stage 3's question |
| `Fin_S`, `S ≠ ∅`: the split-place coordinates of `E`, with N1 (a), (b) at `S ≠ ∅` | **accompanies** — if the bridge is all that reads them | to be shown by the walk (§ Stage 6): every other reading of the larger set must be found or shown absent |
| `Haar(E) = 0` (N1 (c)) | **accompanies** | FS100-MR: "MR uses neither R-U nor `m(E) = 0`"; the kernel proof binds the clause and never uses it (`unused_check.py`: one occurrence, the binder) |
| that the split places are where `R` has denominators (`R = O′`) | **determines**, but it is a feature of `R`, not of `E` | EF_F⁺'s model `R̂ ≅ W/Λ`, `W = L_∞ × ∏′_{w split} L_w` (X01D § 2.0; X12B § 2.0) |

### 2.3 What the recognition predicts, and where it differs from the proposer's picture

1. **R-U's argument is inside EF_F⁺.** If `E ∖ (T + A)` is a wandering piece, then any proof that a class of invariant measures is carried by
   `T + A` must run the wandering argument at the split places, and EF_F⁺ is such a proof. Checked at once, in both derivations: X01D § 3.8
   ("Step 7 — wandering shells kill every other place", over the countably many split `w`), and X12B § 2.1 (Lemma Z: `ord_w` is equivariant, a
   finite measure on `ℤ ∪ {∞}` invariant under `k ↦ k + h` charges no integer). X01D says so itself (§ 3.8, "Sanity check … that is R-U"), and
   so does the plan's ladder ("Step 7 of EF_F⁺ re-derives R-U's mechanism internally", `plans/FS100-three-field-lemma.md` §R-close (stage 5)
   1.2, link L3). **This is the difference from the proposer's picture.** Its words are that E := T + A "removes R-U (J45 § 5.4; FS100-EFZ)
   from the leaves, together with J45-N1's clauses about the split places". What the recognition says: the *lemma* R-U and *J45's model* of the
   split places leave the path; the *argument* of R-U and *a* model of the split places do not — they are a step of EF_F⁺, which is itself a
   leaf. Stage 6 says exactly what stays.
2. **MR⁺ is MR and R-U in one sentence** (a neighbour the new name predicts; derived in § Stage 4 as EN1-EQUIV): given `Haar(E) = 0`,
   MR⁺(F) ⟺ MR(F) ∧ R-U(F). So MR⁺ is not a cheaper sentence than MR; what is saved is a second, separate proof of the wandering step.
3. **N2's home** (recalled, not read; it bears on no verdict below): the vectors whose spectral measure sits on the continuity group of a
   group topology are the vectors on which the action extends to the completion — the frame of eigenvalue groups of non-singular
   transformations and "saturated" subgroups of a dual (Aaronson–Nadkarni 1987; Host–Méla–Parreau 1991, both recalled by name only). A
   prior-art debt of J45-N2's entry, which reads "owed"; listed in the report.

**A recognition that differs from the plan's is a finding**: item 1 is one, and it is the fifth statement's whole risk. Sent to the
coordinator with the first verdict.

## Stage 3 — SAVED (EN1-APLUS: what A⁺ at `S = ∅` reads of `E`, line by line)

**Verdict: TRUE as worded** [hand; one mind — a reading of J45's proofs, with one exact text check]. Nothing in the proof of A⁺ at `S = ∅`
names the union `E`; every occurrence of the set is `E_S`, which at `S = ∅` is `T + A`. N2 at `S = ∅` does need N1 (a) at `S = ∅`. **What the
statement leaves out, and the planner needs:** N1 (a) is not all of N1 that A⁺ at `S = ∅` reads. As written it also reads N1 (b) at `S = ∅`
(`R` is dense in `R̂_prof × (L ⊗ ℝ)`), that `T + A` is Borel, and that `T + A` is stable under `U`. None of the three reads a split place.
N1 (c) — proper, dense, Haar-null — is not read at all.

### 3.1 The reading

J45's A⁺ (`plans/FS84-SI-D-derivation.md` ll. 240–250) is proved from SI-4, N2 and T-C(A); SI-4 from SI-3 and SI-2; SI-3 from SI-1; SI-1 from N2.
Each line that touches the set, at `S = ∅`:

| step (line) | the text | what it reads of the set | what it needs of N1, at `S = ∅` |
|---|---|---|---|
| N2, statement (l. 126) | "`σ_f(R̂ ∖ E_S) = 0` iff `y ↦ V_y f` is `τ′_S`-continuous" | `E_∅ = T + A`, as a Borel set and as the continuity group of `τ′_∅` | that `T + A` is Borel (it is σ-compact: `T` is countable, `A` a continuous image of `L ⊗ ℝ`) |
| N2, ⟹ (l. 128) | "dominated convergence along sequences (`G′_S` is metrizable)" | each `χ ∈ T + A` is `τ′_∅`-continuous | N1 (a), the inclusion `T + A ⊆` continuous characters (immediate); `R̂_prof` metrizable (countably many subgroups `NR`, each of finite index: J28V-7) |
| N2, ⟸ (ll. 128–130) | "it extends to a continuous positive-definite function on `G′_S` (N1 (b)); Bochner there gives `ν` on `Ĝ′_S`, and uniqueness … gives `σ_f = ρ_*ν`, carried by `E_S`" | `ρ(Ĝ′_∅) = T + A` | **N1 (b)**: `R` dense in `G′_∅` (cited by name); **N1 (a)**, the inclusion continuous characters `⊆ T + A` — this is the clause the statement names; Bochner on the group `G′_∅` |
| N2, the algebra and the σ-algebra (ll. 130–135) | "`H_S` … closed and translation-invariant … `Π(E_S)` commutes with every `V_y`" | the spectral projection of the Borel set `T + A` | nothing further |
| SI-1 (ll. 145–148) | "`Π = Π(E_S)` … `∫_{R̂∖E_S} χ(u) dσ_{g_k}` … By N2, `Πg_k = h_k(0)`" | `Π(T + A)`, and `R̂ ∖ (T + A)` as a domain of integration | N2 |
| SI-2 (l. 150) | "`P(c(x) = j, p_j(x) = 0) = 0`" | nothing (only `𝒜_S`) | — |
| SI-3 (ll. 153–157) | "`∫_{R̂∖E_S} Re χ(u) dσ_μ = −(4/3) Σ_j E[p_j(0) p_j(u)]`" | `R̂ ∖ (T + A)` | SI-1 |
| SI-4 (ll. 159–162) | "`M(x)` is a function of `p(x)`, which is `𝒜_S`-measurable, and `M(x + y) = M(x) ∘ T_y`" | nothing (only `𝒜_S` and its invariance) | N2 |
| A⁺, proof (ll. 243–247) | "their spectral measures … are carried by `E_S` (N2): `σ_{μ′}` is carried by `T + A + Fin_S`, which T-C(A) … forbids" | `T + A`, twice: N2's ⟹, and T-C(A)'s hypothesis at `S = ∅` | N2; T-C(A) at `S = ∅` (R88-TCA, a separate leaf: § Stage 6) |
| A⁺, remark (i) (l. 248) | "The `E_S` here is T-C(A)'s own, read literally (N1): nothing is transported between topologies" | `T + A` as a set of characters, the same set in T-C(A)'s statement | nothing: at `S = ∅` both statements name the literal set `T + A` |
| A⁺, remark (ii) (ll. 249–250) — the form SP-Cor uses | "`σ_μ` and `E_S` are `U`-invariant, so `u ↦ ∫_{R̂∖E_S} χ(u) dσ_μ` is constant on `U`" | `u·(T + A) = T + A` | N1's "`U`-invariant" at `S = ∅`. Direct: `(u·χ)ⁿ = u·χⁿ`, so `u·T = T`; multiplication by `u` is a linear homeomorphism of `L ⊗ ℝ`, so `u·A = A` |

**The exact check.** `data/fs131/en1/bare_e_check.py` counts, in the line ranges of those lemmas (N2, SI-1, SI-2, SI-3, SI-4, A⁺ and its
remarks), the occurrences of the set written bare — an `E` that is not `E_S` and not an expectation. It finds none, against fifteen `E_S`. With
SP-Cor's lines (321–328) added it finds five: the check can see the union when it is there (control `aplus-names-only-es` below). N1's own
lines hold two (clause (c), "`Haar(E) = 0` for `E = ⋃_S E_S`") and R-U's two.

### 3.2 N1 at `S = ∅`, clause by clause: what A⁺ at `S = ∅` consumes

| clause of N1 (ll. 105–109) | read by A⁺ at `S = ∅`? | where | does its proof at `S = ∅` read a finite split place? |
|---|---|---|---|
| (a) `ρ(Ĝ′_∅) = T + A` = the `τ′_∅`-continuous characters | **yes**, both inclusions | N2 ⟹ and ⟸ | no: "`NR` has finite index" (J28V-7), extension of characters from a closed subgroup, the dual of a product (ll. 110–113) |
| (b) `R` dense in `G′_∅` | **yes, as written**; N2's ⟸ cites it. It is avoidable there (§ 3.3), but T-C(A) at `S = ∅` needs the same density (§ Stage 6, item C1) | N2 ⟸ (l. 129) | no: at `S = ∅` the proof is weak approximation at the archimedean places and "`S¹ − S¹` is the disc of radius 2" (ll. 115–118) |
| (b) `ρ` injective, a `U`-equivariant Borel isomorphism `Ĝ′_S → E_S` (Lusin–Souslin) | **no** | only R-U's proof reads it (l. 282) | — |
| `E_S` σ-compact (hence Borel) | **yes**, at `S = ∅` | every `σ(R̂ ∖ E_∅)` | no |
| `E_S` is `U`-invariant | **yes**, at `S = ∅` | remark (ii) | no |
| (c) `E_S` proper, dense, `Haar(E_S) = 0`; `Haar(E) = 0` | **no** | read only by SI-J (l. 198), hence by SI-5 and the control SI-C, and by nothing A⁺ uses | — |

### 3.3 The converse the entry owes: both inclusions of N1 (a) at `S = ∅`

The statement says the `τ′_∅`-continuous characters are *exactly* `T + A`, and N2 uses each inclusion once, so each gets its line.
*`T + A ⊆` continuous:* a torsion character kills some `NR`, which is `τ′_∅`-open (the preimage of an open subgroup of `R̂_prof`); an
archimedean character is by definition continuous for the topology of `L ⊗ ℝ`; a sum of continuous characters is continuous.
*Continuous `⊆ T + A`:* a `τ′_∅`-continuous character is uniformly continuous, so it extends to the closure `R̄` of `R` in the locally compact
group `G′_∅`, then to `G′_∅` (a character of a closed subgroup extends); a character of `R̂_prof × (L ⊗ ℝ)` is a product `ψ_T ψ_A`; `ψ_T` is
trivial on an open subgroup of the profinite group, so its restriction to `R` kills some `NR` and is torsion; the restriction of `ψ_A` is
archimedean. No density is used in either inclusion: J45's text (ll. 112–113) extends "to the closure of `R` in the LCA group `G′_S`, then to
`G′_S`".

**N2's ⟸ without density** (a remark on the proof, mine, one mind; it changes no verdict). The positive-definite function `σ̂_f`, uniformly
continuous on `(R, τ′_∅)`, extends to a continuous positive-definite function on `R̄`; Bochner on the locally compact abelian group `R̄` gives
`ν` on its dual; restriction `r : (R̄)^ → R̂` is continuous and injective (`R` is dense in `R̄`), `σ_f = r_*ν` by uniqueness of
Fourier–Stieltjes coefficients on `R̂`, and `r((R̄)^)` is the set of `τ′_∅`-continuous characters, which is `T + A` by (a). So N2 at `S = ∅`
needs (a) and not (b). J46's blind proof does it this way (`plans/FS84-SI-V-verification.md` § 2.1 (b): "it extends to a strongly continuous
unitary representation of the lcsc abelian group `R̄`; by SNAG … which lands in `E_S` by (a)"), and its (D), density, is "used only for the
uniqueness of components (J46-1 (c)) in (R-U) and (SP)'s remark" (§ 2.0).

derivation: EN1-APLUS
  statement: nothing in A⁺ at S = ∅ (SI-3, SI-4, N2 at S = ∅) reads E beyond T + A; N2 at S = ∅ does still need N1 (a) at S = ∅ — the characters continuous for the profinite-plus-archimedean topology are exactly T + A.
  uses only: J45's text of N2, SI-1, SI-2, SI-3, SI-4, A⁺ and its remarks (i), (ii) (`plans/FS84-SI-D-derivation.md` ll. 126–135, 145–162,
    240–250), read line by line (§ 3.1); that `E_∅ = T + A` (`Fin_∅ = 0`); for the second clause, that N2's ⟸ ends "carried by `E_S`" only
    through `ρ(Ĝ′_S) = E_S`, which is N1 (a)
  not claimed: that N1 (a) is all of N1 that A⁺ at S = ∅ reads — as written it also reads N1 (b) at S = ∅ (N2's ⟸, l. 129), that `T + A` is Borel
    and that it is `U`-invariant (§ 3.2); anything about T-C(A) at S = ∅, which A⁺ takes as given and whose own proof is walked in § Stage 6;
    A⁺ at any `S ≠ ∅`; that the kernel's `APlus0` is proved
  converse: § 3.3 The converse the entry owes: both inclusions of N1 (a) at `S = ∅`
  argument: § 3.1 The reading
  verdict: derived
  grade: hand
  minds: 1
  model: `F = ℚ(√47)`, `S = ∅`: `G′_∅ = R̂_prof × ℂ²`, `E_∅ = T + A`; J45-SI-C's colouring over ℚ(√11) is a `μ` on which every lemma of the table
    runs (its `𝒜_∅` holds `σ(Φ)`'s torsion eigenfunctions)
  prior art: known: a statement about this project's own proofs; J45 § 5.1 names the inputs, X05V § 2.1 P8 names "A⁺ (only its `S = ∅` instance)"
  handoff: de Bruijn — the planner's leaf 11 (N1 (a) at `S = ∅`) stands; beside it A⁺ at `S = ∅` needs `T + A` Borel and `U`-stable (its leaf 1)
    and, unless N2 is run on the closure of `R`, N1 (b) at `S = ∅`; N1 (c) and the Borel isomorphism of N1 (b) are not needed for A⁺

control: aplus-names-only-es
  of: EN1-APLUS — the first clause, on the lines of N2, SI-1 to SI-4, A⁺ and its remarks: the union `E` is never named
  run: python3 ../data/fs131/en1/bare_e_check.py 126-135 145-148 150-150 153-157 159-162 240-247 248-250
  expect: 0 15
  fault: python3 ../data/fs131/en1/bare_e_check.py 126-135 145-148 150-150 153-157 159-162 240-247 248-250 321-328

Rests on it: EN1-SPCOR (§ Stage 5) and EN1-OFFPATH (§ Stage 6); the planner's leaves 11 and 12.

## Stage 4 — SAVED (EN1-FROM-TWO and EN1-MRPLUS; and what MR⁺ carries)

**Verdicts.** **EN1-FROM-TWO: TRUE** [hand; one mind; a composition] — for every real number field, PE-2(F) and EF_F⁺(F) give MR⁺(F), and
the argument reads neither R-U, nor `E`, nor `Fin_S`, nor any Haar-null clause. **EN1-MRPLUS: TRUE in the scope row 120 already carries** —
for every real number field `F` with `R_F = O′` (no stable dyadic place ramified in `F(i)/F`), with "finite measure" read as finite positive
measure; at row 100's exception fields (ℚ(√5), ℚ(√17), ℚ(α)) it is a GAP exactly where MR is, at EF_F⁺'s model of the dual. The class of rows
121 and 123 (`L(F) ≥ 5`) lies inside `R = O′` (FS100-EXC), so the scope costs the path nothing.

### 4.1 The argument

Let `τ` be a finite positive Borel measure on `R̂`, invariant under every `u ∈ U`, with `τ(T + A) = 0`.

1. *PE-2* (FS100-PE2): `τ = a·m + τ′`, `a ≥ 0`, `τ′` a finite positive `U`-invariant measure with `h_{τ′}(u) = 0` for every `u ∈ U`.
2. `a·m ≥ 0`, so `τ′ ≤ τ` on every Borel set; `T + A` is Borel (σ-compact); so `τ′(T + A) ≤ τ(T + A) = 0`.
3. `U` holds a non-torsion element: `(3 + 4i)/5 ∈ U_ℚ ⊆ U_F`, and the roots of unity of `ℚ(i)` are `±1, ±i`. By 1 its entropy for `τ′` is 0, so
   *EF_F⁺* (FS100-EFP) gives `τ′(R̂ ∖ (T + A)) = 0`.
4. `τ′(R̂) = τ′(T + A) + τ′(R̂ ∖ (T + A)) = 0`, so `τ′ = 0` and `τ = a·m`.
5. For `r ≠ 0` in `R`, `χ ↦ χ(r)` is a non-trivial character of the compact group `R̂`, so `∫ χ(r) dm = 0`; hence `∫ χ(r) dτ = 0`. ∎

**Against the record.** These are FS100-MR (a)'s three lines — "`τ = a·m + τ′`, `τ′ ≤ τ` carried by `T + A ⊆ E`, `τ(E) = 0`, so `τ′ = 0`"
(`plans/FS100-derivation.md` l. 201) — with "`τ(E) = 0`" used only as "`τ(T + A) = 0`"; the entry itself says "MR uses neither R-U nor
`m(E) = 0`", X01D § 4.1 "(`m(E) = 0` is not needed.)", and the plan's ladder, link L3, "MR does not need R-U … nor `m(E) = 0`". And they are the
kernel proof's lines 198–209: `hTAc` is step 3, `hE'` with `measure_mono_null I.TA_subset_E` is step 2, `hzero` step 4, `hHF` step 5. The
clause `hHE` is bound at l. 198 and occurs nowhere else (control `node-m-never-uses-haar-null`).

**What "alone" leaves standing** (none of it a hand result of ours beyond the two named):
- *The scope of EF_F⁺.* Its three derivations model the dual as `W/Λ`, which needs `R = O′` (FS100-EFP, "Scope"); PE-2 needs no such thing
  ("No `R = O′`", the ladder's L1). So MR⁺(F) is derived exactly where EF_F⁺(F) is.
- *One set under two descriptions.* EF_F⁺'s proofs name `T + A` inside their model — "`T = L/R^∨`, `A` = image of `L_∞`" (X01D § 2.0), "so
  `x ∈ T + A` iff a lift has its finite part in the diagonal `L`" (FS105-B-M1) — while A⁺ reads `T + A` as the continuity group of `τ′_∅`
  (N1 (a)). Both describe the literal set of torsion-plus-archimedean characters; the first identification is a step of EF_F⁺'s proof (its
  § 2.0), the second is N1 (a) at `S = ∅`. A formal MR⁺ must carry one definition of `T + A` through both.
- *A point for the kernel lane, not a ruling on its statements.* The Haar-null clause is unused by the proof of node M, but it is a conjunct of
  the hypothesis `Interface.PE2` as that `Prop` stands (l. 179, "`τH I.E = 0`"). So "`Haar(E) = 0` is off the path" is true of the mathematics
  and of a PE-2 stated without the clause; to discharge the present `Prop` at `E := T + A` one would still prove `m(T + A) = 0`, which is N1 (c)
  at `S = ∅`.

### 4.2 The readings of "finite measure"

For positive measures the sentence is § 4.1's. For a signed or complex `τ` with `|τ|(T + A) = 0` it follows from the positive case (the Jordan
parts of `Re τ` and `Im τ` are `U`-invariant, by uniqueness of the decomposition, and null on `T + A`). Under the literal value reading —
`τ` signed, `τ(T + A) = 0` — it is **false** over every real number field: `ν = λ_r − λ_{r′}`, the difference of two of FS100-EFX's circle
measures, is `U`-invariant, has `ν(T + A) = 1 − 1 = 0`, and `∫ χ(1) dν = J₀(2πr) − J₀(2πr′)`, which is `0.776243` at `r = 1/4`, `r′ = 1/2`
(control `signed-reading-fails`). This is J45's own caution (§ 4.2, "Readings") moved from `E` to `T + A`.

### 4.3 What MR⁺ carries: MR and R-U in one sentence

The recognition predicted it (§ 2.3 item 2). *MR⁺(F) ⟹ MR(F)*: `τ(E) = 0` gives `τ(T + A) = 0`. *MR⁺(F) ⟹ R-U(F), given `m(E) = 0`*: for a
finite positive `U`-invariant `ν`, the restriction `ν|_{R̂∖(T+A)}` is `U`-invariant and null on `T + A`, so it is `a·m` (MR⁺ and Fourier
uniqueness), and `ν(E ∖ (T + A)) = a·m(E ∖ (T + A)) ≤ a·m(E) = 0`. *MR(F) ∧ R-U(F) ⟹ MR⁺(F)*: if `τ(T + A) = 0`, R-U gives
`τ(E ∖ (T + A)) = 0`, so `τ(E) = 0` and MR applies. So MR⁺ is not a lighter sentence than MR: it is MR with R-U folded in. It follows a second
way from two held results, row 120 and J45-RU, with no re-reading of EF_F⁺ — a check on its truth, not a route for the kernel, since that route
is the one that reads R-U.

derivation: EN1-FROM-TWO
  statement: MR⁺(F) follows from PE-2 and EF_F⁺ alone: EF_F⁺'s conclusion is already about T + A (a zero-entropy invariant measure is carried by T + A), so for an invariant τ null on T + A, τ = a·m + τ′ (PE-2), τ′ ≤ τ is null on T + A and, by EF_F⁺, null off it, so τ′ = 0.
  uses only: PE-2's decomposition with `a ≥ 0` and `τ′ ≥ 0` (so `τ′ ≤ τ`); EF_F⁺'s conclusion `τ′(R̂ ∖ (T + A)) = 0` at one non-torsion element of
    zero entropy; that `(3 + 4i)/5 ∈ U_F` is not torsion; that `T + A` is Borel; that Haar measure's Fourier coefficients vanish off 0
  not claimed: PE-2 or EF_F⁺ themselves (FS100-PE2 over `[EinsiedlerLindenstrauss2022]` Thm 1.2, external; FS100-EFP, which needs `R = O′`); that
    the kernel's `Interface.PE2` can be discharged at `E := T + A` without `m(T + A) = 0` — that `Prop` carries the Haar-null clause as a conjunct
    (§ 4.1); that the measure may be signed with only `τ(T + A) = 0`
  argument: § 4.1 The argument
  verdict: derived
  grade: hand
  minds: 1
  model: `τ = m`, Haar probability: `U`-invariant, `m(T + A) = 0` (J45-N1 (c) at `S = ∅` — used for this model only), `a = 1`, `τ′ = 0`; and
    `τ = 0`. A measure the hypothesis excludes: FS100-EFX's circle measure, carried by `A`, with coefficient `J₀(2πρ)` at 1
  prior art: known: FS100-MR (a) (`plans/FS100-derivation.md` l. 201) with `τ(E) = 0` read as `τ(T + A) = 0`; the kernel's `Interface.mr_of_pe2_efPlus`
  handoff: de Bruijn — the planner's leaf 22 as it stands: node M at `E := T + A`, from leaves 20 and 21

control: node-m-never-uses-haar-null
  of: EN1-FROM-TWO — the kernel proof it was read from: in `Interface.mr_of_pe2_efPlus` the Haar-null clause is bound and used nowhere
  run: python3 ../data/fs131/en1/unused_check.py Interface.mr_of_pe2_efPlus hHE
  expect: 1
  fault: python3 ../data/fs131/en1/unused_check.py Interface.mr_of_pe2_efPlus hHF

derivation: EN1-MRPLUS
  statement: MR⁺(F): every finite rotation-invariant measure on the dual of ℤ[U_F] that gives T + A measure 0 has every Fourier coefficient off 0 equal to 0.
  uses only: EN1-FROM-TWO; FS100-PE2 (every real number field) and FS100-EFP (every real number field with `R = O′`) at their grades
  not claimed: MR⁺(F) at a field with a stable dyadic place ramified in `F(i)/F` (ℚ(√5), ℚ(√17), ℚ(α)) — a GAP at EF_F⁺'s model of the dual, as for
    MR (row 120); the signed reading with only `τ(T + A) = 0`, which is false (§ 4.2); that it is new — it is row 120 and J45-RU in one sentence
    (§ 4.3); that the kernel states it
  argument: § 4.1 The argument
  verdict: derived
  grade: derived from: EN1-FROM-TWO
  minds: 1
  model: `F = ℚ(√47)`: its dyadic place splits in `F(i)` (`47 ≡ 7 mod 8`), so `R = O′`; `τ = m` satisfies the hypothesis and the conclusion
  prior art: known: row 120 (MR(F)) with J45-RU; `[OAIMath2026]` Thm 2.3 is the nearest in print and is for the algebraic plane, not a number field (row 120's cell)
  handoff: de Bruijn — the one closed sentence of the planner's leaf 2, for `F` with `R_F = O′`, with "measure" a positive measure

control: signed-reading-fails
  of: EN1-MRPLUS — the not-claimed line: a signed measure with value 0 on `T + A` and a non-zero coefficient at 1
  run: python3 ../data/fs131/en1/j0_check.py 0.25 0.5
  expect: 0.776243
  fault: python3 ../data/fs131/en1/j0_check.py 0.25 0.25

derivation: EN1-EQUIV
  statement: for a real number field F, given Haar(E) = 0, MR⁺(F) holds if and only if MR(F) and R-U(F) both hold.
  uses only: `T + A ⊆ E`; that `T + A` is Borel and `U`-invariant; Fourier uniqueness on `R̂` (a measure whose coefficients vanish off 0 is a
    Haar multiple); `m(E) = 0` in the direction MR⁺ ⟹ R-U only
  not claimed: that either side holds at row 100's exception fields; the direction MR⁺ ⟹ R-U without `m(E) = 0`
  converse: § 4.3 What MR⁺ carries: MR and R-U in one sentence
  argument: § 4.3 What MR⁺ carries: MR and R-U in one sentence
  verdict: derived
  grade: hand
  minds: 1
  model: `F = ℚ(√47)`, where all three sentences are held (row 120; J45-RU; EN1-MRPLUS)
  prior art: known: X12B § 2.1's remark after X12B-E ("for invariant measures 'carried by `E`' and 'carried by `T + A`' are the same statement"); FS100-MR (c)
  handoff: none — a relay-result for EN1-OFFPATH and the report: it says what leaves the path is R-U's separate proof, not R-U's content

Rests on these: EN1-SPCOR and EN1-OFFPATH; the planner's leaves 2 and 22.

## Stage 5 — SAVED (EN1-SPCOR: SP-Cor run at `T + A`)

**Verdict: TRUE** [hand; one mind; a re-derivation of J45's corollary with `T + A` in the place of `E`]. Of this project's hand results the
proof reads MR⁺(F) and A⁺ at `S = ∅` and no other; R-U has nothing left to say. "Needs only" is true among our hand results, not among all
inputs: the two classical theorems stay, and so do two facts about the set `T + A`.

### 5.1 The proof at `T + A`

Suppose `F²` has a proper four-colouring. (P0) Restricted to `R ⊂ L ≅ F²` it is a proper four-colouring of `Cay(R, U)`, so `X₄(F) ≠ ∅`.
(P1) `X₄(F)` is a non-empty compact set of `{0,1,2,3}^R` (`R` countable), invariant under the countable solvable group `R ⋊ U` acting by
`c ↦ c(v· + y)`; an invariant Borel probability `μ` on it exists (Markov–Kakutani). (P2) `C(y) = E_μ⟨g(0), g(y)⟩` is positive definite on the
discrete group `R`; Bochner gives the finite positive `σ = σ_μ` on `R̂` with `σ̂ = C`; `C(vy) = C(y)` for `v ∈ U`, and uniqueness of
Fourier–Stieltjes coefficients makes `σ` `U`-invariant. (P3) `T + A` is Borel and `U`-invariant (§ 3.2), so `τ := σ|_{R̂∖(T+A)}` is finite,
positive, `U`-invariant and null on `T + A`. (P4) MR⁺(F): `∫ χ(1) dτ = 0`, since `1 ≠ 0` in `R`; that is, `∫_{R̂∖(T+A)} Re χ(1) dσ_μ = 0`.
(P5) A⁺ at `S = ∅`, remark (ii): `∫_{R̂∖E_∅} Re χ(1) dσ_μ < 0`, and `E_∅ = T + A`. Contradiction; so `χ(F²) ≥ 5`. ∎

**Where R-U was, and why it is gone.** J45's proof (`plans/FS84-SI-D-derivation.md` ll. 323–326) takes `τ := σ_μ|_{R̂∖E}` because the measure
statement it was given is null on `E`, and then needs "R-U gives `σ_μ(E ∖ (T + A)) = 0`" to turn A⁺'s integral over `R̂ ∖ E_∅` into one over
`R̂ ∖ E`. X05V's blind re-derivation has the same two steps (P4 "`σ(E ∖ (T + A)) = 0` — R-U", P7 "P4 + P6"), and so does the kernel proof:
`hRU` is bound and used once, at l. 544, for `hnull : σ (I.E \ I.TA) = 0` (control `spcor-reads-ru-once`). With the measure statement null on
`T + A` the domain is `R̂ ∖ (T + A)` from the start, and at `E := T + A` the kernel's `RU` reads `τ(TA ∖ TA) = τ(∅) = 0`.

**What the proof still reads, beyond the two named hand results.**

| input | kind | where |
|---|---|---|
| an `R ⋊ U`-invariant probability on a non-empty closed invariant set of colourings | classical (Markov–Kakutani; the kernel's `InvariantMeasureOnClosed`) | P1 |
| Herglotz–Bochner on the discrete `R`, with uniqueness | classical (the kernel's `BochnerHerglotz`) | P2 |
| `R` countable | elementary (kernel: `countable_unitRing`) | P1 |
| `T + A` Borel; `u·(T + A) = T + A` | N1 at `S = ∅`, two of its clauses (§ 3.2) | P3 |
| `T + A` in MR⁺ and `T + A` in A⁺ are one set | § 4.1, "one set under two descriptions" | P4 against P5 |
| T-C(A) at `S = ∅` | ours; A⁺ at `S = ∅` is "given T-C(A)" (R88-TCA; FS100-TCA in every degree) | inside P5 |

Not read: R-U; `E`; `Fin_S`; N1 (b)'s Borel isomorphism; N1 (c); `m(E) = 0` (X05V's P3 lists "`m(E) = 0` (N1)" among `E`'s properties and
no later step of its P4–P8 uses it).

derivation: EN1-SPCOR
  statement: SP-Cor at S = ∅ needs only MR⁺(F) and A⁺ at S = ∅; run at E := T + A, the hypothesis R-U is τ(∅) = 0.
  uses only: MR⁺(F) applied once, to `σ_μ|_{R̂∖(T+A)}`; A⁺ at `S = ∅` in the form of its remark (ii), at `u = 1`; Markov–Kakutani for `R ⋊ U`;
    Herglotz–Bochner with uniqueness on the discrete `R`; `R` countable; `T + A` Borel and `U`-invariant
  not claimed: that no input but the two is read — "only" holds among this project's hand results (the table above lists the rest); A⁺ at `S = ∅`
    itself, which is given T-C(A) at `S = ∅`; SP-Cor's converse; anything at `S ≠ ∅`, where A⁺ needs T-C(A) at that `S` and the set is `E_S`
  argument: § 5.1 The proof at `T + A`
  verdict: derived
  grade: hand
  minds: 1
  model: `F = ℚ(√11)` for the hypotheses that can hold with `X₄ ≠ ∅`: C9's colouring gives a `μ` and a `σ_μ` carried by `T + A`, so
    `τ = 0` and P4 holds with both sides 0; the chain stops at P5, because A⁺ fails there (T-C(A)'s class excludes ℚ(√11): X01D § 4.2's control)
  prior art: known: J45-SP-Cor (`plans/FS84-SI-D-derivation.md` § 4.2) with `E` replaced by `T + A`; X05V § 2.1 P0–P8; the kernel's `Interface.x4_eq_empty`
  handoff: de Bruijn — the planner's leaf 2: an instance of `Interface.x4_eq_empty` at `E := TA := T + A`, whose `hRU` is `τ(∅) = 0`; it needs
    its leaf 1 (`T + A` measurable and rotation-stable) and nothing of J45-RU

control: spcor-reads-ru-once
  of: EN1-SPCOR — the kernel proof it was read from: `Interface.x4_eq_empty` binds `hRU` and uses it once (l. 544)
  run: python3 ../data/fs131/en1/unused_check.py Interface.x4_eq_empty hRU
  expect: 2
  fault: python3 ../data/fs131/en1/unused_check.py Interface.x4_eq_empty hHE

Rests on it: EN1-OFFPATH; the planner's leaf 2.
