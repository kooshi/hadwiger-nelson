import Mathlib.Algebra.Polynomial.SpecificDegree
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.FieldTheory.PrimitiveElement
import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.RingTheory.Trace.Basic
import Mathlib.RingTheory.Adjoin.PowerBasis
import Mathlib.RingTheory.IntegralClosure.IntegralRestrict
import Mathlib.NumberTheory.KummerDedekind
import Mathlib.NumberTheory.NumberField.Basic
import Mathlib.RingTheory.RamificationInertia.Ramification
import Mathlib.RingTheory.RamificationInertia.Inertia
import Mathlib.RingTheory.DedekindDomain.AdicValuation
import Mathlib.RingTheory.Conductor
import Mathlib.NumberTheory.NumberField.Ideal.Basic
import Mathlib.NumberTheory.RamificationInertia.Basic

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

/-! ## FS131-K2c: children (each proved; plan `plans/FS131-w2-kernel-plan.md` § 12)

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

open Polynomial in
/-- A root of a quadratic outside `F` generates `L/F` when `[L : F] = 2` (a power basis). -/
theorem exists_powerBasis_of_root (hdeg : Module.finrank F L = 2) {g : L} (hint : IsIntegral F g)
    (hnot : g ∉ Set.range (algebraMap F L)) : ∃ B : PowerBasis F L, B.gen = g := by
  have hdeg2 : (minpoly F g).natDegree = 2 := by
    have hle : (minpoly F g).natDegree ≤ 2 := hdeg ▸ minpoly.natDegree_le g
    have hpos := minpoly.natDegree_pos hint
    by_contra h2
    have h1 : (minpoly F g).natDegree = 1 := by omega
    have hX := (minpoly.monic hint).eq_X_add_C h1
    have ha := minpoly.aeval F g
    rw [hX] at ha
    simp only [map_add, aeval_X, aeval_C] at ha
    exact hnot ⟨-((minpoly F g).coeff 0), by
      rw [map_neg]; exact (eq_neg_of_add_eq_zero_left ha).symm⟩
  have htop : IntermediateField.adjoin F {g} = ⊤ := (Field.primitive_element_iff_minpoly_natDegree_eq F g).2 (by rw [hdeg2, hdeg])
  have hadj : Algebra.adjoin F {g} = ⊤ := by
    rw [← IntermediateField.adjoin_simple_toSubalgebra_of_isAlgebraic hint.isAlgebraic, htop, IntermediateField.top_toSubalgebra]
  exact ⟨PowerBasis.ofAdjoinEqTop hint hadj, PowerBasis.ofAdjoinEqTop_gen hint hadj⟩

open Polynomial in
/-- Coordinates of an integral element of a quadratic extension, up to the discriminant of the generator. -/
theorem exists_coords_of_quadratic (hdeg : Module.finrank F L = 2) {d δ : 𝓞 F} {g : L}
    (hq : g ^ 2 + algebraMap (𝓞 F) L d * g + algebraMap (𝓞 F) L δ = 0)
    (hnot : g ∉ Set.range (algebraMap F L)) {b : L} (hb : IsIntegral (𝓞 F) b) :
    ∃ p q : 𝓞 F, algebraMap (𝓞 F) L (d ^ 2 - 4 * δ) * b = algebraMap (𝓞 F) L p + algebraMap (𝓞 F) L q * g := by
  have hint : IsIntegral F g := IsIntegral.of_finite F g
  obtain ⟨B, hB⟩ := exists_powerBasis_of_root hdeg hint hnot
  set dF : F := algebraMap (𝓞 F) F d
  set δF : F := algebraMap (𝓞 F) F δ
  have e1 : algebraMap (𝓞 F) L d = algebraMap F L dF := IsScalarTower.algebraMap_apply (𝓞 F) F L d
  have e2 : algebraMap (𝓞 F) L δ = algebraMap F L δF := IsScalarTower.algebraMap_apply (𝓞 F) F L δ
  rw [e1, e2] at hq
  -- the minimal polynomial over `F`
  have hmin : minpoly F g = X ^ 2 + C dF * X + C δF := by
    have hdeg2 : (minpoly F g).natDegree = 2 := by
      have hle : (minpoly F g).natDegree ≤ 2 := hdeg ▸ minpoly.natDegree_le g
      have hpos := minpoly.natDegree_pos hint
      by_contra h2
      have h1 : (minpoly F g).natDegree = 1 := by omega
      have hX := (minpoly.monic hint).eq_X_add_C h1
      have ha := minpoly.aeval F g
      rw [hX] at ha
      simp only [map_add, aeval_X, aeval_C] at ha
      exact hnot ⟨-((minpoly F g).coeff 0), by rw [map_neg]; exact (eq_neg_of_add_eq_zero_left ha).symm⟩
    have hmon : (X ^ 2 + C dF * X + C δF : F[X]).Monic := by monicity!
    have hp : (X ^ 2 + C dF * X + C δF : F[X]).natDegree = 2 := by compute_degree!
    have hz : aeval g (X ^ 2 + C dF * X + C δF : F[X]) = 0 := by simpa [aeval_def] using hq
    exact (eq_of_monic_of_dvd_of_natDegree_le (minpoly.monic hint) hmon (minpoly.dvd F g hz) (by omega)).symm
  -- traces
  have hdim : B.dim = 2 := by rw [← B.finrank, hdeg]
  have htr1 : Algebra.trace F L (1 : L) = 2 := by
    have := Algebra.trace_algebraMap (R := F) (S := L) 1
    rw [map_one, hdeg] at this; simpa using this
  have htrg : Algebra.trace F L g = -dF := by
    have := B.trace_gen_eq_nextCoeff_minpoly
    rw [hB, hmin] at this
    rw [this]
    have hn : (X ^ 2 + C dF * X + C δF : F[X]).natDegree = 2 := by compute_degree!
    have : (X ^ 2 + C dF * X + C δF : F[X]).nextCoeff = dF := by
      rw [nextCoeff_of_natDegree_pos (by omega), hn]
      simp [coeff_add, coeff_X_pow, coeff_C]
    rw [this]
  have hg2 : g ^ 2 = -(algebraMap F L dF * g) - algebraMap F L δF := by linear_combination hq
  obtain ⟨f, hfd, hbf⟩ := B.exists_eq_aeval b
  rw [hdim] at hfd
  have hf1 : f.natDegree ≤ 1 := by omega
  have hfe := eq_X_add_C_of_natDegree_le_one hf1
  set u : F := f.coeff 0
  set v : F := f.coeff 1
  have hbuv : b = u • (1 : L) + v • g := by
    rw [hbf, hfe, hB]; simp [aeval_def, Algebra.smul_def, add_comm]
  have hgint : IsIntegral (𝓞 F) g := by
    refine ⟨X ^ 2 + C d * X + C δ, by monicity!, ?_⟩
    simp only [eval₂_add, eval₂_mul, eval₂_pow, eval₂_X, eval₂_C]
    rw [e1, e2]; exact hq
  have hT0 : Algebra.trace F L b = 2 * u - v * dF := by
    rw [hbuv, map_add, map_smul, map_smul, htr1, htrg]; simp only [smul_eq_mul]; ring
  have hT1 : Algebra.trace F L (b * g) = -dF * u + v * (dF ^ 2 - 2 * δF) := by
    have : b * g = u • g + v • (-(dF • g) - δF • (1 : L)) := by
      rw [hbuv, add_mul, smul_mul_assoc, smul_mul_assoc, one_mul, ← pow_two, hg2]
      simp only [Algebra.smul_def]; ring_nf
    rw [this, map_add, map_smul, map_smul, map_sub, map_neg, map_smul, map_smul, htr1, htrg]
    simp only [smul_eq_mul]; ring
  obtain ⟨t0, ht0⟩ := IsIntegrallyClosed.isIntegral_iff.1 (Algebra.isIntegral_trace (L := F) (F := L) hb)
  obtain ⟨t1, ht1⟩ := IsIntegrallyClosed.isIntegral_iff.1 (Algebra.isIntegral_trace (L := F) (F := L) (hb.mul hgint))
  refine ⟨(d ^ 2 - 2 * δ) * t0 + d * t1, d * t0 + 2 * t1, ?_⟩
  have hu : (dF ^ 2 - 4 * δF) * u = (dF ^ 2 - 2 * δF) * algebraMap (𝓞 F) F t0 + dF * algebraMap (𝓞 F) F t1 := by
    rw [ht0, ht1, hT0, hT1]; ring
  have hv : (dF ^ 2 - 4 * δF) * v = dF * algebraMap (𝓞 F) F t0 + 2 * algebraMap (𝓞 F) F t1 := by
    rw [ht0, ht1, hT0, hT1]; ring
  have hL : ∀ x : 𝓞 F, algebraMap (𝓞 F) L x = algebraMap F L (algebraMap (𝓞 F) F x) := fun x =>
    IsScalarTower.algebraMap_apply (𝓞 F) F L x
  have hbuv' : b = algebraMap F L u + algebraMap F L v * g := by
    rw [hbuv]; simp [Algebra.smul_def]
  have hP : algebraMap (𝓞 F) F ((d ^ 2 - 2 * δ) * t0 + d * t1) =
      (dF ^ 2 - 2 * δF) * algebraMap (𝓞 F) F t0 + dF * algebraMap (𝓞 F) F t1 := by
    simp only [map_add, map_mul, map_sub, map_pow, map_ofNat, dF, δF]
  have hQ : algebraMap (𝓞 F) F (d * t0 + 2 * t1) = dF * algebraMap (𝓞 F) F t0 + 2 * algebraMap (𝓞 F) F t1 := by
    simp only [map_add, map_mul, map_ofNat, dF]
  have hD : algebraMap (𝓞 F) F (d ^ 2 - 4 * δ) = dF ^ 2 - 4 * δF := by
    simp only [map_sub, map_mul, map_pow, map_ofNat, dF, δF]
  rw [hL, hL, hL, hP, hQ, hD, ← hu, ← hv, hbuv']
  simp only [map_mul, map_sub, map_pow, map_ofNat]; ring


/-- **The conductor is prime to `P`** (`Algebra.discr_mul_isIntegral_mem_adjoin`: the discriminant `d² − 4δ = −d²s²` of the
power basis `1, γ` lies in the conductor, and it is a `P`-unit). -/
theorem comap_conductor_sup_eq_top (hdeg : Module.finrank F L = 2) (P : HeightOneSpectrum (𝓞 F)) {s d δ : 𝓞 F}
    (hδ : 4 * δ = d ^ 2 * (1 + s ^ 2)) (hd : d - 1 ∈ P.asIdeal) (hs : s ∉ P.asIdeal) {γ : 𝓞 L}
    (hroot : γ ^ 2 + algebraMap (𝓞 F) (𝓞 L) d * γ + algebraMap (𝓞 F) (𝓞 L) δ = 0)
    (hnot : (γ : L) ∉ Set.range (algebraMap F L)) :
    (conductor (𝓞 F) γ).comap (algebraMap (𝓞 F) (𝓞 L)) ⊔ P.asIdeal = ⊤ := by
  haveI : P.asIdeal.IsMaximal := P.isPrime.isMaximal P.ne_bot
  have hdP : d ∉ P.asIdeal := by
    intro h
    have : (1 : 𝓞 F) ∈ P.asIdeal := by
      have h1 : (1 : 𝓞 F) = d - (d - 1) := by ring
      rw [h1]; exact P.asIdeal.sub_mem h hd
    exact P.isPrime.ne_top ((Ideal.eq_top_iff_one _).mpr this)
  have hxP : d ^ 2 * s ^ 2 ∉ P.asIdeal := by
    intro h
    rcases P.isPrime.mem_or_mem h with h | h
    · exact hdP (P.isPrime.mem_of_pow_mem 2 h)
    · exact hs (P.isPrime.mem_of_pow_mem 2 h)
  have hq : (γ : L) ^ 2 + algebraMap (𝓞 F) L d * γ + algebraMap (𝓞 F) L δ = 0 := by
    have := congrArg (fun z : 𝓞 L => (z : L)) hroot
    simpa [RingOfIntegers.coe_eq_algebraMap, IsScalarTower.algebraMap_apply (𝓞 F) (𝓞 L) L] using this
  have hmem : algebraMap (𝓞 F) (𝓞 L) (d ^ 2 * s ^ 2) ∈ conductor (𝓞 F) γ := by
    rw [mem_conductor_iff]
    intro b
    have hbi : IsIntegral (𝓞 F) (b : L) := (RingOfIntegers.isIntegral_coe b).tower_top
    obtain ⟨p, q, hpq⟩ := exists_coords_of_quadratic hdeg hq hnot hbi
    have hD : d ^ 2 - 4 * δ = -(d ^ 2 * s ^ 2) := by linear_combination -hδ
    rw [hD, map_neg, neg_mul, neg_eq_iff_eq_neg] at hpq
    have : algebraMap (𝓞 F) (𝓞 L) (d ^ 2 * s ^ 2) * b = algebraMap (𝓞 F) (𝓞 L) (-p) + algebraMap (𝓞 F) (𝓞 L) (-q) * γ := by
      apply Subtype.val_injective
      have hc : ∀ x : 𝓞 F, ((algebraMap (𝓞 F) (𝓞 L) x : 𝓞 L) : L) = algebraMap (𝓞 F) L x := fun x => by
        rw [IsScalarTower.algebraMap_apply (𝓞 F) (𝓞 L) L x]
      show ((algebraMap (𝓞 F) (𝓞 L) (d ^ 2 * s ^ 2) : 𝓞 L) : L) * (b : L) =
        ((algebraMap (𝓞 F) (𝓞 L) (-p) : 𝓞 L) : L) + ((algebraMap (𝓞 F) (𝓞 L) (-q) : 𝓞 L) : L) * (γ : L)
      rw [hc, hc, hc, map_neg, map_neg]
      linear_combination hpq
    rw [this]
    exact Subalgebra.add_mem _ (Subalgebra.algebraMap_mem _ _)
      (Subalgebra.mul_mem _ (Subalgebra.algebraMap_mem _ _) (Algebra.self_mem_adjoin_singleton _ _))
  have hle : ¬ (conductor (𝓞 F) γ).comap (algebraMap (𝓞 F) (𝓞 L)) ≤ P.asIdeal := fun h => hxP (h hmem)
  rw [sup_comm]
  exact ‹P.asIdeal.IsMaximal›.out.2 _ (left_lt_sup.mpr hle)

/-- `3 ∣ 2^f − 1` exactly when `f` is even (`4^m ≡ 1 (mod 3)`). -/
theorem three_dvd_two_pow_sub_one_iff (f : ℕ) : 3 ∣ 2 ^ f - 1 ↔ Even f := by
  rcases Nat.even_or_odd' f with ⟨m, rfl | rfl⟩
  · have h1 : 3 ∣ 4 ^ m - 1 := by simpa using Nat.sub_dvd_pow_sub_pow 4 1 m
    have : (2 : ℕ) ^ (2 * m) = 4 ^ m := by rw [pow_mul]; norm_num
    rw [this]; simpa using h1
  · have h1 : 3 ∣ 4 ^ m - 1 := by simpa using Nat.sub_dvd_pow_sub_pow 4 1 m
    have h4 : 1 ≤ 4 ^ m := Nat.one_le_pow _ _ (by norm_num)
    have : (2 : ℕ) ^ (2 * m + 1) = 2 * 4 ^ m := by rw [pow_succ, pow_mul]; norm_num; ring
    rw [this]
    have hodd : ¬ Even (2 * m + 1) := by simp
    simp only [hodd, iff_false]
    omega

open Polynomial UniqueFactorizationMonoid in
/-- **Kummer–Dedekind at `P`** (`KummerDedekind.normalizedFactors_ideal_map_eq_normalizedFactors_min_poly_mk_map`,
`KummerDedekind.emultiplicity_factors_map_eq_emultiplicity`, `Ideal.sum_ramification_inertia`): the minimal polynomial reduces
to `X² + X + 1`, separable (so every prime over `P` is unramified), split iff `3 ∣ 2^f − 1` iff `f` even, else irreducible
(one prime, inertia `2`); with `card_quot_eq_two_pow`. -/
theorem dyadicConclusion_of_minpoly (hdeg : Module.finrank F L = 2) (P : HeightOneSpectrum (𝓞 F))
    (h2 : (2 : 𝓞 F) ∈ P.asIdeal) {d δ : 𝓞 F} (hd : d - 1 ∈ P.asIdeal) (hδ1 : δ - 1 ∈ P.asIdeal) {γ : 𝓞 L}
    (hmin : minpoly (𝓞 F) γ = X ^ 2 + C d * X + C δ)
    (hcond : (conductor (𝓞 F) γ).comap (algebraMap (𝓞 F) (𝓞 L)) ⊔ P.asIdeal = ⊤) :
    DyadicSqrt3Conclusion L P := by
  classical
  haveI hPmax : P.asIdeal.IsMaximal := P.isPrime.isMaximal P.ne_bot
  have hP0 : P.asIdeal ≠ ⊥ := P.ne_bot
  have hint : IsIntegral (𝓞 F) γ := Algebra.IsIntegral.isIntegral γ
  set p := P.asIdeal with hp
  letI : Field (𝓞 F ⧸ p) := Ideal.Quotient.field p
  letI : Fintype (𝓞 F ⧸ p) := Fintype.ofFinite _
  have h2k : ((2 : ℕ) : 𝓞 F ⧸ p) = 0 := by
    rw [Nat.cast_ofNat, ← map_ofNat (Ideal.Quotient.mk p), Ideal.Quotient.eq_zero_iff_mem]; exact h2
  haveI : CharP (𝓞 F ⧸ p) 2 := by
    refine ringChar.of_eq ?_
    rcases (Nat.dvd_prime Nat.prime_two).mp (ringChar.dvd h2k) with h | h
    · exact absurd h (CharP.ringChar_ne_one)
    · exact h
  have hcard : Fintype.card (𝓞 F ⧸ p) = 2 ^ Ideal.inertiaDeg p ℤ := by
    rw [← Nat.card_eq_fintype_card]; exact card_quot_eq_two_pow P h2
  -- the reduced minimal polynomial
  have hred : (minpoly (𝓞 F) γ).map (Ideal.Quotient.mk p) = (X ^ 2 + X + 1 : (𝓞 F ⧸ p)[X]) := by
    have e1 : Ideal.Quotient.mk p d = 1 := by
      rw [← map_one (Ideal.Quotient.mk p)]; exact Ideal.Quotient.eq.mpr hd
    have e2 : Ideal.Quotient.mk p δ = 1 := by
      rw [← map_one (Ideal.Quotient.mk p)]; exact Ideal.Quotient.eq.mpr hδ1
    rw [hmin]
    simp [Polynomial.map_add, Polynomial.map_mul, e1, e2]
  obtain ⟨hsep, hirr⟩ := x2x1_separable_irreducible_iff (K := 𝓞 F ⧸ p)
  rw [hcard, three_dvd_two_pow_sub_one_iff] at hirr
  set q : (𝓞 F ⧸ p)[X] := X ^ 2 + X + 1 with hq
  have hq0 : q ≠ 0 := hsep.ne_zero
  have hMnd : (normalizedFactors q).Nodup := (squarefree_iff_nodup_normalizedFactors hq0).mp hsep.squarefree
  -- Kummer–Dedekind
  set NF := normalizedFactors (p.map (algebraMap (𝓞 F) (𝓞 L))) with hNF
  have hKD := KummerDedekind.normalizedFactors_ideal_map_eq_normalizedFactors_min_poly_mk_map hPmax hP0 hcond hint
  have hcardNF : Multiset.card NF = Multiset.card (normalizedFactors q) := by
    rw [hNF, hKD, Multiset.card_map]
    erw [Multiset.card_attach]
    rw [hred]
  have hNFnd : NF.Nodup := by
    rw [hNF, hKD]
    refine Multiset.Nodup.map (fun a b hab => ?_) (Multiset.nodup_attach.mpr (hred ▸ hMnd))
    exact (KummerDedekind.normalizedFactorsMapEquivNormalizedFactorsMinPolyMk hPmax hP0 hcond hint).symm.injective
      (Subtype.val_injective hab)
  have hmemP : ∀ Q : Ideal (𝓞 L), Q ∈ p.primesOver (𝓞 L) ↔ Q ∈ NF := fun Q =>
    Ideal.mem_primesOver_iff_mem_normalizedFactors (𝓞 L) hP0
  have hset : p.primesOver (𝓞 L) = ↑NF.toFinset := by
    ext Q; rw [hmemP, Finset.mem_coe, Multiset.mem_toFinset]
  have hncard : (p.primesOver (𝓞 L)).ncard = Multiset.card (normalizedFactors q) := by
    rw [hset, Set.ncard_coe_finset, Multiset.toFinset_card_of_nodup hNFnd, hcardNF]
  have hpS : p.map (algebraMap (𝓞 F) (𝓞 L)) ≠ ⊥ := Ideal.map_ne_bot_of_ne_bot hP0
  have he : ∀ Q ∈ p.primesOver (𝓞 L), Ideal.ramificationIdx Q (𝓞 F) = 1 := by
    intro Q hQ
    haveI : Q.LiesOver p := hQ.2
    rw [Ideal.IsDedekindDomain.ramificationIdx_eq_normalizedFactors_count p Q hpS]
    exact Multiset.count_eq_one_of_mem hNFnd ((hmemP Q).1 hQ)
  -- `1 ≤ card ≤ 2`, and `= 1` iff irreducible
  have hle2 : Multiset.card (normalizedFactors q) ≤ 2 := by
    haveI : NoZeroSMulDivisors (𝓞 F) (𝓞 L) := ⟨fun {r m} h => by
      rw [Algebra.smul_def] at h
      rcases mul_eq_zero.mp h with h | h
      · exact Or.inl ((map_eq_zero_iff _ (FaithfulSMul.algebraMap_injective (𝓞 F) (𝓞 L))).mp h)
      · exact Or.inr h⟩
    have := Ideal.card_primesOverFinset_le_finrank (𝓞 L) F L hP0 (p := p)
    rw [hdeg] at this
    rw [← hncard, ← IsDedekindDomain.coe_primesOverFinset hP0 (𝓞 L), Set.ncard_coe_finset]
    exact this
  have hge1 : 1 ≤ Multiset.card (normalizedFactors q) := by
    rw [Nat.one_le_iff_ne_zero, Ne, Multiset.card_eq_zero]
    intro h0
    have hprod := prod_normalizedFactors hq0
    rw [h0, Multiset.prod_zero] at hprod
    have hu : IsUnit q := hprod.isUnit_iff.mp isUnit_one
    have : q.natDegree = 0 := natDegree_eq_zero_of_isUnit hu
    rw [hq] at this
    have h2d : (X ^ 2 + X + 1 : (𝓞 F ⧸ p)[X]).natDegree = 2 := by compute_degree!
    omega
  have hone : Multiset.card (normalizedFactors q) = 1 ↔ Irreducible q := by
    constructor
    · intro h1
      obtain ⟨r, hr⟩ := Multiset.card_eq_one.mp h1
      have hprod := prod_normalizedFactors hq0
      rw [hr, Multiset.prod_singleton] at hprod
      exact hprod.irreducible (irreducible_of_normalized_factor r (by rw [hr]; exact Multiset.mem_singleton_self r))
    · intro hi
      rw [normalizedFactors_irreducible hi, Multiset.card_singleton]
  have hsplit : (p.primesOver (𝓞 L)).ncard = 2 ↔ Even (Ideal.inertiaDeg p ℤ) := by
    rw [hncard]
    constructor
    · intro h2'
      by_contra hne
      have := hone.mpr (hirr.mpr hne)
      omega
    · intro hev
      have hni : ¬ Irreducible q := fun hi => hirr.mp hi hev
      have : Multiset.card (normalizedFactors q) ≠ 1 := fun h => hni (hone.mp h)
      omega
  refine ⟨he, hsplit, fun hne => ?_⟩
  have h1 : (p.primesOver (𝓞 L)).ncard = 1 := by rw [hncard] at hne ⊢; omega
  refine ⟨h1, fun Q hQ => ?_, Nat.not_even_iff_odd.mp ((hsplit.not).mp hne), card_quot_eq_two_pow P h2⟩
  haveI : Q.IsPrime := hQ.1
  haveI : Q.LiesOver p := hQ.2
  haveI : Q.IsMaximal := Ideal.IsMaximal.of_liesOver_isMaximal Q p
  have hfin : IsDedekindDomain.primesOverFinset p (𝓞 L) = {Q} := by
    have hc : (IsDedekindDomain.primesOverFinset p (𝓞 L)).card = 1 := by
      rw [← Set.ncard_coe_finset, IsDedekindDomain.coe_primesOverFinset hP0]; exact h1
    obtain ⟨Q', hQ'⟩ := Finset.card_eq_one.mp hc
    have hmem : Q ∈ IsDedekindDomain.primesOverFinset p (𝓞 L) := by
      rw [← Finset.mem_coe, IsDedekindDomain.coe_primesOverFinset hP0]; exact hQ
    rw [hQ'] at hmem ⊢
    rw [Finset.mem_singleton.mp hmem]
  have hsum := Ideal.sum_ramification_inertia (𝓞 L) F L hP0 (p := p)
  rw [hfin, Finset.sum_singleton, hdeg, Ideal.ramificationIdx'_eq_ramificationIdx p Q hP0, he Q hQ, one_mul,
    Ideal.inertiaDeg'_eq_inertiaDeg p Q] at hsum
  exact hsum


/-- **The P-local engine**: the coefficients of `exists_dyadic_coeffs` give the conclusion (`exists_root_quadratic`,
`minpoly_eq_of_root`, `comap_conductor_sup_eq_top`, `dyadicConclusion_of_minpoly`). Both leaves are its cases: the congruence
at `d = 1`, `δ = 1 + (s² − 3)/4`; the local square through `exists_span_four_eq`, `exists_sq_sub_three_mem_pow` at
`N = a + 1`, `exists_dyadic_coeffs`. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem dyadicConclusion_of_coeffs (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L))
    (P : HeightOneSpectrum (𝓞 F)) (h2 : (2 : 𝓞 F) ∈ P.asIdeal) {s d δ : 𝓞 F} (hδ : 4 * δ = d ^ 2 * (1 + s ^ 2))
    (hd : d - 1 ∈ P.asIdeal) (hδ1 : δ - 1 ∈ P.asIdeal) (hs : s ∉ P.asIdeal) : DyadicSqrt3Conclusion L P := by
  have hd0 : d ≠ 0 := by
    rintro rfl
    exact P.isPrime.ne_top ((Ideal.eq_top_iff_one _).mpr (by simpa using P.asIdeal.neg_mem hd))
  have hs0 : s ≠ 0 := by
    rintro rfl
    exact hs P.asIdeal.zero_mem
  obtain ⟨γ, hroot, hnot⟩ := exists_root_quadratic hdeg hi hδ hd0 hs0
  exact dyadicConclusion_of_minpoly hdeg P h2 hd hδ1 (minpoly_eq_of_root hdeg hroot hnot)
    (comap_conductor_sup_eq_top hdeg P hδ hd hs hroot hnot)

/-- **SQRT3-LOCAL from the congruence**: if `s² − 3 ∈ 4P` for some `s ∈ 𝓞 F`, the dyadic prime `P` satisfies the conclusion. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem sqrt3_local_of_congr (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)) (P : HeightOneSpectrum (𝓞 F))
    (h2 : (2 : 𝓞 F) ∈ P.asIdeal) (hs : ∃ s : 𝓞 F, s ^ 2 - 3 ∈ Ideal.span {(4 : 𝓞 F)} * P.asIdeal) :
    DyadicSqrt3Conclusion L P := by
  obtain ⟨s, hs⟩ := hs
  obtain ⟨t, ht, hst⟩ := Ideal.mem_span_singleton_mul.mp hs
  have hsP : s ∉ P.asIdeal := by
    intro h
    have h3 : (3 : 𝓞 F) ∈ P.asIdeal := by
      have : (3 : 𝓞 F) = s ^ 2 - 4 * t := by rw [hst]; ring
      rw [this]
      exact P.asIdeal.sub_mem (P.asIdeal.pow_mem_of_mem h 2 (by norm_num)) (P.asIdeal.mul_mem_left _ ht)
    have : (1 : 𝓞 F) ∈ P.asIdeal := by
      have : (1 : 𝓞 F) = 3 - 2 := by norm_num
      rw [this]; exact P.asIdeal.sub_mem h3 h2
    exact P.isPrime.ne_top ((Ideal.eq_top_iff_one _).mpr this)
  refine dyadicConclusion_of_coeffs hdeg hi P h2 (s := s) (d := 1) (δ := 1 + t) ?_ (by simp) (by simpa using ht) hsP
  linear_combination hst

/-- **FS129-SA1-SQRT3-LOCAL**: for a place `w` of `F` above `2` at which `3` is a square in the completion `F_w`, `w` is
unramified in `F(i)/F`, splits iff `f(w|2)` is even, and is inert of norm `2^f`, `f` odd, when it does not split. (Ruling, inventory item 134: `hi` carries `ι ∉ F`.) -/
theorem sqrt3_local (hdeg : Module.finrank F L = 2) (hi : ∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)) (P : HeightOneSpectrum (𝓞 F))
    (h2 : (2 : 𝓞 F) ∈ P.asIdeal) (h3 : IsSquare (3 : P.adicCompletion F)) : DyadicSqrt3Conclusion L P := by
  obtain ⟨a, I, h4, hI⟩ := exists_span_four_eq P
  obtain ⟨s, hs⟩ := exists_sq_sub_three_mem_pow P h3 (a + 1)
  obtain ⟨s', d, δ, hδ, hd, hδ1, hs'⟩ := exists_dyadic_coeffs P h2 h4 hI hs
  exact dyadicConclusion_of_coeffs hdeg hi P h2 hδ hd hδ1 hs'

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
