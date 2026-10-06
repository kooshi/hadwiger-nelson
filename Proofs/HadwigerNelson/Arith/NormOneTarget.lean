import Proofs.HadwigerNelson.Arith.StandingFive
import Proofs.HadwigerNelson.Arith.RatioBound
import Mathlib.Algebra.Algebra.ZMod
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.GroupTheory.SpecificGroups.Cyclic

/-!
# The level-one target of a finite field with an involution, read through its character sums (FS-131 wave 10, second pass)

**Read aloud, against the informal claim.** `StandingFive.TargetFloor n Q` asks, of every field `k` of `Q²` elements with a
non-trivial involution `σ`, that `Cay(k, {x : x·σ(x) = 1})` need `n` colours. Both floors the standing five reads — `U₁₂₈`
and the planes `Γ_Q` — go through one reduction, stated here once:

* `involution_eq_pow`: the involution is the `Q`-th power map, `σ x = x ^ Q` (the only automorphism of order two), so the
  connection set is `{u : u ^ (Q + 1) = 1}` and no longer mentions `σ`;
* `card_normOne`: that set has exactly `Q + 1` elements (`kˣ` is cyclic of order `(Q − 1)(Q + 1)`);
* `targetFloor_of_charSum` (proved over the two): if in every field of `Q²` elements every non-trivial additive character
  `ψ` has `Re Σ_{u^(Q+1) = 1} ψ(u) ≥ −m`, and `(N − 1)·m < Q + 1 + m`, then `TargetFloor N Q` — the ratio bound of
  `Arith/RatioBound`.

**Inhabitants.** `k = ℂ` is not finite; the finite model is `GaloisField 3 2` with the cube map (`Q = 3`), which
`StandingFive`'s docstring names. `targetFloor_of_charSum` at `N = 0` is `StandingFive.targetFloor_zero`; the spec example
runs it at `N = 1` from the trivial bound `m = Q + 1`.
-/

namespace HadwigerNelson.StandingFive

open Finset

/-- **A non-trivial involution of a field of `Q²` elements is the `Q`-th power map.** Its fixed field `k₀` has `Q` elements
(`[k : k₀] = 2`, Artin); for `x ∈ k` the polynomial `(T − x)(T − σ x)` has coefficients in `k₀`, which `y ↦ y ^ Q` fixes, so
`x ^ Q ∈ {x, σ x}`, and `x ^ Q = x` only for `x ∈ k₀`, where `σ x = x`. -/
theorem involution_eq_pow {k : Type*} [Field k] [Fintype k] (σ : k →+* k) (hσ : ∀ x, σ (σ x) = x)
    (hne : σ ≠ RingHom.id k) {Q : ℕ} (hcard : Fintype.card k = Q ^ 2) (x : k) : σ x = x ^ Q := by
  -- Route: not the fixed field. `σ` is an algebra endomorphism over the prime field, so it is a power `j < n` of the
  -- Frobenius (`FiniteField.bijective_frobeniusAlgHom_pow`, `n = [k : 𝔽_p]`); `σ² = 1` gives `n ∣ 2j`, `σ ≠ 1` gives
  -- `j ≠ 0`, so `2j = n` and `Q = p ^ j`.
  obtain ⟨p, hp⟩ := CharP.exists k
  haveI : Fact p.Prime := ⟨CharP.char_is_prime k p⟩
  letI : Algebra (ZMod p) k := ZMod.algebra k p
  let σ' : k →ₐ[ZMod p] k :=
    { σ with commutes' := fun r => RingHom.congr_fun (Subsingleton.elim (σ.comp (algebraMap (ZMod p) k)) _) r }
  have hσ' : ∀ y, σ' y = σ y := fun _ => rfl
  obtain ⟨⟨j, hj⟩, hσj⟩ := (FiniteField.bijective_frobeniusAlgHom_pow (ZMod p) k).2 σ'
  have hfrob : ∀ (i : ℕ) (y : k), (FiniteField.frobeniusAlgHom (ZMod p) k ^ i) y = y ^ p ^ i := by
    intro i y
    rw [AlgHom.coe_pow, FiniteField.coe_frobeniusAlgHom, pow_iterate, ZMod.card]
  have hcardn : Fintype.card k = p ^ Module.finrank (ZMod p) k := by
    rw [Module.card_eq_pow_finrank (K := ZMod p), ZMod.card]
  have hσx : ∀ y, σ y = y ^ p ^ j := by
    intro y
    rw [← hσ' y, ← hσj]
    exact hfrob j y
  have h2 : FiniteField.frobeniusAlgHom (ZMod p) k ^ (2 * j) = 1 := by
    ext y
    rw [hfrob, AlgHom.one_apply, two_mul, pow_add, pow_mul, ← hσx, ← hσx]
    exact hσ y
  have hdvd : Module.finrank (ZMod p) k ∣ 2 * j := by
    rw [← FiniteField.orderOf_frobeniusAlgHom]
    exact orderOf_dvd_of_pow_eq_one h2
  have hj0 : j ≠ 0 := by
    rintro rfl
    apply hne
    ext y
    simpa using hσx y
  -- `0 < 2j < 2n` and `n ∣ 2j`, so `2j = n`
  have h2j : 2 * j = Module.finrank (ZMod p) k := by
    obtain ⟨c, hc⟩ := hdvd
    rcases c with _ | _ | c
    · omega
    · omega
    · nlinarith
  have hQ : Q = p ^ j := by
    have h : Q ^ 2 = (p ^ j) ^ 2 := by rw [← hcard, hcardn, ← h2j, ← pow_mul']
    exact Nat.pow_left_injective (by norm_num) h
  rw [hQ]
  exact hσx x

/-- **Roots of unity in a finite field**: `u ^ d = 1` has exactly `d` solutions when `d ∣ |k| − 1`, `d ≠ 0` (`kˣ` is
cyclic). Read at `d = Q + 1` (`card_normOne`) and at `d = Q − 1` (the fixed field of the `Q`-th power map, `FloorPlanes`). -/
theorem card_filter_pow_eq_one {k : Type*} [Field k] [Fintype k] [DecidableEq k] {d : ℕ} (hd0 : d ≠ 0)
    (hd : d ∣ Fintype.card k - 1) : (univ.filter fun u : k => u ^ d = 1).card = d := by
  have hker : Nat.card (powMonoidHom d : kˣ →* kˣ).ker = d := by
    rw [IsCyclic.card_powMonoidHom_ker, Nat.card_units, Nat.card_eq_fintype_card]
    exact Nat.gcd_eq_right hd
  let e : {u : k // u ^ d = 1} ≃ (powMonoidHom d : kˣ →* kˣ).ker :=
    { toFun := fun u => ⟨Units.mk0 u.1 (by
          rintro h
          have h1 := u.2
          rw [h, zero_pow hd0] at h1
          exact zero_ne_one h1), by
          rw [MonoidHom.mem_ker, powMonoidHom_apply]
          ext
          simpa using u.2⟩
      invFun := fun x => ⟨(x.1 : k), by
          have h1 := x.2
          rw [MonoidHom.mem_ker, powMonoidHom_apply] at h1
          rw [← Units.val_pow_eq_pow_val, h1, Units.val_one]⟩
      left_inv := fun u => by simp
      right_inv := fun x => by ext; simp }
  rw [← Fintype.card_subtype, ← Nat.card_eq_fintype_card, Nat.card_congr e, hker]

/-- **The norm-one set has `Q + 1` elements**: the solutions of `u ^ (Q + 1) = 1` in a field of `Q²` elements. -/
theorem card_normOne {k : Type*} [Field k] [Fintype k] [DecidableEq k] {Q : ℕ} (hcard : Fintype.card k = Q ^ 2) :
    (univ.filter fun u : k => u ^ (Q + 1) = 1).card = Q + 1 := by
  refine card_filter_pow_eq_one (Nat.succ_ne_zero Q) ?_
  rw [hcard]
  refine ⟨Q - 1, ?_⟩
  rcases Q with _ | n
  · rfl
  · exact Nat.sub_eq_of_eq_add (by simp only [Nat.add_sub_cancel]; ring)

/-- **The floor of a residue size from its character sums** (the ratio bound at the level-one target): if every
non-trivial additive character of every field of `Q²` elements sums to real part at least `−m` over the norm-one set, and
`(N − 1)·m < Q + 1 + m`, then every level-one target at `Q` needs at least `N` colours. -/
theorem targetFloor_of_charSum (N Q : ℕ) {m : ℝ} (hm : 0 < m) (hN : ((N : ℝ) - 1) * m < (Q : ℝ) + 1 + m)
    (hchar : ∀ (k : Type) [Field k] [Fintype k] [DecidableEq k], Fintype.card k = Q ^ 2 →
      ∀ ψ : AddChar k ℂ, ψ ≠ 1 → -m ≤ (∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re) :
    TargetFloor N Q := by
  intro k _ _ σ hσ hne hcard
  letI : Fintype k := Fintype.ofFinite k
  letI : DecidableEq k := Classical.decEq k
  have hcard' : Fintype.card k = Q ^ 2 := by rw [← Nat.card_eq_fintype_card]; exact hcard
  have hpow := involution_eq_pow σ hσ hne hcard'
  have h0 : (0 : k) ∉ univ.filter (fun u : k => u ^ (Q + 1) = 1) := by
    simp
  have hH : ∀ x y : k, x ≠ y → x - y ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1) → (normOneCayley k σ).Adj x y := by
    intro x y hxy hS
    rw [normOneCayley, SimpleGraph.fromRel_adj]
    refine ⟨hxy, Or.inl ?_⟩
    have h := (mem_filter.mp hS).2
    rw [hpow, ← pow_succ']
    exact h
  refine RatioBound.le_chromaticNumber_of_charSum _ h0 _ hH hm (hchar k hcard') N ?_
  rw [card_normOne hcard']
  push_cast
  exact hN

/-! ## Spec -/

-- `targetFloor_of_charSum` at the trivial bound: `|Σ ψ(u)| ≤ Q + 1` always, and with `m = Q + 1` it yields one colour.
example (Q : ℕ) (hchar : ∀ (k : Type) [Field k] [Fintype k] [DecidableEq k], Fintype.card k = Q ^ 2 →
      ∀ ψ : AddChar k ℂ, ψ ≠ 1 → -((Q : ℝ) + 1) ≤ (∑ u ∈ univ.filter (fun u : k => u ^ (Q + 1) = 1), ψ u).re) :
    TargetFloor 1 Q :=
  targetFloor_of_charSum 1 Q (by positivity) (by push_cast; nlinarith [Nat.cast_nonneg (α := ℝ) Q]) hchar

-- `card_filter_pow_eq_one` at the smallest field with a non-trivial root of unity: `u² = 1` has two solutions in `ZMod 3`
-- (it would fail if the count were `d − 1` or `gcd`-free: `u² = 1` has one solution where `2 ∤ |k| − 1`).
example : (univ.filter fun u : ZMod 3 => u ^ 2 = 1).card = 2 :=
  card_filter_pow_eq_one two_ne_zero (by rw [ZMod.card])

-- `card_normOne` and `involution_eq_pow` need a field of `Q²` elements with a non-trivial involution: `ZMod 3` has `3 = Q²`
-- for no `Q`, and the model is `GaloisField 3 2` with the cube map (the module docstring). Both theorems are consumed
-- above by `targetFloor_of_charSum`, whose hypotheses are theirs.

end HadwigerNelson.StandingFive
