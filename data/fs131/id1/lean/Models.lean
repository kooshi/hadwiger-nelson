import Proofs.HadwigerNelson.Arith.DyadicQuadratic
/-!
FS131-ID1 — every headline of `Arith/DyadicQuadratic` applied at a model the kernel holds, from the compiled module (run
after the build): `lake env lean data/fs131/id1/lean/Models.lean`. Never part of the library.

Each theorem below applies one statement of the module at explicit data, so it typechecks only if every hypothesis of
that statement is proved at the model; `#print axioms` then shows what the model rests on.  Both alternatives of each
shape lemma are met.  Nothing here is new mathematics: these are the witnesses a reader would ask for.
-/
open HadwigerNelson HadwigerNelson.SpectralChain HadwigerNelson.SquareClass HadwigerNelson.DyadicQuadratic SimpleGraph

namespace FS131ID1Models

/-- `1` is a unit vector of every plane: no statement about "every unit vector" is about an empty set. -/
theorem one_mem_unitVectors (F : Subfield ℝ) : (1 : ℂ) ∈ unitVectors F :=
  ⟨⟨by rw [Complex.one_re]; exact F.one_mem, by rw [Complex.one_im]; exact F.zero_mem⟩, norm_one⟩

/-- The hypothesis of `colorable_planeOver_of_addMonoidHom` is inhabited at `F = ℚ(√2)`, `G = ZMod 2` … -/
theorem hom_model_two : ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
    ∀ u ∈ unitVectors (fieldOfRadicands {2}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 :=
  exists_addMonoidHom_two_mod_four (by norm_num)

/-- … at `F = ℚ(√5)`, `G = ZMod 2` (the class `m ≡ 1 (mod 4)`; `5` is not a square) … -/
theorem hom_model_five : ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
    ∀ u ∈ unitVectors (fieldOfRadicands {5}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 :=
  exists_addMonoidHom_one_mod_four (by norm_num) (by
    rintro ⟨r, hr⟩
    have h3 : r < 3 := by nlinarith
    interval_cases r <;> omega)

/-- … and at `F = ℚ(√3)`, `G = ZMod 2 × ZMod 2`. -/
theorem hom_model_three : ∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2 × ZMod 2),
    ∀ u ∈ unitVectors (fieldOfRadicands {3}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0 :=
  exists_addMonoidHom_three_mod_eight (by norm_num)

/-- `colorable_planeOver_of_addMonoidHom` applied at the first of these models. -/
theorem colorable_model : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {2}))).Colorable
    (Nat.card (ZMod 2)) :=
  let ⟨_, ψ, h⟩ := hom_model_two
  colorable_planeOver_of_addMonoidHom ψ h

/-- `exists_rat_add_mul_sqrt_eq` at the generator `√7` of `ℚ(√7)`. -/
theorem coordinates_model : ∃ p q : ℚ, Real.sqrt (7 : ℕ) = p + q * Real.sqrt (7 : ℕ) :=
  exists_rat_add_mul_sqrt_eq (sqrt_mem_fieldOfRadicands rfl)

/-- `exists_int_solution_of_mem_unitVectors` at `m = 2` (not a square) and the unit vector `1`. -/
theorem int_solution_model : ∃ a b c d N : ℤ, N ≠ 0 ∧ ¬ (2 ∣ a ∧ 2 ∣ b ∧ 2 ∣ c ∧ 2 ∣ d ∧ 2 ∣ N) ∧
    a ^ 2 + c ^ 2 + ((2 : ℕ) : ℤ) * (b ^ 2 + d ^ 2) = N ^ 2 ∧ a * b + c * d = 0 ∧
    (N : ℂ) * 1 = (((a : ℝ) + (b : ℝ) * Real.sqrt (2 : ℕ) : ℝ) : ℂ) +
      (((c : ℝ) + (d : ℝ) * Real.sqrt (2 : ℕ) : ℝ) : ℂ) * Complex.I :=
  exists_int_solution_of_mem_unitVectors (m := 2) (by
    rintro ⟨r, hr⟩
    have h2 : r < 2 := by nlinarith
    interval_cases r <;> omega) (one_mem_unitVectors _)

/-- `dyadic_shape_one_mod_four`, `N` odd: `m = 5`, the vector `1` — `(a, b, c, d, N) = (1, 0, 0, 0, 1)`. -/
theorem shape_one_odd : (Odd (1 : ℤ) ∧ Odd ((1 : ℤ) + 0 + 0 + 0)) ∨
    ((1 : ℤ) % 4 = 2 ∧ (2 : ℤ) ∣ 1 - 0 ∧ (2 : ℤ) ∣ 0 - 0 ∧ Odd (((1 : ℤ) - 0 + 0 - 0) / 2)) :=
  dyadic_shape_one_mod_four (m := 5) (by norm_num) (by norm_num) (by norm_num) (by decide)

/-- `dyadic_shape_one_mod_four`, `N ≡ 2 (mod 4)`: `m = 17`, the vector `((1 + √17) + (1 − √17)·i)/6` —
`(1, 1, 1, −1, 6)`, `1 + 1 + 17·2 = 36`. -/
theorem shape_one_even : (Odd (6 : ℤ) ∧ Odd ((1 : ℤ) + 1 + 1 + -1)) ∨
    ((6 : ℤ) % 4 = 2 ∧ (2 : ℤ) ∣ 1 - 1 ∧ (2 : ℤ) ∣ 1 - -1 ∧ Odd (((1 : ℤ) - 1 + 1 - -1) / 2)) :=
  dyadic_shape_one_mod_four (m := 17) (by norm_num) (by norm_num) (by norm_num) (by decide)

/-- `dyadic_shape_two_mod_four`, `N` odd: `m = 2`, the vector `1`. -/
theorem shape_two_odd : (Odd (1 : ℤ) ∧ Odd ((1 : ℤ) + 0)) ∨
    ((1 : ℤ) % 4 = 2 ∧ (2 : ℤ) ∣ 1 ∧ (2 : ℤ) ∣ 0 ∧ Odd (0 : ℤ) ∧ Odd (0 : ℤ) ∧ Odd ((1 : ℤ) / 2 + 0 / 2 + 0)) :=
  dyadic_shape_two_mod_four (m := 2) (by norm_num) (by norm_num) (by norm_num) (by decide)

/-- `dyadic_shape_two_mod_four`, `N ≡ 2 (mod 4)`: `m = 2`, the vector `(√2 + i√2)/2` — `(0, 1, 0, 1, 2)`. -/
theorem shape_two_even : (Odd (2 : ℤ) ∧ Odd ((0 : ℤ) + 0)) ∨
    ((2 : ℤ) % 4 = 2 ∧ (2 : ℤ) ∣ 0 ∧ (2 : ℤ) ∣ 0 ∧ Odd (1 : ℤ) ∧ Odd (1 : ℤ) ∧ Odd ((0 : ℤ) / 2 + 0 / 2 + 1)) :=
  dyadic_shape_two_mod_four (m := 2) (by norm_num) (by norm_num) (by norm_num) (by decide)

/-- `dyadic_shape_three_mod_eight`, `N` odd: `m = 3`, the vector `1`. -/
theorem shape_three_odd : (Odd (1 : ℤ) ∧ Odd ((1 : ℤ) + 0 + 0 + 0)) ∨
    ((1 : ℤ) % 4 = 2 ∧ (2 : ℤ) ∣ 1 - 0 ∧ (2 : ℤ) ∣ 0 - 0 ∧ Odd ((0 : ℤ) + 0)) :=
  dyadic_shape_three_mod_eight (m := 3) (by norm_num) (by norm_num) (by norm_num) (by decide)

/-- `dyadic_shape_three_mod_eight`, `N ≡ 2 (mod 4)`: `m = 3`, the vector `(1 + i√3)/2` — `(1, 0, 0, 1, 2)`. -/
theorem shape_three_even : (Odd (2 : ℤ) ∧ Odd ((1 : ℤ) + 0 + 0 + 1)) ∨
    ((2 : ℤ) % 4 = 2 ∧ (2 : ℤ) ∣ 1 - 1 ∧ (2 : ℤ) ∣ 0 - 0 ∧ Odd ((0 : ℤ) + 1)) :=
  dyadic_shape_three_mod_eight (m := 3) (by norm_num) (by norm_num) (by norm_num) (by decide)

/-- `colorable_two_planeOver_sqrt` at `m = 1` (`ℚ`), `2`, `5`, `17`. -/
theorem two_model : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {1}))).Colorable 2 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {2}))).Colorable 2 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {5}))).Colorable 2 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {17}))).Colorable 2 :=
  ⟨colorable_two_planeOver_sqrt squarefree_one (by norm_num),
   colorable_two_planeOver_sqrt Nat.prime_two.squarefree (by norm_num),
   colorable_two_planeOver_sqrt (show Nat.Prime 5 by norm_num).squarefree (by norm_num),
   colorable_two_planeOver_sqrt (show Nat.Prime 17 by norm_num).squarefree (by norm_num)⟩

/-- `colorable_four_planeOver_sqrt` at `m = 3`, `11`, and at `35` (not squarefree-dependent: no such hypothesis). -/
theorem four_model : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3}))).Colorable 4 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).Colorable 4 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {35}))).Colorable 4 :=
  ⟨colorable_four_planeOver_sqrt (by norm_num), colorable_four_planeOver_sqrt (by norm_num),
   colorable_four_planeOver_sqrt (by norm_num)⟩

end FS131ID1Models

set_option pp.fullNames true
#print axioms FS131ID1Models.one_mem_unitVectors
#print axioms FS131ID1Models.hom_model_two
#print axioms FS131ID1Models.hom_model_five
#print axioms FS131ID1Models.hom_model_three
#print axioms FS131ID1Models.colorable_model
#print axioms FS131ID1Models.coordinates_model
#print axioms FS131ID1Models.int_solution_model
#print axioms FS131ID1Models.shape_one_odd
#print axioms FS131ID1Models.shape_one_even
#print axioms FS131ID1Models.shape_two_odd
#print axioms FS131ID1Models.shape_two_even
#print axioms FS131ID1Models.shape_three_odd
#print axioms FS131ID1Models.shape_three_even
#print axioms FS131ID1Models.two_model
#print axioms FS131ID1Models.four_model
