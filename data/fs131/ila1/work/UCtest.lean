import Proofs.HadwigerNelson.Rigidity.UnitCircle
import Mathlib.NumberTheory.NumberField.Ideal.KummerDedekind
import Mathlib.NumberTheory.NumberField.Discriminant.Different
import Mathlib.NumberTheory.NumberField.Norm
import Mathlib.NumberTheory.RamificationInertia.Unramified
import Mathlib.RingTheory.Norm.Transitivity
import Mathlib.FieldTheory.PrimitiveElement
import Mathlib.NumberTheory.Padics.PadicVal.Basic

/-!
# A degree-one unramified prime at every number field, and two unit vectors of `F(i)` for an admissible pair (FS-131, job FS131-ILA1; lane A of the five-colour chain)

**Read aloud, against the informal claim.** `Rigidity/UnitCircle`'s `exists_admissiblePair` asks, over every real number
field `F`, for unit vectors `u, w` of `F²` — complex numbers of modulus one in `L = F(i)` (`fieldI F`) — that are
multiplicatively independent and such that every finite-index subgroup of `⟨u, w⟩` generates `L` (FS100-X02D l. 146,
PE-1′); through `AdmissiblePair.ofPow` it is enough that `wᵏ` generates `L` for every `k ≥ 1`. This module proves:

* **`exists_residueHom_unramified`**: at every number field `K` and every `M ≠ 0` there are a prime `p ∤ M` and a ring
  homomorphism `φ : 𝓞 K → ℤ/p` with `p ∉ (ker φ)²` — a prime of `K` of degree one above `p`, unramified. By Schur's
  argument for the prime divisors of the values of the minimal polynomial `f` of an integral primitive element `θ`
  (`p ∣ f(t)`), Mathlib's Kummer–Dedekind isomorphism `𝓞 K ⧸ (p) ≃ (ℤ/p)[X] ⧸ (f̄)` at a prime not dividing the exponent of
  `θ`'s conductor (nonzero, by `conductor_mul_differentIdeal`) followed by evaluation at `t̄`, and `p ∤ disc K`
  (`NumberField.not_dvd_discr_iff_forall_mem`) for `p ∉ 𝔓²`.
* **`exists_unitPair`**: the two unit vectors, over every real number field. At such primes `𝔓`, `𝔓′` of `L` above
  distinct odd `p`, `p′`: conjugation moves `𝔓` (`p` odd); `z ∈ 𝔓²` congruent to `1` modulo the cofactor of `𝔓` in `p𝓞`,
  `w = z/z̄`; `z′ ∈ 𝔓′` outside `𝔓̄′`, `𝔓`, `𝔓̄`, `u = z′/z̄′`. **`ℚ⟮wᵏ⟯ = L` by norms**: for `x ∈ M = ℚ⟮wᵏ⟯`,
  `N_{L/ℚ}(x) = N_{M/ℚ}(x)^{[L:M]}`, so `[L : M]` divides `v_p(N_{L/ℚ}(x))`; at `x = wᵐ − p` (`m = k, 2k`) the element
  `zᵐ − p z̄ᵐ` lies in `𝔓`, not in `𝔓²` and in no other prime above `p`, so `v_p(N(wᵐ − p)) = 1 − m·v_p(N(z̄))`, and
  `[L : M]` divides `2(1 − kB) − (1 − 2kB) = 1`. **Independence by membership**: `u^a w^b = 1` with `b > 0` clears to an
  equation in `𝓞 L` whose one side lies in `𝔓` and whose other does not; at `b = 0` the same at `𝔓′`.

No ring of integers of a subfield, no class group and no valuation enter. The archimedean places cannot replace the
`p`-adic step: when `F` is totally real, `L` is a CM field and every conjugate of a unit vector lies on the circle.

**Models.** Both theorems are existence statements over every number field (resp. every real number field) with no
hypothesis beyond `NumberField`; `NumberField ℚ` and `NumberField ↥(⊥ : Subfield ℝ)` are instances, so each is
inhabited at `ℚ`. At `F = ℚ`, `L = ℚ(i)`, `p = 5`, `𝔓 = (2 + i)`: `z = (2 + i)² = 3 + 4i` (`z − 1 = 2i(2 − i)`) and
`w = (3 + 4i)/(3 − 4i) = (−7 + 24i)/25`.
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

/-! ## The core: the norm of a shifted power, and the degree it forces -/

/-- At a degree-one prime `𝔓` above `p`: an `x ∈ 𝔓 \ 𝔓²` in no other prime above `p` has `v_p(N(x)) = 1`. -/
private theorem padicValNat_absNorm_span_eq_one {K : Type*} [Field K] [NumberField K] {p : ℕ} [hp : Fact p.Prime]
    {P : Ideal (𝓞 K)} (hP : Ideal.absNorm P = p) {x : 𝓞 K} (hxP : x ∈ P) (hx2 : x ∉ P ^ 2)
    (hother : ∀ Q : Ideal (𝓞 K), Q.IsMaximal → (p : 𝓞 K) ∈ Q → x ∈ Q → Q = P) :
    padicValNat p (Ideal.absNorm (Ideal.span {x})) = 1 := by
  obtain ⟨J, hJ⟩ : P ∣ Ideal.span {x} := Ideal.dvd_iff_le.mpr ((Ideal.span_singleton_le_iff_mem P).mpr hxP)
  have hx0 : x ≠ 0 := by
    rintro rfl
    exact hx2 (zero_mem _)
  have hJ0 : Ideal.absNorm J ≠ 0 := by
    intro h
    rw [Ideal.absNorm_eq_zero_iff] at h
    rw [h, Ideal.mul_bot, Ideal.span_singleton_eq_bot] at hJ
    exact hx0 hJ
  have hnd : ¬ p ∣ Ideal.absNorm J := by
    intro hpJ
    obtain ⟨Q, hQ, hQu, hQJ⟩ :=
      Ideal.exists_isMaximal_dvd_of_dvd_absNorm (Nat.prime_iff_prime_int.mp hp.out) J (by exact_mod_cast hpJ)
    have hpQ : (p : 𝓞 K) ∈ Q := by
      have h : ((p : ℤ)) ∈ Ideal.under ℤ Q := by
        rw [hQu]
        exact Ideal.mem_span_singleton_self _
      simpa using h
    have hJQ : J ≤ Q := Ideal.le_of_dvd hQJ
    have hxQ : x ∈ Q := hJQ (Ideal.mul_le_left (hJ ▸ Ideal.mem_span_singleton_self x))
    obtain rfl := hother Q hQ hpQ hxQ
    refine hx2 ((show Ideal.span {x} ≤ Q ^ 2 from ?_) (Ideal.mem_span_singleton_self x))
    rw [hJ, sq]
    exact Ideal.mul_mono_right hJQ
  rw [hJ, map_mul, hP, padicValNat.mul hp.out.ne_zero hJ0, padicValNat_self,
    padicValNat.eq_zero_of_not_dvd hnd]

/-- `q𝓞 = 𝔓·R` with `R` coprime to `𝔓` (as `q ∉ 𝔓²`): an element of `𝔓²` congruent to `1` modulo `R`, so in no other
prime above `q`. -/
private theorem exists_mem_sq_forall_notMem {K : Type*} [Field K] [NumberField K] {p : ℕ}
    {P : Ideal (𝓞 K)} [hPm : P.IsMaximal] (hpP : (p : 𝓞 K) ∈ P) (hp2 : (p : 𝓞 K) ∉ P ^ 2) :
    ∃ z : 𝓞 K, z ∈ P ^ 2 ∧ ∀ Q : Ideal (𝓞 K), Q.IsMaximal → (p : 𝓞 K) ∈ Q → Q ≠ P → z ∉ Q := by
  obtain ⟨R, hR⟩ : P ∣ Ideal.span {(p : 𝓞 K)} :=
    Ideal.dvd_iff_le.mpr ((Ideal.span_singleton_le_iff_mem P).mpr hpP)
  have hRP : ¬ R ≤ P := by
    intro h
    apply hp2
    have h' : Ideal.span {(p : 𝓞 K)} ≤ P ^ 2 := by
      rw [hR, sq]
      exact Ideal.mul_mono_right h
    exact h' (Ideal.mem_span_singleton_self _)
  have hcop : P ⊔ R = ⊤ := by
    by_contra h
    exact hRP (le_sup_right.trans (hPm.eq_of_le h le_sup_left).symm.le)
  have hcop2 : R ⊔ P ^ 2 = ⊤ := Ideal.sup_pow_eq_top (by rwa [sup_comm])
  obtain ⟨b, hb, a, ha, hab⟩ := Submodule.mem_sup.mp ((Ideal.eq_top_iff_one _).mp hcop2)
  refine ⟨a, ha, fun Q hQ hpQ hQP haQ => ?_⟩
  have hPR : P * R ≤ Q := by
    rw [← hR]
    exact (Ideal.span_singleton_le_iff_mem Q).mpr hpQ
  rcases (Ideal.IsPrime.mul_le hQ.isPrime).mp hPR with h | h
  · exact hQP (hPm.eq_of_le hQ.ne_top h).symm
  · exact hQ.ne_top ((Ideal.eq_top_iff_one Q).mpr (hab ▸ Q.add_mem (h hb) haQ))

/-- **The norm is a `d`-th power on `ℚ⟮α⟯`**, `d = [L : ℚ⟮α⟯]`, so `d` divides its `p`-adic valuation. -/
private theorem dvd_padicValRat_norm {L : Type*} [Field L] [NumberField L] (p : ℕ) [Fact p.Prime] (α : L)
    (y : ℚ⟮α⟯) : (Module.finrank ℚ⟮α⟯ L : ℤ) ∣ padicValRat p (Algebra.norm ℚ (y : L)) := by
  have h : Algebra.norm ℚ (y : L) = Algebra.norm ℚ y ^ Module.finrank ℚ⟮α⟯ L := by
    rw [← IntermediateField.algebraMap_apply, ← Algebra.norm_norm (S := ℚ⟮α⟯), Algebra.norm_algebraMap, map_pow]
  rw [h, padicValRat.pow]
  exact dvd_mul_right _ _

/-- Three maximal ideals other than `P′`: an element of `P′` in none of them. -/
private theorem exists_mem_notMem_three {R : Type*} [CommRing R] {P' A B C : Ideal R} [hP' : P'.IsMaximal]
    [hA : A.IsMaximal] [hB : B.IsMaximal] [hC : C.IsMaximal] (hPA : P' ≠ A) (hPB : P' ≠ B) (hPC : P' ≠ C) :
    ∃ z : R, z ∈ P' ∧ z ∉ A ∧ z ∉ B ∧ z ∉ C := by
  have h : P' ⊔ A * B * C = ⊤ := by
    rw [← Ideal.isCoprime_iff_sup_eq]
    exact ((Ideal.isCoprime_iff_sup_eq.mpr (hP'.coprime_of_ne hA hPA)).mul_right
      (Ideal.isCoprime_iff_sup_eq.mpr (hP'.coprime_of_ne hB hPB))).mul_right
      (Ideal.isCoprime_iff_sup_eq.mpr (hP'.coprime_of_ne hC hPC))
  obtain ⟨x, hx, y, hy, hxy⟩ := Submodule.mem_sup.mp ((Ideal.eq_top_iff_one _).mp h)
  have hyA : y ∈ A := Ideal.mul_le_right (Ideal.mul_le_right hy)
  have hyB : y ∈ B := Ideal.mul_le_left (Ideal.mul_le_right hy)
  have hyC : y ∈ C := Ideal.mul_le_left hy
  refine ⟨x, hx, fun h => ?_, fun h => ?_, fun h => ?_⟩
  · exact hA.ne_top ((Ideal.eq_top_iff_one A).mpr (hxy ▸ A.add_mem h hyA))
  · exact hB.ne_top ((Ideal.eq_top_iff_one B).mpr (hxy ▸ B.add_mem h hyB))
  · exact hC.ne_top ((Ideal.eq_top_iff_one C).mpr (hxy ▸ C.add_mem h hyC))

/-! ## At `F(i)`: conjugation, the conjugate prime, and the two unit vectors -/

section FieldI

variable {F : Subfield ℝ}

/-- `𝓞 (F(i)) → ℂ`. -/
private def toC (F : Subfield ℝ) : 𝓞 (fieldI F) →+* ℂ :=
  (fieldI F).subtype.comp (algebraMap (𝓞 (fieldI F)) (fieldI F))

private theorem toC_apply (a : 𝓞 (fieldI F)) : toC F a = ((a : fieldI F) : ℂ) := rfl

private theorem toC_injective : Function.Injective (toC F) :=
  Subtype.val_injective.comp RingOfIntegers.coe_injective

private theorem toC_conjO (a : 𝓞 (fieldI F)) : toC F (conjO F a) = starRingEnd ℂ (toC F a) :=
  coe_conjOn (fieldI_conj F) (a : fieldI F)

private theorem conjO_conjO' (a : 𝓞 (fieldI F)) : conjO F (conjO F a) = a :=
  toC_injective (by rw [toC_conjO, toC_conjO, Complex.conj_conj])

private theorem conjO_surjective : Function.Surjective (conjO F) := fun a => ⟨conjO F a, conjO_conjO' a⟩

/-- `i` in `𝓞 (F(i))`. -/
private def iO (F : Subfield ℝ) : 𝓞 (fieldI F) :=
  ⟨⟨Complex.I, ⟨by rw [Complex.I_re]; exact F.zero_mem, by rw [Complex.I_im]; exact F.one_mem⟩⟩,
    IsIntegral.of_pow two_pos (by
      rw [show (⟨Complex.I, _⟩ : fieldI F) ^ 2 = -1 from Subtype.ext (by simp [Complex.I_sq])]
      exact isIntegral_one.neg)⟩

private theorem toC_iO : toC F (iO F) = Complex.I := rfl

/-- **Conjugation moves every degree-one prime above an odd prime** (A4): if it fixed the kernel of `φ : 𝓞 → ℤ/p`,
`φ ∘ conj = φ` (`ZMod.ringHom_eq_of_ker_eq`), so `φ(i) = φ(−i)`, and `φ(i)² = −1` gives `4 = 0` in `ℤ/p`. -/
private theorem comap_conjO_ker_ne {p : ℕ} [hp : Fact p.Prime] (hp2 : p ≠ 2) (φ : 𝓞 (fieldI F) →+* ZMod p) :
    (RingHom.ker φ).comap (conjO F) ≠ RingHom.ker φ := by
  intro h
  have hk : RingHom.ker (φ.comp (conjO F)) = RingHom.ker φ := by
    rw [← RingHom.comap_ker]
    exact h
  have heq := ZMod.ringHom_eq_of_ker_eq _ _ hk
  have hconj : conjO F (iO F) = -iO F := toC_injective (by rw [toC_conjO, map_neg, toC_iO, Complex.conj_I])
  have h1 : φ (-iO F) = φ (iO F) := by
    rw [← hconj]
    exact congrArg (fun g : 𝓞 (fieldI F) →+* ZMod p => g (iO F)) heq
  have hsq : φ (iO F) * φ (iO F) = -1 := by
    rw [← map_mul, show iO F * iO F = -1 from toC_injective (by simp [toC_iO])]
    simp
  rw [map_neg] at h1
  have h4 : ((4 : ℕ) : ZMod p) = 0 := by
    push_cast
    linear_combination 4 * hsq + 2 * φ (iO F) * h1
  have hd : p ∣ 2 ^ 2 := (ZMod.natCast_eq_zero_iff _ _).mp (by simpa using h4)
  exact hp2 ((Nat.prime_dvd_prime_iff_eq hp.out Nat.prime_two).mp (hp.out.dvd_of_dvd_pow hd))

/-- The conjugate of a maximal ideal is maximal, and holds the same rational integers. -/
private theorem comap_conjO_isMaximal (P : Ideal (𝓞 (fieldI F))) [P.IsMaximal] : (P.comap (conjO F)).IsMaximal :=
  Ideal.comap_isMaximal_of_surjective _ conjO_surjective

private theorem natCast_mem_comap_conjO {P : Ideal (𝓞 (fieldI F))} {n : ℕ} (h : (n : 𝓞 (fieldI F)) ∈ P) :
    (n : 𝓞 (fieldI F)) ∈ P.comap (conjO F) := by
  rw [Ideal.mem_comap, map_natCast]
  exact h

/-- `x / x̄` has modulus one. -/
private theorem norm_div_conj {a : 𝓞 (fieldI F)} (ha : conjO F a ≠ 0) : ‖toC F a / toC F (conjO F a)‖ = 1 := by
  have h0 : toC F a ≠ 0 := fun h => ha (by rw [toC_injective (h.trans (map_zero _).symm), map_zero])
  rw [norm_div, toC_conjO, Complex.norm_conj, div_self (norm_ne_zero_iff.mpr h0)]

/-- **`ℚ⟮wᵏ⟯ = F(i)` for every `k ≥ 1`** (the core, by norms): `w = z / z̄` with `z ∈ 𝔓²` in no other prime above `p`
and `z̄ ∉ 𝔓`; `v_p(N(wᵐ − p)) = 1 − m·v_p(N(z̄))` at `m = k, 2k`, and `[F(i) : ℚ⟮wᵏ⟯]` divides both. -/
private theorem adjoin_pow_eq_top [NumberField F] {p : ℕ} [hp : Fact p.Prime] (φ : 𝓞 (fieldI F) →+* ZMod p)
    (hsq : (p : 𝓞 (fieldI F)) ∉ RingHom.ker φ ^ 2) {z : 𝓞 (fieldI F)} (hz : z ∈ RingHom.ker φ ^ 2)
    (hzQ : ∀ Q : Ideal (𝓞 (fieldI F)), Q.IsMaximal → (p : 𝓞 (fieldI F)) ∈ Q → Q ≠ RingHom.ker φ → z ∉ Q)
    (hzb : conjO F z ∉ RingHom.ker φ) {k : ℕ} (hk : 0 < k) :
    ℚ⟮((z : fieldI F) / (conjO F z : fieldI F)) ^ k⟯ = ⊤ := by
  set P := RingHom.ker φ with hPdef
  haveI hPm : P.IsMaximal := RingHom.ker_isMaximal_of_surjective φ (ZMod.ringHom_surjective φ)
  have hpP : (p : 𝓞 (fieldI F)) ∈ P := by rw [RingHom.mem_ker, map_natCast, ZMod.natCast_self]
  have hcard : Ideal.absNorm P = p := by
    rw [Ideal.absNorm_apply, Submodule.cardQuot_apply,
      Nat.card_congr (RingHom.quotientKerEquivOfSurjective (ZMod.ringHom_surjective φ)).toEquiv, Nat.card_zmod]
  have hzP : z ∈ P := Ideal.pow_le_self two_ne_zero hz
  -- the shifted powers `zᵐ − p z̄ᵐ` have `v_p(N) = 1`
  have hx : ∀ m : ℕ, 0 < m →
      padicValNat p (Ideal.absNorm (Ideal.span {z ^ m - (p : 𝓞 (fieldI F)) * conjO F z ^ m})) = 1 := by
    intro m hm
    refine padicValNat_absNorm_span_eq_one hcard ?_ ?_ ?_
    · exact P.sub_mem (P.pow_mem_of_mem hzP m hm) (P.mul_mem_right _ hpP)
    · intro h2
      have hzm : z ^ m ∈ P ^ 2 := by
        obtain ⟨n, rfl⟩ := Nat.exists_eq_add_of_lt hm
        rw [pow_succ z]
        exact Ideal.mul_mem_left _ _ hz
      have h3 : conjO F z ^ m * (p : 𝓞 (fieldI F)) ∈ P ^ 2 := by
        have h4 := (P ^ 2).sub_mem hzm h2
        rwa [sub_sub_cancel, mul_comm] at h4
      rcases Ideal.IsPrime.mul_mem_pow P h3 with h | h
      · exact hzb (hPm.isPrime.mem_of_pow_mem m h)
      · exact hsq h
    · intro Q hQ hpQ hxQ
      by_contra hQP
      refine hzQ Q hQ hpQ hQP (hQ.isPrime.mem_of_pow_mem m ?_)
      have h4 := Q.add_mem hxQ (Q.mul_mem_right (conjO F z ^ m) hpQ)
      rwa [sub_add_cancel] at h4
  -- in `F(i)`: `v_p(N(wᵐ − p)) = 1 − m·B`
  set Zb : fieldI F := (conjO F z : fieldI F) with hZb
  have hZb0 : Zb ≠ 0 := fun h0 => hzb (by rw [RingOfIntegers.coe_eq_zero_iff.mp h0]; exact P.zero_mem)
  set W : fieldI F := (z : fieldI F) / Zb with hW
  set B := padicValRat p (Algebra.norm ℚ Zb)
  have hv : ∀ m : ℕ, 0 < m → padicValRat p (Algebra.norm ℚ (W ^ m - p)) = 1 - m * B := by
    intro m hm
    have hcoe : ((z ^ m - (p : 𝓞 (fieldI F)) * conjO F z ^ m : 𝓞 (fieldI F)) : fieldI F) =
        (W ^ m - p) * Zb ^ m := by
      rw [sub_mul, hW, div_pow, div_mul_cancel₀ _ (pow_ne_zero m hZb0)]
      push_cast
      rfl
    have hval := hx m hm
    rw [Ideal.absNorm_span_singleton] at hval
    have hx0 : z ^ m - (p : 𝓞 (fieldI F)) * conjO F z ^ m ≠ 0 := by
      intro h0
      rw [h0, Algebra.norm_zero, Int.natAbs_zero, padicValNat_zero_right] at hval
      exact zero_ne_one hval
    have hprod : (W ^ m - p) * Zb ^ m ≠ 0 := by
      rw [← hcoe]
      exact (RingOfIntegers.coe_ne_zero_iff).mpr hx0
    have hne1 : Algebra.norm ℚ (W ^ m - p) ≠ 0 := Algebra.norm_ne_zero_iff.mpr (left_ne_zero_of_mul hprod)
    have hne2 : Algebra.norm ℚ Zb ≠ 0 := Algebra.norm_ne_zero_iff.mpr hZb0
    have hval' : padicValRat p (Algebra.norm ℚ ((W ^ m - p) * Zb ^ m)) = 1 := by
      rw [← hcoe, ← Algebra.coe_norm_int, padicValRat.of_int, padicValInt, hval, Nat.cast_one]
    rw [map_mul, map_pow, padicValRat.mul hne1 (pow_ne_zero _ hne2), padicValRat.pow] at hval'
    linarith
  -- the degree `d = [F(i) : ℚ⟮wᵏ⟯]` divides `1 − kB` and `1 − 2kB`
  set α := W ^ k with hα
  have hgen : ∀ j : ℕ, ((AdjoinSimple.gen ℚ α ^ j - (p : ℚ⟮α⟯) : ℚ⟮α⟯) : fieldI F) = W ^ (k * j) - p := by
    intro j
    push_cast [AdjoinSimple.coe_gen]
    rw [hα, pow_mul]
  have h1 := dvd_padicValRat_norm p α (AdjoinSimple.gen ℚ α ^ 1 - (p : ℚ⟮α⟯))
  have h2 := dvd_padicValRat_norm p α (AdjoinSimple.gen ℚ α ^ 2 - (p : ℚ⟮α⟯))
  rw [hgen, hv _ (by positivity)] at h1 h2
  have h3 := dvd_sub (dvd_mul_of_dvd_right h1 2) h2
  have h4 : (2 : ℤ) * (1 - ((k * 1 : ℕ) : ℤ) * B) - (1 - ((k * 2 : ℕ) : ℤ) * B) = 1 := by
    push_cast
    ring
  rw [h4] at h3
  have hd : Module.finrank ℚ⟮α⟯ (fieldI F) = 1 := by exact_mod_cast Int.eq_one_of_dvd_one (by positivity) h3
  exact IntermediateField.finrank_eq_one_iff_eq_top.mp hd

/-- `ℚ⟮α⟯ = F(i)` read in `ℂ`: the subfield of `ℂ` generated by `α` is `F(i)`. -/
private theorem closure_eq_of_adjoin_eq_top (α : fieldI F) (h : ℚ⟮α⟯ = ⊤) :
    Subfield.closure {(α : ℂ)} = fieldI F := by
  refine le_antisymm (Subfield.closure_le.mpr (Set.singleton_subset_iff.mpr α.2)) fun x hx => ?_
  let S : IntermediateField ℚ (fieldI F) :=
    Subfield.toIntermediateField ((Subfield.closure {(α : ℂ)}).comap (fieldI F).subtype) fun q => by
      rw [Subfield.mem_comap, eq_ratCast, map_ratCast]
      exact SubfieldClass.ratCast_mem _ q
  have hle : ℚ⟮α⟯ ≤ S := IntermediateField.adjoin_simple_le_iff.mpr (Subfield.subset_closure rfl)
  exact hle (h ▸ IntermediateField.mem_top : (⟨x, hx⟩ : fieldI F) ∈ ℚ⟮α⟯)

/-- Clearing denominators at a prime: `(y₁/y₂)ⁿ (a/ā)ᵇ ≠ 1` when `a ∈ 𝔓`, `y₂, ā ∉ 𝔓`, `b ≥ 1`. -/
private theorem div_pow_mul_div_pow_ne_one {P : Ideal (𝓞 (fieldI F))} [hP : P.IsPrime] {y₁ y₂ a ā : 𝓞 (fieldI F)}
    (hy₂ : y₂ ∉ P) (ha : a ∈ P) (hā : ā ∉ P) (n b : ℕ) (hb : 0 < b) :
    (toC F y₁ / toC F y₂) ^ n * (toC F a / toC F ā) ^ b ≠ 1 := by
  intro h
  have hne : ∀ c : 𝓞 (fieldI F), c ∉ P → toC F c ≠ 0 := fun c hc h0 =>
    hc (by rw [toC_injective (h0.trans (map_zero _).symm)]; exact P.zero_mem)
  have hden : toC F y₂ ^ n * toC F ā ^ b ≠ 0 := mul_ne_zero (pow_ne_zero _ (hne _ hy₂)) (pow_ne_zero _ (hne _ hā))
  rw [div_pow, div_pow, div_mul_div_comm, div_eq_one_iff_eq hden] at h
  have h' : y₁ ^ n * a ^ b = y₂ ^ n * ā ^ b := toC_injective (by simpa only [map_mul, map_pow] using h)
  have hl : y₁ ^ n * a ^ b ∈ P := P.mul_mem_left _ (P.pow_mem_of_mem ha b hb)
  rw [h'] at hl
  rcases hP.mem_or_mem hl with h1 | h1
  · exact hy₂ (hP.mem_of_pow_mem n h1)
  · exact hā (hP.mem_of_pow_mem b h1)

/-- **Independence by membership** (A6): `u = z′/z̄′`, `w = z/z̄` with `z ∈ 𝔓`, `z̄, z′, z̄′ ∉ 𝔓`, `z′ ∈ 𝔓′`, `z̄′ ∉ 𝔓′`. -/
private theorem eq_zero_of_zpow_mul_zpow_eq_one {P P' : Ideal (𝓞 (fieldI F))} [P.IsPrime] [P'.IsPrime]
    {z z' : 𝓞 (fieldI F)} (hz : z ∈ P) (hzb : conjO F z ∉ P) (hz'P : z' ∉ P) (hz'bP : conjO F z' ∉ P)
    (hz' : z' ∈ P') (hz'b : conjO F z' ∉ P') (a b : ℤ)
    (h : (toC F z' / toC F (conjO F z')) ^ a * (toC F z / toC F (conjO F z)) ^ b = 1) : a = 0 ∧ b = 0 := by
  set U := toC F z' / toC F (conjO F z')
  set W := toC F z / toC F (conjO F z)
  have K1 : ∀ (a : ℤ) (b : ℕ), 0 < b → U ^ a * W ^ b ≠ 1 := by
    intro a b hb
    rcases Int.eq_nat_or_neg a with ⟨n, rfl | rfl⟩
    · rw [zpow_natCast]
      exact div_pow_mul_div_pow_ne_one hz'bP hz hzb n b hb
    · rw [zpow_neg, zpow_natCast, ← inv_pow, inv_div]
      exact div_pow_mul_div_pow_ne_one hz'P hz hzb n b hb
  have h1P' : (1 : 𝓞 (fieldI F)) ∉ P' := fun h1 =>
    (inferInstance : P'.IsPrime).ne_top ((Ideal.eq_top_iff_one _).mpr h1)
  have K2 : ∀ n : ℕ, 0 < n → U ^ n ≠ 1 := by
    intro n hn hU
    refine div_pow_mul_div_pow_ne_one (y₁ := 1) h1P' hz' hz'b 0 n hn ?_
    rw [pow_zero, one_mul]
    exact hU
  rcases lt_trichotomy b 0 with hb | rfl | hb
  · exfalso
    have h' : U ^ (-a) * W ^ (-b) = 1 := by rw [zpow_neg, zpow_neg, ← mul_inv, h, inv_one]
    obtain ⟨m, hm⟩ := Int.eq_ofNat_of_zero_le (neg_nonneg.mpr hb.le)
    rw [hm, zpow_natCast] at h'
    exact K1 (-a) m (by omega) h'
  · rw [zpow_zero, mul_one] at h
    refine ⟨?_, rfl⟩
    rcases lt_trichotomy a 0 with ha | rfl | ha
    · exfalso
      obtain ⟨m, hm⟩ := Int.eq_ofNat_of_zero_le (neg_nonneg.mpr ha.le)
      have h' : U ^ (-a) = 1 := by rw [zpow_neg, h, inv_one]
      rw [hm, zpow_natCast] at h'
      exact K2 m (by omega) h'
    · rfl
    · exfalso
      obtain ⟨m, hm⟩ := Int.eq_ofNat_of_zero_le ha.le
      rw [hm, zpow_natCast] at h
      exact K2 m (by omega) h
  · exfalso
    obtain ⟨m, hm⟩ := Int.eq_ofNat_of_zero_le hb.le
    rw [hm, zpow_natCast] at h
    exact K1 a m (by omega) h

end FieldI

/-- **Two unit vectors of `F²` for an admissible pair, at every real number field** (FS100-X02D's Lemma W
construction; FS131-ILA1's route): complex numbers `u, w` of modulus one in `F(i)`, multiplicatively independent
(`u^a w^b = 1` only at `a = b = 0`), with `wᵏ` generating `F(i)` for every `k ≥ 1`. At degree-one, unramified primes `𝔓`,
`𝔓′` above distinct odd primes `p`, `p′` (`exists_residueHom_unramified`): `w = z/z̄` with `z ∈ 𝔓²` in no other prime above
`p`, and `u = z′/z̄′` with `z′ ∈ 𝔓′` and `z′ ∉ 𝔓̄′, 𝔓, 𝔓̄`. -/
theorem exists_unitPair (F : Subfield ℝ) [NumberField F] :
    ∃ u w : ℂ, u ∈ fieldI F ∧ ‖u‖ = 1 ∧ w ∈ fieldI F ∧ ‖w‖ = 1 ∧
      (∀ a b : ℤ, u ^ a * w ^ b = 1 → a = 0 ∧ b = 0) ∧
      ∀ k : ℕ, 0 < k → Subfield.closure {w ^ k} = fieldI F := by
  obtain ⟨p, φ, hp, hp2, hsq⟩ := exists_residueHom_unramified (fieldI F) 2 two_ne_zero
  haveI : Fact p.Prime := ⟨hp⟩
  have hp2' : p ≠ 2 := fun h => hp2 (h ▸ dvd_rfl)
  obtain ⟨p', φ', hp', hp'2, hsq'⟩ :=
    exists_residueHom_unramified (fieldI F) (2 * p) (mul_ne_zero two_ne_zero hp.ne_zero)
  haveI : Fact p'.Prime := ⟨hp'⟩
  have hp'2' : p' ≠ 2 := fun h => hp'2 (h ▸ dvd_mul_right 2 p)
  have hpp' : p' ≠ p := fun h => hp'2 (h ▸ dvd_mul_left p 2)
  set P := RingHom.ker φ with hPdef
  set P' := RingHom.ker φ' with hP'def
  haveI hPm : P.IsMaximal := RingHom.ker_isMaximal_of_surjective φ (ZMod.ringHom_surjective φ)
  haveI hP'm : P'.IsMaximal := RingHom.ker_isMaximal_of_surjective φ' (ZMod.ringHom_surjective φ')
  have hpP : (p : 𝓞 (fieldI F)) ∈ P := by rw [hPdef, RingHom.mem_ker, map_natCast, ZMod.natCast_self]
  have hp'P' : (p' : 𝓞 (fieldI F)) ∈ P' := by rw [hP'def, RingHom.mem_ker, map_natCast, ZMod.natCast_self]
  -- `w = z / z̄` at `𝔓`
  obtain ⟨z, hz2, hzQ⟩ := exists_mem_sq_forall_notMem hpP hsq
  haveI := comap_conjO_isMaximal P
  have hzb : conjO F z ∉ P := fun h =>
    hzQ (P.comap (conjO F)) inferInstance (natCast_mem_comap_conjO hpP) (comap_conjO_ker_ne hp2' φ) h
  have hzP : z ∈ P := Ideal.pow_le_self two_ne_zero hz2
  -- `u = z′ / z̄′` at `𝔓′`
  haveI := comap_conjO_isMaximal P'
  have hcop : ∀ Q : Ideal (𝓞 (fieldI F)), Q.IsMaximal → (p : 𝓞 (fieldI F)) ∈ Q →
      (p' : 𝓞 (fieldI F)) ∈ Q → False := by
    intro Q hQ h1 h2
    obtain ⟨a, b, hab⟩ := (Nat.isCoprime_iff_coprime.mpr ((Nat.coprime_primes hp hp').mpr hpp'.symm)).map
      (Int.castRingHom (𝓞 (fieldI F)))
    rw [map_natCast, map_natCast] at hab
    exact hQ.ne_top ((Ideal.eq_top_iff_one Q).mpr (hab ▸ Q.add_mem (Q.mul_mem_left a h1) (Q.mul_mem_left b h2)))
  obtain ⟨z', hz'P', hz'b, hz'P, hz'bP⟩ :=
    exists_mem_notMem_three (P' := P') (A := P'.comap (conjO F)) (B := P) (C := P.comap (conjO F))
      (comap_conjO_ker_ne hp'2' φ').symm (fun h => hcop P' hP'm (h ▸ hpP) hp'P')
      (fun h => hcop P' hP'm (h ▸ natCast_mem_comap_conjO hpP) hp'P')
  have hz'b0 : conjO F z' ≠ 0 := fun h => hz'b (by rw [Ideal.mem_comap, h]; exact P'.zero_mem)
  have hzb0 : conjO F z ≠ 0 := fun h => hzb (h ▸ P.zero_mem)
  refine ⟨toC F z' / toC F (conjO F z'), toC F z / toC F (conjO F z),
    (fieldI F).div_mem (z' : fieldI F).2 (conjO F z' : fieldI F).2, norm_div_conj hz'b0,
    (fieldI F).div_mem (z : fieldI F).2 (conjO F z : fieldI F).2, norm_div_conj hzb0,
    eq_zero_of_zpow_mul_zpow_eq_one hzP hzb hz'P hz'bP hz'P' hz'b, fun k hk => ?_⟩
  have e : (toC F z / toC F (conjO F z)) ^ k =
      ((((z : fieldI F) / (conjO F z : fieldI F)) ^ k : fieldI F) : ℂ) := by
    rw [toC_apply, toC_apply]
    push_cast
    rfl
  rw [e]
  exact closure_eq_of_adjoin_eq_top _ (adjoin_pow_eq_top φ hsq hz2 hzQ hzb hk)

end

end HadwigerNelson.Rigidity

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs

noncomputable section

variable {F : Subfield ℝ}

example [NumberField F] : Nonempty (AdmissiblePair F) := by
  obtain ⟨u, w, hu, hu1, hw, hw1, hind, hgen⟩ := exists_unitPair F
  let u' : unitCircle F := ⟨⟨u, mem_sphere_zero_iff_norm.mpr hu1⟩, hu⟩
  let w' : unitCircle F := ⟨⟨w, mem_sphere_zero_iff_norm.mpr hw1⟩, hw⟩
  refine ⟨AdmissiblePair.ofPow u' w' ?_ fun k hk => hgen k hk⟩
  rw [injective_iff_map_eq_one]
  intro n hn
  have h : u ^ (Multiplicative.toAdd n 0) * w ^ (Multiplicative.toAdd n 1) = 1 := by
    have h' := congrArg (fun g : unitCircle F => ((g : Circle) : ℂ)) hn
    simpa only [zpowHom, MonoidHom.coe_mk, OneHom.coe_mk, Subgroup.coe_mul, SubgroupClass.coe_zpow,
      Circle.coe_mul, Circle.coe_zpow, OneMemClass.coe_one, Circle.coe_one] using h'
  obtain ⟨h0, h1⟩ := hind _ _ h
  refine Multiplicative.toAdd.injective (funext fun i => ?_)
  fin_cases i
  · exact h0
  · exact h1

end

end HadwigerNelson.Rigidity

#print axioms HadwigerNelson.Rigidity.exists_unitPair
#print axioms HadwigerNelson.Rigidity.exists_residueHom_unramified
