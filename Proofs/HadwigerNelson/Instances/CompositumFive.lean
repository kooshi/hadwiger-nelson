import Proofs.HadwigerNelson.SquareClass
import Proofs.HadwigerNelson.Instances.FinitePlane11

/-!
# Two fields that pass the four-colour test, whose compositum's plane needs five colours

FS-36 Phase C (`plans/FS36-multiquadratic-decomposition.md` §8): the handoff's item 2
(`reference/ChatGPT-multiquadratic/handoff.md` §4) in the kernel.

`ℚ(√3, √11, √14)` and `ℚ(√3, √11, √70)` both pass the 2-adic four-colour test: the 2-adic images of their square
classes lie in `{1, 3, 10, 14}` and in `{1, 3, 2, 6}`, neither of which holds `[−1]` (`map_twoAdic_fourteen_le`,
`map_twoAdic_seventy_le`). Their compositum holds `√5`, since `14 · 70 = 14² · 5`
(`sqrt_five_mem_fourteen_sup_seventy`). Heule-510's coordinates lie in `ℚ(√3, √5, √11)`, so it draws in the plane
over the compositum, which therefore needs five colours (`five_le_chromaticNumber_planeOver_fourteen_sup_seventy`).

## What it says about combining rules

`SquareClass.fieldOfRadicands_le_sup` puts every real multiquadratic field, once `√2` is adjoined, inside the
compositum of two fields that pass the test. So a rule "`χ(A²), χ(B²) ≤ 4` implies `χ((AB)²) ≤ c`", for test-passing
`A` and `B`, would bound every multiquadratic plane by `c`. This file shows that such a rule needs `c ≥ 5`.

## What is not proved here

That either factor's plane is 4-colourable: that is the test at the field level (FS-37). The kernel holds `χ ≥ 4`
for each factor (`four_le_chromaticNumber_planeOver`) and `χ ≥ 5` for the compositum, not `χ = 4` for the factors.
-/

namespace HadwigerNelson

open SimpleGraph SquareClass

-- `Adjoin.eval`'s defining equation, restated locally for the reason `SeamCert.lean`'s private copy gives: the
-- lemma belongs in `Field/Quadratic.lean`, whose declarations have ~1,500 transitive dependents.
private theorem eval_mk {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} (evalBase : K →+* ℝ)
    (r : ℝ) (hr : r ^ 2 = d) (x : Adjoin d K) :
    Adjoin.eval evalBase r hr x = evalBase x.re + evalBase x.im * r := rfl

/-- **A `√7`-free element of the tower evaluates into every real field holding `√3`, `√5` and `√11`.** -/
theorem Q4.eval_mem_of_mem_sevenFree {F : Subfield ℝ} (h3 : Real.sqrt 3 ∈ F) (h5 : Real.sqrt 5 ∈ F)
    (h11 : Real.sqrt 11 ∈ F) {x : Q4} (hx : x ∈ Q4.sevenFree) : Q4.eval x ∈ F := by
  obtain ⟨h1, h2⟩ := hx
  simp only [Q4.eval, eval_mk, h1, h2, map_zero, zero_mul, add_zero, Int.coe_castRingHom]
  repeat' first
    | exact h3
    | exact h5
    | exact h11
    | exact intCast_mem F _
    | apply add_mem
    | apply mul_mem

namespace UDCert

variable {n : ℕ}

/-- **Every point of a `√7`-free certificate lies in the plane over any real field holding `√3`, `√5` and `√11`.**
Inhabited by Heule-510 in `five_le_chromaticNumber_planeOver_fourteen_sup_seventy`. -/
theorem point_mem_planeOver_of_sevenFree (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {F : Subfield ℝ}
    (h3 : Real.sqrt 3 ∈ F) (h5 : Real.sqrt 5 ∈ F) (h11 : Real.sqrt 11 ∈ F) (i : Fin n) :
    c.point i ∈ planeOver F := by
  have hD : (c.denom : ℝ) ∈ F := by simp
  exact mem_planeOver.mpr ⟨div_mem (Q4.eval_mem_of_mem_sevenFree h3 h5 h11 (hS i).1) hD,
    div_mem (Q4.eval_mem_of_mem_sevenFree h3 h5 h11 (hS i).2) hD⟩

/-- **A valid `√7`-free certificate bounds the plane over any real field holding `√3`, `√5` and `√11` from below.**
Inhabited by Heule-510 in `five_le_chromaticNumber_planeOver_fourteen_sup_seventy`. -/
theorem chromaticNumber_le_planeOver_of_sevenFree (c : UDCert n) (hd : c.denom ≠ 0) (hv : c.Valid = true)
    (hS : c.CoordsIn Q4.sevenFree) {F : Subfield ℝ} (h3 : Real.sqrt 3 ∈ F) (h5 : Real.sqrt 5 ∈ F)
    (h11 : Real.sqrt 11 ∈ F) :
    (edgeGraph n c.edges).chromaticNumber ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have hunit := c.valid_sound hd hv
  refine chromaticNumber_mono_of_hom ⟨fun i => ⟨c.point i, c.point_mem_planeOver_of_sevenFree hS h3 h5 h11 i⟩, ?_⟩
  rintro i j ⟨-, hm | hm⟩
  · exact unitDistance_adj.mpr (hunit (i, j) hm)
  · exact unitDistance_adj.mpr (by rw [dist_comm]; exact hunit (j, i) hm)

end UDCert

/-- **`ℚ(√3, √11, √14)` passes the four-colour test**: the 2-adic classes `[3]`, `[3]` and `[14] = [2] + [−1]` lie in
`{1, 3, 10, 14}`. -/
theorem map_twoAdic_fourteen_le : (classesOfRadicands {3, 11, 14}).map twoAdic ≤ spanThreeTen := by
  refine map_twoAdic_classesOfRadicands_le_iff.mpr ?_
  rintro d (rfl | rfl | rfl)
  · rw [twoAdic_sqClass_three]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [twoAdic_sqClass_eleven]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [show (14 : ℕ) = 2 * 7 from rfl, sqClass_mul (by norm_num) (by norm_num), map_add,
      twoAdic_sqClass_prime Nat.prime_two, twoAdic_sqClass_prime (by norm_num : Nat.Prime 7)]
    simp only [spanThreeTen, Submodule.mem_span_pair]; decide

/-- **`ℚ(√3, √11, √70)` passes the four-colour test**: `[70] = [2] + [5] + [−1] = [6]`, and `[3]`, `[6]` lie in
`{1, 3, 2, 6}`. -/
theorem map_twoAdic_seventy_le : (classesOfRadicands {3, 11, 70}).map twoAdic ≤ spanThreeTwo := by
  refine map_twoAdic_classesOfRadicands_le_iff.mpr ?_
  rintro d (rfl | rfl | rfl)
  · rw [twoAdic_sqClass_three]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [twoAdic_sqClass_eleven]; exact Submodule.subset_span (Set.mem_insert _ _)
  · rw [show (70 : ℕ) = 2 * 35 from rfl, sqClass_mul (by norm_num) (by norm_num), map_add,
      show (35 : ℕ) = 5 * 7 from rfl, sqClass_mul (by norm_num) (by norm_num), map_add,
      twoAdic_sqClass_prime Nat.prime_two, twoAdic_sqClass_prime Nat.prime_five,
      twoAdic_sqClass_prime (by norm_num : Nat.Prime 7)]
    simp only [spanThreeTwo, Submodule.mem_span_pair]; decide

/-- **The compositum holds `√5`**: `14 · 70 = 14² · 5`. -/
theorem sqrt_five_mem_fourteen_sup_seventy :
    Real.sqrt 5 ∈ fieldOfRadicands {3, 11, 14} ⊔ fieldOfRadicands {3, 11, 70} := by
  simpa using sqrt_mem_of_mul_eq_sq_mul (a := 14) (b := 70) (c := 5) (s := 14) (by norm_num) (by norm_num)
    (le_sup_left (a := fieldOfRadicands {3, 11, 14}) (sqrt_mem_fieldOfRadicands (by simp)))
    (le_sup_right (b := fieldOfRadicands {3, 11, 70}) (sqrt_mem_fieldOfRadicands (by simp)))

/-- **Two fields that pass the four-colour test, whose compositum's plane needs five colours**: Heule-510 draws in
the plane over `ℚ(√3, √11, √14) · ℚ(√3, √11, √70)`. With `map_twoAdic_fourteen_le` and `map_twoAdic_seventy_le`, a
combining rule "`χ(A²), χ(B²) ≤ 4` implies `χ((AB)²) ≤ c`" for test-passing fields needs `c ≥ 5`. **Not proved
here:** that either factor's plane is 4-colourable (FS-37). -/
theorem five_le_chromaticNumber_planeOver_fourteen_sup_seventy :
    5 ≤ ((unitDistance ℂ).induce
      (planeOver (fieldOfRadicands {3, 11, 14} ⊔ fieldOfRadicands {3, 11, 70}))).chromaticNumber := by
  have h3 : Real.sqrt 3 ∈ fieldOfRadicands {3, 11, 14} ⊔ fieldOfRadicands {3, 11, 70} :=
    le_sup_left (a := fieldOfRadicands {3, 11, 14})
      (by simpa using sqrt_mem_fieldOfRadicands (D := {3, 11, 14}) (d := 3) (by simp))
  have h11 : Real.sqrt 11 ∈ fieldOfRadicands {3, 11, 14} ⊔ fieldOfRadicands {3, 11, 70} :=
    le_sup_left (a := fieldOfRadicands {3, 11, 14})
      (by simpa using sqrt_mem_fieldOfRadicands (D := {3, 11, 14}) (d := 11) (by simp))
  calc (5 : ℕ∞) = (edgeGraph 510 heule510.edges).chromaticNumber := chromaticNumber_heule510.symm
    _ ≤ _ := heule510.chromaticNumber_le_planeOver_of_sevenFree (by decide) heule510_valid
        heule510_coordsIn_sevenFree h3 sqrt_five_mem_fourteen_sup_seventy h11

/-- Both factors pass the four-colour test. -/
example : TwoAdicSqClass.minusOne ∉ (classesOfRadicands {3, 11, 14}).map twoAdic ∧
    TwoAdicSqClass.minusOne ∉ (classesOfRadicands {3, 11, 70}).map twoAdic :=
  ⟨fun h => minusOne_not_mem_spanThreeTen (map_twoAdic_fourteen_le h),
    fun h => minusOne_not_mem_spanThreeTwo (map_twoAdic_seventy_le h)⟩

end HadwigerNelson
