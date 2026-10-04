import Mathlib.Algebra.Polynomial.SpecificDegree
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.NumberTheory.KummerDedekind
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.RingTheory.RamificationInertia.Ramification
import Mathlib.RingTheory.RamificationInertia.Inertia
import Mathlib.RingTheory.DedekindDomain.AdicValuation
import Mathlib.RingTheory.Conductor

/-!
# Dyadic places where `3` is a square: unramified in `F(i)`, split iff the residue degree is even (FS-131 wave 2)

Row: **FS129-SA1-SQRT3-LOCAL** (carrying TC1-SQRT3-DYADIC, SA1 item 7). Plan: `plans/FS131-w2-kernel-plan.md` § 4.
`F(i)/F` is any quadratic extension `L/F` of number fields with a square root of `−1` in `L` outside `F` (ruling, inventory item 134: `hi` carries `ι ∉ F`; without it `L` is any quadratic extension when `i ∈ F`, and the statements are false);
a place `w` of `F` above `2` is a height-one prime `P` of `𝓞 F` containing `2`; `f(w|2)` is `P`'s inertia degree over `ℤ`.

The local hypothesis "`3` is a square in `F_w`" is equivalent to the global congruence `s² ≡ 3 (mod 4P)` for some `s ∈ 𝓞 F`
(Newton's lemma one way, density of `𝓞 F` the other); `sqrt3_local_of_congr` states the conclusion from the congruence — the
form the proof runs on (Kummer–Dedekind for `γ = (−1 + s i)/2`, whose minimal polynomial `x² + x + (1 + (s² − 3)/4)` is
`x² + x + 1` mod `P`) — and TC1's global form is its case `s = √3`.
-/

namespace HadwigerNelson.Arith

open NumberField IsDedekindDomain

variable {F L : Type*} [Field F] [NumberField F] [Field L] [NumberField L] [Algebra F L]

/-- The conclusion of SQRT3-LOCAL at a dyadic prime `P` of `F`: unramified in `L`, split iff `f(P|2)` is even, and inert of
norm `2^f` with `f` odd when it does not split. -/
def DyadicSqrt3Conclusion (L : Type*) [Field L] [NumberField L] [Algebra F L] (P : HeightOneSpectrum (𝓞 F)) : Prop :=
  (∀ Q ∈ P.asIdeal.primesOver (𝓞 L), Ideal.ramificationIdx Q (𝓞 F) = 1) ∧
    ((P.asIdeal.primesOver (𝓞 L)).ncard = 2 ↔ Even (Ideal.inertiaDeg P.asIdeal ℤ)) ∧
    ((P.asIdeal.primesOver (𝓞 L)).ncard ≠ 2 →
      (P.asIdeal.primesOver (𝓞 L)).ncard = 1 ∧ (∀ Q ∈ P.asIdeal.primesOver (𝓞 L), Ideal.inertiaDeg Q (𝓞 F) = 2) ∧
        Odd (Ideal.inertiaDeg P.asIdeal ℤ) ∧ Nat.card (𝓞 F ⧸ P.asIdeal) = 2 ^ Ideal.inertiaDeg P.asIdeal ℤ)

/-! ## FS131-K2c: children (each `sorry`ed; plan `plans/FS131-w2-kernel-plan.md` § 12)

The route is **P-local** (inventory item 64): a generator `γ = d(−1 + s ι)/2` of `L/F`, integral everywhere because `d`
absorbs the other dyadic primes (`d ∈ I`, `span {4} = P^a I`), whose minimal polynomial `X² + dX + δ` reduces to `X² + X + 1`
mod `P` and whose discriminant `−d²s²` is a `P`-unit; Kummer–Dedekind needs the conductor prime to `P` only. Both leaves are
the assembly of these. -/

open Polynomial in
/-- `X² + X + 1` over a finite field of characteristic `2` is separable, and irreducible iff `3 ∤ |K| − 1`. -/
theorem x2x1_separable_irreducible_iff {K : Type*} [Field K] [Fintype K] [CharP K 2] :
    (X ^ 2 + X + 1 : K[X]).Separable ∧ (Irreducible (X ^ 2 + X + 1 : K[X]) ↔ ¬ 3 ∣ Fintype.card K - 1) := by
  classical
  have h2 : (2 : K) = 0 := by exact_mod_cast CharP.cast_eq_zero K 2
  have hmon : (X ^ 2 + X + 1 : K[X]).Monic := by monicity!
  have hdeg : (X ^ 2 + X + 1 : K[X]).natDegree = 2 := by compute_degree!
  refine ⟨?_, ?_⟩
  · rw [separable_def]
    have : derivative (X ^ 2 + X + 1 : K[X]) = 1 := by
      simp only [derivative_add, derivative_X_pow, derivative_X, derivative_one]
      have : (C (2 : K) : K[X]) = 0 := by rw [h2]; simp
      simp [this]
    rw [this]; exact isCoprime_one_right
  · rw [Polynomial.Monic.irreducible_iff_roots_eq_zero_of_degree_le_three hmon (by omega) (by omega)]
    have hroot : ∀ x : K, x ^ 2 + x + 1 = 0 ↔ x ^ 3 = 1 ∧ x ≠ 1 := by
      intro x
      constructor
      · intro h
        have h3 : x ^ 3 = 1 := by linear_combination (x - 1) * h
        refine ⟨h3, ?_⟩
        rintro rfl
        have : (3 : K) = 0 := by linear_combination h
        have : (1 : K) = 0 := by linear_combination this - h2
        exact one_ne_zero this
      · rintro ⟨h3, hx⟩
        have : (x - 1) * (x ^ 2 + x + 1) = 0 := by linear_combination h3
        rcases mul_eq_zero.mp this with h | h
        · exact absurd (sub_eq_zero.mp h) hx
        · exact h
    rw [Multiset.eq_zero_iff_forall_notMem]
    simp only [mem_roots (show (X ^ 2 + X + 1 : K[X]) ≠ 0 from hmon.ne_zero), IsRoot.def]
    simp only [eval_add, eval_pow, eval_X, eval_one, hroot]
    constructor
    · intro h h3
      haveI : Fact (Nat.Prime 3) := ⟨Nat.prime_three⟩
      obtain ⟨x, hx⟩ := exists_prime_orderOf_dvd_card' (G := Kˣ) 3 (by
        rw [Nat.card_units, Nat.card_eq_fintype_card]; exact h3)
      apply h (x : K)
      refine ⟨?_, ?_⟩
      · have := congrArg Units.val (pow_orderOf_eq_one x)
        rw [hx] at this
        simpa using this
      · intro h1
        have : x = 1 := Units.ext h1
        rw [this, orderOf_one] at hx
        omega
    · intro h x ⟨h3, hx⟩
      apply h
      have hx0 : x ≠ 0 := by rintro rfl; simp at h3
      let u : Kˣ := Units.mk0 x hx0
      have hu : orderOf u = 3 := by
        have h3' : u ^ 3 = 1 := Units.ext (by simp only [Units.val_pow_eq_pow_val, Units.val_one, u, Units.val_mk0]; exact h3)
        refine (Nat.dvd_prime Nat.prime_three).mp (orderOf_dvd_of_pow_eq_one h3') |>.resolve_left ?_
        intro h1
        rw [orderOf_eq_one_iff] at h1
        exact hx (by simpa [u] using congrArg Units.val h1)
      have := orderOf_dvd_natCard u
      rw [hu, Nat.card_units, Nat.card_eq_fintype_card] at this
      exact this

/-- The residue field at a dyadic prime has `2 ^ f` elements (`Ideal.absNorm_eq_pow_inertiaDeg`). -/
theorem card_quot_eq_two_pow (P : HeightOneSpectrum (𝓞 F)) (h2 : (2 : 𝓞 F) ∈ P.asIdeal) :
    Nat.card (𝓞 F ⧸ P.asIdeal) = 2 ^ Ideal.inertiaDeg P.asIdeal ℤ := by
  haveI : P.asIdeal.IsPrime := P.isPrime
  haveI : P.asIdeal.IsMaximal := P.isPrime.isMaximal P.ne_bot
  have hunder : P.asIdeal.under ℤ = Ideal.span {(2 : ℤ)} := by
    have hp : (P.asIdeal.under ℤ).IsMaximal := Ideal.IsMaximal.under ℤ P.asIdeal
    have hle : Ideal.span {(2 : ℤ)} ≤ P.asIdeal.under ℤ := by
      rw [Ideal.span_singleton_le_iff_mem, Ideal.mem_comap]
      simpa using h2
    exact (((Ideal.span_singleton_prime (by norm_num) |>.mpr Int.prime_two).isMaximal (by simp)).eq_of_le hp.ne_top hle).symm
  haveI : P.asIdeal.LiesOver (Ideal.span {(2 : ℤ)}) := ⟨hunder.symm⟩
  have h1 := Ideal.absNorm_eq_pow_inertiaDeg (R := 𝓞 F) P.asIdeal (p := 2) Int.prime_two
  haveI : (Ideal.span {(2 : ℤ)}).IsMaximal := by
    rw [← hunder]; exact Ideal.IsMaximal.under ℤ P.asIdeal
  rw [Ideal.inertiaDeg'_eq_inertiaDeg (Ideal.span {(2:ℤ)}) P.asIdeal] at h1
  have h3 : Nat.card (𝓞 F ⧸ P.asIdeal) = Ideal.absNorm P.asIdeal := by
    rw [Ideal.absNorm_apply]; rfl
  rw [h3, h1]; rfl

/-- `span {4} = P^a · I` with `I ⊄ P` (`Ideal.eq_prime_pow_mul_coprime`). -/
theorem exists_span_four_eq (P : HeightOneSpectrum (𝓞 F)) :
    ∃ (a : ℕ) (I : Ideal (𝓞 F)), Ideal.span {(4 : 𝓞 F)} = P.asIdeal ^ a * I ∧ ¬ I ≤ P.asIdeal := by
  haveI : P.asIdeal.IsMaximal := P.isPrime.isMaximal P.ne_bot
  have h4 : Ideal.span {(4 : 𝓞 F)} ≠ ⊥ := by
    rw [Ne, Ideal.span_singleton_eq_bot]; exact_mod_cast (by norm_num : (4 : ℕ) ≠ 0)
  obtain ⟨Q, hQ, hEq⟩ := Ideal.eq_prime_pow_mul_coprime h4 P.asIdeal
  refine ⟨_, Q, hEq, fun hle => ?_⟩
  rw [sup_eq_left.mpr hle] at hQ
  exact P.isPrime.ne_top hQ

/-- **The local square, approximated** (density of `𝓞 F` in the completion's integers): `3` a square in `F_P` gives
`s ∈ 𝓞 F` with `s² − 3 ∈ P^N`, for every `N`. -/
theorem exists_sq_sub_three_mem_pow (P : HeightOneSpectrum (𝓞 F)) (h3 : IsSquare (3 : P.adicCompletion F)) (N : ℕ) :
    ∃ s : 𝓞 F, s ^ 2 - 3 ∈ P.asIdeal ^ N := by
  obtain ⟨x, hx⟩ := h3
  obtain ⟨π, hπ⟩ := P.intValuation_exists_uniformizer
  have hval : ∀ r : 𝓞 F, Valued.v (algebraMap F (P.adicCompletion F) (algebraMap (𝓞 F) F r)) = P.intValuation r := by
    intro r
    exact (HeightOneSpectrum.valuedAdicCompletion_eq_valuation (K := F) P r).trans (HeightOneSpectrum.valuation_of_algebraMap P r)
  have hval' : ∀ k : F, Valued.v (algebraMap F (P.adicCompletion F) k) = P.valuation F k := fun k =>
    HeightOneSpectrum.valuedAdicCompletion_eq_valuation' (R := 𝓞 F) P k
  set e : F →+* P.adicCompletion F := algebraMap F (P.adicCompletion F) with he
  have hcN : Valued.v (e (algebraMap (𝓞 F) F (π ^ N))) = WithZero.exp (-(N : ℤ)) := by
    rw [hval, map_pow, hπ, ← WithZero.exp_nsmul]; simp
  have hcne : e (algebraMap (𝓞 F) F (π ^ N)) ≠ 0 := by
    intro h; rw [h, map_zero] at hcN; exact (WithZero.exp_ne_zero) hcN.symm
  -- x is integral
  have hx1 : Valued.v x ≤ 1 := by
    by_contra hlt
    push Not at hlt
    have h3v : Valued.v (3 : P.adicCompletion F) ≤ 1 := by
      have := hval 3
      have h3 : (3 : P.adicCompletion F) = e (algebraMap (𝓞 F) F 3) := by rw [map_ofNat, map_ofNat]
      rw [h3, this]; exact P.intValuation_le_one 3
    rw [hx, map_mul] at h3v
    exact absurd h3v (not_le.mpr (lt_of_lt_of_le hlt (le_mul_of_one_le_right' hlt.le)))
  -- an approximant in F
  set γ : (MonoidWithZeroHom.ValueGroup₀ (.ofClass (Valued.v : Valuation (P.adicCompletion F) _)))ˣ :=
    Units.mk0 (Valued.v.restrict (e (algebraMap (𝓞 F) F (π ^ N)))) (by simpa using hcne) with hγ
  have hnhds : {y : P.adicCompletion F | Valued.v.restrict (y - x) < γ.1} ∈ nhds x :=
    Valued.mem_nhds.mpr ⟨γ, subset_rfl⟩
  obtain ⟨_, hk, k, rfl⟩ := mem_closure_iff_nhds.mp ((HeightOneSpectrum.denseRange_algebraMap (R := 𝓞 F) F P) x) _ hnhds
  simp only [Set.mem_setOf_eq, hγ, Units.val_mk0] at hk
  have hk' : Valued.v (e k - x) < WithZero.exp (-(N : ℤ)) := by
    have := (Valued.v : Valuation (P.adicCompletion F) _).restrict_lt_iff.mp hk
    rwa [hcN] at this
  have hexp1 : WithZero.exp (-(N : ℤ)) ≤ 1 := by
    rw [← WithZero.exp_zero]; exact WithZero.exp_le_exp.mpr (by omega)
  have hek1 : Valued.v (e k) ≤ 1 := by
    have := (Valued.v : Valuation (P.adicCompletion F) _).map_add (e k - x) x
    rw [sub_add_cancel] at this
    exact this.trans (max_le (hk'.le.trans hexp1) hx1)
  have hk1 : P.valuation F k ≤ 1 := by rw [← hval']; exact hek1
  obtain ⟨a, ha⟩ := P.exists_valuation_sub_lt_of_integer (K := F) hk1 (Units.mk0 (WithZero.exp (-(N : ℤ))) WithZero.exp_ne_zero)
  have ha' : Valued.v (e (algebraMap (𝓞 F) F a) - e k) < WithZero.exp (-(N : ℤ)) := by
    rw [← map_sub, hval']; exact ha
  set A := e (algebraMap (𝓞 F) F a) with hA
  have hAx : Valued.v (A - x) < WithZero.exp (-(N : ℤ)) := by
    have := (Valued.v : Valuation (P.adicCompletion F) _).map_add (A - e k) (e k - x)
    rw [show A - e k + (e k - x) = A - x by ring] at this
    exact this.trans_lt (max_lt ha' hk')
  have hA1 : Valued.v A ≤ 1 := by rw [hA, hval]; exact P.intValuation_le_one a
  have hAx1 : Valued.v (A + x) ≤ 1 := ((Valued.v : Valuation (P.adicCompletion F) _).map_add A x).trans (max_le hA1 hx1)
  refine ⟨a, (P.intValuation_le_pow_iff_mem _ N).mp ?_⟩
  rw [← hval]
  have hr : e (algebraMap (𝓞 F) F (a ^ 2 - 3)) = (A - x) * (A + x) := by
    simp only [map_sub, map_pow, map_ofNat, ← hA]
    linear_combination (-1 : P.adicCompletion F) * hx
  rw [hr, map_mul]
  exact ((mul_le_of_le_one_right' hAx1)).trans hAx.le

/-- Cancellation of a nonzero ideal in a Dedekind domain, in order form. -/
theorem ideal_le_of_mul_le (A B C : Ideal (𝓞 F)) (hA : A ≠ ⊥) (h : A * B ≤ A * C) : B ≤ C := by
  rw [← Ideal.dvd_iff_le] at h ⊢
  exact (mul_dvd_mul_iff_left hA).mp h

/-- **The generator's coefficients** (CRT and cancellation in the Dedekind domain): from `s² − 3 ∈ P^(a+1)`, pick `d ∈ I`
with `d ≡ 1 (mod P)` (`I ⊔ P = ⊤`); then `4 ∣ d²(1 + s²)`, and `δ = d²(1 + s²)/4 ≡ 1 (mod P)` by
`4(δ − 1) = (d² − 1)(1 + s²) + (s² − 3) ∈ P^(a+1)`. -/
theorem exists_dyadic_coeffs (P : HeightOneSpectrum (𝓞 F)) (h2 : (2 : 𝓞 F) ∈ P.asIdeal) {a : ℕ} {I : Ideal (𝓞 F)}
    (h4 : Ideal.span {(4 : 𝓞 F)} = P.asIdeal ^ a * I) (hI : ¬ I ≤ P.asIdeal) {s : 𝓞 F}
    (hs : s ^ 2 - 3 ∈ P.asIdeal ^ (a + 1)) :
    ∃ s d δ : 𝓞 F, 4 * δ = d ^ 2 * (1 + s ^ 2) ∧ d - 1 ∈ P.asIdeal ∧ δ - 1 ∈ P.asIdeal ∧ s ∉ P.asIdeal := by
  haveI : P.asIdeal.IsMaximal := P.isPrime.isMaximal P.ne_bot
  have hPa : P.asIdeal ^ (a + 1) ≤ P.asIdeal ^ a := Ideal.pow_le_pow_right (by omega)
  have hs1 : s ^ 2 - 3 ∈ P.asIdeal := Ideal.pow_le_self (Nat.succ_ne_zero a) hs
  have hsP : s ∉ P.asIdeal := by
    intro h
    have h3 : (3 : 𝓞 F) ∈ P.asIdeal := by
      have : (3 : 𝓞 F) = s ^ 2 - (s ^ 2 - 3) := by ring
      rw [this]; exact P.asIdeal.sub_mem (P.asIdeal.pow_mem_of_mem h 2 (by norm_num)) hs1
    have : (1 : 𝓞 F) ∈ P.asIdeal := by
      have : (1 : 𝓞 F) = 3 - 2 := by norm_num
      rw [this]; exact P.asIdeal.sub_mem h3 h2
    exact P.isPrime.ne_top ((Ideal.eq_top_iff_one _).mpr this)
  have hsup : P.asIdeal ⊔ I = ⊤ := (this.out.2 _ (left_lt_sup.mpr hI))
  obtain ⟨p, hp, d, hd, hpd⟩ := Submodule.mem_sup.mp ((Ideal.eq_top_iff_one _).mp hsup)
  have hd1 : d - 1 ∈ P.asIdeal := by
    have : d - 1 = -p := by linear_combination hpd
    rw [this]; exact P.asIdeal.neg_mem hp
  have h4mem : (4 : 𝓞 F) ∈ P.asIdeal ^ a * I := h4 ▸ Ideal.mem_span_singleton_self _
  have h4a : (4 : 𝓞 F) ∈ P.asIdeal ^ a := Ideal.mul_le_right h4mem
  have hs2 : s ^ 2 - 3 ∈ P.asIdeal ^ a := hPa hs
  have h1s : 1 + s ^ 2 ∈ P.asIdeal ^ a := by
    have : 1 + s ^ 2 = 4 + (s ^ 2 - 3) := by ring
    rw [this]; exact Ideal.add_mem _ h4a hs2
  have hmem : d ^ 2 * (1 + s ^ 2) ∈ Ideal.span {(4 : 𝓞 F)} := by
    have : d ^ 2 * (1 + s ^ 2) = 4 * d ^ 2 + d ^ 2 * (s ^ 2 - 3) := by ring
    rw [this]
    refine Ideal.add_mem _ (Ideal.mul_mem_right _ _ (Ideal.mem_span_singleton_self _)) ?_
    have hc : d ^ 2 * (s ^ 2 - 3) = (s ^ 2 - 3) * d ^ 2 := mul_comm _ _
    rw [hc, h4]
    exact Ideal.mul_mem_mul hs2 (Ideal.pow_mem_of_mem I hd 2 (by norm_num))
  obtain ⟨δ, hδ⟩ := Ideal.mem_span_singleton'.mp hmem
  refine ⟨s, d, δ, by rw [mul_comm]; exact hδ, hd1, ?_, hsP⟩
  have h4δ : (4 : 𝓞 F) * (δ - 1) ∈ P.asIdeal ^ (a + 1) := by
    have : (4 : 𝓞 F) * (δ - 1) = (d - 1) * (d + 1) * (1 + s ^ 2) + (s ^ 2 - 3) := by
      linear_combination hδ
    have hprod : (d - 1) * (d + 1) * (1 + s ^ 2) ∈ P.asIdeal ^ (a + 1) := by
      rw [pow_succ']
      exact Ideal.mul_mem_mul (Ideal.mul_mem_right _ _ hd1) h1s
    rw [this]; exact Ideal.add_mem _ hprod hs
  have hX : P.asIdeal ^ a * (I * Ideal.span {δ - 1}) ≤ P.asIdeal ^ a * P.asIdeal := by
    rw [← mul_assoc, ← h4, Ideal.span_singleton_mul_span_singleton, ← pow_succ, Ideal.span_singleton_le_iff_mem]
    exact h4δ
  have hX2 := ideal_le_of_mul_le _ _ _ (pow_ne_zero a P.ne_bot) hX
  exact Ideal.span_singleton_le_iff_mem _ |>.mp ((P.isPrime.mul_le.mp hX2).resolve_left hI)

/-- The root `γ = d(−1 + s ι)/2 ∈ 𝓞 L` of `X² + dX + δ` (integral as a root of a monic polynomial over `𝓞 F`), not in `F`
since `s ι ∉ F`. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem exists_root_quadratic (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)) {s d δ : 𝓞 F}
    (hδ : 4 * δ = d ^ 2 * (1 + s ^ 2)) (hd0 : d ≠ 0) (hs0 : s ≠ 0) :
    ∃ γ : 𝓞 L, γ ^ 2 + algebraMap (𝓞 F) (𝓞 L) d * γ + algebraMap (𝓞 F) (𝓞 L) δ = 0 ∧
      (γ : L) ∉ Set.range (algebraMap F L) := by
  have _ := hdeg
  obtain ⟨ι, hι, hιF⟩ := hi
  set sF : F := algebraMap (𝓞 F) F s
  set dF : F := algebraMap (𝓞 F) F d
  set δF : F := algebraMap (𝓞 F) F δ
  have hδF : 4 * δF = dF ^ 2 * (1 + sF ^ 2) := by
    have := congrArg (algebraMap (𝓞 F) F) hδ
    simpa only [map_mul, map_pow, map_add, map_one, map_ofNat] using this
  have hsF : sF ≠ 0 := by
    simpa [sF] using (map_ne_zero_iff _ (FaithfulSMul.algebraMap_injective (𝓞 F) F)).mpr hs0
  have hdF : dF ≠ 0 := by
    simpa [dF] using (map_ne_zero_iff _ (FaithfulSMul.algebraMap_injective (𝓞 F) F)).mpr hd0
  set γ' : L := algebraMap F L dF * (-1 + algebraMap F L sF * ι) / 2 with hγ'
  have hq : γ' ^ 2 + algebraMap F L dF * γ' + algebraMap F L δF = 0 := by
    have h1 : (4 : L) * algebraMap F L δF = algebraMap F L dF ^ 2 * (1 + algebraMap F L sF ^ 2) := by
      have := congrArg (algebraMap F L) hδF
      simpa only [map_mul, map_pow, map_add, map_one, map_ofNat] using this
    rw [hγ']
    linear_combination (algebraMap F L dF ^ 2 * algebraMap F L sF ^ 2 / 4) * hι + (1 / 4 : L) * h1
  have hint0 : IsIntegral (𝓞 F) γ' := by
    refine ⟨Polynomial.X ^ 2 + Polynomial.C d * Polynomial.X + Polynomial.C δ, ?_, ?_⟩
    · monicity!
    · simp only [Polynomial.eval₂_add, Polynomial.eval₂_mul, Polynomial.eval₂_pow, Polynomial.eval₂_X, Polynomial.eval₂_C]
      have e1 : algebraMap (𝓞 F) L d = algebraMap F L dF := IsScalarTower.algebraMap_apply (𝓞 F) F L d
      have e2 : algebraMap (𝓞 F) L δ = algebraMap F L δF := IsScalarTower.algebraMap_apply (𝓞 F) F L δ
      rw [e1, e2]; exact hq
  have hint : IsIntegral ℤ γ' := isIntegral_trans (A := 𝓞 F) γ' hint0
  refine ⟨⟨γ', hint⟩, ?_, ?_⟩
  · apply Subtype.val_injective
    have e1 : algebraMap (𝓞 F) L d = algebraMap F L dF := IsScalarTower.algebraMap_apply (𝓞 F) F L d
    have e2 : algebraMap (𝓞 F) L δ = algebraMap F L δF := IsScalarTower.algebraMap_apply (𝓞 F) F L δ
    show γ' ^ 2 + algebraMap (𝓞 F) L d * γ' + algebraMap (𝓞 F) L δ = 0
    rw [e1, e2]; exact hq
  · rintro ⟨f, hf⟩
    apply hιF
    have hdL : algebraMap F L dF ≠ 0 := by simpa using hdF
    have hsL : algebraMap F L sF ≠ 0 := by simpa using hsF
    refine ⟨(2 * f + dF) / (dF * sF), ?_⟩
    have : ι = (2 * algebraMap F L f + algebraMap F L dF) / (algebraMap F L dF * algebraMap F L sF) := by
      have hf' : algebraMap F L f = γ' := hf
      rw [hf', hγ']
      field_simp
      ring
    rw [this, map_div₀, map_add, map_mul, map_mul, map_ofNat]

open Polynomial in
/-- A root of `X² + dX + δ` outside `F` has that minimal polynomial over `𝓞 F` (`minpoly.eq_of_irreducible_of_monic`;
`𝓞 F` integrally closed). -/
theorem minpoly_eq_of_root (hdeg : Module.finrank F L = 2) {d δ : 𝓞 F} {γ : 𝓞 L}
    (hroot : γ ^ 2 + algebraMap (𝓞 F) (𝓞 L) d * γ + algebraMap (𝓞 F) (𝓞 L) δ = 0)
    (hnot : (γ : L) ∉ Set.range (algebraMap F L)) : minpoly (𝓞 F) γ = X ^ 2 + C d * X + C δ := by
  have _ := hdeg
  have hint : IsIntegral (𝓞 F) γ := (RingOfIntegers.isIntegral_coe γ |> fun _ => (Algebra.IsIntegral.isIntegral γ))
  have hmon : (X ^ 2 + C d * X + C δ : (𝓞 F)[X]).Monic := by monicity!
  have hp : (X ^ 2 + C d * X + C δ : (𝓞 F)[X]).natDegree = 2 := by compute_degree!
  have hz : aeval γ (X ^ 2 + C d * X + C δ : (𝓞 F)[X]) = 0 := by
    simpa [aeval_def] using hroot
  have hdvd := minpoly.isIntegrallyClosed_dvd hint hz
  have hmm : (minpoly (𝓞 F) γ).Monic := minpoly.monic hint
  have hle : (minpoly (𝓞 F) γ).natDegree ≤ 2 := hp ▸ natDegree_le_of_dvd hdvd hmon.ne_zero
  have hpos : 0 < (minpoly (𝓞 F) γ).natDegree := minpoly.natDegree_pos hint
  by_cases h2 : (minpoly (𝓞 F) γ).natDegree = 2
  · exact (eq_of_monic_of_dvd_of_natDegree_le hmm hmon hdvd (by omega)).symm
  · exfalso
    have h1 : (minpoly (𝓞 F) γ).natDegree = 1 := by omega
    have hX := hmm.eq_X_add_C h1
    have ha := minpoly.aeval (𝓞 F) γ
    rw [hX] at ha
    simp only [map_add, aeval_X, aeval_C] at ha
    obtain ⟨c, hc⟩ : ∃ c : 𝓞 F, γ = -(algebraMap (𝓞 F) (𝓞 L) c) := ⟨_, eq_neg_of_add_eq_zero_left ha⟩
    apply hnot
    refine ⟨-(algebraMap (𝓞 F) F c), ?_⟩
    rw [map_neg, ← IsScalarTower.algebraMap_apply (𝓞 F) F L c, hc, RingOfIntegers.coe_eq_algebraMap, map_neg,
      ← IsScalarTower.algebraMap_apply (𝓞 F) (𝓞 L) L c]

/-- **The conductor is prime to `P`** (`Algebra.discr_mul_isIntegral_mem_adjoin`: the discriminant `d² − 4δ = −d²s²` of the
power basis `1, γ` lies in the conductor, and it is a `P`-unit). -/
theorem comap_conductor_sup_eq_top (hdeg : Module.finrank F L = 2) (P : HeightOneSpectrum (𝓞 F)) {s d δ : 𝓞 F}
    (hδ : 4 * δ = d ^ 2 * (1 + s ^ 2)) (hd : d - 1 ∈ P.asIdeal) (hs : s ∉ P.asIdeal) {γ : 𝓞 L}
    (hroot : γ ^ 2 + algebraMap (𝓞 F) (𝓞 L) d * γ + algebraMap (𝓞 F) (𝓞 L) δ = 0)
    (hnot : (γ : L) ∉ Set.range (algebraMap F L)) :
    (conductor (𝓞 F) γ).comap (algebraMap (𝓞 F) (𝓞 L)) ⊔ P.asIdeal = ⊤ := by
  sorry

open Polynomial in
/-- **Kummer–Dedekind at `P`** (`KummerDedekind.normalizedFactors_ideal_map_eq_normalizedFactors_min_poly_mk_map`,
`KummerDedekind.emultiplicity_factors_map_eq_emultiplicity`, `Ideal.sum_ramification_inertia`): the minimal polynomial reduces
to `X² + X + 1`, separable (so every prime over `P` is unramified), split iff `3 ∣ 2^f − 1` iff `f` even, else irreducible
(one prime, inertia `2`); with `card_quot_eq_two_pow`. -/
theorem dyadicConclusion_of_minpoly (hdeg : Module.finrank F L = 2) (P : HeightOneSpectrum (𝓞 F))
    (h2 : (2 : 𝓞 F) ∈ P.asIdeal) {d δ : 𝓞 F} (hd : d - 1 ∈ P.asIdeal) (hδ1 : δ - 1 ∈ P.asIdeal) {γ : 𝓞 L}
    (hmin : minpoly (𝓞 F) γ = X ^ 2 + C d * X + C δ)
    (hcond : (conductor (𝓞 F) γ).comap (algebraMap (𝓞 F) (𝓞 L)) ⊔ P.asIdeal = ⊤) :
    DyadicSqrt3Conclusion L P := by
  sorry

/-- **The P-local engine**: the coefficients of `exists_dyadic_coeffs` give the conclusion (`exists_root_quadratic`,
`minpoly_eq_of_root`, `comap_conductor_sup_eq_top`, `dyadicConclusion_of_minpoly`). Both leaves are its cases: the congruence
at `d = 1`, `δ = 1 + (s² − 3)/4`; the local square through `exists_span_four_eq`, `exists_sq_sub_three_mem_pow` at
`N = a + 1`, `exists_dyadic_coeffs`. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem dyadicConclusion_of_coeffs (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L))
    (P : HeightOneSpectrum (𝓞 F)) (h2 : (2 : 𝓞 F) ∈ P.asIdeal) {s d δ : 𝓞 F} (hδ : 4 * δ = d ^ 2 * (1 + s ^ 2))
    (hd : d - 1 ∈ P.asIdeal) (hδ1 : δ - 1 ∈ P.asIdeal) (hs : s ∉ P.asIdeal) : DyadicSqrt3Conclusion L P := by
  sorry

/-- **SQRT3-LOCAL from the congruence**: if `s² − 3 ∈ 4P` for some `s ∈ 𝓞 F`, the dyadic prime `P` satisfies the conclusion. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem sqrt3_local_of_congr (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)) (P : HeightOneSpectrum (𝓞 F))
    (h2 : (2 : 𝓞 F) ∈ P.asIdeal) (hs : ∃ s : 𝓞 F, s ^ 2 - 3 ∈ Ideal.span {(4 : 𝓞 F)} * P.asIdeal) :
    DyadicSqrt3Conclusion L P := by
  sorry

/-- **FS129-SA1-SQRT3-LOCAL**: for a place `w` of `F` above `2` at which `3` is a square in the completion `F_w`, `w` is
unramified in `F(i)/F`, splits iff `f(w|2)` is even, and is inert of norm `2^f`, `f` odd, when it does not split. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem sqrt3_local (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)) (P : HeightOneSpectrum (𝓞 F))
    (h2 : (2 : 𝓞 F) ∈ P.asIdeal) (h3 : IsSquare (3 : P.adicCompletion F)) : DyadicSqrt3Conclusion L P := by
  sorry

/-- **TC1-SQRT3-DYADIC** (merged): if `√3 ∈ F` and `i ∉ F`, every place of `F` above `2` satisfies the conclusion. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem sqrt3_dyadic (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)) (h3 : ∃ r : F, r ^ 2 = 3)
    (P : HeightOneSpectrum (𝓞 F)) (h2 : (2 : 𝓞 F) ∈ P.asIdeal) : DyadicSqrt3Conclusion L P := by
  obtain ⟨r, hr⟩ := h3
  have hint : IsIntegral ℤ r := by
    refine ⟨Polynomial.X ^ 2 - Polynomial.C 3, Polynomial.monic_X_pow_sub_C _ (by norm_num), ?_⟩
    simp [hr]
  obtain ⟨s, hs⟩ : ∃ s : 𝓞 F, (s : F) = r := ⟨⟨r, hint⟩, rfl⟩
  refine sqrt3_local_of_congr hdeg hi P h2 ⟨s, ?_⟩
  have hs' : algebraMap (𝓞 F) F s = r := hs
  have h0 : s ^ 2 - 3 = 0 := by
    apply FaithfulSMul.algebraMap_injective (𝓞 F) F
    rw [map_sub, map_pow, hs', hr, map_zero, map_ofNat, sub_self]
  rw [h0]; exact Ideal.zero_mem _

end HadwigerNelson.Arith
