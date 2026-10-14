import Mathlib.NumberTheory.NumberField.CanonicalEmbedding.Basic
import Mathlib.RingTheory.Trace.Basic

/-!
# Lane T, the archimedean place: the trace on `K ⊗ ℝ` and its duality (FS-131, job FS131-KT1; skeleton)

The archimedean half of the standard character of form G (`plans/FS131-KT1-tate.md` § Stage 3): `ψ_∞(b) := e(Tr_∞ b)` on
Mathlib's mixed space of a number field `K`.

**Read aloud.**
* `archTrace K` — the `ℝ`-linear map `K ⊗ ℝ → ℝ` sending the image of each element of an integral basis to its trace
  (`mixedEmbedding.latticeBasis`, an `ℝ`-basis of the mixed space made of the images of an integral basis). By construction it
  extends `Tr_{K/ℚ}`: `archTrace_mixedEmbedding`.
* `exists_eq_mixedEmbedding_of_archTrace_int` — **the archimedean duality**: a point `b` with `Tr_∞(b·s)` an integer for every
  `s ∈ 𝓞 K` is the image of an element of `K` (the Gram matrix `Tr(eᵢ eⱼ)` is rational and invertible, its determinant the
  discriminant).
* `archTrace_mixedEmbedding_one` — `Tr_∞(1) = [K : ℚ] ≠ 0`, so `ψ_∞` is not trivial.

**Inhabitants.** Statements over every number field; the definition's spec example is `archTrace_mixedEmbedding` itself.
-/

namespace HadwigerNelson.Rigidity

open NumberField NumberField.mixedEmbedding

variable (K : Type*) [Field K] [NumberField K]

/-- **The archimedean trace `Tr_∞ : K ⊗ ℝ → ℝ`**, on Mathlib's mixed space: the `ℝ`-linear map that sends the image of each
element of an integral basis to its trace. -/
noncomputable def archTrace : mixedSpace K →ₗ[ℝ] ℝ :=
  (latticeBasis K).constr ℝ fun i => ((Algebra.trace ℚ K (integralBasis K i) : ℚ) : ℝ)

variable {K}

/-- **`Tr_∞` extends the trace** of `K`. -/
theorem archTrace_mixedEmbedding (x : K) : archTrace K (mixedEmbedding K x) = (Algebra.trace ℚ K x : ℝ) := by
  sorry

/-- **The archimedean duality**: if `Tr_∞(b · s) ∈ ℤ` for every `s ∈ 𝓞 K`, then `b` is the image of an element of `K`, and
that element's traces against `𝓞 K` are the same integers. -/
theorem exists_eq_mixedEmbedding_of_archTrace_int (b : mixedSpace K)
    (h : ∀ s : 𝓞 K, ∃ n : ℤ, archTrace K (b * mixedEmbedding K (s : K)) = n) :
    ∃ y : K, b = mixedEmbedding K y := by
  sorry

/-- `Tr_∞(1) = [K : ℚ]`. -/
theorem archTrace_mixedEmbedding_one : archTrace K (mixedEmbedding K 1) = (Module.finrank ℚ K : ℝ) := by
  sorry

end HadwigerNelson.Rigidity
