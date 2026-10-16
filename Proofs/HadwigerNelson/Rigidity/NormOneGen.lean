import Mathlib.Algebra.Ring.Subring.Basic
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Algebra.GroupWithZero.Units.Fintype
import Mathlib.FieldTheory.Finite.GaloisField

/-!
# The norm-one elements generate a finite ring with an involution (FS-131; planned by FS131-KRU1, proved by FS131-IRU1)

Plan: `plans/FS131-KRU1-ring-plan.md` § 3 (module 1).

**Read aloud.** `A` is a finite commutative ring, `σ` a ring endomorphism of `A` with `σ ∘ σ = id`, and `θ ∈ A` an element
that `σ` moves by a unit (`θ − σθ` a unit) and that stays a unit after adding any `σ`-fixed element. Then the elements of norm
one, `{x : x·σx = 1}`, generate `A` as a ring (`closure_normOne_eq_top`).

**Route (no counting, uniform in the level).** The *Cayley elements* `t_a = (a + θ)/(a + σθ)`, `a` fixed by `σ`, have norm
one. `t_a − 1 = (θ − σθ)/(a + σθ)` is a unit, and a subring of a finite ring holds the inverse of each unit it holds
(`inv_mem_of_finite`), so `(a + σθ)/(θ − σθ)` lies in the ring the norm-one elements generate; at `a = 0` and `a = 1` and by
difference, every fixed `a` and `θ` lie in it; and every `x` is `α + βθ` with `α, β` fixed (`exists_fixed_add_mul`), since
`θ − σθ` is a unit.

**Use.** At an unramified stable prime `P`, `A = 𝓞 L ⧸ P^m` (and any finite product of such rings), `σ` conjugation, `θ` the
residue of an integer `t` with `t̄ − t ∉ P` (`Rigidity/UnitRingEq`).

**Not claimed:** anything without finiteness (only `inv_mem_of_finite` reads it), or without the unit `θ − σθ` (at a ramified
stable prime the norm-one residues at level one are `{1}`, which generates only the prime field).

**Models.** The hypotheses are inhabited by the field of nine elements with `x ↦ x³` (`exists_model_galoisField`), and, in
the use, by the residue rings of `ℚ(i)` at `3` (`Instances/UnitRingModels`).
-/

namespace HadwigerNelson.Rigidity

variable {A : Type*} [CommRing A]

/-- **A subring of a finite ring holds the inverse of each unit it holds**: `u⁻¹ = u^(|Aˣ| − 1)`. -/
theorem inv_mem_of_finite [Finite A] (T : Subring A) (u : Aˣ) (hu : (u : A) ∈ T) : ((u⁻¹ : Aˣ) : A) ∈ T := by
  have hpos : 0 < orderOf u := orderOf_pos u
  have hinv : u⁻¹ = u ^ (orderOf u - 1) := by
    refine inv_eq_of_mul_eq_one_right ?_
    rw [← pow_succ', Nat.sub_add_cancel hpos, pow_orderOf_eq_one]
  rw [hinv, Units.val_pow_eq_pow_val]
  exact T.pow_mem hu _

/-- **Coordinates over the fixed ring**: when `θ − σθ` is a unit, every `x` is `α + βθ` with `α`, `β` fixed by the
involution `σ` (`β = (x − σx)/(θ − σθ)`, `α = x − βθ`). -/
theorem exists_fixed_add_mul (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ : A} (hθ : IsUnit (θ - σ θ)) (x : A) :
    ∃ α β : A, σ α = α ∧ σ β = β ∧ x = α + β * θ := by
  obtain ⟨δ, hδ⟩ := hθ
  have hde : (δ : A) * ↑δ⁻¹ = 1 := δ.mul_inv
  have hσd : σ (δ : A) = -(δ : A) := by rw [hδ, map_sub, hσ]; ring
  have hσe : σ (↑δ⁻¹ : A) = -↑δ⁻¹ := by
    have h1 : σ (δ : A) * σ ↑δ⁻¹ = 1 := by rw [← map_mul, hde, map_one]
    rw [hσd] at h1
    linear_combination (-(↑δ⁻¹ : A)) * h1 - σ ↑δ⁻¹ * hde
  refine ⟨x - (x - σ x) * ↑δ⁻¹ * θ, (x - σ x) * ↑δ⁻¹, ?_, ?_, by ring⟩
  · rw [map_sub, map_mul, map_mul, map_sub, hσ, hσe]
    linear_combination (x - σ x) * hde - (x - σ x) * ↑δ⁻¹ * hδ
  · rw [map_mul, map_sub, hσ, hσe]
    ring

/-- **The Cayley element has norm one**: for `a` fixed by `σ` and `v` a unit with `v = a + σθ`, the element
`t = (a + θ)·v⁻¹` has `t·σt = 1` (`σv = a + θ`, so `σt = (a + σθ)·(σv)⁻¹` and the product telescopes). -/
theorem cayley_mul_conj_eq_one (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ a : A} (ha : σ a = a) (v : Aˣ)
    (hv : (v : A) = a + σ θ) : (a + θ) * ↑v⁻¹ * σ ((a + θ) * ↑v⁻¹) = 1 := by
  have h1 : σ ↑v * σ ↑v⁻¹ = 1 := by rw [← map_mul, Units.mul_inv, map_one]
  have h2 : σ ↑v = a + θ := by rw [hv, map_add, ha, hσ]
  have h3 : (v : A) * ↑v⁻¹ = 1 := v.mul_inv
  rw [map_mul, map_add, ha]
  linear_combination (-((a + θ) * ↑v⁻¹ * σ ↑v⁻¹)) * hv + (a + θ) * σ ↑v⁻¹ * h3 + h1 - σ ↑v⁻¹ * h2

/-- The quotient of a Cayley element's denominator by `θ − σθ` lies in the ring the norm-one elements generate: for `b`
fixed, `t_b − 1 = (θ − σθ)·(b + σθ)⁻¹` is a unit of that ring, and its inverse is `(b + σθ)·(θ − σθ)⁻¹`. -/
private theorem add_conj_mul_inv_mem [Finite A] (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ : A} (δ : Aˣ)
    (hδ : (δ : A) = θ - σ θ) (hfix : ∀ a, σ a = a → IsUnit (a + θ)) {b : A} (hb : σ b = b) :
    (b + σ θ) * ↑δ⁻¹ ∈ Subring.closure {x : A | x * σ x = 1} := by
  set T := Subring.closure {x : A | x * σ x = 1}
  obtain ⟨v, hv⟩ : IsUnit (b + σ θ) := by
    have h := (hfix b hb).map σ
    rwa [map_add, hb] at h
  have ht : (b + θ) * ↑v⁻¹ ∈ T :=
    Subring.subset_closure (cayley_mul_conj_eq_one σ hσ hb v hv)
  have hu : ((δ * v⁻¹ : Aˣ) : A) ∈ T := by
    have h : ((δ * v⁻¹ : Aˣ) : A) = (b + θ) * ↑v⁻¹ - 1 := by
      have h3 : (v : A) * ↑v⁻¹ = 1 := v.mul_inv
      rw [Units.val_mul]
      linear_combination (↑v⁻¹ : A) * hδ + (↑v⁻¹ : A) * hv - h3
    rw [h]
    exact T.sub_mem ht T.one_mem
  have h := inv_mem_of_finite T _ hu
  rwa [mul_inv_rev, inv_inv, Units.val_mul, hv] at h

/-- `θ − σθ` lies in the ring the norm-one elements generate (`add_conj_mul_inv_mem` at `b = 0` and `b = 1`, by
difference, and `inv_mem_of_finite`). -/
private theorem unit_mem_closure_normOne [Finite A] (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ : A} (δ : Aˣ)
    (hδ : (δ : A) = θ - σ θ) (hfix : ∀ a, σ a = a → IsUnit (a + θ)) :
    (↑δ⁻¹ : A) ∈ Subring.closure {x : A | x * σ x = 1} ∧ (δ : A) ∈ Subring.closure {x : A | x * σ x = 1} := by
  set T := Subring.closure {x : A | x * σ x = 1}
  have h0 := add_conj_mul_inv_mem σ hσ δ hδ hfix (map_zero σ)
  have h1 := add_conj_mul_inv_mem σ hσ δ hδ hfix (map_one σ)
  have he : (↑δ⁻¹ : A) ∈ T := by
    have h := T.sub_mem h1 h0
    rwa [show (1 + σ θ) * (↑δ⁻¹ : A) - (0 + σ θ) * ↑δ⁻¹ = ↑δ⁻¹ by ring] at h
  refine ⟨he, ?_⟩
  have h := inv_mem_of_finite T δ⁻¹ he
  rwa [inv_inv] at h

/-- **The fixed elements lie in the ring the norm-one elements generate** (the heart of `closure_normOne_eq_top`): for `a`
fixed, `t_a − 1 = (θ − σθ)/(a + σθ)` with `t_a` the Cayley element, so `(a + σθ)/(θ − σθ)` lies in it
(`inv_mem_of_finite`); subtract the case `a = 0`, and use `a = 1` and `inv_mem_of_finite` again for `θ − σθ` itself. -/
theorem mem_closure_normOne_of_fixed [Finite A] (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ : A}
    (hθ : IsUnit (θ - σ θ)) (hfix : ∀ a, σ a = a → IsUnit (a + θ)) {a : A} (ha : σ a = a) :
    a ∈ Subring.closure {x : A | x * σ x = 1} := by
  obtain ⟨δ, hδ⟩ := hθ
  set T := Subring.closure {x : A | x * σ x = 1}
  obtain ⟨-, hd⟩ := unit_mem_closure_normOne σ hσ δ hδ hfix
  have ha' := T.sub_mem (add_conj_mul_inv_mem σ hσ δ hδ hfix ha)
    (add_conj_mul_inv_mem σ hσ δ hδ hfix (map_zero σ))
  have h := T.mul_mem ha' hd
  have hde : (δ : A) * ↑δ⁻¹ = 1 := δ.mul_inv
  rwa [show ((a + σ θ) * ↑δ⁻¹ - (0 + σ θ) * ↑δ⁻¹) * (δ : A) = a by linear_combination a * hde] at h

/-- **The norm-one elements generate a finite ring with an involution** that moves some `θ` by a unit, `θ` staying a unit
after adding any fixed element. -/
theorem closure_normOne_eq_top [Finite A] (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ : A} (hθ : IsUnit (θ - σ θ))
    (hfix : ∀ a, σ a = a → IsUnit (a + θ)) : Subring.closure {x : A | x * σ x = 1} = ⊤ := by
  refine eq_top_iff.2 fun x _ => ?_
  obtain ⟨α, β, hα, hβ, rfl⟩ := exists_fixed_add_mul σ hσ hθ x
  obtain ⟨δ, hδ⟩ := hθ
  set T := Subring.closure {x : A | x * σ x = 1}
  obtain ⟨-, hd⟩ := unit_mem_closure_normOne σ hσ δ hδ hfix
  have h0 := add_conj_mul_inv_mem σ hσ δ hδ hfix (map_zero σ)
  have hθT : θ ∈ T := by
    have h := T.add_mem (T.mul_mem h0 hd) hd
    have hde : (δ : A) * ↑δ⁻¹ = 1 := δ.mul_inv
    rwa [show (0 + σ θ) * ↑δ⁻¹ * (δ : A) + δ = θ by linear_combination σ θ * hde + hδ] at h
  exact T.add_mem (mem_closure_normOne_of_fixed σ hσ ⟨δ, hδ⟩ hfix hα)
    (T.mul_mem (mem_closure_normOne_of_fixed σ hσ ⟨δ, hδ⟩ hfix hβ) hθT)

/-- **A model of the hypotheses of `closure_normOne_eq_top`, every clause exercised**: the field of nine elements with
`σ = x ↦ x³` (an involution: `x⁹ = x`), and any `θ` outside the prime field (`θ³ ≠ θ`): `θ − θ³` is a nonzero element of a
field, and `a + θ ≠ 0` for each of the three fixed `a`. -/
theorem exists_model_galoisField :
    (∀ x : GaloisField 3 2, frobenius (GaloisField 3 2) 3 (frobenius (GaloisField 3 2) 3 x) = x) ∧
      ∃ θ : GaloisField 3 2, IsUnit (θ - frobenius (GaloisField 3 2) 3 θ) ∧
        ∀ a : GaloisField 3 2, frobenius (GaloisField 3 2) 3 a = a → IsUnit (a + θ) := by
  classical
  letI : Fintype (GaloisField 3 2) := Fintype.ofFinite _
  have hcard : Fintype.card (GaloisField 3 2) = 9 := by
    rw [← Nat.card_eq_fintype_card, GaloisField.card 3 2 (by norm_num)]
    norm_num
  have hfr : ∀ x : GaloisField 3 2, frobenius (GaloisField 3 2) 3 x = x ^ 3 := fun x => frobenius_def 3 x
  have h9 : ∀ x : GaloisField 3 2, (x ^ 3) ^ 3 = x := by
    intro x
    have h := FiniteField.pow_card x
    rwa [hcard, show 9 = 3 * 3 by rfl, pow_mul] at h
  obtain ⟨θ, hθ⟩ : ∃ θ : GaloisField 3 2, θ ^ 3 ≠ θ := by
    by_contra h
    push Not at h
    have hne : (Polynomial.X ^ 3 - Polynomial.X : Polynomial (GaloisField 3 2)) ≠ 0 :=
      FiniteField.X_pow_card_sub_X_ne_zero _ (by norm_num)
    have hroots : (Finset.univ : Finset (GaloisField 3 2)).val ⊆
        (Polynomial.X ^ 3 - Polynomial.X : Polynomial (GaloisField 3 2)).roots := by
      intro x _
      rw [Polynomial.mem_roots hne, Polynomial.IsRoot, Polynomial.eval_sub, Polynomial.eval_pow, Polynomial.eval_X,
        h x, sub_self]
    have hle := Polynomial.card_le_degree_of_subset_roots hroots
    rw [FiniteField.X_pow_card_sub_X_natDegree_eq _ (by norm_num), Finset.card_univ, hcard] at hle
    omega
  refine ⟨fun x => by rw [hfr, hfr, h9], θ, ?_, fun a ha => ?_⟩
  · rw [hfr]
    exact isUnit_iff_ne_zero.mpr (sub_ne_zero.mpr (Ne.symm hθ))
  · rw [hfr] at ha
    refine isUnit_iff_ne_zero.mpr fun h0 => hθ ?_
    have hθa : θ = -a := by linear_combination h0
    rw [hθa, neg_pow, ha]
    norm_num

end HadwigerNelson.Rigidity
