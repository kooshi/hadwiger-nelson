import Mathlib.RingTheory.DedekindDomain.AdicValuation
import Mathlib.RingTheory.DedekindDomain.Ideal.Lemmas
import Mathlib.RingTheory.DedekindDomain.Factorization
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.RingTheory.Trace.Basic

/-! FS131-KT1, stage 3 — form G of the local character, its first two leaves (scratch; measurement only).

Form G: `ψ_v(z) := e(−Tr_{K/ℚ}(t))` for any `t ∈ K` integral at every prime `≠ v` with `z − t ∈ O_v`.
Leaf G1: such a `t` exists (density, then the Chinese remainder theorem). Leaf G2: `Tr(t − t′) ∈ ℤ` (well-definedness).
-/

open IsDedekindDomain IsDedekindDomain.HeightOneSpectrum NumberField

variable {K : Type*} [Field K] [NumberField K]

/-- **G2.** An element integral at every prime has an integral trace. -/
theorem G2_trace_int (x : K) (h : ∀ v : HeightOneSpectrum (𝓞 K), v.valuation K x ≤ 1) :
    ∃ n : ℤ, Algebra.trace ℚ K x = n := by
  obtain ⟨y, rfl⟩ := mem_integers_of_valuation_le_one K x h
  have hint : IsIntegral ℤ (Algebra.trace ℚ K (algebraMap (𝓞 K) K y)) :=
    Algebra.isIntegral_trace (RingOfIntegers.isIntegral_coe y)
  obtain ⟨n, hn⟩ := IsIntegrallyClosed.isIntegral_iff.mp hint
  exact ⟨n, by rw [← hn]; simp⟩

/-- **G1b**, the Chinese remainder step: every `s ∈ K` is, at `v`, congruent modulo `O_v` to an element of `K` integral at
every other prime. Route: `s = n/c` with `n, c ∈ 𝓞`; CRT gives `y ≡ n (mod v^{v(c)})` and `y ≡ 0 (mod w^{w(c)})` at the
other primes dividing `c`; `t := y/c`. -/
theorem G1b_crt (v : HeightOneSpectrum (𝓞 K)) (s : K) :
    ∃ t : K, (∀ w ≠ v, w.valuation K t ≤ 1) ∧ v.valuation K (s - t) ≤ 1 := by
  classical
  obtain ⟨⟨n, c, hc⟩, hs⟩ := IsLocalization.surj (nonZeroDivisors (𝓞 K)) s
  have hc0 : c ≠ 0 := nonZeroDivisors.ne_zero hc
  have hcK : (algebraMap (𝓞 K) K c) ≠ 0 := by
    simpa using (IsFractionRing.injective (𝓞 K) K).ne hc0
  have hfin : {w : HeightOneSpectrum (𝓞 K) | w.asIdeal ∣ Ideal.span {c}}.Finite :=
    Ideal.finite_factors (by simpa [Ideal.span_singleton_eq_bot] using hc0)
  let S : Finset (HeightOneSpectrum (𝓞 K)) := insert v hfin.toFinset
  let e : HeightOneSpectrum (𝓞 K) → ℕ := fun w => multiplicity w.asIdeal (Ideal.span {c})
  obtain ⟨y, hy⟩ := IsDedekindDomain.exists_forall_sub_mem_ideal (s := S) (fun w => w.asIdeal) e
    (fun w _ => Ideal.prime_of_isPrime w.ne_bot w.isPrime)
    (fun w _ w' _ hne h => hne (HeightOneSpectrum.ext h))
    (fun w => if (w : HeightOneSpectrum (𝓞 K)) = v then n else 0)
  have hval_c : ∀ w : HeightOneSpectrum (𝓞 K), w.intValuation c = WithZero.exp (-(e w : ℤ)) :=
    fun w => w.intValuation_eq_exp_neg_multiplicity hc0
  have hpos : ∀ w : HeightOneSpectrum (𝓞 K), 0 < w.intValuation c := fun w => by
    rw [hval_c]; exact WithZero.exp_pos
  refine ⟨algebraMap (𝓞 K) K y / algebraMap (𝓞 K) K c, ?_, ?_⟩
  · intro w hw
    rw [map_div₀, valuation_of_algebraMap, valuation_of_algebraMap, div_le_one₀ (hpos w)]
    by_cases hwS : w ∈ S
    · have h1 := hy w hwS
      simp only [hw, if_false, sub_zero] at h1
      rw [hval_c]
      exact (w.intValuation_le_pow_iff_mem y (e w)).mpr h1
    · have hwc : ¬ w.asIdeal ∣ Ideal.span {c} := fun h =>
        hwS (Finset.mem_insert_of_mem (hfin.mem_toFinset.mpr h))
      have he : e w = 0 := multiplicity_eq_zero.mpr hwc
      rw [hval_c, he]
      simpa using w.intValuation_le_one y
  · have hsc : s = algebraMap (𝓞 K) K n / algebraMap (𝓞 K) K c := by
      rw [eq_div_iff hcK]; exact hs
    have hdiff : s - algebraMap (𝓞 K) K y / algebraMap (𝓞 K) K c =
        algebraMap (𝓞 K) K (n - y) / algebraMap (𝓞 K) K c := by
      rw [hsc, map_sub, sub_div]
    rw [hdiff, map_div₀, valuation_of_algebraMap, valuation_of_algebraMap, div_le_one₀ (hpos v)]
    have h1 := hy v (Finset.mem_insert_self v _)
    simp only [if_true] at h1
    rw [hval_c, ← neg_sub, Valuation.map_neg]
    exact (v.intValuation_le_pow_iff_mem _ (e v)).mpr h1

/-- **G1**, the leaf: every `z ∈ K_v` is congruent modulo `O_v` to an element of `K` integral at every prime `≠ v`
(density of `K` in `K_v`, then G1b). -/
theorem G1_approx (v : HeightOneSpectrum (𝓞 K)) (z : v.adicCompletion K) :
    ∃ t : K, (∀ w ≠ v, w.valuation K t ≤ 1) ∧ z - (t : v.adicCompletion K) ∈ v.adicCompletionIntegers K := by
  have hopen : IsOpen {x : v.adicCompletion K | z - x ∈ v.adicCompletionIntegers K} :=
    (Valued.isOpen_valuationSubring _).preimage (continuous_const.sub continuous_id)
  obtain ⟨s, hs⟩ := (v.denseRange_algebraMap K).exists_mem_open hopen ⟨z, by simp⟩
  obtain ⟨t, ht, hst⟩ := G1b_crt v s
  refine ⟨t, ht, ?_⟩
  have hst' : ((s - t : K) : v.adicCompletion K) ∈ v.adicCompletionIntegers K := by
    rw [mem_adicCompletionIntegers, valuedAdicCompletion_eq_valuation']; exact hst
  have hsa : algebraMap K (v.adicCompletion K) s = (s : v.adicCompletion K) := by
    simp [algebraMap_adicCompletion]
  have hsub : ((s - t : K) : v.adicCompletion K) = (s : v.adicCompletion K) - (t : v.adicCompletion K) := by
    have := map_sub (algebraMap K (v.adicCompletion K)) s t
    simpa [algebraMap_adicCompletion] using this
  rw [show z - (t : v.adicCompletion K) = (z - algebraMap K _ s) + ((s - t : K) : v.adicCompletion K) by
    rw [hsub, hsa]; ring]
  exact add_mem hs hst'
