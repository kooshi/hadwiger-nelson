# FS-100 / crunch ×2×3 — job X27D: TR-ROT and its flip (derivation record)

*de Bruijn (Opus 5.5), job X27D, 2026-09-26, from 11:52 UTC. Brief: `data/crunch-2026-09-26-x2x3/briefs/X27D-tr-rot-derivation.md`
(with `STANDING-RULES.md`, its clock replaced by the brief's stop, 12:50 UTC). Working files `data/fs100/x27d/`; checks `tools/x27d_*.py`.
One mind. A blind verifier, X27V, works on the same claims; no contact.*

## Theorems this phase proved

*(Filled at each stage; grades as `CLAUDE.md` § Notation.)*

| id | statement (one line) | grade | address |
|---|---|---|---|
| X27D-EQ | given MR, TR-ROT ⟺ Q-μ ⟺ `M′ = ∅` at type (B): the "one step" is the whole measure half | [hand, one mind; from X22D-RT] | Stage 2, §2.1 |
| X27D-L0 | `μ ∈ M_T` is carried by Pull iff `σ_μ(T₄) = 1` (`T₄ = (R ∩ 𝔓⁴)^⊥`) | [hand] | §2.2 |
| X27D-PC | given MR, the `U`-averages of `σ_μ` restricted to any `U`-invariant Borel set converge onto `T₄`, along every Følner sequence | [hand, one mind] | §2.3 |
| X27D-TA | given MR, `σ_μ((T + A) ∖ T₄) = 0` for every `μ ∈ M_T` (isometric places never approach `T₄`) | [hand, one mind] | §2.4 |
| X27D-SPL | for every finite measure on characters of `E_S` with a non-zero component at a split `v ∈ S`, some Følner sequence of `U` carries its `U`-averages to a multiple of Haar (hyperbolic shift at `v` + Ramanujan vanishing on `O_v^×`) | [hand, one mind; the local vanishing checked exactly in a finite model, `tools/x27d_ramanujan.py`, plant watched] | §2.5 |
| X27D-E | **given MR, over a type-(B) field every translation-invariant random four-colouring has `σ_μ|_E = σ_μ|_{T₄}`**; corollary: Theorem C's conclusion for spectra carried by all of `E` | [hand, one mind] | §2.5 |
| X27D-ATT | given MR, a counterexample to Q-μ has an `E`-null, Haar-singular, `T₄`-attracted spectral remainder, an `I`-periodic conditional colour law, and a defect profile on `R ∩ 𝔓⁴` that is subadditive, not zero, and Banach-negligible on every rotation circle | [hand, one mind] | §2.6, §3.1 |
| X27D-FL | given MR, every concave (in particular affine), `U`-invariant, upper-semicontinuous `Q ≥ 0` on `M_T` vanishing on the Pull-measures vanishes on all of `M_T`; so such a `Q` witnesses the flip iff `M′ = ∅`, and without MR its existence proves TR-ROT | [hand] | §3.2 |
| X27D-FLit | TR-ROT-flip as worded is TRUE with a trivial witness (an affine, weak-* continuous window-defect series), which is not rotation-invariant and proves nothing | [hand] | §3.2 |

## Stage 1 — SAVED (quotation check; C0 per claim, sealed before any derivation)

### 1.1 The claims, verbatim from the brief

- **TR-ROT** (brief, "from `plans/FS100-X22D-derivation.md` §2.4"): "Over a type-(B) field, no translation-invariant random four-colouring `μ`
  with `μ(Pull) = 0` has every `U`-Følner average converge onto Pull" (equivalently, by X22D-RT: none is rotationally transient).
- **TR-ROT-flip** (brief, "G79's move, posed by the owner"): "Every translation-invariant random four-colouring `μ` of a type-(B) field's plane
  carries a quantity, invariant under translation and continuous under weak-* limits, that is zero on Pull and positive whenever `μ(Pull) = 0`."
  Name one such quantity, or show that none of a stated kind can exist.

### 1.2 Quotation check (standing rule 5)

| quotation | source checked | result |
|---|---|---|
| TR-ROT | `plans/FS100-X22D-derivation.md` §2.4 (lines "> **TR-ROT.** …") | **verbatim**, including the parenthesis |
| X22D-RT, X22D-QR, X22D-TRM, X22D-EF, X22D-FLK2 (used below) | same file §2.2, §2.3, §3.1, §4.1 | read from source |
| "X22D and X22V (blind) named the step independently" (brief) | `plans/FS100-X22V-verification.md` §2.2 | **true in substance, not in words**: X22V's GAP is "a translation-invariant `μ` with `μ(Pull) = 0` has an `R ⋊ U`-invariant weak-* limit with `ν(Pull) < 1`" — the negation-free form of TR-ROT; same step |
| TR-ROT-flip | posed in the brief; its nearest held source is X22V §2.2: "**a continuous, affine, `U`-invariant functional on `M_T` that vanishes on the Pull-measures and is positive on `M′`**" | **the flip drops two of X22V's three qualifiers** ("affine", "`U`-invariant") and keeps a third that is vacuous on its domain ("invariant under translation": every `μ` in question is translation-invariant). As worded the flip has a trivial witness (Stage 3). I answer the literal flip and the form X22V named (the one that would prove TR-ROT), separately |
| Row 111 (Q-μ, Q-tr), row 112 (Theorem C), row 113, row 120 (MR) | `LEDGER.md` rows 111, 112, 113, 120 | read from source (first 900 characters of each; MR's statement read in full in row 120) |
| MR(F) | row 120: "every `U_F`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure (MR(F))" | verbatim; C-0 (X22D Stage 1) puts ℚ(√59), ℚ(√83), ℚ(√131) inside its scope |

### 1.3 C0 — probabilities before derivation (11:58 UTC, sealed)

| claim | P(TRUE) | P(FALSE) | P(GAP at a named step) | the step I expect to decide it |
|---|---|---|---|---|
| TR-ROT | 0.10 | 0.03 | 0.87 | FALSE is a colouring outside Pull, i.e. row 88's "no" — out of reach in an hour. TRUE needs a way from translation- to rotation-invariance; I expect to be able to push the counterexample's **spectrum** off every part of `E` by the dynamics of `U` on `R̂` (isometric at the archimedean and stable places, hyperbolic at the split ones) and to be stopped by the `E`-null part |
| TR-ROT-flip, literal | 0.90 | 0.02 | 0.08 | as worded ("invariant under translation", no rotation-invariance, no affineness) a weak-* distance to the Pull-measures is a witness; the flip is then empty |
| TR-ROT-flip, X22V's form (affine, `U`-invariant, upper semicontinuous) | 0.10 | 0.05 | 0.85 | such a functional proves TR-ROT outright, so it is as hard as TR-ROT; I expect "no functional of a stated **spectral** kind" to be provable |

### 1.4 Would have searched here (Stage 1)

- None.

## Stage 2 — SAVED (TR-ROT: GAP at NA₀, with the counterexample's shape; `E` is closed off)

**Verdict. TR-ROT: GAP**, at one named step, **NA₀** (§2.6). Given MR, TR-ROT is all of Q-μ (X27D-EQ), and a counterexample's spectrum is
pinned: on `E` it is exactly Pull's (X27D-E) — the torsion, archimedean and every finitely-many-split-places part is closed off by the
dynamics of `U` on `R̂` — so what is left is an `E`-null spectral remainder that every rotation average carries onto the finite set `T₄`.
**No FALSE:** a counterexample is a translation-invariant random four-colouring outside Pull, i.e. row 88's "no" (R88-TA2). **No TRUE:** the
per-place method needs finitely many places, and an `E`-null character reads infinitely many.

**Notation** (X22D §2; J45): `F` of type (B); `L = F(i)`; `R = ℤ[U] = O′`; `𝔓` the stable dyadic prime (inert in `L/F`, X22D-C0);
`I := R ∩ 𝔓⁴`; `T₄ := I^⊥ ⊂ R̂`, the characters trivial on `I`, a finite group (`|R/I| = |O/𝔓⁴| = 4⁴`); Pull the pullbacks of row 67's `P₄`,
i.e. the proper colourings of `Cay(R, U)` that factor through `R/I`; `M_T`, `M_Aff` the `R`-, resp. `R ⋊ U`-invariant probabilities on `X₄`;
`M′ := {μ ∈ M_T : μ(Pull) = 0}`; `g(x) = e_{c(x)}` (tetrahedron, `⟨e_j, e_l⟩ = (4/3)δ_{jl} − 1/3`); `σ_μ` its trace spectral measure.
`U` acts on `R̂` by `(w·χ)(y) := χ(w⁻¹y)`, and on colourings by `(w·c)(x) := c(w⁻¹x)`; then `σ_{w_*μ} = w_*σ_μ`. `T` = torsion characters
(countable; each has a finite `U`-orbit, since `R/NR ≅ ∏_{stable 𝔮 | N} O/𝔮^k` is finite); `A` = archimedean characters
`y ↦ e(Tr(a·y))`, `a ∈ L ⊗ ℝ ≅ ℂ²`; `E_S = T + A + Fin_S`, `E = ⋃_S E_S`. The decomposition `x = t + a + Σ_{v∈S} x_v` of `x ∈ E_S` is unique
(`R` is dense in `∏_{stable} O_𝔮 × (L⊗ℝ) × ∏_{v∈S} L_v` by strong approximation away from one non-stable place `v₀ ∉ S`, so the dual map is
injective; the same density X22D-EF uses). `T` and `T₄` and `A` are `U`-invariant: `w I = I` because `w` is a `𝔓`-unit (`𝔓` stable, `ww̄ = 1`).

### 2.1 X27D-EQ — given MR, TR-ROT is Q-μ, not a sub-step of it [hand, one mind]

Given MR (at X22D-QR's inputs), every `μ ∈ M_T` has every `U`-Følner average converging (along every convergent subsequence) onto Pull
(X22D-RT's proof). So "no `μ ∈ M′` has every `U`-Følner average converge onto Pull" ⟺ `M′ = ∅`. And Q-μ ⟺ `M′ = ∅` (if `0 < μ(X₄ ∖ Pull)`,
normalise `μ` restricted to `X₄ ∖ Pull`, which is `R`-invariant and Borel). ∎ So the brief's "one step between MR and row 88's measure half"
is the whole measure half; nothing smaller remains to be proved beside it.

### 2.2 X27D-L0 — Pull in spectral form [hand]

For `μ ∈ M_T`: `μ` is carried by Pull ⟺ `σ_μ(T₄) = 1`. *Proof.* ⟸: then `σ̂_μ(i) = 1` for `i ∈ I`, i.e. `E⟨g(0), g(i)⟩ = 1 = E|g(0)|²`, so
`g(i) = g(0)` a.s.; by translation-invariance `c(x + i) = c(x)` for all `x ∈ R`, `i ∈ I` a.s. (countably many), so `c` factors through `R/I`:
a pullback. ⟹: an `I`-periodic `g` has spectrum on `I^⊥`. ∎ In particular `μ ∈ M′` ⟹ `δ_μ := 1 − σ_μ(T₄) > 0`.

### 2.3 X27D-PC — every `U`-invariant piece of the spectrum is carried onto `T₄` [hand, one mind]

> Given MR: for `μ ∈ M_T`, a Borel `U`-invariant `B ⊆ R̂`, and any Følner sequence `(Φ_n)` of `U`, every weak-* limit point `λ_B` of
> `|Φ_n|⁻¹ Σ_{w∈Φ_n} w_*(σ_μ|_B)` is carried by `T₄` and has mass `σ_μ(B)`.

*Proof.* `μ ↦ σ_μ` is affine and weak-* continuous (`σ̂_μ(y) = ∫⟨g(0), g(y)⟩ dμ`, a continuous integrand; Fourier convergence of probability
measures on the compact `R̂` is weak-* convergence). So the averages of `w_*σ_μ` have limit points `σ_ν`, `ν` a limit point of the averages of
`w_*μ`, which is `R ⋊ U`-invariant (X22D-RT), hence carried by Pull (X22D-QR), so `σ_ν(T₄) = 1` (L0). `B` is `U`-invariant, so
`w_*(σ|_B) = (w_*σ)|_B`, and along a common subsequence `σ_ν = λ_B + λ_{B^c}` with both positive: `λ_B` is carried by `T₄`. Mass is continuous. ∎

### 2.4 X27D-TA — no mass on `(T + A) ∖ T₄` [hand, one mind]

> Given MR: every `μ ∈ M_T` has `σ_μ((T + A) ∖ T₄) = 0`.

*Proof.* `B := (T + A) ∖ T₄` is Borel (countable `T` times the continuous injective image of `ℂ²`) and `U`-invariant. For `x = t + a ∈ B`,
`w·x = w·t + a w⁻¹` and `|a w⁻¹|_j = |a|_j` at both archimedean places (`|w| = 1` at every complex place of `L`, the global conjugation being
complex conjugation there, `F` real). So the orbit closure lies in `K′_x := (U·t) + A_{r(a)}`, `A_r` the (compact) image of the torus
`{a′ : |a′_j| = r_j}`. `K′_x ∩ T₄ = ∅`: if `a ≠ 0`, every `t′ + a′` with `a′ ∈ A_r` has `a′ ≠ 0`, and `A ∩ T = {0}` (a torsion archimedean
character is trivial on the dense `NR ⊂ L⊗ℝ`), so `t′ + a′ ∉ T`; if `a = 0`, `t ∉ T₄` and `U·t ∩ T₄ = ∅`. Put `D(x) := dist(K′_x, T₄) > 0`
(any compatible metric; Borel in `(t, r(a))`) and `f := min(1, dist(·, T₄))`, continuous, zero on `T₄`. Then for every `w`,
`∫ f d(w_*σ|_B) ≥ ∫ min(1, D) dσ|_B =: κ`, so every limit `λ_B` has `∫ f dλ_B ≥ κ`; by PC, `λ_B` is carried by `T₄`, so `κ = 0`, so `σ(B) = 0`. ∎
(No choice of Følner sequence; the archimedean and stable parts of `U` act isometrically, so their orbits never approach `T₄`.)

### 2.5 X27D-SPL and X27D-E — no mass on `E ∖ (T + A)`; so `σ_μ|_E = σ_μ|_{T₄}` [hand, one mind]

> **X27D-SPL.** Let `S` be a finite set of split places of `F` (split in `L`), `v ∈ S`, and `B^{(j)}_{S,v} := {x ∈ E_S : a_j(x_v) ≠ 0}`
> (`j = 1, 2`), where `x_v = (a₁, a₂) ∈ F_v × F_v ≅ L̂_v` pairs as `(y₁, y₂) ↦ ψ_v(a₁y₁ + a₂y₂)`. For every finite positive `ρ` on `B^{(j)}_{S,v}`
> there is a Følner sequence of `U` along which the `U`-averages of `ρ` converge to `ρ(R̂)·m` (`m` Haar).
>
> **X27D-E.** Given MR, over a type-(B) field, **every translation-invariant random four-colouring has `σ_μ|_E = σ_μ|_{T₄}`**: its
> spectral measure gives `E ∖ T₄` mass 0.

*Proof of SPL* (`j = 2`; `j = 1` is the mirror image, with the shift below reversed). At `v`, `w ∈ U` is `(α_w, α_w⁻¹)` (`ww̄ = 1`, and
conjugation swaps the two places of `L` above `v`), so `(w·x)_v = (α_w⁻¹a₁, α_w a₂)`: `U` acts hyperbolically at `v`.
1. *Splitting `U`.* `ord_S : U → ℤ^S`, `w ↦ (ord_{v′} α_w)` is onto (weak approximation for the norm-one torus `T = R¹_{L/F}𝔾_m`, a rational
   curve: `T(F) ≅ ℙ¹(F)` by stereographic projection, `1 + t² ≠ 0` on real `F`). Pick `w_{v′}` with `ord_S(w_{v′}) = e_{v′}`, so
   `U = ⟨w_v⟩ × Z′ × U_S`, `Z′ = ⟨w_{v′} : v′ ≠ v⟩`, `U_S := ker ord_S` (infinite rank). Følner sets
   `Φ_n := {w_v^{−k} : N_n ≤ k < N_n + L_n} · Ψ_n · Θ_n` (`L_n → ∞`, `Ψ_n` growing boxes in `Z′`, `Θ_n` Følner in `U_S`) are Følner in `U`.
2. *The mean over `U_S` factorises.* For fixed `x ∈ E_S`, `y ≠ 0` and `g ∈ U`, `θ ↦ (gθ·x)(y) = x(θ⁻¹g⁻¹y)` depends on `θ` only through its
   image `ι(θ)` in `K_S := ∏_{p∈P} T(F_p)^{(0)}` (`P` = the stable places of `t`'s conductor, the two archimedean places, and `S`; the
   superscript: valuation 0 at `S`), a compact abelian product group, and is continuous there. `ι(U)` is dense in `∏_{p∈P} T(F_p)` (weak
   approximation, as in 1) and `U_S = ι⁻¹(K_S)` with `K_S` open, so `ι(U_S)` is dense in `K_S`; hence the Følner mean over `U_S` exists and is
   `∫_{K_S}`, which factorises over `p ∈ P` because the integrand is a product of local factors.
3. *The `v`-factor vanishes after the shift.* With `g = w_v^{−k}z` (`z ∈ Z′`), `|α_g|_v = q_v^k`, the `v`-factor is
   `∫_{O_v^×} ψ_v(a₁(α_g u)⁻¹y₁ + a₂α_g u y₂) du`. For `k ≥ k₀(x, y)` the first argument lies in `O_v` and `|a₂α_g y₂|_v ≥ q_v²` (`y ≠ 0` ⟹
   `y₂ ≠ 0`; `a₂ ≠ 0`), and `∫_{O^×} ψ(cu) du = 1[|c| ≤ 1] − q⁻¹1[|c| ≤ q] = 0` for `|c| ≥ q²`. **Exact check of the finite model**
   (`tools/x27d_ramanujan.py`: the unit sum `Σ_{u∈(ℤ/p^k)^×} e(cu/p^k)` vanishes whenever `v_p(c) ≤ k − 2`, 19,722 instances, `p ≤ 11`, `k ≤ 4`;
   plant — the unit set enlarged by `0` — goes RED, exit 1, watched).
4. *Assemble.* For `ρ` on `B^{(2)}_{S,v}`, the Fourier coefficient at `y ≠ 0` of the `Φ_n`-average of `w_*ρ` is
   `avg_{k,z} avg_{θ∈Θ_n} ∫ (w_v^{−k}zθ·x)(y) dρ(x)`. For each of the finitely many `(k, z)` of step `n` and `y` in a finite `Y_n ↑ R ∖ {0}`,
   choose `Θ_n` far enough along a fixed Følner sequence of `U_S` that the inner average is within `1/n` of `∫ M_{k,z,y} dρ` (dominated
   convergence of the means of 2); by 3, `|∫ M_{k,z,y} dρ| ≤ ρ{x : k₀(x, y) > N_n} → 0` as `N_n → ∞`. So every nonzero Fourier coefficient of
   the averages tends to 0: the limit is `ρ(R̂)·m`. ∎

*Proof of E.* `E ∖ (T + A) = ⋃_{S, v∈S, j} B^{(j)}_{S,v}` (a character of `E_S` outside `T + A` has some `x_v ≠ 0`; the `v`-component is the
same in every `E_{S′} ⊇ E_S` by uniqueness), a countable union of `U`-invariant Borel sets (`(w·x)_v = (α⁻¹a₁, αa₂)` preserves `a_j ≠ 0`).
PC applies along **every** Følner sequence, in particular along SPL's, whose limit `σ(B)·m` gives the finite `T₄` mass 0 (`R̂` is infinite, `m`
atomless): so `σ_μ(B^{(j)}_{S,v}) = 0` for each piece. With X27D-TA, `σ_μ(E ∖ T₄) = 0`. ∎

**Consequence (a corollary, not a new input).** Given MR, Theorem C's conclusion holds over the type-(B) fields for spectra carried by the
whole of `E` — `⋃_S E_S`, not one `E_S` (row 112 needs a single finite `S`): `σ_μ(E) = 1` ⟹ `σ_μ(T₄) = 1` ⟹ Pull (L0).

### 2.6 What is left — the counterexample's shape, and the named step NA₀

> **X27D-ATT (the shape) [hand, one mind].** Given MR, if `μ ∈ M′` exists over a type-(B) field, then:
> - **(S1)** `σ_μ = σ_μ|_{T₄} + ρ₀` with `ρ₀ := σ_μ|_{R̂∖E}` `E`-null of mass `δ = 1 − σ_μ(T₄) > 0` (X27D-E, L0): the part of the spectrum that
>   is not Pull's reads infinitely many split places — row 113's situation at ℚ(√47), now forced at type (B).
> - **(S2)** `ρ₀` is **`T₄`-attracted**: every `U`-Følner average of `ρ₀` converges onto `T₄` (PC with `B = R̂ ∖ E`, which is `U`-invariant and
>   misses `T₄ ⊂ E`); and `ρ₀`-almost every character is `T₄`-attracted along a subsequence of any given Følner sequence (`L¹` ⟹ a.e. along a
>   subsequence, for a countable dense family of test functions vanishing on `T₄`).
> - **(S3)** The conditional colour law `p(x) = P(c(x) = · | 𝒜_E)` is `I`-periodic (its tetrahedral image `h = P_E g` has spectrum
>   `σ|_E = σ|_{T₄}`; X22D-EF gives `H_E = L²(𝒜_E)`): the colouring is a random proper colouring **over a Pull-shaped fog** that is exactly
>   periodic mod `𝔓⁴`; and (X22D-FLK2) `ρ̂₀(u) = −(4/3)P(c¹(0) = c²(u))` for `u ∈ U`, where the right side depends only on `u mod I`.
> - **(S4) In pair statistics.** `f(z) := P_μ(c(0) ≠ c(z))` on `I` is subadditive and symmetric, `ρ̂₀(z) = δ − (4/3)f(z)` on `I`, `f ≢ 0`, and
>   for every `y ∈ I ∖ {0}` and `ε > 0` the set `{w ∈ U : f(w⁻¹y) > ε}` has upper Banach density 0: **the colouring is `𝔓⁴`-periodic to within
>   `ε` in Banach-almost every direction of every circle `U·y ⊂ I`, and is not `𝔓⁴`-periodic.**

(S4)'s proof: `σ̂_μ(z) = 1 − (4/3)f(z)`, `σ̂|_{T₄}(z) = 1 − δ` on `I`; a limit of averages carried by `T₄` with mass `δ` has Fourier coefficient
`δ` on `I`, so `avg_{w∈Φ_n} f(w⁻¹y) → 0` along every Følner sequence, and a set of positive upper Banach density is seen at that density by
some Følner sequence. ∎

> **NA₀ (the named step).** "No nonzero finite positive `E`-null measure on `R̂` is `T₄`-attracted under `U`" (every `U`-Følner average of it
> converging onto `T₄`). **Given MR, NA₀ ⟹ TR-ROT ⟺ Q-μ** (by S1–S2). The converse is not claimed: an attracted `E`-null measure need not be the
> remainder of a proper colouring's spectrum (properness is the extra constraint `σ̂(u) = −1/3`).

**Why the method stops exactly there.** SPL needs the Følner mean over `U_S` to factorise into local integrals, one of which a hyperbolic
shift kills; that needs the character to have finitely many local components. An `E`-null character has none (it is not continuous for any
`τ_S`), and the product-over-places structure is lost — the same wall as row 113's "reading infinitely many split places in aggregate".
**Why NA₀ is not obviously true either.** Attraction to a fixed point is what **homoclinic points** do: for a single hyperbolic toral
automorphism the homoclinic group is non-trivial, and each homoclinic point's two-sided averages converge to `δ₀` along every Følner sequence
of `ℤ`. What should exclude it here is the higher (infinite) rank of `U` with the product formula (every non-trivial `w` expands somewhere), a
multi-parameter statement that for `ℤ^d`-actions is the homoclinic-group theory (`[LindSchmidt1999]`, in `BIBLIOGRAPHY.md` as reviews only,
not held; I have not read it) — and the attraction here is only in density, weaker than homoclinicity, and only modulo the finite `T₄`.
**Kind of statement:** NA₀ is pure dynamics of the algebraic action `U ↷ R̂` — no colourings, no Pull, no MR — so the next attack is in the
home discipline (algebraic actions, mean-homoclinic / asymptotic-in-density points), not in colouring theory.

**TR-ROT's verdict, with its scope:**

| form | verdict | address |
|---|---|---|
| TR-ROT as stated | **GAP at NA₀** | §2.6 |
| TR-ROT for `μ` whose spectrum off `T₄` meets `E` | **TRUE** given MR (no such `μ` has `μ(Pull) = 0` … more: no `μ ∈ M_T` gives `E ∖ T₄` any mass) | X27D-E |
| FALSE | not available: it is a colouring outside Pull, row 88's "no" | R88-TA2 |

### 2.7 Audit of the result I like (standing rule 4)

- *X27D-E is strong: does it contradict anything held?* It says, given MR, every `μ ∈ M_T` at type (B) has no `E`-mass off `T₄`. Pull
  measures: spectrum on `T₄` — consistent. `R ⋊ U`-invariant measures: carried by Pull (X22D-QR) — consistent. Row 116 (Kronecker selection
  false over ℚ): ℚ has no stable dyadic place of this kind and no MR-type input used there; not the same statement. Row 112: consistent (E is
  a corollary-strengthening of its conclusion given MR). No held translation-invariant non-Pull measure exists at type (B) to test against —
  so the check is on the steps, not on examples.
- *The steps most likely to be wrong:* (i) the product decomposition of `K_S` and density of `ι(U_S)` in it — rests on weak approximation for a
  rational curve and openness; (ii) that `(w·x)(y)` for `x ∈ E_S` depends on `w` only at the places of `P` — true because `x`'s components
  live only there; (iii) PC's use of X22D-RT "along every Følner sequence" — SPL picks a special sequence, which is allowed only because
  X22D-RT (given MR) covers every Følner sequence. If X22D-QR fell, X27D-E would fall with it.
- *Grades:* all [hand, one mind]; the one exact check is the finite model of step 3.

### 2.8 Would have searched here (Stage 2)

- I would have built a candidate `T₄`-attracted `E`-null character as an infinite product of one-sided split-place characters and computed its
  rotation averages numerically on a finite set of `y`, to see whether attraction fails. Not done (a search for a counterexample shape); NA₀ is
  named instead and the single-generator homoclinic analogy stated as the reason it is not obviously true.

## Stage 3 — SAVED (TR-ROT-flip; one more constraint on the shape; C0 scored; the write-up)

### 3.1 (S5) The remainder is singular to Haar [hand, one mind]

Given MR, `U` acts ergodically on `(R̂, m)`: a `U`-invariant `A` with `0 < m(A) < 1` would make `m|_A` a `U`-invariant, finite, positive,
`E`-null measure (`m(E) = 0`: each `E_S` is Haar-null, J45-N1, and `E` is a countable union; X22V-F1) that is no multiple of `m`, against MR.
Split `ρ₀ = ρ_ac + ρ_s` (Lebesgue, with respect to `m`); `ρ_s` is carried by a `U`-invariant `m`-null set (saturate one carrier by the countable
`U`; each `w` preserves `m`), so `ρ_ac = σ_μ|_B` for a `U`-invariant Borel `B` and PC applies to it. With `ρ_ac = h·m`,
`w_*ρ_ac = (h ∘ w⁻¹)·m`, and the mean ergodic theorem along Følner sequences of `U` sends the averages to `(∫h dm)·m`, which gives the finite `T₄`
mass 0. So `ρ_ac = 0`: **the counterexample's remainder `ρ₀` is `E`-null and singular to Haar.** NA₀ therefore only has to be proved for
singular `E`-null measures (for invariant ones this is where PE-2's zero-entropy part lives, row 120; `ρ₀` is not invariant, so PE-2 does not
apply to it).

### 3.2 TR-ROT-flip

**The literal flip: TRUE, trivially, and uninformative** (X27D-FLit). Fix finite windows `B₁ ⊂ B₂ ⊂ …` exhausting `R` and put
`Q₁(μ) := Σ_k 2^{−k} μ{c : c|_{B_k} ∉ Pull|_{B_k}}`. Each term is the mass of a clopen cylinder, so `Q₁` is affine and weak-* continuous on
`M_T`; it is 0 on the Pull-measures; and if `μ(Pull) = 0` then, since the cylinders `{c|_{B_k} ∈ Pull|_{B_k}}` decrease to Pull, some term is
positive. "Invariant under translation" is automatic on `M_T`. (A weak-* distance to the closed face `M_T(Pull)` is a second witness.) Neither
is rotation-invariant: `Q₁(w_*μ) ≠ Q₁(μ)` in general, and along `U`-averages of a counterexample `Q₁` tends to 0 (X22D-RT). **As worded the flip
is empty**: it drops the qualifier ("`U`-invariant") that makes a quantity survive the rotation average, which is the whole of TR-ROT.

**The flip in the form that would prove TR-ROT — X22V §2.2's "continuous, affine, `U`-invariant functional" — is exactly as hard as TR-ROT,
and given MR it can only be witnessed vacuously** (X27D-FL):

> **X27D-FL [hand].** (a) If some concave, `U`-invariant (`Q(w_*μ) = Q(μ)`), upper-semicontinuous `Q : M_T → [0, ∞)` vanishes on `M_T(Pull)`
> and is positive on `M′`, then TR-ROT holds (no MR used). (b) Given MR, every concave, `U`-invariant, upper-semicontinuous `Q ≥ 0` vanishing on
> `M_T(Pull)` vanishes on **all** of `M_T`. So, given MR, such a `Q` witnesses the flip iff `M′ = ∅` (Q-μ), and never by being positive on a
> counterexample.

*Proof.* For `μ ∈ M_T` and a Følner sequence `Φ_n`, concavity and invariance give `Q(avg_n w_*μ) ≥ Q(μ)`, and upper semicontinuity gives
`Q(ν) ≥ limsup_n Q(avg_n) ≥ Q(μ)` for any limit point `ν`. (a) If every limit were carried by Pull, `0 = Q(ν) ≥ Q(μ) > 0` for `μ ∈ M′`. (b) Given
MR every limit is carried by Pull (X22D-RT), so `Q(μ) ≤ 0`. ∎

**The natural candidates, and the one property each lacks** (a table of what a counterexample defeats, in G79's terms):

| quantity | affine | `U`-invariant | semicontinuity | zero exactly on Pull? | fails because |
|---|---|---|---|---|---|
| `μ(X₄ ∖ Pull)` | yes | yes | lower only | yes | Pull is closed, not open; continuous iff Pull is clopen iff T-B1 |
| `δ_μ = 1 − σ_μ(T₄)` (X27D-L0) | yes | yes (`T₄` is `U`-invariant) | lower only (`T₄` closed) | yes | along `U`-averages of a counterexample `δ` stays `δ_μ > 0` while the limit has `δ = 0`: the `T₄`-attracted `ρ₀` of (S2) is exactly this jump |
| `σ_μ(E ∖ T₄)` | yes | yes | — | — | identically 0 given MR (X27D-E) |
| `∫ φ dσ_μ`, `φ ∈ C(R̂)` pointwise `U`-invariant | yes | yes | continuous | — | given MR `φ` is constant (Haar is `U`-ergodic, §3.1, with full support, so some orbit is dense), so `Q` is constant |
| `∫ φ dσ_μ`, `φ ≥ 0` bounded u.s.c. pointwise `U`-invariant, `φ = 0` on `T₄` | yes | yes | upper | — | X27D-FL (b): identically 0 on `M_T` given MR |
| `Q₁` (window defects), X22V's `P_μ(c(0) ≠ c(4))` | yes | **no** | continuous | yes / Pull-zero | its `U`-average is the question |

**So the quantity TR-ROT needs is `δ_μ` with its lower semicontinuity repaired along rotation averages** — equivalently NA₀: the
`E`-null remainder of the spectrum cannot all be carried onto the finite torsion set `T₄` by rotating. **Verdict on the flip:** literal form
TRUE (vacuous); useful form **GAP at NA₀**, and **no quantity of the stated spectral kinds can exist** except vacuously (X27D-FL (b), the table's
last three spectral rows).

### 3.3 C0 scored

| claim | sealed C0 | outcome | score |
|---|---|---|---|
| TR-ROT | GAP 0.87 | GAP at NA₀ | met; the named step is where I expected ("stopped by the `E`-null part"), and the `E` part fell as expected |
| flip, literal | TRUE 0.90 | TRUE, vacuous | met |
| flip, X22V's form | GAP 0.85; "no functional of a stated spectral kind" expected provable | GAP at NA₀; the spectral no-go proved (FL (b)) | met |

### 3.4 G79 and G72 records (for the close)

- **G79 (example vs counterexample invariant):** X27D-E came from an **example invariant** — what every translation-invariant random
  four-colouring carries (its rotation-averaged spectrum lies on `T₄`, given MR) — pushed through the places one kind at a time. The flip's
  wanted poster ("a counterexample must carry `Q > 0`") produced only the equivalence FL. One more data point on G79's side.
- **G72 (§IQ-type structural form):** the structural question "what does every translation-invariant `μ`'s spectrum look like after rotation
  averaging" is what produced E; the existence question ("is there a rotationally transient `μ`") produced nothing directly.

### 3.5 Proposed edits (for the front-page and close lanes; I edit none of these files)

- **`LEDGER.md`, a new row or an addendum to row 111's X22D line:** "Given MR, over ℚ(√59), ℚ(√83), ℚ(√131) every translation-invariant
  random four-colouring's spectral measure gives `E ∖ T₄` mass 0 (`T₄` the characters trivial on `R ∩ 𝔓⁴`); so TR-ROT, which given MR is all of
  Q-μ, reduces to NA₀ — no nonzero `E`-null (necessarily Haar-singular) measure on `R̂` has all its `U`-Følner averages converging onto `T₄`, a
  statement about the algebraic action `U ↷ R̂` alone. [hand, one mind; X27V blind]" (X27D-EQ, E, ATT, FL).
- **Stub `plans/STUB-measure-rigidity-three-fields.md`, J38 block, after X22D's line:** "X27D: TR-ROT = Q-μ given MR; closed on `E` (X27D-E);
  left: NA₀ for singular `E`-null measures (mean-homoclinic points of `U ↷ R̂` modulo `T₄`)."
- **FS-98 stub (`plans/STUB-ultrametric-continuation.md`):** the measure half now has its own named step NA₀ beside T-B1; T-B1 ⟹ TR-ROT stays
  (X22D-RT's last clause).
- **`BIBLIOGRAPHY.md`, `[LindSchmidt1999]`:** add to "what rests on it": "the home discipline of X27D's NA₀ (homoclinic / asymptotic points of
  algebraic actions); not read by X27D". Prior-art debt: the homoclinic-group theory of algebraic actions of infinitely generated abelian
  groups, and any "mean-asymptotic" (density) version of homoclinicity; unsearched here (no time; not needed for the verdict).
- **G21 instance (a paraphrase that emptied a claim):** the owner's flip dropped X22V's "affine, `U`-invariant", and a claim that drops its
  load-bearing qualifier is satisfied trivially (FLit). Quote the named step's qualifiers verbatim when flipping it.

### 3.6 Would have searched here (Stage 3)

- None. Every statement in 3.1–3.2 is a derivation; no candidate functional was evaluated on constructed colourings.
