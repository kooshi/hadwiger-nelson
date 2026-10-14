import Proofs.HadwigerNelson.Rigidity.PositiveEntropy

namespace HadwigerNelson.Rigidity

open MeasureTheory

namespace ZdAction

/-- `2^m = 3^n` or `2^m · 3^n = 1` in `ℕ` only at `m = n = 0`: `2^m` is even unless `m = 0`, `3^n` is odd. -/
private theorem two_pow_three_pow_nat {m n : ℕ} (h : 2 ^ m = 3 ^ n ∨ 2 ^ m * 3 ^ n = 1) : m = 0 ∧ n = 0 := by
  have h3 : ∀ k : ℕ, 3 ^ k = 1 → k = 0 := fun k hk =>
    Nat.pow_right_injective (le_refl 2) (show 2 ^ k = 2 ^ 0 from by
      have := Nat.pow_right_injective (by norm_num : 2 ≤ 3) (show 3 ^ k = 3 ^ 0 by rw [hk, pow_zero])
      rw [this])
  have h2 : ∀ k : ℕ, 2 ^ k = 1 → k = 0 := fun k hk =>
    Nat.pow_right_injective (le_refl 2) (show 2 ^ k = 2 ^ 0 by rw [hk, pow_zero])
  rcases h with h | h
  · have hm : m = 0 := by
      by_contra hm
      have he : Even (2 ^ m) := (Nat.even_pow' hm).2 even_two
      rw [h] at he
      exact (Nat.not_even_iff_odd.2 (Odd.pow (by decide : Odd 3))) he
    subst hm
    exact ⟨rfl, h3 n (by rw [← h, pow_zero])⟩
  · exact ⟨h2 m (Nat.eq_one_of_mul_eq_one_right h), h3 n (Nat.eq_one_of_mul_eq_one_left h)⟩

/-- **Unique factorisation at `2` and `3`**: `2^x = 3^y` in `ℝ` with `x y : ℤ` only at `x = y = 0`. -/
private theorem two_zpow_eq_three_zpow {x y : ℤ} (h : (2 : ℝ) ^ x = (3 : ℝ) ^ y) : x = 0 ∧ y = 0 := by
  obtain ⟨m, hm | hm⟩ := Int.eq_nat_or_neg x <;> obtain ⟨n, hn | hn⟩ := Int.eq_nat_or_neg y <;> subst hm hn <;>
    simp only [zpow_neg, zpow_natCast] at h
  · have := two_pow_three_pow_nat (m := m) (n := n) (Or.inl (by exact_mod_cast h))
    omega
  · have h' : (2 : ℝ) ^ m * 3 ^ n = 1 := by rw [h, inv_mul_cancel₀ (pow_ne_zero _ three_ne_zero)]
    have := two_pow_three_pow_nat (m := m) (n := n) (Or.inr (by exact_mod_cast h'))
    omega
  · have h' : (2 : ℝ) ^ m * 3 ^ n = 1 := by
      rw [← h, mul_inv_cancel₀ (pow_ne_zero _ two_ne_zero)]
    have := two_pow_three_pow_nat (m := m) (n := n) (Or.inr (by exact_mod_cast h'))
    omega
  · have h' : (2 : ℝ) ^ m = 3 ^ n := inv_inj.mp h
    have := two_pow_three_pow_nat (m := m) (n := n) (Or.inl (by exact_mod_cast h'))
    omega

/-- **Unique factorisation at `2` and `3`**: `2^a 3^b = 2^c 3^d` in `ℝ` forces `a = c` and `b = d`. -/
private theorem two_three_zpow_inj {a b c e : ℤ} (h : (2 : ℝ) ^ a * (3 : ℝ) ^ b = (2 : ℝ) ^ c * (3 : ℝ) ^ e) :
    a = c ∧ b = e := by
  have h' : (2 : ℝ) ^ (a - c) = (3 : ℝ) ^ (e - b) := by
    rw [zpow_sub₀ two_ne_zero, zpow_sub₀ three_ne_zero,
      div_eq_div_iff (zpow_ne_zero _ two_ne_zero) (zpow_ne_zero _ three_ne_zero)]
    linear_combination h
  have := two_zpow_eq_three_zpow h'
  omega

private theorem mulTwoThree_apply (n : Fin 2 → ℤ) (x : ℝ) :
    mulTwoThree n x = (2 : ℝ) ^ n 0 * (3 : ℝ) ^ n 1 * x := rfl

theorem mulTwoThree_model' : mulTwoThree.IsIrreducible ∧ ¬ mulTwoThree.IsVirtuallyCyclic := by
  refine ⟨fun Y _hY hinv => ?_, fun ⟨n, Λ, hΛ, hm⟩ => ?_⟩
  · -- a closed subgroup of `ℝ` is dense, hence everything, or cyclic; a nonzero cyclic one is not doubled onto itself
    rcases Y.dense_or_cyclic with hd | ⟨a, ha⟩
    · exact Or.inr (SetLike.coe_injective (by rw [AddSubgroup.coe_top, ← _hY.closure_eq, hd.closure_eq]))
    · by_cases ha0 : a = 0
      · left
        subst ha0
        rw [ha, AddSubgroup.closure_singleton_zero, AddSubgroup.coe_bot]
        exact Set.finite_singleton 0
      · exfalso
        have haY : a ∈ Y := ha ▸ AddSubgroup.subset_closure rfl
        have hmap := hinv ![1, 0] (AddSubgroup.mem_top _)
        rw [← hmap] at haY
        obtain ⟨y, hy, hya⟩ := AddSubgroup.mem_map.mp haY
        rw [ha, AddSubgroup.mem_closure_singleton] at hy
        obtain ⟨k, rfl⟩ := hy
        rw [mulTwoThree_apply] at hya
        simp only [Matrix.cons_val_zero, Matrix.cons_val_one, zpow_one, zpow_zero, mul_one, zsmul_eq_mul] at hya
        have h2k : ((2 * k - 1 : ℤ) : ℝ) * a = 0 := by push_cast; linarith
        have hk : (2 * k - 1 : ℤ) = 0 := by
          have := (mul_eq_zero.mp h2k).resolve_right ha0
          exact_mod_cast this
        omega
  · -- `(N, 0)` and `(0, N)` lie in `Λ` (`N` its index); each a multiple of one `n` forces `N = 0`
    have hN : Λ.index ≠ 0 := hΛ.index_ne_zero
    obtain ⟨k₁, hk₁⟩ := hm (Λ.index • ![1, 0]) (Λ.nsmul_index_mem _)
    obtain ⟨k₂, hk₂⟩ := hm (Λ.index • ![0, 1]) (Λ.nsmul_index_mem _)
    have e₁ := congrArg (fun f => f (1 : ℝ)) hk₁
    have e₂ := congrArg (fun f => f (1 : ℝ)) hk₂
    have v : ∀ (N : ℕ) (i j : ℤ), (N • ![i, j] : Fin 2 → ℤ) 0 = N * i ∧ (N • ![i, j] : Fin 2 → ℤ) 1 = N * j :=
      fun N i j => by simp
    have w : ∀ (k : ℤ) (i : Fin 2), (k • n) i = k * n i := fun k i => by simp
    simp only [mulTwoThree_apply, mul_one] at e₁ e₂
    rw [(v _ 1 0).1, (v _ 1 0).2, w, w] at e₁
    rw [(v _ 0 1).1, (v _ 0 1).2, w, w] at e₂
    obtain ⟨a₁, b₁⟩ := two_three_zpow_inj e₁
    obtain ⟨a₂, b₂⟩ := two_three_zpow_inj e₂
    have hNz : (Λ.index : ℤ) ≠ 0 := by exact_mod_cast hN
    rw [mul_one] at a₁ b₂
    rw [mul_zero] at b₁ a₂
    have hk₁ : k₁ ≠ 0 := fun h => hNz (by rw [a₁, h, zero_mul])
    have hn₁ : n 1 = 0 := (mul_eq_zero.mp b₁.symm).resolve_left hk₁
    exact hNz (by rw [b₂, hn₁, mul_zero])

end ZdAction

end HadwigerNelson.Rigidity
