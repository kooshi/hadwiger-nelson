import Proofs.HadwigerNelson.Rigidity.SqrtClassFive
import Proofs.HadwigerNelson.Instances.UpperHalfValues

/-!
# The five-colour instances after `ℚ(√47)`: `ℚ(√143)`, `ℚ(√311)`, `ℚ(√335)`, `ℚ(√3, √5)`, and `ℚ(√167) ≥ 5` (FS-131, job FS131-KM15; module M15)

**Read aloud, against the informal claim** (`data/fs131/claims-NF2.md`, NF2-LEAF-23: "Then `ℚ(√143)`, `ℚ(√311)`,
`ℚ(√335)` (D:275), `ℚ(√3,√5)` (D:301), `ℚ(√167) ≥ 5` (D:279)"). Given `[AmbrusEtAl2023]` Theorem 1 as printed
(`Plane.OneAvoidingDensityBound`):

* **`χ(ℚ(√143)²) = 5`**, **`χ(ℚ(√311)²) = 5`**, **`χ(ℚ(√335)²) = 5`**: each radicand is in D:116's class
  (`143 ≡ 143`, `311 ≡ 143`, `335 ≡ 167 (mod 168)`), so `L ≥ 5` (`Rigidity.five_le_localBound_of_isSquare_class`) and
  `χ ≥ 5` (`Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound`); the upper half is the residue plane at 11
  (`311 ≡ 5²`, `335 ≡ 4² (mod 11)`; `11 ∣ 143` once, the ramified prime), five-colourable
  (`finitePlane11_colorable_five`).
* **`χ(ℚ(√3, √5)²) = 5`**: the three radicands of `Rigidity.five_le_localBound_of_isSquare` are `15 = 3·5`
  (`≡ 7 mod 8`), `5` (`≡ 2 mod 3`) and `3` (a non-square mod 7); the upper half at 11 (`3 ≡ 5²`, `5 ≡ 4²`).
* **`χ(ℚ(√167)²) ≥ 5`** (`167 ≡ 167 (mod 168)`); the kernel's upper bound there is 8
  (`UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight`).

**Not claimed:** any value of `L` at these fields; `χ(ℚ(√167)²) ≥ 6` (the conjecture's prediction there); that any value
is new mathematics (`CLAUDE.md` § The local–global conjecture: these are its exposed predictions, met at [hand] through MR).

**What rests on what:** the lower bounds rest on the chain's headline and `Rigidity.ratioAtMost_two_notMem_link`, as
`χ(ℚ(√47)²) = 5` does; the upper bounds on the standard three axioms.

**Inhabitants.** `hOA` is an outside theorem (`Plane.oneAvoidingDensityBound_model` models its clause). Every other
statement is closed.
-/

namespace HadwigerNelson.SqrtClassValues

open SpectralChain NumberField SimpleGraph SquareClass UpperHalf

/-- **A radicand is a square in its field of square roots.** -/
theorem isSquare_radicand {D : Set ℕ} {d : ℕ} (hd : d ∈ D) : IsSquare ((d : ℕ) : fieldOfRadicands D) :=
  ⟨⟨Real.sqrt d, sqrt_mem_fieldOfRadicands hd⟩,
    Subtype.ext (by push_cast; exact (Real.mul_self_sqrt (Nat.cast_nonneg d)).symm)⟩

/-! ### `ℚ(√143)` -/

/-- `5 ≤ L(ℚ(√143))`. -/
theorem five_le_localBound_sqrt143 : 5 ≤ localBound (fieldOfRadicands {143}) :=
  Rigidity.five_le_localBound_of_isSquare_class _ (isSquare_radicand rfl) (by norm_num)

/-- `χ(ℚ(√143)²) ≤ 5`: the prime above 11, ramified (`11 ∣ 143` once), with residue field `𝔽₁₁`. -/
theorem chromaticNumber_planeOver_sqrt143_le_five :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {143}))).chromaticNumber ≤ 5 := by
  obtain ⟨𝔭, hmax, hcard⟩ := QuadraticPrime.exists_maximal_card_eq_of_ramified ∅ 143 (p := 11) (by norm_num)
    (by norm_num) (by simp) (by norm_num) (by norm_num)
  rw [show ({143} : Set ℕ) = insert 143 ∅ from (insert_empty_eq 143).symm]
  exact (colorable_planeOver_of_finitePlane _ ⟨hmax, by rw [hcard]⟩ (by norm_num) hcard
    finitePlane11_colorable_five).chromaticNumber_le

/-- **`χ(ℚ(√143)²) = 5`**, given `[AmbrusEtAl2023]` Theorem 1 as printed. -/
theorem chromaticNumber_planeOver_sqrt143_eq_five (hOA : Plane.OneAvoidingDensityBound) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {143}))).chromaticNumber = 5 :=
  le_antisymm chromaticNumber_planeOver_sqrt143_le_five
    (Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound _ hOA five_le_localBound_sqrt143)

/-! ### `ℚ(√311)` and `ℚ(√335)` -/

/-- **`χ(ℚ(√311)²) = 5`**, given `[AmbrusEtAl2023]` Theorem 1 as printed; the upper half at 11 (`311 ≡ 5²`). -/
theorem chromaticNumber_planeOver_sqrt311_eq_five (hOA : Plane.OneAvoidingDensityBound) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {311}))).chromaticNumber = 5 :=
  le_antisymm
    (colorable_planeOver_fieldOfRadicands {311} (p := 11) (by norm_num) (by norm_num)
      (by rintro d rfl; exact ⟨by decide, ⟨5, by decide⟩⟩) finitePlane11_colorable_five).chromaticNumber_le
    (Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound _ hOA
      (Rigidity.five_le_localBound_of_isSquare_class _ (isSquare_radicand rfl) (by norm_num)))

/-- **`χ(ℚ(√335)²) = 5`**, given `[AmbrusEtAl2023]` Theorem 1 as printed; the upper half at 11 (`335 ≡ 4²`). -/
theorem chromaticNumber_planeOver_sqrt335_eq_five (hOA : Plane.OneAvoidingDensityBound) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {335}))).chromaticNumber = 5 :=
  le_antisymm
    (colorable_planeOver_fieldOfRadicands {335} (p := 11) (by norm_num) (by norm_num)
      (by rintro d rfl; exact ⟨by decide, ⟨4, by decide⟩⟩) finitePlane11_colorable_five).chromaticNumber_le
    (Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound _ hOA
      (Rigidity.five_le_localBound_of_isSquare_class _ (isSquare_radicand rfl) (by norm_num)))

/-! ### `ℚ(√3, √5)` -/

/-- `5 ≤ L(ℚ(√3, √5))`: the radicands `15 = 3·5`, `5` and `3`. -/
theorem five_le_localBound_sqrt3_sqrt5 : 5 ≤ localBound (fieldOfRadicands {3, 5}) := by
  obtain ⟨r3, h3⟩ := isSquare_radicand (D := {3, 5}) (d := 3) (by simp)
  obtain ⟨r5, h5⟩ := isSquare_radicand (D := {3, 5}) (d := 5) (by simp)
  have h15 : IsSquare ((15 : ℕ) : fieldOfRadicands {3, 5}) :=
    ⟨r3 * r5, by
      have e : ((15 : ℕ) : fieldOfRadicands {3, 5}) = ((3 : ℕ) : fieldOfRadicands {3, 5}) * ((5 : ℕ) : _) := by
        push_cast; norm_num
      rw [e, h3, h5]
      ring⟩
  exact Rigidity.five_le_localBound_of_isSquare _ h15 (by norm_num) (isSquare_radicand (D := {3, 5}) (d := 5) (by simp))
    (by norm_num)
    (isSquare_radicand (D := {3, 5}) (d := 3) (by simp)) (by norm_num)

/-- **`χ(ℚ(√3, √5)²) = 5`**, given `[AmbrusEtAl2023]` Theorem 1 as printed; the upper half at 11. -/
theorem chromaticNumber_planeOver_sqrt3_sqrt5_eq_five (hOA : Plane.OneAvoidingDensityBound) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3, 5}))).chromaticNumber = 5 :=
  le_antisymm
    (colorable_planeOver_fieldOfRadicands {3, 5} (p := 11) (by norm_num) (by norm_num)
      (by
        rintro d (rfl | rfl)
        · exact ⟨by decide, ⟨5, by decide⟩⟩
        · exact ⟨by decide, ⟨4, by decide⟩⟩) finitePlane11_colorable_five).chromaticNumber_le
    (Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound _ hOA five_le_localBound_sqrt3_sqrt5)

/-! ### `ℚ(√167)` -/

/-- **`χ(ℚ(√167)²) ≥ 5`**, given `[AmbrusEtAl2023]` Theorem 1 as printed. -/
theorem five_le_chromaticNumber_planeOver_sqrt167 (hOA : Plane.OneAvoidingDensityBound) :
    5 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {167}))).chromaticNumber :=
  Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound _ hOA
    (Rigidity.five_le_localBound_of_isSquare_class _ (isSquare_radicand rfl) (by norm_num))

/-! ## Spec -/

-- The radicands' residues: `143`, `311`, `335`, `167` modulo 168, and the squares modulo 11 the upper halves read.
example : 143 % 168 = 143 ∧ 311 % 168 = 143 ∧ 335 % 168 = 167 ∧ 167 % 168 = 167 := by decide
example : (311 : ZMod 11) = 5 ^ 2 ∧ (335 : ZMod 11) = 4 ^ 2 ∧ (3 : ZMod 11) = 5 ^ 2 ∧ (5 : ZMod 11) = 4 ^ 2 := by decide
-- `ℚ(√3, √5)`'s three radicands: `15 ≡ 7 (mod 8)`, `5 ≡ 2 (mod 3)`, `3` a non-square mod 7.
example : 15 % 8 = 7 ∧ 5 % 3 = 2 ∧ 3 % 7 = 3 ∧ ¬ IsSquare (3 : ZMod 7) := by decide
-- `isSquare_radicand` at its smallest case: `1` is a square in `ℚ(√1) = ℚ`.
example : IsSquare ((1 : ℕ) : fieldOfRadicands {1}) := isSquare_radicand rfl

end HadwigerNelson.SqrtClassValues
