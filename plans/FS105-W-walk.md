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
