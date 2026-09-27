# FS105-W — the degree-16 walk of MR, and row 129's finite-graph test

*Job FS105-W (de Bruijn, Opus 5.5), 2026-09-26, from `data/fs105/briefs/W105-walker.md` and `data/fs105/briefs/STANDING-RULES.md`. Not blind:
MR's records are open to this job. Claims (c) and (d) of `data/fs105/claims.md`. Working files: `data/fs105/fs105-w/`; exact checks:
`tools/fs105_w_*.py`. A walk of written proofs is a **checking reading**, not a blind mind; every verdict below is graded so.*

## Theorems this phase proved

- **FS105-W-S (the setting at de Grey's field)** — `F_dG = ℚ(√3,√5,√7,√11)` is totally real of degree 16; `L = F_dG(i)` has degree 32 and
  sixteen complex places; every prime of `F_dG` above 2 (four of them, `e = f = 2`) splits in `L` (eight primes, `e = f = 2`), so there is no
  stable dyadic place and `R = O′` (row 100); the least prime totally split in `L` is **421**; `μ(L) = μ₁₂`. [tools exact, PARI; one mind]
  `tools/fs105_w_setting.py` S1–S5, S8; §Stage 1.
- **FS105-W-LW (Lemma W, explicit at `F_dG`)** — `z = √3+√5+√7+√11+21i+1` has `v₄₂₁(N_{L/ℚ} z) = 1`; `w = z/c(z) ∈ U` and
  `Γ = ⟨(3+4i)/5, w⟩ ≅ ℤ²` is admissible: every non-trivial element of `Gal(L/ℚ)` moves the 421-part of `div(w)`, so no non-zero power of `w`
  lies in a proper subfield of `L`. Control: `⟨(3+4i)/5, (5+12i)/13⟩` generates only `ℚ(i)` — not admissible. [tools exact + hand (the
  divisor argument); one mind] `tools/fs105_w_setting.py` S6; §Stage 1.
- **FS105-W-H (the height normalisation)** — for `q = (a+bi)/c ∈ U_ℚ`, `H_L(q) = c¹⁶ = c^{[F_dG:ℚ]}` exactly (normalised absolute values on
  `L`), checked at ten primitive triples; so `#{q ∈ U_ℚ : H_L(q) ≤ M} = #{q ∈ U_ℚ : den q ≤ M^{1/16}}`. [tools exact; one mind]
  `tools/fs105_w_setting.py` S7; §Stage 1.

- **FS105-W-G (EF_F⁺'s growth at degree `n`)** — X01D's zero-entropy argument needs exactly `liminf_M log #V_M / log M > 0` (polynomial
  growth of the multipliers in `H_L`); its exponents are degree-free (`K > 9`), the degree entering only the constants `(4ε)^{2n}`,
  `(16ε)^{2n}`, `2^{2n}` and the choice `β < 1/(nK)`; `U_ℚ` supplies `#V_M = (4/π + o(1))M^{1/n}`, so at `n = 16` (`K = 16`, `β = 1/512`)
  the pigeonhole exponent is `1/16 − 1/32 = 1/32 > 0`. [hand (a checking reading of X01D §3 and X12B §2, not blind) + tools exact (G1–G3);
  one mind] §Stage 2.
- **FS105-W-C (C-MR16's zero-entropy half)** — EF_F⁺ holds at `F_dG` by X01D's and X12B's proofs, every step walked at `[L:ℚ] = 32`;
  no step fails. [checking reading, one mind, not blind; adds a reading, not a derivation] §Stage 2.

- **FS105-W-PE (C-MR16's positive-entropy half)** — PE-2 at `F_dG`: every hypothesis of EL2021 Thm 1.2's statement holds for `(M̂, ⟨u, w⟩)` at
  degree 32 (solenoid of dimension 32; action; total irreducibility ⟺ admissibility, two routes; not virtually cyclic, no non-trivial
  virtually cyclic factor; `d = 2`; ergodicity for all of `ℤ²`; one entropy notion); admissibility excluded against all 373 proper subfields of
  `L` by two exact routes (S6 divisors; A1 `(τ(w)/w)¹² ≠ 1` for all 31 `τ ≠ 1`). [checking reading of X02D, X02V, one mind, not blind; tools
  exact; EL2021 Thm 1.2 by statement] §Stage 3.
- **FS105-W-MR16 (C-MR16)** — MR(`F_dG`) holds by row 120's proof, every step walked at `[F:ℚ] = 16`; no step fails; the degree enters
  constants only. [checking reading, one mind, not blind; given EL2021 Thm 1.2 by statement] §Stage 3.2.

- **FS105-W-D1 (row 129's chain)** — MR(`ℚ(√635087)`) ⟹ `α₁(ℝ²) = m₁(ℝ²)` through `α₁(ℝ²) ≤ α₁(F₁²) ≤ α_inv(F₁²) ≤ α_loc(F₁) = m₁ ≤ α₁(ℝ²)`,
  every direction named; the only MR-carrying link is FRAC; the killing test uses only B-AMEN's Følner half (two blind derivations), not its
  one-mind reverse half, and not B-CHIF. [checking reading, one mind, not blind] §Stage 4.1.
- **FS105-W-D2 (what a refutation needs)** — with the best proved bounds (`m₁ ≤ 0.24699…`, `[AmbrusEtAl2023]`; `α₁ < 1/4.0007`,
  `[DuczVarga2026]`), a proof of `α₁(ℝ²) > m₁(ℝ²)` must be (W) a uniform bound `α(G) ≥ c|G|`, `c ∈ (0.24699…, 0.249956…)`, for every finite
  unit-distance graph (equivalently `sup_G χ_f(G) < 4.04876`), or (W′) `χ_f,0(ℝ²) < χ_f(ℝ²)` (with B-CHIF) — MRVZ's open question answered
  "strict"; neither implies the other. [derived from held papers, one mind] §Stage 4.2.

## Stage 1 — SAVED (quotation check; the setting at `F_dG`; C0)

### 1.1 Quotation check (standing rule 5)

Every quotation in `data/fs105/claims.md` §0, (c), (d), and in my brief, against its source on disk:

| quotation | source | result |
|---|---|---|
| §0 Notation, "`F ⊆ ℝ` a real number field, … — `LEDGER.md` rows 98, 113." | `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md` lines 18–20; `plans/FS100-X02D-derivation.md` lines 9–11 | **verbatim** |
| §0 "Added there: … `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`" | X02D lines 11–13 | **verbatim, truncated**: the source continues "; for `u ∈ U`, `H(u) = ∏_w max(1, \|u\|_w)` over the finite places `w` of `L` (normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`." — the cut drops the definition of `H` that (c)'s count uses; I restore it at stage 2 (§2.0). No meaning changed |
| §0 MR, "for every real number field `F` with `R_F = O′` … (MR(F))." | `LEDGER.md` row 120 | **verbatim** |
| §0 its two halves; its "Not claimed" | row 120 | **verbatim** |
| §0 G43, "his coordinates span K(√5,√7) (ℚ-span rank **16 of 16**" | `CLAUDE.md` G43 | **verbatim** (the source continues "over `tools/degrey_cert.json`") |
| (c) C-MR16, "**C-MR16** — MR at de Grey's field walked at degree 16 (PE-2's admissibility; EF_F⁺'s count `c·M^{1/16}`), unreached by both FS-103 verifiers" | `plans/STUB-harden-mr.md` line 4 | **verbatim** (trailing ";" dropped) |
| (c) "EF-G (b) holds (`#U_N ≥ c·N^{1/[F:ℚ]}` via `U_ℚ ⊆ U_F`)" | `plans/FS100-derivation.md` FS100-EFG | **verbatim** |
| (c) "`h_m(u) = Σ_v log max(1, \|u\|_v)` … `= log H(u)` for totally real `F`" | FS100-EFG | **verbatim with an ellipsis** over "over all places of `L` (the finite ones in `supp u`);" — meaning intact |
| (d) "**A finite-graph killing test for MR:** any proof that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087)." | `LEDGER.md` row 129 | **verbatim** |
| brief: "any proof that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087)" | row 129 | **verbatim** |
| brief: "`α₁(ℝ²) ∈ (0.2470, 0.24996]`", "`[DuczVarga2026]`'s graph has ratio below 1/4", B-AMEN's gloss | the advisor's record `plans/POROS-2026-09-26-fs105-harden-mr.md` §2.3; row 129 ("B-AMEN and B-CHIF one mind") | **not quotations** (the owner's and advisor's summaries); checked against their sources at stage 4 |

**Result:** no quotation changes a statement. One truncation noted (§0's `H`).

### 1.2 The setting at `F_dG`, by PARI (`tools/fs105_w_setting.py`; output `data/fs105/fs105-w/setting.out`; each plant's output beside it)

| check | claim | result |
|---|---|---|
| S1 | `[F_dG:ℚ] = 16`, totally real | degree 16, Sturm count 16 ✓ (disc `2¹⁶3⁸5⁸7⁸11⁸`) |
| S2 | `[L:ℚ] = 32`; archimedean places of `L` | signature `(0, 16)`: **sixteen complex places**, none real ✓ |
| S3 | the 2-adic wall broken | `F_dG` has **4** primes above 2, each `e = f = 2`; `L` has **8**, each `e = f = 2`: every dyadic prime of `F_dG` **splits** in `L` ✓ — no stable dyadic place, so `R_F = O′` by row 100's Lemma C′ |
| S4 | G35's congruence (an odd square class `≡ 7 (mod 8)`) | `7, 15, 55, 231` ✓ (agrees with S3) |
| S5 | a totally split prime for Lemma W | **`p₀ = 421`**: 32 primes of `L` above it, all `e = f = 1`; found by the five Legendre symbols `(−1/p) = (3/p) = (5/p) = (7/p) = (11/p) = 1` and confirmed by `idealprimedec` (two routes, one prime) ✓ |
| S6 | Lemma W explicit | `z = √3+√5+√7+√11+21i+1` (the first of `n = 1…60` in `…+ni+1` with `v₄₂₁(Nz) = 1`), `w = z/c(z)`: `w·c(w) = 1` ✓; every non-trivial `τ ∈ Gal(L/ℚ)` (31 of them) moves the 421-part of `div(w)` ✓; `deg minpoly(w) = 32`; `(3+4i)/5` has no 421-part, so `⟨(3+4i)/5, w⟩ ≅ ℤ²` ✓. **Control (the advisor's risk):** `(3+4i)/5`, `(5+12i)/13`, `q₁³q₂⁵` all have minimal polynomials of degree 2 — a `Γ` from `U_ℚ` alone spans `ℚ(i)` only, **not admissible** ✓ |
| S7 | height normalisation | `H_L(q) = c¹⁶` exactly for ten primitive `q = (a+bi)/c` (`c = 5 … 65`); `\|q\|_v = 1` at all sixteen complex places (and `\|w\|_v = 1`: `L` is CM) ✓ |
| S8 | roots of unity | `μ(L) = μ₁₂` (`i`, `√3` in `L`; `√2 ∉ L`) ✓ |

**Plants** (each run separately; each turned its own check red and left the others unchanged): `heightnorm` (the `ℚ_p`-absolute value
`p^{−v/e}` in place of `N(P)^{−v}`) → S7 red (e.g. `H(9+40i)/41 = 7,984,925,229,121 ≠ 41¹⁶`); `notsplit` (the least prime with four of the
five symbols `+1`: 37) → S5 red (16 primes of `f = 2`); `subfieldz` (`z = 2+i ∈ ℚ(i)`) → S6 red (the automorphisms fixing `ℚ(i)` fix
`div(w)`; `deg minpoly(w) = 2`). A first draft's `H_L` read primes from `N_{L/ℚ}(q)`, which is 1 on `U` — it returned `H = 1` everywhere and
S7 went red on the clean run; fixed to `idealfactor` before any verdict (a tool defect caught by its own check, logged).

**Why the divisor argument proves admissibility** [hand]: if `v₄₂₁(Nz) = 1` then exactly one prime `𝔓 | 421` divides `(z)`, to the first
power (all 32 have norm 421). So the 421-part of `div(w)` is `𝔓 − c𝔓`. For `τ ≠ 1`, `τ𝔓 ≠ 𝔓` (the decomposition group of a totally split
prime is trivial), so `τ(div w^k) = k·τ(div w) ≠ k·div w` for `k ≠ 0`: no non-zero power of `w` is fixed by any non-trivial automorphism, i.e.
`ℚ(w^k) = L`. Every finite-index `Γ′ ⊆ ⟨u, w⟩` contains some `w^k`, `k ≠ 0`, so `ℚ(Γ′) = L`: admissible. The same argument with `(z) = 𝔓^h`
is X02D's Lemma W; the check exhibits one instance at degree 32.

### 1.3 C0 — probabilities before the walk (registered; P(TRUE) / P(GAP) / P(FALSE)), and the wrong-reason TRUE for each

| sub-claim | P | a wrong-reason TRUE would look like |
|---|---|---|
| (c-a) (a)'s items at `F_dG` (solenoid, action, admissibility via Lemma W, no virtually cyclic factor, ergodicity, entropy) | 0.88 / 0.10 / 0.02 | admissibility read off `ℚ(Γ) = L` alone (PE-1's original error), or checked on a `Γ ⊂ U_ℚ`; a4 passed by reading "virtually cyclic factor" to include the trivial factor or by not defining it |
| (c-b) EF_F⁺'s count and the growth the argument needs | 0.90 / 0.08 / 0.02 | the count and the thinness compared in two different height normalisations (`H_L` against `den`), so "1/16 suffices" is a comparison in which two things differ; or `K` chosen after `β` (circular) |
| (c-c) `h_m(u) = log H(u)` at `F_dG` | 0.93 / 0.06 / 0.01 | checking only `\|u\|_v = 1` at the archimedean places and not the inverse-limit step from `O_L[1/P₀]` to `R = O′` |
| (c-d) the leaves at the sixteen complex places | 0.94 / 0.05 / 0.01 | treating `A` as one circle (the degree-2 picture) or arguing zero entropy from small support instead of an isometry |
| **(c) overall — C-MR16 TRUE by the same proof** | **0.80** / 0.17 / 0.03 | all four TRUE with no step's degree-dependence written |
| (d1) MR(`F₁`) ⟹ `α₁(ℝ²) = m₁(ℝ²)`, links correct | 0.82 / 0.15 / 0.03 | a link that holds for measurable sets being used for finite graphs; B-AMEN taken as obvious |
| (d3) nothing in print proves `α₁(ℝ²) > m₁(ℝ²)` | 0.95 | reading "no proof found" from a search in our own vocabulary |

### Would have searched here (stage 1)

- Lemma W's `z`: would have searched small elements of `O_L` for one of norm exactly divisible by a totally split prime; instead tried one
  fixed family `√3+√5+√7+√11+ni+1`, `n = 1…60`, exact norms, first hit at `n = 21` — a check of seconds on a list fixed in advance, not a
  witness search in the ban's sense.

## Stage 2 — SAVED ((c) EF_F⁺ at degree 16: a walk of X01D §3 and X12B §2 at `F_dG`)

*Read in full for this stage: `plans/FS100-X01D-derivation.md` §§2–4; `plans/FS100-X12B-derivation.md` §2; `plans/FS100-X01V-verification.md`
§2.3 and §4; `plans/FS100-derivation.md` §3; the advisor's record stages 1–3. This is a checking reading of two written proofs, not a blind
mind.*

### 2.0 One height normalisation, stated once and used for both records

`|x|_v` is the normalised absolute value on `L` (`N(P)^{−v_P(x)}` at a finite `P`; `|x|²` at a complex place). `H(u) := H_L(u) =
∏_{P finite} max(1, |u|_P)` — the definition §0's quotation cut off (X02D line 12). `n := [F:ℚ] = 16`, `d := [L:ℚ] = 32`. `V_M := {q ∈ U_ℚ :
H(q) ≤ M}`. **Exact at `F_dG`** (G1, all 140 elements of `U_ℚ` with `den ≤ 101`): `H(q) = (den q)^{16}`, so `#V_M = #{q ∈ U_ℚ : den q ≤
M^{1/16}} = 4 + 8·#{primitive triples, hypotenuse ≤ M^{1/16}} = (4/π + o(1))M^{1/16}` (the triple formula matched at six thresholds).
- **X01D** counts in this normalisation: `#V_M ≥ c₀M^{1/n}` — row 120's `c·M^{1/[F:ℚ]}`, the claim list's `c·N^{1/16}`.
- **X12B** counts by the denominator `X` and bounds `H(q) ≤ c^{[L:ℚ]}`, so in this normalisation it asserts only `#V_M ≥ (4/π)M^{1/32}`:
  **the same set, counted with a bound loose by a factor 2 in the exponent** (G1 gives the exact `c^{[F:ℚ]}`; G3 finds X12B's per-place
  bound `(4X⁴)^{−[L:ℚ]}` needs exponent `≤ 2` on the 190 pairs of `den ≤ 13`, `≤ [F:ℚ]` by the local-degree argument). Both exponents are
  positive; nothing downstream reads which. Recorded so that no one compares `M^{1/16}` with `M^{1/32}` as a discrepancy of mathematics.

### 2.1 The deciding question — what growth the argument needs, and whether `1/16` supplies it

**The chain of inequalities in X01D §3, with every constant's dependence on the degree named** (`F` totally real, so `L` is CM,
`|u|_v = 1` at all `d/2` complex places for every `u ∈ U`; `C_Λ = ∏_{stable w} sup_{y∈Λ}|y|_w`, a constant of the field):

| step | inequality it needs | degree enters as | at `F_dG` |
|---|---|---|---|
| Lemma 3.1′ (local injectivity) | `(4ε)^{d}·H(u*)·C_Λ < 1` (the `ε`-box meets `Λ` only in 0 through one `u*`-step) | the exponent `d` on `4ε` | `ε < (C_Λ H(u*))^{−1/32}/4`; fixed once `u*` is |
| Lemma 3.1′ (SMB + Jacobs + Egorov) | for every `β > 0`: `δ₀(β)`, `X′` with `μ(B) ≥ δ^β` for `δ ≤ δ₀` | none | any `β` |
| Step 3 (pigeonhole) | `#V_M · M^{−Kβ} > μ(R̂)` for `M ≥ M₂` | the count's exponent `1/n` | `(4/π)M^{1/16}·M^{−16β} > 1`: holds for `β < 1/256`; X01D takes `β = 1/(2nK) = 1/512`, exponent `1/32` |
| Step 4 (`z = ℓ₁e₂ − ℓ₂e₁ = 0`) | `(16ε)^{d}·M^{9−K} < 1/C_Λ` for large `M` | only the constant `(16ε)^{d} ≤ 1` (`ε < 1/16`) | `K > 9` — **the exponent is degree-free**: `3` at `v*` (`M·M²`) plus `6` over the split places (`H(v₁)H(v₂)` at two scales, `M²·M⁴`); `K = 16` |
| Step 5 (divide at `v*`) | `\|ℓ_j\|_{v*} ≥ 4^{−d/2}M_j^{−2}` (Lemma PF for one element of `R`), so `\|x̃ − t\|_{v*} ≤ 2^{d}M_j^{3−K} → 0` | the constant `2^{d}` | `2^{32}M_j^{−13} → 0`; **checked exactly** on 2,400 (pair, split prime) instances at degree 32 (G2): minimum slack `2^{28}`, met at `ℓ = 2` at the dyadic primes — which are split at `F_dG` because the wall is broken, so the archimedean constant is used there |
| Step 7 (wandering shells) | a `g ∈ U` with `ord_w(g) = h ≠ 0` at each split `w ≠ v*` | none (`h` the class number of `L`, finite) | ✓ |

**The answer.** The argument needs **polynomial growth and nothing more**: for some `γ > 0`, `#V_M ≥ C·M^{γ}` for all large `M` (precisely:
`liminf log #V_M / log M > 0`, EF's (1.1) in `H_L`). The reason any fixed exponent suffices is the **order of choices**: `K` is fixed first
by Step 4 (degree-free, `K > 9`), then `β < γ/K`, and Lemma 3.1′ supplies `μ(B) ≥ δ^β` for **every** `β > 0`; the scale `M₂` then depends on
`β` and the field (at `n = 16` it may be astronomically large — it is finite, and nothing asks for uniformity in the degree, `F` being fixed).
**`1/16` supplies it**: `γ = 1/16`, `K = 16`, `β = 1/512`, pigeonhole exponent `1/32 > 0`. **What would not suffice:** sub-polynomial growth,
e.g. X01V's lacunary `(log M)^k` (the group `U_{supp(u*)}`): then `δ^β ≥ (log M)^{−k}` forces `δ ≥ (log M)^{−k/β}`, against Step 4's `δ ≤
M^{−K}` — the pigeonhole and the product formula cannot both hold. X01V's blind GAP was a claim that only such multipliers are usable; its
withdrawn premise (images small at every place) is not what the proof uses (Step 4 reads the *product* over all places), and at degree 16
this is unchanged.

**X12B §2.2 at `d = 32`** (the other normalisation, walked the same way): step 4's constants are `a ≤ 5d = 160` (from `|q_i|_v ≤ X^{d}` and
`|q₁ − q₂|_v ≥ (4X⁴)^{−d}`, both loose — G3) and `b = O(d)` (the height of `1/(q₁ − q₂)` equals that of `q₁ − q₂` over all places, `≤
2^{d}H(q₁)H(q₂)`, plus the `d/2` complex places' `2rX²`); step 5 needs `K > (3b + 2a|P⁺|)/(|P⁺| log ρ)` with `ρ = min_{P⁺}|u*|_v ≥ 5` for
totally real `F` (a split finite place); step 6's `β = 1/(2K)` makes the pigeonhole `(4/π)X·X^{−1/2} > 1`. Here `K` grows linearly with `d`,
and it is chosen before `β`: the same order of choices, the same conclusion. **No failing line at degree 32.**

### 2.2 The remaining items of (c)'s EF_F⁺ part, at `F_dG`

| item | walk at degree 16 | verdict |
|---|---|---|
| **the expanding place** (X01D Step 0; X12B `P⁺ ≠ ∅`) | `u*` non-torsion; `\|u*\|_w = 1` at stable `w` and at all 16 complex places (CM); if `\|u*\|_w ≤ 1` at every split `w` the product formula makes all `= 1` and Kronecker makes `u*` a root of unity (`μ(L) = μ₁₂`, S8). So `v*` is a **split finite** place of `L` | TRUE |
| **the product formula over `L`, `[L:ℚ] = 32`** | normalised absolute values; the complex places contribute squares, which is where `(4ε)^{32}`, `(16ε)^{32}`, `4^{16}` come from (Lemma PF, Steps 3–5); the stable places through `C_Λ` (the different of `L` at stable primes: finite). G2 checks Step 5's consequence exactly | TRUE |
| **the multipliers `U_ℚ`** | `q ∈ ℚ(i) ⊂ L`, `q·c(q) = 1`, `\|q\|_v = 1` at every complex place of `L` (S7); `μ(qB) = μ(B)` is all that is used — **never admissibility** | TRUE |
| **the leaves at the sixteen complex places** (X01D Steps 6–7; X12B Lemma Z) | after Step 5 `μ` is on `T + K_{v*}`; the leaves `π(t + W_{v*})` are disjoint and injective (`L ∩ W_{v*} = 0`); `U`-orbits on `L/Λ ≅ ⊕_{stable} L_w/Λ_w` are finite; Step 7's shells kill every split coordinate `w ≠ v*` (one `g = γ/σ(γ)` per `w`), leaving `W_{v*} ∩ L_∞ = L_∞ ≅ ℂ^{16}`. So `μ` is carried by `T + A` with `A` the injective image of `ℂ^{16}` (not one circle: sixteen), and `T + A ⊆ E` | TRUE |
| **EF-X at `F_dG`** (the control that the conclusion cannot be finite support) | arc length on a circle in any one of the 16 complex coordinates is `U`-invariant, and `U`-ergodic because `(3+4i)/5` rotates every coordinate by `±arctan(4/3)` (an irrational multiple of `π`); zero entropy (an isometry of a circle); carried by `A`. Products of such circles over several coordinates (tori) are invariant too, all inside `A` | TRUE; consistent with EF_F⁺ |
| **`h_m(u) = log H(u)` for totally real `F`** (FS100-EFG) | at `F_dG`, `\|u\|_v = 1` at every complex place (CM), so the archimedean terms of `Σ_v log⁺\|u\|_v` vanish and the formula is `log H(u)`, **given** the `S`-integer entropy formula (Lind–Ward 1988, Chothi–Everest–Ward 1997, Yuzvinskii's addition formula — cited from memory in X01D §2.1 (a′), **unread here too: a debt carried, not paid**). **What MR actually uses** is only `h_m(u) > 0` for non-torsion `u` (PE-2's separation of Haar from the zero-entropy part): `u` expands a split finite place `w` (above), and Haar on a factor solenoid on which `u` expands `L_w` has positive entropy (Yuzvinskii) | TRUE by statement; the load-bearing consequence (positivity) needs only the expanding place |
| **the advisor's risk (i)**: zero entropy of one `u` controls only `u`'s own expanding places | true at degree 16 (`P⁺` is finitely many split places of `L`), and enough: X01D Step 7 / X12B Lemma Z handle every other split place by invariance, one place at a time; the archimedean coordinates are handled by the box (the multipliers are isometries there, so the `2ε`-fatness costs only `(16ε)^{32} ≤ 1`) | the risk is **moot** |
| **the advisor's risk (ii)**: a `Γ` from `U_ℚ ⊂ ℚ(i)` spans only `ℚ(i)` and is not admissible | **true** — S6's control (`(3+4i)/5`, `(5+12i)/13`, `q₁³q₂⁵`: minimal polynomials of degree 2) — and **moot**: EF_F⁺ uses `U_ℚ` only as pigeonhole multipliers; PE-2 uses `⟨u, w⟩` with `w` from a totally split prime (S6: 421) | **moot** |

### 2.3 Verdict on (c)'s EF_F⁺ part

**EF_F⁺ at `F_dG`: TRUE by X01D's and X12B's proofs, walked at degree 16 — no step fails; the degree enters only constants chosen before
the scale, and the growth `U_ℚ` supplies (`M^{1/16}`, exact) exceeds what the argument needs (any positive exponent).** Grade: [hand,
checking reading of two written derivations (X01D, X12B), one mind, not blind; tools exact on the count and on Step 5's division at degree
32]. The C0 line (c-b) is scored at stage 5.

**Where a failure would have had to sit, and why it does not:** (1) a degree-dependent exponent in Step 4 — none (`9` is `3 + 6`, both from
heights in `H_L`); (2) an arch constant growing faster than the thinness — it is a constant, `M → ∞` absorbs it; (3) a count whose exponent
falls below what `β` allows — `β` is free; (4) a normalisation mismatch between the count and the thinness — both are in `H_L` (X01D) or
both in `X` (X12B), and G1 pins the conversion `H = den^{16}` exactly.

### 2.4 Tool defects and controls (stage 2)

- `tools/fs105_w_growth.py` (output `data/fs105/fs105-w/growth.out`; plants beside it): G1 (140 elements, 0 misses), G2 (2,400 instances,
  0 misses, min slack `2^{28}`), G3 (0 misses, worst exponent 2), COUNT (six thresholds). Plants: `unnormalised` → G1 red (136 of 140
  miss); `noarch` (drop `4^{d/2}`) → G2 red (48 misses, min slack `2^{−4}`, at `ℓ ∈ {2, 2i, 1 ± i, …}` on the dyadic split primes). Each fired
  for its own reason; the other checks stayed green.
- A first draft's split test used `nfgaloisapply` on a prime-ideal structure, which PARI refused (an error, loud, before any verdict);
  replaced by conjugating the second generator.

### Would have searched here (stage 2)

- none: every check was a complete enumeration of a finite set fixed in advance (`U_ℚ` to `den ≤ 101`; pairs to `den ≤ 13`).

## Stage 3 — SAVED ((c) PE-2 at degree 16: (a1)–(a8) at `F_dG`) — written and committed **before** opening `plans/FS105-R-reading.md`

*Read for this stage: `plans/FS100-X02D-derivation.md` §§2–3 (PE-1′, Lemma W, Lemma Γ, the passage to `U`, the second route);
`plans/FS100-X02V-verification.md` §§2.2–2.3 (Lemma TI, Lemma W, Lemma H, PE-erg); EL2021 §3.2's opening (the entropy it means), via
`pdftotext` in scratch. EL2021's Thms 1.2–1.3 as quoted in `data/fs105/claims.md` (a); their provenance (a0) and the proof's standing
assumptions (a9) are the reader's, not walked here. A checking reading, not a blind mind.*

### 3.1 The walk

`Γ = ⟨u, w⟩` with `u` non-torsion in `U_{F_dG}` and `w` from Lemma W; `M ⊆ R` a finitely generated `ℤ[Γ]`-module with `ℚM = L`,
`dim_ℚ L = 32`; `α: ℤ² → Aut(M̂)`, `n = (a, b) ↦` the dual of multiplication by `u^a w^b`.

| item | what it needs at `F_dG` | the walk | verdict |
|---|---|---|---|
| **(a1) solenoid** | `M̂` compact, connected, `M ⊗ ℚ` finite-dimensional | `M` countable (compact dual), torsion-free (connected dual), `M ⊗ ℚ = ℚM = L ≅ ℚ³²`. EL2021's definition (claims (a), p. 2) asks exactly this; no dimension bound appears in Thm 1.2's statement | TRUE |
| **(a2) action** | `ℤ² → Aut(M̂)` by continuous automorphisms | `γM ⊆ M` and `γ⁻¹ ∈ Γ`, so multiplication by `γ` is an automorphism of the discrete group `M`; its dual is a continuous automorphism; `Γ` abelian, so `n ↦ α^n` is a homomorphism | TRUE |
| **(a3) total irreducibility ⟺ admissibility** | the criterion, with its finiteness step | ⇐: a non-zero `Γ′`-stable `N ⊆ M` spans a `ℚ(Γ′)`-subspace of `L`; `ℚ[Γ′]` is a finite-dimensional domain, so a field, `= L` by admissibility; so `ℚN = L`, `M/N` is torsion and finitely generated over `ℤ[Γ′]` (coset representatives of `Γ/Γ′`), hence killed by one integer `m` and a quotient of `M/mM`, finite by Lemma F (`\|M/mM\| ≤ m³²`) — X02D's route; X02V's route by Krull dimension one of `ℤ[Γ′]` reaches the same. Neither route reads the degree beyond `m³²`. ⇒ is only used for PE-1's counterexamples | TRUE (two routes, both degree-free) |
| **admissibility itself, against the 373 proper subfields of `L`** | `ℚ(Γ′) = L` for every finite-index `Γ′` | `Gal(L/ℚ) ≅ (ℤ/2)⁵`, so `L` has 374 subfields (`1 + 31 + 155 + 155 + 31 + 1`), 373 of them proper. One argument excludes all: every proper subfield is fixed by a non-trivial `τ`, and `τ(w^k) = w^k` would need `τ(w)/w` to be a root of unity. **Exact, two routes:** S6 (divisors: every `τ ≠ 1` moves the 421-part of `div w`) and **A1** (`tools/fs105_w_admissible.py`: `(τ(w)/w)¹² ≠ 1` for all 31 `τ ≠ 1`, with `μ(L) = μ₁₂` from S8); plant `w := (2+i)/√5` → 15 of 31 fail (the `τ` fixing `ℚ(i)`) | TRUE |
| **(a4) not virtually cyclic; no virtually cyclic factor** | faithfulness on every non-zero submodule | `α^m = α^{kn}` on `M̂` ⟺ `γ_m = γ_n^k` in `L` (both multiply the spanning `M`); `Γ ≅ ℤ²` (A2: valuation rank 2 at the primes above 5 and 421; S8 torsion) forbids a finite-index `Λ ⊆ ℤn`. A non-trivial factor `M̂/Y` (`Y` closed, `α`- or `α_Λ`-invariant, proper) has `Y` finite by (a3), so its dual `N = Y^⊥` has finite index, `ℚN = L`, and the same faithfulness holds. **Reading used:** "virtually cyclic factor" means a *non-trivial* one (the trivial factor `X/X` is virtually cyclic by the letter of p. 2's definition — the advisor's point (i)); with it, total irreducibility plus "not virtually cyclic" gives "no virtually cyclic factor" (the advisor's (ii), by connectedness) | TRUE (with the non-trivial reading; the term is not defined in EL2021 §1) |
| **(a5) `d = 2`** | Thm 1.3's `d ≥ 2` | `Γ ≅ ℤ²` | TRUE |
| **(a6) ergodicity** | every measure fed to Thm 1.2 is a `ℤ²`-invariant, `ℤ²`-ergodic probability | X02D feeds `ρ_k = (π_k)_*ρ` with `ρ` `Γ`-ergodic on `R̂` (a `Γ`-invariant set of `M̂_k` pulls back); X02V feeds the `Γ`-ergodic components `ν_η` of `τ_j`'s decomposition (never `τ_j` itself). The `ℤ²`-action **is** the `Γ`-action (`ℤ² ≅ Γ`), so ergodic for all of `ℤ²`, not a finite-index subgroup; normalised. Ergodic decomposition: `Γ` countable acting continuously on compact metrizable `M̂` | TRUE |
| **(a7) entropy** | Thm 1.2's `h_µ(α^n)` and PE-2's limit use one notion | EL2021 §3.2 works with the measure-theoretic entropy of one automorphism `T` of `X` (leafwise-measure formulae for `h_µ(T)`); PE-2's `h_ρ(γ) = lim_k h_{ρ_k}(γ)` is Kolmogorov–Sinai's for an increasing generating sequence of `γ`-invariant factor σ-algebras (X02D T2; X02V (K)). Same notion; the degree does not enter | TRUE |
| **(a8) Lemma W at `F_dG`** | every non-torsion `u ∈ U_{F_dG}` lies in an admissible `Γ` | a prime `p` totally split in `L` (the five symbols `(−1/p) = (3/p) = (5/p) = (7/p) = (11/p) = 1`; density `1/32` by Chebotarev; the least is 421, S5) with `u` a unit above `p`; `w = z/c(z)`, `(z) = 𝔓^h`. The divisor argument (X02D, X02V) needs only that the decomposition group of `𝔓` in `Gal(L/ℚ)` is trivial — true for totally split `p` at any degree. **Exhibited** with `(z)` not a power of `𝔓` but `v₄₂₁(Nz) = 1` (S6, A1), which suffices by the same argument. **Also:** Haar is `Γ`-ergodic (a character with a finite `Γ`-orbit is killed by some `γ − 1 ≠ 0`); Haar has positive `u`-entropy on each `M̂` (Lemma H; or X02D §3.3's derivation), since `u` expands a split finite place of `L` (Kronecker, `L` CM) where `M ⊇ ℤ[u^{±1}]` is unbounded | TRUE |

**The passage from the pieces to `U`** (X02D §3.2, X02V §2.3; the claim list's (a) does not list it, the advisor asks for it): Γ-ergodic
decomposition on `R̂`, `U` permuting the components (abelian), `U`-extremality — or the constant Haar weight up the chain, the consistent
non-Haar parts, Kolmogorov extension. Nothing in either route reads the degree: `R` is countable, `M_k ↑ R` exists, and every textbook fact
(ergodic decomposition, Jacobs, entropy of an inverse limit, Fourier uniqueness) is dimension-free. TRUE at `F_dG` on this reading.

### 3.2 Verdict on (c)'s PE-2 part, and on (c) overall

- **PE-2 at `F_dG`: TRUE**, given EL2021 Thm 1.2 **by statement** — every hypothesis the statement names holds for `(M̂, Γ)` at degree 32,
  admissibility checked against all 373 proper subfields by two exact routes. [checking reading of two written derivations (X02D, X02V), one
  mind, not blind; tools exact]. **What this walk does not reach:** whether Thm 1.2 is proved (a0) and whether its proof assumes anything its
  statement omits (a9) — the reader's items. Neither depends on the degree as far as the statement shows; if (a9) finds a hidden
  hypothesis, it must be re-checked against 32-dimensional pieces with **sixteen** archimedean (isometric) directions, against two at ℚ(√635087).
- **C-MR16 — MR at `F_dG` walked at degree 16 — TRUE by the same proof** (EF_F⁺ at stage 2; PE-2 here; the composition FS100-MR (a) is
  field-free: `τ = a·m + τ′`, `τ′ ≤ τ` carried by `T + A ⊆ E`, `τ(E) = 0`). The degree enters only constants chosen before the scale
  (stage 2) and the count of subfields that one totally split prime excludes at once (here). Grade: [hand — a checking reading of the held
  derivations at degree 16, one mind, not blind; tools exact (S1–S8, G1–G3, A1–A3)], resting on EL2021 Thm 1.2 by statement and on the
  unread `S`-integer entropy formula only through the positivity of Haar entropy, which is derived (X02D §3.3). **It adds a reading, not a
  derivation;** row 120's "MR at degree 16 … its walk unexercised" (row 128) can become "walked (FS105-W, one checking reading)".

### 3.3 The reader's record — read after this stage's commit (`plans/FS105-R-reading.md`, stages 1–4, commit `309f2c3f`)

Read after `a0fee351` (this stage's first commit), so the two walks are separate minds on (a1)–(a8); the reader is blind to this record.

| item | the reader | this walk | agreement |
|---|---|---|---|
| (a1), (a2), (a5), (a7) | TRUE at both fields | TRUE at `F_dG` | agree |
| (a3) | TRUE; finiteness by Lemma F (no finite generation over ℤ), Krull route also correct | the same two routes | agree |
| (a4) | TRUE for `M̂`, every `α_Λ` **and the adelic lift** (Lemma 4.2), with "factor" = non-trivial, forced (FS105-R-VC) | TRUE for `M̂` and `α_Λ`, the same reading; the lift not checked | agree; the reader's is wider (the lift) |
| (a6) | TRUE; neither route treats a push-forward of a `U`-ergodic measure as `Γ`-ergodic | the same | agree |
| (a8) | TRUE; uniform proof, no enumeration of subfields; an exact instance at `F₁` (`p = 17`, `h = 965`) | TRUE; the same proof; an exact instance at `F_dG` (`p = 421`) by two routes (divisors; `(τ(w)/w)¹² ≠ 1` for all 31 `τ`) | agree; the two instances are complementary (one per field) |
| Haar entropy on the pieces | `h_{m_M}(γ) ≥ log 2` for every `γ ≠ 1` in `Γ` at totally real `F` (Mahler measure of the minimal polynomial; `γ` non-integral by Kronecker, leading coefficient `≥ 2`) — FS105-R-H | positivity only (Lemma H; X02D §3.3) | agree; the reader's bound is sharper and shorter |
| Lemma 7.4 (two independent Lyapunov weights) | holds for the pieces directly: `χ_𝔓(a, b) = b·log\|w\|_𝔓`, `χ_v(a, b) = a·log\|u\|_v` | **A2's valuation matrix (rank 2 at the primes above 5 and 421) is exactly this check at `F_dG`**, made for a different reason | agree; an exact instance at `F_dG` |
| (a9) | TRUE as far as read; a GAP of reading at EL2021's cited machinery; **our pieces are semisimple and isometric at every archimedean place, so every non-zero Lyapunov weight is non-archimedean**, and Thm 4.1's final step treats the purely `p`-adic case in full (p. 34) | flagged only: "if (a9) finds a hidden hypothesis, re-check against sixteen archimedean isometric directions" | **the reader's (a9) answers this walk's flag**: the sixteen isometric directions at `F_dG` contribute no Lyapunov weight, exactly as the two at `F₁`; nothing in the proof as read counts them |
| (a0) | **EL2003 is not a proof of its Thm 1.1 (§6 is an outline); Thm 1.2 follows from EL2021 Thm 1.3 by FS105-R-D (one mind), which EL2021 does not write** | "EL2021 Thm 1.2 by statement" | **a divergence of grounding, not of truth**: this walk's grade line must change — see below |

**Divergences of truth: none.** **One correction to this record, from the reader's (a0):** stage 3.2's "given EL2021 Thm 1.2 by statement"
should read *"given EL2021 Thm 1.3 (its proof read at its skeleton by FS105-R, the cited leafwise machinery unread) and FS105-R-D, the
deduction of Thm 1.2 from it (one mind)"*. C-MR16's walk is unaffected in substance: every hypothesis Thm 1.3 needs (d ≥ 2, no non-trivial
virtually cyclic factor, α-invariant ergodic probability) is among (a1)–(a8), all TRUE at `F_dG` by both walks.

### 3.4 A tool defect in stage 2's G2, found at this stage (logged; the stage-2 numbers stand)

`tools/fs105_w_growth.py` as committed at stage 2 defined `ap(a, e) = …; c = 0;` on one line; in GP a function body runs to the end of the
line, so `c = 0` became part of `ap`, `ap` returned 0, and **G2's split filter was inert**: it tested every prime dividing `ℓ`, split or not.
Found when the same line in `tools/fs105_w_admissible.py` failed loudly (a division by `ap(c, z) = 0`). Fixed in both tools (one statement
per line, and an assertion that the conjugation was found); G2 re-run with the working filter reads **the same 2,400 instances, 0 misses,
minimum slack `2^{28}`** — because at `F_dG` every prime dividing these `ℓ` (above 2, 3, 5, 7, 11, 13 and small `p`) is split (the stable
places start over 131, FS103-DG). **A control now guards the filter:** G4 — no prime of `L` above 131 is split (16 stable), all 32 above 421 are.
The stage-2 inequality was never at risk (Lemma PF bounds `|ℓ|_P` at every finite place, stable or split), but the label "split" was
unearned until G4. The plant outputs (`growth-plant-*.out`) predate G4 and target G1/G2 only; they fire as recorded.

### Would have searched here (stage 3)

- none: the admissibility checks are complete over the 31 non-trivial automorphisms; nothing enumerated beyond them.

## Stage 4 — SAVED ((d) row 129's finite-graph test)

*Read for this stage: `LEDGER.md` row 129; `plans/FS103-derivation.md` §2 (the FS103-F and FS103-B rows); `plans/FS103-F-fractional-shadow.md`
§2.3 (FRAC, its step 1) and §§3.2–3.4; `plans/FS103-B-verification.md` §2.1 ("The equalities"), §3.2, Stage 4's divergences; `[MatolcsiEtAl2025]`
§2 (the definitions, (12)–(14)) and Theorem 2's statement; `[AmbrusEtAl2023]` Theorem 1 and the end of its proof (p. 19), and the Remark of its
§4 on measurable against non-measurable variants; `[DuczVarga2026]` abstract, §§1–2.2, Lemma 1 and the blow-up paragraph after it. All held
(`~/source/library/pdf/`), read here in these sections by `pdftotext` in scratch. A checking reading, not a blind mind.*

### 4.1 (d1) — the chain, every inequality's direction named

The notation, from the sources: `α₁(X) = inf{α(G)/|G| : G ⊆ X finite unit-distance}` (MRVZ §2: "α1 (R2 ) = inf{α1 (G) : G ⊆ R2 , G is
finite}"); `m₁(ℝ²)` the maximal upper density of a measurable 1-avoiding set (MRVZ §2, after `[AmbrusEtAl2023]`); `α_inv(F²)` the supremum of
`P(0 ∈ I)` over `R ⋊ U`-invariant random independent sets of `Cay(R, U)`; `α_loc(F) = max(m₁(ℝ²), sup_v r_v)` (row 129). `F₁ = ℚ(√635087)`.

| link | inequality | direction and why | minds | uses MR? |
|---|---|---|---|---|
| L1 | `α₁(ℝ²) ≤ α₁(F₁²)` | an infimum over a larger family (every finite graph in `F₁²` is one in `ℝ²`) | trivial | no |
| L2 | `α₁(F₁²) ≤ α_inv(F₁²)` | **Følner**: maximum independent sets `I_n` of Følner pieces `B_n ⊂ R`, uniformly translated, weak-* limit (`R`-invariant, independent, `P(0 ∈ I) ≥ α₁`), then rotations averaged over Følner sets of `U` (F) or a Markov–Kakutani fixed point (B); rotations fix `{0 ∈ I}` and normalise translations. A finite graph of `F₁²` lies in finitely many cosets of `R` (edges stay in cosets, `U ⊆ R`), so `α₁(F₁²) = α₁(Cay(R, U))` | **two**, blind to each other: F §2.3 step 1; B §2.1 ("`α_inv(F²) ≥ α₁(F²)`") — and this reading | no |
| L3 | `α_inv(F₁²) ≤ α_loc(F₁)` | FRAC: an invariant set's spectral measure off `E` is `U`-invariant and `E`-null; MR makes it Haar; the per-class SI then puts the set inside one with spectrum on `T + A`, extended to `G_∅` and counted place by place. **Unconditionally:** density `> α_loc` gives an SP witness, which refutes MR (J45-SP-oi) | two blind (F; B) | **yes — the only use** |
| L4 | `α_loc(F₁) = m₁(ℝ²)` | every stable place has `r_v ≤ 0.16330 < δ_Croft = 0.22936 ≤ m₁` (FS103-F-PL, exact to 2000 and Weil beyond); the real place contributes `m₁` (the density points of the extended set are everywhere 1-avoiding, B §3.2 (i)) | tools exact, two | no |
| L5 | `m₁(ℝ²) ≤ α₁(ℝ²)` | a periodic 1-avoiding set of density `d → m₁` under a uniform translation meets a finite `G` in `d\|G\|` points on average — MRVZ (14): "0.22936... = δCroft ≤ m1 (R2 ) ≤ α1 (R2 ) ≤ 1/4"; `[DuczVarga2026]` Claim 1 | in print | no |

So `α₁(ℝ²) ≤ α₁(F₁²) ≤ α_inv(F₁²) ≤ α_loc(F₁) = m₁(ℝ²) ≤ α₁(ℝ²)`: **every term equal, given MR(`F₁`)** — the directions are consistent,
and each arrow is the one its reason gives. **The killing test, run backwards:** a proof of `α₁(ℝ²) > m₁(ℝ²)` gives, by L1 and L2,
`α_inv(F₁²) ≥ α₁(F₁²) ≥ α₁(ℝ²) > m₁ = α_loc(F₁)` (L4), so an invariant random independent set of density above `α_loc(F₁)`, so (L3,
unconditional form) an SP witness over `F₁`, so MR(`F₁`) is false. **Row 129's sentence is correct as stated.** (As with every killing
test, what such a proof refutes is the conjunction MR(`F₁`) ∧ L2 ∧ L3's unconditional form ∧ L4; L2 and L4 carry no MR, and L3's
unconditional form is J45's.)

**B-AMEN — the link the advisor named softest — is not load-bearing here.** B-AMEN (FS103-B-AMEN) is the *equality* `α₁(F²) = α_inv(F²)`, and
row 129 grades it "one mind". Its two halves are unequal:
- **`α₁(F²) ≤ α_inv(F²)` (Følner) — used, as L2**, and it has **two** derivations (F's FRAC step 1 and B's §2.1), blind to each other.
- **`α₁(F²) ≥ α_inv(F²)` (an invariant set meets a finite `G` in `δ|G|` points on average) — not used** by `α₁(ℝ²) = m₁(ℝ²)` or by the
  killing test; it is used only for the field-level equality `α₁(F²) = α_loc(F)` (with the pullbacks `α_inv ≥ α_loc`), where the ℝ²
  statement gets the same inequality from L5 instead. It is one mind (B) and one line: `E|I ∩ G| = Σ_{x∈G} P(x ∈ I) = δ|G|` with an
  independent copy of `I` on each coset of `R`, so some realisation has `α(G) ≥ |I ∩ G| ≥ δ|G|`. Checked here (not blind): TRUE.
- **B-CHIF** (`χ_f(ℝ²) ≤ 1/m₁`, one mind) is likewise not used by the killing test or by `α₁ = m₁`; it enters only row 129's
  `χ_f(ℝ²) = 1/m₁`.

**Verdict (d1): TRUE** — MR(`F₁`) ⟹ `α₁(ℝ²) = m₁(ℝ²)`, every link named with its direction; the only MR-carrying link is L3 (FRAC, two
blind); the one-mind links of row 129 (B-AMEN's reverse half, B-CHIF) are off the chain the killing test uses. [checking reading, one mind,
not blind]. **Correction owed (proposed for the close, not made):** row 129's grade line could say which half is used — "B-AMEN (its
reverse half only) and B-CHIF one mind; the killing test and `α₁(ℝ²) = m₁(ℝ²)` use only the Følner half (two blind: F, B)".

### 4.2 (d2) — the weakest statement about finite unit-distance graphs that proves `α₁(ℝ²) > m₁(ℝ²)`

The best proved bounds, from the sources:
- `m₁(ℝ²) ≤ 0.24699…`: `[AmbrusEtAl2023]` Theorem 1, "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470",
  with the computed value at the end of its proof (p. 19): "m1 (R2 ) ⩽ … = 0.24699 . . . < 0.2470".
- `m₁(ℝ²) ≥ δ_Croft = 0.22936…` (MRVZ (14)); no better lower bound on `α₁(ℝ²)` is known than this one, through `m₁ ≤ α₁` (L5).
- `α₁(ℝ²) < 1/4.0007 = 0.249956…`: `[DuczVarga2026]` Lemma 1, "χgf (G29 ) > 4.0007", and its next paragraph: "we can obtain finite
  'blow-ups' of our graph G29 with independence ratio arbitrarily close to 1/χgf (G29 )".

So `α₁(ℝ²) ∈ [0.22936…, 0.249956…)` and `m₁(ℝ²) ∈ [0.22936…, 0.24699…]` unconditionally. **The weakest statement that proves
`α₁ > m₁` with these bounds:**

> **(W) There is a constant `c > 0.24699…` such that every finite unit-distance graph `G` in the plane has `α(G) ≥ c·|G|`** —
> equivalently (MRVZ Theorem 2, `χ_f,0(ℝ²) = 1/α₁(ℝ²)`), **every finite unit-distance graph has `χ_f(G) ≤ 1/c < 4.04876`**.

`c` must lie in `(0.24699…, 0.249956…)`: the window is **0.00297 wide in ratio** (in `χ_f`: `sup_G χ_f(G)` would have to be proved below
`4.04876`, while `[DuczVarga2026]` proves it above `4.0007`). A uniform lower bound on `α(G)/|G|` for **every** finite unit-distance graph is
the whole content: nothing weaker (a family, a density statement about one graph) says anything about the infimum.

**A form that needs no numerics:** (W′) **`χ_f,0(ℝ²) < χ_f(ℝ²)`** — the finitary fractional chromatic number strictly below the whole-plane
one. With B-CHIF (`χ_f(ℝ²) ≤ 1/m₁`) and MRVZ Theorem 2, (W′) gives `1/α₁ < χ_f ≤ 1/m₁`, so `α₁ > m₁`. MRVZ §2 states exactly this as open:
"It is clear that χf,0 (R2 ) ≤ χf (R2 ), but it is not known whether equality holds." So **MR(`F₁`) predicts the answer "equality" to a question
in print, and a proof of "strict" refutes it** — through B-CHIF, the one one-mind link this form uses. **Neither of (W), (W′) implies the
other** ((W′) gives `α₁ > m₁` without beating `0.24699…`; (W) gives `χ_f,0 < 4.0488` without comparing with `χ_f`, whose lower bound by
`1/m₁` is not known for colourings by arbitrary sets); **each suffices**, and together they are the two shapes a refutation can take: beat a
proved bound on `m₁`, or separate the finitary from the whole-plane number.

### 4.3 (d3) — what in print or held comes near it

- **Nothing in print or held proves (W) or (W′), or comes within a named margin.** The best proved lower bound on `α₁(ℝ²)` is
  `δ_Croft = 0.22936…`, through `m₁ ≤ α₁` itself; (W) needs `0.24699…`: **0.0176 above the best proved lower bound**, and no technique for a
  lower bound on `α(G)/|G|` over all finite unit-distance graphs other than averaging a measurable 1-avoiding set is known to me or appears in
  the three papers read — and that technique gives `m₁`, never more. A refutation would need a new kind of argument: a non-measurable,
  finitely supported fractional colouring of every finite graph beating every measurable one.
- **The cheap form, the advisor's point: `α₁(ℝ²) ≥ 1/4` would have refuted MR, and it is false in print.** It is MRVZ's Conjecture 1 (verbatim:
  "Conjecture 1. χf,0 (R2 ) = 4, and for all finite unit distance graphs G ⊆ R2 we have χf (G) < 4"; their (14) conjectures "α1 (R2 ) = 1/4"),
  and `[AmbrusEtAl2023]` §4's Remark ("we venture to conjecture that χf (R2 ) = χgf (R2 ) = 4. This would imply that α1 (R2 ) = 1/4 and m1 (R2 )
  ≤ 0.247 hold simultaneously, providing an interesting example of a natural infinite graph for which the measurable and the non-measurable
  variants of a parameter have different values"). `[DuczVarga2026]` disproves it (Theorem 1). **So a reachable refutation of MR was on the
  table in print in 2023–2025 and did not happen**: a met prediction, weak, because after June 2026 nobody expects `α₁ = 1/4`. The published
  expectation `α₁ ≠ m₁` was heuristic — "Based on this numerical evidence" (Ambrus et al.; a numerical record `χgf = 3.9954` in the Moser
  lattice) — and its stated basis is false in print.
- **The prediction side, as a number.** MR(`F₁`) predicts `α₁(ℝ²) = m₁(ℝ²) ≤ 0.24699…`, i.e. finite unit-distance graphs (triangle-free ones
  among them, over `F₁`, row 129) with `χ_f` up to `≥ 1/0.24699… = 4.04876 − o(1)`. The best proved is `[DuczVarga2026]`'s `χ_f > 4.0007`
  (blow-ups of `G29`, triangle-full: its field holds `ζ₆`). **The prediction is unscored at a margin of at least 0.00297 in ratio
  (`0.249956 − 0.246990`), 0.048 in `χ_f` (`4.0487 − 4.0007`)** — "at least", since `1/χgf(G29)` is not known exactly (Lemma 1's certificate
  is "not claimed to be optimal") and `m₁` may be as low as `δ_Croft`.
- **zbMATH API, one query set (WORKFLOW 3.2 item 8), 2026-09-26** (`data/fs105/fs105-w/zbmath/q1–q6.json`):

  | query | hits | relevant |
  |---|---|---|
  | `ab:"independence ratio" & ab:"unit distance"` | 2 | MRVZ; DV — both held and read |
  | `ab:"fractional chromatic number" & ab:"plane" & py:2022-2026` | 4 | MRVZ; DV; `[Ducz2026]` (held, read); Zbl 1535.05104, license-withheld in zbMATH, identified by Crossref from its DOI `10.1080/0025570X.2023.2176684` as V. Jungić, *Still Spinning: The Moser Spindle at Sixty*, Math. Mag. 2023 — title only, expository by its title, **not read** |
  | `ab:"avoiding unit distance" \| ab:"avoiding distance 1" \| ab:"1-avoiding"` | 37 | `[KMOR2016]`, `[Bellitto2021]` (both in `BIBLIOGRAPHY.md`); the rest permutation patterns |
  | `au:"Ducz" \| au:"Dúcz"` (the poser's complete listing) | 5 | the two held; *Improved bounds for the double cap conjecture* (Czifra, Dúcz, Matolcsi, Varga, Zsámboki, arXiv:2605.28709) and *On the maximal measure of a spherical set avoiding solutions to x + y + z = 0* (Dúcz, arXiv:2607.05083) — sphere problems by title, **titles only, not read**; *Domination and packing in graphs* (unrelated) |
  | `ab:"unit distance graph" & ab:"independence number" & py:2020-2026` | 0 | — |
  | `ab:"measurable" & ab:"independence ratio" & ab:"plane"` | 0 | — |

  **Negative, and it measures these words (G21):** no citer or co-author work states a lower bound on `α₁(ℝ²)` above `m₁`, and none states
  `α₁ = m₁`. The citation walk of `[DuczVarga2026]` (June 2026) is empty in zbMATH, as expected of a three-month-old preprint.

**Verdicts (d2), (d3):** (d2) stated: (W), and (W′) through B-CHIF. (d3): **nothing near** — the refutation needs `0.0176` above the best proved
lower bound on `α₁(ℝ²)` with no technique in sight; the cheap form is false in print; the prediction is unscored at `≥ 0.00297` in ratio.
[reading of held papers + derivation of the window, one mind]

### Would have searched here (stage 4)

- (d3): would have searched for finite unit-distance graphs of small independence ratio (to score the prediction side); instead read the
  best proved bound in `[DuczVarga2026]` and stated the margin. The ban holds.
