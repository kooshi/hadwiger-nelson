import Mathlib.FieldTheory.IsRealClosed.Basic
import Mathlib.FieldTheory.AlgebraicClosure
import Mathlib.Analysis.Polynomial.Order
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Algebra.Ring.SumsOfSquares

/-!
# The real numbers and the real algebraic numbers are real closed

`Mathlib/FieldTheory/IsRealClosed/Basic.lean` defines `IsRealClosed` and records, as a TODO, "real numbers, real
algebraic numbers, hyperreals form a real closed field". This file supplies the first two, in Mathlib's style and with
no project imports, as upstream candidates:

* `Real.isRealClosed` — `ℝ` is real closed: nonnegatives are squares (`Real.sqrt`), and an odd-degree real polynomial has
  a real root (`Polynomial.exists_isRoot_of_odd_natDegree_real`, from the eventual-sign lemmas of
  `Mathlib/Analysis/Polynomial/Order.lean`: a root-free polynomial has one sign below and above all its roots, and odd
  degree makes the two signs opposite).
* `algebraicClosure.isRealClosed` — the relative algebraic closure of any subfield in a real closed field is real closed:
  a square root, or a root of an odd-degree polynomial, is algebraic over the relative closure and so already in it. With
  `F = ℚ`, `E = ℝ` this is the field of real algebraic numbers (`isRealClosed_algebraicClosure_rat_real`).

**Both instances are upstream candidates, and must be deleted from this repository when Mathlib gains them** — they are
global instances on types this project does not own, true and canonical (a `Prop`-valued class), so no diamond can
arise, but two copies of one fact are a maintenance debt.

They are the `(RC)` input of `plans/M2-S1D-bridge.md` §2.0, needed by every route to real algebraic descent (Tarski's and
Artin–Lang's); the descent itself (`Bridge.RealAlgebraicDescent`) is not proved here.
-/

open Polynomial

/-! ## Sums of squares along ring homomorphisms -/

/-- A ring homomorphism sends sums of squares to sums of squares. -/
theorem IsSumSq.map {R S F : Type*} [NonAssocSemiring R] [NonAssocSemiring S] [FunLike F R S]
    [RingHomClass F R S] (f : F) {s : R} (hs : IsSumSq s) : IsSumSq (f s) := by
  induction hs with
  | zero => simp
  | sq_add a _ ih => simpa using IsSumSq.sq_add (f a) ih

/-- A ring with a ring homomorphism to a semireal ring is semireal: `1 + s = 0` would map to `1 + f s = 0`. -/
theorem IsSemireal.of_ringHom {R S : Type*} [NonAssocRing R] [NonAssocRing S] [IsSemireal S] (f : R →+* S) :
    IsSemireal R where
  one_add_ne_zero {s} hs h := IsSemireal.one_add_ne_zero (hs.map f) (by
    rw [← map_one f, ← map_add, h, map_zero])

/-! ## `ℝ` -/

/-- **An odd-degree real polynomial has a real root.** Were it root-free, it would be positive (for a nonnegative
leading coefficient) at `0` as a point above all its roots, and negative at `0` as a point below all its roots, the
sign there being `(-1) ^ natDegree` times the top one. -/
theorem Polynomial.exists_isRoot_of_odd_natDegree_real {f : ℝ[X]} (hf : Odd f.natDegree) : ∃ x, f.IsRoot x := by
  by_contra! h
  have hlt : ∀ y, f.IsRoot y → y < 0 := fun y hy => (h y hy).elim
  have hgt : ∀ y, f.IsRoot y → 0 < y := fun y hy => (h y hy).elim
  have hodd : ((Int.negOnePow (f.natDegree : ℤ) : ℤ) : ℝ) = -1 := by
    rw [Int.negOnePow_odd _ (by exact_mod_cast hf)]
    simp
  rcases le_total 0 f.leadingCoeff with hlc | hlc
  · have h1 := zero_lt_eval_of_roots_lt_of_leadingCoeff_nonneg hlt hlc
    have h2 := zero_lt_negOnePow_mul_eval_of_lt_roots_of_leadingCoeff_nonneg hgt hlc
    rw [hodd] at h2
    linarith
  · have h1 := eval_lt_zero_of_roots_lt_of_leadingCoeff_nonpos hlt hlc
    have h2 := negOnePow_mul_eval_lt_zero_of_lt_roots_of_leadingCoeff_nonpos hgt hlc
    rw [hodd] at h2
    linarith

/-- **`ℝ` is a real closed field.** Upstream candidate (Mathlib's TODO in `FieldTheory/IsRealClosed/Basic.lean`);
delete when Mathlib gains it. -/
instance Real.isRealClosed : IsRealClosed ℝ :=
  IsRealClosed.of_linearOrderedField (fun {x} hx => ⟨√x, (Real.mul_self_sqrt hx).symm⟩)
    Polynomial.exists_isRoot_of_odd_natDegree_real

/-! ## Relative algebraic closures -/

namespace IsRealClosed

variable {F E : Type*} [Field F] [Field E] [Algebra F E]

/-- An element of `E` integral over the relative algebraic closure of `F` lies in it. -/
theorem mem_algebraicClosure_of_isIntegral {r : E} (hr : IsIntegral (algebraicClosure F E) r) :
    r ∈ algebraicClosure F E :=
  mem_algebraicClosure_iff'.mpr (isIntegral_trans r hr)

/-- A square root of an element of the relative algebraic closure lies in it. -/
theorem mem_algebraicClosure_of_mul_self_mem {r : E} (hr : r * r ∈ algebraicClosure F E) :
    r ∈ algebraicClosure F E :=
  mem_algebraicClosure_of_isIntegral <| IsIntegral.of_pow two_pos <| by
    rw [sq]
    exact (isIntegral_algebraMap (x := (⟨r * r, hr⟩ : algebraicClosure F E)))

end IsRealClosed

open IsRealClosed in
/-- **The relative algebraic closure of a field in a real closed field is real closed.** With `F = ℚ`, `E = ℝ` it is
the field of real algebraic numbers. Upstream candidate (Mathlib's TODO in `FieldTheory/IsRealClosed/Basic.lean` names
the real algebraic numbers); delete when Mathlib gains it. -/
instance algebraicClosure.isRealClosed {F E : Type*} [Field F] [Field E] [Algebra F E] [IsRealClosed E] :
    IsRealClosed (algebraicClosure F E) where
  toIsSemireal := IsSemireal.of_ringHom (algebraMap (algebraicClosure F E) E)
  isSquare_or_isSquare_neg x := by
    rcases IsRealClosed.isSquare_or_isSquare_neg (x : E) with ⟨r, hr⟩ | ⟨r, hr⟩
    · have hmem : r ∈ algebraicClosure F E := mem_algebraicClosure_of_mul_self_mem (hr ▸ x.2)
      exact .inl ⟨⟨r, hmem⟩, Subtype.ext hr⟩
    · have hmem : r ∈ algebraicClosure F E :=
        mem_algebraicClosure_of_mul_self_mem (by rw [← hr]; exact (algebraicClosure F E).neg_mem x.2)
      exact .inr ⟨⟨r, hmem⟩, Subtype.ext hr⟩
  exists_isRoot_of_odd_natDegree {f} hf := by
    have hf0 : f ≠ 0 := fun h => by simp [h] at hf
    obtain ⟨r, hr⟩ := IsRealClosed.exists_isRoot_of_odd_natDegree
      (f := f.map (algebraMap (algebraicClosure F E) E)) (by rwa [natDegree_map])
    have hint : IsIntegral (algebraicClosure F E) r :=
      (show IsAlgebraic (algebraicClosure F E) r from ⟨f, hf0, by rwa [aeval_def, eval₂_eq_eval_map]⟩).isIntegral
    have hmem : r ∈ algebraicClosure F E := mem_algebraicClosure_of_isIntegral hint
    refine ⟨⟨r, hmem⟩, (algebraMap (algebraicClosure F E) E).injective ?_⟩
    rw [map_zero, ← eval₂_at_apply, ← eval_map]
    exact hr

/-- **The real algebraic numbers form a real closed field** — `algebraicClosure.isRealClosed` at `F = ℚ`, `E = ℝ`. -/
theorem isRealClosed_algebraicClosure_rat_real : IsRealClosed (algebraicClosure ℚ ℝ) := inferInstance

/-! ## Spec -/

-- `2` has a square root among the real algebraic numbers, and `-1` has none.
example : IsSquare (2 : algebraicClosure ℚ ℝ) := by
  rcases IsRealClosed.isSquare_or_isSquare_neg (2 : algebraicClosure ℚ ℝ) with h | ⟨r, hr⟩
  · exact h
  · have h' : (-2 : ℝ) = (r : ℝ) * r := by
      have := congrArg (algebraMap (algebraicClosure ℚ ℝ) ℝ) hr
      rw [map_neg, map_ofNat, map_mul] at this
      exact this
    nlinarith [mul_self_nonneg (r : ℝ)]
example : ¬ IsSquare (-1 : algebraicClosure ℚ ℝ) := fun h =>
  IsSemireal.not_isSumSq_neg_one _ h.isSumSq
-- `2` has a real algebraic cube root.
example : ∃ r : algebraicClosure ℚ ℝ, (2 : algebraicClosure ℚ ℝ) = r ^ 3 :=
  IsRealClosed.exists_eq_pow_of_odd 2 (by decide)
-- An even-degree root-free polynomial is no counterexample to the odd-degree lemma: `X² + 1` has no real root.
example : ¬ ∃ x : ℝ, (X ^ 2 + 1 : ℝ[X]).IsRoot x := by
  rintro ⟨x, hx⟩
  simp only [IsRoot, eval_add, eval_pow, eval_X, eval_one] at hx
  nlinarith [sq_nonneg x]
