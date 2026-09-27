# FS105-B — a blind third derivation of EF_F⁺ at ℚ(√635087) (and EF_F⁰)

*Job FS105-B (Coxeter), FS-105 "harden MR", 2026-09-26. Brief: `data/fs105/briefs/B105-blind-efp.md`; standing rules
`data/fs105/briefs/STANDING-RULES.md`; claim (b) of `data/fs105/claims.md`. Blind until stage 3 is committed: nothing on the
brief's fence list opened before then.*

## Theorems this phase proved

- **FS105-B-M1** — `R̂ ≅ 𝔸_𝒮/D` equivariantly, `ker Φ = D = {ℓ ∈ L : ℓ ∈ 𝔡_v⁻¹ at stable v}`, `T = Φ(L)`, `A = Φ(L_∞)` (any real `F`
  with `R = O′`). [hand, one mind] §Stage 2 M1.
- **FS105-B-L0** — non-torsion `u ∈ U_F` (`F` totally real) has a split place with `|u| > 1`. [hand] Lemma 0.
- **FS105-B-L1b/L2** — Bowen balls of `u*` are thin at `𝔓₀`; `h_μ(u*) = 0` ⟹ `μ(x + W_n) ≥ e^{−nβ}` on large sets. [hand] Lemmas 1b, 2.
- **FS105-B-L5** — `μ`-a.e. `x` has its `𝔓₀`-coordinate in `L`. [hand] Steps 3–5.
- **FS105-B-L6** — a `U`-invariant finite measure on `T + Y_{𝔓₀}` lives on `T + A`. [hand] Lemmas 6a–6b.
- **FS105-B-EFP** — **EF_F⁺ at `F₁ = ℚ(√635087)`: TRUE.** [hand, one mind blind] Step 6 Theorem.
- **FS105-B-EF0** — **EF_F⁰ at `F₁`: TRUE** (corollary; ergodicity unused). [hand, one mind blind] Corollary.

---

## Stage 1 — SAVED

### 1.1 What I read (and did not)

| source | status |
|---|---|
| brief, standing rules, `data/fs105/claims.md` | read in full |
| `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md` | in context as loaded from disk at session start (the harness's copy) |
| `LEDGER.md` | header, rows 98, 100, 105, 113, 118, 120 read in full; rows 128–129 and § B located by grep (`635087`) only. **Deviation:** not every row — the file is 423 kB (≈ 150k tokens) against a 250k brief; the rows naming this claim's objects were read. Owner's call whether that is acceptable. |
| `[EinsiedlerFish2010]` (`~/source/library/pdf/EinsiedlerFish2010-…pdf`, arXiv:0804.3586v2) | §1 (Thm 1.2), §2 (Thms 2.1–2.2), §3 (Lemmas 3.1, 3.2, proof of Thm 1.2) read in full; §4 not read |
| `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md` | lines 17–19 only (the notation quoted in claims §0) |
| every fenced path | not opened; no grep hit on a fenced file was opened |

### 1.2 Quotation check (standing rule 5)

| quotation in `claims.md` / brief | source | result |
|---|---|---|
| §0 Notation, "`F ⊆ ℝ` a real number field, `L = F(i)`, … `LEDGER.md` rows 98, 113." | J51V brief lines 17–19 (the original); the intermediate copy `plans/FS100-X02D-derivation.md` is fenced | **matches the J51V original verbatim**; the copy in X02D deferred to stage 4 |
| §0 "Added there: `U` acts on `R̂` by `(u·χ)(x) = χ(ux)`; … `h_μ(u)` is the Kolmogorov–Sinai entropy …" | `plans/FS100-X02D-derivation.md` (fenced) | deferred to stage 4 |
| §0 **MR** "for every real number field `F` with `R_F = O′` … (MR(F))." | `LEDGER.md` row 120 | **matches** |
| §0 **Its two halves** "every `U`-invariant `τ` is `a·m + τ′` … (EF_F⁺ …)" and "Not claimed" | `LEDGER.md` row 120 | **matches** (the ellipsis stands for "Einsiedler–Fish's pigeonhole with the rational unit vectors as multipliers and the product formula as the Diophantine step)") |
| §0 G43 "his coordinates span K(√5,√7) (ℚ-span rank **16 of 16**" | `CLAUDE.md` G43 | **matches** |
| (b) **EF_F⁺** "EF_F⁺: for every real number field `F` (with `R = O′`), every `U`-invariant finite positive Borel measure `μ` on `R̂` with `h_μ(u*) = 0` for one non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`; hence EF_F." | `plans/FS100-derivation.md` FS100-EFP (fenced) | deferred to stage 4; consistent with row 120's "one non-torsion `u` of zero entropy puts a `U`-invariant measure on `T + A`" |
| (b) "whose Lemmas 3.1–3.2 it is said to transfer (`LEDGER.md` row 120)" | row 120: "the zero-entropy method is `[EinsiedlerFish2010]` Lemmas 3.1–3.2" | **matches** |
| brief: **EF_F⁰** "`U`-ergodic, `h_μ(u) = 0` for every `u` ⟹ `μ(E) = 1`" ("the advisor's wording") | the advisor's record `plans/POROS-2026-09-26-*` (fenced) | deferred to stage 4; taken from the brief as stated |
| `[EinsiedlerFish2010]` Lemma 3.1: "if hµ(Tp) = 0 for some p ∈ Σ, then for any ε > 0 and any β > 0, there exist δ0 > 0 and X′ ⊂ T of measure µ(X′) > 1 − ε, such that for every positive δ ≤ δ0 and every x ∈ X′, µ(Bδ(x)) > δ^β" | the PDF, p. 3 | read; Lemma 3.2: "if hµ(Tp) = 0 for some p ∈ Σ, then the measure µ has finite support" (p. 4), under (1.1) "lim inf #(Σ ∩ [1, N])/N^α > 0" and ergodicity |

### 1.3 The setting at `F₁ = ℚ(√635087)` (PARI; `tools/fs105_b_setting.py`, output `data/fs105/fs105-b/setting.out`)

- `635087` is **squarefree — it is prime** (`factor` = itself); `x² − 635087` has two real roots: `F₁` is totally real, `[F₁:ℚ] = 2`.
  `635087 ≡ 7 (mod 8)`, `≡ 3 (mod 4)`.
- `L = F₁(i) = ℚ(√635087, i)`, degree 4, `disc L = 6,453,367,961,104`, signature `[0, 2]`: **two complex places, both over real places of
  `F₁`**, and at each the non-trivial automorphism `σ` of `L/F₁` (`i ↦ −i`, `√635087` fixed) is complex conjugation. So `|u|_w = 1` at
  every archimedean `w` for every `u ∈ U`.
- **Dyadic places:** `2 = (𝔓₁𝔓₂)²` in `L`, `e = 2, f = 1`, and `σ` swaps `𝔓₁, 𝔓₂`: **no stable dyadic place**, so `R = ℤ[U] = O′` by
  `LEDGER.md` row 100 (Lemma C′). Plant: at `ℚ(√3)` the one prime of `L` above 2 (`e = f = 2`) is stable — fires.
- **Split and stable primes.** Every prime of `L` above every `p < 60` is split (`𝔓 ≠ σ𝔓`): the `p ≡ 3 (mod 4)` below 60 are inert in
  `F₁` (residue field `𝔽_{p²} ∋ √−1`), the `p ≡ 1 (mod 4)` split in `ℚ(i)`. The first stable primes lie above **103, 107, 127, 163**
  (`p ≡ 3 (mod 4)` split in `F₁`, inert in `L/F₁`, `f = 2`), and above the ramified 635087 (`e = f = 2`, stable).
- Samples: `u₁ = (3+4i)/5` and `u₂ = z/σ(z)`, `z = 1 + i + √635087`, both norm one, `|u| = 1` at both complex places, units at every
  stable prime, non-units at some split prime. Plant: `2 + i` (not in `U`) fails the norm and archimedean tests — fires.

### 1.4 My model of `R̂`

Let `𝒮` = the split finite places of `L` (`𝔓 ≠ σ𝔓`), `L_∞ = L ⊗ ℝ ≅ ℂ²`, `𝔸 = L_∞ × ∏′_{𝔓∈𝒮} L_𝔓` (restricted product w.r.t. `O_𝔓`),
`K_f = ∏_{𝔓∈𝒮} O_𝔓`. `R = O′ = {x ∈ L : v_𝔓(x) ≥ 0 at every stable 𝔓}` is the ring of `𝒮`-integers.

- **M1 (duality).** `Φ : 𝔸 → R̂`, `Φ(x)(r) = ψ_𝒮(xr)` (`ψ_𝒮 = ∏_{v∈𝒮∪∞} ψ_v`, the standard additive characters) is a continuous, open,
  surjective homomorphism with kernel `D ⊂ L` (diagonal), a fractional `R`-ideal (the inverse different localised at the stable places).
  This is S-integer self-duality, here with `𝒮` infinite: `R = ⋃_{S ⊂ 𝒮 finite} O_{L,S}`, `R̂ = lim← Ô_{L,S}`, and each `Ô_{L,S} ≅ 𝔸_S/D_S`.
- **M2 (equivariance).** `(u·Φ(x))(r) = Φ(x)(ur) = ψ_𝒮(xur) = Φ(ux)(r)`: `U` acts on `𝔸` by multiplication, and `uD = D` (`u` is a
  unit of `R`, `ū = u⁻¹ ∈ U ⊂ R`).
- **M3.** `T = Φ(L)` (`nΦ(x) = 0 ⟺ nx ∈ D ⊂ L`, and `D ⊗ ℚ = L`); `A = Φ(L_∞)` (every `ℚ`-linear `L → ℝ` is `Tr_{L_∞/ℝ}(a·)` for a unique
  `a ∈ L_∞`); so **`T + A = Φ(L + L_∞)`**: `x ∈ T + A` iff a (equivalently every) lift `x̃` has finite part in the diagonal `L`.
- **M4 (fundamental domain).** `D + (L_∞ × K_f) = 𝔸` (strong approximation away from `∞`) and `Λ = D ∩ (L_∞ × K_f)` is a lattice in
  `L_∞`; so every `x ∈ R̂` has a lift in `B_∞ × K_f`, `B_∞` bounded.
- **The picture.** `U` acts isometrically on `L_∞` (rotations of `ℂ²`), as units at every stable place (absent from `𝔸`), and by
  `|u|_𝔓 = |u|_{σ𝔓}⁻¹` at split places. The zero-entropy dynamics lives at the split places; the archimedean leaf is neutral.

### 1.5 The statement in my own words

At `F₁`: let `μ` be a finite Borel measure on the compact group `R̂`, invariant under multiplication by every `u ∈ U`, and suppose one
`u* ∈ U` of infinite order acts with Kolmogorov–Sinai entropy zero for `μ`. Then `μ`-almost every character is a torsion character plus
an archimedean one — in adelic terms, its finite part is a global element of `L`. **EF_F⁰** assumes more (entropy zero for every `u`,
and ergodicity) and concludes less (`μ(E) = 1`, `E ⊇ T + A`); it is a corollary of EF_F⁺ whenever `U` has a non-torsion element.

### 1.6 C0, the wrong-reason line, the controls

- **C0 (registered before stage 2's derivation):** EF_F⁺ at `F₁` TRUE with probability **0.85**; EF_F⁰ **0.90**. The step where a failure
  is likeliest: **the lift bookkeeping** — the `𝔓`-coordinate of a point of `R̂` exists only modulo `D`, and `D` is dense in every `L_𝔓`,
  so any statement "the `𝔓₀`-coordinate is rational" must be shown lift-independent; second, the Lemma 3.1 analogue, since `u*` is
  hyperbolic only at finitely many places and neutral at `∞` and at infinitely many split places.
- **Wrong-reason line — a TRUE for a wrong reason would look like:** (W1) a proof that yields local dimension zero, or a Diophantine
  approximation, in the **archimedean** directions (impossible: `U` is isometric there, and the uniform measure on a circle in `A` is
  `U`-invariant, zero-entropy and non-atomic) — such a proof would also "prove" the false statement "finite support"; (W2) a proof that
  uses zero entropy of elements other than `u*` (that proves EF_F⁰-strength, or leans on PE-2); (W3) a Diophantine step that treats the
  `𝔓₀`-coordinate as a function on `R̂`; (W4) a multiplier count or height normalisation that is off, so that the exponent inequality
  between the approximation error and the Liouville bound holds only on paper.
- **Control C-1 (a case with a known answer, `F = ℚ`):** `L = ℚ(i)`, `R = ℤ[i][1/p : p ≡ 1 (4)]` (row 98's `Q`), `A ≅ ℂ`. The statement
  must reduce to a circle-type theorem — EF's Lemma 3.2 on the `S`-adic solenoid — **but its conclusion cannot be EF's "finite support"**:
  `U_ℚ` is dense in `S¹`, so the rotation-invariant probability on `{|a| = r} ⊂ A` is `U`-invariant, isometric (entropy zero), non-atomic
  and supported on `A`. Any derivation that concludes finite support is wrong (W1). This is the sharpness control for `T + A`.
- **Control C-2 (a subgroup for which the conclusion must fail):** `Γ = ⟨u*⟩` (or any finitely generated `Γ ⊂ U`). A single expanding
  automorphism has non-atomic zero-entropy invariant measures off `T + A` (the analogues of ×2's Sturmian measures on the `u*`-expanding
  coordinate), and for rank ≥ 2 the conclusion is Furstenberg's open problem. So the derivation **must** use a property of `U` that no
  finitely generated `Γ` has — I expect it at the pigeonhole: `#{γ ∈ Γ : H(γ) ≤ M} ≍ (log M)^{rank}` against `≥ c·M^κ` for `U`. The
  derivation must name that step.

### 1.7 "Would have searched here" log

| move I would have made by search | what I did instead |
|---|---|
| scan primes up to 10⁵ for all stable places of `L` | read the first four off one exact decomposition loop to 2000 (seconds); none is needed by the proof |

---

## Stage 2 — the derivation at `F₁` (core Steps M1, 0–5; then Step 6, corollary, controls) — SAVED

*Notation of §1.4. `σ` = the non-trivial automorphism of `L/F₁`. On `L` the normalised absolute values `|·|_w` (at a complex `w`,
`|·|_w = |·|_ℂ²`) satisfy the product formula `∏_w |α|_w = 1` (`α ∈ L^×`). `H(α) = ∏_w max(1, |α|_w)`. Four facts, each one line:
(h1) `H(αβ) ≤ H(α)H(β)`; (h2) `H(α⁻¹) = H(α)` (product formula); (h3) `H(α − β) ≤ 16·H(α)H(β)` (`16 = 4^{#complex places}`, from
`|a − b|²_ℂ ≤ 4·max(1,|a|²)·max(1,|b|²)`, ultrametric elsewhere); (h4) **Liouville**: for `α ≠ 0` and any place `w₀`,
`|α|_{w₀} = ∏_{w≠w₀} |α|_w⁻¹ ≥ H(α)⁻¹`.*

### M1 proved (the model is used, so it is derived, not cited)

Let `D := {ℓ ∈ L : ℓ ∈ 𝔡_v⁻¹ at every stable v}` (`𝔡` the different of `L/ℚ`), and `Φ(x)(r) = ψ_𝒮(xr)` as in §1.4.
- **`D ⊆ ker Φ`:** for `ℓ ∈ D, r ∈ R`: `ψ_𝒮(ℓr) = ψ(ℓr)·∏_{v stable} ψ_v(ℓr)⁻¹ = 1·1` (global `ψ` is trivial on `L`; `ℓr ∈ 𝔡_v⁻¹`
  at stable `v` because `r ∈ O_v` there, `R = O′`).
- **`ker Φ ⊆ D`:** let `x ∈ ker Φ`. By strong approximation away from `∞`, `x = d + y` with `d ∈ D`, `y ∈ L_∞ × K_f`. For `r ∈ O_L ⊆ R`,
  `ψ_v(y_v r) = 1` at every split `v` (`ψ_v` is trivial on `𝔡_v⁻¹ ⊇ O_v`), so `ψ_∞(y_∞ r) = 1` for all `r ∈ O_L`: `y_∞` lies in the
  trace-dual lattice, `y_∞ = ℓ₀ ∈ 𝔡⁻¹ ⊆ D`. Then `y′ := y − ℓ₀ ∈ ker Φ` has `y′_∞ = 0`, so `r ↦ ∏_{v∈𝒮} ψ_v(y′_v r)` is a continuous
  character of `𝔸_f^𝒮` trivial on `R`, which is dense in `𝔸_f^𝒮` (strong approximation away from `∞`); hence trivial, hence `y′ = 0`
  (self-duality of `𝔸_f^𝒮`). So `x = d + ℓ₀ ∈ D`.
- **Surjective, open:** `Φ(closure(B_∞) × K_f)` is compact and equals `Φ(𝔸)` (M4), so `Φ(𝔸)` is closed; its annihilator in `R` is 0
  (`a ↦ ψ_∞(ar)` is non-trivial on `L_∞` for `r ≠ 0`); so `Φ(𝔸) = R̂`. Open by the open-mapping theorem (σ-compact LCA groups).
- Consequences used below: `ker Φ = D ⊂ L`; `max(1,|d|_v) ≤ δ_v` for `d ∈ D` at stable `v`, `δ_v = 1` off the finitely many `v | 𝔡`;
  `C_D := ∏_v δ_v`. M2–M4 as in §1.4.

### Step 0 — the expanding place

**Lemma 0.** For every `u ∈ U`: `|u|_w = 1` at every archimedean `w` and every stable `w`; `|u|_𝔓·|u|_{σ𝔓} = 1` at split `𝔓`. If `u` is
non-torsion, some split `𝔓₀` has `|u|_{𝔓₀} > 1`.
*Proof.* `|σx|_w = |x|_{σw}` and `uσ(u) = 1`. Archimedean `w` of `L` are complex over real places of `F₁` with `σ` = complex conjugation
there (§1.3), so `|u|²_ℂ = uū = 1`; stable `w`: `|u|_w² = 1`; split: as stated. If `|u|_𝔓 ≤ 1` at every split `𝔓`, then (pairing `𝔓`
with `σ𝔓`) `|u|_𝔓 = 1` everywhere finite, so `u ∈ O_L^×` with every complex conjugate of modulus 1: a root of unity (Kronecker). ∎

Fix `u*` non-torsion with `h_μ(u*) = 0`, `𝔓₀` as in Lemma 0, `λ := log|u*|_{𝔓₀} > 0`, `S₀ := {𝔓 ∈ 𝒮 : v_𝔓(u*) ≠ 0}` (finite, `∋ 𝔓₀`),
`c* := max_{𝔓∈S₀} |u*|_𝔓`. WLOG `μ(R̂) = 1`.

### Step 1 — neighbourhoods, lift uniqueness, Bowen balls

For `0 < ε < 1`: `Ñ(ε) := {x ∈ 𝔸 : |x_w|_ℂ < ε (w | ∞); |x_𝔓|_𝔓 ≤ ε (𝔓 ∈ S₀); x_𝔓 ∈ O_𝔓 (𝔓 ∈ 𝒮 ∖ S₀)}`, `N(ε) := Φ(Ñ(ε))` (open).

**Lemma 1a.** There is `ε₁ ∈ (0, 1/2]` with `D ∩ (u*Ñ(ε) − Ñ(ε)) = D ∩ (Ñ(ε) − Ñ(ε)) = {0}` for all `ε ≤ ε₁`. In particular `Φ` is
injective on `Ñ(ε)`.
*Proof.* Both sets lie in `{|x_w| < 2ε at ∞; |x_𝔓| ≤ c* on S₀; x_𝔓 ∈ O_𝔓 off S₀}` (`u*` is a unit off `S₀`). Its elements of `D` lie in
`𝔞 := {a ∈ L : v_𝔓(a) ≥ −m (𝔓 ∈ S₀), v_𝔓(a) ≥ 0 (𝔓 ∈ 𝒮 ∖ S₀), a ∈ 𝔡_v⁻¹ (v stable)}` with `N𝔓^m ≥ c*` — a fractional `O_L`-ideal,
hence a lattice in `L_∞`. With `r_𝔞 := min{max_w|a|_ℂ : a ∈ 𝔞 ∖ 0} > 0` take `ε₁ := min(1/2, r_𝔞/4)`: then `max_w |d|_ℂ < 2ε ≤ r_𝔞/2`
forces `d = 0`. ∎

**Lemma 1b (Bowen balls are thin at `𝔓₀`).** Let `ε ≤ ε₁`, `n ≥ 1`, `z ∈ R̂` with `u*^i z ∈ N(ε)` for `0 ≤ i ≤ n−1`. Then the unique
`z̃ ∈ Ñ(ε)` with `Φ(z̃) = z` has `u*^i z̃ ∈ Ñ(ε)` for `0 ≤ i ≤ n−1`, hence `|z̃_{𝔓₀}| ≤ ε·e^{−(n−1)λ}`.
*Proof.* Induction on `i`. If `u*^i z̃ ∈ Ñ(ε)` and `u*^{i+1}z = Φ(ã)`, `ã ∈ Ñ(ε)`, then `u*^{i+1}z̃ − ã ∈ D ∩ (u*Ñ(ε) − Ñ(ε)) = {0}`
(Lemma 1a, M2). Finally `e^{(n−1)λ}|z̃_{𝔓₀}| = |u*^{n−1}z̃_{𝔓₀}| ≤ ε`. ∎

Set `W̃_n := {w ∈ Ñ(ε₁) : |w_{𝔓₀}| ≤ ε₁e^{−(n−1)λ}}`, `W_n := Φ(W̃_n)` (σ-compact image, Borel).

### Step 2 — zero entropy gives zero dimension along `𝔓₀` (EF Lemma 3.1, transferred)

**Lemma 2.** For every `β > 0` and `η > 0` there are a Borel `X′ ⊆ R̂` with `μ(X′) > 1 − η` and `N₁` such that for all `x ∈ X′` and
`n ≥ N₁`: `μ(x + W_n) ≥ e^{−nβ}`.
*Proof.* `ε := ε₁`, `ε′ := ε/2`: `Ñ(ε′) − Ñ(ε′) ⊆ Ñ(ε)` (strict `< 2ε′ = ε` at `∞`, ultrametric elsewhere). `R̂` is compact:
`R̂ = ⋃_{k≤K} (y_k + N(ε′))`; `P_k := (y_k + N(ε′)) ∖ ⋃_{j<k}(y_j + N(ε′))` is a finite Borel partition `ξ` with
`P_k − P_k ⊆ Φ(Ñ(ε′) − Ñ(ε′)) ⊆ N(ε)`. Let `ξ_n(x) := ⋂_{i<n} u*^{−i}ξ(u*^i x)`. If `y ∈ ξ_n(x)`, then
`u*^i(y − x) ∈ P − P ⊆ N(ε)` for `i < n`, so `y − x ∈ W_n` (Lemma 1b): **`ξ_n(x) ⊆ x + W_n`**. `R̂` is compact metrisable (`R`
countable), `u*` is an invertible `μ`-preserving homeomorphism, `H_μ(ξ) ≤ log K`. Non-ergodic Shannon–McMillan–Breiman (EF Thm 2.1):
`−(1/n) log μ(ξ_n(x)) → h_{μ_x^E}(u*, ξ)` a.e., where `μ_x^E` is the `u*`-ergodic component; Jacobs: `∫ h_{μ_x^E}(u*) dμ = h_μ(u*) = 0`,
so `0 ≤ h_{μ_x^E}(u*, ξ) ≤ h_{μ_x^E}(u*) = 0` a.e. Egorov on `g_N(x) := sup_{n≥N} −(1/n) log μ(ξ_n(x)) ↓ 0` a.e. gives `X′`, `N₁` with
`g_{N₁} < β` on `X′`. ∎

**Note (W2 check):** only `u*`'s entropy is used, and only here.

### Step 3 — the multipliers (the one property of `U` no finitely generated subgroup has)

`q_s := (s + i)/(s − i) ∈ U_ℚ ⊆ U` for `s ∈ ℤ_{≥1}` (norm one: `q_s·σ(q_s) = q_s·q̄_s = 1`); distinct for distinct `s`
(`(s+i)(s′−i) = (s′+i)(s−i) ⟹ 2(s′ − s)i = 0`). `|q_s|_ℂ = 1`; at finite places of `ℚ(i)`, `max(1,|q_s|_v) > 1` only where
`v(s − i) > v(s + i)`, so `H_{ℚ(i)}(q_s) ≤ N(s − i) = s² + 1`, and `H(q_s) = H_{ℚ(i)}(q_s)^{[L:ℚ(i)]} ≤ (s²+1)²` (normalised values:
`∏_{w|v} max(1,|α|_w) = max(1,|α|_v)^{[L:ℚ(i)]}` for `α ∈ ℚ(i)`). So with **`κ := 1/4`** (in degree `d`, `κ = 1/(2d)`):
`#{s : H(q_s) ≤ M} ≥ ⌊(M^{1/2} − 1)^{1/2}⌋ ≥ ½·M^κ` for `M ≥ M₀`. (`tools/fs105_b_heights.py` H1, H3.)
For `Γ = ⟨γ⟩` finitely generated of rank `r` the same count is `≍ (log M)^r`: **this is where control C-2 must break the proof** (Step 4).

### Step 4 — the pigeonhole (EF Lemma 3.2, first half, transferred)

Fix `x ∈ X′` and a lift `x̃ ∈ B_∞ × K_f` (`|x̃_w|_ℂ ≤ B` at both complex places; M4). Let `n ≥ N₁`, `M(n)` the least `M ≥ M₀` with
`½M^κ > e^{nβ}` (so `M(n) ≤ C_M e^{nβ/κ}`, `C_M` independent of `n` and `x`), `Q_n := {q_s : H(q_s) ≤ M(n)}`, `#Q_n > e^{nβ}`.
Each `q ∈ Q_n` is a `μ`-preserving automorphism of `R̂`, so `μ(q(x + W_n)) = μ(x + W_n) ≥ e^{−nβ}`; `#Q_n·e^{−nβ} > 1 = μ(R̂)`, so
**there are `q ≠ q′` in `Q_n` and `w, w′ ∈ W_n` with `q(x + w) = q′(x + w′)`.** Lift `w, w′` to `w̃, w̃′ ∈ W̃_n`; by M2 and M1,
`d := q(x̃ + w̃) − q′(x̃ + w̃′) ∈ D`. Put **`ℓ_n := d/(q − q′) ∈ L`**. Then `x̃ − ℓ_n = (q′w̃′ − qw̃)/(q − q′)` at every place, and:
- **(E1)** `|x̃_{𝔓₀} − ℓ_n|_{𝔓₀} ≤ max(|q|,|q′|)_{𝔓₀}·ε₁e^{−(n−1)λ}·|q − q′|_{𝔓₀}⁻¹ ≤ M·ε₁e^{−(n−1)λ}·16M² = 16ε₁e^{λ}·M³·e^{−nλ}`
  (`|q|_{𝔓₀} ≤ H(q) ≤ M`; (h4) and (h3) for `q − q′`).
- **(E2)** `H(ℓ_n) ≤ H(d)·H(q − q′) ≤ H(d)·16M²` ((h1), (h2)). And `d = (q − q′)x̃ + qw̃ − q′w̃′`: at each complex `w`,
  `|d|_ℂ ≤ 2B + 2`; at split `𝔓` (all of `x̃_𝔓, w̃_𝔓, w̃′_𝔓 ∈ O_𝔓`), `|d|_𝔓 ≤ max(1,|q|_𝔓)·max(1,|q′|_𝔓)`; at stable `v`,
  `max(1,|d|_v) ≤ δ_v`. So `H(d) ≤ (2B+2)⁴·C_D·H(q)H(q′) =: C_d·M²` and **`H(ℓ_n) ≤ 16C_d·M⁴`**.
- The archimedean coordinate of `x̃` is only **bounded**, never approximated (W1 respected): `|q − q′|` may be tiny at `∞`, and that
  smallness is paid for inside `H(q − q′)`, not assumed away.

### Step 5 — stabilisation (EF Lemma 3.2, second half; the product formula is the Diophantine step)

With `M = M(n)`: `|x̃_{𝔓₀} − ℓ_n| ≤ C₁e^{n(3β/κ − λ)}` and `H(ℓ_n) ≤ C₂e^{4nβ/κ}` (`C₁, C₂` independent of `n` and `x`). **Choose
`β := κλ/12`** (fixed before Lemma 2 is invoked). If `ℓ_n ≠ ℓ_{n+1}`, (h4) and (h3) give
`(16C₂²e^{4β/κ})⁻¹e^{−8nβ/κ} ≤ H(ℓ_n − ℓ_{n+1})⁻¹ ≤ |ℓ_n − ℓ_{n+1}|_{𝔓₀} ≤ C₁e^{n(3β/κ − λ)}`, i.e.
`1 ≤ 16C₂²C₁e^{4β/κ}·e^{n(11β/κ − λ)} = C₃e^{−nλ/12}`, false for `n ≥ N₂`. So `ℓ_n = ℓ` for all `n ≥ max(N₁, N₂)`, and
`|x̃_{𝔓₀} − ℓ| ≤ C₁e^{−3nλ/4} → 0`: **`x̃_{𝔓₀} = ℓ ∈ L`** (the diagonal image).

**Lemma 5 (one place is global).** `G := {x ∈ R̂ : x̃_{𝔓₀} ∈ L}` is well defined (a change of lift adds `d ∈ D ⊂ L`) and `μ(G) = 1`.
*Proof.* Every `x ∈ X′` lies in `G`; `μ(X′) > 1 − η` with `η` arbitrary (and `G` Borel, Step 6). ∎

### Step 6 — from one global place to `T + A` (not in EF: the circle has one place)

**Lemma 6a.** Let `𝔸^{(𝔓₀)} := {y ∈ 𝔸 : y_{𝔓₀} = 0}` (a closed subgroup). `Ψ : (L/D) × 𝔸^{(𝔓₀)} → R̂`, `Ψ(ℓ + D, y) := Φ(ℓ + y)`, is a
continuous injective `U`-equivariant map with image `G`. Hence `G` is Borel and `π_Y := pr₂ ∘ Ψ⁻¹ : G → 𝔸^{(𝔓₀)}` is Borel and
`U`-equivariant.
*Proof.* Well defined (`D ⊆ ker Φ`). Image: `x ∈ G`, `x̃_{𝔓₀} = ℓ`, `y := x̃ − ℓ`. Injective: `ℓ − ℓ′ + y − y′ = d ∈ D` read at `𝔓₀`
gives `ℓ − ℓ′ = d` in `L_{𝔓₀}`, all three global, so `ℓ − ℓ′ = d` in `L`, `y = y′`, `ℓ ≡ ℓ′ (mod D)`. Lusin–Souslin (the domain is
Polish: `L/D` countable discrete). Equivariance: `u·Φ(ℓ + y) = Φ(uℓ + uy)`, `uL = L`, `uD = D`, `u𝔸^{(𝔓₀)} = 𝔸^{(𝔓₀)}`. ∎

**Lemma 6b.** For every split `𝔔 ≠ 𝔓₀` there is `u ∈ U` with `|u|_𝔔 ≠ 1`; and a finite measure on `L_𝔔` invariant under `t ↦ ut`
with `|u|_𝔔 ≠ 1` is a multiple of `δ₀`.
*Proof.* `𝔔 ≠ σ𝔔` are distinct maximal ideals, so some `z ∈ O_L` has `z ∈ 𝔔 ∖ σ𝔔`; `u := z/σ(z)` has `uσ(u) = 1` and
`v_𝔔(u) = v_𝔔(z) − v_{σ𝔔}(z) = v_𝔔(z) ≥ 1` (no class number needed; `tools/fs105_b_heights.py` H5 exhibits one at a split prime above
3, which no rational unit vector reaches). Replace `u` by `u⁻¹` so `ρ := |u|_𝔔 < 1`. The shells `A_k := {ρ^{k+1} < |t| ≤ ρ^k}` (`k ∈ ℤ`)
partition `L_𝔔 ∖ {0}` and `uA_k = A_{k+1}`; invariance gives all `ν(A_k)` equal, and `Σ_k ν(A_k) < ∞`. ∎

**Theorem (EF_F⁺ at `F₁`).** `μ(R̂ ∖ (T + A)) = 0`.
*Proof.* `ν := (π_Y)_*(μ|_G)` is a finite `U`-invariant Borel measure on `𝔸^{(𝔓₀)}` (`μ(G) = 1`, `uG = G`). For each split `𝔔 ≠ 𝔓₀`,
push `ν` to `L_𝔔` (continuous, equivariant) and apply Lemma 6b: `ν(y_𝔔 ≠ 0) = 0`. `𝒮` is countable, so `ν`-a.e. `y` has every finite
coordinate zero, i.e. `y ∈ L_∞`. Hence `μ`-a.e. `x ∈ G` is `Φ(ℓ) + Φ(y) ∈ T + A` (M3). ∎

**Where each hypothesis is used.** `R = O′`: M1 (the model and `ker Φ = D ⊂ L`). `F₁` totally real: Lemma 0 and Step 4 (`|q| = 1` at
`∞`). `u*` non-torsion: Lemma 0 (`λ > 0`). `h_μ(u*) = 0`: Lemma 2 only. `U`-invariance: Step 4 (the multipliers `q_s`) and Step 6 (the
contractions `z/σz`). **Polynomial growth of `U` by height: Step 4 only** (control C-2). Ergodicity: nowhere.

### Corollary — EF_F⁰ at `F₁`

**EF_F⁰ ("`U`-ergodic, `h_μ(u) = 0` for every `u` ⟹ `μ(E) = 1`").** `u₁ = (3+4i)/5 ∈ U` is non-torsion (it is a non-unit at a split
prime above 5; `tools/fs105_b_setting.py` S3), so the theorem with `u* := u₁` gives `μ(T + A) = 1`, and `T + A ⊆ E` (the `S = ∅` term).
Ergodicity and the entropy of every `u ≠ u₁` are unused. Its truth therefore stands or falls with the theorem's proof, but it needs
strictly less of it: **any** single non-torsion `u` of zero entropy, and its conclusion `E` is weaker than `T + A`.

### Controls, run

- **C-1 (`F = ℚ`).** Every step runs verbatim with `L = ℚ(i)`, `𝒮` = the places above `p ≡ 1 (mod 4)`, `R = ℤ[i][1/p : p ≡ 1 (4)]`,
  `κ = 1/2` (`d = 1`), and concludes `μ(T + A) = 1`, `A ≅ ℂ` — never finite support: Step 4 bounds `x̃_∞` (by `B`) and never approximates
  it, and Step 6 kills only finite coordinates. The rotation-invariant circle measures in `A` are `U_ℚ`-invariant, zero-entropy,
  non-atomic, and lie in `T + A`: consistent, and they show the conclusion cannot be sharpened to `T`. **Passes (W1 excluded).**
- **C-2 (`Γ = ⟨u*⟩`).** The proof breaks exactly at Step 4: `#{k : H(u*^k) ≤ M} ≍ log M`, so `#Q > e^{nβ}` needs `M ≈ exp(e^{nβ})`, and
  then (E1)'s `M³e^{−nλ}` diverges. H3 measures it: at `n = 400`, the requirement is `4.46·10¹¹` multipliers; the `U_ℚ` family supplies
  `5.3·10¹¹` at `M = 32e^{nβ/κ}`, the cyclic group `69.8`. The same holds for every finitely generated `Γ` (`(log M)^rank`), consistent
  with ×2×3 being open. **Passes: the growth of `U` is used at one named step.**

### Exact checks (`tools/fs105_b_heights.py`, output `data/fs105/fs105-b/heights.out`; `tools/fs105_b_setting.py`, `setting.out`)

| check | result | plant, and why it fires |
|---|---|---|
| H1 `H(q_s) ≤ (s²+1)²`, `s ≤ 12` (e.g. `H(q_2) = 25`, `H(q_{12}) = 21025 = 145²`) | pass | P1 the `ℚ(i)`-height bound `(s²+1)` fails (the `[L:ℚ(i)] = 2` exponent) — fires |
| H2 Liouville at `𝔓₀` (`N𝔓₀ = 25`, `|q_2|_{𝔓₀} = 25`) and (h3), 21 differences `q_s − q_t` | pass | P2 dropping the archimedean factor breaks Liouville for `17³` at a prime above 17 — fires |
| H3 growth: `#{s : (s²+1)² ≤ 10¹⁶} = 9999` vs `#{k : H(q_2^k) ≤ 10¹⁶} = 23` | pass | the cyclic group fails Step 4's requirement — fires |
| H4 `β = κλ/12`: exponents `−3/4·λ`, `−1/12·λ` | pass | P4 `β = κλ/5` gives `+6/5·λ` — fires |
| H5 split `𝔔 | 3`: `u = z/σz ∈ U`, `v_𝔔(u) = 1` | pass | P5 `z = 3 ∈ 𝔔 ∩ σ𝔔` gives `v_𝔔 = 0` — fires |

**Tool slip, mine:** H3's first run failed because I took `M(n) = 16e^{nβ/κ}`, which meets `½M^{1/4} > e^{nβ}` with equality, not
strictly; `C_M > 16` is what Step 4 states. Fixed to 32; not a proof defect.

### The invariant the proof runs on (G72, G79)

An **example invariant of the acting group**: `U` has at least `½M^{1/(2d)}` elements of height `≤ M` — a counting property every
finitely generated subgroup lacks — against the **measure's invariant**: zero local dimension along one expanding place of `u*`
(Shannon–McMillan–Breiman). The product formula (Liouville at one place) turns their collision into a global point; the contractions
`z/σz`, one per split place, spread "global at one place" to "global at every finite place". Nothing about colourings enters.

### Stage-2 "would have searched here" log

| move | instead |
|---|---|
| search the multiplier family for the densest set of bounded height | the explicit family `(s+i)/(s−i)` with a one-line height bound |
| search for a `u ∈ U` non-unit at a split prime above 3 | one `z ∈ 𝔔 ∖ σ𝔔` read off the ideal's basis |

---

## Stage 3 — the write-up (committed before anything fenced was opened) — SAVED

| claim | verdict | grade | minds (this job) |
|---|---|---|---|
| **EF_F⁺ at `F₁ = ℚ(√635087)`** (`claims.md` (b), verbatim there) | **TRUE** | [hand]; its arithmetic inputs [tools exact] (`tools/fs105_b_setting.py`, `tools/fs105_b_heights.py`, every plant firing) | one, blind to X01D, X12B, X01V |
| **EF_F⁰ at `F₁`** ("`U`-ergodic, `h_μ(u) = 0` for every `u` ⟹ `μ(E) = 1`") | **TRUE** — a corollary of the above with `u* = (3+4i)/5`; ergodicity unused | [hand] | one, blind |

- **The proof in one paragraph.** Model `R̂ = 𝔸_𝒮/D` (split places and `∞`; `ker Φ = D ⊂ L`, derived). A non-torsion `u*` expands at a
  split place `𝔓₀` (Kronecker). Zero entropy of `u*` alone gives, by Shannon–McMillan–Breiman, `μ(x + W_n) ≥ e^{−nβ}` for Bowen
  neighbourhoods `W_n` that are thin (`e^{−nλ}`) at `𝔓₀` and merely bounded elsewhere, including at `∞`. The rational unit vectors
  `(s+i)/(s−i)` give `≥ ½M^{1/4}` automorphisms of height `≤ M`; the pigeonhole makes two translates collide, and the collision is a global
  `ℓ_n ∈ L` with `|x̃_{𝔓₀} − ℓ_n| ≤ C₁e^{−3nλ/4}` and `H(ℓ_n) ≤ C₂e^{nλ/3}`; Liouville at `𝔓₀` freezes `ℓ_n`, so the `𝔓₀`-coordinate is
  global. Then each other split place is killed by a contraction `z/σz ∈ U`: a finite measure invariant under a contraction of `L_𝔔` sits
  at 0. What is left is `T + A`.
- **Hardest step:** Lemmas 1a–1b — making the entropy of a `u*` that is neutral at `∞` and at infinitely many split places speak about
  one coordinate that exists only modulo `D`, which is dense in `L_{𝔓₀}`. The lift is unique on a small neighbourhood because `D`
  meets a bounded set in a lattice point only; that is what makes the Bowen ball thin at `𝔓₀`. It was the step C0 named; it holds.
- **C0 scored:** registered 0.85 TRUE (EF_F⁺), 0.90 (EF_F⁰); both TRUE. Wrong-reason line: W1 excluded (the archimedean coordinate is
  bounded and never approximated; C-1 passes); W2 excluded (only `u*`'s entropy, only in Lemma 2); W3 excluded (Lemma 5's `G` is
  lift-independent because `D ⊂ L`); W4 checked exactly (H1–H4, with a boundary slip of my own in H3's constant, fixed).
- **Scope remarks (not claimed, for the owner):** (i) nothing in Steps 0–6 reads `[F:ℚ] = 2` except `κ = 1/(2d)`; any `κ > 0` works,
  so the argument runs verbatim at every **totally real** `F` with `R = O′` — at `F_dG` (degree 16) with `κ = 1/32`, which bears on
  claim (c)'s "whatever size of that count the zero-entropy argument needs": **any positive power**. (ii) Off the totally real fields
  Lemma 0 changes (a non-torsion `u` may expand only at an archimedean place); not examined. (iii) Step 6 (one global place ⟹ `T + A`)
  is a stand-alone lemma that uses only `U`-invariance, not entropy.
- **Proposed for the close (not written by me):** `LEDGER.md` row 120's grade line — "EF_F⁺ … a third derivation blind to the others
  (FS105-B), TRUE at ℚ(√635087)", with FS105-B's divergences from stage 4; `LEDGER.md` § B: FS105-B-M1, -L5, -L6, -EFP, -EF0.

---

## Stage 4 — divergences from X01D §3, X12B §2, X01V §2.3 and §4 (read only after `85c2eb2e`, stage 3) — SAVED

**Deferred quotations, now checked.** `claims.md` (b)'s EF_F⁺ matches `plans/FS100-derivation.md` line 160 (FS100-EFP) verbatim; §0's
"Added there" matches `plans/FS100-X02D-derivation.md` lines 12–13 ("Added here: …") verbatim. The brief's EF_F⁰ ("`U`-ergodic,
`h_μ(u) = 0` for every `u` ⟹ `μ(E) = 1`") is an abbreviation of X01V §2.3's "**EF_F⁰:** every `U`-invariant, `U`-ergodic probability measure
`μ` on `R̂` with `h_μ(u) = 0` for every `u ∈ U` satisfies `μ(E) = 1`" — same content; the advisor's own record was not opened.

| step | FS105-B (mine) | X01D §3 | X12B §2 | truth |
|---|---|---|---|---|
| model | `R̂ = 𝔸_𝒮/D`, `ker Φ = D` **derived** (M1) | `W/Λ`, `Λ = R^∨` (§2.0, not read) | `𝔸_S/Λ′`, Tate duality, annihilator in one line | same model; none |
| expanding place | Lemma 0, totally real only (`F₁`) | split or archimedean `v*`, every real `F` | `P⁺` split or archimedean | none at `F₁` |
| Bowen atoms thin at one place | lift uniqueness in `𝔸`: `D ∩ (u*Ñ − Ñ) = 0` (Lemma 1a) | Lemma PF with `ε` chosen against `u*` | pass to `X_Q = R̂/K_Q`, injectivity radius | same lattice-gap mechanism; none |
| multipliers | explicit `(s+i)/(s−i)`, `κ = 1/(2d)` | all of `U_ℚ`, Lehmer, `α = 1/d` | same, `4X/π` checked | mine weaker exponent, self-contained; any `κ > 0` suffices in all three; none |
| Diophantine step | divide first: `ℓ_n = d/(q − q′)`; `|q−q′|`'s smallness at `∞` paid inside `H(q−q′)`; Liouville at `𝔓₀` | multiply through (`z = ℓ₂r₁ − ℓ₁r₂`, `x̃` cancels), divide once at `v*` by Lemma PF | divide; explicit lower bounds `|q₁−q₂|_v ≥ X^{−2}` at `∞`, a lift-dependent height `H′` | three bookkeepings of one product-formula argument; none |
| scales | consecutive `n`, `M(n) ≍ e^{nβ/κ}` | `M, M², M⁴, …` | `X, X², X⁴, …` | none |
| places made global | one (`𝔓₀`) | one (`v*`) | all of `P⁺` | none |
| the other places | direct-sum coordinates `Ψ`; `π_Y` is `U`-equivariant, so no stabilisers; contraction `z/σz` with `z ∈ 𝔔 ∖ σ𝔔` (no class number) | leaves per torsion `t`, finite-index stabilisers `U_t`, class number | Lemma Z: `T × 𝔸_{S∖P}`, `ord_w` push-forward, class number | same shells mechanism; mine and X12B's avoid stabilisers; none |

**Differences of truth: none.** **X01V's blind GAP ("UZ", §2.3 items 2–4)** assumed the translates must stay small at every place and
worried that `|u₁ − u₂|_∞` amplifies the archimedean error. My proof, written blind to X01V, meets both exactly as X01V §4.2 concedes X01D
does: fat places are paid for by the multipliers' heights (Step 4, (E2)), and the archimedean coordinate is bounded, never approximated,
with `|q − q′|_∞` absorbed in `H(q − q′)` (h2, h3). I found no failing line in X01D §3 or X12B §2.

**Blindness, honestly stated.** The route's outline was open to me and I knew it (row 120: "Einsiedler–Fish's pigeonhole with the rational
unit vectors as multipliers and the product formula as the Diophantine step"; G76's *Do*). The step that made the other places vanish
(X01D's "wandering shells", X12B's Lemma Z) was **not** in any open source; my Step 6 found it independently. The proof, every quantifier
and constant, is mine.

**Count of minds for EF_F⁺ at `F₁` after this job:** three derivations blind to one another (X01D, X12B, FS105-B) and one checking reading
(X01V stage 4). Grade [hand].

**Scratchpad fence (owner's clarification, received after stage 4):** in the shared harness scratchpad I created and opened only my own
two files, `ef.txt` (pdftotext of `[EinsiedlerFish2010]`) and `st.gp` (the stable-prime loop of §1.3), written directly at the scratchpad's
top level. I never listed, grepped or opened any other file there. No slip to log.
