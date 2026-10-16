import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Mathlib.NumberTheory.LSeries.PrimesInAP

namespace HadwigerNelson.PadicPlane

/-- The cosine sums over the circle of `(ℤ/p)²` bound the character sums. -/
private theorem charSum_unitCircle_ge_of_circleCos (Q : ℕ) [Fact Q.Prime] {κ : ℝ}
    (hcos : ∀ α β : ℕ, α < Q → β < Q → (α ≠ 0 ∨ β ≠ 0) →
      -(κ * ((Q : ℝ) + 1)) ≤ ∑ v ∈ Finset.univ.filter (fun v : ZMod Q × ZMod Q => v.1 ^ 2 + v.2 ^ 2 = 1),
        Real.cos (2 * Real.pi * (((α * v.1.val + β * v.2.val) % Q : ℕ) : ℝ) / Q))
    (ψ : AddChar (ZMod Q × ZMod Q) ℂ) (hψ : ψ ≠ 1) :
    -(κ * ((Q : ℝ) + 1)) ≤ (∑ s ∈ FibreCertSound.unitCircle Q, ψ s).re := by
  have hp : Q.Prime := Fact.out
  have hpow : ∀ v : ZMod Q × ZMod Q, ψ v ^ Q = 1 := fun v => by
    have h0 : Q • v = 0 := by ext <;> simp
    rw [← AddChar.map_nsmul_eq_pow, h0, AddChar.map_zero_eq_one]
  have hζ := Complex.isPrimitiveRoot_exp Q hp.ne_zero
  obtain ⟨α, hα, hαz⟩ := hζ.eq_pow_of_pow_eq_one (hpow (1, 0))
  obtain ⟨β, hβ, hβz⟩ := hζ.eq_pow_of_pow_eq_one (hpow (0, 1))
  set ζ := Complex.exp (2 * Real.pi * Complex.I / Q) with hζdef
  have hdec : ∀ v : ZMod Q × ZMod Q, v.1.val • ((1 : ZMod Q), (0 : ZMod Q)) + v.2.val • ((0 : ZMod Q), (1 : ZMod Q)) = v := by
    intro v
    ext <;> simp
  have hψx : ∀ v, ψ v = ζ ^ ((α * v.1.val + β * v.2.val) % Q) := by
    intro v
    have e2 : ζ ^ ((α * v.1.val + β * v.2.val) % Q) = ζ ^ (α * v.1.val + β * v.2.val) := by
      conv_rhs => rw [← Nat.div_add_mod (α * v.1.val + β * v.2.val) Q]
      rw [pow_add, pow_mul, hζ.pow_eq_one, one_pow, one_mul]
    rw [e2, pow_add, pow_mul, pow_mul, hαz, hβz, ← AddChar.map_nsmul_eq_pow, ← AddChar.map_nsmul_eq_pow,
      ← AddChar.map_add_eq_mul, hdec v]
  have hαβ : α ≠ 0 ∨ β ≠ 0 := by
    by_contra h
    push Not at h
    apply hψ
    refine DFunLike.ext _ _ fun v => ?_
    rw [hψx, h.1, h.2, zero_mul, zero_mul, add_zero, Nat.zero_mod, pow_zero, AddChar.one_apply]
  have hre : ∀ m : ℕ, (ζ ^ m).re = Real.cos (2 * Real.pi * (m : ℝ) / Q) := by
    intro m
    rw [hζdef, ← Complex.exp_nat_mul]
    have : (m : ℂ) * (2 * Real.pi * Complex.I / Q) = ((2 * Real.pi * (m : ℝ) / Q : ℝ) : ℂ) * Complex.I := by
      push_cast; ring
    rw [this, Complex.exp_ofReal_mul_I_re]
  have hsum : (∑ s ∈ FibreCertSound.unitCircle Q, ψ s).re = ∑ v ∈ Finset.univ.filter
      (fun v : ZMod Q × ZMod Q => v.1 ^ 2 + v.2 ^ 2 = 1),
      Real.cos (2 * Real.pi * (((α * v.1.val + β * v.2.val) % Q : ℕ) : ℝ) / Q) := by
    rw [Complex.re_sum]
    exact Finset.sum_congr rfl fun v _ => by rw [hψx, hre]
  rw [hsum]
  exact hcos α β hα hβ hαβ

local instance factPrimeTwentyThree' : Fact (Nat.Prime 23) := ⟨by norm_num⟩

example (bound : ∀ {κ : ℝ}, 2 ≤ κ →
    (∀ ψ : AddChar (ZMod 23 × ZMod 23) ℂ, ψ ≠ 1 → -κ ≤ (∑ s ∈ FibreCertSound.unitCircle 23, ψ s).re) →
    ((⌈1 + (((23 : ℕ) : ℝ) + 1) / κ⌉₊ : ℕ) : ℕ∞) ≤ (7 : ℕ∞)) : (5 : ℕ∞) ≤ 7 := by
  obtain ⟨κ, hκ3, hκQ, hcos⟩ := CircleCos.circleCos_ge (Q := 23) (Or.inl rfl)
  have hch := charSum_unitCircle_ge_of_circleCos 23 hcos
  have h24 : ((23 : ℕ) : ℝ) + 1 = 24 := by norm_num
  rw [h24] at hκQ hch
  have hκ0 : 0 < κ := lt_of_lt_of_le (by norm_num) hκQ
  have hκ2 : 2 ≤ κ * 24 := by
    have := (div_le_iff₀ (by norm_num : (0 : ℝ) < 24)).1 hκQ
    linarith
  refine le_trans ?_ (bound hκ2 hch)
  have hx : ((4 : ℕ) : ℝ) < 1 + (((23 : ℕ) : ℝ) + 1) / (κ * 24) := by
    rw [h24, mul_comm, ← div_div, div_self (by norm_num : (24 : ℝ) ≠ 0)]
    have : (3 : ℝ) < 1 / κ := by rw [lt_div_iff₀ hκ0]; linarith
    push_cast
    linarith
  exact_mod_cast Nat.lt_ceil.2 hx

end HadwigerNelson.PadicPlane
