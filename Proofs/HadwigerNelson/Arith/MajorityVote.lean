import Mathlib.Probability.Moments.Variance
import Mathlib.MeasureTheory.Function.ConvergenceInMeasure

/-!
# Majority decoding (FS131-E8-SI5C), the step under J45-SI-5 (c) (FS-131 wave 10, second planning pass)

**Read aloud, against the informal claim.** `plans/FS131-E8-derivation.md` § 5.1, entry FS131-E8-SI5C: "let I be a
countably infinite set, G a random variable with values in a finite set, c = (c(x)) for x in I random variables with values
in the same finite set, and ε = (ε(x)) for x in I indicator variables, pairwise independent, each of probability p < 1/2,
such that almost surely c(x) ≠ G implies ε(x) = 1 for every x in I; then G is almost surely equal to a function of c,
measurable for the σ-algebra c generates". It replaces "ergodic averages along a tempered Følner sequence" in J45-SI-5 (c).

**The class the argument reads** (Chebyshev for a sum of pairwise uncorrelated indicators, a strict majority, and a
subsequence converging almost surely) is wider than the entry's in three ways, all in the statement: the index set need
only be infinite; the events need only have probability **at most** `p < 1/2` (not equal probabilities); and "almost
surely … for every `x`" is read one `x` at a time. Mathlib's strong law at the pin (`ProbabilityTheory.strong_law_ae`,
Etemadi's: pairwise independent, **identically distributed**) serves the entry's class and not this one, so the plan is
Chebyshev written out (`ProbabilityTheory.meas_ge_le_variance_div_sq`, `ProbabilityTheory.IndepFun.variance_sum`).

**Inhabitants.** The degenerate model (`E x = ∅`, `c x = G`) satisfies every hypothesis and makes the conclusion trivial
(the spec example); the entry's model — `I = ℕ`, `G` uniform on two values, `ε` i.i.d. of probability `1/3` — exercises the
clause `c x ≠ G → E x` and needs an infinite product measure, not built here.
-/

namespace HadwigerNelson.MajorityVote

open MeasureTheory

/-- **FS131-E8-SI5C — majority decoding.** A finite-valued `G` that every `c x` equals unless an event `E x` of
probability at most `p < 1/2` occurs, the `E x` pairwise independent over an infinite index set, is almost surely equal to
a function measurable for the σ-algebra the `c x` generate. -/
theorem ae_eq_measurable_of_majority {Ω I K : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
    [Infinite I] [Finite K] [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K) (hG : Measurable G)
    (c : I → Ω → K) (hc : ∀ x, Measurable (c x)) (E : I → Set Ω) (hE : ∀ x, MeasurableSet (E x)) {p : ℝ}
    (hp : p < 1 / 2) (hEp : ∀ x, μ.real (E x) ≤ p)
    (hindep : ∀ x y, x ≠ y → μ (E x ∩ E y) = μ (E x) * μ (E y))
    (hGc : ∀ x, ∀ᵐ ω ∂μ, c x ω ≠ G ω → ω ∈ E x) :
    ∃ g : Ω → K, Measurable[⨆ x, MeasurableSpace.comap (c x) inferInstance] g ∧ G =ᵐ[μ] g := by
  sorry

/-! ## Spec -/

-- the degenerate model: no error event, every `c x` is `G`; all hypotheses hold at `p = 0`.
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] (G : Ω → Bool) (hG : Measurable G) :
    ∃ g : Ω → Bool, Measurable[⨆ _x : ℕ, MeasurableSpace.comap G inferInstance] g ∧ G =ᵐ[μ] g :=
  ae_eq_measurable_of_majority G hG (fun _ : ℕ => G) (fun _ => hG) (fun _ => ∅) (fun _ => MeasurableSet.empty)
    (p := 0) (by norm_num) (fun _ => by simp) (fun _ _ _ => by simp) (fun _ => by simp)

end HadwigerNelson.MajorityVote
