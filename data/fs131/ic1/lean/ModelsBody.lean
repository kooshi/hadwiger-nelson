
/-! FS131-IC1 — a model of the hypotheses of each theorem of `Arith/ThreeColourCharacter` that takes one, as an
`example` reading the theorem at that model (so each is the theorem's conclusion at an object the kernel holds).
Never part of the library: appended to a copy of the module before the build (`data/fs131/ic1/models.sh`), and read
under `import Proofs.HadwigerNelson.Arith.ThreeColourCharacter` after it (`lean/Models.lean`, generated).

No model here for `fieldBandSet_three_nonempty_of_colorable`: its hypothesis is a three-colourable plane over a
subfield of `ℝ`, and no declaration of this branch exhibits one (the record's § Drafts names where one is). -/
namespace FS131IC1Models

open HadwigerNelson HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.ThreeColourCharacter

-- `exists_int_vector_of_forall_neg`: one functional (the coordinate), negative at the real vector `−1/2`, which is no
-- integer vector.
example : ∃ N : Fin 1 → ℤ, ∀ _k : Unit, (LinearMap.proj 0 : (Fin 1 → ℝ) →ₗ[ℝ] ℝ) (fun i => (N i : ℝ)) < 0 :=
  exists_int_vector_of_forall_neg (fun _ : Unit => (LinearMap.proj 0 : (Fin 1 → ℝ) →ₗ[ℝ] ℝ)) (c := fun _ => -1 / 2)
    fun _ => by norm_num [LinearMap.proj_apply]

-- `Winding.exists_box_point`: the winding of `ℤ` along `(1, 2)` (`ThreeColour.nonempty_winding_one_two`).
example : ∃ W : Winding ![(1 : ℤ), 2], ∃ x : Fin 2 → ℝ, (∀ j, x j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) ∧
    ∀ r : (relMap ![(1 : ℤ), 2]).ker, ∑ j, (((r : Fin 2 → ℤ) j : ℤ) : ℝ) * x j = ((W.toHom r : ℤ) : ℝ) :=
  nonempty_winding_one_two.elim fun W => ⟨W, W.exists_box_point⟩

-- `exists_character_of_box_point`: `ℤ` along `(1, 2)` with `x = (1/3, 2/3)` — on a relation `r₀ + 2 r₁ = 0` the
-- form `r₀/3 + 2r₁/3` is the integer `0`.
example : ∃ θ : ℤ →+ UnitAddCircle, ∀ j, θ (![(1 : ℤ), 2] j) = ((![(1 / 3 : ℝ), 2 / 3] j : ℝ) : UnitAddCircle) :=
  exists_character_of_box_point ![(1 : ℤ), 2] fun r => ⟨0, by
    have h : relMap ![(1 : ℤ), 2] (r : Fin 2 → ℤ) = 0 := r.2
    simp only [relMap, AddMonoidHom.coe_mk, ZeroHom.coe_mk, Fin.sum_univ_two, Matrix.cons_val_zero,
      Matrix.cons_val_one, smul_eq_mul] at h
    have h' : (((r : Fin 2 → ℤ) 0 : ℤ) : ℝ) * 1 + (((r : Fin 2 → ℤ) 1 : ℤ) : ℝ) * 2 = 0 := by exact_mod_cast h
    simp only [Fin.sum_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, Int.cast_zero]
    linarith⟩

-- `exists_character_of_properAlong`: `ThreeColour.properAlong_one_two`; the module's own
-- `exists_character_one_two` is the conclusion there.
example : ∃ θ : ℤ →+ UnitAddCircle, ∀ j, θ (![(1 : ℤ), 2] j) ∈ band 3 := exists_character_one_two

-- `bandSet_nonempty_of_finite`: `M = ℤ`, `U = {1}`, the closed band `band 2`, and on every finite subset of `U` the
-- character `half` (`CharacterColouring.half_mem_bandSet`).
example : (bandSet ({1} : Set ℤ) (band 2)).Nonempty :=
  bandSet_nonempty_of_finite _ (isClosed_band 2) fun _ hS => ⟨half, fun u hu => half_mem_bandSet u (hS hu)⟩

-- `bandSet_three_nonempty_of_proper`: `A = ℤ`, `U = {1, 2}`, `c x = x mod 3`.
example : (bandSet ({1, 2} : Set ℤ) (band 3)).Nonempty :=
  bandSet_three_nonempty_of_proper (c := fun x : ℤ => (x : ZMod 3)) fun a u hu => by
    rcases hu with rfl | rfl <;> simp [show (2 : ZMod 3) ≠ 0 by decide]

-- Drafts for the module's spec section (held for the coordinator: its comment promises four facts and the file
-- holds two examples): the band at 3 holds `2/3` and not `0`.
example : ((2 / 3 : ℝ) : UnitAddCircle) ∈ band 3 := ⟨2 / 3, ⟨by norm_num, by norm_num⟩, rfl⟩
example : (0 : UnitAddCircle) ∉ band 3 := by
  rintro ⟨x, ⟨h1, h2⟩, hx⟩
  obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff 1).mp hx
  rw [zsmul_eq_mul, mul_one] at hn
  rw [Nat.cast_ofNat] at h1 h2
  have h3 : (0 : ℝ) < n := by rw [hn]; linarith
  have h4 : (n : ℝ) < 1 := by rw [hn]; linarith
  have h5 : (0 : ℤ) < n := by exact_mod_cast h3
  have h6 : n < (1 : ℤ) := by exact_mod_cast h4
  omega

end FS131IC1Models
