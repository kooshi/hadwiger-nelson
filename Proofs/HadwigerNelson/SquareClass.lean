import Proofs.HadwigerNelson.FieldWall4
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Squarefree
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.Order.GaloisConnection.Basic
import Mathlib.Algebra.Module.ZMod
import Mathlib.Tactic.NormNum.Prime

/-!
# Rational square classes, their 2-adic images, and the splitting of a multiquadratic field

FS-36 (`plans/FS36-multiquadratic-decomposition.md`).

## What this file says

A real multiquadratic field `ℚ(√d₁, …, √d_r)` is determined by the subgroup of positive rational square classes its
radicands span. `fieldOfClasses` sends such a subgroup to its field and `classesOfField` sends a real field to the
classes whose square roots it contains; they form a Galois connection (`gc_fieldOfClasses_classesOfField`) — the
half of Kummer theory that needs no independence of square roots — so the field of a sum of subgroups is the
compositum of their fields.

The 2-adic four-colour test of `plans/FIELD-WALL-THEOREM.md` §6.2 asks one question of a subgroup: does its image
under `twoAdic`, in `ℚ₂^×/(ℚ₂^×)²`, contain the class of `−1` (`TwoAdicSqClass.minusOne`)?

**The decomposition** (a corollary of the 2-adic four-colour criterion, `plans/FIELD-WALL-THEOREM.md` §6.2, stated
and proved by ChatGPT (OpenAI) in conversation with Kooshi, 2026-09-11; no prior statement found;
`reference/ChatGPT-multiquadratic/`). A subgroup containing `[2]` is the sum of its classes landing in
`spanThreeTwo = {1, 3, 2, 6}` and its classes landing in `spanThreeTen = {1, 3, 10, 14}`, the two planes of `𝔽₂³`
through `[3]` that avoid `[−1]` (`inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen`). So every real multiquadratic
field lies, once `√2` is adjoined, in the compositum of two fields that pass the test (`fieldOfRadicands_le_sup`),
each inside the field with `√2` adjoined (`fieldOfClasses_inf_comap_le_fieldOfRadicands`); when it contains
`ℚ(√3, √11)`, so does each of the two (`seamField_le_fieldOfClasses_inf_comap`), and each has a plane needing four
colours. `multiquadratic_decomposition` bundles the handoff's sentence for reading aloud; proofs should use its parts.

## What is kernel-checked and what is not

The splitting, the field containments, the test's hypothesis on each piece, and `χ ≥ 4` for each piece's plane.
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
  **Put a root in a field** from an integer identity `a · b = s² · c`: `sqrt_mem_of_mul_eq_sq_mul`.
* **The plane over a field** is `HadwigerNelson.planeOver`, outside this namespace.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## §0 The plane over a real subfield -/

/-- **The plane over a real subfield `F`**: the complex numbers with both coordinates in `F` — `F²`, seen in `ℂ`. -/
def planeOver (F : Subfield ℝ) : Set ℂ := {z | z.re ∈ F ∧ z.im ∈ F}

/-- Membership in the plane over `F` is membership of both coordinates. -/
@[simp] theorem mem_planeOver {F : Subfield ℝ} {z : ℂ} : z ∈ planeOver F ↔ z.re ∈ F ∧ z.im ∈ F := Iff.rfl

/-- `FieldWall4`'s `seamPlane` is the plane over `seamField`. -/
theorem planeOver_seamField : planeOver seamField = seamPlane := rfl

/-- **A plane over a field containing `ℚ(√3, √11)` needs four colours** — the Moser spindle. -/
theorem four_le_chromaticNumber_planeOver {F : Subfield ℝ} (hF : seamField ≤ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  four_le_chromaticNumber_seamPlane.trans (SimpleGraph.chromaticNumber_mono_of_hom
    (SimpleGraph.induceHomOfLE _ (fun z hz =>
      show z.re ∈ F ∧ z.im ∈ F from
        ⟨hF (FieldWall4.mem_seamPlane_iff.mp hz).1, hF (FieldWall4.mem_seamPlane_iff.mp hz).2⟩)).toHom)

namespace SquareClass

/-! ## §1 A splitting of the image lifts -/

section Split

variable {R M N : Type*} [Ring R] [AddCommGroup M] [AddCommGroup N] [Module R M] [Module R N]

/-- **A splitting of the image lifts to the source.** If `W`'s image is the sum of its parts inside `U₁` and inside
`U₂`, then `W` is the sum of its parts mapping into `U₁` and into `U₂` — the kernel lies in both. -/
theorem inf_comap_sup_inf_comap_eq (f : M →ₗ[R] N) {W : Submodule R M} {U₁ U₂ : Submodule R N}
    (h : W.map f ≤ (W.map f ⊓ U₁) ⊔ (W.map f ⊓ U₂)) :
    (W ⊓ U₁.comap f) ⊔ (W ⊓ U₂.comap f) = W := by
  refine le_antisymm (sup_le inf_le_left inf_le_left) fun w hw => ?_
  obtain ⟨a, ha, b, hb, hab⟩ := Submodule.mem_sup.mp (h (Submodule.mem_map_of_mem hw))
  obtain ⟨w₁, hw₁, rfl⟩ := (Submodule.mem_inf.mp ha).1
  refine Submodule.mem_sup.mpr ⟨w₁, Submodule.mem_inf.mpr ⟨hw₁, (Submodule.mem_inf.mp ha).2⟩, w - w₁,
    Submodule.mem_inf.mpr ⟨W.sub_mem hw hw₁, ?_⟩, by abel⟩
  show f (w - w₁) ∈ U₂
  rw [map_sub, ← hab, add_sub_cancel_left]
  exact (Submodule.mem_inf.mp hb).2

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

/-- The junk value at `0`, stated. -/
@[simp] theorem sqClass_zero : sqClass 0 = 0 := by
  ext p; simp [sqClass_apply]

/-- `1` has trivial class. -/
@[simp] theorem sqClass_one : sqClass 1 = 0 := by
  ext p; simp [sqClass_apply]

/-- **The class is multiplicative on nonzero natural numbers.** -/
theorem sqClass_mul {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) : sqClass (a * b) = sqClass a + sqClass b := by
  ext p; simp [sqClass_apply, Nat.factorization_mul ha hb]

/-- **A prime's class is its basis vector.** -/
theorem sqClass_prime {p : ℕ} (hp : p.Prime) : sqClass p = Finsupp.single ⟨p, hp⟩ 1 := by
  ext ⟨q, hq⟩
  rw [sqClass_apply, hp.factorization]
  by_cases h : p = q
  · subst h; simp
  · have h' : (⟨p, hp⟩ : Nat.Primes) ≠ ⟨q, hq⟩ := fun e => h (congrArg Subtype.val e)
    simp [Finsupp.single_apply, h]
    exact h'

/-- A perfect square has trivial class. -/
@[simp] theorem sqClass_sq (b : ℕ) : sqClass (b ^ 2) = 0 := by
  ext p
  simp only [sqClass_apply, Nat.factorization_pow, Finsupp.smul_apply, smul_eq_mul, Nat.cast_mul,
    Finsupp.coe_zero, Pi.zero_apply]
  rw [show ((2 : ℕ) : ZMod 2) = 0 from rfl, zero_mul]

/-- **A natural number whose square class is trivial is a perfect square** — `0` included, as `0 = 0 · 0`. -/
theorem isSquare_of_sqClass_eq_zero {n : ℕ} (h : sqClass n = 0) : IsSquare n := by
  rcases eq_or_ne n 0 with rfl | hn
  · exact ⟨0, rfl⟩
  obtain ⟨a, b, hab, ha⟩ := Nat.sq_mul_squarefree n
  have ha0 : a ≠ 0 := by rintro rfl; simp at hab; exact hn hab.symm
  have hb0 : b ≠ 0 := by rintro rfl; simp at hab; exact hn hab.symm
  have hca : sqClass a = 0 := by
    have hm := sqClass_mul (pow_ne_zero 2 hb0) ha0
    rwa [hab, h, sqClass_sq, zero_add, eq_comm] at hm
  have hfac : a.factorization = 0 := by
    ext p
    by_cases hp : p.Prime
    · have h1 : a.factorization p ≤ 1 := Squarefree.natFactorization_le_one p ha
      have h2 : ((a.factorization p : ℕ) : ZMod 2) = 0 := by
        show sqClass a ⟨p, hp⟩ = 0
        rw [hca]; rfl
      have h3 : 2 ∣ a.factorization p := (ZMod.natCast_eq_zero_iff _ _).mp h2
      simp only [Finsupp.coe_zero, Pi.zero_apply]
      omega
    · simp [Nat.factorization_eq_zero_of_not_prime a hp]
  have ha1 : a = 1 := Nat.eq_of_factorization_eq ha0 one_ne_zero (fun p => by simp [hfac])
  exact ⟨b, by rw [← hab, ha1, mul_one, sq]⟩

/-- **Every square class is the class of a nonzero natural number** — the product of its primes. -/
theorem exists_sqClass_eq (v : SqClass) : ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v := by
  induction v using Finsupp.induction with
  | zero => exact ⟨1, one_ne_zero, sqClass_one⟩
  | single_add p c f _ hc ih =>
    obtain ⟨m, hm, hfm⟩ := ih
    have hc1 : c = 1 := by revert hc; revert c; decide
    refine ⟨p * m, mul_ne_zero p.2.ne_zero hm, ?_⟩
    rw [sqClass_mul p.2.ne_zero hm, sqClass_prime p.2, hfm, hc1]
    rfl

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

/-- On a prime's class, `twoAdic` is the table. -/
theorem twoAdic_sqClass_prime {p : ℕ} (hp : p.Prime) : twoAdic (sqClass p) = twoAdicOfPrime p := by
  rw [sqClass_prime hp, twoAdic, Finsupp.linearCombination_single, one_smul]

/-- `{1, 3, 2, 6}`: the subgroup of `TwoAdicSqClass` spanned by `[3]` and `[2]`. -/
def spanThreeTwo : Submodule (ZMod 2) TwoAdicSqClass :=
  Submodule.span (ZMod 2) {TwoAdicSqClass.three, TwoAdicSqClass.two}

/-- `{1, 3, 10, 14}`: the subgroup of `TwoAdicSqClass` spanned by `[3]` and `[10]`. -/
def spanThreeTen : Submodule (ZMod 2) TwoAdicSqClass :=
  Submodule.span (ZMod 2) {TwoAdicSqClass.three, TwoAdicSqClass.ten}

/-- `[−1] ∉ {1, 3, 2, 6}`. -/
theorem minusOne_not_mem_spanThreeTwo : TwoAdicSqClass.minusOne ∉ spanThreeTwo := by
  simp only [spanThreeTwo, Submodule.mem_span_pair]; decide

/-- `[−1] ∉ {1, 3, 10, 14}`. -/
theorem minusOne_not_mem_spanThreeTen : TwoAdicSqClass.minusOne ∉ spanThreeTen := by
  simp only [spanThreeTen, Submodule.mem_span_pair]; decide

/-- The eight-case fact the local splitting derives from: every class lies in one of the two spans, or lands in
`spanThreeTen` once `[2]` is added. -/
private theorem mem_spanThreeTwo_or_mem_spanThreeTen_or_add_two_mem (v : TwoAdicSqClass) :
    v ∈ spanThreeTwo ∨ v ∈ spanThreeTen ∨ v + TwoAdicSqClass.two ∈ spanThreeTen := by
  simp only [spanThreeTwo, spanThreeTen, Submodule.mem_span_pair]
  revert v; decide

/-- **Every subgroup of `ℚ₂^×/(ℚ₂^×)²` that holds `[2]` splits along the two spans.** The only classes outside both
are `[5]` and `[−1]`, and `[2]` carries each into `spanThreeTen` (`2 · 5 = 10`, `2 · 7 = 14`). -/
theorem le_inf_spanThreeTwo_sup_inf_spanThreeTen {V : Submodule (ZMod 2) TwoAdicSqClass}
    (h2 : TwoAdicSqClass.two ∈ V) : V ≤ (V ⊓ spanThreeTwo) ⊔ (V ⊓ spanThreeTen) := by
  intro v hv
  have h2B : TwoAdicSqClass.two ∈ spanThreeTwo := by
    simp only [spanThreeTwo, Submodule.mem_span_pair]; decide
  rcases mem_spanThreeTwo_or_mem_spanThreeTen_or_add_two_mem v with h | h | h
  · exact Submodule.mem_sup_left (Submodule.mem_inf.mpr ⟨hv, h⟩)
  · exact Submodule.mem_sup_right (Submodule.mem_inf.mpr ⟨hv, h⟩)
  · exact Submodule.mem_sup.mpr ⟨TwoAdicSqClass.two, Submodule.mem_inf.mpr ⟨h2, h2B⟩,
      v + TwoAdicSqClass.two, Submodule.mem_inf.mpr ⟨V.add_mem hv h2, h⟩,
      by rw [add_left_comm, ZModModule.add_self, add_zero]⟩

/-- `3 ≡ 11 ≡ 3 (mod 8)`: both have the 2-adic class `[3]`, which lies in both spans. -/
theorem twoAdic_sqClass_three : twoAdic (sqClass 3) = TwoAdicSqClass.three := by
  rw [twoAdic_sqClass_prime Nat.prime_three]; decide

/-- `11 ≡ 3 (mod 8)`. -/
theorem twoAdic_sqClass_eleven : twoAdic (sqClass 11) = TwoAdicSqClass.three := by
  rw [twoAdic_sqClass_prime (by norm_num)]; decide

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

/-- A class of `W` whose 2-adic image lies in `U` lies in the piece `W ⊓ U.comap twoAdic`. -/
theorem sqClass_mem_inf_comap {W : Submodule (ZMod 2) SqClass} {U : Submodule (ZMod 2) TwoAdicSqClass} {n : ℕ}
    (hW : sqClass n ∈ W) (hU : twoAdic (sqClass n) ∈ U) : sqClass n ∈ W ⊓ U.comap twoAdic :=
  Submodule.mem_inf.mpr ⟨hW, hU⟩

/-- **The 2-adic image of a set of radicands lies in a subgroup iff every radicand's class does.** -/
theorem map_twoAdic_classesOfRadicands_le_iff {D : Set ℕ} {U : Submodule (ZMod 2) TwoAdicSqClass} :
    (classesOfRadicands D).map twoAdic ≤ U ↔ ∀ d ∈ D, twoAdic (sqClass d) ∈ U := by
  rw [classesOfRadicands, Submodule.map_span, Submodule.span_le, Set.image_image]
  exact Set.image_subset_iff

/-! ## §5 Fields: a Galois connection -/

/-- **The multiquadratic field of a set of radicands**, `ℚ(√d : d ∈ D)`. -/
noncomputable def fieldOfRadicands (D : Set ℕ) : Subfield ℝ :=
  Subfield.closure ((fun d : ℕ => Real.sqrt d) '' D)

/-- **The generators**: `√d ∈ ℚ(√D)` for `d ∈ D`. The image is named explicitly because
`Subfield.subset_closure` cannot infer it through `fieldOfRadicands`. -/
theorem sqrt_mem_fieldOfRadicands {D : Set ℕ} {d : ℕ} (hd : d ∈ D) : Real.sqrt d ∈ fieldOfRadicands D :=
  Subfield.subset_closure (Set.mem_image_of_mem (fun d : ℕ => Real.sqrt d) hd)

/-- More radicands, a larger field. -/
theorem fieldOfRadicands_mono {D₁ D₂ : Set ℕ} (h : D₁ ⊆ D₂) : fieldOfRadicands D₁ ≤ fieldOfRadicands D₂ :=
  Subfield.closure_mono (Set.image_mono h)

/-- **The field of a square-class group**: generated by the square roots of the natural numbers whose class lies
in `W`. -/
noncomputable def fieldOfClasses (W : Submodule (ZMod 2) SqClass) : Subfield ℝ :=
  fieldOfRadicands {n | sqClass n ∈ W}

/-- **Equal square classes carry field membership of the root**, in both directions and with no side condition —
the one arithmetic fact under the Galois connection. Class `0` means a square or zero, whose root is rational. -/
theorem sqrt_mem_iff_of_sqClass_eq {F : Subfield ℝ} {n m : ℕ} (h : sqClass n = sqClass m) :
    Real.sqrt n ∈ F ↔ Real.sqrt m ∈ F := by
  have key : ∀ {a b : ℕ}, sqClass a = sqClass b → Real.sqrt b ∈ F → Real.sqrt a ∈ F := by
    intro a b hab hbF
    rcases eq_or_ne a 0 with rfl | ha
    · simp
    rcases eq_or_ne b 0 with rfl | hb
    · obtain ⟨s, hs⟩ := isSquare_of_sqClass_eq_zero (hab.trans sqClass_zero)
      rw [hs, Nat.cast_mul, Real.sqrt_mul_self (Nat.cast_nonneg _)]
      exact natCast_mem F s
    obtain ⟨s, hs⟩ := isSquare_of_sqClass_eq_zero (n := a * b)
      (by rw [sqClass_mul ha hb, hab, ZModModule.add_self])
    have hb0 : Real.sqrt b ≠ 0 := Real.sqrt_ne_zero'.mpr (by exact_mod_cast Nat.pos_of_ne_zero hb)
    have hroot : Real.sqrt a = (s : ℝ) / Real.sqrt b := by
      rw [eq_div_iff hb0, ← Real.sqrt_mul (Nat.cast_nonneg _), ← Nat.cast_mul, hs, Nat.cast_mul,
        Real.sqrt_mul_self (Nat.cast_nonneg _)]
    rw [hroot]
    exact F.div_mem (natCast_mem F s) hbF
  exact ⟨key h.symm, key h⟩

/-- **A radical identity from an integer one**: `a · b = s² · c` gives `√a · √b = s · √c`. -/
theorem sqrt_mul_sqrt_eq {a b c s : ℕ} (h : a * b = s ^ 2 * c) :
    Real.sqrt a * Real.sqrt b = s * Real.sqrt c := by
  rw [← Real.sqrt_mul (Nat.cast_nonneg _), ← Nat.cast_mul, h, Nat.cast_mul, Real.sqrt_mul (by positivity),
    Nat.cast_pow, Real.sqrt_sq (Nat.cast_nonneg _)]

/-- **A root reached through an integer identity**: `a · b = s² · c` with `s ≠ 0` puts `√c` in every real field
holding `√a` and `√b`. -/
theorem sqrt_mem_of_mul_eq_sq_mul {F : Subfield ℝ} {a b c s : ℕ} (h : a * b = s ^ 2 * c) (hs : s ≠ 0)
    (ha : Real.sqrt a ∈ F) (hb : Real.sqrt b ∈ F) : Real.sqrt c ∈ F := by
  have hroot : Real.sqrt c = Real.sqrt a * Real.sqrt b / s := by
    rw [sqrt_mul_sqrt_eq h, mul_div_cancel_left₀ _ (Nat.cast_ne_zero.mpr hs)]
  rw [hroot]
  exact F.div_mem (F.mul_mem ha hb) (natCast_mem F s)

/-- **The square classes of a real field**: those of the nonzero natural numbers whose square roots it contains. A
subgroup with no appeal to the independence of square roots — `√a, √b ∈ F` puts `√(ab)` in `F` — and, requiring
`n ≠ 0`, one whose closure never leans on the junk value `sqClass 0 = 0`. -/
noncomputable def classesOfField (F : Subfield ℝ) : Submodule (ZMod 2) SqClass where
  carrier := {v | ∃ n : ℕ, n ≠ 0 ∧ sqClass n = v ∧ Real.sqrt n ∈ F}
  add_mem' := by
    rintro _ _ ⟨a, ha, rfl, haF⟩ ⟨b, hb, rfl, hbF⟩
    exact ⟨a * b, mul_ne_zero ha hb, sqClass_mul ha hb, by
      rw [Nat.cast_mul, Real.sqrt_mul (Nat.cast_nonneg _)]; exact F.mul_mem haF hbF⟩
  zero_mem' := ⟨1, one_ne_zero, sqClass_one, by simp⟩
  smul_mem' := by
    rintro c _ ⟨n, hn, rfl, hnF⟩
    rcases (by decide : ∀ c : ZMod 2, c = 0 ∨ c = 1) c with rfl | rfl
    · exact ⟨1, one_ne_zero, by rw [sqClass_one, zero_smul], by simp⟩
    · exact ⟨n, hn, (one_smul _ _).symm, hnF⟩

/-- **`fieldOfClasses` is left adjoint to `classesOfField`.** -/
theorem gc_fieldOfClasses_classesOfField : GaloisConnection fieldOfClasses classesOfField := by
  intro W F
  constructor
  · intro h v hv
    obtain ⟨n, hn, rfl⟩ := exists_sqClass_eq v
    exact ⟨n, hn, rfl, h (Subfield.subset_closure ⟨n, hv, rfl⟩)⟩
  · intro h
    refine Subfield.closure_le.mpr ?_
    rintro _ ⟨n, hn, rfl⟩
    obtain ⟨m, -, hmn, hmF⟩ := h hn
    exact (sqrt_mem_iff_of_sqClass_eq hmn).mp hmF

/-- **The field of a sum of square-class groups is the compositum of their fields.** -/
theorem fieldOfClasses_sup (W₁ W₂ : Submodule (ZMod 2) SqClass) :
    fieldOfClasses (W₁ ⊔ W₂) = fieldOfClasses W₁ ⊔ fieldOfClasses W₂ :=
  gc_fieldOfClasses_classesOfField.l_sup

/-- **The field of a set of radicands is the field of its square classes.** -/
theorem fieldOfRadicands_eq_fieldOfClasses (D : Set ℕ) :
    fieldOfRadicands D = fieldOfClasses (classesOfRadicands D) := by
  apply le_antisymm
  · exact Subfield.closure_le.mpr (by
      rintro _ ⟨d, hd, rfl⟩
      exact Subfield.subset_closure ⟨d, Submodule.subset_span ⟨d, hd, rfl⟩, rfl⟩)
  · refine (gc_fieldOfClasses_classesOfField _ _).mpr (Submodule.span_le.mpr ?_)
    rintro _ ⟨d, hd, rfl⟩
    rcases eq_or_ne d 0 with rfl | hd0
    · exact ⟨1, one_ne_zero, by rw [sqClass_one, sqClass_zero], by simp⟩
    · exact ⟨d, hd0, rfl, Subfield.subset_closure ⟨d, hd, rfl⟩⟩

/-- **The decomposition, at the level of a square-class group.** -/
theorem fieldOfClasses_eq_sup {W : Submodule (ZMod 2) SqClass} (h2 : sqClass 2 ∈ W) :
    fieldOfClasses W =
      fieldOfClasses (W ⊓ spanThreeTwo.comap twoAdic) ⊔ fieldOfClasses (W ⊓ spanThreeTen.comap twoAdic) := by
  rw [← fieldOfClasses_sup, inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen h2]

/-! ## §6 `ℚ(√3, √11)` inside a field of classes -/

/-- **`ℚ(√3, √11)` is generated by `√3` and `√11`.** -/
theorem seamField_le_fieldOfRadicands : seamField ≤ fieldOfRadicands {3, 11} := by
  intro x hx
  obtain ⟨a, b, c, d, rfl⟩ := FieldWall4.mem_seamField_iff.mp hx
  have h3 : Real.sqrt 3 ∈ fieldOfRadicands {3, 11} := by
    simpa using sqrt_mem_fieldOfRadicands (D := {3, 11}) (d := 3) (by simp)
  have h11 : Real.sqrt 11 ∈ fieldOfRadicands {3, 11} := by
    simpa using sqrt_mem_fieldOfRadicands (D := {3, 11}) (d := 11) (by simp)
  have h33 : Real.sqrt 33 ∈ fieldOfRadicands {3, 11} := by
    rw [show (33 : ℝ) = 3 * 11 by norm_num, Real.sqrt_mul (by norm_num)]; exact mul_mem h3 h11
  exact add_mem (add_mem (add_mem (SubfieldClass.ratCast_mem _ a) (mul_mem (SubfieldClass.ratCast_mem _ b) h3))
    (mul_mem (SubfieldClass.ratCast_mem _ c) h11)) (mul_mem (SubfieldClass.ratCast_mem _ d) h33)

/-- `[3], [11] ∈ W` puts `ℚ(√3, √11)` in the field of `W`. -/
theorem seamField_le_fieldOfClasses {W : Submodule (ZMod 2) SqClass} (h3 : sqClass 3 ∈ W)
    (h11 : sqClass 11 ∈ W) : seamField ≤ fieldOfClasses W :=
  seamField_le_fieldOfRadicands.trans (fieldOfRadicands_mono (by
    rintro d (rfl | rfl)
    · exact h3
    · exact h11))

/-- **A piece cut out by a subgroup holding `[3]` contains `ℚ(√3, √11)`** when the radicands contain 3 and 11 — the
handoff's `K ⊆ A, B`. -/
theorem seamField_le_fieldOfClasses_inf_comap {D : Set ℕ} (h3 : 3 ∈ D) (h11 : 11 ∈ D)
    {U : Submodule (ZMod 2) TwoAdicSqClass} (hU : TwoAdicSqClass.three ∈ U) :
    seamField ≤ fieldOfClasses (classesOfRadicands D ⊓ U.comap twoAdic) :=
  seamField_le_fieldOfClasses
    (sqClass_mem_inf_comap (Submodule.subset_span (Set.mem_image_of_mem sqClass h3))
      (by rw [twoAdic_sqClass_three]; exact hU))
    (sqClass_mem_inf_comap (Submodule.subset_span (Set.mem_image_of_mem sqClass h11))
      (by rw [twoAdic_sqClass_eleven]; exact hU))

/-! ## §7 The decomposition of a real multiquadratic field -/

/-- **A piece's field lies in the field it was cut from** — the handoff's `A, B ⊆ F(√2)`, read at `D ∪ {2}`. -/
theorem fieldOfClasses_inf_comap_le_fieldOfRadicands (D : Set ℕ) (U : Submodule (ZMod 2) TwoAdicSqClass) :
    fieldOfClasses (classesOfRadicands D ⊓ U.comap twoAdic) ≤ fieldOfRadicands D :=
  (gc_fieldOfClasses_classesOfField.monotone_l inf_le_left).trans (fieldOfRadicands_eq_fieldOfClasses D).ge

/-- **Every real multiquadratic field lies in the compositum of two fields that pass the four-colour test**: the
fields of the classes of `D ∪ {2}` landing in `spanThreeTwo` and in `spanThreeTen`, neither of which contains `[−1]`
(`minusOne_not_mem_map_inf_comap`). **Not proved here:** that those two fields' planes are 4-colourable — that is
the test at the field level (FS-37). -/
theorem fieldOfRadicands_le_sup (D : Set ℕ) :
    fieldOfRadicands D ≤ fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTwo.comap twoAdic) ⊔
      fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTen.comap twoAdic) := by
  have h2 : sqClass 2 ∈ classesOfRadicands (insert 2 D) :=
    Submodule.subset_span (Set.mem_image_of_mem sqClass (Set.mem_insert 2 D))
  calc fieldOfRadicands D ≤ fieldOfRadicands (insert 2 D) := fieldOfRadicands_mono (Set.subset_insert 2 D)
    _ = fieldOfClasses (classesOfRadicands (insert 2 D)) := fieldOfRadicands_eq_fieldOfClasses _
    _ = _ := fieldOfClasses_eq_sup h2

/-- **When the field contains `ℚ(√3, √11)`, so does every piece cut out by a subgroup holding `[3]`, and the piece's
plane needs four colours.** -/
theorem four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap {D : Set ℕ} (h3 : 3 ∈ D) (h11 : 11 ∈ D)
    {U : Submodule (ZMod 2) TwoAdicSqClass} (hU : TwoAdicSqClass.three ∈ U) :
    4 ≤ ((unitDistance ℂ).induce
      (planeOver (fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ U.comap twoAdic)))).chromaticNumber :=
  four_le_chromaticNumber_planeOver
    (seamField_le_fieldOfClasses_inf_comap (Set.mem_insert_of_mem 2 h3) (Set.mem_insert_of_mem 2 h11) hU)

/-- **The decomposition, as the handoff states it — for reading aloud; proofs should use its parts.** With `W` the
square classes of `D ∪ {2}`, and `A`, `B` the fields of its classes landing in `spanThreeTwo` and in
`spanThreeTen`: `ℚ(√3, √11) ⊆ A, B ⊆ ℚ(√(D ∪ {2}))`; `ℚ(√D) ⊆ A ⊔ B`; each of `A`, `B` has a plane needing four
colours; and neither piece's 2-adic image contains `[−1]`. **Not proved here:** `χ ≤ 4` for the pieces' planes
(FS-37). -/
theorem multiquadratic_decomposition (D : Set ℕ) (h3 : 3 ∈ D) (h11 : 11 ∈ D) :
    let W := classesOfRadicands (insert 2 D)
    let A := fieldOfClasses (W ⊓ spanThreeTwo.comap twoAdic)
    let B := fieldOfClasses (W ⊓ spanThreeTen.comap twoAdic)
    (seamField ≤ A ∧ seamField ≤ B) ∧
      (A ≤ fieldOfRadicands (insert 2 D) ∧ B ≤ fieldOfRadicands (insert 2 D)) ∧
      fieldOfRadicands D ≤ A ⊔ B ∧
      (4 ≤ ((unitDistance ℂ).induce (planeOver A)).chromaticNumber ∧
        4 ≤ ((unitDistance ℂ).induce (planeOver B)).chromaticNumber) ∧
      (TwoAdicSqClass.minusOne ∉ (W ⊓ spanThreeTwo.comap twoAdic).map twoAdic ∧
        TwoAdicSqClass.minusOne ∉ (W ⊓ spanThreeTen.comap twoAdic).map twoAdic) := by
  intro W A B
  have h3' : 3 ∈ insert 2 D := Set.mem_insert_of_mem 2 h3
  have h11' : 11 ∈ insert 2 D := Set.mem_insert_of_mem 2 h11
  have hT : TwoAdicSqClass.three ∈ spanThreeTwo := Submodule.subset_span (Set.mem_insert _ _)
  have hT' : TwoAdicSqClass.three ∈ spanThreeTen := Submodule.subset_span (Set.mem_insert _ _)
  exact ⟨⟨seamField_le_fieldOfClasses_inf_comap h3' h11' hT, seamField_le_fieldOfClasses_inf_comap h3' h11' hT'⟩,
    ⟨fieldOfClasses_inf_comap_le_fieldOfRadicands _ _, fieldOfClasses_inf_comap_le_fieldOfRadicands _ _⟩,
    fieldOfRadicands_le_sup D,
    ⟨four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap h3 h11 hT,
      four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap h3 h11 hT'⟩,
    ⟨minusOne_not_mem_map_inf_comap minusOne_not_mem_spanThreeTwo W,
      minusOne_not_mem_map_inf_comap minusOne_not_mem_spanThreeTen W⟩⟩

/-! ## §8 De Grey's field, worked -/

/-- `10 = 2 · 5` has the 2-adic class `[2] + [5] = [10]`. -/
private theorem twoAdic_sqClass_ten : twoAdic (sqClass 10) = TwoAdicSqClass.ten := by
  rw [show (10 : ℕ) = 2 * 5 from rfl, sqClass_mul (by norm_num) (by norm_num), map_add,
    twoAdic_sqClass_prime Nat.prime_two, twoAdic_sqClass_prime Nat.prime_five]
  decide

/-- `35 = 5 · 7` has the 2-adic class `[5] + [−1] = [3]`. -/
private theorem twoAdic_sqClass_thirtyFive : twoAdic (sqClass 35) = TwoAdicSqClass.three := by
  rw [show (35 : ℕ) = 5 * 7 from rfl, sqClass_mul (by norm_num) (by norm_num), map_add,
    twoAdic_sqClass_prime Nat.prime_five, twoAdic_sqClass_prime (by norm_num : Nat.Prime 7)]
  decide

/-- **De Grey's field `ℚ(√3, √5, √7, √11)` lies in `ℚ(√2, √3, √11, √35) · ℚ(√3, √10, √11, √35)`** — the handoff's
worked example, checked directly by `2 · 10 = 2² · 5` and `35 · 5 = 5² · 7` (`sqrt_mem_of_mul_eq_sq_mul`). -/
theorem fieldOfRadicands_deGrey_le_sup :
    fieldOfRadicands {3, 5, 7, 11} ≤ fieldOfRadicands {2, 3, 11, 35} ⊔ fieldOfRadicands {3, 10, 11, 35} := by
  have hA : ∀ {d : ℕ}, d ∈ ({2, 3, 11, 35} : Set ℕ) →
      Real.sqrt d ∈ fieldOfRadicands {2, 3, 11, 35} ⊔ fieldOfRadicands {3, 10, 11, 35} :=
    fun hd => le_sup_left (a := fieldOfRadicands {2, 3, 11, 35}) (sqrt_mem_fieldOfRadicands hd)
  have hB : ∀ {d : ℕ}, d ∈ ({3, 10, 11, 35} : Set ℕ) →
      Real.sqrt d ∈ fieldOfRadicands {2, 3, 11, 35} ⊔ fieldOfRadicands {3, 10, 11, 35} :=
    fun hd => le_sup_right (b := fieldOfRadicands {3, 10, 11, 35}) (sqrt_mem_fieldOfRadicands hd)
  have h5 := sqrt_mem_of_mul_eq_sq_mul (a := 2) (b := 10) (c := 5) (s := 2) (by norm_num) (by norm_num)
    (hA (by simp)) (hB (by simp))
  have h7 := sqrt_mem_of_mul_eq_sq_mul (a := 35) (b := 5) (c := 7) (s := 5) (by norm_num) (by norm_num)
    (hA (by simp)) h5
  refine Subfield.closure_le.mpr ?_
  rintro _ ⟨d, hd, rfl⟩
  rcases hd with rfl | rfl | rfl | rfl
  · exact hA (by simp)
  · exact h5
  · exact h7
  · exact hA (by simp)

/-- The 2-adic classes of `2, 3, 11, 35` lie in `spanThreeTwo`, so `ℚ(√2, √3, √11, √35)` passes the test. -/
theorem map_twoAdic_deGreyTwo_le : (classesOfRadicands {2, 3, 11, 35}).map twoAdic ≤ spanThreeTwo := by
  refine map_twoAdic_classesOfRadicands_le_iff.mpr ?_
  rintro d (rfl | rfl | rfl | rfl)
  · rw [twoAdic_sqClass_prime Nat.prime_two]
    simp only [spanThreeTwo, Submodule.mem_span_pair]; decide
  · rw [twoAdic_sqClass_three]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [twoAdic_sqClass_eleven]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [twoAdic_sqClass_thirtyFive]; exact Submodule.subset_span (Set.mem_insert _ _)

/-- The 2-adic classes of `3, 10, 11, 35` lie in `spanThreeTen`, so `ℚ(√3, √10, √11, √35)` passes the test. -/
theorem map_twoAdic_deGreyTen_le : (classesOfRadicands {3, 10, 11, 35}).map twoAdic ≤ spanThreeTen := by
  refine map_twoAdic_classesOfRadicands_le_iff.mpr ?_
  rintro d (rfl | rfl | rfl | rfl)
  · rw [twoAdic_sqClass_three]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [twoAdic_sqClass_ten]; exact Submodule.subset_span (Set.mem_insert_of_mem _ (Set.mem_singleton _))
  · rw [twoAdic_sqClass_eleven]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [twoAdic_sqClass_thirtyFive]; exact Submodule.subset_span (Set.mem_insert _ _)

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
example : sqClass 12 = sqClass 3 := by
  rw [show (12 : ℕ) = 2 ^ 2 * 3 from rfl, sqClass_mul (by norm_num) (by norm_num), sqClass_sq, zero_add]

/-- `35 = 5 · 7` has the 2-adic class `[5] + [−1] = [3]`. -/
example : twoAdic (sqClass 35) = TwoAdicSqClass.three := twoAdic_sqClass_thirtyFive

/-- `[6] = [3] + [2]` lies in `spanThreeTwo`; `[10]` does not. -/
example : TwoAdicSqClass.three + TwoAdicSqClass.two ∈ spanThreeTwo ∧ TwoAdicSqClass.ten ∉ spanThreeTwo := by
  simp only [spanThreeTwo, Submodule.mem_span_pair]; decide

/-- `√5 = √2 · √10 / 2`, so `√5 ∈ ℚ(√2, √10)`. -/
example : Real.sqrt 5 ∈ fieldOfRadicands {2, 10} := by
  simpa using sqrt_mem_of_mul_eq_sq_mul (F := fieldOfRadicands {2, 10}) (a := 2) (b := 10) (c := 5) (s := 2)
    (by norm_num) (by norm_num) (sqrt_mem_fieldOfRadicands (by simp)) (sqrt_mem_fieldOfRadicands (by simp))

example : (⟨Real.sqrt 3, 1⟩ : ℂ) ∈ planeOver seamField := mem_planeOver.mpr ⟨FieldWall4.sqrt3_mem, one_mem _⟩

/-- Both pieces of `D ∪ {2}` lie inside the field of `D ∪ {2}` — the handoff's `A, B ⊆ F(√2)`. -/
example (D : Set ℕ) :
    fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTwo.comap twoAdic) ≤ fieldOfRadicands (insert 2 D) ∧
      fieldOfClasses (classesOfRadicands (insert 2 D) ⊓ spanThreeTen.comap twoAdic) ≤
        fieldOfRadicands (insert 2 D) :=
  ⟨fieldOfClasses_inf_comap_le_fieldOfRadicands _ _, fieldOfClasses_inf_comap_le_fieldOfRadicands _ _⟩

/-- **Red: `[2]` is load-bearing in the splitting.** Without `√2`, the classes of `ℚ(√7)` have both pieces trivial:
`[7] = [−1]` lies in neither span. -/
example : (classesOfRadicands {7} ⊓ spanThreeTwo.comap twoAdic) ⊔ (classesOfRadicands {7} ⊓ spanThreeTen.comap twoAdic)
    ≠ classesOfRadicands {7} := by
  have hbot : ∀ U : Submodule (ZMod 2) TwoAdicSqClass, TwoAdicSqClass.minusOne ∉ U →
      classesOfRadicands {7} ⊓ U.comap twoAdic = ⊥ := by
    intro U hU
    refine (Submodule.eq_bot_iff _).mpr fun x hx => ?_
    obtain ⟨hxW, hxU⟩ := Submodule.mem_inf.mp hx
    rw [classesOfRadicands, Set.image_singleton, Submodule.mem_span_singleton] at hxW
    obtain ⟨c, rfl⟩ := hxW
    rcases (by decide : ∀ c : ZMod 2, c = 0 ∨ c = 1) c with rfl | rfl
    · exact zero_smul _ _
    · refine absurd ?_ hU
      have h7 : twoAdicOfPrime 7 = TwoAdicSqClass.minusOne := by decide
      rw [Submodule.mem_comap, one_smul, twoAdic_sqClass_prime (by norm_num), h7] at hxU
      exact hxU
  intro h
  rw [hbot _ minusOne_not_mem_spanThreeTwo, hbot _ minusOne_not_mem_spanThreeTen, bot_sup_eq] at h
  have h7 : sqClass 7 ∈ classesOfRadicands {7} := Submodule.subset_span (Set.mem_image_of_mem sqClass rfl)
  rw [← h, Submodule.mem_bot, sqClass_prime (by norm_num)] at h7
  exact Finsupp.single_ne_zero.mpr one_ne_zero h7

/-- **Red: the lifting lemma's hypothesis is load-bearing.** In `𝔽₂²` with `f = id`, the diagonal meets both axes in
`0`. -/
example : ¬ (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ≤
    (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓
        Submodule.span (ZMod 2) {((1 : ZMod 2), (0 : ZMod 2))}) ⊔
      (Submodule.span (ZMod 2) {((1 : ZMod 2), (1 : ZMod 2))} ⊓
        Submodule.span (ZMod 2) {((0 : ZMod 2), (1 : ZMod 2))})) := by
  intro h
  obtain ⟨y, hy, z, hz, hyz⟩ := Submodule.mem_sup.mp (h (Submodule.subset_span (Set.mem_singleton _)))
  simp only [Submodule.mem_inf, Submodule.mem_span_singleton] at hy hz
  obtain ⟨⟨a, rfl⟩, ⟨b, hb⟩⟩ := hy
  obtain ⟨⟨c, rfl⟩, ⟨d, hd⟩⟩ := hz
  revert a b c d
  decide

end Spec

end SquareClass

end HadwigerNelson
