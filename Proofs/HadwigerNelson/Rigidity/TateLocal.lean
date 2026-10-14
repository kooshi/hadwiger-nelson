import Mathlib.RingTheory.DedekindDomain.AdicValuation
import Mathlib.RingTheory.DedekindDomain.Ideal.Lemmas
import Mathlib.RingTheory.DedekindDomain.Factorization
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.NumberTheory.NumberField.Completion.FinitePlace
import Mathlib.RingTheory.Trace.Basic
import Mathlib.Topology.Algebra.Valued.LocallyCompact

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
  sorry

/-- **Approximation away from one prime, in the completion**: every `z ∈ K_v` is congruent modulo `O_v` to an element of `K`
integral at every prime `≠ v`. -/
theorem exists_approx_completion (v : HeightOneSpectrum (𝓞 K)) (z : v.adicCompletion K) :
    ∃ t : K, (∀ w ≠ v, w.valuation K t ≤ 1) ∧ z - (t : v.adicCompletion K) ∈ v.adicCompletionIntegers K := by
  sorry

/-- **Integral traces**: an element of `K` integral at every prime has its trace in `ℤ`. -/
theorem exists_int_trace_of_integral (x : K) (h : ∀ v : HeightOneSpectrum (𝓞 K), v.valuation K x ≤ 1) :
    ∃ n : ℤ, Algebra.trace ℚ K x = n := by
  sorry

/-- **Local non-degeneracy, the seed**: at every prime `v` some element of `K` integral at every other prime has a trace
outside `ℤ` (else `𝓞[1/v]` would lie in the trace dual of `𝓞`, whose denominators are bounded:
`exists_nat_mul_integral_of_trace_int`). -/
theorem exists_trace_not_int_away (v : HeightOneSpectrum (𝓞 K)) :
    ∃ t : K, (∀ w ≠ v, w.valuation K t ≤ 1) ∧ ∀ n : ℤ, Algebra.trace ℚ K t ≠ n := by
  sorry

/-- **The trace dual of `𝓞 K` has bounded denominators**: some integer `d₀ ≥ 1` makes `d₀·y` integral for every `y` whose
traces against `𝓞 K` are integers (the dual basis of an integral basis, `traceForm_nondegenerate`). -/
theorem exists_nat_mul_integral_of_trace_int :
    ∃ d₀ : ℕ, d₀ ≠ 0 ∧ ∀ y : K, (∀ s : 𝓞 K, ∃ n : ℤ, Algebra.trace ℚ K (y * s) = n) →
      ∀ v : HeightOneSpectrum (𝓞 K), v.valuation K ((d₀ : K) * y) ≤ 1 := by
  sorry

/-- **`O_v` is compact**: complete, a discrete valuation ring, with finite residue field
(`Valued.integer.compactSpace_iff_completeSpace_and_isDiscreteValuationRing_and_finite_residueField`; the residue field is a
quotient of `𝓞 K ⧸ v`, by `exists_valuation_sub_lt_of_integer` and the density of `K`). -/
theorem compactSpace_adicCompletionIntegers (v : HeightOneSpectrum (𝓞 K)) :
    CompactSpace (v.adicCompletionIntegers K) := by
  sorry

end HadwigerNelson.Rigidity
