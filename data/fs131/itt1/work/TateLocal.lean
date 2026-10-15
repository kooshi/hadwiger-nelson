import Mathlib.RingTheory.DedekindDomain.AdicValuation
import Mathlib.RingTheory.DedekindDomain.Ideal.Lemmas
import Mathlib.RingTheory.DedekindDomain.Factorization
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.NumberTheory.NumberField.Completion.FinitePlace
import Mathlib.RingTheory.Trace.Basic
import Mathlib.Topology.Algebra.Valued.LocallyCompact
import Mathlib.RingTheory.DedekindDomain.Different
import Mathlib.NumberTheory.NumberField.Discriminant.Defs

/-!
# Lane T, the finite places: approximation away from one prime, integral traces, compact integers (FS-131, job FS131-KT1; skeleton)

The arithmetic of a number field `K` that the standard character of form G reads (`plans/FS131-KT1-tate.md` § Stage 3: the
local character `ψ_v(z) := e(−Tr_{K/ℚ}(t))` for any `t ∈ K` integral at every prime `≠ v` with `z − t ∈ O_v`). Every statement
is over an arbitrary number field: lane T reads them at `K = F(i)`.

**Read aloud.**
* `exists_valuation_le_one_away` — every `s ∈ K` is, at the prime `v`, congruent modulo the integers to an element of `K`
  integral at every other prime (the Chinese remainder theorem).
* `exists_approx_completion` — the same for every `z` of the completion `K_v` (with the density of `K` in `K_v`).
* `exists_int_trace_of_integral` — an element integral at every prime has an integral trace.
* `exists_trace_not_int_away` — some element integral at every prime but `v` has a trace outside `ℤ` (local non-degeneracy).
* `exists_nat_mul_integral_of_trace_int` — the dual lattice of `𝓞 K` under the trace has bounded denominators.
* `compactSpace_adicCompletionIntegers` — `O_v` is compact (its residue field is finite).

**Route copies.** The first three are elaborated in full in `data/fs131/kt1/scratch/FormG.lean` (FS131-KT1's measurement):
the implementer folds them in.

**Inhabitants.** Statements about every prime of every number field; no hypothesis beyond the field to model.
-/

namespace HadwigerNelson.Rigidity

open IsDedekindDomain IsDedekindDomain.HeightOneSpectrum NumberField

variable {K : Type*} [Field K] [NumberField K]

/-- **Approximation away from one prime** (the Chinese remainder step): every `s ∈ K` is, at `v`, congruent modulo `O_v` to
an element of `K` integral at every other prime. -/
theorem exists_valuation_le_one_away (v : HeightOneSpectrum (𝓞 K)) (s : K) :
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

/-- **Approximation away from one prime, in the completion**: every `z ∈ K_v` is congruent modulo `O_v` to an element of `K`
integral at every prime `≠ v`. -/
theorem exists_approx_completion (v : HeightOneSpectrum (𝓞 K)) (z : v.adicCompletion K) :
    ∃ t : K, (∀ w ≠ v, w.valuation K t ≤ 1) ∧ z - (t : v.adicCompletion K) ∈ v.adicCompletionIntegers K := by
  have hopen : IsOpen {x : v.adicCompletion K | z - x ∈ v.adicCompletionIntegers K} :=
    (Valued.isOpen_valuationSubring _).preimage (continuous_const.sub continuous_id)
  obtain ⟨s, hs⟩ := (v.denseRange_algebraMap K).exists_mem_open hopen ⟨z, by simp⟩
  obtain ⟨t, ht, hst⟩ := exists_valuation_le_one_away v s
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

/-- **Integral traces**: an element of `K` integral at every prime has its trace in `ℤ`. -/
theorem exists_int_trace_of_integral (x : K) (h : ∀ v : HeightOneSpectrum (𝓞 K), v.valuation K x ≤ 1) :
    ∃ n : ℤ, Algebra.trace ℚ K x = n := by
  obtain ⟨y, rfl⟩ := mem_integers_of_valuation_le_one K x h
  have hint : IsIntegral ℤ (Algebra.trace ℚ K (algebraMap (𝓞 K) K y)) :=
    Algebra.isIntegral_trace (RingOfIntegers.isIntegral_coe y)
  obtain ⟨n, hn⟩ := IsIntegrallyClosed.isIntegral_iff.mp hint
  exact ⟨n, by rw [← hn]; simp⟩

/-- The trace dual's denominators (the proof of `exists_nat_mul_integral_of_trace_int`, stated before its first reader). -/
private theorem exists_nat_mul_integral_of_trace_int' :
    ∃ d₀ : ℕ, d₀ ≠ 0 ∧ ∀ y : K, (∀ s : 𝓞 K, ∃ n : ℤ, Algebra.trace ℚ K (y * s) = n) →
      ∀ v : HeightOneSpectrum (𝓞 K), v.valuation K ((d₀ : K) * y) ≤ 1 := by
  classical
  -- the discriminant `δ` of an integral basis multiplies the trace dual of `𝓞 K` into the integers
  -- (`isIntegral_discr_mul_of_mem_traceDual`); `d₀ := |δ|`
  have hb : ∀ i, IsIntegral ℤ (integralBasis K i) := fun i => by
    rw [integralBasis_apply]; exact RingOfIntegers.isIntegral_coe _
  refine ⟨(discr K).natAbs, Int.natAbs_ne_zero.2 (discr_ne_zero K), fun y hy v => ?_⟩
  have hdual : y ∈ Submodule.traceDual ℤ ℚ (1 : Submodule (𝓞 K) K) := by
    rw [Submodule.mem_traceDual]
    intro a ha
    obtain ⟨s, rfl⟩ := Submodule.mem_one.1 ha
    obtain ⟨n, hn⟩ := hy s
    exact ⟨n, by rw [Algebra.traceForm_apply, eq_intCast]; exact hn.symm⟩
  have hint := isIntegral_discr_mul_of_mem_traceDual (1 : Submodule (𝓞 K) K) hb
    (Submodule.one_le.1 le_rfl : (1 : K) ∈ (1 : Submodule (𝓞 K) K)) hdual
  rw [← coe_discr, smul_mul_assoc, one_mul] at hint
  have hint' : IsIntegral ℤ (((discr K).natAbs : K) * y) := by
    rcases Int.natAbs_eq (discr K) with h | h
    · have : ((discr K).natAbs : K) * y = (discr K : ℚ) • y := by
        rw [Rat.smul_def, Rat.cast_intCast]; nth_rewrite 2 [h]; rw [Int.cast_natCast]
      rwa [this]
    · have : ((discr K).natAbs : K) * y = -((discr K : ℚ) • y) := by
        rw [Rat.smul_def, Rat.cast_intCast]; nth_rewrite 2 [h]; rw [Int.cast_neg, Int.cast_natCast, neg_mul, neg_neg]
      rw [this]; exact hint.neg
  obtain ⟨z, hz⟩ : ∃ z : 𝓞 K, (z : K) = ((discr K).natAbs : K) * y := ⟨⟨_, hint'⟩, rfl⟩
  rw [← hz, valuation_of_algebraMap]
  exact v.intValuation_le_one z


/-- **Local non-degeneracy, the seed**: at every prime `v` some element of `K` integral at every other prime has a trace
outside `ℤ` (else `𝓞[1/v]` would lie in the trace dual of `𝓞`, whose denominators are bounded:
`exists_nat_mul_integral_of_trace_int`). -/
theorem exists_trace_not_int_away (v : HeightOneSpectrum (𝓞 K)) :
    ∃ t : K, (∀ w ≠ v, w.valuation K t ≤ 1) ∧ ∀ n : ℤ, Algebra.trace ℚ K t ≠ n := by
  -- if every element integral off `v` had an integral trace, `d₀ t` would be integral at `v` for every such `t`;
  -- `t ≡ ϖ⁻¹ d₀⁻¹ (mod O_v)` with `0 < v(ϖ) < 1` is not
  by_contra hcon
  push Not at hcon
  obtain ⟨d₀, hd₀, hd⟩ := exists_nat_mul_integral_of_trace_int' (K := K)
  have hint : ∀ (x : 𝓞 K) (w : HeightOneSpectrum (𝓞 K)), w.valuation K (x : K) ≤ 1 := fun x w => by
    rw [valuation_of_algebraMap]; exact w.intValuation_le_one x
  obtain ⟨x, hxv, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot v.ne_bot
  have hxK : (x : K) ≠ 0 := by simpa using hx0
  have hϖ1 : v.valuation K (x : K) < 1 := by
    rw [valuation_of_algebraMap]; exact (v.intValuation_lt_one_iff_mem x).2 hxv
  have hϖ0 : v.valuation K (x : K) ≠ 0 := (Valuation.ne_zero_iff _).2 hxK
  have hdK : (d₀ : K) ≠ 0 := Nat.cast_ne_zero.2 hd₀
  have ha0 : v.valuation K (d₀ : K) ≠ 0 := (Valuation.ne_zero_iff _).2 hdK
  have ha1 : v.valuation K (d₀ : K) ≤ 1 := by
    have h := hint (d₀ : 𝓞 K) v
    rwa [show ((d₀ : 𝓞 K) : K) = (d₀ : K) by simp] at h
  set a := v.valuation K (d₀ : K)
  set c := v.valuation K (x : K)
  obtain ⟨t, ht, hst⟩ := exists_valuation_le_one_away v ((x : K)⁻¹ * (d₀ : K)⁻¹)
  have hs : v.valuation K ((x : K)⁻¹ * (d₀ : K)⁻¹) = c⁻¹ * a⁻¹ := by rw [map_mul, map_inv₀, map_inv₀]
  have h1 : 1 < c⁻¹ := one_lt_inv_iff₀.2 ⟨zero_lt_iff.2 hϖ0, hϖ1⟩
  have h2 : 1 ≤ a⁻¹ := one_le_inv_iff₀.2 ⟨zero_lt_iff.2 ha0, ha1⟩
  have hsgt : 1 < c⁻¹ * a⁻¹ := by
    calc (1 : _) < c⁻¹ := h1
      _ = c⁻¹ * 1 := (mul_one _).symm
      _ ≤ c⁻¹ * a⁻¹ := mul_le_mul_right h2 _
  have htge : c⁻¹ * a⁻¹ ≤ v.valuation K t := by
    rw [← hs]
    have h := Valuation.map_add (v.valuation K) t ((x : K)⁻¹ * (d₀ : K)⁻¹ - t)
    rw [add_sub_cancel] at h
    rcases le_max_iff.1 h with h | h
    · exact h
    · exact absurd (h.trans hst) (not_le.2 (hs ▸ hsgt))
  have hdt := hd t (fun s => hcon (t * s) fun w hw => by
    rw [map_mul]; exact mul_le_one' (ht w hw) (hint s w)) v
  rw [map_mul] at hdt
  have key : c⁻¹ ≤ a * v.valuation K t := by
    calc c⁻¹ = a * (c⁻¹ * a⁻¹) := by rw [mul_comm c⁻¹, mul_inv_cancel_left₀ ha0]
      _ ≤ a * v.valuation K t := mul_le_mul_right htge a
  exact absurd (key.trans hdt) (not_le.2 h1)

/-- **The trace dual of `𝓞 K` has bounded denominators**: some integer `d₀ ≥ 1` makes `d₀·y` integral for every `y` whose
traces against `𝓞 K` are integers (the dual basis of an integral basis, `traceForm_nondegenerate`). -/
theorem exists_nat_mul_integral_of_trace_int :
    ∃ d₀ : ℕ, d₀ ≠ 0 ∧ ∀ y : K, (∀ s : 𝓞 K, ∃ n : ℤ, Algebra.trace ℚ K (y * s) = n) →
      ∀ v : HeightOneSpectrum (𝓞 K), v.valuation K ((d₀ : K) * y) ≤ 1 := by
  exact exists_nat_mul_integral_of_trace_int'

/-- **`O_v` is compact**: complete, a discrete valuation ring, with finite residue field
(`Valued.integer.compactSpace_iff_completeSpace_and_isDiscreteValuationRing_and_finite_residueField`; the residue field is a
quotient of `𝓞 K ⧸ v`, by `exists_valuation_sub_lt_of_integer` and the density of `K`). -/
theorem compactSpace_adicCompletionIntegers (v : HeightOneSpectrum (𝓞 K)) :
    CompactSpace (v.adicCompletionIntegers K) := by
  sorry

end HadwigerNelson.Rigidity
