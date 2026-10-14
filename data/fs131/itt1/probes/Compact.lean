import Mathlib.RingTheory.DedekindDomain.AdicValuation
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.NumberTheory.NumberField.Completion.FinitePlace
import Mathlib.Topology.Algebra.Valued.LocallyCompact

open IsDedekindDomain IsDedekindDomain.HeightOneSpectrum NumberField

variable {K : Type*} [Field K] [NumberField K]

example (v : HeightOneSpectrum (𝓞 K)) :
    (v.adicCompletionIntegers K : Set (v.adicCompletion K)) = (Valued.integer (v.adicCompletion K) : Set _) := rfl

example (v : HeightOneSpectrum (𝓞 K)) (h : CompactSpace (Valued.integer (v.adicCompletion K))) :
    CompactSpace (v.adicCompletionIntegers K) := h

#check @Valued.integer.compactSpace_iff_completeSpace_and_isDiscreteValuationRing_and_finite_residueField
#check @Valued.isClosed_integer
#check @IsClosed.completeSpace_coe
#check @Ideal.finiteQuotientOfFreeOfNeBot
#check @Valuation.Integers.isUnit_iff_valuation_eq_one
#check @Valuation.integer.integers
example (v : HeightOneSpectrum (𝓞 K)) : (Valued.v : Valuation (v.adicCompletion K) ℤᵐ⁰).RankOne := inferInstance
example (v : HeightOneSpectrum (𝓞 K)) : IsDiscreteValuationRing (Valued.integer (v.adicCompletion K)) :=
  inferInstanceAs (IsDiscreteValuationRing (v.adicCompletionIntegers K))
example (v : HeightOneSpectrum (𝓞 K)) : Finite (𝓞 K ⧸ v.asIdeal) := inferInstance
