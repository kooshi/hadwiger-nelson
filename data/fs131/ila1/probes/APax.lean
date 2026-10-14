import Proofs.HadwigerNelson.SpectralChain
import Mathlib.NumberTheory.NumberField.Ideal.KummerDedekind
import Mathlib.NumberTheory.NumberField.Discriminant.Different
import Mathlib.NumberTheory.NumberField.Norm
import Mathlib.NumberTheory.RamificationInertia.Unramified
import Mathlib.RingTheory.Norm.Transitivity
import Mathlib.FieldTheory.PrimitiveElement
import Mathlib.NumberTheory.Padics.PadicVal.Basic

/-!
# A degree-one unramified prime at every number field, and two unit vectors of `F(i)` for the admissible pair (FS-131, job FS131-ILA1)
-/

namespace HadwigerNelson.Rigidity

open NumberField Polynomial SpectralChain IntermediateField

noncomputable section

/-! ## Schur: a nonconstant integral polynomial has prime divisors of its values outside any finite set -/

private theorem schur_prime (f : ℤ[X]) (hf : 0 < f.natDegree) (M : ℕ) (hM : M ≠ 0) :
    ∃ q : ℕ, q.Prime ∧ ¬ q ∣ M ∧ ∃ t : ℤ, (q : ℤ) ∣ f.eval t := by
  by_cases hc : f.eval 0 = 0
  · obtain ⟨q, hqM, hq⟩ := Nat.exists_infinite_primes (M + 1)
    refine ⟨q, hq, fun h => ?_, q, ?_⟩
    · have := Nat.le_of_dvd (Nat.pos_of_ne_zero hM) h
      omega
    · have h := sub_dvd_eval_sub (q : ℤ) 0 f
      rwa [hc, sub_zero, sub_zero] at h
  set c := f.eval 0 with hcdef
  set N : ℤ := 2 * M with hN
  have hN0 : N ≠ 0 := by
    rw [hN]
    exact mul_ne_zero two_ne_zero (by exact_mod_cast hM)
  have hcN : c * N ≠ 0 := mul_ne_zero hc hN0
  have hg1 : f - C c ≠ 0 := by
    intro h
    have h' : (f - C c).natDegree = f.natDegree := natDegree_sub_C
    rw [h, natDegree_zero] at h'
    omega
  have hg2 : f + C c ≠ 0 := by
    intro h
    have h' : (f + C c).natDegree = f.natDegree := natDegree_add_C
    rw [h, natDegree_zero] at h'
    omega
  have hG : (f - C c) * (f + C c) ≠ 0 := mul_ne_zero hg1 hg2
  have hinj : Function.Injective (fun t : ℕ => c * N * (t : ℤ)) := by
    intro a b hab
    exact_mod_cast mul_left_cancel₀ hcN hab
  obtain ⟨x, ⟨t, rfl⟩, hx⟩ :=
    (Set.infinite_range_of_injective hinj).exists_notMem_finset ((f - C c) * (f + C c)).roots.toFinset
  rw [Multiset.mem_toFinset, mem_roots hG, IsRoot, eval_mul, eval_sub, eval_add, eval_C, mul_eq_zero,
    not_or] at hx
  obtain ⟨k, hk⟩ := sub_dvd_eval_sub (c * N * (t : ℤ)) 0 f
  have hY : f.eval (c * N * t) = c * (1 + N * t * k) := by
    rw [← hcdef] at hk
    linear_combination hk
  have hY1 : (1 + N * t * k).natAbs ≠ 1 := by
    intro h1
    rcases Int.natAbs_eq_iff.mp h1 with h | h
    · exact hx.1 (by rw [hY, h]; push_cast; ring)
    · exact hx.2 (by rw [hY, h]; push_cast; ring)
  obtain ⟨q, hq, hqY⟩ := Nat.exists_prime_and_dvd hY1
  have hqY' : (q : ℤ) ∣ 1 + N * t * k := Int.natCast_dvd.mpr hqY
  refine ⟨q, hq, fun hqM => ?_, c * N * t, ?_⟩
  · have hqN : (q : ℤ) ∣ N * t * k :=
      Dvd.dvd.mul_right (Dvd.dvd.mul_right (Dvd.dvd.mul_left (Int.natCast_dvd_natCast.mpr hqM) 2) _) _
    have h1 : (q : ℤ) ∣ 1 := by
      have := dvd_sub hqY' hqN
      simpa using this
    have : q = 1 := by exact_mod_cast Int.eq_one_of_dvd_one (by positivity) h1
    exact hq.one_lt.ne' this
  · rw [hY]
    exact Dvd.dvd.mul_left hqY' c

/-! ## An integral primitive element, and a nonzero integer in its conductor -/

private theorem exists_integral_primitive (K : Type*) [Field K] [NumberField K] :
    ∃ θ : 𝓞 K, ℚ⟮(θ : K)⟯ = ⊤ := by
  obtain ⟨α, hα⟩ := Field.exists_primitive_element ℚ K
  obtain ⟨y, hy0, hy⟩ :=
    ((IsFractionRing.isAlgebraic_iff ℤ ℚ K).mpr (Algebra.IsAlgebraic.isAlgebraic α)).exists_integral_multiple
  have hy' : (y : K) ≠ 0 := by exact_mod_cast hy0
  have hmem : α ∈ ℚ⟮y • α⟯ := by
    have h : α = (y : K)⁻¹ * (y • α) := by
      rw [zsmul_eq_mul, inv_mul_cancel_left₀ hy']
    have h2 : (y : K)⁻¹ * (y • α) ∈ ℚ⟮y • α⟯ :=
      mul_mem (inv_mem (intCast_mem ℚ⟮y • α⟯ y)) (IntermediateField.mem_adjoin_simple_self ℚ _)
    rwa [← h] at h2
  refine ⟨⟨y • α, hy⟩, ?_⟩
  rw [eq_top_iff, ← hα, IntermediateField.adjoin_simple_le_iff]
  exact hmem

private theorem exists_dvd_of_dvd_exponent (K : Type*) [Field K] [NumberField K] {θ : 𝓞 K}
    (hθ : ℚ⟮(θ : K)⟯ = ⊤) :
    ∃ E : ℕ, E ≠ 0 ∧ ∀ q : ℕ, q ∣ RingOfIntegers.exponent θ → q ∣ E := by
  have hadj : Algebra.adjoin ℚ {algebraMap (𝓞 K) K θ} = ⊤ :=
    (IntermediateField.adjoin_simple_eq_top_iff_of_isAlgebraic (Algebra.IsAlgebraic.isAlgebraic _)).mp hθ
  have hC := conductor_mul_differentIdeal ℤ ℚ K θ hadj
  have hne₁ : aeval (algebraMap (𝓞 K) K θ) (derivative (minpoly ℚ (algebraMap (𝓞 K) K θ))) ≠ 0 :=
    (Algebra.IsSeparable.isSeparable _ _).aeval_derivative_ne_zero (minpoly.aeval _ _)
  have hne : aeval θ (derivative (minpoly ℤ θ)) ≠ 0 := by
    intro h0
    apply hne₁
    rw [minpoly.isIntegrallyClosed_eq_field_fractions ℚ K θ.isIntegral, derivative_map, aeval_map_algebraMap,
      aeval_algebraMap_apply, h0, map_zero]
  have hCbot : conductor ℤ θ ≠ ⊥ := by
    intro h
    rw [h, Ideal.bot_mul] at hC
    exact hne (Ideal.span_singleton_eq_bot.mp hC.symm)
  refine ⟨Ideal.absNorm (conductor ℤ θ), Ideal.absNorm_eq_zero_iff.not.mpr hCbot, fun q hqe => ?_⟩
  have hmem : ((Ideal.absNorm (conductor ℤ θ) : ℤ)) ∈ Ideal.under ℤ (conductor ℤ θ) := by
    rw [Ideal.under, Ideal.mem_comap, eq_intCast, Int.cast_natCast]
    exact Ideal.absNorm_mem _
  rw [← Int.ideal_span_absNorm_eq_self (Ideal.under ℤ (conductor ℤ θ)), Ideal.mem_span_singleton] at hmem
  exact hqe.trans (Int.natCast_dvd_natCast.mp hmem)

/-! ## The residue homomorphism at a root modulo `q`, and the unramified square -/

private theorem nonempty_residueHom (K : Type*) [Field K] [NumberField K] {θ : 𝓞 K} {q : ℕ} [Fact q.Prime]
    (hq : ¬ q ∣ RingOfIntegers.exponent θ) {t : ℤ} (ht : (q : ℤ) ∣ (minpoly ℤ θ).eval t) :
    Nonempty (𝓞 K →+* ZMod q) := by
  let e := RingOfIntegers.ZModXQuotSpanEquivQuotSpan hq
  let ev : (ZMod q)[X] ⧸ Ideal.span {(minpoly ℤ θ).map (Int.castRingHom (ZMod q))} →+* ZMod q :=
    Ideal.Quotient.lift _ (Polynomial.evalRingHom (t : ZMod q)) (by
      intro a ha
      obtain ⟨b, rfl⟩ := Ideal.mem_span_singleton'.mp ha
      rw [map_mul, coe_evalRingHom, eval_intCast_map, eq_intCast, Int.cast_id,
        (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).mpr ht,
        mul_zero])
  exact ⟨ev.comp (e.symm.toRingHom.comp (Ideal.Quotient.mk _))⟩

private theorem natCast_notMem_sq (K : Type*) [Field K] [NumberField K] {q : ℕ} (hq : q.Prime)
    (hd : ¬ (q : ℤ) ∣ discr K) (P : Ideal (𝓞 K)) [P.IsMaximal] (hqP : (q : 𝓞 K) ∈ P) : (q : 𝓞 K) ∉ P ^ 2 := by
  have hqZ : Prime (q : ℤ) := Nat.prime_iff_prime_int.mp hq
  have hP : algebraMap ℤ (𝓞 K) (q : ℤ) ∈ P := by simpa using hqP
  haveI : Algebra.IsUnramifiedAt ℤ P :=
    (NumberField.not_dvd_discr_iff_forall_mem K (𝓞 K) hqZ).mp hd P inferInstance (by simpa using hqP)
  have h1 : P.ramificationIdx ℤ = 1 := Ideal.ramificationIdx_eq_one P ℤ
  haveI : P.LiesOver (Ideal.span {(q : ℤ)}) :=
    (Ideal.liesOver_span_iff (Ideal.IsMaximal.ne_top inferInstance) hqZ).mpr hP
  have h2 : (Ideal.span {(q : ℤ)}).ramificationIdx' P = 1 := by
    rw [Ideal.ramificationIdx'_eq_ramificationIdx _ P (by simp [hq.ne_zero]), h1]
  have hle : Ideal.map (algebraMap ℤ (𝓞 K)) (Ideal.span {(q : ℤ)}) ≤ P := by
    rw [Ideal.map_span, Set.image_singleton, Ideal.span_singleton_le_iff_mem]
    exact hP
  intro hsq
  refine (Ideal.ramificationIdx'_ne_one_iff hle).mpr ?_ h2
  rw [Ideal.map_span, Set.image_singleton, Ideal.span_singleton_le_iff_mem]
  simpa using hsq

/-- **A degree-one, unramified prime above a rational prime outside any finite set, at every number field**: for every
`M ≠ 0` there are a prime `p ∤ M` and a ring homomorphism `φ : 𝓞 K → ℤ/p` (onto, so its kernel `𝔓` is a maximal ideal
with `p` elements in the quotient) with `p ∉ 𝔓²`. Proved by Schur's argument for the prime divisors of the values of the
minimal polynomial of an integral primitive element `θ`, Mathlib's Kummer–Dedekind isomorphism
`𝓞 K ⧸ (p) ≃ (ℤ/p)[X] ⧸ (minpoly θ)` at a prime not dividing the conductor's exponent (evaluation at a root modulo `p`),
and `p ∤ disc K` (`NumberField.not_dvd_discr_iff_forall_mem`) for `p ∉ 𝔓²`. -/
theorem exists_residueHom_unramified (K : Type*) [Field K] [NumberField K] (M : ℕ) (hM : M ≠ 0) :
    ∃ (p : ℕ) (φ : 𝓞 K →+* ZMod p), p.Prime ∧ ¬ p ∣ M ∧ (p : 𝓞 K) ∉ RingHom.ker φ ^ 2 := by
  obtain ⟨θ, hθ⟩ := exists_integral_primitive K
  obtain ⟨E, hE0, hE⟩ := exists_dvd_of_dvd_exponent K hθ
  have hD : (discr K).natAbs ≠ 0 := Int.natAbs_ne_zero.mpr (discr_ne_zero K)
  have hdeg : 0 < (minpoly ℤ θ).natDegree := minpoly.natDegree_pos θ.isIntegral
  obtain ⟨q, hq, hqM', t, ht⟩ :=
    schur_prime (minpoly ℤ θ) hdeg (M * E * (discr K).natAbs) (mul_ne_zero (mul_ne_zero hM hE0) hD)
  haveI : Fact q.Prime := ⟨hq⟩
  have hqM : ¬ q ∣ M := fun h => hqM' (dvd_mul_of_dvd_left (dvd_mul_of_dvd_left h _) _)
  have hqE : ¬ q ∣ RingOfIntegers.exponent θ := fun h =>
    hqM' (dvd_mul_of_dvd_left (dvd_mul_of_dvd_right (hE q h) _) _)
  have hqD : ¬ (q : ℤ) ∣ discr K := fun h => hqM' (dvd_mul_of_dvd_right (Int.natCast_dvd.mp h) _)
  obtain ⟨φ⟩ := nonempty_residueHom K hqE ht
  have hmax : (RingHom.ker φ).IsMaximal := RingHom.ker_isMaximal_of_surjective φ (ZMod.ringHom_surjective φ)
  refine ⟨q, φ, hq, hqM, natCast_notMem_sq K hq hqD _ ?_⟩
  rw [RingHom.mem_ker, map_natCast, ZMod.natCast_self]

end

end HadwigerNelson.Rigidity
#print axioms HadwigerNelson.Rigidity.exists_residueHom_unramified
