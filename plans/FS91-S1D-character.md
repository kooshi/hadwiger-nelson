# FS-91 crunch job J07 — the character local–global theorem (derivation record)

*Crunch milestone M1 (FS-91), job J07, de Bruijn (Opus 5.5), 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J07-M1-character-local-global.md`
with `STANDING-RULES.md`, and the owner's launch message (news: J03a TRUE at every `k`; `A(R_F)` corrected; J02's theorems verified by J09).
Grades are `CLAUDE.md` § Notation's. Every statement here is about **characters** (colourings `x ↦ ⌊kθ(x)⌋`), never about `χ`: from four
colours up emptiness of `Θ_k` is one-sided (G71). Fenced from me by rule: J10's record. Not opened by choice: J09's proof of its J2 (see
Stage 2, Lemma C′, independence note).*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| # | quotation (brief or owner's message) | source | result |
|---|---|---|---|
| Q1 | CLG_k, "Let `k ≥ 3` satisfy `H_k`, … is `k`-colourable." | `plans/FS91-character-local-global.md` §S | **verbatim** (grep, one hit) |
| Q2 | the converged form "`κ(R_F, U_F) = max over stable places 𝔓 of κ(O_𝔓, S_𝔓)`, under `H_β` for the `β` in question." | same, §M.1 | **verbatim** (the source's sentence begins "CLG in its converged form:", which the brief omits) |
| Q3 | CLG-a to CLG-g | same, §S, "J07 — the class theorem" | read there, verbatim; used from the source, not the brief |
| Q4 | Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` Frontier item 23; `STANDING-RULES.md` rule 4 | **verbatim** |
| Q5 | the brief's unquoted "FS-89 proved (row 95) that at four and five colours every band character is a torsion character plus an archimedean one" | `LEDGER.md` row 95 | **agrees**, with the scope row 95 states: on `Q`, then "by the gluing the same holds for every real field (`Θ₄(R_F) ⊆ T₁₆₈ + A`, `Θ₅(R_F) ⊆ T + A`)" |
| Q6 | the brief's hypothesis line ("`H_k` … at every `k` … given J01-7, one reader") | superseded by the owner's message: J03a TRUE, `plans/FS91-S0V2-SWm-second-reading.md` §3.6 | **checked**: J03a-7, J03a-8 read there: `Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)` for every `F ⊆ ℝ`, every `k ≥ 2`, `N_k` finite, non-effective |
| Q7 | the owner: "Over R_F the archimedean part is A(R_F) = Hom_ℚ(F(i), ℝ) mod 1 … With the one-embedding reading, FS89-CL2 is FALSE" | J03a record §3.4 (J03a-9); FS89-S0A §C1 "Conventions" | **agrees**; S0A's own convention was the wide one from the start ("`A(X)` … `ℓ ∈ Hom_ℚ(L, ℝ)`") |
| Q8 | the owner: J02-T2, T3, C1 verified by J09; J09's J2 and J4 one mind | `plans/FS91-S0FV-three-colours-blind.md` (headings only read) | **agrees** as to what J09 filed; J2's heading (read while grepping for this check, **after** Lemma C′ below was derived in my working notes) is "the unit-vector ring is the stable-integral ring at every prime with no ramified stable place [hand, one mind]". Its proof was not opened |
| Q9 | reading list: S0A-2/3/4/7/8/9, CL2–CL5; J02-L2, L3, T1, §2.8; FS86-B1-LR, LP, dB-Sv; rows 88, 89, 94–96 | the named files | all exist and were read; `plans/PA-tardif2023.md` §5.2–5.3 **not read** — the brief makes it the fallback "only if the peeling route fails", and it did not |

No brief slip found. One ambiguity logged: CLG-c's "the image of `U_F` in `R_F/NR_F` is the product, over the stable places `𝔓 | N`, of
the images of the local norm-one groups" presumes `R_F/NR_F` splits over places; it does not at a ramified stable dyadic place (FS86-CL2's
diagonal). Stage 2 states the form that is true in general.

### 1.2 C0 — probabilities

*Honest timing: written after the reading and after an unwritten first sketch of the route (the peeling plus weak approximation), before
any step below was written down or checked. Not a blind prior.*

| statement | probability TRUE |
|---|---|
| CLG_k at `k ≤ 9`, totally real `F` in Lemma R's scope | 0.90 |
| CLG_k at every `k`, every real number field (given the owner's ruling that `H_k` holds at every `k`) | 0.75 |
| CLG-c without Lemma R's scope (some true form; the literal "product" form may need the ramified-dyadic exception) | 0.75 |
| CLG-d for fields with complex places | 0.85 |
| CLG-e as stated (level one when `p > k/2`), odd `p` | 0.90; dyadic: 0.6 |
| CLG-g with an explicit exception | 0.80; that the exception is empty at `k ≤ 5`: 0.6 |
| CL3, CL4, CL5 survive under the corrected `A(R_F)` | 0.85 each |

### 1.3 Would-have-searched-here log

- (stage 1) Would have sampled random band characters of `ℤ[i]/3^m` to see whether level collapse fails at band 1/6; instead derived the
  level bound (Stage 3) and checked it on the complete, derivation-fixed character list (Stage 4).
