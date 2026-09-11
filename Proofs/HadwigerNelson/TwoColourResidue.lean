import Proofs.HadwigerNelson.ResidueColouring
import Proofs.HadwigerNelson.FieldWall4
import Mathlib.NumberTheory.Zsqrtd.GaussianInt
import Mathlib.LinearAlgebra.Dual.Lemmas
import Mathlib.Combinatorics.SimpleGraph.CycleGraph
import Mathlib.Algebra.CharP.Reduced
import Mathlib.Algebra.Field.ZMod
import Mathlib.Algebra.Algebra.ZMod

/-!
# Two colours from a residue that conjugation does not move

SKELETON (FS-36, `plans/FS36-multiquadratic-decomposition.md`, reshaped by its domain pass §M1): every statement
elaborates; every proof is a `sorry` leaf unless it is a line from the others. The module docstring is rewritten
by the implementer at the close.

**Three hypotheses on how conjugation `σ` meets a residue map `ψ`, each buying more.**

* None — Theorem A (`ResidueColouring.lean`): as many colours as the residue ring has elements.
* `ψ (σ z) = 0 → ψ z = 0` — the prime is fixed by conjugation: the valuation law (`ResidueColouring.lean` §4).
* `ψ (σ z) = ψ z` — conjugation lies in the **inertia group** of the prime. Then a unit vector `u` has
  `ψ u · ψ u = ψ u · ψ (σ u) = 1`, so every unit vector reduces to a square root of `1`
  (`map_mul_self_eq_one_of_mem_normOne_of_conj_eq`); in a reduced ring of characteristic two that root is `1`.
  An additive functional `k →+ ZMod 2` that does not vanish at `1` is then nonzero on every unit step, and
  `colorable_of_residue` gives **two colours**.

The functional is additive and not multiplicative, and that is the content: over `ℚ(√5)` the residue field at 2
is `𝔽₄`, which has no ring homomorphism to `𝔽₂` — Theorem A with `G = ZMod 2` cannot reach it.

The hypothesis covers Woodall's `ℚ²`, the "if" half of `[Fischer1990]` Theorem 8, `[Moorhouse2010]` Theorem 7.1
(odd-degree fields, through the trace) and `[Madore2015]` Proposition 3.9 (`ℚ(√2)²`). Which number fields supply
such a valuation subring is the gap of `plans/A1-theorem-A-kernel.md` §R2, stubbed as FS-37.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## §1 Characteristic two -/

/-- In a reduced ring of characteristic two, `1` is the only square root of `1`. -/
theorem eq_one_of_mul_self_eq_one_of_charTwo {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    {x : k} (h : x * x = 1) : x = 1 := sorry

/-- A ring of characteristic two has an additive functional to `ZMod 2` that does not vanish at `1`. -/
theorem exists_addMonoidHom_zmod_two_apply_one_ne_zero (k : Type*) [Ring k] [CharP k 2] :
    ∃ l : k →+ ZMod 2, l 1 ≠ 0 := sorry

/-! ## §2 Unit vectors under a conjugation-trivial residue, and the ring form -/

section NormOne

variable {L : Type*} [CommRing L] {A : Subring L} {σ : L →+* L}

/-- **A conjugation-trivial residue sends every norm-one element to a square root of `1`.** No hypothesis on
the residue ring. -/
theorem map_mul_self_eq_one_of_mem_normOne_of_conj_eq {k : Type*} [CommRing k]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    {u : L} (hu : u ∈ A) (h : u ∈ normOne σ) : ψ ⟨u, hu⟩ * ψ ⟨u, hu⟩ = 1 := sorry

/-- **In characteristic two, to `1` itself.** -/
theorem map_eq_one_of_mem_normOne_of_conj_eq {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    {u : L} (hu : u ∈ A) (h : u ∈ normOne σ) : ψ ⟨u, hu⟩ = 1 :=
  eq_one_of_mul_self_eq_one_of_charTwo (map_mul_self_eq_one_of_mem_normOne_of_conj_eq hσ ψ hψσ hu h)

/-- **Two colours, over a ring.** -/
theorem colorable_two_of_normOne_of_conj_eq {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    {V : Type*} (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable 2 := sorry

end NormOne

/-! ## §3 The valuation form and the plane -/

/-- **Two colours, valuation form.** -/
theorem colorable_two_of_valuationSubring_of_conj_eq {L : Type*} [Field L] (A : ValuationSubring L)
    {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A) (hσσ : ∀ z : L, σ (σ z) = z)
    {k : Type*} [CommRing k] [IsReduced k] [CharP k 2] (ψ : A.toSubring →+* k)
    (hψσ : ∀ z : A.toSubring, ψ (σ.restrict A.toSubring A.toSubring hσ z) = ψ z)
    {V : Type*} (Γ : SimpleGraph V) (f : V → L)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable 2 := sorry

/-- **Theorem A, two-colour case, in the write-up's shape**: a conjugation-stable subfield of `ℂ`, a
conjugation-stable valuation subring of it, and a residue map into a reduced ring of characteristic two that
conjugation does not move. Every unit-distance graph drawn in the subfield is 2-colourable. -/
theorem colorable_two_unitDistance_induce_of_valuationSubring {L : Subfield ℂ}
    (hL : ∀ z ∈ L, (starRingEnd ℂ) z ∈ L) (A : ValuationSubring L) (hσ : ∀ z ∈ A, conjOn hL z ∈ A)
    {k : Type*} [CommRing k] [IsReduced k] [CharP k 2] (ψ : A.toSubring →+* k)
    (hψσ : ∀ z : A.toSubring, ψ ((conjOn hL).restrict A.toSubring A.toSubring hσ z) = ψ z)
    {S : Set ℂ} (hS : S ⊆ (L : Set ℂ)) :
    ((unitDistance ℂ).induce S).Colorable 2 := sorry

/-! ## §4 Spec — a model with a nontrivial conjugation, and the two reds -/

section Spec

/-- The residue map of the Gaussian integers at `1 + i`: `a + bi ↦ a + b (mod 2)`. -/
def gaussResidue : GaussianInt →+* ZMod 2 := Zsqrtd.lift ⟨1, by decide⟩

/-- The 4-cycle `0 → 1 → 1 + i → i → 0`, drawn in the Gaussian integers. -/
def gaussSquare : Fin 4 → GaussianInt := ![0, 1, ⟨1, 1⟩, ⟨0, 1⟩]

/-- **The model of the ring form's hypotheses**: `ℤ[i]` with its conjugation — nontrivial — and the residue
mod `1 + i`, which conjugation does not move, instantiate the theorem on the square drawn there. -/
example : (SimpleGraph.cycleGraph 4).Colorable 2 := by
  -- `ZMod 2` is a field, hence reduced, only once its modulus is known prime; kept local on purpose.
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  exact colorable_two_of_normOne_of_conj_eq (A := (⊤ : Subring GaussianInt)) (σ := starRingEnd GaussianInt)
    (fun _ _ => Subring.mem_top _) (gaussResidue.comp (⊤ : Subring GaussianInt).subtype)
    (fun _ => sorry) _ gaussSquare (fun _ _ _ => Subring.mem_top _) (fun _ _ _ => sorry)

/-- **Red: `hψσ` is load-bearing.** In `𝔽₄` with Frobenius as the conjugation, `Ω` has norm one and is not `1`
— Theorem B's residue field, where conjugation induces Frobenius and four colours are needed. -/
example : ∃ u : FieldWall4.F4, u * FieldWall4.F4.sq u = 1 ∧ u ≠ 1 := sorry

/-- **Red: characteristic two is load-bearing.** In `ZMod 3`, `2 · 2 = 1` and `2 ≠ 1`. -/
example : ∃ u : ZMod 3, u * u = 1 ∧ u ≠ 1 := sorry

end Spec

end HadwigerNelson
