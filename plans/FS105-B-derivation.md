# FS105-B — a blind third derivation of EF_F⁺ at ℚ(√635087) (and EF_F⁰)

*Job FS105-B (Coxeter), FS-105 "harden MR", 2026-09-26. Brief: `data/fs105/briefs/B105-blind-efp.md`; standing rules
`data/fs105/briefs/STANDING-RULES.md`; claim (b) of `data/fs105/claims.md`. Blind until stage 3 is committed: nothing on the
brief's fence list opened before then.*

## Theorems this phase proved

*(filled at stages 2–3; one line each, grade, address)*

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
