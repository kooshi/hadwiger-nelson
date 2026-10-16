import Mathlib.Algebra.Ring.Subring.Basic
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Algebra.GroupWithZero.Units.Fintype
import Mathlib.FieldTheory.Finite.GaloisField

/-!
# The norm-one elements generate a finite ring with an involution (FS-131, job FS131-KRU1; skeleton)

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
  sorry

/-- **Coordinates over the fixed ring**: when `θ − σθ` is a unit, every `x` is `α + βθ` with `α`, `β` fixed by the
involution `σ` (`β = (x − σx)/(θ − σθ)`, `α = x − βθ`). -/
theorem exists_fixed_add_mul (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ : A} (hθ : IsUnit (θ - σ θ)) (x : A) :
    ∃ α β : A, σ α = α ∧ σ β = β ∧ x = α + β * θ := by
  sorry

/-- **The Cayley element has norm one**: for `a` fixed by `σ` and `v` a unit with `v = a + σθ`, the element
`t = (a + θ)·v⁻¹` has `t·σt = 1` (`σv = a + θ`, so `σt = (a + σθ)·(σv)⁻¹` and the product telescopes). -/
theorem cayley_mul_conj_eq_one (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ a : A} (ha : σ a = a) (v : Aˣ)
    (hv : (v : A) = a + σ θ) : (a + θ) * ↑v⁻¹ * σ ((a + θ) * ↑v⁻¹) = 1 := by
  sorry

/-- **The norm-one elements generate a finite ring with an involution** that moves some `θ` by a unit, `θ` staying a unit
after adding any fixed element. -/
theorem closure_normOne_eq_top [Finite A] (σ : A →+* A) (hσ : ∀ x, σ (σ x) = x) {θ : A} (hθ : IsUnit (θ - σ θ))
    (hfix : ∀ a, σ a = a → IsUnit (a + θ)) : Subring.closure {x : A | x * σ x = 1} = ⊤ := by
  sorry

/-- **A model of the hypotheses of `closure_normOne_eq_top`, every clause exercised**: the field of nine elements with
`σ = x ↦ x³` (an involution: `x⁹ = x`), and any `θ` outside the prime field (`θ³ ≠ θ`): `θ − θ³` is a nonzero element of a
field, and `a + θ ≠ 0` for each of the three fixed `a`. -/
theorem exists_model_galoisField :
    (∀ x : GaloisField 3 2, frobenius (GaloisField 3 2) 3 (frobenius (GaloisField 3 2) 3 x) = x) ∧
      ∃ θ : GaloisField 3 2, IsUnit (θ - frobenius (GaloisField 3 2) 3 θ) ∧
        ∀ a : GaloisField 3 2, frobenius (GaloisField 3 2) 3 a = a → IsUnit (a + θ) := by
  sorry

end HadwigerNelson.Rigidity
