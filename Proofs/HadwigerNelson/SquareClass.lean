import Proofs.HadwigerNelson.FieldWall4
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Squarefree
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.Order.GaloisConnection.Basic

/-!
# Rational square classes, their 2-adic images, and the splitting of a multiquadratic field

SKELETON (FS-36, `plans/FS36-multiquadratic-decomposition.md`, reshaped by its modeling passes §M1–§M3): every
statement elaborates; every proof is a `sorry` leaf unless it is a line or two from the others. The implementer
rewrites this docstring at the close.

## What this file says

A real multiquadratic field `ℚ(√d₁, …, √d_r)` is determined by the subgroup of positive rational square classes its
radicands span. `fieldOfClasses` sends such a subgroup to its field and `classesOfField` sends a real field to the
classes whose square roots it contains; they form a Galois connection (`gc_fieldOfClasses_classesOfField`) — the
half of Kummer theory that needs no independence of square roots — so the field of a sum of subgroups is the
compositum of their fields.

The 2-adic four-colour test of `plans/FIELD-WALL-THEOREM.md` §6.2 asks one question of a subgroup: does its image
under `twoAdic`, in `ℚ₂^×/(ℚ₂^×)²`, contain the class of `−1` (`TwoAdicSqClass.minusOne`)?

**The decomposition** (stated and proved by ChatGPT (OpenAI) in conversation with Kooshi, 2026-09-11, as a
corollary of that test; `reference/ChatGPT-multiquadratic/`). A subgroup containing `[2]` is the sum of its classes
landing in `spanThreeTwo = {1, 3, 2, 6}` and its classes landing in `spanThreeTen = {1, 3, 10, 14}`, the two planes
of `𝔽₂³` through `[3]` that avoid `[−1]` (`inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen`). So every real
multiquadratic field lies, once `√2` is adjoined, in the compositum of two fields that pass the test
(`fieldOfRadicands_le_sup`); when it contains `ℚ(√3, √11)`, each of the two has a plane needing four colours.
`multiquadratic_decomposition` bundles the handoff's sentence for reading aloud; proofs should use its parts.

## What is kernel-checked and what is not

The splitting, the field containment, the test's hypothesis on each piece, and `χ ≥ 4` for each piece's plane.
**Not** `χ ≤ 4` for the pieces: that is the test at the field level, which needs a number field's
conjugation-fixed prime to supply a valuation subring with residue field `𝔽₄` (`plans/A1-theorem-A-kernel.md` §R2,
stubbed as FS-37). **Not** Hensel's lemma: `twoAdicOfPrime` is the classical table of 2-adic square classes, not a
theorem about `ℚ₂`.

## Using this file

* **State the four-colour test for radicands `D`:** `TwoAdicSqClass.minusOne ∉ (classesOfRadicands D).map twoAdic`.
  Prove it by `map_twoAdic_classesOfRadicands_le_iff` into a plane avoiding `[−1]`, one `twoAdic (sqClass d)` per
  radicand, as `map_twoAdic_deGreyTwo_le` does.
* **Compute a class:** `sqClass_mul`, `sqClass_prime`, `twoAdic_sqClass_prime`. The simp set is `sqClass_zero`,
  `sqClass_one`, `sqClass_sq`. Coordinates go through `sqClass_apply`, by name, since tagging it would break
  confluence with `sqClass_sq`.
* **Move between radicands, classes and fields:** `fieldOfRadicands_eq_fieldOfClasses`, and the Galois connection.
* **The plane over a field** is `HadwigerNelson.planeOver`, outside this namespace.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## §0 The plane over a real subfield -/

/-- **The plane over a real subfield `F`**: the complex numbers with both coordinates in `F` — `F²`, seen in `ℂ`. -/
def planeOver (F : Subfield ℝ) : Set ℂ := {z | z.re ∈ F ∧ z.im ∈ F}

@[simp] theorem mem_planeOver {F : Subfield ℝ} {z : ℂ} : z ∈ planeOver F ↔ z.re ∈ F ∧ z.im ∈ F := Iff.rfl

/-- `FieldWall4`'s `seamPlane` is the plane over `seamField`. -/
theorem planeOver_seamField : planeOver seamField = seamPlane := rfl

/-- **A plane over a field containing `ℚ(√3, √11)` needs four colours** — the Moser spindle. -/
theorem four_le_chromaticNumber_planeOver {F : Subfield ℝ} (hF : seamField ≤ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := sorry

namespace SquareClass

/-! ## §1 A splitting of the image lifts -/

section Split

variable {R M N : Type*} [Ring R] [AddCommGroup M] [AddCommGroup N] [Module R M] [Module R N]

/-- **A splitting of the image lifts to the source.** If `W`'s image is the sum of its parts inside `U₁` and inside
`U₂`, then `W` is the sum of its parts mapping into `U₁` and into `U₂` — the kernel lies in both. -/
theorem inf_comap_sup_inf_comap_eq (f : M →ₗ[R] N) {W : Submodule R M} {U₁ U₂ : Submodule R N}
    (h : W.map f ≤ (W.map f ⊓ U₁) ⊔ (W.map f ⊓ U₂)) :
    (W ⊓ U₁.comap f) ⊔ (W ⊓ U₂.comap f) = W := sorry

end Split

/-! ## §2 The square-class group -/

/-- **The positive rational square classes** `ℚ_{>0}/(ℚ^×)²`, as the `𝔽₂`-vector space with basis the primes: a
class records which primes occur to an odd power. -/
abbrev SqClass : Type := Nat.Primes →₀ ZMod 2

/-- **The square class of a natural number**: the parity of each prime's exponent. At `0` it is the junk value
`0`; that is harmless for every field statement below, because `√0 = 0` lies in every field. -/
noncomputable def sqClass (n : ℕ) : SqClass :=
  Finsupp.comapDomain Subtype.val (n.factorization.mapRange (fun e : ℕ => (e : ZMod 2)) Nat.cast_zero)
    Subtype.val_injective.injOn

/-- **The coordinate formula**: every `sqClass` identity reduces to it, one prime at a time. Not `@[simp]`: with
`sqClass_sq` it would make the simp set non-confluent. -/
theorem sqClass_apply (n : ℕ) (p : Nat.Primes) : sqClass n p = (n.factorization p : ZMod 2) := rfl

@[simp] theorem sqClass_zero : sqClass 0 = 0 := sorry

@[simp] theorem sqClass_one : sqClass 1 = 0 := sorry

theorem sqClass_mul {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) : sqClass (a * b) = sqClass a + sqClass b :=
  sorry

theorem sqClass_prime {p : ℕ} (hp : p.Prime) : sqClass p = Finsupp.single ⟨p, hp⟩ 1 := sorry

/-- A perfect square has trivial class. -/
@[simp] theorem sqClass_sq (b : ℕ) : sqClass (b ^ 2) = 0 := sorry

/-- **A nonzero natural number whose square class is trivial is a perfect square.** -/
theorem isSquare_of_sqClass_eq_zero {n : ℕ} (hn : n ≠ 0) (h : sqClass n = 0) : IsSquare n := sorry

/-- **Every square class is the class of a nonzero natural number** — the product of its primes. -/
theorem exists_sqClass_eq (v : SqClass) : ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v := sorry

/-- **The square classes of a set of radicands**: the subgroup they span. -/
noncomputable def classesOfRadicands (D : Set ℕ) : Submodule (ZMod 2) SqClass :=
  Submodule.span (ZMod 2) (sqClass '' D)

/-! ## §3 The 2-adic image -/

/-- **The 2-adic square classes** `ℚ₂^×/(ℚ₂^×)²` in coordinates: `(a, b, c)` is the class of
`(−1)^a · 5^b · 2^c`. -/
abbrev TwoAdicSqClass : Type := ZMod 2 × ZMod 2 × ZMod 2

namespace TwoAdicSqClass

/-- The 2-adic class of `2`. -/
def two : TwoAdicSqClass := (0, 0, 1)

/-- The 2-adic class of `3`, which is that of `−5`. -/
def three : TwoAdicSqClass := (1, 1, 0)

/-- The 2-adic class of `5`, the unramified class. -/
def five : TwoAdicSqClass := (0, 1, 0)

/-- The 2-adic class of `10 = 2 · 5`. -/
def ten : TwoAdicSqClass := (0, 1, 1)

/-- The 2-adic class of `−1`, which is that of `7`. -/
def minusOne : TwoAdicSqClass := (1, 0, 0)

end TwoAdicSqClass

/-- The 2-adic class of a prime `p`: `[2]` at `2`, and an odd prime by `p mod 8`
(`1 ↦ [1]`, `3 ↦ [3]`, `5 ↦ [5]`, `7 ↦ [−1]`). A table, not a theorem about `ℚ₂`: that an odd unit is a 2-adic
square iff it is `1 mod 8` is Hensel's lemma, used here and not formalized. -/
def twoAdicOfPrime (p : ℕ) : TwoAdicSqClass :=
  if p = 2 then TwoAdicSqClass.two
  else if p % 8 = 3 then TwoAdicSqClass.three
  else if p % 8 = 5 then TwoAdicSqClass.five
  else if p % 8 = 7 then TwoAdicSqClass.minusOne
  else 0

/-- **The 2-adic image of a square class**, extended linearly from the primes. -/
noncomputable def twoAdic : SqClass →ₗ[ZMod 2] TwoAdicSqClass :=
  Finsupp.linearCombination (ZMod 2) (fun p : Nat.Primes => twoAdicOfPrime p)

theorem twoAdic_sqClass_prime {p : ℕ} (hp : p.Prime) : twoAdic (sqClass p) = twoAdicOfPrime p := sorry

/-- `{1, 3, 2, 6}`: the subgroup of `TwoAdicSqClass` spanned by `[3]` and `[2]`. -/
def spanThreeTwo : Submodule (ZMod 2) TwoAdicSqClass :=
  Submodule.span (ZMod 2) {TwoAdicSqClass.three, TwoAdicSqClass.two}

/-- `{1, 3, 10, 14}`: the subgroup of `TwoAdicSqClass` spanned by `[3]` and `[10]`. -/
def spanThreeTen : Submodule (ZMod 2) TwoAdicSqClass :=
  Submodule.span (ZMod 2) {TwoAdicSqClass.three, TwoAdicSqClass.ten}

theorem minusOne_not_mem_spanThreeTwo : TwoAdicSqClass.minusOne ∉ spanThreeTwo := sorry

theorem minusOne_not_mem_spanThreeTen : TwoAdicSqClass.minusOne ∉ spanThreeTen := sorry

/-- The eight-case fact the local splitting derives from: every class lies in one of the two spans, or lands in
`spanThreeTen` once `[2]` is added. -/
private theorem mem_spanThreeTwo_or_mem_spanThreeTen_or_add_two_mem (v : TwoAdicSqClass) :
    v ∈ spanThreeTwo ∨ v ∈ spanThreeTen ∨ v + TwoAdicSqClass.two ∈ spanThreeTen := sorry

/-- **Every subgroup of `ℚ₂^×/(ℚ₂^×)²` that holds `[2]` splits along the two spans.** The only classes outside both
are `[5]` and `[−1]`, and `[2]` carries each into `spanThreeTen` (`2 · 5 = 10`, `2 · 7 = 14`). -/
theorem le_inf_spanThreeTwo_sup_inf_spanThreeTen {V : Submodule (ZMod 2) TwoAdicSqClass}
    (h2 : TwoAdicSqClass.two ∈ V) : V ≤ (V ⊓ spanThreeTwo) ⊔ (V ⊓ spanThreeTen) := sorry

/-- `3 ≡ 11 ≡ 3 (mod 8)`: both have the 2-adic class `[3]`, which lies in both spans. -/
theorem twoAdic_sqClass_three : twoAdic (sqClass 3) = TwoAdicSqClass.three := sorry

theorem twoAdic_sqClass_eleven : twoAdic (sqClass 11) = TwoAdicSqClass.three := sorry

/-! ## §4 The 2-adic splitting of a square-class group -/

/-- **The 2-adic splitting.** A square-class group containing `[2]` is the sum of its classes landing in
`spanThreeTwo` and its classes landing in `spanThreeTen`. -/
theorem inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen {W : Submodule (ZMod 2) SqClass}
    (h2 : sqClass 2 ∈ W) :
    (W ⊓ spanThreeTwo.comap twoAdic) ⊔ (W ⊓ spanThreeTen.comap twoAdic) = W :=
  inf_comap_sup_inf_comap_eq twoAdic <| le_inf_spanThreeTwo_sup_inf_spanThreeTen <| by
    have h := Submodule.mem_map_of_mem (f := twoAdic) h2
    simpa [twoAdic_sqClass_prime Nat.prime_two, twoAdicOfPrime] using h

/-- **The classes of `W` landing in a subgroup that avoids `[−1]` pass the four-colour test.** -/
theorem minusOne_not_mem_map_inf_comap {U : Submodule (ZMod 2) TwoAdicSqClass}
    (hU : TwoAdicSqClass.minusOne ∉ U) (W : Submodule (ZMod 2) SqClass) :
    TwoAdicSqClass.minusOne ∉ (W ⊓ U.comap twoAdic).map twoAdic :=
  fun h => hU (Submodule.map_le_iff_le_comap.mpr inf_le_right h)

theorem sqClass_mem_inf_comap {W : Submodule (ZMod 2) SqClass} {U : Submodule (ZMod 2) TwoAdicSqClass} {n : ℕ}
    (hW : sqClass n ∈ W) (hU : twoAdic (sqClass n) ∈ U) : sqClass n ∈ W ⊓ U.comap twoAdic :=
  Submodule.mem_inf.mpr ⟨hW, hU⟩

/-- **The 2-adic image of a set of radicands lies in a subgroup iff every radicand's class does.** -/
theorem map_twoAdic_classesOfRadicands_le_iff {D : Set ℕ} {U : Submodule (ZMod 2) TwoAdicSqClass} :
    (classesOfRadicands D).map twoAdic ≤ U ↔ ∀ d ∈ D, twoAdic (sqClass d) ∈ U := sorry

/-! ## §5 Fields: a Galois connection -/

/-- **The multiquadratic field of a set of radicands**, `ℚ(√d : d ∈ D)`. -/
noncomputable def fieldOfRadicands (D : Set ℕ) : Subfield ℝ :=
  Subfield.closure ((fun d : ℕ => Real.sqrt d) '' D)

/-- **The generators**: `√d ∈ ℚ(√D)` for `d ∈ D`. The image is named explicitly because
`Subfield.subset_closure` cannot infer it through `fieldOfRadicands`. -/
theorem sqrt_mem_fieldOfRadicands {D : Set ℕ} {d : ℕ} (hd : d ∈ D) : Real.sqrt d ∈ fieldOfRadicands D :=
  Subfield.subset_closure (Set.mem_image_of_mem (fun d : ℕ => Real.sqrt d) hd)

theorem fieldOfRadicands_mono {D₁ D₂ : Set ℕ} (h : D₁ ⊆ D₂) : fieldOfRadicands D₁ ≤ fieldOfRadicands D₂ :=
  sorry

/-- **The field of a square-class group**: generated by the square roots of the natural numbers whose class lies
in `W`. -/
noncomputable def fieldOfClasses (W : Submodule (ZMod 2) SqClass) : Subfield ℝ :=
  fieldOfRadicands {n | sqClass n ∈ W}

/-- **Equal square classes carry field membership of the root**, in both directions and with no side condition —
the one arithmetic fact under the Galois connection. Class `0` means a square or zero, whose root is rational. -/
theorem sqrt_mem_iff_of_sqClass_eq {F : Subfield ℝ} {n m : ℕ} (h : sqClass n = sqClass m) :
    Real.sqrt n ∈ F ↔ Real.sqrt m ∈ F := sorry

/-- **A radical identity from an integer one**: `a · b = s² · c` gives `√a · √b = s · √c`. -/
theorem sqrt_mul_sqrt_eq {a b c s : ℕ} (h : a * b = s ^ 2 * c) :
    Real.sqrt a * Real.sqrt b = s * Real.sqrt c := sorry

/-- **The square classes of a real field**: those of the nonzero natural numbers whose square roots it contains. A
subgroup with no appeal to the independence of square roots — `√a, √b ∈ F` puts `√(ab)` in `F` — and, requiring
`n ≠ 0`, one whose closure never leans on the junk value `sqClass 0 = 0`. -/
noncomputable def classesOfField (F : Subfield ℝ) : Submodule (ZMod 2) SqClass where
  carrier := {v | ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v ∧ Real.sqrt n ∈ F}
  add_mem' := sorry
  zero_mem' := sorry
  smul_mem' := sorry

/-- **`fieldOfClasses` is left adjoint to `classesOfField`.** -/
theorem gc_fieldOfClasses_classesOfField : GaloisConnection fieldOfClasses classesOfField := sorry

/-- **The field of a sum of square-class groups is the compositum of their fields.** -/
theorem fieldOfClasses_sup (W₁ W₂ : Submodule (ZMod 2) SqClass) :
    fieldOfClasses (W₁ ⊔ W₂) = fieldOfClasses W₁ ⊔ fieldOfClasses W₂ :=
  gc_fieldOfClasses_classesOfField.l_sup

/-- **The field of a set of radicands is the field of its square classes.** -/
theorem fieldOfRadicands_eq_fieldOfClasses (D : Set ℕ) :
    fieldOfRadicands D = fieldOfClasses (classesOfRadicands D) := sorry

/-- **The decomposition, at the level of a square-class group.** -/
theorem fieldOfClasses_eq_sup {W : Submodule (ZMod 2) SqClass} (h2 : sqClass 2 ∈ W) :
    fieldOfClasses W =
      fieldOfClasses (W ⊓ spanThreeTwo.comap twoAdic) ⊔ fieldOfClasses (W ⊓ spanThreeTen.comap twoAdic) := by
  rw [← fieldOfClasses_sup, inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen h2]

/-! ## §6 `ℚ(√3, √11)` inside a field of classes -/

/-- **`ℚ(√3, √11)` is generated by `√3` and `√11`.** -/
theorem seamField_le_fieldOfRadicands : seamField ≤ fieldOfRadicands {3, 11} := sorry

theorem seamField_le_fieldOfClasses {W : Submodule (ZMod 2) SqClass} (h3 : sqClass 3 ∈ W)
    (h11 : sqClass 11 ∈ W) : seamField ≤ fieldOfClasses W := sorry

/-! ## §7 The decomposition of a real multiquadratic field -/

/-- **Every real multiquadratic field lies in the compositum of two fields that pass the four-colour test**: the
fields of the classes of `D ∪ {2}` landing in `spanThreeTwo` and in `spanThreeTen`, neither of which contains `[−1]`
(`minusOne_not_mem_map_inf_comap`). **Not proved here:** that those two fields' planes are 4-colourable — that is
the test at the field level (FS-37). -/
theorem fieldOfRadicands_le_sup (D : Set ℕ) :
    fieldOfRadicands D ≤ fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTwo.comap twoAdic) ⊔
      fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTen.comap twoAdic) := sorry

/-- **When the field contains `ℚ(√3, √11)`, so does every piece cut out by a subgroup holding `[3]`, and the piece's
plane needs four colours.** -/
theorem four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap {D : Set ℕ} (h3 : 3 ∈ D) (h11 : 11 ∈ D)
    {U : Submodule (ZMod 2) TwoAdicSqClass} (hU : TwoAdicSqClass.three ∈ U) :
    4 ≤ ((unitDistance ℂ).induce
      (planeOver (fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ U.comap twoAdic)))).chromaticNumber := sorry

/-- **The decomposition, as the handoff states it — for reading aloud; proofs should use its parts.** With `W` the
square classes of `D ∪ {2}`: `ℚ(√D)` lies in the compositum of the fields of `W`'s two pieces; each piece's plane
needs four colours; and neither piece's 2-adic image contains `[−1]`. **Not proved here:** `χ ≤ 4` for the pieces'
planes (FS-37). -/
theorem multiquadratic_decomposition (D : Set ℕ) (h3 : 3 ∈ D) (h11 : 11 ∈ D) :
    let W := classesOfRadicands (insert 2 D)
    fieldOfRadicands D ≤
        fieldOfClasses (W ⊓ spanThreeTwo.comap twoAdic) ⊔ fieldOfClasses (W ⊓ spanThreeTen.comap twoAdic) ∧
      4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfClasses (W ⊓ spanThreeTwo.comap twoAdic)))).chromaticNumber ∧
      4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfClasses (W ⊓ spanThreeTen.comap twoAdic)))).chromaticNumber ∧
      TwoAdicSqClass.minusOne ∉ (W ⊓ spanThreeTwo.comap twoAdic).map twoAdic ∧
      TwoAdicSqClass.minusOne ∉ (W ⊓ spanThreeTen.comap twoAdic).map twoAdic := by
  intro W
  exact ⟨fieldOfRadicands_le_sup D,
    four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap h3 h11
      (Submodule.subset_span (Set.mem_insert _ _)),
    four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap h3 h11
      (Submodule.subset_span (Set.mem_insert _ _)),
    minusOne_not_mem_map_inf_comap minusOne_not_mem_spanThreeTwo W,
    minusOne_not_mem_map_inf_comap minusOne_not_mem_spanThreeTen W⟩

/-! ## §8 De Grey's field, worked -/

/-- **De Grey's field `ℚ(√3, √5, √7, √11)` lies in `ℚ(√2, √3, √11, √35) · ℚ(√3, √10, √11, √35)`** — the handoff's
worked example, checked directly by `√5 = √2 · √10 / 2` and `√7 = √35 · √5 / 5` (`sqrt_mul_sqrt_eq`). -/
theorem fieldOfRadicands_deGrey_le_sup :
    fieldOfRadicands {3, 5, 7, 11} ≤ fieldOfRadicands {2, 3, 11, 35} ⊔ fieldOfRadicands {3, 10, 11, 35} :=
  sorry

/-- The 2-adic classes of `2, 3, 11, 35` lie in `spanThreeTwo`, so `ℚ(√2, √3, √11, √35)` passes the test. -/
theorem map_twoAdic_deGreyTwo_le : (classesOfRadicands {2, 3, 11, 35}).map twoAdic ≤ spanThreeTwo := sorry

/-- The 2-adic classes of `3, 10, 11, 35` lie in `spanThreeTen`, so `ℚ(√3, √10, √11, √35)` passes the test. -/
theorem map_twoAdic_deGreyTen_le : (classesOfRadicands {3, 10, 11, 35}).map twoAdic ≤ spanThreeTen := sorry

/-- Both factors pass the four-colour test. -/
example : TwoAdicSqClass.minusOne ∉ (classesOfRadicands {2, 3, 11, 35}).map twoAdic ∧
    TwoAdicSqClass.minusOne ∉ (classesOfRadicands {3, 10, 11, 35}).map twoAdic :=
  ⟨fun h => minusOne_not_mem_spanThreeTwo (map_twoAdic_deGreyTwo_le h),
    fun h => minusOne_not_mem_spanThreeTen (map_twoAdic_deGreyTen_le h)⟩

/-- The general theorem at de Grey's field. -/
example : fieldOfRadicands {3, 5, 7, 11} ≤
    fieldOfClasses (classesOfRadicands {2, 3, 5, 7, 11} ⊓ spanThreeTwo.comap twoAdic) ⊔
      fieldOfClasses (classesOfRadicands {2, 3, 5, 7, 11} ⊓ spanThreeTen.comap twoAdic) :=
  fieldOfRadicands_le_sup {3, 5, 7, 11}

/-! ## §9 Spec -/

section Spec

#guard twoAdicOfPrime 2 = TwoAdicSqClass.two
#guard twoAdicOfPrime 3 = TwoAdicSqClass.three
#guard twoAdicOfPrime 11 = TwoAdicSqClass.three
#guard twoAdicOfPrime 5 = TwoAdicSqClass.five
#guard twoAdicOfPrime 7 = TwoAdicSqClass.minusOne
#guard twoAdicOfPrime 17 = 0
#guard TwoAdicSqClass.three + TwoAdicSqClass.five = TwoAdicSqClass.minusOne
#guard TwoAdicSqClass.two + TwoAdicSqClass.five = TwoAdicSqClass.ten

/-- `12 = 2² · 3` has the class of `3`. -/
example : sqClass 12 = sqClass 3 := sorry

/-- `35 = 5 · 7` has the 2-adic class `[5] + [−1] = [3]`. -/
example : twoAdic (sqClass 35) = TwoAdicSqClass.three := sorry

/-- `[6] = [3] + [2]` lies in `spanThreeTwo`; `[10]` does not. -/
example : TwoAdicSqClass.three + TwoAdicSqClass.two ∈ spanThreeTwo ∧ TwoAdicSqClass.ten ∉ spanThreeTwo := sorry

/-- `√5 = √2 · √10 / 2`, so `√5 ∈ ℚ(√2, √10)`. -/
example : Real.sqrt 5 ∈ fieldOfRadicands {2, 10} := sorry

example : (⟨Real.sqrt 3, 1⟩ : ℂ) ∈ planeOver seamField := sorry

/-- The pieces of `D ∪ {2}` lie inside the field of `D ∪ {2}` — the handoff's `A, B ⊆ F(√2)`. -/
example (D : Set ℕ) : fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTwo.comap twoAdic) ≤
    fieldOfRadicands (insert 2 D) :=
  (fieldOfRadicands_eq_fieldOfClasses _).symm ▸ gc_fieldOfClasses_classesOfField.monotone_l inf_le_left

/-- **Red: `[2]` is load-bearing in the splitting.** Without `√2`, the classes of `ℚ(√7)` have both pieces trivial:
`[7] = [−1]` lies in neither span. -/
example : (classesOfRadicands {7} ⊓ spanThreeTwo.comap twoAdic) ⊔ (classesOfRadicands {7} ⊓ spanThreeTen.comap twoAdic)
    ≠ classesOfRadicands {7} := sorry

/-- **Red: the lifting lemma's hypothesis is load-bearing.** In `𝔽₂²` with `f = id`, the diagonal meets both axes in
`0`. -/
example : ¬ (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ≤
    (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓
        Submodule.span (ZMod 2) {((1 : ZMod 2), (0 : ZMod 2))}) ⊔
      (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓
        Submodule.span (ZMod 2) {((0 : ZMod 2), (1 : ZMod 2))})) :=
  sorry

end Spec

end SquareClass

end HadwigerNelson
