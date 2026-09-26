*Derivation record of crunch job **X23D** (wave 3), de Bruijn, Opus 5.5, 2026-09-26. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X23D-spcor-every-field-derivation.md`, with `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` as part of
it; stop time 12:30 UTC. No subagents; no finite-witness search (ban to 2026-10-01). I touch only this file, `data/fs100/x23d/` and
`tools/x23d_*.py`. A blind verifier (X23V) works the same list; I have not contacted it.*

## Theorems this phase proved

*(filled at each stage)*

## Stage 1 — SAVED (the claims, quotation check, C0)

### 1.1 The claims, copied verbatim

From `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, first paragraph after Kooshi's words (verbatim):

> **Where waves 1–2 left MR** (from the reports, `data/crunch-2026-09-26-x2x3/reports/`): EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
> by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
> X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number
> field at [hand] grade, with the scope of row 100's exception** (a ramified stable dyadic place, where `R = O′` is not proved; X09C's audit).
> Every claim below is stated with that scope and asks whether its field is outside the exception. **"Given MR"** below means: given MR(F) at
> the grade and scope just described; each job names it as an input and does not re-derive it.

List X23 (same file, §7, verbatim):

> Inputs quoted verbatim: row 117 (quoted in list X21); SP-Cor and A⁺ at `S = ∅` (`plans/FS84-SI-D-derivation.md` §4.2, §5.4); X05V's re-derivation
> P0–P8 (`plans/FS100-X05V-verification.md` §2.1); J48-N4cor (quoted in list X21).
>
> - **SPC(F)** (SP-Cor for every real number field; the advisor's F1 (a)). "For every real number field `F` outside row 100's exception: if T-C(A)
>   holds at `S = ∅` (every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`), then J45's A⁺ and SP-Cor hold with J45's
>   proofs, and, given MR, `χ(F²) ≥ 5`." **Named risk (the advisor):** A⁺'s archimedean step when `F` has `n = [F:ℚ] > 2` real places. X03D's
>   `Λ = 0.4028 > 1/3` shows that first moments alone cannot do it; J45 did it at `n = 2`.
> - **CLS(F)** (the class; the advisor's F1 (b)). "For every real number field `F` outside row 100's exception: T-C(A) holds at `S = ∅` iff
>   `L(F) ≥ 5`." **Named risks (the advisor):** `q = 27`; the dyadic `U_Q` for `Q ≥ 64`; ramified stable places; the archimedean part at `n`
>   places.
> - **COR.** "SPC and CLS together give `χ(F²) ≥ min(L(F), 5)` for every real number field outside row 100's exception."
> - **CTL** (controls; each must come out as stated, and each can fail). "T-C(A) at `S = ∅` fails at K = ℚ(√3,√11), ℚ(√2,√3), ℚ(√11) and ℚ(√23),
>   where `L ≤ 4`. At ℚ(√47) it holds."
> - **Q35.** "ℚ(√3,√5) lies outside row 100's exception. Its stable places are exactly those above 11, 59 and the other primes of residue
>   degree one in `L/ℚ(√3,√5)` that are inert in `L/F`; 3, 7, 19, 23, 31, 43 and 47 are not stable; and T-C(A) holds there at `S = ∅`. Hence,
>   given MR and SPC, `χ(ℚ(√3,√5)²) = 5`." (The advisor's F4; its Legendre-symbol list is one mind. An exact check of seconds is in.)
> - **D-1** (the J48 route, kept). "Given MR, for every totally real number field `F` outside row 100's exception with `N₄(F) = ∅`: `χ(F²) ≥ 5`."

Quoted inputs (from list X21, verbatim): row 117 — "For `ℚ(√d)` real quadratic: every stable place of `ℚ(√d, i)` has all-levels four-colour
ratio `< 1/4` ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`; and over every real number field where T-C(A) holds at `S = ∅`, J45's A⁺ and
SP-Cor hold with J45's proofs — so MR(F) ⟹ `χ(F²) ≥ 5` at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47)."; J48-N4cor — "For every totally real `F`
with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`".

The brief's addendum (06:24, the advisor): "If a claim holds for totally real `F` and fails or is ill-posed with a complex place, record both
verdicts." and "The job must name every step of J45 that uses [F:ℚ] = 2."

### 1.2 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | §7's first paragraph and list X23 | `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, ll. 249–254 and 306–327 | copied above from the file itself (no retyping) |
| Q2 | row 117 (in list X21) | `LEDGER.md` row 117 | the ⟺ sentence found byte-identical (`grep -cF` = 1) |
| Q3 | K0 (in list X21), "J45's A⁺ and SP-Cor hold, with the same proofs, over every …" | `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md` | found (`grep -cF` = 1) |
| Q4 | J48-N4cor | `plans/STUB-measure-rigidity-three-fields.md` l. 184–185 | agrees verbatim ("For every totally real `F` with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`") |
| Q5 | addendum: "SP-Cor(F) holds with J45's proofs over every totally real F in T-C(A)'s class. The job must name every step of J45 that uses [F:ℚ] = 2." | advisor record `plans/POROS-2026-09-26-x2x3-crunch.md` l. 450–451: "**D-6** (SP-Cor with J45's proofs over every totally real `F` in the class, naming each step that uses degree 2)" | **not verbatim** in the advisor's record (a paraphrase in the brief); agrees in substance |
| Q6 | addendum: "the stable odd places of ℚ(√3,√5) below 200 are 11, 59, 71, 131, 179, 191; 7, 19, 23, 31, 43, 47 have residue degree 2 …" | advisor record l. 415–418 (F4): "Below 200 the stable odd places are **11, 59, 71, 131, 179, 191**. The primes 7, 19, 23, 31, 43, 47 are **not** stable, since their residue degree is 2. 3 has residue field `𝔽₉`, and no dyadic place is stable, since 15 ≡ 7 mod 8." | **not verbatim** (a paraphrase); agrees in substance |
| Q7 | Q35's phrase "the other primes of residue degree one in `L/ℚ(√3,√5)` that are inert in `L/F`" | the claim itself | **internally inconsistent as worded**: a place inert in `L/F` has residue degree 2 in `L/F`, not 1. I read it as "primes of residue degree one in `F/ℚ` … inert in `L/F`" (which is the advisor's F4 list) and score it under that reading, noting the wording |

### 1.3 Notation (fixed here)

`F ⊆ ℝ` a number field with `r₁ ≥ 1` real and `r₂` complex places, `n = [F:ℚ] = r₁ + 2r₂`; `L = F(i)`; a place `v` of `F` is **stable** iff it
does not split in `L/F`; `𝕋` the norm-one torus of `L/F`; `U = 𝕋(F)`; `R = ℤ[U]`; `E_S = T + A + Fin_S` as J45 N1. **T-C(A)@∅ (class form)**:
every stable place has all-levels four-colour ratio `r_v := sup_m α(G_{v,m})/|G_{v,m}| < 1/4`. **R88-TCA@∅ (spectral form)**: no
translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A`. **H*-place** (J28D; J48's "4-thick"): every non-trivial
character of every level has normalised eigenvalue `> −1/3`.

### 1.4 C0 — probabilities per claim (written after reading the sources and one mental pass, before any written derivation)

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| CTL | 0.90 | 0.05 | 0.05 | each control is a few Legendre symbols plus row 67's dyadic tightness |
| CLS (totally real) | 0.70 | 0.10 | 0.20 | risk: `q = 27` (Weil does not reach 1/4 there: `2√27/(28+2√27) = 0.271`) |
| CLS (with complex places) | 0.70 | 0.10 | 0.20 | CLS reads only finite places; same risks |
| SPC (totally real) | 0.80 | 0.02 | 0.18 | the mental pass says the count uses `m₁` per real place and C14.3's max over factors, not first moments; risk: a hidden degree-2 step in R88-TCA's route |
| SPC (with complex places) | 0.50 | 0.05 | 0.45 | the complex place's archimedean factor is a hyperbola, not a circle |
| COR | 0.65 | 0.05 | 0.30 | the conjunction; plus MR's own scope at complex places (waves 1–2) |
| Q35 | 0.80 | 0.05 | 0.15 | exact Legendre symbols; the field has no stable 23, 27, 31 |
| D-1 | 0.85 | 0.02 | 0.13 | `N₄ = ∅` is a sub-case of the class |

### 1.5 Would-have-searched-here log (running)

- (stage 1) none.
