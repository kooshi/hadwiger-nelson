# FS-89 Stage 1: the derivation agent's lemma statements, for the V-B verifier's phase B2

*Copied verbatim by the owner from `plans/FS89-S1D-derivation.md` (commits 946abfef, 57781bcd, 45ab9636). **Statements only: every proof, and every sentence that describes a proof's method, is omitted**, marked `[proof omitted]`. The verifier opens this file only after its phase-B1 verdicts are committed (its brief says so). The definitions come first because the lemmas use them.*


## Setting and the dichotomy (definitions, verbatim)

**Setting.** `G = R̂_S = (ℂ × ℚ_S)/Δ(R_S)`, with `ℚ_S = ∏_{v|S} ℚ_v` over the `2|S|` places above `S`. `u ∈ U_S` acts by
`θ ↦ θ∘u`; in these coordinates that is `(v, b) ↦ (ū v, u b)`, since `Re(v̄ u x) = Re(conj(ū v) x)`. So `u` rotates the
archimedean coordinate and multiplies each `b_v` by `u ∈ ℚ_v^×`. `|w_p|_v = p^{∓1}` at the two places above `p`, and `|w_p|_v = 1`
at every other place.
- **Chart.** For small `ε` and a small compact open subgroup `O ⊆ ℚ_S`, the map `D(ε) × O → G` is injective (`Δ(R_S)` is
  discrete) and its image `N(ε, O)` is a neighbourhood of `0`. Each `z ∈ N(ε, O)` has a unique **`S`-adic part** `b(z) ∈ O`.
- The image of `D(ε) × {0}` lies in `A`, and `A ∩ T = 0` (S0A-2).

**The dichotomy** (Berend's). Let `M ⊆ G` be closed and `U_S`-invariant.
- *Case 2:* for some `ε, O`, every `z ∈ (M − M) ∩ N(ε, O)` has `b(z) = 0`.
- *Case 1:* otherwise. Then there are `z_k ∈ M − M` with `z_k → 0` and `b(z_k) ≠ 0`.

## D1-L2

**D1-L2 (case 2 ⟹ a point of `T + A`).** If `M ≠ ∅` is in case 2, then `M ∩ (T + A) ≠ ∅`. If `M` is minimal, then `M ⊆ T + A`,
and `M` is a finite union of sets `τ + {λ_d : |d| = r}` (one `r`, possibly `0`). [hand] [proof omitted]

## D1-L3

**D1-L3 (case 1 ⟹ `M − M = G`, when `|S| ≥ 2`).** If `M` is closed, invariant and in case 1, and `|S| ≥ 2`, then `M − M = G`. [hand] [proof omitted]

## D1-L4

**D1-L4 (the parity line; band `[1/4, 3/4]` only).** Let `θ₂` be the parity character. If `M ⊆ Θ₄(R_S)` and `θ₂ ∈ M − M`, then
`M` contains a **corner**: a character `x` with `2x = θ₂`, i.e. `x = ⟨e, ·⟩` with `e ∈ (1+i)/4 + ½ℤ[i]`. There are four
corners; they form one `U_S`-orbit of order-4 torsion characters, of margin 0. [hand] [proof omitted]

## D1-L5

**D1-L5 (near a corner the deviation rotates rigidly and dies).** In the model D0-T1 at `S = {5, 13}`, let `x` be a corner. Its
array is `c_{m,n} = (−1)^m c₀`, with `c₀` a corner of `Q = [¼, ¾]²`, because `w₅ ≡ −1` and `w₁₃ ≡ 1 (mod 4)`. Suppose a band
array has `|e_{m,n} − c_{m,n}| < 0.13` at `(m, n)` and at `(m+1, n)`. Then `e_{m,n} = c_{m,n}` and `e_{m+1,n} = c_{m+1,n}`. [hand + tools exact] [proof omitted]

## D1-L6

**D1-L6 (corner exit lemma, `S = {5, 13}`).** Suppose a band array equals the corner pattern at `(m, n)` and `(m, n+1)`. Then it
equals the pattern at `(m ± 1, n)` and `(m ± 1, n+1)`. Suppose it equals the pattern at `(m, n)`, `(m+1, n)` and `(m+2, n)`. Then
it equals the pattern at `(m, n ± 1)`, `(m+1, n ± 1)` and `(m+2, n ± 1)`. [hand + tools exact] [proof omitted]

## D1-C1

**D1-C1 (corners are isolated in `Θ₄(R₆₅)`).** A band array that equals a corner pattern on a `3 × 2` box is that corner.
Hence every `θ ∈ Θ₄(R₆₅)` within `0.13` of a corner on the window `|m| ≤ 2, |n| ≤ 1` is that corner. [hand + tools exact] [proof omitted]

## D2-L1

**D2-L1 (bounded-order layering).** Let `R ⊆ Q` be a subring with `U_R := U_ℚ ∩ R` and `ℤ[U_R] = R`. Suppose `R` is
`p`-divisible for some prime `p` (so `λ_c` vanishes on a nonzero ideal of `R` only if `c = 0`). Suppose also that
`Θ_β(R) ⊆ T_N + A` for some `N`. Then `Θ_β(Q) ⊆ T_N + A`. [hand] [proof omitted]

## D5-L1

**D5-L1 (band-1/5 replacement for D1-L4).** Let `M ⊆ Θ₅(R_S)` be closed, with `5 ∈ S`, and suppose `θ₂ ∈ M − M`. Then `M` meets
`𝒞 := ⋃_{x₀ corner} (x₀ + {λ_d : |d| ≤ 1/20})`, the four **corner leaf discs**. At band 1/5 the corners have margin 1/20. [hand] [proof omitted]

## D5-L2

**D5-L2 (rigidity near a corner leaf).** Let `y = x₀ + λ_d` with `|d| ≤ 1/20`. Suppose an array is within 0.13 of `y`'s array on a
connected window. Then it equals the leaf array of `x₀ + λ_{d′}` there, for some `d′`. [hand] [proof omitted]

## D5-L3

**D5-L3 (corner-leaf exit lemma, `S = {5, 13}`, band 1/5).** Suppose an array equals a corner-leaf array `c_{m,n} + w̄^{(m,n)}d′`,
with `|d′| ≤ 0.06`, on a column segment of height 3. Then it equals it on the two neighbouring columns at those rows. On a row
segment of length 4 it equals it on the neighbouring rows. [hand + tools exact] [proof omitted]
