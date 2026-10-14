import Proofs.HadwigerNelson.Arith.NormOneTarget
import Mathlib.NumberTheory.LegendreSymbol.AddCharacter

/-! FS131-ICM3 working file: EN1-UQ4, the fourth-moment count at `Q = 2^f ≥ 256`, against a field of `Q²` elements. -/

open Finset

namespace UQ4Work

variable {k : Type} [Field k] [Fintype k] [DecidableEq k]

-- the norm-one set `μ = {u : u^(Q+1) = 1}`
private abbrev mu (k : Type) [Field k] [Fintype k] [DecidableEq k] (Q : ℕ) : Finset k :=
  univ.filter fun u : k => u ^ (Q + 1) = 1

-- for `s ≠ 0`, at most two `u ∈ μ` have `s + u ∈ μ`: `s^Q u² + s^{Q+1} u + s = 0`
private theorem card_shift_le_two {Q : ℕ} (hfrob : ∀ x y : k, (x + y) ^ Q = x ^ Q + y ^ Q) {s : k} (hs : s ≠ 0) :
    ((mu k Q).filter fun u => (s + u) ^ (Q + 1) = 1).card ≤ 2 := by
  classical
  set p : Polynomial k := Polynomial.C (s ^ Q) * Polynomial.X ^ 2 + Polynomial.C (s ^ (Q + 1)) * Polynomial.X +
    Polynomial.C s with hp
  have hcoeff : p.coeff 0 = s := by simp [hp]
  have hp0 : p ≠ 0 := fun h => hs (by rw [← hcoeff, h, Polynomial.coeff_zero])
  have hdeg : p.natDegree ≤ 2 := by
    rw [hp]
    compute_degree
  refine (Polynomial.card_le_degree_of_subset_roots ?_).trans hdeg
  intro u hu
  rw [Finset.mem_val, Finset.mem_filter, Finset.mem_filter] at hu
  obtain ⟨⟨-, hu1⟩, hsu⟩ := hu
  rw [Polynomial.mem_roots hp0, Polynomial.IsRoot.def, hp]
  simp only [Polynomial.eval_add, Polynomial.eval_mul, Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
  have h1 : (s ^ Q + u ^ Q) * (s + u) = 1 := by rw [← hfrob, ← pow_succ]; exact hsu
  linear_combination u * h1 - (s + u) * hu1

-- `S(b) = Σ_{u ∈ μ} ψ(b u)`
private noncomputable def S (ψ : AddChar k ℂ) (Q : ℕ) (b : k) : ℂ := ∑ u ∈ mu k Q, ψ (b * u)

-- the fourth moment: `Σ_b S(b)⁴ = |k| · #{(p, q) ∈ (μ × μ)² : p₁ + p₂ + q₁ + q₂ = 0}`
private theorem sum_S_pow_four (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) (Q : ℕ) :
    ∑ b : k, S ψ Q b ^ 4 = (Fintype.card k : ℂ) *
      (((mu k Q ×ˢ mu k Q) ×ˢ (mu k Q ×ˢ mu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card := by
  have hsq : ∀ b, S ψ Q b ^ 2 = ∑ p ∈ mu k Q ×ˢ mu k Q, ψ (b * (p.1 + p.2)) := by
    intro b
    rw [S, sq, Finset.sum_mul_sum, ← Finset.sum_product']
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [← AddChar.map_add_eq_mul, mul_add]
  have h4 : ∀ b, S ψ Q b ^ 4 = ∑ z ∈ (mu k Q ×ˢ mu k Q) ×ˢ (mu k Q ×ˢ mu k Q),
      ψ (b * (z.1.1 + z.1.2 + (z.2.1 + z.2.2))) := by
    intro b
    rw [show S ψ Q b ^ 4 = S ψ Q b ^ 2 * S ψ Q b ^ 2 by ring, hsq, Finset.sum_mul_sum, ← Finset.sum_product']
    refine Finset.sum_congr rfl fun z _ => ?_
    rw [← AddChar.map_add_eq_mul]
    congr 1
    ring
  have hprim := AddChar.IsPrimitive.of_ne_one hψ
  rw [Finset.sum_congr rfl fun b _ => h4 b, Finset.sum_comm]
  rw [Finset.sum_congr rfl fun z _ => AddChar.sum_mulShift _ hprim]
  simp only [Nat.cast_ite, Nat.cast_zero]
  rw [Finset.sum_ite, Finset.sum_const_zero, add_zero, Finset.sum_const, nsmul_eq_mul, mul_comm]

-- in characteristic 2 a character takes the values `±1`
omit [Fintype k] [DecidableEq k] in
private theorem addChar_eq_ofReal_re [CharP k 2] (ψ : AddChar k ℂ) (x : k) : ψ x = ((ψ x).re : ℂ) := by
  have h : ψ x * ψ x = 1 := by rw [← AddChar.map_add_eq_mul, CharTwo.add_self_eq_zero, AddChar.map_zero_eq_one]
  rcases mul_self_eq_one_iff.1 h with h1 | h1 <;> rw [h1] <;> simp

private theorem S_eq_ofReal_re [CharP k 2] (ψ : AddChar k ℂ) (Q : ℕ) (b : k) : S ψ Q b = ((S ψ Q b).re : ℂ) := by
  rw [S, Complex.re_sum, Complex.ofReal_sum]
  exact Finset.sum_congr rfl fun u _ => addChar_eq_ofReal_re ψ _

-- `S` is constant on `b·μ`: `u ↦ vu` permutes `μ`
private theorem S_mul_mem (ψ : AddChar k ℂ) (Q : ℕ) {v : k} (hv : v ∈ mu k Q) (b : k) : S ψ Q (b * v) = S ψ Q b := by
  rw [Finset.mem_filter] at hv
  have hv0 : v ≠ 0 := by
    rintro rfl
    rw [zero_pow (Nat.succ_ne_zero Q)] at hv
    exact zero_ne_one hv.2
  rw [S, S]
  refine Finset.sum_nbij' (fun u => v * u) (fun u => v⁻¹ * u) ?_ ?_ ?_ ?_ ?_
  · intro u hu
    rw [Finset.mem_filter] at hu ⊢
    exact ⟨Finset.mem_univ _, by rw [mul_pow, hv.2, hu.2, one_mul]⟩
  · intro u hu
    rw [Finset.mem_filter] at hu ⊢
    exact ⟨Finset.mem_univ _, by rw [mul_pow, inv_pow, hv.2, hu.2, inv_one, one_mul]⟩
  · intro u _
    show v⁻¹ * (v * u) = u
    rw [← mul_assoc, inv_mul_cancel₀ hv0, one_mul]
  · intro u _
    show v * (v⁻¹ * u) = u
    rw [← mul_assoc, mul_inv_cancel₀ hv0, one_mul]
  · intro u _
    show ψ (b * v * u) = ψ (b * (v * u))
    rw [mul_assoc]

-- the count: `N ≤ 3(Q + 1)²` (a pair `p` with `p₁ ≠ p₂` has at most two completions, `p₁ = p₂` at most `Q + 1`)
private theorem card_quad_le [CharP k 2] {Q : ℕ} (hfrob : ∀ x y : k, (x + y) ^ Q = x ^ Q + y ^ Q)
    (hμ : (mu k Q).card = Q + 1) :
    (((mu k Q ×ˢ mu k Q) ×ˢ (mu k Q ×ˢ mu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card ≤
      3 * (Q + 1) ^ 2 := by
  classical
  set A := mu k Q with hA
  have e : (((A ×ˢ A) ×ˢ (A ×ˢ A)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card =
      ∑ p ∈ A ×ˢ A, ((A ×ˢ A).filter fun q => p.1 + p.2 + (q.1 + q.2) = 0).card := by
    rw [Finset.card_eq_sum_ones, Finset.sum_filter, Finset.sum_product]
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [Finset.card_eq_sum_ones, Finset.sum_filter]
  have hp : ∀ p ∈ A ×ˢ A, ((A ×ˢ A).filter fun q => p.1 + p.2 + (q.1 + q.2) = 0).card ≤
      2 + (if p.1 = p.2 then Q + 1 else 0) := by
    intro p _
    have hle : ((A ×ˢ A).filter fun q => p.1 + p.2 + (q.1 + q.2) = 0).card ≤
        (A.filter fun u => (p.1 + p.2 + u) ^ (Q + 1) = 1).card := by
      refine Finset.card_le_card_of_injOn (fun q => q.1) ?_ ?_
      · intro q hq
        rw [Finset.mem_coe, Finset.mem_filter, Finset.mem_product] at hq
        rw [Finset.mem_coe, Finset.mem_filter]
        have h2 : q.2 = p.1 + p.2 + q.1 := by
          have := hq.2
          rw [← CharTwo.neg_eq (p.1 + p.2 + q.1)]
          linear_combination this
        refine ⟨hq.1.1, ?_⟩
        have hq2 := hq.1.2
        rw [hA, Finset.mem_filter] at hq2
        rw [← h2]
        exact hq2.2
      · intro q hq q' hq' h
        rw [Finset.mem_coe, Finset.mem_filter] at hq hq'
        have h2 : q.2 = p.1 + p.2 + q.1 := by
          rw [← CharTwo.neg_eq (p.1 + p.2 + q.1)]
          linear_combination hq.2
        have h2' : q'.2 = p.1 + p.2 + q'.1 := by
          rw [← CharTwo.neg_eq (p.1 + p.2 + q'.1)]
          linear_combination hq'.2
        have h1 : q.1 = q'.1 := h
        exact Prod.ext h1 (by rw [h2, h2', h1])
    refine hle.trans ?_
    split_ifs with heq
    · exact (Finset.card_filter_le _ _).trans (by rw [hμ]; omega)
    · have hc : p.1 + p.2 ≠ 0 := by
        intro h0
        apply heq
        rw [← CharTwo.neg_eq p.2]
        linear_combination h0
      exact (card_shift_le_two hfrob hc).trans (by omega)
  have hdiag : ((A ×ˢ A).filter fun p : k × k => p.1 = p.2).card = Q + 1 := by
    rw [← hμ]
    refine Finset.card_nbij' (fun p => p.1) (fun u => (u, u)) ?_ ?_ ?_ ?_
    · intro p hp
      rw [Finset.mem_coe, Finset.mem_filter, Finset.mem_product] at hp
      exact hp.1.1
    · intro u hu
      rw [Finset.mem_coe] at hu
      rw [Finset.mem_coe, Finset.mem_filter, Finset.mem_product]
      exact ⟨⟨hu, hu⟩, rfl⟩
    · intro p hp
      rw [Finset.mem_coe, Finset.mem_filter] at hp
      exact Prod.ext rfl hp.2
    · intro u _
      rfl
  rw [e]
  refine (Finset.sum_le_sum hp).trans ?_
  rw [Finset.sum_add_distrib, Finset.sum_const, Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero,
    hdiag, Finset.card_product, hμ, smul_eq_mul, smul_eq_mul]
  nlinarith

-- the arithmetic: `t³ + s⁴ ≤ 3(t − 1)²t` with `t ≥ 257` gives `s ≥ −3t/10`
private theorem fourth_moment_arith {t s : ℝ} (ht : 257 ≤ t) (h : t ^ 4 + t * s ^ 4 ≤ 3 * (t - 1) ^ 2 * t ^ 2) :
    -(3 * t / 10) ≤ s := by
  by_contra hlt
  push Not at hlt
  have ht0 : 0 < t := by linarith
  have hc : 0 < 3 * t / 10 := by positivity
  have hs : 3 * t / 10 < -s := by linarith
  have h4 : (3 * t / 10) ^ 4 < (-s) ^ 4 := pow_lt_pow_left₀ hs hc.le (by norm_num)
  have h4' : (-s) ^ 4 = s ^ 4 := by ring
  rw [h4'] at h4
  have h1 : t ^ 3 + s ^ 4 ≤ 3 * (t - 1) ^ 2 * t := by
    have := h
    have e : t ^ 4 + t * s ^ 4 = t * (t ^ 3 + s ^ 4) := by ring
    have e2 : 3 * (t - 1) ^ 2 * t ^ 2 = t * (3 * (t - 1) ^ 2 * t) := by ring
    rw [e, e2] at this
    exact le_of_mul_le_mul_left this ht0
  have h2 : 81 * t ^ 4 < 10000 * (2 * t ^ 3 - 6 * t ^ 2 + 3 * t) := by nlinarith
  have h3 : 81 * t ^ 3 < 10000 * (2 * t ^ 2 - 6 * t + 3) := by
    have e : 81 * t ^ 4 = t * (81 * t ^ 3) := by ring
    have e2 : 10000 * (2 * t ^ 3 - 6 * t ^ 2 + 3 * t) = t * (10000 * (2 * t ^ 2 - 6 * t + 3)) := by ring
    rw [e, e2] at h2
    exact lt_of_mul_lt_mul_left h2 ht0.le
  have h5 : 81 * 257 * t ^ 2 ≤ 81 * t ^ 3 := by
    have : 0 ≤ t ^ 2 := sq_nonneg t
    nlinarith
  nlinarith

/-- **EN1-UQ4** at `Q = 2^f ≥ 256`. -/
theorem charSum_dyadic_large {f : ℕ} (hf : 8 ≤ f) {k : Type} [Field k] [Fintype k] [DecidableEq k]
    (hcard : Fintype.card k = (2 ^ f) ^ 2) (ψ : AddChar k ℂ) (hψ : ψ ≠ 1) :
    -(3 * (((2 ^ f : ℕ) : ℝ) + 1) / 10) ≤
      (∑ u ∈ Finset.univ.filter (fun u : k => u ^ (2 ^ f + 1) = 1), ψ u).re := by
  classical
  set Q := 2 ^ f with hQdef
  -- characteristic 2
  haveI : CharP k 2 := by
    refine CharTwo.of_one_ne_zero_of_two_eq_zero one_ne_zero ?_
    have h := FiniteField.cast_card_eq_zero k
    rw [hcard, hQdef, ← pow_mul] at h
    push_cast at h
    exact pow_eq_zero_iff (by omega) |>.1 h
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  have hfrob : ∀ x y : k, (x + y) ^ Q = x ^ Q + y ^ Q := fun x y => add_pow_char_pow x y 2 f
  have hμ : (mu k Q).card = Q + 1 := HadwigerNelson.StandingFive.card_normOne hcard
  -- the fourth moment, in `ℝ`
  set s : k → ℝ := fun b => (S ψ Q b).re with hsdef
  have hS : ∀ b, S ψ Q b = (s b : ℂ) := fun b => S_eq_ofReal_re ψ Q b
  have hmom : ∑ b : k, s b ^ 4 = (Fintype.card k : ℝ) *
      (((mu k Q ×ˢ mu k Q) ×ˢ (mu k Q ×ˢ mu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card := by
    have h := sum_S_pow_four ψ hψ Q
    simp only [hS] at h
    exact_mod_cast h
  have hN := card_quad_le hfrob hμ
  -- the class of `1`: `s v = s 1` on `μ`, and `s 0 = Q + 1`
  have hs0 : s 0 = Q + 1 := by
    rw [hsdef]
    simp only [S, zero_mul, AddChar.map_zero_eq_one, Finset.sum_const, nsmul_eq_mul, mul_one, Complex.natCast_re]
    rw [hμ]
    push_cast
    ring
  have hsv : ∀ v ∈ mu k Q, s v = s 1 := fun v hv => by
    rw [hsdef]
    simp only
    rw [← S_mul_mem ψ Q hv 1, one_mul]
  have h0 : (0 : k) ∉ mu k Q := by
    rw [Finset.mem_filter]
    rintro ⟨-, h⟩
    rw [zero_pow (Nat.succ_ne_zero Q)] at h
    exact zero_ne_one h
  have hlow : s 0 ^ 4 + (Q + 1 : ℝ) * s 1 ^ 4 ≤ ∑ b : k, s b ^ 4 := by
    have hsub : insert 0 (mu k Q) ⊆ Finset.univ := Finset.subset_univ _
    refine le_trans ?_ (Finset.sum_le_sum_of_subset_of_nonneg hsub fun b _ _ => by positivity)
    rw [Finset.sum_insert h0, Finset.sum_congr rfl fun v hv => by rw [hsv v hv], Finset.sum_const, hμ, nsmul_eq_mul]
    push_cast
    rfl
  -- assemble
  have hQ256 : (256 : ℝ) ≤ Q := by
    have : 2 ^ 8 ≤ 2 ^ f := Nat.pow_le_pow_right (by norm_num) hf
    exact_mod_cast (by simpa [hQdef] using this)
  have hcardR : (Fintype.card k : ℝ) = (Q : ℝ) ^ 2 := by rw [hcard]; push_cast; ring
  have hNR : ((((mu k Q ×ˢ mu k Q) ×ˢ (mu k Q ×ˢ mu k Q)).filter fun z => z.1.1 + z.1.2 + (z.2.1 + z.2.2) = 0).card : ℝ)
      ≤ 3 * ((Q : ℝ) + 1) ^ 2 := by exact_mod_cast hN
  have hkey : ((Q : ℝ) + 1) ^ 4 + ((Q : ℝ) + 1) * s 1 ^ 4 ≤ 3 * (((Q : ℝ) + 1) - 1) ^ 2 * ((Q : ℝ) + 1) ^ 2 := by
    have := hlow.trans hmom.le
    rw [hs0, hcardR] at this
    have hQ0 : (0 : ℝ) ≤ (Q : ℝ) ^ 2 := sq_nonneg _
    have := this.trans (mul_le_mul_of_nonneg_left hNR hQ0)
    nlinarith [this]
  have hfin := fourth_moment_arith (by linarith) hkey
  have htarget : (∑ u ∈ Finset.univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re = s 1 := by
    rw [hsdef]
    simp only [S, one_mul]
  rw [htarget]
  exact hfin

end UQ4Work
