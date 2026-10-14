
## Stage 4 — SAVED: M8b, its vocabulary decided and its classical inputs priced (not typed)

Read for this stage: X01D § 2.0 and §§ 3.1–3.8 (`plans/FS100-X01D-derivation.md` ll. 111–311, in full), the split planner's
§ Stage 4, M8's draft claim list; Mathlib's adele files at the pin (`Mathlib/NumberTheory/NumberField/AdeleRing.lean`, 74 lines;
`Mathlib/RingTheory/DedekindDomain/FiniteAdeleRing.lean`, 188; `Mathlib/NumberTheory/NumberField/InfiniteAdeleRing.lean`, 134; their
declarations listed) and `Mathlib/NumberTheory/Padics/AddChar.lean`'s header. **Not reached: typing.** What follows decides, for
M8b's planner, what the split planner's § Stage 4 left open, and changes it where the weaker reading (§ 3.1) makes it shorter.

### 4.1 The model, on the weaker reading: built for `O′`, read for `R`

`W := L_∞ × ∏′_{w split} L_w` (Mathlib's `NumberField.InfiniteAdeleRing L` times a `RestrictedProduct` over the split
`HeightOneSpectrum`s, w.r.t. `adicCompletionIntegers`), the standard character `ψ = ψ_∞ ∏ ψ_w`, and
`π : W → Dual F`, `π a := (r ↦ ψ(a r))` for `r ∈ R ⊆ O′ ⊆ L` (`unitRing_le_stableIntegers`). **What M8b reads of it, and from
where:**

| fact | where read | how obtained, on the weaker reading |
|---|---|---|
| `π` a continuous homomorphism, `π(u a) = rot u (π a)` | everywhere | definitional, from `ψ` |
| `π` onto | the lifts `x̃` (Lemma 3.1′, Steps 3–5) | FS131-KPD1's line: `π(W)` has zero annihilator in `R` (`ψ_∞` alone separates: `Tr(a r) ∈ ℤ` for all `a ∈ L_∞` forces `r = 0`) and is compact once `W = K + Λ′` with `K` compact and `Λ′ ⊆ ker π`; then `Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot` (D2's case, lane PD) |
| `W = K + O′` (cocompactness) | surjectivity; Lemma 3.1′'s finite cover | `K := (a fundamental domain of `𝓞 L` in `L_∞`) × ∏_{split} O_w`: subtract `r ∈ O′` with prescribed principal parts at the finitely many split `w` where `a_w ∉ O_w` and integral elsewhere (approximation in a Dedekind domain, `IsDedekindDomain.exists_forall_sub_mem_ideal`-shape with a common denominator), then an element of `𝓞 L` (`ZSpan.fundamentalDomain` on `NumberField.mixedEmbedding.latticeBasis`, through Mathlib's equivalence of `InfiniteAdeleRing` with the mixed space) |
| `ker π = ι(Λ)`, `Λ ⊆ L`, `Λ` an `R`-module, `d·O′ ⊆ Λ ⊆ d⁻¹·O′` for some integer `d ≥ 1` | Lemma PF (`C_Λ < ∞`), Steps 3–5, Step 6 | `⊇`: the additive product formula `ψ(L) = 1` and `ψ_w(𝔡_w^{-1}O_w) = 1`. `⊆` (**the content of Tate's `L^⊥ = L` here**): for `a ∈ ker π`, subtract `r ∈ O′` as in the cocompactness step (`r ∈ ker π`), so `a − r ∈ L_∞ × ∏ O_w`; testing on `𝓞 L` puts its archimedean part `y` in the trace dual `(𝓞 L)^∨ ⊆ L` (`y ∈ ker π`); `c := a − r − y` has `c_∞ = 0` and, tested on elements of `O′` with one prescribed split pole and integral at the other split places (dense in `L_{w₀}`), `ψ_{w₀}(c_{w₀} L_{w₀}) = 1`, so `c_{w₀} = 0` (local non-degeneracy). **With `c·O′ ⊆ R`** (`exists_mul_stableIntegers_le`) the same computation runs for `R` with `c` in front: `ker π_R ⊆ c⁻¹ ker π_{O′}` |
| `T = π(L)`, `A = π(L_∞)` (so `TA F = π(L + L_∞)`) | the conclusion, Step 7 | `T`: a character of order `N` is `π(a)` with `Na ∈ Λ ⊆ L`; conversely `π(t)` for `t ∈ L` depends only on the stable components (product formula), where `t` has bounded denominators. `A`: an additive `ψ : R → ℝ` extends `ℚ`-linearly to `L` (`ℚR = L`, `exists_mul_stableIntegers_le`'s step (b); `CharacterColouring.exists_ratLinear_extension`), a trace form `Tr(a ·)` for `a ∈ L_∞` |
| finite `U`-orbits on `L/Λ` | Step 6 (ii) | **no strong approximation needed**: `t ∈ m⁻¹O′` for some integer `m`, `u t ∈ m⁻¹O′` for `u ∈ U ⊆ O′`, and `m⁻¹O′/Λ ⊆ m⁻¹O′/dO′`, finite (`O′/nO′` is a finite product of `𝓞/𝔓^k` over the stable `𝔓 ∣ n`) |
| `φ_t` a Borel isomorphism onto its image | Step 6 (i) | **no Lusin–Souslin and no `PolishSpace W` needed**: `W_{v*}` is σ-compact (closed in the σ-compact `W`), `φ_t` is injective and continuous, so a closed embedding on each compact piece (`Topology.IsClosedEmbedding.measurableEmbedding`), and Borel images on each piece add up |

**The interface (my recommendation for M8b's planner).** Package the five facts as a structure `TateModel F` over the concrete
`W` (fields: `π` with continuity and equivariance; surjectivity; `Λ` with `ker π = ι '' Λ`, `R`-stability and the two-sided
bound by `O′`; `W = K + ι(O′)` with `K` compact; `TA F = π '' (ι L + L_∞)`), so that M8b-2..4 are planned and proved over
`(D : TateModel F)` **at the same time as** its construction (lane T below), whose single exit is `Nonempty (TateModel F)`.
Then `zeroEntropyCarried`'s proof is `M8b-4's theorem` applied to lane T's model — and the scope hypothesis is read by neither
(the coordinator's ruling: dropped then, with a dump).

### 4.2 Parts 2–4, decided

- **M8b-2, thin boxes (Lemma 3.1′).** `Q(ε)`, `Q_{v*}(ε, δ)` as subsets of `W` (archimedean components in the ordinary modulus,
  split ones in `O_w`); **Lemma PF** for `y ∈ Λ ∖ 0` and for `y ∈ R ∖ 0` from Mathlib's `NumberField.prod_abs_eq_one` (present;
  `Names9.log`) and the bound `d⁻¹·O′` (so `C_Λ ≤ ∏_{stable 𝔓 ∣ d} N𝔓^{v_𝔓(d)}`); **the expanding place** by Kronecker —
  `NumberField.Embeddings.pow_eq_one_of_norm_eq_one` (present) after the product formula forces `|u*|_v = 1` everywhere and
  integrality at every finite place; **local injectivity** (part (ii)) by induction on `i < n − 1` with the measure `n − 1 − i`;
  **Lemma 3.1′** as EN2-L31 states it, part (iii) over `Rigidity.exists_forall_exp_le_measureReal_nameCell` (EN2-ZE, proved by
  lane N) with `P := ξ` the finite partition of part (i) and `T := rot u*` — the label map is `Dual F → Fin k`, as EN2-ZE takes it.
- **M8b-3, the pigeonhole and the global point (Lemma 3.2′(a), §§ 3.5–3.6).** Multipliers `V_M := {(1 + 2bi)/(1 − 2bi) : 1 ≤ b,
  1 + 4b² ≤ M^{1/n}}`, `n = [L : ℚ(i)] = [F : ℚ]` (KN8's shorter height input: `#V_M ≥ c·M^{α′}`, `α′ = 1/(2[F:ℚ])`, and the
  height of each is `(1 + 4b²)^n ≤ M`, read as `∏_w max(1, |v|_w) ≤ M`); they are archimedean isometries at every place of `L`
  (they lie in `ℚ(i)`); the pigeonhole is a finite-measure count (`μ(vB) = μ(B)` by `RotInv`, `Σ μ(vB) > μ(R̂)` forces an
  intersection); two scales `M`, `M²` give `z = ℓ₁e₂ − ℓ₂e₁ ∈ Λ` with every place bounded, so `z = 0` by Lemma PF; iterating
  the scales gives one `t ∈ L` and `(x̃ − t)_{v*} = 0`; so `μ(R̂ ∖ (T + K_{v*})) = 0`, `K_{v*} := π(W_{v*})`, Borel because
  σ-compact. The constants (`K = 16`, `β = α′/(2K)`, `δ(M) = M^{−K}`) as X01D fixes them, with `α′` for `α`.
- **M8b-4, leaves and wandering shells (§§ 3.7–3.8).** The leaves `φ_t(W_{v*})` pairwise disjoint (`W_{v*} ∩ L = 0`); finite
  orbits and the stabiliser of finite index (§ 4.1's route); `ν_t` invariant under `U_t`; at a split `w ≠ v*`,
  `g := γ/σ(γ)` with `(γ) = 𝔓_w^h` — Mathlib's class group is finite (`NumberField.classNumber`, present), so `𝔓_w^h` is
  principal — and `|g|_w ≠ 1`; the shells' measures are periodic in `j` and sum to a finite number, so all vanish; countably
  many split `w`; so `μ` is carried by `π(L + L_∞) = TA F`. Exit: `Rigidity.zeroEntropyCarried` (moved downstream of M8b at
  the landing with its statement unchanged, as ruling 5 of inventory item 761 moves `entropySplit`).

### 4.3 The classical inputs (brief item 5): named, searched at the pin, priced, formalize or declare

| input | at the pin (searched by name; `data/fs131/kn9/logs/Names9.log`, the file listings above) | price (from Mathlib's state, **not from an elaborated leaf**) | choice |
|---|---|---|---|
| **Tate's self-duality, in the form § 4.1 reads**: the standard character `ψ`; `ψ(L) = 1`; local non-degeneracy; `ker π ⊆ L`; cocompactness | **none**: the adele rings are types with their topology and ring structure only (no discreteness of `L`, no compact quotient, no characters, no local traces); `Mathlib/NumberTheory/Padics/AddChar.lean` describes the continuous characters of `ℤ_p` only | **the dominant cost of M8b.** The character `ψ_w` needs either the local trace `L_w → ℚ_p` (Mathlib does not present `adicCompletion` as a finite extension of `ℚ_p` with `Tr_{L/ℚ} = Σ_w Tr_{L_w/ℚ_p}`, as far as I found) or a global definition on `L` by approximation, extended to `L_w` by uniform continuity. Then the four facts by § 4.1's routes. My guess: **a planner-and-implementer job of several days**, two to four thousand lines; re-price from its first two leaves (`LEAN.md`) | **formalize** (W2), as **lane T**, a planner first; the declared form is no shortcut — `[Weil1967]` IV.2 / `[Tate1950]` § 4.1's statements need `ψ` built anyway, so a declared axiom would save only the four proofs. Neither source is held or read (prior-art debt; bibliography lines in § Drafts) |
| strong approximation | none by that name | **not needed** on § 4.1's routes: the finite orbits use `O′/nO′` finite; the absorption of stable components needs no approximation once the model is built for `O′` directly (stable places never enter `W`) | dropped from the inputs |
| approximation in a Dedekind domain (prescribed principal parts at finitely many primes, integral elsewhere) | `IsDedekindDomain.exists_forall_sub_mem_ideal` (CRT) is Mathlib's; the fractional form with poles is not, as far as I searched | a few hundred lines over CRT | formalize, inside lane T |
| Kronecker | `NumberField.Embeddings.pow_eq_one_of_norm_eq_one` (present) | the expanding place: about a hundred lines with the product formula and integrality from the finite places | Mathlib's |
| the product formula | `NumberField.prod_abs_eq_one` (present) | read directly | Mathlib's |
| Lusin–Souslin | `MeasurableSet.image_of_continuousOn_injOn` (Mathlib) — **not needed**: σ-compactness and closed embeddings on compact pieces suffice (§ 4.1) | — | dropped |
| finiteness of the class group | `NumberField.classNumber`, `ClassGroup.fintypeOfAdmissibleOfFinite` (present) | short | Mathlib's |
| the height count | — | replaced by KN8's family `z = 1 + 2bi` (elementary) | formalize in M8b-3 |
| Shannon–McMillan–Breiman | — | replaced by EN2-ZE (lane N, proved) | — |

No axiom is declared, and none is drafted: the one input with no route in Mathlib (Tate) is a formalization lane.

### 4.4 What M8b's planner inherits

Its vocabulary: § 4.1's `TateModel F` (to type first, over the concrete `W`), § 4.2's three modules over it. Its inputs typed
and landed or on the way: EN2-ZE and EN2-CNT (`Rigidity/ZeroEntropyNames`, proved), `R ⊆ O′` (proved here), `c·O′ ⊆ R` and the
density (M9-R), D2's case (lane PD). Its open questions: (i) the form of `ψ_w` (local trace or global definition) — lane T's
planner, by measuring both on the first two leaves; (ii) whether `zeroEntropyCarried`'s scope binder is read — the kernel
answers it (the coordinator's ruling).
