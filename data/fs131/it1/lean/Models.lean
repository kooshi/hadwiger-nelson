import Proofs.HadwigerNelson.Arith.TorsionExtraction
/-!
FS131-IT1 — the hypotheses of `Arith/TorsionExtraction` at models, and where its `sorryAx` comes from; from the compiled
module (run after the build): `lake env lean data/fs131/it1/lean/Models.lean`. Never part of the library.

1. `layer_step` at a rotation step and at a corner step: each disjunct of its conclusion occurs.
2. `layer_dichotomy` at the zero orbit (every step a rotation) and at the corner orbit `z_m = iᵐ·(−1/6 − i/6)`.
3. The headlines' hypotheses at `F = ℚ(√11)`: `1/3 ∈ ℤ[U_F]` and no two-colouring, together.
4. `1/3 ∈ ℤ[U_F]` at `F = ℚ(√2)`, a field whose plane is two-colourable (the upper half's theorem, another module's):
   the one kind of field at which `colorable_two_of_inv_three_mem` and `mem_fieldBandSet_two_of_inv_three_mem` have all
   their hypotheses at once.
5. The compositions with the upstream leaf `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` taken as a
   hypothesis: on the standard three — so the `sorryAx` the five compositions print in this tree is that leaf's.
-/
open HadwigerNelson HadwigerNelson.TorsionExtraction HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain
  HadwigerNelson.SquareClass SimpleGraph

namespace FS131IT1Models

/-! ## 1. `layer_step` -/

/-- A rotation step: `(a, b) = (1/12, 0)`, `(a', b') = (1/20, −1/15)`; both forms are `0`. -/
theorem layer_step_rotation :
    ((1 / 20 : ℝ) = (3 * (1 / 12) + 4 * 0) / 5 ∧ (-(1 / 15) : ℝ) = (-4 * (1 / 12) + 3 * 0) / 5) ∨
      (|(1 / 12 : ℝ)| = 1 / 6 ∧ |(0 : ℝ)| = 1 / 6 ∧ |(1 / 20 : ℝ)| = 1 / 6 ∧ |(-(1 / 15) : ℝ)| = 1 / 6) :=
  layer_step (abs_le.mpr ⟨by norm_num, by norm_num⟩) (abs_le.mpr ⟨by norm_num, by norm_num⟩)
    (abs_le.mpr ⟨by norm_num, by norm_num⟩) (abs_le.mpr ⟨by norm_num, by norm_num⟩) ⟨0, by norm_num⟩ ⟨0, by norm_num⟩

/-- …and there the second disjunct fails: the step is a rotation and not a corner step. -/
theorem layer_step_rotation_not_corner : ¬ |(1 / 12 : ℝ)| = 1 / 6 := by
  rw [abs_of_pos (by norm_num)]
  norm_num

/-- A corner step: `(a, b) = (−1/6, −1/6)`, `(a', b') = (1/6, −1/6)` (`z' = i z`); the forms are `1` and `0`. -/
theorem layer_step_corner :
    ((1 / 6 : ℝ) = (3 * (-(1 / 6)) + 4 * (-(1 / 6))) / 5 ∧ (-(1 / 6) : ℝ) = (-4 * (-(1 / 6)) + 3 * (-(1 / 6))) / 5) ∨
      (|(-(1 / 6) : ℝ)| = 1 / 6 ∧ |(-(1 / 6) : ℝ)| = 1 / 6 ∧ |(1 / 6 : ℝ)| = 1 / 6 ∧ |(-(1 / 6) : ℝ)| = 1 / 6) :=
  layer_step (abs_le.mpr ⟨by norm_num, by norm_num⟩) (abs_le.mpr ⟨by norm_num, by norm_num⟩)
    (abs_le.mpr ⟨by norm_num, by norm_num⟩) (abs_le.mpr ⟨by norm_num, by norm_num⟩) ⟨1, by norm_num⟩ ⟨0, by norm_num⟩

/-- …and there the first disjunct fails: `1/6 ≠ −7/30`. -/
theorem layer_step_corner_not_rotation : ¬ (1 / 6 : ℝ) = (3 * (-(1 / 6)) + 4 * (-(1 / 6))) / 5 := by norm_num

/-! ## 2. `layer_dichotomy` -/

/-- The zero orbit: every hypothesis holds, and the first disjunct is the one that does. -/
theorem layer_dichotomy_zero :
    (∀ m : ℤ, (0 : ℝ) = (3 * 0 + 4 * 0) / 5 ∧ (0 : ℝ) = (-4 * 0 + 3 * 0) / 5) ∨
      (∀ _ : ℤ, |(0 : ℝ)| = 1 / 6 ∧ |(0 : ℝ)| = 1 / 6) :=
  layer_dichotomy (a := fun _ => 0) (b := fun _ => 0) (fun _ => by norm_num) (fun _ => by norm_num)
    (fun _ => ⟨0, by norm_num⟩) (fun _ => ⟨0, by norm_num⟩)

/-- The first coordinate of the corner orbit `z_m = iᵐ·(−1/6 − i/6)`: `−, +, +, −` with period 4. -/
noncomputable def cornerA (m : ℤ) : ℝ := if m % 4 = 0 ∨ m % 4 = 3 then -(1 / 6) else 1 / 6

/-- Its second coordinate: `−, −, +, +`. -/
noncomputable def cornerB (m : ℤ) : ℝ := if m % 4 = 0 ∨ m % 4 = 1 then -(1 / 6) else 1 / 6

/-- The corner orbit satisfies every hypothesis of `layer_dichotomy`, and is at a corner throughout: the second
disjunct occurs. -/
theorem layer_dichotomy_corner :
    (∀ m, |cornerA m| ≤ 1 / 6) ∧ (∀ m, |cornerB m| ≤ 1 / 6) ∧
      (∀ m, ∃ n : ℤ, 2 * cornerA (m + 1) - cornerB (m + 1) - 2 * cornerA m - cornerB m = n) ∧
      (∀ m, ∃ n : ℤ, cornerA (m + 1) + 2 * cornerB (m + 1) + cornerA m - 2 * cornerB m = n) ∧
      (∀ m, |cornerA m| = 1 / 6 ∧ |cornerB m| = 1 / 6) ∧
      ¬ ∀ m, cornerA (m + 1) = (3 * cornerA m + 4 * cornerB m) / 5 ∧
        cornerB (m + 1) = (-4 * cornerA m + 3 * cornerB m) / 5 := by
  have habs : ∀ m, |cornerA m| = 1 / 6 ∧ |cornerB m| = 1 / 6 := by
    intro m
    constructor
    · unfold cornerA
      split_ifs
      · rw [abs_neg, abs_of_pos (by norm_num)]
      · rw [abs_of_pos (by norm_num)]
    · unfold cornerB
      split_ifs
      · rw [abs_neg, abs_of_pos (by norm_num)]
      · rw [abs_of_pos (by norm_num)]
  have hcases : ∀ m : ℤ, (m % 4 = 0 ∧ (m + 1) % 4 = 1) ∨ (m % 4 = 1 ∧ (m + 1) % 4 = 2) ∨ (m % 4 = 2 ∧ (m + 1) % 4 = 3) ∨
      (m % 4 = 3 ∧ (m + 1) % 4 = 0) := fun m => by omega
  refine ⟨fun m => (habs m).1.le, fun m => (habs m).2.le, fun m => ?_, fun m => ?_, habs, fun h => ?_⟩
  · rcases hcases m with ⟨h, h'⟩ | ⟨h, h'⟩ | ⟨h, h'⟩ | ⟨h, h'⟩
    · exact ⟨1, by simp [cornerA, cornerB, h, h']; norm_num⟩
    · exact ⟨0, by simp [cornerA, cornerB, h, h']; norm_num⟩
    · exact ⟨-1, by simp [cornerA, cornerB, h, h']; norm_num⟩
    · exact ⟨0, by simp [cornerA, cornerB, h, h']; norm_num⟩
  · rcases hcases m with ⟨h, h'⟩ | ⟨h, h'⟩ | ⟨h, h'⟩ | ⟨h, h'⟩
    · exact ⟨0, by simp [cornerA, cornerB, h, h']; norm_num⟩
    · exact ⟨1, by simp [cornerA, cornerB, h, h']; norm_num⟩
    · exact ⟨0, by simp [cornerA, cornerB, h, h']; norm_num⟩
    · exact ⟨-1, by simp [cornerA, cornerB, h, h']; norm_num⟩
  · have := (h 0).1
    simp [cornerA, cornerB] at this
    norm_num at this

/-! ## 3. The headlines' hypotheses at `ℚ(√11)` -/

/-- `four_le_chromaticNumber_planeOver_of_inv_three_mem`'s two hypotheses hold together at `F = ℚ(√11)`. -/
theorem headline_hypotheses_eleven :
    (3 : ℂ)⁻¹ ∈ unitRing (fieldOfRadicands {11}) ∧
      ¬ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 2 :=
  ⟨inv_three_mem_unitRing_of_sqrt_mem (d := 11) (by norm_num) (sqrt_mem_fieldOfRadicands (Set.mem_singleton 11)),
    not_colorable_two_of_sqrt_mem (d := 11) (by norm_num) (sqrt_mem_fieldOfRadicands (Set.mem_singleton 11))⟩

/-- So `Θ₂(R_F)` is empty there: the right side of `colorable_two_iff_fieldBandSet_two_nonempty` fails at `ℚ(√11)`. -/
theorem fieldBandSet_two_empty_eleven : ¬ (fieldBandSet (fieldOfRadicands {11}) (band 2)).Nonempty := fun h =>
  headline_hypotheses_eleven.2 ((colorable_two_iff_fieldBandSet_two_nonempty _).mpr h)

/-! ## 4. `1/3 ∈ ℤ[U_F]` at `ℚ(√2)` -/

/-- `1/3 = 1 − v − v̄` with `v = (1 + 2√2 i)/3`, a unit vector of `ℚ(√2)²`. -/
theorem inv_three_mem_unitRing_sqrt_two : (3 : ℂ)⁻¹ ∈ unitRing (fieldOfRadicands {2}) := by
  have hs : Real.sqrt 2 ∈ fieldOfRadicands {2} := by
    simpa using sqrt_mem_fieldOfRadicands (D := {2}) (Set.mem_singleton 2)
  have hx : (1 / 3 : ℝ) ∈ fieldOfRadicands {2} := by
    simpa using SubfieldClass.ratCast_mem (fieldOfRadicands {2}) (1 / 3 : ℚ)
  have hy : (2 * Real.sqrt 2 / 3 : ℝ) ∈ fieldOfRadicands {2} :=
    div_mem (mul_mem (ofNat_mem _ 2) hs) (ofNat_mem _ 3)
  have hn : (1 / 3 : ℝ) ^ 2 + (2 * Real.sqrt 2 / 3) ^ 2 = 1 := by
    rw [div_pow, div_pow, mul_pow, Real.sq_sqrt (by norm_num)]
    norm_num
  have hv : (⟨1 / 3, 2 * Real.sqrt 2 / 3⟩ : ℂ) ∈ unitVectors (fieldOfRadicands {2}) :=
    ⟨⟨hx, hy⟩, by rw [Complex.norm_eq_sqrt_sq_add_sq, hn, Real.sqrt_one]⟩
  have hv' : (⟨1 / 3, -(2 * Real.sqrt 2 / 3)⟩ : ℂ) ∈ unitVectors (fieldOfRadicands {2}) :=
    ⟨⟨hx, neg_mem hy⟩, by
      rw [Complex.norm_eq_sqrt_sq_add_sq]
      show Real.sqrt ((1 / 3 : ℝ) ^ 2 + (-(2 * Real.sqrt 2 / 3)) ^ 2) = 1
      rw [neg_sq, hn, Real.sqrt_one]⟩
  have h : (3 : ℂ)⁻¹ = 1 - ⟨1 / 3, 2 * Real.sqrt 2 / 3⟩ - ⟨1 / 3, -(2 * Real.sqrt 2 / 3)⟩ := by
    apply Complex.ext <;> simp <;> norm_num
  rw [h]
  exact sub_mem (sub_mem (one_mem _) (unitVectors_subset_unitRing _ hv)) (unitVectors_subset_unitRing _ hv')

/-! ## 5. The upstream leaf as a hypothesis -/

/-- `colorable_two_of_inv_three_mem` with `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` at `F` as a
hypothesis: this module's own leaves are all it reads. -/
theorem colorable_two_of_upstream {F : Subfield ℝ}
    (hup : ((unitDistance ℂ).induce (planeOver F)).Colorable 3 → (fieldBandSet F (band 3)).Nonempty)
    (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 3) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  obtain ⟨τ, hτ, h6⟩ := exists_torsion_mem_fieldBandSet F (hup h)
  exact (colorable_two_iff_fieldBandSet_two_nonempty F).mpr ⟨τ, mem_fieldBandSet_two_of_inv_three_mem h3 hτ h6⟩

/-- Clause (a) at `d = 11` with the upstream leaf as a hypothesis. -/
theorem four_le_eleven_of_upstream
    (hup : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 3 →
      (fieldBandSet (fieldOfRadicands {11}) (band 3)).Nonempty) :
    4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber := by
  have h : ((4 : ℕ) : ℕ∞) ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber := by
    rw [SimpleGraph.le_chromaticNumber_iff_colorable]
    intro k hk
    by_contra hlt
    exact headline_hypotheses_eleven.2
      (colorable_two_of_upstream hup headline_hypotheses_eleven.1 (hk.mono (by omega)))
  exact_mod_cast h

end FS131IT1Models

set_option pp.fullNames true
#print axioms FS131IT1Models.layer_step_rotation
#print axioms FS131IT1Models.layer_step_rotation_not_corner
#print axioms FS131IT1Models.layer_step_corner
#print axioms FS131IT1Models.layer_step_corner_not_rotation
#print axioms FS131IT1Models.layer_dichotomy_zero
#print axioms FS131IT1Models.layer_dichotomy_corner
#print axioms FS131IT1Models.headline_hypotheses_eleven
#print axioms FS131IT1Models.fieldBandSet_two_empty_eleven
#print axioms FS131IT1Models.inv_three_mem_unitRing_sqrt_two
#print axioms FS131IT1Models.colorable_two_of_upstream
#print axioms FS131IT1Models.four_le_eleven_of_upstream
#print axioms HadwigerNelson.ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable
