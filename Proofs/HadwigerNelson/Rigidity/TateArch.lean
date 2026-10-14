import Mathlib.NumberTheory.NumberField.CanonicalEmbedding.Basic
import Mathlib.RingTheory.Trace.Basic

/-!
# Lane T, the archimedean place: the trace on `K ⊗ ℝ` and its duality (FS-131, job FS131-KT1)

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
  classical
  rw [archTrace, Module.Basis.constr_apply_fintype]
  simp only [Module.Basis.equivFun_apply, latticeBasis_repr_apply, smul_eq_mul]
  conv_rhs => rw [← (integralBasis K).sum_repr x]
  rw [map_sum, Rat.cast_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [map_smul, smul_eq_mul, Rat.cast_mul]

/-- **The archimedean duality**: if `Tr_∞(b · s) ∈ ℤ` for every `s ∈ 𝓞 K`, then `b` is the image of an element of `K`, and
that element's traces against `𝓞 K` are the same integers. -/
theorem exists_eq_mixedEmbedding_of_archTrace_int (b : mixedSpace K)
    (h : ∀ s : 𝓞 K, ∃ n : ℤ, archTrace K (b * mixedEmbedding K (s : K)) = n) :
    ∃ y : K, b = mixedEmbedding K y := by
  classical
  -- `Φ b = (Tr_∞(b · ι_∞ eⱼ))ⱼ`, an `ℝ`-linear map from the mixed space onto `ℝ^n`, hence injective
  let e := integralBasis K
  let Φ : mixedSpace K →ₗ[ℝ] (Module.Free.ChooseBasisIndex ℤ (𝓞 K) → ℝ) :=
    LinearMap.pi fun j => (archTrace K).comp (LinearMap.mulRight ℝ (mixedEmbedding K (e j)))
  have hΦ : ∀ c j, Φ c j = archTrace K (c * mixedEmbedding K (e j)) := fun _ _ => rfl
  have hΦK : ∀ y : K, ∀ j, Φ (mixedEmbedding K y) j = (Algebra.trace ℚ K (y * e j) : ℝ) := fun y j => by
    rw [hΦ, ← map_mul, archTrace_mixedEmbedding]
  -- the dual basis of `e` for the trace form
  let B := Algebra.traceForm ℚ K
  have hB : B.Nondegenerate := traceForm_nondegenerate ℚ K
  let d := B.dualBasis hB e
  have hd : ∀ i j, Algebra.trace ℚ K (d i * e j) = if j = i then 1 else 0 := fun i j => by
    rw [← Algebra.traceForm_apply]; exact LinearMap.BilinForm.apply_dualBasis_left hB e i j
  have hsurj : Function.Surjective Φ := by
    rw [← LinearMap.range_eq_top, Submodule.eq_top_iff']
    intro v
    rw [pi_eq_sum_univ v]
    refine Submodule.sum_mem _ fun i _ => Submodule.smul_mem _ _ ⟨mixedEmbedding K (d i), ?_⟩
    funext j
    rw [hΦK, hd]
    by_cases hij : i = j
    · subst hij; simp
    · simp [hij, Ne.symm hij]
  have hinj : Function.Injective Φ := by
    refine (LinearMap.injective_iff_surjective_of_finrank_eq_finrank ?_).2 hsurj
    rw [Module.finrank_eq_card_basis (latticeBasis K), Module.finrank_fintype_fun_eq_card]
  -- the integers `nⱼ`, and `y := Σ nⱼ dⱼ`
  choose n hn using fun j => h (RingOfIntegers.basis K j)
  refine ⟨∑ i, (n i : ℚ) • d i, hinj (funext fun j => ?_)⟩
  rw [hΦK, Finset.sum_mul, map_sum, Rat.cast_sum]
  simp_rw [smul_mul_assoc, map_smul, hd, smul_eq_mul, mul_ite, mul_one, mul_zero]
  rw [Finset.sum_eq_single j (fun i _ hij => by rw [if_neg (Ne.symm hij), Rat.cast_zero])
    (fun hj => absurd (Finset.mem_univ j) hj), if_pos rfl, hΦ]
  have := hn j
  rw [show e j = ((RingOfIntegers.basis K j : 𝓞 K) : K) from integralBasis_apply K j]
  rw [this]
  push_cast; rfl

/-- `Tr_∞(1) = [K : ℚ]`. -/
theorem archTrace_mixedEmbedding_one : archTrace K (mixedEmbedding K 1) = (Module.finrank ℚ K : ℝ) := by
  rw [archTrace_mixedEmbedding, ← (algebraMap ℚ K).map_one, Algebra.trace_algebraMap, nsmul_eq_mul, mul_one,
    Rat.cast_natCast]

end HadwigerNelson.Rigidity
