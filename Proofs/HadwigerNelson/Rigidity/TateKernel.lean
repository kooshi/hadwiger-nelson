import Proofs.HadwigerNelson.Rigidity.TateCharacter
import Proofs.HadwigerNelson.Rigidity.Duality

/-!
# Lane T, Tate's `L^⊥ = L` in the form the model reads: the kernel, its bound, the cover, the surjectivity (FS-131, job FS131-KT1; skeleton)

**Read aloud.** `oAnn F` is the annihilator of `O′` in `W` under the standard character, `{a | ψ(a s) = 1 for all s ∈ O′}`.
* `exists_eq_mixedEmbedding_of_mem_oAnn` — **the archimedean step**: a point of `oAnn` integral at every split prime has its
  archimedean part on the diagonal (`exists_eq_mixedEmbedding_of_archTrace_int`, tested on `𝓞 L`).
* `eq_zero_of_mem_oAnn` — **the split step, local non-degeneracy**: a point `c` of `oAnn` with archimedean part `0`, integral
  at every split prime, is `0`. If `c_{w₀} ≠ 0`, take `t₀` integral off `w₀` with `Tr t₀ ∉ ℤ` (`exists_trace_not_int_away`)
  and `s` integral off `w₀` with `s ≡ t₀ / c_{w₀}` modulo `O_{w₀}` (`exists_approx_completion`): `t₀` approximates `c·s`, so
  `ψ(c s) = e(−Tr t₀) ≠ 1`, though `s ∈ O′`.
* `exists_nat_forall_mem_oAnn` — **`oAnn ⊆ ι(d₀⁻¹·O′)`**: subtract an approximant `t_a` (`ι(O′) ⊆ oAnn`, the product formula
  `tateChar_toSAdele_of_mem`), apply the archimedean step to get `y`, multiply `b − ι y` by the denominator `d₀` of the trace
  dual (`exists_nat_mul_integral_of_trace_int`) so that every test element stays in `O′`, apply the split step. The inverse
  different never enters (`plans/FS131-KT1-tate.md` § 4.2).
* `tatePi_ker_subset`, `tatePi_exists_nat_mul_mem` — **fact 3** for `R`: `c·O′ ⊆ R` (`exists_mul_stableIntegers_le`, lane M9-R)
  puts `c·a` in `oAnn` when `π a = 1`; the bound is `d = d₀·c`.
* `tatePi_exists_isCompact` — **fact 4**: `K := closure(fundamental domain of 𝓞 L in L_∞) × ∏_{split} O_w`, compact
  (`ZSpan.fundamentalDomain_isBounded`, `compactSpace_adicCompletionIntegers` and Tychonoff); subtract an approximant, then an
  element of `𝓞 L` (`ZSpan.exist_unique_vadd_mem_fundamentalDomain`).
* `tatePi_eq_one_forall_imp` and `surjective_tatePi` — **fact 2**: the annihilator of `π(W)` in `R` is `0` (an archimedean
  point `(b, 0)` with `Tr_∞(b r) = 1/2`, using `archTrace_mixedEmbedding_one`), and `π(W) = π(K)` is compact, so closed; D2's
  case `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` (lane PD) gives `π(W) = R̂`.

**Inhabitants.** Statements about the definitions of `Rigidity/TateCharacter` at every real number field.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField IsDedekindDomain IsDedekindDomain.HeightOneSpectrum

open scoped RestrictedProduct

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

/-- **The annihilator of `O′` in `W`** under the standard character. -/
def oAnn : Set (SAdeleRing F) := {a | ∀ s ∈ stableIntegers F, tateChar F (a * toSAdele F s) = 1}

variable {F}

/-- **The archimedean step.** -/
theorem exists_eq_mixedEmbedding_of_mem_oAnn {a : SAdeleRing F} (ha : a ∈ oAnn F)
    (hint : ∀ w : SplitPlace F, a.2 w ∈ w.1.adicCompletionIntegers (fieldI F)) :
    ∃ y : fieldI F, a.1 = mixedEmbedding (fieldI F) y ∧
      ∀ s : 𝓞 (fieldI F), ∃ n : ℤ, Algebra.trace ℚ (fieldI F) (y * s) = n := by
  sorry

/-- **The split step (local non-degeneracy).** -/
theorem eq_zero_of_mem_oAnn {c : SAdeleRing F} (hc : c ∈ oAnn F) (h1 : c.1 = 0)
    (hint : ∀ w : SplitPlace F, c.2 w ∈ w.1.adicCompletionIntegers (fieldI F)) : c = 0 := by
  sorry

variable (F) in
/-- **Tate's `O′^⊥ ⊆ L`, with its bound**: the annihilator of `O′` lies on the diagonal, inside `d₀⁻¹·O′`. -/
theorem exists_nat_forall_mem_oAnn :
    ∃ d₀ : ℕ, d₀ ≠ 0 ∧ ∀ a ∈ oAnn F, ∃ x : fieldI F, a = toSAdele F x ∧ (d₀ : fieldI F) * x ∈ stableIntegers F := by
  sorry

variable (F)

/-- **Fact 3, the kernel on the diagonal**, for `R`. -/
theorem tatePi_ker_subset (a : SAdeleRing F) (ha : tatePi F a = 1) : ∃ y : fieldI F, a = toSAdele F y := by
  sorry

/-- **Fact 3, `Λ ⊆ d⁻¹·O′`**, for `R` (`d = d₀·c`). -/
theorem tatePi_exists_nat_mul_mem :
    ∃ d : ℕ, d ≠ 0 ∧ ∀ y : fieldI F, tatePi F (toSAdele F y) = 1 → (d : fieldI F) * y ∈ stableIntegers F := by
  sorry

/-- **Fact 4, cocompactness.** -/
theorem tatePi_exists_isCompact : ∃ K : Set (SAdeleRing F), IsCompact K ∧
    ∀ a : SAdeleRing F, ∃ k ∈ K, ∃ x ∈ stableIntegers F, a = k + toSAdele F x := by
  sorry

/-- **The annihilator of `π(W)` in `R` is `0`.** -/
theorem tatePi_eq_one_forall_imp (r : unitRing F) (h : ∀ a : SAdeleRing F, tatePi F a r = 1) : r = 0 := by
  sorry

/-- **Fact 2, surjectivity.** -/
theorem surjective_tatePi : Function.Surjective (tatePi F) := by
  sorry

end

end HadwigerNelson.Rigidity
