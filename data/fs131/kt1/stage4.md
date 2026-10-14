
## Stage 4 — SAVED: lane T typed to its leaves (form G), a plan per leaf

Four new modules, with `Rigidity/TateExists` now the assembly. Each statement below is as the kernel prints it
(`logs/KernelSigs4.log`); every name a route cites is checked at the pin (`probes/Names.lean`, `logs/Names-s4b.log`).

```
TateLocal (K any number field)   TateArch (K any number field)
          \                        /
           TateCharacter (F: ψ, π, facts 1, 3-lower, 5)  ← TateModel (the interface)
                    |
           TateKernel (F: kernel, bound, cover, surjectivity; reads Duality's D2 and RingScope's c·O′ ⊆ R)
                    |
           TateExists (exists_tateModel: the structure, one field per fact; no leaf of its own)
```

### 4.1 Why the stable places never appear, and why `O′ ⊆ Λ` costs nothing (the coordinator's ruling (2))

Form G's character on `W` is `ψ(a) = e(Tr_∞(a_∞) − Tr(t))` for an approximant `t ∈ O′` of `a`. It *is* the restriction of
the adelic standard character to `W`: at each split `w` the local factor `ψ_w(z) = e(−Tr(t_z))` with `t_z` integral off `w`
(stage 3), and `∏_{w ∈ supp} ψ_w(a_w) = e(−Tr(Σ t_{a_w}))`, `Σ t_{a_w}` being an approximant of `a`. For `x ∈ O′` the point
`ι x` has the approximant `x` itself, so `ψ(ι x) = e(Tr_∞(ι_∞ x) − Tr x) = 1` by `archTrace_mixedEmbedding` alone: the product
formula on `O′` is the definition read at one point (`tateChar_toSAdele_of_mem`, about ten lines), and `π(ι x)(r) = ψ(ι(x r))`
with `x r ∈ O′` (`R ⊆ O′`). **So the field `O′ ⊆ Λ` is true for the standard character and is the cheapest field of the
structure**; `d·O′ ⊆ Λ` would be proved by the same lines. No change to the interface is needed.

### 4.2 Tate's `O′^⊥ ⊆ L` on form G: the argument the kernel leaves transcribe

For `a ∈ oAnn F` (`ψ(a s) = 1` for every `s ∈ O′`):
1. subtract an approximant `t_a ∈ O′` (`ι(O′) ⊆ oAnn` by § 4.1): `b := a − ι t_a` is integral at every split prime;
2. test `b` on `s ∈ 𝓞 L`: `b·ι s` is integral at every split prime, so `ψ(b ι s) = e(Tr_∞(b_∞ s))` (`tateChar_of_integral`);
   all these are `1`, so `b_∞ = ι_∞(y)` with `Tr(y s) ∈ ℤ` for `s ∈ 𝓞` (`exists_eq_mixedEmbedding_of_archTrace_int`);
3. `d₀ y ∈ 𝓞` (`exists_nat_mul_integral_of_trace_int`); put `c := d₀(b − ι y)`: `c_∞ = 0`, `c_w = d₀ b_w − d₀ y ∈ O_w`, and
   `c ∈ oAnn` (for `s ∈ O′`: `ψ(c ι s) = ψ(b ι(d₀ s)) · ψ(ι(d₀ y s))⁻¹`, the first `1` since `d₀ s ∈ O′`, the second `1` by § 4.1
   since `d₀ y s ∈ O′`);
4. **local non-degeneracy** (`eq_zero_of_mem_oAnn`): suppose `c_{w₀} ≠ 0` at a split `w₀`. Take `t₀ ∈ L` integral off `w₀`
   with `Tr t₀ ∉ ℤ` (`exists_trace_not_int_away`), and `s ∈ L` integral off `w₀` with `s ≡ t₀/c_{w₀}` modulo `O_{w₀}`
   (`exists_approx_completion`); `s ∈ O′`. Then `c·ι s` is integral off `w₀` and `≡ t₀` at `w₀` (as `c_{w₀} O_{w₀} ⊆ O_{w₀}`),
   so `t₀` is an approximant of `c ι s` and `ψ(c ι s) = e(−Tr t₀) ≠ 1`, against `c ∈ oAnn`. Hence `c = 0` (`c_∞ = 0` was
   given), `b = ι y`, `a = ι(t_a + y)`, and `d₀(t_a + y) ∈ O′`. No local character on `L_{w₀}` and no single-place element of
   `W` is needed.

**The step that differs from FS131-KN9 § 4.1**: KN9 tested `c := a − r − y` directly, which needs `ι y ∈ ker π` for
`y ∈ 𝔡⁻¹` and so the local description of `𝔡⁻¹`; multiplying by the denominator `d₀` first (step 3) puts every test element in
`O′`, where § 4.1 applies, and the inverse different never enters. For `R` (fact 3): `π a = 1` gives `c·a ∈ oAnn` through
`c·O′ ⊆ R`, so `ker π ⊆ ι L` and `Λ ⊆ (d₀ c)⁻¹ O′`.

### 4.3 A plan per leaf

| module | leaf | route (Mathlib names, checked) | lines (est.) | hard |
|---|---|---|---|---|
| `TateLocal` | `exists_valuation_le_one_away` | **route copy** `G1b_crt` (scratch): `IsLocalization.surj`, `Ideal.finite_factors`, `IsDedekindDomain.exists_forall_sub_mem_ideal`, `Ideal.prime_of_isPrime`, `intValuation_eq_exp_neg_multiplicity`, `intValuation_le_pow_iff_mem`, `valuation_of_algebraMap`, `multiplicity_eq_zero`, `div_le_one₀` | 45 (done) | — |
| | `exists_approx_completion` | **route copy** `G1_approx`: `denseRange_algebraMap`, `DenseRange.exists_mem_open`, `Valued.isOpen_valuationSubring`, `valuedAdicCompletion_eq_valuation'` | 20 (done) | — |
| | `exists_int_trace_of_integral` | **route copy** `G2_trace_int`: `mem_integers_of_valuation_le_one`, `Algebra.isIntegral_trace`, `IsIntegrallyClosed.isIntegral_iff` | 7 (done) | — |
| | `exists_trace_not_int_away` | a uniformizer `π` at `v` (`valuation_exists_uniformizer`); `t` from `exists_valuation_le_one_away` at `s := π^{−N}` has `v(t) = v(π)^{−N}`; if every such `t` had integral trace, `d₀ t` would be integral at `v` (`exists_nat_mul_integral_of_trace_int` applied to `t`: `t·s` is again integral off `v` for `s ∈ 𝓞`), false for `N > v(d₀)` | 45 | the valuation bookkeeping in `ℤᵐ⁰` |
| | `exists_nat_mul_integral_of_trace_int` | the dual basis of the integral basis for the trace form (`traceForm_nondegenerate`, `LinearMap.BilinForm.dualBasis`, `dualBasis_repr_apply`): `y = Σ Tr(y eᵢ) eᵢ^∨`; `d₀` clears the denominators of the `eᵢ^∨` (`IsLocalization.exist_integer_multiples_of_finset`); integral at every prime by `valuation_of_algebraMap` | 50 | — |
| | `compactSpace_adicCompletionIntegers` | `Valued.integer.compactSpace_iff_completeSpace_and_isDiscreteValuationRing_and_finite_residueField`: complete (`IsClosed.completeSpace_coe`, the integers closed), DVR (Mathlib's instance, FinitePlace.lean l. 76), finite residue field — the map `𝓞 ⧸ v → 𝓀` is onto (density of `K`, then `exists_valuation_sub_lt_of_integer`), and `𝓞 ⧸ v` is finite (`Ideal.finiteQuotientOfFreeOfNeBot` or the number-field instance) | 80 | **the residue field**: no Mathlib statement; the hardest leaf of the module |
| `TateArch` | `archTrace_mixedEmbedding` | both sides `ℚ`-linear in `x`; agree on the integral basis (`latticeBasis_apply`, `Basis.constr_basis`); `x` in the `ℚ`-span (`integralBasis` is a `ℚ`-basis) | 25 | — |
| | `exists_eq_mixedEmbedding_of_archTrace_int` | coordinates of `b` in `latticeBasis` (`Basis.repr`); the Gram matrix `Tr(eᵢ eⱼ)` (`Algebra.traceMatrix`), invertible over `ℚ` (`Algebra.discr_def`, `NumberField.discr_ne_zero`); `c·G ∈ ℤⁿ` gives `c ∈ ℚⁿ`, so `b = ι_∞(Σ cᵢ eᵢ)` (`mem_rat_span_latticeBasis`) | 70 | **the matrix step**: a solve over `ℚ` read back in `ℝ` |
| | `archTrace_mixedEmbedding_one` | `archTrace_mixedEmbedding`, `Algebra.trace_algebraMap` | 5 | — |
| `TateCharacter` | `mem_stableIntegers_iff_valuation` | `mem_stableIntegers`, `UpperHalf`'s `StablePrime.heightOne`, `valuationSubringAtPrime_eq_valuationSubring`; a stable `HeightOneSpectrum` gives a `StablePrime` (`HeightOneSpectrum.isMaximal`) | 30 | the two-way bijection of stable primes |
| | `exists_isApprox` | the finite set `{w : a.2 w ∉ O_w}` (`RestrictedProduct`'s `eventually` in `cofinite`); a `Finset.sum` of `exists_approx_completion`'s `t_w`; at each split `w` the other summands are integral (ultrametric `Valuation.map_sum_le`); in `O′` by `mem_stableIntegers_iff_valuation` (each `t_w` integral off `w`, `w` split) | 55 | the restricted-product bookkeeping |
| | `exists_int_trace_sub_of_isApprox` | `t − t′` integral at split primes (difference of the two congruences) and at stable ones (`O′`); `exists_int_trace_of_integral`; the split/stable dichotomy is `IsStablePlace`'s excluded middle | 20 | — |
| | `tateCharFun_eq` | `exists_int_trace_sub_of_isApprox` for `t` and the chosen approximant; `Circle.exp` is `2π`-periodic (`Circle.exp_int_mul_two_pi` or `_two_pi_mul_int`, whichever the probe finds) | 15 | — |
| | `tateCharFun_zero`, `tateCharFun_add` | the approximants `0` and `t_a + t_b`; `map_add` of `archTrace`, `Algebra.trace` | 20 | — |
| | `tateChar_of_integral`, `tateChar_toSAdele_of_mem` | `tateCharFun_eq` at `0` and at `x`; `archTrace_mixedEmbedding` | 15 | — |
| | `continuous_tateChar` | on the open subgroup `U₀ = L_∞ × ∏ O_w` (`RestrictedProduct.isOpen_forall_mem`) it is `e ∘ 2π Tr_∞ ∘ fst`; a homomorphism continuous at `1` is continuous (`MonoidHom.continuous_of_continuousAt_one` on `AddChar.toMonoidHom`) | 30 | — |
| | `continuous_tatePi` | `isClosedEmbedding_coe` (the pointwise topology of `R̂`), `continuous_pi_iff`, `continuous_tateChar.comp (continuous_mul_right _)` | 20 | — |
| | `tatePi_unit_mul` | `AddChar.ext`; `ofUnitRing (uvRing u * r) = unitL u * ofUnitRing r` by `Subtype.ext`; `mul_comm`, `mul_assoc` | 15 | — |
| | `tatePi_toSAdele_of_mem` | `UnitRing.coe_mem_unitRingOver_iff`, `unitRing_le_stableIntegers`, `Subring.mul_mem`, `tateChar_toSAdele_of_mem` | 15 | — |
| | `tatePi_arch_mem` | `(b, 0)·ι r = (b·ι_∞ r, 0)` is integral at every split prime; `tateChar_of_integral`; the lift `r ↦ 2π Tr_∞(b · ι_∞ r)` as an `AddMonoidHom` | 20 | — |
| `TateKernel` | `exists_eq_mixedEmbedding_of_mem_oAnn` | § 4.2 step 2; `tateChar_of_integral`, `exists_eq_mixedEmbedding_of_archTrace_int`, and `Circle.exp (2π x) = 1 → x ∈ ℤ` (`Circle.exp_eq_one` or `Real.Angle`; check) | 35 | — |
| | `eq_zero_of_mem_oAnn` | § 4.2 step 4: `exists_trace_not_int_away`, `exists_approx_completion` at `t₀ / c_{w₀}` (`div` in the field `L_{w₀}`, `Valuation.map_mul`), `tateCharFun_eq` at the approximant `t₀`, and `Circle.exp (2π x) = 1 → x ∈ ℤ` | 55 | the congruence `c s ≡ t₀` read through `Valued.v` |
| | `exists_nat_forall_mem_oAnn` | § 4.2 steps 1–3 over the two leaves above | 50 | — |
| | `tatePi_ker_subset`, `tatePi_exists_nat_mul_mem` | `exists_mul_stableIntegers_le` (lane M9-R's statement), `exists_nat_forall_mem_oAnn`; `a = ι(c⁻¹)·(ι c · a)` | 45 | — |
| | `tatePi_exists_isCompact` | `K := closure (ι_∞-fundamental domain) ×ˢ (structure map image of `∏ O_w`)`; `ZSpan.fundamentalDomain_isBounded`, `Metric.isCompact_of_isClosed_isBounded` (`ProperSpace` of the finite-dimensional mixed space); `isCompact_univ_pi` with `compactSpace_adicCompletionIntegers`, `RestrictedProduct.isEmbedding_structureMap`; the decomposition by `exists_isApprox` then `ZSpan.exist_unique_vadd_mem_fundamentalDomain` (`mixedEmbedding.fundamentalDomain_integerLattice`) | 90 | the compact set inside the restricted product |
| | `tatePi_eq_one_forall_imp` | for `r ≠ 0`, `ι_∞ r` is a unit of the mixed space (each component a nonzero complex number); `b := (2[L:ℚ])⁻¹ · (ι_∞ r)⁻¹` gives `Tr_∞(b ι_∞ r) = 1/2` (`archTrace_mixedEmbedding_one`), so `π(b,0)(r) = e(π) = −1` | 40 | — |
| | `surjective_tatePi` | `π(W) = π(K)` (fact 4 with `O′ ⊆ ker π`), compact, so closed (`IsCompact.isClosed`); its co-annihilator is `⊥` by the leaf above; `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` on `MonoidHom.range π.toMonoidHom` | 40 | — |
| `TateModel` (interface) | `mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `isOpenMap` | § 2.3's routes (`Subring.closure_le`; `AddChar.map_sub_eq_div`; `exists_integral_multiple`, `AddChar.map_nsmul_eq_pow`; `SigmaCompactSpace.of_countable`, `MonoidHom.isOpenMap_of_sigmaCompact`) | 85 | — |

**Total: 30 leaves, about 1,050 lines**, of which 72 are written (the three route copies).

### 4.4 Models (the statements whose hypotheses are a structure)

`exists_eq_mixedEmbedding_of_mem_oAnn`, `eq_zero_of_mem_oAnn` and `exists_nat_forall_mem_oAnn` take `a ∈ oAnn F`: `0 ∈ oAnn F`
(`tateChar 0 = 1`), and `ι x` for `x ∈ O′` (§ 4.1), are inhabitants exercising every clause (the second is integral at every
split prime and has archimedean part `ι_∞ x`, nonzero for `x ≠ 0`); `eq_zero_of_mem_oAnn`'s three hypotheses hold together at
`0` only — it is a uniqueness statement, and its docstring's route says so. `tatePi_eq_one_forall_imp`'s hypothesis holds at
`r = 0` only, likewise. Every other leaf is over a number field or `F` alone.
