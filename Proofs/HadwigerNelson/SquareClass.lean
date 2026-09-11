import Proofs.HadwigerNelson.FieldWall4
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Squarefree
import Mathlib.LinearAlgebra.Finsupp.LinearCombination

/-!
# Rational square classes, their 2-adic images, and the splitting of a multiquadratic field

SKELETON (FS-36, `plans/FS36-multiquadratic-decomposition.md`): every statement elaborates, every proof
is a `sorry` leaf. The module docstring is rewritten by the implementer at the close.

A real multiquadratic field `ℚ(√d₁, …, √d_r)` is determined by the `𝔽₂`-subspace `W` of positive
rational square classes that its radicands span (Kummer theory). The 2-adic four-colour criterion of
`plans/FIELD-WALL-THEOREM.md` §6.2 asks one question of `W`: does its image in `ℚ₂^×/(ℚ₂^×)² ≅ 𝔽₂³`
contain the class of `−1`?

**The decomposition** (stated and proved by ChatGPT (OpenAI) in conversation with Kooshi, 2026-09-11,
as a corollary of that criterion; `reference/ChatGPT-multiquadratic/`): if `W` contains the classes of
`2` and `3`, it is the sum of its two subspaces whose 2-adic images lie in `{1, 3, 2, 6}` and in
`{1, 3, 10, 14}` — two planes of `𝔽₂³` that avoid `[−1]`. So every real multiquadratic field containing
`ℚ(√3, √11)` lies in the compositum of two such fields, each of which meets the criterion's hypothesis
and contains a Moser spindle.

**What is kernel-checked here and what is not.** The splitting of `W`, the field containment, the
wall predicate on each piece's classes, and the lower bound `χ ≥ 4` for each piece's plane. **Not**
the upper bound `χ ≤ 4` for the pieces: that is the criterion at the field level, which needs a number
field's conjugation-fixed prime to supply a valuation subring with residue field `𝔽₄` — the gap
`plans/A1-theorem-A-kernel.md` §R2 names, stubbed as FS-37.
-/

namespace HadwigerNelson

open SimpleGraph

namespace SquareClass

/-! ## §1 The splitting lemma -/

section Split

variable {R M N : Type*} [Ring R] [AddCommGroup M] [AddCommGroup N] [Module R M] [Module R N]

/-- **A subspace is the sum of the preimages of two subspaces** that together cover its image, when
one of them lies inside that image. -/
theorem le_inf_comap_sup_inf_comap (f : M →ₗ[R] N) {W : Submodule R M} {U₁ U₂ : Submodule R N}
    (h₁ : U₁ ≤ W.map f) (h : W.map f ≤ U₁ ⊔ U₂) :
    W ≤ (W ⊓ U₁.comap f) ⊔ (W ⊓ U₂.comap f) := sorry

end Split

/-! ## §2 The square-class group and localization at 2 -/

/-- **The positive rational square classes** `ℚ_{>0}/(ℚ^×)²`, as the `𝔽₂`-vector space with basis the
primes: a class records which primes occur to an odd power. -/
abbrev SqClass : Type := Nat.Primes →₀ ZMod 2

/-- **The square class of a natural number**: the parity of each prime's exponent. Junk at `0`
(`sqClass 0 = 0`); every theorem that reads it takes `n ≠ 0`. -/
noncomputable def sqClass (n : ℕ) : SqClass :=
  Finsupp.comapDomain Subtype.val (n.factorization.mapRange (fun e : ℕ => (e : ZMod 2)) Nat.cast_zero)
    Subtype.val_injective.injOn

theorem sqClass_mul {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) : sqClass (a * b) = sqClass a + sqClass b :=
  sorry

theorem sqClass_prime {p : ℕ} (hp : p.Prime) : sqClass p = Finsupp.single ⟨p, hp⟩ 1 := sorry

/-- **A natural number whose square class is trivial is a perfect square.** -/
theorem isSquare_of_sqClass_eq_zero {n : ℕ} (hn : n ≠ 0) (h : sqClass n = 0) : IsSquare n := sorry

/-- **Every square class is the class of a natural number** — the product of its primes. -/
theorem exists_sqClass_eq (v : SqClass) : ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v := sorry

/-- **The 2-adic square-class group** `ℚ₂^×/(ℚ₂^×)²` in coordinates: `(a, b, c)` is the class of
`(−1)^a · 5^b · 2^c`. -/
abbrev LocTwo : Type := ZMod 2 × ZMod 2 × ZMod 2

/-- The 2-adic class of a prime `p`: `[2]` at `2`, and an odd prime by `p mod 8`
(`1 ↦ [1]`, `3 ↦ [−5] = [3]`, `5 ↦ [5]`, `7 ↦ [−1]`). A table, not a theorem about `ℚ₂`: that an odd
unit is a 2-adic square iff it is `1 mod 8` is Hensel's lemma, used here and not formalized. -/
def locPrime (p : ℕ) : LocTwo :=
  if p = 2 then (0, 0, 1)
  else if p % 8 = 3 then (1, 1, 0)
  else if p % 8 = 5 then (0, 1, 0)
  else if p % 8 = 7 then (1, 0, 0)
  else 0

/-- **Localization at 2**, extended linearly from the primes. -/
noncomputable def loc2 : SqClass →ₗ[ZMod 2] LocTwo :=
  Finsupp.linearCombination (ZMod 2) (fun p : Nat.Primes => locPrime p)

theorem loc2_sqClass_prime {p : ℕ} (hp : p.Prime) : loc2 (sqClass p) = locPrime p := sorry

/-- The class of `−1` in `ℚ₂^×/(ℚ₂^×)²`. -/
def minusOne : LocTwo := (1, 0, 0)

/-- `{1, 3, 2, 6}`: the plane of `LocTwo` spanned by `[3]` and `[2]`. -/
def blockTwo : Submodule (ZMod 2) LocTwo := Submodule.span (ZMod 2) {(1, 1, 0), (0, 0, 1)}

/-- `{1, 3, 10, 14}`: the plane of `LocTwo` spanned by `[3]` and `[10]`. -/
def blockTen : Submodule (ZMod 2) LocTwo := Submodule.span (ZMod 2) {(1, 1, 0), (0, 1, 1)}

theorem minusOne_not_mem_blockTwo : minusOne ∉ blockTwo := sorry

theorem minusOne_not_mem_blockTen : minusOne ∉ blockTen := sorry

theorem blockTwo_sup_blockTen : blockTwo ⊔ blockTen = ⊤ := sorry

/-! ## §3 The splitting of a square-class group -/

/-- The classes of `W` whose 2-adic image lies in `{1, 3, 2, 6}`. -/
noncomputable def pieceTwo (W : Submodule (ZMod 2) SqClass) : Submodule (ZMod 2) SqClass :=
  W ⊓ blockTwo.comap loc2

/-- The classes of `W` whose 2-adic image lies in `{1, 3, 10, 14}`. -/
noncomputable def pieceTen (W : Submodule (ZMod 2) SqClass) : Submodule (ZMod 2) SqClass :=
  W ⊓ blockTen.comap loc2

/-- **The 2-adic splitting.** A square-class group containing `[2]` and `[3]` is the sum of its two
pieces. -/
theorem pieceTwo_sup_pieceTen (W : Submodule (ZMod 2) SqClass) (h2 : sqClass 2 ∈ W)
    (h3 : sqClass 3 ∈ W) : pieceTwo W ⊔ pieceTen W = W := sorry

theorem minusOne_not_mem_map_pieceTwo (W : Submodule (ZMod 2) SqClass) :
    minusOne ∉ (pieceTwo W).map loc2 := sorry

theorem minusOne_not_mem_map_pieceTen (W : Submodule (ZMod 2) SqClass) :
    minusOne ∉ (pieceTen W).map loc2 := sorry

/-- `[3]` and `[11]` lie in both pieces: `3 ≡ 11 ≡ 3 (mod 8)`. -/
theorem sqClass_three_mem_pieceTwo {W : Submodule (ZMod 2) SqClass} (h : sqClass 3 ∈ W) :
    sqClass 3 ∈ pieceTwo W := sorry

theorem sqClass_eleven_mem_pieceTwo {W : Submodule (ZMod 2) SqClass} (h : sqClass 11 ∈ W) :
    sqClass 11 ∈ pieceTwo W := sorry

theorem sqClass_three_mem_pieceTen {W : Submodule (ZMod 2) SqClass} (h : sqClass 3 ∈ W) :
    sqClass 3 ∈ pieceTen W := sorry

theorem sqClass_eleven_mem_pieceTen {W : Submodule (ZMod 2) SqClass} (h : sqClass 11 ∈ W) :
    sqClass 11 ∈ pieceTen W := sorry

/-! ## §4 Fields -/

/-- **The field of a square-class group**: generated over `ℚ` by the square roots of the natural
numbers whose class lies in `W`. -/
noncomputable def sqrtField (W : Submodule (ZMod 2) SqClass) : Subfield ℝ :=
  Subfield.closure {x | ∃ n : ℕ, n ≠ 0 ∧ sqClass n ∈ W ∧ x = Real.sqrt n}

/-- **The multiquadratic field** `ℚ(√d : d ∈ D)`. -/
noncomputable def mqField (D : Set ℕ) : Subfield ℝ :=
  Subfield.closure ((fun d : ℕ => Real.sqrt d) '' D)

theorem sqrtField_mono {W₁ W₂ : Submodule (ZMod 2) SqClass} (h : W₁ ≤ W₂) :
    sqrtField W₁ ≤ sqrtField W₂ := sorry

theorem mqField_le_sqrtField_span (D : Set ℕ) (hD : 0 ∉ D) :
    mqField D ≤ sqrtField (Submodule.span (ZMod 2) (sqClass '' D)) := sorry

/-- **The field of a sum is the compositum.** -/
theorem sqrtField_sup (W₁ W₂ : Submodule (ZMod 2) SqClass) :
    sqrtField (W₁ ⊔ W₂) = sqrtField W₁ ⊔ sqrtField W₂ := sorry

/-- **The decomposition, at the field level.** -/
theorem sqrtField_eq_sup (W : Submodule (ZMod 2) SqClass) (h2 : sqClass 2 ∈ W)
    (h3 : sqClass 3 ∈ W) : sqrtField W = sqrtField (pieceTwo W) ⊔ sqrtField (pieceTen W) := sorry

/-! ## §5 Planes, and the lower bound every piece carries -/

/-- **The plane over a real subfield**: the complex numbers with both coordinates in it. -/
def fieldPlane (F : Subfield ℝ) : Set ℂ := {z | z.re ∈ F ∧ z.im ∈ F}

theorem seamField_le_sqrtField {W : Submodule (ZMod 2) SqClass} (h3 : sqClass 3 ∈ W)
    (h11 : sqClass 11 ∈ W) : seamField ≤ sqrtField W := sorry

/-- **A plane over a field containing `ℚ(√3, √11)` needs four colours** — the Moser spindle. -/
theorem four_le_chromaticNumber_fieldPlane {F : Subfield ℝ} (hF : seamField ≤ F) :
    4 ≤ ((unitDistance ℂ).induce (fieldPlane F)).chromaticNumber := sorry

/-! ## §6 The headline -/

/-- **The decomposition of a real multiquadratic field containing `ℚ(√3, √11)`.** With `W` the
square-class group of `D ∪ {2}`, the field `ℚ(√D)` lies in the compositum of the fields of `W`'s two
pieces; each piece's plane needs four colours; and neither piece's 2-adic image contains `[−1]`. -/
theorem mqField_le_sup_pieces (D : Set ℕ) (hD : 0 ∉ D) (h3 : 3 ∈ D) (h11 : 11 ∈ D) :
    let W := Submodule.span (ZMod 2) (sqClass '' insert 2 D)
    mqField D ≤ sqrtField (pieceTwo W) ⊔ sqrtField (pieceTen W) ∧
      4 ≤ ((unitDistance ℂ).induce (fieldPlane (sqrtField (pieceTwo W)))).chromaticNumber ∧
      4 ≤ ((unitDistance ℂ).induce (fieldPlane (sqrtField (pieceTen W)))).chromaticNumber ∧
      minusOne ∉ (pieceTwo W).map loc2 ∧ minusOne ∉ (pieceTen W).map loc2 := sorry

/-! ## §7 De Grey's field, worked -/

/-- **De Grey's field `ℚ(√3, √5, √7, √11)` lies in `ℚ(√2, √3, √11, √35) · ℚ(√3, √10, √11, √35)`.** -/
theorem mqField_deGrey_le : mqField {3, 5, 7, 11} ≤ mqField {2, 3, 11, 35} ⊔ mqField {3, 10, 11, 35} :=
  sorry

theorem minusOne_not_mem_map_span_two_three_eleven_thirtyFive :
    minusOne ∉ (Submodule.span (ZMod 2) (sqClass '' {2, 3, 11, 35})).map loc2 := sorry

theorem minusOne_not_mem_map_span_three_ten_eleven_thirtyFive :
    minusOne ∉ (Submodule.span (ZMod 2) (sqClass '' {3, 10, 11, 35})).map loc2 := sorry

/-! ## §8 Spec -/

section Spec

#guard locPrime 2 = (0, 0, 1)
#guard locPrime 3 = (1, 1, 0)
#guard locPrime 11 = (1, 1, 0)
#guard locPrime 5 = (0, 1, 0)
#guard locPrime 7 = (1, 0, 0)

/-- `12 = 2² · 3` has the class of `3`. -/
example : sqClass 12 = sqClass 3 := sorry

/-- `35 = 5 · 7` localizes to `[5] + [−1] = [3]`. -/
example : loc2 (sqClass 35) = (1, 1, 0) := sorry

/-- `[6] = [3] + [2]` lies in `blockTwo`; `[10]` does not. -/
example : ((1, 1, 1) : LocTwo) ∈ blockTwo ∧ ((0, 1, 1) : LocTwo) ∉ blockTwo := sorry

/-- `√5 = √2 · √10 / 2`, so `√5 ∈ ℚ(√2, √10)`. -/
example : Real.sqrt 5 ∈ mqField {2, 10} := sorry

example : (⟨Real.sqrt 3, 1⟩ : ℂ) ∈ fieldPlane seamField := sorry

/-- **Red: the image hypothesis of the splitting lemma is load-bearing.** In `𝔽₂²` with `f = id`, the
diagonal is covered by the two axes but meets each in `0`. -/
example : ¬ (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ≤
    (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓ Submodule.span (ZMod 2) {((1 : ZMod 2), (0 : ZMod 2))}) ⊔
    (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓ Submodule.span (ZMod 2) {((0 : ZMod 2), (1 : ZMod 2))})) :=
  sorry

end Spec

end SquareClass

end HadwigerNelson
