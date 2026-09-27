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
