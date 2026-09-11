import Proofs.HadwigerNelson.FieldWall4
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Squarefree
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.Order.GaloisConnection.Basic

/-!
# Rational square classes, their 2-adic images, and the splitting of a multiquadratic field

SKELETON (FS-36, `plans/FS36-multiquadratic-decomposition.md`, reshaped by its domain pass §M1): every statement
elaborates; every proof is a `sorry` leaf unless it is a line or two from the others. The module docstring is
rewritten by the implementer at the close.

A real multiquadratic field `ℚ(√d₁, …, √d_r)` is determined by the `𝔽₂`-subspace of positive rational square
classes its radicands span. `sqrtField` sends a subspace to its field and `kummerClasses` sends a real field to
the classes whose square roots it contains. They form a **Galois connection** (`gc_sqrtField_kummerClasses`) —
the half of Kummer theory that needs no independence of square roots — so `sqrtField` preserves sums, and a
splitting of a square-class group is a splitting of its field.

The 2-adic four-colour test of `plans/FIELD-WALL-THEOREM.md` §6.2 asks one question of a square-class group: does
its image in `ℚ₂^×/(ℚ₂^×)² ≅ 𝔽₂³` contain the class of `−1`?

**The decomposition** (stated and proved by ChatGPT (OpenAI) in conversation with Kooshi, 2026-09-11, as a
corollary of that test; `reference/ChatGPT-multiquadratic/`): a square-class group containing `[2]` is the sum of
its classes localizing into `{1, 3, 2, 6}` and its classes localizing into `{1, 3, 10, 14}` — the two planes of
`𝔽₂³` through `[3]` that avoid `[−1]`. So every real multiquadratic field, once `√2` is adjoined, lies in the
compositum of two fields that pass the test; when it contains `ℚ(√3, √11)` so does each of the two, and each
one's plane needs four colours.

**What is kernel-checked and what is not.** The splitting, the field containment, the test's hypothesis on each
piece, and `χ ≥ 4` for each piece's plane. **Not** `χ ≤ 4` for the pieces: that is the test at the field level,
which needs a number field's conjugation-fixed prime to supply a valuation subring with residue field `𝔽₄`
(`plans/A1-theorem-A-kernel.md` §R2, stubbed as FS-37). **Not** Hensel's lemma: `locPrime` is the classical table
of 2-adic square classes, not a theorem about `ℚ₂`.
-/

namespace HadwigerNelson

open SimpleGraph

namespace SquareClass

/-! ## §1 A splitting of the image lifts -/

section Split

variable {R M N : Type*} [Ring R] [AddCommGroup M] [AddCommGroup N] [Module R M] [Module R N]

/-- **A splitting of the image lifts to the source.** If `W`'s image is the sum of its parts inside `U₁` and
inside `U₂`, then `W` is the sum of its parts mapping into `U₁` and into `U₂` — the kernel lies in both. -/
theorem inf_comap_sup_inf_comap_eq (f : M →ₗ[R] N) {W : Submodule R M} {U₁ U₂ : Submodule R N}
    (h : W.map f ≤ (W.map f ⊓ U₁) ⊔ (W.map f ⊓ U₂)) :
    (W ⊓ U₁.comap f) ⊔ (W ⊓ U₂.comap f) = W := sorry

end Split

/-! ## §2 The square-class group -/

/-- **The positive rational square classes** `ℚ_{>0}/(ℚ^×)²`, as the `𝔽₂`-vector space with basis the primes:
a class records which primes occur to an odd power. -/
abbrev SqClass : Type := Nat.Primes →₀ ZMod 2

/-- **The square class of a natural number**: the parity of each prime's exponent. At `0` it is the junk
value `0`; that is harmless for every field statement below, because `√0 = 0` lies in every field. -/
noncomputable def sqClass (n : ℕ) : SqClass :=
  Finsupp.comapDomain Subtype.val (n.factorization.mapRange (fun e : ℕ => (e : ZMod 2)) Nat.cast_zero)
    Subtype.val_injective.injOn

/-- **The coordinate formula**: every `sqClass` identity reduces to it, one prime at a time. -/
theorem sqClass_apply (n : ℕ) (p : Nat.Primes) : sqClass n p = (n.factorization p : ZMod 2) := rfl

theorem sqClass_zero : sqClass 0 = 0 := sorry

theorem sqClass_one : sqClass 1 = 0 := sorry

theorem sqClass_mul {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) : sqClass (a * b) = sqClass a + sqClass b :=
  sorry

theorem sqClass_prime {p : ℕ} (hp : p.Prime) : sqClass p = Finsupp.single ⟨p, hp⟩ 1 := sorry

/-- A perfect square has trivial class. -/
theorem sqClass_sq (b : ℕ) : sqClass (b ^ 2) = 0 := sorry

/-- **A nonzero natural number whose square class is trivial is a perfect square.** -/
theorem isSquare_of_sqClass_eq_zero {n : ℕ} (hn : n ≠ 0) (h : sqClass n = 0) : IsSquare n := sorry

/-- **Every square class is the class of a nonzero natural number** — the product of its primes. -/
theorem exists_sqClass_eq (v : SqClass) : ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v := sorry

/-- **The square-class group of a set of radicands.** -/
noncomputable def classGroup (D : Set ℕ) : Submodule (ZMod 2) SqClass :=
  Submodule.span (ZMod 2) (sqClass '' D)

/-! ## §3 Localization at 2 -/

/-- **The 2-adic square-class group** `ℚ₂^×/(ℚ₂^×)²` in coordinates: `(a, b, c)` is the class of
`(−1)^a · 5^b · 2^c`. -/
abbrev LocTwo : Type := ZMod 2 × ZMod 2 × ZMod 2

/-- The 2-adic class of a prime `p`: `[2]` at `2`, and an odd prime by `p mod 8`
(`1 ↦ [1]`, `3 ↦ [−5] = [3]`, `5 ↦ [5]`, `7 ↦ [−1]`). A table, not a theorem about `ℚ₂`: that an odd unit is a
2-adic square iff it is `1 mod 8` is Hensel's lemma, used here and not formalized. -/
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

/-- **Every class lies in a block, or lands in `blockTen` once `[2]` is added** — the eight-case fact the local
splitting derives from, a `decide` once span membership is a finite existential. -/
theorem mem_blockTwo_or_mem_blockTen_or_add_two_mem_blockTen (v : LocTwo) :
    v ∈ blockTwo ∨ v ∈ blockTen ∨ v + (0, 0, 1) ∈ blockTen := sorry

/-- **Every subgroup of `ℚ₂^×/(ℚ₂^×)²` that holds `[2]` splits along the two blocks.** The only classes outside
both blocks are `[5]` and `[−1]`, and `[2]` carries each into `blockTen` (`2 · 5 = 10`, `2 · 7 = 14`). -/
theorem le_inf_blockTwo_sup_inf_blockTen {V : Submodule (ZMod 2) LocTwo}
    (h2 : ((0, 0, 1) : LocTwo) ∈ V) : V ≤ (V ⊓ blockTwo) ⊔ (V ⊓ blockTen) := sorry

/-- `3 ≡ 11 ≡ 3 (mod 8)`: both localize to `[3]`, which lies in both blocks. -/
theorem loc2_sqClass_three : loc2 (sqClass 3) = (1, 1, 0) := sorry

theorem loc2_sqClass_eleven : loc2 (sqClass 11) = (1, 1, 0) := sorry

/-! ## §4 The 2-adic splitting of a square-class group -/

/-- **The 2-adic splitting.** A square-class group containing `[2]` is the sum of its classes localizing into
`blockTwo` and its classes localizing into `blockTen`. -/
theorem inf_comap_blockTwo_sup_inf_comap_blockTen (W : Submodule (ZMod 2) SqClass) (h2 : sqClass 2 ∈ W) :
    (W ⊓ blockTwo.comap loc2) ⊔ (W ⊓ blockTen.comap loc2) = W :=
  inf_comap_sup_inf_comap_eq loc2 <| le_inf_blockTwo_sup_inf_blockTen <| by
    have h := Submodule.mem_map_of_mem (f := loc2) h2
    simpa [loc2_sqClass_prime Nat.prime_two, locPrime] using h

/-- **A piece cut out by a plane avoiding `[−1]` passes the four-colour test.** -/
theorem minusOne_not_mem_map_inf_comap {U : Submodule (ZMod 2) LocTwo} (hU : minusOne ∉ U)
    (W : Submodule (ZMod 2) SqClass) : minusOne ∉ (W ⊓ U.comap loc2).map loc2 :=
  fun h => hU (Submodule.map_le_iff_le_comap.mpr inf_le_right h)

theorem sqClass_mem_inf_comap {W : Submodule (ZMod 2) SqClass} {U : Submodule (ZMod 2) LocTwo} {n : ℕ}
    (hW : sqClass n ∈ W) (hU : loc2 (sqClass n) ∈ U) : sqClass n ∈ W ⊓ U.comap loc2 :=
  Submodule.mem_inf.mpr ⟨hW, hU⟩

/-- **A class group's 2-adic image lies in a plane iff every radicand's class does.** -/
theorem map_loc2_classGroup_le_iff {D : Set ℕ} {U : Submodule (ZMod 2) LocTwo} :
    (classGroup D).map loc2 ≤ U ↔ ∀ d ∈ D, loc2 (sqClass d) ∈ U := sorry

/-! ## §5 Fields: a Galois connection -/

/-- **The multiquadratic field** `ℚ(√d : d ∈ D)`. -/
noncomputable def mqField (D : Set ℕ) : Subfield ℝ :=
  Subfield.closure ((fun d : ℕ => Real.sqrt d) '' D)

/-- **The field of a square-class group**: generated by the square roots of the natural numbers whose class
lies in `W`. -/
noncomputable def sqrtField (W : Submodule (ZMod 2) SqClass) : Subfield ℝ :=
  mqField {n | sqClass n ∈ W}

/-- **The generators**: `√d ∈ ℚ(√D)` for `d ∈ D`. The image is named explicitly because
`Subfield.subset_closure` cannot infer it through `mqField`. -/
theorem sqrt_mem_mqField {D : Set ℕ} {d : ℕ} (hd : d ∈ D) : Real.sqrt d ∈ mqField D :=
  Subfield.subset_closure (Set.mem_image_of_mem (fun d : ℕ => Real.sqrt d) hd)

theorem mqField_mono {D₁ D₂ : Set ℕ} (h : D₁ ⊆ D₂) : mqField D₁ ≤ mqField D₂ := sorry

/-- **Equal square classes carry field membership of the root**, in both directions and with no side
condition — the one arithmetic fact under the Galois connection. Class `0` means a square or zero, whose
root is rational. -/
theorem sqrt_mem_iff_of_sqClass_eq {F : Subfield ℝ} {n m : ℕ} (h : sqClass n = sqClass m) :
    Real.sqrt n ∈ F ↔ Real.sqrt m ∈ F := sorry

/-- **A radical identity from an integer one**: `a · b = s² · c` gives `√a · √b = s · √c`. -/
theorem sqrt_mul_sqrt_eq {a b c s : ℕ} (h : a * b = s ^ 2 * c) :
    Real.sqrt a * Real.sqrt b = s * Real.sqrt c := sorry

/-- **The square classes of a real field**: those of the nonzero natural numbers whose square roots it
contains. A subgroup with no appeal to the independence of square roots — `√a, √b ∈ F` puts `√(ab)` in `F` —
and, requiring `n ≠ 0`, one whose closure never leans on the junk value `sqClass 0 = 0`. -/
noncomputable def kummerClasses (F : Subfield ℝ) : Submodule (ZMod 2) SqClass where
  carrier := {v | ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v ∧ Real.sqrt n ∈ F}
  add_mem' := sorry
  zero_mem' := sorry
  smul_mem' := sorry

/-- **`sqrtField` is left adjoint to `kummerClasses`.** -/
theorem gc_sqrtField_kummerClasses : GaloisConnection sqrtField kummerClasses := sorry

/-- **The field of a sum is the compositum.** -/
theorem sqrtField_sup (W₁ W₂ : Submodule (ZMod 2) SqClass) :
    sqrtField (W₁ ⊔ W₂) = sqrtField W₁ ⊔ sqrtField W₂ :=
  gc_sqrtField_kummerClasses.l_sup

theorem mqField_eq_sqrtField_classGroup (D : Set ℕ) : mqField D = sqrtField (classGroup D) := sorry

/-- **The decomposition, at the level of a square-class group.** -/
theorem sqrtField_eq_sup (W : Submodule (ZMod 2) SqClass) (h2 : sqClass 2 ∈ W) :
    sqrtField W = sqrtField (W ⊓ blockTwo.comap loc2) ⊔ sqrtField (W ⊓ blockTen.comap loc2) := by
  rw [← sqrtField_sup, inf_comap_blockTwo_sup_inf_comap_blockTen W h2]

/-! ## §6 Planes -/

/-- **The plane over a real subfield**: the complex numbers with both coordinates in it. -/
def fieldPlane (F : Subfield ℝ) : Set ℂ := {z | z.re ∈ F ∧ z.im ∈ F}

theorem mem_fieldPlane {F : Subfield ℝ} {z : ℂ} : z ∈ fieldPlane F ↔ z.re ∈ F ∧ z.im ∈ F := Iff.rfl

theorem fieldPlane_seamField : fieldPlane seamField = seamPlane := rfl

/-- **A plane over a field containing `ℚ(√3, √11)` needs four colours** — the Moser spindle. -/
theorem four_le_chromaticNumber_fieldPlane {F : Subfield ℝ} (hF : seamField ≤ F) :
    4 ≤ ((unitDistance ℂ).induce (fieldPlane F)).chromaticNumber := sorry

/-- **`ℚ(√3, √11)` is generated by `√3` and `√11`.** -/
theorem seamField_le_mqField : seamField ≤ mqField {3, 11} := sorry

theorem seamField_le_sqrtField {W : Submodule (ZMod 2) SqClass} (h3 : sqClass 3 ∈ W)
    (h11 : sqClass 11 ∈ W) : seamField ≤ sqrtField W := sorry

/-! ## §7 The decomposition of a real multiquadratic field -/

/-- **Every real multiquadratic field lies in the compositum of two fields that pass the four-colour test.** -/
theorem mqField_le_sup (D : Set ℕ) :
    mqField D ≤ sqrtField (classGroup (insert 2 D) ⊓ blockTwo.comap loc2) ⊔
      sqrtField (classGroup (insert 2 D) ⊓ blockTen.comap loc2) := sorry

/-- **When the field contains `ℚ(√3, √11)`, so does every piece cut out by a plane through `[3]`, and the
piece's plane needs four colours.** -/
theorem four_le_chromaticNumber_fieldPlane_sqrtField_inf_comap {D : Set ℕ} (h3 : 3 ∈ D) (h11 : 11 ∈ D)
    {U : Submodule (ZMod 2) LocTwo} (hU : ((1, 1, 0) : LocTwo) ∈ U) :
    4 ≤ ((unitDistance ℂ).induce
      (fieldPlane (sqrtField (classGroup (insert 2 D) ⊓ U.comap loc2)))).chromaticNumber := sorry

/-- **The decomposition, as the handoff states it** — for reading aloud. With `W` the square-class group of
`D ∪ {2}`: `ℚ(√D)` lies in the compositum of the fields of `W`'s two pieces; each piece's plane needs four
colours; and neither piece's 2-adic image contains `[−1]`. -/
theorem multiquadratic_decomposition (D : Set ℕ) (h3 : 3 ∈ D) (h11 : 11 ∈ D) :
    let W := classGroup (insert 2 D)
    mqField D ≤ sqrtField (W ⊓ blockTwo.comap loc2) ⊔ sqrtField (W ⊓ blockTen.comap loc2) ∧
      4 ≤ ((unitDistance ℂ).induce (fieldPlane (sqrtField (W ⊓ blockTwo.comap loc2)))).chromaticNumber ∧
      4 ≤ ((unitDistance ℂ).induce (fieldPlane (sqrtField (W ⊓ blockTen.comap loc2)))).chromaticNumber ∧
      minusOne ∉ (W ⊓ blockTwo.comap loc2).map loc2 ∧ minusOne ∉ (W ⊓ blockTen.comap loc2).map loc2 := by
  intro W
  exact ⟨mqField_le_sup D,
    four_le_chromaticNumber_fieldPlane_sqrtField_inf_comap h3 h11 (Submodule.subset_span (Set.mem_insert _ _)),
    four_le_chromaticNumber_fieldPlane_sqrtField_inf_comap h3 h11 (Submodule.subset_span (Set.mem_insert _ _)),
    minusOne_not_mem_map_inf_comap minusOne_not_mem_blockTwo W,
    minusOne_not_mem_map_inf_comap minusOne_not_mem_blockTen W⟩

/-! ## §8 De Grey's field, worked -/

/-- **De Grey's field `ℚ(√3, √5, √7, √11)` lies in `ℚ(√2, √3, √11, √35) · ℚ(√3, √10, √11, √35)`** — the
handoff's worked example, checked directly by `√5 = √2 · √10 / 2` and `√7 = √35 · √5 / 5`. -/
theorem mqField_deGrey_le : mqField {3, 5, 7, 11} ≤ mqField {2, 3, 11, 35} ⊔ mqField {3, 10, 11, 35} :=
  sorry

theorem minusOne_not_mem_map_classGroup_two_three_eleven_thirtyFive :
    minusOne ∉ (classGroup {2, 3, 11, 35}).map loc2 := sorry

theorem minusOne_not_mem_map_classGroup_three_ten_eleven_thirtyFive :
    minusOne ∉ (classGroup {3, 10, 11, 35}).map loc2 := sorry

/-- The general theorem at de Grey's field. -/
example : mqField {3, 5, 7, 11} ≤ sqrtField (classGroup {2, 3, 5, 7, 11} ⊓ blockTwo.comap loc2) ⊔
    sqrtField (classGroup {2, 3, 5, 7, 11} ⊓ blockTen.comap loc2) :=
  mqField_le_sup {3, 5, 7, 11}

/-! ## §9 Spec -/

section Spec

#guard locPrime 2 = (0, 0, 1)
#guard locPrime 3 = (1, 1, 0)
#guard locPrime 11 = (1, 1, 0)
#guard locPrime 5 = (0, 1, 0)
#guard locPrime 7 = (1, 0, 0)
#guard locPrime 17 = 0

/-- `12 = 2² · 3` has the class of `3`. -/
example : sqClass 12 = sqClass 3 := sorry

/-- `35 = 5 · 7` localizes to `[5] + [−1] = [3]`. -/
example : loc2 (sqClass 35) = (1, 1, 0) := sorry

/-- `[6] = [3] + [2]` lies in `blockTwo`; `[10]` does not. -/
example : ((1, 1, 1) : LocTwo) ∈ blockTwo ∧ ((0, 1, 1) : LocTwo) ∉ blockTwo := sorry

/-- `√5 = √2 · √10 / 2`, so `√5 ∈ ℚ(√2, √10)`. -/
example : Real.sqrt 5 ∈ mqField {2, 10} := sorry

example : (⟨Real.sqrt 3, 1⟩ : ℂ) ∈ fieldPlane seamField := sorry

/-- **Red: `[2]` is load-bearing in the splitting.** Without `√2`, the group of `ℚ(√7)` has both pieces trivial:
`[7] = [−1]` lies in neither block. -/
example : (classGroup {7} ⊓ blockTwo.comap loc2) ⊔ (classGroup {7} ⊓ blockTen.comap loc2) ≠ classGroup {7} :=
  sorry

/-- **Red: the lifting lemma's hypothesis is load-bearing.** In `𝔽₂²` with `f = id`, the diagonal meets both
axes in `0`. -/
example : ¬ (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ≤
    (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓
        Submodule.span (ZMod 2) {((1 : ZMod 2), (0 : ZMod 2))}) ⊔
      (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓
        Submodule.span (ZMod 2) {((0 : ZMod 2), (1 : ZMod 2))})) :=
  sorry

end Spec

end SquareClass

end HadwigerNelson
