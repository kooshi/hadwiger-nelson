import Proofs.HadwigerNelson.NoParam

/-!
# The plant: Lemma NP's route, run on the genus-0 twin `a² − 1` (J17K2, not part of the library)

Each step of `HadwigerNelson.NoParam`'s proof, transported: lowest terms, the integrally-closed step, pairwise coprime factors
each a unit times a square, one Fermat–Catalan equation, `Polynomial.flt_catalan`. On the twin the factors are `p − q` and
`p + q`, and their relation `r₂δ² − r₁γ² − 2q = 0` has signature `(2, 2, 1)`. Expected: exactly ONE error, at `flt_catalan`'s
signature hypothesis `2·1 + 1·2 + 2·2 ≤ 2·2·1` (i.e. `8 ≤ 4`, `1/2 + 1/2 + 1 > 1`: genus 0), and every scaffolding step green.
The last `example` derives `False` from the errored theorem and the kernel's twin counterexample, so the error is the only
thing standing between this route and a contradiction.
-/

set_option autoImplicit false

open Polynomial HadwigerNelson.NoParam

variable {k : Type*} [Field k]

theorem twin_core_attempt (h2 : (2 : k) ≠ 0) {p q g : k[X]} (hpq : IsCoprime p q)
    (hg : (p - q) * (p + q) = g ^ 2) : p.natDegree = 0 ∧ q.natDegree = 0 := by
  have hunit : ∀ {x : k[X]}, IsUnit x → x.natDegree = 0 := fun hx => natDegree_eq_zero_of_isUnit hx
  have h2u : IsUnit (2 : k[X]) := by
    rw [show (2 : k[X]) = C 2 from (map_ofNat C 2).symm]; exact isUnit_C.mpr h2.isUnit
  -- the two factors are coprime (they differ by `2q` and sum to `2p`)
  have hmq : IsCoprime (p - q) q := by
    have := hpq.add_mul_right_left (-1); rwa [show p + -1 * q = p - q by ring] at this
  have hcop : IsCoprime (p - q) (p + q) := by
    have h2q : IsCoprime (p - q) (2 * q) := (isCoprime_mul_unit_left_right h2u _ _).mpr hmq
    have := h2q.add_mul_left_right 1; rwa [show 2 * q + (p - q) * 1 = p + q by ring] at this
  by_cases hq0 : q = 0
  · subst hq0; exact ⟨hunit (isCoprime_zero_right.mp hpq), natDegree_zero⟩
  by_cases hm0 : p - q = 0
  · have hpq' : p = q := sub_eq_zero.mp hm0
    exact ⟨hunit (hpq.isUnit_of_dvd' dvd_rfl (hpq' ▸ dvd_rfl)),
      hunit (hpq.isUnit_of_dvd' (hpq' ▸ dvd_rfl) dvd_rfl)⟩
  by_cases hp0 : p + q = 0
  · have hpq' : p = -q := eq_neg_of_add_eq_zero_left hp0
    exact ⟨hunit (hpq.isUnit_of_dvd' dvd_rfl ⟨-1, by rw [hpq']; ring⟩),
      hunit (hpq.isUnit_of_dvd' ⟨-1, by rw [hpq']; ring⟩ dvd_rfl)⟩
  -- each factor is a unit times a square
  obtain ⟨r₁, γ, hr₁, hγ⟩ := exists_eq_C_mul_sq_of_mul_eq_sq hcop hg
  obtain ⟨r₂, δ, hr₂, hδ⟩ := exists_eq_C_mul_sq_of_mul_eq_sq hcop.symm (by rw [mul_comm]; exact hg)
  have hγ0 : γ ≠ 0 := by rintro rfl; apply hm0; rw [← hγ]; ring
  have hδ0 : δ ≠ 0 := by rintro rfl; apply hp0; rw [← hδ]; ring
  have hδγ : IsCoprime δ γ := by
    have := hcop.symm; rw [← hγ, ← hδ] at this
    exact (IsCoprime.pow_iff two_pos two_pos).mp this.of_mul_left_left.of_mul_right_left
  -- the Fermat–Catalan equation, now of signature (2, 2, 1)
  have heq : C r₂ * δ ^ 2 + C (-r₁) * γ ^ 2 + C (-2) * q ^ 1 = 0 := by
    simp only [map_neg, pow_one, map_ofNat]
    linear_combination hδ - hγ
  obtain ⟨hδd, hγd, hqd⟩ := Polynomial.flt_catalan (p := 2) (q := 2) (r := 1) (by norm_num) (by norm_num)
    (by norm_num)
    (by norm_num) -- THE SIGNATURE HYPOTHESIS: 2 * 1 + 1 * 2 + 2 * 2 ≤ 2 * 2 * 1
    (by exact_mod_cast h2) (by exact_mod_cast h2) (by simp) hδ0 hγ0 hq0 hδγ hr₂
    (neg_ne_zero.mpr hr₁) (neg_ne_zero.mpr h2) heq
  refine ⟨?_, by simpa using hqd⟩
  have hp2 : 2 * p = δ ^ 2 * C r₂ + γ ^ 2 * C r₁ := by rw [hδ, hγ]; ring
  have : (2 * p).natDegree = 0 := by
    rw [hp2]; refine Nat.le_zero.mp (natDegree_add_le_of_degree_le ?_ ?_) <;>
      simp [natDegree_mul_C, hr₁, hr₂, natDegree_pow, hδd, hγd]
  rwa [show (2 : k[X]) = C 2 from (map_ofNat C 2).symm, natDegree_C_mul h2] at this

theorem twin_NP_attempt (h2 : (2 : k) ≠ 0) {a : RatFunc k}
    (ha : a ∉ Set.range (RatFunc.C (K := k))) : ¬ IsSquare (a ^ 2 - 1) := by
  rintro ⟨b, hb⟩
  have hQ : algebraMap k[X] (RatFunc k) a.denom ≠ 0 := RatFunc.algebraMap_ne_zero a.denom_ne_zero
  have haQ : algebraMap k[X] (RatFunc k) a.num = a * algebraMap k[X] (RatFunc k) a.denom :=
    (div_eq_iff hQ).mp (RatFunc.num_div_denom a)
  -- `(b·q)² = (p − q)(p + q)`
  have hB : (b * algebraMap k[X] (RatFunc k) a.denom) ^ 2 =
      algebraMap k[X] (RatFunc k) ((a.num - a.denom) * (a.num + a.denom)) := by
    simp only [map_mul, map_sub, map_add]
    set P := algebraMap k[X] (RatFunc k) a.num
    set Q := algebraMap k[X] (RatFunc k) a.denom
    linear_combination (-(Q ^ 2)) * hb - (a * Q + P) * haQ
  obtain ⟨g, hg⟩ := exists_algebraMap_eq_of_sq_eq hB
  have hg2 : (a.num - a.denom) * (a.num + a.denom) = g ^ 2 := by
    apply RatFunc.algebraMap_injective k
    rw [map_pow, hg, hB]
  obtain ⟨hp, hq⟩ := twin_core_attempt h2 (RatFunc.isCoprime_num_denom a) hg2
  refine ha ⟨a.num.coeff 0 / a.denom.coeff 0, ?_⟩
  rw [map_div₀, ← RatFunc.algebraMap_C, ← RatFunc.algebraMap_C, ← eq_C_of_natDegree_eq_zero hp,
    ← eq_C_of_natDegree_eq_zero hq, RatFunc.num_div_denom]

-- The route's only obstacle is the error above: with it, the kernel's twin counterexample gives `False`.
example : False :=
  twin_NP_attempt (k := ℚ) two_ne_zero (twin_not_mem_range_C ℚ two_ne_zero) (isSquare_twin_sq_sub_one ℚ two_ne_zero)

#print axioms twin_core_attempt
